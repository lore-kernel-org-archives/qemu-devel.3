Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB172D1CA0E
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 02:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t897T-0002D9-Ta; Mon, 04 Nov 2024 21:16:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t897S-0002Bl-AW
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 21:16:34 -0500
Received: from mail-me3aus01olkn2066.outbound.protection.outlook.com
 ([40.92.63.66] helo=AUS01-ME3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t897Q-0001HM-La
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 21:16:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yS2AfFYJKCxjWqIwC6B+CrxHQ4mgJqKZbsGc3m/DdSzyB4sWKTZe5/zk1qfmVv7/X4/YUhgWtAFApjQ1DamhrinNXA2UnfbWDm5f8Q7pA0g4aYqfkkkprQFhYYXvdli9boXzVX50ygNOLs27MrN2Q7PFPLVG3n71evGdnXCoQKwXZZQHRhLg+2G8AyAYBEaUDWmwpNCiU7QVjBTvkC53dxG5bmK1PR1FlW3zkYI2h0D4kYNg4wShSU3YnqVzuxhI9VNRXycDbDDa60rWSmIUNJX1gkhQ0PfnnrByI4vzYxBjgiwx1MlGFm4v7mQR3D18UNcIOCOB75QM7GZLAg6Lew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZcIJjVhtX3JACp9/VcBgHRyGlg0ORRVAe6dCXtYjx1I=;
 b=Ez/MhR41lUL/0jhyoV8tjDD6qTJ4xOwxUTBPHHPrA4r80E9gmOpJwy5bQmaCdbvbCia4b9LwyeqBFFa+lMrodFeHU7fU7dLH7bM19XJopn+0lB0YvL4oTsjvN5ZMND8kOdZwPPHhuWLGk7AwcRxrRWTJ9G9QPky8xQBaPv/xBhkvdAsLdRJIc+heBxjmnbOiUHuMeqPOQKN3OXmUnbEJhGGPNLaoKgw+B0QbBkNo6VlaSxJqosY/7KF1pyTltgaOeB5aUaGF3+3MM4eag8rn8F3OukDLqjSZMjAQOITbJFzrKmQTtC36n/Koz4caU6IvVnJljL91/i04cMYYDNyHSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZcIJjVhtX3JACp9/VcBgHRyGlg0ORRVAe6dCXtYjx1I=;
 b=uDZ6WT09sl/nuCxsoQGfgMiqnmgiAl9zqMB1BkWKgtVNC0kjIyD37u57cT/DsREt1tENOtD/CoFFybBf1VzkYOWi7AWCd5nM0/rjpU9r1tgT4BjVp4rTAoPTnpqpaOINgY3DdseAviGVyLGQzoL+qkRF7ZT7G3HYPhaqC2m92bNjuLXJfwLuYzDx3/UJt5MC8lLayV1PM/KtX/sEwRtBhgQpfDNHXprEbIFsGbRXajn7Gu+XgIqC7MKrD+rOSGZUbY79ZsCOw5ZN1y2nE3hZqbyWrJjmr1a5kUCww7Bl0bgKnfBNHZx6kteSIvYHhNkPoe5v2hwNH2sWHmjyKBcdKQ==
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:282::22)
 by SY0P300MB0673.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 02:11:13 +0000
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd]) by SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd%2]) with mapi id 15.20.8114.031; Tue, 5 Nov 2024
 02:11:13 +0000
References: <20241025160209.194307-1-pbonzini@redhat.com>
 <20241025160209.194307-16-pbonzini@redhat.com>
 <SY0P300MB1026D525F3022164941671B895502@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
 <6f20610a-a9ab-48fc-83ae-1c0de791bd8d@redhat.com>
User-agent: mu4e 1.6.10; emacs 27.1
From: Junjie Mao <junjie.mao@hotmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, manos.pitsidianakis@linaro.org,
 zhao1.liu@intel.com, berrange@redhat.com
Subject: Re: [PATCH 15/23] rust: introduce alternative implementation of
 offset_of!
Date: Tue, 05 Nov 2024 10:07:48 +0800
In-reply-to: <6f20610a-a9ab-48fc-83ae-1c0de791bd8d@redhat.com>
Message-ID: <SY0P300MB102635C63F850E89687D0A5E95522@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0002.apcprd04.prod.outlook.com
 (2603:1096:4:197::17) To SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:282::22)
