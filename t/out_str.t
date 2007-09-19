use warnings;
use strict;
use Math::MPFR qw(:mpfr);

print "1..3\n";

Rmpfr_set_default_prec(100);

my $str = Math::MPFR->new('3579' x 6);
my $ok = '';

my $ret = Rmpfr_out_str($str, 16, 0, GMP_RNDN);

if($ret == 30) {$ok .= 'a'}
else {print "\nReturned: ", $ret, "\n"}

print "\n";

$ret = Rmpfr_out_str($str, 16, 0, GMP_RNDN, " \n");

if($ret == 30) {$ok .= 'b'}
else {print "Returned: ", $ret, "\n"}

print "\n";

if($ok eq 'ab') {print "ok 1 \n"}
else {print "not ok 1 $ok\n"}

$ok = '';

eval{$ret = Rmpfr_out_str($str, 16, 0);};
$ok .= 'a' if $@ =~ /Wrong number of arguments/;

eval{$ret = Rmpfr_out_str($str, 16, 0, GMP_RNDN, 7, 5);};
$ok .= 'b' if $@ =~ /Wrong number of arguments/;

if($ok eq 'ab') {print "ok 2 \n"}
else {print "not ok 2 $ok\n"}

$ok = '';

my $mpfr = Math::MPFR->new(0.1);

$ok .= 'a' if Rmpfr_integer_string($mpfr, 10, GMP_RNDN) == 0;
$mpfr *= -1;
$ok .= 'b' if Rmpfr_integer_string($mpfr, 10, GMP_RNDN) == 0;
$ok .= 'c' if Rmpfr_integer_string($mpfr, 31, GMP_RNDN) == 0;
$mpfr *= -1;
$ok .= 'd' if Rmpfr_integer_string($mpfr, 5, GMP_RNDN) == 0;

Rmpfr_set_ui($mpfr, 1, GMP_RNDN);

$ok .= 'e' if Rmpfr_integer_string($mpfr, 10, GMP_RNDN) == 1;
$mpfr *= -1;
$ok .= 'f' if Rmpfr_integer_string($mpfr, 10, GMP_RNDN) == -1;
$ok .= 'g' if Rmpfr_integer_string($mpfr, 30, GMP_RNDN) == -1;
$mpfr *= -1;
$ok .= 'h' if Rmpfr_integer_string($mpfr, 6, GMP_RNDN) == 1;

$mpfr += 0.001;

$ok .= 'i' if Rmpfr_integer_string($mpfr, 10, GMP_RNDN) == 1;
$mpfr *= -1;
$ok .= 'j' if Rmpfr_integer_string($mpfr, 10, GMP_RNDN) == -1;
$ok .= 'k' if Rmpfr_integer_string($mpfr, 29, GMP_RNDN) == -1;
$mpfr *= -1;
$ok .= 'l' if Rmpfr_integer_string($mpfr, 7, GMP_RNDN) == 1;

eval {Rmpfr_integer_string($mpfr, 0, GMP_RNDN);};
if($@ =~ /Rmpfr_integer_string/) {$ok .= 'm'}
else {print $@, "\n"}

if($ok eq 'abcdefghijklm') {print "ok 3\n"}
else {print "not ok 3 $ok\n"}



