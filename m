Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B9DECD98F6
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 06:07:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbXnU-00054s-9k; Mon, 22 Jun 2026 02:06:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wbXn4-0004xq-Og
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 02:05:53 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wbXms-0006bi-2q
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 02:05:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mxf7m0wc9aFlhDtDvN2ocO+8cCvcLZQEORzacN3ZtKPXSSeeTZHi2suLZ8tgL+4HCjhFvnniaj6RwlQW+J8EjLdV5eR9VKsDk9RbIBloZOVBZg2oVjnY7FdYv6ycwgdl+g41tz0eW8TuR0RKPvDMH3BO5j3Jbu6jTQP/YBBokoQshqpIt14qSMM3wsTlEKnChF8iRhxJt4faZUxKvEiXpLFD7x3NMPPNHPWUsLSdv3jz0s5ol+5fvOzDfhhx/AwuPHfUcc2pmgILXQ05B/SA57yVKLUy5sUbFtX7E2NYMVxIBeSFk863fOkePr//5OzxTBjBhW5no0EM3uEvS+YpNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6PBDZgfzLGn1ta6uCVBm8jtTlzdblSGuaK/QZH1XYU=;
 b=l2CElkewFRkDcDQuz6CJ2ILe1eJzUe9d1rAcuqsc3/i7b8DAyR6BPS8Lu0sNIebOnk75gx3OG++9hlnlFZBvDi6M5+bPc4bXweUA9PJcbvnBhLNAPqG1BCgKwZHQ4/Y67y6UtD6TPvM1V5/fBKtukjdOa4kQzT4oT8VhjkLoQm8OJ+M/wx5AdyvFGkkL64PjxDRrN3YgDianW7AhxAhiqcQDQivO6DgcPL7k8LH+JX3zYzfHhSekHXIJOI+5K4HenM6qPNIvnx4g+eLlT0SO92/mPvQEtZ0NwfY9IKGndglNY8thoP5QyRD2FNke1/5Ih2hpbRWeIQAFNUmA+A8JNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6PBDZgfzLGn1ta6uCVBm8jtTlzdblSGuaK/QZH1XYU=;
 b=JndM7k+buHIaf/k8k4etYzeaiW5aD9yXEnEtAYwHjiOjGL6GAKa0a+X1hklNN7jITGCPXn3NG2y9Ix8TA+G2s5jHjgosaDLabtBMvPFxL+pZEiDoJ6T+d33d2Y7BxrLhJcXqqUhapXQOMF9ZLhUZ/x5TUuysU/yiHKoIHnHhINs5RG6dznaIjRtzZsHv0TrXeJQllqHvFVJlaOmWGNSpBvfr4efINchOeah1cXhd3Aicm6PFGuAPatF6u0u+P9kvF3rumbuTuQTFsQsUzi6ywUKvdB5kRJ+oMUrLIYilm4vdJiPYwZX1dhrlAJ/+FKvHxGHUCWQcGnimXIV70pT0xQ==
