@echo off
SET RAILO_CLI_VERSION=Railo CLI (w0.1.9-121115)
title %RAILO_CLI_VERSION%
rem Original shell wrapper (*nix) provided by @MarkDrew
rem First stage windows batch wrapper adapted by @Vagrant (Chris Bauer) - please report errors/fixes here

SET DEBUG=

if "%1" == "debug" (
	SET DEBUG=1
 	shift /1
)

SET CURRPATH=
SET PARAMS=
SET SAFEPATH=
SET SCRIPTPATH=
SET VERB=

if "%DEBUG%"=="1" echo Running %RAILO_CLI_VERSION% at %DATE% %TIME% on %COMPUTERNAME%

rem -{ SET UP VARS }-


goto path_check
:resume_path
goto pwd_set
:resume_pwd
goto params_set
:resume_params

rem -{ PROCESS COMMAND LINE ARGUMENTS }-

if "%DEBUG%"=="1"  echo DEBUG: Executing: %0
set VERB=%1
shift
if "%DEBUG%"=="1"   echo DEBUG: Verb: %VERB%
if "%DEBUG%"=="1"   echo DEBUG: Arguments: %*

if "%VERB%" == "" goto verb_none
if "%VERB%" == "register" goto verb_register 
if "%VERB%" == "run" goto verb_run 
if "%VERB%" == "start" goto verb_start 
if "%VERB%" == "stop" goto verb_stop
rem else interpret verb as plugin
goto verb_plugin
rem each of the above should push through to :finito or :eof once complete.
goto error_fallthrough


:error_fallthrough
echo The script is exiting through an invalid case. Please report this error! (~@Vagrant)
goto finito

:finito
echo Done!
goto eof

:params_set
if "%DEBUG%"=="1"   echo DEBUG: WARNING: PARAMS set here are passed into plugins as ~SV, or passed to the "run" function in sequence as individual query string variables.
for /f "usebackq tokens=* delims= " %%a in ('%2') do set PARAMS=%%~a
for /f "usebackq tokens=* delims= " %%a in ('%3') do set PARAMS=%PARAMS%~%%~a
for /f "usebackq tokens=* delims= " %%a in ('%4') do set PARAMS=%PARAMS%~%%~a
for /f "usebackq tokens=* delims= " %%a in ('%5') do set PARAMS=%PARAMS%~%%~a
for /f "usebackq tokens=* delims= " %%a in ('%6') do set PARAMS=%PARAMS%~%%~a
for /f "usebackq tokens=* delims= " %%a in ('%7') do set PARAMS=%PARAMS%~%%~a
for /f "usebackq tokens=* delims= " %%a in ('%8') do set PARAMS=%PARAMS%~%%~a
for /f "usebackq tokens=* delims= " %%a in ('%9') do set PARAMS=%PARAMS%~%%~a

goto resume_params

:path_check
if not "%~dp$PATH:0" == "" goto resume_path
if "%DEBUG%"=="1"   echo DEBUG: called batch file not found in Windows PATH
echo WARNING: no PATH set. run "railo-cli register" to add the appropriate path and access the CLI from anywhere on the system.
goto resume_path

:pwd_set
SET CURRPATH=%CD%
SET SCRIPTPATH=%~dp0
SET SAFEPATH=%CD%
if "%CURRPATH:~1,1%" == ":" set SAFEPATH="%CURRPATH:~0,1%%%3A%CURRPATH:~2%"
SET SAFEPATH=%SAFEPATH:\=/%
if "%DEBUG%"=="1"   echo DEBUG: Present Working Directory: %CURRPATH%
if "%DEBUG%"=="1"   echo DEBUG: Safe Working Directory: %SAFEPATH%
if "%DEBUG%"=="1"   echo DEBUG: Script Location: %SCRIPTPATH%
if "%DEBUG%"=="1"   echo DEBUG: Script Name: %~nx0
goto resume_pwd

