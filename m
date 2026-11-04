Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A5C606ECC0
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 17:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=di/MoMhp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOeu5-0005vA-3U; Wed, 04 Nov 2026 12:36:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOesr-0003Gn-KM; Wed, 04 Nov 2026 12:34:52 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOeso-0006Er-VU; Wed, 04 Nov 2026 12:34:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rV3OMQF7ORGzSXmD/HkQkFkp3LemBPdlSzbGiTDPtHqxxS+P4OctbavzYBq5zS6Mbg2+pds/XE/Y4lbXonHy4cMBS+xqBHtUds6usqzfylBdtOrNjTIKg1f/XdzUcw43pqirmUGYBskAvJgufiQd5pRl/kC1Da5bDn11//zQsAHoerYur5DpMty9cH5kKsakaSaMXZK5sni5CjPb07Qns2/+Phe48unZzvZ9NmpTElH5rNdO+7zqa2+YYZarkV25CyCycjo5+WkjZumV1rwK91qlgDpdOfpkDba3Gz/B11timGP7R/wl5PJ2f9bJrn/G5ljkj45LcbJglZDHKiGFyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mXrfYsdYzZaku/TioU/2hdpOKhXAoSIS8j3oBfjcGtI=;
 b=KSjz8KlkH7aprZkpuBzGqMqcLItZ0BFxHEZoXCIZVA0VFPAQ87V3SnaxO1eEWFs+tA0G/6Wl7pYjLqchAKhzINzv+wQOupDJiak/9gf1Z0lPuZ2k1EeHkPW8URguqJHwVM40zMD8s41JoTjG5PUDJW68re18fTO/0RJnVGTPNTLKGs77paZtfYhLDofktOGapvyDx/aHG9Y0oM+IczH70+D9Y6ZVDLl2N2mbH0y43/vd98bveTZFiFQSLdaDJmNKH/+sOR/y8To6bO3vyFBKPh4JXDZYEhIe9ru2Zn5lVlHC3+KhNSnFZ0E5rvoTiFaThV8PNwpXdlPHFoMTm99UNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXrfYsdYzZaku/TioU/2hdpOKhXAoSIS8j3oBfjcGtI=;
 b=di/MoMhpqAV/iv/MpXSCaQP04iIhAUkpNz0uKgUw5J5qMyW30sAywWI8tcIJxLBPcTAnbY1RXAIpxMn4/r2BzUyjupUKll6WmaOy0ZY71/JcYdlqdf2GbjrQzrWz70YLsJ+g3H9zZKF7U74xKpNLlJc4KGhz+fegz2kE3i9xCjRcUa2DzTAsitD/Y9xjg1c9XUdtP/l/Mw7ibusY0FoCd9WoQIsPvZvf7UAG8OlZx51+vAqXk8GMEEy8Rfec4wDmUoMylhed8TzbGpuztWed63AILpkCYjM+BwGs/baThgDGHTUqN3u6z1YnhDqAf8ffjan3UHwTw1rUxcFGBcW6/g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com (2603:1096:405:2c::12)
 by KUXPR02MB8801.apcprd02.prod.outlook.com (2603:1096:d10:4c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 17:34:14 +0000
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10]) by TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 17:34:14 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-ppc@nongnu.org
Subject: [PATCH v2 15/17] tests/tcg/ppc: Add Book E illegal instruction tests
Date: Thu,  5 Nov 2026 01:33:18 +0800
Message-ID: <20261104173329.706635-16-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: eedb2541-0d74-4d90-afc4-08df3a99d817
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|23010399003|1800799024|10067099003|18002099003|22082099003|18092099006|3023799007|56012099006|261026130827099003|261026140227099003|261026121527099003|261028144727099003|261022075727099003|261026135527099003|261022115727099003|261022105027099003|261022113327099003|261021123027099003|261021135927099003|261021133027099003|261021130227099003|261009221227099003|261021121427099003|261009223027099003|261102123227099003|260925021311599003|260925022911599003|260925021911599003;
X-Microsoft-Antispam-Message-Info: rKhiSVbcbC6B7bpu31MXwIPTl9V23CqJxhOOyNhr4Drilq+IJZo9Wt95u7oUCEALomG9e+/CDlf1YacIXI1jG67FvXQnofTWdoGHvZskSBFI/RPY+WG+0WOPFfiKsNZvqVqQqF7Y7B4oVvzyhmvdkOaeb9G/xlnWRoqjioWhQLHsfH2/VyIsK+IGfFtm6QoHJmnWms1Z+tK2LITy8/PHWzhuPSEhHCX+FHIuC5o+IcP4MAphspsJekj0Kl/eKv8OjaNzPfqvCUtLt2jV2c+x7/5MqYRLe1GJz6AoBSlxfWI6XW+XqHbShHNYGNlViQg7MYLqDix+Eg4N+x5ihz9RFycbmeR0M2GCq6V6ZYkEw3US/1cUwncInv74yNGSwY8Gr656ysa++QOq3RjtITZ22tQwH//If6JNOkaIPTq/gTu5XJP6EkJ9NEOmfQCgzOvwtzjFD0l1gKzrR71EAT26hHA/FzKNRjEjaujdmC7q4d1zyilG6VpCFOBsBdLWdu4nYFaLFp8D3/ux5jpDToerpwQ6bAli9f001eeYDxatUlL54MMnnr//mG+xlmFLbKxum5aWPc/9RDMMMdX2wyyUF5pquzHdi9dnoNwZhmqpfyG30V/sNvNJ44ZN/rXJcO6AI1LgfcCBtI7pCo9QsRJtbigbUHci4/CMmyC3TlzidbI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR02MB7121.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(10067099003)(18002099003)(22082099003)(18092099006)(3023799007)(56012099006)(261026130827099003)(261026140227099003)(261026121527099003)(261028144727099003)(261022075727099003)(261026135527099003)(261022115727099003)(261022105027099003)(261022113327099003)(261021123027099003)(261021135927099003)(261021133027099003)(261021130227099003)(261009221227099003)(261021121427099003)(261009223027099003)(261102123227099003)(260925021311599003)(260925022911599003)(260925021911599003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wFmB3shZ+/hZGTIWOu8LJXVThOuc0VwaO+EaXGR99E42HyBqzK5blsx3E5AZ?=
 =?us-ascii?Q?wkV325IH53+wDYuFt+SIeeE3dWpUPssJz23L/DjkywIXwXs7P/TKQNJ38lH4?=
 =?us-ascii?Q?8aImMxTLLWq9RlQF/cnLCzVm+uoy9WpQQtK4jhC7pUvWVQpETypILmXQGWHt?=
 =?us-ascii?Q?WeZeMU7+aB3++mCxTtLvq05enbPDmsZVKjSEBEkBm4Mi9OIOE8CBGgvQX97U?=
 =?us-ascii?Q?Xgwn9/d2ro5Yo++DIMSzbZxkNn5Y0cZ5bByX1qAlrcaDNQjpiVXL7OlkBxAT?=
 =?us-ascii?Q?FXyAUVLWRCLFltQ9AjyqGeEeFaUuwlW5GIftxCo5wOJAaCCrVgyIm2eVzfKG?=
 =?us-ascii?Q?8vVwTLoMTAJL4ZI2Gc93+B0qh+8hcH6a6ykxalrDA+7Z7cQxDRXbxou1YiUd?=
 =?us-ascii?Q?Giq5Mwk2RCvG/Mc1u/YeuVdOH1RB2x2hR2hA+C/u/J34aIKf9yh8Phn24YcC?=
 =?us-ascii?Q?/s+bMXlt12/OcF73oXD2rUy9KTbhG5DKJBjTlENKPBcCpCj8J6LB/LoBcvhp?=
 =?us-ascii?Q?l24c3UA01xUlvWHP2HhxjXUCWyVMBs6ijwDYOBfoOee6dwjZx2/OYK567bMe?=
 =?us-ascii?Q?F9++CMM5s7WVy8C7l8LywcCepAUc49/GOQ2BxxuwPxgFXdllPedwKTfLDMMj?=
 =?us-ascii?Q?6ChFs5gARgz+2Jajgmf+gMAC+YigX75HOJ3mHkeDCDEV3u8fxYLnQBXBTrj3?=
 =?us-ascii?Q?XxOIqYOHXlVNmmCRm7MtRULDjhI5bSntA8zo1u1m5tmwLkBiCBQ4URsRIsRw?=
 =?us-ascii?Q?JNl7AyQ9Jc7tHD5i1151qdzaFMNBsO993aF3Haq4T6fPuRtEL8RsB+zCKaRf?=
 =?us-ascii?Q?IviEpneAZsu8JAolUXmZrEg/xWSwFW4mRV5KCy58V4i8OZDjW7sRd2GDFEgL?=
 =?us-ascii?Q?Lw8L3Y1clVJ/zDptcfOpXDU9AGFx0LbU5ShH7SMidcizC4CMyXHaiepkvSz/?=
 =?us-ascii?Q?93AT1A7rDv8M29weTOkU//V53K4FI1VzGm9d0KfWjazcObDCFmH0Lfu7dLmR?=
 =?us-ascii?Q?q/9V3bvZF5FEuWNJWnNJ+wHlOs116iGZVS8k/2+6xUhGdUJ4mH0dpQ9GKQ7w?=
 =?us-ascii?Q?KGAos6WsP+cVOnOgcW1ImowrNmX6G0+OI9AxEb6NB1O3ipPUFj5ATbyVjLj/?=
 =?us-ascii?Q?ROkaUKH73ykeT0qdhaKbjyYfMDx6pyIAQ//lykraLY8lbYEPBa7imEYgbic2?=
 =?us-ascii?Q?fkdPBLD2sDggS+n7s9g43CfblGurG8u1A6UIXfKULeJ11uYahjILXq7oQ93w?=
 =?us-ascii?Q?TtedtnXRgPVXg+zt777FaJ8WA1BQU+kCvR1mv45BQblSnGZV2qUhBgAmpuIv?=
 =?us-ascii?Q?K/IdV+PymsqX3aMAVdg+NSs4bMrDcWSM7szzTehkTAmpb0Uzb+6CBsWjFYAc?=
 =?us-ascii?Q?3a8si393V2088hSqK7PuxM6XMzgXAMpXXlI3FR5V30MRwUybA3NbzHVuaXaQ?=
 =?us-ascii?Q?thbYnAkiYdMjykLxaQ+Azgf3jf60jyaigH9k4Eg/00NP6gxSehl3iS55OVfZ?=
 =?us-ascii?Q?TjYrtAWmIpZ2SExU8L5ns/B3S7DVq6q4bGBsKb0gHzMHToj6ImN1fC8XpOGk?=
 =?us-ascii?Q?FpQeFocDfmolVcNHgnYKu55Kh55fHf4YJLI9GAN2vV94w3DtcP9BCRZFexc7?=
 =?us-ascii?Q?Zoera6Csz2VIjDNo4XNZH3XYCFzGAAUrHoK4ApP2Nxk28YKfLNgJ5p5SaXSh?=
 =?us-ascii?Q?U3w20riGswE2X+AiMECqRD7fJemwwdqY5MLe4PaXcdXeQONRIn5Dwan2U0Xh?=
 =?us-ascii?Q?x442nhIns+6CvMn4ptgKQYMcAiDJvl0=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eedb2541-0d74-4d90-afc4-08df3a99d817
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7121.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 17:34:14.1516 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tsPgXRuua06bwcn7Ns6sKkwC3yXo7n1YXx+fvzSNu5b2Bdal6eQEAjWloFO/yGvyd2rB4mHXy4Bxz/gIw7us/+OQYh70segfj+oqCFNhlx0=
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

