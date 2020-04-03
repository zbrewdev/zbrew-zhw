#!/bin/sh
#*******************************************************************************
# Licensed Materials - Property of IBM
# (c) Copyright IBM Corporation 2019. All Rights Reserved.
#
# Note to U.S. Government Users Restricted Rights:
# Use, duplication or disclosure restricted by GSA ADP Schedule
# Contract with IBM Corp.
#*******************************************************************************
#
# Run through each of the tests in the test bucket that aren't 
# explicitly excluded, and return the highest error code
#
. zbrewsetenv

export PATH=$ZBREW_ROOT/testtools:$PATH
. zbrewtestfuncs

#
# Override the ZBREW_SRC_HLQ to ensure test datasets go to ZHWT instead of ZBREW
#
export ZBREW_SRC_HLQ=ZBREWVS.
export ZBREW_SRC_ZFSROOT=/zbrew/zhwvs/
export ZBREW_TGT_HLQ=ZBREWVT.
export ZBREW_TGT_ZFSROOT=/zbrew/zhwvt/

runtests "${mydir}/tests" "$1"
exit $?
