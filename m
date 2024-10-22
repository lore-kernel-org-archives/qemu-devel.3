Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C85D1CDA1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 07:17:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t398q-0005p5-Ob; Tue, 22 Oct 2024 03:17:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t398o-0005ol-4V
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 03:17:18 -0400
Received: from mail-sy4aus01olkn2038.outbound.protection.outlook.com
 ([40.92.62.38] helo=AUS01-SY4-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t398l-0000tf-Is
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 03:17:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ib5bCEo/53f4hdFtIBi3VWurpy7EJB1d2QCPrEV2e5HenKhI5PYcyFEKUcHG4H+281BK0IWuQ7wkzwEmumbPvXsZYOTl0T363Y/FIlq9Alt54BND+haVre4F2ci5VZYa13qvipNupAVuFgqknxwL8BUlwNRL4sgoZOgOX7NnOP5XNvUVtZ22V8OMw3pUROVKX8nxgQSLS8l1CUfpnLYIy4EJU/9lazOLoYySvQnPo+45sFGScNI8BCa8OgxxOOR6nSqgdeS6eX0YcB3YitIYlNwNydsXbewOctvtEncMl9dFnzVL4IYISlyhqU0M6HOoO2qeWqhRYf+y4X7/g1Y4Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=smxpbrd5kLBBHmEELhyeOeQIpl5BZqOeEJfz2dhJbRo=;
 b=HqLlYFIBiOpR0AdVzQE/E9Qd+U/fx8rMtFdGf4LBwqMSII60YxG5G/7twJs4LO5ocXT+UoW8ubLLUPc5fpsnNEn0k3qikMcN26I9p41P6EV+PwGa/PDDZKIzA9JvEkyOyUe3uKCpTt9E5w6mm0dW74tRGm+zx93Tz3/h0KPGdyQfxxMQDej0ITgcUXUCADvO7Bda3OZh8IyjmThz3xV5sOXKGdPo7+sZGkuPNdfdSBAKc3TzIxpzW2lWcp3dZArKgyZQZmIRt49YIsZA6THFmniN+V7JZkVhO6zc7JC6C0tjI6NmNKEojuZ7f1tAXscmZk8JjFrKkIRodI3/QlNc5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smxpbrd5kLBBHmEELhyeOeQIpl5BZqOeEJfz2dhJbRo=;
 b=RTlL6DPwDd4geZ9MYczXmL3WVlUS7NkWaZnQzug14XaMVSMpnlaIPlse0yL5qPpiQLiOi1fUP6KGpWyAuWAxvZuLHCyQE2DNJ1aPVvDzuJQIX/wptORqoGxmg3QsmgGsnp/qMUlJy3n1Ifgmo9H8Au5Zrn+fUGfNPhp13bZsAozU4rgchpzwNp7DEC9/jZvKcI2oy8vCXKB69zoBR+csP9/zZDOg4vmyibWdg5EfRnXuSy477OHn8WMzAnF8e/YmE+gydntn0sv8B8sH//T6Q7dYXlLnZy5Zl0yMftq3woKJTL1FGFaHoGF3UzDPbzKlL+fr2FFxRAFCvgoKP35tRw==
Received: from ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:231::14)
 by SY2PPF13231F1EC.AUSP300.PROD.OUTLOOK.COM (2603:10c6:18::385) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Tue, 22 Oct
 2024 07:12:05 +0000
Received: from ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM
 ([fe80::f32e:6e2b:b854:7166]) by ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM
 ([fe80::f32e:6e2b:b854:7166%6]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 07:12:05 +0000
References: <20241021163538.136941-1-pbonzini@redhat.com>
 <20241021163538.136941-9-pbonzini@redhat.com>
 <ME0P300MB1040AEF7807BCED2866FA5F6954C2@ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM>
 <CABgObfZ95u+3CG92Zoobju=Sg19W4P2Dzb2YAGms=nwoydaknQ@mail.gmail.com>
User-agent: mu4e 1.6.10; emacs 27.1
From: Junjie Mao <junjie.mao@hotmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH v2 08/13] rust: cleanup module_init!, use it from
 #[derive(Object)]
