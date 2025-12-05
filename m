Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B9F9D2E00A
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 05:39:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vROXL-0008Ok-GD; Fri, 05 Dec 2025 00:39:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vROX5-0008K9-HQ
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 00:39:08 -0500
Received: from inva021.nxp.com ([92.121.34.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vROWr-0005Lo-Qb
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 00:38:59 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A0906201617;
 Fri,  5 Dec 2025 06:38:26 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6ABED2015FF;
 Fri,  5 Dec 2025 06:38:26 +0100 (CET)
Received: from lsv031015.swis.in-blr01.nxp.com
 (lsv031015.swis.in-blr01.nxp.com [10.12.177.77])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id DE523180007D;
 Fri,  5 Dec 2025 13:38:25 +0800 (+08)
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
Subject: [PATCHv4 15/15] hw/arm/fsl-imx8mm: Adding functional testing of
 iMX8MM emulation
Date: Fri,  5 Dec 2025 11:08:19 +0530
Message-Id: <20251205053819.2021772-16-gaurav.sharma_7@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251205053819.2021772-1-gaurav.sharma_7@nxp.com>
References: <20251205053819.2021772-1-gaurav.sharma_7@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Received-SPF: pass client-ip=92.121.34.21;
 envelope-from=gaurav.sharma_7@nxp.com; helo=inva021.nxp.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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

Added script that would validate the iMX8MM emulation by checking the
linux console log. If it succeeds, it will return:-

ok 1 test_imx8mm_evk.Imx8mmEvkMachine.test_aarch64_imx8mm_evk_usdhc

Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
---
 tests/functional/aarch64/meson.build        |  2 +
 tests/functional/aarch64/test_imx8mm_evk.py | 67 +++++++++++++++++++++
 2 files changed, 69 insertions(+)
 create mode 100755 tests/functional/aarch64/test_imx8mm_evk.py

diff --git a/tests/functional/aarch64/meson.build b/tests/functional/aarch64/meson.build
index 5ad52f93e1..c0e5be1b58 100644
--- a/tests/functional/aarch64/meson.build
+++ b/tests/functional/aarch64/meson.build
@@ -4,6 +4,7 @@ test_aarch64_timeouts = {
   'aspeed_ast2700' : 600,
   'aspeed_ast2700fc' : 600,
   'device_passthrough' : 720,
+  'imx8mm_evk' : 240,
   'imx8mp_evk' : 240,
   'raspi4' : 480,
   'reverse_debug' : 180,
@@ -27,6 +28,7 @@ tests_aarch64_system_thorough = [
   'aspeed_ast2700fc',
   'device_passthrough',
   'hotplug_pci',
+  'imx8mm_evk',
   'imx8mp_evk',
   'kvm',
   'multiprocess',
diff --git a/tests/functional/aarch64/test_imx8mm_evk.py b/tests/functional/aarch64/test_imx8mm_evk.py
new file mode 100755
index 0000000000..224fe4669e
--- /dev/null
+++ b/tests/functional/aarch64/test_imx8mm_evk.py
@@ -0,0 +1,67 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots a Linux kernel and checks the console
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import LinuxKernelTest, Asset
+
+class Imx8mmEvkMachine(LinuxKernelTest):
+
+    ASSET_IMAGE = Asset(
+        ('https://cloud.debian.org/images/cloud/bookworm/20231210-1590/'
+         'debian-12-generic-arm64-20231210-1590.tar.xz'),
+        '7ebf1577b32d5af6204df74b54ca2e4675de9b5a9fa14f3ff70b88eeb7b3b359')
+
+    KERNEL_OFFSET = 0x51000000
+    KERNEL_SIZE = 32622528
+    INITRD_OFFSET = 0x76000000
+    INITRD_SIZE = 30987766
+    DTB_OFFSET = 0x64DB5000
+    DTB_SIZE = 36812
+
+    def extract(self, in_path, out_path, offset, size):
+        try:
+            with open(in_path, "rb") as source:
+                source.seek(offset)
+                data = source.read(size)
+            with open(out_path, "wb") as target:
+                target.write(data)
+        except (IOError, ValueError) as e:
+            self.log.error(f"Failed to extract {out_path}: {e}")
+            raise
+
+    def setUp(self):
+        super().setUp()
+
+        self.image_path = self.scratch_file("disk.raw")
+        self.kernel_path = self.scratch_file("linux")
+        self.initrd_path = self.scratch_file("initrd.zstd")
+        self.dtb_path = self.scratch_file("imx8mm-evk.dtb")
+
+        self.archive_extract(self.ASSET_IMAGE)
+        self.extract(self.image_path, self.kernel_path,
+                     self.KERNEL_OFFSET, self.KERNEL_SIZE)
+        self.extract(self.image_path, self.initrd_path,
+                     self.INITRD_OFFSET, self.INITRD_SIZE)
+        self.extract(self.image_path, self.dtb_path,
+                     self.DTB_OFFSET, self.DTB_SIZE)
+
+    def test_aarch64_imx8mm_evk_usdhc(self):
+        self.require_accelerator("tcg")
+        self.set_machine('imx8mm-evk')
+        self.vm.set_console(console_index=1)
+        self.vm.add_args('-m', '2G',
+                         '-smp', '4',
+                         '-kernel', self.kernel_path,
+                         '-initrd', self.initrd_path,
+                         '-dtb', self.dtb_path,
+                         '-append', 'root=/dev/mmcblk2p1',
+                         '-drive', f'file={self.image_path},if=sd,bus=2,'
+                                    'format=raw,id=mmcblk2,snapshot=on')
+
+        self.vm.launch()
+        self.wait_for_console_pattern('Welcome to ')
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.34.1


