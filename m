Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A6E2CD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 17:16:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMqhm-0007tU-6O; Tue, 12 May 2026 13:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wMqgb-0006nk-ML
 for qemu-devel@nongnu.org; Tue, 12 May 2026 13:14:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wMqgV-00010q-Dx
 for qemu-devel@nongnu.org; Tue, 12 May 2026 13:14:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778606058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mJSWxrK/DsrWExYq5kDHhvcdyrwDNbnw2tsgw3hDlWA=;
 b=NU2P/Z45vWSD/sTVv04FaqwwhebCVDa6VMqukjZu4VO+9auHQfAvOOmmm+Yd9uNsIlrXx5
 hc/LRAOr6utq4VHbtl4fAJmCPzMiDtH0tffEp4XYbfy1PsPKwV+htUBghPA020x/WFpx/v
 39rzyeWmYdeaEcoyrPRSVmF8AYPd6DU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-451-_q_2rmsvPiqF_DPl4-keCQ-1; Tue,
 12 May 2026 13:14:15 -0400
X-MC-Unique: _q_2rmsvPiqF_DPl4-keCQ-1
X-Mimecast-MFC-AGG-ID: _q_2rmsvPiqF_DPl4-keCQ_1778606054
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F19E180034E; Tue, 12 May 2026 17:14:14 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.49.156])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B00D61955D84; Tue, 12 May 2026 17:14:12 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 7/9] hw/arm: Remove fp5280g2-bmc machine
Date: Tue, 12 May 2026 19:13:52 +0200
Message-ID: <20260512171354.4183887-8-clg@redhat.com>
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

The fp5280g2-bmc machine was deprecated in QEMU 10.2 and is now
removed in QEMU 11.1.

This Inspur FP5280G2 BMC board does not rely on specific device models
and can be replaced by the ast2500-evb machine with appropriate
fmc-model and I2C device configuration via command line.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260510165704.2935316-4-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 docs/about/deprecated.rst        |  8 ---
 docs/about/removed-features.rst  |  8 +++
 docs/system/arm/aspeed.rst       |  5 +-
 hw/arm/aspeed_ast2500_fp5280g2.c | 88 --------------------------------
 hw/arm/meson.build               |  1 -
 5 files changed, 10 insertions(+), 100 deletions(-)
 delete mode 100644 hw/arm/aspeed_ast2500_fp5280g2.c

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index bbb4a9886fbc..e416f3d8a74b 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -250,14 +250,6 @@ deprecated; use the new name ``dtb-randomness`` instead. The new name
 better reflects the way this property affects all random data within
 the device tree blob, not just the ``kaslr-seed`` node.
 
-Arm ``fp5280g2-bmc`` machine (since 10.2)
-'''''''''''''''''''''''''''''''''''''''''
-
-The ``fp5280g2-bmc`` machine does not rely on any specific device
-models, it can be replaced by the ``ast2500-evb`` machine using the
-``fmc-model`` option to specify the flash type. The I2C devices
-connected to the board can be defined via the QEMU command line.
-
 Arm ``fby35`` machine (since 10.2)
 ''''''''''''''''''''''''''''''''''
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index b9e9d43dada3..2da8283d0e1e 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -1205,6 +1205,14 @@ machine using the ``fmc-model`` option to specify the flash type. The
 I2C devices connected to the board can be defined via the QEMU command
 line.
 
