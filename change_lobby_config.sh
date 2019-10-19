#!/bin/bash

ln -sfn ./.local/Uber\ Entertainment/Planetary\ Annihilation/stable/media/server-script/states/lobby.js ./lobby.js


echo "Insert after first block of vars"

NEWLINE="
setInterval(function() {
  if (server.beacon) {
    console.log(\"<BACON>\"+JSON.stringify(server.beacon)+\"</BACON>\");
  }
}, 5000);"

sed -i '/# Insert New DNS/,/^$/s/^$/'"$NEWLINE"'/' ~/.local/Uber\ Entertainment/Planetary\ Annihilation/stable/media/server-script/states/lobby.js
