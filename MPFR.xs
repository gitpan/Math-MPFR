#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include "INLINE.h"
#include <stdio.h>
#include <gmp.h>
#include <mpfr.h>

#ifdef OLDPERL
#define SvUOK SvIsUV
#endif

void Rmpfr_set_default_rounding_mode(SV * round) {
     mpfr_set_default_rounding_mode(SvUV(round));    
}

SV * Rmpfr_get_default_rounding_mode() {
     return newSViv(__gmpfr_default_rounding_mode);
}

SV * Rmpfr_prec_round(SV * p, SV * prec, SV * round) {
     return newSViv(mpfr_prec_round(*((mpfr_t *) SvIV(SvRV(p))), SvUV(prec), SvUV(round)));
}

void DESTROY(SV * p) {
     mpfr_clear(*((mpfr_t *) SvIV(SvRV(p))));
     Safefree((mpfr_t *) SvIV(SvRV(p)));
}

void Rmpfr_clear(SV * p) {
     mpfr_clear(*((mpfr_t *) SvIV(SvRV(p))));
     Safefree((mpfr_t *) SvIV(SvRV(p)));
}

void Rmpfr_clear_mpfr(SV * p) {
     mpfr_clear(*((mpfr_t *) SvIV(SvRV(p))));
}

void Rmpfr_clear_ptr(SV * p) {
     Safefree((mpfr_t *) SvIV(SvRV(p)));
}

