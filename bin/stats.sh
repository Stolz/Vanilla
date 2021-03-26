#!/bin/bash

# Get some stats about the code using https://github.com/AlDanial/cloc

# Go to project base dir
cd $( cd -P "$( dirname "$0" )" && pwd ) && source source.me || exit 1; cd ..

command -v cloc >/dev/null 2>&1 || exit_error "'cloc' program not found. Install it from https://github.com/AlDanial/cloc"
DIRS='app bin resources tests'

echo
color "Code stats (lines)" purple
cloc $DIRS

echo
color "Code stats (percentage)" purple
cloc $DIRS --by-percent c
