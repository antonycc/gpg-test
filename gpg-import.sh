#!/bin/bash
# Purpose: Import all the a public key from this folder into the local key chain

ls -1 *.public |
while read PUBLIC_KEY_FILE
do
   gpg --options gpg-options.conf --import ${PUBLIC_KEY_FILE?}
done
