Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C585E73165
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 02:10:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn5r1-0002Yc-Cv; Mon, 02 Feb 2026 21:09:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vn5r0-0002YO-Bk; Mon, 02 Feb 2026 21:09:22 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vn5qy-0006uM-Kl; Mon, 02 Feb 2026 21:09:22 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 3 Feb
 2026 10:08:57 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 3 Feb 2026 10:08:57 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC
 here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>
Subject: [PATCH v2 6/8] tests/functional/aarch64/test_aspeed_ast2700: Update
 test ASPEED SDK v11.00 for A1
Date: Tue, 3 Feb 2026 10:08:51 +0800
Message-ID: <20260203020855.1642884-7-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260203020855.1642884-1-jamin_lin@aspeedtech.com>
References: <20260203020855.1642884-1-jamin_lin@aspeedtech.com>
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
 .../functional/aarch64/test_aspeed_ast2700.py | 60 +++++++++----------
 1 file changed, 29 insertions(+), 31 deletions(-)

diff --git a/tests/functional/aarch64/test_aspeed_ast2700.py b/tests/functional/aarch64/test_aspeed_ast2700.py
index 1f1b5749f4..828ea1ca53 100755
--- a/tests/functional/aarch64/test_aspeed_ast2700.py
+++ b/tests/functional/aarch64/test_aspeed_ast2700.py
@@ -26,15 +26,23 @@ def do_test_aarch64_aspeed_sdk_start(self, image):
         self.vm.launch()
 
     def verify_vbootrom_firmware_flow(self):
-        wait_for_console_pattern(self, 'Found valid FIT image')
-        wait_for_console_pattern(self, '[uboot] loading')
-        wait_for_console_pattern(self, 'done')
-        wait_for_console_pattern(self, '[fdt] loading')
-        wait_for_console_pattern(self, 'done')
-        wait_for_console_pattern(self, '[tee] loading')
-        wait_for_console_pattern(self, 'done')
-        wait_for_console_pattern(self, '[atf] loading')
-        wait_for_console_pattern(self, 'done')
+        wait_for_console_pattern(self, 'Found valid caliptra flash image')
+        wait_for_console_pattern(self, 'Check flash image checksum')
+        wait_for_console_pattern(self, 'pass')
+        wait_for_console_pattern(self, 'Read abb header')
+        wait_for_console_pattern(self, 'pass')
+        wait_for_console_pattern(self, 'Read soc manifest')
+        wait_for_console_pattern(self, 'pass')
+        wait_for_console_pattern(self, 'Load atf image')
+        wait_for_console_pattern(self, 'pass')
+        wait_for_console_pattern(self, 'Load optee image')
+        wait_for_console_pattern(self, 'pass')
+        wait_for_console_pattern(self, 'Load uboot image')
+        wait_for_console_pattern(self, 'pass')
+        wait_for_console_pattern(self, 'Load ssp image')
+        wait_for_console_pattern(self, 'pass')
+        wait_for_console_pattern(self, 'Load tsp image')
+        wait_for_console_pattern(self, 'pass')
         wait_for_console_pattern(self, 'Jumping to BL31 (Trusted Firmware-A)')
 
     def enable_ast2700_pcie2(self):
@@ -63,9 +71,9 @@ def verify_openbmc_boot_and_login(self, name):
         exec_command_and_wait_for_pattern(self, 'root', 'Password:')
         exec_command_and_wait_for_pattern(self, '0penBmc', f'root@{name}:~#')
 
-    ASSET_SDK_V908_AST2700A1 = Asset(
-            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.08/ast2700-default-obmc.tar.gz',
-            'eac3dc409b7ea3cd4b03d4792d3cebd469792ad893cb51e1d15f0fc20bd1e2cd')
+    ASSET_SDK_V1100_AST2700A1 = Asset(
+            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.00/ast2700-a1-obmc.tar.gz',
+            'd5ceed511cd0dfefbb102fff2d731159e0472948a28066dc0d90bcd54be76525')
 
     def do_ast2700_i2c_test(self):
         exec_command_and_wait_for_pattern(self,
@@ -93,19 +101,10 @@ def do_ast2700_pcie_test(self):
 
     def start_ast2700_test(self, name):
         num_cpu = 4
-        uboot_size = os.path.getsize(self.scratch_file(name,
-                                                       'u-boot-nodtb.bin'))
-        uboot_dtb_load_addr = hex(0x400000000 + uboot_size)
-
         load_images_list = [
             {
                 'addr': '0x400000000',
-                'file': self.scratch_file(name,
-                                          'u-boot-nodtb.bin')
-            },
-            {
-                'addr': str(uboot_dtb_load_addr),
-                'file': self.scratch_file(name, 'u-boot.dtb')
+                'file': self.scratch_file(name, 'u-boot.bin')
             },
             {
                 'addr': '0x430000000',
@@ -113,8 +112,7 @@ def start_ast2700_test(self, name):
             },
             {
                 'addr': '0x430080000',
-                'file': self.scratch_file(name, 'optee',
-                                          'tee-raw.bin')
+                'file': self.scratch_file(name, 'optee', 'tee-raw.bin')
             }
         ]
 
@@ -137,26 +135,26 @@ def start_ast2700_test_vbootrom(self, name):
         self.do_test_aarch64_aspeed_sdk_start(
                 self.scratch_file(name, 'image-bmc'))
 
-    def test_aarch64_ast2700a1_evb_sdk_v09_08(self):
+    def test_aarch64_ast2700a1_evb_sdk_v11_00(self):
         self.set_machine('ast2700a1-evb')
         self.require_netdev('user')
 
-        self.archive_extract(self.ASSET_SDK_V908_AST2700A1)
+        self.archive_extract(self.ASSET_SDK_V1100_AST2700A1)
         self.vm.add_args('-device', 'e1000e,netdev=net1,bus=pcie.2')
         self.vm.add_args('-netdev', 'user,id=net1')
-        self.start_ast2700_test('ast2700-default')
-        self.verify_openbmc_boot_and_login('ast2700-default')
+        self.start_ast2700_test('ast2700-a1')
+        self.verify_openbmc_boot_and_login('ast2700-a1')
         self.do_ast2700_i2c_test()
         self.do_ast2700_pcie_test()
 
-    def test_aarch64_ast2700a1_evb_sdk_vbootrom_v09_08(self):
+    def test_aarch64_ast2700a1_evb_sdk_vbootrom_v11_00(self):
         self.set_machine('ast2700a1-evb')
         self.require_netdev('user')
 
-        self.archive_extract(self.ASSET_SDK_V908_AST2700A1)
+        self.archive_extract(self.ASSET_SDK_V1100_AST2700A1)
         self.vm.add_args('-device', 'e1000e,netdev=net1,bus=pcie.2')
         self.vm.add_args('-netdev', 'user,id=net1')
-        self.start_ast2700_test_vbootrom('ast2700-default')
+        self.start_ast2700_test_vbootrom('ast2700-a1')
         self.verify_vbootrom_firmware_flow()
         self.verify_openbmc_boot_start()
 
-- 
2.43.0


