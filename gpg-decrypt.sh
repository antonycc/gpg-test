#!/bin/bash
# Purpose: Decrypt using one of the key pairs in the local key chain

CMD="gpg --options gpg-options.conf --output credentials.txt --decrypt credentials.txt.asc"
echo $CMD
eval $CMD

