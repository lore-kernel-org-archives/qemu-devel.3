Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B782DC0219D
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 12:18:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thpCl-0002Sl-W5; Tue, 11 Feb 2025 07:17:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1thpCc-0002S1-WD; Tue, 11 Feb 2025 07:17:23 -0500
Received: from mail-me3aus01olkn20821.outbound.protection.outlook.com
 ([2a01:111:f403:2818::821]
 helo=AUS01-ME3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1thpCa-0003Yv-EC; Tue, 11 Feb 2025 07:17:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kJhFxTjIZzq3cy8EApudT3JB75N8aq+uL/y+hvJKlA00CW1BRfAxcQxqoy3HDP+hM2FQsB3GIYehn1Dl70WkPSKxGd+qTVlL3AxZ8LbsBWxBMkd/uOWSy5MFx3VRmJWzSN8sp27uwdETeKgy61CweENQnkfNcFrT4LEbckvuDz4gAN3p61F4godanUNfb9ni7wJ7lWZ7Mbw+NYpjELZGbVVR8sBzk7juYEVLnofRQJRuBvhixi45zLhAroRIAhz2WGoOIqvPCNVekdJhs06x3DtbpJ27W3bEIgumhN0A7otD6OIydrx0w095nr2CUQ3Xc8r8WetUie7Sdr6zj7ZhTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jVF4p4yHehLtyukjgEy6G/oE1J0b/V5zgtOuyGMShXs=;
 b=Gmgiotvsd18O/Rjb3AhuWPvlCumh8BatpQWk3eycNRIU74iPVvodYLUqRSWHW5yD3oiBdOKR9Vimy5XJVHCjqFPGxaGoHRXS+jQ3Bch8Ri201WTRoF+nQ/uhbt6ImuT2vB646PHeCSjwkV4Jtc9LJPfihuBbftHElEoTPOAKjmdms62H8oHN7lGH8n4ZW3A4ZJm1sLLVcPffpA+EoPgsBum1Elc7eHYr/9rr+xwk5x7KnTvMVoTa2ljhhEH7eoujCV4M1dSeHxVLlq9BFkNtbLqK7DALxZThaiMosv/b8dfSi2Ir5uOoUmZ/dJ7bHkKTwgaP2mP/vorMq+BAJGtI9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVF4p4yHehLtyukjgEy6G/oE1J0b/V5zgtOuyGMShXs=;
 b=I/luZ/BKSRKZCY7VguEpuZ2dMAyUBoKaK74Pbu0n3O56N1F5RP9qfF3Uji4eHUG2eqTGb1Roz0BW2Nm/aW+WsHo2TahVLjRevcZcykTPgyFoFBVtkaxpfWptvIHbrDbhfcDGUMfIN9HaoA5Algg4v3JNlFPE1U7YfpUyq0x1OaF2mX96gSaybQasrcF6YKLg9km442s9dEm+1evOUEZA9csfkfsYMTJVex0twl8vdIYeY79L2O8fGmY9ygIjnRD9+8x6yuta1cQkiTMmiqyAbWg22oOGgO9naRmqbvAE9jwOTLbeH14V+dBBGF2bHcQd+75Yr0iChO1smpbyVo+/gQ==
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:282::22)
 by SY7P300MB0258.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:238::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Tue, 11 Feb
 2025 12:17:11 +0000
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd]) by SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd%3]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 12:17:11 +0000
References: <20250206111514.2134895-1-pbonzini@redhat.com>
 <20250206111514.2134895-2-pbonzini@redhat.com>
 <Z6nOAftJsjQ7KAiS@intel.com>
 <c7685bff-96d1-4e89-ba19-08fbba399d37@redhat.com>
 <SY0P300MB1026B9C81F2EF236BB703F2B95FD2@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
 <CABgObfbTx9DNkkzw8EeMRU0+L6_+P64KHtAJTUwsW40mtwGSOg@mail.gmail.com>
 <SY0P300MB1026E0CE5AFBEA4E713F73F595FD2@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
User-agent: mu4e 1.6.10; emacs 27.1
From: Junjie Mao <junjie.mao@hotmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, qemu-rust@nongnu.org
Subject: Re: vtables and procedural macros (was Re: [PATCH] rust: pl011:
 convert pl011_create to safe Rust)
Date: Tue, 11 Feb 2025 20:16:03 +0800
In-reply-to: <SY0P300MB1026E0CE5AFBEA4E713F73F595FD2@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
Message-ID: <SY0P300MB10268B59A558B46964D24BB895FD2@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: KL1PR01CA0103.apcprd01.prod.exchangelabs.com
 (2603:1096:820:3::19) To SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:282::22)
