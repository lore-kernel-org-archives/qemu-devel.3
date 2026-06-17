Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BF10CD98F3
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 08:56:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZm3q-0002S9-MW; Wed, 17 Jun 2026 04:55:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wZm3o-0002RZ-Kz
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 04:55:48 -0400
Received: from mail-centralusazon11020141.outbound.protection.outlook.com
 ([52.101.61.141] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wZm3m-0005fM-Lg
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 04:55:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lzsa93CZbCgrySrCZA6cW8KrtvQQntoz2007oNbj+nZigPQmLdxSoTh/VUSytXigiHzWlOXenRTxkn3KzeEcAMAAWCorbFyo5/2JwP/d0AroBzw/HlQuo4uQv5hLA9Og9H3FNdY0EOCqAMT93VfkQdjEbbsPvzCwqRLfyInM1q532QeDYaEuhWHrCUJ59VE/9VbZ+SMfth+Lf020bmLLXnqWRRUXDil4oAZKYbWB1Ms/F+iDzzJ8cIlMlgEPCn57x8EpnCJZ8WCGaX2Wc1RNkHR2jCOEEhDBdJir3U5vfg3HiXrhlJdnoqQMUlH4jeeFwswI45XE7tY8g+GPqTvq0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q58+k2z7M1Jtrf+JCqem5Y3F+Nj0q2Qzq3DTpXQdgjM=;
 b=dluxCHEYQpBRJRHEo8sxdX/EUdsKxpOHR/OJGNnHrUzryc/OzbwALxoXGhX30beA9HNDKm2zuNoA90Os5Wz6ljjn0qy7iSwnZ2qIkIzq2dytk7xNYQtKQCoNx49LaD47PVgjGyiXyytdXzXsCEdD8DHfVCtaxlQpYqYGrON5FsZexyz0qdQ0Ck/jQoqfwaq8mgAY+u8D0EPpo1hnaiKXGprZFsVyWwrux24Y0iEtMBHyvQ2L1tM8QG1Z1YlyXXragZ0ANpIWmnNbrDZdcT0E6WWmlqe/OQcD6XVFV9ONxKcByXbRTsXIFHTDVxlW46FUl7wSoeEi0UdBi/jidjmFlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q58+k2z7M1Jtrf+JCqem5Y3F+Nj0q2Qzq3DTpXQdgjM=;
 b=e4ksDEPomi7WHxDTM97Eozz3E4NYyBwuFJqd0JxaeQzyO8Dzr8oVoFkTE2KYEy0lqXXM7iDfKrOiNEP0RtsMHcnsJiFTMJXM3sYAlsBKaWGfzBX5Hcok4mlaQo/9/DaCdorQOZZmd98u0w52ezkR9WEDE9vAqD67jQzUZxmxWme+JY0wSVDKwBSDxbZAegiGl31wgwr3YlXhWyt2mHrAWuZTaLUVC3aw61kQxXMiDiyOs4hXpJh2j2CzUFU/dEM9GuTg2RFhFnjHP/Aur1zKt/R30ZAN+R2dc8Co+xFGb62xUQlAdIVurt9EplGkUonSzePRmfdA2qFnxF6n/sID5A==
Received: from SJ0PR03CA0026.namprd03.prod.outlook.com (2603:10b6:a03:33a::31)
 by BL1PPF97DE7431C.namprd18.prod.outlook.com
 (2603:10b6:20f:fc04::dac) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 08:50:39 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::c) by SJ0PR03CA0026.outlook.office365.com
 (2603:10b6:a03:33a::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Wed,
 17 Jun 2026 08:50:39 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.8
 via Frontend Transport; Wed, 17 Jun 2026 08:50:38 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id CBFBF4186B5B;
 Wed, 17 Jun 2026 01:47:59 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v4 2/6] hw/sd: Add Axiado SD host controller with eMMC PHY
