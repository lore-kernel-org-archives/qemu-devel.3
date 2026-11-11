Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A487606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=FZaAk1R1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR3V7-0004Bo-M6; Wed, 11 Nov 2026 03:16:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xR3V5-0004BW-Sk; Wed, 11 Nov 2026 03:16:11 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xR3V3-0002H9-7I; Wed, 11 Nov 2026 03:16:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aNZU0dcrFDfdyiI9oN6UmodU2XqqIinJhb2Ppu+0vbbYrYzMVHOkImhemEEJls7dtR/o/wgQR8RG4XDXwfnJAspq1BMFmaPJ+f2tYInu3HhTdRxsirxZZEt1QiDqkTvpCwFZ+IfC5ZYjSPGyFwghTKG1wVuWt5IGq2NsQZ3/hdsDeUB9iGGH0aej5pTVIoLiXSPWYeklgai91l2pVJ1QoNPAynqhyPZBUZP7acPPiU8E+LR6ja58ueh6kgr5CJZDrG+Ra+u3BLyBBkmG5GnD1y7M04PN+jNmJq6LH2nHhG+sfYswnorQrBZne5JwsEf9FLDMFwYmTkuYq+zVQ+Fc2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8Hx88JljUEuglisKK4MLhLkun1LiijirrFQPzZzfnQ=;
 b=woGFyPtbUx2tHinPD5FUXv4YR7J6vioGGw5HbZl7pj49U00Fzo+MugZfEBlUDR/uqbS8zrWZWn1xw3ZpokK0FEf6pCr1cHxOM91jVmImadIc1tpHBsAu8/LMA++doCyIb2uXxRSNHtOgPTLTXI8Kyu2GHyKNRS6m19IWBx+s9nZGOV4E+3UhnCQCtJhJuJIxfSZcH4yUK9dZvSmimxxVgAjACeNgmPc3RWHXTiJm40Ik0P4xjDuwLN0+urb7DyOe/J1o5XyrQnthYbMhyJJIaLbfeSolwW9NKfhTC0o0YGfE8v8pM6ecs/y+1YFaC8DEA0bX0SWYUYjk0+w4QjNCOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8Hx88JljUEuglisKK4MLhLkun1LiijirrFQPzZzfnQ=;
 b=FZaAk1R1FMDRHtQNiEY/nBNu3gUEZi5EKNqfjS9rXA0daURC4xpYck82PvH5qQQTck3oPu+pohEkaJR2yT2H3eLVfT4+WaD7g9uPReNS2OHbtmmqXl6MXn8fPMQhGiKPe7X3j2HSCUD5nV/Kzp0gf+8Fc9ByNJPDyiiWIwtE6Lau/9g/j2A4yF6a9UUcg1EesjdYlwCYaFavHouYuFgOuiC37SrfsFheBsBMYDnJcWxAjKIjRLD21LJewuGkcAZTpLW4mvsmL2ijQR/zBryppkRIsxmiqLSkUoAd9bsGJJ61zUPbj9Ze0f5B3bhV4iW97mzVP+imsO/5/v13ERDFFw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by TYZPR02MB7583.apcprd02.prod.outlook.com (2603:1096:405:4b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 08:16:01 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 08:16:01 +0000
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
Subject: Re: [RFC PATCH 27/38] target/riscv: Add implied rules for
 Zvfwbdota16bf extension
Date: Wed, 11 Nov 2026 16:15:43 +0800
Message-ID: <20261111081545.53431-1-chao.liu@processmission.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104194155.679241-28-max.chou@sifive.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0118.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32d::18) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|TYZPR02MB7583:EE_
X-MS-Office365-Filtering-Correlation-Id: b0aac4d3-1315-46e1-61cc-08df3fcc05b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|7416014|1800799024|366016|261021121427099003|261102124527099003|261026121527099003|261028144727099003|261026140227099003|261102123227099003|261009223027099003|261022105027099003|261022075727099003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Xfa0VHXOeRQp3LPEZpK8Pfbk2dzmUmkw/pQfOabRtuCWvm1eoqIzQYnF6neqoYDPf/k295dXiAHeDcZ9phdC6sVak5iyR4EpgSQYmsFp3NhEYTtdaVr5g0RXOhjo6ZZouKqL2iufth36OaoPnq8Fw9WMEP9r1ZvENGssFdR28/2sxfOe1N4ufjjv9iqc4sLeti6QIpVCU2aro1/KEWUqPnnjEfZNNQRbwZ2uEbjyEwNw2/M40UGJGQsWGZzvY1p1GfkphnheHboIQvSiMrqgoy+RYEctRFq6ACabh1raX5RUOPG6/30Wu/Fbtag+aoz6S+sK7DB7FYfx0nxeO9BSQhwXJPQ2mXIAvI1HgABsGmoS/RkBTwyHJC0XptcaqpPgiOC3xwELdNoK54EdteeZMMUN+xz5tqMNhQc7Xje9KW/rRmJ+tJeXsMT7VcaqPwJYzGp5Lnj5uyWB/BJera7XHs4kJwSgMR5tSd3nJZqNlCsPge1EnllY8DjvhEEWMYg0cxv3VeMwqTGGIfgdIQ5TGt8trhJ8p7mKd7vXI+XhDLM6SxQQdQIZSLJJrdGgVwA7igns24dwopKnjYU01AZM1ly4cydghvjSRvf6tzvLX9Ay543GQ3Kjlg/+feNS2x6L+VzXuOU3zlayAZODHG9UzBm+EZfksuaSYxACq3joaa0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(261021121427099003)(261102124527099003)(261026121527099003)(261028144727099003)(261026140227099003)(261102123227099003)(261009223027099003)(261022105027099003)(261022075727099003)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PTh98crTi+qLrVSjwc7utrwfEXbUMEvQC60sNfkCjGUXtZLGVXNYv5fUPqRb?=
 =?us-ascii?Q?7OsGsKh0jxIggx+LeBazCf2AnVyRN5bZitkB8cOn0Gwp7yLAC7wjIJ0nUmIR?=
 =?us-ascii?Q?lYYYlzhWasmgodoOqQOkxuyOTcFt8I13d6qKp9oUE/Umqa/66fz8FjFnvNYG?=
 =?us-ascii?Q?7XDnLZSW2ye0XkhgMkujsSf8t3CFgM4hrQhBG10BX89PjkTc+irlpXKX0som?=
 =?us-ascii?Q?4A2AURR8cqpCSm+63/C5MMEsu7qLdqo0e/4yXUXMxtvY/cwmwV0zfa4J1WR5?=
 =?us-ascii?Q?bqVOu41E+bskRMq5fDE4E5T/rsGFPkeWKS7phbqpWeUY00V3/y6BOy63/edd?=
 =?us-ascii?Q?A9UxS8wWzws7j42kxuB3zUOL9DaHgJIhYrQ+IGJuYTjcg7OpgvJqNjH+k7Cy?=
 =?us-ascii?Q?TJA70U/VMdLvmNIdlcSNhsf6BJrS0vDlnzmoeTimzmuulaqlM5jt7Q2uwveW?=
 =?us-ascii?Q?T7pGbrnJrg/n1i0aNe7+RORfjQ8QG4kc2nQyTTkZT985L0cD5c/6a2UyDOZq?=
 =?us-ascii?Q?VVx4iV94MBJ5jPVnjm1Q+2CuXAJSlfx0EUki4cfZC/p2a0+Zazhms9M25BN4?=
 =?us-ascii?Q?rtvxwzJeESs/GcgcS6WIREjGK51M5VpaTiPNBGeH4y/JchBCidqeK7/SbFPr?=
 =?us-ascii?Q?IujZquqFqJ8SXhrxf4tWC2Cem5fNMjGeIa4LOJhykCtAeNH+IRHqNe/SA/aq?=
 =?us-ascii?Q?ikOO8eOslEitP0+HEDqUNY6tfOIPK/cGKXnCw58dO/wXQee4cK5DaF+elsvj?=
 =?us-ascii?Q?tRJaqXsNtqNpiAjhaCBb97k+GFjNDA9rXZscOzDpkuabDyG+bnfmdHpitNgw?=
 =?us-ascii?Q?J4cx2eAr20S/UfqVrfEIWjGCJuvRzshG0R0JqG7pXg2nw7GUsdoXQGwtW++G?=
 =?us-ascii?Q?b7ZFACdw73ktD/nMPWIe0+50N+8jsYDy1/S5174suWVe26TIZ9Kk+XVMPrRE?=
 =?us-ascii?Q?xD89U13sq64H0sthvqosJPm2tSN4fDySO5wJhPm4NHaBISW3qgDqBRlyekQB?=
 =?us-ascii?Q?yBqZvXOXlY5bBqz5Bjvx+dO7tO7pTm94ePv62RUXtWmhxOOvxeUV6OG+cjdL?=
 =?us-ascii?Q?isNe7O7SG3VqXQd23+0UjPJw8TyhkE+xnCL52zbW6bxbcycuAHsdUPeIZSDp?=
 =?us-ascii?Q?21O2c0du+ZbA/ykRCGA/ExASMujXgkzJqdnKFfMR0oqNYwZqVgAji9KciQax?=
 =?us-ascii?Q?8QWXBW0UvEF3fCHJVfYG/hdvcRFwVeqc1jaDFkoFtJSpT6n0dPYfW4bgLD5k?=
 =?us-ascii?Q?xn4lzalgq9qVTBip2V5r/UOJt2u1w0xWCIZJijmeUXkVxQjsddcJQfYhJ5Ug?=
 =?us-ascii?Q?swMCPAJ/AA4bAyuy6E9UTItweIoleGuyRZn07yad1sif2YL4gDHAJTmxdkEC?=
 =?us-ascii?Q?PvFaCZ0xkN1QWfc6eOGLqIzoHoM/1kRsEba4KEnJEDIN7rEYm7JXoKl7CneC?=
 =?us-ascii?Q?03VAM73JARY/TSBO7Qfg0N5Ks1gnqfMEZMtC/YrvpuT87x/i4rCPXmtvU9mW?=
 =?us-ascii?Q?6uj9XCGd2YHos4DAumu0i5lY0lbYJ5d+4F9TUpuan1om1PU7/z3x3q1kUG5H?=
 =?us-ascii?Q?FZryih3AAA2lHP2oWKWwNVl520Yc4EYeAQPxFGhQoot9WuBRF2LoYdmDZ7gB?=
 =?us-ascii?Q?rRmVprwtvegVg1CxYjYMjk9LMk5GDdzG0Rqeu1rtTdN7fjoOrUEwO94pxoRw?=
 =?us-ascii?Q?J6nSWwkYSbEs37L1eRU5R9/5jlY3rzRyYSLbYdD/T+JKboGJLrlbhDeh2Bzv?=
 =?us-ascii?Q?8CBzaF2MlLjsByi/Y54tuBo/3kTG55Y=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0aac4d3-1315-46e1-61cc-08df3fcc05b3
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 08:16:01.3145 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oHXoI47XjTzJ0Ky5uW93KPwW1cDgIXiDzHs53KkiTUFCjU+G2ygtpVsoE3F6cA5zvFUKB0JUUbncByNdLSaay4sd3mcWSBoiCkT4G750fUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB7583
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=chao.liu@processmission.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On Thu,  5 Nov 2026 03:41:42 +0800 Max Chou <max.chou@sifive.com> wrote:

