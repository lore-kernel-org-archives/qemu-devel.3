Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECEE5C61DD6
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2026 04:21:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0AY7-0008Up-0a; Sat, 29 Aug 2026 00:20:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vae1207@gmail.com>) id 1x08Rj-0004nQ-CC
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 22:05:27 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vae1207@gmail.com>) id 1x08Rg-0007nF-Vx
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 22:05:27 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2caced6038eso16916625ad.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 19:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787969123; x=1788573923; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7R5WDd0jmooDcW5HPp0cRFbEdNBKPJFny5PovUq6WAE=;
 b=fspzbclDtvbh2BJ/IKBhiIU3e3p1gvLYKQ13oSsZeAit6i+rfFtRrIJz0dsQK2Jxwh
 qw/GcyMH9R1+Z67inugn057qAlaBl6gwLDA38wau9hidLth3hmIWxNmZyDUP3Ty/BIw7
 GzqiUiRcYkv+FGnoMMy1cvK6kpE4FJkA7oheNcVAPCIe4uaVrA1VZhLqbOJOpssh+RGx
 Y9uW36tq4OrLz4s8VTzXXd6hVSX32z5MdQNgrXHtZ62adVmdhxbp/52MzAhDLZQ1dSbj
 rX7V+a8clbwMi5ok/BxZ6xNc7J9xQtDCAdo7FrPYFiGvyWmfZtt0npedarRy/X46YAG6
 odCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787969123; x=1788573923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7R5WDd0jmooDcW5HPp0cRFbEdNBKPJFny5PovUq6WAE=;
 b=JK3LW/o0i19UZZNUDK8NslnFwF30vWpgKy9e2cWTrTfKMAqvtrtkWPGc6zHyau9UN9
 nZeLoKfwcCY9FG16rZma985j9D4zGfvUDeYw7eqCmy6z78qy5bbn26gv3SVpq8Q7Qqsw
 u1SKXTwPoGWxZ/c7vJGmBJS/eGlEC2aJN+EAcwnbgR6diNrT6bD3rwmf5AqTQ3icwXR5
 Pjrj2d7JKql+GhK2VWafzAKTAYF5e1w2xedbjUbB0tvARv5ZYb+fVYuSoOk9bjpOlScS
 yobDkOPl0wvWrXuBWA2nAxw6qVLRL2tj4IXAh1jmyBJ9j81MAHoVMmLK3DAPvSLR6Th8
 2RBg==
X-Gm-Message-State: AFuF++mskxmCMZ1csQSnwTvu12y91K/Ie6DKf3itfgZ8TNnSsWt3bBrn
 z/klvPNuKrgA+BPk5Bx5NYa92ipwR+QhBxKbz1E5KvNtYyuoUUUEv+OjMj7O0Tbz
X-Gm-Gg: AYBFou0XrFmGF49MOsTzsH/nYTLvg3OisE+/tjWGRljIuuKtWdeKVVtLgu5+4ReZwjq
 t+wxakCEgnV7Ys42H3SVOBVEG5QxivXSLPt2z3oXAZRyicAZIjCIix3LdGnOvUuMxUYzFri/KR4
 hFM3zgPA93dX01g04AlgH97GD27s9zuRd8W2eaPyValGKx3INrqsMdbqjVv5g3ZAhDxD1R4iq1Z
 0hj8GUWP6GkDAUq4Zl7MHE/3K3xl9bkzyAgZOxAeZf3EcvbqxYBtWu7G0LBYrEsiYJKJPjG9hLj
 3WJdV3E/Mb8LPeGX1kyxqrSzG2sLUUdfY/WNpb6q0S80wCfnghOlkNazqDHVLbg62V74kPaHVEo
 bmgSA7XQDBLYxHhh4vRs/kFYuCwm0gR6Aw1nUhciQ3IXpSq5bX8YtEu60TB2ZTT/4S6QZSRX/y0
 0S+2n99UHbdtnAilujBOgs5GNrUcDNAK84gSTi5oovrASTheidZ/AvGptYZHNCFmvZ2QjF68Veq
 Xb+1RpU
X-Received: by 2002:a17:903:2ec5:b0:2d6:fddf:a890 with SMTP id
 d9443c01a7336-2d72634612dmr244738765ad.6.1787969123178; 
 Fri, 28 Aug 2026 19:05:23 -0700 (PDT)
