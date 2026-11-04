Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DF7606A31B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 15:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=fg2nu9kO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOd8a-0001h7-KS; Wed, 04 Nov 2026 10:42:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOd8Y-0001e4-EO; Wed, 04 Nov 2026 10:42:54 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOd8W-0001DQ-28; Wed, 04 Nov 2026 10:42:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X6pwhn97X2r6O9L+eTGMePQaURZaqLJ2c8+JGJQCWZtWP0suq9Uf2XdoIfyQxGbSjI5q2mNaD7vuiJv0IwJYPeUTn0Egsf0xPlADzNgeOuDq9q6d22XTpwTmOynRlT9JJ7+ZjIOE1VbXhy/wddUAEH3lOtdAhfXjcsuSGyntuN/Gks/+PmOfXDo7oa1qUviqJ7MWG9fHNL2P2v1D8MvQI2jGL5k3vFQ7sDu2Le4aTBjKrivDEZklMVlnhe4p8Vri6AA0L/VhieEuc7Rf10pT7YnJM0I63nk/nv+REgBtOLSWrKGq+2cMC+cYLQHIpY+2W1jZRX4qROF2EfdchV+Mng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9gu/PK1cPylCp+f8704eBe4Y9sNKMe/5wuiU2TwyrpE=;
 b=Fe5ZCzcp56LdciB3rWqIkDZhRxSnnz78xJteXm+cGoVlarEweuhmoyi8Wh8o/ixnxKrIce89Pk0mk77Fusruyy8fc7eYi7+XdDbgeN6jLrpJC3Mq+wMT1kP6P8s375a7N4oF2n/QeQ6YQeEY634ujVxLNGhd0TSDGWwOGYDqttRteF3oz8BMSrBaqpIzzI2vKmGyM8BwNfSzHTIcbVLmB2zGVdXSicHeLjzl+EnHnZbsUAWbMsavvWl2lVVaEvbIc0CNPtnoGQTwDyQUUN6DregKYHIDRfTjHSjadpKjQe1lx9uUKJoOlbz5nu8ys3PlWRz0ZbJoUYfm2BR+nSBLYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9gu/PK1cPylCp+f8704eBe4Y9sNKMe/5wuiU2TwyrpE=;
 b=fg2nu9kO2M4CI3KRfK/MSGjmFY8N4zyucEf82T9/m4ouEbhBNWLF3OLc2knW5/I+76+icwMT11OUDGMFyCa2+dGtdonRGqYXdHwDqTyWfCO6MJsFOkrO5di+1giFypWR5AcqJvNaaZK++ZDeSa6U8byHiTpllMY4AusGYpO5XkI5G2as0tQZS7iqSP0eH3GrMDAZ1tKM5NbgIOUR3uOs9zrKPWZNWbklUIR4RuGL2VfRTww3bp1DbXl3ulLJwEwvxoO9us91QSwMBjVOgbHgXlVDOI0BoKpqCRHwGH5wQ3zi2RUX5M2NUUBGiREJpv0cOhAIhMGVS2VpqL4Jk5CO4A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com (2603:1096:405:2c::12)
 by SEYPR02MB9159.apcprd02.prod.outlook.com (2603:1096:101:302::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 15:42:44 +0000
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10]) by TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 15:42:44 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Wadim Mueller <wafgo01@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-block@nongnu.org
Subject: [PATCH v5 10/26] tests/qtest: add Cadence SDHCI ADMA pacing/MMIO
 reproducer