Received: from SA0PR12CA0019.namprd12.prod.outlook.com (2603:10b6:806:6f::24)
 by CH0PR18MB4244.namprd18.prod.outlook.com (2603:10b6:610:bb::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 06:05:12 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:6f:cafe::71) by SA0PR12CA0019.outlook.office365.com
 (2603:10b6:806:6f::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Mon,
 22 Jun 2026 06:05:12 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.10
 via Frontend Transport; Mon, 22 Jun 2026 06:05:11 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 8A15940BFE07;
 Sun, 21 Jun 2026 23:02:27 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org, philmd@oss.qualcomm.com
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v6 4/8] hw/sd: Add Axiado SD host controller with eMMC PHY
Date: Sun, 21 Jun 2026 23:05:02 -0700
Message-Id: <20260622060507.83195-5-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622060507.83195-1-kchiu@axiado.com>
References: <20260622060507.83195-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|CH0PR18MB4244:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 73cbb248-1db0-438f-5874-08ded024387c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: rMGFlUeuPIRqDBrLvgwWM2JmjwRU35W0ca3Zoqb7+Cf22/iOY0ytiyxDpPl3ywWMD0e/XC/S/UAetmYFPVQRON/vayfu2nFh29EQuUa3kuHWo7J+5F9VQ7MbIeKrkdUZru1C1DLrFsldkF7s1p2K7QdEmaJzr+zr8TLZfyCAnE1G6x/yoDN3168Vu/LCa5+TIwviexO3QRK14rG9X27SOOTRsRivbOFGgbvXFelghWbHxRCiWE35svFVDDxRfUGMxABMWgNzOWCWG5V9UeFKm6XOie2qf/cdTcYtpT0TplVzuM14IMCpsM0l+/NUNGVry4f3prQvuhZnuTr4eI9U9lXFAQIvA9TCGHydnE3xOXwL7+JCwuwiP2ZW114bGwXDh1kUd1X7/8Qy3d7Jmplb/MpPKCH0P/5hiaXkqS6vyA5rZpdpKr3aArSVKDtNVbxeOIODsEs361mGK0bXQAAKyMiQ6mS7brcCx/+rSsg6+s84k/jM1snt9JAsupJkaLC6ygJdGwVD/iDOPC5pucWAKERWPDd4qRC7XcO8X33Z/HvBRhYNlhd7Ng1P+EZk9Q6ECdcX293km04yMObvQpbO3l+i9H9X5V47MXXx3HWascwnwaGeCj3Obe+rxqCVNvN3bnIUn9xABCjSvLF9aKyXMFWpCYh8eXoses+G9vNcYLcnX4gpR2UZecMSYEQMEmG6PlJ71BAt//RnMrtl20S57A==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vPgj/bCTwOQ2eza/J5KK+8Vtvp9XEyFlrejtV7k5Rkcw4a/ci9l1AXS4SubXS8TS1DMvLS01HeDQDhm8NNqwHdcdnPNNKVxE7KfZPjNoUP7XEgDPOwDJ8EKrMnoxTMMhtlC6x9Gd5KCPS0hvlE6y7AoiTNMBgCJePj5Q8zTMhezJb8hHxSOP5aq4MTQ6l2/wdjgDqDGFxGEybPP2zb2f+X7JJlKcabTvbfbLuL105EZ5SFkwV+TY31RCBHmB1l75zHulpZn57PE+pRkh9c2gqm+eQDH5WyZwPnSp+NrRmf+re+duS2GDP4D3R9yg0rpWhLftWCyEAryGq+sNn6ZAu6zvGcmflA+PweWnEihlB48K12ETD6yWz/iI5K29AVTdnJ3ZqUjPBIEJq+09R5rUNpvAzla9IBnONnelEnuc+yD87zQbBOcd3R81m5H6FqlG
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 06:05:11.7007 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73cbb248-1db0-438f-5874-08ded024387c
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR18MB4244
Received-SPF: pass client-ip=2a01:111:f403:c107::9;
 envelope-from=kchiu@axiado.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS                  |   2 +
 hw/sd/Kconfig                |   4 ++
 hw/sd/axiado_sdhci.c         | 117 +++++++++++++++++++++++++++++++++++
 hw/sd/meson.build            |   1 +
 include/hw/sd/axiado_sdhci.h |  21 +++++++
 5 files changed, 145 insertions(+)
 create mode 100644 hw/sd/axiado_sdhci.c
 create mode 100644 include/hw/sd/axiado_sdhci.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 9707a71137b..f3a3034f27b 100644
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
index 00000000000..94c2e044097
--- /dev/null
+++ b/hw/sd/axiado_sdhci.c
@@ -0,0 +1,117 @@
+/*
+ * Axiado SD Host Controller with embedded PHY
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
+#include "qemu/log.h"
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
+        qemu_log_mask(LOG_UNIMP, "Register 0x%lx not implemented\n", offset);
+        break;
+    }
+
+    return val;
+}
+
+static void emmc_phy_write(void *opaque, hwaddr offset, uint64_t value,
+                           unsigned size)
+{
+    qemu_log_mask(LOG_UNIMP, "Register 0x%lx not implemented\n", offset);
+}
+
+static const MemoryRegionOps emmc_phy_ops = {
+    .read = emmc_phy_read,
+    .write = emmc_phy_write,
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


