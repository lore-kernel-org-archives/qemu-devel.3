Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A913ACCA470
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 07:23:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4a76-00066Q-L0; Fri, 03 Oct 2025 03:22:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v4a72-00062z-TP; Fri, 03 Oct 2025 03:21:56 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v4a6s-0001f4-4I; Fri, 03 Oct 2025 03:21:55 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 3 Oct
 2025 15:21:07 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 3 Oct 2025 15:21:07 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>
Subject: [PATCH v1 1/5] tests/functional/arm/test_aspeed_ast1030: Update test
 ASPEED SDK v03.03
Date: Fri, 3 Oct 2025 15:21:02 +0800
Message-ID: <20251003072107.3530642-2-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003072107.3530642-1-jamin_lin@aspeedtech.com>
References: <20251003072107.3530642-1-jamin_lin@aspeedtech.com>
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

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 tests/functional/arm/test_aspeed_ast1030.py | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/tests/functional/arm/test_aspeed_ast1030.py b/tests/functional/arm/test_aspeed_ast1030.py
index e47b597d0b..60e2b0251c 100755
--- a/tests/functional/arm/test_aspeed_ast1030.py
+++ b/tests/functional/arm/test_aspeed_ast1030.py
@@ -13,17 +13,17 @@
 
 class AST1030Machine(AspeedTest):
 
-    ASSET_ZEPHYR_3_02 = Asset(
+    ASSET_ZEPHYR_3_03 = Asset(
         ('https://github.com/AspeedTech-BMC'
-         '/zephyr/releases/download/v00.03.02/ast1030-evb-demo.zip'),
-        '1ec83caab3ddd5d09481772801be7210e222cb015ce22ec6fffb8a76956dcd4f')
+         '/zephyr/releases/download/v00.03.03/ast1030-evb-demo.zip'),
+         '27cd73cdee6374bceb4ee58b3ace87989fa3f0684f4e612510804b588b24d4e0')
 
-    def test_arm_ast1030_zephyros_3_02(self):
+    def test_arm_ast1030_zephyros_3_03(self):
         self.set_machine('ast1030-evb')
 
-        kernel_name = "ast1030-evb-demo-3/zephyr.elf"
+        kernel_name = "ast1030-evb-demo/zephyr.elf"
         kernel_file = self.archive_extract(
-            self.ASSET_ZEPHYR_3_02, member=kernel_name)
+            self.ASSET_ZEPHYR_3_03, member=kernel_name)
 
         self.vm.set_console()
         self.vm.add_args('-kernel', kernel_file, '-nographic')
@@ -72,8 +72,9 @@ def test_arm_ast1030_zephyros_1_07(self):
     def test_arm_ast1030_otp_blockdev_device(self):
         self.vm.set_machine("ast1030-evb")
 
-        kernel_name = "ast1030-evb-demo-3/zephyr.elf"
-        kernel_file = self.archive_extract(self.ASSET_ZEPHYR_3_02, member=kernel_name)
+        kernel_name = "ast1030-evb-demo/zephyr.elf"
+        kernel_file = self.archive_extract(self.ASSET_ZEPHYR_3_03,
+                                           member=kernel_name)
         otp_img = self.generate_otpmem_image()
 
         self.vm.set_console()
-- 
2.43.0


