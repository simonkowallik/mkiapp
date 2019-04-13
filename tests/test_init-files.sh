#!/usr/bin/env bash
set -ev

# prepare for tests
export PATH="$PATH:$(pwd)"
export BASEDIR=$(pwd)
mkdir ./test_initfiles
cd ./test_initfiles

# init files in current working directory
mkiapp init-files >/dev/null || exit 1

# check if all init-files exist
ls ./macro.tcl || exit 1
ls ./help.html || exit 1
ls ./implementation.tcl || exit 1
ls ./presentation.tcl || exit 1

# init files in ./src directory
mkiapp init-files ./src >/dev/null || exit 1

# check if all init-files in ./src exist
ls ./src/macro.tcl || exit 1
ls ./src/help.html || exit 1
ls ./src/implementation.tcl || exit 1
ls ./src/presentation.tcl || exit 1
