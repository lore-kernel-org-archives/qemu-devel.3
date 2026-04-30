Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 324DFFF886F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 09:19:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wINXx-0007Ht-6Y; Thu, 30 Apr 2026 05:19:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wINXo-0007Gs-MP
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:18:53 -0400
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wINXl-0005dE-O2
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:18:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ynT/drX+TQ17QGfB1J9r0ou56QvBu4r/nujlnl+iAMDQ9piirnBch8TbNhfzQ2u3OHKf8PgYLIF5HYgyjMr38oQ7kHtTfVK/BJ1XrhLcjVUznxPx9ci10vHH9CCAJ9+8G8BaiICdoUl/Yjjwji1SRhHQa5Qpw9QCwHcb05XQ4iXDOPRy4j2zwI6LJXPB1SUr1nrrjjYFxI3iQ9URYAobCkRGQ9U9nwIsYHPQJE8wS4O+/+H1OgJE4I6VtiXxfXnfCqNJFhdY4R1X6AFxU/ufAA58mLqIsnBZWTW5BVdT9BF5934BoHI3I82WoTUBFAlrnQyrlRxQrYLTS3HQP/MdWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1z3L37m0lQ2h5Ohrva4ApyLn8+Bi7/AfdBhZfEs3G9E=;
 b=zQVI8uOdWmg5YmtW3F+RdQO3rpsnPWz5LEDY1DQ1kMfcMxXENTXDQ2HdkRDhOtYh6tNn/RnksjURhR55TyA5WwsXOyKTrXu9f5V4tu6eUUG3ZyBib3pXCv5lw35WvxrZZgQEHC7EJkFmWFxY0wn9FKLjUxcqwldVCs64bso7gx8D/Au4EpvxOWfMCWbiqSZEEsy3TrSSsBHDqiHqi8/2RRSgxrxnpxMJFjFDlEqdkCgF8KvtvFMZmY90Jc/0OtrPf8aPlA9nWwLQ4sA2JYCW8FvxRqF2TMxojxA5UlDofh5XDSApJHazDv/feikbRsqPHY4jk0sEDvCS7PQRXccuCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1z3L37m0lQ2h5Ohrva4ApyLn8+Bi7/AfdBhZfEs3G9E=;
 b=q8aumhUEqe1ftD45teqQB3dPclSXgUE+VrLWiNT3yh6ffskZED4bsSCkAvKOUNNCKfJxO1b4R5BNRdrmg4rQB9MSwqxgH7yJtOUbqfc11GoGMzRVtRqo/m5+fmFhXQIeFSrq/ZFwrNGV/aKDspHtIPrUd3TYo23Pc6ahC3UumoyTq0wGzOFkBA0xlUHDULS7vlveRzNXLzHBTIguJoyAy0zoRgTP25yHnLfC+CAKJkrJFwl0+mDGQrWBaC/rKcOXBvho0TBlVmMi5fuhfzrDiR+6ZrL3bOt95LT/dXhpobDCwQLkfohzLUwBPxK6lkEkq1zmPaf0xskQvWngCwRMBA==
