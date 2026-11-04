Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60410606A32D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 17:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=mW2r4V74
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOesR-00037c-Ne; Wed, 04 Nov 2026 12:34:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOesD-00035i-WC; Wed, 04 Nov 2026 12:34:13 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOes9-0006Dv-1P; Wed, 04 Nov 2026 12:34:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ifsjy7Y8AsQ7C4Y9Qnt/6Se3rwj1xRsTujBFq7KVcfIR3+SmAE074SwXYhCX+OnSNbjzme3Sde4Z8cKQ+Ph9t4bvcU2cNQzQqwUvEKYvwNQAaMNvrr9sGo9doBuLIL3lUPQ6/YDkdjY2aVhZeXNuE9Y83f1ohd1qHMd+l8g6vfPZNZsfzSsAI1OW+9cvhd4jDg8ZLAq+sPeYcU7fAb+i6QZ9dzkF1xzR87N0qHHddHbk2+gP7y3B/7gzjRx+j/Pb2+8feAjEfIynp8ExUQn/gTFG9ybbsaf7b+AnBvbXvR2drxjOfMfXgY3AYBz2GqnFzt8RGmkGD6jOXuvn8JCkBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xS3y4nu036laE/mntVqLocq41rNXUwkZnskHWVcxf6Q=;
 b=wdHtrKzu+LIMwRuml1hbbDOkp4jpJsVJ27zwZGrO1B2RmEGfdU0c5cVv3Ou2zAKtI+1mu/Zzf/hKW4Ug4E2xQyZhVJyvhQB0nS65fwn+Otj4UEVSrCGkN3EOEXfwkS2yFLjp3wEmR9m8SI5H1lEZkg0K9g5w8+ByZD66Tw6c7i7/QwYMT6Y/1Zg8h/72r6BHhNGcC2EX4psWC8MrYeVjnKHKDOk4k7fnp5A9NGaElfzO++FtIJX6GKaRLIhVLWUxq1R5nK+2Q+Qm2bO84dI1orgP8O0vjZLD7SL1/IVfGi0pZDvXcVZggHkJtk5cLFMFSzlqTN9yFdZMuMd79pfEDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xS3y4nu036laE/mntVqLocq41rNXUwkZnskHWVcxf6Q=;
 b=mW2r4V74Vv7UOVLXXS2ZVDQMLXmzXqpXiTz2ZU2DLJLwD4CpF+0Gjmr6bjjlIw0uPugtCsZGdXWSmo9FRTtQuKmNazWjzLBxPv+++DHAJ3aMipT0bgF2aHI1whslWjDyyII+YODX+YnxIA0BnOYWQFqamLX01rVqeFY418WjYGtqOIa7YN68BUvyBn1cyrCpyhQnV1b2gTGP46tE2JzIzQSjVDZA15Vb6HfL1wVzSGS3MegV6Izh3fuEQSVRSQlDAKDxN9HVydJd5vALzsdZeoAVekubt6Pux1mSCpaOnIrLDrFsx01WhOWjt/fI+AjF27wStpv6vxBxWKHk9EaOOA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com (2603:1096:405:2c::12)
 by KUXPR02MB8801.apcprd02.prod.outlook.com (2603:1096:d10:4c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 17:33:53 +0000
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10]) by TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 17:33:53 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-stable@nongnu.org, Chinmay Rath <rathc@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: [PATCH v2 04/17] target/ppc: Correct cache line size for e6500
Date: Thu,  5 Nov 2026 01:33:07 +0800
Message-ID: <20261104173329.706635-5-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: a3a6fa6f-5c3b-4313-9a64-08df3a99cb8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|6133799003|10067099003|18002099003|22082099003|3023799007|56012099006|261026121527099003|261022075727099003|261021123027099003|261021121427099003|261009223027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: iOWERdxOxcPGpU41PFXcjZ2eyM9EcHhIdXN4mVSChizutE8XLIrIXf3VNf1OSBtX+V3+I4FkTj9DNSbsqYR2b65LdQTfzvlPmnTOOhayRYm38HKlhI9rDukVl8sZHj3db7KiW8vB/y0OLX5UuimsSfG6wfEdtKn7/ObplnyPgvFVfM8wpzcwStlN89DB3MTUF3aT+CAgbDEf+V8IkwvhIB5aQKEukqG4ph3letCe3Dd6ZYSAvSU0VijoeCS9fUOHq2TY23bexlFVV8DvTWVuk/uFln1Yv+PzW+5+G4RqbjToqfvTJcf7qW+m+MewF7MvW0akXZBDiA9oVuVo4b6Qn+HIEgPB0NRGHAfgTi8dKohvJhcTJbTaQ7D5k45MzOO2nN1oE2wojdODxiU7X2ySXiRGE9NuwwfuwArru7aL1KiVunQ5LpUswrAOHozz6VEYz/Qo+ktDYxuLSQbJSIhXwriMKJk/ZVN5LGQhxgD/r0PZuM25/XoTk5hErEYGS40m53MhKojNj+1pgV9N8ab5ggPMEZV6eO+oYMcOApJVAwvZuVxLFaz+S5ywCs753X8gn+JNSFRaOFb4JpJTBnIS2GcXzD2BsRcrHMCp5/kiL5M+zEvBZGdImP51j/d6d7GVXM35Rk+VYizm5F8wo5MapgNGuOTzyDBndS0wJWG45Tc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR02MB7121.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(6133799003)(10067099003)(18002099003)(22082099003)(3023799007)(56012099006)(261026121527099003)(261022075727099003)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3MFNd29XYJUovYVy9Jc37vRrjww7mMAcFTul6m8QexR0/J59qn21srKtEtau?=
 =?us-ascii?Q?um4vrmND4cNXHXDR+mbJdJKrFXsA7rtk2a+mBZP6dqyU7AAg9Mz17rz8Svx+?=
 =?us-ascii?Q?wLFSub/TRl2Sorwgj8Htl5IQNUNsexlB2OI1Vrbz5YwoMdr4vQJ7zVd0ePE5?=
 =?us-ascii?Q?RES6ik9k3Z+3xKWaXtDuUUl9AdM8najoJ15p9UMubVc7dctaka6CCsyRyC89?=
 =?us-ascii?Q?QpqIwxRXb2o/msxDVPHH8LX9JpI08zRyH78NZLpHJ+482Ec3ynqI337xZZen?=
 =?us-ascii?Q?WJoGR+9eRqU052fl7+XaMC86Mk/z253aCY4Dh0SC8heXgS4/483XMLakQl5K?=
 =?us-ascii?Q?zhgnvlqYDgYOl22eKsty93znR5NEYxquh4e9a5h7N33edK3k72NH3OOQjF+1?=
 =?us-ascii?Q?hWb+ychsgyZzBLV3ugAAWQ4fRexejMCxpyVIbwNe57CJfoI+onMKOc1UuWxE?=
 =?us-ascii?Q?rxiAF+AI1iHEbESnn/KreZub/pQEBRtNak0O0uGGGvrw2zFPdlrKNn/ITeCV?=
 =?us-ascii?Q?ZnExP/IcmSt2sm34MVSPQM8C+SjSboIW17qKNaB4G2UDkoCvbnAXxbr5BYuN?=
 =?us-ascii?Q?ss5HIxjRn1VJRPi3T3oYjHUiumVT0d1OA2XJhVk4/+sosZDhYx3vLfhuybsc?=
 =?us-ascii?Q?JB/1MDriWS6gQDWIetHkKiHrOXJhXx8b/2BVOmBMv11gXcOq/ZJNCLlfXiX4?=
 =?us-ascii?Q?Dec13ySIpRBkV2OcZC7XWjTAqVPTPBoDsoiw1ENuH5t46lQY+dwEH+Xxm7Vs?=
 =?us-ascii?Q?Bq8tYbVhiDORKiZfLl2zmnMqoNlu9+ueYhOUH1bLMKemEC8tFaWfSiD1lM/E?=
 =?us-ascii?Q?UjEuvMF4P6oMiRCYPtxK9npIrNY0Dz+lGl3Id2UOyd0sJ5YpHqAuQDLR4PPS?=
 =?us-ascii?Q?UVasg9kK2NRHX+TbMC5l7F5IaWpHTKuq5u0026Swi9tB0xLbYAa6T9qYorLr?=
 =?us-ascii?Q?HuTkqtWUJ2J6G5Otmghfe3FU0q0bM239ouC4qoMo6GFkTb8dsjBBLl0QE068?=
 =?us-ascii?Q?vSnb5hXvMpBX84V3IdVbTBBayuIxYm9UjxuL04eHaCCCFrOAeVJnV9BP02sn?=
 =?us-ascii?Q?yT49yveFSUUTn5MrKLfR29wr4SNvncx/zfHhmmm9+bJEb+cpqHvZf0+mFshn?=
 =?us-ascii?Q?qCrAYWDSQFNo82dH5dA7Yo4uNZU+3DBZt2cCj+OhnkP5O6dG6r457aapuKl5?=
 =?us-ascii?Q?71fAnJ8D7dMyW5IkNS+lIR968m61cfwTXskD2F/SBlpYVwcapQHHdhUPCG5O?=
 =?us-ascii?Q?UHNUSZvI+ebrbI3853Q9DBzl0P90BKw3r+QDpaf4tmqSAUo/T0zRB60LY3TP?=
 =?us-ascii?Q?064wkOJcl9oZWSC05dpwSwwqgHJD9rKmw6e1by7Flvs4gyX8paQv8MCyXzzA?=
 =?us-ascii?Q?C7VKWltY2gnKqFuDVx9GKzgVPa188asaMktHJY7n/R3WC6oIIO3BcZ3GBIGz?=
 =?us-ascii?Q?YJOGHPtKXl15zOjiofRPpxDMO7kUVgfm3ualM8cH2A7pMwU2SPhHQ9Oondnp?=
 =?us-ascii?Q?YYVEDI+yGlJR5ITNL+m7rRnz7xrpBONX8j0/UWxqL1H41ypGHK85+T4x6znm?=
 =?us-ascii?Q?tWDeJpCXdHeVhOD19yWWS7AlLPJeHE6xAvHfiJvrMMpRvXNlFdIOTOmt8hJW?=
 =?us-ascii?Q?+R4kYQ3TQv4vX5q+dNypa8NzuE0S0eA5egeX9sgDMc9IGWTqSCrdBw5cQkyF?=
 =?us-ascii?Q?KdKvgW/3Vrm5MRHIiwKDUov2XN0mIlYZqdFY4/Za5OW38pwArshElkZDykkZ?=
 =?us-ascii?Q?a+mIxh0yQ2r0hL0cJ+rPDUgZvLFtS3o=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3a6fa6f-5c3b-4313-9a64-08df3a99cb8e
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7121.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 17:33:53.0503 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QfOs6bfFKORUFS+lrlZUap0A4rIFW/ohbXpAe67hfAVrMIWZ9q4UCLuw9r1pWSwRzaiKNWI1o6Fi5xV08nGHqN8M+l2F+dGG2JnWFC4iDEk=
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

The e6500 L1 instruction and data caches use 64-byte cache lines.
The cache configuration registers already describe this geometry,
but the translator used 32-byte lines for cache operations.

Match the line sizes to the hardware so that guest cache management
and dcbz agree with the reported configuration.

Reference: E6500RM (Rev.0), section 2.11.4 and 2.11.5
https://www.nxp.com/docs/en/reference-manual/E6500RM.pdf

Fixes: 54a50dae93fa ("ppc64: introduce e6500")
Cc: qemu-stable@nongnu.org
Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

(no changes since v1)

 target/ppc/cpu_init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 2de2684c69..3be3e44aad 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -2890,8 +2890,8 @@ static void init_proc_e500(CPUPPCState *env, int version)
         l1cfg1 |= 0x00800000; /* 64 byte cache block size */
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


