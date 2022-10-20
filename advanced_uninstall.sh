#!/bin/bash

APP=$1

function get_similar () {
    echo -e "Package '\x1b[32m$APP\x1b[0m' not found!\nSimilar packages:"
    pacman -Q | grep $APP
    exit
}

echo -e "Uninstalling '\x1b[32m$APP\x1b[0m'..."
sudo pacman -Rcns $APP || get_similar
yes | sudo pacman -Sc
