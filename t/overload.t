use strict;
use warnings;
use Math::MPFR qw(:mpfr);
use Math::BigInt; # for some error tests

print "1..52\n";

Rmpfr_set_default_prec(200);

my $p = Rmpfr_init();
my $q = Rmpfr_init();

my $ui = (2 ** 31) + 17;
my $negi = -1236;
my $posi = 1238;
my $posd = (2 ** 41) + 11234;
my $negd = -((2 ** 43) - 111);
my $frac = 23.124901;

Rmpfr_set_ui($p, 1234, GMP_RNDN);
Rmpfr_set_si($q, -5678, GMP_RNDN);

my $ok = '';

my $z = $p * $q;
if(Rmpfr_get_str($z, 10,7, GMP_RNDN) eq '-.7006652@7'
   && $z == -7006652
   && "$z" eq '-.7006652@7') {$ok = 'a'}

$z = $p * $ui;
if(Rmpfr_get_str($z, 10, 13, GMP_RNDN) eq '.2649994842610@13'
   && $z == 2649994842610
   && "$z" eq '.264999484261@13') {$ok .= 'b'}

$z = $p * $negi;
if(Rmpfr_get_str($z, 10, 0, GMP_RNDN) eq '-.1525224@7'
   && $z == -1525224
   && "$z" eq '-.1525224@7') {$ok .= 'c'}

$z = $p * $posd;
if(Rmpfr_get_str($z, 10, 0, GMP_RNDN) eq '.2713594711213924@16'
   && $z == 2713594711213924
   && "$z" eq '.2713594711213924@16') {$ok .= 'd'}

$z = $p * $negd;
if(Rmpfr_get_str($z, 10, 0, GMP_RNDN) eq '-.10854378789267698@17'
   && $z == -10854378789267698
   && "$z" eq '-.10854378789267698@17') {$ok .= 'e'}

$z = $p * $frac;
if($z > 28536.12783 && $z < 28536.12784) {$ok .= 'f'}

$z = $p * $posi;
if($z == 1527692) {$ok .= 'g'}

if($ok eq 'abcdefg'
   && Math::MPFR::get_refcnt($z) == 1
   && Math::MPFR::get_refcnt($p) == 1
   && Math::MPFR::get_refcnt($q) == 1) {print "ok 1\n"}
else {print "not ok 1\n"}

$ok = '';

$p *= $q;
if(Rmpfr_get_str($p, 10, 0, GMP_RNDN) eq '-.7006652@7'
   && $p == -7006652
   && "$p" eq '-.7006652@7') {$ok = 'a'}
Rmpfr_set_ui($p, 1234, GMP_RNDN);

$p *= $ui;
if(Rmpfr_get_str($p, 10, 0, GMP_RNDN) eq '.264999484261@13'
   && $p == 2649994842610
   && "$p" eq '.264999484261@13') {$ok .= 'b'}
Rmpfr_set_ui($p, 1234, GMP_RNDN);

$p *= $negi;
if(Rmpfr_get_str($p, 10, 0, GMP_RNDN) eq '-.1525224@7'
   && $p == -1525224
   && "$p" eq '-.1525224@7') {$ok .= 'c'}
Rmpfr_set_ui($p, 1234, GMP_RNDN);

$p *= $posd;
if(Rmpfr_get_str($p, 10, 0, GMP_RNDN) eq '.2713594711213924@16'
   && $p == 2713594711213924
   && "$p" eq '.2713594711213924@16') {$ok .= 'd'}
Rmpfr_set_ui($p, 1234, GMP_RNDN);

$p *= $negd;
if(Rmpfr_get_str($p, 10, 0, GMP_RNDN) eq '-.10854378789267698@17'
   && $p == -10854378789267698
   && "$p" eq '-.10854378789267698@17') {$ok .= 'e'}
Rmpfr_set_ui($p, 1234, GMP_RNDN);

$p *= $frac;
if($p > 28536.12783 && $p < 28536.12784) {$ok .= 'f'}
Rmpfr_set_ui($p, 1234, GMP_RNDN);

