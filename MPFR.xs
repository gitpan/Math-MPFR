#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include <stdio.h>

#if defined USE_64_BIT_INT || defined USE_LONG_DOUBLE
#ifndef _MSC_VER
#include <inttypes.h>
#endif
#endif

#include <gmp.h>
#include <mpfr.h>

/* Squash some annoying compiler warnings (Microsoft compilers only). */
#ifdef _MSC_VER
#pragma warning(disable:4700 4715 4716)
#endif

#ifdef OLDPERL
#define SvUOK SvIsUV
#endif

/* May one day be removed from mpfr.h */
#ifndef mp_rnd_t
# define mp_rnd_t  mpfr_rnd_t
#endif
#ifndef mp_prec_t
# define mp_prec_t mpfr_prec_t
#endif

#ifndef __gmpfr_default_rounding_mode
#define __gmpfr_default_rounding_mode mpfr_get_default_rounding_mode()
#endif

/* Has inttypes.h been included ? */
int _has_inttypes() {
#ifdef _MSC_VER
return 0;
#else
#if defined USE_64_BIT_INT || defined USE_LONG_DOUBLE
return 1;
#else
return 0;
#endif
#endif
}

void Rmpfr_set_default_rounding_mode(SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     mpfr_set_default_rounding_mode((mp_rnd_t)SvUV(round));    
}

SV * Rmpfr_get_default_rounding_mode() {
     return newSViv(__gmpfr_default_rounding_mode);
}

SV * Rmpfr_prec_round(mpfr_t * p, SV * prec, SV * round) {
     return newSViv(mpfr_prec_round(*p, (mpfr_prec_t)SvUV(prec), (mp_rnd_t)SvUV(round)));
}

void DESTROY(mpfr_t * p) {
     mpfr_clear(*p);
     Safefree(p);
}

void Rmpfr_clear(mpfr_t * p) {
     mpfr_clear(*p);
     Safefree(p);
}

void Rmpfr_clear_mpfr(mpfr_t * p) {
     mpfr_clear(*p);
}

void Rmpfr_clear_ptr(mpfr_t * p) {
     Safefree(p);
}

void Rmpfr_clears(SV * p, ...) {
     dXSARGS;
     unsigned long i;
     for(i = 0; i < items; i++) {
        mpfr_clear(*(INT2PTR(mpfr_t *, SvIV(SvRV(ST(i))))));
        Safefree(INT2PTR(mpfr_t *, SvIV(SvRV(ST(i)))));
     }
     XSRETURN(0);
}

SV * Rmpfr_init() {
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;

     New(1, mpfr_t_obj, 1, mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in Rmpfr_init function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, "Math::MPFR");
     mpfr_init(*mpfr_t_obj);

     sv_setiv(obj, INT2PTR(IV,mpfr_t_obj));
     SvREADONLY_on(obj);
     return obj_ref;
}

SV * Rmpfr_init2(SV * prec) {
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;

     New(1, mpfr_t_obj, 1, mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in Rmpfr_init2 function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, "Math::MPFR");
     mpfr_init2 (*mpfr_t_obj, (mpfr_prec_t)SvUV(prec));

     sv_setiv(obj, INT2PTR(IV,mpfr_t_obj));
     SvREADONLY_on(obj);
     return obj_ref;
}

SV * Rmpfr_init_nobless() {
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;

     New(1, mpfr_t_obj, 1, mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in Rmpfr_init_nobless function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, NULL);
     mpfr_init(*mpfr_t_obj);

     sv_setiv(obj, INT2PTR(IV,mpfr_t_obj));
     SvREADONLY_on(obj);
     return obj_ref;
}

SV * Rmpfr_init2_nobless(SV * prec) {
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;

     New(1, mpfr_t_obj, 1, mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in Rmpfr_init2_nobless function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, NULL);
     mpfr_init2 (*mpfr_t_obj, (mpfr_prec_t)SvUV(prec));

     sv_setiv(obj, INT2PTR(IV,mpfr_t_obj));
     SvREADONLY_on(obj);
     return obj_ref;
}

void Rmpfr_init_set(mpfr_t * q, SV * round) {
     dXSARGS;
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;
     int ret;

#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif

     // sp = mark; // not needed

     New(1, mpfr_t_obj, 1, mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in Rmpfr_init_set function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, "Math::MPFR");
     ret = mpfr_init_set(*mpfr_t_obj, *q, (mp_rnd_t)SvUV(round));

     sv_setiv(obj, INT2PTR(IV,mpfr_t_obj));
     SvREADONLY_on(obj);
     ST(0) = sv_2mortal(obj_ref);
     ST(1) = sv_2mortal(newSViv(ret));
     // PUTBACK; // not needed
     XSRETURN(2);
}

void Rmpfr_init_set_ui(SV * q, SV * round) {
     dXSARGS;
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;
     int ret;

#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif

     // sp = mark; // not needed

     New(1, mpfr_t_obj, 1, mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in Rmpfr_init_set_ui function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, "Math::MPFR");
     ret = mpfr_init_set_ui(*mpfr_t_obj, (unsigned long)SvUV(q), (mp_rnd_t)SvUV(round));

     sv_setiv(obj, INT2PTR(IV,mpfr_t_obj));
     SvREADONLY_on(obj);
     ST(0) = sv_2mortal(obj_ref);
     ST(1) = sv_2mortal(newSViv(ret));
     // PUTBACK; // not needed
     XSRETURN(2);
}

void Rmpfr_init_set_si(SV * q, SV * round) {
     dXSARGS;
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;
     int ret;

#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif

     // sp = mark; // not needed

     New(1, mpfr_t_obj, 1, mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in Rmpfr_init_set_si function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, "Math::MPFR");
     ret = mpfr_init_set_si(*mpfr_t_obj, (long)SvIV(q), (mp_rnd_t)SvUV(round));

     sv_setiv(obj, INT2PTR(IV,mpfr_t_obj));
     SvREADONLY_on(obj);
     ST(0) = sv_2mortal(obj_ref);
     ST(1) = sv_2mortal(newSViv(ret));
     // PUTBACK; // not needed
     XSRETURN(2);
}

void Rmpfr_init_set_d(SV * q, SV * round) {
     dXSARGS;
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;
     int ret;

#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif

     // sp =  mark; // not needed

     New(1, mpfr_t_obj, 1, mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in Rmpfr_init_set_d function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, "Math::MPFR");
     ret = mpfr_init_set_d(*mpfr_t_obj, SvNV(q), (mp_rnd_t)SvUV(round));

     sv_setiv(obj, INT2PTR(IV,mpfr_t_obj));
     SvREADONLY_on(obj);
     ST(0) = sv_2mortal(obj_ref);
     ST(1) = sv_2mortal(newSViv(ret));
     // PUTBACK; // not needed;
     XSRETURN(2);
}

void Rmpfr_init_set_ld(SV * q, SV * round) {
#ifdef USE_LONG_DOUBLE
#ifndef _MSC_VER
     dXSARGS;
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;
     int ret;

#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif

     // sp = mark; // not needed

     New(1, mpfr_t_obj, 1, mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in Rmpfr_init_set_d function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, "Math::MPFR");
     ret = mpfr_init_set_ld(*mpfr_t_obj, SvNV(q), (mp_rnd_t)SvUV(round));
     sv_setiv(obj, INT2PTR(IV,mpfr_t_obj));
     SvREADONLY_on(obj);
     ST(0) = sv_2mortal(obj_ref);
     ST(1) = sv_2mortal(newSViv(ret));
     // PUTBACK; // not needed;
     XSRETURN(2);
#else
     croak("Rmpfr_init_set_ld() not implemented on this build of perl - use Rmpfr_init_set_d() instead");
#endif
#else
     croak("Rmpfr_init_set_ld() not implemented on this build of perl");
#endif
}

void Rmpfr_init_set_f(mpf_t * q, SV * round) {
     dXSARGS;
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;
     int ret;

#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif

     // sp = mark; //not needed

     New(1, mpfr_t_obj, 1, mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in Rmpfr_init_set_f function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, "Math::MPFR");
     ret = mpfr_init_set_f(*mpfr_t_obj, *q, (mp_rnd_t)SvUV(round));

     sv_setiv(obj, INT2PTR(IV,mpfr_t_obj));
     SvREADONLY_on(obj);
     ST(0) = sv_2mortal(obj_ref);
     ST(1) = sv_2mortal(newSViv(ret));
     // PUTBACK; // not needed
     XSRETURN(2);
}

void Rmpfr_init_set_z(mpz_t * q, SV * round) {
     dXSARGS;
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;
     int ret;

#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif

     // sp = mark; // not neededInline_Stack_Reset;

     New(1, mpfr_t_obj, 1, mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in Rmpfr_init_set_z function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, "Math::MPFR");
     ret = mpfr_init_set_z(*mpfr_t_obj, *q, (mp_rnd_t)SvUV(round));

     sv_setiv(obj, INT2PTR(IV,mpfr_t_obj));
     SvREADONLY_on(obj);
     ST(0) = sv_2mortal(obj_ref);
     ST(1) = sv_2mortal(newSViv(ret));
     // PUTBACK; // not needed
     XSRETURN(2);
}

void Rmpfr_init_set_q(mpq_t * q, SV * round) {
     dXSARGS;
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;
     int ret;

#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif

     // sp = mark; // not needed

     New(1, mpfr_t_obj, 1, mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in Rmpfr_init_set_q function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, "Math::MPFR");
     ret = mpfr_init_set_q(*mpfr_t_obj, *q, (mp_rnd_t)SvUV(round));

     sv_setiv(obj, INT2PTR(IV,mpfr_t_obj));
     SvREADONLY_on(obj);
     ST(0) = sv_2mortal(obj_ref);
     ST(1) = sv_2mortal(newSViv(ret));
     // PUTBACK // not needed
     XSRETURN(2);
}

void Rmpfr_init_set_str(SV * q, SV * base, SV * round) {
     dXSARGS;
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;
     int ret = (int)SvIV(base);

#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif

     // sp = mark; // not needed

     if(ret < 0 || ret > 36 || ret == 1) croak("2nd argument supplied to Rmpfr_init_set str is out of allowable range");

     New(1, mpfr_t_obj, 1, mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in Rmpfr_init_set_str function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, "Math::MPFR");
     sv_setiv(obj, INT2PTR(IV,mpfr_t_obj));
     SvREADONLY_on(obj);
     ret = mpfr_init_set_str(*mpfr_t_obj, SvPV_nolen(q), ret, (mp_rnd_t)SvUV(round));

     ST(0) = sv_2mortal(obj_ref);
     ST(1) = sv_2mortal(newSViv(ret));
     // PUTBACK; // not needed
     XSRETURN(2);
}

void Rmpfr_init_set_nobless(mpfr_t * q, SV * round) {
     dXSARGS;
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;
     int ret;

#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif

     // sp = mark; // not needed

     New(1, mpfr_t_obj, 1, mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in Rmpfr_init_set_nobless function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, NULL);
     ret = mpfr_init_set(*mpfr_t_obj, *q, (mp_rnd_t)SvUV(round));

     sv_setiv(obj, INT2PTR(IV,mpfr_t_obj));
     SvREADONLY_on(obj);
     ST(0) = sv_2mortal(obj_ref);
     ST(1) = sv_2mortal(newSViv(ret));
     // PUTBACK; // not needed
     XSRETURN(2);
}

void Rmpfr_init_set_ui_nobless(SV * q, SV * round) {
     dXSARGS;
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;
     int ret;

#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif

     // sp  = mark; // not needed

     New(1, mpfr_t_obj, 1, mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in Rmpfr_init_set_ui_nobless function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, NULL);
     ret = mpfr_init_set_ui(*mpfr_t_obj, (unsigned long)SvUV(q), (mp_rnd_t)SvUV(round));

     sv_setiv(obj, INT2PTR(IV,mpfr_t_obj));
     SvREADONLY_on(obj);
     ST(0) = sv_2mortal(obj_ref);
     ST(1) = sv_2mortal(newSViv(ret));
     // PUTBACK; // not needed
     XSRETURN(2);
}

void Rmpfr_init_set_si_nobless(SV * q, SV * round) {
     dXSARGS;
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;
     int ret;

#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif

     // sp = mark; // not needed

     New(1, mpfr_t_obj, 1, mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in Rmpfr_init_set_si_nobless function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, NULL);
     ret = mpfr_init_set_si(*mpfr_t_obj, (long)SvIV(q), (mp_rnd_t)SvUV(round));

     sv_setiv(obj, INT2PTR(IV,mpfr_t_obj));
     SvREADONLY_on(obj);
     ST(0) = sv_2mortal(obj_ref);
     ST(1) = sv_2mortal(newSViv(ret));
     // PUTBACK; // not needed
     XSRETURN(2);
}

void Rmpfr_init_set_d_nobless(SV * q, SV * round) {
     dXSARGS;
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;
     int ret;

#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif

     // sp = mark; // not needed

     New(1, mpfr_t_obj, 1, mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in Rmpfr_init_set_d_nobless function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, NULL);
     ret = mpfr_init_set_d(*mpfr_t_obj, SvNV(q), (mp_rnd_t)SvUV(round));

     sv_setiv(obj, INT2PTR(IV,mpfr_t_obj));
     SvREADONLY_on(obj);
     ST(0) = sv_2mortal(obj_ref);
     ST(1) = sv_2mortal(newSViv(ret));
     // PUTBACK; // not needed
     XSRETURN(2);
}

void Rmpfr_init_set_ld_nobless(SV * q, SV * round) {
#ifdef USE_LONG_DOUBLE
#ifndef _MSC_VER
     dXSARGS;
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;
     int ret;

#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif

     // sp = mark; // not needed

     New(1, mpfr_t_obj, 1, mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in Rmpfr_init_set_d_nobless function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, NULL);
     ret = mpfr_init_set_ld(*mpfr_t_obj, SvNV(q), (mp_rnd_t)SvUV(round));
     sv_setiv(obj, INT2PTR(IV,mpfr_t_obj));
     SvREADONLY_on(obj);
     ST(0) = sv_2mortal(obj_ref);
     ST(1) = sv_2mortal(newSViv(ret));
     // PUTBACK; // not needed
     XSRETURN(2);
#else
     croak("Rmpfr_init_set_ld_nobless() not implemented on this build of perl - use Rmpfr_init_set_d_nobless() instead");
#endif
#else
     croak("Rmpfr_init_set_ld_nobless() not implemented on this build of perl");
#endif
}

void Rmpfr_init_set_f_nobless(mpf_t * q, SV * round) {
     dXSARGS;
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;
     int ret;

#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif

     // sp = mark; // not needed

     New(1, mpfr_t_obj, 1, mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in Rmpfr_init_set_f_nobless function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, NULL);
     ret = mpfr_init_set_f(*mpfr_t_obj, *q, (mp_rnd_t)SvUV(round));

     sv_setiv(obj, INT2PTR(IV,mpfr_t_obj));
     SvREADONLY_on(obj);
     ST(0) = sv_2mortal(obj_ref);
     ST(1)  = sv_2mortal(newSViv(ret));
     // PUTBACK; // not needed
     XSRETURN(2);
}

void Rmpfr_init_set_z_nobless(mpz_t * q, SV * round) {
     dXSARGS;
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;
     int ret;

#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif

     // sp  = mark; //not needed

     New(1, mpfr_t_obj, 1, mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in Rmpfr_init_set_z_nobless function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, NULL);
     ret = mpfr_init_set_z(*mpfr_t_obj, *q, (mp_rnd_t)SvUV(round));

     sv_setiv(obj, INT2PTR(IV,mpfr_t_obj));
     SvREADONLY_on(obj);
     ST(0) = sv_2mortal(obj_ref);
     ST(1) = sv_2mortal(newSViv(ret));
     // PUTBACK; // not needed
     XSRETURN(2);
}

void Rmpfr_init_set_q_nobless(mpq_t * q, SV * round) {
     dXSARGS;
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;
     int ret;

#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif

     // sp = mark; // not needed

     New(1, mpfr_t_obj, 1, mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in Rmpfr_init_set_q_nobless function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, NULL);
     ret = mpfr_init_set_q(*mpfr_t_obj, *q, (mp_rnd_t)SvUV(round));

     sv_setiv(obj, INT2PTR(IV,mpfr_t_obj));
     SvREADONLY_on(obj);
     ST(0) = sv_2mortal(obj_ref);
     ST(1) = sv_2mortal(newSViv(ret));
     // PUTBACK; // not needed
     XSRETURN(2);
}

void Rmpfr_init_set_str_nobless(SV * q, SV * base, SV * round) {
     dXSARGS;
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;
     int ret = (int)SvIV(base);

#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif

     if(ret < 0 || ret > 36 || ret == 1) croak("2nd argument supplied to Rmpfr_init_set_str_nobless is out of allowable range");

     // sp = mark; // not needed

     New(1, mpfr_t_obj, 1, mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in Rmpfr_init_set_str_nobless function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, NULL);
     sv_setiv(obj, INT2PTR(IV,mpfr_t_obj));
     SvREADONLY_on(obj);
     ret = mpfr_init_set_str(*mpfr_t_obj, SvPV_nolen(q), ret, (mp_rnd_t)SvUV(round));

     ST(0) = sv_2mortal(obj_ref);
     ST(1) = sv_2mortal(newSViv(ret));
     // PUTBACK; // not needed
     XSRETURN(2);
}

void Rmpfr_deref2(mpfr_t * p, SV * base, SV * n_digits, SV * round) {
     dXSARGS;
     char * out;
     mp_exp_t ptr;
     unsigned long b = (unsigned long)SvUV(base);

#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif

     if(b < 2 || b > 36) croak("Second argument supplied to Rmpfr_get_str() is not in acceptable range");

     out = mpfr_get_str(0, &ptr, b, (unsigned long)SvUV(n_digits), *p, (mp_rnd_t)SvUV(round));

     if(out == NULL) croak("An error occurred in mpfr_get_str()\n");

     // sp  = mark; // not needed
     ST(0) = sv_2mortal(newSVpv(out, 0));
     mpfr_free_str(out);
     ST(1) = sv_2mortal(newSViv(ptr));
     // PUTBACK; // not needed
     XSRETURN(2);
}

void Rmpfr_set_default_prec(SV * prec) {
     mpfr_set_default_prec((mpfr_prec_t)SvUV(prec));
} 

SV * Rmpfr_get_default_prec() {
     return newSVuv(mpfr_get_default_prec());
}

SV * Rmpfr_min_prec() {
     return newSVuv(MPFR_PREC_MIN);
}

SV * Rmpfr_max_prec() {
     return newSVuv(MPFR_PREC_MAX);
}

void Rmpfr_set_prec(mpfr_t * p, SV * prec) {
     mpfr_set_prec(*p, (mpfr_prec_t)SvUV(prec));
}

void Rmpfr_set_prec_raw(mpfr_t * p, SV * prec) {
     mpfr_set_prec_raw(*p, (mpfr_prec_t)SvUV(prec));
}

SV * Rmpfr_get_prec(mpfr_t * p) {
     return newSVuv(mpfr_get_prec(*p));
}

