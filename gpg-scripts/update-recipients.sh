#!/bin/bash
# Purpose: Add a UID to the signers list
# Usage: update-recipients.sh  [--noninteractive]
# e.g. ./update-recipients.sh 
#      ./update-recipients.sh --noninteractive

# Parameters
NON_INTERACTIVE=$([ "${1}" == "--noninteractive" ] && echo "true" || echo "false")

# Constants
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
RECIPIENTS_FILE="${DIR?}/recipients.txt"
OPTIONS_FILE="${DIR?}/gpg-options.conf"
TMP_FILE="./tmp_${RANDOM?}"

if [ "${NON_INTERACTIVE?}" == "true" ] ;
then
   KEYPAIR_UID=$( gpg --options "${OPTIONS_FILE?}" --list-keys | grep -e "^uid" | tail -1 | sed "s/^[^]]*][[:space:]]*//" | sed "s/^uid[[:space:]]*//" )
else
   echo "Available key pairs:"
   gpg --options gpg-options.conf --list-keys | grep -e "^uid" | cat -n
   echo -n "Enter the number of the key pair to add: " ; read KEYPAIR_NUMBER
   KEYPAIR_UID=$( gpg --options "${OPTIONS_FILE?}" --list-keys | grep -e "^uid" | sed "${KEYPAIR_NUMBER?}q;d" | sed "s/^[^]]*][[:space:]]*//" | sed "s/^uid[[:space:]]*//" )
fi
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
   mv "${RECIPIENTS_FILE?}" "${TMP_FILE?}"
   cat "${TMP_FILE?}" | grep -v "${KEYPAIR_EMAIL?}" > "${RECIPIENTS_FILE?}"
   echo "--recipient \"${KEYPAIR_UID?}\"" >> "${RECIPIENTS_FILE?}"
   rm "${TMP_FILE?}"
fi
echo "Current signers:"
cat "${RECIPIENTS_FILE?}"