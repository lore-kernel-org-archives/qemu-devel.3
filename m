Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA6EFF886F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 09:19:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wINXt-0007HT-8H; Thu, 30 Apr 2026 05:18:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wINXn-0007Gf-Ts
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:18:52 -0400
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wINXl-0005dD-EU
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:18:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WDkoYuG/kRy/PcAhd/9Xad1L6pJCg5EaOEEbJcNF5I78537jhKt/KIhg3fleMzjQevVk/F/H6ofi1ajOTbgKfY5RfqQSDctzl2wl37+5Vc6z/aFq+A6fma+EP7MNX4I3OxcDAj2A3H1/dV+rpH2gMQSoX49FAcesyOZJgqhYHT2ns5UoPsdrwYL20adt9edEjl3CAtdn5LYBqF+33BhsO31sf+0oa13v0SQE2YFdi8zv3D7QA/K1Nf2vuZiKsJp0mGTYe6N6IPx9z29ejTNX/6aOAVwHE2PbdZe9EbpLH13WoNhwjMhXDUa1W9PKYFb8a6THdLQVaewuk4Kxe2SGgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JBP2Dy8PohOl92QiYu5dhbnXOshFNJ5ePVoP6UYMiuA=;
 b=GRB5HwFRMHgPmMW3L+zOOmgqA/qwfGHajsETE48o9qfREVms5ZOMZRRlY1DFqTVvv5oYZmI6twha4+OVgpFvRL6EcRC+RtT2UuckiqWzkTpJ9mREKmZlZm1aV6Jg3ayyV11LIoHahJPY/ZvFUWuMgIRiN6kvB+tT3RyovCSBYwOAkO7TY0JAIqFdcEArOU3/Hge9P7f1/+j0mD0WtsgHC6EQlddZ0mjjjb8tajkDN9Y5g3cFKxatrlXgBHX9rP5PKSTPANQvjegUQTLoJPFA7L1OlwQ+fgtrz8B3jQgeDyj9Hqz964wzKbdPUhmrMmsRl4ryzzAuk6aQ+Ez4PM3pqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBP2Dy8PohOl92QiYu5dhbnXOshFNJ5ePVoP6UYMiuA=;
 b=mkwaibgHL536eHnRwPXOCry0R8iKwo9uHU6oc19bTa7XfZDAy6kKsM+rU4KnYmiL/kGtWOJHA3n3KxzCdZ3FyzYSp5udn2Yk0hBQjIbpAg0ghGHBcEa3nKRIAeAfM56n3hIawyN5YBym5JFiGftNzMUv/9ZN0xry/gm8rTTMK7WW47Nxf5H2/UOJboFtOC8MQ3XAt23v3rSmAlQ7M83DIAMhZvEuf0T2JQxSXwkkqAmB5aUsXTTHFQYkJz/O4lSU6XQFv1vygyk7lBtg4Slq0dVsXYd2/0Z3N56B51xowpf64vM8oeaUZSRbsb7Ujoo0V5D8v5Wav47wl0XGXoSKdw==
