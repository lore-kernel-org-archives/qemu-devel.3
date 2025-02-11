Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD80C0219E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 06:48:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thk3G-00061j-2x; Tue, 11 Feb 2025 01:47:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1thk32-000601-Ii; Tue, 11 Feb 2025 01:47:09 -0500
Received: from mail-sy4aus01olkn20805.outbound.protection.outlook.com
 ([2a01:111:f403:2819::805]
 helo=AUS01-SY4-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1thk2z-00068p-14; Tue, 11 Feb 2025 01:47:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M4kejqrdXmpQqUnUQ41+n3XAY+m3AWzBk/e9xdoWCosQytpqbLEeN+mN+84mIjTL+baI+Yf4zJYcHu8qpY/YTHF0nU9TQmLt9Oq7G3JUgJRbeqbiCf5rL7UPFLgf0OqvTN0IkB8Bs+vI+MHNW64Kc8EZj3hBMCf5Id57M+t0VRyFE5LP3TvhmBZJCAQV8M/gBkjqAYXqwm9XUbXTfcT8SDSKqAz8YXwxnK+W5Iw/kRe5pym9BI+QHkjJ5QvrvCVtaJ6mOAf6S5mqrtSUptaVqf5Q9kHyEmxI5qnPd53DI9aiZQpg/MDxoTMc4eMWWDr4179LigPcHHapiuJ+mDCxjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pnPAjQDn3wwzwnnqWwZGyDKw/r2RXPGzDIRfGUU9NF8=;
 b=pxTxrN9JAKZZMiO0jiwEvfCTohyW1inkaeZrccFuu5x5n1lyRViGmiow/Xce8Pvhi/e0L/1E75lBIounodbuIJwJWAW018h9U/CZ98dWofT43VyGLiZwg36OUlVSk+wCafFcbSl0JwVO2Ox7GsOoTZC2NQOkLUGZSRiVvYpaj93UaZtiua+cidE7xsaxj6UxItrWWPq2QMinrT1qBChcDfZADigTf2K3E76QxdMbMvSr40CmQPhRSSAR69YCxiSOPL8Gj0b8/OwiJIVz2WoTq98dRbT84TGVSVPvaFb25dgtbLiCwK5JM4hT+xpTFpxOgvAmeeylGLJejWcCa4vP4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pnPAjQDn3wwzwnnqWwZGyDKw/r2RXPGzDIRfGUU9NF8=;
 b=lj4y/EolViKNeDS9+/qapDjgQl0yUgER/+KdSY0XGvkxpovBA/2je0J903TRuekiALK5eaBvw9iiPzabWoNb3xmyEM0YdUUgw8Q5vjuT/iRsBNq6Fd1ovTGa+lNjVa1gpDkxnGXMWzG6+P/sKRNKBMaqWGO+fp67uH1gpu6Zwu25fZubUNIPndQVuipjr/cfRD5yBpuz7dEwUdVmw7psnMtXJ32gZnxcLFDwCklwGL8GlbUfkEHo8ET6VxVb+zwbErpAgSntIEfpuRittrOpZa7s3QJtB1zipjil//wQk3KtL16VQSI102av4z8lNCJUrnUZ8x9YvLoetoOQQ8Oy8A==
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:282::22)
 by SY0P300MB0051.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:251::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Tue, 11 Feb
 2025 06:46:51 +0000
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd]) by SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd%3]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 06:46:51 +0000
References: <20250206111514.2134895-1-pbonzini@redhat.com>
 <20250206111514.2134895-2-pbonzini@redhat.com>
 <Z6nOAftJsjQ7KAiS@intel.com>
 <c7685bff-96d1-4e89-ba19-08fbba399d37@redhat.com>
User-agent: mu4e 1.6.10; emacs 27.1
From: Junjie Mao <junjie.mao@hotmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org, qemu-stable@nongnu.org
Subject: Re: vtables and procedural macros (was Re: [PATCH] rust: pl011:
 convert pl011_create to safe Rust)