SV * Rmpfr_init() {
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;

     New(1, mpfr_t_obj, sizeof(mpfr_t), mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in Rmpfr_init function");
     obj_ref = newSViv(0);
     obj = newSVrv(obj_ref, "Math::MPFR");
     mpfr_init(*mpfr_t_obj);

     sv_setiv(obj, (IV)mpfr_t_obj);
     SvREADONLY_on(obj);
     return obj_ref;
}

SV * Rmpfr_init2(SV * prec) {
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;

     New(1, mpfr_t_obj, sizeof(mpfr_t), mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in Rmpfr_init2 function");
     obj_ref = newSViv(0);
     obj = newSVrv(obj_ref, "Math::MPFR");
     mpfr_init2 (*mpfr_t_obj, SvUV(prec));

     sv_setiv(obj, (IV)mpfr_t_obj);
     SvREADONLY_on(obj);
     return obj_ref;
}

SV * Rmpfr_init_nobless() {
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;

     New(1, mpfr_t_obj, sizeof(mpfr_t), mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in Rmpfr_init_nobless function");
     obj_ref = newSViv(0);
     obj = newSVrv(obj_ref, NULL);
     mpfr_init(*mpfr_t_obj);

     sv_setiv(obj, (IV)mpfr_t_obj);
     SvREADONLY_on(obj);
     return obj_ref;
}

SV * Rmpfr_init2_nobless(SV * prec) {
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;

     New(1, mpfr_t_obj, sizeof(mpfr_t), mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in Rmpfr_init2_nobless function");
     obj_ref = newSViv(0);
     obj = newSVrv(obj_ref, NULL);
     mpfr_init2 (*mpfr_t_obj, SvUV(prec));

     sv_setiv(obj, (IV)mpfr_t_obj);
     SvREADONLY_on(obj);
     return obj_ref;
}

void Rmpfr_init_set(SV * q, SV * round) {
     Inline_Stack_Vars;
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;
     int ret;

     Inline_Stack_Reset;

     New(1, mpfr_t_obj, sizeof(mpfr_t), mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in Rmpfr_init_set function");
     obj_ref = newSViv(0);
     obj = newSVrv(obj_ref, "Math::MPFR");
     ret = mpfr_init_set(*mpfr_t_obj, *((mpfr_t *) SvIV(SvRV(q))), SvUV(round));

     sv_setiv(obj, (IV)mpfr_t_obj);
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

     New(1, mpfr_t_obj, sizeof(mpfr_t), mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in Rmpfr_init_set_ui function");
     obj_ref = newSViv(0);
     obj = newSVrv(obj_ref, "Math::MPFR");
     ret = mpfr_init_set_ui(*mpfr_t_obj, SvUV(q), SvUV(round));

     sv_setiv(obj, (IV)mpfr_t_obj);
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

     New(1, mpfr_t_obj, sizeof(mpfr_t), mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in Rmpfr_init_set_si function");
     obj_ref = newSViv(0);
     obj = newSVrv(obj_ref, "Math::MPFR");
     ret = mpfr_init_set_si(*mpfr_t_obj, SvIV(q), SvUV(round));

     sv_setiv(obj, (IV)mpfr_t_obj);
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

     New(1, mpfr_t_obj, sizeof(mpfr_t), mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in Rmpfr_init_set_d function");
     obj_ref = newSViv(0);
     obj = newSVrv(obj_ref, "Math::MPFR");
     ret = mpfr_init_set_d(*mpfr_t_obj, SvNV(q), SvUV(round));

     sv_setiv(obj, (IV)mpfr_t_obj);
     SvREADONLY_on(obj);
     Inline_Stack_Push(sv_2mortal(obj_ref));
     Inline_Stack_Push(sv_2mortal(newSViv(ret)));
     Inline_Stack_Done;
     Inline_Stack_Return(2);
}

void Rmpfr_init_set_f(SV * q, SV * round) {
     Inline_Stack_Vars;
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;
     int ret;

     Inline_Stack_Reset;

     New(1, mpfr_t_obj, sizeof(mpfr_t), mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in Rmpfr_init_set_f function");
     obj_ref = newSViv(0);
     obj = newSVrv(obj_ref, "Math::MPFR");
     ret = mpfr_init_set_f(*mpfr_t_obj, *((mpf_t *) SvIV(SvRV(q))), SvUV(round));

     sv_setiv(obj, (IV)mpfr_t_obj);
     SvREADONLY_on(obj);
     Inline_Stack_Push(sv_2mortal(obj_ref));
     Inline_Stack_Push(sv_2mortal(newSViv(ret)));
     Inline_Stack_Done;
     Inline_Stack_Return(2);
}

void Rmpfr_init_set_z(SV * q, SV * round) {
     Inline_Stack_Vars;
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;
     int ret;

     Inline_Stack_Reset;

     New(1, mpfr_t_obj, sizeof(mpfr_t), mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in Rmpfr_init_set_z function");
     obj_ref = newSViv(0);
     obj = newSVrv(obj_ref, "Math::MPFR");
     ret = mpfr_init_set_z(*mpfr_t_obj, *((mpz_t *) SvIV(SvRV(q))), SvUV(round));

     sv_setiv(obj, (IV)mpfr_t_obj);
     SvREADONLY_on(obj);
     Inline_Stack_Push(sv_2mortal(obj_ref));
     Inline_Stack_Push(sv_2mortal(newSViv(ret)));
     Inline_Stack_Done;
     Inline_Stack_Return(2);
}

void Rmpfr_init_set_q(SV * q, SV * round) {
     Inline_Stack_Vars;
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;
     int ret;

     Inline_Stack_Reset;

     New(1, mpfr_t_obj, sizeof(mpfr_t), mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in Rmpfr_init_set_q function");
     obj_ref = newSViv(0);
     obj = newSVrv(obj_ref, "Math::MPFR");
     ret = mpfr_init_set_q(*mpfr_t_obj, *((mpq_t *) SvIV(SvRV(q))), SvUV(round));

     sv_setiv(obj, (IV)mpfr_t_obj);
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
     int ret;

     Inline_Stack_Reset;

     New(1, mpfr_t_obj, sizeof(mpfr_t), mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in Rmpfr_init_set_str function");
     obj_ref = newSViv(0);
     obj = newSVrv(obj_ref, "Math::MPFR");
     ret = mpfr_init_set_str(*mpfr_t_obj, SvPV_nolen(q), SvIV(base), SvUV(round));

     sv_setiv(obj, (IV)mpfr_t_obj);
     SvREADONLY_on(obj);
     Inline_Stack_Push(sv_2mortal(obj_ref));
     Inline_Stack_Push(sv_2mortal(newSViv(ret)));
     Inline_Stack_Done;
     Inline_Stack_Return(2);
}

void Rmpfr_init_set_nobless(SV * q, SV * round) {
     Inline_Stack_Vars;
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;
     int ret;

     Inline_Stack_Reset;

     New(1, mpfr_t_obj, sizeof(mpfr_t), mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in Rmpfr_init_set_nobless function");
     obj_ref = newSViv(0);
     obj = newSVrv(obj_ref, NULL);
     ret = mpfr_init_set(*mpfr_t_obj, *((mpfr_t *) SvIV(SvRV(q))), SvUV(round));

     sv_setiv(obj, (IV)mpfr_t_obj);
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

     New(1, mpfr_t_obj, sizeof(mpfr_t), mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in Rmpfr_init_set_ui_nobless function");
     obj_ref = newSViv(0);
     obj = newSVrv(obj_ref, NULL);
     ret = mpfr_init_set_ui(*mpfr_t_obj, SvUV(q), SvUV(round));

     sv_setiv(obj, (IV)mpfr_t_obj);
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

     New(1, mpfr_t_obj, sizeof(mpfr_t), mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in Rmpfr_init_set_si_nobless function");
     obj_ref = newSViv(0);
     obj = newSVrv(obj_ref, NULL);
     ret = mpfr_init_set_si(*mpfr_t_obj, SvIV(q), SvUV(round));

     sv_setiv(obj, (IV)mpfr_t_obj);
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

     New(1, mpfr_t_obj, sizeof(mpfr_t), mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in Rmpfr_init_set_d_nobless function");
     obj_ref = newSViv(0);
     obj = newSVrv(obj_ref, NULL);
     ret = mpfr_init_set_d(*mpfr_t_obj, SvNV(q), SvUV(round));

     sv_setiv(obj, (IV)mpfr_t_obj);
     SvREADONLY_on(obj);
     Inline_Stack_Push(sv_2mortal(obj_ref));
     Inline_Stack_Push(sv_2mortal(newSViv(ret)));
     Inline_Stack_Done;
     Inline_Stack_Return(2);
}

void Rmpfr_init_set_f_nobless(SV * q, SV * round) {
     Inline_Stack_Vars;
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;
     int ret;

     Inline_Stack_Reset;

     New(1, mpfr_t_obj, sizeof(mpfr_t), mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in Rmpfr_init_set_f_nobless function");
     obj_ref = newSViv(0);
     obj = newSVrv(obj_ref, NULL);
     ret = mpfr_init_set_f(*mpfr_t_obj, *((mpf_t *) SvIV(SvRV(q))), SvUV(round));

     sv_setiv(obj, (IV)mpfr_t_obj);
     SvREADONLY_on(obj);
     Inline_Stack_Push(sv_2mortal(obj_ref));
     Inline_Stack_Push(sv_2mortal(newSViv(ret)));
     Inline_Stack_Done;
     Inline_Stack_Return(2);
}

void Rmpfr_init_set_z_nobless(SV * q, SV * round) {
     Inline_Stack_Vars;
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;
     int ret;

     Inline_Stack_Reset;

     New(1, mpfr_t_obj, sizeof(mpfr_t), mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in Rmpfr_init_set_z_nobless function");
     obj_ref = newSViv(0);
     obj = newSVrv(obj_ref, NULL);
     ret = mpfr_init_set_z(*mpfr_t_obj, *((mpz_t *) SvIV(SvRV(q))), SvUV(round));

     sv_setiv(obj, (IV)mpfr_t_obj);
     SvREADONLY_on(obj);
     Inline_Stack_Push(sv_2mortal(obj_ref));
     Inline_Stack_Push(sv_2mortal(newSViv(ret)));
     Inline_Stack_Done;
     Inline_Stack_Return(2);
}

void Rmpfr_init_set_q_nobless(SV * q, SV * round) {
     Inline_Stack_Vars;
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;
     int ret;

     Inline_Stack_Reset;

     New(1, mpfr_t_obj, sizeof(mpfr_t), mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in Rmpfr_init_set_q_nobless function");
     obj_ref = newSViv(0);
     obj = newSVrv(obj_ref, NULL);
     ret = mpfr_init_set_q(*mpfr_t_obj, *((mpq_t *) SvIV(SvRV(q))), SvUV(round));

     sv_setiv(obj, (IV)mpfr_t_obj);
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
     int ret;

     Inline_Stack_Reset;

     New(1, mpfr_t_obj, sizeof(mpfr_t), mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in Rmpfr_init_set_str_nobless function");
     obj_ref = newSViv(0);
     obj = newSVrv(obj_ref, NULL);
     ret = mpfr_init_set_str(*mpfr_t_obj, SvPV_nolen(q), SvIV(base), SvUV(round));

     sv_setiv(obj, (IV)mpfr_t_obj);
     SvREADONLY_on(obj);
     Inline_Stack_Push(sv_2mortal(obj_ref));
     Inline_Stack_Push(sv_2mortal(newSViv(ret)));
     Inline_Stack_Done;
     Inline_Stack_Return(2);
}

void Rmpfr_deref2(SV * p, SV * base, SV * n_digits, SV * round) {
     Inline_Stack_Vars;
     char * out;
     mp_exp_t ptr, *expptr;
     unsigned long b = SvUV(base), n_dig = SvUV(n_digits);

     expptr = &ptr;

     if(!n_dig) {
        n_dig = (double)(mpfr_get_prec(*((mpfr_t *) SvIV(SvRV(p))))) / log(b) * log(2);
        }

     if(b < 2 || b > 36) croak("Second argument supplied to Rmpfr_get_str() is not in acceptable range");

     New(2, out, n_dig + 5 , char);
     if(out == NULL) croak("Failed to allocate memory in Rmpfr_get_str function");

     mpfr_get_str(out, expptr, b, n_dig, *((mpfr_t *) SvIV(SvRV(p))), SvUV(round));

     Inline_Stack_Reset;
     Inline_Stack_Push(sv_2mortal(newSVpv(out, 0)));
     Safefree(out);
     Inline_Stack_Push(sv_2mortal(newSViv(ptr)));
     Inline_Stack_Done;
     Inline_Stack_Return(2);
}

void Rmpfr_set_default_prec(SV * prec) {
     mpfr_set_default_prec(SvUV(prec));
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

void Rmpfr_set_prec(SV * p, SV * prec) {
     mpfr_set_prec(*((mpfr_t *) SvIV(SvRV(p))), SvUV(prec));
}

void Rmpfr_set_prec_raw(SV * p, SV * prec) {
     mpfr_set_prec_raw(*((mpfr_t *) SvIV(SvRV(p))), SvUV(prec));
}

SV * Rmpfr_get_prec(SV * p) {
     return newSVuv(mpfr_get_prec(*((mpfr_t *) SvIV(SvRV(p)))));
}

SV * Rmpfr_set(SV * p, SV * q, SV * round) {
     return newSViv(mpfr_set(*((mpfr_t *) SvIV(SvRV(p))), *((mpfr_t *) SvIV(SvRV(q))), SvUV(round)));
}

SV * Rmpfr_set_ui(SV * p, SV * q, SV * round) {
     return newSViv(mpfr_set_ui(*((mpfr_t *) SvIV(SvRV(p))), SvUV(q), SvUV(round)));
}

SV * Rmpfr_set_si(SV * p, SV * q, SV * round) {
     return newSViv(mpfr_set_si(*((mpfr_t *) SvIV(SvRV(p))), SvIV(q), SvUV(round)));
}

SV * Rmpfr_set_d(SV * p, SV * q, SV * round) {
     return newSViv(mpfr_set_d(*((mpfr_t *) SvIV(SvRV(p))), SvNV(q), SvUV(round)));
}

SV * Rmpfr_set_z(SV * p, SV * q, SV * round) {
     return newSViv(mpfr_set_z(*((mpfr_t *) SvIV(SvRV(p))), *((mpz_t *) SvIV(SvRV(q))), SvUV(round)));
}

SV * Rmpfr_set_q(SV * p, SV * q, SV * round) {
     return newSViv(mpfr_set_q(*((mpfr_t *) SvIV(SvRV(p))), *((mpq_t *) SvIV(SvRV(q))), SvUV(round)));
}

SV * Rmpfr_set_f(SV * p, SV * q, SV * round) {
     return newSViv(mpfr_set_f(*((mpfr_t *) SvIV(SvRV(p))), *((mpf_t *) SvIV(SvRV(q))), SvUV(round)));
}

SV * Rmpfr_set_str(SV * p, SV * num, SV * base, SV * round) {
     return newSViv(mpfr_set_str(*((mpfr_t *) SvIV(SvRV(p))), SvPV_nolen(num), SvUV(base), SvUV(round)));
}

void Rmpfr_set_str_binary(SV * p, SV * str) {
     mpfr_set_str_binary(*((mpfr_t *) SvIV(SvRV(p))), SvPV_nolen(str));
}

void Rmpfr_set_inf(SV * p, SV * sign) {
     mpfr_set_inf(*((mpfr_t *) SvIV(SvRV(p))), SvIV(sign));
}

void Rmpfr_set_nan(SV * p) {
     mpfr_set_nan(*((mpfr_t *) SvIV(SvRV(p))));
}

void Rmpfr_swap(SV *p, SV * q) {
     mpfr_swap(*((mpfr_t *) SvIV(SvRV(p))), *((mpfr_t *) SvIV(SvRV(q))));
}

SV * Rmpfr_get_d(SV * p, SV * round){
     return newSVnv(mpfr_get_d(*((mpfr_t *) SvIV(SvRV(p))), SvUV(round)));
}

SV * Rmpfr_get_d1(SV * p) {
     return newSVnv(mpfr_get_d1(*((mpfr_t *) SvIV(SvRV(p)))));
}

SV * Rmpfr_get_z_exp(SV * z, SV * p){
     return newSViv(mpfr_get_z_exp(*((mpz_t *) SvIV(SvRV(z))), *((mpfr_t *) SvIV(SvRV(p)))));
}

SV * Rmpfr_add(SV * a, SV * b, SV * c, SV * round) {
     return newSViv(mpfr_add(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), *((mpfr_t *) SvIV(SvRV(c))), SvUV(round)));
}

SV * Rmpfr_add_ui(SV * a, SV * b, SV * c, SV * round){
     return newSViv(mpfr_add_ui(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), SvUV(c), SvUV(round)));
}

SV * Rmpfr_add_z(SV * a, SV * b, SV * c, SV * round) {
     return newSViv(mpfr_add_z(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), *((mpz_t *) SvIV(SvRV(c))), SvUV(round)));
}

SV * Rmpfr_add_q(SV * a, SV * b, SV * c, SV * round) {
     return newSViv(mpfr_add_q(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), *((mpq_t *) SvIV(SvRV(c))), SvUV(round)));
}

SV * Rmpfr_sub(SV * a, SV * b, SV * c, SV * round) {
     return newSViv(mpfr_sub(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), *((mpfr_t *) SvIV(SvRV(c))), SvUV(round)));
}

SV * Rmpfr_sub_ui(SV * a, SV * b, SV * c, SV * round) {
     return newSViv(mpfr_sub_ui(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), SvUV(c), SvUV(round)));
}

SV * Rmpfr_sub_z(SV * a, SV * b, SV * c, SV * round) {
     return newSViv(mpfr_sub_z(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), *((mpz_t *) SvIV(SvRV(c))), SvUV(round)));
}

SV * Rmpfr_sub_q(SV * a, SV * b, SV * c, SV * round) {
     return newSViv(mpfr_sub_q(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), *((mpq_t *) SvIV(SvRV(c))), SvUV(round)));
}

SV * Rmpfr_ui_sub(SV * a, SV * b, SV * c, SV * round) {
     return newSViv(mpfr_ui_sub(*((mpfr_t *) SvIV(SvRV(a))), SvUV(b), *((mpfr_t *) SvIV(SvRV(c))), SvUV(round)));
}

SV * Rmpfr_mul(SV * a, SV * b, SV * c, SV * round) {
     return newSViv(mpfr_mul(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), *((mpfr_t *) SvIV(SvRV(c))), SvUV(round)));
}

SV * Rmpfr_mul_ui(SV * a, SV * b, SV * c, SV * round){
     return newSViv(mpfr_mul_ui(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), SvUV(c), SvUV(round)));
}

SV * Rmpfr_mul_z(SV * a, SV * b, SV * c, SV * round) {
     return newSViv(mpfr_mul_z(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), *((mpz_t *) SvIV(SvRV(c))), SvUV(round)));
}

SV * Rmpfr_mul_q(SV * a, SV * b, SV * c, SV * round) {
     return newSViv(mpfr_mul_q(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), *((mpq_t *) SvIV(SvRV(c))), SvUV(round)));
}

SV * Rmpfr_div(SV * a, SV * b, SV * c, SV * round) {
     return newSViv(mpfr_div(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), *((mpfr_t *) SvIV(SvRV(c))), SvUV(round)));
}

SV * Rmpfr_div_ui(SV * a, SV * b, SV * c, SV * round){
     return newSViv(mpfr_div_ui(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), SvUV(c), SvUV(round)));
}

SV * Rmpfr_div_z(SV * a, SV * b, SV * c, SV * round) {
     return newSViv(mpfr_div_z(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), *((mpz_t *) SvIV(SvRV(c))), SvUV(round)));
}

SV * Rmpfr_div_q(SV * a, SV * b, SV * c, SV * round) {
     return newSViv(mpfr_div_q(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), *((mpq_t *) SvIV(SvRV(c))), SvUV(round)));
}

SV * Rmpfr_ui_div(SV * a, SV * b, SV * c, SV * round) {
     return newSViv(mpfr_ui_div(*((mpfr_t *) SvIV(SvRV(a))), SvUV(b), *((mpfr_t *) SvIV(SvRV(c))), SvUV(round)));
}

SV * Rmpfr_sqrt(SV * a, SV * b, SV * round) {
     return newSViv(mpfr_sqrt(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), SvUV(round)));
}

SV * Rmpfr_cbrt(SV * a, SV * b, SV * round) {
     return newSViv(mpfr_cbrt(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), SvUV(round)));
}

SV * Rmpfr_sqrt_ui(SV * a, SV * b, SV * round) {
     return newSViv(mpfr_sqrt_ui(*((mpfr_t *) SvIV(SvRV(a))), SvUV(b), SvUV(round)));
}

SV * Rmpfr_pow_ui(SV * a, SV * b, SV * c, SV * round) {
     return newSViv(mpfr_pow_ui(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), SvUV(c), SvUV(round)));
}

SV * Rmpfr_ui_pow_ui(SV * a, SV * b, SV * c, SV * round) {
     return newSViv(mpfr_ui_pow_ui(*((mpfr_t *) SvIV(SvRV(a))), SvUV(b), SvUV(c), SvUV(round)));
}

SV * Rmpfr_ui_pow(SV * a, SV * b, SV * c, SV * round) {
     return newSViv(mpfr_ui_pow(*((mpfr_t *) SvIV(SvRV(a))), SvUV(b), *((mpfr_t *) SvIV(SvRV(c))), SvUV(round)));
}

SV * Rmpfr_pow_si(SV * a, SV * b, SV * c, SV * round) {
     return newSViv(mpfr_pow_si(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), SvIV(c), SvUV(round)));
}

SV * Rmpfr_pow(SV * a, SV * b, SV * c, SV * round) {
     return newSViv(mpfr_pow(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), *((mpfr_t *) SvIV(SvRV(c))), SvUV(round)));
}

SV * Rmpfr_neg(SV * a, SV * b, SV * round) {
     return newSViv(mpfr_neg(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), SvUV(round)));
}

SV * Rmpfr_abs(SV * a, SV * b, SV * round) {
     return newSViv(mpfr_abs(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), SvUV(round)));
}

SV * Rmpfr_mul_2exp(SV * a, SV * b, SV * c, SV * round) {
     return newSViv(mpfr_mul_2exp(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), SvUV(c), SvUV(round)));
}