Date: Tue, 22 Oct 2024 14:00:32 +0800
In-reply-to: <CABgObfZ95u+3CG92Zoobju=Sg19W4P2Dzb2YAGms=nwoydaknQ@mail.gmail.com>
Message-ID: <ME0P300MB1040458035970DCE9B84D6A3954C2@ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SI2PR01CA0017.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::19) To ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:220:231::14)
X-Microsoft-Original-Message-ID: <87ttd4r4qt.fsf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ME0P300MB1040:EE_|SY2PPF13231F1EC:EE_
X-MS-Office365-Filtering-Correlation-Id: d515aaa7-c0b3-4b61-6a89-08dcf268d560
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|7092599003|15080799006|8060799006|461199028|5072599009|6090799003|19110799003|56899033|1602099012|10035399004|440099028|4302099013|3412199025;
X-Microsoft-Antispam-Message-Info: dXyV6VnEFnf+BJCixlUs2iiizB/3NnawYyeeeKRO3beWU+5GcDnQpw4vy4WZY6oL9ggxn3E41d3RraNpAlF+KQ6wtHhjagsFgckVIeSG0juAL7M0E3uIYT6/sfqa8EaUHPPFcVUi1ZHeMSekmswZjEwmk+Bbu/3/XAGAy6NkXL/n7f91SrKXMRFpSFlw/Ya0F0hg+I0xIP46TaBRRBC0gVUttJDq/v5IE17oDFvl8NB7KbVxFe+ACKxG8PrDerEdWrFuegoAp3g3ZIwXirjTYox3y3kGhYRzCLtkJjIwWBuuJwK8z636s2X8mNWQe7IzL7SLjD+EIPVzbgFDq9wjNcGbd3o5myMndUrJDkvEjMnOvL5/Hl/2VIeW8t0kgn/TdcT1ZpwYnfVD3Fz1V12WxQtXUP5f9XstJv2gIEAlAUFrOvEK4BN1BEqc2X94fUMaWXuHqZ0W6vUhg+VCC0+gNhwdlvr2pqMmA+q8P5IeEjNt9znnN2X7TI789TqUrFVJJ+ijj2zDD/e75Hi9EA87Rm3cn0eK2VJm1X6BedwAXM+OOSqh3umD1dxZwhB1LAmSosjq+DHcyYCiN0CU5Bl1rRM1CTkap33sa4oMUXl7Z+18JOqsAdAsqlWGVsLmSUKaH/C/9V7IGlw5IPj6Bt3Hwi63Lg/A2nFhCZEzrfQ8oYnlwPCEr5Lul5A0jGTa2InS/Bi0btz2+zb6vELjSp9IDNxU5h85XJMdpJaD4CDFJxwujj4OrjXSXCrf9Vv9/nuKdheuUvDoVsqBwPajwMdn+tO7zEYfoArRac6tccasyK2tbPp9PAuA1n12BDhwBt0zP/bk1nCWjdfmDVq0xZDOigBHFVIoAC4uHp3dfULcApqgiVMY9nn/lQRnOPbnIHDqAGEbHoefBchjbKQ0uZjYBA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkFwK1hzMjBISHpiWlZXRklyY3FFODROVWdPdmRZSFEvazRSRzY3ckdZODVV?=
 =?utf-8?B?Wmt5bmMwcEZ2UkFYQmVxMEVCaEh4eTZoZzVVdGdHT0xyQTk1UUFiREpucWRt?=
 =?utf-8?B?UFNjb0Q4VEpvOVhzM0t0c1VPd1EwNWNSNDZPVHpMWVFZVHpNWmNBdW4xcC9h?=
 =?utf-8?B?dVQyWFZzU1VZazJSSDdjRFozd1pMK29ISEpYb29hZFpTajB4dCtaWlA2WjRV?=
 =?utf-8?B?eGZ6M0pZVlJvVHVmemxtcktsdjh6d2Q3UTc3b1ZaUlVucWlWbk1tbTZpWW12?=
 =?utf-8?B?NjR4TTdBZ2JwejBVTFhEYktxYytDMC8xdzdKb2RJQTJjY21hNUlyTkR0MS9K?=
 =?utf-8?B?djR2ZW1GVGN6LzBXcWJRdzhHZVUyNllYVVQvdldhcUlNaFNLKzVuNEE1dlBH?=
 =?utf-8?B?VVRBQXVWSXpaa2VhdlVXNmhueG93bmtnNmVFYWJhOUVWYXdHbXZZZks2SzRB?=
 =?utf-8?B?ZjQzNzEreXRXeVpvVlZxVWZDS0ZBM0xZS2pXbm1vUmkya3lSU2d6WVlQaDFl?=
 =?utf-8?B?SmhCWGE3K0tUQXBmditvUEY0d2dzRGM3ZDl5aDc1aHlnUjM4Zkt0UUREdVp1?=
 =?utf-8?B?RDJkblgxR0xQL2xtOHN6RTA5aXFoc0FaSkY2TGpNQmpQR2NOVkVoWkU4WlJt?=
 =?utf-8?B?RDN3NERJTUNjcmVnR1lGWWdmdm1tV3VMVzRyakRtSHI4aUZUR1JBZnFQbUMz?=
 =?utf-8?B?b1VubzVXNVhBcnltLzh4QkE0SlBZbDZGVGt6RHlOcUNFb1R0azlyejYzYjM0?=
 =?utf-8?B?elF6ZWovR2NoRkxrTzNnRGlBOE9DTE1mSktVek9qYVJnN2NIS3ZjZGVhVzVZ?=
 =?utf-8?B?d3FCa2ZkQm95WVc2WHRXS2tiQU9Bbi9FMmU0KzgzdXVmL1pKUVNPTXNVYVVE?=
 =?utf-8?B?d09UaE9NTG9SS08rOUMvd2xGdS9jZjB0Z0VFV1NyNmJhc3p1eDBpWldLTmZD?=
 =?utf-8?B?dGZKU0tkMGxnb0R4OE5nQVRZWGJXaDVYTzBEMjBNUlZsVkxBSk9nbTUrNlkv?=
 =?utf-8?B?SkluSG15UG9wZTNHRFFud1FqcFhuaXRSaHB4YmpuRDV4N2ZOdHZwaDhIOVJ6?=
 =?utf-8?B?aDRSVnIvKy9VNDVHeWFhV1lsUllScmRhSlhab2w4ZjVCVmpwTEFvWWR0RGRN?=
 =?utf-8?B?M1hIK1JYbVdDYmo2UXFwMjRUdFZBY3F5VUJLb3dxNFNGZ2t6UkVZQitYWklq?=
 =?utf-8?B?Yy9kMTVsdXJWTkN4c0FpaWdjOVVQeGYvUWFCODQyM3VFSWtZcmZySTl3V2tp?=
 =?utf-8?B?OE1ReGJMcWV4YzROUE5ZeFFxZlMrRTZ4cjg1eHZMNFZHRTNvTlhiUmpZUlVO?=
 =?utf-8?B?QjlIUExSUllZSlcySmxpTzFZQzhmQjVUVE43djJwWnNDRUh2cGN1dEdvRVZl?=
 =?utf-8?B?V01lOUlqd0JKQjRiNXRkQUxSbC83b3BseU0ybnJwTU9WMS9OWGlVYjIwYjgr?=
 =?utf-8?B?L0R1MmUxQ2JrTGVVbWF3SGdGVXdiQnBWWTZRMW9lMm9zQmFZdTZXS1VLdmNI?=
 =?utf-8?B?Q0tCVG5vSENVVlIvcTh0K1R3QXl2clRxRTlxcmJuZ2FEZ2IrRlR6RERYTlox?=
 =?utf-8?B?aUNFTG9MbUJmMEpNR0p5Skh3U1laY1c4TmxpSDBCUEwvbUpxVERWZThnUTBP?=
 =?utf-8?Q?RSAWKtPoy7U9/T7yGfGnpAkxT21kUyoGpjSVIgiYdmes=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d515aaa7-c0b3-4b61-6a89-08dcf268d560
