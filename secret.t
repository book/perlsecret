#!./perl

# this will be needed for inclusion in the core perl test suite
#BEGIN {
#    chdir 't' if -d 't';
#    @INC = '../lib';
#    require './test.pl';
#}

use Test::More;

use strict;
use Config;

my $UV_MAX = 2**( 8 * $Config{uvsize} ) - 1;
my $UV_MIN = -2**( 8 * $Config{uvsize} );
my $IV_MAX = 2**( 8 * $Config{ivsize} - 1 ) - 1;
my $IV_MIN = -2**( 8 * $Config{ivsize} - 1 );

diag "$UV_MAX $UV_MIN $IV_MAX $IV_MIN";
my ( $got, @got, %got );
my $true  = 1;
my $false = '';

# venus
is( 0+ '23a',       23,   '0+' );
is( 0+ '3.00',      3,    '0+' );
is( 0+ '1.2e3',     1200, '0+' );
is( 0+ '42 EUR',    42,   '0+' );
is( 0+ 'two cents', 0,    '0+' );
ok( ( 0+ [] ) =~ /^[1-9][0-9]*$/, '0+' );

# baby cart
{
    local $" = ',';
    %got = ( 'a' .. 'f' );
    is( "A @{[sort keys %got]} Z", "A a,c,e Z", '@{[ ]}' );
}

# bang bang
is( !!$true,      $true,  '!!' );
is( !!$false,     $false, '!!' );
is( !!'a string', $true,  '!!' );
is( !!undef,      $false, '!!' );

# eskimo greeting
# TODO

# inchworm
$got = time;
is( scalar localtime $got, ~~ localtime $got, '~~' );
@got = localtime;
is( ~~ @got, 9, '~~' );

is( ~~ 1.23, 1, '~~ exception' );    # floating point

$got = '1.23';                       # string
is( ~~ $got, 1, '~~ exception' ) if $got != 0;    # used in numeric context

$got = $UV_MAX + 1;
is( ~~ $got, $UV_MAX, '~~ exception' );
$got = -1;
is( ~~ $got, $UV_MAX, '~~ exception' );

$got = 2**( 8 * $Config{uvsize} - 1 );
{
    use integer;
    is( ~~ $got, $IV_MIN, '~~ exception' );
}
$got = -2**( 8 * $Config{uvsize} - 1 ) - 1;
{
    use integer;
    is( ~~ $got, $IV_MIN, '~~ exception' );
}

# TODO
# show overloading "" example

# backward inchworm on a stick
# forward inchworm on a stick


    # $y = ~-$x * 4;    # identical to $y = ($x-1)*4;

# Exceptions

# space station
is( -+- '23a',       23,   '-+-' );
is( -+- '3.00',      3,    '-+-' );
is( -+- '1.2e3',     1200, '-+-' );
is( -+- '42 EUR',    42,   '-+-' );
ok( ( -+- [] ) =~ /^[1-9][0-9]*$/, '-+-' );

is( -+- 'two cents', '+two cents',    '-+- exception' );
is( -+- '-2B' x 5, '-2B-2B-2B-2B-2B', '-+- exception' );

# goatse
my $n;
$_ = "word2 and word3";
$n =()= /word1|word2|word3/g;
is( $n, 2, '=()=' );
$n =()= "abababab" =~ /a/;
is( $n, 1, '=()=' );
$n =()= "abababab" =~ /a/g;
is( $n, 4, '=()=' );
$n =($got)= "abababab" =~ /a/g;
is( $n, 4, '=()=' );
is( $got, 'a', '=()=' );
$n =(@got)= "abababab" =~ /a/g;
is( $n, 4, '=()=' );
is( "@got", 'a a a a', '=()=' );

done_testing;
