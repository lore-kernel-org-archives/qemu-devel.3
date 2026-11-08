Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090F0606A31C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 12:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=QO+g58yn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQ1cR-00085M-Fp; Sun, 08 Nov 2026 07:03:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xQ1am-0006vM-LY; Sun, 08 Nov 2026 07:01:56 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xQ1ak-0000V3-DE; Sun, 08 Nov 2026 07:01:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rLcetLGfRVcKXAxPknWSIuIPVzDp0ekKTsgN0Bsm5xkhvLuR88qlQJSbV46KiAtCp/F2SQPMaNO+Eyrd2UWtgKdNDgXGjhUQFDor/BuuHPnxeY0mhUn8T5PCKvTeimzVOihWCO/Uk1+dJL7JUXgRvKAegzu6adJpQpOXdqGLDw6UZvMDASJL5tyS++n/4Z32w9L5mWxDd8AbX5hOPKUeVR0u2G6SoXbY/C34kBJKaJ882avHRLOUzSuJE82yoM9c/g/5mDbmngqYHJLakcVQ6j7uSNEsDXshAvRHfdStUdSCkCAkBPkx6JnDXmjC1pPc93cq8zuRX+0IPREjH/W6cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AOPFbFgrKQWJ5Wbh7JxKbHh09Qv+hLLXIRVW7v+JYWQ=;
 b=JbF7yX63bd6P5pMJIcsXUnE9ABLySVIZgLmjSG7d3YVRJjJdD0FOIB9cNtWl5O/ORU+i7JUF60Tszp2xDdpLjYAvQvDa26VB4FLj/QjT2Ld4FC1Rq4IkqfW1actSuPoUXUWXOXSi+EHUYXTXHJQRBL9icX+tzNUz2o0uEXgI6qVEznfKtcJSJQdM3KoUJeMgnYQPjgyqXvFJMnU/R7IyDaenFmNeqcWWb+bkuU8VYjEDqYLOQRbZk7dUN++HFyCZkAkeJAkqljF0O///pmDnWB4BmvBvi2Ul/V2AkRyhdngQga4riqrcJySV+PS/TYl6oim410x9PVN0c17YozyUbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AOPFbFgrKQWJ5Wbh7JxKbHh09Qv+hLLXIRVW7v+JYWQ=;
 b=QO+g58ynNqvoNP+Ate8b0+tBNiWiLLYWXp4EpLV528Ck0jzPJdXBTHVWVnFaBdWfLOoABU3JzFceZDSFHgBJ2UgPh3Z0Ifx4kzM7Y6fD4J99ge0rkYeWVD0MUb9tgLgwchzd5lPtw2p9BV2DYXIGelf1CPCP0WWqnjM9ZMVfFBhe3nFIYDZjglqGQbLdVJpbeK018Iz5q2KG/zQ7a5UJXqRw//Il15xwSlBvU4PQr8PDCUyeHHd5cqeMQue1UEYFxC1BFIWx+RtAL8wSgCA2uzmiKMVGgnpnItYF9ydhx2ZJCNfzYfbbk6drQrPzcpuSq6E0c8c5YenZY1SnnWG9Yg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB7144.apcprd02.prod.outlook.com (2603:1096:820:116::10)
 by KUZPR02MB9138.apcprd02.prod.outlook.com (2603:1096:d10:61::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Sun, 8 Nov
 2026 12:01:42 +0000
Received: from KL1PR02MB7144.apcprd02.prod.outlook.com
 ([fe80::18f7:ed72:e33:ea5c]) by KL1PR02MB7144.apcprd02.prod.outlook.com
 ([fe80::18f7:ed72:e33:ea5c%6]) with mapi id 15.21.0592.010; Sun, 8 Nov 2026
 12:01:42 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: [PATCH v3 18/23] target/ppc: Build e6500 MMUCFG values from field
 encodings
Date: Sun,  8 Nov 2026 20:00:17 +0800
Message-ID: <20261108120034.1755008-19-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: ef15a3d9-4521-447e-968c-08df3d900daf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|6133799003|10067099003|261028144727099003|261102123227099003|261022105027099003|261022075727099003|56012099006|261021123027099003|261021121427099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: CybxFuUY+sZOoMe86QbU9ys6PM4A7Hcewo/5sRWScKtoyhJHLDu21G0TpwHYYwF+faRwPLvBcnNyXgJqvy+r+xGs4Y9QOrvscIeHMTcPLxXK0dlXn4A8imSKZYIdj3UEUIsRbRDatRNDh1h2RHzqpW9IPR2KMZiqnLedbl1HDZKOx4yXS7yUCtk9W822dVExNkH1mUVja/PDhF1C4yCh5dP9gdtvjZQw7qYgClsWpR98ji8fPCBXNATEZIqGJ6WBpOi9P02KFBUcxdetFWjBEardr/4rxNJMLmklXMfOfx4IRxfk5LeDw39JEV4GVge08tdhZ1ZYs9MSg+BIDWZvATw4PIjv8h1fgh/upoojEtf1+MEodoSsiJDG+60PIsVJcmzTT8FQHV8d2i8a4Whg3BMoWg9dQ6jIypdftiMXZGxpmrAqZ1p2m0mCXTACCEj4z3fJ/jOMWNdRjBpTwV8pbIW6n/5XyJL/+7VuWD6CJdkozFZgOcz+TQOe/FMwsyb5ok2RL7srjfWmHypQ4sAwu1erx1haF5PTGszmuCyt5d8vNaZfNu5dDEfn9biSqtKeyFKbP903WQqfpXaRw3QSQ362tGspjCjmbDTr7PKdLaJffl9ByBI80q6uhIWwpxlH9SULKEMapSH188UccFbtnMmyAmGDE8JydUzObiRqFWs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB7144.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(6133799003)(10067099003)(261028144727099003)(261102123227099003)(261022105027099003)(261022075727099003)(56012099006)(261021123027099003)(261021121427099003)(261026140227099003)(261009223027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8R121fjtVBhj7qmNmbSRSk4SjDsvdov0F7F/wXNAc3LLnnajUyP+gP5sKotz?=
 =?us-ascii?Q?r62ssJS6rNjrtzOV2A6ZT+j3959UJAHUcFIBI3Fk/FVCQvo8bn5BAS6Aolek?=
 =?us-ascii?Q?keqU+7Kz3G8i4r0LheRMKhq23y0M0yA4ZGxEx5JeuIsMAWGkW5iqBvTsocCD?=
 =?us-ascii?Q?r1MtwQi1zgqoxm5R1JM1REYeuy880pjWQJyLEg662fB4ou/NwtU/e45Mqj6l?=
 =?us-ascii?Q?evnFrTcaGmHfwJNMUXgzAMCECRu68TT9wVP4sGVOkNxq4qA9gsyXZqC2ry3S?=
 =?us-ascii?Q?jx4YZU2w4wCoib5vHMFM2EJ/w+a2tHRETfSl2ywAKfGgddNM+I/oBT+GzFPh?=
 =?us-ascii?Q?itxdy7qOYSrYVqI7M/8dxh32M07jOS+6EU1TETmw8kyYPwf7Qm+q5V/qZN1o?=
 =?us-ascii?Q?TapXTVC9tjyfpLW9VgfhTOs8Awhno3nQ8tGobQIL7KZRbDIT5tL4GBKtE3Ak?=
 =?us-ascii?Q?nk4PtaGS76iMQYhfUZSTGlcnLKJHz2RDChU2xFNSBvHMPIGNs+Tll3IT4o1i?=
 =?us-ascii?Q?Y1kLH7wzNtnGZSNklHOxCEjUoBpQS/ri9lp1hUAZE0KkRn+4hA2BDGfdc0Ei?=
 =?us-ascii?Q?r6rfiRrC+0kP+y3jdi3qLViLoig/ZBoFZeNuYRbpM0I6L5/8Ld4ZEiPszB75?=
 =?us-ascii?Q?l1dWVxDu3M6q9PbZsCLxqtde84ArXQTNQwclc8UF0ByqIi2zSpxqRkFiwA9o?=
 =?us-ascii?Q?UjokhKBb/Kr1s5Z49uiScChz642J+9l2B5oVQJpcucApflPCNGIaQxrLXhkq?=
 =?us-ascii?Q?AL/IiR3HySIqgSdoxGsyIGXWJksFp5QHhEtjm+FyN+WN1sxACH0RJi4SXMAx?=
 =?us-ascii?Q?1C36fLoJMGmlgT8aWJ/cERt/stZP0l06yDD9+Ll0Ob2kwp/3Fspw1x5vbwjm?=
 =?us-ascii?Q?k8ycrxD9skDHPnMwO2+754LueaKfsqN7tof/N/JarbYS9EpEoub1oy839nIh?=
 =?us-ascii?Q?ljSYu95T91FRagAehjm9BdF5ILI3Dicog3NazmxBtvpPvx4cLyQBJajHxk7h?=
 =?us-ascii?Q?e8ueXl7oO8DNDbfAux24bIR+cJc3kqb3aDG1xXoFJfSJDtNhf2ZB06MSR984?=
 =?us-ascii?Q?eIeqPJoPUVyg+eG8hMMrVKDiL8XLWNxE75e47MOeuCceSJ6W/g2jhoz/o01t?=
 =?us-ascii?Q?ji8vNynD07gpbvfYJErcLRe/f7roQvdPHrJySgmcRIFceXlIb3g+PGyWxPq+?=
 =?us-ascii?Q?DHm94BCZ/nHdpx/Ca6RGC5kN9lbUJUlezvj6MlXnYh+OolndiDovh7m7b8fj?=
 =?us-ascii?Q?CIWjwAFE2tBB/FUav4ZxjPw9kny22fKLTihkN5Kc0tDaX78YMccsRxOHhGw9?=
 =?us-ascii?Q?WJlJ5SG2Y9ID5kC5dPJfrCN/W+Przpek+8O6PH8Ygdjl1ayvnKlmaJcbkZvA?=
 =?us-ascii?Q?cjYkNrclxTYxjmy7i58P9sjUcXjqVy7PYEHwWU6jb3zn9Nz3oCgYbH3ezhFe?=
 =?us-ascii?Q?e75X7ykuDpEDI17RUSgUz9fRq/JV8glRgea/Bk5vFJC+LGVQz8ZD0Ysdudd7?=
 =?us-ascii?Q?ZAgrhgmdvNsYmYOabYTyHBWkVClXtBF36NpLGQphpmLhAjaXsviE61zidN5Q?=
 =?us-ascii?Q?x8weIfOKl5JV9rUwsyOjoM2HrPnRHfd8CqgF/Ml62wLtqAXI5qV0QswA+Sh/?=
 =?us-ascii?Q?RPm6FF+qrjDS28/5vRiQ+PdSiSSEQdXW7JN7ZkQ5h/1JrlCLXHdpraXu8dM7?=
 =?us-ascii?Q?euvrHqI8uMwiBVs5Mvxm7QO01OdolG/ksxPYFOL4jJtCSHv3uAi7iB/YLRWe?=
 =?us-ascii?Q?9ZeSxey33N+2a3ShJECs9YyESq2Ksic=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef15a3d9-4521-447e-968c-08df3d900daf
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB7144.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2026 12:01:42.4701 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O1SZYR5wBfr9bP6Y4i9nIhUzjbEYFZQHMFrP+OUeRI65RIaiW/lB0lshcN1zeeL9ivGSFQszWcPEU9oVn1ruQCULTXhu4lrF4+8a/BOkmu0=
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

Add field encoders for TLB count, PID count, PID width, real address
width and LPID width for the MMUCFG register. Compose the e6500
configuration from these encoders. The value remains 0x06510b45.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

Changes in v3:
- New

 target/ppc/cpu.h      | 24 +++++++++++++++---------
 target/ppc/cpu_init.c |  4 +++-
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 7fe02887de..451b794a21 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1120,15 +1120,21 @@ FIELD(FPSCR, FI, FPSCR_FI, 1)
 #define MAS8_TLBPID             0x00000fff
 
 /* Bit definitions for MMUCFG */
-#define MMUCFG_MAVN     0x00000003      /* MMU Architecture Version Number */
-#define MMUCFG_MAVN_V1  0x00000000      /* v1.0 */
-#define MMUCFG_MAVN_V2  0x00000001      /* v2.0 */
-#define MMUCFG_NTLBS    0x0000000c      /* Number of TLBs */
-#define MMUCFG_PIDSIZE  0x000007c0      /* PID Reg Size */
-#define MMUCFG_TWC      0x00008000      /* TLB Write Conditional (v2.0) */
-#define MMUCFG_LRAT     0x00010000      /* LRAT Supported (v2.0) */
-#define MMUCFG_RASIZE   0x00fe0000      /* Real Addr Size */
-#define MMUCFG_LPIDSIZE 0x0f000000      /* LPID Reg Size */
+#define MMUCFG_MAVN            0x00000003 /* MMU Architecture Version Number */
+#define MMUCFG_MAVN_V1         0x00000000 /* v1.0 */
+#define MMUCFG_MAVN_V2         0x00000001 /* v2.0 */
+#define MMUCFG_NTLBS_MASK      0x0000000c /* Number of TLBs minus one */
+#define MMUCFG_NTLBS(n)        (((n) - 1U) << 2)
+#define MMUCFG_PIDSIZE_MASK    0x000007c0 /* PID width minus one */
+#define MMUCFG_PIDSIZE(n)      (((n) - 1U) << 6)
+#define MMUCFG_NPIDS_MASK      0x00007800 /* Number of PID registers */
+#define MMUCFG_NPIDS(n)        ((n) << 11)
+#define MMUCFG_TWC             0x00008000 /* TLB Write Conditional (v2.0) */
+#define MMUCFG_LRAT            0x00010000 /* LRAT Supported (v2.0) */
+#define MMUCFG_RASIZE_MASK     0x00fe0000 /* Real address width */
+#define MMUCFG_RASIZE(n)       ((n) << 17)
+#define MMUCFG_LPIDSIZE_MASK   0x0f000000 /* LPID width */
+#define MMUCFG_LPIDSIZE(n)     ((n) << 24)
 
 /* Bit definitions for MMUCSR0 */
 #define MMUCSR0_TLB1FI  0x00000002      /* TLB1 Flash invalidate */
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 52340bb84c..945754e9a4 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -2865,7 +2865,9 @@ static void init_proc_e500(CPUPPCState *env, int version)
         tlbncfg[1] = register_tlbncfg(64, 1, 12, TLBnCFG_AVAIL | TLBnCFG_IPROT, 64);
         break;
     case fsl_e6500:
-        mmucfg = 0x6510B45;
+        mmucfg = MMUCFG_MAVN_V2 | MMUCFG_NTLBS(2) |
+                 MMUCFG_NPIDS(1) | MMUCFG_PIDSIZE(14) | MMUCFG_LRAT |
+                 MMUCFG_RASIZE(40) | MMUCFG_LPIDSIZE(6);
         env->nb_pids = 1;
         tlbncfg[0] = 0x08052400;
         tlbncfg[1] = 0x40028040;
-- 
2.53.0


