Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8B7606AA69
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=SnRjR4Dt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQnNm-0002wb-QC; Tue, 10 Nov 2026 10:03:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xQnMY-0002jH-T9; Tue, 10 Nov 2026 10:02:35 -0500
Received: from mail-japaneastazon11022091.outbound.protection.outlook.com
 ([52.101.126.91] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xQnMW-0008Ni-9H; Tue, 10 Nov 2026 10:02:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u81g70433iIn4NGkuAYG+1Ogjhwe+QPz4XJPLa+GU7/JoVjSMYelqI3Kny9hXGUJ0tHCPac0F7i2FxdONPFAATwdurgROKPDA9ght2ym9neVT1MHIfkFDvgBJoXnkBQ6xTgGEgl7dRp2Mu13w4utBPLPnTsX/dyckmo4NOkelj/S1KWRGxgYwU9ShkkJn8LwOLd22qAlBENsHJMILEIqiOdYdNlAGV3rl6E4nMh2bUI7z3kHc2Dx4wUAiUaukwuNH2AHtgBNDMAoj5kf2wuBNSSdDwSJPhy57bON8zLLbFSfFQlea3evn0OIzGfjItDKzfvpr75HXLPZop9GIrbl+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpV5Zr9JVU0mDBKobTL57gTZlm9J28G2AIm8dacBy54=;
 b=EsRUFiKo4MIYUmiH0jWcbg5VVX24AmjzdpthFstEN7ewhHQzKo9Wvt55bvpYLJtJa9h64VvXii/ROd63R8sPpsFSdi3UoAkyHuAZyWK79r69RTMxJzL6L2QAM8rhwdN+0AWyjM/5ZDECXgGGyzfm+pl0q+fClMb2fLVMO5Sc/ah2KyI74tODUm36aGJTbq7w56CKgbMFtsmMbdhnvlhbfUSpfX1O90DVffLRTiqqKDobxRR7aiDx1LS6McY0XeSaXrva5j7idQ7Gay3E4YqneR8l6EuDg+ZEGeS5CCAUDfAp8K3uApxLdzzRxg7yjkn1gAQMYvCP1lRf6YsvwlrstA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpV5Zr9JVU0mDBKobTL57gTZlm9J28G2AIm8dacBy54=;
 b=SnRjR4Dt2jG+LDJ1104sjZYG64iUbZCQQw86I14YiECOtO5tpDWFwxzEBKKeAXfJgupm28pOPwCWbki1xW36BW/GDT0oFQqdC5X1We6ORLLTGRBraoVZ2K8iyNAdq/c9kL90Bve+NzY6mKGtkPP5qZQ0eHP+6J1st8phMl4yZITArNNw0u11fuCCkarIVuPEAcLyMMBM8aeSz8bjc570sBRCeXUuHjkLeiI46vcDRetVNS/iQyjSEZ8aPjF2Ly0PleqWVDCNGSIptKOt8/QmJk0fJUTU4wLCQlCxsS76p7pSHhqe7MXGroRyVGPGEtNdip4F4XPZEGOqcWaIQLmfGw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by JH0PR02MB6901.apcprd02.prod.outlook.com (2603:1096:990:53::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 14:57:03 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 14:57:03 +0000
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
Subject: Re: [RFC PATCH 03/38] target/riscv: rvv: Introduce RVBNA algorithm
 for Zvdota/Zvbdota extensions
Date: Tue, 10 Nov 2026 22:56:42 +0800
Message-ID: <20261110145644.96107-1-chao.liu@processmission.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104194155.679241-4-max.chou@sifive.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0028.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:326::17) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|JH0PR02MB6901:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c2c5931-daaa-43a5-16b8-08df3f3ae13a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|23010399003|376014|22082099003|18002099003|10067099003|3023799007|261009223027099003|261102123227099003|261102124527099003|261026121527099003|261028144727099003|261022105027099003|56012099006|261022075727099003|261021123027099003|261021121427099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: TLnABHHmOPRC8Sz1DrZoxy2Rxczl/pbMXqAP6h6ML/SfD3g4bi/gLJ5hlbUDb8RXo41k9Z6BY6pT3WA6kjMVAtxkcD243Ufk49Dxo7KjHqWn2glCZ/DHJhdiGpVPro1gYh5yTfTPdHxM1TTtt8MAknn+dP3/9Zj0ux+kI9p/4q0jVdDa37sZEZhEhInJ2/FnHZGz1XVOhwf+NzCfsUmkwjZfSI2tMH0leolf6mXG+E2se5643m9gWZJ0wxqnGjYSEhokA9YOBXcb/XZh+awIOh+RXywIpaZ5iowjsMaUUJA5xMBxMVJ9msnPLtlXAh812ekOyaG3SrN2XW2zqYmoQYtNZGMEPpN65XrB8ziVfoD93sBe4MCnwgZhc1MZbHyWAqliOx6W2BMWD+ewYBrDGP0foeXvv1jEkeKlapwCdKxK20D8dAX/V4UDSEf3tU+jlyeWziZpO9Qbk/FYAD0GUdp44sqfUP8UnuXeXu1K8ONSsLBGN96vsgxrxU8VOF1buYLcacLevYTwoVGjOY/I9OqUgKL/Rx4WpsDH8INf1crPz2yhjcpqtSSrug17LJYCH59fA77rBHGAkXB7G96VKOOItylkJusMHPumPEURWgAVqz3wdeDSWhfv/PpdeWyHPnMV/MgBm1Poz0rX901MGqfPLNPdLbA5bwZvoOPg6vw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(23010399003)(376014)(22082099003)(18002099003)(10067099003)(3023799007)(261009223027099003)(261102123227099003)(261102124527099003)(261026121527099003)(261028144727099003)(261022105027099003)(56012099006)(261022075727099003)(261021123027099003)(261021121427099003)(261026140227099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L0c+CQ/p+T2/mewZsbE7Vrawv/VZ+rpx1C4QiuvVD/jlqsmdyrZSSJPIhGZU?=
 =?us-ascii?Q?dttYoPGQ0ywbzBmv8qPOZSZjBg4Ijc1GrZbJShr1eKqXO9hGIk9Ye2yF7vzk?=
 =?us-ascii?Q?FQEuiwEtA+Y0dyTZ+fe9QS4mxFCeIELClnFRbx6XOf+4TgheQjy2ktxkferC?=
 =?us-ascii?Q?9BfhhqLOgthSrzQAoI4Ztfm9SncWwu2ycBGhbeSTMUqMbqUXxjz2m+sutXJG?=
 =?us-ascii?Q?TS1gcfCI4PZlouchqd9W+ggfecsYIG3i0AtTNajHBuoii76pGOzjhsirBi6I?=
 =?us-ascii?Q?4aj22PI58tqWw3dvQWTSpm1Fqe3q7P8RnMALI2mioPoavxGm4CqvVaCWtYw+?=
 =?us-ascii?Q?OJ+RTyq/jpf3yWcz1OGjgDYFLwC6IWaSU6acBhgbbYkPBica2i+i/86jLKJ9?=
 =?us-ascii?Q?KwVInf2sh2TPXkW4KgMxO04vo8UXpPDtWzh9Ql5/s9a8lXzjxHY/iW7IXx6+?=
 =?us-ascii?Q?QGtrkB+eBUiTWIkDEP9q2652jN2kh+Yo+r8FTr0YdWHODWf65ybuNklTaoCL?=
 =?us-ascii?Q?LTlhQ7+07RN5+V7ByhLzc4sJo/Y1AS980a+lG3skkTl0qyaGHelE1CB74Vg8?=
 =?us-ascii?Q?QR6Mgle4oetsySCRBPyWqNMDlNIlXrTDtE96bDcC0dnLqSGEf8/UJn3b9mBJ?=
 =?us-ascii?Q?zLmf6LoNlNwp/aiMb2Qndk3C9Q9R1PVkJOue+7S1wldd2BRWkP9nCtDuq+5s?=
 =?us-ascii?Q?Hh7IT1qiCY3E1BZAR2Vr2F/dyUU3CSy6VZ0d8F6WLZUoEABXTASO1lApeZP+?=
 =?us-ascii?Q?D33CE3PmBXSRU9qU0GArP8TLhFjoRoO5Kte8BykW+OPypHs/5LcAZ0B3hSr6?=
 =?us-ascii?Q?GA153ZEgUDJpFmpyRjU56pMzD5+bE0iD3e9k8eu7ECOAnjFORyNtFn7JFpz/?=
 =?us-ascii?Q?GnyW5Su+TlR++kZT+25+IfCdj9jgH6BQp5g0a3wnaUmtr3wN/7hhH7kJtPZI?=
 =?us-ascii?Q?8Iu/Mtar/xOoLQsV2SLdcZYMgSJFyyqeO5z8CW6Nyo1XE/WftUGWvxyGnxFh?=
 =?us-ascii?Q?WvXQAizBEy5NJa10bX4ILID86UDzq7WJn2kQpQ+t8mQAYQFz51dmwG4tvVW2?=
 =?us-ascii?Q?IYBORPhjcP30A8He9Uvvi3kw6d+3NgdqjyLzkRRX2/oOqiBsq8uE2Pmcc26d?=
 =?us-ascii?Q?gDOdeoWyVxrK9VCW8Z/8IdycRbs7WmiDeP2dxKkFwZIo9Q29s3YWq85opefk?=
 =?us-ascii?Q?hEHPDQSIKDwfQ5a9EBXSF2FLPkE0VKtkDWtIAimcLX4dfoYLIewDIdeY7ORw?=
 =?us-ascii?Q?4WxD7ngOAcWQ5zpicHxZZecPSczqXvnJWlUiZ2xHSEGSJpNOvfUhkGEKGycO?=
 =?us-ascii?Q?piuB4WvRFR+xh1dK8ZApmvnZk58T4gb9leKBKlP/+2Brr3qyzuoWm9dDdZOr?=
 =?us-ascii?Q?GfEqieQhB5wHz1P96TIq93H/EwX05PuGN24f2y/Sv2REKwWhArMEtM66EK0R?=
 =?us-ascii?Q?/MmkLmf1lNUhVr/ipVvIofz8DNJsnE9Fy0sCB0AK6ULk5blbNpMMuTXWxLY6?=
 =?us-ascii?Q?p8Z8RzNacAVC5+QhbAMxjoSAY0EfNaAJwtdOWi++H3RADRrrNxsUoSSXD1Yx?=
 =?us-ascii?Q?ks+X6jsKHaQjE2KZrjdBaF5noyh/rwL//ksd9DLeOUcScFUMeJRNxi9Vm6Yb?=
 =?us-ascii?Q?3IFEQwiPzim0sxTuKI1w4UVf5rDS/+/b/lqSwF+7/TY5qdq93mA3Y1NRVK3N?=
 =?us-ascii?Q?a3gdIdDA504UKGfYYh6cgemSXXFLCHDbf1mc1CAwTL2tUrO754DBjPW5NoDG?=
 =?us-ascii?Q?JL4FCgJCwRCXZOxw5gRtNcfa7PL51EM=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c2c5931-daaa-43a5-16b8-08df3f3ae13a
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 14:57:03.1470 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Kmo3xZtfA6/dwyAZ5M3bqNgCWF415v4Nr2xAWWbYLy+QVJVsF5fAvw4pqkvB+nGp+WUIZErQ3Jqr67CJolmt37kGe3am5uIGbyTcLS5vbo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR02MB6901
Received-SPF: pass client-ip=52.101.126.91;
 envelope-from=chao.liu@processmission.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On Thu,  5 Nov 2026 03:41:18 +0800 Max Chou <max.chou@sifive.com> wrote:

> The RISC-V Bulk Normalization Algorithm (RVBNA) is a scheme employed by
> multiple RISC-V extensions (e.g. Zvdota/Zvbdota family) for efficient
> computation of floating-point dot products.
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---
>  MAINTAINERS                      |   6 +
>  target/riscv/tcg/meson.build     |   2 +-
>  target/riscv/tcg/rvbna.c         | 185 +++++++++++++++++++++++++++++++
>  target/riscv/tcg/rvbna.h         |  40 +++++++
>  target/riscv/tcg/vector_helper.c |   1 +
>  5 files changed, 233 insertions(+), 1 deletion(-)
>  create mode 100644 target/riscv/tcg/rvbna.c
>  create mode 100644 target/riscv/tcg/rvbna.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 55463103ff1..b91e5925344 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -416,6 +416,12 @@ F: target/riscv/tcg/xsf_helper.c
>  F: disas/riscv-xsf*
>  F: tests/tcg/riscv64/test-xsfvqmacc.S
>  
> +RISC-V Bulk Normalization Algorithm (RVBNA)
> +M: Max Chou <max.chou@sifive.com>
> +L: qemu-riscv@nongnu.org
> +S: Supported
> +F: target/riscv/tcg/rvbna.*
> +
>  RENESAS RX CPUs
>  R: Yoshinori Sato <yoshinori.sato@nifty.com>
>  S: Orphan
> diff --git a/target/riscv/tcg/meson.build b/target/riscv/tcg/meson.build
> index 86805b30cbc..3b7821178fc 100644
> --- a/target/riscv/tcg/meson.build
> +++ b/target/riscv/tcg/meson.build
> @@ -10,6 +10,7 @@ riscv_ss.add(files(
>    'fpu_helper.c',
>    'm128_helper.c',
>    'op_helper.c',
> +  'rvbna.c',
>    'translate.c',
>    'tcg-cpu.c',
>    'vcrypto_helper.c',
> @@ -27,4 +28,3 @@ riscv_system_ss.add(files(
>    'th_csr.c',
>  ))
>  
> -
> diff --git a/target/riscv/tcg/rvbna.c b/target/riscv/tcg/rvbna.c
> new file mode 100644
> index 00000000000..f6150e4976d
> --- /dev/null
> +++ b/target/riscv/tcg/rvbna.c
> @@ -0,0 +1,185 @@
> +/*
> + * RISC-V Bulk Normalization Algorithm (RVBNA)
> + *
> + * Copyright (c) 2026 SiFive, Inc.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/bitops.h"
> +#include "qemu/host-utils.h"
> +#include "fpu/softfloat.h"
> +#include "fpu/softfloat-macros.h"
> +#include "rvbna.h"
> +
> +static inline int rvbna_guard_bits(uint32_t n_prod)
> +{
> +    g_assert(n_prod > 0);
> +    return 32 - clz32(n_prod - 1);
> +}
> +
> +float32 rvbna_final_f32_add(float32 partial, float32 accumulator,
> +                            float_status *fp_status)
> +{
> +    FloatRoundMode old_rm = get_float_rounding_mode(fp_status);
> +    int old_flags = get_float_exception_flags(fp_status);
> +    int new_flags;
> +    float32 result;
> +
> +    set_float_rounding_mode(float_round_to_odd_inf, fp_status);
> +    set_float_exception_flags(0, fp_status);
Why are we adding this exception flag clear operation?

> +    result = float32_add(partial, accumulator, fp_status);
> +    new_flags = get_float_exception_flags(fp_status) &
> +                (float_flag_invalid | float_flag_overflow);
We can simplify the variable definitions. Using a 'flags' instead of
'old_flags' and 'new_flags' is enough.


Otherwise, looks good to me.

Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> +    set_float_rounding_mode(old_rm, fp_status);
> +    set_float_exception_flags(old_flags | new_flags, fp_status);
> +
> +    return result;
> +}
> +
> +#define RVBNA_STACK_THRESHOLD 8
> +
> +#define GEN_RVBNA(TA, TB, TO, A_E, A_M, B_E, B_M, OUT_E, OUT_M)              \
> +TO rvbna_dot_##TA##_##TB(const TA a[], const TB b[], uint32_t n_prod,        \
> +                         float_status *fp_status)                            \
> +{                                                                            \
> +    int32_t stack_ref_exps[RVBNA_STACK_THRESHOLD];                           \
> +    bool stack_signs[RVBNA_STACK_THRESHOLD];                                 \
> +    uint64_t stack_sigs[RVBNA_STACK_THRESHOLD];                              \
> +    int32_t *prod_ref_exps = stack_ref_exps;                                 \
> +    bool *prod_signs = stack_signs;                                          \
> +    uint64_t *prod_sigs = stack_sigs;                                        \
> +    g_autofree int32_t *heap_ref_exps = NULL;                                \
> +    g_autofree bool *heap_signs = NULL;                                      \
> +    g_autofree uint64_t *heap_sigs = NULL;                                   \
> +    int guard_bits = rvbna_guard_bits(n_prod);                               \
> +    int pad = OUT_M - (A_M + B_M) + guard_bits;                              \
> +    int output_bias = (1 << (OUT_E - 1)) - 1;                                \
> +    int a_exp_bias = (1 << (A_E - 1)) - 1;                                   \
> +    int b_exp_bias = (1 << (B_E - 1)) - 1;                                   \
> +    int ref_bias = output_bias - (a_exp_bias + b_exp_bias);                  \
> +    int max_prod_ref_exp = ref_bias;                                         \
> +    int overflow_exp = (1 << OUT_E) - 1;                                     \
> +    int64_t acc = 0;                                                         \
> +    bool nan_result = false;                                                 \
> +    bool inf_result = false;                                                 \
> +    bool inf_sign = false;                                                   \
> +    bool any_pos_inf = false;                                                \
> +    bool any_neg_inf = false;                                                \
> +    bool any_invalid_prod = false;                                           \
> +    bool any_signan = false;                                                 \
> +    bool op_sign_inf, sign, overflow;                                        \
> +    uint32_t i;                                                              \
> +    uint64_t sig;                                                            \
> +    int lead, exp, sig_bits;                                                 \
> +                                                                             \
> +    g_assert(pad >= 0);                                                      \
> +    if (n_prod > RVBNA_STACK_THRESHOLD) {                                    \
> +        heap_ref_exps = g_new(int32_t, n_prod);                              \
> +        heap_signs = g_new(bool, n_prod);                                    \
> +        heap_sigs = g_new(uint64_t, n_prod);                                 \
> +        prod_ref_exps = heap_ref_exps;                                       \
> +        prod_signs = heap_signs;                                             \
> +        prod_sigs = heap_sigs;                                               \
> +    }                                                                        \
> +                                                                             \
> +    for (i = 0; i < n_prod; i++) {                                           \
> +        bool a_sign = TA##_is_neg(a[i]);                                     \
> +        bool b_sign = TB##_is_neg(b[i]);                                     \
> +        bool a_sub = TA##_is_zero_or_denormal(a[i]);                         \
> +        bool b_sub = TB##_is_zero_or_denormal(b[i]);                         \
> +        bool a_zero = TA##_is_zero(a[i]);                                    \
> +        bool b_zero = TB##_is_zero(b[i]);                                    \
> +        bool a_inf = TA##_is_infinity(a[i]);                                 \
> +        bool b_inf = TB##_is_infinity(b[i]);                                 \
> +        bool a_nan = TA##_is_any_nan(a[i]);                                  \
> +        bool b_nan = TB##_is_any_nan(b[i]);                                  \
> +        bool prod_sign = a_sign ^ b_sign;                                    \
> +        bool invalid_prod = (a_inf && b_zero) || (b_inf && a_zero);          \
> +        bool inf_prod_lhs = a_inf && !b_nan && !b_zero;                      \
> +        bool inf_prod_rhs = b_inf && !a_nan && !a_zero;                      \
> +        bool inf_prod = inf_prod_lhs || inf_prod_rhs;                        \
> +        bool invalid_sum = inf_result && inf_prod &&                         \
> +                           (inf_sign != prod_sign);                          \
> +        uint32_t a_mant = extract32(a[i], 0, A_M);                           \
> +        uint32_t b_mant = extract32(b[i], 0, B_M);                           \
> +        bool a_signan = a_nan && TA##_is_signaling_nan(a[i], fp_status);     \
> +        bool b_signan = b_nan && TB##_is_signaling_nan(b[i], fp_status);     \
> +        uint64_t a_sig = a_mant | (!a_sub << A_M);                           \
> +        uint64_t b_sig = b_mant | (!b_sub << B_M);                           \
> +        bool prod_is_zero = a_zero || b_zero;                                \
> +        bool either_inf = a_inf || b_inf;                                    \
> +        bool either_nan = a_nan || b_nan;                                    \
> +                                                                             \
> +        any_invalid_prod |= invalid_prod;                                    \
> +        nan_result |= a_nan || b_nan || any_invalid_prod || invalid_sum;     \
> +        inf_result |= inf_prod;                                              \
> +        inf_sign = inf_prod ? prod_sign : inf_sign;                          \
> +                                                                             \
> +        prod_signs[i] = prod_sign;                                           \
> +        prod_sigs[i] = (uint64_t)(a_sig * b_sig) << pad;                     \
> +        prod_ref_exps[i] = ref_bias;                                         \
> +        if (!prod_is_zero) {                                                 \
> +            prod_ref_exps[i] += (a_sub ? 1 : extract32(a[i], A_M, A_E)) +    \
> +                                (b_sub ? 1 : extract32(b[i], B_M, B_E));     \
> +        }                                                                    \
> +        max_prod_ref_exp = MAX(prod_ref_exps[i], max_prod_ref_exp);          \
> +                                                                             \
> +        any_pos_inf |= (either_inf && !either_nan && !prod_is_zero &&        \
> +                        (a_sign == b_sign));                                 \
> +        any_neg_inf |= (either_inf && !either_nan && !prod_is_zero &&        \
> +                        (a_sign != b_sign));                                 \
> +        any_signan |= a_signan || b_signan;                                  \
> +    }                                                                        \
> +                                                                             \
> +    op_sign_inf = any_pos_inf && any_neg_inf;                                \
> +                                                                             \
> +    if (nan_result) {                                                        \
> +        if (any_signan || any_invalid_prod || op_sign_inf) {                 \
> +            float_raise(float_flag_invalid, fp_status);                      \
> +        }                                                                    \
> +        return TO##_default_nan(fp_status);                                  \
> +    } else if (inf_result) {                                                 \
> +        return TO##_set_sign(TO##_infinity, inf_sign);                       \
> +    }                                                                        \
> +                                                                             \
> +    for (i = 0; i < n_prod; i++) {                                           \
> +        shift64RightJamming(prod_sigs[i],                                    \
> +                            max_prod_ref_exp - prod_ref_exps[i], &sig);      \
> +        acc += prod_signs[i] ? -(int64_t)sig : (int64_t)sig;                 \
> +    }                                                                        \
> +                                                                             \
> +    sign = acc < 0;                                                          \
> +    sig = sign ? -(uint64_t)acc : acc;                                       \
> +    if (sig == 0) {                                                          \
> +        return 0;                                                            \
> +    }                                                                        \
> +                                                                             \
> +    lead = 63 - clz64(sig);                                                  \
> +    exp = max_prod_ref_exp - OUT_M - guard_bits + lead;                      \
> +    overflow = exp >= overflow_exp;                                          \
> +    if (overflow) {                                                          \
> +        float_raise(float_flag_overflow, fp_status);                         \
> +        sig = 0;                                                             \
> +        exp = overflow_exp;                                                  \
> +    } else {                                                                 \
> +        sig_bits = MAX(0, exp <= 0 ? OUT_M - (1 - exp) : OUT_M);             \
> +        if (lead > sig_bits) {                                               \
> +            shift64RightJamming(sig, lead - sig_bits, &sig);                 \
> +        } else {                                                             \
> +            sig <<= (sig_bits - lead);                                       \
> +        }                                                                    \
> +        exp = MAX(exp, 0);                                                   \
> +    }                                                                        \
> +    return (TO)deposit64(deposit64(sig, OUT_M, OUT_E, exp),                  \
> +                         OUT_M + OUT_E,                                      \
> +                         1, sign);                                           \
> +}
> +
> +GEN_RVBNA(float8_e4m3, float8_e4m3, float32, 4, 3, 4, 3, 8, 23)
> +GEN_RVBNA(float8_e4m3, float8_e5m2, float32, 4, 3, 5, 2, 8, 23)
> +GEN_RVBNA(float8_e5m2, float8_e4m3, float32, 5, 2, 4, 3, 8, 23)
> +GEN_RVBNA(float8_e5m2, float8_e5m2, float32, 5, 2, 5, 2, 8, 23)
> +GEN_RVBNA(float16, float16, float32, 5, 10, 5, 10, 8, 23)
> +GEN_RVBNA(bfloat16, bfloat16, float32, 8, 7, 8, 7, 8, 23)
> diff --git a/target/riscv/tcg/rvbna.h b/target/riscv/tcg/rvbna.h
> new file mode 100644
> index 00000000000..d4d3eced952
> --- /dev/null
> +++ b/target/riscv/tcg/rvbna.h
> @@ -0,0 +1,40 @@
> +/*
> + * RISC-V Bulk Normalization Algorithm (RVBNA)
> + *
> + * Copyright (c) 2026 SiFive, Inc.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef TARGET_RISCV_TCG_RVBNA_H
> +#define TARGET_RISCV_TCG_RVBNA_H
> +
> +#include "fpu/softfloat.h"
> +
> +float32 rvbna_final_f32_add(float32 partial, float32 accumulator,
> +                            float_status *fp_status);
> +
> +float32 rvbna_dot_float8_e4m3_float8_e4m3(const float8_e4m3 a[],
> +                                          const float8_e4m3 b[],
> +                                          uint32_t n_prod,
> +                                          float_status *fp_status);
> +float32 rvbna_dot_float8_e4m3_float8_e5m2(const float8_e4m3 a[],
> +                                          const float8_e5m2 b[],
> +                                          uint32_t n_prod,
> +                                          float_status *fp_status);
> +float32 rvbna_dot_float8_e5m2_float8_e4m3(const float8_e5m2 a[],
> +                                          const float8_e4m3 b[],
> +                                          uint32_t n_prod,
> +                                          float_status *fp_status);
> +float32 rvbna_dot_float8_e5m2_float8_e5m2(const float8_e5m2 a[],
> +                                          const float8_e5m2 b[],
> +                                          uint32_t n_prod,
> +                                          float_status *fp_status);
> +float32 rvbna_dot_float16_float16(const float16 a[], const float16 b[],
> +                                  uint32_t n_prod,
> +                                  float_status *fp_status);
> +float32 rvbna_dot_bfloat16_bfloat16(const bfloat16 a[], const bfloat16 b[],
> +                                    uint32_t n_prod,
> +                                    float_status *fp_status);
> +
> +#endif
> diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
> index 917a48b5106..172ae0f11dc 100644
> --- a/target/riscv/tcg/vector_helper.c
> +++ b/target/riscv/tcg/vector_helper.c
> @@ -31,6 +31,7 @@
>  #include "tcg/tcg-gvec-desc.h"
>  #include "internals.h"
>  #include "vector_internals.h"
> +#include "rvbna.h"
>  #include <math.h>
>  
>  static target_ulong vtype_reserved(CPURISCVState *env, target_ulong vtype)
> -- 
> 2.56.0
> 
> 
> 

Sent using hkml (https://github.com/sjp38/hackermail)

