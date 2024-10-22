Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B151D1715D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 03:25:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t35VQ-00048P-N6; Mon, 21 Oct 2024 23:24:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t35VJ-00047k-3l
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 23:24:17 -0400
Received: from mail-me3aus01olkn2081a.outbound.protection.outlook.com
 ([2a01:111:f403:2818::81a]
 helo=AUS01-ME3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t35VF-0007YQ-4B
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 23:24:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T/lQ1fdlx2h2z08SGb9QvrfgjooSs101Kv8fgz+8qS4xfQ9z/b2bPI2ccXc8h1EJgJHLu9rfJS0Slm31NsJ22O17hg9imn8kTborlZc4QQi+QpQcNEMhoT0l8IVQQDVAjKg7YkgDe58Oa1+t0JNL+2WOrJ8s+3Y7ywy17yCNV3roCQU2rViS0Pe/xbcT6rPHPBrUpMmuZsGCgjUKXSNZ3G1iGhanwvw9/Vk83OLldsrmlrmPoA73GH4BUmJ9JgYsICL0sTL7lOuJpSQNV6q4JPgDHxifMJw88EQUv7B5rrfrmpbfVTW5f/+Gwo6WqmL+xY2Nh3lev8XgGt+uBVyJGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mQSr0+W6fS4A0H64pGuW8oXNzNOo291MpUhjrp5JjYQ=;
 b=GP3L8NpolzfIMjMYsPSO6keL2LX453VufO11EWgqdpEcEubqY2jiIdERMC77KEaNK0RsrUSVl6Jh1pz0+BtRTI2OorOIXz6HeXs8pNLrXyiP0EsO0vNhAka4JKpN39oNGUoNn/BD9CghgxMRWodilcsOFLQOoAfTmYFECRa8H/1Kc9k+5bqadkWvdsj4ECYwSUGBUiwAvgegy7mxX3cl7krc6fFCPXsAZQxiIHUAiHteEMwok591aBur0fPJFYjWfLJxs/fa2R7hp3+KosEh2HksToQlPSVsKuMwaGrCnbqI8tT4fwmVTdKXklndeoO740oZ1og3kAKy9TgcA9ApoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQSr0+W6fS4A0H64pGuW8oXNzNOo291MpUhjrp5JjYQ=;
 b=is8ChQZsnw0W7vWZmMjGWNJ6BydBZooCWIwF5jwsswZTEq/M3wZ3UvIyHr6Vi7+PPd8PFZ6EyixU7WptnJrEAb0GK8LlhZv/YJkhVPa0nKBlP2ErYh90gTy31tlHo4xbGOL4qrAT88FjVgJJVlTAH37EdF0Y+bN7SLCiNB0a2xLKJDFQ40qsp7Qv5ucERNq1Tcs++Z+kTyujf7z4PdQ22wBfDepZ/JQFnb+tkhltNwJeWygxOlZIRDEgR8F87FCeJrwCwhdId8D5zJScNXZ0ePtLOjPg5lojEr8n0gAlhJ1X1zGIPSj0tA7zpcAS6GCaJGL+AUpzR6UQPtCcOLLPtw==
Received: from ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:231::14)
 by SY0P300MB0072.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:24f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 03:24:06 +0000
Received: from ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM
 ([fe80::f32e:6e2b:b854:7166]) by ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM
 ([fe80::f32e:6e2b:b854:7166%6]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 03:24:06 +0000
References: <ZxPZ5oUDRcVroh7o@intel.com>
 <CAFEAcA8m4OeDHopFxCL3MP-cmu-PO5=2+MjNBG7YCudpKdoqDA@mail.gmail.com>
 <ZxZjqypRL7d2rMuQ@intel.com>
 <CAFEAcA-imJJQO=WAmCAHBY1MtszuPyyaD9OHWMRx88h-fjVvsw@mail.gmail.com>
 <ZxZwwe1ULIUqEdKN@intel.com>
 <CAFEAcA9E_-J3EJ+izeErnHDAwaP1LoctRaihu=5xTYrMSnqVig@mail.gmail.com>
 <ZxZ2KS6hi3Y2HdtC@intel.com>
 <CAFEAcA9V0yUCOkAWGumoOD_SMk-saS4OU5gL67gj7SRT0v4cPg@mail.gmail.com>
User-agent: mu4e 1.6.10; emacs 27.1
From: Junjie Mao <junjie.mao@hotmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, qemu-devel@nongnu.org
Subject: Re: [Question] What is the definition of =?utf-8?B?4oCccHJpdmF0?=
 =?utf-8?B?ZeKAnQ==?= fields in QOM?
Date: Tue, 22 Oct 2024 11:08:19 +0800
In-reply-to: <CAFEAcA9V0yUCOkAWGumoOD_SMk-saS4OU5gL67gj7SRT0v4cPg@mail.gmail.com>
Message-ID: <ME0P300MB10401C7825D982CE03574134954C2@ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SG2PR04CA0162.apcprd04.prod.outlook.com (2603:1096:4::24)
 To ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:231::14)
