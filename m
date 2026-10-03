Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10619CA5FEF
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2026 17:04:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xD38e-000753-Sc; Sat, 03 Oct 2026 13:03:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xD38c-00074S-Qq; Sat, 03 Oct 2026 13:03:06 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xD38b-00075o-Cl; Sat, 03 Oct 2026 13:03:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eEV49ZeyHQOnv/FPSL+c3rEFgRuM70kkISnNV0D4Wo8at/SnexaHEHlLqBkugnl4JC2H6VKCLJdwgHSpSTDEQC+x1vX+nWaM6xPT+yTuIaSuz6mrYtaymKdPEpZr73KusEpoDk47/ca8xFx0ZUPs7lh6nxWVPjTlYdhOcJCmFnAeNLF7lIJRb6TMWJX+WDxAh1eC1lVISVW2nkemL5xUWIOZJoAfiw2EspQOZoCSeiBdrckFUsRLwwTE8RAE5lWr/JqdymIr7FoBP3RyWdRwUocCTxwDxFG/DfSPTU03jEh0v27LMoQSRNN+2w2jPtCOUPHYUQeDERWnk2CA1vYp+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L0rhl7GY61g03mQTRcsJ8UabnJ+bj3IidlZgZGOwU+o=;
 b=yAbrOA3vXj8z36dgtUOWvYMptxCV/VB6+nQYZzMPncVA4ahXQXgiEQAEOy9kBlyrDKWJ7xvOzI3+jRRSyTCLs005PiJc5IIJz1eQVccVn9ylUP5+xcg/E5lESWKcvAO7RgNDNYOzr0p2s7D3DW5jHTiTPAAcGHBGIL5GlcPV2Mp4/cqFio4ygRqIq6Zu2LzYMamHKBD9y7EG4RpNgiJKKZphJQKqOuOHYoQKv3DvV685waaLIO9MxUcQ3NDK8p+3lRN03M/C6chTuNzJVvFubuEQIhRZTrSOtrzFTK7bIDzTC76waSuY5iig1TTC+Z1TmiYMfwMVvmBRSWNtUDvQLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0rhl7GY61g03mQTRcsJ8UabnJ+bj3IidlZgZGOwU+o=;
 b=YTrAEegKJbByaG4A2ajJn+0zj8/jmlq8ETrvfbmQM8Qgybsozr9n682YajkTsb7vIm5g2jD9MDBjIhDNk3dQ2WAmshoT/FLA+cQMlwhu8VMy6ti5MAb9GKRJZBTc2umHsANbJp6O/W05/DSAtq95M/pzYi99ZGtxb5groJlst1tbW7BvhMFyoBMHlRsst370r+zBHpuC0RSdv1Gqmzb0O9rwltfy3rGDxv7oLvHQxmQLnJPSDhDP5jWK+vMsvhPQ7m3FVJ12c0kupjF1grioCUmweODA77Jm31pWBXYEJ97lNxaOf6pObYtA5JpCxwb27Fa60m7dfF0z9M8V8qhsmA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by TYSPR02MB7371.apcprd02.prod.outlook.com (2603:1096:405:39::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sat, 3 Oct
 2026 17:02:56 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0472.016; Sat, 3 Oct 2026
 17:02:56 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Conor Dooley <conor@kernel.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org
Subject: [PATCH v3 01/27] hw/riscv: pfsoc: Correct the L2LIM maximum mapped
 size
Date: Sun,  4 Oct 2026 01:01:51 +0800
Message-ID: <20261003170232.2450916-2-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261003170232.2450916-1-bin.meng@processmission.com>
References: <20261003170232.2450916-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0100.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37b::14) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|TYSPR02MB7371:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c31bb66-9431-46a6-b976-08df21702b5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: PBPpuQDKNGkpI9DIwIytm8ApZNl5ha3FTC3iRftbsgvDG8V3mfoVcq0q6X6QEelZDoEz7s57oTaq16ZR3mHeV7cYNDIk+L3wkbaCuTPJ7HIxtsgx6il8Lz5Kl4PiNKFN3CWGj57bSUFqxlYlIduUeGXX71x0O1DGD+FK8e5lYplDbG87GIxsUEMG4zweFnhTzYELAk+StnMYf3ihZgUCB4jIw2EhtL70X1tdcsdB5j/dMM7dEYLCPQ1d0gKcy8RQXlXFG0H1Sgq/4IcaHzHQ/uLMyahb3EUZYtM7wSQD2cp2CjcWgbPXX47ILd6KQSeFnc2n8bckQiPGOpLNwfoVQEC4feHVp/eiKlG4mZjNgQfRXH7zSxLn60FsgzJu4PZdUfQTXctzFi37+OwaSwUVc9+w+uiYBrdWYXpAwMuJlb56l3Ns77CJoGSMT5QNVfRgR5CPHnw2pV6uN5k+2U3zRVhGna1uOyQx7I0iXuXxFiuqjN/t+2F61+NyVG+ZrvbVAnokOyvWSKwvRpE7JbsXmTcWeGZi90sQeb5d+evkeptIJ4fAXNGR8seTPpLFPq2ve/Lutoz12xqpvItRdf2L2Y0codneVg/MJbNWZz4Ci2zAF2fLS3qHbdEE3F1CNDllejUl26X2ztliWaydEi2E3SMqjha1bjaOPsn1htEgAIc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OjrGgYikiQPsYLs16l5mxdGk3ytD5CBH+2EBK8BHfbcOzTCVp6uYYLUwO1/X?=
 =?us-ascii?Q?LssuNmwF9LPKfYen3laDbCUjqfSXYQFxt0HlnOZtBGX/v6mmlc6UMX8SjSA0?=
 =?us-ascii?Q?6CwHMBvYfwk2ASy1vc7EbNEQnJEB5BPwfwA4RFckH9kF5Q34bswvKbdIQ7Ql?=
 =?us-ascii?Q?bLlO/1Qhk8oQZDqXhhFXzouPT588rXHuLCOPWGcfXcw5s5L1Wg9Fiw7aMq+Q?=
 =?us-ascii?Q?a94ZKzTM5eXRGMZ/1y4jVS4flei9D2ZfAzKy9G42oiK7yjejFU6Q54i+cDs8?=
 =?us-ascii?Q?RT3d9alFsWVG6roxoVAearPuOdEwKoND76ixNV353DleHiarhh+dSrjCegP4?=
 =?us-ascii?Q?Otgj++NJIca4cr5xrY1wy4SgI0nn6lCgtjF/5UoQMlWLRdi2pEtoM/oSWNzz?=
 =?us-ascii?Q?XMRLrwx7RZGVXHq7diAtVJJPeI6r7+RIPnywm/CekmdXkyx8xr1sHeEb2xNR?=
 =?us-ascii?Q?Z6onuuTl9/pjMXcikTlNKXE2SM3GZd2sNoVCFC129GG/d1Yv9qcw5CDAAr7D?=
 =?us-ascii?Q?EXC3p6rzY9giITt9ArCUtpjXyXCdJgYUQn2ZL1mF+DhjpQ+5fWlfz1wGwGTE?=
 =?us-ascii?Q?9EC6AxbhnvoEoTJtrhbnjJzP9slM3YeGJcoEeZ0FtWMp+V8wxW0nSEBzDip0?=
 =?us-ascii?Q?E2x0VlJr2eO0nRRpIyTxBBzhfQMcc+CWQf9F50Wmhln3W88k75Ssv+6dHixG?=
 =?us-ascii?Q?oBiHI+2Lw8EcjrYfhcX/CNaihfnnYlfrbWIrec6RznX4FpuYnr0xenlcnuvs?=
 =?us-ascii?Q?APWGqayMgrPvJDtqJiNLmVp0fu1XY4aCM95XNx7MCpuUvuIZZCZ5cHXfSHEq?=
 =?us-ascii?Q?F+jjDBsBN8tPm3Mxp5E/2Zo9A8rCC8yBlz1Zijz1cXMI6nHGPvmrcROKylP6?=
 =?us-ascii?Q?+YBsLbSE2QDcoDBLCPf20bSyrUqCjT27BQ+0akE1LQ86RhbLXUfYFdeALPdP?=
 =?us-ascii?Q?W+V/Ed2yj1OWH4fbQkD9TUYxv2Wyf8kgC18qo6TIKfIEOEGlgj/k4GeroSMC?=
 =?us-ascii?Q?rYmcE3k1JizYAMhsoaONflyq0ut7JZaLMLm1BrCiHh5YyLsTgdJ1fBFYl4t2?=
 =?us-ascii?Q?ra3s3m/Y8S5zcPgQvg88HazheorGQ4DGRFGduofuYIvZWj4PmCaMilZ4OXHG?=
 =?us-ascii?Q?vjkpADR63o/2hWNXFRXF4kllhE4ExQhqtrkfF4pqJj3L0aA1coOf9GppWNjA?=
 =?us-ascii?Q?zxs3s5mPKy5iWOYmBCfl5Y8ia0d2j7SrxOzNH9J5KS0taJP9qs+RHLljU/wt?=
 =?us-ascii?Q?fhYI2VEEiNlkts5/DDN8tDVduwM5fIEGhXyFv2zIijlyRZJLwGLbDjK/v5Ty?=
 =?us-ascii?Q?mKJ+NbIB9OcZzCiQKgG/GpJifrh6GQ0Wp6inYEH8iPvRy3Y0dk/a5e/RCtE+?=
 =?us-ascii?Q?rqD19N18652XAQ+xfD6pPrarlvNRUwPbUhQeIGBLI4HeIXwUA5hmv+K0SgDz?=
 =?us-ascii?Q?xPQqn83KGb9IeU7Di+EWTVc6rXz/UqHcW+QXpCh0224lLOm/Kb8YEGG4NNMH?=
 =?us-ascii?Q?6Aa4I7fUTcjdxCEp505DnPjT9fqjO7NkqwfnAynWSKBmNIYiPrrrj2I6w8SM?=
 =?us-ascii?Q?IqJLDh+Ghxow2NLB5DXOXBj9UPytuQjKbzJ+LhKZ0tBRngLZFUU/CuD+EWhz?=
 =?us-ascii?Q?CSQXl6hp7tZ4I+/AdsmtQXFNxL3SHQTe5bFC+h4yvZak31R0fDdelfWXnut7?=
 =?us-ascii?Q?BPQ2r9EsH43H9TyUmE+oJqNLjj30EqPyq5kI9e+tvJEEqT0jHc+ouKmYc/n8?=
 =?us-ascii?Q?FSe76Ef2GP0zz19q+0XkKoIcWcC6dFo=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c31bb66-9431-46a6-b976-08df21702b5c
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2026 17:02:55.9189 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nKP58BeLBJnAv4SmrHU8FtgF7Qu5POqYowm+izAYy9mtFEwdKBCDolF5I173gL0PM1D8DzlgyUIOpdCOi9YIqLxZx3Qq4azlZtVmeLJzVeA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR02MB7371
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=bin.meng@processmission.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

PolarFire SoC has a 2MiB L2 cache, so the maximum mapped size of
L2LIM should be set to 2MiB too.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---

(no changes since v1)

 hw/riscv/microchip_pfsoc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index edd29626fa..cfba2990b6 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -95,7 +95,7 @@ static const MemMapEntry microchip_pfsoc_memmap[] = {
     [MICROCHIP_PFSOC_CLINT] =           {  0x2000000,      0x10000 },
     [MICROCHIP_PFSOC_L2CC] =            {  0x2010000,       0x1000 },
     [MICROCHIP_PFSOC_DMA] =             {  0x3000000,     0x100000 },
-    [MICROCHIP_PFSOC_L2LIM] =           {  0x8000000,    0x2000000 },
+    [MICROCHIP_PFSOC_L2LIM] =           {  0x8000000,     0x200000 },
     [MICROCHIP_PFSOC_PLIC] =            {  0xc000000,    0x4000000 },
     [MICROCHIP_PFSOC_MMUART0] =         { 0x20000000,       0x1000 },
     [MICROCHIP_PFSOC_WDOG0] =           { 0x20001000,       0x1000 },
-- 
2.53.0


