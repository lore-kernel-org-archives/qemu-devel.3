Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BBD7D2069A
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 06:11:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0xF7-00058x-AR; Wed, 16 Oct 2024 02:10:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t0xF5-00058n-0i
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 02:10:44 -0400
Received: from mail-me3aus01olkn20817.outbound.protection.outlook.com
 ([2a01:111:f403:2818::817]
 helo=AUS01-ME3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t0xF1-0005hj-GP
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 02:10:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ftez1iR9Y9AIFqDGzW8DfRvuFg4qzz3zBrsfn5AxRidfQKyJkyF9m+zKaggM63s5fBIVDDBkm3Rej5WLTogcIL6ZpHh9slog/k2B/NTjeyXulC1CQTmCEhLl2HteBfeAv47Zhd4tvGI9vTUxL3Ao52pAJ5gven4jVmNs4HqbGSLcv4cU8e4ULYN1L3aO2Ni1FoXcgCB5sxdh6m2rDH7vGDYaIM4pcTB4f8XM1hsixUQq8BEnI/1clRLEwkchvP55RkKNuaKD59iIWqxYdwlqa4Y3upi8tv93IVdnuyRNfruis7xruBOiQ2hEXozq8ktimqxHxrPCSAhmdL6ZS/z+YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N6yqjE1xKySdy5/8VsV3IH+7CODVQSkgHR4MzfbiR/0=;
 b=APkAv7/wRMDZaJCCQXTVC7WUblhokWruDpsV9vQplTKdkEg4FpvHMZdpIRR3WkA2mlrdHmEJIYIcHqmbZW3t+esgEiGt5W8z7IMmmBF20vGrHqgrxJeARTqZqUswGzd7oJxC6vqbptYIVr4uX52f0VgPQPKDb2Y5UjZSU1M1yE7Exre7miO+dhsFVnJ5VsQIXwDamwx79wLsbHxNbbnEQ16MWU1e16qTfUU9Et46eX1grwHN6dMP49qNZj/dmhGrBC9mxRPSNAwfZZIkp5mrLDSWsCtFUvJiXXeFaOyD7SoN/dtXDzrJLsyY/IGtt9RKET7Sem7YQ1NiF3yFHtBvPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N6yqjE1xKySdy5/8VsV3IH+7CODVQSkgHR4MzfbiR/0=;
 b=udWtkeVd08DJbs78hFW4hbkbV/p5JihkE4Zy8o1yqHoomphGa62NK3zNGBfnY2g+auGur5hOSaK6wmzJWKkHPJiybEPJ115FqCBGqSPdrLY8L+9eFOZaeCH6EnbuWOaJLnzKy4r+IYfdv+KCJVx5V2bZ5JMbW7OACSwHG4eUM2/ZiOmgQexKE/BlVo7s6VDSKQqas0bO2YncRInap1a7rLN8gfFyey3xAVpdkTza2whGuhEgPLtl4Yo55zSSoUZeaVYaHjePFnrpsD2h3aINvOU5U7z/i0AwnSOu1kHJINWFFg1cUKNqOVty2h0+bGKRTr+ZopPhhLUPrQSXLGLYhg==
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:282::22)
 by SY3PPF906539F5C.AUSP300.PROD.OUTLOOK.COM (2603:10c6:18::49c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Wed, 16 Oct
 2024 06:10:32 +0000
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd]) by SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd%2]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 06:10:32 +0000
References: <20241015131735.518771-1-pbonzini@redhat.com>
 <20241015131735.518771-13-pbonzini@redhat.com>
User-agent: mu4e 1.6.10; emacs 27.1
From: Junjie Mao <junjie.mao@hotmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 12/16] rust: allow version 1.63.0 of rustc
Date: Wed, 16 Oct 2024 14:01:07 +0800
In-reply-to: <20241015131735.518771-13-pbonzini@redhat.com>
Message-ID: <SY0P300MB102670D06E55A6B463CD1BDA95462@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain
X-ClientProxiedBy: KL1PR01CA0147.apcprd01.prod.exchangelabs.com
 (2603:1096:820:149::16) To SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:282::22)
