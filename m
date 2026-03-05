Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D61DBF30920
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 09:26:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy4xy-00036q-Sx; Thu, 05 Mar 2026 04:25:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1vy4xu-00035w-Hl; Thu, 05 Mar 2026 04:25:55 -0500
Received: from oxygen.pond.sub.org ([2a01:4f8:13b:3ad0:1::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1vy4xs-0002F1-9i; Thu, 05 Mar 2026 04:25:54 -0500
Received: from blackfin.pond.sub.org (p50902e3b.dip0.t-ipconnect.de
 [80.144.46.59])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by oxygen.pond.sub.org (Postfix) with ESMTPSA id B31B22487B;
 Thu, 05 Mar 2026 10:29:14 +0100 (CET)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4691721E6A04; Thu, 05 Mar 2026 10:25:43 +0100 (CET)
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Bernhard Beschow <shentey@gmail.com>,  qemu-devel@nongnu.org,  Helge
 Deller <deller@gmx.de>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Steven Lee <steven_lee@aspeedtech.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@kaod.org>, Troy Lee <leetroy@gmail.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Mark Cave-Ayland
 <mark.caveayland@nutanix.com>,  qemu-arm@nongnu.org,  Jamin Lin
 <jamin_lin@aspeedtech.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,  "Michael S. Tsirkin"
 <mst@redhat.com>,  Andrew Jeffery <andrew@codeconstruct.com.au>,  Joel
 Stanley <joel@jms.id.au>
Subject: Re: QOM parent type "sys-bus-device" vs. "device"
In-Reply-To: <CAFEAcA_WYkAYccog-BiA6MJAvoFVwa6niKvFZ7UpLjzkRyd6aA@mail.gmail.com>
 (Peter Maydell's message of "Wed, 4 Mar 2026 13:54:07 +0000")
References: <20260303222143.142741-1-shentey@gmail.com>
 <20260303222143.142741-13-shentey@gmail.com>
 <87ikbbixy5.fsf_-_@pond.sub.org>
 <CAFEAcA_WYkAYccog-BiA6MJAvoFVwa6niKvFZ7UpLjzkRyd6aA@mail.gmail.com>
Date: Thu, 05 Mar 2026 10:25:43 +0100
Message-ID: <87fr6eocfc.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2a01:4f8:13b:3ad0:1::3;
 envelope-from=armbru@pond.sub.org; helo=oxygen.pond.sub.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Markus Armbruster <armbru@redhat.com>
From:  Markus Armbruster via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Peter Maydell <peter.maydell@linaro.org> writes:

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

I was almost entirely mistaken there.  However, you're not quite right,
either :)

We *can* create more than one system bus, and we in fact do: abstract
PCI device "macio" contains a "macio-bus", which is a subtype of the
system bus type.  Its concrete subtypes are "macio-oldworld" and
"macio-newworld".  To see the "macio-bus" in "info qtree", try machine
"g3beige".

But this is the rare exception.  The rule is us doing something
differently undesirable.

Consider ARM machine "ast2700fc".  Its core are three devices:
"ast2700-a2", "aspeed27x0ssp-coprocessor", and
"aspeed27x0tsp-coprocessor".  All three contain component devices.  The
QOM composition tree shows them as "/machine/ca35", "/machine/ssp", and
"/machine/tsp", i.e. they are direct children of the machine object.

Here's a closer look at a small part of the composition tree:

    /machine (ast2700fc-machine)
      [...]
      /ca35 (ast2700-a2)
        [...]
        /ioexp[0] (aspeed.ast1700)
          [...]
          /uart (serial-mm)
            /serial (serial)
            /serial[0] (memory-region)

I'll refer back to this later.

A few components end up in the "/machine/unattached" orphanage instead
due to sloppy modelling.

My point is: the QOM composition tree actually reflects how devices are
built from components, except for the parts where we got sloppy, which
should be fixable.

The qtree (the thing shown by "info qtree") shows a different picture.
The three core devices are bus-less, and therefore not in the qtree.
Their components, however, are mostly sysbus devices, and therefore in
the qtree right under the root.  Here are the parts of the qtree that
correspond to the QOM composition tree snippet above:

bus: main-system-bus
  type System
  [...]
  dev: serial-mm, id ""
    gpio-out "sysbus-irq" 1
    regshift = 2 (0x2)
    endianness = 2 (0x2)
    mmio ffffffffffffffff/0000000000000020
  dev: aspeed.ast1700, id ""
    board-idx = 0 (0x0)
    silicon-rev = 100794627 (0x6020103)
    dram = "/machine/ca35/ca35-dram[0]"
    mmio 0000000030000000/0000000001000000

The "aspeed.ast1700" and its "serial-mm" component are siblings.  The
latter's "serial" component is bus-less, and therefore not in the qtree.
Bernhard's patches make it a sysbus device instead, and therefore add it
to the qtree as another sibling.

My point is: the qtree does not reflect how devices are built from
components / are wired together, at least not where sysbus devices are
involved.

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
> qtree (the tree of buses).

Unfortunately, the qtree is far removed from reality for sysbus devices.

Case in point: "aspeed.ast1700" and its component "serial-mm" are
siblings in the qtree.  In what order will they be reset?

Physical hardware has reset lines.  Devices generally wire up their
components' reset pins to their own.  I believe the sane way to model
this is a reset tree.

>                            So something (like TYPE_SERIAL, and
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

I think this would make more sense.  Unlike the qtree, the QOM
composition tree contains all devices, and reflects the actual
composition.  It's certainly closer to the real reset tree than the
qtree is.  Is it close enough?  I don't know.  If yes, there's our reset
tree.  If no, I guess we could still use it as a base, with manually
corrected reset lines where the QOM composition tree is off.

> So for now, we muddle along.
>
> -- PMM

