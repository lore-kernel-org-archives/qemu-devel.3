Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1094CCAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 17:00:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3H8a-0003uL-7N; Mon, 29 Sep 2025 12:54:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3H7f-0002uu-GF
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:53:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3H7X-0002nV-Md
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:53:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759164782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LtZkkfn48BVSq6kvoBsfQMoqoIUkdv0Eh2+9wImb+4E=;
 b=eIePFgbZm9brY6oMtroeB7NQh0moZQ3JrOurCpsYqwxT2vD5RKPGYDigHFjpQ1e+vSgSbu
 Brdy+q7McmKHT2+w3BZvRlY91eNTJtD4BGxkcNmsz8kAi0I/jLvJ4wA/S+/BA/0lpS5xVf
 5LPTfqJsDKgeV+ubscvW4IeDSkQceUM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-389-414rMYyNPcOmS6PkunwGXw-1; Mon,
 29 Sep 2025 12:53:00 -0400
X-MC-Unique: 414rMYyNPcOmS6PkunwGXw-1
X-Mimecast-MFC-AGG-ID: 414rMYyNPcOmS6PkunwGXw_1759164779
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B77151956087; Mon, 29 Sep 2025 16:52:59 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.27])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1FE201800452; Mon, 29 Sep 2025 16:52:57 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 10/32] hw/arm/aspeed Move ast2700-evb alias to ast2700a1-evb
Date: Mon, 29 Sep 2025 18:52:08 +0200
Message-ID: <20250929165230.797471-11-clg@redhat.com>
In-Reply-To: <20250929165230.797471-1-clg@redhat.com>
References: <20250929165230.797471-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

This patch moves the "ast2700-evb" alias from the A0 to A1.
The A0 machine remains available via its explicit name
("ast2700a0-evb"), while functional tests are updated to
target A0 by name instead of relying on the generic alias.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250902062550.3797040-1-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed.c                                 | 2 +-
 tests/functional/aarch64/test_aspeed_ast2700.py | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index c31bbe770138..d21b21965aa6 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -1995,7 +1995,6 @@ static void aspeed_machine_ast2700a0_evb_class_init(ObjectClass *oc,
     MachineClass *mc = MACHINE_CLASS(oc);
     AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
 
-    mc->alias = "ast2700-evb";
     mc->desc = "Aspeed AST2700 A0 EVB (Cortex-A35)";
     amc->soc_name  = "ast2700-a0";
     amc->hw_strap1 = AST2700_EVB_HW_STRAP1;
@@ -2018,6 +2017,7 @@ static void aspeed_machine_ast2700a1_evb_class_init(ObjectClass *oc,
     MachineClass *mc = MACHINE_CLASS(oc);
     AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
 
+    mc->alias = "ast2700-evb";
     mc->desc = "Aspeed AST2700 A1 EVB (Cortex-A35)";
     amc->soc_name  = "ast2700-a1";
     amc->hw_strap1 = AST2700_EVB_HW_STRAP1;
diff --git a/tests/functional/aarch64/test_aspeed_ast2700.py b/tests/functional/aarch64/test_aspeed_ast2700.py
index 8a08bc46888e..a3db26729499 100755
--- a/tests/functional/aarch64/test_aspeed_ast2700.py
+++ b/tests/functional/aarch64/test_aspeed_ast2700.py
@@ -115,8 +115,8 @@ def start_ast2700_test_vbootrom(self, name):
         self.do_test_aarch64_aspeed_sdk_start(
                 self.scratch_file(name, 'image-bmc'))
 
-    def test_aarch64_ast2700_evb_sdk_v09_06(self):
-        self.set_machine('ast2700-evb')
+    def test_aarch64_ast2700a0_evb_sdk_v09_06(self):
+        self.set_machine('ast2700a0-evb')
 
         self.archive_extract(self.ASSET_SDK_V906_AST2700)
         self.start_ast2700_test('ast2700-a0-default')
-- 
2.51.0


