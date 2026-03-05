Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 898B4F47CA2
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 18:01:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyCz5-0003l7-DH; Thu, 05 Mar 2026 12:59:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vyCyM-0001mT-50
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:58:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vyCyK-0003wK-HC
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:58:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772733531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j5VXgKFAEC72l5zG8x07hxH/DFHgikbZY2WmqNRno08=;
 b=KUjV2laY8OSTto4wFEyBgk/5rENGG0wOHt3ZAqm6fd1wLO7nDwZogIzuH2uoE3wltKpNjN
 WB8r3EpyCIq5Vkv6ErjrlkhGQ8MKsBnv+F0UJ3OvQ56P/wSGzOVtsx/raSjUE/pckHlLJY
 WVCbLIIWeCyLCV6Tr6WpGpRrz/2f5fw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-263-uOyWCEDMNbuMq7JmoWwiOg-1; Thu,
 05 Mar 2026 12:58:48 -0500
X-MC-Unique: uOyWCEDMNbuMq7JmoWwiOg-1
X-Mimecast-MFC-AGG-ID: uOyWCEDMNbuMq7JmoWwiOg_1772733527
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2062319560AE; Thu,  5 Mar 2026 17:58:47 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8B4463003E9E; Thu,  5 Mar 2026 17:58:45 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 36/38] tests/functional/aarch64/test_aspeed_ast2700a1: Update
 test ASPEED OpenBMC SDK v11.01
Date: Thu,  5 Mar 2026 18:57:09 +0100
Message-ID: <20260305175711.1119025-37-clg@redhat.com>
In-Reply-To: <20260305175711.1119025-1-clg@redhat.com>
References: <20260305175711.1119025-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001 autolearn=no autolearn_force=no
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
Tested-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260303063930.2878300-9-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 .../aarch64/test_aspeed_ast2700a1.py          | 30 +++++++++----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/tests/functional/aarch64/test_aspeed_ast2700a1.py b/tests/functional/aarch64/test_aspeed_ast2700a1.py
index 61373ffe5bd4..5c0c4b0ed50f 100755
--- a/tests/functional/aarch64/test_aspeed_ast2700a1.py
+++ b/tests/functional/aarch64/test_aspeed_ast2700a1.py
@@ -78,13 +78,13 @@ def verify_openbmc_boot_and_login(self, name, enable_pcie=True):
         exec_command_and_wait_for_pattern(self, 'root', 'Password:')
         exec_command_and_wait_for_pattern(self, '0penBmc', f'root@{name}:~#')
 
-    ASSET_SDK_V1100_AST2700A1 = Asset(
-            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.00/ast2700-a1-obmc.tar.gz',
-            'd5ceed511cd0dfefbb102fff2d731159e0472948a28066dc0d90bcd54be76525')
+    ASSET_SDK_V1101_AST2700A1 = Asset(
+            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.01/ast2700-a1-image.tar.gz',
+            '859808828531a51931aad3b4e70b28143eebb3cde1838ba7d8e7a2b844c8a1ab')
 
-    ASSET_SDK_V1100_AST2700A1_DCSCM = Asset(
-            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.00/ast2700-a1-dcscm-obmc.tar.gz',
-            '4f8778be176ece1b57d33c4aee13bb989be114c3e4703150eaeb6f996bd5587f')
+    ASSET_SDK_V1101_AST2700A1_DCSCM = Asset(
+            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.01/ast2700-a1-dcscm-image.tar.gz',
+            '4654eabad75da3fd33635cd6d29b7635181daefee7294b68feb124b9d4c24116')
 
     def do_ast2700_i2c_test(self, bus_id):
         bus_str = str(bus_id)
@@ -147,38 +147,38 @@ def start_ast2700_test_vbootrom(self, name, bus_id):
         self.do_test_aarch64_aspeed_sdk_start(
                 self.scratch_file(name, 'image-bmc'), bus_id)
 
-    def test_aarch64_ast2700a1_evb_sdk_v11_00(self):
+    def test_aarch64_ast2700a1_evb_sdk_v11_01(self):
         self.set_machine('ast2700a1-evb')
         self.require_netdev('user')
 
-        self.archive_extract(self.ASSET_SDK_V1100_AST2700A1)
+        self.archive_extract(self.ASSET_SDK_V1101_AST2700A1)
         self.vm.add_args('-device', 'e1000e,netdev=net1,bus=pcie.2')
         self.vm.add_args('-netdev', 'user,id=net1')
-        self.start_ast2700_test('ast2700-a1', 1)
+        self.start_ast2700_test('ast2700-a1-image', 1)
         self.verify_openbmc_boot_and_login('ast2700-a1')
         self.do_ast2700_i2c_test(1)
         self.do_ast2700_pcie_test()
 
-    def test_aarch64_ast2700a1_evb_sdk_vbootrom_v11_00(self):
+    def test_aarch64_ast2700a1_evb_sdk_vbootrom_v11_01(self):
         self.set_machine('ast2700a1-evb')
         self.require_netdev('user')
 
-        self.archive_extract(self.ASSET_SDK_V1100_AST2700A1)
+        self.archive_extract(self.ASSET_SDK_V1101_AST2700A1)
         self.vm.add_args('-device', 'e1000e,netdev=net1,bus=pcie.2')
         self.vm.add_args('-netdev', 'user,id=net1')
-        self.start_ast2700_test_vbootrom('ast2700-a1', 1)
+        self.start_ast2700_test_vbootrom('ast2700-a1-image', 1)
         self.verify_vbootrom_firmware_flow()
         self.verify_openbmc_boot_start()
 
-    def test_aarch64_ast2700a1_evb_ioexp_v11_00(self):
+    def test_aarch64_ast2700a1_evb_ioexp_v11_01(self):
         self.set_machine('ast2700a1-evb')
         self.require_netdev('user')
 
-        self.archive_extract(self.ASSET_SDK_V1100_AST2700A1_DCSCM)
+        self.archive_extract(self.ASSET_SDK_V1101_AST2700A1_DCSCM)
         self.vm.set_machine('ast2700a1-evb,fmc-model=w25q512jv')
         self.vm.add_args('-device',
                          'tmp105,bus=ioexp0.0,address=0x4d,id=tmp-test-16')
-        self.start_ast2700_test('ast2700-a1-dcscm', 8)
+        self.start_ast2700_test('ast2700-a1-dcscm-image', 8)
         self.verify_openbmc_boot_and_login('ast2700-a1-dcscm', False)
         self.do_ast2700_i2c_test(8)
         self.do_ast2700_i2c_test(16)
-- 
2.53.0


