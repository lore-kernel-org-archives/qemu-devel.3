Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43667CDB46B
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 06:06:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbXnD-0004x9-8N; Mon, 22 Jun 2026 02:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wbXmq-0004sk-Qn
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 02:05:40 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wbXmn-0006dI-7l
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 02:05:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aE50prvocDTwh5uzRky7fUz79liT7g08Ao5sDkVGDTICJKr9j6GAtSgdSdpk/eLESQvTZC0YgsTI8A6drMe9Tu0Nmo55QfpNQFbxz7tGvZDm7xObCkSDr3zlvX/KoKRmpCzvZnfgqTGSY3s8oxW9AfuFERhS8SeigX21330YGejPJYId/qB1SWkbz2A30b5yRQlP+BVq0F4ZyzsoivO67wd8LpAE4yUpnsNM1qjMmudtL+gHwiq+u6q2voBphxCWSLg7sn0BqmlNSudQ+txuCSBcUNDHlbNVrOvDZYv69MYQfRT0eKCXCiZQtsnEDy4DqSEpJ57avYt0JQH7233HMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ih5KlBM31tv7G8Xh1DYmjLXIPinn+btQ9QOz0eBgst4=;
 b=h0d2h8UaXXf9I87O3StqMh6UGHOKrTm3HTZYIQ19ftpJaX8GTRNm+/K6X+5LUUf01MMKn68WDF9/d+miyqB/PCuTkvDxPH7/o6zHJCILMEhHL056hH6wTgYAE2rrBminp6MWchTGPg/AY0QrsMoTrMOZBmQEJLidC75LA4jpnmQXozrUN4dUiySMj0O2Dg2Wzkrqx6gwTFyaMoIvJkMhNGUiXs7iuqpyV6Rl3NZgOpJ8sm61PItdVczfXKvtSv39HLIqJChw0h6zRrQzyuIpQ8dlVeUg3cJEWT47cVMguuZ583w59wQP2wBBjEYrLImYTlUiQhmYkkxJVAW7BBNMZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ih5KlBM31tv7G8Xh1DYmjLXIPinn+btQ9QOz0eBgst4=;
 b=GjnTf9qj0wlN+Cc52Doxbog+XYqezLwAmaZzrQIcmd9MJlywgMhX9QNyxYD8FK+7XZHy/WMk5H/SdJESxc37/0VK4ZvnXyH9Rm6ueN22JzaLixjhXaIjnlo+UuYCFgDg85XYnzXAP1gl09KpFLCG4wXnTENvt04e6qWuZLQTfXteTi4moPk4t4nGgUQ4bt4b3PP/TIV29q9WZi/kSdygWyAAY1Ec3twhJ6/ye8UFBM8p0o3Sr8reNX9dJzRo7iQscITEPwtfeHxIp4VSxG6qPNq6aEJRccUIAqvEukafhLt6C1AzTNHJEtB9h0XPYu0SBNRTWIH8l/Fk9qenDr4IuQ==
Received: from BN0PR04CA0108.namprd04.prod.outlook.com (2603:10b6:408:ec::23)
 by PH7PR18MB5029.namprd18.prod.outlook.com (2603:10b6:510:15b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 06:05:13 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:ec:cafe::5a) by BN0PR04CA0108.outlook.office365.com
 (2603:10b6:408:ec::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Mon,
 22 Jun 2026 06:05:13 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.8
 via Frontend Transport; Mon, 22 Jun 2026 06:05:13 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id CB88340BFE15;
 Sun, 21 Jun 2026 23:02:27 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org, philmd@oss.qualcomm.com
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v6 8/8] hw/arm: ax3000-soc: Enable Cadence GPIO controllers
Date: Sun, 21 Jun 2026 23:05:06 -0700
Message-Id: <20260622060507.83195-9-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622060507.83195-1-kchiu@axiado.com>
References: <20260622060507.83195-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|PH7PR18MB5029:EE_
X-MS-Office365-Filtering-Correlation-Id: 460d3879-72c9-463c-7a55-08ded024398a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: xF5laY8geHVoey5zvhRMz11KlIGUc0ZCTpkgc19PRREn2ArIcI8pnlUpgyKBvw7LWzy9bRc7Uj117bXJAc8+nyaCiF+lK7WaLOBkBWPd55jOx+rLHwzs35MHrfpLRKg70BNfs0alO408xKG82PPsIFy1foqApdGXCbbavROeR8/XpNeGj70sKzmfYRSE9/pJPt4SU8uzDYRAZYPyPeC3Y+dUvbHBTA30obs0Rh7fG98dRn0Iao5+hL5GCLPo13hYa+omuT/pTEKYCH9mljq3jJOtd+EfVLxGnR6kexcipbBdgSKOBo4Ml5dk9WGYF+jcTJNX57YizzOFlbHDGc4nBrZNjGTyrAU4unHWkyY+guqnxZwIfZeEVXAZjQWG8EFv6y7n2ylP5olD+KvedOAV5VZltlmDvS4+Eefu1pjpOjDvpkp78BYUFGB3rQP/T0zLjgzJJqI694LlhFzbYp3AckzYoIY4T+btsnYnp6rrcDzsga1of5iEzSegBfgkC4iLNupmTshEzgbJTMqaLVOaEdk+IJWb8O31IlZMjzi5t0JR5qd0BrEFUjd5NDoJYtAocWt/MuP6qgyc79/18w5J/H4bUEwcufbDydtLPdKRPQlivQ1xJfPHE0J9YXQe74F3OkHGvHgRce5oHCmYfZP4XgodOtPjB3ky6Wk/VCuE+dG3lUK8O/Ks6HQcrOIo/+b1wqgyWMubboEveAdBUsfGiw==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(6133799003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FgnLocKYuW3KDwTGBR2GWFb5gpf8OPvNTUaEprA9tuwsK3kSEGbtASCsUW70m8LYBSOwHY9XNOcQdinbDmC40dL0jrNXC62I+qkkTf4QnzY32+MNkoHM5k1KtLiDFodbJqd6x3OgNvBJ/L8QOlMij+U1xvhAMiaFygB3PH0UW2if1jj2tEX8H85l1gyN4f4ggX/P0oshiUteqTJxebHDvI3wLur7ruYMgOp8Xx9xhth/xg01WR13J2/jGx+soULYE4tIDcbePPtBVsosw92X4rMcawOGQ8q+Ts0PzpVYX/kN3qJctfekmCfXmx1Bo6tmPq2N9ozLCman+AogPQxiod8u2Z5B5Y/vwpS/TqLWaEXw5meFzyYUUvzPUW1ipCs8Rt1PzRejJMUlSMHFE83nvIJB3PdWlmVnI6A58fbIxuXnkH8TjwUnwoNMrgyBjl/K
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 06:05:13.4219 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 460d3879-72c9-463c-7a55-08ded024398a
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR18MB5029
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
index c63c57fd18d..749de848b7a 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -729,6 +729,7 @@ config AXIADO_SOC
     select ARM_GIC
     select CADENCE # UART
     select AXIADO_CLK
+    select CADENCE_GPIO
     select AXIADO_SDHCI
     select UNIMP
 
diff --git a/hw/arm/ax3000-soc.c b/hw/arm/ax3000-soc.c
index 3a882dd4673..58d167d0fa7 100644
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


