Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99CBDC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:36:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjBD5-0006Hq-EN; Mon, 13 Jul 2026 03:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wjBCz-0006HA-RO
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 03:36:11 -0400
Received: from mail-eastusazon11022098.outbound.protection.outlook.com
 ([52.101.53.98] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wjBCw-0002vP-Eb
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 03:36:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kaNmIBt3JCYmLd2ybfbmNBCG3N2mfOnLnF5BblkIJN6ZG6WwV1cyA2omgBwU2PDRkztQIFiAiLoyBbdvnvIwgElMccgntpRZUZRaUClgKkuxkVU3vOV4D6fGbwpr3c3FXwd0eHx+1mihfuh3VxUOCL0/5p5TFWBjbJt0LmiLknfhImlmpvmwjZrSpM5LvKxYWrr9XyYwqn3GF0YQo4H0Glh+SNcy3pP+xkbuGhFG7rxY7A7AJjFrzAS1oO87sqweE66jjE5uRza+nIYyINQWfb8ofDD2/TbVWdqkgG7b0SbWNFQx0fVHW0LjYh3jIk2K22YWsNgpiUuhxbaupeeGHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PF71HK3uIMcH0aKyUJdJCfQ1HxPlx7Lu96khR+UIZac=;
 b=SS1C4w8An/5kSCBaij/45M4LKtJJctUKP9e8TMVzIMLT3YNdX/oI43XqO/XSzfSONzM9Mx4qZC3sKOGRTlNeZ/jwuXpUn9EpByVxEKQMQAlMBasljcosl9sCNlvPEBOlZb4cWWdV3dQ98xI+8zJfreci6VK3lPriCWk2huqt+R8CHXL+3xsXvjBcM3MkfWECDLv52qYefwmTlofnafrrME9E+eK9HIbR+0JEsemrJb+PTDd5Fvp9im/fUFKDiXVqVAL/JNJf9Y6/fioSImXkmZwIeXCHO8XyRR4E3TgXihfMaP0bpNTBebBgrvQUJH2rzjgdM5US/lYTk8qvSzRiBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PF71HK3uIMcH0aKyUJdJCfQ1HxPlx7Lu96khR+UIZac=;
 b=AgaAMsMKkRBygDipRoebnC/66mP4pEurSqkNlOqPwMA+ZCusrVUeqYKioM5ybLsHZUgkkVP2nBcTex60QpHntftG5PTXl3iWTzUBDneOpVS+teyWf0rqzTsuBXaOYInEXfwz+zeIkmo0LgiAsPHm/BDRjcNYmYvoaZ4IgPp26rjQeTLTV+lDqg/4twRsV9BvfA6GUl7/bDdNC4/J9+6wNJ+AtdschMzkGJugepy3DnlDZVcUnzzrvpiF8ZCrSGhb5AWprCUDbfxVVsrzMHZ3w0d7nFv3XZfVg50WyS99qOxqOxmGlySurxsovibjg4WEIomufnZLcbD3YLHekxwFGg==
Received: from CH0PR03CA0294.namprd03.prod.outlook.com (2603:10b6:610:e6::29)
 by MN2PR18MB3589.namprd18.prod.outlook.com (2603:10b6:208:260::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 07:31:01 +0000
Received: from CH1PEPF0000A346.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::91) by CH0PR03CA0294.outlook.office365.com
 (2603:10b6:610:e6::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Mon,
 13 Jul 2026 07:31:00 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 CH1PEPF0000A346.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.9
 via Frontend Transport; Mon, 13 Jul 2026 07:31:00 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id A967240BFE0F;
 Mon, 13 Jul 2026 00:30:59 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org, philmd@oss.qualcomm.com
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v7 5/8] hw/arm: ax3000-soc: Enable Axiado SD host controller
Date: Mon, 13 Jul 2026 00:30:30 -0700
Message-Id: <20260713073033.3883619-6-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260713073033.3883619-1-kchiu@axiado.com>
References: <20260713073033.3883619-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A346:EE_|MN2PR18MB3589:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 60924441-d0a5-4b03-b9db-08dee0b0b023
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|376014|36860700016|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: dUEzzoIzoND2Qmw1ufp+c5jGa+8xwoUrgr/ldLnhspu/I2KcWAPJyVbeQR8KBmff6YZLV2jYRUSOR8YF8V0Nqr3HEpnNGxpJYZOKMQcOTI0WZJ7cz+cs5wi2pbyCpyXEy1h+qmN3l4h8vo99+QbvX/wrOFrsMHJwkNxHFlBJbJt54XAMbyYA/WCXP3o4wMdYUVVFUTgIjWxT/JbF/YE+5JADxLuUFOQvIasB9Gm5oowQBUhrB/vJMVv+zMTF5LosOjlsXUNXlbBbkxIVECxeVo+KmETwDiBkarpqLgch6+JLT/72WrXamYLSBFhHZ76ZD921eN8SoULe5AbGgGD5XDbhXILhCxAyrYGZxSu1Pwtra9ag7rsVXXx4K8nK0Qa9mEsaBwlSiDIpZ+lv7R5I2C5L1yX8T85aYgRo1wM3h4S/HIrleNNNcFUcFgUwlj4NvYQNnLLso01JKramYgufWSNqnZY+4bz6jDIqiuSLIHoSVPfLslp9kaKc2jpciRBjtTeY3bhBuG6YNDDOJDsD3CA/G6XoPo0LNLyrdAU2dV7HCbu96U0Vf0WVyfNzKh3G0Gh8mTmn1cG81fBqq30t9HThYkU8UXAdqK8P8sFJcXeOFktNLJjWtY11hGIyf+KJ31AgsIpdHxvJ/ookMD5Jo0zmEcyfGVvPN69P3TSAKTgrNqKk6JiSNjV1e1BV3r9GQ5QKLr0aRD6zN9jXGvX5Rw==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(376014)(36860700016)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fAmP4WXFsyO6mP2zGUKwIfuhREhIvZ0pNBu4H0nET0zE/awemq1TGhbDk0Tyn0c6H5F2KSHSeWxc/knSSQr/GGMG339gzzSawfZgh5W5X2JtV3Kzd1ki2F4QaXcLUwfb5QvTHA+VlaB3u5UPQ+WaGp0FdE94Al0Vlr3wMbqmwaItPdsOvWwmR51n04zVeDEKlgGoqUB7j5MWl1MSWV7xqyq23dZhaEoXREm6nOmP08CaxijO9rK8jcvs3zJm5tHshpM/VT+UNdFHVDx69wn75cxBcqwonMcOFsfB63+NmuQXn3zB8Ov85yvb24pZ3cCVgyM6trAsWfEXU/pXnNiuFxUkg7OEdUcgEZYtx8BfB3u/aCwTTS2n0slOQUryVCnLhgygaXKejPeegToAgDP/AVOJmhe5Ga7boMTxwRs64jFo41KMWJ3kZAiDzclY5VaY
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 07:31:00.4769 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60924441-d0a5-4b03-b9db-08dee0b0b023
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A346.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3589
Received-SPF: pass client-ip=52.101.53.98; envelope-from=kchiu@axiado.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_NONE=0.001,
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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/Kconfig              |  1 +
 hw/arm/ax3000-soc.c         | 22 ++++++++++++++++++++++
 include/hw/arm/ax3000-soc.h |  7 +++++++
 3 files changed, 30 insertions(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index fc82a1ab01..411ea90bfe 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -730,4 +730,5 @@ config AXIADO_SOC
     select ARM_GIC
     select CADENCE # UART
     select AXIADO_CLK
+    select AXIADO_SDHCI
     select UNIMP
diff --git a/hw/arm/ax3000-soc.c b/hw/arm/ax3000-soc.c
index aaeae11074..23903b081b 100644
--- a/hw/arm/ax3000-soc.c
+++ b/hw/arm/ax3000-soc.c
@@ -35,6 +35,7 @@ static void ax3000_init(Object *obj)
     }
 
     object_initialize_child(obj, "clk", &s->ax3000_clk, TYPE_AX3000_CLK);
+    object_initialize_child(obj, "sdhci0", &s->sdhci0, TYPE_AXIADO_SDHCI);
 }
 
 static void ax3000_realize(DeviceState *dev, Error **errp)
