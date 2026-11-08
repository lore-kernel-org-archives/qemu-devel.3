Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C6D606A31C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 12:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=AfYdiphq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQ1cd-0000Gj-7M; Sun, 08 Nov 2026 07:03:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xQ1ai-0006sQ-HG; Sun, 08 Nov 2026 07:01:50 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xQ1ah-0000Wc-0T; Sun, 08 Nov 2026 07:01:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zEEDLlUQCFzQIDj6pW92DEtE2Ysfx5rrjBWUZi7d8+YYkGP3Lx2rBfy53WfiT4rU3M/EwyCuvTueWP60nNJMM5yNMhBUbaNJWLuR4+6E3TDN6jRu99geugC+YZHkhbPQQYlWO/u2zeBp/eAOtSHwa+Ko+zvH6r5MMhZ4ORHMzTjI+oB7B7cmnNRKRzxupgSuUBinmwlYbxGE607wcq0Sr8s55vZml0y/eWh2aDnKDKOTBRCKoGNn9Rk+vjcW07VYpu2KTJztSWR5IbhPOBFrZDNRoBHn6OiH93bsuPYCZsNW/iol+hv27J8kPzqvvz432G1vGI2NZogDIySEHQgvPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vh1oekmywseXWoVEsx4HFgqSFqMOjzQj1AW84xw54Xo=;
 b=aPPjtJRSCs9lA3IEb0cEYADHmmNsE/55WpJEe1asY2CxI0zmS0r2q6bvHRdi1P2MSVm0lvOYnI9H5TdSaNYxM9PNH87R6uz8QhA0ubWox+1m69kEfHwp8bILDAC7M8NilmTbvhT5rO80e/pQS0AmedLerWPSGtWK3jHiHRkSx/53x5USLdh1WSCuNn7fUym7tNMJhJ9iXHReAtTBcb8DS+aCj7DdF/xclHEXXyuDtKKasr1eu+1Wu+sPqoYWjattQuc+bngI/7Idd6YciBjG+A7hM8KMSc8oGzEvgmcQg/i/zQ8PWrIrZMoynOlK6fdmM8ymCz/Hku6gag0s5KauIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vh1oekmywseXWoVEsx4HFgqSFqMOjzQj1AW84xw54Xo=;
 b=AfYdiphqlJBI0LCUtNTs5nYYjcDSRUnL8L06Vx2Ox6GR4AvNQIgRqujDoBrgpTONX0uqqTJ7HOq/Q23L42ajlU319A+s0JlfmCCWMUFy/kldYeS0fj+41sxBP2mZjUPpGj+QwYUT3H1MSHf9ZKD4/JX+SmJSN38mFqM+dfHxjOCTEUaukW4AtJluGHThpF7bvGzrChrwYWPRNMyZ4EGoLH/K3EAXAhfY1XPmQMSXAr3JqUcFC9Mp0YW/e3P2AVDLD+rXvz3LmfxGa3aGztXTBtvmXeda5BBbUEtN3CcK95agrW6krOFswqii/h2G7otEqDCemKbAsKOJUyvVT0glxg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB7144.apcprd02.prod.outlook.com (2603:1096:820:116::10)
 by KUZPR02MB9138.apcprd02.prod.outlook.com (2603:1096:d10:61::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Sun, 8 Nov
 2026 12:01:37 +0000
Received: from KL1PR02MB7144.apcprd02.prod.outlook.com
 ([fe80::18f7:ed72:e33:ea5c]) by KL1PR02MB7144.apcprd02.prod.outlook.com
 ([fe80::18f7:ed72:e33:ea5c%6]) with mapi id 15.21.0592.010; Sun, 8 Nov 2026
 12:01:37 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: [PATCH v3 16/23] tests/tcg/ppc: Test byte comparison and parity on
 e5500/e6500
Date: Sun,  8 Nov 2026 20:00:15 +0800
Message-ID: <20261108120034.1755008-17-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261108120034.1755008-1-bin.meng@processmission.com>
References: <20261108120034.1755008-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0219.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::15) To KL1PR02MB7144.apcprd02.prod.outlook.com
 (2603:1096:820:116::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB7144:EE_|KUZPR02MB9138:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ff6f64e-c129-4606-3b89-08df3d900a73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|10067099003|261028144727099003|261102123227099003|261022105027099003|56012099006|261021121427099003|261026121527099003|261026140227099003|261009223027099003|260925021311599003|260925021911599003|260925022911599003;
X-Microsoft-Antispam-Message-Info: PBLt5lfkvRB/cfJi2H6dVB719Oud7dDLGsWpJivtMjI5IMu7LKJajA2bv3KVhPAfDi5S+66W62LWPnmLMFgNp8c7z+ruV7/JNbMkNX2r3ieazS7VSNsHCqDYT3HJdb/B8VwIyMnewdbLRt77CCpoLJdA0yxXJDUKlGmvVnxpovSkGTbfvTbEK2IUr1mgE8T9zh/PvvY0ggJe2qBcUjWB9VsPZtWVS03GTjZCAy8So77+MHQUj3Hm1MgVyKgfJesL6U9GUXAhUDjUJtYN5URih6TgUEXEu1065SPMlqMBlb95GRY5ga/tI0djlD5iVJrwvjnwd2QXExfe7QOooypevKFLJcIdPbqeACUZ4LRQnYqwbzegvDhQwVnQrT3Mk8y6x7NpbNrReymtOz4UXmAsVGYS0uT16rYEeeUlq/b6iITqe1xiEcjqxaWK1wC6ns/Wjb7mLKJinAl1sqlZOqbGQupCJvXAIEFG019/BE6HdluGdWMRVuk1wBggPpVzrnYn470Sk89a1uGLCSsr6iO1c2jYh4J9DJ1dB7TV9Bc6O1UCkpIghkwJKphLWa1GLOXVXWPyalOkyN0w8xj5ezBV7+AULooitLZj+9IWqjBlC3w6E1LxtKxBSD1+2zx1tre4r5DaHIr7sqaeYQmYjm2yBLuixl+hpjBFg9jowwxu4Cw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB7144.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(10067099003)(261028144727099003)(261102123227099003)(261022105027099003)(56012099006)(261021121427099003)(261026121527099003)(261026140227099003)(261009223027099003)(260925021311599003)(260925021911599003)(260925022911599003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FDm96LXV2322nbyLz8Dk6Db/nCAqvinBiYcdOTHOsCDgVrTGw5ff/hhte47O?=
 =?us-ascii?Q?79zzMQJjJRIZJPxRNdJA76maMtRmGklT38po7KOH3T5bHLXC3untofHEgJyw?=
 =?us-ascii?Q?oXHNL4dzbZmIlnjgT9Myq5AHTO2LNomDs504RwnJGix36WUtfVXg6B3x4dQB?=
 =?us-ascii?Q?0KF1o04Ve7AfdWSQOk6dgPvl9utnSxItzuLdGmzIgbbyMlxS9yr/SXiC+43r?=
 =?us-ascii?Q?V7XrlHT4EQuh4N+bXeZrMI1qbFivsjlC3aYZiWCRn26iO5+a9cr3vZXoYaEj?=
 =?us-ascii?Q?LXHu44dqRyiQRubT/PWVTSMIVh8ibuXWG31IQt3cv1i7GLYIfx+9OrbNZdhT?=
 =?us-ascii?Q?vuPW1rIWqlUlu83rThajrvlT4M6AZO4C92FhTO2NNSZ3aRr/b5Rdg7Tx5CdX?=
 =?us-ascii?Q?WyugbcjTiJWaE+bnL5nSdkUEsEHmgy5mYwEYZUQy9nm1eKQ61LlQs64MrCvO?=
 =?us-ascii?Q?n4XfHH/tFaB+5/QOppj1hKp4eE91QsZYFoGgYJ1pCgh0to09d3agHV9L8TWr?=
 =?us-ascii?Q?SXw6K6DR5WA80Pv+T3TE/61GibpvXBpPvMRaH5oQ1Qu5V1Om0JcAjC5bOYAa?=
 =?us-ascii?Q?mFxfecLERIYu4odVP4lqfoYB27bP8o+mYQupWM0Rjlzp0ns2HaUHfw8W6/o/?=
 =?us-ascii?Q?m71bYicHE3OflrjbgtCy+WTcXLbJ6szdiJR1ZnqP8qiATk+s4otMwekBvL/p?=
 =?us-ascii?Q?5RDV3S36HYwvV60Ukeu2OPCP2y0D2OlC6DjTByscPZX4bopxs24hp1/ctWaY?=
 =?us-ascii?Q?fGneBj7fqo5IR5GWWn9u/yVZEEaxVNXMd9hZMK9JZAF/S0glH1l/bDvc2utR?=
 =?us-ascii?Q?sjRW/8w4aFDgqOemRlb95tkITIbG/3FRvWNlIXoLIkpyo2L1cuISoEPhmVR5?=
 =?us-ascii?Q?f66WyLAw9puG160CNo/U96BkH/8dbEi2wPKKxJT1Nk7MBSvA9OQl0KuQCV+K?=
 =?us-ascii?Q?Ce84Ws68jCmPflAGYXPwH6UkkiRgtFxM8h+f/fOoXTA7t1fBETUzupIz35eK?=
 =?us-ascii?Q?mttIG0M70BjyEmqKs0YLNRpS9/vIbOiqJI7gIDJxzGq/1URCZ7QuYSpuRfI7?=
 =?us-ascii?Q?k61sm8SCNEZfHH5af9bVCfZ9YbNGOCzz5G7/2mk9PlYsIsAS2BItx4M64Bxi?=
 =?us-ascii?Q?Ke0+yyhH1g+RsLgCnmpOGoaUh4FHB/q5I7OUaouFe87ZnMl2qGcW4CjohD+2?=
 =?us-ascii?Q?ByFlQ6B3hUDUtoWU5QGtdi9qWTchikt1EtqiPkuIn0VOtgmt3MTOgeQmljmi?=
 =?us-ascii?Q?tEBi1PCcNNV6KVUiVGgHN/knRtw8XZylfk7KTiza1tKxvUYrLTAnJBcAzanY?=
 =?us-ascii?Q?A6Cd5zU1cW/nuDpzdIj8pruWcRLSFyW3cz5uyaQa4YlS3Jv1ZW1bD4CW6v/s?=
 =?us-ascii?Q?YBWPNuUbfwoTmKPkxUGqHA0dQNeg3kr8pJV/oJAzxgm85JMB3XrbLUcFxh2Q?=
 =?us-ascii?Q?OAqABrqWQ3h/A3M9GN+9a1EmVQHTt+HwVFnIyYv3Xz/cemlLvmmLia5lc33q?=
 =?us-ascii?Q?C0nzId0vV6sH13vRBSdEEgRf1AFHrp1Z7mZaWcsMPE0udIaXOszeggfFQ1Ll?=
 =?us-ascii?Q?9uDi3cK7zQ7OoigKf+bKIW3U8HY6SeS9bsy/49Agc0QWMXcBjXqZW74+RaM/?=
 =?us-ascii?Q?i2LA96wIpRE7+BhVeG797QUGh5dke3a3NAuzmGGJ/DMYbTXUbhnrssePtd8d?=
 =?us-ascii?Q?Qvcsf7w3EMOaW6nbS5yWSJVroCAuvAJELmaG+vkGroY4i6j8HM77mzvHQqTV?=
 =?us-ascii?Q?+cETi4qJciPmOJUF1BjZYKAlT0tquLE=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ff6f64e-c129-4606-3b89-08df3d900a73
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB7144.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2026 12:01:37.1225 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CROx8Me0iB2HNmwddbq5A2mMAK0sI8P4aSnkCsnzl6X6GDhnupPXBuaDy/adX2WmiPLMlioi6PcVgdWn4h+iw0aG3k5OCw+Ef32O4Y8EFcw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR02MB9138
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


