Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3774E95377
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 10:35:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnaBU-0000hM-6X; Wed, 04 Feb 2026 05:32:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnaBE-0000Wl-9c
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:32:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnaBC-00040k-6F
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:32:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770201133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+tJJ4Gdav/bQecXsilsxeWeIbf+cYAYSrCPgNukvVfY=;
 b=hKae0xwnN7QBNS/IgtJUPAyRS0CLzo4ibeZbXAtLdyxeA+U0okXQBsfshqdb145jIFFwVT
 mXuTlgwm2PpXdB9U+rTNhhYgWTFKjgnzPhgBc5gpn3APuk6MqkkvViPK+VmMoXrcSqwaRY
 0QvKOxMpIksvICiB5qRo3FFeYzq7Oho=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-128-tY4WTL1kMoiSZcGs40OAXQ-1; Wed,
 04 Feb 2026 05:32:11 -0500
X-MC-Unique: tY4WTL1kMoiSZcGs40OAXQ-1
X-Mimecast-MFC-AGG-ID: tY4WTL1kMoiSZcGs40OAXQ_1770201131
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E63F21956053; Wed,  4 Feb 2026 10:32:10 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.44])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 74DBE18004AD; Wed,  4 Feb 2026 10:32:09 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 14/45] tests/functional/arm/test_aspeed_ast1060: Update test
 aspeed-zephyr-project v03.04
Date: Wed,  4 Feb 2026 11:31:05 +0100
Message-ID: <20260204103136.1795455-15-clg@redhat.com>
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
Link: https://lore.kernel.org/qemu-devel/20260127032348.2238527-7-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/functional/arm/test_aspeed_ast1060.py | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/functional/arm/test_aspeed_ast1060.py b/tests/functional/arm/test_aspeed_ast1060.py
index 034efa534262..eccb4252d86a 100644
--- a/tests/functional/arm/test_aspeed_ast1060.py
+++ b/tests/functional/arm/test_aspeed_ast1060.py
@@ -11,18 +11,18 @@
 
 
 class AST1060Machine(AspeedTest):
-    ASSET_ASPEED_AST1060_PROT_3_02 = Asset(
+    ASSET_ASPEED_AST1060_PROT_3_04 = Asset(
         ('https://github.com/AspeedTech-BMC'
-         '/aspeed-zephyr-project/releases/download/v03.02'
-         '/ast1060_prot_v03.02.tgz'),
-         'dd5f1adc935316ddd1906506a02e15567bd7290657b52320f1a225564cc175bd')
+         '/aspeed-zephyr-project/releases/download/v03.04'
+         '/ast1060_prot_v03.04.tgz'),
+         'c0319df55f5b7a547efefc5a6ba374b881223d5fe1a776bfdd36f97fd1f31d50')
 
-    def test_arm_ast1060_prot_3_02(self):
+    def test_arm_ast1060_prot_3_04(self):
         self.set_machine('ast1060-evb')
 
         kernel_name = "ast1060_prot/zephyr.bin"
         kernel_file = self.archive_extract(
-            self.ASSET_ASPEED_AST1060_PROT_3_02, member=kernel_name)
+            self.ASSET_ASPEED_AST1060_PROT_3_04, member=kernel_name)
 
         self.vm.set_console()
         self.vm.add_args('-kernel', kernel_file, '-nographic')
@@ -35,7 +35,7 @@ def test_arm_ast1060_otp_blockdev_device(self):
         self.vm.set_machine("ast1060-evb")
 
         kernel_name = "ast1060_prot/zephyr.bin"
-        kernel_file = self.archive_extract(self.ASSET_ASPEED_AST1060_PROT_3_02,
+        kernel_file = self.archive_extract(self.ASSET_ASPEED_AST1060_PROT_3_04,
                                            member=kernel_name)
         otp_img = self.generate_otpmem_image()
 
-- 
2.52.0


