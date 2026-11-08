Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7166606A31C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 12:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=TDpamhi7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQ1ax-0006sP-RZ; Sun, 08 Nov 2026 07:02:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xQ1aW-0006mD-7s; Sun, 08 Nov 2026 07:01:41 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xQ1aU-0000V3-AR; Sun, 08 Nov 2026 07:01:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=czTnPnsMACuDfyFPsRR/pAF8jDeV/UmsXA3kIkhdGlYEpNSrjecXNzt1F0JJ/3O7nzgkwVTFLw16slQIzBk2jB+RuBgyDOQJnmb86OLatvRtdFKL4fcJlhr/RbzSt1h68UJz+VntffqMkW/G+zpG5RJhR5FaiAIDKG9EOeY8wvSsY6Jae0pauG1WuGpY458po7AfhS1UAVXQ5wQwpGZvozyU+aac5A7oiqUr7QjV8ofvAn6MNt+7314gX022LeEYPZHrmfECMaqUIIbqi4WvTweDVhTvK4B2GAznuEGshDeGFLDpgZkBGh4DNxFp6mj7mSwQ2CZZ1IEdTdZ8ZhqAUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pC0Clc8SvCDhihMFqI1fJWohVY7XsTw2+UnexuHzWC4=;
 b=vOux5ypueOrQ7KKOXVxsHfZ6jTcCj+JXHxkVScdzqF54004xfXfhUL7mfHstE4T2kmW96kc01NeUmqsyOAV6mYRL0C4BQz0b42+93PYpd62glNC4HovcD2QLhbPArnBZYsidBZ4typ06Jlk194ZI1OabHcAPYTzTJdOe+fA/nZMJS1dcJ4B0/kdD7QHdojCIvntACdv0CEYy702kfoygcTzq/LsCAiT3TN+d8VvlyAvGHhCqX/UNupJFR01PbPJfoGFfIM98aV0a/Zo3RM4vMkAQMYUap9ukCNXMwkpPHIRZnjVfFHko76rDyJreHEaZsevwnVyw7Y3PZYAahSTysg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pC0Clc8SvCDhihMFqI1fJWohVY7XsTw2+UnexuHzWC4=;
 b=TDpamhi7c2r9PkN6wxkDWUIGKXZKkKV10ZLhLi5oAFa7EKD1glPewlO0J30cmzLVmQ4HkCvi/HSReCgW1tpRmio3Pv7CANdESl2izx1yluU53OwB9a3EVjWnSJch/QAaG7/gZtnijARAnwfaUpe3oohvdXRSGf2y9Xwz7VHFbHyCS6buUZh2XuvIRlpO3gUcWWCfWHwLm4atJEKhP2dk4v0hGFQLRibk/b4MZAlGwgAwud+rdlMLFIek+w4Jiwlwy+ZFkoGdadbWI3HtakHYAdj1xdgNFoEh0oiTNRd8aUx3bev131AIBlThUPVOS7oqHT1I1bkXhlY1Xr9zMWPAGw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB7144.apcprd02.prod.outlook.com (2603:1096:820:116::10)
 by KUZPR02MB9138.apcprd02.prod.outlook.com (2603:1096:d10:61::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Sun, 8 Nov
 2026 12:01:17 +0000
Received: from KL1PR02MB7144.apcprd02.prod.outlook.com
 ([fe80::18f7:ed72:e33:ea5c]) by KL1PR02MB7144.apcprd02.prod.outlook.com
 ([fe80::18f7:ed72:e33:ea5c%6]) with mapi id 15.21.0592.010; Sun, 8 Nov 2026
 12:01:17 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: [PATCH v3 09/23] target/ppc: Register MAS5 and MAS8 on
 e500mc/e5500/e6500
Date: Sun,  8 Nov 2026 20:00:08 +0800
Message-ID: <20261108120034.1755008-10-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: 56b42c59-1482-4808-83aa-08df3d8ffec2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|10067099003|261102123227099003|56012099006|261021121427099003|261026121527099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: 6rFxzT8XDNy4/T7UuKr88SK/Ld6E0wAHv2Q54ScHHM0YI84XJp0yLFV2RARUfOpG2ejpBtJ5lWcTfXTOFL3kqazMDBl/rgY2u4UBaF3QWBW7U2dJlkwSGN+ZLxosx2Ie750MIusDs0wee91AcYZ8SHpqyIbueBUWFooZqyOQkvGfc+tZfKZMfaBjRqz4gnhpjd2ycIGI7Wz3yYwcWdfWI9vWj8LgfxrT8WCkxo4FLytxzkV7BjqFSrKTQTULRvk1ZBDl128Ky6sQwNAGZxv1FxTKmJO4XdEqpprkcGE6WNEusEtVlOtdq0/lUpearBhBnT+KSYMg7/x8EUgcTwaKrX24eU9sGgVhEEmHpNBNLbfpvghmj8loWbe59c+9onzyJm2dgxgY9kz0neMuURxAkvPjS95eUPCTBwBhA7sPHraxjaPm5pUEqhLorafk0h6PD21wpxanOhdzWo8/vnAK5ooGC27v8Iuz3rifyHrYSDIxQNi6SvxXW8FNjuSFt8HcTDtC7ucRgg8YKog138FSGgBVCD4FlPpb+BANDBc0w20gcDZbaji3aTczCHBuRvRz4S87EK9FfmdpTVJ2PruMe9ijjIhH4ZJc8fZ0gxi34qBBWndxA9Bpbh1zwoEhkTq3fvEKI84yPsLa3EnKEscDk/8+FYWKGcPPnZcqmnEQvhQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB7144.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(10067099003)(261102123227099003)(56012099006)(261021121427099003)(261026121527099003)(261009223027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1/KjqQiWVK7KzaeG/VzPB9E9cnfCGuTlFVyLTuFKB174doQKa/BZ8IabhHtZ?=
 =?us-ascii?Q?8+smVrafEdSkYb1es/xuc2TIL49FmdcNUbOyoaSad4FsVtpeHd5EXFvQWWkc?=
 =?us-ascii?Q?GVA4X/bmiGB5ZPs6tenap7hCm8ZFfpA5eovzZ/aU8IVZrCMqwdE5kUlDH7s1?=
 =?us-ascii?Q?4efbdQhyvwHoYEo3/Eocn7gEBXFO9irqRnuqJ1Pt/qnaI9+i6gHROPzEAtCN?=
 =?us-ascii?Q?RTl2ch4LX1NhjfoUj2XxCrTMu45vuHRdwaODtHcNqEDJ9ZOrr4oLFwIhJgiM?=
 =?us-ascii?Q?NfmHwPb7injk/YeyZwJ2FwCl9GYJPMBJTo+xlICraKwAA0YlCCHqCr81xgjP?=
 =?us-ascii?Q?BuMOfXBIMjX/QSCleSFlKuM6Nd1i+jix6sxjF0GpRUdxmp60GstfHm0Sif1n?=
 =?us-ascii?Q?QqslWTqsh3Km5nDE/e1FjfWN/5tKQz+K5Rdl7zUPnBau9fYQXnPWkshxVLyL?=
 =?us-ascii?Q?92uV6iFm8QXD0P+Ruaws5BULr9VHeaSQKWKou3OW3m4Bdy8GdylPxyYhffp7?=
 =?us-ascii?Q?4sEQcrGp80Wa5W6JSuXiBJOCjxze2D2B96tHTGVeE93HDbrCvlOnJzgyz1c7?=
 =?us-ascii?Q?5TIfxrwfMQ60xwY6UL5NAW1MnzddEqIiOt5vR2cf7afBM4WUzEj2zy3VoGdL?=
 =?us-ascii?Q?tW5tWOy6MG92AGFgG/2GmF2MjiGhpY31Vw7uTaFPNMIySSmyHbucGQYoLC0X?=
 =?us-ascii?Q?g1t4kYiV85LUm4yt0R1vS1gqngSLNA+GpXtaJX+bIFao8bxpszGSOOr6f9Qq?=
 =?us-ascii?Q?MRfaW5MmJYuYPI0AchPaCW7eIxy16uulg837Q6fC74ysddI9u7oQResyhdYe?=
 =?us-ascii?Q?u3CuluL5Y9xsz7hr3Yo0A3p8X6PMhVvl8CGPKV5ItUoBc/M2hU68RQvuqBe9?=
 =?us-ascii?Q?ZT+amSawRJhIAQyaP9QWxz0HsHJozVHfVLu57PfkKirYv7xCBOkagvK/20z1?=
 =?us-ascii?Q?2ONhazlk34uaUWfDjVmDaZdxhyuKirm8lc7CuuWOXYQYlGVy/0BaUpkV409H?=
 =?us-ascii?Q?CULL/IlItEwF45vhPzKRy1pQ1cKYzSGZ3Iy9EIfv14KjgPW0lvX7rqWcJs0y?=
 =?us-ascii?Q?XjL+eUGS9O53F0WVgqdgVG971grgEjsUxhNKegjYNUW1XH+pa6kSu4lEoio+?=
 =?us-ascii?Q?sjzrEezOhqU9MYUVx0FyXpo+Ka5oQxsEJ/mjfXI3UsycrTDnsHSAlpcNmQdc?=
 =?us-ascii?Q?RSye5PoJ4GJ6WooWbPa3YAUyeUM8fS9Rg/zBWlEslOBIjNrBRU1fDv6PknDN?=
 =?us-ascii?Q?+00Asua4ALZhj31oznFbZR+oTl3UhcxVmpn7/HA3NpWwgUVeAlk+BD1pZRA9?=
 =?us-ascii?Q?LvR05sFVLqlk/8HsDp7lvPJD1ueCpljRUK/ZPuVNP/e18EDimThWXZKfD4j6?=
 =?us-ascii?Q?UBbNnH5aFW+gFgL7XTpxB4ybCL3lKbvruAZmVNIAWYNgVdk+QZd6EMJ8sPXN?=
 =?us-ascii?Q?qqtNlse9bd2U7cjFf6V3IT4V2K0XO70WFLtxgBz17qc2NMJd6js01YWsoZFT?=
 =?us-ascii?Q?RIC1HjE+wJRg+rWtmtQu0uSyJpVeXHv7Fq65QFnUg8NwN/YBq/bX4Haw8j0E?=
 =?us-ascii?Q?u4JMoBT5f4JzUklavOGpEMirKUA0Nf3AqGILJzg6ii2Smd0W7VUKvT/aA1Hc?=
 =?us-ascii?Q?iYn0ydrt18KqiOFU0jP48E1Kay/JiwdRHCtY/xtRbADmnpT/0zlKWUN2Hs65?=
 =?us-ascii?Q?MFtRwCo3d0ko9W9pTXh4CNVjg/CM+MfO8scH5n+viGkGd4YCMoMSLP4y1Ecy?=
 =?us-ascii?Q?q4KSouUhYlzavPD0+AaRu5SD0Bpq75o=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56b42c59-1482-4808-83aa-08df3d8ffec2
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB7144.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2026 12:01:17.4978 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yhhXhUO0TwMd5jC/G7zGy5HPN3xf4/bhM/YRs+sE/oyh6dXi+O3nD3FTO48lLKLsHE0jzj4XUKV6gpF9Ds60cACKwFV8wSMd7OCAWpvmo6E=
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

The e500mc, e5500 and e6500 core manuals define MAS5 and MAS8 as
SPRs 339 (0x153) and 341 (0x155). MAS5 supplies GS and LPID values
for TLB searches and invalidations, while MAS8 holds guest-space
and LPID context for TLB entries.

Register both alongside the other BookE MMU assist registers using
the existing 32-bit SPR storage. Exclude e500v1 and e500v2, which
do not implement MAS5 or MAS8.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---
Reference:
- E500MCRM (Rev.3), section 2.16.6.6 and 2.16.6.9
  https://www.nxp.com/docs/en/reference-manual/E500MCRM.pdf
- E5500RM (Rev.4), section 2.16.6.6 and 2.16.6.9
  https://www.nxp.com/webapp/Download?colCode=E5500RM
- E6500RM (Rev.0), section 2.13.10.6 and 2.13.10.9
  https://www.nxp.com/docs/en/reference-manual/E6500RM.pdf

(no changes since v1)

 target/ppc/cpu.h      | 1 +
 target/ppc/cpu_init.c | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 3d76b8a082..e93f699f83 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1933,6 +1933,7 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_BOOKE_MAS5        (0x153)
 #define SPR_BOOKE_TCR         (0x154)
 #define SPR_PPE42_TCR         (0x154)
+#define SPR_BOOKE_MAS8        (0x155)
 #define SPR_BOOKE_TLB0PS      (0x158)
 #define SPR_BOOKE_TLB1PS      (0x159)
 #define SPR_BOOKE_TLB2PS      (0x15A)
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index bf535d3081..7bb4e4bcb2 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -2901,6 +2901,14 @@ static void init_proc_e500(CPUPPCState *env, int version)
                   env->spr[SPR_PVR]);
     }
     register_BookE206_sprs(env, 0x000000DF, tlbncfg, mmucfg);
+    if (version != fsl_e500v1 && version != fsl_e500v2) {
+        spr_register(env, SPR_BOOKE_MAS5, "MAS5",
+                     SPR_NOACCESS, SPR_NOACCESS,
+                     &spr_read_generic, &spr_write_generic32, 0);
+        spr_register(env, SPR_BOOKE_MAS8, "MAS8",
+                     SPR_NOACCESS, SPR_NOACCESS,
+                     &spr_read_generic, &spr_write_generic32, 0);
+    }
     register_usprgh_sprs(env);
 
     if (version != fsl_e500v1) {
-- 
2.53.0


