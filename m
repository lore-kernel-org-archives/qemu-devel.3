Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94435E95375
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 10:35:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnaBf-0001Tv-Hw; Wed, 04 Feb 2026 05:32:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnaBY-0000ux-7Z
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:32:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnaBW-00045H-J7
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:32:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770201153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=APl5obzIM65XG4dJG4xhzOqCAx+fYtuuzxyfsimqC9c=;
 b=MrMY/LG9MW9k4+fJGSoDbD9zzDUbM5TW1p0Y1Pdnda+TWyuOWtkCAFmaIsilGW0VMIuA6E
 oXPXmDdyMa2Cvb5oBEBA+Iur2By7SGU5p+XTEPLDUUEBd+LX1bx69rxbnOOlGSkgncbf0g
 Blk7nGytA4HrpRn/egaDYiTCj3TJUBM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-248-GkyOuYA7P5aBpqYqaWYknQ-1; Wed,
 04 Feb 2026 05:32:27 -0500
X-MC-Unique: GkyOuYA7P5aBpqYqaWYknQ-1
X-Mimecast-MFC-AGG-ID: GkyOuYA7P5aBpqYqaWYknQ_1770201146
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8FDEE195606B; Wed,  4 Feb 2026 10:32:26 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.44])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1D7C318004AD; Wed,  4 Feb 2026 10:32:24 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 22/45] tests/functional/aarch64/test_aspeed_ast2700fc: Update
 test ASPEED SDK v11.00 for A1
Date: Wed,  4 Feb 2026 11:31:13 +0100
Message-ID: <20260204103136.1795455-23-clg@redhat.com>
In-Reply-To: <20260204103136.1795455-1-clg@redhat.com>
References: <20260204103136.1795455-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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
Link: https://lore.kernel.org/qemu-devel/20260203020855.1642884-8-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 .../aarch64/test_aspeed_ast2700fc.py          | 36 +++++++------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/tests/functional/aarch64/test_aspeed_ast2700fc.py b/tests/functional/aarch64/test_aspeed_ast2700fc.py
index a1d8046f58e6..47e56dcfc50c 100755
--- a/tests/functional/aarch64/test_aspeed_ast2700fc.py
+++ b/tests/functional/aarch64/test_aspeed_ast2700fc.py
@@ -61,9 +61,9 @@ def load_ast2700fc_coprocessor(self, name):
             self.vm.add_args('-device',
                              f'loader,file={file},cpu-num={cpu_num}')
 
-    ASSET_SDK_V908_AST2700 = Asset(
-            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.08/ast2700-default-obmc.tar.gz',
-            'eac3dc409b7ea3cd4b03d4792d3cebd469792ad893cb51e1d15f0fc20bd1e2cd')
+    ASSET_SDK_V1100_AST2700 = Asset(
+            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.00/ast2700-a1-obmc.tar.gz',
+            'd5ceed511cd0dfefbb102fff2d731159e0472948a28066dc0d90bcd54be76525')
 
     def do_ast2700_i2c_test(self):
         exec_command_and_wait_for_pattern(self,
@@ -113,19 +113,10 @@ def do_ast2700fc_tsp_test(self):
 
     def start_ast2700fc_test(self, name):
         ca35_core = 4
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
@@ -133,8 +124,7 @@ def start_ast2700fc_test(self, name):
             },
             {
                 'addr': '0x430080000',
-                'file': self.scratch_file(name, 'optee',
-                                          'tee-raw.bin')
+                'file': self.scratch_file(name, 'optee', 'tee-raw.bin')
             }
         ]
 
@@ -158,24 +148,24 @@ def start_ast2700fc_test_vbootrom(self, name):
         self.do_test_aarch64_aspeed_sdk_start(
                 self.scratch_file(name, 'image-bmc'))
 
-    def test_aarch64_ast2700fc_sdk_v09_08(self):
+    def test_aarch64_ast2700fc_sdk_v11_00(self):
         self.set_machine('ast2700fc')
         self.require_netdev('user')
 
-        self.archive_extract(self.ASSET_SDK_V908_AST2700)
-        self.start_ast2700fc_test('ast2700-default')
-        self.verify_openbmc_boot_and_login('ast2700-default')
+        self.archive_extract(self.ASSET_SDK_V1100_AST2700)
+        self.start_ast2700fc_test('ast2700-a1')
+        self.verify_openbmc_boot_and_login('ast2700-a1')
         self.do_ast2700_i2c_test()
         self.do_ast2700_pcie_test()
         self.do_ast2700fc_ssp_test()
         self.do_ast2700fc_tsp_test()
 
-    def test_aarch64_ast2700fc_sdk_vbootrom_v09_08(self):
+    def test_aarch64_ast2700fc_sdk_vbootrom_v11_00(self):
         self.set_machine('ast2700fc')
 
-        self.archive_extract(self.ASSET_SDK_V908_AST2700)
-        self.start_ast2700fc_test_vbootrom('ast2700-default')
-        self.verify_openbmc_boot_and_login('ast2700-default')
+        self.archive_extract(self.ASSET_SDK_V1100_AST2700)
+        self.start_ast2700fc_test_vbootrom('ast2700-a1')
+        self.verify_openbmc_boot_and_login('ast2700-a1')
         self.do_ast2700fc_ssp_test()
         self.do_ast2700fc_tsp_test()
 
-- 
2.52.0


