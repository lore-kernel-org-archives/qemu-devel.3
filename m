Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86DB7C982C1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 06:28:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6j84-0005vu-Tm; Wed, 16 Sep 2026 02:28:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rdondi@axiado.com>)
 id 1x6hcu-0002Ef-Rs; Wed, 16 Sep 2026 00:52:10 -0400
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rdondi@axiado.com>)
 id 1x6hcr-0001XO-Td; Wed, 16 Sep 2026 00:52:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xRsGVlcHuF2VYMbDhGQvQSwgex9Kw4/AZkW7if4jZ3QcxlMOntupHQoUqqj1yydpisLTIiShz7ETMa7MZMgfNEOtjoyBXl/xbW6WYm1k8m1diVIVYWV6s+QoBy8pR4Fx//fnIjJSO+OS8GjEDjCsrow3eTwfKZdrmilQEqQuNx3wtmyXazP7o5p9eDUqCjPslNO/QUu6LDRx3nVHPp+ymjxFCoqufSxCEpQ7mh53tn0sK5KVeVBEOE52HW2IMC2OjS0PKxG0Qp99ANbDujIkZllRy5LLAt9odNZwCwin0H1aLeCuf9ar5VtH+PX4xL6iAT2gZJIPfi2zE/1sM2NRGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yKb4EafBysRSKmV477/Xy1Ah8Q06+juLK9rG8DOlISc=;
 b=rC9RC6nW7rwFxbeHvtlZJciSXE9tlvlZxgpknq8zI9dFdk8oPn0jJrjHUUBLy0CAoyDcdwdPAT8YgFQ7hxCSKP1VYgK44drQAKObIFjeNJn2w1lY1DRc8uha+lrY6Ph9hu039eyg2UG77w9dUhrpg8uTl9GsWEoXyT22YnkHip40HqqXyfKSs/Rh6VpRX76AmcXBkqaq2qwsliQzXCsDBflFW1UBHILKjfXXFjD4QUs4oOYOtcts3N0KXosyCRHGv3D4UXmKejIyPsHBnQIPABft4htQf0ZxUd20/Nm/fosbIA6z9FkK9bUAaBV1ZWxAr2zoJ+Lh2k6CoLV8H1xtog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKb4EafBysRSKmV477/Xy1Ah8Q06+juLK9rG8DOlISc=;
 b=W5dw7qGzGIkhYQtY7RvxXdmosnh+KZURDn6R4tbnQQE9v0ZiYK2BMlf9PbgHMqNxYEqBH0rup7+sPWBonK8dXYfrrsIPm3dgQ9TGkNRycvTSwhcBkSuPpmAb7ABKdoUMoM2RMm5WEktMIZPAaoPtpfZdk0yt4ZeigIvv2oZo31/OWgIgF/e9mBYlpmitr7jhrUKT6w+VWRP99p8mQjW1qVEb+C3cvMOefcbGNlcqZlZg81n6tq82TIq4Cpg/DBAvPJ1VTt1OKhSgOSwGznsqv/+KHd4x09x4YjjZ4wCzAAXTXK5Xjrab8NADlUzMhheevnuW94GxgY1gK+V6w5V1eQ==
