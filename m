Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96372CA1012
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 10:08:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu6rV-0004Z8-2b; Thu, 04 Sep 2025 06:06:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uu6rM-0004Uc-Ae; Thu, 04 Sep 2025 06:06:28 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uu6rK-0004eu-0u; Thu, 04 Sep 2025 06:06:28 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 4 Sep
 2025 18:05:57 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 4 Sep 2025 18:05:57 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, <thuth@redhat.com>, Kane-Chen-AS
 <kane_chen@aspeedtech.com>
Subject: [PATCH v1 3/4] tests/functional/arm: Update test ASPEED SDK v09.07
 for AST2600
Date: Thu, 4 Sep 2025 18:05:54 +0800
Message-ID: <20250904100556.1729604-4-kane_chen@aspeedtech.com>
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
 tests/functional/arm/test_aspeed_ast2600.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/functional/arm/test_aspeed_ast2600.py b/tests/functional/arm/test_aspeed_ast2600.py
index fdae4c939d..129695ca4e 100755
--- a/tests/functional/arm/test_aspeed_ast2600.py
+++ b/tests/functional/arm/test_aspeed_ast2600.py
@@ -97,14 +97,14 @@ def test_arm_ast2600_evb_buildroot_tpm(self):
 
         self.do_test_arm_aspeed_buildroot_poweroff()
 
-    ASSET_SDK_V906_AST2600 = Asset(
-        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.06/ast2600-default-obmc.tar.gz',
-        '768d76e247896ad78c154b9cff4f766da2ce65f217d620b286a4a03a8a4f68f5')
+    ASSET_SDK_V907_AST2600 = Asset(
+        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.07/ast2600-default-obmc.tar.gz',
+        'cb6c08595bcbba1672ce716b068ba4e48eda1ed9abe78a07b30392ba2278feba')
 
     def test_arm_ast2600_evb_sdk(self):
         self.set_machine('ast2600-evb')
 
-        self.archive_extract(self.ASSET_SDK_V906_AST2600)
+        self.archive_extract(self.ASSET_SDK_V907_AST2600)
 
         self.vm.add_args('-device',
             'tmp105,bus=aspeed.i2c.bus.5,address=0x4d,id=tmp-test')
-- 
2.43.0


