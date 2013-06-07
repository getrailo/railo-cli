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
	
		function cliFormat(any object, boolean queryShowColumns = false){
		var returnString = "";

		if(isQuery(object)){
			
			var aColLengths = {};
			
			loop query="arguments.object" {
				loop list=arguments.object.columnlist index="local.c" {

					if(!StructKeyExists(aColLengths, local.c)){
						aColLengths[local.c] = 1;
					}
					var colSize = Len(arguments.object[local.c]); 
					if(colSize GT aColLengths[local.c]){
 						aColLengths[local.c] = colSize;
					}		
				}
			}	

			//Add the colums if we must
			if(arguments.queryShowColumns){
				loop list=arguments.object.columnlist index="local.c" {
					returnString &= "| " & local.c;

					//Now add the spaces
					if(aColLengths[local.c] GT Len(local.c)){
						loop from="1" to="#aColLengths[local.c] - Len(local.c)+1#" index="local.s"{
							returnString &= " ";							
						}
					}
							
				}
				returnString &= "|" & chr(10);

				//Add a == underneath
				loop list=arguments.object.columnlist index="local.c" {
					returnString &= "--";

					//Now add the spaces
					
					loop from="1" to="#aColLengths[local.c]+1#" index="local.s"{
							returnString &= "-";							
					}
				}
				returnString &= "-" & chr(10);
			}

			//Add the rows now
			loop query="arguments.object" {

				loop list=arguments.object.columnlist index="local.c" {
					returnString &= "| " & arguments.object[local.c];

					if(aColLengths[local.c] GT Len(local.c)){
						loop from="1" to="#aColLengths[local.c] - Len(arguments.object[local.c])+1#" index="local.s"{
							returnString &= " ";							
						}
					}
				}


				returnString &= "|" & chr(10);
			}

			return returnString;

			//return formatForOutput(aColLengths);	
		}

		return SerializeJSON(object);
		
	}
}