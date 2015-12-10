#!/bin/bash
# Purpose: Generate keys for new user or an existing user requiring a new key, export the key, then update the recipients list
# Usage: generate-export-update.sh.sh 
# e.g. ./generate-export-update.sh.sh 

# Parameters

# Constants
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

${DIR?}/gpg-key-gen.sh
${DIR?}/gpg-export.sh --noninteractive
${DIR?}/gpg-update-recipients.sh --noninteractive
