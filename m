Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C6BD2E01C
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 07:22:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3VgH-0000zO-J1; Wed, 23 Oct 2024 03:21:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t3VgE-0000z4-Mf
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 03:21:19 -0400
Received: from mail-me3aus01olkn2084.outbound.protection.outlook.com
 ([40.92.63.84] helo=AUS01-ME3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t3VgC-0006Jg-Hi
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 03:21:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cNOd+Nc4DK8mHQ94zjnEF5RnWIxXypg1S/KTXMg+KlFpNKNCwf5REJDAZm3fO9xTsof7sWI9upazHbAITWMsohTbVwwZlpFOtIoIha2D8QLUTfWUDiYgTQVFcuP9Zfx0JiOXDoSWm710tEjys47NPq3sZr1HFLxAHRnRP7e27EJf6lGlEMTKlTcrRLQfbXpICLTPDfHcEPxoKSdQtuXAYHLfQo/i51RhVGd1qHAbi8XXq7bwDE+wF2wBZEtSBFNTqvBmSpYvGQ5XHvOlbrktEO8Om4KPEPq/uxxUY5uRC58SprFR++bdbFnoKxVf1c7MZDyk+XlFP4MJ5OIIAKtDhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=btMWivqWyv0CYMKml7HVIgJid+mSv3imW3NeJt1u1zo=;
 b=bPgl5PvYbnvdnXB/hFJeK8xw4zw8+Zi7p26a6zZI4oNbZV69cO8vHq1x2MtL1edQ4EIklb9bbucWDvA3i6frwmlNdADsvyfSd2x17KSnfLkiZ4LovwuvpicEE4F25cl+f+gwSg95zIoM89AMYk056BLThFNa6c8BGPRHk6EHIi0XO+XX9/JWpJe243+64+x4KgHb0XmvyuWbWZ0+utyLXUU8ZdT13J7owiszLhys5hXBIQXIwdX0BmqhbuS1VVau1MMEIsahIlYplnOH6Brszl6+bzfq0b2WXEGByu1RO9SVFOLUVq46pEXewyG4yx1bZyXreNObMic+8qCZTj3x6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btMWivqWyv0CYMKml7HVIgJid+mSv3imW3NeJt1u1zo=;
 b=DVx7aKb10DRamUxKEvg75gSF58q7UvJMSNtyd3NC/BeX/qBY7qgtfcyDVQVDu+F6h/wHUnTnT35c6EKvKiU7elQyMqF/5cZSKkc19iSTLouLVF1DtqWdbJk8v1tJSHRvbTA1QZHU8yfbk4S1fxhch/u1Lq7D10hjQ9pU0PPzsQWt9IGsTQc5B2AkRtPdvnoIjXY/iXDN22qIFu7dti+cn+4TMCdJn9NuaHBKr4WcQoTTFhpeDGs/VlamC+XwpQ6wgKYMHBlXcDjuaGx71y66LzCxZaGQ2rCDd0aEG4QiEJp+KFWhfJ2UX2QorMz6Xse3U5n5WT5mRKl6fQVEpGZ/Rg==
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:282::22)
 by SY0P300MB0756.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Wed, 23 Oct
 2024 07:16:08 +0000
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd]) by SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd%2]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 07:16:07 +0000
References: <20241021163538.136941-1-pbonzini@redhat.com>
 <20241021163538.136941-9-pbonzini@redhat.com>
 <ME0P300MB1040AEF7807BCED2866FA5F6954C2@ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM>
 <CABgObfZ95u+3CG92Zoobju=Sg19W4P2Dzb2YAGms=nwoydaknQ@mail.gmail.com>
 <ME0P300MB1040458035970DCE9B84D6A3954C2@ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM>
 <ZxgL4l-itd8GjhnB@redhat.com>
User-agent: mu4e 1.6.10; emacs 27.1
From: Junjie Mao <junjie.mao@hotmail.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Manos
 Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH v2 08/13] rust: cleanup module_init!, use it from
 #[derive(Object)]
