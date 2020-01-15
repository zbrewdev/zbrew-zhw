#!/bin/sh
#set -x
function syntax {
	echo "Syntax: deploy.sh <directory>"
	echo " deploy the bill of materials to the specified directory"
	return 0
}

if [ $# -ne 1 ]; then
	echo "Need to provide a directory to deploy to. No parameter given."
	syntax
	exit 16
fi
if [ ! -d $1 ]; then 
	echo "Need to specify a directory to deploy to. $1 is not a directory."
	syntax
	exit 16
fi

rm -rf $1/zhw110
mkdir $1/zhw110
mkdir $1/zhw110/docs
mkdir $1/zhw110/docs/C
mkdir $1/zhw110/docs/C/cat1
mkdir $1/zhw110/smphold
mkdir $1/zhw110/smpmcs
mkdir $1/zhw110/smprelf

names=`cat zhw110.bom`
code="${names}"
 
for c in ${code}; do
	cp -p ${c} $1/${c}
done

exit $? 