X-MS-Exchange-CrossTenant-AuthSource: ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 07:12:05.2172 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY2PPF13231F1EC
Received-SPF: pass client-ip=40.92.62.38; envelope-from=junjie.mao@hotmail.com;
 helo=AUS01-SY4-obe.outbound.protection.outlook.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_BULK_SIG=0.106, RAZOR2_CF_RANGE_51_100=1.886, RAZOR2_CHECK=0.922,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> On Tue, Oct 22, 2024 at 4:12=E2=80=AFAM Junjie Mao <junjie.mao@hotmail.co=
m> wrote:
>> > +    ($type:ident =3D> $body:block) =3D> {
>> > +        const _: () =3D {
>> > +            #[used]
>> > +            #[cfg_attr(
>> > +                not(any(target_vendor =3D "apple", target_os =3D "win=
dows")),
>> > +                link_section =3D ".init_array"
>> > +            )]
>> > +            #[cfg_attr(target_vendor =3D "apple", link_section =3D "_=
_DATA,__mod_init_func")]
>> > +            #[cfg_attr(target_os =3D "windows", link_section =3D ".CR=
T$XCU")]
>> > +            pub static LOAD_MODULE: extern "C" fn() =3D {
>> > +                extern "C" fn init_fn() {
>>
>> init_fn() should be unsafe fn according to the signature of
>> register_module_init.
>
> I think it *can* be unsafe (which bindgen does by default). It's
> always okay to pass a non-unsafe function as unsafe function pointer:
>
> fn f() {
>     println!("abc");
> }
>
> fn g(pf: unsafe fn()) {
>     unsafe {
>         pf();
>     }
> }
>
> fn main() {
>     g(f);
> }
>
>> Being unsafe fn also makes sense here because it
>> is the caller, not init_fn() itself, that is responsible for the safety =
of
>> the unsafe code in the body.
>
> Isn't it the opposite? Since the caller of module_init! is responsible
> for the safety, init_fn() itself can be safe.

My understanding is that:

  1. init_fn() is called by QEMU QOM subsystem with certain timing
     (e.g., called after main()) and concurrency (e.g., all init_fn()
     are called sequentially) preconditions.

  2. The caller of module_init! is responsible for justifying the safety
     of their $body under the preconditions established in #1.

"unsafe fn" in Rust is designed to mark functions with safety
preconditions so that the compiler can raise an error if the caller
forgets that it has those preconditions to uphold [1].

Under that interpretation, a safe "fn init_fn()" reads that init_fn() is
safe to call without the preconditions mentioned in #1. That is rarely
the case to me.

Using "unsafe" to mark the responsibility of device backends in #2 looks
like repurposing the keyword. That may make more sense in this specific
context because:

  1. the callers of init_fn() are in C, so Rust compiler cannot really
     check them,

  2. the caller will by design upholds the safety preconditions
     regardless of whether a specific callback needs it or not, and

  3. without unsafe_op_in_unsafe_fn an unsafe fn hides unsafe operation
     in its body from the compiler.

If that's what we prefer, I would suggest add the considerations above
to the code as comments, so that future readers are not confused by the
usage of "unsafe" here.

[1] https://rust-lang.github.io/rfcs/2585-unsafe-block-in-unsafe-fn.html

> With unsafe_op_in_unsafe_fn it's not a big deal; but without it, an
> unsafe init_fn would hide what is safe and what is not in the argument
> of module_init!.
>
> It's also relevant in this respect that init_fn is called *after*
> main(), only ctor_fn() is called before main.
>
> Thanks,
>
> Paolo

--
Best Regards
Junjie Mao

