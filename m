Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECBD1CA5FEF
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2026 17:05:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xD391-0007BR-6a; Sat, 03 Oct 2026 13:03:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xD38m-00076q-TW; Sat, 03 Oct 2026 13:03:18 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xD38k-00075o-2V; Sat, 03 Oct 2026 13:03:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BIotkQv5k+kHaI8RDFfLpfAnCB4wX+N81lWxp5geCAdoROWKUGeM5Pz6Utf1JhlfLuj4DaGRwIN6ns7GKn5x1OaZ1Q1AtvlTrRCuWfkFvkWYvr5Y8cf+LrKkHR3deQsF6Ke1a0bCrxwMmzR69hjPgpTG+bAqVcgGJ61PVXUz7Cd2RbAn7Dsflaj6V8+5eVkQiUWRkEgBwsl3IyWPJUBb8rxDNwUfbddOT7HCcT0jDqE45RUyvdkGI9cjSoM4Xh8tlvnX15rhBpGG+2dAQdGUInIOB1KrgPkuVOHgYmGIN+ZVorpaqR1ySqrQ2MlkfCQF9bA4FudtGSABDDSEj+3oZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1PnCZAVUe1OFYHdVmCZHsbYJb8xZb0a7NRkYsPwBThw=;
 b=ZRAE6YFKOjfc5aDNpm4i14U8wk0IthZ5Off3zeaATUakQkUuLAQmrlhr3J/rLuuYA684fJsMMujPEmvpcMx25Yku9Nh8rIg8Wjze6Gjdqq9yUB4zKBc/hg5If22Y2/fNz9uLV2VPB7xqE0O3aRHV40V+AbNBOKn14/UzdgNuAmmEnzGHXBMCx4tW+Hf8ZsuodKYTYKJGFXjfRUMGZJWvSacpOcpPDwYkqM2wejdgNZN7GX1r3jVwKO1nWymUZMa98D0nhxPBsDJCbICoOR1JOklTpVDIUpU2GLLbp0IPzLD4DLJpjdGQjYo8zd3cH/mPGlzCvVhoyaw0wmt8bRrzKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1PnCZAVUe1OFYHdVmCZHsbYJb8xZb0a7NRkYsPwBThw=;
 b=B5CJl1MwfXrpzzrI2nJ8b788jmQZIQDYRqIoZpzDT2LPfxAUtQkLaIWg9syZzYlZTOItw6E3iAaB1pBwGG8VgoTfgAYiI0jww7/XmX6F46Hjkb0k8bzx0DaCpwDhm0gynITpKiWM5n1xDPdX4GWNgzKiLHHGe8VGxqxNrL7Cdkrqih51iiJYj6jBFd/Clly2tOeNUzxuXaJutjU9BW7L6RVUR9AY84d0XvJI10a3XHtKS27pvl8DhdTbmGFUm3Gd6WpWOEYVqgvarn972rzRSYEZo7py+UomTH3gZ2seeVLxZ3hDDZ3VmYAEKIYcyCXYWAAln8jT41aOeSlBPb12rg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by TYSPR02MB7371.apcprd02.prod.outlook.com (2603:1096:405:39::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sat, 3 Oct
 2026 17:03:04 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0472.016; Sat, 3 Oct 2026
 17:03:04 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-riscv@nongnu.org
Subject: [PATCH v3 04/27] hw/misc: Add SiFive L2 cache controller model
Date: Sun,  4 Oct 2026 01:01:54 +0800
Message-ID: <20261003170232.2450916-5-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261003170232.2450916-1-bin.meng@processmission.com>
References: <20261003170232.2450916-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0100.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37b::14) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|TYSPR02MB7371:EE_
X-MS-Office365-Filtering-Correlation-Id: 83e1ad6b-c605-4317-7c92-08df21703049
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|6133799003|18002099003|22082099003|56012099006|260925021311599003|260925022911599003|260925021911599003|10067099003;
X-Microsoft-Antispam-Message-Info: d6rV+Cidr54xkyHraZRX1szwRhHw0xmkrQiNxRl03CfMSiV4JJ7qiWPcSkNpGQEl3efu0ffHBxaP2y3iUrj4aSqM5usD2O+40MDwFHEvwTcfZ1an398y9PqaqSkR14UEIFx9ebnahf2CD7pzs8vrdKAbCe4two4vAwVmnN8yY4nTQ1IDWqJwZezhZlXnSgs24kii5KZOiPEtBLv3Nr+lxDr1CiCo7W+Kv4TrAKtSMahNE4uwjNKMmhymtxOTrDUJUuTRdYMuP1IIVgsG502/CfJaLs2Wh4AoASR56BTnO1crTDh8o3jvxf/tcq/x32/a3xNHtJS45rmUwyIQOVTkyLxb8G5zqJuAvi2ZuZWOIpGp6pUKzr7OR27KP1NZPZiUDUDsaVwONC1sG6irQutah0YVFko89iR3BuhjARdvaZd0homvPkxDsrO8w8U1ItkF9Lr7zODvLZY87tRRgdceE/Mp8OiTo9iXGhbapWkpvUy4JhqwRIgU1ivBUs1k2ne+iWOO71dCbqapvGch767zooGNdukZItwk+gePxU9zSa8iiDJvBN1EJQiKJRZwV48sRGjV/SQelPDxp6VLhHDTxZAinMgRR/Pu0/XnItSu1s1NaWfG9wJJ1yCgNjNPptNRnkdod/WVOjZTZbfK0UNq3xeJBbrnAOvKosXncg1P6d8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(18002099003)(22082099003)(56012099006)(260925021311599003)(260925022911599003)(260925021911599003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BZVtVU5XDX+QsI/IsRwvLrm2cSbT5DDMuFpqU2aWkVFfl0bqv0jfsBiFpKl6?=
 =?us-ascii?Q?tGa86Jy8G3B5SaYbIAL4DEPEivj9Q80Ql2tPpimsDhs8fOXhNhVj3lLRotKW?=
 =?us-ascii?Q?0Giq8JSkuyVxxSyisJBZ6cp+zkEjZnBBlvWsAVRz40tCmlUgYL2R1knwQNg0?=
 =?us-ascii?Q?/626QD7rQRrXSK4SlcOmzYQe/AmHn+T0A8eqt0SEl7OFKWMFAryFxvOLnhoa?=
 =?us-ascii?Q?0cDZD1REliDAm0d7fwsevp6tXAuaXib6EZVjiZP8NFIXBgD8bJyRYyREp9+6?=
 =?us-ascii?Q?DQiEZ3QWKVavK1GAjxecKAb7GY3DWx2T9tIExfxXIxM+H3CJEjLaXDiVfIpm?=
 =?us-ascii?Q?aqCf0Dx9QWr90nNDZ7OVdYdcBbD1D18ZYbyM9pqLAdPICKzEyAWnyHAkXPuF?=
 =?us-ascii?Q?1SnE+a8K7sc6nuJHd4KLXb8CkH8/TWbpMdbjzNwMn/pWUtXvt6f5xKI+Qhdq?=
 =?us-ascii?Q?DPo7Re3s12oI+kfr4gbZGPITsu7x8ACxQnCeqpwwvG7sXe0GhkMoZci/Voap?=
 =?us-ascii?Q?2UUCU7HuUHxyKMfzWzBKOPXGctuRizJurtA52vnEljAG6K49iCkKUYyyK8Z/?=
 =?us-ascii?Q?Kto2wTnjDIrj2+oDoJIgU0970l6F/QLIyOaDuakWGIMDQVoQHl25ln4fsflC?=
 =?us-ascii?Q?ScBqu+bv2WGBmdr36CM2X6/85FL6CnrnBLrALtavn/MEOg3jqcXjmHSfw0vw?=
 =?us-ascii?Q?h5O9+nmXSAGVRFE0Zz17JU+jFgeemSdgbnkLG7EWUQABZyCP9w3yld813coi?=
 =?us-ascii?Q?qYKCft2SlNdih7xHQedac31FFj2vuDgc2RtFckWsb24aVc37G2ctOAJ+qXme?=
 =?us-ascii?Q?efihxiOFoUPas/qIbNkv1iAhtuBeMaVYNdPb0DV7tDY7zXDnNl5BGRBwbx5y?=
 =?us-ascii?Q?2Hqvmq0TPBulky/YE985VlWHu/L97YVvwgRE1t7Zq93ivw6qU7sUiBro30VJ?=
 =?us-ascii?Q?1cLJXggWy4Gs2ACZReJXk35n4UebVp0rrHvtRPSppapOBWjLL+cIE/Tm4zjL?=
 =?us-ascii?Q?7gnDb0CbKkgAAW9tW3NIImV9V4+QJiZeJYyxTe71tCEJoFzhKY15jVHldiAT?=
 =?us-ascii?Q?k0l+0geofqFR3ostvcCiW+y6jlTNFWNIvWhg6jWspJRBN6TeR3k6vKccrG6K?=
 =?us-ascii?Q?fNjtGiDWtPBc7jfEPs2RpHc0d5+XXhvY9+xrNCr7pyUcaIi6AuRwk1fHPzwV?=
 =?us-ascii?Q?iyYyQisz9i0t3yFHwmcwVIJjN21Vd8LeDiJTYAC4qL6OGeOBPobP+/iex6cD?=
 =?us-ascii?Q?iVwBS9V52Csm5SNnqKKd5vzVT69MGpqceBeURvm7FwNroPdyIWOdz++TI0sf?=
 =?us-ascii?Q?jPkdp4p62AYce2hUsDhrVdutBzsF4d5eu3HdNwIXqgqzH1Wj8gHG2JyKK7iq?=
 =?us-ascii?Q?iftlTm5vN2drMMmQDZS1CZvf71SyS03s4qYVvI63y0V6QG1cqqaQMuNswtqB?=
 =?us-ascii?Q?9zJVW1lqp4HeZ8frWqrwfr6NwR9RP45t7ApsvIF5igKoFuq8vWzcvPR6KbVH?=
 =?us-ascii?Q?kvxbC5raVZQKpzScTkCzxqOtLo+HFznNIuMhemPgRNPjom8z2KE3fK6Qedi6?=
 =?us-ascii?Q?8YKFVwYzwd7KNDQeOci1SzV1N0ofgkLLztcvC0eU/fC/yznufu5MfBwJ5RHH?=
 =?us-ascii?Q?qh6/SPzUX43Q4r1YekKlAEbD+LEan7ah6h65HpQa74gKPO/jK9mQAKEVs9oH?=
 =?us-ascii?Q?1GVOg3d928RB7S/Ahztqgvc0aFMqd3NZpm3N+/0MdPo9BAb7+bjEfRTWwfVg?=
 =?us-ascii?Q?KZve3dIYoRRK3MQvtPXY8S2+dVQ/6XI=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83e1ad6b-c605-4317-7c92-08df21703049
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2026 17:03:04.1349 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a8m87R/i5jdghwbwbviuqMGJRwt9KE9UZxUdPnUVf6YLO5hfGb7lpp8Ny8emHN0iuecmQq5HQ0D/DFMcS+n/TrzmB5pNyw7bjWU9q3SJU20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR02MB7371
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=bin.meng@processmission.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
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

---

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


