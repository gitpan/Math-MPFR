#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include "INLINE.h"
#include <stdio.h>
#include <gmp.h>
#include <mpfr.h>

// Squash some annoying compiler warnings (Microsoft compilers only).
#ifdef _MSC_VER
#pragma warning(disable:4700 4715 4716)
#endif

#if defined USE_64_BIT_INT || defined USE_LONG_DOUBLE
#ifndef _MSC_VER
#include <inttypes.h>
#endif
#endif

#ifdef OLDPERL
#define SvUOK SvIsUV
#endif

#ifndef __gmpfr_default_rounding_mode
#define __gmpfr_default_rounding_mode mpfr_get_default_rounding_mode()
#endif

void Rmpfr_set_default_rounding_mode(SV * round) {
     mpfr_set_default_rounding_mode(SvUV(round));    
}

SV * Rmpfr_get_default_rounding_mode() {
     return newSViv(__gmpfr_default_rounding_mode);
}

SV * Rmpfr_prec_round(mpfr_t * p, SV * prec, SV * round) {
     return newSViv(mpfr_prec_round(*p, (mpfr_prec_t)SvUV(prec), SvUV(round)));
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
     Inline_Stack_Vars;
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;
     int ret;

     Inline_Stack_Reset;

     New(1, mpfr_t_obj, 1, mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in Rmpfr_init_set function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, "Math::MPFR");
     ret = mpfr_init_set(*mpfr_t_obj, *q, SvUV(round));

     sv_setiv(obj, INT2PTR(IV,mpfr_t_obj));
     SvREADONLY_on(obj);
     Inline_Stack_Push(sv_2mortal(obj_ref));
     Inline_Stack_Push(sv_2mortal(newSViv(ret)));
     Inline_Stack_Done;
     Inline_Stack_Return(2);
}

void Rmpfr_init_set_ui(SV * q, SV * round) {
     Inline_Stack_Vars;
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;
     int ret;

     Inline_Stack_Reset;

     New(1, mpfr_t_obj, 1, mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in Rmpfr_init_set_ui function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, "Math::MPFR");
     ret = mpfr_init_set_ui(*mpfr_t_obj, (unsigned long)SvUV(q), SvUV(round));

     sv_setiv(obj, INT2PTR(IV,mpfr_t_obj));
     SvREADONLY_on(obj);
     Inline_Stack_Push(sv_2mortal(obj_ref));
     Inline_Stack_Push(sv_2mortal(newSViv(ret)));
     Inline_Stack_Done;
     Inline_Stack_Return(2);
}

void Rmpfr_init_set_si(SV * q, SV * round) {
     Inline_Stack_Vars;
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;
     int ret;

     Inline_Stack_Reset;

     New(1, mpfr_t_obj, 1, mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in Rmpfr_init_set_si function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, "Math::MPFR");
     ret = mpfr_init_set_si(*mpfr_t_obj, (long)SvIV(q), SvUV(round));

     sv_setiv(obj, INT2PTR(IV,mpfr_t_obj));
     SvREADONLY_on(obj);
     Inline_Stack_Push(sv_2mortal(obj_ref));
     Inline_Stack_Push(sv_2mortal(newSViv(ret)));
     Inline_Stack_Done;
     Inline_Stack_Return(2);
}

void Rmpfr_init_set_d(SV * q, SV * round) {
     Inline_Stack_Vars;
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;
     int ret;

     Inline_Stack_Reset;

     New(1, mpfr_t_obj, 1, mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in Rmpfr_init_set_d function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, "Math::MPFR");
     ret = mpfr_init_set_d(*mpfr_t_obj, SvNV(q), SvUV(round));

     sv_setiv(obj, INT2PTR(IV,mpfr_t_obj));
     SvREADONLY_on(obj);
     Inline_Stack_Push(sv_2mortal(obj_ref));
     Inline_Stack_Push(sv_2mortal(newSViv(ret)));
     Inline_Stack_Done;
     Inline_Stack_Return(2);
}

void Rmpfr_init_set_ld(SV * q, SV * round) {
#ifdef USE_LONG_DOUBLE
#ifndef _MSC_VER
     Inline_Stack_Vars;
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;
     int ret;

     Inline_Stack_Reset;

     New(1, mpfr_t_obj, 1, mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in Rmpfr_init_set_d function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, "Math::MPFR");
     ret = mpfr_init_set_ld(*mpfr_t_obj, SvNV(q), SvUV(round));
     sv_setiv(obj, INT2PTR(IV,mpfr_t_obj));
     SvREADONLY_on(obj);
     Inline_Stack_Push(sv_2mortal(obj_ref));
     Inline_Stack_Push(sv_2mortal(newSViv(ret)));
     Inline_Stack_Done;
     Inline_Stack_Return(2);
#else
     croak("Rmpfr_init_set_ld() not implemented on this build of perl - use Rmpfr_init_set_d() instead");
#endif
#else
     croak("Rmpfr_init_set_ld() not implemented on this build of perl");
#endif
}

void Rmpfr_init_set_f(mpf_t * q, SV * round) {
     Inline_Stack_Vars;
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;
     int ret;

     Inline_Stack_Reset;

     New(1, mpfr_t_obj, 1, mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in Rmpfr_init_set_f function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, "Math::MPFR");
     ret = mpfr_init_set_f(*mpfr_t_obj, *q, SvUV(round));

     sv_setiv(obj, INT2PTR(IV,mpfr_t_obj));
     SvREADONLY_on(obj);
     Inline_Stack_Push(sv_2mortal(obj_ref));
     Inline_Stack_Push(sv_2mortal(newSViv(ret)));
     Inline_Stack_Done;
     Inline_Stack_Return(2);
}