Check the instruction subsets of e500mc, e5500 and e6500 through the
existing TCG test framework. System emulation allows checking SRR0 and
ESR on program exceptions. Run e500mc in 32-bit computation mode and
e5500/e6500 in 64-bit computation mode.

Add shared ppce500 startup code, a linker script and assembly helpers.
Use the existing UART and GPIO power-off devices to report results and
terminate QEMU. Register the system targets in ppc/system and
ppc64/system, sharing the assembly sources.

Test that unsupported floating-point instructions raise precise illegal
instruction exceptions. Also check cmpb, prtyw and prtyd on e500mc.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

Changes in v2:
- Rebase the PPC64 test entry onto the Meson variable cleanup

 meson_options.txt                  |  4 ++
 scripts/meson-buildoptions.sh      |  2 +
 tests/tcg/meson.build              |  1 +
 tests/tcg/ppc/meson.build          |  5 ++
 tests/tcg/ppc/system/README        | 22 +++++++
 tests/tcg/ppc/system/boot.S        | 92 ++++++++++++++++++++++++++++++
 tests/tcg/ppc/system/isa.out       |  1 +
 tests/tcg/ppc/system/kernel.ld     | 18 ++++++
 tests/tcg/ppc/system/macros.inc    | 56 ++++++++++++++++++
 tests/tcg/ppc/system/meson.build   | 39 +++++++++++++
 tests/tcg/ppc/system/unsupported.S | 31 ++++++++++
 tests/tcg/ppc64/meson.build        |  2 +
 tests/tcg/ppc64/system/meson.build | 32 +++++++++++
 13 files changed, 305 insertions(+)
 create mode 100644 tests/tcg/ppc/meson.build
 create mode 100644 tests/tcg/ppc/system/README
 create mode 100644 tests/tcg/ppc/system/boot.S
 create mode 100644 tests/tcg/ppc/system/isa.out
 create mode 100644 tests/tcg/ppc/system/kernel.ld
 create mode 100644 tests/tcg/ppc/system/macros.inc
 create mode 100644 tests/tcg/ppc/system/meson.build
 create mode 100644 tests/tcg/ppc/system/unsupported.S
 create mode 100644 tests/tcg/ppc64/system/meson.build

