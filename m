Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E1B606A31E
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 14:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aPXW5btI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNAWr-0000z9-Pi; Sat, 31 Oct 2026 10:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dovankhai97@gmail.com>)
 id 1xNAR9-0008OA-41
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 10:52:05 -0400
Received: from mail-dy1-x1331.google.com ([2607:f8b0:4864:20::1331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dovankhai97@gmail.com>)
 id 1xNAR5-0006Ya-Ow
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 10:52:02 -0400
Received: by mail-dy1-x1331.google.com with SMTP id
 5a478bee46e88-36661f953e4so2565842eec.1
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 07:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793458317; x=1794063117; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=o0w7XcUFgWTWzodYVb9xluA3Z7upoFe97lvtKvW/hlI=;
 b=aPXW5btItBtIQlArFAp8iqxRMlUKN6aYCKV/ohJcsRelEAx+2II01c5OUlDtH3JIPp
 A2CpOdQRBWsIuVwBHe44EWyi0ojwdKuZAVDrQCEazg8Qd99mTXA5/i+9LW0XkvLcm5FJ
 PaQY521SPs6KLlxYpz3/dvrsPZI0q1UnoFQBM2AfTIGElxjTAzoq3bjJ8FSlWF1ZCOds
 OYPg4Maa3Hobc89Lu5WIdCzOBg/s11+Snn366OY0wC2/25w+1UwPxWAAHK182Lwth7GO
 yQZ3bKv203iWk8s2h/jbwX8jrsjxRXg+C02Q5xzkqaVxHkhjJk7j0ahlOFcr5OpJFLpv
 2+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793458317; x=1794063117;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=o0w7XcUFgWTWzodYVb9xluA3Z7upoFe97lvtKvW/hlI=;
 b=J4saZco023UzK9rcqyWDqYpRGJP7Uk/wgieJVhon5KlF21L5MoOOhmzgH7qd00evTt
 7rwq70jcOVwrXZYB2Wajd7NVGlRIiU6qxmAcZSMhyvhCrdXCE/vaCtu+nkGYRWM6eQ1A
 qkPFEDPPPut963NEGOOWeznHOCJzYaMGUApCmD/CwEv5FlKcBMhIeRyaFumB/uIx0MKS
 povG2KwyG5m5S+skHdlSLowfaTHmn7YY8G5+Bhp/nBwJR2Aujhj4Nf0boP7jeQ1vPpnp
 ULFlXtbFucJDxdzdH+/pOhdgQJZwJr+a0uop4STZwqABa2suIdxYxVcZRvNhmRRor/Js
 9jKg==
X-Gm-Message-State: AFq9FYIIP0NMERGlxAXhIeAEQmmO5t7Mv7MrF9ApDV3/7R7Pbcvwc2A3
 zB9JhKDLOI2gISPJ+/npJ6vEUVDrNj8+zgOJcTO06sm9+qVyjMl2wrA68LUzpLHy
X-Gm-Gg: AYBFou3Q6YqFCo7Ow7w0nuSrspyy17VzDABkiKivabnLNxKJBUV+8jp3NorAGWf11x4
 aZh7GUjDt7WHrBVE+tIUwNYl++jzgzlNxA4SjReSI532ZtiWd6lSCnfnlnlSOctCKPQW1dLGAaO
 2f2ESzyIhkmPpmbZXdwqkSTEkIrmUn0+PJhCbcP/0VIq4r13QtVMq43kdVDWw7uJjmuFSAPXRhf
 GOsqvxyMTXndCLokMp2BLBcnGTI2qgFK4CLoIMldPfq7aY1XZbJlrC5/0/OOM623a51UmgPtRHc
 vSJycWF45xWRlgBCiVsgthi0d/IqAZTENUg+AI/AUrtX4cDmXTh8XhtQhl6WzXGs6F3lXQDEj7e
 kd5iCKoLDT7x5QhuuJ8bLstPKhTxy867tSjXcDvUZcB3cxtQsbNIa/mXGQxtqpELtXmewQ03gip
 j77Ou7DEmlG8EhvVxL84W0ScrNiMOfuOWU2tGS4WmTLf6GburfFhCGuTrNruH8M0EDgAuLjuZCh
 4Gb+yUrrm3lZhKaJ9O2VQL4LykGLQ+etTbFVnljun78VQJ1NOtNW3+d1rlMuCNVZC5tjQfOlKJC
 IDt/fS5Dsc0cFINIrAzYeTzikJhUIsXg
X-Received: by 2002:a05:7300:b098:b0:369:3e30:c665 with SMTP id
 5a478bee46e88-36a423fb4a1mr7252257eec.33.1793458316206; 
 Sat, 31 Oct 2026 07:51:56 -0700 (PDT)
Received: from ubuntu.lan ([2405:4802:913e:86f0:fc32:76b2:b6d6:a3f6])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a428c17bdsm17541006eec.6.2026.10.31.07.51.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 07:51:55 -0700 (PDT)
From: Khai Do <dovankhai97@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com,
 strahinja.p.jankovic@gmail.com, Khai Do <dovankhai97@gmail.com>
Subject: [PATCH 1/5] hw/arm/allwinner-h618: Add Allwinner H618 SoC emulation
Date: Sat, 31 Oct 2026 21:51:43 +0700
Message-ID: <20261031145147.32683-2-dovankhai97@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261031145147.32683-1-dovankhai97@gmail.com>
References: <20261031145147.32683-1-dovankhai97@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1331;
 envelope-from=dovankhai97@gmail.com; helo=mail-dy1-x1331.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 31 Oct 2026 10:57:53 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Allwinner H618 is a 64-bit quad-core Cortex-A53 SoC. This commit
adds baseline SoC emulation including:
- 4x Cortex-A53 cores with PSCI conduit for SMP
- ARM GICv2 interrupt controller and generic timer PPI connections
- SRAM A1, SRAM A2, and 16550 UART0/1 controllers
- Unimplemented memory regions for non-critical peripherals

Signed-off-by: Khai Do <dovankhai97@gmail.com>
---
 MAINTAINERS                     |   7 +
 hw/arm/Kconfig                  |   7 +
 hw/arm/allwinner-h618.c         | 224 ++++++++++++++++++++++++++++++++
 hw/arm/meson.build              |   1 +
 include/hw/arm/allwinner-h618.h |  57 ++++++++
 5 files changed, 296 insertions(+)
 create mode 100644 hw/arm/allwinner-h618.c
 create mode 100644 include/hw/arm/allwinner-h618.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 70e9fed776..68f1c31d60 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -779,6 +779,13 @@ F: hw/arm/orangepi.c
 F: docs/system/arm/orangepi.rst
 F: tests/functional/arm/test_orangepi.py
 
+Allwinner-h618
+M: Khai Do <dovankhai97@gmail.com>
+L: qemu-arm@nongnu.org
+S: Maintained
+F: hw/*/allwinner-h618*
+F: include/hw/*/allwinner-h618*
+
 ARM PrimeCell and CMSDK devices
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index e9f796f718..616beae7bf 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -333,6 +333,13 @@ config ALLWINNER_R40
     select USB_EHCI_SYSBUS
     select SD
 
+config ALLWINNER_H618
+    bool
+    default y if TCG && AARCH64
+    select SERIAL_MM
+    select ARM_GIC
+    select UNIMP
+
 config MAX78000_SOC
     bool
     select ARM_V7M
diff --git a/hw/arm/allwinner-h618.c b/hw/arm/allwinner-h618.c
new file mode 100644
index 0000000000..59e0196fc6
--- /dev/null
+++ b/hw/arm/allwinner-h618.c
@@ -0,0 +1,224 @@
+/*
+ * Allwinner H618 System on Chip emulation
+ *
+ * Copyright (C) 2026 Khai Do <dovankhai97@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "qemu/module.h"
+#include "qemu/units.h"
+#include "hw/core/qdev.h"
+#include "hw/core/sysbus.h"
+#include "hw/char/serial-mm.h"
+#include "hw/misc/unimp.h"
+#include "system/system.h"
+#include "system/address-spaces.h"
+#include "hw/arm/allwinner-h618.h"
+#include "target/arm/cpu-qom.h"
+#include "target/arm/gtimer.h"
+
+/* Memory map */
+const hwaddr allwinner_h618_memmap[] = {
+    [AW_H618_DEV_SRAM_A1]  = 0x00020000,
+    [AW_H618_DEV_SRAM_A2]  = 0x00100000,
+    [AW_H618_DEV_GIC_DIST] = 0x03021000,
+    [AW_H618_DEV_GIC_CPU]  = 0x03022000,
+    [AW_H618_DEV_GIC_HYP]  = 0x03024000,
+    [AW_H618_DEV_GIC_VCPU] = 0x03026000,
+    [AW_H618_DEV_UART0]    = 0x05000000,
+    [AW_H618_DEV_UART1]    = 0x05000400,
+    [AW_H618_DEV_UART2]    = 0x05000800,
+    [AW_H618_DEV_UART3]    = 0x05000c00,
+    [AW_H618_DEV_SDRAM]    = 0x40000000,
+};
+
+/* List of unimplemented devices */
+static const struct AwH618Unimplemented {
+    const char *device_name;
+    hwaddr base;
+    hwaddr size;
+} unimplemented[] = {
+    { "ccu",       0x03001000, 4 * KiB },
+    { "dma",       0x03002000, 4 * KiB },
+    { "sid",       0x03006000, 4 * KiB },
+    { "smc",       0x03007000, 4 * KiB },
+    { "timer",     0x03009000, 4 * KiB },
+    { "pwm",       0x0300a000, 4 * KiB },
+    { "pio",       0x0300b000, 4 * KiB },
+    { "mmc0",      0x04020000, 4 * KiB },
+    { "mmc1",      0x04021000, 4 * KiB },
+    { "mmc2",      0x04022000, 4 * KiB },
+    { "rtc",       0x07000000, 4 * KiB },
+    { "prcm",      0x07010000, 4 * KiB },
+    { "r_pio",     0x07022000, 4 * KiB },
+    { "r_uart",    0x07080000, 4 * KiB },
+};
+
+/* Interrupt mapping */
+enum {
+    AW_H618_GIC_PPI_MAINT     =  9,
+    AW_H618_GIC_PPI_HYPTIMER  = 10,
+    AW_H618_GIC_PPI_VIRTTIMER = 11,
+    AW_H618_GIC_PPI_SECTIMER  = 13,
+    AW_H618_GIC_PPI_PHYSTIMER = 14
+};
+
+enum {
+    AW_H618_GIC_SPI_UART0 = 0,
+    AW_H618_GIC_SPI_UART1 = 1,
+    AW_H618_GIC_SPI_UART2 = 2,
+    AW_H618_GIC_SPI_UART3 = 3,
+};
+
+enum {
+    AW_H618_GIC_NUM_SPI = 128
+};
+
+static void allwinner_h618_init(Object *obj)
+{
+    AwH618State *s = AW_H618(obj);
+    int i;
+
+    s->memmap = allwinner_h618_memmap;
+
+    for (i = 0; i < AW_H618_NUM_CPUS; i++) {
+        object_initialize_child(obj, "cpu[*]", &s->cpus[i],
+                                ARM_CPU_TYPE_NAME("cortex-a53"));
+    }
+
+    object_initialize_child(obj, "gic", &s->gic, TYPE_ARM_GIC);
+}
+
+static void allwinner_h618_realize(DeviceState *dev, Error **errp)
+{
+    AwH618State *s = AW_H618(dev);
+    unsigned int i;
+
+    /* CPUs */
+    for (i = 0; i < AW_H618_NUM_CPUS; i++) {
+        /* Disable secondary CPUs until brought up by firmware/kernel */
+        qdev_prop_set_bit(DEVICE(&s->cpus[i]), "start-powered-off",
+                          i > 0);
+
+        /*
+         * Enable PSCI emulation with SMC calls so secondary CPUs
+         * can be brought up.
+         */
+        qdev_prop_set_uint32(DEVICE(&s->cpus[i]), "psci-conduit",
+                             QEMU_PSCI_CONDUIT_SMC);
+
+        /* Mark realized */
+        qdev_realize(DEVICE(&s->cpus[i]), NULL, &error_fatal);
+    }
+
+    /* Generic Interrupt Controller */
+    qdev_prop_set_uint32(DEVICE(&s->gic), "num-irq", AW_H618_GIC_NUM_SPI +
+                                                     GIC_INTERNAL);
+    qdev_prop_set_uint32(DEVICE(&s->gic), "revision", 2);
+    qdev_prop_set_uint32(DEVICE(&s->gic), "num-cpu", AW_H618_NUM_CPUS);
+    qdev_prop_set_bit(DEVICE(&s->gic), "has-security-extensions", false);
+    qdev_prop_set_bit(DEVICE(&s->gic), "has-virtualization-extensions", true);
+    sysbus_realize(SYS_BUS_DEVICE(&s->gic), &error_fatal);
+
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 0,
+                    s->memmap[AW_H618_DEV_GIC_DIST]);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 1,
+                    s->memmap[AW_H618_DEV_GIC_CPU]);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 2,
+                    s->memmap[AW_H618_DEV_GIC_VCPU]);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 3,
+                    s->memmap[AW_H618_DEV_GIC_HYP]);
+
+    /* Connect GIC outputs to CPU interrupt inputs and CPU timer to GIC PPI */
+    for (i = 0; i < AW_H618_NUM_CPUS; i++) {
+        DeviceState *cpudev = DEVICE(&s->cpus[i]);
+        int ppibase = AW_H618_GIC_NUM_SPI + i * GIC_INTERNAL + GIC_NR_SGIS;
+        int irq;
+        /*
+         * Mapping from the output timer irq lines from the CPU to the
+         * GIC PPI inputs used for this board.
+         */
+        const int timer_irq[] = {
+            [GTIMER_PHYS] = AW_H618_GIC_PPI_PHYSTIMER,
+            [GTIMER_VIRT] = AW_H618_GIC_PPI_VIRTTIMER,
+            [GTIMER_HYP]  = AW_H618_GIC_PPI_HYPTIMER,
+            [GTIMER_SEC]  = AW_H618_GIC_PPI_SECTIMER,
+        };
+
+        /* Connect CPU timer outputs to GIC PPI inputs */
+        for (irq = 0; irq < ARRAY_SIZE(timer_irq); irq++) {
+            qdev_connect_gpio_out(cpudev, irq,
+                                  qdev_get_gpio_in(DEVICE(&s->gic),
+                                                   ppibase + timer_irq[irq]));
+        }
+
+        /* Connect GIC outputs to CPU interrupt inputs */
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gic), i,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gic), i + AW_H618_NUM_CPUS,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gic), i + (2 * AW_H618_NUM_CPUS),
+                           qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gic), i + (3 * AW_H618_NUM_CPUS),
+                           qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
+
+        /* GIC maintenance signal */
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gic), i + (4 * AW_H618_NUM_CPUS),
+                           qdev_get_gpio_in(DEVICE(&s->gic),
+                                            ppibase + AW_H618_GIC_PPI_MAINT));
+    }
+
+    /* SRAM */
+    memory_region_init_ram(&s->sram_a1, OBJECT(dev), "sram A1",
+                           64 * KiB, &error_abort);
+    memory_region_init_ram(&s->sram_a2, OBJECT(dev), "sram A2",
+                           48 * KiB, &error_abort);
+    memory_region_add_subregion(get_system_memory(),
+                                s->memmap[AW_H618_DEV_SRAM_A1], &s->sram_a1);
+    memory_region_add_subregion(get_system_memory(),
+                                s->memmap[AW_H618_DEV_SRAM_A2], &s->sram_a2);
+
+    /* UART0 */
+    serial_mm_init(get_system_memory(), s->memmap[AW_H618_DEV_UART0], 2,
+                   qdev_get_gpio_in(DEVICE(&s->gic), AW_H618_GIC_SPI_UART0),
+                   115200, serial_hd(0), DEVICE_LITTLE_ENDIAN);
+    /* UART1 */
+    serial_mm_init(get_system_memory(), s->memmap[AW_H618_DEV_UART1], 2,
+                   qdev_get_gpio_in(DEVICE(&s->gic), AW_H618_GIC_SPI_UART1),
+                   115200, serial_hd(1), DEVICE_LITTLE_ENDIAN);
+
+    /* Unimplemented devices */
+    for (i = 0; i < ARRAY_SIZE(unimplemented); i++) {
+        create_unimplemented_device(unimplemented[i].device_name,
+                                    unimplemented[i].base,
+                                    unimplemented[i].size);
+    }
+}
+
+static void allwinner_h618_class_init(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->realize = allwinner_h618_realize;
+    /* Reason: uses serial_hd() in realize function */
+    dc->user_creatable = false;
+}
+
+static const TypeInfo allwinner_h618_type_info = {
+    .name = TYPE_AW_H618,
+    .parent = TYPE_DEVICE,
+    .instance_size = sizeof(AwH618State),
+    .instance_init = allwinner_h618_init,
+    .class_init = allwinner_h618_class_init,
+};
+
+static void allwinner_h618_register_types(void)
+{
+    type_register_static(&allwinner_h618_type_info);
+}
+
+type_init(allwinner_h618_register_types)
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index bcc068de04..42ed065b17 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -24,6 +24,7 @@ arm_common_ss.add(when: 'CONFIG_OMAP', if_true: files('omap1.c'))
 arm_common_ss.add(when: 'CONFIG_ALLWINNER_A10', if_true: files('allwinner-a10.c', 'cubieboard.c'))
 arm_common_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-h3.c', 'orangepi.c'))
 arm_common_ss.add(when: 'CONFIG_ALLWINNER_R40', if_true: files('allwinner-r40.c', 'bananapi_m2u.c'))
