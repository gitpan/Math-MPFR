use warnings;
use strict;
use Math::MPFR qw(:mpfr);

print "1..3\n";

print "# Using mpfr version ", MPFR_VERSION_STRING, "\n";

my $_64 = Math::MPFR::_has_longlong() ? 1 : 0;

Rmpfr_set_default_prec(300);

my $ok = '';

if($_64) {
  use integer;
  my $int1 = Math::MPFR->new(2 ** 57 + 12345);
  $int1 *= -1;
  if($int1 == -144115188075868217
     && $int1 == "-144115188075868217"
    ) {$ok = 'a'}

  my $pp1 = Rmpfr_get_sj($int1, GMP_RNDN);
  if($pp1 == -144115188075868217) {$ok .= 'b'} 
 
  $pp1 += 14;

  my $int2 = Rmpfr_init();
  Rmpfr_set_sj($int2, $pp1, GMP_RNDN);
  if($int2 == $pp1
     && $int2 - $int1 - 14 == 0
     && !($int2 - $int1 - 14)
     ) {$ok .= 'c'}  

  Rmpfr_set_sj_2exp($int2, $pp1, 2, GMP_RNDN);
  if($int2 == $pp1 * 4) {$ok .= 'd'}


  if($ok eq 'abcd') {print "ok 1\n"}
  else {print "not ok 1 $ok\n"}
}


$ok = '';

if($_64) {

  my $int3 = Rmpfr_init();
  my $pp2 = 2 ** 57 + 12345;
  $pp2 *= -1;
  if(Math::MPFR::_itsa($pp2) == 2) {$ok = 'AB'}
  else {
   Rmpfr_set_sj($int3, ~0, GMP_RNDN);
   if($int3 == -1) {$ok = 'a'}

   Rmpfr_set_sj_2exp($int3, ~0, 2, GMP_RNDN);
   if($int3 == -4) {$ok .= 'b'}
  }

  if(lc($ok) eq 'ab') {print "ok 2\n"}
  else {print "not ok 2 $ok\n"}
}

$ok = '';

if($_64) {
  my ($int, $discard) = Rmpfr_init_set_ui(2, GMP_RNDN);
  my $pint = -144115188075868217;

  if(Math::MPFR::_itsa($pint) == 2) {$ok .= 'a'}

  $int *= $pint;

  if($int == -288230376151736434
     && $int <= -288230376151736434
     && $int >= -288230376151736434
     && ($int <=> -288230376151736434) == 0
     && ($int <=> -288230376151736435) == 1
     && $int != -288230376151736435
    ) {$ok .= 'b'}

  $int += $pint;

  if($int == -432345564227604651
     && ($int <=> -432345564227604651) == 0
     && ($int <=> -432345564227604649) == -1
     && $int != -432345564227604653
    ) {$ok .= 'c'}

  $int -= $pint;

  if($int == -288230376151736434
     && $int == "-288230376151736434"
     && ($int <=> -288230376151736434) == 0
     && ($int <=> -288230376151736435) == 1
     && $int != -288230376151736435
    ) {$ok .= 'd'}

  $int += 12345;
  $int /= $pint; # $int is no longer an integer value

  if($int < 2 
     && $int > 1.99
     && $int > "1.99"
     && $int <= 2 
     && $int >= 1.99
     && ($int <=> 1.99) == 1
     && ($int <=> 2) == -1
    ) {$ok .= 'e'}

  $int = 2;
  my $temp = Math::MPFR->new();

  $temp = $int * $pint;

  if($temp == -288230376151736434
     && $temp != -288230376151736435
    ) {$ok .= 'f'}

  $temp = $temp + $pint;

  if($temp == -432345564227604651
     && $temp != -432345564227604653
    ) {$ok .= 'g'}

  $temp = $temp - $pint;

  if($temp == -288230376151736434
     && $temp != -288230376151736435
    ) {$ok .= 'h'}

  $temp = $temp + 12345;
  $temp = $temp / $pint; # $temp no longer an integer value

  if($temp < 2
     && $temp > 1.99
     && $temp <= 2 
     && $temp <= "2"
     && $temp >+ 1.99
    ) {$ok .= 'i'}

  $pint *= -1;

  $temp = atan2(99999, $pint);

  if($temp > 6.938824e-13 
     && $temp < 6.938825e-13 
     && $temp >= 6.938824e-13
     && $temp <= 6.938825e-13
     && ($temp <=> 6.938825e-13) == -1
     && ($temp <=> 6.938824e-13) == 1
    ) {$ok .= 'j'}

  if($int) {$ok .= 'k'}
  $int *= 0;
  if(!$int) {$ok.= 'l'}

  my $temp2 = Math::MPFR->new($pint);

  my $pint2 = Rmpfr_get_sj($temp2, GMP_RNDN);

  if($pint2 == $pint
     && $pint2 < $pint + 1
     && $pint2 > $pint - 1
    ) {$ok .= 'm'}
  
  my $temp3 = new Math::MPFR($pint);

  if($temp3 == $temp2) {$ok .= 'n'}

  if($ok eq 'abcdefghijklmn') {print "ok 3\n"}
  else {print "not ok 3 $ok\n"}
}

$ok = '';

if(!$_64) {
  print "ok 1 - skipped\n";
  my $int1;
  eval{Rmpfr_set_sj_2exp($int1, 2 ** 23, 2, GMP_RNDN);};
  if($@ =~ /not implemented on this build of perl/i) {print "ok 2\n"}
  else {print "not ok 2 \n"}

  eval{Rmpfr_get_sj($int1, GMP_RNDN);};
  if($@ =~ /not implemented on this build of perl/i) {print "ok 3\n"}
  else {print "not ok 3 \n"}

}