SV * Rmpfr_mul_2ui(SV * a, SV * b, SV * c, SV * round) {
     return newSViv(mpfr_mul_2ui(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), SvUV(c), SvUV(round)));
}

SV * Rmpfr_mul_2si(SV * a, SV * b, SV * c, SV * round) {
     return newSViv(mpfr_mul_2si(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), SvIV(c), SvUV(round)));
}

SV * Rmpfr_div_2exp(SV * a, SV * b, SV * c, SV * round) {
     return newSViv(mpfr_div_2exp(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), SvUV(c), SvUV(round)));
}

SV * Rmpfr_div_2ui(SV * a, SV * b, SV * c, SV * round) {
     return newSViv(mpfr_div_2ui(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), SvUV(c), SvUV(round)));
}

SV * Rmpfr_div_2si(SV * a, SV * b, SV * c, SV * round) {
     return newSViv(mpfr_div_2si(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), SvIV(c), SvUV(round)));
}

SV * Rmpfr_cmp(SV * a, SV * b) {
     return newSViv(mpfr_cmp(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b)))));
}

SV * Rmpfr_cmpabs(SV * a, SV * b) {
     return newSViv(mpfr_cmpabs(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b)))));
}

SV * Rmpfr_cmp_ui(SV * a, SV * b) {
     return newSViv(mpfr_cmp_ui(*((mpfr_t *) SvIV(SvRV(a))), SvUV(b)));
}

SV * Rmpfr_cmp_si(SV * a, SV * b) {
     return newSViv(mpfr_cmp_si(*((mpfr_t *) SvIV(SvRV(a))), SvIV(b)));
}

SV * Rmpfr_cmp_ui_2exp(SV * a, SV * b, SV * c) {
     return newSViv(mpfr_cmp_ui_2exp(*((mpfr_t *) SvIV(SvRV(a))), SvUV(b), SvIV(c)));
}

SV * Rmpfr_cmp_si_2exp(SV * a, SV * b, SV * c) {
     return newSViv(mpfr_cmp_si_2exp(*((mpfr_t *) SvIV(SvRV(a))), SvIV(b), SvIV(c)));
}

SV * Rmpfr_eq(SV * a, SV * b, SV * c) {
     return newSViv(mpfr_eq(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), SvUV(c)));
}

SV * Rmpfr_nan_p(SV * p) {
     return newSViv(mpfr_nan_p(*((mpfr_t *) SvIV(SvRV(p)))));
}

SV * Rmpfr_inf_p(SV * p) {
     return newSViv(mpfr_inf_p(*((mpfr_t *) SvIV(SvRV(p)))));
}

SV * Rmpfr_number_p(SV * p) {
     return newSViv(mpfr_number_p(*((mpfr_t *) SvIV(SvRV(p)))));
}

void Rmpfr_reldiff(SV * a, SV * b, SV * c, SV * round) {
     mpfr_reldiff(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), *((mpfr_t *) SvIV(SvRV(c))), SvUV(round));
}

SV * Rmpfr_sgn(SV * p) {
     return newSViv(mpfr_sgn(*((mpfr_t *) SvIV(SvRV(p)))));
}

SV * Rmpfr_greater_p(SV * a, SV * b) {
     return newSViv(mpfr_greater_p(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b)))));
}

SV * Rmpfr_greaterequal_p(SV * a, SV * b) {
     return newSViv(mpfr_greaterequal_p(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b)))));
}

SV * Rmpfr_less_p(SV * a, SV * b) {
     return newSViv(mpfr_less_p(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b)))));
}

SV * Rmpfr_lessequal_p(SV * a, SV * b) {
     return newSViv(mpfr_lessequal_p(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b)))));
}

SV * Rmpfr_lessgreater_p(SV * a, SV * b) {
     return newSViv(mpfr_lessgreater_p(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b)))));
}

SV * Rmpfr_equal_p(SV * a, SV * b) {
     return newSViv(mpfr_equal_p(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b)))));
}

SV * Rmpfr_unordered_p(SV * a, SV * b) {
     return newSViv(mpfr_unordered_p(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b)))));
}

SV * Rmpfr_sin_cos(SV * a, SV * b, SV * c, SV * round) {
     return newSViv(mpfr_sin_cos(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), *((mpfr_t *) SvIV(SvRV(c))), SvUV(round)));
}

SV * Rmpfr_sin(SV * a, SV * b, SV * round) {
     return newSViv(mpfr_sin(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), SvUV(round)));
}

SV * Rmpfr_cos(SV * a, SV * b, SV * round) {
     return newSViv(mpfr_cos(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), SvUV(round)));
}

SV * Rmpfr_tan(SV * a, SV * b, SV * round) {
     return newSViv(mpfr_tan(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), SvUV(round)));
}

SV * Rmpfr_asin(SV * a, SV * b, SV * round) {
     return newSViv(mpfr_asin(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), SvUV(round)));
}

SV * Rmpfr_acos(SV * a, SV * b, SV * round) {
     return newSViv(mpfr_acos(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), SvUV(round)));
}

SV * Rmpfr_atan(SV * a, SV * b, SV * round) {
     return newSViv(mpfr_atan(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), SvUV(round)));
}

SV * Rmpfr_sinh(SV * a, SV * b, SV * round) {
     return newSViv(mpfr_sinh(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), SvUV(round)));
}

SV * Rmpfr_cosh(SV * a, SV * b, SV * round) {
     return newSViv(mpfr_cosh(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), SvUV(round)));
}

SV * Rmpfr_tanh(SV * a, SV * b, SV * round) {
     return newSViv(mpfr_tanh(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), SvUV(round)));
}

SV * Rmpfr_asinh(SV * a, SV * b, SV * round) {
     return newSViv(mpfr_asinh(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), SvUV(round)));
}

SV * Rmpfr_acosh(SV * a, SV * b, SV * round) {
     return newSViv(mpfr_acosh(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), SvUV(round)));
}

SV * Rmpfr_atanh(SV * a, SV * b, SV * round) {
     return newSViv(mpfr_atanh(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), SvUV(round)));
}

SV * Rmpfr_fac_ui(SV * a, SV * b, SV * round) {
     return newSViv(mpfr_fac_ui(*((mpfr_t *) SvIV(SvRV(a))), SvUV(b), SvUV(round)));
}

SV * Rmpfr_log1p(SV * a, SV * b, SV * round) {
     return newSViv(mpfr_log1p(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), SvUV(round)));
}

SV * Rmpfr_expm1(SV * a, SV * b, SV * round) {
     return newSViv(mpfr_expm1(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), SvUV(round)));
}

SV * Rmpfr_log2(SV * a, SV * b, SV * round) {
     return newSViv(mpfr_log2(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), SvUV(round)));
}

SV * Rmpfr_log10(SV * a, SV * b, SV * round) {
     return newSViv(mpfr_log10(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), SvUV(round)));
}

SV * Rmpfr_fma(SV * a, SV * b, SV * c, SV * d, SV * round) {
     return newSViv(mpfr_fma(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), *((mpfr_t *) SvIV(SvRV(c))), *((mpfr_t *) SvIV(SvRV(d))), SvUV(round)));
}

SV * Rmpfr_agm(SV * a, SV * b, SV * c, SV * round) {
     return newSViv(mpfr_agm(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), *((mpfr_t *) SvIV(SvRV(c))), SvUV(round)));
}

SV * Rmpfr_const_log2(SV * p, SV * round) {
     return newSViv(mpfr_const_log2(*((mpfr_t *) SvIV(SvRV(p))), SvUV(round)));
}

SV * Rmpfr_const_pi(SV * p, SV * round) {
     return newSViv(mpfr_const_pi(*((mpfr_t *) SvIV(SvRV(p))), SvUV(round)));
}

SV * Rmpfr_const_euler(SV * p, SV * round) {
     return newSViv(mpfr_const_euler(*((mpfr_t *) SvIV(SvRV(p))), SvUV(round)));
}

void Rmpfr_print_binary(SV * p) {
     mpfr_print_binary(*((mpfr_t *) SvIV(SvRV(p))));
}

SV * Rmpfr_rint(SV * a, SV * b, SV * round) {
     return newSViv(mpfr_rint(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), SvUV(round)));
}

SV * Rmpfr_ceil(SV * a, SV * b) {
     return newSViv(mpfr_ceil(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b)))));
}

SV * Rmpfr_floor(SV * a, SV * b) {
     return newSViv(mpfr_floor(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b)))));
}

SV * Rmpfr_round(SV * a, SV * b) {
     return newSViv(mpfr_round(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b)))));
}

SV * Rmpfr_trunc(SV * a, SV * b) {
     return newSViv(mpfr_trunc(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b)))));
}

SV * Rmpfr_add_one_ulp(SV * p, SV * round) {
     return newSViv(mpfr_add_one_ulp(*((mpfr_t *) SvIV(SvRV(p))), SvUV(round)));
}

SV * Rmpfr_sub_one_ulp(SV * p, SV * round) {
     return newSViv(mpfr_sub_one_ulp(*((mpfr_t *) SvIV(SvRV(p))), SvUV(round)));
}

SV * Rmpfr_can_round(SV * p, SV * err, SV * round1, SV * round2, SV * prec) {
     return newSViv(mpfr_can_round(*((mpfr_t *) SvIV(SvRV(p))), SvIV(err), SvUV(round1), SvUV(round2), SvUV(prec)));
}

SV * Rmpfr_get_emin() {
     return newSViv(mpfr_get_emin());
}

SV * Rmpfr_get_emax() {
     return newSViv(mpfr_get_emax());
}

SV * Rmpfr_set_emin(SV * e) {
     return newSViv(mpfr_set_emin(SvIV(e)));
}

SV * Rmpfr_set_emax(SV * e) {
     return newSViv(mpfr_set_emax(SvIV(e)));
}

SV * Rmpfr_check_range(SV * p, SV * t, SV * round) {
     return newSViv(mpfr_check_range(*((mpfr_t *) SvIV(SvRV(p))), SvIV(t), SvUV(round)));
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

SV * Rmpfr_log(SV * a, SV * b, SV * round) {
     return newSViv(mpfr_log(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), SvUV(round)));
}

SV * Rmpfr_exp(SV * a, SV * b, SV * round) {
     return newSViv(mpfr_exp(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), SvUV(round)));
}

SV * Rmpfr_exp2(SV * a, SV * b, SV * round) {
     return newSViv(mpfr_exp2(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), SvUV(round)));
}

void Rmpfr_urandomb(SV * x, ...) {
     Inline_Stack_Vars;
     unsigned long i, t;

     t = Inline_Stack_Items;
     --t;

     for(i = 0; i < t; ++i) {
        mpfr_urandomb(*((mpfr_t *) SvIV(SvRV(Inline_Stack_Item(i)))), *((gmp_randstate_t *) SvIV(SvRV(Inline_Stack_Item(t)))));
        }
}

void Rmpfr_random2(SV * p, SV * s, SV * exp) {
     mpfr_random2(*((mpfr_t *) SvIV(SvRV(p))), SvIV(s), SvUV(exp));
}

SV * Rmpfr_out_str(SV * p, SV * base, SV * dig, SV * round) {
     return newSVuv(mpfr_out_str(stdout, SvUV(base), SvUV(dig), *((mpfr_t *) SvIV(SvRV(p))), SvUV(round)));
}

SV * Rmpfr_inp_str(SV * p, SV * base, SV * round) {
     return newSVuv(mpfr_inp_str(*((mpfr_t *) SvIV(SvRV(p))), stdin, SvUV(base), SvUV(round)));
}

SV * Rmpfr_gamma(SV * a, SV * b, SV * round) {
     return newSViv(mpfr_gamma(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), SvUV(round)));
}

SV * Rmpfr_zeta(SV * a, SV * b, SV * round) {
     return newSViv(mpfr_zeta(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), SvUV(round)));
}

SV * Rmpfr_erf(SV * a, SV * b, SV * round) {
     return newSViv(mpfr_erf(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), SvUV(round)));
}

