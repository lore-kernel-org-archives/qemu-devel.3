Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75C98D3E1A8
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 07:25:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2mmo-0001ZZ-FW; Mon, 21 Oct 2024 03:25:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t2mmb-0001Vs-3B
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 03:24:53 -0400
Received: from mail-sy4aus01olkn20810.outbound.protection.outlook.com
 ([2a01:111:f403:2819::810]
 helo=AUS01-SY4-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t2mmZ-0005cj-Cu
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 03:24:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lS0O36l6r9/xtlIdWIvlQM+8FHjBfk5qZrq0YUTi4XrC3u2mlKTxO0oXi/5/qAvgzls5S89e9bg2H+dVWjnZpoyBj3WNmn7TrEPjjKbdo0uUY7KgniSFDp1p7a5LxtPoDwxilpkyU32bxudLCjui7+rLMyciRwoXBTQgdlkfCtDMZxA+wR2fdAULweVBiU0sjmsLCQ7A5bfbqIIyukClWRIABM4d67wWfd50z8jN7Qo/NxKG1rn07a2A7DD/tP0IVSnL69ByTIXV4ETAut1sp3u1Yldso42/9GNWD0yipmoNuLz8UrVjIwBNxAtG7lJg7qz9OthMlGQ30c2EwjVaNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bqET1D9zWiqEc1awjViuXWWDe4Pe8UGNrpnCIV+CAb8=;
 b=nMlLiCE6OyX5UwMx43ULGkkYNm6ldJn9UAkrRXfibTuo/YvSvfbOcLuH8PfSL528xyfYMVLETIdV2WxxNm/YmhL8+QrOy4bUB9gmbpAlo4R8lOR6iCiMEa4sylLAdUNC2qZd+RModeWar2bdah4rmV5qL2R5iJ94gwtB1POTIUi41bQlDawKHZXFLw59zM2cFcldhYKmihcHasV2EQISEfI6JprrKHLYB1z6QpzwduPERZyqkQ68llA9ScTmdNNoIsU25VTzxfky2SKGIkwTDrVhJuOID45WmksZzQNV4TcMuZEPQ9k0RglP8WCFVznoiVl4FsM/OGN9wgnn6h9t1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqET1D9zWiqEc1awjViuXWWDe4Pe8UGNrpnCIV+CAb8=;
 b=Nsqmwbnm/zy/6T+H9L4XHLcoGV7vkqMS5Vh1dLEQkrgQO5GxpE7o65m5QkTs3fwzOAA5HLhM7XqFwnvfPfvaHj66fpcfrmmDg5MWwHW4Tz9nMjpnlouQvO9T+jAwiU7wX2MFI22X96lfat068I5GOY1M14II4OACAYsFaLzg8gI5CX41cKgpRel0FNLBvIePuDeRlZiov4R/VPQqEPGHZRoyY3EANIike1dPUQ5Fey/jkQpyXpibZ0CPc1KItLLQ5bPNxluUi3CrxI5d6X6Lhoa3aVMix/evPjh1amP+OqgA0uPKTlu/8nouP6AuEAv1jAry83/1JZV/r873TRezWQ==
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:282::22)
 by ME0P300MB1357.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:242::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 07:24:44 +0000
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd]) by SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd%2]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 07:24:44 +0000
References: <SY0P300MB10265E25557DB71EE426525795432@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
 <5db62c58-b6e3-4f83-9954-ff2bcb1108bc@redhat.com>
User-agent: mu4e 1.6.10; emacs 27.1
From: Junjie Mao <junjie.mao@hotmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH] rust: introduce alternative implementation of offset_of!
Date: Mon, 21 Oct 2024 14:46:52 +0800
In-reply-to: <5db62c58-b6e3-4f83-9954-ff2bcb1108bc@redhat.com>
Message-ID: <SY0P300MB10261816C21DC5FCC6D39F6295432@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain
X-ClientProxiedBy: KL1PR0401CA0020.apcprd04.prod.outlook.com
 (2603:1096:820:e::7) To SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:282::22)
