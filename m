Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 096DAD3C53F
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 03:17:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1dTe-0001li-1a; Thu, 17 Oct 2024 23:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t1dTb-0001l8-Mr
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 23:16:31 -0400
Received: from mail-sy4aus01olkn20824.outbound.protection.outlook.com
 ([2a01:111:f403:2819::824]
 helo=AUS01-SY4-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t1dTZ-00027m-L8
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 23:16:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SeWurpaNV2sGyLExviZV2SS+CK14KP2PAIqXBPIXR6z9i2y0ldB+CSV9D4DN2GguX6V2+sUZcenSeQo03x485XwrgKK/O+3OZGmM3ljlGotqMJrL3j3TKX06oyYZMi5bN0/obpLpDipBOpb4+DKdNy4w41C+en+Xe2kmkSqkQGhfuj8nOGpnzQae9d10fvHMKMqI6Ui0t9k6twO7+MSnfQeHNCghFEcHA8ceH85NtIHqGih22w4WzpHnJ10YgemJMtYJcNStt5W9M8a6PcR4gGM8AhHEcwECtVygTkgviBKgnBojaqx3b5eqA7+mcC4fKxy9dJdgMKtt5XVCkQgV5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K43+vNRgbm8C5vFldEQfkKvXBU1sRReq86swRDtA770=;
 b=vCSbfgZxLBEQg6QxkbKaaPs+Uy9ai8AmSXiQiKUpavzLunYNP4dq75J5jVAWNsgSZ62DmxbWJvqna4IKe9yu1JBlHxyhLaOYyqiZymasH4ha5GKmAb/ysWb9OW5wHae4vy+qBBYdacepXJaxcZCx3l2vr86UMz4e4ymRB2qcTFuswvlv9FyluXj5vwuUvfniOmmGo1EvwI7+vWEAZ4n7Ai+Yv9F/7eviPwFVtoPInPLUOuE1SrOmk/Q8u8maepgswIv/h62aPF+Cq/4K6uvhAWubsJBebQTFDm8udU3bOXL7GVaZfUvwiMsQFKedBXwXvtk//nKxYcttc3DDK6+MUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K43+vNRgbm8C5vFldEQfkKvXBU1sRReq86swRDtA770=;
 b=OYK0y9A2UAPVuwWj8BemuR3Dn2YIBEzrpaZci9ebyCoTr/IKytgz/Tz5acA0kc/Gl4SqJqKXkcK7q3GPyW1n7WX+aNLgD7oBtQYsHiZ9iqEIdAmEEAIa6oJni4SdloyByHb0yI9q3m6wdGXEoLG7QEthKKH2IEE2TuK+per4jNxk7oejfOfRwvrzDfKIVhy1MDVoo75aGKmXn6gioo398qf4rsWts7BgW7Yq7tUwVEIJQ8Lb6N7mZUNhSGo+wkf6onenQPgkWgHSq34Ak56/E9Z1eU46vOAMYgR0eafk6o1tKLFzjp0DTCt/J5oVb6rjhyMEqvVdPbfR41SG/zTTvQ==
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:282::22)
 by SY8P300MB0477.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:29a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23; Fri, 18 Oct
 2024 03:16:22 +0000
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd]) by SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd%2]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 03:16:22 +0000
References: <20241015131735.518771-1-pbonzini@redhat.com>
 <20241015131735.518771-11-pbonzini@redhat.com>
 <SY0P300MB10266B5144972CDF92AF065795472@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
 <CABgObfaX+KhYx3Wo8jGG_hLh_c6t=nYEPZt3FXKQMyOqivVDgA@mail.gmail.com>
User-agent: mu4e 1.6.10; emacs 27.1
From: Junjie Mao <junjie.mao@hotmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 10/16] rust: introduce alternative implementation of
 offset_of!
Date: Fri, 18 Oct 2024 11:01:21 +0800
In-reply-to: <CABgObfaX+KhYx3Wo8jGG_hLh_c6t=nYEPZt3FXKQMyOqivVDgA@mail.gmail.com>
Message-ID: <SY0P300MB1026EAB6DCBDDCD602E7A67C95402@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SG2PR02CA0069.apcprd02.prod.outlook.com
 (2603:1096:4:54::33) To SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:282::22)
