Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FD6AC5CFEB
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:37:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpOa-0004wv-EV; Tue, 11 Aug 2026 12:32:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpOY-0004mc-0X
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:32:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpOV-0000xP-M3
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:32:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nzxhg5EtdsbPFhxM9OxJLcKjuCS3+iMJ8/d5JpbJPEw=;
 b=eixjbBpKIeppLyNn/a+nrH3D0whaBx/xExhmHTcQiFpuFfYVzOjYCyHKJaA82GR4f2S9vO
 jl+XH0u0k6A6n0G/kL+d068U8a8evvfasAdLkqSntvgcs8FJUCryAZofIjAw0c/qJfkaZU
 yvRKF+ZUTOVci6WkaGOZT764AWJLuWg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-507-lvd707_uOzC0wr46runsAQ-1; Tue,
 11 Aug 2026 12:31:59 -0400
X-MC-Unique: lvd707_uOzC0wr46runsAQ-1
X-Mimecast-MFC-AGG-ID: lvd707_uOzC0wr46runsAQ_1786465918
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 731881800650; Tue, 11 Aug 2026 16:31:58 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A83A0195DF91; Tue, 11 Aug 2026 16:31:56 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 63/83] tests/functional/arm/test_aspeed_ast2600_sdk: Update
 ASPEED SDK v11.03
Date: Tue, 11 Aug 2026 18:29:18 +0200
Message-ID: <20260811162938.1403216-64-clg@redhat.com>
In-Reply-To: <20260811162938.1403216-1-clg@redhat.com>
References: <20260811162938.1403216-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Link: https://lore.kernel.org/qemu-devel/20260804081955.1563537-6-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/functional/arm/test_aspeed_ast2600_sdk.py     | 8 ++++----
 tests/functional/arm/test_aspeed_ast2600_sdk_515.py | 8 ++++----
 tests/functional/arm/test_aspeed_ast2600_sdk_otp.py | 8 ++++----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/tests/functional/arm/test_aspeed_ast2600_sdk.py b/tests/functional/arm/test_aspeed_ast2600_sdk.py
index cabbe230c4cc..4fc594dfd5a1 100755
--- a/tests/functional/arm/test_aspeed_ast2600_sdk.py
+++ b/tests/functional/arm/test_aspeed_ast2600_sdk.py
@@ -14,9 +14,9 @@
 
 class AST2600Machine(AspeedTest):
 
-    ASSET_SDK_V1101_AST2600 = Asset(
-        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.01/ast2600-default-image.tar.gz',
-        '3c5b4d4ccf27b0d208a073f98426db54cd751b96143180cd15df1a83978f832c')
+    ASSET_SDK_V1103_AST2600 = Asset(
+        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.03/ast2600-default-image.tar.gz',
+        '47e3656a14bf7a4de28d3dfbf48bc2325443bc42d270f3bc82646f92f6dea165')
 
     def do_ast2600_pcie_test(self):
         exec_command_and_wait_for_pattern(self,
@@ -49,7 +49,7 @@ def test_arm_ast2600_evb_sdk(self):
         self.set_machine('ast2600-evb')
         self.require_netdev('user')
 
-        self.archive_extract(self.ASSET_SDK_V1101_AST2600)
+        self.archive_extract(self.ASSET_SDK_V1103_AST2600)
 
         self.vm.add_args('-device',
             'tmp105,bus=aspeed.i2c.bus.5,address=0x4d,id=tmp-test')
diff --git a/tests/functional/arm/test_aspeed_ast2600_sdk_515.py b/tests/functional/arm/test_aspeed_ast2600_sdk_515.py
index a8e7faff4890..f5b14de083a7 100755
--- a/tests/functional/arm/test_aspeed_ast2600_sdk_515.py
+++ b/tests/functional/arm/test_aspeed_ast2600_sdk_515.py
@@ -10,14 +10,14 @@
 
 class AST2600Machine(AspeedTest):
 
-    ASSET_SDK_V1101_AST2600_515 = Asset(
-        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.01/ast2600-default-515-image.tar.gz',
-        'f3ccf1c08db71cf891637fc73131b80b2c0c0e005c06d5dcae0cf74fc458b43c')
+    ASSET_SDK_V1103_AST2600_515 = Asset(
+        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.03/ast2600-default-515-image.tar.gz',
+        'c79d0197106f146476e82bb878e5438f6569bd30f3b53fbb520b59bc54f6b7dc')
 
     def test_arm_ast2600_evb_sdk_515(self):
         self.set_machine('ast2600-evb')
 
-        self.archive_extract(self.ASSET_SDK_V1101_AST2600_515)
+        self.archive_extract(self.ASSET_SDK_V1103_AST2600_515)
 
         self.do_test_arm_aspeed_sdk_start(
             self.scratch_file("ast2600-default-515-image", "image-bmc"))
diff --git a/tests/functional/arm/test_aspeed_ast2600_sdk_otp.py b/tests/functional/arm/test_aspeed_ast2600_sdk_otp.py
index f24dea1e8f03..5813c59bd6db 100755
--- a/tests/functional/arm/test_aspeed_ast2600_sdk_otp.py
+++ b/tests/functional/arm/test_aspeed_ast2600_sdk_otp.py
@@ -12,15 +12,15 @@
 
 class AST2600Machine(AspeedTest):
 
-    ASSET_SDK_V1101_AST2600 = Asset(
-        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.01/ast2600-default-image.tar.gz',
-        '3c5b4d4ccf27b0d208a073f98426db54cd751b96143180cd15df1a83978f832c')
+    ASSET_SDK_V1103_AST2600 = Asset(
+        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.03/ast2600-default-image.tar.gz',
+        '47e3656a14bf7a4de28d3dfbf48bc2325443bc42d270f3bc82646f92f6dea165')
 
     def test_arm_ast2600_otp_blockdev_device(self):
         self.vm.set_machine("ast2600-evb")
         self.require_netdev('user')
 
-        image_path = self.archive_extract(self.ASSET_SDK_V1101_AST2600)
+        image_path = self.archive_extract(self.ASSET_SDK_V1103_AST2600)
         otp_img = self.generate_otpmem_image()
 
         self.vm.set_console()
-- 
2.55.0


