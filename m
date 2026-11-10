Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E7F606A33F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 01:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=i8d++ZuX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQaWN-0004OI-AL; Mon, 09 Nov 2026 20:19:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xQaWL-0004Ni-Bt; Mon, 09 Nov 2026 20:19:33 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xQaWJ-0003no-8M; Mon, 09 Nov 2026 20:19:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LFRAlVUgYSHuz/bze1ZQ8+0laCUwNnoOuPiccnqk9b4cJ1t/jImyxe4F2lN/+UyF+YYh9aeo9YRIBzVnGeiOfAcTsuhzKToUOPgg0MTzQaD5ZyBiBEUK86hjNcIVmvkyIi7KpzhXGEbJKRb7W1c3W0ad3j1oNE6MjolH2rGEbyptxr2dAEVoaF3q9hxVQ9fONoxpO0HhsUHrdsaLArV4DACRt5GB4Wk5B0S5HP4Xy9oQEcoy73Uoeh6CrUBDTZed1iSUhMJ4cb9rp8JiiIdlDafN7QAlOSOViqfGlDmIUhrzlnb2ktOjglg6D72tJ93l9ErrKMwiGPg1A7dJ5GPDBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0d/6L2VaQoILHIBY3MJ1RhSsdEfDRBSOZBhBrbbIM3U=;
 b=hsIm6/4x5Uf2JPoC/L2TAEzE0ROOxjndLU7E8lTCNgVnaVzwlxIVjW+WE7/DIVRKt1+RYnDCj4AVBBptGDRC4rl9r+dtqaH0tFneWx+RbeYTzUN2J9OYoKKvPLtWW4oQoHNGyzjlzim87UuX8Qe7Y+VexoQvsUjhc2URxiaKyOLgID+08q6mI8yGuPKT4nN4b+lV7ZAXWUOJnBeimbftyDW4sUY7ZAQhMnESZVepOfQ0MBzJK5ciXR3OhNYBvFIlmRZ7DWN5JHlavlQYhflY25QlsjKlqTFpqbV6RkZo1DANBNT+3ZwJlWOkQ5vUTA2CMcFxtAZJ2n5YVoc29Ddyrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0d/6L2VaQoILHIBY3MJ1RhSsdEfDRBSOZBhBrbbIM3U=;
 b=i8d++ZuXxCRjdzfGeYe9uBtcBI3Z06IR66aqQqJV7FDHBt34vZE5ktLjqZ6qtkXV1siSSgwYFd8bNeeNU8Ib4fzQ0EykwbugEoM6llQx3HsxohB5inkrSOJSQMmBy5BFRY75ktqscz4gkZz5uDIdI/OyLBPLxoRE2LNyCNe+tSd/f5VpbZgULTa20orn5McckM9+ZooQ5KGfC7BBJJuWxSJ3SZpSMH2CMonUDocvIw6r+YdtXbvfaObfKu1Vvadasri/YbKSIoTiEGxaN+3Ws1vXF4Tk2lg7YDp3x2BCN3+JEBkmmL7j1fKe7NEKMD4Q+IMD3r6oyPN50XpxTZ7Mjw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by KUYPR02MB9329.apcprd02.prod.outlook.com (2603:1096:d10:93::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 01:19:22 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 01:19:22 +0000
From: Chao Liu <chao.liu@processmission.com>
To: WX Chen <wxchen0913@gmail.com>
Cc: Chao Liu <chao.liu@processmission.com>, qemu-devel@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org
Subject: Re: [PATCH] target/riscv: Use gen_goto_tb() for vsetivli exits
Date: Tue, 10 Nov 2026 09:18:55 +0800
Message-ID: <20261110011901.14512-1-chao.liu@processmission.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104-research-vsetivli-direct-chain-20261103-v1-1-ace12cf5280a@gmail.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0018.namprd10.prod.outlook.com
 (2603:10b6:a03:255::23) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|KUYPR02MB9329:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fc989ed-2cf8-452d-0ca9-08df3ec8a692
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|261009221727099003|56012099006|261021121427099003|261021123027099003|261022105027099003|261022075727099003|261026121527099003|261009223027099003|261009221227099003|261009220027099003|261009223327099003|261026140227099003|261028144727099003|261102123227099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: xteY1AufW5oMNx8OxBssiYHUsb0PMijI0UrkyeeMwZqCtlOrwuVH+PQLp0XwPQPkauzv6yz6B+AZB7pZf/dyhnC2V8GAcoZRMAn8jwDGLxBs3Dg/5ikND7UWbgiwpLaWDm3HnjKLuwRX/tGJKw6/D6QVMW47FBuV+XFOzdqgUq2IObu5wvNMdh32Znqib+HMVmR7lyBwR/hCwoSwPAMvpOKzAHMcGnLpTwfFc+IBj5Sec6UGcgHovqiUBEXmA1bVVc9IIljnxVhAW7iW3c7o7u0+y3bjy0WyaxWE/Tg10cpNEIrSjpUKoYtEpO14LIFaJdNXXl4RD7pafM0ospwBhZWl+BL9IBjklwbL5UFHAn/Odc4E4eq/JjLswKHIR2NgTVcZB9Zt63jhiTReCJGGWWeMp/eBPQckcTHy+Fafno0WLBjktMxEtqxJ6AsoQA7Y9J3c6oorHvESHQ6tja3hw+IR0v/x4NYqGzfrGYrhz0e4ljurDalm/09p++eqY2GfMkeoOJecITKSaZicw3r4+chxJPZJTxeOj3ee7vvXxa3lglDrbKw5JTVqUlyf04hEYIJmcB0G/8Dw0OSdUQlK1pClzcB/nov05B05MnFhXBUBXcHuxYLCWc5DrpXAFNvmpr0Aq0xEPyyscZKob/crQkBVfpJ/h5lQxBNcZrkeO0o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(261009221727099003)(56012099006)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(261026121527099003)(261009223027099003)(261009221227099003)(261009220027099003)(261009223327099003)(261026140227099003)(261028144727099003)(261102123227099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vOVLL5k4hs1fFON+gMXItMWAiDjY+pvBKgfq3duIfLB00tsHpeDo41B2j3pK?=
 =?us-ascii?Q?MxycYpSavHJu2Os/o6odk5IPuTzyz0KHTVhb6quj+yiM2XCqujE/8gBx4j7G?=
 =?us-ascii?Q?PWGoCaLKxMo4p2z0J+gy8i8Zd4/5/CEtNB0nAGeOvw9FB3VKnZ3/Fh6gPK2E?=
 =?us-ascii?Q?jh5CTgycAy/Cwwx2ljII7Z3Ugo2W2/cHbr9uoj6U0wgkrdx70be2xpksszYb?=
 =?us-ascii?Q?x3nTVwJAiyKRgMk8c8besQmuyInNAC10/me12bl40/B316efVbxw6yFAEdvZ?=
 =?us-ascii?Q?43vMhFgKEUXadcXL4/VI/DUWAecbKCN54vWIAuxRZWkyRJoXRp+AfGASooaC?=
 =?us-ascii?Q?Rv0w+SU3eQoCUep2jqqqTVIU5e0SpHSD8E92PzxFy8S/dXQ27r/cYh3gGram?=
 =?us-ascii?Q?Rxy7oqEIFgBCEm9wTTeZcLBZjX3Mz3+gqBJJqmqVXK2rc4WPQ9JVvqP779q+?=
 =?us-ascii?Q?/yCQfWyXqsHiv1glopEJz6xWZIQ0p3QwDP7HKXBAzxbtsz2RtGvrRnEwRwvE?=
 =?us-ascii?Q?1XTOe+Y/v5omixhTKgFZExsStOHZJvtnfkEhsQeRMRgf+uczSMuX3OKyILAT?=
 =?us-ascii?Q?BWbDa9hEfkeS114w3ITi+b9vHSFIjiq9CPc88cFFSHPf7SYxdmUzN86P2Jdt?=
 =?us-ascii?Q?chGSmNR6M6Oz85HGm3EQc0xIqjJPeLs7d/u8DI0oiwFAl+IZOitIyFwnbgws?=
 =?us-ascii?Q?nk4Dq88tydomNim2YCaJT1ESUWmiNaCbpmwCTOC+9RU3R8Rmc0AnQaNwHjim?=
 =?us-ascii?Q?vzS/5VlHWz4bl+Uvs4POOzWwrHExybpi+DepNwtwc1ZPOdFpskSQSz5sBtq+?=
 =?us-ascii?Q?3o3U81tCq+S8ooAW9DYFRUr4Pp6yPPk9g7r+I4GiLR+SUaSpWGa14LEJ+clS?=
 =?us-ascii?Q?sTmuvbdn5EGS7thrXyMzfMMyfUBT2W5NuLu6KN5f3JxyFvF2Ya8g1A96SE3C?=
 =?us-ascii?Q?MhfBUf69CXVuK3soLNUIoWWnQfsrOqEnpvJJKeiEh/VtM+QPFkxtp5/MDQOZ?=
 =?us-ascii?Q?SqLY5/1aINkSJCzsxrOWfkuYJySmbUuAZobaea/TO1V3chBktvglhFlK+lQH?=
 =?us-ascii?Q?j1nFnPBQZaHQqkYxC7Y4RjeCh9zl5o41iy4tpWDxOTkTpIK48BwqF1zs49jQ?=
 =?us-ascii?Q?dCOgajZRX5ugkczkO+wCvRdylyRSDibIVom6Ko+vktPhWv9dIFybAk4DOgeW?=
 =?us-ascii?Q?OvotWj3/myuKuYnxqUs/SPKqV6TjefTM7mCZR1vq5EPJ20/YKBeBKi522A7A?=
 =?us-ascii?Q?c5xQ7QWcDeJWH1HW9zJInEfDO6Dc+vf4qynauhH1twsEhOmCccPQtjpijE3i?=
 =?us-ascii?Q?uB9MeaZCn3eW6YEgW/N8/XcVm5ZpffHXTkR/kwQREN3XMh0xR7OIo73lLVaF?=
 =?us-ascii?Q?7VLXMSht+LEa9ddoIzMlSnqdpW7uMTDyM6usb9nCcKE3E5fcziwWvMaWkmqU?=
 =?us-ascii?Q?f3QtBAOTPUHqsLzOgs9cCAAYWd93jlWrSPBYW2o/Q1u3ZvOtA8aUGeY/RgHq?=
 =?us-ascii?Q?UDIfQq/xsqzhH0h+3SuhvxRTCsegsoj2atUXWjcHtZScad4ndejmBQIapP9y?=
 =?us-ascii?Q?DR3HtWQ0VgkaxdC6nDnvR3v5Camw/ln3qld1bDpKe/X3s2Q/Wf8vTsQXJx8o?=
 =?us-ascii?Q?6djFdfWS9l6CQLlm552cOLL+WdOu5i4aUzJVTDjlYJuT+rJF27cd6hCYVKir?=
 =?us-ascii?Q?fJ2B2WRrnAJM363jM+PMtEtz8HS72D7oUBV+h0Xo8dijYK6rUM9gPoA3Lrxx?=
 =?us-ascii?Q?j6WONM7I7dhGkC5Ju10fnRkCSh/6bxU=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fc989ed-2cf8-452d-0ca9-08df3ec8a692
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 01:19:22.0675 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nFpalO85rWaqqonLrVxKgIZetWqw1DtL4pDAPQRsXVaO5HjMrSWF4rHAk1AKcq+sE0TPcW37K07zQYcA3cqrPzq3q8p/cXD42Eeuz/Zcq3c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR02MB9329
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

On Wed, 04 Nov 2026 01:34:44 +0800 WX Chen <wxchen0913@gmail.com> wrote:

> This change adjusts the translation exit of `vsetivli`. While preserving
> the existing helper, state update flow, and TB boundaries, it uses the
> generic `gen_goto_tb()` path to reduce the overhead of repeated successor-TB
> lookups.
> 
> `vsetivli` is used to set the vector length and type, and both its AVL and
> vtype encodings are provided by immediates. Given the CPU configuration and
> the source TB execution context, after this instruction completes normally,
> the vector state changes relevant to subsequent translation are
> deterministic. Therefore, this exit is eligible for direct TB linking.
> 
> Measured on an AMD Ryzen AI 9 H 365 (x86-64) host, using qemu-riscv64
> with -cpu rv64,v=true,vlen=128,elen=64. A RISC-V GCC 14.2.0 cc1 built for
> rv64gcv compiles the packages with -O2 -g0 -march=rv64gcv -mabi=lp64d.
> Only cc1 runs under emulation; make, the compiler driver, assembler and
> linker run on the host.
> 
> Each variant is warmed up once, followed by three paired clean builds in
> AB/BA/AB order, using -j1 and fixed host CPU affinity (CPU 7). Median build
> wall times are:
> 
>                   Before (s)    After (s)    Wall time reduction
>   LZ4 1.10.0         125.017      123.060                  1.57%
>   zlib 1.3.1          71.062       70.310                  1.06%
> 
> In a separate untimed test, a loop executes two vsetivli instructions per
> iteration for 37 iterations. Host-side GDB entry breakpoints show that
> helper_lookup_tb_ptr() entries at the two successor PCs fall from 74 to 0.
> The guest still executes 74 vsetivli instructions. Initial TB dispatch and
> link establishment still occur through the normal dispatcher.
> 
> Signed-off-by: WX Chen <wxchen0913@gmail.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
>  target/riscv/tcg/insn_trans/trans_rvv.c.inc | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/target/riscv/tcg/insn_trans/trans_rvv.c.inc b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> index a22e2cae6ce8e5a055c106fb76c305c92ac53d3c..b299c82d7a29057433e280b49b5220e6ad71498f 100644
> --- a/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> @@ -234,8 +234,7 @@ static bool do_vsetivli(DisasContext *s, int rd, TCGv s1, TCGv s2)
>      gen_helper_vsetvl(dst, tcg_env, s1, s2, tcg_constant_tl(0));
>      gen_set_gpr(s, rd, dst);
>      finalize_rvv_inst(s);
> -    gen_update_pc(s, s->cur_insn_len);
> -    lookup_and_goto_ptr(s);
> +    gen_goto_tb(s, 0, s->cur_insn_len);
>      s->base.is_jmp = DISAS_NORETURN;
>  
>      return true;
> 
> ---
> base-commit: d73149283205645625bfa9fe029cfb68e4c4a9ae
> change-id: 20261104-research-vsetivli-direct-chain-20261103-69536f07be37
> 
> Best regards,
> -- 
> WX Chen <wxchen0913@gmail.com>
> 
> 
> 

Sent using hkml (https://github.com/sjp38/hackermail)

