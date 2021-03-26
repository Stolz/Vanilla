#!/bin/bash

# Delete obsolete files (editor backup files and Git merge conflicts remains)

# Go to project base dir
cd $( cd -P "$( dirname "$0" )" && pwd ) && source source.me || exit 1; cd ..

color "Deleting obsolete files in `pwd`" red
color "Press ENTER to continue or CONTROL+C to cancel" yellow
read

# Remove editor backps
find . -type f \( -name ".*~" -o -name "*~" \) -exec rm {} \;

# Remove Git merge conflicts remains
for ext in php mo po json; do
	find . -type f \( -name "*.$ext.orig" -o -name "*.$ext.BACKUP.*.$ext" -o -name "*.$ext.BASE.*.$ext" -o  -name "*.$ext.LOCAL.*.$ext" -o -name "*.$ext.REMOTE.*.$ext" \) -exec rm -i {} \;
done

exit 0
