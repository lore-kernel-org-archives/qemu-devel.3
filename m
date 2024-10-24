Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A1BBD0BB4F
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 03:02:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3o6l-0005ex-EF; Wed, 23 Oct 2024 23:01:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t3o6j-0005em-Bx
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 23:01:53 -0400
Received: from mail-sy4aus01olkn20817.outbound.protection.outlook.com
 ([2a01:111:f403:2819::817]
 helo=AUS01-SY4-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t3o6h-0005Yd-PA
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 23:01:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yLeARREtTk0V50fDRZi2oyBO0hYk9I7bSWbwvS0AE1ROCyeih2xFn6bys9jQDAnKO+OHtbdlglPRozif1XWcbYWMSxKpBaoSWPKE85jR4LMbfF1LdhNZALOBwmPhGfpIvCvwOpTZ1b2JXE1dxMwKLI3zG9HE98oh64pdZVFHZjVP5QTW97f3FsgBeIfyBqWc977weXsObHcj6eWAuKY0XvQVbF4RCekzkqrmO2cEdm91C2thur6d0wxHyVxuEhu+61NARRo/zHJA3bIcaumvgc56BiacxqtnUtenTw+speKy5MFBo695fE7XeuCHNXaxGKtn5+Cx+wr9aFgI0HiA7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ytiY3Bra0pcqdIs8udB90JZhNrq55JfQvs6O+xuRiLs=;
 b=X3hsfGnHNF+qP5E5EAJJDwSUuhixSpjmqns/8dwWNgTetjM7OldDv/ywAFLwE2Rp4pN9Wu9USN1V/IqoLXMJh21Am4XpEcvqYcPIuuKdQ4QqDCQSg9kMAvrUJ2oOE+Zn+PdJiYaB01zMoNcc9qBBLXBODHfv0duoy9gfJD85vgMoWkG9upWnYi3n1NH7AqjRmo4lRAIhOa5jZ8sNb+uC8NIw15lgi0OpFXk53Vd/xA9hKHd3RpMg0rpve95hoNHU41u1yG4H8gFJteJ28cICI9XAZVtsGrkNMYQVXUQ4BB20mW/wTgMVTXOWB/BTQ0FtBIas6ZV2+sMJPa1PqiQjww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytiY3Bra0pcqdIs8udB90JZhNrq55JfQvs6O+xuRiLs=;
 b=ccwsGx/Epp9I5eIgulTVspg2JEmHAtFClvbbdxlzRo3fTlWY/FRJU63jimuq/+5pqZn5MrX46UXBj/E6Udce/aY7VOmOvpf6ZLBsPADM3Wgg05wlIpZ4S3YtTaclxQSQsVlaKShxllzpe44sWNBZJI6zEEyjzRJi5RQyRqLObsgTruh2I34SDe/5Q0bpmj/Wm9ceNcfMU3nbijeSivnDXBsEZ+xXiPDRqvHJk3RpaS8kWxV0mQLMCXV9NYb+mywTtAQ1YKh2o0GKdOa97OlHBfenblm14UxcndKzHlrYc6G3yzaJBUEkI10VZRBE+OvfsT2/Qgam+2lgDuzSOq8A8w==
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:282::22)
 by ME0P300MB1387.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:244::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23; Thu, 24 Oct
 2024 03:01:45 +0000
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd]) by SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd%2]) with mapi id 15.20.8093.018; Thu, 24 Oct 2024
 03:01:45 +0000
References: <20241022100956.196657-1-pbonzini@redhat.com>
 <20241022100956.196657-7-pbonzini@redhat.com>
User-agent: mu4e 1.6.10; emacs 27.1
From: Junjie Mao <junjie.mao@hotmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, kwolf@redhat.com,
 manos.pitsidianakis@linaro.org
Subject: Re: [PATCH v2 06/14] rust: synchronize dependencies between
 subprojects and Cargo.lock
