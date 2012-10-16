#!/usr/bin/env bash
CURRPATH=$(pwd)
#java -jar ${railoCLIPATH} -webroot=${webroot} -uri=/runner.cfm
PARAMS=""
#Check the first param... 
echo $0
echo $1

##If param $1 has no length, list commands and list cli-extensions

##If param $1 is run

##If param $1 is start

for var in "$@"
do
    PARAMS=${PARAMS}~"$var"
done
cd $(dirname $0)
#java -jar ./lib/ext/railo-cli.jar -webroot=./webroot/ -uri='/runner.cfm?currentpath='${CURRPATH}'&params='$PARAMS
