    package Math::MPFR;
    use strict;
    use warnings;

    use constant GMP_RNDN => 0;
    use constant GMP_RNDZ => 1;
    use constant GMP_RNDU => 2;
    use constant GMP_RNDD => 3;

    use overload
    '+'    => \&overload_add,
    '-'    => \&overload_sub,
    '*'    => \&overload_mul,
    '/'    => \&overload_div,
    '+='   => \&overload_add_eq,
    '-='   => \&overload_sub_eq,
    '*='   => \&overload_mul_eq,
    '/='   => \&overload_div_eq,
    '""'   => \&overload_string,
    '>'    => \&overload_gt,
    '>='   => \&overload_gte,
    '<'    => \&overload_lt,
    '<='   => \&overload_lte,
    '<=>'  => \&overload_spaceship,
    '=='   => \&overload_equiv,
    '!='   => \&overload_not_equiv,
    '!'    => \&overload_not,
    'not'  => \&overload_not,
    '='    => \&overload_copy,
    'abs'  => \&overload_abs,
    '**'   => \&overload_pow,
    '**='  => \&overload_pow_eq,
    'atan2'=> \&overload_atan2,
    'cos'  => \&overload_cos,
    'sin'  => \&overload_sin,
    'log'  => \&overload_log,
    'exp'  => \&overload_exp,
    'int'  => \&overload_int,
    'sqrt' => \&overload_sqrt;

    require Exporter;
    require DynaLoader;

    @Math::MPFR::ISA = qw(Exporter DynaLoader);
    @Math::MPFR::EXPORT_OK = qw(GMP_RNDN GMP_RNDZ GMP_RNDU GMP_RNDD
Rmpfr_set_default_rounding_mode Rmpfr_prec_round Rmpfr_get_emin
Rmpfr_get_default_rounding_mode 
Rmpfr_get_emax Rmpfr_set_emin Rmpfr_set_emax Rmpfr_check_range
Rmpfr_clear_underflow Rmpfr_clear_overflow Rmpfr_clear_nanflag
Rmpfr_clear_inexflag Rmpfr_clear_flags Rmpfr_underflow_p
Rmpfr_overflow_p Rmpfr_nanflag_p Rmpfr_inexflag_p 
Rmpfr_set_default_prec Rmpfr_get_default_prec Rmpfr_init
Rmpfr_init_set Rmpfr_init_set_ui Rmpfr_init_set_si Rmpfr_init_set_d
Rmpfr_init_set_z Rmpfr_init_set_q Rmpfr_init_set_f Rmpfr_init_set_str
Rmpfr_init2 Rmpfr_set_prec Rmpfr_get_prec Rmpfr_set_prec_raw
Rmpfr_init_nobless Rmpfr_init2_nobless Rmpfr_clear
Rmpfr_init_set_nobless Rmpfr_init_set_ui_nobless Rmpfr_init_set_si_nobless
Rmpfr_init_set_d_nobless Rmpfr_init_set_z_nobless Rmpfr_init_set_q_nobless
Rmpfr_init_set_f_nobless Rmpfr_init_set_str_nobless
Rmpfr_min_prec Rmpfr_max_prec Rmpfr_set Rmpfr_set_ui Rmpfr_set_si
Rmpfr_set_d Rmpfr_set_z Rmpfr_set_q Rmpfr_set_f Rmpfr_set_str
Rmpfr_set_str_binary Rmpfr_set_inf Rmpfr_set_nan Rmpfr_swap
Rmpfr_get_str Rmpfr_get_d Rmpfr_get_d1 Rmpfr_get_z_exp Rmpfr_out_str Rmpfr_inp_str
Rmpfr_add Rmpfr_add_ui Rmpfr_add_z Rmpfr_add_q Rmpfr_sub Rmpfr_sub_ui
Rmpfr_sub_z Rmpfr_sub_q Rmpfr_ui_sub Rmpfr_mul Rmpfr_mul_ui
Rmpfr_mul_z Rmpfr_mul_q Rmpfr_div Rmpfr_div_ui Rmpfr_div_z
Rmpfr_div_q Rmpfr_ui_div Rmpfr_sqrt Rmpfr_cbrt Rmpfr_sqrt_ui Rmpfr_pow_ui
Rmpfr_ui_pow_ui Rmpfr_ui_pow Rmpfr_pow_si Rmpfr_pow Rmpfr_neg
Rmpfr_abs Rmpfr_mul_2exp Rmpfr_mul_2ui Rmpfr_mul_2si Rmpfr_div_2exp
Rmpfr_div_2ui Rmpfr_div_2si Rmpfr_cmp Rmpfr_cmpabs Rmpfr_cmp_ui Rmpfr_cmp_si
Rmpfr_cmp_ui_2exp Rmpfr_cmp_si_2exp Rmpfr_eq Rmpfr_nan_p Rmpfr_inf_p
Rmpfr_number_p Rmpfr_reldiff Rmpfr_sgn
Rmpfr_greater_p Rmpfr_greaterequal_p Rmpfr_less_p Rmpfr_lessequal_p
Rmpfr_lessgreater_p Rmpfr_equal_p Rmpfr_unordered_p
Rmpfr_log Rmpfr_exp Rmpfr_exp2 Rmpfr_sin Rmpfr_cos Rmpfr_tan
Rmpfr_sin_cos Rmpfr_acos Rmpfr_asin Rmpfr_atan Rmpfr_cosh Rmpfr_sinh
Rmpfr_tanh Rmpfr_acosh Rmpfr_asinh Rmpfr_atanh Rmpfr_fac_ui
Rmpfr_log1p Rmpfr_expm1 Rmpfr_log2 Rmpfr_log10 Rmpfr_fma Rmpfr_agm
Rmpfr_gamma Rmpfr_zeta Rmpfr_erf
Rmpfr_const_log2 Rmpfr_const_pi Rmpfr_const_euler
Rmpfr_print_binary Rmpfr_rint Rmpfr_ceil Rmpfr_floor Rmpfr_round
Rmpfr_trunc Rmpfr_add_one_ulp Rmpfr_sub_one_ulp Rmpfr_can_round
Rmpfr_frac Rmpfr_integer_p Rmpfr_nexttoward Rmpfr_nextabove 
Rmpfr_next_below Rmpfr_min Rmpfr_max Rmpfr_get_exp Rmpfr_set_exp
Rgmp_randinit_default Rgmp_randinit_lc_2exp Rgmp_randinit_lc_2exp_size
Rgmp_randseed Rgmp_randseed_ui Rgmp_randclear
Rmpfr_urandomb Rmpfr_random2 Rmpfr_dump
Rmpfr_set_ui_2exp Rmpfr_set_si_2exp Rmpfr_get_z Rmpfr_si_sub 
Rmpfr_sub_si Rmpfr_mul_si Rmpfr_si_div Rmpfr_div_si Rmpfr_sqr
Rmpfr_cmp_z Rmpfr_cmp_q Rmpfr_cmp_f Rmpfr_zero_p Rmpfr_free_cache
Rmpfr_get_version Rmpfr_get_emin_min Rmpfr_get_emin_max 
Rmpfr_get_emax_min Rmpfr_get_emax_max Rmpfr_clear_erangeflag
Rmpfr_erangeflag_p Rmpfr_rint_round Rmpfr_rint_trunc
Rmpfr_rint_ceil Rmpfr_rint_floor);
    $Math::MPFR::VERSION = '1.04';

    bootstrap Math::MPFR $Math::MPFR::VERSION;

    %Math::MPFR::EXPORT_TAGS =(mpfr => [qw(
GMP_RNDN GMP_RNDZ GMP_RNDU GMP_RNDD
Rmpfr_set_default_rounding_mode Rmpfr_prec_round Rmpfr_get_emin
Rmpfr_get_default_rounding_mode 
Rmpfr_get_emax Rmpfr_set_emin Rmpfr_set_emax Rmpfr_check_range
Rmpfr_clear_underflow Rmpfr_clear_overflow Rmpfr_clear_nanflag
Rmpfr_clear_inexflag Rmpfr_clear_flags Rmpfr_underflow_p
Rmpfr_overflow_p Rmpfr_nanflag_p Rmpfr_inexflag_p
Rmpfr_set_default_prec Rmpfr_get_default_prec Rmpfr_init
Rmpfr_init_set Rmpfr_init_set_ui Rmpfr_init_set_si Rmpfr_init_set_d
Rmpfr_init_set_z Rmpfr_init_set_q Rmpfr_init_set_f Rmpfr_init_set_str
Rmpfr_init2 Rmpfr_set_prec Rmpfr_get_prec Rmpfr_set_prec_raw
Rmpfr_init_nobless Rmpfr_init2_nobless Rmpfr_clear
Rmpfr_init_set_nobless Rmpfr_init_set_ui_nobless Rmpfr_init_set_si_nobless
Rmpfr_init_set_d_nobless Rmpfr_init_set_z_nobless Rmpfr_init_set_q_nobless
Rmpfr_init_set_f_nobless Rmpfr_init_set_str_nobless
Rmpfr_min_prec Rmpfr_max_prec Rmpfr_set Rmpfr_set_ui Rmpfr_set_si
Rmpfr_set_d Rmpfr_set_z Rmpfr_set_q Rmpfr_set_f Rmpfr_set_str
Rmpfr_set_str_binary Rmpfr_set_inf Rmpfr_set_nan Rmpfr_swap Rmpfr_out_str Rmpfr_inp_str
Rmpfr_get_str Rmpfr_get_d Rmpfr_get_d1 Rmpfr_get_z_exp
Rmpfr_add Rmpfr_add_ui Rmpfr_add_z Rmpfr_add_q Rmpfr_sub Rmpfr_sub_ui
Rmpfr_sub_z Rmpfr_sub_q Rmpfr_ui_sub Rmpfr_mul Rmpfr_mul_ui
Rmpfr_mul_z Rmpfr_mul_q Rmpfr_div Rmpfr_div_ui Rmpfr_div_z
Rmpfr_div_q Rmpfr_ui_div Rmpfr_sqrt Rmpfr_cbrt Rmpfr_sqrt_ui Rmpfr_pow_ui
Rmpfr_ui_pow_ui Rmpfr_ui_pow Rmpfr_pow_si Rmpfr_pow Rmpfr_neg
Rmpfr_abs Rmpfr_mul_2exp Rmpfr_mul_2ui Rmpfr_mul_2si Rmpfr_div_2exp
Rmpfr_div_2ui Rmpfr_div_2si Rmpfr_cmp Rmpfr_cmpabs Rmpfr_cmp_ui Rmpfr_cmp_si
Rmpfr_cmp_ui_2exp Rmpfr_cmp_si_2exp Rmpfr_eq Rmpfr_nan_p Rmpfr_inf_p
Rmpfr_number_p Rmpfr_reldiff Rmpfr_sgn
Rmpfr_greater_p Rmpfr_greaterequal_p Rmpfr_less_p Rmpfr_lessequal_p
Rmpfr_lessgreater_p Rmpfr_equal_p Rmpfr_unordered_p
Rmpfr_log Rmpfr_exp Rmpfr_exp2 Rmpfr_sin Rmpfr_cos Rmpfr_tan
Rmpfr_sin_cos Rmpfr_acos Rmpfr_asin Rmpfr_atan Rmpfr_cosh Rmpfr_sinh
Rmpfr_tanh Rmpfr_acosh Rmpfr_asinh Rmpfr_atanh Rmpfr_fac_ui
Rmpfr_log1p Rmpfr_expm1 Rmpfr_log2 Rmpfr_log10 Rmpfr_fma Rmpfr_agm
Rmpfr_gamma Rmpfr_zeta Rmpfr_erf
Rmpfr_const_log2 Rmpfr_const_pi Rmpfr_const_euler
Rmpfr_print_binary Rmpfr_rint Rmpfr_ceil Rmpfr_floor Rmpfr_round
Rmpfr_trunc Rmpfr_add_one_ulp Rmpfr_sub_one_ulp Rmpfr_can_round
Rmpfr_frac Rmpfr_integer_p Rmpfr_nexttoward Rmpfr_nextabove 
Rmpfr_next_below Rmpfr_min Rmpfr_max Rmpfr_get_exp Rmpfr_set_exp
Rgmp_randinit_default Rgmp_randinit_lc_2exp Rgmp_randinit_lc_2exp_size
Rgmp_randseed Rgmp_randseed_ui Rgmp_randclear
Rmpfr_urandomb Rmpfr_random2 Rmpfr_dump
Rmpfr_set_ui_2exp Rmpfr_set_si_2exp Rmpfr_get_z Rmpfr_si_sub 
Rmpfr_sub_si Rmpfr_mul_si Rmpfr_si_div Rmpfr_div_si Rmpfr_sqr
Rmpfr_cmp_z Rmpfr_cmp_q Rmpfr_cmp_f Rmpfr_zero_p Rmpfr_free_cache
Rmpfr_get_version Rmpfr_get_emin_min Rmpfr_get_emin_max 
Rmpfr_get_emax_min Rmpfr_get_emax_max Rmpfr_clear_erangeflag
Rmpfr_erangeflag_p Rmpfr_rint_round Rmpfr_rint_trunc
Rmpfr_rint_ceil Rmpfr_rint_floor
)]);

