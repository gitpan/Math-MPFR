
use strict;
use warnings;
use Math::MPFR qw(:mpfr);
use Config;

print "1..77\n";

my $double = 12345.5;
my $ui = 4;
my $si = -1369012;

my($have_mpz, $have_mpf, $have_mpq, $have_gmp, $have_Gmpz,
   $have_Gmpq, $have_Gmpf) = (0, 0, 0, 0, 0, 0, 0);

eval{require Math::GnuMPz};
if(!$@) {$have_mpz = 1}

eval{require Math::GnuMPf};
if(!$@) {$have_mpf = 1}

eval{require Math::GnuMPq};
if(!$@) {$have_mpq = 1}

eval{require Math::GMP};
if(!$@) {$have_gmp = 1}

eval{require GMP::Mpz};
if(!$@) {$have_Gmpz = 1}

eval{require GMP::Mpq};
if(!$@) {$have_Gmpq = 1}

eval{require GMP::Mpf};
if(!$@) {$have_Gmpf = 1}

my($z, $f, $q);

if($have_mpz) {$z = Math::GnuMPz::Rmpz_init_set_str('aaaaaaaaaaaaaaaaaaaa', 36)}
if($have_mpq) {
  $q = Math::GnuMPq::Rmpq_init();
  Math::GnuMPq::Rmpq_set_str($q, 'qqqqqqqqqqqqqq/12345z', 36);
  Math::GnuMPq::Rmpq_canonicalize($q);
  }
if($have_mpf) {$f = Math::GnuMPf::Rmpf_init_set_str('zzzzzzzzzzzzz123@-5', 36)}

if(Rmpfr_get_default_prec() == 53) {print "ok 1\n"}
else {print "not ok 1\n"}

Rmpfr_set_default_prec(101);
if(Rmpfr_get_default_prec() == 101) {print "ok 2\n"}
else {print "not ok 2\n"}

if(Rmpfr_min_prec() > 0 && Rmpfr_max_prec() > Rmpfr_min_prec()) {print "ok 3\n"}
else {print "not ok 3\n"}

my $c = Rmpfr_init();
my $d = Rmpfr_init2(300);
my $e = Rmpfr_init2(300);
my $check = Rmpfr_init2(300);
my $check2 = Rmpfr_init2(300);
my $check3 = Rmpfr_init2(300);
my $angle = Rmpfr_init2(300);
my $unity = Rmpfr_init2(300);
my $s = Rmpfr_init2(300);
my $t = Rmpfr_init2(300);

Rmpfr_set_d($angle, 3.217, GMP_RNDN);
Rmpfr_set_ui($unity, 1, GMP_RNDN);
#print Rmpfr_get_prec($c), "\n";

if(Rmpfr_get_prec($c) >= 101 && Rmpfr_get_prec($c) < 300 && Rmpfr_get_prec($d) >= 300) {print "ok 4\n"}
else {print "not ok 4\n"}

Rmpfr_set_prec($c, 300);
if(Rmpfr_get_prec($c) >= 300) {print "ok 5\n"}
else {print "not ok 5\n"}

Rmpfr_set_str($c, 'afsder.dgk1111111111111111111116', 36, GMP_RNDZ);

my $s3 = Rmpfr_get_str($c, 16, 0, GMP_RNDU);
my $s4 = Rmpfr_get_str($c, 16, 0, GMP_RNDD);

if($s3 ne $s4) {print "ok 6\n"}
else {print "not ok 6\n"}

Rmpfr_set($d, $c, GMP_RNDD);

$s3 = Rmpfr_get_str($d, 16, 0, GMP_RNDU);
$s4 = Rmpfr_get_str($d, 16, 0, GMP_RNDD);

if($s3 ne $s4) {print "ok 7\n"}
else {print "not ok 7\n"}

Rmpfr_set_d($c, $double, GMP_RNDN);

if(Rmpfr_get_d($c, GMP_RNDN) == $double) {print "ok 8\n"}
else {print "not ok 8\n"}

if(Rmpfr_get_d1($c) == $double) {print "ok 9\n"}
else {print "not ok 9\n"}

if($have_mpz) {
  Rmpfr_set_z($c, $z, GMP_RNDN);
  if(Rmpfr_get_str($c, 36, 20, GMP_RNDN) eq '.aaaaaaaaaaaaaaaaaaaa@20') {print "ok 10\n"}
  else {print "not ok 10\n"}
  }
