use strict;
use warnings;
use Math::MPFR qw(:mpfr);
use Math::Trig; # for checking results

print "1..13\n";

Rmpfr_set_default_prec(100);

my $angle = 13.2314;
my $inv = 0.5123;
my $hangle = 0.1234;
my $invatanh = 0.991;
my $hinv = 1.4357;

my $sin = Rmpfr_init();
my $cos = Rmpfr_init();
my $tan = Rmpfr_init();
my $asin = Rmpfr_init();
my $acos = Rmpfr_init();
my $atan = Rmpfr_init();
my $sinh = Rmpfr_init();
my $cosh = Rmpfr_init();
my $tanh = Rmpfr_init();
my $asinh = Rmpfr_init();
my $acosh = Rmpfr_init();
my $atanh = Rmpfr_init();
my $b_angle = Rmpfr_init();
my $b_inv = Rmpfr_init();
my $b_hangle = Rmpfr_init();
my $b_invatanh = Rmpfr_init();
my $b_hinv = Rmpfr_init();


Rmpfr_set_d($b_angle, $angle, GMP_RNDN);
Rmpfr_set_d($b_inv, $inv, GMP_RNDN);
Rmpfr_set_d($b_invatanh, $invatanh, GMP_RNDN);
Rmpfr_set_d($b_hinv, $hinv, GMP_RNDN);
Rmpfr_set_d($b_hangle, $hangle, GMP_RNDN);

Rmpfr_sin($sin, $b_angle, GMP_RNDN);
if($sin - sin($angle) < 0.00001 &&
   $sin - sin($angle) > -0.00001) {print "ok 1\n"}
else {print "not ok 1\n"}

Rmpfr_cos($cos, $b_angle, GMP_RNDN);
if($cos - cos($angle) < 0.00001 &&
   $cos - cos($angle) > -0.00001) {print "ok 2\n"}
else {print "not ok 2\n"}

Rmpfr_tan($tan, $b_angle, GMP_RNDN);
if($tan - tan($angle) < 0.00001 &&
   $tan - tan($angle) > -0.00001) {print "ok 3\n"}
else {print "not ok 3\n"}

Rmpfr_asin($asin, $b_inv, GMP_RNDN);
if($asin - asin($inv) < 0.00001 &&
   $asin - asin($inv) > -0.00001) {print "ok 4\n"}
else {print "not ok 4\n"}

Rmpfr_acos($acos, $b_inv, GMP_RNDN);
if($acos - acos($inv) < 0.00001 &&
   $acos - acos($inv) > -0.00001) {print "ok 5\n"}
else {print "not ok 5\n"}

Rmpfr_atan($atan, $b_inv, GMP_RNDN);
if($atan - atan($inv) < 0.00001 &&
   $atan - atan($inv) > -0.00001) {print "ok 6\n"}
else {print "not ok 6\n"}

Rmpfr_sinh($sinh, $b_hangle, GMP_RNDN);
if($sinh - sinh($hangle) < 0.00001 &&
   $sinh - sinh($hangle) > -0.00001) {print "ok 7\n"}
else {print "not ok 7\n"}

Rmpfr_cosh($cosh, $b_hangle, GMP_RNDN);
if($cosh - cosh($hangle) < 0.00001 &&
   $cosh - cosh($hangle) > -0.00001) {print "ok 8\n"}
else {print "not ok 8\n"}

Rmpfr_tanh($tanh, $b_hangle, GMP_RNDN);
if($tanh - tanh($hangle) < 0.00001 &&
   $tanh - tanh($hangle) > -0.00001) {print "ok 9\n"}
else {print "not ok 9\n"}

Rmpfr_asinh($asinh, $b_hinv, GMP_RNDN);
if($asinh - asinh($hinv) < 0.00001 &&
   $asinh - asinh($hinv) > -0.00001) {print "ok 10\n"}
else {print "not ok 10\n"}

Rmpfr_acosh($acosh, $b_hinv, GMP_RNDN);
if($acosh - acosh($hinv) < 0.00001 &&
   $acosh - acosh($hinv) > -0.00001) {print "ok 11\n"}
else {print "not ok 11\n"}

Rmpfr_atanh($atanh, $b_invatanh, GMP_RNDN);
if($atanh - atanh($invatanh) < 0.00001 &&
   $atanh - atanh($invatanh) > -0.00001) {print "ok 12\n"}
else {print "not ok 12\n"}

Rmpfr_sin_cos($sin, $cos, $b_angle, GMP_RNDN);
if($sin - sin($angle) < 0.00001 &&
   $sin - sin($angle) > -0.00001 &&
   $cos - cos($angle) < 0.00001 &&
   $cos - cos($angle) > -0.00001) {print "ok 13\n"}
else {print "not ok 13\n"}