diff --git a/meson_options.txt b/meson_options.txt
index 9ae8e44ab5..e053064e42 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -469,6 +469,10 @@ option('tcg_tests_cross_cc_or1k', type: 'string',
        description: 'cc for or1k tcg tests')
 option('tcg_tests_cross_cflags_or1k', type: 'string',
        description: 'cflags for or1k tcg tests')
+option('tcg_tests_cross_cc_ppc', type: 'string',
+       description: 'cc for ppc tcg tests')
+option('tcg_tests_cross_cflags_ppc', type: 'string',
+       description: 'cflags for ppc tcg tests')
 option('tcg_tests_cross_cc_ppc64', type: 'string',
        description: 'cc for ppc64 tcg tests')
 option('tcg_tests_cross_cflags_ppc64', type: 'string',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 0f8b56bd7f..020c42f8a4 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -546,6 +546,7 @@ _meson_option_parse() {
     --tcg-tests-cross-cc-mips64r6el=*) quote_sh "-Dtcg_tests_cross_cc_mips64r6el=$2" ;;
     --tcg-tests-cross-cc-mipsel=*) quote_sh "-Dtcg_tests_cross_cc_mipsel=$2" ;;
     --tcg-tests-cross-cc-or1k=*) quote_sh "-Dtcg_tests_cross_cc_or1k=$2" ;;
