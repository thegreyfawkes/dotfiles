#!/bin/bash
# *****
# change directory to rsync folder (taken from stackoverflow - verify if this step is necessary
cd /rsync_pi

##### FILESYSTEM BACKUP #####
# OLD METHOD - backup home as a .tar.gz file, and put it in the rsync folder
#sudo tar czf pi_bak.tar.gz /home/rsync_pi

# CURRENT - utilize rsync and a text file with exclusions to back up everything
# directly to a mounted USB drive in /mnt/usbdrive
rsync -aHv --delete-during --exclude-from=/rsync-exclude.txt / /mnt/usbdrive/
# note that "--delete-during" is meaningless the 1st time, but is used in
# subsequent backups
# TO RESTORE:
#rsync -av --delete-during /mnt/usbdrive/ /mnt/sdcard_partition2
