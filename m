Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C40BDE6C5E4
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 01:03:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIHIt-0001jQ-SJ; Mon, 02 Dec 2024 20:02:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1tIHIe-0001hm-VP; Mon, 02 Dec 2024 20:02:02 -0500
Received: from mail-me3aus01olkn20801.outbound.protection.outlook.com
 ([2a01:111:f403:2818::801]
 helo=AUS01-ME3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1tIHIb-0003No-J8; Mon, 02 Dec 2024 20:01:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kqIDNRRGcMcFjR655/dm27Aa67AWBhSQsjMOGWZKJ3ZuvSKIsLBVcL6Nyr5SYG93o89xhU2qIfsMaROMxuyjPxmHD1qPFGaKltA7zTL0Q0N8FF5Qu6lOqDnzl2nz1jFQmw11GJvHF21RQBNYbOnrC2gFGpOTdxulygq1OI4/xMMEhZjBSMIJUhByfu58gAqIAjuns3rWVSX5PwmqvIm0SIlPtpgHd6VeyTxuncx6eZJyApqC+J/9KeSFhxV7zgac/x/LnP1z+UpiecfRqd3xJ+e8+iJYr0qcsCBPWJSC2dP+j68bqLt0XDK5IJCuIw/Kp8BM4TAMMfkGxaKygZDSWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQJkaxU9x0tapBtY9ZmlYA5Q1rKV56eCxYirX5E+lp8=;
 b=LysN2JpyyvbC0h7EQK53XRhXaaZWsn3QoQOzeMHeNxFDv2w7eHkoq5jnm8E4rgLX2W1McsS8Mkizjt0tX7gziAO/blrnxmgC3usxkum4gyRi1nNTFeaDW0uGo11S0vKT4W5aOroephjlK4PU+GG4J+1SABy4IuWUMRbRrDcOTsqTh5BkA1LrGT0I1eZAZj1+tg85QUQwjHpP8edJx6i+v+NPKRk8aPrqsdLxyaM6QnwSwIH/lAYvPtW32vpiQlx1llYuIltRXPbc7enjuFC3W8DaoSFQkVwiUEONqODGyxn1eC0QcSa3gz8VYbvINVSf74LURPksW+U7cVqSMIxLKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQJkaxU9x0tapBtY9ZmlYA5Q1rKV56eCxYirX5E+lp8=;
 b=rN11ZB/bCwOiOdkMTVh2V9EqZq+3IIHgSSgnHTl/fVHGWv/ZrVpfX0OURgjy0bXPbu1fvnfIqx6QztiEQGWjq6mPCmRajr5hkPpEv1SUKkkRi8VTXsPCfxdtlwSBcVf9dRFJCT+KdXVBMOWEWb0CgW2SO6/fbYoSONZwFtcvAmM8osilGSnlcWw772NQpWQ+sLOQbCYOyVV07KtKjmKJWFnb0brmWiq/HyRkeaIjppLMxMiDzR99r8xfTZf36wBu1lr+EzG1cBegDiW0IpZ+V7HFrX09ZRdwgOCokxDOR8Vs6yw2b6PfyZjjbXHDfLFTnEBnmFz+aBJI0T+u+OfmGA==
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:282::22)
 by SY8P300MB0210.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:267::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Tue, 3 Dec
 2024 01:01:47 +0000
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd]) by SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd%4]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 01:01:47 +0000
References: <20241202110609.36775-1-pbonzini@redhat.com>
 <20241202110609.36775-2-pbonzini@redhat.com>
User-agent: mu4e 1.6.10; emacs 27.1
From: Junjie Mao <junjie.mao@hotmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH v2 1/2] rust: add BQL-enforcing Cell variant
Date: Tue, 03 Dec 2024 09:01:15 +0800
In-reply-to: <20241202110609.36775-2-pbonzini@redhat.com>
Message-ID: <SY0P300MB102656EAEE4C02500675056395362@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain
X-ClientProxiedBy: KL1PR01CA0126.apcprd01.prod.exchangelabs.com
 (2603:1096:820:4::18) To SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:282::22)
