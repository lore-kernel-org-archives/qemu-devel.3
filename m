Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0710BD0E6F7
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 11:40:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2qla-0003ZM-JZ; Mon, 21 Oct 2024 07:40:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t2ql7-0003EE-VZ
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 07:39:40 -0400
Received: from mail-me3aus01olkn20814.outbound.protection.outlook.com
 ([2a01:111:f403:2818::814]
 helo=AUS01-ME3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t2ql6-0001y1-50
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 07:39:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TcLGGUyVv96zkcBwJthcHiMuouh7U0sZw79GATRx8fqT3mySNAHKY3pfl4L9blDdEi9cvZjJtradmN5JU60uf216e0uo3uIWlI70mqCagRkQtZP4VO4U/EJA2UKb4dalxc8s7ee87d9rCyi8vCRYwCGcctM2ytSUabZiEJXJ/QEmd2fkNANjqQGiAhlZZHO/rT3eAjXOfxoXENW7zL45rG+7sVsT0YFd4CuBC5y4dc+sgZYnsQ+Ac4PaynlHxOJa/rq5MhBAXkuH5vK1Pipso0MAFZCbvNlpJ3A/ZE53av/dPLldLaVoIXtgw0ZnrVdFx46GRR4QYrV87rxqXUqsJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UE6iaAtxxeFE4g/MLeVFw7ixcUXL7Z75s5oqiwFQYZE=;
 b=KOD62WUgo/LzpndHd0qGHjjSb+UuPpvWCRLkbljn+WOPu3Nz5orBzfNJQkso1Cf9mKjMKqaAfZ7R72SjEKMdMrMrLx+BosZz6XB140kgMAIoYza88YZlg78p8AGOIrgyC2jGnKtSZr0iWckA26Gy61r25B4u9u31TC7ByaZq+20lEqEkCCrAqlBvJYafFXjPy0K/R/eW1IhORii+cUqpx9RWn+Qx+uB8iZ+LDWM8updY4cqEgxFi4VvEPVZfgrIT1exq94yIHCBcGNijmmLur3c3dBchfBdTn6Yu9wo7uLO/1P9PyRNM34cQeD7olg/H2MNQeOzplfi48HlqEokk8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UE6iaAtxxeFE4g/MLeVFw7ixcUXL7Z75s5oqiwFQYZE=;
 b=tm9I6GauGmbzfv8CvLg1bXGTsjXdtp3OEWhN/JhV98+ex3eOizY+aBedkdbiZYsuB+Q0h+U1Hk+76Y3VE/VT5lhGnkBQ0i3cg1+fC4ZsKjA0LhZQmsAkSoOY2ySKe/gmd/ZMd68RyvX4ke4NPsCRmIGE/zzU6WjYZ1GKANcwdLcV4TheVDeAeI61gpKNJ+pAtLZl9LhscCad/YDk9yUptqxWbwQB7vOYjIwxdfszzA4iqm8/X9kzLrUxRRQ5ZGLuMRVCgsL844jFrSeCe21tDP5b9U0j37Vi1+k24gOFqt+FsXbhON9pMNxY9IOmyajHBlxm2BCv6KSb+m3sG2d5KA==
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:282::22)
 by SY7P300MB0292.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:236::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23; Mon, 21 Oct
 2024 11:39:28 +0000
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd]) by SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd%2]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 11:39:28 +0000
References: <20241018144306.954716-1-pbonzini@redhat.com>
 <20241018144306.954716-10-pbonzini@redhat.com>
 <SY0P300MB1026DF84A11DD5A72EC45EEB95432@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
 <CABgObfYox+Un798wFjxktDsa7XnjXmgM8ohTeotD2eFpqAweeg@mail.gmail.com>
