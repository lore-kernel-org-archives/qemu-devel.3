Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D444606A31C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 12:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=JwO+ZREz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQ1cm-0001OJ-JA; Sun, 08 Nov 2026 07:03:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xQ1av-0006yA-1Y; Sun, 08 Nov 2026 07:02:01 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xQ1ar-0000hv-O2; Sun, 08 Nov 2026 07:01:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U0Uboh/96Sci+TnALkpNl9v5PFBMFRCs+eMJxSIsMMNb4magTpeeQkhKzNpSJqMTlF9lDsq0Fe4xD/TR7nCsDjk73/NHiuJQ05+jS5u2nRguztIqZBcR1KIWHR+dgDzy6zwkimzLqcfHXs2YOLXFOiKgGGiIoK8wMyZ1pdfyMuB58maZXyAFUvqE5BgOsh/ZichCBoViWoxA2u8YU6JRm0ZHqvSl3augvKiqkD0pIefna8jk1fELiKiEH79xXIoOQRbv+u9/Edcijmjk4qBiBxlVPWgXQoqDFM5akUnWZOeb7qGGuxJUdVZuS2uwifrW1ZKAUVWlEebqdoOk38sRMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BfJRQSrPzqj5L36XWwIi/gAe6MgeV6Yy3FAo8v9hYB8=;
 b=Okj5Kcwg4pZTIKP9x2wdzR/G4pKM/ukKAaH2RPjBxNt3DS2+LaUjcGzm7VDcrxZEleTnUbyYGRUiVXX6ixIyR8wmQoUaS7ZoI/5RKrXg1qfUNRKUWqvcZ1O6EG+puvH2EZwea0TdUXZWYGy0CQ2tLD/xcDVgjBwd2subnQfKSAlyT+7taAQRGtwbcNY4u+RrDnnGUfBl6538j4YBIxhYCfza2feNEgAvJ1MPghFVPJ0de6u0JlrPhOuv4q0Mt/8POYwEEmEg55SNZDxHsbTPgWWe0BUmDenUOQYa2fbByz6x0XfCWyxsc92f0kJTHXASWqleM+HV25z/yqUrasl+Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BfJRQSrPzqj5L36XWwIi/gAe6MgeV6Yy3FAo8v9hYB8=;
 b=JwO+ZREz+gIs2ihQasn16IuiDDwvlGObb05EG6PUTHjpzgennbBrwUM8MKzIF3sdAV7YHJqmxskarhy74zQjYfkeXKmpCXq5YxE7i20tLKXAYwYu+BHdVkj4l7mQBDwFkVTRHzngK+aDubCdVkLgVzRCLSL3VLDzDvRMwELIpyNdofErKRJ4qcfMwaaTQbE5aGPZQ9xY8eI4lzDpQB4M94iPbA7s/rSKhXgXXABylq/46+vNqPauGjKrB4UY+Jpqoko9MQ7MyZLy69zSN0F9oQHj8d0YxCtxD/c/oxO3T6//czwOlQ4Ccw/lcCqV232Z5D+hcQiDwYRLpqRV9OAReg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB7144.apcprd02.prod.outlook.com (2603:1096:820:116::10)
 by SEZPR02MB6945.apcprd02.prod.outlook.com (2603:1096:101:19b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Sun, 8 Nov
 2026 12:01:45 +0000
Received: from KL1PR02MB7144.apcprd02.prod.outlook.com
 ([fe80::18f7:ed72:e33:ea5c]) by KL1PR02MB7144.apcprd02.prod.outlook.com
 ([fe80::18f7:ed72:e33:ea5c%6]) with mapi id 15.21.0592.010; Sun, 8 Nov 2026
 12:01:45 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: [PATCH v3 19/23] target/ppc: Complete MMU configuration for e500
 family cores
Date: Sun,  8 Nov 2026 20:00:18 +0800
Message-ID: <20261108120034.1755008-20-bin.meng@processmission.com>
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
X-MS-TrafficTypeDiagnostic: KL1PR02MB7144:EE_|SEZPR02MB6945:EE_
X-MS-Office365-Filtering-Correlation-Id: 208eb8c5-91e3-4b65-09d7-08df3d900f3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|6133799003|10067099003|261028144727099003|261102123227099003|261022075727099003|261022105027099003|56012099006|261021123027099003|261021121427099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: 7XY9Yt6sMKnSsuDP/ArL/5yeMKIYTPp/G03CGQKr1OnHgxcpYAybN1bNG04BqxF0IsivA7Wh3HhhrkQ33hEZkz676q56r8PeJVK9x/vMTN8sxlJX6dQElOPO/86b7P6NXFGaECmVf5711a5vAB0EBYP9RzcwOYGviXZdmfk9/CA0DPjBCB9npuc8ZwrUF747IUYKtCoUXdj6ffv56/VGgnnPDqzl/Zl/QOW+1CLkYgfegvFOToVK1YfwNewPDJfLWkOV/YvQ538Y0WeSK31MiUXNG1L+VlEu9BUAlmVEzzgiKIvFoJeStKBDDvhVEx26OiMhKYbKWJlCSvt4f1kCDD2COekZv6TzEGPJJnw6kLvm0BktaYyxaNuvD0kMNIO2X6kUs8+IghH1dDNfLC1FGigZJY7dvAHjsUvcnAQesMGiI6y+S9Mm4h7CeI0t4ImvbI6pBHCjX2W7zCigC/49zqWA39USqFzQna2snJ+gpiR26JZ9zb9wWcZ4HIT5XAU4V17CkHUjkSdMWPpfaFTLZ+DsjsaBezcLQSt1ba9iLIY4CKIFQ+NXG+1sYt+eMP+JyYuAo+I0a9VyIzUAVLPwDJ4FLzza7X2D8KmJeAYpW8AlBFELOBbjmJZq+ztmPCmcWsBdhRDf4IiCr7uClCaVgSJjjO4iRNoRyPWy8XwZfDU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB7144.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(6133799003)(10067099003)(261028144727099003)(261102123227099003)(261022075727099003)(261022105027099003)(56012099006)(261021123027099003)(261021121427099003)(261026140227099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R12XxoRdcO52QaeCMFrWjw5V7sF7smgX7RWt21exz2BFW5En8ztPnTVqRSf5?=
 =?us-ascii?Q?o/vERJGs0FuohW6EANxjEMg2RgFXAMJSS14L3aonmXZrqD/KH7es59D0VR6t?=
 =?us-ascii?Q?YFMZ3whRlCLnUtGt6M8ngIaAtTuir3aIvNWVMvWxCW6sCK55zq3ZWhoOW7+h?=
 =?us-ascii?Q?/SYMOXazzEcWAqcNF4XUcgLiPBm9v75RTzojYAlN3xj+T1/iHMtamLBC+weY?=
 =?us-ascii?Q?+/8gXhyONauDaNcEih0fYyk45/a5ApxCU+lKd+By8UZBcAvKCU0b6FlYPtBC?=
 =?us-ascii?Q?/XZT29gDGi7m71EijAnB60dIKAkhDwGW/M4AaYxtCqGAKS+PE9E+chCadQqz?=
 =?us-ascii?Q?p/qyKhE07y9fXyxzGNtsjt2sObxxWv1bDZijhSixncaGX3/kO2TSb3oZT/oJ?=
 =?us-ascii?Q?7qdtWQIfHGOBh3kO/nCg0+T45juFJHMyP+UIU2Y1HPQ4bjUbLaz7OWAxq1Wq?=
 =?us-ascii?Q?N3iI8JI5dh9rWdiAll3hNBuBzHzzPMy9xEhCR/ShmS6Ty5Sl0KAqN88S4HJy?=
 =?us-ascii?Q?uVKBEHKSgK7vCHfT8OFWIlU4iFZezmsw9lrgn1vwTglnpYhuhCRPQtiM+JM7?=
 =?us-ascii?Q?Cy17w8ADTKKEkiCXy0HAb9uT/YRxAi76+jF+9tPbKPbpKeqbX0CiFMLaOzOD?=
 =?us-ascii?Q?0rZGU51py1w6WQIQwdvMMHeI/zrOgzyAwv3ypuYWBOspV0j+e+JwPLadg1A3?=
 =?us-ascii?Q?pIKVKrwJxQ5dQ9PcQBPzUNHzbr2uHUxvFvJtYEjYfjQ65/EKHKBLdGaDtjsV?=
 =?us-ascii?Q?8LPy0YKQqjqhRVliTztsqcuV5SKxHiQ1MQbLD1ueotTth1Yir+15chPMR27r?=
 =?us-ascii?Q?1AgbpumS8+N7ecFy5E1oz5CvuoIfjgEuWN6PL/GlgQrf5c4JnG55Vr2xw+KB?=
 =?us-ascii?Q?s8flDhGjhBuWrAlcBneuDbjEJaG1dPvWXhQUUeI7vd1TKGk2oSRg5+YA+4yo?=
 =?us-ascii?Q?2dbCpDQRUXCRj2anoNbTILw+OSjIIBzYAob9J6Uz+QiE1SBiSP+4FVUNqQGN?=
 =?us-ascii?Q?u4Uam9OFUIxZY91hmRzXZ51tGaSWgVIB9mr4ylmxOqcUVWTGfHywH8Jj4SxF?=
 =?us-ascii?Q?BO6nh7Mm+Xn4ej4Wj+fnf8YTwyttjk9B0ORhTB6SP8ld8R8pUPKQvXPT82r3?=
 =?us-ascii?Q?nC5TOFD/fReUfUkz5HbMNJ+jBUYAIE/cifSkF1+1gsKz+1Dal5F3BbLjiqbv?=
 =?us-ascii?Q?OuLcelWfH7rr8/JItROsNZPcdSw9Wdf7sApMJed+SvMXYIQIDCNZmF8tw8cJ?=
 =?us-ascii?Q?MxuDgFkftauPvQZ1z7/nWMLx8XqOKQ21gyZDiiU0Xuw2htmhPZ14ewM6Ab0p?=
 =?us-ascii?Q?hSSW81iDBBIvql4IRaWOIM/x9Enzj+zzBJtS7m4diPcoE6Vdk2GmCAloR52R?=
 =?us-ascii?Q?aGAfrzpbzft64DzGE2Hy5kwJWp0Ou5RpPZnUyqs2f5nZPw0KE2rALG874nZK?=
 =?us-ascii?Q?eIX5ryBdr/NRiqIOinjR+SjKcRIaNgEFlYY7GjmEvu8LaGqLm1atxpPtu1ty?=
 =?us-ascii?Q?vNb8slWnJroBfrNVxxP73uCDnVuh7p02FTBefhFkk6FU4nK5tXW27xZuBvNQ?=
 =?us-ascii?Q?bwAF1VtKuqJ6nGXFBv9OGKAaaGI5g3pt5Y1HdEVnpezQBc5sixPpwNDSTvXY?=
 =?us-ascii?Q?zcLf0qswDaXyg2Aby17VVfzgEn7htcLHGEbaDQ5FzUrcPKucSc5378Ij+7Sl?=
 =?us-ascii?Q?FeeS0HtnHNUYwiJLlx56R5ZgjTOmLNzWxxWrXIjszDY5gj0VD/MeEoE8B/LV?=
 =?us-ascii?Q?rou981R6qSM5/42OLYV3flm/HCxYfkg=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 208eb8c5-91e3-4b65-09d7-08df3d900f3c
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB7144.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2026 12:01:45.1640 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z/iH/oMiU09fVkImOiPSX2iqSGjS6Q+CektfiKP1xmJfYX3KEPQJCPXjKCFoFPWFkPEWBgCDe2Or1MT6yUhzClrHkYnTkJgeGQKE8eMY3EA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB6945
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

Add the missing MMUCFG register initialization for the e500v1, e500v2,
e500mc and e5500 models.

For e500v1/v2, use 0x000019c4 from the field definitions in the PowerPC
e500 Core Family Reference Manual, revision 1, section 2.12.3. For
e500mc and e5500, use the shared 0x064809c4 configuration, which
matches the e500mc Core Reference Manual, revision 3, section 2.16.4,
and e5500RM revision 4, section 2.16.4.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

Changes in v3:
- New

 target/ppc/cpu_init.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 945754e9a4..72a46d72fd 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -2852,15 +2852,22 @@ static void init_proc_e500(CPUPPCState *env, int version)
     env->nb_ways = 2;
     switch (version) {
     case fsl_e500v1:
+        mmucfg = MMUCFG_MAVN_V1 | MMUCFG_NTLBS(2) |
+                 MMUCFG_NPIDS(3) | MMUCFG_PIDSIZE(8);
         tlbncfg[0] = register_tlbncfg(2, 1, 1, 0, 256);
         tlbncfg[1] = register_tlbncfg(16, 1, 9, TLBnCFG_AVAIL | TLBnCFG_IPROT, 16);
         break;
     case fsl_e500v2:
+        mmucfg = MMUCFG_MAVN_V1 | MMUCFG_NTLBS(2) |
+                 MMUCFG_NPIDS(3) | MMUCFG_PIDSIZE(8);
         tlbncfg[0] = register_tlbncfg(4, 1, 1, 0, 512);
         tlbncfg[1] = register_tlbncfg(16, 1, 12, TLBnCFG_AVAIL | TLBnCFG_IPROT, 16);
         break;
     case fsl_e500mc:
     case fsl_e5500:
+        mmucfg = MMUCFG_MAVN_V1 | MMUCFG_NTLBS(2) |
+                 MMUCFG_NPIDS(1) | MMUCFG_PIDSIZE(8) |
+                 MMUCFG_RASIZE(36) | MMUCFG_LPIDSIZE(6);
         tlbncfg[0] = register_tlbncfg(4, 1, 1, 0, 512);
         tlbncfg[1] = register_tlbncfg(64, 1, 12, TLBnCFG_AVAIL | TLBnCFG_IPROT, 64);
         break;
-- 
2.53.0


