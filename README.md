# Manjaro-Utility
This repository contains shell-scripts and other usefull tools i created to help me with my daily life.

## Description

### obsidian-synced
This is a tool that automatically synchronizes my obsidian vaults with a private git repository.
Note, that the tool requires a ssh connection to git in order to function without forcing the user to enter 
a password every minute.

**Usage**
```bash
./obsidian-synced <target-directory>
```
*\<target-directory\>* has to be a git-repository in order for the script to successfully push any changes. 

