<?php declare(strict_types=1);

// Improve error messages
if (php_sapi_name() === 'cli') {
    (new \NunoMaduro\Collision\Provider)->register();
} else {
    (new \Whoops\Run)->pushHandler(new \Whoops\Handler\PrettyPageHandler)->register();
}

// NOTE: For interactive debugging just drop this line in where you'd like to have a breakpoint:
// eval(\Psy\sh());
