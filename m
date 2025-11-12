Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C45FCCFA18
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 03:09:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJ1Bx-0000lw-9O; Tue, 11 Nov 2025 22:06:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vJ1Bw-0000ky-4N; Tue, 11 Nov 2025 22:06:40 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vJ1Bu-00048F-KN; Tue, 11 Nov 2025 22:06:39 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 12 Nov
 2025 11:05:56 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 12 Nov 2025 11:05:56 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>, "Kevin
 Wolf" <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>
Subject: [PATCH v2 10/12] tests/functional/arm/test_aspeed_ast1060: Add
 functional tests for Aspeed AST1060 SoC
Date: Wed, 12 Nov 2025 11:05:47 +0800
Message-ID: <20251112030553.291734-11-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251112030553.291734-1-jamin_lin@aspeedtech.com>
References: <20251112030553.291734-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_FAIL=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add functional tests for the Aspeed AST1060 SoC and its evaluation board.
The new test test_aspeed_ast1060.py validates booting the AST1060 EVB
machine using the Zephyr OS and ASPEED PROT application (ast1060_prot_v03.02.tgz)
and ensures basic console functionality.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 tests/functional/arm/meson.build            |  1 +
 tests/functional/arm/test_aspeed_ast1060.py | 52 +++++++++++++++++++++
 2 files changed, 53 insertions(+)
 create mode 100644 tests/functional/arm/test_aspeed_ast1060.py

diff --git a/tests/functional/arm/meson.build b/tests/functional/arm/meson.build
index d1ed076a6a..1762a49604 100644
--- a/tests/functional/arm/meson.build
+++ b/tests/functional/arm/meson.build
@@ -28,6 +28,7 @@ tests_arm_system_quick = [
 
 tests_arm_system_thorough = [
   'aspeed_ast1030',
+  'aspeed_ast1060',
   'aspeed_palmetto',
   'aspeed_romulus',
   'aspeed_witherspoon',
diff --git a/tests/functional/arm/test_aspeed_ast1060.py b/tests/functional/arm/test_aspeed_ast1060.py
new file mode 100644
index 0000000000..034efa5342
--- /dev/null
+++ b/tests/functional/arm/test_aspeed_ast1060.py
@@ -0,0 +1,52 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots the ASPEED SoCs with firmware
+#
+# Copyright (C) 2025 ASPEED Technology Inc
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from aspeed import AspeedTest
+from qemu_test import Asset, exec_command_and_wait_for_pattern
+
+
+class AST1060Machine(AspeedTest):
+    ASSET_ASPEED_AST1060_PROT_3_02 = Asset(
+        ('https://github.com/AspeedTech-BMC'
+         '/aspeed-zephyr-project/releases/download/v03.02'
+         '/ast1060_prot_v03.02.tgz'),
+         'dd5f1adc935316ddd1906506a02e15567bd7290657b52320f1a225564cc175bd')
+
+    def test_arm_ast1060_prot_3_02(self):
+        self.set_machine('ast1060-evb')
+
+        kernel_name = "ast1060_prot/zephyr.bin"
+        kernel_file = self.archive_extract(
+            self.ASSET_ASPEED_AST1060_PROT_3_02, member=kernel_name)
+
+        self.vm.set_console()
+        self.vm.add_args('-kernel', kernel_file, '-nographic')
+        self.vm.launch()
+        self.wait_for_console_pattern("Booting Zephyr OS")
+        exec_command_and_wait_for_pattern(self, "help",
+                                          "Available commands")
+
+    def test_arm_ast1060_otp_blockdev_device(self):
+        self.vm.set_machine("ast1060-evb")
+
+        kernel_name = "ast1060_prot/zephyr.bin"
+        kernel_file = self.archive_extract(self.ASSET_ASPEED_AST1060_PROT_3_02,
+                                           member=kernel_name)
+        otp_img = self.generate_otpmem_image()
+
+        self.vm.set_console()
+        self.vm.add_args(
+            "-kernel", kernel_file,
+            "-blockdev", f"driver=file,filename={otp_img},node-name=otp",
+            "-global", "aspeed-otp.drive=otp",
+        )
+        self.vm.launch()
+        self.wait_for_console_pattern("Booting Zephyr OS")
+
+if __name__ == '__main__':
+    AspeedTest.main()
-- 
2.43.0


