#! /bin/sh

CMAKE_BIN=$1

R_BIN_FOLDER=${R_HOME}/bin${R_ARCH_BIN}
R_BIN=${R_BIN_FOLDER}/R
RSCRIPT_BIN=${R_BIN_FOLDER}/Rscript

NCORES=`${RSCRIPT_BIN} -e "cat(min(2, parallel::detectCores(logical = FALSE), na.rm=TRUE))"`

dot() { file=$1; shift; . "$file"; }
dot tools/r_config.sh ${R_BIN}

${RSCRIPT_BIN} --vanilla -e 'getRversion() > "4.0.0"' | grep TRUE > /dev/null
if [ $? -eq 0 ]; then
  AR=`"${R_BIN}" CMD config AR`
 	AR=`which "$AR"`
  CMAKE_ADD_AR="-D CMAKE_AR=${AR}"

  RANLIB=`"${R_BIN}" CMD config RANLIB`
 	RANLIB=`which "$RANLIB"`
  CMAKE_ADD_RANLIB="-D CMAKE_RANLIB=${RANLIB}"
else
  CMAKE_ADD_AR=""
  CMAKE_ADD_RANLIB=""
fi

cd src
mkdir nlopt
mkdir -p build && cd build

${CMAKE_BIN} \
  -D BUILD_SHARED_LIBS=OFF \
  -D CMAKE_BUILD_TYPE=Release \
  -D CMAKE_INSTALL_PREFIX=../nlopt \
  -D CMAKE_POSITION_INDEPENDENT_CODE=ON \
  -D NLOPT_CXX=OFF \
  -D NLOPT_FORTRAN=OFF \
  -D NLOPT_GUILE=OFF \
  -D NLOPT_JAVA=OFF \
  -D NLOPT_LUKSAN=ON \
  -D NLOPT_MATLAB=OFF \
  -D NLOPT_OCTAVE=OFF \
  -D NLOPT_PYTHON=OFF \
  -D NLOPT_SWIG=OFF \
  -D NLOPT_TESTS=OFF \
  -D NLOPT_R_BINDIR=${R_BIN_FOLDER} \
  ${CMAKE_ADD_AR} ${CMAKE_ADD_RANLIB} ../libs
make -j${NCORES}
make install
cd ..
rm -fr build