Date: Wed,  4 Nov 2026 23:41:37 +0800
Message-ID: <20261104154207.641511-11-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: b1848442-436a-448f-ac80-08df3a8a4471
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|261022115727099003|260925022911599003|260925021311599003|260925021911599003|261022113327099003|5023799004|56012099006|261021123027099003|261022075727099003|261021121427099003|261009223027099003|261102123227099003|261022105027099003|261028144727099003|261026140227099003|261026121527099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: LRxaUe35HkY7EFRVp1eXjdfuBM/cfkQCUc2AQRxiFtdvER9ATc35TBmTJj/qHV9465l1/B9WTFgVl2T4cTlqVUhNVSwQWEV5th+0kKBsn7CxsDrKXzUqbxZMxVZzdECZSPqS5NNj7sDMw4fX/6gKE1/17/wAT6Xznx4yXBaG1NFvlT0d2jgBi0NOqtLuPV1nL+vfgGInqhpZf/I2CUIC90/+JHg6y6ieghvZDnRyXkV2F5ZKs1wedx+QJ5h5GeRwFltGbmCg//ACSwi7/FBJbKyl5SrV1EtaixQJdrCC/9XghyhozwTBp17fhXbZA3m93YhC+2NEa6xhFHdtzetD7jJlSL9J8oCydagx7RSXiE4tUjpvZKAZZNNCnG19vowNWGQBmnu4x7tKkqn/CDXGaC5ulEN60VIeBRIOEjMPb+UFniqYd60ncvFSxxSBVEktw3Sw5YsVHUkeRc6SnDabkekul0sraF3W2AQ5CbffAjRd1kaJ+W7LVI/HNUCtrw5dlXSqXFxeJF07Bcq4vArEIDze5rRrB4vYsVSJgWIBpvvZ5VZhN9oc7Ey6dOytQeOv+3QiKwL57KsWcsfvHqe0Gbfq35x4im4H09yJA3f0ThSyh/WP4BTbC3jMGPj43Oo13vDpPNu5zaower3/w6Y8sqDvHD4tNPYx3GCnvDQWYsg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR02MB7121.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(261022115727099003)(260925022911599003)(260925021311599003)(260925021911599003)(261022113327099003)(5023799004)(56012099006)(261021123027099003)(261022075727099003)(261021121427099003)(261009223027099003)(261102123227099003)(261022105027099003)(261028144727099003)(261026140227099003)(261026121527099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NlVlZjb7tV9fsdgKBv+OM7xhm2hV/e4FcqTU02vmpUvFwn5ttgLT5Eti0Gd+?=
 =?us-ascii?Q?pxho/cVc/z1hBG/2NkfQk4aQy3PCWgm+/9ZZNVSlxbLt0OjJJ2GL3HeiFjUB?=
 =?us-ascii?Q?/iIUe4R0zxSL6GSv/uleNNP2BV7dZ+eLYAbYx+gBoRXonEfQfOvPy5wRd7dZ?=
 =?us-ascii?Q?Z6rAUh5J6ONovoatDQSWBgfyibqxs3A8d3G5GkJyZCNN2vi+2CsrgdbpRJCJ?=
 =?us-ascii?Q?7x8l5iH4037CPR3SR0On8vl01CffYdvOV1JzDF+DSrkiVZwbaj5gKn6s0vmW?=
 =?us-ascii?Q?Vknp2w4w0S97rNRkbLJDWK9KIPtK3V0SYh5wGW/9TW7hMZF1s8JmtFD4g1V4?=
 =?us-ascii?Q?uAu9tODkHkCWiIPxDHwwx4ljVJrvr04nUTy3RWZcsEeNjrsJVxi0imKlefM6?=
 =?us-ascii?Q?TDKQc9YUDLZ/kvxevrJ3Sb0nkHoRzSaWRlQxAJ88ZO+Zi76/Z/Hgy+SOZRVz?=
 =?us-ascii?Q?/Ue9nK24vRmbXgwkYtkRIrHG9u4gN9fKaUZXVQD/tV42yIczXvR4WpfiI9aA?=
 =?us-ascii?Q?CorAYjL8BQusUfj91s+IAJujB4+pZR4epSWXkPlIdgJ1Hl/lvDBkWyjFFzwU?=
 =?us-ascii?Q?c3DJ/FcBqhZSxVyreZVAECigl2QFZknvYY+6zrwf/5di4Bfn1pbVzN5eYsoh?=
 =?us-ascii?Q?940X+MliZkTFSmGUnRbzedlAgTeb5X7oRENctWjWomlKpoUpgqixlGXY+5VQ?=
 =?us-ascii?Q?aa1g//RWRLAsLAAho8vgbqeOhszf+g+CNEUKQ8g0AB31R1ey7GT89hPMl39B?=
 =?us-ascii?Q?Hc0uSUZXFTP+tMv8YExJdo19PN3JUzKC9iFPXAu3ijKBoXZ4wJwSWTnh25ic?=
 =?us-ascii?Q?fEDSh3O+iqFs9zSQE8aXyEAHPyj06Ky4daYiWoE3cvqjoDbtXG08+R36bhDR?=
 =?us-ascii?Q?QG+CwxeX9M/50GXc/uLv2HflfFLmv8d5A8Wrm1SFZSE2NT96cHE+fG4FTmfW?=
 =?us-ascii?Q?3vhapeITvoL/ENsP+gyB5OKas+PpUKy4y9/OrDMuv3oVWJcbe44QgQ1tnwqP?=
 =?us-ascii?Q?6q9r4EjDLh3+1M67FQcBkxqKz2ShEIv3jLv79+AJLVi10X1ARSClFFyYQC1S?=
 =?us-ascii?Q?HxzT4TVF69Ev3jIBN5pwTKY2475ZpGQRFyGGPSggyxo3zs8oJBcQ9TNZJmw8?=
 =?us-ascii?Q?RnMIuaCo2U73ufa3Fyq17gnfFu+AGxJXDpmE+sddIrDQ0QgQG0wcBPzpdo2X?=
 =?us-ascii?Q?dzed9sGOdaJ3B5fWRD495IgOm/XdlW46245YXUyoKGqpgd+l/4jVRszr88Z+?=
 =?us-ascii?Q?GnYC9vWHgt97hKSxeHJA0V0VI+E4CgFvW8WMS8k0rdlt8gMwTGGwE4NtBWAI?=
 =?us-ascii?Q?EmS0+V9oUiAtLmjsh5j3jERHQUdayget9G/9Zf/3KQp2Ka4Jag09O4V1px5D?=
 =?us-ascii?Q?oCXtvdBE4z0srzbEKVr3H6dI1nMZGcwc/nMyeBHfe8WhK8zkmMP+ggdNQtYb?=
 =?us-ascii?Q?JV1xAKXn8hMeYNF/vZCKLcayWRnPGlBxaMrvFborI55ie8pKoRQy/2jqvLg4?=
 =?us-ascii?Q?htaOSiJpUJEvvd19jWTBOmGZm4x64l5ji85KVdlcK9U37wctcmLyOzUjB97e?=
 =?us-ascii?Q?hhgRSwMHJtS4nWRD1fa1z40nXqdOHxzKHpx7nwgy7h2LXtqfJepPU0DFMZy0?=
 =?us-ascii?Q?4sSfPT17NjKw/yrSRgh4tvKjxubrWQKgJY1hqOkYIGpnsTnBtXu7o4Dcal8B?=
 =?us-ascii?Q?0L8PPnVqdcvyddgljuWlH6MW2qCKNgImpgxGMMkBHgJcdn1do/ymFDqa30gF?=
 =?us-ascii?Q?ttn83D+vEgZ+UyrmAX2KBtiRHUdHNa8=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1848442-436a-448f-ac80-08df3a8a4471
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7121.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 15:42:43.9711 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WMpwww6/w5RXYyIgLlTuhTPYvknvjYNCONlqdRHhKIQJQd6m8ADXf/ZNlFjDf+AfujnEmFxRr8fcmeA1MNnt6aUYirorMEnvsfl1RQ9/O3k=
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Wadim Mueller <wafgo01@gmail.com>

