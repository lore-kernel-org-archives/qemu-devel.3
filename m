Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA741CCF9F8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 03:19:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG7Yu-0002JW-2P; Mon, 03 Nov 2025 22:18:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vG7Wm-00087Q-9n; Mon, 03 Nov 2025 22:16:15 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vG7Wk-0004m7-63; Mon, 03 Nov 2025 22:16:12 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 4 Nov
 2025 11:13:44 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 4 Nov 2025 11:13:44 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>
Subject: [PATCH v4 29/30] hw/arm/aspeed: Rename and export
 connect_serial_hds_to_uarts() as aspeed_connect_serial_hds_to_uarts()
Date: Tue, 4 Nov 2025 11:13:07 +0800
Message-ID: <20251104031325.146374-30-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251104031325.146374-1-jamin_lin@aspeedtech.com>
References: <20251104031325.146374-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_FAIL=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

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
---
 include/hw/arm/aspeed.h | 14 ++++++++++++++
 hw/arm/aspeed.c         |  6 +++---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
index 87dcadab26..714bbd326c 100644
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
index 924c02bcb8..7e9cd532d1 100644
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
2.43.0