> Add implied rules to enable the implied extensions of Zvfwbdota16bf
> extension recursively.
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao
> ---
>  target/riscv/cpu.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index c33885542f5..566e2e835ae 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2890,6 +2890,15 @@ static RISCVCPUImpliedExtsRule ZVFQWDOTA8F_IMPLIED = {
>      },
>  };
>  
> +static RISCVCPUImpliedExtsRule ZVFWBDOTA16BF_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_zvfwbdota16bf),
> +    .implied_multi_exts = {
> +        CPU_CFG_OFFSET(ext_zve32f),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
>  static RISCVCPUImpliedExtsRule ZVFWDOTA16BF_IMPLIED = {
>      .ext = CPU_CFG_OFFSET(ext_zvfwdota16bf),
>      .implied_multi_exts = {
> @@ -3115,6 +3124,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
>      &ZVFH_IMPLIED,
>      &ZVFHMIN_IMPLIED,
>      &ZVFQWDOTA8F_IMPLIED,
> +    &ZVFWBDOTA16BF_IMPLIED,
>      &ZVFWDOTA16BF_IMPLIED,
>      &ZVKN_IMPLIED,
>      &ZVKNC_IMPLIED,
> -- 
> 2.56.0
> 
> 
> 

Sent using hkml (https://github.com/sjp38/hackermail)

