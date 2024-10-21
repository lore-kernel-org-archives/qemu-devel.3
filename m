Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0BD4D3C92D
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 11:56:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2r0r-0005rM-4s; Mon, 21 Oct 2024 07:55:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t2r0p-0005rB-Lt
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 07:55:52 -0400
Received: from mail-sy4aus01olkn20801.outbound.protection.outlook.com
 ([2a01:111:f403:2819::801]
 helo=AUS01-SY4-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t2r0o-0003bP-66
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 07:55:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hmUDzaY9+Z1oYCnvxgGh5BxWnZH5ZcruBNyWTp0zt649G3Q9FAKVF23i48gmJ9iWJaS957z8KLvy9VVET2hrFw/fhQzCDRKcHDUHQFBsL3HhMz5lDTJMLbvFy4/QTwDW8a6eCxjjoG409WZ7MP8oC0nPaHxuZKEEzJY4suJ/soDPjqytWthXjuFj9iwhVzjouPMzHOnYvggbrwNdEyfRwhIh33xIUxdH5ErmsM79Tc3YQYH5ZOGF2L5ckaGplVd/pQ0kGKZAWq8XBS5/JScCcCJ0Q+9NyTq6V/utxdw3OTqEh4Qe2SE5DnbZuCTux1I4ThmHHxpN5MDIfVlhV0oz5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHoQewuuhgOSvojO/CbCrGkFCQFqwzkSQzWcuRvmGQM=;
 b=pNM58qJ8EBcp50x+iIplwXr8MGdSCB2C82RvR3WtBwlD1ORdu4B9z3GARRPAJV3cT4H+w9TgUd9NdrrqyeKjAtqoMP8r4rb/rv72JQtC0nrjZ6XxgxtPUGr1ysnjzlRDA8eJj93pqXgGbudBArobYjYatNYFjB3LP3U85OJsNC8tTCc8PzRD6Va2P9ty9YY+b1bOG/G2epggPMr9wqQ8LNVXpHm4ZeRLBk6a7iHolZffyXQYg6+98UBd/8MMIh54rleHuoLbC37OM1lohHIEcvxFfpf/bFCfH/NZakpelFkHvjY90vRK9XgYSqwLZaaBvYUQY2EUxvLMpL/WqRU1gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHoQewuuhgOSvojO/CbCrGkFCQFqwzkSQzWcuRvmGQM=;
 b=rnsxzkyerqqajhOasNvUQ6nExhUiro5WJgzE6FpF3qoOzMXvTIwHc8TeEfrSdtVkwEEPITkbr0ZHrnyQ36QFAdpoXO/XRiF2++uofqemt35xg7rbravQuDRuLskv4a7Mt5eS70Tnt5sVgDqehEiJGJDkfqWg7f3OcU6M3bfyyt9tM/1zwzS+8j7xSV6V38+V3dnWCVwMnz+zFC9DZvyCAcotjkhj4aDQJ/iebssS6c2zQ3VU28BAnAvii4QK0TZQ60/JQzqSFABe4c4Q6pkP3cv0F4q1Xc9Mb1IiWZVXFeySpKDmSbrKmqNH1PKsvU6mcL1Znah1QbDT1H1K3g+CHw==
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:282::22)
 by ME0P300MB0554.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Mon, 21 Oct
 2024 11:55:40 +0000
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd]) by SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd%2]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 11:55:39 +0000
References: <20241018144306.954716-1-pbonzini@redhat.com>
 <20241018144306.954716-9-pbonzini@redhat.com>
 <SY0P300MB10265D6A0FEDF3DE07F2220395432@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
 <CABgObfbUWFf_Mr+PR5_TZ0A6n29sZwdJ3umJFdTHgPHiVZrU4Q@mail.gmail.com>
User-agent: mu4e 1.6.10; emacs 27.1
From: Junjie Mao <junjie.mao@hotmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH 08/13] rust: build integration test for the qemu_api crate
Date: Mon, 21 Oct 2024 19:51:04 +0800
In-reply-to: <CABgObfbUWFf_Mr+PR5_TZ0A6n29sZwdJ3umJFdTHgPHiVZrU4Q@mail.gmail.com>
Message-ID: <SY0P300MB10265C8AF6439FEACFBDD17295432@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SGXP274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::17)
 To SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:282::22)
