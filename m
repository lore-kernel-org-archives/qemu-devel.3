Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C6A4F47CA6
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 18:05:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyD0i-0006OX-7M; Thu, 05 Mar 2026 13:01:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vyCyJ-0001Ma-8y
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:58:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vyCyH-0003v8-Nt
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:58:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772733529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P4HTDVqp1Rm75CcgAML40zMJ2sVIsoJHpgpbY9bqmsI=;
 b=JD2vC2KirNVCCBEzaYf6epjQ81Tq4qXnIqahjcu5Ho83YhZx9VSEY9g4NJc+KXLm6/m34M
 nS90jH17kfOiO/xe45C6Vx7z9NnyI5w+7Isogl/dt3pvcYbCXG/84FQJJKFqI1qYvoGzYy
 Nn44YCtfzGxxl/tevoImUAz6HkWLmNs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-218-q8zhgj1zPoq-XZHJxUJwJw-1; Thu,
 05 Mar 2026 12:58:46 -0500
X-MC-Unique: q8zhgj1zPoq-XZHJxUJwJw-1
X-Mimecast-MFC-AGG-ID: q8zhgj1zPoq-XZHJxUJwJw_1772733525
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 25305195608F; Thu,  5 Mar 2026 17:58:45 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 910AA3003E9E; Thu,  5 Mar 2026 17:58:43 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 35/38] tests/functional/arm/test_aspeed_ast2600_sdk_515: Update
 test ASPEED OpenBMC SDK v11.01
Date: Thu,  5 Mar 2026 18:57:08 +0100
Message-ID: <20260305175711.1119025-36-clg@redhat.com>
In-Reply-To: <20260305175711.1119025-1-clg@redhat.com>
References: <20260305175711.1119025-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Link: https://lore.kernel.org/qemu-devel/20260303063930.2878300-8-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/functional/arm/test_aspeed_ast2600_sdk_515.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/functional/arm/test_aspeed_ast2600_sdk_515.py b/tests/functional/arm/test_aspeed_ast2600_sdk_515.py
index f48da301d567..ec043e7d6116 100755
--- a/tests/functional/arm/test_aspeed_ast2600_sdk_515.py
+++ b/tests/functional/arm/test_aspeed_ast2600_sdk_515.py
@@ -10,17 +10,17 @@
 
 class AST2600Machine(AspeedTest):
 
-    ASSET_SDK_V1100_AST2600_515 = Asset(
-        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.00/ast2600-default-515-obmc.tar.gz',
-        'ece1a934095378929780f03e7d092e562f4b33b2841b80ad7c3d12a85744c0f6')
+    ASSET_SDK_V1101_AST2600_515 = Asset(
+        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.01/ast2600-default-515-image.tar.gz',
+        'f3ccf1c08db71cf891637fc73131b80b2c0c0e005c06d5dcae0cf74fc458b43c')
 
     def test_arm_ast2600_evb_sdk_515(self):
         self.set_machine('ast2600-evb')
 
-        self.archive_extract(self.ASSET_SDK_V1100_AST2600_515)
+        self.archive_extract(self.ASSET_SDK_V1101_AST2600_515)
 
         self.do_test_arm_aspeed_sdk_start(
-            self.scratch_file("ast2600-default-515", "image-bmc"))
+            self.scratch_file("ast2600-default-515-image", "image-bmc"))
 
         self.wait_for_console_pattern('ast2600-default-515 login:')
 
-- 
2.53.0


