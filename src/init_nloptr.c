/*
 * Copyright (C) 2017 Jelmer Ypma. All Rights Reserved.
 * This code is published under the L-GPL.
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published
 * by the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * File:   init_nloptr.c
 * Author: Jelmer Ypma
 * Date:   3 October 2017
 *
 * This file registers C functions to be used from R.
 *
 * CHANGELOG:
 * 2017-10-01: Initial version.
 * 2017-10-03: Included registering of C functions to be used by external R
 *             packages.
 * 2023-02-07: Use "modern" method for invoking native routine registration
 *             (Avraham Adler).
 * 2023-08-24: Delete files solely needed for testthat (Avraham Adler).
 * 2024-07-02: Updated old include which is no longer maintained and other
 *             minor code tweaks and efficiency enhancements (Avraham Adler).
 */

#include <R.h>
#include <Rinternals.h>
#include <stdlib.h> // for NULL
#include <R_ext/Rdynload.h>

#include "nloptr.h"
#include <nlopt.h>

static const R_CallMethodDef CallEntries[] = {
  {"NLoptR_Optimize",    (DL_FUNC) &NLoptR_Optimize,    1},
  {NULL, NULL, 0}
};

void R_init_nloptrbundled(DllInfo *info) {
    // Register C functions that can be used by external packages
    // linking to internal NLopt code from C.
    R_RegisterCCallable("nloptrbundled", "nlopt_algorithm_name",            (DL_FUNC) &nlopt_algorithm_name);
    R_RegisterCCallable("nloptrbundled", "nlopt_srand",                     (DL_FUNC) &nlopt_srand);
    R_RegisterCCallable("nloptrbundled", "nlopt_srand_time",                (DL_FUNC) &nlopt_srand_time);
    R_RegisterCCallable("nloptrbundled", "nlopt_version",                   (DL_FUNC) &nlopt_version);
    R_RegisterCCallable("nloptrbundled", "nlopt_create",                    (DL_FUNC) &nlopt_create);
    R_RegisterCCallable("nloptrbundled", "nlopt_destroy",                   (DL_FUNC) &nlopt_destroy);
    R_RegisterCCallable("nloptrbundled", "nlopt_copy",                      (DL_FUNC) &nlopt_copy);
    R_RegisterCCallable("nloptrbundled", "nlopt_optimize",                  (DL_FUNC) &nlopt_optimize);
    R_RegisterCCallable("nloptrbundled", "nlopt_set_min_objective",         (DL_FUNC) &nlopt_set_min_objective);
    R_RegisterCCallable("nloptrbundled", "nlopt_set_max_objective",         (DL_FUNC) &nlopt_set_max_objective);
    R_RegisterCCallable("nloptrbundled", "nlopt_set_precond_min_objective", (DL_FUNC) &nlopt_set_precond_min_objective);
    R_RegisterCCallable("nloptrbundled", "nlopt_set_precond_max_objective", (DL_FUNC) &nlopt_set_precond_max_objective);
    R_RegisterCCallable("nloptrbundled", "nlopt_get_algorithm",             (DL_FUNC) &nlopt_get_algorithm);
    R_RegisterCCallable("nloptrbundled", "nlopt_get_dimension",             (DL_FUNC) &nlopt_get_dimension);

    R_RegisterCCallable("nloptrbundled", "nlopt_set_lower_bounds",                  (DL_FUNC) &nlopt_set_lower_bounds);
    R_RegisterCCallable("nloptrbundled", "nlopt_set_lower_bounds1",                 (DL_FUNC) &nlopt_set_lower_bounds1);
    R_RegisterCCallable("nloptrbundled", "nlopt_get_lower_bounds",                  (DL_FUNC) &nlopt_get_lower_bounds);
    R_RegisterCCallable("nloptrbundled", "nlopt_set_upper_bounds",                  (DL_FUNC) &nlopt_set_upper_bounds);
    R_RegisterCCallable("nloptrbundled", "nlopt_set_upper_bounds1",                 (DL_FUNC) &nlopt_set_upper_bounds1);
    R_RegisterCCallable("nloptrbundled", "nlopt_get_upper_bounds",                  (DL_FUNC) &nlopt_get_upper_bounds);
    R_RegisterCCallable("nloptrbundled", "nlopt_remove_inequality_constraints",     (DL_FUNC) &nlopt_remove_inequality_constraints);
    R_RegisterCCallable("nloptrbundled", "nlopt_add_inequality_constraint",         (DL_FUNC) &nlopt_add_inequality_constraint);
    R_RegisterCCallable("nloptrbundled", "nlopt_add_precond_inequality_constraint", (DL_FUNC) &nlopt_add_precond_inequality_constraint);
    R_RegisterCCallable("nloptrbundled", "nlopt_add_inequality_mconstraint",        (DL_FUNC) &nlopt_add_inequality_mconstraint);
    R_RegisterCCallable("nloptrbundled", "nlopt_remove_equality_constraints",       (DL_FUNC) &nlopt_remove_equality_constraints);
    R_RegisterCCallable("nloptrbundled", "nlopt_add_equality_constraint",           (DL_FUNC) &nlopt_add_equality_constraint);
    R_RegisterCCallable("nloptrbundled", "nlopt_add_precond_equality_constraint",   (DL_FUNC) &nlopt_add_precond_equality_constraint);
    R_RegisterCCallable("nloptrbundled", "nlopt_add_equality_mconstraint",          (DL_FUNC) &nlopt_add_equality_mconstraint);

    R_RegisterCCallable("nloptrbundled", "nlopt_set_stopval",    (DL_FUNC) &nlopt_set_stopval);
    R_RegisterCCallable("nloptrbundled", "nlopt_get_stopval",    (DL_FUNC) &nlopt_get_stopval);
    R_RegisterCCallable("nloptrbundled", "nlopt_set_ftol_rel",   (DL_FUNC) &nlopt_set_ftol_rel);
    R_RegisterCCallable("nloptrbundled", "nlopt_get_ftol_rel",   (DL_FUNC) &nlopt_get_ftol_rel);
    R_RegisterCCallable("nloptrbundled", "nlopt_set_ftol_abs",   (DL_FUNC) &nlopt_set_ftol_abs);
    R_RegisterCCallable("nloptrbundled", "nlopt_get_ftol_abs",   (DL_FUNC) &nlopt_get_ftol_abs);
    R_RegisterCCallable("nloptrbundled", "nlopt_set_xtol_rel",   (DL_FUNC) &nlopt_set_xtol_rel);
    R_RegisterCCallable("nloptrbundled", "nlopt_get_xtol_rel",   (DL_FUNC) &nlopt_get_xtol_rel);
    R_RegisterCCallable("nloptrbundled", "nlopt_set_xtol_abs1",  (DL_FUNC) &nlopt_set_xtol_abs1);
    R_RegisterCCallable("nloptrbundled", "nlopt_set_xtol_abs",   (DL_FUNC) &nlopt_set_xtol_abs);
    R_RegisterCCallable("nloptrbundled", "nlopt_get_xtol_abs",   (DL_FUNC) &nlopt_get_xtol_abs);
    R_RegisterCCallable("nloptrbundled", "nlopt_set_maxeval",    (DL_FUNC) &nlopt_set_maxeval);
    R_RegisterCCallable("nloptrbundled", "nlopt_get_maxeval",    (DL_FUNC) &nlopt_get_maxeval);
    R_RegisterCCallable("nloptrbundled", "nlopt_set_maxtime",    (DL_FUNC) &nlopt_set_maxtime);
    R_RegisterCCallable("nloptrbundled", "nlopt_get_maxtime",    (DL_FUNC) &nlopt_get_maxtime);
    R_RegisterCCallable("nloptrbundled", "nlopt_force_stop",     (DL_FUNC) &nlopt_force_stop);
    R_RegisterCCallable("nloptrbundled", "nlopt_set_force_stop", (DL_FUNC) &nlopt_set_force_stop);
    R_RegisterCCallable("nloptrbundled", "nlopt_get_force_stop", (DL_FUNC) &nlopt_get_force_stop);

    R_RegisterCCallable("nloptrbundled", "nlopt_set_local_optimizer",      (DL_FUNC) &nlopt_set_local_optimizer);
    R_RegisterCCallable("nloptrbundled", "nlopt_set_population",           (DL_FUNC) &nlopt_set_population);
    R_RegisterCCallable("nloptrbundled", "nlopt_get_population",           (DL_FUNC) &nlopt_get_population);
    R_RegisterCCallable("nloptrbundled", "nlopt_set_vector_storage",       (DL_FUNC) &nlopt_set_vector_storage);
    R_RegisterCCallable("nloptrbundled", "nlopt_get_vector_storage",       (DL_FUNC) &nlopt_get_vector_storage);
    R_RegisterCCallable("nloptrbundled", "nlopt_set_default_initial_step", (DL_FUNC) &nlopt_set_default_initial_step);
    R_RegisterCCallable("nloptrbundled", "nlopt_set_initial_step",         (DL_FUNC) &nlopt_set_initial_step);
    R_RegisterCCallable("nloptrbundled", "nlopt_set_initial_step1",        (DL_FUNC) &nlopt_set_initial_step1);
    R_RegisterCCallable("nloptrbundled", "nlopt_get_initial_step",         (DL_FUNC) &nlopt_get_initial_step);

    // Register routines to improve lookup from R using .Call interface.
    R_registerRoutines(info, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(info, FALSE);
    R_forceSymbols(info, TRUE);
}