$p *= $posi;
if($p == 1527692) {$ok .= 'g'}
Rmpfr_set_ui($p, 1234, GMP_RNDN);

if($ok eq 'abcdefg'
   && Math::MPFR::get_refcnt($p) == 1) {print "ok 2\n"}
else {print "not ok 2\n"}

$ok = '';

$z = $p + $p;
if(Rmpfr_get_str($z, 10, 0, GMP_RNDN) eq '.2468@4'
   && $z == 2468
   && "$z" eq '.2468@4') {$ok = 'a'}

$z = $p + $ui;
if(Rmpfr_get_str($z, 10, 0, GMP_RNDN) eq '.2147484899@10'
   && $z == 2147484899
   && "$z" eq '.2147484899@10') {$ok .= 'b'}

$z = $p + $negi;
if(Rmpfr_get_str($z, 10, 0, GMP_RNDN) eq '-.2@1'
   && $z == -2
   && "$z" eq '-.2@1') {$ok .= 'c'}

$z = $p + $posd;
if(Rmpfr_get_str($z, 10, 0, GMP_RNDN) eq '.219902326802@13'
   && $z == 2199023268020
   && "$z" eq '.219902326802@13') {$ok .= 'd'}

$z = $p + $negd;
if(Rmpfr_get_str($z, 10, 0, GMP_RNDN) eq '-.8796093020863@13'
   && $z == -8796093020863
   && "$z" eq '-.8796093020863@13') {$ok .= 'e'}

$z = $p + $frac;
if($z > 1257.1249 && $z < 1257.124902) {$ok .= 'f'}

$z = $p + $posi;
if($z == 2472) {$ok .= 'g'}

if($ok eq 'abcdefg'
   && Math::MPFR::get_refcnt($p) == 1
   && Math::MPFR::get_refcnt($z) == 1) {print "ok 3\n"}
else {print "not ok 3\n"}

$ok = '';

$p += $p;
if(Rmpfr_get_str($p, 10, 0, GMP_RNDN) eq '.2468@4'
   && $p == 2468
   && "$p" eq '.2468@4') {$ok = 'a'}
Rmpfr_set_ui($p, 1234, GMP_RNDN);

$p += $ui;
if(Rmpfr_get_str($p, 10, 0, GMP_RNDN) eq '.2147484899@10'
   && $p == 2147484899
   && "$p" eq '.2147484899@10') {$ok .= 'b'}
Rmpfr_set_ui($p, 1234, GMP_RNDN);

$p += $negi;
if(Rmpfr_get_str($p, 10, 0, GMP_RNDN) eq '-.2@1'
   && $p == -2
   && "$p" eq '-.2@1') {$ok .= 'c'}
Rmpfr_set_ui($p, 1234, GMP_RNDN);

$p += $posd;
if(Rmpfr_get_str($p, 10, 0, GMP_RNDN) eq '.219902326802@13'
   && $p == 2199023268020
   && "$p" eq '.219902326802@13') {$ok .= 'd'}
Rmpfr_set_ui($p, 1234, GMP_RNDN);

$p += $negd;
if(Rmpfr_get_str($p, 10, 0, GMP_RNDN) eq '-.8796093020863@13'
   && $p == -8796093020863
   && "$p" eq '-.8796093020863@13') {$ok .= 'e'}
Rmpfr_set_ui($p, 1234, GMP_RNDN);

$p += $frac;
if($p > 1257.1249 && $p < 1257.124902) {$ok .= 'f'}
Rmpfr_set_ui($p, 1234, GMP_RNDN);

$p += $posi;
if($p == 2472) {$ok .= 'g'}
Rmpfr_set_ui($p, 1234, GMP_RNDN);

if($ok eq 'abcdefg'
   && Math::MPFR::get_refcnt($p) == 1) {print "ok 4\n"}
else {print "not ok 4\n"}

$ok = '';

$z = $p / $q;
if($z > -0.2174 && $z < -0.2173) {$ok = 'a'}

