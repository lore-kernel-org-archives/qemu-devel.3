Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F3D7CD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 17:16:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMqhl-0007oz-KX; Tue, 12 May 2026 13:15:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wMqgb-0006nf-9q
 for qemu-devel@nongnu.org; Tue, 12 May 2026 13:14:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wMqgS-0000vC-4t
 for qemu-devel@nongnu.org; Tue, 12 May 2026 13:14:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778606053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qIWlUGQItg/GXf15TcEdgeYx061cCYRWPjXLhRieIw0=;
 b=LOpR+U1g1MdTOtpxEBVie++nUuWnzzUeaq2O3n4/E0tosDjLfTz7D6k9YlBoyPQ6+oSbiN
 lnHdSYk1/qMi4kueF6d/+v4LVcPxVVV7JZZf2fGqJP8FedCmeAOJ2RHvN12uN2Agjsi5Bs
 DzlLakF5m9lUUSHkZi9RgpsRa1la4SU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-413-BvQoL9OYMcqVV3CmVKWaTg-1; Tue,
 12 May 2026 13:14:11 -0400
X-MC-Unique: BvQoL9OYMcqVV3CmVKWaTg-1
X-Mimecast-MFC-AGG-ID: BvQoL9OYMcqVV3CmVKWaTg_1778606050
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 38ECF180062E; Tue, 12 May 2026 17:14:10 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.49.156])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AF93A1953947; Tue, 12 May 2026 17:14:08 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 5/9] hw/arm: Remove sonorapass-bmc machine
Date: Tue, 12 May 2026 19:13:50 +0200
Message-ID: <20260512171354.4183887-6-clg@redhat.com>
In-Reply-To: <20260512171354.4183887-1-clg@redhat.com>
References: <20260512171354.4183887-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The sonorapass-bmc machine was deprecated in QEMU 10.2 and is now
removed in QEMU 11.1.

This OCP SonoraPass BMC lab server never entered production and can be
replaced by the ast2500-evb machine with appropriate fmc-model and I2C
device configuration via command line.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260510165704.2935316-2-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 docs/about/deprecated.rst          |   9 ---
 docs/about/removed-features.rst    |  10 ++-
 docs/system/arm/aspeed.rst         |   5 +-
 hw/arm/aspeed_ast2500_sonorapass.c | 102 -----------------------------
 hw/arm/meson.build                 |   1 -
 5 files changed, 11 insertions(+), 116 deletions(-)
 delete mode 100644 hw/arm/aspeed_ast2500_sonorapass.c

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 5551bd12ad83..cc75afe55d95 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -250,15 +250,6 @@ deprecated; use the new name ``dtb-randomness`` instead. The new name
 better reflects the way this property affects all random data within
 the device tree blob, not just the ``kaslr-seed`` node.
 
-Arm ``sonorapass-bmc`` machine (since 10.2)
-'''''''''''''''''''''''''''''''''''''''''''
-
-The ``sonorapass-bmc`` machine represents a lab server that never
-entered production. Since it does not rely on any specific device
-models, it can be replaced by the ``ast2500-evb`` machine using the
-``fmc-model`` option to specify the flash type. The I2C devices
-connected to the board can be defined via the QEMU command line.
-
 Arm ``qcom-dc-scm-v1-bmc`` and ``qcom-firework-bmc`` machine (since 10.2)
 '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 626162022a8c..02e3c06b2988 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -1112,7 +1112,7 @@ This machine was removed because it was unused. Alternative AST2500 based
 OpenPOWER machines are ``witherspoon-bmc`` and ``romulus-bmc``.
 
 ppc ``taihu`` machine (removed in 7.2)
