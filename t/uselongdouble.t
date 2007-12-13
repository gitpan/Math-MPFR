use strict;
use warnings;
use Math::MPFR qw(:mpfr);
use Config;

print "1..4\n";

print  "# Using Math::MPFR version ", $Math::MPFR::VERSION, "\n";
print  "# Using mpfr library version ", MPFR_VERSION_STRING, "\n";
print  "# Using gmp library version ", Math::MPFR::gmp_v(), "\n";

if(Math::MPFR::_has_longdouble()) {print "Using long double\n"}
else {print "Not using long double\n"}

Rmpfr_set_default_prec(300);

if(Math::MPFR::_has_longdouble()) {
  my $ok = '';
  my $n = (2 ** 55) + 0.5;
  my $ld1 = Math::MPFR->new($n);
  my $ld2 = Math::MPFR::new($n);
  my $ld3 = Math::MPFR->new();
  Rmpfr_set_ld($ld3, $n, GMP_RNDN);

  if(
     $ld1 == $ld2 && 
     $ld2 == $ld3 &&
     $ld2 <= $n  &&
     $ld2 >= $n  &&
     $ld2 < $n + 1 &&
     $ld2 > $n - 1 &&
     ($ld2 <=> $n) == 0 &&
     ($ld2 <=> $n - 1) > 0 &&
     ($ld2 <=> $n + 1) < 0 &&
     $ld2 != $n - 1
                   ) {$ok .= 'a'}

  my $d2 = Rmpfr_get_ld($ld1, GMP_RNDN);
  
  if($d2 == $n) {$ok .= 'b'}

  if(!Rmpfr_cmp_ld($ld1, $n)) {$ok .= 'c'}

  if($ok eq 'abc') {print "ok 1\n"}
  else {print "not ok 1 $ok\n"}

  $ok = '';

# Check the overloaded operators.

  if($ld1 - 1 == $n - 1) {$ok .= 'a'}

  $ld1 -= 1;

  if($ld1 == $n - 1) {$ok .= 'b'}

  $ld1 = $ld1 / 2;

  if($ld1 == ($n - 1) / 2) {$ok .= 'c'}

  $ld1 = $ld1 * 2;

  if($ld1 == $n - 1) {$ok .= 'd'}

  $ld1 /= 2;

  if($ld1 == ($n - 1) / 2) {$ok .= 'e'} 

  $ld1 *= 2;

  if($ld1 == $n - 1) {$ok .= 'f'}

  if($ld1 + 1 == $n) {$ok .= 'g'}

  $ld1 += 1;

  if($ld1 == $n) {$ok .= 'h'}

  if($ld1 ** 0.5 < 189812531.25 &&
     $ld1 ** 0.5 > 189812531.24) {$ok .= 'i'}

  $ld1 **= 0.5;

  if($ld1 < 189812531.25 &&
     $ld1 > 189812531.24) {$ok .= 'j'}

  if($ok eq 'abcdefghij') {print "ok 2\n"}
  else {print "not ok 2 $ok\n"}

  my $bits = $Config::Config{longdblsize} > $Config::Config{doublesize} ? $Config::Config{doublesize} * 7 : 50; 

  $n = (2 ** $bits) + 0.5;

  my $ld4 = Math::MPFR->new($n);

  if($ld4 == int($ld4)) { print "not ok 3 precision has been lost: $ld4\n"}
  else {print "ok 3\n"} 

}
else {
  my $ok = '';
  my $int1 = Rmpfr_init();
  eval{Rmpfr_set_ld($int1, 2 ** 23, GMP_RNDN);};
  if($@ =~ /not implemented on this build of perl/i) {$ok = 'a'}
  eval{Rmpfr_cmp_ld($int1, 2 ** 23);};
  if($@ =~ /not implemented on this build of perl/i) {$ok .= 'b'}
  eval{Rmpfr_get_ld($int1, GMP_RNDN);};
  if($@ =~ /not implemented on this build of perl/i) {$ok .= 'c'}
  eval{my($int2, $ret) = Rmpfr_init_set_ld(2 ** 23, GMP_RNDN);};
  if($@ =~ /not implemented on this build of perl/i) {$ok .= 'd'}
  if($ok eq 'abcd') {print "ok 1\n"}
  else {print "not ok 1 $ok\n"}
  print "ok 2 - skipped, built without long double support\n";
  print "ok 3 - skipped, built without long double support\n";
}

if(Math::MPFR::_has_longdouble()) {
  my $mpfr = Math::MPFR->new('1' x 62, 2);
  my $mpfr2 = Rmpfr_init();
  my $ok = '';

  if ($mpfr <  4611686018427387904 && $mpfr >  4611686018427387902) {$ok .= 'a'}
  if ($mpfr <= 4611686018427387904 && $mpfr >= 4611686018427387902) {$ok .= 'b'}
  if ($mpfr == 4611686018427387903) {$ok .= 'c'}
  if ($mpfr <= 4611686018427387903) {$ok .= 'd'}
  if ($mpfr >= 4611686018427387903) {$ok .= 'e'}

  my $ld = Rmpfr_get_ld($mpfr, GMP_RNDN);
  
  if ($ld < 4611686018427387904 && $ld > 4611686018427387902) {$ok .= 'f'}
  if ($ld == 4611686018427387903) {$ok .= 'g'} 

  my $cmp = $mpfr <=> 4611686018427387902;
  if($cmp > 0) {$ok .= 'h'}

  $cmp = $mpfr <=> 4611686018427387903;
  if($cmp == 0) {$ok .= 'i'}

  $cmp = $mpfr <=> 4611686018427387904;
  if($cmp < 0) {$ok .= 'j'}

  $cmp = 4611686018427387902 <=> $mpfr;
  if($cmp < 0) {$ok .= 'k'}

  $cmp = 4611686018427387903 <=> $mpfr;
  if($cmp == 0) {$ok .= 'l'}

  $cmp = 4611686018427387904 <=> $mpfr;
  if($cmp > 0) {$ok .= 'm'}

  Rmpfr_set_ld($mpfr2, 4611686018427387903, GMP_RNDN);
  if($mpfr2 == $mpfr) {$ok .= 'n'}

  if($ok eq 'abcdefghijklmn') {print "ok 4\n"}
  else {print "not ok 4 $ok\n"}
}

else {print "ok 4 - skipped, built without long double support\n"}