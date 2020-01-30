#!/bin/sh
#
# Install zhw with a few overrides and then ensure the zFS files are laid down
#
. zbrewfuncs
mydir=$(callerdir ${0})
#set -x

zbrewpropse zbrew config ${mydir}/../../zbrew/properties/zbrewprops.json
zbrewpropse zhw110 install ${mydir}/../zhw110/zhw110install.json

# Clear up any jetsam from a previous run
MOUNT="${ZFSROOT}${ZFSDIR}"
unmount "${MOUNT}" 2>/dev/null 


drm -f "${ZBREW_HLQ}zhw*.*"

zbrew install zhw110
rc=$?
if [ $rc != 0 ]; then
	echo "zbrew install failed with rc:$rc" >&2
	exit 3
fi

zbrew configure zhw110
rc=$?
if [ $rc != 0 ]; then
	echo "zbrew configure failed with rc:$rc" >&2
	exit 4
fi

#
# zhw only has one leaf (hw)
#
if [ "${LEAVES}" != "hw" ]; then
	zbrewtest "zbrew configure of zhw110 has wrong value for LEAVES" "hw" "${LEAVES}"
	exit 5
fi

leafdir="${MOUNT}${LEAVES}"
if ! [ -d "${leafdir}" ]; then
	zbrewtest "leaf directory not created" "${leafdir}" "${leafdir}"
	exit 6
fi

exit 0
