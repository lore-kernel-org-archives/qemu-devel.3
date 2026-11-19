Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF81606A324
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=axiado.com header.i=@axiado.com header.a=rsa-sha256 header.s=selector1 header.b=ENNAx3td
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTwN0-000478-MM; Thu, 19 Nov 2026 02:15:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1xTwLb-00032m-DD; Thu, 19 Nov 2026 02:14:21 -0500
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1xTwLW-0004Ky-UR; Thu, 19 Nov 2026 02:14:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k2SqkLYxOqQf6zRBpv6slXF9UTlmQ+lMQ+v1cMQs1Q9Fq2K5zoD2Qbtm4yeclysf2eDpp7ZTUrEO1a3q7fgcAAPo9CRxCcbhD3rR5W4V4F0agM9mlWZLyNOQc2TzBaDDCQgcJtT6aCLqicgLxNFUKExOiy/OeBIPVGRHuR3RfiV1IdJpzYOns3ensll8pm1KkT3sHzI66qWDgR1gL73Vxy/CRo6o8HUoGQXDpByCkKWYhizHz4P5c+B8q1ZMMs6bG3IxEfZmotdUNRV1b/mb/mL0aXfQYmKfvxRHo+CemigtgUgN+wCfz1jlKhP3BpeeQ5M5hqb7LpeR9e9KTLIvGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vt0NoHS5xw2yep9hM3+qIGjDj6HbE+ggH17iFRDXkyY=;
 b=hg3HslqvZAGzvUGA7WA7ZlUXAs6lCbAxjz2Umu3sgBW4Gt6++GC7fYrrzgW91PTbjsbXH5cUuLCf90u6hav2txLQstLlwRcX/hF1cnjqS9p/+5tXctju6EWLDYC58P5+9K940kQflAoZdxUJsvZm5xXYH61RDyBY1j3y8JTPXeAR47kx5P2Xf4YTXbktFhLHDMrVQnFAcpedfM1UW0xppmLNVD1Tyteup/tEZzW8Y0EP4rVHOc4DdwijyCqkvpd4r0alh9olhfZH7dT7pl7Ts/zTk0v1CfN+pnKPC+HPwgpfVkSqJHfXkwtK5eZTuYUPsQzDYAdHSKfNE2OfVAHMmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vt0NoHS5xw2yep9hM3+qIGjDj6HbE+ggH17iFRDXkyY=;
 b=ENNAx3td20ASNT07FyI5n42NBtcT461zKE+odYjWzZe+mCzsFKfYUqwdm1Fy1WgSZnL5iVg0Upm1Qd+iMIq6VVvGkFQf1neVw7t485+kc1ZWfEcQiGqtLbr21dVg4Y6sw3DXayLP+D6IuNjCdo2yiL07bU94MeSgMhEyzPGqT/o3xMplEKdhQhmFCAK2ww6aHmlRKLSOQ+oMQO05TtauPglMIr8CmKL4LKl/UrsW4U48IIJe26m5rc+WJGtC/6r9Io9i3IPhNT5ZOBIv3JLUni9cVVMxYtJSBXUXMela95keLmhSrEV67MsPda1lKpaona3ZsxEnIqiICQVpI5Otow==