void Rmpfr_init_set_z(mpz_t * q, SV * round) {
     Inline_Stack_Vars;
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;
     int ret;

     Inline_Stack_Reset;

     New(1, mpfr_t_obj, 1, mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in Rmpfr_init_set_z function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, "Math::MPFR");
     ret = mpfr_init_set_z(*mpfr_t_obj, *q, SvUV(round));

     sv_setiv(obj, INT2PTR(IV,mpfr_t_obj));
     SvREADONLY_on(obj);
     Inline_Stack_Push(sv_2mortal(obj_ref));
     Inline_Stack_Push(sv_2mortal(newSViv(ret)));
     Inline_Stack_Done;
     Inline_Stack_Return(2);
}

void Rmpfr_init_set_q(mpq_t * q, SV * round) {
     Inline_Stack_Vars;
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;
     int ret;

     Inline_Stack_Reset;

     New(1, mpfr_t_obj, 1, mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in Rmpfr_init_set_q function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, "Math::MPFR");
     ret = mpfr_init_set_q(*mpfr_t_obj, *q, SvUV(round));

     sv_setiv(obj, INT2PTR(IV,mpfr_t_obj));
     SvREADONLY_on(obj);
     Inline_Stack_Push(sv_2mortal(obj_ref));
     Inline_Stack_Push(sv_2mortal(newSViv(ret)));
     Inline_Stack_Done;
     Inline_Stack_Return(2);
}

void Rmpfr_init_set_str(SV * q, SV * base, SV * round) {
     Inline_Stack_Vars;
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;
     int ret = (int)SvIV(base);

     Inline_Stack_Reset;

     if(ret < 0 || ret > 36 || ret == 1) croak("2nd argument supplied to Rmpf_init_set str is out of allowable range");

     New(1, mpfr_t_obj, 1, mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in Rmpfr_init_set_str function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, "Math::MPFR");
     sv_setiv(obj, INT2PTR(IV,mpfr_t_obj));
     SvREADONLY_on(obj);
     ret = mpfr_init_set_str(*mpfr_t_obj, SvPV_nolen(q), ret, SvUV(round));

     Inline_Stack_Push(sv_2mortal(obj_ref));
     Inline_Stack_Push(sv_2mortal(newSViv(ret)));
     Inline_Stack_Done;
     Inline_Stack_Return(2);
}

void Rmpfr_init_set_nobless(mpfr_t * q, SV * round) {
     Inline_Stack_Vars;
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;
     int ret;

     Inline_Stack_Reset;

     New(1, mpfr_t_obj, 1, mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in Rmpfr_init_set_nobless function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, NULL);
     ret = mpfr_init_set(*mpfr_t_obj, *q, SvUV(round));

     sv_setiv(obj, INT2PTR(IV,mpfr_t_obj));
     SvREADONLY_on(obj);
     Inline_Stack_Push(sv_2mortal(obj_ref));
     Inline_Stack_Push(sv_2mortal(newSViv(ret)));
     Inline_Stack_Done;
     Inline_Stack_Return(2);
}

void Rmpfr_init_set_ui_nobless(SV * q, SV * round) {
     Inline_Stack_Vars;
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;
     int ret;

     Inline_Stack_Reset;

     New(1, mpfr_t_obj, 1, mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in Rmpfr_init_set_ui_nobless function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, NULL);
     ret = mpfr_init_set_ui(*mpfr_t_obj, (unsigned long)SvUV(q), SvUV(round));

     sv_setiv(obj, INT2PTR(IV,mpfr_t_obj));
     SvREADONLY_on(obj);
     Inline_Stack_Push(sv_2mortal(obj_ref));
     Inline_Stack_Push(sv_2mortal(newSViv(ret)));
     Inline_Stack_Done;
     Inline_Stack_Return(2);
}

void Rmpfr_init_set_si_nobless(SV * q, SV * round) {
     Inline_Stack_Vars;
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;
     int ret;

     Inline_Stack_Reset;

     New(1, mpfr_t_obj, 1, mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in Rmpfr_init_set_si_nobless function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, NULL);
     ret = mpfr_init_set_si(*mpfr_t_obj, (long)SvIV(q), SvUV(round));

     sv_setiv(obj, INT2PTR(IV,mpfr_t_obj));
     SvREADONLY_on(obj);
     Inline_Stack_Push(sv_2mortal(obj_ref));
     Inline_Stack_Push(sv_2mortal(newSViv(ret)));
     Inline_Stack_Done;
     Inline_Stack_Return(2);
}

void Rmpfr_init_set_d_nobless(SV * q, SV * round) {
     Inline_Stack_Vars;
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;
     int ret;

     Inline_Stack_Reset;

     New(1, mpfr_t_obj, 1, mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in Rmpfr_init_set_d_nobless function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, NULL);
     ret = mpfr_init_set_d(*mpfr_t_obj, SvNV(q), SvUV(round));

     sv_setiv(obj, INT2PTR(IV,mpfr_t_obj));
     SvREADONLY_on(obj);
     Inline_Stack_Push(sv_2mortal(obj_ref));
     Inline_Stack_Push(sv_2mortal(newSViv(ret)));
     Inline_Stack_Done;
     Inline_Stack_Return(2);
}

