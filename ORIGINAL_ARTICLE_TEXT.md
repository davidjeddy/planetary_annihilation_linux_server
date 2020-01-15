# Original Article Text

CUSTOM SERVER SETUP
Date: 20th October, 2014Updated: 19th September, 2016Category: Server, Step-by-step
Quitch
QUITCH
Queller AI
   
User streaming now!
Before starting on this guide to setting up your own Planetary Annihilation dedicated server I’d like to give massive thanks to Cola_Colin whose post on how to setup a dedicated server was the basis for this guide.

PREREQUISITES
Ubuntu 14.04 LTS Trusty Tahr LogoThis guide is written for Ubuntu, specifically version 14.04 LTS, and is based on the cloud image provided by Ubuntu. I do not guarantee that certain commands or other elements will work on other distributions or software baselines. Knowledge of Linux will be helpful, but should not be essential to make it through this guide. I make no apologies though for the fact that this is a technical guide and may be too difficult for some.

This guide will not cover the specifics of setting up a virtual machine on a cloud service provider such as AWS or Azure.

Where text is in italics you should copy it and then right-click in your PuTTY window to paste it.

SERVER SPECIFICATION
The first thing you’re going to need is a server. Based on testing performed by the community you will want something with:

8+ CPU cores
Strong single threaded performance
32GB RAM
30Mb+ outgoing bandwidth

The number of cores, amount of RAM and outgoing bandwidth will vary depending on the number of players and planets, the specification above is written on the assumption you will put more than ten players on your server.

If you’re looking into cloud server providers, know that AWS uses more powerful processors than Azure. You could also go with a bare metal option such as those offered by SoftLayer.

CONNECTING TO YOUR DEDICATED SERVER
So you’ve got your dedicated server set up and running Ubuntu. Now to connect. To do this you’ll need to SSH access to the box.

On Windows I recommend PuTTY.

PuTTY session

Simply enter the host name or IP address of your server and click Open to connect. You should then be prompted for your authentication credentials. For really robust security I strongly recommend using a certificate rather than a password, but that’s a more complex topic and outside the scope of this guide.

SETTING UP YOUR DEDICATED SERVER
If you want to run a server using the PTE build rather than stable, please see the PTE server section at the end of this guide.

INSTALLING PLANETARY ANNIHILATION
First we need to download the files required to run a Go executable.

sudo apt-get update
sudo apt-get install golang
Next we get the Planetary Annihilation patcher.

wget https://bitbucket.org/papatcher/papatcher/raw/a7b8b4febb491d6fc6c45155b238fd42ee34fcc8/papatcher.go

Then we update the permissions on the file and run it.

chmod +x papatcher.go
go run papatcher.go -stream=”stable”
enter your Uber login credentials
ignore any warnings about a missing video card
Next we need to install an OpenGL library.

sudo apt-get install libgl1-mesa-glx
CONFIGURING PLANETARY ANNIHILATION
Install nano for easy editing of files (may already be installed on some distributions).

apt-get install nano
Let’s ensure the lobby reports to PA Stats

nano ./.local/Uber\ Entertainment/Planetary\ Annihilation/stable/media/server-script/states/lobby.js
After the first block of vars you should insert the text below.

setInterval(function() {
if (server.beacon) {
console.log("<BACON>"+JSON.stringify(server.beacon)+"</BACON>");
}
}, 5000);
LAUNCH SCRIPT
Now it’s time to setup a script to launch the server.

wget http://nanodesu.info/stuff/pa/mods/NodePAMaster.zip
sudo apt-get install unzip
unzip NodePAMaster.zip
sudo apt-get install nodejs
nano ./NodePAMaster/src/conf.json
The first two lines of the file should be modified to use the correct path for your server and version.txt files.

Change server to “./.local/Uber\ Entertainment/Planetary\ Annihilation/stable/server”
Change serverversion to “./.local/Uber Entertainment/Planetary Annihilation/stable/version.txt”
Now update the server IP address and port.

Change the serverip to your public facing IP
Change the serverport to 20545
Change shownregion to anything you like, but don’t use spaces
Now update the server parameters in serverparams.

change the name
add the following
"--max-players", "15", "--max-spectators", "5"
The final serverparams will look something like:

["--headless", "--game-mode", "Config", "--allow-lan","--server-name", "MyServerName", "--max-players", "15", "--max-spectators", "5"]
The server name will be changed as soon as someone joins but your region name will always remain.

If you’re running a TITANS server then change “Config” to “PAExpansion1:Config”.

STARTING THE SERVER
Finally, let’s start the server so it can be joined by the outside world!

byobu
nodejs ./NodePAMaster/src/control.js
Press F6 to exit byobu but leave the server running
The server will continue to run even if you exit your SSH session. If you enter byobu again you will see your server running and if you wish to terminate it you can do so using CTRL^C.

Congratulations, you have yourself a working server!

-----

Dedicated server listed in the lobby

I recommend you install a firewall that allows incoming connections to the following ports only:

SSH: TCP 22
PA: TCP 20545
HOSTING / JOINING
No mods are required to host, join or spectate servers.

If you cannot see your server in the lobby make sure you’ve setup proper port forwarding with your cloud provider. For example, with Azure you will need to configure an endpoint to pass traffic from public port 20545 to private port 20545.

We recommend that you take a snapshot of your image once it has been successfully tested to allow you to get yourself up and running faster in the future. How you go about this will vary depending upon provider.

RESTORING YOUR DEDICATED SERVER
Once you spin up another virtual machine from a snapshot you took it’s easy to get yourself up and running again.

UPDATE PLANETARY ANNIHILATION
If there have been any patches since the last time you updated this image you will need to patch your server.

go run papatcher.go
Updates mean you will also need to restore your changes to lobby.js (and version.txt for PTE builds).

nano ./.local/Uber\ Entertainment/Planetary\ Annihilation/stable/media/server-script/states/lobby.js
UPDATE THE SERVER
You may wish to update your server packages from time to time to ensure you have the latest security patches and bug fixes.

sudo apt-get update
UPDATE THE IP ADDRESS
Unless you’ve been assigned a fixed IP address you will most likely need to update the public facing IP address in your configuration file.

nano ./NodePAMaster/src/conf.json
LAUNCH THE SERVER
byobu
nodejs ./NodePAMaster/src/control.js
PTE SERVER
If you want to run a server using the latest PTE rather than stable branch then you’ll need to change all references in commands and file paths from stable to PTE. i.e.

go run papatcher.go -stream=”stable” becomes go run papatcher.go -stream=”PTE”
conf.json “./.local/Uber\ Entertainment/Planetary\ Annihilation/stable/server” becomes “./.local/Uber\ Entertainment/Planetary\ Annihilation/PTE/server”
conf.json “./.local/Uber\ Entertainment/Planetary\ Annihilation/stable/version.txt” becomes “./.local/Uber\ Entertainment/Planetary\ Annihilation/PTE/version.txt”
If you want stable clients to connect to your PTE server then you’ll also need to create a version.txt containing the number of the latest stable build number and change conf.json to use that version number:

nano “./.local/Uber Entertainment/Planetary Annihilation/PTE/version.txt”
Enter 94684 and save the file
While 94684 is correct at the time of writing, this will change in the future.

CONCLUSION
And that’s it! Getting your own server running can look intimidating but it’s actually relatively simple. We recommend that you check out Cola_Colin’s data on server performance to assist you in making the right choice regarding provider and server.

Leave any questions in the comments section below and we will do what I can to assist, or pop across to the Dedicated Servers thread.

ADDITIONAL INFORMATION
Planetary Annihilation Version
94684