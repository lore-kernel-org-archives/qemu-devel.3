Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC40C60A2609
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=on2N+YUh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQnQj-0000BT-9P; Tue, 10 Nov 2026 10:06:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xQnQa-0008DW-IT; Tue, 10 Nov 2026 10:06:30 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xQnQX-0000VQ-OS; Tue, 10 Nov 2026 10:06:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u1aChguNKGwxoEkVke+z42GD8K74PctoahoeY4CuSFtwXdQx2ub1DZup1YzywxVK3+Os622LMHC1BmvT32M2xqUL1DQBHoNzXIBaq0GWbfPuR1VxJzTClaPzoZfPjfTEmUNIct9wiXLpYXC9YakBEciU9x73Gfln4L+ki+LEBMxc9DkRsK+3XbXp1ySS66ESZzLhHFmkvLFemH1sEBaivfv1qWCvSeqN3JUtnmgh9qMAFSuuKi4ahu6tz+be4fPAMZJ8j7YIQhD7Wnmu4rQ0U56XoC957UgTPJMozgNRUF7Vp1ZuHI8Gv5IU4TAatqpfs5Jk+Xpm3Mst6MKtLBBoBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GTtgzedTEEC26h5aRLpViBxP1YUmGqIFlWG5swr/aS4=;
 b=oH2YO7U4cpeCbQLu9yJ72WOpXT/UllEKhfPbiB+R1faAi2lvMLwMVz1WbvgS/6flf97JeTlRE9EL4bmmeeCNGgZIJhJLeVSB67g+Ew95Gdw/hg65N+lSD+c0MgVnFiMa37SIpib5a6Um8jdSCTBjAyYqG5341TJWccG02zL/PrCZtLah0T79E47xPHLFBbGlMTvNre2NqGSh13/MOFPP3SRdZiJ3YPZ07RodQcFWAkj/gIFFz0dpj84oONktx+okfwvZFuECTundLZJnfQCsBH6hnqR8/aznIXYxpuQrgopcjbPShnpOTFGaZQ/RVu6VjhaEmHVDjoRrmIOP5ZzZCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTtgzedTEEC26h5aRLpViBxP1YUmGqIFlWG5swr/aS4=;
 b=on2N+YUhGLqu69MF2e1ZkwRzvgHIeFO5c5t43CI2v5um89PA9aXY8rEnF9dwoKJXWlB7n3hivlTfXpgjXHdyfjB4DV9cqWxSRJM8qUwL0JfyoD3pj2NIN7hHsGCS4FE0ZMLJHCo9l5uX1/2eSbXq9I9oXpOqmTxgW5ZEJgPAQ3G9KFB6ZzmuGHPTijsJ2R+Uqq9IEg8pRTB0ZiwwLF9tHn98kuRvd9EQ5KiJd5+BQdJ2R7fCRCn1iOBzPiK8U7rACIetml/w3cE33avaXipmvgzkEuusQQm6toESlp9Evni7pKf80g7VTkhC1gLloVv9Xz6zyzwz2w4Efuku9nfQdw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by SEYPR02MB6548.apcprd02.prod.outlook.com (2603:1096:101:16f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 15:06:19 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 15:06:19 +0000
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
Subject: Re: [RFC PATCH 06/38] target/riscv: rvv: Implement Zvqwdota8i
 instructions
Date: Tue, 10 Nov 2026 23:05:59 +0800
Message-ID: <20261110150602.7073-1-chao.liu@processmission.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104194155.679241-7-max.chou@sifive.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0030.namprd21.prod.outlook.com
 (2603:10b6:a03:114::40) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|SEYPR02MB6548:EE_
X-MS-Office365-Filtering-Correlation-Id: 5135b543-a22c-4119-e8bb-08df3f3c2ccb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|7416014|10067099003|18002099003|22082099003|3023799007|261009223027099003|261028144727099003|261102123227099003|56012099006|261022075727099003|261021121427099003|261026121527099003|261022105027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: 5rNIdxWdHi6OmHW4mEL9B12uu9EyKPJAmodgUjUTRq6gl8qL1ULGm0UViHF8YuT6nmGnVcQJYu1bfNry+BMA9pb/MqmvCuvektoscCDJP6v0x3jtTrYJHA5rgbohD+W0jBON92l7Mjw8DfgQNaf0YnZqzDyiMu18xEi+4XuJhUWdV3tQDcSaOT4VhyZahpFAka43NZCk/OvQF3wOdK1b4vlsaWHXHpw9tNtZ+uM8kbh9K+EW+ju5mc5X784fxRPStZE0v4QLGqyqV+DRzBY6o+Ft+uWw1i/sSaAOW1u4fvNJF+d+f2xTrn4uARtVy/wIffKEXGsaaiSSmNhjgwlncu8qTsyd9P7amXwsoyA39U0dA+/pX9CUiSdpPaJG70AUTtJZHQZgkSh/aSup416TSns9wT5CClarUY+RPs5pFhrV+heO/HIAhLaKCL1mkLZcTjDotM5SUuRRn2Hkx6kPDQJZ4r2sBzQYQeQz1kcbQMFpeudmWpqISvREnnPaTUVY+0hDpBYGtSMB0Xvkwe1XtuGCupQgRRj67agLYArUIMUZd2AfTsKm8eIKjuFvw70CjYpina7jlQBsB0qlks6g4rHFx9GDZMmBUL3r6thIoOYFiWy1YQztfzRAD/eHK2M1+Fjbt0eVrV8LI5kYhSKYsENivSbGYdFzwKuf78FE9po=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(7416014)(10067099003)(18002099003)(22082099003)(3023799007)(261009223027099003)(261028144727099003)(261102123227099003)(56012099006)(261022075727099003)(261021121427099003)(261026121527099003)(261022105027099003)(261026140227099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?skCpIZatGylPNsdaCYpWU22VoP3E/63Hf85tuXwHcTvABe8utgMGctZk9wrX?=
 =?us-ascii?Q?CmdAQOXupD8qL7A4eS3/l2dDyNYcrq1UpFCtW0SgiLvhUlwGHpYauGRvvpLk?=
 =?us-ascii?Q?FrhFNILE4e9vyhiB8b9Dah8xMzX4KXVmokVNuTYWES5ByDi7M9x7abwoGIsT?=
 =?us-ascii?Q?JT92oAPWf4DV1k+VeAvebGZwI5jKLHW/0MGTGoCajXbFNdTWIsRsU01pGn5Y?=
 =?us-ascii?Q?rliGvI2BkN4ahO6KVrFWNo28iHjrYbFBfFPTGNpGj+s6hdjcx9KPyd2y0W6B?=
 =?us-ascii?Q?aGBK0mUHgloLvwIXnZ53s+H/gUX5i1srIkoqI2SjHWKtCwDnQ3TpteT81Jcd?=
 =?us-ascii?Q?aI0c5I1Tq8rww9VDIaSsTDSGUIA1+0uIC/ODSm1WdO3AkkfEZGDoNQv5C6IR?=
 =?us-ascii?Q?JVitNhIMBroJmdWrJH9h8zVqDaxwlvy5PaIzwjTgFDcqP2GfMoNq2NliQqUa?=
 =?us-ascii?Q?qiGzHrejMcEzttiUgBR/emasOFEbMqArg5tR1JT+h8l4ZsvIdA4KqDwfb5mH?=
 =?us-ascii?Q?qNZVUATi4NNEcRbMq/Rtscjeseng2HDF/fZG2YCi+jCul1QYqDHNuv+vmUap?=
 =?us-ascii?Q?zo0q9u/ngblvwwIPugImbJ2oaVcv1/IwBNW2bGBEi8hOaRIsrrWyoonksC3Z?=
 =?us-ascii?Q?1gdsyKaoIXkU2hMXLQiAN6uQ9NcRK0q854YnsKEVSSGr15dyAe/4tBVV071S?=
 =?us-ascii?Q?w85M53Vqg+A0onZUv5ml2jFC/Q9X7vh7C02UHG8mmEV5nkQzmmVCAREGJ/fl?=
 =?us-ascii?Q?GJSOh4Jlod3ySRXgyAfW4QZ6yVY/phYMeFur1uHAbG/87nA944irN9mVLWLd?=
 =?us-ascii?Q?T+4+5mVXGQlkiGU4S83lcPscaFIdyxt9rVm1F1L5tWT1STE1HYL1MpnQasHr?=
 =?us-ascii?Q?iYwMMKSDbA9DRPzR8T6zoQxVTE7iETv9YyXPfFp1fFfoQz0bzY93a7NSBjWG?=
 =?us-ascii?Q?jd6UW0rGm05A4yrg5j8LtoGWppwjtm4cxWOstdH1o173tbwNul60z+x+vQNU?=
 =?us-ascii?Q?5Moa+h9Ui5VlRapNFtdRGBHJ/N+jUQ2S5sKWDhgQEOV5YzkmdgutuGURc8aJ?=
 =?us-ascii?Q?Bvcw/PI+l09sA2mP7yBv3prL/dqYo/p4S7xkBQlpzB7Ryxz861Rlh1H0p5yF?=
 =?us-ascii?Q?7BwtaLbUWF79G637UGRAAis+/Thb651mirP93cnoqzpPReJmGOKAsfvnF9hg?=
 =?us-ascii?Q?LLFE9ClExkbqdc1N7Iempu/NalsIYybjmrsIhH1ATRxyXvSlYBXjWWlJ0qm5?=
 =?us-ascii?Q?xGpYB2HKI86qSHmyqXfNgLqxOw8HzbXZ+jHuC92e0f2dWaVhLwRfTvqFzKY7?=
 =?us-ascii?Q?sozlXmpOKnn+NrkDdYMUEg9smxYj4nOo7xELad5B+D8TBVqUKSUIasHx1tcd?=
 =?us-ascii?Q?VfRE4vG7pKcXx37tUYAY/ZTzHlOYF4tZYgGp1zy0BOvkYMBy/gwWJWk0VLU7?=
 =?us-ascii?Q?T02vIjXrb5nBArMbDlFSvAL3QQxZRHvY1NldQmfBSONsFzyZhpHBHCW2aV6Y?=
 =?us-ascii?Q?n1luHFTTTw2VcozNb2ZITKJL5Dv1FfjI7deHCsb8D9oxZsv7IgwNvvDAB6X9?=
 =?us-ascii?Q?NOXQyJ2JCAJoNezHkZGUh2ozhTs30xGo7hBpe9HNGx8h6xTTViGy+A6rh0z4?=
 =?us-ascii?Q?Sb+qo+CRBBugs0EfXBE6iI21ekWySqE79U6Ofls5K+fnC5Ihf5H59DuiDjR/?=
 =?us-ascii?Q?DWI4eR2Y0w3Uu6b0WR9/NOF7vXnfK+TQqjGgiZnqZAWjCmtRX7HNiIO8Vtuj?=
 =?us-ascii?Q?YtLXzPEEGVWaLMaYtHa1772/wLUJqwU=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5135b543-a22c-4119-e8bb-08df3f3c2ccb
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:06:19.2705 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: anYeCvKM73mejSJVy9/i4IRJY3rHWCL+G/LFGPFZFvVFBw1uZCuY2yQ4loo8lct/AxNZlnfRu2UCsIDyNuuv3UTt4N13U3h4/geN3ESqy/s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB6548
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
X-Spam-Status: No, score=-19.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu,  5 Nov 2026 03:41:21 +0800 Max Chou <max.chou@sifive.com> wrote:

> Implement the vqwdotau.vv and vqwdotas.vv instructions from the
> Zvqwdota8i extension. These instructions compute a dot product between
> two 8-bit integer vectors, accumulating into a 32-bit scalar in vd[0].
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
>  target/riscv/helper.h                       |  4 ++
>  target/riscv/insn32.decode                  |  4 ++
>  target/riscv/tcg/insn_trans/trans_rvv.c.inc | 63 +++++++++++++++++++++
>  target/riscv/tcg/vector_helper.c            | 49 ++++++++++++++++
>  4 files changed, 120 insertions(+)
> 
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index 1cffcad580c..767b04658b4 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -1387,6 +1387,10 @@ DEF_HELPER_1(ssamoswap_disabled, void, env)
>  /* Zalrsc SC write probe */
>  DEF_HELPER_FLAGS_3(sc_probe_write, TCG_CALL_NO_WG, void, env, tl, tl)
>  
> +/* Zvqwdota8i - 8-bit Integer Dot Product */
> +DEF_HELPER_6(vqwdotau_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vqwdotas_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
> +
>  /* SiFive Custom int8 Matrix-Multiply */
>  DEF_HELPER_5(sf_vqmaccu_4x8x4, void, ptr, ptr, ptr, env, i32)
>  DEF_HELPER_5(sf_vqmacc_4x8x4, void, ptr, ptr, ptr, env, i32)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index 795badc8a7d..cc7d639ab73 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -1097,3 +1097,7 @@ vwabda_vv     111101 . ..... ..... 000 ..... 1010111 @r_vm
>  vwabda_vx     111101 . ..... ..... 100 ..... 1010111 @r_vm
>  vwabdau_vv    111110 . ..... ..... 000 ..... 1010111 @r_vm
>  vwabdau_vx    111110 . ..... ..... 100 ..... 1010111 @r_vm
> +
> +# *** Zvqwdota8i 8-bit Integer Dot-Product Extension ***
> +vqwdotau_vv  100110 . ..... ..... 000 ..... 1110111 @r_vm
> +vqwdotas_vv  100111 . ..... ..... 000 ..... 1110111 @r_vm
> diff --git a/target/riscv/tcg/insn_trans/trans_rvv.c.inc b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> index 7e1295f33e7..befdbf273e5 100644
> --- a/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> @@ -4132,7 +4132,70 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                  \
>      return false;                                                       \
>  }
>  
> +/* Zvqwdota8i 8-bit Integer Dot-Product Extension */
> +static bool vext_zvdota_base_check(DisasContext *s, arg_rmrr * a)
> +{
> +    return require_rvv(s) &&
> +           vext_check_isa_ill(s) &&
> +           s->vstart_eq_zero &&
> +           require_align(a->rs1, s->lmul) &&
> +           require_align(a->rs2, s->lmul) &&
> +           require_vm(a->vm, a->rd) &&
> +           require_noover(a->rd, 0, a->rs1, s->lmul) &&
> +           require_noover(a->rd, 0, a->rs2, s->lmul) &&
> +           vext_check_input_eew(s, a->rs1, s->sew, a->rs2, s->sew, a->vm);
> +}
> +
> +static bool vext_vqwdota_check(DisasContext *s, arg_rmrr *a)
> +{
> +    return vext_zvdota_base_check(s, a) &&
> +           (s->cfg_ptr->ext_zvqwdota8i && s->sew == MO_8);
> +}
> +
> +typedef void gen_helper_zvdota_int(TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_ptr,
> +                                   TCGv_env, TCGv_i32);
> +
> +#define GEN_ZVDOTA_INT_TRANS(NAME, CHECK)                               \
> +static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                  \
> +{                                                                       \
> +    static gen_helper_zvdota_int * const fns[2] = {                     \
> +        gen_helper_##NAME##_b, NULL,                                    \
> +    };                                                                  \
> +    if (CHECK(s, a)) {                                                  \
> +        TCGv_ptr dest, src1, src2, mask;                                \
> +        TCGv_i32 desc;                                                  \
> +        uint32_t data = 0;                                              \
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
> +        fns[s->sew](dest, mask, src1, src2, tcg_env, desc);             \
> +                                                                        \
> +        finalize_rvv_inst(s);                                           \
> +                                                                        \
> +        return true;                                                    \
> +    }                                                                   \
> +    return false;                                                       \
> +}
> +
>  GEN_ABD_OPIVV_WIDEN_TRANS(vwabda_vv, vwabd_vv_check)
>  GEN_ABD_OPIVX_WIDEN_TRANS(vwabda_vx, vwabd_vx_check)
>  GEN_ABD_OPIVV_WIDEN_TRANS(vwabdau_vv, vwabd_vv_check)
>  GEN_ABD_OPIVX_WIDEN_TRANS(vwabdau_vx, vwabd_vx_check)
> +
> +GEN_ZVDOTA_INT_TRANS(vqwdotau_vv, vext_vqwdota_check)
> +GEN_ZVDOTA_INT_TRANS(vqwdotas_vv, vext_vqwdota_check)
> diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
> index 4ba0a89f4b5..6abcf522648 100644
> --- a/target/riscv/tcg/vector_helper.c
> +++ b/target/riscv/tcg/vector_helper.c
> @@ -5970,3 +5970,52 @@ GEN_VEXT_VV(vwabdau_vv_b, 2)
>  GEN_VEXT_VV(vwabdau_vv_h, 4)
>  GEN_VEXT_VX(vwabdau_vx_b, 2)
>  GEN_VEXT_VX(vwabdau_vx_h, 4)
> +
> +/*
> + * Zvqwdota8i: 8-bit Integer Dot Product with Accumulation
> + */
> +#define GEN_VEXT_ZVDOTA_INT(NAME, WD, W1, T2, HD, HS)            \
> +void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,      \
> +                  CPURISCVState *env, uint32_t desc)             \
> +{                                                                \
> +    uint32_t vm = vext_vm(desc);                                 \
> +    uint32_t vl = env->vl;                                       \
> +    uint32_t vta = vext_vta(desc);                               \
> +    uint32_t vta_all_1s = vext_vta_all_1s(desc);                 \
> +    uint16_t vlenb = riscv_cpu_cfg(env)->vlenb;                  \
> +    uint32_t total_elems = vlenb >> ctzl(sizeof(uint##WD##_t));  \
> +    uint8_t altfmt = FIELD_EX64(env->vtype, VTYPE, ALTFMT);      \
> +    uint32_t i;                                                  \
> +    uint##WD##_t acc, dot_result, a;                             \
> +                                                                 \
> +    VSTART_CHECK_EARLY_EXIT(env, vl);                            \
> +                                                                 \
> +    acc = *((uint##WD##_t *)vd + HD(0));                         \
> +    dot_result = 0;                                              \
> +                                                                 \
> +    for (i = 0; i < vl; i++) {                                   \
> +        if (!vm && !vext_elem_mask(v0, i)) {                     \
> +            continue;                                            \
> +        }                                                        \
> +                                                                 \
> +        uint##WD##_t b = *((T2 *)vs2 + HS(i));                   \
> +        if (altfmt) {                                            \
> +            a = *((int##W1##_t *)vs1 + HS(i));                   \
> +        } else {                                                 \
> +            a = *((uint##W1##_t *)vs1 + HS(i));                  \
> +        }                                                        \
> +        dot_result += (a * b);                                   \
> +    }                                                            \
> +                                                                 \
> +    *((uint##WD##_t *)vd + HD(0)) = acc + dot_result;            \
> +                                                                 \
> +    env->vstart = 0;                                             \
> +                                                                 \
> +    if (vta_all_1s) {                                            \
> +        vext_set_elems_1s(vd, vta, sizeof(int##WD##_t),          \
> +                          total_elems * sizeof(int##WD##_t));    \
> +    }                                                            \
> +}
> +
> +GEN_VEXT_ZVDOTA_INT(vqwdotau_vv_b, 32, 8, uint8_t, H4, H1)
> +GEN_VEXT_ZVDOTA_INT(vqwdotas_vv_b, 32, 8, int8_t, H4, H1)
> -- 
> 2.56.0
> 
> 
> 

Sent using hkml (https://github.com/sjp38/hackermail)