SV * Rmpfr_frac(SV * a, SV * b, SV * round) {
     return newSViv(mpfr_frac(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), SvUV(round)));
}

SV * Rmpfr_integer_p(SV * p) {
     return newSViv(mpfr_integer_p(*((mpfr_t *) SvIV(SvRV(p)))));
}

void Rmpfr_nexttoward(SV * a, SV * b) {
     mpfr_nexttoward(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))));
}

void Rmpfr_nextabove(SV * p) {
     mpfr_nextabove(*((mpfr_t *) SvIV(SvRV(p))));
}

void Rmpfr_nextbelow(SV * p) {
     mpfr_nextbelow(*((mpfr_t *) SvIV(SvRV(p))));
}

SV * Rmpfr_min(SV * a, SV * b, SV * c, SV * round) {
     return newSViv(mpfr_min(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), *((mpfr_t *) SvIV(SvRV(c))), SvUV(round)));
}

SV * Rmpfr_max(SV * a, SV * b, SV * c, SV * round) {
     return newSViv(mpfr_max(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), *((mpfr_t *) SvIV(SvRV(c))), SvUV(round)));
}

SV * Rmpfr_get_exp(SV * p) {
     return newSViv(mpfr_get_exp(*((mpfr_t *) SvIV(SvRV(p)))));
}

SV * Rmpfr_set_exp(SV * p, SV * exp) {
     return newSViv(mpfr_set_exp(*((mpfr_t *) SvIV(SvRV(p))), SvIV(exp)));
}

SV * get_refcnt(SV * s) {
     return newSVuv(SvREFCNT(s));
}

SV * overload_mul(SV * a, SV * b, SV * third) {
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;

     New(1, mpfr_t_obj, sizeof(mpfr_t), mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in overload_mul function");
     obj_ref = newSViv(0);
     obj = newSVrv(obj_ref, "Math::MPFR");
     mpfr_init(*mpfr_t_obj);

     if(SvUOK(b)) {
       mpfr_mul_ui(*mpfr_t_obj, *((mpfr_t *) SvIV(SvRV(a))), SvUV(b), __gmpfr_default_rounding_mode);
       sv_setiv(obj, (IV)mpfr_t_obj);
       SvREADONLY_on(obj);
       return obj_ref;
       }

     if(SvIOK(b)) {
       if(SvIV(b) >= 0) {
         mpfr_mul_ui(*mpfr_t_obj, *((mpfr_t *) SvIV(SvRV(a))), SvUV(b), __gmpfr_default_rounding_mode);
         sv_setiv(obj, (IV)mpfr_t_obj);
         SvREADONLY_on(obj);
         return obj_ref;
         }
       mpfr_mul_ui(*mpfr_t_obj, *((mpfr_t *) SvIV(SvRV(a))), SvIV(b) * -1, __gmpfr_default_rounding_mode);
       mpfr_neg(*mpfr_t_obj, *mpfr_t_obj, __gmpfr_default_rounding_mode);
       sv_setiv(obj, (IV)mpfr_t_obj);
       SvREADONLY_on(obj);
       return obj_ref;
       }

     if(SvNOK(b)) {
       mpfr_set_d(*mpfr_t_obj, SvNV(b), __gmpfr_default_rounding_mode);
       mpfr_mul(*mpfr_t_obj, *((mpfr_t *) SvIV(SvRV(a))), *mpfr_t_obj, __gmpfr_default_rounding_mode);
       sv_setiv(obj, (IV)mpfr_t_obj);
       SvREADONLY_on(obj);
       return obj_ref;
       }

     if(SvROK(b)) {
       if(strEQ(HvNAME(SvSTASH(SvRV(b))), "Math::MPFR")) {
         mpfr_mul(*mpfr_t_obj, *((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), __gmpfr_default_rounding_mode);
         sv_setiv(obj, (IV)mpfr_t_obj);
         SvREADONLY_on(obj);
         return obj_ref;
         }
       }

     croak("Invalid argument supplied to overload_mul");
}

SV * overload_mul_eq(SV * a, SV * b, SV * third) {
     mpfr_t t;

     SvREFCNT_inc(a);

     if(SvUOK(b)) {
       mpfr_mul_ui(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(a))), SvUV(b), __gmpfr_default_rounding_mode);
       return a;
       }

     if(SvIOK(b)) {
       if(SvIV(b) >= 0) {
         mpfr_mul_ui(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(a))), SvUV(b), __gmpfr_default_rounding_mode);
         return a;
         }
       mpfr_mul_ui(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(a))), SvIV(b) * -1, __gmpfr_default_rounding_mode);
       mpfr_neg(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(a))), __gmpfr_default_rounding_mode);
       return a;
       }

     if(SvNOK(b)) {
       mpfr_init_set_d(t, SvNV(b), __gmpfr_default_rounding_mode);
       mpfr_mul(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(a))), t, __gmpfr_default_rounding_mode);
       mpfr_clear(t);
       return a;
       }

     if(SvROK(b)) {
       if(strEQ(HvNAME(SvSTASH(SvRV(b))), "Math::MPFR")) {
         mpfr_mul(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), __gmpfr_default_rounding_mode);
         return a;
         }
       }

     SvREFCNT_dec(a);
     croak("Invalid argument supplied to overload_mul_eq");
}

SV * overload_add(SV * a, SV * b, SV * third) {
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;

     New(1, mpfr_t_obj, sizeof(mpfr_t), mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in overload_add function");
     obj_ref = newSViv(0);
     obj = newSVrv(obj_ref, "Math::MPFR");
     mpfr_init(*mpfr_t_obj);

     if(SvUOK(b)) {
       mpfr_add_ui(*mpfr_t_obj, *((mpfr_t *) SvIV(SvRV(a))), SvUV(b), __gmpfr_default_rounding_mode);
       sv_setiv(obj, (IV)mpfr_t_obj);
       SvREADONLY_on(obj);
       return obj_ref;
       }

     if(SvIOK(b)) {
       if(SvIV(b) >= 0) {
         mpfr_add_ui(*mpfr_t_obj, *((mpfr_t *) SvIV(SvRV(a))), SvUV(b), __gmpfr_default_rounding_mode);
         sv_setiv(obj, (IV)mpfr_t_obj);
         SvREADONLY_on(obj);
         return obj_ref;
         }
       mpfr_sub_ui(*mpfr_t_obj, *((mpfr_t *) SvIV(SvRV(a))), SvIV(b) * -1, __gmpfr_default_rounding_mode);
       sv_setiv(obj, (IV)mpfr_t_obj);
       SvREADONLY_on(obj);
       return obj_ref;
       }

     if(SvNOK(b)) {
       mpfr_set_d(*mpfr_t_obj, SvNV(b), __gmpfr_default_rounding_mode);
       mpfr_add(*mpfr_t_obj, *((mpfr_t *) SvIV(SvRV(a))), *mpfr_t_obj, __gmpfr_default_rounding_mode);
       sv_setiv(obj, (IV)mpfr_t_obj);
       SvREADONLY_on(obj);
       return obj_ref;
       }

     if(SvROK(b)) {
       if(strEQ(HvNAME(SvSTASH(SvRV(b))), "Math::MPFR")) {
         mpfr_add(*mpfr_t_obj, *((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), __gmpfr_default_rounding_mode);
         sv_setiv(obj, (IV)mpfr_t_obj);
         SvREADONLY_on(obj);
         return obj_ref;
         }
       }

     croak("Invalid argument supplied to overload_add");
}

SV * overload_add_eq(SV * a, SV * b, SV * third) {
     mpfr_t t;

     SvREFCNT_inc(a);

     if(SvUOK(b)) {
       mpfr_add_ui(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(a))), SvUV(b), __gmpfr_default_rounding_mode);
       return a;
       }

     if(SvIOK(b)) {
       if(SvIV(b) >= 0) {
         mpfr_add_ui(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(a))), SvUV(b), __gmpfr_default_rounding_mode);
         return a;
         }
       mpfr_sub_ui(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(a))), SvIV(b) * -1, __gmpfr_default_rounding_mode);
       return a;
       }

     if(SvNOK(b)) {
       mpfr_init_set_d(t, SvNV(b), __gmpfr_default_rounding_mode);
       mpfr_add(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(a))), t, __gmpfr_default_rounding_mode);
       mpfr_clear(t);
       return a;
       }

     if(SvROK(b)) {
       if(strEQ(HvNAME(SvSTASH(SvRV(b))), "Math::MPFR")) {
         mpfr_add(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), __gmpfr_default_rounding_mode);
         return a;
         }
       }

     SvREFCNT_dec(a);
     croak("Invalid argument supplied to overload_add_eq");
}

SV * overload_sub(SV * a, SV * b, SV * third) {
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;

     New(1, mpfr_t_obj, sizeof(mpfr_t), mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in overload_sub function");
     obj_ref = newSViv(0);
     obj = newSVrv(obj_ref, "Math::MPFR");
     mpfr_init(*mpfr_t_obj);

     if(SvUOK(b)) {
       if(third == &PL_sv_yes) mpfr_ui_sub(*mpfr_t_obj, SvUV(b), *((mpfr_t *) SvIV(SvRV(a))), __gmpfr_default_rounding_mode);
       else mpfr_sub_ui(*mpfr_t_obj, *((mpfr_t *) SvIV(SvRV(a))), SvUV(b), __gmpfr_default_rounding_mode);
       sv_setiv(obj, (IV)mpfr_t_obj);
       SvREADONLY_on(obj);
       return obj_ref;
       }

     if(SvIOK(b)) {
       if(SvIV(b) >= 0) {
         if(third == &PL_sv_yes) mpfr_ui_sub(*mpfr_t_obj, SvUV(b), *((mpfr_t *) SvIV(SvRV(a))), __gmpfr_default_rounding_mode);
         else mpfr_sub_ui(*mpfr_t_obj, *((mpfr_t *) SvIV(SvRV(a))), SvUV(b), __gmpfr_default_rounding_mode);
         sv_setiv(obj, (IV)mpfr_t_obj);
         SvREADONLY_on(obj);
         return obj_ref;
         }
       mpfr_add_ui(*mpfr_t_obj, *((mpfr_t *) SvIV(SvRV(a))), SvIV(b) * -1, __gmpfr_default_rounding_mode);
       if(third == &PL_sv_yes) mpfr_neg(*mpfr_t_obj, *mpfr_t_obj, __gmpfr_default_rounding_mode);
       sv_setiv(obj, (IV)mpfr_t_obj);
       SvREADONLY_on(obj);
       return obj_ref;
       }

     if(SvNOK(b)) {
       mpfr_set_d(*mpfr_t_obj, SvNV(b), __gmpfr_default_rounding_mode);
       if(third == &PL_sv_yes) mpfr_sub(*mpfr_t_obj, *mpfr_t_obj, *((mpfr_t *) SvIV(SvRV(a))), __gmpfr_default_rounding_mode);
       else mpfr_sub(*mpfr_t_obj, *((mpfr_t *) SvIV(SvRV(a))), *mpfr_t_obj, __gmpfr_default_rounding_mode);
       sv_setiv(obj, (IV)mpfr_t_obj);
       SvREADONLY_on(obj);
       return obj_ref;
       }

     if(SvROK(b)) {
       if(strEQ(HvNAME(SvSTASH(SvRV(b))), "Math::MPFR")) {
         mpfr_sub(*mpfr_t_obj, *((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), __gmpfr_default_rounding_mode);
         sv_setiv(obj, (IV)mpfr_t_obj);
         SvREADONLY_on(obj);
         return obj_ref;
         }
       }

     croak("Invalid argument supplied to overload_sub function");

}

SV * overload_sub_eq(SV * a, SV * b, SV * third) {
     mpfr_t t;

     SvREFCNT_inc(a);

     if(SvUOK(b)) {
       mpfr_sub_ui(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(a))), SvUV(b), __gmpfr_default_rounding_mode);
       return a;
       }

     if(SvIOK(b)) {
       if(SvIV(b) >= 0) {
         mpfr_sub_ui(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(a))), SvUV(b), __gmpfr_default_rounding_mode);
         return a;
         }
       mpfr_add_ui(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(a))), SvIV(b) * -1, __gmpfr_default_rounding_mode);
       return a;
       }

     if(SvNOK(b)) {
       mpfr_init_set_d(t, SvNV(b), __gmpfr_default_rounding_mode);
       mpfr_sub(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(a))), t, __gmpfr_default_rounding_mode);
       mpfr_clear(t);
       return a;
       }

     if(SvROK(b)) {
       if(strEQ(HvNAME(SvSTASH(SvRV(b))), "Math::MPFR")) {
         mpfr_sub(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), __gmpfr_default_rounding_mode);
         return a;
         }
       }

     SvREFCNT_dec(a);
     croak("Invalid argument supplied to overload_sub_eq function");

}

