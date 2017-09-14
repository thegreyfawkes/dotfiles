#!/bin/bash

DOTFILES_DIR=$HOME/pi/dotfiles
UNIVERSAL_PROGRAMS=(vim tmux curl git nmap);
# not added yet: tig, htop, vifm, zsh, sqlite3

function main () {
	remove_existing
	clone_repo
	install_apt_programs
	mount_usb_and_restore
}

function remove_existing () {
	cd $HOME
	rm -rf $DOTFILES_DIR
	mkdir $DOTFILES_DIR
}

function clone_repo () {
	rm -rf $DOTFILES_DIR
	git clone https://github.com/thegreyfawkes/dotfiles $DOTFILES_DIR
}

function install_apt_programs () {	
	sudo apt-get update
	sudo apt-get -y apt
	sudo apt-get install -y unattended-upgrades apt-listchanges
	sudo apt-get install -y nmap
	sudo apt-get install -y git
	sudo apt-get install -y curl
	sudo apt-get install -y tmux
	sudo apt-get install -y tmuxinator
	sudo apt-get install -y vim
	sudo apt-get install apache2 -y
	sudo apt-get install php7 libapache3-mod-php7
	sudo apt-get install mysql-server mysql-client
	sudo apt-get upgrade -y	
}

function mount_usb_and_restore () {
	sudo mkdir /mnt/usbdrive
	sudo mount /dev/sda1 /mnt/usbdrive
	sudo rsync -av --delete-during /mnt/usbdrive/ /
}


	

