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
    echo -e "\e[31m\e[1m[ALERT]\e[5m !\e[0m Invalid credentials."
    echo -e "User: $(whoami)\nDate: `date`\nOperation: Unsuccessful login attempt.\nCredentials: $username:[REDACTED]\n" >> "$alert_file"
    exit 0
}

function validate_input() {
    echo -e "\e[36m\e[1m[STATUS]\e[0m: Generated Query: $1;"

    if grep -xvqE "[a-zA-Z0-9, ]+" <<< "$1" ; then
        echo -e "\e[31m\e[1m[ALERT]\e[5m !\e[0m Illegal query. Incident will be reported."
        echo -e "User: $(whoami)\nDate: `date`\nOperation: $1\n" >> "$alert_file"
        exit 0
    fi
}

function run_query() {
    echo -en "\e[1A\e[K\e[32m\e[1m[PROMPT]\e[0m: Enter Database: "
    read database
    echo -e "\e[1A\e[K\e[36m\e[1m[STATUS]\e[0m: Set 'database' to: '$database'."

    echo -en "\e[32m\e[1m[PROMPT]\e[0m: Enter Table: "
    read table
    echo -e "\e[1A\e[K\e[36m\e[1m[STATUS]\e[0m: Set 'table' to: '$table'."

    echo -en "\e[32m\e[1m[PROMPT]\e[0m: Enter Columns (Format: '<column>,<column>'): "
    read columns
    echo -e "\e[1A\e[K\e[36m\e[1m[STATUS]\e[0m: Selected columns: '$columns'."

    query="SELECT $columns FROM $table"
    validate_input "$query"

    echo "$query;" > .query.sql
    query_result=$(mariadb --user=$username --password=$password --database=$database -h localhost < .query.sql)
    rm .query.sql

    less <<< "$query_result"
}

echo -e "\e[32m\e[1m$title\e[0m\n"

echo -en "\e[31m\e[1m[AUTHENTICATION]\e[0m: User: "
read username

echo -en "\e[31m\e[1m[AUTHENTICATION]\e[0m: Password: "
read -s password
echo ""

mariadb --user=$username --password=$password < /dev/null 2>/dev/null || invalid_credentials $username

while [[ "$input" != "n" ]]
do
    run_query

    echo -en "\e[32m\e[1m[PROMPT]\e[0m: Enter another query? (Y/n) "
    read input
done
