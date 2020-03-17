#!/bin/sh
#
# Install zhw with a few overrides and then ensure the zFS files are laid down
#
. zbrewsetenv
#set -x

sw='zhw110'

zosinfo=`uname -rsvI`
version=`echo ${zosinfo} | awk '{ print $3; }'`
release=`echo ${zosinfo} | awk '{ print $2; }'`

case ${release} in
	'03.00' ) 
		export ZBREW_ZOS230_CSI='MVS.GLOBAL.CSI'
		;;
	'04.00' )
		export ZBREW_ZOS240_CSI='MVS.GLOBAL.CSI'
		;;
esac

zbrew -c install zhw110
rc=$?
if [ $rc != 0 ]; then
        echo "zbrew install clean failed with rc:$rc" >&2
        exit 3
fi

zbrew smpreceiveptf zhw110 MCSPTF2  
rc=$?
if [ $rc != 0 ]; then
        echo "zbrew receive ptf from z/os file failed with rc:$rc" >&2
        exit 4
fi

zbrew update zhw110
rc=$?
if [ $rc != 0 ]; then
        echo "zbrew update of zhw110 failed with rc:$rc" >&2
        exit 5
fi

zbrew configure zhw110
rc=$?
if [ $rc != 0 ]; then
        echo "zbrew configure failed with rc:$rc" >&2
        exit 6
fi

zbrew deconfigure zhw110
rc=$?
if [ $rc != 0 ]; then
        echo "zbrew uninstall failed with rc:$rc" >&2
        exit 7
fi

zbrew uninstall zhw110
rc=$?
if [ $rc != 0 ]; then
        echo "zbrew uninstall failed with rc:$rc" >&2
        exit 8
fi

exit 0
