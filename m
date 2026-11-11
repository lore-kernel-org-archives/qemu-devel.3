Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB34606A320
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 05:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=UKo0nqbc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR0yM-0005zB-Hf; Wed, 11 Nov 2026 00:34:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xR0yG-0005yY-K8; Wed, 11 Nov 2026 00:34:10 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xR0yC-0002sy-Rs; Wed, 11 Nov 2026 00:34:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TvQrfCKOa9CzclXOGE09kWYElGKoyMLrTPx3Upt8XAyvqr1FMc0DODndQRaB8hwFFHqQ9w+cw8yNq3IWxSEoihaOLoY5s42qHxjMnQgHQlsr9bFsXe5FcriyXXBcMuR0vkJPAIWjdCEXWZx4JtXm4LZ4CcrihG/O119HPd+OlISMGr2m6324AkJO2WR1LwoyEMrnUs9xHgYXwhclwTm0ODo/sUYzZk+xRWx24d9OJBw8onJQ+6eiAppbJyoZ8ToiuZCcMXltuZZ5X2sJ3ykAJSrUGdQtLyCFv4oGDQvQmB0NTSrKgojQ+W9d3cbGSBZgY+EKlDUa8hYoDF2uERStIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pG5j4GCa/oUx3zoe40EjTdX/ejeoXJNJwyEIPhXR/ls=;
 b=qvDH6+HApwtOASP9p0Oj+qd3P+uTzPcQx0ieXp54LAu7XxrQhEwI4gxuZxJfv7PEEyFGyuWox3lLCLxo/lgnCh2VImxApFg4ECv/Sgtz0jT+UwnGo2K0Gms0bf5IXQD4mo2NT/fs5BtmldRJnJgp075CdnmdFLIE7DMZdmyrJ7J84J+nmQWNstaO44NrjaYnoheV3Ugya74ZnM09GIz0czkbf6S4EYGLXcInvekEyiKg7BdMttOwKm9ZOCIyLHFJsYg8gZWvQgU25BaD8LuVp7WNBoWFJVkzsKNG0LY2WsxUtEIJtcG+81OEsA2abETmCBvBpWsBg2FlW4LBsNML1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pG5j4GCa/oUx3zoe40EjTdX/ejeoXJNJwyEIPhXR/ls=;
 b=UKo0nqbcYMc5qlAJJrTohGqf7NMgGUv8Z6TL0seyC16Dc6ki3JXkP8/VIpDiQ07qHixKL7qdZgxgeJJfAlSiPMXq6peu0a+adxTfzUMoifkOjsQZB0im4zIl4gnvqcnoiNd+q1iiahDR9dr7JM6q3HiYe8H94o710JRMEP/iP+JoAyyM2aAB1e6WbBwASpkU94w1Gpqm4cV8Wu7Y+pb9cK4WF1s2yAwGfXreO1Emsl2qi7bEo5X6BoG6r+DhAZn2S5yYt+jnX7CQDHfChgaqyiZ0EFrwUPP8awfFR1zswI6w/TiCW8FTNctsIDXjWD0AZUDNkXAoMYfsE1Zv4i4//Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by OSQPR02MB7903.apcprd02.prod.outlook.com (2603:1096:604:296::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 05:33:57 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 05:33:57 +0000