X-Microsoft-Original-Message-ID: <87froum77n.fsf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB1026:EE_|SY8P300MB0477:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a9ebbe2-cea3-4285-5971-08dcef233dc5
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|19110799003|5072599009|6090799003|461199028|8060799006|7092599003|15080799006|3412199025|440099028|10035399004;
X-Microsoft-Antispam-Message-Info: 0NRbFzaGagItGIfLn9EEXj8EZah5QqHzmsDCJtc0xhvLho4p88F5qevO1lGx1MvZt/RECMzc9V/9N+w+1DhVkycpr+tfbYkM1cJA/C1z+L+3v557NDCddj+CfVxe9U0+oSPYpgoaSzY1L15+sV22z/5O1p7J6gkn90aMYYd77smB3FCnWZhZoQqRR1556Joc7f7oJFCnfwK6SAzDxfLZUCb4hT/7qOMLMi2J+s5GDP3xE8dzXhqPxOZ4b7UR908FAaHDbwhX0Zw9sf/DiYnaNAJaDrGgLbuu7CQaYmtIVLSY/xeSqrLwjd0Duh/dFtZnJFD8innxig6AOR2P2C1/4tVblZgG3dJ9FjTLBdk+4Xh0bh7HG+bAFYNiP1w6z+8RiHFlnS8L7GbBeCJA5J04lIkvqlktYsHJEwhJZltSM0WXfwOW99EtKCJH3tdC3vYbqbFdZ7wMcyDS+L8dPRK9eujHiVfAHR8XPDbNRZ7qDIeizjOEHDpGzVCSIfc31qjs1GHTyM4ov8QBdUrh4Nwl7ZfQ3pB8V0wRKG3EfTAYfg8T5+iJ7apQr8Dgk7jDbAcn07NdxVT8NIP93QQ6HfXDC5F3dZ+hKAs/VY473DVGYx/IZ6SwvpVN+ThWnwab0+f/mUPdHcFGdUA0lkIqznH5PbOM4L1CiIVB7XgAeGV/brEdiTJ5XQXnkBKTn2N1PMr2wLySgB9nz/PUY3MApr848628082lneBFgJMlpDbKhJWYPWjuipBQK3/hBf6s9VgR1K5N7CkfbQDDoKqUXX5ZA0ddQ/R7UgKlXyKwh0wCrR7x3JrtXWaSJEOX3lLfbycNDOCAlOJF+O1sjsSyeDb1ZQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDVuZXRCMDNUL1gvemlkU0tIYkh1aGdrSzhaMExmWnlRVGVNVmJqU0Q3VFcy?=
 =?utf-8?B?cUtWZlBuTzJWMGVFY3RsY0srR3lBcndlL3ljK01SMHVPUXgxUC9QZ2pnaHQ5?=
 =?utf-8?B?Qm0zR1lVa1NmRW1Qa0FQRWlDWTF4SlF5cGhyR2lYM1BYeGV0OEVDUEVHVUZj?=
 =?utf-8?B?MnZhWDB6dTVvVUt0WVRKaFpyZEFUMXpLaUxyVkpjKy9qY0xtdmI0TFRoSThZ?=
 =?utf-8?B?MlEyYWZ4aHFFd2dhZnJDTEgwWTZ0Qi9idWZzQ3d4c1BoSCtjdDFNeWxHdm16?=
 =?utf-8?B?RFZoQWkvRFNIMExrcE5kRjZaazlxRXo1NUMxcVpVRDFOSE5hVVZuV1NyRUdY?=
 =?utf-8?B?dFRhY0dRYi9ZRnRtci81YnFobXRHWVI5bDBtTDdXbHJ0NDdRRWR5VXVkRERv?=
 =?utf-8?B?Zzg1Qys1ZFpKSEEyM0FLVnJ6aUswYjVaMWl5TlV2WkN0MWhWYm9DUEZ5WXF2?=
 =?utf-8?B?WDdhZjVWNktrNGNjTTFNUTd5dk9YbEtZaWREUDQ4NEM1cDhsZGFkSG9hdnNU?=
 =?utf-8?B?K3BoWjNXbGo2UU9PekpqQUZiSE05WHROTzdjVjRUbkZXbS8rNWdQWFpuMDhP?=
 =?utf-8?B?T0JXek9PS1h4YVkxRlIrV3FpalZteGQ1dHh0RVBsemZBV3ZqQWVWODRKM0hz?=
 =?utf-8?B?RENvV003eEJXMUZKSy9CZGF1b3h3OHM4MFVZU1E1R3NwNkM3d1JyVnJXdHdU?=
 =?utf-8?B?alVhaXlmSERHV0ErM0xPSE83eER0M3dob3o5UUxVNFhkeEd6QlcrN3RqYTJG?=
 =?utf-8?B?WHI2TDAxT1VQMXR1QWE2QjVrR3V4aTNFdG8wck1IaWsrNnRSQ3RTa1llbDRH?=
 =?utf-8?B?U0JiNmtjUTVKRWNRYjYxQjRIUzRYT2FUZGJEN1VFZ1JOMFgrRm5NRzR3Kzcr?=
 =?utf-8?B?QjVtem5nbWdHY21PdTRqRXVRTGdyWXlQRDJhUWtBOUJ6WWhtRVNpOHZNVyt4?=
 =?utf-8?B?OFJJcUdTWExHMExCd1A4SCt2NjhBZmFzb0tSZWw3dzVzaVNGNHk5TWFKTXpB?=
 =?utf-8?B?L1F5V0FibmpWWmtHTkRGZVdwNVY1NkVjUFowNWw5TEwwR0VKSDRKWXYvcTlV?=
 =?utf-8?B?RHlpaHdLUmdvVHAwTlNnSURwL1JWZk02TjF4cjVZR3ZDandhREJGL0FwT3lD?=
 =?utf-8?B?NGhqK1JNb3EyRjFjUzVkS3V0alEvZm5TNzZaYXpuUmVXMTNKU3FoVS9uOEkw?=
 =?utf-8?B?WWI5VDd3bFRzVU0rZG4wdDd6MzcrbmZVTzFwd2dFZmFzTlMvNDg0LzhZT3FF?=
 =?utf-8?B?ZS9XMGdqTlNmV3dIZ01kbUxlcTJLZEREcmR5QWdyN1QwSGxIMmRFOG5BWlJJ?=
 =?utf-8?B?a2pwV3VWZkh4RTBaQ1RqbzB1Y3NFczR2c1ZpNVhCNWx5VjJuSG5xKzI4eG9N?=
 =?utf-8?B?aGxsTE1kTFBqZS9ES2FLL0tKS3pqYmFSeXdaQTJhYWhDWmtyRFovOEpOWmRJ?=
 =?utf-8?B?dWdoOXhpVVczSjU1STBDZTRLUG1nSi9LUWRRNm9pVlJia0pKeENncjZlRTVJ?=
 =?utf-8?B?UEppbWJLR1pCNVFYWS94QVdXZ2ZtLzZYejdwbGZqaDJXcDZrT0ZnRG5yNDB6?=
 =?utf-8?B?WGVXQlJzbGwyUTFzOUZFTDRBdUR0OUs5WG4wV3pHdndWeW80ZElJbXU3SURS?=
 =?utf-8?Q?1SbqTt6IVcXsbvIE9C7/pmdpqSXhaKzNNT+TRfWBHc2c=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a9ebbe2-cea3-4285-5971-08dcef233dc5
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 03:16:22.2750 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P300MB0477
Received-SPF: pass client-ip=2a01:111:f403:2819::824;
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

