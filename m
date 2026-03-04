Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C02EF8FEF
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 14:38:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxnMS-0004LC-Kj; Wed, 04 Mar 2026 09:38:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vxnMN-0004KC-AM; Wed, 04 Mar 2026 09:38:00 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vxnMK-0002hV-O6; Wed, 04 Mar 2026 09:37:58 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D1A60596D97;
 Wed, 04 Mar 2026 15:37:53 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id HAgW-eYnIJJI; Wed,  4 Mar 2026 15:37:51 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id AC700596DA1; Wed, 04 Mar 2026 15:37:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A9CBB596D9D;
 Wed, 04 Mar 2026 15:37:50 +0100 (CET)
Date: Wed, 4 Mar 2026 15:37:50 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Maydell <peter.maydell@linaro.org>
cc: Markus Armbruster <armbru@redhat.com>, 
 Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org, 
 Helge Deller <deller@gmx.de>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, 
 Steven Lee <steven_lee@aspeedtech.com>, 
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, 
 Troy Lee <leetroy@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-arm@nongnu.org, 
 Jamin Lin <jamin_lin@aspeedtech.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>
Subject: Re: QOM parent type "sys-bus-device" vs. "device" (was: [PATCH v2
 12/13] hw/char/serial: Inherit from SysBusDevice)
In-Reply-To: <CAFEAcA_WYkAYccog-BiA6MJAvoFVwa6niKvFZ7UpLjzkRyd6aA@mail.gmail.com>
Message-ID: <75b86ecb-1248-c0a8-5c44-3da48ff0891e@eik.bme.hu>
References: <20260303222143.142741-1-shentey@gmail.com>
 <20260303222143.142741-13-shentey@gmail.com> <87ikbbixy5.fsf_-_@pond.sub.org>
 <CAFEAcA_WYkAYccog-BiA6MJAvoFVwa6niKvFZ7UpLjzkRyd6aA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 4 Mar 2026, Peter Maydell wrote:
> On Wed, 4 Mar 2026 at 12:25, Markus Armbruster <armbru@redhat.com> wrote:
>> We might be at a crossroads here.
>>
>> Paul Brook designed qdev around "a device plugs into some bus, and may
>> provide buses".  To make this work, he added a main system bus to serve
>> as root of a single tree.
>>
>> The parent of a device in that tree is the bus it plugs into, and the
>> parent of a bus is the device that provides it, except for the main
>> system bus, which has no parent.  "info qtree" shows this tree.
>>
>> Note a machine had just this one system bus back then.
>>
>> The system bus isn't something hardware people would call a bus.
>>
>> The qtree is a qdev thing.  It is *not* the QOM composition tree ("info
>> qom-tree /").
>>
>> We actually abandoned "a device plugs into some bus" a long time ago.
>> Moe on that below.
>>
>> Qdev was later rebased onto QOM, as follows.
>>
>> A bus QOM type is a subtype of "bus".
>>
>> A device QOM type is a subtype of "device".
>>
>> If a device type has a @bus_type, then it plugs into a bus of that QOM
>> type.  Such a concrete device is commonly[*] not a direct subtype of
>> "device".  Instead, it's a subtype of the abstract device that plugs
>> into that bus type.  Example: "isa-serial" is a direct subtype of
>> "isa-device", and it inherits its bus type "ISA" from there.
>>
>> If a device has no @bus_type, it doesn't plug into any bus.  It doesn't
>> show up in "info qtree" (it does in "info qom-tree", of course).
>> Example: "serial" is a direct subtype of "device".
>>
>> This lets us build devices from components without having to make up
>> buses to connect them.  Example: "isa-serial" has a direct QOM child of
>> type "serial".  Good!
>>
>> Except infrastructure useful to such bus-less devices lives in sysbus,
>> where bus-less devices can't access it.  This tempts us to make devices
>> sysbus devices just to be able to use the infrastructure, and to create
>> additional sysbuses.
>
> There is only one sysbus -- it is impossible to create more than one,
> and there wouldn't be much point in creating a second one anyway.
>
>> We can elect to go down this path further: make more sysbus devices.
>> Create more sysbuses.  If this is the right path, then bus-less devices
>> were a mistake, and we should consider eliminating them.
>>
>> Or we can pick the other branch: put the infrastructure where bus-less
>> devices can use it.  If this is the right path, then sysbus is
>> obsolescent.
>
> I do think that at some point it would be good to move all that
> stuff into the base "device" class, and drop sysbus. The real
> problem, though, is reset. Currently reset propagates along the
> qtree (the tree of buses). So something (like TYPE_SERIAL, and
> also like CPU objects) that is a direct child of TYPE_DEVICE does
> not get automatically reset. The major overriding reason why
> (as it currently stands) I favour making things sysbus devices
> and not plain devices is that devices that don't get reset are
> either broken or need all their users to take extra steps that
> most don't take, or do in a weird way. We can't just push the
> reset handling into TYPE_DEVICE because by definition it is tied
> to "being a thing on a bus, i.e. the sysbus".
>
> Disentangling reset is extremely painful -- I don't even know
> what it ought to be doing. Maybe propagating along the QOM tree?
> So for now, we muddle along.

This suggests maybe we need a way to represent qtree in QOM. So while QOM 
devices are organised by parent-child relationship in the qom-tree they 
could have standardised properties that tell which bus they are connected 
to (or buses have properties that list devices connected to them, 
whichever is easier to walk) then the reset or info qtree could select 
devices based on these properties. Could that replace the qtree of sysbus 
devices and thus allow merging SysBusDevice into Device? There are link 
properties in QOM to connect objects so it should be possible to represent 
object relationships with such properties not just by their parent-child 
(which I think are also represented by properties but I did not check it).

Regards,
BALATON Zoltan