Date: Wed, 23 Oct 2024 14:46:19 +0800
In-reply-to: <ZxgL4l-itd8GjhnB@redhat.com>
Message-ID: <SY0P300MB102659897DCA90F8E25B695E954D2@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SI2PR01CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::21) To SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:282::22)
X-Microsoft-Original-Message-ID: <878quf1e8l.fsf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB1026:EE_|SY0P300MB0756:EE_
X-MS-Office365-Filtering-Correlation-Id: c440e641-692f-4ac6-eb58-08dcf3329040
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|7092599003|15080799006|461199028|5072599009|19110799003|6090799003|8060799006|1602099012|10035399004|440099028|3412199025|4302099013;
X-Microsoft-Antispam-Message-Info: RLbg86zxNuNECYj2LJZTxUmBVcYfYM52D0bKZEw1sWqcxCkls2zF6f0iCRE3m+7R87V40yaBGl/xTuxKLE6ELoyOIE2XNxBBTtpbfVfZFw4L5gDCSo/KXsftILM0HkEigCdMUMOWiK/bAiK5HMszXoYchNSuOgxAyoUrifU7OAanijLSypq6oZtq8uaJfswt+3fdQA14YWwqS1Cxt1Ec0lpA7Bcm1HERoHveXXPPDwa5i3qMV8tpE8bRj3t6kTMLOfsixrGfs4UXmZe33Wn8QxO5NfTZtrGNfgXlkzhYTF9gfztlsZ9N/E6D1rCCl/C2WhAAbpPGxSHNWyqThqOUJCk2sRWjUKIqIzRiiIauVqa8gscuW5n27FB8azbz7IYvmEz0AU9WwSNW8U3qRYHSawu+GIzQNQKKYv9pEGQgZOZJOn1CWaE8Lh09N0iS9ghxyCh09qfrTuvL6txEfZ3j33F0c4ixusbT1WarbHDCwlWe/PKqHntc7lTWbKEBbXPn89rjG59NVcDU4xpoo3nVdGiJa2s1SecnwFNboSsE1XqM05RqK+XZk0iJDu1gGBPylAu9WoHkWkPvKr/bSQmvfErtpUOewF9xYYBnzYgU+AgzWXFcBQtGo9FIQNKBGdpOvaoBRGSirqgqfbCBHJpQXB301sPsUPzTRPOqhWtA9QYOnUnwh1Cps6pY4HeDthpv5gXTZCJF99FWQSuIjjCYG9Y7seBJxNhRYy5TJ1T1mGQpUY/cTQ2cjoNhOaHTlzxHSOfM9KJ6hvFL4QBs4/XbIZ3NTLGtMC3qPAJxVth4QN4FdQ1nZwCD1ytAsXA/mrMdt6MS0YwW4h1rlTSq7Vdk05AYUCBtE3LCx/+oUedVRShP7aSwDz/WDCEwoFqs7p5tS+ZFM1vxoPmgbWfqYXA6iA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUlHdE5acnU1b3FrYjdZWGJsV1FMTHJmWk96Uk9heUJYQkhrRnd2b1FZaU1I?=
 =?utf-8?B?OXY2MU45akRwdkVhOTdVODF5d3QxQUJLZ2NDVFRZaTJqOExFaG5TWXU1dUFx?=
 =?utf-8?B?ZHZFd29TbkRqZ0NCczlvaHlmTXg2VmdQZm01V2NDVUJGV2JuYUdUS0g4eCt6?=
 =?utf-8?B?ZFRXbEF5ZzltRDVrNCtFYlM0bGZsUFNqd3Rld1dkdmxuYWNOMENUTEgybGQ5?=
 =?utf-8?B?eFJ5K3UyZmw0OWsxZDRGZ0F5ZytScGlLYWNsZy9peU41M2NReUxrUUsvOUlP?=
 =?utf-8?B?aUFiTmt2RzlsQWtmL2dTSlpBd0trbitETGRrdWhDdDZWUWh4MXloYjg1RXFw?=
 =?utf-8?B?emZTVityOEJPREJ2RUdVZ0NkVHJla0NpWXpiSGtKejBySHZaU2ZrMlIvMTM2?=
 =?utf-8?B?Q2tzWkpnR1lvK2ZpQ0NTSE9SaEdQa0hlaFFtNzVqYVlia1pESnZYa01Ub1ZJ?=
 =?utf-8?B?RFgyNDA3a2VFZGluVlhoQ0lNUitOK25oNUNHZks0TjQwWkJCeXBJRENlM3ln?=
 =?utf-8?B?VzJheVUreTdENVM0bnVDZFphUjM0QmpwNlJwZENmU3l0UENQUThWNXpQdjZi?=
 =?utf-8?B?bWNZRDMyU0J6UVdFZ21FeVlQeHRNS0E2SzQxSTBQZElmdkJ3WHNyemdXY0o4?=
 =?utf-8?B?d1NYNTRKR2Vaa05iVDFxekZWc3c3WVdGTDczRU92a2FpRDRpNzRteWsybmpF?=
 =?utf-8?B?UWN3eU9RK0E1ajI3a3hQL29TL0VsZVhIVzk3SFBOQzJRejEyWHVtR001d0ZT?=
 =?utf-8?B?YzRyMlRwUzJnOWNQaXB6d054WmlUU1N1dGh2aFh4N2o0TU8wU1B0ZFZNc3p0?=
 =?utf-8?B?WWRDR3VCbi80eFlNczdYVloyb3ZDUHdTT1BDQTFqSlZiNFVvbUROSE9wUkxQ?=
 =?utf-8?B?RXBOQURqcjNpOWV2bHRsSE5QVTc4SDBUOGszcWFYd1ZsZXQwaVhvRS9qVlpU?=
 =?utf-8?B?dVliUmJUL1p2VFVaN3BxK2RMcWJ4dDVFNmhuWFFZWWZ0TTNiTjBheWo0eE9V?=
 =?utf-8?B?WU9tWEhOSHcrczduc2ZVSEQ3MVZxbEFFYm1aWE95QmJRUHh6WkdoMThIa0Vq?=
 =?utf-8?B?eHBtTUdjWG9tYjB0ZEx6UXE0dzc4WXFkdE5uajg2L3BBRGxiOWdUNDgraVBm?=
 =?utf-8?B?cjFaSGg5SXFWZmNYWVF2N3owT1BqS1RHNGVkUUQ0R2xHekhoN0RMS3hVNW91?=
 =?utf-8?B?Y3B3NmppdURnQk9GaXFjR2dDWThHMG00UEtTK2tjS3Z4N3AvNkRCSW1ON3Zv?=
 =?utf-8?B?NmpMcnlWRkY5ZUo3ZkFRQVpsc2NWcXBhRFRycVk1WE1FWHI1OUlubC8vdlo0?=
 =?utf-8?B?VVhkaHRacHdCZ0JjUnNQYVVwbklYMU5vTlVUTDh6aWxQRVRiNURlbG5ldmgy?=
 =?utf-8?B?SUlqYzAyT1lXS1JYVGdVdFdqWml0UFpiWFJ4LzVnYnUzT2dKVUVLN2FRaXNo?=
 =?utf-8?B?MWRxWmUzeEhTRmFhVlpwQ2NKN1VxYi9KOXVNU0JHTmJMMTVxdHl4SEdLbHQ3?=
 =?utf-8?B?azgwVmZsdm5kUVFDTDBtUHZ6T3Y0cEc1ZFdnMm1WZkZPSWc2TXo4bkRJcmti?=
 =?utf-8?B?ZW85SVJmaGhBSUVLMmFCQXVOQlM5ejRjMDhYaHFFdXo3VGdSTTdEd0tLSHVI?=
 =?utf-8?Q?uQ/X/jThjF+2jYSaA7zY650fAQn1oRyHz+0e2ADo/VfU=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c440e641-692f-4ac6-eb58-08dcf3329040
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 07:16:07.6856 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY0P300MB0756
Received-SPF: pass client-ip=40.92.63.84; envelope-from=junjie.mao@hotmail.com;
 helo=AUS01-ME3-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


