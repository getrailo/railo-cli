<cfscript>
	function filterListing(item){
		if(ListLast(item, "/") EQ ".DS_Store"){
			return false;
		}
		return true;
	}
	//We totally should have pm installed. It will be in there by default. 
	
	pm =  new modules.pm.cli.Main();

</cfscript>
RAILO COMMAND LINE PARAMETERS
=============================
 run
 start
 pm

 Installed Plugins
 -----------------
 <cfoutput>#pm.installed([false])#</cfoutput>