Date: Wed, 17 Jun 2026 01:50:24 -0700
Message-Id: <20260617085030.2586072-3-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260617085030.2586072-1-kchiu@axiado.com>
References: <20260617085030.2586072-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|BL1PPF97DE7431C:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 700352e3-da71-4796-0caf-08decc4d8171
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: TEei8FFwc48HqjTqS6Ldg8y0nmSA1uNdU+21wFG9eIlVaLzaxReu4oO8xwyO+WWuonIszCqI/5kgo5vPFPAPVZyQoiAj/92dRE2dfaS6fqgSepu0l6IuwqjlY31RGxIqAgvx8oapnnW5INiwc+LK5kUgpV+RdfK5A6zzCj7sPZvbPG9qSOYWRH1NsJGC3ASBWiMhuglLmtBRpr6dppUz7jrqg9jzxZu/IgaBVfckT6Hs//XBSRND5dw7tQQfBjIGUuVRqHlUnLoVucdBW27qIzTaGQHQg86thFSW066Mx9p5C2AbGlgq6ydH5sW8orPKHOYFc2OMcfm2qofxBRgh+F7OHSPZ+dFTax2Xm/CktmdKZU3h5SMJBRexB2pP16dPhV9QM2IYr1h9XuKRh/8/oiENHtIpWW5awvv2t03JFMc3IeozpV6PRGStlQ+Q7LNGsZPcl8JGbyx52alZ8xdB3uAWmy89TIfbDeBnwL75kbk0qItOXvXO2S4Q95NEiDzrzer6bU+M/JMtn3igQ9B2nPfX+unPjBBqbND2baMQrvbAKOIK7ETVEYgLKKfjop+JEaA7X223N7Xey/sQAUpvO53tt4S72emiMyBnfOKfQ54WnuUpfNC38+kyoiPqKn63cHEtAU3z4cS44rQ5S2tcn8j7rbObjICh945BEkw6IL7aEMs5erZFbiphU38H+qqSGFbRppNvySklX3sTKVTN2OJNBHuGRWhjmzlDbByp4BU=
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yWRd2qSQ3rLbwvDFSekU2ZsXQLsxRTCfDcDcLxL4uNwh7O8pKM1ycFY2Ot3sEskFLm/CzhQCXPWfXNlbXz0G0DGarhCDIBTFs/mnbZ3C1r98BmUt6DvcQcemEv2XHDZWdZUL4Fzdzz015HeihDUcyxQG+3EIHhLqCWgAgKRH31M8dqTE3XMzi0DmbvS8x1Jv9qgo3i595OFmXBM8UvvMJB5kscWON2C4YLv4UG/3H66DNzpowdqIZ4y/VTZbeDuziyRtMd1+SPpMBSyxSamOegVw2djljDY5Vv2kQPLxeqOQFyIkAUhu+yxZUOOCu6xTGG7h5CYqibOxhBUYvTLB1bPc51lVJOvMO5ZVpEfA5+Wv1OLik/LJlQqGp6dOEYFdifSRzvzTFKlT6rpbkgZtULoAmVP9Fk7RimquAmpom0f1/pa69ifASlgoiPT5nHZy
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:50:38.8956 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 700352e3-da71-4796-0caf-08decc4d8171
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PPF97DE7431C
Received-SPF: pass client-ip=52.101.61.141; envelope-from=kchiu@axiado.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

This patch add a new model for Axiado SD host controller which is compatible
with SDHCI 3.0 spec

This device model also includes a eMMC PHY which helps to control SD/eMMC

Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
---
 MAINTAINERS                  |   2 +
 hw/sd/Kconfig                |   4 ++
 hw/sd/axiado_sdhci.c         | 114 +++++++++++++++++++++++++++++++++++
 hw/sd/meson.build            |   1 +
 include/hw/sd/axiado_sdhci.h |  21 +++++++
 5 files changed, 142 insertions(+)
 create mode 100644 hw/sd/axiado_sdhci.c
 create mode 100644 include/hw/sd/axiado_sdhci.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 340428cda55..0c112890818 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1299,7 +1299,9 @@ M: Kuan-Jui Chiu <kchiu@axiado.com>
 L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/arm/ax3000*.c
+F: hw/*/axiado*.c
 F: include/hw/arm/ax3000*.h
+F: include/hw/*/axiado*.h
 
 AVR Machines
 -------------
diff --git a/hw/sd/Kconfig b/hw/sd/Kconfig
index 633b9afec91..c69bf24f8de 100644
--- a/hw/sd/Kconfig
+++ b/hw/sd/Kconfig
@@ -23,3 +23,7 @@ config SDHCI_PCI
 config CADENCE_SDHCI
     bool
     select SDHCI
