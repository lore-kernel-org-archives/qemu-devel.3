Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC5CFC5DF71
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 06:35:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUIhb-0005lZ-7Z; Tue, 02 Jun 2026 02:34:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wUIhS-0005gV-P2
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 02:34:07 -0400
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wUIhN-0004bs-Qe
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 02:34:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DjLZDfEv8/A+I22UeT8ZwoNYnqb/nhMyOSn6nEVOGohu8ea40xVoDS8Usm/jHn6Q3Abr0pR61H3Pn3Vx/z8cDKv08qGid6gnyd/wwan6QSyJXtw/cYwPO/kgploB0818oxBb6i3H/Oa6YhCSMhAUyB5+ehwWdsfrgUgioZBDmTMuUlt3huN/3q6vIjVyEgCsSOdnuIrQtdDN1jLpRiT8xNBnOR20z5s5MOZodYQNHFYCZ5TMA/wWRe9oJIS1IuM5yh5dI/EB53ma7kyt2IkpTbhfWKCAh4dN5FamMI1J0pgitwAhkKhZE/Owb1cIKSY5IsObs9+4s1Tw41uLMVpA5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqDuTLlbD/pqC07vlzjNCr3/ydrt2tHEEBebMBQfS8k=;
 b=zK1/Cc4soy46vL3XPlNLnVoWrmsbhyp0Nstf5Q7DEzbN+F+QmiamH4UjUOg/ifYSsGJyoEAWFmIajkoESFyWPz5xqrSX5xU8Qa4glJOfOK6US2Y5PC9fEKAt5tGiawcRAjGixAr16WSM2rS0i0kVt0Ltu/Cfxp8pHb1ujacMDlwhfBm9nsreqsCkJxEXu+/XUTgyElJksHer7W/qYEJZMEcfytDWonExQCA/HSx0+fpDO3mb3devZqV+2H/MkxAA983z0u/l0kz5zY70Qzr1jk7kTgmdkxjzwtb5/OtaWrSSIE1v69j/sXrLkOCEotAfLYKt4dHctnTTt1OZhJp6KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqDuTLlbD/pqC07vlzjNCr3/ydrt2tHEEBebMBQfS8k=;
 b=aTYizlM5aJm5Hh7y8Co4OJdi1cT99hxhumNgMRG1AxQju3M3s67+IhjnQL9JobkVb/BbhfjK4AHWF9wyiekMHEVRTCqoSzvVrywM7ugealZsuqii++fG6hQOf6F1KBM+rHs7nTSPAp/hxc70RlP2FcxKqUqpeh6VItT1q2qwHwT/VIBL6DRKEqxjozdHIJl4Ly/SIhsA+g0DJVOMWlyvYOmLTg2mafnjhQMHoIFRhkIr6PtwlUkTjmVT6KTJ74JtQzsCSzOMPlbxEU4yw57vosr6vg8HT/IDM2wLi6ekTAAaeY9nv3j0E+kx5kbsTGlpMYwifAf3QHqazrokY5gA5A==
