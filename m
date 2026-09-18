Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36051C982D9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 10:14:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Va3-0003PH-DD; Fri, 18 Sep 2026 06:12:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1x7VZs-0003NP-El
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 06:12:21 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1x7VZq-0007ay-7u
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 06:12:20 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49b912df756so4211795e9.3
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 03:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789726327; x=1790331127; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=G06ebrzhC++l4jiv/i/SbggAjFbZj6iqgJHSmd7Z4QQ=;
 b=I2jEogZk4m1aU92QkQVKoGlEepbr7RGqET9cEk8Nxomkaa0A73/LQgSTK9zsBksqYk
 lEMfE2lfxmDE/+3lEpc7L5CBZGibCih2E/uFtqw2mQna4r9WfTavxYQepUtzEVe+lwAp
 CxqVY8n+u4SvK59/INvLP49hTZ/tksU1f3iyFrtOCoCp+zU1dfUAGaqCbCzdT9hitUAd
 Ixd6dFY5invgwehsEbzJ4VbIIQxYVNiFzqqyDIWEBR5kLCV/Eby8X6/T/MT41qpu9OM7
 rEP5bXR23n77POn87Q5Wa8LaI/k7e2yC1onIuqg+zCrF3KX99m9S1dxQFDZ8fWMxOLbd
 wyGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789726327; x=1790331127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=G06ebrzhC++l4jiv/i/SbggAjFbZj6iqgJHSmd7Z4QQ=;
 b=JaZCWAnzLYv8ACEtP6XCjdAoVkD8L3yJNlRX6GkzhAc2gXt+LreHbdoSCMjvNsep3F
 D2x6PJp6pUHNfXXUdIM98h/I/pp2SazT11uHGBJ88kvYv6Zu4XhJ88kxGRM6F517X/cC
 hdWyPAKSeJV92lOeRgPB9AovxV4IQYpl+R/nTw0AzZkgzBI65TPd+X8x9NqCKhY25U1Q
 9z2DWkHu13tKfUJ0fRbCnLaCke6n736i+0+0Vpi1Vq+oqcY5Yzy5QmRP3Yxcv1lAvhfh
 gwNPOAUkxgsTQwzXzu2MgDn2BuKsXfTDY8ko2u7vJrWleqXtRkdEdNqOVraZwYH26WKV
 +yTw==
X-Gm-Message-State: AFuF++mUOVcdJ5FZrvGXMnkXTXvUgQQA8Nisx5VyqGLOhbFYn/d9nhRP
 FpOfw1C47DtOFGdv/mKPCRyxSBd9gxuUlY+pXmM5+IC0JKt8raw0w+lJWsl3GdA0
X-Gm-Gg: AYBFou1VicB0tCJ+Dz9owU3RhRx2BPNv39xD/KD7DsBrFpxSKEQI8De/SZbsKR4L/wq
 lay753WNI8ykjJAbLh94Ful1dNRs1PqfpbzzptVlL72o8wMnUp4SI6vkTLcHkF4/55W1CcOFMB0
 +iycXtXSMEoDm9nbphh6maLIrIk58s0qy6Axh3XhUIpZvMO1kwU7/eTMFt1pKrTeffWjFbytT88
 mwHcwSRknorS0jpa2dyfQ57JFfEzRD51ic3w0ptJToM0XILkvu7SLgvtOlIPhgqLnKS6ygqdX/s
 llV6mPMPeOgDp9v+opopsMYJRIRTTAsNQLjgEJfM3Ko4lywr8MnXPaBk+QU39uO1OsU/Q8qspDL
 bQ7dO+xXVbHXfRYuGFiSC9dPD48PUz1H/ibxgcp6OSgDEoL+TCVUQZghX9Ru+xFYjwrOKL3hHlm
 qLqbe5FSr4HE/xGmDbcSvfq4Zwm+jCtNrrNBzvgpVL/bW+KZT+CMXnXBuCPO41A23K6lOY98rzc
 vqXRRtueOUX14ePoQYzEhI5lqt5O6GEDg==
X-Received: by 2002:a05:600c:1c1a:b0:49d:1de5:ce0a with SMTP id
 5b1f17b1804b1-49fc56d4238mr29022345e9.13.1789726326701; 
 Fri, 18 Sep 2026 03:12:06 -0700 (PDT)
Received: from PC-DA2D10.beckhoff.com
 ([2001:9e8:dc20:5e84:de9d:56c6:df83:7819])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd225898sm153886245e9.9.2026.09.18.03.12.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 03:12:06 -0700 (PDT)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: Corvin Koehne <C.Koehne@beckhoff.com>, qemu-block@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Hanna Reitz <hreitz@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Yannick Vossen <Y.Vossen@beckhoff.com>, qemu-arm@nongnu.org,
 Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH v8 6/7] hw/arm: Add new machine based on xilinx-zynq-a9 for
 Beckhoff CX7200
Date: Fri, 18 Sep 2026 12:11:57 +0200
Message-ID: <20260918101158.42101-7-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918101158.42101-1-corvin.koehne@gmail.com>
References: <20260918101158.42101-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=corvin.koehne@gmail.com; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: YannickV <Y.Vossen@beckhoff.com>

Introduce a new machine type 'beckhoff-cx7200' that inherits from the
xilinx-zynq-a9 machine. The CX7200 is an industrial PC based on the
Xilinx Zynq-7000 SoC.
The machine preserves all standard Zynq features (boot-mode selection,
SPI, UART, Ethernet, etc.) while adding CX7200-specific hardware
components.