Received: from localhost.localdomain ([180.213.79.228])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d759869aeesm10592695ad.46.2026.08.28.19.05.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 19:05:22 -0700 (PDT)
From: JunWei Li <vae1207@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, chenhuacai@canaan-creative.com,
 JunWei Li <vae1207@gmail.com>
Subject: [PATCH 1/3] hw/misc: add K230 PMU device
Date: Sat, 29 Aug 2026 10:02:27 +0800
Message-Id: <20260829020229.389742-2-vae1207@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260829020229.389742-1-vae1207@gmail.com>
References: <20260829020229.389742-1-vae1207@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=vae1207@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 29 Aug 2026 00:20:10 -0400
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

Add a model of the K230 power management unit with the APB register bank, interrupt detection state and the two PMIC output pads, based on the K230 Technical Reference Manual V0.3.1 chapter 14.

The PMU registers keep their reset values and write masks from the TRM. PAD64..PAD69 inputs set the matching PMU_INT_STATE bit when the corresponding detection is enabled, and the interrupt line follows PMU_INT_STATE & PMU_INT0_TO_CPU. Writing PMU_SYSCTRL_REG drives the PAD70/PAD71 outputs. Long/short press timing, edge counting and debounce are not modelled yet.

Signed-off-by: JunWei Li <vae1207@gmail.com>
---
 MAINTAINERS                |   3 +
 hw/misc/Kconfig            |   3 +
 hw/misc/k230_pmu.c         | 242 +++++++++++++++++++++++++++++++++++++
 hw/misc/meson.build        |   1 +
 include/hw/misc/k230_pmu.h |  71 +++++++++++
 5 files changed, 320 insertions(+)
 create mode 100644 hw/misc/k230_pmu.c
 create mode 100644 include/hw/misc/k230_pmu.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 6171cc7494..49c165f71e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1824,10 +1824,13 @@ M: Chao Liu <chao.liu@processmission.com>
 L: qemu-riscv@nongnu.org
 S: Maintained
 F: docs/system/riscv/k230.rst
+F: hw/misc/k230_pmu.c
 F: hw/riscv/k230.c
 F: hw/watchdog/k230_wdt.c
+F: include/hw/misc/k230_pmu.h
 F: include/hw/riscv/k230.h
 F: include/hw/watchdog/k230_wdt.h
+F: tests/qtest/k230-pmu-test.c
 F: tests/qtest/k230-wdt-test.c
 
 RX Machines
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 1543ee6653..98a2ab3709 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -135,6 +135,9 @@ config RISCV_MIPS_CPC
 config RISCV_MIPS_CPS
     bool
 
+config K230_PMU
+    bool
+
 config MPS2_FPGAIO
     bool
     select LED