void Rmpfr_init_set_ld_nobless(SV * q, SV * round) {
#ifdef USE_LONG_DOUBLE
#ifndef _MSC_VER
     Inline_Stack_Vars;
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;
     int ret;

     Inline_Stack_Reset;

     New(1, mpfr_t_obj, 1, mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in Rmpfr_init_set_d_nobless function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, NULL);
     ret = mpfr_init_set_ld(*mpfr_t_obj, SvNV(q), SvUV(round));
     sv_setiv(obj, INT2PTR(IV,mpfr_t_obj));
     SvREADONLY_on(obj);
     Inline_Stack_Push(sv_2mortal(obj_ref));
     Inline_Stack_Push(sv_2mortal(newSViv(ret)));
     Inline_Stack_Done;
     Inline_Stack_Return(2);
#else
     croak("Rmpfr_init_set_ld_nobless() not implemented on this build of perl - use Rmpfr_init_set_d_nobless() instead");
#endif
#else
     croak("Rmpfr_init_set_ld_nobless() not implemented on this build of perl");
#endif
}

void Rmpfr_init_set_f_nobless(mpf_t * q, SV * round) {
     Inline_Stack_Vars;
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;
     int ret;

     Inline_Stack_Reset;

     New(1, mpfr_t_obj, 1, mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in Rmpfr_init_set_f_nobless function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, NULL);
     ret = mpfr_init_set_f(*mpfr_t_obj, *q, SvUV(round));

     sv_setiv(obj, INT2PTR(IV,mpfr_t_obj));
     SvREADONLY_on(obj);
     Inline_Stack_Push(sv_2mortal(obj_ref));
     Inline_Stack_Push(sv_2mortal(newSViv(ret)));
     Inline_Stack_Done;
     Inline_Stack_Return(2);
}

void Rmpfr_init_set_z_nobless(mpz_t * q, SV * round) {
     Inline_Stack_Vars;
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;
     int ret;

     Inline_Stack_Reset;

     New(1, mpfr_t_obj, 1, mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in Rmpfr_init_set_z_nobless function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, NULL);
     ret = mpfr_init_set_z(*mpfr_t_obj, *q, SvUV(round));

     sv_setiv(obj, INT2PTR(IV,mpfr_t_obj));
     SvREADONLY_on(obj);
     Inline_Stack_Push(sv_2mortal(obj_ref));
     Inline_Stack_Push(sv_2mortal(newSViv(ret)));
     Inline_Stack_Done;
     Inline_Stack_Return(2);
}

void Rmpfr_init_set_q_nobless(mpq_t * q, SV * round) {
     Inline_Stack_Vars;
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;
     int ret;

     Inline_Stack_Reset;

     New(1, mpfr_t_obj, 1, mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in Rmpfr_init_set_q_nobless function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, NULL);
     ret = mpfr_init_set_q(*mpfr_t_obj, *q, SvUV(round));

     sv_setiv(obj, INT2PTR(IV,mpfr_t_obj));
     SvREADONLY_on(obj);
     Inline_Stack_Push(sv_2mortal(obj_ref));
     Inline_Stack_Push(sv_2mortal(newSViv(ret)));
     Inline_Stack_Done;
     Inline_Stack_Return(2);
}

void Rmpfr_init_set_str_nobless(SV * q, SV * base, SV * round) {
     Inline_Stack_Vars;
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;
     int ret = (int)SvIV(base);

     if(ret < 0 || ret > 36 || ret == 1) croak("2nd argument supplied to Rmpfr_init_set_str_nobless is out of allowable range");

     Inline_Stack_Reset;

     New(1, mpfr_t_obj, 1, mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in Rmpfr_init_set_str_nobless function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, NULL);
     sv_setiv(obj, INT2PTR(IV,mpfr_t_obj));
     SvREADONLY_on(obj);
     ret = mpfr_init_set_str(*mpfr_t_obj, SvPV_nolen(q), ret, SvUV(round));

     Inline_Stack_Push(sv_2mortal(obj_ref));
     Inline_Stack_Push(sv_2mortal(newSViv(ret)));
     Inline_Stack_Done;
     Inline_Stack_Return(2);
}

void Rmpfr_deref2(mpfr_t * p, SV * base, SV * n_digits, SV * round) {
     Inline_Stack_Vars;
     char * out;
     mp_exp_t ptr, *expptr;
     unsigned long b = (unsigned long)SvUV(base);

     expptr = &ptr;

     if(b < 2 || b > 36) croak("Second argument supplied to Rmpfr_get_str() is not in acceptable range");

     out = mpfr_get_str(0, expptr, b, (unsigned long)SvUV(n_digits), *p, SvUV(round));

     if(out == NULL) croak("An error occurred in mpfr_get_str()\n");

     Inline_Stack_Reset;
     Inline_Stack_Push(sv_2mortal(newSVpv(out, 0)));
     mpfr_free_str(out);
     Inline_Stack_Push(sv_2mortal(newSViv(ptr)));
     Inline_Stack_Done;
     Inline_Stack_Return(2);
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
     return newSViv(mpfr_set(*p, *q, SvUV(round)));
}

SV * Rmpfr_set_ui(mpfr_t * p, SV * q, SV * round) {
     return newSViv(mpfr_set_ui(*p, (unsigned long)SvUV(q), SvUV(round)));
}

SV * Rmpfr_set_si(mpfr_t * p, SV * q, SV * round) {
     return newSViv(mpfr_set_si(*p, (long)SvIV(q), SvUV(round)));
}

SV * Rmpfr_set_uj(mpfr_t * p, SV * q, SV * round) {
#ifdef USE_64_BIT_INT
#ifndef _MSC_VER
     return newSViv(mpfr_set_uj(*p, SvUV(q), SvUV(round)));
#else
     croak("Rmpfr_set_uj() not implemented on this build of perl - use Rmpfr_set_str() instead");
#endif
#else
     croak("Rmpfr_set_uj() not implemented on this build of perl");
#endif
}

SV * Rmpfr_set_sj(mpfr_t * p, SV * q, SV * round) {
#ifdef USE_64_BIT_INT
#ifndef _MSC_VER
     return newSViv(mpfr_set_sj(*p, SvIV(q), SvUV(round)));
#else
     croak("Rmpfr_set_sj() not implemented on this build of perl - use Rmpfr_set_str() instead");
#endif
#else
     croak("Rmpfr_set_sj() not implemented on this build of perl");
#endif
}

