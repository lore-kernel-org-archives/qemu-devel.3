Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 080EFCD98EE
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 08:56:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZm3p-0002S4-Ue; Wed, 17 Jun 2026 04:55:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wZm3n-0002RK-Qp
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 04:55:47 -0400
Received: from mail-southcentralusazon11021125.outbound.protection.outlook.com
 ([40.93.194.125] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wZm3m-0005fH-3X
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 04:55:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q+F2vsH77mXF4pUr2fIvZLRKwiyarz/TABVUFix/hPCgOqvZQouMalZab0XD8I48wSH6SQaPfp+HUTSXCTwFuzGSezyYF6xHcskOk8vUbjsNSPVVeBUzFd4rAvdflxVC0XQ3ANx7ntKwv7fUjvy19V4W9JexXvYhAlXIHhQZZD93e7OVFz4ed8pluEAsJxxRbf5JwldH4HnlyAKgJMEVLNFk8o3ztg39rdXX1R/FzeDILZWq2Vz5CdCOnb+TJENyBhYJzoCS6+5Z5gqqPeYiIDtUW5spDvDYytkSDcrAtckidkKYqvEDBByumwLSdacfRCfkcRlBob3tnELeDxCxcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I13qa5mJszx7TrUChedJIsZx0M3fJXbAsXolvetKpAs=;
 b=Zpohanftyuzve83U93wAwyNWjirjsIYHIZ46ROP39cxOjLNafCpUg97bhDOMYWwRugrnyxiBXhDNCC7w+Gnaf7NUrOCGPDoZ6EUPYvIcKIsH/Zbo4df1fcF98D6NxohlUydhmWN+AFjARDuKbUEX9wEC/BIMpS5ZkF9+bp1rAF5p2eMTPmEi5rTDQqsalICjBGjD+kIJNDj49ROmsPIJs/HFLvQcX0nFY474fpFuChHqqZzmx2i37XEoWBJS5ieLhfJb874xob7DcfNUn0EDq3IEu2FxqFVwtnwwhY3Jg2v53Hy5Sw9tcvbQgfcb6RGqPgvha86H1Yc9Xl63w3bUBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I13qa5mJszx7TrUChedJIsZx0M3fJXbAsXolvetKpAs=;
 b=G+fv8RIe1IhQrUE5KMiT0e/M9XnYV43rSdkO2HKbcyPIOzfaKBvREnpPuCACJf3E7dQXGveErw28/TsWqVb6TiaVhZ0T25R5IGc/JIB1CpLkj7t4F+l7H3k5khLUSudbnlaFIrBL1kZ76HEkFH+zoM20UQrbK151fX/quBRFxzLeW6qevgnvmKvVe0mhMdsnri6/sYMw2KA4IyBZdKXDnhixYfyhpJQV6ivlb7bkp150OxtmIvabQAUuKbYyn09BIeGv3uCmx3RcKoura4Oelvxu9+0ZWXS+5463JsgM6Yk3J8elrlSb5R+m8LQ0ZWJK8gM9nCkf9u858lyQroIAeg==
Received: from CH3P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::26)
 by LV9PR18MB927591.namprd18.prod.outlook.com (2603:10b6:408:374::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 08:50:40 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:1e8:cafe::8) by CH3P220CA0011.outlook.office365.com
 (2603:10b6:610:1e8::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.12 via Frontend Transport; Wed,
 17 Jun 2026 08:50:40 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.8
 via Frontend Transport; Wed, 17 Jun 2026 08:50:40 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 1382440BFE11;
 Wed, 17 Jun 2026 01:48:00 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v4 6/6] hw/arm: ax3000-soc: Enable Cadence GPIO controllers
Date: Wed, 17 Jun 2026 01:50:27 -0700
Message-Id: <20260617085030.2586072-6-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260617085030.2586072-1-kchiu@axiado.com>
References: <20260617085030.2586072-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|LV9PR18MB927591:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c4137cac-ef21-48e0-ca57-08decc4d822c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|18002099003|22082099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: 8SItb3g/gdvWhHrOZVbYWE3WxUT/BDgNBqXDjH1Kmrw20jTl3qyR/LYsIAP44x3jBZWYrIMv1Om2bTwFaAoEhIMFcLo+/e0AzXHW5omPs1tg7wqNaYZH7Lp8JfPSi1w13Fm0YLDXwcB0fMcGNjyd/dLA6B9b+iBb/T4STNj9IXJ7D7Zktp00Z7Kem5krCHautlICZ3T6lrQwPuS0pB7V1Ty5K9v02Bd40qAQTMCtgIaCQGG+PPrDXfR9Q2mGanf7ggQUtkH++CpWUQsrv0kOe3JUtYhA0FsHO+E2aBIKJekFBwG0l2qhYdL7h6g0WIlCOlOzRlawfYoWS45dMsKce8oz0VGnYOXJlDV9HviReD9OyDrxXuRNnvL48utWEa4h9tySpdR0h5sfEBJlGIYJUOxkJQzfbOPl3RDTAIPgr8nH9KE9yS2FRj/K3MKCTVw6dncDW3AiirVHuM1xxsTcwvQOj1zhvSIZQ1oQCx0ZDFmZnOTE6KHlbvY+/OwqaBQpvu5XFbGsIenlANbD9gFZMwRr05nfbOmZnlsMK6YRt8CO44DjWfshp4P4ju4L9Y+kAZbHRzNNa/wmQwMw1P0ZQvcC2JaeRWzSciQRvxR38aUe0qZHod+CVyakN3ViHahT1VtD+F4DgjiGxsdgDeZn8xMHmkqpjV9GyiNa5xuRN/oHBReY7LQTP2fwYlw6XYCVLg3yXMFwQ9znsXTqq4a7q+zA1tYAX5d8vK6Z+3hsJj4=
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(18002099003)(22082099003)(56012099006)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 20dBQckLQXXQaVnM0iebHfU5EpIhCIzbQKPbDy2WRRIR0KW7k9y6cYx6MCD3HzZPtEWNiBhDeK1Yt22XmT7zAN/KHH401vOYrhwid2+S92uCBHuiLLYkDUpKT6wv9cPIv7nNqv6LqD65xj6riUPtDfZMSFG7xoaGGNcL1EqfCdKusJAVmvW3+ulV6nWmNvOOLa2cDkPsyBk/BkzbO8FMv4+qxpIJeiWOiP5emn0lkNrqoNIUarD6ryn2faTd5ViJ1jNRv+X2bHK88TsXzDztdYarampjYZ0bb4zCgX81lWnc3xcVRJba8RBzRgNf/CDN3TDMAqByTW12w/BdBfI09j5lg+QbWhS8PB3n/lPck9zj4Q9W0/e0k1fdvB4JFN9KVGzHDczHT65nAcaO6ILJmvfc+FmYRXQ2gZlH7MuTNSsCSr2F2gOiPoheFZ4NSgeg
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:50:40.0322 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4137cac-ef21-48e0-ca57-08decc4d822c
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR18MB927591
Received-SPF: pass client-ip=40.93.194.125; envelope-from=kchiu@axiado.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
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

Enable 8 Cadence GPIO controllers into Axiado AX3000 SoC

Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
---
 hw/arm/Kconfig              |  1 +
 hw/arm/ax3000-soc.c         | 30 ++++++++++++++++++++++++++++++
 include/hw/arm/ax3000-soc.h | 21 +++++++++++++++++++++
 3 files changed, 52 insertions(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 5240b57079a..4801a18a737 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -723,6 +723,7 @@ config AXIADO_SOC
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


