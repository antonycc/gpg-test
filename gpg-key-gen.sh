#!/bin/bash
# Purpose: Generate keys for new user or an existing user requiring a new key

CMD="gpg --options gpg-options.conf --gen-key"
echo $CMD
eval $CMD
