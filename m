Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B51C5DF71
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 06:35:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUIhR-0005ff-J8; Tue, 02 Jun 2026 02:34:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wUIhQ-0005eU-6r
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 02:34:04 -0400
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wUIhN-0004bv-R5
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 02:34:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FyEUlZ5zzl3uw3lQ+pEhpX9rPVL1JAzHT9xbjwW+EF8dbuYgLwf/+CdeVByBkKLK42Vn8PhYIrSUNucSiRhD9du4dyvMExeyG7m0hNPqh0HtdrdfpIGIM//VY5DFbqL0JmSfeXXBj2tAdiO1D2tDd6N4KcqTS8QGcPU02MhBGg3bDVuOMC+M56zQ1BybLr7fVgjgJXdWu9SAviTaX1Cj57IL1FupXktuwv/ngzHac6xx9Eotbz/cpDcK1X8J69pM5kasJk4dvuwqqHqpqPu+psON2QCx/bXP0+hUUUmxpKSp3xd4dSjSzcJvzTKU2kB5uiKRUxkAUVA/Pep/wClLVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=604fLzWtT33lyCZ8SEvyoaj7ruGF3ReTRMguGEFCk40=;
 b=gny2Dat+aMpqQwN7zG341pQesUPtr+vm8ix51NJgjJpVpT/Ca4fk+du4l+207eKLzeS8ALz03jfGWJo3uo6xnfsgbJcBexkcjMpxtqaUQFWYWUdvNhZ+uWkzv4Qx6khEeNwxgFsLPRdqJOiN2jqbCxUmxz5NxZSLlyQK5GVll9DtwES+nLH+N6aCacTszQXBZydUJAO9MXICYX5eVdMm2hd/NDXsZJrVCtrkdpjtrUkeitNak/xU7pq66eRC/el6XSMYkSl0ulfkZssmaCOxlc4H6A8ikr64JWYg2WTU1pGQdmt+bYMSf98L2e7oDwd1fpVoxYnD/Brva3TZJF2HaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=604fLzWtT33lyCZ8SEvyoaj7ruGF3ReTRMguGEFCk40=;
 b=Geo13iawreCp/jlbtA/NQyHVLfBVFiel6a0qEdfyD/q0HljjlhKWWdIZR600xw92vgy5bnYX+tX3Iy9wrxAkUXuVat2HQYoscNjnG4Ekhx1aESsgp4xCIj8WT6gb8YKM+JlpuVBcUVIaTcDb/TDUvVyaDHpDoU2sWPCz78XNK12/xMyqR2EXkTNO/voAqcY5G9bjDS0Mi9EzTnN8brqfl02OYrAwQ45Hh+FM2xKiBCB6Uo1qfBW7JJBOU6ifO1Eyq68WvXVVg4nMs86uxV0UBSxr8gLlktZ/iThKormAYycmDziYgYK+8BNIm5bSun0iVSMxhq9Ewwh2gH+3PmB/8A==
