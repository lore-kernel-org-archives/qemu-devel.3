Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13521606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 13:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=axiado.com header.i=@axiado.com header.a=rsa-sha256 header.s=selector1 header.b=njMDieES
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTgAl-0005hS-Ue; Wed, 18 Nov 2026 08:58:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rdondi@axiado.com>)
 id 1xTgAk-0005h6-7p; Wed, 18 Nov 2026 08:58:02 -0500
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rdondi@axiado.com>)
 id 1xTgAi-0002wL-Gs; Wed, 18 Nov 2026 08:58:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qu8Q6rgn7rB7jOhd22w52KPD2wCUSmwmOclORKOnc8XZagO8Nwohi/13wkC8K3IE2h9Fz5dyi8VodupOyy8LwLFWDEZCQXeTbf2OgAhMX4DnsFxhIu4Nrk6cLB1FC3QdCLruJ9kuBqgereYRufgR1iTwzNlo65l318taLczo1bW5gK0p6aBRTZG4uSu18ugt3qc/vc/ncrGSnwHDJi+KIjLtoyVanNgz/lohulXk9sFdwh8zFwmlmNhRyTzFTuNHOYlxSlSu8Jvcf1M2BR5P2OnzD11W8eGTlBxeXsvK8Yoz72FNCJ/P/mYvOny/h9rP3HHlNGWY1hckYxLpyiLzsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xyLZsRDYRrkJGLBP6EB4CZss47jZHoNvN0Y2dnysnSU=;
 b=Cm37Z40w9UBVDMwe75iICZALCmg2xEq4nb3hEfzNUyMh0eliiFiqGy1+VxOQqonvBPSNu5Ua84lY9YTI4GXjnVZeYAxpGijPQsEZR/KK2WsGC4YQuz8gM/VxEifwNwQbxHaDOU/nNNz9f/BqizyPsfXYSp8qMwLRuZbggNw99aQZDIkTc5QYPLIPLg//JiRJDWGWMgri6ZUQUdVTtOpryCAh7yXX3S9NNpBoKHrlS0Oz+N7s8pxAPzsVA6NH/IRmfCP2TzkzYMGHU210uaiyu3gfcxEoXz1xRqYF3c2beopGFyrNTFUoZ/MCzD752+HSFtc/4EdVQucYBSaTUwd4lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xyLZsRDYRrkJGLBP6EB4CZss47jZHoNvN0Y2dnysnSU=;
 b=njMDieESBH4JCCldyhlmOBA8pUv0iatwoEmh0TOB46YxfgeLAaRPQLTLiBLKXHewhe6z34+1tbng8xAZwe+vK/R1uYddSMFqowJeHg0NFAWRm7M6fNsmJ+d5aAINPCmjKi7EYHHpU58jG/sDuqoAnxIXJ7/EqvMj0eO6hnoT99QHppf0W1g1L04YYeSUcvj20/GqxoByRKdmibVQ6x2FuYPsSr5pgTrf2LUZQZ+eRAUh0oolFUOJlwxTZvZ/W/qqHoAcle1sPWOYk9pTdx0wG7FTNBlazYQVjdkBxrDV0ZAhDTgr3eD4fJY35EaKi5AtPOJfJ5MNDC14g38aBDEghQ==