Date: Thu, 24 Oct 2024 10:53:26 +0800
In-reply-to: <20241022100956.196657-7-pbonzini@redhat.com>
Message-ID: <SY0P300MB1026AD4676BFD368DC51CA04954E2@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::13) To SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:282::22)
X-Microsoft-Original-Message-ID: <87o73ai4q8.fsf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB1026:EE_|ME0P300MB1387:EE_
X-MS-Office365-Filtering-Correlation-Id: 11a72911-33a5-4fe8-dbd8-08dcf3d83167
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|8060799006|7092599003|15080799006|19110799003|5072599009|461199028|440099028|3412199025;
X-Microsoft-Antispam-Message-Info: r2XVJPBxXKgA/jBkoL4fE7OT2W9G4Zq12mKcE0091Ttp5U1J/Fzget/+JDm7kXP9XhRHqSWhfXCAhw5yTKkCC+VIBFRkdqbrQUoiZ+SjMhHrAxpwJ5UWyrMeV0npTObgAEp5PEBNqdo5EQg3eK60YMQmK06nrP4URIuOBju+zVLONrlC1wt0KrmQR+HkyytqxYhfR1Z0BFT0zC99sAUVNV3cxSgcptH9U2/T4pOLvU+zzinFhpOcNPFYFwlo/ST+5v0KUSnz0SuQclFk8ZSjDGK2iTP4/uotsCGhkWTZK9Bl4CaYbMv02fr7H7grtn1sEEyTp64a37ozR6xtxxUxBUbIEnnxMTwPBcqtxhludLf1/r8kbnP2JIb1EHOQKnHJhRJdVLXc0ac+GycAO5ZYHG6cg77xwmi1lGyy6MBt9VDaniImqYcgl7Rz46ORKLIqD1u/mk14ordeY/Exodno+T/KRi8KnjUJ825/lWcpK1bADCHxkfbQRWVzBtKsoGHmXIE0yfP/8gAfC3rz79RjcGCN8Z7leCRn/nzKpprnBkHzgHgB7J8V9KD567XB8WNP+i/Jw4FBLlOh/3oM2zA2W3F1/oNdygsbwBxSeu/rt9CF4/zioCM/o+u2tMPhfQd+Io0JnKLnuIzJwvt+Xs4hOBL1CbkAuaKO1ZXsyfixQv9MYm+5ghMYQPQOmIjuXFaYDYmp9z3LGapkV4zpJyDUuyFqgNdgdHq+CdhFCT69YFM=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x7MfVc01mL5zXtBYzp2nFgtibZQWK5GXDWndtCGGRaKXhdFRAh6UYgn/nFDS?=
 =?us-ascii?Q?Gb1J8s566wwaTA8N5LbiWezyYAwSI4wA25Te7CH4rNrhP/GruPisOtSgi1yo?=
 =?us-ascii?Q?MOyIerOkaHveFm+Aeowrh4XKD2Ah67h3PyzYVVKBiSL1iKI61EnPG/zYDW9d?=
 =?us-ascii?Q?GddSRx0RFFIjmhcsnH2lx/l0lNGDkd/pVkb8p/9g6TRF8Hmiy8Lj/nb91JDa?=
 =?us-ascii?Q?lOwkB9z9TE1k9b5dgRp/PBYckBCLwMKCmr7j5NvS6R+SGAatznEZ+AYtDGpo?=
 =?us-ascii?Q?vlE+Aq2ZYkjGRICQPlo75enPM7yux5D7yV+WwzlCnYLmGTEucH4+5ty8d+qi?=
 =?us-ascii?Q?VFzNp9Y6JiQ4JWkzRJAVKYlWkdZkz55f6H/jKrQeYGPVkBlB6Po+JG2FIma1?=
 =?us-ascii?Q?UpRs3alP+Xwjm8Qt19QcoFp1I+NzG/NPADYNmnyDha2oOAmeNPutwxTmcPRa?=
 =?us-ascii?Q?jOX8q+XBhieNvH9Ug6sMKPezAKQakroghsfbBLyoNoxfUT2NDHBlvYlX8wzq?=
 =?us-ascii?Q?XMmUVGbKu2raJgbsLEakKmmexO5M+SZwfU8ma11NeVGb93A1ncZi8uVKwY2U?=
 =?us-ascii?Q?jgQ/bYMhawklGHGcN0YTprBRApqmSt8BExs2KHo+S60zffv87TjohcbMurXL?=
 =?us-ascii?Q?c6LAuw4rGJYm9y+DM3G/9gLmQ2JW/uyGP2oyHKqqYsvsfjXO93sfCkr0hcH0?=
 =?us-ascii?Q?7fxwzukSBuJ/BAgkOZGI5jlEKgAupFOAgFg7oAjXoVhxZFsHu/4b8A2qpEv9?=
 =?us-ascii?Q?Mo9IQTn7X3kyuNhED3mFIorOW0lRMUXPGUt8fkGZzsQGkpj6gwM0F6DsT5/2?=
 =?us-ascii?Q?ytaWysq4y2fhkFwc72vczRMGcPDDr7/shp9oMIglN77qbEazyp/BKQLL16AI?=
 =?us-ascii?Q?BAdfm+JQa74KNjFBbJ/3N12Aqo0x8i5982q1q71yRB7xpSNFi5IdTYwwZHea?=
 =?us-ascii?Q?T9wEWOMbH1azH9uTsdF17r3b01wn0E1/daI+3Jaaid/KZDQcqcIE7/dXKtz1?=
 =?us-ascii?Q?PPdKe3Aw8Mp268q3tlwZ5nUDGS9iApITimsbV08RWwj1BZYJKji3ZOWrEXF/?=
 =?us-ascii?Q?+9OPXJA9xrzzAmX5+2JuSi5YpbwTN9iQDMAJAc+lCtw8tcM41vVUFuVenEaG?=
 =?us-ascii?Q?UPa94/+AFyhqOghjCd3wF4k1h/XqWa3zZRmHl36TMR4O0pLxB5fK41y4cK7V?=
 =?us-ascii?Q?DnJJrUg9EMXxPk7SzOFCtsEqtrMH7421zI0XCI7fKl41woj4VDQIWGcGrkE?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 11a72911-33a5-4fe8-dbd8-08dcf3d83167
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 03:01:44.9873 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME0P300MB1387
Received-SPF: pass client-ip=2a01:111:f403:2819::817;
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

