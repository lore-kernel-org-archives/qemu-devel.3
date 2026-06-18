Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB5D5CD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 10:14:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa9kO-0005dN-HF; Thu, 18 Jun 2026 06:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wa9kH-0005c7-9A
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 06:13:15 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wa9kF-0006D3-19
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 06:13:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dyXbyaCj19iibIwfB9PYrsAT8pQEAYI73pUKDGiuvncqYNoME7gssEkL/tjWgsG9TltJGXgH0cehguYGlROoTJpFoB5+Hytm51VWAnSl8owYQkG8mg8T1fASHjOkFfF3HMM2Za+8VZy2WnM+9QWA38NpVwVe0lTHVE9oOWJzZZ0Tn0fC2xOd3vHO8z3reCb5pz5Vn0U0xHwv62Hwbm2ZlpBv3N9GbPwho/Fi64e9JofON9k6vCY4W9Xv7qYiPLGZKzPSQEzXZ5bqVlu8cyyu/P8VeKvJ23u323I+0iqVUVcm98Ls+HjiwmYRgE3jCGyNedvIvC6T6F2omSKtRNcnwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V5UMqwes+9OLk6NjQnycuKTc2aB4CYFQMfad4h4Wqt8=;
 b=k6R0K014rrWRZ7oTlAJemdhWkt1+44ZncyCTZNNOvICWviVhElfIfnf5izZsWcbSC+mnOesMEKhZh69CWid8oYs9XexiXXuckjS2V+q5XCHnjuzlC4mX/DB1GcD4+2ipH3JTDr/gy6Xa21pyeIsfVnB92rgFzq2rAvJXQyQiodD0bXF1WnBOjTW7gv+Wifhk5oznmb2FpfHVpjsIqwqrNbIVNMxcVA8f7J5Me5/YYak10oVzUXAHP6qQczOcyo5LyFcNvj5h2fBBzX1Cyk6eMwdUfY/DeJdZVUdUHish4Yzh6cyrLU1ODYVdUY4Berq13t3jJ5mCrTD+E49xQc/qKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5UMqwes+9OLk6NjQnycuKTc2aB4CYFQMfad4h4Wqt8=;
 b=SvOG0Eh61q5H+ih4XhqFj27KPyizhnoA+i5LnCCFzyoaRunRJflOUvtwwMexVz60bl0U2aksnKOFIpvQRFC6heRdzaSSYTRGOD7UZx9Dcgh+Lv7coc2DnbNzwnuaRU+cqc11DcOOk2mP7GHUWFbEnKoV1H0zDfAknxbTC00h9ixiHTvV0doAth+gBiyqYAlu3O/Dd58/rGlp+SBUQ9A8LQEjVkU2hq80DpXATfSqtI4wovnnlqaAB0S15Z/jpvt0HOnOcTo1lvdwmZgwi3aUgordi1D6sWgjOiyAo/Sx/thS9DDbBrafaOd2Jdr7QP4x3+NXDJgXPVlR2Cuzfu4Siw==
Received: from MN2PR15CA0046.namprd15.prod.outlook.com (2603:10b6:208:237::15)
 by SN7PR18MB3981.namprd18.prod.outlook.com (2603:10b6:806:108::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 10:13:04 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:208:237:cafe::53) by MN2PR15CA0046.outlook.office365.com
 (2603:10b6:208:237::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Thu,
 18 Jun 2026 10:13:04 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.8
 via Frontend Transport; Thu, 18 Jun 2026 10:13:03 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 37C3B4186B5B;
 Thu, 18 Jun 2026 03:10:23 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v5 2/8] hw/misc: Add AX3000 clock control
Date: Thu, 18 Jun 2026 03:12:43 -0700
Message-Id: <20260618101249.2926976-3-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260618101249.2926976-1-kchiu@axiado.com>
References: <20260618101249.2926976-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|SN7PR18MB3981:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e0a88d46-fa41-4e65-7322-08decd222f67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|23010399003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: a8QzBs6ZqQMImu9Sy1B3QjRT1fF9VwrS3ZLaBqND7xGoTml2lnkTdxWl7G5NVGEJ7CcmZ4Pj/zgD6YH1sp5gtsa2w1IdYLxJgLKR+xAblsFkGie3IwPYRft/QptCS8hEGzWHJePeblwe7pQ+ufK9SBH25dlq2+E/Ryl3Z+pQqYRe1b89t92fpLam1jMT7LMRj/Uziig+DuUvyarzfZ7btQs1xASqhkVHS1/ofXKk9t46veg0yd/2wXb76kfbNyUCxXLhoRr4AEjFnnWQbkp/8Er6QRzWuA27lzOdsjWNZfyQAZ1Rw5mKQgAXWk93dV9aN5pPqyIkUh8PjdeiFQJTAE7F0+Ai79kDCi1VVtlMmJxYd3/2w1j0CBHhD8rk7rF3jbhmCQv9ChGndpz9M0hpyIWZtSkd4JC7jJPjysz6ngxbynmbkbKCGDqt/EgVYjWyuldoXIqN3kHkU3jLUFpNgcTqqp9eVKJzhjQOJNFPXRMpplFrVnK2Pd0EjKJkWE3ogCXBPw4JMNAhEptybP89CSBYKj9zlJ/ZVQV9iwxwsrhvi+XLYygN9kQWYd3KXX5VCeiuVc7A5ojAuJM2fNEmNxcEyV7RdElJNvkpG8TyC17HhwvTDTfK9xF5C6fx4CRhvWGQbMX5k/vBf9pG2M4AMfyNkZOFgxnAPJY49U+yLp3IK0YB5eUMwnc1Ed1UFRobtQAjMTXXDeQBk+Dytn7Dw+S+tnFxWgJUCMJKGQ6Omi0=
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(23010399003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 80qkHC7oA79oytU0D8wATbKko8oXmG9u7+y9tpdxu89nxT02xwk6F23Zt/v7awOdlyz9urqpmY15QmxuqkppIbZn9V/A/7ORwtxUer6XTR94u16MXQEK2Wyz/AgXm2OfEIZsvmROYDwGfLgyrBESB5YEDMOBepwcO9Nk/du6P2CHAAuHWjo0iA169GmuOnAh/3iLg6dvyrlpgts/ED0jklIjRpAH1JR7l6MmJdEKQuBtDrOP8a4ghoglua6+MVWSTK11iBCeDl51+WfR2O6NlTDDdq1l0ekQUj6zBO4kTN0cUOLzyxnnDhbxfpxd4tK2F6JDKpimYidVdPSWpBYpWwZjGq71YUoAsGHKAx5bGiWQOhbIYB9gc/0pY1ClKzsN8aQW1Agj1OvREFq+NEzA2fk+n5LYPWqfk4fz1rZn0lReWhAurVYPCfh4PkSS3AMM
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 10:13:03.9313 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0a88d46-fa41-4e65-7322-08decd222f67
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR18MB3981
Received-SPF: pass client-ip=2a01:111:f403:c101::7;
 envelope-from=kchiu@axiado.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
 hw/misc/axiado_clk.c         | 73 ++++++++++++++++++++++++++++++++++++
 hw/misc/meson.build          |  3 ++
 include/hw/misc/axiado_clk.h | 26 +++++++++++++
 4 files changed, 105 insertions(+)
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
index 00000000000..6967a5995c5
--- /dev/null
+++ b/hw/misc/axiado_clk.c
@@ -0,0 +1,73 @@
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
+        return 0x00;
+    }
+}
+
+static void pll_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
+{
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


