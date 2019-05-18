#!/usr/bin/env bash
set -ev

# test for issue: only the first occurrence of MKIAPP_FILE_ is included when re-using the same variable #3

# prepare for tests
export PATH="$PATH:$(pwd)"
export BASEDIR=$(pwd)
mkdir -p ./MKIAPP_FILE
cd ./MKIAPP_FILE

# init mkiapp in current directory
mkiapp init >/dev/null || exit 1

# add two MKIAPP_FILE_ statements
echo '# first' >> implementation.tcl
echo '# <MKIAPP_FILE_TEST>' >> implementation.tcl
echo '# second' >> implementation.tcl
echo '# <MKIAPP_FILE_TEST>' >> implementation.tcl

# prepare test.include
cat<<EOF > test.include
test.include:line one
test.include:line two
EOF

# create MKIAPP_FILE_TEST in mkiapp config
mkiapp config MKIAPP_FILE_TEST test.include

# generate iApp
mkiapp -t $BASEDIR/tests/template.tmpl > iapp.tmpl || exit 1

# check if iApp differs from expected result
diff $BASEDIR/tests/test_multiple_MKIAPP_FILE.tmpl iapp.tmpl || exit 1