+Arm ``fp5280g2-bmc`` machine (removed in 11.1)
+''''''''''''''''''''''''''''''''''''''''''''''
+
+The ``fp5280g2-bmc`` machine does not rely on any specific device
+models, it can be replaced by the ``ast2500-evb`` machine using the
+``fmc-model`` option to specify the flash type. The I2C devices
+connected to the board can be defined via the QEMU command line.
+
 linux-user mode CPUs
 --------------------
 
diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst
index cbaab5edd65c..df2f539b0257 100644
--- a/docs/system/arm/aspeed.rst
+++ b/docs/system/arm/aspeed.rst
@@ -1,5 +1,5 @@
-Aspeed family boards (``ast2500-evb``, ``ast2600-evb``, ``bletchley-bmc``, ``fuji-bmc``, ``gb200nvl-bmc``, ``fby35-bmc``, ``fp5280g2-bmc``, ``g220a-bmc``, ``palmetto-bmc``, ``quanta-q71l-bmc``, ``rainier-bmc``, ``romulus-bmc``, ``supermicrox11-bmc``, ``supermicrox11spi-bmc``, ``tiogapass-bmc``, ``witherspoon-bmc``, ``yosemitev2-bmc``)
-================================================================================================================================================================================================================================================================================================================================================
+Aspeed family boards (``ast2500-evb``, ``ast2600-evb``, ``bletchley-bmc``, ``fuji-bmc``, ``gb200nvl-bmc``, ``fby35-bmc``, ``g220a-bmc``, ``palmetto-bmc``, ``quanta-q71l-bmc``, ``rainier-bmc``, ``romulus-bmc``, ``supermicrox11-bmc``, ``supermicrox11spi-bmc``, ``tiogapass-bmc``, ``witherspoon-bmc``, ``yosemitev2-bmc``)
+==============================================================================================================================================================================================================================================================================================================================
 
 The QEMU Aspeed machines model BMCs of various OpenPOWER systems and
 Aspeed evaluation boards. They are based on different releases of the
@@ -22,7 +22,6 @@ AST2500 SoC based machines :
 - ``ast2500-evb``          Aspeed AST2500 Evaluation board
 - ``romulus-bmc``          OpenPOWER Romulus POWER9 BMC
 - ``witherspoon-bmc``      OpenPOWER Witherspoon POWER9 BMC
-- ``fp5280g2-bmc``         Inspur FP5280G2 BMC
 - ``g220a-bmc``            Bytedance G220A BMC
 - ``yosemitev2-bmc``       Facebook YosemiteV2 BMC
 - ``tiogapass-bmc``        Facebook Tiogapass BMC
diff --git a/hw/arm/aspeed_ast2500_fp5280g2.c b/hw/arm/aspeed_ast2500_fp5280g2.c
deleted file mode 100644
index 858e0388714b..000000000000
--- a/hw/arm/aspeed_ast2500_fp5280g2.c
+++ /dev/null
@@ -1,88 +0,0 @@
-/*
- * Inspur FP5280G2
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
-#include "hw/nvram/eeprom_at24c.h"
-#include "hw/i2c/i2c_mux_pca954x.h"
-#include "hw/sensor/tmp105.h"
-
-/* FP5280G2 hardware value: 0XF100D286 */
-#define FP5280G2_BMC_HW_STRAP1 (                                      \
-        SCU_AST2500_HW_STRAP_SPI_AUTOFETCH_ENABLE |                     \
-        SCU_AST2500_HW_STRAP_GPIO_STRAP_ENABLE |                        \
-        SCU_AST2500_HW_STRAP_UART_DEBUG |                               \
-        SCU_AST2500_HW_STRAP_RESERVED28 |                               \
-        SCU_AST2500_HW_STRAP_DDR4_ENABLE |                              \
-        SCU_HW_STRAP_VGA_CLASS_CODE |                                   \
-        SCU_HW_STRAP_LPC_RESET_PIN |                                    \
-        SCU_HW_STRAP_SPI_MODE(SCU_HW_STRAP_SPI_MASTER) |                \
-        SCU_AST2500_HW_STRAP_SET_AXI_AHB_RATIO(AXI_AHB_RATIO_2_1) |     \
-        SCU_HW_STRAP_MAC1_RGMII |                                       \
-        SCU_HW_STRAP_VGA_SIZE_SET(VGA_16M_DRAM) |                       \
-        SCU_AST2500_HW_STRAP_RESERVED1)
-
-static void fp5280g2_bmc_i2c_init(AspeedMachineState *bmc)
-{
-    AspeedSoCState *soc = bmc->soc;
-    I2CSlave *i2c_mux;
-
-    /* The at24c256 */
-    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 1), 0x50, 32768);
-
-    /* The fp5280g2 expects a TMP112 but a TMP105 is compatible */
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2), TYPE_TMP105,
-                     0x48);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2), TYPE_TMP105,
-                     0x49);
-
-    i2c_mux = i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2),
-                     "pca9546", 0x70);
-    /* It expects a TMP112 but a TMP105 is compatible */
-    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 0), TYPE_TMP105,
-                     0x4a);
-
-    /* It expects a ds3232 but a ds1338 is good enough */
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4), "ds1338", 0x68);
-
-    /* It expects a pca9555 but a pca9552 is compatible */
-    aspeed_create_pca9552(soc, 8, 0x30);
-}
-
-static void aspeed_machine_fp5280g2_class_init(ObjectClass *oc,
-                                               const void *data)
-{
-    MachineClass *mc = MACHINE_CLASS(oc);
-    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
-
-    mc->desc       = "Inspur FP5280G2 BMC (ARM1176)";
-    mc->deprecation_reason = "use 'ast2500-evb' instead";
-    amc->soc_name  = "ast2500-a1";
-    amc->hw_strap1 = FP5280G2_BMC_HW_STRAP1;
-    amc->fmc_model = "n25q512a";
-    amc->spi_model = "mx25l25635e";
-    amc->num_cs    = 2;
-    amc->macs_mask  = ASPEED_MAC0_ON | ASPEED_MAC1_ON;
-    amc->i2c_init  = fp5280g2_bmc_i2c_init;
-    mc->default_ram_size = 512 * MiB;
-    aspeed_machine_class_init_cpus_defaults(mc);
-};
-
-static const TypeInfo aspeed_ast2500_fp5280g2_types[] = {
-    {
-        .name          = MACHINE_TYPE_NAME("fp5280g2-bmc"),
-        .parent        = TYPE_ASPEED_MACHINE,
-        .class_init    = aspeed_machine_fp5280g2_class_init,
-        .interfaces    = arm_machine_interfaces,
-    }
-};
-
-DEFINE_TYPES(aspeed_ast2500_fp5280g2_types)
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 2be74b575efc..063abf2cf654 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -47,7 +47,6 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed_ast2400_quanta-q71l.c',
   'aspeed_ast2400_supermicrox11.c',
   'aspeed_ast2500_evb.c',
-  'aspeed_ast2500_fp5280g2.c',
   'aspeed_ast2500_g220a.c',
   'aspeed_ast2500_romulus.c',
   'aspeed_ast2500_supermicro-x11spi.c',
-- 
2.54.0


