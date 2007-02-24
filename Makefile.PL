use ExtUtils::MakeMaker;
use Config;
require 5.006;

$use_64_bit_int = 0; # Let perl decide whether to include 64-bit 'long long' support
$use_long_double = 0;# Let perl decide whether to include 'long double' support

#$use_64_bit_int = -1; # Force exclusion of 64-bit 'long long' support
#$use_long_double = -1;# Force exclusion of 'long double' support

#$use_64_bit_int = 1; # Force inclusion of 64-bit 'long long' support
#$use_long_double = 1;# Force inclusion of 'long double' support


$| = 1;

print "Checking for a C compiler ....";

if(!have_compiler()) {
  die "

******************************************
Could not find your $Config{cc} compiler.
If you know this is not an issue then feel
free to modify the Makefile.PL to exclude
this test, and then re-run the Makefile.PL.

If the author has made a mistake in the
construction of this test, please let him
know:
sisyphus at cpan dot org
******************************************
";
  }
else {print ".. found\n"}

print "Looking for GMP and MPFR libraries ...";

if(!have_libraries()) {
  die "

******************************************
Couldn't find libgmp and/or libmpfr -
both of which are required for Math::MPFR.

To obtain GMP go to:
http://swox.com/gmp/

To obtain MPFR go to:
http://www.mpfr.org/

If you have these 2 libraries installed,
then apparently one (or both) was not
found. Check the README for instructions.
If the instructions are incorrect, please
notify the author:
sisyphus at cpan dot org

You can, of course, modify Makefile.PL so 
that this test is not conducted - then
re-run it.
******************************************
";
}
else {print "... libraries found\n"}

print "Checking that your MPFR library is up to date ...";

$v_ok = get_version();

if($v_ok == 2) {print ".. ok - up to date\n"}

if($v_ok == 1) {
  die "

In attempting to determine your MPFR version, the
executable did not compile. This would indicate that
you don't have a sufficiently recent version of MPFR. 
You need MPFR version 2.2.0 or higher. Get it from:

http://www.mpfr.org/

Alternatively, if you think there's an error in 
this check procedure, then edit the Makefile.PL
to exclude this check, re-run it, and please 
inform the author:
sisyphus at cpan dot org
";
}

if($v_ok == 0) {
  die "

You need MPFR version 2.2.0 or higher. Get it from:

http://www.mpfr.org/

Alternatively, if you think there's an error in 
this check procedure, then edit the Makefile.PL
to exclude this check, re-run it, and please 
inform the author:
sisyphus at cpan dot org
";
}

my $defines = $] < 5.008 ? "-DOLDPERL" : "-DNEWPERL";

if($use_64_bit_int == -1) {}                                
elsif($use_64_bit_int == 1) {$defines .= " -DUSE_64_BIT_INT"}
else {
  if($Config::Config{use64bitint} eq 'define' || 
     $Config::Config{use64bitall} eq 'define' ||
     $Config::Config{ivsize} == 8 ||
     $Config::Config{usemorebits} eq 'define') {$defines .= " -DUSE_64_BIT_INT"}
}

if($use_long_double == -1) {}
elsif($use_long_double == 1) {$defines .= " -DUSE_LONG_DOUBLE"}
else {
  if($Config::Config{uselongdouble} eq 'define' ||
     $Config::Config{longdblsize} == $Config::Config{doublesize} ||
     $Config::Config{usemorebits} eq 'define') {$defines .= " -DUSE_LONG_DOUBLE"}
}

$defines =~ /-DUSE_64_BIT_INT/ ? print "Building with 64-bit'long long' support\n" :
                                 print "Building without 64-bit 'long long' support\n";

print "If this is wrong, see the \"64-bit support\" section in the README\n\n";

$defines =~ /-DUSE_LONG_DOUBLE/ ? print "Building with 'long double' support\n" :
                                 print "Building without 'long double' support\n";

print "If this is wrong, see the \"64-bit support\" section in the README\n\n";

my %options = (       
  NAME => 'Math::MPFR',
  DEFINE   => $defines,
  LIBS => [
    '-lmpfr -lgmp'
  ],
  VERSION_FROM => 'MPFR.pm',
  clean   => { FILES => 'comp.exe check.exe version.exe' },
);

WriteMakefile(%options);

# Remove the Makefile dependency. Causes problems on a few systems.
sub MY::makefile { '' }

sub have_compiler {
    if($^O =~ /mswin32/i) {
      if(system("$Config{cc} -o comp.exe comp.c >NUL 2>&1") == 0) {return 1}
      else {return 0}
      }

    else {
      if(system("$Config{cc} -o comp.exe comp.c 2>/dev/null") == 0) {return 1}
      else {return 0}
      }
}

sub have_libraries {
    my $CC = $Config{cc};
    my %args = map{split /\s*=\s*/} @ARGV;
    my $LIBS = $args{LIBS} || '-lmpfr -lgmp';
    my $INC = $args{INC};

    if($^O =~ /mswin32/i) {
      if($CC eq 'cl') {
        $INC =~ s/-I/\/I/g;
        if($LIBS eq '-lmpfr -lgmp') {$LIBS = 'libmpfr.lib libgmp.lib'}
        else {
          $LIBS =~ s/-L//g;
          $LIBS =~ s/ -lmpfr/\/libmpfr.lib/;
          $LIBS =~ s/ -lgmp/\/libgmp.lib/;
          }

        if(system("$CC -o check.exe check.c $INC $LIBS >NUL 2>&1") == 0) {return 1}
        else {return 0}
        }
      if(system("$CC -o check.exe check.c $INC $LIBS >NUL 2>&1") == 0) {return 1}
      else {return 0}
      }

    else {
      if(system("$CC -o check.exe check.c $INC $LIBS 2>/dev/null") == 0) {return 1}
      else {return 0}
      }
}

sub get_version {
    my $CC = $Config{cc};
    my %args = map{split /\s*=\s*/} @ARGV;
    my $LIBS = $args{LIBS} || '-lmpfr -lgmp';
    my $INC = $args{INC};

    if($^O =~ /mswin32/i) {
      if($CC eq 'cl') {
        $INC =~ s/-I/\/I/g;
        if($LIBS eq '-lmpfr -lgmp') {$LIBS = 'libmpfr.lib libgmp.lib'}
        else {
          $LIBS =~ s/-L//g;
          $LIBS =~ s/ -lmpfr/\/libmpfr.lib/;
          $LIBS =~ s/ -lgmp/\/libgmp.lib/;
          }
        unless(system("$CC -o version.exe version.c $INC $LIBS >NUL 2>&1") == 0) {return 1}
        my $v = `version.exe`;
        my @v = split /\./, $v;
        if($v[0] > 2 || ($v[0] == 2 && $v[1] >= 2 && $v[2] >= 0)) {return 2}
        print "\nYou have MPFR version $v\n";
        return 0;
        }
      unless(system("$CC -o version.exe version.c $INC $LIBS >NUL 2>&1") == 0) {return 1}
      my $v = `version.exe`;
      my @v = split /\./, $v;
      if($v[0] > 2 || ($v[0] == 2 && $v[1] >= 2 && $v[2] >= 0)) {return 2}
      print "\nYou have MPFR version $v\n";
      return 0;
      }

    else {
      unless(system("$CC -o version.exe version.c $INC $LIBS 2>/dev/null") == 0) {return 1}
      my $v = `./version.exe`;
      my @v = split /\./, $v;
      if($v[0] > 2 || ($v[0] == 2 && $v[1] >= 2 && $v[2] >= 0)) {return 2}
      print "\nYou have MPFR version $v\n";
      return 0;
      }
}
