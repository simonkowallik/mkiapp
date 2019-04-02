#!/usr/bin/env bash
set -ev

# prepare for tests
export PATH="$PATH:$(pwd)"
export BASEDIR=$(pwd)
mkdir ./test_init
cd ./test_init

# init mkiapp in current directory
mkiapp init-files >/dev/null || exit 1

# check if all init-files exist
ls ./macro.tcl || exit 1
ls ./help.html || exit 1
ls ./implementation.tcl || exit 1
ls ./presentation.tcl || exit 1