use warnings;
use strict;
use Math::MPFR qw(:mpfr);

print "1..1\n";

print STDERR "\n# Using Math::MPFR version ", $Math::MPFR::VERSION, "\n";
print STDERR "# Using mpfr library version ", MPFR_VERSION_STRING, "\n";
print STDERR "# Using gmp library version ", Math::MPFR::gmp_v(), "\n";

if($Math::MPFR::VERSION eq '2.02') {print "ok 1\n"}
else {print "not ok 1 $Math::MPFR::VERSION\n"}