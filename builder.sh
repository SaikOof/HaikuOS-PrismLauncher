#!/bin/sh
export DEPS="cmake coreutils gcc git openjdk14_default qt5_devel sed"
pkgman install $DEPS

git clone --recursive https://github.com/PrismLauncher/PrismLauncher src
mkdir -p "install/jars"

#START patching files
sed -i '0,/.*include(KDEInstallDirs).*/s/.*include(KDEInstallDirs).*/set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}\/libraries\/extra-cmake-modules\/kde-modules;${CMAKE_MODULE_PATH}")\n&/' src/CMakeLists.txt
sed -i 's/#error Unsupported operating system./QString finishCmd = FS::PathCombine(m_root, BuildConfig.LAUNCHER_NAME);/' src/launcher/UpdateController.cpp
#END patching files

cmake -S src -B src/build \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_INSTALL_PREFIX="install" \
      -DENABLE_LTO=ON \
      -DECM_MODULE_DIR="libraries/extra-cmake-modules/modules" \

#Not using one thread causes the build to get stuck at 99%
cmake --build src/build -j1
cmake --install src/build

mv install/bin/launcher install
mv install/share/prismlauncher/* install/jars

rmdir bin
rm -rf share
