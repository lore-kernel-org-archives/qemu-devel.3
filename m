Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73BBCEEA85A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 21:42:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqeQU-0008OY-7G; Thu, 12 Feb 2026 16:40:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vqeQS-0008Nj-Jy
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 16:40:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vqeQR-0006DQ-1O
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 16:40:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770932438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=idsrYY9pfBEEfLRU3KKnXin+EUmFekGrhDRA4Yvu7FE=;
 b=bWzelrWCRZZ0cIdKCr9nR7d1j+ZDXz+XhfIvkqwWBH5HQR0D5qv3tkZazacihDyX4BgviL
 sk57OK+n+8BA3mx9Sa+h/5CsnZb4nj7arGw00IXp57ZWhZWa2tz2Mf/ABktP88VrOKcBqO
 ng/X2H4Q1Dld20W2PfdnzxNSIBn3g5s=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-192-zZdFUBdBNH2hjEr_xCTNpQ-1; Thu,
 12 Feb 2026 16:40:35 -0500
X-MC-Unique: zZdFUBdBNH2hjEr_xCTNpQ-1
X-Mimecast-MFC-AGG-ID: zZdFUBdBNH2hjEr_xCTNpQ_1770932434
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E34521956046; Thu, 12 Feb 2026 21:40:33 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.55])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 039AD180035A; Thu, 12 Feb 2026 21:40:31 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 16/16] tests/functional/aarch64/test_aspeed_ast2700fc: Use
 AST2700 A2 SDK image for FC tests
Date: Thu, 12 Feb 2026 22:39:55 +0100
Message-ID: <20260212213955.2225662-17-clg@redhat.com>
In-Reply-To: <20260212213955.2225662-1-clg@redhat.com>
References: <20260212213955.2225662-1-clg@redhat.com>
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

Update AST2700 FC functional tests to use the AST2700 A2 SDK v11.00 image.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260211021527.119674-12-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 .../functional/aarch64/test_aspeed_ast2700fc.py  | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tests/functional/aarch64/test_aspeed_ast2700fc.py b/tests/functional/aarch64/test_aspeed_ast2700fc.py
index 47e56dcfc50c..51ee8bc78791 100755
--- a/tests/functional/aarch64/test_aspeed_ast2700fc.py
+++ b/tests/functional/aarch64/test_aspeed_ast2700fc.py
@@ -62,8 +62,8 @@ def load_ast2700fc_coprocessor(self, name):
                              f'loader,file={file},cpu-num={cpu_num}')
 
     ASSET_SDK_V1100_AST2700 = Asset(
-            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.00/ast2700-a1-obmc.tar.gz',
-            'd5ceed511cd0dfefbb102fff2d731159e0472948a28066dc0d90bcd54be76525')
+            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.00/ast2700-default-obmc.tar.gz',
+            'e2b8f043fe8063dd3b6ded93422e38bd41914dc9c3202199507652df024de4dc')
 
     def do_ast2700_i2c_test(self):
         exec_command_and_wait_for_pattern(self,
@@ -98,7 +98,7 @@ def do_ast2700fc_ssp_test(self):
         exec_command_and_wait_for_pattern(self, 'version',
                                           'Zephyr version 3.7.1')
         exec_command_and_wait_for_pattern(self, 'md 72c02000 1',
-                                          '[72c02000] 06010103')
+                                          '[72c02000] 06020103')
 
     def do_ast2700fc_tsp_test(self):
         self.vm.shutdown()
@@ -109,7 +109,7 @@ def do_ast2700fc_tsp_test(self):
         exec_command_and_wait_for_pattern(self, 'version',
                                           'Zephyr version 3.7.1')
         exec_command_and_wait_for_pattern(self, 'md 72c02000 1',
-                                          '[72c02000] 06010103')
+                                          '[72c02000] 06020103')
 
     def start_ast2700fc_test(self, name):
         ca35_core = 4
@@ -153,8 +153,8 @@ def test_aarch64_ast2700fc_sdk_v11_00(self):
         self.require_netdev('user')
 
         self.archive_extract(self.ASSET_SDK_V1100_AST2700)
-        self.start_ast2700fc_test('ast2700-a1')
-        self.verify_openbmc_boot_and_login('ast2700-a1')
+        self.start_ast2700fc_test('ast2700-default')
+        self.verify_openbmc_boot_and_login('ast2700-default')
         self.do_ast2700_i2c_test()
         self.do_ast2700_pcie_test()
         self.do_ast2700fc_ssp_test()
@@ -164,8 +164,8 @@ def test_aarch64_ast2700fc_sdk_vbootrom_v11_00(self):
         self.set_machine('ast2700fc')
 
         self.archive_extract(self.ASSET_SDK_V1100_AST2700)
-        self.start_ast2700fc_test_vbootrom('ast2700-a1')
-        self.verify_openbmc_boot_and_login('ast2700-a1')
+        self.start_ast2700fc_test_vbootrom('ast2700-default')
+        self.verify_openbmc_boot_and_login('ast2700-default')
         self.do_ast2700fc_ssp_test()
         self.do_ast2700fc_tsp_test()
 
-- 
2.53.0