SV * Rmpfr_set_ld(mpfr_t * p, SV * q, SV * round) {
#ifdef USE_LONG_DOUBLE
#ifndef _MSC_VER
     return newSViv(mpfr_set_ld(*p, SvNV(q), SvUV(round)));
#else
     croak("Rmpfr_set_ld() not implemented on this build of perl - use Rmpfr_set_d() instead");
#endif
#else
     croak("Rmpfr_set_ld() not implemented on this build of perl");
#endif
}

SV * Rmpfr_set_d(mpfr_t * p, SV * q, SV * round) {
     return newSViv(mpfr_set_d(*p, SvNV(q), SvUV(round)));
}

SV * Rmpfr_set_z(mpfr_t * p, mpz_t * q, SV * round) {
     return newSViv(mpfr_set_z(*p, *q, SvUV(round)));
}

SV * Rmpfr_set_q(mpfr_t * p, mpq_t * q, SV * round) {
     return newSViv(mpfr_set_q(*p, *q, SvUV(round)));
}

SV * Rmpfr_set_f(mpfr_t * p, mpf_t * q, SV * round) {
     return newSViv(mpfr_set_f(*p, *q, SvUV(round)));
}

SV * Rmpfr_set_str(mpfr_t * p, SV * num, SV * base, SV * round) {
     int b = (int)SvIV(base);
     if(b < 0 || b > 36 || b == 1) croak("3rd argument supplied to Rmpfr_set_str is out of allowable range");
     return newSViv(mpfr_set_str(*p, SvPV_nolen(num), b, SvUV(round)));
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
     return newSVnv(mpfr_get_d(*p, SvUV(round)));
}

