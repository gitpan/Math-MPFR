
use warnings;
use strict;
use Math::MPFR qw(:mpfr);

my $t = 1;

print "1..$t\n";

eval {require Math::LongDouble;};

unless($@) {
  Rmpfr_set_default_prec(150);
  my($ld_1, $ld_2) = (Math::LongDouble->new('1.123'), Math::LongDouble->new());
  my $fr = Math::MPFR->new();

  Rmpfr_set_LD($fr, $ld_1, MPFR_RNDN);
  Rmpfr_get_LD($ld_2, $fr, MPFR_RNDN);

  if($ld_1 && $ld_1 == $ld_2) {print "ok 1\n"}
  else {
    warn "\$ld_1: $ld_1\n\$ld_2: $ld_2\n";
    print "not ok 1\n";
  }
}
else {
  warn "\nSkipping all tests - couldn't load Math::LongDouble\n";
  for(1 .. $t) {print "ok $_\n"}
}