SV * overload_div(SV * a, SV * b, SV * third) {
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;

     New(1, mpfr_t_obj, sizeof(mpfr_t), mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in overload_div function");
     obj_ref = newSViv(0);
     obj = newSVrv(obj_ref, "Math::MPFR");
     mpfr_init(*mpfr_t_obj);

     if(SvUOK(b)) {
       if(third == &PL_sv_yes) mpfr_ui_div(*mpfr_t_obj, SvUV(b), *((mpfr_t *) SvIV(SvRV(a))), __gmpfr_default_rounding_mode);
       else mpfr_div_ui(*mpfr_t_obj, *((mpfr_t *) SvIV(SvRV(a))), SvUV(b), __gmpfr_default_rounding_mode);
       sv_setiv(obj, (IV)mpfr_t_obj);
       SvREADONLY_on(obj);
       return obj_ref;
       }

     if(SvIOK(b)) {
       if(SvIV(b) >= 0) {
         if(third == &PL_sv_yes) mpfr_ui_div(*mpfr_t_obj, SvUV(b), *((mpfr_t *) SvIV(SvRV(a))), __gmpfr_default_rounding_mode);
         else mpfr_div_ui(*mpfr_t_obj, *((mpfr_t *) SvIV(SvRV(a))), SvUV(b), __gmpfr_default_rounding_mode);
         sv_setiv(obj, (IV)mpfr_t_obj);
         SvREADONLY_on(obj);
         return obj_ref;
         }
       if(third == &PL_sv_yes) mpfr_ui_div(*mpfr_t_obj, SvIV(b) * -1, *((mpfr_t *) SvIV(SvRV(a))), __gmpfr_default_rounding_mode);
       else mpfr_div_ui(*mpfr_t_obj, *((mpfr_t *) SvIV(SvRV(a))), SvIV(b) * -1, __gmpfr_default_rounding_mode);
       mpfr_neg(*mpfr_t_obj, *mpfr_t_obj, __gmpfr_default_rounding_mode);
       sv_setiv(obj, (IV)mpfr_t_obj);
       SvREADONLY_on(obj);
       return obj_ref;
       }

     if(SvNOK(b)) {
       mpfr_set_d(*mpfr_t_obj, SvNV(b), __gmpfr_default_rounding_mode);
       if(third == &PL_sv_yes) mpfr_div(*mpfr_t_obj, *mpfr_t_obj, *((mpfr_t *) SvIV(SvRV(a))), __gmpfr_default_rounding_mode);
       else mpfr_div(*mpfr_t_obj, *((mpfr_t *) SvIV(SvRV(a))), *mpfr_t_obj, __gmpfr_default_rounding_mode);
       sv_setiv(obj, (IV)mpfr_t_obj);
       SvREADONLY_on(obj);
       return obj_ref;
       }

     if(SvROK(b)) {
       if(strEQ(HvNAME(SvSTASH(SvRV(b))), "Math::MPFR")) {
         mpfr_div(*mpfr_t_obj, *((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), __gmpfr_default_rounding_mode);
         sv_setiv(obj, (IV)mpfr_t_obj);
         SvREADONLY_on(obj);
         return obj_ref;
         }
       }

     mpfr_clear(*mpfr_t_obj);
     croak("Invalid argument supplied to overload_div function");

}

SV * overload_div_eq(SV * a, SV * b, SV * third) {
     mpfr_t t;

     SvREFCNT_inc(a);

     if(SvUOK(b)) {
       mpfr_div_ui(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(a))), SvUV(b), __gmpfr_default_rounding_mode);
       return a;
       }

     if(SvIOK(b)) {
       if(SvIV(b) >= 0) {
         mpfr_div_ui(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(a))), SvUV(b), __gmpfr_default_rounding_mode);
         return a;
         }
       mpfr_div_ui(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(a))), SvIV(b) * -1, __gmpfr_default_rounding_mode);
       mpfr_neg(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(a))), __gmpfr_default_rounding_mode);
       return a;
       }

     if(SvNOK(b)) {
       mpfr_init_set_d(t, SvNV(b), __gmpfr_default_rounding_mode);
       mpfr_div(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(a))), t, __gmpfr_default_rounding_mode);
       mpfr_clear(t);
       return a;
       }

     if(SvROK(b)) {
       if(strEQ(HvNAME(SvSTASH(SvRV(b))), "Math::MPFR")) {
         mpfr_div(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), __gmpfr_default_rounding_mode);
         return a;
         }
       }

     SvREFCNT_dec(a);
     croak("Invalid argument supplied to overload_div_eq function");

}

SV * overload_copy(SV * p, SV * second, SV * third) {
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;

     New(1, mpfr_t_obj, sizeof(mpfr_t), mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in overload_copy function");
     obj_ref = newSViv(0);
     obj = newSVrv(obj_ref, "Math::MPFR");

     mpfr_init_set(*mpfr_t_obj, *((mpfr_t *) SvIV(SvRV(p))), __gmpfr_default_rounding_mode);
     sv_setiv(obj, (IV)mpfr_t_obj);
     SvREADONLY_on(obj);
     return obj_ref;
}

SV * overload_abs(SV * p, SV * second, SV * third) {
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;

     New(1, mpfr_t_obj, sizeof(mpfr_t), mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in overload_abs function");
     obj_ref = newSViv(0);
     obj = newSVrv(obj_ref, "Math::MPFR");
     mpfr_init(*mpfr_t_obj);

     mpfr_abs(*mpfr_t_obj, *((mpfr_t *) SvIV(SvRV(p))), __gmpfr_default_rounding_mode);
     sv_setiv(obj, (IV)mpfr_t_obj);
     SvREADONLY_on(obj);
     return obj_ref;
}

SV * overload_gt(SV * a, SV * b, SV * third) {
     mpfr_t t;
     int ret;

     if(SvUOK(b)) {
       ret = mpfr_cmp_ui(*((mpfr_t *) SvIV(SvRV(a))), SvUV(b));
       if(third == &PL_sv_yes) ret *= -1;
       if(ret > 0) return newSViv(1);
       return newSViv(0);
       }

     if(SvIOK(b)) {
       ret = mpfr_cmp_si(*((mpfr_t *) SvIV(SvRV(a))), SvIV(b));
       if(third == &PL_sv_yes) ret *= -1;
       if(ret > 0) return newSViv(1);
       return newSViv(0);
       }

     if(SvNOK(b)) {
       mpfr_init_set_d(t, SvNV(b), __gmpfr_default_rounding_mode);
       ret = mpfr_cmp(*((mpfr_t *) SvIV(SvRV(a))), t);
       mpfr_clear(t);
       if(third == &PL_sv_yes) ret *= -1;
       if(ret > 0) return newSViv(1);
       return newSViv(0);
       }

     if(SvROK(b)) {
       if(strEQ(HvNAME(SvSTASH(SvRV(b))), "Math::MPFR")) {
         return newSVuv(mpfr_greater_p(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b)))));
         }
       }

     croak("Invalid arguments supplied to overload_gt");
}

SV * overload_gte(SV * a, SV * b, SV * third) {
     mpfr_t t;
     int ret;

     if(SvUOK(b)) {
       ret = mpfr_cmp_ui(*((mpfr_t *) SvIV(SvRV(a))), SvUV(b));
       if(third == &PL_sv_yes) ret *= -1;
       if(ret >= 0) return newSViv(1);
       return newSViv(0);
       }

     if(SvIOK(b)) {
       ret = mpfr_cmp_si(*((mpfr_t *) SvIV(SvRV(a))), SvIV(b));
       if(third == &PL_sv_yes) ret *= -1;
       if(ret >= 0) return newSViv(1);
       return newSViv(0);
       }

     if(SvNOK(b)) {
       mpfr_init_set_d(t, SvNV(b), __gmpfr_default_rounding_mode);
       ret = mpfr_cmp(*((mpfr_t *) SvIV(SvRV(a))), t);
       mpfr_clear(t);
       if(third == &PL_sv_yes) ret *= -1;
       if(ret >= 0) return newSViv(1);
       return newSViv(0);
       }

     if(SvROK(b)) {
       if(strEQ(HvNAME(SvSTASH(SvRV(b))), "Math::MPFR")) {
         return newSVuv(mpfr_greaterequal_p(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b)))));
         }
       }

     croak("Invalid arguments supplied to overload_gte");
}

SV * overload_lt(SV * a, SV * b, SV * third) {
     mpfr_t t;
     int ret;

     if(SvUOK(b)) {
       ret = mpfr_cmp_ui(*((mpfr_t *) SvIV(SvRV(a))), SvUV(b));
       if(third == &PL_sv_yes) ret *= -1;
       if(ret < 0) return newSViv(1);
       return newSViv(0);
       }

     if(SvIOK(b)) {
       ret = mpfr_cmp_si(*((mpfr_t *) SvIV(SvRV(a))), SvIV(b));
       if(third == &PL_sv_yes) ret *= -1;
       if(ret < 0) return newSViv(1);
       return newSViv(0);
       }

     if(SvNOK(b)) {
       mpfr_init_set_d(t, SvNV(b), __gmpfr_default_rounding_mode);
       ret = mpfr_cmp(*((mpfr_t *) SvIV(SvRV(a))), t);
       mpfr_clear(t);
       if(third == &PL_sv_yes) ret *= -1;
       if(ret < 0) return newSViv(1);
       return newSViv(0);
       }

     if(SvROK(b)) {
       if(strEQ(HvNAME(SvSTASH(SvRV(b))), "Math::MPFR")) {
         return newSVuv(mpfr_less_p(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b)))));
         }
       }

     croak("Invalid arguments supplied to overload_lt");
}

SV * overload_lte(SV * a, SV * b, SV * third) {
     mpfr_t t;
     int ret;

     if(SvUOK(b)) {
       ret = mpfr_cmp_ui(*((mpfr_t *) SvIV(SvRV(a))), SvUV(b));
       if(third == &PL_sv_yes) ret *= -1;
       if(ret <= 0) return newSViv(1);
       return newSViv(0);
       }

     if(SvIOK(b)) {
       ret = mpfr_cmp_si(*((mpfr_t *) SvIV(SvRV(a))), SvIV(b));
       if(third == &PL_sv_yes) ret *= -1;
       if(ret <= 0) return newSViv(1);
       return newSViv(0);
       }

     if(SvNOK(b)) {
       mpfr_init_set_d(t, SvNV(b), __gmpfr_default_rounding_mode);
       ret = mpfr_cmp(*((mpfr_t *) SvIV(SvRV(a))), t);
       mpfr_clear(t);
       if(third == &PL_sv_yes) ret *= -1;
       if(ret <= 0) return newSViv(1);
       return newSViv(0);
       }

     if(SvROK(b)) {
       if(strEQ(HvNAME(SvSTASH(SvRV(b))), "Math::MPFR")) {
         return newSVuv(mpfr_lessequal_p(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b)))));
         return newSViv(0);
         }
       }

     croak("Invalid arguments supplied to overload_lte");
}