X-Microsoft-Original-Message-ID: <87cyjatop9.fsf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB1026:EE_|SY0P300MB0673:EE_
X-MS-Office365-Filtering-Correlation-Id: 534a1df1-36b8-44e5-e53e-08dcfd3f1f55
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|461199028|19110799003|5072599009|15080799006|7092599003|8060799006|3412199025|440099028;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Lf0qhVt0OTMhxz9ZTeKBxLspc8HVEihzt/IK3l61vMH/x/V9kc7paBBkg2xh?=
 =?us-ascii?Q?SMeye/oLApE1eLEF1PBWZ6xQCUqP7waE/M3jbMWwYEUt0LdBqE4MFw3Kz6ZH?=
 =?us-ascii?Q?CZR9lQ/eF62O4jy5YfmuVGXXraRK99ZBe/45yznwjI3TAWAf+aFb5bSx8Oid?=
 =?us-ascii?Q?iffkgbAH4e02jidwOOibH9Oo2CIqcSTit9BAd83BOTQwvT296Mqkm5zMitSC?=
 =?us-ascii?Q?bqOi1F2QQOrIA1Vg9qUdNckIbc67+iAquz7aHyLqimBOvAsCiDPEtnbarjGg?=
 =?us-ascii?Q?Xcz/6SQCgLfQWtvteHWSprPFYfjeNMgiw8y2avLYkPl/8QWkUrzZxuI2/klb?=
 =?us-ascii?Q?GdToSLT3Kp/6sIQ/+G5LT43Xt8UvBauFI45h8cvfAPyjEt4Rr4qH+TFrgyp9?=
 =?us-ascii?Q?9MeCeKDj0Q7EvPCMzbiJb6/jcKOtXbdRrwKFWRfnrOScZ5zmgk4OaFFtp6Sh?=
 =?us-ascii?Q?ULbFd48AjN5Ly2rOhrk2ACJ6T+IQ8owqc4KM5yJgWbxalqnIu0GG8BmmXWXp?=
 =?us-ascii?Q?X4hJG6WdcNY720JCd2LnE75HL92EfgaFtIhlfW9cXi8pbLbvwR6/KGSrN5Wf?=
 =?us-ascii?Q?/0KTHrqvNLK8vpEWg4B2XrDdznhGa+srHXFQDdU3s+HAA99oDPE93pNbkHfV?=
 =?us-ascii?Q?YbvQvZZZmrilYEw6aZ2krYN5YOBqQjHmGVvS/iP54Qj6wj60K/0UGqeoyqmZ?=
 =?us-ascii?Q?CAAz6idUtwY8qNYGhcbLLFp01UPEgRqKigqTLMTy3Pqk0V5v7fEtODnNfa1Q?=
 =?us-ascii?Q?ao+o3ZsoHZ5Q7BwRrblPA8I73zYwQh0UBVHqDnOJubAmp3SrMXr4ZK4sfMlH?=
 =?us-ascii?Q?wDcgbp5hJy0I9gTFVJh+2inSe3skZLQ5D36CQB9oSaP+umjA4aU3HWbKNado?=
 =?us-ascii?Q?ZBtYUqrHuPkcFV/fd9OjT3IaTpEKcoUpJrNem37QFBbVhXsjKUHS6RIGw2ix?=
 =?us-ascii?Q?Zrvz3efnp5uE3hR0+ulg7h1s4oELquAf8LsSk5xIeJdoec6Gge9xXMtrVY7d?=
 =?us-ascii?Q?I2eJECvCZTJR+TQTh9PZxZ6BwDXBoMDPkSeANozppRIIoiY=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N0imwlTO+BGxC7utx6KnFQ8Ll/BO13PvCemkoYQ3Wrob+IoHk6OSck3D4TZd?=
 =?us-ascii?Q?fTPGRJ4NZBDIZVIDWiWhLolmGD6nI3IkicMeuIyeLCgB6YNJbXt0NpyqsUCV?=
 =?us-ascii?Q?uivD5JZD0PYJNYNjLavpxmjWfoSAUiTgHDzpt64HgU7BzFFM/bD/Dqw6BA/N?=
 =?us-ascii?Q?IBSKFLozmSUKqwqgpbc2IFKVHC3QplDbfThfQUmdhO8wCPRfvAZqRo5h6aaa?=
 =?us-ascii?Q?rfbSwFBD8B6HzUnbpInUHmQ9sDfDpe2fRCNbCciacj3u/6YiWZfvR+YuQKzp?=
 =?us-ascii?Q?qrI+NlwN/YIXq9LWssWie9yBT9n7Ah9BqMlDrIUJ+9B1zqPmdbjTqpKkcdMe?=
 =?us-ascii?Q?0ZjooLoOIiBcGk4RLHW2iuo29P6D0KiRTb9vlpEMskRCLuo+atdjTTnEKH1o?=
 =?us-ascii?Q?XwGxgoA1Fq63ijCvc0c/XysUnvO9DKnNyNQrPvarrs0cyviWqUxkIvMmN9vk?=
 =?us-ascii?Q?5KjmUMxkTjuAGjnnofV94Wscd34M1RcAwokwJol1a5grvbxHrz5h+lI3E0fF?=
 =?us-ascii?Q?lhrAUA8h0a1XdW9iCuP+7nEk7xPNiH9xF4jXwZOS2TvQarlTpH9YOctp2QdT?=
 =?us-ascii?Q?vTF3bZZAvZOhR66gDRle976qVuTDgif42jkVxRQoVl9VJ+w6w3Oy2TYCnBe0?=
 =?us-ascii?Q?0xDecU26zIRcOq+XirUHhjM4yCbzcsoLbkxvYSDlUY0qwwuDMK8sczkcvCX7?=
 =?us-ascii?Q?GwihMDbQF+OqqM8xDckwoNKNq/Si1Ac0BxiHb/sh+a4MZz6ydE8BFjeqQOXn?=
 =?us-ascii?Q?4D5wEJVqDSGpRitxG7zFgVvLjkCkCi7kEzap0CwRmr6E5oPFURw8ieZ9u5nV?=
 =?us-ascii?Q?nmWCnYatxvuZjk3MXaFk6K/yJ7uwplR+z2z9Ul3Ha7eE4y/eIK4SbMmt2TQZ?=
 =?us-ascii?Q?j53B17i1DhqFp76ejSIinxWhmp6GSrnlx4zZsa7RaiKXTTk+hhnct2nw2RDG?=
 =?us-ascii?Q?KYW8Me59CJBSxLoUNtUWs1kBXuF/EHMPmNTMO6NoUQVNyLGNXzh0sXki+IAl?=
 =?us-ascii?Q?SlpsoISQ7jd2Kb6gKfUyCx9LkcJwMaLkL5qxS4qVdsNmfFUfTLv6/+MpcJup?=
 =?us-ascii?Q?ALuWZavZ5VIjA5KTAUW1I6Ub5R4MNFqLB4oSaEl9EeWxgzG9231cNHrrgceZ?=
 =?us-ascii?Q?8bWlry5+XMeU1Eg92s3v1Y6DYCYp1p4FyaiPpMOLxBWwZJOTIKf87+t3on32?=
 =?us-ascii?Q?oP/4P1Upkbl88lmnulQef1Xm4OVXopH646eKnjKggK0zSV9RbPeGVT1CGTk?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 534a1df1-36b8-44e5-e53e-08dcfd3f1f55
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 02:11:13.3805 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY0P300MB0673
Received-SPF: pass client-ip=40.92.63.66; envelope-from=junjie.mao@hotmail.com;
 helo=AUS01-ME3-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

