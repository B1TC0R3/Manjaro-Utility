#!/bin/bash

title="
   ____                          _____                            _
  / __ \\                        / ____|                          | |
 | |  | |_   _  ___ _ __ _   _  | |  __  ___ _ __   ___ _ __ __ _| |_ ___  _ __
 | |  | | | | |/ _ \\ '__| | | | | | |_ |/ _ \\ '_ \\ / _ \\ '__/ _\` | __/ _ \\| '__|
 | |__| | |_| |  __/ |  | |_| | | |__| |  __/ | | |  __/ | | (_| | || (_) | |
  \\___\\_\\_____|\\___|_|   \\__, |  \\_____|\\___|_| |_|\\___|_|  \\__,_|\\__\\___/|_|
                          __/ |
                         |___/ "

alert_file="./alerts"
legal_chars="[a-zA-Z0-9, ]+"

function invalid_credentials() {
    echo -e "\x1b[31m\x1b[1m[ALERT]\x1b[5m !\x1b[0m Invalid credentials."
    echo -e "User: $(whoami)\nDate: `date`\nOperation: Unsuccessful login attempt.\nCredentials: $username:[REDACTED]\n" >> "$alert_file"
    exit 0
}

function validate_input() {
    echo -e "\x1b[36m\x1b[1m[STATUS]\x1b[0m: Generated Query: $1;"

    if grep -xvqE "[a-zA-Z0-9, ]+" <<< "$1" ; then
        echo -e "\x1b[31m\x1b[1m[ALERT]\x1b[5m !\x1b[0m Illegal query. Incident will be reported."
        echo -e "User: $(whoami)\nDate: `date`\nOperation: $1\n" >> "$alert_file"
        exit 0
    fi
}

function run_query() {
    echo -en "\x1b[1A\x1b[K\x1b[32m\x1b[1m[PROMPT]\x1b[0m: Enter Database: "
    read database
    echo -e "\x1b[1A\x1b[K\x1b[36m\x1b[1m[STATUS]\x1b[0m: Set 'database' to: '$database'."

    echo -en "\x1b[32m\x1b[1m[PROMPT]\x1b[0m: Enter Table: "
    read table
    echo -e "\x1b[1A\x1b[K\x1b[36m\x1b[1m[STATUS]\x1b[0m: Set 'table' to: '$table'."

    echo -en "\x1b[32m\x1b[1m[PROMPT]\x1b[0m: Enter Columns (Format: '<column>,<column>'): "
    read columns
    echo -e "\x1b[1A\x1b[K\x1b[36m\x1b[1m[STATUS]\x1b[0m: Selected columns: '$columns'."

    query="SELECT $columns FROM $table"
    validate_input "$query"

    echo "$query;" > .query.sql
    query_result=$(mariadb --user=$username --password=$password --database=$database -h localhost < .query.sql)
    rm .query.sql

    less <<< "$query_result"
}

echo -e "\x1b[32m\x1b[1m$title\x1b[0m\n"

echo -en "\x1b[31m\x1b[1m[AUTHENTICATION]\x1b[0m: User: "
read username

echo -en "\x1b[31m\x1b[1m[AUTHENTICATION]\x1b[0m: Password: "
read -s password
echo ""

mariadb --user=$username --password=$password < /dev/null 2>/dev/null || invalid_credentials $username

while [[ "$input" != "n" ]]
do
    run_query

    echo -en "\x1b[32m\x1b[1m[PROMPT]\x1b[0m: Enter another query? (Y/n) "
    read input
done
