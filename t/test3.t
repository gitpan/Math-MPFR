# Test the functions that became available with MPFR-2.1.0.
use strict;
use warnings;
use Math::MPFR qw(:mpfr);

print "1..24\n";

Rmpfr_set_default_prec(300);
my $rnd = 0;

my $double = 1234567.0987;
my $mpfr_nan = Rmpfr_init();
my $mpfr1 = Rmpfr_init();
my $mpfr2 = Rmpfr_init();
my $v;

my($have_mpz, $have_mpf, $have_mpq, $have_Gmpz,
   $have_Gmpq, $have_Gmpf, $have_gmp) = (0, 0, 0, 0, 0, 0, 0);

eval{require Math::GnuMPz};
if(!$@) {$have_mpz = 1}

eval{require Math::GnuMPf};
if(!$@) {$have_mpf = 1}

eval{require Math::GnuMPq};
if(!$@) {$have_mpq = 1}

eval{require GMP::Mpz};
if(!$@) {$have_Gmpz = 1}

eval{require GMP::Mpq};
if(!$@) {$have_Gmpq = 1}

eval{require GMP::Mpf};
if(!$@) {$have_Gmpf = 1}

eval{require Math::GMP};
if(!$@) {$have_gmp = 1}

Rmpfr_set_d($mpfr1, $double, $rnd);

if($have_mpz) {
  my $ok = '';
  my $z = Math::GnuMPz::Rmpz_init_set_ui(123456);
  my $cmp = Rmpfr_cmp_z($mpfr_nan, $z);
  if(Rmpfr_erangeflag_p() && !$cmp) {$ok .= 'a'}
  Rmpfr_clear_erangeflag();
  if(!Rmpfr_erangeflag_p()) {$ok .= 'b'}
  if(Rmpfr_cmp_z($mpfr1, $z) > 0) {$ok .= 'c'}
  Rmpfr_get_z($z, $mpfr1, $rnd);
  Rmpfr_trunc($mpfr1, $mpfr1);
  if(!Rmpfr_cmp_z($mpfr1, $z)) {$ok .= 'd'}
  Rmpfr_set_d($mpfr1, $double, $rnd); 
  if($ok eq 'abcd') {print "ok 1\n"}
  else {print "not ok 1 $ok\n"}
  }
else {print "ok 1 - skipped - no Math::GnuMPz\n"} 

if($have_mpq) {
  my $ok = '';
  my $q = Math::GnuMPq::Rmpq_init();
  Math::GnuMPq::Rmpq_set_ui($q, 11, 17);
  my $cmp = Rmpfr_cmp_q($mpfr_nan, $q);
  if(Rmpfr_erangeflag_p() && !$cmp) {$ok .= 'a'}
  Rmpfr_clear_erangeflag();
  if(!Rmpfr_erangeflag_p()) {$ok .= 'b'}
  if(Rmpfr_cmp_q($mpfr1, $q) > 0) {$ok .= 'c'}
  if($ok eq 'abc') {print "ok 2\n"}
  else {print "not ok 2 $ok\n"}
  }
else {print "ok 2 - skipped - no Math::GnuMPq\n"} 

if($have_mpf) {
  my $ok = '';
  my $f = Math::GnuMPf::Rmpf_init_set_d(123456.12);
  my $cmp = Rmpfr_cmp_f($mpfr_nan, $f);
  if(Rmpfr_erangeflag_p() && !$cmp) {$ok .= 'a'}
  Rmpfr_clear_erangeflag();
  if(!Rmpfr_erangeflag_p()) {$ok .= 'b'}
  if(Rmpfr_cmp_f($mpfr1, $f) > 0) {$ok .= 'c'}
  if($ok eq 'abc') {print "ok 3\n"}
  else {print "not ok 3 $ok\n"}
  }
else {print "ok 3 - skipped - no Math::GnuMPf\n"} 

if($have_Gmpz) {
  my $ok = '';
  my $z = GMP::Mpz::mpz(123456);
  my $cmp = Rmpfr_cmp_z($mpfr_nan, $z);
  if(Rmpfr_erangeflag_p() && !$cmp) {$ok .= 'a'}
  Rmpfr_clear_erangeflag();
  if(!Rmpfr_erangeflag_p()) {$ok .= 'b'}
  if(Rmpfr_cmp_z($mpfr1, $z) > 0) {$ok .= 'c'}
  if($ok eq 'abc') {print "ok 4\n"}
  else {print "not ok 4 $ok\n"}
  }
else {print "ok 4 - skipped - no GMP::Mpz\n"} 

if($have_Gmpq) {
  my $ok = '';
  my $q = GMP::Mpq::mpq(11/17);
  my $cmp = Rmpfr_cmp_q($mpfr_nan, $q);
  if(Rmpfr_erangeflag_p() && !$cmp) {$ok .= 'a'}
  Rmpfr_clear_erangeflag();
  if(!Rmpfr_erangeflag_p()) {$ok .= 'b'}
  if(Rmpfr_cmp_q($mpfr1, $q) > 0) {$ok .= 'c'}
  if($ok eq 'abc') {print "ok 5\n"}
  else {print "not ok 5 $ok\n"}
  }