else {print "ok 10 - skipped - no Math::GnuMPz\n"}

Rmpfr_set_prec($c, 53);

Rmpfr_set_ui($c, 2, GMP_RNDN);

if($have_mpz) {
  my $exp = Rmpfr_get_z_exp($z, $c);
  if($exp == -51 && Math::GnuMPz::Rmpz_get_str($z, 10) eq '4503599627370496') {print "ok 11\n"}
  else {print "not ok 11\n"}
  }
else {print "ok 11 - skipped - no Math::GnuMPz\n"}

Rmpfr_set_prec($c, 300);
Rmpfr_set_str($c, 'zyxwvp123456@-2', 36, GMP_RNDN);
Rmpfr_set($check, $c, GMP_RNDN);
Rmpfr_add($c, $c, $d, GMP_RNDN);
Rmpfr_add_ui($c, $c, 12345, GMP_RNDN);
Rmpfr_sub($c, $c, $d, GMP_RNDN);
Rmpfr_sub_ui($c, $c, 12345, GMP_RNDN);

if(Rmpfr_eq($c, $check, 250)) {print "ok 12\n"}
else {print "not ok 12\n"}

Rmpfr_ui_sub($check, 0, $c, GMP_RNDN);
Rmpfr_neg($c, $c, GMP_RNDN);

if(!Rmpfr_cmp($c, $check)) {print "ok 13\n"}
else {print "not ok 13\n"}

Rmpfr_add($check, $c, $c,  GMP_RNDN);
Rmpfr_mul_ui($check2, $c, 2, GMP_RNDN);
Rmpfr_mul_2exp($check3, $c, 1, GMP_RNDN);

if(!Rmpfr_cmp($check, $check2) && !Rmpfr_cmp($check, $check3)) {print "ok 14\n"}
else {print "not ok 14\n"}

Rmpfr_div_ui($check2, $check, 2, GMP_RNDN);
Rmpfr_div_2exp($check3, $check, 1, GMP_RNDN);
Rmpfr_mul_2ui($check3, $check3, 3, GMP_RNDN);
Rmpfr_mul_2si($check3, $check3, -3, GMP_RNDN);
Rmpfr_div_2ui($check3, $check3, 3, GMP_RNDN);
Rmpfr_div_2si($check3, $check3, -3, GMP_RNDN);

if(!Rmpfr_cmp($check2, $check3)) {print "ok 15\n"}
else {print "not ok 15\n"}

Rmpfr_div($check, $c, $c, GMP_RNDN);

if(!Rmpfr_cmp_ui($check, 1)) {print "ok 16\n"}
else {print "not ok 16\n"}

Rmpfr_ui_div($check, 1, $c, GMP_RNDN);
Rmpfr_mul($check, $c, $check, GMP_RNDN);

if(!Rmpfr_cmp_ui($check, 1)) {print "ok 17\n"}
else {print "not ok 17\n"}

Rmpfr_pow_ui($check2, $c, 2, GMP_RNDN);
Rmpfr_sqrt($check2, $check2, GMP_RNDN);

if(Rmpfr_cmp($check2, $c) && !Rmpfr_eq($check2, $c, 10)) {print "ok 18\n"}
else {print "not ok 18\n"}

Rmpfr_abs($c, $c, GMP_RNDN);

if(Rmpfr_eq($check2, $c, 280)) {print "ok 19\n"}
else {print "not ok 19\n"}

if(Rmpfr_nan_p($e) && Rmpfr_number_p($c) && Rmpfr_sgn($c) == 1) {print "ok 20\n"}
else {print "not ok 20\n"}

Rmpfr_div_ui($check2, $c, 0, GMP_RNDN);
if(Rmpfr_inf_p($check2)) {print "ok 21\n"}
else {print "not ok 21\n"}

Rmpfr_neg($check2, $c, GMP_RNDN);

Rmpfr_reldiff($check, $check2, $c, GMP_RNDN);

if(!Rmpfr_cmp_si($check, -2)) {print "ok 22\n"}
else {print "not ok 22\n"}

if($have_mpz) {
  Rmpfr_div_z($check2, $c, $z, GMP_RNDN);
  Rmpfr_mul_z($check2, $check2, $z, GMP_RNDN);
  if(Rmpfr_eq($check2, $c, 280)) {print "ok 23\n"}
  else {print "not ok 23\n"}
  }
