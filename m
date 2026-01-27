Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D94D25926
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 03:25:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkZgd-0004LL-L6; Mon, 26 Jan 2026 22:24:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vkZgb-0004KF-Tq; Mon, 26 Jan 2026 22:24:13 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vkZga-0003Z2-HJ; Mon, 26 Jan 2026 22:24:13 -0500
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
Subject: [PATCH v1 6/7] tests/functional/arm/test_aspeed_ast1060: Update test
 aspeed-zephyr-project v03.04
Date: Tue, 27 Jan 2026 11:23:42 +0800
Message-ID: <20260127032348.2238527-7-jamin_lin@aspeedtech.com>
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
 tests/functional/arm/test_aspeed_ast1060.py | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/functional/arm/test_aspeed_ast1060.py b/tests/functional/arm/test_aspeed_ast1060.py
index 034efa5342..eccb4252d8 100644
--- a/tests/functional/arm/test_aspeed_ast1060.py
+++ b/tests/functional/arm/test_aspeed_ast1060.py
@@ -11,18 +11,18 @@
 
 
 class AST1060Machine(AspeedTest):
-    ASSET_ASPEED_AST1060_PROT_3_02 = Asset(
+    ASSET_ASPEED_AST1060_PROT_3_04 = Asset(
         ('https://github.com/AspeedTech-BMC'
-         '/aspeed-zephyr-project/releases/download/v03.02'
-         '/ast1060_prot_v03.02.tgz'),
-         'dd5f1adc935316ddd1906506a02e15567bd7290657b52320f1a225564cc175bd')
+         '/aspeed-zephyr-project/releases/download/v03.04'
+         '/ast1060_prot_v03.04.tgz'),
+         'c0319df55f5b7a547efefc5a6ba374b881223d5fe1a776bfdd36f97fd1f31d50')
 
-    def test_arm_ast1060_prot_3_02(self):
+    def test_arm_ast1060_prot_3_04(self):
         self.set_machine('ast1060-evb')
 
         kernel_name = "ast1060_prot/zephyr.bin"
         kernel_file = self.archive_extract(
-            self.ASSET_ASPEED_AST1060_PROT_3_02, member=kernel_name)
+            self.ASSET_ASPEED_AST1060_PROT_3_04, member=kernel_name)
 
         self.vm.set_console()
         self.vm.add_args('-kernel', kernel_file, '-nographic')
@@ -35,7 +35,7 @@ def test_arm_ast1060_otp_blockdev_device(self):
         self.vm.set_machine("ast1060-evb")
 
         kernel_name = "ast1060_prot/zephyr.bin"
-        kernel_file = self.archive_extract(self.ASSET_ASPEED_AST1060_PROT_3_02,
+        kernel_file = self.archive_extract(self.ASSET_ASPEED_AST1060_PROT_3_04,
                                            member=kernel_name)
         otp_img = self.generate_otpmem_image()
 
-- 
2.43.0


