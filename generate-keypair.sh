#!/bin/bash
# Purpose: Generate keys for new user or an existing user requiring a new key
# Usage: generate-keypair.sh 
# e.g. ./generate-keypair.sh 

# Parameters

# Constants
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
OPTIONS_FILE="${DIR?}/gpg-options.conf"

CMD="gpg --options \"${OPTIONS_FILE?}\" --gen-key"
echo $CMD
eval $CMD
