Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C05A9C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 15:44:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzcFW-0006Iv-PW; Thu, 27 Aug 2026 11:42:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1wzcFV-0006IU-6K
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 11:42:41 -0400
Received: from mx1.catap.net ([2a01:4f8:271:125e::2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1wzcFT-000193-5p
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 11:42:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=wdN3LkJ
 qSXQZ+0NOPMPbvhWUOL76mgM3Iuonmr1gwXDN/0C/+vXlTewb8K0kb9G2WSE436hJAz+rb
 EBtaBnvulAQDi5vf9uKUkD2HH50zy0Jc6I8ChN9yW16gxJBRkp1AgDzPQ2s5QZyWZyxlGD
 a3aAyf8i3YbZNHPm7PXOIz04JtC8emjLl7YVFYNIMrXDqVEz/CRY7WgXSH3UTu4CRxuvQ7
 P6fLGOjEp4rCfzkEDlexd4Cw2RuRx/zgOtM6vdh7+FQUwwpD0wtNMp17r/eYJfSUZr7yzV
 FiPog3jEqP4uQNLBL8qiqEgW7QogXjFOOvOHJ+RUSUOEJccvg2DCEdw==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=q
 A437rlrS/eneymJ21yfTMArrIp3PE7bMGZ/YzrWPHc=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=ZuMhzSNQ2Md0j2g13yxG8y6KF67Nfz6fgxOqO7wm+kpePWTEJX2OnszHSSfhxkhX8wTZ
 gupaaaZe1CEWdSCVZ3EFLDOz9bPh/wJoipikUlCZWgRAm8y6vxB8ZdS43TAwv8ZmvSrgSk
 gA1gXa3GbflAGdBA3mjo89GgNMXdQYwQDwLYoFExJAVtL9Nc08Ck99HFiPSajXpfbm7TpI
 qYmu6Vs92dlfC9hJRR6czVYqfczKPi6sD5mx/UAr1N4hkg9TmGpoBrqeQoUPA2u6TcQaqF
 QQQ8ksIjhk0tIl23LOiao2+Nu+ufXtlL3Lx3YMGcG990VabnwLJM1rXsMR4NteNQ==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=FZAcAc8F; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=ufuD4CJC;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=qA437rlr
 S/eneymJ21yfTMArrIp3PE7bMGZ/YzrWPHc=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=FZAcAc8FIFVhRnAUGzubIA4wkV7WNirnS34
 Wz41l4Vkd2jFT52uGYQs2rvNBlz763eWV7FpNcLw3/StTe2frAvW7YD/fc2SrLjoD7I9iG
 ZvMqJ4BQpZ+2Mqt5CB2E8ClSeuvAVojmctxZjQRONy0r51Ny+56bhsZW266s9xiusxqg7z
 +/JMpEO8A1mtp30cBHbEQr6CzFOXdtIsgjAwQbGm0P9Wuay5mTb8Gc7+pQtkFcWDtBMn6D
 3fFH6xcN2K5scO8Cz2tOg9yc8ibCqyDvsBikinwq89j1r3VOzuhcpzJ/PT+qpy6zSzdrdZ
 cYH2Lqd35B9oqVBtVp7kdvO6Wqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=qA437rlrS/eneymJ21yfTMArrIp3PE7bMGZ/YzrWPHc=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=ufuD4CJCLvk4Kf9aX3
 jDSro7l8uXcmupKVoAFpgT9c3MY6nn0z4Po7RiaUiHorqMRqJQTiB7f+z96F2CEXb0BA==
Received: by mx1.catap.net (OpenSMTPD) with ESMTPSA id 64615583
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Thu, 27 Aug 2026 17:42:34 +0200 (CEST)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 60dd7ed8;
 Thu, 27 Aug 2026 17:42:32 +0200 (CEST)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH 5/5] tests/functional: Boot OpenBSD on mac99
Date: Thu, 27 Aug 2026 17:41:17 +0200
Message-ID: <20260827154220.84845-6-kirill@korins.ky>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827154220.84845-1-kirill@korins.ky>
References: <20260827154220.84845-1-kirill@korins.ky>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a01:4f8:271:125e::2;
 envelope-from=kirill@korins.ky; helo=mx1.catap.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

OpenBSD device discovery exercises CTPR masking, zero decrementer
writes, and CUDA reply timing and layout; regressions in any of these
paths stall the guest before the installer starts.

Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
---
 tests/functional/ppc/meson.build     |  2 ++
 tests/functional/ppc/test_openbsd.py | 46 ++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)
 create mode 100755 tests/functional/ppc/test_openbsd.py

diff --git a/tests/functional/ppc/meson.build b/tests/functional/ppc/meson.build
index ae061fe5a6..1055cdaa17 100644
--- a/tests/functional/ppc/meson.build
+++ b/tests/functional/ppc/meson.build
@@ -2,6 +2,7 @@
 
 test_ppc_timeouts = {
   '40p' : 240,
+  'openbsd' : 240,
 }
 
 tests_ppc_system_quick = [
@@ -15,6 +16,7 @@ tests_ppc_system_thorough = [
   'bamboo',
   'mac',
   'mpc8544ds',
+  'openbsd',
   'ppe42',
   'replay',
   'sam460ex',
diff --git a/tests/functional/ppc/test_openbsd.py b/tests/functional/ppc/test_openbsd.py
new file mode 100755
index 0000000000..cf45930a7c
--- /dev/null
+++ b/tests/functional/ppc/test_openbsd.py
@@ -0,0 +1,46 @@
+#!/usr/bin/env python3
+#
+# Test that OpenBSD boots on mac99 and reaches the installer.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import wait_for_console_pattern
+
+
+class OpenBSDMac99(QemuSystemTest):
+
+    ASSET_CD = Asset(
+        'https://ftp.eu.openbsd.org/pub/OpenBSD/7.9/macppc/cd79.iso',
+        '227fef3d5089d56ce8376d8bfa28181ce5b19f0eceef0a6d82d58d8e52832b24')
+
+    def test_openbsd_79_installer(self):
+        self.set_machine('mac99')
+        self.require_accelerator('tcg')
+        cdrom_path = self.ASSET_CD.fetch()
+
+        self.vm.set_console()
+        self.vm.add_args('-M', 'via=cuda,graphics=off,usb=off',
+                         '-cpu', '7400',
+                         '-accel', 'tcg,thread=single',
+                         '-smp', '1',
+                         '-m', '2g',
+                         '-nic', 'none',
+                         '-device', 'VGA',
+                         '-global', 'cuda.sr-delay-ns=0',
+                         '-prom-env', 'input-device=ttya',
+                         '-prom-env', 'output-device=ttya',
+                         '-cdrom', cdrom_path,
+                         '-boot', 'd',
+                         '-no-reboot')
+        self.vm.launch()
+
+        wait_for_console_pattern(self, 'OpenBSD 7.9 (RAMDISK)', 'panic:')
+        wait_for_console_pattern(
+            self,
+            '(I)nstall, (U)pgrade, (A)utoinstall or (S)hell?',
+            'panic:')
+
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.55.0


