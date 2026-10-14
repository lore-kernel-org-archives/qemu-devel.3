Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C24CC6B1D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 01:28:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGnj1-0005St-7K; Tue, 13 Oct 2026 21:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGniy-0005S1-U8; Tue, 13 Oct 2026 21:24:08 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGniw-0006ql-MT; Tue, 13 Oct 2026 21:24:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T8fjoYRSqpYuP/0QONlq8j86BczDbn0orKLjtefVS2656R77GS9AtDW7dmvQJd52I5SIUSs2IzC0VXa3xRyco3Y9OznTUTH1wJpzuhtz0a/7JfkRyyUhEZHRO5A0FByL0y2XMx+TBRwe8nGAIAgnF8pIjPexTRYLpFDtl5hR7V660C0VXsRkdUjVOcYGnT4FyKcy8Hhymc0F/WIPVgFuYo6sx/a/IfZaD9zATuIr08FyPJEuj5WilpnkYoYTN1+lUKTYcpKzapAPPWfuOxWaNhpvFx95hhj4nGOq1nyvZfZLxg75BdIm/vq02QAgcRH/23hkrvgqai8fDz5FEBgMJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cqj+wc4HItyXNEUJy0lus4BwTY7MMniiPXfbrjCEdA0=;
 b=j5+hE0YJfTy/qKtMRoxwI+/7y+6UFpiJ0JPgaH8+p26zBdy/ZBlaJKf4YtVUED4zcYInzHKHaahkuyZz3eF5QUD/QJ/ehBRokZ+Xeoq1ph/KX5H2dAtYf+h5Te4WGfH62227zg+mcJR9iI0PhlZ64E/eEnSntd8m1jL1kNr6onsMB+lSBpsUgqFwyRmkolb8m68nR/koGVLDnrq88kGw1LjmRhnEKsq9CbdMVhckAXKHu1MmykbUj/gbV4HxW5APfSoXzRhw5fxBZWlU/c9iCB79H1qwZDdoxEHlKVa2tp699Qs0ubyVK9UtiYc1W7uUOvRIuC6L9zF4DQz1BlIaaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cqj+wc4HItyXNEUJy0lus4BwTY7MMniiPXfbrjCEdA0=;
 b=CGuTRaT+bX8HTvvuTpF2QfUlZriwXgNH+7SP8p5mr6xlVwjRQYH84ImgnK6vCd9bMClbLdAGzDvPEpfsTe8evBoUkkXs3bTtneiJbwC8JMo3LwLLq/4etbwuD4EndVW648ec18Fazqn6hdd5C1y8c4pYPwwHYbXkltTi4wUi/nIUoLSSUpqql7LiP1W+x0DOA9GxR0N1IeeugVz831nIKt3pEgLElXd5qtSh86OEFFOYA5xzyi39L0FfwoDDpARtLf666FlDN5ojMibMLXZ8xa3bYxLnA/iyrvjUu4Mzuw64cWNAEFFU96QTzNluzeQUl1eVyOkSg3g3DD6o2cOLag==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by KL1PR02MB6214.apcprd02.prod.outlook.com (2603:1096:820:9e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 01:23:56 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 01:23:56 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-riscv@nongnu.org
Subject: [PATCH v4 04/27] hw/misc: Add SiFive L2 cache controller model
Date: Wed, 14 Oct 2026 09:22:44 +0800
Message-ID: <20261014012323.322790-5-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014012323.322790-1-bin.meng@processmission.com>
References: <20261014012323.322790-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6PR01CA0005.jpnprd01.prod.outlook.com
 (2603:1096:405:3bc::12) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|KL1PR02MB6214:EE_
X-MS-Office365-Filtering-Correlation-Id: c08b8dd0-b4cd-498e-5b9f-08df2991d0b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|6133799003|18002099003|22082099003|260925022911599003|10067099003|260925021311599003|260925021911599003|261009220027099003|261009223327099003|261009221727099003|261009221227099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: iTkmAWBtrNhiCVbAx1YoUOtadRHG8XKC2m73Z4gUOZq744DFVlY3aC6oQN39UMhGHKq8ZmX+mRtAK4NzzcoG9eaH6fz1zoMGKHG9SaLefVdF/uNY1JFceVzWFRpuOHwm1GgKON/4C1TZvawNKWn58XDQkfzRK+AClOqe/bQcq2GF6u4xmOOJJz2VMbDIBTVtgkS8tb3gB1iZSbsXWK/YcHIhp0SMibJ9rim4DvD5ML5VxfO19bumAc44QRDW5G2jCdZbr5WP9u+Qx1w6pi6PzirI+6maAJ+nJhl+LDE2dkihf721Q5KRDkq/jWH007VeAS0iSpSn+2l1ypDWHTX4QWYvO4h9a/89i9Yg6lT6RVbk54dC/9iWvsCzJslA8dTDqkfN6Va5cLU5ekLrP+eId0NNrnjOv3Vy8DFhuToTybC3ZITm7awBD8u9bq/Q3tyOEd2HT+TFSj8xtx9AOPv1gU/dnuLhgF+uma2s7/XBGwjETHhiWXrXvymWMxeH3ZTMFLsDrUnJB5LxF4Awf52gatZZwpofv1v1e1ggTh7TJvbfkDsKGSYCgDn9stjX+bWG8ES0bPEvjfK2IxtGd5B910Z4Vs52zZ6a8U9klx1RI63IN98+UQ80ahqIfJcEvQ2ahRYN9A4/mVgKy5fIdkAqfcwHrd8dXSgds8UouEuPuKE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(18002099003)(22082099003)(260925022911599003)(10067099003)(260925021311599003)(260925021911599003)(261009220027099003)(261009223327099003)(261009221727099003)(261009221227099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XVT7bh31T8BBaxjHeFSR+tVSTb89ESiUQslTFdBeYaGoUxvK51TgHT7apXYW?=
 =?us-ascii?Q?ilfFxEjbCfIhDJ0a5vLlREQESR9j6V4mWKNtwLa24vkgI6q2g0vC1iiduJuA?=
 =?us-ascii?Q?1tOfwMvaOlDiaFz/KA+LcyBH/jAP1MsFwamgN9D1YpnhF9wI6YVudRmF6EWR?=
 =?us-ascii?Q?GxVgIuNE6VHTnMmFUm1nlEMuu430qvK4NKVcK0imsxUjP4Fgg2mNJ7rrA3zr?=
 =?us-ascii?Q?mMFRcBdfweI9cDedFMHA5DLM6mcT6lHVrNns7e2kgHxWbd9vjNkq9HohiVTh?=
 =?us-ascii?Q?SE0TPHArWlbsIxLlNrSXBpajeC0UwRnygW8kOGWJZOEWZHkn+8cxqpl5gby0?=
 =?us-ascii?Q?rlpdgIOuaDBw3kiM6HHlPoSXgAZD2ilpzss/hN1jjMTPyVzp+muyv/St9XUU?=
 =?us-ascii?Q?oubZU4ii9tBzZIFq6MSMezoG7A9ixEGXrXsqftRfthBWlG17NMRECtLe39yT?=
 =?us-ascii?Q?LuURoCjJ55S9bFnLpyK1sG3KX70NL+L7ac8sfoyGKLkkq2xVNS2YY7Z1p9KF?=
 =?us-ascii?Q?mvati3s/z2fg6OiPCGjc9NdbzF1AwsQA/pPfQZ7DwOhlJ+I6gF2hwAiVeFkZ?=
 =?us-ascii?Q?VncFyaWdy0i0YkRvAQGKLI5sKFURE7wmcb6ytGxgUtP6uk+OYoItaca5AeKD?=
 =?us-ascii?Q?zK78FpqntL1Rj82cPH2tR3vHYgIBJi/ovEFyNcZGaG+AJdBYzEpPHxywT0jy?=
 =?us-ascii?Q?73BpUhjPxwN/olFSmiYeqBdC3sI4rOSlS1TE2HjDu6OnLcCEo3L9Ujd8Mc8K?=
 =?us-ascii?Q?8VCWABsKlDtm1l9Bxm8ekDd73xLoHwjswD1V26RBL8yZ1JFG5wdFDJuXkBAC?=
 =?us-ascii?Q?klYVIH8OY1w+AKojd9it7A8ovV35V4/GQQyxTlGwTtw+fewY/fXNR+JLqZXZ?=
 =?us-ascii?Q?WDrFnaSTOdGzMhGCiFN3guzyG7N5hsLkKLRkZ5O7LHamfPlnjI1AG/BNa4N8?=
 =?us-ascii?Q?YS5sKgxPRPN23ORD2CFKfq/svqUfQktF7b6T9Wk1y9eKr95Fz8R6pzOvFG/p?=
 =?us-ascii?Q?yTwz2/9Q8A22sbSA8q8+A8FdLUuwaNP9OA5Zg8N4ye41qAD3n79djkj3jhrd?=
 =?us-ascii?Q?lLVjWyl++sCkiz001UEmyb1zqb78bxBEnFlb67hYw/kzVpPL1y1VPEEKlLlZ?=
 =?us-ascii?Q?qvcUMBezteHm8G94hJkR8A8YScNSwvZcMZni8NlIGxXQt1yGf5cFNgJ/Owhp?=
 =?us-ascii?Q?YNmDZEUN/p40rl168vawt4KZpjbUoW0ac0sWGy3LaBusE98TpucMafal3YeK?=
 =?us-ascii?Q?Eq3eMDkN9TDwpAwX/gi/DBXV7FND3zGYN+Q+TxtfVKvkIJk/w3qIvHJH6S4A?=
 =?us-ascii?Q?lXh41H1qpLjTsIkOluRO6l3haPPt5pXzPOv4p2l4hFaM2hPj1CiCf4antMrC?=
 =?us-ascii?Q?Z+PeYRtwLmShRL55UDH+jQJTRY3tnkVpPx+CvzBYuZ1jwrIJFeUTY2AaygG6?=
 =?us-ascii?Q?jYaouWM7qvgvI1OVGIeqOmpRTHM7D1NKPSQcI1YiwfykDxdukgTf5pwUVUY4?=
 =?us-ascii?Q?URo65Szh/N/JC+Oicy2qRTxK4dhk41aJbqh1AFX1Nu34S2wOaTXFhKr2JWSp?=
 =?us-ascii?Q?wHZN4biNVmKDC5Lqm9YmLeQAVkQsKg4lKVxqEsoQRQYxwIZnF/Ai1KEsHp6T?=
 =?us-ascii?Q?gwe3tSUUQjC6oKFNwrSp3Kvj0DwiiGkSwRMz6G15lg3Jfa4liosI/C+GMcYX?=
 =?us-ascii?Q?9wdCO+fXxoVTmMACUXu7XZQYeqXvct33Hb26b1J/B2+FZtSY6o03Jb4lR8+K?=
 =?us-ascii?Q?bW7dJJQvLGZglSON0tVs8ud4MPuYGiw=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c08b8dd0-b4cd-498e-5b9f-08df2991d0b5
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 01:23:55.9834 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mw2aEIPGO5ps8LMC8fZjglU89etqavl8FZndT9V0oDNRxhSEhhSGI2E4Gj9slL9M1kWKW66/FFnWjW3Y1zc9DUdPZLRM1z0j86XFZffMqBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB6214
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=bin.meng@processmission.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
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

FU540 and PolarFire use the same SiFive L2 configuration and way-control
interface. Implement Config, monotonic WayEnable, and indexed WayMask
registers with a configurable master count for the 21-master FU540 and
15-master PolarFire integrations.

Own the fixed 2 MiB SRAM backing inside the controller and expose the
remaining LIM ways through a resizable alias. Also expose a separately
sized L2 Zero window backed by RAM to approximate scratchpad accesses.
The Zero aperture is independent of the cache/LIM way partition; cache
allocation, replacement, coherence, and ECC remain unimplemented.

Export register, LIM, and Zero windows for the SoC to map.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Tested-by: Conor Dooley <conor.dooley@microchip.com>

---

(no changes since v3)

Changes in v3:
- Name the QOM parent field parent_obj
- Move the LIM and Zero windows into L2CC
- Use the shared SiFive name and indexed WayMask registers
- Parameterize master count and the RAM-backed Zero aperture
- Resize a LIM alias while keeping its SRAM backing fixed

Changes in v2:
- Use the Resettable API instead of a legacy reset handler

 include/hw/misc/sifive_l2cc.h |  42 +++++
 hw/misc/sifive_l2cc.c         | 282 ++++++++++++++++++++++++++++++++++
 hw/misc/Kconfig               |   3 +
 hw/misc/meson.build           |   1 +
 4 files changed, 328 insertions(+)
 create mode 100644 include/hw/misc/sifive_l2cc.h
 create mode 100644 hw/misc/sifive_l2cc.c

diff --git a/include/hw/misc/sifive_l2cc.h b/include/hw/misc/sifive_l2cc.h
new file mode 100644
index 0000000000..b1cd9c4054
--- /dev/null
+++ b/include/hw/misc/sifive_l2cc.h
@@ -0,0 +1,42 @@
+/*
+ * SiFive L2 cache controller
+ *
+ * Copyright (c) 2026 Process Mission
+ *
+ * Author:
+ *   Bin Meng <bin.meng@processmission.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef SIFIVE_L2CC_H
+#define SIFIVE_L2CC_H
+
+#include "hw/core/register.h"
+#include "hw/core/sysbus.h"
+
+#define SIFIVE_L2CC_REG_SIZE    0x1000
+#define SIFIVE_L2CC_REG_NUM     (SIFIVE_L2CC_REG_SIZE / 8)
+#define SIFIVE_L2CC_MAX_MASTERS 21
+
+enum {
+    SIFIVE_L2CC_MMIO_REGS,
+    SIFIVE_L2CC_MMIO_LIM,
+    SIFIVE_L2CC_MMIO_ZERO,
+};
+
+typedef struct SiFiveL2CCState {
+    SysBusDevice parent_obj;
+    uint64_t regs[SIFIVE_L2CC_REG_NUM];
+    RegisterInfo regs_info[SIFIVE_L2CC_REG_NUM];
+    MemoryRegion lim_ram;
+    MemoryRegion lim;
+    MemoryRegion zero;
+    uint32_t num_masters;
+    uint64_t zero_size;
+} SiFiveL2CCState;
+
+#define TYPE_SIFIVE_L2CC "sifive.l2cc"
+OBJECT_DECLARE_SIMPLE_TYPE(SiFiveL2CCState, SIFIVE_L2CC)
+
+#endif
diff --git a/hw/misc/sifive_l2cc.c b/hw/misc/sifive_l2cc.c
new file mode 100644
index 0000000000..f99c44b301
--- /dev/null
+++ b/hw/misc/sifive_l2cc.c
@@ -0,0 +1,282 @@
+/*
+ * SiFive L2 cache controller
+ *
+ * Copyright (c) 2026 Process Mission
+ *
+ * Author:
+ *   Bin Meng <bin.meng@processmission.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/units.h"
+#include "qapi/error.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/core/register.h"
+#include "hw/core/registerfields.h"
+#include "hw/misc/sifive_l2cc.h"
+#include "migration/vmstate.h"
+
+REG64(L2_CONFIG, 0x000)
+    FIELD(L2_CONFIG, BANKS, 0, 8)
+    FIELD(L2_CONFIG, WAYS, 8, 8)
+    FIELD(L2_CONFIG, LG_SETS, 16, 8)
+    FIELD(L2_CONFIG, LG_BLOCK_BYTES, 24, 8)
+REG64(L2_WAY_ENABLE, 0x008)
+    FIELD(L2_WAY_ENABLE, VALUE, 0, 8)
+REG64(L2_WAY_MASK, 0x800)
+
+#define L2_CONFIG_RESET         0x06091004
+#define L2_LIM_WAY_COUNT        15
+#define L2_WAY_SIZE             (128 * KiB)
+#define L2_CACHE_SIZE           (2 * MiB)
+#define L2_ZERO_MAX_SIZE        (32 * MiB)
+
+static void sifive_l2cc_update_l2lim(SiFiveL2CCState *s, uint64_t way_enable)
+{
+    uint64_t l2lim_size;
+
+    if (way_enable >= L2_LIM_WAY_COUNT) {
+        l2lim_size = 0;
+    } else {
+        l2lim_size = (L2_LIM_WAY_COUNT - way_enable) * L2_WAY_SIZE;
+    }
+
+    memory_region_transaction_begin();
+    memory_region_set_size(&s->lim, l2lim_size);
+    memory_region_set_enabled(&s->lim, l2lim_size != 0);
+    memory_region_transaction_commit();
+}
+
+static uint64_t sifive_l2cc_way_enable_pre_write(RegisterInfo *reg,
+                                                 uint64_t value)
+{
+    uint64_t current = *(uint64_t *)reg->data;
+
+    return MAX(current, value);
+}
+
+static void sifive_l2cc_way_enable_post_write(RegisterInfo *reg,
+                                              uint64_t value)
+{
+    SiFiveL2CCState *s = SIFIVE_L2CC(reg->opaque);
+
+    sifive_l2cc_update_l2lim(s, value);
+}
+
+#define WAY_MASK_REGISTER(_id)                  \
+    {                                           \
+        .name = "WAY_MASK_" #_id,               \
+        .addr = A_L2_WAY_MASK + 8 * (_id),       \
+        .reset = UINT64_MAX,                    \
+    }
+
+static const RegisterAccessInfo sifive_l2cc_regs_info[] = {
+    {
+        .name = "CONFIG",
+        .addr = A_L2_CONFIG,
+        .reset = L2_CONFIG_RESET,
+        .ro = UINT64_MAX,
+    }, {
+        .name = "WAY_ENABLE",
+        .addr = A_L2_WAY_ENABLE,
+        .rsvd = ~R_L2_WAY_ENABLE_VALUE_MASK,
+        .pre_write = sifive_l2cc_way_enable_pre_write,
+        .post_write = sifive_l2cc_way_enable_post_write,
+    },
+    WAY_MASK_REGISTER(0),
+    WAY_MASK_REGISTER(1),
+    WAY_MASK_REGISTER(2),
+    WAY_MASK_REGISTER(3),
+    WAY_MASK_REGISTER(4),
+    WAY_MASK_REGISTER(5),
+    WAY_MASK_REGISTER(6),
+    WAY_MASK_REGISTER(7),
+    WAY_MASK_REGISTER(8),
+    WAY_MASK_REGISTER(9),
+    WAY_MASK_REGISTER(10),
+    WAY_MASK_REGISTER(11),
+    WAY_MASK_REGISTER(12),
+    WAY_MASK_REGISTER(13),
+    WAY_MASK_REGISTER(14),
+    WAY_MASK_REGISTER(15),
+    WAY_MASK_REGISTER(16),
+    WAY_MASK_REGISTER(17),
+    WAY_MASK_REGISTER(18),
+    WAY_MASK_REGISTER(19),
+    WAY_MASK_REGISTER(20),
+};
+
+static bool sifive_l2cc_register_implemented(SiFiveL2CCState *s,
+                                             hwaddr offset)
+{
+    if (offset == A_L2_CONFIG || offset == A_L2_WAY_ENABLE) {
+        return true;
+    }
+
+    return offset >= A_L2_WAY_MASK &&
+           offset < A_L2_WAY_MASK + 8 * s->num_masters && !(offset & 7);
+}
+
+static uint64_t sifive_l2cc_read(void *opaque, hwaddr offset,
+                                 unsigned size)
+{
+    RegisterInfoArray *reg_array = opaque;
+    SiFiveL2CCState *s = SIFIVE_L2CC(reg_array->r[0]->opaque);
+
+    if (sifive_l2cc_register_implemented(s, offset)) {
+        return register_read_memory(opaque, offset, size);
+    }
+
+    qemu_log_mask(LOG_UNIMP, "%s: unimplemented device read "
+                  "(size %u, offset 0x%" HWADDR_PRIx ")\n",
+                  __func__, size, offset);
+    return 0;
+}
+
+static void sifive_l2cc_write(void *opaque, hwaddr offset,
+                              uint64_t value, unsigned size)
+{
+    RegisterInfoArray *reg_array = opaque;
+    SiFiveL2CCState *s = SIFIVE_L2CC(reg_array->r[0]->opaque);
+
+    if (sifive_l2cc_register_implemented(s, offset)) {
+        register_write_memory(opaque, offset, value, size);
+        return;
+    }
+
+    qemu_log_mask(LOG_UNIMP, "%s: unimplemented device write "
+                  "(size %u, value 0x%" PRIx64
+                  ", offset 0x%" HWADDR_PRIx ")\n",
+                  __func__, size, value, offset);
+}
+
+static const MemoryRegionOps sifive_l2cc_ops = {
+    .read = sifive_l2cc_read,
+    .write = sifive_l2cc_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = { .min_access_size = 1, .max_access_size = 8 },
+    .impl = { .min_access_size = 1, .max_access_size = 8 },
+};
+
+static void sifive_l2cc_reset_hold(Object *obj, ResetType type)
+{
+    SiFiveL2CCState *s = SIFIVE_L2CC(obj);
+    size_t i;
+
+    memset(s->regs, 0, sizeof(s->regs));
+    for (i = 0; i < 2 + s->num_masters; i++) {
+        hwaddr addr = sifive_l2cc_regs_info[i].addr;
+
+        register_reset(&s->regs_info[addr / sizeof(uint64_t)]);
+    }
+}
+
+static void sifive_l2cc_init(Object *obj)
+{
+    SiFiveL2CCState *s = SIFIVE_L2CC(obj);
+    RegisterInfoArray *reg_array;
+
+    reg_array = register_init_block64(
+        DEVICE(obj), sifive_l2cc_regs_info,
+        ARRAY_SIZE(sifive_l2cc_regs_info), s->regs_info, s->regs,
+        &sifive_l2cc_ops, false, SIFIVE_L2CC_REG_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &reg_array->mem);
+}
+
+static void sifive_l2cc_realize(DeviceState *dev, Error **errp)
+{
+    SiFiveL2CCState *s = SIFIVE_L2CC(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    if (!s->num_masters || s->num_masters > SIFIVE_L2CC_MAX_MASTERS) {
+        error_setg(errp, "num-masters must be between 1 and %u",
+                   SIFIVE_L2CC_MAX_MASTERS);
+        return;
+    }
+    if (!s->zero_size || s->zero_size > L2_ZERO_MAX_SIZE) {
+        error_setg(errp, "zero-size must be between 1 byte and 32 MiB");
+        return;
+    }
+
+    /* Keep the SRAM backing fixed while WayEnable changes the LIM alias */
+    if (!memory_region_init_ram(&s->lim_ram, OBJECT(dev),
+                                TYPE_SIFIVE_L2CC ".lim-ram",
+                                L2_CACHE_SIZE, errp)) {
+        return;
+    }
+    memory_region_init_alias(&s->lim, OBJECT(dev), TYPE_SIFIVE_L2CC ".lim",
+                             &s->lim_ram, 0, L2_LIM_WAY_COUNT * L2_WAY_SIZE);
+    sysbus_init_mmio(sbd, &s->lim);
+
+    /*
+     * L2 Zero allocates into enabled cache ways without external memory
+     * backing. Use a separate RAM stand-in because QEMU does not model
+     * cache allocation, replacement, or coherence. Its aperture size is
+     * independent of the cache/LIM way partition.
+     */
+    if (!memory_region_init_ram(&s->zero, OBJECT(dev),
+                                TYPE_SIFIVE_L2CC ".zero",
+                                s->zero_size, errp)) {
+        return;
+    }
+    sysbus_init_mmio(sbd, &s->zero);
+
+    sifive_l2cc_update_l2lim(s, s->regs[R_L2_WAY_ENABLE]);
+}
+
+static const Property sifive_l2cc_properties[] = {
+    DEFINE_PROP_UINT32("num-masters", SiFiveL2CCState, num_masters,
+                       SIFIVE_L2CC_MAX_MASTERS),
+    DEFINE_PROP_SIZE("zero-size", SiFiveL2CCState, zero_size,
+                     L2_ZERO_MAX_SIZE),
+};
+
+static int sifive_l2cc_post_load(void *opaque, int version_id)
+{
+    SiFiveL2CCState *s = opaque;
+
+    sifive_l2cc_update_l2lim(s, s->regs[R_L2_WAY_ENABLE]);
+    return 0;
+}
+
+static const VMStateDescription vmstate_sifive_l2cc = {
+    .name = TYPE_SIFIVE_L2CC,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .post_load = sifive_l2cc_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_EQUAL(num_masters, SiFiveL2CCState),
+        VMSTATE_UINT64_EQUAL(zero_size, SiFiveL2CCState),
+        VMSTATE_UINT64_ARRAY(regs, SiFiveL2CCState, SIFIVE_L2CC_REG_NUM),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void sifive_l2cc_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    rc->phases.hold = sifive_l2cc_reset_hold;
+    device_class_set_props(dc, sifive_l2cc_properties);
+    dc->realize = sifive_l2cc_realize;
+    dc->vmsd = &vmstate_sifive_l2cc;
+}
+
+static const TypeInfo sifive_l2cc_info = {
+    .name = TYPE_SIFIVE_L2CC,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(SiFiveL2CCState),
+    .instance_init = sifive_l2cc_init,
+    .class_init = sifive_l2cc_class_init,
+};
+
+static void sifive_l2cc_register_types(void)
+{
+    type_register_static(&sifive_l2cc_info);
+}
+
+type_init(sifive_l2cc_register_types)
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 46e3c03cc8..254103e4ff 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -206,6 +206,9 @@ config MCHP_PFSOC_IOSCB
 config MCHP_PFSOC_SYSREG
     bool
 
+config SIFIVE_L2CC
+    bool
+
 config SIFIVE_TEST
     bool
 
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 9790afa104..6c401541e9 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -33,6 +33,7 @@ system_ss.add(when: 'CONFIG_K230', if_true: files('k230_ddr.c'))
 system_ss.add(when: 'CONFIG_MCHP_PFSOC_DMC', if_true: files('mchp_pfsoc_dmc.c'))
 system_ss.add(when: 'CONFIG_MCHP_PFSOC_IOSCB', if_true: files('mchp_pfsoc_ioscb.c'))
 system_ss.add(when: 'CONFIG_MCHP_PFSOC_SYSREG', if_true: files('mchp_pfsoc_sysreg.c'))
+system_ss.add(when: 'CONFIG_SIFIVE_L2CC', if_true: files('sifive_l2cc.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_TEST', if_true: files('sifive_test.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_E_PRCI', if_true: files('sifive_e_prci.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_E_AON', if_true: files('sifive_e_aon.c'))
-- 
2.53.0


