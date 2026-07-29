Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1CDFC53219
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 15:35:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp6JA-0006ak-9G; Wed, 29 Jul 2026 11:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1wp6J8-0006Za-GI
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 11:34:58 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1wp6J6-00018l-MJ
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 11:34:58 -0400
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-493b966dd74so6934145e9.3
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 08:34:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785339295; x=1785944095;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=waRQgwYJZyfJZTnlp7ivy6wT8uIy6YjpVb6bYaBZS7g=;
 b=bZXaYwUQJ2kbS8JJefqEhwEiu0RN1ZmEcV7J/VR/uFuOMYjtifxa91OBFQcFQ9fIsl
 2FoYMsIDXSJWeL+jIYOEvabyc7BBrx6M1ZUxzj4oKXgMSC0RNUWb017RTlBVw6f2BeeJ
 856OJXMkqXnbozUkFLkc12EftidgRuuQEmsyJouByslDvi1LyAhXh/qBYgws3XwOnw15
 82Qk8GnICXopvqC6jhal4OVMCeJ40JCA4RxzH1QyEKqQ1RL1YR3fWuzlpTCIHmCvZyps
 cKh4pzx1XJLyCS9zfSMCpRHdjmGefWT3rXsQ8dNc4MfoMfH9oGUeQ+KioZDcmKZR/Ljl
 wwMw==
X-Gm-Message-State: AOJu0Yy7SAQRf++RgSJxr3YH42C5I8LvdeZK9GSNIedBeqUkbdHCj1Ji
 IwoHGyZfTKJjJqZK6v1kZalVnjjaRzJBGB/dfChHasJv6jM1jb+ZusJJYthj2Phy
X-Gm-Gg: AR+sD10bAdzVT4EnHF5aD6Z2EyCo8gFm0dHIUz0qoiOH7gypX5wgUTB/P16gmfpfVLb
 oFeb45KRetG/88KmEloqoQycOSQgYu6cBN5oS0IRHfXkG0UuYm9QIX3EI6zGt+qZWE6XPaOvd1z
 L8mT4tBgLlafyROyQTwO6noF6At8BFPcs8u5VHwv3QiZbNOhxTL96mHE5/4Ccdkf45zMSfM1Zr7
 w2rMTW6tSk5FXMWLZRQ9KpS/Bin9bco7CrCr7uhxIDH7MdxamFqdV+/zcQoFY6iPW8eeh7PmOVd
 Ow2SxR66BHTcsIT6AagTDdVlUzkh1VLI38yCl2jodZDUivypKn9Za15VAFxxgGq1+V4jNg+NPpL
 16cKyfHeiE+BAezqZdodcwsjJHjKGLGTeJ0z99NF0PogTHLVrzErfwknpVUKsB0nBrG8W8Ws5nN
 /BwXmQE2E6AlOHh8bJkg1InaP6/uICESFtyFziAX36z3BY3WG8ikBQTBLjBA5C35QQQLnsIeCy2
 3x9TG3ee/lhHVxXsItcG3K6lw+jBzY2s1KKIgX68dcUvOka
X-Received: by 2002:a05:600c:c48f:b0:493:a623:d090 with SMTP id
 5b1f17b1804b1-496c642d64amr81488645e9.10.1785339295012; 
 Wed, 29 Jul 2026 08:34:55 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4976bd7d4e5sm47960965e9.0.2026.07.29.08.34.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 08:34:54 -0700 (PDT)
Date: Wed, 29 Jul 2026 17:12:48 +0200
Subject: [PATCH 12/25] hw/arm: sanmiguel: add Facebook SanMiguel BMC
 machine
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260729-sanmiguel-bmc-locator-v1-12-c8f9a8d101f6@free.fr>
References: <20260729-sanmiguel-bmc-locator-v1-0-c8f9a8d101f6@free.fr>
In-Reply-To: <20260729-sanmiguel-bmc-locator-v1-0-c8f9a8d101f6@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <th.huth+qemu@posteo.eu>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Emmanuel Blot <eblot@meta.com>, Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785337964; l=6006;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=IIGp7JMpwq/OH+NFukTrNiRzNgl7XKdaJGt6qK4dT9k=;
 b=Eob/FrvxJDWrPaoYGCADNo4jLQQQrqx1Lnu2OZRaVgmo+eNy/vpSpZdprngZxMV9bq89i8Ba5
 cuvb5hTnrQwAaZmnCL32mOZaIH1Xlqn71rZRG6NbYNAxpJF07F6q8kT
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.128.45; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm1-f45.google.com
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