+    --tcg-tests-cross-cc-ppc=*) quote_sh "-Dtcg_tests_cross_cc_ppc=$2" ;;
     --tcg-tests-cross-cc-ppc64=*) quote_sh "-Dtcg_tests_cross_cc_ppc64=$2" ;;
     --tcg-tests-cross-cc-ppc64le=*) quote_sh "-Dtcg_tests_cross_cc_ppc64le=$2" ;;
     --tcg-tests-cross-cc-riscv32=*) quote_sh "-Dtcg_tests_cross_cc_riscv32=$2" ;;
@@ -574,6 +575,7 @@ _meson_option_parse() {
     --tcg-tests-cross-cflags-mips64r6el=*) quote_sh "-Dtcg_tests_cross_cflags_mips64r6el=$2" ;;
     --tcg-tests-cross-cflags-mipsel=*) quote_sh "-Dtcg_tests_cross_cflags_mipsel=$2" ;;
     --tcg-tests-cross-cflags-or1k=*) quote_sh "-Dtcg_tests_cross_cflags_or1k=$2" ;;
+    --tcg-tests-cross-cflags-ppc=*) quote_sh "-Dtcg_tests_cross_cflags_ppc=$2" ;;
     --tcg-tests-cross-cflags-ppc64=*) quote_sh "-Dtcg_tests_cross_cflags_ppc64=$2" ;;
     --tcg-tests-cross-cflags-ppc64le=*) quote_sh "-Dtcg_tests_cross_cflags_ppc64le=$2" ;;
     --tcg-tests-cross-cflags-riscv32=*) quote_sh "-Dtcg_tests_cross_cflags_riscv32=$2" ;;
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index b61ddf8051..c754419db7 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -180,6 +180,7 @@ subdir('mipsel')
 subdir('mips64')
 subdir('mips64el')
 subdir('or1k')
