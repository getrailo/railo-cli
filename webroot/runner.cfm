<cfsetting enablecfoutputonly="true">
<cferror template="error.cfm" type="exception">
<cfscript>
	param name="url.currentpath" default=expandPath(".");
	param name="url.params" default="";	
	for(u in URL){
//		WriteOutput(u & ": " & URL[u] & Chr(10));
	}
	
	params = ListCompact(url.params, "~");
	aParams = ListToArray(params, "~");

	cfc = isDefined("aParams[1]") ? aParams[1] : "";
	method = isDefined("aParams[2]") ? aParams[2] : "help";

	if(!ArrayLen(aParams)){
		println("You need to call a module. Available modules are:");
		extensionList();
		exit;
	}
	

	if(isDefined("aParams[1]") && isDefined("aParams[2]")){
		ArrayDeleteAt(aParams,1);	
		ArrayDeleteAt(aParams,1);
	}
	elseif(isDefined("aParams[1]") && !isDefined("aParams[2]")){
		ArrayDeleteAt(aParams,1);	
	}
	
	
	
	args = aParams;

	if(!Len(cfc)){
		WriteOutput("You need to define a cfc to run");
		exit;
	}

	
	
	if(!DirectoryExists(expandPath("/modules/#cfc#"))){
		println("Module #cfc# doesn't exist. The currently installed modules are:");
		extensionList();
		
		exit;
	}
	
	runnerCFC = CreateObject("component", "modules.#cfc#.cli.Main");

	if(structKeyExists(runnerCFC, "init")){
		runnerCFC.init(url.currentpath);
	}

	ret = runnerCFC[method](args);
	if(isDefined("ret")){
		WriteOutput(ret);	
	}
	
	
	function extensionList(){
		
		//This should get the package manager and use that. 
		
		varDirs = DirectoryList(expandPath("/modules/"), false, "name");
		for(dir in varDirs){
			if(DirectoryExists(expandPath("/modules/#dir#")) && FileExists(expandPath("/modules/#dir#/config.xml"))){
				//Now read the config.xml
				var config = XMLParse(FileRead(expandPath("/modules/#dir#/config.xml")));
				println("#config.config.info.name.XMLText# - #config.config.info.label.XMLText# (v. #config.config.info.version.XMLText#) ");				
			}
		}
	}

	function println(message){
		WriteOutput(message & chr(10));
	}
</cfscript>