> On Thu, Oct 17, 2024 at 7:35=E2=80=AFAM Junjie Mao <junjie.mao@hotmail.co=
m> wrote:
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>> > offset_of! was stabilized in Rust 1.77.0.  Use an alternative implemen=
ation
>> > that was found on the Rust forums, and whose author agreed to license =
as
>> > MIT for use in QEMU.
>> >
>> > The alternative allows only one level of field access, but apart
>> > from this can be used just by replacing core::mem::offset_of! with
>> > qemu_api::offset_of!.
>>
>> How about a macro like this (which essentially comes from memoffset
>> crate [1])? It has the same use as core::mem::offset_of! (except the
>> same single-level limitation) and does not need wrapping structures with
>> with_offsets!.
>
> Unfortunately offset_from is not available in const context, and
> offset_of! is needed to fill in the Property and VMStateDescription
> arrays.
>
> That said, I noticed now that declare_properties! does not declare the
> resulting array as const, so that would be possible. But if
> declare_properties could use a non-mut static, that would be better.

Agree.

Then how about converting with_offsets! to a derive attribute
(e.g. #[derive(offsets)])? The current approach introduces one more
level of indentation. When we later upgrade the minimal supported
version of Rust and switch to std::mem::offset_of!, we'll need a large
diff to adjust the indentation which may be annoying to rebase upon. An
attribute seems easier to manage.

I can help draft the macro early next week if you think that is valuable.

Junjie Mao

>
> Paolo
>
>> macro_rules! offset_of {
>>     ($parent:ty, $field:tt) =3D> {{
>>         let uninit =3D std::mem::MaybeUninit::<$parent>::uninit();
>>         let base =3D uninit.as_ptr();
>>         // SAFETY:
>>         //
>>         // MaybeUninit<$parent> has the same size and alignment as $pare=
nt, so
>>         // projection to $field is in bound.
>>         //
>>         // addr_of! does not create intermediate references to the unini=
tialized
>>         // memory, thus no UB is involved.
>>         let field =3D unsafe { std::ptr::addr_of!((*base).$field) };
>>         // SAFETY:
>>         //
>>         // Both base and field point to the MaybeUninit<$parent> and are=
 casted
>>         // to u8 for calculating their distance.
>>         unsafe { field.cast::<u8>().offset_from(base.cast::<u8>()) as us=
ize }
>>     }};
>> }
>>
>> [1] https://docs.rs/memoffset/latest/memoffset/

