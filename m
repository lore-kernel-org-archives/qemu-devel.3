Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC4ACCAC5BB
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 17:42:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5SiY-00030u-Pa; Sun, 05 Oct 2025 13:40:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v5ShA-0000vb-GT; Sun, 05 Oct 2025 13:38:55 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v5Sh8-0004n5-Jw; Sun, 05 Oct 2025 13:38:52 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2489015AA96;
 Sun, 05 Oct 2025 20:37:34 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4A706299741;
 Sun,  5 Oct 2025 20:37:38 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.5 58/58] tests/functional/test_aarch64_sbsaref_freebsd:
 Fix the URL of the ISO image
Date: Sun,  5 Oct 2025 20:37:07 +0300
Message-ID: <20251005173712.445160-20-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.5-20251005203554@cover.tls.msk.ru>
References: <qemu-stable-10.0.5-20251005203554@cover.tls.msk.ru>
MIME-Version: 1.0
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

The original image has been removed from the server, so the test
currently fails if it has to fetch the asset, but we can still
download the ISO from the archive server. While we're at it, prefer
the XZ compressed image, it's much smaller and thus the download
should be faster.

Message-ID: <20250701105809.366180-1-thuth@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit 01e2b1bc27bae874bfeb6978ce093deac5bb9639)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/functional/test_aarch64_sbsaref_freebsd.py b/tests/functional/test_aarch64_sbsaref_freebsd.py
index bd6728dc70..2a26281d25 100755
--- a/tests/functional/test_aarch64_sbsaref_freebsd.py
+++ b/tests/functional/test_aarch64_sbsaref_freebsd.py
@@ -20,9 +20,9 @@
 class Aarch64SbsarefFreeBSD(QemuSystemTest):
 
     ASSET_FREEBSD_ISO = Asset(
-        ('https://download.freebsd.org/releases/arm64/aarch64/ISO-IMAGES/'
-         '14.1/FreeBSD-14.1-RELEASE-arm64-aarch64-bootonly.iso'),
-        '44cdbae275ef1bb6dab1d5fbb59473d4f741e1c8ea8a80fd9e906b531d6ad461')
+        ('http://ftp-archive.freebsd.org/pub/FreeBSD-Archive/old-releases/arm64'
+         '/aarch64/ISO-IMAGES/14.1/FreeBSD-14.1-RELEASE-arm64-aarch64-bootonly.iso.xz'),
+        '7313a4495ffd71ab77b49b1e83f571521c32756e1d75bf48bd890e0ab0f75827')
 
     # This tests the whole boot chain from EFI to Userspace
     # We only boot a whole OS for the current top level CPU and GIC
@@ -30,7 +30,7 @@ class Aarch64SbsarefFreeBSD(QemuSystemTest):
     def boot_freebsd14(self, cpu=None):
         fetch_firmware(self)
 
-        img_path = self.ASSET_FREEBSD_ISO.fetch()
+        img_path = self.uncompress(self.ASSET_FREEBSD_ISO)
 
         self.vm.set_console()
         self.vm.add_args(
-- 
2.47.3


