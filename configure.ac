# require at least autoconf 2.61
AC_PREREQ([2.69])
AC_INIT([nloptrbundled],[0.0.1])

: ${R_HOME=`R RHOME`}
if test -z "${R_HOME}"; then
  echo "could not determine R_HOME"
  exit 1
fi

AC_PATH_PROG(CMAKE_BIN, cmake, no)
if test x"${CMAKE_BIN}" = x"no"; then
   . tools/cmake_config.sh
   if test -z "${CMAKE_BIN}"; then
      ## also error to end configure here
      AC_MSG_ERROR([Could not find 'cmake'.])
   fi
fi
tools/cmake_call.sh "$CMAKE_BIN"

## does the actual copy of the headers into inst/include
headers_location="src/nlopt/include"
AC_MSG_RESULT([Copying headers found in ${headers_location} into inst/include/nloptr])
mkdir -p inst/include/nloptr
# nlopt.h
NLOPT_H=${headers_location}/nlopt.h
AC_CHECK_FILE("${NLOPT_H}", [cp "${NLOPT_H}" inst/include/nloptr/nlopt.h])
# nlopt.hpp
NLOPT_HPP=${headers_location}/nlopt.hpp
AC_CHECK_FILE("${NLOPT_HPP}", [cp "${NLOPT_HPP}" inst/include/nloptr/nlopt.hpp])
# nlopt.f
NLOPT_F=${headers_location}/nlopt.f
AC_CHECK_FILE("${NLOPT_F}", [cp "${NLOPT_F}" inst/include/nloptr/nlopt.f])

AC_OUTPUT
