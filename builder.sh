#!/bin/sh
#INSERT THIS SCRIPT INSIDE A FOLDER BEFORE RUNNING

export DEPS="cmake coreutils gcc git openjdk14_default qt5_devel sed"
pkgman install $DEPS

mkdir "install"
#START patching files
sed -i '0,/.*include(KDEInstallDirs).*/s/.*include(KDEInstallDirs).*/set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}\/libraries\/extra-cmake-modules\/kde-modules;${CMAKE_MODULE_PATH}")\n&/' src/CMakeLists.txt
#sed ''
#END patching files

cmake -S src -B src/build \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_INSTALL_PREFIX="install" \
      -DENABLE_LTO=ON \
      -DECM_MODULE_DIR="libraries/extra-cmake-modules/modules" \

cmake --build src/build -j1
cmake --install src/build