X-Microsoft-Original-Message-ID: <87y12grfar.fsf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ME0P300MB1040:EE_|SY0P300MB0072:EE_
X-MS-Office365-Filtering-Correlation-Id: c1a3aacf-fe2b-428a-5524-08dcf248fbeb
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|5072599009|8060799006|19110799003|6090799003|461199028|7092599003|15080799006|4302099013|3412199025|440099028|10035399004|1602099012;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eG44NkZmVStubXJwS0d6ci9EQ1JaaU1Vb29uVkpNWEhrazNlUlN2ZUdBQ2oz?=
 =?utf-8?B?TmZLZTQ5Z25JWVBjQ0ZoYUFNalpGaDRCRGh5RmUyL1pSWTVxWjJzdXg4ejBG?=
 =?utf-8?B?L0FubnZMZjJYWEI0OWxMWk1RNDdRWGhKdUMwY1RmQUZsOXhWS1hNcitGZGdm?=
 =?utf-8?B?SmZOaWovckxRc1BRWi9JSVJKdWlIamU3c3pGVFhRMjllbktRWW1EMU5hcGdx?=
 =?utf-8?B?YXNNQTBLRE10bmc2ZzAxRU85akdOOXdFVm1ycVVHQU5wcXpCUkloME5BUERy?=
 =?utf-8?B?VUdETUg0Z0FXYU8wWHdFSzVjOFh4Ym1hL1lmbTI4bE4reWpKdG95QVA5WDh0?=
 =?utf-8?B?Rk04WDJvRDhUMVNnRk05RlpqMXRjWFhQZW1MRlJHZFdxU2l3eXZHVE9BcHpK?=
 =?utf-8?B?blBMcnlQMmZGT1JCdFpjd0dId3pyaVFieFQxdllKaXc2SVBPMFJZN2xDdmxv?=
 =?utf-8?B?bU1WVGY5b043Kzd1T0lSdnA1Nm16cXZ1eWJmWjhtRkR1L1QrdjFsaXpERTZq?=
 =?utf-8?B?S3AvMXpqT2QvVkpJNzJLVGIyTzlFL2VvNVJDV1ZPSjV6NDFHcFkvUjBGSEZu?=
 =?utf-8?B?RU5QZ1RZMURodG1QMmFHRWc2SXUvL2ZMc3JIdy9nUlk5dGJvMjcrekdNa28v?=
 =?utf-8?B?MVYxNWs3ZzAzSnl4dXRaU0xVVnVncG5tVTg3WXY1Q0t0dUk4NndJcWlsZVY1?=
 =?utf-8?B?SHVBWXBsN1FsRHdZL0F1R1Q2THVLOXpVbk5kVDhXSFhyRFlMUDUvaC9JUE5r?=
 =?utf-8?B?djNESExWZUE3SGF6UGlldFJ3V2FJRVUxSkdUdGVCNUdVZ3ZzaXlIcHJEbDdE?=
 =?utf-8?B?a0tFc1NHUWdZWlBzYVdYMEFHZjdCTUVndnlCWk5xekN3eEUwVTBpUlYzblYy?=
 =?utf-8?B?bkxZcUxSSHZZUFNkNWhNa05nL1doeXEvMmNGcFBJdXlBTWd4WlkrOUp2OVFD?=
 =?utf-8?B?ck5RMzF6Z2lxK1pCRWhJUFczUVhsYUlQU3dVR0RYNzFBQkVLYStQb0dPai9U?=
 =?utf-8?B?MkNiRzJOcjdEeUpUckNoK0pqT01sYmhHRlFPWW8vRERXNnFYcTNRQUtSc09D?=
 =?utf-8?B?c3lEbmlPT0d4VkRWbjhyU0lRb05lcmlRY2RXRENnNlhIeUJNQjc3UzQ4U0gy?=
 =?utf-8?B?VUJIeEYxUUkxWGpqWU9LeHFHNktPa2pWM0JGM3pGYS9GU055eklvbTE5MDQ5?=
 =?utf-8?B?L3pzbG1RM0hNM3Fud240WEpUZFNFRmhCNmRnT3psWDZVRjV1TGhJcTd4Q1Y0?=
 =?utf-8?B?TmgxY1YvNjJGY2pROG8yRjZub1hxZld5d3hOaVozN2dVRWNqdz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akpXZkc1cThzZlAvamJsc2grUXpCUDBFVWNMRXg4eGhQLzNpLzhkRmNoSVgr?=
 =?utf-8?B?L3h4ZHhZVmhJNFpyY016MDdqY2hyWFZJN3R1MkpDUklsU2FWWDMybzVXTEhx?=
 =?utf-8?B?SHBtdURlOFdVV2Z0WEJuSnR6eTRTNUluV3ovNW5hYmp1WktRaE1mcnJjczZV?=
 =?utf-8?B?SXRubmk2dGUvT0FPOWxqRFFKRnRFMVNiYkgrSXBtd2FvUkRnQTMyZzBDdmlG?=
 =?utf-8?B?bmR0UG04ZWJTcWdDbVg5aWRYMTRveW5mSXdoOU5CY0JYSExaY01COS9pck1u?=
 =?utf-8?B?OEwxV0EzRmtMOXlzeTUrZ1ZOYTVWQ2wxczNEejEwckhtSEdESzRqREJ0YW1K?=
 =?utf-8?B?U1pJcW1RQWhhM3U5b1VQTWh0bUVmN3RNNHJHazh2L1BjenRHYnNjelpOaHhr?=
 =?utf-8?B?ek9SNHJRRjJyZXB3cGF5MkdpYXNPeWxvb3NEQkdMajd0aE9RTTdjdmkxVGRl?=
 =?utf-8?B?MC96a1o0S1JBMCtra2dQeFIyTEdJWWIxK2VQaXJHSUc0WnFzRWFEVEFPMnY0?=
 =?utf-8?B?WlRwR2hHTEhEdU4zODBRcGpzMFBwZlhld05aaWFFenltVVF1YnNhVkg2bUlL?=
 =?utf-8?B?aTg2RGx2WExQczJjazRjYTdmK0dWYTNrbHcyQ21XNHV5ZTh6UDBVaWs1YUYv?=
 =?utf-8?B?Nm5nVE1vNHJ5SDk1MzBaazRNUkp5aXloUSsrVXRuekdGdjY3WXNQK042bkN4?=
 =?utf-8?B?KzlZQ2g3L3dhWEtHUjB4T2ZzclJxK29rR3dJT2RrWkVMemFIcW83VnZ4ekVL?=
 =?utf-8?B?YzVBL3VMcXEzV2pwTjZ5T2xvTGEyNVNQMUdZV2RRcjl4dWhXUTV5Nk5ldFFH?=
 =?utf-8?B?MmJpeVpYTnk3SDdubjRQRGI1NHdqM3d1cEhzSnRHWXpDM3RLMS9UdW1vT1Z2?=
 =?utf-8?B?elByNE5tQjdGRENFOEl5b2ZBVmRmN2ZSK2VrQ1BZY0thMkFEdkM2VEtrQUNj?=
 =?utf-8?B?dzkxdndJT24zbE5OUmZ0ZzBGeVE5OVJJS0pEY0ZJYlV3ZS9zbk8vcTBnYTNF?=
 =?utf-8?B?NHNaUzcxRkM2SStqc2tYbWFlOWhCNW5OU1Z5VzdrUU40VENRUVVYUFUzaExU?=
 =?utf-8?B?L0RvSnlTREJDZ0FjUnB3Ty9sZnd3TWU2U0JnM2RmVEkxeU13R1hiTGwzL3Vm?=
 =?utf-8?B?V1dvZTJJL0l5UHNlTm5CUkxGU0R4OHF6SEtpMXN2eW5rZDJXaHNPM2U3TDJR?=
 =?utf-8?B?NXFaRFNJdGNqaklTenU3WllPMHBwdTQyY1dPU1U5Zm00bEpSS1pEbTE0Y1Rp?=
 =?utf-8?B?aE5oRHdFR0plRlF2WmVtdnFtVVU5M2VFM3dBNXYxV1BNa3lvbThCbHVIcU5E?=
 =?utf-8?B?UlNGbmp1c3oyMEp5OXFtNllJYWFoSCtwc05DM0xUSThZVXFJNnlxd2ZYV2lQ?=
 =?utf-8?B?aVA5UWQydXlnQ00vWkNZQlBhT0czbkJLQUJEOEU0eE5uK2hGOWFrQTN4ZmxK?=
 =?utf-8?B?K0tMcEY5enRCcVRBSkVtMnhqUnFwYXVrM0JCVlREU1lBVjh6TkVIeGp0Ykxt?=
 =?utf-8?B?YnNKTTYwTmhZQkp3TVc0ZzNkR1MwallWUmVXVmRFMWdJMWo2ZFZicVduSmpX?=
 =?utf-8?B?eFhvUEU5dTRET1dpeThMNFh1ekM2Ni85anZjOG5LVHRkY211Y2d1VURCRDQx?=
 =?utf-8?Q?WRshgVgVZ0CB7IdupkY+Mx2BG23/U6+UfuKwi07xMJxs=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a3aacf-fe2b-428a-5524-08dcf248fbeb
