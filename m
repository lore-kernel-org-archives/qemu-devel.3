Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6640ECA9EC5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 15:41:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGI9j-0004vz-Al; Mon, 12 Oct 2026 11:41:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xGI9h-0004ui-83
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 11:41:37 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xGI9e-0004CJ-Qr
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 11:41:36 -0400
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-48b02b1b4cfso2616514f8f.0
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 08:41:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791819693; x=1792424493;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=B93lbF1AB8TDmaiV+Eh5ZQzyxvlqzMHBTF/j93JXN/E=;
 b=Rj+m5Q0Pq2h/NuiT48EJplp+2KTAOd0p6Qos+l19Dlu5d5rmrJDcQKTjeM+/4pGuHf
 Hr5aRxG17tL/PI1SDQsI9Dk3yUY2cAJO59XWDrjOP/080ZrsKerTecHM3Z0JJbJ7CJ7j
 C/ZXAcPzJsQypjWAj7Uxz00tR4TgdjFpw5bayEMCuv7CN9E1fjdkRav5su9ooewnCErS
 6yDQ6Wc2VXHEhUiFrUO63Huvn514rNc6RMwfjSlcL6szp1ihedeDz7c9NMoCABMGK5sK
 fCaVQHIsUek/wvtyUre9uP8jRn9n3ntOShGi9wKKSFYf18HM6GKRUscV0IRVWB+rjeFz
 gL6A==
X-Gm-Message-State: AFq9FYLN8TLI1HCGZXCaL7zuP5snvZxIIKindqT8iuq0L2r67mxs/VNn
 O7nqkJVfFdWJL2BwHVfZpzWKWQMc82//FKOiQbZwP90rwfeT6TsvSdZFwPR3nLRA
X-Gm-Gg: AYBFou3V1Fqr7Jvf2ocbkhP0xn1MhXY8Z9YHC9X3thKGjLKC/VaqjKMhr2im8O2Wx1i
 3azwIrCKpLbGvKfFowYSTSYlMIO4zEKQfhrc4ZzPhHMgTuCBWDiI5uv27MAcg6dAvgQtft3HZYK
 AbDdECxAFhJfzSeP8BipOig7r5yJZmsWfI6pb89SCdcp7PriTi2oRnR/tPQ1tFB5CR4lOzIueW2
 8XR5VSoQoKh2ajJxouv4V+QTvP4NDl0Y+ToY9ShLKSKB81PhF31AGiRBuSSv3DY5lRg2FVn++fa
 mZp/BeY5pw1yOfBP5joX33SmR01xVdZIn/Avzsk4XywAIuFflzQrgeOOz3wSCsp/8aHIxS31bSu
 9+5diWcevFmGdvModz7q2sTNnfshS9x+HwnH62Y/i554Wu4RSvkXhlxuHZW4eexFm08QL3h9m/f
 KaGpIAwHHr5QHo2QmEDqwDOIJkX08xNDMpqDqYDQD/TXjEviBeroTvjz3jUhsGocbTcPLpUGjsm
 JpRWHHqX7aqjnnnxm3B2u6T6V2BLwMwwQiFmuDnikifYw==
X-Received: by 2002:a05:6000:240d:b0:48c:55c1:fb7e with SMTP id
 ffacd0b85a97d-48db94743e8mr20136133f8f.11.1791819693011; 
 Mon, 12 Oct 2026 08:41:33 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0ac35dfsm97864f8f.33.2026.10.12.08.41.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 08:41:32 -0700 (PDT)
