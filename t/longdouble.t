use strict;
use warnings;
use Math::MPFR qw(:mpfr);
use Config;

print "1..3\n";

print "# Using mpfr version ", MPFR_VERSION_STRING, "\n";

Rmpfr_set_default_prec(300);

if(Math::MPFR::_has_longdouble()) {
  my $ok = '';
  my $n = (2 ** 48) + 0.5;
  my $ld1 = Math::MPFR->new($n);
  my $ld2 = Math::MPFR::new($n);
  my $ld3 = Math::MPFR->new();
  Rmpfr_set_d($ld3, $n, GMP_RNDN);

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

  if($ld1 ** 0.5 < 16777216.01 &&
     $ld1 ** 0.5 > 16777216) {$ok .= 'i'}

  $ld1 **= 0.5;

  if($ld1 < 16777216.01 &&
     $ld1 > 16777216) {$ok .= 'j'}

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
  if($ok eq 'abc') {print "ok 1\n"}
  else {print "not ok 1 $ok\n"}
  print "ok 2 - skipped, built without long double support\n";
  print "ok 3 - skipped, built without long double support\n";
}