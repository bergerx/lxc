#!/bin/sh

if [ ! -e /var/lib/dpkg/info/ifupdown.list ]
then
	exit 0
fi

if grep -qs '^# Required-Start:    checkroot$' /etc/init.d/ifupdown-clean
then
	echo -n "P: Fixing #607713 in ifupdown (http://bugs.debian.org/607713)..."

	sed -i -e 's|^# Required-Start:    checkroot|# Required-Start:    mountdevsubfs hostname|' \
		/etc/init.d/ifupdown-clean

	echo " done."
fi
