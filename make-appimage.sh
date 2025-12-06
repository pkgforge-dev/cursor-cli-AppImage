#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q cursor-cli | awk '{print $2; exit}') # example command to get version of application here
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.bg.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=DUMMY
export DESKTOP=DUMMY

# Deploy dependencies
quick-sharun /opt/cursor-agent/* /usr/bin/rg /usr/bin/node

# Additional changes can be done in between here

# Turn AppDir into AppImage
quick-sharun --make-appimage
