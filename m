Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BE6606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 20:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=f9F2VmED;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=WEyWuM7Y
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMX1e-00010x-Ij; Thu, 29 Oct 2026 16:47:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xMX1H-0008PU-0G
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 16:46:43 -0400
Received: from mx1.catap.net ([162.55.82.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xMX1E-0007Tg-L8
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 16:46:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=yi4Y6wL
 YufR0WSn+GKO0+1o2pqYSwU1UHesFfLvPsE84Z2kVCPOJwJNzbU+WaS44psIZPqmrwv0yJ
 Mxv0245w9RysBmvk2mXCwvdUd/3qV0EciL2hF7SXGjj0d9axl706A6PjA72maU5zqvtesL
 lzYWRYh7hbVlw/rLasxKVNdMWusubKmlxLrhhfxMOanvJPPKD0ibInmPLYA/BD9c4HkHq8
 6Q6seMsBAN07B1hNIDk6lMW5lvD7fmT0kDU9PPTEAxMFfREGzBHfES9+z/PLQy8HiQCKNH
 FpiUyvcnemh9GaFYsFbdEDpWFklVu9qYnimRvbPzBO3M8yfC0ysqYCg==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=Y
 6d3nL/8O4alIMPMbOwSmpEvoTXX8GrBSyv7hrl9FxE=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=VuwDf2gUufmUxg5eqhN+i4oTnQ+mpnbKvkdHG+5L5RwwwN+nen1Lrco/DTwk5EU/SY9N
 sA3GEnowYdNRKD57Z5kKQ8D4LtBGJCyrmT4LrquxAnMxMEzPSZ/0+aJ24UEXqQiMN+5E9D
 wqr/uRBKG/SUhq6zGCI7s47qI1wTJzzIdZOMXiKZTYQkk9nr1TWoY3DRIeTN/QxnYNj2ws
 y2/XN191WpowFcGC8Vg4z39nq1GDJgM+1Xt+UBOg2GRn8gwqwIjKG5w4cCk6UbBLhvVLCB
 klzfEqigBgUW7/V9Z9lERhN7A8kvhnJstIxDk6tW/t4L3GsodL3a+dj2aWqMHRTA==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=f9F2VmED; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=WEyWuM7Y;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=Y6d3nL/8
 O4alIMPMbOwSmpEvoTXX8GrBSyv7hrl9FxE=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=f9F2VmEDh/lWwzH1/ynI9/9cqSCHrkPk/NZ
 wa6qGk20QAgrByeL4tHQJBEA0vefYFGRH6Qs1X9UaFSIIeD4B9/vM9BWGfL8HyVJ6dJhJa
 cRu6BS6EZtmCwn8/NkTgHa8KWBI8KzhyQ8OG0iR653uIqbRjuoyEzdYPvBiwW2BFkVFREG
 6AI7qxjDaxtw7QvtCvi8Iuw2s0PlYVpA9UW9i9NOBpJ+9pO9h9XozfqyE8UM9uTJ8/vlKq
 nNAs34+Zxp9+TAqZNJKq1q+7bgc5dGS8osd1WFra3eoWXPUfSvYE4XOOVefXlX5CmL4x26
 G+i1WxcQcxaFohXQNIGN5EE4faw==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=Y6d3nL/8O4alIMPMbOwSmpEvoTXX8GrBSyv7hrl9FxE=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=WEyWuM7YhWVXvu7cN3
 R56V3eqNiU3v6Lt0IIfJv8+FozYQZdHgQbefbOEj3777xcnPaquH4TOL7AYHqzXq6lBA==
Received: by mx1.catap.net (OpenSMTPD) id 3ce9d001;
 Thu, 29 Oct 2026 21:46:20 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 4c6ad5df;
 Thu, 29 Oct 2026 21:46:14 +0100 (CET)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH v5 26/26] tests/functional: test Octeon III boot
Date: Thu, 29 Oct 2026 21:44:11 +0100
Message-ID: <20261029204609.38989-27-kirill@korins.ky>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029204609.38989-1-kirill@korins.ky>
References: <20261029204609.38989-1-kirill@korins.ky>
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


