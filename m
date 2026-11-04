Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C389606A31B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 17:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=iAf3+udI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOetx-00053t-4u; Wed, 04 Nov 2026 12:35:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOet5-0003Ov-Jb
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 12:35:03 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOet2-0006Er-9r
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 12:35:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bvz9hNdGHZ29Rf17uwr+tUgDjsHiymrNxgT8lYus6r/HFtLpDamkaKb1Rr1Kn5Hca5h/zkJyLBERWgmvhVE8TuzEOwkCta70aHnAhX0LHG0PDSprPnVOjCxuVvhtAoCPNUt/Kb2qeUb60rlqJ123wiY9jPHqHeS7oFqkRy/sdQnQ9hnfGNiI9y6Iv78+ezz3Y65RyByc0L+5t+iFXJNWz8raDjZCH/NvP8PBl7Q2tIq2z720W8aAR3DPX1YYecUCiuNjJu08pKW1UeQpt8bajSZbDfzlMsaSs2MCryTCRaBeE3KYy5vBmpfNlIdd9SKyRw+5zAermAtsqW8jnmVVHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ztf8RhMyHbxCYaRHVkd3dMeuyEBAQPS4rK4tVCtyt+c=;
 b=J70t6xTGUi+Dqe31dqCDkMXkVAB0pZeQ2Tl9Fv5JtT5Mxr+hd7Y9LtPngfYVOaVyYfrpL4YPxAVvH6pV0D+LWCG7/3pnUWoWA/RMptOqTkOp+numbaKfE3ivsoVjzKEAKHtFEWh2XI9jUn8EkwgTZj6m85cfjTVyza3C2MQ4/t+ZMmIrcNw4v0Zmc192gz4LuYRdyb//ORpsyYu2oRKSABZRbx4DyK+rcgWdK1mrBrKbrWHxJTjJWYE3kESac4fz04w35QfJb2R5ba+wW+I1DpLXqXEY3XkPRsFEwpSNEKBqPEr9xHM8CHTij5Vy+5MHvHN+OjEaJoeGMf7g94EPuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ztf8RhMyHbxCYaRHVkd3dMeuyEBAQPS4rK4tVCtyt+c=;
 b=iAf3+udIp7LuHSapsNFzOq7DKu5CIHYrr8GPWRN/+CeKwtXeAyxV6P7m27EH6Pp4zVfK4bOSua8ThfPLUvicTYGrv1X8WygOWzwAme2d/FrxL9HVshxo07eJvFS1B7NKG1Il7yl0xb8kjipUcAJ/w+VcSoZnepNhQyclJwqJMgj7hihWdfxB2jgWMraKfS21YZ1kYx0PODsZGyZEga7OvFrBp9q2r8G7QXWZAcBD5sf6Pa43cBbpF64UESvX+13RYafwmK40cvV7QhmYUc7zxPo1u7eDX9GOT0Jo4sqqbEKMzHtzyysroFReuH4bxxJ00jsVwH62K8LJMeoUI9DDkw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com (2603:1096:405:2c::12)
 by KUXPR02MB8801.apcprd02.prod.outlook.com (2603:1096:d10:4c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 17:34:16 +0000
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10]) by TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 17:34:16 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 17/17] tests/tcg/ppc: Test FPSCR W/L handling on
 e500mc/e5500/e6500
