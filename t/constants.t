use warnings;
use strict;
use Math::MPFR qw(:mpfr);

print "1..5\n";

my $version = RMPFR_VERSION_NUM(MPFR_VERSION_MAJOR, MPFR_VERSION_MINOR, MPFR_VERSION_PATCHLEVEL);

if($version == MPFR_VERSION) {print "ok 1\n"}
else {print "not ok 1 $version ", MPFR_VERSION, "\n"}

if(MPFR_VERSION_MAJOR >= 2) {print "ok 2\n"}
else {print "not ok 2\n"}

if(MPFR_VERSION_MINOR >= 2) {print "ok 3\n"}
else {print "not ok 3\n"}

if(MPFR_VERSION_PATCHLEVEL >= 0) {print "ok 4\n"}
else {print "not ok 4\n"}

my $v = Rmpfr_get_version();

if($v eq MPFR_VERSION_STRING) {print "ok 5\n"}
else {print "not ok 5\n"} 

