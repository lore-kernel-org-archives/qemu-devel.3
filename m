Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F7DBCD37B2
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 16:58:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wM7TD-0007it-Cs; Sun, 10 May 2026 12:57:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wM7TB-0007iG-7e
 for qemu-devel@nongnu.org; Sun, 10 May 2026 12:57:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wM7T8-0008JS-IW
 for qemu-devel@nongnu.org; Sun, 10 May 2026 12:57:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778432249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=42IX29jwlVzKy/Bw9Kvk0U3cZzFRJ3xq+hDR5pmyoT8=;
 b=JtmRa/M3Upa5HyxXX9X+v34HiZDnjVJnlMV9ZdJet9R3ehmpZqH7wTwXsUOgvA7feP+FBm
 fhyEleMB9pP1LAEaNEE5BcUcNHZooAZbn32d/p73YTlH1pN0c86gl4TLSjKPm9U3nlKHjv
 8dBFFG6/gF/wl1SA0vtxksTE+hemK6E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-531-tEICY0BSP4Wqbzo2UpS16A-1; Sun,
 10 May 2026 12:57:23 -0400
X-MC-Unique: tEICY0BSP4Wqbzo2UpS16A-1
X-Mimecast-MFC-AGG-ID: tEICY0BSP4Wqbzo2UpS16A_1778432242
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DDB3C1800451; Sun, 10 May 2026 16:57:21 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.49.156])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 521771800465; Sun, 10 May 2026 16:57:17 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 pierrick.bouvier@oss.qualcomm.com
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, kane_chen@aspeedtech.com,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 2/4] hw/arm: Remove qcom-dc-scm-v1-bmc and qcom-firework-bmc
 machines
Date: Sun, 10 May 2026 18:57:02 +0200
Message-ID: <20260510165704.2935316-3-clg@redhat.com>
In-Reply-To: <20260510165704.2935316-1-clg@redhat.com>
References: <20260510165704.2935316-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The qcom-dc-scm-v1-bmc and qcom-firework-bmc machines were deprecated
in QEMU 10.2 and are now removed in QEMU 11.1.

These Qualcomm lab servers never entered production and do not rely on
specific device models. They can be replaced by the ast2600-evb
machine with appropriate fmc-model and I2C device configuration via
command line.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 docs/about/deprecated.rst              | 10 ---
 docs/about/removed-features.rst        | 10 +++
 docs/system/arm/aspeed.rst             |  6 +-
 hw/arm/aspeed_ast2600_qcom-dc-scm-v1.c | 55 ----------------
 hw/arm/aspeed_ast2600_qcom-firework.c  | 91 --------------------------
 hw/arm/meson.build                     |  2 -
 6 files changed, 12 insertions(+), 162 deletions(-)
 delete mode 100644 hw/arm/aspeed_ast2600_qcom-dc-scm-v1.c
 delete mode 100644 hw/arm/aspeed_ast2600_qcom-firework.c

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index cc75afe55d95..bbb4a9886fbc 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -250,16 +250,6 @@ deprecated; use the new name ``dtb-randomness`` instead. The new name
 better reflects the way this property affects all random data within
 the device tree blob, not just the ``kaslr-seed`` node.
 
