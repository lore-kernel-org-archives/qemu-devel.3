Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83768C44506
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:37:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjBD6-0006IW-Lv; Mon, 13 Jul 2026 03:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wjBD1-0006HL-H4
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 03:36:13 -0400
Received: from mail-westus3azon11020104.outbound.protection.outlook.com
 ([52.101.201.104] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wjBCz-0002vX-PN
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 03:36:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A15VVPCGtkwy65SziaORwSj9+JSAUOEAdeaFIEkR9CaNE2umxSu1QC6e05lZRxKOyZ/6nNvxjO4R/qquy4Wc3diOnvmlotqP+Og17Uyu9ow3BqnTVkQF08EgPnIxSRzhXM2Gmc+UJGC7n1wMhnlQ9CtIABhjmJl1R/0/vOxe57yxR+BID1sgrWAMSQIu09wPhLbJN99M1YiyIuEW2M3MtGXuzW70rfT8dAltW6Qly2JfH/P89zaITkMhqtSl6y0nLJwryfT14yBjSKVWFPv54qJr1kLnw8jMswjK0Dcba1RZQwdH8TQ1kaEPFUIRHM8FNMy5eTW42eC37BuIJVhnvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Biw3weI2o7XaW2DPStwY51IQP6zmyds1jdOfjWoHVpo=;
 b=j6+USlOUI27aWtcmLdGxmIQYiXgpHXYt3OPUKYLvPkj/9dS4RApLZeeAs8w9YBntz0SrXrsMLfplaiYYU4pv08MB7N6vHSfzhfqvwFIgmQwSpHTpIJy9C5wQhnDo8mgLYvalV1TllsqPyQlqEXJUvMZ6KPdgYazvJh3SLbglrwuW69CVuVSsR6MaFc5eQvmzgPh6x71N2erd8kIVU1YKJJpahCsMnSovrN+Ww95tTR4wsqtW167qzzB7EtqX4cRUhx0A8o9LStv2dzE3uNCm10w186/u76DG9CdS5O7ZuuPjr6G29+n3GveDxeuxMAHL2BU/472o4W29CD2G8Fetwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Biw3weI2o7XaW2DPStwY51IQP6zmyds1jdOfjWoHVpo=;
 b=VFMWdjNC3RkzImIFR0l5qG9N3yzs9eEsh/zu3u67MfB7l20I4rQ8sp5/60uyeB9GJAseqINYZUv8i3GWEl0lQPMDOSgKWVAyTXPUTUQHCHjL6C2A8c3D33g8EdLCCg2GDJ4GSZuYtqzdT4n5bowfD51LM2Bra5aBZ1N3loLFXVoUatnqN3nFhYVpzpbMI5H3ZN1iCzFdOybS9uGkji6tFXv6V1SbNlM9GtXfTdxWW+2URIt01krQVF8xQs+gkoWY15hhgmPc3f0O0TC7lvikU7CMNE9N+B5zR39PJCnx0nBxoCYDb8k2/rSGYaatImqJseviUlavOrvvcukolbpHqQ==
Received: from BY5PR03CA0023.namprd03.prod.outlook.com (2603:10b6:a03:1e0::33)
 by CH0PR18MB4289.namprd18.prod.outlook.com (2603:10b6:610:b9::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 07:30:59 +0000
Received: from BY1PEPF0001AE1C.namprd04.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::28) by BY5PR03CA0023.outlook.office365.com
 (2603:10b6:a03:1e0::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.18 via Frontend Transport; Mon,
 13 Jul 2026 07:30:59 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BY1PEPF0001AE1C.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.9
 via Frontend Transport; Mon, 13 Jul 2026 07:30:59 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 190124186B59;
 Mon, 13 Jul 2026 00:30:59 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org, philmd@oss.qualcomm.com
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v7 2/8] hw/misc: Add AX3000 clock control
Date: Mon, 13 Jul 2026 00:30:27 -0700
Message-Id: <20260713073033.3883619-3-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260713073033.3883619-1-kchiu@axiado.com>
References: <20260713073033.3883619-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1C:EE_|CH0PR18MB4289:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 74b9cce5-d16f-4584-7f40-08dee0b0af5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|23010399003|82310400026|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: OIF2X0cNbBIu3ju0pQymxIps0N4Iw6sRAc1vxZ2ZUNajrihKix2Iqr0loWYaq+DQpOQby4x2ro+c8F/V2J4tznhj9Yl98lH2ixeKlwbGv+fC0Q4J2mr2MInI9UxO8y+y1smDxHRyphgKFMXo0UNJzA30qI44aF/5YH3P7j4zBqikU2Q6LCa7k0MHFZDkxv4vnJm+XjEVDYPrhdh9r1DG7YK2bSLRWNAxSzdQTRR+krzI/Uu5cccW7/X6RAe0hLzWuQ0SrQXH+HmuK2pRB8/gXlvVmvGNmq5IblR7+ZhQWxGofqvS/X9OZ15eITM3kG8yZ50UvcW1Xhpp9pu8urb9zIjuNM4r8EfUDXpcJdkHsTIrx7pkauJPpDQPxzTsT184gcm9mR9Wi3+T8K2ItJnzQedb02XkzchzqhlYpitBPGEV1CvjxqRo7L8kPhXURrXJe4+mgsLnJj+XFJRQNtSc0/Mi5MH5v6IN2eQ0ngs1OqXa7bGu69srIphcoDiChC0WJ9BGOU4M2P5jgb/vv2hGyHDYfXv0E1r6M9GDf57Kcc+dO+US+hvR8oThrZkN5NdmME194SFJrUW01jQReV4TLshhsyRlbAUasVLTFVAgZQMTxwdPiQ4qewP+0oNf34tW7v7xo/sqeXSbNUuR0wc7iFvmmlArYCy63d/JU4pEiHaAAQpekyHWqq4zHmv7JN8dAh3jq6NvU3H9aapVplIXOw==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4sNRI1STDUSSmX+M0rl29Pdyw/T4ytjKe2Ee55NCzNuFQp+WcXIdS513xrpvA73ZG6c49+d5y2wPDidRHw0e5MBsSbFYTywEPBot5xHy0YAGjjDkAG+qnqSrsxkkkpC7BDctm+p9j3RDjaYuYWfAaQZ1Xacfic/Df+sWeJt4FOSVrSNIi3Vo08Xa6B2a+sP+8FY51X7uGAkWQE9XscpH8J5KLS7J+yuzBhUHk8QxEAn3isV6RfYxnBlFAeUwM5t5lFuKlwn5c2GH2Ff3KvrndX7pC2BkSlSwrSdDo0wXc++HGRGPO4+3Kmd76ITvsM0UR/9zVvCaZuyAsd4pvQSdf/kEFVoklFepgJ2Q98eCoPDbgVWIclk0NfxRIXnaHltpbM7s2kDHSDK+iu/1rJ4nIahnpHb2gWBvWwLODJBR4mUzH/J6Hv/+aUf2O2SObllu
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 07:30:59.3617 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74b9cce5-d16f-4584-7f40-08dee0b0af5b
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR18MB4289
Received-SPF: pass client-ip=52.101.201.104; envelope-from=kchiu@axiado.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
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

This patch adds a new model for Axiado AX3000 clock control which supports
to read ID and status

Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
---
 hw/misc/Kconfig              |  3 ++
 hw/misc/axiado_clk.c         | 77 ++++++++++++++++++++++++++++++++++++
 hw/misc/meson.build          |  3 ++
 include/hw/misc/axiado_clk.h | 26 ++++++++++++
 4 files changed, 109 insertions(+)
 create mode 100644 hw/misc/axiado_clk.c
 create mode 100644 include/hw/misc/axiado_clk.h

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 1543ee6653..b8860dd3e7 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -257,4 +257,7 @@ config XLNX_VERSAL_TRNG
 config XLNX_ZYNQ_DDRC
     bool
 
+config AXIADO_CLK
+    bool
+
 source macio/Kconfig
diff --git a/hw/misc/axiado_clk.c b/hw/misc/axiado_clk.c
new file mode 100644
index 0000000000..10b8012a67
--- /dev/null
+++ b/hw/misc/axiado_clk.c
@@ -0,0 +1,77 @@
+/*
+ * Axiado Clock Control
+ *
+ * Author: Kuan-Jui Chiu <kchiu@axiado.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/misc/axiado_clk.h"
+#include "qemu/log.h"
+
+#define CLKRST_CPU_PLL_POSTDIV_OFFSET   0x0C
+#define CLKRST_CPU_PLL_STS_OFFSET       0x14
+
+static uint64_t pll_read(void *opaque, hwaddr offset, unsigned size)
+{
+    switch (offset) {
+    case CLKRST_CPU_PLL_POSTDIV_OFFSET:
+        return 0x20891b;
+    case CLKRST_CPU_PLL_STS_OFFSET:
+        return 0x01;
+    default:
+        qemu_log_mask(LOG_UNIMP, "Register 0x%lx not implemented\n", offset);
+        break;
+    }
+    return 0x00;
+}
+
+static void pll_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
+{
+    qemu_log_mask(LOG_UNIMP, "Register 0x%lx not implemented\n", offset);
+}
+
+static const MemoryRegionOps pll_ops = {
+    .read = pll_read,
+    .write = pll_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    }
+};
+
+static void ax3000_clk_init(Object *obj)
+{
+    Ax3000ClkState *s = AX3000_CLK(obj);
+
+    memory_region_init_io(&s->pll_ctrl, obj, &pll_ops, s,
+                          TYPE_AX3000_CLK, AX3000_CLK_PLL_CTRL_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->pll_ctrl);
+}
+
+static void ax3000_clk_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->desc = "Axiado AX3000 Clock Control";
+}
+
+static const TypeInfo ax3000_clk_info = {
+    .parent             = TYPE_SYS_BUS_DEVICE,
+    .name               = TYPE_AX3000_CLK,
+    .instance_size      = sizeof(Ax3000ClkState),
+    .instance_init      = ax3000_clk_init,
+    .class_init         = ax3000_clk_class_init,
+};
+
+static void axiado_clk_register_type(void)
+{
+    type_register_static(&ax3000_clk_info);
+}
+type_init(axiado_clk_register_type);
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 23265f6035..e86d9ad6b3 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -1,4 +1,5 @@
 system_ss.add(when: 'CONFIG_APPLESMC', if_true: files('applesmc.c'))
+
 system_ss.add(when: 'CONFIG_EDU', if_true: files('edu.c'))
 system_ss.add(when: 'CONFIG_FW_CFG_DMA', if_true: files('vmcoreinfo.c'))
 system_ss.add(when: 'CONFIG_ISA_DEBUG', if_true: files('debugexit.c'))
@@ -168,3 +169,5 @@ system_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa_ec.c'))
 
 # HPPA devices
 system_ss.add(when: 'CONFIG_LASI', if_true: files('lasi.c'))
+
+system_ss.add(when: 'CONFIG_AXIADO_CLK', if_true: files('axiado_clk.c'))
diff --git a/include/hw/misc/axiado_clk.h b/include/hw/misc/axiado_clk.h
new file mode 100644
index 0000000000..6e12a509d7
--- /dev/null
+++ b/include/hw/misc/axiado_clk.h
@@ -0,0 +1,26 @@
+/*
+ * Axiado AX3000 Clock Control
+ *
+ * Author: Kuan-Jui Chiu <kchiu@axiado.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef AXIADO_AX3000_CLK_H
+#define AXIADO_AX3000_CLK_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_AX3000_CLK "ax3000-clk"
+OBJECT_DECLARE_SIMPLE_TYPE(Ax3000ClkState, AX3000_CLK)
+
+#define AX3000_CLK_PLL_CTRL_SIZE    0x1000
+
+typedef struct Ax3000ClkState {
+    SysBusDevice        parent;
+
+    MemoryRegion        pll_ctrl;
+} Ax3000ClkState;
+
+#endif /* AXIADO_AX3000_CLK_H */
-- 
2.34.1


