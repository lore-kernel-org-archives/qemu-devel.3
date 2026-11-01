Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A73C606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 14:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=gjmzmI4n;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=08PVGySZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNWYK-00077q-Fe; Sun, 01 Nov 2026 09:28:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xNWXJ-0006d0-BJ
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 09:27:56 -0500
Received: from mx1.catap.net ([162.55.82.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xNWXH-00084M-Ai
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 09:27:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=Jco2lHe
 dEtM6oEpeiwb49K9NrrWOMv0GQsMl2CiiavkVyo4HH3NE4KnbQKiS8L50Kb9qNjp8NXbv9
 ywkdfd1nN0h/TlN13dna+rYq2ZJp6ldIonjsVyc/Mv6bifeASP0t+C/cb+8Vx0wnbCmtIc
 nInTWyMznYOCh6TZ1H3huJf1PGMNxfICR7bE4NaHIXqM5C9odaLFT63Mvav7CC8AVltlGn
 Nu6JYxe4Wfadn/Uh8iodUCmBQygKN5g9SxUNOY/MPlAOskuSTVI2JOJyOxd8irUb3Kmasc
 yOpeU4KBLfybAQ8+tbVCsuA1+nz4lyrpkgWMZjIx0MIWo6k0bbkNR0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=Y
 6d3nL/8O4alIMPMbOwSmpEvoTXX8GrBSyv7hrl9FxE=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=xPUebZ5zYQSekfqqZrSedVFukqGjMKQNXFy/iSqxgpJ8FfzhHhUv9HvBsTv3L7gIfwOB
 OdQIyGvZ7JzLaXUPZPtL2EqMfVxRbbfUhLiMjqu2oIrotfqVNaUooV4CkafXbYzKiGfGdM
 dIH2soxrwfMOyWk1MKEm7d+L1wPM7ENe6VFM6zP5HrGtBPGjvZY3K6h5tP1qZF8Vv3zVz+
 JpHXnxbcFkUKOlZxNpuwb80HreJWMZ0/wUhG/QBqjhyq3ob5ZhNDcB7di/jG4tDrvYwjNn
 05eWlq17neUu0+qySTZ6SRS2gJ3zIcqkk+db5+kPEGdi59yNLaIxd6++BTgFfXbg==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=gjmzmI4n; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=08PVGySZ;
 arc=none; iprev=fail; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=Y6d3nL/8
 O4alIMPMbOwSmpEvoTXX8GrBSyv7hrl9FxE=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=gjmzmI4nJ7ENV5zeNfeQzOuXvqRM4HMOgaW
 di5kNt+Y6vxmC/g7YPidoU/lf9z/rFzCjDRsW8KgcK/7Xif2BDP3fcsgFpJhDi9C1D2KJg
 gitDcvfaEiEKK9innbxRiu6WZJlsgXRwjKw++4j7ZFrB9cv0gLgslV7sEytWI2BBUFJElq
 UhATisfeRaL6HYbKUe6F59tLQdS53VANTyzzqID3iC8bh1pzaPfjo0x9PeH8WQqALEUxNl
 w5UD32LrFXqqPRmOGgyazdlFwEQXCQ7lG0Of72MB9ELHVQ7kfxePQuZ6Qo5bnC96A/bku5
 BE1XUAriCpFdlHKbgeTiq7ehMMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=Y6d3nL/8O4alIMPMbOwSmpEvoTXX8GrBSyv7hrl9FxE=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=08PVGySZu9XNgeyjXo
 E8wkBGfCxmXfHxzoW80ULcus5UlNFjkRgFdPyJB9G4W0vHMTi+9nlYjsC6yjxW8JGJBw==
Received: by mx1.catap.net (OpenSMTPD) id c1976895;
 Sun, 1 Nov 2026 15:27:39 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 39e7d82e;
 Sun, 1 Nov 2026 15:27:32 +0100 (CET)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH v6 26/26] tests/functional: test Octeon III boot
Date: Sun,  1 Nov 2026 15:23:42 +0100
Message-ID: <20261101142723.41346-27-kirill@korins.ky>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261101142723.41346-1-kirill@korins.ky>
References: <20261101142723.41346-1-kirill@korins.ky>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.55.82.72; envelope-from=kirill@korins.ky;
 helo=mx1.catap.net
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


