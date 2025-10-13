Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B2DCCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 12:46:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8HvG-0004ad-4p; Mon, 13 Oct 2025 08:45:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v8Hv4-0004TM-Oj
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 08:44:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v8Hut-0007uL-NQ
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 08:44:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760359481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y1n9/TEVgsijBQW/VTwJkBgfQKQp+H/4+6pCunli+Ks=;
 b=GTelR5ruyhbZViWNRNtIwWwmekzH2RgVH/Xp/fLqxGfOZNzO1HSJd0zDXwA6h3NRIyJcz2
 Is9BmK9o+3JkT9mnDx+/6nIEl6mIQH9r2Jxjjk4I3cic7O19Xltued3y69WsnT+6WWzEot
 pE2rDBRWwNEA6DW/hlxwdWuqRONykRA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-ZqlNdHRsOouNqxZHUYz7qA-1; Mon,
 13 Oct 2025 08:44:37 -0400
X-MC-Unique: ZqlNdHRsOouNqxZHUYz7qA-1
X-Mimecast-MFC-AGG-ID: ZqlNdHRsOouNqxZHUYz7qA_1760359476
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F278195608E; Mon, 13 Oct 2025 12:44:36 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.225.105])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E036C1800446; Mon, 13 Oct 2025 12:44:34 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 06/29] tests/functional/aarch64/test_aspeed_ast2700: Update
 test ASPEED SDK v09.08 for A1
Date: Mon, 13 Oct 2025 14:43:57 +0200
Message-ID: <20251013124421.71977-7-clg@redhat.com>
In-Reply-To: <20251013124421.71977-1-clg@redhat.com>
References: <20251013124421.71977-1-clg@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Jamin Lin <jamin_lin@aspeedtech.com>

Support for AST2700 A0 was dropped starting from SDK v09.07.
The new SDK v09.08 only updates support for AST2700 A1.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20251003072107.3530642-5-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 .../functional/aarch64/test_aspeed_ast2700.py  | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/tests/functional/aarch64/test_aspeed_ast2700.py b/tests/functional/aarch64/test_aspeed_ast2700.py
index 0973fce0e995..0e9f10d991ea 100755
--- a/tests/functional/aarch64/test_aspeed_ast2700.py
+++ b/tests/functional/aarch64/test_aspeed_ast2700.py
@@ -50,13 +50,9 @@ def verify_openbmc_boot_and_login(self, name):
             'https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.06/ast2700-a0-default-obmc.tar.gz',
             '7247b6f19dbfb700686f8d9f723ac23f3eb229226c0589cb9b06b80d1b61f3cb')
 
-    ASSET_SDK_V906_AST2700A1 = Asset(
-            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.06/ast2700-default-obmc.tar.gz',
-            'f1d53e0be8a404ecce3e105f72bc50fa4e090ad13160ffa91b10a6e0233a9dc6')
-
-    ASSET_SDK_V907_AST2700A1_VBOOROM = Asset(
-            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.07/ast2700-default-obmc.tar.gz',
-            '6e9e0c4b13e0f26040eca3f4a7f17cf09fc0f5c37c820500ff79370cc3c44add')
+    ASSET_SDK_V908_AST2700A1 = Asset(
+            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.08/ast2700-default-obmc.tar.gz',
+            'eac3dc409b7ea3cd4b03d4792d3cebd469792ad893cb51e1d15f0fc20bd1e2cd')
 
     def do_ast2700_i2c_test(self):
         exec_command_and_wait_for_pattern(self,
@@ -133,11 +129,11 @@ def test_aarch64_ast2700a0_evb_sdk_v09_06(self):
         self.verify_openbmc_boot_and_login('ast2700-a0-default')
         self.do_ast2700_i2c_test()
 
-    def test_aarch64_ast2700a1_evb_sdk_v09_06(self):
+    def test_aarch64_ast2700a1_evb_sdk_v09_08(self):
         self.set_machine('ast2700a1-evb')
         self.require_netdev('user')
 
-        self.archive_extract(self.ASSET_SDK_V906_AST2700A1)
+        self.archive_extract(self.ASSET_SDK_V908_AST2700A1)
         self.vm.add_args('-device', 'e1000e,netdev=net1,bus=pcie.2')
         self.vm.add_args('-netdev', 'user,id=net1')
         self.start_ast2700_test('ast2700-default')
@@ -145,11 +141,11 @@ def test_aarch64_ast2700a1_evb_sdk_v09_06(self):
         self.do_ast2700_i2c_test()
         self.do_ast2700_pcie_test()
 
-    def test_aarch64_ast2700a1_evb_sdk_vbootrom_v09_07(self):
+    def test_aarch64_ast2700a1_evb_sdk_vbootrom_v09_08(self):
         self.set_machine('ast2700a1-evb')
         self.require_netdev('user')
 
-        self.archive_extract(self.ASSET_SDK_V907_AST2700A1_VBOOROM)
+        self.archive_extract(self.ASSET_SDK_V908_AST2700A1)
         self.vm.add_args('-device', 'e1000e,netdev=net1,bus=pcie.2')
         self.vm.add_args('-netdev', 'user,id=net1')
         self.start_ast2700_test_vbootrom('ast2700-default')
-- 
2.51.0


