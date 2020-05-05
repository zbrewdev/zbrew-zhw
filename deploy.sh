#!/bin/sh
. zbrewsetenv 

zbrewdeploy "$1" zbrew-zhwbin.bom
exit $? 