Received: from CH0PR04CA0048.namprd04.prod.outlook.com (2603:10b6:610:77::23)
 by DM3PPFD4080C554.namprd18.prod.outlook.com (2603:10b6:f:fc00::6ca)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Thu, 30 Apr
 2026 09:18:42 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:77:cafe::f9) by CH0PR04CA0048.outlook.office365.com
 (2603:10b6:610:77::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Thu,
 30 Apr 2026 09:18:42 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.18
 via Frontend Transport; Thu, 30 Apr 2026 09:18:42 +0000
Received: from axiado.com (vm-swbuild01.axiadoRD [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 5E82A40BFE07;
 Thu, 30 Apr 2026 02:16:49 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: qemu-devel@nongnu.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v2 4/4] hw/arm: ax3000-soc: Enable Cadence GPIO controllers
Date: Thu, 30 Apr 2026 02:18:32 -0700
Message-Id: <20260430091832.1846637-5-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430091832.1846637-1-kchiu@axiado.com>
References: <20260430091832.1846637-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|DM3PPFD4080C554:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 586232dc-f8cc-4e51-c8fc-08dea69978f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|34020700016|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: /03IheHyM5q72SCC47ryVCTer0e+Ds9zBTLISuPDXBdTZ01ojJR6MXFVLujZEr7zWvIyxthb/nrhFY8QwA7avCO43GDGDKhEEbdj3JfuYKXlF3x4Jm6T8Hwizo44bi2H6pon8/8sPSX2AaLwxwIncpLbKP/3OajIIjfmw5cWZf9gMm0/6sN+Lp30pN6iwuvf5OhGuGrO6duZLlz52zfAqTP/WGZncbHKJ2Ft7hhX0pQZ1SI3+Ea2NcAXN4wdvBrX1uQVGiGRRpxPqDYCkMjrOYL2AIFbElpe1F4WTQLWtkB3zNHQIVzNvP/EMHPiMl3ykrdtC8uqk3iXxI6JcY6tDi3BiIzRWGUwpE38tRVSikfA1HwqP7RdrbOy7f22IWQVqGwvoF1cBjqFBApQ+/Z47zUOF7dLrV49/aM7J/Ql8Q/tWISQKSLZ1CwGrs5/HZf4rItjGiE5bVo9Q/tWcEhZlrf2OrVVaclVYDYRYiyjolrjLBlcM3ZDIIJ9Gl98yEg6pOmhCWM4xiO6Nz//mBJ1xQOBxRNFUJcwLweT0khfvSRA6LwVuWvW60wxaq2h7UkcXV1q5FMBCw33KWz4A3hu7DDgWxjiIr80ZFb11QU2ytifG9K9p0fDR0VtO+OLt5Lo6sTc1mWc3VDZqK4Z26iZdBk6XDCOcUj70NsOHvNMm7y9IuAFQKpw6whN+Iefu+ScyVzAbd+yJTKjyrCbRg2UuCLSvLU+8gt1U8ul5Rjtnlh7C5OtrHTLmN5Zp0TqUVojyp4Syx/uQ6SS4P2psA9o2w==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(34020700016)(36860700016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /Vov0oIL5vi1/tLBIdGrqbK1u86+D0NmYEJ7Y17saxH/UjGFCCgSlrzU2n44V/VBLI2cnmzgObeYVOzWnKwXHV0CeygoGBL09GqCf9EjTN+EWA8VvzIQ0t4RqSXBW8xYjPMIjXe6C2JTBUo0AGL+AKpJPlv4XUjsyWlv64RjmL4lHq5PKsUXA+VDOIG6KhpMyR10WbtUkoh91rOSr+sF8amvH3vY2w8+Z6hxV+MjT3e4HfVtaHqT2AyoGjUQOeHAd4SCpFlfidWBBHHFHsdmBmFIUgDpmNTVgcsz8Vt8Sksf77TvpWllkdxIPhmR2f4BEWz9WNXdUFonTiQcCv3k71sA1mh+0bd/ATd4vkKW1rmoHyMW8eDu5wkoiOZtkiH1MzdI0JCdmW/gPgA/mgRlVuZtfYp4OX61qFeAwQqh2303ruM5PYpi1GryY3/ar+Hb
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 09:18:42.1171 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 586232dc-f8cc-4e51-c8fc-08dea69978f1
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFD4080C554
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

Enable 8 Cadence GPIO controllers into Axiado AX3000 SoC

Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
---
 hw/arm/Kconfig              |  1 +
 hw/arm/ax3000-soc.c         | 30 ++++++++++++++++++++++++++++++
 include/hw/arm/ax3000-soc.h | 23 ++++++++++++++++++++++-
 3 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index e569d8ee9e..3adca2923c 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -697,6 +697,7 @@ config AXIADO_SOC
     depends on ARM
     select ARM_GIC
     select CADENCE # UART
+    select CADENCE_GPIO
     select AXIADO_SDHCI
     select UNIMP
 
diff --git a/hw/arm/ax3000-soc.c b/hw/arm/ax3000-soc.c
index e845a64c2a..b5669cd5ba 100644
--- a/hw/arm/ax3000-soc.c
+++ b/hw/arm/ax3000-soc.c
@@ -59,6 +59,11 @@ static void ax3000_init(Object *obj)
     }
 
     object_initialize_child(obj, "sdhci0", &s->sdhci0, TYPE_AXIADO_SDHCI);
+
+    for (i = 0; i < AX3000_NUM_GPIOS; i++) {
+        g_autofree char *name = g_strdup_printf("gpio%d", i);
+        object_initialize_child(obj, name, &s->gpio[i], TYPE_CADENCE_GPIO);
+    }
 }
 
 static void ax3000_realize(DeviceState *dev, Error **errp)
@@ -207,6 +212,31 @@ static void ax3000_realize(DeviceState *dev, Error **errp)
                             blk_by_legacy_dinfo((drive_get(IF_SD, 0, 0))),
                             &error_fatal);
     qdev_realize_and_unref(card, s->sdhci0.sd_bus, &error_fatal);
