#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
# pacman -Syu --noconfirm PACKAGESHERE

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

# Comment this out if you need an AUR package
export PRE_BUILD_CMDS="
  sed -i -e '/\/usr\/bin\/node/d' ./PKGBUILD
  sed -i -e '/\/usr\/bin\/rg/d' ./PKGBUILD
"
make-aur-package cursor-cli

# If the application needs to be manually built that has to be done down here
