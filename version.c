/*
* Check that the MPFR library is sufficiently recent
*/
#include <stdio.h>
#include <gmp.h>
#include <mpfr.h>

int main(void) {
    printf("%s\n", mpfr_get_version());
    return 0;
}