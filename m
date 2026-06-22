Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3321CDB46B
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 06:07:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbXnR-00052w-Nr; Mon, 22 Jun 2026 02:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wbXmo-0004qO-V8
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 02:05:36 -0400
Received: from mail-westusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c001::5] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wbXmm-0006d4-Vs
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 02:05:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cr+jkOJn95T9fKbicKpoGXd9NhcVxKnOoxmnc/utObjjlXtZprUnODGJSU8J0KMVPMuNoc80cEOzeY+l0EVz140DSWBHFqIbgxuUDQul/etovW3YN5CT02CK347XN0oGqENniKgeB4ZMTe4ek66wV3bonFO74c43cgoCtmzIPeFxKqZKCUatkcI8m3iHex68dcJn/xmSSEBSH16eDtQ4MKptkeV46NvJZf+XYF/4u/GMwp2++9YCZcaFmsYiUtWD3anErqOwConDhGmup8P6Ala5wuT7Hl5chACV4f4JsgvkYwUxEGDHg94XGb9bzYOqNLaICkEykq8KCCax2k2HIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ni568zj/C7PiPHH70jIP770vIIailqU/rJvPxyZA9hc=;
 b=SOymenlDoCNIRWXIVYXXUBM5x/nvKkw2qDZv93CXL+EzzouLLDuD/WCsMMAHmG1onKo2GY8omG+w0BXh2MWHNzcNjxrZypFZKq2h6RneUuZo6+S979OADuSTBbQdLCGIWHA9xN2YQNx/qsaIZMHTj6cQkBCBeEMsEuSk5+mQjvr/M5OIdoV2mbMi+ZM1FUxLZoDKlxjCdkUC/eN8Z1Cv6HgNFxHiKCbT1TP+vpizq+/4QNHLaeP/IoraE6W95Wm/Fwlif//8W04pO1bWPGcGnvnYDNl77qYyQoClTmaaLj7FM5RIP/blZTw0NYsG+gFhEhDM2XxE9zvwnTM8nqCQBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ni568zj/C7PiPHH70jIP770vIIailqU/rJvPxyZA9hc=;
 b=P0q3J/M1/Ln8AdFqoxS8/drWff0TEj9neGVcF6Eqtt4Kb/0SidZeCkpU35ASrgOg+LLH9QohF9K8tjejTHJMatMYQDFDwAtqtPXJwtH1ulHSoNsJPHyDgLYOhf73LGfJvfgCa864nLknh8ZriQhlCB7+pyUrOYcC31uVhj5BhmEOKqITd96hVLyrn5Bo4dojF443lwIni+qznHQrOaHPTiNzUJVaU5wxfG6Tkf5IGY8/kiTUfb1V0pz7fidFw6FlxpWa/cOsY1t1BZuRzzuyoBYlYVBPs9O0Yp5HQWACTSxfgcbgVsSoU1ZTk3RliXCkhhvkU9MedIX0O7VnFN+0lA==
