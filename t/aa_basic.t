use warnings;
use strict;
use Math::MPFR qw(:mpfr);

print "1..2\n";

print STDERR "\n# Using Math::MPFR version ", $Math::MPFR::VERSION, "\n";
print STDERR "# Using mpfr library version ", MPFR_VERSION_STRING, "\n";
print STDERR "# Using gmp library version ", Math::MPFR::gmp_v(), "\n";

if($Math::MPFR::VERSION eq '3.02') {print "ok 1\n"}
else {print "not ok 1 $Math::MPFR::VERSION\n"}

if(Rmpfr_get_version() eq MPFR_VERSION_STRING) {print "ok 2\n"}
else {print "not ok 2 - Header and Library do not match\n"}