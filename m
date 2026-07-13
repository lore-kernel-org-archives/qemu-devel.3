Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97EC7C44507
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:37:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjBD6-0006IV-Lg; Mon, 13 Jul 2026 03:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wjBD1-0006HK-Gf
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 03:36:11 -0400
Received: from mail-westusazon11022084.outbound.protection.outlook.com
 ([52.101.43.84] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wjBCz-0002vU-Nj
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 03:36:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CwCSIxQJXtX6vC1q1iKWLnRja2B1nuqzavqtb4rQcF+kw5gdej/qAt/dOsCxVCTB/DVnV6JLW7LubmeF4PIL9I6gXY5xHoKtMfG/7O6wFWGa1RzuVkscbT9fqHgur1VxwWbj6G/mW8doZidcnop/W0elZefHmtBPNpBHDqMegN4TOcDqm+AB0/ISt8cikbp8eYR4/jbPAuXg9tgeBzxi9DeOVA7++KC5iUbSrwjfY1hwOfmY1tXsNjy/T3b+1hby2cRXLrLPObU7SzM/+7Ly6mFM04+4J1gUlVPvXEd3dYjwKCjTyNuI/euMPWMnorb670Wi+fsprvSlcXBxHGfY+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A8LPj80EayICM+oa6/m0qK1KwuNJEbUpX5jns8DGTBg=;
 b=xWSp2TOK/xAdxODrE6Qb95D3TUg20V1S596DBQOxdJIlFWGURLW+NjFJBoT2DEzD8neuMx6KDBRl2efc2+OqY31DiVnNY5oC61nE+MOpd61KlPDSDY9prMzJ+0mnQyKUgRLsriivSco3avgeh7fJdmxQ9W5R1GcVV31tWrtAFCa9pXJaMuqB5l9BWktLBBuP6UdOJJOSE7EnVrwpRHOfWeglGzQNML3v39x9NgiN3mvf7gQbRp+sbsxL82djblL41wfKt+GhWK4U76ZTtzQ/8vf9Xxgxwm9ciK0yq2iIt8jo29Udw7nXOxUsZ4fteznc6x9uJBq6k8D29TIMS/cYwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8LPj80EayICM+oa6/m0qK1KwuNJEbUpX5jns8DGTBg=;
 b=ibEAPKyeBw4ht/AChNvVarr+vABK7MGjMV8cmWwALa/A73MOd+OHyxrfWGPKE6B1ZiBIcm5ndpmI3HurGwJfj5bn49LwvL1caKpppsfRjVlZTlfoXH6yquGB3zavBmtJpQs3SkTvVQD7xPuL1ns53JpBVa7Hj0OO0oFh/4cnIxB+/blvTbikfuNec2zbCnx2UnJDE02KB5sODxZonT6iWbV5CBW6aRFUnhLpZkKulp1sm4PcEia117cr+gdK0ykSQ1EPkcXxb8Pt4zjpvKTVtK+BZLHvgK3yLSREcTWsxMVOBN4PGHPAhoOqXQASFsQ+3fcQ1BXCSCpFzDWg6rvsdg==
Received: from SJ2PR07CA0011.namprd07.prod.outlook.com (2603:10b6:a03:505::20)
 by CO1PR18MB4697.namprd18.prod.outlook.com (2603:10b6:303:e4::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Mon, 13 Jul
 2026 07:31:00 +0000
Received: from BY1PEPF0001AE1B.namprd04.prod.outlook.com
 (2603:10b6:a03:505:cafe::2e) by SJ2PR07CA0011.outlook.office365.com
 (2603:10b6:a03:505::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Mon,
 13 Jul 2026 07:31:00 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BY1PEPF0001AE1B.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.9
 via Frontend Transport; Mon, 13 Jul 2026 07:31:00 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 494094186B59;
 Mon, 13 Jul 2026 00:31:00 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org, philmd@oss.qualcomm.com
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v7 8/8] hw/arm: ax3000-soc: Enable Cadence GPIO controllers
Date: Mon, 13 Jul 2026 00:30:33 -0700
Message-Id: <20260713073033.3883619-9-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260713073033.3883619-1-kchiu@axiado.com>
References: <20260713073033.3883619-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1B:EE_|CO1PR18MB4697:EE_
X-MS-Office365-Filtering-Correlation-Id: d1ee5608-937e-40be-911a-08dee0b0b00f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|6133799003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ttDC/pjIldyuzXtkLqrmgOjS7GQL9GSRYS9AhDXT65MV3HAJ/NPrw9udyogX9p/R/+Clr4mbUcDIoI7U+gq6ueww8qLsHWO+WMTX2R1D25YxoQYggPph6w8k1/nTA6WoeVpEn47EwMTE9R0HaQxnITHyv12TXqpVrzN54YLg/T8oiepCg3rlXDefJQEFJyjMw4ilEzlFbRU/xb/ii/Pb9IPMII4z2Ta8TlgxMN9GqJTTH7WTQwOCDUrDkLQWusCooAb+caM9CHaphLybmwg/CcRj+ksmWQLcl4pPwQcRryLGiHEpuuw4DDpsVffWp/1MTEwwrRg8nArBaW7iRxXNifUqqTpUcRdiWqmO41wqwDVApPKOhcaEZtM4gWcU99PKfvRetshyNvo9Mdk8i8t5PZgsEwa6zJU6p1xjAfsz5DhiZoslBrb1/3Id8yuzy5YVZCDwSiKhu1lt9Tpv+NfVssXNljXpKH+WjCYQLIYYCQUXov/D/FE00TTE1XJ4iUUq18+c/1cBxCd/186+Hl6I1SfwvdSlR5WrbN8SQexes4ZNJ4YWEkhZNEdyUqdk4lLQruX4R/Ke9YSpzFAPXbIrNGn0TPPS53A06/0+VspeMppIfPdtDDn0IE8Cyk9nyW13HF4loYhuw0QPvODaDOsE3IRBcgl1W2hKHSLG9FCzDif2JRZW0kC00JoQTbtjQXQogLgjgEP/fMWCPThy9Esx8g==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(6133799003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BpywM/0tUoJ08S/eZ17WqU5VZrSomSIFsxMFN7XGP3eFQKozZpDc7404qJ3U7Nd0OUo3e8s+9OzgmCzlAPK2KHQoHVg3DZGSoCX+JWOSdEwbbqQPog+A7ypkWZwPdvcSsoq/hqFui3kCiJLz2lBDJQNy7i+cG7c1cxPDxVnEkPSyDkMT+GAiRGNFaRc+A6ozMGPHyTRBaqDHUuMAFcCo/1d/0covduuGsQU2SO1ygGP/JkKfbgbfanHVR7qsayD029KFVzoVJK6REvkMFEA5wxSKcZBc4t4JB/f8r4uzerxKaISyOKEfQ6NmNUey3zvDDFbZSNqtJJnBmjkCBvdnV/okQ45xPmamAXUSaym1R9JquQ57aiqKIQ3hVGgniuGKLk7DG5zBYwBgnRbnEPWUfVqJBKj5SYA+lezw1i9QisJbUI1HJeMDyYRkam4M+kTM
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 07:31:00.5415 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1ee5608-937e-40be-911a-08dee0b0b00f
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR18MB4697
Received-SPF: pass client-ip=52.101.43.84; envelope-from=kchiu@axiado.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/arm/Kconfig              |  1 +
 hw/arm/ax3000-soc.c         | 30 ++++++++++++++++++++++++++++++
 include/hw/arm/ax3000-soc.h | 21 +++++++++++++++++++++
 3 files changed, 52 insertions(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 6ca172d750..b78f362931 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -730,6 +730,7 @@ config AXIADO_SOC
     select ARM_GIC
     select CADENCE # UART
     select AXIADO_CLK
+    select CADENCE_GPIO
     select AXIADO_SDHCI
     select UNIMP
 
diff --git a/hw/arm/ax3000-soc.c b/hw/arm/ax3000-soc.c
index 23903b081b..71e31c6fb4 100644
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
@@ -187,6 +192,31 @@ static void ax3000_realize(DeviceState *dev, Error **errp)
                                 &error_fatal);
         qdev_realize_and_unref(card, s->sdhci0.sd_bus, &error_fatal);
     }
+
+    /* GPIOs */
+    const struct {
+        hwaddr addr;
+        unsigned int irq;
+    } gpio_table[] = {
+        { AX3000_GPIO0_BASE, AX3000_GPIO0_IRQ },
+        { AX3000_GPIO1_BASE, AX3000_GPIO1_IRQ },
+        { AX3000_GPIO2_BASE, AX3000_GPIO2_IRQ },
+        { AX3000_GPIO3_BASE, AX3000_GPIO3_IRQ },
+        { AX3000_GPIO4_BASE, AX3000_GPIO4_IRQ },
+        { AX3000_GPIO5_BASE, AX3000_GPIO5_IRQ },
+        { AX3000_GPIO6_BASE, AX3000_GPIO6_IRQ },
+        { AX3000_GPIO7_BASE, AX3000_GPIO7_IRQ }
+    };
+
+    for (int i = 0; i < AX3000_NUM_GPIOS; i++) {
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
index 52b47aa829..344fcb6f3c 100644
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


