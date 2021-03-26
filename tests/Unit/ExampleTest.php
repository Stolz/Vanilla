<?php

namespace Tests\Unit;

final class ExampleTest extends \Tests\TestCase
{
    /**
     * Example of a unit test.
     *
     * @return void
     */
    public function testExample(): void
    {
        $expected = 'foo';
        $actual = \App\Example::repeat($expected);

        $this->assertEquals($expected, $actual);
    }
}
