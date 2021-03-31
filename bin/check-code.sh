#!/bin/bash

# Wrapper script to invoke these popular quality assurance tools with sane defaults:
#  - PHP CodeSniffer https://github.com/squizlabs/PHP_CodeSniffer
#  - PHP Compatibility https://github.com/PHPCompatibility/PHPCompatibility
#  - PHP Mess Detector https://phpmd.org
#  - PHP Native Linter
#  - PHP Stan https://phpstan.org
#  - Slevomat Coding Standards https://github.com/slevomat/coding-standard

include_dirs="app,resources,tests"
exclude_dirs="bin,docs,node_modules,vendor"
phpcs="./vendor/bin/phpcs . -s --standard=phpcodesniffer.xml --ignore=$exclude_dirs --report-width=120 --tab-width=4"

# Go to project base dir
cd $( cd -P "$( dirname "$0" )" && pwd ) && source source.me || exit 1; cd ..

# Show script help
function usage
{
	color "Usage:" "yellow"
	echo
	color "    $0 -l | -S | -s [sniffs] | -i [sniffs] | -m | -h" "cyan"
	echo
	color "where:" "yellow"
	echo
	color "    -l: Run PHP linter" "cyan"
	color "    -S: Run PHP Stan" "cyan"
	color "    -s: Run PHP Code Sniffer" "cyan"
	color "    -i: Run PHP Code Sniffer (interactive mode)" "cyan"
	color "    -m: Run PHP Mess Detector" "cyan"
	color "    -h: Show usage help" "cyan"
	echo
	color "and:" "yellow"
	echo
	color "    [sniffs] A comma separated lists of sniffs to filter by" "cyan"
}

# Run PHP Linter
function linter
{
	color "Running PHP lint" cyan
	find . -type f -iname "*.php" -not -path "./vendor/*" -print0 | xargs -0 -n1 -P$(nproc) php -lnf | grep "Parse error:"
	if [[ $? -eq 0 ]]; then
		exit_error "Files listed above contain syntax errors"
	else
		color OK
		exit 0
	fi
}

# Run PHP Stan
function stan
{
	color "Running PHP Stan" cyan
	./vendor/bin/phpstan analyse --memory-limit=0 --ansi $@
	exit $?
}

# Run PHP_CodeSniffer interactive mode
function isniffer
{
	[[ -z $1 ]] && sniffs="" || sniffs="--sniffs=$1"

	color "Running PHP_CodeSniffer in interactive mode" cyan
	$phpcs -a $sniffs
	color OK
	exit 0
}

# Run PHP_CodeSniffer
function sniffer
{
	[[ -z $1 ]] && sniffs="" || sniffs="--sniffs=$1"

	color "Running PHP_CodeSniffer" cyan
	$phpcs -p --report-source $sniffs

	if [[ $? -ne 0 ]]; then
		color "Standard coding violations found" red
		color "Press ENTER to run sniffer in interactive mode or CONTROL+C to cancel" yellow
		color "Provide a comma separated list of rules (sniffs) if you want to limit results" yellow
		read newsniffs

		# If no new sniffs provided use original ones
		[[ -z $newsniffs ]] && sniffs="$1" || sniffs="$newsniffs"

		isniffer $sniffs
	else
		color OK
		exit 0
	fi
}

# Run PHP Mess Detector
function detectmess
{
	# If no ruleset is provide usa all
	local rulesets="${1:-cleancode,codesize,controversial,design,naming,unusedcode}"
	color "Running PHP Mess Detector with rulesets: $rulesets" cyan
	./vendor/bin/phpmd $include_dirs text $rulesets -suffixes .php
	exit $?
}

# Show wrong parameters message
function wrong_parameters
{
	color "ERROR: Wrong parameters" "red"
	usage
	exit 1;
}

# Read command line parameters
while getopts "lSsimh" opt; do
case $opt in
	l)
	linter
	;;

	S)
	stan
	;;

	s)
	sniffer $2
	;;

	i)
	isniffer $2
	;;

	m)
	detectmess $2
	;;

	h)
	usage
	exit 0
	;;

	\?)
	wrong_parameters
	;;
esac
done

[[ $OPTIND -eq 0 ]] || wrong_parameters
