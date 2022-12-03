#!/bin/bash

function get_similar () {
    echo -e "Package '\x1b[32m$1\x1b[0m' not found!\nSimilar packages:"
    pacman -Q | grep $APP
    exit
}

echo -e "Uninstalling '\x1b[32m$1\x1b[0m'..."
sudo pacman -Rcns $1 || get_similar
yes | sudo pacman -Sc