From: Chao Liu <chao.liu@processmission.com>
To: Max Chou <max.chou@sifive.com>
Cc: Chao Liu <chao.liu@processmission.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [RFC PATCH 14/38] disas/riscv: Support Zvfwdota16bf extension
Date: Wed, 11 Nov 2026 13:33:35 +0800
Message-ID: <20261111053337.91192-1-chao.liu@processmission.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104194155.679241-15-max.chou@sifive.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH1PEPF00013310.namprd07.prod.outlook.com
 (2603:10b6:518:1::b) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|OSQPR02MB7903:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b475506-23a0-4a68-3677-08df3fb5619e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|23010399003|56012099006|261021121427099003|261026140227099003|261026121527099003|261022075727099003|261028144727099003|261102123227099003|261022105027099003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: mLgXx2QHuGQgSX7s28GNlVho1/gRzv4Sw2HsatcXwcJWc1A5Eo/+8UIBDeYtcKfNQ7skJiuJn9ot64NVK8NSubkAczpPty9GTuHGtVeNdSBcKrj0KbC4NS2F2PMMqS+DTTblCLJ+7cmqV9RF6rbOrfl7uO4CJFBoG2Ay/Ao3GBKov6cz7p0KCldUeTVX33ruHEW5FpCk55G9hpQQk2wvZbJqjaCpeFtwFrObMpQd1VK/w+M0PQJdUWxcjA10IAr88hUVrFsIoPU7OlTCgvI5nqfsZK/nkikyRfdYjJDx6+6lNy5Q43SDj3guWu6IEsWwoEdirPgnV/nR4iL6AouStfDTs1ST7dfaGIPkSPLYwM+4NILMX6aVNqMROGYHSrDAEXdvVK/Aa1FSAHBtpeStxUPzt1FL2Iyj4yUnfJp1kMrK9jU5JcumWmUqtajz1TPfCfqxHBN/vb1xWKRFk5gfhbrlS5ml5F7pflebSJyOP7AXtnZZLHCaCeJ/N4I+biAoFGMN9J2/SBRc6i745fX+6qwMzk+K3vZ8SVf7FY2gdd3bLpkw9bC6v0nTTib0uVI03Z95ODs56VSj5o0c/KnUNNJgvvpwxNlYWBD+nQWPmNRYdasiT4SGQsm4wvLtF70PN216cj7Iry4qlQ8NjYHEIyT2kxqrlkStqxqhbiHaPs0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(56012099006)(261021121427099003)(261026140227099003)(261026121527099003)(261022075727099003)(261028144727099003)(261102123227099003)(261022105027099003)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gBYQFAohuHg6XpUdk2T5y7uKS+dhAqowQDZnlCEze1TR1GCscnOuqe949kmm?=
 =?us-ascii?Q?IrbdZC5TTt+urV+PisiGlLl/pQSO5oGAZ/oFvmKn+67pnMmQufLi5Qo5y45o?=
 =?us-ascii?Q?spKXkZbo5bnDwTPyX7yF0Rv3C3VlOr4SmIOxYisglGaroHnqZr3mTUk8bXJA?=
 =?us-ascii?Q?nVEOwh77jx9p8IQTofXTASH7VQ/7GmOz2+xKbyn42FSBkInhX+GtaK0hUTDv?=
 =?us-ascii?Q?0Th2S373WvIeh7RYqv2oqJlbeZ4fXmD+fRDBBImRX4Sw6GR/ziS2f8sTwnOF?=
 =?us-ascii?Q?Fy+hpWkdV294YaQE/5DMpFAtI6xXfTiiaQfhnWtU8+bP0t/n3cWuSkK/AFIG?=
 =?us-ascii?Q?z83h2E29DisxoVoiZHMk2/EpZ0Ih/kTgT2Iwgn3HyFmpJhFo0fkdbkURrrZR?=
 =?us-ascii?Q?qffY0OQcfXaYoC1uFebztpVrK3/AJfI8aj8gwc5rXjjRHx5/sdh7vh7Q78yC?=
 =?us-ascii?Q?g5dFcQZfyZSqeVKT5fhclOLVl03UbwHE+2UypAxc1bwsJ6hd5SYCPEZEc6ZF?=
 =?us-ascii?Q?AmDoShYCcCY5vFvn0jYESOT7s3SKPy92Q47qGwSvhYj/wGUzO2IcnEOrMg0k?=
 =?us-ascii?Q?jJwTvGoeQdqEF+ADbYtSF6X4U4MRe1Dyq1GHi1wnMVHJemxk0RXLPMVFYUX/?=
 =?us-ascii?Q?k+WL1X75D0eILntg8Emo9juV8IeedBRQuDQVeYddXvaDuuW5sTNfs9k30be9?=
 =?us-ascii?Q?oc+E9jr2OaSMXgQzlwb+OwQwpRO4JkTaf9rDokvdamhbJUzjhWNDoJN1xqMy?=
 =?us-ascii?Q?f2MHbazEX2QaqQseyCASjQrr2Ac1soiVkkamikgS2AL+NodI0hNDYHuHQpJ1?=
 =?us-ascii?Q?XA5GYySFzn+m9IRiwnRnNFp/t4sVlrYSwKNUCoT3dKpw3/GqBmkReqECA2cC?=
 =?us-ascii?Q?2Lsz7Zvnu+0DovkOlmk3552wXjisl50GBT09u37w2i4Son7IHl+0rMsjPme6?=
 =?us-ascii?Q?07F+DUcIM5GISriSzEdeXNmOpT1df1v512CSR91HCvp+jKZnoEiI+c3jE6X6?=
 =?us-ascii?Q?3H1zZXLgyA8zV7BL80g/+AYHYFdY2LxKmxaL2LwtyfjN9WWd4VgYc+fY8b3w?=
 =?us-ascii?Q?dKNKVuC7HZKT+M/emyZBIoAkNnF/UTUqi7GClik3Q7JOgJvTQ/uSNueVqtEj?=
 =?us-ascii?Q?GTXM8S66zeHhyhOkYt81qRuk2iRk94PGvzeGbVhPMXQSVfK9wOHBj9hwDbue?=
 =?us-ascii?Q?sMca4hjmr6lelpcnMoLxagsY6fd8lXbWzb3Jw2ZGRctSeUKdKcX8jjMfPHKW?=
 =?us-ascii?Q?WPahLF4KjW9Sv5N1MP32mVYzXC3p28DGwkdgHkEaDJYHRcBZs54pLCLQ/IVO?=
 =?us-ascii?Q?0KJ8PsIX8YcWGOHPlxfxOVtZFMUO8RBBj6iBUL1BMOR2Mg/Nxi5VNrDv67C4?=
 =?us-ascii?Q?c0Ht3JuPzuhrysd0oobD1Yb/cgSVNE9swL/vsbPOB3OPCnkuA4fsjLt4BS7D?=
 =?us-ascii?Q?SBO/eDqVvgD7Gp3Yuf9+dshbvhsnAkiArDcAHPzXiFXg0iEaiUj2fLqlTLUR?=
 =?us-ascii?Q?hXTlZgyLjLGMrUulCxKrycYE0Qo50ZoWW/uWnFsDUVrlPEN3p/NIxQZKj+vw?=
 =?us-ascii?Q?6M7S+EdDCXwCctTicnh34XDaQHWb7bVEP9UYGw8JBjyppnGfRapUZcoG0jW6?=
 =?us-ascii?Q?zut5V8d6sMxvD1Gy5J/Kvp3RIx+28IsD4ntphTCltIa9C6Og7pgq+kPO6sGt?=
 =?us-ascii?Q?ujDFTZJD8gXKCACLw0GOBS+hv4s58aTEJnX3+QxZH8fcC4XGImB3M4l0tEWI?=
 =?us-ascii?Q?EDWuCks4kgK/lYtFjfEyiLZkQ7Q8KFM=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b475506-23a0-4a68-3677-08df3fb5619e
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 05:33:57.0902 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bMqWA3DvTc3B5d14UEhqK6X8u1jJCNab89CLtJwbwwxNQtV6zSRNI5rrcr/ySBlA+Ava0miHtoKOKeOmrwkks2VenPgIefCMi5JbF3PG4Vo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR02MB7903
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

