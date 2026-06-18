Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC659CD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 10:13:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa9kN-0005d0-P9; Thu, 18 Jun 2026 06:13:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wa9kH-0005c6-92
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 06:13:14 -0400
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wa9kE-0006Bv-Vs
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 06:13:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MyStBuIAxxJy2uIOMwDOdyenr8OyvpmYHBh8FDb0YTVFA8bYFSvWOW+lkeFBfWLo0OqBu01FmTeGYn/QjSP+/l362jU0HFMcPEJjNPpOLwlVyDF6D1Wtn6D8syj15tzaZDhCnbJWNYDGz7xFaS1nfFbkSpTgbfdJu863cCQB74Jj2yeDjEw4Eo+7zO6kLDCAa8CYDyMyk+BSGZ3d/X3fjyRBp1IrLGtMcBHPNa0+qrhiXyWuZDMdRpVR4bh/ZU3ABQFMY6l6hTul14abT3ypYtL+zet/kTrYmxKlooW/6B5KqY/6K9mrmg3D7WlR72M6fPm51fC4LVIa10HSR6Zfxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=di6xXB4q0ZamLQf6EcwMIC/esOgAswlfGEUL3kBir1M=;
 b=J/953SYYJi51vyzwgCa43G59sqpt+ThKIxKrntny823nCAiZJ11LoaGxEjN5dq7ic/HRxq7H2njqmLzmMU8i8xfwkne3MSz+4IEQinKsc1hpiWyjOl7o+WwBhq9QcJMskyxEl+SgoQ9Zpz9+MKbvzGiJvA+vh4XFR4QFH6EsVTH1s0RpJpjRKc3zwKvgL22MXd8ru/lTfjjyfnuPz8XOt7uCgrI1Lp6oZIpQvysjFM5U37x4YWpKF7sfaE7w36gKQ+UUzKCdimuXlizYk8MmGHkM2HUbYV8JSeYDzd2nbaW2x78VcKUfSPJb0Z3mSgcuRIoeokmv6ijC9XTJc6rqxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=di6xXB4q0ZamLQf6EcwMIC/esOgAswlfGEUL3kBir1M=;
 b=g+Z/H0gsbTm62KFMPbkxxRFtb7VVXkm+OCzfVTL6BCm/H8sKhNYao1onS8rySfE8t7mwNbww87CAMAgCz7V/t0AIXfgqD1o1hnMWAaMgj9yQBbinyrMH3/8myvcE3nzGTRQ79us7b2fj24ou25cfJ38tavEr+8Z7FCqAcHOXZwBVqwx/nrgW4MuCQBIZvnQjrmttylfIYBiagYeVoFG7Cx3ob0uz4f1xrp13rerhkd2aDX1dr5/2fBICENO/yyy/wLSsR9jyvFfL/2AZ4TKT9JvkVVz4dg6jNKhoIbxt0NtH2TzNbtObSEl8tTBiBduazwAWRciO2spo6oL+SefDtA==
Received: from BL1PR13CA0204.namprd13.prod.outlook.com (2603:10b6:208:2be::29)
 by MN0PR18MB6093.namprd18.prod.outlook.com (2603:10b6:208:4be::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Thu, 18 Jun
 2026 10:13:05 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:208:2be:cafe::63) by BL1PR13CA0204.outlook.office365.com
 (2603:10b6:208:2be::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.13 via Frontend Transport; Thu,
 18 Jun 2026 10:13:05 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.0
 via Frontend Transport; Thu, 18 Jun 2026 10:13:05 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id B0B8640BFE15;
 Thu, 18 Jun 2026 03:10:23 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v5 8/8] hw/arm: ax3000-soc: Enable Cadence GPIO controllers