X-Microsoft-Original-Message-ID: <87ed4gr31v.fsf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB1026:EE_|SY3PPF906539F5C:EE_
X-MS-Office365-Filtering-Correlation-Id: d939a48a-64e8-477e-e233-08dceda93d9c
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|461199028|19110799003|5072599009|7092599003|15080799006|8060799006|1602099012|440099028|10035399004|3412199025|4302099013;
X-Microsoft-Antispam-Message-Info: fURfcftO/Fntx2ctDaMTL/sq9a3RrRtQ04N37NLRuLrZAMTcLwyFsj1dRx/GO8yigpw+nvGYm8NOxGHQGuVONWZnlDQZ55P3GgvP0oC6FHkrlrWvibxS5WxQ4Hm23loYkj6FnWleQS7Y5DqJszk4s2Pb+mXAiLcisubw4X4aBfYOjC/mC10/YTASIqkjVZQ66ZUO4X1xxKA8n2ac/Qt0p4monopulnAyX/vbhz7M2M6Hu8vjSd8+iXn1sJoq+z2bYoFy62Wdwh30F/6rW0cCIg+ZacNcjRyxlgkOD6OWHExSZ3DPze0SlZz1MoX16VsX77zWKRtuCdnI/tdRsKykRtRCvLjYmN4qCGd9vu8MngO2JTBUjSVGOQdAwWw5mm70hvqk+CWPyTVvlz4mHYZnbQPd6V4oenXA4on5E2Ts71uZpNBTzDrmDhZAx/KXbn+b1pEOzd2LvONxz1mDnoOHzXy125CNoHupVuIGbluT3N/2nXJMJQzfxzvutdOJEfbcuvJbx2phWP982SVCdfZ4AoHdaXuj0phUR5+xEurPqKQMB1ah5JZDH5W70bblep++/qXRdAfCbEqNeb7yTn2Hb81WPXnp/dSCTrztUyMz2Qs+KiOwxVhwfv9/dWw33/reavQrJADi8UPyN40A2PhU1D8ybYFk88DoiVD8+7YNlgJYfU5qNKbQG7P/nLbKR84kZ61YDNhLMdrvx4hKRq4QKHh68S6TmKU5NxbBmROJbWKcKsWAmfupNbHYyLQpqDjv9Be5dq9Qqky9OOZDvdO/vJPR3nrxBjiGmgWRuJSKPGBp9DKPTQIguxHecad/fKcPq21yapmk9FLs3Qht/JYvRJkzJpSkAW43fn4DqrVHCGhi+E7SCKeEp7+odM+rlKee
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Zy+GTb3qQxfPrO0Izeh/m0AQNjzm7woaJzcxyLm+m2eRs6HFNABvn17SaTsE?=
 =?us-ascii?Q?cbq991sxxSFCo6ix4JfE0PiE2rzEtzRuZugJmKAT2mHVbUZj5COEKtN0TDaZ?=
 =?us-ascii?Q?Fu6QQvlxBVQTA34N084zVk126kSEbZK3/5NvZUxT8zy3rHiGV0Oy7wOK99J/?=
 =?us-ascii?Q?Vfp80QZ17hooMXEUIoppK5YsbBSeYRE18NrZdw/xBu4OdbZPwB4WSWrlPj7J?=
 =?us-ascii?Q?QqQJEEvqpZQFHm+8/Ny5D3a8FO9Wn/FXzeeWfuRtszYo5my/iE4//T623FnS?=
 =?us-ascii?Q?qmL6VW6JykIvUUcaYVCvecFi4+zhb99kz9VPEFxekv2OpvzLL9Rb5vUeW1yD?=
 =?us-ascii?Q?DimTWfPlCiUgI2ni/ekGtjn1OX3XtMGmGmuwTHlNZ3M+VUn+tXcVtbHXp4nv?=
 =?us-ascii?Q?pearCaZluCR0TSsoTer2zvlNc8NjzHBfuG3CQRKAYfZksGHVqqh7djYHWamk?=
 =?us-ascii?Q?eocFQVPHbWak01ZubdFhwfAQEmEdd3MK16eg2S68Kf/otmhfc1MktCoBp7Y4?=
 =?us-ascii?Q?/jbcZMQqt92NaaAyBq22HlLhzxH/tvhbSaQVoH57+X3Vg6RYOwJWb4trzPwV?=
 =?us-ascii?Q?/+QVxXVnxG6hK5qulEoQvvJbYPVeUcJ7xTuhPvpmkzH7Z6Gozv+O5eZorttu?=
 =?us-ascii?Q?d9IGgBgO+jCrWPrCWevlCqTKH1tRdX49yig2V0uC6IM28vsShB4+ktkSzprU?=
 =?us-ascii?Q?DeVJZ8l8R5WfLJGKJcA+XXk/duwXpnCIBET2mFpuu8xyVi0//6KFmCadmUcY?=
 =?us-ascii?Q?qhHYl4CNaflM/d1t4jaaWz2HqrSbQbu+b+T1K/hcGc23lERfQRsDDg83y/qi?=
 =?us-ascii?Q?CTvAahaqFeDhmumZCT84n+TlVSYAm1OJso/vopIKiaxvAoA6FBn3Fmjhfu15?=
 =?us-ascii?Q?SvKj652VVltY+L/B6iwUQofrEINQ+1HDF0xFSwvCQcgM63F2mn1bYtkIrMxu?=
 =?us-ascii?Q?pjZTGxj5jo1QB/9UQ847RODFp0xTuOjpcPwvcc5VYVuKgpJ+wAXajuWuL2go?=
 =?us-ascii?Q?vE/Zj5eh5y05Fi4MR8a4wR+Yd/mDQRN8ZM05W7P5IfOllKpmnt88G3Wre8rL?=
 =?us-ascii?Q?M+lSmBByPBubRQFpOt/rkwo4pg9cGjkwh9S35YoW9GGI0CA47r3IBtXruO0b?=
 =?us-ascii?Q?n/wGxyDhchA/05JgptQmLI7vT+oco9CLFv4rYM0v77ZsEvTwGbDsdp3JnqGy?=
 =?us-ascii?Q?UAh9PrVzZ8heMIG0xPjBvcGrnClqE1SMRtiiNU3Ko1qPWCZipY3QtBIhiAY?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d939a48a-64e8-477e-e233-08dceda93d9c
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 06:10:32.1730 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY3PPF906539F5C
Received-SPF: pass client-ip=2a01:111:f403:2818::817;
 envelope-from=junjie.mao@hotmail.com;
 helo=AUS01-ME3-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


