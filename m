Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99253CCFA03
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 09:29:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFqre-0000m4-1c; Mon, 03 Nov 2025 04:28:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vFqrZ-0000kp-HS; Mon, 03 Nov 2025 04:28:34 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vFqrV-0001r9-Ed; Mon, 03 Nov 2025 04:28:33 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 3 Nov
 2025 17:28:04 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 3 Nov 2025 17:28:04 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>
Subject: [PATCH v3 04/30] hw/arm/aspeed: Rename and export create_pca9554() as
 aspeed_create_pca9554()
Date: Mon, 3 Nov 2025 17:27:15 +0800
Message-ID: <20251103092801.1282602-5-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251103092801.1282602-1-jamin_lin@aspeedtech.com>
References: <20251103092801.1282602-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

The helper function create_pca9554() has been renamed to
aspeed_create_pca9554() and made globally available.

Previously, the function was declared static inside aspeed.c, restricting
its visibility to that file. As more Aspeed machine implementations
require PCA9554 I²C expander setup, it makes sense to rename it with the
aspeed_ prefix and export its declaration in aspeed.h for shared use.

No functional changes.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 include/hw/arm/aspeed.h | 14 ++++++++++++++
 hw/arm/aspeed.c         |  8 ++++----
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
index 3afb964088..d2d9e49a39 100644
--- a/include/hw/arm/aspeed.h
+++ b/include/hw/arm/aspeed.h
@@ -80,4 +80,18 @@ void aspeed_machine_class_init_cpus_defaults(MachineClass *mc);
  */
 void aspeed_create_pca9552(AspeedSoCState *soc, int bus_id, int addr);
 
+/*
+ * aspeed_create_pca9554:
+ * @soc: pointer to the #AspeedSoCState.
+ * @bus_id: the I²C bus index to attach the device.
+ * @addr: the I²C address of the PCA9554 device.
+ *
+ * Create and attach a PCA9554 I/O expander to the specified I²C bus
+ * of the given Aspeed SoC. The device is created via
+ * i2c_slave_create_simple() and returned as an #I2CSlave pointer.
+ *
+ * Returns: a pointer to the newly created #I2CSlave instance.
+ */
+I2CSlave *aspeed_create_pca9554(AspeedSoCState *soc, int bus_id, int addr);
+
 #endif
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index c6f272d986..59416eb5ae 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -543,7 +543,7 @@ void aspeed_create_pca9552(AspeedSoCState *soc, int bus_id, int addr)
                             TYPE_PCA9552, addr);
 }
 
-static I2CSlave *create_pca9554(AspeedSoCState *soc, int bus_id, int addr)
+I2CSlave *aspeed_create_pca9554(AspeedSoCState *soc, int bus_id, int addr)
 {
     return i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, bus_id),
                             TYPE_PCA9554, addr);
@@ -1142,7 +1142,7 @@ static void gb200nvl_bmc_i2c_init(AspeedMachineState *bmc)
     }
 
     /* Bus 5 Expander */
-    create_pca9554(soc, 4, 0x21);
+    aspeed_create_pca9554(soc, 4, 0x21);
 
     /* Mux I2c Expanders */
     i2c_slave_create_simple(i2c[5], "pca9546", 0x71);
@@ -1153,12 +1153,12 @@ static void gb200nvl_bmc_i2c_init(AspeedMachineState *bmc)
     i2c_slave_create_simple(i2c[5], "pca9546", 0x77);
 
     /* Bus 10 */
-    dev = DEVICE(create_pca9554(soc, 9, 0x20));
+    dev = DEVICE(aspeed_create_pca9554(soc, 9, 0x20));
 
     /* Set FPGA_READY */
     object_property_set_str(OBJECT(dev), "pin1", "high", &error_fatal);
 
-    create_pca9554(soc, 9, 0x21);
+    aspeed_create_pca9554(soc, 9, 0x21);
     at24c_eeprom_init(i2c[9], 0x50, 64 * KiB);
     at24c_eeprom_init(i2c[9], 0x51, 64 * KiB);
 
-- 
2.43.0


