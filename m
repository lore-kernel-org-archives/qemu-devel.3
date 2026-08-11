Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFEB7C5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:36:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpOc-00058Y-9X; Tue, 11 Aug 2026 12:32:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpOa-0004vZ-0W
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:32:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpOY-0000yL-A7
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:32:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kWnoHbeX0Bj5s7Ejqgs+GFdD0ZsE2bcsx8zPMkC5ZgY=;
 b=fiTxaH22LRfxZVMgcOEnItZw7BWjQCficqF4BQWOGsGBcRyZEOcanA5mZHK5Yk9S0uUqGC
 vngT9fajnxX6CAk4bpui/05aUNaSTtHaNuHO7kOwnI7/dU/8NNQFsUJBxNeuwy8xtzT64g
 9xjChzvwAF4C2JDDheyN0v9uUSV4HKo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-144-6H7rgFEwPwmPQkFO0UVFZA-1; Tue,
 11 Aug 2026 12:32:01 -0400
X-MC-Unique: 6H7rgFEwPwmPQkFO0UVFZA-1
X-Mimecast-MFC-AGG-ID: 6H7rgFEwPwmPQkFO0UVFZA_1786465920
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5EAB0180064B; Tue, 11 Aug 2026 16:32:00 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E2858195DF91; Tue, 11 Aug 2026 16:31:58 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 64/83] tests/functional/arm/test_aspeed_ast2500_sdk: Update
 ASPEED SDK v11.03
Date: Tue, 11 Aug 2026 18:29:19 +0200
Message-ID: <20260811162938.1403216-65-clg@redhat.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001 autolearn=unavailable autolearn_force=no
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
Link: https://lore.kernel.org/qemu-devel/20260804081955.1563537-7-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/functional/arm/test_aspeed_ast2500_sdk.py     | 8 ++++----
 tests/functional/arm/test_aspeed_ast2500_sdk_515.py | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tests/functional/arm/test_aspeed_ast2500_sdk.py b/tests/functional/arm/test_aspeed_ast2500_sdk.py
index 6ab498b3ff54..95df32b84ff8 100755
--- a/tests/functional/arm/test_aspeed_ast2500_sdk.py
+++ b/tests/functional/arm/test_aspeed_ast2500_sdk.py
@@ -10,14 +10,14 @@
 
 class AST2500Machine(AspeedTest):
 
-    ASSET_SDK_V1101_AST2500 = Asset(
-        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.01/ast2500-default-obmc.tar.gz',
-        '3faa1188198da2216837be4b53861c483a58c3ad63784089720bf8421e157da1')
+    ASSET_SDK_V1103_AST2500 = Asset(
+        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.03/ast2500-default-obmc.tar.gz',
+        '8e20cafddca04d73b799918d6f35b08c83c9f024e223a317b0ad71b97b84842f')
 
     def test_arm_ast2500_evb_sdk(self):
         self.set_machine('ast2500-evb')
 
-        self.archive_extract(self.ASSET_SDK_V1101_AST2500)
+        self.archive_extract(self.ASSET_SDK_V1103_AST2500)
 
         self.do_test_arm_aspeed_sdk_start(
             self.scratch_file("ast2500-default", "image-bmc"))
diff --git a/tests/functional/arm/test_aspeed_ast2500_sdk_515.py b/tests/functional/arm/test_aspeed_ast2500_sdk_515.py
index 8d39dc65daaa..516e96e52db7 100755
--- a/tests/functional/arm/test_aspeed_ast2500_sdk_515.py
+++ b/tests/functional/arm/test_aspeed_ast2500_sdk_515.py
@@ -10,14 +10,14 @@
 
 class AST2500Machine(AspeedTest):
 
-    ASSET_SDK_V1101_AST2500_515 = Asset(
-        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.01/ast2500-default-515-obmc.tar.gz',
-        'b848ff620d2e9c83e2fb4736b4d1c39b82fdb041058cd42be42c3b177bf38eb9')
+    ASSET_SDK_V1103_AST2500_515 = Asset(
+        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.03/ast2500-default-515-obmc.tar.gz',
+        'f17d3b0a5157bcf73c21c4981f838ea0b76c6406cc4a6409267d57d61758ebb6')
 
     def test_arm_ast2500_evb_sdk_515(self):
         self.set_machine('ast2500-evb')
 
-        self.archive_extract(self.ASSET_SDK_V1101_AST2500_515)
+        self.archive_extract(self.ASSET_SDK_V1103_AST2500_515)
 
         self.do_test_arm_aspeed_sdk_start(
             self.scratch_file("ast2500-default-515", "image-bmc"))
-- 
2.55.0


