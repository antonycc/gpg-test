#!/bin/bash
# Purpose: Export a key so it can be shared vis the repository

echo "Available keys:"
gpg --options gpg-options.conf --list-keys | grep -e "^uid" | cat -n
echo -n "Enter the number for your account: " ; read KEY_NUMBER
KEYPAIR_UID=$( gpg --options gpg-options.conf --list-keys | grep -e "^uid" | sed "${KEY_NUMBER?}q;d" | sed "s/^[^]]*][[:space:]]*//" )
echo "Selected UID: \"${KEYPAIR_UID?}\""
KEYPAIR_EMAIL=$( echo "${KEYPAIR_UID?}" | sed "s/^[^<]*<//" | sed "s/>//" )
gpg --options gpg-options.conf --output "${KEYPAIR_EMAIL?}.public" --export "${KEYPAIR_UID?}"
echo -n "Exported public key: " ; ls -l "${KEYPAIR_EMAIL?}.public"