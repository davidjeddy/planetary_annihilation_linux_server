#!/bin/bash

# vars

USERNAME=Pheagey
PASSWORD=~Asdf1234

# logic

sudo apt-get update -y
sudo apt-get install -y \
    byobu \
    golang \
    libgl1-mesa-glx \
    nodejs \
    unzip

if [ ! -f papatcher.go ]; then
    # wget https://bitbucket.org/papatcher/papatcher/raw/a7b8b4febb491d6fc6c45155b238fd42ee34fcc8/papatcher.go
    wget https://raw.githubusercontent.com/planetary-annihilation/papatcher/master/papatcher.go
fi

chmod +x papatcher.go

# go run papatcher.go -stream=”stable”
go run papatcher.go --stream=modern-pte --update-only ${USERNAME} ${PASSWORD}