Kevin Wolf <kwolf@redhat.com> writes:

> Am 22.10.2024 um 08:00 hat Junjie Mao geschrieben:
>>
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>>
>> > On Tue, Oct 22, 2024 at 4:12=E2=80=AFAM Junjie Mao <junjie.mao@hotmail=
.com> wrote:
>> >> > +    ($type:ident =3D> $body:block) =3D> {
>> >> > +        const _: () =3D {
>> >> > +            #[used]
>> >> > +            #[cfg_attr(
>> >> > +                not(any(target_vendor =3D "apple", target_os =3D "=
windows")),
>> >> > +                link_section =3D ".init_array"
>> >> > +            )]
>> >> > +            #[cfg_attr(target_vendor =3D "apple", link_section =3D=
 "__DATA,__mod_init_func")]
>> >> > +            #[cfg_attr(target_os =3D "windows", link_section =3D "=
.CRT$XCU")]
>> >> > +            pub static LOAD_MODULE: extern "C" fn() =3D {
>> >> > +                extern "C" fn init_fn() {
>> >>
>> >> init_fn() should be unsafe fn according to the signature of
>> >> register_module_init.
>> >
>> > I think it *can* be unsafe (which bindgen does by default). It's
>> > always okay to pass a non-unsafe function as unsafe function pointer:
>> >
>> > fn f() {
>> >     println!("abc");
>> > }
>> >
>> > fn g(pf: unsafe fn()) {
>> >     unsafe {
>> >         pf();
>> >     }
>> > }
>> >
>> > fn main() {
>> >     g(f);
>> > }
>> >
>> >> Being unsafe fn also makes sense here because it
>> >> is the caller, not init_fn() itself, that is responsible for the safe=
ty of
>> >> the unsafe code in the body.
>> >
>> > Isn't it the opposite? Since the caller of module_init! is responsible
>> > for the safety, init_fn() itself can be safe.
>>
>> My understanding is that:
>>
>>   1. init_fn() is called by QEMU QOM subsystem with certain timing
>>      (e.g., called after main()) and concurrency (e.g., all init_fn()
>>      are called sequentially) preconditions.
>
> Though these conditions are not a matter of safety, but of correctness.
>

The "no concurrency" condition is related to Rust safety. Deep in
type_register_static(), which is commonly used in such init_fn(), there
is a modification to mutable statics in type_table_get():

    static GHashTable *type_table_get(void)
    {
        static GHashTable *type_table;

        if (type_table =3D=3D NULL) {
            type_table =3D g_hash_table_new(g_str_hash, g_str_equal);
        }

        return type_table;
    }

It'll cause data race when multiple init_fn() are concurrently called,
and data races has UB.

Also, glib hashtables are not automatically thread-safe [1]:

    ... individual data structure instances are not automatically locked
    for performance reasons. For example, you must coordinate accesses
    to the same GHashTable from multiple threads.

[1] https://docs.gtk.org/glib/threads.html

I don't have evidence yet for the relationship between timing condition
and Rust safety, though.

>>   2. The caller of module_init! is responsible for justifying the safety
>>      of their $body under the preconditions established in #1.
>>
>> "unsafe fn" in Rust is designed to mark functions with safety
>> preconditions so that the compiler can raise an error if the caller
>> forgets that it has those preconditions to uphold [1].
>
> I don't think we expect to have preconditions here that are required for
> safety (in the sense with which the term is used in Rust).
>
> But safe code is not automatically correct.
>
> If you added "unsafe" for every function that requires some
> preconditions to be met so that it functions correctly (instead of only
> so that it doesn't have undefined behaviour on the language level), then
> you would annotate almost every function as "unsafe".
>
> I think the rule of thumb for marking a function unsafe is when you have
> unsafe code inside of it whose safety (not correctness!) depends on a
> condition that the caller must reason about because you can't guarantee
> it in the function itself.

I fully agree with your rules for "unsafe fn" uses.

--
Best Regards
Junjie Mao

>
> This macro should probably only be used with code that can guarantee
> the safety of its unsafe blocks in itself. The C side of constructors
> can't make many guarantees anyway, and there is nobody who would
> reason about them.
>
> Kevin

