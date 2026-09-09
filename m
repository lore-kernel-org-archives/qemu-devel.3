Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 906D6C79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 10:56:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4FyK-00046r-Gz; Wed, 09 Sep 2026 06:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x4FyG-000447-Gw; Wed, 09 Sep 2026 06:56:04 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x4FyB-0004Gl-SL; Wed, 09 Sep 2026 06:56:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rC6Iu2wM9W/Ehf3dR31TkdU1DLXGoXZuZvbYiiYLNdoF8Y5XpwZfJI0sl+aumDBEZKfSWO+ayAcp/u+exghcTEAkUF3+qoEGHRtQixh3DZbk6EueiUUrKcPC1/stODWBwRFoMdAkl06Li57zyMw/jenA8cZRMMiIfZMut/Gwlr+YUVmlsoCzGYKDvqwJFVd/GMBp7YfvmQkye4grgn7D6eERK/vfhq3vpCnC4dCLV0mXgTuaJid6qB8DkLR0Vk2E86hi7vSLwzJYjLPVq4ZLGQetRVJgFR1yDPtTfN1fE5jJxAN5UkdrXvBOrpTrH+cxnskvKLdtOZYjB6KoiRfMFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lAuh4gYTGJrX0CU3iSOG6sErpmyfwVERKAM1+MBX3bE=;
 b=srwqBg+C/ptT95zx5k0KWn5e8CBwQ9AHwGc5t234LGlAar2UwV2DlLs5ayxxHYB04qB0Xgsm9Hx7Y+tra0dS7MeyXRJngP3PCLoFUbmPCjeHLOavYNbMCKSOGz2A9ws4iv6u4nJ3Oipr0fGBkcSIznq2AxrB3vIzgX5BIPVuR0sYrwWS+8AIHyInzPSB/WcTbeJtDtCb8ljF/sI75iBXk12rmBVzhibdYwD1o9ICmrxOXOmXwfiz8Sq7QUYTRk9FUyHKyJkMCnT69PoczDDqy+OJY+5UJ5hgo9CrEm+8zCkDdpGO8TRD4AccTaDNSk6UfEYLZ0EpWQOYpVMv0Tb8tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAuh4gYTGJrX0CU3iSOG6sErpmyfwVERKAM1+MBX3bE=;
 b=HN6BYiSagAPenJcdxivAz5DTIaWsSaP0iyYueOpVqzVtWjcCm4mUO7MuovdLgSS5p16TaxOHIB1QAkDDGXswUmaedSsx1ujtekj/cy+sCywcJKEwp10in+t1HWJ1eKC6y/oTKlL/5EyRbhMrdiYgdnT3JOFAsLfZVHBOdu34qqESIoAtGodkGJG2bPMpwWEtjFWUZRCw5B125WwPiuiHrZYbw5XR3XmEsBNfwlZ/uz14n2bQirgBEWaXWbzZPRoBHVSNNY3mSnpvbYm6t0agO+ndJ3CWSCG3a8m+QaoOTy4eozn2V/IWQcW4Y4W85bf1WypllshpO9zuCjxaGIWbcw==
Received: from LV3P220CA0030.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::10)
 by EAYPR18MB919086.namprd18.prod.outlook.com (2603:10b6:303:2f7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 10:55:51 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:408:234:cafe::26) by LV3P220CA0030.outlook.office365.com
 (2603:10b6:408:234::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Wed, 9
 Sep 2026 10:55:51 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Wed, 9 Sep 2026 10:55:50 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id D6CA840BFE13;
 Wed,  9 Sep 2026 03:55:48 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: philmd@oss.qualcomm.com, 163wangjack@gmail.com, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, qemu-arm@nongnu.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v6 09/12] hw/arm: Add Axiado SoC AX3005