Received: from CY8P222CA0024.NAMP222.PROD.OUTLOOK.COM (2603:10b6:930:6b::9) by
 LV3PR18MB6282.namprd18.prod.outlook.com (2603:10b6:408:26d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.21; Thu, 30 Apr
 2026 09:18:42 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:930:6b:cafe::f6) by CY8P222CA0024.outlook.office365.com
 (2603:10b6:930:6b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.21 via Frontend Transport; Thu,
 30 Apr 2026 09:18:42 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.18
 via Frontend Transport; Thu, 30 Apr 2026 09:18:42 +0000
Received: from axiado.com (vm-swbuild01.axiadoRD [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 2B2AE4186B5A;
 Thu, 30 Apr 2026 02:16:49 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: qemu-devel@nongnu.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v2 1/4] hw/arm: Add Axiado SoC AX3000
Date: Thu, 30 Apr 2026 02:18:29 -0700
Message-Id: <20260430091832.1846637-2-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430091832.1846637-1-kchiu@axiado.com>
References: <20260430091832.1846637-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|LV3PR18MB6282:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: bad112fc-0198-4d03-521c-08dea69978e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34020700016|82310400026|376014|36860700016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: IEy+f09DF2HAXw/jJgI0VBvJmPwbuqb4//i0nI31j5e8iL+7pJ/PerapxcG4qcbqP67Qi5f8bG9xe3Q6tsOVNAwaC29JF4O0EMlzi3dn0nSp+HDwEGcypuMm5S+QB4VfR0RnimNU8N27T0mSgc/GC7E3Ma9nRYGOE6OjEwG5tXTxLHeUHQ+02P59yejcRwuTBP0v5IKPUzwU0g7grIEQu3Q5FpdDSYKWF7CQqu63IYmSEx6pld6dcE0v2mVH57S433J7yUXCAKyhQsqOLZL0/zb3WA2TtB286xV88M4PkWi4WIADSCGbVzuxUKfVHxui7VuJuhT6tbRUt+e3LJzlFbI66zE3z3N50BIV/mH9SiNjYi4VmaXSvBPTdbMb17mDg7J03Wrf3tjFcA7nxDPRfjg9BMUehpZWNpKISQtjWKKdRiCTYQ7hOpJG2ka/d+xmW69Y6AkEMi28pvHEpsNlJTPyl52qGrYePdw48SritM9MVJDOR5iQheMz6VMG9vn/p24DfKf/xc3Hw8BO3g24muiaEX5oybw5iDCxTdEAYyC0bbqvZ2VFYkVd0+mQxghbWLYJUXdVHTqUz7gyr0Qi3Y4varjVvselu7mUa6qcyhs7VmCpDXxcOMHXriMEuwjQ8LOuw46bz6MKzAbcFZ2z5rVvWweGUZffOl+tt8HIq8GHgqPbH/4yVAYNue3zEe5KfZcLwLzzwQ44Pr403UDVDaVRqKCfvx+BUsnORpgDHjjhtoSyQ64InA35HwlYC/XXK0Va1DOEG8mRCJNQwKr+tw==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(34020700016)(82310400026)(376014)(36860700016)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XcC/6YaPhO1xXMp2dVFfxpJSYrRvgrgNYuvR3N03Vsl2u5VlGCBPWVtWLAbWEruCPGPcrtFcqF4ZVGCz0We08If1guvVGBcrwQ8I+sMvVXWUxtL4Dt53/nupbzjVqX4CPqHqbLhE1Cu8zrjiOLPygf5OwTfTPl0xUOSAgo9xLYiATSC0M3Q4HpB8X6Az26Q9wKOWh+RVAk9pcPwYumxtg/gwLWSRqdfXgmM1bVdffdNFgUPvW8OvCa2JkT3QKgvMsQyLxCxSkY21MmJcs3QdKx5wt72VRejYaBezSMo1M+0lrg0FLjnrNwhwSG2r1IvMdeVs2FCulMNY1O3O17fvar665DTq6CLyaXsv/wdNGftnGsKAV6c6Y8+30p418dz8QpP554cQj/vV7sSeGFYYzMWONs6qjL5if/Xl7AXEmRdJJTDy1MVckQysuF1opa6b
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 09:18:42.0422 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bad112fc-0198-4d03-521c-08dea69978e7
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR18MB6282
Received-SPF: pass client-ip=2a01:111:f403:c112::5;
 envelope-from=kchiu@axiado.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
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
    1 SDHCI controller with eMMC PHY

Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
---
 MAINTAINERS                  |   9 ++
 hw/arm/Kconfig               |   8 ++
 hw/arm/ax3000-soc.c          | 232 +++++++++++++++++++++++++++++++++++
 hw/arm/meson.build           |   3 +
 hw/sd/Kconfig                |   4 +
 hw/sd/axiado_sdhci.c         | 100 +++++++++++++++
 hw/sd/meson.build            |   1 +
 include/hw/arm/ax3000-soc.h  |  78 ++++++++++++
 include/hw/sd/axiado_sdhci.h |  21 ++++
 9 files changed, 456 insertions(+)
 create mode 100644 hw/arm/ax3000-soc.c
 create mode 100644 hw/sd/axiado_sdhci.c
 create mode 100644 include/hw/arm/ax3000-soc.h
 create mode 100644 include/hw/sd/axiado_sdhci.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 0a90204ae9..69da0df99a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1285,6 +1285,15 @@ M: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 S: Maintained
 F: rust/hw/char/pl011/
 
+Axiado SoCs and EVKs
+M: Kuan-Jui Chiu <kchiu@axiado.com>
+L: qemu-arm@nongnu.org
+S: Maintained
+F: hw/arm/ax3000*.c
+F: hw/*/axiado*.c
+F: include/hw/arm/ax3000*.h
+F: include/hw/*/axiado*.h
+
 AVR Machines
 -------------
 
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 4e50fb1111..4fb23122fd 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -691,3 +691,11 @@ config ARMSSE
     select UNIMP
     select SSE_COUNTER
     select SSE_TIMER
+
+config AXIADO_SOC
+    bool
+    depends on ARM
+    select ARM_GIC
+    select CADENCE # UART
+    select AXIADO_SDHCI
+    select UNIMP
diff --git a/hw/arm/ax3000-soc.c b/hw/arm/ax3000-soc.c
new file mode 100644
index 0000000000..e845a64c2a
--- /dev/null
+++ b/hw/arm/ax3000-soc.c
@@ -0,0 +1,232 @@
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
+    /* TBD */
+}
+
+static const MemoryRegionOps pll_ops = {
+    .read = pll_read,
+    .write = pll_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void ax3000_init(Object *obj)
+{
+    Ax3000SoCState *s = AX3000_SOC(obj);
+    Ax3000SoCClass *sc = AX3000_SOC_GET_CLASS(s);
+    int i;
+
+    for (i = 0; i < sc->num_cpus; i++) {
+        g_autofree char *name = g_strdup_printf("cpu%d", i);
+        object_initialize_child(obj, name, &s->cpu[i],
+                                ARM_CPU_TYPE_NAME("cortex-a53"));
+    }
+
+    object_initialize_child(obj, "gic", &s->gic, gicv3_class_name());
+
+    for (i = 0; i < AX3000_NUM_UARTS; i++) {
+        g_autofree char *name = g_strdup_printf("uart%d", i);
+        object_initialize_child(obj, name, &s->uart[i], TYPE_CADENCE_UART);
+    }
+
+    object_initialize_child(obj, "sdhci0", &s->sdhci0, TYPE_AXIADO_SDHCI);
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
+    int i;
+
+    /* CPUs */
+    for (i = 0; i < sc->num_cpus; i++) {
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
+    for (i = 0; i < sc->num_cpus; i++) {
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
+    for (i = 0; i < AX3000_NUM_BANKS; i++) {
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
+    for (i = 0; i < AX3000_NUM_UARTS; i++) {
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
+
+    /* SDHCI */
+    sdhci0_sbd = SYS_BUS_DEVICE(&s->sdhci0);
+    if (!sysbus_realize(sdhci0_sbd, errp)) {
+        return;
+    }
+
+    sysbus_mmio_map(sdhci0_sbd, 0, AX3000_SDHCI0_BASE);
+    sysbus_mmio_map(sdhci0_sbd, 1, AX3000_EMMC_PHY_BASE);
+    sysbus_connect_irq(sdhci0_sbd, 0,
+                       qdev_get_gpio_in(gic_dev, AX3000_SDHCI0_IRQ));
+
+    card = qdev_new(TYPE_SD_CARD);
+    qdev_prop_set_drive_err(card, "drive",
+                            blk_by_legacy_dinfo((drive_get(IF_SD, 0, 0))),
+                            &error_fatal);
+    qdev_realize_and_unref(card, s->sdhci0.sd_bus, &error_fatal);
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
index b187b946f0..e32f5eb0c7 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -105,6 +105,9 @@ arm_common_ss.add(when: 'CONFIG_SX1', if_true: files('omap_sx1.c'))
 arm_common_ss.add(when: 'CONFIG_VERSATILE', if_true: files('versatilepb.c'))
 arm_common_ss.add(when: 'CONFIG_VEXPRESS', if_true: files('vexpress.c'))
 
+arm_common_ss.add(when: ['CONFIG_AXIADO_SOC', 'TARGET_AARCH64'], if_true: files(
+  'ax3000-soc.c'))
+
 arm_common_ss.add(files('boot.c'))
 
 hw_arch += {'arm': arm_ss}
diff --git a/hw/sd/Kconfig b/hw/sd/Kconfig
index 633b9afec9..c69bf24f8d 100644
--- a/hw/sd/Kconfig
+++ b/hw/sd/Kconfig
@@ -23,3 +23,7 @@ config SDHCI_PCI
 config CADENCE_SDHCI
     bool
     select SDHCI
+
+config AXIADO_SDHCI
+    bool
+    select SDHCI
diff --git a/hw/sd/axiado_sdhci.c b/hw/sd/axiado_sdhci.c
new file mode 100644
index 0000000000..219d49079e
--- /dev/null
+++ b/hw/sd/axiado_sdhci.c
@@ -0,0 +1,100 @@
+/*
+ * Axiado SD Host Controller
+ *
+ * Author: Kuan-Jui Chiu <kchiu@axiado.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/sd/axiado_sdhci.h"
+#include "sdhci-internal.h"
+#include "qapi/error.h"
+#include "hw/core/qdev-properties.h"
+
+#define EMMC_PHY_ID     0x00
+#define EMMC_PHY_STATUS 0x50
+
+static uint64_t emmc_phy_read(void *opaque, hwaddr offset, unsigned size)
+{
+    uint32_t val = 0x00;
+
+    switch (offset) {
+    case EMMC_PHY_ID:
+        val = 0x3dff6870;
+        break;
+    case EMMC_PHY_STATUS:
+        /* Make DLL_RDY | CAL_DONE */
+        val =  (1u << 0) | (1u << 6);
+        break;
+    default:
+        break;
+    }
+
+    return val;
+}
+
+static void emmc_phy_write(void *opaque, hwaddr offset, uint64_t value,
+                            unsigned size)
+{
+    /* TBD */
+}
+
+static const MemoryRegionOps emmc_phy_ops = {
+    .read = emmc_phy_read,
+    .write = emmc_phy_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void axiado_sdhci_realize(DeviceState *dev, Error **errp)
+{
+    AxiadoSDHCIState *s = AXIADO_SDHCI(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    SysBusDevice *sdhci_sbd;
+
+    object_initialize_child(OBJECT(s), "sdhci", &s->sdhci,
+                            TYPE_SYSBUS_SDHCI);
+
+    qdev_prop_set_uint64(DEVICE(&s->sdhci), "capareg", 0x216737eed0b0);
+    qdev_prop_set_uint64(DEVICE(&s->sdhci), "sd-spec-version", 3);
+
+    sdhci_sbd = SYS_BUS_DEVICE(&s->sdhci);
+    sysbus_realize(sdhci_sbd, errp);
+    if (*errp) {
+        return;
+    }
+
+    sysbus_init_mmio(sbd, sysbus_mmio_get_region(sdhci_sbd, 0));
+
+    /* Propagate IRQ from SDHCI and SD bus  */
+    sysbus_pass_irq(sbd, sdhci_sbd);
+    s->sd_bus = qdev_get_child_bus(DEVICE(sdhci_sbd), "sd-bus");
+
+    /* Initialize eMMC PHY MMIO */
+    memory_region_init_io(&s->emmc_phy, OBJECT(s), &emmc_phy_ops, s,
+                          "axiado.emmc-phy", 0x1000);
+
+    sysbus_init_mmio(sbd, &s->emmc_phy);
+}
+
+static void axiado_sdhci_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = axiado_sdhci_realize;
+    dc->desc = "Axiado SD Host Controller with eMMC PHY";
+}
+
+static const TypeInfo axiado_sdhci_info = {
+    .name          = TYPE_AXIADO_SDHCI,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(AxiadoSDHCIState),
+    .class_init    = axiado_sdhci_class_init,
+};
+
+static void axiado_sdhci_register_types(void)
+{
+    type_register_static(&axiado_sdhci_info);
+}
+
+type_init(axiado_sdhci_register_types);
diff --git a/hw/sd/meson.build b/hw/sd/meson.build
index b43d45bc56..ebf09e30a4 100644
--- a/hw/sd/meson.build
+++ b/hw/sd/meson.build
@@ -10,3 +10,4 @@ system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_sdhci.c'))
 system_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-sdhost.c'))
 system_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_sdhci.c'))
 system_ss.add(when: 'CONFIG_CADENCE_SDHCI', if_true: files('cadence_sdhci.c'))
+system_ss.add(when: 'CONFIG_AXIADO_SDHCI', if_true: files('axiado_sdhci.c'))
diff --git a/include/hw/arm/ax3000-soc.h b/include/hw/arm/ax3000-soc.h
new file mode 100644
index 0000000000..2708c9c672
--- /dev/null
+++ b/include/hw/arm/ax3000-soc.h
@@ -0,0 +1,78 @@
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
+#include "hw/sd/axiado_sdhci.h"
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
+#define AX3000_SDHCI0_BASE      0x86000000
+#define AX3000_EMMC_PHY_BASE    0x80801C00
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
+    AxiadoSDHCIState    sdhci0;
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
+
+    AX3000_SDHCI0_IRQ    = 123,
+};
+
+#endif /* AXIADO_AX3000_H */
diff --git a/include/hw/sd/axiado_sdhci.h b/include/hw/sd/axiado_sdhci.h
new file mode 100644
index 0000000000..85afebad93
--- /dev/null
+++ b/include/hw/sd/axiado_sdhci.h
@@ -0,0 +1,21 @@
+/*
+ * Axiado SD Host Controller
+ *
+ * Author: Kuan-Jui Chiu <kchiu@axiado.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "hw/sd/sdhci.h"
+#include "qom/object.h"
+
+#define TYPE_AXIADO_SDHCI "axiado-sdhci"
+OBJECT_DECLARE_SIMPLE_TYPE(AxiadoSDHCIState, AXIADO_SDHCI)
+
+typedef struct AxiadoSDHCIState {
+    SysBusDevice parent;
+
+    SDHCIState sdhci;
+    MemoryRegion emmc_phy;
+    BusState *sd_bus;
+} AxiadoSDHCIState;
-- 
2.34.1


