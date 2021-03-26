#!/bin/bash

# Automatically fix errors in PHP files using:
# - https://github.com/FriendsOfPHP/PHP-CS-Fixer
# - https://github.com/squizlabs/PHP_CodeSniffer

# Go to project base dir
cd $( cd -P "$( dirname "$0" )" && pwd ) && source source.me || exit 1; cd ..

# Check parameters
if [ $# -ne 1 ]; then
	exit_error "You must pass one and only one file or folder as a parameter"
fi

# For a list of all available rules run: ./vendor/bin/php-cs-fixer fix --help
./vendor/bin/php-cs-fixer fix -v "$@"  # --rules=some_rule,-disable_another_rule

./vendor/bin/phpcbf --standard=phpcodesniffer.xml "$@"

exit 0
