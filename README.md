# Stolz/Vanilla

Skeleton for a vanilla PHP project. It does not contain any business logic other than the traditional 'Hello world'. However, several popular development tools have been installed and configured such:

- [PHP Stan](https://phpstan.org) and [PHP Mess Detector](https://phpmd.org) for static code analysis.
- [PHP Compatibility](https://github.com/PHPCompatibility/PHPCompatibility) and [Slevomat](https://github.com/slevomat/coding-standard) to enforce common code standards beyond [PSR](https://www.php-fig.org/psr/).
- [PHP CodeSniffer](https://github.com/squizlabs/PHP_CodeSniffer) and [PHP CS Fixer](https://github.com/FriendsOfPHP/PHP-CS-Fixer) to detect code standards violations and automatically fix them.
- [Collision](https://github.com/nunomaduro/collision) to enhance error messages.
- [PHPUnit](https://github.com/sebastianbergmann/phpunit) to write and run automatic code tests.
- [Symfony Var Dumper](https://symfony.com/doc/current/components/var_dumper.html) for non-interactive debugging.
- [Psysh](https://psysh.org/) for interactive debugging.

For every tool there is an associated [Composer](https://getcomposer.org) script with a mnemonic name that will run the tool with sane defaults already applied.

## Installation

Clone this repository

	git clone git@github.com:Stolz/Vanilla.git my-project
	cd my-project

Install dependencies in a development environment

	composer build

Install dependencies in a production environment

	composer build-prod

## Usage

Start the application in the CLI

	composer start-cli

Start the application in the PHP built-in web server at <http://localhost:8000>

	composer start-web

Start the application in the interactive debugger console

	composer cli

## Testing tools

List available test suites and default test suites

	composer test-list
	composer test-list-default

Run all tests on the default suites

	composer test       # no code coverage calculation
	composer test-cover # code coverage calculation

Run all tests on a file

	composer test tests/Unit/ExampleTest.php

Run all tests on a directory

	composer test tests/Unit

Run a single test on a single file

	composer test --filter testExample tests/Unit/ExampleTest.php

Run all tests on certain test suites only

	composer test --testsuite Unit,Functional

## Static code analysis tools

Check code with PHP linter

	composer lint

Check code with [CodeSniffer](https://github.com/squizlabs/PHP_CodeSniffer)

	composer sniff

Check code with [Stan](https://phpstan.org)

	composer stan

Check code with [Mess Detector](https://phpmd.org)

	composer mess

Fix code with [CS Fixer](https://github.com/FriendsOfPHP/PHP-CS-Fixer) and [CodeSniffer](https://github.com/squizlabs/PHP_CodeSniffer)

	composer fix <pathToFile>

## Misc tools

Get some stats about the code using [Cloc](https://github.com/AlDanial/cloc)

	composer stats

Fix filesystem permissions and owner

	composer secure

Delete obsolete files (editor backup files and Git merge conflicts remains)

	composer clean

Lint + check standards + test

	composer hook

## License

The MIT License (MIT). Please see [LICENSE file](LICENSE.md) for more information.
