Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16C56D5E14A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 09:22:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9LBH-0005Wa-TE; Fri, 08 Nov 2024 04:21:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t9LBG-0005WM-HE
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 04:21:26 -0500
Received: from mail-me3aus01olkn2103.outbound.protection.outlook.com
 ([40.92.63.103] helo=AUS01-ME3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t9LBE-0004S2-Cu
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 04:21:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hFvIG7OBMAEb8+aEVzgwMlkTypqp6XDPJr3zN8ODO25g+GiYij72k1q8EZO0ZI3EpnGzrkGCU+daaTavFYmWCr1NeHybFCdff+FOoIoHczw5tT4kEBjmS5qdjFBecNll5NWParDi5v8ax+n7Hr1sTqnS2Trd4vqo1OWUP1OHzNFipKLhBByuDM8YNLZxDwVsLGiPhE+MBzrpehMdJK0c/EH51nGkHSzEKSfEuhr5sVo/2AiWqV8PSR0TYcBagFfuHcsTStFUNAdrphj4vxD6efCEZ7lE25aWW2GJsZdWp1yroKOp7E/WmBufvfGpGuabxG6gPCn8qDn47KDwHE5gpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ch0ETzxdyw2dbL5q9QVZVHCJQmBbYLzedAYN8+ouUSk=;
 b=eTeVP2UdeZBcm989y61p48R7wJMALdsIRRBi5/lk3s/XMUr0rSA7vkdD+7Yns+g5yESk6zFJ8WIX9U81s8+N3qPP63s6cU3gqbRjnG+GQCsqmp8kFxFrMoFDLlf7+bG4bxZtRsFrd1HbGRsS9oD3KGILplANW39P72vG+uBnovNSCYGwWvllY/hvyoLAgoM1NQtHWepyk30Sax90iwCi73sc42OkqKc0qOdv9mDpXVQBNII3R1t6oFFdFRQBz9TAAlp48F3NdLmyhSUfasUnxXVM63v1r7wskVdqqfEFlqbYjJxi0dD0Tfrqj5wg9HgbpL8r+En5x0S0+kKLdjfMww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ch0ETzxdyw2dbL5q9QVZVHCJQmBbYLzedAYN8+ouUSk=;
 b=kG7ZIEk2ZPJhQ7nVnOar8NSKI3EWq2pASG5w0J9ZXCVhQEwDJiOlYk9RrwDk1TF1vsQkrRJuDkS9kpxr8I439gP5jZPMSI2zxojKbHUCDOoHbLqlgIJ9RotLdlcA4bV6fa9fPMpy/zDGVCBhSP7Fh9LIUr5Mwp9rcMmIEIapH7HiIO8o6T21GARmee/xaCIy9Vrk2Gmp0HNwjmaGVNTPGp9zf//r+XyGOfdZ/XgvVpO2Wzy3qrYYPdkWayZ2xbBsxSUCBX2FxRmIjJxP9SVxSVsH077es9E1hGQIy2AB2pabtd8rITLRUAJ6YODnIyVunnKiCo10VetCyJUJGfT9vw==
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:282::22)
 by SY7P300MB0009.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:219::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Fri, 8 Nov
 2024 09:16:13 +0000
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd]) by SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd%2]) with mapi id 15.20.8137.019; Fri, 8 Nov 2024
 09:16:13 +0000
References: <20241104085159.76841-1-pbonzini@redhat.com>
User-agent: mu4e 1.6.10; emacs 27.1
From: Junjie Mao <junjie.mao@hotmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, manos.pitsidianakis@linaro.org,
 zhao1.liu@intel.com, kwolf@redhat.com, marcandre.lureau@redhat.com,
 hreitz@redhat.com
Subject: Re: [RFC PATCH] rust: add bindings for interrupt sources + interior
 mutability discussion
