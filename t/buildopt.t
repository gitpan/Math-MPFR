use warnings;
use strict;
use Math::MPFR qw(:mpfr);

print "1..2\n";

print  "# Using Math::MPFR version ", $Math::MPFR::VERSION, "\n";
print  "# Using mpfr library version ", MPFR_VERSION_STRING, "\n";
print  "# Using gmp library version ", Math::MPFR::gmp_v(), "\n";

if(MPFR_VERSION_MAJOR >= 3) {
  if(defined(Rmpfr_buildopt_tls_p())) {print "ok 1\n"}
  else {print "not ok 1\n"}
  if(defined(Rmpfr_buildopt_decimal_p())) {print "ok 2\n"}
  else {print "not ok 2\n"}
}
else {
  eval{Rmpfr_buildopt_tls_p();};
  if($@ =~ /Rmpfr_buildopt_tls_p not implemented/) {print "ok 1\n"}
  else {print "not ok 1\n"}
  eval{Rmpfr_buildopt_decimal_p();};
  if($@ =~ /Rmpfr_buildopt_decimal_p not implemented/) {print "ok 2\n"}
  else {print "not ok 2\n"}
}
