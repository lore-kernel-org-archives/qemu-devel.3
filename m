Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E81BBCC6B1D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 01:27:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGnk0-0005s7-94; Tue, 13 Oct 2026 21:25:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGnje-0005me-QT; Tue, 13 Oct 2026 21:24:52 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGnjc-0006vY-F1; Tue, 13 Oct 2026 21:24:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wZxBKP1oReuODuhjIujFxXiFhV1kTsDbXwqXJOokorI7Pp5leLdueWl5ZyhgiDHJz2UmDGq/wBOk7FpARSDiZv2yCjy4ncOE2K4HJVAAbNOI76RtVtpaMdL4IxcvFtezTPp24gKAqo5oLrBL5oNhO46TMxsologS6/8sl52/cmKn9oetaoIge2ejPiG68yvMkqA6wmHvTF1E5WjBWOtlpfrBEgauN8/XG8i0wEXr7Pf9lCjtKUUAjB2KqQsOJZqBgFGwQT0vemE2GZFV8QqzPzC3PKM52S1nnuKiJ09kgAPRuhKa/TG0za2kCfulKkDOIEwYhEvTJHYOPJWrDOOCRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ptKTNmPcNCKuxW70KmXI7j27gJCTxhu92faVWTurgo=;
 b=Is0LE3otJzz2/TttVJMaNFaw7FXu1sxELcvok9GpJnW8pn3ec1oJC3b8BQEpZFyFYi5ICvuYWKI363UsqQbJZodmvyEnaqabCIVQJLQNPbMQFKqeOsiyQNq/DMGimjgQKvkxAxp6fFKJAKa/N06WZXZOyLEOGTIi94Wn4QWAQ0CJOWuAxeBH7WuIGInJWzbm8cd8WqDdKpyQI4wjCo7aqZlfIwd2AiBd9bbqbuEAzGEHDNdRMji9VBROjAFTTcCue47CwXGrq41Sw/u//wbuKJHfXMoMXLdjwYtShenNVsPUJ/DiS6iZVu6xrk+DCog27854WTaOHim3rWP2ar8l5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ptKTNmPcNCKuxW70KmXI7j27gJCTxhu92faVWTurgo=;
 b=Pw/UYx8q/w6EhbeJLvaX0Y4hZdqtBqSia13yE9Uec/ysKtJ0pYukrQrJgT/9S0w5fX7tJVwpve4asxHL6Ys17enMyJioXkUuJflK5/YTI8NQW2to8wYP1MBCFXdhOmvF4fm3lgBA4HhZ9jit0YxD+4tquTU/VTIkDcSHMqr8Z26rN7/ZT4Bng/L9eSWoIybKMQsNJnFC9XEcliwnG4iLQ+Sq5EfNqst/BBfSsQidDmqWnA/wHg+wUrBcUTyr8nNQcFDFGRymdgiqV927PE2aw26gnmfRWZR4bgjbJ1K+8ux6GB8RPKrWiJVMWS4/pGWiHQaMp8npM8unVbrWUmKLhg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by KL1PR02MB6214.apcprd02.prod.outlook.com (2603:1096:820:9e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 01:24:29 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 01:24:29 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor@kernel.org>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>, qemu-riscv@nongnu.org
Subject: [PATCH v4 16/27] tests/qtest: Add PolarFire SoC RTC coverage
Date: Wed, 14 Oct 2026 09:22:56 +0800
Message-ID: <20261014012323.322790-17-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6e783c6d-75a7-44e2-3b42-08df2991e4c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|18002099003|22082099003|260925022911599003|10067099003|260925021311599003|260925021911599003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: gsfHW4z/fFvdOaBYaYcNbktxzvsGdWPn+1y4HYEMDQEFsvJ9aafsUCbuy3s9m3kLeGBe+ASPbjzlOdIw/dMFtBdW6eX9CbZ8PZqvxIpwruinl96TkXGLlxcgZCj4ZpgR2kAt97WECRONKWL2G+xNDRM28o0e9yU1KKiZkH4IMd2XHkt0JDaX6zvkWSfR/nocTQrBSn/deCcNESsKqSmIE7/VAZsMoKwEviDnh2iQEvt7a8D/CUaPh9qdpEYt3COcpDs2g1m3aOh6y9g1NAuixFxaatvyEPhZmHx1F++A50JY4RYobZXpDPWrZWFtT/gknQKktpXAPH5A/OP/bfwLQ1JarZLzMqyT5dvP/aEhy/Sieum7G72me8JG0jxTCTekv8iSiLY0lI/9B2mP1DJ+hPDz350xjQotqoYQtt8QlmA0eD2zJQzkxfhCjaWnvpqf20uItRAq8PiCff2t472pCBOof+v0VNZv3gnFqEN99x4Fqfn5u86cLj3ZvAABMrhsQ+byuyr5o1yfHNv6k53xHGy8DTVXm+J+rSnzMELqryC5/QfhgOsojKcMTWpzDh9DgUMtvt1dsvd2syb2Qafv8L4rbgYl8lghlz++oKZBJ5qxwl4NCfyIpLjqku6Ya/CQrWjTZkkCUYcu9jpTgP8SwiP4Lnw+hqBRDjaeaB0VlJQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(18002099003)(22082099003)(260925022911599003)(10067099003)(260925021311599003)(260925021911599003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bw4IbBYpgE58JnqMHKNSPd/NtyI76lnaBXFa+6CfUCrax7dP5sPY/hvEWimt?=
 =?us-ascii?Q?FUEFafHQo4TgGkLSjVNpsMNlprYqQ5YQVyzgEih6brVwhgvy8o2ohXrt4DOQ?=
 =?us-ascii?Q?cHAWk+fOrHcBr1QC1Q3Diw/jb1dJzj0v+9s0h5KiinUQ0rNRkGFDeIadWc5N?=
 =?us-ascii?Q?TFbyg5h5CbGcH9jjWepjbWiv27vMDWcMosut3HiTcDzHaX+glkuDhLPw9fni?=
 =?us-ascii?Q?HEDH6NTyIy4d4YVJxq2MdMR/MX67gPmmqJuEV1z5TB7zPQ4N960D0VVk6QOu?=
 =?us-ascii?Q?PHJTU04GcACmZtAHNWCTMkVo4IAO1D9ZQZCsZIdUJn7QGd+j8L/bfNeRU36L?=
 =?us-ascii?Q?gNZPil1eAsfyf8ep7jAa8yNdGwr111UDvksp6XsCNTslmckz5cX/yuaw2ufY?=
 =?us-ascii?Q?KP/DmgqxrdEivpmuCpGO/mVgq3EEscZZf0Xn3XRWKuM+NvLc2VIV5ztwlXwo?=
 =?us-ascii?Q?yNyDSSHSPpvcg7RqWwebpXMGcp+IJkiZWqB4vUVy7O/fwV80WpnqApOiPN07?=
 =?us-ascii?Q?IuNN57gwrjM1jpRPkdryr3uGAeTEeISPdcOY4cvy0JU1KnUhZ6xflAetQ8aL?=
 =?us-ascii?Q?orijmjQnDpLA1k/PP2m6L4nmZotfKJYRAi4REGXFFLNKJE4iNTPI/+EV/qJW?=
 =?us-ascii?Q?ojiRoVH2+SDtu+oY6f6ntyxDGYQJOuXZPKXXba093Ray/BeAQLmpqJJ6wCRr?=
 =?us-ascii?Q?3wtEbsTgBMiddFU6Nj/zwk8m5KcC21ESdV1tSehtDaAqsjqVr9d7wJ0P2IdZ?=
 =?us-ascii?Q?MD/FyYX6NYU0IJeRk4zB98fCgsptbrWa1iAdSjfDdF1njS1GUoJ6fgWU4zfY?=
 =?us-ascii?Q?dG46NhQAd1T1hlImfI/FB7adIEDnV+iaz4A3Xq+PWMUsN+DDa5FL06lxE2mn?=
 =?us-ascii?Q?pCq7EqGjmtmbVpZwMzx6AiSs12s54ykqsbT8+NK9wysuFpxeEbu5q/+gXxEi?=
 =?us-ascii?Q?s7YsZ3LQNEpuWQT2F2CcHASHLEeDHQcdWxf4u00efAhzpTgCdnKxzpEhTbjT?=
 =?us-ascii?Q?iaEAyaFM99IBJ9CLqJqJIJjijqBmLAOGXr+cGXXyRGPFpccuOE2KRPaFCwNe?=
 =?us-ascii?Q?wy+IPnX5e5qHUcZYF+doITyYHxJohVJyHet16jizDpAimGgCW6qhk1X9Iv+K?=
 =?us-ascii?Q?Yh0Fi308lEvgzizLSEOAA2eUmeJqPPl+kgN+xFa4QaEB0Z7AcMidOmsmpPA9?=
 =?us-ascii?Q?o3ezLnCd9KRxLZV1jSvi0ySouQsdN7Hi4JQHg1c6e1wc/XjhDtyFNE/l0Gp6?=
 =?us-ascii?Q?Irm70TsxMA6yvXbbC5a/l20MV+GnvvC4OjN4qR6yNhqhegj8+A8zU1ybflwv?=
 =?us-ascii?Q?8oY/SFfFd01b3QkRPFPgPvFsh8/e72LD8qAgx/OEILY4jpp4H9yrzJ/udcui?=
 =?us-ascii?Q?EpMBAZXL15ufxVqZ7UmSYZGSductrSfhcKDGVNF3b0U2Gz6+38T59HiwrI8F?=
 =?us-ascii?Q?szxo550bBgfqDf3OwARrbnom1c4Ztx5ZWvRKu79Gg2JKbFeFhEwyVmbNiYvA?=
 =?us-ascii?Q?nsJe0iDhU8f7RqBIjkfgfshA4B9nug/RX5abZR4xGpZmpBrT4ihJM9P4uflx?=
 =?us-ascii?Q?9otIHwRxu3QZ8NWabGvnVAEnGdEuvAnkfUG7SclbVJQwialx43xCuJHxQCPz?=
 =?us-ascii?Q?3/FtCbTIPudD/wotjz+CVfbeZl/DwDtuz9G5MDKfq0fVYwdieFHiJufjXSY5?=
 =?us-ascii?Q?2pAxVvRXiIYlhWa+kDY9mYiYQP2NrZpNFat3mOefo87AbMnVCiLC0MLwyg1d?=
 =?us-ascii?Q?ZbJMIWAd+3b1GcODtMI3KjQxDPkBjII=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e783c6d-75a7-44e2-3b42-08df2991e4c7
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 01:24:29.6870 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EKue6F/NPFuyYGiNR6DlGFtd9TBdjhymMJu6m1xpNXML3qj0vkdk9aKQgeoL7av5dqaHB11Z77LCAUNjI67puCVb/5Qb39jvjetuKrTTNt8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB6214
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

Exercise RTC register masks, binary counter, upload and stop controls,
alarm and wakeup interrupt behavior, reset state, and PLIC wiring on
the Icicle Kit.

Also verify RTC state and pending interrupt migration, including streams
from QEMU versions that predate the RTC device.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

(no changes since v2)

Changes in v2:
- Expect the documented hardware state after RTC reset

 MAINTAINERS                       |   1 +
 tests/qtest/mchp_pfsoc_rtc_test.c | 315 ++++++++++++++++++++++++++++++
 tests/qtest/meson.build           |   5 +-
 3 files changed, 320 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/mchp_pfsoc_rtc_test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 2ea76ad1cd..12ffbd560e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1810,6 +1810,7 @@ F: include/hw/misc/mchp_pfsoc_dmc.h
 F: include/hw/misc/mchp_pfsoc_ioscb.h
 F: include/hw/misc/mchp_pfsoc_sysreg.h
 F: include/hw/rtc/mchp_pfsoc_rtc.h
+F: tests/qtest/mchp_pfsoc_rtc_test.c
 
 Shakti C class SoC
 L: qemu-riscv@nongnu.org
diff --git a/tests/qtest/mchp_pfsoc_rtc_test.c b/tests/qtest/mchp_pfsoc_rtc_test.c
new file mode 100644
index 0000000000..ed96c15faa
--- /dev/null
+++ b/tests/qtest/mchp_pfsoc_rtc_test.c
@@ -0,0 +1,315 @@
+/*
+ * QTest testcase for the Microchip PolarFire SoC RTC
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
+#include "qemu/bitops.h"
+#include "qemu/bswap.h"
+#include "qemu/timer.h"
+#include "libqtest.h"
+#include "migration/migration-qmp.h"
+#include "migration/migration-util.h"
+
+#define RTC_BASE            0x20124000
+#define RTC_CONTROL         0x00
+#define RTC_MODE            0x04
+#define RTC_PRESCALER       0x08
+#define RTC_ALARM_LOWER     0x0c
+#define RTC_ALARM_UPPER     0x10
+#define RTC_COMPARE_LOWER   0x14
+#define RTC_COMPARE_UPPER   0x18
+#define RTC_DATETIME_LOWER  0x20
+#define RTC_DATETIME_UPPER  0x24
+#define RTC_RUNNING         BIT(0)
+#define RTC_STOP            BIT(1)
+#define RTC_ALARM_ON        BIT(2)
+#define RTC_ALARM_OFF       BIT(3)
+#define RTC_UPLOAD          BIT(5)
+#define RTC_MATCH           BIT(7)
+#define RTC_WAKEUP_CLEAR    BIT(8)
+#define RTC_WAKEUP_SET      BIT(9)
+#define RTC_UPDATED         BIT(10)
+#define RTC_WAKEUP_ENABLE   BIT(1)
+#define RTC_WAKEUP_RESET    BIT(2)
+#define RTC_WAKEUP_CONTINUE BIT(3)
+#define RTC_PRESCALER_MASK  0x03ffffff
+#define RTC_UPPER_MASK      0x3fffffff
+#define PLIC_BASE           0x0c000000
+#define PLIC_PENDING        0x1000
+#define PLIC_RTC_PENDING    (BIT(16) | BIT(17))
+#define ENVM_BASE           0x20220000
+#define HSS_HEADER_SIZE     0x100
+#define HSS_HEADER_JUMP     0x1000006f
+#define HSS_PAYLOAD_BASE    (ENVM_BASE + HSS_HEADER_SIZE)
+#define HSS_PAYLOAD_SIZE    8
+
+static QTestState *microchip_icicle_kit_start_rtc(const char *firmware)
+{
+    return qtest_initf(
+        "-machine microchip-icicle-kit -smp 5 -m 2G -bios \"%s\" "
+        "-rtc clock=vm", firmware);
+}
+
+static QTestState *microchip_icicle_kit_start_ext(const char *qemu_var,
+                                                  const char *firmware)
+{
+    g_autofree char *args = g_strdup_printf(
+        "-machine microchip-icicle-kit -smp 5 -m 2G -bios \"%s\"",
+        firmware);
+
+    return qtest_init_ext(qemu_var, args, NULL, true);
+}
+
+static char *create_firmware(void)
+{
+    uint8_t firmware[HSS_HEADER_SIZE + HSS_PAYLOAD_SIZE] = { 0 };
+    static const uint8_t payload[] = {
+        0x13, 0x00, 0x00, 0x00,
+        0x6f, 0x00, 0x00, 0x00,
+    };
+    char *path;
+    int fd;
+    ssize_t written;
+    unsigned int i;
+
+    stl_le_p(&firmware[0], HSS_HEADER_JUMP);
+    stl_le_p(&firmware[4], HSS_PAYLOAD_SIZE);
+    for (i = 0; i < 5; i++) {
+        stl_le_p(&firmware[8 + i * sizeof(uint32_t)], HSS_PAYLOAD_BASE);
+    }
+    memcpy(&firmware[HSS_HEADER_SIZE], payload, sizeof(payload));
+
+    fd = g_file_open_tmp("microchip-icicle-kit-XXXXXX", &path, NULL);
+    g_assert_cmpint(fd, >=, 0);
+
+    written = write(fd, firmware, sizeof(firmware));
+    g_assert_cmpint(written, ==, sizeof(firmware));
+    close(fd);
+
+    return path;
+}
+
+static uint64_t rtc_read_binary_count(QTestState *qts)
+{
+    uint64_t count = qtest_readl(qts, RTC_BASE + RTC_DATETIME_LOWER);
+
+    count |= (uint64_t)qtest_readl(qts,
+                                   RTC_BASE + RTC_DATETIME_UPPER) << 32;
+    return count;
+}
+
+static void test_rtc(void)
+{
+    g_autofree char *firmware = create_firmware();
+    QTestState *qts = microchip_icicle_kit_start_rtc(firmware);
+    uint32_t control;
+
+    unlink(firmware);
+    qtest_irq_intercept_out_named(qts, "/machine/soc/rtc", "sysbus-irq");
+
+    g_assert_cmphex(qtest_readl(qts, RTC_BASE + RTC_CONTROL), ==, 0);
+    g_assert_cmphex(rtc_read_binary_count(qts), ==, 0);
+    qtest_clock_step(qts, 2 * NANOSECONDS_PER_SECOND);
+    g_assert_cmphex(rtc_read_binary_count(qts), ==, 0);
+
+    qtest_writel(qts, RTC_BASE + RTC_MODE, UINT32_MAX);
+    qtest_writel(qts, RTC_BASE + RTC_PRESCALER, UINT32_MAX);
+    g_assert_cmphex(qtest_readl(qts, RTC_BASE + RTC_MODE), ==, 0xf);
+    g_assert_cmphex(qtest_readl(qts, RTC_BASE + RTC_PRESCALER), ==,
+                    RTC_PRESCALER_MASK);
+    qtest_writel(qts, RTC_BASE + RTC_MODE, 0);
+
+    qtest_writel(qts, RTC_BASE + RTC_CONTROL, RTC_STOP);
+    g_assert_cmphex(qtest_readl(qts, RTC_BASE + RTC_CONTROL) &
+                    RTC_RUNNING, ==, 0);
+    qtest_clock_step(qts, 2 * NANOSECONDS_PER_SECOND);
+    g_assert_cmphex(rtc_read_binary_count(qts), ==, 0);
+
+    qtest_writel(qts, RTC_BASE + RTC_DATETIME_LOWER, 42);
+    qtest_writel(qts, RTC_BASE + RTC_DATETIME_UPPER, 0);
+    qtest_writel(qts, RTC_BASE + RTC_CONTROL, RTC_UPLOAD);
+    g_assert_cmphex(rtc_read_binary_count(qts), ==, 42);
+    g_assert_cmphex(qtest_readl(qts, RTC_BASE + RTC_CONTROL) &
+                    (RTC_UPLOAD | RTC_UPDATED), ==, RTC_UPDATED);
+
+    qtest_writel(qts, RTC_BASE + RTC_CONTROL, RTC_RUNNING);
+    qtest_clock_step(qts, NANOSECONDS_PER_SECOND);
+    g_assert_cmphex(rtc_read_binary_count(qts), ==, 43);
+    qtest_writel(qts, RTC_BASE + RTC_CONTROL, RTC_WAKEUP_SET);
+    g_assert_true(qtest_get_irq(qts, 0));
+    qtest_writel(qts, RTC_BASE + RTC_CONTROL, RTC_WAKEUP_CLEAR);
+    g_assert_false(qtest_get_irq(qts, 0));
+
+    qtest_writel(qts, RTC_BASE + RTC_ALARM_LOWER, 45);
+    qtest_writel(qts, RTC_BASE + RTC_ALARM_UPPER, 0);
+    qtest_writel(qts, RTC_BASE + RTC_COMPARE_LOWER, UINT32_MAX);
+    qtest_writel(qts, RTC_BASE + RTC_COMPARE_UPPER, RTC_UPPER_MASK);
+    qtest_writel(qts, RTC_BASE + RTC_MODE,
+                 RTC_WAKEUP_ENABLE | RTC_WAKEUP_CONTINUE);
+    qtest_writel(qts, RTC_BASE + RTC_CONTROL, RTC_ALARM_ON);
+    g_assert_false(qtest_get_irq(qts, 0));
+    g_assert_false(qtest_get_irq(qts, 1));
+    control = qtest_readl(qts, RTC_BASE + RTC_CONTROL);
+    g_assert_cmphex(control & RTC_ALARM_ON, ==, RTC_ALARM_ON);
+    qtest_writel(qts, RTC_BASE + RTC_CONTROL, control | RTC_ALARM_OFF);
+    g_assert_cmphex(qtest_readl(qts, RTC_BASE + RTC_CONTROL) &
+                    RTC_ALARM_ON, ==, 0);
+    qtest_clock_step(qts, 2 * NANOSECONDS_PER_SECOND);
+    g_assert_false(qtest_get_irq(qts, 0));
+    g_assert_false(qtest_get_irq(qts, 1));
+
+    qtest_writel(qts, RTC_BASE + RTC_DATETIME_LOWER, 43);
+    qtest_writel(qts, RTC_BASE + RTC_CONTROL, RTC_UPLOAD);
+    qtest_writel(qts, RTC_BASE + RTC_CONTROL, RTC_ALARM_ON);
+    qtest_clock_step(qts, 2 * NANOSECONDS_PER_SECOND);
+    g_assert_true(qtest_get_irq(qts, 0));
+    g_assert_true(qtest_get_irq(qts, 1));
+    g_assert_cmphex(qtest_readl(qts, RTC_BASE + RTC_CONTROL) & RTC_MATCH,
+                    ==, RTC_MATCH);
+    qtest_writel(qts, RTC_BASE + RTC_CONTROL, RTC_ALARM_OFF);
+    g_assert_false(qtest_get_irq(qts, 0));
+    g_assert_false(qtest_get_irq(qts, 1));
+
+    qtest_writel(qts, RTC_BASE + RTC_DATETIME_LOWER, 0);
+    qtest_writel(qts, RTC_BASE + RTC_DATETIME_UPPER, 0);
+    qtest_writel(qts, RTC_BASE + RTC_CONTROL, RTC_UPLOAD);
+    qtest_writel(qts, RTC_BASE + RTC_ALARM_LOWER, 2);
+    qtest_writel(qts, RTC_BASE + RTC_MODE,
+                 RTC_WAKEUP_ENABLE | RTC_WAKEUP_RESET |
+                 RTC_WAKEUP_CONTINUE);
+    qtest_writel(qts, RTC_BASE + RTC_CONTROL, RTC_ALARM_ON);
+    qtest_clock_step(qts, 2 * NANOSECONDS_PER_SECOND);
+    g_assert_true(qtest_get_irq(qts, 0));
+    g_assert_cmphex(rtc_read_binary_count(qts), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, RTC_BASE + RTC_CONTROL) &
+                    RTC_ALARM_ON, ==, RTC_ALARM_ON);
+    qtest_writel(qts, RTC_BASE + RTC_CONTROL, RTC_WAKEUP_CLEAR);
+    qtest_clock_step(qts, 2 * NANOSECONDS_PER_SECOND);
+    g_assert_true(qtest_get_irq(qts, 0));
+    g_assert_cmphex(rtc_read_binary_count(qts), ==, 0);
+    qtest_writel(qts, RTC_BASE + RTC_CONTROL, RTC_ALARM_OFF);
+    g_assert_false(qtest_get_irq(qts, 0));
+    g_assert_false(qtest_get_irq(qts, 1));
+
+    qtest_system_reset(qts);
+    g_assert_cmphex(qtest_readl(qts, RTC_BASE + RTC_CONTROL), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, RTC_BASE + RTC_MODE), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, RTC_BASE + RTC_PRESCALER), ==, 0);
+    g_assert_false(qtest_get_irq(qts, 0));
+    g_assert_false(qtest_get_irq(qts, 1));
+
+    qtest_quit(qts);
+}
+
+static void test_rtc_plic(void)
+{
+    g_autofree char *firmware = create_firmware();
+    QTestState *qts = microchip_icicle_kit_start_rtc(firmware);
+
+    unlink(firmware);
+
+    qtest_writel(qts, RTC_BASE + RTC_DATETIME_LOWER, 42);
+    qtest_writel(qts, RTC_BASE + RTC_DATETIME_UPPER, 0);
+    qtest_writel(qts, RTC_BASE + RTC_CONTROL, RTC_UPLOAD);
+    qtest_writel(qts, RTC_BASE + RTC_CONTROL, RTC_RUNNING);
+    qtest_writel(qts, RTC_BASE + RTC_ALARM_LOWER, 43);
+    qtest_writel(qts, RTC_BASE + RTC_ALARM_UPPER, 0);
+    qtest_writel(qts, RTC_BASE + RTC_COMPARE_LOWER, UINT32_MAX);
+    qtest_writel(qts, RTC_BASE + RTC_COMPARE_UPPER, RTC_UPPER_MASK);
+    qtest_writel(qts, RTC_BASE + RTC_MODE,
+                 RTC_WAKEUP_ENABLE | RTC_WAKEUP_CONTINUE);
+    qtest_writel(qts, RTC_BASE + RTC_CONTROL, RTC_ALARM_ON);
+    qtest_clock_step(qts, NANOSECONDS_PER_SECOND);
+
+    g_assert_cmphex(qtest_readl(qts, PLIC_BASE + PLIC_PENDING + 8) &
+                    PLIC_RTC_PENDING, ==, PLIC_RTC_PENDING);
+
+    qtest_quit(qts);
+}
+
+static void test_machine_migration(void)
+{
+    g_autofree char *firmware = create_firmware();
+    const char *old_qemu = g_getenv("QTEST_QEMU_BINARY_OLD");
+    QTestState *from;
+    QTestState *to = qtest_initf(
+        "-machine microchip-icicle-kit -smp 5 -m 2G "
+        "-bios \"%s\" -incoming defer "
+        "-rtc clock=vm", firmware);
+
+    qtest_irq_intercept_out_named(to, "/machine/soc/rtc", "sysbus-irq");
+
+    /* Allow an older QEMU source to exercise migration compatibility */
+    if (old_qemu) {
+        from = microchip_icicle_kit_start_ext("QTEST_QEMU_BINARY_OLD",
+                                              firmware);
+    } else {
+        from = microchip_icicle_kit_start_rtc(firmware);
+        qtest_writel(from, RTC_BASE + RTC_DATETIME_LOWER, 0x23456789);
+        qtest_writel(from, RTC_BASE + RTC_DATETIME_UPPER, 1);
+        qtest_writel(from, RTC_BASE + RTC_CONTROL, RTC_UPLOAD);
+        qtest_writel(from, RTC_BASE + RTC_CONTROL, RTC_RUNNING);
+        qtest_writel(from, RTC_BASE + RTC_ALARM_LOWER, 0x2345678b);
+        qtest_writel(from, RTC_BASE + RTC_ALARM_UPPER, 1);
+        qtest_writel(from, RTC_BASE + RTC_COMPARE_LOWER, UINT32_MAX);
+        qtest_writel(from, RTC_BASE + RTC_COMPARE_UPPER, RTC_UPPER_MASK);
+        qtest_writel(from, RTC_BASE + RTC_MODE,
+                     RTC_WAKEUP_ENABLE | RTC_WAKEUP_CONTINUE);
+        qtest_writel(from, RTC_BASE + RTC_CONTROL, RTC_ALARM_ON);
+        qtest_writel(from, RTC_BASE + RTC_CONTROL, RTC_WAKEUP_SET);
+        qtest_writel(from, RTC_BASE + RTC_PRESCALER, 999999);
+    }
+
+    unlink(firmware);
+
+    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", NULL, "{}");
+    migrate_qmp(from, to, NULL, NULL, "{}");
+    wait_for_migration_complete(from);
+
+    if (old_qemu) {
+        g_assert_cmphex(qtest_readl(to, RTC_BASE + RTC_CONTROL), ==, 0);
+        g_assert_cmphex(qtest_readl(to, RTC_BASE + RTC_PRESCALER), ==, 0);
+        g_assert_false(qtest_get_irq(to, 0));
+        g_assert_false(qtest_get_irq(to, 1));
+    } else {
+        g_assert_cmphex(rtc_read_binary_count(to), ==, 0x123456789);
+        g_assert_cmphex(qtest_readl(to, RTC_BASE + RTC_CONTROL) &
+                        (RTC_RUNNING | RTC_ALARM_ON), ==,
+                        RTC_RUNNING | RTC_ALARM_ON);
+        g_assert_cmphex(qtest_readl(to, RTC_BASE + RTC_PRESCALER), ==,
+                        999999);
+        g_assert_true(qtest_get_irq(to, 0));
+        g_assert_false(qtest_get_irq(to, 1));
+        qtest_writel(to, RTC_BASE + RTC_CONTROL, RTC_WAKEUP_CLEAR);
+        g_assert_false(qtest_get_irq(to, 0));
+        qtest_clock_step(to, 2 * NANOSECONDS_PER_SECOND);
+        g_assert_cmphex(rtc_read_binary_count(to), ==, 0x12345678b);
+        g_assert_true(qtest_get_irq(to, 0));
+        g_assert_true(qtest_get_irq(to, 1));
+        qtest_writel(to, RTC_BASE + RTC_CONTROL, RTC_ALARM_OFF);
+        g_assert_false(qtest_get_irq(to, 0));
+        g_assert_false(qtest_get_irq(to, 1));
+    }
+
+    qtest_quit(from);
+    qtest_quit(to);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/mchp_pfsoc_rtc/registers", test_rtc);
+    qtest_add_func("/mchp_pfsoc_rtc/plic", test_rtc_plic);
+    qtest_add_func("/mchp_pfsoc_rtc/migration",
+                   test_machine_migration);
+
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 29457193ed..fb3dcb200b 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -312,7 +312,8 @@ qtests_riscv32 = \
 qtests_riscv64 = ['riscv-csr-test'] + \
   (unpack_edk2_blobs ? ['bios-tables-test'] : []) + \
   (config_all_devices.has_key('CONFIG_MICROCHIP_PFSOC') ?
-   ['cadence-sdhci-test'] : []) + \
+   ['cadence-sdhci-test',
+    'mchp_pfsoc_rtc_test'] : []) + \
   (config_all_devices.has_key('CONFIG_SIFIVE_L2CC') ? ['sifive_l2cc_test'] : []) + \
   (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
    config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
@@ -432,6 +433,8 @@ qtests = {
   'migration-test': test_migration_files + migration_tls_files + migration_colo_files,
   'sifive_l2cc_test': files('migration/migration-qmp.c',
                            'migration/migration-util.c'),
+  'mchp_pfsoc_rtc_test': files('migration/migration-qmp.c',
+                               'migration/migration-util.c'),
   'pxe-test': files('boot-sector.c'),
   'pnv-xive2-test': files('pnv-xive2-common.c', 'pnv-xive2-flush-sync.c',
                           'pnv-xive2-nvpg_bar.c'),
-- 
2.53.0


