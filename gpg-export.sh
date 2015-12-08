#!/bin/bash
# Purpose: Export a key so it can be shared via the repository
# Usage: gpg-export.sh 
# e.g. ./gpg-export.sh 

# Parameters

# Constants
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
OPTIONS_FILE="${DIR?}/gpg-options.conf"

echo "Available key pairs:"
gpg --options gpg-options.conf --list-keys | grep -e "^uid" | cat -n
echo -n "Enter the number for your key pair: " ; read KEY_NUMBER
KEYPAIR_UID=$( gpg --options "${OPTIONS_FILE?}" --list-keys | grep -e "^uid" | sed "${KEY_NUMBER?}q;d" | sed "s/^[^]]*][[:space:]]*//" | sed "s/^uid[[:space:]]*//" )
echo "Selected UID: \"${KEYPAIR_UID?}\""
KEYPAIR_EMAIL=$( echo "${KEYPAIR_UID?}" | sed -e "s/^[^<]*<//" | sed -e "s/>//" )
CMD="gpg --options \"${OPTIONS_FILE?}\" --output \"${KEYPAIR_EMAIL?}.public\" --export \"${KEYPAIR_UID?}\""
echo $CMD
eval $CMD
echo -n "Exported public key: " ; ls -l "${KEYPAIR_EMAIL?}.public"