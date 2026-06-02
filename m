Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA8CACD6E4A
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 06:35:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUIhR-0005fJ-3B; Tue, 02 Jun 2026 02:34:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wUIhQ-0005eT-6J
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 02:34:04 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wUIhN-0004bq-Ni
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 02:34:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EezmFBNFuUhhs0c5OmjW082KVOsqP4aZkBQjb9QfmWFUPQ1+LN4nWSA5expp/Uy+P88ER+IJMPlbSKhnkbQ2Z6leXK3/wmaZTd+PyBIkXaYNS9lGyk/UCaJdUjp/7jxubEFAfd5E5skrdYiRip7NN08pF/W/G/heuVKQvefJuM63EJgC4zAG9ecek/sQEciu9J223fEJwxhXdi57B8whQDmCGX/djF3fjrYpaS8AhlX/txuB+1DuJanzsrEx8eEu29Zri6UYst70sN+SH8G0f3qQ+93z8W8H4ymoMG7VRvNwhCZbRPdVydxBB6qDCa6WMgX66NGrP5CxtRU90a896Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5i++P1WeTSff2Wd3mJRaaTQ5SXXN+Yy4VHduISAx1Xs=;
 b=SLTWQJN5vZ1HXR9wSP1ZlIf1TfNSJ2YFFnEZbgnRe/7E20H6vH1goix0wjhiQw0dzD8pCsX2Z7GsyBNg94+HPAMqjLl+Cf9klg+q0cM8qGk7WzkPocVOjbBxo6yYdKvFfrjBWcsvik0tLmqW3BQ6nU7ybZDN/1YwZC/H4msXlXNI/yXo0y78wEqnfUgsQIlYnN3em3TQqOSEOnJAr9r3N6R6jLLA6A1aWo6w5ybrt0bNxZAE9Qt98d/k1vNeH03BwhwPFbQuXVtPWfrq7XbfJAF6jVwQeug9qEieKCAZaxRtr8h7O5lpViv6MIi8nx53uC6SIPZ1P5RoQMAdL8rjhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5i++P1WeTSff2Wd3mJRaaTQ5SXXN+Yy4VHduISAx1Xs=;
 b=e5OlYPluzgLnZt1YH0DU7gtkr7bISvL4dB4zZ/FEsLBIMLkVKbZDVId/OfEujaLTfLNIJK8+ERpOFKnW6duMXv1G/MLuC6X3jurndS8xmglbJhyalcJO/e+Wx0IAqCVaZbtEejYOT7L8lKbfegpPKeNIYxac5zjjlQRDtaiB4iIzOa9W2fDLVU6BxDwAHyMPUbgZIZTkwnD39nTupZs0Oa03vuwhxH4A3C9OLXGvK+Tzb1jkXDsn8RbPeCABB0M7lXMt9I/WzJfQgr8gLC5gXiQwCqpzbvTEoR4jN5b4hcRP2o4SeiGolrpXk6ZHofjIG1FbWC3suF+pmKh3BJ+AAQ==