else {print "ok 23 - skipped - no Math::GnuMPz\n"}

if($have_mpq) {
  Rmpfr_div_q($check2, $c, $q, GMP_RNDN);
  Rmpfr_mul_q($check2, $check2, $q, GMP_RNDN);
  if(Rmpfr_eq($check2, $c, 280)) {print "ok 24\n"}
  else {print "not ok 24\n"}
  }
else {print "ok 24 - skipped - no Math::GnuMPq\n"}

Rmpfr_neg($check, $c, GMP_RNDN);
Rmpfr_set($check2, $c, GMP_RNDN);
Rmpfr_swap($check2, $check);
Rmpfr_add($check3, $check2, $check, GMP_RNDN);

if(Rmpfr_sgn($check2) == -1 && Rmpfr_sgn($check) == 1 && !Rmpfr_cmp_ui($check3, 0)) {print "ok 25\n"}
else {print "not ok 25\n"}

Rmpfr_sin_cos($s, $c, $angle, GMP_RNDN);
Rmpfr_pow_ui($check, $s, 2, GMP_RNDN);
Rmpfr_pow_ui($check2, $c, 2, GMP_RNDN);
Rmpfr_add($check3, $check2, $check, GMP_RNDN);

if(Rmpfr_eq($check3, $unity, 280)) {print "ok 26\n"}
else {print "not ok 26\n"}

Rmpfr_tan($t, $angle, GMP_RNDN);
Rmpfr_div($check, $s, $c, GMP_RNDN);

if(Rmpfr_eq($t, $check, 280)) {print "ok 27\n"}
else {print "not ok 27\n"}

my $d2;

if($Config{make} !~ /nmake/i) {
  Rmpfr_const_pi($c, GMP_RNDN);
  $d2 = Rmpfr_get_d($c, GMP_RNDN);

  if($d2 > 3.14159265 && $d2 < 3.14159266) {print "ok 28\n"}
  else {print "not ok 28\n"}
  }
else {print "ok 28 - skipped - msvc-built perl likes to segfault here\n"}

Rmpfr_const_euler($c, GMP_RNDN);
$d2 = Rmpfr_get_d($c, GMP_RNDN);

if($d2 > 0.5772156649 && $d2 < 0.577215665) {print "ok 29\n"}
else {print "not ok 29\n"}

Rmpfr_const_log2($c, GMP_RNDN);
$d2 = Rmpfr_get_d($c, GMP_RNDN);

if($d2 > 0.69314718 && $d2 < 0.69314719) {print "ok 30\n"}
else {print "not ok 30\n"}

my $ret = Rmpfr_exp($c, $unity, GMP_RNDN);
$d2 = Rmpfr_get_d($c, GMP_RNDN);

if($ret && $d2 > 2.7182818284 && $d2 < 2.7182818285) {print "ok 31\n"}
else {print "not ok 31\n"}

Rmpfr_set_d($c, $d2, GMP_RNDN);
Rmpfr_log($c, $c, GMP_RNDN);
$d2 = Rmpfr_get_d($c, GMP_RNDN);

if($d2 > 0.99999 && $d2 < 1.00001) {print "ok 32\n"}
else {print "not ok 32\n"}

Rmpfr_set_d($c, $double, GMP_RNDN);
Rmpfr_exp2($c, $c, GMP_RNDN);
Rmpfr_log2($c, $c, GMP_RNDN);
$d2 = Rmpfr_get_d($c, GMP_RNDN);
if($d2 > 12345.49 && $d2 < 12345.51) {print "ok 33\n"}
else {print "not ok 33\n"}

Rmpfr_set_d($c, $double, GMP_RNDN);
Rmpfr_set_ui($d, 10, GMP_RNDN);
Rmpfr_pow($c, $d, $c, GMP_RNDN);

Rmpfr_log10($c, $c, GMP_RNDN);
$d2 = Rmpfr_get_d($c, GMP_RNDN);

if($d2 > 12345.49 && $d2 < 12345.51) {print "ok 34\n"}
else {print "not ok 34\n"}

Rmpfr_set_ui($check2, 12345, GMP_RNDN);
Rmpfr_set_ui($check3, 12346, GMP_RNDN);
Rmpfr_agm($check, $check3, $check2, GMP_RNDN);
$d2 = Rmpfr_get_d($check, GMP_RNDN);

