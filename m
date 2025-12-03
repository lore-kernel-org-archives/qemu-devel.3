Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 018C5D116F3
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 08:01:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQhmv-000072-78; Wed, 03 Dec 2025 03:00:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vQhmM-0008Mq-D5; Wed, 03 Dec 2025 03:00:02 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vQhmK-0006hK-F1; Wed, 03 Dec 2025 03:00:02 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7DE31170767;
 Wed, 03 Dec 2025 10:59:22 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4BEA632B48E;
 Wed, 03 Dec 2025 10:59:40 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.7 090/116] tests/functional: Convert the 64-bit little
 endian Wheezy mips test
Date: Wed,  3 Dec 2025 10:59:10 +0300
Message-ID: <20251203075939.2366131-9-mjt@tls.msk.ru>
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
convert the 64-bit little endian Wheezy mips test.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20250414113031.151105-9-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit 8e3461c3a6fc0b1bce4571e46e861db0b2bcf621)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/avocado/linux_ssh_mips_malta.py b/tests/avocado/linux_ssh_mips_malta.py
index c1300aec96..2fa5cf9a6c 100644
--- a/tests/avocado/linux_ssh_mips_malta.py
+++ b/tests/avocado/linux_ssh_mips_malta.py
@@ -179,11 +179,3 @@ def test_mips_malta64eb_kernel3_2_0(self):
         :avocado: tags=device:pcnet32
         """
         self.check_mips_malta('mips64', 'be')
-
-    def test_mips_malta64el_kernel3_2_0(self):
-        """
-        :avocado: tags=arch:mips64el
-        :avocado: tags=endian:little
-        :avocado: tags=device:pcnet32
-        """
-        self.check_mips_malta('mips64', 'le')
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index cba0abf292..a4a317115b 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -42,6 +42,7 @@ test_timeouts = {
   'mips_malta' : 480,
   'mipsel_malta' : 420,
   'mipsel_replay' : 480,
+  'mips64el_malta' : 420,
   'mips64el_replay' : 180,
   'netdev_ethtool' : 180,
   'ppc_40p' : 240,
diff --git a/tests/functional/test_mips64el_malta.py b/tests/functional/test_mips64el_malta.py
index a8da15a26b..dd37212f9d 100755
--- a/tests/functional/test_mips64el_malta.py
+++ b/tests/functional/test_mips64el_malta.py
@@ -16,6 +16,8 @@
 from qemu_test import exec_command_and_wait_for_pattern
 from qemu_test import skipIfMissingImports, skipFlakyTest, skipUntrustedTest
 
+from test_mips_malta import mips_check_wheezy
+
 
 class MaltaMachineConsole(LinuxKernelTest):
 
@@ -90,6 +92,26 @@ def test_mips64el_malta_5KEc_cpio(self):
         # Wait for VM to shut down gracefully
         self.vm.wait()
 
+    ASSET_WHEEZY_KERNEL = Asset(
+        ('https://people.debian.org/~aurel32/qemu/mipsel/'
+         'vmlinux-3.2.0-4-5kc-malta'),
+        '5e8b725244c59745bb8b64f5d8f49f25fecfa549f3395fb6d19a3b9e5065b85b')
+
+    ASSET_WHEEZY_DISK = Asset(
+        ('https://people.debian.org/~aurel32/qemu/mipsel/'
+         'debian_wheezy_mipsel_standard.qcow2'),
+        '454f09ae39f7e6461c84727b927100d2c7813841f2a0a5dce328114887ecf914')
+
+    def test_wheezy(self):
+        kernel_path = self.ASSET_WHEEZY_KERNEL.fetch()
+        image_path = self.ASSET_WHEEZY_DISK.fetch()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE
+                               + 'console=ttyS0 root=/dev/sda1')
+        mips_check_wheezy(self,
+            kernel_path, image_path, kernel_command_line, cpuinfo='MIPS 20Kc',
+            dl_file='/boot/initrd.img-3.2.0-4-5kc-malta',
+            hsum='7579f8b56c1187c7c04d0dc3c0c56c7a6314c5ddd3a9bf8803ecc7cf8a3be9f8')
+
 
 @skipIfMissingImports('numpy', 'cv2')
 class MaltaMachineFramebuffer(LinuxKernelTest):
-- 
2.47.3


