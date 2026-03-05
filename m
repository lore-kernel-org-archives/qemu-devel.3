Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A9FF47CA5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 18:06:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyCzq-0004Zo-2f; Thu, 05 Mar 2026 13:00:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vyCyF-0000vX-Ka
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:58:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vyCyE-0003r7-00
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:58:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772733525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7uebfYJvdK0ylSR25PlNa2JWPt2whqAd9Oc2g3r2CAk=;
 b=d5rb8uEYR1/kZ0f96mt/mfEVxUALWTybCprlsamLUqZ5Pif0Yk54XtcUbjGKxvKj9cmmli
 nfCu0RZFJySGqPeFpy7AgXIL9pXvQcxJY9fqXorgBdFe+DYrfh9fbErw38XsjxStwmfO7p
 H2L9+1iXOD0Y0BnaML8UrKPyyhRi0ss=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-WkKzz6lnO--0GDIoZw6gJw-1; Thu,
 05 Mar 2026 12:58:42 -0500
X-MC-Unique: WkKzz6lnO--0GDIoZw6gJw-1
X-Mimecast-MFC-AGG-ID: WkKzz6lnO--0GDIoZw6gJw_1772733521
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 243E8195609D; Thu,  5 Mar 2026 17:58:41 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 80E0A3003E9E; Thu,  5 Mar 2026 17:58:39 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 33/38] tests/functional/arm/test_aspeed_ast2600_sdk: Update
 test ASPEED OpenBMC SDK v11.01
Date: Thu,  5 Mar 2026 18:57:06 +0100
Message-ID: <20260305175711.1119025-34-clg@redhat.com>
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
Link: https://lore.kernel.org/qemu-devel/20260303063930.2878300-6-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/functional/arm/test_aspeed_ast2600_sdk.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/functional/arm/test_aspeed_ast2600_sdk.py b/tests/functional/arm/test_aspeed_ast2600_sdk.py
index 46b9f7058c08..d787e90d1024 100755
--- a/tests/functional/arm/test_aspeed_ast2600_sdk.py
+++ b/tests/functional/arm/test_aspeed_ast2600_sdk.py
@@ -14,9 +14,9 @@
 
 class AST2600Machine(AspeedTest):
 
-    ASSET_SDK_V1100_AST2600 = Asset(
-        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.00/ast2600-default-obmc.tar.gz',
-        '64d8926a7d01b649168be96c986603b5690f06391286c438a3a772c8c7039e93')
+    ASSET_SDK_V1101_AST2600 = Asset(
+        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.01/ast2600-default-image.tar.gz',
+        '3c5b4d4ccf27b0d208a073f98426db54cd751b96143180cd15df1a83978f832c')
 
     def do_ast2600_pcie_test(self):
         exec_command_and_wait_for_pattern(self,
@@ -44,7 +44,7 @@ def test_arm_ast2600_evb_sdk(self):
         self.set_machine('ast2600-evb')
         self.require_netdev('user')
 
-        self.archive_extract(self.ASSET_SDK_V1100_AST2600)
+        self.archive_extract(self.ASSET_SDK_V1101_AST2600)
 
         self.vm.add_args('-device',
             'tmp105,bus=aspeed.i2c.bus.5,address=0x4d,id=tmp-test')
@@ -55,7 +55,7 @@ def test_arm_ast2600_evb_sdk(self):
         self.vm.add_args('-device',
             'mock-i3c-target,bus=dw.i3c.5,pid=0xab9078563412')
         self.do_test_arm_aspeed_sdk_start(
-            self.scratch_file("ast2600-default", "image-bmc"))
+            self.scratch_file("ast2600-default-image", "image-bmc"))
 
         self.wait_for_console_pattern('ast2600-default login:')
 
-- 
2.53.0


