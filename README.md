# Manjaro-Utility
This repository contains shell-scripts and other usefull tools i created to help me with my daily life.

- [Bash](#bash)
  - [obsidian-synced](#obsidian-synced)  
  - [virtualcam](#virtualcam)

## Bash

### obsidian-synced
This is a tool that automatically synchronizes my obsidian vaults with a private git repository.
Note, that the tool requires a ssh connection to git in order to function without forcing the user to enter 
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
./virtualcam.sh -h              # print help
```


