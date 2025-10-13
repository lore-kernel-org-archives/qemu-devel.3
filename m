Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F5BCCA476
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 12:54:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8HvH-0004bJ-3z; Mon, 13 Oct 2025 08:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v8Hv0-0004Ry-05
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 08:44:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v8Hur-0007tX-UK
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 08:44:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760359474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gDa4MlGPXC/kLw04nHyA0sUhKFEOWlwz/Set6pS/fKA=;
 b=jV8zfrMAXn5tfdujvxrr63T33sTBWYyv/eosql0skKSZeS+0PJLpvnuJ5C5wp35VMLjUnA
 bPAdaeFwJ7wzV/2tDi04mv2Nqvwz2leffZJBE6CmK7hlami5aIIn+6U5dAIvSiBGOMb0QV
 Xbci5BQNrUDgbhsP13wXxJizJYhKxGs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-146-TNj5ifmkO7uwr5Uuop2-eA-1; Mon,
 13 Oct 2025 08:44:31 -0400
X-MC-Unique: TNj5ifmkO7uwr5Uuop2-eA-1
X-Mimecast-MFC-AGG-ID: TNj5ifmkO7uwr5Uuop2-eA_1760359470
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8CCE9195410A; Mon, 13 Oct 2025 12:44:30 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.225.105])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D4B701800282; Mon, 13 Oct 2025 12:44:28 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 03/29] tests/functional/arm/test_aspeed_ast1030: Update test
 ASPEED SDK v03.03
Date: Mon, 13 Oct 2025 14:43:54 +0200
Message-ID: <20251013124421.71977-4-clg@redhat.com>
In-Reply-To: <20251013124421.71977-1-clg@redhat.com>
References: <20251013124421.71977-1-clg@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20251003072107.3530642-2-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/functional/arm/test_aspeed_ast1030.py | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/tests/functional/arm/test_aspeed_ast1030.py b/tests/functional/arm/test_aspeed_ast1030.py
index e47b597d0bd9..60e2b0251c6c 100755
--- a/tests/functional/arm/test_aspeed_ast1030.py
+++ b/tests/functional/arm/test_aspeed_ast1030.py
@@ -13,17 +13,17 @@
 
 class AST1030Machine(AspeedTest):
 
-    ASSET_ZEPHYR_3_02 = Asset(
+    ASSET_ZEPHYR_3_03 = Asset(
         ('https://github.com/AspeedTech-BMC'
-         '/zephyr/releases/download/v00.03.02/ast1030-evb-demo.zip'),
-        '1ec83caab3ddd5d09481772801be7210e222cb015ce22ec6fffb8a76956dcd4f')
+         '/zephyr/releases/download/v00.03.03/ast1030-evb-demo.zip'),
+         '27cd73cdee6374bceb4ee58b3ace87989fa3f0684f4e612510804b588b24d4e0')
 
-    def test_arm_ast1030_zephyros_3_02(self):
+    def test_arm_ast1030_zephyros_3_03(self):
         self.set_machine('ast1030-evb')
 
-        kernel_name = "ast1030-evb-demo-3/zephyr.elf"
+        kernel_name = "ast1030-evb-demo/zephyr.elf"
         kernel_file = self.archive_extract(
-            self.ASSET_ZEPHYR_3_02, member=kernel_name)
+            self.ASSET_ZEPHYR_3_03, member=kernel_name)
 
         self.vm.set_console()
         self.vm.add_args('-kernel', kernel_file, '-nographic')
@@ -72,8 +72,9 @@ def test_arm_ast1030_zephyros_1_07(self):
     def test_arm_ast1030_otp_blockdev_device(self):
         self.vm.set_machine("ast1030-evb")
 
-        kernel_name = "ast1030-evb-demo-3/zephyr.elf"
-        kernel_file = self.archive_extract(self.ASSET_ZEPHYR_3_02, member=kernel_name)
+        kernel_name = "ast1030-evb-demo/zephyr.elf"
+        kernel_file = self.archive_extract(self.ASSET_ZEPHYR_3_03,
+                                           member=kernel_name)
         otp_img = self.generate_otpmem_image()
 
         self.vm.set_console()
-- 
2.51.0


