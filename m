Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35467606A31B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 15:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=AWW3XATI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOd8S-0001Vt-60; Wed, 04 Nov 2026 10:42:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOd8J-0001T6-24; Wed, 04 Nov 2026 10:42:40 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOd8G-0001DQ-68; Wed, 04 Nov 2026 10:42:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ehObS8Pb4JUNuB9IuA0rxuVMeeAQ3o3l7RkITkFFO96/cxS/5SZqL4n+8yrDyjdC8K2N3bMEVDBJ0eTzGt/QpD0SxnDm+6+5B1Vf7cgtWbgg5ZuF9iuafAwc8j3ch6MNKmoHX4pr2eWnDE6GqjH+PxY1ak6g695xegPd5RE4SwQ33ZJy6GJc8s2CfYuQh7WY5oObw/gPCNeKSCTdKy6uZQWJyeac7rcsNJhaLkc8DEQyxfHhYksspdHO1ipOW5LgBDyHMe1T+Ck41eT3+bq7dDUXF0uKCt2sCdC7GduyFIjTdV50qE94jzCVDVfOHR3lxcUl1lyHYEerfEQrknK/Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bXQjR9DyWWhUc1NRUx1qU40mEmVbUGNKrDWqqbxhC8A=;
 b=THwCyBffdlVeq/xUHB6lrVz/j7aBzwGiS0sWGnrm39A5iE/D5O7Y6VKXKUANzCHo56ySWzdxbtmnsXJ/FO9j1uJyfTe90dpLfrJtkuEY2Cq98+BEaWR2m81uzk21wRbwxeBsMkDQpy3MEHCJwSent70L+/3iSUwlLJo7KxysXeEJIpYfWKRUmnwirYg/b9fQeY7YxhuSYjBwnisYVoulgX8AxQkd2k3Pp8Ex708eZy12TQF8BudDPWGTpivwuPcaajmcPjLRWeTZF98pXOWOozUCjbi5yMs6yCDGUiJ4Hlh2BhW6BRuh1EbTSrW5KusZs26ixEbpLa1ery3+2O+bGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXQjR9DyWWhUc1NRUx1qU40mEmVbUGNKrDWqqbxhC8A=;
 b=AWW3XATItyUwGdBCdPBAt5KH1QtbYJlHa1PDQnf+jH6v1T1x0NPffWeIu1FASGDY7tdZ4TvoANcDhB/08oYVJNh7i6B+nUkw23rYxrO9wpuE/pFZSujD0JovE3k6M7PxnvYJ9tMt3MOu/A5huchZiVgVXzdvxjT8Xqi6ePDpFaZoTjCza5WY5GfVbyQSDh4tJ4sabvA3mxLs2XPbQ5uOimx4U1fbr6A0oECS0ijDjbWLb6DJOkY8obLZRP0JsaCPSBXu+T7R/LxWXrD+5r7ISJ3AzyE+f9Hb6khQEonbJfUPPu2jbcl/EO9mjksNT9SWSZNt2fTS9SD9cKKAh8QV/Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com (2603:1096:405:2c::12)
 by SEYPR02MB9159.apcprd02.prod.outlook.com (2603:1096:101:302::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 15:42:26 +0000
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10]) by TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 15:42:26 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Conor Dooley <conor.dooley@microchip.com>, Conor Dooley <conor@kernel.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org
Subject: [PATCH v5 01/26] hw/riscv: pfsoc: Correct the L2LIM maximum mapped
 size