Received: from SN7PR18CA0006.namprd18.prod.outlook.com (2603:10b6:806:f3::8)
 by CO6PR18MB4452.namprd18.prod.outlook.com (2603:10b6:303:13e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Tue, 2 Jun 2026
 06:33:56 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:806:f3:cafe::8e) by SN7PR18CA0006.outlook.office365.com
 (2603:10b6:806:f3::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Tue, 2
 Jun 2026 06:33:56 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Tue, 2 Jun 2026 06:33:56 +0000
Received: from axiado.com (vm-swbuild01.axiadoRD [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 6C85D4186B51;
 Mon,  1 Jun 2026 23:31:31 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v3 1/6] hw/arm: Add Axiado SoC AX3000
Date: Mon,  1 Jun 2026 23:33:45 -0700
Message-Id: <20260602063350.3623723-2-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260602063350.3623723-1-kchiu@axiado.com>
References: <20260602063350.3623723-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|CO6PR18MB4452:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f30b2a3b-682f-4f2f-5a16-08dec070ec03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|34020700016|82310400026|1800799024|376014|3023799007|56012099006|18002099003|22082099003|5023799004|6133799003;
X-Microsoft-Antispam-Message-Info: TEzEVGuITCcHM/sGsy3q/3Ma9VBQCghZWnpjOhfyCsdcXjFQXNLgzFw3+jbthuZ7OZTEa8DXi7zwdfZcjQDua50AVb6lO3FK40RGdANLetj+1GDxx+ao9xEcylnp6riPxF01t2EKoXaYclI7i/f0vh/Y2V7MUI/OowQZWeKPqqMIOYdToW+TRtKanNH6zWbIZ+Jhq6jbTMLDHzAF6jLjmh34/0zPBdFxjfLdqOMmH0hNxZEh303jeyQPfeBRfffxtWe9tIbT+kvW4yyPuHjnntgLFx1jjbkJ2bnPa60CYwf1vJuO/6ga8cgUeCh6Dls1L+q8HZQ05fOSBSrlVO6lK3vINRx0P1DBHIYrBp9/TMBjTwxLrp/GfQ9kTqJhDGGaatWwYmNCzQ7dTZgBAXKB9ChQz+9DUSTt0IR0pRTSmahZRxFAfroMT3v3Zq4BDjKCF+zW5z1u4bis2tZx1Pu1JW8GyYml6Sn8W4j/zSmHQswH4rKKZU3YAkudkAzqDOXiaoyjyWCBLTQrAmqfPAcNwevfFinUM108I9FTZPFSe5l42fFmzAtE7tLyiOwvtCrZUgMif9Ff8Q9VFc2DLyAkuJfncg5URZzuWDIcJ73MBJePkiQHCXQlbOiSbAy4DMYCNBe5Qe9MgD2L4kvklHtDjW7m7buGp6rj9yUxwPZuNjKRo1D5ke2oCKmfE69Ry4u10Ab4TZRR1K17j1DNPH4tqmYR9gwcbe8N31+HuY8yCyQ=
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(34020700016)(82310400026)(1800799024)(376014)(3023799007)(56012099006)(18002099003)(22082099003)(5023799004)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WpoSrxnnRxgxhjYfqHNYQPrYgeaUGYKy1d9uF5z9DjXoWOaQaJhsCp79/L1Km95E4t9ho/B3pYMJ6vOHxggev3DP0tPmSWQFvmeUWz2T7pDcf+YoGeUK2emv+2ZpEwOzloRBC7tz/H+wc0ZHwa6wlSJM9TCDaL5hx8bSGvttZ0EoMX9gl1seSNfJMO0wjolxX+/558a85F/tiZcPsra0h0RPcMutgmKLheh0/82jgiyM3MDDpKW/1/ZlmWtY06RdWu65Pz8rVFtMSIK+7cp5LgNEbnyX6iC2NFZbv7uTkCaLdKztgVdEhiIcO+b2sUkc1DgvC6FtWhLpIHmV7Zffk8jFXs0aFb/bFMqxwmrtOZU7/tLpFa2uIcJSjF02fBKYxIdbxXfYDCH56R2lNbkjZvphCSRNbNqmBRnCmyITrXwRJZrM9dpwczZ81wL1v0Jm
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 06:33:56.0500 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f30b2a3b-682f-4f2f-5a16-08dec070ec03
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR18MB4452
Received-SPF: pass client-ip=2a01:111:f403:c111::5;
 envelope-from=kchiu@axiado.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This patch adds new model for Axiado SoC AX3000 which supports
    4 Cortex-A53 ARM64 CPUs
    Arm Generic Interrupt Controller v3
    4 Cadence UARTs

Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
---
 MAINTAINERS                 |   7 ++
 hw/arm/Kconfig              |   7 ++
 hw/arm/ax3000-soc.c         | 218 ++++++++++++++++++++++++++++++++++++
 hw/arm/meson.build          |   3 +
 include/hw/arm/ax3000-soc.h |  71 ++++++++++++
 5 files changed, 306 insertions(+)
 create mode 100644 hw/arm/ax3000-soc.c
 create mode 100644 include/hw/arm/ax3000-soc.h

diff --git a/MAINTAINERS b/MAINTAINERS
index cd5c4831e27..3782c83738a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1298,6 +1298,13 @@ M: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 S: Maintained
 F: rust/hw/char/pl011/
 
+Axiado SoCs and EVKs
+M: Kuan-Jui Chiu <kchiu@axiado.com>
+L: qemu-arm@nongnu.org
+S: Maintained
+F: hw/arm/ax3000*.c
+F: include/hw/arm/ax3000*.h
+
 AVR Machines
 -------------
 
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 5b198402d5e..39f0b652a0f 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -716,3 +716,10 @@ config ARMSSE
     select UNIMP
     select SSE_COUNTER
     select SSE_TIMER
+
+config AXIADO_SOC
+    bool
+    depends on ARM
+    select ARM_GIC
+    select CADENCE # UART
+    select UNIMP
diff --git a/hw/arm/ax3000-soc.c b/hw/arm/ax3000-soc.c
new file mode 100644
index 00000000000..517cc6f52d5
--- /dev/null
+++ b/hw/arm/ax3000-soc.c
@@ -0,0 +1,218 @@
+/*
+ * Axiado SoC AX3000
+ *
+ * Author: Kuan-Jui Chiu <kchiu@axiado.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "system/address-spaces.h"
+#include "hw/arm/bsa.h"
+#include "hw/arm/ax3000-soc.h"
+#include "hw/misc/unimp.h"
+#include "system/system.h"
+#include "qobject/qlist.h"
+#include "qom/object.h"
+#include "hw/core/boards.h"
+
+static uint64_t pll_read(void *opaque, hwaddr offset, unsigned size)
+{
+    switch (offset) {
+    case CLKRST_CPU_PLL_POSTDIV_OFFSET:
+        return 0x20891b;
+    case CLKRST_CPU_PLL_STS_OFFSET:
+        return 0x01;
+    default:
+        return 0x00;
+    }
+}
+
+static void pll_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
+{
+}
+
+static const MemoryRegionOps pll_ops = {
+    .read = pll_read,
+    .write = pll_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    }
+};
+
+static void ax3000_init(Object *obj)
+{
+    Ax3000SoCState *s = AX3000_SOC(obj);
+    Ax3000SoCClass *sc = AX3000_SOC_GET_CLASS(s);
+
+    for (int i = 0; i < sc->num_cpus; i++) {
+        g_autofree char *name = g_strdup_printf("cpu%d", i);
+        object_initialize_child(obj, name, &s->cpu[i],
+                                ARM_CPU_TYPE_NAME("cortex-a53"));
+    }
+
+    object_initialize_child(obj, "gic", &s->gic, gicv3_class_name());
+
+    for (int i = 0; i < AX3000_NUM_UARTS; i++) {
+        g_autofree char *name = g_strdup_printf("uart%d", i);
+        object_initialize_child(obj, name, &s->uart[i], TYPE_CADENCE_UART);
+    }
+}
+
+static void ax3000_realize(DeviceState *dev, Error **errp)
+{
+    Ax3000SoCState *s = AX3000_SOC(dev);
+    Ax3000SoCClass *sc = AX3000_SOC_GET_CLASS(s);
+    SysBusDevice *gic_sbd = SYS_BUS_DEVICE(&s->gic);
+    DeviceState *gic_dev = DEVICE(&s->gic);
+    QList *redist_region_count;
+    SysBusDevice *sdhci0_sbd;
+    DeviceState *card;
+
+    /* CPUs */
+    for (int i = 0; i < sc->num_cpus; i++) {
+        object_property_set_int(OBJECT(&s->cpu[i]), "cntfrq", 8000000,
+                                &error_abort);
+
+        if (object_property_find(OBJECT(&s->cpu[i]), "has_el3")) {
+            object_property_set_bool(OBJECT(&s->cpu[i]), "has_el3",
+                                     false, &error_abort);
+        }
+
+        if (!qdev_realize(DEVICE(&s->cpu[i]), NULL, errp)) {
+            return;
+        }
+    }
+
+    /* GIC */
+    qdev_prop_set_uint32(gic_dev, "num-cpu", sc->num_cpus);
+    qdev_prop_set_uint32(gic_dev, "num-irq",
+                         AX3000_NUM_IRQS + GIC_INTERNAL);
+
+    redist_region_count = qlist_new();
+    qlist_append_int(redist_region_count, sc->num_cpus);
+    qdev_prop_set_array(gic_dev, "redist-region-count", redist_region_count);
+
+    if (!sysbus_realize(gic_sbd, errp)) {
+        return;
+    }
+
+    sysbus_mmio_map(gic_sbd, 0, AX3000_GIC_DIST_BASE);
+    sysbus_mmio_map(gic_sbd, 1, AX3000_GIC_REDIST_BASE);
+
+    /*
+     * Wire the outputs from each CPU's generic timer and the GICv3
+     * maintenance interrupt signal to the appropriate GIC PPI inputs, and
+     * the GIC's IRQ/FIQ interrupt outputs to the CPU's inputs.
+     */
+    for (int i = 0; i < sc->num_cpus; i++) {
+        DeviceState *cpu_dev = DEVICE(&s->cpu[i]);
+        int intidbase = AX3000_NUM_IRQS + i * GIC_INTERNAL;
+        qemu_irq irq;
+
+        /*
+         * Mapping from the output timer irq lines from the CPU to the
+         * GIC PPI inputs.
+         */
+        static const int timer_irqs[] = {
+            [GTIMER_PHYS] = ARCH_TIMER_NS_EL1_IRQ,
+            [GTIMER_VIRT] = ARCH_TIMER_VIRT_IRQ,
+            [GTIMER_HYP]  = ARCH_TIMER_NS_EL2_IRQ,
+            [GTIMER_SEC]  = ARCH_TIMER_S_EL1_IRQ
+        };
+
+        for (int j = 0; j < ARRAY_SIZE(timer_irqs); j++) {
+            irq = qdev_get_gpio_in(gic_dev, intidbase + timer_irqs[j]);
+            qdev_connect_gpio_out(cpu_dev, j, irq);
+        }
+
+        irq = qdev_get_gpio_in(gic_dev, intidbase + ARCH_GIC_MAINT_IRQ);
+        qdev_connect_gpio_out_named(cpu_dev, "gicv3-maintenance-interrupt",
+                                        0, irq);
+
+        sysbus_connect_irq(gic_sbd, i,
+                           qdev_get_gpio_in(cpu_dev, ARM_CPU_IRQ));
+        sysbus_connect_irq(gic_sbd, i + sc->num_cpus,
+                           qdev_get_gpio_in(cpu_dev, ARM_CPU_FIQ));
+        sysbus_connect_irq(gic_sbd, i + 2 * sc->num_cpus,
+                           qdev_get_gpio_in(cpu_dev, ARM_CPU_VIRQ));
+        sysbus_connect_irq(gic_sbd, i + 3 * sc->num_cpus,
+                           qdev_get_gpio_in(cpu_dev, ARM_CPU_VFIQ));
+    }
+
+    /* DRAM */
+    for (int i = 0; i < AX3000_NUM_BANKS; i++) {
+        struct {
+            hwaddr addr;
+            size_t size;
+            const char *name;
+        } dram_table[] = {
+            { AX3000_DRAM0_BASE, AX3000_DRAM0_SIZE, "dram0" },
+            { AX3000_DRAM1_BASE, AX3000_DRAM1_SIZE, "dram1" }
+        };
+
+        memory_region_init_ram(&s->dram[i], OBJECT(s), dram_table[i].name,
+                               dram_table[i].size, &error_fatal);
+        memory_region_add_subregion(get_system_memory(), dram_table[i].addr,
+                                    &s->dram[i]);
+    }
+
+    /* UARTs */
+    for (int i = 0; i < AX3000_NUM_UARTS; i++) {
+        struct {
+            hwaddr addr;
+            unsigned int irq;
+        } serial_table[] = {
+            { AX3000_UART0_BASE, AX3000_UART0_IRQ },
+            { AX3000_UART1_BASE, AX3000_UART1_IRQ },
+            { AX3000_UART2_BASE, AX3000_UART2_IRQ },
+            { AX3000_UART3_BASE, AX3000_UART3_IRQ }
+        };
+
+        qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hd(i));
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), errp)) {
+            return;
+        }
+
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->uart[i]), 0, serial_table[i].addr);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart[i]), 0,
+                           qdev_get_gpio_in(gic_dev, serial_table[i].irq));
+    }
+
+    /* Timer control */
+    create_unimplemented_device("ax3000.timerctrl", AX3000_TIMER_CTRL, 32);
+
+    /* PLL control */
+    memory_region_init_io(&s->pll_ctrl, OBJECT(s), &pll_ops, s,
+                          "ax3000.pllctrl", 32);
+    memory_region_add_subregion(get_system_memory(), AX3000_PLL_BASE,
+                                &s->pll_ctrl);
+}
+
+static void ax3000_class_init(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    Ax3000SoCClass *sc = AX3000_SOC_CLASS(oc);
+
+    dc->desc = "Axiado SoC AX3000";
+    dc->realize = ax3000_realize;
+    sc->num_cpus = AX3000_NUM_CPUS;
+}
+
+static const TypeInfo axiado_soc_types[] = {
+    {
+        .name           = TYPE_AX3000_SOC,
+        .parent         = TYPE_SYS_BUS_DEVICE,
+        .instance_size  = sizeof(Ax3000SoCState),
+        .instance_init  = ax3000_init,
+        .class_init     = ax3000_class_init,
+    }
+};
+
+DEFINE_TYPES(axiado_soc_types)
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 80068f70bb9..772ae5211dc 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -103,6 +103,9 @@ arm_common_ss.add(when: 'CONFIG_SX1', if_true: files('omap_sx1.c'))
 arm_common_ss.add(when: 'CONFIG_VERSATILE', if_true: files('versatilepb.c'))
 arm_common_ss.add(when: 'CONFIG_VEXPRESS', if_true: files('vexpress.c'))
 
