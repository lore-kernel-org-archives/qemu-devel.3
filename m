Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59842D4335C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 02:51:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9F4u-0004QJ-32; Thu, 07 Nov 2024 21:50:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t9F4s-0004Q9-6w
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 21:50:26 -0500
Received: from mail-me3aus01olkn2081e.outbound.protection.outlook.com
 ([2a01:111:f403:2818::81e]
 helo=AUS01-ME3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t9F4p-0005M5-MG
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 21:50:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fhnbL3B8JNgbjkli+3wRUKcRmGFvyeNRL+lPFCxt8PtkYU6pSjwQ52mHRDtpr8m+1R7j16zuRsUGA7BUO401Y1gho/0auL5kUuFp9Ji9K2hqAk/Qk3TIarF/C1362CpT52cq8IYjwZeAPv34zvFuw7ut/F18GN+l3H/lKGKTNlgl+Vwvz/Qhtz+VhSLwfEGwrY5xb3CB2HyR6uLAiTTOD5hHqK9w4Y6aCQADE/1GqLHeMMqD2DBgLwrIG37Te1RBxho0Y1EGSjVn0Uv7GH8DdDWCixtmVdhxh5q2fq0Wux6fz1RVqWWzqRSifZZEFI1QMjwZLDQSip5opciprDHu7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nPpplNqE4l8II6Ucfkxx8TgsskSZv4r4/XGADQAdL9U=;
 b=ndy/0PzxGwhCjRdp3MUj0zm8Z10KtDZcg2bnRhPxboQvN5Py6AAhSVCT2NlCHF3GVVD2j+Mb2xqPkM5NfstPniJaIlSZl77kjLf9pSlUst9utwv8Mnf+sQjm0Zx8z8WU7E8SadirenGyh3ZqrtnEBh1ycIHJwrjzcjEIe/wE0Tp3cXwULI/fgVVbrfuk6ipCYVJ+g0IOUVDLJp+UdaWJbrVMFVgpg8QGbcAljbm4yhpDjw+BSwwVwDSr180bWfo/HMt3WHfit47cVL5hEUD14PCrA9t/9kRoSHQk8en4PtiDYdKzFjIygObwONskMvc0GjWDRkjkapwPDIwAKDfI0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPpplNqE4l8II6Ucfkxx8TgsskSZv4r4/XGADQAdL9U=;
 b=RCo3z6++L+XHVlud/ThuFi/8qsZ1XhlitELFXEO6Jcm2KGATcjRQkg7jyXL1sRyiVF8jEcekkE44XKzbfOtMWtynKpceyJud0XeKH7bUHKIRdnrcO5kCkh+SOhZ6cuXfEo8oXF+ERMwD8stLhruh33EPYJKAkqqzSRTPksLeQvxh+Vg3twPI8K6JXHVwmYvyUHSpNJfLjCHvUWZI3joHOFWehXPQkAy2cEFuNmKbixbHJJzcV9zpD3mkdQR4rTZx5UPwTibvKtqOpmeGZdUP13bW97s5McndzjC9/hxmmzozDgKDCk7wMdljlQr/iX9vE4f1dPfz2diM76f68oMcdg==
Received: from ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:231::14)
 by SY7P300MB0011.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:218::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Fri, 8 Nov
 2024 02:50:13 +0000
Received: from ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM
 ([fe80::f32e:6e2b:b854:7166]) by ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM
 ([fe80::f32e:6e2b:b854:7166%6]) with mapi id 15.20.8137.019; Fri, 8 Nov 2024
 02:50:13 +0000
References: <20241107092622.616487-1-pbonzini@redhat.com>
User-agent: mu4e 1.6.10; emacs 27.1
From: Junjie Mao <junjie.mao@hotmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] rust: qemu-api-macros: always process subprojects
 before dependencies
