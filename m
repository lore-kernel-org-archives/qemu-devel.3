Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBB2BC61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 12:07:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x26CW-000399-Vh; Thu, 03 Sep 2026 08:05:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1x26CP-0002xx-Uf
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 08:05:46 -0400
Received: from mx1.catap.net ([2a01:4f8:271:125e::2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1x26CK-0005L8-OM
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 08:05:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=aQr3Fiw
 s2MAd5UUb2gC2xzjaH3Z0toUe2q1ug+VfWaLqy8iCFQq4BW2kosrK+ufXKngjS/OPT4Tqv
 spU+VdeiXEBI3lZcSlPNg6PIk4F8C4HtLOwH8GMqOV3BPg3CJKOsw387EXVrgVoJJRDxxE
 tzvsByghCP4gj13UehZkuVniH6oYI6sbTVjC1tgSX2ti+Td4UhWLdtXFVZbF4jlpg2HM+J
 dIAZBK5nPsRk5t8dqqsUDGz7DwdEg6b1ZMFrMwh0znthflryJpGYts35oo/CzOtZZKSCp4
 GpHqtABBHYekThi5X25bQqOlu3mKWgKI+n1IAylA+d5kijFtPDIdL9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=S
 WGfmNWEzuFLnOvW36cuYNj75rNosivGBrRlNukj2kU=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=GaFJ0uJEryEvFyKn27mWNtzCv+dxzpmVnyQG1QXPSGkTpzAxheJP7k5JTCxAfVt/G7Vm
 MhOqBuJ54WHgblK3RyyoTd81lvQpy9Mka1PdO1ySIInUnjpy7ByjvZz4g5KyX1KmFzQSnb
 nefI6uCkzk7OV3P2E8pImSEcwxYEDcW8MM+bdet2NmT/efQTg8+PRQ4c3qpYrTo6Jm2L6n
 MCOxnqzjFI9P726nykQettlaKsta6iiUUbrr/gS4Cl3gt9Xg5Rln+wm9644MR5kXy/oBbc
 wujr71fkqwpNeDcbC6HVr05eeF55I1OEcV+lzLie9ode4H79+6OZ/dlsOhgBcdow==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=VqbmbT7D; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=ys35gz7g;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=SWGfmNWE
 zuFLnOvW36cuYNj75rNosivGBrRlNukj2kU=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=VqbmbT7DB2E+6g8sKnSqjCR3rcPCjRGd2rq
 vrSjo8YBMyFqFq0jQbsPc2nFuKVdDLdyBjEGQSbn9FbeikpUSM59r8ZnQdU8q+k+8UXunq
 zHwY9e9Lb906/2/gbRTNxAtYzEpl4p62rKqGiI5CekNKXJbWZlA3xn+ygF0x/p0dHVhcBk
 KT9oRFF/T2/0byEIqp+CjcQTaD9Pguu4WP6VPlu1YztsMihiX3L5aOpGfD8Ju46UZmrJRo
 jcNLeWYgcn4/G7QtEpVIKS/OMgqQvZjtUON5UwxMGAnwbw+RwSfejjZ8pg2oIGYKwK3w4q
 zOhKYNO8Itdkbjq823HCGXAzJzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=SWGfmNWEzuFLnOvW36cuYNj75rNosivGBrRlNukj2kU=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=ys35gz7g+k2vqZO+7a
 KO4hitxb2TsrCEnqtloa92vxcye+JjJA/29RgZHqmm3DwGM+UZkOy2o9TqocOIKe48Ag==
Received: by mx1.catap.net (OpenSMTPD) with ESMTPSA id 4f02acfc
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Thu, 3 Sep 2026 14:05:34 +0200 (CEST)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 8ea342a1;
 Thu, 3 Sep 2026 14:05:16 +0200 (CEST)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH v2 25/25] tests/functional: test Octeon III boot
Date: Thu,  3 Sep 2026 14:02:13 +0200
Message-ID: <20260903120510.34876-26-kirill@korins.ky>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903120510.34876-1-kirill@korins.ky>
References: <20260903120510.34876-1-kirill@korins.ky>
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

Boot the OpenBSD/octeon ramdisk through U-Boot using an e1000 device
and QEMU user mode TFTP. Verify PCI enumeration, DHCP, image transfer
and entry into the OpenBSD installer.
---
 tests/functional/mips64/meson.build     |  2 +
 tests/functional/mips64/test_octeon3.py | 54 +++++++++++++++++++++++++
 2 files changed, 56 insertions(+)
 create mode 100644 tests/functional/mips64/test_octeon3.py

diff --git a/tests/functional/mips64/meson.build b/tests/functional/mips64/meson.build
index 3ff2118987..98b7c491a1 100644
--- a/tests/functional/mips64/meson.build
+++ b/tests/functional/mips64/meson.build
@@ -2,9 +2,11 @@
 
 test_mips64_timeouts = {
   'malta' : 240,
+  'octeon3' : 300,
 }
 
 tests_mips64_system_thorough = [
   'malta',
+  'octeon3',
   'tuxrun',
 ]
diff --git a/tests/functional/mips64/test_octeon3.py b/tests/functional/mips64/test_octeon3.py
new file mode 100644
index 0000000000..9c2bc67ac4
--- /dev/null
+++ b/tests/functional/mips64/test_octeon3.py
@@ -0,0 +1,54 @@
+#!/usr/bin/env python3
+#
+# Functional test for the Cavium Octeon III / EBB7304 machine.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+import shutil
+
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import wait_for_console_pattern
+from qemu_test import exec_command_and_wait_for_pattern as ec_and_wait
+
+
+class Octeon3Machine(QemuSystemTest):
+
+    ASSET_UBOOT = Asset(
+        'https://kirill.korins.ky/pub/qemu-mips64-openbsd/u-boot.bin',
+        '7e519b2e52ba44b27bfafd16738c8f485e9eda5438b4899cf6a70520a6d34396')
+
+    ASSET_BSD_RD = Asset(
+        'https://kirill.korins.ky/pub/qemu-mips64-openbsd/bsd.rd',
+        '907f26f0ff67390dd21dc85e2c854fc0e65db295b15d47ae92e1927f98ac5872')
+
+    def test_openbsd_ramdisk_tftp(self):
+        self.require_netdev('user')
+        self.require_device('e1000')
+        self.set_machine('octeon3')
+
+        tftp_dir = self.scratch_file('tftp')
+        os.mkdir(tftp_dir)
+        shutil.copy(self.ASSET_BSD_RD.fetch(),
+                    os.path.join(tftp_dir, 'bsd.rd'))
+
+        self.vm.set_console()
+        self.vm.add_args('-bios', self.ASSET_UBOOT.fetch(),
+                         '-m', '1G',
+                         '-smp', '4',
+                         '-no-reboot',
+                         '-netdev',
+                         f'user,id=net0,tftp={tftp_dir},bootfile=bsd.rd',
+                         '-device', 'e1000,netdev=net0')
+        self.vm.launch()
+
+        wait_for_console_pattern(self, '=> ')
+        ec_and_wait(self, 'pci enum', '=> ')
+        ec_and_wait(self, 'dhcp', 'Bytes transferred')
+        wait_for_console_pattern(self, '=> ')
+        ec_and_wait(self, 'bootoctlinux ${loadaddr} numcores=4',
+                    'Welcome to the OpenBSD/octeon 7.9 installation program.')
+
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.55.0


