Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A290606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 06:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=TjZcZQg5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR2BI-0005NT-Ic; Wed, 11 Nov 2026 01:51:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xR2BB-0005Hm-HS; Wed, 11 Nov 2026 01:51:34 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xR2B7-0006QW-V1; Wed, 11 Nov 2026 01:51:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b1Cen0fAKq0/LXeeEB9puYnoDqI/YrwXEgfCGarFOn3XllGDWA4s6PexN259NfJp6x3dRzDjr0JTriQZtRx/PPk0AM3dad2Eyr0zt3PUY9zKfDJX4knsueTVmFa/V+lc/AX5Uq1VbkOQUMfQV8uvfv6sisvQstROsktYwaEzAafhpAbXV3abYuIgeLBhRK7nIGhnChnO8sywDmaLTNgPqN8lHkMrUyzhbhsmE6HRIUrHXnj78GzvlPEitB01DE+BpjoJA/8nvrVRRL2UICawA44XKhzQPggnQoVuDSWeOI/DmgTcr0oeVpKWRxZJWG94Kd6Knch/fgioM+qCFYNJlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kk3BaOetq/YR5v45dKG7etGEMyAftz71nPZ4TEn/Oqk=;
 b=qktI1Y/gfq6vrdPWDw9UlDKEQiqekMz/8A6HDfWv5t1F3Ef/K1jutHE6J4n2xeV1S2RCIZO7Fa4lsS5r+A/tlcknzHRG4bqQmsY2TzKyj8JkHG2sQJYJG5YFciAAHzyPlF7fZ26SwHAwNQun8cUoaIHp6OBzAVqViNSN0UakxnRws6RTiLHONN7sKWc5LW1spvmChtyHlJME8wNlB1lfN2/UYk/l1MDoLIcNdGEcZBi0L8Q4XaOBOH6xv50PHLN6syfC3TRpivXHYsVKPMga4Y20jLZs6zzWBnqF0bSek/1HAHaNYgR/tpmDCT3FaFoDUlu+FBjOWvGu95zFp+FC/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kk3BaOetq/YR5v45dKG7etGEMyAftz71nPZ4TEn/Oqk=;
 b=TjZcZQg5YqAcJZzF2Z3RiUgsJRdWGhFD/AcuQHX6B3BG7F+Nm0tW/qW/s0gdkzh+arUlqI/MbPkAH8w+XF+W2zzVq8PWu4EE7MSWu7PuBV1ylVu5tnD0IFjDyeUxOq6QWTJwrPzmFoWGa8n6rCgkG74qrn0W5zbl9TgYg1mVybnrwkro1DxEfG5xt98pNKlV+JE/BL2ZzIvmZosyMyyi5+fzaog+ufIkltVCtZH31RVuFbXbkUcHWhCPglm/fo4C8vpRVJ/1wFxh2UNug7z6VNh2GK1+EigomSrJHMgArMDOAbDNr6tBnGn9zjDHZGrvU9HXSIeibWLFkYTQIVtDbw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by SI2PR02MB5611.apcprd02.prod.outlook.com (2603:1096:4:1aa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 06:51:23 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 06:51:23 +0000
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
Subject: Re: [RFC PATCH 17/38] target/riscv: rvv: Implement Zvfqwdota8f
 instructions
Date: Wed, 11 Nov 2026 14:51:03 +0800
Message-ID: <20261111065104.36477-1-chao.liu@processmission.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104194155.679241-18-max.chou@sifive.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0038.namprd07.prod.outlook.com
 (2603:10b6:510:e::13) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|SI2PR02MB5611:EE_
X-MS-Office365-Filtering-Correlation-Id: 308d70c0-5550-40fb-7545-08df3fc0331b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|366016|1800799024|10067099003|56012099006|261021121427099003|261022105027099003|261022075727099003|261009223027099003|261026121527099003|261028144727099003|261102123227099003|261026140227099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: QU9eq24u9C+bOB4Q3trwSkvLTBDltgDon1eM8364YVU+0/D3xY2zVbYVXxGldKIfmTxLagBVT0/9NqyecjS5QZr+/Iai6zpMuGPJeZoX+MYFlgd+zPqaIvHrRxgMgJ2VL7NBmyUtRqkvchP4k5Yl+fzMfkQQjvWG+NpCF2HvargWeaxnqe6MGi891eXaK1RrmiGY6JnbNfuoGGilwK2eLo5qmnG7RbNZVXwQ42GRV90EfLJOjX0F7DOVwfDcVhy0oJiWHRvqtUXBlQNl1BtzjERO3eo8DVwAL9x1QUrEFTw50I0Eyu1ltPVklVwpF0o8F0dh7NP0LBSmHt8KZZlWYCcUw73NkERplfxB+i6kRZqRwx6H945ek572p4jmVja/Y37kgzlCjEbU3eCyz20smbzq9nv06AZG1Bw/FFu1j25Vbi6aKKmQChx/eR0q7Fqi+lg2w9f4fOav5GVcavbefXf28H4gATwg2QTxqNS9Xzl9ly6fZYEvYBHzGpKQYE4f9vtX+YNeh3gYWattWj/7qbhom09bJ7mYyiUOT8u/VS8NZNTWHoc5NPPsJwoTGvL1AWp3HKhyhi3rflw7EBnA+1lCQMBwSCZFUkcPxlBmKyfUqbZADgoMEt3kZsmP/IB0Em2WCXIYiuowLVg1ZrN29nB+cKTizByYKD3OzDgyzmk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(10067099003)(56012099006)(261021121427099003)(261022105027099003)(261022075727099003)(261009223027099003)(261026121527099003)(261028144727099003)(261102123227099003)(261026140227099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QSP+yGh19Tr2FLqGnl6X4THhWVdvUNU+aEAm7RZ15GtQnV5LBqnLvK7RlX9h?=
 =?us-ascii?Q?jAbUBY+X1kpbSrIkVUwhrLPjealNgD69vQIiksX4Fl6H4lzlHCb/e4hn8W+N?=
 =?us-ascii?Q?N16wourc+yWDrSdHBdT+qY7dHLLpxbqxTqvFKE47E5Fp3zIq7jF3yISbCwpS?=
 =?us-ascii?Q?dyJNOkEAgAGhy1iVBr8sgKxDJ8k8zis7WNbVWu7vFvJt/TpdbLaa8VPXQbCw?=
 =?us-ascii?Q?lcoScqNhZiUVGwooyv7hNplAhAR1EQGp96mwwX+ltZ8F1e8Vlf5Qh6NCOh7Y?=
 =?us-ascii?Q?5NSsN9ne6eSd3a4Yeln/OsO3EWU3EPcCfsiqKSOWKF4hFogOMCGwEuGRcSq7?=
 =?us-ascii?Q?tQW7I2SZFN0P+N3NAKwr3ixomi5iaatl3/PTvZhjnBlfWmaoxQyZnxPUHHDX?=
 =?us-ascii?Q?WD17h8X6b5ZVp+2fts6+BVlI3TgjsRhgW7E0NFcZV5MTlV2ww3l51VLM0fs1?=
 =?us-ascii?Q?qi3yQnPNhHgl2c+21LCQoppBL884NFaHNdxNcWEtPu/eDdUY/ze0cZHIJygF?=
 =?us-ascii?Q?EYLEKjqmgOUEJZD179k69RDRzQkn9DoVidMR2DapRm6q5mVi4Y74GgHfcWK6?=
 =?us-ascii?Q?EuWyIWnpzvTrwQ7jlmCrzhTENettin+wtIFe1merwBqMbqxcdb26VvnMi3mv?=
 =?us-ascii?Q?7EuTVmy3tiuS4E7SPEP+zCRVoB2lckttvUfblZ5c4In6T6ug1+kP8LuPOpqO?=
 =?us-ascii?Q?pFZxpMzCGkP8xvI3mXs/b6hfZIb7Svo5Ofvqx4HVcTe9SZXLgsrmkivVDdnq?=
 =?us-ascii?Q?n/6zoJAAh/WWqGD9x43K4nBbodVk9OQvBo5iPZcAZvK/2hvHC/XUJyGPdFtq?=
 =?us-ascii?Q?eGr3DvfzOdcqUpfol3V7MLDuAaWhIskmjSwJF2KEjYhjhyfKu4HHQdWlWqDp?=
 =?us-ascii?Q?l8s00qGa2r6Aj7Fg7bi6xSoBbOtIPP9Iam1qf0YKknNMBKeN1sthtqA7NzpG?=
 =?us-ascii?Q?Q8tVPo/j9RjNvh0ksxVLaX/KFWK2J+8BaHeaJuF2DLhM2kYOoJv1PvJty3DC?=
 =?us-ascii?Q?lK+a+rhsGerycuhWwqu1Jhvn6EXNG0HihoZ4iWNBcHFbmouYx+mpYRjE98ED?=
 =?us-ascii?Q?n5cN+kBnbZ5Pnx8QyEIQUr4IImgNy1R528aPNo/ucJ1mlA3kx4YoSWmhgktI?=
 =?us-ascii?Q?w4EGEHbgwltYvtA5OEmM+qR6N/BURuCaB7eXa2hYTVVwRc/QEPM7khyDBTc8?=
 =?us-ascii?Q?TU3ojXNSjhQknLn+Zk1E08+OA1VtyOAYfMZO5L3s/r6ChMbgJzojVIwH2X0w?=
 =?us-ascii?Q?tnu+Mqad32SDCPGTlVzH+NUcRRWoR/6L8mhZPFPjQfn4TRVg9Qpd2iC6IvKg?=
 =?us-ascii?Q?Ck3wIUyv19tJt8V5SHPkMuYByZFaSU/XybstWkPU3OpcumR9UYq0aOswkDe+?=
 =?us-ascii?Q?wdgvZEc/DigZ2U5Ivvnqc9OJsMV9GGsdXGuygh4XDSfIg2I4T0Qp6cwzRnIq?=
 =?us-ascii?Q?Kboannc8SPIKwp5vBK3AgZXLu5jN5doIz+ePAAePD5rN+/Hy20nLikYRDc3P?=
 =?us-ascii?Q?EmZlljCJ/ybTXbeKG6mHthQUqzpu2xN9h2jrelOh/1f3gyxW2PhpUU5AVTPz?=
 =?us-ascii?Q?AT1/umHgEffMhpniEjoyygYRQVOnFRsF+Ndi4VllcvZV48rtXS31+tpM1hii?=
 =?us-ascii?Q?3IHVsS5aWmgcvhU5UA+40unkW9M+GheFSNGpSSHZQ3nojoR5y1bbJr5ed9qD?=
 =?us-ascii?Q?SS9fF5Ux1Zc9G0jnP6S1wK2WI2wwWUH1NAX4Fpn7HUVDpkTfwQ4GguYIlqa9?=
 =?us-ascii?Q?9UF9JWJHLieyIyD7Q/e4yIBk/RyPzLI=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 308d70c0-5550-40fb-7545-08df3fc0331b
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 06:51:23.5419 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MMGLRkc+dmD7gUhj9SfZ3DWflA44TP19ldNP/0bQSBfd+8n2OStuc2M4YrW0y13n37sp7cXPwl/592SD7Am6Ltvckd7mxMPHWlu0YCNHPds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR02MB5611
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=chao.liu@processmission.com;
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
X-Spam-Status: No, score=-19.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu,  5 Nov 2026 03:41:32 +0800 Max Chou <max.chou@sifive.com> wrote:

> Implements the Zvfqwdota8f OCP FP8 dot-product instructions:
> - vfqwdota.vv: vs2 is E4M3, vs1 format selected by altfmt (0=E4M3, 1=E5M2)
> - vfqwdota.alt.vv: vs2 is E5M2, vs1 format selected by altfmt (0=E4M3, 1=E5M2)
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---
>  target/riscv/helper.h                       |  5 ++
>  target/riscv/insn32.decode                  |  4 ++
>  target/riscv/tcg/insn_trans/trans_rvv.c.inc | 47 ++++++++++++++++
>  target/riscv/tcg/vector_helper.c            | 62 +++++++++++++++++++++
>  4 files changed, 118 insertions(+)
> 
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index 918ff21b3e2..48c64f45748 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -1395,6 +1395,11 @@ DEF_HELPER_6(vqwdotas_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
>  
>  /* Zvfwdota16bf - BF16 Dot Product */
>  DEF_HELPER_6(vfwdota_vv, void, ptr, ptr, ptr, ptr, env, i32)
> +
> +/* Zvfqwdota8f - OCP FP8 Dot Product */
> +DEF_HELPER_6(vfqwdota_vv, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfqwdota_alt_vv, void, ptr, ptr, ptr, ptr, env, i32)
> +
>  /* SiFive Custom int8 Matrix-Multiply */
>  DEF_HELPER_5(sf_vqmaccu_4x8x4, void, ptr, ptr, ptr, env, i32)
>  DEF_HELPER_5(sf_vqmacc_4x8x4, void, ptr, ptr, ptr, env, i32)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index d800ad99451..def5785f8e2 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -1104,3 +1104,7 @@ vqwdotas_vv  100111 . ..... ..... 000 ..... 1110111 @r_vm
>  
>  # *** Zvfwdota16bf BF16 Dot-Product Extension ***
>  vfwdota_vv  100100 . ..... ..... 001 ..... 1110111 @r_vm
> +
> +# *** Zvfqwdota8f OCP FP8 Dot-Product Extension ***
> +vfqwdota_vv     100110 . ..... ..... 001 ..... 1110111 @r_vm
> +vfqwdota_alt_vv 100111 . ..... ..... 001 ..... 1110111 @r_vm
> diff --git a/target/riscv/tcg/insn_trans/trans_rvv.c.inc b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> index c50f863ea0b..6eb22494838 100644
> --- a/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> @@ -4242,3 +4242,50 @@ static bool trans_vfwdota_vv(DisasContext *s, arg_rmrr * a)
>      }
>      return false;
>  }
> +
> +/* Zvfqwdota8f OCP FP8 Dot-Product Extension */
> +static bool vext_vfqwdota_check(DisasContext *s, arg_rmrr *a)
> +{
> +    return s->mstatus_fs != EXT_STATUS_DISABLED &&
> +           vext_zvdota_base_check(s, a) &&
> +           (s->cfg_ptr->ext_zvfqwdota8f && s->sew == MO_8);
> +}
> +
> +#define GEN_ZVDOTA_FP8_TRANS(NAME, CHECK)                               \
> +static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                  \
> +{                                                                       \
> +    if (CHECK(s, a)) {                                                  \
> +        TCGv_ptr dest, src1, src2, mask;                                \
> +        TCGv_i32 desc;                                                  \
> +        uint32_t data = 0;                                              \
> +                                                                        \
> +        gen_set_rm(s, RISCV_FRM_DYN);                                   \
> +                                                                        \
> +        data = FIELD_DP32(data, VDATA, VM, a->vm);                      \
> +        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);                  \
> +        data = FIELD_DP32(data, VDATA, VTA, s->vta);                    \
> +        data = FIELD_DP32(data, VDATA, VTA_ALL_1S, s->cfg_vta_all_1s);  \
> +                                                                        \
> +        dest = tcg_temp_new_ptr();                                      \
> +        mask = tcg_temp_new_ptr();                                      \
> +        src1 = tcg_temp_new_ptr();                                      \
> +        src2 = tcg_temp_new_ptr();                                      \
> +        desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,            \
> +                                          s->cfg_ptr->vlenb, data));    \
> +                                                                        \
> +        tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, a->rd));            \
> +        tcg_gen_addi_ptr(src1, tcg_env, vreg_ofs(s, a->rs1));           \
> +        tcg_gen_addi_ptr(src2, tcg_env, vreg_ofs(s, a->rs2));           \
> +        tcg_gen_addi_ptr(mask, tcg_env, vreg_ofs(s, 0));                \
> +                                                                        \
> +        gen_helper_##NAME(dest, mask, src1, src2, tcg_env, desc);       \
> +                                                                        \
> +        finalize_rvv_inst(s);                                           \
> +                                                                        \
> +        return true;                                                    \
> +    }                                                                   \
> +    return false;                                                       \
> +}
> +
> +GEN_ZVDOTA_FP8_TRANS(vfqwdota_vv, vext_vfqwdota_check)
> +GEN_ZVDOTA_FP8_TRANS(vfqwdota_alt_vv, vext_vfqwdota_check)
> diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
> index a4c52ed296a..5cb44326200 100644
> --- a/target/riscv/tcg/vector_helper.c
> +++ b/target/riscv/tcg/vector_helper.c
> @@ -6075,3 +6075,65 @@ void HELPER(vfwdota_vv)(void *vd, void *v0, void *vs1, void *vs2,
>          vext_set_elems_1s(vd, vta, 1 * 4, total_elems * 4);
>      }
>  }
> +
> +/*
> + * Zvfqwdota8f: OCP FP8 Dot Product with Accumulation
> + */
> +#define GEN_VEXT_ZVDOTA_FP8(NAME, TYPE_VS2)                              \
> +void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,              \
> +                  CPURISCVState *env, uint32_t desc)                     \
> +{                                                                        \
> +    uint32_t vlmax = vext_max_elems(desc, ctzl(sizeof(uint8_t)));        \
> +    uint32_t vm = vext_vm(desc);                                         \
> +    uint32_t vl = env->vl;                                               \
> +    uint32_t vta = vext_vta(desc);                                       \
> +    uint32_t vta_all_1s = vext_vta_all_1s(desc);                         \
> +    uint32_t total_elems = riscv_cpu_cfg(env)->vlenb >> 2;               \
> +    uint32_t altfmt = FIELD_EX64(env->vtype, VTYPE, ALTFMT);             \
> +    uint32_t i;                                                          \
> +    uint8_t *a_vec, *b_vec;                                              \
> +    uint32_t dot_result, acc;                                            \
> +                                                                         \
> +    VSTART_CHECK_EARLY_EXIT(env, vl);                                    \
> +                                                                         \
> +    a_vec = g_new0(uint8_t, vlmax);                                      \
> +    b_vec = g_new0(uint8_t, vlmax);                                      \
Please use g_autofree here and initialize both pointers to NULL, as Daniel
suggested in the earlier patch.

LGTM, Otherwise.


Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> +                                                                         \
> +    for (i = 0; i < vl; i++) {                                           \
> +        if (!vm && !vext_elem_mask(v0, i)) {                             \
> +            continue;                                                    \
> +        }                                                                \
> +        a_vec[i] = *((uint8_t *)vs2 + H1(i));                            \
> +        b_vec[i] = *((uint8_t *)vs1 + H1(i));                            \
> +    }                                                                    \
> +                                                                         \
> +    FloatExceptionFlags pre_fflag =                                      \
> +        get_float_exception_flags(&env->fp_status);                      \
> +    FloatSNaNRule pre_snan_rule = get_snan_rule(&env->fp_status);        \
> +    set_snan_rule(float_snan_never, &env->fp_status);                    \
> +    if (altfmt == 0) {                                                   \
> +        dot_result = rvbna_dot_float8_##TYPE_VS2##_float8_e4m3(          \
> +            a_vec, b_vec, vlmax, &env->fp_status);                       \
> +    } else {                                                             \
> +        dot_result = rvbna_dot_float8_##TYPE_VS2##_float8_e5m2(          \
> +            a_vec, b_vec, vlmax, &env->fp_status);                       \
> +    }                                                                    \
> +    set_snan_rule(pre_snan_rule, &env->fp_status);                       \
> +                                                                         \
> +    acc = *((uint32_t *)vd + H4(0));                                     \
> +    *((uint32_t *)vd + H4(0)) = rvbna_final_f32_add(dot_result, acc,     \
> +                                                    &env->fp_status);    \
> +    riscv_cpu_check_fflags(env, pre_fflag);                              \
> +                                                                         \
> +    g_free(a_vec);                                                       \
> +    g_free(b_vec);                                                       \
> +                                                                         \
> +    env->vstart = 0;                                                     \
> +                                                                         \
> +    if (vta_all_1s) {                                                    \
> +        vext_set_elems_1s(vd, vta, 1 * 4, total_elems * 4);              \
> +    }                                                                    \
> +}
> +
> +GEN_VEXT_ZVDOTA_FP8(vfqwdota_vv, e4m3)
> +GEN_VEXT_ZVDOTA_FP8(vfqwdota_alt_vv, e5m2)
> -- 
> 2.56.0
> 
> 
> 

Sent using hkml (https://github.com/sjp38/hackermail)