Received: from PH8PR22CA0009.namprd22.prod.outlook.com (2603:10b6:510:2d1::25)
 by LV8PR18MB6197.namprd18.prod.outlook.com (2603:10b6:408:263::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 06:05:13 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:510:2d1::4) by PH8PR22CA0009.outlook.office365.com
 (2603:10b6:510:2d1::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.19 via Frontend Transport; Mon,
 22 Jun 2026 06:05:13 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.10
 via Frontend Transport; Mon, 22 Jun 2026 06:05:12 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 985BE40BFE11;
 Sun, 21 Jun 2026 23:02:27 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org, philmd@oss.qualcomm.com
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v6 5/8] hw/arm: ax3000-soc: Enable Axiado SD host controller
Date: Sun, 21 Jun 2026 23:05:03 -0700
Message-Id: <20260622060507.83195-6-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622060507.83195-1-kchiu@axiado.com>
References: <20260622060507.83195-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|LV8PR18MB6197:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f28c0f87-c751-4d9c-019d-08ded024392b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: Ht0Y/vs20Vm06bvxaojM5GgIw4GuL3M8Aoh97Wcr7a+/KN/kTm+qxlrW7iddu4flkedz+9QuGXalM3e7RoJPNYNuGH6nIWRSsp5JiGoNmL7WyP0skF90DJAlIIiGLh3KmyQ7aOcc3cuGKINYG+WSaHEcL96ULLaYlEDCBPZo815yHmhjeWlPKGYkV5KxMvhcue0fAff0qwvOqeP+HZ2mOGAFl5WV2ua1y/2bC67x/0otHMgm/6YYs79McRRhb9pX7VgkHnvG07HQm3Bg1RgEppFrUfSjSlJaMP3P8OCYGP744VjF2c42AQkOG4HVTklA6S2iuRX5b+nGelMqBOixhdUuBxituztks0ivAaBnIPlqLwoEQXHgS7BmPCbeH03TAWOQpQvdeBt4LCUCPwC9n19rpY8HeXeRf7d3kvHB36r05mc3WKWJf9lqBYWX+1r93EBwRbBqshS7MHD890lL3GoyszcwPN7fQpM6Pq6PCF6fchgtvT29PSJnvzQq1dyJCBX88fP/Qj8/JIN82dncf0Kq0fluQI1iRVRLqFF6T8rHRwsvbuVE3QMmLjDEoS4e3Yki0dfZ6nKV6eTRM+XdZ6DiusvDDmEdrs0S/8BtSN1/t1rrB+mfhAd1VAVzyJUuyEovOwqNSfJ8kdD4oPPBdbFQEuje4iPx0M27lVkw2BvIKPUg5VJt5Vcvd6yqEMnnkdY5AJ4+mlEsNX/e+7igCg==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: p7k8omerYvJKRlZjGVRmPFYqJYVcLnfgW2xYSR0A9y0K9T2QcjLoaygLBz3sFKFlI7qGKvY7HIU14yPwBnyxHCEZf015UTnJ8FzGGPrxgLrBdWgoeW6LdHPDqvxAVKNM6x3mACtkkuqCBS4shGwIFAULoZFtmDk3VubYO9yANNVOImKokKSjQVk2hAE32cHSmPQTcTjM3RT2MZFlTuM729+XjPiDfU2OOUNYZ/uCSBMcsiRzhZVFyajC7u4HC8OhwNSySF2SCnAN7PyLDXmmoZXa0QhUCYKkztTSMobJ0FyofXJIz8RmzPwDYbZ2cqY8o4Mx0kkaQnwk/tW8cN+vU+Mwwtc1ZJyAbd9IuOFIrwMZhCvC3RNjnsOq3CrOl/a5GUXGNdzvG48L0RzgEMMdH4KqaI+/DvKDaP4l0pNjFZCnRaGU18HIIon8Od4j/Kgd
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 06:05:12.8459 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f28c0f87-c751-4d9c-019d-08ded024392b
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB6197
Received-SPF: pass client-ip=2a01:111:f403:c001::5;
 envelope-from=kchiu@axiado.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
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

Enable SD host controller into Axiado AX3000 SoC to load kernel and rootfs
from eMMC.

Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/Kconfig              |  1 +
 hw/arm/ax3000-soc.c         | 18 ++++++++++++++++++
 include/hw/arm/ax3000-soc.h |  7 +++++++
 3 files changed, 26 insertions(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 63fa8869317..4a201dc8236 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -729,4 +729,5 @@ config AXIADO_SOC
     select ARM_GIC
     select CADENCE # UART
     select AXIADO_CLK
+    select AXIADO_SDHCI
     select UNIMP
diff --git a/hw/arm/ax3000-soc.c b/hw/arm/ax3000-soc.c
index aaeae110747..3a882dd4673 100644
--- a/hw/arm/ax3000-soc.c
+++ b/hw/arm/ax3000-soc.c
@@ -35,6 +35,7 @@ static void ax3000_init(Object *obj)
     }
 
     object_initialize_child(obj, "clk", &s->ax3000_clk, TYPE_AX3000_CLK);
+    object_initialize_child(obj, "sdhci0", &s->sdhci0, TYPE_AXIADO_SDHCI);
 }
 
 static void ax3000_realize(DeviceState *dev, Error **errp)
@@ -165,6 +166,23 @@ static void ax3000_realize(DeviceState *dev, Error **errp)
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
+    card = qdev_new(TYPE_SD_CARD);
+    qdev_prop_set_drive_err(card, "drive",
+                            blk_by_legacy_dinfo((drive_get(IF_SD, 0, 0))),
+                            &error_fatal);
+    qdev_realize_and_unref(card, s->sdhci0.sd_bus, &error_fatal);
 }
 
 static void ax3000_class_init(ObjectClass *oc, const void *data)
diff --git a/include/hw/arm/ax3000-soc.h b/include/hw/arm/ax3000-soc.h
index 329aa4e7698..52b47aa8294 100644
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


