#!/bin/bash
# Purpose: Add a UID to the signers list
# Usage: gpg-update-recipients.sh 
# e.g. ./gpg-update-recipients.sh 

# Parameters

# Constants
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
RECIPIENTS_FILE="${DIR?}/gpg-recipients.txt"
OPTIONS_FILE="${DIR?}/gpg-options.conf"

echo "Available key pairs:"
gpg --options gpg-options.conf --list-keys | grep -e "^uid" | cat -n
echo -n "Enter the number of the key pair to add: " ; read KEYPAIR_NUMBER
KEYPAIR_UID=$( gpg --options "${OPTIONS_FILE?}" --list-keys | grep -e "^uid" | sed "${KEYPAIR_NUMBER?}q;d" | sed "s/^[^]]*][[:space:]]*//" | sed "s/^uid[[:space:]]*//" )
echo "Selected UID: \"${KEYPAIR_UID?}\""
KEYPAIR_EMAIL=$( echo "${KEYPAIR_UID?}" | sed "s/^[^<]*<//" | sed "s/>//" )
echo "Any matching email addresses matching ${KEYPAIR_EMAIL?} in the signers list will be removed:"
cat gpg-recipients.txt | grep "${KEYPAIR_EMAIL?}"
if [ "$?" == "0" ] ;
then
   echo -n "Enter Y to remove the above key pairs from the signers list and add \"${KEYPAIR_UID?}\": " ; read Y_TO_PROCEED
else
   Y_TO_PROCEED="Y"
fi
if [ "${Y_TO_PROCEED?}" == "Y" ] ;
then
   mv "${RECIPIENTS?}" "${RECIPIENTS?}.tmp"
   cat "${RECIPIENTS?}.tmp" | grep -v "${KEYPAIR_EMAIL?}" > "${RECIPIENTS?}"
   echo "--recipient \"${KEYPAIR_UID?}\"" >> "${RECIPIENTS?}"
   rm "${RECIPIENTS?}.tmp"
fi
echo "Current signers:"
cat "${RECIPIENTS?}"