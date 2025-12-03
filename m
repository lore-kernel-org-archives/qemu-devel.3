Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EE5DD116F3
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 08:03:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQhn1-0000Az-2A; Wed, 03 Dec 2025 03:00:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vQhmP-0008Nd-0h; Wed, 03 Dec 2025 03:00:05 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vQhmM-0006iO-DN; Wed, 03 Dec 2025 03:00:04 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8FE0C170768;
 Wed, 03 Dec 2025 10:59:22 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5D2B032B48F;
 Wed, 03 Dec 2025 10:59:40 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.7 091/116] tests/functional: Convert the 64-bit big
 endian Wheezy mips test
Date: Wed,  3 Dec 2025 10:59:11 +0300
Message-ID: <20251203075939.2366131-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.7-20251203105830@cover.tls.msk.ru>
References: <qemu-stable-10.0.7-20251203105830@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Thomas Huth <thuth@redhat.com>

Reuse the test function from the 32-bit big endian test to easily
convert the 64-bit big endian Wheezy mips test.

Since this was the last test in tests/avocado/linux_ssh_mips_malta.py,
we can remove this avocado file now, too.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20250414113031.151105-10-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit f79592f427d7faabb25d533815d6c3dd4ab9726d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/MAINTAINERS b/MAINTAINERS
index 42348df9d6..72f6b208f5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1355,7 +1355,6 @@ F: hw/acpi/piix4.c
 F: hw/mips/malta.c
 F: hw/pci-host/gt64120.c
 F: include/hw/southbridge/piix.h
-F: tests/avocado/linux_ssh_mips_malta.py
 F: tests/functional/test_mips*_malta.py
 F: tests/functional/test_mips*_tuxrun.py
 
