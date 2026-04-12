#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q cursor-cli | awk '{print $2; exit}') # example command to get version of application here
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.bg.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=https://github.com/user-attachments/assets/0de7bd75-fd58-44f0-ba5f-74bad7261a3b
export DESKTOP=DUMMY
export MAIN_BIN=cursor-agent

# Deploy dependencies
quick-sharun $(find ./AppDir/bin ! -name '*.node' -executable) /usr/bin/bash

# This is hardcoded to look into /usr/bin/ldd and causes a crash on musl systems
# looks like we only need to patch this path away, it seems to work without it
sed -i -e 's|/usr/bin/ldd|/XXX/YYY/ZZZ|g' ./AppDir/bin/*

# Turn AppDir into AppImage
quick-sharun --make-appimage