X-Microsoft-Original-Message-ID: <871pw4islh.fsf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB1026:EE_|SY7P300MB0258:EE_
X-MS-Office365-Filtering-Correlation-Id: 30610bb8-fa21-4103-31fb-08dd4a960322
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|15080799006|461199028|19110799003|6090799003|5072599009|8060799006|7092599003|440099028|10035399004|3412199025|56899033;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cnR1VVU4MThoRUszOUhHOFc4RGpQenpLWUJ6QjhKRWp0Qmo5c0lMQm5uUW9z?=
 =?utf-8?B?R3FQaGFaQVBkVTUvZFNJQTlKazZIUWJtNzhLc01WTkw4QW5KT2NtRjhLS0lJ?=
 =?utf-8?B?djVNZGhia3VRcTJpQjgvd21YVmk5aWh2L0dFMWJ0OGx0TktDOU1mR3JxaEQw?=
 =?utf-8?B?QUQ5a0J2UndkYkY0bEIwcXRsRndjZlViYVRSb3RJZnZ0SGxhaDB4d1NwRlgy?=
 =?utf-8?B?clpzazZEditoOVNKZFpXWFNKMEIxbzcxRjY4ZjBHSW1uK0JWb0VUUHpvaGs0?=
 =?utf-8?B?bGN2RTdEd1hmMW1IS2F4WDJZaXczbnlwREZuUm5lMHZiS1ZQYm5NVlVVWVNG?=
 =?utf-8?B?cTB1dXJudnV2QUlnYVJOVU5aVzdqVUdxMVArU0dtNUpHdUNGL1E1NnUxV2tq?=
 =?utf-8?B?WWRCRzh3S0dIb00yMFMyZlJwTWpYTkllbjRva0FRNGREZzFQa2h1emxqZFdl?=
 =?utf-8?B?UnE5SEp0YXJNQmVwNitwTW91VTVRa1hPbDBIU29aL1ZtS0p1NWFWMXVDNFpB?=
 =?utf-8?B?am85UDh1cTREdlBpT0JBQnZmZmVFSnF0Nll3SHRqcU8zOUc0b3NmczIxQXBV?=
 =?utf-8?B?ZStXQnRFUlU3cFpOcUZJSEFKTERrUmJyeTJIL3pYa21RcHIzWkJVb2N5UUI0?=
 =?utf-8?B?WG05K2Fnamd3aTlHNGRlc3hJSEZiaDNQeUNpNzdBd2t0RVNja0lUbFVtZXly?=
 =?utf-8?B?VmZsMG1yTE5wVUZrK25wbGc3N3FhaENOcjFqS01obUpJN3R1cXY2NTAvcmVz?=
 =?utf-8?B?eEZaTnFKd2l6b295cTEwSGE2K3piVk1oZm92QlB6d1k0cE9QQUFLOHoxTVFt?=
 =?utf-8?B?T3hjWUw1bnFURERsM252OFBueW1oWUdDUFJIMlZxY3NScWROMUZjZUE3V1gw?=
 =?utf-8?B?WjN3NWg3bDdCRmJyVERBdzBWeUxKUmtDYjRxcmJJSEFJWHZqeGI4UUo2UVpl?=
 =?utf-8?B?RlZ6Lyt2STV4RDZobDRIUXpnNFVpTXVEYTNRNHo0TnZUajRQamxYOGsxa2pk?=
 =?utf-8?B?SThUc2hITjN0aDBNNFU2b3E3OU02NDVoL21sSXZXMUFFSWJXbFZpS3ZzWjJt?=
 =?utf-8?B?YUhOd1VsVTVHbXdGZ1NIWm5pVnBFSXJMWEtKMTdvRjRuYVJldjcwR1Z0QjNF?=
 =?utf-8?B?eUVkTWV0dHpBdjdreTViWDUvQW80aXRNbDc3SVZESVRtam55UDVVQkhTYnN5?=
 =?utf-8?B?dmRRVitSSE1KSE9DWDhUR2VhSHZKNnByR014ZkRFeHVPandveUU0MXJvUW9G?=
 =?utf-8?B?OHVBU1NoSXhZSXpuUFY0cTNzK21kY25Vcys0MWlJUU5SMVpCdEZtSDA1eU1q?=
 =?utf-8?B?OXJPSmdja0R0RlArcEFMblU0MDhOajdrL1ZMakxQWHN5MHZpdy8zSkZvOHdO?=
 =?utf-8?B?RGc1N3lRNno4aHhXUGxTaXJENWJQUS81WEN3N3hnQzc3RHdHNnBBRDdMTmhk?=
 =?utf-8?B?Ykt0WVB0UWEyNGFDdllnY0lBZExDZlpKVnVTbEtrWU5WTzJXTk5BUGlXTjl5?=
 =?utf-8?B?VU16MG1pSXoxQjZOZXJUVG85T2VtNWhrQ2oyRUVLZStzSk10dmpKMW1jVVdS?=
 =?utf-8?B?ajUzQT09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDM1Ui9McXAwU3FIckd2ZmRBRklHSURNT2lRdTV2WElMcjBXQUxnVUJLZUVz?=
 =?utf-8?B?c201S1FwQlE5by9Oa1NhMUZ6K2lYZjl4d0tTS1EvaDlXaDgyTjgrZkdDaHV6?=
 =?utf-8?B?N0dtQ3NJNlcrOUYzWDVZZnBFbmUwOFEzdXd4bVRtMVgzQ3hSdFlkZlk1MDBJ?=
 =?utf-8?B?RFV3S0hhbTZhNGo3OHYwbFg2K2JvNVd5dkY1UW4rMEZlbS9vME5aRmk2Z25S?=
 =?utf-8?B?MDF5eUt6Sk5RWjU1R0M0Rm56aVo4K3ROejJnM1JMM09qWU0zdE1WSFVKQTZm?=
 =?utf-8?B?em16eWZ2cmE3WFFLZEVqN3NmdXNKODZaR3QzeDNRejdvNjJib3hmMEVBSUli?=
 =?utf-8?B?cjQ4TEZVUWpFNFloZ0JqSzRFL1R0V214Yi9XUFh6YS85OVZWMHlwMFF4dktX?=
 =?utf-8?B?QVc1SXdXQTFHZlhxRTRPajdFN1Erc0owYTFmRlRkNFRqL3Q0ZE9vQkNDWUpN?=
 =?utf-8?B?TDlLUUtkM0JOTjRXRGlsK2lHeGpsZ3JEdzNQYitZSitTZTdVdUNLQzJKdlg3?=
 =?utf-8?B?ZnRoU05BR1NTeDZjamN5SSt0NTJBejdvN3NOQmExR1d6TENWUmh0d2FFSUJ5?=
 =?utf-8?B?UE40M1J5dFZsN0pjQmk3R3ZJa3BLaWJyR3ZQbUdLSzlpQkQwbXMvT2Ryd2E4?=
 =?utf-8?B?NnNueUl1dHhaY2tlWGJ5em83eTRTa1RwZFNwU1ZKTGJRQW41ekRQOGhoNzdL?=
 =?utf-8?B?aUJnZ09DZ1pnZ0xTWGhOVmFTNXY4NDhpWkpmWVBIVU1NaGVJRWdCS01tdTJZ?=
 =?utf-8?B?Q25vUm1senNCdlBhK25XOC9pRTRRSzZQc01Jc1FYcXpXY1N0d2QvTGRFeTlK?=
 =?utf-8?B?UXhVaGlWMmdSVWVnMjV2bE16NGs3R0ZGZnBhVFJheGpCVlArRkZ6WkhET3U5?=
 =?utf-8?B?S2xaaDlyRnlLVkQ4SmVHY241MXYwcjd5NFVtenBmYUxvcFlEMmptd0QvQ3E2?=
 =?utf-8?B?MndzRFdhV0ZNYk5lQ2xRZUdLYzA0M3FPNDNIclZaZlNlK3pCZ0FrUUR4T0pU?=
 =?utf-8?B?b0JOeWlSQnVhL0VIT2RKeU1JeUU2cjA4VlVBMy9BRE1SNGx4b25JSm14a2dy?=
 =?utf-8?B?akhsK1hPb2xEODAvU0xaRTloU3FUdHJNemhYaWtXSkhrdGtjdE1ja3dBOHhV?=
 =?utf-8?B?VjFVelVxTU8vSXNqVE5MTDVGbHhMQkJqY3FSZzlEYk1VOWtJQnZNdjV2cyth?=
 =?utf-8?B?ejZKVHJ3QjdFUUpoZkRNWGs1ak9nbUFTMFJmMTdnUDVhamNkaUY1dzBsa2gv?=
 =?utf-8?B?OTdtaEduMVg5NVdzdmJ4SlNYSktPakdlZWVFaGJ5ZlNUMWtBSDB6cm9JNGZL?=
 =?utf-8?B?eWtKT2FVYUlUd0c0TXRtaE0rTTE5VU5uWmZibVJ6ejFiTFF4NEdscDRBbGZy?=
 =?utf-8?B?UjR2S2wvK2F6MXUxSy9vVWhSU2h2QUJuNTFqRkNpc2YwQmlpRkwwYkZzL01X?=
 =?utf-8?B?ZDRZS1llaWx1TytKYVhOUWRvQXpPR1ZKeEVROEJXV2Y0QU53QmRKOEpGcHVy?=
 =?utf-8?B?eXlxWUhPWUVPZUs3aG9URzd0WGhsYjhWVUExaHFQeTBYdG5iMGVZdEFvaWlJ?=
 =?utf-8?B?S1d5KzJWSDBPVTNmYXBEVC95N1lMOWRXbG52Nkg0bXl5WFZmdk9HZGg1dXZH?=
 =?utf-8?B?ZlZQNFdFVXBHOUNGbUM4VEkwZWt1QThoSUpEQ3RvaTBhZFRkNjBPQUx4WTFG?=
 =?utf-8?Q?GjSLg2hU05VWOsbgeaHK?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 30610bb8-fa21-4103-31fb-08dd4a960322
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 12:17:11.7274 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P300MB0258
Received-SPF: pass client-ip=2a01:111:f403:2818::821;
 envelope-from=junjie.mao@hotmail.com;
 helo=AUS01-ME3-obe.outbound.protection.outlook.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_BULK_SIG=0.001, RAZOR2_CF_RANGE_51_100=1.886, RAZOR2_CHECK=0.922,
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


