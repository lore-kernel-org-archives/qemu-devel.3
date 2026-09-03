Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DADAC624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 11:31:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x25ag-0005r7-O3; Thu, 03 Sep 2026 07:26:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x25af-0005oz-3v; Thu, 03 Sep 2026 07:26:45 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x25ad-0006k3-7u; Thu, 03 Sep 2026 07:26:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I1+Z7kYdF7t1MC786+jqRJQg8NrlYtdKF76ixc2aW8Ul1RP/viDc1K5Hf8ejIe+x+2oOq6DwSPNL+XOhk9MeEFkH8bycHMJHffqu7TyRu0RoJts0SS87q5napSLPtq71eV6N0k1s1BdqX5+LK8By8heYIg1Ne94OqQaMPRjcQim+1Yw8SUxNmlo50UKs6D9IQaI1MpooPBydRg5Y+FdXkVIAqeyzQkoxghnY86mXFuzGYd8K0W/CTNNzaDLFG+39+ZLMKMriiFawkMe1hiBETB2uhciW0Z+M79/yly7FK7IHJQyvQgIwU6eSl0IhgHiMy0f9Nfc8pms9IuaoSAK+EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64bfFIkxbKG1Vk0SGtQinOs0N8O8n6aw5ySeocBBBBw=;
 b=xzd2iBWFCnZh/U8E7nilTgUnE1IdegLPeOJW1m1LHELONFU/kwYeQMPK+b1FKxNOuDPJvmy013H797felOcve7BQX7t2r/+RggtxGr5A/6fqPkgvhMYbkmND0N/azXCCxc1S7K+gC25yZlK06XyAmSHajcCyvlL9ipCJQcmIgJpLLP31NZ4cnl6uVXL0uXlyUtmDThS6nUhayAc1SIRKOVAhsktdxuITljBFnar9xsNkr3D51bo7sVhCF8jWf5/sL2KShjnq0BNUr8063rDvyLdwIwh2FH3REiWp5LEVlYx/vluAUf+3lNn+J4HeY6vKdiBFxj36NmvUWPM6Amh6Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64bfFIkxbKG1Vk0SGtQinOs0N8O8n6aw5ySeocBBBBw=;
 b=h0ykcKpI4f8nUu2kmJUlMioGpnKPmDUkDsYqoTuPEPnKyQjq6BK+4zFZjp3A7EZutL2UyqB+t4++u9taKVLTd3WoKBaeJOH9qNZVe6CRxxlz6PaWZQHXFAS+XFPMn4nkmDI1wAQhS2gn/6Ckv/8UOoAqXxQLSbOxIrkNBlk/UTaRWjJCu9F3L+FvG/Hdana35nWIqMeeuAQ8AnUIubIi+QO24fGCsS08JSG5dj0Pz+LzKhTpzElci5HgU1kEalp8gIPOO9LfoWng0qXs0/OinlubUJR/9WSlB680m8HFE0GxkRtXRRCWRLT96QUmwk1QFkrv7QSi234zYBSQeUr8sw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by OSNPR02MB8962.apcprd02.prod.outlook.com (2603:1096:604:45b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 11:26:33 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 11:26:33 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: qemu-arm@nongnu.org
Subject: [PATCH 22/33] hw/misc: Model the Phytium E2000 random generator
Date: Thu,  3 Sep 2026 19:25:02 +0800
Message-ID: <20260903112532.3276678-23-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903112532.3276678-1-bin.meng@processmission.com>
References: <20260903112532.3276678-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0026.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::11) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|OSNPR02MB8962:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b7f2be9-c5bb-428f-b350-08df09ae3549
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|10067099003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: WQ6l/d/MQFQ2N/Ou/pjmhsL99aF3QcsB/Fj0p+MnXE5i+lOvnq8hWRy0FG9cvCRU1zPNn6W3hUfItmKq5xXwSrG1ZwTqBkrLXIKzLHHexbgtLmwHvholnriyWonioPhiQR/ZhP9fNReKypiyQsAh/64mfTs/s96qRncvf5zUxOvjGHW3RW4jjtUbfMBF5B4dfuD2rsn4D0uNtrQ5hKWvvKl6rhCt0B58Hy0tc8oFvKPour6fTejO5pvSvQ1U0/yvxDlfrrGvm1qJgdHyaRteZPR2ZXsw8YwJPpKt3ZUUKg/GDPK4Z2Ut/vNEaS485fM1zKJtjQ39XRGGJWTsa1gOJfdGtB0KggBxAClj9ltLP/AD2v/chcCy+UJD+JeKpkMX8mxINkmb1baCEjq9H9kAoEaH7V/ZW7h6vUQEvrOlPJmYC5Kghsd4WvKhbC/DLsb5dQLSit4SVwW2lu/NBUVqirOtVZf+13nLg4EBhhFHNAzZ1cQrj9me2wDfbsedEvv36EkJdJl3vvdIwxOS9i5wBu9Tr9WxASpbkP9lJAqoBXH6yakqqKNXjLGVsXbhd+ANmAgcxWjCg7DLyjjkny4FAr9sqGAxUrso2D4jxRRpexQgeZG47oMdiqQrs5nUfr41mTzs1nABRkv2e8cBNuKqwY0qzUTDJrB3Ds/nXi3mkE8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10067099003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iJlbHihncqLjY2KlqiaoO2m2637a3CY6zkq5SD5IgCqnK5Mzp09M5uWF+Aus?=
 =?us-ascii?Q?VGBulUfF2OOY6bFkgk+6n5FQ0DssOR8IK/914myK4gR6h29f3+4qLzMmHikx?=
 =?us-ascii?Q?stNr+AAWn7fYTHNZRsYNzuL9EYgS+yXFFXjjzNh7bp2AFSXWk6prUnYadJ96?=
 =?us-ascii?Q?rtLYEKflAi+0sLIue5VE+ojoz9CamhJOBam4ZvBUsUbeCl2HxGgkWXTYwciN?=
 =?us-ascii?Q?6qdSvqDqYtxURZzJLO/jXmQVO080zu8xzMg5K2R1YOa6fWNIlriHb8airmWd?=
 =?us-ascii?Q?+fxT9ohDcM51lbZJwVnlw4nBw0GAagGnDLUDeBvO49SKCuGcWGdaiRA/yo4O?=
 =?us-ascii?Q?peBvGTjoRTJjzM3uxwNhL3uHT+lm+u8LNd1jJfVFvCzjt6rFC9577T6OTCNW?=
 =?us-ascii?Q?FGjPDIeXuUaF1ytgkbSngfzihhX6v1ey3Y0pPz5HL+pqjY7neme6XSmfrHfF?=
 =?us-ascii?Q?Sf+uvN+6grrg928c9xCbJBqeYmqXaxzNUVz/tZhNTHTo8EsI4FrV6aQdOBH5?=
 =?us-ascii?Q?00OMdlbsdlZk9KiqIznZ5/cWxShVRbZq9Qj+9udKkP1qrAwQdQv9VSbW21Ty?=
 =?us-ascii?Q?ZkAxvQcr3D8DvV6nz+q772+NJs42zIPPRPuAijO1LuWJZFrN7CGQ5pzN2hcj?=
 =?us-ascii?Q?SRuAfXhQhzuIxZN+Th0tFbnCJ2ki9VWX+bs89WMwoNqatXOo79l+sfoODuSD?=
 =?us-ascii?Q?x2jeHGUUhTCmuYm1u1r+LX2pbeYiY4IQ/EX4F7KF211l0f2QtmfVov2+mE2B?=
 =?us-ascii?Q?d8fpYPzylmV2THmoHkAon1wlqtS33xwURChhdOhhc8sJ39PrqrXLS4yDEbXz?=
 =?us-ascii?Q?m48pOqh6aL8DECzo2EGwQsj1a/ojKhaYrKaitF2ZnQkIvz50I8WKPeYuBpUu?=
 =?us-ascii?Q?RLVtvFNbNYPqSpkuKoiel/pT8qgaz1QbKwaNORo20apOfVwnGF41vS4xhr6u?=
 =?us-ascii?Q?Xz7j9744rMnBQ208fktSIChd8FHNtRf1vPsev1ZuxentXqYfwJ1LR3hcO/qk?=
 =?us-ascii?Q?+sAgqAGjvg/P05aXeNb+IsUKLdFDZxI0uDi3LkeUlJNrlY2ZG7gL40NZRciP?=
 =?us-ascii?Q?4fukAgDpuqzzD1c8oiXg9u97Kl3vjYE9IEsirtV5v6w1KeqUJotpcbeVK2su?=
 =?us-ascii?Q?1Cdmj10mrF4CYtrQ4EcQ6lL9SHDjZh+bP8ydLEnG71Nw6KMGGK6+JygAHB+y?=
 =?us-ascii?Q?cF2eT1MqAmjDXFcqcuU8zDmMwI/PLmTvdZD4pzyZdx+PsH2bE9Ddg7NhnNXO?=
 =?us-ascii?Q?pFR9fSxf3oaYVKXv13Tj6UE0p+z9lt9IrHf1Lan4vlvNJSHxp6Y7j2QKcFpk?=
 =?us-ascii?Q?n4GvcePXP5s7v8ihq/334KPSlRPbQQHMkffbZDODBf7Bsi8SB7s8bA4tjVgO?=
 =?us-ascii?Q?4vkPCp6qP/fQbz8ijexAORMftoTDAra+VcuE/7nAsVON4dfxlp5aO6skXEae?=
 =?us-ascii?Q?eo1nwODpzSo57gMHDHNKF75XIczEk0pOgekDpU4vWVwC2AWiP7gWNSqxD6NF?=
 =?us-ascii?Q?g92/PNzeoX1BiSm+bzZ0Ku9dqHhJi3jHRMTOq3ZElvcGmaqomFU1H2BbfEbn?=
 =?us-ascii?Q?7OYL67nnCcxkDFsgLhiDTDnAR7jObeigvMW5gA1xc8HojlZumwrNQZD8eQ8C?=
 =?us-ascii?Q?DWlldq33jLMN9w5SVS3eUfiLwFS5o6vJA6T8iHQ8l6+fKDZ2FsXthqrWGJVM?=
 =?us-ascii?Q?btV/BrREq66Rpa5xSV9utwQP6/WG205OefF5YH3L7MiJAEJyWNE9yUSLEwue?=
 =?us-ascii?Q?DQQNlMV43NaDTjYuPc5VAv5aMbPrIL8=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b7f2be9-c5bb-428f-b350-08df09ae3549
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 11:26:33.4206 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7O/xSD3Svux5hLha6lkQ0dX22zh1+4Nej/Kr7kiegFFRKRCwdcV3EqcqH6T0aTJhZZcHqN6b3JmxeLGwcGfsLn0t87BIj74K8h9z7tQY+ZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR02MB8962
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Implement the polled control, mode, status, data, and reseed registers
for the E2000 hardware RNG. Use the guest random source for data and
preserve deterministic replay.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/misc/meson.build                 |   1 +
 hw/misc/phytium_e2000_rng.c         | 182 ++++++++++++++++++++++++++++
 include/hw/misc/phytium_e2000_rng.h |  23 ++++
 3 files changed, 206 insertions(+)
 create mode 100644 hw/misc/phytium_e2000_rng.c
 create mode 100644 include/hw/misc/phytium_e2000_rng.h

diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 8db55e3ef9..7fafafd87c 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -19,6 +19,7 @@ system_ss.add(when: 'CONFIG_ARM11SCU', if_true: files('arm11scu.c'))
 system_ss.add(when: 'CONFIG_PHYTIUM_E2000', if_true: files('phytium_e2000_ddr.c'))
 system_ss.add(when: 'CONFIG_PHYTIUM_E2000', if_true: files('phytium_e2000_mhu.c'))
 system_ss.add(when: 'CONFIG_PHYTIUM_E2000', if_true: files('phytium_e2000_pbr.c'))
+system_ss.add(when: 'CONFIG_PHYTIUM_E2000', if_true: files('phytium_e2000_rng.c'))
 
 system_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('armv7m_ras.c'))
 
diff --git a/hw/misc/phytium_e2000_rng.c b/hw/misc/phytium_e2000_rng.c
new file mode 100644
index 0000000000..6862fb9ec6
--- /dev/null
+++ b/hw/misc/phytium_e2000_rng.c
@@ -0,0 +1,182 @@
+/*
+ * Phytium E2000 random number generator
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
+#include "hw/misc/phytium_e2000_rng.h"
+
+#include "migration/vmstate.h"
+#include "qemu/bitops.h"
+#include "qemu/guest-random.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+
+#define TRNG_CR             0x00
+#define TRNG_CR_RNGEN       BIT(0)
+#define TRNG_CR_ROSEN_MASK  MAKE_64BIT_MASK(4, 4)
+#define TRNG_CR_DIEN        BIT(16)
+#define TRNG_CR_ERIEN       BIT(17)
+#define TRNG_CR_IRQEN       BIT(24)
+#define TRNG_CR_MASK        (TRNG_CR_RNGEN | TRNG_CR_ROSEN_MASK | \
+                             TRNG_CR_DIEN | TRNG_CR_ERIEN | TRNG_CR_IRQEN)
+
+#define TRNG_MSEL           0x04
+#define TRNG_MSEL_PRNG      BIT(0)
+
+#define TRNG_SR             0x08
+#define TRNG_SR_DRDY        BIT(1)
+
+#define TRNG_DR             0x0c
+
+#define TRNG_RESEED         0x40
+
+struct PhytiumE2000RNGState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    uint32_t control;
+    uint32_t mode;
+};
+
+static bool phytium_e2000_rng_enabled(PhytiumE2000RNGState *s)
+{
+    return s->control & TRNG_CR_RNGEN;
+}
+
+static uint64_t phytium_e2000_rng_read(void *opaque, hwaddr offset,
+                                       unsigned int size)
+{
+    PhytiumE2000RNGState *s = opaque;
+    uint32_t value;
+
+    switch (offset) {
+    case TRNG_CR:
+        return s->control;
+    case TRNG_MSEL:
+        return s->mode;
+    case TRNG_SR:
+        /*
+         * Generation takes zero virtual time, so DRDY is reasserted as soon
+         * as the guest acknowledges the previous batch.
+         */
+        return phytium_e2000_rng_enabled(s) ? TRNG_SR_DRDY : 0;
+    case TRNG_DR:
+        if (!phytium_e2000_rng_enabled(s)) {
+            return 0;
+        }
+        qemu_guest_getrandom_nofail(&value, sizeof(value));
+        return value;
+    case TRNG_RESEED:
+        return 0;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: read from invalid offset 0x%" HWADDR_PRIx "\n",
+                      DEVICE(s)->canonical_path, offset);
+        return 0;
+    }
+}
+
+static void phytium_e2000_rng_write(void *opaque, hwaddr offset,
+                                    uint64_t value, unsigned int size)
+{
+    PhytiumE2000RNGState *s = opaque;
+
+    switch (offset) {
+    case TRNG_CR:
+        s->control = value & TRNG_CR_MASK;
+        break;
+    case TRNG_MSEL:
+        s->mode = value & TRNG_MSEL_PRNG;
+        break;
+    case TRNG_SR:
+        break;
+    case TRNG_DR:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: write to read-only data register\n",
+                      DEVICE(s)->canonical_path);
+        break;
+    case TRNG_RESEED:
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: write to invalid offset 0x%" HWADDR_PRIx "\n",
+                      DEVICE(s)->canonical_path, offset);
+        break;
+    }
+}
+
+static const MemoryRegionOps phytium_e2000_rng_ops = {
+    .read = phytium_e2000_rng_read,
+    .write = phytium_e2000_rng_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned = false,
+    },
+};
+
+static void phytium_e2000_rng_reset(Object *obj, ResetType type)
+{
+    PhytiumE2000RNGState *s = PHYTIUM_E2000_RNG(obj);
+
+    s->control = 0;
+    s->mode = 0;
+}
+
+static const VMStateDescription phytium_e2000_rng_vmsd = {
+    .name = TYPE_PHYTIUM_E2000_RNG,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(control, PhytiumE2000RNGState),
+        VMSTATE_UINT32(mode, PhytiumE2000RNGState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void phytium_e2000_rng_init(Object *obj)
+{
+    PhytiumE2000RNGState *s = PHYTIUM_E2000_RNG(obj);
+
+    memory_region_init_io(&s->iomem, obj, &phytium_e2000_rng_ops, s,
+                          TYPE_PHYTIUM_E2000_RNG,
+                          PHYTIUM_E2000_RNG_MMIO_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+}
+
+static void phytium_e2000_rng_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    dc->desc = "Phytium E2000 random number generator";
+    dc->vmsd = &phytium_e2000_rng_vmsd;
+    rc->phases.enter = phytium_e2000_rng_reset;
+}
+
+static const TypeInfo phytium_e2000_rng_info = {
+    .name = TYPE_PHYTIUM_E2000_RNG,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(PhytiumE2000RNGState),
+    .instance_init = phytium_e2000_rng_init,
+    .class_init = phytium_e2000_rng_class_init,
+};
+
+static void phytium_e2000_rng_register_types(void)
+{
+    type_register_static(&phytium_e2000_rng_info);
+}
+
+type_init(phytium_e2000_rng_register_types)
diff --git a/include/hw/misc/phytium_e2000_rng.h b/include/hw/misc/phytium_e2000_rng.h
new file mode 100644
index 0000000000..d8c73e20a9
--- /dev/null
+++ b/include/hw/misc/phytium_e2000_rng.h
@@ -0,0 +1,23 @@
+/*
+ * Phytium E2000 random number generator
+ *
+ * Copyright (c) 2026 Process Mission
+ *
+ * Author:
+ *   Bin Meng <bin.meng@processmission.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_PHYTIUM_E2000_RNG_H
+#define HW_MISC_PHYTIUM_E2000_RNG_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_PHYTIUM_E2000_RNG "phytium-e2000-rng"
+OBJECT_DECLARE_SIMPLE_TYPE(PhytiumE2000RNGState, PHYTIUM_E2000_RNG)
+
+#define PHYTIUM_E2000_RNG_MMIO_SIZE 0x1000
+
+#endif
-- 
2.53.0


