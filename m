Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A082DC79FB0
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 10:44:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3tHq-000872-SF; Tue, 08 Sep 2026 06:42:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x3tHp-000860-4y; Tue, 08 Sep 2026 06:42:45 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x3tHn-0006ZW-8N; Tue, 08 Sep 2026 06:42:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sZ6/FJujGwFUejF2M59hLKq2xTITQ86bnRUVHVOEhU7vSsZ5QcXv26k5lpT/+JFLnE3Yc84epTdQ4lFd7Iv7VvV3JI44D6Bp8qzhE1s39mhWbk4oBp1sYfcdgGGi9Ztwr2aeWZH6lWO/dbE1i9282iztTGtRX9RGGo2stcWDzccrwKUBtmUGzvc0ldB4WsfDGKGjl5/ap4p/y/MpzuU+n/gS6X/eNpYVg2GSO5LEa50zCG8jEiS8/FXIZuo924GuvESYuwANFP/pTTlJHWW5nEJF5Uqpg7T7+WbWsQb5JEsXR8/ggwqqQ+WxmDlOfPFoNAoa+Qk1l/R1vT0PIkXmDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b6P05mNi/hQKhzpbNsx9HGXCq0bljxwls4xnUFAAMvk=;
 b=J9cL5dz3z/iWL2xZlHIcFCftzpDIPxigy2M48xaaDfwTkW4xOHNr1POu8VyADXxZ1/IlAdBa8owVj/SXG1jJu1kWUcib+NWze5a/XPoQvgdsV1DpBkBDuwy6eJhC3VQSdCJUtUoqChIf4scT8SugCZfT2/2dZkM8gCJ4ZzOgfR3ehn/7Zl6syyC9jDg7k/6Q43QqI6YwbLaPkwRK2DBHWnKytDfWMdxTAT/adxBQagoRWUazp01DM123X1W9PPakFJTLevPk2BUiILk0ygkFI091pF1v8QtYbNj4w5KUuLUPy6bjf6HqdJy2uO93b9+DumMfk5hZwTdg2cWXSIHANA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6P05mNi/hQKhzpbNsx9HGXCq0bljxwls4xnUFAAMvk=;
 b=tYl/z6EzsH3BmCbVviCcTWvF3T+jzDnk7IjGKKQQaP6BCXvf9/wlL4cYUfJ21QmuBUAfUSGuFvRkrGJtLEQu2ANAieceh8rzVOsrIciL+XR1oYRm0kc6KDApZ1t5upxA4fzQuKQ3su1H9M8FcuNbzMJN/i+FnyK37rqecvreAar3F7JisMSglnZRyENrOF3AeZBAdooShydeLQeqy2mNG7ovwFV372eRJkDwYQFcu6Llc2ET+Q7tObtlXi7Hi7nL/aWVvPBU3tTik6IBMTzh8tHyO+0IqmCvSzuZFWwDTuBMgNsjcEJP7S4+eXKQMNIpZeVq9+HiHgx4j5ed7gnDlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from PSAPR02MB4984.apcprd02.prod.outlook.com (2603:1096:301:78::7)
 by OSQPR02MB7928.apcprd02.prod.outlook.com (2603:1096:604:291::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 10:42:30 +0000
Received: from PSAPR02MB4984.apcprd02.prod.outlook.com
 ([fe80::fd75:bbda:6f27:c616]) by PSAPR02MB4984.apcprd02.prod.outlook.com
 ([fe80::fd75:bbda:6f27:c616%6]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 10:42:30 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v2 07/32] hw/arm: phytium: Connect Phytium E2000 GEM
 controllers
Date: Tue,  8 Sep 2026 18:41:16 +0800
Message-ID: <20260908104159.1621764-8-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908104159.1621764-1-bin.meng@processmission.com>
References: <20260908104159.1621764-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0041.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::15) To PSAPR02MB4984.apcprd02.prod.outlook.com
 (2603:1096:301:78::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR02MB4984:EE_|OSQPR02MB7928:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f2fe49b-614a-42f2-89eb-08df0d95e21b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|6133799003|18002099003|22082099003|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info: yjyxZD9nX5ZcaBZEqx25Oz7CCdZd1rPMnTeDrjJ3ZaMtbD03L9qw1wY8YoSAVFmzZwvn6kk2TkyoGuYHSeOeOETC+XZIgXvhAmzU1HD/LTUdPUGY7JKIN3OMB/F9UQKyJ1KuH0TZ0pMIYKB0799hZos+R14lkCNEu0LcEfvDxppu6oGegHHuv+C5HlZEzM2IGvSAdz5OLDRQJ1kSGgugPzkAz5oNmMhZc9PODcU6zfYmrS8Q3ddTR4+T2E9aRKW6hk3cG/YSFe+85tnR07wce7/jyfZFoR9skZA9rl9+HsgbwGE7wRXzxQYART5cXny9Z9mt3wWtIdsJNoo+ZlxVDo5loB7vFpXn3h9XaYLIQt7+WvNH0hrCGfGDDJMBRevd4C8RgCVAv8Y+y1x5Rb374hbtlrIVTfN41tdWCIunAYZBVRUeJ42sZ4+NBQOB0PH1+TNZ7ROQK3ven0oLV8QXZ8IXmGEybo6t0eVqNIzYM0HC1HyPFjsEVhHOMXW/xpVIDZJ4VwHBP9UxqlBiGXrw1u3EZz8WhzQtP40h0BCUpmJjVZ9/iORP5x7nNrK3tDRyfTtXc31IcvB8Je5+CcNhG7601N7RkLXzEqX5rTJnCgAwnv9AoVbnC+nt0feLPlZ/FH8s7W9vuTqd0mzUbSTLywrG/7QHIaQ9hfdIyitmQaE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PSAPR02MB4984.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(6133799003)(18002099003)(22082099003)(56012099006)(5023799004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KQwVyqJEfva31XNoFU4/zKJWfWdrYS/RKF1952QVFNb4mbolAaz4NxK7MoFT?=
 =?us-ascii?Q?rE3NiqkXhyxMmy5wrCgPAIbimhF+6gXqrXQlAVGj7vHtmK0tc88ONd215NFf?=
 =?us-ascii?Q?SI0rLhPl1Zc9pM8fg9dAkajDNTgCqaTgiXMi6Ap5y0Kid8oGgO2EcO0xEn1x?=
 =?us-ascii?Q?nxDSZhGhzdfUWpImuC+TK6BTXY6eJ3iYOO0jdT1a/ySwaMxZZlQOv1n0ObUv?=
 =?us-ascii?Q?MCD73NwauSyvc1fTpFceVejrHNv39vUpHab0HRa80up//pxMRHvbM2eFl8aD?=
 =?us-ascii?Q?GSkKh2RIYuK03i+QGnqfAYFY1bM3fw3kvn2OV/2aw+jkhNPwFVxQy7Zx+KoD?=
 =?us-ascii?Q?LrR44ZOmEQETyJerT30ZQ2cplvSrcqabbtvLBm2jDL1DUvrtOLE03ZN3K+ii?=
 =?us-ascii?Q?dK/B8gd8DuW97FzDs8wzwj6MhvcC/vrpqxlNjiQH0UryEzBmTyZYaeLG4Qw8?=
 =?us-ascii?Q?danG4V3R6YAeHVJoy0hLZnD4dPWEFd9s8mfmylGdMwdKqwnSPWdDrBjKhNq/?=
 =?us-ascii?Q?WsDGWF6M7GaDxfgIjMZrzMgk2Rv5X9FC2ZPAm0XuLu/QBC5AGU8/FFQ/SRnD?=
 =?us-ascii?Q?OnNyqdbR5M9Y8ooXfmaqTtQvBzmtWojaiYZDo/JSFXBla481dWKPRnR+YdNY?=
 =?us-ascii?Q?hetxzvwpfyBVrq1XkhNi1pEHtzNurYrwH41NpE1Q5NyO7hUCAGVY0B+9L3Q9?=
 =?us-ascii?Q?84WrIhhg+jmrnKt2NzYxKQ2dN5l2khcryKAF0NNmYxStx0IKFHw7jh9Yayuy?=
 =?us-ascii?Q?0nMZgeMV/8Ww8vzvmT19vrZwaxR197TCHy0qmsNNA9IhDYSCSvNmsYF0GJ2p?=
 =?us-ascii?Q?GNc7ekjmgwRxI2Q1sQvOtlirW3AJgTp5cPFY3jHni6gyIJ+UnmO9N32hhnJI?=
 =?us-ascii?Q?YZQ15sTEpOvCbAJ5qYTk9yqN0dI7rWsqtJ88aVr38FADMLGbGfoI8gEMHo19?=
 =?us-ascii?Q?7k/csSAORhj5EV5Yz2/c2AhE3ki+qdykUBKoA2I7Kq7GDAeqmMoYcCAvjADe?=
 =?us-ascii?Q?tP1ZVdJSTKD6q8y6ckhue6gh5uoEwlgzlkrbwwZ7QVF0Hjqv8ggsW4L/bC3s?=
 =?us-ascii?Q?JY2wRa5ljwoa79g7hf8oHbKzpC64mpKhfJp2TYso87gZjVGFc2mmCrufBfhh?=
 =?us-ascii?Q?GLqN1XWVv3lMRpxSwZvKeZXoJDvGA9AiXW+DeYddlm50VK0gPfnB+HaI5jlj?=
 =?us-ascii?Q?QSvBeboqqp2U1B2ySJVbK+CU54vJ9z1E6aLZex6qbmzMLcPXX+kswhJMMc8j?=
 =?us-ascii?Q?daqa/RCtILJGDJ/I2A5RUxhNVgYAi5XvOWTwxTu3LTbIke9kdpEZ16KQe0Q+?=
 =?us-ascii?Q?SalfwictQhq5gVp9ppwl1PESYyE8QEM77Dq4cQEbRz/SfnKp80Sc0ZyUkc0W?=
 =?us-ascii?Q?0Nwd7qWzFqqNK677DUJnEts/ryJPVDqC5YGSjQ8s88R/vHGqtBKV23gR17MH?=
 =?us-ascii?Q?WLy7LCLvRH0XnstOuQgO9ECnj8w31dcodaWHyis2kM1bVqeiBmJ7iA53OLLn?=
 =?us-ascii?Q?xZku70E1z/MjV8Px4o7T3daUvNHDqs8awtV5ccFnbCEIbhwR0x7ZKNXDVdeb?=
 =?us-ascii?Q?OIM9SCfhDi6pQWq++6m3FvZv7aoU27kVpStkVaMtSJfAKPwM7/nPOkDfl5Yg?=
 =?us-ascii?Q?4awzqgbqj9icSzGc1z/QgLGCQAHUy0NTEMDC9zSfnvR862vRUoCjhtVdn8U7?=
 =?us-ascii?Q?9L1rivp4kWHM2G5ok2jk6/qGYYWudOZaqZpty1LvOk3GD3BQ3BFRZEY+cnXX?=
 =?us-ascii?Q?mIZc5aYOy+OvjlRA5+kghhNtNP2eb8Y=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f2fe49b-614a-42f2-89eb-08df0d95e21b
X-MS-Exchange-CrossTenant-AuthSource: PSAPR02MB4984.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 10:42:30.5525 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HiYKn68FgwseOlGODR27WM5s7U0wG4IaygmZkvPusSccQ1YSiiy/ctLnPeThCCyQhTNC0SLWdyX+8Djjqanqi+MrlPNJD1HDtebFn+P4OO4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR02MB7928
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

Instantiate all four standard Cadence GEM controllers described by the
E2000 SoC device tree. The generic model implements the first 0x800
bytes of each 0x2000-byte E2000 aperture, so cover the complete window
with a low-priority unimplemented region and map the Cadence registers
on top. This accepts accesses to the SoC-specific clock and SerDes
selectors without inventing their behavior.

Connect eight queue interrupts for GEM0 and four for GEM1 through GEM3,
and configure the PCS, MDIO PHY address and 16360-byte jumbo limit
expected by the SDK drivers.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

Changes in v2:
- Move GEM controllers and placeholder regions into the E2000 SoC

 include/hw/arm/phytium_e2000.h |  7 ++++
 hw/arm/phytium_e2000.c         | 59 ++++++++++++++++++++++++++++++++++
 hw/arm/Kconfig                 |  1 +
 3 files changed, 67 insertions(+)

diff --git a/include/hw/arm/phytium_e2000.h b/include/hw/arm/phytium_e2000.h
index e759d71746..a948c54f2c 100644
--- a/include/hw/arm/phytium_e2000.h
+++ b/include/hw/arm/phytium_e2000.h
@@ -14,6 +14,7 @@
 
 #include "hw/arm/boot.h"
 #include "hw/core/sysbus.h"
+#include "hw/net/cadence_gem.h"
 #include "hw/sd/phytium_e2000_mci.h"
 #include "qemu/typedefs.h"
 #include "target/arm/cpu.h"
@@ -23,6 +24,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(PhytiumE2000SoCState, PHYTIUM_E2000_SOC)
 
 #define PHYTIUM_E2000_NUM_CPUS 4
 #define PHYTIUM_E2000_NUM_MCIS 2
+#define PHYTIUM_E2000_NUM_GEMS 4
 
 enum {
     PHYTIUM_E2000_LOW_PERIPH,
@@ -42,6 +44,10 @@ enum {
     PHYTIUM_E2000_PCIE_CTRL,
     PHYTIUM_E2000_PCIE_PHY_CTRL,
     PHYTIUM_E2000_BOARD_CTRL,
+    PHYTIUM_E2000_GEM0,
+    PHYTIUM_E2000_GEM1,
+    PHYTIUM_E2000_GEM2,
+    PHYTIUM_E2000_GEM3,
     PHYTIUM_E2000_BOOT_IACC,
     PHYTIUM_E2000_PCIE_ECAM,
     PHYTIUM_E2000_PCIE_PIO,
@@ -58,6 +64,7 @@ struct PhytiumE2000SoCState {
 
     DeviceState *gic;
     PhytiumE2000MciState *mci[PHYTIUM_E2000_NUM_MCIS];
+    CadenceGEMState *gem[PHYTIUM_E2000_NUM_GEMS];
     ARMCPU cpu[PHYTIUM_E2000_NUM_CPUS];
     unsigned int num_cpus;
 };
diff --git a/hw/arm/phytium_e2000.c b/hw/arm/phytium_e2000.c
index c618065ffe..da8313d61f 100644
--- a/hw/arm/phytium_e2000.c
+++ b/hw/arm/phytium_e2000.c
@@ -22,9 +22,11 @@
 #include "hw/intc/arm_gicv3_common.h"
 #include "hw/intc/arm_gicv3_its_common.h"
 #include "hw/misc/unimp.h"
+#include "hw/net/cadence_gem.h"
 #include "hw/pci/pci.h"
 #include "hw/pci-host/gpex.h"
 #include "hw/sd/sd.h"
+#include "net/net.h"
 #include "qobject/qlist.h"
 #include "qom/object.h"
 #include "target/arm/cpu.h"
@@ -62,6 +64,10 @@ const MemMapEntry phytium_e2000_memmap[] = {
     [PHYTIUM_E2000_PCIE_CTRL] =      { 0x31000000, 0x00200000 },
     [PHYTIUM_E2000_PCIE_PHY_CTRL] =  { 0x31500000, 0x00001000 },
     [PHYTIUM_E2000_BOARD_CTRL] =     { 0x31800000, 0x01400000 },
+    [PHYTIUM_E2000_GEM0] =           { 0x3200c000, 0x00002000 },
+    [PHYTIUM_E2000_GEM1] =           { 0x3200e000, 0x00002000 },
+    [PHYTIUM_E2000_GEM2] =           { 0x32010000, 0x00002000 },
+    [PHYTIUM_E2000_GEM3] =           { 0x32012000, 0x00002000 },
     [PHYTIUM_E2000_BOOT_IACC] =      { 0x38000000, 0x08000000 },
     [PHYTIUM_E2000_PCIE_ECAM] =      { 0x40000000, 0x10000000 },
     [PHYTIUM_E2000_PCIE_PIO] =       { 0x50000000, 0x00f00000 },
@@ -86,6 +92,16 @@ static const int phytium_e2000_uart_irqmap[] = {
     [6] = 107,
 };
 
+static const uint8_t phytium_e2000_gem_num_queues[] = { 8, 4, 4, 4 };
+
+static const int
+phytium_e2000_gem_irqmap[PHYTIUM_E2000_NUM_GEMS][MAX_PRIORITY_QUEUES] = {
+    [0] = { 55, 56, 57, 58, 28, 29, 30, 31 },
+    [1] = { 59, 60, 61, 62 },
+    [2] = { 64, 65, 66, 67 },
+    [3] = { 68, 69, 70, 71 },
+};
+
 static const int phytium_e2000_pcie_irqmap[PCI_NUM_PINS] = {
     [0] = 4,
     [1] = 5,
@@ -298,6 +314,45 @@ static void phytium_e2000_create_unimplemented_region(
                             phytium_e2000_memmap[map_idx].base, -1000);
 }
 
+static void phytium_e2000_create_gem(PhytiumE2000SoCState *s, int index)
+{
+    DeviceState *dev = qdev_new(TYPE_CADENCE_GEM);
+    CadenceGEMState *gem = CADENCE_GEM(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    g_autofree char *name = g_strdup_printf("gem%d", index);
+    g_autofree char *unimp_child =
+        g_strdup_printf("gem%d-unimplemented", index);
+    g_autofree char *unimp_name =
+        g_strdup_printf("phytium-e2000.gem%d-unimplemented", index);
+    int map_idx = PHYTIUM_E2000_GEM0 + index;
+    hwaddr base = phytium_e2000_memmap[map_idx].base;
+    int i;
+
+    s->gem[index] = gem;
+    object_property_add_child(OBJECT(s), name, OBJECT(dev));
+
+    qemu_configure_nic_device(dev, true, name);
+    qdev_prop_set_uint8(dev, "phy-addr", 0);
+    qdev_prop_set_uint8(dev, "num-priority-queues",
+                        phytium_e2000_gem_num_queues[index]);
+    qdev_prop_set_uint16(dev, "jumbo-max-len", 16360);
+    qdev_prop_set_bit(dev, "pcs-enabled", true);
+
+    /*
+     * The E2000 exposes a 0x2000-byte aperture, while the generic Cadence
+     * model implements the first 0x800 bytes. Catch accesses to the remaining
+     * SoC-specific registers without inventing their clock and SerDes effects.
+     */
+    phytium_e2000_create_unimplemented_region(
+        s, unimp_child, unimp_name, map_idx);
+    sysbus_realize_and_unref(sbd, &error_fatal);
+    sysbus_mmio_map(sbd, 0, base);
+    for (i = 0; i < phytium_e2000_gem_num_queues[index]; i++) {
+        sysbus_connect_irq(sbd, i,
+            qdev_get_gpio_in(s->gic, phytium_e2000_gem_irqmap[index][i]));
+    }
+}
+
 /* The vendor DT maps root-bus INTx solely by pin */
 static int phytium_e2000_pcie_map_irq(PCIDevice *pdev, int pin)
 {
@@ -535,6 +590,10 @@ static void phytium_e2000_soc_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < PHYTIUM_E2000_NUM_UARTS; i++) {
         phytium_e2000_create_uart(s, i);
     }
+    for (i = 0; i < PHYTIUM_E2000_NUM_GEMS; i++) {
+        phytium_e2000_create_gem(s, i);
+    }
+
     phytium_e2000_create_pcie(s);
 }
 
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 8b865e4e30..d9759731f0 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -132,6 +132,7 @@ config PHYTIUM_E2000
     depends on TCG && AARCH64
     imply PCI_DEVICES
     select ARM_GIC
+    select CADENCE
     select DW_MCI
     select PCI_EXPRESS
     select PCI_EXPRESS_GENERIC_BRIDGE
-- 
2.53.0


