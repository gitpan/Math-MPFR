
use warnings;
use strict;
use Math::MPFR qw(:mpfr);

my $t = 11;

print "1..$t\n";

eval {require Math::LongDouble;};

unless($@ || $Math::LongDouble::VERSION < 0.02) {
  Rmpfr_set_default_prec(70);
  my($ld_1, $ld_2) = (Math::LongDouble->new('1.123'), Math::LongDouble->new());
  my $fr70 = Math::MPFR->new();
  my $fr64 = Rmpfr_init2(64);
  my ($man, $exp);
  my $str70 =
    '1000100000011100111010100001010001010100010111000111010101110101100000';
  my $m70to64 = 
    '1000100000011100111010100001010001010100010111000111010101110110';
  my $m64 =
    '1000100000011100111010100001010001010100010111000111010101110101';

  Rmpfr_set_LD($fr70, $ld_1, MPFR_RNDN);
  Rmpfr_get_LD($ld_2, $fr70, MPFR_RNDN);

  if($ld_1 && $ld_1 == $ld_2) {print "ok 1\n"}
  else {
    warn "\$ld_1: $ld_1\n\$ld_2: $ld_2\n";
    print "not ok 1\n";
  }

  my $ld_check = Math::LongDouble->new('1e-37');

  Rmpfr_set_str($fr70, '1@-37', 10, MPFR_RNDN);
  Rmpfr_set_str($fr64, '1@-37', 10, MPFR_RNDN);

  ($man, $exp) = Rmpfr_deref2($fr64, 2, 64, MPFR_RNDN);
  print "\$man:\n$man\n\n";


  #####################################################
  # $ld_2, derived from $fr64 should == $ld_check     #
  #####################################################
  Rmpfr_get_LD($ld_2, $fr64, MPFR_RNDN);
  $man = get_man($ld_2);
  if($man eq '1.00000000000000000') {print "ok 2\n"}
  else {
    warn "\n\$man: $man\n";
    print "not ok 2\n";
  }
  if($ld_check == $ld_2) {print "ok 3\n"}
  else {
    warn "\n\$ld_check: $ld_check\n\$ld_2: $ld_2\n";
    print "not ok 3\n";
  }
  $man = get_manp($ld_2, 19);
  if($man eq '9.999999999999999999') {print "ok 4\n"}
  else {
    warn "\n\$man: $man\n";
    print "not ok 4\n";
  }

  #####################################################
  # $ld_2, derived from $fr70 should != $ld_check     #
  #####################################################
  Rmpfr_get_LD($ld_2, $fr70, MPFR_RNDN);
  $man = get_man($ld_2);
  if($man eq '1.00000000000000000') {print "ok 5\n"}
  else {
    warn "\n\$man: $man\n";
    print "not ok 5\n";
  }
  if($ld_check != $ld_2) {print "ok 6\n"}
  else {
    warn "\n\$ld_check: $ld_check\n\$ld_2: $ld_2\n";
    print "not ok 6\n";
  }
  $man = get_manp($ld_2, 19);
  if($man eq '1.000000000000000000') {print "ok 7\n"}
  else {
    warn "\n\$man: $man\n";
    print "not ok 7\n";
  }

  #############################################################
  # Mantissa of $fr70, rounded to 64 bits should eq $m70to64  #
  #############################################################
  ($man, $exp) = Rmpfr_deref2($fr70, 2, 64, MPFR_RNDN);
  if($man eq $m70to64) {print "ok 8\n"}
  else {
    warn "\n\$man: $man\n      $m70to64\n";
    print "not ok 8\n";
  }

  #############################################################
  # 64-bit mantissa of $fr64 should eq $m64                   #
  ############################################################# 
  ($man, $exp) = Rmpfr_deref2($fr64, 2, 64, MPFR_RNDN);
  if($man eq $m64) {print "ok 9\n"}
  else {
    warn "\n\$man: $man\n\$m64: $m64\n";
    print "not ok 9\n";
  }


  Rmpfr_set_str($fr70, $str70, 2, MPFR_RNDN);
  #############################################################
  # Mantissa of $fr70, rounded to 64 bits should eq $m70to64  #
  #############################################################
  ($man, $exp) = Rmpfr_deref2($fr70, 2, 64, MPFR_RNDN);
  if($man eq $m70to64) {print "ok 10\n"}
  else {
    warn "\n\$man: $man\n      $m70to64\n";
    print "not ok 10\n";
  }
 

  Rmpfr_set_str($fr64, $str70, 2, MPFR_RNDN);
  #############################################################
  # Mantissa of $fr64, rounded to 64 bits should eq $m70to64  #
  #############################################################
  ($man, $exp) = Rmpfr_deref2($fr64, 2, 64, MPFR_RNDN);
  if($man eq $m70to64) {print "ok 11\n"}
  else {
    warn "\n\$man: $man\n      $m70to64\n";
    print "not ok 11\n";
  }
}


else {
  warn "\nSkipping all tests - couldn't load Math-LongDouble-0.02 (or later)\n";
  for(1 .. $t) {print "ok $_\n"}
}

sub get_man {
    return (split /e/i, Math::LongDouble::LDtoSTR($_[0]))[0];
}

sub get_manp {
    return (split /e/i, Math::LongDouble::LDtoSTRP($_[0], $_[1]))[0];
}