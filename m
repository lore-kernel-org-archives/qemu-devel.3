Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A63CC6B3A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 16:12:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHO3P-0003ew-78; Thu, 15 Oct 2026 12:11:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xHO3I-0003e0-JF; Thu, 15 Oct 2026 12:11:34 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xHO3C-0007eO-Si; Thu, 15 Oct 2026 12:11:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=viMbm3lTAiR2CBu4OAprer3TeQPXb5iCOoQeTpOAVNXNb1RF1Udbe6kghmR9SmUvYn48FMAfxoO8Xlh1i6bl3QIqvRyfGOZz1lzNH5uje0a8LxXbWipJai0gTiUv/n1bScfhszyQAokrvvxZr9kmU1dJqg5/QtGmZs1nLTAH8zlE0BYpN843CquowIL8deXd/PcQwL7CzARzcHJ6vG6aMiCUlXYcD3+fuYKPWmeyRJKavZXDUXtTPXTr7d05diNl8TBEKzeVTFtxmTBn2Ih2DT6jyqlO91Y+BHzw37IF7DBYg+rv4uQiSrgDUNVbfPbYvW5fuunvild2fHp0w7Ulyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YLxdg5QgqBFbe2uqjCmPM5UY2Id/eQPUgAU5adM00jY=;
 b=D9R0zVJ+jRNYIomzOA0AceGZEq1vj7D3BDbQ44zjU68F7Pd9nRPgFA+GAPSnXPJ4foqk85h+3NowsdmAvBEwLlxMddbiT7MfgAh5BOVXW/cTXH+bOQEOoaEDK7nRfO/n4856zy6sq4oblbdZlse3sxSRMu2xTJAWEjiNLidvAyW9jWt8TftgMRSeWwbKyooW4rDl8TbxnRTxznCHJeUdtdV88jTt9KZfEgPH0oC67yoX9D/KwhfhbBO9E6+WbWE3jVVztCvvr7qo/KJ+etfLsnl5SS4C+h9Xt571SBCcYlArGBCs/Qf+qQ6KG4ub/BWanNOmOnsDMeYG8D/DatLQTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLxdg5QgqBFbe2uqjCmPM5UY2Id/eQPUgAU5adM00jY=;
 b=hVhqGpPbssyIe9PLikPVSzO/TVh6cLGiBOQnYZMN+kJqe6zU8C5049KBj30ViMFazTA/OvYvS1aSg4N6lNo2dvsOeiZcUKWUQ6Ci/5tuVxmzcZ1/5VxYZRkUlkg1zTHQgEH6veyYMRORHVTpxcADiq6gUrLL7tCjsp8mwYeozZ/EQe4uRFaJ7Y5Q5BOglqkdvkwc/yH22buf38aNN7HRkTnI4yW3VtgNUsgpI2BkKdSrSmbfmFRkq1J2uNk0bgwtsvm1P8xXhRXUPsibjm78xplxne7ZF9NlPr9UK/TnEobgyUsDRVM95Pup8YK06RrkeMwDQeZahb880240KfJzJw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by SEZPR02MB7968.apcprd02.prod.outlook.com (2603:1096:101:225::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 16:11:13 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 16:11:13 +0000
Date: Fri, 16 Oct 2026 00:10:41 +0800
From: Chao Liu <chao.liu@processmission.com>
To: Mingliang Liu <liumingliang.dev@bytedance.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 Alistair.Francis@wdc.com, zhiwei_liu@linux.alibaba.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, richard.henderson@linaro.org
Subject: Re: [PATCH v4 2/3] disas/riscv: Support vabs.v pseudo-instruction
Message-ID: <atD680v20YjwUC1J@MacBook-Pro-4.local>
References: <20261015134337.3354723-1-liumingliang.dev@bytedance.com>
 <20261015134337.3354723-3-liumingliang.dev@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015134337.3354723-3-liumingliang.dev@bytedance.com>
X-ClientProxiedBy: PH7P220CA0151.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:33b::11) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|SEZPR02MB7968:EE_
X-MS-Office365-Filtering-Correlation-Id: 084da83f-4c22-4494-4bf0-08df2ad6ef23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|18002099003|22082099003|10067099003|3023799007|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: hwFF1OuMhMcqVBiD3975N1zLYR5dWJd7JjIIYqMOEF52+Xn+gsjdfnYGC6KUse3ly85O0H32uGv6VCXBiSb6pDxDwNILVFjcW21KaRgwbyl3e9nd7jaIW1JDSnAXylpOn/OLaNxi4DP2lG5ssHUdxsX87pqGOkw59M/ookZ2cJxAuDMqmPNZDloSOAqItIQcs0VIRrsWDY+496VYuHPo8/8FzqJvpFcyx3p28bG02WCVVvrWF1EwR/5mkt2PEyqP7/VxG4F01GwST2sU35uogpbckf7zTsnQs5UWUBPYoMYQcoJFtu3oY5nzXN3DnrFs7qJXlAUxJXnzLPpo2dQ8oKEnJTcebNQG9rmRHYv6x+jgMvJmPg37+woWHgKd1Eli3EXbDYQRp8nzfYEdiOcPaFdG/YgDrA2HMVtUmHILYCax2XZv9kh7H71ZCG1Aje0yz9+4DnRzKU0E0cZ0ECi9p17kKNR6SWp7Wyxfs+aVMSP20iR5EM4uvVeUthwmZTCCQKExiYiJmj4NtaLV4wwen4JHz3IYlrDvPFRctGJq2V6c4wxA6WqycVh+9cS4gurYJYORqq500a5DNeJaux3GVwBdfU74W7ZSd+rD1/TVLJaYYxSw1oSBV+eyKR9dT52TtFfWcclxAWCAtHBebho13YPRFD9QB5h//Dl9FLb9mh8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(18002099003)(22082099003)(10067099003)(3023799007)(4143699003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LKWv6VNMrQhfnwTpus6UBe0hev6NY+8GYYwUtCF5/ronYxIsijDJd2731hVT?=
 =?us-ascii?Q?CTrFrkY2qnUN+EXiGzo6pkNS5F3HDHl3Y+ZOkxF3WEMzDrdaoF68cG3luPWT?=
 =?us-ascii?Q?MaOjaglsKaGjbJqW7nT44oioErsumrGJqzeqUM4qntMk4cVOkw2Xm950a8mu?=
 =?us-ascii?Q?6CvFi8BgoooPDT1RmBh7dP6S76CqfFsz8sLW6uoT7Pmhtn9EfWgXvmcQu5i6?=
 =?us-ascii?Q?1Wwof/xhunZMukM7ksSQMpzK2i/11KF0+mwSncA2G1yauwn9S6780aKanwB6?=
 =?us-ascii?Q?Jkb3tYoWdvIz/eK6zi5yRZq2Knq+Hbtgjj/EwdKjoZcOvrpjZ5BLnhcBM018?=
 =?us-ascii?Q?o7HAilLgqYAvSPgwWxkCM4fbgFCrG0DSPF9LgKE2M/5A6VijfsJycOHsdD4D?=
 =?us-ascii?Q?Tn8TYkCFfaXsY874gPDjrb66OgX9V/q1Xy2LAjUfpSnb2wDyiBWOQsTFuGAo?=
 =?us-ascii?Q?vEBQ8hm2XcW/+81JIGNIpzqA3E6NOtr4K1fddqmyXAxqTbdLIe4A9G5pRIab?=
 =?us-ascii?Q?XRKGTITRE21QyKay5RYk+spwe5Gm+0wokf/yGMSOzesFC0DsmMHy0AOdHS6x?=
 =?us-ascii?Q?Ahqigkz27TYNaHO6G16RcFPBfNPKufxY2PVXMNtLzJH4TH7PjMOuiaK0ZZjV?=
 =?us-ascii?Q?43Otdn83O8D47gm51bLmtLSQnWBf7Fzca4PMoarh1xFDeaJRVfLVq8Xy/pw4?=
 =?us-ascii?Q?Nv+ixPlAwjiTa8MBX4uZsP9wuluNp5ack+GiAii8TVWqmTVqb2qGcxZ55h+J?=
 =?us-ascii?Q?9NmuYASeStHzy29sdjiVr+vyG6CNMHxNPf1oagdDHhyk4D3H7aV7EpvjW7vQ?=
 =?us-ascii?Q?MzKUmpcCsp/rMMMaRMtUMqQn3i426735QIlJ7GV9b0+RuqFfdkV1rTFNUCRM?=
 =?us-ascii?Q?/BbRDqsXtwugzFd+z4StDmHQhelTszhCj5nGVY1ZW7aJdwhWGGf64LLN7RYr?=
 =?us-ascii?Q?/3i1L6CFHmH87vPrE9U6tOia1XDG7CJ/ot22/h6ypKFr1mbUypf08dPSCQUW?=
 =?us-ascii?Q?4gREAN32DT6eAyvMGVjWUpDGGo7PBvF2mWPUorLZrKmhvA4+XIWrY2n7tH0d?=
 =?us-ascii?Q?QB28OUShsqYUX1YjmJCC6dhJjosb0L4gXnIuVyHd3goXHsoi8QRmwfAcjr3G?=
 =?us-ascii?Q?fUtZbun0el+z6IQUn9S7O6okJ/R89duMHbvgKKU8JLFarGMpP4aTRf53LI/Q?=
 =?us-ascii?Q?I+iWbA1Unn/8r5SOITn2nrtWqDnMMR8JAJe6J2e++Ijt05O4xkmgWdr13y9L?=
 =?us-ascii?Q?701wo0NEMfS3qYYLQIAmlN/PPPqqnubLYwGmLmSx9AuL/7BDk0fStWrXhkON?=
 =?us-ascii?Q?Bbz4uXj9Cup9WZQkp24tOPkBN3gVfd1AjTakcpCe8OK9MqlNDbCd7vtSWMaJ?=
 =?us-ascii?Q?Y9NwfgrgHjkfKwddwZRpNiIkT2GXkw0ZQxgw5yXRFCqolOHHEGtH8cLvTDci?=
 =?us-ascii?Q?52ggplEOE5yna3FyakYnP7DeHDe1O+2HpKoe7Ok3ToHNfjrimsw+nHAh5ej6?=
 =?us-ascii?Q?o6oysJUFVTLmyKEAl1WE9Egq7uCr5WCs1kWjzOGvJIpLfeIo7RYi9OOf9Lgi?=
 =?us-ascii?Q?2ioEfLI5qBeaVaZI3A6Ur50v56Ssc6pTmmXuAVzwTalqkJ1LR+HYr5xH+XO5?=
 =?us-ascii?Q?nHid+q+WTMRPkFPXP4sDVxUq57Cf1VhoqxYABcKCZSKd+LbObCyedln2z1dw?=
 =?us-ascii?Q?92/INeogTi7OJAFV9D2hY29acSvMxGUHd/EK0gmF3lVfoSWA3h6l3B8Iypon?=
 =?us-ascii?Q?gd3s/E+M79woOsyXP5MeYNiY+WzooYg=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 084da83f-4c22-4494-4bf0-08df2ad6ef23
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 16:11:13.3867 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rtAGFv/HjlTs8G08gpH/SHh+7iXkJOLBIyueFsumiBBIAvztdTKhnEK9FjR7NWCkh067biTheOzxccAaITWdX+rZsC9rulppx6sC7O/M5q0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB7968
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Oct 15, 2026 at 09:43:36PM +0800, Mingliang Liu wrote:
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Signed-off-by: Mingliang Liu <liumingliang.dev@bytedance.com>
Tested-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao
> ---
>  disas/riscv-op.c.inc | 3 ++-
>  disas/riscv.c        | 6 ++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/disas/riscv-op.c.inc b/disas/riscv-op.c.inc
> index 07b56f5d52..425473ee61 100644
> --- a/disas/riscv-op.c.inc
> +++ b/disas/riscv-op.c.inc
> @@ -491,9 +491,10 @@ OP(vaadd_vx, "vaadd.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
>  OP(vaaddu_vv, "vaaddu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
>  OP(vaaddu_vx, "vaaddu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
>  OP(vabd_vv, "vabd.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> -OP(vabd_vx, "vabd.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vabd_vx, "vabd.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, rvcp_vabd_vx)
>  OP(vabdu_vv, "vabdu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
>  OP(vabdu_vx, "vabdu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vabs_v, "vabs.v", rv_codec_illegal, rv_fmt_vd_vs2_vm)
>  OP(vadc_vim, "vadc.vim", rv_codec_v_i, rv_fmt_vd_vs2_imm_vl)
>  OP(vadc_vvm, "vadc.vvm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vl)
>  OP(vadc_vxm, "vadc.vxm", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vl)
> diff --git a/disas/riscv.c b/disas/riscv.c
> index b0102e47bc..e349f521e8 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -103,6 +103,7 @@ static const rvc_constraint rvcc_j[] = { rvc_rd_eq_x0, rvc_end };
>  static const rvc_constraint rvcc_ret[] = { rvc_rs1_eq_ra, rvc_end };
>  static const rvc_constraint rvcc_jr[] = { rvc_rd_eq_x0, rvc_imm_eq_zero,
>                                            rvc_end };
> +static const rvc_constraint rvcc_vabs_v[] = { rvc_rs1_eq_x0, rvc_end };
>  static const rvc_constraint rvcc_true[] = { rvc_end };
>  
>  /* pseudo-instruction metadata */
> @@ -242,6 +243,11 @@ static const rv_comp_data rvcp_fsgnjx_q[] = {
>      { },
>  };
>  
> +static const rv_comp_data rvcp_vabd_vx[] = {
> +    { &op_vabs_v, rvcc_vabs_v },
> +    { },
> +};
> +
>  /* Convert compressed insns into normal insns via pseudo expansion. */
>  #define DECOMP(X)  &(const rv_comp_data){ &X, rvcc_true }
>  
> -- 
> 2.39.5