-Arm ``qcom-dc-scm-v1-bmc`` and ``qcom-firework-bmc`` machine (since 10.2)
-'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
-
-The ``qcom-dc-scm-v1-bmc`` and ``qcom-firework-bmc`` represent lab
-servers that never entered production. Since they do not rely on any
-specific device models, they can be replaced by the ``ast2600-evb``
-machine using the ``fmc-model`` option to specify the flash type. The
-I2C devices connected to the board can be defined via the QEMU command
-line.
-
 Arm ``fp5280g2-bmc`` machine (since 10.2)
 '''''''''''''''''''''''''''''''''''''''''
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 02e3c06b2988..b9e9d43dada3 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -1195,6 +1195,16 @@ using the ``fmc-model`` option to specify the flash type. The I2C
 devices connected to the board can be defined via the QEMU command
 line.
 
+Arm ``qcom-dc-scm-v1-bmc`` and ``qcom-firework-bmc`` machine (removed in 11.1)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+The ``qcom-dc-scm-v1-bmc`` and ``qcom-firework-bmc`` represent lab
+servers that never entered production. Since they do not rely on any
+specific device models, they can be replaced by the ``ast2600-evb``
+machine using the ``fmc-model`` option to specify the flash type. The
+I2C devices connected to the board can be defined via the QEMU command
+line.
+
 linux-user mode CPUs
 --------------------
 
diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst
index 1871f31713d4..cbaab5edd65c 100644
--- a/docs/system/arm/aspeed.rst
+++ b/docs/system/arm/aspeed.rst
@@ -1,5 +1,5 @@
-Aspeed family boards (``ast2500-evb``, ``ast2600-evb``, ``bletchley-bmc``, ``fuji-bmc``, ``gb200nvl-bmc``, ``fby35-bmc``, ``fp5280g2-bmc``, ``g220a-bmc``, ``palmetto-bmc``, ``qcom-dc-scm-v1-bmc``, ``qcom-firework-bmc``, ``quanta-q71l-bmc``, ``rainier-bmc``, ``romulus-bmc``, ``supermicrox11-bmc``, ``supermicrox11spi-bmc``, ``tiogapass-bmc``, ``witherspoon-bmc``, ``yosemitev2-bmc``)
-===============================================================================================================================================================================================================================================================================================================================================================================================
+Aspeed family boards (``ast2500-evb``, ``ast2600-evb``, ``bletchley-bmc``, ``fuji-bmc``, ``gb200nvl-bmc``, ``fby35-bmc``, ``fp5280g2-bmc``, ``g220a-bmc``, ``palmetto-bmc``, ``quanta-q71l-bmc``, ``rainier-bmc``, ``romulus-bmc``, ``supermicrox11-bmc``, ``supermicrox11spi-bmc``, ``tiogapass-bmc``, ``witherspoon-bmc``, ``yosemitev2-bmc``)
+================================================================================================================================================================================================================================================================================================================================================
 
 The QEMU Aspeed machines model BMCs of various OpenPOWER systems and
 Aspeed evaluation boards. They are based on different releases of the
@@ -35,8 +35,6 @@ AST2600 SoC based machines :
 - ``bletchley-bmc``        Facebook Bletchley BMC
 - ``fby35-bmc``            Facebook fby35 BMC
 - ``gb200nvl-bmc``         Nvidia GB200nvl BMC
-- ``qcom-dc-scm-v1-bmc``   Qualcomm DC-SCM V1 BMC
-- ``qcom-firework-bmc``    Qualcomm Firework BMC
 
 Supported devices
 -----------------
diff --git a/hw/arm/aspeed_ast2600_qcom-dc-scm-v1.c b/hw/arm/aspeed_ast2600_qcom-dc-scm-v1.c
deleted file mode 100644
index bbdeb6023686..000000000000
--- a/hw/arm/aspeed_ast2600_qcom-dc-scm-v1.c
+++ /dev/null
@@ -1,55 +0,0 @@
-/*
- * Qualcomm DC-SCM V1
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
-
-/* Qualcomm DC-SCM hardware value */
-#define QCOM_DC_SCM_V1_BMC_HW_STRAP1  0x00000000
-#define QCOM_DC_SCM_V1_BMC_HW_STRAP2  0x00000041
-
-static void qcom_dc_scm_bmc_i2c_init(AspeedMachineState *bmc)
-{
-    AspeedSoCState *soc = bmc->soc;
-
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 15), "tmp105", 0x4d);
-}
-
-static void aspeed_machine_qcom_dc_scm_v1_class_init(ObjectClass *oc,
-                                                     const void *data)
-{
-    MachineClass *mc = MACHINE_CLASS(oc);
-    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
-
-    mc->desc       = "Qualcomm DC-SCM V1 BMC (Cortex A7)";
-    mc->deprecation_reason = "use 'ast2600-evb' instead";
-    amc->soc_name  = "ast2600-a3";
-    amc->hw_strap1 = QCOM_DC_SCM_V1_BMC_HW_STRAP1;
-    amc->hw_strap2 = QCOM_DC_SCM_V1_BMC_HW_STRAP2;
-    amc->fmc_model = "n25q512a";
-    amc->spi_model = "n25q512a";
-    amc->num_cs    = 2;
-    amc->macs_mask = ASPEED_MAC2_ON | ASPEED_MAC3_ON;
-    amc->i2c_init  = qcom_dc_scm_bmc_i2c_init;
-    mc->default_ram_size = 1 * GiB;
-    aspeed_machine_class_init_cpus_defaults(mc);
-};
-
-static const TypeInfo aspeed_ast2600_qcom_dc_scm_v1_types[] = {
-    {
-        .name          = MACHINE_TYPE_NAME("qcom-dc-scm-v1-bmc"),
-        .parent        = TYPE_ASPEED_MACHINE,
-        .class_init    = aspeed_machine_qcom_dc_scm_v1_class_init,
-        .interfaces    = arm_machine_interfaces,
-    }
-};
-
-DEFINE_TYPES(aspeed_ast2600_qcom_dc_scm_v1_types)
diff --git a/hw/arm/aspeed_ast2600_qcom-firework.c b/hw/arm/aspeed_ast2600_qcom-firework.c
deleted file mode 100644
index a4dbe6eea8ab..000000000000
--- a/hw/arm/aspeed_ast2600_qcom-firework.c
+++ /dev/null
@@ -1,91 +0,0 @@
-/*
- * Qualcomm DC-SCM V1/Firework
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
-#include "hw/i2c/i2c_mux_pca954x.h"
-#include "hw/sensor/tmp105.h"
-
-/* Qualcomm DC-SCM Firework hardware value */
-#define QCOM_DC_SCM_FIREWORK_BMC_HW_STRAP1  0x00000000
-#define QCOM_DC_SCM_FIREWORK_BMC_HW_STRAP2  0x00000041
-
-#define TYPE_LM75 TYPE_TMP105
-
-static void qcom_dc_scm_bmc_i2c_init(AspeedMachineState *bmc)
-{
-    AspeedSoCState *soc = bmc->soc;
-
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 15), "tmp105", 0x4d);
-}
-
-static void qcom_dc_scm_firework_i2c_init(AspeedMachineState *bmc)
-{
-    AspeedSoCState *soc = bmc->soc;
-    I2CSlave *therm_mux, *cpuvr_mux;
-
-    /* Create the generic DC-SCM hardware */
-    qcom_dc_scm_bmc_i2c_init(bmc);
-
-    /* Now create the Firework specific hardware */
-
-    /* I2C7 CPUVR MUX */
-    cpuvr_mux = i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7),
-                                        "pca9546", 0x70);
-    i2c_slave_create_simple(pca954x_i2c_get_bus(cpuvr_mux, 0), "pca9548", 0x72);
-    i2c_slave_create_simple(pca954x_i2c_get_bus(cpuvr_mux, 1), "pca9548", 0x72);
-    i2c_slave_create_simple(pca954x_i2c_get_bus(cpuvr_mux, 2), "pca9548", 0x72);
-    i2c_slave_create_simple(pca954x_i2c_get_bus(cpuvr_mux, 3), "pca9548", 0x72);
-
-    /* I2C8 Thermal Diodes*/
-    therm_mux = i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 8),
-                                        "pca9548", 0x70);
-    i2c_slave_create_simple(pca954x_i2c_get_bus(therm_mux, 0), TYPE_LM75, 0x4C);
-    i2c_slave_create_simple(pca954x_i2c_get_bus(therm_mux, 1), TYPE_LM75, 0x4C);
-    i2c_slave_create_simple(pca954x_i2c_get_bus(therm_mux, 2), TYPE_LM75, 0x48);
-    i2c_slave_create_simple(pca954x_i2c_get_bus(therm_mux, 3), TYPE_LM75, 0x48);
-    i2c_slave_create_simple(pca954x_i2c_get_bus(therm_mux, 4), TYPE_LM75, 0x48);
-
-    /* I2C9 Fan Controller (MAX31785) */
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9), "max31785", 0x52);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9), "max31785", 0x54);
-}
-
-static void aspeed_machine_qcom_firework_class_init(ObjectClass *oc,
-                                                    const void *data)
-{
-    MachineClass *mc = MACHINE_CLASS(oc);
-    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
-
-    mc->desc       = "Qualcomm DC-SCM V1/Firework BMC (Cortex A7)";
-    mc->deprecation_reason = "use 'ast2600-evb' instead";
-    amc->soc_name  = "ast2600-a3";
-    amc->hw_strap1 = QCOM_DC_SCM_FIREWORK_BMC_HW_STRAP1;
-    amc->hw_strap2 = QCOM_DC_SCM_FIREWORK_BMC_HW_STRAP2;
-    amc->fmc_model = "n25q512a";
-    amc->spi_model = "n25q512a";
-    amc->num_cs    = 2;
-    amc->macs_mask = ASPEED_MAC2_ON | ASPEED_MAC3_ON;
-    amc->i2c_init  = qcom_dc_scm_firework_i2c_init;
-    mc->default_ram_size = 1 * GiB;
-    aspeed_machine_class_init_cpus_defaults(mc);
-};
-
-static const TypeInfo aspeed_ast2600_qcom_firework_types[] = {
-    {
-        .name          = MACHINE_TYPE_NAME("qcom-firework-bmc"),
-        .parent        = TYPE_ASPEED_MACHINE,
-        .class_init    = aspeed_machine_qcom_firework_class_init,
-        .interfaces    = arm_machine_interfaces,
-    }
-};
-
-DEFINE_TYPES(aspeed_ast2600_qcom_firework_types)
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 098015357ddc..2be74b575efc 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -61,8 +61,6 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed_ast2600_fby35.c',
   'aspeed_ast2600_fuji.c',
   'aspeed_ast2600_gb200nvl.c',
-  'aspeed_ast2600_qcom-dc-scm-v1.c',
-  'aspeed_ast2600_qcom-firework.c',
   'aspeed_ast2600_rainier.c',
   'aspeed_ast10x0.c',
   'aspeed_ast10x0_evb.c',
-- 
2.54.0


