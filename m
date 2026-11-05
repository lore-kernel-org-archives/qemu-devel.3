Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58919606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 07:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=PkqHwYvi
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOs6a-0007Ha-PD; Thu, 05 Nov 2026 02:41:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xOs6Y-0007HE-Uh; Thu, 05 Nov 2026 02:41:50 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xOs6V-0006yX-Ub; Thu, 05 Nov 2026 02:41:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c6Z7i6yjlyPci2lpTy9tZIbjnsnYePufY1EqDWMakQzbRj7jxUgpLZg6qegGUTr4TuH+Kjttof9Twv7HBuXH02r2li7a6ofCrkT75lYuoGZS84K/EWZ3jt4e/dpjh9yLTtpxYfREeEnCUbXzHd0IaH2Ro5PxoAE3V5ogPFNUcZdfTViuawVbrhT8ndhQgg56/XtC2LzA8bTD6SCOtO4mEV2ksDYit5e2r612gkCFUJ5t1kAnj3J28rHySXW/3Zbnaimc1LD5RRs5ymIyqnhhr9x15p2QmnYwsvW4oR15CFnBdeVBIAA2JiQwfoHH2gdvOtHYX2DiqfnJHF6gU8V3GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eP63kEllUrcbgZaQlDpIbQGMxtiinIzvznAhSfRP6Zc=;
 b=OO3cCxHT3cWkq/uodsEHPUrG8YKTUt42lvmHyMubSWV7m7wU/10t/w1Rhv93htLKI7WyQyuZ+8UKUqqgrqQ8VLYQgp9mTHRV7ZII7t1B6cqaic23Uw4wuWgt8CWn0Er0UO93cJrNfKkMrYH4AwcSqa1SuoGz5LcBNwh3UsJjtxbGSXwaqk1WicWDsQnEifjVarxL4g0BkYDIdzK7DWO08D77VXY43OBlPdXPa7VCJN/C6tWvTh2ZaEmtIMmgSK2i8iKZyNI7kWGKp0zwF0UJnuGaNoUTMNncHCex7vK1mNRab74eu9M6mnoA9mUBd3ta7dkEnR4NqYnEYFT9ZTTQXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eP63kEllUrcbgZaQlDpIbQGMxtiinIzvznAhSfRP6Zc=;
 b=PkqHwYviWmZ8k4Zh9xDgtyOb/7rXQz7dpMcIY8ZTC/eDRlDm8+cg6gsycO2xCxV8Mco95BMDAcxbYlNREu1Wt564hFBmaHm+0NNiGotO0/C6+HbQ92YYG8Iv+I1svvC5oBYOj+RxJVhlJCwncDBXmr/StsUIh9lnS2Zqjc3rWO6LPd3xM+ZZuSgrtY4sGhkCPhrTiMOfS0xKavGeCGApQvD0gfy3bjLboSR4H0Nk0PziHFtvfUYgwYzziUcVw8Hd3NvuRN66hVVOvZ/hYENQkUM33KYnkfg5nlbopWS3ZKEFh20zR2NLFEMr0iHKvbZRY9un1YhPtYARNh/0s9uBUg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by KL1PR02MB6569.apcprd02.prod.outlook.com (2603:1096:820:ee::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Thu, 5 Nov 2026
 07:41:37 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 07:41:35 +0000
From: Chao Liu <chao.liu@processmission.com>
To: WX Chen <wxchen0913@gmail.com>
Cc: Chao Liu <chao.liu@processmission.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH] target/riscv: use gen_goto_tb for vsetvli
Date: Thu,  5 Nov 2026 15:41:07 +0800
Message-ID: <20261105074115.99275-1-chao.liu@processmission.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104-research-vsetvli-direct-chain-20261104-v1-1-7d5737100a27@gmail.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR07CA0036.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::9) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|KL1PR02MB6569:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bce1876-6b9e-4d7c-b49c-08df3b1037f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|260925021311599003|260925021911599003|260925022911599003|56012099006|261021123027099003|261021121427099003|261009223027099003|261022105027099003|261102123227099003|261022075727099003|261026140227099003|261026121527099003|261028144727099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: quKRSp0AhuyLkCztOCDhermYYOdhwJ5aqBFsj9SEykFjbN2CyHnIg3PVcAW7lunnzy5AS1Kvw1jjq4axm/W5D5P4PBr8hgc4VLRZrNxTvwxIPUJlq3tzBGzHye9+GRzkYHEqETcQhPBVPMf8zlEBhkrAyEkLUWbWr/buB2WWpiUGxu8DaYVm1nJjp9Yyc/VSqkS3CK8lKcJ17Pwa80o4ScPKjiX+8Aqrd9Q+zrCQ7NAF28HT9F903NNgvui03PsNXkrKw3J7h9gPLPQ2T908m28EU82lpHkQxf44qJCdZwYwkSDBO6kNVJS5vYMpVmv7O1pRaS7UIeOCJ8ar5Gf/PMqA5rZjsqMv408N3ThP1wuoZdvUQCKOC8H9I1fBXJBWEkcCaduquaS12p7lIDe1YVNGc2dkyQiydiIKsdIjkD4ILtl2v9iWcxiOczSp7cIPt5od9EdwwBGTvx6l89Wnl7jvcVsQ8KWDPtVuFqzDZiKO15p54OewIdKi5r399cdzWcmSHmSpxtn1bi3mJ19VgOq4SOMEt/8hsNWIxh60NzzqHR7J8u5RMJ6JHNg7vewIleJuoENz5jW2lWHc46zVV92mCa64wXethXzJGFGEWLFoIsZo2WS5iPp6eoBB8QL42ObSjqvav7E8zXFh1fS89o1FtX4jOYvOkqbB3mE5GUE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(260925021311599003)(260925021911599003)(260925022911599003)(56012099006)(261021123027099003)(261021121427099003)(261009223027099003)(261022105027099003)(261102123227099003)(261022075727099003)(261026140227099003)(261026121527099003)(261028144727099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OcGl3v/vqAGV1knya/LrchZmDAbPGQhAZMkz0Ck0vCbrhwVGejiUHgW65toC?=
 =?us-ascii?Q?+PmfUuHj+daC2WP5FlHQbhbXsq7SArf/qhiJyHGBqApKTFc3/gjURNCO4eS1?=
 =?us-ascii?Q?tWvPQIT5jpkVzLBmZIAs7p6KKTZ152p+DVg83tyg37vlmAHH4t8Ry6tHtQtS?=
 =?us-ascii?Q?3uDRwyjazEdGou4YR/ziVUcCcAlfGGhEM9s/EuK/E5PIntM7z4e2CTlpL76u?=
 =?us-ascii?Q?quWnnY0CxRBlPpkkAmp+nco1SzQ/PHlicnYIrj5oDVUEf5amhmtXooT+UGd4?=
 =?us-ascii?Q?J0eIU3iEGanCnIFFqGGfTxRLr/yApYr0m0uws/fFL4IqnHlJlruFbFvrn1D+?=
 =?us-ascii?Q?x6es9j0kX/zDENlQwvVX48IyyQvuW+BW3512ujcVCkASu5PoCUCdWXr8WbE5?=
 =?us-ascii?Q?OvoEK164/wib8/DT8D1F/PHjMtqSLBMpIGOcx4CXyEbWxJ4pbnK5nCtsyPb2?=
 =?us-ascii?Q?sLryjt4gSH2nBwY4YYYNZTBNXtEuSQEhFF3GdiUM4wCQjxK45PMDyxRKIIaJ?=
 =?us-ascii?Q?nx4frlX9+uLMoOV3zjrZ2IzwF+0O2GRBH3YSQyTDOdbHYCzSRJ98mj4c9mQJ?=
 =?us-ascii?Q?l/hQLYEvH4RF2WHl4tbYgyhoPOvDwO/KCZQSP7nA38Ywrx4aEc4XmF115yHv?=
 =?us-ascii?Q?EZjWxVBtrztVrR52cHr1NKs7/nvWDOdzxlmJWips+ljijbjRNy8MsBGhxGSx?=
 =?us-ascii?Q?vMvBwDzIVkRHqFw+ECkxjrszRtBNWmpkGY48KY8lqUuTkjQo6nLff+L5MZYi?=
 =?us-ascii?Q?PrwmJfce3+7DNPx+yHEL51VhvIrkgkZmVr40QUzDTdbLRdJJztyEsu5aCz1s?=
 =?us-ascii?Q?trTUHuiBR7Uq4FBvxFzqBQOYa21M8ei7C6EwEtebLChKB5yFLRfqo3GncsDn?=
 =?us-ascii?Q?qNfLWrmzeChGYGw4nKDeI5s3o+7NbqgvRdz+KLpc96z0ORGWAsuwRi8600o3?=
 =?us-ascii?Q?VMTvTWX/A283L6D8HdF0+sTRPujrmc+BOSqqujdAhM+1+i7XjA0d9Xxu/SLv?=
 =?us-ascii?Q?n578xaT0+oi1vZ1Z22j7awAb0KaL196oKBq7HXx+8HQeU3IqjR9biuM+PupT?=
 =?us-ascii?Q?GKsRIrExtkq03mEQw36FzZ4+bT2/TizWOTU3JvNNyV+W7N4wSHcy4/m0SzUB?=
 =?us-ascii?Q?NtOriyT7ivQd/3wV6ThfIzS4shNOtShYaCyval1RPeNbnGZDpBUBybe4HYtu?=
 =?us-ascii?Q?83i3DMwbdclmDsg4q5NhlydEVLNyiCwcQaPZMJLcSj1s4b6XdDkZ0DKBRALO?=
 =?us-ascii?Q?eQDQd/UN3GEj+oH104l3bogIOxHJ9NS6dz10URRMEBSd4KsTadcBGL5i2Wik?=
 =?us-ascii?Q?l77o6D9W1yw+IcfKPj44gP7YniMknxrcvg5B9G4TE4j0caUscnF7TsQah2kO?=
 =?us-ascii?Q?oLeosmSjx9GiSSYxND15dnInaW+B70AQpGDq3RZk0+YyAeZh8wKid7l8NTBG?=
 =?us-ascii?Q?1PFb2rxH6nJ1RL7N/PEAbF0UMfxXaLxo4uEP/oyBAwJwwCqc8fLfh2J8eG2L?=
 =?us-ascii?Q?yriGJ02zwzxZgjOfRVsiD2k/wFsK1ewdL05tQ26ALVdZd954mOuD5tE9vI1k?=
 =?us-ascii?Q?O0HBKfU4+5QuIhzQjWQYTAKkuRYVDq7c3Vbj8rtdts73e5ZAvgkE/mJG/H5x?=
 =?us-ascii?Q?ZHuOqnJPKM018ru18ctEL3s11sXd3BW/DMED0h2enRxLoR9cdjH0sJgzMqmP?=
 =?us-ascii?Q?WCfFOcSTLk2Zd/KFfdxoUEGr6fySy8yT/VSZbKxtpcLw5lynre7J1mP1BxpO?=
 =?us-ascii?Q?B9hmvutUaiagMW8qgonLszwmHB50efg=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bce1876-6b9e-4d7c-b49c-08df3b1037f5
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 07:41:35.6292 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ow0Ex4Xv65QYJiSVOQSgbRxugw6K5P8cweySjFAtppYSBHB/HugNSHaRoq2TrkWoDqLE5Bnf9Bf7caPXMkXgjFZGqOH5/05nUARt1dwmSXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB6569
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

Hi Wu Xing,

Thanks for the contribution! I have few comments for you.

On Wed, 04 Nov 2026 15:55:24 +0800 WX Chen <wxchen0913@gmail.com> wrote:

> This patch uses gen_goto_tb() to reduce the overhead of the
> unconditional lookup_and_goto_ptr() exit currently generated
> for vsetvli.
> 
> The shared do_vsetvl() function handles both vsetvl and vsetvli.
> The two instructions differ primarily in the source of their vtype
> operand: vsetvl takes it from a register, while vsetvli provides it
> as an immediate.
> 
> When translating vsetvli, the immediate vtype provides information
> that can be used to optimize the exit generated by do_vsetvl().
> 
> To use gen_goto_tb(), each jump slot must correspond to a deterministic
> successor-TB lookup key (pc, flags, cflags, cs_base) for a given source
> TB. The relevant state changes are confined to the vector-related
> translation state: VILL, SEW, ALTFMT, VSTART_EQ_ZERO, VS, LMUL, VTA,
> VMA, and VL_EQ_VLMAX.
> 
> For the vsetvli forms optimized by this patch, given the CPU
> configuration and source TB context, the immediate vtype and existing
> state update flow determine the other relevant translation state.
> Only VL_EQ_VLMAX can vary with AVL. This patch therefore uses separate
> jump slots depending on whether the returned VL equals VLMAX,
> enabling direct TB linking after vsetvli.
> 
> The register-vtype vsetvl instruction retains the existing lookup
> path, as its vtype is not known at translation time.
> 
> Measured on an AMD Ryzen AI 9 H 365 (x86-64) host, using qemu-riscv64
> with -cpu rv64,v=true,vlen=128,elen=64. A RISC-V GCC 14.2.0 cc1 built
> for rv64gcv compiles the packages with
> -O2 -g0 -march=rv64gcv -mabi=lp64d. Only cc1 runs under emulation;
> make, the compiler driver and cross-binutils run on the host.
> 
> Each variant is warmed up once, followed by three paired clean builds
> in AB/BA/AB order, using -j1 and fixed host CPU affinity (CPU 7).
> The SQLite workload builds the amalgamation and command-line shell.
> Median build wall times are:
> 
>                     Before (s)    After (s)    Wall time reduction
>     LZ4 1.10.0         125.120      123.867                  1.00%
>     zlib 1.3.1          70.269       69.911                  0.51%
>     SQLite 3.45.1      438.322      433.213                  1.17%
> 
> In a separate untimed test, a loop executes two vsetvli instructions
> per iteration for 37 iterations. Host-side GDB entry breakpoints show
> that helper_lookup_tb_ptr() entries at the two sequential successor
> PCs fall from 74 to 0.
> 
> Signed-off-by: WX Chen <wxchen0913@gmail.com>
> ---
>  target/riscv/tcg/insn_trans/trans_rvv.c.inc | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/target/riscv/tcg/insn_trans/trans_rvv.c.inc b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> index 7e1295f33e7d4b7a2ff26cbf428f6b5d9eb682ff..5e9a861b6af1565485e9be89b393d0d64080a662 100644
> --- a/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> @@ -191,7 +191,8 @@ static bool require_noover(const int8_t dst, const int8_t dst_lmul,
>      return !is_overlapped(dst, dst_size, src, src_size);
>  }
>  
> -static bool do_vsetvl(DisasContext *s, int rd, int rs1, TCGv s2)
> +/* A negative vtype denotes the register-supplied form. */
> +static bool do_vsetvl(DisasContext *s, int rd, int rs1, TCGv s2, int vtype)
I suggested that we replace `int vtype` with `uint32_t vtype` and `bool vtype_is_imm`:

static bool do_vsetvl(DisasContext *s, int rd, int rs1, TCGv s2,
                      uint32_t vtype, bool vtype_is_imm)

>  {
>      TCGv s1, dst;
>  
> @@ -215,8 +216,22 @@ static bool do_vsetvl(DisasContext *s, int rd, int rs1, TCGv s2)
>      gen_set_gpr(s, rd, dst);
>      finalize_rvv_inst(s);
>  
> -    gen_update_pc(s, s->cur_insn_len);
> -    lookup_and_goto_ptr(s);
> +    if (vtype >= 0 && (rd != 0 || rs1 != 0)) {
I would like to discuss this a bit further. In fact, we can divide this into
five cases:

   Case                    Condition                Current implementation
------------------------------------------------------------------------------
1. vsetvl  rd, rs1, rs2    vtype from rs2 register  keep lookup_and_goto_ptr()
2. vsetvli x0, x0,  imm    rd == 0 && rs1 == 0      keep lookup_and_goto_ptr()
3. vsetvli rd, rs1, imm    rd != 0 && rs1 != 0      new path
4. vsetvli x0, rs1, imm    rd == 0 && rs1 != 0      new path
5. vsetvli rd, x0,  imm    rd != 0 && rs1 == 0      new path

Currently there are two TB exit forms:

 - Case1 and Case2 is the existing lookup_and_goto_ptr() exit.
 - Case3 ~ Case5 is the new split exit, which compares the returned VL against
   VLMAX and uses two goto_tb slots.

The new path can be improved. For rs1 == 0 a single gen_goto_tb() call is
enough, because the successor TB lookup key cannot change between executions.

So, We give three exit forms:

  1. lookup: keep lookup_and_goto_ptr()
  2. single: one gen_goto_tb() slot
  3. split: compare VL against VLMAX and use two gen_goto_tb() slots

The cases map to the exit forms as follows:

  Case   Exit form
  --------------------------------------
  1      lookup
  2      lookup
  3      split, or single when maxsz < 8
  4      split, or single when maxsz < 8
  5      single

For cases 3 and 4, we care about the case where VL is not equal to
VLMAX. To explain this, let us look at VL_EQ_VLMAX first. It is computed
in riscv_get_tb_cpu_state() in target/riscv/tcg/tcg-cpu.c:

  vl_eq_vlmax = (env->vstart == 0) && (vlmax == env->vl) && (maxsz >= 8)

In two cases, the AVL comes from a GPR rather than an immediate, so
VL may or may not equal VLMAX. Using the split exit is fine in that
situation. When maxsz < 8, however, VL_EQ_VLMAX is forced to zero. In
that case, both VL values map to the same successor key during the TB
lookup, so a single slot is enough.

> +        uint32_t vsew = FIELD_EX32(vtype, VTYPE, VSEW);
> +        int8_t lmul = sextract32(FIELD_EX32(vtype, VTYPE, VLMUL), 0, 3);
> +        uint32_t vlmax = vext_get_vlmax(s->cfg_ptr->vlenb, vsew, lmul);
> +        target_ulong pc_save = s->pc_save;
> +        TCGLabel *not_vlmax = gen_new_label();
> +
> +        tcg_gen_brcondi_tl(TCG_COND_NE, dst, vlmax, not_vlmax);
> +        gen_goto_tb(s, 0, s->cur_insn_len);
> +        s->pc_save = pc_save;
> +        gen_set_label(not_vlmax);
> +        gen_goto_tb(s, 1, s->cur_insn_len);
> +    } else {
> +        gen_update_pc(s, s->cur_insn_len);
> +        lookup_and_goto_ptr(s);
> +    }
The following code is for your reference:

    if (!vtype_is_imm || (rd == 0 && rs1 == 0)) {
        gen_update_pc(s, s->cur_insn_len);
        lookup_and_goto_ptr(s);
    } else {
        uint32_t vsew = FIELD_EX32(vtype, VTYPE, VSEW);
        int8_t lmul = sextract32(FIELD_EX32(vtype, VTYPE, VLMUL), 0, 3);
        uint32_t vlmax = vext_get_vlmax(s->cfg_ptr->vlenb, vsew, lmul);

        if ((rs1 == 0) || ((vlmax << vsew) < 8)) {
            gen_goto_tb(s, 0, s->cur_insn_len);
        } else {
            target_ulong pc_save = s->pc_save;
            TCGLabel *not_vlmax = gen_new_label();

            tcg_gen_brcondi_tl(TCG_COND_NE, dst, vlmax, not_vlmax);
            gen_goto_tb(s, 0, s->cur_insn_len);
            s->pc_save = pc_save;
            gen_set_label(not_vlmax);
            gen_goto_tb(s, 1, s->cur_insn_len);
        }
    }

Thanks,
Chao
>      s->base.is_jmp = DISAS_NORETURN;
>      return true;
>  }
> @@ -244,13 +259,13 @@ static bool do_vsetivli(DisasContext *s, int rd, TCGv s1, TCGv s2)
>  static bool trans_vsetvl(DisasContext *s, arg_vsetvl *a)
>  {
>      TCGv s2 = get_gpr(s, a->rs2, EXT_ZERO);
> -    return do_vsetvl(s, a->rd, a->rs1, s2);
> +    return do_vsetvl(s, a->rd, a->rs1, s2, -1);
>  }
>  
>  static bool trans_vsetvli(DisasContext *s, arg_vsetvli *a)
>  {
>      TCGv s2 = tcg_constant_tl(a->zimm);
> -    return do_vsetvl(s, a->rd, a->rs1, s2);
> +    return do_vsetvl(s, a->rd, a->rs1, s2, a->zimm);
>  }
>  
>  static bool trans_vsetivli(DisasContext *s, arg_vsetivli *a)
> 
> ---
> base-commit: a3565937b39779d4e3704298095f566e7559ad53
> change-id: 20261104-research-vsetvli-direct-chain-20261104-206bc2104ddb
> 
> Best regards,
> -- 
> WX Chen <wxchen0913@gmail.com>
> 
> 
> 

Sent using hkml (https://github.com/sjp38/hackermail)

