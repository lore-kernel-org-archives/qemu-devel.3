Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B05AD0E6EC
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 10:39:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2poz-0005oq-5z; Mon, 21 Oct 2024 06:39:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t2pow-0005oN-P2
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 06:39:31 -0400
Received: from mail-sy4aus01olkn20815.outbound.protection.outlook.com
 ([2a01:111:f403:2819::815]
 helo=AUS01-SY4-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t2pov-0002ZV-2R
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 06:39:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jn/wIpefFG3wk+E2WCE+mJYVs4goc4F+o25d4n9a/TRyn+vCZm8IhSU+SJxnAmKSwzWZKi0YBfkmyfNWJ/diC3tth6EFpwONyae0HngElgv0/JGMkBEKGZFpQllQXNCcXNT+2C9qw1ehCdXEUa9iTgTaFqZ0DBnlGbeaf9B/dShNVn3bEEXAcYgBD8hD/4i6lmC2QQZ1Wy2TgwrXtJqlSU+wN6BWTIoTS0+sz81FyhEibnzRW3phH18kFx7XHZsNRiZ7SuXZCvo4UmkFczb/eWWlyo+v8JUs4fXTGTO4J5LPo6Fuz7CNTkvczSoh9FRow8ptJaFFXKqofeL8xdeNvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QLyd5+/M7uWcE75GkA44PLkLQkReg2gtFnoQrmgH9aw=;
 b=YKry6uP3407/Ub4r+zrs/VcqYL2ZsiMCw+lQEbEPO5jWIa82+ZuNKORtVEIDt8hjM8kiNw7hjZFBtpcVxNflY4bCtsvH6vqi6kUGqKzgK9jvbsnu08FJyzMhf34LIAylYjQVv3noI0rMTdn542c6H1XJrUjSb3AFpuNtQ2UFYfxzAZvb7QDHQXj2gFI/fwLyysqbYm/vzTaZJTfQ2ezSXU52xZhzOTNvcrrYPfpZufjCH71saaGWv0yrYHdN/VPf+g+NCXppTDKK6zUY3lhOQwcs0o9dvSaB3TKCY+IxykSr0GlZN1m1b37PKIE6fdNvRdDdwfhnBHNnW2SsG7CFow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLyd5+/M7uWcE75GkA44PLkLQkReg2gtFnoQrmgH9aw=;
 b=R6fwF684NZ+Ke0yP7QcbPJ4sJFo5hoGrJY2+mfAVibr1GGRa+uHId8ve0fvRG17GlGqHImc4dI8nEB/e3vYyKHuUJ8KDEmg+PzeB0z3R6HAg12NNGwlJ5qcSA3Fxdt9YHNY6Hq+/aRNXvBCGTiNzUnJciwA6aA489f7TP09wzw4L+d4KhvDkSRED6dFjskfqN6mcEAxhyL64LFgz1hU/W+YmBPPICXGFk1QRgbIDumc4WpmwpSA5aiCqr34VIL7mSons76is4i2rZE1IEab+Y3pFKw0wTTVA661TrIY4z3r8pgntdc8lCsQoNVEpPq9vQfvTk5ej2yEN3CJmJmLqdw==
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:282::22)
 by SY7P300MB0749.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:28b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 10:39:21 +0000
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd]) by SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd%2]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 10:39:21 +0000
References: <20241018144306.954716-1-pbonzini@redhat.com>
 <20241018144306.954716-10-pbonzini@redhat.com>
