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

AC_OUTPUT