Date: Tue, 11 Feb 2025 13:21:57 +0800
In-reply-to: <c7685bff-96d1-4e89-ba19-08fbba399d37@redhat.com>
Message-ID: <SY0P300MB1026B9C81F2EF236BB703F2B95FD2@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0046.jpnprd01.prod.outlook.com
 (2603:1096:404:28::34) To SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:282::22)
X-Microsoft-Original-Message-ID: <87a5athtbm.fsf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB1026:EE_|SY0P300MB0051:EE_
X-MS-Office365-Filtering-Correlation-Id: a60618ee-afb9-4119-ed08-08dd4a67dcec
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|461199028|8060799006|19110799003|5072599009|7092599003|15080799006|440099028|3412199025;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Uf3C8uVRwGCZAESnauaDHiVBIIpg5XBV9GImPN3Waep2zyLrD7RO4gmEJFBq?=
 =?us-ascii?Q?kiZexDTlCdKdfCaQnhg4RU783BQJU5KQIFwGARt7QLDhFHgmue4/gaIw4yDP?=
 =?us-ascii?Q?qSWic81CEoT7j8aDhcurkXuKhPJcw3JT4m0w01EWYk/0tIV5VOk9qN4p70ff?=
 =?us-ascii?Q?Aq9Q5QlwyYPHCuJtOqPJ9phl7y5jwmtBcfajPBxYmSl5J6ZHfL0izzVyofhH?=
 =?us-ascii?Q?qEqPUOat2zzMFdsfkzeM+LUYFOSunkSLQHm/pNPUmQKFjNYGFKzaKiMUAOiT?=
 =?us-ascii?Q?J2P+kYjEMuXINgKv0wd9bbXmVPt3OBb0klITAI9bEep97P6BlJ2dNIaXu2g2?=
 =?us-ascii?Q?r5/n6vK2Pj5OTkUkf+01IwdIvhstsJO04ikgMccN2obWutJs0MQ9kTtF/pJj?=
 =?us-ascii?Q?+QFuH+en12bHRP+VhMPV/bUAZ8ldnoYO9/F5SbQu2OWSel0DDj4w6N3BTMaw?=
 =?us-ascii?Q?Cgf5tvh+4mYiaBgJj29IYSs2jHkJVohOmIbfKuFtPhZp85G/jB0RRkv+dmb5?=
 =?us-ascii?Q?quT1b8mmudVFB/mgcnrLfdYO4zl247fqmt7wjUej4ocTmo9nsZwXw42CC9yn?=
 =?us-ascii?Q?XqCD6TiCDyECuWPMyVcVHl3VNhU6rdPwtYGcp2xhDO/uLcVrufS1NL5a5NOf?=
 =?us-ascii?Q?xzHmqIhRH581bshZB//QiV/bzYK6DFoCZgiDA9V6NDwwLKR6HaQWdli6VaPp?=
 =?us-ascii?Q?RmpKwCDL0lQpTbCH2WSsDlCzZzSPBGotYGaqwp8xRFZE1YX15MMhK6kWwTwZ?=
 =?us-ascii?Q?n2Gocd7mA92iao7iv0CKkHMU158BkU+6yALPbQ5Tnyp+jsulk4pzvQRQ898t?=
 =?us-ascii?Q?k3Un5rYQNfSP9ud3DkukYDc4RE197/me6uxy0gHpH2Bu4mAQONraxvRow/7v?=
 =?us-ascii?Q?b3OBb2CtKFaO/M4OGnlfgo5tCHnAc5+wDDxhKVk1JAZz4ryuXus61gXIrlUc?=
 =?us-ascii?Q?3XFYz6eS9y6VcNzzUl40nA5kOkaoI+qkigXfj7Ti8tx+U2GKiu9ihnEOLsto?=
 =?us-ascii?Q?X/wdkOs6cMxbxSrlBqgwmdv8zOhckfLIiFDmv/0f7tA0R5APUU3t6Nbm8Wmm?=
 =?us-ascii?Q?E81wkR5/qb6GiEV3noaN/bVOgKHpmA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zAvIZqXP7zqnwPIsVX6vwWqQutxYFRKcK2Wf2Xp6KEaipofVZSI8P/fCPh4B?=
 =?us-ascii?Q?oPNoJRCxLT6ubL3eeaTcE1vHerP4rCDwqRTCX1ff2FgAj8DaPlvyjWM6O/ql?=
 =?us-ascii?Q?CGszK37XAoBK+E4FyGqQOGMpbujlBX2oMdjU63KgVxa3duYp6tFfZ1qcg0JE?=
 =?us-ascii?Q?acVkOPBoIjRxoJ7cG4bKYiGrjm5/hWKKs6a1CTtP+IXLsMvKn8TtgMzQ8IGc?=
 =?us-ascii?Q?in4wFQYJGRpKR23abcx7NE3dhRoqa7GgiEL7jCJRXlDcE7GwDKRDntSvbpUF?=
 =?us-ascii?Q?bCZ8waJNMg9is2f1LYCt44WeKk+tT/Gm3B9mki87ar0MKlGMEVHsqG5cXua8?=
 =?us-ascii?Q?x0S2LPPuRhh1U3v0KfAuMhIrwLRu4Gm5h0Es/Xz8ZyZ25GmNE/w4BlhEvH6I?=
 =?us-ascii?Q?2Tx+CdxYvB9O/LGgp6Vzb4tvUD9EOszhyzBXB6nIyJiBpxlY4lhs1g+zOz2E?=
 =?us-ascii?Q?DZbFyIqRVP7bDzitmOTnC55OhOSeFijnFeguDkc8MA0FoBzY0+s7rPjfQMpr?=
 =?us-ascii?Q?MC6qQ3NTm7Gbegj3gux/L0pqz32YN+65epO04Zwu+ZG0EVrNKWk/GfVOkKSR?=
 =?us-ascii?Q?MaMHBvvLz5JeRgKt3WQ2KFt+SQVSVByz2ZckdFm5cN5pnu7rHKsoDaBPimXt?=
 =?us-ascii?Q?6XTCv20QkdBv2dRil77R8onk8LAmNSPVqqZXcJ2Mqb7WaEFNwbeFtErD6R73?=
 =?us-ascii?Q?7FQM/VJktIDBafzSswV0i8noz5BqD9EFqRtrL7xJWGM0+B3LvzjxFU7Bthgg?=
 =?us-ascii?Q?atZvXF31dVdp5/w+paeteef+GSRgxM5K9I6JgwfPYcrw6ekTVo+wkTiacbbI?=
 =?us-ascii?Q?VRF+FTpOxm37bTqBTVMi5x16vPZ5ezkuKzgcPkNBlice+/r8waRXl4Kkyc2R?=
 =?us-ascii?Q?TI4MCzCfOg/j14oItcmHzpB5E/vWevJvcxoTplAE1LTD2TcH0+z+jFt3FjaE?=
 =?us-ascii?Q?HLwGYzHgFQpSLd0YPTLkbSEKe3irmhXnaT8D2SVw/whh0MMa2o2h2T+uEnER?=
 =?us-ascii?Q?d0i2/oYKyxBEsr93Eu9B2CH923elkGO/+dMc9Lyu25I55O48UoHwwYxD9YvX?=
 =?us-ascii?Q?0ocGAF3iOb8nNPBO9jDGuznEePNmC9OsKcmO6d9Lb0ryqkbV2LwAXJyOq97p?=
 =?us-ascii?Q?Fr18mFKcwQGFMBhzwvWhrKbhtMW0foWV6rg5APXy++P018N7v9Z179C+ok7S?=
 =?us-ascii?Q?8kjeoX7g3oKbRhmHSkj3/T9OMceqWyy/NICfFPhZtC4xXPe/po2XUIByCmTy?=
 =?us-ascii?Q?Ei6hufY6uvc5CtYxNpt7?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a60618ee-afb9-4119-ed08-08dd4a67dcec
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 06:46:51.0644 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY0P300MB0051
Received-SPF: pass client-ip=2a01:111:f403:2819::805;
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

