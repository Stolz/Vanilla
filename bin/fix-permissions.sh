#!/bin/bash

# Set proper file and directory permissions

# Default user and group if none is provided as argument
USER=${1:-$USER}
GROUP=${2:-nginx}

# Go to project base dir
cd $( cd -P "$( dirname "$0" )" && pwd ) && source source.me || exit 1; cd ..

color "Changing permissions for `pwd`"
color "Owner will be set to $USER:$GROUP. Use $0 [user] [group] to customize this" "yellow"

# Wrapper command
if [[ $EUID -ne 0 && -x /usr/bin/sudo ]]; then
	SUDO='sudo'
else
	SUDO=''
fi

# Set owner
$SUDO chown -R "$USER":"$GROUP" .

# Set default safe permissions
$SUDO find . -type d -exec chmod 750 {} \;
$SUDO find . -type f -exec chmod 640 {} \;

# Set exec permission for scripts
$SUDO chmod 750 bin/*.sh vendor/bin/*

exit 0
