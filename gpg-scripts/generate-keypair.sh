#!/bin/bash
# Purpose: Generate keys for new user or an existing user requiring a new key and expprt to recipients folder
# Usage: generate-keypair.sh 
# e.g. ./gpg-scripts/generate-keypair.sh 

# Parameters

# Constants
SCRIPTS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
RECIPIENTS_DIR="${SCRIPTS_DIR?}/../recipients"
OPTIONS_FILE="${SCRIPTS_DIR?}/gpg-options.conf"

# Generate the key
CMD="gpg --options \"${OPTIONS_FILE?}\" --gen-key"
echo $CMD
eval $CMD

# Export to recipients folder
KEYPAIR_UID=$( gpg --options "${OPTIONS_FILE?}" --list-keys | grep -e "^uid" | tail -1 | sed "s/^[^]]*][[:space:]]*//" | sed "s/^uid[[:space:]]*//" )
#echo "Selected UID: \"${KEYPAIR_UID?}\""
KEYPAIR_EMAIL=$( echo "${KEYPAIR_UID?}" | sed -e "s/^[^<]*<//" | sed -e "s/>//" )
CMD="gpg --options \"${OPTIONS_FILE?}\" --output \"${RECIPIENTS_DIR?}/${KEYPAIR_EMAIL?}.public\" --export \"${KEYPAIR_UID?}\""
echo $CMD
eval $CMD
echo -n "Exported public key: " ; ls -l "${RECIPIENTS_DIR?}/${KEYPAIR_EMAIL?}.public"
