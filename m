Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37245606ECC0
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 17:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=Lj5WBv7+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOetn-0004Xq-SO; Wed, 04 Nov 2026 12:35:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOet5-0003Ot-IL
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 12:35:03 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOet1-0006Dv-4q
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 12:35:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l19AotH92stg+4eiLeS0DU22yhS0RZuOUpwNDdPU0MZBmaKNa5CM4Of7OPfsSwJfel0LZofT0uNRP+D2oA1VoFsKIxN/4Eb9VmF2f+KU9XDOtx2xLD6J5vg9PRD5jI3Zm960rKMCtRWR7IeHh5A8JWIuWc525taycTSFXKmcMyvkcFVSnYiGynqu55eN54oCngebDgh8eQt+M1AePHQB9TGlsbPwZb+oehP/JKCNwlrkicltKdBM3aeLmfrvojG6RBqOKtZzMf4sbl1OWwADMcIjj6M+4aHb/H6uOIsc34a9sUT8G7O0PSVUAd5bgJCVjWUFiB4sIQ9UstFf3UaSsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vh1oekmywseXWoVEsx4HFgqSFqMOjzQj1AW84xw54Xo=;
 b=QPq5FI1X5vhyW/RFW+P48qb2BPi76yjJjpx9moDkacBg+dC/95zdmkg/GPZnvUOPglLkGEK8ARHsE0yWnC9wrlB94+xcVcH9G8vEascKHfaiE2sBPvbYvGMf1sSRLfMFnYvdPBMo6GOwi6FZHT5Sz5lHWbf6h+CxnfCVUXcW22NraMURriEjpSyWWuQ2TOQfgIXaUT4mv1Y7fjOPbR9KPOwTtgU8F3YrRMalSO6K4moBFtFDxb6ZQ3wOyTEAIhfT0ZJgLRCKet7Y2mKWh0NhLPgfEMt88+36q2Beqdj16a4+3NKK9x1mkgB+4n3EpkEvTzr+nU/j37mNMMMn/U6tYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vh1oekmywseXWoVEsx4HFgqSFqMOjzQj1AW84xw54Xo=;
 b=Lj5WBv7+TEskGd5HHgYXMqh0g3DEX3J7TFKp+nAwd9DKLR7fy67qywqAeVUybbdSnpfr10A6WxxwPLffBB84DeG32ZDbSJGD81CCBW7eFI/+9/XEunBwXCSh7MGtxcfwVb8QA7+iNK1VekNone3gTrlAf1+1u7FjaENN5lj97uoZ5t9mRRVYpAWuLJjOjj1/loQlcDghMqL64QqoAjrF/YwQetP97L85htWNMkAIt5ejybKOltejESon0fDLD6ociGk5C3TT9tSoYy83dfUCAUuLAfyOlgQB3UsGikGOJm4AROjZxglrCtDmuQVJThGTjNDRhMApQujvWPb6mgkxFw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com (2603:1096:405:2c::12)
 by KUXPR02MB8801.apcprd02.prod.outlook.com (2603:1096:d10:4c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 17:34:15 +0000
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10]) by TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 17:34:15 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 16/17] tests/tcg/ppc: Test byte comparison and parity on
 e5500/e6500
