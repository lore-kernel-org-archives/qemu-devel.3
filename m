Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3542FC44501
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 15:07:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiZI7-0006si-Un; Sat, 11 Jul 2026 11:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlmgr@proulx.com>) id 1wiZHh-0006pi-SO
 for qemu-devel@nongnu.org; Sat, 11 Jul 2026 11:06:30 -0400
Received: from havoc.proulx.com ([198.99.81.74])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlmgr@proulx.com>) id 1wiZHg-0003YT-4M
 for qemu-devel@nongnu.org; Sat, 11 Jul 2026 11:06:29 -0400
Received: by havoc.proulx.com (Postfix, from userid 1027)
 id 67D766AF; Sat, 11 Jul 2026 09:06:26 -0600 (MDT)
Resent-From: Mailing List Manager <mlmgr@proulx.com>
Resent-Date: Sat, 11 Jul 2026 09:06:26 -0600
Resent-Message-ID: <alJb8rTLC45j0FF8@havoc.proulx.com>
Resent-To: qemu-devel@nongnu.org
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <caojunze424@caojunze424deMacBook-Air.local>)
 id 1wiXCz-00021H-IS; Sat, 11 Jul 2026 08:53:29 -0400
Received: from [180.213.84.245] (helo=caojunze424deMacBook-Air.local)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <caojunze424@caojunze424deMacBook-Air.local>)
 id 1wiXCx-0005w5-Fk; Sat, 11 Jul 2026 08:53:29 -0400
Received: by caojunze424deMacBook-Air.local (Postfix, from userid 501)
 id 8FCD227F1DE3; Sat, 11 Jul 2026 20:53:21 +0800 (CST)
From: Junze Cao <caojunze424@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, chao.liu@processmission.com,
 alistair.francis@wdc.com, th.huth+qemu@posteo.eu,
 Junze Cao <caojunze424@gmail.com>
Subject: [PATCH] tests/functional/riscv64: Add K230 Linux boot tests
Date: Sat, 11 Jul 2026 20:53:20 +0800
Message-ID: <20260711125320.72319-1-caojunze424@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 180.213.84.245 (failed)
Received-SPF: none client-ip=180.213.84.245;
 envelope-from=caojunze424@caojunze424deMacBook-Air.local;
 helo=caojunze424deMacBook-Air.local
X-Spam_action: reject
X-Listhelper-Id: 20260711065350-5291
X-Bogosity: Spam, tests=bogofilter, spamicity=1.000000, version=1.2.5
X-CRM114-Status: UNSURE (   2.03  )
Received-SPF: pass client-ip=198.99.81.74; envelope-from=mlmgr@proulx.com;
 helo=havoc.proulx.com
X-Spam_score_int: 46
X-Spam_score: 4.6
X-Spam_bar: ++++
X-Spam_report: (4.6 / 5.0 requ) BAYES_00=-1.9, DKIM_ADSP_CUSTOM_MED=0.001,
 FORGED_GMAIL_RCVD=1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 HK_RANDOM_ENVFROM=0.999, NML_ADSP_CUSTOM_MED=0.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 11 Jul 2026 11:06:55 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The K230 machine supports direct Linux boot and firmware boot through
the SDK U-Boot, but neither path has functional test coverage.

Add one test for each boot path. Both tests use the Yocto initramfs
assets and wait for the shell prompt to confirm a successful boot.

Fetch the boot assets from the k230-boot-assets repository maintained
by Chao Liu. Pin the URLs to a repository commit and verify each asset
with its SHA-256 digest.

Signed-off-by: Junze Cao <caojunze424@gmail.com>
---
 MAINTAINERS                           |   1 +
 tests/functional/riscv64/meson.build  |   2 +
 tests/functional/riscv64/test_k230.py | 108 ++++++++++++++++++++++++++
 3 files changed, 111 insertions(+)
 create mode 100755 tests/functional/riscv64/test_k230.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 6171cc7494..fcf87609cb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1828,6 +1828,7 @@ F: hw/riscv/k230.c
 F: hw/watchdog/k230_wdt.c
 F: include/hw/riscv/k230.h
 F: include/hw/watchdog/k230_wdt.h
+F: tests/functional/riscv64/test_k230.py
 F: tests/qtest/k230-wdt-test.c
 
 RX Machines
diff --git a/tests/functional/riscv64/meson.build b/tests/functional/riscv64/meson.build
index c9d4c090fb..d1a3e6c2bf 100644
--- a/tests/functional/riscv64/meson.build
+++ b/tests/functional/riscv64/meson.build
@@ -2,6 +2,7 @@
 
 test_riscv64_timeouts = {
   'boston' : 120,
+  'k230' : 120,
   'tuxrun' : 120,
 }
 