$z *= $q / $p;
if($z > 0.999 && $z < 1.001) {$ok .= '1'}

$z = $p / $ui;
if($z > 5.7462e-7 && $z < 5.7463e-7) {$ok .= 'b'}

$z *= $ui / $p;
if($z > 0.999 && $z < 1.001) {$ok .= '2'}

$z = $p / $negi;
if($z > -0.998382 && $z < -0.998381) {$ok .= 'c'}

$z *= $negi / $p;
if($z > 0.999 && $z < 1.001) {$ok .= '3'}

$z = $p / $posd;
if($z > 5.6115822e-10  && $z < 5.6115823e-10  ) {$ok .= 'd'}

$z *= $posd / $p;
if($z > 0.999 && $z < 1.001) {$ok .= '4'}

$z = $p / $negd;
if($z > -1.402896e-10  && $z < -1.402895e-10  ) {$ok .= 'e'}

$z *= $negd / $p;
if($z > 0.999 && $z < 1.001) {$ok .= '5'}

$z = $p / $frac;
if($z > 53.36239  && $z < 53.362391  ) {$ok .= 'f'}

$z *= $frac / $p;
if($z > 0.999 && $z < 1.001) {$ok .= '6'}

$z = $p / $posi;
if($z > 0.9967  && $z < 0.9968  ) {$ok .= 'g'}

$z *= $posi / $p;
if($z > 0.999 && $z < 1.001) {$ok .= '7'}

if($ok eq 'a1b2c3d4e5f6g7'
   && Math::MPFR::get_refcnt($p) == 1
   && Math::MPFR::get_refcnt($z) == 1) {print "ok 5\n"}
else {print "not ok 5\n"}

$ok = '';

$p *= $ui;
$p /= $ui;
if($p < 1234.0001 && $p > 1233.9999) {$ok = 'a'}

$p *= $negi;
$p /= $negi;
if($p < 1234.0001 && $p > 1233.9999) {$ok .= 'b'}

$p *= $posd;
$p /= $posd;
if($p < 1234.0001 && $p > 1233.9999) {$ok .= 'c'}

$p *= $negd;
$p /= $negd;
if($p < 1234.0001 && $p > 1233.9999) {$ok .= 'd'}

$p *= $frac;
$p /= $frac;
if($p < 1234.0001 && $p > 1233.9999) {$ok .= 'e'}

$p *= $q;
$p /= $q;
if($p < 1234.0001 && $p > 1233.9999) {$ok .= 'f'}

$p *= $posi;
$p /= $posi;
if($p < 1234.0001 && $p > 1233.9999) {$ok .= 'g'}

if($ok eq 'abcdefg'
   && Math::MPFR::get_refcnt($p) == 1) {print "ok 6\n"}
else {print "not ok 6\n"}

my $c = $p;
if("$c" eq '.1234@4'
   && "$c" eq "$p"
   && $c == $p
   && $c != $q
   && Math::MPFR::get_refcnt($p) == 1
   && Math::MPFR::get_refcnt($c) == 1
   && Math::MPFR::get_refcnt($q) == 1) {print "ok 7\n"}
else {print "not ok 7\n"}

$c *= -1;
if(Rmpfr_get_str(abs($c), 10, 0, GMP_RNDN) eq '.1234@4'
   && Math::MPFR::get_refcnt($c) == 1) {print "ok 8\n"}
else {print "not ok 8\n"}

$ok = adjust($p!=$ui).adjust($p==$ui).adjust($p>$ui).adjust($p>=$ui).adjust($p<$ui)
.adjust($p<=$ui).adjust($p<=>$ui);
if($ok eq '100011-1') {print "ok 9\n"}
else {print "not ok 9\n"}

$ok = adjust($p!=$negi).adjust($p==$negi).adjust($p>$negi).adjust($p>=$negi)
.adjust($p<$negi).adjust($p<=$negi).adjust($p<=>$negi);
if($ok eq '1011001') {print "ok 10\n"}
else {print "not ok 10\n"}

