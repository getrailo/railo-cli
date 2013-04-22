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

