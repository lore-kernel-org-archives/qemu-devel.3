Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C18606A331
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 15:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=vZh+lRQu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOd8V-0001b0-D8; Wed, 04 Nov 2026 10:42:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOd8S-0001Vu-1F; Wed, 04 Nov 2026 10:42:48 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOd8Q-0001DQ-J0; Wed, 04 Nov 2026 10:42:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OuQC/PXJc9Xs9qChhAj3iDEikwK/cCx5SL5W/HaGsM2+EoAnJpu1CiJAxc0p/KuTp+mYm9yY6147ig22qA/ybhK0j3Gjf+UiqEfYxO4Q8MSq5KTXO/7votqWEBpMAlQYNMfSxaE2mxjRy5is42x+0E4tLSdvbl+NuTsn+0t59Zp6/mmbCO3ovAuj2/IgF3vJb9wE3Yo/mIKioWs3WOEtiA9Ch6It9BcnoNeKtVCuLoAXR26sDg+ROl/+Sh9EWgP8w31CGQlSsN8mJPcfUnnwXLFq4zqPxzwdroXjN+BNdHsGFR/F567vy89OZ+qs9oswS5Eu/SCiuxT7Uz13q0oNiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gTMcvvD8fzkqfq2E3mMzzBgSDBbcZIebxHvtFywOu9U=;
 b=h43cNGSwbHMGB3fBqRMlnyKlWtzTePS2ag2uAP+sE/zVzutclQPQPQGrwLR9Y9ac3d3GE8BBTp1JrTLomTq7BdDUEdCiPVoSgbvLQTFJjTY5vs/M4X25kfgUBaJjl43mqslxm5GNcGcjzpdyOss1IlcWRAxMa2EDrEfuOnH5GqJdN0gKCkSb3r4VIym0b3TVMv2oR7ZAObArFE3bPHTmqLOLFr+evRomWmBNMdvcf6sGCTgqScBAHqUvivJBqBXoeKJ4zJIov6RSk2pZ3havM/p1m0ElaN8HHVXGEAHqNInVL6151aGc6DMNeG7ktepO329JyUe0OaTzji+CaFRwQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTMcvvD8fzkqfq2E3mMzzBgSDBbcZIebxHvtFywOu9U=;
 b=vZh+lRQuh18f5EKrxm7m+WPdQ4vj1njEkf7MFv6xGbYUMbvGjK3T1inPrVyC434Z7iu1gjBluRfpumkx0+Yq3x0XwNDlgyi238AnQL+8BpHSuSANWj7ZwhdkB3BPj3ncjerF6CYGoIIv9F9PvJdyx97PIaG8stHG0nFSqDJQ8ZwoPBFWA0R7d4WeWO35tL4A+bsp/V2bY4AIbiLXK8BK24hSSuEayF5tBRZ/FjVvkfwZlKfnC6HV8ffsDz39BISkncyRMxs0COsL3LvwKauTZTf9dQz2wS5oPCGEiPZKhTOysv8lTiy0OXre06DMQjEV1y6EJpu574CVDkIvOi/lGA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com (2603:1096:405:2c::12)
 by SEYPR02MB9159.apcprd02.prod.outlook.com (2603:1096:101:302::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 15:42:36 +0000
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10]) by TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 15:42:36 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Chao Liu <chao.liu@processmission.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 qemu-riscv@nongnu.org
Subject: [PATCH v5 06/26] hw/riscv: sifive_u: Correct the L2LIM maximum mapped
 size
