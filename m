Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1127F606A32A
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 14:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=cxHgeIPX;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=nrkjnkcb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR9RY-0001FP-2E; Wed, 11 Nov 2026 09:36:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xR9RA-00011V-Rc
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 09:36:33 -0500
Received: from mx2.catap.net ([65.21.79.163])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xR9R4-00025c-AL
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 09:36:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=jxzEK/H
 Pz8cYEfjzzGXpr03IFtGYQ4dEs45+kf3+8FkqdTbRGFZPvA1tPDZz1/WmNiMYu044WpnSW
 06EMlPM3pzCfe3kBIMzUKe+jmHt+okBCJFDzCFbMRm8Eoo3g66UQzZrxh1idz/kdEkDu3j
 TEvvIIm86TQ9lUYzm1WsXZFeBK3+u6o1W9H7B5LzgNzeXbgUEUZF+po2khfrZRFlTO+mi0
 jXSmZ9XgBtjwQUeJMOBPWgqGU5yOvUuJdc7LDSzb0t2FHu2QaOU24pyOdmoDcV1AJJZ1A4
 235met/cUyerCHva2ccj3ZokWBsEzoAhs3W3QITlvf7e2NAqJ+NDr/w==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=a
 lPetn4aE/xvcLwyw7DORbklqnqs0MzMLKrQO9jiiqg=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=dR15L6F61XF0ZWnXa76jFcw40ExR19VZCLH59YqOv9+yLSgXpXSMhoUD0FlmCZE5JyEC
 YfSO0PttffqAHZ40faGa/nJhzz1g+ViZU06SlehnHdnqlXQtejdW28YE2WyD6IF5ajv5kL
 h6PTev3lXwqRJl6aTXeDX2lSuhl3G0r6X+qCmkheMkDlqSNibuC2Mqk8VfF8UyZzHzlHBE
 rZCqFIK4wwm6dRN4mbYxcutAsiZ1+zjeWmYbxCJDkp/urhB6vQRH4B5PP9UmW0sjtet/YP
 QPSwPg+6cnVG2FIOmqhWjOgMfoAbfQLmcqhdq02oh4DpIYn6jE3ZX8fgz9t9YpzQ==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=cxHgeIPX; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=nrkjnkcb;
 arc=none; iprev=fail; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=alPetn4a
 E/xvcLwyw7DORbklqnqs0MzMLKrQO9jiiqg=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=cxHgeIPX5N+v57E4o5c9RK3VemgJ1k7P05I
 0BWLLy9Sf0RB5UTxV7VGHk83zfNdmTKUv/flDgIibFk4CMFR2Clh7I4WaKUbw0EyqWwb/+
 Bqfj6la26Cl8Fojt07c2iMC8GPwZJmwEsVCSpQSw1K5rg3AVl/5uA3EIlbSjBtEsP/uHu1
 tqxBM2i5M3q1t71dx3Vr/5yE7JxKtuErYNmDwHlyOI+yWcoIxEEWmO64z9cEjspQifAWRY
 4cNq5lgh91toYfbZMd/sks2AoehwWbQtuepcLwkktzV8sAGAKAO5DLGQykrzGdZoqYhqXc
 UQaWDauvd/0YOraTKZlgq3Nvutg==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=alPetn4aE/xvcLwyw7DORbklqnqs0MzMLKrQO9jiiqg=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=nrkjnkcbGFbI4tzlLk
 5W49BNH02hfccaBdrLbh0zxan3p0m2sduVNo4DK8ALqya5YNDgfbaz+61Ggmkpkx/HAQ==
Received: by mx2.catap.net (OpenSMTPD) id e9a51f31;
 Wed, 11 Nov 2026 15:36:17 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 0a213944;
 Wed, 11 Nov 2026 15:35:55 +0100 (CET)
From: Kirill A. Korinsky <kirill@korins.ky>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: "Kirill A . Korinsky" <kirill@korins.ky>
Subject: [PATCH v7 26/26] tests/functional: test Octeon III boot
Date: Wed, 11 Nov 2026 15:32:26 +0100
Message-ID: <20261111143533.1775-27-kirill@korins.ky>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111143533.1775-1-kirill@korins.ky>
References: <20261111143533.1775-1-kirill@korins.ky>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=65.21.79.163; envelope-from=kirill@korins.ky;
 helo=mx2.catap.net
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: "Kirill A. Korinsky" <kirill@korins.ky>

Boot the OpenBSD/octeon ramdisk through U-Boot using an e1000 device
and QEMU user mode TFTP. Verify PCI enumeration, DHCP, image transfer
and entry into the OpenBSD installer.

Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
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
2.56.0