+
+    /* GPIOs */
+    for (i = 0; i < AX3000_NUM_GPIOS; i++) {
+        struct {
+            hwaddr addr;
+            unsigned int irq;
+        } gpio_table[] = {
+            { AX3000_GPIO0_BASE, AX3000_GPIO0_IRQ },
+            { AX3000_GPIO1_BASE, AX3000_GPIO1_IRQ },
+            { AX3000_GPIO2_BASE, AX3000_GPIO2_IRQ },
+            { AX3000_GPIO3_BASE, AX3000_GPIO3_IRQ },
+            { AX3000_GPIO4_BASE, AX3000_GPIO4_IRQ },
+            { AX3000_GPIO5_BASE, AX3000_GPIO5_IRQ },
+            { AX3000_GPIO6_BASE, AX3000_GPIO6_IRQ },
+            { AX3000_GPIO7_BASE, AX3000_GPIO7_IRQ }
+        };
+
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio[i]), errp)) {
+            return;
+        }
+
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio[i]), 0, gpio_table[i].addr);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio[i]), 0,
+                           qdev_get_gpio_in(gic_dev, gpio_table[i].irq));
+    }
 }
 
 static void ax3000_class_init(ObjectClass *oc, const void *data)
diff --git a/include/hw/arm/ax3000-soc.h b/include/hw/arm/ax3000-soc.h
index 2708c9c672..aa388f79f0 100644
--- a/include/hw/arm/ax3000-soc.h
+++ b/include/hw/arm/ax3000-soc.h
@@ -12,6 +12,7 @@
 #include "cpu.h"
 #include "hw/intc/arm_gicv3_common.h"
 #include "hw/char/cadence_uart.h"
+#include "hw/gpio/cadence_gpio.h"
 #include "hw/sd/axiado_sdhci.h"
 #include "hw/core/sysbus.h"
 #include "qemu/units.h"
@@ -37,6 +38,15 @@ OBJECT_DECLARE_TYPE(Ax3000SoCState, Ax3000SoCClass, AX3000_SOC)
 #define AX3000_SDHCI0_BASE      0x86000000
 #define AX3000_EMMC_PHY_BASE    0x80801C00
 
+#define AX3000_GPIO0_BASE       0x80500000
+#define AX3000_GPIO1_BASE       0x80580000
+#define AX3000_GPIO2_BASE       0x80600000
+#define AX3000_GPIO3_BASE       0x80680000
+#define AX3000_GPIO4_BASE       0x80700000
+#define AX3000_GPIO5_BASE       0x80780000
+#define AX3000_GPIO6_BASE       0x80800000
+#define AX3000_GPIO7_BASE       0x80880000
+
 #define AX3000_TIMER_CTRL       0x8A020000
 #define AX3000_PLL_BASE         0x80000000
 #define CLKRST_CPU_PLL_POSTDIV_OFFSET   0x0C
@@ -47,6 +57,7 @@ enum Ax3000Configuration {
     AX3000_NUM_IRQS     = 224,
     AX3000_NUM_BANKS    = 2,
     AX3000_NUM_UARTS    = 4,
+    AX3000_NUM_GPIOS    = 8,
 };
 
 typedef struct Ax3000SoCState {
@@ -57,6 +68,7 @@ typedef struct Ax3000SoCState {
     MemoryRegion        dram[AX3000_NUM_BANKS];
     MemoryRegion        pll_ctrl;
     CadenceUARTState    uart[AX3000_NUM_UARTS];
+    CadenceGPIOState    gpio[AX3000_NUM_GPIOS];
     AxiadoSDHCIState    sdhci0;
 } Ax3000SoCState;
 
@@ -72,7 +84,16 @@ enum Ax3000Irqs {
     AX3000_UART2_IRQ    = 114,
     AX3000_UART3_IRQ    = 170,
 
-    AX3000_SDHCI0_IRQ    = 123,
+    AX3000_SDHCI0_IRQ   = 123,
+
+    AX3000_GPIO0_IRQ    = 183,
+    AX3000_GPIO1_IRQ    = 184,
+    AX3000_GPIO2_IRQ    = 185,
+    AX3000_GPIO3_IRQ    = 186,
+    AX3000_GPIO4_IRQ    = 187,
+    AX3000_GPIO5_IRQ    = 188,
+    AX3000_GPIO6_IRQ    = 189,
+    AX3000_GPIO7_IRQ    = 190,
 };
 
 #endif /* AXIADO_AX3000_H */
-- 
2.34.1


