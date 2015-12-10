#!/bin/bash
# Purpose: Encypt the credentials to share with all the signers
# https://www.gnupg.org/gph/en/manual.html#AEN111
# Usage: gpg-encrypt.sh <clear file>
# e.g. ./gpg-encrypt.sh credentials.txt

# Parameters
FILE_CLEAR=${1?}

# Constants
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
RECIPIENTS_FILE="${DIR?}/gpg-recipients.txt"
OPTIONS_FILE="${DIR?}/gpg-options.conf"

RECIPIENTS=$( cat "${RECIPIENTS_FILE?}" | tr "\n" " " )
echo "Encrypting for recipients: \"${RECIPIENTS}\""
CMD="gpg --options \"${OPTIONS_FILE?}\" --output \"${FILE_CLEAR?}.gpg\" --encrypt \"${RECIPIENTS?}\" \"${FILE_CLEAR?}\""
echo $CMD
eval $CMD