Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF482CA5FED
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2026 17:06:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xD391-0007BT-GR; Sat, 03 Oct 2026 13:03:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xD38s-00077v-Uu; Sat, 03 Oct 2026 13:03:24 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xD38r-00075o-F3; Sat, 03 Oct 2026 13:03:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wr1ZMIclUKNGknxHTMXg8XVqeo4R7i0bHqwkDhGx6gszTzg3aGA+jXXv2NtCO8SkFTgynupFIgkBKzQQSD9so5rk4ap3BDQuMRy7/nNN0V76TCQovzQ46HcwYR7JDZ2iQSy821gO/2q5ydwcKMLmnslqx9VjR9p46JfudYYNfSgVn1dUJYzL5O+LsrIT6z/vIRIlc1OH5/2JCjT3Ak4nY33YFT9/XXgVFZPVEb3Ftam2N0Em37zhAAW65019m1H5q3ji+Ex6CWBJGaOMKCbQwE3MiqhEDCjcLu1BSWe8wpOBzB/YIRP9jHuUPZXrMeG9TGYEjFxMlwMRqJbZQvpaZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYB0fu8lwGXFm9mLQ10UCQUsmJlonj+3BPoEUF2306U=;
 b=jveRoCPY07+670p+m7qBragBUnqZ8ppcnRYegd+1eTg1Wt+6uoSWHIa4+pij1aozFTguBjEhD9yqlebDae6amBdugInq0dTl4Ltcl/TSLybLdTvaX0HanQyMmFcFNNAABeYVS4vaCWHhLcv75spUAkEC++eLD9B+2DHmCFF3FA0zYOrX/xIH7coPm4WE16+sMoFrpxS9UknPDUzalxPxlXEmPak4g5tvA3g3qvUDEJtYzquRoH92iSq4eEOauS4H7n9+eqWfOoWpMTYA3Y1/CQPXaGRdNT4opLVDfbodcRCThSM6n3jCH/6xBpL5TqoX9zmzwVUIswUvbLnvgCubDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYB0fu8lwGXFm9mLQ10UCQUsmJlonj+3BPoEUF2306U=;
 b=gKYW40E9DXckZOkcVtosyF41AXMKs7IX9iA+0MyomPZmqmWyO19YZ/he3m4xj6rB68pA5JoxgOM9e+PeJt2ZsyVfbGcdaAVZPdHZRGQKaWYquTlIWuJPqFI91aoSA5oJfIW951mKfzxNBhkJRIUPxnglkqYAW1OKzwgCHLFqxd4hOdXwaOkIGOY9CymZoiGQTv6mVuqadzdGH5xWUeHbnxU8vtqVLRrmLl86PjV/fwKAdsMU2NC6FyE2+cLP3MI+uayKrWsZOQgyYXkpgQ/KHIboI9aotyxOg/eJiZdYa7q4Ua4Ib5H4Rxj2M9qktQBwobcJYQNQbDSiEhxXLbcQqw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by TYSPR02MB7371.apcprd02.prod.outlook.com (2603:1096:405:39::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sat, 3 Oct
 2026 17:03:10 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0472.016; Sat, 3 Oct 2026
 17:03:10 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Chao Liu <chao.liu@processmission.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 qemu-riscv@nongnu.org
Subject: [PATCH v3 06/27] hw/riscv: sifive_u: Correct the L2LIM maximum mapped
 size
Date: Sun,  4 Oct 2026 01:01:56 +0800
Message-ID: <20261003170232.2450916-7-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: 36b94488-26b3-421e-49e8-08df21703410
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: c7vJ+DODQ/9/PG6CSyrE6Uma22d3JXba8z3HX7yVSTot+vYmqN/xWXn5VZEhXofJAhQUrqaItFyvOsZdZxK6zOJm1YCQBO+9k6Y38EBOorasqttqqAfaE3EmBBOMDj6BmvKnaRuKqJfg/Zcz6m1+lE4q2gWMKH5HG0H7FnGpbSBrN7MhaxPhNORPj6jmofwDi5xagSqy0oHfdVQegFpDASMULlAVqqVqQEIRDLHQNcmQWS6JHKLGuXE+BAsvea/xevKm27q1faob/OEXWwUzd7L0t+Lnb+Dy/zOR4OF9EeZhB0N/3/VE/sgAaL/K02qVRZi+sUrVFSSAonJYjQVY+DpTsdX5++YeI9zrM3se715qPdagC+MxKJYHTSujfU/NnLxan2r7Co3RWOFTqOc8J43CZdCs8sRlyHOvcIMpUP/LKaycpHg8LLxj7IEUaAS015XEr4kVoDoX/htMtv345KBkHtCBhsC/+6i40kOFvw6C3ndgWaJQISdWdYx+JsSDFQ96GyWy1jQS0/dIt1YNqVvTnVYYa+xpFmtLnXWmoLLafhGdb1wHfQzY5d8+Di9pmfOV1nMVJp6dANUfe642njCYUiJUrQuY4fiyPEn5Nt0BdrbypcT4Rf8H805kgj5HeWhSqkli6fEEyT2+4gfZy+/ykeQPaZj5ry7rGK+Xj1k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JdiEJm9BnfYtodjhb/YNWUXKdZPHaLPcPA7ge1qewBfUJaKUP32F6HskF0ar?=
 =?us-ascii?Q?9yzIJL7kzfpy0FYGZFmkrkypZFr1aS9hcFP139EMnk048F5PiWnlEixQFcks?=
 =?us-ascii?Q?99xFOn+gEFJOzdqH5mRnms+68PbVokl/83HLgauzFudHQdwIFL3t35miaTEd?=
 =?us-ascii?Q?2GyDbNdwMEokWiOcJAe7yvkCpCPbrTtOM6NtcFejOI1edtqHF3zdoWVhLZ+8?=
 =?us-ascii?Q?y1KyqsDYJxN6H4ZAXQIXDIpGYBW08SY/MQlgEi9oykj3Psu5+2/p0OiA22WU?=
 =?us-ascii?Q?EXQVVcZ0x3CjiLQy4uiwfnHEfEiMb/KZJ7IxlBr8HK6H+B+JolY35UWgaJk2?=
 =?us-ascii?Q?9Rxrl5kz6O3K1ZIXfYdJX3zeWfsgoqYXqbGyDryOKtNEIm188L6/jqINmmmC?=
 =?us-ascii?Q?n2RSFW6mJZZUCA6bFTlwZWNYy334s/1e4EdeAozIxOB6V72x7lIG0l03S98r?=
 =?us-ascii?Q?sJ+QJvxRPnNyRtOeoLPjUHIC00lbCeJD/NRVoM6gOKGRj5deinle3+hhAR4k?=
 =?us-ascii?Q?QKq04iUovW9uDobwdCklYU9fEM3TYiSz2JAYeNbyBloKTdLyOldej2ZbLDaC?=
 =?us-ascii?Q?BPKqdf06PA36g4cIf2HBEamP6sIbOEObZn5coBvGrZysCqUtTS6obbgpg9hj?=
 =?us-ascii?Q?hKwpnXeSJ2LaJ+5T9X2Ztg7aXB56DhfiP87DKKDLLg8RhMhD3UzWaACVC8Wi?=
 =?us-ascii?Q?kNOm4gSpFiQmZvLxy4BJweg/T7fHvkJclEvlnHn0RhqCJ4aGng6+qfSsxbw2?=
 =?us-ascii?Q?DRJDF/irh0VQSP20CIU//mYtwhxqyiMiKtTpPbZBuS5CxP18C6tnfoC9y47+?=
 =?us-ascii?Q?QDD8GGxWLENaXBiPRGNtudMtgIBJjwTCUnqIjd+hy7zffuWbz7Grh2+vA7qH?=
 =?us-ascii?Q?zfoIcPPHIrffBXhxp5kJNfqpTN4wmUJ8mkbYa/J28RO+Nk3Aj9axW3UBxsW2?=
 =?us-ascii?Q?wHvroGviUjpMQDm9RhSO14Guq9sCQRNmi07sJ4/kltuxK+FWGxxcccFQ1DcC?=
 =?us-ascii?Q?Y6TpoL55vw4dlNXmCQGWR/PjlXPvX9mYvANOTv5qtecCTDM9ZIj6m3JEnSKV?=
 =?us-ascii?Q?0ZGsQtdzeaaelj8LpptX1ySNeZNM7J3KedCgVk0kZF0zEALBlNT/HbakZdGq?=
 =?us-ascii?Q?A1sgTjMi47G/lzpmlFWUvqApGB3bLrMbowxD17xMsPXjvFIW53vtus28B7Ui?=
 =?us-ascii?Q?EmR3l92JXhJui+Ur8g7G4m6Rj2pgmMiUeWBglWD7ZVbA0BPF8w2V3PcdxdYI?=
 =?us-ascii?Q?T/GKBWfNyww0RCei67hc9AFhkSMjbLRF68nJW3dy9ILp7GfCmTnhFpLuFFeD?=
 =?us-ascii?Q?K68yT5fu6+cLTbG8GRKTljrybnwWLhECMryWyKP9q0CNaVDHbIM5qbrvqm24?=
 =?us-ascii?Q?v3OpDtj/alEJGE6ZonnPE9iZ/FNhLuQs8vxaMYLW3DHLE4yhfYS9F46T/z6Y?=
 =?us-ascii?Q?kiso3jnsz1bEUMWpQls+uCzjLrDzXNdmyIVaXKJByKcFsMEjozlNMcFlbMZ4?=
 =?us-ascii?Q?gtKf81YV9RppCwOWYsXwMiXmeE3Vy9D4uC7cwGvMUQLPfoDfMnlJ5vN58Bq0?=
 =?us-ascii?Q?7roamrjjhUy4J3GT0UGSaRiUQHbxnnNqUCHn6smu6VP7Qe5fRxcy/8lpsAh7?=
 =?us-ascii?Q?0l4SaqT+EBsSmNjyr/wOj5S6LZAP03X+mKHOb61ayqUyLTfkUeuqbW9GvwL+?=
 =?us-ascii?Q?qHn859VG/7kHGlKTp8OoS0NqUtMbOUyGjiK3aU+KqU+7ViSC37huINOI2vE/?=
 =?us-ascii?Q?q+BLK+/ik3vghABM+GoTBm7CzW/a4zs=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36b94488-26b3-421e-49e8-08df21703410
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2026 17:03:10.5104 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F+jFBFNVHGFVYZJgPay92H9edZOUYGp8ZA60Gmmo0RZ2Qjt6Zm800NX+TVyQNhw5Ghexawl0hhlGplkKSaP2StgbleCY3rCoAaXaIr/6gGo=
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

FU540 SoC has a 2MiB L2 cache, so the maximum mapped size of
L2LIM should be set to 2MiB too.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

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


