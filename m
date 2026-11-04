Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BE5606A31B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 15:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=FFOahuBs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOd8k-0001n1-P1; Wed, 04 Nov 2026 10:43:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOd8i-0001mT-NR; Wed, 04 Nov 2026 10:43:04 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOd8g-0001Gk-51; Wed, 04 Nov 2026 10:43:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AUVKZiwKu2sLR509wN6HCCzUT72UNpxoDErGEAN06NCRAe8CX91SybF/+XTWfBB4ZEKFmUFMKcvBOYEne2eTOS9eZWgwJ2Cu1ICU2lWbsgBS3xjPNdq4Tv7BwAYgf4dLPx4Utc6XcFeulYu5Z1sBcjNyMziIm5dXyzXsE1FFGBe+1rJszeeKnjxVEG5JoiEeX3xl0c8AHRQR64VLV/54hZI963yOS2nKIB6uyaKMZOECwodeOEwwe+ArzlV2T2TmiU9MM/ySYbzHDLKgyggIx4FqZsu3KP9pK/qU5xXwG2OvR/7Q1Ah1ykf1sN/pYiraWrbzsQVN5trSznYpAVS0dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3GIvQ/3WHofefCL9IhPbi33tMO9lMSUNBAfVPgtFIIU=;
 b=uaOAcoRQZist4gqbm27asTbS5HaaiSkrUaMULk7WkfYqJMQIpmeFS1xlgX1aGs2CUuHArFH316hsFULNskrwI2UFxm2ZtfwCrTfhPM1/Gngf558qkRlptaCEqFrHVanOi5MncdIT0rlW+/mHV9IuECOjY1GVHqbylL6+T/VxeXptUoCGpc0bK4Q5vwV+2miQKCf4hFWqSaqHi++n/bI09f0qyLU68ZQ7A1z4TTt0cjZfXPYLB3ZbfxK3ZfXnsxq9U7GnLiH++xwZ5DEu16zCdK2L9WQjKc1errPWkFr3UVky97W84gTBslw2z6sUhTq46zEYESqh/5oEsBapH1Qrpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3GIvQ/3WHofefCL9IhPbi33tMO9lMSUNBAfVPgtFIIU=;
 b=FFOahuBs+xEoeyOi5NNZymxy91RA2bkkKJuAahW7OtlzsY3ULgKc3QpnddOdYxYmljO/nxDR3eDNq9qfKCXEnYBpUXl7YQEoUqzSH67vY8LQ1uFZLRqe0rYxrJs+fcWf1IxZdhqyap6RvmsjOLAHSClcx6PacRnFMxOP4i7GSPLOz0+7k8RrSrsYgIbS6+KPpp7RMcyEIhQWQ3qoxDThAO5jedlcg4c4H4iNQctOm+3HOKVVaTKf/59JtN2SyXu/MXmseyzLxdX3muOR7LHm5RCwrNUU7TeUP8q9JipgOn6ZdQwQ8ONp2k2oPmvRwocRSXp/6qMcrdjPRASU3jpkTQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com (2603:1096:405:2c::12)
 by SEZPR02MB7162.apcprd02.prod.outlook.com (2603:1096:101:190::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 15:42:53 +0000
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10]) by TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 15:42:53 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor@kernel.org>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>, qemu-riscv@nongnu.org
Subject: [PATCH v5 15/26] tests/qtest: Add PolarFire SoC RTC coverage
Date: Wed,  4 Nov 2026 23:41:42 +0800
Message-ID: <20261104154207.641511-16-bin.meng@processmission.com>
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
X-MS-TrafficTypeDiagnostic: TYZPR02MB7121:EE_|SEZPR02MB7162:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f557c60-02f4-4a7c-0614-08df3a8a4a2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|260925021311599003|260925021911599003|260925022911599003|56012099006|261022105027099003|261021121427099003|261009223027099003|261021130227099003|261021123027099003|261022075727099003|261021135927099003|261022115727099003|261102123227099003|261026130827099003|261021133027099003|261022113327099003|261026121527099003|261026140227099003|261026135527099003|261028144727099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 7q7P7OSTNiuXDOus+7nJuWOKCoCfrgJaHF6YacSbEda+Z4sK2SSYNPLKaht9i3Ee/JKCBiKArKOVflzH6M1MIO5UeS2+9EnyIg4JN9gOxillEGLEuN55asHn8lh4OSGJM1FsG8cpnI+cjy2naH7bthxCAXKsUjBxZnymAHup+Fj37wqEEHFgKuqyE0qCVU4lpQ8N8PqmwTmXbsAA5yNXKSgqhZU+ng7ZRVryUBFCf+GwM4OqZrZ9AMZTUBRpTYt7GRiz/pw0hThYaFK67BHruPDIKW+9EAt+AClMG9wrp5qA8fDhDgXFBkphzhGpw5ojsDGRwuOmLtmOdirVAlvbz8+RdJfffEjjWcRI6zueG6iB1LFcEprfh6QTkkZwkL5qB7jwx+RW167OIBw0WBNLnnVzqnKILwmV6Qea8fAXvtXgBsDDxayhjQoGw9SVvlwZs+a+BgBEThHhLXWTNPtX/eogbGdQXS0dEw1K5zRpwp7ivlbqKp2uD+UT5yezZHlVcMZpRXT7Umovz3F0yt4VoNE5WyJ8CDe+BxLDh5gHG2TzC7LckWA98inQQ+FT1khAQadQ5KQf0Mdk2kKB0r6a8w12VI6JBcAaNoylAlQt+ooEOqMU/dENwocgS/jDhaDJoaejPRh4GtY2FvrX0JEJ+fRzPe3fqBCIbzENrvHnwfQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR02MB7121.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(260925021311599003)(260925021911599003)(260925022911599003)(56012099006)(261022105027099003)(261021121427099003)(261009223027099003)(261021130227099003)(261021123027099003)(261022075727099003)(261021135927099003)(261022115727099003)(261102123227099003)(261026130827099003)(261021133027099003)(261022113327099003)(261026121527099003)(261026140227099003)(261026135527099003)(261028144727099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kMzEHLdU8Ck7tn+SYF9bR7vCasSNxpGGgmpZ8XDCQqVQEUKSHM+OAA3fVOLi?=
 =?us-ascii?Q?y7o3/FjGS9Yq5sr7Z77YSAaOEY7AP9rx4tPr+UB0/uC9ADN1gXT4mv+5leqI?=
 =?us-ascii?Q?4/B/ixreUuMVuM6U7v2LAcUjb6Xi/4fzFBwtWafDKY3La8trelvX6SUQSYKF?=
 =?us-ascii?Q?L5JBpghfONRudZoJg/80+sFLleF6VTRmcd3w6VYbylspgfpJ40vBOwzdqLpU?=
 =?us-ascii?Q?p5qGA6boqb0dC+4JIVMJvqK453L0ntiW9THK5EpST+b/pVTKLLtcXFAk3Ly6?=
 =?us-ascii?Q?uSRnim0s6EeXBF1agSUyNNcsz5L+OiS02oZYzAWN0ZyYKVzmsmgqcpUK7n+H?=
 =?us-ascii?Q?m3JB5/pRv9HPW9w95B23ReIjeHgFxiwluty9pW378696atzfplxCdJBQsCPG?=
 =?us-ascii?Q?Vw09ha8xS1oFce59S/zfRA00yBk6jC3JcX1stTdDbWDouqx9kCT2GTruQ0Zj?=
 =?us-ascii?Q?2jXR4ls3pwxTQMBg0/qbRseK7EsY6Vf2lEpU9tKbpZhBRww47SMj+4AuSeQh?=
 =?us-ascii?Q?tGpWu+U0MyVBCLxGIk1uX+fiew22GbsJTzZML/7EWccK1zMxKdjGfCr8b7h2?=
 =?us-ascii?Q?KFNQVtMpN3zugjv+J85/W6p7oqqkfmPg03ctFGWO0Lr3JYAJgvCMFLn1Krax?=
 =?us-ascii?Q?b9RnQWNo/H952Hq1RvqYnuEd0QOK94XMlq/qJOu6BuY/gI2L95GGAoxslJQa?=
 =?us-ascii?Q?hJIdJyq7AKreqLtYF+vuo8sCy8DR7ZTjR0y4eorl42RtkxtLD5ixzQIeNs76?=
 =?us-ascii?Q?0gLk4GzQUa4RRjYuij2csR5ZqSlPyAd9DY7Qlm13Ik015k0dfArQqHHk6+5l?=
 =?us-ascii?Q?AFhzdr1mkj27xdEsZ3dxq0wxLIfoljQ1c4c7SP1hdoIV1U9Bkh939z8AYEbi?=
 =?us-ascii?Q?xQqxIGoV3w8Ap9K/woHq84wkAJkDiG/7PYi0fRsPGw6iyQJsGViC8LFAoq8C?=
 =?us-ascii?Q?V2Wcu9NLV7Bnf6wG9k/XeRlml4m7NmtmNesngeLvS0SB8MrIGC8eKHwc2bnR?=
 =?us-ascii?Q?+Ibu04c0DmndtsvP2z8jHvN/SAD3/fmbIBFkINae4j0/7m9vcZaq3RdOCVfX?=
 =?us-ascii?Q?iyMXUrSRl/HJSqzQOWH/gFNlDu/RO+VYEG0qhYvKMCXSqvAnEtLdK4HcN0YX?=
 =?us-ascii?Q?JNGpBGjjirjYMUTG+iGGmLn3DrqBqJPQcuvzksxAfdfQyxKvh2lm0CaxAlDt?=
 =?us-ascii?Q?lcfHoAQylmWy9Xlg6nivY+5DvX4lcOSjplSbenB+xJayjYRasczNY9qbqELn?=
 =?us-ascii?Q?1rWPcLGHgeO7wh1jEAzK1vhpgzeIA3rsZgtQT6eXfcY9aKXlFTvlwcNCgnMh?=
 =?us-ascii?Q?2tUOto+8EOJTlF2Y1HE9seeaN1cXduBEp1yMOLeHM6qw5YA/7v2rU/LNPE5v?=
 =?us-ascii?Q?OX08dDVR/NiTBsw4daqVApPMHXIsvatJ0ebqzUzn8/Q5v/hPh9XJbxj/NnnT?=
 =?us-ascii?Q?nnWldkODV7jjQICyTfk8IWjbTOe6+IsNa6qNdFBtIojyTycD7ljixaMAn41/?=
 =?us-ascii?Q?N8kdIvcNnfd2vPDQIZVYfdrF3qZQCJuMOXRaMwGiDEcbUx85vHHjvI8oJ0yP?=
 =?us-ascii?Q?V3fiMK0M2XXAxgoUkvcHPJ2+r+0nut6PkQJiZa0nx5l/5hXXrbVNQQmDi8ZU?=
 =?us-ascii?Q?3aorWpMnIE00Cwm0psvOySm+1rCyZadlTnpdvdkoETNeGDumN/plTsZq8vbE?=
 =?us-ascii?Q?wGTDX5i7pMhDuOxi3vPBTY9h9BqGZO3oaw8fqLAmUgjVdm4cO2FYFAwQst8+?=
 =?us-ascii?Q?EGZg8UFNxDiy7jeg+rNweeIxsl6Uuus=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f557c60-02f4-4a7c-0614-08df3a8a4a2a
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7121.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 15:42:53.5195 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EL20A5FJmOYeaf/whQ3xyXKXAAa4CK76GDFP7vIP1it+3GVp4TryYGji6jc4Da6HolZo7IHmkyB0WOHhl5cQMgzHgQWtkUH//Cm/YTqaHD4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB7162
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
index a4e33654ef..a8343e3d55 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1834,6 +1834,7 @@ F: include/hw/misc/mchp_pfsoc_dmc.h
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
index d08fbc1eb7..3fe0786af2 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -318,7 +318,8 @@ qtests_riscv32 = \
 qtests_riscv64 = ['riscv-csr-test'] + \
   (unpack_edk2_blobs ? ['bios-tables-test'] : []) + \
   (config_all_devices.has_key('CONFIG_MICROCHIP_PFSOC') ?
-   ['cadence-sdhci-test'] : []) + \
+   ['cadence-sdhci-test',
+    'mchp_pfsoc_rtc_test'] : []) + \
   (config_all_devices.has_key('CONFIG_SIFIVE_L2CC') ? ['sifive_l2cc_test'] : []) + \
   (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
    config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
@@ -443,6 +444,8 @@ qtests = {
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


