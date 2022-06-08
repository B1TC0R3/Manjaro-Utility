#!/bin/bash

# Path to ssh-key for git repo
ssh_key=$HOME/.ssh/git.ssh

# Git configuration
repository=$HOME/Desktop/config_repo
remote=origin
branch=main

# Backup-files
files=(
/home/thomas/.config/nvim/init.vim
/home/thomas/.config/ranger/rc.conf
/home/thomas/.config/picom/config
/home/thomas/.config/neofetch/config.conf
/home/thomas/.zshrc
/home/thomas/.p10k.zsh
/etc/xdg/awesome/rc.lua
/usr/share/awesome/themes/b1tc0r3/theme.lua
)

# Check if script is configured
[[ -z $ssh_key ]] && echo -e "\e[31mError:\e[ Ssh-key not configured!" && exit
[[ -z $repository ]] && echo -e "\e[31mError:\39m Repository not configured!" && exit
[[ -z $remote ]] && echo -e "\e[31mError:\39m Remote not defined!" && exit
[[ -z $branch ]] && echo -e "\e[Error:\39m Branch not defined!" && exit

echo "Copying files..."
for elem in ${files[@]}; do
	install -DC $elem $repository/$elem 1>/dev/null && echo -e "Backed up: \e[36m$elem\e[39m"
done
echo -e "\e[32mCopying finished!\e[39m"

echo "Checking for ssh-key..."
ssh -T git@github.com || eval "$(ssh-agent -s)" &>/dev/null && ssh-add $ssh_key
echo -e "\e[32mKey accepted!\e[39m"

git -C $repository add .
git -C $repository commit -m "Automated backup at: `date`"

echo "Uploading files to git..."
git -C $repository push $remote $branch && echo -e "\e[32mFiles uploaded!\e[39m"