@@ -46,6 +47,7 @@ static void ax3000_realize(DeviceState *dev, Error **errp)
     QList *redist_region_count;
     SysBusDevice *sdhci0_sbd;
     DeviceState *card;
+    DriveInfo *dinfo;
 
     /* CPUs */
     for (int i = 0; i < sc->num_cpus; i++) {
@@ -165,6 +167,26 @@ static void ax3000_realize(DeviceState *dev, Error **errp)
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->ax3000_clk), 0, AX3000_PLL_BASE);
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
+    dinfo = drive_get(IF_SD, 0, 0);
+    if (dinfo) {
+        card = qdev_new(TYPE_SD_CARD);
+        qdev_prop_set_drive_err(card, "drive",
+                                blk_by_legacy_dinfo(dinfo),
+                                &error_fatal);
+        qdev_realize_and_unref(card, s->sdhci0.sd_bus, &error_fatal);
+    }
 }
 
 static void ax3000_class_init(ObjectClass *oc, const void *data)
diff --git a/include/hw/arm/ax3000-soc.h b/include/hw/arm/ax3000-soc.h
index 329aa4e769..52b47aa829 100644
--- a/include/hw/arm/ax3000-soc.h
+++ b/include/hw/arm/ax3000-soc.h
@@ -13,6 +13,7 @@
 #include "hw/intc/arm_gicv3_common.h"
 #include "hw/char/cadence_uart.h"
 #include "hw/misc/axiado_clk.h"
+#include "hw/sd/axiado_sdhci.h"
 #include "hw/core/sysbus.h"
 #include "qemu/units.h"
 
@@ -34,6 +35,9 @@ OBJECT_DECLARE_TYPE(Ax3000SoCState, Ax3000SoCClass, AX3000_SOC)
 #define AX3000_UART2_BASE       0x80620000
 #define AX3000_UART3_BASE       0x80520800
 
+#define AX3000_SDHCI0_BASE      0x86000000
+#define AX3000_EMMC_PHY_BASE    0x80801C00
+
 #define AX3000_TIMER_CTRL       0x8A020000
 #define AX3000_PLL_BASE         0x80000000
 
@@ -52,6 +56,7 @@ typedef struct Ax3000SoCState {
     MemoryRegion        dram[AX3000_NUM_BANKS];
     Ax3000ClkState      ax3000_clk;
     CadenceUARTState    uart[AX3000_NUM_UARTS];
+    AxiadoSDHCIState    sdhci0;
 } Ax3000SoCState;
 
 typedef struct Ax3000SoCClass {
@@ -65,6 +70,8 @@ enum Ax3000Irqs {
     AX3000_UART1_IRQ    = 113,
     AX3000_UART2_IRQ    = 114,
     AX3000_UART3_IRQ    = 170,
+
+    AX3000_SDHCI0_IRQ   = 123,
 };
 
 #endif /* AXIADO_AX3000_H */
-- 
2.34.1