X-Microsoft-Original-Message-ID: <87bjzdude6.fsf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB1026:EE_|ME0P300MB1357:EE_
X-MS-Office365-Filtering-Correlation-Id: 89a7e6ef-ff87-43ba-1331-08dcf1a16f2d
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|15080799006|461199028|7092599003|5072599009|19110799003|8060799006|1602099012|10035399004|440099028|4302099013|3412199025;
X-Microsoft-Antispam-Message-Info: UB/rTbbVwLInJpGqJMOnDSwZziNKocA7hDv/YvNThnLaO8Ghf4/9QAuXkZwHuouZQ4icfEmsRrFxrvw0wpYmDzfIcdJU2uHaJpthE+mc/GuW5RTYZ/+3sBc6speVSsdKnO1wfBWaNaZ32OlkzjZF6rIBD2cGvhCGdyvXX678XZnks+0Di/j8rcpotBRwn2nJJKZ8PsbNmpkhrMsngq0ETwG2ig1ufthK0dO1NZUuY9zGIJcHhrzU39sk2ZYoh5j9r91BDvftdF0WtIYMC6VtW5EPxwTcZWkOz5IVrmwF9fNpaAsbMBl2BFhxH8/qsjAh85YdeLgzdPRA25xqVhhGJK5fINUXVzfeijviH0lPpt5N61FNTYUAKi+3Gz/hzCRSvYhvHXl/HlMmz3/pVt+5js2Cmj01IlfDkQ2Z+TumZbNEBwE+A57KRQSAscaoLvlBNEkJSgtufJXR9k920w/733LGhaVUSQ34nY2GtXD0eJy6iCBqYyHrgx5Ogz9gtHtNCfPyGtbjI7zBkVqzDhRnJwJ4byOpFD4EajSeJc0LpI69DoEmvervCRCMBE5WI6eMriFpmDqmBTh9IeGn1pCftU8avFmjC68h+ZzFTYNVvPzSzNHHFM/BjXBTYhB6Vuil9FGfUvQNktJ8h2vBCU+jF0ZMc0FuyBdSOnbF7iuFO/wMAkba7FgLtsMADDrO/IQGvPhXKZ0CewFlyzwB0aO6c8bAuyVG/YuxzmWDuuome61Z3PsUVsnU8Kw3PsyXppMOrTbCsDP0JZYAswiW9C+Fm5unzyV/ZM+tQHKpJSjr2IcUU7OxYJY7yYaPs9q27JW6KRWNzuYfznNxQzsBDBR+KZIyduxKUS6gSizjKaHtvEh+qKVuXslSXjauH+G5VrfTLPwfZRWd5nzK4KwqWgt5MNDCEom05unwAHEGdkwPDPY=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8KHUvDl6D7qIiAXk0Hvv9OpLkVDo1e/g7Jj/l7cLo9eIw114H3oxHvnGOd/4?=
 =?us-ascii?Q?biEKx68JWJyMmZ02QVoxD3TFTh6LmYMQkpTTQ02HLpyks39M9dTd/rOT/vUx?=
 =?us-ascii?Q?kv+EuJVzNA2DQZ420m6gpLXdUNctfk2MPFoF/XFuNS5gtbHxYajBF6pmYMFL?=
 =?us-ascii?Q?o/t8wPWJAyIe09Z2Qf25TNBg6Ok3odCHLVDNIGbIjfm3KK/I8W1HuLah5bLj?=
 =?us-ascii?Q?uSb2j5frl4xr95m0jRasEqF3u01EnC9+6DM0Y7he23d9Apury1UzNfRW8y0l?=
 =?us-ascii?Q?xfi5NERp4bCIBj5bqDr1o6vTY+R5vEL30lF56MrB6fCQKtkBhrf0nGGdP/7b?=
 =?us-ascii?Q?0FnH1sVMAWnS7NxQS0P3UMnyhCzuKc+iAE6K4Qb4c1NKcawlo3sIV+dAXC75?=
 =?us-ascii?Q?/xpOouYyUVt3lj3Lp7PbY/7wKHzDB2Ka4lVPczg19xqavGI1Y1CDO9P8my9L?=
 =?us-ascii?Q?lQQE9+w6cEGtIIYfEDm3LjibOK2rKsl0T1JmpzSU6zB2Jan5jbaN5bKZ7oRz?=
 =?us-ascii?Q?kHxRwecVG2G/UzXTpJXessRD3n4csCoC2kkwEXA9cm6AY0RlHfIXzzn6UsFn?=
 =?us-ascii?Q?Tgrsi/6BS2msvCuOvaHT98hm6xOP0eMhv5NetqXlG0vGWRA34A9jDOeBWLKP?=
 =?us-ascii?Q?U2ZVUnWsi1DSaT3jEv1psGfP8onSp3XgKa/7fjrsFDDLpHwUfioYc2l1bYRN?=
 =?us-ascii?Q?nfEd+Q1D6FhxthgcqrOddduRvLOOOprAZAnl43mHxF5s93MzK/mVO732cKsM?=
 =?us-ascii?Q?M9d5LOVbv9tujej0rN6VEUybrt53w/iIsBAc0RFKCCe7H3hsr1rlCC0bedz4?=
 =?us-ascii?Q?wi735aijq4KlB05YPjWql0UTlKbujpOyQ/XystECdmSKQw4n8bImvas+M0XI?=
 =?us-ascii?Q?wTR09SE8R4sx5JGumei1NbRAL2YddwsInfn/aaMV4tUm1+wtlLOesmKUYi6g?=
 =?us-ascii?Q?8alVN0uHtGuD7GPATMwZe1gzDw0TZraxb8AGeivDeVO8Sdb/PtH90omTxPRL?=
 =?us-ascii?Q?jjESB/Y31wFLMmaHdBrtgLBkf68EAhL5ZF1WIuqbl0Ej2Xg2w0vIomokZ0y1?=
 =?us-ascii?Q?je/EmQKUyRKLx/bsgjOiez7Zt8EutPswxxLX7bL+bQhLPLFj7DlGgZrOBVF5?=
 =?us-ascii?Q?xF4443BPHJ6bDDv+t2m2QIaAvqIh/RSOhuvEO7ttOOgZ034jNKKdSjWjm8Ay?=
 =?us-ascii?Q?hstJV5TFSH4rUTBOy9ZtaVgRrIruD9UGv1/UVgEw7c+wQRO+BbeMsGKrwX8?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 89a7e6ef-ff87-43ba-1331-08dcf1a16f2d
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 07:24:43.9519 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME0P300MB1357
Received-SPF: pass client-ip=2a01:111:f403:2819::810;
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

