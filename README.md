# Dougs-ClusterHat-View-Script
A script to spawn 6 xterms that shell into the p1-p4, the cnat and the local system

The purpose of the script is to set up a six terminal view in a two column three row
matrix. The top four are p1-p4 and the bottom two are the cnat and the local host.

Hardware Topology:

  I am using a Pi 4B as the ClusterHat host.
  It is running Raspbian GNU/Linux 12 (bookworm)

  The slave cards are running Raspbian GNU/Linux 10 (buster)
  The slave cards are booting off 16GB MicroSD cards.

  The script is meant to run on a GNU Linux host. In my case I am using LMDE
  running on my Ryzen 9 development machine. The development machine is on
  a local network subnet. 

  The ClusterHat host machine is a raspberry Pi 4B that has a ClusterHat v2.4
  installed with four Raspberry Pi Zero W v1.1 modules.



SETTING UP THE SYSTEM FOR THE SCRIPT

  Preparing the development machine:
    The user-facing machine must be running GNU Linux (I use LMDE 6 Faye)
    The ssh client must be available

  Preparing the ClusterHat Host machine
    I added a doug account as well as other user accounts for each slave.

    Here is an except from the /etc/passwd
      doug:x:1000:1000:,,,:/home/doug:/bin/bash
      userp1:x:1001:1000:ClusterHat P1 User,,,:/home/userp1:/bin/bash
      userp2:x:1001:1000:ClusterHat P2 User,,,:/home/userp2:/bin/bash
      userp3:x:1001:1000:ClusterHat P3 User,,,:/home/userp3:/bin/bash
      userp4:x:1001:1000:ClusterHat P4 User,,,:/home/userp4:/bin/bash

    Here is an excerpt from the /etc/group
      goodall:x:1000:
      userp1:x:1000:
      userp2:x:1000:
      userp3:x:1000:
      userp4:x:1000:

    etc/hosts looks like this:
      127.0.0.1      localhost
      172.19.181.1   p1
      172.19.181.2   p2
      172.19.181.3   p3
      172.19.181.4   p4
      172.19.181.254 gw

    Each of the user accounts gets a .ssh/authorized_keys entry through the followng action:
      On the cnat host,
        ssh-copy-id pi@p1
        ssh-copy-id pi@p2
        ssh-copy-id pi@p3
        ssh-copy-id pi@p4
    
    Each of the userpX accounts needs an edit to it's .bashrc file.
    A line needs to be added at the end like so:

      /home/userp1/.bashrc gets appended with:
        ssh pi@p1

      /home/userp2/.bashrc get appended with 
        ssh pi@p2

      And so on for userp3 and user p4.

    The user-facing machine must also establish credentials with the clusterhat host.
      I did this with a:
        ssh-copy-id doug@192.168.4.251  
      
THEORY OF SCRIPT OPERATION

  When the script is executed on the user-facing host, it spawns a total of six xterms.
  The first four are used to communicatye with the slave cards.
  The fifth communicates with the cnat host.
  The sixth communicates with the user-facing host.

  The script does the following:

    1. Lines 5-6 get the screen geometry from the OS. SCREEN_WIDTH and SCREEN_HEIGHT.
    2. Lines 10-11 calculate the width and height of each window assuming two columns
      and three rows. WIN_WIDTH and WIN_HEIGHT
    3. Lines 13-18 define the default background colors for each xterm 
    4. Lines 20-31 calculate the vertical position and horizontal position for each window.
    5. lines 33-34 set the number of character per line HCHAR and lines per window VCHAR.
    6. Lines 36-41 create a macro containing what is needed for the --geometry field
    7. line 44 sets the Fonmt Size for characters in the targbet windows.
    8. Lines 46-51 Spawn the xterms using all the prepared fields.
    
