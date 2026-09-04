Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81CF3C624DE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 16:03:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2WJw-0005UR-D8; Fri, 04 Sep 2026 11:59:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WJm-000583-2l; Fri, 04 Sep 2026 11:59:06 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WJj-0004Wv-GB; Fri, 04 Sep 2026 11:59:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p+tKjiDot0Ns4JK3TvbRQF0NxNACWUooF9w4/ZkqQ9f9QpnJEssJtEm8mUST665m/xCWw5FxEZoa+FOQOICVPEdsLt0fbajglzYVY3cuW/UwwW2+H+e0hvA2Wr9I/xQw+q5z1OFEwdljyciCfGHK0vOWZJHQJUuA3S0lhBIfoXhP9IBCHbBlFo0V2v6fvLrrqNQh9KerTJbMc24WrjhSNOZEOzdj1AD0BFs4mA7dJ6APeu42Xg6S5pHeOMETavmrBerxHFRvcxtrhK5/JMgA/35XeHKeOWyAYNXv7osW63EnATjJBVthT/Lz9DjMD1edvaeJBTciEWldSRLpc8JjTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oW4NH1yIZySa6jN9mqfkWOsf5KPFy219oGJxk7pvz3s=;
 b=alZ5572YpEYj56vghxdXeAbQ8RpMIZKwfetF5SjKQ0s/7dZJPQ9deJHHx3iJuenwM2F9faAVuHECmSpCK+919DxJaJ3rmb3F7ySgYnUW6yKLtRGD9FKwoyNkWSucjLLGEhEFzPlruuZL0x1uMmUoA0NIIr8sUOn1F4Hsnym23RzERQtxQ1qWxc1seYh6XE+tB+hUUiUCLRAUVTCEO4557vUy0JSDvgk0xAaIYHiajuJAr+BlulnDiZGUqM7nRfANUcceZhhwTCArWcul53Tdp78vj+oTOUFS7Z3ZBATFR38+WsJxY5K5PHSLbLWGNthz3Mt/h9YFoR91p+bEB/yB/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oW4NH1yIZySa6jN9mqfkWOsf5KPFy219oGJxk7pvz3s=;
 b=FDO3/6HPv+h5Po6FSLm1XmR17mfcCOr1FimDL2sxSXY4HYE9ZpwLLmSwBM+/25ZI4Dsdriq4AWrrL7PbGl4NGKj+0bMDIAJOwB4ikOZ7sgkJ8ftn8Hm03AtfINEUQQNI0cXST8N909l8mJTnEtuh4LIDAmEod4nZ2yHki3lcnL9zYwwf00lZxsuuVmp951tv6Q70VQiQgsYPengFDrS4XVU2P3nBlJE5XdN8xnChxzdOs/dseDddiB7rPyldRzLyhfZOT85GY/h2XLldRHDzQIdNsP+4/dUd/DTpBGXFAYDH06Rq28Vgkc1hxqVgHdkXwup5bYnYWzPkwaq9RxBt0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TYSPR02MB7490.apcprd02.prod.outlook.com (2603:1096:405:37::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 15:58:57 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Fri, 4 Sep 2026
 15:58:56 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor@kernel.org>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>, qemu-riscv@nongnu.org
Subject: [PATCH v2 15/24] tests/qtest: Add PolarFire SoC RTC coverage
Date: Fri,  4 Sep 2026 23:57:34 +0800
Message-ID: <20260904155758.3833179-16-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904155758.3833179-1-bin.meng@processmission.com>
References: <20260904155758.3833179-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0020.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::13) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|TYSPR02MB7490:EE_
X-MS-Office365-Filtering-Correlation-Id: d8f0eaf2-5680-4986-ef7b-08df0a9d6d02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|10067099003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: +qvre+yRgi5NGK6Li7vowKLJR04APD34/KlnhOicXlxAxDi/CB2f9Gs+DgAjjJl7p5JFIY7u1VhNKKlaQ2CdSRAK/PXhiXKQGh8si1OqHu0TusiiUdbJ1NepScOJExQofZiIlnfFeAPyV5ZlwVA3FJlXErT1V7N+tzwm2QNIQcHRFN8TJvB/kkKxvzA5vngZJOb5QNHzSL02Y6WNWd0nAbvu2wpf4pdrCcDKMOq58Cve0tG1LpioVPf9MrIgKnDp2TEozK6uPI1M1fl3U5DcyTylAPm8QG/MnjWA+hV34/FClGH2bmUb4xCZPZwUZlpvTjvfXfURa9Mx3UHo+FjB8aURXeZDANeOM7rICWiRtl461P1FWm/PE5JuOD861LAPGcsdS+n7PqcyYoYwfBKViuwtR0mUMr/DE+PUBHJGkyreeiDc6Njm5OpUehlOfVVssyf7i2vUzKWCWbWLAi+6QKMxDwBPipt6Pl2nQ35GzVda64ktGe6zRlV9WGNSq4eQvBbvBgSp/D2I9Z90myWGfhSK4c0et1aArSZGMlJq/JHzVGZvUJnUT71oBC6+C1YLOpYAv2HKMJ+GILldhv7DBm3Ouxb5biArfaIM7n3av19+XqiXyR4enELoQVs511DSgfTUzN2y2+Q9tR46totI+MOxT8DJhz8v8lUNBW3wusQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6KFGxpHqfx7R9zcz+AY0pHLsR/X6N2dyJMDwbHizmpuG87Hor52Q1Ys721EA?=
 =?us-ascii?Q?itgto88EhrHTDdb8VNumivEuONg+Ojp6DMrFfb2sLhe8Q8cuN5H1C8k6ZYs4?=
 =?us-ascii?Q?9MCP5ZIojS9vHuRjMVJLqO8yg674hgWjkY44zFOq3AXw3j5OsxGACQQPUSJu?=
 =?us-ascii?Q?ji56cHbYxqJRDyw+zicIGB20x4P1rpvcMMyntuf27giLvAMa0z7ZbRXBfPJW?=
 =?us-ascii?Q?UjINOZKBa5ll0yN0bKv3cU0WJIm7ncW7Y08VFo+wsFFMFHqbl+GzIkOlnK2m?=
 =?us-ascii?Q?vc2YgRLKzIswWk7F1loHS4yzlab2LbO86BlQpGnU+z6dVWxAW+NT/+c8p9+E?=
 =?us-ascii?Q?3qBkFgR2JfgJNzLZt39dWukHdopaIWQc47iWv/yWc6I3jZC7hxEKHgJbplql?=
 =?us-ascii?Q?fN6y+uXr5D8dkXpqfKGvi7GGkDlrwYnp5orIX2dnMsmVwdbp5/e2TT9mms+e?=
 =?us-ascii?Q?Rj4HPPfXMV0K8KhUqy8KnDHH48u5qRvgsg00DoqQmiZgz6gcWkBzXqBUoFsE?=
 =?us-ascii?Q?6QdO2/Eg2cyJAajmDYz2GbgCiN+v8H3kqsvWtJv56kutGdVCN3ss2QK5w5tN?=
 =?us-ascii?Q?Yk7Cm/I7Au8U3DE2cNy1T6/eQVYjnRayn/v/bMUW64sJGwjsHPF9Zueok6hM?=
 =?us-ascii?Q?+5HLNtaCAAJgpIuT4wbgNwA/G6zqS603GFpttm69deaKwSLYE4FqKLFmUL9X?=
 =?us-ascii?Q?Q8nam7mxHqc/9oFzEnWgod2sMIgF4b+hu1CFN8Mng75WYSSuuDeLhuS7GvB8?=
 =?us-ascii?Q?cQc9eVZz9D4SPAUaL9DefREY0/frKBv+bQOAIzfdqP7YQeYQVVOL0rHVUbvz?=
 =?us-ascii?Q?6gyxyyIk+GUSKeHk18aPQQS9L8VnfycoybkdQp6Wd0DF+mjJSnB3Sp1MLjZd?=
 =?us-ascii?Q?NG0MxgbsIa7llpuprPTt4phhD/aPF8P9OuJWMOUaxYW5lacBC6vJxsiJrM/J?=
 =?us-ascii?Q?NrWOAfRcb2/agoRW5JI7q1n/fNP+h0RzG3QajXlNAPEh7sgsL2CVFL3RGUJs?=
 =?us-ascii?Q?i9o8eK3Oz6zFXu1TNIBHPvJOyrJ8vYzmv+KhYoMXtqpW9sVSERvfpyrhrYlI?=
 =?us-ascii?Q?MggaUouwodX53laVuKRShAmg382eN87BRlCT1wgtgWz47okCp2tQjdOv2mL4?=
 =?us-ascii?Q?ZaUS9p9SCctQ4Z3qUVqQ7BWhbUxU5G7/106u2R3ObvSkVFvm9DVyoMLhbFnN?=
 =?us-ascii?Q?yufV5UCoulUy/ILM4fmaEomar4C7f3lWj9DL9H90I6x+O2wKMxLG1vqxt6iN?=
 =?us-ascii?Q?LCAplU80BxNRqkk6OLIwYJBHCdJJg7Ye18XmOqt/3/yRklqgCQfmV3Fw7k3I?=
 =?us-ascii?Q?RciDd5CvvSb0S8jTh3KsEPDWX3AsFuB3FiUexSSBuV+M2EnUYUTbJPEzDIhA?=
 =?us-ascii?Q?i+5XKFq/B600xOxUXewT/vHIabS6DXaaj9zw80gl8a7+osHlgypQBt/GNgWU?=
 =?us-ascii?Q?vJY7H5zoxsOjBhRtiMPLbq4Pnjs1sDoUNt4dreDn/9565bz3KWxVCOFVHvRU?=
 =?us-ascii?Q?qaZ2uysFeauCKvYFBpeu/leK/kvExM5oymV06ckRVpSQZPDFdtPXFa1PEYfh?=
 =?us-ascii?Q?78ZpdA9ezJkdpde2hDnUifed3U3uzZffjLGmOIGvsRSZxsYHWVtOqnf3ZqOa?=
 =?us-ascii?Q?Bb9hAnPGdlCXfQp9XT7o9Gw8VLInRock+6+2P2uF9fG2Kaf8CDNs5lGRwutp?=
 =?us-ascii?Q?AgJ+QwiEruWwjLpYsvJLt7cHS/OVKuQnVhAre1KjSnpTNILLoy8HyC9nRB4t?=
 =?us-ascii?Q?m2dm0iBtWR7qYD3AP37NjajkXN//9rM=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f0eaf2-5680-4986-ef7b-08df0a9d6d02
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 15:58:56.6244 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BxWlFSmKkS18igkjaIKTW6C7c5DwHWx2nlfpciHVBOIDSjee2YF8bI2dodPuG4LO9NZrEnFYqAEFLBZOUGZHqxvUOJP1sAEJOqwg9M+HH9o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR02MB7490
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=bin.meng@processmission.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Changes in v2:
- Expect the documented hardware state after RTC reset

 MAINTAINERS                       |   1 +
 tests/qtest/mchp_pfsoc_rtc_test.c | 315 ++++++++++++++++++++++++++++++
 tests/qtest/meson.build           |   5 +-
 3 files changed, 320 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/mchp_pfsoc_rtc_test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index adc4a41266..1856c67feb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1806,6 +1806,7 @@ F: include/hw/misc/mchp_pfsoc_l2cc.h
 F: include/hw/misc/mchp_pfsoc_sysreg.h
 F: include/hw/rtc/mchp_pfsoc_rtc.h
 F: tests/qtest/mchp_pfsoc_l2cc_test.c
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
index abe73370b6..3f7ecbdde7 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -305,7 +305,8 @@ qtests_riscv64 = ['riscv-csr-test'] + \
   (unpack_edk2_blobs ? ['bios-tables-test'] : []) + \
   (config_all_devices.has_key('CONFIG_MICROCHIP_PFSOC') ?
    ['cadence-sdhci-test',
-    'mchp_pfsoc_l2cc_test'] : []) + \
+    'mchp_pfsoc_l2cc_test',
+    'mchp_pfsoc_rtc_test'] : []) + \
   (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
    config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
    ['iommu-riscv-test'] : []) + \
@@ -419,6 +420,8 @@ qtests = {
   'erst-test': files('erst-test.c'),
   'ivshmem-test': [rt, '../../contrib/ivshmem-server/ivshmem-server.c'],
   'migration-test': test_migration_files + migration_tls_files + migration_colo_files,
+  'mchp_pfsoc_rtc_test': files('migration/migration-qmp.c',
+                               'migration/migration-util.c'),
   'pxe-test': files('boot-sector.c'),
   'pnv-xive2-test': files('pnv-xive2-common.c', 'pnv-xive2-flush-sync.c',
                           'pnv-xive2-nvpg_bar.c'),
-- 
2.53.0