Date: Wed,  4 Nov 2026 23:41:33 +0800
Message-ID: <20261104154207.641511-7-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104154207.641511-1-bin.meng@processmission.com>
References: <20261104154207.641511-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0056.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36b::16) To TYZPR02MB7121.apcprd02.prod.outlook.com
 (2603:1096:405:2c::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR02MB7121:EE_|SEYPR02MB9159:EE_
X-MS-Office365-Filtering-Correlation-Id: 762d46ef-34c5-434a-9f04-08df3a8a3fff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|56012099006|261021123027099003|261021121427099003|261102123227099003|261026121527099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: R/nYrkUMahYwC6dmVOztkfntA8UHgC1uohU05qJUilZtDDaC5YHBzqOnfi7BKCi0iTmNjNp/pyYX7EJjzPvM3Lem3/EkxmO+edBI/5SYD0QNQt6knchqn/WwYWfqLjIl9hKi+wuQ+vsuFy1AQ2VM3Rvix/ATv0m2sEeScGD1nUn10ElMR0mKWvDr2WJjEgTkSlfP2a9i0PvDb/FyoFPkyrsJz2qn3Pk0cAgwLjcniGaToPFHF700+rx+EljzQglUUbTsTNnLxHKh/5Q2FAJyiaNORfR3Sjo+r8KZsfsTTZjOwKJnX6QUQDrEjsW4t7/yocHrYxUb0b/l6Qg1gy8/aSmUBmqSeCwTJjt3ljt0xIDjsu88opVw6f2Cy23m2KnuoQf1TKP4RMmOz3ypLKGh3I/tT4ssWLXlVDTFsaHevMVmrJL5yQOZGr2GsjDDTQeKaKLjN0VqB5pthVa5mIGB13cvdDJr3Bc5zGjIDdYhbqN91ct0ubJ5bFAiCLuc5v3xeGNINosfyaTRoSUvy+DW3KwDT0dHDknFoOb5mcdjT2bGrE+BiWsKZeQeDTNlVOsRO0bjrX7uvSpryPbbdedXs6RpkGbMxcN97XrNfC/zyYOiiWOtXQPL+N+tIey98k5Kb/yvEaG/Ky6Izo8RWlRwmKLHRhCMTohiwf3ofZcIG54=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR02MB7121.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(56012099006)(261021123027099003)(261021121427099003)(261102123227099003)(261026121527099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5zovxNPr0QjyiNzKOIDDmurAN/d+5C+Vpt0YwdUXqRtpNALXqQMsSjBf5R1q?=
 =?us-ascii?Q?+OAUw8uAPB+aZ3e/sfmuVQExAv6tcETly3w1qVRiZr3fpc024wEGOb0HUrqZ?=
 =?us-ascii?Q?Qn5yAB0s2RP02MW6FuH7r4+XSem4lwjXgW+Iod+b7C1Q12eliyiS7YjHAd+3?=
 =?us-ascii?Q?ysMJZjkwHSD386XGY3Jv7ByS47IBT6OpqDCEJP/5ZTUxbK5PQPa6SldHae5E?=
 =?us-ascii?Q?fmKYPOEWuSEJv5WZVPJXuRupzDWA5lghdqdfeO5ZxjFNLjSuqNShRCbWcOd1?=
 =?us-ascii?Q?1jA28npEtimP493tCqmLKzrFix7J7ZpnCCdFETT03c+BUa/XBPuXIN/HTSVy?=
 =?us-ascii?Q?JWCe0sc4bmnVTuLo0GyKz7GGcWMoF3RhGLyIG33WaiY2rWIs3Ml7ziDo6fmt?=
 =?us-ascii?Q?CUTJG1HCwvGPEnf2YUxmYaHgET4peBhJUZptyGrWcG9Bn3PkiwyZfotRFUEY?=
 =?us-ascii?Q?rLS54H7lZXuS6vFo9ZCAjjK0RRi4D3uwGBBl950w1psF2AXDdA6RxkvDj5CU?=
 =?us-ascii?Q?42uJUQDv4ojLWw5CQ8F/3xIsK5wvqpa8h6dEXy5T+KQ72GzsOiN4RLndX+UT?=
 =?us-ascii?Q?ek4y0BmO1/soK3QHa2tMjm3v4STihmR+Uldgq4aHochyRxrLX3nXCaxtj5Jh?=
 =?us-ascii?Q?g1MAWPeQYZKlQguFkzhdD65mtV+9EQFZUa7mj73N8T+nQ8OE15Np7wxoV/ld?=
 =?us-ascii?Q?vKXO9A0ULlwVEeChNj2OUL4Si2zCrCzUevHXomx6uQaKUyeHGlSArCVvOhKd?=
 =?us-ascii?Q?l/PUj7WLcGIkB+ZbAnhp2CTce4V7aL8koacMnEpEgw1YiL/CLi+xhtNCdBYx?=
 =?us-ascii?Q?FGvrLuQLsCVN+nn8VkJU2igyILyrJraBJTMYh1Zpkn5+0U8GIa7lDmRV9FAp?=
 =?us-ascii?Q?GNpivK1B8OG4/GP/IugD4F/OZVt23bqPDzfHMi1APUOodnyjfdqyx+jkptio?=
 =?us-ascii?Q?HKs4xJD6BhZyk8cAVZ3MU/X5TTrFpVk4iXNk1JNm7kuiVhthWuvvlhRqs6Rs?=
 =?us-ascii?Q?snNWUK36DQYyJR+KvKmuhmFBDFDoQPVtJKWFeW4MWyD3TeZ02qcazLWmNc6u?=
 =?us-ascii?Q?8AkYBX9EVuOQERkimSajYoIZVkI9sDpJ7iwTMLw7NA1QddQJx1ldHDuoHnKC?=
 =?us-ascii?Q?FkGHdOmZ3xXe2L/zZIysUpRKJG0yyKOycpmaAjmtfkUjkzB13OhbEB681ZP8?=
 =?us-ascii?Q?G3hw7Nkpr8GBSTlaf6Gv3hv2OVal2XAuqheSZDlCKN0zmZgZxCbi3nHIchfa?=
 =?us-ascii?Q?cCrxoFmOLjNzIJPpPB453b9gyl9eXr6bKzoLzcvMmzVEKg0MtKXdXqh+Axoh?=
 =?us-ascii?Q?1532TngKXaZDPluzQwksyk79xFQN0lCR3+KKXv2+vCZoDesQ+N4N5RehUiAl?=
 =?us-ascii?Q?Jx6Z5FZ/gDuGeiPma0tcsIG701q5FpHXfPDSvT8fSuIsRIgKj8HlAHexaP2r?=
 =?us-ascii?Q?0s8w9gCDfUI5sRyEiSkSCQOy0Uml3Asu1xHg5AAsr1Cf/kmtKeOGF3RWv+xO?=
 =?us-ascii?Q?9BhA+mn9TW2WTwmJNgixS8os8wlC9DzbBYJJ0ufVFl9IjWgJoWKQedYrH2It?=
 =?us-ascii?Q?F0D6PIIBH1en1vKRom3DgvFwtyR2sAx8jOB2UgibJC8ib9GLLHfa1I4tbIj3?=
 =?us-ascii?Q?EFwOMOTjfVqI8bFIS+tOKA/fiT+Jg6oxH6jAIR06JLKy20doKyVQ1NXgq6d1?=
 =?us-ascii?Q?UkHsYLZ+t3qJJ4HK2RhxLFA3FTt3MQ9ZBk+zgm+ZwzMT64sva3L9UW4JhR4Z?=
 =?us-ascii?Q?EMkulliAGtzkmAzdjS2ycQWuKB0DRnI=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 762d46ef-34c5-434a-9f04-08df3a8a3fff
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7121.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 15:42:36.4578 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9wHs6TVEc65bCMUPlaPN+qnnx29p8IfTivn6DMa58VCnWz0Seg2bxSMkhiLDlh0j0czg+qHSxW15/CYGauI6A2pTz1/5vme0lmxZPUfbMvA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB9159
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

FU540 SoC has a 2MiB L2 cache, so the maximum mapped size of
L2LIM should be set to 2MiB too.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Tested-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

---

(no changes since v3)

Changes in v3:
- New

 hw/riscv/sifive_u.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index b7d5e7b4da..1ac0d1bbd9 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -72,7 +72,7 @@ static const MemMapEntry sifive_u_memmap[] = {
     [SIFIVE_U_DEV_CLINT] =    {  0x2000000,    0x10000 },
     [SIFIVE_U_DEV_L2CC] =     {  0x2010000,     0x1000 },
     [SIFIVE_U_DEV_PDMA] =     {  0x3000000,   0x100000 },
-    [SIFIVE_U_DEV_L2LIM] =    {  0x8000000,  0x2000000 },
+    [SIFIVE_U_DEV_L2LIM] =    {  0x8000000,   0x200000 },
     [SIFIVE_U_DEV_PLIC] =     {  0xc000000,  0x4000000 },
     [SIFIVE_U_DEV_PRCI] =     { 0x10000000,     0x1000 },
     [SIFIVE_U_DEV_UART0] =    { 0x10010000,     0x1000 },
-- 
2.53.0


