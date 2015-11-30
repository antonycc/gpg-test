# gpg-test

Intended use
============

Share common credentials

Initial project set up
======================


New contributor on-boarding
==========================

 1. [Existing contributor] Invites [New contributor] to join the project
 2. [New contributor] Clone project from shared repository into workspace
 3. [New contributor] Generate keypair (RSA and RSA, 2048)
 4. [New contributor] Export public key
 5. [New contributor] Add public key to shared repository
 6. [Existing contributor] Update workspace from shared repository
 7. [Existing contributor] Import public key into local keychain
 8. [Existing contributor] Decrypt sensitive material and re-encrypts using current public keys
 9. [Existing contributor] Update shared repository with encrypted sensitive material
10. [New contributor] Update workspace from shared repository
11. [New contributor] Decrypt sensitive material in workspace




Test secure storage of sensitive information using public private keys
Docs:
https://gnupg.org/documentation/howtos.html
http://www.dewinter.com/gnupg_howto/english/GPGMiniHowto-3.html
https://www.gnupg.org/gph/de/manual/r1023.html
https://www.gnupg.org/documentation/manuals/gnupg/

gnupg
https://sourceforge.net/projects/libusb-win32/files/libusb-win32-releases/1.2.6.0/libusb-win32-devel-filter-1.2.6.0.exe

Generating a key with Cygwin
============================

$ ./gpg-key-gen.sh
gpg (GnuPG) 1.4.19; Copyright (C) 2015 Free Software Foundation, Inc.
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Please select what kind of key you want:
   (1) RSA and RSA (default)
   (2) DSA and Elgamal
   (3) DSA (sign only)
   (4) RSA (sign only)
Your selection? 1
RSA keys may be between 1024 and 4096 bits long.
What keysize do you want? (2048) 2048
Requested keysize is 2048 bits
Please specify how long the key should be valid.
         0 = key does not expire
      <n>  = key expires in n days
      <n>w = key expires in n weeks
      <n>m = key expires in n months
      <n>y = key expires in n years
Key is valid for? (0) 0
Key does not expire at all
Is this correct? (y/N) y

You need a user ID to identify your key; the software constructs the user ID
from the Real Name, Comment and Email Address in this form:
    "Heinrich Heine (Der Dichter) <heinrichh@duesseldorf.de>"

Real name: test5
Email address: test5@example.com
Comment:
You selected this USER-ID:
    "test5 <test5@example.com>"

Change (N)ame, (C)omment, (E)mail or (O)kay/(Q)uit? O
You need a Passphrase to protect your secret key.

We need to generate a lot of random bytes. It is a good idea to perform
some other action (type on the keyboard, move the mouse, utilize the
disks) during the prime generation; this gives the random number
generator a better chance to gain enough entropy.
....+++++
....+++++
gpg: writing self signature
gpg: RSA/SHA1 signature from: "E120B7C3 [?]"
We need to generate a lot of random bytes. It is a good idea to perform
some other action (type on the keyboard, move the mouse, utilize the
disks) during the prime generation; this gives the random number
generator a better chance to gain enough entropy.
........+++++
........+++++
gpg: writing key binding signature
gpg: RSA/SHA1 signature from: "E120B7C3 [?]"
gpg: writing key binding signature
gpg: RSA/SHA1 signature from: "E120B7C3 [?]"
gpg: writing public key to `/cygdrive/c/Users/antony/.gnupg/pubring.gpg'
gpg: writing secret key to `/cygdrive/c/Users/antony/.gnupg/secring.gpg'
gpg: /cygdrive/c/Users/antony/.gnupg/trustdb.gpg: trustdb created
gpg: using PGP trust model
gpg: key E120B7C3 marked as ultimately trusted
public and secret key created and signed.

gpg: checking the trustdb
gpg: 1 keys cached (2 signatures)
gpg: 1 keys processed (0 validity counts cleared)
gpg: 3 marginal(s) needed, 1 complete(s) needed, PGP trust model
gpg: depth: 0  valid:   1  signed:   0  trust: 0-, 0q, 0n, 0m, 0f, 1u
pub   2048R/E120B7C3 2015-11-30
      Key fingerprint = D78F 736D 6BBC 41DA 3C67  9F4A 8E1F 0880 E120 B7C3
uid                  test5 <test5@example.com>
sub   2048R/184C8FE5 2015-11-30

antony@ANTONYCARTWC7BC ~/projects/gpg-test
$


Export public key (Cygwin)
==========================

$ ./gpg-export.sh
Available key pairs:
gpg: using PGP trust model
     1  uid                  test5 <test5@example.com>
Enter the number for your key pair: 1
gpg: using PGP trust model
Selected UID: "test5 <test5@example.com>"
gpg --options gpg-options.conf --output "test5@example.com.public" --export "test5 <test5@example.com>"
gpg: writing to `test5@example.com.public'
Exported public key: -rw-r--r-- 1 antony None 1690 Nov 30 11:45 test5@example.com.public

antony@ANTONYCARTWC7BC ~/projects/gpg-test
$ 






