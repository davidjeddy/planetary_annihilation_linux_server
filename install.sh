#!/bin/bash

# vars

# logic

echo -n "Update and Install system deps..."
apt-get update -y
apt-get install -y \
    byobu \
    golang \
    libcurl4-gnutls-dev \
    libgl1-mesa-glx \
    libsdl2-2.0-0 \
    libsdl2-image-2.0-0 \
    libsdl2-mixer-2.0-0 \
    nodejs \
    vim \
    wget \
    unzip

if [ ! -f papatcher.go ]; then
    echo -n "Downloading PA patcher..."
    # wget https://bitbucket.org/papatcher/papatcher/raw/a7b8b4febb491d6fc6c45155b238fd42ee34fcc8/papatcher.go
    wget https://raw.githubusercontent.com/planetary-annihilation/papatcher/master/papatcher.go
    chmod +x papatcher.go
    echo -n "Running PA patcher..."
    go run papatcher.go -stream=stable
fi

if [ ! -f ./NodePAMaster.zip]; then
    echo -n "Downloading Node server..."
    wget http://nanodesu.info/stuff/pa/mods/NodePAMaster.zip -O NodePAMaster.zip
    unzip NodePAMaster.zip
fi

echo -n "Copying configurations..."
echo -n "- lobby.js..."
cp /root/.local/Uber\ Entertainment/Planetary\ Annihilation/stable/media/server-script/states/lobby.js /root/.local/Uber\ Entertainment/Planetary\ Annihilation/stable/media/server-script/states/lobby.js.bckp
cp ./confs/lobby.js /root/.local/Uber\ Entertainment/Planetary\ Annihilation/stable/media/server-script/states/lobby.js
echo -n "- conf.json..."
cp ./NodePAMaster/src/conf.json ./NodePAMaster/src/conf.json.bckp
cp ./confs/conf.json ./NodePAMaster/src/conf.json 

echo 'Starting PA server...'
nodejs ./NodePAMaster/src/control.js
