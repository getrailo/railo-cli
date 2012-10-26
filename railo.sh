#!/usr/bin/env bash
CURRPATH=$(pwd)
#java -jar ${railoCLIPATH} -webroot=${webroot} -uri=/runner.cfm
PARAMS=""
#Check the first param... 
##If param $1 has no length, list commands and list cli-extensions

##If param $1 is run

##If param $1 is start

for var in "$@"
do
    PARAMS=${PARAMS}~"$var"
done
cd $(dirname $0)
if [ -n "$1" ]
then

	if [ "$1" == "run" ]/Applications/Railo-4-CLI/
	then
		echo "WE are going to run a file, so we just do the file"
		## java -jar ./lib/ext/railo-cli.jar -webroot=./webroot/ -uri='/runner.cfm?currentpath='${CURRPATH}'&params='$PARAMS
		
	fi
	
	if [ "$1" == "start" ]
	then
		echo "WE are going to run a file, so we just do the file"
		java -DSTOP.PORT=8887 -DSTOP.KEY=railo -jar -Xms256M  -Xmx512M lib/start.jar -Drespath=$CURRPATH		
	fi
fi
#java -jar ./lib/ext/railo-cli.jar -webroot=./webroot/ -uri='/runner.cfm?currentpath='${CURRPATH}'&params='$PARAMS