X-Microsoft-Original-Message-ID: <87h67linpw.fsf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB1026:EE_|SY8P300MB0210:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aa8c2c4-1ee7-4ec9-a627-08dd13360ff8
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|15080799006|7092599003|8060799006|19110799003|461199028|5072599009|3412199025|440099028;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?U5Eb/Jj1qIdoip/QgaGlcqccYmJsWtq8tmFYOeNLGXTVuCNm2dRlcYX6GW9C?=
 =?us-ascii?Q?y5uKM0UMQjCXBZ2r0Pn1hbm+sdxps2K5tKiezIFkFfUfpNgXYkjmZJKKrn10?=
 =?us-ascii?Q?XOzSm1Ii7jjTAGvGVBZvNmNVBJWK/b0MoraJzxRuz4QNG+6Fa0nH4Y3xm1WP?=
 =?us-ascii?Q?dvQ4BozVzp2PzdXxkOzjkBj69vYCZkUCvuj1sPwpAr+wCW/sRTQxrYdrAVvl?=
 =?us-ascii?Q?m7zthwG3CvCI4YCyf2E4kVkYCFoTaPVzJgT6Xz/jA0qMf8hE10bLeUkdaHiQ?=
 =?us-ascii?Q?23PDXmHQsa8NQETbn6xvAReNvjflnxW0wgc76SxYUe+pX9oHHFteOTmLwa7P?=
 =?us-ascii?Q?7v2gPGB6wqVgpAnOOGm8JzfdpK73wp2XNqmt07HfScPY/dINNrrc8NPeGL3a?=
 =?us-ascii?Q?UMWOFHuJgTdaDMKrSPrr+lsXm7Guu83qn1tjZ2k/Ty5SvkgLp186futstopA?=
 =?us-ascii?Q?Uz0J8NnWEJfm0NwRi+yYyd8RdX3Xny//Yh7vs2NDSKXbKqeMMGOLbi+/ZcWa?=
 =?us-ascii?Q?aVYDkjQ68AKEllbVtDsRrPGy8zBfxTboIMjr8eddJQpPiAoysqQU4yb2o0V+?=
 =?us-ascii?Q?i0iHdUmmB1XEoLm+xu7kS28cLc0O85pe7TBiLLCgUUWtlYujDq+IfBMztkG5?=
 =?us-ascii?Q?LB8QRQmbRgDg5QU7ci4G9nfnTGxccvlP9rWvNf8Pa0KvGhcHfLvZYL6w8xAf?=
 =?us-ascii?Q?LAlpLHDojEObzNYR4MQEMMe/M8vS9meZtFh8mLT6RQiQuJxxoBqDGrVZi1w8?=
 =?us-ascii?Q?jnR4sirE0kbvfEVBzQqAhyfs4KlTOoAivYVE8dwbEV2WH7gM2PljBIkU2JHS?=
 =?us-ascii?Q?Fos85uwVfy8/iWvRzCH0Al+t0UVxYq9r7uALmtHp9cs+W1pWvOR0e0qrtIvZ?=
 =?us-ascii?Q?yKUHIaipCfZQy2AjbDG5tkPHzLxbSySTx2SVcp4N+pY78iToW8iwzlzPYQAl?=
 =?us-ascii?Q?qUaZgJiJBdKexLK0Fihkl7JYvXtjlxIcx8t5CRiPzrPZyPSNfFlK/DFSkPfH?=
 =?us-ascii?Q?+iWRTtV0dzPZWPKkAJUlhK40qB9+ZHG+FWTh2vLobwhI4Jg=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xd9VI6Uru0utlS3RXjYr0okz55LrERax87RSDJZFGyEvnZcaIfqKweiKdydD?=
 =?us-ascii?Q?fJhIlWSa+oLI6VqCylzexjg6eba9XVJ804vTA3ye4dvUa4AskxgD2Xau97wH?=
 =?us-ascii?Q?E/T2Tl2a3Ydt/g9ZpZ6jAmEno/RkNZgEJ/te+RsgzJ75ZPlvFVL9UBMoZy+w?=
 =?us-ascii?Q?WqnWSCDH1PZ1xPpIO2UWNMEoXpt6E3dYJMzzejHIGlKiHMG3hN6/wZY0DLt1?=
 =?us-ascii?Q?Idp00dt2wwaLBi/h7FPQkssD1vnMypNzd+V9liVvZ10LfDpHWi+lyx65KFaa?=
 =?us-ascii?Q?4xsN9KDWTxRwkULm1yAvM24fF4fpHFxPb0AFYdRbwsSOhvWBtFDK42DknyvG?=
 =?us-ascii?Q?TkD16Ml/Fo76554B0LSfBbAQzW0587ibUwszd3B0wVnA5jzYugNwsQxAy/HJ?=
 =?us-ascii?Q?qpnorg5Xn+pKSdARTUoEnKGqZYd+r6/SMDa1cqUJasROmZEpU2SCR5Q5lUuS?=
 =?us-ascii?Q?nnsAlhSb9f9ZaIAmyHwFLqVe+kquAdVo9YeKscBr6i7J5ZqMpIKeqQZDJx3p?=
 =?us-ascii?Q?kEuFbsYK4mnkAfNG6Bm4SYroI7cUvZosDQyZfinbDkrTKqbM0Z54Sjp+JN5g?=
 =?us-ascii?Q?/1e+FvhkyBpVFZGsp6ySl7ZKGxrnyhKf7z1ZfAqvvCjKnXHBZ+WW9yf3byMf?=
 =?us-ascii?Q?s/gMqmcGS8pGzYM/h/PBYukwg2DasD9btsCx+qjDXX2S/CoPqyjJAOpXmW7F?=
 =?us-ascii?Q?mdI/gTZv2l/Fig/3rGXn4yt807xlkepppDtxBj/O2RssUzqMn8925pY/J9Ze?=
 =?us-ascii?Q?AGhlZMu5km+5Z0qRrUbmy8DSI25P+2nd6PsDJ7S6/pJ2drWAuQLU19y0ieWA?=
 =?us-ascii?Q?P0+EWXu791Dftd7InqeRj1u7U9K975Q6GtP1O+vz+dY5w8Yw7cL+1YcmIVX+?=
 =?us-ascii?Q?NEoYQZ9L78eIcl/GblydPD0J9J2y10EConIsaCZgdq4F8FmV6Nhz3WQGO7DC?=
 =?us-ascii?Q?qfhSB9OF+thl4/cRP2CFZ+NG3bWxvp3Kr0eQxkxzsWc6qzhWpicxOcm7Q1dE?=
 =?us-ascii?Q?qGDBneAhFXW7jWC/5z2r1yn8phGBtGlebB3JsPQiN8/9s5MkJKrfrFHhLs2k?=
 =?us-ascii?Q?bLpbaivnjUwLop5o/dzAwostQxrXMG8HgmANsnTrdEL3kb3+MbBUH4C18qTI?=
 =?us-ascii?Q?++3gwakD/avdRVbBafZYCOx9I2w15LLjUIYRn2exNULgW8LNWra0FmxkKEf8?=
 =?us-ascii?Q?8GAdxisxyzqGDuNbDWXZsGTMtk21qUEYZCgZYHlgXlFitGWLP0BaXzjxCvk?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa8c2c4-1ee7-4ec9-a627-08dd13360ff8
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 01:01:47.8555 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P300MB0210
Received-SPF: pass client-ip=2a01:111:f403:2818::801;
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

