Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11051CA1002
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 10:07:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu6ra-0004hJ-Fi; Thu, 04 Sep 2025 06:06:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uu6rS-0004Xq-HO; Thu, 04 Sep 2025 06:06:36 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uu6rO-0004eu-AV; Thu, 04 Sep 2025 06:06:33 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 4 Sep
 2025 18:05:58 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 4 Sep 2025 18:05:58 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, <thuth@redhat.com>, Kane-Chen-AS
 <kane_chen@aspeedtech.com>
Subject: [PATCH v1 4/4] tests/functional/arm: Update test ASPEED SDK v09.07
 for AST2700 vbootrom
Date: Thu, 4 Sep 2025 18:05:55 +0800
Message-ID: <20250904100556.1729604-5-kane_chen@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250904100556.1729604-1-kane_chen@aspeedtech.com>
References: <20250904100556.1729604-1-kane_chen@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=kane_chen@aspeedtech.com; helo=TWMBX01.aspeed.com
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
Reply-to:  Kane Chen <kane_chen@aspeedtech.com>
From:  Kane Chen via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Kane-Chen-AS <kane_chen@aspeedtech.com>

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
---
 tests/functional/aarch64/test_aspeed_ast2700.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tests/functional/aarch64/test_aspeed_ast2700.py b/tests/functional/aarch64/test_aspeed_ast2700.py
index e8e06701cf..a3db267294 100755
--- a/tests/functional/aarch64/test_aspeed_ast2700.py
+++ b/tests/functional/aarch64/test_aspeed_ast2700.py
@@ -54,6 +54,10 @@ def verify_openbmc_boot_and_login(self, name):
             'https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.06/ast2700-default-obmc.tar.gz',
             'f1d53e0be8a404ecce3e105f72bc50fa4e090ad13160ffa91b10a6e0233a9dc6')
 
+    ASSET_SDK_V907_AST2700A1_VBOOROM = Asset(
+            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.07/ast2700-default-obmc.tar.gz',
+            '6e9e0c4b13e0f26040eca3f4a7f17cf09fc0f5c37c820500ff79370cc3c44add')
+
     def do_ast2700_i2c_test(self):
         exec_command_and_wait_for_pattern(self,
             'echo lm75 0x4d > /sys/class/i2c-dev/i2c-1/device/new_device ',
@@ -127,10 +131,10 @@ def test_aarch64_ast2700a1_evb_sdk_v09_06(self):
         self.verify_openbmc_boot_and_login('ast2700-default')
         self.do_ast2700_i2c_test()
 
-    def test_aarch64_ast2700a1_evb_sdk_vbootrom_v09_06(self):
+    def test_aarch64_ast2700a1_evb_sdk_vbootrom_v09_07(self):
         self.set_machine('ast2700a1-evb')
 
-        self.archive_extract(self.ASSET_SDK_V906_AST2700A1)
+        self.archive_extract(self.ASSET_SDK_V907_AST2700A1_VBOOROM)
         self.start_ast2700_test_vbootrom('ast2700-default')
         self.verify_vbootrom_firmware_flow()
         self.verify_openbmc_boot_and_login('ast2700-default')
-- 
2.43.0


