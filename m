Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C9D5CA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 04:22:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usw3a-0006d2-Mm; Mon, 01 Sep 2025 00:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1usvqB-0002lg-ND; Mon, 01 Sep 2025 00:08:23 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1usvq9-000862-Qq; Mon, 01 Sep 2025 00:08:23 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 1 Sep
 2025 12:08:09 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 1 Sep 2025 12:08:09 +0800
To: "reviewer:Incompatible changes" <devel@lists.libvirt.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>
Subject: [PATCH v1 1/4] hw/arm: Remove ast2700a0-evb machine
Date: Mon, 1 Sep 2025 12:08:04 +0800
Message-ID: <20250901040808.1454742-2-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250901040808.1454742-1-jamin_lin@aspeedtech.com>
References: <20250901040808.1454742-1-jamin_lin@aspeedtech.com>
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

The ast2700a0-evb machine represents the first revision of the AST2700 and
serves as the initial engineering sample rather than a production version.
A newer revision, A1, is now supported, and the ast2700a1-evb should replace
the older A0 version.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 docs/about/deprecated.rst                     |  8 ------
 hw/arm/aspeed.c                               | 28 +------------------
 .../functional/aarch64/test_aspeed_ast2700.py | 12 --------
 3 files changed, 1 insertion(+), 47 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 5d1579dcf8..8a273e019a 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -305,14 +305,6 @@ deprecated; use the new name ``dtb-randomness`` instead. The new name
 better reflects the way this property affects all random data within
 the device tree blob, not just the ``kaslr-seed`` node.
 
-Arm ``ast2700a0-evb`` machine (since 10.1)
-''''''''''''''''''''''''''''''''''''''''''
-
-The ``ast2700a0-evb`` machine represents the first revision of the AST2700
-and serves as the initial engineering sample rather than a production version.
-A newer revision, A1, is now supported, and the ``ast2700a1-evb`` should
-replace the older A0 version.
-
 Mips ``mipssim`` machine (since 10.0)
 '''''''''''''''''''''''''''''''''''''
 
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index c31bbe7701..e729edfe13 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -1989,35 +1989,13 @@ static void ast2700_evb_i2c_init(AspeedMachineState *bmc)
                             TYPE_TMP105, 0x4d);
 }
 
-static void aspeed_machine_ast2700a0_evb_class_init(ObjectClass *oc,
-                                                    const void *data)
-{
-    MachineClass *mc = MACHINE_CLASS(oc);
-    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
-
-    mc->alias = "ast2700-evb";
-    mc->desc = "Aspeed AST2700 A0 EVB (Cortex-A35)";
-    amc->soc_name  = "ast2700-a0";
-    amc->hw_strap1 = AST2700_EVB_HW_STRAP1;
-    amc->hw_strap2 = AST2700_EVB_HW_STRAP2;
-    amc->fmc_model = "w25q01jvq";
-    amc->spi_model = "w25q512jv";
-    amc->num_cs    = 2;
-    amc->macs_mask = ASPEED_MAC0_ON | ASPEED_MAC1_ON | ASPEED_MAC2_ON;
-    amc->uart_default = ASPEED_DEV_UART12;
-    amc->i2c_init  = ast2700_evb_i2c_init;
-    amc->vbootrom = true;
-    mc->auto_create_sdcard = true;
-    mc->default_ram_size = 1 * GiB;
-    aspeed_machine_class_init_cpus_defaults(mc);
-}
-
 static void aspeed_machine_ast2700a1_evb_class_init(ObjectClass *oc,
                                                     const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
 
+    mc->alias = "ast2700-evb";
     mc->desc = "Aspeed AST2700 A1 EVB (Cortex-A35)";
     amc->soc_name  = "ast2700-a1";
     amc->hw_strap1 = AST2700_EVB_HW_STRAP1;
@@ -2166,10 +2144,6 @@ static const TypeInfo aspeed_machine_types[] = {
         .class_init     = aspeed_minibmc_machine_ast1030_evb_class_init,
 #ifdef TARGET_AARCH64
     }, {
-        .name          = MACHINE_TYPE_NAME("ast2700a0-evb"),
-        .parent        = TYPE_ASPEED_MACHINE,
-        .class_init    = aspeed_machine_ast2700a0_evb_class_init,
-        }, {
         .name          = MACHINE_TYPE_NAME("ast2700a1-evb"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_ast2700a1_evb_class_init,
diff --git a/tests/functional/aarch64/test_aspeed_ast2700.py b/tests/functional/aarch64/test_aspeed_ast2700.py
index d02dc7991c..063d9e572c 100755
--- a/tests/functional/aarch64/test_aspeed_ast2700.py
+++ b/tests/functional/aarch64/test_aspeed_ast2700.py
@@ -46,10 +46,6 @@ def verify_openbmc_boot_and_login(self, name):
         exec_command_and_wait_for_pattern(self, 'root', 'Password:')
         exec_command_and_wait_for_pattern(self, '0penBmc', f'root@{name}:~#')
 
-    ASSET_SDK_V906_AST2700 = Asset(
-            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.06/ast2700-a0-default-obmc.tar.gz',
-            '7247b6f19dbfb700686f8d9f723ac23f3eb229226c0589cb9b06b80d1b61f3cb')
-
     ASSET_SDK_V906_AST2700A1 = Asset(
             'https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.06/ast2700-default-obmc.tar.gz',
             'f1d53e0be8a404ecce3e105f72bc50fa4e090ad13160ffa91b10a6e0233a9dc6')
@@ -111,14 +107,6 @@ def start_ast2700_test_vbootrom(self, name):
         self.do_test_aarch64_aspeed_sdk_start(
                 self.scratch_file(name, 'image-bmc'))
 
-    def test_aarch64_ast2700_evb_sdk_v09_06(self):
-        self.set_machine('ast2700-evb')
-
-        self.archive_extract(self.ASSET_SDK_V906_AST2700)
-        self.start_ast2700_test('ast2700-a0-default')
-        self.verify_openbmc_boot_and_login('ast2700-a0-default')
-        self.do_ast2700_i2c_test()
-
     def test_aarch64_ast2700a1_evb_sdk_v09_06(self):
         self.set_machine('ast2700a1-evb')
 
-- 
2.43.0


