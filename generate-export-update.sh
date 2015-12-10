#!/bin/bash
# Purpose: Generate keys for new user or an existing user requiring a new key, export the key, then update the recipients list
# Usage: generate-export-update.sh.sh 
# e.g. ./generate-export-update.sh.sh 

# Parameters

# Constants
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

${DIR?}/generate-keypair.sh
${DIR?}/export-public-key.sh --noninteractive
${DIR?}/update-recipients.sh --noninteractive