+arm_common_ss.add(when: 'CONFIG_ALLWINNER_H618', if_true: files('allwinner-h618.c'))
 arm_common_ss.add(when: 'CONFIG_MAX78000_SOC', if_true: files('max78000_soc.c'))
 arm_common_ss.add(when: 'CONFIG_RASPI', if_true: files(
   'bcm2836.c',
diff --git a/include/hw/arm/allwinner-h618.h b/include/hw/arm/allwinner-h618.h
new file mode 100644
index 0000000000..e1b7162759
--- /dev/null
+++ b/include/hw/arm/allwinner-h618.h
@@ -0,0 +1,57 @@
+/*
+ * Allwinner H618 System on Chip emulation
+ *
+ * Copyright (C) 2026 Khai Do <dovankhai97@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_ARM_ALLWINNER_H618_H
+#define HW_ARM_ALLWINNER_H618_H
+
+#include "qom/object.h"
+#include "hw/intc/arm_gic.h"
+#include "target/arm/cpu.h"
+
+/**
+ * Allwinner H618 device list
+ */
+enum {
+    AW_H618_DEV_SRAM_A1,
+    AW_H618_DEV_SRAM_A2,
+    AW_H618_DEV_GIC_DIST,
+    AW_H618_DEV_GIC_CPU,
+    AW_H618_DEV_GIC_HYP,
+    AW_H618_DEV_GIC_VCPU,
+    AW_H618_DEV_UART0,
+    AW_H618_DEV_UART1,
+    AW_H618_DEV_UART2,
+    AW_H618_DEV_UART3,
+    AW_H618_DEV_SDRAM
+};
+
+/** Total number of CPU cores in the H618 SoC */
+#define AW_H618_NUM_CPUS (4)
+
+/** Object type for the Allwinner H618 SoC */
+#define TYPE_AW_H618 "allwinner-h618"
+
+/** Convert input object to Allwinner H618 state object */
+OBJECT_DECLARE_SIMPLE_TYPE(AwH618State, AW_H618)
+
+/**
+ * Allwinner H618 object
+ */
+struct AwH618State {
+    /*< private >*/
+    DeviceState parent_obj;
+    /*< public >*/
+
+    ARMCPU cpus[AW_H618_NUM_CPUS];
+    const hwaddr *memmap;
+    GICState gic;
+    MemoryRegion sram_a1;
+    MemoryRegion sram_a2;
+};
+
+#endif /* HW_ARM_ALLWINNER_H618_H */
-- 
2.43.0


