Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B928B606A31C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 12:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=IJ0cCOVR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQ1cj-00010D-Ij; Sun, 08 Nov 2026 07:03:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xQ1av-0006y9-1N; Sun, 08 Nov 2026 07:02:01 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xQ1an-0000V3-JH; Sun, 08 Nov 2026 07:01:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SQG2qyWRj+3jjlfb29IfN6Ei54F869A6u2RwZebAyu70SPm6+UuQ8jrGeNqwAGqgCwv/8/w0zm9MU0HPYzNVqnPCdOKK9YGTr21fbR/PjHGaJ4sq36m3xrXOGeB/II/HGeW+TbfGYb9ivbaFHAQPGw6CKfbD8Aj9iRfyeSQa96u7gYJIoD8aFdWl4Zsfd8fp3/WEwj6BRRsgKT0M2k3kfVPL1tfqAadJL+Cd/lk/9HxLAC0jtUeMDwFcvhRD1lLJOgXfOruJKJ/zimPZULj0c+XK34tnFn2tliX1hRTktkoBHCanWNbLlBJ7DDpvswS+FiXTUvMjzPwq8OkmelGj1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1r2LV4fqTImfc6ohP7TU99BqUOdHbSXPJLD2z/rcjA=;
 b=eSQZdYWSp543jAOSprQ1bNlP8ov02aEVVwYF2WaryYn/zPwgxXkq5sMS8zmLBGCwBqmoox0IjkpksfR/up2ImoZEmSqkideooLl9w7eig2WpHA2x59Nidma7QDN6jTdvMHZKcL2S1FU8aHBTAm5wAg4yuGYyHsy3rcTh5RA81u9Q2Tdcrov/WEU870JErFTbEhM1OnJdt/TrQYYC52XwxiXgDouKmSjkjAQKmt8NL/nOj1wjDM7AQT2y3plsQMiUB2CtNgDupJW7a7euZ4X0WQkSJ0p5w2Lu9odx3GbQki3LjjpmX8O9LFoe59jUumqASa1E/xj6jGGkzl2rikxGeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1r2LV4fqTImfc6ohP7TU99BqUOdHbSXPJLD2z/rcjA=;
 b=IJ0cCOVR7uMqsM5UdG/GsucMZ1l+kovMuYIe2n7iEtcFJPROVJ0+adMlpbV3nLWaOYG9bZMqLUaOnsIo5dwWOA7wxm1M9LItqZMjom6kTcqVxULlnM89MihD/rNUB5F1iQErbKYvU9RYZ4Jr3DsYST8mAvcJd+aK36vpQY5IWtNJ81KemUXtKK4qpHBPNapS2PZFk8FbsP4FRYpuCMt9vgEGbtackhXfMe1iZo03jUpLYMYUfeGj280oiJVfLx6JFg5LY1AfWJsImCcsD0t7yvjrfVMnasOe7O3Jj54ucGxmQt0+V5ZvlfyC9SrJh3x+wGXRD12jBrEXSgkZGyR61Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB7144.apcprd02.prod.outlook.com (2603:1096:820:116::10)
 by KUZPR02MB9138.apcprd02.prod.outlook.com (2603:1096:d10:61::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Sun, 8 Nov
 2026 12:01:39 +0000
Received: from KL1PR02MB7144.apcprd02.prod.outlook.com
 ([fe80::18f7:ed72:e33:ea5c]) by KL1PR02MB7144.apcprd02.prod.outlook.com
 ([fe80::18f7:ed72:e33:ea5c%6]) with mapi id 15.21.0592.010; Sun, 8 Nov 2026
 12:01:39 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: [PATCH v3 17/23] tests/tcg/ppc: Test FPSCR W/L handling on
 e500mc/e5500/e6500
Date: Sun,  8 Nov 2026 20:00:16 +0800
Message-ID: <20261108120034.1755008-18-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8dcbaf77-94ad-4551-a62e-08df3d900c0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|10067099003|3023799007|261028144727099003|261102123227099003|261022115727099003|261022113327099003|261022105027099003|261022075727099003|56012099006|261021135927099003|261021130227099003|261021123027099003|261021121427099003|261021133027099003|261026130827099003|261026121527099003|261026135527099003|261026140227099003|261009223027099003|260925021311599003|260925021911599003|260925022911599003;
X-Microsoft-Antispam-Message-Info: 5JANxaFPoejhjdNcOFiWjKvclmzrlVGX/G9C07fWvmUnXcDYFENDQhkv17+c47W/ASrcuTMA0c3F0LIwsCEkxKB2pTw9s7qcRdKvQ9xwt3mj/eKbYIyAmQd9w4XMeyb8OrZtKtrQ1vpbJ16s3llowo/YE837SWLDEg2FUZYr8CxmoKef9W0nvCZQiVKlSpqcnw3w/uJWInwc12KKeI9B1mN5DHW7eVog+pE4RzaWMXFPDwUTr8IJsZLF6cJhsk5z2kwbTqGGJpF4ObwfAMRCctinGQMJ5oe6jFmAnCFXh3qxR7wj9KSdV6tMMk95F4jVuETO/6LOvqetVjStKYwvQ4G06Gi8agI71UmtS3iz+/brKrzKelFYMVJFCsQEiFFL6fNLxbd6NHqMWmDvvbzbw9kw35qOiT6gRIrYdASNjMTw6ZLpPASew9UIcJwUbB1O3ya7QB5kxLGW/FLUPCovoe8UOD7EAZhS4W9fSOP0H+ExcJE294tyQKpC4yfp95kM8UQT7abxZak58Sx6k/ckA8LhhBwACNRDlp0XPUrOvCiy1F03OPOyqIlEyv589SkJHHy/m5Uozh5DujVJgZodUEPIfJ2KQz7sD/330pKTBxIP651n8UoRx7MGQ7vIqHejEguTlut5PUvpk56Na6Mc79AHZyIi3wiAa0VKzuwk2Qg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB7144.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(10067099003)(3023799007)(261028144727099003)(261102123227099003)(261022115727099003)(261022113327099003)(261022105027099003)(261022075727099003)(56012099006)(261021135927099003)(261021130227099003)(261021123027099003)(261021121427099003)(261021133027099003)(261026130827099003)(261026121527099003)(261026135527099003)(261026140227099003)(261009223027099003)(260925021311599003)(260925021911599003)(260925022911599003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jtCKocZeq/HNcbvOOJb+bEnp1suYeJ6ozz+nVeMb3u1qaddBIuSArBJZtcee?=
 =?us-ascii?Q?bG0sne1yKQklv2wetPQmK/hLwdg1KTkkJIKk27YuD1MYUV3YTgnjGQ0NkEiZ?=
 =?us-ascii?Q?vxsQ9ils+LYpZsWrVXFP3l74g8IVmviNKuEFo/bYiFxFlGNdxIuqQ3Gtu5r3?=
 =?us-ascii?Q?0zwFPGDpESDNaqLxE6kAls2qiBfxkTarg4zR05V53lGIVwp0vxc+FTmzoUgA?=
 =?us-ascii?Q?6pvBkXky6SLFej6R495FSaVnaaZqhjaWacEZDpGiLIYDv5cPwke9A4BqKFYQ?=
 =?us-ascii?Q?HYiaBEP7ubfyJ6UXlJfWUBVSQU+PA6vo788aBDqUg1OpnwSeGLz48kxiMsh1?=
 =?us-ascii?Q?+G3W0lzDuJskH3bN4a4je61OcM9P67IFAG01RDDlxwc+LCGsLO56V1Fnz1eV?=
 =?us-ascii?Q?FxfUUM3c4U+RnJ0yjH2VjIQ1oH8FXi9u41AcOe+ByF5lgVsZeDGH1oVr4H13?=
 =?us-ascii?Q?jP4YyZmkIYGnrUmDEDxUhDRc7kTyj83fdxCUQQKHl/2vRls1lcrlyp2dwMA5?=
 =?us-ascii?Q?gCymckQAn7S9uN3lobvMBfgSWRHp8by/9YUwqPaLxhDhcTbW03N2yMfGNEHZ?=
 =?us-ascii?Q?t2mkZfT9D2EWixk3s7MeUR2CyROE6bTp8maBFPqZOzj4YCPvn9cwZXT8jR2T?=
 =?us-ascii?Q?emL+k274iBtQR6f4daV76d1hY517Y7llyhPtVBE4ORDMa8QNP67vdZ79/Ner?=
 =?us-ascii?Q?+8hkzquyv0nh25hC8ViwLrGD633BVQHf6Z4pW2/AuqafROpETA7Mac1ottD0?=
 =?us-ascii?Q?Fk4D6w3ZZ6bdoNqNGalWhIpWgJ/cV3seiKb9senekMHMZDCt1HudGOeFHhbz?=
 =?us-ascii?Q?C83VEXJvsI6pdjHIhd6pbezhQrIkN88IYwkGYsPWFNeBT+P3QCTIaQYnAGUR?=
 =?us-ascii?Q?0+vS8M4Lr74hMqm46kTjyteOJ6wEGyLaN329WtZi8O9iMY4Xe9QQ0Rz8twCI?=
 =?us-ascii?Q?+cVZJQ3SzdkoQGg4SFd4JMAzZFGREWj2bPXUXjgewHUXTlMeznMnyQ3R/FyY?=
 =?us-ascii?Q?iuhOJHovGQO1FLJAjD+A221QfA1LK07MvGEuDRNwS1uKqjcwRt1Qbr7fFX8u?=
 =?us-ascii?Q?k+UsaRjfhzs/7lf1SxbUjfuOQXICw1l2ARr4wRFmdrWfz+/TIWzp1QCNHUEF?=
 =?us-ascii?Q?Z1O4gYJjaKhWKQ3RWpGYFmUxncNvQXbcrS0NASAOOkPkt4n5kxMuO0cWWeln?=
 =?us-ascii?Q?SvTFjQcJfPlHzO1PyY77gtKCuyvTxqTaYB4QghdV+s6SVFoeMzp9r0OjhMBw?=
 =?us-ascii?Q?xmK7f2mdCEtA8ZArUCMpe3sLgTDT3WHfAU3fe83PHvME92dVd5GRuatSUJro?=
 =?us-ascii?Q?KTEXbj/2F0xJhuCdcz32CoJgDExTBkTsX3Dg6IH3nYd67P3jaW8A5Oj+j/Vm?=
 =?us-ascii?Q?ZnjU7f1/gmI1XfpTPp4JW7PnYyKwsfKKMfrocle3BnLd5GGLhxLcejGaMY/c?=
 =?us-ascii?Q?dzXMBv29OosonGYsoFsfnR9OPqSjy5foBG1cNKOP5A/eRZVirBrRhtfNabTG?=
 =?us-ascii?Q?exkgMlbIVVeytGVDX6KR/WmSrcjH/FosMY2FiW6nVdPTcxLsq0jdqRFWGAaB?=
 =?us-ascii?Q?P21AvhKDxBrcDDCpd+VSGkSIFY8YJIFdGFd5VAvph7kjgGJRIzvdzmlk3Jk4?=
 =?us-ascii?Q?FVBlbEvsYAnUEpPKDym22quN9M2qwxi6Sv4PlBS/uiskg+bGUpYOTkKiLs4L?=
 =?us-ascii?Q?OeUEC4+J9OBJJnOP3zqzVpN2AP8kOApLs+b832qI7DotsR5oBCwaCDSUDwIJ?=
 =?us-ascii?Q?o5qMcOkp6CAp74V1HGFUJ4Bd5yJmO6Q=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dcbaf77-94ad-4551-a62e-08df3d900c0e
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB7144.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2026 12:01:39.8422 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dv3O5CARL8vV9jZm9P+btMsE+I/cj40dc1K8P7TeWEq5Q0nuRAGZj1A8iCFtwtZGOmj7FzH1HbrmohpXFpPHm81sqg7PQVcZSfSJbJnWpm8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR02MB9138
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


