Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB02C5DF87
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:27:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwzzN-0004IB-SL; Thu, 20 Aug 2026 06:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wwzzM-0004Hw-QY
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:27:12 -0400
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wwzzK-00037g-JV
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:27:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rbAvDaIDpE5+jtCVD/09SeDo3mh7ZgZrj5pSGUz2NTwfecSW5k5ulvMnY6jL82tM1udCMrTMZOBokAnKYkau+ZSbxFT3PuhXCwUn88Odbod5izFaVEKzk9j82Scf4RLugZiPyq3ow60yG7itrYxMDEO0q6z/z1UAsnAeRqUVsggtw6mpAaHcrCi/AuWWdYaU763T6MwaKbX/xN7hjEwi9MskDE70npV9EHC0jDnqy+kyTUSGjvl7uW9TRYiiK4wgQlejlHt1IgW+isEps2E+NP4CAl3/S7GlZ/vG49Ql303VabHfiWDQn+rbX6MNX1xWsVRGEbNTd+13n8s3wCGJlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RMKC8MfX8ml/hu2EYA/tnBG1lYfZs0kcK9FaARf+pII=;
 b=WiYUzJvgmBOvMPsgz0qXpsJhLt5W3gtydf4QVG02zRW0YhDaeiMV/Po/i3egqzgv6Ei4UnLxNOHb1sVhFjFuKqXntXMENxjazZMwzEw0V5zGS+8X+1dEEi0RYSSCGfZvVvsoPIsIwhYz608d47CLHOinFM7X8SaM6TOTiyYjRvRZiAXhtZgi+0ijnWndhmBXkmMKp1m7dtR6hD+VAXVYX4b6Jw8SC5ue1UlRj9WcpE1vDO5k9K2K3ARS0l8YF23qNviJio8Tj0xpK3EQNxV1WxeHVVsbQENiu8/3jKS3HiK7cZjH4Pe9+3RBypmD0gLoPnMUqtZBN2a+Jz1d0GoYjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMKC8MfX8ml/hu2EYA/tnBG1lYfZs0kcK9FaARf+pII=;
 b=BZEp/+PRFRMRh/6Za6UHuH7uLWYg1ZCnR1oarxRm204S4eAfsgLv9/cKDGx8WVcNuwuXSRiB5vxD8L4MMDlxFD3zcJe++TDFJ3PP/iTUOKeH4QefYciDA8LV6cAscFrbp5W1oRyaq4BlfKm9b1hTiSujRpm4/rebjCP/jKTqald7cLRTrg+TMHXq1K3D+XFX8A3pnY/wKXipuL7Y2sCaf3z1NBV6dpf1pjM/+cbVPide/EgZXJzjvtMvEyqy3n8csyMdEEHMt3xwRdkuHn0nEWtfxOYBB2AzcbSOHUVpHsZ4pE+ZQm73cGAVGiadie2U6Hu+AqaJSSeRDINWp3Tuqw==
Received: from SJ0PR13CA0065.namprd13.prod.outlook.com (2603:10b6:a03:2c4::10)
 by IA0PPF559287CF7.namprd18.prod.outlook.com
 (2603:10b6:20f:fc04::c1c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 10:27:03 +0000
Received: from SJ1PEPF00002311.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::94) by SJ0PR13CA0065.outlook.office365.com
 (2603:10b6:a03:2c4::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3 via Frontend Transport; Thu, 20
 Aug 2026 10:27:03 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 SJ1PEPF00002311.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.3
 via Frontend Transport; Thu, 20 Aug 2026 10:27:01 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 7759D4186B51;
 Thu, 20 Aug 2026 03:27:01 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v1 4/5] hw/arm: Add Axiado SoC AX3005