User-agent: mu4e 1.6.10; emacs 27.1
From: Junjie Mao <junjie.mao@hotmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH 09/13] rust: clean up define_property macro
Date: Mon, 21 Oct 2024 18:35:34 +0800
In-reply-to: <20241018144306.954716-10-pbonzini@redhat.com>
Message-ID: <SY0P300MB1026DF84A11DD5A72EC45EEB95432@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:54::23) To SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:282::22)
X-Microsoft-Original-Message-ID: <87plntsptb.fsf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB1026:EE_|SY7P300MB0749:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d7024e1-166e-4ed0-9859-08dcf1bc9fbf
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|15080799006|7092599003|19110799003|8060799006|5072599009|461199028|1602099012|10035399004|440099028|3412199025|4302099013;
X-Microsoft-Antispam-Message-Info: 69wZxY58Qp+Z6ojAClR9JxUHKANdz8bII2BBZY3U1Z+dYCBDNyXQwdc88NMHOHBCGQhR8Wo/uWi+ebtmaHskXdUoZc3QpFX502+fvTCx/qYCMoSABl+qYdr3NWQoiBmqUPO6YDf5m7cH+mo2nRfCViLWpreGYVDGkPCnZeMDaPr1RertfrEh3YSPNRX3JVyDGA3l56Sgji+I6IcRfHNOpdA0/Qt+OatMqb8QSPZ4eptP9OX5rU/n7ubkeqHb6pwD4DZQ0zvbmm7AUf0L49hwy2qbvaN89e5yvcygO6y+YxzWCKr5j9sSSMYp0HXblDoHj6hBShi6Fdsm7EalYWR1f8ihVgpjLVFUY+LLwa9jRgXVIvTLZ7u8DFy5VV6WJ5ldPf9iKbreTqyyulKmSu5fbQvqgLb6yOVeYqegcWkuQU2gN52GafQ48AOq15FJTWk3bMXdbga0B8R+WsxPMSv1dFIxagz3CVA5KWYH6CxN2pmvavtRLSfY+R43kWNkzUFpQJ2prKISMn34J6CnRYUq8CNk9lcELzSo03v6vPrP/1emBojzJ7RWddmGHP4bAS9dR3wx6ehnncJIyW9cnw2qnIgeElrjtAfeY1KEXEhyMA/OquLhUipmYeOuGCi0R/Q1S7m9mrchNQ/QE1X1CQKPMf6g9sg6BHLdHpJ6A23Qw4B2TWu0F6rpAmpaydwmqVnio8IqNlIUcuhB1kwvrX1LlsP57JMd0uqgUTf3ZO/RAP3u9NygAS6zzNAxC5impuqPcchXvWO3L8DZbAnZllBUXu0h0tmH45Q/GlRiv7FLupUi0prWiWwpevKG83FZUFk4c49svPHJs1UZEi9D+cI23P8qVXAts36yKphfNnsKGXo/BNmetsQHLKQJ/j6MfN77
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1+m+X9dA8nhQbtIBM5jHEeIpuPmw1Gnz9sZkkEVnvLccEKncacPzVQ7n1Qyv?=
 =?us-ascii?Q?dXKGvuOg7ELhqSSAvJfCvv1wbB+7l6Tv2jMSnQJdNpMBTbPuR0vZTbsRXhma?=
 =?us-ascii?Q?VowY/D24ldRoKVDii7l8RjyuBLSTFw8LQ1GvVSmLURnrnLr0HEKe6Cm/UcMV?=
 =?us-ascii?Q?6IQ/lewwVMeJyVbQmTq+z3nFCYsmJwMTlW/DPoeeg6ZqMZ39I2BYslT2x7jr?=
 =?us-ascii?Q?0YPNsbKEmNWjCrPYfM3wxLXDp4XsyUzkw/AMDe3RYfW5KnsDo1bzDc/xLuuR?=
 =?us-ascii?Q?eH9JwRXzphiYNMnPQvoGUy01E8/lRen6xD48lomtpX8vpgk/kWneP6N53nPF?=
 =?us-ascii?Q?HI1WAkzsqORtn953VC9bYXxyBGo6o3as3Bx6PQDHzBs8YQBx+Yta7HIkTPxF?=
 =?us-ascii?Q?QhVDeIN3qUhugRqcNJtX2Ju1hi9wZrsw1LTIliVxeF1+1MolakIRQ55hsgEM?=
 =?us-ascii?Q?xLUxvwZsnUsw3kIJo/7A+W0T7tJvewNS4zGtYKZpK1+mhWjJ2VCwimrgPb66?=
 =?us-ascii?Q?+dMi1qM3z/Fo+XhYD5dkwZHgnjs71cXQjIxGzgbfZsJTQ8RWji48aoJPLxUl?=
 =?us-ascii?Q?NJHBDuiMdkdB8i3UvtWUGRDqKijbt/pKU/gC1StYys+ucj4ExHzn3a245LMB?=
 =?us-ascii?Q?KvWe4WGr9HC6MPaTuSDTTyG25eXlONf1T+1QQkCV+YUnIhTXg+umW3OUD18+?=
 =?us-ascii?Q?iUMfsM0mGbcf2+ErzPHbbPQhtDuiOcvr903jpF/PjdCFiBR2Rz1hOiQTl2Q+?=
 =?us-ascii?Q?8127LOgprsYZFGaeHosGkocV1sUfazesoCN3rYcnjQJrcqEXlC4gA/Q+9KWw?=
 =?us-ascii?Q?dm5fm5Wnaqhs/UQ2XmE2FfgCzuQaw/ICFJ0a00KSI/RRWay4lb2LXxedHD86?=
 =?us-ascii?Q?9+AHhOp4W4XAzFXRtU5zsHEJBlVH/YgTExc5Io2H0ruum6ZAkCzwFNtqJANo?=
 =?us-ascii?Q?2ErTxFsE2FvYljPQBp0Y+s2BP73Z7zJ5veJL8brRjHYKdEskbzwajdYtEpl3?=
 =?us-ascii?Q?h05veQ817f7jzkASLAwxLZPbF3G8HCj2coG/4HL7NQlix6fofM0IcV/Zkg+P?=
 =?us-ascii?Q?kzcil6kGs/gBXvEOiz37IJAHKVfTrZTCS1O+GsxYZecl8fCk2lM2a/DXjuh1?=
 =?us-ascii?Q?6+fBXYUc1CumiDxYiMoc0rxzVx9nJ75CZiJnDL5LpBl2YMD6rUL19nyzCZIA?=
 =?us-ascii?Q?Qeg8WuVaCw/khlS888197Rmp8TSGSD1Fl356MGIsECHsbtqzbvfKdUP8jMg?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d7024e1-166e-4ed0-9859-08dcf1bc9fbf
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 10:39:21.7433 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P300MB0749
Received-SPF: pass client-ip=2a01:111:f403:2819::815;
 envelope-from=junjie.mao@hotmail.com;
 helo=AUS01-SY4-obe.outbound.protection.outlook.com
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