SV * Rmpfr_get_ld(mpfr_t * p, SV * round){
#ifdef USE_LONG_DOUBLE
#ifndef _MSC_VER
     return newSVnv(mpfr_get_ld(*p, SvUV(round)));
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

SV * Rmpfr_get_z_exp(mpz_t * z, mpfr_t * p){
     return newSViv(mpfr_get_z_exp(*z, *p));
}

SV * Rmpfr_add(mpfr_t * a, mpfr_t * b, mpfr_t * c, SV * round) {
     return newSViv(mpfr_add(*a, *b, *c, SvUV(round)));
}

SV * Rmpfr_add_ui(mpfr_t * a, mpfr_t * b, SV * c, SV * round){
     return newSViv(mpfr_add_ui(*a, *b, (unsigned long)SvUV(c), SvUV(round)));
}

SV * Rmpfr_add_z(mpfr_t * a, mpfr_t * b, mpz_t * c, SV * round) {
     return newSViv(mpfr_add_z(*a, *b, *c, SvUV(round)));
}

SV * Rmpfr_add_q(mpfr_t * a, mpfr_t * b, mpq_t * c, SV * round) {
     return newSViv(mpfr_add_q(*a, *b, *c, SvUV(round)));
}

SV * Rmpfr_sub(mpfr_t * a, mpfr_t * b, mpfr_t * c, SV * round) {
     return newSViv(mpfr_sub(*a, *b, *c, SvUV(round)));
}

SV * Rmpfr_sub_ui(mpfr_t * a, mpfr_t * b, SV * c, SV * round) {
     return newSViv(mpfr_sub_ui(*a, *b, (unsigned long)SvUV(c), SvUV(round)));
}

SV * Rmpfr_sub_z(mpfr_t * a, mpfr_t * b, mpz_t * c, SV * round) {
     return newSViv(mpfr_sub_z(*a, *b, *c, SvUV(round)));
}

SV * Rmpfr_sub_q(mpfr_t * a, mpfr_t * b, mpq_t * c, SV * round) {
     return newSViv(mpfr_sub_q(*a, *b, *c, SvUV(round)));
}

SV * Rmpfr_ui_sub(mpfr_t * a, SV * b, mpfr_t * c, SV * round) {
     return newSViv(mpfr_ui_sub(*a, (unsigned long)SvUV(b), *c, SvUV(round)));
}

SV * Rmpfr_mul(mpfr_t * a, mpfr_t * b, mpfr_t * c, SV * round) {
     return newSViv(mpfr_mul(*a, *b, *c, SvUV(round)));
}

SV * Rmpfr_mul_ui(mpfr_t * a, mpfr_t * b, SV * c, SV * round){
     return newSViv(mpfr_mul_ui(*a, *b, (unsigned long)SvUV(c), SvUV(round)));
}

SV * Rmpfr_mul_z(mpfr_t * a, mpfr_t * b, mpz_t * c, SV * round) {
     return newSViv(mpfr_mul_z(*a, *b, *c, SvUV(round)));
}

SV * Rmpfr_mul_q(mpfr_t * a, mpfr_t * b, mpq_t * c, SV * round) {
     return newSViv(mpfr_mul_q(*a, *b, *c, SvUV(round)));
}

SV * Rmpfr_div(mpfr_t * a, mpfr_t * b, mpfr_t * c, SV * round) {
     return newSViv(mpfr_div(*a, *b, *c, SvUV(round)));
}

SV * Rmpfr_div_ui(mpfr_t * a, mpfr_t * b, SV * c, SV * round){
     return newSViv(mpfr_div_ui(*a, *b, (unsigned long)SvUV(c), SvUV(round)));
}

SV * Rmpfr_div_z(mpfr_t * a, mpfr_t * b, mpz_t * c, SV * round) {
     return newSViv(mpfr_div_z(*a, *b, *c, SvUV(round)));
}

SV * Rmpfr_div_q(mpfr_t * a, mpfr_t * b, mpq_t * c, SV * round) {
     return newSViv(mpfr_div_q(*a, *b, *c, SvUV(round)));
}

SV * Rmpfr_ui_div(mpfr_t * a, SV * b, mpfr_t * c, SV * round) {
     return newSViv(mpfr_ui_div(*a, (unsigned long)SvUV(b), *c, SvUV(round)));
}

SV * Rmpfr_sqrt(mpfr_t * a, mpfr_t * b, SV * round) {
     return newSViv(mpfr_sqrt(*a, *b, SvUV(round)));
}

SV * Rmpfr_cbrt(mpfr_t * a, mpfr_t * b, SV * round) {
     return newSViv(mpfr_cbrt(*a, *b, SvUV(round)));
}

SV * Rmpfr_sqrt_ui(mpfr_t * a, SV * b, SV * round) {
     return newSViv(mpfr_sqrt_ui(*a, (unsigned long)SvUV(b), SvUV(round)));
}

SV * Rmpfr_pow_ui(mpfr_t * a, mpfr_t * b, SV * c, SV * round) {
     return newSViv(mpfr_pow_ui(*a, *b, (unsigned long)SvUV(c), SvUV(round)));
}

SV * Rmpfr_ui_pow_ui(mpfr_t * a, SV * b, SV * c, SV * round) {
     return newSViv(mpfr_ui_pow_ui(*a, (unsigned long)SvUV(b), (unsigned long)SvUV(c), SvUV(round)));
}

SV * Rmpfr_ui_pow(mpfr_t * a, SV * b, mpfr_t * c, SV * round) {
     return newSViv(mpfr_ui_pow(*a, (unsigned long)SvUV(b), *c, SvUV(round)));
}

SV * Rmpfr_pow_si(mpfr_t * a, mpfr_t * b, SV * c, SV * round) {
     return newSViv(mpfr_pow_si(*a, *b, (long)SvIV(c), SvUV(round)));
}

SV * Rmpfr_pow(mpfr_t * a, mpfr_t * b, mpfr_t * c, SV * round) {
     return newSViv(mpfr_pow(*a, *b, *c, SvUV(round)));
}

SV * Rmpfr_neg(mpfr_t * a, mpfr_t * b, SV * round) {
     return newSViv(mpfr_neg(*a, *b, SvUV(round)));
}

SV * Rmpfr_abs(mpfr_t * a, mpfr_t * b, SV * round) {
     return newSViv(mpfr_abs(*a, *b, SvUV(round)));
}

SV * Rmpfr_mul_2exp(mpfr_t * a, mpfr_t * b, SV * c, SV * round) {
     return newSViv(mpfr_mul_2exp(*a, *b, (unsigned long)SvUV(c), SvUV(round)));
}

SV * Rmpfr_mul_2ui(mpfr_t * a, mpfr_t * b, SV * c, SV * round) {
     return newSViv(mpfr_mul_2ui(*a, *b, (unsigned long)SvUV(c), SvUV(round)));
}

SV * Rmpfr_mul_2si(mpfr_t * a, mpfr_t * b, SV * c, SV * round) {
     return newSViv(mpfr_mul_2si(*a, *b, (long)SvIV(c), SvUV(round)));
}

SV * Rmpfr_div_2exp(mpfr_t * a, mpfr_t * b, SV * c, SV * round) {
     return newSViv(mpfr_div_2exp(*a, *b, (unsigned long)SvUV(c), SvUV(round)));
}

SV * Rmpfr_div_2ui(mpfr_t * a, mpfr_t * b, SV * c, SV * round) {
     return newSViv(mpfr_div_2ui(*a, *b, (unsigned long)SvUV(c), SvUV(round)));
}

SV * Rmpfr_div_2si(mpfr_t * a, mpfr_t * b, SV * c, SV * round) {
     return newSViv(mpfr_div_2si(*a, *b, (long)SvIV(c), SvUV(round)));
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
     mpfr_reldiff(*a, *b, *c, SvUV(round));
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
     return newSViv(mpfr_sin_cos(*a, *b, *c, SvUV(round)));
}

SV * Rmpfr_sin(mpfr_t * a, mpfr_t * b, SV * round) {
     return newSViv(mpfr_sin(*a, *b, SvUV(round)));
}

SV * Rmpfr_cos(mpfr_t * a, mpfr_t * b, SV * round) {
     return newSViv(mpfr_cos(*a, *b, SvUV(round)));
}

SV * Rmpfr_tan(mpfr_t * a, mpfr_t * b, SV * round) {
     return newSViv(mpfr_tan(*a, *b, SvUV(round)));
}

SV * Rmpfr_asin(mpfr_t * a, mpfr_t * b, SV * round) {
     return newSViv(mpfr_asin(*a, *b, SvUV(round)));
}

SV * Rmpfr_acos(mpfr_t * a, mpfr_t * b, SV * round) {
     return newSViv(mpfr_acos(*a, *b, SvUV(round)));
}

SV * Rmpfr_atan(mpfr_t * a, mpfr_t * b, SV * round) {
     return newSViv(mpfr_atan(*a, *b, SvUV(round)));
}

SV * Rmpfr_sinh(mpfr_t * a, mpfr_t * b, SV * round) {
     return newSViv(mpfr_sinh(*a, *b, SvUV(round)));
}

SV * Rmpfr_cosh(mpfr_t * a, mpfr_t * b, SV * round) {
     return newSViv(mpfr_cosh(*a, *b, SvUV(round)));
}

SV * Rmpfr_tanh(mpfr_t * a, mpfr_t * b, SV * round) {
     return newSViv(mpfr_tanh(*a, *b, SvUV(round)));
}

SV * Rmpfr_asinh(mpfr_t * a, mpfr_t * b, SV * round) {
     return newSViv(mpfr_asinh(*a, *b, SvUV(round)));
}

SV * Rmpfr_acosh(mpfr_t * a, mpfr_t * b, SV * round) {
     return newSViv(mpfr_acosh(*a, *b, SvUV(round)));
}

SV * Rmpfr_atanh(mpfr_t * a, mpfr_t * b, SV * round) {
     return newSViv(mpfr_atanh(*a, *b, SvUV(round)));
}

SV * Rmpfr_fac_ui(mpfr_t * a, SV * b, SV * round) {
     return newSViv(mpfr_fac_ui(*a, (unsigned long)SvUV(b), SvUV(round)));
}

SV * Rmpfr_log1p(mpfr_t * a, mpfr_t * b, SV * round) {
     return newSViv(mpfr_log1p(*a, *b, SvUV(round)));
}

SV * Rmpfr_expm1(mpfr_t * a, mpfr_t * b, SV * round) {
     return newSViv(mpfr_expm1(*a, *b, SvUV(round)));
}

SV * Rmpfr_log2(mpfr_t * a, mpfr_t * b, SV * round) {
     return newSViv(mpfr_log2(*a, *b, SvUV(round)));
}

SV * Rmpfr_log10(mpfr_t * a, mpfr_t * b, SV * round) {
     return newSViv(mpfr_log10(*a, *b, SvUV(round)));
}

SV * Rmpfr_fma(mpfr_t * a, mpfr_t * b, mpfr_t * c, mpfr_t * d, SV * round) {
     return newSViv(mpfr_fma(*a, *b, *c, *d, SvUV(round)));
}

SV * Rmpfr_fms(mpfr_t * a, mpfr_t * b, mpfr_t * c, mpfr_t * d, SV * round) {
     return newSViv(mpfr_fms(*a, *b, *c, *d, SvUV(round)));
}

SV * Rmpfr_agm(mpfr_t * a, mpfr_t * b, mpfr_t * c, SV * round) {
     return newSViv(mpfr_agm(*a, *b, *c, SvUV(round)));
}

SV * Rmpfr_hypot(mpfr_t * a, mpfr_t * b, mpfr_t * c, SV * round) {
     return newSViv(mpfr_hypot(*a, *b, *c, SvUV(round)));
}

SV * Rmpfr_const_log2(mpfr_t * p, SV * round) {
     return newSViv(mpfr_const_log2(*p, SvUV(round)));
}

SV * Rmpfr_const_pi(mpfr_t * p, SV * round) {
     return newSViv(mpfr_const_pi(*p, SvUV(round)));
}

SV * Rmpfr_const_euler(mpfr_t * p, SV * round) {
     return newSViv(mpfr_const_euler(*p, SvUV(round)));
}

void Rmpfr_print_binary(mpfr_t * p) {
     mpfr_print_binary(*p);
}

SV * Rmpfr_rint(mpfr_t * a, mpfr_t * b, SV * round) {
     return newSViv(mpfr_rint(*a, *b, SvUV(round)));
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
     return newSViv(mpfr_add_one_ulp(*p, SvUV(round)));
} */

/* NO LONGER SUPPORTED
SV * Rmpfr_sub_one_ulp(SV * p, SV * round) {
     return newSViv(mpfr_sub_one_ulp(*p, SvUV(round)));
} */

SV * Rmpfr_can_round(mpfr_t * p, SV * err, SV * round1, SV * round2, SV * prec) {
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
     return newSViv(mpfr_check_range(*p, (int)SvIV(t), SvUV(round)));
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
     return newSViv(mpfr_log(*a, *b, SvUV(round)));
}

SV * Rmpfr_exp(mpfr_t * a, mpfr_t * b, SV * round) {
     return newSViv(mpfr_exp(*a, *b, SvUV(round)));
}

SV * Rmpfr_exp2(mpfr_t * a, mpfr_t * b, SV * round) {
     return newSViv(mpfr_exp2(*a, *b, SvUV(round)));
}

SV * Rmpfr_exp10(mpfr_t * a, mpfr_t * b, SV * round) {
     return newSViv(mpfr_exp10(*a, *b, SvUV(round)));
}

void Rmpfr_urandomb(SV * x, ...) {
     Inline_Stack_Vars;
     unsigned long i, t;

     t = Inline_Stack_Items;
     --t;

     for(i = 0; i < t; ++i) {
        mpfr_urandomb(*(INT2PTR(mpfr_t *, SvIV(SvRV(Inline_Stack_Item(i))))), *(INT2PTR(gmp_randstate_t *, SvIV(SvRV(Inline_Stack_Item(t))))));
        }
}

void Rmpfr_random2(mpfr_t * p, SV * s, SV * exp) {
     mpfr_random2(*p, (int)SvIV(s), (mp_exp_t)SvIV(exp));
}

SV * _Rmpfr_out_str(mpfr_t * p, SV * base, SV * dig, SV * round) {
     size_t ret;
     if(SvIV(base) < 2 || SvIV(base) > 36) croak("2nd argument supplied to Rmpfr_out_str is out of allowable range (must be between 2 and 36 inclusive)");
     ret = mpfr_out_str(NULL, (int)SvIV(base), (size_t)SvUV(dig), *p, SvUV(round));
     fflush(stdout);
     return newSVuv(ret);
}

SV * _Rmpfr_out_str2(mpfr_t * p, SV * base, SV * dig, SV * round, SV * suff) {
     size_t ret;
     if(SvIV(base) < 2 || SvIV(base) > 36) croak("2nd argument supplied to Rmpfr_out_str is out of allowable range (must be between 2 and 36 inclusive)");
     ret = mpfr_out_str(NULL, (int)SvIV(base), (size_t)SvUV(dig), *p, SvUV(round));
     printf("%s", SvPV_nolen(suff));
     fflush(stdout);
     return newSVuv(ret);
}

SV * Rmpfr_inp_str(mpfr_t * p, SV * base, SV * round) {
     if(SvIV(base) < 2 || SvIV(base) > 36) croak("2nd argument supplied to Rmpfr_inp_str is out of allowable range (must be between 2 and 36 inclusive)");
     return newSVuv(mpfr_inp_str(*p, NULL, (int)SvIV(base), SvUV(round)));
}

SV * Rmpfr_gamma(mpfr_t * a, mpfr_t * b, SV * round) {
     return newSViv(mpfr_gamma(*a, *b, SvUV(round)));
}

SV * Rmpfr_zeta(mpfr_t * a, mpfr_t * b, SV * round) {
     return newSViv(mpfr_zeta(*a, *b, SvUV(round)));
}

SV * Rmpfr_erf(mpfr_t * a, mpfr_t * b, SV * round) {
     return newSViv(mpfr_erf(*a, *b, SvUV(round)));
}

SV * Rmpfr_frac(mpfr_t * a, mpfr_t * b, SV * round) {
     return newSViv(mpfr_frac(*a, *b, SvUV(round)));
}

SV * Rmpfr_remainder(mpfr_t * a, mpfr_t * b, mpfr_t * c, SV * round) {
     return newSViv(mpfr_remainder(*a, *b, *c, SvUV(round)));
}

void Rmpfr_remquo(mpfr_t * a, mpfr_t * b, mpfr_t * c, SV * round) {
     Inline_Stack_Vars;
     long ret, q;
     ret = mpfr_remquo(*a, &q, *b, *c, (mp_rnd_t)SvUV(round)); 
     Inline_Stack_Reset;
     Inline_Stack_Push(sv_2mortal(newSViv(q)));
     Inline_Stack_Push(sv_2mortal(newSViv(ret)));
     Inline_Stack_Done;
     Inline_Stack_Return(2);
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
     return newSViv(mpfr_min(*a, *b, *c, SvUV(round)));
}

SV * Rmpfr_max(mpfr_t * a, mpfr_t * b, mpfr_t * c, SV * round) {
     return newSViv(mpfr_max(*a, *b, *c, SvUV(round)));
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
     return newSViv(mpfr_setsign(*rop, *op, SvIV(sign), SvUV(round)));
}

SV * Rmpfr_copysign(mpfr_t * rop, mpfr_t * op1, mpfr_t * op2, SV * round) {
     return newSViv(mpfr_copysign(*rop, *op1, *op2, SvUV(round)));
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

void Rmpfr_get_z(mpz_t * a, mpfr_t * b, SV * round) {
     mpfr_get_z(*a, *b, (mp_rnd_t)SvUV(round));
}

SV * Rmpfr_si_sub(mpfr_t * a, SV * b, mpfr_t * c, SV * round) {
     return newSViv(mpfr_si_sub(*a, (long)SvIV(b), *c, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_sub_si(mpfr_t * a, mpfr_t * b, SV * c, SV * round){
     return newSViv(mpfr_sub_si(*a, *b, (long)SvIV(c), (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_mul_si(mpfr_t * a, mpfr_t * b, SV * c, SV * round){
     return newSViv(mpfr_mul_si(*a, *b, (long)SvIV(c), (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_si_div(mpfr_t * a, SV * b, mpfr_t * c, SV * round) {
     return newSViv(mpfr_si_div(*a, (long)SvIV(b), *c, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_div_si(mpfr_t * a, mpfr_t * b, SV * c, SV * round){
     return newSViv(mpfr_div_si(*a, *b, (long)SvIV(c), (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_sqr(mpfr_t * a, mpfr_t * b, SV * round) {
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
     return newSViv(mpfr_rint_round(*a, *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_rint_trunc(mpfr_t * a, mpfr_t * b, SV * round) {
     return newSViv(mpfr_rint_trunc(*a, *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_rint_ceil(mpfr_t * a, mpfr_t * b, SV * round) {
     return newSViv(mpfr_rint_ceil(*a, *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_rint_floor(mpfr_t * a, mpfr_t * b, SV * round) {
     return newSViv(mpfr_rint_floor(*a, *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_get_ui(mpfr_t * a, SV * round) {
     return newSVuv(mpfr_get_ui(*a, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_get_si(mpfr_t * a, SV * round) {
     return newSViv(mpfr_get_si(*a, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_get_uj(mpfr_t * a, SV * round) {
#ifdef USE_64_BIT_INT
#ifndef _MSC_VER
     return newSVuv(mpfr_get_uj(*a, (mp_rnd_t)SvUV(round)));
#else
     croak ("Rmpfr_get_uj() not implemented on this build of perl - use Rmpfr_integer_string() instead");
#endif
#else
     croak ("Rmpfr_get_uj() not implemented on this build of perl");
#endif
}

SV * Rmpfr_get_sj(mpfr_t * a, SV * round) {
#ifdef USE_64_BIT_INT
#ifndef _MSC_VER
     return newSViv(mpfr_get_sj(*a, (mp_rnd_t)SvUV(round)));
#else
     croak ("Rmpfr_get_sj() not implemented on this build of perl - use Rmpfr_integer_string() instead");
#endif
#else
     croak ("Rmpfr_get_sj() not implemented on this build of perl");
#endif
}

SV * Rmpfr_fits_ulong_p(mpfr_t * a, SV * round) {
     return newSVuv(mpfr_fits_ulong_p(*a, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_fits_slong_p(mpfr_t * a, SV * round) {
     return newSVuv(mpfr_fits_slong_p(*a, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_strtofr(mpfr_t * a, SV * str, SV * base, SV * round) {
     int b = (int)SvIV(base);
     //char ** endptr;
     if(b < 0 || b > 36 || b == 1) croak("3rd argument supplied to Rmpfr_strtofr is out of allowable range");
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
     return newSViv(mpfr_erfc(*a, *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_j0(mpfr_t * a, mpfr_t * b, SV * round) {
     return newSViv(mpfr_j0(*a, *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_j1(mpfr_t * a, mpfr_t * b, SV * round) {
     return newSViv(mpfr_j1(*a, *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_jn(mpfr_t * a, SV * n, mpfr_t * b, SV * round) {
     return newSViv(mpfr_jn(*a, (long)SvIV(n), *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_y0(mpfr_t * a, mpfr_t * b, SV * round) {
     return newSViv(mpfr_y0(*a, *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_y1(mpfr_t * a, mpfr_t * b, SV * round) {
     return newSViv(mpfr_y1(*a, *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_yn(mpfr_t * a, SV * n, mpfr_t * b, SV * round) {
     return newSViv(mpfr_yn(*a, (long)SvIV(n), *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_atan2(mpfr_t * a, mpfr_t * b, mpfr_t * c, SV * round) {
     return newSViv(mpfr_atan2(*a, *b, *c, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_pow_z(mpfr_t * a, mpfr_t * b, mpz_t * c,  SV * round) {
     return newSViv(mpfr_pow_z(*a, *b, *c, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_subnormalize(mpfr_t * a, SV * b, SV * round) {
     return newSViv(mpfr_subnormalize(*a, (int)SvIV(b), (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_const_catalan(mpfr_t * a, SV * round) {
     return newSViv(mpfr_const_catalan(*a, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_sec(mpfr_t * a, mpfr_t * b, SV * round) {
     return newSViv(mpfr_sec(*a, *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_csc(mpfr_t * a, mpfr_t * b, SV * round) {
     return newSViv(mpfr_csc(*a, *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_cot(mpfr_t * a, mpfr_t * b, SV * round) {
     return newSViv(mpfr_cot(*a, *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_root(mpfr_t * a, mpfr_t * b, SV * c, SV * round) {
     return newSViv(mpfr_root(*a, *b, (unsigned long)SvUV(c), (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_eint(mpfr_t * a, mpfr_t * b, SV * round) {
     return newSViv(mpfr_eint(*a, *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_get_f(mpf_t * a, mpfr_t * b, SV * round) {
     return newSViv(mpfr_get_f(*a, *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_sech(mpfr_t * a, mpfr_t * b, SV * round) {
     return newSViv(mpfr_sech(*a, *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_csch(mpfr_t * a, mpfr_t * b, SV * round) {
     return newSViv(mpfr_csch(*a, *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_coth(mpfr_t * a, mpfr_t * b, SV * round) {
     return newSViv(mpfr_coth(*a, *b, (mp_rnd_t)SvUV(round)));
}

SV * Rmpfr_lngamma(mpfr_t * a, mpfr_t * b, SV * round) {
     return newSViv(mpfr_lngamma(*a, *b, (mp_rnd_t)SvUV(round)));
}

void Rmpfr_lgamma(mpfr_t * a, mpfr_t * b, SV * round) {
     Inline_Stack_Vars;
     int ret, signp;
     ret = mpfr_lgamma(*a, &signp, *b, (mp_rnd_t)SvUV(round)); 
     Inline_Stack_Reset;
     Inline_Stack_Push(sv_2mortal(newSViv(signp)));
     Inline_Stack_Push(sv_2mortal(newSViv(ret)));
     Inline_Stack_Done;
     Inline_Stack_Return(2);
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

     mpfr_init_set(*mpfr_t_obj, *p, __gmpfr_default_rounding_mode);
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

     if(mpfr_nan_p(*a)) return newSVuv(0);

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

     if(mpfr_nan_p(*a)) return newSVuv(0);

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

     if(mpfr_nan_p(*a)) return newSVuv(0);

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

     if(mpfr_nan_p(*a)) return newSVuv(0);

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

     if(mpfr_nan_p(*a)) return newSVuv(0);

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

     if(mpfr_nan_p(*a)) return newSVuv(1);

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

     if(mpfr_cmp_ui(*p, 0) < 0) croak("Negative value supplied as argument to overload_sqrt");
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


MODULE = Math::MPFR	PACKAGE = Math::MPFR	

PROTOTYPES: DISABLE


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
Rmpfr_get_ld (p, round)
	mpfr_t *	p
	SV *	round

SV *
Rmpfr_get_d1 (p)
	mpfr_t *	p

SV *
Rmpfr_get_z_exp (z, p)
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
Rmpfr_sqrt (a, b, round)
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
_Rmpfr_out_str (p, base, dig, round)
	mpfr_t *	p
	SV *	base
	SV *	dig
	SV *	round

SV *
_Rmpfr_out_str2 (p, base, dig, round, suff)
	mpfr_t *	p
	SV *	base
	SV *	dig
	SV *	round
	SV *	suff

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

void
Rmpfr_get_z (a, b, round)
	mpz_t *	a
	mpfr_t *	b
	SV *	round
	PREINIT:
	I32* temp;
	PPCODE:
	temp = PL_markstack_ptr++;
	Rmpfr_get_z(a, b, round);
	if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
	  PL_markstack_ptr = temp;
	  XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
	return; /* assume stack size is correct */

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
Rmpfr_fits_ulong_p (a, round)
	mpfr_t *	a
	SV *	round

SV *
Rmpfr_fits_slong_p (a, round)
	mpfr_t *	a
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

int
_has_inttypes ()

