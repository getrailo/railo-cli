<cfsetting enablecfoutputonly="true">
<cfparam name="error.message" default="">
<cfparam name="error.type" default="">
<cfparam name="error.detail" default="">
<cfparam name="tc.codeprinthtml" default="">
<cfoutput>
Railo #server.railo.version# Error (#error.type#)
MESSAGE: #replace( HTMLEditFormat( trim( error.message ) ), chr(10), '<br>', 'all' )#</cfoutput>
<cfif len( error.detail )>
<cfoutput>DETAIL: #replace( HTMLEditFormat( trim( error.detail ) ), chr(10), '<br>', 'all' )#</cfoutput>
</cfif>
<cfif structkeyexists( error, 'errorcode' ) && len( error.errorcode ) && error.errorcode NEQ 0>
<cfoutput>Error Code:	#error.errorcode#</cfoutput>
</cfif>
<cfif structKeyExists( error, 'extendedinfo' ) && len( error.extendedinfo )>
<cfoutput>Extended Info: #HTMLEditFormat( error.extendedinfo )#</cfoutput>
</cfif>
<cfif structKeyExists( error, 'additional' )>
<cfloop collection="#error.additional#" item="key">
<cfoutput>	#key#:#replace( HTMLEditFormat( error.additional[key] ), chr(10),'<br>', 'all' )#</cfoutput>
</cfloop>
</cfif>

<cfif structKeyExists( error, 'tagcontext' )>
<cfset len=arrayLen( error.tagcontext )>
<cfif len>
<cfoutput>STACKTRACE 
The Error Occurred in:</cfoutput>
	<cfloop index="idx" from="1" to="#len#">
		<cfset tc = error.tagcontext[ idx ]>
		<cfif len( tc.codeprinthtml )>
			<cfset isFirst = ( idx == 1 )>
<cfoutput>#isFirst ? "#tc.template#: line #tc.line#" : " called from #tc.template#: line #tc.line#"#
<!--- #tc.codeprinthtml# ---></cfoutput>
		</cfif>
	</cfloop>
</cfif>
</cfif>	
<cfoutput>Java Stacktrace
#error.stacktrace#</cfoutput>
Timestamp: <cfset timestamp = now()> #LsDateFormat( timestamp, 'short' )# #LsTimeFormat( timestamp, 'long' )#
<cfsetting enablecfoutputonly="false">
