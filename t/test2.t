use strict;
use warnings;
use Math::MPFR qw(:mpfr);

print "1..5\n";

print "# Using mpfr version ", MPFR_VERSION_STRING, "\n";

my $have_gmp = 0;
my $c = Rmpfr_init();
my $check2 = Rmpfr_init();
my $z;

Rmpfr_set_default_prec(300);

eval{require Math::GMP};
if(!$@) {$have_gmp = 1}

if($have_gmp) {
  $z = Math::GMP->new("1123");
  Rmpfr_set_z($c, $z, GMP_RNDN);
  if($c == 1123 && Math::MPFR::get_refcnt($z) == 1
     && Math::MPFR::get_package_name($z) eq "Math::GMP") {print "ok 1\n"}
  else {print "not ok 1\n"}
  }
else {print "ok 1 - skipped - no Math::GMP\n"}

if($have_gmp) {
  Rmpfr_set_prec($c, 53);
  Rmpfr_set_ui($c, 2, GMP_RNDN);
  $z = Math::GMP->new(0);
  my $exp = Rmpfr_get_z_exp($z, $c);
  if($exp == -51 && "$z" eq '4503599627370496'
     && Math::MPFR::get_package_name($z) eq "Math::GMP") {print "ok 2\n"}
  else {print "not ok 2\n"}
  }
else {print "ok 2 - skipped - no Math::GMP\n"}

if($have_gmp) {
  $z = Math::GMP->new(11234);
  Rmpfr_set_prec($c, 300);
  Rmpfr_set_ui($c, 237, GMP_RNDN);
  Rmpfr_div_z($check2, $c, $z, GMP_RNDN);
  Rmpfr_mul_z($check2, $check2, $z, GMP_RNDN);
  if($check2 - $c > -0.000001 
     && $check2 - $c < 0.000001
     && Math::MPFR::get_package_name($z) eq "Math::GMP") {print "ok 3\n"}
  else {print "not ok 3\n"}
  }
else {print "ok 3 - skipped - no Math::GMP\n"}

if($have_gmp) {
  $z = Math::GMP->new("1123");
  my ($c, $cmp) = Rmpfr_init_set_z($z, GMP_RNDN);
  if($c == 1123 && Math::MPFR::get_refcnt($z) == 1
     && Math::MPFR::get_package_name($z) eq "Math::GMP") {print "ok 4\n"}
  else {print "not ok 4\n"}
  }
else {print "ok 4 - skipped - no Math::GMP\n"}

if($have_gmp) {
  $z = Math::GMP->new(17);
  Rmpfr_set($check2, $c, GMP_RNDN);

  Rmpfr_add_z($c, $c, $z, GMP_RNDN);
  Rmpfr_sub_z($c, $c, $z, GMP_RNDN);
 
  if($c == $check2) {print "ok 5\n"}
  else {print "not ok 5\n"}
  }
else {print "ok 5 - skipped - no Math::GMP\n"}

