#!/bin/sh
#
# Install zhw with a few overrides and then ensure the zFS files are laid down
#
#set -x
. zbrewsetenv

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

dls 'zbrewvs.*'

zbrew install zhw110
rc=$?
if [ $rc != 0 ]; then
	echo "zbrew install failed with rc:$rc" >&2
	exit 2
fi

dls 'zbrewvs.*'

zbrew -c install zhw110
rc=$?
if [ $rc != 0 ]; then
        echo "zbrew install failed with rc:$rc" >&2
        exit 3
fi
dls 'zbrewvt.*'

zbrew smpreceiveptf zhw110 MCSPTF2  
rc=$?
if [ $rc != 0 ]; then
        echo "zbrew receive ptf from z/os file failed with rc:$rc" >&2
        exit 4
fi
dls 'zbrewvt.*'

zbrew update zhw110
rc=$?
if [ $rc != 0 ]; then
        echo "zbrew update of zhw110 failed with rc:$rc" >&2
        exit 5
fi
dls 'zbrewvt.*'

zbrew configure zhw110
rc=$?
if [ $rc != 0 ]; then
        echo "zbrew configure failed with rc:$rc" >&2
        exit 6
fi
dls 'zbrewvt.*'

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