if($d2 > 12345.49999 && $d2 < 12345.50001) {print "ok 35\n"}
else {print "not ok 35\n"} 

$ret = '';

Rmpfr_set_d($d, 123456.6, GMP_RNDN);
Rmpfr_rint($c, $d, GMP_RNDD);
if(!Rmpfr_cmp_ui($c, 123456)) { $ret .= 'a'}

Rmpfr_ceil($c, $d);
if(!Rmpfr_cmp_ui($c, 123457)) { $ret .= 'a'}

Rmpfr_floor($c, $d);
if(!Rmpfr_cmp_ui($c, 123456)) { $ret .= 'a'}

Rmpfr_round($c, $d);
if(!Rmpfr_cmp_ui($c, 123457)) { $ret .= 'a'}

Rmpfr_trunc($c, $d);
if(!Rmpfr_cmp_ui($c, 123456)) { $ret .= 'a'}

if($ret eq 'aaaaa') {print "ok 36\n"}
else {print "not ok 36\n"}

if(Rmpfr_get_emin() < -1000000 && Rmpfr_get_emax > 1000000) {print "ok 37\n"}
else {print "not ok 37\n"}

if(!Rmpfr_check_range($d, 0, GMP_RNDN)) {print "ok 38\n"}
else {print "not ok 38\n"}

if($have_mpf) {
  Rmpfr_set_f($c, $f, GMP_RNDN);
  Rmpfr_set_str($d, 'zzzzzzzzzzzzz123@-5', 36, GMP_RNDN);
  if(Rmpfr_eq($c, $d, 100)) {print "ok 39\n"}
  else {print "not ok 39\n"}
  }
else {print "ok 39 - skipped - no Math::GnuMPf\n"}

my @r = ();
Rmpfr_set_default_prec(75);
for(1..100) {push @r, Rmpfr_init()}

if($have_mpz) {
  my $str = '1';

  for(1..63) {$str .= int(rand(2))}

  my $seed = Math::GnuMPz::Rmpz_init_set_str($str, 2);
  my $state = Rgmp_randinit_default();

  Rgmp_randseed($state, $seed);

  my $ok = 1;

  Rmpfr_urandomb(@r, $state);

  for(@r) {
     if(length(Rmpfr_get_str($_, 2, 0, GMP_RNDN)) > 80 || length(Rmpfr_get_str($_, 2, 0, GMP_RNDN)) < 40) {$ok = 0} 
     if($_ <= 0 || $_ >= 1) {$ok = 0}
     }

  for(my $i = 0; $i < 100; $i++) {
     for(my $j = $i + 1; $j < 100; $j++) {
        if($r[$i] == $r[$j]) {$ok = 0}
        }
     } 

  if($ok) {print "ok 40\n"}
  else {print "not ok 40\n"}

  Rgmp_randclear($state);
  }
else {print "ok 40 - skipped - no Math::GnuMPz\n"}

#########################
if(1) {
  my $str = '';

  for(1..21) {$str .= 1 + int(rand(9))}

  my $state = Rgmp_randinit_lc_2exp_size(100);

  Rgmp_randseed($state, $str);

  my $ok = 1;

  Rmpfr_urandomb(@r, $state);

  for(@r) {
     if(length(Rmpfr_get_str($_, 2, 0, GMP_RNDN)) > 80 || length(Rmpfr_get_str($_, 2, 0, GMP_RNDN)) < 40) {$ok = 0} 
     if($_ <= 0 || $_ >= 1) {$ok = 0}
     }

  for(my $i = 0; $i < 100; $i++) {
     for(my $j = $i + 1; $j < 100; $j++) {
        if($r[$i] == $r[$j]) {$ok = 0}
        }
     } 

  if($ok) {print "ok 41\n"}
  else {print "not ok 41\n"}

  Rgmp_randclear($state);
  }
#else {print "ok 41 - skipped - no Math::GMP\n"}
#########################

my $o = Rmpfr_init();
Rmpfr_set_d($o, $double, GMP_RNDN);

my ($t1, $s1) = Rmpfr_init_set($o, GMP_RNDN);
my ($t2, $s2) = Rmpfr_init_set_d($double, GMP_RNDN);

if(Rmpfr_eq($t1, $t2, 50)) {print "ok 42\n"}
else {print "not ok 42\n"} 

my ($t3, $s33) = Rmpfr_init_set_ui(int($double), GMP_RNDN);
my ($t4, $s44) = Rmpfr_init_set_si(int($double) + 1, GMP_RNDN);

