#!/bin/bash
# Purpose: Decrypt using one of the key pairs in the local key chain

echo "Available key pairs:"
gpg --options gpg-options.conf --list-keys | grep -e "^uid" | cat -n
echo -n "Enter the number of the key pair to decrypt with: " ; read KEYPAIR_NUMBER
KEYPAIR_UID=$( gpg --options gpg-options.conf --list-keys | grep -e "^uid" | sed "${KEYPAIR_NUMBER?}q;d" | sed "s/^[^]]*][[:space:]]*//" )
echo "Selected UID: \"${KEYPAIR_UID?}\""
echo "gpg --options gpg-options.conf --decrypt --recipient \"${KEYPAIR_UID?}\" credentials.txt.asc"

