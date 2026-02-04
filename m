Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 605EAE95375
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 10:37:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnaBY-0000x2-Pt; Wed, 04 Feb 2026 05:32:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnaBJ-0000bQ-3j
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:32:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnaBG-00041e-UU
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:32:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770201138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jspOalxDiHJBD00cvxzPJ6LHxGM6dr6+SEae2qJ57r4=;
 b=QoREvIBT2CaKGBcBnhTosX6uJWQo83PAxfyzPwKCPPnnEKrGEUJaE4wiTag6A79yMKWcZY
 6ibrAkjANmG71PE2bECPU18IhjGPVUSVICMTKzXsTPvkr6ruVbu947ZqTgAvlTLxeu0ss4
 h359oO2ti9exv2GfPu1T+/TfAsrmpkE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-49-mKbz-2BhNLueCVRPPtJQ9g-1; Wed,
 04 Feb 2026 05:32:13 -0500
X-MC-Unique: mKbz-2BhNLueCVRPPtJQ9g-1
X-Mimecast-MFC-AGG-ID: mKbz-2BhNLueCVRPPtJQ9g_1770201133
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ECF241800473; Wed,  4 Feb 2026 10:32:12 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.44])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 634F518003F6; Wed,  4 Feb 2026 10:32:11 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 15/45] tests/functional/arm/test_aspeed_ast1030: Update test
 ASPEED Zephyr SDK v03.05
Date: Wed,  4 Feb 2026 11:31:06 +0100
Message-ID: <20260204103136.1795455-16-clg@redhat.com>
In-Reply-To: <20260204103136.1795455-1-clg@redhat.com>
References: <20260204103136.1795455-1-clg@redhat.com>
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

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260127032348.2238527-8-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/functional/arm/test_aspeed_ast1030.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/functional/arm/test_aspeed_ast1030.py b/tests/functional/arm/test_aspeed_ast1030.py
index d1822edd8f10..0defa7c38e25 100755
--- a/tests/functional/arm/test_aspeed_ast1030.py
+++ b/tests/functional/arm/test_aspeed_ast1030.py
@@ -12,17 +12,17 @@
 
 class AST1030Machine(AspeedTest):
 
-    ASSET_ZEPHYR_3_03 = Asset(
+    ASSET_ZEPHYR_3_05 = Asset(
         ('https://github.com/AspeedTech-BMC'
-         '/zephyr/releases/download/v00.03.03/ast1030-evb-demo.zip'),
-         '27cd73cdee6374bceb4ee58b3ace87989fa3f0684f4e612510804b588b24d4e0')
+         '/zephyr/releases/download/v00.03.05/ast1030-evb-demo.zip'),
+         '057528d343490b1fbb5a721e91084b4f04fec60dc114bd65e724554f9c217f4b')
 
-    def test_arm_ast1030_zephyros_3_03(self):
+    def test_arm_ast1030_zephyros_3_05(self):
         self.set_machine('ast1030-evb')
 
         kernel_name = "ast1030-evb-demo/zephyr.elf"
         kernel_file = self.archive_extract(
-            self.ASSET_ZEPHYR_3_03, member=kernel_name)
+            self.ASSET_ZEPHYR_3_05, member=kernel_name)
 
         self.vm.set_console()
         self.vm.add_args('-kernel', kernel_file, '-nographic')
@@ -72,7 +72,7 @@ def test_arm_ast1030_otp_blockdev_device(self):
         self.vm.set_machine("ast1030-evb")
 
         kernel_name = "ast1030-evb-demo/zephyr.elf"
-        kernel_file = self.archive_extract(self.ASSET_ZEPHYR_3_03,
+        kernel_file = self.archive_extract(self.ASSET_ZEPHYR_3_05,
                                            member=kernel_name)
         otp_img = self.generate_otpmem_image()
 
-- 
2.52.0


