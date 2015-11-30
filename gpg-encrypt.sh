#!/bin/bash
# Purpose: Encypt the credentials to share with all the signers
# https://www.gnupg.org/gph/en/manual.html#AEN111

RECIPIENTS=$( cat gpg-recipients.txt | tr "\n" " " )
echo "Encrypting for recipients: \"${RECIPIENTS}\""
CMD="gpg --options gpg-options.conf --encrypt ${RECIPIENTS?} credentials.txt"
eval $CMD