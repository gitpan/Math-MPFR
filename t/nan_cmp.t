use strict;
use warnings;
use Math::MPFR qw(:mpfr);

print "1..6\n";

print  "# Using Math::MPFR version ", $Math::MPFR::VERSION, "\n";
print  "# Using mpfr library version ", MPFR_VERSION_STRING, "\n";
print  "# Using gmp library version ", Math::MPFR::gmp_v(), "\n";

my $nan = Math::MPFR->new();
my $zero = Math::MPFR->new(0);
my $one = Math::MPFR->new(1);
my $negtwo = -$one;
$negtwo --;
my $postwo = $one + 1;
my $posinf = $one / $zero;
my $neginf = -$posinf;
my $temp = Math::MPFR->new();

my $ok = '';

if($nan == $zero || $nan == 0 || $zero / $zero == 0) {$ok .= 'A'}
if($nan <  $zero || $nan <  0 || $zero / $zero <  0) {$ok .= 'B'}
if($nan <= $zero || $nan <= 0 || $zero / $zero <= 0) {$ok .= 'C'}
if($nan >  $zero || $nan >  0 || $zero / $zero >  0) {$ok .= 'D'}
if($nan >= $zero || $nan >= 0 || $zero / $zero >= 0) {$ok .= 'E'}

if(Rmpfr_erangeflag_p()) {$ok .= 'F'}

$ok .= $nan <=> $zero ? 'G' : 'a';

if(Rmpfr_erangeflag_p()) {$ok .= 'b'}
Rmpfr_clear_erangeflag();
if(Rmpfr_erangeflag_p()) {$ok .= 'H'}

$ok .= $nan <=> 0 ? 'I' : 'c';

if(Rmpfr_erangeflag_p()) {$ok .= 'd'}
Rmpfr_clear_erangeflag();
if(Rmpfr_erangeflag_p()) {$ok .= 'J'}

###########################

$ok .= $nan <=> $one ? 'K' : 'e';

if(Rmpfr_erangeflag_p()) {$ok .= 'f'}
Rmpfr_clear_erangeflag();
if(Rmpfr_erangeflag_p()) {$ok .= 'L'}

$ok .= $nan <=> 1 ? 'M' : 'g';

if(Rmpfr_erangeflag_p()) {$ok .= 'h'}
Rmpfr_clear_erangeflag();
if(Rmpfr_erangeflag_p()) {$ok .= 'N'}

if($nan == $one || $nan == 1) {$ok .= 'O'}
if($nan <  $one || $nan <  1) {$ok .= 'P'}
if($nan <= $one || $nan <= 1) {$ok .= 'Q'}
if($nan <  $one || $nan <  1) {$ok .= 'R'}
if($nan <= $one || $nan <= 1) {$ok .= 'S'}

if($nan == $nan) {$ok .= 'T'}
if($nan <  $nan) {$ok .= 'U'}
if($nan <= $nan) {$ok .= 'V'}
if($nan <  $nan) {$ok .= 'W'}
if($nan <= $nan) {$ok .= 'X'}

$ok .= $zero / $zero <=> 1 ? 'Y' : 'i';
$ok .= Rmpfr_nan_p($zero / $zero) ? 'j' : 'Z';
Rmpfr_clear_erangeflag();

if($ok eq 'abcdefghij') {print "ok 1\n"}
else {print "not ok 1 $ok\n"}

$ok = '';

if($nan != $zero) {$ok .= 'a'}
if($nan != 0)     {$ok .= 'b'}
if($nan != $one)  {$ok .= 'c'}
if($nan != 1)     {$ok .= 'd'}
if(!$nan)         {$ok .= 'e'}
if($nan)          {$ok .= 'A'}

if(Rmpfr_erangeflag_p()) {$ok .= 'B'}

if($ok eq 'abcde') {print "ok 2\n"}
else {print "not ok 2 $ok\n"}

my $nan2 = Math::MPFR->new('nan');

if(Rmpfr_nan_p($nan2)) {print "ok 3\n"}
else {print "not ok 3 $nan2\n"}

if((1 ** $nan) == 1) {print "ok 4\n"}
else {print "not ok 4 ", 1 ** $nan, "\n"}

if(Rmpfr_nan_p(2 ** $nan)) {print "ok 5\n"}
else {print "not ok 5", 2 ** $nan, "\n"}

$ok = '';

if(Rmpfr_nan_p($posinf / $posinf)) {$ok .= 'a'}
else {warn "a: ", $posinf / $posinf, "\n"}

if(Rmpfr_nan_p($posinf / $neginf)) {$ok .= 'b'}
else {warn "b: ", $posinf / $neginf, "\n"}

if(Rmpfr_nan_p($neginf / $posinf)) {$ok .= 'c'}
else {warn "c: ", $neginf / $posinf, "\n"}

if(Rmpfr_nan_p($neginf / $neginf)) {$ok .= 'd'}
else {warn "d: ", $neginf / $neginf, "\n"}

if(Rmpfr_nan_p($zero * $posinf)) {$ok .= 'e'}
else {warn "e: ", $zero * $posinf, "\n"}

if(Rmpfr_nan_p($zero * $neginf)) {$ok .= 'f'}
else {warn "f: ", $zero * $neginf, "\n"}

if(Rmpfr_nan_p($neginf + $posinf)) {$ok .= 'g'}
else {warn "g: ", $neginf + $posinf, "\n"}

if(Rmpfr_nan_p($neginf - $neginf)) {$ok .= 'h'}
else {warn "h: ", $neginf - $neginf, "\n"}

if(Rmpfr_nan_p($posinf - $posinf)) {$ok .= 'i'}
else {warn "i: ", $posinf - $posinf, "\n"}

if(Rmpfr_nan_p(sqrt($negtwo))) {$ok .= 'j'}
else {warn "j: ", sqrt($negtwo), "\n"}

if(Rmpfr_nan_p(log($negtwo))) {$ok .= 'k'}
else {warn "k: ", log($negtwo), "\n"}

Rmpfr_log2($temp, $negtwo, GMP_RNDN);
if(Rmpfr_nan_p($temp)) {$ok .= 'l'}
else {warn "l: ", $temp, "\n"}

Rmpfr_log10($temp, $negtwo, GMP_RNDN);
if(Rmpfr_nan_p($temp)) {$ok .= 'm'}
else {warn "m: ", $temp, "\n"}

Rmpfr_acos($temp, $negtwo, GMP_RNDN);
if(Rmpfr_nan_p($temp)) {$ok .= 'n'}
else {warn "n: ", $temp, "\n"}

Rmpfr_asin($temp, $negtwo, GMP_RNDN);
if(Rmpfr_nan_p($temp)) {$ok .= 'o'}
else {warn "o: ", $temp, "\n"}

Rmpfr_acos($temp, $postwo, GMP_RNDN);
if(Rmpfr_nan_p($temp)) {$ok .= 'p'}
else {warn "p: ", $temp, "\n"}

Rmpfr_asin($temp, $postwo, GMP_RNDN);
if(Rmpfr_nan_p($temp)) {$ok .= 'q'}
else {warn "q: ", $temp, "\n"}

if($nan ** 0 == 1) {$ok .= 'r'}
else {warn "r: ", $nan ** 0, "\n"}

if($ok eq 'abcdefghijklmnopqr') {print "ok 6\n"}
else {print "not ok 6 $ok\n"}



