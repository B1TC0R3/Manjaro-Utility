#!/bin/bash

APP=$1

echo -e "\x1b[1m\x1b[32mPacman packages:\x1b[0m"
pacman -Ss $APP

echo -e "\x1b[1m\x1b[32mYay packages:\x1b[0m"
yay -Ss $APP
