Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43CE8C5CFCF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:42:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpP0-0005N8-Hq; Tue, 11 Aug 2026 12:32:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpOf-0005Ih-IG
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:32:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpOd-0000zV-JA
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:32:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cE93U6qH8M4ozN3ohqmDXKwZ17IGP/4+6S9yr2Y5Xg4=;
 b=HWZ2XH4o4rimrWcAeyb1AIxhOp39vANtdzEVEGF2G8ndPJ05cch8WpoJXqzF9GtQfqiCeR
 58WTUY+1BtbkZfTrwFq4wjUD9m6zwEQVwh5bnQCJwA6msApRWSRgEE7G6SgvLreTSwQn2V
 9LmnGGqg0lQwlJCiIJVEfcXS8lGyABI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-336-2c7AefyuM32uAthgGByqWw-1; Tue,
 11 Aug 2026 12:32:05 -0400
X-MC-Unique: 2c7AefyuM32uAthgGByqWw-1
X-Mimecast-MFC-AGG-ID: 2c7AefyuM32uAthgGByqWw_1786465924
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 332D11800C36; Tue, 11 Aug 2026 16:32:04 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B74BC195DF91; Tue, 11 Aug 2026 16:32:02 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 66/83] tests/functional/arm/test_aspeed_ast1060: Update ASPEED
 ZEPHYR PROJECT v03.07
Date: Tue, 11 Aug 2026 18:29:21 +0200
Message-ID: <20260811162938.1403216-67-clg@redhat.com>
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
Link: https://lore.kernel.org/qemu-devel/20260804081955.1563537-9-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/functional/arm/test_aspeed_ast1060.py | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/functional/arm/test_aspeed_ast1060.py b/tests/functional/arm/test_aspeed_ast1060.py
index 833cfb8272e7..d7158259e647 100755
--- a/tests/functional/arm/test_aspeed_ast1060.py
+++ b/tests/functional/arm/test_aspeed_ast1060.py
@@ -11,18 +11,18 @@
 
 
 class AST1060Machine(AspeedTest):
-    ASSET_ASPEED_AST1060_PROT_3_05 = Asset(
+    ASSET_ASPEED_AST1060_PROT_3_07 = Asset(
         ('https://github.com/AspeedTech-BMC'
-         '/aspeed-zephyr-project/releases/download/v03.05'
-         '/ast1060_prot_v03.05.tgz'),
-         '63b36d7420290726ca80477de254474b7cb79539a42819bb1fe2665d598dadb5')
+         '/aspeed-zephyr-project/releases/download/v03.07'
+         '/ast1060_prot_v03.07.tgz'),
+         '55a7f51f0b77051a0ef2ada993a16c5033768e1b8e8be3babfc52c303eecd07f')
 
-    def test_arm_ast1060_prot_3_05(self):
+    def test_arm_ast1060_prot_3_07(self):
         self.set_machine('ast1060-evb')
 
         kernel_name = "ast1060_prot/zephyr.bin"
         kernel_file = self.archive_extract(
-            self.ASSET_ASPEED_AST1060_PROT_3_05, member=kernel_name)
+            self.ASSET_ASPEED_AST1060_PROT_3_07, member=kernel_name)
 
         self.vm.set_console()
         self.vm.add_args('-kernel', kernel_file, '-nographic')
@@ -35,7 +35,7 @@ def test_arm_ast1060_otp_blockdev_device(self):
         self.vm.set_machine("ast1060-evb")
 
         kernel_name = "ast1060_prot/zephyr.bin"
-        kernel_file = self.archive_extract(self.ASSET_ASPEED_AST1060_PROT_3_05,
+        kernel_file = self.archive_extract(self.ASSET_ASPEED_AST1060_PROT_3_07,
                                            member=kernel_name)
         otp_img = self.generate_otpmem_image()
 
-- 
2.55.0


