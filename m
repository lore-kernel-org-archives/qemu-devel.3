Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCBBEC5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:38:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpOZ-0004uU-MV; Tue, 11 Aug 2026 12:32:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpOW-0004cx-CH
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:32:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpOT-0000ws-Q3
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:32:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q+J/qy7+bht/kyPAbZlkpp6BbLg4+QeWWJukYRsz8Ks=;
 b=a4azVqr3qRZ9VjqVGuqaDQS+R5S9TB6z3Pof5GLel/Hfu/vQTuSWdO6OLMS0L3aaBAfbsv
 rAXeofTbUsgPVm6RRiIM+urgfqjEHIMDkj5QMVSW5W4Yu7t3AWJEOpP8Kf5Efx0kX2uTZ7
 fZL9SejJz4XppdWPFPhqDErPrD7Gvx4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-155-_7U6NrlaPI2O1zNjQ5PjWg-1; Tue,
 11 Aug 2026 12:31:57 -0400
X-MC-Unique: _7U6NrlaPI2O1zNjQ5PjWg-1
X-Mimecast-MFC-AGG-ID: _7U6NrlaPI2O1zNjQ5PjWg_1786465916
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 39B751955F5A; Tue, 11 Aug 2026 16:31:56 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BF43B195DF96; Tue, 11 Aug 2026 16:31:54 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 62/83] tests/functional/aarch64/test_aspeed_ast2700fc: Update
 ASPEED SDK v11.03
Date: Tue, 11 Aug 2026 18:29:17 +0200
Message-ID: <20260811162938.1403216-63-clg@redhat.com>
In-Reply-To: <20260811162938.1403216-1-clg@redhat.com>
References: <20260811162938.1403216-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Link: https://lore.kernel.org/qemu-devel/20260804081955.1563537-5-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 .../aarch64/test_aspeed_ast2700fc.py          | 21 ++++++++++---------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/tests/functional/aarch64/test_aspeed_ast2700fc.py b/tests/functional/aarch64/test_aspeed_ast2700fc.py
index 86270e6111f3..704477d7c583 100755
--- a/tests/functional/aarch64/test_aspeed_ast2700fc.py
+++ b/tests/functional/aarch64/test_aspeed_ast2700fc.py
@@ -66,9 +66,9 @@ def load_ast2700fc_coprocessor(self, name):
             self.vm.add_args('-device',
                              f'loader,file={file},cpu-num={cpu_num}')
 
-    ASSET_SDK_V1101_AST2700 = Asset(
-            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.01/ast2700-default-image.tar.gz',
-            'ce89dcd995cf284d41a6a4bd17a1b97d59939f0277bfe54fdaaf30e741ce7487')
+    ASSET_SDK_V1103_AST2700 = Asset(
+            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.03/ast2700-default-image.tar.gz',
+            'b91450d53da234591060cfb926fa30f7534ce20eaab766cb0f80ec332f8f0adb')
 
     def do_ast2700_i2c_test(self):
         exec_command_and_wait_for_pattern(self,
@@ -101,7 +101,7 @@ def do_ast2700fc_ssp_test(self):
 
         exec_command_and_wait_for_pattern(self, '\012', 'ssp_tsp:~$')
         exec_command_and_wait_for_pattern(self, 'version',
-                                          'Zephyr version 3.7.1')
+                                          'Zephyr version 3.7.2')
         exec_command_and_wait_for_pattern(self, 'md 72c02000 1',
                                           '[72c02000] 06020103')
 
@@ -112,7 +112,7 @@ def do_ast2700fc_tsp_test(self):
 
         exec_command_and_wait_for_pattern(self, '\012', 'tsp:~$')
         exec_command_and_wait_for_pattern(self, 'version',
-                                          'Zephyr version 3.7.1')
+                                          'Zephyr version 3.7.2')
         exec_command_and_wait_for_pattern(self, 'md 72c02000 1',
                                           '[72c02000] 06020103')
 
@@ -125,7 +125,8 @@ def start_ast2700fc_test(self, name):
             },
             {
                 'addr': '0x430000000',
-                'file': self.scratch_file(name, 'bl31.bin')
+                'file': self.scratch_file(name, 'trusted-firmware-a',
+                                          'bl31.bin')
             },
             {
                 'addr': '0x430080000',
@@ -153,11 +154,11 @@ def start_ast2700fc_test_vbootrom(self, name):
         self.do_test_aarch64_aspeed_sdk_start(
                 self.scratch_file(name, 'image-bmc'))
 
-    def test_aarch64_ast2700fc_sdk_v11_01(self):
+    def test_aarch64_ast2700fc_sdk_v11_03(self):
         self.set_machine('ast2700fc')
         self.require_netdev('user')
 
-        self.archive_extract(self.ASSET_SDK_V1101_AST2700)
+        self.archive_extract(self.ASSET_SDK_V1103_AST2700)
         self.start_ast2700fc_test('ast2700-default-image')
         self.verify_openbmc_boot_and_login('ast2700-default')
         self.do_ast2700_i2c_test()
@@ -165,10 +166,10 @@ def test_aarch64_ast2700fc_sdk_v11_01(self):
         self.do_ast2700fc_ssp_test()
         self.do_ast2700fc_tsp_test()
 
-    def test_aarch64_ast2700fc_sdk_vbootrom_v11_01(self):
+    def test_aarch64_ast2700fc_sdk_vbootrom_v11_03(self):
         self.set_machine('ast2700fc')
 
-        self.archive_extract(self.ASSET_SDK_V1101_AST2700)
+        self.archive_extract(self.ASSET_SDK_V1103_AST2700)
         self.start_ast2700fc_test_vbootrom('ast2700-default-image')
         self.verify_openbmc_boot_and_login('ast2700-default')
         self.do_ast2700fc_ssp_test()
-- 
2.55.0


