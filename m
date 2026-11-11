Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB397606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 09:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=pmkcRzYg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR4T7-0007bC-8J; Wed, 11 Nov 2026 04:18:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xR4Sw-0007Zu-LY; Wed, 11 Nov 2026 04:18:09 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xR4St-0002mJ-5y; Wed, 11 Nov 2026 04:18:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=chugId2ArbOilvRFu1glbOxAOrVDEAzYMwyEontQEx1vVpOZfia6BqKdIWQH2H7CEKgRfmn80Ommf3Miu1ewRvZww+B1lE71MGZVVqqKrn48Rc1ONC9GmNuFGQCs4RguQ6Jtymj6HSWb8YqB9biOxiJ768R7fcQLxkz7H0a/jrnz8hWjDzTjsxkD6lYnWzTkJ4VNYheU9gg45RxBYBBiBMhgjwekYpIzBtuw9MtXMXuuR5Jt5Up1OyitC+c3mQmolB5hV8eC/EVvLSnPBuWtG35dooYAvtH5TQWWM5KD3/j1HR00LlMc84P3Z2AFwKERWIRDmSZA1yFgjQfapd+bsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cjROvCIe8fNv2aLnAyXsswlsVOvyqJ7ynmeX3zvKBrE=;
 b=GBz7kDKoEXbHZxd/J7S/jLa7NbDZsSuht8YaWizmPYUwM3sTm/O6Jvg3li37DSJWMciq+jz3Rlw8aIEYxVs3sgRpzG5gik19gAO4Cf321EdOerqaRPJ8Qdk1osc8uusUF+wJrfgDGev7+kMjane3aZi3HkistjHA/LqguJLaleR20jHRkq8Nc5i6mx9W+K7A4nwJSYR3+eSSONv000QpW3dF3V9qd+MFsjuTOujKYM5e9oE3Idyn7OOzxtj6ha3S3PQUGKISbjj2dGygTv4Cs9yFuH7qm3ihv9lnbRrrNwzoRVf0W0KIiEHT/rdzTwbFhu6pjHnFVVBhy2DXulk+PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjROvCIe8fNv2aLnAyXsswlsVOvyqJ7ynmeX3zvKBrE=;
 b=pmkcRzYgrN+FPlh8ohdld71iFBZI3TQK1ubMkND1ImrhO5jIMwFmQ0vDlSkL+olRxIoSln5/DsZtCK0phatyLVWJlnaplyf6kGYDrS1SGiICGk43XMmHDoxErhkqFKsabTWN9KNUOWX/PoulHOIL5U+zx5ihUg1lJiBWfwm0C4mpciFhuiyyOKTDOYWqzZXzrgwFEOdF+NRPNnASCrg8Rc9UY+bGkmy/2zrKoWbuUQuuLOpk1R2OJ9jApyJGw4Xuj+p7OaWC3TqwClfuoGXaEm2PEOGNPG8jEkNdUTD6rvEQmnoy4MR98I9VwwZJ0vQL2t7qTmiGSailgqmo98e4og==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by TYZPR02MB6925.apcprd02.prod.outlook.com (2603:1096:405:28::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 09:17:52 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 09:17:52 +0000
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
Subject: Re: [RFC PATCH 36/38] target/riscv: rvv: Implement Zvfbdota32f
 instructions
Date: Wed, 11 Nov 2026 17:17:31 +0800
Message-ID: <20261111091733.79751-1-chao.liu@processmission.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104194155.679241-37-max.chou@sifive.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0029.namprd07.prod.outlook.com
 (2603:10b6:510:5::34) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|TYZPR02MB6925:EE_
X-MS-Office365-Filtering-Correlation-Id: fbfe081b-761d-4df7-4bcf-08df3fd4a98f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|7416014|376014|22082099003|18002099003|3023799007|10067099003|261026140227099003|261028144727099003|261022075727099003|261021121427099003|261022105027099003|56012099006|261102123227099003|261009223027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: IXQ2i0Mxynqa5JKlxrNsZnMJLoW2QWpUycsoGRNYfCIbWknNqT3kWMcncNXZuh+EGlZTgBVqPwFTmRDiQnDQoHQ1qtdlagEdxhaPi4SsdIkMT3RFgoVrd0pfAGmd2D06NBE5r3+XLwiLv6u3Lypuln1cqg2O7Uf7Yp/XwLqNjbPT0PBBoaksBhWFDwVh4PWxrF6le6c4PRcbjSYxS11Je1Z7ehrNv/xhFxVvxtycnESP2Bk9h9ChB8tshB0dvie2b9ijHWye4psHB90LqnhtTjB5EHZHlpc4/eA0VKZlzRzOPDsC+CZ+bOYi09OIrZ0/pBA5u9tdn0NycW+pjeEqkiyXspKLwBCo5tdTTyA6vuv7Y5NTJoPPiAqpApIWHskNYn/PIIoiwPyARv4tgMgcu4rfvJHwAyZYB3QHz6+/CqU+/3dBg7Jz/rcEXwGCfBDhJ2wPSBrNZQ8JjpP3d3kHFhSN+Fqb9QlpXd6P1dYUbaqv8eysAEXCX0ahgH/06969Y58wZOj8MqlaOAylnnuPSW0M055bmrvGAbOGmqOS24ywZTcSSBTeUAaF6xLmft8sWYCoiVKYB249MGdddUvHsbljTehL3Vp2cM/MmjwJlSwX2TmvMIu9GHxhGPp5Vnap9x7z+nnV4cEs2P7Xk9M4t6/d1Y6WZEQhixHtQT9X/gM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(22082099003)(18002099003)(3023799007)(10067099003)(261026140227099003)(261028144727099003)(261022075727099003)(261021121427099003)(261022105027099003)(56012099006)(261102123227099003)(261009223027099003)(261026121527099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EDes6BtBTsicKKBNMPMty0t/xrY2RcLEYg8mCR8drbeiPbyvTrcUwTWmY6NY?=
 =?us-ascii?Q?lAzH4aVPaQtrTTsJxZcjKwAabxe4FasVWbGuku/gCX8XwFL2yx0C1snWHXgM?=
 =?us-ascii?Q?xGJH8Tk3FzwdfNgHYrEjU+EhuDDM+gCxyPBOQnupXKphzI3voUoOOt11Fqyg?=
 =?us-ascii?Q?sglFEU8fRIl+22807wDpMsZhMC4/qLhrXHVj5Ji+j2vi/Z1jYfEeVJmw3kzZ?=
 =?us-ascii?Q?hwnxZFIu0LDZgB6zNuIeCORRlHxsM8eBvkiluw8QLRMpuyxqjyFTmyPZEZYY?=
 =?us-ascii?Q?Tgwu0RHTAv/4zGfPXEdeypWH1vK5D4SFdWXExf4tpeBc60yp4pEaNWpjRITg?=
 =?us-ascii?Q?Bcpgm6ioNJMfF6vJZVSvZz4NCRveXT47auf+80gxF6P5rB2LO4PP1w4JwInN?=
 =?us-ascii?Q?zGtXdJutJza/0m8B+uScwVYAbCmiAfePEGr09rzMHto5m2rdtfCEjkYbDM5r?=
 =?us-ascii?Q?Bmokdo/kadTVdc+lfFDDdP9emkaWfMIS5kcBiZy+bX24KeQ5qpwgHOOhoOo6?=
 =?us-ascii?Q?+bMy/9porvT/i3kdBfADbnYgoYr8PiRWdv/idxGtnfTKom+xaiIf87qB2Onp?=
 =?us-ascii?Q?ckVXN/q8UT5DCxKNlMheaV40mGDG2nxn0QOWEM5LH7t+elh7V/j5jH1eNA5J?=
 =?us-ascii?Q?/Pz3U1kp5gGrpzZ5Mb4Ei8deD8saLA4M3pqj/2V3so6IA2YSh9CtGjo9ac6v?=
 =?us-ascii?Q?90XQ+X4JRbMuILLRLHUrUqmdHq4X0vw2Db3z+FeT869mnj0luGrVfmfGxwE9?=
 =?us-ascii?Q?e7nZ+PkAd5qvL1aCaI0ubtC8Ik+G9gkNRiQ52amZ5JPjQHOUsekOxcGgYEr4?=
 =?us-ascii?Q?qnXCejba0hbX8DfQ48OahK3hiN5CrD2doUk/ChwTDyDPtt9t2VcDkDcyFzfs?=
 =?us-ascii?Q?nALJZs0wNxCxDgH2Ut2quntkSdZktqtllUk8LNOc6uVow+RTOhdxrbF/38o1?=
 =?us-ascii?Q?Aue7wr8cxk4231OyYWyp1hyR3rf1qa32C82XAWPt0ttHRIKmOYBC5M+exxIR?=
 =?us-ascii?Q?28CseXv8w71S80z/VxUyCgqc2x8Ct8Pg5Mmv2CntxQxnN6HjJ3poVPkFZzby?=
 =?us-ascii?Q?I1vwR7mMVpnaJy2zHkWpQ5BPeUtKM1DDbPKnU7CzkPeZpbhJUe7Tr/3Ddkn7?=
 =?us-ascii?Q?5VAroswFwLnt+zEtUsISpukncEH0ySvG+avtSpajRy4JJk6Gfz9a0ATanUB9?=
 =?us-ascii?Q?F2qtlwriMRLB2thfdn0Du6aYZ7FsFUC53Qz/2NR4UtZB2TCLAsThsCi3imDb?=
 =?us-ascii?Q?UqqY7J67L9iIQ/dUSu791kyfm1OA4pCYKzzcX5TeeM5aZXql5TgvWREATSme?=
 =?us-ascii?Q?3dMOH4bErBlTzGBtMk9KeUQiMDzs4CyLneU8CJBWzxy+lvSWWsWU1c3k3uw8?=
 =?us-ascii?Q?50s6EMwrG6GWBaeLNigVm3ahozYGtFWIC4Sn+GiGv0p/ZtNRNO+hsRmOUgYc?=
 =?us-ascii?Q?1e3Au4aFY8tjGp2i555OrOP+iCviNMMqBzZf0O4XSgAHSHFS5IdU7kd5f2aU?=
 =?us-ascii?Q?2RmwUoSOsxGE6jgAu0YpiMxeyYWqamU4sP2GStV6IgAuJb2zTDqG5sMeyZBQ?=
 =?us-ascii?Q?C59v7opGzy8dQeMuzJn3DRwoJnqBuzI8uPHHP9MEVvVY4SKUhpiwpLtzBZ9y?=
 =?us-ascii?Q?eAXZQcVSGpvNbKa0shqhIKh98eTC0CZW+nj+pt5k53U7tE7pAMdbriqJkEEF?=
 =?us-ascii?Q?x0nqyb5WppzJnMmiKuBzPD/nVM/8RZPU8OWnn4V1zLbTAZ2EFFX7Pw+vPFYk?=
 =?us-ascii?Q?DOzv+Z9CeC0++WeOGKMAxjSgXjRNIoA=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbfe081b-761d-4df7-4bcf-08df3fd4a98f
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 09:17:52.2012 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rUa9kIuCp6UKtS78AMQc2uxlI1HVCIZc9kjYs26N0dzGzP2bOOA78QV2EcHbwUaA5Hm36NQf7mdlVrnG/4oeUZDnVvCn2kghthHDwz0X5LU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB6925
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
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu,  5 Nov 2026 03:41:51 +0800 Max Chou <max.chou@sifive.com> wrote:

> Add support for the Zvfbdota32f FP32 batched dot-product instruction.
> The vfbdota.vv instruction performs 8 parallel dot products between
> FP32 vectors, accumulating into FP32 elements.
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---
>  target/riscv/helper.h                       |  3 ++
>  target/riscv/insn32.decode                  |  3 ++
>  target/riscv/tcg/insn_trans/trans_rvv.c.inc | 11 ++++
>  target/riscv/tcg/vector_helper.c            | 58 +++++++++++++++++++++
>  4 files changed, 75 insertions(+)
> 
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index a257436fb31..94f4d9c40c6 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -1398,6 +1398,9 @@ DEF_HELPER_6(vfwdota_vv, void, ptr, ptr, ptr, ptr, env, i32)
>  /* Zvfwbdota16bf - BF16 Batched Dot Product */
>  DEF_HELPER_7(vfwbdota_vv, void, ptr, ptr, ptr, ptr, i32, env, i32)
>  
> +/* Zvfbdota32f - FP32 Batched Dot Product */
> +DEF_HELPER_7(vfbdota_vv, void, ptr, ptr, ptr, ptr, i32, env, i32)
> +
>  /* Zvfqwbdota8f - OCP FP8 Batched Dot Product */
>  DEF_HELPER_7(vfqwbdota_vv, void, ptr, ptr, ptr, ptr, i32, env, i32)
>  DEF_HELPER_7(vfqwbdota_alt_vv, void, ptr, ptr, ptr, ptr, i32, env, i32)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index 48597915f7b..7fdb7eb54da 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -1112,6 +1112,9 @@ vfwbdota_vv 101100 . ..... ..... 001 ..... 1110111 @r_vm
>  vfqwbdota_vv     101110 . ..... ..... 001 ..... 1110111 @r_vm
>  vfqwbdota_alt_vv 101111 . ..... ..... 001 ..... 1110111 @r_vm
>  
> +# *** Zvfbdota32f FP32 Batched Dot-Product Extension ***
> +vfbdota_vv  101011 . ..... ..... 001 ..... 1110111 @r_vm
> +
>  # *** Zvfqwdota8f OCP FP8 Dot-Product Extension ***
>  vfqwdota_vv     100110 . ..... ..... 001 ..... 1110111 @r_vm
>  vfqwdota_alt_vv 100111 . ..... ..... 001 ..... 1110111 @r_vm
> diff --git a/target/riscv/tcg/insn_trans/trans_rvv.c.inc b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> index 50f0f67ea60..9b06c6a782c 100644
> --- a/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> @@ -4430,3 +4430,14 @@ static bool vext_vfqwbdota_check(DisasContext *s, arg_rmrr * a)
>  
>  GEN_ZVBDOTA_FP_TRANS(vfqwbdota_vv, vext_vfqwbdota_check, MO_32)
>  GEN_ZVBDOTA_FP_TRANS(vfqwbdota_alt_vv, vext_vfqwbdota_check, MO_32)
> +
> +/* Zvfbdota32f FP32 Batched Dot-Product Extension */
> +static bool vext_vfbdota_check(DisasContext *s, arg_rmrr * a)
> +{
> +    int32_t sew = s->sew;
> +    return s->mstatus_fs != EXT_STATUS_DISABLED &&
> +           vext_zvbdota_base_check(s, a, sew) &&
> +           (s->cfg_ptr->ext_zvfbdota32f && sew == MO_32);
> +}
> +
> +GEN_ZVBDOTA_FP_TRANS(vfbdota_vv, vext_vfbdota_check, MO_32)
> diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
> index e641e21d088..7d680747ddd 100644
> --- a/target/riscv/tcg/vector_helper.c
> +++ b/target/riscv/tcg/vector_helper.c
> @@ -6327,3 +6327,61 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,              \
>  
>  GEN_VEXT_ZVBDOTA_FP8(vfqwbdota_vv, e4m3)
>  GEN_VEXT_ZVBDOTA_FP8(vfqwbdota_alt_vv, e5m2)
> +
> +/*
> + * Zvfbdota32f: FP32 Batched Dot Product with Accumulation
> + */
> +void HELPER(vfbdota_vv)(void *vd, void *v0, void *vs1, void *vs2, uint32_t ci,
> +                        CPURISCVState *env, uint32_t desc)
> +{
> +    uint32_t vm = vext_vm(desc);
> +    uint32_t vl = env->vl;
> +    uint32_t vta = vext_vta(desc);
> +    uint32_t vta_all_1s = vext_vta_all_1s(desc);
> +    uint32_t vlenb = riscv_cpu_cfg(env)->vlenb;
> +    uint32_t vd_emul = vext_lmul(desc);
> +    uint32_t log_esz = 2;
> +    uint32_t vlmax = vlenb >> MO_32;
> +    uint32_t total_elems = (vlenb << vd_emul) >> log_esz;
> +    uint32_t n, k;
> +    float32 *a_vec, *b_vec;
Please use g_autofree for these arrays as well.

Otherwise, LGTM.

Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> +    float32 acc, prod, a, b;
> +
> +    VSTART_CHECK_EARLY_EXIT(env, vl);
> +
> +    a_vec = g_new0(float32, vlmax);
> +    b_vec = g_new0(float32, vlmax);
> +
> +    FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
> +    for (n = 0; n < 8; n++) {
> +        if (!vm && !vext_elem_mask(v0, ci + n)) {
> +            continue;
> +        }
> +
> +        for (k = 0; k < vl; k++) {
> +            a_vec[k] = *((float32 *)vs2 + n * vlmax + H4(k));
> +            b_vec[k] = *((float32 *)vs1 + H4(k));
> +        }
> +
> +        acc = *((float32 *)vd + H4(ci + n));
> +        for (k = 0; k < vlmax; k++) {
> +            a = a_vec[k];
> +            b = b_vec[k];
> +            prod = float32_mul(a, b, &env->fp_status);
> +            acc = float32_add(acc, prod, &env->fp_status);
> +        }
> +        *((float32 *)vd + H4(ci + n)) = acc;
> +    }
> +    riscv_cpu_check_fflags(env, pre_fflag);
> +
> +    g_free(a_vec);
> +    g_free(b_vec);
> +
> +    env->vstart = 0;
> +
> +    if (ci + 8 < total_elems) {
> +        if (vta_all_1s) {
> +            vext_set_elems_1s(vd, vta, (ci + 8) * 4, total_elems * 4);
> +        }
> +    }
> +}
> -- 
> 2.56.0
> 
> 
> 

Sent using hkml (https://github.com/sjp38/hackermail)

