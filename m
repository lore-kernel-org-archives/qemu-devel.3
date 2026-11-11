Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668F1606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 07:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=S4Srm66T
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR2Kg-0004Dn-Eu; Wed, 11 Nov 2026 02:01:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xR2Kf-0004DX-0h; Wed, 11 Nov 2026 02:01:21 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xR2Kb-00008P-TH; Wed, 11 Nov 2026 02:01:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JJ+v3qUUKP5KKahQj5VDrKnF+LerCj2dFNEqYupvuD+Z5LTxlr/fvtmTJ5LI3dv+a0Y2Ye90C91kFcok9YH/HaEfQUKoO7uPXoIt+vBDkqm26q32ru6UPxR0VKJslhCXqt+CQ+GYftZ2JunBkp9KewaZ7jbLajJza9a64O/3lgInKD9reoqstHS9X89REckbE3JXzGPJesCf3ddV5IugwZD1sNA4tVDQV2ocOYRKkRAVPACRKFPXHd7Z7MYgywc0bX0QMhfkkGCxHOaVkXn2LDeZtLRMgO6kktwvFogHAyWxor/Grp2+0WemzaN29IJ0T+PasL1c5vNjIc6+fkzUSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jRwkvE/cHJtUGElzrIiGtHItMn7e4QWqilu9EpiJjfg=;
 b=NnQBtex44mIsIrSov6+iOD3YRKQKKZJFcs1S3sZe39qJga8WKIYWsFw82NGHDBdp7JWLGZ/RHeLT3S8FuRH417Dm4NtFhLjoY+2IuoRxcFWScspb+xTOzoIpIc/Oq+XWnGb+9n2R25QXD5hNYK/jfd9s+SjUA67ijZ0SsqO21s3/YwC7iq72Q+EWf7fYo4JAGFvpq/25+fvlNUBljD/928bR2uUO24gC+KckzXzRbnWxZHfCEv/5Yjcer2rId6bW2+l/dMcigM31ubOk1dO6fJ9mHoEOEt45JnGNNtFTOHpJ93P8gcxaIkbut71tfzvWokMUlwAZUm9yR5jdXEtOGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRwkvE/cHJtUGElzrIiGtHItMn7e4QWqilu9EpiJjfg=;
 b=S4Srm66TeLLkkxdDyHTKSRZ7mp6e4BZlYGG9bJxy3xPU/3i9Ngw8g0xp8IX9ygSqiGBzYvmLDh9NKArooTnNtLnzfFBolN0AIQqv1RrsXT0f/CVNwoGFZsnjm33hrf0+zbE8uzlaNIiUrCnQamNTlMB7are7e4f5u98CYrbUI+FZaKYOeqvrasvtjW5R4jKAh66gb2q17XnJV/KmT9WZSBSJe7lw2rX8SvrKXlSo2w+F0ClAJSidOp2EyDEgYRhyfd60Et3/8yw+HSUd32rUOZ8iqjA/cD3HV4oDFnVpgPfGTPBCrotm6/0/RbkVaOnp1HN9xB0l9EHxaTYkRlbrQw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by JH0PR02MB6591.apcprd02.prod.outlook.com (2603:1096:990:10::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 07:01:07 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 07:01:05 +0000
From: Chao Liu <chao.liu@processmission.com>
To: Max Chou <max.chou@sifive.com>
Cc: Chao Liu <chao.liu@processmission.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [RFC PATCH 21/38] target/riscv: rvv: Implement Zvqwbdota8i
 instructions
Date: Wed, 11 Nov 2026 15:00:46 +0800
Message-ID: <20261111070048.38550-1-chao.liu@processmission.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104194155.679241-22-max.chou@sifive.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::12) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|JH0PR02MB6591:EE_
X-MS-Office365-Filtering-Correlation-Id: 13e540f7-48c1-4d03-44e8-08df3fc18dae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|22082099003|18002099003|10067099003|3023799007|261028144727099003|261009223027099003|261026140227099003|261102123227099003|56012099006|261022105027099003|261021121427099003|261022075727099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: HpvY0Ip56uC/xsKZtFjgATTedtSiZd/T0V5X5cd36imQxTXZQD8nMo/vbjrcbtZFH0Aoqhhj/xcckmje2B0OAfdU2ScdNbFtaFO7sqcWDb/fXJTHInSNG7Y4TQ8GBEix3+e9QbI6KCF52tYDGFJN3+xYKdskgvll0vqAcvRLdDaHjJHQL2txNXQaeJAEsuJhQ2ZoGHH9zAH51Z6BObebIQZL48jjQ4TIBmrEDCYl3bNRlP0L3xSS7neliiE3mb6UDNihAH2uAhnQHfFn7rexz3qNEAQOcDAHb7g8xu24Z2n1YlrBsgt3CHBBAFcYAWU0Lxunlr/g6KVWPDene7oL0JWhycoR15qIwFb4EZnolimt5zv6CxYk6GeWqrp/s2S7cbNWa/IFHpljbnpVGU/hAx4j0NB6MpyxjbjJvFS7W8TFufkrlmtR5HNIuemeDjc7kiSNgy8FF+fN9wE+04s4QydJrlZTVdj4LCPB3SXQKKKdMwvvrwPLz0Lyy4OvO6leSP/no+toDW08ZeOIv5wap+sDlO27HROeisZ/3TJpNCPmAo1gJTBWoWh61OvCYsRU10knQC5wDilimvBaPKzTxSY28BaJ8ZS7umfGghY3odeQGxy6OZ6Wrj2iwZmGl2Zp+Gp3Ag0E1472vn0GQgHkE2hw7VdTiTSN08bU8oww+xs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(22082099003)(18002099003)(10067099003)(3023799007)(261028144727099003)(261009223027099003)(261026140227099003)(261102123227099003)(56012099006)(261022105027099003)(261021121427099003)(261022075727099003)(261026121527099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PYJ518vcrG3u1v5P62DsHFtQo8ClIjHef1ypagpFpeMEGvQBZp1xq3DU9ub6?=
 =?us-ascii?Q?lmMFnDsRT//TLbSX+DohYQQOsubkrslwR+FD9QSeMJoBq8rLxYjZmYkSGaPs?=
 =?us-ascii?Q?nHYu3M923/BmEzgICE56xpaX0V3Ks9CvQf0RPQasJJse80wF4hpQpnOjtFCG?=
 =?us-ascii?Q?Yxamro+UYAQnCG08kQkjFxghJUsFC9/4aSJHm0ZTZ6UlYOWEnGZJu0qKeNVo?=
 =?us-ascii?Q?W/vizC7SXHy7gzCW2uEKEwchHJSzNI1kn8DlC/4hjNMulpTZm+C6VWeDPkSK?=
 =?us-ascii?Q?8VnRRyEGv/PbEPUca7QMK+Mov2OPIadReS3V0UpHPtH/eruGDKEgMjxHp5yN?=
 =?us-ascii?Q?1ruK6Jf/JAouftcFRqJ4grA1znmWt+URwsMG+c+tEtQu+GGcVQmW/kLHkc2U?=
 =?us-ascii?Q?CmC0G6MHqjmlgKQQsOUk4CPme/MAFgfGU5mFhxN2VEPFgmbYUQJtlUe8Dak1?=
 =?us-ascii?Q?GWR0/yhM8MB83ggVywr+essQM7yLovl6QsZjEB0L5d4j1L17bijFav9LsmKn?=
 =?us-ascii?Q?7JfM4nsVx1WJFhaRk1+AkKoaOVin2dBPFmxxoeW1ltTCmbgriumzUFLY27cR?=
 =?us-ascii?Q?UIL/ShdHQXctVx/r4tOocn1fR2TktZlPJcusYWd+LgrAZPiGcJqZKXtxpKBk?=
 =?us-ascii?Q?od2XJq34ESvHH7lGx7rFWE8fJlPOa3zg99194bJXwFJLGZWZ/yi9QTxuJpE7?=
 =?us-ascii?Q?+8Xrx2qrZqQO7goLz+Mhjjo92Cijq4KZzbObxHDti6yH0kxk2P3+IuC423K1?=
 =?us-ascii?Q?1aVyy+gfhMflb66a3gXUXrqbcFfY+mGRK03bhoGCOwurIy2fYwFFo3YPQ4p8?=
 =?us-ascii?Q?4XB7n9jk6mUDKtq/DI286KnD7tVvDMFx2SPmHxd3WIi0/0bETH1PVTIxNQn+?=
 =?us-ascii?Q?chmuLlee2j0CX+UcqJyWjkUNWpquITeiIymM3XxBwnWiWF5oOigKq2+4I0g9?=
 =?us-ascii?Q?as4yvab+VpyVFrUfimN/vK2fk6KUnZYVBbaZwbAv62djT0R5r9d+eyu6Hcsu?=
 =?us-ascii?Q?dN6jmRzHpvuC28/U1WTUBZjrY9VbJEzIxe9AbnFSHI+5bvZ389gvbS0qVCJU?=
 =?us-ascii?Q?o0le34C+3cfu8LGGbEQ4QWP/x3GZY/9MMYXssOKc5TVf6va007tsJdEETqVB?=
 =?us-ascii?Q?xfgOmhhGtrvC04ZXxefX70axNPY9H1bV2Zim0nUpmtm2RTeqYcWYdF9ElsOO?=
 =?us-ascii?Q?Rjee/4ObKxn82prc6WYx9q9VIxCcHHb5uCCQPVfGnElxMV4iPfBBUqpzRfOv?=
 =?us-ascii?Q?cUH5yb5gumj1EOVDgR4pLbYegBZqZBUBkXnQQhD2XM7Xk8grkm3hlB9Pesfy?=
 =?us-ascii?Q?tBC9SqdNTAjVBMWaE28N8j472nU9ezVeN9WJVi0u1dLFzUunAMRfBW0xiaeY?=
 =?us-ascii?Q?6bizBK+ZJMyZCjnDSLC2LFIYcECvEe7dAAOhCpUwnfwbDA88gHceMIMREDtC?=
 =?us-ascii?Q?3FQjb+AWbKglm2UbC1dXe24UWsYbGfKWKkqJFVgs+D7RuF2xaBgw+k6ZeuhI?=
 =?us-ascii?Q?4oL9cPDQV8Ma0uOa54ybtNF1Hgi4x3k5YjH5jpBokyMhQRFhpQNgjqG+dGTM?=
 =?us-ascii?Q?pAUN3jt6yxm3OaUODQ8vKyp9w7K9fbqx+h4P+mJ828LpnvlMUOK4X01uZmIN?=
 =?us-ascii?Q?OqR6O2FEdqVZj1pEjfLXHEh/fjWsCLSkW4gipGt2WdEimOqwM93+ohZdsmTP?=
 =?us-ascii?Q?1KCw285qPJm2uCiNENcqj8l2pkAKCLbHgqeNrrU54lCXrWUir2LbyaS/JTdr?=
 =?us-ascii?Q?V0Jvefso4vHc1bmRSwW76aKQdJi12RQ=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13e540f7-48c1-4d03-44e8-08df3fc18dae
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 07:01:05.1681 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1pguIUbCHIJ9dCH9cf/VfykMDOlSKWuWuINR1n6ih/8IRew+c9P488eGgoi46rmar3P1/nPVO9R0GS8Xn8uqvxx/fpEEbAgYDld51K+yG7A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR02MB6591
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=chao.liu@processmission.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu,  5 Nov 2026 03:41:36 +0800 Max Chou <max.chou@sifive.com> wrote:

> Implements the Zvqwbdota8i INT8 dot-product instructions:
> - vqwbdotau.vv
> - vqwbdotas.vv
> 
> The vqwbdotau.vv and vqwbdotas.vv instructions perform batched
> dot-product operations on 8-bit integer vectors, computing 8 parallel
> dot products and accumulating into 32-bit integers.
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao
> ---
>  target/riscv/helper.h                       |  4 ++
>  target/riscv/insn32.decode                  |  4 ++
>  target/riscv/tcg/insn_trans/trans_rvv.c.inc | 75 +++++++++++++++++++++
>  target/riscv/tcg/vector_helper.c            | 56 +++++++++++++++
>  4 files changed, 139 insertions(+)
> 
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index 48c64f45748..e48b9b4edec 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -1400,6 +1400,10 @@ DEF_HELPER_6(vfwdota_vv, void, ptr, ptr, ptr, ptr, env, i32)
>  DEF_HELPER_6(vfqwdota_vv, void, ptr, ptr, ptr, ptr, env, i32)
>  DEF_HELPER_6(vfqwdota_alt_vv, void, ptr, ptr, ptr, ptr, env, i32)
>  
> +/* Zvqwbdota8i - 8-bit Integer Batched Dot Product */
> +DEF_HELPER_7(vqwbdotau_vv_b, void, ptr, ptr, ptr, ptr, i32, env, i32)
> +DEF_HELPER_7(vqwbdotas_vv_b, void, ptr, ptr, ptr, ptr, i32, env, i32)
> +
>  /* SiFive Custom int8 Matrix-Multiply */
>  DEF_HELPER_5(sf_vqmaccu_4x8x4, void, ptr, ptr, ptr, env, i32)
>  DEF_HELPER_5(sf_vqmacc_4x8x4, void, ptr, ptr, ptr, env, i32)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index def5785f8e2..bf325229100 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -1108,3 +1108,7 @@ vfwdota_vv  100100 . ..... ..... 001 ..... 1110111 @r_vm
>  # *** Zvfqwdota8f OCP FP8 Dot-Product Extension ***
>  vfqwdota_vv     100110 . ..... ..... 001 ..... 1110111 @r_vm
>  vfqwdota_alt_vv 100111 . ..... ..... 001 ..... 1110111 @r_vm
> +
> +# *** Zvqwbdota8i 8-bit Integer Batched Dot-Product Extension ***
> +vqwbdotau_vv  101110 . ..... ..... 000 ..... 1110111 @r_vm
> +vqwbdotas_vv  101111 . ..... ..... 000 ..... 1110111 @r_vm
> diff --git a/target/riscv/tcg/insn_trans/trans_rvv.c.inc b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> index 6eb22494838..bc12bcb9b72 100644
> --- a/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> @@ -4289,3 +4289,78 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                  \
>  
>  GEN_ZVDOTA_FP8_TRANS(vfqwdota_vv, vext_vfqwdota_check)
>  GEN_ZVDOTA_FP8_TRANS(vfqwdota_alt_vv, vext_vfqwdota_check)
> +
> +static bool vext_zvbdota_base_check(DisasContext *s, arg_rmrr * a,
> +                                    int32_t vd_eew)
> +{
> +    int32_t vlenb = s->cfg_ptr->vlenb;
> +    int32_t vd_emul = MAX(0, vd_eew + 3 - ctzl(vlenb));
> +    uint8_t ci = a->rs2 & 0b111;
> +    int rs2 = a->rs2 & ~0x7;
> +
> +    return require_rvv(s) &&
> +           vext_check_isa_ill(s) &&
> +           s->vstart_eq_zero &&
> +           (s->lmul == 0) &&
> +           ((ci << (3 + vd_eew)) < vlenb) &&
> +           require_vm(a->vm, a->rd) &&
> +           require_align(a->rd, vd_emul) &&
> +           !is_overlapped(a->rd, 1 << vd_emul, a->rs1, 1) &&
> +           !is_overlapped(a->rd, 1 << vd_emul, rs2, 8) &&
> +           vext_check_input_eew(s, a->rs1, s->sew, rs2, s->sew, a->vm);
> +}
> +
> +static bool vext_vqwbdota_check(DisasContext *s, arg_rmrr *a)
> +{
> +    int32_t sew = s->sew;
> +    int32_t vd_eew = sew + 2;
> +    return vext_zvbdota_base_check(s, a, vd_eew) &&
> +           (s->cfg_ptr->ext_zvqwbdota8i && sew == MO_8);
> +}
> +
> +typedef void gen_helper_zvbdota_int(TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_ptr,
> +                                    TCGv_i32, TCGv_env, TCGv_i32);
> +
> +#define GEN_ZVBDOTA_INT_TRANS(NAME, CHECK)                               \
> +static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                   \
> +{                                                                        \
> +    static gen_helper_zvbdota_int * const fns[2] = {                     \
> +        gen_helper_##NAME##_b, NULL,                                     \
> +    };                                                                   \
> +    if (CHECK(s, a)) {                                                   \
> +        TCGv_ptr dest, src1, src2, mask;                                 \
> +        TCGv_i32 ci, desc;                                               \
> +        uint32_t data = 0;                                               \
> +        int32_t vd_eew = s->sew + 2;                                     \
> +        int32_t vd_emul = MAX(0, vd_eew + 3 - ctzl(s->cfg_ptr->vlenb));  \
> +                                                                         \
> +        data = FIELD_DP32(data, VDATA, VM, a->vm);                       \
> +        data = FIELD_DP32(data, VDATA, VTA, s->vta);                     \
> +        data = FIELD_DP32(data, VDATA, LMUL, vd_emul);                   \
> +        data = FIELD_DP32(data, VDATA, VMA, s->vma);                     \
> +        data = FIELD_DP32(data, VDATA, VTA_ALL_1S, s->cfg_vta_all_1s);   \
> +                                                                         \
> +        dest = tcg_temp_new_ptr();                                       \
> +        mask = tcg_temp_new_ptr();                                       \
> +        src1 = tcg_temp_new_ptr();                                       \
> +        src2 = tcg_temp_new_ptr();                                       \
> +        desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,             \
> +                                          s->cfg_ptr->vlenb, data));     \
> +        ci = tcg_constant_i32((a->rs2 & 0x7) << 3);                      \
> +                                                                         \
> +        tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, a->rd));             \
> +        tcg_gen_addi_ptr(src1, tcg_env, vreg_ofs(s, a->rs1));            \
> +        tcg_gen_addi_ptr(src2, tcg_env, vreg_ofs(s, a->rs2 & ~0x7));     \
> +        tcg_gen_addi_ptr(mask, tcg_env, vreg_ofs(s, 0));                 \
> +                                                                         \
> +        fns[s->sew](dest, mask, src1, src2, ci, tcg_env, desc);          \
> +                                                                         \
> +        finalize_rvv_inst(s);                                            \
> +                                                                         \
> +        return true;                                                     \
> +    }                                                                    \
> +    return false;                                                        \
> +}
> +
> +GEN_ZVBDOTA_INT_TRANS(vqwbdotau_vv, vext_vqwbdota_check)
> +GEN_ZVBDOTA_INT_TRANS(vqwbdotas_vv, vext_vqwbdota_check)
> diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
> index b1ca584f9ef..9e872eccaeb 100644
> --- a/target/riscv/tcg/vector_helper.c
> +++ b/target/riscv/tcg/vector_helper.c
> @@ -6139,3 +6139,59 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,              \
>  
>  GEN_VEXT_ZVDOTA_FP8(vfqwdota_vv, e4m3)
>  GEN_VEXT_ZVDOTA_FP8(vfqwdota_alt_vv, e5m2)
> +
> +/*
> + * Zvqwbdota8i: 8-bit Integer Batched Dot Product with Accumulation
> + */
> +#define GEN_VEXT_ZVBDOTA_INT(NAME, WD, W1, T2, HD, HS)                       \
> +void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,                  \
> +                  uint32_t ci, CPURISCVState *env, uint32_t desc)            \
> +{                                                                            \
> +    uint32_t vm = vext_vm(desc);                                             \
> +    uint32_t vl = env->vl;                                                   \
> +    uint32_t vta = vext_vta(desc);                                           \
> +    uint32_t vta_all_1s = vext_vta_all_1s(desc);                             \
> +    uint32_t vlenb = riscv_cpu_cfg(env)->vlenb;                              \
> +    uint32_t vd_emul = vext_lmul(desc);                                      \
> +    uint32_t total_elems = (vlenb << vd_emul) >> ctzl(sizeof(uint##WD##_t)); \
> +    uint8_t altfmt = FIELD_EX64(env->vtype, VTYPE, ALTFMT);                  \
> +    uint32_t n, k;                                                           \
> +    uint32_t stride = vlenb >> ctzl(sizeof(uint##W1##_t));                   \
> +    uint##WD##_t acc, dot_result, a;                                         \
> +                                                                             \
> +    VSTART_CHECK_EARLY_EXIT(env, vl);                                        \
> +                                                                             \
> +    for (n = 0; n < 8; n++) {                                                \
> +        if (!vm && !vext_elem_mask(v0, ci + n)) {                            \
> +            continue;                                                        \
> +        }                                                                    \
> +                                                                             \
> +        acc = *((uint##WD##_t *)vd + HD(ci + n));                            \
> +        dot_result = 0;                                                      \
> +                                                                             \
> +        for (k = 0; k < vl; k++) {                                           \
> +            uint##WD##_t b = *((T2 *)vs2 + n * stride + HS(k));              \
> +            if (altfmt) {                                                    \
> +                a = *((int##W1##_t *)vs1 + HS(k));                           \
> +            } else {                                                         \
> +                a = *((uint##W1##_t *)vs1 + HS(k));                          \
> +            }                                                                \
> +            dot_result += (a * b);                                           \
> +        }                                                                    \
> +                                                                             \
> +        *((uint##WD##_t *)vd + HD(ci + n)) = acc + dot_result;               \
> +    }                                                                        \
> +                                                                             \
> +    env->vstart = 0;                                                         \
> +                                                                             \
> +    if (ci + 8 < total_elems) {                                              \
> +        if (vta_all_1s) {                                                    \
> +            vext_set_elems_1s(vd, vta,                                       \
> +                              (ci + 8) * sizeof(int##WD##_t),                \
> +                              total_elems * sizeof(int##WD##_t));            \
> +        }                                                                    \
> +    }                                                                        \
> +}
> +
> +GEN_VEXT_ZVBDOTA_INT(vqwbdotau_vv_b, 32, 8, uint8_t, H4, H1)
> +GEN_VEXT_ZVBDOTA_INT(vqwbdotas_vv_b, 32, 8, int8_t, H4, H1)
> -- 
> 2.56.0
> 
> 
> 

Sent using hkml (https://github.com/sjp38/hackermail)

