Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8069CAC5B8
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 16:50:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5Rvw-0001zB-VQ; Sun, 05 Oct 2025 12:50:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v5Rvu-0001v2-Fo; Sun, 05 Oct 2025 12:50:02 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v5Rvs-0007Av-5a; Sun, 05 Oct 2025 12:50:02 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 57F2415AA43;
 Sun, 05 Oct 2025 19:49:34 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id B88362996FA;
 Sun,  5 Oct 2025 19:49:34 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.1 81/81] tests/functional/aarch64: Fix assets of
 test_hotplug_pci
Date: Sun,  5 Oct 2025 19:48:01 +0300
Message-ID: <20251005164822.442861-21-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.1-20251005194607@cover.tls.msk.ru>
References: <qemu-stable-10.1.1-20251005194607@cover.tls.msk.ru>
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

The old bookworm URLs don't work anymore, resulting in a 404 error
now. Let's update the test to Debian Trixie to get it going again.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 769acb2a1e47b97ada8e0db6ff73e303b23764d8)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/functional/test_aarch64_hotplug_pci.py b/tests/functional/test_aarch64_hotplug_pci.py
index 0c67991b89..bf67720431 100755
--- a/tests/functional/test_aarch64_hotplug_pci.py
+++ b/tests/functional/test_aarch64_hotplug_pci.py
@@ -15,14 +15,14 @@
 class HotplugPCI(LinuxKernelTest):
 
     ASSET_KERNEL = Asset(
-        ('https://ftp.debian.org/debian/dists/bookworm/main/installer-arm64/'
-         '20230607+deb12u11/images/netboot/debian-installer/arm64/linux'),
-         'd92a60392ce1e379ca198a1a820899f8f0d39a62d047c41ab79492f81541a9d9')
+        ('https://ftp.debian.org/debian/dists/trixie/main/installer-arm64/'
+         '20250803/images/netboot/debian-installer/arm64/linux'),
+         '93a6e4f9627d759375d28f863437a86a0659e125792a435f8e526dda006b7d5e')
 
     ASSET_INITRD = Asset(
-        ('https://ftp.debian.org/debian/dists/bookworm/main/installer-arm64/'
-         '20230607+deb12u11/images/netboot/debian-installer/arm64/initrd.gz'),
-         '9f817f76951f3237bca8216bee35267bfb826815687f4b2fcdd5e6c2a917790c')
+        ('https://ftp.debian.org/debian/dists/trixie/main/installer-arm64/'
+         '20250803/images/netboot/debian-installer/arm64/initrd.gz'),
+         'f6c78af7078ca67638ef3a50c926cd3c1485673243f8b37952e6bd854d6ba007')
 
     def test_hotplug_pci(self):
 
-- 
2.47.3


