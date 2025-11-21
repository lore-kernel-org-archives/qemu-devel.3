Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5C23CF64B1
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 04:29:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMctt-0007yz-Cf; Fri, 21 Nov 2025 20:58:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMbpK-0002z0-Qu; Fri, 21 Nov 2025 19:50:10 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMbnG-0008IX-7y; Fri, 21 Nov 2025 19:50:06 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 32B1116CA7A;
 Fri, 21 Nov 2025 21:44:28 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id E4C14321CB6;
 Fri, 21 Nov 2025 21:44:36 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.7 63/81] tests: move test_xen assets to share.linaro.org
Date: Fri, 21 Nov 2025 21:44:02 +0300
Message-ID: <20251121184424.1137669-63-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.7-20251121170317@cover.tls.msk.ru>
References: <qemu-stable-10.0.7-20251121170317@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
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

From: Alex Bennée <alex.bennee@linaro.org>

Linaro are migrating file-hosting from the old NextCloud instance to
another sharing site.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Cc: qemu-stable@nongnu.org
Message-ID: <20251117115523.3993105-7-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
(cherry picked from commit 863449cc8ec7ff23d41ac71d462e2349e11b3852)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/functional/test_aarch64_xen.py b/tests/functional/test_aarch64_xen.py
index 339904221b..d03799cab8 100755
--- a/tests/functional/test_aarch64_xen.py
+++ b/tests/functional/test_aarch64_xen.py
@@ -25,8 +25,7 @@ class BootXen(LinuxKernelTest):
     XEN_COMMON_COMMAND_LINE = 'dom0_mem=128M loglvl=all guest_loglvl=all'
 
     ASSET_KERNEL = Asset(
-        ('https://fileserver.linaro.org/s/JSsewXGZ6mqxPr5/'
-         'download?path=%2F&files=linux-5.9.9-arm64-ajb'),
+        'https://share.linaro.org/downloadFile?id=RRahAWwAwYKTZQd',
         '00366fa51ea957c19462d2e2aefd480bef80ce727120e714ae48e0c88f261edb')
 
     def launch_xen(self, xen_path):
@@ -54,8 +53,7 @@ def launch_xen(self, xen_path):
         wait_for_console_pattern(self, console_pattern, "Panic on CPU 0:")
 
     ASSET_XEN_4_11 = Asset(
-        ('https://fileserver.linaro.org/s/JSsewXGZ6mqxPr5/download?path=%2F&'
-         'files=xen-hypervisor-4.11-arm64_4.11.4%2B37-g3263f257ca-1_arm64.deb'),
+        'https://share.linaro.org/downloadFile?id=ALU4n2NGGYbE4fO',
         'b745c2631342f9fcc0147ddc364edb62c20ecfebd430e5a3546e7d7c6891c0bc')
 
     def test_arm64_xen_411_and_dom0(self):
@@ -65,8 +63,7 @@ def test_arm64_xen_411_and_dom0(self):
         self.launch_xen(xen_path)
 
     ASSET_XEN_4_14 = Asset(
-        ('https://fileserver.linaro.org/s/JSsewXGZ6mqxPr5/download?path=%2F&'
-         'files=xen-hypervisor-4.14-arm64_4.14.0%2B80-gd101b417b7-1_arm64.deb'),
+        'https://share.linaro.org/downloadFile?id=os4zSXPl7WW4lqX',
         'e930a3293248edabd367d5b4b3b6448b9c99c057096ea8b47228a7870661d5cb')
 
     def test_arm64_xen_414_and_dom0(self):
@@ -76,8 +73,7 @@ def test_arm64_xen_414_and_dom0(self):
         self.launch_xen(xen_path)
 
     ASSET_XEN_4_15 = Asset(
-        ('https://fileserver.linaro.org/s/JSsewXGZ6mqxPr5/download?path=%2F&'
-         'files=xen-upstream-4.15-unstable.deb'),
+        'https://share.linaro.org/downloadFile?id=jjjG4uTp2wuO4Ks',
         '2a9a8af8acf0231844657cc28baab95bd918b0ee2d493ee4ee6f8846e1358bc9')
 
     def test_arm64_xen_415_and_dom0(self):
-- 
2.47.3


