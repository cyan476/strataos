#!/bin/bash
set -e

# 1. Install build dependencies needed for AeroThemePlasma
dnf5 -y install gcc gcc-c++ cmake ninja-build extra-cmake-modules \
    plasma-workspace-devel libksysguard-devel kvantum qt6-qtmultimedia-devel \
    qt6-qt5compat-devel libplasma-devel qt6-qtbase-devel qt6-qtwayland-devel \
    plasma-activities-devel kf6-kpackage-devel kf6-kglobalaccel-devel \
    qt6-qtsvg-devel wayland-devel git unzip plasma-wayland-protocols-devel

# 2. Clone AeroThemePlasma source
git clone --depth 1 https://gitgud.io/aeroshell/atp/aerothemeplasma.git /tmp/atp
cd /tmp/atp

# 3. Build and install ATP directly into system paths (/usr)
LIBEXEC_DIR=libexec UAC_LIBEXEC_DIR=libexec/kf6 CMAKE_GENERATOR=Ninja CMAKE_PREFIX_PATH=/usr bash install.sh

# 4. Clean up temporary files & build tools to keep ISO size minimal
rm -rf /tmp/atp
dnf5 -y remove gcc gcc-c++ cmake ninja-build extra-cmake-modules
dnf5 clean all
