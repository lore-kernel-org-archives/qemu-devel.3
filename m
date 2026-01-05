Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D11BAC79FA4
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 16:04:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcn4d-0006O8-N0; Mon, 05 Jan 2026 11:04:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vcn42-0006CO-I7
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 11:04:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vcn40-0001Yp-DZ
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 11:04:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767629050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=cc30GGOr0KYzUuRX6aINvx68bU34Pn4a22V59/U6nmw=;
 b=e/BOsPM0Wla1kg0M0OGLAFZrg6nsigLiwduQPrd6c8V+iMgFn5Z2Hl/ymc4UhKcTESeDEM
 yBftArXZqOTqukWa4IMvfL8VTO9QHzdnyov/KZwmmd1WEMpyl5O2y96HmReBNBhi+uVI9P
 pBytcYY8LotH3C8Ig0VuarnGUh2d6CU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-306-FvZkPrN-PO2r-JamSzdpYQ-1; Mon,
 05 Jan 2026 11:04:07 -0500
X-MC-Unique: FvZkPrN-PO2r-JamSzdpYQ-1
X-Mimecast-MFC-AGG-ID: FvZkPrN-PO2r-JamSzdpYQ_1767629044
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 24177195FCF6; Mon,  5 Jan 2026 16:04:04 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.53])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9D98619560AB; Mon,  5 Jan 2026 16:04:00 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH] tests/functional/arm/aspeed: Update buildroot images to
 2025.11
Date: Mon,  5 Jan 2026 17:03:58 +0100
Message-ID: <20260105160358.771511-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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

The main changes compared to upstream 2025.11 buildroot are

  - Linux v6.18
  - latest OpenBMC U-Boot
  - extra packages (ssh, etc.)

See

  https://github.com/legoater/buildroot/commits/aspeed-2025.11

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/functional/arm/test_aspeed_ast2500.py           | 8 ++++----
 tests/functional/arm/test_aspeed_ast2600_buildroot.py | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tests/functional/arm/test_aspeed_ast2500.py b/tests/functional/arm/test_aspeed_ast2500.py
index 5efd104c2b95..ac33c62a9f85 100755
--- a/tests/functional/arm/test_aspeed_ast2500.py
+++ b/tests/functional/arm/test_aspeed_ast2500.py
@@ -10,15 +10,15 @@
 
 class AST2500Machine(AspeedTest):
 
-    ASSET_BR2_202411_AST2500_FLASH = Asset(
+    ASSET_BR2_202511_AST2500_FLASH = Asset(
         ('https://github.com/legoater/qemu-aspeed-boot/raw/master/'
-         'images/ast2500-evb/buildroot-2024.11/flash.img'),
-        '641e6906c18c0f19a2aeb48099d66d4771929c361001d554d0d45c667413e13a')
+         'images/ast2500-evb/buildroot-2025.11/flash.img'),
+        '31e5a8e280b982fb0e7c07eb71c94851002f99ac604dfe620e71a5d47cc87e78')
 
     def test_arm_ast2500_evb_buildroot(self):
         self.set_machine('ast2500-evb')
 
-        image_path = self.ASSET_BR2_202411_AST2500_FLASH.fetch()
+        image_path = self.ASSET_BR2_202511_AST2500_FLASH.fetch()
 
         self.vm.add_args('-device',
                          'tmp105,bus=aspeed.i2c.bus.3,address=0x4d,id=tmp-test')
diff --git a/tests/functional/arm/test_aspeed_ast2600_buildroot.py b/tests/functional/arm/test_aspeed_ast2600_buildroot.py
index 575a5f64143f..3d130b9fd189 100755
--- a/tests/functional/arm/test_aspeed_ast2600_buildroot.py
+++ b/tests/functional/arm/test_aspeed_ast2600_buildroot.py
@@ -16,15 +16,15 @@
 
 class AST2600Machine(AspeedTest):
 
-    ASSET_BR2_202411_AST2600_FLASH = Asset(
+    ASSET_BR2_202511_AST2600_FLASH = Asset(
         ('https://github.com/legoater/qemu-aspeed-boot/raw/master/'
-         'images/ast2600-evb/buildroot-2024.11/flash.img'),
-        '4bb2f3dfdea31199b51d66b42f686dc5374c144a7346fdc650194a5578b73609')
+         'images/ast2600-evb/buildroot-2025.11/flash.img'),
+        'c64a0755501393d570ca318e326e1e9f8372edc5a6452cdccc3649bc9fd2c138')
 
     def test_arm_ast2600_evb_buildroot(self):
         self.set_machine('ast2600-evb')
 
-        image_path = self.ASSET_BR2_202411_AST2600_FLASH.fetch()
+        image_path = self.ASSET_BR2_202511_AST2600_FLASH.fetch()
 
         self.vm.add_args('-device',
                          'tmp105,bus=aspeed.i2c.bus.3,address=0x4d,id=tmp-test')
-- 
2.52.0


