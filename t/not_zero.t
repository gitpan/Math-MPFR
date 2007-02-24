# Just some additional tests to check that ~0, unsigned and signed longs are 
# are being handled as expected.

use warnings;
use strict;
use Math::MPFR qw(:mpfr);
use Config;

print"1..5\n";

print "# Using mpfr version ", MPFR_VERSION_STRING, "\n";

Rmpfr_set_default_prec(65);

my $n = ~0;

my $mpfr1 = Math::MPFR::new($n);
my $mpfr2 = Math::MPFR->new($n);
my ($mpfr3, $info3) = Rmpfr_init_set_ui($n, GMP_RNDN);
my ($mpfr4, $info4) = Rmpfr_init_set_si($n, GMP_RNDN);

if($mpfr4 == -1) {print "ok 1\n"}
else {print "not ok 1\n"}

if($mpfr1 == $n &&
   $mpfr2 == $n ) {print "ok 2\n"}
else {print "not ok 2\n"}

if(Math::MPFR::_has_longlong() &&
   $Config::Config{longsize} == 4) {
   if($mpfr3 != $n) {print "ok 3 A\n"}
   else {print "not ok 3 A $mpfr3 == $n\n"}
}

else {
  if($n == $mpfr3) {print "ok 3 B \n"}
  else {print "not ok 3 B $mpfr3 != $n\n"}
}

my $ok = '';

# Check the overloaded operators.

if($mpfr1 - 1 == $n - 1) {$ok .= 'a'}

$mpfr1 -= 1;

if($mpfr1 == $n - 1) {$ok .= 'b'}

$mpfr1 = $mpfr1 / 2;

if($mpfr1 == ($n - 1) / 2) {$ok .= 'c'}

$mpfr1 = $mpfr1 * 2;

if($mpfr1 == $n - 1) {$ok .= 'd'}

$mpfr1 /= 2;

if($mpfr1 == ($n - 1) / 2) {$ok .= 'e'} 

$mpfr1 *= 2;

if($mpfr1 == $n - 1) {$ok .= 'f'}

if($mpfr1 + 1 == $n) {$ok .= 'g'}

$mpfr1 += 1;

if($mpfr1 == $n) {$ok .= 'h'}

my $bits = Math::MPFR::_has_longlong() ? 32 : 16;

if($mpfr1 ** 0.5 < 2 ** $bits &&
   $mpfr1 ** 0.5 > (2 ** $bits) - 1 ) {$ok .= 'i'}

$mpfr1 **= 0.5;

if($mpfr1 < 2 ** $bits &&
   $mpfr1 > (2 ** $bits) - 1) {$ok .= 'j'}

if($ok eq 'abcdefghij') {print "ok 4\n"}
else {print "not ok 4 $ok\n"}

if(Math::MPFR::_has_longlong()) {
  my $ul = Rmpfr_get_uj($mpfr2, GMP_RNDN);
  if($ul == $n) {print "ok 5\n"}
  else {print "not ok 5 $ul != $n\n"}
}
else {print "ok 5 - skipped, not using 'long long' support\n"}

