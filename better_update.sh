#!/bin/bash


function print_green () {
    echo -e "\x1b[32m\x1b[1m$1\x1b[0m"
}

print_green "Updating pacman packages..."
sudo pacman -Syu

print_green "Updating yay packages..."
yay -Syu

print_green "Clearing yay cache..."
yes | yay -Sc && print_green "Cache cleared (yay)!"

print_green "Update complete!"


