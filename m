Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511D0606A320
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 05:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=hUpKYZOT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR11c-0006qZ-JL; Wed, 11 Nov 2026 00:37:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xR11a-0006pI-6P; Wed, 11 Nov 2026 00:37:34 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xR11X-00043h-NA; Wed, 11 Nov 2026 00:37:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pa9O/Sf8FagN4GnlOCCCcowWQJIw6ybBc8fmwXik31zkqpsAsFYsuVRdhpQI7XKC96LjuY/iGgymctlZLbCfU+PorRukdjMJIXKx8jfijE7BJFPz0iV1rkKp2OHCu3wpzRg4HiGjTPS4xC9gHSzxLN49c0wwDhnbHiwSuRqzS1YD4qReBs2lFoUfR3Y8hnYPkVHTdEMF4lCY3xz7SV7LYRYZ9BMwOBJn61z5f/UIilbWoAWRUHdD6kzQaqgkaznupt90iQB81ITWsXRoa+LdHumrr57EPH5qY0mVAwkuqwlL6DClqW35KdO9yIMe0PO2yrFl/4dtw3HRZd/Dmwpmdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3MVqrIe39+7CmDi0e4ZNOUd+M2fJiBq4b3/bob9MDo=;
 b=r1mUv73zhKB1v1EWKDVL7Bri/WJSQh24gd29eVMiVVy4BL1Dfe0+Rb395CU/7GgFMWn0REJedCQYGnFA6RrxgXm+F/+H3eVEKJ5CWUM2Mslt0eqbMjBM4ld/UJA9XEMP7Hai1ad3lqKkzoPEqllxetMs/rTQLOIwGjeV9zpLRieL7lWV/nUFdfMxgSuyFwV5pDFp4cJ8RPj2s+X3AZlLgUyRH/FyINBxjHg6vgn8dA2szCksK5c1QpTRb1r4RhK5z+/4nfmM7Ty+ndKH0DpPJNlYIheH5Q/IbX2rQdPShehpv7sqA5faU0XBsMWrTN2/Hhtq1eBCCohXtjxiA073MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3MVqrIe39+7CmDi0e4ZNOUd+M2fJiBq4b3/bob9MDo=;
 b=hUpKYZOTneVp+Qp7fD+ork3+dGWQkxXU556L0XrO6YFHV7BlAkoFor+eziw49QdXV7cruE7BxYpbdIpUg4xwYEC1T6xMSMin3Rvhho7XD7D0B6IVdD2PssJ5oZa6oU7zpJwAVEJ7HnvU6+/s33WjtNR1hKVQOjMoVWwW847zj1Pg0h2L4saPPy9Qxc/Lha1SSYG4XvEms3GD2lbUDSIm4ghyyfxXarqB6QkBmLwblIR5Qv2dLS7PAlEEyt1UOYHTyrj9zfKIF0YvbNMA9KSUu1n3kUWWAWUjy9qoev57vqt+ZL/0lWWkT47mPvC85YvC5JM+qHa2mp2v2I2vB/btng==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by KL1PR02MB6944.apcprd02.prod.outlook.com (2603:1096:820:104::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Wed, 11 Nov
 2026 05:37:24 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 05:37:24 +0000
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
Subject: Re: [RFC PATCH 15/38] target/riscv: Add cfg property for Zvfqwdota8f
 extension
Date: Wed, 11 Nov 2026 13:37:05 +0800
Message-ID: <20261111053706.8493-1-chao.liu@processmission.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104194155.679241-16-max.chou@sifive.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0022.namprd10.prod.outlook.com
 (2603:10b6:a03:255::27) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|KL1PR02MB6944:EE_
X-MS-Office365-Filtering-Correlation-Id: f33728ff-d514-481a-45a1-08df3fb5dcf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|7416014|376014|261021121427099003|261022075727099003|261026140227099003|261026121527099003|261009223027099003|261102124527099003|261028144727099003|56012099006|261102123227099003|261022105027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: YRPDtCofrrbEY6eoDE0s3eYGgH6tVBYKSYfSxC6CQGjUzyoESnI1UgF4f1xHqXE4erPoAR3os8FJBICPCOVb9HZ8S/7MiAfEdVLkSZDfRWP19lDqRRV5JTE4nDz5jb0qs3p7cyXcLbfGRQFwr4tGdt0W/ElOmsHch5uqiT83jaX+COZFPfraNkuY7Xva+LKjRGwV2Uawzw4v667Kzh8/C3H0PFgySgvs84BR1SZs4qfiZ5Q5eCh2+AivI0MDFkCqniZZUd/alIeZ2Gb+wzfQ7rUiUBlpk8UY+Eq+if5M6gg3+0MnL+ePdPdawj2eA5WM+JOfFp3vfjyJzN6GaINiqos4a7A3oN+r66DC8zl5X/s9++V/JPPPN/Mp2joAb3eYADy0OcHfojxb2OYNmTYjUFtqSEyCje0PjP+b6wS6D4m+J+GRkEw3Ya1IQRW0TCsjObYCvifdJEWFSJHf3f9NAMJEIcVd5NL6zbzhUOLnDSMyvMWePubNsob0cqmDZhBPpvXvrWK3cYevMWA53qmHREWPAKBES8Rh1wLRjHrDdW4G99gR4YM4Wlyac4GNcsKRpcUySNVgy6C3WKTpeIRV0wwKochaAkZmue8Kf6ji17XsTcXZCBbuLY17njFi0VZECwlibSTzohAEV9g5Z/0lAoYty2E0bVXiDoXbaEsShww=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(261021121427099003)(261022075727099003)(261026140227099003)(261026121527099003)(261009223027099003)(261102124527099003)(261028144727099003)(56012099006)(261102123227099003)(261022105027099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FN9QAjJe3dCDcroL2Ly0+cRBVzR+bfwXRKPl2OKK20va5uyh1zlYpQlm9JOz?=
 =?us-ascii?Q?WXe3lSv7RDztYyWJhoLmSKy+xoRHVbyv1R4XlwTa74+CLO2sRv0mTF6noBCB?=
 =?us-ascii?Q?3SmmxiPVA8zgsJJtfyQ9E8lDOgS681Y9k4/zNcXc9pNmhkD2nakKv5908lD7?=
 =?us-ascii?Q?h7FO6bOkYO+x5FmRjvtH11IEVfQUH5EgrVeFJW2YbKqko1rEBBt4UoDBKy36?=
 =?us-ascii?Q?+Uy+RcaFEJhQ40UgocJpq7ELZnTgJ2g9xAaoHh4vMd5EYf8zQ8/H7siVgusW?=
 =?us-ascii?Q?3mp6Wz3zjtS5tkj3ReyJ7PhlPouOySoJq3rW2A36n0EZzonM4I8yMFiyWQik?=
 =?us-ascii?Q?yKb2qWoBgStNLLGxcOMb4BOAkAPJ3VsYQ8dVlN4GwH0SSy3nzabtYgW48xLy?=
 =?us-ascii?Q?foW+qN64XmJefVbuNtcvjfzn+TnPreYk1HtD86YaI9SOUEgvU92t2udg7vdV?=
 =?us-ascii?Q?p/ZxQ2OXFMiv5mZGNLf5oBGOWxY81Y6t6NJEOt6a5O8hZ1kPLws8JGLWzGyv?=
 =?us-ascii?Q?JhhJlAIIs5XIhJGJm/u5SD15cLpFJ3WbuqOAQcdXHE1INlkS2gai0nDFFonE?=
 =?us-ascii?Q?ixBRy4Y8GaHfb9GvB6UMZKyO502TSL6S9zY5FY5Yy0wcf0dWnL0CDVaGwXx2?=
 =?us-ascii?Q?eWKNshB8dw2o1+fHncjzMFE2YaxakIb9dgNNzdLHPJw4cccxbhQb31wa11Cy?=
 =?us-ascii?Q?2iokHHROXXMAy0HoV/kEW8KF/QZOKhHSSowf+Xn/lbWVi5NpGWf29cuTDKfJ?=
 =?us-ascii?Q?jErD5eu0bIy2xfvWBr/uP/p5LquZBJnkOMZP63MCzbQuHymx3J44W3e396k5?=
 =?us-ascii?Q?Oo6sB4DDC8ysMHgL2yPeNh+WDRkP9Q9FEOspcffF/SeTg1gzQYod4MNUmrjY?=
 =?us-ascii?Q?sWLkUybQ7vrR2RS3EzFNUHb5oqzcmAiyOaM8fbFEiPnXiFMGP8ZXYYZtdlrO?=
 =?us-ascii?Q?OOVuqncm/6P6NQ0hDQkz+KdnN0GOrQOdAF1H50UW+ASnnaBg90dkoC1bVr1x?=
 =?us-ascii?Q?uoWn9I0IBeZZzI+clC3Kd3A6xcHdZ9BGktrDeB/gNn6wnTPUQumeIdGmfUlM?=
 =?us-ascii?Q?ziWSzPSt9657/V4Rdwfv9CDCGeeN44yNz6kXzJdopvi4e1CIgaNMgQoFfR0N?=
 =?us-ascii?Q?SccM6kudw04/08BbUwpNxz4EOoCFLxVjJOcV2kYp09YYxWXoaVfq1DWvZBk+?=
 =?us-ascii?Q?RDMi/5+h6nmr3nKWAXTXiqFsOPM9zZhVwGyCMZ9IOmGpi6tTtgaZ/TqXkxxb?=
 =?us-ascii?Q?3kERxWQCOh0N6KxmTqmteilXU0RlVLDd4ELD8kce9Itx9Cfibq9z145qjsMA?=
 =?us-ascii?Q?/XZiaFe4XteJ/yLbhiBuCZZPyXuBfRLWSL7k4tX8KBJLr6Qi5uO/de5V9Ssu?=
 =?us-ascii?Q?E21JQQ7Roey2GiUFKmrDPfjB829c6fh/v5JcRG5Q6MRu3Hrxm4Gy3CtlKv+3?=
 =?us-ascii?Q?JLkOh0xjpz3Cw+z2zDoHstVPvq69nYOdnwhmF5ulhOHVAFM0K81QEVFbRyZo?=
 =?us-ascii?Q?jEoUlkVmeKQ3WsAZDhjR0DOGT8q7ZFFASdnhssUrMAC1zm9MDIgZhJaMBhqM?=
 =?us-ascii?Q?BB7sEO/qviIzy6OZ2yU6DAnzFCDooEup1HkNP9WhdYJGlNm33Hvgj3JJu2Tn?=
 =?us-ascii?Q?LNPgUHb1yoFgEeqiyXU9tx1nXOwXE2Ax6tX9vhOzU4Qh08jJvb4/F825W/6U?=
 =?us-ascii?Q?TdQxoK0u+4dND8fIxcBkI/9jZ8i+ARkTIQtV7RBhOHGYJ6O6xJ4s2PNfWH/c?=
 =?us-ascii?Q?VbU/g0u+/OEa59c2W7QQxDh055KJeTo=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f33728ff-d514-481a-45a1-08df3fb5dcf5
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 05:37:24.0276 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J7I6z0sBFnL8aLxPQTQjEEk2ANbfBdu4WJJGRDkgib34HXsrcFU9zgzfyb5JriQYqLhBvloMkakcTymcPPfotaZzbk4pwtrcW+VbqekaK6I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB6944
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu,  5 Nov 2026 03:41:30 +0800 Max Chou <max.chou@sifive.com> wrote:

> Add CPU configuration property of Zvfqwdota8f extension which depends on
> the Zve32f extension per the specification.
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao
> ---
>  target/riscv/cpu.c                | 2 ++
>  target/riscv/cpu_cfg_fields.h.inc | 1 +
>  target/riscv/tcg/tcg-cpu.c        | 5 +++++
>  target/riscv/tcg/vector_helper.c  | 2 ++
>  4 files changed, 10 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 2d905a99d68..4f2e7a8faa9 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -236,6 +236,8 @@ const RISCVIsaExtData isa_edata_arr[] = {
>      ISA_EXT_DATA_ENTRY(zvfbfwma, PRIV_VERSION_1_12_0, ext_zvfbfwma),
>      ISA_EXT_DATA_ENTRY(zvfh, PRIV_VERSION_1_12_0, ext_zvfh),
>      ISA_EXT_DATA_ENTRY(zvfhmin, PRIV_VERSION_1_12_0, ext_zvfhmin),
> +    ISA_EXPERIMENTAL_EXT_DATA_ENTRY(zvfqwdota8f, PRIV_VERSION_1_13_0,
> +                                    ext_zvfqwdota8f),
>      ISA_EXPERIMENTAL_EXT_DATA_ENTRY(zvfwdota16bf, PRIV_VERSION_1_13_0,
>                                      ext_zvfwdota16bf),
>      ISA_EXT_DATA_ENTRY(zvkb, PRIV_VERSION_1_12_0, ext_zvkb),
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
> index 30c404863c8..b18abdd8b9b 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -106,6 +106,7 @@ BOOL_FIELD(ext_zvfbfmin)
>  BOOL_FIELD(ext_zvfbfwma)
>  BOOL_FIELD(ext_zvfh)
>  BOOL_FIELD(ext_zvfhmin)
> +BOOL_FIELD(ext_zvfqwdota8f)
>  BOOL_FIELD(ext_zvfwdota16bf)
>  BOOL_FIELD(ext_zvqwdota16i)
>  BOOL_FIELD(ext_zvqwdota8i)
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 91e009072e6..72ce0b4fbd0 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -706,6 +706,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
>          return;
>      }
>  
> +    if (cpu->cfg.ext_zvfqwdota8f && !cpu->cfg.ext_zve32f) {
> +        error_setg(errp, "Zvfqwdota8f extension depends on Zve32f extension");
> +        return;
> +    }
> +
>      if ((cpu->cfg.ext_zdinx || cpu->cfg.ext_zhinxmin) && !cpu->cfg.ext_zfinx) {
>          error_setg(errp, "Zdinx/Zhinx/Zhinxmin extensions require Zfinx");
>          return;
> diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
> index 5947427b6b4..a4c52ed296a 100644
> --- a/target/riscv/tcg/vector_helper.c
> +++ b/target/riscv/tcg/vector_helper.c
> @@ -40,6 +40,7 @@ static target_ulong vtype_reserved(CPURISCVState *env, target_ulong vtype)
>      target_ulong reserved = 0;
>  
>      if (riscv_cpu_cfg(env)->ext_zvfbfa ||
> +        riscv_cpu_cfg(env)->ext_zvfqwdota8f ||
>          riscv_cpu_cfg(env)->ext_zvfwdota16bf ||
>          riscv_cpu_cfg(env)->ext_zvqwdota16i ||
>          riscv_cpu_cfg(env)->ext_zvqwdota8i) {
> @@ -92,6 +93,7 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
>      switch (vsew) {
>      case MO_8:
>          ill_altfmt &= !(cpu->cfg.ext_zvfbfa ||
> +                        cpu->cfg.ext_zvfqwdota8f ||
>                          cpu->cfg.ext_zvqwdota8i);
>          break;
>      case MO_16:
> -- 
> 2.56.0
> 
> 
> 

Sent using hkml (https://github.com/sjp38/hackermail)

