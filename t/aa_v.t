use warnings;
use strict;

print "1..1\n";

eval {use Math::MPFR::V;};

if($@) {
  warn "\$\@: $@";
  print "not ok 1\n";
}
else {
  warn "\nGMP Header version (major): ", Math::MPFR::V::___GNU_MP_VERSION(), "\n";
  warn "GMP Header version (minor): ", Math::MPFR::V::___GNU_MP_VERSION_MINOR(), "\n";
  warn "GMP Header version (patchlevel): ", Math::MPFR::V::___GNU_MP_VERSION_PATCHLEVEL(), "\n";
  warn "GMP Library version: ", Math::MPFR::V::gmp_v(), "\n";
  warn "GMP CC: ", Math::MPFR::V::___GMP_CC(), "\n";
  warn "GMP CFLAGS: ", Math::MPFR::V::___GMP_CFLAGS(), "\n";

  warn "MPFR Header version (major): ", Math::MPFR::V::_MPFR_VERSION_MAJOR(), "\n";
  warn "MPFR Header version (minor): ", Math::MPFR::V::_MPFR_VERSION_MINOR(), "\n";
  warn "MPFR Header version (patchlevel): ", Math::MPFR::V::_MPFR_VERSION_PATCHLEVEL(), "\n";
  warn "MPFR Library version: ", Math::MPFR::V::Rmpfr_get_version(), "\n";
  print "ok 1\n";
}