diff --git a/hw/misc/k230_pmu.c b/hw/misc/k230_pmu.c
new file mode 100644
index 0000000000..14a955dbd1
--- /dev/null
+++ b/hw/misc/k230_pmu.c
@@ -0,0 +1,242 @@
+/*
+ * K230 PMU device
+ *
+ * Copyright (c) 2026 LiJunWei <vae1207@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * K230 Technical Reference Manual V0.3.1 (2024-11-18):
+ * https://github.com/revyos/external-docs/blob/master/K230/en-us/K230_Technical_Reference_Manual_V0.3.1_20241118.pdf
+ *
+ * Minimal model of the PMU (TRM chapter 14): the APB register bank,
+ * the interrupt detection state and the two PMIC output pads.  The
+ * long/short press timing, edge counting and debounce units are not
+ * modelled yet.
+ */
+#include "qemu/osdep.h"
+
+#include "qemu/bitops.h"
+#include "qemu/log.h"
+#include "migration/vmstate.h"
+#include "hw/core/irq.h"
+#include "hw/core/sysbus.h"
+#include "hw/misc/k230_pmu.h"
+
+/* PMU_INT_DETECT_CLR bit i clears PMU_INT_STATE bit state_bit[i] */
+static const uint8_t state_bit[10] = {
+    [0] = 3, [1] = 4, [2] = 5, [3] = 6, [4] = 7,
+    [5] = 8, [6] = 9, [7] = 10, [8] = 0, [9] = 11,
+};
+
+/*
+ * PAD64..PAD69 edge/level detection.  For these inputs the
+ * PMU_INT_DETECT_EN enable bit and the PMU_INT_STATE state bit
+ * coincide.
+ */
+static const uint8_t input_bit[K230_PMU_INPUTS] = { 9, 7, 6, 5, 4, 3 };
+
+static void k230_pmu_update_irq(K230PmuState *s)
+{
+    qemu_set_irq(s->irq,
+                 (s->regs[R_INT_STATE] &
+                  s->regs[R_INT0_TO_CPU] & 0xfff) != 0);
+}
+
+static void k230_pmu_gpio_in(void *opaque, int n, int level)
+{
+    K230PmuState *s = opaque;
+    uint32_t bit = BIT(input_bit[n]);
+
+    if (level && (s->regs[R_INT_DETECT_EN] & bit)) {
+        s->regs[R_INT_STATE] |= bit;
+        k230_pmu_update_irq(s);
+    }
+}
+
+static uint64_t k230_pmu_read(void *opaque, hwaddr offset, unsigned size)
+{
+    K230PmuState *s = opaque;
+
+    if (offset >= K230_PMU_REG_COUNT * 4) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: read from invalid offset 0x%" HWADDR_PRIx "\n",
+                      TYPE_K230_PMU, offset);
+        return 0;
+    }
+
+    return s->regs[offset / 4];
+}
+
+static void k230_pmu_write(void *opaque, hwaddr offset, uint64_t value,
+                           unsigned size)
+{
+    K230PmuState *s = opaque;
+    uint32_t mask;
+
+    if (offset >= K230_PMU_REG_COUNT * 4) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: write to invalid offset 0x%" HWADDR_PRIx "\n",
+                      TYPE_K230_PMU, offset);
+        return;
+    }
+
+    switch (offset / 4) {
+    case R_INT_DETECT_CLR:      /* W1C */
+        for (unsigned int i = 0; i < ARRAY_SIZE(state_bit); i++) {
+            if (value & BIT(i)) {
+                s->regs[R_INT_STATE] &= ~BIT(state_bit[i]);
+            }
+        }
+        k230_pmu_update_irq(s);
+        return;
+    case R_INT_STATE:           /* RO */
+        return;
+    case R_SYSCTRL:             /* drives PAD70/71 */
+        s->regs[R_SYSCTRL] = value & 0x3;
+        qemu_set_irq(s->pad[0], s->regs[R_SYSCTRL] & BIT(0));
+        qemu_set_irq(s->pad[1], s->regs[R_SYSCTRL] & BIT(1));
+        return;
+    case R_INT0_TO_CTL:
+    case R_INT1_TO_CTL:
+    case R_INT0_TO_CPU:
+    case R_INT_DETECT_EN:
+    case R_OUT_EVENT_CTRL:
+        mask = 0x1fff;          /* [12:0] */
+        break;
+    case R_INT_DETECT_TYP:
+        mask = 0x1fffff;        /* [20:0] */
+        break;
+    case R_LONG_PRESS_TRIGGER:
+    case R_LONG_PRESS_SHUTDOWN:
+        mask = 0xfffff;         /* [19:0] */
+        break;
+    case R_SHORT_PRESS_TRIGGER:
+    case R_NORMAL_TIMER_VAL:
+        mask = 0xffff;          /* [15:0] */
+        break;
+    case R_LEVEL_DEBOUNCE:
+    case R_INT1_LEVEL_DEBOUNCE:
+    case R_INT2_LEVEL_DEBOUNCE:
+    case R_INT3_LEVEL_DEBOUNCE:
+        mask = 0xfff;           /* [11:0] */
+        break;
+    case R_EDGE_NUMBER:
+        mask = 0x3ff;           /* [9:0] */
+        break;
+    case R_OUT_DELAY_SET:
+        mask = 0x3ffffff;       /* [25:0] */
+        break;
+    case R_IO_CFG0:
+    case R_IO_CFG0 + 1:
+    case R_IO_CFG0 + 2:
+    case R_IO_CFG0 + 3:
+    case R_IO_CFG0 + 4:
+    case R_IO_CFG0 + 5:
+    case R_IO_CFG6:
+    case R_IO_CFG7:
+        mask = 0x3def;          /* [9] and [4] are reserved */
+        break;
+    default:
+        mask = 0xffffffff;
+        break;
+    }
+
+    s->regs[offset / 4] = (s->regs[offset / 4] & ~mask) | (value & mask);
+    k230_pmu_update_irq(s);
+}
+
+static void k230_pmu_reset(Object *obj, ResetType type)
+{
+    K230PmuState *s = K230_PMU(obj);
+
+    memset(s->regs, 0, sizeof(s->regs));
+    s->regs[R_INT0_TO_CTL] = 0xfff;
+    s->regs[R_INT1_TO_CTL] = 0xfff;
+    s->regs[R_INT_DETECT_EN] = 0x810;
+    s->regs[R_LONG_PRESS_TRIGGER] = 0x17700;
+    s->regs[R_LONG_PRESS_SHUTDOWN] = 0x4e200;
+    s->regs[R_SHORT_PRESS_TRIGGER] = 0x3e800;
+    s->regs[R_LEVEL_DEBOUNCE] = 0x100;
+    s->regs[R_EDGE_NUMBER] = 0x1;
+    s->regs[R_INT1_LEVEL_DEBOUNCE] = 0x100;
+    s->regs[R_INT2_LEVEL_DEBOUNCE] = 0x100;
+    s->regs[R_INT3_LEVEL_DEBOUNCE] = 0x100;
+    s->regs[R_SYSCTRL] = 0x1;
+    s->regs[R_OUT_DELAY_SET] = 0x1100640;
+    for (unsigned int i = 0; i < 6; i++) {
+        s->regs[R_IO_CFG0 + i] = 0x1124;
+    }
+    s->regs[R_IO_CFG6] = 0x10a4;
+    s->regs[R_IO_CFG7] = 0x1084;
+    s->regs[R_NORMAL_TIMER_VAL] = 0x780;
+    s->regs[R_OUT_EVENT_CTRL] = 0x5c;
+    s->regs[R_OUT_LOGIC_CTRL] = 0x2;
+
+    k230_pmu_update_irq(s);
+    qemu_set_irq(s->pad[0], s->regs[R_SYSCTRL] & BIT(0));
+    qemu_set_irq(s->pad[1], s->regs[R_SYSCTRL] & BIT(1));
+}
+
+static const MemoryRegionOps k230_pmu_ops = {
+    .read = k230_pmu_read,
+    .write = k230_pmu_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static const VMStateDescription vmstate_k230_pmu = {
+    .name = TYPE_K230_PMU,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, K230PmuState, K230_PMU_REG_COUNT),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void k230_pmu_init(Object *obj)
+{
+    K230PmuState *s = K230_PMU(obj);
+
+    memory_region_init_io(&s->iomem, obj, &k230_pmu_ops, s,
+                          TYPE_K230_PMU, K230_PMU_MMIO_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->pad[0]);
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->pad[1]);
+
+    qdev_init_gpio_in(DEVICE(obj), k230_pmu_gpio_in, K230_PMU_INPUTS);
+}
+
+static void k230_pmu_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    dc->desc = "K230 PMU";
+    dc->vmsd = &vmstate_k230_pmu;
+    rc->phases.enter = k230_pmu_reset;
+}
+
+static const TypeInfo k230_pmu_type_info = {
+    .name = TYPE_K230_PMU,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(K230PmuState),
+    .instance_init = k230_pmu_init,
+    .class_init = k230_pmu_class_init,
+};
+
+static void k230_pmu_register_types(void)
+{
+    type_register_static(&k230_pmu_type_info);
+}
+
+type_init(k230_pmu_register_types)
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 23265f6035..7eaff69081 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -28,6 +28,7 @@ system_ss.add(when: 'CONFIG_IOSB', if_true: files('iosb.c'))
 system_ss.add(when: 'CONFIG_VIRT_CTRL', if_true: files('virt_ctrl.c'))
 
 # RISC-V devices
