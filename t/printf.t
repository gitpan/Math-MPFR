use warnings;
use strict;
use Math::BigInt;
use Math::MPFR qw(:mpfr);

print "1..4\n";

print  "# Using Math::MPFR version ", $Math::MPFR::VERSION, "\n";
print  "# Using mpfr library version ", MPFR_VERSION_STRING, "\n";
print  "# Using gmp library version ", Math::MPFR::gmp_v(), "\n";

Rmpfr_set_default_prec(80);

my $ok = '';
my $buf = ' ' x 200;
my $ul = 123;
my $ret;
my $mpfr1 = Math::MPFR->new(1234567.625);

$ret = Rmpfr_printf("For testing: %.30Rf\n", $mpfr1);

if($ret == 52) {$ok .= 'a'}
else {warn "1a: $ret\n"}

$ok .= 'b' if $ret == Rmpfr_printf("For testing: %.30RNf\n", $mpfr1);
$ok .= 'c' if $ret == Rmpfr_printf("For testing: %.30R*f\n", GMP_RNDN, $mpfr1);
$ok .= 'd' if $ret == Rmpfr_fprintf(\*STDOUT, "For testing: %.30Rf\n", $mpfr1);
$ok .= 'e' if $ret == Rmpfr_fprintf(\*STDOUT, "For testing: %.30RNf\n", $mpfr1);
$ok .= 'f' if $ret == Rmpfr_fprintf(\*STDOUT, "For testing: %.30R*f\n", GMP_RNDZ, $mpfr1);
$ok .= 'g' if $ret == Rmpfr_sprintf($buf, "For testing: %.30Rf\n", $mpfr1);
$buf = ' ' x 200;
$ok .= 'h' if $ret == Rmpfr_sprintf($buf, "For testing: %.30RNf\n", $mpfr1);
$buf = ' ' x 200;
$ok .= 'i' if $ret == Rmpfr_sprintf($buf, "For testing: %.30R*f\n", GMP_RNDN, $mpfr1);

# Buffer is no longer large enough to store the result of the next 3 tests
$ok .= 'j' if "For some more testing: 1234567.625000000000000000000000000000\n" ne Rmpfr_sprintf_ret($buf, "For some more testing: %.30Rf\n", $mpfr1);
$ok .= 'k' if "For some more testing: 1234567.625000000000000000000000000000\n" ne Rmpfr_sprintf_ret($buf, "For some more testing: %.30RNf\n", $mpfr1);
$ok .= 'l' if "For some more testing: 1234567.625000000000000000000000000000\n" ne Rmpfr_sprintf_ret($buf, "For some more testing: %.30R*f\n", GMP_RNDD, $mpfr1);

# Restore buffer to its original size
$buf = ' ' x 200;

# Rmpfr_sprintf_ret() does not change the size of the buffer.
$ok .= 'm' if "For testing: 1234567.625000000000000000000000000000\n" eq Rmpfr_sprintf_ret($buf, "For testing: %.30Rf\n", $mpfr1);
$ok .= 'n' if "For testing: 1234567.625000000000000000000000000000\n" eq Rmpfr_sprintf_ret($buf, "For testing: %.30RNf\n", $mpfr1);
$ok .= 'o' if "For testing: 1234567.625000000000000000000000000000\n" eq Rmpfr_sprintf_ret($buf, "For testing: %.30R*f\n", GMP_RNDU, $mpfr1);
$ok .= 'p' if "For some more testing: 1234567.625000000000000000000000000000\n" eq Rmpfr_sprintf_ret($buf, "For some more testing: %.30Rf\n", $mpfr1);
$ok .= 'q' if "For some more testing: 1234567.625000000000000000000000000000\n" eq Rmpfr_sprintf_ret($buf, "For some more testing: %.30RNf\n", $mpfr1);
$ok .= 'r' if "For some more testing: 1234567.625000000000000000000000000000\n" eq Rmpfr_sprintf_ret($buf, "For some more testing: %.30R*f\n", GMP_RNDN, $mpfr1);

Rmpfr_sprintf ($buf, "%Pu\n", Rmpfr_get_prec($mpfr1));

if($buf == 80) {$ok .= 's'}
else {warn "1s: $buf\n"}

# Restore buffer to its original size
$buf = ' ' x 200;

Rmpfr_sprintf($buf, "%.30Rb\n", $mpfr1);
if(lc($buf) eq "1.001011010110100001111010000000p+20\n") {$ok .= 't'}
else {warn "1t: $buf\n"}

Rmpfr_sprintf($buf, "%.30RNb\n", $mpfr1);
if(lc($buf) eq "1.001011010110100001111010000000p+20\n") {$ok .= 'u'}
else {warn "1u: $buf\n"}

Rmpfr_sprintf($buf, "%.30R*b\n", GMP_RNDD, $mpfr1);
if(lc($buf) eq "1.001011010110100001111010000000p+20\n") {$ok .= 'v'}
else {warn "1v: $buf\n"}

$ret = Rmpfr_printf("hello world", 0);
if($ret == 11) {$ok .= 'w'}
else {warn "1w: $ret\n"}

$ret = Rmpfr_printf("$ul", 0);
if($ret == 3) {$ok .= 'x'}
else {warn "1x: $ret\n"}

