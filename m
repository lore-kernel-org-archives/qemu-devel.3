Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CCF606A320
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=i3DVMm+U
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR3JS-0008Hj-3N; Wed, 11 Nov 2026 03:04:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xR3JQ-0008HA-9T; Wed, 11 Nov 2026 03:04:08 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xR3JO-0004BF-9e; Wed, 11 Nov 2026 03:04:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rUD6BHRmDm/hiuD25DVkusX6OLdYtVXjuElLQX1wpg7gaEseYsx/g5udwHet+sqQlv6WaJMuxXHDwyyI00iG+tdkG+tf8HLsz19m11bt14qNfpSJ1v4xwqev2kgIy0+FrzMkv0/FG/eBTWgJyyn5hOv1nuB2yjvQ/RsE7Ty/MSVy63jvGCbDknFVVCg4H7YFes4pyTf64Z3K16GFQx65q2eCvySfHf1ijLRjgi/cVN3M9jUAFs+fgCS3Hlot81CBwv9ECeuX9KyCKFs2XruvEmmevqYMlcpGxUR4hCOsFBIQUw+/+v6iLX4Fno66rP+21roRytez00i4SsWAANKRSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifWHdTF/UmqJbxaXWa1XH9lh9cnCCSS0LtKklfyoY9g=;
 b=AUrIEI9GnTxUQZqD+rDpHnLXSHAmVVLbq2SMhM916VYrIehJcfAKTjOiKIuv52V32Ixr17H0yFTh6kjWOviWTgmptOjd1NlB3REOPa6BQi949cJxDYraF7VhY5Av6QSe/vDbNU69G2+WZo4cvTZdyM/hRlgX0dxwMzab91NPWphB+bbinrXSoqqniHB+O8TxZvEqqN+899foSE5B/ZPWn4XGHmaDkOlnqhEp0c+rJ6NbBtGX2rvPt9FhLQMveg4iwYj8u8r7EBrrLgWnvXAKei/Xy4m9Bxvd1YzHOyTiPWdnEwS+vl642X+cnrGITHv7CikHY9dGdIh0dU0Qh+oxbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifWHdTF/UmqJbxaXWa1XH9lh9cnCCSS0LtKklfyoY9g=;
 b=i3DVMm+U9NGfK95TWCEiWPJfs9WqeVoaszUIwD2rIxaXfQytQNY5/TWOatHmcCvzGHAAVj13u6kQbQ+99VjqyRwt3vLohMrATY4Uk/0qGdYS+O1jYffROkEz3hKAUZH8HWLpsnZYqGIW2M+8xKQMrfygmXU8OWz48BW3PWP8328cm1s9QEdzinIFiTr01PfHnuRJ9X4qQ9B7OyKTWP1+60PZecWsGc/viJvS1hAduK60aCv8YtLyv386ss7XkQGBjWXm66gYsBdIRf0qlW93KVKcov3zT6S1/O2L/lgGaDpT2uwRUeZwSGLVpiwH1tTX1eWs/pdrviGMrg/ewSJtQw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by SE3PR02MB9870.apcprd02.prod.outlook.com (2603:1096:101:325::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 08:04:00 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 08:04:00 +0000
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
Subject: Re: [RFC PATCH 25/38] target/riscv: rvv: Implement Zvqwbdota16i
 instructions
Date: Wed, 11 Nov 2026 16:03:40 +0800
Message-ID: <20261111080341.48513-1-chao.liu@processmission.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104194155.679241-26-max.chou@sifive.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0129.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::14) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|SE3PR02MB9870:EE_
X-MS-Office365-Filtering-Correlation-Id: 344d33e4-30c7-4238-4bbb-08df3fca5820
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|7416014|1800799024|366016|261009223027099003|10067099003|3023799007|261028144727099003|261102123227099003|261026140227099003|261026121527099003|261021123027099003|261021121427099003|261022075727099003|261022105027099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: L38Ravw5VT6dqpvlqEtIuRtLn8L0sl7mV70krPv46+W0PdeSgE7ussNerTWa9JkmcvxLd3rwKR+prNLibDpvfvE1+/8cX8MztuhYw6I/bsEMBmJUcfc2cVzzYmX8HPecKrT6mTHBCeyqA7X47fyaJxKZ/v3q4AkLbjiHHO5i+nizYPcfdH5UfXP0ZDIyUgGi4raxjGUkjCM13ELRjHP2JMIaLEOdlZOmxTm6mSGKziNIfK7z2vujBdlOYFOZMM4E7UNwkIeccKwrSdnkBo4SemB81fhKgkL6+XASHonf3+nWID9QwnE9p/9CdPgdYcGCKLcJh7t7gVhi8F/2MBPLY6rTogBO6Xx+VQnuUdHvxjIjKNMVSUGtMC16eX9q13lVZtGSqNHY9CEvjgWAY2pTkA1vske+6LwCs+8Dm4GG55HtR7NlzWljFZRH0z+GSlRGKq7++PhRAU59yRObzUqQE3aOwAZL2VjAOuBkNvUb33UiR63Zosi7s0cqQf4eQMwQfJvyxJk9xmFIm7Pi4jMh85dLzstW+tjKlZ3U6w1ZZQkoO9OP6Hi/F63iTa2IIw6C2tCX1gQ888ZXxhPhPmtpI/HoKdKHORfG4xsFLvuA3b6eXH1oij5JF3rw3tpbfJK6Meh4PydMSt1PeSUXphURAt2fcuFULXGax57Al83ya0g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(261009223027099003)(10067099003)(3023799007)(261028144727099003)(261102123227099003)(261026140227099003)(261026121527099003)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wDU1SpspOpG54kEbJOVcAlazr6xfcdIqZBjJ3am9M+Kq+P2jAxCTgYV2PYCu?=
 =?us-ascii?Q?eVbti08jxP40tj5GNBQYTlvizLYY6dEddZeWQCib6KjOJvYUusnPyI5MvG55?=
 =?us-ascii?Q?RDt3YXzKjIlBWWj++g04uVO6C/4gQFLamt/DHQv/rWD3jlyJ6LQ7kGeOXXCO?=
 =?us-ascii?Q?96f3gwxZoAl3WLwrTf7SIK7u6RHsXR3hEUrZjTpjMiaFOquTHLx2BI/nDwhi?=
 =?us-ascii?Q?DIRGxdXqZ43n843q9rI/mBb2eI0qXCt0to/TDPml+U1TJ9W8acyOxhhoqxHD?=
 =?us-ascii?Q?ljUXSxdMpbQdbVFyg+2oefPsdQe7pYbDJdX7hZddQFhuuYYH+WESPmKWEvh7?=
 =?us-ascii?Q?JYZ/18hDKWORQPSuPX4vvcjjEPZGCd82KhZBPzYn94YjrxY4W9MZnIx6WqXO?=
 =?us-ascii?Q?0QpuFjN8M/aM/oqv/BNyhkyt996EWVrhDj3exLHLZ//XSwlfuZ/1RX7eGohO?=
 =?us-ascii?Q?gfqmHN6YIacyEcNoYkyFy2r3jSzi26+XOxCRpQlV3hGCNuACXnoLYxhzwQNE?=
 =?us-ascii?Q?WPtSYW5ixr59ppWV9KPAtgzGbvY4UT0S2dub4GIdP1RUd8gQAILbdrrZi0f+?=
 =?us-ascii?Q?Q5g5hLIuFWpToXeEqYltabJU/DwPYsFhIaVBBOwlTSDGmBJ2vbZhXrzoydap?=
 =?us-ascii?Q?D+wmt+Uz4tbpkhWYCZQ9IEYY4/XFpsLKSfZU0GNbqtvkebUOBSIrsdK7GF+i?=
 =?us-ascii?Q?FPmDhmPybASnCK5Zvt7BBXWVji96tMnZGhLJMC1OeMtcXOMsAGLZ8tBHEnX/?=
 =?us-ascii?Q?uwpIDlI2+IwzjwjvC9rhMml/a3xlNgtNjj097vaq/tOejHVJP6tEEW+E5dqp?=
 =?us-ascii?Q?+ovvf+lUh6hfHy8lp7pERmcG4ch7MYTiP5083S/K3rVwuoZDaWzpebk5N1Bs?=
 =?us-ascii?Q?rLytOZtISo/PQaS7XWF+QCDpA/g1+bWI7dJnZjgFOTcBMhjACiaqS3PIoA0I?=
 =?us-ascii?Q?0GmNRV0rQ70stFQW2Z82SW9jXRlX0CYdfikQEZfLK3ohV3snAIXbRGKfII/Q?=
 =?us-ascii?Q?5v0vCTSLzEHy2K7nhIezyPdhDBPB7PqBMj2G9nTjX4Ct6P2bO8sIG/UP/JgH?=
 =?us-ascii?Q?L6rkbKEpAsyg77gZ4ZbjPVKwRCOvg7AWBoPpfVVpnKvQR/GE/lytYqxSFYit?=
 =?us-ascii?Q?UydviWs50bdfkYznOpEpyx8wwnDdfwcQMv14sxDASd5zVj3dCV7AbZqfdl4M?=
 =?us-ascii?Q?O/z5pax5h7qdTsTy2lV4WRun7Z+Ztgj3EG5die3O/C1ImIRXNDSlC3gMJeA4?=
 =?us-ascii?Q?WodDGwNUTb8roy97HHiTiWy285Y0dYvAS33KxqVHjXDJZKnRKmCzxzzeTuIG?=
 =?us-ascii?Q?0LARXEPnbIhj9hMIB8ElK+7HdS4DU/SdZ/MwaOva6ZJA3H3XTrBhY5xhou6U?=
 =?us-ascii?Q?WZlU7RPTTQz1nfMl+UlPDiz1ai8nwxf5tDwss4ShlvAgQoeKG4GSXjaoaQYa?=
 =?us-ascii?Q?hufir0PqtIYCtwVLRFSqZuqW/4srOFgfB/j8QR1QOraKdEm01MvT4r9XWGBd?=
 =?us-ascii?Q?Rcw3ng6f0IK5MsX4mjXGgWK73yVDOEWAFVk2qA85c0LBsqKF3aHbmFbHu2VJ?=
 =?us-ascii?Q?sj3AZlTEdpDmmWYI3PobZ2K5mvBgkEhFBrdtYsuNuRyaUUcAdfnH+Dda75MI?=
 =?us-ascii?Q?nWlT8/Bw+Git/y0xb1Xnpy1g3QTfBF8ekbHxYnnh0+jpPuTZnYFcLWuH7Utz?=
 =?us-ascii?Q?2ORb9bpwRpLiaxg/Nzot5pNBvpNLxh9CpRaXPjURNc1YpxsRlwpy4jKfPFgm?=
 =?us-ascii?Q?yFCMLrqK2qFvJM0eXKtb74g0QWjuik8=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 344d33e4-30c7-4238-4bbb-08df3fca5820
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 08:04:00.5059 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xdS6SoLy0Rv343mfjhkW9REK6lwS41NCEjg85caqBKUnYqW8G1HX7hZIDDT1AkLL+ZSBVGz+5WyRkerdYXU48ICn10Bm625PTs8Zv2o/vQQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR02MB9870
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
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu,  5 Nov 2026 03:41:40 +0800 Max Chou <max.chou@sifive.com> wrote:

> Extend the vqwbdotau.vv and vqwbdotas.vv instructions to support
> both 8-bit (Zvqwbdota8i) and 16-bit (Zvqwbdota16i) batched
> dot-product operations.
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao
> ---
>  target/riscv/helper.h                       | 4 +++-
>  target/riscv/insn32.decode                  | 2 +-
>  target/riscv/tcg/insn_trans/trans_rvv.c.inc | 5 +++--
>  target/riscv/tcg/vector_helper.c            | 2 ++
>  4 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index e48b9b4edec..84571a999f4 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -1400,9 +1400,11 @@ DEF_HELPER_6(vfwdota_vv, void, ptr, ptr, ptr, ptr, env, i32)
>  DEF_HELPER_6(vfqwdota_vv, void, ptr, ptr, ptr, ptr, env, i32)
>  DEF_HELPER_6(vfqwdota_alt_vv, void, ptr, ptr, ptr, ptr, env, i32)
>  
> -/* Zvqwbdota8i - 8-bit Integer Batched Dot Product */
> +/* Zvqwbdota8i/Zvqwbdota16i - 8/16-bit Integer Batched Dot Product */
>  DEF_HELPER_7(vqwbdotau_vv_b, void, ptr, ptr, ptr, ptr, i32, env, i32)
>  DEF_HELPER_7(vqwbdotas_vv_b, void, ptr, ptr, ptr, ptr, i32, env, i32)
> +DEF_HELPER_7(vqwbdotau_vv_h, void, ptr, ptr, ptr, ptr, i32, env, i32)
> +DEF_HELPER_7(vqwbdotas_vv_h, void, ptr, ptr, ptr, ptr, i32, env, i32)
>  
>  /* SiFive Custom int8 Matrix-Multiply */
>  DEF_HELPER_5(sf_vqmaccu_4x8x4, void, ptr, ptr, ptr, env, i32)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index bf325229100..8a06547a570 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -1109,6 +1109,6 @@ vfwdota_vv  100100 . ..... ..... 001 ..... 1110111 @r_vm
>  vfqwdota_vv     100110 . ..... ..... 001 ..... 1110111 @r_vm
>  vfqwdota_alt_vv 100111 . ..... ..... 001 ..... 1110111 @r_vm
>  
> -# *** Zvqwbdota8i 8-bit Integer Batched Dot-Product Extension ***
> +# *** Zvqwbdota8i/Zvqwbdota16i Integer Batched Dot-Product Extension ***
>  vqwbdotau_vv  101110 . ..... ..... 000 ..... 1110111 @r_vm
>  vqwbdotas_vv  101111 . ..... ..... 000 ..... 1110111 @r_vm
> diff --git a/target/riscv/tcg/insn_trans/trans_rvv.c.inc b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> index bc12bcb9b72..650affc045b 100644
> --- a/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> @@ -4315,7 +4315,8 @@ static bool vext_vqwbdota_check(DisasContext *s, arg_rmrr *a)
>      int32_t sew = s->sew;
>      int32_t vd_eew = sew + 2;
>      return vext_zvbdota_base_check(s, a, vd_eew) &&
> -           (s->cfg_ptr->ext_zvqwbdota8i && sew == MO_8);
> +           ((s->cfg_ptr->ext_zvqwbdota8i && sew == MO_8) ||
> +            (s->cfg_ptr->ext_zvqwbdota16i && s->sew == MO_16));
>  }
>  
>  typedef void gen_helper_zvbdota_int(TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_ptr,
> @@ -4325,7 +4326,7 @@ typedef void gen_helper_zvbdota_int(TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_ptr,
>  static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                   \
>  {                                                                        \
>      static gen_helper_zvbdota_int * const fns[2] = {                     \
> -        gen_helper_##NAME##_b, NULL,                                     \
> +        gen_helper_##NAME##_b, gen_helper_##NAME##_h,                    \
>      };                                                                   \
>      if (CHECK(s, a)) {                                                   \
>          TCGv_ptr dest, src1, src2, mask;                                 \
> diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
> index 5ea073b6d76..683b14f28f3 100644
> --- a/target/riscv/tcg/vector_helper.c
> +++ b/target/riscv/tcg/vector_helper.c
> @@ -6197,3 +6197,5 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,                  \
>  
>  GEN_VEXT_ZVBDOTA_INT(vqwbdotau_vv_b, 32, 8, uint8_t, H4, H1)
>  GEN_VEXT_ZVBDOTA_INT(vqwbdotas_vv_b, 32, 8, int8_t, H4, H1)
> +GEN_VEXT_ZVBDOTA_INT(vqwbdotau_vv_h, 64, 16, uint16_t, H8, H2)
> +GEN_VEXT_ZVBDOTA_INT(vqwbdotas_vv_h, 64, 16, int16_t, H8, H2)
> -- 
> 2.56.0
> 
> 
> 

Sent using hkml (https://github.com/sjp38/hackermail)