if(Rmpfr_cmp($t3, $t2) < 0
  && Rmpfr_cmp($t4, $t2) > 0
  && Rmpfr_get_prec($t3) == Rmpfr_get_default_prec()) {print "ok 43\n"}
else {print "not ok 43\n"}

if($have_mpz) {
   eval {my $t = Rmpfr_init_set_z($z, GMP_RNDN)};
   if(!$@) {print "ok 44\n"}
   else {print "not ok 44\n"}
   }
else {print "ok 44 - skipped - no Math::GnuMPz\n"}

if($have_mpq) {
   eval {my $t = Rmpfr_init_set_q($q, GMP_RNDN)};
   if(!$@) {print "ok 45\n"}
   else {print "not ok 45\n"}
   }
else {print "ok 45 - skipped - no Math::GnuMPq\n"}

if($have_mpf) {
   eval {my $t = Rmpfr_init_set_f($f, GMP_RNDN)};
   if(!$@) {print "ok 46\n"}
   else {print "not ok 46\n"}
   }
else {print "ok 46 - skipped - no Math::GnuMPf\n"}

if($have_mpz) {
   # Check that a specific MPFR bug has been fixed
   Math::GnuMPz::Rmpz_set_ui($z, 0);
   Rmpfr_set($check, $c, GMP_RNDN);

   my $ok = '';

   Rmpfr_add_z($c, $c, $z, GMP_RNDN);
   if($c == $check) {$ok = 'a'}

   Rmpfr_sub_z($c, $c, $z, GMP_RNDN);
   if($c == $check) {$ok .= 'b'}

   Rmpfr_mul_z($check, $c, $z, GMP_RNDN);
   if($check == 0) {$ok .= 'c'}

   my $flag = Rmpfr_nanflag_p();

   Rmpfr_div_z($check, $c, $z, GMP_RNDN);
   if(Rmpfr_inf_p($check)) {$ok .= 'd'}

   if($ok eq 'abcd' && !$flag
     && get_refcnt($c) == 1
     && get_refcnt($check) == 1){print "ok 47\n"}
   else {print "not ok 47\n"}
   }
else {print "ok 47 - skipped - no Math::GnuMPz\n"}

my $ok = '';

$check = $c;
$c *= 0;

if($check != $c) {$ok = 'a'}
$check *= 0;

if($check == $c) {$ok .= 'b'}

my $flag = Rmpfr_nanflag_p();

$check = $check / $c;
if(!$flag && Rmpfr_nanflag_p()
   && get_refcnt($check) == 1
   && get_refcnt($c) == 1) {print "ok 48\n"}
else {print "not ok 48\n"}

########################

if($have_gmp) {
  $z = Math::GMP->new("1123");
  Rmpfr_set_z($c, $z, GMP_RNDN);
  if($c == 1123 && get_refcnt($z) == 1
     && get_package_name($z) eq "Math::GMP") {print "ok 49\n"}
  else {print "not ok 49\n"}
  }
else {print "ok 49 - skipped - no Math::GMP\n"}

if($have_Gmpz) {
  $z = GMP::Mpz::mpz(11213);
  Rmpfr_set_z($c, $z, GMP_RNDN);
  if($c == 11213 && get_refcnt($z) == 1
     && get_package_name($z) eq "GMP::Mpz") {print "ok 50\n"}
  else {print "not ok 50\n"}
  }
else {print "ok 50 - skipped - no GMP::Mpz\n"}

if($have_gmp) {
  Rmpfr_set_prec($c, 53);
  Rmpfr_set_ui($c, 2, GMP_RNDN);
  $z = Math::GMP->new(0);
  my $exp = Rmpfr_get_z_exp($z, $c);
  if($exp == -51 && Math::GnuMPz::Rmpz_get_str($z, 10) eq '4503599627370496'
     && get_package_name($z) eq "Math::GMP") {print "ok 51\n"}
  else {print "not ok 51\n"}
  }
else {print "ok 51 - skipped - no Math::GMP\n"}

if($have_Gmpz) {
  Rmpfr_set_prec($c, 53);
  $z = GMP::Mpz::mpz(0);
  Rmpfr_set_ui($c, 2, GMP_RNDN);
  my $exp = Rmpfr_get_z_exp($z, $c);
  if($exp == -51 && Math::GnuMPz::Rmpz_get_str($z, 10) eq '4503599627370496'
     && get_package_name($z) eq "GMP::Mpz") {print "ok 52\n"}
  else {print "not ok 52\n"}
  }
