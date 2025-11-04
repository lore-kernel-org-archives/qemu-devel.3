Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A7FCCFA07
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 08:36:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGCV4-0005u6-Gc; Tue, 04 Nov 2025 03:34:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vGCTP-0001vf-HK
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 03:33:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vGCTN-0003gc-QV
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 03:33:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762245181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/9iufskJQQ++QRyMnAKC1ep4sYPcH7RhHFstsir2oBA=;
 b=CYiof7zx90A9u2rg/4qn2oKtSckHGTpFHg/Z2jLOlL4rjMy1ymiVo1jnIWI8cxV89OjTBu
 c5N/B8I1OWs4erRsA67Oaq/S/EbZSWD/wfKeaqC5hYLECH21ZbCgZOyPSb4avUvQ3bJJVW
 P7/9o80ZikrZd0gr+c2B/AfDAEKfGQw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-2Jnsl_f1N4mwxkcybpdPTQ-1; Tue,
 04 Nov 2025 03:32:56 -0500
X-MC-Unique: 2Jnsl_f1N4mwxkcybpdPTQ-1
X-Mimecast-MFC-AGG-ID: 2Jnsl_f1N4mwxkcybpdPTQ_1762245175
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 25EF01800637; Tue,  4 Nov 2025 08:32:55 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.250])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 353E719560A2; Tue,  4 Nov 2025 08:32:52 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 29/30] hw/arm/aspeed: Rename and export
 connect_serial_hds_to_uarts() as aspeed_connect_serial_hds_to_uarts()
Date: Tue,  4 Nov 2025 09:31:43 +0100
Message-ID: <20251104083144.187806-30-clg@redhat.com>
In-Reply-To: <20251104083144.187806-1-clg@redhat.com>
References: <20251104083144.187806-1-clg@redhat.com>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

The helper function connect_serial_hds_to_uarts() has been renamed to
aspeed_connect_serial_hds_to_uarts() and promoted to a public Aspeed
machine API.

Previously, this function was declared static within aspeed.c and only
used internally. Renaming it with the aspeed_ prefix and exporting its
declaration in aspeed.h makes the function accessible to other Aspeed
machine implementations that need to attach host serial devices to SoC
UARTs.

No functional changes.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20251104031325.146374-30-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed.h | 14 ++++++++++++++
 hw/arm/aspeed.c         |  6 +++---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
index 87dcadab264f..714bbd326c48 100644
--- a/include/hw/arm/aspeed.h
+++ b/include/hw/arm/aspeed.h
@@ -111,4 +111,18 @@ I2CSlave *aspeed_create_pca9554(AspeedSoCState *soc, int bus_id, int addr);
  */
 void aspeed_machine_ast2600_class_emmc_init(ObjectClass *oc);
 
+/*
+ * aspeed_connect_serial_hds_to_uarts:
+ * @bmc: pointer to the #AspeedMachineState.
+ *
+ * Connect host serial backends (character devices) to the UART interfaces
+ * of the Aspeed SoC used by the given BMC machine.
+ *
+ * The function assigns `serial_hd(0)` to the primary UART channel
+ * (either chosen via `bmc->uart_chosen` or the machine class default),
+ * and iteratively connects remaining serial ports to other available UARTs
+ * on the SoC based on their index.
+ */
+void aspeed_connect_serial_hds_to_uarts(AspeedMachineState *bmc);
+
 #endif
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 924c02bcb8c8..7e9cd532d136 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -118,7 +118,7 @@ static void sdhci_attach_drive(SDHCIState *sdhci, DriveInfo *dinfo, bool emmc,
                                &error_fatal);
 }
 
-static void connect_serial_hds_to_uarts(AspeedMachineState *bmc)
+void aspeed_connect_serial_hds_to_uarts(AspeedMachineState *bmc)
 {
     AspeedMachineClass *amc = ASPEED_MACHINE_GET_CLASS(bmc);
     AspeedSoCState *s = bmc->soc;
@@ -189,7 +189,7 @@ static void aspeed_machine_init(MachineState *machine)
         object_property_set_int(OBJECT(bmc->soc), "hw-prot-key",
                                 ASPEED_SCU_PROT_KEY, &error_abort);
     }
-    connect_serial_hds_to_uarts(bmc);
+    aspeed_connect_serial_hds_to_uarts(bmc);
     qdev_realize(DEVICE(bmc->soc), NULL, &error_abort);
 
     if (defaults_enabled()) {
@@ -444,7 +444,7 @@ static void aspeed_minibmc_machine_init(MachineState *machine)
 
     object_property_set_link(OBJECT(bmc->soc), "memory",
                              OBJECT(get_system_memory()), &error_abort);
-    connect_serial_hds_to_uarts(bmc);
+    aspeed_connect_serial_hds_to_uarts(bmc);
     qdev_realize(DEVICE(bmc->soc), NULL, &error_abort);
 
     if (defaults_enabled()) {
-- 
2.51.1


