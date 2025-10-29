Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B716CCF9E9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 04:38:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDxwL-00079B-P1; Wed, 29 Oct 2025 00:37:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vDxwJ-00077l-EV; Wed, 29 Oct 2025 00:37:39 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vDxwB-0004M3-7y; Wed, 29 Oct 2025 00:37:39 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 29 Oct
 2025 12:37:11 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 29 Oct 2025 12:37:11 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>
Subject: [PATCH v2 01/17] hw/arm/aspeed: Split Quanta-Q71L machine into a
 separate source file for maintainability
Date: Wed, 29 Oct 2025 12:36:47 +0800
Message-ID: <20251029043710.1486573-2-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251029043710.1486573-1-jamin_lin@aspeedtech.com>
References: <20251029043710.1486573-1-jamin_lin@aspeedtech.com>
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

This commit moves the Quanta-Q71L BMC machine implementation out of
aspeed.c into a new standalone file aspeed_ast2400_quanta-q71l.c.

This refactor continues the modularization effort for Aspeed platform
support, placing each board’s logic in its own dedicated source file.
It improves maintainability, readability, and simplifies future
development for new platforms without cluttering aspeed.c

Key updates include:

- Removed QUANTA_Q71L_BMC_HW_STRAP1 macro definition from aspeed.c.
- Moved quanta_q71l_bmc_i2c_init() I²C initialization logic into the new file.
- Moved aspeed_machine_quanta_q71l_class_init() and type registration.
- Added aspeed_ast2400_quanta-q71l.c to the build system (meson.build).
- Removed all Quanta-Q71L–specific code and macros from aspeed.c.

No functional changes.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/arm/aspeed.c                     | 66 ----------------------
 hw/arm/aspeed_ast2400_quanta-q71l.c | 85 +++++++++++++++++++++++++++++
 hw/arm/meson.build                  |  1 +
 3 files changed, 86 insertions(+), 66 deletions(-)
 create mode 100644 hw/arm/aspeed_ast2400_quanta-q71l.c

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 11c74c3e1b..3eb1d19373 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -70,19 +70,6 @@ static struct arm_boot_info aspeed_board_binfo = {
         SCU_HW_STRAP_VGA_SIZE_SET(VGA_16M_DRAM) |                       \
         SCU_AST2400_HW_STRAP_BOOT_MODE(AST2400_SPI_BOOT))
 
-/* Quanta-Q71l hardware value */
-#define QUANTA_Q71L_BMC_HW_STRAP1 (                                     \
-        SCU_AST2400_HW_STRAP_DRAM_SIZE(DRAM_SIZE_128MB) |               \
-        SCU_AST2400_HW_STRAP_DRAM_CONFIG(2/* DDR3 with CL=6, CWL=5 */) | \
-        SCU_AST2400_HW_STRAP_ACPI_DIS |                                 \
-        SCU_AST2400_HW_STRAP_SET_CLK_SOURCE(AST2400_CLK_24M_IN) |       \
-        SCU_HW_STRAP_VGA_CLASS_CODE |                                   \
-        SCU_HW_STRAP_SPI_MODE(SCU_HW_STRAP_SPI_PASS_THROUGH) |          \
-        SCU_AST2400_HW_STRAP_SET_CPU_AHB_RATIO(AST2400_CPU_AHB_RATIO_2_1) | \
-        SCU_HW_STRAP_SPI_WIDTH |                                        \
-        SCU_HW_STRAP_VGA_SIZE_SET(VGA_8M_DRAM) |                        \
-        SCU_AST2400_HW_STRAP_BOOT_MODE(AST2400_SPI_BOOT))
-
 /* AST2600 evb hardware value */
 #define AST2600_EVB_HW_STRAP1 0x000000C0
 #define AST2600_EVB_HW_STRAP2 0x00000003