Add an image-free qtest for the microchip-icicle-kit machine that drives
the generic SDHCI model (hw/sd/sdhci.c) through the Cadence wrapper
(hw/sd/cadence_sdhci.c, SRS window at 0x20008200) directly over MMIO
under "-accel qtest", where QEMU_CLOCK_VIRTUAL only advances when the
test steps it.

It reproduces two aspects of the ADMA2 engine objectively, without any
guest firmware:

  1. Pacing: a 12-descriptor (> SDHC_ADMA_DESCS_PER_DELAY) non-interrupt
     ADMA2 CMD18 read completes after a model-dependent number of
     SDHC_TRANSFER_DELAY virtual-clock steps, which the test reports.

  2. MMIO coupling: a chain carrying a DMA-boundary interrupt descriptor
     yields mid-chain and reschedules on the virtual clock. With the
     clock frozen, an interrupt-status read must not itself resume or
     complete the transfer. This asserts the behaviour intended by "Run
     ADMA independently of MMIO": it passes on the fixed model and fails
     on a model that resumes ADMA from an MMIO read.

The SD bring-up (CMD0/CMD8/ACMD41/CMD2/CMD3/CMD7/CMD16) and the ADMA2
descriptor-table layout mirror the pattern already used by the SDHCI
device model; SDHCI register offsets and ADMA attribute bits are
reproduced locally because sdhci-internal.h is not standalone-includable
from a qtest.

Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
[bmeng: strengthen checks, reuse SDHCI helpers, verify data]
Signed-off-by: Bin Meng <bin.meng@processmission.com>