Received: from BL1P221CA0043.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:5b5::13)
 by PH0PR18MB4426.namprd18.prod.outlook.com (2603:10b6:510:e9::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 04:52:00 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:208:5b5:cafe::62) by BL1P221CA0043.outlook.office365.com
 (2603:10b6:208:5b5::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 04:52:00 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.7
 via Frontend Transport; Wed, 16 Sep 2026 04:52:00 +0000
Received: from axiado.com (unknown [10.4.1.32])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 79C9F4186B53;
 Tue, 15 Sep 2026 21:51:59 -0700 (PDT)
From: Ratan Lal Dondi <rdondi@axiado.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org, jasowangio@gmail.com,
 kchiu@axiado.com, Ratan Lal Dondi <rdondi@axiado.com>
Subject: [PATCH 2/2] hw/arm: Wire up the HCP network complex in the AX3000 SoC
Date: Tue, 15 Sep 2026 21:51:34 -0700
Message-Id: <20260916045134.1687145-3-rdondi@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260916045134.1687145-1-rdondi@axiado.com>
References: <20260916045134.1687145-1-rdondi@axiado.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|PH0PR18MB4426:EE_
X-MS-Office365-Filtering-Correlation-Id: d9d8b88b-c235-4450-3853-08df13ae3e81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|30052699003|36860700016|23010399003|376014|1800799024|82310400026|56012099006|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: 4ItoEYvArvUmcx7muplvB10RSE0Sj/SveIGyfOwC9eT0WpjojXFe0xmzWHhl2ak9CF/YKl7pZTj5/seedE5gLp/waiIuvffNLH3xNJvKyLaXZmhOhdJM4a9GhMnOZvErVs+ECbddboC7tIns5MfsCIF1kSkes2LgkfgWH/kqP6nkuT0uhjH5jYCWbWeGPoFMF+uQq9LMlUgNiM5UZb+9LSjzXbIGuYEzHQvO69r2QmlMJ60e0mYBwmgtjmBjAO6v0NrhBqI6R2dO7+HnQymRQEjR+su04AVviOGA0w6fuyucJm4RXnGwMNNaJJVMoopMvujfDHy/yak/6aDd0o9Shs8+7xyNrR/mtNmd16Yew26AGmCIgdDOjJujJ9P202bBD0Nik0SRZjU2O/eoP/l83BFFMG4aY/bOKHhq998CbAiPJGurd20JprNjPdH4JlD2eV7bRADLx08d3zOl+2aFTfEaj4PEZj1VgfS8FsZk+z5+zbT2TCMJEdXIgvgnBgv28kUL/tMJKAMM34F1PPVJEH2LE/1IOhu0uvtBxym8D2utBNFm6XlVcX+vTO0ga2f9OkRk7m1KUoDnukEktaUghP8Y3YyK6080AWFjxSCPACyNutVYIoxxsqJBYt1E5j9Va0THj1yz4LifH3KU8bP4Pmjh3W5QffTH/2oVblo2dYhR5cc3lsieEPo3OPC8W28iEd6KFy8UeVmWZURIZx0DHw==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(30052699003)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(56012099006)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UWKCUiZeMZ+zrBuGamBDbFqbz+jpGaMZ5mlqMRecwPYGTfHC10QjDNukfJzF+Pu2nZFNruq4G09r16mhRI0yX2JDSe+QpGatsSXo9DVNSWWG5WAl7uqqvpAWy7+bpRc4CWAjBBBXmJf4B0qq6oLuIy1YStlGqjA69Q4nfLqvbgvnjFHjttz/GAkzz4aSLCNNLSHhCGoNPZdDGRqOTaIBBKefL7yUbtOTeg8VkR90LHPMVQ8Yp1YP6bxB47oL3I/3TxS3XGH9f9mf7cyOJwi7CAKeA/Io5byBrGVasB319GKjM35Ld1C6O/FO3AksQQoK/Y37oNTochoxK3ufxIz6WMcvXrQsfv/T0r6XMjl4mJL88KYK9EtGseTdjdDahY9pho4g9QFlv8ugxKa5CZQejTRuZJrZhdAPbXSW10+2nFP4kL/tZKx+Wxi9CqeiGxGc
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 04:52:00.2123 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9d8b88b-c235-4450-3853-08df13ae3e81
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB4426
Received-SPF: pass client-ip=2a01:111:f403:c007::2;
 envelope-from=rdondi@axiado.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 16 Sep 2026 02:28:02 -0400
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

Instantiate the Axiado HCP and map its three MMIO regions - the EIP-197
packet engine, the SHIM MAC configuration block and the PCS/SerDes CSR
region - at the addresses the SoC uses.

Its ten interrupt lines are connected to the GIC in the order the guest
expects: one for the EIP-197 itself, four for the descriptor ring
interfaces and five for the MACs.

Signed-off-by: Ratan Lal Dondi <rdondi@axiado.com>
---
 hw/arm/Kconfig              |  1 +
 hw/arm/ax3000-soc.c         | 23 +++++++++++++++++++++++
 include/hw/arm/ax3000-soc.h | 14 ++++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index eae06369b0..5545f4846d 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -723,6 +723,7 @@ config AXIADO_SOC
     select AXIADO_CLK
     select CADENCE_GPIO
     select AXIADO_SDHCI
+    select AXIADO_HCP
     select UNIMP
 
 config AXIADO_EVK
diff --git a/hw/arm/ax3000-soc.c b/hw/arm/ax3000-soc.c
index ebe174fb97..9c3137af2a 100644
--- a/hw/arm/ax3000-soc.c
+++ b/hw/arm/ax3000-soc.c
@@ -41,6 +41,10 @@ static void ax3000_init(Object *obj)
         g_autofree char *name = g_strdup_printf("gpio%d", i);
         object_initialize_child(obj, name, &s->gpio[i], TYPE_CADENCE_GPIO);
     }