else {print "ok 52 - skipped - no GMP::Mpz\n"}

if($have_gmp) {
  $z = Math::GMP->new(11234);
  Rmpfr_set_prec($c, 300);
  Rmpfr_set_ui($c, 237, GMP_RNDN);
  Rmpfr_div_z($check2, $c, $z, GMP_RNDN);
  Rmpfr_mul_z($check2, $check2, $z, GMP_RNDN);
  if(Rmpfr_eq($check2, $c, 280)
     && get_package_name($z) eq "Math::GMP") {print "ok 53\n"}
  else {print "not ok 53\n"}
  }
else {print "ok 53 - skipped - no Math::GMP\n"}

if($have_Gmpz) {
  $z = GMP::Mpz::mpz(11231);
  Rmpfr_set_prec($c, 300);
  Rmpfr_set_ui($c, 236, GMP_RNDN);
  Rmpfr_div_z($check2, $c, $z, GMP_RNDN);
  Rmpfr_mul_z($check2, $check2, $z, GMP_RNDN);
  if($check2 >= 235.999999 && $check2 <= 236.000001
     && get_package_name($z) eq "GMP::Mpz") {print "ok 54\n"}
  else {print "not ok 54\n"}
  }
else {print "ok 54 - skipped - no GMP::Mpz\n"}

if($have_Gmpq) {
  Rmpfr_set_prec($c, 300);
  Rmpfr_set_ui($c, 236, GMP_RNDN);
  $q = GMP::Mpq::mpq(11/7);
  Rmpfr_div_q($check2, $c, $q, GMP_RNDN);
  Rmpfr_mul_q($check2, $check2, $q, GMP_RNDN);
  if(Rmpfr_eq($check2, $c, 280)
     && get_package_name($q) eq "GMP::Mpq") {print "ok 55\n"}
  else {print "not ok 55\n"}
  }
else {print "ok 55 - skipped - no GMP::Mpq\n"}

if($have_gmp) {
  $z = Math::GMP->new("1123");
  my ($c, $cmp) = Rmpfr_init_set_z($z, GMP_RNDN);
  if($c == 1123 && get_refcnt($z) == 1
     && get_package_name($z) eq "Math::GMP") {print "ok 56\n"}
  else {print "not ok 56\n"}
  }
else {print "ok 56 - skipped - no Math::GMP\n"}

if($have_Gmpz) {
  $z = GMP::Mpz::mpz(11213);
  my ($c, $cmp) = Rmpfr_init_set_z($z, GMP_RNDN);
  if($c == 11213 && get_refcnt($z) == 1
     && get_package_name($z) eq "GMP::Mpz") {print "ok 57\n"}
  else {print "not ok 57\n"}
  }
else {print "ok 57 - skipped - no GMP::Mpz\n"}

if($have_Gmpq) {
  $z = GMP::Mpq::mpq(11213);
  my ($c, $cmp) = Rmpfr_init_set_q($z, GMP_RNDN);
  if($c == 11213 && get_refcnt($z) == 1
     && get_package_name($z) eq "GMP::Mpq") {print "ok 58\n"}
  else {print "not ok 58\n"}
  }
else {print "ok 58 - skipped - no GMP::Mpq\n"}

if($have_Gmpf) {
  $z = GMP::Mpf::mpf(11213.0);
  my ($c, $cmp) = Rmpfr_init_set_f($z, GMP_RNDN);
  if($c == 11213 && get_refcnt($z) == 1
     && get_package_name($z) eq "GMP::Mpf") {print "ok 59\n"}
  else {print "not ok 59\n"}
  }
else {print "ok 59 - skipped - no GMP::Mpf\n"}

if($have_Gmpq) {
  $z = GMP::Mpq::mpq(11213);
  Rmpfr_set_q($c, $z, GMP_RNDN);
  if($c == 11213 && get_refcnt($z) == 1
     && get_package_name($z) eq "GMP::Mpq") {print "ok 60\n"}
  else {print "not ok 60\n"}
  }
else {print "ok 60 - skipped - no GMP::Mpq\n"}