Date: Fri, 08 Nov 2024 14:21:26 +0800
In-reply-to: <20241104085159.76841-1-pbonzini@redhat.com>
Message-ID: <SY0P300MB10266F3AFA3AEF31A6E06ACF955D2@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::9) To SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:282::22)
X-Microsoft-Original-Message-ID: <87ses2nl11.fsf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB1026:EE_|SY7P300MB0009:EE_
X-MS-Office365-Filtering-Correlation-Id: efbe1756-cbe3-4772-0834-08dcffd5fc93
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|19110799003|5072599009|461199028|8060799006|7092599003|8022599003|15080799006|440099028|3412199025;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vEd9Fa0zXnNyLlnJFQHwlwKNT/oDpxBu5XmuMyJ273fY1pEd7bsXmbA6YBQf?=
 =?us-ascii?Q?VoAAJvsnMN2U7wWEg/nuZqARBBT4xtA/6suJwUd7goPM6INOikICz3V6ZQ3w?=
 =?us-ascii?Q?TfDxVMhQfpYkFxJTx1Ea+DYuBV9bUoU3z84ITNG1w4BidNfZsHilyNoFnmzv?=
 =?us-ascii?Q?IurnLC2V9fX7TBD4lTwGOn43bqt9sHy5sqKYbVRRvRH77eJHdR/HvFr2hvav?=
 =?us-ascii?Q?S+zRdmhuz329yU466S6REdIyG0n59jkar7m4rnxw/sooEcqWNy+2fHY6/XYH?=
 =?us-ascii?Q?LNBi1SLlq2iOuXEoCEZ9lEE570SEZWmlHN+tR0NFEoNDr9dH7pLE23lV9W3a?=
 =?us-ascii?Q?J4939bgS+/Yxxc33zfFxGXA3tqqW53ggkxU6jh3H93JzE4124NzN2HUgsPET?=
 =?us-ascii?Q?PygFFbeQrm8z0u7joKJ023+aR3XaPlFPeD5m0XM/Z0EkS0Tn2VOj6N7EKTxQ?=
 =?us-ascii?Q?qlDnCKV1sU83IBCrnIksoIYt4R50JkQ/Vqku+3d2eeXyt6jAauqj0Cf8JZcm?=
 =?us-ascii?Q?Kk6r+KacvR4uNOqR5fwGn+LDUyovWh4lg/8nmAE2gmuXwSRLmdAiFu8Gruqm?=
 =?us-ascii?Q?zrfJOxz3dBGeIvOHg7degZcnqYxKg954d+L98RaZ3ZksSm2oy2DR5lqJK6Is?=
 =?us-ascii?Q?jk6o0vYsbTlKfI/HFrXF+1nX6d9XMBu6gx2aBGZ5L6LmkEBv3Bs9ord5NxCU?=
 =?us-ascii?Q?XlUB2fWTrNf2TQRQcJDU7RFieZLffmGOwt4oQDHq5n15H7Fhjnc06D1bImdw?=
 =?us-ascii?Q?vyfJesoWlUOmxpHal5K/my3usb0QoQDXwRCd6q0oazdc2qfCgmHlQVKS/CW0?=
 =?us-ascii?Q?zbpCM/cD/fZHL5V+HA+yglmAAQmp+LY+QGcy6LjRJPbVaOsm2tYJHNXKLMKZ?=
 =?us-ascii?Q?gPyT2NIUUBqZRcc4a4GXWXmNEJfVTJZC8nPtXRZIBaKRkgeFyPwnF8iYy7F4?=
 =?us-ascii?Q?epswF9x34k8ylIEeR9kmomtXAtXTNXj4+PhLVZEsr5rTBUbIsNZl6FhqSfmC?=
 =?us-ascii?Q?klWUSSNHGxice+gydFwR+UFhG8gpfuw4+cCz6ywcOIQGua6PR5PBz2t1rUIs?=
 =?us-ascii?Q?0SUSi+SE?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yKKzmhk2X1cl+jYLxP0xGW0m08rC2/ETXR3whBWaEz6ODURIajCZI2IgEWSA?=
 =?us-ascii?Q?8mDxfJyVJ0RKwq5Wm5hysoIM4/7DYIcWKD/r2AXV9C3jM2N393zmPYjzGNDH?=
 =?us-ascii?Q?M5Bd6KWEqubcCYjK3ZTt0zPaifSuD38cN4s1JkFd7GSgmx5kUvpBpYsfHntY?=
 =?us-ascii?Q?3kMqwg7Sswo7pbzFTJ0R3SLjGzEA6rFG5X7sfXi3Qm/rrn1eyij9zAn7N7Nw?=
 =?us-ascii?Q?r1TKQzjYbaxtFW2/l01rSauxHNcglIMp6P8zjU9wWJGqstXxtgPcS7L8fSos?=
 =?us-ascii?Q?B8+pebFpDsCdkVPEIs/wt95En8mHnMr8NkgpYWmPXpwnmJHGxH5xltRuteQF?=
 =?us-ascii?Q?TTf8smTTBE4reFN6ZZiqULtQmQHSvW1CI58pRud02i/BNIHFIfo7B616vRMK?=
 =?us-ascii?Q?Ip2+6TZyC/3kO3C7Bs152qg/9C+fBCk1g2lA//wIxb5Z0coCJvgRooCxdA9m?=
 =?us-ascii?Q?3xp0lxaJxTMTbOXBSf36S9t+zaXLjvFUyzwzK2yTVNtU4XF/v/vJK1i2Snco?=
 =?us-ascii?Q?16pIZQuEv+r1OVIGDOI8x8EMECsgTorN9s3uDzHUJf7bsHvWDbs8Hq+uR/Ri?=
 =?us-ascii?Q?+IMgjmzRByPcI6TZYpIUZTgyJLA7sb5HMEglCyTaLv0jycO4+ajVVC+mYczd?=
 =?us-ascii?Q?WJ8g5OPLmJ5bcOv+WERnkuSu8a8HSN4dMOVEyUBArUtqLBFasYaFKhLQfHFI?=
 =?us-ascii?Q?YQCNq0m/vnvcDTWjWrml5ia5sFr3eBfuDnF1RATt9KcO80q3gCW7fDZHxuRG?=
 =?us-ascii?Q?WOZoLuiXu7Bkpwkb5GsSff2JD60uajehcKo4uqbmCQgHyf+iIwVnxvY9x+pm?=
 =?us-ascii?Q?Y+jYaPHmt6FC67JdWsMDqwnchS/066AvswZeqovr9VOSxPo93hRP8/VXLGyS?=
 =?us-ascii?Q?T5zZ1V9gZxXWjyngHcHtKz6avqp5Ah9RB+c/5lwkhv9wW5FwHCDxuXBDLeTv?=
 =?us-ascii?Q?AIfVLK/dE3/x4klJn5+x3SwUQdgM4fh2Ho8XWqBuPLIT8SnZvZPh4WWchL1X?=
 =?us-ascii?Q?h6oKfVZpTOcqyt6OXvLYV5Wr3dpootT7Q9mLVKVP7R9hq/dYBkM/4+XeJOgW?=
 =?us-ascii?Q?mpLZ9jijdwDmr/yvBMzD+AVC9eujInwh9idjDpVnDZygfMZsteLwP8CF40+h?=
 =?us-ascii?Q?9uW2dLhvYgHJSrJKlZHJlbZzHHrZrQ1BnQuKwOCs6ssS9TjYAjN2s16dsaT2?=
 =?us-ascii?Q?6JEvGWhW16r2qfcPv9HWyGZF8oVq/b6Gi8ymLm3bgGa78OLRhx9rVxvGjjU?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: efbe1756-cbe3-4772-0834-08dcffd5fc93
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 09:16:12.5774 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P300MB0009
Received-SPF: pass client-ip=40.92.63.103; envelope-from=junjie.mao@hotmail.com;
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

