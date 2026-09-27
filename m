Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1E55C9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 12:00:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAnYD-0006d9-DP; Sun, 27 Sep 2026 08:00:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xAnXt-0006aj-5n; Sun, 27 Sep 2026 07:59:53 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xAnXr-00081X-Au; Sun, 27 Sep 2026 07:59:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vUs+Btp2v4ilppBZPh9IyDpOHRkn3+ufUCllNv9oR88wpoMoJRgH6AmMFPy5hUQDOXgyR/qR4ccL7HLTX7QMsut2ciVAIwjAYroDxizUcFdzZl7J/Jri41qiZ2pAah8hCtHQJ5d3IjXfcFrIu8/7yVX1eeJwvt6oASZGP2dK/05pcygnWu6pizQd95uaFGTzOdB4rBie/SknDez7aOvTsjFwBZSsMmQp8M42/IUanw1Z1rkdpBiJRx2JD65UOKSSuDnpDQED71hxJLw3wtoZ4VNRo3MLeruVevEVLjZi3ab+4fay3+9+5N0H8Qnrkv5JQOyfMHs5Yn64tsHz4VaOtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=il5VmNoX2DFYcA2Vcxm0bsVvuxvTDZk1KPp1AC49rYE=;
 b=VYCCnQRG2MLWFVu76mZ6HNJ5ibRE6RFnEZ1l4Gd3/uhpycteQjpIp2p6Ol9SVYE5c3qmYG/lmN6PNQg+L8PIEH3MCczCFzpGA91/2ctPH8a8HCVMTUO+u8C3ClV3TGy/OF+CLg4tofwfagFwhjLiNO6N6wBNU2kJBbKFtzUtNhm+zyCe7ZDO6sW/1sFAjLTzwKCqxRbVtAr7n2I3D9kml8jAIOAp448CRWUYx6SKveiGjaCW7i0qq7ACOAJic+uYghpaXQ5OExEKZNBDKUm3L0zlOdOzJWpRjKVJzWSdTJdpK8klu3ZcDBg/UMUHnxFD3fGAuvmG1I1tCVO8N522Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=il5VmNoX2DFYcA2Vcxm0bsVvuxvTDZk1KPp1AC49rYE=;
 b=CFOxvGvvdpBS20p22MBoz4dT37toXeM6LLy3lE6u7yxkAXLuBCqr/Qh/bPyYt5GeIjLX03wTcBcPnnD0PiTQr7iy4KXeUJQUYDKNXXJRmJS2hHJqbWeZkHQo/1+qRdCWBwqwhtrYZVIcARe6jTwWz1VVdz7r/aLnxoX8eCGYm5XnGe8zhy9g91gNaKB2mf6ZQzEoOIeNvYCQV9IiOKER/wSEI6lCC/Qqfzd6R5HDLoJSEW/l6cyT2dDQwEYLTdRqNBNqKka+E/XGRPc9V1De+AqoGoaQhwLrj3cHjj/y0ZBK1RelYPKPdW1bK45WVHq8cAdbFyD1LG1fP3Ozp4G57Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KUXPR02MB9336.apcprd02.prod.outlook.com (2603:1096:d10:a3::10)
 by KL1PR02MB7331.apcprd02.prod.outlook.com (2603:1096:820:11b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Sun, 27 Sep
 2026 11:59:46 +0000
Received: from KUXPR02MB9336.apcprd02.prod.outlook.com
 ([fe80::1451:cb49:7950:b10d]) by KUXPR02MB9336.apcprd02.prod.outlook.com
 ([fe80::1451:cb49:7950:b10d%5]) with mapi id 15.21.0451.022; Sun, 27 Sep 2026
 11:59:46 +0000
Date: Sun, 27 Sep 2026 19:59:40 +0800
From: Chao Liu <chao.liu@processmission.com>
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v4 2/6] target/riscv/cpu: List one implied-ext rule per
 line
Message-ID: <arkFCJp20VoXOc4K@MacBook-Pro-4.local>
References: <20260927082534.3228237-1-max.chou@sifive.com>
 <20260927082534.3228237-3-max.chou@sifive.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260927082534.3228237-3-max.chou@sifive.com>