Signed-off-by: YannickV <Y.Vossen@beckhoff.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS              |  9 +++++
 hw/arm/Kconfig           |  7 ++++
 hw/arm/beckhoff_CX7200.c | 79 ++++++++++++++++++++++++++++++++++++++++
 hw/arm/meson.build       |  1 +
 4 files changed, 96 insertions(+)
 create mode 100644 hw/arm/beckhoff_CX7200.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 9012bf476da9..49c40c2dd587 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1153,6 +1153,15 @@ F: include/hw/adc/zynq-xadc.h
 X: hw/ssi/xilinx_*
 F: docs/system/arm/xlnx-zynq.rst
 
+Beckhoff CX7200
+M: Yannick Vossen <Y.Vossen@beckhoff.com>
+M: Corvin Koehne <C.Koehne@beckhoff.com>
+L: qemu-arm@nongnu.org
+S: Maintained
+F: hw/arm/beckhoff_CX7200.c
+F: hw/misc/beckhoff_ccat.c
+F: include/hw/misc/beckhoff_ccat.h
+
 Xilinx ZynqMP and Versal
 M: Alistair Francis <alistair@alistair23.me>
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index eae06369b02f..c5ef7e68f8b8 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -277,6 +277,13 @@ config ZYNQ
     select XLNX_ZYNQ_DDRC
     select ZYNQ_DEVCFG
 
+config BECKHOFF_CX7200
+    bool
+    default y
+    depends on TCG && ARM
+    select ZYNQ
+    select BECKHOFF_CCAT
+
 config ARM_V7M
     bool
     # currently v7M must be included in a TCG build due to translate.c
diff --git a/hw/arm/beckhoff_CX7200.c b/hw/arm/beckhoff_CX7200.c
new file mode 100644
index 000000000000..606d62d78110
--- /dev/null
+++ b/hw/arm/beckhoff_CX7200.c
@@ -0,0 +1,79 @@
+/*
+ * Modified Xilinx Zynq Baseboard System emulation for Beckhoff CX7200.
+ *
+ * Copyright (c) 2026 Beckhoff Automation GmbH & Co. KG
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/core/boards.h"
+#include "hw/block/block.h"
+#include "hw/core/loader.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/core/clock.h"
+#include "qemu/error-report.h"
+#include "hw/arm/xilinx_zynq.h"  /* For ZynqMachineState */
+#include "hw/cpu/a9mpcore.h"
+#include "hw/timer/a9gtimer.h"
+#include "qom/object.h"
+
+#define TYPE_CX7200_MACHINE MACHINE_TYPE_NAME("beckhoff-cx7200")
+
+#define CX7200_PS_CLK_FREQUENCY (40 * 1000 * 1000)
+
+static void ccat_init(uint32_t base, BlockBackend *eeprom_blk)
+{
+    DeviceState *dev;
+    SysBusDevice *busdev;
+
+    dev = qdev_new("beckhoff-ccat");
+    if (eeprom_blk) {
+        qdev_prop_set_drive_err(dev, "eeprom", eeprom_blk, &error_fatal);
+    }
+    busdev = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(busdev, &error_fatal);
+    sysbus_mmio_map(busdev, 0, base);
+}
+
+static void beckhoff_cx7200_init(MachineState *machine)
+{
+    DriveInfo *di;
+    BlockBackend *blk;
+    MachineClass *parent_mc;
+
+    parent_mc = MACHINE_CLASS(object_class_get_parent(
+                                  object_get_class(OBJECT(machine))));
+    parent_mc->init(machine);
+
+    di = drive_get(IF_NONE, 0, 0);
+    blk = di ? blk_by_legacy_dinfo(di) : NULL;
+    ccat_init(0x40000000, blk);
+}
+
+static void beckhoff_cx7200_machine_class_init(ObjectClass *oc,
+                                               const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    ZynqMachineClass *zmc = ZYNQ_MACHINE_CLASS(oc);
+
+    mc->desc = "Beckhoff CX7200 Industrial PC (Zynq-based)";
+    mc->init = beckhoff_cx7200_init;
+    zmc->qspi_flash_type = "is25lp016d";
+    zmc->ps_clk_freq = CX7200_PS_CLK_FREQUENCY;
+}
+
+static const TypeInfo beckhoff_cx7200_machine_type = {
+    .name = TYPE_CX7200_MACHINE,
+    .parent = TYPE_ZYNQ_MACHINE,
+    .class_init = beckhoff_cx7200_machine_class_init,
+    .instance_size = sizeof(ZynqMachineState),
+};
+
+static void beckhoff_cx7200_machine_register_types(void)
+{
+    type_register_static(&beckhoff_cx7200_machine_type);
+}
+
+type_init(beckhoff_cx7200_machine_register_types)
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index bcc068de0403..6c7b4870bf6a 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -1,6 +1,7 @@
 arm_common_ss = ss.source_set()
 arm_common_ss.add(when: 'CONFIG_ARM_VIRT', if_true: files('virt.c'))
 arm_common_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
+arm_common_ss.add(when: 'CONFIG_BECKHOFF_CX7200', if_true: files('beckhoff_CX7200.c'))
 arm_common_ss.add(when: 'CONFIG_DIGIC', if_true: files('digic_boards.c'))
 arm_common_ss.add(when: 'CONFIG_EMCRAFT_SF2', if_true: files('msf2-som.c'))
 arm_common_ss.add(when: 'CONFIG_INTEGRATOR', if_true: files('integratorcp.c'))
-- 
2.47.3


