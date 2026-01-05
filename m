Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28828C79F94
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 13:02:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vckBJ-0006zN-Lq; Mon, 05 Jan 2026 07:59:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vck9E-0004PR-Bo
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 07:57:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vck9C-000875-Jc
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 07:57:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767617842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dUNgTCcgVwMHoRdHx+5eUBcnLo70zMvS6I1BEpTwZDs=;
 b=W7SCC17voWxacpQ+rtzxRZ/hfpUeWHKzS8NVgSsl/PxfUMlKg5DPkRhOjYhzuSOtEnndEX
 KUtDFVDJHjElNfEGdZZjbuv/Tw1vcZM5blK6usYUSR1YAtif5T+WKvZ7E65xgNbzj7u77o
 E58E8wmqisfmF7lewvF0iprO16PTUXw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-510-k9RJQIkBNnOYT-gWkwdDJg-1; Mon,
 05 Jan 2026 07:57:20 -0500
X-MC-Unique: k9RJQIkBNnOYT-gWkwdDJg-1
X-Mimecast-MFC-AGG-ID: k9RJQIkBNnOYT-gWkwdDJg_1767617839
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BC31419560A5; Mon,  5 Jan 2026 12:57:19 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.53])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 49C6619560A7; Mon,  5 Jan 2026 12:57:18 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 30/36] hw/arm: Remove ast2700a0-evb machine
Date: Mon,  5 Jan 2026 13:56:07 +0100
Message-ID: <20260105125613.622667-31-clg@redhat.com>
In-Reply-To: <20260105125613.622667-1-clg@redhat.com>
References: <20260105125613.622667-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The ast2700a0-evb machine represents the first revision of the AST2700 and
serves as the initial engineering sample rather than a production version.
A newer revision, A1, is now supported, and the ast2700a1-evb should replace
the older A0 version.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250901040808.1454742-2-jamin_lin@aspeedtech.com
[ clg: Updated docs/about/removed-features.rst ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 docs/about/deprecated.rst       |  8 --------
 docs/about/removed-features.rst |  8 ++++++++
 hw/arm/aspeed_ast27x0_evb.c     | 26 --------------------------
 3 files changed, 8 insertions(+), 34 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index ac31a2bce427..7abb3dab592b 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -280,14 +280,6 @@ deprecated; use the new name ``dtb-randomness`` instead. The new name
 better reflects the way this property affects all random data within
 the device tree blob, not just the ``kaslr-seed`` node.
 
-Arm ``ast2700a0-evb`` machine (since 10.1)
-''''''''''''''''''''''''''''''''''''''''''
-
-The ``ast2700a0-evb`` machine represents the first revision of the AST2700
-and serves as the initial engineering sample rather than a production version.
-A newer revision, A1, is now supported, and the ``ast2700a1-evb`` should
-replace the older A0 version.
-
 Arm ``sonorapass-bmc`` machine (since 10.2)
 '''''''''''''''''''''''''''''''''''''''''''
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 422b9c98d354..e81d79da47f2 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -1136,6 +1136,14 @@ Mips ``mipssim`` machine (removed in 10.2)
 Linux dropped support for this virtual machine type in kernel v3.7, and
 there was also no binary available online to use with that board.
 
+Arm ``ast2700a0-evb`` machine (since 11.0)
+''''''''''''''''''''''''''''''''''''''''''
+
+The ``ast2700a0-evb`` machine represents the first revision of the AST2700
+and serves as the initial engineering sample rather than a production version.
+A newer revision, A1, is now supported, and the ``ast2700a1-evb`` should
+replace the older A0 version.
+
 linux-user mode CPUs
 --------------------
 
diff --git a/hw/arm/aspeed_ast27x0_evb.c b/hw/arm/aspeed_ast27x0_evb.c
index 0c4e9cd9cd8e..31f7d61117a9 100644
--- a/hw/arm/aspeed_ast27x0_evb.c
+++ b/hw/arm/aspeed_ast27x0_evb.c
@@ -28,27 +28,6 @@ static void ast2700_evb_i2c_init(AspeedMachineState *bmc)
                             TYPE_TMP105, 0x4d);
 }
 
-static void aspeed_machine_ast2700a0_evb_class_init(ObjectClass *oc,
-                                                    const void *data)
-{
-    MachineClass *mc = MACHINE_CLASS(oc);
-    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
-
-    mc->desc = "Aspeed AST2700 A0 EVB (Cortex-A35)";
-    amc->soc_name  = "ast2700-a0";
-    amc->hw_strap1 = AST2700_EVB_HW_STRAP1;
-    amc->hw_strap2 = AST2700_EVB_HW_STRAP2;
-    amc->fmc_model = "w25q01jvq";
-    amc->spi_model = "w25q512jv";
-    amc->num_cs    = 2;
-    amc->macs_mask = ASPEED_MAC0_ON | ASPEED_MAC1_ON | ASPEED_MAC2_ON;
-    amc->uart_default = ASPEED_DEV_UART12;
-    amc->i2c_init  = ast2700_evb_i2c_init;
-    amc->vbootrom = true;
-    mc->default_ram_size = 1 * GiB;
-    aspeed_machine_class_init_cpus_defaults(mc);
-}
-
 static void aspeed_machine_ast2700a1_evb_class_init(ObjectClass *oc,
                                                     const void *data)
 {
@@ -73,11 +52,6 @@ static void aspeed_machine_ast2700a1_evb_class_init(ObjectClass *oc,
 
 static const TypeInfo aspeed_ast27x0_evb_types[] = {
     {
-        .name          = MACHINE_TYPE_NAME("ast2700a0-evb"),
-        .parent        = TYPE_ASPEED_MACHINE,
-        .class_init    = aspeed_machine_ast2700a0_evb_class_init,
-        .interfaces    = aarch64_machine_interfaces,
-    }, {
         .name          = MACHINE_TYPE_NAME("ast2700a1-evb"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_ast2700a1_evb_class_init,
-- 
2.52.0


