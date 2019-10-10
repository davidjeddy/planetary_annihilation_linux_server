#!/bin/bash

# functions

UBER_USERNAME=""
UBER_PASSWORD=""

# variable

# input

UBER_USERNAME=""
UBER_PASSWORD=""


# logic

sudo apt-get update -y
sudo apt-get install -y \
byobu \
golang \
libgl1-mesa-glx \
nodejs \
unzip

wget https://bitbucket.org/papatcher/papatcher/raw/a7b8b4febb491d6fc6c45155b238fd42ee34fcc8/papatcher.go
chmod +x papatcher.go
go run papatcher.go -stream=”stable”

echo "Enter credentials..."

