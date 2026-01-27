Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ECBFD25929
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 03:25:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkZgg-0004M9-HR; Mon, 26 Jan 2026 22:24:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vkZge-0004LY-2Y; Mon, 26 Jan 2026 22:24:16 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vkZgc-0003Z2-NA; Mon, 26 Jan 2026 22:24:15 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 27 Jan
 2026 11:23:50 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 27 Jan 2026 11:23:50 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>
Subject: [PATCH v1 7/7] tests/functional/arm/test_aspeed_ast1030: Update test
 ASPEED Zephyr SDK v03.05
Date: Tue, 27 Jan 2026 11:23:43 +0800
Message-ID: <20260127032348.2238527-8-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260127032348.2238527-1-jamin_lin@aspeedtech.com>
References: <20260127032348.2238527-1-jamin_lin@aspeedtech.com>
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 tests/functional/arm/test_aspeed_ast1030.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/functional/arm/test_aspeed_ast1030.py b/tests/functional/arm/test_aspeed_ast1030.py
index d1822edd8f..0defa7c38e 100755
--- a/tests/functional/arm/test_aspeed_ast1030.py
+++ b/tests/functional/arm/test_aspeed_ast1030.py
@@ -12,17 +12,17 @@
 
 class AST1030Machine(AspeedTest):
 
-    ASSET_ZEPHYR_3_03 = Asset(
+    ASSET_ZEPHYR_3_05 = Asset(
         ('https://github.com/AspeedTech-BMC'
-         '/zephyr/releases/download/v00.03.03/ast1030-evb-demo.zip'),
-         '27cd73cdee6374bceb4ee58b3ace87989fa3f0684f4e612510804b588b24d4e0')
+         '/zephyr/releases/download/v00.03.05/ast1030-evb-demo.zip'),
+         '057528d343490b1fbb5a721e91084b4f04fec60dc114bd65e724554f9c217f4b')
 
-    def test_arm_ast1030_zephyros_3_03(self):
+    def test_arm_ast1030_zephyros_3_05(self):
         self.set_machine('ast1030-evb')
 
         kernel_name = "ast1030-evb-demo/zephyr.elf"
         kernel_file = self.archive_extract(
-            self.ASSET_ZEPHYR_3_03, member=kernel_name)
+            self.ASSET_ZEPHYR_3_05, member=kernel_name)
 
         self.vm.set_console()
         self.vm.add_args('-kernel', kernel_file, '-nographic')
@@ -72,7 +72,7 @@ def test_arm_ast1030_otp_blockdev_device(self):
         self.vm.set_machine("ast1030-evb")
 
         kernel_name = "ast1030-evb-demo/zephyr.elf"
-        kernel_file = self.archive_extract(self.ASSET_ZEPHYR_3_03,
+        kernel_file = self.archive_extract(self.ASSET_ZEPHYR_3_05,
                                            member=kernel_name)
         otp_img = self.generate_otpmem_image()
 
-- 
2.43.0