Date: Mon, 12 Oct 2026 16:32:41 +0200
Subject: [PATCH v2 48/50] hw/arm: minerva: add Facebook BMC machine
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-bmc-minerva-v2-48-4c3dff084ec9@free.fr>
References: <20261012-bmc-minerva-v2-0-4c3dff084ec9@free.fr>
In-Reply-To: <20261012-bmc-minerva-v2-0-4c3dff084ec9@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org, 
 Patrick Leis <venture@google.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791815522; l=8430;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=1AtBc0pagvipMFLYb/Fka5t4gJc/Ah7jZctQNlIXOxo=;
 b=tnI5tkj95JsY9ytomSX4IYOqcfNjRWBm6rEFmhVyruiFLy2oeg7T4PQrmAlhGpaD1GVEsH4UA
 XiX5HwcgaNiBbXd8VN9Vp4MbHDFtSVrbL+5I5XwOnzPJIsAA5cewcdS
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.221.46; envelope-from=eblot.ml@gmail.com;
 helo=mail-wr1-f46.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Emmanuel Blot <emmanuel.blot@free.fr>
From:  Emmanuel Blot via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add a machine for the Facebook Minerva Chassis Management Module (BMC),
an AST2600-based board modelled from its device tree
(aspeed-bmc-facebook-minerva.dts).

The board uses INA230 and INA238 power monitors, TMP75 temperature
sensors, PCA9555 IO expanders, PCA9545 and PCA9548 I2C muxes, AT24C
EEPROMs and a DS1339 RTC.

Every device the Minerva device tree describes and QEMU already models
is instantiated. The remaining ones (LTC4287, XDP710, MAX31790, PCF8563
and IPMB) have no QEMU model and are left documented as comments.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 docs/system/arm/aspeed.rst      |   1 +
 hw/arm/aspeed_ast2600_minerva.c | 180 ++++++++++++++++++++++++++++++++++++++++
 hw/arm/meson.build              |   1 +
 3 files changed, 182 insertions(+)

diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst
index f38f33cbe1..bbd3d9cdf4 100644
--- a/docs/system/arm/aspeed.rst
+++ b/docs/system/arm/aspeed.rst
@@ -36,6 +36,7 @@ AST2600 SoC based machines :
 - ``catalina-bmc``         Facebook Catalina BMC
 - ``sanmiguel-bmc``        Facebook SanMiguel BMC
 - ``anacapa-bmc``          Facebook Anacapa BMC
+- ``minerva-bmc``          Facebook Minerva BMC
 - ``gb200nvl-bmc``         Nvidia GB200nvl BMC
 
 Supported devices