sub Rmpfr_get_str {
    my @ret = Rmpfr_deref2($_[0], $_[1], $_[2], $_[3]);

    if(!$_[2]) {
      my $len = 1;
      if(substr($ret[0], 0, 1) eq '-') {$len = 2}
      while(length($ret[0]) > $len && substr($ret[0], -1, 1) eq '0') {
           substr($ret[0], -1, 1, '');
           }
      }
    if(substr($ret[0], 0, 1) eq '-') {
       substr($ret[0], 0, 1, '');
       return "-." . $ret[0] . '@' . $ret[1];
       }
    return "." . $ret[0] . '@' . $ret[1];
}

sub overload_string {
   return Rmpfr_get_str($_[0], 10, 0, Rmpfr_get_default_rounding_mode());
}

    use Config;
1;

__END__

=head1 NAME

Math::MPFR - perl interface to the MPFR (floating point) library.

=head1 DESCRIPTION

   A bigfloat module utilising the MPFR library. Basically
   this module simply wraps the 'mpfr' floating point functions
   provided by that library. See:
   http://www.loria.fr/projets/mpfr/mpfr-current/mpfr.html
   Operator overloading is also available.
   The following documentation heavily plagiarises the mpfr
   documentation.
   See also the Math::MPFR test suite for some examples of
   usage.

=head1 SYNOPSIS

   use Math::MPFR qw(:mpfr);

   my $str = '.123542@2'; # mantissa = (.)123452
                         # exponent = 2
   #Alternatively:
   # my $str = '12.3542';

   my $base = 10;
   my $rnd = GMP_RNDZ; # Rounding mode - can be set to
             # one of GMP_RNDN, GMP_RNDZ, GMP_RNDU,
             # GMP_RNDD or to the corresponding numeric
             # value 0, 1, 2, or 3. See 'ROUNDING MODE'

   # Create a Math::MPFR object with precision
   # of 100 bits and an initial value of NaN.
   my $bn1 = Rmpfr_init2(100);

   # Create another Math::MPFR object that holds
   # an initial value of NaN and has the default precision.
   my $bn2 = Rmpfr_init();

   # Create another Math::MPFR object that holds an initial
   # value of $str (in base $base) and has the default
   # precision. $bn3 is the number. The value of $cmp 
   # tells us whether $bn3 is an exact representation of the
   # string value, or whether it is less than (or greater 
   # than) the string value. See 'COMBINED INITIALISATION AND
   # ASSIGNMENT', below.
   my ($bn3, $cmp) = Rmpfr_init_set_str($str, $base, $rnd);

   # Perform some operations ... see 'FUNCTIONS' below.
   # see 'OPERATOR OVERLOADING' below for docs re
   # operator overloading

   .
   .

   # print out the value held by $bn1 (in octal):
   print Rmpfr_get_str($bn1, 8, 0, $rnd), "\n"; 

   # print out the value held by $bn1 (in decimal):
   print Rmpfr_get_str($bn1, 10, 0, $rnd), "\n";
   # or just make use of overloading :
   print $bn1, "\n";

   # print out the value held by $bn1 (in base 16) using the
   # 'Rmpfr_out_str' function. (No newline is printed.)
   Rmpfr_out_str($bn1, 16, 0, $rnd);

