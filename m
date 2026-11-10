Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEF7606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 14:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=Vl8cuvWO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQmSl-0000KX-9d; Tue, 10 Nov 2026 09:04:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xQmSh-0000JO-US; Tue, 10 Nov 2026 09:04:35 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xQmSf-0001QA-Bc; Tue, 10 Nov 2026 09:04:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DUMKQ9/ONqFXjHOZb2qMPHUT1ub+yUSIsOEYhtwhjhKn4emu4iMt2xDgzUA1j5iFldeTAzIuDagUQRyWcCXFO82KJChseLGWBKXa7BHCApERtI8vvRwzK0JNH+5ZvMROI+29H0l7SCWoQXp4Um1hWGja7+rbs6r0L8jUJMgebXbOfuwr1iMUNR9yh34MUWDw/D+laZ+4iiNqn+V3mrs6pRSr3l5QqhV1MuuERAghaNobOYfN5c2PErHLwW39fcFgnkXH3Z8eTYZfuXVBfgHNFK5Na60Yz2R7cYd1xOXLz/j2KcX1SahH463QywLP8Xv0UQgShNnV6X+VB7Pzh3GpQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hnF3ntpHfRZtu9Fj4CIDOsgi1zcpXpfOB0PIUZrWkaY=;
 b=KXYgKVB8ppv/s3SNfZhQVMc48jkC5cVaewTZ5brWEfzkKAERH9QQB4YV2nBUkQbmvwqljI8HoEM1rDTVZg0wIPdXq+AWmxyp1Wue265Nx2OaQ+AxQpz//C2SaY4cie84O76N4qyLbX7OEPolNVqo+IkJgXurgPQf9DVb92hAwqeaVzfk4/Gfe1q+mXuCxq4W5hDoN/OAgVQ3KzCotUVEUsH8xPTC75hUccNwiZ6itgXM5VuNGxBipaul6YH3Qt7lyI3jYHZCgtvpgLaC6lMsagStaq8z/PJr0SKnsqqcFfDB6OegbeMzLfdBFCb/M9eb4hZN287mqC5NCbydIgsN7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnF3ntpHfRZtu9Fj4CIDOsgi1zcpXpfOB0PIUZrWkaY=;
 b=Vl8cuvWOG3Ze3qfQkK7ByHBIU/lJjyi5oWumPQVntuzJt3Gaybo2YrT9z7uzUWynTsZTm/a2k5UJhQXFCgQkBptviKJ1lbcdfIa/r/PMLw4ntzhPkq0DqVKZ5ndiH9wq/HnP/x+TvJtxQiHwZwhuBmcGiJJ1FmmtZ9tt9yAgyxfSSY4uQP9ptjl8DuWiLwrIjEFijBYxfpekm7TKQavUKQnWwk4QGETvIQC2bKvYr6tU0gElrdVkMc9XHliII2szZn8e+TqJEXaBvbOOOMHMqKbSyuk7mYGwKFgdV0ng31dJ7h5ASPlzDKvIEn3+PVmLp7CorZZp1N7llBymohhN7w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by KUXPR02MB9477.apcprd02.prod.outlook.com (2603:1096:d10:a6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 14:04:26 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 14:04:24 +0000
From: Chao Liu <chao.liu@processmission.com>
To: Max Chou <max.chou@sifive.com>
Cc: Chao Liu <chao.liu@processmission.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [RFC PATCH 01/38] fpu/softfloat: Support OCP(Open Compute
 Project) OFP8 checking functions
Date: Tue, 10 Nov 2026 22:04:04 +0800
Message-ID: <20261110140407.29506-1-chao.liu@processmission.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104194155.679241-2-max.chou@sifive.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5da::12) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|KUXPR02MB9477:EE_
X-MS-Office365-Filtering-Correlation-Id: 7215e996-7f7f-4f91-79e5-08df3f338647
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|23010399003|56012099006|18002099003|22082099003|6133799003|10067099003|261009223027099003|261102123227099003|261026140227099003|261021121427099003|261022105027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: Nz7av/WhdYoz4EuWj/e+f6KlNW39ZhfjxNdx/Ii8KhUUYakEdJFF6E4Q6yynalY0vTemOgvHUF7wgVU28g4fLpZKDuBpIsBO3+ZIyWq8LaZuNk4fHJHm7UWEbs/9RifHk/f0S2RvMO9rbmlwLLg2phKxSiYFnUJt4pX3AWpF66usI3Ts3dYjL2aUCifswMzm0SV4TpykIMe55TDMvCy0DG7eXr/95tFsCb7unNHk5J4pqZXCQkmnYgk/dctH8JYJcK86dQh/LAIql9E7FgfmHSlMfaa3uAVl/itzH6f60V0gbINRvZmLB4tdkyJYxcuxs/YxdmeRADe0ocnZ+H1b7qsR2envQO8e//dj5qtH8T5BdwTFSAver9FeE0c3b0CfyVKiGgVQXZqK6/Dp9UqvwXpLiv1hkoSEcYIF/1oYhEYJGn7NLYp4fb+pxFI+RB6srvxsSTvtrffYz3J6W92G9y7/3IKOAOKoSRiIiXgsi3DLQ+DGEBEgkyKvs3IQ3l88TOBLnJ/krIooJ/tLyWFhd8AHtVGhAV2sJc4U7PLoS7gTx+hupAbegQhodv0kfQ/tLo/cQyfyU9wkc7Y2doSVNBh/dtC53YqEaBxKi4endALQVmir2kYaqRSF/iDFdAAKhJVuJBzGpYiHtpARg7Zr326wDDERsNFmlSN+lPozEFI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(56012099006)(18002099003)(22082099003)(6133799003)(10067099003)(261009223027099003)(261102123227099003)(261026140227099003)(261021121427099003)(261022105027099003)(261028144727099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5RdY1QUOFOEJgYn2danVyDIvmmnO0uWJJ5kEc5d99cZd9XOnnxnPIHKmVTll?=
 =?us-ascii?Q?mE5+t64JATbGJv6/1mT2ckzS8tCfXNAl4k6abOKQlUB8htEbKTtqJjfL3cUL?=
 =?us-ascii?Q?iTezwmjwC3/mwj4PEMETg3M6oKhIlJHVqaqLvG2vs4gwcoNT1eyStxZxawme?=
 =?us-ascii?Q?iT9KWbjr7i9VWIyTDZZTzlky9hL4UlAvrqxViEWgw7IkjlWq12npyEx6EORV?=
 =?us-ascii?Q?ANsIIMjBVopw0DAICcBJEHgd/xpRkyltpHIYGhcLG6SUF5mg5hhIQaYYJmyZ?=
 =?us-ascii?Q?Omr88Giiyb0LEuHoLy4tNee7HXW+47sSLZXpETqJmKdXv07BYR2osXxj5qMd?=
 =?us-ascii?Q?Al9geI2Aetg/SGPaBNxgWG9LDba7eql/zCVwow1FWBw+V6DtQefDmFm2mzbV?=
 =?us-ascii?Q?MV3FqZ3wGl6Szd1NPd6L7AZhNH4+Y6k1h9YJhWIgRT9oGXCg/O32qMOU32AA?=
 =?us-ascii?Q?zHuKTLVL5T2eSWaBnpCKF3pSKla0IKJ2F0ttOggKIT1bESaDIMll5QkTVRt1?=
 =?us-ascii?Q?NcRbizN0MujKVtz9YntzjYCiI1tmeCi8XmH4lyIn9zMBpKz2s/Tyad+3SstW?=
 =?us-ascii?Q?B/OLn0lOYd4GqySuvlIG3A/HWtjSH4a3I6sar+9age2u3h+ww9ZFp5r/vmUv?=
 =?us-ascii?Q?Vv22dRncXpwDd3MHze/4ki3w5IvKEIoND4ybgqR37M8bz4yaNtcuyfp1fhVA?=
 =?us-ascii?Q?hqnLGcJW8PNZYe7XAvSB5pwcICk+pCZ1d8DrRxTun+PkDyJfS8qFFm+rP6Hu?=
 =?us-ascii?Q?3O/q0yCHTt/Wy/e8cKtudH5ECxvj/WGLIJlH5PenBQSKCfOVl+Zl+KVcNtiY?=
 =?us-ascii?Q?EXGNM5e/xZaUWkqyrl811dvNLqKqHmOFct0AWSi3TUxWpkr7W9jJk1ag4f2d?=
 =?us-ascii?Q?maZj1d7ObWkRZLY2jNNDwRLOoaZwdn/ayc3QoF7d/sport476c/xhRaqVgQI?=
 =?us-ascii?Q?pt/oyZMvJotO6ohWQaPuNfx0sT3z1YWuX1jCZF57URGxYrygZv0opl1Zoo11?=
 =?us-ascii?Q?ZzCel6TYyR5Yx/ILjdNKKDF8YkVqCuA4LDed66YXcWe0L4tS6BG46CmDquXD?=
 =?us-ascii?Q?4jdogXpq4L8wDdzdaCCrtJi617eT1IVDHaVKUGYIimoO5XC+rJ4lMk1/1Zuk?=
 =?us-ascii?Q?tm1q22nNxHyPW5nhxmE/uodSITnUsMZMWhgB3YD5t0XpMUKKwRlXXYRFYIvx?=
 =?us-ascii?Q?V0FiSrfxghHQkGwi+AAn7FAugjjhsRlYFoCsNOFPSYOroJ4nz5GSTSMZzD+2?=
 =?us-ascii?Q?fO6R4FCX/IEFoANs6YixxPcCJ1V33i+qmTSIwT9O/uauI2OOrTzYIUk1pZP5?=
 =?us-ascii?Q?Pllc6VGcvnyKSVpE81EZmFvZZppPrCtKzBLhUG1tfrBfNZd0y7vsoWjqYumK?=
 =?us-ascii?Q?VYBGWJ4HMxekU50hvCSqFXadqGrRC2fXQhp8pQDyWIOfCERYQImzQACzhsf2?=
 =?us-ascii?Q?urYfgQQI2dsa1Ryi+Fww913j+ZVICmnn1CL+XCFL1DeBxtOBRRIsgOLKNnEW?=
 =?us-ascii?Q?j/B4Bx80iR6IzCyI+JGfaZmJRIltuDY6Yux4v5Io6Yv9mWI19Od7oI8AMY7p?=
 =?us-ascii?Q?lcFyjtaPHiDmkpmESxvMnxqyfMZ6rlFThfKf9YO+PM+PBLrPBMSYX5cfLtRr?=
 =?us-ascii?Q?zqoOHZ5NMR7+WI80Wlk6os9s4wYrg90OVh7P99CGvpdcdhnMcsk3S9kQugBM?=
 =?us-ascii?Q?he21YADNFPZMIbptAm2EpZJ5r1J5/dJrwTxIB9oXsUZlz9TFvj76AwY68sOr?=
 =?us-ascii?Q?hsxZ3tcMs7qquRykrStluiKMsJJ5pc0=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7215e996-7f7f-4f91-79e5-08df3f338647
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 14:04:24.0543 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: angrTDV8W5W+9RxBc3/c2oACtfG3iiLNRCyU2KfvBHX5lH/OKNShGaO7KJTrl53yuDLzErk+L67BEU6JyhnsTJQFsYD53knOumYoF2+wVAo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR02MB9477
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