@@ -362,38 +349,6 @@ static void palmetto_bmc_i2c_init(AspeedMachineState *bmc)
     object_property_set_int(OBJECT(dev), "temperature3", 110000, &error_abort);
 }
 
-static void quanta_q71l_bmc_i2c_init(AspeedMachineState *bmc)
-{
-    AspeedSoCState *soc = bmc->soc;
-
-    /*
-     * The quanta-q71l platform expects tmp75s which are compatible with
-     * tmp105s.
-     */
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 1), "tmp105", 0x4c);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 1), "tmp105", 0x4e);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 1), "tmp105", 0x4f);
-
-    /* TODO: i2c-1: Add baseboard FRU eeprom@54 24c64 */
-    /* TODO: i2c-1: Add Frontpanel FRU eeprom@57 24c64 */
-    /* TODO: Add Memory Riser i2c mux and eeproms. */
-
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2), "pca9546", 0x74);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2), "pca9548", 0x77);
-
-    /* TODO: i2c-3: Add BIOS FRU eeprom@56 24c64 */
-
-    /* i2c-7 */
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7), "pca9546", 0x70);
-    /*        - i2c@0: pmbus@59 */
-    /*        - i2c@1: pmbus@58 */
-    /*        - i2c@2: pmbus@58 */
-    /*        - i2c@3: pmbus@59 */
-
-    /* TODO: i2c-7: Add PDB FRU eeprom@52 */
-    /* TODO: i2c-8: Add BMC FRU eeprom@50 */
-}
-
 static void ast2600_evb_i2c_init(AspeedMachineState *bmc)
 {
     AspeedSoCState *soc = bmc->soc;
@@ -1117,23 +1072,6 @@ static void aspeed_machine_palmetto_class_init(ObjectClass *oc,
     aspeed_machine_class_init_cpus_defaults(mc);
 };
 
-static void aspeed_machine_quanta_q71l_class_init(ObjectClass *oc,
-                                                  const void *data)
-{
-    MachineClass *mc = MACHINE_CLASS(oc);
-    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
-
-    mc->desc       = "Quanta-Q71l BMC (ARM926EJ-S)";
-    amc->soc_name  = "ast2400-a1";
-    amc->hw_strap1 = QUANTA_Q71L_BMC_HW_STRAP1;
-    amc->fmc_model = "n25q256a";
-    amc->spi_model = "mx25l25635e";
-    amc->num_cs    = 1;
-    amc->i2c_init  = quanta_q71l_bmc_i2c_init;
-    mc->default_ram_size       = 128 * MiB;
-    aspeed_machine_class_init_cpus_defaults(mc);
-}
-
 static void aspeed_machine_supermicrox11_bmc_class_init(ObjectClass *oc,
                                                         const void *data)
 {
@@ -1517,10 +1455,6 @@ static const TypeInfo aspeed_machine_types[] = {
         .name          = MACHINE_TYPE_NAME("qcom-firework-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_qcom_firework_class_init,
-    }, {
-        .name          = MACHINE_TYPE_NAME("quanta-q71l-bmc"),
-        .parent        = TYPE_ASPEED_MACHINE,
-        .class_init    = aspeed_machine_quanta_q71l_class_init,
     }, {
         .name          = MACHINE_TYPE_NAME("rainier-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
diff --git a/hw/arm/aspeed_ast2400_quanta-q71l.c b/hw/arm/aspeed_ast2400_quanta-q71l.c
new file mode 100644
index 0000000000..cda0406ace
--- /dev/null
+++ b/hw/arm/aspeed_ast2400_quanta-q71l.c
@@ -0,0 +1,85 @@
+/*
+ * Quanta Q71l
+ *
+ * Copyright (C) 2025 ASPEED Technology Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/arm/aspeed.h"
+#include "hw/arm/aspeed_soc.h"
+
+/* Quanta-Q71l hardware value */
+#define QUANTA_Q71L_BMC_HW_STRAP1 (                                     \
+        SCU_AST2400_HW_STRAP_DRAM_SIZE(DRAM_SIZE_128MB) |               \
+        SCU_AST2400_HW_STRAP_DRAM_CONFIG(2/* DDR3 with CL=6, CWL=5 */) | \
+        SCU_AST2400_HW_STRAP_ACPI_DIS |                                 \
+        SCU_AST2400_HW_STRAP_SET_CLK_SOURCE(AST2400_CLK_24M_IN) |       \
+        SCU_HW_STRAP_VGA_CLASS_CODE |                                   \
+        SCU_HW_STRAP_SPI_MODE(SCU_HW_STRAP_SPI_PASS_THROUGH) |          \
+        SCU_AST2400_HW_STRAP_SET_CPU_AHB_RATIO(AST2400_CPU_AHB_RATIO_2_1) | \
+        SCU_HW_STRAP_SPI_WIDTH |                                        \
+        SCU_HW_STRAP_VGA_SIZE_SET(VGA_8M_DRAM) |                        \
+        SCU_AST2400_HW_STRAP_BOOT_MODE(AST2400_SPI_BOOT))
+
+static void quanta_q71l_bmc_i2c_init(AspeedMachineState *bmc)
+{
+    AspeedSoCState *soc = bmc->soc;
+
+    /*
+     * The quanta-q71l platform expects tmp75s which are compatible with
+     * tmp105s.
+     */
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 1), "tmp105", 0x4c);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 1), "tmp105", 0x4e);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 1), "tmp105", 0x4f);
+
+    /* TODO: i2c-1: Add baseboard FRU eeprom@54 24c64 */
+    /* TODO: i2c-1: Add Frontpanel FRU eeprom@57 24c64 */
+    /* TODO: Add Memory Riser i2c mux and eeproms. */
+
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2), "pca9546", 0x74);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2), "pca9548", 0x77);
+
+    /* TODO: i2c-3: Add BIOS FRU eeprom@56 24c64 */
+
+    /* i2c-7 */
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7), "pca9546", 0x70);
+    /*        - i2c@0: pmbus@59 */
+    /*        - i2c@1: pmbus@58 */
+    /*        - i2c@2: pmbus@58 */
+    /*        - i2c@3: pmbus@59 */
+
+    /* TODO: i2c-7: Add PDB FRU eeprom@52 */
+    /* TODO: i2c-8: Add BMC FRU eeprom@50 */
+}
+
+static void aspeed_machine_quanta_q71l_class_init(ObjectClass *oc,
+                                                  const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
+
+    mc->desc       = "Quanta-Q71l BMC (ARM926EJ-S)";
+    amc->soc_name  = "ast2400-a1";
+    amc->hw_strap1 = QUANTA_Q71L_BMC_HW_STRAP1;
+    amc->fmc_model = "n25q256a";
+    amc->spi_model = "mx25l25635e";
+    amc->num_cs    = 1;
+    amc->i2c_init  = quanta_q71l_bmc_i2c_init;
+    mc->default_ram_size       = 128 * MiB;
+    aspeed_machine_class_init_cpus_defaults(mc);
+}
+
+static const TypeInfo aspeed_ast2400_quanta_q71l_types[] = {
+    {
+        .name          = MACHINE_TYPE_NAME("quanta-q71l-bmc"),
+        .parent        = TYPE_ASPEED_MACHINE,
+        .class_init    = aspeed_machine_quanta_q71l_class_init,
+    }
+};
+
+DEFINE_TYPES(aspeed_ast2400_quanta_q71l_types)
+
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index cbee7ebf60..4475807e11 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -44,6 +44,7 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed.c',
   'aspeed_soc_common.c',
   'aspeed_ast2400.c',
+  'aspeed_ast2400_quanta-q71l.c',
   'aspeed_ast2500_evb.c',
   'aspeed_ast2500_fp5280g2.c',
   'aspeed_ast2500_g220a.c',
-- 
2.43.0