Date: Wed,  9 Sep 2026 03:55:36 -0700
Message-Id: <20260909105543.1478008-10-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260909105543.1478008-1-kchiu@axiado.com>
References: <20260909105543.1478008-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|EAYPR18MB919086:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a316d76c-c2d8-4bac-3aaf-08df0e60e9ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|36860700016|1800799024|10067099003|6133799003|3023799007|56012099006|22082099003|18002099003|5023799004;
X-Microsoft-Antispam-Message-Info: gzgiIFjuNzOEYE0FSzwcE+AUWP39qkB4qOvuvHuFyjq0OV9BwJN+bNKatYVO7FzD61EWJDpSty7nt+PmiSUKjFrI53LS8HJpz6ScmyGo9KrnuPAtJSWRLuF4cKpLeb2a28K4X0F5uHUyG3Lo0Q5/DARIgIrL8Fg0Fc4/7m7xk3eh408q3ovYIo5DcpymbV5gNlkYI851Vw9/gg5Fc0Jkf2provt2QI5Y99TwCsO9LJoqXXsdhMcAmWrGi9BHOdNucUWbJjWNaqbIFX14IxL5xXk9zOwPJqDsRNBMwZHD+dTQIernsrqu/5xsC7zxkeBoWsu8OoOtG7jIZoLYg0hT5LWW8DhDaGGGu8+QwawPVPPc2zN68vLPBk/Dk5jrCCOYAyA/0zfqTrz7zDIR+GhO6cdIDzlWBDjbnq2yVVTBUnt8yru2SBoiGRK23tHHEqjgZbZ+eB+JatCqH2+UIfgd1khrQDGhJ168eQPJJeSlQKZz2sQmhCWs9cik0reTJnxI5xKYXpNCCA5nrAQWQBlZxqVDN++JSZCwRVcbczNAk1xM5QpUqIPF2x8+S50CEAaKD+xu2/bl8tilWZqN+81yitNWkFP4T3j827SU6A8VVQ4f9Qy1NSouGv3ty/R/nYcDGdaDw7hRPz5172Io20oEAkcqRxG2DstZR0ZZN59nqYf/0Pu/OmcC44ZqiSqAa9Fh1jrzby0Gzpm8YyLsvBLd2A==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(36860700016)(1800799024)(10067099003)(6133799003)(3023799007)(56012099006)(22082099003)(18002099003)(5023799004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VhtOXSrVoSDOr1CDLjsEzdZMcsi9ctonFlWfqTd/aSA4CV/W/p2FW6Ef8Xd6BldFKlw+so4VWC5mZbzyOiZuC1j5mGax/OSf3NnTuacF1hNgoHXD+4nxlcFHcSsnlucX/m3PPG5pVyBGrL7Q8a+ZtSdK5hPHuAlrpk5QH6udJn5byvtnYMHEo9MxMc3TDhhECwJSn4k2cjxBPqV9WZe1eZiYGNfR42STJVWX8xmvEm3WJk3ACB4tWmJsrSWkjainCJMaeKIRrNYUjWHiKHbFWkQooU736/PETGksvSv2O2RmMaHdX7tMblQASORXhq9HJyxN0hblkVka1EljERH3y5ocOP9IH9VTBufA6HiBIcvNCAEsDejYey0BPRlDBoC72HpwxP4nj7Tf8Fgf3aY7B62lEpDcJr9JCWmuw8rmSFQ+m7MlfvMnAwRXlDosBD5i
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 10:55:50.8258 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a316d76c-c2d8-4bac-3aaf-08df0e60e9ac
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR18MB919086
Received-SPF: pass client-ip=2a01:111:f403:c107::9;
 envelope-from=kchiu@axiado.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

This patch adds new model for Axiado SoC AX3005 which supports
    4 Cortex-A53 ARM64 CPUs
    Arm Generic Interrupt Controller v3
    9 Cadence UARTs
    1 SDHCI controller with PHY
    8 Cadence GPIOs

Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
---
 MAINTAINERS                 |   2 +
 hw/arm/ax3005-soc.c         | 226 ++++++++++++++++++++++++++++++++++++
 hw/arm/meson.build          |   3 +-
 include/hw/arm/ax3005-soc.h | 102 ++++++++++++++++
 4 files changed, 332 insertions(+), 1 deletion(-)
 create mode 100644 hw/arm/ax3005-soc.c
 create mode 100644 include/hw/arm/ax3005-soc.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 7183babd6a..deddcc4eed 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1305,8 +1305,10 @@ M: Kuan-Jui Chiu <kchiu@axiado.com>
 L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/arm/ax3000*.c
+F: hw/arm/ax3005*.c
 F: hw/*/axiado*.c
 F: include/hw/arm/ax3000*.h
+F: include/hw/arm/ax3005*.h
 F: include/hw/*/axiado*.h
 
 AVR Machines
diff --git a/hw/arm/ax3005-soc.c b/hw/arm/ax3005-soc.c
new file mode 100644
index 0000000000..e555b156f4
--- /dev/null
+++ b/hw/arm/ax3005-soc.c
@@ -0,0 +1,226 @@
+/*
+ * Axiado SoC AX3005
+ *
+ * Author: Kuan-Jui Chiu <kchiu@axiado.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "system/address-spaces.h"
+#include "hw/arm/bsa.h"
+#include "hw/arm/ax3005-soc.h"
+#include "hw/misc/unimp.h"
+#include "system/system.h"
+#include "qobject/qlist.h"
+#include "qom/object.h"
+#include "hw/core/boards.h"
+
+static void ax3005_init(Object *obj)
+{
+    Ax3005SoCState *s = AX3005_SOC(obj);
+    Ax3005SoCClass *sc = AX3005_SOC_GET_CLASS(s);
+
+    for (int i = 0; i < sc->num_cpus; i++) {
+        g_autofree char *name = g_strdup_printf("cpu%d", i);
+        object_initialize_child(obj, name, &s->cpu[i],
+                                ARM_CPU_TYPE_NAME("cortex-a53"));
+    }
+
+    object_initialize_child(obj, "gic", &s->gic, gicv3_class_name());
+
+    for (int i = 0; i < AX3005_NUM_UARTS; i++) {
+        g_autofree char *name = g_strdup_printf("uart%d", i);
+        object_initialize_child(obj, name, &s->uart[i], TYPE_CADENCE_UART);
+    }
+
+    object_initialize_child(obj, "sdhci0", &s->sdhci0, TYPE_AXIADO_SDHCI);
+
+    for (int i = 0; i < AX3005_NUM_GPIOS; i++) {
+        g_autofree char *name = g_strdup_printf("gpio%d", i);
+        object_initialize_child(obj, name, &s->gpio[i], TYPE_CADENCE_GPIO);
+    }
+}
+
+static void ax3005_realize(DeviceState *dev, Error **errp)
+{
+    Ax3005SoCState *s = AX3005_SOC(dev);
+    Ax3005SoCClass *sc = AX3005_SOC_GET_CLASS(s);
+    SysBusDevice *gic_sbd = SYS_BUS_DEVICE(&s->gic);
+    DeviceState *gic_dev = DEVICE(&s->gic);
+    QList *redist_region_count;
+    SysBusDevice *sdhci0_sbd;
+    DeviceState *card;
+    DriveInfo *dinfo;
+
+    /* CPUs */
+    for (int i = 0; i < sc->num_cpus; i++) {
+        object_property_set_int(OBJECT(&s->cpu[i]), "cntfrq", 1000000000,
+                                &error_abort);
+
+        if (!qdev_realize(DEVICE(&s->cpu[i]), NULL, errp)) {
+            return;
+        }
+    }
+
+    /* GIC */
+    qdev_prop_set_uint32(gic_dev, "num-cpu", sc->num_cpus);
+    qdev_prop_set_uint32(gic_dev, "num-irq",
+                         AX3005_NUM_IRQS + GIC_INTERNAL);
+
+    redist_region_count = qlist_new();
+    qlist_append_int(redist_region_count, sc->num_cpus);
+    qdev_prop_set_array(gic_dev, "redist-region-count", redist_region_count);
+
+    if (!sysbus_realize(gic_sbd, errp)) {
+        return;
+    }
+
+    sysbus_mmio_map(gic_sbd, 0, AX3005_GIC_DIST_BASE);
+    sysbus_mmio_map(gic_sbd, 1, AX3005_GIC_REDIST_BASE);
+
+    /*
+     * Mapping from the output timer irq lines from the CPU to the
+     * GIC PPI inputs.
+     */
+    const int timer_irqs[] = {
+        [GTIMER_PHYS] = ARCH_TIMER_NS_EL1_IRQ,
+        [GTIMER_VIRT] = ARCH_TIMER_VIRT_IRQ,
+        [GTIMER_HYP]  = ARCH_TIMER_NS_EL2_IRQ,
+        [GTIMER_SEC]  = ARCH_TIMER_S_EL1_IRQ
+    };
+
+    /*
+     * Wire the outputs from each CPU's generic timer and the GICv3
+     * maintenance interrupt signal to the appropriate GIC PPI inputs, and
+     * the GIC's IRQ/FIQ interrupt outputs to the CPU's inputs.
+     */
+    for (int i = 0; i < sc->num_cpus; i++) {
+        DeviceState *cpu_dev = DEVICE(&s->cpu[i]);
+        int intidbase = AX3005_NUM_IRQS + i * GIC_INTERNAL;
+        qemu_irq irq;
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
+    memory_region_init_ram(&s->dram, OBJECT(s), "dram", AX3005_DRAM_SIZE,
+                           &error_fatal);
+    memory_region_add_subregion(get_system_memory(), AX3005_DRAM_BASE,
+                                &s->dram);
+
+    /* UARTs */
+    const struct {
+        hwaddr addr;
+        unsigned int irq;
+    } serial_table[] = {
+        { AX3005_UART0_BASE, AX3005_UART0_IRQ },
+        { AX3005_UART1_BASE, AX3005_UART1_IRQ },
+        { AX3005_UART2_BASE, AX3005_UART2_IRQ },
+        { AX3005_UART3_BASE, AX3005_UART3_IRQ },
+        { AX3005_UART4_BASE, AX3005_UART4_IRQ },
+        { AX3005_UART5_BASE, AX3005_UART5_IRQ },
+        { AX3005_UART6_BASE, AX3005_UART6_IRQ },
+        { AX3005_UART7_BASE, AX3005_UART7_IRQ },
+        { AX3005_UART8_BASE, AX3005_UART8_IRQ }
+    };
+
+    for (int i = 0; i < AX3005_NUM_UARTS; i++) {
+        qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hd(i));
+        qdev_prop_set_bit(DEVICE(&s->uart[i]), "brk-support", true);
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
+    create_unimplemented_device("ax3005.timerctrl", AX3005_TIMER_CTRL, 32);
+
+    /* SDHCI */
+    sdhci0_sbd = SYS_BUS_DEVICE(&s->sdhci0);
+    if (!sysbus_realize(sdhci0_sbd, errp)) {
+        return;
+    }
+
+    sysbus_mmio_map(sdhci0_sbd, 0, AX3005_SDHCI0_BASE);
+    sysbus_mmio_map(sdhci0_sbd, 1, AX3005_EMMC_PHY_BASE);
+    sysbus_connect_irq(sdhci0_sbd, 0,
+                       qdev_get_gpio_in(gic_dev, AX3005_SDHCI0_IRQ));
+
+    dinfo = drive_get(IF_SD, 0, 0);
+    if (dinfo) {
+        card = qdev_new(TYPE_SD_CARD);
+        qdev_prop_set_drive_err(card, "drive",
+                                blk_by_legacy_dinfo(dinfo),
+                                &error_fatal);
+        qdev_realize_and_unref(card, s->sdhci0.sd_bus, &error_fatal);
+    }
+
+    /* GPIOs */
+    const struct {
+        hwaddr addr;
+        unsigned int irq;
+    } gpio_table[] = {
+        { AX3005_GPIO0_BASE, AX3005_GPIO0_IRQ },
+        { AX3005_GPIO1_BASE, AX3005_GPIO1_IRQ },
+        { AX3005_GPIO2_BASE, AX3005_GPIO2_IRQ },
+        { AX3005_GPIO3_BASE, AX3005_GPIO3_IRQ },
+        { AX3005_GPIO4_BASE, AX3005_GPIO4_IRQ },
+        { AX3005_GPIO5_BASE, AX3005_GPIO5_IRQ },
+        { AX3005_GPIO6_BASE, AX3005_GPIO6_IRQ },
+        { AX3005_GPIO7_BASE, AX3005_GPIO7_IRQ }
+    };
+
+    for (int i = 0; i < AX3005_NUM_GPIOS; i++) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio[i]), errp)) {
+            return;
+        }
+
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio[i]), 0, gpio_table[i].addr);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio[i]), 0,
+                           qdev_get_gpio_in(gic_dev, gpio_table[i].irq));
+    }
+}
+
+static void ax3005_class_init(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    Ax3005SoCClass *sc = AX3005_SOC_CLASS(oc);
+
+    dc->desc = "Axiado SoC AX3005";
+    dc->realize = ax3005_realize;
+    sc->num_cpus = AX3005_NUM_CPUS;
+}
+
+static const TypeInfo ax3005_soc_types[] = {
+    {
+        .name           = TYPE_AX3005_SOC,
+        .parent         = TYPE_SYS_BUS_DEVICE,
+        .instance_size  = sizeof(Ax3005SoCState),
+        .instance_init  = ax3005_init,
+        .class_size     = sizeof(Ax3005SoCClass),
+        .class_init     = ax3005_class_init,
+    }
+};
+
+DEFINE_TYPES(ax3005_soc_types)
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index bcc068de04..b6a036c953 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -111,7 +111,8 @@ arm_common_ss.add(when: 'CONFIG_VERSATILE', if_true: files('versatilepb.c'))
 arm_common_ss.add(when: 'CONFIG_VEXPRESS', if_true: files('vexpress.c'))
 
 arm_common_ss.add(when: ['CONFIG_AXIADO_SOC', 'TARGET_AARCH64'], if_true: files(
-  'ax3000-soc.c'))
+  'ax3000-soc.c',
+  'ax3005-soc.c'))
 arm_common_ss.add(when: ['CONFIG_AXIADO_EVK', 'TARGET_AARCH64'], if_true: files(
   'ax3000-boards.c',
   'ax3000-evk.c'))
