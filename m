Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5D66C02181
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 20:39:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZyXJ-0003ub-Pk; Mon, 20 Jan 2025 15:38:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tZyXG-0003tp-3X; Mon, 20 Jan 2025 15:38:14 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tZyXC-0002Vy-NA; Mon, 20 Jan 2025 15:38:13 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5d3dce16a3dso6166428a12.1; 
 Mon, 20 Jan 2025 12:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737405488; x=1738010288; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g309B/65PRNKKOTakjdLrCe1Z4YUJcyjgMJCLdfcxEE=;
 b=GIJoQLURIqSkDMTcN2/1YvIhM7f5Eks2cJBYG0W2Ts/1GYeSwBOaEY+ywhWy4UDRS1
 5u2/XQd+mjgMP8vlq9wPgJ6lh4jszfufr+mssnB8CsiZjzF/FD3DBfgR16+JfcsKQGWU
 JAIPv8YUElEcL3LWb707KLkWHP3P/9erpYCKJMCIHjZqceUK3h5q0Bh91B8W4YExPLd0
 vhMJFwI2YFgYpdJiUAYuJGuCWlocpz8Z32Wn7D4d8Ax6Cr2BSVauujbLZuho8RyJSpVx
 Mlh7pc4Fdrp2ZTlMF68wF4ORYWHYQ/l+o3IIajPoR8mIzaXBTElkYlP7FfTEYd+6dN6P
 gVrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737405488; x=1738010288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g309B/65PRNKKOTakjdLrCe1Z4YUJcyjgMJCLdfcxEE=;
 b=Vcxxi6DnJnl4j6fOJ3Kcuc/YkeX09fUSKwzT2DI0BVQtJlZ80mgAYK22SSlTqO+o4c
 FKhA0TbntCVuBESiSATOFxNdXrRcdHo96yZ3wOY/OCL0dv64f5frXxA17882fqB5UimW
 lw2XZW6GcxF769tl2IeTPIF63+SO/wOxG3gf30T4iTyPjqhOAK4/Y6YE8xRAaR/rWfzg
 xwstUvi4A32wjSvE3Em5uhZ0TAcNAhk75xXWQ4pFZ7y2FaTlP3YTVW5I7gTcFdmJykM0
 ZxNzUi7aoxvAPfj9KmPD5T+47BJumWCdojwZU10Qa8qeckSVvCC/GJFe0qVK7BqmGPED
 A0lg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQB1u0ATkFajatzuXnjTAOYzGdMibCpibj1xpI4WNYN6UT+9keOdw1Wf0IoT7aMRVcKRaAQDEm/g==@nongnu.org
X-Gm-Message-State: AOJu0Yy7Bnko420WcNXmubDUvAt8RIYL+3WCifoiBA7hJilFOttGNh2w
 qjYIeQ7DFu9h+4hchcUc1uyD6F59kXX9+tzEfZAYZ4B/HoKpqhcvIm+c/YC9
X-Gm-Gg: ASbGnctsb60qjAp1qMnjTlb7D3Ob03lvSau0Z9AZbOEnKAREML+T4V95YHU1X59H8Kk
 qWR43AHnHjVPhvcZBXLxk5drqARdC7vRIT+aMVWm0iXfOwK94c/0D7iz6aQyCIkOC2HyJn85cPk
 VbkEqhEMQEJUNWzYOkJBVlMGA0BlDPkPxhVC1YfN5zhst7od4Ns+psvNV3JnH2Q4d97DQKwiuZC
 v2za25dL79cIc8iq8zn+XyaGoY2M88FrkiUzTriU/h5R7UEjA76YL+jw7rIxa/MaSblFDpegeBJ
 H2zjKL+xfTnH7U7wsNhco5s3HjBA4T3LxwPR5xsjja1uNGiSRYMKfIN+R0CX
X-Google-Smtp-Source: AGHT+IGaWwIc9LgS5QYnCt89bp0ruO4suLPSDSmXgUUqKfR9i4rjkPjh9ZWRuiyqczJMhHc7o4JuQw==
X-Received: by 2002:a05:6402:90e:b0:5d9:f3fb:fa45 with SMTP id
 4fb4d7f45d1cf-5db7dd354abmr12468106a12.16.1737405486740; 
 Mon, 20 Jan 2025 12:38:06 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-077-183-181-102.77.183.pool.telefonica.de. [77.183.181.102])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5db7364258csm6021077a12.1.2025.01.20.12.38.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 12:38:06 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 06/21] hw/arm/fsl-imx8mp: Implement clock tree
