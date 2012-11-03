<cfsetting enablecfoutputonly="true">
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
		println("You need to call an extension. Available Extensions are:");
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

	
	
	if(!DirectoryExists(expandPath("/plugins/#cfc#"))){
		println("Extension #cfc# doesn't exist. The currently installed extensions are:");
		extensionList();
		
		exit;
	}
	
	runnerCFC = CreateObject("component", "plugins.#cfc#.Main");

	if(structKeyExists(runnerCFC, "init")){
		runnerCFC.init(url.currentpath);
	}

	ret = runnerCFC[method](args);
	if(isDefined("ret")){
		WriteOutput(ret);	
	}
	
	
	function extensionList(){
		varDirs = DirectoryList(expandPath("/plugins/"), false, "name");
		for(dir in varDirs){
			if(DirectoryExists(expandPath("/plugins/#dir#"))){
				println(dir);				
			}
		}
	}

	function println(message){
		WriteOutput(message & chr(10));
	}
</cfscript>