diff --git a/include/hw/arm/ax3005-soc.h b/include/hw/arm/ax3005-soc.h
new file mode 100644
index 0000000000..2a383a8084
--- /dev/null
+++ b/include/hw/arm/ax3005-soc.h
@@ -0,0 +1,102 @@
+/*
+ * Axiado SoC AX3005
+ *
+ * Author: Kuan-Jui Chiu <kchiu@axiado.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef AXIADO_AX3005_H
+#define AXIADO_AX3005_H
+
+#include "cpu.h"
+#include "hw/intc/arm_gicv3_common.h"
+#include "hw/char/cadence_uart.h"
+#include "hw/gpio/cadence_gpio.h"
+#include "hw/sd/axiado_sdhci.h"
+#include "hw/core/sysbus.h"
+#include "qemu/units.h"
+
+#define TYPE_AX3005_SOC "ax3005"
+OBJECT_DECLARE_TYPE(Ax3005SoCState, Ax3005SoCClass, AX3005_SOC)
+
+#define AX3005_DRAM_BASE        0x80000000
+#define AX3005_DRAM_SIZE        (2 * GiB)
+
+#define AX3005_GIC_DIST_BASE    0x40400000
+#define AX3005_GIC_DIST_SIZE    (64 * KiB)
+#define AX3005_GIC_REDIST_BASE  0x40500000
+#define AX3005_GIC_REDIST_SIZE  (768 * KiB)
+
+#define AX3005_UART0_BASE       0x33020000
+#define AX3005_UART1_BASE       0x330A0000
+#define AX3005_UART2_BASE       0x33120000
+#define AX3005_UART3_BASE       0x33020800
+#define AX3005_UART4_BASE       0x331A0400
+#define AX3005_UART5_BASE       0x33381D00
+#define AX3005_UART6_BASE       0x33381E00
+#define AX3005_UART7_BASE       0x33381F00
+#define AX3005_UART8_BASE       0x330C0000
+
+#define AX3005_SDHCI0_BASE      0x46000000
+#define AX3005_EMMC_PHY_BASE    0x33301C00
+
+#define AX3005_GPIO0_BASE       0x33000000
+#define AX3005_GPIO1_BASE       0x33080000
+#define AX3005_GPIO2_BASE       0x33100000
+#define AX3005_GPIO3_BASE       0x33180000
+#define AX3005_GPIO4_BASE       0x33200000
+#define AX3005_GPIO5_BASE       0x33280000
+#define AX3005_GPIO6_BASE       0x33300000
+#define AX3005_GPIO7_BASE       0x33380000
+
+#define AX3005_TIMER_CTRL       0x48016000
+
+enum Ax3005Configuration {
+    AX3005_NUM_CPUS     = 4,
+    AX3005_NUM_IRQS     = 224,
+    AX3005_NUM_UARTS    = 9,
+    AX3005_NUM_GPIOS    = 8,
+};
+
+typedef struct Ax3005SoCState {
+    SysBusDevice        parent;
+
+    ARMCPU              cpu[AX3005_NUM_CPUS];
+    GICv3State          gic;
+    MemoryRegion        dram;
+    CadenceUARTState    uart[AX3005_NUM_UARTS];
+    CadenceGPIOState    gpio[AX3005_NUM_GPIOS];
+    AxiadoSDHCIState    sdhci0;
+} Ax3005SoCState;
+
+typedef struct Ax3005SoCClass {
+    SysBusDeviceClass   parent;
+
+    uint32_t            num_cpus;
+} Ax3005SoCClass;
+
+enum Ax3005Irqs {
+    AX3005_UART0_IRQ    = 112,
+    AX3005_UART1_IRQ    = 113,
+    AX3005_UART2_IRQ    = 114,
+    AX3005_UART3_IRQ    = 170,
+    AX3005_UART4_IRQ    = 208,
+    AX3005_UART5_IRQ    = 209,
+    AX3005_UART6_IRQ    = 210,
+    AX3005_UART7_IRQ    = 211,
+    AX3005_UART8_IRQ    = 212,
+
+    AX3005_SDHCI0_IRQ   = 123,
+
+    AX3005_GPIO0_IRQ    = 183,
+    AX3005_GPIO1_IRQ    = 184,
+    AX3005_GPIO2_IRQ    = 185,
+    AX3005_GPIO3_IRQ    = 186,
+    AX3005_GPIO4_IRQ    = 187,
+    AX3005_GPIO5_IRQ    = 188,
+    AX3005_GPIO6_IRQ    = 189,
+    AX3005_GPIO7_IRQ    = 190,
+};
+
+#endif /* AXIADO_AX3005_H */
-- 
2.34.1