Date: Fri, 08 Nov 2024 10:49:20 +0800
In-reply-to: <20241107092622.616487-1-pbonzini@redhat.com>
Message-ID: <ME0P300MB10400AE739FA61AA3670E36D955D2@ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0057.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::10) To ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:220:231::14)
X-Microsoft-Original-Message-ID: <87wmheo2w5.fsf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ME0P300MB1040:EE_|SY7P300MB0011:EE_
X-MS-Office365-Filtering-Correlation-Id: 325c3e80-7223-43c5-80c0-08dcffa01193
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|19110799003|5072599009|15080799006|7092599003|461199028|8060799006|440099028|3412199025;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qyW4ErhYzkQQkxzO6wQY4XZLyIPzgP3Tx0gdxvNb6ikVSgTyoidKocZ81j/x?=
 =?us-ascii?Q?vgwGOkFekUhQqGrtBQqUNkJbj1J+fqB8L3l1ePpx56UMhK35PbfJlg+tOYaX?=
 =?us-ascii?Q?pzLn0a3GrWAoXNI4QOqS9yi2h/0XxqH60Hq/ze74SK1JysvXIZSkcDYhW892?=
 =?us-ascii?Q?5J9MySTCGqYzAF+Ia2X3IDSTe9C/+RL9/ldyBA2QzrHRA0taxRomJZk0iqhs?=
 =?us-ascii?Q?P/wMc1mLFpGK2d0oPunIscjfD4zu24pGmpdtXOlDXwhEyjhX+zs94pxvKt4D?=
 =?us-ascii?Q?KgXiDEKd5OLmcrQNKrIqLZZbzP8V2NVbsTRMvqI/Nghe1KVyzGX/5c+r+lkV?=
 =?us-ascii?Q?igzuVVViCEMj61+Dqua0wvTMUv2mpR1or1OFuJSYxo78Nt7Kbc0sEqyuqj52?=
 =?us-ascii?Q?vL0RliNbCWbTyVuXw53XrJbr7CIObGhWNYQktqR7gqfummY1/bVX+qV1ouNN?=
 =?us-ascii?Q?L1FifR2ydSx9NPNbVsvCyQAExsjtBNIuAWXvQBSO/HkQOBjHpmZvtqoF73oz?=
 =?us-ascii?Q?VXw5muD/3qfxOF23+4anA3EjjEvYgctAwWjQwLEpAdPaRVin6h4jORMzmy3f?=
 =?us-ascii?Q?G4fJZ+BNfp9CF5x6kXYlQMHYjSi+1vDzDzl72+wBByEUlXeemQ0J2Ux/D9CM?=
 =?us-ascii?Q?VXj68EIr1CWWrIzoa58H3qqrSvLngP1tBvHsb0USljy6cB7iAJzloz+itXBa?=
 =?us-ascii?Q?h+rmKA16bRYkH54tLi4hVzfxV6BfYprfrQ+UXQuC8hSfw1GSnZOwAUYHaCq0?=
 =?us-ascii?Q?8hk6N53PBVRsKvHu6Y5YVM6Nqi2uYIg1n0o3GIwdk+YfVCFiT8v/qxV1j9G7?=
 =?us-ascii?Q?58qGC/XKuldNpx2qghVKB5u5LPhumhUYb3pSFDRT4i7rqRQSAUgk45r/BbpR?=
 =?us-ascii?Q?HySUNbhWll7d9qgBTD6t91VAyAm8mw2CEBp27NuigzzIENOf9lGMIWtkS0Ai?=
 =?us-ascii?Q?4EwsMm2KmSRCvjr0hs2loDNR63bInUlxoT6EiYAOJknu5HWH9GI8wg+0kWcE?=
 =?us-ascii?Q?Qgz1tDVRRs2PcW167Zpu3zNkvhqx3L/keurbMqjEv7ae0J8=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T8KoUp6ClmClryDTocBA8gABfZNy6fLBXpXOlfxbjyYhTf2yefjOBYOKvWCj?=
 =?us-ascii?Q?skazXX1hGJ0Tl//4ngXfuUtxrF0w/qngxItH+TVJp/gZAryfDahPtMSygbIp?=
 =?us-ascii?Q?tca1+k7eeFIRt8RaVd8QrE4wk+EjWfSL+/wp1UAO9xeZT+JCfmUwyd6JtWco?=
 =?us-ascii?Q?A2mnLCbtGsNnYGjJZSivfSL0epvr0AeG5pcLcSamHuWgCh2MrVTQcd/8k8ss?=
 =?us-ascii?Q?br9I//UWQvopyn29FpA82hmy/uopP1w66JUZFSRRsxuaitNFvJ4Q4QY/GxQR?=
 =?us-ascii?Q?iPHVO94D9FcRL1koprPeNv0uzGZscI3sYer3R1B2MivT5065HRdGepKhOFOk?=
 =?us-ascii?Q?4icHo3cg02qgN7T+6qZNLTCPhC7bEcxeAZrZN7iwPRtBGl0BSJRcHRxXvV9V?=
 =?us-ascii?Q?RiiRdHu2oZGoHrZp52GckiNS4x466QwG9vW+NWkMlitXDw0a3LfCrKDKgyc0?=
 =?us-ascii?Q?FFtiwBWOZfPzwYXODef+4x8mMxQpHa/F6ipyuyyf3WffskGWSOLarIZHdXMU?=
 =?us-ascii?Q?0gkuYH3MpnvSYTfOxn7wLrVf/6Zv/2AeqUkCRwOEffl2ywVijHWMRIYZCgwy?=
 =?us-ascii?Q?zxonV4qpg+RxX9gJA33KIpNeCJVO3rtGQFTRTP5mC7ETnmmsajZw3Pqn9i70?=
 =?us-ascii?Q?w/nwamfcwADNS9iLgfUEYtjwiI3ifik2udVDcZFCU3vy+7lMReYvYQiOThYf?=
 =?us-ascii?Q?cR90y4MqcuTgUoC2k/AsYAeWkzHXQVMtfd06GyMOlLq0TsFwRzQFqwMY5Y3a?=
 =?us-ascii?Q?2KlNB4Eb2eQ/IAj2EEgWcpLofIzN/mRnNeh7Z2mHmYeRXHy6aN+iBuBZ+t9h?=
 =?us-ascii?Q?CgPQuuP+V14YfM0aSBuwq9mScmtC1B01bcM1h/pJ3RqTf1NGGWlhu83Xjp+w?=
 =?us-ascii?Q?Lhr5f8sRrIllUhAsG/qIy7MOdHimOclTbLaxWOHfFfxz+SjVj6reU69uBTfY?=
 =?us-ascii?Q?gcc/fwP/eSjz8QcVwtcG04XJ3OG4st/BP9pQ+tI2iJWZShBwHCxNwgkSBl8S?=
 =?us-ascii?Q?rZAh9KuPtX44DEyqdiurwWUlMcClBUkziNmy9pNigl+2GJrN2pJ0oX85xHSu?=
 =?us-ascii?Q?QwISCnv7IZAM4/Vmv0b/KbZxOdLY2zkmz9dvqFz9hIXtWi+3NQ/Y4taf3BZY?=
 =?us-ascii?Q?XWKPWAkg/yZ0dW7s+nu29udauhcrMdCw8COyCxsZKCHMcvCYabA6RZrJevmE?=
 =?us-ascii?Q?eUMMEtf2gClUaCOWLASWpZW6B+sKR3uxjRFesLl5xJFxfOztAes9LMoq/sY?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 325c3e80-7223-43c5-80c0-08dcffa01193
X-MS-Exchange-CrossTenant-AuthSource: ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 02:50:13.7503 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P300MB0011
Received-SPF: pass client-ip=2a01:111:f403:2818::81e;
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

> Avoid looking for Rust dependencies via cmake.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Junjie Mao <junjie.mao@hotmail.com>

> ---
>  rust/qemu-api-macros/meson.build | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/rust/qemu-api-macros/meson.build b/rust/qemu-api-macros/meson.build
> index 24325dea5c2..6f94a4bb3c2 100644
> --- a/rust/qemu-api-macros/meson.build
> +++ b/rust/qemu-api-macros/meson.build
> @@ -1,3 +1,7 @@
> +subproject('proc-macro2-1-rs', required: true)
> +subproject('quote-1-rs', required: true)
> +subproject('syn-2-rs', required: true)
> +
>  quote_dep = dependency('quote-1-rs', native: true)
>  syn_dep = dependency('syn-2-rs', native: true)
>  proc_macro2_dep = dependency('proc-macro2-1-rs', native: true)

