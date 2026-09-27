Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EDABC9832F
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 12:02:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAna2-00084P-Us; Sun, 27 Sep 2026 08:02:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xAnZl-0007lb-9l; Sun, 27 Sep 2026 08:01:53 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xAnZf-00008M-LL; Sun, 27 Sep 2026 08:01:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tCo1IbKLetRv9amFpFEFgl7gF6tTP4vl6qGqSo+WAfXjjg9wI4OHMl+a+a1BDrcfKJNbICgvSaTVVwbag0U8TJxwswH6tUPi1OgIgWqI+NsjWPJpXBGa9OAO3avVMqVo2Tcw/GAD9/fspRAyVExunq9D28GZ7Nj3rso8JZL9LEKtR++WAKz91mugRM8CqzKw7YQBOyt67lPQtv5ONZweEEkT0RTVWtm4PyMVEJXqGm3bXAMXGV28DWsHSF5V/0BGTrau3L8fDZgyYrrJhBkzf3AtdkGkIdo4Flaa9OhvTjTm/d1lVU64ejuIlXDMb0JwlRCujHnj91jgMSWwaSPWAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qSbDm6zs6osy1vC1q7SnKVrkI4aasNet73y1bfqmZoE=;
 b=x+F3HzOI3bzoqvow13MyAART2yMsD/DkrUbyLPHxFJaIm5VywJ3CnE+GoZhbl+DjzgY3nbontfgbWcismAtD96q7QzqDFYsDpfGGdKX4FfAFPsDX9c1GUvP95s2uOFKC8ys49otGiPrFFG0gW1w4rn5KweEAG71D0484EsQhYfeYvy7rEh7nCNcX/AdfUnFMBHguYFw2lNsl59F1rmgn6bD4YQlt5Q53zwmtnyhhSFkY4d3sIlIc3eMTst+2YQU7ftouq7AFHj585d0eo35GoCd6/UA0Jly+HamctGHkuoyqibDkpzgyv7JzTKZPRmQDMhrvZSmAJeCn8LvcFkaYiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSbDm6zs6osy1vC1q7SnKVrkI4aasNet73y1bfqmZoE=;
 b=BX4Qe+qnfui7Y2yYW6FR/SHvfxW4BcWW4t1TWdLCFv0SqcfrUwzjaYQH6UA1iiCyYwiMj1+iQ8bUcG3tCvq4KUS2hffu9KeTZw1N9HchaJQAJviOpTpXT3YC09N9aQ0Hpx06PWcK2pGv9JGMIivRuQJpDswi+UhmWNMl5rBVVNKxb20iZJ+CLkhXgbJAzbG0rFgPO6HDgBagHrtQGbL/qOFy9aoLGakwqBfmCvXXHEdUdiMsT31+cdfejz8yKLnGCvgQ9OacCy9URuljd4rGUanoy6pUvsAlw0q4goR0+y2LeJeiPwoLM5Zm2wCZcy83r5rYWv13Is9Vl+GWrf0OYQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KUXPR02MB9336.apcprd02.prod.outlook.com (2603:1096:d10:a3::10)
 by KL1PR02MB7331.apcprd02.prod.outlook.com (2603:1096:820:11b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Sun, 27 Sep
 2026 12:01:36 +0000
Received: from KUXPR02MB9336.apcprd02.prod.outlook.com
 ([fe80::1451:cb49:7950:b10d]) by KUXPR02MB9336.apcprd02.prod.outlook.com
 ([fe80::1451:cb49:7950:b10d%5]) with mapi id 15.21.0451.022; Sun, 27 Sep 2026
 12:01:36 +0000
Date: Sun, 27 Sep 2026 20:01:29 +0800
From: Chao Liu <chao.liu@processmission.com>
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Frank Chang <frank.chang@sifive.com>
Subject: Re: [PATCH v4 4/6] target/riscv: rvv: Add SiFive custom int8 matmul
 instructions
Message-ID: <arkFkoClGv_lVBzB@MacBook-Pro-4.local>
References: <20260927082534.3228237-1-max.chou@sifive.com>
 <20260927082534.3228237-5-max.chou@sifive.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260927082534.3228237-5-max.chou@sifive.com>
X-ClientProxiedBy: PH7P221CA0017.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:32a::32) To KUXPR02MB9336.apcprd02.prod.outlook.com
 (2603:1096:d10:a3::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KUXPR02MB9336:EE_|KL1PR02MB7331:EE_
X-MS-Office365-Filtering-Correlation-Id: 28a67e9f-0e6c-4d9a-2676-08df1c8f149f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|22082099003|18002099003|3023799007|56012099006|260925021311599003|260925021911599003|260925022911599003|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info: boibMeCqgPFvT59itqcvoYnXmM+kzOEBZDQQ6J1wlHz/sEW+SvDOMxNEzdgIXWETx2K32od/ArY4S1wsQfMnwFJUw+ICQef5cLpbU2L2usfgn2xURdYeX8uSN+ogDoyP1jHeXgoU0dwDvYpjkDyEKJLgGTCk/Tr/hpiONwovBF+yvBB2w8NiS2qiNPiDz6J8CibVOZTSVNkLT20ExlZ3GZDtBO87xeEI0h8hZd9tm+DimY4+GThsRgIl84V5V4cPuk1yZYmfIp5t8ZenlM8IWfNTM+2FO2OpHWnfSqRb2NKd7MDWDFQdF4nXht1Cdmd/QvTrDqPp1mFiAZmt3q9QcmqYoHG5XiSwILoulj4QDXou3dhV8HBmnw+0Xbb80lOy62cyvX2y5UQod6EYvFSYKmHVN2HsV9xI5SPQXgNQHdZV3AKXZM9BvMG2Ql/4DBQ9oGQE2tExM3sV5WBw2Cu3coMip7Skpwfj4sbKlXq5gc9aYjGHkq4Eny3CwUAG2QnXRLwT4f0nU/V5/ym7ECjP2WGEBziir551tTvSkWdrYlgI+Gg0xsIfOiSAxjjYCETd91AmzKXzuY7P+jQQgLK7AXzXtXVHX+5P3aqqPn/L78sRjdu3zX+l82YhrYgpo+CemGjIg4re5rDC10108a79HvFC9zhlIT0U1VWMQhq+2Kk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KUXPR02MB9336.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(3023799007)(56012099006)(260925021311599003)(260925021911599003)(260925022911599003)(10067099003)(4143699003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d1GI+NRQz4xtgh34JCDMUONtiBa4adpdNisftoWSRgr8rMo1dmvVWcWpysxZ?=
 =?us-ascii?Q?P5XvCuUVauUgw0ibzwG7koLbCieCoQEyVKT48t9ufzMPfLuogN8oVU6W3DRz?=
 =?us-ascii?Q?takYWHFb3FtPSlQ4AcjFqB3vdL/m4F10tYNThCkVYcxLvs/KB7QBPLe9bWzu?=
 =?us-ascii?Q?SrVIVZQ5rli1cEQ7Zq96FId+N4D0b0MRb28d/ml/HalfdbVvM6lIshlNbzFv?=
 =?us-ascii?Q?GbpJOOW57qheAtvwy6oUctnasIYP2eZQm/2F8qquTpQAdFcf3SBQvg+L50ik?=
 =?us-ascii?Q?tVXli0mJcHmoBivD6DIlzJTDZAWVoidLGc+k1bsddYzydQZQNACqnLB/GWSM?=
 =?us-ascii?Q?NCiqDzF+u/l4ffV7Mh5ezxg18534dDJ/g/5GVZElKQDwPgfGXNrF6cti93mv?=
 =?us-ascii?Q?e5dvt58ElFaX38QVPAoffTHgPbA7wcYv9KHgdytokb/yKC7qTkhXjX3CCznH?=
 =?us-ascii?Q?BHVzVxO7QqCuIhoHf/QxsUWOhQ1oEdeJ+0sRDkV+7LDa3ghcuX0nxFCKYi6h?=
 =?us-ascii?Q?Jc4panBl+C0NaywJ4uYYRcvKFVT3B+wmRw2kGeATrwx9wV82R0Bl1Raq9R9Z?=
 =?us-ascii?Q?B6NJYRerhfYPpJLEUTfg08xa/wxBEqh9FJIfwNmDx9SvfF/EOy+walpkozIj?=
 =?us-ascii?Q?jH882I0kc5coUuqu2/38KSEYKrmaNTMUpbJco6vQR02tcMV5O2y9x/JWA5xX?=
 =?us-ascii?Q?5vW4+VQrprp0iwR2P1MoykfZsMd+LkCx3Du7e5lUNE9hdR0X2re4tD+GYJyu?=
 =?us-ascii?Q?KzOi+7BzL/RpE+sgjwQ+ubN100AT7tbU02U0Ok7HMM8X3Aqm9eF0AqrdWJBD?=
 =?us-ascii?Q?FdNar7KaW+2FulhOr5PGBF0uphJjPW2G7oMJXt+ka6c5A+PgZq1OtS85kJKb?=
 =?us-ascii?Q?eJQHuN8qgm2LYPfxU3Lj6Wjp59xf5Ep3wYRQAeDnL0xKRkxacoKXlJyGrqeh?=
 =?us-ascii?Q?tSyrfY07viSMoIQB2AujkpLJCa7L2OtAoFtRNLhvDGy/lbVareO3t+Amfkyg?=
 =?us-ascii?Q?hO3cwrPlqLDjT9f5OUHP81qF08BklkRyYLhAbQ8AoYfB/J8iU9wkzIdxKCSd?=
 =?us-ascii?Q?gfiNF23i9RPFKdvdalqClIj2qW2PCBQiktxH1D7gIdRqJTWfFBvMnW5clLjg?=
 =?us-ascii?Q?V4LB85sGhvJlYWGLxeKisW31Wqd3QYVkzLs5dQAF+O2GCymRwHD/HrYPuL/d?=
 =?us-ascii?Q?/WGwPEn+pLenBRE5ocRQQJfRyOEo0T63Eso4VwJJ0rY5Q1oCNYjoCwRjhglz?=
 =?us-ascii?Q?e3yVuKomHxH1BeV2fvGp6s1KYJ5yk31EbC1gjnJQnhyOp1l2gAfwPqCubs9w?=
 =?us-ascii?Q?z+bAJlOr31fcm2+em6hPCbV7NELxwE3/Xza4QXylH7UNlg5KsxKV3UUvg8Fl?=
 =?us-ascii?Q?EvCVUiArh4e67s9ZcrKyDOQ8Bd2kMeBrgZI/X+vXDFrzY1a/TdqOxXYRYglZ?=
 =?us-ascii?Q?gEZ7T7PpPr/+ZYOOd16vvNM7LqevAm9k9qOBcHu8qheAAVnIh5HUBqRt0tre?=
 =?us-ascii?Q?xb3AuLZ/9QTDojH9s3znEeTXU2nBPdLqtc0wtsJu1EMRAIHHLDcxQvuIq/8b?=
 =?us-ascii?Q?R6gOuaCwIxa2cK4G8kGINRXxUcdzOCc/5fSYrs1GGGY9AwMDtOdw5JUkChOR?=
 =?us-ascii?Q?GQRacE9PhWND4CQNEB1mbrtdANaOL3y92cKWDwi/cSD7xC5Cq3TyhF1/CqR6?=
 =?us-ascii?Q?28xy5I9iTji5E8vS3u3MJv+dl/h8Q2Djb5oxSZfPZ/mVuiDjkNUsCjEKdF5C?=
 =?us-ascii?Q?fzLWrTinbhJc5EuMXi3fwv5DvKedZB4=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28a67e9f-0e6c-4d9a-2676-08df1c8f149f
X-MS-Exchange-CrossTenant-AuthSource: KUXPR02MB9336.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2026 12:01:36.5942 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bl5Qej6JtdfwO5iB8MZ9+Q9S8X9e7WvidZS1A6EoR8K4dvwJG/+LSnCtgac5tlTTqGKYkUdo6qdyaFZRrPCZNxYMnyTV6twmkl16xJ8He+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB7331
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=chao.liu@processmission.com;
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sun, Sep 27, 2026 at 04:25:32PM +0800, Max Chou wrote:
> From: Frank Chang <frank.chang@sifive.com>
> 
> Add the 8 SiFive custom int8 matrix-multiply vector instructions:
> sf.vqmacc{u,,us,su}.4x8x4 and sf.vqmacc{u,,us,su}.2x8x2. Each name
> suffix encodes the signedness of vs1/vs2.
> The 4x8x4 forms multiply-accumulate a 4x8 by 8x4 int8 tile into a
> 4x4 int32 result; the 2x8x2 forms use a 2x8 by 8x2 tile producing a
> 2x2 int32 result. Both Xsfvqmaccqoq/Xsfvqmaccdod extensions are
> gated on vlenb >= 32, sew == 8 and vm == 1, per the SiFive Int8
> Matrix Multiplication Extensions Specification.
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
>  MAINTAINERS                                 |  8 ++
>  target/riscv/cpu_cfg.h                      |  5 ++
>  target/riscv/helper.h                       | 10 +++
>  target/riscv/meson.build                    |  1 +
>  target/riscv/tcg/insn_trans/trans_xsf.c.inc | 98 +++++++++++++++++++++
>  target/riscv/tcg/meson.build                |  1 +
>  target/riscv/tcg/translate.c                |  3 +
>  target/riscv/tcg/xsf_helper.c               | 87 ++++++++++++++++++
>  target/riscv/xsf.decode                     | 30 +++++++
>  9 files changed, 243 insertions(+)
>  create mode 100644 target/riscv/tcg/insn_trans/trans_xsf.c.inc
>  create mode 100644 target/riscv/tcg/xsf_helper.c
>  create mode 100644 target/riscv/xsf.decode
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 43d5d3715e4..a3a8199840f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -399,6 +399,14 @@ F: target/riscv/XVentanaCondOps.decode
>  F: target/riscv/insn_trans/trans_xventanacondops.c.inc
>  F: disas/riscv-xventana*
>  
> +RISC-V SiFive (Xsf*) extensions
> +M: Max Chou <max.chou@sifive.com>
> +L: qemu-riscv@nongnu.org
> +S: Supported
> +F: target/riscv/xsf.decode
> +F: target/riscv/tcg/insn_trans/trans_xsf.c.inc
> +F: target/riscv/tcg/xsf_helper.c
> +
>  RENESAS RX CPUs
>  R: Yoshinori Sato <yoshinori.sato@nifty.com>
>  S: Orphan
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index 211d0708ba4..d6db1cfb7cc 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -51,6 +51,11 @@ static inline bool has_xthead_p(const RISCVCPUConfig *cfg)
>             cfg->ext_xtheadmempair || cfg->ext_xtheadsync;
>  }
>  
> +static inline bool has_xsf_p(const RISCVCPUConfig *cfg)
> +{
> +    return cfg->ext_xsfvqmaccdod || cfg->ext_xsfvqmaccqoq;
> +}
> +
>  #define MATERIALISE_EXT_PREDICATE(ext) \
>      static inline bool has_ ## ext ## _p(const RISCVCPUConfig *cfg) \
>      { \
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index aab92bf132a..43ef6b3ff92 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -1362,3 +1362,13 @@ DEF_HELPER_FLAGS_3(sc_probe_write, TCG_CALL_NO_WG, void, env, tl, tl)
>  /* Invalidate reservations overlapping a completed linux-user store. */
>  DEF_HELPER_3(riscv_invalidate_reservations, void, env, tl, tl)
>  #endif
> +
> +/* SiFive Custom int8 Matrix-Multiply */
> +DEF_HELPER_5(sf_vqmaccu_4x8x4, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(sf_vqmacc_4x8x4, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(sf_vqmaccus_4x8x4, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(sf_vqmaccsu_4x8x4, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(sf_vqmaccu_2x8x2, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(sf_vqmacc_2x8x2, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(sf_vqmaccus_2x8x2, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(sf_vqmaccsu_2x8x2, void, ptr, ptr, ptr, env, i32)
> diff --git a/target/riscv/meson.build b/target/riscv/meson.build
> index e1b51d2bd4d..da1df1e74e6 100644
> --- a/target/riscv/meson.build
> +++ b/target/riscv/meson.build
> @@ -6,6 +6,7 @@ gen = [
>    decodetree.process('XVentanaCondOps.decode', extra_args: '--static-decode=decode_XVentanaCodeOps'),
>    decodetree.process('xmips.decode', extra_args: '--static-decode=decode_xmips'),
>    decodetree.process('xlrbr.decode', extra_args: '--static-decode=decode_xlrbr'),
> +  decodetree.process('xsf.decode', extra_args: '--static-decode=decode_xsf'),
>  ]
>  
>  riscv_ss = ss.source_set()
> diff --git a/target/riscv/tcg/insn_trans/trans_xsf.c.inc b/target/riscv/tcg/insn_trans/trans_xsf.c.inc
> new file mode 100644
> index 00000000000..1677352689f
> --- /dev/null
> +++ b/target/riscv/tcg/insn_trans/trans_xsf.c.inc
> @@ -0,0 +1,98 @@
> +/*
> + * RISC-V translation routines for the SiFive vendor extensions (xsf*)
> + *
> + * Copyright (c) 2023 SiFive, Inc.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +
> +/*
> + * SiFive Xsfvqmaccdod/Xsfvqmaccqoq custom int8 matrix-multiply extensions
> + */
> +static bool sf_int8_matmul_check(DisasContext *s, arg_rmrr *a)
> +{
> +    return require_rvv(s) &&
> +           vext_check_isa_ill(s) &&
> +           s->vstart_eq_zero &&
> +           (s->cfg_ptr->vlenb >= 32) &&
> +           (s->sew == MO_8) &&
> +           (a->vm == 1);
> +}
> +
> +static bool sf_int8_matmul_4x8x4_check(DisasContext *s, arg_rmrr *a)
> +{
> +    /*
> +     * vd  has EMUL=2*LMUL
> +     * vs2 has EMUL=LMUL
> +     * vs1 has EMUL=1
> +     * vd must not overlap vs1
> +     */
> +    return sf_int8_matmul_check(s, a) &&
> +           (s->cfg_ptr->ext_xsfvqmaccqoq) &&
> +           (s->lmul <= 2) &&
> +           require_align(a->rd, s->lmul + 1) &&
> +           require_align(a->rs2, s->lmul) &&
> +           require_align(a->rs1, 0) &&
> +           require_noover(a->rd, s->lmul + 1, a->rs2, s->lmul) &&
> +           !is_overlapped(a->rd, 1 << MAX(s->lmul + 1, 0), a->rs1, 1);
> +}
> +
> +static bool sf_int8_matmul_2x8x2_check(DisasContext *s, arg_rmrr *a)
> +{
> +    /*
> +     * vd  has EMUL=LMUL
> +     * vs2 has EMUL=LMUL
> +     * vs1 has EMUL=1
> +     * vd must not overlap vs1
> +     */
> +    return sf_int8_matmul_check(s, a) &&
> +           (s->cfg_ptr->ext_xsfvqmaccdod) &&
> +           require_align(a->rd, s->lmul) &&
> +           require_align(a->rs2, s->lmul) &&
> +           require_align(a->rs1, 0) &&
> +           !is_overlapped(a->rd, 1 << MAX(s->lmul, 0), a->rs1, 1);
> +}
> +
> +static bool sf_int8_matmul_op(DisasContext *s, arg_rmrr *a, uint8_t seq)
> +{
> +    static gen_helper_gvec_3_ptr * const fns[8] = {
> +        gen_helper_sf_vqmaccu_4x8x4, gen_helper_sf_vqmacc_4x8x4,
> +        gen_helper_sf_vqmaccus_4x8x4, gen_helper_sf_vqmaccsu_4x8x4,
> +        gen_helper_sf_vqmaccu_2x8x2, gen_helper_sf_vqmacc_2x8x2,
> +        gen_helper_sf_vqmaccus_2x8x2, gen_helper_sf_vqmaccsu_2x8x2,
> +    };
> +
> +    /*
> +     * The helper raises an illegal-instruction exception when vl is not a
> +     * multiple of the tile size; save the opcode so mtval/stval report the
> +     * faulting instruction if that exception is thrown.
> +     */
> +    decode_save_opc(s, 0);
> +
> +    tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, a->rs1),
> +                       vreg_ofs(s, a->rs2), tcg_env,
> +                       s->cfg_ptr->vlenb, s->cfg_ptr->vlenb, 0, fns[seq]);
> +
> +    finalize_rvv_inst(s);
> +
> +    return true;
> +}
> +
> +#define GEN_SF_INT8_MATMUL_TRANS(NAME, CHECK, SEQ)       \
> +static bool trans_##NAME(DisasContext *s, arg_rmrr *a)   \
> +{                                                        \
> +    if (CHECK(s, a)) {                                   \
> +        return sf_int8_matmul_op(s, a, SEQ);             \
> +    }                                                    \
> +    return false;                                        \
> +}
> +
> +GEN_SF_INT8_MATMUL_TRANS(sf_vqmaccu_4x8x4,  sf_int8_matmul_4x8x4_check, 0)
> +GEN_SF_INT8_MATMUL_TRANS(sf_vqmacc_4x8x4,   sf_int8_matmul_4x8x4_check, 1)
> +GEN_SF_INT8_MATMUL_TRANS(sf_vqmaccus_4x8x4, sf_int8_matmul_4x8x4_check, 2)
> +GEN_SF_INT8_MATMUL_TRANS(sf_vqmaccsu_4x8x4, sf_int8_matmul_4x8x4_check, 3)
> +GEN_SF_INT8_MATMUL_TRANS(sf_vqmaccu_2x8x2,  sf_int8_matmul_2x8x2_check, 4)
> +GEN_SF_INT8_MATMUL_TRANS(sf_vqmacc_2x8x2,   sf_int8_matmul_2x8x2_check, 5)
> +GEN_SF_INT8_MATMUL_TRANS(sf_vqmaccus_2x8x2, sf_int8_matmul_2x8x2_check, 6)
> +GEN_SF_INT8_MATMUL_TRANS(sf_vqmaccsu_2x8x2, sf_int8_matmul_2x8x2_check, 7)
> diff --git a/target/riscv/tcg/meson.build b/target/riscv/tcg/meson.build
> index a05ab642f41..86805b30cbc 100644
> --- a/target/riscv/tcg/meson.build
> +++ b/target/riscv/tcg/meson.build
> @@ -15,6 +15,7 @@ riscv_ss.add(files(
>    'vcrypto_helper.c',
>    'vector_helper.c',
>    'vector_internals.c',
> +  'xsf_helper.c',
>    'zce_helper.c'))
>  
>  
> diff --git a/target/riscv/tcg/translate.c b/target/riscv/tcg/translate.c
> index cce3b6dc721..f88997c859c 100644
> --- a/target/riscv/tcg/translate.c
> +++ b/target/riscv/tcg/translate.c
> @@ -1246,10 +1246,12 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
>  #include "decode-xthead.c.inc"
>  #include "decode-xmips.c.inc"
>  #include "decode-xlrbr.c.inc"
> +#include "decode-xsf.c.inc"
>  #include "insn_trans/trans_xthead.c.inc"
>  #include "insn_trans/trans_xventanacondops.c.inc"
>  #include "insn_trans/trans_xmips.c.inc"
>  #include "insn_trans/trans_xlrbr.c.inc"
> +#include "insn_trans/trans_xsf.c.inc"
>  
>  /* Include the auto-generated decoder for 16 bit insn */
>  #include "decode-insn16.c.inc"
> @@ -1270,6 +1272,7 @@ const RISCVDecoder decoder_table[] = {
>      { has_xthead_p, decode_xthead},
>      { has_XVentanaCondOps_p, decode_XVentanaCodeOps},
>      { has_xlrbr_p, decode_xlrbr},
> +    { has_xsf_p, decode_xsf },
>  };
>  
>  const size_t decoder_table_size = ARRAY_SIZE(decoder_table);
> diff --git a/target/riscv/tcg/xsf_helper.c b/target/riscv/tcg/xsf_helper.c
> new file mode 100644
> index 00000000000..6e953d12493
> --- /dev/null
> +++ b/target/riscv/tcg/xsf_helper.c
> @@ -0,0 +1,87 @@
> +/*
> + * RISC-V translation helpers for the SiFive vendor extensions (xsf*)
> + *
> + * Copyright (c) 2023 SiFive, Inc.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "cpu.h"
> +#include "exec/helper-proto.h"
> +#include "internals.h"
> +#include "vector_internals.h"
> +
> +#define QOP_SUU_B int32_t, uint8_t, uint8_t, int32_t, int32_t
> +#define QOP_SUS_B int32_t, uint8_t, int8_t, int32_t, int32_t
> +#define QOP_SSU_B int32_t, int8_t, uint8_t, int32_t, int32_t
> +#define QOP_SSS_B int32_t, int8_t, int8_t, int32_t, int32_t
> +
> +/* SiFive Custom int8 Matrix-Multiply */
> +/*
> + * vd may overlap vs2, we need to allocate an additional vd array
> + * to save temporary results of vd and write them back at the end.
> + */
> +#define GEN_VEXT_SF_INT8_MATMUL(NAME, TD, T1, T2, TX1, TX2,           \
> +                                HD, HS1, HS2, ROWS, COLS, TILE_SIZE)  \
> +void HELPER(NAME)(void *vd, void *vs1, void *vs2,                     \
> +                  CPURISCVState *env, uint32_t desc)                  \
> +{                                                                     \
> +    int it, il, in, im, ivd, ivs1, ivs2;                              \
> +    TD *vds;                                                          \
> +                                                                      \
> +    if (env->vl % TILE_SIZE) {                                        \
> +        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC()); \
> +        return;                                                       \
> +    }                                                                 \
> +                                                                      \
> +    VSTART_CHECK_EARLY_EXIT(env, env->vl);                            \
> +                                                                      \
> +    vds = g_malloc0(sizeof(TD) *                                      \
> +                    ROWS * ROWS * (env->vl / TILE_SIZE));             \
> +                                                                      \
> +    for (it = 0; it < (env->vl / TILE_SIZE); it++) {                  \
> +        for (il = 0; il < ROWS; il++) {                               \
> +            for (in = 0; in < ROWS; in++) {                           \
> +                ivd = ROWS * ROWS * it + ROWS * il + in;              \
> +                vds[ivd] = *((TD *)vd + HD(ivd));                     \
> +                for (im = 0; im < COLS; im++) {                       \
> +                    ivs1 = il * COLS + im;                            \
> +                    ivs2 = TILE_SIZE * it + im * ROWS + in;           \
> +                    T1 s1 = *((T1 *)vs1 + HS1(ivs1));                 \
> +                    T2 s2 = *((T2 *)vs2 + HS2(ivs2));                 \
> +                    vds[ivd] += (TX1)s1 * (TX2)s2;                    \
> +                }                                                     \
> +            }                                                         \
> +        }                                                             \
> +    }                                                                 \
> +                                                                      \
> +    for (it = 0; it < (env->vl / TILE_SIZE); it++) {                  \
> +        for (il = 0; il < ROWS; il++) {                               \
> +            for (in = 0; in < ROWS; in++) {                           \
> +                ivd = ROWS * ROWS * it + ROWS * il + in;              \
> +                *((TD *)vd + HD(ivd)) = vds[ivd];                     \
> +            }                                                         \
> +        }                                                             \
> +    }                                                                 \
> +                                                                      \
> +    env->vstart = 0;                                                  \
> +    g_free(vds);                                                      \
> +}
> +
> +RVVCALL(GEN_VEXT_SF_INT8_MATMUL, sf_vqmaccu_4x8x4, QOP_SUU_B, H4, H1, H1,
> +        4, 8, 32)
> +RVVCALL(GEN_VEXT_SF_INT8_MATMUL, sf_vqmacc_4x8x4, QOP_SSS_B, H4, H1, H1,
> +        4, 8, 32)
> +RVVCALL(GEN_VEXT_SF_INT8_MATMUL, sf_vqmaccus_4x8x4, QOP_SUS_B, H4, H1, H1,
> +        4, 8, 32)
> +RVVCALL(GEN_VEXT_SF_INT8_MATMUL, sf_vqmaccsu_4x8x4, QOP_SSU_B, H4, H1, H1,
> +        4, 8, 32)
> +RVVCALL(GEN_VEXT_SF_INT8_MATMUL, sf_vqmaccu_2x8x2, QOP_SUU_B, H4, H1, H1,
> +        2, 8, 16)
> +RVVCALL(GEN_VEXT_SF_INT8_MATMUL, sf_vqmacc_2x8x2, QOP_SSS_B, H4, H1, H1,
> +        2, 8, 16)
> +RVVCALL(GEN_VEXT_SF_INT8_MATMUL, sf_vqmaccus_2x8x2, QOP_SUS_B, H4, H1, H1,
> +        2, 8, 16)
> +RVVCALL(GEN_VEXT_SF_INT8_MATMUL, sf_vqmaccsu_2x8x2, QOP_SSU_B, H4, H1, H1,
> +        2, 8, 16)
> diff --git a/target/riscv/xsf.decode b/target/riscv/xsf.decode
> new file mode 100644
> index 00000000000..bb585046ab1
> --- /dev/null
> +++ b/target/riscv/xsf.decode
> @@ -0,0 +1,30 @@
> +#
> +# RISC-V translation routines for the SiFive vendor extensions
> +#
> +# Copyright (c) 2023 SiFive, Inc.
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +# Fields:
> +%rs2       20:5
> +%rs1       15:5
> +%rd        7:5
> +%vm        25:1
> +
> +# Argument sets:
> +&rmrr      vm rd rs1 rs2                           !extern
> +
> +# Formats:
> +@r_vm_1    ......  . ..... ..... ... ..... ....... &rmrr vm=1 %rs2 %rs1 %rd
> +
> +# *** Xsfvqmaccqoq: SiFive custom int8 matrix-multiply (4x8x4 tile) ***
> +sf_vqmaccu_4x8x4    111100 1 ..... ..... 010 ..... 1011011 @r_vm_1
> +sf_vqmacc_4x8x4     111101 1 ..... ..... 010 ..... 1011011 @r_vm_1
> +sf_vqmaccus_4x8x4   111110 1 ..... ..... 010 ..... 1011011 @r_vm_1
> +sf_vqmaccsu_4x8x4   111111 1 ..... ..... 010 ..... 1011011 @r_vm_1
> +
> +# *** Xsfvqmaccdod: SiFive custom int8 matrix-multiply (2x8x2 tile) ***
> +sf_vqmaccu_2x8x2    101100 1 ..... ..... 010 ..... 1011011 @r_vm_1
> +sf_vqmacc_2x8x2     101101 1 ..... ..... 010 ..... 1011011 @r_vm_1
> +sf_vqmaccus_2x8x2   101110 1 ..... ..... 010 ..... 1011011 @r_vm_1
> +sf_vqmaccsu_2x8x2   101111 1 ..... ..... 010 ..... 1011011 @r_vm_1
> -- 
> 2.43.0
> 

