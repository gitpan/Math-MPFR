/*
* Check that gmp.h, mpfr.h, and mpf2mpfr.h
* can be found by the compiler
* and that libmpfr.a and libgmp.a can be
* found by the linker
*/

#include <stdio.h>
#include <gmp.h>
#include <mpfr.h>
//#include <mpf2mpfr.h>

#ifdef _MSC_VER
void __GSHandlerCheck(void) {}
void __security_check_cookie(void) {}
void __security_cookie(void) {}
#endif

int main(void) {
   mpfr_t x;
   mpfr_init_set_ui(x, 7, GMP_RNDN);
   mpfr_clear(x);
   printf("DONE\n");
   return 0;
}