Date: Thu,  5 Nov 2026 01:33:19 +0800
Message-ID: <20261104173329.706635-17-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104173329.706635-1-bin.meng@processmission.com>
References: <20261104173329.706635-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0044.jpnprd01.prod.outlook.com
 (2603:1096:405:372::17) To TYZPR02MB7121.apcprd02.prod.outlook.com
 (2603:1096:405:2c::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR02MB7121:EE_|KUXPR02MB8801:EE_
X-MS-Office365-Filtering-Correlation-Id: 04a9f52e-713e-436e-6546-08df3a99d8ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|10067099003|18002099003|22082099003|56012099006|261026140227099003|261026121527099003|261028144727099003|261022105027099003|261021121427099003|261009223027099003|261102123227099003|260925021311599003|260925022911599003|260925021911599003;
X-Microsoft-Antispam-Message-Info: gF8KH2+IORGpRYv8vQwayNCYF/XBYcSBc41F+q4XF1eK4Oh9S0U7JStYSBXic7ZarPPZhX8puvENwXiwBqOs/FYjB8UixHRN/oDxkUcJeMdirJSwpgbJ/pGHU0h6zruVaQ5MlRzD77UTWT4CXHybA8xHI8rieK6cntAwOzN3rTai9y0lRnPbuRbecowPJV9/UfGWjQF6XWpd9VFM5RAQ7GgbX4612rgxj+ReGg0TEfefK0CE7YbV0K9BeUjbfkUWfwGSpRWmOCIa9bDU6Pi269mtRFIgwdD/Ato6f7kACLyedf8iAxhvZY6NN8xCjmLjuUfMwRrrdow00YlI0HGzbuvT/+BRy2UrcrDIiiQFqnAjaX97+kuP7keD4Vo3FdLCNc4qa/JydVG5te22gbRq8GfdUI4U1ZQDjEYC2c2IZs0t3RDg4aunKw5Tho1JpWuqeEzFNmx9iGLIXsAyiyJbV71NBXHXJ3aTpyokUEeGot3TRH7VLz7csKal/FBEbcabRxDTQ/cXRJK/p4x3GylzpDeslt+j6zuEW8O/5s/3g+ZCq2/GE4TmxuEixlp9NDBGeugUisdnd0+zs02CVsmP0k/NTnxtlS7ZCVCDEgR5kUowv2PQwW2g3Jgwmi0pzou30xItYiidthQufVVMpCz+YFnL/L0ca++FAz2+x0+70co=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR02MB7121.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(18002099003)(22082099003)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(261022105027099003)(261021121427099003)(261009223027099003)(261102123227099003)(260925021311599003)(260925022911599003)(260925021911599003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LG2tJCWlWw98WM9aE0L3Btu85dUFNzW45Eq4AUxx9e/w30gwH2ty6sKp4A1u?=
 =?us-ascii?Q?TJo4R4yTPziEt5IKx+4OcWf8uUYzKdqYMsj+9F0fnPnOn3uRO6g2XcesY0Wu?=
 =?us-ascii?Q?+9nW4W6W+iOeiYYz0OdmLBv4GnSaDKoDd3ZbJJaM3vW2SpleU70EbFeH5R2d?=
 =?us-ascii?Q?luny4D+OtvA+NORj0aczGy4p3ZoB2UeVWwdOO0LaBLRK2W118yvBIBzz4Irb?=
 =?us-ascii?Q?pqk11hXVs21YA+mQSUoWGqtdP7r7/9/0liM6qWP0bsyDMGT9i7SQ6FMQHQKM?=
 =?us-ascii?Q?1e47qYFYWFtqOm9CwtG9FJDzXltRiYUDWBnES/65qq+AcsMJfkJ/xnk5U+YV?=
 =?us-ascii?Q?IIQyONj9kb/KhUz5FViD86OR/amHBjSZudkzHqpUr0mKT0mMLj8UDGlZt5+K?=
 =?us-ascii?Q?UHMbSSuzCR5Jqgut5hJl4PYjfUoOiPYBGEm89SxOVFar6I8vnB0VzI/aMDnw?=
 =?us-ascii?Q?WGvr0uq1Bhnq81Jgkg/t5lgFnqRi/O+6aqSdYD1U4yBW2bza8deqEIfMM9JR?=
 =?us-ascii?Q?H/6ThhZaJVSOYzrhKHVYkXx9jHl5oPNur88H/8ZFoEztTG9jUHo0N2X14atp?=
 =?us-ascii?Q?bzTP/wrfvCziJyKB7N0SttCwQbzO7UapC8tPObaHsPIN5Snskf57RDfwOPPB?=
 =?us-ascii?Q?u1897xP9fGoXh4Yc29d6QNnuhZkSVs6lDCR61v7MjhIvPOsXZAXkhZL4h2GX?=
 =?us-ascii?Q?sx51Oe4M59HUtW3jfE0NnSLNMkSzXGxMYcA7iytLtYDHw4NCJdFTtLiYrcor?=
 =?us-ascii?Q?Sk65BSpRhZoHQoTo9pZ64scmJ5YEDOHD9KNKl/Kdh35rESOi89mIvmAO11KE?=
 =?us-ascii?Q?F+TQ4EZv0Rj44dq96mPHnmXm2GX2vY6YtImvM6UqJJLeC4OTPlXIQ+VvEGfM?=
 =?us-ascii?Q?LmRL9N7mKICDOCQOGBX5VCfviwlxHtYN6L3pKMCnnvzhgBnzY7/ZEqeZQN8P?=
 =?us-ascii?Q?VZimD6RikOLGwAd/6a7K1eNZYlHSLfSGuA+tMzDR+HbBUt4xRqHQ8dKw6tIk?=
 =?us-ascii?Q?Z2PzhEmxbd7haI8IegpdAdOH2JSC7CEWVLgGcH06cyJ0VpyLSqGYlBGBDyfV?=
 =?us-ascii?Q?ftoWqx7gyNWyvPgdYO2CArgb4bD7o0QuyaFtcm9WVf67l+yGwMb1hdx/c+A9?=
 =?us-ascii?Q?5ON8o3HY/9KJEGZKQGy988fq0BcN+j6A7LzwLeU8ftW6z1l4A20ysqqLHNz7?=
 =?us-ascii?Q?Bpzwgp5aBjh4a3I4pu0NuQZl/wj3cLMY819rilCM8OboQjU3eSfhQYGlMvU6?=
 =?us-ascii?Q?ONXdH8XH7R7z4WtBhrqqptUS0AmcjGHp3+UHqyeknLlEfw3LMODFqRDtpLEC?=
 =?us-ascii?Q?dYRN6ewDUEE3ZRa5NQL3bus6hrFsAFTJC939edzoXtvsPPlbfwhnHzTMwmlx?=
 =?us-ascii?Q?tMjGXt508dqzGCLsoQxDM5ucguGRx0434H5E2zvofn4cxQZ1xYdS8DPmo5YC?=
 =?us-ascii?Q?ihzOhVbcranb8Kbh6T+JrgXg/rUCHBp1IZLq08YCMOjGk7PoXinOyOA8b5DY?=
 =?us-ascii?Q?7RcM3TXJ2iMvC0ZaqGbht2Uh1OnzO5uH5TWeDpJJ9dbifRuBrRIs6Y7kU7ww?=
 =?us-ascii?Q?Xsks/yIZccA6bau8IlcntRjUgEYArZTeEi8DZVWgm8e7po2G0dZp4NLfGtsg?=
 =?us-ascii?Q?cPNW1oRErlS1bJ45gmUbNLWZnz7ERMUGg+i51Yszhb1tOzU+Ax+kLYtq0R7m?=
 =?us-ascii?Q?zKv47kqE+btao0x+xuR9ZY+ZlmwRvVVJZpE+sMELC6imwAOJQm/PvQw/tFud?=
 =?us-ascii?Q?HSUjo7RqXyZ4+ssZ6/AHszlZsg8Bfzc=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04a9f52e-713e-436e-6546-08df3a99d8ee
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7121.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 17:34:15.4577 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9RlU+No4oGHVBY0mryjwRhNgMYFKMJi5dGMDJLX9Jpeju+olQV1MH87MaExe3k6UYYuCEdiGf42Lpy9fVItk5UaWugjmCKAdMVsMqqWNA8k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR02MB8801
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

The e5500 and e6500 implement cmpb, prtyw and prtyd. Check matching-byte
masks and parity results, including the separate word results in a
64-bit register and parity based on the low bit of each byte.

Use inputs with odd parity in bits above each byte's low bit to reject
implementations that compute parity over all bits.

Add the test to the existing Book E matrix for e5500 and e6500 in
64-bit mode.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

(no changes since v1)

 tests/tcg/ppc/system/byte-parity.S | 33 ++++++++++++++++++++++++++++++
 tests/tcg/ppc64/system/meson.build |  1 +
 2 files changed, 34 insertions(+)
 create mode 100644 tests/tcg/ppc/system/byte-parity.S

diff --git a/tests/tcg/ppc/system/byte-parity.S b/tests/tcg/ppc/system/byte-parity.S
new file mode 100644
index 0000000000..f4d434c881
--- /dev/null
+++ b/tests/tcg/ppc/system/byte-parity.S
@@ -0,0 +1,33 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (c) 2026 Process Mission
+ */
+
+#include "macros.inc"
+
+    .text
+    .globl test_main
+test_main:
+    load_value r9, 0x1122334455667788
+    load_value r10, 0x1122994455660088
+    cmpb r11, r9, r10
+    check_value r11, 0xffff00ffffff00ff
+
+    .macro parity value, word, doubleword
+    load_value r9, \value
+    prtyw r11, r9
+    check_value r11, \word
+#ifdef _LP64
+    prtyd r11, r9
+    check_value r11, \doubleword
+#endif
+    .endm
+
+    /* Parity uses the least significant bit of each byte */
+    parity 0x0101010100010000, 1, 1
+    parity 0x0001010100010000, 0x100000001, 0
+    parity 0x8080808002020202, 0, 0
+    parity 0x0000000000000080, 0, 0
+    parity 0x8000000000000000, 0, 0
+    b pass
diff --git a/tests/tcg/ppc64/system/meson.build b/tests/tcg/ppc64/system/meson.build
index ca398860e3..ffa3060f05 100644
--- a/tests/tcg/ppc64/system/meson.build
+++ b/tests/tcg/ppc64/system/meson.build
@@ -6,6 +6,7 @@ ppc64_system_cflags = ppc_system_cflags + ['-m64']
 tests = []
 foreach cpu: ['e5500', 'e6500']
   sources = ppc_system_sources
+  sources += ['byte-parity.S']
   foreach src: sources
     tests += {
       '../ppc/system/' + src: {
-- 
2.53.0