X-Microsoft-Original-Message-ID: <87zfmxr7pp.fsf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB1026:EE_|ME0P300MB0554:EE_
X-MS-Office365-Filtering-Correlation-Id: 67435a27-9696-4d66-3639-08dcf1c7487e
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|5072599009|6090799003|19110799003|461199028|8060799006|15080799006|7092599003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info: RMvlpZSexDU19FsAuxXWl3Ie9XnecCen8+mCxzMtLBsI3KEGxbyGvwGzSfZp7Z8H9huCaZ+pwOyiDSADyY6HybByp26huV2+RU/xNo4EsfcftK7WfNeFvrlBEaEAo3doy0uDX0JmL3DP63uhdvd6H3d87VSGAP0jeRh5FebU6iLqZWP1ZQT2qgv1zMmh3PHB8YZ6bb8dDXB4i0S7pMNEIu/KDhjHmRgkvtjC9fTNmS7DnPIBwuIu9bJ/IvDQuf2WpD8NTdruXqJ7kfttbnRUizsybvl5GgygaLrfs6Ox1ODWYMGJsZu8PBcmRHMPe6L0tiNtRJKP3Mj+YuRhj6KZjULxV+Ber1c9z3y6vKa32T4pN6hd2eTmsZroR2N9QAJWr108NkLdVZsGhn334kb5yp/y5CFumfIccFW3zAt2ehJl1Udx88CzkahrmRcIR50KQBOZaXO3OLlYVoBQUvgEqtmNusG5KfeNHOJV9USaXK6B2mlZobydGuC9/0RvX7KT16+LZE/7YDs5gdou+4GnyD2uWDVLXtAoEJL8AswStAl6Ps6200I4A+AZ04DhdYwVoXvppJ31pdRSgcwnaQ1e/rg9Lq/MLLqtLShexYsW75YeuO0sLt02nB2cDIMEbUshxGtlrmLA5gI+2AcGLQaohS48VOwFMd/pManoEoEgnImxl6xLotzTs+f6E0x9gnf/I7jXdh88NHgRB5/Z8vafcwr7pgK0mWJYjr2rUhl3YczWS5VdFbMVmwiVQBH20tsVBt3Hovhjbs4EWCwB9BObpA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dU5oYitlaXhUSGkzVVJsZUpYaGt6RmdsVTJldlJHWjR1VHpzWGE2Z1dvK3NJ?=
 =?utf-8?B?ZHJyTmUySWIwRG1jc3lqMEdmN1pjV0JQVHJLT1NmRFdEZWtTOHNUUXhFR1ph?=
 =?utf-8?B?QXJ5UmpKWUxxZDBpcUM2TTJ6L1dqWENjZlY1azdndFJWUWttUHJjWjZpcDFm?=
 =?utf-8?B?cEkzeHFNc0k3LzFUK0F5Z05RcnAxYTF6WEFydVNEVGJ4aGJ4eE9SNFd6MzFw?=
 =?utf-8?B?T2s4WWp2Zk1GYVprRTM2MkZYNDNrMGJZSVNiUlRFem1lQzNiWUo2aGQwVCs0?=
 =?utf-8?B?M0RDRHJjeVRaclN5dzRHUXVMNnFXMUhUMG5XNFl1QW9VaEZzcldKSjVLVnRO?=
 =?utf-8?B?RS8xWjBUSFcwSjZBTGp0eE9EekRlY1VUZmdWUUlOaGI5dWVXdHFYZXRjMzRB?=
 =?utf-8?B?Z2U4M0NLUUU5VTQwd2RURlJSWkp3WHBoY0lGeWN0aHhESWNUNmJCdzUyUnpG?=
 =?utf-8?B?QVFDRlQzMUdOdGJ0QU9DTUNobUdEREd2eWZaZEtjTk5LdUNwNVBJUDZKZ0Fu?=
 =?utf-8?B?U2RHeFA0WmVNbEJ6clNVK0dXdWIyUnFBUk1hMWpadldzSDdjeDM4Tk5FY3JZ?=
 =?utf-8?B?TjJ3NlRyU3BldUY5NDdGVlQ5YWNHRTJKS1VOVWIwV3p2TmpTdERpVk9YdVQ1?=
 =?utf-8?B?d2hPbkMyUzFjTVd1ZW51UmtZc3B3TVhsMEdWTDZqbm5ndzdKeTFEMTI5ZTYr?=
 =?utf-8?B?NlVNVWRLNXBla3Z0ZDN4UGdYUU5lZkgveVIyVFpQUlNrYkk1cTFSK3IxY0kz?=
 =?utf-8?B?VjlLZ1VsRVh2eXdmdW9TWGM1WFhObEpoek1ocTVkMnFkOGpqYXBlaml3aVpj?=
 =?utf-8?B?UnAxMEV3QXlsU1U1blU2azFGWlNWK1dUb3Vtc1E0dldRL1RPM0xvK1EyM05t?=
 =?utf-8?B?NU9EWTRFTVZsMHNXemZlN0lNU3plOXc0NWZ2a2FxcEZTeUoxYzlwZzZxQXI3?=
 =?utf-8?B?WUtWZTQ0RDBEVmUrWEFUd2c3cC9XRzFSblFTcjdsZHJBQ0t2SzNLL044N1pz?=
 =?utf-8?B?REtUZjE4RG1aeE83R1ZoZVEyUyt1Z3hzK0hqTDVtVndweFFDLzdHT3dQaXEz?=
 =?utf-8?B?TWZBZ0l4RndOWWRCTkp3Yk5oMTB2SzdrMmk0MEI2Zys3YS9HM09qUDM2Wm0z?=
 =?utf-8?B?NzdYdnhpLzh3MC9EeC9BU3ZvRkFmT3M2WUN0UCtraFBRcWZMVmN2TEVONkor?=
 =?utf-8?B?RWQ4WDdCQTNjK1dUNm5tbFB3QmhIeHY1UHdDMTdTZ0dxeUNndklmVmN1TDBt?=
 =?utf-8?B?YkZCbFFpT0JHNWJVR29QWlhVVCszMVhMMEFQQnBsN09BTER5eEJqR1VoMFhp?=
 =?utf-8?B?Z0pCMGpRcFhnMWZzNU96ZVhGaFJReG16VWVKT2tmYTRDOUxmOWtYK0lPQ1Fk?=
 =?utf-8?B?WFh6WjV2VlB0RmN6K2VOeklsOEdjQ2R1NFRQZHBpRFE5TDBmN3lVWnN2NEdq?=
 =?utf-8?B?L1RFb25oV3dOZEFDMU1oSkFKSGhNYWVlay8rYjFtTDFNQlhiRzhoaXJMT3Mv?=
 =?utf-8?B?UmNFYVRUK3RwZTV6Q1AvVWZWVjl5K3lidDRBYXluTTN2VTE0eExEUjFjbEha?=
 =?utf-8?B?SGhGTGdNdzFMU2djNnkxLzJjUFUxNTlNbExqbVVJZjZYNVlKcHZvOXRGbjY5?=
 =?utf-8?Q?g9i3Tsvm9uKHeR/vusJdOTkVQ4RFSWyXpnbXHUNYB2Co=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 67435a27-9696-4d66-3639-08dcf1c7487e
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 11:55:39.8199 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME0P300MB0554
Received-SPF: pass client-ip=2a01:111:f403:2819::801;
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