if($have_Gmpf) {
  $z = GMP::Mpf::mpf(11213.0);
  Rmpfr_set_f($c, $z, GMP_RNDN);
  if($c == 11213 && get_refcnt($z) == 1
     && get_package_name($z) eq "GMP::Mpf") {print "ok 61\n"}
  else {print "not ok 61\n"}
  }
else {print "ok 61 - skipped - no GMP::Mpf\n"}

my $inf = Rmpfr_init();
Rmpfr_set_inf($inf, -1);

if(Rmpfr_inf_p($inf)) {print "ok 62\n"}
else {print "not ok 62\n"}

my $nan = Rmpfr_init();
Rmpfr_set_nan($nan);

if(Rmpfr_nan_p($nan)) {print "ok 63\n"}
else {print "not ok 63\n"}

Rmpfr_set_si($inf, -27, GMP_RNDN);
Rmpfr_cbrt($inf, $inf, GMP_RNDN);

if($inf == -3 && Rmpfr_integer_p($inf)) {print "ok 64\n"}
else {print "not ok 64\n"}

$ok = 1;
my @r3 = ();
Rmpfr_set_default_prec(75);
for(1..100) {push @r3, Rmpfr_init()}

for(@r3) {Rmpfr_random2($_, 6, 2)}

for(my $i = 0; $i < 100; $i++) {
   for(my $j = $i + 1; $j < 100; $j++) {
      if($r3[$i] == $r3[$j]) {$ok = 0}
      }
   } 

if($ok) {print "ok 65\n"}
else {print "not ok 65\n"}

if($have_gmp) {
  $z = Math::GMP->new(17);
  Rmpfr_set($check, $c, GMP_RNDN);

  Rmpfr_add_z($c, $c, $z, GMP_RNDN);
  Rmpfr_sub_z($c, $c, $z, GMP_RNDN);
 
  if($c == $check) {print "ok 66\n"}
  else {print "not ok 66\n"}
  }
else {print "ok 66 - skipped - no Math::GMP\n"}

if($have_Gmpz) {
  $z = GMP::Mpz::mpz(57);
  Rmpfr_set($check, $c, GMP_RNDN);

  Rmpfr_add_z($c, $c, $z, GMP_RNDN);
  Rmpfr_sub_z($c, $c, $z, GMP_RNDN);
 
  if($c == $check) {print "ok 67\n"}
  else {print "not ok 67\n"}
  }
else {print "ok 67 - skipped - no GMP::Mpz\n"}

Rmpfr_set_si($c, -123, GMP_RNDN);
Rmpfr_set_si($check, -7, GMP_RNDN);

if(Rmpfr_cmpabs($c, $check) > 0 && !Rmpfr_unordered_p($c, $check)) {print "ok 68\n"}
else {print "not ok 68\n"}

$ok = '';

Rmpfr_min($check2, $check, $c, GMP_RNDN);
if($check2 == $c) {$ok = 'a'}

Rmpfr_max($check2, $check, $c, GMP_RNDN);
if($check2 == $check) {$ok .= 'b'}

if($ok eq 'ab') {print "ok 69\n"}
else {print "not ok 69\n"}

Rmpfr_set_d($c, 1.003, GMP_RNDN);
Rmpfr_gamma($c, $c, GMP_RNDN);

if($c > 0.9982772 && $c < 0.9982773) {print "ok 70\n"}
else {print "not ok 70\n"}

Rmpfr_set_ui($c, 0, GMP_RNDN);
Rmpfr_erf($check, $c, GMP_RNDN);

if($check == 0) {print "ok 71\n"}
else {print "not ok 71\n"}

Rmpfr_const_pi($check, GMP_RNDN);
$check **= 4;
$check /= 90;

Rmpfr_set_ui($c, 4, GMP_RNDN);
Rmpfr_zeta($c, $c, GMP_RNDN);

if($c > $check - 0.00001 && $c < $check + 0.00001) {print "ok 72\n"}
else {print "not ok 72\n"}

my $fail = Rmpfr_set_exp($c, -5);

if(!$fail && Rmpfr_get_exp($c) == -5) {print "ok 73\n"}
else {print "not ok 73\n"}