SV * Rmpfr_set(mpfr_t * p, mpfr_t * q, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_set(*p, *q, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_set_ui(mpfr_t * p, SV * q, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_set_ui(*p, (unsigned long)SvUV(q), (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_set_si(mpfr_t * p, SV * q, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_set_si(*p, (long)SvIV(q), (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_set_uj(mpfr_t * p, SV * q, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
#ifdef USE_64_BIT_INT
#ifndef _MSC_VER
     return newSViv(mpfr_set_uj(*p, SvUV(q), (mp_rnd_t)SvUV(round)));
#else
     croak("Rmpfr_set_uj() not implemented on this build of perl - use Rmpfr_set_str() instead");
#endif
#else
     croak("Rmpfr_set_uj() not implemented on this build of perl");
#endif
}

SV * Rmpfr_set_sj(mpfr_t * p, SV * q, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
#ifdef USE_64_BIT_INT
#ifndef _MSC_VER
     return newSViv(mpfr_set_sj(*p, SvIV(q), (mp_rnd_t)SvUV(round)));
#else
     croak("Rmpfr_set_sj() not implemented on this build of perl - use Rmpfr_set_str() instead");
#endif
#else
     croak("Rmpfr_set_sj() not implemented on this build of perl");
#endif
}

SV * Rmpfr_set_ld(mpfr_t * p, SV * q, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
#ifdef USE_LONG_DOUBLE
#ifndef _MSC_VER
     return newSViv(mpfr_set_ld(*p, SvNV(q), (mp_rnd_t)SvUV(round)));
#else
     croak("Rmpfr_set_ld() not implemented on this build of perl - use Rmpfr_set_d() instead");
#endif
#else
     croak("Rmpfr_set_ld() not implemented on this build of perl");
#endif
}

SV * Rmpfr_set_d(mpfr_t * p, SV * q, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_set_d(*p, SvNV(q), (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_set_z(mpfr_t * p, mpz_t * q, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_set_z(*p, *q, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_set_q(mpfr_t * p, mpq_t * q, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_set_q(*p, *q, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_set_f(mpfr_t * p, mpf_t * q, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_set_f(*p, *q, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_set_str(mpfr_t * p, SV * num, SV * base, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     int b = (int)SvIV(base);
     if(b < 0 || b > 36 || b == 1) croak("3rd argument supplied to Rmpfr_set_str is out of allowable range");
     return newSViv(mpfr_set_str(*p, SvPV_nolen(num), b, (mp_rnd_t)SvUV(round)));
}

void Rmpfr_set_str_binary(mpfr_t * p, SV * str) {
     mpfr_set_str_binary(*p, SvPV_nolen(str));
}

void Rmpfr_set_inf(mpfr_t * p, SV * sign) {
     mpfr_set_inf(*p, (int)SvIV(sign));
}

void Rmpfr_set_nan(mpfr_t * p) {
     mpfr_set_nan(*p);
}

void Rmpfr_swap(mpfr_t *p, mpfr_t * q) {
     mpfr_swap(*p, *q);
}

SV * Rmpfr_get_d(mpfr_t * p, SV * round){
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSVnv(mpfr_get_d(*p, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_get_d_2exp(SV * exp, mpfr_t * p, SV * round){
     long _exp;
     double ret;
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     ret = mpfr_get_d_2exp(&_exp, *p, (mp_rnd_t)SvUV(round));
     sv_setuv(exp, _exp);
     return newSVnv(ret);
}

SV * Rmpfr_get_ld_2exp(SV * exp, mpfr_t * p, SV * round){
#ifdef USE_LONG_DOUBLE
#ifndef _MSC_VER
     long _exp;
     long double ret;
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     ret = mpfr_get_ld_2exp(&_exp, *p, (mp_rnd_t)SvUV(round));
     sv_setuv(exp, _exp);
     return newSVnv(ret);
#else
     croak("Rmpfr_get_ld_2exp() not implemented on this build of perl - use Rmpfr_get_d_2exp() instead");
#endif
#else
     croak("Rmpfr_get_ld_2exp() not implemented on this build of perl");
#endif
}

SV * Rmpfr_get_ld(mpfr_t * p, SV * round){
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
#ifdef USE_LONG_DOUBLE
#ifndef _MSC_VER
     return newSVnv(mpfr_get_ld(*p, (mp_rnd_t)SvUV(round)));
#else
     croak("Rmpfr_get_ld() not implemented on this build of perl - use Rmpfr_get_d() instead");
#endif
#else
     croak("Rmpfr_get_ld() not implemented on this build of perl");
#endif
}

SV * Rmpfr_get_d1(mpfr_t * p) {
     return newSVnv(mpfr_get_d1(*p));
}

/* Alias for the perl function Rmpfr_get_z_exp
*  (which will perhaps one day be removed). 
*  The mpfr headers define 'mpfr_get_z_exp' to
*  'mpfr_get_z_2exp' when that function is
*  available. 
*/
SV * Rmpfr_get_z_2exp(mpz_t * z, mpfr_t * p){
     return newSViv(mpfr_get_z_exp(*z, *p));
}

SV * Rmpfr_add(mpfr_t * a, mpfr_t * b, mpfr_t * c, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_add(*a, *b, *c, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_add_ui(mpfr_t * a, mpfr_t * b, SV * c, SV * round){
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_add_ui(*a, *b, (unsigned long)SvUV(c), (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_add_d(mpfr_t * a, mpfr_t * b, SV * c, SV * round){
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_add_d(*a, *b, (double)SvNV(c), (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_add_si(mpfr_t * a, mpfr_t * b, SV * c, SV * round){
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_add_si(*a, *b, (int)SvIV(c), (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_add_z(mpfr_t * a, mpfr_t * b, mpz_t * c, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_add_z(*a, *b, *c, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_add_q(mpfr_t * a, mpfr_t * b, mpq_t * c, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_add_q(*a, *b, *c, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_sub(mpfr_t * a, mpfr_t * b, mpfr_t * c, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_sub(*a, *b, *c, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_sub_ui(mpfr_t * a, mpfr_t * b, SV * c, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_sub_ui(*a, *b, (unsigned long)SvUV(c), (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_sub_d(mpfr_t * a, mpfr_t * b, SV * c, SV * round){
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_sub_d(*a, *b, (double)SvNV(c), (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_sub_z(mpfr_t * a, mpfr_t * b, mpz_t * c, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_sub_z(*a, *b, *c, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_sub_q(mpfr_t * a, mpfr_t * b, mpq_t * c, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_sub_q(*a, *b, *c, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_ui_sub(mpfr_t * a, SV * b, mpfr_t * c, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_ui_sub(*a, (unsigned long)SvUV(b), *c, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_d_sub(mpfr_t * a, SV * b, mpfr_t * c, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_d_sub(*a, (double)SvNV(b), *c, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_mul(mpfr_t * a, mpfr_t * b, mpfr_t * c, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_mul(*a, *b, *c, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_mul_ui(mpfr_t * a, mpfr_t * b, SV * c, SV * round){
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_mul_ui(*a, *b, (unsigned long)SvUV(c), (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_mul_d(mpfr_t * a, mpfr_t * b, SV * c, SV * round){
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_mul_d(*a, *b, (double)SvNV(c), (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_mul_z(mpfr_t * a, mpfr_t * b, mpz_t * c, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_mul_z(*a, *b, *c, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_mul_q(mpfr_t * a, mpfr_t * b, mpq_t * c, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_mul_q(*a, *b, *c, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_dim(mpfr_t * rop, mpfr_t * op1, mpfr_t * op2, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
         int ret = mpfr_dim( *rop, *op1, *op2, (mp_rnd_t)SvUV(round));
         return newSViv(ret);
}

SV * Rmpfr_div(mpfr_t * a, mpfr_t * b, mpfr_t * c, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_div(*a, *b, *c, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_div_ui(mpfr_t * a, mpfr_t * b, SV * c, SV * round){
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_div_ui(*a, *b, (unsigned long)SvUV(c), (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_div_d(mpfr_t * a, mpfr_t * b, SV * c, SV * round){
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_div_d(*a, *b, (double)SvNV(c), (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_div_z(mpfr_t * a, mpfr_t * b, mpz_t * c, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_div_z(*a, *b, *c, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_div_q(mpfr_t * a, mpfr_t * b, mpq_t * c, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_div_q(*a, *b, *c, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_ui_div(mpfr_t * a, SV * b, mpfr_t * c, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_ui_div(*a, (unsigned long)SvUV(b), *c, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_d_div(mpfr_t * a, SV * b, mpfr_t * c, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_d_div(*a, (double)SvNV(b), *c, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_sqrt(mpfr_t * a, mpfr_t * b, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_sqrt(*a, *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_rec_sqrt(mpfr_t * a, mpfr_t * b, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_rec_sqrt(*a, *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_cbrt(mpfr_t * a, mpfr_t * b, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_cbrt(*a, *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_sqrt_ui(mpfr_t * a, SV * b, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_sqrt_ui(*a, (unsigned long)SvUV(b), (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_pow_ui(mpfr_t * a, mpfr_t * b, SV * c, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_pow_ui(*a, *b, (unsigned long)SvUV(c), (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_ui_pow_ui(mpfr_t * a, SV * b, SV * c, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_ui_pow_ui(*a, (unsigned long)SvUV(b), (unsigned long)SvUV(c), (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_ui_pow(mpfr_t * a, SV * b, mpfr_t * c, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_ui_pow(*a, (unsigned long)SvUV(b), *c, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_pow_si(mpfr_t * a, mpfr_t * b, SV * c, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_pow_si(*a, *b, (long)SvIV(c), (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_pow(mpfr_t * a, mpfr_t * b, mpfr_t * c, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_pow(*a, *b, *c, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_neg(mpfr_t * a, mpfr_t * b, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_neg(*a, *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_abs(mpfr_t * a, mpfr_t * b, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_abs(*a, *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_mul_2exp(mpfr_t * a, mpfr_t * b, SV * c, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_mul_2exp(*a, *b, (unsigned long)SvUV(c), (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_mul_2ui(mpfr_t * a, mpfr_t * b, SV * c, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_mul_2ui(*a, *b, (unsigned long)SvUV(c), (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_mul_2si(mpfr_t * a, mpfr_t * b, SV * c, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_mul_2si(*a, *b, (long)SvIV(c), (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_div_2exp(mpfr_t * a, mpfr_t * b, SV * c, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_div_2exp(*a, *b, (unsigned long)SvUV(c), (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_div_2ui(mpfr_t * a, mpfr_t * b, SV * c, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_div_2ui(*a, *b, (unsigned long)SvUV(c), (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_div_2si(mpfr_t * a, mpfr_t * b, SV * c, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_div_2si(*a, *b, (long)SvIV(c), (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_cmp(mpfr_t * a, mpfr_t * b) {
     return newSViv(mpfr_cmp(*a, *b));
}

SV * Rmpfr_cmpabs(mpfr_t * a, mpfr_t * b) {
     return newSViv(mpfr_cmpabs(*a, *b));
}

SV * Rmpfr_cmp_ui(mpfr_t * a, SV * b) {
     return newSViv(mpfr_cmp_ui(*a, (unsigned long)SvUV(b)));
}

SV * Rmpfr_cmp_d(mpfr_t * a, SV * b) {
     return newSViv(mpfr_cmp_d(*a, SvNV(b)));
}

SV * Rmpfr_cmp_ld(mpfr_t * a, SV * b) {
#ifdef USE_LONG_DOUBLE
#ifndef _MSC_VER
     return newSViv(mpfr_cmp_ld(*a, SvNV(b)));
#else
     croak("Rmpfr_cmp_ld() not implemented on this build of perl - use Rmpfr_cmp_d() instead");
#endif
#else
     croak("Rmpfr_cmp_ld() not implemented on this build of perl");
#endif
}

SV * Rmpfr_cmp_si(mpfr_t * a, SV * b) {
     return newSViv(mpfr_cmp_si(*a, (long)SvIV(b)));
}

SV * Rmpfr_cmp_ui_2exp(mpfr_t * a, SV * b, SV * c) {
     return newSViv(mpfr_cmp_ui_2exp(*a, (unsigned long)SvUV(b), (mp_exp_t)SvIV(c)));
}

SV * Rmpfr_cmp_si_2exp(mpfr_t * a, SV * b, SV * c) {
     return newSViv(mpfr_cmp_si_2exp(*a, (long)SvIV(b), (mp_exp_t)SvIV(c)));
}

SV * Rmpfr_eq(mpfr_t * a, mpfr_t * b, SV * c) {
     return newSViv(mpfr_eq(*a, *b, (unsigned long)SvUV(c)));
}

SV * Rmpfr_nan_p(mpfr_t * p) {
     return newSViv(mpfr_nan_p(*p));
}

SV * Rmpfr_inf_p(mpfr_t * p) {
     return newSViv(mpfr_inf_p(*p));
}

SV * Rmpfr_number_p(mpfr_t * p) {
     return newSViv(mpfr_number_p(*p));
}

void Rmpfr_reldiff(mpfr_t * a, mpfr_t * b, mpfr_t * c, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     mpfr_reldiff(*a, *b, *c, (mp_rnd_t)SvUV(round));
}

SV * Rmpfr_sgn(mpfr_t * p) {
     return newSViv(mpfr_sgn(*p));
}

SV * Rmpfr_greater_p(mpfr_t * a, mpfr_t * b) {
     return newSViv(mpfr_greater_p(*a, *b));
}

SV * Rmpfr_greaterequal_p(mpfr_t * a, mpfr_t * b) {
     return newSViv(mpfr_greaterequal_p(*a, *b));
}

SV * Rmpfr_less_p(mpfr_t * a, mpfr_t * b) {
     return newSViv(mpfr_less_p(*a, *b));
}

SV * Rmpfr_lessequal_p(mpfr_t * a, mpfr_t * b) {
     return newSViv(mpfr_lessequal_p(*a, *b));
}

SV * Rmpfr_lessgreater_p(mpfr_t * a, mpfr_t * b) {
     return newSViv(mpfr_lessgreater_p(*a, *b));
}

SV * Rmpfr_equal_p(mpfr_t * a, mpfr_t * b) {
     return newSViv(mpfr_equal_p(*a, *b));
}

SV * Rmpfr_unordered_p(mpfr_t * a, mpfr_t * b) {
     return newSViv(mpfr_unordered_p(*a, *b));
}

SV * Rmpfr_sin_cos(mpfr_t * a, mpfr_t * b, mpfr_t * c, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_sin_cos(*a, *b, *c, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_sinh_cosh(mpfr_t * a, mpfr_t * b, mpfr_t * c, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_sinh_cosh(*a, *b, *c, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_sin(mpfr_t * a, mpfr_t * b, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_sin(*a, *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_cos(mpfr_t * a, mpfr_t * b, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_cos(*a, *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_tan(mpfr_t * a, mpfr_t * b, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_tan(*a, *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_asin(mpfr_t * a, mpfr_t * b, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_asin(*a, *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_acos(mpfr_t * a, mpfr_t * b, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_acos(*a, *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_atan(mpfr_t * a, mpfr_t * b, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_atan(*a, *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_sinh(mpfr_t * a, mpfr_t * b, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_sinh(*a, *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_cosh(mpfr_t * a, mpfr_t * b, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_cosh(*a, *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_tanh(mpfr_t * a, mpfr_t * b, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_tanh(*a, *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_asinh(mpfr_t * a, mpfr_t * b, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_asinh(*a, *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_acosh(mpfr_t * a, mpfr_t * b, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_acosh(*a, *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_atanh(mpfr_t * a, mpfr_t * b, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_atanh(*a, *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_fac_ui(mpfr_t * a, SV * b, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_fac_ui(*a, (unsigned long)SvUV(b), (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_log1p(mpfr_t * a, mpfr_t * b, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_log1p(*a, *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_expm1(mpfr_t * a, mpfr_t * b, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_expm1(*a, *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_log2(mpfr_t * a, mpfr_t * b, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_log2(*a, *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_log10(mpfr_t * a, mpfr_t * b, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_log10(*a, *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_fma(mpfr_t * a, mpfr_t * b, mpfr_t * c, mpfr_t * d, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_fma(*a, *b, *c, *d, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_fms(mpfr_t * a, mpfr_t * b, mpfr_t * c, mpfr_t * d, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_fms(*a, *b, *c, *d, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_agm(mpfr_t * a, mpfr_t * b, mpfr_t * c, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_agm(*a, *b, *c, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_hypot(mpfr_t * a, mpfr_t * b, mpfr_t * c, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_hypot(*a, *b, *c, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_const_log2(mpfr_t * p, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_const_log2(*p, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_const_pi(mpfr_t * p, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_const_pi(*p, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_const_euler(mpfr_t * p, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_const_euler(*p, (mp_rnd_t)SvUV(round)));
}

void Rmpfr_print_binary(mpfr_t * p) {
     mpfr_print_binary(*p);
}

SV * Rmpfr_rint(mpfr_t * a, mpfr_t * b, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_rint(*a, *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_ceil(mpfr_t * a, mpfr_t * b) {
     return newSViv(mpfr_ceil(*a, *b));
}

SV * Rmpfr_floor(mpfr_t * a, mpfr_t * b) {
     return newSViv(mpfr_floor(*a, *b));
}

SV * Rmpfr_round(mpfr_t * a, mpfr_t * b) {
     return newSViv(mpfr_round(*a, *b));
}

SV * Rmpfr_trunc(mpfr_t * a, mpfr_t * b) {
     return newSViv(mpfr_trunc(*a, *b));
}

/* NO LONGER SUPPORTED
SV * Rmpfr_add_one_ulp(mpfr_t * p, SV * round) {
     return newSViv(mpfr_add_one_ulp(*p, (mp_rnd_t)SvUV(round)));
} */

/* NO LONGER SUPPORTED
SV * Rmpfr_sub_one_ulp(SV * p, SV * round) {
     return newSViv(mpfr_sub_one_ulp(*p, (mp_rnd_t)SvUV(round)));
} */

SV * Rmpfr_can_round(mpfr_t * p, SV * err, SV * round1, SV * round2, SV * prec) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round1) > 3 || (mp_rnd_t)SvUV(round2) > 3)
      croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_can_round(*p, (mp_exp_t)SvIV(err), SvUV(round1), SvUV(round2), (mpfr_prec_t)SvUV(prec)));
}

SV * Rmpfr_get_emin() {
     return newSViv(mpfr_get_emin());
}

SV * Rmpfr_get_emax() {
     return newSViv(mpfr_get_emax());
}

SV * Rmpfr_set_emin(SV * e) {
     return newSViv(mpfr_set_emin((mp_exp_t)SvIV(e)));
}

SV * Rmpfr_set_emax(SV * e) {
     return newSViv(mpfr_set_emax((mp_exp_t)SvIV(e)));
}

SV * Rmpfr_check_range(mpfr_t * p, SV * t, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_check_range(*p, (int)SvIV(t), (mp_rnd_t)SvUV(round)));
}

void Rmpfr_clear_underflow() {
     mpfr_clear_underflow();
}

void Rmpfr_clear_overflow() {
     mpfr_clear_overflow();
}

void Rmpfr_clear_nanflag() {
     mpfr_clear_nanflag();
}

void Rmpfr_clear_inexflag() {
     mpfr_clear_inexflag();
}

void Rmpfr_clear_flags() {
     mpfr_clear_flags();
}

SV * Rmpfr_underflow_p() {
     return newSViv(mpfr_underflow_p());
}

SV * Rmpfr_overflow_p() {
     return newSViv(mpfr_overflow_p());
}

SV * Rmpfr_nanflag_p() {
     return newSViv(mpfr_nanflag_p());
}

SV * Rmpfr_inexflag_p() {
     return newSViv(mpfr_inexflag_p());
}

SV * Rmpfr_log(mpfr_t * a, mpfr_t * b, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_log(*a, *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_exp(mpfr_t * a, mpfr_t * b, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_exp(*a, *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_exp2(mpfr_t * a, mpfr_t * b, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_exp2(*a, *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_exp10(mpfr_t * a, mpfr_t * b, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_exp10(*a, *b, (mp_rnd_t)SvUV(round)));
}

void Rmpfr_urandomb(SV * x, ...) {
     dXSARGS;
     unsigned long i, t;

     t = items;
     --t;

     for(i = 0; i < t; ++i) {
        mpfr_urandomb(*(INT2PTR(mpfr_t *, SvIV(SvRV(ST(i))))), *(INT2PTR(gmp_randstate_t *, SvIV(SvRV(ST(t))))));
        }
     XSRETURN(0);
}

void Rmpfr_random2(mpfr_t * p, SV * s, SV * exp) {
#if MPFR_VERSION_MAJOR > 2
     croak("Rmpfr_random2 no longer implemented. Use Rmpfr_urandom or Rmpfr_urandomb");
#else
     mpfr_random2(*p, (int)SvIV(s), (mp_exp_t)SvIV(exp));
#endif
}
 
SV * _TRmpfr_out_str(FILE * stream, SV * base, SV * dig, mpfr_t * p, SV * round) {
     size_t ret;
     if(SvIV(base) < 2 || SvIV(base) > 36) croak("2nd argument supplied to TRmpfr_out_str is out of allowable range (must be between 2 and 36 inclusive)");
     ret = mpfr_out_str(stream, (int)SvIV(base), (size_t)SvUV(dig), *p, (mp_rnd_t)SvUV(round));
     fflush(stream);
     return newSVuv(ret);
}

SV * _Rmpfr_out_str(mpfr_t * p, SV * base, SV * dig, SV * round) {
     size_t ret;
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     if(SvIV(base) < 2 || SvIV(base) > 36) croak("2nd argument supplied to Rmpfr_out_str is out of allowable range (must be between 2 and 36 inclusive)");
     ret = mpfr_out_str(NULL, (int)SvIV(base), (size_t)SvUV(dig), *p, (mp_rnd_t)SvUV(round));
     fflush(stdout);
     return newSVuv(ret);
}

SV * _TRmpfr_out_strS(FILE * stream, SV * base, SV * dig, mpfr_t * p, SV * round, SV * suff) {
     size_t ret;
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     if(SvIV(base) < 2 || SvIV(base) > 36) croak("2nd argument supplied to TRmpfr_out_str is out of allowable range (must be between 2 and 36 inclusive)");
     ret = mpfr_out_str(stream, (int)SvIV(base), (size_t)SvUV(dig), *p, (mp_rnd_t)SvUV(round));
     fflush(stream);
     fprintf(stream, "%s", SvPV_nolen(suff));
     fflush(stream);
     return newSVuv(ret);
}

SV * _TRmpfr_out_strP(SV * pre, FILE * stream, SV * base, SV * dig, mpfr_t * p, SV * round) {
     size_t ret;
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     if(SvIV(base) < 2 || SvIV(base) > 36) croak("3rd argument supplied to TRmpfr_out_str is out of allowable range (must be between 2 and 36 inclusive)");
     fprintf(stream, "%s", SvPV_nolen(pre));
     fflush(stream);
     ret = mpfr_out_str(stream, (int)SvIV(base), (size_t)SvUV(dig), *p, (mp_rnd_t)SvUV(round));
     fflush(stream);
     return newSVuv(ret);
}

SV * _TRmpfr_out_strPS(SV * pre, FILE * stream, SV * base, SV * dig, mpfr_t * p, SV * round, SV * suff) {
     size_t ret;
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     if(SvIV(base) < 2 || SvIV(base) > 36) croak("3rd argument supplied to TRmpfr_out_str is out of allowable range (must be between 2 and 36 inclusive)");
     fprintf(stream, "%s", SvPV_nolen(pre));
     fflush(stream);
     ret = mpfr_out_str(stream, (int)SvIV(base), (size_t)SvUV(dig), *p, (mp_rnd_t)SvUV(round));
     fflush(stream);
     fprintf(stream, "%s", SvPV_nolen(suff));
     fflush(stream);
     return newSVuv(ret);
}

SV * _Rmpfr_out_strS(mpfr_t * p, SV * base, SV * dig, SV * round, SV * suff) {
     size_t ret;
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     if(SvIV(base) < 2 || SvIV(base) > 36) croak("2nd argument supplied to Rmpfr_out_str is out of allowable range (must be between 2 and 36 inclusive)");
     ret = mpfr_out_str(NULL, (int)SvIV(base), (size_t)SvUV(dig), *p, (mp_rnd_t)SvUV(round));
     printf("%s", SvPV_nolen(suff));
     fflush(stdout);
     return newSVuv(ret);
}

SV * _Rmpfr_out_strP(SV * pre, mpfr_t * p, SV * base, SV * dig, SV * round) {
     size_t ret;
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     if(SvIV(base) < 2 || SvIV(base) > 36) croak("3rd argument supplied to Rmpfr_out_str is out of allowable range (must be between 2 and 36 inclusive)");
     printf("%s", SvPV_nolen(pre));
     ret = mpfr_out_str(NULL, (int)SvIV(base), (size_t)SvUV(dig), *p, (mp_rnd_t)SvUV(round));
     fflush(stdout);
     return newSVuv(ret);
}

SV * _Rmpfr_out_strPS(SV * pre, mpfr_t * p, SV * base, SV * dig, SV * round, SV * suff) {
     size_t ret;
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     if(SvIV(base) < 2 || SvIV(base) > 36) croak("3rd argument supplied to Rmpfr_out_str is out of allowable range (must be between 2 and 36 inclusive)");
     printf("%s", SvPV_nolen(pre));
     ret = mpfr_out_str(NULL, (int)SvIV(base), (size_t)SvUV(dig), *p, (mp_rnd_t)SvUV(round));
     printf("%s", SvPV_nolen(suff));
     fflush(stdout);
     return newSVuv(ret);
}

SV * TRmpfr_inp_str(mpfr_t * p, FILE * stream, SV * base, SV * round) {
     size_t ret;
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     if(SvIV(base) < 2 || SvIV(base) > 36) croak("3rd argument supplied to TRmpfr_inp_str is out of allowable range (must be between 2 and 36 inclusive)");
     ret = mpfr_inp_str(*p, stream, (int)SvIV(base), (mp_rnd_t)SvUV(round));
     /* fflush(stream); */
     return newSVuv(ret);
}

SV * Rmpfr_inp_str(mpfr_t * p, SV * base, SV * round) {
     size_t ret;
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     if(SvIV(base) < 2 || SvIV(base) > 36) croak("2nd argument supplied to Rmpfr_inp_str is out of allowable range (must be between 2 and 36 inclusive)");
     ret = mpfr_inp_str(*p, NULL, (int)SvIV(base), (mp_rnd_t)SvUV(round));
     /* fflush(stdin); */
     return newSVuv(ret);
}

SV * Rmpfr_gamma(mpfr_t * a, mpfr_t * b, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_gamma(*a, *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_zeta(mpfr_t * a, mpfr_t * b, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_zeta(*a, *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_zeta_ui(mpfr_t * a, SV * b, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_zeta_ui(*a, (unsigned long)SvUV(b), (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_erf(mpfr_t * a, mpfr_t * b, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_erf(*a, *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_frac(mpfr_t * a, mpfr_t * b, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_frac(*a, *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_remainder(mpfr_t * a, mpfr_t * b, mpfr_t * c, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_remainder(*a, *b, *c, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_modf(mpfr_t * a, mpfr_t * b, mpfr_t * c, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_modf(*a, *b, *c, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_fmod(mpfr_t * a, mpfr_t * b, mpfr_t * c, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_fmod(*a, *b, *c, (mp_rnd_t)SvUV(round)));
}

void Rmpfr_remquo(mpfr_t * a, mpfr_t * b, mpfr_t * c, SV * round) {
     dXSARGS;
     long ret, q;
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     ret = mpfr_remquo(*a, &q, *b, *c, (mp_rnd_t)SvUV(round)); 
     // sp  = mark; // not needed
     ST(0) = sv_2mortal(newSViv(q));
     ST(1) = sv_2mortal(newSViv(ret));
     // PUTBACK; // not needed
     XSRETURN(2);
} 

SV * Rmpfr_integer_p(mpfr_t * p) {
     return newSViv(mpfr_integer_p(*p));
}

void Rmpfr_nexttoward(mpfr_t * a, mpfr_t * b) {
     mpfr_nexttoward(*a, *b);
}

void Rmpfr_nextabove(mpfr_t * p) {
     mpfr_nextabove(*p);
}

void Rmpfr_nextbelow(mpfr_t * p) {
     mpfr_nextbelow(*p);
}

SV * Rmpfr_min(mpfr_t * a, mpfr_t * b, mpfr_t * c, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_min(*a, *b, *c, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_max(mpfr_t * a, mpfr_t * b, mpfr_t * c, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_max(*a, *b, *c, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_get_exp(mpfr_t * p) {
     return newSViv(mpfr_get_exp(*p));
}

SV * Rmpfr_set_exp(mpfr_t * p, SV * exp) {
     return newSViv(mpfr_set_exp(*p, (mp_exp_t)SvIV(exp)));
}

SV * Rmpfr_signbit(mpfr_t * op) {
     return newSViv(mpfr_signbit(*op));
}

SV * Rmpfr_setsign(mpfr_t * rop, mpfr_t * op, SV * sign, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_setsign(*rop, *op, SvIV(sign), (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_copysign(mpfr_t * rop, mpfr_t * op1, mpfr_t * op2, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_copysign(*rop, *op1, *op2, (mp_rnd_t)SvUV(round)));
}

SV * get_refcnt(SV * s) {
     return newSVuv(SvREFCNT(s));
}

SV * get_package_name(SV * x) {
     if(sv_isobject(x)) return newSVpv(HvNAME(SvSTASH(SvRV(x))), 0);
     return newSViv(0);
}

void Rmpfr_dump(mpfr_t * a) { /* Once took a 'round' argument */
     mpfr_dump(*a);
} 

SV * gmp_v() {
     return newSVpv(gmp_version, 0);
}

/* NEW in MPFR-2.1.0 */

SV * Rmpfr_set_ui_2exp(mpfr_t * a, SV * b, SV * c, SV * round) {
     return newSViv(mpfr_set_ui_2exp(*a, (unsigned long)SvUV(b), (mp_exp_t)SvIV(c), (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_set_si_2exp(mpfr_t * a, SV * b, SV * c, SV * round) {
     return newSViv(mpfr_set_si_2exp(*a, (long)SvIV(b), (mp_exp_t)SvIV(c), (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_set_uj_2exp(mpfr_t * a, SV * b, SV * c, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
#ifdef USE_64_BIT_INT
#ifndef _MSC_VER
     return newSViv(mpfr_set_uj_2exp(*a, SvUV(b), SvIV(c), (mp_rnd_t)SvUV(round)));
#else
     croak ("Rmpfr_set_uj_2exp() not implemented on this build of perl");
#endif
#else
     croak ("Rmpfr_set_uj_2exp() not implemented on this build of perl");
#endif
}

SV * Rmpfr_set_sj_2exp(mpfr_t * a, SV * b, SV * c, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
#ifdef USE_64_BIT_INT
#ifndef _MSC_VER
     return newSViv(mpfr_set_sj_2exp(*a, SvIV(b), SvIV(c), (mp_rnd_t)SvUV(round)));
#else
     croak ("Rmpfr_set_sj_2exp() not implemented on this build of perl");
#endif
#else
     croak ("Rmpfr_set_sj_2exp() not implemented on this build of perl");
#endif
}

SV * Rmpfr_get_z(mpz_t * a, mpfr_t * b, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
#if MPFR_VERSION_MAJOR < 3
     mpfr_get_z(*a, *b, (mp_rnd_t)SvUV(round));
     return &PL_sv_undef;
#else
     return newSViv(mpfr_get_z(*a, *b, (mp_rnd_t)SvUV(round)));
#endif
}

SV * Rmpfr_si_sub(mpfr_t * a, SV * b, mpfr_t * c, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_si_sub(*a, (long)SvIV(b), *c, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_sub_si(mpfr_t * a, mpfr_t * b, SV * c, SV * round){
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_sub_si(*a, *b, (long)SvIV(c), (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_mul_si(mpfr_t * a, mpfr_t * b, SV * c, SV * round){
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_mul_si(*a, *b, (long)SvIV(c), (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_si_div(mpfr_t * a, SV * b, mpfr_t * c, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_si_div(*a, (long)SvIV(b), *c, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_div_si(mpfr_t * a, mpfr_t * b, SV * c, SV * round){
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_div_si(*a, *b, (long)SvIV(c), (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_sqr(mpfr_t * a, mpfr_t * b, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_sqr(*a, *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_cmp_z(mpfr_t * a, mpz_t * b) {
     return newSViv(mpfr_cmp_z(*a, *b));
}

SV * Rmpfr_cmp_q(mpfr_t * a, mpq_t * b) {
     return newSViv(mpfr_cmp_q(*a, *b));
}

SV * Rmpfr_cmp_f(mpfr_t * a, mpf_t * b) {
     return newSViv(mpfr_cmp_f(*a, *b));
}

SV * Rmpfr_zero_p(mpfr_t * a) {
     return newSViv(mpfr_zero_p(*a));
}

void Rmpfr_free_cache() {
     mpfr_free_cache();
}

SV * Rmpfr_get_version() {
     return newSVpv(mpfr_get_version(), 0);
}

SV * Rmpfr_get_patches() {
     return newSVpv(mpfr_get_patches(), 0);
}

SV * Rmpfr_get_emin_min() {
     return newSViv(mpfr_get_emin_min());
}

SV * Rmpfr_get_emin_max() {
     return newSViv(mpfr_get_emin_max());
}

SV * Rmpfr_get_emax_min() {
     return newSViv(mpfr_get_emax_min());
}

SV * Rmpfr_get_emax_max() {
     return newSViv(mpfr_get_emax_max());
}

void Rmpfr_clear_erangeflag() {
     mpfr_clear_erangeflag();
}

SV * Rmpfr_erangeflag_p() {
     return newSViv(mpfr_erangeflag_p());
}

SV * Rmpfr_rint_round(mpfr_t * a, mpfr_t * b, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_rint_round(*a, *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_rint_trunc(mpfr_t * a, mpfr_t * b, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_rint_trunc(*a, *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_rint_ceil(mpfr_t * a, mpfr_t * b, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_rint_ceil(*a, *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_rint_floor(mpfr_t * a, mpfr_t * b, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_rint_floor(*a, *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_get_ui(mpfr_t * a, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSVuv(mpfr_get_ui(*a, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_get_si(mpfr_t * a, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_get_si(*a, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_get_uj(mpfr_t * a, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
#ifdef USE_64_BIT_INT
     return newSVuv(mpfr_get_uj(*a, (mp_rnd_t)SvUV(round)));
#else
     croak ("Rmpfr_get_uj() not implemented on this build of perl");
#endif
}

SV * Rmpfr_get_sj(mpfr_t * a, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
#ifdef USE_64_BIT_INT
     return newSViv(mpfr_get_sj(*a, (mp_rnd_t)SvUV(round)));
#else
     croak ("Rmpfr_get_sj() not implemented on this build of perl");
#endif
}

SV * Rmpfr_get_IV(mpfr_t * x, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     if(sizeof(IV) == sizeof(int)) return newSViv(mpfr_get_si(*x, (mp_rnd_t)SvUV(round)));
#if defined USE_64_BIT_INT
#ifndef _MSC_VER
     if(sizeof(IV) == sizeof(intmax_t)) return newSViv(mpfr_get_sj(*x, (mp_rnd_t)SvUV(round)));
#else
     if(sizeof(IV) == sizeof(signed __int64)) return newSViv(mpfr_get_sj(*x, (mp_rnd_t)SvUV(round)));
#endif
#endif
     croak("Rmpfr_get_IV not implemented on this build of perl");
}

SV * Rmpfr_get_UV(mpfr_t * x, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     if(sizeof(UV) == sizeof(unsigned long)) return newSVuv(mpfr_get_ui(*x, (mp_rnd_t)SvUV(round)));
#if defined USE_64_BIT_INT
#ifndef _MSC_VER
     if(sizeof(UV) == sizeof(uintmax_t)) return newSVuv(mpfr_get_uj(*x, (mp_rnd_t)SvUV(round)));
#else
     if(sizeof(UV) == sizeof(unsigned __int64)) return newSVuv(mpfr_get_uj(*x, (mp_rnd_t)SvUV(round)));
#endif
#endif
     croak("Rmpfr_get_UV not implemented on this build of perl");
}

SV * Rmpfr_get_NV(mpfr_t * x, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     if(sizeof(NV) == sizeof(double)) return newSVnv(mpfr_get_d(*x, (mp_rnd_t)SvUV(round)));
#if defined USE_LONG_DOUBLE
#ifndef _MSC_VER
     if(sizeof(NV) == sizeof(long double)) return newSVnv(mpfr_get_ld(*x, (mp_rnd_t)SvUV(round)));
#endif
#endif
     croak("Rmpfr_get_NV not implemented on this build of perl");
}

SV * Rmpfr_fits_ulong_p(mpfr_t * a, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSVuv(mpfr_fits_ulong_p(*a, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_fits_slong_p(mpfr_t * a, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSVuv(mpfr_fits_slong_p(*a, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_fits_ushort_p(mpfr_t * a, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSVuv(mpfr_fits_ushort_p(*a, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_fits_sshort_p(mpfr_t * a, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSVuv(mpfr_fits_sshort_p(*a, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_fits_uint_p(mpfr_t * a, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSVuv(mpfr_fits_uint_p(*a, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_fits_sint_p(mpfr_t * a, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSVuv(mpfr_fits_sint_p(*a, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_fits_uintmax_p(mpfr_t * a, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSVuv(mpfr_fits_uintmax_p(*a, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_fits_intmax_p(mpfr_t * a, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSVuv(mpfr_fits_intmax_p(*a, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_fits_IV_p(mpfr_t * x, SV * round) {
     unsigned long ret = 0, bits = sizeof(IV) * 8;
     mpfr_t high, low, copy;

#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif

     if(sizeof(IV) == sizeof(long)) {
       if(mpfr_fits_slong_p(*x, (mp_rnd_t)SvUV(round))) return newSVuv(1);
       return newSVuv(0);
     }

     if(sizeof(IV) == sizeof(int)) {
       if(mpfr_fits_sint_p(*x, (mp_rnd_t)SvUV(round))) return newSVuv(1);
       return newSVuv(0);
     }

#if defined USE_64_BIT_INT || defined USE_LONG_DOUBLE
#ifndef _MSC_VER
     if(sizeof(IV) == sizeof(intmax_t)) {
       if(mpfr_fits_intmax_p(*x, (mp_rnd_t)SvUV(round))) return newSVuv(1);
       return newSVuv(0);
     }
#else
     if(sizeof(IV) == sizeof(signed __int64)) {
       if(mpfr_fits_intmax_p(*x, (mp_rnd_t)SvUV(round))) return newSVuv(1);
       return newSVuv(0);
     }
#endif
#endif

     mpfr_init2(high, bits);
     mpfr_init2(low, bits);
     mpfr_init2(copy, bits - 1);

     mpfr_set_ui(high, 1, GMP_RNDN);
     mpfr_mul_2exp(high, high, bits - 1, GMP_RNDN);
     mpfr_sub_ui(high, high, 1, GMP_RNDN);

     mpfr_setsign(low, high, 1, GMP_RNDN);
     mpfr_sub_ui(low, low, 1, GMP_RNDN);
     mpfr_set(copy, *x, (mp_rnd_t)SvUV(round));

     if(mpfr_lessequal_p(copy, high) && mpfr_greaterequal_p(copy, low)) ret = 1;

     mpfr_clear(high);
     mpfr_clear(low);
     mpfr_clear(copy);

     return newSVuv(ret);
}

SV * Rmpfr_fits_UV_p(mpfr_t * x, SV * round) {
     unsigned long ret = 0, bits = sizeof(UV) * 8;
     mpfr_t high, copy;

#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif

     if(sizeof(UV) == sizeof(unsigned long)) {
       if(mpfr_fits_ulong_p(*x, (mp_rnd_t)SvUV(round))) return newSVuv(1);
       return newSVuv(0);
     }

     if(sizeof(UV) == sizeof(unsigned int)) {
       if(mpfr_fits_uint_p(*x, (mp_rnd_t)SvUV(round))) return newSVuv(1);
       return newSVuv(0);
     }

#if defined USE_64_BIT_INT || defined USE_LONG_DOUBLE
#ifndef _MSC_VER
     if(sizeof(UV) == sizeof(uintmax_t)) {
       if(mpfr_fits_uintmax_p(*x, (mp_rnd_t)SvUV(round))) return newSVuv(1);
       return newSVuv(0);
     }
#else
     if(sizeof(UV) == sizeof(unsigned __int64)) {
       if(mpfr_fits_intmax_p(*x, (mp_rnd_t)SvUV(round))) return newSVuv(1);
       return newSVuv(0);
     }
#endif
#endif

     mpfr_init2(high, bits + 1);
     mpfr_init2(copy, bits);

     mpfr_set_ui(high, 1, GMP_RNDN);
     mpfr_mul_2exp(high, high, bits, GMP_RNDN);
     mpfr_sub_ui(high, high, 1, GMP_RNDN);

     mpfr_set(copy, *x, (mp_rnd_t)SvUV(round));

     if(mpfr_lessequal_p(copy, high) && mpfr_cmp_ui(copy, 0) >= 0) ret = 1;

     mpfr_clear(high);
     mpfr_clear(copy);

     return newSVuv(ret);
}

SV * Rmpfr_strtofr(mpfr_t * a, SV * str, SV * base, SV * round) {
     int b = (int)SvIV(base);
     /* char ** endptr; */
#if MPFR_VERSION_MAJOR < 3
     if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
     if(b < 0 || b > 36 || b == 1) croak("3rd argument supplied to Rmpfr_strtofr is out of allowable range");
#else
     if(b < 0 || b > 62 || b == 1) croak("3rd argument supplied to Rmpfr_strtofr is out of allowable range");
#endif
     return newSViv(mpfr_strtofr(*a, SvPV_nolen(str), NULL, b, (mp_rnd_t)SvUV(round)));
}

void Rmpfr_set_erangeflag() {
     mpfr_set_erangeflag();
}

void Rmpfr_set_underflow() {
     mpfr_set_underflow();
}

void Rmpfr_set_overflow() {
     mpfr_set_overflow();
}

void Rmpfr_set_nanflag() {
     mpfr_set_nanflag();
}

void Rmpfr_set_inexflag() {
     mpfr_set_inexflag();
}

SV * Rmpfr_erfc(mpfr_t * a, mpfr_t * b, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_erfc(*a, *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_j0(mpfr_t * a, mpfr_t * b, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_j0(*a, *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_j1(mpfr_t * a, mpfr_t * b, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_j1(*a, *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_jn(mpfr_t * a, SV * n, mpfr_t * b, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_jn(*a, (long)SvIV(n), *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_y0(mpfr_t * a, mpfr_t * b, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_y0(*a, *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_y1(mpfr_t * a, mpfr_t * b, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_y1(*a, *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_yn(mpfr_t * a, SV * n, mpfr_t * b, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_yn(*a, (long)SvIV(n), *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_atan2(mpfr_t * a, mpfr_t * b, mpfr_t * c, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_atan2(*a, *b, *c, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_pow_z(mpfr_t * a, mpfr_t * b, mpz_t * c,  SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_pow_z(*a, *b, *c, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_subnormalize(mpfr_t * a, SV * b, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_subnormalize(*a, (int)SvIV(b), (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_const_catalan(mpfr_t * a, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_const_catalan(*a, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_sec(mpfr_t * a, mpfr_t * b, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_sec(*a, *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_csc(mpfr_t * a, mpfr_t * b, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_csc(*a, *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_cot(mpfr_t * a, mpfr_t * b, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_cot(*a, *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_root(mpfr_t * a, mpfr_t * b, SV * c, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_root(*a, *b, (unsigned long)SvUV(c), (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_eint(mpfr_t * a, mpfr_t * b, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_eint(*a, *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_li2(mpfr_t * a, mpfr_t * b, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_li2(*a, *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_get_f(mpf_t * a, mpfr_t * b, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_get_f(*a, *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_sech(mpfr_t * a, mpfr_t * b, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_sech(*a, *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_csch(mpfr_t * a, mpfr_t * b, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_csch(*a, *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_coth(mpfr_t * a, mpfr_t * b, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_coth(*a, *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_lngamma(mpfr_t * a, mpfr_t * b, SV * round) {
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     return newSViv(mpfr_lngamma(*a, *b, (mp_rnd_t)SvUV(round)));
}

void Rmpfr_lgamma(mpfr_t * a, mpfr_t * b, SV * round) {
     dXSARGS;
     int ret, signp;
#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif
     ret = mpfr_lgamma(*a, &signp, *b, (mp_rnd_t)SvUV(round)); 
     ST(0) = sv_2mortal(newSViv(signp));
     ST(1) = sv_2mortal(newSViv(ret));
     XSRETURN(2);
} 

SV * _MPFR_VERSION() {
     return newSVuv(MPFR_VERSION);
}

SV * _MPFR_VERSION_MAJOR() {
     return newSVuv(MPFR_VERSION_MAJOR);
}

SV * _MPFR_VERSION_MINOR() {
     return newSVuv(MPFR_VERSION_MINOR);
}
  
SV * _MPFR_VERSION_PATCHLEVEL() {
     return newSVuv(MPFR_VERSION_PATCHLEVEL);
}

SV * _MPFR_VERSION_STRING() {
     return newSVpv(MPFR_VERSION_STRING, 0);
}

SV * RMPFR_VERSION_NUM(SV * a, SV * b, SV * c) {
     return newSVuv(MPFR_VERSION_NUM((unsigned long)SvUV(a), (unsigned long)SvUV(b), (unsigned long)SvUV(c)));
}

SV * Rmpfr_sum(mpfr_t * rop, SV * avref, SV * len, SV * round) {
     mpfr_ptr *p;
     SV ** elem;
     int ret, i;
     unsigned long s = (unsigned long)SvUV(len);

#if MPFR_VERSION_MAJOR < 3
    if((mp_rnd_t)SvUV(round) > 3) croak("Illegal rounding value supplied for this version (%s) of the mpfr library", MPFR_VERSION_STRING);
#endif

     New(42, p, s, mpfr_ptr);
     if(p == NULL) croak("Unable to allocate memory in Rmpfr_sum()"); 

     for(i = 0; i < s; ++i) {
        elem = av_fetch((AV*)SvRV(avref), i, 0);
        p[i] = (INT2PTR(mpfr_t *, SvIV(SvRV(*elem))))[0];
     }  

     ret = mpfr_sum(*rop, p, s, (mp_rnd_t)SvUV(round));  

     Safefree(p);
     return newSVuv(ret);
}

/* Finish typemapping - typemap 1st arg only */

SV * overload_mul(mpfr_t * a, SV * b, SV * third) {
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;

     New(1, mpfr_t_obj, 1, mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in overload_mul function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, "Math::MPFR");
     mpfr_init(*mpfr_t_obj);
     sv_setiv(obj, INT2PTR(IV,mpfr_t_obj));
     SvREADONLY_on(obj);

#ifdef USE_64_BIT_INT
#ifndef _MSC_VER
     if(SvUOK(b)) {
       mpfr_set_uj(*mpfr_t_obj, SvUV(b), __gmpfr_default_rounding_mode);
       mpfr_mul(*mpfr_t_obj, *a, *mpfr_t_obj, __gmpfr_default_rounding_mode);
       return obj_ref;
       }

     if(SvIOK(b)) {
       mpfr_set_sj(*mpfr_t_obj, SvIV(b), __gmpfr_default_rounding_mode);
       mpfr_mul(*mpfr_t_obj, *a, *mpfr_t_obj, __gmpfr_default_rounding_mode);
       return obj_ref;
       }
#else
     if(SvIOK(b)) {
       if(mpfr_set_str(*mpfr_t_obj, SvPV_nolen(b), 10, __gmpfr_default_rounding_mode))
         croak("Invalid string supplied to Math::MPFR::overload_mul");
       mpfr_mul(*mpfr_t_obj, *a, *mpfr_t_obj, __gmpfr_default_rounding_mode);
       return obj_ref;
       }
#endif
#else
     if(SvUOK(b)) {
       mpfr_mul_ui(*mpfr_t_obj, *a, SvUV(b), __gmpfr_default_rounding_mode);
       return obj_ref;
       }

     if(SvIOK(b)) {
       if(SvIV(b) >= 0) {
         mpfr_mul_ui(*mpfr_t_obj, *a, SvUV(b), __gmpfr_default_rounding_mode);
         return obj_ref;
         }
       mpfr_mul_ui(*mpfr_t_obj, *a, SvIV(b) * -1, __gmpfr_default_rounding_mode);
       mpfr_neg(*mpfr_t_obj, *mpfr_t_obj, __gmpfr_default_rounding_mode);
       return obj_ref;
       }
#endif

     if(SvNOK(b)) {
#ifdef USE_LONG_DOUBLE
#ifndef _MSC_VER
       mpfr_set_ld(*mpfr_t_obj, SvNV(b), __gmpfr_default_rounding_mode);
#else
       mpfr_set_d(*mpfr_t_obj, SvNV(b), __gmpfr_default_rounding_mode);
#endif
#else
       mpfr_set_d(*mpfr_t_obj, SvNV(b), __gmpfr_default_rounding_mode);
#endif
       mpfr_mul(*mpfr_t_obj, *a, *mpfr_t_obj, __gmpfr_default_rounding_mode);
       return obj_ref;
       }

     if(SvPOK(b)) {
       if(mpfr_set_str(*mpfr_t_obj, SvPV_nolen(b), 0, __gmpfr_default_rounding_mode))
         croak("Invalid string supplied to Math::MPFR::overload_mul");
       mpfr_mul(*mpfr_t_obj, *a, *mpfr_t_obj, __gmpfr_default_rounding_mode);
       return obj_ref;
       }

     if(sv_isobject(b)) {
       if(strEQ(HvNAME(SvSTASH(SvRV(b))), "Math::MPFR")) {
         mpfr_mul(*mpfr_t_obj, *a, *(INT2PTR(mpfr_t *, SvIV(SvRV(b)))), __gmpfr_default_rounding_mode);
         return obj_ref;
         }
       }

     croak("Invalid argument supplied to Math::MPFR::overload_mul");
}

SV * overload_add(mpfr_t* a, SV * b, SV * third) {
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;

     New(1, mpfr_t_obj, 1, mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in overload_add function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, "Math::MPFR");
     mpfr_init(*mpfr_t_obj);
     sv_setiv(obj, INT2PTR(IV,mpfr_t_obj));
     SvREADONLY_on(obj);

#ifdef USE_64_BIT_INT
#ifndef _MSC_VER
     if(SvUOK(b)) {
       mpfr_set_uj(*mpfr_t_obj, SvUV(b), __gmpfr_default_rounding_mode);
       mpfr_add(*mpfr_t_obj, *a, *mpfr_t_obj, __gmpfr_default_rounding_mode);
       return obj_ref;
       }

     if(SvIOK(b)) {
       mpfr_set_sj(*mpfr_t_obj, SvIV(b), __gmpfr_default_rounding_mode);
       mpfr_add(*mpfr_t_obj, *a, *mpfr_t_obj, __gmpfr_default_rounding_mode);
       return obj_ref;
       }
#else
     if(SvIOK(b)) {
       if(mpfr_set_str(*mpfr_t_obj, SvPV_nolen(b), 10, __gmpfr_default_rounding_mode))
         croak("Invalid string supplied to Math::MPFR::overload_add");
       mpfr_add(*mpfr_t_obj, *a, *mpfr_t_obj, __gmpfr_default_rounding_mode);
       return obj_ref;
       }
#endif
#else
     if(SvUOK(b)) {
       mpfr_add_ui(*mpfr_t_obj, *a, SvUV(b), __gmpfr_default_rounding_mode);
       return obj_ref;
       }

     if(SvIOK(b)) {
       if(SvIV(b) >= 0) {
         mpfr_add_ui(*mpfr_t_obj, *a, SvUV(b), __gmpfr_default_rounding_mode);
         return obj_ref;
         }
       mpfr_sub_ui(*mpfr_t_obj, *a, SvIV(b) * -1, __gmpfr_default_rounding_mode);
       return obj_ref;
       }
#endif

     if(SvNOK(b)) {
#ifdef USE_LONG_DOUBLE
#ifndef _MSC_VER
       mpfr_set_ld(*mpfr_t_obj, SvNV(b), __gmpfr_default_rounding_mode);
#else
       mpfr_set_d(*mpfr_t_obj, SvNV(b), __gmpfr_default_rounding_mode);
#endif
#else
       mpfr_set_d(*mpfr_t_obj, SvNV(b), __gmpfr_default_rounding_mode);
#endif
       mpfr_add(*mpfr_t_obj, *a, *mpfr_t_obj, __gmpfr_default_rounding_mode);
       return obj_ref;
       }

     if(SvPOK(b)) {
       if(mpfr_set_str(*mpfr_t_obj, SvPV_nolen(b), 0, __gmpfr_default_rounding_mode))
         croak("Invalid string supplied to Math::MPFR::overload_add");
       mpfr_add(*mpfr_t_obj, *a, *mpfr_t_obj, __gmpfr_default_rounding_mode);
       return obj_ref;
       }

     if(sv_isobject(b)) {
       if(strEQ(HvNAME(SvSTASH(SvRV(b))), "Math::MPFR")) {
         mpfr_add(*mpfr_t_obj, *a, *(INT2PTR(mpfr_t *, SvIV(SvRV(b)))), __gmpfr_default_rounding_mode);
         return obj_ref;
         }
       }

     croak("Invalid argument supplied to Math::MPFR::overload_add");
}

SV * overload_sub(mpfr_t * a, SV * b, SV * third) {
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;

     New(1, mpfr_t_obj, 1, mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in overload_sub function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, "Math::MPFR");
     mpfr_init(*mpfr_t_obj);
     sv_setiv(obj, INT2PTR(IV,mpfr_t_obj));
     SvREADONLY_on(obj);

#ifdef USE_64_BIT_INT
#ifndef _MSC_VER
     if(SvUOK(b)) {
       mpfr_set_uj(*mpfr_t_obj, SvUV(b), __gmpfr_default_rounding_mode);
       if(third == &PL_sv_yes) mpfr_sub(*mpfr_t_obj, *mpfr_t_obj, *a, __gmpfr_default_rounding_mode);
       else mpfr_sub(*mpfr_t_obj, *a, *mpfr_t_obj, __gmpfr_default_rounding_mode);
       return obj_ref;
       }

     if(SvIOK(b)) {
       mpfr_set_sj(*mpfr_t_obj, SvIV(b), __gmpfr_default_rounding_mode);
       if(third == &PL_sv_yes) mpfr_sub(*mpfr_t_obj, *mpfr_t_obj, *a, __gmpfr_default_rounding_mode);
       else mpfr_sub(*mpfr_t_obj, *a, *mpfr_t_obj, __gmpfr_default_rounding_mode);
       return obj_ref;
       }
#else
     if(SvIOK(b)) {
       if(mpfr_set_str(*mpfr_t_obj, SvPV_nolen(b), 10, __gmpfr_default_rounding_mode))
         croak("Invalid string supplied to Math::MPFR::overload_sub");
       if(third == &PL_sv_yes) mpfr_sub(*mpfr_t_obj, *mpfr_t_obj, *a, __gmpfr_default_rounding_mode);
       else mpfr_sub(*mpfr_t_obj, *a, *mpfr_t_obj, __gmpfr_default_rounding_mode);
       return obj_ref;
       }
#endif
#else
     if(SvUOK(b)) {
       if(third == &PL_sv_yes) mpfr_ui_sub(*mpfr_t_obj, SvUV(b), *a, __gmpfr_default_rounding_mode);
       else mpfr_sub_ui(*mpfr_t_obj, *a, SvUV(b), __gmpfr_default_rounding_mode);
       return obj_ref;
       }

     if(SvIOK(b)) {
       if(SvIV(b) >= 0) {
         if(third == &PL_sv_yes) mpfr_ui_sub(*mpfr_t_obj, SvUV(b), *a, __gmpfr_default_rounding_mode);
         else mpfr_sub_ui(*mpfr_t_obj, *a, SvUV(b), __gmpfr_default_rounding_mode);
         return obj_ref;
         }
       mpfr_add_ui(*mpfr_t_obj, *a, SvIV(b) * -1, __gmpfr_default_rounding_mode);
       if(third == &PL_sv_yes) mpfr_neg(*mpfr_t_obj, *mpfr_t_obj, __gmpfr_default_rounding_mode);
       return obj_ref;
       }
#endif

     if(SvNOK(b)) {
#ifdef USE_LONG_DOUBLE
#ifndef _MSC_VER
       mpfr_set_ld(*mpfr_t_obj, SvNV(b), __gmpfr_default_rounding_mode);
#else
       mpfr_set_d(*mpfr_t_obj, SvNV(b), __gmpfr_default_rounding_mode);
#endif
#else
       mpfr_set_d(*mpfr_t_obj, SvNV(b), __gmpfr_default_rounding_mode);
#endif
       if(third == &PL_sv_yes) mpfr_sub(*mpfr_t_obj, *mpfr_t_obj, *a, __gmpfr_default_rounding_mode);
       else mpfr_sub(*mpfr_t_obj, *a, *mpfr_t_obj, __gmpfr_default_rounding_mode);
       return obj_ref;
       }

     if(SvPOK(b)) {
       if(mpfr_set_str(*mpfr_t_obj, SvPV_nolen(b), 0, __gmpfr_default_rounding_mode))
         croak("Invalid string supplied to Math::MPFR::overload_sub");
       if(third == &PL_sv_yes) mpfr_sub(*mpfr_t_obj, *mpfr_t_obj, *a, __gmpfr_default_rounding_mode);
       else mpfr_sub(*mpfr_t_obj, *a, *mpfr_t_obj, __gmpfr_default_rounding_mode);
       return obj_ref;
       }

     if(sv_isobject(b)) {
       if(strEQ(HvNAME(SvSTASH(SvRV(b))), "Math::MPFR")) {
         mpfr_sub(*mpfr_t_obj, *a, *(INT2PTR(mpfr_t *, SvIV(SvRV(b)))), __gmpfr_default_rounding_mode);
         return obj_ref;
         }
       }

     croak("Invalid argument supplied to Math::MPFR::overload_sub function");
}

SV * overload_div(mpfr_t * a, SV * b, SV * third) {
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;

     New(1, mpfr_t_obj, 1, mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in overload_div function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, "Math::MPFR");
     mpfr_init(*mpfr_t_obj);
     sv_setiv(obj, INT2PTR(IV,mpfr_t_obj));
     SvREADONLY_on(obj);

#ifdef USE_64_BIT_INT
#ifndef _MSC_VER
     if(SvUOK(b)) {
       mpfr_set_uj(*mpfr_t_obj, SvUV(b), __gmpfr_default_rounding_mode);
       if(third == &PL_sv_yes) mpfr_div(*mpfr_t_obj, *mpfr_t_obj, *a, __gmpfr_default_rounding_mode);
       else mpfr_div(*mpfr_t_obj, *a, *mpfr_t_obj, __gmpfr_default_rounding_mode);
       return obj_ref;
       }

     if(SvIOK(b)) {
       mpfr_set_sj(*mpfr_t_obj, SvIV(b), __gmpfr_default_rounding_mode);
       if(third == &PL_sv_yes) mpfr_div(*mpfr_t_obj, *mpfr_t_obj, *a, __gmpfr_default_rounding_mode);
       else mpfr_div(*mpfr_t_obj, *a, *mpfr_t_obj, __gmpfr_default_rounding_mode);
       return obj_ref;
       }
#else
     if(SvIOK(b)) {
       if(mpfr_set_str(*mpfr_t_obj, SvPV_nolen(b), 10, __gmpfr_default_rounding_mode))
         croak("Invalid string supplied to Math::MPFR::overload_div");
       if(third == &PL_sv_yes) mpfr_div(*mpfr_t_obj, *mpfr_t_obj, *a, __gmpfr_default_rounding_mode);
       else mpfr_div(*mpfr_t_obj, *a, *mpfr_t_obj, __gmpfr_default_rounding_mode);
       return obj_ref;
       }
#endif
#else
     if(SvUOK(b)) {
       if(third == &PL_sv_yes) mpfr_ui_div(*mpfr_t_obj, SvUV(b), *a, __gmpfr_default_rounding_mode);
       else mpfr_div_ui(*mpfr_t_obj, *a, SvUV(b), __gmpfr_default_rounding_mode);
       return obj_ref;
       }

     if(SvIOK(b)) {
       if(SvIV(b) >= 0) {
         if(third == &PL_sv_yes) mpfr_ui_div(*mpfr_t_obj, SvUV(b), *a, __gmpfr_default_rounding_mode);
         else mpfr_div_ui(*mpfr_t_obj, *a, SvUV(b), __gmpfr_default_rounding_mode);
         return obj_ref;
         }
       if(third == &PL_sv_yes) mpfr_ui_div(*mpfr_t_obj, SvIV(b) * -1, *a, __gmpfr_default_rounding_mode);
       else mpfr_div_ui(*mpfr_t_obj, *a, SvIV(b) * -1, __gmpfr_default_rounding_mode);
       mpfr_neg(*mpfr_t_obj, *mpfr_t_obj, __gmpfr_default_rounding_mode);
       return obj_ref;
       }
#endif

     if(SvNOK(b)) {
#ifdef USE_LONG_DOUBLE
#ifndef _MSC_VER
       mpfr_set_ld(*mpfr_t_obj, SvNV(b), __gmpfr_default_rounding_mode);
#else
       mpfr_set_d(*mpfr_t_obj, SvNV(b), __gmpfr_default_rounding_mode);
#endif
#else
       mpfr_set_d(*mpfr_t_obj, SvNV(b), __gmpfr_default_rounding_mode);
#endif
       if(third == &PL_sv_yes) mpfr_div(*mpfr_t_obj, *mpfr_t_obj, *a, __gmpfr_default_rounding_mode);
       else mpfr_div(*mpfr_t_obj, *a, *mpfr_t_obj, __gmpfr_default_rounding_mode);
       return obj_ref;
       }

     if(SvPOK(b)) {
       if(mpfr_set_str(*mpfr_t_obj, SvPV_nolen(b), 0, __gmpfr_default_rounding_mode))
         croak("Invalid string supplied to Math::MPFR::overload_div");
       if(third == &PL_sv_yes) mpfr_div(*mpfr_t_obj, *mpfr_t_obj, *a, __gmpfr_default_rounding_mode);
       else mpfr_div(*mpfr_t_obj, *a, *mpfr_t_obj, __gmpfr_default_rounding_mode);
       return obj_ref;
       }

     if(sv_isobject(b)) {
       if(strEQ(HvNAME(SvSTASH(SvRV(b))), "Math::MPFR")) {
         mpfr_div(*mpfr_t_obj, *a, *(INT2PTR(mpfr_t *, SvIV(SvRV(b)))), __gmpfr_default_rounding_mode);
         return obj_ref;
         }
       }

     croak("Invalid argument supplied to Math::MPFR::overload_div function");
}

SV * overload_copy(mpfr_t * p, SV * second, SV * third) {
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;

     New(1, mpfr_t_obj, 1, mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in overload_copy function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, "Math::MPFR");

     mpfr_init2(*mpfr_t_obj, mpfr_get_prec(*p));
     mpfr_set(*mpfr_t_obj, *p, __gmpfr_default_rounding_mode);
     sv_setiv(obj, INT2PTR(IV,mpfr_t_obj));
     SvREADONLY_on(obj);
     return obj_ref;
}

SV * overload_abs(mpfr_t * p, SV * second, SV * third) {
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;

     New(1, mpfr_t_obj, 1, mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in overload_abs function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, "Math::MPFR");
     mpfr_init(*mpfr_t_obj);

     mpfr_abs(*mpfr_t_obj, *p, __gmpfr_default_rounding_mode);
     sv_setiv(obj, INT2PTR(IV,mpfr_t_obj));
     SvREADONLY_on(obj);
     return obj_ref;
}

SV * overload_gt(mpfr_t * a, SV * b, SV * third) {
     mpfr_t t;
     int ret;

     if(mpfr_nan_p(*a)){
       mpfr_set_erangeflag();
       return newSVuv(0);
     }

#ifdef USE_64_BIT_INT
#ifndef _MSC_VER
     if(SvUOK(b)) {
       mpfr_init(t);
       mpfr_set_uj(t, SvUV(b), __gmpfr_default_rounding_mode);
       ret = mpfr_cmp(*a, t);
       mpfr_clear(t);
       if(third == &PL_sv_yes) ret *= -1;
       if(ret > 0) return newSViv(1);
       return newSViv(0);
       }

     if(SvIOK(b)) {
       mpfr_init(t);
       mpfr_set_sj(t, SvIV(b), __gmpfr_default_rounding_mode);
       ret = mpfr_cmp(*a, t);
       mpfr_clear(t);
       if(third == &PL_sv_yes) ret *= -1;
       if(ret > 0) return newSViv(1);
       return newSViv(0);
       }
#else
     if(SvIOK(b)) {
       if(mpfr_init_set_str(t, SvPV_nolen(b), 10, __gmpfr_default_rounding_mode))
         croak("Invalid string supplied to Math::MPFR::overload_gt");
       ret = mpfr_cmp(*a, t);
       mpfr_clear(t);
       if(third == &PL_sv_yes) ret *= -1;
       if(ret > 0) return newSViv(1);
       return newSViv(0);
       }
#endif
#else
     if(SvUOK(b)) {
       ret = mpfr_cmp_ui(*a, SvUV(b));
       if(third == &PL_sv_yes) ret *= -1;
       if(ret > 0) return newSViv(1);
       return newSViv(0);
       }

     if(SvIOK(b)) {
       ret = mpfr_cmp_si(*a, SvIV(b));
       if(third == &PL_sv_yes) ret *= -1;
       if(ret > 0) return newSViv(1);
       return newSViv(0);
       }
#endif

     if(SvNOK(b)) {

       if(SvNV(b) != SvNV(b)) { /* it's a NaN */
         mpfr_set_erangeflag();
         return newSVuv(0);
       }
         
#ifdef USE_LONG_DOUBLE
#ifndef _MSC_VER
       ret = mpfr_cmp_ld(*a, SvNV(b));
#else
       ret = mpfr_cmp_d(*a, SvNV(b));
#endif
#else
       ret = mpfr_cmp_d(*a, SvNV(b));
#endif
       if(third == &PL_sv_yes) ret *= -1;
       if(ret > 0) return newSViv(1);
       return newSViv(0);
       }

     if(SvPOK(b)) {
       if(mpfr_init_set_str(t, SvPV_nolen(b), 0, __gmpfr_default_rounding_mode))
         croak("Invalid string supplied to Math::MPFR::overload_gt");
       ret = mpfr_cmp(*a, t);
       mpfr_clear(t);
       if(third == &PL_sv_yes) ret *= -1;
       if(ret > 0) return newSViv(1);
       return newSViv(0);
       }

     if(sv_isobject(b)) {
       if(strEQ(HvNAME(SvSTASH(SvRV(b))), "Math::MPFR")) {
         return newSVuv(mpfr_greater_p(*a, *(INT2PTR(mpfr_t *, SvIV(SvRV(b))))));
         }
       }

     croak("Invalid argument supplied to Math::MPFR::overload_gt");
}

SV * overload_gte(mpfr_t * a, SV * b, SV * third) {
     mpfr_t t;
     int ret;

     if(mpfr_nan_p(*a)){
       mpfr_set_erangeflag();
       return newSVuv(0);
     }

#ifdef USE_64_BIT_INT
#ifndef _MSC_VER
     if(SvUOK(b)) {
       mpfr_init(t);
       mpfr_set_uj(t, SvUV(b), __gmpfr_default_rounding_mode);
       ret = mpfr_cmp(*a, t);
       mpfr_clear(t);
       if(third == &PL_sv_yes) ret *= -1;
       if(ret >= 0) return newSViv(1);
       return newSViv(0);
       }

     if(SvIOK(b)) {
       mpfr_init(t);
       mpfr_set_sj(t, SvIV(b), __gmpfr_default_rounding_mode);
       ret = mpfr_cmp(*a, t);
       mpfr_clear(t);
       if(third == &PL_sv_yes) ret *= -1;
       if(ret >= 0) return newSViv(1);
       return newSViv(0);
       }
#else
     if(SvIOK(b)) {
       if(mpfr_init_set_str(t, SvPV_nolen(b), 10, __gmpfr_default_rounding_mode))
         croak("Invalid string supplied to Math::MPFR::overload_gte");
       ret = mpfr_cmp(*a, t);
       mpfr_clear(t);
       if(third == &PL_sv_yes) ret *= -1;
       if(ret >= 0) return newSViv(1);
       return newSViv(0);
       }
#endif
#else
     if(SvUOK(b)) {
       ret = mpfr_cmp_ui(*a, SvUV(b));
       if(third == &PL_sv_yes) ret *= -1;
       if(ret >= 0) return newSViv(1);
       return newSViv(0);
       }

     if(SvIOK(b)) {
       ret = mpfr_cmp_si(*a, SvIV(b));
       if(third == &PL_sv_yes) ret *= -1;
       if(ret >= 0) return newSViv(1);
       return newSViv(0);
       }
#endif

     if(SvNOK(b)) {

       if(SvNV(b) != SvNV(b)) { /* it's a NaN */
         mpfr_set_erangeflag();
         return newSVuv(0);
       }

#ifdef USE_LONG_DOUBLE
#ifndef _MSC_VER
       ret = mpfr_cmp_ld(*a, SvNV(b));
#else
       ret = mpfr_cmp_d(*a, SvNV(b));
#endif
#else
       ret = mpfr_cmp_d(*a, SvNV(b));
#endif
       if(third == &PL_sv_yes) ret *= -1;
       if(ret >= 0) return newSViv(1);
       return newSViv(0);
       }

     if(SvPOK(b)) {
       if(mpfr_init_set_str(t, SvPV_nolen(b), 0, __gmpfr_default_rounding_mode))
         croak("Invalid string supplied to Math::MPFR::overload_gte");
       ret = mpfr_cmp(*a, t);
       mpfr_clear(t);
       if(third == &PL_sv_yes) ret *= -1;
       if(ret >= 0) return newSViv(1);
       return newSViv(0);
       }

     if(sv_isobject(b)) {
       if(strEQ(HvNAME(SvSTASH(SvRV(b))), "Math::MPFR")) {
         return newSVuv(mpfr_greaterequal_p(*a, *(INT2PTR(mpfr_t *, SvIV(SvRV(b))))));
         }
       }

     croak("Invalid argument supplied to Math::MPFR::overload_gte");
}

SV * overload_lt(mpfr_t * a, SV * b, SV * third) {
     mpfr_t t;
     int ret;

     if(mpfr_nan_p(*a)){
       mpfr_set_erangeflag();
       return newSVuv(0);
     }

#ifdef USE_64_BIT_INT
#ifndef _MSC_VER
     if(SvUOK(b)) {
       mpfr_init(t);
       mpfr_set_uj(t, SvUV(b), __gmpfr_default_rounding_mode);
       ret = mpfr_cmp(*a, t);
       mpfr_clear(t);
       if(third == &PL_sv_yes) ret *= -1;
       if(ret < 0) return newSViv(1);
       return newSViv(0);
       }

     if(SvIOK(b)) {
       mpfr_init(t);
       mpfr_set_sj(t, SvIV(b), __gmpfr_default_rounding_mode);
       ret = mpfr_cmp(*a, t);
       mpfr_clear(t);
       if(third == &PL_sv_yes) ret *= -1;
       if(ret < 0) return newSViv(1);
       return newSViv(0);
       }
#else
     if(SvIOK(b)) {
       if(mpfr_init_set_str(t, SvPV_nolen(b), 10, __gmpfr_default_rounding_mode))
         croak("Invalid string supplied to Math::MPFR::overload_lt");
       ret = mpfr_cmp(*a, t);
       mpfr_clear(t);
       if(third == &PL_sv_yes) ret *= -1;
       if(ret < 0) return newSViv(1);
       return newSViv(0);
       }
#endif
#else
     if(SvUOK(b)) {
       ret = mpfr_cmp_ui(*a, SvUV(b));
       if(third == &PL_sv_yes) ret *= -1;
       if(ret < 0) return newSViv(1);
       return newSViv(0);
       }

     if(SvIOK(b)) {
       ret = mpfr_cmp_si(*a, SvIV(b));
       if(third == &PL_sv_yes) ret *= -1;
       if(ret < 0) return newSViv(1);
       return newSViv(0);
       }
#endif

     if(SvNOK(b)) {

       if(SvNV(b) != SvNV(b)) { /* it's a NaN */
         mpfr_set_erangeflag();
         return newSVuv(0);
       }

#ifdef USE_LONG_DOUBLE
#ifndef _MSC_VER
       ret = mpfr_cmp_ld(*a, SvNV(b));
#else
       ret = mpfr_cmp_d(*a, SvNV(b));
#endif
#else
       ret = mpfr_cmp_d(*a, SvNV(b));
#endif
       if(third == &PL_sv_yes) ret *= -1;
       if(ret < 0) return newSViv(1);
       return newSViv(0);
       }

     if(SvPOK(b)) {
       if(mpfr_init_set_str(t, SvPV_nolen(b), 0, __gmpfr_default_rounding_mode))
         croak("Invalid string supplied to Math::MPFR::overload_lt");
       ret = mpfr_cmp(*a, t);
       mpfr_clear(t);
       if(third == &PL_sv_yes) ret *= -1;
       if(ret < 0) return newSViv(1);
       return newSViv(0);
       }

     if(sv_isobject(b)) {
       if(strEQ(HvNAME(SvSTASH(SvRV(b))), "Math::MPFR")) {
         return newSVuv(mpfr_less_p(*a, *(INT2PTR(mpfr_t *, SvIV(SvRV(b))))));
         }
       }

     croak("Invalid argument supplied to Math::MPFR::overload_lt");
}

SV * overload_lte(mpfr_t * a, SV * b, SV * third) {
     mpfr_t t;
     int ret;

     if(mpfr_nan_p(*a)){
       mpfr_set_erangeflag();
       return newSVuv(0);
     }

#ifdef USE_64_BIT_INT
#ifndef _MSC_VER
     if(SvUOK(b)) {
       mpfr_init(t);
       mpfr_set_uj(t, SvUV(b), __gmpfr_default_rounding_mode);
       ret = mpfr_cmp(*a, t);
       mpfr_clear(t);
       if(third == &PL_sv_yes) ret *= -1;
       if(ret <= 0) return newSViv(1);
       return newSViv(0);
       }

     if(SvIOK(b)) {
       mpfr_init(t);
       mpfr_set_sj(t, SvIV(b), __gmpfr_default_rounding_mode);
       ret = mpfr_cmp(*a, t);
       mpfr_clear(t);
       if(third == &PL_sv_yes) ret *= -1;
       if(ret <= 0) return newSViv(1);
       return newSViv(0);
       }
#else
     if(SvIOK(b)) {
       if(mpfr_init_set_str(t, SvPV_nolen(b), 10, __gmpfr_default_rounding_mode))
         croak("Invalid string supplied to Math::MPFR::overload_lte");
       ret = mpfr_cmp(*a, t);
       mpfr_clear(t);
       if(third == &PL_sv_yes) ret *= -1;
       if(ret <= 0) return newSViv(1);
       return newSViv(0);
       }
#endif
#else
     if(SvUOK(b)) {
       ret = mpfr_cmp_ui(*a, SvUV(b));
       if(third == &PL_sv_yes) ret *= -1;
       if(ret <= 0) return newSViv(1);
       return newSViv(0);
       }

     if(SvIOK(b)) {
       ret = mpfr_cmp_si(*a, SvIV(b));
       if(third == &PL_sv_yes) ret *= -1;
       if(ret <= 0) return newSViv(1);
       return newSViv(0);
       }
#endif

     if(SvNOK(b)) {

       if(SvNV(b) != SvNV(b)) { /* it's a NaN */
         mpfr_set_erangeflag();
         return newSVuv(0);
       }

#ifdef USE_LONG_DOUBLE
#ifndef _MSC_VER
       ret = mpfr_cmp_ld(*a, SvNV(b));
#else
       ret = mpfr_cmp_d(*a, SvNV(b));
#endif
#else
       ret = mpfr_cmp_d(*a, SvNV(b));
#endif
       if(third == &PL_sv_yes) ret *= -1;
       if(ret <= 0) return newSViv(1);
       return newSViv(0);
       }

     if(SvPOK(b)) {
       if(mpfr_init_set_str(t, SvPV_nolen(b), 0, __gmpfr_default_rounding_mode))
         croak("Invalid string supplied to Math::MPFR::overload_lte");
       ret = mpfr_cmp(*a, t);
       mpfr_clear(t);
       if(third == &PL_sv_yes) ret *= -1;
       if(ret <= 0) return newSViv(1);
       return newSViv(0);
       }

     if(sv_isobject(b)) {
       if(strEQ(HvNAME(SvSTASH(SvRV(b))), "Math::MPFR")) {
         return newSVuv(mpfr_lessequal_p(*a, *(INT2PTR(mpfr_t *, SvIV(SvRV(b))))));
         return newSViv(0);
         }
       }

     croak("Invalid argument supplied to Math::MPFR::overload_lte");
}

SV * overload_spaceship(mpfr_t * a, SV * b, SV * third) {
     mpfr_t t;
     int ret;

     if(mpfr_nan_p(*a)) {
       mpfr_set_erangeflag();
       return &PL_sv_undef;
     }

#ifdef USE_64_BIT_INT
#ifndef _MSC_VER
     if(SvUOK(b)) {
       mpfr_init(t);
       mpfr_set_uj(t, SvUV(b), __gmpfr_default_rounding_mode);
       ret = mpfr_cmp(*a, t);
       mpfr_clear(t);
       if(third == &PL_sv_yes) ret *= -1;
       if(ret < 0) return newSViv(-1);
       if(ret > 0) return newSViv(1);
       return newSViv(0);
       }

     if(SvIOK(b)) {
       mpfr_init(t);
       mpfr_set_sj(t, SvIV(b), __gmpfr_default_rounding_mode);
       ret = mpfr_cmp(*a, t);
       mpfr_clear(t);
       if(third == &PL_sv_yes) ret *= -1;
       if(ret < 0) return newSViv(-1);
       if(ret > 0) return newSViv(1);
       return newSViv(0);
       }
#else
     if(SvIOK(b)) {
       if(mpfr_init_set_str(t, SvPV_nolen(b), 10, __gmpfr_default_rounding_mode))
         croak("Invalid string supplied to Math::MPFR::overload_spaceship");
       ret = mpfr_cmp(*a, t);
       mpfr_clear(t);
       if(third == &PL_sv_yes) ret *= -1;
       if(ret < 0) return newSViv(-1);
       if(ret > 0) return newSViv(1);
       return newSViv(0);
       }
#endif
#else
     if(SvUOK(b)) {
       ret = mpfr_cmp_ui(*a, SvUV(b));
       if(third == &PL_sv_yes) ret *= -1;
       if(ret < 0) return newSViv(-1);
       if(ret > 0) return newSViv(1);
       return newSViv(0);
       }

     if(SvIOK(b)) {
       ret = mpfr_cmp_si(*a, SvIV(b));
       if(third == &PL_sv_yes) ret *= -1;
       if(ret < 0) return newSViv(-1);
       if(ret > 0) return newSViv(1);
       return newSViv(0);
       }
#endif

     if(SvNOK(b)) {

       if(SvNV(b) != SvNV(b)) { /* it's a NaN */
       mpfr_set_erangeflag();
       return &PL_sv_undef;
     }

#ifdef USE_LONG_DOUBLE
#ifndef _MSC_VER
       ret = mpfr_cmp_ld(*a, SvNV(b));
#else
       ret = mpfr_cmp_d(*a, SvNV(b));
#endif
#else
       ret = mpfr_cmp_d(*a, SvNV(b));
#endif
       if(third == &PL_sv_yes) ret *= -1;
       if(ret < 0) return newSViv(-1);
       if(ret > 0) return newSViv(1);
       return newSViv(0);
       }

     if(SvPOK(b)) {
       if(mpfr_init_set_str(t, SvPV_nolen(b), 0, __gmpfr_default_rounding_mode))
         croak("Invalid string supplied to Math::MPFR::overload_spaceship");
       ret = mpfr_cmp(*a, t);
       mpfr_clear(t);
       if(third == &PL_sv_yes) ret *= -1;
       if(ret < 0) return newSViv(-1);
       if(ret > 0) return newSViv(1);
       return newSViv(0);
       }

     if(sv_isobject(b)) {
       if(strEQ(HvNAME(SvSTASH(SvRV(b))), "Math::MPFR")) {
         return newSViv(mpfr_cmp(*a, *(INT2PTR(mpfr_t *, SvIV(SvRV(b))))));
         }
       }

     croak("Invalid argument supplied to Math::MPFR::overload_spaceship");
}

SV * overload_equiv(mpfr_t * a, SV * b, SV * third) {
     mpfr_t t;
     int ret;

     if(mpfr_nan_p(*a)){
       mpfr_set_erangeflag();
       return newSVuv(0);
     }

#ifdef USE_64_BIT_INT
#ifndef _MSC_VER
     if(SvUOK(b)) {
       mpfr_init(t);
       mpfr_set_uj(t, SvUV(b), __gmpfr_default_rounding_mode);
       ret = mpfr_cmp(*a, t);
       mpfr_clear(t);
       if(ret == 0) return newSViv(1);
       return newSViv(0);
       }

     if(SvIOK(b)) {
       mpfr_init(t);
       mpfr_set_sj(t, SvIV(b), __gmpfr_default_rounding_mode);
       ret = mpfr_cmp(*a, t);
       mpfr_clear(t);
       if(ret == 0) return newSViv(1);
       return newSViv(0);
       }
#else
     if(SvIOK(b)) {
       if(mpfr_init_set_str(t, (char *)SvPV_nolen(b), 10, __gmpfr_default_rounding_mode))
         croak("Invalid string supplied to Math::MPFR::overload_equiv");
       ret = mpfr_cmp(*a, t);
       mpfr_clear(t);
       if(ret == 0) return newSViv(1);
       return newSViv(0);
       }
#endif
#else
     if(SvUOK(b)) {
       ret = mpfr_cmp_ui(*a, SvUV(b));
       if(ret == 0) return newSViv(1);
       return newSViv(0);
       }

     if(SvIOK(b)) {
       ret = mpfr_cmp_si(*a, SvIV(b));
       if(ret == 0) return newSViv(1);
       return newSViv(0);
       }
#endif

     if(SvNOK(b)) {

       if(SvNV(b) != SvNV(b)) { /* it's a NaN */
         mpfr_set_erangeflag();
         return newSVuv(0);
       }

#ifdef USE_LONG_DOUBLE
#ifndef _MSC_VER
       ret = mpfr_cmp_ld(*a, SvNV(b));
#else
       ret = mpfr_cmp_d(*a, SvNV(b));
#endif
#else
       ret = mpfr_cmp_d(*a, SvNV(b));
#endif
       if(ret == 0) return newSViv(1);
       return newSViv(0);
       }

     if(SvPOK(b)) {
       if(mpfr_init_set_str(t, (char *)SvPV_nolen(b), 0, __gmpfr_default_rounding_mode))
         croak("Invalid string supplied to Math::MPFR::overload_equiv");
       ret = mpfr_cmp(*a, t);
       mpfr_clear(t);
       if(ret == 0) return newSViv(1);
       return newSViv(0);
       }

     if(sv_isobject(b)) {
       if(strEQ(HvNAME(SvSTASH(SvRV(b))), "Math::MPFR")) {
         return newSVuv(mpfr_equal_p(*a, *(INT2PTR(mpfr_t *, SvIV(SvRV(b))))));
         }
       }

     croak("Invalid argument supplied to Math::MPFR::overload_equiv");
}

SV * overload_not_equiv(mpfr_t * a, SV * b, SV * third) {
     mpfr_t t;
     int ret;

     if(mpfr_nan_p(*a)){
       mpfr_set_erangeflag();
       return newSVuv(1);
     }

#ifdef USE_64_BIT_INT
#ifndef _MSC_VER
     if(SvUOK(b)) {
       mpfr_init(t);
       mpfr_set_uj(t, SvUV(b), __gmpfr_default_rounding_mode);
       ret = mpfr_cmp(*a, t);
       mpfr_clear(t);
       if(ret != 0) return newSViv(1);
       return newSViv(0);
       }

     if(SvIOK(b)) {
       mpfr_init(t);
       mpfr_set_sj(t, SvIV(b), __gmpfr_default_rounding_mode);
       ret = mpfr_cmp(*a, t);
       mpfr_clear(t);
       if(ret != 0) return newSViv(1);
       return newSViv(0);
       }
#else
     if(SvIOK(b)) {
       if(mpfr_init_set_str(t, (char *)SvPV_nolen(b), 10, __gmpfr_default_rounding_mode))
         croak("Invalid string supplied to Math::MPFR::overload_not_equiv");
       ret = mpfr_cmp(*a, t);
       mpfr_clear(t);
       if(ret != 0) return newSViv(1);
       return newSViv(0);
       }
#endif
#else
     if(SvUOK(b)) {
       ret = mpfr_cmp_ui(*a, SvUV(b));
       if(ret != 0) return newSViv(1);
       return newSViv(0);
       }

     if(SvIOK(b)) {
       ret = mpfr_cmp_si(*a, SvIV(b));
       if(ret != 0) return newSViv(1);
       return newSViv(0);
       }
#endif

     if(SvNOK(b)) {

       if(SvNV(b) != SvNV(b)) { /* it's a NaN */
         mpfr_set_erangeflag();
         return newSVuv(1);
       }

#ifdef USE_LONG_DOUBLE
#ifndef _MSC_VER
       ret = mpfr_cmp_ld(*a, SvNV(b));
#else
       ret = mpfr_cmp_d(*a, SvNV(b));
#endif
#else
       ret = mpfr_cmp_d(*a, SvNV(b));
#endif
       if(ret != 0) return newSViv(1);
       return newSViv(0);
       }

     if(SvPOK(b)) {
       if(mpfr_init_set_str(t, (char *)SvPV_nolen(b), 0, __gmpfr_default_rounding_mode))
         croak("Invalid string supplied to Math::MPFR::overload_not_equiv");
       ret = mpfr_cmp(*a, t);
       mpfr_clear(t);
       if(ret != 0) return newSViv(1);
       return newSViv(0);
       }

     if(sv_isobject(b)) {
       if(strEQ(HvNAME(SvSTASH(SvRV(b))), "Math::MPFR")) {
         if(mpfr_equal_p(*a, *(INT2PTR(mpfr_t *, SvIV(SvRV(b)))))) return newSViv(0);
         return newSViv(1);
         }
       }

     croak("Invalid argument supplied to Math::MPFR::overload_not_equiv");
}

SV * overload_true(mpfr_t *a, SV *second, SV * third) {
     if(mpfr_nan_p(*a)) return newSVuv(0);
     if(mpfr_cmp_ui(*a, 0)) return newSVuv(1);
     return newSVuv(0);
}

SV * overload_not(mpfr_t * a, SV * second, SV * third) {
     if(mpfr_nan_p(*a)) return newSViv(1);
     if(mpfr_cmp_ui(*a, 0)) return newSViv(0);
     return newSViv(1);
}

SV * overload_sqrt(mpfr_t * p, SV * second, SV * third) {
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;

     New(1, mpfr_t_obj, 1, mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in overload_sqrt function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, "Math::MPFR");
     mpfr_init(*mpfr_t_obj);

     /* No - this was wrong. If a negative value is supplied, a NaN should be returned instad */
     /* if(mpfr_cmp_ui(*p, 0) < 0) croak("Negative value supplied as argument to overload_sqrt"); */

     mpfr_sqrt(*mpfr_t_obj, *p, __gmpfr_default_rounding_mode);
     sv_setiv(obj, INT2PTR(IV,mpfr_t_obj));
     SvREADONLY_on(obj);
     return obj_ref;
}

SV * overload_pow(mpfr_t * p, SV * second, SV * third) {
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;

     New(1, mpfr_t_obj, 1, mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in overload_pow function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, "Math::MPFR");
     mpfr_init(*mpfr_t_obj);
     sv_setiv(obj, INT2PTR(IV,mpfr_t_obj));
     SvREADONLY_on(obj);

#ifdef USE_64_BIT_INT
#ifndef _MSC_VER
     if(SvUOK(second)) {
       mpfr_set_uj(*mpfr_t_obj, SvUV(second), __gmpfr_default_rounding_mode);
       if(third == &PL_sv_yes) mpfr_pow(*mpfr_t_obj, *mpfr_t_obj, *p, __gmpfr_default_rounding_mode);
       else mpfr_pow(*mpfr_t_obj, *p, *mpfr_t_obj, __gmpfr_default_rounding_mode); 
       return obj_ref;
       }

     if(SvIOK(second)) {
       mpfr_set_sj(*mpfr_t_obj, SvIV(second), __gmpfr_default_rounding_mode);
       if(third == &PL_sv_yes) mpfr_pow(*mpfr_t_obj, *mpfr_t_obj, *p, __gmpfr_default_rounding_mode);
       else mpfr_pow(*mpfr_t_obj, *p, *mpfr_t_obj, __gmpfr_default_rounding_mode); 
       return obj_ref;
       }
#else
     if(SvIOK(second)) {
       if(mpfr_set_str(*mpfr_t_obj, SvPV_nolen(second), 10, __gmpfr_default_rounding_mode))
         croak("Invalid string supplied to Math::MPFR::overload_pow");
       if(third == &PL_sv_yes) mpfr_pow(*mpfr_t_obj, *mpfr_t_obj, *p, __gmpfr_default_rounding_mode);
       else mpfr_pow(*mpfr_t_obj, *p, *mpfr_t_obj, __gmpfr_default_rounding_mode); 
       return obj_ref;
       }
#endif
#else
     if(SvUOK(second)) {
       if(third == &PL_sv_yes) mpfr_ui_pow(*mpfr_t_obj, SvUV(second), *p, __gmpfr_default_rounding_mode);
       else mpfr_pow_ui(*mpfr_t_obj, *p, SvUV(second), __gmpfr_default_rounding_mode);
       return obj_ref;
       }

     if(SvIOK(second)) {
       if(SvIV(second) >= 0) {
         if(third == &PL_sv_yes) mpfr_ui_pow(*mpfr_t_obj, SvUV(second), *p, __gmpfr_default_rounding_mode);
         else mpfr_pow_ui(*mpfr_t_obj, *p, SvUV(second), __gmpfr_default_rounding_mode);
         return obj_ref;
         }
       if(third != &PL_sv_yes) {
         mpfr_pow_si(*mpfr_t_obj, *p, SvIV(second), __gmpfr_default_rounding_mode);
         return obj_ref;
         }
       }
#endif

     if(SvNOK(second)) {
#ifdef USE_LONG_DOUBLE
#ifndef _MSC_VER
       mpfr_set_ld(*mpfr_t_obj, SvNV(second), __gmpfr_default_rounding_mode);
#else
       mpfr_set_d(*mpfr_t_obj, SvNV(second), __gmpfr_default_rounding_mode);
#endif
#else
       mpfr_set_d(*mpfr_t_obj, SvNV(second), __gmpfr_default_rounding_mode);
#endif
       if(third == &PL_sv_yes) mpfr_pow(*mpfr_t_obj, *mpfr_t_obj, *p, __gmpfr_default_rounding_mode);
       else mpfr_pow(*mpfr_t_obj, *p, *mpfr_t_obj, __gmpfr_default_rounding_mode); 
       return obj_ref;
       }

     if(SvPOK(second)) {
       if(mpfr_set_str(*mpfr_t_obj, SvPV_nolen(second), 0, __gmpfr_default_rounding_mode))
         croak("Invalid string supplied to Math::MPFR::overload_pow");
       if(third == &PL_sv_yes) mpfr_pow(*mpfr_t_obj, *mpfr_t_obj, *p, __gmpfr_default_rounding_mode);
       else mpfr_pow(*mpfr_t_obj, *p, *mpfr_t_obj, __gmpfr_default_rounding_mode); 
       return obj_ref;
       }

     if(sv_isobject(second)) {
       if(strEQ(HvNAME(SvSTASH(SvRV(second))), "Math::MPFR")) {
         mpfr_pow(*mpfr_t_obj, *p, *(INT2PTR(mpfr_t *, SvIV(SvRV(second)))), __gmpfr_default_rounding_mode);
         return obj_ref;
         }
       }

     croak("Invalid argument supplied to Math::MPFR::overload_pow.");
}

SV * overload_log(mpfr_t * p, SV * second, SV * third) {
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;

     New(1, mpfr_t_obj, 1, mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in overload_log function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, "Math::MPFR");
     mpfr_init(*mpfr_t_obj);

     mpfr_log(*mpfr_t_obj, *p, __gmpfr_default_rounding_mode);
     sv_setiv(obj, INT2PTR(IV,mpfr_t_obj));
     SvREADONLY_on(obj);
     return obj_ref;
}

SV * overload_exp(mpfr_t * p, SV * second, SV * third) {
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;

     New(1, mpfr_t_obj, 1, mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in overload_exp function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, "Math::MPFR");
     mpfr_init(*mpfr_t_obj);

     mpfr_exp(*mpfr_t_obj, *p, __gmpfr_default_rounding_mode);
     sv_setiv(obj, INT2PTR(IV,mpfr_t_obj));
     SvREADONLY_on(obj);
     return obj_ref;
}

SV * overload_sin(mpfr_t * p, SV * second, SV * third) {
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;

     New(1, mpfr_t_obj, 1, mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in overload_sin function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, "Math::MPFR");
     mpfr_init(*mpfr_t_obj);

     mpfr_sin(*mpfr_t_obj, *p, __gmpfr_default_rounding_mode);
     sv_setiv(obj, INT2PTR(IV,mpfr_t_obj));
     SvREADONLY_on(obj);
     return obj_ref;
}

SV * overload_cos(mpfr_t * p, SV * second, SV * third) {
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;

     New(1, mpfr_t_obj, 1, mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in overload_cos function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, "Math::MPFR");
     mpfr_init(*mpfr_t_obj);

     mpfr_cos(*mpfr_t_obj, *p, __gmpfr_default_rounding_mode);
     sv_setiv(obj, INT2PTR(IV,mpfr_t_obj));
     SvREADONLY_on(obj);
     return obj_ref;
}

SV * overload_int(mpfr_t * p, SV * second, SV * third) {
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;

     New(1, mpfr_t_obj, 1, mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in overload_int function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, "Math::MPFR");
     mpfr_init(*mpfr_t_obj);

     mpfr_trunc(*mpfr_t_obj, *p);
     sv_setiv(obj, INT2PTR(IV,mpfr_t_obj));
     SvREADONLY_on(obj);
     return obj_ref;
}

SV * overload_atan2(mpfr_t * a, SV * b, SV * third) {
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;

     New(1, mpfr_t_obj, 1, mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in overload_atan2 function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, "Math::MPFR");
     mpfr_init(*mpfr_t_obj);

#ifdef USE_64_BIT_INT
#ifndef _MSC_VER
     if(SvUOK(b)) {
       mpfr_set_uj(*mpfr_t_obj, SvUV(b), __gmpfr_default_rounding_mode);
       if(third == &PL_sv_yes){
         mpfr_atan2(*mpfr_t_obj, *mpfr_t_obj, *a, __gmpfr_default_rounding_mode);
         }
       else {
         mpfr_atan2(*mpfr_t_obj, *a, *mpfr_t_obj, __gmpfr_default_rounding_mode);
         }
       sv_setiv(obj, INT2PTR(IV,mpfr_t_obj));
       SvREADONLY_on(obj);
       return obj_ref;
       }

     if(SvIOK(b)) {
       mpfr_set_sj(*mpfr_t_obj, SvIV(b), __gmpfr_default_rounding_mode);
       if(third == &PL_sv_yes){
         mpfr_atan2(*mpfr_t_obj, *mpfr_t_obj, *a, __gmpfr_default_rounding_mode);
         }
       else {
         mpfr_atan2(*mpfr_t_obj, *a, *mpfr_t_obj, __gmpfr_default_rounding_mode);
         }
       sv_setiv(obj, INT2PTR(IV,mpfr_t_obj));
       SvREADONLY_on(obj);
       return obj_ref;
       }
#else
     if(SvIOK(b)) {
       if(mpfr_set_str(*mpfr_t_obj, SvPV_nolen(b), 10, __gmpfr_default_rounding_mode))
         croak("Invalid string supplied to Math::MPFR::overload_atan2");
       if(third == &PL_sv_yes){
         mpfr_atan2(*mpfr_t_obj, *mpfr_t_obj, *a, __gmpfr_default_rounding_mode);
         }
       else {
         mpfr_atan2(*mpfr_t_obj, *a, *mpfr_t_obj, __gmpfr_default_rounding_mode);
         }
       sv_setiv(obj, INT2PTR(IV,mpfr_t_obj));
       SvREADONLY_on(obj);
       return obj_ref;
       }
#endif
#else
     if(SvUOK(b)) {
       mpfr_set_ui(*mpfr_t_obj, SvUV(b), __gmpfr_default_rounding_mode);
       if(third == &PL_sv_yes){
         mpfr_atan2(*mpfr_t_obj, *mpfr_t_obj, *a, __gmpfr_default_rounding_mode);
         }
       else {
         mpfr_atan2(*mpfr_t_obj, *a, *mpfr_t_obj, __gmpfr_default_rounding_mode);
         }
       sv_setiv(obj, INT2PTR(IV,mpfr_t_obj));
       SvREADONLY_on(obj);
       return obj_ref;
       }

     if(SvIOK(b)) {
       mpfr_set_si(*mpfr_t_obj, SvIV(b), __gmpfr_default_rounding_mode);
       if(third == &PL_sv_yes){
         mpfr_atan2(*mpfr_t_obj, *mpfr_t_obj, *a, __gmpfr_default_rounding_mode);
         }
       else {
         mpfr_atan2(*mpfr_t_obj, *a, *mpfr_t_obj, __gmpfr_default_rounding_mode);
         }
       sv_setiv(obj, INT2PTR(IV,mpfr_t_obj));
       SvREADONLY_on(obj);
       return obj_ref;
       }
#endif

     if(SvNOK(b)) {
#ifdef USE_LONG_DOUBLE
#ifndef _MSC_VER
       mpfr_set_ld(*mpfr_t_obj, SvNV(b), __gmpfr_default_rounding_mode);
#else
       mpfr_set_d(*mpfr_t_obj, SvNV(b), __gmpfr_default_rounding_mode);
#endif
#else
       mpfr_set_d(*mpfr_t_obj, SvNV(b), __gmpfr_default_rounding_mode);
#endif
       if(third == &PL_sv_yes){
         mpfr_atan2(*mpfr_t_obj, *mpfr_t_obj, *a, __gmpfr_default_rounding_mode);
         }
       else {
         mpfr_atan2(*mpfr_t_obj, *a, *mpfr_t_obj, __gmpfr_default_rounding_mode);
         }
       sv_setiv(obj, INT2PTR(IV,mpfr_t_obj));
       SvREADONLY_on(obj);
       return obj_ref;
       }

     if(SvPOK(b)) {
       if(mpfr_set_str(*mpfr_t_obj, SvPV_nolen(b), 0, __gmpfr_default_rounding_mode))
         croak("Invalid string supplied to Math::MPFR::overload_atan2");
       if(third == &PL_sv_yes){
         mpfr_atan2(*mpfr_t_obj, *mpfr_t_obj, *a, __gmpfr_default_rounding_mode);
         }
       else {
         mpfr_atan2(*mpfr_t_obj, *a, *mpfr_t_obj, __gmpfr_default_rounding_mode);
         }
       sv_setiv(obj, INT2PTR(IV,mpfr_t_obj));
       SvREADONLY_on(obj);
       return obj_ref;
       }

     if(sv_isobject(b)) {
       if(strEQ(HvNAME(SvSTASH(SvRV(b))), "Math::MPFR")) {
         mpfr_atan2(*mpfr_t_obj, *a, *(INT2PTR(mpfr_t *, SvIV(SvRV(b)))), __gmpfr_default_rounding_mode);
         sv_setiv(obj, INT2PTR(IV,mpfr_t_obj));
         SvREADONLY_on(obj);
         return obj_ref;
         }
       }

     croak("Invalid argument supplied to Math::MPFR::overload_atan2 function");
}

/* Finish typemapping */

SV * Rgmp_randinit_default() {
     gmp_randstate_t * state;
     SV * obj_ref, * obj;

     New(1, state, 1, gmp_randstate_t);
     if(state == NULL) croak("Failed to allocate memory in Rgmp_randinit_default function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, NULL);
     gmp_randinit_default(*state);

     sv_setiv(obj, INT2PTR(IV,state));
     SvREADONLY_on(obj);
     return obj_ref;
}

SV * Rgmp_randinit_lc_2exp(SV * a, SV * c, SV * m2exp ) {
     gmp_randstate_t * state;
     mpz_t aa;
     SV * obj_ref, * obj;

     New(1, state, 1, gmp_randstate_t);
     if(state == NULL) croak("Failed to allocate memory in Rgmp_randinit_lc_2exp function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, NULL);
     if(sv_isobject(a)) {
       if(strEQ(HvNAME(SvSTASH(SvRV(a))), "Math::GMP") ||
          strEQ(HvNAME(SvSTASH(SvRV(a))), "GMP::Mpz") ||
          strEQ(HvNAME(SvSTASH(SvRV(a))), "Math::GMPz"))
         gmp_randinit_lc_2exp(*state, *(INT2PTR(mpz_t *, SvIV(SvRV(a)))), (unsigned long)SvUV(c), (unsigned long)SvUV(m2exp));
       else croak("First arg to Rgmp_randinit_lc_2exp is of invalid type");
       }

     else {
       if(!mpz_init_set_str(aa, SvPV_nolen(a), 0)) {
         gmp_randinit_lc_2exp(*state, aa, (unsigned long)SvUV(c), (unsigned long)SvUV(m2exp));
         mpz_clear(aa);
         }
       else croak("Seedstring supplied to Rgmp_randinit_lc_2exp is not a valid number");
       }

     sv_setiv(obj, INT2PTR(IV,state));
     SvREADONLY_on(obj);
     return obj_ref;
}

SV * Rgmp_randinit_lc_2exp_size(SV * size) {
     gmp_randstate_t * state;
     SV * obj_ref, * obj;

     if(SvUV(size) > 128) croak("The argument supplied to Rgmp_randinit_lc_2exp_size function (%u) needs to be in the range [1..128]", SvUV(size));

     New(1, state, 1, gmp_randstate_t);
     if(state == NULL) croak("Failed to allocate memory in Rgmp_randinit_lc_2exp_size function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, NULL);

     if(gmp_randinit_lc_2exp_size(*state, (unsigned long)SvUV(size))) {
       sv_setiv(obj, INT2PTR(IV,state));
       SvREADONLY_on(obj);
       return obj_ref;
       }

     croak("Rgmp_randinit_lc_2exp_size function failed");
}

void Rgmp_randclear(SV * p) {
     gmp_randclear(*(INT2PTR(gmp_randstate_t *, SvIV(SvRV(p)))));
     Safefree(INT2PTR(gmp_randstate_t *, SvIV(SvRV(p))));
}

void Rgmp_randseed(SV * state, SV * seed) {
     mpz_t s;

     if(sv_isobject(seed)) {
       if(strEQ(HvNAME(SvSTASH(SvRV(seed))), "Math::GMP") ||
          strEQ(HvNAME(SvSTASH(SvRV(seed))), "GMP::Mpz") ||
          strEQ(HvNAME(SvSTASH(SvRV(seed))), "Math::GMPz"))
         gmp_randseed(*(INT2PTR(gmp_randstate_t *, SvIV(SvRV(state)))), *(INT2PTR(mpz_t *, SvIV(SvRV(seed)))));
       else croak("2nd arg to Rgmp_randseed is of invalid type");
       }

     else {
       if(!mpz_init_set_str(s, SvPV_nolen(seed), 0)) {
         gmp_randseed(*(INT2PTR(gmp_randstate_t *, SvIV(SvRV(state)))), s);
         mpz_clear(s);
         }
       else croak("Seedstring supplied to Rgmp_randseed is not a valid number");
       }
}

void Rgmp_randseed_ui(SV * state, SV * seed) {
     gmp_randseed_ui(*(INT2PTR(gmp_randstate_t *, SvIV(SvRV(state)))), (unsigned long)SvUV(seed));     
}

SV * overload_pow_eq(SV * p, SV * second, SV * third) {
     mpfr_t t;

     SvREFCNT_inc(p);

#ifdef USE_64_BIT_INT
#ifndef _MSC_VER
     if(SvUOK(second)) {
       mpfr_init(t);
       mpfr_set_uj(t, SvUV(second), __gmpfr_default_rounding_mode);
       mpfr_pow(*(INT2PTR(mpfr_t *, SvIV(SvRV(p)))), *(INT2PTR(mpfr_t *, SvIV(SvRV(p)))), t, __gmpfr_default_rounding_mode);
       mpfr_clear(t);
       return p;
       }

     if(SvIOK(second)) {
       mpfr_init(t);
       mpfr_set_sj(t, SvIV(second), __gmpfr_default_rounding_mode);
       mpfr_pow(*(INT2PTR(mpfr_t *, SvIV(SvRV(p)))), *(INT2PTR(mpfr_t *, SvIV(SvRV(p)))), t, __gmpfr_default_rounding_mode);
       mpfr_clear(t);
       return p;
       }
#else
     if(SvIOK(second)) {
       if(mpfr_init_set_str(t, SvPV_nolen(second), 10, __gmpfr_default_rounding_mode)) {
         SvREFCNT_dec(p);
         croak("Invalid string supplied to Math::MPFR::overload_pow_eq");
         }
       mpfr_pow(*(INT2PTR(mpfr_t *, SvIV(SvRV(p)))), *(INT2PTR(mpfr_t *, SvIV(SvRV(p)))), t, __gmpfr_default_rounding_mode);
       mpfr_clear(t);
       return p;
       }
#endif
#else
     if(SvUOK(second)) {
       mpfr_pow_ui(*(INT2PTR(mpfr_t *, SvIV(SvRV(p)))), *(INT2PTR(mpfr_t *, SvIV(SvRV(p)))), SvUV(second), __gmpfr_default_rounding_mode);
       return p;
       }

     if(SvIOK(second)) {
       if(SvIV(second) >= 0) {
         mpfr_pow_ui(*(INT2PTR(mpfr_t *, SvIV(SvRV(p)))), *(INT2PTR(mpfr_t *, SvIV(SvRV(p)))), SvUV(second), __gmpfr_default_rounding_mode);
         return p;
         }
       mpfr_pow_si(*(INT2PTR(mpfr_t *, SvIV(SvRV(p)))), *(INT2PTR(mpfr_t *, SvIV(SvRV(p)))), SvIV(second), __gmpfr_default_rounding_mode);
       return p;
       }
#endif

     if(SvNOK(second)) {
#ifdef USE_LONG_DOUBLE
#ifndef _MSC_VER
       mpfr_init(t);
       mpfr_set_ld(t, SvNV(second), __gmpfr_default_rounding_mode);
#else
       mpfr_init_set_d(t, SvNV(second), __gmpfr_default_rounding_mode);
#endif
#else
       mpfr_init_set_d(t, SvNV(second), __gmpfr_default_rounding_mode);
#endif
       mpfr_pow(*(INT2PTR(mpfr_t *, SvIV(SvRV(p)))), *(INT2PTR(mpfr_t *, SvIV(SvRV(p)))), t, __gmpfr_default_rounding_mode);
       mpfr_clear(t);
       return p;
       }

     if(SvPOK(second)) {
       if(mpfr_init_set_str(t, SvPV_nolen(second), 0, __gmpfr_default_rounding_mode)) {
         SvREFCNT_dec(p);
         croak("Invalid string supplied to Math::MPFR::overload_pow_eq");
         }
       mpfr_pow(*(INT2PTR(mpfr_t *, SvIV(SvRV(p)))), *(INT2PTR(mpfr_t *, SvIV(SvRV(p)))), t, __gmpfr_default_rounding_mode);
       mpfr_clear(t);
       return p;
       }

     if(sv_isobject(second)) {
       if(strEQ(HvNAME(SvSTASH(SvRV(second))), "Math::MPFR")) {
         mpfr_pow(*(INT2PTR(mpfr_t *, SvIV(SvRV(p)))), *(INT2PTR(mpfr_t *, SvIV(SvRV(p)))), *(INT2PTR(mpfr_t *, SvIV(SvRV(second)))), __gmpfr_default_rounding_mode);
         return p;
         }
       }

     SvREFCNT_dec(p);
     croak("Invalid argument supplied to Math::MPFR::overload_pow_eq.");
}

SV * overload_div_eq(SV * a, SV * b, SV * third) {
     mpfr_t t;

     SvREFCNT_inc(a);

#ifdef USE_64_BIT_INT
#ifndef _MSC_VER
     if(SvUOK(b)) {
       mpfr_init(t);
       mpfr_set_uj(t, SvUV(b), __gmpfr_default_rounding_mode);
       mpfr_div(*(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), *(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), t, __gmpfr_default_rounding_mode);
       mpfr_clear(t);
       return a;
       }

     if(SvIOK(b)) {
       mpfr_init(t);
       mpfr_set_sj(t, SvIV(b), __gmpfr_default_rounding_mode);
       mpfr_div(*(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), *(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), t, __gmpfr_default_rounding_mode);
       mpfr_clear(t);
       return a;
       }
#else
     if(SvIOK(b)) {
       if(mpfr_init_set_str(t, SvPV_nolen(b), 10, __gmpfr_default_rounding_mode)) {
         SvREFCNT_dec(a);
         croak("Invalid string supplied to Math::MPFR::overload_div_eq");
         } 
       mpfr_div(*(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), *(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), t, __gmpfr_default_rounding_mode);
       mpfr_clear(t);
       return a;
       }
#endif
#else
     if(SvUOK(b)) {
       mpfr_div_ui(*(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), *(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), SvUV(b), __gmpfr_default_rounding_mode);
       return a;
       }

     if(SvIOK(b)) {
       if(SvIV(b) >= 0) {
         mpfr_div_ui(*(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), *(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), SvUV(b), __gmpfr_default_rounding_mode);
         return a;
         }
       mpfr_div_ui(*(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), *(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), SvIV(b) * -1, __gmpfr_default_rounding_mode);
       mpfr_neg(*(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), *(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), __gmpfr_default_rounding_mode);
       return a;
       }
#endif

     if(SvNOK(b)) {
#ifdef USE_LONG_DOUBLE
#ifndef _MSC_VER
       mpfr_init(t);
       mpfr_set_ld(t, SvNV(b), __gmpfr_default_rounding_mode);
#else
       mpfr_init_set_d(t, SvNV(b), __gmpfr_default_rounding_mode);
#endif
#else
       mpfr_init_set_d(t, SvNV(b), __gmpfr_default_rounding_mode);
#endif
       mpfr_div(*(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), *(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), t, __gmpfr_default_rounding_mode);
       mpfr_clear(t);
       return a;
       }

     if(SvPOK(b)) {
       if(mpfr_init_set_str(t, SvPV_nolen(b), 0, __gmpfr_default_rounding_mode)) {
         SvREFCNT_dec(a);
         croak("Invalid string supplied to Math::MPFR::overload_div_eq");
         } 
       mpfr_div(*(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), *(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), t, __gmpfr_default_rounding_mode);
       mpfr_clear(t);
       return a;
       }

     if(sv_isobject(b)) {
       if(strEQ(HvNAME(SvSTASH(SvRV(b))), "Math::MPFR")) {
         mpfr_div(*(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), *(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), *(INT2PTR(mpfr_t *, SvIV(SvRV(b)))), __gmpfr_default_rounding_mode);
         return a;
         }
       }

     SvREFCNT_dec(a);
     croak("Invalid argument supplied to Math::MPFR::overload_div_eq function");
}

SV * overload_sub_eq(SV * a, SV * b, SV * third) {
     mpfr_t t;

     SvREFCNT_inc(a);

#ifdef USE_64_BIT_INT
#ifndef _MSC_VER
     if(SvUOK(b)) {
       mpfr_init(t);
       mpfr_set_uj(t, SvUV(b), __gmpfr_default_rounding_mode);
       mpfr_sub(*(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), *(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), t, __gmpfr_default_rounding_mode);
       mpfr_clear(t);
       return a;
       }

     if(SvIOK(b)) {
       mpfr_init(t);
       mpfr_set_sj(t, SvIV(b), __gmpfr_default_rounding_mode);
       mpfr_sub(*(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), *(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), t, __gmpfr_default_rounding_mode);
       mpfr_clear(t);
       return a;
       }
#else
     if(SvIOK(b)) {
       if(mpfr_init_set_str(t, SvPV_nolen(b), 10, __gmpfr_default_rounding_mode)) {
         SvREFCNT_dec(a);
         croak("Invalid string supplied to Math::MPFR::overload_sub_eq");
         }
       mpfr_sub(*(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), *(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), t, __gmpfr_default_rounding_mode);
       mpfr_clear(t);
       return a;
       }
#endif
#else
     if(SvUOK(b)) {
       mpfr_sub_ui(*(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), *(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), SvUV(b), __gmpfr_default_rounding_mode);
       return a;
       }

     if(SvIOK(b)) {
       if(SvIV(b) >= 0) {
         mpfr_sub_ui(*(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), *(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), SvUV(b), __gmpfr_default_rounding_mode);
         return a;
         }
       mpfr_add_ui(*(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), *(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), SvIV(b) * -1, __gmpfr_default_rounding_mode);
       return a;
       }
#endif

     if(SvNOK(b)) {
#ifdef USE_LONG_DOUBLE
#ifndef _MSC_VER
       mpfr_init(t);
       mpfr_set_ld(t, SvNV(b), __gmpfr_default_rounding_mode);
#else
       mpfr_init_set_d(t, SvNV(b), __gmpfr_default_rounding_mode);
#endif
#else
       mpfr_init_set_d(t, SvNV(b), __gmpfr_default_rounding_mode);
#endif
       mpfr_sub(*(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), *(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), t, __gmpfr_default_rounding_mode);
       mpfr_clear(t);
       return a;
       }

     if(SvPOK(b)) {
       if(mpfr_init_set_str(t, SvPV_nolen(b), 0, __gmpfr_default_rounding_mode)) {
         SvREFCNT_dec(a);
         croak("Invalid string supplied to Math::MPFR::overload_sub_eq");
         }
       mpfr_sub(*(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), *(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), t, __gmpfr_default_rounding_mode);
       mpfr_clear(t);
       return a;
       }

     if(sv_isobject(b)) {
       if(strEQ(HvNAME(SvSTASH(SvRV(b))), "Math::MPFR")) {
         mpfr_sub(*(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), *(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), *(INT2PTR(mpfr_t *, SvIV(SvRV(b)))), __gmpfr_default_rounding_mode);
         return a;
         }
       }

     SvREFCNT_dec(a);
     croak("Invalid argument supplied to Math::MPFR::overload_sub_eq function");
}

SV * overload_add_eq(SV * a, SV * b, SV * third) {
     mpfr_t t;

     SvREFCNT_inc(a);

#ifdef USE_64_BIT_INT
#ifndef _MSC_VER
     if(SvUOK(b)) {
       mpfr_init(t);
       mpfr_set_uj(t, SvUV(b), __gmpfr_default_rounding_mode);
       mpfr_add(*(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), *(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), t, __gmpfr_default_rounding_mode);
       mpfr_clear(t);
       return a;
       }

     if(SvIOK(b)) {
       mpfr_init(t);
       mpfr_set_sj(t, SvIV(b), __gmpfr_default_rounding_mode);
       mpfr_add(*(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), *(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), t, __gmpfr_default_rounding_mode);
       mpfr_clear(t);
       return a;
       }
#else
     if(SvIOK(b)) {
       if(mpfr_init_set_str(t, SvPV_nolen(b), 10, __gmpfr_default_rounding_mode)) {
         SvREFCNT_dec(a);
         croak("Invalid string supplied to Math::MPFR::overload_add_eq");
         }
       mpfr_add(*(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), *(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), t, __gmpfr_default_rounding_mode);
       mpfr_clear(t);
       return a;
       }
#endif
#else
     if(SvUOK(b)) {
       mpfr_add_ui(*(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), *(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), SvUV(b), __gmpfr_default_rounding_mode);
       return a;
       }

     if(SvIOK(b)) {
       if(SvIV(b) >= 0) {
         mpfr_add_ui(*(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), *(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), SvUV(b), __gmpfr_default_rounding_mode);
         return a;
         }
       mpfr_sub_ui(*(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), *(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), SvIV(b) * -1, __gmpfr_default_rounding_mode);
       return a;
       }
#endif

     if(SvNOK(b)) {
#ifdef USE_LONG_DOUBLE
#ifndef _MSC_VER
       mpfr_init(t);
       mpfr_set_ld(t, SvNV(b), __gmpfr_default_rounding_mode);
#else
       mpfr_init_set_d(t, SvNV(b), __gmpfr_default_rounding_mode);
#endif
#else
       mpfr_init_set_d(t, SvNV(b), __gmpfr_default_rounding_mode);
#endif
       mpfr_add(*(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), *(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), t, __gmpfr_default_rounding_mode);
       mpfr_clear(t);
       return a;
       }

     if(SvPOK(b)) {
       if(mpfr_init_set_str(t, SvPV_nolen(b), 0, __gmpfr_default_rounding_mode)) {
         SvREFCNT_dec(a);
         croak("Invalid string supplied to Math::MPFR::overload_add_eq");
         }
       mpfr_add(*(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), *(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), t, __gmpfr_default_rounding_mode);
       mpfr_clear(t);
       return a;
       }

     if(sv_isobject(b)) {
       if(strEQ(HvNAME(SvSTASH(SvRV(b))), "Math::MPFR")) {
         mpfr_add(*(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), *(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), *(INT2PTR(mpfr_t *, SvIV(SvRV(b)))), __gmpfr_default_rounding_mode);
         return a;
         }
       }

     SvREFCNT_dec(a);
     croak("Invalid argument supplied to Math::MPFR::overload_add_eq");
}

SV * overload_mul_eq(SV * a, SV * b, SV * third) {
     mpfr_t t;

     SvREFCNT_inc(a);

#ifdef USE_64_BIT_INT
#ifndef _MSC_VER
     if(SvUOK(b)) {
       mpfr_init(t);
       mpfr_set_uj(t, SvUV(b), __gmpfr_default_rounding_mode);
       mpfr_mul(*(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), *(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), t, __gmpfr_default_rounding_mode);
       mpfr_clear(t);
       return a;
       }

     if(SvIOK(b)) {
       mpfr_init(t);
       mpfr_set_sj(t, SvIV(b), __gmpfr_default_rounding_mode);
       mpfr_mul(*(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), *(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), t, __gmpfr_default_rounding_mode);
       mpfr_clear(t);
       return a;
       }
#else
     if(SvIOK(b)) {
       if(mpfr_init_set_str(t, SvPV_nolen(b), 10, __gmpfr_default_rounding_mode)) {
         SvREFCNT_dec(a);
         croak("Invalid string supplied to Math::MPFR::overload_mul_eq");
         }
       mpfr_mul(*(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), *(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), t, __gmpfr_default_rounding_mode);
       mpfr_clear(t);
       return a;
       }
#endif
#else
     if(SvUOK(b)) {
       mpfr_mul_ui(*(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), *(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), SvUV(b), __gmpfr_default_rounding_mode);
       return a;
       }

     if(SvIOK(b)) {
       if(SvIV(b) >= 0) {
         mpfr_mul_ui(*(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), *(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), SvUV(b), __gmpfr_default_rounding_mode);
         return a;
         }
       mpfr_mul_ui(*(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), *(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), SvIV(b) * -1, __gmpfr_default_rounding_mode);
       mpfr_neg(*(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), *(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), __gmpfr_default_rounding_mode);
       return a;
       }
#endif

     if(SvNOK(b)) {
#ifdef USE_LONG_DOUBLE
#ifndef _MSC_VER
       mpfr_init(t);
       mpfr_set_ld(t, SvNV(b), __gmpfr_default_rounding_mode);
#else
       mpfr_init_set_d(t, SvNV(b), __gmpfr_default_rounding_mode);
#endif
#else
       mpfr_init_set_d(t, SvNV(b), __gmpfr_default_rounding_mode);
#endif
       mpfr_mul(*(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), *(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), t, __gmpfr_default_rounding_mode);
       mpfr_clear(t);
       return a;
       }

     if(SvPOK(b)) {
       if(mpfr_init_set_str(t, SvPV_nolen(b), 0, __gmpfr_default_rounding_mode)) {
         SvREFCNT_dec(a);
         croak("Invalid string supplied to Math::MPFR::overload_mul_eq");
         }
       mpfr_mul(*(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), *(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), t, __gmpfr_default_rounding_mode);
       mpfr_clear(t);
       return a;
       }

     if(sv_isobject(b)) {
       if(strEQ(HvNAME(SvSTASH(SvRV(b))), "Math::MPFR")) {
         mpfr_mul(*(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), *(INT2PTR(mpfr_t *, SvIV(SvRV(a)))), *(INT2PTR(mpfr_t *, SvIV(SvRV(b)))), __gmpfr_default_rounding_mode);
         return a;
         }
       }

     SvREFCNT_dec(a);
     croak("Invalid argument supplied to Math::MPFR::overload_mul_eq");
}

SV * _itsa(SV * a) {
     if(SvUOK(a)) return newSVuv(1);
     if(SvIOK(a)) return newSVuv(2);
     if(SvNOK(a)) return newSVuv(3);
     if(SvPOK(a)) return newSVuv(4);
     if(sv_isobject(a)) {
       if(strEQ(HvNAME(SvSTASH(SvRV(a))), "Math::MPFR")) return newSVuv(5);
       if(strEQ(HvNAME(SvSTASH(SvRV(a))), "Math::GMPf")) return newSVuv(6);
       if(strEQ(HvNAME(SvSTASH(SvRV(a))), "Math::GMPq")) return newSVuv(7);
       if(strEQ(HvNAME(SvSTASH(SvRV(a))), "Math::GMPz")) return newSVuv(8);
       if(strEQ(HvNAME(SvSTASH(SvRV(a))), "Math::GMP")) return newSVuv(9);
       }
     return newSVuv(0);
}

int _has_longlong() {
#ifdef USE_64_BIT_INT
    return 1;
#else
    return 0;
#endif
}

int _has_longdouble() {
#ifdef USE_LONG_DOUBLE
    return 1;
#else
    return 0;
#endif
}

/*
int _mpfr_longsize() {
    mpfr_t x, y;

    mpfr_init2(x, 100);
    mpfr_init2(y, 100);

    mpfr_set_str(x, "18446744073709551615", 10, GMP_RNDN);
    mpfr_set_ui(y, 18446744073709551615, GMP_RNDN);

    if(!mpfr_cmp(x,y)) return 64;
    return 32;
}
*/

SV * RMPFR_PREC_MAX() {
     return newSVuv(MPFR_PREC_MAX);
}

SV * RMPFR_PREC_MIN() {
     return newSVuv(MPFR_PREC_MIN);
}

SV * wrap_mpfr_printf(SV * a, SV * b) {
     int ret;
     if(sv_isobject(b)) { 
       if(strEQ(HvNAME(SvSTASH(SvRV(b))), "Math::MPFR")){
         ret = mpfr_printf(SvPV_nolen(a), *(INT2PTR(mpfr_t *, SvIV(SvRV(b)))));
         fflush(stdout);
         return newSViv(ret);
       }
   
       croak("Unrecognised object supplied as argument to Rmpfr_printf");
     } 

     if(SvUOK(b)) {
       ret = mpfr_printf(SvPV_nolen(a), SvUV(b));
       fflush(stdout);
       return newSViv(ret);
     }
     if(SvIOK(b)) {
       ret = mpfr_printf(SvPV_nolen(a), SvIV(b));
       fflush(stdout);
       return newSViv(ret);
     }
     if(SvNOK(b)) {
       ret = mpfr_printf(SvPV_nolen(a), SvNV(b));
       fflush(stdout);
       return newSViv(ret);
     }
     if(SvPOK(b)) {
       ret = mpfr_printf(SvPV_nolen(a), SvPV_nolen(b));
       fflush(stdout);
       return newSViv(ret);
     }
  
     croak("Unrecognised type supplied as argument to Rmpfr_printf");
}

SV * wrap_mpfr_fprintf(FILE * stream, SV * a, SV * b) {
     int ret;
     if(sv_isobject(b)) { 
       if(strEQ(HvNAME(SvSTASH(SvRV(b))), "Math::MPFR")) {
         ret = mpfr_fprintf(stream, SvPV_nolen(a), *(INT2PTR(mpfr_t *, SvIV(SvRV(b)))));
         fflush(stream);
         return newSViv(ret);
       }
 
       croak("Unrecognised object supplied as argument to Rmpfr_fprintf");
     } 

     if(SvUOK(b)) {
       ret = mpfr_fprintf(stream, SvPV_nolen(a), SvUV(b));
       fflush(stream);
       return newSViv(ret);
     }
     if(SvIOK(b)) {
       ret = mpfr_fprintf(stream, SvPV_nolen(a), SvIV(b));
       fflush(stream);
       return newSViv(ret);
     }
     if(SvNOK(b)) {
       ret = mpfr_fprintf(stream, SvPV_nolen(a), SvNV(b));
       fflush(stream);
       return newSViv(ret);
     }
     if(SvPOK(b)) {
       ret = mpfr_fprintf(stream, SvPV_nolen(a), SvPV_nolen(b));
       fflush(stream);
       return newSViv(ret);
     }

     croak("Unrecognised type supplied as argument to Rmpfr_fprintf");
}

SV * wrap_mpfr_sprintf(char * stream, SV * a, SV * b) {
     int ret;
     if(sv_isobject(b)) { 
       if(strEQ(HvNAME(SvSTASH(SvRV(b))), "Math::MPFR")) {
         ret = mpfr_sprintf(stream, SvPV_nolen(a), *(INT2PTR(mpfr_t *, SvIV(SvRV(b)))));
         return newSViv(ret);
       }

       croak("Unrecognised object supplied as argument to Rmpfr_sprintf");
     } 

     if(SvUOK(b)) {
       ret = mpfr_sprintf(stream, SvPV_nolen(a), SvUV(b));
       return newSViv(ret);
     }

     if(SvIOK(b)) {
       ret = mpfr_sprintf(stream, SvPV_nolen(a), SvIV(b));
       return newSViv(ret);
     }

     if(SvNOK(b)) {
       ret = mpfr_sprintf(stream, SvPV_nolen(a), SvNV(b));
       return newSViv(ret);
     }

     if(SvPOK(b)) {
       ret = mpfr_sprintf(stream, SvPV_nolen(a), SvPV_nolen(b));
       return newSViv(ret);
     }

     croak("Unrecognised type supplied as argument to Rmpfr_sprintf");
}

SV * wrap_mpfr_snprintf(char * stream, SV * bytes, SV * a, SV * b) {
     int ret;
     if(sv_isobject(b)) { 
       if(strEQ(HvNAME(SvSTASH(SvRV(b))), "Math::MPFR")) {
         ret = mpfr_snprintf(stream, (size_t)SvUV(bytes), SvPV_nolen(a), *(INT2PTR(mpfr_t *, SvIV(SvRV(b)))));
         return newSViv(ret);
       }

       croak("Unrecognised object supplied as argument to Rmpfr_snprintf");
     } 

     if(SvUOK(b)) {
       ret = mpfr_snprintf(stream, (size_t)SvUV(bytes), SvPV_nolen(a), SvUV(b));
       return newSViv(ret);
     }

     if(SvIOK(b)) {
       ret = mpfr_snprintf(stream, (size_t)SvUV(bytes), SvPV_nolen(a), SvIV(b));
       return newSViv(ret);
     }

     if(SvNOK(b)) {
       ret = mpfr_snprintf(stream, (size_t)SvUV(bytes), SvPV_nolen(a), SvNV(b));
       return newSViv(ret);
     }

     if(SvPOK(b)) {
       ret = mpfr_snprintf(stream, (size_t)SvUV(bytes), SvPV_nolen(a), SvPV_nolen(b));
       return newSViv(ret);
     }

     croak("Unrecognised type supplied as argument to Rmpfr_snprintf");
}

SV * wrap_mpfr_printf_rnd(SV * a, SV * round, SV * b) {
     int ret;
#if MPFR_VERSION_MAJOR >= 3
     if((mp_rnd_t)SvUV(round) > 4) croak("Invalid 2nd argument (rounding value) of %u passed to Rmpfr_printf", (mp_rnd_t)SvUV(round));
#else
     if((mp_rnd_t)SvUV(round) > 3) croak("Invalid 2nd argument (rounding value) of %u passed to Rmpfr_printf", (mp_rnd_t)SvUV(round));
#endif
     if(sv_isobject(b)) { 
       if(strEQ(HvNAME(SvSTASH(SvRV(b))), "Math::MPFR")){
         ret = mpfr_printf(SvPV_nolen(a), (mp_rnd_t)SvUV(round), *(INT2PTR(mpfr_t *, SvIV(SvRV(b)))));
         fflush(stdout);
         return newSViv(ret);
       }
   
       croak("Unrecognised object supplied as argument to Rmpfr_printf");
     } 

     if(SvUOK(b)) {
       ret = mpfr_printf(SvPV_nolen(a), (mp_rnd_t)SvUV(round), SvUV(b));
       fflush(stdout);
       return newSViv(ret);
     }
     if(SvIOK(b)) {
       ret = mpfr_printf(SvPV_nolen(a), (mp_rnd_t)SvUV(round), SvIV(b));
       fflush(stdout);
       return newSViv(ret);
     }
     if(SvNOK(b)) {
       ret = mpfr_printf(SvPV_nolen(a), (mp_rnd_t)SvUV(round), SvNV(b));
       fflush(stdout);
       return newSViv(ret);
     }
     if(SvPOK(b)) {
       ret = mpfr_printf(SvPV_nolen(a), (mp_rnd_t)SvUV(round), SvPV_nolen(b));
       fflush(stdout);
       return newSViv(ret);
     }
  
     croak("Unrecognised type supplied as argument to Rmpfr_printf");
}

SV * wrap_mpfr_fprintf_rnd(FILE * stream, SV * a, SV * round, SV * b) {
     int ret;
#if MPFR_VERSION_MAJOR >= 3
     if((mp_rnd_t)SvUV(round) > 4) croak("Invalid 3rd argument (rounding value) of %u passed to Rmpfr_fprintf", (mp_rnd_t)SvUV(round));
#else
     if((mp_rnd_t)SvUV(round) > 3) croak("Invalid 3rd argument (rounding value) of %u passed to Rmpfr_fprintf", (mp_rnd_t)SvUV(round));
#endif
     if(sv_isobject(b)) { 
       if(strEQ(HvNAME(SvSTASH(SvRV(b))), "Math::MPFR")) {
         ret = mpfr_fprintf(stream, SvPV_nolen(a), (mp_rnd_t)SvUV(round), *(INT2PTR(mpfr_t *, SvIV(SvRV(b)))));
         fflush(stream);
         return newSViv(ret);
       }
 
       croak("Unrecognised object supplied as argument to Rmpfr_fprintf");
     } 

     if(SvUOK(b)) {
       ret = mpfr_fprintf(stream, SvPV_nolen(a), (mp_rnd_t)SvUV(round), SvUV(b));
       fflush(stream);
       return newSViv(ret);
     }
     if(SvIOK(b)) {
       ret = mpfr_fprintf(stream, SvPV_nolen(a), (mp_rnd_t)SvUV(round), SvIV(b));
       fflush(stream);
       return newSViv(ret);
     }
     if(SvNOK(b)) {
       ret = mpfr_fprintf(stream, SvPV_nolen(a), (mp_rnd_t)SvUV(round), SvNV(b));
       fflush(stream);
       return newSViv(ret);
     }
     if(SvPOK(b)) {
       ret = mpfr_fprintf(stream, SvPV_nolen(a), (mp_rnd_t)SvUV(round), SvPV_nolen(b));
       fflush(stream);
       return newSViv(ret);
     }

     croak("Unrecognised type supplied as argument to Rmpfr_fprintf");
}

SV * wrap_mpfr_sprintf_rnd(char * stream, SV * a, SV * round, SV * b) {
     int ret;
#if MPFR_VERSION_MAJOR >= 3
     if((mp_rnd_t)SvUV(round) > 4) croak("Invalid 3rd argument (rounding value) of %u passed to Rmpfr_sprintf", (mp_rnd_t)SvUV(round));
#else
     if((mp_rnd_t)SvUV(round) > 3) croak("Invalid 3rd argument (rounding value) of %u passed to Rmpfr_sprintf", (mp_rnd_t)SvUV(round));
#endif
     if(sv_isobject(b)) { 
       if(strEQ(HvNAME(SvSTASH(SvRV(b))), "Math::MPFR")) {
         ret = mpfr_sprintf(stream, SvPV_nolen(a), (mp_rnd_t)SvUV(round), *(INT2PTR(mpfr_t *, SvIV(SvRV(b)))));
         return newSViv(ret);
       }

       croak("Unrecognised object supplied as argument to Rmpfr_sprintf");
     } 

     if(SvUOK(b)) {
       ret = mpfr_sprintf(stream, SvPV_nolen(a), (mp_rnd_t)SvUV(round), SvUV(b));
       return newSViv(ret);
     }

     if(SvIOK(b)) {
       ret = mpfr_sprintf(stream, SvPV_nolen(a), (mp_rnd_t)SvUV(round), SvIV(b));
       return newSViv(ret);
     }

     if(SvNOK(b)) {
       ret = mpfr_sprintf(stream, SvPV_nolen(a), (mp_rnd_t)SvUV(round), SvNV(b));
       return newSViv(ret);
     }

     if(SvPOK(b)) {
       ret = mpfr_sprintf(stream, SvPV_nolen(a), (mp_rnd_t)SvUV(round), SvPV_nolen(b));
       return newSViv(ret);
     }

     croak("Unrecognised type supplied as argument to Rmpfr_sprintf");
}

SV * wrap_mpfr_snprintf_rnd(char * stream, SV * bytes, SV * a, SV * round, SV * b) {
     int ret;
#if MPFR_VERSION_MAJOR >= 3
     if((mp_rnd_t)SvUV(round) > 4) croak("Invalid 3rd argument (rounding value) of %u passed to Rmpfr_snprintf", (mp_rnd_t)SvUV(round));
#else
     if((mp_rnd_t)SvUV(round) > 3) croak("Invalid 3rd argument (rounding value) of %u passed to Rmpfr_snprintf", (mp_rnd_t)SvUV(round));
#endif
     if(sv_isobject(b)) { 
       if(strEQ(HvNAME(SvSTASH(SvRV(b))), "Math::MPFR")) {
         ret = mpfr_snprintf(stream, (size_t)SvUV(bytes), SvPV_nolen(a), (mp_rnd_t)SvUV(round), *(INT2PTR(mpfr_t *, SvIV(SvRV(b)))));
         return newSViv(ret);
       }

       croak("Unrecognised object supplied as argument to Rmpfr_snprintf");
     } 

     if(SvUOK(b)) {
       ret = mpfr_snprintf(stream, (size_t)SvUV(bytes), SvPV_nolen(a), (mp_rnd_t)SvUV(round), SvUV(b));
       return newSViv(ret);
     }

     if(SvIOK(b)) {
       ret = mpfr_snprintf(stream, (size_t)SvUV(bytes), SvPV_nolen(a), (mp_rnd_t)SvUV(round), SvIV(b));
       return newSViv(ret);
     }

     if(SvNOK(b)) {
       ret = mpfr_snprintf(stream, (size_t)SvUV(bytes), SvPV_nolen(a), (mp_rnd_t)SvUV(round), SvNV(b));
       return newSViv(ret);
     }

     if(SvPOK(b)) {
       ret = mpfr_snprintf(stream, (size_t)SvUV(bytes), SvPV_nolen(a), (mp_rnd_t)SvUV(round), SvPV_nolen(b));
       return newSViv(ret);
     }

     croak("Unrecognised type supplied as argument to Rmpfr_snprintf");

}

SV * Rmpfr_buildopt_tls_p() {
#if MPFR_VERSION_MAJOR >= 3
     return newSViv(mpfr_buildopt_tls_p());
#else
     croak("Rmpfr_buildopt_tls_p not implemented with this version of the mpfr library - we have %s but need at least 3.0.0", MPFR_VERSION_STRING);
#endif
}

SV * Rmpfr_buildopt_decimal_p() {
#if MPFR_VERSION_MAJOR >= 3
     return newSViv(mpfr_buildopt_decimal_p());
#else
     croak("Rmpfr_buildopt_decimal_p not implemented with this version of the mpfr library - we have %s but need at least 3.0.0", MPFR_VERSION_STRING);
#endif
}

SV * Rmpfr_regular_p(mpfr_t * a) {
#if MPFR_VERSION_MAJOR >= 3
     return newSViv(mpfr_regular_p(*a));
#else
     croak("Rmpfr_regular_p not implemented with this version of the mpfr library - we have %s but need at least 3.0.0", MPFR_VERSION_STRING);
#endif
}

void Rmpfr_set_zero(mpfr_t * a, SV * sign) {
#if MPFR_VERSION_MAJOR >= 3
     mpfr_set_zero(*a, (int)SvIV(sign));
#else
     croak("Rmpfr_set_zero not implemented with this version of the mpfr library - we have %s but need at least 3.0.0", MPFR_VERSION_STRING);
#endif
}

SV * Rmpfr_digamma(mpfr_t * rop, mpfr_t * op, SV * round) {
#if MPFR_VERSION_MAJOR >= 3
     return newSViv(mpfr_digamma(*rop, *op, (mp_rnd_t)SvIV(round)));
#else
     croak("Rmpfr_digamma not implemented with this version of the mpfr library - we have %s but need at least 3.0.0", MPFR_VERSION_STRING);
#endif
}

SV * Rmpfr_ai(mpfr_t * rop, mpfr_t * op, SV * round) {
#if MPFR_VERSION_MAJOR >= 3
     return newSViv(mpfr_ai(*rop, *op, (mp_rnd_t)SvUV(round)));
#else
     croak("Rmpfr_ai not implemented with this version of the mpfr library - we have %s but need at least 3.0.0", MPFR_VERSION_STRING);
#endif
}

SV * Rmpfr_get_flt(mpfr_t * a, SV * round) {
#if MPFR_VERSION_MAJOR >= 3
     return newSVnv(mpfr_get_flt(*a, (mp_rnd_t)SvUV(round)));
#else
     croak("Rmpfr_get_flt not implemented with this version of the mpfr library - we have %s but need at least 3.0.0", MPFR_VERSION_STRING);
#endif
}

SV * Rmpfr_set_flt(mpfr_t * rop, SV * f, SV * round) {
#if MPFR_VERSION_MAJOR >= 3
     return newSViv(mpfr_set_flt(*rop, (float)SvNV(f), (mp_rnd_t)SvUV(round)));
#else
     croak("Rmpfr_set_flt not implemented with this version of the mpfr library - we have %s but need at least 3.0.0", MPFR_VERSION_STRING);
#endif
}

SV * Rmpfr_urandom(mpfr_t * rop, gmp_randstate_t* state, SV * round) {
#if MPFR_VERSION_MAJOR >= 3
     return newSViv(mpfr_urandom(*rop, *state, (mp_rnd_t)SvUV(round)));
#else
     croak("Rmpfr_urandom not implemented with this version of the mpfr library - we have %s but need at least 3.0.0", MPFR_VERSION_STRING);
#endif
}

SV * Rmpfr_set_z_2exp(mpfr_t * rop, mpz_t * op, SV * exp, SV * round) {
#if MPFR_VERSION_MAJOR >= 3
     return newSViv(mpfr_set_z_2exp(*rop, *op, (mpfr_exp_t)SvIV(exp), (mp_rnd_t)SvUV(round)));
#else
     croak("Rmpfr_set_z_2exp not implemented with this version of the mpfr library - we have %s but need at least 3.0.0", MPFR_VERSION_STRING);
#endif
}






MODULE = Math::MPFR	PACKAGE = Math::MPFR	

PROTOTYPES: DISABLE


int
_has_inttypes ()

void
Rmpfr_set_default_rounding_mode (round)
	SV *	round
	PREINIT:
	I32* temp;
	PPCODE:
	temp = PL_markstack_ptr++;
	Rmpfr_set_default_rounding_mode(round);
	if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
	  PL_markstack_ptr = temp;
	  XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
	return; /* assume stack size is correct */

SV *
Rmpfr_get_default_rounding_mode ()

SV *
Rmpfr_prec_round (p, prec, round)
	mpfr_t *	p
	SV *	prec
	SV *	round

void
DESTROY (p)
	mpfr_t *	p
	PREINIT:
	I32* temp;
	PPCODE:
	temp = PL_markstack_ptr++;
	DESTROY(p);
	if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
	  PL_markstack_ptr = temp;
	  XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
	return; /* assume stack size is correct */

void
Rmpfr_clear (p)
	mpfr_t *	p
	PREINIT:
	I32* temp;
	PPCODE:
	temp = PL_markstack_ptr++;
	Rmpfr_clear(p);
	if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
	  PL_markstack_ptr = temp;
	  XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
	return; /* assume stack size is correct */

void
Rmpfr_clear_mpfr (p)
	mpfr_t *	p
	PREINIT:
	I32* temp;
	PPCODE:
	temp = PL_markstack_ptr++;
	Rmpfr_clear_mpfr(p);
	if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
	  PL_markstack_ptr = temp;
	  XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
	return; /* assume stack size is correct */

void
Rmpfr_clear_ptr (p)
	mpfr_t *	p
	PREINIT:
	I32* temp;
	PPCODE:
	temp = PL_markstack_ptr++;
	Rmpfr_clear_ptr(p);
	if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
	  PL_markstack_ptr = temp;
	  XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
	return; /* assume stack size is correct */

void
Rmpfr_clears (p, ...)
	SV *	p
	PREINIT:
	I32* temp;
	PPCODE:
	temp = PL_markstack_ptr++;
	Rmpfr_clears(p);
	if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
	  PL_markstack_ptr = temp;
	  XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
	return; /* assume stack size is correct */

SV *
Rmpfr_init ()

SV *
Rmpfr_init2 (prec)
	SV *	prec

SV *
Rmpfr_init_nobless ()

SV *
Rmpfr_init2_nobless (prec)
	SV *	prec

void
Rmpfr_init_set (q, round)
	mpfr_t *	q
	SV *	round
	PREINIT:
	I32* temp;
	PPCODE:
	temp = PL_markstack_ptr++;
	Rmpfr_init_set(q, round);
	if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
	  PL_markstack_ptr = temp;
	  XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
	return; /* assume stack size is correct */

void
Rmpfr_init_set_ui (q, round)
	SV *	q
	SV *	round
	PREINIT:
	I32* temp;
	PPCODE:
	temp = PL_markstack_ptr++;
	Rmpfr_init_set_ui(q, round);
	if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
	  PL_markstack_ptr = temp;
	  XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
	return; /* assume stack size is correct */

void
Rmpfr_init_set_si (q, round)
	SV *	q
	SV *	round
	PREINIT:
	I32* temp;
	PPCODE:
	temp = PL_markstack_ptr++;
	Rmpfr_init_set_si(q, round);
	if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
	  PL_markstack_ptr = temp;
	  XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
	return; /* assume stack size is correct */

void
Rmpfr_init_set_d (q, round)
	SV *	q
	SV *	round
	PREINIT:
	I32* temp;
	PPCODE:
	temp = PL_markstack_ptr++;
	Rmpfr_init_set_d(q, round);
	if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
	  PL_markstack_ptr = temp;
	  XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
	return; /* assume stack size is correct */

void
Rmpfr_init_set_ld (q, round)
	SV *	q
	SV *	round
	PREINIT:
	I32* temp;
	PPCODE:
	temp = PL_markstack_ptr++;
	Rmpfr_init_set_ld(q, round);
	if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
	  PL_markstack_ptr = temp;
	  XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
	return; /* assume stack size is correct */

void
Rmpfr_init_set_f (q, round)
	mpf_t *	q
	SV *	round
	PREINIT:
	I32* temp;
	PPCODE:
	temp = PL_markstack_ptr++;
	Rmpfr_init_set_f(q, round);
	if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
	  PL_markstack_ptr = temp;
	  XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
	return; /* assume stack size is correct */

void
Rmpfr_init_set_z (q, round)
	mpz_t *	q
	SV *	round
	PREINIT:
	I32* temp;
	PPCODE:
	temp = PL_markstack_ptr++;
	Rmpfr_init_set_z(q, round);
	if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
	  PL_markstack_ptr = temp;
	  XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
	return; /* assume stack size is correct */

void
Rmpfr_init_set_q (q, round)
	mpq_t *	q
	SV *	round
	PREINIT:
	I32* temp;
	PPCODE:
	temp = PL_markstack_ptr++;
	Rmpfr_init_set_q(q, round);
	if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
	  PL_markstack_ptr = temp;
	  XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
	return; /* assume stack size is correct */

void
Rmpfr_init_set_str (q, base, round)
	SV *	q
	SV *	base
	SV *	round
	PREINIT:
	I32* temp;
	PPCODE:
	temp = PL_markstack_ptr++;
	Rmpfr_init_set_str(q, base, round);
	if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
	  PL_markstack_ptr = temp;
	  XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
	return; /* assume stack size is correct */

void
Rmpfr_init_set_nobless (q, round)
	mpfr_t *	q
	SV *	round
	PREINIT:
	I32* temp;
	PPCODE:
	temp = PL_markstack_ptr++;
	Rmpfr_init_set_nobless(q, round);
	if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
	  PL_markstack_ptr = temp;
	  XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
	return; /* assume stack size is correct */

void
Rmpfr_init_set_ui_nobless (q, round)
	SV *	q
	SV *	round
	PREINIT:
	I32* temp;
	PPCODE:
	temp = PL_markstack_ptr++;
	Rmpfr_init_set_ui_nobless(q, round);
	if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
	  PL_markstack_ptr = temp;
	  XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
	return; /* assume stack size is correct */

void
Rmpfr_init_set_si_nobless (q, round)
	SV *	q
	SV *	round
	PREINIT:
	I32* temp;
	PPCODE:
	temp = PL_markstack_ptr++;
	Rmpfr_init_set_si_nobless(q, round);
	if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
	  PL_markstack_ptr = temp;
	  XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
	return; /* assume stack size is correct */

void
Rmpfr_init_set_d_nobless (q, round)
	SV *	q
	SV *	round
	PREINIT:
	I32* temp;
	PPCODE:
	temp = PL_markstack_ptr++;
	Rmpfr_init_set_d_nobless(q, round);
	if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
	  PL_markstack_ptr = temp;
	  XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
	return; /* assume stack size is correct */

void
Rmpfr_init_set_ld_nobless (q, round)
	SV *	q
	SV *	round
	PREINIT:
	I32* temp;
	PPCODE:
	temp = PL_markstack_ptr++;
	Rmpfr_init_set_ld_nobless(q, round);
	if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
	  PL_markstack_ptr = temp;
	  XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
	return; /* assume stack size is correct */

void
Rmpfr_init_set_f_nobless (q, round)
	mpf_t *	q
	SV *	round
	PREINIT:
	I32* temp;
	PPCODE:
	temp = PL_markstack_ptr++;
	Rmpfr_init_set_f_nobless(q, round);
	if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
	  PL_markstack_ptr = temp;
	  XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
	return; /* assume stack size is correct */

void
Rmpfr_init_set_z_nobless (q, round)
	mpz_t *	q
	SV *	round
	PREINIT:
	I32* temp;
	PPCODE:
	temp = PL_markstack_ptr++;
	Rmpfr_init_set_z_nobless(q, round);
	if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
	  PL_markstack_ptr = temp;
	  XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
	return; /* assume stack size is correct */

void
Rmpfr_init_set_q_nobless (q, round)
	mpq_t *	q
	SV *	round
	PREINIT:
	I32* temp;
	PPCODE:
	temp = PL_markstack_ptr++;
	Rmpfr_init_set_q_nobless(q, round);
	if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
	  PL_markstack_ptr = temp;
	  XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
	return; /* assume stack size is correct */

void
Rmpfr_init_set_str_nobless (q, base, round)
	SV *	q
	SV *	base
	SV *	round
	PREINIT:
	I32* temp;
	PPCODE:
	temp = PL_markstack_ptr++;
	Rmpfr_init_set_str_nobless(q, base, round);
	if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
	  PL_markstack_ptr = temp;
	  XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
	return; /* assume stack size is correct */

void
Rmpfr_deref2 (p, base, n_digits, round)
	mpfr_t *	p
	SV *	base
	SV *	n_digits
	SV *	round
	PREINIT:
	I32* temp;
	PPCODE:
	temp = PL_markstack_ptr++;
	Rmpfr_deref2(p, base, n_digits, round);
	if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
	  PL_markstack_ptr = temp;
	  XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
	return; /* assume stack size is correct */

void
Rmpfr_set_default_prec (prec)
	SV *	prec
	PREINIT:
	I32* temp;
	PPCODE:
	temp = PL_markstack_ptr++;
	Rmpfr_set_default_prec(prec);
	if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
	  PL_markstack_ptr = temp;
	  XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
	return; /* assume stack size is correct */

SV *
Rmpfr_get_default_prec ()

SV *
Rmpfr_min_prec ()

SV *
Rmpfr_max_prec ()

void
Rmpfr_set_prec (p, prec)
	mpfr_t *	p
	SV *	prec
	PREINIT:
	I32* temp;
	PPCODE:
	temp = PL_markstack_ptr++;
	Rmpfr_set_prec(p, prec);
	if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
	  PL_markstack_ptr = temp;
	  XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
	return; /* assume stack size is correct */

void
Rmpfr_set_prec_raw (p, prec)
	mpfr_t *	p
	SV *	prec
	PREINIT:
	I32* temp;
	PPCODE:
	temp = PL_markstack_ptr++;
	Rmpfr_set_prec_raw(p, prec);
	if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
	  PL_markstack_ptr = temp;
	  XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
	return; /* assume stack size is correct */

SV *
Rmpfr_get_prec (p)
	mpfr_t *	p

SV *
Rmpfr_set (p, q, round)
	mpfr_t *	p
	mpfr_t *	q
	SV *	round

SV *
Rmpfr_set_ui (p, q, round)
	mpfr_t *	p
	SV *	q
	SV *	round

SV *
Rmpfr_set_si (p, q, round)
	mpfr_t *	p
	SV *	q
	SV *	round

SV *
Rmpfr_set_uj (p, q, round)
	mpfr_t *	p
	SV *	q
	SV *	round

SV *
Rmpfr_set_sj (p, q, round)
	mpfr_t *	p
	SV *	q
	SV *	round

SV *
Rmpfr_set_ld (p, q, round)
	mpfr_t *	p
	SV *	q
	SV *	round

SV *
Rmpfr_set_d (p, q, round)
	mpfr_t *	p
	SV *	q
	SV *	round

SV *
Rmpfr_set_z (p, q, round)
	mpfr_t *	p
	mpz_t *	q
	SV *	round

SV *
Rmpfr_set_q (p, q, round)
	mpfr_t *	p
	mpq_t *	q
	SV *	round

SV *
Rmpfr_set_f (p, q, round)
	mpfr_t *	p
	mpf_t *	q
	SV *	round

SV *
Rmpfr_set_str (p, num, base, round)
	mpfr_t *	p
	SV *	num
	SV *	base
	SV *	round

void
Rmpfr_set_str_binary (p, str)
	mpfr_t *	p
	SV *	str
	PREINIT:
	I32* temp;
	PPCODE:
	temp = PL_markstack_ptr++;
	Rmpfr_set_str_binary(p, str);
	if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
	  PL_markstack_ptr = temp;
	  XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
	return; /* assume stack size is correct */

void
Rmpfr_set_inf (p, sign)
	mpfr_t *	p
	SV *	sign
	PREINIT:
	I32* temp;
	PPCODE:
	temp = PL_markstack_ptr++;
	Rmpfr_set_inf(p, sign);
	if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
	  PL_markstack_ptr = temp;
	  XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
	return; /* assume stack size is correct */

void
Rmpfr_set_nan (p)
	mpfr_t *	p
	PREINIT:
	I32* temp;
	PPCODE:
	temp = PL_markstack_ptr++;
	Rmpfr_set_nan(p);
	if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
	  PL_markstack_ptr = temp;
	  XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
	return; /* assume stack size is correct */

void
Rmpfr_swap (p, q)
	mpfr_t *	p
	mpfr_t *	q
	PREINIT:
	I32* temp;
	PPCODE:
	temp = PL_markstack_ptr++;
	Rmpfr_swap(p, q);
	if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
	  PL_markstack_ptr = temp;
	  XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
	return; /* assume stack size is correct */

SV *
Rmpfr_get_d (p, round)
	mpfr_t *	p
	SV *	round

SV *
Rmpfr_get_d_2exp (exp, p, round)
	SV *	exp
	mpfr_t *	p
	SV *	round

SV *
Rmpfr_get_ld_2exp (exp, p, round)
	SV *	exp
	mpfr_t *	p
	SV *	round

SV *
Rmpfr_get_ld (p, round)
	mpfr_t *	p
	SV *	round

SV *
Rmpfr_get_d1 (p)
	mpfr_t *	p

SV *
Rmpfr_get_z_2exp (z, p)
	mpz_t *	z
	mpfr_t *	p

SV *
Rmpfr_add (a, b, c, round)
	mpfr_t *	a
	mpfr_t *	b
	mpfr_t *	c
	SV *	round

SV *
Rmpfr_add_ui (a, b, c, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	c
	SV *	round

SV *
Rmpfr_add_d (a, b, c, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	c
	SV *	round

SV *
Rmpfr_add_si (a, b, c, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	c
	SV *	round

SV *
Rmpfr_add_z (a, b, c, round)
	mpfr_t *	a
	mpfr_t *	b
	mpz_t *	c
	SV *	round

SV *
Rmpfr_add_q (a, b, c, round)
	mpfr_t *	a
	mpfr_t *	b
	mpq_t *	c
	SV *	round

SV *
Rmpfr_sub (a, b, c, round)
	mpfr_t *	a
	mpfr_t *	b
	mpfr_t *	c
	SV *	round

SV *
Rmpfr_sub_ui (a, b, c, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	c
	SV *	round

SV *
Rmpfr_sub_d (a, b, c, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	c
	SV *	round

SV *
Rmpfr_sub_z (a, b, c, round)
	mpfr_t *	a
	mpfr_t *	b
	mpz_t *	c
	SV *	round

SV *
Rmpfr_sub_q (a, b, c, round)
	mpfr_t *	a
	mpfr_t *	b
	mpq_t *	c
	SV *	round

SV *
Rmpfr_ui_sub (a, b, c, round)
	mpfr_t *	a
	SV *	b
	mpfr_t *	c
	SV *	round

SV *
Rmpfr_d_sub (a, b, c, round)
	mpfr_t *	a
	SV *	b
	mpfr_t *	c
	SV *	round

SV *
Rmpfr_mul (a, b, c, round)
	mpfr_t *	a
	mpfr_t *	b
	mpfr_t *	c
	SV *	round

SV *
Rmpfr_mul_ui (a, b, c, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	c
	SV *	round

SV *
Rmpfr_mul_d (a, b, c, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	c
	SV *	round

SV *
Rmpfr_mul_z (a, b, c, round)
	mpfr_t *	a
	mpfr_t *	b
	mpz_t *	c
	SV *	round

SV *
Rmpfr_mul_q (a, b, c, round)
	mpfr_t *	a
	mpfr_t *	b
	mpq_t *	c
	SV *	round

SV *
Rmpfr_dim (rop, op1, op2, round)
	mpfr_t *	rop
	mpfr_t *	op1
	mpfr_t *	op2
	SV *	round

SV *
Rmpfr_div (a, b, c, round)
	mpfr_t *	a
	mpfr_t *	b
	mpfr_t *	c
	SV *	round

SV *
Rmpfr_div_ui (a, b, c, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	c
	SV *	round

SV *
Rmpfr_div_d (a, b, c, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	c
	SV *	round

SV *
Rmpfr_div_z (a, b, c, round)
	mpfr_t *	a
	mpfr_t *	b
	mpz_t *	c
	SV *	round

SV *
Rmpfr_div_q (a, b, c, round)
	mpfr_t *	a
	mpfr_t *	b
	mpq_t *	c
	SV *	round

SV *
Rmpfr_ui_div (a, b, c, round)
	mpfr_t *	a
	SV *	b
	mpfr_t *	c
	SV *	round

SV *
Rmpfr_d_div (a, b, c, round)
	mpfr_t *	a
	SV *	b
	mpfr_t *	c
	SV *	round

SV *
Rmpfr_sqrt (a, b, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	round

SV *
Rmpfr_rec_sqrt (a, b, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	round

SV *
Rmpfr_cbrt (a, b, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	round

SV *
Rmpfr_sqrt_ui (a, b, round)
	mpfr_t *	a
	SV *	b
	SV *	round

SV *
Rmpfr_pow_ui (a, b, c, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	c
	SV *	round

SV *
Rmpfr_ui_pow_ui (a, b, c, round)
	mpfr_t *	a
	SV *	b
	SV *	c
	SV *	round

SV *
Rmpfr_ui_pow (a, b, c, round)
	mpfr_t *	a
	SV *	b
	mpfr_t *	c
	SV *	round

SV *
Rmpfr_pow_si (a, b, c, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	c
	SV *	round

SV *
Rmpfr_pow (a, b, c, round)
	mpfr_t *	a
	mpfr_t *	b
	mpfr_t *	c
	SV *	round

SV *
Rmpfr_neg (a, b, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	round

SV *
Rmpfr_abs (a, b, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	round

SV *
Rmpfr_mul_2exp (a, b, c, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	c
	SV *	round

SV *
Rmpfr_mul_2ui (a, b, c, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	c
	SV *	round

SV *
Rmpfr_mul_2si (a, b, c, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	c
	SV *	round

SV *
Rmpfr_div_2exp (a, b, c, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	c
	SV *	round

SV *
Rmpfr_div_2ui (a, b, c, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	c
	SV *	round

SV *
Rmpfr_div_2si (a, b, c, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	c
	SV *	round

SV *
Rmpfr_cmp (a, b)
	mpfr_t *	a
	mpfr_t *	b

SV *
Rmpfr_cmpabs (a, b)
	mpfr_t *	a
	mpfr_t *	b

SV *
Rmpfr_cmp_ui (a, b)
	mpfr_t *	a
	SV *	b

SV *
Rmpfr_cmp_d (a, b)
	mpfr_t *	a
	SV *	b

SV *
Rmpfr_cmp_ld (a, b)
	mpfr_t *	a
	SV *	b

SV *
Rmpfr_cmp_si (a, b)
	mpfr_t *	a
	SV *	b

SV *
Rmpfr_cmp_ui_2exp (a, b, c)
	mpfr_t *	a
	SV *	b
	SV *	c

SV *
Rmpfr_cmp_si_2exp (a, b, c)
	mpfr_t *	a
	SV *	b
	SV *	c

SV *
Rmpfr_eq (a, b, c)
	mpfr_t *	a
	mpfr_t *	b
	SV *	c

SV *
Rmpfr_nan_p (p)
	mpfr_t *	p

SV *
Rmpfr_inf_p (p)
	mpfr_t *	p

SV *
Rmpfr_number_p (p)
	mpfr_t *	p

void
Rmpfr_reldiff (a, b, c, round)
	mpfr_t *	a
	mpfr_t *	b
	mpfr_t *	c
	SV *	round
	PREINIT:
	I32* temp;
	PPCODE:
	temp = PL_markstack_ptr++;
	Rmpfr_reldiff(a, b, c, round);
	if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
	  PL_markstack_ptr = temp;
	  XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
	return; /* assume stack size is correct */

SV *
Rmpfr_sgn (p)
	mpfr_t *	p

SV *
Rmpfr_greater_p (a, b)
	mpfr_t *	a
	mpfr_t *	b

SV *
Rmpfr_greaterequal_p (a, b)
	mpfr_t *	a
	mpfr_t *	b

SV *
Rmpfr_less_p (a, b)
	mpfr_t *	a
	mpfr_t *	b

SV *
Rmpfr_lessequal_p (a, b)
	mpfr_t *	a
	mpfr_t *	b

SV *
Rmpfr_lessgreater_p (a, b)
	mpfr_t *	a
	mpfr_t *	b

SV *
Rmpfr_equal_p (a, b)
	mpfr_t *	a
	mpfr_t *	b

SV *
Rmpfr_unordered_p (a, b)
	mpfr_t *	a
	mpfr_t *	b

SV *
Rmpfr_sin_cos (a, b, c, round)
	mpfr_t *	a
	mpfr_t *	b
	mpfr_t *	c
	SV *	round

SV *
Rmpfr_sinh_cosh (a, b, c, round)
	mpfr_t *	a
	mpfr_t *	b
	mpfr_t *	c
	SV *	round

SV *
Rmpfr_sin (a, b, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	round

SV *
Rmpfr_cos (a, b, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	round

SV *
Rmpfr_tan (a, b, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	round

SV *
Rmpfr_asin (a, b, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	round

SV *
Rmpfr_acos (a, b, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	round

SV *
Rmpfr_atan (a, b, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	round

SV *
Rmpfr_sinh (a, b, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	round

SV *
Rmpfr_cosh (a, b, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	round

SV *
Rmpfr_tanh (a, b, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	round

SV *
Rmpfr_asinh (a, b, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	round

SV *
Rmpfr_acosh (a, b, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	round

SV *
Rmpfr_atanh (a, b, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	round

SV *
Rmpfr_fac_ui (a, b, round)
	mpfr_t *	a
	SV *	b
	SV *	round

SV *
Rmpfr_log1p (a, b, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	round

SV *
Rmpfr_expm1 (a, b, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	round

SV *
Rmpfr_log2 (a, b, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	round

SV *
Rmpfr_log10 (a, b, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	round

SV *
Rmpfr_fma (a, b, c, d, round)
	mpfr_t *	a
	mpfr_t *	b
	mpfr_t *	c
	mpfr_t *	d
	SV *	round

SV *
Rmpfr_fms (a, b, c, d, round)
	mpfr_t *	a
	mpfr_t *	b
	mpfr_t *	c
	mpfr_t *	d
	SV *	round

SV *
Rmpfr_agm (a, b, c, round)
	mpfr_t *	a
	mpfr_t *	b
	mpfr_t *	c
	SV *	round

SV *
Rmpfr_hypot (a, b, c, round)
	mpfr_t *	a
	mpfr_t *	b
	mpfr_t *	c
	SV *	round

SV *
Rmpfr_const_log2 (p, round)
	mpfr_t *	p
	SV *	round

SV *
Rmpfr_const_pi (p, round)
	mpfr_t *	p
	SV *	round

SV *
Rmpfr_const_euler (p, round)
	mpfr_t *	p
	SV *	round

void
Rmpfr_print_binary (p)
	mpfr_t *	p
	PREINIT:
	I32* temp;
	PPCODE:
	temp = PL_markstack_ptr++;
	Rmpfr_print_binary(p);
	if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
	  PL_markstack_ptr = temp;
	  XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
	return; /* assume stack size is correct */

SV *
Rmpfr_rint (a, b, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	round

SV *
Rmpfr_ceil (a, b)
	mpfr_t *	a
	mpfr_t *	b

SV *
Rmpfr_floor (a, b)
	mpfr_t *	a
	mpfr_t *	b

SV *
Rmpfr_round (a, b)
	mpfr_t *	a
	mpfr_t *	b

SV *
Rmpfr_trunc (a, b)
	mpfr_t *	a
	mpfr_t *	b

SV *
Rmpfr_can_round (p, err, round1, round2, prec)
	mpfr_t *	p
	SV *	err
	SV *	round1
	SV *	round2
	SV *	prec

SV *
Rmpfr_get_emin ()

SV *
Rmpfr_get_emax ()

SV *
Rmpfr_set_emin (e)
	SV *	e

SV *
Rmpfr_set_emax (e)
	SV *	e

SV *
Rmpfr_check_range (p, t, round)
	mpfr_t *	p
	SV *	t
	SV *	round

void
Rmpfr_clear_underflow ()
	PREINIT:
	I32* temp;
	PPCODE:
	temp = PL_markstack_ptr++;
	Rmpfr_clear_underflow();
	if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
	  PL_markstack_ptr = temp;
	  XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
	return; /* assume stack size is correct */

void
Rmpfr_clear_overflow ()
	PREINIT:
	I32* temp;
	PPCODE:
	temp = PL_markstack_ptr++;
	Rmpfr_clear_overflow();
	if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
	  PL_markstack_ptr = temp;
	  XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
	return; /* assume stack size is correct */

void
Rmpfr_clear_nanflag ()
	PREINIT:
	I32* temp;
	PPCODE:
	temp = PL_markstack_ptr++;
	Rmpfr_clear_nanflag();
	if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
	  PL_markstack_ptr = temp;
	  XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
	return; /* assume stack size is correct */

void
Rmpfr_clear_inexflag ()
	PREINIT:
	I32* temp;
	PPCODE:
	temp = PL_markstack_ptr++;
	Rmpfr_clear_inexflag();
	if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
	  PL_markstack_ptr = temp;
	  XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
	return; /* assume stack size is correct */

void
Rmpfr_clear_flags ()
	PREINIT:
	I32* temp;
	PPCODE:
	temp = PL_markstack_ptr++;
	Rmpfr_clear_flags();
	if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
	  PL_markstack_ptr = temp;
	  XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
	return; /* assume stack size is correct */

SV *
Rmpfr_underflow_p ()

SV *
Rmpfr_overflow_p ()

SV *
Rmpfr_nanflag_p ()

SV *
Rmpfr_inexflag_p ()

SV *
Rmpfr_log (a, b, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	round

SV *
Rmpfr_exp (a, b, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	round

SV *
Rmpfr_exp2 (a, b, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	round

SV *
Rmpfr_exp10 (a, b, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	round

void
Rmpfr_urandomb (x, ...)
	SV *	x
	PREINIT:
	I32* temp;
	PPCODE:
	temp = PL_markstack_ptr++;
	Rmpfr_urandomb(x);
	if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
	  PL_markstack_ptr = temp;
	  XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
	return; /* assume stack size is correct */

void
Rmpfr_random2 (p, s, exp)
	mpfr_t *	p
	SV *	s
	SV *	exp
	PREINIT:
	I32* temp;
	PPCODE:
	temp = PL_markstack_ptr++;
	Rmpfr_random2(p, s, exp);
	if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
	  PL_markstack_ptr = temp;
	  XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
	return; /* assume stack size is correct */

SV *
_TRmpfr_out_str (stream, base, dig, p, round)
	FILE *	stream
	SV *	base
	SV *	dig
	mpfr_t *	p
	SV *	round

SV *
_Rmpfr_out_str (p, base, dig, round)
	mpfr_t *	p
	SV *	base
	SV *	dig
	SV *	round

SV *
_TRmpfr_out_strS (stream, base, dig, p, round, suff)
	FILE *	stream
	SV *	base
	SV *	dig
	mpfr_t *	p
	SV *	round
	SV *	suff

SV *
_TRmpfr_out_strP (pre, stream, base, dig, p, round)
	SV *	pre
	FILE *	stream
	SV *	base
	SV *	dig
	mpfr_t *	p
	SV *	round

SV *
_TRmpfr_out_strPS (pre, stream, base, dig, p, round, suff)
	SV *	pre
	FILE *	stream
	SV *	base
	SV *	dig
	mpfr_t *	p
	SV *	round
	SV *	suff

SV *
_Rmpfr_out_strS (p, base, dig, round, suff)
	mpfr_t *	p
	SV *	base
	SV *	dig
	SV *	round
	SV *	suff

SV *
_Rmpfr_out_strP (pre, p, base, dig, round)
	SV *	pre
	mpfr_t *	p
	SV *	base
	SV *	dig
	SV *	round

SV *
_Rmpfr_out_strPS (pre, p, base, dig, round, suff)
	SV *	pre
	mpfr_t *	p
	SV *	base
	SV *	dig
	SV *	round
	SV *	suff

SV *
TRmpfr_inp_str (p, stream, base, round)
	mpfr_t *	p
	FILE *	stream
	SV *	base
	SV *	round

SV *
Rmpfr_inp_str (p, base, round)
	mpfr_t *	p
	SV *	base
	SV *	round

SV *
Rmpfr_gamma (a, b, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	round

SV *
Rmpfr_zeta (a, b, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	round

SV *
Rmpfr_zeta_ui (a, b, round)
	mpfr_t *	a
	SV *	b
	SV *	round

SV *
Rmpfr_erf (a, b, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	round

SV *
Rmpfr_frac (a, b, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	round

SV *
Rmpfr_remainder (a, b, c, round)
	mpfr_t *	a
	mpfr_t *	b
	mpfr_t *	c
	SV *	round

SV *
Rmpfr_modf (a, b, c, round)
	mpfr_t *	a
	mpfr_t *	b
	mpfr_t *	c
	SV *	round

SV *
Rmpfr_fmod (a, b, c, round)
	mpfr_t *	a
	mpfr_t *	b
	mpfr_t *	c
	SV *	round

void
Rmpfr_remquo (a, b, c, round)
	mpfr_t *	a
	mpfr_t *	b
	mpfr_t *	c
	SV *	round
	PREINIT:
	I32* temp;
	PPCODE:
	temp = PL_markstack_ptr++;
	Rmpfr_remquo(a, b, c, round);
	if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
	  PL_markstack_ptr = temp;
	  XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
	return; /* assume stack size is correct */

SV *
Rmpfr_integer_p (p)
	mpfr_t *	p

void
Rmpfr_nexttoward (a, b)
	mpfr_t *	a
	mpfr_t *	b
	PREINIT:
	I32* temp;
	PPCODE:
	temp = PL_markstack_ptr++;
	Rmpfr_nexttoward(a, b);
	if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
	  PL_markstack_ptr = temp;
	  XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
	return; /* assume stack size is correct */

void
Rmpfr_nextabove (p)
	mpfr_t *	p
	PREINIT:
	I32* temp;
	PPCODE:
	temp = PL_markstack_ptr++;
	Rmpfr_nextabove(p);
	if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
	  PL_markstack_ptr = temp;
	  XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
	return; /* assume stack size is correct */

void
Rmpfr_nextbelow (p)
	mpfr_t *	p
	PREINIT:
	I32* temp;
	PPCODE:
	temp = PL_markstack_ptr++;
	Rmpfr_nextbelow(p);
	if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
	  PL_markstack_ptr = temp;
	  XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
	return; /* assume stack size is correct */

SV *
Rmpfr_min (a, b, c, round)
	mpfr_t *	a
	mpfr_t *	b
	mpfr_t *	c
	SV *	round

SV *
Rmpfr_max (a, b, c, round)
	mpfr_t *	a
	mpfr_t *	b
	mpfr_t *	c
	SV *	round

SV *
Rmpfr_get_exp (p)
	mpfr_t *	p

SV *
Rmpfr_set_exp (p, exp)
	mpfr_t *	p
	SV *	exp

SV *
Rmpfr_signbit (op)
	mpfr_t *	op

SV *
Rmpfr_setsign (rop, op, sign, round)
	mpfr_t *	rop
	mpfr_t *	op
	SV *	sign
	SV *	round

SV *
Rmpfr_copysign (rop, op1, op2, round)
	mpfr_t *	rop
	mpfr_t *	op1
	mpfr_t *	op2
	SV *	round

SV *
get_refcnt (s)
	SV *	s

SV *
get_package_name (x)
	SV *	x

void
Rmpfr_dump (a)
	mpfr_t *	a
	PREINIT:
	I32* temp;
	PPCODE:
	temp = PL_markstack_ptr++;
	Rmpfr_dump(a);
	if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
	  PL_markstack_ptr = temp;
	  XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
	return; /* assume stack size is correct */

SV *
gmp_v ()

SV *
Rmpfr_set_ui_2exp (a, b, c, round)
	mpfr_t *	a
	SV *	b
	SV *	c
	SV *	round

SV *
Rmpfr_set_si_2exp (a, b, c, round)
	mpfr_t *	a
	SV *	b
	SV *	c
	SV *	round

SV *
Rmpfr_set_uj_2exp (a, b, c, round)
	mpfr_t *	a
	SV *	b
	SV *	c
	SV *	round

SV *
Rmpfr_set_sj_2exp (a, b, c, round)
	mpfr_t *	a
	SV *	b
	SV *	c
	SV *	round

SV *
Rmpfr_get_z (a, b, round)
	mpz_t *	a
	mpfr_t *	b
	SV *	round

SV *
Rmpfr_si_sub (a, b, c, round)
	mpfr_t *	a
	SV *	b
	mpfr_t *	c
	SV *	round

SV *
Rmpfr_sub_si (a, b, c, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	c
	SV *	round

SV *
Rmpfr_mul_si (a, b, c, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	c
	SV *	round

SV *
Rmpfr_si_div (a, b, c, round)
	mpfr_t *	a
	SV *	b
	mpfr_t *	c
	SV *	round

SV *
Rmpfr_div_si (a, b, c, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	c
	SV *	round

SV *
Rmpfr_sqr (a, b, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	round

SV *
Rmpfr_cmp_z (a, b)
	mpfr_t *	a
	mpz_t *	b

SV *
Rmpfr_cmp_q (a, b)
	mpfr_t *	a
	mpq_t *	b

SV *
Rmpfr_cmp_f (a, b)
	mpfr_t *	a
	mpf_t *	b

SV *
Rmpfr_zero_p (a)
	mpfr_t *	a

void
Rmpfr_free_cache ()
	PREINIT:
	I32* temp;
	PPCODE:
	temp = PL_markstack_ptr++;
	Rmpfr_free_cache();
	if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
	  PL_markstack_ptr = temp;
	  XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
	return; /* assume stack size is correct */

SV *
Rmpfr_get_version ()

SV *
Rmpfr_get_patches ()

SV *
Rmpfr_get_emin_min ()

SV *
Rmpfr_get_emin_max ()

SV *
Rmpfr_get_emax_min ()

SV *
Rmpfr_get_emax_max ()

void
Rmpfr_clear_erangeflag ()
	PREINIT:
	I32* temp;
	PPCODE:
	temp = PL_markstack_ptr++;
	Rmpfr_clear_erangeflag();
	if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
	  PL_markstack_ptr = temp;
	  XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
	return; /* assume stack size is correct */

SV *
Rmpfr_erangeflag_p ()

SV *
Rmpfr_rint_round (a, b, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	round

SV *
Rmpfr_rint_trunc (a, b, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	round

SV *
Rmpfr_rint_ceil (a, b, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	round

SV *
Rmpfr_rint_floor (a, b, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	round

SV *
Rmpfr_get_ui (a, round)
	mpfr_t *	a
	SV *	round

SV *
Rmpfr_get_si (a, round)
	mpfr_t *	a
	SV *	round

SV *
Rmpfr_get_uj (a, round)
	mpfr_t *	a
	SV *	round

SV *
Rmpfr_get_sj (a, round)
	mpfr_t *	a
	SV *	round

SV *
Rmpfr_get_IV (x, round)
	mpfr_t *	x
	SV *	round

SV *
Rmpfr_get_UV (x, round)
	mpfr_t *	x
	SV *	round

SV *
Rmpfr_get_NV (x, round)
	mpfr_t *	x
	SV *	round

SV *
Rmpfr_fits_ulong_p (a, round)
	mpfr_t *	a
	SV *	round

SV *
Rmpfr_fits_slong_p (a, round)
	mpfr_t *	a
	SV *	round

SV *
Rmpfr_fits_ushort_p (a, round)
	mpfr_t *	a
	SV *	round

SV *
Rmpfr_fits_sshort_p (a, round)
	mpfr_t *	a
	SV *	round

SV *
Rmpfr_fits_uint_p (a, round)
	mpfr_t *	a
	SV *	round

SV *
Rmpfr_fits_sint_p (a, round)
	mpfr_t *	a
	SV *	round

SV *
Rmpfr_fits_uintmax_p (a, round)
	mpfr_t *	a
	SV *	round

SV *
Rmpfr_fits_intmax_p (a, round)
	mpfr_t *	a
	SV *	round

SV *
Rmpfr_fits_IV_p (x, round)
	mpfr_t *	x
	SV *	round

SV *
Rmpfr_fits_UV_p (x, round)
	mpfr_t *	x
	SV *	round

SV *
Rmpfr_strtofr (a, str, base, round)
	mpfr_t *	a
	SV *	str
	SV *	base
	SV *	round

void
Rmpfr_set_erangeflag ()
	PREINIT:
	I32* temp;
	PPCODE:
	temp = PL_markstack_ptr++;
	Rmpfr_set_erangeflag();
	if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
	  PL_markstack_ptr = temp;
	  XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
	return; /* assume stack size is correct */

void
Rmpfr_set_underflow ()
	PREINIT:
	I32* temp;
	PPCODE:
	temp = PL_markstack_ptr++;
	Rmpfr_set_underflow();
	if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
	  PL_markstack_ptr = temp;
	  XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
	return; /* assume stack size is correct */

void
Rmpfr_set_overflow ()
	PREINIT:
	I32* temp;
	PPCODE:
	temp = PL_markstack_ptr++;
	Rmpfr_set_overflow();
	if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
	  PL_markstack_ptr = temp;
	  XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
	return; /* assume stack size is correct */

void
Rmpfr_set_nanflag ()
	PREINIT:
	I32* temp;
	PPCODE:
	temp = PL_markstack_ptr++;
	Rmpfr_set_nanflag();
	if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
	  PL_markstack_ptr = temp;
	  XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
	return; /* assume stack size is correct */

void
Rmpfr_set_inexflag ()
	PREINIT:
	I32* temp;
	PPCODE:
	temp = PL_markstack_ptr++;
	Rmpfr_set_inexflag();
	if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
	  PL_markstack_ptr = temp;
	  XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
	return; /* assume stack size is correct */

SV *
Rmpfr_erfc (a, b, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	round

SV *
Rmpfr_j0 (a, b, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	round

SV *
Rmpfr_j1 (a, b, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	round

SV *
Rmpfr_jn (a, n, b, round)
	mpfr_t *	a
	SV *	n
	mpfr_t *	b
	SV *	round

SV *
Rmpfr_y0 (a, b, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	round

SV *
Rmpfr_y1 (a, b, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	round

SV *
Rmpfr_yn (a, n, b, round)
	mpfr_t *	a
	SV *	n
	mpfr_t *	b
	SV *	round

SV *
Rmpfr_atan2 (a, b, c, round)
	mpfr_t *	a
	mpfr_t *	b
	mpfr_t *	c
	SV *	round

SV *
Rmpfr_pow_z (a, b, c, round)
	mpfr_t *	a
	mpfr_t *	b
	mpz_t *	c
	SV *	round

SV *
Rmpfr_subnormalize (a, b, round)
	mpfr_t *	a
	SV *	b
	SV *	round

SV *
Rmpfr_const_catalan (a, round)
	mpfr_t *	a
	SV *	round

SV *
Rmpfr_sec (a, b, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	round

SV *
Rmpfr_csc (a, b, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	round

SV *
Rmpfr_cot (a, b, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	round

SV *
Rmpfr_root (a, b, c, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	c
	SV *	round

SV *
Rmpfr_eint (a, b, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	round

SV *
Rmpfr_li2 (a, b, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	round

SV *
Rmpfr_get_f (a, b, round)
	mpf_t *	a
	mpfr_t *	b
	SV *	round

SV *
Rmpfr_sech (a, b, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	round

SV *
Rmpfr_csch (a, b, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	round

SV *
Rmpfr_coth (a, b, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	round

SV *
Rmpfr_lngamma (a, b, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	round

void
Rmpfr_lgamma (a, b, round)
	mpfr_t *	a
	mpfr_t *	b
	SV *	round
	PREINIT:
	I32* temp;
	PPCODE:
	temp = PL_markstack_ptr++;
	Rmpfr_lgamma(a, b, round);
	if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
	  PL_markstack_ptr = temp;
	  XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
	return; /* assume stack size is correct */

SV *
_MPFR_VERSION ()

SV *
_MPFR_VERSION_MAJOR ()

SV *
_MPFR_VERSION_MINOR ()

SV *
_MPFR_VERSION_PATCHLEVEL ()

SV *
_MPFR_VERSION_STRING ()

SV *
RMPFR_VERSION_NUM (a, b, c)
	SV *	a
	SV *	b
	SV *	c

SV *
Rmpfr_sum (rop, avref, len, round)
	mpfr_t *	rop
	SV *	avref
	SV *	len
	SV *	round

SV *
overload_mul (a, b, third)
	mpfr_t *	a
	SV *	b
	SV *	third

SV *
overload_add (a, b, third)
	mpfr_t *	a
	SV *	b
	SV *	third

SV *
overload_sub (a, b, third)
	mpfr_t *	a
	SV *	b
	SV *	third

SV *
overload_div (a, b, third)
	mpfr_t *	a
	SV *	b
	SV *	third

SV *
overload_copy (p, second, third)
	mpfr_t *	p
	SV *	second
	SV *	third

SV *
overload_abs (p, second, third)
	mpfr_t *	p
	SV *	second
	SV *	third

SV *
overload_gt (a, b, third)
	mpfr_t *	a
	SV *	b
	SV *	third

SV *
overload_gte (a, b, third)
	mpfr_t *	a
	SV *	b
	SV *	third

SV *
overload_lt (a, b, third)
	mpfr_t *	a
	SV *	b
	SV *	third

SV *
overload_lte (a, b, third)
	mpfr_t *	a
	SV *	b
	SV *	third

SV *
overload_spaceship (a, b, third)
	mpfr_t *	a
	SV *	b
	SV *	third

SV *
overload_equiv (a, b, third)
	mpfr_t *	a
	SV *	b
	SV *	third

SV *
overload_not_equiv (a, b, third)
	mpfr_t *	a
	SV *	b
	SV *	third

SV *
overload_true (a, second, third)
	mpfr_t *	a
	SV *	second
	SV *	third

SV *
overload_not (a, second, third)
	mpfr_t *	a
	SV *	second
	SV *	third

SV *
overload_sqrt (p, second, third)
	mpfr_t *	p
	SV *	second
	SV *	third

SV *
overload_pow (p, second, third)
	mpfr_t *	p
	SV *	second
	SV *	third

SV *
overload_log (p, second, third)
	mpfr_t *	p
	SV *	second
	SV *	third

SV *
overload_exp (p, second, third)
	mpfr_t *	p
	SV *	second
	SV *	third

SV *
overload_sin (p, second, third)
	mpfr_t *	p
	SV *	second
	SV *	third

SV *
overload_cos (p, second, third)
	mpfr_t *	p
	SV *	second
	SV *	third

SV *
overload_int (p, second, third)
	mpfr_t *	p
	SV *	second
	SV *	third

SV *
overload_atan2 (a, b, third)
	mpfr_t *	a
	SV *	b
	SV *	third

SV *
Rgmp_randinit_default ()

SV *
Rgmp_randinit_lc_2exp (a, c, m2exp)
	SV *	a
	SV *	c
	SV *	m2exp

SV *
Rgmp_randinit_lc_2exp_size (size)
	SV *	size

void
Rgmp_randclear (p)
	SV *	p
	PREINIT:
	I32* temp;
	PPCODE:
	temp = PL_markstack_ptr++;
	Rgmp_randclear(p);
	if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
	  PL_markstack_ptr = temp;
	  XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
	return; /* assume stack size is correct */

void
Rgmp_randseed (state, seed)
	SV *	state
	SV *	seed
	PREINIT:
	I32* temp;
	PPCODE:
	temp = PL_markstack_ptr++;
	Rgmp_randseed(state, seed);
	if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
	  PL_markstack_ptr = temp;
	  XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
	return; /* assume stack size is correct */

void
Rgmp_randseed_ui (state, seed)
	SV *	state
	SV *	seed
	PREINIT:
	I32* temp;
	PPCODE:
	temp = PL_markstack_ptr++;
	Rgmp_randseed_ui(state, seed);
	if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
	  PL_markstack_ptr = temp;
	  XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
	return; /* assume stack size is correct */

SV *
overload_pow_eq (p, second, third)
	SV *	p
	SV *	second
	SV *	third

SV *
overload_div_eq (a, b, third)
	SV *	a
	SV *	b
	SV *	third

SV *
overload_sub_eq (a, b, third)
	SV *	a
	SV *	b
	SV *	third

SV *
overload_add_eq (a, b, third)
	SV *	a
	SV *	b
	SV *	third

SV *
overload_mul_eq (a, b, third)
	SV *	a
	SV *	b
	SV *	third

SV *
_itsa (a)
	SV *	a

int
_has_longlong ()

int
_has_longdouble ()

SV *
RMPFR_PREC_MAX ()

SV *
RMPFR_PREC_MIN ()

SV *
wrap_mpfr_printf (a, b)
	SV *	a
	SV *	b

SV *
wrap_mpfr_fprintf (stream, a, b)
	FILE *	stream
	SV *	a
	SV *	b

SV *
wrap_mpfr_sprintf (stream, a, b)
	char *	stream
	SV *	a
	SV *	b

SV *
wrap_mpfr_snprintf (stream, bytes, a, b)
	char *	stream
	SV *	bytes
	SV *	a
	SV *	b

SV *
wrap_mpfr_printf_rnd (a, round, b)
	SV *	a
	SV *	round
	SV *	b

SV *
wrap_mpfr_fprintf_rnd (stream, a, round, b)
	FILE *	stream
	SV *	a
	SV *	round
	SV *	b

SV *
wrap_mpfr_sprintf_rnd (stream, a, round, b)
	char *	stream
	SV *	a
	SV *	round
	SV *	b

SV *
wrap_mpfr_snprintf_rnd (stream, bytes, a, round, b)
	char *	stream
	SV *	bytes
	SV *	a
	SV *	round
	SV *	b

SV *
Rmpfr_buildopt_tls_p ()

SV *
Rmpfr_buildopt_decimal_p ()

SV *
Rmpfr_regular_p (a)
	mpfr_t *	a

void
Rmpfr_set_zero (a, sign)
	mpfr_t *	a
	SV *	sign
	PREINIT:
	I32* temp;
	PPCODE:
	temp = PL_markstack_ptr++;
	Rmpfr_set_zero(a, sign);
	if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
	  PL_markstack_ptr = temp;
	  XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
	return; /* assume stack size is correct */

SV *
Rmpfr_digamma (rop, op, round)
	mpfr_t *	rop
	mpfr_t *	op
	SV *	round

SV *
Rmpfr_ai (rop, op, round)
	mpfr_t *	rop
	mpfr_t *	op
	SV *	round

SV *
Rmpfr_get_flt (a, round)
	mpfr_t *	a
	SV *	round

SV *
Rmpfr_set_flt (rop, f, round)
	mpfr_t *	rop
	SV *	f
	SV *	round

SV *
Rmpfr_urandom (rop, state, round)
	mpfr_t *	rop
	gmp_randstate_t *	state
	SV *	round

SV *
Rmpfr_set_z_2exp (rop, op, exp, round)
	mpfr_t *	rop
	mpz_t *	op
	SV *	exp
	SV *	round