On Thu,  5 Nov 2026 03:41:29 +0800 Max Chou <max.chou@sifive.com> wrote:

> Add disassembler support for the vfwdota.vv instruction from the
> Zvfwdota16bf extension.
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao
> ---
>  disas/riscv-op.c.inc | 1 +
>  disas/riscv.c        | 4 ++++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/disas/riscv-op.c.inc b/disas/riscv-op.c.inc
> index ec767ccbf8b..aeb9423f130 100644
> --- a/disas/riscv-op.c.inc
> +++ b/disas/riscv-op.c.inc
> @@ -614,6 +614,7 @@ OP(vfwcvt_rtz_xu_f_v, "vfwcvt.rtz.xu.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm)
>  OP(vfwcvt_x_f_v, "vfwcvt.x.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm)
>  OP(vfwcvt_xu_f_v, "vfwcvt.xu.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm)
>  OP(vfwcvtbf16_f_f_v, "vfwcvtbf16.f.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm)
> +OP(vfwdota_vv, "vfwdota.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
>  OP(vfwmacc_vf, "vfwmacc.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm)
>  OP(vfwmacc_vv, "vfwmacc.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm)
>  OP(vfwmaccbf16_vf, "vfwmaccbf16.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm)
> diff --git a/disas/riscv.c b/disas/riscv.c
> index 2acded0c915..62feb4c653e 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -2640,6 +2640,10 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
>                  case 39: return &op_vqwdotas_vv;
>                  }
>              }
> +            if (((inst >> 12) & 0b111) == 1 &&
> +                ((inst >> 26) & 0b111111) == 36) {
> +                return &op_vfwdota_vv;
> +            }
>              if (((inst >> 25) & 1) == 1 && ((inst >> 12) & 0b111) == 2) {
>                  switch ((inst >> 26) & 0b111111) {
>                  case 32: return &op_vsm3me_vv;
> -- 
> 2.56.0
> 
> 
> 

Sent using hkml (https://github.com/sjp38/hackermail)