Date: Mon, 20 Jan 2025 21:37:33 +0100
Message-ID: <20250120203748.4687-7-shentey@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250120203748.4687-1-shentey@gmail.com>
References: <20250120203748.4687-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Fixes quite a few stack traces during the Linux boot process. Also provides the
clocks for devices added later, e.g. enet1.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 MAINTAINERS                    |   2 +
 docs/system/arm/imx8mp-evk.rst |   1 +
 include/hw/arm/fsl-imx8mp.h    |   3 +
 include/hw/misc/imx8mp_ccm.h   |  97 ++++++++++
 hw/arm/fsl-imx8mp.c            |  20 +++
 hw/misc/imx8mp_ccm.c           | 315 +++++++++++++++++++++++++++++++++
 hw/misc/meson.build            |   1 +
 7 files changed, 439 insertions(+)
 create mode 100644 include/hw/misc/imx8mp_ccm.h
 create mode 100644 hw/misc/imx8mp_ccm.c

diff --git a/MAINTAINERS b/MAINTAINERS
index cace8cf25b..3c60581fe7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -825,7 +825,9 @@ L: qemu-arm@nongnu.org
 S: Odd Fixes
 F: hw/arm/imx8mp-evk.c
 F: hw/arm/fsl-imx8mp.c
+F: hw/misc/imx8mp_*.c
 F: include/hw/arm/fsl-imx8mp.h
+F: include/hw/misc/imx8mp_*.h
 F: docs/system/arm/imx8mp-evk.rst
 
 MPS2 / MPS3
diff --git a/docs/system/arm/imx8mp-evk.rst b/docs/system/arm/imx8mp-evk.rst
index 184f1ef7e6..3de4a73530 100644
--- a/docs/system/arm/imx8mp-evk.rst
+++ b/docs/system/arm/imx8mp-evk.rst
@@ -13,6 +13,7 @@ The ``imx8mp-evk`` machine implements the following devices:
  * Up to 4 Cortex-A53 Cores
  * Generic Interrupt Controller (GICv3)
  * 4 UARTs
+ * Clock Tree
 
 Boot options
 ------------
diff --git a/include/hw/arm/fsl-imx8mp.h b/include/hw/arm/fsl-imx8mp.h
index 57e23d1b69..979cdbd8c4 100644
--- a/include/hw/arm/fsl-imx8mp.h
+++ b/include/hw/arm/fsl-imx8mp.h
@@ -12,6 +12,7 @@
 #include "cpu.h"
 #include "hw/char/imx_serial.h"
 #include "hw/intc/arm_gicv3_common.h"
+#include "hw/misc/imx8mp_ccm.h"
 #include "qom/object.h"
 #include "qemu/units.h"
 
@@ -32,6 +33,8 @@ struct FslImx8mpState {
 
     ARMCPU             cpu[FSL_IMX8MP_NUM_CPUS];
     GICv3State         gic;
+    IMX8MPCCMState     ccm;
+    IMX8MPAnalogState  analog;
     IMXSerialState     uart[FSL_IMX8MP_NUM_UARTS];
 };
 
