#!/bin/bash

# Clean orphan packages
sudo pacman -Rsn $(pacman -Qdtq)

# Delete cache
rm -rf ~/.cache/


