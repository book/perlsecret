#!./perl

# this will be needed for inclusion in the core perl test suite
#BEGIN {
#    chdir 't' if -d 't';
#    @INC = '../lib';
#    require './test.pl';
#}

use Test::More;

use strict;
use warnings;
use Config;

plan skip_all =>
  "'bitwise feature was introduced in Perl 5.022, this is only $]"
  if $] < 5.022;

my ( $UV_MAX, $UV_MIN, $IV_MAX, $IV_MIN );
$UV_MAX += 2** $_ for 0 .. 8 * $Config{uvsize} - 1; # avoid overflowing
$UV_MIN = 0;
$IV_MAX = 2**( 8 * $Config{ivsize} - 1 ) - 1;
$IV_MIN = -2**( 8 * $Config{ivsize} - 1 );
# diag "$UV_MAX $UV_MIN $IV_MAX $IV_MIN";

(my $uvuformat = "%" . $Config{uvuformat}) =~ tr/"//d;
(my $ivdformat = "%" . $Config{ivdformat}) =~ tr/"//d;

my ( $got, @got, %got );
my $true  = 1;
my $false = '';
my $zero  = 0;
my $undef = undef;

# 'bitwise' feature was experimental until 5.028
no if $] < 5.028, warnings => 'experimental';
use feature 'bitwise';

# key to the truth
is( 0+!!$true,      $true, '0+!!' );
is( 0+!!$false,     $zero, '0+!!' );
is( 0+!!$zero,      $zero, '0+!!' );
is( 0+!!'a string', $true, '0+!!' );
is( 0+!!$undef,     $zero, '0+!!' );

# serpent of truth
is( ~~!!$true,      $true, '~~!!' );
is( ~~!!$false,     $zero, '~~!!' );
is( ~~!!$zero,      $zero, '~~!!' );
is( ~~!!'a string', $true, '~~!!' );
is( ~~!!$undef,     $zero, '~~!!' );

# inchworm
{
    no warnings 'numeric';
    $got = time;
    is( ~~ localtime $got, 0, '~~' );
}

@got = localtime;
is( ~~ @got, 9, '~~' );

is( ~~ 1.23, 1, '~~ exception' );    # floating point

$got = '1.23';                       # string
is( ~~ $got, 1, '~~ exception' ) if $got != 0;    # used in numeric context

$got = $UV_MAX + 1;
is( ~~ $got, sprintf($uvuformat, $UV_MAX), '~~ exception' );
$got = -1;
is( ~~ $got, sprintf($uvuformat, $UV_MAX), '~~ exception' );

$got = 2**( 8 * $Config{uvsize} - 1 );
{
    use integer;
    is( ~~ $got, sprintf($ivdformat, $IV_MIN), '~~ exception' );
}
$got = -2**( 8 * $Config{uvsize} - 1 ) - 1;
{
    use integer;
    is( ~~ $got, sprintf($ivdformat, $IV_MIN), '~~ exception' );
}

# backward inchworm on a stick
for my $val ( $IV_MAX, $IV_MIN + 1, 0, 1, -1 ) {
    $got = $val;
    if( $val <= 0 ) {
        use integer;
        is( ~- $got, $val - 1, '~-' );
    }
    elsif( $Config{'use64bitint'} ) {
        TODO: {
            local $TODO = 'fails with use64bitint';
            is( ~- $got, $val - 1, '~-' ); # TODO
        }
    }
    else {
        is( ~- $got, $val - 1, '~-' );
    }
}

# forward inchworm on a stick
for my $val ( $IV_MAX -1 , $IV_MIN, 0, 1, -1 ) {
    $got = $val;
    if( $val >= 0 ) {
        use integer;
        is( -~ $got, $val + 1, '-~' );
    }
    elsif( $Config{'use64bitint'} ) {
        TODO: {
            local $TODO = 'fails with use64bitint';
            is( -~ $got, $val + 1, '-~' );
        }
    }
    else {
        is( -~ $got, $val + 1, '-~' );
    }
}

# kite
{
    no warnings 'numeric';
    @got = ( ~~<DATA>, ~~<DATA> );
    is( "@got", "31337 0", '~~<>' );
    @got = ( ~~<DATA> );    # return '' instead of undef at EOF
    is( "@got", '0', '~~<>' );
}

done_testing;

__DATA__
31337 is eleet
camel
llama