> Use the "struct update" syntax to initialize most of the fields to zero,
> and simplify the handmade type-checking of $name.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/qemu-api/src/device_class.rs | 29 ++++++-----------------------
>  1 file changed, 6 insertions(+), 23 deletions(-)
>
> diff --git a/rust/qemu-api/src/device_class.rs b/rust/qemu-api/src/device_class.rs
> index 2219b9f73d0..5aba426d243 100644
> --- a/rust/qemu-api/src/device_class.rs
> +++ b/rust/qemu-api/src/device_class.rs
> @@ -29,44 +29,27 @@ macro_rules! device_class_init {
>  macro_rules! define_property {
>      ($name:expr, $state:ty, $field:expr, $prop:expr, $type:expr, default = $defval:expr$(,)*) => {
>          $crate::bindings::Property {
> -            name: {
> -                #[used]
> -                static _TEMP: &::core::ffi::CStr = $name;
> -                _TEMP.as_ptr()
> -            },
> +            // use associated function syntax for type checking
> +            name: ::core::ffi::CStr::as_ptr($name),
>              info: $prop,
>              offset: ::core::mem::offset_of!($state, $field)
>                  .try_into()
>                  .expect("Could not fit offset value to type"),
> -            bitnr: 0,
> -            bitmask: 0,
>              set_default: true,
>              defval: $crate::bindings::Property__bindgen_ty_1 { u: $defval.into() },
> -            arrayoffset: 0,
> -            arrayinfo: ::core::ptr::null(),
> -            arrayfieldsize: 0,
> -            link_type: ::core::ptr::null(),
> +            ..unsafe { ::core::mem::MaybeUninit::<$crate::bindings::Property>::zeroed().assume_init() }

zeroed() is const only since 1.75.0 [1]. Is there any alternative for
older Rust versions?

[1] https://doc.rust-lang.org/std/mem/union.MaybeUninit.html#method.zeroed

--
Best Regards
Junjie Mao