Junjie Mao <junjie.mao@hotmail.com> writes:

> Paolo Bonzini <pbonzini@redhat.com> writes:
>
>> On Tue, Feb 11, 2025 at 7:47=E2=80=AFAM Junjie Mao <junjie.mao@hotmail.c=
om> wrote:
>>> I would suggest to keep the "sysbus" prefix in the method name, or in
>>> general, keep the class prefix in the method names in XXXClassMethods
>>> traits. Otherwise APIs from different parent classes may also
>>> conflict. As an example, in the following class hierarchy:
>>>
>>>   Object -> DeviceState -> PCIDevice -> PCIBridge -> ...
>>>
>>> For PCIDevice instances there is an API pci_device_reset(), and for
>>> PCIBridge ones pci_bridge_reset(). Without class prefixes both will be
>>> wrapped (as blanket impl in two traits) as reset() and a dev.reset()
>>> call will lead to a "multiple applicable items in scope" build error.
>>
>> Yes, reset is definitely a problem.
>>
>> I will wrap qdev_realize() in DeviceMethods to check if you get
>> "multiple applicable items" from that as well.
>>
>> I can also go back and add "sysbus_" in front of init_mmio, init_irq,
>> etc.; but on the other hand we have Timer::{modify, delete} and
>> DeviceMethods::init_{clock,qdev}_{in,out}, should they be changed as
>> well? I'm not sure there is a single solution that always works.
>>
>
> The DeviceMethods::init_* wrappers may need a similar prefix for the
> same reason, though it seems unlikely to suffer from such name
> conflicts. Meanwhile, adding prefixes to timer::* seems redundant.
>
> Essentially we want a naming convention that (1) avoids any potential
> name conflicts, and (2) applies consistently to (ideally) all APIs. For
> goal (1), we need something at API call sites that can resolve the
> potential ambiguity. So instead of dev.realize(), we may write:
>
>   a) dev.sysbus_realize()
>
>   b) SysBusDeviceMethods::realize(&dev); dev.realize() is still ok if
>      there is no ambiguity
>
>   c) dev.as_ref::<SysBusDevice>().realize()
>
>   (any more options?)
>
> None looks perfect, unfortunately. Option (a) introduces inconsistent
> naming conventions as mentioned earlier; (b) cannot prevent confusions
> when a device has both a "reset()" method and "dev.reset()" calls; (c)
> deviates from how wrappers are auto-delegated to child classes today and
> is the longest to write.
>
> Option (b) + a lint that warns same method names looks a good tradeoff
> to me. I tried to find some clippy lints for that purpose, but have not
> found any yet. A similar issue exists [1], but has been kept open for >6
> years and is not exactly what we want.

Just found the lint: https://rust-lang.github.io/rust-clippy/master/index.h=
tml#same_name_method

>
> [1] https://github.com/rust-lang/rust-clippy/issues/3117

--
Best Regards
Junjie Mao