User-agent: mu4e 1.6.10; emacs 27.1
From: Junjie Mao <junjie.mao@hotmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH 09/13] rust: clean up define_property macro
Date: Mon, 21 Oct 2024 19:37:38 +0800
In-reply-to: <CABgObfYox+Un798wFjxktDsa7XnjXmgM8ohTeotD2eFpqAweeg@mail.gmail.com>
Message-ID: <SY0P300MB1026052067932D3A10A9C89595432@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain
X-ClientProxiedBy: KL1PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:820:c::16) To SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:282::22)
X-Microsoft-Original-Message-ID: <87h695sn14.fsf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB1026:EE_|SY7P300MB0292:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e52ccbb-212f-4a5b-e4f0-08dcf1c505ba
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|15080799006|7092599003|8060799006|461199028|5072599009|19110799003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info: bktBiIqY72R12F1MHRoSI+0bpzo8h9TjTbdL7ezgPn6kC3CYLCiRsuDgO62Q/rm8gGsV6kjWTNpGNBYGl5FM/auhF8Cyaf4Kw2MAI6ytPcwq0kxpKTMNrpHvr23luiD74DfmXzBEfFEV0YdnxBptPBWU+D19kUv7Ka4dWwuWFN6odh5gZWrucqslZF7t5OfxsE96vJd+OI5bz5vZ0jfdvgcYMHQC8fV2Z/rtO6bpIJJ/btoPHYJhai1oifsjkaE5g50SA3Ly3VYkcVy+bjNh8RfEADXNR9243EoGU2KbDhy234RQIsiLkz7FB1tNjk2NKni1Blmn7A7FtNeCcb58YeEMD5Q0rZu+g/Tsnjt8RsaaloeDWQkzIm5/kEUxPNTUBBt374JLykHjWNLa6RUt2pDZkH8I0RtyIMOYAaZpJlTbXEiGFxXMgthIqAEdHLSFlIm0VTRWdIVe3umW4ZFP7WGa6ML/av2uBJNBpxOBF9W0JYtmetNBVjKZOv7iLLg4w2KAWaoD6R7l0q4Zd++PKmTXwAccA/FghgoxUIhI1E0uonlXNiFaZkWOz+ZO5TAOQWznqopun1TryMFDP34LB/vW9tK3FsuLqxmwDSOGtKboNRtjeHn1Wizw+GN3j/POWlSOpxs9KvmKCuQ0496P6avMst4uMnTofiG51CSjSSLcuOEbA7q5DZncSmNgvUeW4oFuJExEHd8KV0nPFpCy9NrO0M/VJysA5z5RAxueSn8=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PYz+kLL6/nv7jQ1sXwKA/HMncQOv8H4826nSqGkbBvejgnMrSiCDid0UGYRV?=
 =?us-ascii?Q?N6NZNZl/SsGDJhoX2in2xEZ2CtAyAfN0zHngT3H3PZD4euhG7/GZZ039FqYB?=
 =?us-ascii?Q?VHsSrj1vFe8H52edng+KTA9I0fTtoNPtp5eElIhvHG9AnWmS/0HtS6FjrwTz?=
 =?us-ascii?Q?AT6qSvmHwuv+VhBrqyNWtGwA/1gB0caHUrYAKw0RNRQZ1/exHGf6EajZWwht?=
 =?us-ascii?Q?VeP9FDr9IqxCr5CAyS4upBl/KtrimNksTQrCSc/Ce4CxpmQ3lJE4ONcJHGgR?=
 =?us-ascii?Q?yfzHZ/8xnHHNDloNao7sGKvEDKk4w/R7NTov/EzjoWK6GSipZvrkY7yGqchT?=
 =?us-ascii?Q?deIM6lVVqHHUlwfFWqOSLRmPeofc3j3UtxqLIx58ZhEb0sqkSKL9ba1SYIXi?=
 =?us-ascii?Q?EIQoxFvXcF+ZQq+rQw/XxpqfCFZSEAp/iG5sUIzlkiJORz8JvaP4+ER0p+Hz?=
 =?us-ascii?Q?BW8Wvs4zmzE+BbHlJsirOB7pwziCfYgmIBaKyC4FkmmtsW+KNxYGelWMyrqU?=
 =?us-ascii?Q?GMFcEi9gxuSRE/sqbmjNOYaLw/rq7y4zoemUm3FRTLoGs7Shf+2ayvQNeApQ?=
 =?us-ascii?Q?rIbQiNoFeYTV2lRoZGRsxDpeNEINxuELocDQyy8UCcs83yi4eDFD1Z1gEvoR?=
 =?us-ascii?Q?pjmEdnwF/Ef4ogkHskPfXVR7W3pn54uwRJ0ml1lbAZ30dan+IjG2LmOD8hwu?=
 =?us-ascii?Q?eYm2+WuK08IqsUPtUiJJ0EJg0HXqyAy4OZR/KqxNCbWgL9hq20cwXAZslSu/?=
 =?us-ascii?Q?I81YQgNd6m7XBNUPwnf7pLqdvwb0ATbqP3OBkLbb3z4fsBHxukUa0F2IIn28?=
 =?us-ascii?Q?yRldxdXiOzddYt8RDYNbWfp4156398zr5styQpL6zavShO0IvHwNi6qIOK0b?=
 =?us-ascii?Q?l6JbBEuViyoJoIj3IYMXJP0E0hrlnbPMF7hsC6amdE9CZRc6SajoromaxKxX?=
 =?us-ascii?Q?hhwtQM54tEwnw+3giHKRd41s3q2Lu6Cn/3LNFeu7DTyNRZk5X5zgWVElPnZu?=
 =?us-ascii?Q?QfoOW7001NNh9zClk9qEl7aC4BWhpah1pYWCEILLAxUGa5U4bp4ED6ra+Ie5?=
 =?us-ascii?Q?fD7484Obhz5aGLa/UOdiWNJQAJzEQOdOlqAkWaAGJ+j38Xe4/O9xr9LDK7v7?=
 =?us-ascii?Q?FIViRxNS7VVF6ocdlMXjXmMI1Zbf0hdHg2KjLG2o713QF7yLbB9fm9qzAAvK?=
 =?us-ascii?Q?SCIAkk+0oUWj8CXqJP9fIgg3u04CoK3HG/cUYxGRQ/x2pjQi8GB4rTd/vGk?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e52ccbb-212f-4a5b-e4f0-08dcf1c505ba
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 11:39:28.8145 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P300MB0292
Received-SPF: pass client-ip=2a01:111:f403:2818::814;
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

