Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE848F47CA6
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 18:02:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyD0P-0005Oh-1s; Thu, 05 Mar 2026 13:01:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vyCyP-0001tW-Vr
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:59:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vyCyO-0003xB-4d
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:58:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772733535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i10retBrKrqgEaDwENbXT41GXQeYfp1WHmU6uiaBIC0=;
 b=A1gyI5gSUcdkbDiwfeuILrcjMNMYK4VKb4XAjVFavYXkzVB99Z4MstOxL0m/g0XyM5BHA5
 ZCPWrkSWxE+rjswN5Z0oqQ+8ujTgGWKnKXu6UGkXqJ7wSGagTQm73Fbo/ZMo0cBsXcjmaH
 Lo8gmdo3vf9nbc/ymllDfkTteNkJSXo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-31--Osc91gbPWCOIXN-MyZh9w-1; Thu,
 05 Mar 2026 12:58:52 -0500
X-MC-Unique: -Osc91gbPWCOIXN-MyZh9w-1
X-Mimecast-MFC-AGG-ID: -Osc91gbPWCOIXN-MyZh9w_1772733531
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 776C518002DC; Thu,  5 Mar 2026 17:58:51 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C1DE03003E9E; Thu,  5 Mar 2026 17:58:49 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 38/38] tests/functional/aarch64/test_aspeed_ast2700fc: Update
 test ASPEED OpenBMC SDK v11.01
Date: Thu,  5 Mar 2026 18:57:11 +0100
Message-ID: <20260305175711.1119025-39-clg@redhat.com>
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
Link: https://lore.kernel.org/qemu-devel/20260303063930.2878300-11-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 .../aarch64/test_aspeed_ast2700fc.py           | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tests/functional/aarch64/test_aspeed_ast2700fc.py b/tests/functional/aarch64/test_aspeed_ast2700fc.py
index 51ee8bc78791..f68f40a1bfaf 100755
--- a/tests/functional/aarch64/test_aspeed_ast2700fc.py
+++ b/tests/functional/aarch64/test_aspeed_ast2700fc.py
@@ -61,9 +61,9 @@ def load_ast2700fc_coprocessor(self, name):
             self.vm.add_args('-device',
                              f'loader,file={file},cpu-num={cpu_num}')
 
-    ASSET_SDK_V1100_AST2700 = Asset(
-            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.00/ast2700-default-obmc.tar.gz',
-            'e2b8f043fe8063dd3b6ded93422e38bd41914dc9c3202199507652df024de4dc')
+    ASSET_SDK_V1101_AST2700 = Asset(
+            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.01/ast2700-default-image.tar.gz',
+            'ce89dcd995cf284d41a6a4bd17a1b97d59939f0277bfe54fdaaf30e741ce7487')
 
     def do_ast2700_i2c_test(self):
         exec_command_and_wait_for_pattern(self,
@@ -148,23 +148,23 @@ def start_ast2700fc_test_vbootrom(self, name):
         self.do_test_aarch64_aspeed_sdk_start(
                 self.scratch_file(name, 'image-bmc'))
 
-    def test_aarch64_ast2700fc_sdk_v11_00(self):
+    def test_aarch64_ast2700fc_sdk_v11_01(self):
         self.set_machine('ast2700fc')
         self.require_netdev('user')
 
-        self.archive_extract(self.ASSET_SDK_V1100_AST2700)
-        self.start_ast2700fc_test('ast2700-default')
+        self.archive_extract(self.ASSET_SDK_V1101_AST2700)
+        self.start_ast2700fc_test('ast2700-default-image')
         self.verify_openbmc_boot_and_login('ast2700-default')
         self.do_ast2700_i2c_test()
         self.do_ast2700_pcie_test()
         self.do_ast2700fc_ssp_test()
         self.do_ast2700fc_tsp_test()
 
-    def test_aarch64_ast2700fc_sdk_vbootrom_v11_00(self):
+    def test_aarch64_ast2700fc_sdk_vbootrom_v11_01(self):
         self.set_machine('ast2700fc')
 
-        self.archive_extract(self.ASSET_SDK_V1100_AST2700)
-        self.start_ast2700fc_test_vbootrom('ast2700-default')
+        self.archive_extract(self.ASSET_SDK_V1101_AST2700)
+        self.start_ast2700fc_test_vbootrom('ast2700-default-image')
         self.verify_openbmc_boot_and_login('ast2700-default')
         self.do_ast2700fc_ssp_test()
         self.do_ast2700fc_tsp_test()
-- 
2.53.0


