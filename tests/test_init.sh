#!/usr/bin/env bash
set -ev

# prepare for tests
export PATH="$PATH:$(pwd)"
export BASEDIR=$(pwd)
mkdir ./test_init
cd ./test_init

# create section files
mkdir ./src
touch ./src/macro.tcl
touch ./src/help.html
touch ./src/implementation.tcl
touch ./src/presentation.tcl

# init mkiapp in current directory
mkiapp init >/dev/null || exit 1

# test if all section files have been detected and loaded to the correct variable 
grep -e 'src/macro.tcl' .mkiapp | grep 'MKIAPP_SECTIONFILE_MACRO' || exit 1
grep -e 'src/help.html' .mkiapp | grep 'MKIAPP_SECTIONFILE_HELP' || exit 1
grep -e 'src/implementation.tcl' .mkiapp | grep 'MKIAPP_SECTIONFILE_IMPLEMENTATION' || exit 1
grep -e 'src/presentation.tcl' .mkiapp | grep 'MKIAPP_SECTIONFILE_PRESENTATION' || exit 1