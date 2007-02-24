use warnings;
use strict;
use Math::MPFR qw(:mpfr);
use Math::BigInt;
use Config;

print "1..9\n";

print "# Using mpfr version ", MPFR_VERSION_STRING, "\n";

my $ui = 123569;
my $si = -19907;
my $d = -1.625;
my $str = '-119.125';

my $ok = '';

my $f00 = new Math::MPFR();
if(Rmpfr_nan_p($f00)) {$ok = 'a'}
Rmpfr_set_ui($f00, $ui, Rmpfr_get_default_rounding_mode());
if($f00 == $ui) {$ok .= 'b'}

my $f01 = new Math::MPFR($ui);
if($f01 == $ui) {$ok .= 'c'}

my $f02 = new Math::MPFR($si);
if($f02 == $si) {$ok .= 'd'}

my $f03 = new Math::MPFR($d);
if($f03 == $d) {$ok .= 'e'}

my $f04 = new Math::MPFR($str);
if($f04 == $str) {$ok .= 'f'}

my $f05 = new Math::MPFR($str, 10);
if($f05 == $str) {$ok .= 'g'}

my $f06 = new Math::MPFR($d);
if($f06 == $d) {$ok .= 'h'}

if($ok eq 'abcdefgh') {print "ok 1\n"}
else {print "not ok 1 $ok\n"}

#############################


$ok = '';

my $f10 = Math::MPFR::new();
if(Rmpfr_nan_p($f10)) {$ok = 'a'}
Rmpfr_set_ui($f10, $ui, Rmpfr_get_default_rounding_mode());
if($f10 == $ui) {$ok .= 'b'}

my $f11 = Math::MPFR::new($ui);
if($f11 == $ui) {$ok .= 'c'}

my $f12 = Math::MPFR::new($si);
if($f12 == $si) {$ok .= 'd'}

my $f13 = Math::MPFR::new($d);
if($f13 == $d) {$ok .= 'e'}

my $f14 = Math::MPFR::new($str);
if($f14 == $str) {$ok .= 'f'}

my $f15 = Math::MPFR::new($str, 10);
if($f15 == $str) {$ok .= 'g'}

my $f16 = Math::MPFR::new($d);
if($f16 == $d) {$ok .= 'h'}

if($ok eq 'abcdefgh') {print "ok 2\n"}
else {print "not ok 2 $ok\n"}

################################

$ok = '';

my $f20 = Math::MPFR->new();
if(Rmpfr_nan_p($f20)) {$ok = 'a'}
Rmpfr_set_ui($f20, $ui, Rmpfr_get_default_rounding_mode());
if($f20 == $ui) {$ok .= 'b'}

my $f21 = Math::MPFR->new($ui);
if($f21 == $ui) {$ok .= 'c'}

my $f22 = Math::MPFR->new($si);
if($f22 == $si) {$ok .= 'd'}

my $f23 = Math::MPFR->new($d);
if($f23 == $d) {$ok .= 'e'}

my $f24 = Math::MPFR->new($str);
if($f24 == $str) {$ok .= 'f'}

my $f25 = Math::MPFR->new($str, 10);
if($f25 == $str) {$ok .= 'g'}

my $f26 = Math::MPFR->new($d);
if($f26 == $d) {$ok .= 'h'}

Rmpfr_set_default_prec(100);
my $f27 = Math::MPFR->new(36028797018964023);
my $f28 = Math::MPFR->new('36028797018964023');

if(defined($Config::Config{use64bitint})) {
  if($f27 == $f28) {$ok .= 'i'}
}
else {
  if($f27 != $f28) {$ok .= 'i'}
}

if($ok eq 'abcdefghi') {print "ok 3\n"}
else {print "not ok 3 $ok\n"}

#############################

my $bi = Math::BigInt->new(123456789);

$ok = '';

eval{my $f30 = Math::MPFR->new(17, 12);};
if($@ =~ /Too many arguments supplied to new\(\) \- expected only two/) {$ok = 'a'}

eval{my $f31 = Math::MPFR::new(17, 12);};
if($@ =~ /Too many arguments supplied to new\(\) \- expected only one/) {$ok .= 'b'}

eval{my $f32 = Math::MPFR->new($str, 12, 7);};
if($@ =~ /Too many arguments supplied to new\(\)/) {$ok .= 'c'}

eval{my $f33 = Math::MPFR::new($str, 12, 7);};
if($@ =~ /Too many arguments supplied to new\(\) \- expected no more than two/) {$ok .= 'd'}

eval{my $f34 = Math::MPFR->new($bi);};
if($@ =~ /Inappropriate argument/) {$ok .= 'e'}

eval{my $f35 = Math::MPFR::new($bi);};
if($@ =~ /Inappropriate argument/) {$ok .= 'f'}

if($ok eq 'abcdef') {print "ok 4\n"}
else {print "not ok 4 $ok\n"}

###############################

$ok = '';

my($gmpf, $gmpq, $gmpz, $gmp) = (0, 0, 0, 0);

eval{require Math::GMPf;};
if(!$@) {$gmpf = 1}

eval{require Math::GMPq;};
if(!$@) {$gmpq = 1}

eval{require Math::GMPz;};
if(!$@) {$gmpz = 1}

eval{require Math::GMP;};
if(!$@) {$gmp = 1}

if($gmpf) {
  my $x = Math::GMPf::new(125.5);
  my $y = Math::MPFR::new($x);
  my $z = Math::MPFR->new($x);

  if($y == $z && $z == 125.5) {print "ok 5\n"}
  else {print "not ok 5 $y $z\n"}
}
else {print "ok 5 - skipped, no Math::GMPf\n"}

if($gmpq) {
  my $x = Math::GMPq::new('251/2');
  my $y = Math::MPFR::new($x);
  my $z = Math::MPFR->new($x);

  if($y == $z && $z == 125.5) {print "ok 6\n"}
  else {print "not ok 6 $y $z\n"}
}
else {print "ok 6 - skipped, no Math::GMPq\n"}

if($gmpz) {
  my $x = Math::GMPz::new(125.5);
  my $y = Math::MPFR::new($x);
  my $z = Math::MPFR->new($x);

  if($y == $z && $z == 125) {print "ok 7\n"}
  else {print "not ok 7 $y $z\n"}
}
else {print "ok 7 - skipped, no Math::GMPz\n"}

if($gmp) {
  my $x = Math::GMP->new(125);
  my $y = Math::MPFR::new($x);
  my $z = Math::MPFR->new($x);

  if($y == $z && $z == 125) {print "ok 8\n"}
  else {print "not ok 8 $y $z\n"}
}
else {print "ok 8 - skipped, no Math::GMP\n"}

my $x = Math::MPFR::new(12345.5);
my $y = Math::MPFR::new($x);
my $z = Math::MPFR->new($x);

if($y == $z && $z == 12345.5) {print "ok 9\n"}
else {print "not ok 9 $y $z\n"}
