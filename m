Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A4C606A32E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 15:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=Mrd5Zhga
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOd8V-0001aX-5S; Wed, 04 Nov 2026 10:42:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOd8P-0001V6-QX; Wed, 04 Nov 2026 10:42:47 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOd8N-0001DQ-E6; Wed, 04 Nov 2026 10:42:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vhg/FRVDVLnHBDqzd848GCi6E1/tyG+vQKpG5ZikLaZIWLDLk0fNvE5yhQqSOqmF5TqaAlPzRESG8gyos0mEBwNpHY/+1QodyXhFhZCsVcUIKQXn+ABmNuqwn+r0H1YBKDXkEFNSIUTa3BUMGZHjVpbVA0UTe4eFQekH9E0vOWA9sue3S6FJUnpi3NZiql36ZnCsIDk60mnuspFItK9qxU5Ii8qBPehUxN3+CrGd+5+yyDyih7VxvOHsCLpaANwK+PISj4pDJfd9IeBVEI2gpvpLPiPcLehuhrQ/zB1gyv3zMCwgWdxWZwe7ix8niq/WSNUn+swsK+g/o68OuCdvUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kPTF7dDM4nT74FKWWWp80ZucSCvvMYMcR7tG99I0Foc=;
 b=zFDAwp2XvgyxhTEzyYSom+vDP+s2q8I1CzzqBW6j/3o0JCqm0KUcUNP34/mLgY9oUsHky0aVOvEnRMmA5TD4ymKGwQudzXeYiopcZKJEBUpNHhVL+qudhJwjbDfjAQS+frZO418MHAlgaXCxib5+d3hBvpuS9QcaUKcxCjC2dXGPbjFPqZUsChrSfiMt94JJCCvHJlnktClVFLXgCLkmQsEAwvMb2//y4BnDnQmrYIulO5KVdd8uYAEGE8u8cFARA0Hexk0qHujDyaWSlcrZ+otQipO+KLu7FMwn4x5Vuon9dMkw/+XxpuPIBpbTJQLR1cG0Mz38+sASr7p7Vu/xnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPTF7dDM4nT74FKWWWp80ZucSCvvMYMcR7tG99I0Foc=;
 b=Mrd5ZhgamGDNAt6Mjja4WONvrEOxfkmyE3bH/E/pYin1s/4xWfd10a2zyQg2JuaZi4G0C4nTFheWYP3LdI2BszcfNdChJyWMSqBQVge0tdwObxoMl3lrH2BhqLpoRlwk8s4/f6E+BVSXLXTaESuy6/w8kS/XjfMBHexLC2FKNqHkMliISiDUBynDzuAInFgdgSg/hfVp0qhXMWTzd03vLarAMnP7mRBY1gW9BRdOgxviUi1qh6KDpQ4mssDDongs6iw6BDGJU3ydEMdXcSRgKPMJMbaRlimc/NKwEC7Itcs+aL1gXtses9h+IDvkJCwQlGfK/Pp0xCc7CBFCgUG8sA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com (2603:1096:405:2c::12)
 by SEYPR02MB9159.apcprd02.prod.outlook.com (2603:1096:101:302::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 15:42:32 +0000
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10]) by TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 15:42:32 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-riscv@nongnu.org
Subject: [PATCH v5 04/26] hw/misc: Add SiFive L2 cache controller model
Date: Wed,  4 Nov 2026 23:41:31 +0800
Message-ID: <20261104154207.641511-5-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104154207.641511-1-bin.meng@processmission.com>
References: <20261104154207.641511-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0056.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36b::16) To TYZPR02MB7121.apcprd02.prod.outlook.com
 (2603:1096:405:2c::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR02MB7121:EE_|SEYPR02MB9159:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d8cf8e9-680f-4b84-5f60-08df3a8a3d77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|260925022911599003|260925021311599003|260925021911599003|56012099006|261009221727099003|261009220027099003|261021123027099003|261022075727099003|261021121427099003|261009223027099003|261009221227099003|261021135927099003|261102123227099003|261102130727099003|261022105027099003|261028144727099003|261026140227099003|261009223327099003|261026121527099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: lbm+aPvO5erfnenvJiqkkOZgQkwG8MnvLKbvpwS0lMWqP3pxTbvPq++o49EtqZipYlRzchgxRYyWQbQ7XY5NWxbW7ef7nGJdGFVub2JUHoFIjU3zMoLrZ8HQEWLFHRt8VRIW8Ni9LUn2FbYnwGQjJbfEY1BeNREF1Hx/BALO0G4R/Ky+LL33CgW+eS1Hk4FuAj90CxKFHKJJo3eqg9ii1j0Yd2ORHVvXrqZ1BAWsX3dAzZyqKFFjMzzq+qKzdcawByaAryx/OWS1W9w9D6FLlOQE3CaGyXZXQAZm01FPfvWM9Z7UDPbCytVbJkMNF+H9KWXPJNRoyiU45KKA2UpX+lwPHQDi88v01+jGejcVsXednS+XeWMlbOtDg9wCYKBOiDSN0Vt4u5CfSN7YLcPesFlijwi+Snn6VsMprDvl7d5Tl6paKpvCv9sJMAcakgf0o9H6dDgG2Y3SWANZ+tRAWXXiq5CmB0IOcXYWCr3lk5JYYx8iAYbu4de/yPBmLdmvEYJtEMcAZmCWoisk20IbvEL6X3sTbXsjbCfBC175t0YsIBxdIvksp96CR76ztzEKJaYsq8M8Z6Jsl0h6vhcxqP7t5BUhzJSGbJblD4YVXczWYRwRZO5DjscYFwqcp/4SwXIFz1+klu4qgGlUHbmnoVKaoMOalrAzsApzVlRTjss=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR02MB7121.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(260925022911599003)(260925021311599003)(260925021911599003)(56012099006)(261009221727099003)(261009220027099003)(261021123027099003)(261022075727099003)(261021121427099003)(261009223027099003)(261009221227099003)(261021135927099003)(261102123227099003)(261102130727099003)(261022105027099003)(261028144727099003)(261026140227099003)(261009223327099003)(261026121527099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0G6Kv0kZMnGX4EjwFbHj8zGGq5LUoyY367zFV/T2ejw/df6xPrW6zSLPsrCh?=
 =?us-ascii?Q?F/UCPWohGTZbwJ8cn10MrZT92Q5UUiFRL5lvJ83EPXTeAIMqCSvfWmBdSByY?=
 =?us-ascii?Q?97uBedIk0YlYs9BjCtkY5gqfezmJ0aM/o094kBsZsVd6542ilv48U0rb7vvT?=
 =?us-ascii?Q?zmQAXF/tIraICcVyDIHwYsu+AF2uGh2gc4Q49mpu+SdykbkEz4b0tBw9WEqJ?=
 =?us-ascii?Q?9Kn3RZhZWwKaMZ5TBTs60RKMDEvyMcIkNdj8A0csY9754CImT9BokfouA/jT?=
 =?us-ascii?Q?lyYag9O3uPusfaw7s0nN8bfTeOpb02qcN3ZV4V4FLgUov+JIiftWsljXK+B0?=
 =?us-ascii?Q?8KwUvwO1U49H00yOefovxas6jTRS7g0plk5CmUVuo00wBLzVpI8AUmyeRKSL?=
 =?us-ascii?Q?kUIQ6RU9eeh0FR7iplpkiEMxePlNnHqLLnYFZ6NKgVUxBYMh2kCjtP7x26Sd?=
 =?us-ascii?Q?GoqWr8Hn6L9GE2QHMB44BsH8nWJ3xOlf+cjLA4TQBmXBJDedNaw71m3HfWtV?=
 =?us-ascii?Q?BhCeiiEUIVAJbWZYwgtiPQCggJvL1WaXaYuJTTuTg7EOkPaUq1n/cH1n1lNT?=
 =?us-ascii?Q?UZAPz22xrfPx8sQT3DZ9pdIwwv0Sk8GF2F9CAUT8+mWQEnFz3KAavejVqFF6?=
 =?us-ascii?Q?QZtIUbpjAux6b8NnAkKRErKmTmKSPXyMRImzSByGg7694deCwVKbkHgjtA1X?=
 =?us-ascii?Q?wkDAIe5kjXZ3UEj+n+tKxB1z0LM2SRBhrDimEPVWnccgvt6oszfc7j3y4KRv?=
 =?us-ascii?Q?fm32G/7Ff0fxvTZSfQK4G5e+7cEkcKO/txE/0o9mAoFr54XB7Gfsi1SAJtQP?=
 =?us-ascii?Q?BU+2VP0yg1WZ5yIhC2820IrcLVn9wxdIs/xTrimQw/0VJayUui4iitY1jvE5?=
 =?us-ascii?Q?VfDckO2yoYg2nUbk0O2chVgN8RX51II7c+XjeW5Z+ITJlzjMz3ZKvVvUetfA?=
 =?us-ascii?Q?0FJsQyTh9ZHhB9wLcxmtlMTVguHgGqmPP+BKrBsCzLCAPea2/AQbGc0Garee?=
 =?us-ascii?Q?37KhDHter3eYrgIT3yNgW9sZaE5LdRiSM0HVvbPEzZkmJtPB+EYVfN45PM7j?=
 =?us-ascii?Q?GbjfgIAcWxDilaRGMI0hYIMFpX54oNK76t/B2x8KzPeUkwLezbauKHSU12rV?=
 =?us-ascii?Q?gyYvnH3KlQ0GwHJnJf29PW9k3kDqmP7Ce+7qe+5OCy2s1JU26FuiI693lUgz?=
 =?us-ascii?Q?WViCIUiOuZ+IcQiJtweESj9HQC8dZZvnkF5asHbPasSJEcRdoafc3FZzLvoV?=
 =?us-ascii?Q?G/h4cyO5uNPuOT7pMK06MaHRBiYFsLZpgil7nvUP8K9mqHpJmv7ZJ2Us8O9F?=
 =?us-ascii?Q?gY1eUY3dJVaj+m3D2UGnLrcbdm9LC3QC8COTfRxVgVv+7tNiYtfZpq6rkFM6?=
 =?us-ascii?Q?3bV4s1sWP43/8iS6nVaWiAG0yxn4D39YAqreM+qgAaBvbFRrsSI/BC5NU0K3?=
 =?us-ascii?Q?xWSUI70aiqqAIZAAelu/jDmdGsUfSdAeDl1unIeq6cQfdbUcoHSOu4F/BjrO?=
 =?us-ascii?Q?thNVaGQOVE+j5HC2A08Hydp7CzIs3OogGAL8w7fWNzDchbtFfAbteFrR8YAr?=
 =?us-ascii?Q?sXlocKyxtZnEJVG2mFCkOChTpA4uxRKWs7Q54dp9GHwgPnxUVq2R1yFEUK4B?=
 =?us-ascii?Q?9kjHs5jtqYISRQHpYQAjg0ciLqWrbUPmBFzWjmjBuUy4ylNrF9Uxk4QX1mr6?=
 =?us-ascii?Q?djUExVCkGoWjHnFCV8U+9mdamwj0rOPO0UOwkkP/UZLE6uCqDJJrSauvKEsF?=
 =?us-ascii?Q?skZsDPVUktHhYd29D+nuzZ+q3yIrRm8=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d8cf8e9-680f-4b84-5f60-08df3a8a3d77
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7121.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 15:42:32.2445 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YCVPqBYqIT9kerJMYHzf8eyTJ8dZXHPeN2zL+YmdlC1oPSTKOMtm2nPIeq9uNOvq28rzhBBu0046sMaHNOhNbQxaDBzlxFa2663V55j6vBE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB9159
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=bin.meng@processmission.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

Changes in v5:
- Select REGISTER to fix riscv32-softmmu link failures

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
 hw/misc/Kconfig               |   4 +
 hw/misc/meson.build           |   1 +
 4 files changed, 329 insertions(+)
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
index 685b7ff1e7..9bd417af82 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -239,6 +239,10 @@ config MCHP_PFSOC_IOSCB
 config MCHP_PFSOC_SYSREG
     bool
 
+config SIFIVE_L2CC
+    bool
+    select REGISTER
+
 config SIFIVE_TEST
     bool
 
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index fc3800baec..a1118e583f 100644
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