Date: Wed,  4 Nov 2026 23:41:28 +0800
Message-ID: <20261104154207.641511-2-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: 97499139-8c5f-46c8-91b3-08df3a8a3a26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|7416014|366016|56012099006|261021123027099003|261021121427099003|261009223027099003|261102123227099003|261022105027099003|261028144727099003|261026140227099003|261026121527099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 7RWewsH9obMD1tw6Iblf9DgX1C4goy4bSdX1lLIHEuj6LNyZwssdEYMpcjN1R/vKvLsl7gdFCxdpDZI2A21MAtlX5cD8hfj1XzNUxr1CtsZTKfPR8iDNyyqSZU6kNdZjzb+UeW9a1iW9SRL2DL2UFXSHD2ddsKRGR2Q8A3jD16BAqXWc2RHcrfswqJfiaGaHO02jwSJ27RtkkcWgVK146E9dzYKfHkFKlEn5u/8f+bxpUtn6o+Tc6pM0w4yGS9/e4K+3Nzxm41HI3LzxZT35yQ/m7lqGLT9cFxqDVZs+1i761x/pU4RreDsFBKhboP3tA4jBsQBLvmGro1ImrzXMc+NrgVu60aIONpScIeFeVff7wAYMFoylZFRTzpZ6vi25b+HXRC/AqvamFoCdC9Y/9nagbBtyodlw1YVLeJny01EgRV/qLqkQ6tgLacU6vAf03WtyGA2NCmVLGHiUUW9oTc+1c7TbdoDLjNjP6xXW0OW7KDKu8vQ3zNZFMbb8JZQFv6DDv1n02V9rPRR6jtaXhYYqZaDsga+Ad6o9L0zu2wJall2Z/CFn33dhVaoEsl6EO2gsHfVSYYMq+D7/DHJlnhSEZS/3ApbXx/q9FmGwVwpxRuJm39Twx1bOtYqpH1kW26X3I4MHKpNMDbkA/3hgffI0t8TDzHUJp0S1kK4m0R0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR02MB7121.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(7416014)(366016)(56012099006)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003)(261022105027099003)(261028144727099003)(261026140227099003)(261026121527099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5HNL1uVPeOPbxh29XEJTX0UNzDlak2DO2NI6aQNwJy3s3cFD7GUbRhMqV4hF?=
 =?us-ascii?Q?jw+VLabOyJn/PqPVs/74S4ST+eZpLcI7N83FWRtIW0cYmBGBtoFRNSHVobEW?=
 =?us-ascii?Q?SxzqiT3BV+I4PtSBE+lWAQhwCvHUMUvXhRuQL4yn5uGbMZHvpv2V1+eWA1w6?=
 =?us-ascii?Q?0RuQ3IJhInxgu16BjE7qe6iae46FxjVWniMnsuw3PjdKkvg/ws9isgFoFrSE?=
 =?us-ascii?Q?h6WZKEGVNnlFtlPZQAM6Y9DLos54vS8vvalAjd1pnlJCqzMykzL0YomghJqJ?=
 =?us-ascii?Q?YUAfXd7uBfuPFKtCiS+S101cIPup+dL4J5hFX5DmBSvL75SnaO94dNu5frH1?=
 =?us-ascii?Q?V1HVSOyc76cPC/ACJ53/6owa11sFdfY9xmg3XyMvckRPWLOrtsZeKvCWlAuP?=
 =?us-ascii?Q?gRr2e5v58xQFQRq+0soeukaqSHiD7BXCf9tvewMqaeGvRHpQJ5Siq08TSnBH?=
 =?us-ascii?Q?FbIDOnRFtUpX4TgamhnIWRFrLGus2PeEpRC68nqZ47ujouKRONRrMGX+XnA6?=
 =?us-ascii?Q?hNBh1CVGXGBBPMW1z7sxa/mozFgx6wMlSPWntdDvEMEqKDy8m1PqTRCukO7h?=
 =?us-ascii?Q?rfxtPthm09wBj72vhoKkDYXc104nTedUH89jgHljNPHlY++9z5ozzcAkSvzU?=
 =?us-ascii?Q?WKrvJ3iEtyEg5c4FSsNlhWHeTDIJ5aZzjomf5BChn1QXVgeReHVxx5ff6pT2?=
 =?us-ascii?Q?9bGn4nAHjGOouB+jYvkFcysTaBWM4gTIluaVNB4hJv2op1YqcwEymRO2mU6a?=
 =?us-ascii?Q?36/oQg6PG1aOxdkIv2GYD0D9humm5MWbEIykPv339NSKH01LXwi08pK/+ixR?=
 =?us-ascii?Q?7jAQDPwvrhwr8Z+RaWjB+dKrnQ7vg10hz/T5mohE//ZRourN9fG62XCItAYO?=
 =?us-ascii?Q?GQzncPc5Nf5qr1MCCVjgFQLNRIorNR/ZhowPE/pxscn835HMxBqDHZ8M1jGv?=
 =?us-ascii?Q?8NJFB7hjoj08w/rsCN2K2jpJuMpMmFFkngvrDVCLndhW/aoPC5EZmzPq2zwt?=
 =?us-ascii?Q?8rEk9MzXgqmWjvSZqty74MPS1HaWvAKtPAudJKy8i3GX0NBmA1brWSl16aaX?=
 =?us-ascii?Q?LUnjBFmUkWiCPbyhdd1sRBYpIRMa6CuvCwFgUTPoXfa7lf8ZLul2GlOOSFjo?=
 =?us-ascii?Q?ui4YRbX3yxv2jOCmHCtNhs/ddtsQlNiSnRKrkQ9OwJazmtWgqwhHZudtfhl1?=
 =?us-ascii?Q?Bm0xB3t+yAffU1CPYb/oxOoMD1t/d12GqRx2awYitxFXwj5X0H9qAtI69Klp?=
 =?us-ascii?Q?eaVf8XB+fAAsYy4imvxAuLxPgbMKee96hxdQerOscJCV5Rvvugw4DO4Sb/zH?=
 =?us-ascii?Q?+4MxBNhjx7xg0VtcFciNpawM5i6NXhNpJCwKBJa6/xMlqN3cr6oPVHT1jcHp?=
 =?us-ascii?Q?TCNvdz8AJMMfn5PN1JHZVMZ6B6FnvyMivJF3k/XepNXamgfzxEroc0F82ot3?=
 =?us-ascii?Q?+GNmMA4EVwO+lXXn4YLsMkyLMPyziZBlqfSCwYXZQDMnpzQrwfSoAdQuT29w?=
 =?us-ascii?Q?0LkSwr/u8RpEhvAGxctUjJkzetYUihCh2SU9nxpnwyNFcgwwKLGGBLKPDAEL?=
 =?us-ascii?Q?70GeY8o9rrVNnw7NrT8/DAio1vjb5/5yNufjVgorRJJybQSjs9snGH2FiXDD?=
 =?us-ascii?Q?o1qKKaKUrnjvoUKn2iooVrRZsF0tTUoTkybjvsNRm2i0jGVZ0vNBeljuMnCI?=
 =?us-ascii?Q?p+1YBm5NuIMpK7umjMiDyJZaSUx1d/tC2BpdIE2bfYqcsaLMNYRw7TEKxJ0O?=
 =?us-ascii?Q?szGaHyOKNr8OC654UJ8sorw0nlgbFMw=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97499139-8c5f-46c8-91b3-08df3a8a3a26
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7121.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 15:42:26.6510 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wQE0bnAaB3zV8/PewaVHYuDTm5Yzz6CYr9KNyDL7YuY78RlFUPu4Mk3D1ysrTtkjFAvEVzm+YveZ85ynJYu2pkJ+i7smWDbAcwkBEYBeKe8=
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

PolarFire SoC has a 2MiB L2 cache, so the maximum mapped size of
L2LIM should be set to 2MiB too.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Tested-by: Conor Dooley <conor.dooley@microchip.com>
---

(no changes since v1)

 hw/riscv/microchip_pfsoc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 27c7c42231..c6b76fa3c2 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -96,7 +96,7 @@ static const MemMapEntry microchip_pfsoc_memmap[] = {
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