+system_ss.add(when: 'CONFIG_K230_PMU', if_true: files('k230_pmu.c'))
 system_ss.add(when: 'CONFIG_MCHP_PFSOC_DMC', if_true: files('mchp_pfsoc_dmc.c'))
 system_ss.add(when: 'CONFIG_MCHP_PFSOC_IOSCB', if_true: files('mchp_pfsoc_ioscb.c'))
 system_ss.add(when: 'CONFIG_MCHP_PFSOC_SYSREG', if_true: files('mchp_pfsoc_sysreg.c'))
diff --git a/include/hw/misc/k230_pmu.h b/include/hw/misc/k230_pmu.h
new file mode 100644
index 0000000000..48f5052f61
--- /dev/null
+++ b/include/hw/misc/k230_pmu.h
@@ -0,0 +1,71 @@
+/*
+ * K230 PMU device
+ *
+ * Copyright (c) 2026 LiJunWei <vae1207@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_K230_PMU_H
+#define HW_MISC_K230_PMU_H
+
+#include "hw/core/registerfields.h"
+#include "hw/core/sysbus.h"
+
+REG32(LOGGER, 0x000)
+REG32(INT0_TO_CTL, 0x040)
+REG32(INT1_TO_CTL, 0x044)
+REG32(INT0_TO_CPU, 0x048)
+REG32(INT_DETECT_EN, 0x04c)
+    FIELD(INT_DETECT_EN, INT1_EDGE_NUM_TICK_EN, 0, 1)
+    FIELD(INT_DETECT_EN, INT7_EN, 1, 1)
+    FIELD(INT_DETECT_EN, INT6_EN, 2, 1)
+    FIELD(INT_DETECT_EN, INT5_EDGE_LEVEL_EN, 3, 1)
+    FIELD(INT_DETECT_EN, INT4_EDGE_LEVEL_EN, 4, 1)
+    FIELD(INT_DETECT_EN, INT3_EDGE_LEVEL_EN, 5, 1)
+    FIELD(INT_DETECT_EN, INT2_EDGE_LEVEL_EN, 6, 1)
+    FIELD(INT_DETECT_EN, INT1_EDGE_LEVEL_EN, 7, 1)
+    FIELD(INT_DETECT_EN, INT1_EDGE_NUM_EN, 8, 1)
+    FIELD(INT_DETECT_EN, INT0_EDGE_LEVEL_EN, 9, 1)
+    FIELD(INT_DETECT_EN, INT0_SHORT_PRESS_EN, 10, 1)
+    FIELD(INT_DETECT_EN, INT0_LONG_PRESS_EN, 11, 1)
+    FIELD(INT_DETECT_EN, INT0_SHUTDOWN_PRESS_EN, 12, 1)
+REG32(INT_DETECT_TYP, 0x050)
+REG32(INT_DETECT_CLR, 0x054)
+REG32(LONG_PRESS_TRIGGER, 0x058)
+REG32(LONG_PRESS_SHUTDOWN, 0x05c)
+REG32(SHORT_PRESS_TRIGGER, 0x060)
+REG32(LEVEL_DEBOUNCE, 0x064)
+REG32(EDGE_NUMBER, 0x068)
+REG32(INT1_LEVEL_DEBOUNCE, 0x06c)
+REG32(INT2_LEVEL_DEBOUNCE, 0x070)
+REG32(INT3_LEVEL_DEBOUNCE, 0x074)
+REG32(SYSCTRL, 0x078)
+REG32(OUT_DELAY_SET, 0x07c)
+REG32(IO_CFG0, 0x080)
+REG32(IO_CFG6, 0x098)
+REG32(IO_CFG7, 0x09c)
+REG32(NORMAL_TIMER_VAL, 0x0a0)
+REG32(OUT_EVENT_CTRL, 0x0a4)
+REG32(OUT_LOGIC_CTRL, 0x0a8)
+REG32(INT_STATE, 0x0ac)
+
+#define K230_PMU_MMIO_SIZE   0xc00
+#define K230_PMU_REG_COUNT   (R_INT_STATE + 1)
+#define K230_PMU_INPUTS      6
+#define K230_PMU_OUTPUTS     2
+
+#define TYPE_K230_PMU "riscv.k230.pmu"
+OBJECT_DECLARE_SIMPLE_TYPE(K230PmuState, K230_PMU)
+
+struct K230PmuState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    qemu_irq irq;
+    qemu_irq pad[K230_PMU_OUTPUTS];
+
+    uint32_t regs[K230_PMU_REG_COUNT];
+};
+
+#endif /* HW_MISC_K230_PMU_H */
-- 
2.20.1