> On Mon, Oct 21, 2024 at 1:35=E2=80=AFPM Junjie Mao <junjie.mao@hotmail.co=
m> wrote:
>>
>>
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>>
>> > Adjust the integration test to compile with a subset of QEMU object
>> > files, and make it actually create an object of the class it defines.
>> >
>> > Follow the Rust filesystem conventions, where tests go in tests/ if
>> > they use the library in the same way any other code would.
>> >
>> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> > ---
>> >  meson.build                  | 10 ++++-
>> >  rust/qemu-api/meson.build    | 20 +++++++--
>> >  rust/qemu-api/src/tests.rs   | 49 ----------------------
>> >  rust/qemu-api/tests/tests.rs | 78 +++++++++++++++++++++++++++++++++++=
+
>> >  4 files changed, 104 insertions(+), 53 deletions(-)
>> >  delete mode 100644 rust/qemu-api/src/tests.rs
>> >  create mode 100644 rust/qemu-api/tests/tests.rs
>> <snip>
>> > diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
>> > index 42ea815fa5a..d24e0c0725e 100644
>> > --- a/rust/qemu-api/meson.build
>> > +++ b/rust/qemu-api/meson.build
>> > @@ -14,11 +14,25 @@ _qemu_api_rs =3D static_library(
>> >      '--cfg', 'MESON',
>> >      # '--cfg', 'feature=3D"allocator"',
>> >    ],
>> > -  dependencies: [
>> > -    qemu_api_macros,
>> > -  ],
>> >  )
>> >
>> >  qemu_api =3D declare_dependency(
>> >    link_with: _qemu_api_rs,
>> > +  dependencies: qemu_api_macros,
>> >  )
>> > +
>> > +# Rust executable do not support objects, so add an intermediate step=
.
>> > +rust_qemu_api_objs =3D static_library(
>> > +    'rust_qemu_api_objs',
>> > +    objects: [libqom.extract_all_objects(recursive: false),
>> > +              libhwcore.extract_all_objects(recursive: false)])
>> > +
>> > +rust.test('rust-qemu-api-integration',
>> > +     static_library(
>> > +         'rust_qemu_api_integration',
>> > +         'tests/tests.rs',
>> > +         override_options: ['rust_std=3D2021', 'build.rust_std=3D2021=
'],
>> > +         link_whole: [rust_qemu_api_objs, libqemuutil]),
>> > +
>> > +     dependencies: [qemu_api, qemu_api_macros],
>> > +     suite: ['unit', 'rust'])
>>
>> I met the following error when trying to build the test:
>
> It works for me, but I'll switch to your meson.build code just to be safe=
.

That's odd. What's the version of Rust and meson you have used in your
test? On my side they're 1.82.0 and 1.5.1.

Rust.test() is still preferrable to me for its brevity, as long as it
works.

--
Best Regards
Junjie Mao