else {print "ok 5 - skipped - no GMP::Mpq\n"} 

if($have_Gmpf) {
  my $ok = '';
  my $f = GMP::Mpf::mpf(123456.12);
  my $cmp = Rmpfr_cmp_f($mpfr_nan, $f);
  if(Rmpfr_erangeflag_p() && !$cmp) {$ok .= 'a'}
  Rmpfr_clear_erangeflag();
  if(!Rmpfr_erangeflag_p()) {$ok .= 'b'}
  if(Rmpfr_cmp_f($mpfr1, $f) > 0) {$ok .= 'c'}
  if($ok eq 'abc') {print "ok 6\n"}
  else {print "not ok 6 $ok\n"}
  }
else {print "ok 6 - skipped - no GMP::Mpf\n"} 

if($have_gmp) {
  my $ok = '';
  my $z = Math::GMP->new(123456);
  my $cmp = Rmpfr_cmp_z($mpfr_nan, $z);
  if(Rmpfr_erangeflag_p() && !$cmp) {$ok .= 'a'}
  Rmpfr_clear_erangeflag();
  if(!Rmpfr_erangeflag_p()) {$ok .= 'b'}
  if(Rmpfr_cmp_z($mpfr1, $z) > 0) {$ok .= 'c'}
  Rmpfr_get_z($z, $mpfr1, $rnd);
  Rmpfr_trunc($mpfr1, $mpfr1);
  if(!Rmpfr_cmp_z($mpfr1, $z)) {$ok .= 'd'}
  Rmpfr_set_d($mpfr1, $double, $rnd); 
  if($ok eq 'abcd') {print "ok 7\n"}
  else {print "not ok 7 $ok\n"}
  }
else {print "ok 7 - skipped - no Math::GMP\n"} 

Rmpfr_set_ui_2exp($mpfr2, 5, 3, $rnd);
if($mpfr2 == 40) {print "ok 8\n"}
else {print "not ok 8\n"}

Rmpfr_set_si_2exp($mpfr2, 5, 3, $rnd);
if($mpfr2 == 40) {print "ok 9\n"}
else {print "not ok 9\n"}

Rmpfr_set_si_2exp($mpfr2, 8, -3, $rnd);
if($mpfr2 == 1) {print "ok 10\n"}
else {print "not ok 10\n"}

Rmpfr_sub_si($mpfr2, $mpfr2, -11, $rnd);
if($mpfr2 == 12) {print "ok 11\n"}
else {print "not ok 11\n"}

Rmpfr_si_sub($mpfr2, -11, $mpfr2, $rnd);
if($mpfr2 == -23) {print "ok 12\n"}
else {print "not ok 12\n"}

Rmpfr_mul_si($mpfr2, $mpfr2, -11, $rnd);
if($mpfr2 == 253) {print "ok 13\n"}
else {print "not ok 13\n"}

Rmpfr_div_si($mpfr2, $mpfr2, -11, $rnd);
if($mpfr2 == -23) {print "ok 14\n"}
else {print "not ok 14\n"}

$mpfr2++;

Rmpfr_si_div($mpfr2, -11, $mpfr2, $rnd);
if($mpfr2 == 0.5) {print "ok 15\n"}
else {print "not ok 15\n"}

Rmpfr_mul($mpfr1, $mpfr2, $mpfr2, $rnd);
Rmpfr_sqr($mpfr2, $mpfr2, $rnd);
if($mpfr1 == $mpfr2) {print "ok 16\n"}
else {print "not ok 16\n"}

Rmpfr_const_pi($mpfr1, $rnd);
if(!Rmpfr_zero_p($mpfr1)) {print "ok 17\n"}
else {print "not ok 17\n"}

eval{Rmpfr_free_cache();};
if(!$@) {print "ok 18\n"}
else {print "not ok 18: $@\n"}

eval{$v = Rmpfr_get_version();};
if(!$@ && $v) {print "ok 19\n"}
else {print "not ok 19: $@\n"}

if((Rmpfr_get_emin_min() <= Rmpfr_get_emin_max()) &&
   (Rmpfr_get_emax_min() <= Rmpfr_get_emax_min())) {print "ok 20\n"}
else {print "not ok 20\n"}

Rmpfr_set_d($mpfr1, $double, $rnd);

Rmpfr_rint_ceil($mpfr2, $mpfr1, $rnd);
if($mpfr2 == 1234568) {print "ok 21\n"}
else {print "not ok 21\n"}

Rmpfr_rint_floor($mpfr2, $mpfr1, $rnd);
if($mpfr2 == 1234567) {print "ok 22\n"}
else {print "not ok 22\n"}

Rmpfr_rint_round($mpfr2, $mpfr1, $rnd);
if($mpfr2 == 1234567) {print "ok 23\n"}
else {print "not ok 23\n"}

Rmpfr_rint_trunc($mpfr2, $mpfr1, $rnd);
if($mpfr2 == 1234567) {print "ok 24\n"}
else {print "not ok 24\n"}
