Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CBA7CD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 10:18:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa9p9-0000P6-AI; Thu, 18 Jun 2026 06:18:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wa9p7-0000OQ-Na
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 06:18:13 -0400
Received: from mail-westus3azon11021111.outbound.protection.outlook.com
 ([40.107.208.111] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wa9p5-0008P0-A8
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 06:18:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p7Jug1qm/za+FdHI5bVKZmQJHdAAD6LCLdhKOktK57ELeFWKVE+zAOAYB0yfThldIO0/UUfYFkdQ1jwI7rynMjy/+CVodsMF3FHl/efbawh99QkkdwFgSFJgK7UITVaaujJbDldtCyjiikuoKuJoPPQ1Hhmw0eyqK729Nq/sgIG6LHCQ1PA/1VUSYOJRnuHVQvgGwL0GDoJOQflytwu0xppQEkIdiDgZ9e/yxF+/o3AVoyW3kVbx6nAXqeuIdWeweAX83Piinm4nyIfNMSyhjtuNtEVa4ZuE5BOe3RlIluxl1L+e8ncs0K/Zdi0Qo0j5MQ8Nry60DJmeZ80qfIUXYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lv80HXvVBY3IYtgVq7oXNKrNR9qqrL5oY7XcdR5bb+U=;
 b=ddqNY6aomdPfiUIMxul+9NhTGzCvuSnYgUDg/HM6segiOqAEk6PUfYWY4XFswp8d8JYPqh3sXwdWR5ZIKgI9WIFLBT+hmsr3VWdOHw6EoHJcS379Nm/QfpYgnk8SjNpE5ymVedtrTTk8UiYuNWO4CHCFRXcswcVsHF+oc4dBGqCE8ged2FVzuejAn1gGbNatMvpvckCOYleSyvK521HqNXNCuaqkTh4oHlInFAMWyYjbboqTMfxsUcn8SkDAIzqaHlseySHEp7dlD0PV81yrqJMPFNYfPxmQCygL44b8kCBRG0Ph+1pzUrqOsAAkAqLRbKIsdCMV9Gc0dZg7bt7TLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lv80HXvVBY3IYtgVq7oXNKrNR9qqrL5oY7XcdR5bb+U=;
 b=vWnz7V0ftmVBoALWk0tx5T5IymcZHUbfdiogc1FoDVipukpyXvC+xgJQYP91uTjbI4rlbwQ+Bz1zwCvzNm3rIQ0/ikOGwUnGmeAu/MlGcdrwDFVxqZYF0z5AAnojU8mYLtm+B2d2xjlxlvNRptEFA5UJn2uWhot5WCPCd6Ajj/JHgzeopI62rbynikUmj136J2fptGDkrKVcqBgHKKUueuRR0FP0CS/9wDGo71aloUJQ7d4C1Lq5xUzjD55iaLhl03tcK0TJT9rdEIr1dQGhaiNa94IEhZjkq0cZWFt/wN7SG9OZKb0ta2MeSjmsejsT8GWqyO4XP3r3ndKeyetjDA==
Received: from MN2PR03CA0016.namprd03.prod.outlook.com (2603:10b6:208:23a::21)
 by LV8PR18MB5868.namprd18.prod.outlook.com (2603:10b6:408:22c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Thu, 18 Jun
 2026 10:13:04 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:23a:cafe::71) by MN2PR03CA0016.outlook.office365.com
 (2603:10b6:208:23a::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Thu,
 18 Jun 2026 10:13:04 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.8
 via Frontend Transport; Thu, 18 Jun 2026 10:13:03 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 288BC4186B5A;
 Thu, 18 Jun 2026 03:10:23 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v5 1/8] hw/arm: Add Axiado SoC AX3000
Date: Thu, 18 Jun 2026 03:12:42 -0700
Message-Id: <20260618101249.2926976-2-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260618101249.2926976-1-kchiu@axiado.com>
References: <20260618101249.2926976-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|LV8PR18MB5868:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: fd679cc5-82d4-4777-d0ab-08decd222f45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|56012099006|6133799003|3023799007|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: wbYkH7lyOT3h55btRkr43xwv9gUsuz151ZC/gSVaN0KT1QGDOFPO0Ohy/uVmsoZOhvTDrw/YRLtOEopY0kpZEzztPomWktmu4B/6C7BjVhgRWYId23V5jsQi5CSoldOdKuc9MLukCFfDa0NP4+tmkBxoKHoORW2Dt+7cdaNpemaZ6AieHh5pCIYWBekYsXwDQUUiB9p4bAhH51qKNSSDYv0atiDIV6A9QyiuiwIFeCMUbZRk+lcIX8ip7d2WTXP1TMxEZ80PoxKi9HildUlNkTHUG+Kjsepnz+Svw4sFuL04J/BBPyMV9MacXjwiP0Kdg26L+VfuVGU6pi3KAXY4ujQqACHmnnzcegysZu7MaSPPRFtrd20Vx3/jXW7SuvEVRfBqW1G22JMu6Yz1GVsd/v7sEgk86y02apXEyeFuThPYqn1kfyg7pPL7hXRhoCzE3oriqq/+MqB+USudl7BfsIRzqIdjz/d9g6SmDGS75H2J4ca5WV4Wpdfl/GJ7WAHAUx6Ap7JezlMTzDi9vFQtegOYcn0ZPCT1fRBZNZVKLdJWAe+ZHRs7kkbKMi0rZ89j8anCNLelD2IP7teV2znXtpn5a42TZsgg+3Oh+K9cSWsDBwC04c0Ef1BOSQkXH0KGFmj1B7w8I2hsg3N41jsShtnntrhYDKOHgC/5lhNgfNSPUC2QA/56pdChiksBWwp9Ad4hH9p65mlZ2qsCPIFCU2QyoMVxcpgzSvF5OswEkQI=
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(56012099006)(6133799003)(3023799007)(5023799004)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NzCESEmL+r0Lb3Uod9DSC2ctbg/AtsA5IRJjFd/peT09j2AC/hSjz819m4+sv576TcAusRhYAoX6gFiZkk2BVv+f/i1s7Vkm+xBCn5Oot+9AJdEMWcjeCN57Kla6QRND2XKnhSw4iHs9bqPRZEwiz3Zyg/wvx0850ojrE0ysGy3xuyseWvsl4pwI+ib4XJ/pTG/lo9vT8xW8Y9QlDawmb20uBlWOK0CBnk2Lt7EPH8FiwRv56XxE6Pn+Z0vNXqXrSy6eUtT3tI1WzFrIEavy24o+NtSaSDG5jQTq5djWowzejZQ3FEZiPPEMub/38A0WnSqIIyuetsOHsdOXj6JlrJ+wHIOK8I8eUKrbvUih60JRJJkmSY3RBCI/vfoRZ+5ZskXho68Tk88YQUjPZDr/JKUuoOBXVD7L9IntA8aWaELs27BiXLMnNgue15lEfHGf
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 10:13:03.7202 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd679cc5-82d4-4777-d0ab-08decd222f45
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB5868
Received-SPF: pass client-ip=40.107.208.111; envelope-from=kchiu@axiado.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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
 hw/arm/ax3000-soc.c         | 182 ++++++++++++++++++++++++++++++++++++
 hw/arm/meson.build          |   3 +
 include/hw/arm/ax3000-soc.h |  68 ++++++++++++++
 5 files changed, 267 insertions(+)
 create mode 100644 hw/arm/ax3000-soc.c
 create mode 100644 include/hw/arm/ax3000-soc.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 2b5b581e173..340428cda55 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1294,6 +1294,13 @@ M: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
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
index fb798ccbeed..818ffdbce56 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -717,3 +717,10 @@ config ARMSSE
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
index 00000000000..8e8d2edfb71
--- /dev/null
+++ b/hw/arm/ax3000-soc.c
@@ -0,0 +1,182 @@
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
index 8f66a80e10e..111ab2ba010 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -108,6 +108,9 @@ arm_common_ss.add(when: 'CONFIG_SX1', if_true: files('omap_sx1.c'))
 arm_common_ss.add(when: 'CONFIG_VERSATILE', if_true: files('versatilepb.c'))
 arm_common_ss.add(when: 'CONFIG_VEXPRESS', if_true: files('vexpress.c'))
 
+arm_common_ss.add(when: ['CONFIG_AXIADO_SOC', 'TARGET_AARCH64'], if_true: files(
+  'ax3000-soc.c'))
+
 arm_common_ss.add(files('boot.c'))
 
 hw_common_arch += {'arm': arm_common_ss}
diff --git a/include/hw/arm/ax3000-soc.h b/include/hw/arm/ax3000-soc.h
new file mode 100644
index 00000000000..b984d7a8ec3
--- /dev/null
+++ b/include/hw/arm/ax3000-soc.h
@@ -0,0 +1,68 @@
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


