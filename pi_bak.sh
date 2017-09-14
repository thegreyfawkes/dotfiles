#!/bin/bash
# *****
# change directory to rsync folder (taken from stackoverflow - verify if this step is necessary
cd /rsync_pi

###### FILESYSTEM BACKUP ######
### Depreciated ### 
# backup home as a .tar.gz file, and put it in the rsync folder
#sudo tar czf pi_bak.tar.gz /home/rsync_pi

### CURRENT ###
# Utilize rsync and a text file with exclusions to back up everything directly to a mounted USB drive in /mnt/usbdrive
sudo rsync -aHv --delete-during --exclude-from=/rsync-exclude.txt / /mnt/usbdrive/
# note that "--delete-during" is meaningless the 1st time, but is used in subsequent backups
# TO RESTORE, use following at cmd prompt (not in this script):
#rsync -av --delete-during /mnt/usbdrive/ /mnt/sdcard_partition2

# Compress output of rsync above to .tar file - Partially works, needs refinement
#sudo ./dotfiles/pi_bak.sh > /rsync_pi/pi_bak-`date +\%Y\%m\%d\%H\%M`.tar.gz

# Copy 'rsync_pi/" over to usb "rsync_pi/"
sudo cp -r /rsync_pi/ /mnt/usbdrive/rsync_pi/
