Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99718C54798
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 00:31:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf7qZ-0004TW-Js; Tue, 27 Feb 2024 19:30:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rf7qX-0004Sv-7V
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 19:30:53 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rf7qU-0005zh-Fs
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 19:30:52 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 5C77B4E6012;
 Wed, 28 Feb 2024 01:30:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id mXgkOmN4jWrI; Wed, 28 Feb 2024 01:30:45 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 4A1CF4E6005; Wed, 28 Feb 2024 01:30:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 44B257456B4;
 Wed, 28 Feb 2024 01:30:45 +0100 (CET)
Date: Wed, 28 Feb 2024 01:30:45 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?ISO-8859-15?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>
Subject: Re: [PATCH 3/5] hw/isa: Embed TYPE_PORT92 in south bridges used in
 PC machines
In-Reply-To: <241AE060-27EF-4A36-92C8-7563256273A9@gmail.com>
Message-ID: <e2299f9a-47bb-48a1-84fb-85f171c4e480@eik.bme.hu>
References: <20240218131701.91132-1-shentey@gmail.com>
 <20240218131701.91132-4-shentey@gmail.com>
 <6a2333d7-9dea-4a0e-9d91-0889e6205128@ilande.co.uk>
 <F3980E89-7FE5-443A-9287-DB0350B159D9@gmail.com>
 <f25bdf58-2fc0-9f04-ef6c-c8d1cff02405@eik.bme.hu>
 <241AE060-27EF-4A36-92C8-7563256273A9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 27 Feb 2024, Bernhard Beschow wrote:
> Am 27. Februar 2024 21:54:19 UTC schrieb BALATON Zoltan <balaton@eik.bme.hu>:
>> On Tue, 27 Feb 2024, Bernhard Beschow wrote:
>>> Am 21. Februar 2024 11:53:21 UTC schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:
>>>> On 18/02/2024 13:16, Bernhard Beschow wrote:
>>>>> Port 92 is an integral part of the PIIX and ICH south bridges, so instantiate it
>>>>> there. The isapc machine now needs to instantiate it explicitly, analoguous to
>>>>> the RTC.
>>>>>
>>>>> Note that due to migration compatibility, port92 is optional in the south
>>>>> bridges. It is always instantiated the isapc machine for simplicity.
>>>>>
>>>>> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
>>>>> ---
>>>>>   include/hw/i386/pc.h          |  2 +-
>>>>>   include/hw/southbridge/ich9.h |  4 ++++
>>>>>   include/hw/southbridge/piix.h |  3 +++
>>>>>   hw/i386/pc.c                  | 18 ++++++++++++------
>>>>>   hw/i386/pc_piix.c             |  9 +++++++--
>>>>>   hw/i386/pc_q35.c              |  8 +++++---
>>>>>   hw/isa/lpc_ich9.c             |  9 +++++++++
>>>>>   hw/isa/piix.c                 |  9 +++++++++
>>>>>   hw/isa/Kconfig                |  2 ++
>>>>>   9 files changed, 52 insertions(+), 12 deletions(-)
>>>>
>>>> I had a look at this (and did a bit of revision around 8042 and A20), and I am starting to wonder if the PORT92 device isn't something that belongs to the southbridge, but more specifically to the superio chip?
>>>
>>> If there is agreement to model real hardware in QEMU, then I think that
>>
>> I think there's no such agreement and QEMU is more lax about it both for historical reasons and to simplify machine models. Indeed, QEMU sometimes models non-existing machines (e.g. the mac99 or virt boards) that don't correspond to real hardware but allow guest OSes to boot. Even when modelllng real hardware it's ofren modelled just enough for guests to work and unused details are omitted for simplicity. It is recommended to follow what real hardware does when modelling real hardware but not always required. Although it might help both with verifying a device model and to compose machines with these models to try to follow the real hardware.
>
> Composing real machines and verifying device models is exactly what I'm 
> after. I'm aware that QEMU provides virt machines such as the microvm, 
> and from the context I didn't refer to these.

Even without pure virt machines currently a lot of QEMU machines don't 
exactly model real hardware. They may roughly follow real hardware but not 
exactly such as mac99 is a non-existent Mac and the pc machines also use 
some parts that don't exist in real life such as PIIX4-PIIX3 hybrid you've 
been working on resolving. Some of these however are restricted by 
backward compatibilty requirements. But you probably aware of all of that 
but this means the argument that real hardware should be followed is not 
enough. At least it should not break backward compatibility too much and 
that's more important than exactly modelling real machine. Also having a 
simple model may be more important than modeling every detail even when 
not used just to follow real hardware.

>>> port 92 belongs into any device model where the hardware has one. All our PC-like southbridges (PIIX, ICH, VIA) have port 92. Many FDC37xxxx including the FDC37M81x as used in the Malta board have one, too -- where it must first be enabled.
>>
>> So port92 is not a real hardware but a QEMU abstraction or model of some functionality found in some machines. Real chips probably implement this in different ways so we could either model this in these chips independently the same way as real hardware does or use the abstracted model anywhere in our machine model. Since this does not exist in real hardware as this abstract model it also does not belong anywhere so we are free to put it where it's most convenient or simple to do.
>
> As mentioned already, port 92 is an integral part of PIIX, ICH, and VIA 
> southbridges.