Received: from DS7PR05CA0101.namprd05.prod.outlook.com (2603:10b6:8:56::21) by
 LV3PR18MB6350.namprd18.prod.outlook.com (2603:10b6:408:26d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 07:14:02 +0000
Received: from CY8PEPF00000059.namprd21.prod.outlook.com
 (2603:10b6:8:56:cafe::47) by DS7PR05CA0101.outlook.office365.com
 (2603:10b6:8:56::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.10 via Frontend Transport; Thu,
 19 Nov 2026 07:14:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 CY8PEPF00000059.mail.protection.outlook.com (10.167.247.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.0
 via Frontend Transport; Thu, 19 Nov 2026 07:14:01 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id CAA1240BFE15;
 Wed, 18 Nov 2026 23:13:59 -0800 (PST)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: 
Cc: Kuan-Jui Chiu <kchiu@axiado.com>, mark.caveayland@nutanix.com,
 philmd@oss.qualcomm.com, 163wangjack@gmail.com, peter.maydell@linaro.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v8 10/13] hw/arm: Add Axiado SoC AX3005
Date: Wed, 18 Nov 2026 23:13:50 -0800
Message-Id: <20261119071355.3520249-11-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261119071355.3520249-1-kchiu@axiado.com>
References: <20261119071355.3520249-1-kchiu@axiado.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PEPF00000059:EE_|LV3PR18MB6350:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 803d83e4-74cb-420c-e9f4-08df460cb03d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|260925021311599003|260925022911599003|260925021911599003|10067099003|5023799004|56012099006|261021135927099003|261021130227099003|261009223027099003|261021133027099003|261009221227099003|261102123227099003|261021123027099003|261022113327099003|261022105027099003|261022115727099003|261028144727099003|261026140227099003|261022075727099003|261026130827099003|261026135527099003|261026121527099003|261021121427099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: AHqcNnapQmu8ozLoBfdHMSiGDxQK/GU4vEhrJRMLqjweKUV8JRlT6ZcOoMglNaCmkfApcmHDjEJfNRkKP+QQcPaqjRrwfmalubuyRsKG74SdT1iahMmZNf1JlcGSNCpvyUeneqvaxEFhHXdSOuDiiUoJFFAmgUEwFOi4VOJiwlwGRxjYdftbRYcVTh2ptUTuen9228bzFWSbpiQBEB+RvmuUkSQI24+gqsowlVRipMfuuLldu3LNpYXhybY9DRLUQb+k2uIozCGnmxlOrLwo4qIj4Gqx5cLvfOE0rdWLoGCvKc3iDpUwAQm7ufxnuy5PyNLRQzvASmxKu55uWaq4DtqlFhQnvxasSw54t0a4MnlGYePNrbAq+AyjBwApnqZAzb8TTvu+yAmSsUoTPdRjf2KKHgOgY+CCmP/O1OL7WKB2uhO9vbReAtgGE1boqYgrQ0DxbhMYOFEDs7EdiD+jmhUz4Mem/mPOLfGbWzjWOigpKWbK+D22y210BmXOnIHBAop8L2gaIzbB2e1gAtxBieIm9iT+hU6mwSoeL4/i5os5P7pwN/jZz62TrWEoHCyUs/B3UY+MuDe1/tTeKBP39w7Bea3qU0cWVnDZPJw2OG1oQ4Kr7O7TPy3xPXFPRLAWSYd9HlNMXXu//diAxpuwjwmovZ2oAHxWfQcFZ3/Xe1DEZe7zQXyiUqvf3aYwcUYdDi+2wYpTgQOg2p2xTpdNKQ==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(260925021311599003)(260925022911599003)(260925021911599003)(10067099003)(5023799004)(56012099006)(261021135927099003)(261021130227099003)(261009223027099003)(261021133027099003)(261009221227099003)(261102123227099003)(261021123027099003)(261022113327099003)(261022105027099003)(261022115727099003)(261028144727099003)(261026140227099003)(261022075727099003)(261026130827099003)(261026135527099003)(261026121527099003)(261021121427099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: byoVH2MugQjDdzrA1wkELqeAFFMKVXKES0sWU5kDsHHRSAZbv9iXIDYSw5r7Lx65EVMoSzkBE7YX9twZD+PZWZT0dL3lasWSF/0sMq0UkQE0H0ni+IN0cDMNbpR4GsC8qh2LlyN+EefxoXnFlokRyzO6A04Si63c5y0QupSTggP25RwUUrOutUclsDupi7DMbTsQ8vYkct7nt7zT8Zu01309jhIFbKpjd+/DkQFVBBM/ffFXxZfcHTywHMgx0tVLJvXlvy9Y8WYiTftA/YDCykO9BXrkfr9Qst3QnRcVKRhc5XElWfqmPaWO5KzMJCztxodoiJ3g7GacHz5IoV+apqY0aQ7g8BPGGeAtk8DiE0oDi0jnlrY7sOX1mYcAOHOEk122mr4/nImz+i+Woz8AcDCNPENf6rf8UPtDLwdV4Sapddj/b0DTOLrv+fqg7qCZ
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 07:14:01.8319 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 803d83e4-74cb-420c-e9f4-08df460cb03d
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: CY8PEPF00000059.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR18MB6350
Received-SPF: pass client-ip=2a01:111:f403:c005::5;
 envelope-from=kchiu@axiado.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This patch adds new model for Axiado SoC AX3005 which supports
    4 Cortex-A53 ARM64 CPUs
    Arm Generic Interrupt Controller v3
    9 Cadence UARTs
    1 SDHCI controller with PHY
    8 Cadence GPIOs

Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
---
 MAINTAINERS                 |   3 +
 hw/arm/ax3005-soc.c         | 226 ++++++++++++++++++++++++++++++++++++
 hw/arm/meson.build          |   3 +-
 include/hw/arm/ax3005-soc.h | 102 ++++++++++++++++
 4 files changed, 333 insertions(+), 1 deletion(-)
 create mode 100644 hw/arm/ax3005-soc.c
 create mode 100644 include/hw/arm/ax3005-soc.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 15942aaba3..e5f37262cf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1324,11 +1324,14 @@ F: rust/hw/char/pl011/
 
 Axiado SoCs and EVKs
 M: Kuan-Jui Chiu <kchiu@axiado.com>
+M: Prasad Bolisetty <pbolisetty@axiado.com>
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
index f3c1b0e00f..f54aaffef2 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -113,7 +113,8 @@ arm_common_ss.add(when: 'CONFIG_VERSATILE', if_true: files('versatilepb.c'))
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
index 0000000000..e9faa80dbd
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
+struct Ax3005SoCState {
+    SysBusDevice        parent_obj;
+
+    ARMCPU              cpu[AX3005_NUM_CPUS];
+    GICv3State          gic;
+    MemoryRegion        dram;
+    CadenceUARTState    uart[AX3005_NUM_UARTS];
+    CadenceGPIOState    gpio[AX3005_NUM_GPIOS];
+    AxiadoSDHCIState    sdhci0;
+};
+
+struct Ax3005SoCClass {
+    SysBusDeviceClass   parent_class;
+
+    uint32_t            num_cpus;
+};
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