SV * overload_spaceship(SV * a, SV * b, SV * third) {
     mpfr_t t;
     int ret;

     if(SvUOK(b)) {
       ret = mpfr_cmp_ui(*((mpfr_t *) SvIV(SvRV(a))), SvUV(b));
       if(third == &PL_sv_yes) ret *= -1;
       if(ret < 0) return newSViv(-1);
       if(ret > 0) return newSViv(1);
       return newSViv(0);
       }

     if(SvIOK(b)) {
       ret = mpfr_cmp_si(*((mpfr_t *) SvIV(SvRV(a))), SvIV(b));
       if(third == &PL_sv_yes) ret *= -1;
       if(ret < 0) return newSViv(-1);
       if(ret > 0) return newSViv(1);
       return newSViv(0);
       }

     if(SvNOK(b)) {
       mpfr_init_set_d(t, SvNV(b), __gmpfr_default_rounding_mode);
       ret = mpfr_cmp(*((mpfr_t *) SvIV(SvRV(a))), t);
       mpfr_clear(t);
       if(third == &PL_sv_yes) ret *= -1;
       if(ret < 0) return newSViv(-1);
       if(ret > 0) return newSViv(1);
       return newSViv(0);
       }

     if(SvROK(b)) {
       if(strEQ(HvNAME(SvSTASH(SvRV(b))), "Math::MPFR")) {
         return newSViv(mpfr_cmp(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b)))));
         }
       }

     croak("Invalid arguments supplied to overload_spaceship");
}

SV * overload_equiv(SV * a, SV * b, SV * third) {
     mpfr_t t;
     int ret;

     if(SvUOK(b)) {
       ret = mpfr_cmp_ui(*((mpfr_t *) SvIV(SvRV(a))), SvUV(b));
       if(third == &PL_sv_yes) ret *= -1;
       if(ret == 0) return newSViv(1);
       return newSViv(0);
       }

     if(SvIOK(b)) {
       ret = mpfr_cmp_si(*((mpfr_t *) SvIV(SvRV(a))), SvIV(b));
       if(third == &PL_sv_yes) ret *= -1;
       if(ret == 0) return newSViv(1);
       return newSViv(0);
       }

     if(SvNOK(b)) {
       mpfr_init_set_d(t, SvNV(b), __gmpfr_default_rounding_mode);
       ret = mpfr_cmp(*((mpfr_t *) SvIV(SvRV(a))), t);
       mpfr_clear(t);
       if(third == &PL_sv_yes) ret *= -1;
       if(ret == 0) return newSViv(1);
       return newSViv(0);
       }

     if(SvROK(b)) {
       if(strEQ(HvNAME(SvSTASH(SvRV(b))), "Math::MPFR")) {
         return newSVuv(mpfr_equal_p(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b)))));
         }
       }

     croak("Invalid arguments supplied to overload_equiv");
}

SV * overload_not_equiv(SV * a, SV * b, SV * third) {
     mpfr_t t;
     int ret;

     if(SvUOK(b)) {
       ret = mpfr_cmp_ui(*((mpfr_t *) SvIV(SvRV(a))), SvUV(b));
       if(third == &PL_sv_yes) ret *= -1;
       if(ret != 0) return newSViv(1);
       return newSViv(0);
       }

     if(SvIOK(b)) {
       ret = mpfr_cmp_si(*((mpfr_t *) SvIV(SvRV(a))), SvIV(b));
       if(third == &PL_sv_yes) ret *= -1;
       if(ret != 0) return newSViv(1);
       return newSViv(0);
       }

     if(SvNOK(b)) {
       mpfr_init_set_d(t, SvNV(b), __gmpfr_default_rounding_mode);
       ret = mpfr_cmp(*((mpfr_t *) SvIV(SvRV(a))), t);
       mpfr_clear(t);
       if(third == &PL_sv_yes) ret *= -1;
       if(ret != 0) return newSViv(1);
       return newSViv(0);
       }

     if(SvROK(b)) {
       if(strEQ(HvNAME(SvSTASH(SvRV(b))), "Math::MPFR")) {
         if(mpfr_equal_p(*((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))))) return newSViv(0);
         return newSViv(1);
         }
       }

     croak("Invalid arguments supplied to overload_not_equiv");
}

SV * overload_not(SV * a, SV * second, SV * third) {
     if(mpfr_cmp_ui(*((mpfr_t *) SvIV(SvRV(a))), 0)) return newSViv(0);
     return newSViv(1);
}