Date: Thu, 18 Jun 2026 03:12:49 -0700
Message-Id: <20260618101249.2926976-9-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260618101249.2926976-1-kchiu@axiado.com>
References: <20260618101249.2926976-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|MN0PR18MB6093:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3df6097c-c905-49b1-6567-08decd22305e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|376014|1800799024|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: R5hMvsa2UaS2XWviAZRoATl6hTI9M67zCY7Izncav+vhOO0FfM1u+HnXJib86MMfcPiGDu6hXVzwAXybk/R/2/n6BeZgPd6ES7wu3cKxZ5lHqLzpCj/ftUg/FZtoEZO1ln5SU01SZWnwr+QPcZBCmfsNylnknOzPYdKxa8sz1CXQx5hCPg+NJ/XoKUQId0qN/IED0TFoetQhpJ/Su+WfYtZv+flJqAfmTs6usJSAUi6+FavLivmOOtjE/sqZToE+VSYDzbfICmyT02AIoTpFZrBSh0MSPV/zbTFg0As2mKeaf1ER5dDMJBc5i+3v0c7w4F33iY9W5D2wbcsdzjh1vzdPg4nZjsON5l001B2zLrs5JqGo9dqAKDVOgHdy5EQgaNKiT5HCIOn/4moSXrd9GIiNotQtPOClL2np55OMZ6vGW1+4yn9pCzcsa+sID1x4QzigLy3tYfNMPsky6r/mXi5/pyGekyhTDmV5bNYk+nznR0bpO1ATornBCXBsklpk6gEJoGAQIh5z1+Kc1olki9YkfVrW87HuMckl0UfAPHFv+4ROt0tL2qxecocPr/8T6PhhhWaBUKxHFrCZYa2h+5sATyD4PGWC/F7/+UaVtxChzt6TB156XGzo4SYxLVsVwMJXdxjv24AdrNgjeTbgTde33mV5GoQKA+j4nKWskRk0sgsG2OqfgJQIWJQ1OTC85DwW331C/NZK4sWcXcOoFPiU2bulyXu907xKgC0lTTM=
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(1800799024)(56012099006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gPNJ90pOR/Mnl7nhiR4K3qRdMOK04WxEMUf7jkmajxEUwAV9jlJRt+2UdJKby33IVWgX0zkCB8nGDLk+W55W70RwByxG8vq+lCu/Fr4DT6BeUxaDMv64vAMgbXQNexv5Znb6Or+iLQAiAtnZCMArgRoU5OHX/LzcblUXOj8k61QBznNqfP5mKB/IYTd6dC2Nqm2wuFbEROuJrNfqCGYAPYta6L+bB2YCtnz5aYTJcOK9TwsgWYYpSUmIiJwGjJcg0d0+NdlFhGvbi9mt8q7aGI2UGYhuB0lkx7lTtJje5wCIKmUSgEUKDmfX304N3Aw7fydV0ZRg7Ac6FYnPzp5AZeIi9i0NIYlSnG2fviLFXMiULPoHDL3A+I7PLCzk4s3QY8QBbRWX7F7bZUqJ0zSvsJVUAVAAugNLU89RoKSRg6eLB/NOvNNYnWsYDsbOk1uy
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 10:13:05.5511 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3df6097c-c905-49b1-6567-08decd22305e
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR18MB6093
Received-SPF: pass client-ip=2a01:111:f403:c110::1;
 envelope-from=kchiu@axiado.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/Kconfig              |  1 +
 hw/arm/ax3000-soc.c         | 30 ++++++++++++++++++++++++++++++
 include/hw/arm/ax3000-soc.h | 21 +++++++++++++++++++++
 3 files changed, 52 insertions(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 7fc6fae9673..84810b0eadd 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -724,6 +724,7 @@ config AXIADO_SOC
     select ARM_GIC
     select CADENCE # UART
     select AXIADO_CLK
+    select CADENCE_GPIO
     select AXIADO_SDHCI
     select UNIMP
 
diff --git a/hw/arm/ax3000-soc.c b/hw/arm/ax3000-soc.c
index 159385cf913..98b4f1697ce 100644
--- a/hw/arm/ax3000-soc.c
+++ b/hw/arm/ax3000-soc.c
@@ -36,6 +36,11 @@ static void ax3000_init(Object *obj)
 
     object_initialize_child(obj, "clk", &s->ax3000_clk, TYPE_AX3000_CLK);
     object_initialize_child(obj, "sdhci0", &s->sdhci0, TYPE_AXIADO_SDHCI);
+
+    for (int i = 0; i < AX3000_NUM_GPIOS; i++) {
+        g_autofree char *name = g_strdup_printf("gpio%d", i);
+        object_initialize_child(obj, name, &s->gpio[i], TYPE_CADENCE_GPIO);
+    }
 }
 
 static void ax3000_realize(DeviceState *dev, Error **errp)
@@ -183,6 +188,31 @@ static void ax3000_realize(DeviceState *dev, Error **errp)
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
index 52b47aa8294..344fcb6f3c2 100644
--- a/include/hw/arm/ax3000-soc.h
+++ b/include/hw/arm/ax3000-soc.h
@@ -13,6 +13,7 @@
 #include "hw/intc/arm_gicv3_common.h"
 #include "hw/char/cadence_uart.h"
 #include "hw/misc/axiado_clk.h"
+#include "hw/gpio/cadence_gpio.h"
 #include "hw/sd/axiado_sdhci.h"
 #include "hw/core/sysbus.h"
 #include "qemu/units.h"
@@ -38,6 +39,15 @@ OBJECT_DECLARE_TYPE(Ax3000SoCState, Ax3000SoCClass, AX3000_SOC)
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
 
@@ -46,6 +56,7 @@ enum Ax3000Configuration {
     AX3000_NUM_IRQS     = 224,
     AX3000_NUM_BANKS    = 2,
     AX3000_NUM_UARTS    = 4,
+    AX3000_NUM_GPIOS    = 8,
 };
 
 typedef struct Ax3000SoCState {
@@ -56,6 +67,7 @@ typedef struct Ax3000SoCState {
     MemoryRegion        dram[AX3000_NUM_BANKS];
     Ax3000ClkState      ax3000_clk;
     CadenceUARTState    uart[AX3000_NUM_UARTS];
+    CadenceGPIOState    gpio[AX3000_NUM_GPIOS];
     AxiadoSDHCIState    sdhci0;
 } Ax3000SoCState;
 
@@ -72,6 +84,15 @@ enum Ax3000Irqs {
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


