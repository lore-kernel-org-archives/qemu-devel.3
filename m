Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB4C606A32D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 15:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=J3venBFS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOd8Z-0001fQ-4F; Wed, 04 Nov 2026 10:42:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOd8V-0001b4-8F; Wed, 04 Nov 2026 10:42:51 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOd8S-0001DQ-R6; Wed, 04 Nov 2026 10:42:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JMmJdDFWdIDx40sdlPE19zohxAeBvuuT2mbmsE6bw1pLI7KYg2vFwoR1nbgH9ec7BplCvKS4bu0uEBiHVcuZa88CbY/m/dVFJu4Bd+O/QSn/WtXDG+naIwJSzrPKFL4uAI2njnVYlkz1kmiSytw5fWf4FJSvHwtEFOkYr4SXTY55noaUh7oyfBKHoWXuJBLJHxlN80hMwjzwryTnMyyVrxUkQ4BB8/9KFTxxBXsGQ28B5qNtGE489Psd05xHT2Cl3Spr+E3AN4WAh9gX3KnFNoacsSXCwZbDbSyShvExT3noSXHkHB9piuQ7ixZGEeeCC3qa7aiyi2nWcFtDNPgMHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ABNLyohnCCVwtoGB5Ei7DRhReVxoY+IqVGIigoDfHI=;
 b=hZQkDFiqUjpKrPDts6F1xaeOXlGf5Jjjjz4X0eKChKlMVo9IxzUZ/DCae2XbNvguoWw6ja09woSquaT0o7h7Oy+uyd96S/Znk3BP9MJTuoK9t9HM6/OEHErdVLEOOOZQ87JzNVL+AiNrlnWXsQdqupIr3x+rvw5bVv3eq5GHRC0ISmzPTTIlrZ6SPR0V+CQPY/FxNzRupaLHY6E1bBmKF13HL+Dc5h14pX1ier5Cj4/Ld/xWf9m5ZGnSYX9EiDOsBrUfC51LL08/kNm7Lz8gciPUBk083wqfS9bOcWIPZGk4Maj7IET4BNdVhY3Bhz8oIpU3ABccD5fCeZYcFkKvjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ABNLyohnCCVwtoGB5Ei7DRhReVxoY+IqVGIigoDfHI=;
 b=J3venBFSZjjkfhYvkt0Bk+WSElWbU4sd8cSDysBJU21v70+aY2/qSpNY9guPI5Nus0L4D8uxfbuCkZeM0VrJXnt6wFiSv0oFXcROGBuYREg6g8ITqsinHHxyKAiiuf3zadTGhGpxtuZjVdZ3jdAUEIUBrBZUkXn3NXn2Rnl2hlUYUtA1j189givnTab8Kqj5rUkOcPawvihj5xFX33nFC1YW4QcVO117+6vYWnja0H7F1K7+HpQcYc+fbxfUaa1PNbbtnO3hQPsoOmZiNxvenZBMtntBixgywq04qQQQTerZmSvqyTBU2UgKtPIfHiwQrfEkfxaPyuc2npywgNn8ZQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com (2603:1096:405:2c::12)
 by SEYPR02MB9159.apcprd02.prod.outlook.com (2603:1096:101:302::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 15:42:40 +0000
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10]) by TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 15:42:40 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-riscv@nongnu.org
Subject: [PATCH v5 08/26] tests/qtest: Add SiFive L2 cache controller coverage
Date: Wed,  4 Nov 2026 23:41:35 +0800
Message-ID: <20261104154207.641511-9-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: 81c825e2-6971-4f13-45e7-08df3a8a424a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|260925022911599003|260925021311599003|260925021911599003|5023799004|56012099006|261021123027099003|261021121427099003|261009223027099003|261009221227099003|261021135927099003|261102123227099003|261022105027099003|261028144727099003|261026140227099003|261026121527099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: apuml0mLEQB2BLiswXNrS2T++a8YQOhS6a2mCNedRpOwHyXoj9adG9KCayO5Kp29v6v2i6/zW3Y4lwOuT5vtMWs0IbLtIIK8kqd1vbhwmH/4sQkPHtxnYnRrt9HZcRt1YZboq+BlwnJGzA5rGFs20gWJm4k4u3MGXoqOX1heraAIlE0qdPySYxt85Iyqf1DSVQqdbjOEFX8eOCJzLn05bbPha1GtW8Q6R1HlDHAYosMTFuo/fkgA1Q8clSrSJtH8eqsq5/cNmWCUp0+YJf31zsAvhvzPiPM8qPAq+jrtmkEHx+mfB/PcgoMkATrLSzd3GdFSUBFBXCLL023rHBX5XIVfJDknulavNtXJC1AoAORh4S3iISqE/m/Hke3EyJw/W3HA8mfgjEgaT2GtJFNMhcUewMr6MZu4aoKDESSefU1YkTHbktt5wwUquNvDN0C+p91nzFkv513MGt61LxEjW0OosTVRZky6iBnVv0gpRddV/rL6cNUNIwf/3xJyUb6QZGcYb3roQUUKvIvEIZHRAyMRJs/729lxcPlDfMZkKzfX0S3aepp25in+SBgeT+mgdgsYTZnxCHqBL/nH1X+dFzES2J2Y5dCTFxlWuxl1PoKsa1w1zrR0E4UfejByn3UkGiahdtVB9m3o2LDDA9IuvMME6U641Iw85s7ag5SG+II=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR02MB7121.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(260925022911599003)(260925021311599003)(260925021911599003)(5023799004)(56012099006)(261021123027099003)(261021121427099003)(261009223027099003)(261009221227099003)(261021135927099003)(261102123227099003)(261022105027099003)(261028144727099003)(261026140227099003)(261026121527099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HwivVowjwme85qLQzpGgUUbu+5RJfOPd1UdBuvtJXsjJaUOAlB3XbYxe6aJS?=
 =?us-ascii?Q?fPc8h2Ie03qFFwNLJZwkNVw6yJgR7gdvVIv5dbOaf46A1O9plJ0rEb8P5ool?=
 =?us-ascii?Q?fr0XGCK5aVhMPt0zWF2oRGX8s7wEWrN+3TgeclO17P+x+fy7C5hiY3ukP+Jm?=
 =?us-ascii?Q?qcjoOFho8NVxc4mQuKop70ANgMl0nYJwjCkg2JDmwEiIApwhEbxIFsH8oc73?=
 =?us-ascii?Q?UPK8H9ZS1IJhVnbZT9pOW2jd0pNajSZuUAD6+ENX+HmOAzCm2/PQV5zq1ZPO?=
 =?us-ascii?Q?2vabLNHyjIYfx45hh7x7cIgnFkWnfr9r4g8j5fKM2AzSUchvSCpfJq0mjRSr?=
 =?us-ascii?Q?VEzMa0pTE2DuvmG+YLUnvqdtvlfj92UCa0ZVoSNHGGzIErW25/Eq2Gk9X8k+?=
 =?us-ascii?Q?uM/zarB4E7DGDKJ+RYvx2zcwIxurJPX/hoOJ35XhNJV+ggY+hRtAWhr1ESYv?=
 =?us-ascii?Q?acICrJB8riD4zfYM1k5qqGctjrIv5ZAJLEToYPtR2X40QV6TgWiaB6n1JTMD?=
 =?us-ascii?Q?IpBbhi19feVN+B/v0I6HJQ9T7y7dCdK+HcGWg1kNcBOyOvY4jGtEAkdUVXKl?=
 =?us-ascii?Q?AnRIPAehDD+maKa4yjnabpd1BvLyB9GS/wWIIOzAjCV9Ac5bSug7rPOL3LlD?=
 =?us-ascii?Q?tSoAPhRW6fUJXugFMgHlM0b9N2rIwek9xzyHmXv7BynqTh5vDhxwDHVWhP7H?=
 =?us-ascii?Q?smG0RFTd2xRSKfMtFZndG51KQjtAJ4WG+6ZkDMBq5wvkD3g7falSgSNAEln4?=
 =?us-ascii?Q?ij1V85Ct1OHUtdQWpQ9lF+Qw5Y/GEnfAz1T01Bxk8FqbH0+fZE75Kap2u3O3?=
 =?us-ascii?Q?J8sfkncyWuaxr7FotO1Ucln7oPO1XbdqPDEOvOdRxLy+PYsnzreiUiS1A2aa?=
 =?us-ascii?Q?cBgeMKqPbddvFrYvvSgHO989bt79tW34u0d8Gpkjkwii0EJx37jgVM8WlriU?=
 =?us-ascii?Q?xEfPsaNeJHADLnKdCnCNLjRZBRyBroHwvD5eJRuRYE32GMVev4Hnk3YJBRNw?=
 =?us-ascii?Q?p2oZJIzXhLFmvBilT1fyFtkAvDak1/wYhMs0YcnpYZkNeB88C57roDBqBGLn?=
 =?us-ascii?Q?MaD1ei5hdTOuLYrNd2jS7BZIYPZ/6DVgnTbnJ7XTw8FSvUJd1Hs5RnOuGTPS?=
 =?us-ascii?Q?oPVsL0ncUu4/8FwE7rmt5tZ6142CndatUmEThY1ysz+eWxPhDJI0z40txHGn?=
 =?us-ascii?Q?SJi84N+AelDw/g8TDCksW+Jo+j23NWEbb/5RST6eUtrU6WQ/cOqbFymc850k?=
 =?us-ascii?Q?fiOHrvg9lNIhVUOHkS9OdDnuGrE3n3dyvym+R02IPw0qj0PhjGYmrx8PkXPK?=
 =?us-ascii?Q?8Hsc93dCvU1oYUq2dZvrxNbHzzQOMsw6JehM7PconYeaaudloxe/MAIsgOTU?=
 =?us-ascii?Q?SVzxddWp9N51TAJ4mMQrCykEp/xO4ePwcqfFgHlytMcXxvIvqTG0yg+cUIgk?=
 =?us-ascii?Q?pxaHpKKZ4TPvoCDM1y8m/sryjPrk40vYnqDw7ggdegB+7nmnoL61/W7nhJua?=
 =?us-ascii?Q?e4vUJkd1xKrpAP8QqKWN/WcxIRRPfEbraM1du8FJniVb6v3loNOymHYTwa/o?=
 =?us-ascii?Q?aduenL4jZkSRQVTGrGauWjIxa/ACsxH0dAFU09iK4DoZGmCOGz7Mbwqk0XoB?=
 =?us-ascii?Q?Px4qa701oPAMp1jiU/ByYBP+FxZ7MM5wTuKkr0d53mSWDh/xweva/9+vbf7H?=
 =?us-ascii?Q?f/HcyEXWVaD/JzYIj6DEI2kl4fLLaKSha905EACzqJmyNjq3vCMfHFrG2PK3?=
 =?us-ascii?Q?bW6czItayFkBEbmnCRke3JMhwqxzoSI=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81c825e2-6971-4f13-45e7-08df3a8a424a
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7121.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 15:42:40.3707 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yMvAUKpO5eGc3U69LUgiL3aRGJ/Dj1yxynydJMyL/SvtlAD/+Yot7TcTbWeMdvBtbf9Ijl4yIzzCuHDI1zE9rSzSDNG8OmFucgCD5DENo28=
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
index 55463103ff..4bef2dffb0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1851,6 +1851,7 @@ F: docs/system/riscv/sifive_u.rst
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
index ff4bf9528a..a001409de2 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -317,6 +317,7 @@ qtests_riscv32 = \
 
 qtests_riscv64 = ['riscv-csr-test'] + \
   (unpack_edk2_blobs ? ['bios-tables-test'] : []) + \
+  (config_all_devices.has_key('CONFIG_SIFIVE_L2CC') ? ['sifive_l2cc_test'] : []) + \
   (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
    config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
    ['iommu-riscv-test'] : []) + \
@@ -438,6 +439,8 @@ qtests = {
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