$ok = adjust($p!=$posd).adjust($p==$posd).adjust($p>$posd).adjust($p>=$posd)
.adjust($p<$posd).adjust($p<=$posd).adjust($p<=>$posd);
if($ok eq '100011-1') {print "ok 11\n"}
else {print "not ok 11\n"}

$ok = adjust($p!=$negd).adjust($p==$negd).adjust($p>$negd).adjust($p>=$negd)
.adjust($p<$negd).adjust($p<=$negd).adjust($p<=>$negd);
if($ok eq '1011001') {print "ok 12\n"}
else {print "not ok 12\n"}

$ok = adjust($p!=$frac).adjust($p==$frac).adjust($p>$frac).adjust($p>=$frac)
.adjust($p<$frac).adjust($p<=$frac).adjust($p<=>$frac);
if($ok eq '1011001') {print "ok 13\n"}
else {print "not ok 13\n"}

$ok = adjust($ui!=$p).adjust($ui==$p).adjust($ui>$p).adjust($ui>=$p)
.adjust($ui<$p).adjust($ui<=$p).adjust($ui<=>$p);
if($ok eq '1011001') {print "ok 14\n"}
else {print "not ok 14\n"}

$ok = adjust($negi!=$p).adjust($negi==$p).adjust($negi>$p).adjust($negi>=$p)
.adjust($negi<$p).adjust($negi<=$p).adjust($negi<=>$p);
if($ok eq '100011-1') {print "ok 15\n"}
else {print "not ok 15\n"}

$ok = adjust($posd!=$p).adjust($posd==$p).adjust($posd>$p).adjust($posd>=$p)
.adjust($posd<$p).adjust($posd<=$p).adjust($posd<=>$p);
if($ok eq '1011001') {print "ok 16\n"}
else {print "not ok 16\n"}

$ok = adjust($negd!=$p).adjust($negd==$p).adjust($negd>$p).adjust($negd>=$p)
.adjust($negd<$p).adjust($negd<=$p).adjust($negd<=>$p);
if($ok eq '100011-1') {print "ok 17\n"}
else {print "not ok 17\n"}

$ok = adjust($frac!=$p).adjust($frac==$p).adjust($frac>$p).adjust($frac>=$p)
.adjust($frac<$p).adjust($frac<=$p).adjust($frac<=>$p);
if($ok eq '100011-1'
   && Math::MPFR::get_refcnt($p) == 1) {print "ok 18\n"}
else {print "not ok 18\n"}

Rmpfr_set_ui($q, 0, GMP_RNDN);

if($p && Math::MPFR::get_refcnt($p) == 1) {print "ok 19\n"}
else {print "not ok 19\n"}

if(!$q && Math::MPFR::get_refcnt($q) == 1) {print "ok 20\n"}
else {print "not ok 20\n"}

if(not($q) && Math::MPFR::get_refcnt($q) == 1) {print "ok 21\n"}
else {print "not ok 21\n"}

unless($q || Math::MPFR::get_refcnt($q) != 1) {print "ok 22\n"}
else {print "not ok 22\n"}

$z = $c;
$z *= -1;
if($z == -$c
   && Math::MPFR::get_refcnt($z) == 1
   && Math::MPFR::get_refcnt($c) == 1) {print "ok 23\n"}
else {print "not ok 23\n"}

$ok = '';

$z = $p - $p;
$z += $p;
if($z == $p) {$ok = 'a'}

$z = $p - $ui;
$z += $ui;
if($z == $p) {$ok .= 'b'}

$z = $p - $negi;
$z += $negi;
if($z == $p) {$ok .= 'c'}

$z = $p - $negd;
$z += $negd;
if($z == $p) {$ok .= 'd'}

$z = $p - $posd;
$z += $posd;
if($z == $p) {$ok .= 'e'}

$z = $p - $frac;
$z += $frac;
if($z == $p) {$ok .= 'f'}

$z = $p - $posi;
$z += $posi;
if($z == $p) {$ok .= 'g'}

if($ok eq 'abcdefg'
   && Math::MPFR::get_refcnt($z) == 1
   && Math::MPFR::get_refcnt($p) == 1) {print "ok 24\n"}