> The next commit will introduce a new build dependency for rust/qemu-api,
> version_check.  Before adding it, ensure that all dependencies are
> synchronized between the Meson- and cargo-based build systems.
>
> Note that it's not clear whether in the long term we'll use Cargo for
> anything; it seems that the three main uses (clippy, rustfmt, rustdoc)

Here's a fourth use case: "cargo expand" for debugging Rust macros.

> can all be invoked manually---either via glue code in QEMU, or by
> extending Meson to gain the relevant functionality.  However, for
> the time being we're stuck with Cargo so it should at least look at
> the same code as the rest of the build system.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/Cargo.lock   |  5 +++-
>  rust/qemu-api-macros/Cargo.lock | 11 ++++----
>  rust/qemu-api/Cargo.lock        | 49 ++++++++++++++++++++++++++++++++-
>  rust/qemu-api/Cargo.toml        |  1 +
>  4 files changed, 59 insertions(+), 7 deletions(-)
>
> diff --git a/rust/hw/char/pl011/Cargo.lock b/rust/hw/char/pl011/Cargo.lock
> index b58cebb186e..82028ddf793 100644
> --- a/rust/hw/char/pl011/Cargo.lock
> +++ b/rust/hw/char/pl011/Cargo.lock
> @@ -1,6 +1,6 @@
>  # This file is automatically @generated by Cargo.
>  # It is not intended for manual editing.
> -version = 3
> +version = 4

V4 was introduced in Rust 1.78. Should we stick to V3 as the MSRV is 1.63.0?

>
>  [[package]]
>  name = "arbitrary-int"
> @@ -91,6 +91,9 @@ dependencies = [
>  [[package]]
>  name = "qemu_api"
>  version = "0.1.0"
> +dependencies = [
> + "qemu_api_macros",
> +]

I would suggest adding those dependencies and version constraints in
Cargo.toml, not Cargo.lock. Future devices in Rust will have their
Cargo.lock derived from Cargo.toml of qemu-api and qemu-api-macro, so
missing version info there will force device writers to manually tweak
their Cargo.lock.

--
Best Regards
Junjie Mao

