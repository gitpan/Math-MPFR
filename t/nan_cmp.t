use strict;
use warnings;
use Math::MPFR qw(:mpfr);

print "1..2\n";

print  "# Using Math::MPFR version ", $Math::MPFR::VERSION, "\n";
print  "# Using mpfr library version ", MPFR_VERSION_STRING, "\n";
print  "# Using gmp library version ", Math::MPFR::gmp_v(), "\n";

my $nan = Math::MPFR->new();
my $zero = Math::MPFR->new(0);
my $one = Math::MPFR->new(1);

my $ok = '';

if($nan == $zero || $nan == 0) {$ok .= 'A'}
if($nan <  $zero || $nan <  0) {$ok .= 'B'}
if($nan <= $zero || $nan <= 0) {$ok .= 'C'}
if($nan <  $zero || $nan <  0) {$ok .= 'D'}
if($nan <= $zero || $nan <= 0) {$ok .= 'E'}

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
if($nan <= $nan) {$ok .= 'x'}

if($ok eq 'abcdefgh') {print "ok 1\n"}
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