> The InterruptSource bindings let us call qemu_set_irq() and
> sysbus_init_irq() as safe code.  Apart from this, they are a good starting
> point to think more about Rust shared/exclusive reference requirements
> and what this means for QEMU.
>
> Interrupt sources, qemu_irq in C code, are pointers to IRQState objects.
> They are QOM link properties and can be written to outside the control
> of the device (i.e. from a shared reference); therefore their Rust
> representation must be an interior-mutable field.

I like the idea of modeling device struct fields as interior-mutable.
That reflects how such fields are referenced and can help forbid invalid
accesses early.

To showcase the benefit of modeling interior-mutable fields, a more
complex device example (probably involving coroutines or other async
mechanisms) may be needed.

>
> But this actually applies to _all_ of the device struct! Once a pointer
> to the device has been handed out (for example via memory_region_init_io
> or qdev_init_clock_in), accesses to the device struct must not use
> &mut anymore.  It does not matter if C code handed you a *mut, such as
> in a MemoryRegion or CharBackend callback: Rust disallows altogether
> creating mutable references to data that has an active shared reference.
> Instead, individual regions of the device must use cell types to make
> _parts_ of the device structs mutable.
>
> Back to interrupt sources, for now this patch uses a Cell, but this is
> only an approximation of what is actually going on; a Cell can only
> live within one thread, while here the semantics are "accessible by
> multiple threads but only under the Big QEMU Lock".  It seems to me that
> the way to go is for QEMU to provide its own "cell" types that check
> locking rules with respect to the "Big QEMU Lock" or to ``AioContext``s.
> For example, qemu_api::cell::Cell, which is for Copy types like
> std::cell:Cell, would only allow get()/set() under BQL protection and
> therefore could be Send/Sync.  Likewise, qemu_api::cell::RefCell would be
> a RefCell that is Send/Sync, because it checks that borrow()/borrow_mut()
> is only done under BQL.