> On 11/3/24 10:54, Junjie Mao wrote:
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>>
>>> diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-api-macros/src/lib.rs
>>> index a4bc5d01ee8..c2ea22101e4 100644
>>> --- a/rust/qemu-api-macros/src/lib.rs
>>> +++ b/rust/qemu-api-macros/src/lib.rs
>>> @@ -3,8 +3,34 @@
>>>   // SPDX-License-Identifier: GPL-2.0-or-later
>>>
>>>   use proc_macro::TokenStream;
>>> -use quote::quote;
>>> -use syn::{parse_macro_input, DeriveInput};
>>> +use proc_macro2::Span;
>>> +use quote::{quote, quote_spanned};
>>> +use syn::{
>>> +    parse_macro_input, parse_quote, punctuated::Punctuated, token::Comma, Data, DeriveInput, Field,
>>> +    Fields, Ident, Type, Visibility,
>>> +};
>>> +
>>> +struct CompileError(String, Span);
>>> +
>>> +impl From<CompileError> for proc_macro2::TokenStream {
>>> +    fn from(err: CompileError) -> Self {
>>> +        let CompileError(msg, span) = err;
>>> +        quote_spanned! { span => compile_error!(#msg); }
>> The documentation [2] says "there should be no space before the =>
>> token" and that is by intention to tell that `span` is "evaluated in the
>> context of proc macro" while those after the arm "in the generated
>> code". Should we follow that convention (even though the extra white
>> space does not impact building)?
>
> Ah, forgot to reply about this.  Personally I think it's clear enough with the
> space around both sides of "=>", but if there's agreement on removing the space
> I don't oppose it.
>
> Paolo

I don't have any preference, either. I think we can keep it as is and
make sure future calls to quote_spanned! have consistent style. Thanks.

--
Best Regards
Junjie Mao