> QEMU objects usually have their pointer shared with the "outside
> world" very early in their lifetime, for example when they create their
> MemoryRegions.  Because at this point it is not valid anymore to
> create a &mut reference to the device, individual parts of the
> device struct must be made mutable in a controlled manner.
>
> QEMU's Big Lock (BQL) effectively turns multi-threaded code into
> single-threaded code while device code runs, as long as the BQL is not
> released while the device is borrowed (because C code could sneak in and
> mutate the device).  We can then introduce custom interior mutability primitives
> that are semantically similar to the standard library's (single-threaded)
> Cell and RefCell, but account for QEMU's threading model.  Accessing
> the "BqlCell" or borrowing the "BqlRefCell" requires proving that the
> BQL is held, and attempting to access without the BQL is a runtime panic,
> similar to RefCell's already-borrowed panic.
>
> With respect to naming I also considered omitting the "Bql" prefix or
> moving it to the module, e.g.  qemu_api::bql::{Cell, RefCell}.  However,
> this could easily lead to mistakes and confusion; for example rustc could
> suggest the wrong import, leading to subtle bugs.
>
> As a start introduce the an equivalent of Cell.  Almost all of the code
> was taken from Rust's standard library, while removing unstable features
> and probably-unnecessary functionality that constitute a large of the
> original code.  A lot of what's left is documentation, as well as unit
> tests in the form of doctests.  These are not yet integrated in "make
> check" but can be run with "cargo test --doc".
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Junjie Mao <junjie.mao@hotmail.com>

--
Best Regards
Junjie Mao