else {print "not ok 24\n"}

$ok = '';

$z = $p + $p;
$z -= $p;
if($z == $p) {$ok = 'a'}

$z = $p + $ui;
$z -= $ui;
if($z == $p) {$ok .= 'b'}

$z = $p + $negi;
$z -= $negi;
if($z == $p) {$ok .= 'c'}

$z = $p + $negd;
$z -= $negd;
if($z == $p) {$ok .= 'd'}

$z = $p + $posd;
$z -= $posd;
if($z == $p) {$ok .= 'e'}

$z = $p + $frac;
$z -= $frac;
if($z == $p) {$ok .= 'f'}

$z = $p + $posi;
$z -= $posi;
if($z == $p) {$ok .= 'g'}

if($ok eq 'abcdefg'
   && Math::MPFR::get_refcnt($z) == 1
   && Math::MPFR::get_refcnt($p) == 1) {print "ok 25\n"}
else {print "not ok 25\n"}

$ok = '';

$z = $p - $p;
$z += $p;
if($z == $p) {$ok = 'a'}

$z = $ui - $p;
$z -= $ui;
if($z == -$p) {$ok .= 'b'}

$z = $negi - $p;
$z -= $negi;
if($z == -$p) {$ok .= 'c'}

$z = $negd - $p;
$z -= $negd;
if($z == -$p) {$ok .= 'd'}

$z = $posd - $p;
$z -= $posd;
if($z == -$p) {$ok .= 'e'}

$z = $frac - $p;
$z -= $frac;
if($z == -$p) {$ok .= 'f'}

$z = $posi - $p;
$z -= $posi;
if($z == -$p) {$ok .= 'g'}

if($ok eq 'abcdefg'
   && Math::MPFR::get_refcnt($z) == 1
   && Math::MPFR::get_refcnt($p) == 1) {print "ok 26\n"}
else {print "not ok 26\n"}

$ok = '';

$z = $p + $p;
$z -= $p;
if($z == $p) {$ok = 'a'}

$z = $ui + $p;
$z -= $ui;
if($z == $p) {$ok .= 'b'}

$z = $negi + $p;
$z -= $negi;
if($z == $p) {$ok .= 'c'}

$z = $negd + $p;
$z -= $negd;
if($z == $p) {$ok .= 'd'}

$z = $posd + $p;
$z -= $posd;
if($z == $p) {$ok .= 'e'}

$z = $frac + $p;
$z -= $frac;
if($z == $p) {$ok .= 'f'}

$z = $posi + $p;
$z -= $posi;
if($z == $p) {$ok .= 'g'}

if($ok eq 'abcdefg'
   && Math::MPFR::get_refcnt($z) == 1
   && Math::MPFR::get_refcnt($p) == 1) {print "ok 27\n"}
else {print "not ok 27\n"}

$ok = ($posi!=$p).($posi==$p).($posi>$p).($posi>=$p).($posi<$p).($posi<=$p).($posi<=>$p);
if($ok eq '1011001'
   && Math::MPFR::get_refcnt($p) == 1) {print "ok 28\n"}
else {print "not ok 28\n"}

$ok = ($p!=$posi).($p==$posi).($p>$posi).($p>=$posi).($p<$posi).($p<=$posi).($p<=>$posi);
if($ok eq '100011-1') {print "ok 29\n"}
else {print "not ok 29\n"}

Rmpfr_set_ui($z, 2, GMP_RNDN);

my $root = sqrt($z);
if($root > 1.414 && $root < 1.415
   && Math::MPFR::get_refcnt($z) == 1
   && Math::MPFR::get_refcnt($root) == 1) {print "ok 30\n"}
else {print "not ok 30\n"}

my $root_copy = $root;

$root = $root ** 2;
$root_copy **= 2;

if($root_copy > 1.99999 && $root_copy < 2.00000001
   && $root > 1.99999 && $root < 2.00000001
   && Math::MPFR::get_refcnt($root) == 1
   && Math::MPFR::get_refcnt($root_copy) == 1) {print "ok 31\n"}
