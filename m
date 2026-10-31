Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590D6606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 07:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EUptm46j
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xN33c-0002zw-2A; Sat, 31 Oct 2026 02:59:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xN33T-0002uv-65
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 02:59:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xN33R-0002mR-Er
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 02:59:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793429944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s+x+YDOD5GwyemKg4BGRa6gT/kh9XQ7D1brgydNK4OE=;
 b=EUptm46j6C7sOO4VHUNxApLfKtAcXy8vV1WXb6baeclbVhcfDmGh2Ubcb0Ykx3085gVsbP
 fC2AuJbmRHW6Sg+KN6y8zHpQO1lLLeBy2ln2p3GlnilfdOvthtnQ8F8NaV1H0rdwwt2qwz
 wwBKu3UgMmDqhaovCLS9bXc9E9hzh3E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-543-9mW0NCLVNZGe5SlGJKYDNA-1; Sat,
 31 Oct 2026 02:59:02 -0400
X-MC-Unique: 9mW0NCLVNZGe5SlGJKYDNA-1
X-Mimecast-MFC-AGG-ID: 9mW0NCLVNZGe5SlGJKYDNA_1793429941
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CA0D0180057D; Sat, 31 Oct 2026 06:59:01 +0000 (UTC)
Received: from circe.redhat.com (unknown [10.44.32.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4F5DA1803A40; Sat, 31 Oct 2026 06:59:00 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 13/34] tests/functional/arm/test_aspeed_ast1040: Update AST1040
 image to aspeed-mcu-fw-hub v01.00
Date: Sat, 31 Oct 2026 07:58:02 +0100
Message-ID: <20261031065823.191966-14-clg@redhat.com>
In-Reply-To: <20261031065823.191966-1-clg@redhat.com>
References: <20261031065823.191966-1-clg@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jamin Lin <jamin_lin@aspeedtech.com>

Previously, ASPEED hosted the AST1040 pre-built image in the Zephyr GitHub repository
as a temporary solution for QEMU functional tests.

ASPEED now provides official AST1040/AST1080 pre-built images in the aspeed-mcu-fw-hub
repository, starting with release v01.00.

Update the AST1040 functional test to use the official pre-built image from
aspeed-mcu-fw-hub instead of the Zephyr repository.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20261028023154.48395-14-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/functional/arm/test_aspeed_ast1040.py | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tests/functional/arm/test_aspeed_ast1040.py b/tests/functional/arm/test_aspeed_ast1040.py
index e4d8ecb37a58..bdfd81567325 100644
--- a/tests/functional/arm/test_aspeed_ast1040.py
+++ b/tests/functional/arm/test_aspeed_ast1040.py
@@ -12,17 +12,19 @@
 
 class AST1040Machine(AspeedTest):
 
-    ASSET_ZEPHYR_3_07 = Asset(
+    ASSET_ASPEED_AST1040_EVB_01_00 = Asset(
         ('https://github.com/AspeedTech-BMC'
-         '/zephyr/releases/download/v00.03.07/ast1040-evb-demo.zip'),
-         'b5189797c22c2d732ddc27670c1efdeba821a2747c9c7434f190791125baa121')
+         '/aspeed-mcu-fw-hub/releases/download/v01.00'
+         '/ast1040a0-evb-v01.00.tar.gz'),
+         '62dff10cef99a72a9ec679b7ed2c80ba1b76dcdab6bb66251e99a83a31612a02')
 
     def test_arm_ast1040_zephyros(self):
         self.set_machine('ast1040-evb')
 
-        kernel_name = "zephyr.bin"
+        kernel_name = ('ast1040a0-evb-v01.00/ast1040/ast1040a0/evb/'
+                       'zephyr-shell-module.bin')
         kernel_file = self.archive_extract(
-            self.ASSET_ZEPHYR_3_07, member=kernel_name)
+            self.ASSET_ASPEED_AST1040_EVB_01_00, member=kernel_name)
 
         self.vm.set_console()
         self.vm.add_args('-kernel', kernel_file, '-nographic')
-- 
2.56.0