diff --git a/tests/avocado/linux_ssh_mips_malta.py b/tests/avocado/linux_ssh_mips_malta.py
deleted file mode 100644
index 2fa5cf9a6c..0000000000
--- a/tests/avocado/linux_ssh_mips_malta.py
+++ /dev/null
@@ -1,181 +0,0 @@
-# Functional test that boots a VM and run commands via a SSH session
-#
-# Copyright (c) Philippe Mathieu-Daudé <f4bug@amsat.org>
-#
-# This work is licensed under the terms of the GNU GPL, version 2 or
-# later.  See the COPYING file in the top-level directory.
-
-import os
-import re
-import base64
-import logging
-import time
-
-from avocado import skipUnless
-from avocado_qemu import LinuxSSHMixIn
-from avocado_qemu import QemuSystemTest
-from avocado_qemu import wait_for_console_pattern
-from avocado.utils import process
-from avocado.utils import archive
-from avocado.utils import ssh
-
-
-@skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
-@skipUnless(ssh.SSH_CLIENT_BINARY, 'No SSH client available')
-class LinuxSSH(QemuSystemTest, LinuxSSHMixIn):
-    """
-    :avocado: tags=accel:tcg
-    """
-
-    timeout = 150 # Not for 'configure --enable-debug --enable-debug-tcg'
-
-    KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
-    VM_IP = '127.0.0.1'
-
-    BASE_URL = 'https://people.debian.org/~aurel32/qemu/'
-    IMAGE_INFO = {
-        'be': {'base_url': 'mips',
-               'image_name': 'debian_wheezy_mips_standard.qcow2',
-               'image_hash': '8987a63270df67345b2135a6b7a4885a35e392d5',
-               'kernel_hash': {
-                   32: '592e384a4edc16dade52a6cd5c785c637bcbc9ad',
-                   64: 'db6eea7de35d36c77d8c165b6bcb222e16eb91db'}
-              },
-        'le': {'base_url': 'mipsel',
-               'image_name': 'debian_wheezy_mipsel_standard.qcow2',
-               'image_hash': '7866764d9de3ef536ffca24c9fb9f04ffdb45802',
-               'kernel_hash': {
-                   32: 'a66bea5a8adaa2cb3d36a1d4e0ccdb01be8f6c2a',
-                   64: '6a7f77245acf231415a0e8b725d91ed2f3487794'}
-              }
-        }
-    CPU_INFO = {
-        32: {'cpu': 'MIPS 24Kc', 'kernel_release': '3.2.0-4-4kc-malta'},
-        64: {'cpu': 'MIPS 20Kc', 'kernel_release': '3.2.0-4-5kc-malta'}
-        }
-
-    def get_url(self, endianess, path=''):
-        qkey = {'le': 'el', 'be': ''}
-        return '%s/mips%s/%s' % (self.BASE_URL, qkey[endianess], path)
-
-    def get_image_info(self, endianess):
-        dinfo = self.IMAGE_INFO[endianess]
-        image_url = self.get_url(endianess, dinfo['image_name'])
-        image_hash = dinfo['image_hash']
-        return (image_url, image_hash)
-
-    def get_kernel_info(self, endianess, wordsize):
-        minfo = self.CPU_INFO[wordsize]
-        kernel_url = self.get_url(endianess,
-                                  'vmlinux-%s' % minfo['kernel_release'])
-        kernel_hash = self.IMAGE_INFO[endianess]['kernel_hash'][wordsize]
-        return kernel_url, kernel_hash
-
-    def ssh_disconnect_vm(self):
-        self.ssh_session.quit()
-
-    def boot_debian_wheezy_image_and_ssh_login(self, endianess, kernel_path):
-        image_url, image_hash = self.get_image_info(endianess)
-        image_path = self.fetch_asset(image_url, asset_hash=image_hash)
-
-        self.vm.set_console()
-        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE
-                               + 'console=ttyS0 root=/dev/sda1')
-        self.vm.add_args('-no-reboot',
-                         '-kernel', kernel_path,
-                         '-append', kernel_command_line,
-                         '-drive', 'file=%s,snapshot=on' % image_path,
-                         '-netdev', 'user,id=vnet,hostfwd=:127.0.0.1:0-:22',
-                         '-device', 'pcnet,netdev=vnet')
-        self.vm.launch()
-
-        self.log.info('VM launched, waiting for sshd')
-        console_pattern = 'Starting OpenBSD Secure Shell server: sshd'
-        wait_for_console_pattern(self, console_pattern, 'Oops')
-        self.log.info('sshd ready')
-
-        self.ssh_connect('root', 'root', False)
-
-    def shutdown_via_ssh(self):
-        self.ssh_command('poweroff')
-        self.ssh_disconnect_vm()
-        wait_for_console_pattern(self, 'Power down', 'Oops')
-
-    def run_common_commands(self, wordsize):
-        self.ssh_command_output_contains(
-            'cat /proc/cpuinfo',
-            self.CPU_INFO[wordsize]['cpu'])
-        self.ssh_command_output_contains(
-            'uname -m',
-            'mips')
-        self.ssh_command_output_contains(
-            'uname -r',
-            self.CPU_INFO[wordsize]['kernel_release'])
-        self.ssh_command_output_contains(
-            'cat /proc/interrupts',
-            'XT-PIC  timer')
-        self.ssh_command_output_contains(
-            'cat /proc/interrupts',
-            'XT-PIC  i8042')
-        self.ssh_command_output_contains(
-            'cat /proc/interrupts',
-            'XT-PIC  serial')
-        self.ssh_command_output_contains(
-            'cat /proc/interrupts',
-            'XT-PIC  ata_piix')
-        self.ssh_command_output_contains(
-            'cat /proc/interrupts',
-            'XT-PIC  eth0')
-        self.ssh_command_output_contains(
-            'cat /proc/devices',
-            'input')
-        self.ssh_command_output_contains(
-            'cat /proc/devices',
-            'usb')
-        self.ssh_command_output_contains(
-            'cat /proc/devices',
-            'fb')
-        self.ssh_command_output_contains(
-            'cat /proc/ioports',
-            ' : serial')
-        self.ssh_command_output_contains(
-            'cat /proc/ioports',
-            ' : ata_piix')
-        self.ssh_command_output_contains(
-            'cat /proc/ioports',
-            ' : piix4_smbus')
-        self.ssh_command_output_contains(
-            'lspci -d 11ab:4620',
-            'GT-64120')
-        self.ssh_command_output_contains(
-            'cat /sys/bus/i2c/devices/i2c-0/name',
-            'SMBus PIIX4 adapter')
-        self.ssh_command_output_contains(
-            'cat /proc/mtd',
-            'YAMON')
-        # Empty 'Board Config' (64KB)
-        self.ssh_command_output_contains(
-            'md5sum /dev/mtd2ro',
-            '0dfbe8aa4c20b52e1b8bf3cb6cbdf193')
-
-    def check_mips_malta(self, uname_m, endianess):
-        wordsize = 64 if '64' in uname_m else 32
-        kernel_url, kernel_hash = self.get_kernel_info(endianess, wordsize)
-        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
-        self.boot_debian_wheezy_image_and_ssh_login(endianess, kernel_path)
-
-        stdout, _ = self.ssh_command('uname -a')
-        self.assertIn(True, [uname_m + " GNU/Linux" in line for line in stdout])
-
-        self.run_common_commands(wordsize)
-        self.shutdown_via_ssh()
-        # Wait for VM to shut down gracefully
-        self.vm.wait()
-
-    def test_mips_malta64eb_kernel3_2_0(self):
-        """
-        :avocado: tags=arch:mips64
-        :avocado: tags=endian:big
-        :avocado: tags=device:pcnet32
-        """
-        self.check_mips_malta('mips64', 'be')
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index a4a317115b..985ac5c27f 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -42,6 +42,7 @@ test_timeouts = {
   'mips_malta' : 480,
   'mipsel_malta' : 420,
   'mipsel_replay' : 480,
+  'mips64_malta' : 240,
   'mips64el_malta' : 420,
   'mips64el_replay' : 180,
   'netdev_ethtool' : 180,
@@ -191,6 +192,7 @@ tests_mipsel_system_thorough = [
 ]
 
 tests_mips64_system_thorough = [
+  'mips64_malta',
   'mips64_tuxrun',
 ]
 
diff --git a/tests/functional/test_mips64_malta.py b/tests/functional/test_mips64_malta.py
new file mode 100755
index 0000000000..53c3e0c122
--- /dev/null
+++ b/tests/functional/test_mips64_malta.py
@@ -0,0 +1,35 @@
+#!/usr/bin/env python3
+#
+# Functional tests for the big-endian 64-bit MIPS Malta board
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import LinuxKernelTest, Asset
+from test_mips_malta import mips_check_wheezy
+
+
+class MaltaMachineConsole(LinuxKernelTest):
+
+    ASSET_WHEEZY_KERNEL = Asset(
+        ('https://people.debian.org/~aurel32/qemu/mips/'
+         'vmlinux-3.2.0-4-5kc-malta'),
+        '3e4ec154db080b3f1839f04dde83120654a33e5e1716863de576c47cb94f68f6')
+
+    ASSET_WHEEZY_DISK = Asset(
+        ('https://people.debian.org/~aurel32/qemu/mips/'
+         'debian_wheezy_mips_standard.qcow2'),
+        'de03599285b8382ad309309a6c4869f6c6c42a5cfc983342bab9ec0dfa7849a2')
+
+    def test_wheezy(self):
+        kernel_path = self.ASSET_WHEEZY_KERNEL.fetch()
+        image_path = self.ASSET_WHEEZY_DISK.fetch()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE
+                               + 'console=ttyS0 root=/dev/sda1')
+        mips_check_wheezy(self,
+            kernel_path, image_path, kernel_command_line, cpuinfo='MIPS 20Kc',
+            dl_file='/boot/initrd.img-3.2.0-4-5kc-malta',
+            hsum='d98b953bb4a41c0fc0fd8d19bbc691c08989ac52568c1d3054d92dfd890d3f06')
+
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.47.3