SV * overload_sqrt(SV * p, SV * second, SV * third) {
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;

     New(1, mpfr_t_obj, sizeof(mpfr_t), mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in overload_sqrt function");
     obj_ref = newSViv(0);
     obj = newSVrv(obj_ref, "Math::MPFR");
     mpfr_init(*mpfr_t_obj);

     if(mpfr_cmp_ui(*((mpfr_t *) SvIV(SvRV(p))), 0) < 0) croak("Negative value supplied as argument to overload_sqrt");
     mpfr_sqrt(*mpfr_t_obj, *((mpfr_t *) SvIV(SvRV(p))), __gmpfr_default_rounding_mode);
     sv_setiv(obj, (IV)mpfr_t_obj);
     SvREADONLY_on(obj);
     return obj_ref;
}

SV * overload_pow(SV * p, SV * second, SV * third) {
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;

     New(1, mpfr_t_obj, sizeof(mpfr_t), mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in overload_sqrt function");
     obj_ref = newSViv(0);
     obj = newSVrv(obj_ref, "Math::MPFR");
     mpfr_init(*mpfr_t_obj);

     if(SvUOK(second)) {
       if(third == &PL_sv_yes) mpfr_ui_pow(*mpfr_t_obj, SvUV(second), *((mpfr_t *) SvIV(SvRV(p))), __gmpfr_default_rounding_mode);
       else mpfr_pow_ui(*mpfr_t_obj, *((mpfr_t *) SvIV(SvRV(p))), SvUV(second), __gmpfr_default_rounding_mode);
       sv_setiv(obj, (IV)mpfr_t_obj);
       SvREADONLY_on(obj);
       return obj_ref;
       }

     if(SvIOK(second)) {
       if(SvIV(second) >= 0) {
         if(third == &PL_sv_yes) mpfr_ui_pow(*mpfr_t_obj, SvUV(second), *((mpfr_t *) SvIV(SvRV(p))), __gmpfr_default_rounding_mode);
         else mpfr_pow_ui(*mpfr_t_obj, *((mpfr_t *) SvIV(SvRV(p))), SvUV(second), __gmpfr_default_rounding_mode);
         sv_setiv(obj, (IV)mpfr_t_obj);
         SvREADONLY_on(obj);
         return obj_ref;
         }
       if(third != &PL_sv_yes) {
         mpfr_pow_si(*mpfr_t_obj, *((mpfr_t *) SvIV(SvRV(p))), SvIV(second), __gmpfr_default_rounding_mode);
         sv_setiv(obj, (IV)mpfr_t_obj);
         SvREADONLY_on(obj);
         return obj_ref;
         }
       }

     if(SvNOK(second)) {
       mpfr_set_d(*mpfr_t_obj, SvNV(second), __gmpfr_default_rounding_mode);
       if(third == &PL_sv_yes) mpfr_pow(*mpfr_t_obj, *mpfr_t_obj, *((mpfr_t *) SvIV(SvRV(p))), __gmpfr_default_rounding_mode);
       else mpfr_pow(*mpfr_t_obj, *((mpfr_t *) SvIV(SvRV(p))), *mpfr_t_obj, __gmpfr_default_rounding_mode); 
       sv_setiv(obj, (IV)mpfr_t_obj);
       SvREADONLY_on(obj);
       return obj_ref;
       }

     if(SvROK(second)) {
       if(strEQ(HvNAME(SvSTASH(SvRV(second))), "Math::MPFR")) {
         mpfr_pow(*mpfr_t_obj, *((mpfr_t *) SvIV(SvRV(p))), *((mpfr_t *) SvIV(SvRV(second))), __gmpfr_default_rounding_mode);
         sv_setiv(obj, (IV)mpfr_t_obj);
         SvREADONLY_on(obj);
         return obj_ref;
         }
       }

     croak("Inappropriate argument supplied to overload_pow.");
}

SV * overload_pow_eq(SV * p, SV * second, SV * third) {
     mpfr_t t;

     SvREFCNT_inc(p);

     if(SvUOK(second)) {
       mpfr_pow_ui(*((mpfr_t *) SvIV(SvRV(p))), *((mpfr_t *) SvIV(SvRV(p))), SvUV(second), __gmpfr_default_rounding_mode);
       return p;
       }

     if(SvIOK(second)) {
       if(SvIV(second) >= 0) {
         mpfr_pow_ui(*((mpfr_t *) SvIV(SvRV(p))), *((mpfr_t *) SvIV(SvRV(p))), SvUV(second), __gmpfr_default_rounding_mode);
         return p;
         }
       mpfr_pow_si(*((mpfr_t *) SvIV(SvRV(p))), *((mpfr_t *) SvIV(SvRV(p))), SvIV(second), __gmpfr_default_rounding_mode);
       return p;
       }

     if(SvNOK(second)) {
       mpfr_init_set_d(t, SvNV(second), __gmpfr_default_rounding_mode);
       mpfr_pow(*((mpfr_t *) SvIV(SvRV(p))), *((mpfr_t *) SvIV(SvRV(p))), t, __gmpfr_default_rounding_mode);
       mpfr_clear(t);
       return p;
       }

     if(SvROK(second)) {
       if(strEQ(HvNAME(SvSTASH(SvRV(second))), "Math::MPFR")) {
         mpfr_pow(*((mpfr_t *) SvIV(SvRV(p))), *((mpfr_t *) SvIV(SvRV(p))), *((mpfr_t *) SvIV(SvRV(second))), __gmpfr_default_rounding_mode);
         return p;
         }
       }

     SvREFCNT_dec(p);
     croak("Inappropriate argument supplied to overload_pow_eq.");
}

SV * overload_log(SV * p, SV * second, SV * third) {
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;

     New(1, mpfr_t_obj, sizeof(mpfr_t), mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in overload_log function");
     obj_ref = newSViv(0);
     obj = newSVrv(obj_ref, "Math::MPFR");
     mpfr_init(*mpfr_t_obj);

     mpfr_log(*mpfr_t_obj, *((mpfr_t *) SvIV(SvRV(p))), __gmpfr_default_rounding_mode);
     sv_setiv(obj, (IV)mpfr_t_obj);
     SvREADONLY_on(obj);
     return obj_ref;
}

SV * overload_exp(SV * p, SV * second, SV * third) {
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;

     New(1, mpfr_t_obj, sizeof(mpfr_t), mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in overload_exp function");
     obj_ref = newSViv(0);
     obj = newSVrv(obj_ref, "Math::MPFR");
     mpfr_init(*mpfr_t_obj);

     mpfr_exp(*mpfr_t_obj, *((mpfr_t *) SvIV(SvRV(p))), __gmpfr_default_rounding_mode);
     sv_setiv(obj, (IV)mpfr_t_obj);
     SvREADONLY_on(obj);
     return obj_ref;
}

SV * overload_sin(SV * p, SV * second, SV * third) {
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;

     New(1, mpfr_t_obj, sizeof(mpfr_t), mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in overload_sin function");
     obj_ref = newSViv(0);
     obj = newSVrv(obj_ref, "Math::MPFR");
     mpfr_init(*mpfr_t_obj);

     mpfr_sin(*mpfr_t_obj, *((mpfr_t *) SvIV(SvRV(p))), __gmpfr_default_rounding_mode);
     sv_setiv(obj, (IV)mpfr_t_obj);
     SvREADONLY_on(obj);
     return obj_ref;
}

SV * overload_cos(SV * p, SV * second, SV * third) {
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;

     New(1, mpfr_t_obj, sizeof(mpfr_t), mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in overload_cos function");
     obj_ref = newSViv(0);
     obj = newSVrv(obj_ref, "Math::MPFR");
     mpfr_init(*mpfr_t_obj);

     mpfr_cos(*mpfr_t_obj, *((mpfr_t *) SvIV(SvRV(p))), __gmpfr_default_rounding_mode);
     sv_setiv(obj, (IV)mpfr_t_obj);
     SvREADONLY_on(obj);
     return obj_ref;
}

SV * overload_int(SV * p, SV * second, SV * third) {
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;

     New(1, mpfr_t_obj, sizeof(mpfr_t), mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in overload_int function");
     obj_ref = newSViv(0);
     obj = newSVrv(obj_ref, "Math::MPFR");
     mpfr_init(*mpfr_t_obj);

     mpfr_trunc(*mpfr_t_obj, *((mpfr_t *) SvIV(SvRV(p))));
     sv_setiv(obj, (IV)mpfr_t_obj);
     SvREADONLY_on(obj);
     return obj_ref;
}

SV * overload_atan2(SV * a, SV * b, SV * third) {
     mpfr_t * mpfr_t_obj;
     SV * obj_ref, * obj;

     New(1, mpfr_t_obj, sizeof(mpfr_t), mpfr_t);
     if(mpfr_t_obj == NULL) croak("Failed to allocate memory in overload_atan2 function");
     obj_ref = newSViv(0);
     obj = newSVrv(obj_ref, "Math::MPFR");
     mpfr_init(*mpfr_t_obj);

     if(SvUOK(b)) {
       if(third == &PL_sv_yes) mpfr_ui_div(*mpfr_t_obj, SvUV(b), *((mpfr_t *) SvIV(SvRV(a))), __gmpfr_default_rounding_mode);
       else mpfr_div_ui(*mpfr_t_obj, *((mpfr_t *) SvIV(SvRV(a))), SvUV(b), __gmpfr_default_rounding_mode);
       mpfr_atan(*mpfr_t_obj, *mpfr_t_obj, __gmpfr_default_rounding_mode);
       sv_setiv(obj, (IV)mpfr_t_obj);
       SvREADONLY_on(obj);
       return obj_ref;
       }

     if(SvIOK(b)) {
       if(SvIV(b) >= 0) {
         if(third == &PL_sv_yes) mpfr_ui_div(*mpfr_t_obj, SvUV(b), *((mpfr_t *) SvIV(SvRV(a))), __gmpfr_default_rounding_mode);
         else mpfr_div_ui(*mpfr_t_obj, *((mpfr_t *) SvIV(SvRV(a))), SvUV(b), __gmpfr_default_rounding_mode);
         mpfr_atan(*mpfr_t_obj, *mpfr_t_obj, __gmpfr_default_rounding_mode);
         sv_setiv(obj, (IV)mpfr_t_obj);
         SvREADONLY_on(obj);
         return obj_ref;
         }
       if(third == &PL_sv_yes) mpfr_ui_div(*mpfr_t_obj, SvIV(b) * -1, *((mpfr_t *) SvIV(SvRV(a))), __gmpfr_default_rounding_mode);
       else mpfr_div_ui(*mpfr_t_obj, *((mpfr_t *) SvIV(SvRV(a))), SvIV(b) * -1, __gmpfr_default_rounding_mode);
       mpfr_neg(*mpfr_t_obj, *mpfr_t_obj, __gmpfr_default_rounding_mode);
       mpfr_atan(*mpfr_t_obj, *mpfr_t_obj, __gmpfr_default_rounding_mode);
       sv_setiv(obj, (IV)mpfr_t_obj);
       SvREADONLY_on(obj);
       return obj_ref;
       }

     if(SvNOK(b)) {
       mpfr_set_d(*mpfr_t_obj, SvNV(b), __gmpfr_default_rounding_mode);
       if(third == &PL_sv_yes) mpfr_div(*mpfr_t_obj, *mpfr_t_obj, *((mpfr_t *) SvIV(SvRV(a))), __gmpfr_default_rounding_mode);
       else mpfr_div(*mpfr_t_obj, *((mpfr_t *) SvIV(SvRV(a))), *mpfr_t_obj, __gmpfr_default_rounding_mode);
       mpfr_atan(*mpfr_t_obj, *mpfr_t_obj, __gmpfr_default_rounding_mode);
       sv_setiv(obj, (IV)mpfr_t_obj);
       SvREADONLY_on(obj);
       return obj_ref;
       }

     if(SvROK(b)) {
       if(strEQ(HvNAME(SvSTASH(SvRV(b))), "Math::MPFR")) {
         mpfr_div(*mpfr_t_obj, *((mpfr_t *) SvIV(SvRV(a))), *((mpfr_t *) SvIV(SvRV(b))), __gmpfr_default_rounding_mode);
         mpfr_atan(*mpfr_t_obj, *mpfr_t_obj, __gmpfr_default_rounding_mode);
         sv_setiv(obj, (IV)mpfr_t_obj);
         SvREADONLY_on(obj);
         return obj_ref;
         }
       }

     croak("Invalid argument supplied to overload_atan2 function");
}

SV * get_package_name(SV * x) {
     if(sv_isobject(x)) return newSVpv(HvNAME(SvSTASH(SvRV(x))), 0);
     return newSViv(0);
}

SV * Rgmp_randinit_default() {
     gmp_randstate_t * state;
     SV * obj_ref, * obj;

     New(1, state, sizeof(gmp_randstate_t), gmp_randstate_t);
     if(state == NULL) croak("Failed to allocate memory in Rgmp_randinit_default function");
     obj_ref = newSViv(0);
     obj = newSVrv(obj_ref, NULL);
     gmp_randinit_default(*state);

     sv_setiv(obj, (IV)state);
     SvREADONLY_on(obj);
     return obj_ref;
}

SV * Rgmp_randinit_lc_2exp(SV * a, SV * c, SV * m2exp ) {
     gmp_randstate_t * state;
     mpz_t aa;
     SV * obj_ref, * obj;

     New(1, state, sizeof(gmp_randstate_t), gmp_randstate_t);
     if(state == NULL) croak("Failed to allocate memory in Rgmp_randinit_lc_2exp function");
     obj_ref = newSViv(0);
     obj = newSVrv(obj_ref, NULL);
     if(sv_isobject(a)) {
       if(strEQ(HvNAME(SvSTASH(SvRV(a))), "Math::GMP") ||
          strEQ(HvNAME(SvSTASH(SvRV(a))), "GMP::Mpz") ||
          strEQ(HvNAME(SvSTASH(SvRV(a))), "Math::GnuMPz"))
         gmp_randinit_lc_2exp(*state, *((mpz_t *) SvIV(SvRV(a))), SvUV(c), SvUV(m2exp));
       else croak("First arg to Rgmp_randinit_lc_2exp is of invalid type");
       }

     else {
       if(!mpz_init_set_str(aa, SvPV_nolen(a), 0)) {
         gmp_randinit_lc_2exp(*state, aa, SvUV(c), SvUV(m2exp));
         mpz_clear(aa);
         }
       else croak("Seedstring supplied to Rgmp_randinit_lc_2exp is not a valid number");
       }

     sv_setiv(obj, (IV)state);
     SvREADONLY_on(obj);
     return obj_ref;
}

SV * Rgmp_randinit_lc_2exp_size(SV * size) {
     gmp_randstate_t * state;
     SV * obj_ref, * obj;

     if(SvUV(size) > 128) croak("The argument supplied to Rgmp_randinit_lc_2exp_size function (%u) needs to be in the range [1..128]", SvUV(size));

     New(1, state, sizeof(gmp_randstate_t), gmp_randstate_t);
     if(state == NULL) croak("Failed to allocate memory in Rgmp_randinit_lc_2exp_size function");
     obj_ref = newSViv(0);
     obj = newSVrv(obj_ref, NULL);

     if(gmp_randinit_lc_2exp_size(*state, SvUV(size))) {
       sv_setiv(obj, (IV)state);
       SvREADONLY_on(obj);
       return obj_ref;
       }

     croak("Rgmp_randinit_lc_2exp_size function failed");
}

void Rgmp_randclear(SV * p) {
     gmp_randclear(*((gmp_randstate_t *) SvIV(SvRV(p))));
     Safefree((gmp_randstate_t *) SvIV(SvRV(p)));
}

void Rgmp_randseed(SV * state, SV * seed) {
     mpz_t s;

     if(sv_isobject(seed)) {
       if(strEQ(HvNAME(SvSTASH(SvRV(seed))), "Math::GMP") ||
          strEQ(HvNAME(SvSTASH(SvRV(seed))), "GMP::Mpz") ||
          strEQ(HvNAME(SvSTASH(SvRV(seed))), "Math::GnuMPz"))
         gmp_randseed(*((gmp_randstate_t *) SvIV(SvRV(state))), *((mpz_t *) SvIV(SvRV(seed))));
       else croak("2nd arg to Rgmp_randseed is of invalid type");
       }

     else {
       if(!mpz_init_set_str(s, SvPV_nolen(seed), 0)) {
         gmp_randseed(*((gmp_randstate_t *) SvIV(SvRV(state))), s);
         mpz_clear(s);
         }
       else croak("Seedstring supplied to Rgmp_randseed is not a valid number");
       }
}

void Rgmp_randseed_ui(SV * state, SV * seed) {
     gmp_randseed_ui(*((gmp_randstate_t *) SvIV(SvRV(state))), SvUV(seed));     
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
	SV *	p
	SV *	prec
	SV *	round

void
DESTROY (p)
	SV *	p
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
	SV *	p
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
	SV *	p
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
	SV *	p
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
	SV *	q
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
Rmpfr_init_set_f (q, round)
	SV *	q
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
	SV *	q
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
	SV *	q
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
	SV *	q
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
Rmpfr_init_set_f_nobless (q, round)
	SV *	q
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
	SV *	q
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
	SV *	q
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
	SV *	p
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
	SV *	p
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
	SV *	p
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
	SV *	p

SV *
Rmpfr_set (p, q, round)
	SV *	p
	SV *	q
	SV *	round

SV *
Rmpfr_set_ui (p, q, round)
	SV *	p
	SV *	q
	SV *	round

SV *
Rmpfr_set_si (p, q, round)
	SV *	p
	SV *	q
	SV *	round

SV *
Rmpfr_set_d (p, q, round)
	SV *	p
	SV *	q
	SV *	round

SV *
Rmpfr_set_z (p, q, round)
	SV *	p
	SV *	q
	SV *	round

SV *
Rmpfr_set_q (p, q, round)
	SV *	p
	SV *	q
	SV *	round

SV *
Rmpfr_set_f (p, q, round)
	SV *	p
	SV *	q
	SV *	round

SV *
Rmpfr_set_str (p, num, base, round)
	SV *	p
	SV *	num
	SV *	base
	SV *	round

void
Rmpfr_set_str_binary (p, str)
	SV *	p
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
	SV *	p
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
	SV *	p
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
	SV *	p
	SV *	q
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
	SV *	p
	SV *	round

SV *
Rmpfr_get_d1 (p)
	SV *	p

SV *
Rmpfr_get_z_exp (z, p)
	SV *	z
	SV *	p

SV *
Rmpfr_add (a, b, c, round)
	SV *	a
	SV *	b
	SV *	c
	SV *	round

SV *
Rmpfr_add_ui (a, b, c, round)
	SV *	a
	SV *	b
	SV *	c
	SV *	round

SV *
Rmpfr_add_z (a, b, c, round)
	SV *	a
	SV *	b
	SV *	c
	SV *	round

SV *
Rmpfr_add_q (a, b, c, round)
	SV *	a
	SV *	b
	SV *	c
	SV *	round

SV *
Rmpfr_sub (a, b, c, round)
	SV *	a
	SV *	b
	SV *	c
	SV *	round

SV *
Rmpfr_sub_ui (a, b, c, round)
	SV *	a
	SV *	b
	SV *	c
	SV *	round

SV *
Rmpfr_sub_z (a, b, c, round)
	SV *	a
	SV *	b
	SV *	c
	SV *	round

SV *
Rmpfr_sub_q (a, b, c, round)
	SV *	a
	SV *	b
	SV *	c
	SV *	round

SV *
Rmpfr_ui_sub (a, b, c, round)
	SV *	a
	SV *	b
	SV *	c
	SV *	round

SV *
Rmpfr_mul (a, b, c, round)
	SV *	a
	SV *	b
	SV *	c
	SV *	round

SV *
Rmpfr_mul_ui (a, b, c, round)
	SV *	a
	SV *	b
	SV *	c
	SV *	round

SV *
Rmpfr_mul_z (a, b, c, round)
	SV *	a
	SV *	b
	SV *	c
	SV *	round

SV *
Rmpfr_mul_q (a, b, c, round)
	SV *	a
	SV *	b
	SV *	c
	SV *	round

SV *
Rmpfr_div (a, b, c, round)
	SV *	a
	SV *	b
	SV *	c
	SV *	round

SV *
Rmpfr_div_ui (a, b, c, round)
	SV *	a
	SV *	b
	SV *	c
	SV *	round

SV *
Rmpfr_div_z (a, b, c, round)
	SV *	a
	SV *	b
	SV *	c
	SV *	round

SV *
Rmpfr_div_q (a, b, c, round)
	SV *	a
	SV *	b
	SV *	c
	SV *	round

SV *
Rmpfr_ui_div (a, b, c, round)
	SV *	a
	SV *	b
	SV *	c
	SV *	round

SV *
Rmpfr_sqrt (a, b, round)
	SV *	a
	SV *	b
	SV *	round

SV *
Rmpfr_cbrt (a, b, round)
	SV *	a
	SV *	b
	SV *	round

SV *
Rmpfr_sqrt_ui (a, b, round)
	SV *	a
	SV *	b
	SV *	round

SV *
Rmpfr_pow_ui (a, b, c, round)
	SV *	a
	SV *	b
	SV *	c
	SV *	round

SV *
Rmpfr_ui_pow_ui (a, b, c, round)
	SV *	a
	SV *	b
	SV *	c
	SV *	round

SV *
Rmpfr_ui_pow (a, b, c, round)
	SV *	a
	SV *	b
	SV *	c
	SV *	round

SV *
Rmpfr_pow_si (a, b, c, round)
	SV *	a
	SV *	b
	SV *	c
	SV *	round

SV *
Rmpfr_pow (a, b, c, round)
	SV *	a
	SV *	b
	SV *	c
	SV *	round

SV *
Rmpfr_neg (a, b, round)
	SV *	a
	SV *	b
	SV *	round

SV *
Rmpfr_abs (a, b, round)
	SV *	a
	SV *	b
	SV *	round

SV *
Rmpfr_mul_2exp (a, b, c, round)
	SV *	a
	SV *	b
	SV *	c
	SV *	round

SV *
Rmpfr_mul_2ui (a, b, c, round)
	SV *	a
	SV *	b
	SV *	c
	SV *	round

SV *
Rmpfr_mul_2si (a, b, c, round)
	SV *	a
	SV *	b
	SV *	c
	SV *	round

SV *
Rmpfr_div_2exp (a, b, c, round)
	SV *	a
	SV *	b
	SV *	c
	SV *	round

SV *
Rmpfr_div_2ui (a, b, c, round)
	SV *	a
	SV *	b
	SV *	c
	SV *	round

SV *
Rmpfr_div_2si (a, b, c, round)
	SV *	a
	SV *	b
	SV *	c
	SV *	round

SV *
Rmpfr_cmp (a, b)
	SV *	a
	SV *	b

SV *
Rmpfr_cmpabs (a, b)
	SV *	a
	SV *	b

SV *
Rmpfr_cmp_ui (a, b)
	SV *	a
	SV *	b

SV *
Rmpfr_cmp_si (a, b)
	SV *	a
	SV *	b

SV *
Rmpfr_cmp_ui_2exp (a, b, c)
	SV *	a
	SV *	b
	SV *	c

SV *
Rmpfr_cmp_si_2exp (a, b, c)
	SV *	a
	SV *	b
	SV *	c

SV *
Rmpfr_eq (a, b, c)
	SV *	a
	SV *	b
	SV *	c

SV *
Rmpfr_nan_p (p)
	SV *	p

SV *
Rmpfr_inf_p (p)
	SV *	p

SV *
Rmpfr_number_p (p)
	SV *	p

void
Rmpfr_reldiff (a, b, c, round)
	SV *	a
	SV *	b
	SV *	c
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
	SV *	p

SV *
Rmpfr_greater_p (a, b)
	SV *	a
	SV *	b

SV *
Rmpfr_greaterequal_p (a, b)
	SV *	a
	SV *	b

SV *
Rmpfr_less_p (a, b)
	SV *	a
	SV *	b

SV *
Rmpfr_lessequal_p (a, b)
	SV *	a
	SV *	b

SV *
Rmpfr_lessgreater_p (a, b)
	SV *	a
	SV *	b

SV *
Rmpfr_equal_p (a, b)
	SV *	a
	SV *	b

SV *
Rmpfr_unordered_p (a, b)
	SV *	a
	SV *	b

SV *
Rmpfr_sin_cos (a, b, c, round)
	SV *	a
	SV *	b
	SV *	c
	SV *	round

SV *
Rmpfr_sin (a, b, round)
	SV *	a
	SV *	b
	SV *	round

SV *
Rmpfr_cos (a, b, round)
	SV *	a
	SV *	b
	SV *	round

SV *
Rmpfr_tan (a, b, round)
	SV *	a
	SV *	b
	SV *	round

SV *
Rmpfr_asin (a, b, round)
	SV *	a
	SV *	b
	SV *	round

SV *
Rmpfr_acos (a, b, round)
	SV *	a
	SV *	b
	SV *	round

SV *
Rmpfr_atan (a, b, round)
	SV *	a
	SV *	b
	SV *	round

SV *
Rmpfr_sinh (a, b, round)
	SV *	a
	SV *	b
	SV *	round

SV *
Rmpfr_cosh (a, b, round)
	SV *	a
	SV *	b
	SV *	round

SV *
Rmpfr_tanh (a, b, round)
	SV *	a
	SV *	b
	SV *	round

SV *
Rmpfr_asinh (a, b, round)
	SV *	a
	SV *	b
	SV *	round

SV *
Rmpfr_acosh (a, b, round)
	SV *	a
	SV *	b
	SV *	round

SV *
Rmpfr_atanh (a, b, round)
	SV *	a
	SV *	b
	SV *	round

SV *
Rmpfr_fac_ui (a, b, round)
	SV *	a
	SV *	b
	SV *	round

SV *
Rmpfr_log1p (a, b, round)
	SV *	a
	SV *	b
	SV *	round

SV *
Rmpfr_expm1 (a, b, round)
	SV *	a
	SV *	b
	SV *	round

SV *
Rmpfr_log2 (a, b, round)
	SV *	a
	SV *	b
	SV *	round

SV *
Rmpfr_log10 (a, b, round)
	SV *	a
	SV *	b
	SV *	round

SV *
Rmpfr_fma (a, b, c, d, round)
	SV *	a
	SV *	b
	SV *	c
	SV *	d
	SV *	round

SV *
Rmpfr_agm (a, b, c, round)
	SV *	a
	SV *	b
	SV *	c
	SV *	round

SV *
Rmpfr_const_log2 (p, round)
	SV *	p
	SV *	round

SV *
Rmpfr_const_pi (p, round)
	SV *	p
	SV *	round

SV *
Rmpfr_const_euler (p, round)
	SV *	p
	SV *	round

void
Rmpfr_print_binary (p)
	SV *	p
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
	SV *	a
	SV *	b
	SV *	round

SV *
Rmpfr_ceil (a, b)
	SV *	a
	SV *	b

SV *
Rmpfr_floor (a, b)
	SV *	a
	SV *	b

SV *
Rmpfr_round (a, b)
	SV *	a
	SV *	b

SV *
Rmpfr_trunc (a, b)
	SV *	a
	SV *	b

SV *
Rmpfr_add_one_ulp (p, round)
	SV *	p
	SV *	round

SV *
Rmpfr_sub_one_ulp (p, round)
	SV *	p
	SV *	round

SV *
Rmpfr_can_round (p, err, round1, round2, prec)
	SV *	p
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
	SV *	p
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
	SV *	a
	SV *	b
	SV *	round

SV *
Rmpfr_exp (a, b, round)
	SV *	a
	SV *	b
	SV *	round

SV *
Rmpfr_exp2 (a, b, round)
	SV *	a
	SV *	b
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
	SV *	p
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
Rmpfr_out_str (p, base, dig, round)
	SV *	p
	SV *	base
	SV *	dig
	SV *	round

SV *
Rmpfr_inp_str (p, base, round)
	SV *	p
	SV *	base
	SV *	round

SV *
Rmpfr_gamma (a, b, round)
	SV *	a
	SV *	b
	SV *	round

SV *
Rmpfr_zeta (a, b, round)
	SV *	a
	SV *	b
	SV *	round

SV *
Rmpfr_erf (a, b, round)
	SV *	a
	SV *	b
	SV *	round

SV *
Rmpfr_frac (a, b, round)
	SV *	a
	SV *	b
	SV *	round

SV *
Rmpfr_integer_p (p)
	SV *	p

void
Rmpfr_nexttoward (a, b)
	SV *	a
	SV *	b
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
	SV *	p
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
	SV *	p
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
	SV *	a
	SV *	b
	SV *	c
	SV *	round

SV *
Rmpfr_max (a, b, c, round)
	SV *	a
	SV *	b
	SV *	c
	SV *	round

SV *
Rmpfr_get_exp (p)
	SV *	p

SV *
Rmpfr_set_exp (p, exp)
	SV *	p
	SV *	exp

SV *
get_refcnt (s)
	SV *	s

SV *
overload_mul (a, b, third)
	SV *	a
	SV *	b
	SV *	third

SV *
overload_mul_eq (a, b, third)
	SV *	a
	SV *	b
	SV *	third

SV *
overload_add (a, b, third)
	SV *	a
	SV *	b
	SV *	third

SV *
overload_add_eq (a, b, third)
	SV *	a
	SV *	b
	SV *	third

SV *
overload_sub (a, b, third)
	SV *	a
	SV *	b
	SV *	third

SV *
overload_sub_eq (a, b, third)
	SV *	a
	SV *	b
	SV *	third

SV *
overload_div (a, b, third)
	SV *	a
	SV *	b
	SV *	third

SV *
overload_div_eq (a, b, third)
	SV *	a
	SV *	b
	SV *	third

SV *
overload_copy (p, second, third)
	SV *	p
	SV *	second
	SV *	third

SV *
overload_abs (p, second, third)
	SV *	p
	SV *	second
	SV *	third

SV *
overload_gt (a, b, third)
	SV *	a
	SV *	b
	SV *	third

SV *
overload_gte (a, b, third)
	SV *	a
	SV *	b
	SV *	third

SV *
overload_lt (a, b, third)
	SV *	a
	SV *	b
	SV *	third

SV *
overload_lte (a, b, third)
	SV *	a
	SV *	b
	SV *	third

SV *
overload_spaceship (a, b, third)
	SV *	a
	SV *	b
	SV *	third

SV *
overload_equiv (a, b, third)
	SV *	a
	SV *	b
	SV *	third

SV *
overload_not_equiv (a, b, third)
	SV *	a
	SV *	b
	SV *	third

SV *
overload_not (a, second, third)
	SV *	a
	SV *	second
	SV *	third

SV *
overload_sqrt (p, second, third)
	SV *	p
	SV *	second
	SV *	third

SV *
overload_pow (p, second, third)
	SV *	p
	SV *	second
	SV *	third

SV *
overload_pow_eq (p, second, third)
	SV *	p
	SV *	second
	SV *	third

SV *
overload_log (p, second, third)
	SV *	p
	SV *	second
	SV *	third

SV *
overload_exp (p, second, third)
	SV *	p
	SV *	second
	SV *	third

SV *
overload_sin (p, second, third)
	SV *	p
	SV *	second
	SV *	third

SV *
overload_cos (p, second, third)
	SV *	p
	SV *	second
	SV *	third

SV *
overload_int (p, second, third)
	SV *	p
	SV *	second
	SV *	third

SV *
overload_atan2 (a, b, third)
	SV *	a
	SV *	b
	SV *	third

SV *
get_package_name (x)
	SV *	x

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

