#!/usr/bin/env bash
set -ev

# prepare for tests
export PATH="$PATH:$(pwd)"
export BASEDIR=$(pwd)
mkdir ./test_version_attributes
cd ./test_version_attributes

# init mkiapp in current directory
mkiapp init >/dev/null || exit 1

# create init files
mkiapp init-files >/dev/null || exit 1

# mkiapp config variables
mkiapp config MKIAPP_VAR_MINVERSION 11.6.0
mkiapp config MKIAPP_VAR_MAXVERSION 13.1.0
mkiapp config MKIAPP_VAR_TMSH_VERSION 12.1.0

# create iapp template
mkiapp > iapp.tmpl || exit 1

# check versions match expected value
grep '#TMSH-VERSION: 12.1.0' iapp.tmpl || exit 1
grep 'requires-bigip-version-max 13.1.0' iapp.tmpl || exit 1
grep 'requires-bigip-version-min 11.6.0' iapp.tmpl || exit 1