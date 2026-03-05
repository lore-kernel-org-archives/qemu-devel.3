Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C61F47CA5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 17:59:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyCyI-0001Fo-KE; Thu, 05 Mar 2026 12:58:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vyCyC-0000Wx-Qw
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:58:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vyCy8-0003oO-P5
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:58:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772733519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gMQduxnluG/Tkw5NdD3LVshsRn8xQODMCyimqNUgoVw=;
 b=V5A9maOZiLqQKEoetaRIZNlu12SkOeqwWo4da8C6obh4DGsmtmfJnFLpEVUibHrzEVaHEJ
 qRz9z7DjwJOMaR6pm5IoRo/9pF28wSX0L89G1BIcFdHE8GVq8sU13vj6Kb+Kkg04q2509S
 NdUn9H50Rl3NkFSj4c5zxbgdA8yzxM0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-aiS3zozsPnGK1QeATM8vjA-1; Thu,
 05 Mar 2026 12:58:36 -0500
X-MC-Unique: aiS3zozsPnGK1QeATM8vjA-1
X-Mimecast-MFC-AGG-ID: aiS3zozsPnGK1QeATM8vjA_1772733515
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1826118005BA; Thu,  5 Mar 2026 17:58:35 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 90D603003E9E; Thu,  5 Mar 2026 17:58:33 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 30/38] tests/functional/arm/test_aspeed_ast1060: Update test
 aspeed-zephyr-project v03.05
Date: Thu,  5 Mar 2026 18:57:03 +0100
Message-ID: <20260305175711.1119025-31-clg@redhat.com>
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
Tested-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260303063930.2878300-3-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/functional/arm/test_aspeed_ast1060.py | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/functional/arm/test_aspeed_ast1060.py b/tests/functional/arm/test_aspeed_ast1060.py
index eccb4252d86a..833cfb8272e7 100755
--- a/tests/functional/arm/test_aspeed_ast1060.py
+++ b/tests/functional/arm/test_aspeed_ast1060.py
@@ -11,18 +11,18 @@
 
 
 class AST1060Machine(AspeedTest):
-    ASSET_ASPEED_AST1060_PROT_3_04 = Asset(
+    ASSET_ASPEED_AST1060_PROT_3_05 = Asset(
         ('https://github.com/AspeedTech-BMC'
-         '/aspeed-zephyr-project/releases/download/v03.04'
-         '/ast1060_prot_v03.04.tgz'),
-         'c0319df55f5b7a547efefc5a6ba374b881223d5fe1a776bfdd36f97fd1f31d50')
+         '/aspeed-zephyr-project/releases/download/v03.05'
+         '/ast1060_prot_v03.05.tgz'),
+         '63b36d7420290726ca80477de254474b7cb79539a42819bb1fe2665d598dadb5')
 
-    def test_arm_ast1060_prot_3_04(self):
+    def test_arm_ast1060_prot_3_05(self):
         self.set_machine('ast1060-evb')
 
         kernel_name = "ast1060_prot/zephyr.bin"
         kernel_file = self.archive_extract(
-            self.ASSET_ASPEED_AST1060_PROT_3_04, member=kernel_name)
+            self.ASSET_ASPEED_AST1060_PROT_3_05, member=kernel_name)
 
         self.vm.set_console()
         self.vm.add_args('-kernel', kernel_file, '-nographic')
@@ -35,7 +35,7 @@ def test_arm_ast1060_otp_blockdev_device(self):
         self.vm.set_machine("ast1060-evb")
 
         kernel_name = "ast1060_prot/zephyr.bin"
-        kernel_file = self.archive_extract(self.ASSET_ASPEED_AST1060_PROT_3_04,
+        kernel_file = self.archive_extract(self.ASSET_ASPEED_AST1060_PROT_3_05,
                                            member=kernel_name)
         otp_img = self.generate_otpmem_image()
 
-- 
2.53.0


