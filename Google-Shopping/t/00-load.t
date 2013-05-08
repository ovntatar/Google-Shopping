#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'Google::Shopping' ) || print "Bail out!\n";
}

diag( "Testing Google::Shopping $Google::Shopping::VERSION, Perl $], $^X" );
