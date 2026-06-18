Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E67FCD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 10:14:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa9kR-0005fH-8w; Thu, 18 Jun 2026 06:13:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wa9kO-0005d3-7C
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 06:13:20 -0400
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wa9kF-0006Cn-3e
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 06:13:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cffEWCOC6L7q0VTrDH4ueOBkjIdpbaD6lGU3doCd5nGwlmXdERWFo0j2Rg9YsV7Jri+nDbiHYckz8Cg+soF8c8aPtZhM9vTl7wEBKYbBF5j8/qtF1+QBReRsB1aQ8T+tmGtaIggqh2kAiz/Rd0Ak7nFpL0oYXHMv8Fx7Dk+9o3BdGyLdDSlhe2Yck8I8gMu2AHxr2VkSB940rpZieZGaAw9fley8X+T2JYo0GujU1SYsgafV6oMTCh5C0xDQ64HtGAx4GhxXSaefQQN53yBcw8OLO07JPCMQpMriXtJvPZvC975qv1NhdcmUrk5T4+simEFbIJAK1IrUXjeNTkPQhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kn3oCo1Di4r+iQOd3URhtWT1yBvui0dnTPaLjlnvVS0=;
 b=VzpvURCPcdXypVV4RMCev29Zij5Vg0GBnDEYRDeGM0bHln8NgKarTjwQ0GnR0JYixhX1klIqBYzGxqMQiArxb+lpSvqnnG63fmMAWXooHQs8dOuRS6TBFd+bJWtaMBo96ye5VqU4oRZIPR2p/muHD21dQEdmys1talx877Ai18AhxqI69sNz/sgPHwjuIKx7oJebfGNtquDHBV8AlqIn1iLnAhK9ATlEW78SW1QbUXm1USPmEtlD9MguoKiTpG/UpE2spwjY/xy8LxmyVpVUMVNVG8cRK4iL+0wlXdL6O+8WS5Q7DlJCbmhfxyY7BLO3qD9ieqb9G+glDYJ5lbjoag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kn3oCo1Di4r+iQOd3URhtWT1yBvui0dnTPaLjlnvVS0=;
 b=bBq8kOEzFFqEQcyT2hVfFRMzAQFsnoXx2293h1cQ5DfTYfJ+/73PSJgZmBpbZrcKUmYy2ZakKRqlOCJY8EsA9YCp0GYofwbuD79D0BbV9fNHu3yN2rMgP+slwV1MtLSHQkiDacn4P1Je+Jno+deaax4xmYv1FxAqp5EIMqTJQVUHXNo8xtgcPG4IKDtkpcKH3gKCtfYkTH3lFt/3DESu446RD1oT0aK460DxJGDDgG7TWk2ic66xA+72PqkOzr5/TyEfWLedqh1wRPsgb4Vds6etAijYRQzKHDBF0TqbehdTwwwGHSrXGtHwobNTTmcBPmgU8laEAxcpHomlM8ewxQ==
Received: from BL1PR13CA0187.namprd13.prod.outlook.com (2603:10b6:208:2be::12)
 by BL1PR18MB4136.namprd18.prod.outlook.com (2603:10b6:208:30a::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Thu, 18 Jun
 2026 10:13:05 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:208:2be:cafe::43) by BL1PR13CA0187.outlook.office365.com
 (2603:10b6:208:2be::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.15 via Frontend Transport; Thu,
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
 by smtp.corp.axiado.com (Postfix) with ESMTP id 64FF040BFE11;
 Thu, 18 Jun 2026 03:10:23 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v5 5/8] hw/arm: ax3000-soc: Enable Axiado SD host controller
Date: Thu, 18 Jun 2026 03:12:46 -0700
Message-Id: <20260618101249.2926976-6-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260618101249.2926976-1-kchiu@axiado.com>
References: <20260618101249.2926976-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|BL1PR18MB4136:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d28bd4de-12a8-48cc-e399-08decd223016
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: awQkqHBZysqIDiH2QnCpQDiXPaFmN2icx9HwxKxg7hfJ/u991dZ2aWz2iNs2FckPDasqf+S8uKkHBmqj7GAJRP1M3sWLLGoNiHRXIwAzluqnlC9D/0o7GZLTbuzdzQKAbTS0+IxipNAyGK+UGnKIPyJq/3NbcS8Up3oO0A/VAqcX4QNsRTuNPhfEJxvA9J9XdJ36Za+wey1ZVlapfSnn4iCJ8tJnYayN42hjEoEB3JY0MXiD5XldRix16xak90HyLZWyDucWz9ePIzdq9Xn0o8O6v8oFKpDwMTrwwS8mUD1pMFScrq4b/616U7RReQKFjAMJ37xgPGhv2cY9kdvM1Q32kfJXdQlGBw4JHE6Y+v1CLW3tmfBIhOJWxNAtLg9CnDeX6jZVnsxHnMTo3PnUAx05eLAR2D3QmBd/Q93X8Iv5JX6G5F4AxAjQ8IDivICBA7swovwgN53ejVGKP2QIFiWUdhGoNQqJfvUfG7U9PRYDiwyM9hQaODGacOD1aWqoMy7CbI2XkhW++L21zBOtqCMVXXK/UAFXkrnQspVUtzHm9gvbQ9k5/diWV2lePijLm3WW91C8gXqO7ultFzur/HBdEDgW6FOAsCdq40PSCv4zECr+sT0Z45DkBeyApuRvZIWktQYfhjjmHfM6vFa096gQI5QlV/LGKDkriv/9brdws4oNwJQdNai9HSPLkXO6fVx3oYAbZ2MXVnjgsp3FOIHnoQv7IzSr70YBcy2oXSM=
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lCyw5y9C0npyKaHKEoq3EqYyZbXUcA31m5M+uRFsHIF2CWvOLM7xwGCqU1TB+ESmVOOm4NFMTrlARkdRV2kpkGIBlmHjj8xYEA6K9+7eKTKeiqM0IVN3qe8MY9UqKIU/WivIO587NQL9sYwkvVnbFoLqbFlJ2RDYUi1KGbd9u6asOAW00Xc4VBdM+3qpPzitkJ2VU64jkN077RNp8Mur1NAbcCG458DtWU6NVSwRtovHitCsuIrmhDUrYcsvTvuL7qx/OnHgM5MI205Vxc2BXJJXjrej0G7MyMoOceKw8AmIEBulKIPxJ6y3YTzQgCUEJYfsXgmW7DVvqKwjRRRFqyr+JnB4ZGjA2jHr+DppQNn8LhFYtPOlSinrBxgiDowLzJ4hSdK77WtA2lvK+I9iyDPAXyhma0+lmMOGzoueQAmkxFfQPtX0yowKVyO09RBF
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 10:13:05.0549 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d28bd4de-12a8-48cc-e399-08decd223016
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR18MB4136
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
index 866e4b14e6f..13c0b44a180 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -724,4 +724,5 @@ config AXIADO_SOC
     select ARM_GIC
     select CADENCE # UART
     select AXIADO_CLK
+    select AXIADO_SDHCI
     select UNIMP
diff --git a/hw/arm/ax3000-soc.c b/hw/arm/ax3000-soc.c
index 9a01d23bcc6..159385cf913 100644
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


