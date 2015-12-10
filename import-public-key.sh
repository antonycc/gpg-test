#!/bin/bash
# Purpose: Import all the a public key from this folder into the local key chain
# Usage: gpg-import.sh 
# e.g. ./gpg-import.sh 

# Parameters

# Constants
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
OPTIONS_FILE="${DIR?}/gpg-options.conf"

ls -1 *.public |
while read PUBLIC_KEY_FILE
do
   CMD="gpg --options \"${OPTIONS_FILE?}\" --import \"${PUBLIC_KEY_FILE?}\""
   echo $CMD
   eval $CMD
done
