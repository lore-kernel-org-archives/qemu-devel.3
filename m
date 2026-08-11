Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9865DC5CFCF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:41:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpPZ-0006vT-Lx; Tue, 11 Aug 2026 12:33:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpPY-0006u4-KM
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:33:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpPW-00018R-Ts
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:33:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wku9aFtVPzn10aVW4SZ0dHKlvl30Ogei5mgKGFhOEQQ=;
 b=erztoYDtwibNGw/Kmihm2n3+DC7TxiRwI2LTnRXTrpzTJKNFhh8hbVtE3dvdOMkr7//n8s
 SAyzX6dxz00n0x3RDmQK1xETda+Iva2AUhpbgVCprBBGTExSlzhVZvSiw4XSJCRaNhepwK
 Mccr24SAuxPuQepakgoRwAohxInj/yQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-404-NzKXynYmMqaRlNra3nhE1Q-1; Tue,
 11 Aug 2026 12:31:55 -0400
X-MC-Unique: NzKXynYmMqaRlNra3nhE1Q-1
X-Mimecast-MFC-AGG-ID: NzKXynYmMqaRlNra3nhE1Q_1786465914
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4FD4A1956057; Tue, 11 Aug 2026 16:31:54 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CDE73195DF91; Tue, 11 Aug 2026 16:31:52 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 61/83] tests/functional/aarch64/test_aspeed_ast2700a1: Update
 ASPEED SDK v11.03
Date: Tue, 11 Aug 2026 18:29:16 +0200
Message-ID: <20260811162938.1403216-62-clg@redhat.com>
In-Reply-To: <20260811162938.1403216-1-clg@redhat.com>
References: <20260811162938.1403216-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Link: https://lore.kernel.org/qemu-devel/20260804081955.1563537-4-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 .../aarch64/test_aspeed_ast2700a1.py          | 27 ++++++++++---------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/tests/functional/aarch64/test_aspeed_ast2700a1.py b/tests/functional/aarch64/test_aspeed_ast2700a1.py
index adbbef5cf11e..2113c78db202 100755
--- a/tests/functional/aarch64/test_aspeed_ast2700a1.py
+++ b/tests/functional/aarch64/test_aspeed_ast2700a1.py
@@ -85,13 +85,13 @@ def verify_openbmc_boot_and_login(self, name, enable_pcie=True):
         exec_command_and_wait_for_pattern(self, 'root', 'Password:')
         exec_command_and_wait_for_pattern(self, '0penBmc', f'root@{name}:~#')
 
-    ASSET_SDK_V1101_AST2700A1 = Asset(
-            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.01/ast2700-a1-image.tar.gz',
-            '859808828531a51931aad3b4e70b28143eebb3cde1838ba7d8e7a2b844c8a1ab')
+    ASSET_SDK_V1103_AST2700A1 = Asset(
+            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.03/ast2700-a1-image.tar.gz',
+            '540961dc380709d852e957c5817cd7ee0dbb0a66f3aa17413eac7b67518afbfe')
 
-    ASSET_SDK_V1101_AST2700A1_DCSCM = Asset(
-            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.01/ast2700-a1-dcscm-image.tar.gz',
-            '4654eabad75da3fd33635cd6d29b7635181daefee7294b68feb124b9d4c24116')
+    ASSET_SDK_V1103_AST2700A1_DCSCM = Asset(
+            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.03/ast2700-a1-dcscm-image.tar.gz',
+            '5f7c139330fcefa6025bc7565a20fd5ea42cacebf810d56dc9a76b07cf69b3e1')
 
     def do_ast2700_i2c_test(self, bus_id):
         bus_str = str(bus_id)
@@ -132,7 +132,8 @@ def start_ast2700_test(self, name, bus_id):
             },
             {
                 'addr': '0x430000000',
-                'file': self.scratch_file(name, 'bl31.bin')
+                'file': self.scratch_file(name, 'trusted-firmware-a',
+                                          'bl31.bin')
             },
             {
                 'addr': '0x430080000',
@@ -159,11 +160,11 @@ def start_ast2700_test_vbootrom(self, name, bus_id):
         self.do_test_aarch64_aspeed_sdk_start(
                 self.scratch_file(name, 'image-bmc'), bus_id)
 
-    def test_aarch64_ast2700a1_evb_sdk_v11_01(self):
+    def test_aarch64_ast2700a1_evb_sdk_v11_03(self):
         self.set_machine('ast2700a1-evb')
         self.require_netdev('user')
 
-        self.archive_extract(self.ASSET_SDK_V1101_AST2700A1)
+        self.archive_extract(self.ASSET_SDK_V1103_AST2700A1)
         self.vm.add_args('-device', 'e1000e,netdev=net1,bus=pcie.2')
         self.vm.add_args('-netdev', 'user,id=net1')
         self.vm.add_args('-device', 'usb-kbd,bus=usb-bus.3')
@@ -173,22 +174,22 @@ def test_aarch64_ast2700a1_evb_sdk_v11_01(self):
         self.do_ast2700_pcie_test()
         self.do_ast2700_usb_ehci_test()
 
-    def test_aarch64_ast2700a1_evb_sdk_vbootrom_v11_01(self):
+    def test_aarch64_ast2700a1_evb_sdk_vbootrom_v11_03(self):
         self.set_machine('ast2700a1-evb')
         self.require_netdev('user')
 
-        self.archive_extract(self.ASSET_SDK_V1101_AST2700A1)
+        self.archive_extract(self.ASSET_SDK_V1103_AST2700A1)
         self.vm.add_args('-device', 'e1000e,netdev=net1,bus=pcie.2')
         self.vm.add_args('-netdev', 'user,id=net1')
         self.start_ast2700_test_vbootrom('ast2700-a1-image', 1)
         self.verify_vbootrom_firmware_flow()
         self.verify_openbmc_boot_start()
 
-    def test_aarch64_ast2700a1_evb_ioexp_v11_01(self):
+    def test_aarch64_ast2700a1_evb_ioexp_v11_03(self):
         self.set_machine('ast2700a1-evb')
         self.require_netdev('user')
 
-        self.archive_extract(self.ASSET_SDK_V1101_AST2700A1_DCSCM)
+        self.archive_extract(self.ASSET_SDK_V1103_AST2700A1_DCSCM)
         self.vm.set_machine('ast2700a1-evb,fmc-model=w25q512jv')
         self.vm.add_args('-device',
                          'tmp105,bus=ioexp0.0,address=0x4d,id=tmp-test-16')
-- 
2.55.0


