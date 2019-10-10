#!/bin/bash

# functions

# variable

# input

# logic

if [ ! -f ./NodePAMaster.zip]; then
    wget http://nanodesu.info/stuff/pa/mods/NodePAMaster.zip
    unzip NodePAMaster.zip
fi

go run papatcher.go

vi ./NodePAMaster/src/conf.json

# The first two lines of the file should be modified to use the correct path for your server and version.txt files.
# Change server to “./.local/Uber\ Entertainment/Planetary\ Annihilation/stable/server”
# Change serverversion to “./.local/Uber Entertainment/Planetary Annihilation/stable/version.txt”
# Change the serverip to your public facing IP
# Change the serverport to 20545
# Change shownregion to anything you like, but don’t use spaces

Now update the server parameters in serverparams.

change the name
add the following
"--max-players", "15", "--max-spectators", "5"
The final serverparams will look something like:

["--headless", "--game-mode", "Config", "--allow-lan","--server-name", "MyServerName", "--max-players", "15", "--max-spectators", "5"]
The server name will be changed as soon as someone joins but your region name will always remain.

If you’re running a TITANS server then change “Config” to “PAExpansion1:Config”.

byobu

nodejs ./NodePAMaster/src/control.js

Ensure only ports 22 (SSH) and 20545 (PA) are accessible to the world.