Date: Thu,  5 Nov 2026 01:33:20 +0800
Message-ID: <20261104173329.706635-18-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104173329.706635-1-bin.meng@processmission.com>
References: <20261104173329.706635-1-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY4PR01CA0044.jpnprd01.prod.outlook.com
 (2603:1096:405:372::17) To TYZPR02MB7121.apcprd02.prod.outlook.com
 (2603:1096:405:2c::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR02MB7121:EE_|KUXPR02MB8801:EE_
X-MS-Office365-Filtering-Correlation-Id: 44aa7c68-5aef-4168-ee3e-08df3a99d9b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|10067099003|18002099003|22082099003|3023799007|56012099006|261026130827099003|261026140227099003|261026121527099003|261028144727099003|261022075727099003|261026135527099003|261022115727099003|261022105027099003|261022113327099003|261021123027099003|261021135927099003|261021133027099003|261021130227099003|261021121427099003|261009223027099003|261102123227099003|260925021311599003|260925022911599003|260925021911599003;
X-Microsoft-Antispam-Message-Info: Dip614rf8uC0BqEfOBR3KCsyqNtWFfiXfuVUgxag1tI/OOU1KNyCP1K33BH+W77rJ0c7dZ/3CM6ydRr5x8AWsDkEv3beh+8EDKHdQGexg19FyOTMVM8vIeFa+/RjDeUELUu7xI8Hp6DUbvS6w6FEg6Oaww0X6mLirO/a5HwyFEtFXKcJtToRaX4YjJ8SNe4R5JEXS/hXe/+WZr5UX6bauKr1l/FyZTrp2Zp/lir+gr0g90fw9Eigj53tRwL3aeLsAQRAFojE38WuvJBEKKj/DNGWaG81ZvIhQHsGSDa3/z4Ef3LgO/rHCCoHJcfRK6IHAFjp9GsK0xL6+n7kI8S5D1T2cT7rnoy2gjXM0RkRtz/4gJVMVz+6pZ+fJZHJtxB6ZoLFuqqbHN1k07eAcCT9fS0sOsZhd0IJlcw5DQOfQk1AzbSGy2tF7xXZikmaVd12bGiwvM97Kj635icba03hgubgweZg6HofGe5vrhMzChcyyuqq2PS4yXvx/KzOWPOyjNNyrJFjaBrw5phO8ZnBnzlJsKYwSPemKgNKGgVoUOl1CGtMNaNGPl2jCUnJ8u4N+GLmlK7yz93cOLcxPQP5NsXZ3CpzMiOIH5dafyWv+CiNJY8bbgz5ny2310O1Tb/nxdaM7Y7paVsspJ7dSYAR/F3G65fii5OUucJKV0GlDIo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR02MB7121.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(18002099003)(22082099003)(3023799007)(56012099006)(261026130827099003)(261026140227099003)(261026121527099003)(261028144727099003)(261022075727099003)(261026135527099003)(261022115727099003)(261022105027099003)(261022113327099003)(261021123027099003)(261021135927099003)(261021133027099003)(261021130227099003)(261021121427099003)(261009223027099003)(261102123227099003)(260925021311599003)(260925022911599003)(260925021911599003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTJ1dlA1WEZxdVhpWmVGYkN2WTJmVlJzSXpkelFwaGh0Lzg2Q0szbkFXOU9N?=
 =?utf-8?B?cXZGRXBjakVQUG01VnZvUkQ4ODNZanFwZWZFaWJxRVdYOHNKU3ptdm54dGZ5?=
 =?utf-8?B?bmNvRnJlSFBETUd3cUhva3ZVTTN5YXBMUFNEd1FUZXhrMnN6R1ZnRUF5cTdq?=
 =?utf-8?B?Y2dlTmtrRElLbEo4MWFTQkQrYmMva01BcHZVVGZhWk5BYzhoc3dVeTNTc0Mv?=
 =?utf-8?B?OEwvU29JN2hWMkVDZzlNakdFNDV5VSt2cUdhaGtoNE5xZ293RmxQbHFoYXp6?=
 =?utf-8?B?TG9XY0xBOEFqbjEwSXYzbGYvUFQxeU1LazBVWEhNOFBXQkQ2VjhMdExPZjBN?=
 =?utf-8?B?Qm1BWkgyU2l6LzZnVEc2MkVocG1HNVdvOXN0ZVhWenMyQzFuYTM3amhSVTk0?=
 =?utf-8?B?M0d3dkZYTHZSckcxclJOVXJPenZaZnVjaWRIMHRXcDVQd0xtQ1RuM2tiSDZ2?=
 =?utf-8?B?OGVrbWc3M29laFRScm51bGVNcERIUE94R1p0OFBKQk9PZlNrdjdUcFhvNTlu?=
 =?utf-8?B?a2puNVhwdi9Hanc4cFNHa1lHZGNpSktnWmE3V1I3VlhTV3dHOTc1c1lJK013?=
 =?utf-8?B?cUZyV2JjMTl2QjZ1ejNhcXhDUmd4NjVYZkgvZ2Z3QmU5QkcyS0UxN1RFYXF6?=
 =?utf-8?B?UURmSUF1Ym5Ebmx6M1A5VVUvekxwTWxzQW41dzc4Q1EySjZOZzB5N1pGLzRD?=
 =?utf-8?B?T0VqQ2FPMTI1clk2dnRDUnMzWW1iQWlreGJxUGpOT3hWaGg0VXRxSHVQNXo5?=
 =?utf-8?B?ZVNPWVA2KzZPcVNub1pDU2dXeGtoM3paTTJDelQ4Z0xYR0ZYeWwyOHhnejY2?=
 =?utf-8?B?enYwZkExUGFUdERZem9iUnY1Z3QvQVVVWGJKK3AzVGxFaFNHYmVvUHBPd3ZW?=
 =?utf-8?B?ampiMjI5SmIwSm0xbWtUQ0drdHljRlJVdlAwYjRyN3UzSmtQY3pFaXkxQ3pU?=
 =?utf-8?B?RVBHdkQyRWV0M0N3ZlcxU21vRnlBbDZkRFJmbnc4cTU5VWxwMi9nZVNpSGVQ?=
 =?utf-8?B?K1ZBSm1nWGR3MVdiZGRiK1JTNy9BU3NWU2xiQjNHbkw1QjdncW5oTTdiQnFK?=
 =?utf-8?B?UGJWVFR0R3d4Qms5cjVuQmdIVjVwcjJBVWx6TEhzTXRpWlRMaXRHUGRQYTNl?=
 =?utf-8?B?NTF0cEo2VUREQlFHNFNneDY2Rm10WDJkbUt1SjVUTDgrSUhOZjV3UFhtQWlQ?=
 =?utf-8?B?eGFVelR4WUZMNFFSTG9nQ0x5d3lkckZMdjNRWVVrRDNLQkJYQTd3WFk3WE9Q?=
 =?utf-8?B?RFoxc2xIYnlINGo0NklvZUxTVnR2NHNyTktLNXFmM211N2V3eUpjWWpBWEhx?=
 =?utf-8?B?dWo1OVV6TmRkTThnNzN4V09jWHg0cW5qNytQQzZNeUpWbEtrOUR4QmtZTTRM?=
 =?utf-8?B?NHZ6aHhtZHFOTUdCNHgzZlVXdXI5KzJRL3VocWRYSExxZjlhcDUxLzMwOEs5?=
 =?utf-8?B?ZUIxUENjdmZxRzRmaTZISmx6VTVYVzdiazlXamd1Y1NIamJpaTZjeUxpd2RW?=
 =?utf-8?B?Z0tkUURIY2crVVd6Qm5GdTFMNlFGZlBxYWsvRTdYdC9uOG5JTlNRcm01OFc3?=
 =?utf-8?B?dlhrTEU4em43eGJXem9SWkduelJzbm10aVlsSjdPSytOYnRtS3BzN3A4QStr?=
 =?utf-8?B?YmV0eWlrMjEyaitrZEdNNE9qV1FueDRSamVpRGNDTWZZenZpNGtUWnA1TDkv?=
 =?utf-8?B?dDZhaGRVZFQrQkVZV3U2QSs5eUp6RVBqSGpYaEdXbmpCVXhmaGI3a05VbkpP?=
 =?utf-8?B?NWQyRE1FeWlkZE9mMWlLbktKQ21Ia3RKOWt0cVQyejNydUt5SXd4YzJPRW1E?=
 =?utf-8?B?RGgzYWlkTXhjRDU4V0l0ZE5mVXVEamZib0p6SmtXRWpUSWJUWUpNcmVJcWFx?=
 =?utf-8?B?blk0WnF4eTJTUjhSdHVWRUgyTWRiYlBIN1hLMExPa052eFFITHlFUEJSUFpp?=
 =?utf-8?B?UHJIMkd2MGFpZkZ3a1pQcUlFQjZ3SkpVVXB6Tlg3cnNKSHFNTXNzbVJKOFY2?=
 =?utf-8?B?K0xoaENkSVFmM0dWeWw2ZC9YUUhPdGo0OUhVaUVXRGhGTUlKSXlIMWdXSmxL?=
 =?utf-8?B?YXh0c0IxUVJjSGl3WFYyWi9tb1p2RnJYTndudEU1c3V3WG1pM3M2ampkb21L?=
 =?utf-8?B?UkhBWVlReXhoSUp5ODVMQ0dkU3dPbkVpR3ArcG1BQlNDWFBIcUkzQjNaVTdY?=
 =?utf-8?B?ejdTZ1N5eG42dDByMDA5L09pSTVHQTlGWXJ5VUZ1VE5PeUtvYTJqZWZEVDFB?=
 =?utf-8?B?YXZiZnBlbTZLRWI0V0xabW9NVzZ1RXVVa0tRZlRPbmU4TVorMVp1ZC9qT0Rl?=
 =?utf-8?B?eEpYYWhaOU1vdS9tK1NwZHN0ZVo5RUxvOVNvQ1I4Z2JWbnJIUDgrazgzOWFB?=
 =?utf-8?Q?97mSUWEUqDHtIus0=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44aa7c68-5aef-4168-ee3e-08df3a99d9b1
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7121.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 17:34:16.7645 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NwE5BR65mvnxn+e+y6RU0LOmzYdgY1ww70fEnxgacxL7mjwzxW0MA1dGHUGj4NEXz8BzUqQpeyBjgLzpGU37bZvp4CT+Z6O1iTNn4BTAxmE=
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

The e500mc, e5500 and e6500 ignore W in mtfsfi and W/L in mtfsf.
Check that these fields do not select extended FPSCR fields, cause
illegal instruction exceptions or override the ordinary field mask.

Test both W values, all W/L combinations and the Rc variants. Seed ZE
and RN before each instruction so partial and zero field masks verify
that unaffected fields remain intact and selected fields receive the
expected values. Ignore the undefined upper word returned by mffs.

Register the test for e500mc in 32-bit mode and for e5500/e6500 in
64-bit mode, using the shared Book E startup and result handling.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

(no changes since v1)

 tests/tcg/ppc/system/fpscr.S     | 75 ++++++++++++++++++++++++++++++++
 tests/tcg/ppc/system/meson.build |  2 +-
 2 files changed, 76 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/ppc/system/fpscr.S

diff --git a/tests/tcg/ppc/system/fpscr.S b/tests/tcg/ppc/system/fpscr.S
new file mode 100644
index 0000000000..41e90b1076
--- /dev/null
+++ b/tests/tcg/ppc/system/fpscr.S
@@ -0,0 +1,75 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (c) 2026 Process Mission
+ */
+
+#include "macros.inc"
+
+    .macro seed_fpscr
+    mtfsf 255, f2
+    mtfsfi 6, 1                 /* ZE */
+    mtfsfi 7, 2                 /* RN */
+    .endm
+
+    .macro check_fpscr expected
+    mffs f1
+    stfd f1, 8(r4)
+    lwz r11, 12(r4)
+    load32 r12, \expected
+    cmpw r11, r12
+    bne fail
+    .endm
+
+    .macro test_mtfsfi field, value, w, record, expected
+    seed_fpscr
+    .if \record
+    mtfsfi. \field, \value, \w
+    .else
+    mtfsfi \field, \value, \w
+    .endif
+    check_fpscr \expected
+    .endm
+
+    .macro test_mtfsf mask, w, l, record, expected
+    seed_fpscr
+    .if \record
+    mtfsf. \mask, f0, \l, \w
+    .else
+    mtfsf \mask, f0, \l, \w
+    .endif
+    check_fpscr \expected
+    .endm
+
+    .text
+    .globl test_main
+test_main:
+    load_addr r4, scratch
+    lfd f0, 0(r4)               /* Source: upper word 3, lower word 1 */
+    lfd f2, 16(r4)              /* Zero for a reproducible initial FPSCR */
+
+    .irp w, 0, 1
+    .irp record, 0, 1
+    test_mtfsfi 6, 4, \w, \record, 0x42
+    test_mtfsfi 7, 1, \w, \record, 0x11
+    .endr
+    .endr
+
+    .irp w, 0, 1
+    .irp l, 0, 1
+    .irp record, 0, 1
+    /* L must not override the ordinary field mask, and W is ignored */
+    test_mtfsf 0, \w, \l, \record, 0x12
+    test_mtfsf 1, \w, \l, \record, 0x11
+    test_mtfsf 2, \w, \l, \record, 0x02
+    test_mtfsf 255, \w, \l, \record, 0x01
+    .endr
+    .endr
+    .endr
+    b pass
+
+    .data
+    .balign 8
+scratch:
+    .long 3, 1
+    .space 16
diff --git a/tests/tcg/ppc/system/meson.build b/tests/tcg/ppc/system/meson.build
index 1598348656..ad4c257c9a 100644
--- a/tests/tcg/ppc/system/meson.build
+++ b/tests/tcg/ppc/system/meson.build
@@ -11,7 +11,7 @@ ppc_system_cflags = ['-nostdlib', '-ffreestanding', '-mcpu=power6',
                      '-Wl,-T', ppc_system_link_script, ppc_system_boot]
 ppc_system_qemu_args = ['-M', 'ppce500', '-accel', 'tcg', '-display', 'none',
                         '-serial', 'stdio', '-monitor', 'none', '-nic', 'none']
-ppc_system_sources = ['unsupported.S']
+ppc_system_sources = ['unsupported.S', 'fpscr.S']
 
 tests = []
 foreach src: ppc_system_sources
-- 
2.53.0


