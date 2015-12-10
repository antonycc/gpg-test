gpg-test
==
A set of wrapper scripts and common config to create a confidential circle of trust between a group. The initial Use Case is sharing of credentials which are used privately in a local workspace and stored in a public/untrusted location.

Todate this project is an exploration of the PGP tool. When (if) mature scripted tests will accompany the project to aid extension without regression.

System requirements (general)
==
- Bash terminal
- gpg

Cugwin
--
- gnupg: https://sourceforge.net/projects/libusb-win32/files/libusb-win32-releases/1.2.6.0/libusb-win32-devel-filter-1.2.6.0.exe

TODO
==
- Specify key size in config (Cygwin's gnupg takes up to 4096 on the command line)
- Select algorithm in config rather than allowing Cygwin to prompt
- Select appropriate model to avoid trust warning whe using cygwin

Initial project set up
==
The files and structures in this project are decorators for an enclosing project. The idea is that when a team needs to share a secret, structures from this project are copied into there own project. The following steps are taken to use these project:

1. Clone this project locally.
2. Copy the gpg-scripts folder to your module root to create "my-module/gpg-scripts/".
3. Create a reciepients folder under your module root to create "my-module/recipients/".
4. Where you have an existing public/private key pair, copy the existing public key into the reciepents folder. 

New contributor on-boarding
==
1 [New contributor]
--
- Clones project from shared repository into workspace
- Generates keypair (RSA and RSA, 2048)
- Exports public key
- Adds public key to shared repository

2 [Existing contributor]
--
- Updates workspace from shared repository
- Imports public key into local keychain
- Decrypts sensitive material
- Encrypts using current public keys
- Updates shared repository with encrypted sensitive material

3 [New contributor] 
--
- Updates workspace from shared repository
- Decrypts sensitive material in workspace

Examples - OS X
==
OS Examples captured using:

    Darwin Kernel Version 15.0.0: Sat Sep 19 15:53:46 PDT 2015; root:xnu-3247.10.11~1/RELEASE_X86_64 x86_64

Generating a keypair and exporting a public key (1)
--

    Antonys-MacBook-Pro:gpg-test antony$ ./gpg-scripts/generate-keypair.sh 
    gpg --options "/Users/antony/projects/gpg-test/gpg-scripts/gpg-options.conf" --gen-key
    gpg (GnuPG) 2.1.5; Copyright (C) 2015 Free Software Foundation, Inc.
    This is free software: you are free to change and redistribute it.
    There is NO WARRANTY, to the extent permitted by law.

    Note: Use "gpg2 --full-gen-key" for a full featured key generation dialog.

    GnuPG needs to construct a user ID to identify your key.

    Real name: test10
    Email address: test10@example.com
    You selected this USER-ID:
        "test10 <test10@example.com>"

    Change (N)ame, (E)mail, or (O)kay/(Q)uit? O
    We need to generate a lot of random bytes. It is a good idea to perform
    some other action (type on the keyboard, move the mouse, utilize the
    disks) during the prime generation; this gives the random number
    generator a better chance to gain enough entropy.
    We need to generate a lot of random bytes. It is a good idea to perform
    some other action (type on the keyboard, move the mouse, utilize the
    disks) during the prime generation; this gives the random number
    generator a better chance to gain enough entropy.
    gpg: key B64BFE0E marked as ultimately trusted
    public and secret key created and signed.

    gpg: checking the trustdb
    gpg: 3 marginal(s) needed, 1 complete(s) needed, PGP trust model
    gpg: depth: 0  valid:  11  signed:   0  trust: 0-, 0q, 0n, 0m, 0f, 11u
    gpg: next trustdb check due at 2018-08-19
    pub   rsa2048/B64BFE0E 2015-12-10
          Key fingerprint = C9BF 07ED A0CC 28B0 766A  9C54 6B50 CFE2 B64B FE0E
    uid       [ultimate] test10 <test10@example.com>
    sub   rsa2048/CB700527 2015-12-10

    gpg --options "/Users/antony/projects/gpg-test/gpg-scripts/gpg-options.conf" --output "/Users/antony/projects/gpg-test/gpg-scripts/../recipients/test10@example.com.public" --export "test10 <test10@example.com>"
    Exported public key: -rw-r--r--  1 antony  staff  1694 10 Dec 13:41 /Users/antony/projects/gpg-test/gpg-scripts/../recipients/test10@example.com.public
    Antonys-MacBook-Pro:gpg-test antony$ 


Importing public keys and encrypting a secret (2)
--

    Antonys-MacBook-Pro:gpg-test antony$ ./gpg-scripts/encrypt.sh example-secret.txt 
    gpg --options "/Users/antony/projects/gpg-test/gpg-scripts/gpg-options.conf" --import "/Users/antony/projects/gpg-test/gpg-scripts/../recipients/test10@example.com.public"
    gpg: key B64BFE0E: "test10 <test10@example.com>" not changed
    gpg: Total number processed: 1
    gpg:              unchanged: 1
    gpg --options "/Users/antony/projects/gpg-test/gpg-scripts/gpg-options.conf" --import "/Users/antony/projects/gpg-test/gpg-scripts/../recipients/test2@example.com.public"
    gpg: key 87513011: "test2 <test2@example.com>" not changed
    gpg: Total number processed: 1
    gpg:              unchanged: 1
    gpg --options "/Users/antony/projects/gpg-test/gpg-scripts/gpg-options.conf" --import "/Users/antony/projects/gpg-test/gpg-scripts/../recipients/test3@example.com.public"
    gpg: key C3DE6EBB: "test3 <test3@example.com>" not changed
    gpg: Total number processed: 1
    gpg:              unchanged: 1
    gpg --options "/Users/antony/projects/gpg-test/gpg-scripts/gpg-options.conf" --import "/Users/antony/projects/gpg-test/gpg-scripts/../recipients/test6@example.com.public"
    gpg: key 66DB8C9C: "Test6 <test6@example.com>" not changed
    gpg: Total number processed: 1
    gpg:              unchanged: 1
    gpg --options "/Users/antony/projects/gpg-test/gpg-scripts/gpg-options.conf" --import "/Users/antony/projects/gpg-test/gpg-scripts/../recipients/test8@example.com.public"
    gpg: key AD17C38F: "Test8 <test8@example.com>" not changed
    gpg: Total number processed: 1
    gpg:              unchanged: 1
    gpg --options "/Users/antony/projects/gpg-test/gpg-scripts/gpg-options.conf" --import "/Users/antony/projects/gpg-test/gpg-scripts/../recipients/test9@example.com.public"
    gpg: key 8E79C987: "test9 <test9@example.com>" not changed
    gpg: Total number processed: 1
    gpg:              unchanged: 1
    gpg --options "/Users/antony/projects/gpg-test/gpg-scripts/gpg-options.conf" --output "example-secret.txt.gpg" --encrypt --recipient "test2 <test2@example.com>" --recipient "test3 <test3@example.com>" --recipient "Test6 <test6@example.com>" --recipient "Test8 <test8@example.com>" --recipient "test9 <test9@example.com>" --recipient "test10 <test10@example.com>" "example-secret.txt"
    Antonys-MacBook-Pro:gpg-test antony$ 


Decrypting a shared secret (3)
--

    Antonys-MacBook-Pro:gpg-test antony$ ls -l example-secret.txt
    ls: example-secret.txt: No such file or directory
    Antonys-MacBook-Pro:gpg-test antony$ ./gpg-scripts/decrypt.sh example-secret.txt
    gpg --options "/Users/antony/projects/gpg-test/gpg-scripts/gpg-options.conf" --output "example-secret.txt" --decrypt "example-secret.txt.gpg"
    gpg: encrypted with 2048-bit RSA key, ID CB700527, created 2015-12-10
          "test10 <test10@example.com>"
    gpg: encrypted with 2048-bit RSA key, ID 3438AA66, created 2015-12-10
          "test9 <test9@example.com>"
    gpg: encrypted with 2048-bit RSA key, ID 70904840, created 2015-12-10
          "Test8 <test8@example.com>"
    gpg: encrypted with 2048-bit RSA key, ID CA79665E, created 2015-12-10
          "Test6 <test6@example.com>"
    gpg: encrypted with 2048-bit RSA key, ID F870AF97, created 2015-11-29
          "test3 <test3@example.com>"
    gpg: encrypted with 2048-bit RSA key, ID 2BA31D8D, created 2015-11-29
          "test2 <test2@example.com>"
    Antonys-MacBook-Pro:gpg-test antony$ ls -l example-secret.txt
    -rw-r--r--  1 antony  staff  58 10 Dec 13:59 example-secret.txt
    Antonys-MacBook-Pro:gpg-test antony$ 


Decrypting a shared secret to the environment (3)
--

    Antonys-MacBook-Pro:gpg-test antony$ echo $SECRET1

    Antonys-MacBook-Pro:gpg-test antony$ . ./gpg-scripts/decrypt-to-env.sh example-secret.txt
    gpg --options "/Users/antony/projects/gpg-test/gpg-scripts/gpg-options.conf" --output "./tmp_29407" --decrypt "example-secret.txt.gpg"
    gpg: encrypted with 2048-bit RSA key, ID CB700527, created 2015-12-10
          "test10 <test10@example.com>"
    gpg: encrypted with 2048-bit RSA key, ID 3438AA66, created 2015-12-10
          "test9 <test9@example.com>"
    gpg: encrypted with 2048-bit RSA key, ID 70904840, created 2015-12-10
          "Test8 <test8@example.com>"
    gpg: encrypted with 2048-bit RSA key, ID CA79665E, created 2015-12-10
          "Test6 <test6@example.com>"
    gpg: encrypted with 2048-bit RSA key, ID F870AF97, created 2015-11-29
          "test3 <test3@example.com>"
    gpg: encrypted with 2048-bit RSA key, ID 2BA31D8D, created 2015-11-29
          "test2 <test2@example.com>"
    Antonys-MacBook-Pro:gpg-test antony$ echo $SECRET1
    this-is-a-secret-one
    Antonys-MacBook-Pro:gpg-test antony$ 

Examples - Cygwin
==
Cygwin examples captured using:

    CYGWIN_NT-6.3 ANTONYCARTWC7BC 2.3.1(0.291/5/3) 2015-11-14 12:44 x86_64 Cygwin

    
Generating a keypair and exporting a public key (1)
--

   antony@ANTONYCARTWC7BC ~/projects/gpg-test
   $ ./gpg-scripts/generate-keypair.sh
   gpg --options "/cygdrive/c/Users/antony/projects/gpg-test/gpg-scripts/gpg-options.conf" --gen-key
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

   Real name: test11
   Email address: test11@example.com
   Comment:
   You selected this USER-ID:
       "test11 <test11@example.com>"

   Change (N)ame, (C)omment, (E)mail or (O)kay/(Q)uit? O
   You need a Passphrase to protect your secret key.

   We need to generate a lot of random bytes. It is a good idea to perform
   some other action (type on the keyboard, move the mouse, utilize the
   disks) during the prime generation; this gives the random number
   generator a better chance to gain enough entropy.
   +++++
   .+++++
   We need to generate a lot of random bytes. It is a good idea to perform
   some other action (type on the keyboard, move the mouse, utilize the
   disks) during the prime generation; this gives the random number
   generator a better chance to gain enough entropy.
   ..+++++
   ........+++++
   gpg: key E97E87BD marked as ultimately trusted
   public and secret key created and signed.

   gpg: checking the trustdb
   gpg: 3 marginal(s) needed, 1 complete(s) needed, PGP trust model
   gpg: depth: 0  valid:   2  signed:   0  trust: 0-, 0q, 0n, 0m, 0f, 2u
   pub   2048R/E97E87BD 2015-11-30
         Key fingerprint = AB7A BE22 0A87 95F7 E14C  3387 B230 188D E97E 87BD
   uid                  test11 <test11@example.com>
   sub   2048R/DF12ADD6 2015-11-30

   gpg --options "/cygdrive/c/Users/antony/projects/gpg-test/gpg-scripts/gpg-options.conf" --output "/cygdrive/c/Users/antony/projects/gpg-test/gpg-scripts/../recipients/test11@example.com.public" --export "test11 <test11@example.com>"
   Exported public key: -rw-r--r-- 1 antony None 1694 Nov 30 12:50 /cygdrive/c/Users/antony/projects/gpg-test/gpg-scripts/../recipients/test11@example.com.public

   antony@ANTONYCARTWC7BC ~/projects/gpg-test
   $


Importing public keys and encrypting a secret (2)
--


Decrypting a shared secret (3)
--



Decrypting a shared secret to the environment (3)
--


Further reading
==
- https://gnupg.org/documentation/howtos.html
- http://www.dewinter.com/gnupg_howto/english/GPGMiniHowto-3.html
- https://www.gnupg.org/gph/de/manual/r1023.html
- https://www.gnupg.org/documentation/manuals/gnupg/