Date: Thu, 20 Aug 2026 03:21:31 -0700
Message-Id: <20260820102132.361642-5-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260820102132.361642-1-kchiu@axiado.com>
References: <20260820102132.361642-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002311:EE_|IA0PPF559287CF7:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: eef4a4ab-a075-4f31-f5aa-08defea592c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|6133799003|10067099003|5023799004|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: u6zrS/UfT+VG0tXQxr3Kb3p5890OgyLSDKMjhgmAIJr0s9TmS+9vii71yVMgiLx0boifkA5IyBYgOuuHhuE3TbSdrwTFfyqBTxl3mZpGH30xFBRLmIY88hQ7M1ghSUqLnysdLnPgUdY+KC6ht4Xh7GnOcT6tJk91GZpBKVQVdB2zse27XmGxsHm5Wet97ideTdE6tN/wDn01XhzxOc1lCOUtj2AWzwysewf9Q58B5It6N1Ji+EABYo0PQcgKhwuKMq3BOABNAfUez39H1Jlnr0WapxQJ+ipxnKJnIfyWNYwNNBtL8EjYEMkKR9g4fxKcRaqIks+4t1RMtxRv23yZ36gIgqvfFFbDGGVhKb5QGau9t3ES1zh0+3akMtANmmjiNHAN4FKtJIVm60LXFw7ZBtkG95MlauRIs6LboZO1gjlEhPChUNmOrtUTZRwlGNasHUHF0VsjwCdGt6zVrmK62hNK/lV10HCb726no/qD9An3ID47zup/xZ/fwnDhABjPWHiKSeIk1Ntq1j2oGI1OTLzjtdPMlh8oT8nQtPUNma5i59kg7NUGPJ4RGCMTpM/fT2/6sOWhRJf4io0pntZ8kVH7g7iTuHx7EKTYVpf0mAgdnUjrtG6LI6RnoDvLYHyfhu31LCwjKDL+KYhnrVQkmDsQqABDon2wRFsU8U27Grx0BFC5z6OxwlTYXCS6j1Jp1w63p+04cUreA+x7jUaE+Q==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(6133799003)(10067099003)(5023799004)(56012099006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HoHyB08dITlQQf7zABA/9xQq8WrM9bM6sFwlAjkPrhjNujnLgWRYD98EhwnxnamY9ekLh+VD7duuQltgqjN/tSd9A47WcwNFS8/3uXQLxHWVxhl4YDHJk5WgXGpZdNi3MBW226a03UvGuztZJPT8vJHhzThru26UWfEVw4+6SdS9V/dsEmvPjJp3T4QDMLZhM3IsrXUH9Rw8HieAWF5mfrKrtRukQD9w6SRI/nGCHZ2PihxgjDFsw8MbuxGiL/AhQBkj8Bx/OIJVJsTqztfGU8Yt8bJmB3MHpYxDebZ08M3DGVHpjmcDbGhT0qlx1q2SKoXov45woglCrCkMVaxVg19bfh2mYgjQiGrTu+caxn+sj2J+lz27dWV06mlqMYaYcBpJuSpIksLgC9mveEviko3v/m28SyFtNZ7B/uy6qX7R6ca4pxBawtG+Tt61xjhX
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 10:27:01.8178 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eef4a4ab-a075-4f31-f5aa-08defea592c4
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002311.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF559287CF7
Received-SPF: pass client-ip=2a01:111:f403:c007::2;
 envelope-from=kchiu@axiado.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
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
 hw/arm/ax3005-soc.c         | 224 ++++++++++++++++++++++++++++++++++++
 hw/arm/meson.build          |   3 +-
 include/hw/arm/ax3005-soc.h | 102 ++++++++++++++++
 4 files changed, 330 insertions(+), 1 deletion(-)
 create mode 100644 hw/arm/ax3005-soc.c
 create mode 100644 include/hw/arm/ax3005-soc.h

diff --git a/MAINTAINERS b/MAINTAINERS
index b51f5c3e60..cb542ad591 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1312,8 +1312,10 @@ M: Kuan-Jui Chiu <kchiu@axiado.com>
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
index 0000000000..e8a91bceb6
--- /dev/null
+++ b/hw/arm/ax3005-soc.c
@@ -0,0 +1,224 @@
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
+        .class_init     = ax3005_class_init,
+    }
+};
+
+DEFINE_TYPES(ax3005_soc_types)
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 8ee5307a91..9fceb8d2e7 100644
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


