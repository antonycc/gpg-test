#!/bin/bash
# Purpose: Encypt a file using public keys of all the recipients
# https://www.gnupg.org/gph/en/manual.html#AEN111
# Usage: encrypt.sh <clear file>
# e.g. ./gpg-scripts/encrypt.sh credentials.txt

# Parameters
FILE_CLEAR=${1?}

# Constants
SCRIPTS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
RECIPIENTS_DIR="${SCRIPTS_DIR?}/../recipients"
OPTIONS_FILE="${SCRIPTS_DIR?}/gpg-options.conf"
TMP_FILE="./tmp_${RANDOM?}"

# Ensure all the public keys are imported
ls -1 "${RECIPIENTS_DIR?}"/*.public |
while read PUBLIC_KEY_FILE
do
   CMD="gpg --options \"${OPTIONS_FILE?}\" --import \"${PUBLIC_KEY_FILE?}\""
   echo $CMD
   eval $CMD
done

# Generate a list of recipients from the intesection of locally imported keys and public keys in recipients
cat /dev/null > "${TMP_FILE?}"
gpg --options "${OPTIONS_FILE?}" --list-keys | grep -e "^uid" | sed "s/^[^]]*][[:space:]]*//" | sed "s/^uid[[:space:]]*//" |
while read KEYPAIR_UID
do
   KEYPAIR_EMAIL=$( echo "${KEYPAIR_UID?}" | sed "s/^[^<]*<//" | sed "s/>//" )
   if [ -e "${RECIPIENTS_DIR?}/${KEYPAIR_EMAIL?}.public" ] ;
   then
      echo "--recipient \"${KEYPAIR_UID?}\"" >> "${TMP_FILE?}"
   fi
done

# Encrypt the file using the recipients
RECIPIENTS=$( cat "${TMP_FILE?}" | tr "\n" " " )
#echo "Encrypting for recipients: \"${RECIPIENTS}\""
CMD="gpg --options \"${OPTIONS_FILE?}\" --output \"${FILE_CLEAR?}.gpg\" --encrypt ${RECIPIENTS?} \"${FILE_CLEAR?}\""
echo $CMD
eval $CMD
rm "${TMP_FILE?}"
