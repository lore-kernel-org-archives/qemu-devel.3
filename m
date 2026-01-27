Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A377D25929
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 03:25:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkZgb-0004Jq-5q; Mon, 26 Jan 2026 22:24:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vkZgZ-0004Is-NN; Mon, 26 Jan 2026 22:24:11 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vkZgY-0003Z2-8D; Mon, 26 Jan 2026 22:24:11 -0500
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
Subject: [PATCH v1 5/7] tests/functional/arm/test_aspeed_ast2600_sdk: Update
 test ASPEED SDK v11.00
Date: Tue, 27 Jan 2026 11:23:41 +0800
Message-ID: <20260127032348.2238527-6-jamin_lin@aspeedtech.com>
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

Drop root device and set root bus number to 0.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 .../functional/arm/test_aspeed_ast2600_sdk.py | 22 ++++++++-----------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/tests/functional/arm/test_aspeed_ast2600_sdk.py b/tests/functional/arm/test_aspeed_ast2600_sdk.py
index e3d4ed09e2..6236aeb11c 100755
--- a/tests/functional/arm/test_aspeed_ast2600_sdk.py
+++ b/tests/functional/arm/test_aspeed_ast2600_sdk.py
@@ -14,22 +14,18 @@
 
 class AST2600Machine(AspeedTest):
 
-    ASSET_SDK_V908_AST2600 = Asset(
-        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.08/ast2600-default-obmc.tar.gz',
-        'a0414f14ad696550efe083c2156dbeda855c08cc9ae7f40fe1b41bf292295f82')
+    ASSET_SDK_V1100_AST2600 = Asset(
+        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.00/ast2600-default-obmc.tar.gz',
+        '64d8926a7d01b649168be96c986603b5690f06391286c438a3a772c8c7039e93')
 
     def do_ast2600_pcie_test(self):
         exec_command_and_wait_for_pattern(self,
-            'lspci -s 80:00.0',
-            '80:00.0 Host bridge: '
-            'ASPEED Technology, Inc. Device 2600')
-        exec_command_and_wait_for_pattern(self,
-            'lspci -s 80:08.0',
-            '80:08.0 PCI bridge: '
+            'lspci -s 00:08.0',
+            '00:08.0 PCI bridge: '
             'ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge')
         exec_command_and_wait_for_pattern(self,
-            'lspci -s 81:00.0',
-            '81:00.0 Ethernet controller: '
+            'lspci -s 01:00.0',
+            '01:00.0 Ethernet controller: '
             'Intel Corporation 82574L Gigabit Network Connection')
         exec_command_and_wait_for_pattern(self,
             'ip addr show dev eth4',
@@ -39,7 +35,7 @@ def test_arm_ast2600_evb_sdk(self):
         self.set_machine('ast2600-evb')
         self.require_netdev('user')
 
-        self.archive_extract(self.ASSET_SDK_V908_AST2600)
+        self.archive_extract(self.ASSET_SDK_V1100_AST2600)
 
         self.vm.add_args('-device',
             'tmp105,bus=aspeed.i2c.bus.5,address=0x4d,id=tmp-test')
@@ -77,7 +73,7 @@ def test_arm_ast2600_evb_sdk(self):
     def test_arm_ast2600_otp_blockdev_device(self):
         self.vm.set_machine("ast2600-evb")
 
-        image_path = self.archive_extract(self.ASSET_SDK_V908_AST2600)
+        image_path = self.archive_extract(self.ASSET_SDK_V1100_AST2600)
         otp_img = self.generate_otpmem_image()
 
         self.vm.set_console()
-- 
2.43.0


