#ifndef __NLOPTR_H__
#define __NLOPTR_H__

#ifdef __cplusplus
extern "C" {
#endif

#include <R.h>
#include <Rinternals.h> // Rdefines.h is no longer maintained.

SEXP NLoptR_Optimize(SEXP args);

#ifdef __cplusplus
}
#endif

#endif /*__NLOPTR_H__*/
