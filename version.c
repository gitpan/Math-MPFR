/*
* Check that the MPFR library is sufficiently recent
*/
#include <stdio.h>
#include <gmp.h>
#include <mpfr.h>

#ifdef _MSC_VER
void __GSHandlerCheck(void) {}
void __security_check_cookie(void) {}
void __security_cookie(void) {}
#endif

int main(void) {
    printf("%s\n", mpfr_get_version());
    return 0;
}