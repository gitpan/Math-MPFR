use ExtUtils::MakeMaker;
use Config;

### NOTE ###
# '-lgcc' is simply MinGW\lib\libgcc.a renamed (copied) to 
# 'libgcc.lib' and placed where the MSVC compiler can find it.
# '-lcoldname' is simply MinGW\lib\libcoldname.a renamed (copied) to
# 'libcoldname.lib' and placed where the MSVC compiler can find it.
############

if($Config{'cc'} =~ /cl/) {$libs = '-lmpfr -lgmp -lgcc -lcoldname'}
else {$libs = '-lmpfr -lgmp'}

my %options = %{       
{
  NAME => 'Math::MPFR',
  DEFINE   => $] < 5.008 ? "-DOLDPERL" : "-DNEWPERL",
  LIBS => [
    $libs
  ],
  'VERSION' => '1.04',
}
};
WriteMakefile(%options);

# Remove the Makefile dependency. Causes problems on a few systems.
sub MY::makefile { '' }