diff --git a/hw/arm/aspeed_ast2600_minerva.c b/hw/arm/aspeed_ast2600_minerva.c
new file mode 100644
index 0000000000..93abc64770
--- /dev/null
+++ b/hw/arm/aspeed_ast2600_minerva.c
@@ -0,0 +1,180 @@
+/*
+ * Facebook Minerva Chassis Management Module
+ *
+ * Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/arm/aspeed.h"
+#include "hw/arm/aspeed_soc.h"
+#include "hw/i2c/i2c_mux_pca954x.h"
+#include "hw/gpio/pca9552.h"
+#include "hw/nvram/eeprom_at24c.h"
+#include "hw/rtc/ds1338.h"
+#include "hw/sensor/ina230.h"
+#include "hw/sensor/ina238.h"
+#include "hw/sensor/tmp105.h"
+
+/*
+ * Minerva hardware values.
+ */
+#define MINERVA_BMC_HW_STRAP1 0x00002002
+#define MINERVA_BMC_HW_STRAP2 0x00000800
+#define MINERVA_BMC_RAM_SIZE (2 * GiB)
+
+/*
+ * Fan Controller Board (FCB).  The Minerva BMC device tree describes six
+ * identical FCBs, each hanging off one channel of the PCA9548 on i2c2.
+ */
+static void minerva_fcb_i2c_init(I2CBus *bus)
+{
+    /* eeprom@50 - atmel,24c128 */
+    at24c_eeprom_init(bus, 0x50, 16 * KiB);
+    /* pwm@5e - maxim,max31790 (no model) */
+    /* power-sensor@40/41/44/45 - ti,ina238 */
+    i2c_slave_create_simple(bus, TYPE_INA238, 0x40);
+    i2c_slave_create_simple(bus, TYPE_INA238, 0x41);
+    i2c_slave_create_simple(bus, TYPE_INA238, 0x44);
+    i2c_slave_create_simple(bus, TYPE_INA238, 0x45);
+    /* temperature-sensor@4b - tmp75 */
+    i2c_slave_create_simple(bus, TYPE_TMP75, 0x4b);
+    /* gpio@11/12/13/17 - pca9555 */
+    i2c_slave_create_simple(bus, TYPE_PCA9555, 0x11);
+    i2c_slave_create_simple(bus, TYPE_PCA9555, 0x12);
+    i2c_slave_create_simple(bus, TYPE_PCA9555, 0x13);
+    i2c_slave_create_simple(bus, TYPE_PCA9555, 0x17);
+}
+
+static void minerva_pca9545_eeprom_init(I2CBus *bus, uint8_t addr,
+                                        unsigned neeprom)
+{
+    I2CSlave *i2c_mux = i2c_slave_create_simple(bus, TYPE_PCA9545, addr);
+
+    for (unsigned idx = 0; idx < neeprom; idx++) {
+        at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, idx), 0x50, 8 * KiB);
+    }
+}
+
+static void minerva_bmc_i2c_init(AspeedMachineState *bmc)
+{
+    /* Reference: aspeed-bmc-facebook-minerva.dts */
+
+    AspeedSoCState *soc = bmc->soc;
+    I2CBus *i2c[16] = {};
+    I2CSlave *i2c_mux;
+
+    for (unsigned idx = 0; idx < ARRAY_SIZE(i2c); idx++) {
+        i2c[idx] = aspeed_i2c_get_bus(&soc->i2c, idx);
+    }
+
+    /* &i2c0 */
+    /* power-monitor@40/41 - ti,ina230 */
+    i2c_slave_create_simple(i2c[0], TYPE_INA230, 0x40);
+    i2c_slave_create_simple(i2c[0], TYPE_INA230, 0x41);
+    /* power-monitor@44 - lltc,ltc4287 (no model) */
+    /* power-monitor@43 - infineon,xdp710 (no model) */
+    /* leds_gpio: gpio@19 - pca9555 */
+    i2c_slave_create_simple(i2c[0], TYPE_PCA9555, 0x19);
+    /* gpio@11/12/13 - pca9555 */
+    i2c_slave_create_simple(i2c[0], TYPE_PCA9555, 0x11);
+    i2c_slave_create_simple(i2c[0], TYPE_PCA9555, 0x12);
+    i2c_slave_create_simple(i2c[0], TYPE_PCA9555, 0x13);
+
+    /* &i2c1 */
+    /* temperature-sensor@4b/4f - tmp75 */
+    i2c_slave_create_simple(i2c[1], TYPE_TMP75, 0x4b);
+    i2c_slave_create_simple(i2c[1], TYPE_TMP75, 0x4f);
+    /* eeprom@54 - atmel,24c128 */
+    at24c_eeprom_init(i2c[1], 0x54, 16 * KiB);
+
+    /* &i2c2 */
+    /* i2c-mux@77 (PCA9548) - six Fan Controller Boards */
+    i2c_mux = i2c_slave_create_simple(i2c[2], TYPE_PCA9548, 0x77);
+    /* FCB 1 - imux16 (channel 1) */
+    minerva_fcb_i2c_init(pca954x_i2c_get_bus(i2c_mux, 1));
+    /* FCB 2 - imux17 (channel 0) */
+    minerva_fcb_i2c_init(pca954x_i2c_get_bus(i2c_mux, 0));
+    /* FCB 3 - imux18 (channel 3) */
+    minerva_fcb_i2c_init(pca954x_i2c_get_bus(i2c_mux, 3));
+    /* FCB 4 - imux19 (channel 2) */
+    minerva_fcb_i2c_init(pca954x_i2c_get_bus(i2c_mux, 2));
+    /* FCB 5 - imux20 (channel 4) */
+    minerva_fcb_i2c_init(pca954x_i2c_get_bus(i2c_mux, 4));
+    /* FCB 6 - imux21 (channel 5) */
+    minerva_fcb_i2c_init(pca954x_i2c_get_bus(i2c_mux, 5));
+    /* imux22/imux23 (channels 6/7) - empty */
+
+    /* &i2c3 */
+    /* i2c-mux@72 (PCA9545) - imux24-27, eeprom@50 on each channel */
+    minerva_pca9545_eeprom_init(i2c[3], 0x72, 4);
+
+    /* &i2c4 */
+    /* i2c-mux@72 (PCA9545) - imux28-31, eeprom@50 on each channel */
+    minerva_pca9545_eeprom_init(i2c[4], 0x72, 4);
+
+    /* &i2c5 */
+    /* i2c-mux@72 (PCA9545) - imux32-35, eeprom@50 on each channel */
+    minerva_pca9545_eeprom_init(i2c[5], 0x72, 4);
+
+    /* &i2c6 */
+    /* i2c-mux@72 (PCA9545) - imux36-39, eeprom@50 on each channel */
+    minerva_pca9545_eeprom_init(i2c[6], 0x72, 4);
+
+    /* &i2c7 - empty */
+    /* &i2c8 - empty */
+
+    /* &i2c9 */
+    /* eeprom@50 - atmel,24c64 */
+    at24c_eeprom_init(i2c[9], 0x50, 8 * KiB);
+    /* rtc@51 - nxp,pcf8563 (no model) */
+    /* rtc@68 - dallas,ds1339 */
+    i2c_slave_create_simple(i2c[9], TYPE_DS1339, 0x68);
+
+    /* &i2c12 */
+    /* i2c-mux@70 (PCA9545) - imux40-42 eeprom@50, imux43 empty */
+    minerva_pca9545_eeprom_init(i2c[12], 0x70, 3);
+
+    /* &i2c13 */
+    /* i2c-mux@70 (PCA9545) - imux44-46 eeprom@50, imux47 empty */
+    minerva_pca9545_eeprom_init(i2c[13], 0x70, 3);
+
+    /* &i2c14 */
+    /* ipmb@10 - ipmb-dev (no model) */
+
+    /* &i2c15 */
+    /* eeprom@50 - atmel,24c128 */
+    at24c_eeprom_init(i2c[15], 0x50, 16 * KiB);
+    /* eeprom@56 - atmel,24c64 */
+    at24c_eeprom_init(i2c[15], 0x56, 8 * KiB);
+}
+
+static void aspeed_machine_minerva_class_init(ObjectClass *oc,
+                                              const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
+
+    mc->desc       = "Facebook Minerva BMC (Cortex-A7)";
+    amc->soc_name  = "ast2600-a3";
+    amc->hw_strap1 = MINERVA_BMC_HW_STRAP1;
+    amc->hw_strap2 = MINERVA_BMC_HW_STRAP2;
+    amc->fmc_model = "mx66l1g45g";
+    amc->spi_model = NULL;
+    amc->num_cs    = 2;
+    amc->macs_mask = ASPEED_MAC3_ON;
+    amc->i2c_init  = minerva_bmc_i2c_init;
+    mc->default_ram_size = MINERVA_BMC_RAM_SIZE;
+    aspeed_machine_class_init_cpus_defaults(mc);
+}
+
+static const TypeInfo aspeed_ast2600_minerva_types[] = {
+    {
+        .name          = MACHINE_TYPE_NAME("minerva-bmc"),
+        .parent        = TYPE_ASPEED_MACHINE,
+        .class_init    = aspeed_machine_minerva_class_init,
+    }
+};
+
+DEFINE_TYPES(aspeed_ast2600_minerva_types)
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index bcc068de04..a9e8270b85 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -63,6 +63,7 @@ arm_common_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed_ast2600_fby35.c',
   'aspeed_ast2600_fuji.c',
   'aspeed_ast2600_gb200nvl.c',
+  'aspeed_ast2600_minerva.c',
   'aspeed_ast2600_rainier.c',
   'aspeed_ast2600_sanmiguel.c',
   'aspeed_ast10x0.c',

-- 
2.50.1


