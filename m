Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12A1606A31C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 12:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=bz8DGDrF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQ1aL-0006fh-Vd; Sun, 08 Nov 2026 07:01:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xQ1aJ-0006fD-DW; Sun, 08 Nov 2026 07:01:20 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xQ1aG-0000V3-GJ; Sun, 08 Nov 2026 07:01:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=anzYR5a9ZHrBfCJCuisIoXZqBvzWKYXKWNwcfO0MXclCUS0nMjDiD/cODCzIrVpvZosJ9c0DZ4IY+kXEl0gSvbNNKEMyfxs+3HuVxgeaUSCMhag7Z8eBaxkSB+NX6a7QNT1GuOMgN9udSiALwD1vnTDEVtiDYio7Nr+HtnK8yz84mWfcDvD6C5yOgtm6Nyjy6owECu1bjBIB4+22gbPjY3xy9AhzYbho4AB7EpIYqMbXZOF0hav+HaadIeEffBS47+436vz7PW0KGQmpSZ8+M7uVQHlbVxjyisQeiSggNhiaWUt7EiAkTvf3vxKn1VIvVDkQgyflszeqU+GT004mVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sUTgfIbUdohWZc7i3EefgWtd26mgIwBYJORXuWfE7ws=;
 b=cDJ983zSzBWFBpaedATz4m+Q7WnKMVLkmAwe/AbZ3KZGgIQKXFRq/8KMK4ApacfhOR2L9UfNKWlg6ZNdck1XqxzMaAv1+xrM0No8n1WMcTiyRlYs5qkZzj99UnKPmpQvzbQK72Aj88GRUvlNCEA0fPCrj/Z/J7DvHZPFtA5Lx76AOFBNpFT2PTm4+VOjJ/Bme4OdXliACCEErO9Z7cCbyp28Ec3doknQ6n+0+Vhx+VhVBkUQFzuPr+tKJGzjY5T90zGMtIVDfD166BXIlykdV6c6Z0h9f9orNCTnuqDJTY3qWxKd650jXdu9xikbW7g9SMSzT0zNQbG5LfD929GvYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sUTgfIbUdohWZc7i3EefgWtd26mgIwBYJORXuWfE7ws=;
 b=bz8DGDrFbMHTr+vC7rxbVGAnyBOCVLwsewKKf7VT88kp+jakJcC48r8iXflAf9kHoJ8qMCsPAGhCM/u+RhzvXLKQRsw93LXl4tiZo+CqyGWtLSo5zHS92LCksURWYdaM5pGZL2uBp3OFEOcpKRPDM13rL2I31m7GFlbl1mpzGKjQqoMyzJzNnTTIdqK52rt4sYFEpN1bvCKYrjANK5RocbLQB+ucFIPgdKiVXZ5QkrYgi2ZFVsBTnTR0F6L92QkIe6JxqAcblNy59Shyzecbx7xmx/1oXHJUf5LTuJ5Mn2uZ0jjFlukPB8zRR+keNslwOHHW4w5LHFMtr2lNOUcBjA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB7144.apcprd02.prod.outlook.com (2603:1096:820:116::10)
 by KUZPR02MB9138.apcprd02.prod.outlook.com (2603:1096:d10:61::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Sun, 8 Nov
 2026 12:01:03 +0000
Received: from KL1PR02MB7144.apcprd02.prod.outlook.com
 ([fe80::18f7:ed72:e33:ea5c]) by KL1PR02MB7144.apcprd02.prod.outlook.com
 ([fe80::18f7:ed72:e33:ea5c%6]) with mapi id 15.21.0592.010; Sun, 8 Nov 2026
 12:01:03 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: [PATCH v3 04/23] target/ppc: Complete e500mc and e5500 L1 cache
 configuration
Date: Sun,  8 Nov 2026 20:00:03 +0800
Message-ID: <20261108120034.1755008-5-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: 14baed55-00d4-4608-9fa8-08df3d8ff692
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|10067099003|261102123227099003|56012099006|261021123027099003|261021121427099003|261026121527099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: V57WOWji8rziHACf7/0tBp5i3mnaGH0MGpAdB6Kr0FQ2ZA8RmquYy+eaQLTFIqy5dPJ5Rnlp341+aap2bV0TZaiA1TSv4eU2Tm5fHvgTQhacU8KuI9skdWOYGpAzmNB9fd0qNDfGdYFX0efzG2BgjsLyq5N9aRLB2v6YOJr8GDQrfPANKy1hG1xn1Xfvqzdf6FqztZ0cQHYj4pb/6MPEu0DppyT6dkkLkbUgI4aab5H4oyrVtJQMaGT82pSepsZWNCJGz0gbdlIm+dFHjb+dwW3u/c6MwDPI9L0iYUFp6RfooGr6627rqD4l8IjokTeeGHvTkQSW9ax97ebfgizbK0e8c78qc5HxoyIs3r4czahsUuVqGynjDo1r4+xEOfDLTlhKDjBks4nJRsPtCwFhBgE1+fN+6Zs1WIJqDVxcl/eHmE38Z8wDfPJk0bw2zeu1sV4BR2d5YkCWolk0WKejpm32lJ3WCY2ov/8FYEd593J/fbwHRR2rZW74w82YXyMq49Xg55vK5rcXRriqJQ/MgIQgKLIW4Wo7voBvjJg+Ts9Tp9HYaI5u+kb5xebOJFVAiilA6Gr8+iP1ecTcqT28/ndP3K2NVA+B0rDYo9GwAnHp9o0+NKuod+uurAqomPNC9vLKqQ3DR07JQCHSkfPh5W+P6Z29nE/Nnsb+pPjHXM8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB7144.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(10067099003)(261102123227099003)(56012099006)(261021123027099003)(261021121427099003)(261026121527099003)(261009223027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Qdvf2c3O2cCKw8YvVN9Sp1ozejb1TkPGJFnMPmvvzq0g7nBOri2bZ7YMwnLZ?=
 =?us-ascii?Q?mgLS4Kc64/fSDaXVniHG6GvTY+lVKLhAb9ZTrWUaLcL9D+HdujUrj75QwjOW?=
 =?us-ascii?Q?49rNzvtoG0WUE4yxW+ZG4+nxX50Gi6iixRhcOFXjcg4wgjAraK/CEXXKan2U?=
 =?us-ascii?Q?r2h1UY0+in2+JaJMBE/IJRZBchBrOpCUmDO8JPu1CuiQNVk+ZOI3WBVOjogh?=
 =?us-ascii?Q?2dFelYvEQyKIFHoYXo0kCU0K4U1MgIB/AY/jpf+4Bn4xuICzxca3tl/fJop4?=
 =?us-ascii?Q?C3GwwfgP1vtoY5F0s3ln0+8T9w+b16lAbvFHozv+UqXRTEoUZaBjyP4cWvkn?=
 =?us-ascii?Q?Lx1A86mWpD9ycIfswCZw4u5axK0OqxfwsRsCl5/elfrrbsUkJ/uu59Y7B+tl?=
 =?us-ascii?Q?pppWT88QqdsgsLH8l9vBrdZl+tAzCp6hFz4uVWov9N7X8jXzu2oiZrsfT1Zx?=
 =?us-ascii?Q?9rFGiPv+3eptGlhZqihpRq8tCl6woo9pucd/JuCzTd5HzaySkOYUobBbZBsL?=
 =?us-ascii?Q?ioeJ19Z1PbrYZ7DmmT+3jX2cGmBk3XrBIsHseVxiLsRtKj3/cwDe4JJBvXIW?=
 =?us-ascii?Q?2EKdeHMffb7wkxQ4c1Ef6/Nk3S0dF44hY+6ed9acQVMRRtOEZ5frYoqTjoj2?=
 =?us-ascii?Q?tmVD5DKlNKIRSxuke1LWK4FYjJiuFtBnmWkyXQ1jEgkBOxBsI6H9n/tbKnmu?=
 =?us-ascii?Q?1h4+XtE3JUhQO19zaaS5GUCGSGeCIHuW/iscszHOcKl7JTpdGRTFVaB1Lmwl?=
 =?us-ascii?Q?1BkdzJz5FfGZ3J149ty7I8dp/9tBaD0JHr0tQjqG62l9LqviNWgqlMtBiJ0A?=
 =?us-ascii?Q?SHY3EfYyhKrQlCtWyc39VX07WAw1FydgqhfpaADRx6z80+MNACvmuGqagQWl?=
 =?us-ascii?Q?lkDyZtASnVTYZOC14TTCKoYVH0hMtHTn8929e6OxFAgUb0sfAmYcCNpeRQbl?=
 =?us-ascii?Q?b9Oq7ge+w0mmjt8Yzis87L3Mf+WWIcvd7NQLsqCwSGtYxM9Erryr7U1FfxWN?=
 =?us-ascii?Q?gyCSIE/N/zt7qY6i6AYRYt52mMFMqs5eqIeqjH77doW8RudbLexW5cQbvYVM?=
 =?us-ascii?Q?yC+FTg3ENxeXRzjpdjAnxGemUfv4EKSjOiTEEPajqO/ABwKsOKjXlKtbu6UH?=
 =?us-ascii?Q?PPDzn0q8GytJRu+TRYgna7auGDAEY4O6UrxAWPTIgX0uNjvP8GrqzpB1KKPN?=
 =?us-ascii?Q?OgrN0KTqgRfQe1oCtE+YzPG9zrQNJxc+9welyqEZVSI9MRBt0OSOrbR6KZCI?=
 =?us-ascii?Q?DRQequsiBQRBsniVOY2VKWWVW9oR7gcF2AZP3oFG3Fg5QfGJ6/js6Z4YQsuq?=
 =?us-ascii?Q?FeDe+vZY8aM8xPiKUFzOuIOY6RR9bDbDaQz2gQes8ewk2wQKBHYNEPuIlZ+p?=
 =?us-ascii?Q?kJYCqPHbR4oaZpBNcnkeOpx7BUGYrkcu27xZc6conEDx8w9/cqBpDbhyquT7?=
 =?us-ascii?Q?UFASnv0mzMtA7H4dNM5UeFRzDHLHQuh1hVQwsBGsrTg3Hd4KgKx+gU+UWpiW?=
 =?us-ascii?Q?3iQdjUY6tD334ndGSkW/mEVbSMDyKEvnywqaDd4NppyubRdEe27MmABfNJuq?=
 =?us-ascii?Q?hdGAa4aAwfeYZmkFX6MLRcZil+dbjfG4pcnfu0Id0O4XcUpgeXsq8dhj31fO?=
 =?us-ascii?Q?EhrBlmFN4lJ0Xbdji9iSzKlkuKp3juAa9G0L444aJ1lYoPAep2eqcEKOI9bN?=
 =?us-ascii?Q?OTm5IwX8jL3R9AKe+MbZSEOJdHb5wbLRWkSAwNgOW8/fceIs4GJXoO5f6cu3?=
 =?us-ascii?Q?NwRSw7cV61Z8RF4iLyuCNSCDb8E0R2o=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14baed55-00d4-4608-9fa8-08df3d8ff692
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB7144.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2026 12:01:03.7584 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bIEWWZEVqoH2q7N8QIpRejrIBM1jIHImoJCwIKbZljWatXxMOZXzdU08DK4keU8EcDnHXCH4LLeeFX1YaOfuGfjkUOpM/zfvMyGggFKtSUQ=
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

The e500mc and e5500 manuals specify pseudo-LRU replacement, cache
locking and parity detection for both L1 caches. The reset values
describe the block size, associativity and capacity, but leave
CREPL/ICREPL, CLA/ICLA and CPA/ICPA clear.

Set those fields to their documented values so both L1CFG0 and
L1CFG1 reset to 0x00B83820, including the shared eight-way, 32 KiB
cache geometry.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---
Reference:
- E500MCRM (Rev.3), section 2.14.4 and 2.14.5
  https://www.nxp.com/docs/en/reference-manual/E500MCRM.pdf
- E5500RM (Rev.4), section 2.14.4 and 2.14.5
  https://www.nxp.com/webapp/Download?colCode=E5500RM

(no changes since v1)

 target/ppc/cpu_init.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 2de2684c69..5549728ec2 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -2886,8 +2886,9 @@ static void init_proc_e500(CPUPPCState *env, int version)
     case fsl_e5500:
         env->dcache_line_size = 64;
         env->icache_line_size = 64;
-        l1cfg0 |= 0x00800000; /* 64 byte cache block size */
-        l1cfg1 |= 0x00800000; /* 64 byte cache block size */
+        /* 64 byte blocks, pseudo-LRU replacement, cache locking and parity */
+        l1cfg0 |= 0x00B80000;
+        l1cfg1 |= 0x00B80000;
         break;
     case fsl_e6500:
         env->dcache_line_size = 32;
-- 
2.53.0