On Thu,  5 Nov 2026 03:41:16 +0800 Max Chou <max.chou@sifive.com> wrote:

> Include following checking functions liked other fp types:
> - *_nan_is_snan
> - *_is_quiet_nan
> - *_is_signaling_nan
> - *_is_any_nan
> - *_is_neg
> - *_is_infinity
> - *_is_zero
> - *_is_zero_or_denormal
> - *_is_normal
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
>  fpu/softfloat-specialize.c.inc | 55 ++++++++++++++++++++++++++
>  include/fpu/softfloat.h        | 70 ++++++++++++++++++++++++++++++++++
>  2 files changed, 125 insertions(+)
> 
> diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
> index 8b765ef623f..22a3188f99b 100644
> --- a/fpu/softfloat-specialize.c.inc
> +++ b/fpu/softfloat-specialize.c.inc
> @@ -255,6 +255,61 @@ floatx80 floatx80_default_inf(bool zSign, float_status *status)
>      return packFloatx80(zSign, 0x7fff, z ? 0 : (1ULL << 63));
>  }
>  
> +/*----------------------------------------------------------------------------
> +| Determine if a OCP FP8 E4M3 NaN is signaling NaN.
> +| E4M3 has only one NaN encoding, so classification is policy-based.
> +*----------------------------------------------------------------------------*/
> +
> +static bool float8_e4m3_nan_is_snan(float8_e4m3 a, float_status *status)
> +{
> +    return get_float_e4m3_nan_is_snan(status);
> +}
> +
> +/*----------------------------------------------------------------------------
> +| Returns 1 if the OCP FP8 E4M3 value `a' is a quiet NaN; otherwise returns 0.
> +*----------------------------------------------------------------------------*/
> +
> +bool float8_e4m3_is_quiet_nan(float8_e4m3 a_, float_status *status)
> +{
> +    return float8_e4m3_is_any_nan(a_) && !float8_e4m3_nan_is_snan(a_, status);
> +}
> +
> +/*----------------------------------------------------------------------------
> +| Returns 1 if the OCP FP8 E4M3 value `a' is a signaling NaN; otherwise 0.
> +*----------------------------------------------------------------------------*/
> +
> +bool float8_e4m3_is_signaling_nan(float8_e4m3 a_, float_status *status)
> +{
> +    return float8_e4m3_is_any_nan(a_) && float8_e4m3_nan_is_snan(a_, status);
> +}
> +
> +/*----------------------------------------------------------------------------
> +| Determine if a OCP FP8 E5M2 NaN is signaling NaN.
> +*----------------------------------------------------------------------------*/
> +
> +static bool float8_e5m2_nan_is_snan(float8_e5m2 a, float_status *status)
> +{
> +    return frac_msb_is_snan((a >> 1) & 1, status);
> +}
> +
> +/*----------------------------------------------------------------------------
> +| Returns 1 if the OCP FP8 E5M2 value `a' is a quiet NaN; otherwise returns 0.
> +*----------------------------------------------------------------------------*/
> +
> +bool float8_e5m2_is_quiet_nan(float8_e5m2 a_, float_status *status)
> +{
> +    return float8_e5m2_is_any_nan(a_) && !float8_e5m2_nan_is_snan(a_, status);
> +}
> +
> +/*----------------------------------------------------------------------------
> +| Returns 1 if the OCP FP8 E5M2 value `a' is a signaling NaN; otherwise 0.
> +*----------------------------------------------------------------------------*/
> +
> +bool float8_e5m2_is_signaling_nan(float8_e5m2 a_, float_status *status)
> +{
> +    return float8_e5m2_is_any_nan(a_) && float8_e5m2_nan_is_snan(a_, status);
> +}
> +
>  /*----------------------------------------------------------------------------
>  | Determine if a float16 NaN is signaling NaN.
>  *----------------------------------------------------------------------------*/
> diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
> index d48fc6b0437..4d91599e25d 100644
> --- a/include/fpu/softfloat.h
> +++ b/include/fpu/softfloat.h
> @@ -222,6 +222,76 @@ bfloat16 float8_e5m2_to_bfloat16(float8_e5m2, float_status *status);
>  float8_e5m2 bfloat16_to_float8_e5m2(bfloat16, bool sat, float_status *status);
>  float8_e5m2 float32_to_float8_e5m2(float32, bool sat, float_status *status);
>  
> +/*----------------------------------------------------------------------------
> +| OCP FP{4,8} classify operations.
> +*----------------------------------------------------------------------------*/
> +
> +bool float8_e4m3_is_quiet_nan(float8_e4m3, float_status *status);
> +bool float8_e4m3_is_signaling_nan(float8_e4m3, float_status *status);
> +bool float8_e5m2_is_quiet_nan(float8_e5m2, float_status *status);
> +bool float8_e5m2_is_signaling_nan(float8_e5m2, float_status *status);
> +
> +static inline bool float8_e4m3_is_any_nan(float8_e4m3 a)
> +{
> +    return ((a & ~0x80) == 0x7f);
> +}
> +
> +static inline bool float8_e5m2_is_any_nan(float8_e5m2 a)
> +{
> +    return ((a & ~0x80) > 0x7c);
> +}
> +
> +static inline bool float8_e4m3_is_neg(float8_e4m3 a)
> +{
> +    return a >> 7;
> +}
> +
> +static inline bool float8_e5m2_is_neg(float8_e5m2 a)
> +{
> +    return a >> 7;
> +}
> +
> +static inline bool float8_e4m3_is_infinity(float8_e4m3 a)
> +{
> +    return false;
> +}
> +
> +static inline bool float8_e5m2_is_infinity(float8_e5m2 a)
> +{
> +    return (a & 0x7f) == 0x7c;
> +}
> +
> +static inline bool float8_e4m3_is_zero(float8_e4m3 a)
> +{
> +    return (a & 0x7f) == 0;
> +}
> +
> +static inline bool float8_e5m2_is_zero(float8_e5m2 a)
> +{
> +    return (a & 0x7f) == 0;
> +}
> +
> +static inline bool float8_e4m3_is_zero_or_denormal(float8_e4m3 a)
> +{
> +    return (a & 0x78) == 0;
> +}
> +
> +static inline bool float8_e5m2_is_zero_or_denormal(float8_e5m2 a)
> +{
> +    return (a & 0x7c) == 0;
> +}
> +
> +static inline bool float8_e4m3_is_normal(float8_e4m3 a)
> +{
> +    uint8_t em = a & 0x7f;
> +    return em >= 0x8 && em <= 0x7e;
> +}
> +
> +static inline bool float8_e5m2_is_normal(float8_e5m2 a)
> +{
> +    return (((a >> 2) + 1) & 0x1f) >= 2;
> +}
> +
>  /*----------------------------------------------------------------------------
>  | Software half-precision conversion routines.
>  *----------------------------------------------------------------------------*/
> -- 
> 2.56.0
> 
> 
> 

Sent using hkml (https://github.com/sjp38/hackermail)

