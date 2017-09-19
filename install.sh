#!/bin/bash

DOTFILES_DIR=$HOME/pi/dotfiles
UNIVERSAL_PROGRAMS=(vim tmux curl git nmap);
# not added yet: tig, htop, vifm, zsh, sqlite3

function main () {
	remove_existing
	clone_repo
	install_apt_programs
	mount_usb_and_restore
	setup_dotfiles
	decoupling
}

function remove_existing () {
	echo "Delete current dotfiles directory? (y/N)"
	old_stty_cfg=$(stty -g)
	stty raw -echo
	answer=$( while ! head -c 1 | grep -i '[ny]' ;do true ;done )
	stty $old_stty_cfg
	if echo "$answer" | grep -iq "^y" ;then
		cd $HOME
		rm -rf $DOTFILES_DIR
		rm -rf $DOTFILES_DIR/.Trash
		mkdir $DOTFILES_DIR
		mkdir $DOTFILES_DIR/.Trash
	else
		echo "Dotfiles folder not deleted. This may negatively impact installation."
	fi
}

function clone_repo () {
	echo "Clone dotfiles now? (y/N)"
	old_stty_cfg=$(stty -g)
	stty raw -echo
	answer=$( while ! head -c 1 | grep -i '[ny]' ;do true ;done )
	stty $old_stty_cfg
	if echo "$answer" | grep -iq "^y" ;then
		git clone https://github.com/thegreyfawkes/dotfiles-1 $DOTFILES_DIR
	else
		echo "Dotfiles not cloned."
	fi
}

function install_apt_programs () {	
	echo "Begin apt-get install process? (y/N)"
	old_stty_cfg=$(stty -g)
	stty raw -echo
	answer=$( while ! head -c 1 | grep -i '[ny]' ;do true ;done )
	stty $old_stty_cfg
	if echo "$answer" | grep -iq "^y" ;then
		sudo apt-get update
		sudo apt-get -y apt
		sudo apt-get install -y unattended-upgrades apt-listchanges
		sudo apt-get install -y nmap
		sudo apt-get install -y git
		sudo apt-get install -y curl
		sudo apt-get install -y vim
		sudo apt-get install apache2 -y
		sudo apt-get install php7 libapache3-mod-php7
		sudo apt-get install mysql-server mysql-client
		sudo apt-get upgrade -y
	else
		echo "Apt-Get install process not started."
	fi
}

function mount_usb_and_restore () {
	echo "Restore data from USB backup? (y/N)"
	old_stty_cfg=$(stty -g)
	stty raw -echo
	answer=$( while ! head -c 1 | grep -i '[ny]' ;do true ;done )
	stty $old_stty_cfg
	if echo "$answer" | grep -iq "^y" ;then
		sudo mkdir /mnt/usbdrive
		sudo mount /dev/sda1 /mnt/usbdrive
		target=$1
		if test "$(ls -A "$target")"; then
			sudo rsync -av --delete-during /mnt/usbdrive/ /
		else
			echo "$target is either empty or cannot be found"
		fi
	else
		echo "USB restore operation cancelled"
	fi
}

function setup_dotfiles () {
	echo "Run user configuration 'deploy' script? (y/N)"
	old_stty_cfg=$(stty -g)
	stty raw -echo
	answer=$( while ! head -c 1 | grep -i '[ny]' ;do true ;done )
	stty $old_stty_cfg
	if echo "$answer" | grep -iq "^y" ;then
		if [ -d "/root/dotfiles-1" ]; then
			/bin/bash /root/dotfiles-1/deploy
			echo "Deploy script run from 'dotfiles-1'"
		else
			/bin/bash /root/dotfiles/deploy
			echo "Deploy script run from 'dotfiles'"
		fi
	else
		echo -e "\nDeploy script will not be run."
	fi
}

function decoupling () {
	echo "---DEPLOY SCRIPT COMPLETE---"
	echo "Please document errors NOW so you do not forget them."
	echo "Also, it might be beneficial to actually just try to fix it now."
}