Paolo Bonzini <pbonzini@redhat.com> writes:

> All constructs introduced by newer versions of Rust have been removed.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  meson.build | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/meson.build b/meson.build
> index 175b8d82228..0e279d245b4 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -76,11 +76,11 @@ if not get_option('rust').disabled() and add_languages('rust', required: get_opt
>      and add_languages('rust', required: get_option('rust'), native: true)
>    rustc = meson.get_compiler('rust')
>    have_rust = true
> -  if rustc.version().version_compare('<1.80.0')
> +  if rustc.version().version_compare('<1.63.0')

In my Ubuntu 22.04 environment (rustc 1.76.0 and bindgen 0.59.1 from
apt) the feature `proc_macro_byte_character` is not yet stablized but
used in proc-macro2. Downgrading proc-macro2 to 1.0.79 [1] and syn to
2.0.58 fixes that issue for me.

[1] https://github.com/drmingdrmer/openraft/commit/d496b6db4c6128d33f0f211165c08a7925cf20f7

Here're my changes:

diff --git a/subprojects/proc-macro2-1-rs.wrap b/subprojects/proc-macro2-1-rs.wrap
index 7053e2c013..d5713b45d7 100644
--- a/subprojects/proc-macro2-1-rs.wrap
+++ b/subprojects/proc-macro2-1-rs.wrap
@@ -1,7 +1,7 @@
 [wrap-file]
-directory = proc-macro2-1.0.84
-source_url = https://crates.io/api/v1/crates/proc-macro2/1.0.84/download
-source_filename = proc-macro2-1.0.84.0.tar.gz
-source_hash = ec96c6a92621310b51366f1e28d05ef11489516e93be030060e5fc12024a49d6
+directory = proc-macro2-1.0.79
+source_url = https://crates.io/api/v1/crates/proc-macro2/1.0.79/download
+source_filename = proc-macro2-1.0.79.0.tar.gz
+source_hash = e835ff2298f5721608eb1a980ecaee1aef2c132bf95ecc026a11b7bf3c01c02e
 #method = cargo
 patch_directory = proc-macro2-1-rs
diff --git a/subprojects/syn-2-rs.wrap b/subprojects/syn-2-rs.wrap
index 13ffdac3c3..9d413a0c57 100644
--- a/subprojects/syn-2-rs.wrap
+++ b/subprojects/syn-2-rs.wrap
@@ -1,7 +1,7 @@
 [wrap-file]
-directory = syn-2.0.66
-source_url = https://crates.io/api/v1/crates/syn/2.0.66/download
-source_filename = syn-2.0.66.0.tar.gz
-source_hash = c42f3f41a2de00b01c0aaad383c5a45241efc8b2d1eda5661812fda5f3cdcff5
+directory = syn-2.0.58
+source_url = https://crates.io/api/v1/crates/syn/2.0.58/download
+source_filename = syn-2.0.58.0.tar.gz
+source_hash = 44cfb93f38070beee36b3fef7d4f5a16f27751d94b187b666a5cc5e9b0d30687
 #method = cargo
 patch_directory = syn-2-rs

--
Best Regards
Junjie Mao

>      if get_option('rust').enabled()
> -      error('rustc version ' + rustc.version() + ' is unsupported: Please upgrade to at least 1.80.0')
> +      error('rustc version ' + rustc.version() + ' is unsupported: Please upgrade to at least 1.63.0')
>      else
> -      warning('rustc version ' + rustc.version() + ' is unsupported: Disabling Rust compilation. Please upgrade to at least 1.80.0 to use Rust.')
> +      warning('rustc version ' + rustc.version() + ' is unsupported: Disabling Rust compilation. Please upgrade to at least 1.63.0 to use Rust.')
>        have_rust = false
>      endif
>    endif