> Il lun 21 ott 2024, 12:39 Junjie Mao <junjie.mao@hotmail.com> ha scritto:
>
>  Paolo Bonzini <pbonzini@redhat.com> writes:
>
>  > Use the "struct update" syntax to initialize most of the fields to zero,
>  > and simplify the handmade type-checking of $name.
>  >
>  > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>  > ---
>  >  rust/qemu-api/src/device_class.rs | 29 ++++++-----------------------
>  >  1 file changed, 6 insertions(+), 23 deletions(-)
>  >
>  > diff --git a/rust/qemu-api/src/device_class.rs b/rust/qemu-api/src/device_class.rs
>  > index 2219b9f73d0..5aba426d243 100644
>  > --- a/rust/qemu-api/src/device_class.rs
>  > +++ b/rust/qemu-api/src/device_class.rs
>  > @@ -29,44 +29,27 @@ macro_rules! device_class_init {
>  >  macro_rules! define_property {
>  >      ($name:expr, $state:ty, $field:expr, $prop:expr, $type:expr, default = $defval:expr$(,)*) => {
>  >          $crate::bindings::Property {
>  > -            name: {
>  > -                #[used]
>  > -                static _TEMP: &::core::ffi::CStr = $name;
>  > -                _TEMP.as_ptr()
>  > -            },
>  > +            // use associated function syntax for type checking
>  > +            name: ::core::ffi::CStr::as_ptr($name),
>  >              info: $prop,
>  >              offset: ::core::mem::offset_of!($state, $field)
>  >                  .try_into()
>  >                  .expect("Could not fit offset value to type"),
>  > -            bitnr: 0,
>  > -            bitmask: 0,
>  >              set_default: true,
>  >              defval: $crate::bindings::Property__bindgen_ty_1 { u: $defval.into() },
>  > -            arrayoffset: 0,
>  > -            arrayinfo: ::core::ptr::null(),
>  > -            arrayfieldsize: 0,
>  > -            link_type: ::core::ptr::null(),
>  > +            ..unsafe { ::core::mem::MaybeUninit::<$crate::bindings::Property>::zeroed().assume_init() }
>
>  zeroed() is const only since 1.75.0 [1]. Is there any alternative for
>  older Rust versions?
>
> Yes: manual implementation of a Zeroable trait, as in the series I sent before one. For now I am not worrying about the MSRV, since the hacks/workarounds from those patches do not become any worse.

Ah, yes, I should have recalled seeing that earlier.

Reviewed-by: Junjie Mao <junjie.mao@hotmail.com>

--
Best Regards
Junjie Mao