To me a container that check locking rules sound more like Lock, not
Cell. Name it as a Cell can be misleading to those being used to Rust
cells.

That said, one of its primary differences from the standard locking
types in Rust is that the lock involved is global instead of being bound
to a specific object. There are two alternative APIs in my mind:

1. get(&self) -> T / set(&self, T) which internally checks if BQL is
held by the current thread, and panics if it is not. This is more
straightforward.

2. get(&self, _: &BqlLockGuard) -> T / set(&self, _: T,
_: &BqlLockGuard) which takes an extra evidence of BQL being
held. BqlLockGuard can only be got as an argument to BQL-protected
callbacks (macro-generated glue code here) or Bql::lock() which calls
bql_lock().

The second approach looks more idiomatic to me and may allow the
compiler to error (via analyzing lifetimes) on derefs of
borrow()/borrow_mut()-returned refs after BQL is unlocked (I need a
double check on this). However, temporarily unlocking BQL is extremely
rare in devices. I'm not sure if that's worthwhile at the cost of making
the APIs more tedious to use.

What do you think?

--
Best Regards
Junjie Mao

>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> 	Do people think this is the right way forward for interior
> 	mutability?  Should these bindings be committed already with
> 	the FIXME comment, or should qemu_api::cell:Cell be written and
> 	committed first?  Should the implementation and use be split
> 	in separate patches or is the diff small enough?
>
>  rust/hw/char/pl011/src/device.rs | 22 +++++++-----
>  rust/qemu-api/meson.build        |  2 ++
>  rust/qemu-api/src/irq.rs         | 61 ++++++++++++++++++++++++++++++++
>  rust/qemu-api/src/lib.rs         |  2 ++
>  rust/qemu-api/src/sysbus.rs      | 26 ++++++++++++++
>  5 files changed, 104 insertions(+), 9 deletions(-)
>  create mode 100644 rust/qemu-api/src/irq.rs
>  create mode 100644 rust/qemu-api/src/sysbus.rs
>