Received: from MW4PR03CA0153.namprd03.prod.outlook.com (2603:10b6:303:8d::8)
 by SJ0PR18MB4431.namprd18.prod.outlook.com (2603:10b6:a03:3ba::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 13:57:55 +0000
Received: from MWH0EPF000D894F.namprd05.prod.outlook.com
 (2603:10b6:303:8d:cafe::3d) by MW4PR03CA0153.outlook.office365.com
 (2603:10b6:303:8d::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Wed,
 18 Nov 2026 13:57:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 MWH0EPF000D894F.mail.protection.outlook.com (10.167.249.215) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Wed, 18 Nov 2026 13:57:55 +0000
Received: from axiado.com (unknown [10.4.1.32])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 8F1874186B53;
 Wed, 18 Nov 2026 05:57:54 -0800 (PST)
From: Ratan Lal Dondi <rdondi@axiado.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org, jasowangio@gmail.com,
 kchiu@axiado.com, Ratan Lal Dondi <rdondi@axiado.com>
Subject: [PATCH v2 2/2] hw/arm: Wire up the HCP network complex in the AX3000
 SoC
Date: Wed, 18 Nov 2026 05:56:31 -0800
Message-Id: <20261118135631.3563037-3-rdondi@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261118135631.3563037-1-rdondi@axiado.com>
References: <20261118135631.3563037-1-rdondi@axiado.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000D894F:EE_|SJ0PR18MB4431:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 49d29d99-1153-4217-3b88-08df457bf1e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|30052699003|1800799024|36860700016|82310400026|261022075727099003|56012099006|10067099003|261021121427099003|261026121527099003|261102123227099003|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: NT6RXMnLiwTasP2wUCtzLvtLb25GEbrJdP3VSdRwXOry3x8wQZeF0YTJxOIKIPIUXW3hUADTOroXXOYA1u48C4t+4SKGh2y1kdeT5Aa31AfMQu6Mz8y/vlBTNVjsiQis20wbOwgD0G2nWwTMcPDNMdS4Ak4i+GYEP00VIvv7FLttP0qfrHna2FjM5MDek7ALxCXxWOPceqZ+TyED5+yexJVxYQtorkxzcF/CyulcMUEJSbLCypD3fz5XxMNVWuU3Z0uojUJLzzjzRLk7LhnKQoMkI+UThzCi1sC1SFARXRs5p3136hIeIadTaHlUF+rgpId/GF8p/KhI4GWQ3kMSwgeBZOCetyjJ87Gc2oyCsoqYLm5zGtxSssuxBaUOd0hxT6Zng7E1nYxS0PjrbJyV2ux4sFSivFqNMZuOuZxsqZicvfHhEuFvIv5RBzAytF5BB5S5c+fxQg8VHwwQabgS6IHxiLmQO6XtgSkffcq/QxeFw+xYHp4YcA146h+llnbVqn8/C8tMoRSWMxOFg24LRUJ2IVHgqTzW/nPerRP5b87DLvUTD4aBLxAyT2EcQhcZjALA36lY8yAhDt32b3bA86k7pKh35V48lpwJUZsiOf8rRovbbtvudSMBavKaFD988VWm7YfnLj3ql0wZWax7x5BG6vd4cpnJ0avq6q9oPRiDOkWT6MyyUJVhjz8TVBcYGE4It2aeSskCvctZ1rY9TA==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(30052699003)(1800799024)(36860700016)(82310400026)(261022075727099003)(56012099006)(10067099003)(261021121427099003)(261026121527099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DQCL4z0XmgbQarzojGwRiaTgAePb2oiLb26ci+cazWQJ5KmjrFfBC3PI6EChyqi2kALLIPgoftD7TvkBTd3ayhdZ3hZA4NrPpMfGUMEqlQ4v9cQc/5i91bkjmCfGxLOqEsKQrYdfFgptDd6SmItcGayncxSxyhqwrABt3xRJ4il3iIl9yMuEZaINqxtOUEe4lrJ55txIcSjZLRcewVxPVJnJMmP0ImasaxCycFBUR6Ch5AFeQ4WkfBDZzve+/wI8bFXRS1WfVeAO+fwMPamwR8MPSC4sM7qYiC6Q8QRIjUXdPWuyTigf552Y4yS6MXio/bPwNtEPj3rJ9bunbwE/n9LdY6dkPrtOY0PjFgpkN+FSGAlzdpWYGGwruf4rZzTMqOgK/lUvE1Lryx4uW/URpqT4jPXj2sKBywhYje9KOfUfoJdk6GF18RxzaZsak/i1
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 13:57:55.0321 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49d29d99-1153-4217-3b88-08df457bf1e0
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000D894F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB4431
Received-SPF: pass client-ip=2a01:111:f403:c001::2;
 envelope-from=rdondi@axiado.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Instantiate the Axiado HCP and map its three MMIO regions - the EIP-197
packet engine, the SHIM MAC configuration block and the PCS/SerDes CSR
region - at the addresses the SoC uses.

Its ten interrupt lines are connected to the GIC in the order the guest
expects: one for the EIP-197 itself, four for the descriptor ring
interfaces and five for the MACs.

Signed-off-by: Ratan Lal Dondi <rdondi@axiado.com>
---
 hw/arm/Kconfig              |  1 +
 hw/arm/ax3000-soc.c         | 31 +++++++++++++++++++++++++++++++
 include/hw/arm/ax3000-soc.h | 17 +++++++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index e9f796f718..34f2154efb 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -767,6 +767,7 @@ config AXIADO_SOC
     select AXIADO_CLK
     select CADENCE_GPIO
     select AXIADO_SDHCI
+    select AXIADO_HCP
     select UNIMP
 
 config AXIADO_EVK
diff --git a/hw/arm/ax3000-soc.c b/hw/arm/ax3000-soc.c
index ebe174fb97..be33ce2b81 100644
--- a/hw/arm/ax3000-soc.c
+++ b/hw/arm/ax3000-soc.c
@@ -41,6 +41,9 @@ static void ax3000_init(Object *obj)
         g_autofree char *name = g_strdup_printf("gpio%d", i);
         object_initialize_child(obj, name, &s->gpio[i], TYPE_CADENCE_GPIO);
     }
+
+    object_initialize_child(obj, "hcp", &s->hcp, TYPE_AXIADO_HCP);
+
 }
 
 static void ax3000_realize(DeviceState *dev, Error **errp)
@@ -49,6 +52,7 @@ static void ax3000_realize(DeviceState *dev, Error **errp)
     Ax3000SoCClass *sc = AX3000_SOC_GET_CLASS(s);
     SysBusDevice *gic_sbd = SYS_BUS_DEVICE(&s->gic);
     DeviceState *gic_dev = DEVICE(&s->gic);
+    SysBusDevice *hcp_sbd = SYS_BUS_DEVICE(&s->hcp);
     QList *redist_region_count;
     SysBusDevice *sdhci0_sbd;
     DeviceState *card;
@@ -217,6 +221,33 @@ static void ax3000_realize(DeviceState *dev, Error **errp)
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio[i]), 0,
                            qdev_get_gpio_in(gic_dev, gpio_table[i].irq));
     }