diff --git a/include/hw/misc/imx8mp_ccm.h b/include/hw/misc/imx8mp_ccm.h
new file mode 100644
index 0000000000..2378c157de
--- /dev/null
+++ b/include/hw/misc/imx8mp_ccm.h
@@ -0,0 +1,97 @@
+/*
+ * Copyright (c) 2025 Bernhard Beschow <shentey@gmail.com>
+ *
+ * i.MX8MP CCM, ANALOG IP blocks emulation code
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef IMX8MP_CCM_H
+#define IMX8MP_CCM_H
+
+#include "hw/misc/imx_ccm.h"
+#include "qom/object.h"
+
+enum IMX8MPAnalogRegisters {
+    ANALOG_AUDIO_PLL1_GEN_CTRL = 0x000 / 4,
+    ANALOG_AUDIO_PLL1_FDIV_CTL0 = 0x004 / 4,
+    ANALOG_AUDIO_PLL1_FDIV_CTL1 = 0x008 / 4,
+    ANALOG_AUDIO_PLL1_SSCG_CTRL = 0x00c / 4,
+    ANALOG_AUDIO_PLL1_MNIT_CTRL = 0x010 / 4,
+    ANALOG_AUDIO_PLL2_GEN_CTRL = 0x014 / 4,
+    ANALOG_AUDIO_PLL2_FDIV_CTL0 = 0x018 / 4,
+    ANALOG_AUDIO_PLL2_FDIV_CTL1 = 0x01c / 4,
+    ANALOG_AUDIO_PLL2_SSCG_CTRL = 0x020 / 4,
+    ANALOG_AUDIO_PLL2_MNIT_CTRL = 0x024 / 4,
+    ANALOG_VIDEO_PLL1_GEN_CTRL = 0x028 / 4,
+    ANALOG_VIDEO_PLL1_FDIV_CTL0 = 0x02c / 4,
+    ANALOG_VIDEO_PLL1_FDIV_CTL1 = 0x030 / 4,
+    ANALOG_VIDEO_PLL1_SSCG_CTRL = 0x034 / 4,
+    ANALOG_VIDEO_PLL1_MNIT_CTRL = 0x038 / 4,
+    ANALOG_DRAM_PLL_GEN_CTRL = 0x050 / 4,
+    ANALOG_DRAM_PLL_FDIV_CTL0 = 0x054 / 4,
+    ANALOG_DRAM_PLL_FDIV_CTL1 = 0x058 / 4,
+    ANALOG_DRAM_PLL_SSCG_CTRL = 0x05c / 4,
+    ANALOG_DRAM_PLL_MNIT_CTRL = 0x060 / 4,
+    ANALOG_GPU_PLL_GEN_CTRL = 0x064 / 4,
+    ANALOG_GPU_PLL_FDIV_CTL0 = 0x068 / 4,
+    ANALOG_GPU_PLL_LOCKD_CTRL = 0x06c / 4,
+    ANALOG_GPU_PLL_MNIT_CTRL = 0x070 / 4,
+    ANALOG_VPU_PLL_GEN_CTRL = 0x074 / 4,
+    ANALOG_VPU_PLL_FDIV_CTL0 = 0x078 / 4,
+    ANALOG_VPU_PLL_LOCKD_CTRL = 0x07c / 4,
+    ANALOG_VPU_PLL_MNIT_CTRL = 0x080 / 4,
+    ANALOG_ARM_PLL_GEN_CTRL = 0x084 / 4,
+    ANALOG_ARM_PLL_FDIV_CTL0 = 0x088 / 4,
+    ANALOG_ARM_PLL_LOCKD_CTRL = 0x08c / 4,
+    ANALOG_ARM_PLL_MNIT_CTRL = 0x090 / 4,
+    ANALOG_SYS_PLL1_GEN_CTRL = 0x094 / 4,
+    ANALOG_SYS_PLL1_FDIV_CTL0 = 0x098 / 4,
+    ANALOG_SYS_PLL1_LOCKD_CTRL = 0x09c / 4,
+    ANALOG_SYS_PLL1_MNIT_CTRL = 0x100 / 4,
+    ANALOG_SYS_PLL2_GEN_CTRL = 0x104 / 4,
+    ANALOG_SYS_PLL2_FDIV_CTL0 = 0x108 / 4,
+    ANALOG_SYS_PLL2_LOCKD_CTRL = 0x10c / 4,
+    ANALOG_SYS_PLL2_MNIT_CTRL = 0x110 / 4,
+    ANALOG_SYS_PLL3_GEN_CTRL = 0x114 / 4,
+    ANALOG_SYS_PLL3_FDIV_CTL0 = 0x118 / 4,
+    ANALOG_SYS_PLL3_LOCKD_CTRL = 0x11c / 4,
+    ANALOG_SYS_PLL3_MNIT_CTRL = 0x120 / 4,
+    ANALOG_OSC_MISC_CFG = 0x124 / 4,
+    ANALOG_ANAMIX_PLL_MNIT_CTL = 0x128 / 4,
+
+    ANALOG_DIGPROG = 0x800 / 4,
+    ANALOG_MAX,
+};
+
+enum IMX8MPCCMRegisters {
+    CCM_MAX = 0xc6fc / sizeof(uint32_t) + 1,
+};
+
+#define TYPE_IMX8MP_CCM "imx8mp.ccm"
+OBJECT_DECLARE_SIMPLE_TYPE(IMX8MPCCMState, IMX8MP_CCM)
+
+struct IMX8MPCCMState {
+    IMXCCMState parent_obj;
+
+    MemoryRegion iomem;
+
+    uint32_t ccm[CCM_MAX];
+};
+
+
+#define TYPE_IMX8MP_ANALOG "imx8mp.analog"
+OBJECT_DECLARE_SIMPLE_TYPE(IMX8MPAnalogState, IMX8MP_ANALOG)
+
+struct IMX8MPAnalogState {
+    IMXCCMState parent_obj;
+
+    struct {
+        MemoryRegion container;
+        MemoryRegion analog;
+    } mmio;
+
+    uint32_t analog[ANALOG_MAX];
+};
+
+#endif /* IMX8MP_CCM_H */
diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index 6b2cdb2c0a..311b8ee0cd 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -200,6 +200,10 @@ static void fsl_imx8mp_init(Object *obj)
 
     object_initialize_child(obj, "gic", &s->gic, TYPE_ARM_GICV3);
 
