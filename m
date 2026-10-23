Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7715B606A33A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 02:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=af6Y4P8N
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK4j6-0001ck-Su; Thu, 22 Oct 2026 22:09:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xK4j4-0001cP-U8; Thu, 22 Oct 2026 22:09:46 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xK4j1-0008Hq-Nm; Thu, 22 Oct 2026 22:09:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tMARWbeLeAgyRjWb4yJ+vllJ97ohqUiVyIYtp5bn7GhDzcLZ6whsPIeKatu/p0+AeawOOP7jaOIp4a9MKY9CJf5q9vDHLuPFN4pJEbjpdp2en8T9kqhDv4bc2LRRtS82XTE+ge34c4ZOfjSSbrnwS2QDi6Hucr6M9WNDBFv/p2s18lyJEqop5TRwhZKchCRrl2DsNuuz32SxNPYX+jOpu3+RQ3V+SNhAjoOdzHYF6TXNcPWqreL0PBgW7/hG053Q7NR2hWxGP3TylSISGm4I9S7ElUvzbnU0SIuAaC+hTDO6WgGl4aqMhtlklSm1+TQZzqKDvVjAXv9k/ZlE1y7zwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2bj19nc9oEseaCVl5Qn1B9kEdUisuP9od7siWrbuF54=;
 b=GU2x03n3LJwk8e2viRz7NYCHA0x1sdRIoPImtXK7UiiYaK9QUg3YXFqQaV/milW/t1IMYifcT1rQt77yQXzOMc1wx+E9WsnFvoczT2Va4JAnW9C6Jm/E2WvSlszpa7tpJn165PMbyMVRH8rvq3aOvLr6olnAvX6bK7mWWnd++wtQvgEJgAIYIC77eiRhVTaM8dL1GKZZSuwmlOtTVpufpA+jK0R9BAbQmQ4w2dgy6emhyRTwlJ00oBXMlbBPdBglSXL9anFRAXWbEZnXam3RboqAYNcC5U2EY3QNu5BMqkI8aOLGtl8HNDKUqJ77BR+nRbudJw+/fAKmjZ5tUQ9RMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2bj19nc9oEseaCVl5Qn1B9kEdUisuP9od7siWrbuF54=;
 b=af6Y4P8NkWC7YrwYJJImTFrdX9PgOp/23yCMerLbNKvCquOCcJGiZR6c8P4RcDA1UidVYbfeikpqM8qk2S1O9LUyd/5QZWyzaTAQi+yTokIf7x5tbax1U+wEyzz0c74Tquo6YjrXYnyLlmPnIGtizbtbUnKmQhW2F7WYcShZGGLGbC2J5I8Xjivhr3kC2xz+afPOYUTShXVKzt6RrkmjmrOgLMVD5jUoKdi0pjBjsKFgBdCCSMURWEsBJTT9Lsq1agMAmhiS/inhIlmwlYQxK/D6UhLdHWKrWlTnYpUIHpHXvj7pTk1VyVsOm/mNun8DFJjtK/jxWp32JW1NTdE6PQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by TYSPR02MB7933.apcprd02.prod.outlook.com (2603:1096:405:83::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.18; Fri, 23 Oct
 2026 02:09:36 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0546.012; Fri, 23 Oct 2026
 02:09:36 +0000
Date: Fri, 23 Oct 2026 10:09:30 +0800
From: Chao Liu <chao.liu@processmission.com>
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, daniel.barboza@oss.qualcomm.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com
Subject: Re: [PATCH] target/riscv: Fix CPU state access on big-endian hosts
Message-ID: <atq-jzTZMEPxXL8h@MacBook-Pro-4.local>
References: <20261022130657.6449-1-anjo@rev.ng>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022130657.6449-1-anjo@rev.ng>
X-ClientProxiedBy: PH3PEPF000040AB.namprd05.prod.outlook.com
 (2603:10b6:518:1::4d) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|TYSPR02MB7933:EE_
X-MS-Office365-Filtering-Correlation-Id: ba0670d9-7f1a-4015-5fe4-08df30aaafa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|261022075727099003|56012099006|261021121427099003|10067099003|261009223027099003|261021123027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: kJEI/pr2FtYwWbnWTraDmygbVgMaLSsIzH+/KKmTNZbnJ/29A1gMj18/oviQUk5JFd7Rfj10aYbC9jlEVV41mTVlwcmev65rydC/2p5isP9ItDfFO1UJNfncoIIThIHsIwVGCsCHXmmGUcosao0cRojeGb2Q6mBAG3RKjAYEwiR4lX/c5J3UWsouayAHOl1W68KvTezjvzcVm9s24PnlgmTqeejXkAgJBqM/IJXTSkkIPBzWGnubjVZoNKOVzlCeYEcWaNl8a5y7wP94j5RinZo2WsKl6TtavNeT741MBCp98Z+lecbXRvT4CZzb2/suII8ZTMCEI0fvupsEG0PIiuqyCg+tXgKYew6WmuLPbHUKI6eRNykCpBeR2WXDhH/4AwrhElL90wGvo7U3QTb31bBYWzAiyjKVDK2PKDjek9aZy3dqUYAbn+8e9UsBR9GIFmy4A1+8SiqNvsTJxl6IYtw4TbZCFZwR1QtTvEA9iI0sgvZnTk/QiYsi5qzCZ9ABkowOkjjkunbiVzVqh0UTEcIweL90bGpkEiXKg5NMEJYG9cCuR0sTXzTQ4W4gFLpc3J1qSSuInhqfU7O0/V0xYRGsIRzVSj6RsOBeHXCw9gJo49ioW5lzXMbbH0SqoKdouodS6xTMr1EHiGnxFxJeQmxNfomU0y8cvET/2uMU+yE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(261022075727099003)(56012099006)(261021121427099003)(10067099003)(261009223027099003)(261021123027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ajpYHHKsLX4xt2wULgHDffJ3tS25Yahh3IlIGn+Fubqdfz9AVpvzyL4vm53q?=
 =?us-ascii?Q?lRi0W6FQ8aOvRF3Whpm7z9UpDBqVU3AV8LBzyNNHlI9lT38V1GKfKz7w2dWb?=
 =?us-ascii?Q?He86f3DqsQ3KdwKSva5IXal5nwp3h82ioscaDRxJ2ZFrLMaOjKr6eBQZ3Zje?=
 =?us-ascii?Q?kfSjAg2KfZaO90sXATJ0T+FX86W4pBdarHCQPa7Xuroi01pMlHBccoOvIGjb?=
 =?us-ascii?Q?7Zfz3aZXziYXj7Xyi4jZPPbLIMTIMw5hAsPwc9B/lQvvxb0EK7qfwzFg9/KA?=
 =?us-ascii?Q?YWMvV3A6oAfHB0SAVMlARhNV8h19PlTdoZpu3ba+M9xwFsGu3s0uQNltiOqt?=
 =?us-ascii?Q?8yLQVpQ2OrdyO5EySbPWYn2CJJjt0UmdNoeJBwiGzr2a4AB03HR8axf+t7Ne?=
 =?us-ascii?Q?wPlHSq8XwsXE6EY7U/lcXVa90MzAsP8YMj3VqWGBG79ZvUI4srJGeZVbL9cN?=
 =?us-ascii?Q?VcVmVXflC+3XP6nqizAdZMjeq1PjifETo3dcwAvQnWl5K4u6cFUacCgXV8e0?=
 =?us-ascii?Q?var41d50FIR42HbvZHGqfTvw2Af9UXLzq4L1M+72DyDfU8ahL7yKGbGPhEP9?=
 =?us-ascii?Q?Mehvwn0cKOE4BscLFM6a9mZwfTUw8wz6IlJgL3EiOHtwfnDMPhILoz1N2YbM?=
 =?us-ascii?Q?UQ2CjbJoEjAzTF8/0Y4lp6KjscFTjBhgCXUazRYOMIUN6c95F1h63qBZzfvj?=
 =?us-ascii?Q?ujehJnzA4JR72utjyBdUJHxNvU2QozTKMBu3F/0wn0h445uQK8RtlSclBkmK?=
 =?us-ascii?Q?EzIj8yvZaQFUdRE1szoUEtMMN+6VRNwx3oYo0bhtIhd4wkaD16Pfjhui/P2/?=
 =?us-ascii?Q?FuEQrSBfSRjeTYxeHaOtFulC+smtpsoqWO5obPM/+HQmNZzVgFDCyOSD89Py?=
 =?us-ascii?Q?AQSaDZKBlfMHpk22VpA6XDyI+1MTnUdywy0WTZ3BTrLBi5eJhmtq5GSF+O82?=
 =?us-ascii?Q?OFW9lDYFLOn99gYrjTWsrTc+MyApfiKn41sGlL9EjZkmqfwwv9TO/UkZCAID?=
 =?us-ascii?Q?po2f9tS2GJOeA+KOuYu0aUGz8627pwo11QawR087xHb3YKZgEg1yECaxX46R?=
 =?us-ascii?Q?ydD/nSDYWCNqpBLdCKuxeDt8deY0DDKJRHFSYKF9UUCEJX2xRkcnkjppvI3o?=
 =?us-ascii?Q?Er4gccY5kCuhUoOgWKbqNo9H3xvsRbSFPn3+XzR5puMlSeLjuTAXmdGg4gCr?=
 =?us-ascii?Q?JpBS5x9pdm00mMZT3RqDV82BD0dBwZmhzTlc0TJns9PXSBYQqe1E1GW2Zvwl?=
 =?us-ascii?Q?64xuXteD/2kNCHCfVtfKGxF5PG5vFlx/1n+VAYk3uOMQJS3dKpRXk9bkUXq6?=
 =?us-ascii?Q?oJO8Lzqa7ZYcNm+ICbndyjCSJGtfH0vVavqS7DVSwFs9DnlKQEtM5EG47n4a?=
 =?us-ascii?Q?LW7hdoCjKcBzf4XjkHOiHoIngQzGCia4f1Faj2rFUeR8ltWUIekhVC1c4Ji+?=
 =?us-ascii?Q?Q1jRbHd21gN+adHyvGKuIQZ6EuoiWziYbZxG8q+oncvIqqtXFvHHWyBjjt2J?=
 =?us-ascii?Q?I0iNEq2pVoTFQTkVOpjBXcuQzdD1n2ogUAasWkE6ElOBdsWfu0+Lz2sxvzlA?=
 =?us-ascii?Q?TkDjeXwHLT0IKgZXSEM/QLHMmBu/yAlkcixxNEo8j8+q8Y1Gk15odOHfU/pK?=
 =?us-ascii?Q?o98FBuFmTUd7ASY9Q3JovSMAQ4V4z2D6heuFnZC1HU4DpYon/jmI+HL17OWy?=
 =?us-ascii?Q?HsC1FIsoLIH2y4KLXHu5V1EgShqQtpGuv0RGUxrQpfEg7FLWmDVyYnRNhQE9?=
 =?us-ascii?Q?pXUCnVh3Tf7ZAE5EcVhMu4Bb65fTg50=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba0670d9-7f1a-4015-5fe4-08df30aaafa6
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 02:09:36.2424 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kXmZwHr8f0enbCxbgY+HJUegXzpOzQ7tEt5Nk+jGrK6osEO7dALgrRfq1vUYKJbSoZdRL3i49dBUnMAlI26Nm3EV4TliEjOi4I1qIeVKzvc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR02MB7933
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22, 2026 at 03:06:57PM +0800, Anton Johansson wrote:
> mstatus and mstatus_hs are uint64_t but accessed through
> 
>   tcg_gen_[ld|st]_tl(..., offsetof(mstatus))
> 
> which on a big-endian host running riscv32 incorrectly accesses the
> top 32 bits rather than the lower bits.
> 
> Widen the operations to 64 bit so the lower bits are modified.
> 
Please also add a `Fixes` tag pointing to the commit that introduced this bug.

The format is,

Fixes: <12+ hex SHA> ("<original commit subject>")


Thanks,
Chao

> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>  target/riscv/tcg/translate.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/target/riscv/tcg/translate.c b/target/riscv/tcg/translate.c
> index ede9c2563f..79b0f444ef 100644
> --- a/target/riscv/tcg/translate.c
> +++ b/target/riscv/tcg/translate.c
> @@ -693,7 +693,7 @@ static TCGv get_address_indexed(DisasContext *ctx, int rs1, TCGv offs)
>   */
>  static void mark_fs_dirty(DisasContext *ctx)
>  {
> -    TCGv tmp;
> +    TCGv_i64 tmp;
>  
>      if (!has_ext(ctx, RVF)) {
>          return;
> @@ -703,15 +703,15 @@ static void mark_fs_dirty(DisasContext *ctx)
>          /* Remember the state change for the rest of the TB. */
>          ctx->mstatus_fs = EXT_STATUS_DIRTY;
>  
> -        tmp = tcg_temp_new();
> -        tcg_gen_ld_tl(tmp, tcg_env, offsetof(CPURISCVState, mstatus));
> -        tcg_gen_ori_tl(tmp, tmp, MSTATUS_FS);
> -        tcg_gen_st_tl(tmp, tcg_env, offsetof(CPURISCVState, mstatus));
> +        tmp = tcg_temp_new_i64();
> +        tcg_gen_ld_i64(tmp, tcg_env, offsetof(CPURISCVState, mstatus));
> +        tcg_gen_ori_i64(tmp, tmp, MSTATUS_FS);
> +        tcg_gen_st_i64(tmp, tcg_env, offsetof(CPURISCVState, mstatus));
>  
>          if (ctx->virt_enabled) {
> -            tcg_gen_ld_tl(tmp, tcg_env, offsetof(CPURISCVState, mstatus_hs));
> -            tcg_gen_ori_tl(tmp, tmp, MSTATUS_FS);
> -            tcg_gen_st_tl(tmp, tcg_env, offsetof(CPURISCVState, mstatus_hs));
> +            tcg_gen_ld_i64(tmp, tcg_env, offsetof(CPURISCVState, mstatus_hs));
> +            tcg_gen_ori_i64(tmp, tmp, MSTATUS_FS);
> +            tcg_gen_st_i64(tmp, tcg_env, offsetof(CPURISCVState, mstatus_hs));
>          }
>      }
>  }
> @@ -726,21 +726,21 @@ static inline void mark_fs_dirty(DisasContext *ctx) { }
>   */
>  static void mark_vs_dirty(DisasContext *ctx)
>  {
> -    TCGv tmp;
> +    TCGv_i64 tmp;
>  
>      if (ctx->mstatus_vs != EXT_STATUS_DIRTY) {
>          /* Remember the state change for the rest of the TB.  */
>          ctx->mstatus_vs = EXT_STATUS_DIRTY;
>  
> -        tmp = tcg_temp_new();
> -        tcg_gen_ld_tl(tmp, tcg_env, offsetof(CPURISCVState, mstatus));
> -        tcg_gen_ori_tl(tmp, tmp, MSTATUS_VS);
> -        tcg_gen_st_tl(tmp, tcg_env, offsetof(CPURISCVState, mstatus));
> +        tmp = tcg_temp_new_i64();
> +        tcg_gen_ld_i64(tmp, tcg_env, offsetof(CPURISCVState, mstatus));
> +        tcg_gen_ori_i64(tmp, tmp, MSTATUS_VS);
> +        tcg_gen_st_i64(tmp, tcg_env, offsetof(CPURISCVState, mstatus));
>  
>          if (ctx->virt_enabled) {
> -            tcg_gen_ld_tl(tmp, tcg_env, offsetof(CPURISCVState, mstatus_hs));
> -            tcg_gen_ori_tl(tmp, tmp, MSTATUS_VS);
> -            tcg_gen_st_tl(tmp, tcg_env, offsetof(CPURISCVState, mstatus_hs));
> +            tcg_gen_ld_i64(tmp, tcg_env, offsetof(CPURISCVState, mstatus_hs));
> +            tcg_gen_ori_i64(tmp, tmp, MSTATUS_VS);
> +            tcg_gen_st_i64(tmp, tcg_env, offsetof(CPURISCVState, mstatus_hs));
>          }
>      }
>  }
> -- 
> 2.52.0
> 