X-MS-Exchange-CrossTenant-AuthSource: ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 03:24:06.0516 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY0P300MB0072
Received-SPF: pass client-ip=2a01:111:f403:2818::81a;
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


Peter Maydell <peter.maydell@linaro.org> writes:

> On Mon, 21 Oct 2024 at 16:25, Zhao Liu <zhao1.liu@intel.com> wrote:
>> My initial confusion stemmed from seeing the private comment and
>> noticing that there are many direct accesses to parent_obj/parent_class
>> in QEMU (which I could list in my reply to Daniel). Now I understand
>> that these examples are only valid within the class/object
>> implementation or in QOM code.
>>
>> For instance, an example in KVM is a misuse:
>>
>> accel/kvm/kvm-all.c:4285:                        cpu->parent_obj.canonic=
al_path,
>> accel/kvm/kvm-all.c:4377:            if (!apply_str_list_filter(cpu->par=
ent_obj.canonical_path, targets)) {
>>
>>
>> At the same time, I=E2=80=99ve been thinking that the current C implemen=
tation
>> seems to have no way to prevent such misuse.
>
> Mmm. We rely on code review to catch major misuses (and let
> some minor misuses slide because we don't care enough to put
> in the effort to provide a proper API to access the information
> or because we don't want the performance overhead of a QOM cast).
>
> In a previous iteration of QEMU's design the device's state
> struct was purely private to the implementation source file,
> and code that used the device always did so via a pointer.
> But at some point we decided we wanted to allow users to
> embed the device struct inside their own device struct, which
> needs them to have access to the struct definition (though
> strictly they only need to know the size and alignment
> requirements of it).
>
> I did a decade ago write a proof-of-concept for marking
> fields in the C struct as "private" such that you could get
> a compile error for touching them:
> https://lists.gnu.org/archive/html/qemu-devel/2014-05/msg01846.html
> which (mis?)uses GCC's __attribute__((deprecated("reason")))
> to arrange that touching the struct field from outside the
> implementation is a compile error. But we never took up the idea.
>
>> So for Rust's class/state,
>> should parent_class/parent_obj also be defined as private (for example,
>> by removing the pub keyword from PL011State in rust/hw/char/pl011/src/
>> device.rs)?
>>
>> However, through our discussion, I realized that in QOM, "private" does
>> not only refer to parent_obj/parent_class, but all fields belong to
>> this category. If everything is strictly defined as private in Rust, it
>> seems impractical=E2=80=A6
>
> For Rust we get to make a fresh start on these things. If
> we do mark all these fields not public, what would break?
>

The only thing that breaks today is std::mem::offset_of! which respects
field visibility. Defining a Property const structure requires getting
the field offset outside of the state context.

To me properties are still private to the device state and must be
accessed via their getters & setters. A solution to that is to keep
properties private but make their offsets public in our alternative to
offset_of!.

--
Best Regards
Junjie Mao

> I do think that some of these fields really are internal
> implementation details -- only the PL011 UART itself
> should be directly accessing PL011State::read_fifo, for example.
>
> thanks
> -- PMM

