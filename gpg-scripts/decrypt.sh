#!/bin/bash
# Purpose: Decrypt using one of the key pairs in the local key chain
# Usage: decrypt.sh <clear file>
# e.g. ./decrypt.sh credentials.txt

# Parameters
FILE_CLEAR=${1?}

# Constants
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
OPTIONS_FILE="${DIR?}/gpg-options.conf"

CMD="gpg --options \"${OPTIONS_FILE?}\" --output \"${FILE_CLEAR?}\" --decrypt \"${FILE_CLEAR?}.gpg\""
echo $CMD
eval $CMD

