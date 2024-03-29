#!/usr/bin/bash

SYNC_TIME=60
BINARY=obsidian

COL_DEFAULT="\033[0m"
COL_RED="\033[0;31m"
COL_GREEN="\033[0;32m"

CHECKMARK="\u2714"

OBSIDIAN_RUNNING="N/A"

VAULT_DIR=$1

function process_found_exit() 
{
    echo -e "${COL_RED}ERROR: Obsidian already running!   x${COL_DEFAULT}"
    echo "Exiting..."
    exit
}

function vault_not_found_exit() 
{
    echo -e "${COL_RED}ERROR: Failed to open target directory!   x${COL_DEFAULT}"
    echo "Exiting..."
    exit
}

function push() 
{
    git add . &> /dev/null
    git commit -m "Automated commit `date`" &> /dev/null
    git push origin main &> /dev/null

    clear
    if [ $? -eq 0 ]
    then
        echo -e "${COL_GREEN}Vault synchronized! Time: `date`   ${CHECKMARK}${COL_DEFAULT}"
    else
        echo -e "${COL_RED}Push failed! Time: `date`  X${COL_DEFAULT}" 
    fi
}

function sync_loop() 
{
    while true
    do
        sleep $SYNC_TIME
        push
    done
}

# Check if Obsidian is running
# Check is target directory is reachable
# Go to target directory
ps axu | grep obsidian | grep 131072 1> /dev/null && process_found_exit
cd $VAULT_DIR 1> /dev/null || vault_not_found_exit

# Start sync-loop
# Start obsidian
sync_loop &
$BINARY

# Kill sync_loop
# Synchronize latest state of the Vault
kill -9 $! 
wait $! &> /dev/null
echo -e "${COL_GREEN}Sync-loop stopped.   ${CHECKMARK}${COL_DEFAULT}"
push

exit