+
+
+    object_initialize_child(obj, "hcp", &s->hcp, TYPE_AXIADO_HCP);
+
 }
 
 static void ax3000_realize(DeviceState *dev, Error **errp)
@@ -49,6 +53,7 @@ static void ax3000_realize(DeviceState *dev, Error **errp)
     Ax3000SoCClass *sc = AX3000_SOC_GET_CLASS(s);
     SysBusDevice *gic_sbd = SYS_BUS_DEVICE(&s->gic);
     DeviceState *gic_dev = DEVICE(&s->gic);
+    SysBusDevice *hcp_sbd = SYS_BUS_DEVICE(&s->hcp);
     QList *redist_region_count;
     SysBusDevice *sdhci0_sbd;
     DeviceState *card;
@@ -217,6 +222,24 @@ static void ax3000_realize(DeviceState *dev, Error **errp)
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio[i]), 0,
                            qdev_get_gpio_in(gic_dev, gpio_table[i].irq));
     }
+
+    /* HCP */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->hcp), errp)) {
+        return;
+    }
+
+    sysbus_mmio_map(hcp_sbd, 0, AX3000_HCP_EIP197_BASE);
+
+    sysbus_mmio_map(hcp_sbd, 1, AX3000_HCP_SHIM_BASE);
+
+    sysbus_mmio_map(hcp_sbd, 2, AX3000_HCP_PHY_CSR_BASE);
+
+    for (int i = 0; i < HCP_NUM_IRQS; i++) {
+        sysbus_connect_irq(hcp_sbd, i,
+                           qdev_get_gpio_in(gic_dev,
+                                            AX3000_HCP_IRQ_BASE + i));
+    }
+
 }
 
 static void ax3000_class_init(ObjectClass *oc, const void *data)
diff --git a/include/hw/arm/ax3000-soc.h b/include/hw/arm/ax3000-soc.h
index 344fcb6f3c..187c1e02ad 100644
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
@@ -93,6 +99,14 @@ enum Ax3000Irqs {
     AX3000_GPIO5_IRQ    = 188,
     AX3000_GPIO6_IRQ    = 189,
     AX3000_GPIO7_IRQ    = 190,
+
+    /*
+     * HCP IRQ base — 10 contiguous SPIs :
+     *   +0       = EIP-197 global
+     *   +1..+4   = ring interfaces (4)
+     *   +5..+9   = MAC IRQs (5)
+     */
+    AX3000_HCP_IRQ_BASE = 0,
 };
 
 #endif /* AXIADO_AX3000_H */
-- 
2.34.1