+subdir('ppc')
 subdir('ppc64')
 subdir('ppc64le')
 subdir('riscv32')
diff --git a/tests/tcg/ppc/meson.build b/tests/tcg/ppc/meson.build
new file mode 100644
index 0000000000..869b8906c5
--- /dev/null
+++ b/tests/tcg/ppc/meson.build
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (c) 2026 Process Mission
+
+subdir('system')
diff --git a/tests/tcg/ppc/system/README b/tests/tcg/ppc/system/README
new file mode 100644
index 0000000000..37a0fca951
--- /dev/null
+++ b/tests/tcg/ppc/system/README
@@ -0,0 +1,22 @@
+These Book E ISA tests use the generic tests/tcg build and test runner.
+They run on ppce500 with e500mc, e5500 and e6500 CPU models. System mode
+allows checking SRR0 and ESR on illegal instructions. The ppc target runs
+e500mc in 32-bit computation mode; ppc64 runs e5500/e6500 in 64-bit mode.
+
+The cross compiler builds freestanding ELF32 executables for ppc with
+-m32 and ELF64 executables for ppc64 with -m64. No target libc or
+multilib runtime is needed. The boot stub uses the initial RAM mapping
+provided by ppce500 -kernel, maps the CCSR area, and installs a program
+exception handler. Results go to UART0, and the existing GPIO power-off
+line terminates QEMU. The standard run_and_diff wrapper compares the
+output with isa.out.
+
+Configure QEMU with ppc-softmmu and/or ppc64-softmmu enabled. Compilers
+are found through the usual TCG cross-compiler detection or containers;
+--cross-cc-ppc and --cross-cc-ppc64 can select them explicitly. Run with:
+
+    make check-tcg-ppc-softmmu
+    make check-tcg-ppc64-softmmu
+
+These targets are generated only when configure finds a usable cross
+compiler or container. If missing, check the TCG tests configure summary.
diff --git a/tests/tcg/ppc/system/boot.S b/tests/tcg/ppc/system/boot.S
new file mode 100644
index 0000000000..2176205bcc
--- /dev/null
+++ b/tests/tcg/ppc/system/boot.S
@@ -0,0 +1,92 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (c) 2026 Process Mission
+ */
+
+#include "macros.inc"
+
+    .section .text.start, "ax"
+    .globl _start
+_start:
+    /* Map CCSR at VA 0xfe000000 to PA 0xfe0000000 in TLB1[1] */
+    load32 r3, 0x10010000
+    mtspr SPR_BOOKE_MAS0, r3    /* MAS0 */
+    load32 r3, 0xc0000500
+    mtspr SPR_BOOKE_MAS1, r3    /* MAS1: valid, protected, 1 MiB */
+    load32 r3, 0xfe00000a
+    mtspr SPR_BOOKE_MAS2, r3    /* MAS2: cache inhibited, guarded */
+    load32 r3, 0xe000003f
+    mtspr SPR_BOOKE_MAS3, r3    /* MAS3: RPN and permissions */
+    li r3, 15
+    mtspr SPR_BOOKE_MAS7, r3    /* MAS7 */
+    tlbwe
+    isync
+
+    load_addr r3, vectors
+    mtspr SPR_BOOKE_IVPR, r3    /* IVPR */
+    li r3, 0x600
+    mtspr SPR_BOOKE_IVOR6, r3   /* IVOR6: program exception */
+    li r14, 0                   /* No program exception expected */
+
+#ifdef _LP64
+    load32 r3, 0x80002000
+#else
+    li r3, 0x2000
+#endif
+    mtmsr r3                    /* Enable FP and select computation mode */
+    isync
+    b test_main
+
+    .section .vectors, "ax"
+vectors:
+    .space 0x600
+program_exception:
+    mfspr r3, SPR_SRR0          /* SRR0 must name the illegal instruction */
+#ifdef _LP64
+    cmpd r3, r14
+#else
+    cmpw r3, r14
+#endif
+    bne unexpected_exception
+    mfspr r3, SPR_BOOKE_ESR     /* ESR must contain only PIL */
+    load32 r5, 0x08000000
+    cmpw r3, r5
+    bne unexpected_exception
+    mtspr SPR_SRR0, r15
+    rfi
+unexpected_exception:
+    b fail
+
+    .text
+    .globl pass, fail
+pass:
+    load_addr r3, pass_message
+    b report
+fail:
+    load_addr r3, fail_message
+report:
+    load32 r4, 0xfe004500       /* UART0 */
+    rlwinm r4, r4, 0, 0, 31     /* Zero extend the address on 64-bit cores */
+1:
+    lbz r5, 0(r3)
+    cmpwi r5, 0
+    beq 2f
+    stb r5, 0(r4)
+    addi r3, r3, 1
+    b 1b
+2:
+    /* GPIO pin 0 is the ppce500 power-off line */
+    load32 r4, 0xfe0ff000
+    rlwinm r4, r4, 0, 0, 31
+    load32 r5, 0x80000000
+    stw r5, 0(r4)               /* Direction: output */
+    stw r5, 8(r4)               /* Data: assert pin 0 */
+3:
+    b 3b
+
+    .section .rodata
+pass_message:
+    .asciz "ISA:PASS\n"
+fail_message:
+    .asciz "ISA:FAIL\n"
diff --git a/tests/tcg/ppc/system/isa.out b/tests/tcg/ppc/system/isa.out
new file mode 100644
index 0000000000..34dabaf8bb
--- /dev/null
+++ b/tests/tcg/ppc/system/isa.out
@@ -0,0 +1 @@
+ISA:PASS
diff --git a/tests/tcg/ppc/system/kernel.ld b/tests/tcg/ppc/system/kernel.ld
new file mode 100644
index 0000000000..3f18a3e087
--- /dev/null
+++ b/tests/tcg/ppc/system/kernel.ld
@@ -0,0 +1,18 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (c) 2026 Process Mission
+ */
+
+ENTRY(_start)
+
+SECTIONS
+{
+    . = 0x100000;
+    .text : { *(.text.start) *(.text) }
+    . = ALIGN(0x10000);
+    .vectors : { *(.vectors) }
+    .rodata : { *(.rodata) }
+    .data : { *(.data) }
+    .bss : { *(.bss) }
+}
diff --git a/tests/tcg/ppc/system/macros.inc b/tests/tcg/ppc/system/macros.inc
new file mode 100644
index 0000000000..ec58f68cbd
--- /dev/null
+++ b/tests/tcg/ppc/system/macros.inc
@@ -0,0 +1,56 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (c) 2026 Process Mission
+ */
+
+#define SPR_SRR0         0x01a
+#define SPR_BOOKE_ESR    0x03e
+#define SPR_BOOKE_IVPR   0x03f
+#define SPR_BOOKE_IVOR6  0x196
+#define SPR_BOOKE_MAS0   0x270
+#define SPR_BOOKE_MAS1   0x271
+#define SPR_BOOKE_MAS2   0x272
+#define SPR_BOOKE_MAS3   0x273
+#define SPR_BOOKE_MAS7   0x3b0
+
+    .macro load32 reg, value
+    lis \reg, ((\value) >> 16) & 0xffff
+    ori \reg, \reg, (\value) & 0xffff
+    .endm
+
+    .macro load_addr reg, symbol
+    lis \reg, \symbol@ha
+    addi \reg, \reg, \symbol@l
+    .endm
+
+    .macro load_value reg, value
+#ifdef _LP64
+    load32 \reg, (\value) >> 32
+    sldi \reg, \reg, 32
+    oris \reg, \reg, ((\value) >> 16) & 0xffff
+    ori \reg, \reg, (\value) & 0xffff
+#else
+    load32 \reg, \value
+#endif
+    .endm
+
+    .macro check_value reg, value
+    load_value r12, \value
+#ifdef _LP64
+    cmpd \reg, r12
+#else
+    cmpw \reg, r12
+#endif
+    bne fail
+    .endm
+
+    .macro check_illegal insn:vararg
+    load_addr r14, 1f
+    load_addr r15, 2f
+1:
+    \insn
+    b fail                      /* Executing the instruction is a failure */
+2:
+    li r14, 0
+    .endm
diff --git a/tests/tcg/ppc/system/meson.build b/tests/tcg/ppc/system/meson.build
new file mode 100644
index 0000000000..1598348656
--- /dev/null
+++ b/tests/tcg/ppc/system/meson.build
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (c) 2026 Process Mission
+
+# Shared settings and sources for the ppc and ppc64 system targets
+ppc_system_link_script = files('kernel.ld')[0]
+ppc_system_boot = files('boot.S')[0]
+ppc_system_cflags = ['-nostdlib', '-ffreestanding', '-mcpu=power6',
+                     '-Wa,-mregnames', '-Wa,--noexecstack',
+                     '-Wl,--build-id=none',
+                     '-Wl,-T', ppc_system_link_script, ppc_system_boot]
+ppc_system_qemu_args = ['-M', 'ppce500', '-accel', 'tcg', '-display', 'none',
+                        '-serial', 'stdio', '-monitor', 'none', '-nic', 'none']
+ppc_system_sources = ['unsupported.S']
+
+tests = []
+foreach src: ppc_system_sources
+  tests += {
+    'system/' + src: {
+      'exe_name': fs.stem(src) + '-e500mc-32',
+      'cflags': ppc_system_cflags + ['-m32', '-DE500MC'],
+      'qemu_args': ppc_system_qemu_args + ['-cpu', 'e500mc', '-kernel'],
+      'expected_output': 'system/isa.out',
+    }
+  }
+endforeach
+
+if 'qemu-system-ppc' in emulators
+  tcg_tests += {
+    'ppc-softmmu': {
+      'cc': 'powerpc-linux-gnu-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
+      'folder': 'ppc',
+      'gdb_arch': 'ppc',
+      'qemu': emulators['qemu-system-ppc'],
+      'tests': tests,
+    }
+  }
+endif
diff --git a/tests/tcg/ppc/system/unsupported.S b/tests/tcg/ppc/system/unsupported.S
new file mode 100644
index 0000000000..1737646b35
--- /dev/null
+++ b/tests/tcg/ppc/system/unsupported.S
@@ -0,0 +1,31 @@
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
+    /* Valid memory prevents address faults from hiding decode errors */
+    load_addr r4, scratch
+    check_illegal fcpsgn f0, f0, f0
+    check_illegal fcpsgn. f0, f0, f0
+    check_illegal lfiwax f0, 0, r4
+    check_illegal lfdp f0, 0(r4)
+    check_illegal lfdpx f0, 0, r4
+    check_illegal stfdp f0, 0(r4)
+    check_illegal stfdpx f0, 0, r4
+#ifdef E500MC
+    check_illegal cmpb r11, r9, r10
+    check_illegal prtyw r11, r9
+    check_illegal prtyd r11, r9
+#endif
+    b pass
+
+    .data
+    .balign 16
+scratch:
+    .space 16
diff --git a/tests/tcg/ppc64/meson.build b/tests/tcg/ppc64/meson.build
index fb0bb7fa56..f96e4d5e27 100644
--- a/tests/tcg/ppc64/meson.build
+++ b/tests/tcg/ppc64/meson.build
@@ -1,3 +1,5 @@
+subdir('system')
+
 tests = []
 
 # Multi arch tests
diff --git a/tests/tcg/ppc64/system/meson.build b/tests/tcg/ppc64/system/meson.build
new file mode 100644
index 0000000000..ca398860e3
--- /dev/null
+++ b/tests/tcg/ppc64/system/meson.build
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (c) 2026 Process Mission
+
+ppc64_system_cflags = ppc_system_cflags + ['-m64']
+tests = []
+foreach cpu: ['e5500', 'e6500']
+  sources = ppc_system_sources
+  foreach src: sources
+    tests += {
+      '../ppc/system/' + src: {
+        'exe_name': fs.stem(src) + '-' + cpu + '-64',
+        'cflags': ppc64_system_cflags,
+        'qemu_args': ppc_system_qemu_args + ['-cpu', cpu, '-kernel'],
+        'expected_output': '../ppc/system/isa.out',
+      }
+    }
+  endforeach
+endforeach
+
+if 'qemu-system-ppc64' in emulators
+  tcg_tests += {
+    'ppc64-softmmu': {
+      'cc': 'powerpc64-linux-gnu-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
+      'folder': 'ppc64',
+      'gdb_arch': 'ppc64',
+      'qemu': emulators['qemu-system-ppc64'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.53.0