> On 2/10/25 10:59, Zhao Liu wrote:
>> On Thu, Feb 06, 2025 at 12:15:14PM +0100, Paolo Bonzini wrote:
>>> Not a major change but, as a small but significant step in creating
>>> qdev bindings, show how pl011_create can be written without "unsafe"
>>> calls (apart from converting pointers to references).
>>>
>>> This also provides a starting point for creating Error** bindings.
>>>
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>> ---
>>>   rust/hw/char/pl011/src/device.rs | 39 ++++++++++++++++----------------
>>>   rust/qemu-api/src/sysbus.rs      | 34 +++++++++++++++++++++++++---
>>>   2 files changed, 50 insertions(+), 23 deletions(-)
>> ...
>>
>>> +    fn realize(&self) {
>> What about renaming this as "realize_with_sysbus"?
>> Elsewhere, the device's own realize method is often used to set
>> DeviceImpl::REALIZE.
>
> I *think* this is not a problem in practice because trait methods are public (if
> the trait is in scope) whereas the device's realize method if private.

I would suggest to keep the "sysbus" prefix in the method name, or in
general, keep the class prefix in the method names in XXXClassMethods
traits. Otherwise APIs from different parent classes may also
conflict. As an example, in the following class hierarchy:

  Object -> DeviceState -> PCIDevice -> PCIBridge -> ...

For PCIDevice instances there is an API pci_device_reset(), and for
PCIBridge ones pci_bridge_reset(). Without class prefixes both will be
wrapped (as blanket impl in two traits) as reset() and a dev.reset()
call will lead to a "multiple applicable items in scope" build error.

In addition, it is quite common to see static functions named
xxx_device_type_reset() in C today. Thus, it is quite natural to expect
(private) methods named XXXDeviceState::reset() in future Rust devices,
which will cause even more trouble as the compiler will no longer
complain and always pick that method for dev.reset() calls.

More general names can be found in multiple device classes, such as
write_config (pci_default_write_config() and pci_bridge_write_config()).

There are alternatives to solve such conflicts, such as requiring proc
macro attributes above methods with such general names, and requiring
ambiguous parent class API call to use fully qualified syntax, e.g.,
SysBusDeviceMethods::realize(self). But I think the former can be
error-prone because the list of general names vary among different
device types and required attributes can be easily neglected since no
build error is triggered without them, and the later is more tedious
than self.sysbus_realize().

>
> I agree that the naming conflict is unfortunate though, if only because it can
> cause confusion.  I don't know if this can be solved by procedural macros; for
> example a #[vtable] attribute that changes
>
>     #[qemu_api_macros::vtable]
>     fn realize(...) {
>     }
>
> into
>
>     const fn REALIZE: ... = Some({
>         fn realize(...) {
>         }
>         realize
>     }
>
> This way, the REALIZE item would be included in the "impl DeviceImpl for
> PL011State" block instead of "impl PL011State".  It's always a fine line
> between procedural macros cleaning vs. messing things up, which is why until now
> I wanted to see what things look like with pure Rust code; but I guess now it's
> the time to evaluate this kind of thing.
>
> Adding Junjie since he contributed the initial proc macro infrastructure and may
> have opinions on this.

I agree that uses of proc macros should be carefully evaluated to see if
they really help or hurt. In this specific case, I'm not sure if using
attributes solves the root cause, though.

--
Best Regards
Junjie Mao

>
> Paolo

