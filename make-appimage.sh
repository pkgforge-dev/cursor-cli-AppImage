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
quick-sharun ./AppDir/bin/*

# make bash script posix, doesn't need many changes
sed -i \
	-e 's|#!/usr/bin/env bash|#!/bin/sh|' \
	-e 's|set -euo pipefail|set -eu|'     \
	./AppDir/bin/cursor-agent

# Turn AppDir into AppImage
quick-sharun --make-appimage