if($have_Gmpz) {
  my $str = '';

  for(1..21) {$str .= 1 + int(rand(9))}

  my $seed = GMP::Mpz::mpz($str);
  my $state = Rgmp_randinit_lc_2exp_size(90);

  Rgmp_randseed($state, $seed);

  my $ok = 1;

  Rmpfr_urandomb(@r, $state);

  for(@r) {
     if(length(Rmpfr_get_str($_, 2, 0, GMP_RNDN)) > 80 || length(Rmpfr_get_str($_, 2, 0, GMP_RNDN)) < 40) {$ok = 0} 
     if($_ <= 0 || $_ >= 1) {$ok = 0}
     }

  for(my $i = 0; $i < 100; $i++) {
     for(my $j = $i + 1; $j < 100; $j++) {
        if($r[$i] == $r[$j]) {$ok = 0}
        }
     } 

  if($ok) {print "ok 74\n"}
  else {print "not ok 74\n"}

  Rgmp_randclear($state);
  }
else {print "ok 74 - skipped - no GMP::Mpz\n"}

if(1) {
  my $str = '';

  for(1..21) {$str .= 1 + int(rand(10))}

  my $state = Rgmp_randinit_lc_2exp_size(90);

  Rgmp_randseed($state, $str);

  my $ok = 1;

  Rmpfr_urandomb(@r, $state);

  for(@r) {
     if(length(Rmpfr_get_str($_, 2, 0, GMP_RNDN)) > 80 || length(Rmpfr_get_str($_, 2, 0, GMP_RNDN)) < 40) {$ok = 0} 
     if($_ <= 0 || $_ >= 1) {$ok = 0}
     }

  for(my $i = 0; $i < 100; $i++) {
     for(my $j = $i + 1; $j < 100; $j++) {
        if($r[$i] == $r[$j]) {$ok = 0}
        }
     } 

  if($ok) {print "ok 75\n"}
  else {print "not ok 75\n"}

  Rgmp_randclear($state);
  }
#else {print "ok 75 - skipped - no GMP::Mpz\n"}

##########################################

if($have_mpz) {
  my $str = '';

  for(1..21) {$str .= 1 + int(rand(9))}

  my $seed = Math::GnuMPz::Rmpz_init_set_str($str, 10);

  my $state = Rgmp_randinit_lc_2exp_size(120);

  Rgmp_randseed($state, $seed);

  my $ok = 1;

  Rmpfr_urandomb(@r, $state);

  for(@r) {
     if(length(Rmpfr_get_str($_, 2, 0, GMP_RNDN)) > 80 || length(Rmpfr_get_str($_, 2, 0, GMP_RNDN)) < 40) {$ok = 0} 
     if($_ <= 0 || $_ >= 1) {$ok = 0}
     }

  for(my $i = 0; $i < 100; $i++) {
     for(my $j = $i + 1; $j < 100; $j++) {
        if($r[$i] == $r[$j]) {$ok = 0}
        }
     } 

  if($ok) {print "ok 76\n"}
  else {print "not ok 76\n"}

  Rgmp_randclear($state);
  }
else {print "ok 76 - skipped - no Math::GnuMPz\n"}

#########################
if(1) {
  my $str = '';

  for(1..21) {$str .= 1 + int(rand(10))}

  my $state = Rgmp_randinit_lc_2exp_size(100);

  Rgmp_randseed_ui($state, 1123456);

  my $ok = 1;

  Rmpfr_urandomb(@r, $state);

  for(@r) {
     if(length(Rmpfr_get_str($_, 2, 0, GMP_RNDN)) > 80 || length(Rmpfr_get_str($_, 2, 0, GMP_RNDN)) < 40) {$ok = 0} 
     if($_ <= 0 || $_ >= 1) {$ok = 0}
     }

  for(my $i = 0; $i < 100; $i++) {
     for(my $j = $i + 1; $j < 100; $j++) {
        if($r[$i] == $r[$j]) {$ok = 0}
        }
     } 

  if($ok) {print "ok 77\n"}
  else {print "not ok 77\n"}

  Rgmp_randclear($state);
  }
#else {print "ok 77 - skipped - no Math::GMP\n"}


# Run the following to test Rmpfr_out_str,
# Rmpfr_print _binary and Rmpfr_inp_str
__END__
Rmpfr_set_d($c, 1123.5, GMP_RNDN);
Rmpfr_out_str($c, 10, 0, GMP_RNDN);
print "\n";
Rmpfr_print_binary($c);
print "\nEnter a number [eg .11235\@4]\n";
Rmpfr_inp_str($check, 10, GMP_RNDN);
print "\n";
Rmpfr_out_str($check, 10, 0, GMP_RNDN);

