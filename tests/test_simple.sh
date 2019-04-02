#!/usr/bin/env bash
set -ev

# prepare for tests
export PATH="$PATH:$(pwd)"
export BASEDIR=$(pwd)
cd ./examples/simple

# init mkiapp in current directory
mkiapp init >/dev/null || exit 1

# update iapp name
mkiapp config MKIAPP_IAPP_NAME simple_test || exit 1
grep 'MKIAPP_IAPP_NAME.*simple_test.*' .mkiapp >/dev/null || exit 1

# generate iApp
mkiapp -t $BASEDIR/tests/template.tmpl > iapp.tmpl || exit 1

# check if iApp differs from expected result
diff $BASEDIR/tests/test_simple.tmpl iapp.tmpl || exit 1