Received: from BL1PR13CA0200.namprd13.prod.outlook.com (2603:10b6:208:2be::25)
 by IA2PR18MB5961.namprd18.prod.outlook.com (2603:10b6:208:4ba::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Tue, 2 Jun 2026
 06:33:57 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:208:2be:cafe::9e) by BL1PR13CA0200.outlook.office365.com
 (2603:10b6:208:2be::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Tue, 2
 Jun 2026 06:33:57 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Tue, 2 Jun 2026 06:33:57 +0000
Received: from axiado.com (vm-swbuild01.axiadoRD [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id BAD4240BFE11;
 Mon,  1 Jun 2026 23:31:31 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v3 6/6] hw/arm: ax3000-soc: Enable Cadence GPIO controllers
Date: Mon,  1 Jun 2026 23:33:50 -0700
Message-Id: <20260602063350.3623723-7-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260602063350.3623723-1-kchiu@axiado.com>
References: <20260602063350.3623723-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|IA2PR18MB5961:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 11769ea2-71dd-4dc6-5491-08dec070ecd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|34020700016|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: v3/i/LE07Ezpla0q4b3s3i1PJkUCB1EAyJTzdVAfYqLBcSzI/G1BrV7l7zJEOsi4Epjx/wgbU4jSPKrHjhkdJI+uoRlTPqdvhJS5rBlz4cIKjrCBHLeXXyaBknQJWb85R6KyW7rThBNa+BlbXyoNk1baVmQncJTJMuA6NtE5SSl5u46OPzhiG+JezutnRv4wOq8hCyacoy3SDwUU4j57tdyAM8vbVc3dN76fAwoLtUM7Q1gKs0YUrc9JJXTS6mFa1+HvRr7RrK50q5CoOFdZL0DFdXrs+u1aSdczI56/4nWMfFWI6ywDv3x5MZZQKhu3/RpYYnzS4F/qpL1XAo3IoOzwJA1dy+pfmBvkw9tOWNoaVUF5PCaMvBfiMs3CSUjF+m4vki5nB1g/uORAq58R19TVdA1znSS/Y3J3HKeJrqRldM50StMq0INRNg7qnvFMekGwAcwVvRuqJ4el61a+n6MMneuDuXyBT5yn/0O3iUcuTVD+6L74QuPzkNwFqotEpzL8BRfyFK+emP0Q4Riw+zdbkrEL67BfJ3qF9Iyld//wJVZY8osq/+5E7ICPJ/NYaR0PuT6O/PWbpwGYFNZb+ZHsBh7kQmXx4iTlj+OdxatAtPDjxLME/b7pJ4nELsVO5wPoogptF430sGCpORIY7mm92ZFNzpr+hJgk5EjjD8MIyRJ3jBkkWSkiVC3Pjz31Z3D8/HNcLWN5UEWvk4erYDzs9sEmUxxxdHOLc3DnTmE=
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(34020700016)(56012099006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2rmUGbQbBNUS1ZUEaxYJdwirHt1KZCg5ZOoYU1CmR4HOv6o+1lp24f6KTN95+TIyDCk55Ge3fLPsOivELoUdYlFQFTLEFTErE5hbyj3zD4hfyC2hpmizFgib/fx6bt0opKFWgTeVCzUWUftSmxIq4uL1okzFw4h7Dg+3XJlPc1v9SYzGtwwkR8mgZ6EPGjpRcMvxlveyuyIkNfSzkeIWCM0BrBxOlQKCnFa/VHgMhjkno6pN04/aemCVm5SNFGcsPI5O0kT3A5KMc0Ufk9+JDcKWhq1kVm0BWE7PqiEDwppPKK9WlslxXg/w7QTF85xk5mILaPVKz6h0cDqWhYgOxgNomtkmdm5UzITfri0QHadu7NDk1LYIMqPNHdcUap7X97CF04zBctdoN8zSM5yjwOpISNqoyU0uGVIT0eJc4qfvLsmdzqJyyI0GzmWFZSbY
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 06:33:57.3723 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11769ea2-71dd-4dc6-5491-08dec070ecd5
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA2PR18MB5961
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

Enable 8 Cadence GPIO controllers into Axiado AX3000 SoC

Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
---
 hw/arm/Kconfig              |  1 +
 hw/arm/ax3000-soc.c         | 30 ++++++++++++++++++++++++++++++
 include/hw/arm/ax3000-soc.h | 21 +++++++++++++++++++++
 3 files changed, 52 insertions(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 175e6c7985b..1affb1f6228 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -722,6 +722,7 @@ config AXIADO_SOC
     depends on ARM
     select ARM_GIC
     select CADENCE # UART
+    select CADENCE_GPIO
     select AXIADO_SDHCI
     select UNIMP
 
diff --git a/hw/arm/ax3000-soc.c b/hw/arm/ax3000-soc.c
index fd8c2f977e7..3f9abc59dff 100644
--- a/hw/arm/ax3000-soc.c
+++ b/hw/arm/ax3000-soc.c
@@ -65,6 +65,11 @@ static void ax3000_init(Object *obj)
     }
 
     object_initialize_child(obj, "sdhci0", &s->sdhci0, TYPE_AXIADO_SDHCI);
+
+    for (int i = 0; i < AX3000_NUM_GPIOS; i++) {
+        g_autofree char *name = g_strdup_printf("gpio%d", i);
+        object_initialize_child(obj, name, &s->gpio[i], TYPE_CADENCE_GPIO);
+    }
 }
 
 static void ax3000_realize(DeviceState *dev, Error **errp)
@@ -212,6 +217,31 @@ static void ax3000_realize(DeviceState *dev, Error **errp)
                             blk_by_legacy_dinfo((drive_get(IF_SD, 0, 0))),
                             &error_fatal);
     qdev_realize_and_unref(card, s->sdhci0.sd_bus, &error_fatal);
+
+    /* GPIOs */
+    for (int i = 0; i < AX3000_NUM_GPIOS; i++) {
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
index 763866ce6e2..aa388f79f0e 100644
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
 
@@ -73,6 +85,15 @@ enum Ax3000Irqs {
     AX3000_UART3_IRQ    = 170,
 
     AX3000_SDHCI0_IRQ   = 123,
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


