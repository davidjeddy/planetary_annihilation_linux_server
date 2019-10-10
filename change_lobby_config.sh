#!/bin/bash

echo "Insert after first block of vars
"
sed "
setInterval(function() {
if (server.beacon) {
console.log("<BACON>"+JSON.stringify(server.beacon)+"</BACON>");
}
}, 5000);" > ./.local/Uber\ Entertainment/Planetary\ Annihilation/stable/media/server-script/states/lobby.js