+arm_common_ss.add(when: ['CONFIG_AXIADO_SOC', 'TARGET_AARCH64'], if_true: files(
+  'ax3000-soc.c'))
+
 arm_common_ss.add(files('boot.c'))
 
 hw_arch += {'arm': arm_ss}
diff --git a/include/hw/arm/ax3000-soc.h b/include/hw/arm/ax3000-soc.h
new file mode 100644
index 00000000000..6e3b5f51d30
--- /dev/null
+++ b/include/hw/arm/ax3000-soc.h
@@ -0,0 +1,71 @@
+/*
+ * Axiado SoC AX3000
+ *
+ * Author: Kuan-Jui Chiu <kchiu@axiado.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef AXIADO_AX3000_H
+#define AXIADO_AX3000_H
+
+#include "cpu.h"
+#include "hw/intc/arm_gicv3_common.h"
+#include "hw/char/cadence_uart.h"
+#include "hw/core/sysbus.h"
+#include "qemu/units.h"
+
+#define TYPE_AX3000_SOC "ax3000"
+OBJECT_DECLARE_TYPE(Ax3000SoCState, Ax3000SoCClass, AX3000_SOC)
+
+#define AX3000_DRAM0_BASE       0x3C000000
+#define AX3000_DRAM0_SIZE       (1088 * MiB)
+#define AX3000_DRAM1_BASE       0x400000000
+#define AX3000_DRAM1_SIZE       (2 * GiB)
+
+#define AX3000_GIC_DIST_BASE    0x80300000
+#define AX3000_GIC_DIST_SIZE    (64 * KiB)
+#define AX3000_GIC_REDIST_BASE  0x80380000
+#define AX3000_GIC_REDIST_SIZE  (512 * KiB)
+
+#define AX3000_UART0_BASE       0x80520000
+#define AX3000_UART1_BASE       0x805a0000
+#define AX3000_UART2_BASE       0x80620000
+#define AX3000_UART3_BASE       0x80520800
+
+#define AX3000_TIMER_CTRL       0x8A020000
+#define AX3000_PLL_BASE         0x80000000
+#define CLKRST_CPU_PLL_POSTDIV_OFFSET   0x0C
+#define CLKRST_CPU_PLL_STS_OFFSET       0x14
+
+enum Ax3000Configuration {
+    AX3000_NUM_CPUS     = 4,
+    AX3000_NUM_IRQS     = 224,
+    AX3000_NUM_BANKS    = 2,
+    AX3000_NUM_UARTS    = 4,
+};
+
+typedef struct Ax3000SoCState {
+    SysBusDevice        parent;
+
+    ARMCPU              cpu[AX3000_NUM_CPUS];
+    GICv3State          gic;
+    MemoryRegion        dram[AX3000_NUM_BANKS];
+    MemoryRegion        pll_ctrl;
+    CadenceUARTState    uart[AX3000_NUM_UARTS];
+} Ax3000SoCState;
+
+typedef struct Ax3000SoCClass {
+    SysBusDeviceClass   parent;
+
+    uint32_t            num_cpus;
+} Ax3000SoCClass;
+
+enum Ax3000Irqs {
+    AX3000_UART0_IRQ    = 112,
+    AX3000_UART1_IRQ    = 113,
+    AX3000_UART2_IRQ    = 114,
+    AX3000_UART3_IRQ    = 170,
+};
+
+#endif /* AXIADO_AX3000_H */
-- 
2.34.1


