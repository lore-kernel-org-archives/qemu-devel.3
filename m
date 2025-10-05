Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A29FCCAC5B8
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 17:42:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5SiQ-0002TC-DK; Sun, 05 Oct 2025 13:40:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v5Sh7-0000ro-4j; Sun, 05 Oct 2025 13:38:50 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v5Sh0-0004hB-In; Sun, 05 Oct 2025 13:38:48 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0F4C415AA95;
 Sun, 05 Oct 2025 20:37:33 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id EB013299740;
 Sun,  5 Oct 2025 20:37:36 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.5 57/58] tests/functional/test_ppc_bamboo: Replace
 broken link with working assets
Date: Sun,  5 Oct 2025 20:37:06 +0300
Message-ID: <20251005173712.445160-19-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.5-20251005203554@cover.tls.msk.ru>
References: <qemu-stable-10.0.5-20251005203554@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The old image that we used for testing the bamboo machine has disappeared
from the internet. Fortunately there is another kernel + initrd provided
by Cédric that can be used for testing this machine, too.

Reported-by: Stefan Hajnoczi <stefanha@gmail.com>
Suggested-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250707184736.88660-1-thuth@redhat.com>
(cherry picked from commit 3b1cf40dd665a0c4c38bc339fea6eacf1742b46c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/functional/test_ppc_bamboo.py b/tests/functional/test_ppc_bamboo.py
index fddcc24d0d..c634ae7b4a 100755
--- a/tests/functional/test_ppc_bamboo.py
+++ b/tests/functional/test_ppc_bamboo.py
@@ -16,28 +16,32 @@ class BambooMachine(QemuSystemTest):
 
     timeout = 90
 
-    ASSET_IMAGE = Asset(
-        ('http://landley.net/aboriginal/downloads/binaries/'
-         'system-image-powerpc-440fp.tar.gz'),
-        'c12b58f841c775a0e6df4832a55afe6b74814d1565d08ddeafc1fb949a075c5e')
+    ASSET_KERNEL = Asset(
+        ('https://github.com/legoater/qemu-ppc-boot/raw/refs/heads/main/'
+         'buildroot/qemu_ppc_bamboo-2023.11-8-gdcd9f0f6eb-20240105/vmlinux'),
+        'a2e12eb45b73491ac62fc0bbeb68dead0dc5c0f22cf83146558389209b420ad1')
+    ASSET_INITRD = Asset(
+        ('https://github.com/legoater/qemu-ppc-boot/raw/refs/heads/main/'
+         'buildroot/qemu_ppc_bamboo-2023.11-8-gdcd9f0f6eb-20240105/rootfs.cpio'),
+        'd2a36bdb8763b389765dc8c29d4904cec2bd001c587f92e85ab9eb10d5ddda54')
 
     def test_ppc_bamboo(self):
         self.set_machine('bamboo')
         self.require_accelerator("tcg")
         self.require_netdev('user')
-        self.archive_extract(self.ASSET_IMAGE)
+
+        kernel = self.ASSET_KERNEL.fetch()
+        initrd = self.ASSET_INITRD.fetch()
+
         self.vm.set_console()
-        self.vm.add_args('-kernel',
-                         self.scratch_file('system-image-powerpc-440fp',
-                                           'linux'),
-                         '-initrd',
-                         self.scratch_file('system-image-powerpc-440fp',
-                                           'rootfs.cpio.gz'),
-                         '-nic', 'user,model=rtl8139,restrict=on')
+        self.vm.add_args('-kernel', kernel,
+                         '-initrd', initrd,
+                         '-nic', 'user,model=virtio-net-pci,restrict=on')
         self.vm.launch()
-        wait_for_console_pattern(self, 'Type exit when done')
-        exec_command_and_wait_for_pattern(self, 'ping 10.0.2.2',
-                                          '10.0.2.2 is alive!')
+        wait_for_console_pattern(self, 'buildroot login:')
+        exec_command_and_wait_for_pattern(self, 'root', '#')
+        exec_command_and_wait_for_pattern(self, 'ping -c1 10.0.2.2',
+                '1 packets transmitted, 1 packets received, 0% packet loss')
         exec_command_and_wait_for_pattern(self, 'halt', 'System Halted')
 
 if __name__ == '__main__':
-- 
2.47.3