Mark argued that more specifically it's part of the superio within those 
couthbridges. That makes sense, considering this port92 is related to 
functionality that was in the keyboard contorller before which is part of 
the superio. I don't know PC hardware too well but reading about this fast 
gate A20 feature looks like original PC and XT had only a 1 MB address 
space but addresses above 1 MB wrapped to 0 and some software depended on 
that. Then AT added more memory but then it needed a way to control if 
addresses above 1 MB would wrap or access high memory. This was done with 
some free part of the keyboard controller but that was too slow so an 
alternative fast way was added with this port92 device. But then the old 
keyboard controller and this port92 stuff are interacting so may need to 
consider both. Apart from that all of this is not relevant to other 
machines that don't use this functionality.

QEMU decided to model it as a separate QOM object that is now instantiated 
by the machines that use it. This is not real hardware but a QEMU 
implementation detail. What's wrong with that? It seems you just want to 
simplify the pc machine creation and push this object that does not 
correspond to some real hardware somewhere else. But this belongs nowhere 
as it does not model a real hardware.

> That's why I want to move it there. My goal is to create 
> different PC machines in a data-driven manner which model real boards. I 
> want to see how low-level guests interact with the hardware, including 
> e.g. how they set up the memory map.

Then I think the port92 as a QOM object should be gone completely and 
implemented separately in south bridges beacause in real machine there's 
no such port 92 thing, only a south briege so if you need to create port92 
in a data driver machine description then that's not modeling real 
hardware but reflects QEMU implementation of it. However the QOM object 
could be retained as an internal object whithn the device model if that 
makes it model simpler or helps code reuse. I'm not convinced about that 
but I also don't care enough to mind if it will still be there somewhere 
outside of the VIA model. What I care about is that I don't want 
unneccesary things in the VIA model and want to keep it simple.

>>>> A couple of thoughts as to why I came to this conclusion: firstly the superio chip is generally considered to be a single integrated implementation of legacy IO devices, so this feels like a natural home for the PORT92 device.
>>>
>>>> Secondly the value of the "has-port92" property is controlled by pcms->i8042_enabled, and this value is already passed into functions such as pc_superio_init() for example.
>>>
>>> Rhight. There, it also controls the presence of port 92. If we move port 92 into the southbridges, we have to respect this command line switch there to preserve backward compatibility.
>>>
>>> I wonder what `-M i8042` is supposed to do. If it is for modeling a stripped-down x86 system, why not use the microvm instead? How is it possible to omit an essential piece of hardware needed to boot x86 systems? Don't we need at least either one (i8042 or port 92)?
>>
>> Try git log -p 4ccd5fe22fe (found it via git blame and see what added that property).
>
> Alright, the intention was to omit the PS/2 controller in favor of USB. 
> That doesn't mean that port 92 needs to be affected. I see an 
> opportunity here to reduce the scope of the i8042 option which may help 
> with data-driven machine creation in the future.
>
>>
>>>> I think this would also help reduce the changes required for the individual machines, however the devil is always in the details particularly when migration is involved.
>>>
>>> As stated above, this series is more about modeling real hardware, in the hope that this will lend itself for configuration-driven machine creation. It is also about identifying obstacles towards this goal. Does it make sense to deprecate some machine-specific options such as i8042?
>>
>> Only if you want to break downsteam users of those options but maybe they won't be happy about that.
>
> I don't want to break downstream users of course.
>
> I want device models true to the original. I think that this series is a 
> step in this direction, hence I'd like feedback for achieving that. 
> What's necessary to get this series in?

I think you got feedback. My proposal was to remove port92 object and 
implemnt it in the south bridges instead independently but you did not 
like that because wanted to keep it at a central place and maybe also 
migration compatibility is simpler if it's kept (although I think that can 
be solved by some compatibility function in the machine the same way as 
optional sections or changes in migration format are handled on the 
receving side where it could set a property on some object exporting the 
state of this register).

Then Mark proposed to move it down into superio which is used by all these 
southbridges and it also contains the keyboard controller which this 
might interact with so that seems like a good place to put it (either 
instantiating the port92 object there or implementing it directly). As 
long as this keeps it out from VIA and does not need too much QOM wizardry 
in the VIA model (more than maybe forwarding a property for this), I'm 
happy with that so I think you could try that unless you see some problem 
with this approach.

Now if you also want to change the keyboard controller too, maybe port92 
handling could also be implemented there instead of the superio as an 
optional part that machines that need it can enable. But all this will 
probably result in that either the pc machine will need to dig down to 
find this part or have a chain of property forwarding through superio and 
south bridge models that would complicate those models which may be uglier 
than what we have now to just instantiate the port92 object in the pc 
machine and leave the other models that don't need it without this 
complication.

Regards,
BALATON Zoltan

