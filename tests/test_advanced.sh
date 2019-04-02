#!/usr/bin/env bash
set -ev

# prepare for tests
export PATH="$PATH:$(pwd)"
export BASEDIR=$(pwd)
cd ./examples/advanced

# init mkiapp in current directory
mkiapp init >/dev/null || exit 1

# update iapp name
mkiapp config MKIAPP_IAPP_NAME adv_test || exit 1
grep 'MKIAPP_IAPP_NAME.*adv_test.*' .mkiapp >/dev/null || exit 1

# update section files
mkiapp config MKIAPP_SECTIONFILE_IMPLEMENTATION impl.tcl || exit 1
mkiapp config MKIAPP_SECTIONFILE_MACRO irule_macro.tcl || exit 1

# add MKIAPP_FILE for HTML response
mkiapp config MKIAPP_FILE_HTMLRESPONSE ./htmlresponse.html || exit 1

# export current version & generate iApp
export MKIAPP_ENV_PRESENTATION_VERSION=v01
mkiapp -t $BASEDIR/tests/template.tmpl > iapp.tmpl || exit 1

# check if iApp differs from expected result
diff $BASEDIR/tests/test_advanced.tmpl iapp.tmpl || exit 1