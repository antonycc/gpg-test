#!/bin/bash
# Purpose: Add a UID to the signers list

echo "Available key pairs:"
gpg --options gpg-options.conf --list-keys | grep -e "^uid" | cat -n
echo -n "Enter the number of the key pair to add: " ; read KEYPAIR_NUMBER
KEYPAIR_UID=$( gpg --options gpg-options.conf --list-keys | grep -e "^uid" | sed "${KEYPAIR_NUMBER?}q;d" | sed "s/^[^]]*][[:space:]]*//" )
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
   mv gpg-recipients.txt gpg-tmp-recipients.txt
   cat gpg-tmp-recipients.txt | grep -v "${KEYPAIR_EMAIL?}" > gpg-recipients.txt
   echo "--recipient \"${KEYPAIR_UID?}\"" >> gpg-recipients.txt
   rm gpg-tmp-recipients.txt
fi
echo "Current signers:"
cat gpg-recipients.txt