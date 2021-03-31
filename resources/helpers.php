<?php declare(strict_types=1);

use Symfony\Component\VarDumper\Cloner\VarCloner;
use Symfony\Component\VarDumper\Dumper\CliDumper;

if (! function_exists('dd')) {
    /**
     * Dump the passed values and end the script.
     *
     * @return void
     */
    function dd()
    {
        array_map(function ($value) {
            if (class_exists(CliDumper::class)) {
                (new CliDumper)->dump((new VarCloner)->cloneVar($value));
            } else {
                var_dump($value);
            }
        }, func_get_args());
        die(1);
    }
}
