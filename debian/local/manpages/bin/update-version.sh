#!/bin/sh

set -e

DATE="$(LC_ALL=C date +%Y\\\\-%m\\\\-%d)"
PROGRAM="LXC"
VERSION="$(cd ../../../ && dpkg-parsechangelog | awk '/^Version: / { print $2 }' | cut -d: -f 2-)"

echo "Updating version headers..."

for MANPAGE in en/*
do
	SECTION="$(basename ${MANPAGE} | awk -F. '{ print $2 }')"

	sed -i -e "s|^.TH.*$|.TH ${PROGRAM} ${SECTION} ${DATE} ${VERSION} \"Linux Containers\"|" ${MANPAGE}
done
