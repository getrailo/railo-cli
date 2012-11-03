<cfscript>
	function filterListing(item){
		if(ListLast(item, "/") EQ ".DS_Store"){
			return false;
		}
		return true;
	}
	
</cfscript>
RAILO COMMAND LINE PARAMETERS
=============================
  run
  start

  Installed Plugins
  -----------------
  <cfloop array="#DirectoryList("plugins/", false, "name", filterListing)#" item="a"><cfoutput>#a#</cfoutput>
  </cfloop>

