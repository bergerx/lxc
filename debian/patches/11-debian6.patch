Author: Daniel Baumann <daniel.baumann@progress-technologies.net>
Description:
 Disable services in debian template upgrade proof (Closes: #636851).

diff -Naurp lxc.orig/templates/lxc-debian.in lxc/templates/lxc-debian.in
--- lxc.orig/templates/lxc-debian.in	2011-08-07 10:54:11.356126665 +0200
+++ lxc/templates/lxc-debian.in	2011-08-07 11:09:54.924805575 +0200
@@ -85,12 +85,26 @@ EOF
     chroot $rootfs sh -c "LANG=C dpkg-reconfigure locales -f noninteractive"
 
     # remove pointless services in a container
-    chroot $rootfs /usr/sbin/update-rc.d -f checkroot.sh remove
-    chroot $rootfs /usr/sbin/update-rc.d -f umountfs remove
-    chroot $rootfs /usr/sbin/update-rc.d -f umountroot remove
-    chroot $rootfs /usr/sbin/update-rc.d -f hwclock.sh remove
-    chroot $rootfs /usr/sbin/update-rc.d -f hwclockfirst.sh remove
-    chroot $rootfs /usr/sbin/update-rc.d -f module-init-tools remove
+    chroot $rootfs /usr/sbin/update-rc.d -f checkroot.sh remove # S
+    chroot $rootfs /usr/sbin/update-rc.d checkroot.sh stop 09 S .
+
+    chroot $rootfs /usr/sbin/update-rc.d -f umountfs remove # 0 6
+    chroot $rootfs /usr/sbin/update-rc.d umountfs start 09 0 6 .
+
+    chroot $rootfs /usr/sbin/update-rc.d -f umountroot remove # 0 6
+    chroot $rootfs /usr/sbin/update-rc.d umountroot start 10 0 6 .
+
+    # The following initscripts don't provide an empty start or stop block.
+    # To prevent them being enabled on upgrades, we leave a start link on
+    # runlevel 3.
+    chroot $rootfs /usr/sbin/update-rc.d -f hwclock.sh remove # S 0 6
+    chroot $rootfs /usr/sbin/update-rc.d hwclock.sh start 10 3 .
+
+    chroot $rootfs /usr/sbin/update-rc.d -f hwclockfirst.sh remove # S
+    chroot $rootfs /usr/sbin/update-rc.d hwclockfirst start 08 3 .
+
+    chroot $rootfs /usr/sbin/update-rc.d -f module-init-tools remove # S
+    chroot $rootfs /usr/sbin/update-rc.d module-init-tools start 10 3 .
 
     echo "root:root" | chroot $rootfs chpasswd
     echo "Root password is 'root', please change !"