---

(no changes since v2)

Changes in v2:
- Assert bounded ADMA pacing and MMIO-independent progress
- Reuse existing SDHCI definitions and command helpers
- Verify transferred data against a known image pattern
- New

 MAINTAINERS                      |   1 +
 tests/qtest/cadence-sdhci-test.c | 282 +++++++++++++++++++++++++++++++
 tests/qtest/meson.build          |   2 +
 3 files changed, 285 insertions(+)
 create mode 100644 tests/qtest/cadence-sdhci-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 4bef2dffb0..3c305d570f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2462,6 +2462,7 @@ F: include/hw/sd/sd*
 F: hw/sd/core.c
 F: hw/sd/sd*
 F: hw/sd/ssi-sd.c
+F: tests/qtest/cadence-sdhci-test.c
 F: tests/qtest/fuzz-sdcard-test.c
 F: tests/qtest/sdhci-test.c
 F: tests/qtest/xilinx-zynq-sdhci-test.c
diff --git a/tests/qtest/cadence-sdhci-test.c b/tests/qtest/cadence-sdhci-test.c
new file mode 100644
index 0000000000..71c1e53333
--- /dev/null
+++ b/tests/qtest/cadence-sdhci-test.c
@@ -0,0 +1,282 @@
+/*
+ * QTest for Cadence SDHCI ADMA2 pacing / MMIO coupling on the Microchip
+ * PolarFire SoC Icicle Kit (microchip-icicle-kit).
+ *
+ * Drives the generic SDHCI model (hw/sd/sdhci.c) through the Cadence wrapper
+ * directly over MMIO under "-accel qtest", where QEMU_CLOCK_VIRTUAL only
+ * advances when the test steps it; no guest firmware runs.
+ *
+ * Copyright (c) 2026 Wadim Mueller <wafgo01@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/sd/sdhci.h"
+#include "hw/sd/sdhci-internal.h"
+
+#include "libqtest.h"
+#include "libqos/sdhci-cmd.h"
+
+/*
+ * Use the controller definitions and command helper shared with the existing
+ * SDHCI qtests so this reproducer stays in sync with the device model.
+ */
+
+/* Cadence maps the generic SDHCI (SRS) register window at base + 0x200 */
+#define SDHCI_BASE        (0x20008000ULL + 0x200)
+
+/* Scratch in PolarFire DRAM (base 0x80000000): descriptor table + target */
+#define ADMA_TABLE_ADDR   0x82000000ULL
+#define ADMA_BUF_ADDR     0x82100000ULL
+
+#define BLK_LEN           512
+#define NDESC             12      /* > SDHC_ADMA_DESCS_PER_DELAY (5) */
+#define INT_DESC          5       /* ADMA interrupt descriptor */
+#define TRANSFER_SIZE     (NDESC * BLK_LEN)
+
+/* CMDREG response-type encodings (bits [1:0]) */
+#define RESP_NONE         0x0000
+#define RESP_R2           0x0001  /* 136-bit */
+#define RESP_R48          0x0002  /* 48-bit */
+#define RESP_R1B          0x0003  /* 48-bit with busy */
+
+#define ACMD41_ARG        0x40FF8000u   /* HCS + 3.3-3.6V window */
+#define CMD8_ARG          0x000001AAu   /* VHS 2.7-3.6V + check pattern */
+
+static void fill_pattern(uint8_t *buf, size_t len)
+{
+    for (size_t i = 0; i < len; i++) {
+        buf[i] = (i * 13 + 7) & 0xff;
+    }
+}
+
+static void write_pattern(int fd)
+{
+    g_autofree uint8_t *buf = g_malloc(TRANSFER_SIZE);
+    ssize_t written;
+
+    fill_pattern(buf, TRANSFER_SIZE);
+    written = pwrite(fd, buf, TRANSFER_SIZE, 0);
+    g_assert_cmpint(written, ==, TRANSFER_SIZE);
+}
+
+static void check_adma_data(QTestState *qts)
+{
+    g_autofree uint8_t *actual = g_malloc(TRANSFER_SIZE);
+    g_autofree uint8_t *expected = g_malloc(TRANSFER_SIZE);
+
+    fill_pattern(expected, TRANSFER_SIZE);
+    qtest_memread(qts, ADMA_BUF_ADDR, actual, TRANSFER_SIZE);
+    g_assert_cmpmem(actual, TRANSFER_SIZE, expected, TRANSFER_SIZE);
+}
+
+/* Issue an SD command and wait (bounded) for Command Complete */
+static uint16_t sd_cmd(QTestState *qts, uint8_t cmd, uint32_t arg,
+                       uint16_t flags)
+{
+    uint16_t sts = 0;
+    int i;
+
+    sdhci_cmd_regs(qts, SDHCI_BASE, 0, 0, arg, 0,
+                   ((uint16_t)cmd << 8) | flags);
+
+    for (i = 0; i < 1000; i++) {
+        sts = qtest_readw(qts, SDHCI_BASE + SDHC_NORINTSTS);
+        if (sts & SDHC_NIS_CMDCMP) {
+            break;
+        }
+    }
+    g_assert_cmphex(sts & SDHC_NIS_CMDCMP, ==, SDHC_NIS_CMDCMP);
+
+    qtest_writew(qts, SDHCI_BASE + SDHC_NORINTSTS, 0xffff);  /* w1c */
+    return sts;
+}
+
+/* Bring the SD card from idle to transfer state */
+static void sd_bring_up_card(QTestState *qts)
+{
+    uint32_t rca;
+
+    g_assert_cmphex(qtest_readl(qts, SDHCI_BASE + SDHC_PRNSTS) &
+                    SDHC_CARD_PRESENT, ==, SDHC_CARD_PRESENT);
+
+    qtest_writeb(qts, SDHCI_BASE + SDHC_SWRST, SDHC_RESET_ALL);
+    qtest_writew(qts, SDHCI_BASE + SDHC_CLKCON,
+                 SDHC_CLOCK_INT_EN | SDHC_CLOCK_SDCLK_EN);
+    qtest_writew(qts, SDHCI_BASE + SDHC_NORINTSTSEN, 0xffff);
+    qtest_writew(qts, SDHCI_BASE + SDHC_ERRINTSTSEN, 0xffff);
+    qtest_writew(qts, SDHCI_BASE + SDHC_NORINTSIGEN, 0xffff);
+
+    sd_cmd(qts, 0,  0x00000000, RESP_NONE);  /* GO_IDLE_STATE */
+    sd_cmd(qts, 8,  CMD8_ARG,   RESP_R48);   /* SEND_IF_COND */
+    sd_cmd(qts, 55, 0x00000000, RESP_R48);   /* APP_CMD */
+    sd_cmd(qts, 41, ACMD41_ARG, RESP_R48);   /* SD_SEND_OP_COND */
+    sd_cmd(qts, 2,  0x00000000, RESP_R2);    /* ALL_SEND_CID */
+    sd_cmd(qts, 3,  0x00000000, RESP_R48);   /* SEND_RELATIVE_ADDR */
+
+    rca = qtest_readl(qts, SDHCI_BASE + SDHC_RSPREG0) >> 16;  /* R6 */
+
+    sd_cmd(qts, 7,  rca << 16,  RESP_R1B);   /* SELECT_CARD */
+    sd_cmd(qts, 16, BLK_LEN,    RESP_R48);   /* SET_BLOCKLEN */
+}
+
+/*
+ * Build a 32-bit ADMA2 table: per 8-byte entry word0 = (len << 16) | attr,
+ * word1 = target address.  When int_desc >= 0 that descriptor also carries
+ * the ADMA descriptor interrupt attribute, so the model yields mid-chain
+ * (rescheduling on QEMU_CLOCK_VIRTUAL) instead of running to completion.
+ */
+static void build_adma_table(QTestState *qts, int int_desc)
+{
+    for (int i = 0; i < NDESC; i++) {
+        uint8_t attr = SDHC_ADMA_ATTR_VALID | SDHC_ADMA_ATTR_ACT_TRAN;
+        uint32_t addr = (uint32_t)(ADMA_BUF_ADDR + (uint64_t)i * BLK_LEN);
+
+        if (i == int_desc) {
+            attr |= SDHC_ADMA_ATTR_INT;
+        }
+        if (i == NDESC - 1) {
+            attr |= SDHC_ADMA_ATTR_END;
+        }
+        qtest_writel(qts, ADMA_TABLE_ADDR + (uint64_t)i * 8,
+                     ((uint32_t)BLK_LEN << 16) | attr);
+        qtest_writel(qts, ADMA_TABLE_ADDR + (uint64_t)i * 8 + 4, addr);
+    }
+}
+
+/* Program the ADMA2 engine, descriptor pointer and transfer geometry */
+static void program_adma_read(QTestState *qts)
+{
+    qtest_writeb(qts, SDHCI_BASE + SDHC_HOSTCTL, SDHC_CTRL_ADMA2_32);
+    qtest_writel(qts, SDHCI_BASE + SDHC_ADMASYSADDR, (uint32_t)ADMA_TABLE_ADDR);
+    qtest_writel(qts, SDHCI_BASE + SDHC_ADMASYSADDR + 4,
+                 (uint32_t)(ADMA_TABLE_ADDR >> 32));
+    qtest_writel(qts, SDHCI_BASE + SDHC_BLKSIZE, BLK_LEN | (NDESC << 16));
+    qtest_writew(qts, SDHCI_BASE + SDHC_TRNMOD,
+                 SDHC_TRNS_DMA | SDHC_TRNS_BLK_CNT_EN |
+                 SDHC_TRNS_READ | SDHC_TRNS_MULTI);
+    qtest_writel(qts, SDHCI_BASE + SDHC_ARGUMENT, 0);  /* start block 0 */
+    qtest_writew(qts, SDHCI_BASE + SDHC_NORINTSTS, 0xffff);
+    qtest_memset(qts, ADMA_BUF_ADDR, 0xa5, TRANSFER_SIZE);
+}
+
+/* CMD18 READ_MULTIPLE_BLOCK with data present -> kicks off ADMA */
+static void kick_cmd18(QTestState *qts)
+{
+    qtest_writew(qts, SDHCI_BASE + SDHC_CMDREG,
+                 (18 << 8) | SDHC_CMD_DATA_PRESENT | RESP_R48);
+}
+
+/* Start a card-carrying icicle machine and bring the card to "tran" */
+static QTestState *icicle_start(char **tmp)
+{
+    int fd;
+    GError *err = NULL;
+    QTestState *qts;
+
+    fd = g_file_open_tmp("icicle-sdhci-XXXXXX.raw", tmp, &err);
+    g_assert_no_error(err);
+    g_assert_cmpint(fd, >=, 0);
+    g_assert_cmpint(ftruncate(fd, 1 * 1024 * 1024), ==, 0);
+    write_pattern(fd);
+    close(fd);
+
+    qts = qtest_initf("-machine microchip-icicle-kit -accel qtest "
+                      "-display none -drive if=sd,file=%s,format=raw", *tmp);
+    sd_bring_up_card(qts);
+    return qts;
+}
+
+/*
+ * Facet 1 -- pacing.  A non-interrupt chain completes after a bounded number
+ * of SDHC_TRANSFER_DELAY steps.  With 12 descriptors and a quota of five per
+ * batch, completion requires exactly three virtual-clock steps.
+ */
+static void test_adma_pacing(void)
+{
+    char *tmp = NULL;
+    QTestState *qts = icicle_start(&tmp);
+    const int expected_steps = DIV_ROUND_UP(NDESC,
+                                            SDHC_ADMA_DESCS_PER_DELAY);
+    uint16_t sts;
+    int steps = 0;
+
+    build_adma_table(qts, -1);
+    program_adma_read(qts);
+    kick_cmd18(qts);
+
+    while (!((sts = qtest_readw(qts, SDHCI_BASE + SDHC_NORINTSTS)) &
+             SDHC_NIS_TRSCMP)) {
+        qtest_clock_step(qts, SDHC_TRANSFER_DELAY);
+        steps++;
+        g_assert_cmpint(steps, <=, expected_steps);
+    }
+
+    g_assert_cmpint(steps, ==, expected_steps);
+    g_assert_cmphex(sts & SDHC_NIS_TRSCMP, ==, SDHC_NIS_TRSCMP);
+    g_assert_cmphex(sts & SDHC_NIS_ERR, ==, 0);
+    check_adma_data(qts);
+
+    g_test_message("ADMA %d descriptors: %d clock steps to Transfer Complete",
+                   NDESC, steps);
+
+    qtest_quit(qts);
+    unlink(tmp);
+    g_free(tmp);
+}
+
+/*
+ * Facet 2 -- MMIO coupling (regression for "Run ADMA independently of MMIO").
+ * With the clock frozen, a bare interrupt-status read must not resume the
+ * transfer left pending by the mid-chain interrupt descriptor: Transfer
+ * Complete must still be clear.  A model that resumes ADMA from an MMIO read
+ * completes it on that bare read and fails the assertion.
+ */
+static void test_adma_mmio_coupling(void)
+{
+    char *tmp = NULL;
+    QTestState *qts = icicle_start(&tmp);
+    uint16_t sts;
+    int steps = 0;
+
+    build_adma_table(qts, INT_DESC);
+    program_adma_read(qts);
+    kick_cmd18(qts);
+
+    qtest_clock_step(qts, SDHC_TRANSFER_DELAY);
+    qtest_clock_step(qts, SDHC_TRANSFER_DELAY);
+
+    sts = qtest_readw(qts, SDHCI_BASE + SDHC_NORINTSTS);
+    g_assert_cmphex(sts & (SDHC_NIS_DMA | SDHC_NIS_TRSCMP), ==,
+                    SDHC_NIS_DMA);
+
+    sts = qtest_readw(qts, SDHCI_BASE + SDHC_NORINTSTS);
+    g_assert_cmphex(sts & (SDHC_NIS_DMA | SDHC_NIS_TRSCMP), ==,
+                    SDHC_NIS_DMA);
+
+    while (!((sts = qtest_readw(qts, SDHCI_BASE + SDHC_NORINTSTS)) &
+             SDHC_NIS_TRSCMP)) {
+        qtest_clock_step(qts, SDHC_TRANSFER_DELAY);
+        steps++;
+        g_assert_cmpint(steps, <, 1000);
+    }
+    g_assert_cmphex(sts & SDHC_NIS_ERR, ==, 0);
+    check_adma_data(qts);
+
+    g_test_message("ADMA coupling: %d clock steps to complete after bare read",
+                   steps);
+
+    qtest_quit(qts);
+    unlink(tmp);
+    g_free(tmp);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    qtest_add_func("/microchip/icicle/sdhci/adma-pacing", test_adma_pacing);
+    qtest_add_func("/microchip/icicle/sdhci/adma-mmio-coupling",
+                   test_adma_mmio_coupling);
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index a001409de2..d08fbc1eb7 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -317,6 +317,8 @@ qtests_riscv32 = \
 
 qtests_riscv64 = ['riscv-csr-test'] + \
   (unpack_edk2_blobs ? ['bios-tables-test'] : []) + \
+  (config_all_devices.has_key('CONFIG_MICROCHIP_PFSOC') ?
+   ['cadence-sdhci-test'] : []) + \
   (config_all_devices.has_key('CONFIG_SIFIVE_L2CC') ? ['sifive_l2cc_test'] : []) + \
   (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
    config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
-- 
2.53.0


