Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70A9FCDB46B
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 06:08:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbXnR-000536-VU; Mon, 22 Jun 2026 02:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wbXmp-0004rC-F0
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 02:05:36 -0400
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wbXmn-0006dJ-7k
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 02:05:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tBQ1H+ikYrgEUi6IyuDMVqyV94qfN/m9TLMW/+QedI7ugmqXwMaDHI1zWxoWeoRjpjNzpXufART/B0sIrqOI8xd/smPHVzw4/5nQylkF6s431SCKtyntdxc9o4ttYbvoMfm2MgjY5sy9l5NqzO7PK2DexHkmE5kHnyAOLTfgRp8WrfC/vZTwYlA7/atGviDE6PYR3l9If+vbn3lFI0b5Q416Ro4QQVCooBdNZ8tHiFL1GBV6SuhiD0fQE1JGsjMH0FNF9XB0X/hl9chUTyXfN61q/jTUVDybFdYv70IfSL+sAEd1Bn1emfSgi84NfXvaB/zS17QmZnE0/aFhzEqfMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1EbES+qilksBHZ2iigsdfMQjchFsfS753R4MTSe1WFs=;
 b=k/JybAZTo04XRbyNCjjL2C7KSbi2dUx9LxXadZV0gfNThf2CysSxHtb4K5dF4wSCZSyshLsy1mnAVGPbAvFU969m/NGwmDb/9s7pEbNK6XIL2kdMAZqjL9K9Klj7uthKMcTceui4eNP/sejN7jyIDuGygAzPiPGB0aqTiulLF9hEraNHEZOHB4Qc1z5EY3Sm6UlLo7L4TQho3FpU6XhU4YJJhXN58UIuPU/7fkDy3fHBCwnPyxNmvWBbtprNYxfj6EVvOhC1MWKOyrgaeTRCOrOuNDRIQ8/WpTthup+hYNT+dOWb5soiThfbkYV9KZWMS/kfALnSc8rMb/+WDeUtHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1EbES+qilksBHZ2iigsdfMQjchFsfS753R4MTSe1WFs=;
 b=tV7ag5n6mNw4ar2JJAImehm23ilRE7mpnmwV6/D86PQ0qRx3VblLOyEwC//a2RTONA+uTeJqfKuE3zuU3nyFyQ/sHwQ3xPg+QjsnPQJwfrdVU1TZ2l/PBKWqyRrydmcsZoQ97Zqtp9wZdQ4fabwRT8UFjM0GQfamSSGwyFNbBnvPvn++UiRU8L9bkJ8mASVm3u24u59Dxa9tAGXSlcVJ98KkofKNnKkTD5SqkeMtLOce/BVhk0s6CvCcR1AKByva+aMiHyGRRAwvYYv4KY7eKIfpqCXpflgITZFsyQjD5KnpJMd00H8S/jx2awAp+L/E84cXwqFgkrHvXEEb6plI9w==
Received: from BN9PR03CA0794.namprd03.prod.outlook.com (2603:10b6:408:13f::19)
 by CH3PR18MB5672.namprd18.prod.outlook.com (2603:10b6:610:197::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 06:05:12 +0000
Received: from BN3PEPF0000B06D.namprd21.prod.outlook.com
 (2603:10b6:408:13f:cafe::4c) by BN9PR03CA0794.outlook.office365.com
 (2603:10b6:408:13f::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.19 via Frontend Transport; Mon,
 22 Jun 2026 06:05:12 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BN3PEPF0000B06D.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.0
 via Frontend Transport; Mon, 22 Jun 2026 06:05:11 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 5FD934186B5B;
 Sun, 21 Jun 2026 23:02:27 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org, philmd@oss.qualcomm.com
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v6 2/8] hw/misc: Add AX3000 clock control
Date: Sun, 21 Jun 2026 23:05:00 -0700
Message-Id: <20260622060507.83195-3-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622060507.83195-1-kchiu@axiado.com>
References: <20260622060507.83195-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06D:EE_|CH3PR18MB5672:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 955c82af-f800-4b97-d31d-08ded02438a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: TwfT3y4dYmnUao70Zq2i8Yw0stL/iKeUinPq+xcB1Y8rJW6zCe5WyHMxaFJwNSuk7jwPIik3lBzSdFaml9aB8QzW9u/RU+qlhqG8Z9rdESpwHXQ064rBwv2IvJaTkLvSLjcruvcAowdIQ9cMji9jZgIsWRXJF1yZTOgg0cvVosLf99CEr6hgCuvfejnAIKaao7AqPO8K+h49e6OW5HMpyTJxU5xlR8gW8a/7Tgp+g2fv5Tevzp9HVfXmi8K4JFIBBiiog5sesvoA8PRWlkGizZHrvUrljHcoy9PC356KdXMTXuM8DflmkOzgnB2jI0aU3uKVIA2rW+oDtKPLNOkdC453SOZTA6HgXCvMni1hM+bYHz4voS/SOzrXFfFi429QURQf/QRaMmeFI3kt4HPPannDp3aMlO6WpCzaaB/4Uot/w3jB8fParb6lctZbrXUd+qE2zuUWEW4sEFOM/d0RYIrihgTlHbORS5ph13a2oSLAphrL3wNT0Si+2qOMoGKHg45vp4uSWbqn578chvYsb4Xvg9VLPEGtzL3ie/fUgnmgIBMleRQhlJ+O2/XyCuJqEUSaQ4dZTyKJe4Phb0ifeZzBlVa6bSvuymHIWLSbYkVZhtnW4b37YsL87x7Dg7pCcY6wDpYkX18j5hE75+Ev5wCjFjAtI1WBe8m2k0opFvynr9PBJj1aogpsuRz1RuJ+rn6kXD2LCD25750z6JuCaQ==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xNUpulHLV91+wBlLTlTncqZOlE9jkx5YltrXUVprB4O55LhaCXXZPJlXvvUHij+cabsjDkXdL/yQRyDryMatbYkXIDdRV3l92wV6hYxhd3GELUNLV2BR0oCHsitBwnbuaqtEQ/p78sDYs4f7DuIHnmIex7ELqKHJO70dDH6vpmY4ZCMgCFqyNLVEetTICSiwxGoEGb+ahorLh5cvYCHLeEg/djknENwnt2rkST6qyrLq+nUMx83cufLlshl8JpIPkgqPrZbg1mZUDbPKH5bLfXQecD6BrT8DwqnJg49jPizsgxxOCcqlWMKWem2KoW5SF3guGGKvV7PAJN1fzEmcJe8RYN/ez/ysYZisNKBReYHf5Gthus0Jm5Dfgz27X0e2IFpyczFdY47d8IOaPwZ5t9Vcq97ZCt7RlDvgSYwl/0yjd9gtxTq5Zt9YdHrWOiSa
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 06:05:11.8967 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 955c82af-f800-4b97-d31d-08ded02438a1
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR18MB5672
Received-SPF: pass client-ip=2a01:111:f403:c007::2;
 envelope-from=kchiu@axiado.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
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
index 1543ee66531..b8860dd3e77 100644
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
index 00000000000..10b8012a674
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
index 23265f6035b..e86d9ad6b39 100644
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
index 00000000000..6e12a509d72
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