+
+    /* HCP */
+    static const unsigned int hcp_irq_table[] = {
+        AX3000_HCP_EIP197_IRQ,
+        AX3000_HCP_RING0_IRQ,
+        AX3000_HCP_RING1_IRQ,
+        AX3000_HCP_RING2_IRQ,
+        AX3000_HCP_RING3_IRQ,
+        AX3000_HCP_MAC0_IRQ,
+        AX3000_HCP_MAC1_IRQ,
+        AX3000_HCP_MAC2_IRQ,
+        AX3000_HCP_MAC3_IRQ,
+        AX3000_HCP_MAC4_IRQ,
+    };
+
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->hcp), errp)) {
+        return;
+    }
+
+    sysbus_mmio_map(hcp_sbd, 0, AX3000_HCP_EIP197_BASE);
+    sysbus_mmio_map(hcp_sbd, 1, AX3000_HCP_SHIM_BASE);
+    sysbus_mmio_map(hcp_sbd, 2, AX3000_HCP_PHY_CSR_BASE);
+
+    for (int i = 0; i < HCP_NUM_IRQS; i++) {
+        sysbus_connect_irq(hcp_sbd, i,
+                           qdev_get_gpio_in(gic_dev, hcp_irq_table[i]));
+    }
 }
 
 static void ax3000_class_init(ObjectClass *oc, const void *data)
diff --git a/include/hw/arm/ax3000-soc.h b/include/hw/arm/ax3000-soc.h
index 344fcb6f3c..141628ec0d 100644
--- a/include/hw/arm/ax3000-soc.h
+++ b/include/hw/arm/ax3000-soc.h
@@ -15,6 +15,7 @@
 #include "hw/misc/axiado_clk.h"
 #include "hw/gpio/cadence_gpio.h"
 #include "hw/sd/axiado_sdhci.h"
+#include "hw/net/axiado_hcp.h"
 #include "hw/core/sysbus.h"
 #include "qemu/units.h"
 
@@ -48,6 +49,10 @@ OBJECT_DECLARE_TYPE(Ax3000SoCState, Ax3000SoCClass, AX3000_SOC)
 #define AX3000_GPIO6_BASE       0x80800000
 #define AX3000_GPIO7_BASE       0x80880000
 
+#define AX3000_HCP_EIP197_BASE  0x83000000
+#define AX3000_HCP_SHIM_BASE    0x83100000
+#define AX3000_HCP_PHY_CSR_BASE 0x87000000
+
 #define AX3000_TIMER_CTRL       0x8A020000
 #define AX3000_PLL_BASE         0x80000000
 
@@ -69,6 +74,7 @@ typedef struct Ax3000SoCState {
     CadenceUARTState    uart[AX3000_NUM_UARTS];
     CadenceGPIOState    gpio[AX3000_NUM_GPIOS];
     AxiadoSDHCIState    sdhci0;
+    AXIADOHCPState      hcp;
 } Ax3000SoCState;
 
 typedef struct Ax3000SoCClass {
@@ -93,6 +99,17 @@ enum Ax3000Irqs {
     AX3000_GPIO5_IRQ    = 188,
     AX3000_GPIO6_IRQ    = 189,
     AX3000_GPIO7_IRQ    = 190,
+
+    AX3000_HCP_EIP197_IRQ   = 0,
+    AX3000_HCP_RING0_IRQ    = 1,
+    AX3000_HCP_RING1_IRQ    = 2,
+    AX3000_HCP_RING2_IRQ    = 3,
+    AX3000_HCP_RING3_IRQ    = 4,
+    AX3000_HCP_MAC0_IRQ     = 5,
+    AX3000_HCP_MAC1_IRQ     = 6,
+    AX3000_HCP_MAC2_IRQ     = 7,
+    AX3000_HCP_MAC3_IRQ     = 8,
+    AX3000_HCP_MAC4_IRQ     = 9,
 };
 
 #endif /* AXIADO_AX3000_H */
-- 
2.34.1


