use warnings;
use strict;
use Math::MPFR qw(:mpfr);

print "1..2\n";

print "# Using mpfr version ", MPFR_VERSION_STRING, "\n";

my $ok = '';

my $numerator = Math::MPFR->new(11.5);
my $denominator = Math::MPFR->new(3);
my $rop = Rmpfr_init();

Rmpfr_remainder($rop, $numerator, $denominator, GMP_RNDN);

if($rop == -0.5) {$ok .= 'a'}

if($ok eq 'a') {print "ok 1\n"}
else {print "not ok 1 $ok \n"}

$ok = '';

$numerator += 30.5; # 42
$denominator += 14; # 17

my($q, $ret) = Rmpfr_remquo($rop, $numerator, $denominator, GMP_RNDN);

if($q == 2) {$ok .= 'a'}
if($rop == 8) {$ok .= 'b'}

if($ok eq 'ab') {print "ok 2\n"}
else {print "not ok 2 $ok\n"}

