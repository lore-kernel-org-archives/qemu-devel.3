Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9860AC5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:41:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpOX-0004lf-Rh; Tue, 11 Aug 2026 12:32:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpOR-0004TX-3u
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:31:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpOP-0000wB-9b
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:31:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hwyd3J2gBRtLn+ZKRjnjpi6JQjPFecjC+WykmELV2rk=;
 b=cd5unDKbLeLDbkyGKz1LuX/0DyHkQhf/vKrg+WIwHrcBFE76NcQIzej7iXUW/PAgD5xWHR
 wVlG02FNF/ywAMruj4t7bHut/iVCXtn3zp0OJn3aiBFfcNsC5mIpYVWpJOA7bef3zH+D2k
 Rfrc7fgNwQx9LDf5tvymvW1HsCa+EIw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-RE80q7CPNfqqJPyPPkdgCA-1; Tue,
 11 Aug 2026 12:31:53 -0400
X-MC-Unique: RE80q7CPNfqqJPyPPkdgCA-1
X-Mimecast-MFC-AGG-ID: RE80q7CPNfqqJPyPPkdgCA_1786465912
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F6311800C36; Tue, 11 Aug 2026 16:31:52 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E4B49195DF91; Tue, 11 Aug 2026 16:31:50 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 60/83] tests/functional/aarch64/test_aspeed_ast2700a2: Update
 ASPEED SDK v11.03
Date: Tue, 11 Aug 2026 18:29:15 +0200
Message-ID: <20260811162938.1403216-61-clg@redhat.com>
In-Reply-To: <20260811162938.1403216-1-clg@redhat.com>
References: <20260811162938.1403216-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Link: https://lore.kernel.org/qemu-devel/20260804081955.1563537-3-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 .../aarch64/test_aspeed_ast2700a2.py          | 27 ++++++++++---------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/tests/functional/aarch64/test_aspeed_ast2700a2.py b/tests/functional/aarch64/test_aspeed_ast2700a2.py
index 5f9073c89754..01c7c4fdbe35 100755
--- a/tests/functional/aarch64/test_aspeed_ast2700a2.py
+++ b/tests/functional/aarch64/test_aspeed_ast2700a2.py
@@ -85,13 +85,13 @@ def verify_openbmc_boot_and_login(self, name, enable_pcie=True):
         exec_command_and_wait_for_pattern(self, 'root', 'Password:')
         exec_command_and_wait_for_pattern(self, '0penBmc', f'root@{name}:~#')
 
-    ASSET_SDK_V1101_AST2700A2 = Asset(
-            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.01/ast2700-default-image.tar.gz',
-            'ce89dcd995cf284d41a6a4bd17a1b97d59939f0277bfe54fdaaf30e741ce7487')
+    ASSET_SDK_V1103_AST2700A2 = Asset(
+            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.03/ast2700-default-image.tar.gz',
+            'b91450d53da234591060cfb926fa30f7534ce20eaab766cb0f80ec332f8f0adb')
 
-    ASSET_SDK_V1101_AST2700A2_DCSCM = Asset(
-            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.01/ast2700-dcscm-image.tar.gz',
-            'b92ece9ca733dfd7a20193a12582f743b77f1898116b6d6f1abe57ac8db01c56')
+    ASSET_SDK_V1103_AST2700A2_DCSCM = Asset(
+            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.03/ast2700-dcscm-image.tar.gz',
+            '7afd8323fc95097c14872b90d68c5cae5d078530c704591b192b74bd892c1dbf')
 
     def do_ast2700_i2c_test(self, bus_id):
         bus_str = str(bus_id)
@@ -135,7 +135,8 @@ def start_ast2700_test(self, name, bus_id):
             },
             {
                 'addr': '0x430000000',
-                'file': self.scratch_file(name, 'bl31.bin')
+                'file': self.scratch_file(name, 'trusted-firmware-a',
+                                          'bl31.bin')
             },
             {
                 'addr': '0x430080000',
@@ -162,11 +163,11 @@ def start_ast2700_test_vbootrom(self, name, bus_id):
         self.do_test_aarch64_aspeed_sdk_start(
                 self.scratch_file(name, 'image-bmc'), bus_id)
 
-    def test_aarch64_ast2700a2_evb_sdk_v11_01(self):
+    def test_aarch64_ast2700a2_evb_sdk_v11_03(self):
         self.set_machine('ast2700a2-evb')
         self.require_netdev('user')
 
-        self.archive_extract(self.ASSET_SDK_V1101_AST2700A2)
+        self.archive_extract(self.ASSET_SDK_V1103_AST2700A2)
         self.vm.add_args('-device', 'e1000e,netdev=net1,bus=pcie.2')
         self.vm.add_args('-netdev', 'user,id=net1')
         self.vm.add_args('-device', 'usb-kbd,bus=usb-bus.3')
@@ -176,22 +177,22 @@ def test_aarch64_ast2700a2_evb_sdk_v11_01(self):
         self.do_ast2700_pcie_test()
         self.do_ast2700_usb_ehci_test()
 
-    def test_aarch64_ast2700a2_evb_sdk_vbootrom_v11_01(self):
+    def test_aarch64_ast2700a2_evb_sdk_vbootrom_v11_03(self):
         self.set_machine('ast2700a2-evb')
         self.require_netdev('user')
 
-        self.archive_extract(self.ASSET_SDK_V1101_AST2700A2)
+        self.archive_extract(self.ASSET_SDK_V1103_AST2700A2)
         self.vm.add_args('-device', 'e1000e,netdev=net1,bus=pcie.2')
         self.vm.add_args('-netdev', 'user,id=net1')
         self.start_ast2700_test_vbootrom('ast2700-default-image', 1)
         self.verify_vbootrom_firmware_flow()
         self.verify_openbmc_boot_start()
 
-    def test_aarch64_ast2700a2_evb_ioexp_v11_01(self):
+    def test_aarch64_ast2700a2_evb_ioexp_v11_03(self):
         self.set_machine('ast2700a2-evb')
         self.require_netdev('user')
 
-        self.archive_extract(self.ASSET_SDK_V1101_AST2700A2_DCSCM)
+        self.archive_extract(self.ASSET_SDK_V1103_AST2700A2_DCSCM)
         self.vm.set_machine('ast2700a2-evb,fmc-model=w25q512jv')
         self.vm.add_args('-device',
                          'tmp105,bus=ioexp0.0,address=0x4d,id=tmp-test-16')
-- 
2.55.0


