#!/bin/bash

function print_green () {
    echo -e "\x1b[32m\x1b[1m$1\x1b[0m"
}

print_green "Updating..."
yay -Syu

print_green "Clearing cache..."
yes | yay -Sc && print_green "Cache cleared!"

print_green "Update complete!"