Received: from MN2PR16CA0040.namprd16.prod.outlook.com (2603:10b6:208:234::9)
 by SJ0PR18MB4413.namprd18.prod.outlook.com (2603:10b6:a03:3ad::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Tue, 2 Jun 2026
 06:33:56 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:208:234:cafe::7) by MN2PR16CA0040.outlook.office365.com
 (2603:10b6:208:234::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Tue, 2
 Jun 2026 06:33:56 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Tue, 2 Jun 2026 06:33:56 +0000
Received: from axiado.com (vm-swbuild01.axiadoRD [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 8CAA74186B5B;
 Mon,  1 Jun 2026 23:31:31 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v3 3/6] hw/arm: ax3000-soc: Enable Axiado SD host controller
Date: Mon,  1 Jun 2026 23:33:47 -0700
Message-Id: <20260602063350.3623723-4-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260602063350.3623723-1-kchiu@axiado.com>
References: <20260602063350.3623723-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|SJ0PR18MB4413:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3e6c9474-1d7c-4b97-2923-08dec070ec3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|34020700016|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: fs+jtroeySDaRk0sZtTizctF8+9N6UIxR7G1iIhYcm9xCLPeHDLC7UDX7XZEkucYMJrnnVnFIjOnNGRgxk1b7PhdhFbZG4NGuG/96l7yTEBZkt0Pipqr0kys53b9K05cN2rLmahptvYwrRWCTiWql1Bme67Z8/75Cs029+rVgc1V2ACn4mynmpklSOpiQ/NvswnZdf4JJ50BLzNCENdvIFqy+WO6oy34nqe4q8M70nQ0TqwA0BXkeXqODciok71XCm9CQ1XiydNz2ifmYPN4vhSpJ7oHbo9uP5Yt5n6fChtx7tFBxYYRDcd7LQzTLXTkxK7PWzXzPjGfW/brcFuaLJU0LuSh536vaqHbP/y1Hi19zoY1tR4XZk/EXnlp/tjLsVn1KZH4NLwq8uMHgwyKnOPtq/THpAkRLgfUT3fydtVJ9O2H35rSmMK2U6Jd4PkC9ZNZfuNA3JsaNcyF3RURLouJ7HOy0C0xc/XVbyQ9ZFXhooKx3+VYnEqsmUYPNGI5b3fkGDI51brDwBCDJ1keah7x8CP7tPIGywEDF8628Qs3HYDbWuGzJBYY5kv2fRXT2rX6dxBNB64ZJlI0ZLqSyj9cXDl6wTD44g3vbwHzmRErUIDRgtlnujeLOZSYPdiQOW5Pl/dUYnlIV3KIGeHhqkAGSeYB3CE2fMLavpqaeYEFpoGWdzo8fkHSWzp1kRGoA++fp1e/eqn+AOBaTSlsfkceYd9MMKtJBNpN2GfNcpI=
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(34020700016)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SKzcJbNgBQQHqm2gO3wYpvKqXjNyP+ZS49wu9QWEq9d36GwUnhVsao3fYu0cIatXLSr1zM1amCpOrYRl5ErqPCVKqLSzUSIXv37b31a83VBsXQwgBGcJbiu4sTpGBLxXzfaBWf6lAtCkYTuZueN2jQihSNIO73TIt6puUnMZza/advO5A4Vp2itte91rdqBVJxUFiCNxqALnm5XFN7fYp9FusW9QmhrDRByCvCrFq9NebLeChWafyrud3M8jad12jgX0AQb3wNCDngdF6Y1inz33/BrMmjUARLYjl/KBc0Ry6JNuvuubA2Yn2Xp+YGr+YGiY4O3RCPLXFzxHcioBEmCjqwkOM3XyTpbbykOztCZQ7iO2/fefq7P44MySDWy68CGwbNzWx3Yw6XSq0zckMXrzvPOUWMduHXHAAvmulMQmAT5B/CX/JcxeciOiMk7q
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 06:33:56.3751 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e6c9474-1d7c-4b97-2923-08dec070ec3d
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB4413
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

Enable SD host controller into Axiado AX3000 SoC to load kernel and rootfs
from eMMC.

Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
---
 hw/arm/Kconfig              |  1 +
 hw/arm/ax3000-soc.c         | 19 +++++++++++++++++++
 include/hw/arm/ax3000-soc.h |  7 +++++++
 3 files changed, 27 insertions(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 39f0b652a0f..5b9cf25dd31 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -722,4 +722,5 @@ config AXIADO_SOC
     depends on ARM
     select ARM_GIC
     select CADENCE # UART
+    select AXIADO_SDHCI
     select UNIMP
diff --git a/hw/arm/ax3000-soc.c b/hw/arm/ax3000-soc.c
index 517cc6f52d5..fd8c2f977e7 100644
--- a/hw/arm/ax3000-soc.c
+++ b/hw/arm/ax3000-soc.c
@@ -63,6 +63,8 @@ static void ax3000_init(Object *obj)
         g_autofree char *name = g_strdup_printf("uart%d", i);
         object_initialize_child(obj, name, &s->uart[i], TYPE_CADENCE_UART);
     }
+
+    object_initialize_child(obj, "sdhci0", &s->sdhci0, TYPE_AXIADO_SDHCI);
 }
 
 static void ax3000_realize(DeviceState *dev, Error **errp)
@@ -193,6 +195,23 @@ static void ax3000_realize(DeviceState *dev, Error **errp)
                           "ax3000.pllctrl", 32);
     memory_region_add_subregion(get_system_memory(), AX3000_PLL_BASE,
                                 &s->pll_ctrl);
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
 }
 
 static void ax3000_class_init(ObjectClass *oc, const void *data)
diff --git a/include/hw/arm/ax3000-soc.h b/include/hw/arm/ax3000-soc.h
index 6e3b5f51d30..763866ce6e2 100644
--- a/include/hw/arm/ax3000-soc.h
+++ b/include/hw/arm/ax3000-soc.h
@@ -12,6 +12,7 @@
 #include "cpu.h"
 #include "hw/intc/arm_gicv3_common.h"
 #include "hw/char/cadence_uart.h"
+#include "hw/sd/axiado_sdhci.h"
 #include "hw/core/sysbus.h"
 #include "qemu/units.h"
 
@@ -33,6 +34,9 @@ OBJECT_DECLARE_TYPE(Ax3000SoCState, Ax3000SoCClass, AX3000_SOC)
 #define AX3000_UART2_BASE       0x80620000
 #define AX3000_UART3_BASE       0x80520800
 
+#define AX3000_SDHCI0_BASE      0x86000000
+#define AX3000_EMMC_PHY_BASE    0x80801C00
+
 #define AX3000_TIMER_CTRL       0x8A020000
 #define AX3000_PLL_BASE         0x80000000
 #define CLKRST_CPU_PLL_POSTDIV_OFFSET   0x0C
@@ -53,6 +57,7 @@ typedef struct Ax3000SoCState {
     MemoryRegion        dram[AX3000_NUM_BANKS];
     MemoryRegion        pll_ctrl;
     CadenceUARTState    uart[AX3000_NUM_UARTS];
+    AxiadoSDHCIState    sdhci0;
 } Ax3000SoCState;
 
 typedef struct Ax3000SoCClass {
@@ -66,6 +71,8 @@ enum Ax3000Irqs {
     AX3000_UART1_IRQ    = 113,
     AX3000_UART2_IRQ    = 114,
     AX3000_UART3_IRQ    = 170,
+
+    AX3000_SDHCI0_IRQ   = 123,
 };
 
 #endif /* AXIADO_AX3000_H */
-- 
2.34.1


