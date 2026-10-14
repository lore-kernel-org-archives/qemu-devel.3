Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24D29CC6B19
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 01:24:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGnjB-0005X0-GI; Tue, 13 Oct 2026 21:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGnjA-0005WC-C0; Tue, 13 Oct 2026 21:24:20 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGnj8-0006ql-2H; Tue, 13 Oct 2026 21:24:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i8W6Rd5Stqw8VyJnoEbKe6aJce9sBdWwDM73QNBkXMdDvlzfKu3suLjaGfQ/HvKus+uQpwQlS4VH2mW0YWHU8QPXXA6YxlBqDE7CLv9zETO5O23hLqRPgxj41O/hXLJeg08YtRPMWhB4qWSk1FY0tAT/7Vhxu5fH+5Vmk1pRk/7/3AnaR5EYRP2UOVqFdHfkjG+H+MZXl8iam7tmtsM+KBq+Pdo5MeN4hv0cHv9kVYHTEoTNKR0/ZtYNpvmakYjASTNwIODIxjY+V0rwQ7PL35vjKE7byf5mftOZelP+8Do7ILGGu0picOYsfaZpON69Fr19XqCoR2dfIMwe2/1brg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bg52kWXK8j7jf/301TCFVCrSsD2/GDUhc+1K1wL9I10=;
 b=Akz6+sKiZ+aB3nmFTNoSFJPLEKmN5y8jiyJTkxopp8B50gDvQPq9tq6Upl7XEFpe55QX3jaL1jvbMUGFd2YfYynfitPDhYEW9psezlact7J7sr/5rzMakDmpUxOiDfF47A3rrOC60JSxWonED24vDwRuPEpJ9/w4sb7JJyz6adyLCmS23iUGsR3mEHtQPCcTuz0Y3RwKG/FH351kP4nvhWjXCLgcI/qgRThcb8Eo1dCwQK0m7s0j7g+5FnrvJQ5es7qWg/IFROEEqLcwQsMCC9lE3b6PRZ0e1YT/KuKYqUtYHoO0mkpaHPJhMkGMkQ3RUKpY7WHWjhrJybq7Uz01AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bg52kWXK8j7jf/301TCFVCrSsD2/GDUhc+1K1wL9I10=;
 b=RbtcPcNJ20qvblKKzMn0RL7rhgBANdgmIz8PUTxIpxclyZoAXjuSKbZzBrr22i3cSqzcqpk9OS07wR9LX/dX8+epl2VldgRpXETW2XtdkYP2FldgGU/G3OhiJdJ/u5xZqWeCUqso5jyP17yjJ0b/tuAIgyWQWAOPDA+GMFSjJkRHUFDaFDPoJKe+M4dgAkADQ9UYNWTuLrhHHD3dkssnD04cBa72mDR3OLBn88XaCxvflwMKFIH61QMyiWMkBoanrTVm8azsc8NEzM6bvuhd/TvnN8wD557TwpEOj8tFFdQoXNAVMxpmV8R+4WoAn+F7Troz3X8x573v4R/nPt2O6Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by KL1PR02MB6214.apcprd02.prod.outlook.com (2603:1096:820:9e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 01:24:08 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 01:24:08 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-riscv@nongnu.org
Subject: [PATCH v4 08/27] tests/qtest: Add SiFive L2 cache controller coverage
Date: Wed, 14 Oct 2026 09:22:48 +0800
Message-ID: <20261014012323.322790-9-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: d3cf1651-6c5d-469d-296d-08df2991d7dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|6133799003|18002099003|22082099003|260925022911599003|10067099003|260925021311599003|260925021911599003|261009221227099003|261009223027099003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: V1h2/Lj6b9/uos1++26z5Bz8f5JDpF/57YWktwQw2hWj+aOTBQe5U+cIKClzXd7DauHQ/t+6DofrYZyQchlU+yw6cu5R0YQAR2vVl5cbBv2nstMZnJKPBpwl3oHnIbob2Hz1HdNsvOqmyUWK1vJYBhEtzBcbvcgHHabwZLfmYvwGeqphZA85Wnh1KcnGyuIa7NA7q5Z2JuKwrBJk/bnKmQUgSEq1Y9xt4hg4sJeuJPXill0/HpMx5yJH4KLGneKQt1nRSnZc6ZAH/yFv6YqJsosYA4po0pHy6AuiEKCJ4q9r0IytTR3cFbklrjnL0D/NLs0O3Ya7DtAKL7BqQsbwzuNj7BKudm5cPngzIfP5x+x8USpANkX622xiti0JngId143hJpcArQuqT+L2mU8kZqIGaq/D8ByGb9t61WHQI370DaDtihJjYLcV+NMfM3DF6RQ7ydQffpwu1lCLEhujxIRQNqNJQrsVK3Hu1CSjBdt3s8xdLI53a/wDHHDxJBHL9gcOUcMnaid9ncRuNrvaiZVh5nIsqFNX9w33qwY/143M7M7KMet6VyXzLwIl2RDtTuvmnNWEWg31pCBPhtgURQsPxrM03gqnTviAv1H2JlNB4nSoUOhLYAqjCwg/iEnpZJH1AwxnntOeRj7W47/rwLbeeWHG+017ykQJMh1RIgw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(18002099003)(22082099003)(260925022911599003)(10067099003)(260925021311599003)(260925021911599003)(261009221227099003)(261009223027099003)(5023799004)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+YgkjUE7T85FMF2EbrhLqE8c6D9x4TVJUT7cwdTwEGljvqD4hdUvzFWC8VgU?=
 =?us-ascii?Q?S0cv+MYCLpr2ZPn+6avtoBo+nNg29TUdbR5j5EOuI7yNnVn0WhENzsWroleB?=
 =?us-ascii?Q?idxZ8iXqS9W5V2dX94HMYSO2M+iRYB4mF9r2i3enobWXpSddECr0yYvPjsXo?=
 =?us-ascii?Q?ynY++WWjspjEOMl5l3Oblfvp3QMuuk+cLiSCrcL6BMNUB4zDmlQ11d34TboQ?=
 =?us-ascii?Q?0iGm3LRx63hpQ3IV9Nssj+g6n8AnOYhDhaTz23OjFH8NUwzwtcsfTqyVEuNz?=
 =?us-ascii?Q?1+mUFn/XGpjto1CCW+8Bb0mzPKof7/hpROyZOxMn7xx2DjMbXZpUgsPrKj3x?=
 =?us-ascii?Q?yKU/usDqiEmRbhc/2GNl+9m3oQiugy6OwAsVb5Hv+C+KjktEuJPABYfWZQFl?=
 =?us-ascii?Q?ryOqepORAb6W/+qkVRe0kBJF3+kgu9mrJS1j6CmPA1KA1DmUs8//QAl+8MSc?=
 =?us-ascii?Q?enscZUvI1se6gVFQAYSrveJVBOgwYZdsP/344z8JXSyvtN+I/btdrPlc1kpj?=
 =?us-ascii?Q?K+LgvVdtF3VgLBDqKcc9PDB2BvYtBL3QLShxggKgFrI39Oh3GpbisJ7F/ZVp?=
 =?us-ascii?Q?En3zzBfBWldO2KKzZ30FTh8AZxUUoAi08Ks6WOK16hInKG1+VUU2vH3+ze9V?=
 =?us-ascii?Q?7gjZVgR/KTWUJhIRC/U9WugL+6pX3+3OFq4Yz9+cBrRcrnREl4kisl4+7LGz?=
 =?us-ascii?Q?idxxzZ14MLvnRJTGwxEYriE+oLbN9GBVs76PgUWGIJQWlI5b2su+3puGV0Co?=
 =?us-ascii?Q?tXkQb748Wg6YSgyhrUiIy67xNwEJfuRpFUOVrR1ye+XWCY9oXxiWAUjH00PJ?=
 =?us-ascii?Q?5Guek+gaTLwr+dMVZZfkeMwrJzJ56Sq7TVV/kpOHB0z8HMu1OyrblgA2yHlX?=
 =?us-ascii?Q?ZrVlLjWOrjy7LAg+Gv+FCZ6uIYOvMNQ30lpAo9D+IiaM/UMKhyYlOxK7Eswu?=
 =?us-ascii?Q?LxiegYpqcCMObLvAInB+YH78WoB12lmViSPHvrytLzshgsuBPUShn1ZKRU6f?=
 =?us-ascii?Q?7uRCxZgcpqeWhvSSvmfgjjNSCcIeap56XfTNZSqgvLNhr8MQEqt4SQJe7HZo?=
 =?us-ascii?Q?+0DK0ADOcre0GpRDg41ca3eS6tZ+Pi32qFdJ44fq3omSS9j2YyM0xql82yaW?=
 =?us-ascii?Q?GHXhvL0dgzXiZSKG689LRDdK8FvNXKqdAE9/YfKutnqFDE9DaECvnonNgh5T?=
 =?us-ascii?Q?wmsAGJ9iv3vOIe9Ky6OnVT/r6Dy0ooIzuAjwytIKnkwF2/iTVUn5v63EMtr3?=
 =?us-ascii?Q?niBTAu1+ECUjMiyJASRnsgXKqQOczdZtAt9EAPsElF0J7UWc1T24f8TgZEKp?=
 =?us-ascii?Q?geFg0qP2CQBP8rkiCTc5gqniNJcMZhdQX3ys9QvGurO/VYykS9sVzBw0VBPW?=
 =?us-ascii?Q?l7X2VLW1GzTfpmPjY3EU0eA6R8mBc8d2wnqBI+1eAYfR/myCTkOHrehJ60za?=
 =?us-ascii?Q?yaELUMO2uiS6osQHk54xP0Vw0+UC+dDd9I0j858mcTdJQHlFnAh07+6iuJ8i?=
 =?us-ascii?Q?opoVf8S2VLUZm5SbgJxD66ALbYiCD5KKSm8WmPEwdFW04bPonF4UIx0uGdte?=
 =?us-ascii?Q?Dw3MboOpfG8BKRleUgMzOiebRIiSN1ItjtQyk+p/TqGscOW17XKH+IvU525/?=
 =?us-ascii?Q?wp2tmCx1HqXJxcT2jOFreQRIu3uYErJgGsbFR3LnFS1TAGW9jmENcEPS9tCr?=
 =?us-ascii?Q?XzmGkGdn5vBnGHMjoRBzXvSmtMc7yPpEGZVVjaR7KMGw89ZtnVihhAalhMIX?=
 =?us-ascii?Q?lbgcIWD0viwWCGIxUkMYJl+gwsTQ4ek=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3cf1651-6c5d-469d-296d-08df2991d7dd
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 01:24:07.9957 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u+BNMWKKyaCWbwRpO/nQqeJYkFlLLai6Mpd8HSLpsQrW1d0uid2UPpVpAwXmZJHqianseJJyOQJit0Qzg/fsQIIMX51TZnTTuvC+TP+5hTQ=
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

Exercise Config, WayEnable, and indexed WayMask registers on the
PolarFire and FU540 integrations, including their different master
counts, reset, monotonic writes, and unimplemented-register logging.

Verify that enabling cache ways hides the corresponding LIM range,
while the controller's Zero window stays accessible. Check that reset
restores hidden LIM data without clearing the Zero RAM stand-in.

Migrate register state and both RAM backings, verify the destination
LIM view, and confirm that writes to hidden addresses do not alter the
data restored by a later reset.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

(no changes since v3)

Changes in v3:
- Rename the test for the shared SiFive L2CC model
- Exercise 15 masters on PolarFire and 21 masters on FU540

 MAINTAINERS                    |   1 +
 tests/qtest/sifive_l2cc_test.c | 306 +++++++++++++++++++++++++++++++++
 tests/qtest/meson.build        |   3 +
 3 files changed, 310 insertions(+)
 create mode 100644 tests/qtest/sifive_l2cc_test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1312bbd1bd..acb79a7d61 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1827,6 +1827,7 @@ F: docs/system/riscv/sifive_u.rst
 F: hw/*/*sifive*.c
 F: include/hw/*/*sifive*.h
 F: tests/functional/riscv64/test_sifive_u.py
+F: tests/qtest/sifive_l2cc_test.c
 
 Tenstorrent Machines
 M: Joel Stanley <joel@jms.id.au>
diff --git a/tests/qtest/sifive_l2cc_test.c b/tests/qtest/sifive_l2cc_test.c
new file mode 100644
index 0000000000..fef80f3438
--- /dev/null
+++ b/tests/qtest/sifive_l2cc_test.c
@@ -0,0 +1,306 @@
+/*
+ * QTest testcase for the SiFive L2 cache controller
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
+#include "qemu/units.h"
+#include "libqtest.h"
+#include "migration/migration-qmp.h"
+#include "migration/migration-util.h"
+
+#define L2CC_BASE                       0x02010000
+#define L2CC_CONFIG                     0x000
+#define L2CC_CONFIG_VALUE               0x06091004
+#define L2CC_WAY_ENABLE                 0x008
+#define L2CC_ECC_INJECT                 0x040
+#define L2CC_FLUSH64                    0x200
+#define L2CC_WAY_MASK_BASE              0x800
+#define L2CC_WAY_MASK_COUNT             15
+#define L2CC_MAX_MASTERS                21
+#define L2CC_WAY_MASK(n)                (L2CC_WAY_MASK_BASE + 8 * (n))
+#define L2CC_MASTER15                   L2CC_WAY_MASK(L2CC_WAY_MASK_COUNT)
+#define L2CC_WAY_ENABLE_RESET           0
+#define L2CC_WAY_MASK_RESET             UINT64_MAX
+
+#define L2_LIM_BASE                     0x08000000
+#define L2_WAY_SIZE                     (128 * KiB)
+#define L2_LIM_RESET_WAYS               15
+#define L2_ZERO_BASE                    0x0a000000
+#define L2_ZERO_SIZE                    (2 * MiB)
+
+static QTestState *sifive_l2cc_start(const char *firmware)
+{
+    return qtest_initf("-machine microchip-icicle-kit -smp 5 -m 2G "
+                       "-bios \"%s\"", firmware);
+}
+
+static char *sifive_l2cc_create_firmware(void)
+{
+    static const uint8_t firmware[] = {
+        0x13, 0x00, 0x00, 0x00,
+        0x6f, 0x00, 0x00, 0x00,
+    };
+    char *path;
+    int fd;
+    ssize_t written;
+
+    fd = g_file_open_tmp("sifive_l2cc_XXXXXX", &path, NULL);
+    g_assert_cmpint(fd, >=, 0);
+
+    written = write(fd, firmware, sizeof(firmware));
+    g_assert_cmpint(written, ==, sizeof(firmware));
+    close(fd);
+
+    return path;
+}
+
+static uint64_t l2cc_way_mask_test_value(unsigned int master)
+{
+    return UINT64_C(0xfedcba9876543201) + master;
+}
+
+static void test_l2cc_registers(void)
+{
+    g_autofree char *firmware = sifive_l2cc_create_firmware();
+    QTestState *qts = sifive_l2cc_start(firmware);
+    unsigned int i;
+
+    unlink(firmware);
+
+    g_assert_cmphex(qtest_readl(qts, L2CC_BASE + L2CC_CONFIG), ==,
+                    L2CC_CONFIG_VALUE);
+    qtest_writel(qts, L2CC_BASE + L2CC_CONFIG, UINT32_MAX);
+    g_assert_cmphex(qtest_readl(qts, L2CC_BASE + L2CC_CONFIG), ==,
+                    L2CC_CONFIG_VALUE);
+
+    g_assert_cmphex(qtest_readb(qts, L2CC_BASE + L2CC_WAY_ENABLE), ==,
+                    L2CC_WAY_ENABLE_RESET);
+    qtest_writeb(qts, L2CC_BASE + L2CC_WAY_ENABLE, 0xd);
+    g_assert_cmphex(qtest_readb(qts, L2CC_BASE + L2CC_WAY_ENABLE), ==, 0xd);
+    qtest_writeb(qts, L2CC_BASE + L2CC_WAY_ENABLE, 3);
+    g_assert_cmphex(qtest_readb(qts, L2CC_BASE + L2CC_WAY_ENABLE), ==, 0xd);
+    qtest_writeq(qts, L2CC_BASE + L2CC_WAY_ENABLE, 0xf);
+    g_assert_cmphex(qtest_readq(qts, L2CC_BASE + L2CC_WAY_ENABLE), ==, 0xf);
+    qtest_writeb(qts, L2CC_BASE + L2CC_WAY_ENABLE, 0xe);
+    g_assert_cmphex(qtest_readb(qts, L2CC_BASE + L2CC_WAY_ENABLE), ==, 0xf);
+
+    for (i = 0; i < L2CC_WAY_MASK_COUNT; i++) {
+        g_assert_cmphex(qtest_readq(qts, L2CC_BASE + L2CC_WAY_MASK(i)), ==,
+                        L2CC_WAY_MASK_RESET);
+        qtest_writeq(qts, L2CC_BASE + L2CC_WAY_MASK(i),
+                     l2cc_way_mask_test_value(i));
+    }
+    for (i = 0; i < L2CC_WAY_MASK_COUNT; i++) {
+        g_assert_cmphex(qtest_readq(qts, L2CC_BASE + L2CC_WAY_MASK(i)), ==,
+                        l2cc_way_mask_test_value(i));
+    }
+
+    qtest_system_reset(qts);
+    g_assert_cmphex(qtest_readl(qts, L2CC_BASE + L2CC_CONFIG), ==,
+                    L2CC_CONFIG_VALUE);
+    g_assert_cmphex(qtest_readb(qts, L2CC_BASE + L2CC_WAY_ENABLE), ==,
+                    L2CC_WAY_ENABLE_RESET);
+    for (i = 0; i < L2CC_WAY_MASK_COUNT; i++) {
+        g_assert_cmphex(qtest_readq(qts, L2CC_BASE + L2CC_WAY_MASK(i)), ==,
+                        L2CC_WAY_MASK_RESET);
+    }
+
+    qtest_quit(qts);
+}
+
+static void test_l2lim_topology(void)
+{
+    g_autofree char *firmware = sifive_l2cc_create_firmware();
+    uint32_t original[L2_LIM_RESET_WAYS];
+    const uint32_t poison = 0xdeadc0de;
+    const uint64_t zero_last = L2_ZERO_BASE + L2_ZERO_SIZE - 4;
+    QTestState *qts = sifive_l2cc_start(firmware);
+    unsigned int i;
+
+    unlink(firmware);
+
+    /* Check the fixed aperture, not the RAM stand-in's eviction behavior */
+    qtest_writel(qts, zero_last, 0xa55a9669);
+    g_assert_cmphex(qtest_readl(qts, zero_last), ==, 0xa55a9669);
+
+    for (i = 1; i <= L2_LIM_RESET_WAYS; i++) {
+        uint64_t l2lim_size = (L2_LIM_RESET_WAYS - i) * L2_WAY_SIZE;
+        uint64_t hidden = L2_LIM_BASE + l2lim_size;
+        uint32_t tail = 0x96000000 | i;
+
+        original[i - 1] = 0x69000000 | i;
+        qtest_writel(qts, hidden, original[i - 1]);
+        g_assert_cmphex(qtest_readl(qts, hidden), ==, original[i - 1]);
+
+        if (l2lim_size) {
+            qtest_writel(qts, hidden - 4, tail);
+            g_assert_cmphex(qtest_readl(qts, hidden - 4), ==, tail);
+        }
+
+        qtest_writeb(qts, L2CC_BASE + L2CC_WAY_ENABLE, i);
+        g_assert_cmphex(qtest_readb(qts,
+                                   L2CC_BASE + L2CC_WAY_ENABLE), ==, i);
+        if (l2lim_size) {
+            g_assert_cmphex(qtest_readl(qts, hidden - 4), ==, tail);
+        }
+        g_assert_cmphex(qtest_readl(qts, hidden), ==, 0);
+        qtest_writel(qts, hidden, poison);
+        g_assert_cmphex(qtest_readl(qts, hidden), ==, 0);
+        g_assert_cmphex(qtest_readl(qts, zero_last), ==, 0xa55a9669);
+    }
+
+    qtest_writeb(qts, L2CC_BASE + L2CC_WAY_ENABLE, UINT8_MAX);
+    g_assert_cmphex(qtest_readb(qts, L2CC_BASE + L2CC_WAY_ENABLE), ==,
+                    UINT8_MAX);
+    g_assert_cmphex(qtest_readl(qts, L2_LIM_BASE), ==, 0);
+    qtest_writeb(qts, L2CC_BASE + L2CC_WAY_ENABLE, 3);
+    g_assert_cmphex(qtest_readb(qts, L2CC_BASE + L2CC_WAY_ENABLE), ==,
+                    UINT8_MAX);
+    g_assert_cmphex(qtest_readl(qts, L2_LIM_BASE), ==, 0);
+
+    qtest_system_reset(qts);
+    g_assert_cmphex(qtest_readb(qts, L2CC_BASE + L2CC_WAY_ENABLE), ==,
+                    L2CC_WAY_ENABLE_RESET);
+    for (i = 1; i <= L2_LIM_RESET_WAYS; i++) {
+        uint64_t restored = L2_LIM_BASE +
+                            (L2_LIM_RESET_WAYS - i) * L2_WAY_SIZE;
+
+        g_assert_cmphex(qtest_readl(qts, restored), ==, original[i - 1]);
+    }
+    g_assert_cmphex(qtest_readl(qts, zero_last), ==, 0xa55a9669);
+
+    qtest_quit(qts);
+}
+
+static void test_l2cc_master_count(void)
+{
+    g_autofree char *firmware = sifive_l2cc_create_firmware();
+    QTestState *qts = qtest_initf(
+        "-machine sifive_u -smp 5 -bios \"%s\"", firmware);
+    const uint64_t zero_last = L2_ZERO_BASE + L2_ZERO_SIZE - 4;
+    unsigned int i;
+
+    unlink(firmware);
+
+    for (i = 0; i < L2CC_MAX_MASTERS; i++) {
+        g_assert_cmphex(qtest_readq(qts, L2CC_BASE + L2CC_WAY_MASK(i)), ==,
+                        L2CC_WAY_MASK_RESET);
+        qtest_writeq(qts, L2CC_BASE + L2CC_WAY_MASK(i),
+                     l2cc_way_mask_test_value(i));
+    }
+    for (i = 0; i < L2CC_MAX_MASTERS; i++) {
+        g_assert_cmphex(qtest_readq(qts, L2CC_BASE + L2CC_WAY_MASK(i)), ==,
+                        l2cc_way_mask_test_value(i));
+    }
+    g_assert_cmphex(qtest_readq(qts,
+                                L2CC_BASE + L2CC_WAY_MASK(L2CC_MAX_MASTERS)),
+                    ==, 0);
+    qtest_writel(qts, zero_last, 0x12345678);
+    qtest_writel(qts, L2_ZERO_BASE + L2_ZERO_SIZE, 0xdeadc0de);
+    g_assert_cmphex(qtest_readl(qts, L2_ZERO_BASE + L2_ZERO_SIZE), ==, 0);
+    qtest_writeb(qts, L2CC_BASE + L2CC_WAY_ENABLE, 15);
+    g_assert_cmphex(qtest_readl(qts, zero_last), ==, 0x12345678);
+    g_assert_cmphex(qtest_readl(qts, L2_LIM_BASE), ==, 0);
+
+    qtest_system_reset(qts);
+    for (i = 0; i < L2CC_MAX_MASTERS; i++) {
+        g_assert_cmphex(qtest_readq(qts, L2CC_BASE + L2CC_WAY_MASK(i)), ==,
+                        L2CC_WAY_MASK_RESET);
+    }
+    qtest_quit(qts);
+}
+
+static void test_l2cc_migration(void)
+{
+    g_autofree char *firmware = sifive_l2cc_create_firmware();
+    QTestState *from = sifive_l2cc_start(firmware);
+    QTestState *to = qtest_initf(
+        "-machine microchip-icicle-kit -smp 5 -m 2G "
+        "-bios \"%s\" -incoming defer", firmware);
+    const uint64_t hidden = L2_LIM_BASE + 8 * L2_WAY_SIZE;
+    const uint64_t zero_last = L2_ZERO_BASE + L2_ZERO_SIZE - 4;
+
+    unlink(firmware);
+
+    qtest_writel(from, L2_LIM_BASE, 0x11223344);
+    qtest_writel(from, hidden, 0x55667788);
+    qtest_writel(from, zero_last, 0x99aabbcc);
+    qtest_writeb(from, L2CC_BASE + L2CC_WAY_ENABLE, 7);
+    qtest_writeq(from, L2CC_BASE + L2CC_WAY_MASK(14), 0x1234);
+    g_assert_cmphex(qtest_readl(from, hidden), ==, 0);
+
+    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", NULL, "{}");
+    migrate_qmp(from, to, NULL, NULL, "{}");
+    wait_for_migration_complete(from);
+
+    g_assert_cmphex(qtest_readb(to, L2CC_BASE + L2CC_WAY_ENABLE), ==, 7);
+    g_assert_cmphex(qtest_readq(to, L2CC_BASE + L2CC_WAY_MASK(14)), ==, 0x1234);
+    g_assert_cmphex(qtest_readl(to, L2_LIM_BASE), ==, 0x11223344);
+    g_assert_cmphex(qtest_readl(to, hidden), ==, 0);
+    qtest_writel(to, hidden, 0xdeadc0de);
+    g_assert_cmphex(qtest_readl(to, zero_last), ==, 0x99aabbcc);
+
+    qtest_system_reset(to);
+    g_assert_cmphex(qtest_readb(to, L2CC_BASE + L2CC_WAY_ENABLE), ==, 0);
+    g_assert_cmphex(qtest_readl(to, hidden), ==, 0x55667788);
+    g_assert_cmphex(qtest_readl(to, zero_last), ==, 0x99aabbcc);
+
+    qtest_quit(from);
+    qtest_quit(to);
+}
+
+static void test_l2cc_unimplemented(void)
+{
+    g_autofree char *firmware = sifive_l2cc_create_firmware();
+    g_autofree char *log_path = NULL;
+    g_autofree char *log = NULL;
+    QTestState *qts;
+    int fd;
+
+    fd = g_file_open_tmp("sifive_l2cc_unimp_XXXXXX", &log_path, NULL);
+    g_assert_cmpint(fd, >=, 0);
+    close(fd);
+
+    qts = qtest_initf(
+        "-machine microchip-icicle-kit -smp 5 -m 2G -bios \"%s\" "
+        "-d unimp -D \"%s\"", firmware, log_path);
+    unlink(firmware);
+
+    g_assert_cmphex(qtest_readl(qts, L2CC_BASE + L2CC_ECC_INJECT), ==, 0);
+    qtest_writeq(qts, L2CC_BASE + L2CC_FLUSH64, 0x1234);
+    g_assert_cmphex(qtest_readq(qts, L2CC_BASE + L2CC_MASTER15), ==, 0);
+    qtest_quit(qts);
+
+    g_assert_true(g_file_get_contents(log_path, &log, NULL, NULL));
+    g_assert_nonnull(strstr(log,
+        "unimplemented device read (size 4, offset 0x40)"));
+    g_assert_nonnull(strstr(log,
+        "unimplemented device write (size 8, value 0x1234, offset 0x200)"));
+    g_assert_nonnull(strstr(log,
+        "unimplemented device read (size 8, offset 0x878)"));
+    unlink(log_path);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    if (qtest_has_machine("microchip-icicle-kit")) {
+        qtest_add_func("/sifive_l2cc/registers", test_l2cc_registers);
+        qtest_add_func("/sifive_l2cc/l2lim_topology", test_l2lim_topology);
+        qtest_add_func("/sifive_l2cc/unimplemented", test_l2cc_unimplemented);
+        qtest_add_func("/sifive_l2cc/migration", test_l2cc_migration);
+    }
+    if (qtest_has_machine("sifive_u")) {
+        qtest_add_func("/sifive_l2cc/master_count", test_l2cc_master_count);
+    }
+
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 200abf6f36..1fe008c9ed 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -311,6 +311,7 @@ qtests_riscv32 = \
 
 qtests_riscv64 = ['riscv-csr-test'] + \
   (unpack_edk2_blobs ? ['bios-tables-test'] : []) + \
+  (config_all_devices.has_key('CONFIG_SIFIVE_L2CC') ? ['sifive_l2cc_test'] : []) + \
   (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
    config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
    ['iommu-riscv-test'] : []) + \
@@ -427,6 +428,8 @@ qtests = {
   'erst-test': files('erst-test.c'),
   'ivshmem-test': [rt, '../../contrib/ivshmem-server/ivshmem-server.c'],
   'migration-test': test_migration_files + migration_tls_files + migration_colo_files,
+  'sifive_l2cc_test': files('migration/migration-qmp.c',
+                           'migration/migration-util.c'),
   'pxe-test': files('boot-sector.c'),
   'pnv-xive2-test': files('pnv-xive2-common.c', 'pnv-xive2-flush-sync.c',
                           'pnv-xive2-nvpg_bar.c'),
-- 
2.53.0