+    object_initialize_child(obj, "ccm", &s->ccm, TYPE_IMX8MP_CCM);
+
+    object_initialize_child(obj, "analog", &s->analog, TYPE_IMX8MP_ANALOG);
+
     for (i = 0; i < FSL_IMX8MP_NUM_UARTS; i++) {
         snprintf(name, NAME_SIZE, "uart%d", i + 1);
         object_initialize_child(obj, name, &s->uart[i], TYPE_IMX_SERIAL);
@@ -308,6 +312,20 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
         }
     }
 
+    /* CCM */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->ccm), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->ccm), 0,
+                    fsl_imx8mp_memmap[FSL_IMX8MP_CCM].addr);
+
+    /* Analog */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->analog), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->analog), 0,
+                    fsl_imx8mp_memmap[FSL_IMX8MP_ANA_PLL].addr);
+
     /* UARTs */
     for (i = 0; i < FSL_IMX8MP_NUM_UARTS; i++) {
         static const struct {
@@ -333,6 +351,8 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
     /* Unimplemented devices */
     for (i = 0; i < ARRAY_SIZE(fsl_imx8mp_memmap); i++) {
         switch (i) {
+        case FSL_IMX8MP_ANA_PLL:
+        case FSL_IMX8MP_CCM:
         case FSL_IMX8MP_GIC_DIST:
         case FSL_IMX8MP_GIC_REDIST:
         case FSL_IMX8MP_RAM:
diff --git a/hw/misc/imx8mp_ccm.c b/hw/misc/imx8mp_ccm.c
new file mode 100644
index 0000000000..17658eb876
--- /dev/null
+++ b/hw/misc/imx8mp_ccm.c
@@ -0,0 +1,315 @@
+/*
+ * Copyright (c) 2025 Bernhard Beschow <shentey@gmail.com>
+ *
+ * i.MX8MP CCM, PMU and ANALOG IP blocks emulation code
+ *
+ * Based on hw/misc/imx7_ccm.c
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+
+#include "hw/misc/imx8mp_ccm.h"
+#include "migration/vmstate.h"
+
+#include "trace.h"
+
+#define CKIH_FREQ 16000000 /* 16MHz crystal input */
+
+#define ANALOG_PLL_LOCK BIT(31)
+
+static void imx8mp_analog_reset(DeviceState *dev)
+{
+    IMX8MPAnalogState *s = IMX8MP_ANALOG(dev);
+
+    memset(s->analog, 0, sizeof(s->analog));
+
+    s->analog[ANALOG_AUDIO_PLL1_GEN_CTRL] = 0x00002010;
+    s->analog[ANALOG_AUDIO_PLL1_FDIV_CTL0] = 0x00145032;
+    s->analog[ANALOG_AUDIO_PLL1_FDIV_CTL1] = 0x00000000;
+    s->analog[ANALOG_AUDIO_PLL1_SSCG_CTRL] = 0x00000000;
+    s->analog[ANALOG_AUDIO_PLL1_MNIT_CTRL] = 0x00100103;
+    s->analog[ANALOG_AUDIO_PLL2_GEN_CTRL] = 0x00002010;
+    s->analog[ANALOG_AUDIO_PLL2_FDIV_CTL0] = 0x00145032;
+    s->analog[ANALOG_AUDIO_PLL2_FDIV_CTL1] = 0x00000000;
+    s->analog[ANALOG_AUDIO_PLL2_SSCG_CTRL] = 0x00000000;
+    s->analog[ANALOG_AUDIO_PLL2_MNIT_CTRL] = 0x00100103;
+    s->analog[ANALOG_VIDEO_PLL1_GEN_CTRL] = 0x00002010;
+    s->analog[ANALOG_VIDEO_PLL1_FDIV_CTL0] = 0x00145032;
+    s->analog[ANALOG_VIDEO_PLL1_FDIV_CTL1] = 0x00000000;
+    s->analog[ANALOG_VIDEO_PLL1_SSCG_CTRL] = 0x00000000;
+    s->analog[ANALOG_VIDEO_PLL1_MNIT_CTRL] = 0x00100103;
+    s->analog[ANALOG_DRAM_PLL_GEN_CTRL] = 0x00002010;
+    s->analog[ANALOG_DRAM_PLL_FDIV_CTL0] = 0x0012c032;
+    s->analog[ANALOG_DRAM_PLL_FDIV_CTL1] = 0x00000000;
+    s->analog[ANALOG_DRAM_PLL_SSCG_CTRL] = 0x00000000;
+    s->analog[ANALOG_DRAM_PLL_MNIT_CTRL] = 0x00100103;
+    s->analog[ANALOG_GPU_PLL_GEN_CTRL] = 0x00000810;
+    s->analog[ANALOG_GPU_PLL_FDIV_CTL0] = 0x000c8031;
+    s->analog[ANALOG_GPU_PLL_LOCKD_CTRL] = 0x0010003f;
+    s->analog[ANALOG_GPU_PLL_MNIT_CTRL] = 0x00280081;
+    s->analog[ANALOG_VPU_PLL_GEN_CTRL] = 0x00000810;
+    s->analog[ANALOG_VPU_PLL_FDIV_CTL0] = 0x0012c032;
+    s->analog[ANALOG_VPU_PLL_LOCKD_CTRL] = 0x0010003f;
+    s->analog[ANALOG_VPU_PLL_MNIT_CTRL] = 0x00280081;
+    s->analog[ANALOG_ARM_PLL_GEN_CTRL] = 0x00000810;
+    s->analog[ANALOG_ARM_PLL_FDIV_CTL0] = 0x000fa031;
+    s->analog[ANALOG_ARM_PLL_LOCKD_CTRL] = 0x0010003f;
+    s->analog[ANALOG_ARM_PLL_MNIT_CTRL] = 0x00280081;
+    s->analog[ANALOG_SYS_PLL1_GEN_CTRL] = 0x0aaaa810;
+    s->analog[ANALOG_SYS_PLL1_FDIV_CTL0] = 0x00190032;
+    s->analog[ANALOG_SYS_PLL1_LOCKD_CTRL] = 0x0010003f;
+    s->analog[ANALOG_SYS_PLL1_MNIT_CTRL] = 0x00280081;
+    s->analog[ANALOG_SYS_PLL2_GEN_CTRL] = 0x0aaaa810;
+    s->analog[ANALOG_SYS_PLL2_FDIV_CTL0] = 0x000fa031;
+    s->analog[ANALOG_SYS_PLL2_LOCKD_CTRL] = 0x0010003f;
+    s->analog[ANALOG_SYS_PLL2_MNIT_CTRL] = 0x00280081;
+    s->analog[ANALOG_SYS_PLL3_GEN_CTRL] = 0x00000810;
+    s->analog[ANALOG_SYS_PLL3_FDIV_CTL0] = 0x000fa031;
+    s->analog[ANALOG_SYS_PLL3_LOCKD_CTRL] = 0x0010003f;
+    s->analog[ANALOG_SYS_PLL3_MNIT_CTRL] = 0x00280081;
+    s->analog[ANALOG_OSC_MISC_CFG] = 0x00000000;
+    s->analog[ANALOG_ANAMIX_PLL_MNIT_CTL] = 0x00000000;
+    s->analog[ANALOG_DIGPROG] = 0x00824010;
+
+    /* all PLLs need to be locked */
+    s->analog[ANALOG_AUDIO_PLL1_GEN_CTRL] |= ANALOG_PLL_LOCK;
+    s->analog[ANALOG_AUDIO_PLL2_GEN_CTRL] |= ANALOG_PLL_LOCK;
+    s->analog[ANALOG_VIDEO_PLL1_GEN_CTRL] |= ANALOG_PLL_LOCK;
+    s->analog[ANALOG_DRAM_PLL_GEN_CTRL] |= ANALOG_PLL_LOCK;
+    s->analog[ANALOG_GPU_PLL_GEN_CTRL] |= ANALOG_PLL_LOCK;
+    s->analog[ANALOG_VPU_PLL_GEN_CTRL] |= ANALOG_PLL_LOCK;
+    s->analog[ANALOG_ARM_PLL_GEN_CTRL] |= ANALOG_PLL_LOCK;
+    s->analog[ANALOG_SYS_PLL1_GEN_CTRL] |= ANALOG_PLL_LOCK;
+    s->analog[ANALOG_SYS_PLL2_GEN_CTRL] |= ANALOG_PLL_LOCK;
+    s->analog[ANALOG_SYS_PLL3_GEN_CTRL] |= ANALOG_PLL_LOCK;
+}
+
+static void imx8mp_ccm_reset(DeviceState *dev)
+{
+    IMX8MPCCMState *s = IMX8MP_CCM(dev);
+
+    memset(s->ccm, 0, sizeof(s->ccm));
+}
+
+#define CCM_INDEX(offset)   (((offset) & ~(hwaddr)0xF) / sizeof(uint32_t))
+#define CCM_BITOP(offset)   ((offset) & (hwaddr)0xF)
+
+enum {
+    CCM_BITOP_NONE = 0x00,
+    CCM_BITOP_SET  = 0x04,
+    CCM_BITOP_CLR  = 0x08,
+    CCM_BITOP_TOG  = 0x0C,
+};
+
+static uint64_t imx8mp_set_clr_tog_read(void *opaque, hwaddr offset,
+                                        unsigned size)
+{
+    const uint32_t *mmio = opaque;
+
+    return mmio[CCM_INDEX(offset)];
+}
+
+static void imx8mp_set_clr_tog_write(void *opaque, hwaddr offset,
+                                     uint64_t value, unsigned size)
+{
+    const uint8_t  bitop = CCM_BITOP(offset);
+    const uint32_t index = CCM_INDEX(offset);
+    uint32_t *mmio = opaque;
+
+    switch (bitop) {
+    case CCM_BITOP_NONE:
+        mmio[index]  = value;
+        break;
+    case CCM_BITOP_SET:
+        mmio[index] |= value;
+        break;
+    case CCM_BITOP_CLR:
+        mmio[index] &= ~value;
+        break;
+    case CCM_BITOP_TOG:
+        mmio[index] ^= value;
+        break;
+    };
+}
+
+static const struct MemoryRegionOps imx8mp_set_clr_tog_ops = {
+    .read = imx8mp_set_clr_tog_read,
+    .write = imx8mp_set_clr_tog_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .impl = {
+        /*
+         * Our device would not work correctly if the guest was doing
+         * unaligned access. This might not be a limitation on the real
+         * device but in practice there is no reason for a guest to access
+         * this device unaligned.
+         */
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned = false,
+    },
+};
+
+static uint64_t imx8mp_analog_read(void *opaque, hwaddr offset, unsigned size)
+{
+    IMX8MPAnalogState *s = opaque;
+
+    return s->analog[offset >> 2];
+}
+
+static void imx8mp_analog_write(void *opaque, hwaddr offset,
+                                uint64_t value, unsigned size)
+{
+    IMX8MPAnalogState *s = opaque;
+
+    if (offset >> 2 == ANALOG_DIGPROG) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "Guest write to read-only ANALOG_DIGPROG register\n");
+    } else {
+        s->analog[offset >> 2] = value;
+    }
+}
+
+static const struct MemoryRegionOps imx8mp_analog_ops = {
+    .read = imx8mp_analog_read,
+    .write = imx8mp_analog_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned = false,
+    },
+};
+
+static void imx8mp_ccm_init(Object *obj)
+{
+    SysBusDevice *sd = SYS_BUS_DEVICE(obj);
+    IMX8MPCCMState *s = IMX8MP_CCM(obj);
+
+    memory_region_init_io(&s->iomem,
+                          obj,
+                          &imx8mp_set_clr_tog_ops,
+                          s->ccm,
+                          TYPE_IMX8MP_CCM ".ccm",
+                          sizeof(s->ccm));
+
+    sysbus_init_mmio(sd, &s->iomem);
+}
+
+static void imx8mp_analog_init(Object *obj)
+{
+    SysBusDevice *sd = SYS_BUS_DEVICE(obj);
+    IMX8MPAnalogState *s = IMX8MP_ANALOG(obj);
+
+    memory_region_init(&s->mmio.container, obj, TYPE_IMX8MP_ANALOG, 0x10000);
+
+    memory_region_init_io(&s->mmio.analog, obj, &imx8mp_analog_ops, s,
+                          TYPE_IMX8MP_ANALOG, sizeof(s->analog));
+    memory_region_add_subregion(&s->mmio.container, 0, &s->mmio.analog);
+
+    sysbus_init_mmio(sd, &s->mmio.container);
+}
+
+static const VMStateDescription vmstate_imx8mp_ccm = {
+    .name = TYPE_IMX8MP_CCM,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(ccm, IMX8MPCCMState, CCM_MAX),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static uint32_t imx8mp_ccm_get_clock_frequency(IMXCCMState *dev, IMXClk clock)
+{
+    /*
+     * This function is "consumed" by GPT emulation code. Some clocks
+     * have fixed frequencies and we can provide requested frequency
+     * easily. However for CCM provided clocks (like IPG) each GPT
+     * timer can have its own clock root.
+     * This means we need additional information when calling this
+     * function to know the requester's identity.
+     */
+    uint32_t freq = 0;
+
+    switch (clock) {
+    case CLK_NONE:
+        break;
+    case CLK_32k:
+        freq = CKIL_FREQ;
+        break;
+    case CLK_HIGH:
+        freq = CKIH_FREQ;
+        break;
+    case CLK_IPG:
+    case CLK_IPG_HIGH:
+        /*
+         * For now we don't have a way to figure out the device this
+         * function is called for. Until then the IPG derived clocks
+         * are left unimplemented.
+         */
+        qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: Clock %d Not implemented\n",
+                      TYPE_IMX8MP_CCM, __func__, clock);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: unsupported clock %d\n",
+                      TYPE_IMX8MP_CCM, __func__, clock);
+        break;
+    }
+
+    trace_ccm_clock_freq(clock, freq);
+
+    return freq;
+}
+
+static void imx8mp_ccm_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    IMXCCMClass *ccm = IMX_CCM_CLASS(klass);
+
+    device_class_set_legacy_reset(dc, imx8mp_ccm_reset);
+    dc->vmsd  = &vmstate_imx8mp_ccm;
+    dc->desc  = "i.MX8MP Clock Control Module";
+
+    ccm->get_clock_frequency = imx8mp_ccm_get_clock_frequency;
+}
+
+static const VMStateDescription vmstate_imx8mp_analog = {
+    .name = TYPE_IMX8MP_ANALOG,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(analog, IMX8MPAnalogState, ANALOG_MAX),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void imx8mp_analog_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_legacy_reset(dc, imx8mp_analog_reset);
+    dc->vmsd  = &vmstate_imx8mp_analog;
+    dc->desc  = "i.MX8MP Analog Module";
+}
+
+static const TypeInfo imx8mp_ccm_types[] = {
+    {
+        .name          = TYPE_IMX8MP_CCM,
+        .parent        = TYPE_IMX_CCM,
+        .instance_size = sizeof(IMX8MPCCMState),
+        .instance_init = imx8mp_ccm_init,
+        .class_init    = imx8mp_ccm_class_init,
+    },
+    {
+        .name          = TYPE_IMX8MP_ANALOG,
+        .parent        = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(IMX8MPAnalogState),
+        .instance_init = imx8mp_analog_init,
+        .class_init    = imx8mp_analog_class_init,
+    }
+};
+
+DEFINE_TYPES(imx8mp_ccm_types);
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 55f493521b..d556965821 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -65,6 +65,7 @@ system_ss.add(when: 'CONFIG_IMX', if_true: files(
   'imx7_src.c',
   'imx7_gpr.c',
   'imx7_snvs.c',
+  'imx8mp_ccm.c',
   'imx_ccm.c',
   'imx_rngc.c',
 ))
-- 
2.48.1