-'''''''''''''''''''''''''''''''''''''''''''''
+''''''''''''''''''''''''''''''''''''''
 
 This machine was removed because it was partially emulated and 405
 machines are very similar. Use the ``ref405ep`` machine instead.
@@ -1186,6 +1186,14 @@ Arm ``highbank`` and ``midway`` machines (removed in 11.0)
 There were no known users left for these machines. If you just want to
 boot a Cortex-A15 or Cortex-A9 Linux, use the ``virt`` machine instead.
 
+Arm ``sonorapass-bmc`` machine (removed in 11.1)
+''''''''''''''''''''''''''''''''''''''''''''''''
+
+The ``sonorapass-bmc`` machine represents a lab server that never
+entered production. It can be replaced by the ``ast2500-evb`` machine
+using the ``fmc-model`` option to specify the flash type. The I2C
+devices connected to the board can be defined via the QEMU command
+line.
 
 linux-user mode CPUs
 --------------------
diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst
index d0054a7dbb88..1871f31713d4 100644
--- a/docs/system/arm/aspeed.rst
+++ b/docs/system/arm/aspeed.rst
@@ -1,5 +1,5 @@
-Aspeed family boards (``ast2500-evb``, ``ast2600-evb``, ``bletchley-bmc``, ``fuji-bmc``, ``gb200nvl-bmc``, ``fby35-bmc``, ``fp5280g2-bmc``, ``g220a-bmc``, ``palmetto-bmc``, ``qcom-dc-scm-v1-bmc``, ``qcom-firework-bmc``, ``quanta-q71l-bmc``, ``rainier-bmc``, ``romulus-bmc``, ``sonorapass-bmc``, ``supermicrox11-bmc``, ``supermicrox11spi-bmc``, ``tiogapass-bmc``, ``witherspoon-bmc``, ``yosemitev2-bmc``)
-===================================================================================================================================================================================================================================================================================================================================================================================================================
+Aspeed family boards (``ast2500-evb``, ``ast2600-evb``, ``bletchley-bmc``, ``fuji-bmc``, ``gb200nvl-bmc``, ``fby35-bmc``, ``fp5280g2-bmc``, ``g220a-bmc``, ``palmetto-bmc``, ``qcom-dc-scm-v1-bmc``, ``qcom-firework-bmc``, ``quanta-q71l-bmc``, ``rainier-bmc``, ``romulus-bmc``, ``supermicrox11-bmc``, ``supermicrox11spi-bmc``, ``tiogapass-bmc``, ``witherspoon-bmc``, ``yosemitev2-bmc``)
+===============================================================================================================================================================================================================================================================================================================================================================================================
 
 The QEMU Aspeed machines model BMCs of various OpenPOWER systems and
 Aspeed evaluation boards. They are based on different releases of the
@@ -22,7 +22,6 @@ AST2500 SoC based machines :
 - ``ast2500-evb``          Aspeed AST2500 Evaluation board
 - ``romulus-bmc``          OpenPOWER Romulus POWER9 BMC
 - ``witherspoon-bmc``      OpenPOWER Witherspoon POWER9 BMC
-- ``sonorapass-bmc``       OCP SonoraPass BMC
 - ``fp5280g2-bmc``         Inspur FP5280G2 BMC
 - ``g220a-bmc``            Bytedance G220A BMC
 - ``yosemitev2-bmc``       Facebook YosemiteV2 BMC
diff --git a/hw/arm/aspeed_ast2500_sonorapass.c b/hw/arm/aspeed_ast2500_sonorapass.c
deleted file mode 100644
index 84de4f56b376..000000000000
--- a/hw/arm/aspeed_ast2500_sonorapass.c
+++ /dev/null
@@ -1,102 +0,0 @@
-/*
- * OCP SonoraPass
- *
- * Copyright 2016 IBM Corp.
- *
- * SPDX-License-Identifier: GPL-2.0-or-later
- */
-
-#include "qemu/osdep.h"
-#include "qapi/error.h"
-#include "hw/arm/machines-qom.h"
-#include "hw/arm/aspeed.h"
-#include "hw/arm/aspeed_soc.h"
-#include "hw/i2c/smbus_eeprom.h"
-
-/* Sonorapass hardware value: 0xF100D216 */
-#define SONORAPASS_BMC_HW_STRAP1 (                                      \
-        SCU_AST2500_HW_STRAP_SPI_AUTOFETCH_ENABLE |                     \
-        SCU_AST2500_HW_STRAP_GPIO_STRAP_ENABLE |                        \
-        SCU_AST2500_HW_STRAP_UART_DEBUG |                               \
-        SCU_AST2500_HW_STRAP_RESERVED28 |                               \
-        SCU_AST2500_HW_STRAP_DDR4_ENABLE |                              \
-        SCU_HW_STRAP_VGA_CLASS_CODE |                                   \
-        SCU_HW_STRAP_LPC_RESET_PIN |                                    \
-        SCU_HW_STRAP_SPI_MODE(SCU_HW_STRAP_SPI_MASTER) |                \
-        SCU_AST2500_HW_STRAP_SET_AXI_AHB_RATIO(AXI_AHB_RATIO_2_1) |     \
-        SCU_HW_STRAP_VGA_BIOS_ROM |                                     \
-        SCU_HW_STRAP_VGA_SIZE_SET(VGA_16M_DRAM) |                       \
-        SCU_AST2500_HW_STRAP_RESERVED1)
-
-static void sonorapass_bmc_i2c_init(AspeedMachineState *bmc)
-{
-    AspeedSoCState *soc = bmc->soc;
-
-    /* bus 2 : */
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2), "tmp105", 0x48);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2), "tmp105", 0x49);
-    /* bus 2 : pca9546 @ 0x73 */
-
-    /* bus 3 : pca9548 @ 0x70 */
-
-    /* bus 4 : */
-    uint8_t *eeprom4_54 = g_malloc0(8 * 1024);
-    smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 4), 0x54,
-                          eeprom4_54);
-    /* PCA9539 @ 0x76, but PCA9552 is compatible */
-    aspeed_create_pca9552(soc, 4, 0x76);
-    /* PCA9539 @ 0x77, but PCA9552 is compatible */
-    aspeed_create_pca9552(soc, 4, 0x77);
-
-    /* bus 6 : */
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6), "tmp105", 0x48);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6), "tmp105", 0x49);
-    /* bus 6 : pca9546 @ 0x73 */
-
-    /* bus 8 : */
-    uint8_t *eeprom8_56 = g_malloc0(8 * 1024);
-    smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 8), 0x56,
-                          eeprom8_56);
-    aspeed_create_pca9552(soc, 8, 0x60);
-    aspeed_create_pca9552(soc, 8, 0x61);
-    /* bus 8 : adc128d818 @ 0x1d */
-    /* bus 8 : adc128d818 @ 0x1f */
-
-    /*
-     * bus 13 : pca9548 @ 0x71
-     *      - channel 3:
-     *          - tmm421 @ 0x4c
-     *          - tmp421 @ 0x4e
-     *          - tmp421 @ 0x4f
-     */
-
-}
-
-static void aspeed_machine_sonorapass_class_init(ObjectClass *oc,
-                                                 const void *data)
-{
-    MachineClass *mc = MACHINE_CLASS(oc);
-    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
-
-    mc->desc       = "OCP SonoraPass BMC (ARM1176)";
-    mc->deprecation_reason = "use 'ast2500-evb' instead";
-    amc->soc_name  = "ast2500-a1";
-    amc->hw_strap1 = SONORAPASS_BMC_HW_STRAP1;
-    amc->fmc_model = "mx66l1g45g";
-    amc->spi_model = "mx66l1g45g";
-    amc->num_cs    = 2;
-    amc->i2c_init  = sonorapass_bmc_i2c_init;
-    mc->default_ram_size       = 512 * MiB;
-    aspeed_machine_class_init_cpus_defaults(mc);
-};
-
-static const TypeInfo aspeed_ast2500_sonorapass_types[] = {
-    {
-        .name          = MACHINE_TYPE_NAME("sonorapass-bmc"),
-        .parent        = TYPE_ASPEED_MACHINE,
-        .class_init    = aspeed_machine_sonorapass_class_init,
-        .interfaces    = arm_machine_interfaces,
-    }
-};
-
-DEFINE_TYPES(aspeed_ast2500_sonorapass_types)
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 84b8ec5fb5ab..098015357ddc 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -50,7 +50,6 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed_ast2500_fp5280g2.c',
   'aspeed_ast2500_g220a.c',
   'aspeed_ast2500_romulus.c',
-  'aspeed_ast2500_sonorapass.c',
   'aspeed_ast2500_supermicro-x11spi.c',
   'aspeed_ast2500_tiogapass.c',
   'aspeed_ast2500_witherspoon.c',
-- 
2.54.0


