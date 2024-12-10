#!/bin/bash
#set -x
##################################################
#Author : Dhinesh R
#Team : Infra
#Version: 0.1
#Description : Script for create user in Linux machine
######################################################

if [ $# -gt 0 ]; then
    for USER in $@; do
        echo $USER
        EXISTING_USER=$(cat /etc/passwd | grep -i -w $USER | cut -d ":" -f1)
        if [ "${USER}" = "${EXISTING_USER}" ]; then
            echo " the $USER is already existing in this machine, please create with another user "
        else
            echo " $USER is not present in machine lets create a new username "
            sudo useradd -m $USER --shell /bin/bash
            SPEC=$(echo '!@#$%^&*()_' | fold -w1 | shuf | head -1)
            PASSWORD="Testaccount@${RANDOM}${SPEC}"
            echo "$USER:$PASSWORD" | sudo chpasswd
            echo "The Tempoary password the $USER is ${PASSWORD}"
            sudo passwd -e $USER
        fi
    done
else
    echo " please enter correct username "

fi