@@ -13,6 +14,7 @@ tests_riscv64_system_quick = [
 tests_riscv64_system_thorough = [
   'endianness',
   'boston',
+  'k230',
   'sifive_u',
   'tt_atlantis',
   'tuxrun',
diff --git a/tests/functional/riscv64/test_k230.py b/tests/functional/riscv64/test_k230.py
new file mode 100755
index 0000000000..6ccbf2d581
--- /dev/null
+++ b/tests/functional/riscv64/test_k230.py
@@ -0,0 +1,108 @@
+#!/usr/bin/env python3
+#
+# Functional tests that boot Linux on a Kendryte K230 machine.
+#
+# The direct boot test lets QEMU load OpenSBI, Linux, the device tree, and the
+# initramfs.  The firmware boot test starts the K230 SDK U-Boot and uses bootm
+# to launch OpenSBI and Linux from images preloaded into RAM.
+#
+# Author:
+#  Junze Cao
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+
+from qemu_test import Asset, LinuxKernelTest
+from qemu_test import exec_command_and_wait_for_pattern
+from qemu_test import interrupt_interactive_console_until_pattern
+
+
+class K230Machine(LinuxKernelTest):
+
+    ASSET_KERNEL = Asset(
+        ('https://raw.githubusercontent.com/zevorn/k230-boot-assets/'
+         'c3c32fb46e8307c5063f13e8f367c98bf9273cd1/'
+         'yocto/direct-boot/Image'),
+        '3a44970213fa68ad318d308518adfc0bf4bee72ed1b2926f9b468f82ef7d7829')
+    ASSET_DTB = Asset(
+        ('https://raw.githubusercontent.com/zevorn/k230-boot-assets/'
+         'c3c32fb46e8307c5063f13e8f367c98bf9273cd1/'
+         'yocto/direct-boot/k230-canmv.dtb'),
+        '5050240b48ce0988c73eaefa73e4945a40abca503cf488d22a3adf6ef50bbe4c')
+    ASSET_INITRD = Asset(
+        ('https://raw.githubusercontent.com/zevorn/k230-boot-assets/'
+         'c3c32fb46e8307c5063f13e8f367c98bf9273cd1/'
+         'yocto/direct-boot/rootfs.cpio.gz'),
+        '4e1869a99a232ee60324f71f3a9e84a79b03ccabb5b73f8a727c5ff5be5c0914')
+    ASSET_UBOOT = Asset(
+        ('https://raw.githubusercontent.com/zevorn/k230-boot-assets/'
+         'c3c32fb46e8307c5063f13e8f367c98bf9273cd1/common/u-boot'),
+        '0915b9a92a7c911846a8cf691866ef14ef050a51d04209f884ae8e9ec33f36d2')
+    ASSET_FW_JUMP = Asset(
+        ('https://raw.githubusercontent.com/zevorn/k230-boot-assets/'
+         'c3c32fb46e8307c5063f13e8f367c98bf9273cd1/'
+         'common/fw_jump.uImage'),
+        'cf7788e470f1d6e8c85491ecdc2705518db1b6af54080e8c7a3464bad0d902b7')
+
+    def wait_for_linux_shell(self):
+        self.wait_for_console_pattern('meta-k230 initramfs starting...')
+        self.wait_for_console_pattern('~ #')
+
+    def test_k230_direct_boot(self):
+        self.set_machine('k230')
+        kernel_path = self.ASSET_KERNEL.fetch()
+        dtb_path = self.ASSET_DTB.fetch()
+        initrd_path = self.ASSET_INITRD.fetch()
+
+        self.vm.set_console()
+        self.vm.add_args('-kernel', kernel_path,
+                         '-dtb', dtb_path,
+                         '-initrd', initrd_path,
+                         '-append', 'console=ttyS0,115200 earlycon=sbi',
+                         '-no-reboot')
+        self.vm.launch()
+        self.wait_for_linux_shell()
+
+    def test_k230_uboot_boot(self):
+        self.set_machine('k230')
+        kernel_path = self.ASSET_KERNEL.fetch()
+        dtb_path = self.ASSET_DTB.fetch()
+        initrd_path = self.ASSET_INITRD.fetch()
+        uboot_path = self.ASSET_UBOOT.fetch()
+        fw_jump_path = self.ASSET_FW_JUMP.fetch()
+        initrd_end = 0x0a100000 + os.path.getsize(initrd_path)
+
+        self.vm.set_console()
+        self.vm.add_args(
+            '-bios', uboot_path,
+            '-device',
+            f'loader,file={fw_jump_path},addr=0xc100000,force-raw=on',
+            '-device',
+            f'loader,file={kernel_path},addr=0x8200000,force-raw=on',
+            '-device',
+            f'loader,file={initrd_path},addr=0xa100000,force-raw=on',
+            '-device',
+            f'loader,file={dtb_path},addr=0xa000000,force-raw=on',
+            '-no-reboot')
+        self.vm.launch()
+
+        interrupt_interactive_console_until_pattern(self, 'K230#')
+        commands = (
+            'setenv bootargs console=ttyS0,115200 earlycon=sbi',
+            'fdt addr 0xa000000',
+            'fdt resize 8192',
+            'fdt set /chosen linux,initrd-start <0x0 0xa100000>',
+            f'fdt set /chosen linux,initrd-end <0x0 0x{initrd_end:x}>',
+        )
+        for command in commands:
+            exec_command_and_wait_for_pattern(self, command, 'K230#')
+
+        exec_command_and_wait_for_pattern(
+            self, 'bootm 0xc100000 - 0xa000000',
+            'Starting kernel ...', failure_message='ERROR')
+        self.wait_for_linux_shell()
+
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.53.0



