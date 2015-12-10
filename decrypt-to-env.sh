#!/bin/bash
# Purpose: Decrypt using one of the key pairs in the local key chain to the environment. 
# Usage: decrypt-to-env.sh <clear file>
# e.g. . ./decrypt-to-env.sh credentials.txt

# Parameters
FILE_CLEAR=${1?}

# Constants
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
OPTIONS_FILE="${DIR?}/gpg-options.conf"
TMP_FILE="./tmp_${RANDOM?}"

CMD="gpg --options \"${OPTIONS_FILE?}\" --output \"${TMP_FILE?}\" --decrypt \"${FILE_CLEAR?}.gpg\""
echo $CMD
eval $CMD
source "${TMP_FILE?}"
rm "${TMP_FILE?}"