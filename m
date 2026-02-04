Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 220F3E95377
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 10:33:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnaBe-0001Ln-8r; Wed, 04 Feb 2026 05:32:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnaBS-0000fg-JG
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:32:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnaBP-00043W-Q0
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:32:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770201146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vbeGJUD/FPOPHW2asDqxfTZ8BJkrGhDFAcGbiy6EOg8=;
 b=h4/VDcQl0jLrm82hfkkijb0HyPXLnZ5wggo+0V6nk5lygIw9rHf8NNDtFSngG0fz86wEcS
 xn3DrwvNBQ8d1Bpp4etnLBP39EPKSR2STqS/oJMDJAb/qNw0Wu9Ae6dY+l8tU0FvYLztWR
 JHIluueycGPALiA31xpdyk7TumEcTK0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-597-SPYolAm_M7ueRQagmTmNCA-1; Wed,
 04 Feb 2026 05:32:25 -0500
X-MC-Unique: SPYolAm_M7ueRQagmTmNCA-1
X-Mimecast-MFC-AGG-ID: SPYolAm_M7ueRQagmTmNCA_1770201144
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A02B7195605A; Wed,  4 Feb 2026 10:32:24 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.44])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2E68018004BB; Wed,  4 Feb 2026 10:32:22 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 21/45] tests/functional/aarch64/test_aspeed_ast2700: Update
 test ASPEED SDK v11.00 for A1
Date: Wed,  4 Feb 2026 11:31:12 +0100
Message-ID: <20260204103136.1795455-22-clg@redhat.com>
In-Reply-To: <20260204103136.1795455-1-clg@redhat.com>
References: <20260204103136.1795455-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Jamin Lin <jamin_lin@aspeedtech.com>

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260203020855.1642884-7-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 .../functional/aarch64/test_aspeed_ast2700.py | 60 +++++++++----------
 1 file changed, 29 insertions(+), 31 deletions(-)

diff --git a/tests/functional/aarch64/test_aspeed_ast2700.py b/tests/functional/aarch64/test_aspeed_ast2700.py
index 1f1b5749f4a0..828ea1ca53df 100755
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
2.52.0


