#!/bin/bash
# *****
# change directory to rsync folder (taken from stackoverflow - verify if this step is necessary
cd /home/rsync_pi

# backup home as a .tar.gz file, and put it in the rsync folder
sudo tar czf pi_bak.tar.gz /home/rsync_pi

# backup everything, excluding folders in exclude file
# initial run will take a long time; subsequent runs will utilize excludes
# !BACKUP EVERYTHING MANUALLY BEFORE LETTING IT CONTINUE INAUGURAL RUN
# sudo rsync -aHv --delete-during --exclude-during --exclude-from=/home/,dotlifes/rsync-exclude.txt / /home/rsync_pi/