=head1 ROUNDING MODE


   One of 4 values:
    GMP_RNDN (numeric value = 0): Round to nearest.
    GMP_RNDZ (numeric value = 1): Round towards zero.
    GMP_RNDU (numeric value = 2): Round up.
    GMP_RNDD (numeric value = 3): Round down.

    The `round to nearest' mode works as in the IEEE
    P754 standard: in case the number to be rounded
    lies exactly in the middle of two representable 
    numbers, it is rounded to the one with the least
    significant bit set to zero.  For example, the 
    number 5, which is represented by (101) in binary,
    is rounded to (100)=4 with a precision of two bits,
    and not to (110)=6.  This rule avoids the "drift"
    phenomenon mentioned by Knuth in volume 2 of 
    The Art of Computer Programming (section 4.2.2,
    pages 221-222).

    Most Math::MPFR functions take as first argument the
    destination variable, as second and following arguments 
    the input variables, as last argument a rounding mode,
    and have a return value of type `int'. If this value
    is zero, it means that the value stored in the 
    destination variable is the exact result of the 
    corresponding mathematical function. If the
    returned value is positive (resp. negative), it means
    the value stored in the destination variable is greater
    (resp. lower) than the exact result.  For example with 
    the `GMP_RNDU' rounding mode, the returned value is 
    usually positive, except when the result is exact, in
    which case it is zero.  In the case of an infinite
    result, it is considered as inexact when it was
    obtained by overflow, and exact otherwise.  A
    NaN result (Not-a-Number) always corresponds to an
    inexact return value.

=head1 MEMORY MANAGEMENT

   Objects are created with Rmpfr_init* functions, which
   return an object that has been blessed into the 
   package Math::MPFR. They will therefore be
   automatically cleaned up by the DESTROY()
   function whenever they go out of scope.

   For each Rmpfr_init* function there is a corresponding function
   called Rmpfr_init*_nobless which returns an unblessed object.
   If you create Math::MPFR objects using the '_nobless'
   versions, it will then be up to you to clean up the memory
   associated with these objects by calling Rmpfr_clear($op) 
   for each object. Alternatively such objects will be
   cleaned up when the script ends. I don't know why you
   would want to create unblessed objects. The point is that
   you can if you want to.

=head1 MIXING GMP OBJECTS WITH MPFR OBJECTS

   Some of the Math::MPFR functions below take as arguments
   one or more of the GMP types mpz (integer), mpq
   (rational) and mpf (floating point). (Such functions are
   marked as taking mpz/mpq/mpf arguments.)
   For these functions to work you need to have loaded either:

   1) Math::GMP from CPAN. (This module provides access to mpz
      objects only - NOT mpf and mpq objects.)

   AND/OR

   2) The GMP module. This module ships with the GMP source
      distribution. It provides access to all 3 types.
      Win32 binaries of it are available from
      http://www.kalinabears.com.au/w32perl/math_gmp.html
   
   AND/OR

   3) Math::GnuMPz (for mpz types), Math::GnuMPq (for mpq types)
      and Math::GnuMPf (for mpf types). These modules (both 
      source code and win32 binaries) are available from 
      http://www.kalinabears.com.au/w32perl/math_gnump.html      

=head1 FUNCTIONS

   These next 3 functions are demonstrated above:
   $rop = Rmpfr_init();
   $rop = Rmpfr_init2($p);
   $str = Rmpfr_get_str($op, $base, $digits, $rnd); # 1 < $base < 37 
   The third argument to Rmpfr_get_str() specifies the number
   of digits required to be output. Up to $digits digits
   will be generated.  Trailing zeros are not returned.  No
   more digits than can be accurately represented by OP are
   ever generated.  If $digits is 0 then that accurate
   maximum number of digits are generated.

   The following functions are simply wrappers around an mpfr
   function of the same name. eg. Rmpfr_swap() is a wrapper around
   mpfr_swap().

   "$rop", "$op1", "$op2", etc. are Math::MPFR objects - the
   return value of one of the Rmpfr_init* functions. They are in fact 
   references to mpfr structures. The "$op" variables are the operands
   and "$rop" is the variable that stores the result of the operation.
   Generally, $rop, $op1, $op2, etc. can be the same perl variable 
   referencing the same mpfr structure, though often they will be 
   distinct perl variables referencing distinct mpfr structures.
   Eg something like Rmpfr_add($r1, $r1, $r1, $rnd),
   where $r1 *is* the same reference to the same mpfr structure,
   would add $r1 to itself and store the result in $r1. Alternatively,
   you could (courtesy of operator overloading) simply code it
   as $r1 += $r1. Otoh, Rmpfr_add($r1, $r2, $r3, $rnd), where each of the
   arguments is a different reference to a different mpfr structure
   would add $r2 to $r3 and store the result in $r1. Alternatively
   it could be coded as $r1 = $r2 + $r3.

   "$ui" means any integer that will fit into a C 'unsigned long int',
   which for most of us means that it will be less than 2**32 and
   greater than or equal to zero.

   "$si" means any integer that will fit into a C 'signed long int'.
   which for most of us means that it will be greater than
   -(2**31) and less than 2**31.

   "$double" is a C double.

   "$bool" means a value (usually a 'signed long int') in which
   the only interest is whether it evaluates as false or true.

   "$str" simply means a string of symbols that represent a number,
   eg "1234567890987654321234567@7" which might be a base 10 number,
   or "zsa34760sdfgq123r5@11" which would have to represent a base 36
   number (because "z" is a valid digit only in base 36). Valid
   bases for MPFR numbers are 2 to 36 (inclusive).
 
   $rnd is simply one of the 4 rounding mode values (discussed above).

   $p is the (unsigned long) value for precision.

   ##############

   ROUNDING MODES

   Rmpfr_set_default_rounding_mode($rnd);
    Sets the default rounding mode to $rnd.
    The default rounding mode is to nearest initially (GMP_RNDN).
    The default rounding mode is the rounding mode that
    is used in overloaded operations.
 
   $si = Rmpfr_get_default_rounding_mode();
    Returns the numeric value (0, 1, 2 or 3) of the
    current default rounding mode. This will initially be 0.

   $si = Rmpfr_prec_round($rop, $p, $rnd); 
    Rounds $rop according to $rnd with precision $p, which may be
    different from that of $rop.  If $p is greater or equal to the
    precision of $rop, then new space is allocated for the mantissa,
    and it is filled with zeroes.  Otherwise, the mantissa is rounded
    to precision $p with the given direction. In both cases, the
    precision of $rop is changed to $p.  The returned value is zero
    when the result is exact, positive when it is greater than the
    original value of $rop, and negative when it is smaller.  The
    precision $p can be any integer between Rmpfr_min_prec() and
    Rmpfr_max_prec().  

   ##########

   EXCEPTIONS

   $si =  Rmpfr_get_emin();
   $si =  Rmpfr_get_emax();
    Return the (current) smallest and largest exponents
    allowed for a floating-point variable.

   $si = Rmpfr_get_emin_min();
   $si = Rmpfr_get_emin_max();
   $si = Rmpfr_get_emax_min();
   $si = Rmpfr_get_emax_max();
    Return the minimum and maximum of the smallest and largest
    exponents allowed for `mpfr_set_emin' and `mpfr_set_emax'. These
    values are implementation dependent

   $bool =  Rmpfr_set_emin($si);
   $bool =  Rmpfr_set_emax($si);
    Set the smallest and largest exponents allowed for a
    floating-point variable.  Return a non-zero value when $si is not
    in the range of exponents accepted by the implementation (in that
    case the smallest or largest exponent is not changed), and zero
    otherwise. If the user changes the exponent range, it is her/his
    responsibility to check that all current floating-point variables
    are in the new allowed range (for example using `Rmpfr_check_range',
    otherwise the subsequent behaviour will be undefined, in the sense
    of the ISO C standard. 

   $si2 = Rmpfr_check_range($op, $si1, $rnd);
    This function has changed from earlier implementations.
    It now forces $op to be in the current range of acceptable
    values, $si1 the current ternary value: negative if $op is
    smaller than the exact value, positive if $op is larger than the
    exact value and zero if $op is exact (before the call). It generates
    an underflow or an overflow if the exponent of $op is outside the
    current allowed range; the value of $si1 may be used to avoid a
    double rounding. This function returns zero if the rounded result
    is equal to the exact one, a positive value if the rounded result
    is larger than the exact one, a negative value if the rounded
    result is smaller than the exact one. Note that unlike most
    functions, the result is compared to the exact one, not the input
    value $op, i.e. the ternary value is propagated.

   Rmpfr_clear_underflow();
   Rmpfr_clear_overflow();
   Rmpfr_clear_nanflag();
   Rmpfr_clear_inexflag();
   Rmpfr_clear_erangeflag()
    Clear the underflow, overflow, invalid, inexact and erange flags.

   Rmpfr_clear_flags();
    Clear all global flags (underflow, overflow, inexact, invalid,
    and erange).

   $bool = Rmpfr_underflow_p();
   $bool = Rmpfr_overflow_p();
   $bool = Rmpfr_nanflag_p();
   $bool = Rmpfr_inexflag_p();
   $bool = Rmpfr_erangeflag_p();
    Return the corresponding (underflow, overflow, invalid, inexact
    or erange) flag, which is non-zero iff the flag is set.

   ##############

   INITIALIZATION

   Normally, a variable should be initialized once only or at least be
   cleared, using `Rmpfr_clear', between initializations.
   'DESTROY' (which calls 'Rmpfr_clear') is automatically called on 
   blessed objects whenever they go out of scope.

   First read the section 'MEMORY MANAGEMENT' (above).

   Rmpfr_set_default_prec($p);
    Set the default precision to be *exactly* $p bits.  The
    precision of a variable means the number of bits used to store its
    mantissa.  All subsequent calls to `mpfr_init' will use this
    precision, but previously initialized variables are unaffected.
    This default precision is set to 53 bits initially.  The precision
    can be any integer between Rmpfr_min_prec() and Rmpfr_max_prec().

   $ui = Rmpfr_get_default_prec();
    Returns the default MPFR precision in bits.

   $rop = Rmpfr_init();
   $rop = Rmpfr_init_nobless();
    Initialize $rop, and set its value to NaN. The precision 
    of $rop is the default precision, which can be changed
    by a call to `Rmpfr_set_default_prec'.

   $rop = Rmpfr_init2($p);
   $rop = Rmpfr_init2_nobless($p);
    Initialize $rop, set its precision to be *exactly* $p bits,
    and set its value to NaN.  To change the precision of a
    variable which has already been initialized,
    use `Rmpfr_set_prec' instead.  The precision PREC can be
    any integer between Rmpfr_min_prec() andRmpfr_max_prec().

   Rmpfr_set_prec($op, $p);
    Reset the precision of $op to be *exactly* $p bits.
    The previous value stored in $op is lost.  The precision
    $p can be any integer between Rmpfr_min_prec() and
    Rmpfr_max_prec(). If you want to keep the previous
    value stored in $op, use 'Rmpfr_prec_round' instead.

   $ui = Rmpfr_get_prec($op);
    Return the precision actually used for assignments of $op,
   i.e. the number of bits used to store its mantissa.

   Rmpfr_set_prec_raw($rop, $p);
    Reset the precision of $rop to be *exactly* $p bits.  The only
    difference with `mpfr_set_prec' is that $p is assumed to be small
    enough so that the mantissa fits into the current allocated
    memory space for $rop. Otherwise an error will occur.

   $minimum_precision = Rmpfr_min_prec();
   $maximum_precision = Rmpfr_max_prec();
    Returns the minimum/maximum allowed precision

   ##########

   ASSIGNMENT

   $si = Rmpfr_set($rop, $op, $rnd);
   $si = Rmpfr_set_ui($rop, $ui, $rnd);
   $si = Rmpfr_set_si($rop, $si, $rnd);
   $si = Rmpfr_set_d($rop, $double, $rnd);
   $si = Rmpfr_set_z($rop, $z, $rnd); # $z is a mpz object.
   $si = Rmpfr_set_q($rop, $q, $rnd); # $q is a mpq object.
   $si = Rmpfr_set_f($rop, $f, $rnd); # $f is a mpf object.
    Set the value of $rop from 2nd arg, rounded to the precision of
    $rop towards the given direction $rnd.  Please note that even a 
    'long int' may have to be rounded if the destination precision
    is less than the machine word width.  The return value is zero
    when $rop=2nd arg, positive when $rop>2nd arg, and negative when 
    $rop<2nd arg.  For `mpfr_set_d', be careful that the input
    number $double may not be exactly representable as a double-precision
    number (this happens for 0.1 for instance), in which case it is
    first rounded by the C compiler to a double-precision number,
    and then only to a mpfr floating-point number.

   $si = Rmpfr_set_ui_2exp($rop, $ui, $exp, $rnd);
   $si = Rmpfr_set_si_2exp($rop, $si1, $exp, $rnd);
    Set the value of $rop from the 2nd arg multiplied by two to the
    power $exp, rounded towards the given direction $rnd.  Note that
    the input 0 is converted to +0.

   $si = Rmpfr_set_str($rop, $str, $base, $rnd);
    Set $rop to the value of $str in base $base (between 2 and
    36), rounded in direction $rnd to the precision of $rop. 
    The exponent is read in decimal.  This function returns 0 if
    the entire string is a valid number in base $base. otherwise
    it returns -1.

   Rmpfr_set_str_binary($rop, $str);
    Set $rop to the value of the binary number in $str, which has to
    be of the form +/-xxxx.xxxxxxEyy. The exponent is read in decimal,
    but is interpreted as the power of two to be multiplied by the
    mantissa.  The mantissa length of $str has to be less or equal to
    the precision of $rop, otherwise an error occurs.  If $str starts
    with `N', it is interpreted as NaN (Not-a-Number); if it starts
    with `I' after the sign, it is interpreted as infinity, with the
    corresponding sign.

   Rmpfr_set_inf($rop, $si);
   Rmpfr_set_nan($rop);
    Set the variable $rop to infinity or NaN (Not-a-Number) respectively.
    In `mpfr_set_inf', $rop is set to plus infinity iff $si is positive.

   Rmpfr_swap($op1, $op2); 
    Swap the values $op1 and $op2 efficiently. Warning: the precisions
    are exchanged too; in case the precisions are different, `mpfr_swap'
    is thus not equivalent to three `mpfr_set' calls using a third
    auxiliary variable.

   ################################################

   COMBINED INITIALIZATION AND ASSIGNMENT

   NOTE: Do NOT use these functions if $rop has already
   been initialised. Use the Rmpfr_set* functions in the
   section 'ASSIGNMENT' (above).

   First read the section 'MEMORY MANAGEMENT' (above).

   ($rop, $si) = Rmpfr_init_set($op, $rnd);
   ($rop, $si) = Rmpfr_init_set_nobless($op, $rnd);
   ($rop, $si) = Rmpfr_init_set_ui($ui, $rnd);
   ($rop, $si) = Rmpfr_init_set_ui_nobless($ui, $rnd);
   ($rop, $si) = Rmpfr_init_set_si($si, $rnd);
   ($rop, $si) = Rmpfr_init_set_si_nobless($si, $rnd);
   ($rop, $si) = Rmpfr_init_set_d($double, $rnd);
   ($rop, $si) = Rmpfr_init_set_d_nobless($double, $rnd);
   ($rop, $si) = Rmpfr_init_set_f($f, $rnd);# $f is a mpf object
   ($rop, $si) = Rmpfr_init_set_f_nobless($f, $rnd);# $f is a mpf object
   ($rop, $si) = Rmpfr_init_set_z($z, $rnd);# $z is a mpz object
   ($rop, $si) = Rmpfr_init_set_z_nobless($z, $rnd);# $z is a mpz object
   ($rop, $si) = Rmpfr_init_set_q($q, $rnd);# $q is a mpq object
   ($rop, $si) = Rmpfr_init_set_q_nobless($q, $rnd);# $q is a mpq object
    Initialize $rop and set its value from the 1st arg, rounded to
    direction $rnd. The precision of $rop will be taken from the
    active default precision, as set by `Rmpfr_set_default_prec'.
    If $rop = 1st arg, $si is zero. If $rop > 1st arg, $si is positive.
    If $rop < 1st arg, $si is negative.

   ($rop, $si) = Rmpfr_init_set_str($str, $base, $rnd);
   ($rop, $si) = Rmpfr_init_set_str_nobless($str, $base, $rnd);
     Initialize $rop and set its value from $str in base $base,
     rounded to direction $rnd.  See `Rmpfr_set_str'.

   ##########
  
   CONVERSION

   $str = Rmpfr_get_str($r, $base, $digits, $rnd); 
    Returns a string of the form, eg, '.83456712@3'
    which means '834.56712'.
    The third argument to Rmpfr_get_str() specifies the number
    of digits required to be output. Up to $digits digits
    will be generated.  Trailing zeros are not returned.  No
    more digits than can be accurately represented by OP are
    ever generated.  If $digits is 0 then that accurate
    maximum number of digits are generated.

   $double = Rmpfr_get_d($op, $rnd);
    Convert $op to a double, using the rounding mode $rnd.

   $double = Rmpfr_get_d1($op);
    Convert $op to a double, using the default MPFR rounding mode
    (see function `mpfr_set_default_rounding_mode').

   $ui = Rmpfr_get_z_exp($z, $op); # $z is a mpz object
    Puts the mantissa of $rop into $z, and returns the exponent 
    $ui such that $rop equals $z multiplied by two exponent $ui.

   Rmpfr_get_z($z, $op, $rnd); # $z is a mpz object.
    Convert $op to an mpz object ($z), after rounding it with respect
    to RND. If $op is NaN or Inf, the result is undefined.

   ##########

   ARITHMETIC

   $si = Rmpfr_add($rop, $op1, $op2, $rnd);
   $si = Rmpfr_add_ui($rop, $op, $ui, $rnd);
   $si = Rmpfr_add_z($rop, $op, $z, $rnd); # $z is a mpz object.
   $si = Rmpfr_add_q($rop, $op, $q, $rnd); # $q is a mpq object.
    Set $rop to 2nd arg + 3rd arg rounded in the direction $rnd.
    The return  value is zero if $rop is exactly 2nd arg + 3rd arg,
    positive if $rop is larger than 2nd arg + 3rd arg, and negative
    if $rop is smaller than 2nd arg + 3rd arg.

   $si = Rmpfr_sub($rop, $op1, $op2, $rnd);
   $si = Rmpfr_sub_ui($rop, $op, $ui, $rnd);
   $si = Rmpfr_sub_z($rop, $op, $z, $rnd); # $z is a mpz object.
   $si = Rmpfr_sub_q($rop, $op, $q, $rnd); # $q is a mpq object.
   $si = Rmpfr_ui_sub($rop, $ui, $op, $rnd);
   $si = Rmpfr_si_sub($rop, $si1, $op, $rnd);
   $si = Rmpfr_sub_si($rop, $op, $si1, $rnd);
    Set $rop to 2nd arg - 3rd arg rounded in the direction $rnd.
    The return value is zero if $rop is exactly 2nd arg - 3rd arg,
    positive if $rop is larger than 2nd arg - 3rd arg, and negative
    if $rop is smaller than 2nd arg - 3rd arg.

   $si = Rmpfr_mul($rop, $op1, $op2, $rnd);
   $si = Rmpfr_mul_ui($rop, $op, $ui, $rnd);
   $si = Rmpfr_mul_si($rop, $op, $si1, $rnd);
   $si = Rmpfr_mul_z($rop, $op, $z, $rnd); # $z is a mpz object.
   $si = Rmpfr_mul_q($rop, $op, $q, $rnd); # $q is a mpq object.
    Set $rop to 2nd arg * 3rd arg rounded in the direction $rnd.
    Return 0 if the result is exact, a positive value if $rop is 
    greater than 2nd arg times 3rd arg, a negative value otherwise.

   $si = Rmpfr_div($rop, $op1, $op2, $rnd);
   $si = Rmpfr_div_ui($rop, $op, $ui, $rnd);
   $si = Rmpfr_div_si($rop, $op, $si1, $rnd);
   $si = Rmpfr_si_div($rop, $si1, $op, $rnd);
   $si = Rmpfr_div_z($rop, $op, $z, $rnd); # $z is a mpz object.
   $si = Rmpfr_div_q($rop, $op, $q, $rnd); # $q is a mpq object.
   $si = Rmpfr_ui_div($rop, $ui, $op, $rnd);
    Set $rop to 2nd arg / 3rd arg rounded in the direction $rnd. 
    These functions return 0 if the division is exact, a positive
    value when $rop is larger than 2nd arg divided by 3rd arg,
    and a negative value otherwise.

   $si = Rmpfr_sqr($rop, $op, $rnd);
    Set $rop to the square of $op, rounded in direction $rnd.

   $bool = Rmpfr_sqrt($rop, $op, $rnd);
   $bool = Rmpfr_sqrt_ui($rop, $ui, $rnd);
    Set $rop to the square root of the 2nd arg rounded in the
    direction $rnd. Set $rop to NaN if 2nd arg is negative.
    Return 0 if the operation is exact, a non-zero value otherwise.

   $bool = Rmpfr_cbrt($rop, $op, $rnd);
    Set $rop to the cubic root (defined over the real numbers)
    of $op, rounded in the direction $rnd.

   $bool = Rmpfr_pow_ui($rop, $op, $ui, $rnd);
   $bool = Rmpfr_ui_pow_ui($rop, $ui, $ui, $rnd);
    Set $rop to 2nd arg raised to 3rd arg. The computation is done
    by binary exponentiation.  Return 0 if the result is exact,
    a non-zero value otherwise (but the sign of the return value
    has no meaning).

   $si = Rmpfr_ui_pow($rop, $ui, $op, $rnd);
    Set $rop to 2nd arg raised to 3rd arg, rounded to the directio
    $rnd with the precision of $rop.  Return zero iff the result is
    exact, a positive value when the result is greater than 2nd arg
    to the power 3rd arg, and a negative value when it is smaller.

   $bool = Rmpfr_pow_si($rop, $op, $si, $rnd);
    Set $rop to 2nd arg raised to the power 3rd arg, rounded to 
    the direction $rnd with the precision of $rop.  Return zero
    iff the result is exact.

   $bool = Rmpfr_pow($rop, $op1, $op2, $rnd);
    Set $rop to 2nd arg raised to the power 3rd arg, rounded to
    the direction $rnd with the precision of $rop.  If 2nd arg
    is negative then $rop is set to NaN, even if 3rd arg is an
    integer.  Return zero iff the result is exact.

   $si = Rmpfr_neg($rop, $op, $rnd);
    Set $rop to -$op rounded in the direction $rnd. Just
    changes the sign if $rop and $op are the same variable.

   $si = Rmpfr_abs($rop, $op, $rnd);
    Set $rop to the absolute value of $op, rounded in the direction
    $rnd. Return 0 if the result is exact, a positive value if ROP
    is larger than the absolute value of $op, and a negative value 
    otherwise.

   $si = Rmpfr_mul_2exp($rop, $op, $ui, $rnd);
   $si = Rmpfr_mul_2ui($rop, $op, $ui, $rnd);
   $si = Rmpfr_mul_2si($rop, $op, $si, $rnd);
    Set $rop to 2nd arg times 2 raised to 3rd arg rounded to the
    direction $rnd. Just increases the exponent by 3rd arg when
    $rop and 2nd arg are identical. Return zero when $rop = 2nd
    arg, a positive value when $rop > 2nd arg, and a negative
    value when $rop < 2nd arg.  Note: The `Rmpfr_mul_2exp' function
    is defined for compatibility reasons; you should use
    `Rmpfr_mul_2ui' (or `Rmpfr_mul_2si') instead.

   $si = Rmpfr_div_2exp($rop, $op, $ui, $rnd);
   $si = Rmpfr_div_2ui($rop, $op, $ui, $rnd);
   $si = Rmpfr_div_2si($rop, $op, $si, $rnd);
    Set $rop to 2nd arg divided by 2 raised to 3rd arg rounded to
    the direction $rnd. Just decreases the exponent by 3rd arg
    when $rop and 2nd arg are identical.  Return zero when 
    $rop = 2nd arg, a positive value when $rop > 2nd arg, and a
    negative value when $rop < 2nd arg.  Note: The `Rmpfr_div_2exp'
    function is defined for compatibility reasons; you should
    use `Rmpfr_div_2ui' (or `Rmpfr_div_2si') instead.

   ##########
     
   COMPARISON

   $si = Rmpfr_cmp($op1, $op2);
   $si = Rmpfr_cmpabs($op1, $op2);
   $si = Rmpfr_cmp_ui($op, $ui);
   $si = Rmpfr_cmp_si($op, $si);
   $si = Rmpfr_cmp_z($op, $z); # $z is a mpz object
   $si = Rmpfr_cmp_q($op, $q); # $q is a mpq object
   $si = Rmpfr_cmp_f($op, $f); # $f is a mpf object
    Compare 1st and 2nd args. In the case of 'Rmpfr_cmpabs()'
    compare the absolute values of the 2 args.  Return a positive
    value if 1st arg > 2nd arg, zero if 1st arg = 2nd arg, and a 
    negative value if 1st arg < 2nd arg.  Both args are considered
    to their full own precision, which may differ. In case 1st and 
    2nd args are of same sign but different, the absolute value 
    returned is one plus the absolute difference of their exponents.
    If one of the operands is NaN (Not-a-Number), return zero 
    and set the erange flag.


   $si = Rmpfr_cmp_ui_2exp($op, $ui, $si);
   $si = Rmpfr_cmp_si_2exp($op, $si, $si);
    Compare 1st arg and 2nd arg multiplied by two to the power 
    3rd arg.

   $bool = Rmpfr_eq($op1, $op2, $ui);
    Return non-zero if the first $ui bits of $op1 and $op2 are
    equal, zero otherwise.  I.e., tests if $op1 and $op2 are 
    approximately equal.

   $bool = Rmpfr_nan_p($op);
    Return non-zero if $op is Not-a-Number (NaN), zero otherwise.

   $bool = Rmpfr_inf_p($op);
    Return non-zero if $op is plus or minus infinity, zero otherwise.

   $bool = Rmpfr_number_p($op);
    Return non-zero if $op is an ordinary number, i.e. neither
    Not-a-Number nor plus or minus infinity.

   $bool = Rmpfr_zero_p($op);
    Return non-zero if $op is zero. Else return 0.

   Rmpfr_reldiff($rop, $op1, $op2, $rnd);
    Compute the relative difference between $op1 and $op2 and 
    store the result in $rop.  This function does not guarantee
    the exact rounding on the relative difference; it just
    computes abs($op1-$op2)/$op1, using the rounding mode
    $rnd for all operations.

   $si = Rmpfr_sgn($op);
    Return a positive value if op > 0, zero if $op = 0, and a
    negative value if $op < 0.  Its result is not specified
    when $op is NaN (Not-a-Number).

   $bool = Rmpfr_greater_p($op1, $op2);
    Return non-zero if $op1 > $op2, zero otherwise.

   $bool = Rmpfr_greaterequal_p($op1, $op2);
    Return non-zero if $op1 >= $op2, zero otherwise.

   $bool = Rmpfr_less_p($op1, $op2);
    Return non-zero if $op1 < $op2, zero otherwise.

   $bool = Rmpfr_lessequal_p($op1, $op2);
    Return non-zero if $op1 <= $op2, zero otherwise.

   $bool = Rmpfr_lessgreater_p($op1, $op2);
    Return non-zero if $op1 < $op2 or $op1 > $op2 (i.e. neither
    $op1, nor $op2 is NaN, and $op1 <> $op2), zero otherwise
    (i.e. $op1 and/or $op2 are NaN, or $op1 = $op2).

   $bool = Rmpfr_equal_p($op1, $op2);
    Return non-zero if $op1 = $op2, zero otherwise
    (i.e. $op1 and/or $op2 are NaN, or $op1 <> $op2).

   $bool = Rmpfr_unordered_p($op1, $op2);
     Return non-zero if $op1 or $op2 is a NaN
     (i.e. they cannot be compared), zero otherwise.

   #######

   SPECIAL

   $si = Rmpfr_log($rop, $op, $rnd);
    Set $rop to the natural logarithm of $op, rounded to the
    direction $rnd with the precision of $rop.  Return zero when
    the result is exact (this occurs in fact only when $op is 0,
    1, or +infinity) and a non-zero value otherwise (except for
    rounding to nearest, the sign of the return value is that
    of $rop-log($op).

   $si = Rmpfr_exp($rop, $op, $rnd);
    Set $rop to the exponential of $op, rounded to the direction
    $rnd with the precision of $rop.  Return zero when the result
    is exact (this occurs in fact only when $op is -infinity, 0,
    or +infinity), a positive value when the result is greater 
    than the exponential of $op, and a negative value when it is
    smaller.

   $si = Rmpfr_exp2($rop, $op, $rnd);
    Set $rop to 2 power of $op, rounded to the direction $rnd with
    the precision of $rop.  Return zero iff the result is exact
    (this occurs in fact only when OP is -infinity, 0, or
    +infinity), a positive value when the result is greater than
    the exponential of $op, and a negative value when it is smaller.

   $bool = Rmpfr_sin($rop $op, $rnd);
   $bool = Rmpfr_cos($rop, $op, $rnd);
   $bool = Rmpfr_tan($rop, $op, $rnd);
    Set $rop to the sine/cosine/tangent respectively of $op,
    rounded to the direction $rnd with the precision of $rop.
    Return 0 iff the result is exact (this occurs in fact only
    when $op is 0 i.e. the sine is 0, the cosine is 1, and the
    tangent is 0).

   $bool = Rmpfr_sin_cos($rop1, $rop2, $op, $rnd);
    Set simultaneously $rop1 to the sine of $op and
    $rop2 to the cosine of $op, rounded to the direction $rnd
    with their corresponding precisions.  Return 0 iff both
    results are exact.

   $bool = Rmpfr_acos($rop, $op, $rnd);
   $bool = Rmpfr_asin($rop, $op, $rnd);
   $bool = Rmpfr_atan($rop, $op, $rnd);
    Set $rop to the arc-cosine, arc-sine or arc-tangent of $op,
    rounded to the direction $rnd with the precision of $rop.
    Return 0 iff the result is exact.

   $bool = Rmpfr_cosh($rop, $op, $rnd);
   $bool = Rmpfr_sinh($rop, $op, $rnd);
   $bool = Rmpfr_tanh($rop, $op, $rnd);
    Set $rop to the hyperbolic cosine/hyperbolic sine/hyperbolic
    tangent respectively of $op, rounded to the direction $rnd
    with the precision of $rop.  Return 0 iff the result is exact
    (this occurs in fact only when OP is 0 i.e. the result is 1).

   $bool = Rmpfr_acosh($rop, $op, $rnd);
   $bool = Rmpfr_asinh($rop, $op, $rnd);
   $bool = Rmpfr_atanh($rop, $op, $rnd);
    Set $rop to the inverse hyperbolic cosine, sine or tangent
    of $op, rounded to the direction $rnd with the precision of
    $rop.  Return 0 iff the result is exact.

   $bool = Rmpfr_fac_ui($rop, $ui, $rnd);
    Set $rop to the factorial of $ui, rounded to the direction
    $rnd with the precision of $rop.  Return 0 iff the
    result is exact.

   $bool = Rmpfr_log1p($rop, $op, $rnd);
    Set $rop to the logarithm of one plus $op, rounded to the
    direction $rnd with the precision of $rop.  Return 0 iff 
    the result is exact (this occurs in fact only when OP is 0
    i.e. the result is 0).

   $bool = Rmpfr_expm1($rop, $op, $rnd);
    Set $rop to the exponential of $op minus one, rounded to the
    direction $rnd with the precision of $rop.  Return 0 iff the
    result is exact (this occurs in fact only when OP is 0 i.e
    the result is 0).

   $bool = Rmpfr_log2($rop, $op, $rnd);
   $bool = Rmpfr_log10($rop, $op, $rnd);
    Set $rop to the log[t] (t=2 or 10)(log x / log t) of $op,
    rounded to the direction $rnd with the precision of $rop.
    Return 0 iff the result is exact (this occurs in fact 
    only when $op is 1 i.e. the result is 0).

   $bool = Rmpfr_fma($rop, $op1, $op2, $op3, $rnd);
    Set $rop to $op1 * $op2 + $op3, rounded to the direction
    $rnd with the precision of $rop. Return 0 iff the result
    is exact, a positive value if $rop is larger than
    $op1 * $op2 + $op3, and a negative value otherwise.

   $si = Rmpfr_agm($rop, $op1, $op2, $rnd);
    Set $rop to the arithmetic-geometric mean of $op1 and $op2,
    rounded to the direction $rnd with the precision of $rop.
    Return zero if $rop is exact, a positive value if $rop is
    larger than the exact value, or a negative value if $rop 
    is less than the exact value.

   $si = Rmpfr_const_log2($rop, $rnd);
    Set $rop to the logarithm of 2 rounded to the direction
    $rnd with the precision of $rop. This function stores the
    computed value to avoid another calculation if a lower or
    equal precision is requested.
    Return zero if $rop is exact, a positive value if $rop is
    larger than the exact value, or a negative value if $rop 
    is less than the exact value.

   $si = Rmpfr_const_pi($rop, $rnd);
    Set $rop to the value of Pi rounded to the direction $rnd
    with the precision of $rop. This function uses the Borwein,
    Borwein, Plouffe formula which directly gives the expansion
    of Pi in base 16.
    Return zero if $rop is exact, a positive value if $rop is
    larger than the exact value, or a negative value if $rop 
    is less than the exact value.

   $si = Rmpfr_const_euler($rop, $rnd);
    Set $rop to the value of Euler's constant 0.577...  rounded
    to the direction $rnd with the precision of $rop.
    Return zero if $rop is exact, a positive value if $rop is
    larger than the exact value, or a negative value if $rop 
    is less than the exact value.

   Rmpfr_free_cache();
    Free the cache used by the functions computing constants if
    needed (currently `mpfr_const_log2', `mpfr_const_pi' and
    `mpfr_const_euler').

   $si = Rmpfr_gamma($rop, $op, $rnd);
    Set $rop to the value of the Gamma function on $op, rounded
    to the direction $rnd. Return zero if $rop is exact, a
    positive value if $rop is larger than the exact value, or a
    negative value if $rop is less than the exact value.

   $si = Rmpfr_zeta($rop, $op, $rnd);
    Set $rop to the value of the Riemann Zeta function on $op,
    rounded to the direction $rnd. Return zero if $rop is exact,
    a positive value if $rop is larger than the exact value, or
    a negative value if $rop is less than the exact value.

   $si = Rmpfr_erf($rop, $op, $rnd);
    Set $rop to the value of the error function on $op,
    rounded to the direction $rnd. Return zero if $rop is exact,
    a positive value if $rop is larger than the exact value, or
    a negative value if $rop is less than the exact value.

   #############

   I-O FUNCTIONS

   $ui = Rmpfr_out_str($op, $base, $digits, $round);
    Output $op to STDOUT, as a string of digits in base $base,
    rounded in direction $round.  The base may vary from 2 to 36.
    Print $digits significant digits exactly, or if $digits is 0,
    the maximum number of digits accurately representable by $op
    (this feature may disappear). In addition to the significant
    digits, a decimal point at the right of the first digit and a
    trailing exponent in base 10, in the form `eNNN', are printed
    If $base is greater than 10, `@' will be used instead of `e'
    as exponent delimiter. Return the number of bytes written, or
    if an error occurred, return 0.

   $ui = Rmpfr_inp_str($rop, $base, $round);
    Input a string in base $base from STDIN, rounded in
    direction $round, and put the read float in $rop.  The string
    is of the form `M@N' or, if the base is 10 or less, alternatively
    `MeN' or `MEN', or, if the base is 16, alternatively `MpB' or
    `MPB'. `M' is the mantissa in the specified base, `N' is the 
    exponent written in decimal for the specified base, and in base 16,
    `B' is the binary exponent written in decimal (i.e. it indicates
    the power of 2 by which the mantissa is to be scaled).
    The argument $base may be in the range 2 to 36.
    Special values can be read as follows (the case does not matter):
    `@NaN@', `@Inf@', `+@Inf@' and `-@Inf@', possibly followed by
    other characters; if the base is smaller or equal to 16, the
    following strings are accepted too: `NaN', `Inf', `+Inf' and
    `-Inf'.
    Return the number of bytes read, or if an error occurred, return 0.

   Rmpfr_print_binary($op);
    Output $op on stdout in raw binary format (the exponent is in
    decimal, yet).

   Rmpfr_dump($op);
    Output "$op\n" on stdout in base 2.
    As with 'Rmpfr_print_binary' the exponent is in base 10.

   #############

   MISCELLANEOUS

   $MPFR_version = Rmpfr_get_version();
    Returns the version of the MPFR library (eg 2.1.0).

   $GMP_version = Math::MPFR::gmp_v();
    Returns the version of the GMP library (eg. 4.1.3).
    The function is not exportable.

   $si = Rmpfr_rint($rop, $op, $rnd);
   $si = Rmpfr_ceil($rop, $op);
   $si = Rmpfr_floor($rop, $op);
   $si = Rmpfr_round($rop, $op);
   $si = Rmpfr_trunc($rop, $op);
    Set $rop to $op rounded to an integer. `Rmpfr_ceil' rounds to the
    next higher representable integer, `Rmpfr_floor' to the next lower,
    `Rmpfr_round' to the nearest representable integer, rounding
    halfway cases away from zero, and `Rmpfr_trunc' to the
    representable integer towards zero. `Rmpfr_rint' behaves like one
    of these four functions, depending on the rounding mode.  The
    returned value is zero when the result is exact, positive when it
    is greater than the original value of $op, and negative when it is
    smaller.  More precisely, the returned value is 0 when $op is an
    integer representable in $rop, 1 or -1 when $op is an integer that
    is not representable in $rop, 2 or -2 when $op is not an integer.

    $si = Rmpfr_rint_ceil($rop, $op, $rnd);
    $si = Rmpfr_rint_floor($rop, $op, $rnd);
    $si = Rmpfr_rint_round($rop, $op, $rnd);
    $si = Rmpfr_rint_trunc($rop, $op, $rnd):
     Set $rop to $op rounded to an integer. `Rmpfr_rint_ceil' rounds to
     the next higher or equal integer, `Rmpfr_rint_floor' to the next
     lower or equal integer, `Rmpfr_rint_round' to the nearest integer,
     rounding halfway cases away from zero, and `Rmpfr_rint_trunc' to
     the next integer towards zero.  If the result is not
     representable, it is rounded in the direction $rnd. The returned
     value is the ternary value associated with the considered
     round-to-integer function (regarded in the same way as any other
     mathematical function).

   $si = Rmpfr_frac($rop, $op, $round);
    Set $rop to the fractional part of OP, having the same sign as $op,
    rounded in the direction $round (unlike in `mpfr_rint', $round
    affects only how the exact fractional part is rounded, not how
    the fractional part is generated).

   $si = Rmpfr_integer_p($op);
    Return non-zero iff $op is an integer.

   Rmpfr_nexttoward($op1, $op2);
    If $op1 or $op2 is NaN, set $op1 to NaN. Otherwise, if $op1 is 
    different from $op2, replace $op1 by the next floating-point number
    (with the precision of $op1 and the current exponent range) in the 
    direction of $op2, if there is one (the infinite values are seen as
    the smallest and largest floating-point numbers). If the result is
    zero, it keeps the same sign. No underflow or overflow is generated.

   Rmpfr_nextabove($op1);
    Equivalent to `mpfr_nexttoward' where $op2 is plus infinity.

   Rmpfr_nextbelow($op1);
    Equivalent to `mpfr_nexttoward' where $op2 is minus infinity.

   $si = Rmpfr_min($rop, $op1, $op2, $round);
    Set $rop to the minimum of $op1 and $op2. If $op1 and $op2
    are both NaN, then $rop is set to NaN. If $op1 or $op2 is 
    NaN, then $rop is set to the numeric value. If $op1 and
    $op2 are zeros of different signs, then $rop is set to -0.

   $si = Rmpfr_max($rop, $op1, $op2, $round);
     Set $rop to the maximum of $op1 and $op2. If $op1 and $op2
    are both NaN, then $rop is set to NaN. If $op1 or $op2 is
    NaN, then $rop is set to the numeric value. If $op1 and 
    $op2 are zeros of different signs, then $rop is set to +0.

   ##############

   RANDOM NUMBERS

   Rmpfr_urandomb(@r, $state);
    Each member of @r is a Math::MPFR object.
    $state is a reference to a gmp_randstate_t structure.
    Set each member of @r to a uniformly distributed random
    float in the interval 0 <= $_ < 1. 
    Before using this function you must first create $state
    by calling one of the 3 Rgmp_randinit functions, then
    seed $state by calling one of the 2 Rgmp_randseed functions.
    The memory associated with $state will not be freed until
    either you call Rgmp_randclear, or the program ends.

   Rmpfr_random2($rop, $si, $ui);
    Generate a random float of at most abs($si) limbs, with long
    strings of zeros and ones in the binary representation.
    The exponent of the number is in the interval -$ui to
    $ui.  This function is useful for testing functions and
    algorithms, since this kind of random numbers have proven
    to be more likely to trigger corner-case bugs.  Negative
    random numbers are generated when $si is negative.

   $state = Rgmp_randinit_default();
    Initialise $state with a default algorithm. This will be
    a compromise between speed and randomness, and is 
    recommended for applications with no special requirements.
    (The GMP function is documented in the GMP, not MPFR, docs.)

   $state = Rgmp_randinit_lc_2exp($a, $c, $m2exp);
    This function is not tested in the test suite.
    Use with caution - I often select values here that cause
    Rmpf_urandomb() to behave non-randomly.    
    Initialise $state with a linear congruential algorithm:
    X = ($a * X + $c) % 2 ** $m2exp
    The low bits in X are not very random - for this reason
    only the high half of each X is actually used.
    $c and $m2exp sre both unsigned longs.
    $a can be any one of Math::GMP, GMP::Mpz, or Math::GnuMPz
    objects. Or it can be a string.
    If it is a string of hex digits it must be prefixed with
    either OX or Ox. If it is a string of octal digits it must
    be prefixed with 'O'. Else it is assumed to be a decimal
    integer. No other bases are allowed.
    (The GMP function is documented in the GMP, not MPFR, docs.)

   $state = Rgmp_randinit_lc_2exp_size($ui);
    Initialise state as per Rgmp_randinit_lc_2exp. The values
    for $a, $c. and $m2exp are selected from a table, chosen
    so that $ui bits (or more) of each X will be used.
    (The GMP function is documented in the GMP, not MPFR, docs.)
    

   Rgmp_randseed($state, $seed);
    $state is a reference to a gmp_randstate_t strucure (the
    return value of one of the Rgmp_randinit functions).
    $seed is the seed. It can be any one of Math::GMP, 
    GMP::Mpz, or Math::GnuMPz objects. Or it can be a string.
    If it is a string of hex digits it must be prefixed with
    either OX or Ox. If it is a string of octal digits it must
    be prefixed with 'O'. Else it is assumed to be a decimal
    integer. No other bases are allowed.
    (The GMP function is documented in the GMP, not MPFR, docs.)

   Rgmp_randseed_ui($state, $ui);
    $state is a reference to a gmp_randstate_t strucure (the
    return value of one of the Rgmp_randinit functions).
    $ui is the seed.
    (The GMP function is documented in the GMP, not MPFR, docs.)

   #########

   INTERNALS

   $bool = Rmpfr_add_one_ulp($rop, $rnd);
    Add one unit in last place (ulp) to $rop if $rop is finite
    and positive, subtract one ulp if $rop is finite and negative;
    otherwise, $rop is not changed.  The return value is zero 
    unless an overflow occurs, in which case the `Rmpfr_add_one_ulp'
    function behaves like a conventional addition.

   $bool = Rmpfr_sub_one_ulp($rop, $rnd);
    Subtract one ulp to $rop if $rop is finite and positive, add 
    one ulp if $rop is finite and negative; otherwise, $rop is not
    changed. The return value is zero unless an underflow occurs,
    in which case the `Rmpfr_sub_one_ulp' function behaves like a
    conventional subtraction.

   $bool = Rmpfr_can_round($op, $ui, $rnd1, $rnd2, $prec);
    Assuming $op is an approximation of an unknown number X in direction
    $rnd1 with error at most two to the power E(b)-$ui where E(b) is
    the exponent of B, returns 1 if one is able to round exactly X
    to precision $prec with direction $rnd2, and 0 otherwise. This
    function *does not modify* its arguments.

   $si = Rmpfr_get_exp($op);
    Get the exponent of $op, assuming that $op is a non-zero
    ordinary number.

   $si = Rmpfr_set_exp($op, $si);
    Set the exponent of $op if $si is in the current exponent 
    range, and return 0 (even if $op is not a non-zero
    ordinary number); otherwise, return a non-zero value.

   ####################

   OPERATOR OVERLOADING
    
    Overloading works with numbers, strings (base 10 only) and
    Math::MPFR objects.
    Overloaded operations are performed using the current
    "default rounding mode" (which you can determine using the
    'Rmpfr_get_default_rounding_mode' function, and change using
    the 'Rmpfr_set_default_rounding_mode' function).

    The following operators are overloaded:
     + - * / ** sqrt (Return value has default precision)
     += -= *= /= **= (Precision remains unchanged)
     < <= > >= == != <=>
     ! not
     abs atan2 cos sin log exp (Return value has default precision)
     int (On perl 5.8 only, NA on perl 5.6. The return value
          has default precision)
     = ""

    Attempting to use the overloaded operators with objects that
    have been blessed into some package other than 'Math::MPFR'
    will not (currently) work. It would be fun (and is tempting)
    to implement cross-class overloading - but it could also
    easily lead to user confusion and frustration, so I'll resist
    the temptation until someone convinces me that I should do
    otherwise.
    The workaround is to convert this "foreign" object to a
    format that *will* work with the overloaded operator.

    In those situations where the overload subroutine operates on 2
    perl variables, then obviously one of those perl variables is
    a Math::MPFR object. To determine the value of the other variable
    the subroutine works through the following steps (in order),
    using the first value it finds, or croaking if it gets
    to step 6:

    1. If the variable is an unsigned long then that value is used.
       The variable is considered to be an unsigned long if 
       (perl 5.8) the UOK flag is set or if (perl 5.6) SvIsUV() 
       returns true.

    2. If the variable is a signed long int, then that value is used.
       The variable is consdiered to be a signed long int if the
       IOK flag is set.

    3. If the variable is a double, then that value is used. The
       variable is considered to be a double if the NOK flag is set.

    4. If the variable is a string (ie the POK flag is set) then the
       base 10 value of that string is used. If the POK flag is set,
       but the string is not a valid base 10 number, the subroutine
       croaks with an appropriate error message.

    5. If the variable is a Math::MPFR object then the value of that
       object is used.

    6. If none of the above is true, then the second variable is
       deemed to be of an invalid type. The subroutine croaks with
       an appropriate error message.

   #####################

=head1 LICENSE

    This program is free software; you may redistribute it
    and/or modify it under the same terms as Perl itself.

=head1 AUTHOR

    Sisyphus <kalinabears at iinet dot net dot au>

=cut