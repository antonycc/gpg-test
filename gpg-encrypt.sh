#!/bin/bash
# Purpose: Encypt the credentials to share with all the signers

RECIPIENTS=$( cat gpg-signers.txt | tr "\n" " " )
echo "Encrypting for recipients: \"${RECIPIENTS}\""
CMD="gpg --options gpg-options.conf --encrypt ${RECIPIENTS?} credentials.txt"
eval $CMD