else {print "not ok 31\n"}

$z = $root ** -2;

if($z > 0.24999 && $z < 0.25001
   && Math::MPFR::get_refcnt($z) == 1
   && Math::MPFR::get_refcnt($root) == 1) {print "ok 32\n"}
else {print "not ok 32\n"}

$root_copy **= -2;

if($root_copy > 0.24999 && $root_copy < 0.25001
   && Math::MPFR::get_refcnt($root) == 1
   && Math::MPFR::get_refcnt($root_copy)  == 1) {print "ok 33\n"}
else {print "not ok 33\n"}

Rmpfr_set_ui($z, 2, GMP_RNDN);
Rmpfr_set_ui($root, 3, GMP_RNDN);

$p = $z ** $root;

if($p == 8
   && Math::MPFR::get_refcnt($z) == 1
   && Math::MPFR::get_refcnt($p) == 1
   && Math::MPFR::get_refcnt($root) == 1) {print "ok 34\n"}
else {print "not ok 34\n"}

$z **= $root;

if($z == 8
   && Math::MPFR::get_refcnt($root) == 1
   && Math::MPFR::get_refcnt($z)  == 1) {print "ok 35\n"}
else {print "not ok 35\n"}

Rmpfr_set_ui($z, 2, GMP_RNDN);
Rmpfr_set_si($root, -3, GMP_RNDN);

$p = $z ** $root;

if($p == 0.125
   && Math::MPFR::get_refcnt($z) == 1
   && Math::MPFR::get_refcnt($p) == 1
   && Math::MPFR::get_refcnt($root) == 1) {print "ok 36\n"}
else {print "not ok 36\n"}

$z **= $root;

if($z == 0.125
   && Math::MPFR::get_refcnt($root) == 1
   && Math::MPFR::get_refcnt($z)  == 1) {print "ok 37\n"}
else {print "not ok 37\n"}

my $s = sin($p);
$c = cos($p);

$s **= 2;
$c **= 2;

if($s + $c < 1.0001 && $s + $c > 0.9999
   && Math::MPFR::get_refcnt($s) == 1
   && Math::MPFR::get_refcnt($c) == 1) {print "ok 38\n"}
else {print "not ok 38\n"}

Rmpfr_set_ui($c, 10, GMP_RNDN);

$s = log($c);

if($] >= 5.008) {
  my $int = int($s);
  if(int($s) == 2 && $int == 2
    && Math::MPFR::get_refcnt($s) == 1
    && Math::MPFR::get_refcnt($int) == 1) {print "ok 39\n"}
  else {print "not ok 39\n"}
  }
else {print "ok 39 - skipped - no overloading of 'int()' on perl $] \n"}

$s = exp($s);

if($s < 10.0001 && $s > 0.9999
   && Math::MPFR::get_refcnt($s) == 1
   && Math::MPFR::get_refcnt($c) == 1) {print "ok 40\n"}
else {print "not ok 40\n"}

Rmpfr_set_ui($s, 3, GMP_RNDN);

$ok = '';

$c = atan2($s, $ui);
if($c > 1.396983836e-009 && $c < 1.3969839e-009) {$ok = 'a'}

$c = atan2($ui, $s);
if($c > 1.57079632 && $c < 1.57079633) {$ok .= 'b'}

$c = atan2($s, $negi);
my $check = atan2(-$s, -$negi);
if($check == $c) {$ok .= 'c'}

$c = atan2($negi, $s);
if($c > -1.5683692 && $c < -1.5683691) {$ok .= 'd'}

$c = atan2($posi, $s);
if($c > 1.5683730 && $c < 1.5683731) {$ok .= 'e'}

$c = atan2($s, $posi);
if($c > 0.0024232 && $c < 0.0024233) {$ok .= 'f'}

$c = atan2($posd, $s);
if($c > 1.57079632 && $c < 1.57079633) {$ok .= 'g'}