$ret = Rmpfr_fprintf(\*STDOUT, "hello world", 0);
if($ret == 11) {$ok .= 'y'}
else {warn "1y: $ret\n"}

$ret = Rmpfr_fprintf(\*STDOUT, "$ul", 0);
if($ret == 3) {$ok .= 'z'}
else {warn "1z: $ret\n"}

$ret = Rmpfr_sprintf($buf, "hello world", 0);
if($ret == 11) {$ok .= 'A'}
else {warn "1A: $ret\n"}
if($buf eq 'hello world') {$ok .= 'B'}
else {warn "1B: $buf\n"}

$ret = Rmpfr_sprintf_ret($buf, "$ul", 0);
if($ret eq '123') {$ok .= 'C'}
else {warn "1C: $ret\n"}
if($buf eq "123\0o world") {$ok .= 'D'}
else {warn "1D: $buf\n"}

Rmpfr_printf("\n", 0); # Otherwise Test::Harness gets confused
if($ok eq 'abcdefghijklmnopqrstuvwxyzABCD') {print "ok 1\n"}
else {
  warn "got: $ok\n";
  print "not ok 1 $ok\n";
}

$ok = '';

my $mbi = Math::BigInt->new(123);
eval {Rmpfr_printf("%RNd", $mbi);};
if($@ =~ /Unrecognised object/) {$ok .= 'a'}
else {warn "2a got: $@\n"}

eval {Rmpfr_fprintf(\*STDOUT, "%RDd", $mbi);};
if($@ =~ /Unrecognised object/) {$ok .= 'b'}
else {warn "2b got: $@\n"}

eval {Rmpfr_sprintf($buf, "%RNd", $mbi);};
if($@ =~ /Unrecognised object/) {$ok .= 'c'}
else {warn "2c got: $@\n"}

eval {Rmpfr_sprintf_ret($buf, "%RUd", $mbi);};
if($@ =~ /Unrecognised object/) {$ok .= 'd'}
else {warn "2d got: $@\n"}

eval {Rmpfr_fprintf(\*STDOUT, "%R*d", GMP_RNDN, $mbi, $ul);};
if($@ =~ /must take 3 or 4 arguments/) {$ok .= 'e'}
else {warn "2e got: $@\n"}

eval {Rmpfr_sprintf($buf, "%R*d", GMP_RNDN, $mbi, $ul);};
if($@ =~ /must take 3 or 4 arguments/) {$ok .= 'f'}
else {warn "2f got: $@\n"}

eval {Rmpfr_sprintf_ret("%RNd", $mbi);};
if($@ =~ /must take 3 or 4 arguments/) {$ok .= 'g'}
else {warn "2g got: $@\n"}

eval {Rmpfr_fprintf(\*STDOUT, "%R*d", 4, $mbi);};
if(MPFR_VERSION_MAJOR >= 3) {
  if($@ =~ /Unrecognised object supplied/) {$ok .= 'h'}
  else {warn "2h got: $@\n"}
}
else {
  if($@ =~ /Invalid 3rd argument/) {$ok .= 'h'}
  else {warn "2h got: $@\n"}
}

eval {Rmpfr_sprintf($buf, "%R*d", 4, $mbi);};
if(MPFR_VERSION_MAJOR >= 3) {
  if($@ =~ /Unrecognised object supplied/) {$ok .= 'i'}
  else {warn "2i got: $@\n"}
}
else {
  if($@ =~ /Invalid 3rd argument/) {$ok .= 'i'}
  else {warn "2i got: $@\n"}
}

eval {Rmpfr_printf("%R*d", 4, $mbi);};
if(MPFR_VERSION_MAJOR >= 3) {
  if($@ =~ /Unrecognised object supplied/) {$ok .= 'j'}
  else {warn "2j got: $@\n"}
}
else {
  if($@ =~ /Invalid 2nd argument/) {$ok .= 'j'}
  else {warn "2j got: $@\n"}
}

if($ok eq 'abcdefghij') {print "ok 2\n"}
else {print "not ok 2 $ok\n"}

# $mpfr1 contains the value 1.234567625e6.

$ok = '';

$buf = 'X' x 10;
$ret = Rmpfr_snprintf_ret($buf, 5, "%.0Rf", $mpfr1);

if($ret eq '1234') {$ok .= 'a'}
else {warn "3a: $ret\n"}

$ret = Rmpfr_snprintf($buf, 6, "%.0Rf", $mpfr1);

if($ret == 7) {$ok .= 'b'}
else {warn "3b: $ret\n"}

if($buf eq '12345') {$ok .= 'c'}
else {warn "3c: $buf\n"}

if($ok eq 'abc') {print "ok 3\n"}
else {print "not ok 3\n"}

$ok = '';

$buf = 'X' x 10;
$ret = Rmpfr_snprintf_ret($buf, 7, "%.0R*f", GMP_RNDD, $mpfr1);

if($ret eq '123456') {$ok .= 'a'}
else {warn "4a: $ret\n"}

$ret = Rmpfr_snprintf($buf, 6, "%.0R*f", GMP_RNDD, $mpfr1 / 10);

if($ret == 6) {$ok .= 'b'}
else {warn "4b: $ret\n"}

if($buf eq '12345') {$ok .= 'c'}
else {warn "4c: $buf\n"}

if($ok eq 'abc') {print "ok 4\n"}
else {print "not ok 4\n"}