X-ClientProxiedBy: SJ0PR13CA0148.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::33) To KUXPR02MB9336.apcprd02.prod.outlook.com
 (2603:1096:d10:a3::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KUXPR02MB9336:EE_|KL1PR02MB7331:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b4773a9-7cfb-4e9c-a257-08df1c8ed33f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|22082099003|18002099003|56012099006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info: p9IvGYia8kVasYs3DTPjIA8MnVYucF1WCZC7atX0OCenrefaZa1pxH5QWClgVca196CoAn87kx7j/lgl9h6sJ6BFjG5ZB7D/tWw8v9UBWd2CQM1jPQL/v7QRe3UhKIo0cqqhUSyvQCplzjWrUCQCHHvEywEn5SzNpCbhu78jOWG5BADR4Vwrd+b2v5YX++5JIBWDmnL3WO24Dl31Zo2ofPGE1dvpXG/OHmTJXDaZLFuQsPM5StQUfEuFdcjmxgjzNaF3FXoxO8YiMDa3OwlaF+3nrRVNf16iSIMyG+QDi50GjwNWoRrZ5OczbTITpOXghGnP6kD1zVE2apJOYmSRIBBlnPBmM2SS/3nsuRlKDpxBUNj/BJzmjU5MpBP+9+5iF0oVl95GDEdFKO2ZvxwwcVRuWpX8L/WlPlI30CSNGwzYf+iZu9CNba5R8IkXMz9EOtCsCZrd0c3CHui/nS14KwDFkvhrD1H05cqloLy3I4YWnzOxugZsgu4aORzzcXrWqowOhBsgwVKiTRv51Fq0Y37rpMN7rbNRE8LMgdmjajMuBv3IoFrXDY9csFH98TvlnoHvFYKpk0Rb+ShmQUWBsrTv0vdXvVViCj1mwXzbk88KNvDDKSJwZcA+2f9jmOEBheME/BF8hhpl3hc5RKPBwrgUQ2b0a9Asx+4v5iqOa+Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KUXPR02MB9336.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(56012099006)(10067099003)(4143699003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JbXeAozkupxNhDr507DdAr/dQ1W8eK0rY+q/3wSC+r8UkBNoz7k2mN/kKMIs?=
 =?us-ascii?Q?NNgy/fcWjkYJiNTMw11+/UD2hZUJC3zvUcCUFVVwq3v20yLp+wijf/E0IkxP?=
 =?us-ascii?Q?izLEBNZeACFksxYU6rI8j+uHV0RJr5VkZK1fcFXEL637kEvjKgZ3d7rSA60Q?=
 =?us-ascii?Q?HhJ6tBX5djZmcQmgyXqW6b0v3SA4SzZa5/e3A0Bn8BalL/LXMtGbV0e5tWDl?=
 =?us-ascii?Q?rxCPl99CEx7EJfPnYLOEjPLxSkbf4/71/rraw3u8PrXtgMDEfeujLga6gTTl?=
 =?us-ascii?Q?IL0QOW4nVzY1z7deXlU2ZPz4eipNjUhZflb4mkkixuxzdqlTsiocZHVLBeo1?=
 =?us-ascii?Q?Z7qPSZKZQOQYJnGwG/+gmEC6RtYNr0eciW0Zfp9AEdcRHjfzoLOmA2byIk63?=
 =?us-ascii?Q?98FRRDHlyyot24fMuz7Hd6LHnYMjiO0GhAperuiPJ+SDHphidN34Oloo0vgy?=
 =?us-ascii?Q?jtQ1e+pi+8HnEZQR8I1UL7et1XXtjpyhQ7p5/eVT3zBUVG5QS/jf3PEwbJ3z?=
 =?us-ascii?Q?GewpDJf9yVeQrn3vTyweLBfUJDbUfS0J1s+I/hrt70/jt5ZsZuAntxTr535E?=
 =?us-ascii?Q?nfDVGnZevn1PwTjRk3IPQ7v2IQuW5jEEHZByjaokUbfya7VoO0muFeA5ySPx?=
 =?us-ascii?Q?dXgozBvmkYmh6nDVfnmqNiOI9Y1psc96o2aniKAbGqK+aMm679g1onq7EP9b?=
 =?us-ascii?Q?N+V+oIENs3Fr8FSZultYxuSj6vfXgpBQsO0pPJ72+N6ENTRruo2baCTPRpS7?=
 =?us-ascii?Q?51kTAPX2L7mGMi1MhnAROBGKJfMpIxZlbXaDDWAEe1dTuoLwlhhFeFTP+smn?=
 =?us-ascii?Q?Lgr1ezEMyB1Lcb5PnKN9w7tEzMSSOUQ+hZSQhZtcCgTgsjwFpDLLitHxtBso?=
 =?us-ascii?Q?LaO+Glks7bZPJTy2ePFRrk1L3lfKLY+9c2zlxh8awPJKjragJ42snS9fUxES?=
 =?us-ascii?Q?gx+NL9zhjDHHawFV3UcgCd2azYSzT41lW/aJQAnpLnigiPOLRbFvaaF+eTGD?=
 =?us-ascii?Q?+LO9uuCKkCWxs21LAaZiYDKrOv2UUvDRx3rl6qsKUhJmUx2fSbUovLXzBEYp?=
 =?us-ascii?Q?GzllGCIM6HBBVXQ2CzW7r2842IzBEnW0fS2ATrxrd9y1VvU+2X2EtYyiZfjn?=
 =?us-ascii?Q?ZQpy1xsY5D76kttRoe/azzv5KlWbaRaDkbN7Dl21exuHVv/es13MRfYlbha6?=
 =?us-ascii?Q?kLnZk8/jcwA0YIWDbsPsm099/2j8IMOBrzby20FeHLT/BfKK8k4mleQOA6nM?=
 =?us-ascii?Q?41LMr/vKCzjVdhwXrLk7EzLC4FRThzGOZyUKSLCAXHkQ5SyoOxmW357suso9?=
 =?us-ascii?Q?7CrI6HUIDJsQX0E7j9cK9v7cR80CybEoNGsTQcUNBfTOnDMcONGe7zSdg/P/?=
 =?us-ascii?Q?XADpi31gKEMu7QjhB5nNESuQaXqgBbe2Zdrvz/X18WT2wvKoN3iOu1yLeEJ9?=
 =?us-ascii?Q?Zb7Mw7dpEqSZb/ot4m+XSYFrukCSlKDhgS93GpZ587J5PI2s+aYf6UI8AhBe?=
 =?us-ascii?Q?ugaQEHvbTFSys/j2L73qweEV1TB57xCJ2BDV4CNbm0pI+PlLav3VEo3axXWO?=
 =?us-ascii?Q?dImKfc8c/9XrvQwIz3/ujW/MBWHuaQzVIh3BBEtSv3kaRo0yNnpnZdpHECKE?=
 =?us-ascii?Q?40j3MnxE/1sjFnzMcg+CyjYDFZcVR9v4YJp770/IubQ4pjiBR85pwSZrzPfd?=
 =?us-ascii?Q?apthGUvP9LcCM+CIctdPO72gswvIFgHUr6X6ZY3C3TZiow+XCJWrIW8ORiiY?=
 =?us-ascii?Q?bWeotce+tU/nZn7yGCGFoEFHxUh16RY=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b4773a9-7cfb-4e9c-a257-08df1c8ed33f
X-MS-Exchange-CrossTenant-AuthSource: KUXPR02MB9336.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2026 11:59:46.5459 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4437H5KWG/zUwPa31Wy9ywD/qQCosxJugWzgLKtFPVGsbBms43OsdV8Dh8oNvPA0RF57i5565nLN2zJU2cQpL+q/Cmrk0McHElWEKOWhJzg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB7331
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=chao.liu@processmission.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

On Sun, Sep 27, 2026 at 04:25:30PM +0800, Max Chou wrote:
> Every entry added to riscv_multi_ext_implied_rules currently has to
> reflow whatever line it lands on, since entries are packed several
> per line. List one rule per line instead so future additions are a
> pure append.
> 
> Suggested-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
>  target/riscv/cpu.c | 58 +++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 44 insertions(+), 14 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 55833896bef..90fa1d714c7 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2913,20 +2913,50 @@ RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[] = {
>  };
>  
>  RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
> -    &ZCB_IMPLIED, &ZCD_IMPLIED, &ZCE_IMPLIED,
> -    &ZCF_IMPLIED, &ZCMP_IMPLIED, &ZCMT_IMPLIED,
> -    &ZDINX_IMPLIED, &ZFA_IMPLIED, &ZFBFMIN_IMPLIED,
> -    &ZFH_IMPLIED, &ZFHMIN_IMPLIED, &ZFINX_IMPLIED,
> -    &ZHINX_IMPLIED, &ZHINXMIN_IMPLIED, &ZICNTR_IMPLIED,
> -    &ZIHPM_IMPLIED, &ZK_IMPLIED, &ZKN_IMPLIED,
> -    &ZKS_IMPLIED, &ZVBB_IMPLIED, &ZVE32F_IMPLIED,
> -    &ZVE32X_IMPLIED, &ZVE64D_IMPLIED, &ZVE64F_IMPLIED, &ZVE64X_IMPLIED,
> -    &ZVFBFA_IMPLIED, &ZVFBFMIN_IMPLIED, &ZVFBFWMA_IMPLIED,
> -    &ZVFH_IMPLIED, &ZVFHMIN_IMPLIED, &ZVKN_IMPLIED,
> -    &ZVKNC_IMPLIED, &ZVKNG_IMPLIED, &ZVKNHB_IMPLIED,
> -    &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED, &SHA_IMPLIED,
> -    &SSCFG_IMPLIED, &SUPM_IMPLIED, &SSPM_IMPLIED, &SMCTR_IMPLIED,
> -    &SSCTR_IMPLIED, &SSSTATEEN_IMPLIED,
> +    &ZCB_IMPLIED,
> +    &ZCD_IMPLIED,
> +    &ZCE_IMPLIED,
> +    &ZCF_IMPLIED,
> +    &ZCMP_IMPLIED,
> +    &ZCMT_IMPLIED,
> +    &ZDINX_IMPLIED,
> +    &ZFA_IMPLIED,
> +    &ZFBFMIN_IMPLIED,
> +    &ZFH_IMPLIED,
> +    &ZFHMIN_IMPLIED,
> +    &ZFINX_IMPLIED,
> +    &ZHINX_IMPLIED,
> +    &ZHINXMIN_IMPLIED,
> +    &ZICNTR_IMPLIED,
> +    &ZIHPM_IMPLIED,
> +    &ZK_IMPLIED,
> +    &ZKN_IMPLIED,
> +    &ZKS_IMPLIED,
> +    &ZVBB_IMPLIED,
> +    &ZVE32F_IMPLIED,
> +    &ZVE32X_IMPLIED,
> +    &ZVE64D_IMPLIED,
> +    &ZVE64F_IMPLIED,
> +    &ZVE64X_IMPLIED,
> +    &ZVFBFA_IMPLIED,
> +    &ZVFBFMIN_IMPLIED,
> +    &ZVFBFWMA_IMPLIED,
> +    &ZVFH_IMPLIED,
> +    &ZVFHMIN_IMPLIED,
> +    &ZVKN_IMPLIED,
> +    &ZVKNC_IMPLIED,
> +    &ZVKNG_IMPLIED,
> +    &ZVKNHB_IMPLIED,
> +    &ZVKS_IMPLIED,
> +    &ZVKSC_IMPLIED,
> +    &ZVKSG_IMPLIED,
> +    &SHA_IMPLIED,
> +    &SSCFG_IMPLIED,
> +    &SUPM_IMPLIED,
> +    &SSPM_IMPLIED,
> +    &SMCTR_IMPLIED,
> +    &SSCTR_IMPLIED,
> +    &SSSTATEEN_IMPLIED,
>      NULL
>  };
>  
> -- 
> 2.43.0
> 

