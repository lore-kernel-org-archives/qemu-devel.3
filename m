Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24EDACCA470
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 07:24:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4a7o-0006QW-5o; Fri, 03 Oct 2025 03:22:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v4a7j-0006Oa-LA; Fri, 03 Oct 2025 03:22:39 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v4a7U-0001f4-SO; Fri, 03 Oct 2025 03:22:38 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 3 Oct
 2025 15:21:08 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 3 Oct 2025 15:21:08 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>
Subject: [PATCH v1 4/5] tests/functional/aarch64/test_aspeed_ast2700: Update
 test ASPEED SDK v09.08 for A1
Date: Fri, 3 Oct 2025 15:21:05 +0800
Message-ID: <20251003072107.3530642-5-jamin_lin@aspeedtech.com>
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
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_FAIL=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Support for AST2700 A0 was dropped starting from SDK v09.07.
The new SDK v09.08 only updates support for AST2700 A1.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 .../functional/aarch64/test_aspeed_ast2700.py  | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/tests/functional/aarch64/test_aspeed_ast2700.py b/tests/functional/aarch64/test_aspeed_ast2700.py
index 0973fce0e9..0e9f10d991 100755
--- a/tests/functional/aarch64/test_aspeed_ast2700.py
+++ b/tests/functional/aarch64/test_aspeed_ast2700.py
@@ -50,13 +50,9 @@ def verify_openbmc_boot_and_login(self, name):
             'https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.06/ast2700-a0-default-obmc.tar.gz',
             '7247b6f19dbfb700686f8d9f723ac23f3eb229226c0589cb9b06b80d1b61f3cb')
 
-    ASSET_SDK_V906_AST2700A1 = Asset(
-            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.06/ast2700-default-obmc.tar.gz',
-            'f1d53e0be8a404ecce3e105f72bc50fa4e090ad13160ffa91b10a6e0233a9dc6')
-
-    ASSET_SDK_V907_AST2700A1_VBOOROM = Asset(
-            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.07/ast2700-default-obmc.tar.gz',
-            '6e9e0c4b13e0f26040eca3f4a7f17cf09fc0f5c37c820500ff79370cc3c44add')
+    ASSET_SDK_V908_AST2700A1 = Asset(
+            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.08/ast2700-default-obmc.tar.gz',
+            'eac3dc409b7ea3cd4b03d4792d3cebd469792ad893cb51e1d15f0fc20bd1e2cd')
 
     def do_ast2700_i2c_test(self):
         exec_command_and_wait_for_pattern(self,
@@ -133,11 +129,11 @@ def test_aarch64_ast2700a0_evb_sdk_v09_06(self):
         self.verify_openbmc_boot_and_login('ast2700-a0-default')
         self.do_ast2700_i2c_test()
 
-    def test_aarch64_ast2700a1_evb_sdk_v09_06(self):
+    def test_aarch64_ast2700a1_evb_sdk_v09_08(self):
         self.set_machine('ast2700a1-evb')
         self.require_netdev('user')
 
-        self.archive_extract(self.ASSET_SDK_V906_AST2700A1)
+        self.archive_extract(self.ASSET_SDK_V908_AST2700A1)
         self.vm.add_args('-device', 'e1000e,netdev=net1,bus=pcie.2')
         self.vm.add_args('-netdev', 'user,id=net1')
         self.start_ast2700_test('ast2700-default')
@@ -145,11 +141,11 @@ def test_aarch64_ast2700a1_evb_sdk_v09_06(self):
         self.do_ast2700_i2c_test()
         self.do_ast2700_pcie_test()
 
-    def test_aarch64_ast2700a1_evb_sdk_vbootrom_v09_07(self):
+    def test_aarch64_ast2700a1_evb_sdk_vbootrom_v09_08(self):
         self.set_machine('ast2700a1-evb')
         self.require_netdev('user')
 
-        self.archive_extract(self.ASSET_SDK_V907_AST2700A1_VBOOROM)
+        self.archive_extract(self.ASSET_SDK_V908_AST2700A1)
         self.vm.add_args('-device', 'e1000e,netdev=net1,bus=pcie.2')
         self.vm.add_args('-netdev', 'user,id=net1')
         self.start_ast2700_test_vbootrom('ast2700-default')
-- 
2.43.0