Add an AST2600-based machine for the Facebook SanMiguel BMC, derived
from the aspeed-bmc-facebook-sanmiguel.dts device tree.

The board wires up three TMP75 temperature sensors across its I2C buses,
alongside IO expanders, FRU EEPROMs, an I2C mux and an RTC, with 2 GiB
RAM, dual FMC flash and RGMII networking.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 hw/arm/aspeed_ast2600_sanmiguel.c | 142 ++++++++++++++++++++++++++++++++++++++
 hw/arm/meson.build                |   1 +
 2 files changed, 143 insertions(+)

diff --git a/hw/arm/aspeed_ast2600_sanmiguel.c b/hw/arm/aspeed_ast2600_sanmiguel.c
new file mode 100644
index 0000000000..0f766449ae
--- /dev/null
+++ b/hw/arm/aspeed_ast2600_sanmiguel.c
@@ -0,0 +1,142 @@
+/*
+ * Facebook SanMiguel BMC
+ *
+ * Copyright (c) Meta Platforms, Inc. and affiliates.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/arm/machines-qom.h"
+#include "hw/arm/aspeed.h"
+#include "hw/arm/aspeed_soc.h"
+#include "hw/i2c/i2c_mux_pca954x.h"
+#include "hw/gpio/pca9552.h"
+#include "hw/gpio/pca9554.h"
+#include "hw/nvram/eeprom_at24c.h"
+#include "hw/sensor/tmp105.h"
+
+/* SanMiguel hardware values */
+#define SANMIGUEL_BMC_HW_STRAP1 0x00002002
+#define SANMIGUEL_BMC_HW_STRAP2 0x00000000
+#define SANMIGUEL_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)
+
+#define TYPE_DS1338 "ds1338"
+
+static void sanmiguel_bmc_i2c_init(AspeedMachineState *bmc)
+{
+    /* Reference: aspeed-bmc-facebook-sanmiguel.dts */
+
+    AspeedSoCState *soc = bmc->soc;
+    I2CBus *i2c[16] = {};
+
+    for (unsigned idx = 0; idx < ARRAY_SIZE(i2c); idx++) {
+        i2c[idx] = aspeed_i2c_get_bus(&soc->i2c, idx);
+    }
+
+    /* &i2c0 */
+    /* ssif-bmc@10 — no QEMU model */
+
+    /* &i2c1 — empty */
+
+    /* &i2c2 — HPM0 */
+    /* hpm0_ioexp_20: pca9555@20 */
+    i2c_slave_create_simple(i2c[2], TYPE_PCA9555, 0x20);
+    /* hpm0_ioexp_21: pca9555@21 */
+    i2c_slave_create_simple(i2c[2], TYPE_PCA9555, 0x21);
+
+    /* &i2c3 — empty */
+    /* &i2c4 — empty */
+
+    /* &i2c5 — SMM */
+    /* smm_ioexp_20: pca9555@20 */
+    i2c_slave_create_simple(i2c[5], TYPE_PCA9555, 0x20);
+    /* smm_ioexp_21: pca9555@21 */
+    i2c_slave_create_simple(i2c[5], TYPE_PCA9555, 0x21);
+    /* smm_temp: lm75@48 */
+    i2c_slave_create_simple(i2c[5], TYPE_TMP75, 0x48);
+    /* smm_fru: eeprom@50 (24c128 = 16 KiB) */
+    at24c_eeprom_init(i2c[5], 0x50, 16 * KiB);
+    /* rtc@6f — nct3018y (ds1338 stand-in) */
+    i2c_slave_create_simple(i2c[5], TYPE_DS1338, 0x6f);
+
+    /* &i2c6 — HMC */
+    /* hmc_ioexp: tca6408@20 (pca9554 stand-in) */
+    i2c_slave_create_simple(i2c[6], TYPE_PCA9554, 0x20);
+    /* i2c-mux@70 (PCA9546) — 4 channels (imux16-19), all empty */
+    i2c_slave_create_simple(i2c[6], TYPE_PCA9546, 0x70);
+
+    /* &i2c7 — HPM1 */
+    /* hpm1_ioexp_20: pca9555@20 */
+    i2c_slave_create_simple(i2c[7], TYPE_PCA9555, 0x20);
+    /* hpm1_ioexp_21: pca9555@21 */
+    i2c_slave_create_simple(i2c[7], TYPE_PCA9555, 0x21);
+
+    /* &i2c8 — empty */
+
+    /* &i2c9 — PDB */
+    /* mp5926@10-16, lm5066i@11-17 — no QEMU model (power monitors) */
+    /* pdb_ioexp_20: pca9555@20 */
+    i2c_slave_create_simple(i2c[9], TYPE_PCA9555, 0x20);
+    /* pdb_temp: lm75@4e */
+    i2c_slave_create_simple(i2c[9], TYPE_TMP75, 0x4e);
+    /* pdb_fru: eeprom@50 (24c128 = 16 KiB) */
+    at24c_eeprom_init(i2c[9], 0x50, 16 * KiB);
+
+    /* &i2c10 — SCM */
+    /* scm_temp: lm75@48 */
+    i2c_slave_create_simple(i2c[10], TYPE_TMP75, 0x48);
+    /* scm_fru: eeprom@50 (24c128 = 16 KiB) */
+    at24c_eeprom_init(i2c[10], 0x50, 16 * KiB);
+
+    /* &i2c11 — Switch Config */
+    /* sw_config: eeprom@50 (24c64 = 8 KiB) */
+    at24c_eeprom_init(i2c[11], 0x50, 8 * KiB);
+
+    /* &i2c12 — empty */
+
+    /* &i2c13 — SMM extension */
+    /* mctp@10 — no QEMU model */
+    /* smm_ext_ioexp: pca9554@38 */
+    i2c_slave_create_simple(i2c[13], TYPE_PCA9554, 0x38);
+    /* smm_ext_fru: eeprom@55 (24c128 = 16 KiB) */
+    at24c_eeprom_init(i2c[13], 0x55, 16 * KiB);
+
+    /* &i2c14 — FIO */
+    /* fio_ioexp: pca9555@20 */
+    i2c_slave_create_simple(i2c[14], TYPE_PCA9555, 0x20);
+    /* fio_fru: eeprom@50 (24c64 = 8 KiB) */
+    at24c_eeprom_init(i2c[14], 0x50, 8 * KiB);
+
+    /* &i2c15 — empty */
+}
+
+static void aspeed_machine_sanmiguel_class_init(ObjectClass *oc,
+                                                const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
+
+    mc->desc       = "Facebook SanMiguel BMC (Cortex-A7)";
+    amc->soc_name  = "ast2600-a3";
+    amc->hw_strap1 = SANMIGUEL_BMC_HW_STRAP1;
+    amc->hw_strap2 = SANMIGUEL_BMC_HW_STRAP2;
+    amc->fmc_model = "mx66l1g45g";
+    amc->spi_model = "mx66l1g45g";
+    amc->num_cs    = 2;
+    amc->macs_mask = ASPEED_MAC0_ON;
+    amc->i2c_init  = sanmiguel_bmc_i2c_init;
+    mc->default_ram_size = SANMIGUEL_BMC_RAM_SIZE;
+    aspeed_machine_class_init_cpus_defaults(mc);
+}
+
+static const TypeInfo aspeed_ast2600_sanmiguel_types[] = {
+    {
+        .name          = MACHINE_TYPE_NAME("sanmiguel-bmc"),
+        .parent        = TYPE_ASPEED_MACHINE,
+        .class_init    = aspeed_machine_sanmiguel_class_init,
+        .interfaces    = arm_machine_interfaces,
+    }
+};
+
+DEFINE_TYPES(aspeed_ast2600_sanmiguel_types)
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 4233a800be..2d5f4a0fe4 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -65,6 +65,7 @@ arm_common_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed_ast2600_fuji.c',
   'aspeed_ast2600_gb200nvl.c',
   'aspeed_ast2600_rainier.c',
+  'aspeed_ast2600_sanmiguel.c',
   'aspeed_ast10x0.c',
   'aspeed_ast10x0_evb.c',
   'aspeed_ast1040.c',

-- 
2.50.1


