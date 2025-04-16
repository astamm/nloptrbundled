#### R CONFIGURATION ####

R_BIN=$1

CC=`"${R_BIN}" CMD config CC`
if test -z "${CC}"; then
  echo ""
  echo "------------------ C COMPILER NOT FOUND --------------------"
  echo ""
  echo "Please set the CC environment variable to the C compiler you want to use."
  echo "For example, if you want to use gcc, run the following command:"
  echo "export CC=gcc"
  echo "------------------------------------------------------------"
  echo ""

  exit 1
fi
echo set CC=$CC
export CC

CPPFLAGS=`"${R_BIN}" CMD config CPPFLAGS`
CFLAGS=`"${R_BIN}" CMD config CFLAGS`
CPICFLAGS=`"${R_BIN}" CMD config CPICFLAGS`

CFLAGS="$CPPFLAGS $CPICFLAGS $CFLAGS"
echo set CFLAGS=$CFLAGS
export CFLAGS

CXX=`"${R_BIN}" CMD config CXX11`
if test -z "${CXX}"; then
  echo ""
  echo "------------------ C++ COMPILER NOT FOUND -------------------"
  echo ""
  echo "Please set the CXX environment variable to the C++ compiler you want to use."
  echo "For example, if you want to use g++, run the following command:"
  echo "export CXX=g++"
  echo "------------------------------------------------------------"
  echo ""

  exit 1
fi
echo set CXX=$CXX
export CXX

CXXSTD=`"${R_BIN}" CMD config CXX11STD`
CXXFLAGS=`"${R_BIN}" CMD config CXX11FLAGS`
CXXPICFLAGS=`"${R_BIN}" CMD config CXX11PICFLAGS`

CXXFLAGS="$CXXSTD $CPPFLAGS $CXXPICFLAGS $CXXFLAGS"
echo set CXXFLAGS=$CXXFLAGS
export CXXFLAGS

LDFLAGS=`"${R_BIN}" CMD config LDFLAGS`
echo set LDFLAGS=$LDFLAGS
export LDFLAGS
