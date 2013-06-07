component{
	variables.targetpath = "";
	
	function init(targetpath){
		variables.targetpath = targetpath;
		return this;
	}
	
	function onMissingMethod(method){
	
		return "Method #method# has not been implemented #Chr(10)#";
	}	

	function out(message){
		WriteOutput(message & Chr(10));
	}

	function println(message){
		out(message);
	}

	function help(param){
		

		//See if we are looking for some help
		if(Arraylen(param)){
			//WE are looking for help, do we have it?
			if(StructKeyExists(variables.help, param[1])){
				return variables.help[param[1]];
			}
			else {
				return "No help found for entry #param[1]#";
			}
		
			
		}

		if(StructKeyExists(variables.help, "default")){
				return variables.help["default"];
		}
		return "";
	}
}