+
+config AXIADO_SDHCI
+    bool
+    select SDHCI
diff --git a/hw/sd/axiado_sdhci.c b/hw/sd/axiado_sdhci.c
new file mode 100644
index 00000000000..e1a76b80a67
--- /dev/null
+++ b/hw/sd/axiado_sdhci.c
@@ -0,0 +1,114 @@
+/*
+ * Axiado SD Host Controller
+ *
+ * Author: Kuan-Jui Chiu <kchiu@axiado.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/sd/axiado_sdhci.h"
+#include "sdhci-internal.h"
+#include "qapi/error.h"
+#include "hw/core/qdev-properties.h"
+
+#define EMMC_PHY_ID     0x00
+#define EMMC_PHY_STATUS 0x50
+
+#define DLL_RDY  (1u << 0)
+#define CAL_DONE (1u << 6)
+
+static uint64_t emmc_phy_read(void *opaque, hwaddr offset, unsigned size)
+{
+    uint32_t val = 0x00;
+
+    switch (offset) {
+    case EMMC_PHY_ID:
+        val = 0x3dff6870;
+        break;
+    case EMMC_PHY_STATUS:
+        val = DLL_RDY | CAL_DONE;
+        break;
+    default:
+        break;
+    }
+
+    return val;
+}
+
+static void emmc_phy_write(void *opaque, hwaddr offset, uint64_t value,
+                           unsigned size)
+{
+}
+
+static const MemoryRegionOps emmc_phy_ops = {
+    .read = emmc_phy_read,
+    .write = emmc_phy_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 2,
+        .max_access_size = 4,
+    },
+    .valid = {
+        .min_access_size = 2,
+        .max_access_size = 4,
+    }
+};
+
+static void axiado_sdhci_realize(DeviceState *dev, Error **errp)
+{
+    AxiadoSDHCIState *s = AXIADO_SDHCI(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    SysBusDevice *sdhci_sbd;
+
+    qdev_prop_set_uint64(DEVICE(&s->sdhci), "capareg", 0x216737eed0b0);
+    qdev_prop_set_uint64(DEVICE(&s->sdhci), "sd-spec-version", 3);
+
+    sdhci_sbd = SYS_BUS_DEVICE(&s->sdhci);
+    if (!sysbus_realize(sdhci_sbd, errp)) {
+        return;
+    }
+
+    sysbus_init_mmio(sbd, sysbus_mmio_get_region(sdhci_sbd, 0));
+
+    /* Propagate IRQ from SDHCI and SD bus  */
+    sysbus_pass_irq(sbd, sdhci_sbd);
+    s->sd_bus = qdev_get_child_bus(DEVICE(sdhci_sbd), "sd-bus");
+
+    /* Initialize eMMC PHY MMIO */
+    memory_region_init_io(&s->emmc_phy, OBJECT(s), &emmc_phy_ops, s,
+                          "axiado.emmc-phy", 0x1000);
+
+    sysbus_init_mmio(sbd, &s->emmc_phy);
+}
+
+static void axiado_sdhci_instance_init(Object *obj)
+{
+    AxiadoSDHCIState *s = AXIADO_SDHCI(obj);
+
+    object_initialize_child(OBJECT(s), "sdhci", &s->sdhci,
+                            TYPE_SYSBUS_SDHCI);
+}
+
+static void axiado_sdhci_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = axiado_sdhci_realize;
+    dc->desc = "Axiado SD Host Controller with eMMC PHY";
+}
+
+static const TypeInfo axiado_sdhci_info = {
+    .name          = TYPE_AXIADO_SDHCI,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(AxiadoSDHCIState),
+    .instance_init = axiado_sdhci_instance_init,
+    .class_init    = axiado_sdhci_class_init,
+};
+
+static void axiado_sdhci_register_types(void)
+{
+    type_register_static(&axiado_sdhci_info);
+}
+
+type_init(axiado_sdhci_register_types);
diff --git a/hw/sd/meson.build b/hw/sd/meson.build
index b43d45bc564..ebf09e30a48 100644
--- a/hw/sd/meson.build
+++ b/hw/sd/meson.build
@@ -10,3 +10,4 @@ system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_sdhci.c'))
 system_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-sdhost.c'))
 system_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_sdhci.c'))
 system_ss.add(when: 'CONFIG_CADENCE_SDHCI', if_true: files('cadence_sdhci.c'))
+system_ss.add(when: 'CONFIG_AXIADO_SDHCI', if_true: files('axiado_sdhci.c'))
diff --git a/include/hw/sd/axiado_sdhci.h b/include/hw/sd/axiado_sdhci.h
new file mode 100644
index 00000000000..85afebad931
--- /dev/null
+++ b/include/hw/sd/axiado_sdhci.h
@@ -0,0 +1,21 @@
+/*
+ * Axiado SD Host Controller
+ *
+ * Author: Kuan-Jui Chiu <kchiu@axiado.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "hw/sd/sdhci.h"
+#include "qom/object.h"
+
+#define TYPE_AXIADO_SDHCI "axiado-sdhci"
+OBJECT_DECLARE_SIMPLE_TYPE(AxiadoSDHCIState, AXIADO_SDHCI)
+
+typedef struct AxiadoSDHCIState {
+    SysBusDevice parent;
+
+    SDHCIState sdhci;
+    MemoryRegion emmc_phy;
+    BusState *sd_bus;
+} AxiadoSDHCIState;
-- 
2.34.1


