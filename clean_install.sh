#!/bin/bash

echo -e "Installing '\e[32m$1\e[0m' with pacman..."
sudo pacman -S $1 && yes | sudo yay -Sc && exit

echo "Failed to install '$1' with pacman"
echo -n "Install with yay? [y/N] "
read install_with_yay

if [ "$install_with_yay" = "y" ]; then
    echo -e "Installing '\e[32m$1\e[0m' with yay..."
    yay -S $1 && yes | yay -Sc && exit
fi
