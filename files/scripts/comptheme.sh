#!/bin/bash
set -e

# 1. Install build dependencies needed for AeroThemePlasma
dnf5 -y install \
    gcc gcc-c++ cmake ninja-build extra-cmake-modules git unzip kvantum \
    qt6-qtbase-devel qt6-qtbase-private-devel qt6-qtdeclarative-devel \
    qt6-qtmultimedia-devel qt6-qt5compat-devel qt6-qtwayland-devel qt6-qtsvg-devel \
    wayland-devel wayland-protocols-devel plasma-wayland-protocols-devel \
    layer-shell-qt-devel kwin-devel libksysguard-devel \
    plasma-workspace-devel libplasma-devel plasma-activities-devel plasma-activities-stats-devel plasma5support-devel \
    kf6-kcoreaddons-devel kf6-kcolorscheme-devel kf6-kpackage-devel kf6-kglobalaccel-devel \
    kf6-ksvg-devel kf6-kcrash-devel kf6-kguiaddons-devel kf6-kcmutils-devel kf6-kio-devel \
    kf6-ki18n-devel kf6-knotifications-devel kf6-kirigami-devel kf6-kiconthemes-devel \
    kf6-knewstuff-devel kf6-knotifyconfig-devel kf6-attica-devel kf6-krunner-devel \
    kf6-kdbusaddons-devel kf6-sonnet-devel kf6-kauth-devel kf6-kconfig-devel kf6-kcodecs-devel \
    kf6-kxmlgui-devel kf6-kwindowsystem-devel kf6-kservice-devel kf6-kwidgetsaddons-devel \

# 2. Clone AeroThemePlasma source
git clone --depth 1 https://gitgud.io/aeroshell/atp/aerothemeplasma.git /tmp/atp
cd /tmp/atp

# 3. Build and install ATP directly into system paths (/usr)
LIBEXEC_DIR=libexec UAC_LIBEXEC_DIR=libexec/kf6 CMAKE_GENERATOR=Ninja CMAKE_PREFIX_PATH=/usr bash install.sh

# 4. Clean up temporary files & all build-time dev dependencies to keep image size minimal
rm -rf /tmp/atp
dnf5 -y remove \
    gcc gcc-c++ cmake ninja-build extra-cmake-modules git unzip \
    qt6-qtbase-devel qt6-qtbase-private-devel qt6-qtdeclarative-devel \
    qt6-qtmultimedia-devel qt6-qt5compat-devel qt6-qtwayland-devel qt6-qtsvg-devel \
    wayland-devel wayland-protocols-devel plasma-wayland-protocols-devel \
    layer-shell-qt-devel kwin-devel libksysguard-devel \
    plasma-workspace-devel libplasma-devel plasma-activities-devel plasma-activities-stats-devel plasma5support-devel \
    kf6-kcoreaddons-devel kf6-kcolorscheme-devel kf6-kpackage-devel kf6-kglobalaccel-devel \
    kf6-ksvg-devel kf6-kcrash-devel kf6-kguiaddons-devel kf6-kcmutils-devel kf6-kio-devel \
    kf6-ki18n-devel kf6-knotifications-devel kf6-kirigami-devel kf6-kiconthemes-devel \
    kf6-knewstuff-devel kf6-knotifyconfig-devel kf6-attica-devel kf6-krunner-devel \
    kf6-kdbusaddons-devel kf6-sonnet-devel kf6-kauth-devel kf6-kconfig-devel kf6-kcodecs-devel \
    kf6-kxmlgui-devel kf6-kwindowsystem-devel kf6-kservice-devel kf6-kwidgetsaddons-devel \
dnf5 clean all