$c = atan2($s, $posd);
if($c > 1.36424204e-012 && $c < 1.36424205e-012) {$ok .= 'h'}

$c = atan2($negd, $s);
if($c > -1.57079633 && $c < -1.57079632) {$ok .= 'i'}

$c = atan2($s, $negd);
$check = atan2(-$s, -$negd);
if($check == $c) {$ok .= 'j'}

$c = atan2($frac, $s);
if($c > 1.4417865 && $c < 1.4417866) {$ok .= 'k'}

$c = atan2($s, $frac);
if($c > 0.1290097624 && $c < 0.1290097625) {$ok .= 'l'}

Rmpfr_set_ui($p, 113, GMP_RNDN);

$c = atan2($s, $p);
if($c > 0.0265424377 && $c < 0.0265424378) {$ok .= 'm'}

if($ok eq 'abcdefghijklm'
  && Math::MPFR::get_refcnt($s) == 1
  && Math::MPFR::get_refcnt($c) == 1
  && Math::MPFR::get_refcnt($p) == 1) {print "ok 41\n"}
else {print "not ok 41\n"}

Rmpfr_set_d($p, 81, GMP_RNDN);
$q = $p ** 0.5;

if($q == 9) {print "ok 42\n"}
else {print "not ok 42\n"}

Rmpfr_set_d($p, 2, GMP_RNDN);
$q = 0.5 ** $p;

if($q == 0.25) {print "ok 43\n"}
else {print "not ok 43\n"}

Rmpfr_set_d($p, 36, GMP_RNDN);

$p **= 0.5;
if($p == 6
   && Math::MPFR::get_refcnt($p) == 1
   && Math::MPFR::get_refcnt($q) == 1) {print "ok 44\n"}
else {print "not ok 44\n"}

my $mbi = Math::BigInt->new(112345);
$ok = '';

eval{$q = $p + $mbi;};
if($@ =~ /Invalid argument/) {$ok = 'a'}
eval{$q = $p * $mbi;};
if($@ =~ /Invalid argument/) {$ok .= 'b'}
eval{$q = $p - $mbi;};
if($@ =~ /Invalid argument/) {$ok .= 'c'}
eval{$q = $p / $mbi;};
if($@ =~ /Invalid argument/) {$ok .= 'd'}
eval{$q = $p ** $mbi;};
if($@ =~ /Invalid argument/) {$ok .= 'e'}
eval{$p += $mbi;};
if($@ =~ /Invalid argument/) {$ok .= 'f'}
eval{$p *= $mbi;};
if($@ =~ /Invalid argument/) {$ok .= 'g'}
eval{$p -= $mbi;};
if($@ =~ /Invalid argument/) {$ok .= 'h'}
eval{$p /= $mbi;};
if($@ =~ /Invalid argument/) {$ok .= 'i'}
eval{$p **= $mbi;};
if($@ =~ /Invalid argument/) {$ok .= 'j'}

if($ok eq 'abcdefghij') {print "ok 45\n"}
else {print "not ok 45\n"}

$mbi = "this is a string";
$ok = '';

eval{$q = $p + $mbi;};
if($@ =~ /Invalid string/) {$ok = 'a'}
eval{$q = $p * $mbi;};
if($@ =~ /Invalid string/) {$ok .= 'b'}
eval{$q = $p - $mbi;};
if($@ =~ /Invalid string/) {$ok .= 'c'}
eval{$q = $p / $mbi;};
if($@ =~ /Invalid string/) {$ok .= 'd'}
eval{$q = $p ** $mbi;};
if($@ =~ /Invalid string/) {$ok .= 'e'}
eval{$p += $mbi;};
if($@ =~ /Invalid string/) {$ok .= 'f'}
eval{$p *= $mbi;};
if($@ =~ /Invalid string/) {$ok .= 'g'}
eval{$p -= $mbi;};
if($@ =~ /Invalid string/) {$ok .= 'h'}
eval{$p /= $mbi;};
if($@ =~ /Invalid string/) {$ok .= 'i'}
eval{$p **= $mbi;};
if($@ =~ /Invalid string/) {$ok .= 'j'}
eval{if($q >$mbi){};};
if($@ =~ /Invalid string/) {$ok .= 'k'}
eval{if($q <$mbi){};};
if($@ =~ /Invalid string/) {$ok .= 'l'}
eval{if($p >= $mbi){};};
if($@ =~ /Invalid string/) {$ok .= 'm'}
eval{if($p <= $mbi){};};
if($@ =~ /Invalid string/) {$ok .= 'n'}
eval{if($p <=> $mbi){};};
if($@ =~ /Invalid string/) {$ok .= 'o'}
eval{if($p == $mbi){};};
if($@ =~ /Invalid string/) {$ok .= 'p'}
eval{if($p != $mbi){};};
if($@ =~ /Invalid string/) {$ok .= 'q'}

