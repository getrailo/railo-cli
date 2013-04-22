railo-cli
=========

These are the cli scripts for Railo. They are the scripts to start and call railo from the command line.


Installation
============
Basically this project should be extracted OVER a Railo Express version. The reason for this is that we don't want to include ALL the Railo JAR's and configs as well as the configuration for Jetty itself. 

 1. Download Railo Express from (http://www.getrailo.org/index.cfm/download/) and unzip somewhere (let's say /Applications/railo-cli for argument's sake)
 1. Download the zip of this project and unzip it somewhere
 1. Now you want to move all the railo.* scripts from the root of this project to /Applications/railo-cli 
 1. Now move and overwrite the /Applications/railo-cli/contexts/railo.xml with the one in this project
 1. Finally we have some helper scripts in the webroot which you can put into your Railo webroot folder. 

All done? Not yet, final part
## Set the path ##
In OS X and Linux based systems you now need to add the path to /Applications/railo-cli/ to your environment so do this as follows

### OS X ###
 Edit ~/.bash_profile and add the following:

 export RAILOCLI=/Applications/railo-cli/ 
 export PATH=$RAILOCLI:$PATH

then you can run the following script to make sure the changes are picked up:
 source ~/.bash_profile


### Windows ###
TODO


You should now be able to go to any folder and run the "railo" command. 

How can I run it?
=================

There are a few ways to run railo in the command line:

 1. #railo run myfile.cfm# : This would allow Railo to run the file you have chosen in the command line. No server will startup and all output will be displayed in the terminal. You can pass parameters to the file as if you were doing a url, for example: #railo run myfile.cfm?test=1#
 1. #railo start# : this will allow you start an instance of Railo as a webserver using the current path as the webroot. It will create a WEB-INF folder in the current path and you will be able to access it via http://localhost:8888
 1. #railo pluginname pluginaction# : This allows you to run the commands in a Railo CLI plugin. An example would be the as yet to be written Framework One plugin: #railo fw1 createApplication myApplication# which would create a skeleton FW1 application in the current folder, called myApplication.


A word about CLI Plugins
========================
We are currently implementing the cli plugins and you can see the start of a plugin manager over at https://github.com/cybersonic/org.getrailo.cli.pm


