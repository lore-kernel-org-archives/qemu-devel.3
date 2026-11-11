Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E719F606A324
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=HVi3Clzm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR3dk-0001m0-9T; Wed, 11 Nov 2026 03:25:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xR3di-0001ck-PQ; Wed, 11 Nov 2026 03:25:06 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xR3dg-0007wP-KD; Wed, 11 Nov 2026 03:25:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZTP8Rzs7qki6c1lSlZ6iN5lOqogiAMKLyXX7tbpYSyRfsQucV0HViDsuRC3I+xnugXCzw2vRHD3yCttYb/gde2Ca7AGYVbnl5Luq2Eki3320xmlz0Bm/V7FZ5UOMkGQko5qGK97HCpjkrikVcPfPjNUgFqIXYJLscqCsELSZButjsONyWcg51uGMEy/rlRFkIycX7FmJGfeJMz19pDjTpiQClQPfm63BFtWCc93tD8eApaNiwdpcmdwzDTJH47/DPcG0CYt6Wzsp6485b9BprLy84yy094imyItA/Pv32A7eSqWmvYNnmr1lmpY2oTlybgyYMj9h4yiJk3zWOmaUcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SgcNrYoEIo+1DzegBgaPMc/dKrZQzrcsAk3QJM4JruM=;
 b=sYAs24VSBSdkCMhV4i0xGIMuD/j2FTU5y7AGIjFnuRSMyY//IidgjlBDyQ/VbD1oCAB8k0wgpSeNxjkAwFb/yQRlR3tF6iXRDOGUQdnl1lShoF76u5zcwdEZFwEp5rAqITkgElr22Qm7qRT901TYy/Bbk73k0uhPfVts3q5MJ8ZBEWViWg4fQ7uQ1lD5ZjrX81hqnBKSpI7RIMiBB7WFuC6bs/Vzlhmz81ZUfh+SfBgkPAhczN0bfeFlVejdKvLnM0o77O7i/bIy33coLakNFnq8TmG0uFuXYWA+vrQCrwVvfHqW7e9kBucTah1flXMHT73+6iZW9IRdmzDdkg6aWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SgcNrYoEIo+1DzegBgaPMc/dKrZQzrcsAk3QJM4JruM=;
 b=HVi3Clzm3+rCwtfNUN2cNUCSBU6TuwxSynHlORwKBcqIYsqVmH6hY6ldXrBRYpfbLdYYgabUN1ij0bqA8RbppzeXHurUcr6VqUtuHNUtN0khi+tKJtG1XNJTQFSF79F9iJ7nRV3PVO5iq2WlAKAkBhQ7DmFjQBpjOB2KcGo9cv32EchuD9WeQx+iB3ceqBjEWN60hw/ic7aVI1tE9WIafacCjxhcdhTFT4/j6FwTB+gRcCAk3tp6painwcBgd1Go9GuOrAnidLwgEjo+4m2KMivUX0vQo/DIPlTK1cUdZ2c7DV2l8qb6Gcuc3aEgHQS8jjeB4rDOdyLYJhaecxLrLQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by SEYPR02MB7810.apcprd02.prod.outlook.com (2603:1096:101:20a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 08:25:00 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 08:24:59 +0000
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
Subject: Re: [RFC PATCH 32/38] target/riscv: rvv: Implement Zvfqwbdota8f
 instructions
Date: Wed, 11 Nov 2026 16:24:42 +0800
Message-ID: <20261111082443.60614-1-chao.liu@processmission.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104194155.679241-33-max.chou@sifive.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::11) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|SEYPR02MB7810:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c9e5cbe-df95-4fa0-26f3-08df3fcd46c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|366016|10067099003|56012099006|261022075727099003|261022105027099003|261021121427099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|261009223027099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: AJ+EjTBfuemnHnlr1D+coRBez/FC/5omOy3WuEf/lIpM4IsHlSIIorqaer7XXTdY9ioUWL16DYQTVCymLOv656l+r0PxBr+m94aj256Lzrkc2/X62kpFEd5SoDzKKQt92z0DSQ4dxmOs1zLGoXBW0T/xbykH/PKI7/2b3meQ+btvnL9j7zNXKnV7YZXEtaIxtwUepkYidIHekNY9AXkm7kN44Lc0tZH9+Ue1PMXzq0po53RovlCc+X8jtUJ708DYbazWCNHYyITD5vifZK7dJe4cWAVnw8r6YTbl35tZVKvpdtCNN0l6qw0v79vPEIyeLi/ZB76qV/ajZpS4oCIX52bshPX8rBcxoWCQqjypHaxIaKuimk+ZEvIhpy1vewRYNVUeiz0x2YOwky/+bBFpwe24SJInzMMB22S4pZEpk+64srOg4PZpjFLX/V8QK0g3Y30ldEez9gUkLvc9mb6JKOQm/wYRqfVW+p8IxJ1JL8CabgkhinDlaCNxyBQJJpB+Qzoe46FVRFgWKnAgOq6CD6kcLiqGf0cQucXnWmrLP5vXWcLLYc0SdUNRjQRIlPenSAzP4siGxo/hGaYoWwjd6c22i46WmyoocFTZwm07NsSohyYS0OYLsAe61EP/JLeoDyURCErglG+fBfeMMkzG3+56vBGiT3ODsQzVWiXsBnM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(10067099003)(56012099006)(261022075727099003)(261022105027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iYA4fbyrxhz+icD8M/kf2x4JOXw4a+vgWw4QWUTunx9jsH4GhCS0iFhLJAz7?=
 =?us-ascii?Q?1tQsw1wlXJpyBIPcqQh2uve3Ko7JVI0H4f6PEVY7iUFNGOudRT3trS7en6YX?=
 =?us-ascii?Q?Pi3sFl2uwFsDimVSBahtDFSM2+5L1FaDzbnHWKn/Gdw5PymGzetPu6GMvyJZ?=
 =?us-ascii?Q?gFIv0zqIVrZqirc6zAE95KSKe6uRfC3L4yeCUArj/qq6e5uj56h4ichWB5wx?=
 =?us-ascii?Q?9eysUEGeDzDRQb671AEOz5x6QKwRhg6PZW9+sb50tYsK/Ae5584Zfz5DG7Q2?=
 =?us-ascii?Q?/pRWkijJSyNx9LNqj8ZWHkAli/NRGgCKm4xF7dj7PYDeSbtweakPXNJfJJXr?=
 =?us-ascii?Q?ltM5Fdszy4D3BqSIg4A6UQRoP0ehXzjCp21TOmFxxNvMLgF3wi/gZ3H0vcif?=
 =?us-ascii?Q?rH+lZlmpNdOtkBYKXg4zzMax3FDREATiDJJ8oLaquFq0oWDqlz9hEZn/z0h3?=
 =?us-ascii?Q?8E94+xC/ILD3XnGnRdO5A64/Wqbm8YGRh7y9iNUJQV0BX7xS+/Wo+Y+BJ0pm?=
 =?us-ascii?Q?E5knd0vcMv2wzJh2sATIhLQEdwjXzLXknW+G64I/yTsYI+4W9ewQD5mINAhV?=
 =?us-ascii?Q?YPRX++Dx8s9VovHSUkWcG+4+hPZg3gJyhFzxyTZzcNvxhLVxdKik1W8SPGZ3?=
 =?us-ascii?Q?dwhUPDNOW45I7zykyVn1iJ9CMAWNNNAjG53Tj79kUZRsZAArju/NwQHhceee?=
 =?us-ascii?Q?XGAJOzY27A6pnb+0+xG4R3OFGZQzzxsqjj1EXapJEw6uGq8xT9bH9bfbwHPw?=
 =?us-ascii?Q?siD80MlYp0GSwzzbGQNLB5HgqLYAFvWbLLKmfyT2HxgnlAImb/QeZU6idjX2?=
 =?us-ascii?Q?ZPiIX4x/5t6oYQn+/ndRpHOJM8DcnBVOb/voo8rtGtBRMExgwNPLIoVCSk/6?=
 =?us-ascii?Q?NjneboxR+Adg/eza04uIdCFypHl5HtBvHuogqKPlvSGJVX8etUH5swN15eEe?=
 =?us-ascii?Q?/FPUdZpIKU/qVvhRN4rgpqtJK/B5pAG2wvb+s+NBNfvfzmWSSemMUehl5RfQ?=
 =?us-ascii?Q?YWNgO9KU2ol7DjwsNfBGNO07pymTaTuZ6oL/HPw8bRzFAFjBqwF+Ge/9ogTV?=
 =?us-ascii?Q?w4g/M/AnVGXZg1JTbao1oQVzjmCQwzUS0whHMPEXo5R8BIEAnJzhEWP/O1W3?=
 =?us-ascii?Q?IhFoe80ubdpSzU/PNE0bB1P+m/ETnJ2J+4vXe8GnnD3Qfih+GPZOgIQrhs2b?=
 =?us-ascii?Q?mBhz6kxxJwhPxrbgzrTiWTMBiO1rq7LCLLJiUmjJywI12ZQWF9itirGFvTAn?=
 =?us-ascii?Q?8/rTPSN5ki290zFT8MB/YVEMxuQvaaa+Fl2kM701K0ViC1FhvVavfMyComru?=
 =?us-ascii?Q?RKs8Zo+xJDJ1Ht9Z5MXzicEShGRm2QF7xJlJsvv3CyuCdbnEztykH15Sd4xW?=
 =?us-ascii?Q?gp205h/wZ7p/aurmiHDkYnY5HlsHWiu7cWsksIOrMUtbvZy+V+JY9NiXLy0f?=
 =?us-ascii?Q?Iq22fheGXaZXNwaEhRrm8jgkyo6sS/jQd5ITOji0GxBM2I6OXJlDJHguQqhY?=
 =?us-ascii?Q?oe3IRT6MJT3QdxgwnYwWvn+STTkUWvLeZU4HPU2tq+6nYpoi8DUH4kxMZT+o?=
 =?us-ascii?Q?e+cGj2tqfv6wlWVRvIUs8RP12Z/YlgzeGqZdTeGuZgRZ+o8QpIw40mdVlcX/?=
 =?us-ascii?Q?XaCKcbmjDBEjCPdYLsY77105BDZ2EN+uKrOQCECzOSl6DLiZuj+jjeP5D46E?=
 =?us-ascii?Q?fujCv7Hf5OS3Hv/q5h3aR4RaQQbzTcaiWfKBAlyk+0U2Lpn3QhdWt6ka4UYx?=
 =?us-ascii?Q?OHOkA39hEUJ0x1dNoMyZMlcoNLQk4ks=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c9e5cbe-df95-4fa0-26f3-08df3fcd46c8
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 08:24:59.8940 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 42G9DZm74+W+PEynjOoSqx+oYjNB4OcRU+zCSs+g/OAir8jT18Q0Ve1dZ0Z77in26exJ8PEVMK99LahKb7UyuhmOFyQITA+RP0XZmisOVIE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB7810
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=chao.liu@processmission.com;
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

On Thu,  5 Nov 2026 03:41:47 +0800 Max Chou <max.chou@sifive.com> wrote:

> Support the Zvfqwbdota8f OCP FP8 batched dot-product instructions.
> These instructions perform 8 parallel dot products between OCP FP8 vectors,
> accumulating into FP32 elements.
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao
> ---
>  target/riscv/helper.h                       |  4 ++
>  target/riscv/insn32.decode                  |  4 ++
>  target/riscv/tcg/insn_trans/trans_rvv.c.inc | 13 ++++
>  target/riscv/tcg/vector_helper.c            | 69 +++++++++++++++++++++
>  4 files changed, 90 insertions(+)
> 
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index 1f2dfd6d557..a257436fb31 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -1398,6 +1398,10 @@ DEF_HELPER_6(vfwdota_vv, void, ptr, ptr, ptr, ptr, env, i32)
>  /* Zvfwbdota16bf - BF16 Batched Dot Product */
>  DEF_HELPER_7(vfwbdota_vv, void, ptr, ptr, ptr, ptr, i32, env, i32)
>  
> +/* Zvfqwbdota8f - OCP FP8 Batched Dot Product */
> +DEF_HELPER_7(vfqwbdota_vv, void, ptr, ptr, ptr, ptr, i32, env, i32)
> +DEF_HELPER_7(vfqwbdota_alt_vv, void, ptr, ptr, ptr, ptr, i32, env, i32)
> +
>  /* Zvfqwdota8f - OCP FP8 Dot Product */
>  DEF_HELPER_6(vfqwdota_vv, void, ptr, ptr, ptr, ptr, env, i32)
>  DEF_HELPER_6(vfqwdota_alt_vv, void, ptr, ptr, ptr, ptr, env, i32)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index 00ed64b73fd..48597915f7b 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -1108,6 +1108,10 @@ vfwdota_vv  100100 . ..... ..... 001 ..... 1110111 @r_vm
>  # *** Zvfwbdota16bf BF16 Batched Dot-Product Extension ***
>  vfwbdota_vv 101100 . ..... ..... 001 ..... 1110111 @r_vm
>  
> +# *** Zvfqwbdota8f OCP FP8 Batched Dot-Product Extension ***
> +vfqwbdota_vv     101110 . ..... ..... 001 ..... 1110111 @r_vm
> +vfqwbdota_alt_vv 101111 . ..... ..... 001 ..... 1110111 @r_vm
> +
>  # *** Zvfqwdota8f OCP FP8 Dot-Product Extension ***
>  vfqwdota_vv     100110 . ..... ..... 001 ..... 1110111 @r_vm
>  vfqwdota_alt_vv 100111 . ..... ..... 001 ..... 1110111 @r_vm
> diff --git a/target/riscv/tcg/insn_trans/trans_rvv.c.inc b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> index d4678171ac5..50f0f67ea60 100644
> --- a/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> @@ -4417,3 +4417,16 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr * a)                 \
>  }
>  
>  GEN_ZVBDOTA_FP_TRANS(vfwbdota_vv, vext_vfwbdota_check, MO_32)
> +
> +/* Zvfqwbdota8f OCP FP8 Batched Dot-Product Extension */
> +static bool vext_vfqwbdota_check(DisasContext *s, arg_rmrr * a)
> +{
> +    int32_t sew = s->sew;
> +    int32_t vd_eew = sew + 2;
> +    return s->mstatus_fs != EXT_STATUS_DISABLED &&
> +           vext_zvbdota_base_check(s, a, vd_eew) &&
> +           (s->cfg_ptr->ext_zvfqwbdota8f && sew == MO_8);
> +}
> +
> +GEN_ZVBDOTA_FP_TRANS(vfqwbdota_vv, vext_vfqwbdota_check, MO_32)
> +GEN_ZVBDOTA_FP_TRANS(vfqwbdota_alt_vv, vext_vfqwbdota_check, MO_32)
> diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
> index 6f3b666784e..e641e21d088 100644
> --- a/target/riscv/tcg/vector_helper.c
> +++ b/target/riscv/tcg/vector_helper.c
> @@ -6258,3 +6258,72 @@ void HELPER(vfwbdota_vv)(void *vd, void *v0, void *vs1, void *vs2, uint32_t ci,
>          }
>      }
>  }
> +
> +/*
> + * Zvfqwdota8f: OCP FP8 Dot Product with Accumulation
> + */
> +#define GEN_VEXT_ZVBDOTA_FP8(NAME, TYPE_VS2)                             \
> +void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,              \
> +                  uint32_t ci, CPURISCVState *env, uint32_t desc)        \
> +{                                                                        \
> +    uint32_t vm = vext_vm(desc);                                         \
> +    uint32_t vl = env->vl;                                               \
> +    uint32_t vta = vext_vta(desc);                                       \
> +    uint32_t vta_all_1s = vext_vta_all_1s(desc);                         \
> +    uint32_t vlenb = riscv_cpu_cfg(env)->vlenb;                          \
> +    uint32_t vd_emul = vext_lmul(desc);                                  \
> +    uint32_t total_elems = (vlenb << vd_emul) >> 2;                      \
> +    uint32_t vlmax = vlenb;                                              \
> +    uint32_t altfmt = FIELD_EX64(env->vtype, VTYPE, ALTFMT);             \
> +    uint32_t n, k;                                                       \
> +    uint8_t *a_vec, *b_vec;                                              \
> +    float32 acc, dot_result;                                             \
> +                                                                         \
> +    VSTART_CHECK_EARLY_EXIT(env, vl);                                    \
> +                                                                         \
> +    a_vec = g_new0(uint8_t, vlmax);                                      \
> +    b_vec = g_new0(uint8_t, vlmax);                                      \
> +                                                                         \
> +    FloatExceptionFlags pre_fflag =                                      \
> +        get_float_exception_flags(&env->fp_status);                      \
> +    for (n = 0; n < 8; n++) {                                            \
> +        if (!vm && !vext_elem_mask(v0, ci + n)) {                        \
> +            continue;                                                    \
> +        }                                                                \
> +                                                                         \
> +        for (k = 0; k < vl; k++) {                                       \
> +            a_vec[k] = *((uint8_t *)vs2 + n * vlmax + H1(k));            \
> +            b_vec[k] = *((uint8_t *)vs1 + H1(k));                        \
> +        }                                                                \
> +                                                                         \
> +        FloatSNaNRule pre_snan_rule = get_snan_rule(&env->fp_status);    \
> +        set_snan_rule(float_snan_never, &env->fp_status);                \
> +        if (altfmt == 0) {                                               \
> +            dot_result = rvbna_dot_float8_##TYPE_VS2##_float8_e4m3(      \
> +                    a_vec, b_vec, vlmax, &env->fp_status);               \
> +        } else {                                                         \
> +            dot_result = rvbna_dot_float8_##TYPE_VS2##_float8_e5m2(      \
> +                    a_vec, b_vec, vlmax, &env->fp_status);               \
> +        }                                                                \
> +        set_snan_rule(pre_snan_rule, &env->fp_status);                   \
> +                                                                         \
> +        acc = *((float32 *)vd + H4(ci + n));                             \
> +        *((float32 *)vd + H4(ci + n)) = rvbna_final_f32_add(             \
> +                dot_result, acc, &env->fp_status);                       \
> +    }                                                                    \
> +    riscv_cpu_check_fflags(env, pre_fflag);                              \
> +                                                                         \
> +    g_free(a_vec);                                                       \
> +    g_free(b_vec);                                                       \
> +                                                                         \
> +    env->vstart = 0;                                                     \
> +                                                                         \
> +    if (ci + 8 < total_elems) {                                          \
> +        if (vta_all_1s) {                                                \
> +            vext_set_elems_1s(vd, vta, (ci + 8) * 4, total_elems * 4);   \
> +        }                                                                \
> +    }                                                                    \
> +}
> +
> +GEN_VEXT_ZVBDOTA_FP8(vfqwbdota_vv, e4m3)
> +GEN_VEXT_ZVBDOTA_FP8(vfqwbdota_alt_vv, e5m2)
> -- 
> 2.56.0
> 
> 
> 

Sent using hkml (https://github.com/sjp38/hackermail)