> On 10/21/24 07:40, Junjie Mao wrote:
>> offset_of! was stabilized in Rust 1.77.0. Use an alternative implemenation
>> that was found on the Rust forums, and whose author agreed to license as
>> MIT for use in QEMU.
>> The alternative allows only one level of field access, but apart from this
>> can be used just by replacing core::mem::offset_of! with
>> qemu_api::offset_of!.
>> Using offset_of! prior Rust 1.77.0 requires the structure to have the
>> derive(qemu_api_macros::Offsets) attribute.
>> Apply as a replacement of 10/16 of Paolo's RFC series [1].
>> Also remove subprojects/syn-2.0.66 if there is an existing build. An
>> additional
>> feature cfg is added to packagefiles/syn-2-rs/meson.build, which requires meson
>> to re-checkout the subproject.
>> [1]
>> https://lore.kernel.org/qemu-devel/20241015131735.518771-1-pbonzini@redhat.com
>> Co-authored-by: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Junjie Mao <junjie.mao@hotmail.com>
>
> Thanks.  I still prefer to keep the procedural macro code minimal, and have the
> code generation in a separate macro, but this is a nice start!
>

I'm not sure if I get your point right.

My understanding is that preferring minimizing proc macros is because
they generate a big, arbitrary block of code that is hard to read and
debug directly (which requires cargo expand the whole crate). That is
thus more error-prone and makes maintenance harder.

As for having "the code generation in a separate macro", are you
referring to `macro_rules!`?

>> +fn is_c_repr(input: &DeriveInput) -> Result<(), proc_macro2::TokenStream> {
>> +    let expected = parse_quote! { #[repr(C)] };
>> +
>> +    for attr in &input.attrs {
>> +        if attr == &expected {
>> +            return Ok(());
>> +        }
>> +    }
>> +
>> +    Err(quote! { "Can only generate offsets for structs with a C representation." })
>> +}
>
> Probably can use any() here.
>

Sure.

>> +/// A derive macro that generate field offsets for using `offset_of!` in
>> +/// versions of Rust prior to 1.77
>> +#[proc_macro_derive(Offsets)]
>> +pub fn derive_offsets(input: TokenStream) -> TokenStream {
>> +    let input = parse_macro_input!(input as DeriveInput);
>> +
>> +    let expanded = match derive_offsets_or_error(input) {
>> +        Ok(ts) => ts,
>> +        Err(msg) => quote! { compile_error!(#msg); },
>
> It should use quote_spanned! here.

Sure. Will use quote_spanned! here and make reported errors being a
tuple of error msg and span to use.

>
> Paolo

--
Best Regards
Junjie Mao

