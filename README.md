# Manjaro-Utility
This repository contains shell-scripts and other usefull tools i created to help me with my daily life.
It also holds some smaller pratice programs.

## Bash

### obsidian-synced
This is a tool that automatically synchronizes my obsidian vaults with a private git repository.
Note that the tool requires a ssh connection to git in order to function without forcing the user to enter
a password every minute.

**Usage**
```bash
./obsidian-synced <target-directory>
```
*\<target-directory\>* has to be a git-repository in order for the script to successfully push any changes.

### virtualcam
This is a script to create a virtual camera with v4l2loopback.
The camera will play back any video.
The video format should be **mp4**.
*Requires v4l2loopback and ffmpeg to be installed.*

**Usage**
```bash
./virtualcam.sh -f <path to video> # start the application
./virtualcam.sh -h                 # print help
```

### clean_install
A small `pacman` and `yay` wrapper that clears the cache after a successfull install.
It tries to install the wanted package with pacman first. Should this fail, it will prompt for a `yay` install.

**Usage**
```bash
./clean_install <package-name>
```

### better_uninstall
A script to uninstall packages which will suggest packages with similar names if you dont fully remember the name of the package you want to uninstall.

**Usage**
```bash
./better_uninstall <package-name>
```

### better_search
This script searches packages using both `pacman` and `yay`.
```bash
./better_search <package-name>
```