:verb_none
	pushd %SCRIPTPATH%
	echo Running %RAILO_CLI_VERSION% at %DATE% %TIME% on %COMPUTERNAME%
	echo Syntax: railo.bat [debug] (run^|start^|stop^|{plugin_name}) [param1] [...] [param8]	
	if "%DEBUG%"=="1"   echo DEBUG: Executing: java -jar lib\ext\railo-cli.jar -webroot=./webroot/ -uri="/help.cfm"
	java -jar lib\ext\railo-cli.jar -webroot=./webroot/ -uri="/help.cfm"
	popd
goto finito

:verb_plugin
	pushd %SCRIPTPATH%
	set PLUGIN=%VERB%
	echo Calling plugin %PLUGIN%
	shift
	if "%DEBUG%"=="1"   echo DEBUG: Executing: java -jar lib/ext/railo-cli.jar -webroot=./webroot/ -uri="/runner.cfm?currentpath=%SAFEPATH%&params=%PLUGIN%~%PARAMS%"
	echo WARNING: query parameters passed in at the windows command line are currently evaluated inline by the command processor. Surround with quotes if they're not passing values in properly!
	echo ...
	java -jar lib/ext/railo-cli.jar -webroot=./webroot/ -uri="/runner.cfm?currentpath=%SAFEPATH%&params=%PLUGIN%~%PARAMS%"
	echo ...
	popd

goto finito

:verb_register
	echo Registering CLI in Windows PATH...

	if not "%~dp$PATH:0" == "" goto verb_register_abort

	set RAILOCLI_PATH="%SCRIPTPATH%"
	setx RAILOCLI_PATH "%SCRIPTPATH%" /M
	setx RAILOCLI_PATH %SCRIPTPATH%

	setx PATH "%PATH%;%%RAILOCLI_PATH%%" /M
	setx PATH "%PATH%;%%RAILOCLI_PATH%%"
	rem SETX does not work on all systems. SET will apply a session variable 
	set PATH=%PATH%;%SCRIPTPATH%
	echo Ok. Verify by opening a new command session.
	echo Note that on some systems the PATH cannot be modified directly - in this case, add %RAILOCLI_PATH% to the end of your user or machine PATH in environmental variables setting.
goto finito

:verb_register_abort
	echo The Railo CLI path was found in the Windows path. No variables were set - if necessary, remove them from the path and run the register command again.
goto finito

:verb_run
	pushd %SCRIPTPATH%
	set FILE=%1
	shift
	if "%DEBUG%"=="1"   echo DEBUG: Executing: java -jar lib\ext\railo-cli.jar -webroot="%CURRPATH%" -uri="%FILE%?%1&%2&%3&%4&%5&%6&%7&%8&%9"
	echo WARNING:query parameters passed in at the windows command line are currently evaluated inline by the command processor. Surround with quotes if they're not passing values in properly!
	echo ...
	java -jar lib\ext\railo-cli.jar -webroot="%CURRPATH%" -uri="%FILE%?%1&%2&%3&%4&%5&%6&%7&%8&%9"
	echo ...
	popd
goto finito

:verb_start
	pushd %SCRIPTPATH%
	if "%DEBUG%"=="1"   echo DEBUG: Executing: java -jar -DSTOP.PORT=8887 -DSTOP.KEY=railo -Xms256M  -Xmx512M lib/start.jar -Drailo.webroot="%CURRPATH%" --exec
	if "%DEBUG%"=="1"   echo DEBUG: Launching in new process - may not work correctly on older versions of Windows
	start /min java -jar -DSTOP.PORT=8887 -DSTOP.KEY=railo -Xms256M  -Xmx512M lib/start.jar -Drailo.webroot="%CURRPATH%" --exec
	popd
goto finito

:verb_stop
	pushd %SCRIPTPATH%
	if "%DEBUG%"=="1"   echo DEBUG: Executing: java -jar -DSTOP.PORT=8887 -DSTOP.KEY=railo lib/start.jar --stop
	java -jar -DSTOP.PORT=8887 -DSTOP.KEY=railo lib/start.jar --stop
	popd
goto finito

:eof





