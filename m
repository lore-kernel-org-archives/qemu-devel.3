Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4CA606A31C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 12:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=kka7Mwls
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQ1bA-0007Et-Nd; Sun, 08 Nov 2026 07:02:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xQ1aQ-0006jK-1n; Sun, 08 Nov 2026 07:01:32 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xQ1aN-0000Wc-IY; Sun, 08 Nov 2026 07:01:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hjgsYOZlFVs07VVxLAY/Z5LI3lPI9KFkf/BDijAnea2dr+KaM6Yt1/i+crp8ylpURyYFvmpVs+eu2J2jWwuydIT6p9VergrQBKPjCDiyweu7TgbisxpSNGBax0BILpEfbSCRXAv9bH3MIuvTCskPfGp8XQ65RTZ7++12YzmO4QCUl0O1tHvWKZ/2bVBUQLr2Gf+/wuLUOFGIn0Ca2cQzaCdG0SGZoM+3T/sL7v76jqL/4+dprEjOV3cUUgtePrgKhk+RdjB9VYEAs3XjCzRM7X+WDvg4pclsps3ZOSYUUFSeB1VJmWYxaI9gcLasIzE1jSBPwpTsF3yn/htFtmVUAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jlsFxHLDgTbv8vU+IN04xkdODYfueYPWiMk8QKA3zYw=;
 b=Esen94wi74jfNDHm46AufoVovLBK26hx/qOh8N1jYU9OhcJvV+OKOlqU5Usw8rmFtlDAF3qC/sZ/ek8jisLcuNH1bq2QpRWfg52gCeUoiWLjzFlLOgoZZELsHcNukwGiEE1IM7oykPJ0XRSxeH++3THIYUUMly1oVayXpGdcUm75THogmuyV06RlQ0EPnhUf9p9QE7qvxfB0fxddv1R5JRNxLx0Tw7Zwy49XDLAKZ+PaNQTBcRIvguivQ+YIToichcXrXqQLDJ6jPue28hcE+rtJpxhodBkbB6DmGd/UPap6SEXV6OPIzfXDBluZ47ZUxDzsuv9gFYfej1/iNex4FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlsFxHLDgTbv8vU+IN04xkdODYfueYPWiMk8QKA3zYw=;
 b=kka7Mwls6bXRpHkCjANSprW1fA6C7Ub/lKwng2sdZHYClrzXLSyaBlXp+dtenlbKRuYoDx15uUV6vFpDi5IpVXVaPSKAdB0CWYFi7jTimHpSqQG5NXEd6WOS20dJ3ygoTyKpdC9UYP6hHodHqhHhso3w6RrsU/wfiLxSVE7y5f0MFm3k4s1tg8FbAxH16nOp7jUw98osYS2wU2eUcKBnoKsmAxPQ3vhhrANGTqYRHY7NIFrcW/a//eW7mBFNTcw14r+1kCMt+jS1aPJSjnkD95zoDX32DvzdsEjUfzkLSQu5d085Y6NNSERABQ/qEpFrCA0eAzKFKnzFrqXbSaWjuQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB7144.apcprd02.prod.outlook.com (2603:1096:820:116::10)
 by KUZPR02MB9138.apcprd02.prod.outlook.com (2603:1096:d10:61::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Sun, 8 Nov
 2026 12:01:06 +0000
Received: from KL1PR02MB7144.apcprd02.prod.outlook.com
 ([fe80::18f7:ed72:e33:ea5c]) by KL1PR02MB7144.apcprd02.prod.outlook.com
 ([fe80::18f7:ed72:e33:ea5c%6]) with mapi id 15.21.0592.010; Sun, 8 Nov 2026
 12:01:06 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-stable@nongnu.org, Chinmay Rath <rathc@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: [PATCH v3 05/23] target/ppc: Correct cache line size for e6500
Date: Sun,  8 Nov 2026 20:00:04 +0800
Message-ID: <20261108120034.1755008-6-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: a012d431-a8a3-49dc-5535-08df3d8ff845
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|6133799003|10067099003|3023799007|261102123227099003|261022075727099003|56012099006|261021123027099003|261021121427099003|261026121527099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: pIYJzeUfXsC62ts40XiZMGTViNRPddZ7/cvyRJVHShEqQPP/ALRAvU4o6hSx7QYJJKZljLxquJTAQlQpNZ6ql2qEnxb9v4k0CzCBnBzBAjK7B/czjJUzfAHTmu8G5b6iGtk3G4Mz/CTUPg44PVR48tVDTo3G4SZdoOndAcL6vcUK5GL4x1TJX0h4b0BuHSA1ke1hC+Wx6BoBp7tXxUCbzy8NtJsrz5Rxj0bW8ahUVid8bWTMLO/LRxTAUALUpNKk+7UfICbBY2ICLsFSt3SxjbIKKf+Sx13Y5X/XloOzMPLIvFSEGbeWRvVXhp89hWEvNeh10GBWKdIs1PfcAd5SuPWYviTKAGRGELqA+GGoya3D2s7DyYL6VzJUOLoUpKa7cKyJXLSSIIoImJEIiGbIMJwENQLWEsX+Ir1Aus+sTPHUPC1+eP1gLkplNThf0mjWP8WoQp7XwlBPO0dkHxM08jOpIb9y2DRTecY7o6RVjYxuuObcHwyLMwQlzGzyLGNJq+ricEhPvtpllumFHD51C5Vu5BIPSj4f70EOYrBBAkAGpION304W6ZnYfWI4+Mo6f3OjWxbtgtC6sVetDagX19bDWOF2jyklWkFpiZKmJCBRuSxL1Rtf0CAxx4N7P/stqh0Bon+gYExbzUOefE9ezxhS6Ar88rSUg/tU6iorcM8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB7144.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(6133799003)(10067099003)(3023799007)(261102123227099003)(261022075727099003)(56012099006)(261021123027099003)(261021121427099003)(261026121527099003)(261009223027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sdZWH59oHN6nknI5M5UMuKc2oqVEZkMwIJ0wR47O9dQz0J7l+LWBUgpH6WMf?=
 =?us-ascii?Q?ZhmwUiORDq5W0jG9wEBMmHZmaxKYew6tEv7GTwu14NXLtzcl50PBLCQRoYpA?=
 =?us-ascii?Q?Tk4Ji+tg4hzs+TOlIHP3rtLg/lqXog8KhH03wYub9Wv0Roua4qkqJmWaP9i3?=
 =?us-ascii?Q?n66XYBWURMynfqm0UFIiPTOdB0v7peAP6UOrKnyOLueMvoFa03ky4ttN6nDT?=
 =?us-ascii?Q?3oahUTkL1fNUFxn5IAp5XJFiVvdivCGFqHkwEJ4M+JFmMVxk9Enll/D2CUQA?=
 =?us-ascii?Q?ofDxBrRTdCtWpajDpLCizY70HNmBEvsUpjSK20KPeN20N/JCqpEn+WPpYfOx?=
 =?us-ascii?Q?a04zPAsfWi0NzKD4Tm/8bfq45EBkF+zCHHq9E17/DorL42C+48gkpTCAYwqZ?=
 =?us-ascii?Q?oWjfiWDHnNB4J6YB+IxBlEbkB0Ik7MGB7yBvhKd0MdcsoFtgzgLG0NCIKccB?=
 =?us-ascii?Q?h19QLW0hH7fY6WmRidGpWJtJRTodghJKQF67JNfNj3Ma50Vu8ErrIOpfSSvU?=
 =?us-ascii?Q?wG+yuB166mjajTHaGFcsTij6ggzn27oOequBPk16qEBJe5/vvN7bfNIA+nyc?=
 =?us-ascii?Q?/PJ+OUBzkfsKvrcLKm1h4Q/Qc2fypMTlVSPpERqfEQQiQC9yTPA0JK4tkJFe?=
 =?us-ascii?Q?5DcpB3jy7F+lo9TwGNvk2VHtUEQx/EYzlzXHXZUsOAGGXbhENmM2Wz0qUqLL?=
 =?us-ascii?Q?AMgLi9UJmJ9Wc3mIoQJISA/hkedhDJuLdHsbjmZaPxrJfYrSuA22cT1EMjTb?=
 =?us-ascii?Q?0AfNGpvx+k+usV5DUtiznqOwKsPeX/UJPFFN0ht/z72t4vWFov1p5Kljljhf?=
 =?us-ascii?Q?p479s4q9qfKH+kGY76f7R6HBU61bPrM62yIvCqVXck2p2dczb4w/kK8H5S9y?=
 =?us-ascii?Q?nIpq85T9fycsLm4Ygp98W3AFj4ECe1ccPjgLloUk2LgITg0jMk4NNHt0xJGd?=
 =?us-ascii?Q?mKg5JMdzhFQuVlGo6lByio1m3gIuquvmtlFwvl0ZGvXsCbW1+FZvkSvXcXD/?=
 =?us-ascii?Q?osv7MqEE20rHmknouRgzWbAFfgH5smKJhMJIqjEvsWqQg4t0bjzezXZkcJ+j?=
 =?us-ascii?Q?kk/wvxvXrZoZ2JwZPdy6bB4I3wUUQ8eIvXZjP60nfnSWY+ULyq6bmi91V3+D?=
 =?us-ascii?Q?lDRSgbQBZFu72zj6svyfNJvSWSY4MCP8+tUYkF52Zdyln4FBiAJAospX9yc7?=
 =?us-ascii?Q?j4smdKNqFB9NZisBDiUYWdRt8rQnNjyH0ju+JPvcWHDwy4EF0K2Hg56c0Asp?=
 =?us-ascii?Q?I0P7aBq0R9TjBS8JVOcUsRLiJN02U4oc49LBfP3niuZpOA4yGgDPusW9g6an?=
 =?us-ascii?Q?TS9tx7Q3bo5tkCJC7yDBtthQpwHpBi+4worAsiYV/pWPT+ff11KGT9vqjhsS?=
 =?us-ascii?Q?YxTjy7BdcWle3dZWMQZfIWBz3UzHoy7pd2OVRqSQ5GouWenus0Bx8wjisSeP?=
 =?us-ascii?Q?dbVpBetWX4lRVyFXJT3mgU+DjnMv2K6mUAvheIXMhS34+TGZ9fFY7mmAwhLc?=
 =?us-ascii?Q?ldzTAImu5a7wJ2HEroT+bsrzD3WoDxpcIQgNMHe9J2qbFoo3ZwmpcSvz7yGO?=
 =?us-ascii?Q?+Ja7FwBQOWNopjXvaubtL0V+a7196hLTYJDlmWV01qs5cHsbLOqgfkqM2MNZ?=
 =?us-ascii?Q?hxSziwtpNVk5I10nWb33bl2jF0XdCGjrZ4cJQzWm2/p4q+/ybl50Utl0x4lh?=
 =?us-ascii?Q?NRwmvwXdIpB4jev1d0l47lYcnYvuDE1Sjy5ZipM2qHRW1NsPwTyuW82dUuTx?=
 =?us-ascii?Q?felLm18VJOQzBqhtSGeY7sRe4a7166I=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a012d431-a8a3-49dc-5535-08df3d8ff845
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB7144.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2026 12:01:06.6754 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5dvQvQU+xtVpl+dQofveDdG7Hvfy8uvBF6Tx0eivBw8bkFlmtqcl41rks4ao6/F8Phy8g4BkzbaCWHtXYqNS1uH2yn9UvTFHxsRRLHP00nM=
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

The e6500 L1 instruction and data caches use 64-byte cache lines.
The cache configuration registers already describe this geometry,
but the translator used 32-byte lines for cache operations.

Match the line sizes to the hardware so that guest cache management
and dcbz agree with the reported configuration.

Fixes: 54a50dae93fa ("ppc64: introduce e6500")
Cc: qemu-stable@nongnu.org
Signed-off-by: Bin Meng <bin.meng@processmission.com>

---
Reference: E6500RM (Rev.0), section 2.11.4 and 2.11.5
https://www.nxp.com/docs/en/reference-manual/E6500RM.pdf

(no changes since v1)

 target/ppc/cpu_init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 5549728ec2..e2182720a3 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -2891,8 +2891,8 @@ static void init_proc_e500(CPUPPCState *env, int version)
         l1cfg1 |= 0x00B80000;
         break;
     case fsl_e6500:
-        env->dcache_line_size = 32;
-        env->icache_line_size = 32;
+        env->dcache_line_size = 64;
+        env->icache_line_size = 64;
         l1cfg0 |= 0x0F83820;
         l1cfg1 |= 0x0B83820;
         break;
-- 
2.53.0