if($ok eq 'abcdefghijklmnopq') {print "ok 46\n"}
else {print "not ok 46\n"}

$mbi = "-111111111111112.34567879";
Rmpfr_set_si($p, 1234, GMP_RNDN);

$q = $p + $mbi;
$p = $q - $mbi;
$q = $p * $mbi;
$p = $q / $mbi;

if($p == 1234
   && Math::MPFR::get_refcnt($p) == 1
   && Math::MPFR::get_refcnt($q) == 1) {print "ok 47\n"}
else {print "not ok 47\n"}

$p *= $mbi;
$p /= $mbi;
$p += $mbi;
$p -= $mbi;

if($p == 1234
   && Math::MPFR::get_refcnt($p) == 1
   && Math::MPFR::get_refcnt($q) == 1) {print "ok 48\n"}
else {print "not ok 48\n"}

$q = $mbi + $p;
$p = $mbi - $q;

if($p == -1234
   && Math::MPFR::get_refcnt($p) == 1
   && Math::MPFR::get_refcnt($q) == 1) {print "ok 49\n"}
else {print "not ok 49\n"}

$q = $mbi * $p;
$p = $mbi / $q;

if($p < -0.00081 && $p > -0.000811
   && Math::MPFR::get_refcnt($p) == 1
   && Math::MPFR::get_refcnt($q) == 1) {print "ok 50\n"}
else {print "not ok 50\n"}

Rmpfr_set_str($p, "1234567.123", 10, GMP_RNDN);

if($p > $mbi &&
   $p >= $mbi &&
   $mbi < $p &&
   $mbi <= $p &&
   ($p <=> $mbi) > 0 &&
   ($mbi <=> $p) < 0 &&
   $p != $mbi &&
   !($p == $mbi) &&
   Math::MPFR::get_refcnt($p) == 1) {print "ok 51\n"}
else {print "not ok 51\n"}

$mbi = \$p;
$ok = '';

eval{$q = $p + $mbi;};
if($@ =~ /Invalid argument/) {$ok = 'a'}
eval{$q = $p * $mbi;};
if($@ =~ /Invalid argument/) {$ok .= 'b'}
eval{$q = $p - $mbi;};
if($@ =~ /Invalid argument/) {$ok .= 'c'}
eval{$q = $p / $mbi;};
if($@ =~ /Invalid argument/) {$ok .= 'd'}
eval{$q = $p ** $mbi;};
if($@ =~ /Invalid argument/) {$ok .= 'e'}
eval{$p += $mbi;};
if($@ =~ /Invalid argument/) {$ok .= 'f'}
eval{$p *= $mbi;};
if($@ =~ /Invalid argument/) {$ok .= 'g'}
eval{$p -= $mbi;};
if($@ =~ /Invalid argument/) {$ok .= 'h'}
eval{$p /= $mbi;};
if($@ =~ /Invalid argument/) {$ok .= 'i'}
eval{$p **= $mbi;};
if($@ =~ /Invalid argument/) {$ok .= 'j'}

if($ok eq 'abcdefghij') {print "ok 52\n"}
else {print "not ok 52\n"}


sub adjust {
    if($_[0]) {
      if($_[0] > 0) { return 1}
      return -1;
      }
    return 0;
}

