Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39AC4CCD1BF
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Oct 2025 20:27:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCkpV-0004A6-Kf; Sat, 25 Oct 2025 16:25:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vCkpJ-00046v-S4; Sat, 25 Oct 2025 16:25:28 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vCkpG-0004Je-TB; Sat, 25 Oct 2025 16:25:25 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 6389D597305;
 Sat, 25 Oct 2025 22:25:19 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id B-5oo9a6-W0A; Sat, 25 Oct 2025 22:25:16 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E8D4F5972FE; Sat, 25 Oct 2025 22:25:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E61225972F3;
 Sat, 25 Oct 2025 22:25:16 +0200 (CEST)
Date: Sat, 25 Oct 2025 22:25:16 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, 
 qemu-ppc@nongnu.org, 
 =?ISO-8859-15?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v5 11/13] hw/pci-host/raven: Do not map regions in init
 method
In-Reply-To: <4dc7b5ba-176b-4e2a-876c-a911793dab13@linaro.org>
Message-ID: <b126746f-4f62-66c2-4c46-4e501f36cefe@eik.bme.hu>
References: <cover.1761232472.git.balaton@eik.bme.hu>
 <586026b62dd514cc2c4bc0a67346d9e79d13dee6.1761232473.git.balaton@eik.bme.hu>
 <809dd471-4acd-4f14-80eb-3454a365b69a@ilande.co.uk>
 <370952a5-c0a0-98db-3c05-328bf773af60@eik.bme.hu>
 <58055dac-2263-4a29-7bb6-424bb38e4ef3@eik.bme.hu>
 <4dc7b5ba-176b-4e2a-876c-a911793dab13@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1145709054-1761423916=:44805"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1145709054-1761423916=:44805
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Sat, 25 Oct 2025, Philippe Mathieu-Daudé wrote:
> On 25/10/25 16:49, BALATON Zoltan wrote:
>> Hello,
>> 
>> Added a few more people to cc hoping to get some opinion to clear this up. 
>> This is brought up by my patch trying to simplify hw/pci-host/ raven.c part 
>> of this series:
>> https://patchew.org/QEMU/cover.1761232472.git.balaton@eik.bme.hu/
>> (First submitted in May here:
>> https://patchew.org/QEMU/cover.1746374076.git.balaton@eik.bme.hu/
>> but that went relatively unnoticed and missed the previous release.)
>> Find discussion below the patch.
>> 
>> On Sat, 25 Oct 2025, BALATON Zoltan wrote:
>>> On Fri, 24 Oct 2025, Mark Cave-Ayland wrote:
>>>> On 23/10/2025 16:26, BALATON Zoltan wrote:
>>>>> Export memory regions as sysbus mmio regions and let the board code
>>>>> map them similar to how it is done in grackle. While at it rename
>>>>> raven_pcihost_realizefn to raven_pcihost_realize.
>>>>> 
>>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>> ---
>>>>>   hw/pci-host/raven.c | 38 +++++++++++++-------------------------
>>>>>   hw/ppc/prep.c       | 10 ++++++++--
>>>>>   2 files changed, 21 insertions(+), 27 deletions(-)
>
>
>>>>> @@ -180,7 +178,18 @@ static void raven_pcihost_realizefn(DeviceState *d, 
>>>>> Error **errp)
>>>>>         qdev_init_gpio_in(d, raven_change_gpio, 1);
>>>>>   +    memory_region_init(&s->pci_io, o, "pci-io", 0x3f800000);
>>>>> +    memory_region_init_io(&s->pci_discontiguous_io, o,
>>>>> +                          &raven_io_ops, &s->pci_io,
>>>>> +                          "pci-discontiguous-io", 8 * MiB);
>>>>> +    memory_region_set_enabled(&s->pci_discontiguous_io, false);
>>>>> +    memory_region_init(&s->pci_memory, o, "pci-memory", 0x3f000000);
>>>>> +
>>>>> +    sysbus_init_mmio(dev, &s->pci_io);
>>>>> +    sysbus_init_mmio(dev, &s->pci_discontiguous_io);
>>>>> +    sysbus_init_mmio(dev, &s->pci_memory);
>>>>>       sysbus_init_irq(dev, &s->irq);
>>>>> +
>>>>>       h->bus = pci_register_root_bus(d, NULL, raven_set_irq, 
>>>>> raven_map_irq,
>>>>>                                      &s->irq, &s->pci_memory, &s- 
>>>>> >pci_io, 0, 1,
>>>>>                                      TYPE_PCI_BUS);
>>>>> @@ -219,32 +228,12 @@ static void raven_pcihost_realizefn(DeviceState 
>>>>> *d, Error **errp)
>>>>>       pci_setup_iommu(h->bus, &raven_iommu_ops, s);
>>>>>   }
>>>>>   -static void raven_pcihost_initfn(Object *obj)
>>>>> -{
>>>>> -    PREPPCIState *s = RAVEN_PCI_HOST_BRIDGE(obj);
>>>>> -    MemoryRegion *address_space_mem = get_system_memory();
>>>>> -
>>>>> -    memory_region_init(&s->pci_io, obj, "pci-io", 0x3f800000);
>>>>> -    memory_region_init_io(&s->pci_discontiguous_io, obj,
>>>>> -                          &raven_io_ops, &s->pci_io,
>>>>> -                          "pci-discontiguous-io", 8 * MiB);
>>>>> -    memory_region_init(&s->pci_memory, obj, "pci-memory", 0x3f000000);
>>>>> -
>>>>> -    /* CPU address space */
>>>>> -    memory_region_add_subregion(address_space_mem, PCI_IO_BASE_ADDR,
>>>>> -                                &s->pci_io);
>>>>> -    memory_region_add_subregion_overlap(address_space_mem, 
>>>>> PCI_IO_BASE_ADDR,
>>>>> -                                        &s->pci_discontiguous_io, 1);
>>>>> -    memory_region_set_enabled(&s->pci_discontiguous_io, false);
>>>>> -    memory_region_add_subregion(address_space_mem, 0xc0000000, &s- 
>>>>> >pci_memory);
>>>>> -}
>>>>> -
>
>
>>>>> @@ -293,6 +296,9 @@ static void ibm_40p_init(MachineState *machine)
>>>>>       pcihost = SYS_BUS_DEVICE(dev);
>>>>>       object_property_add_child(qdev_get_machine(), "raven", 
>>>>> OBJECT(dev));
>>>>>       sysbus_realize_and_unref(pcihost, &error_fatal);
>>>>> +    sysbus_mmio_map(pcihost, 0, PCI_IO_BASE_ADDR);
>>>>> +    sysbus_mmio_map_overlap(pcihost, 1, PCI_IO_BASE_ADDR, 1);
>>>>> +    sysbus_mmio_map(pcihost, 2, PCI_MEM_BASE_ADDR);
>>>>>       pci_bus = PCI_BUS(qdev_get_child_bus(dev, "pci.0"));
>>>>>       if (!pci_bus) {
>>>>>           error_report("could not create PCI host controller");
>>>> 
>>>> In general the expectation is that memory regions should be initialised 
>>>> in the _init() function, unless they depend upon a property in which case 
>>>> they should be initialised in the _realize() function. Why do you feel 
>>>> this needs to be different?
>>> 
>>> Is any of it needed before realize? If not why have an init method at all? 
>>> As shown here this works perfectly without one and is more comprehensible 
>>> that way for people reading it without deep knowledge about Qdev. In 
>>> general I think simple devices only need a realize method and the init 
>>> method is rarely needed, e.g. if there are some child objects that need to 
>>> be init for passing properties that can be set before realize or similar 
>>> unusual cases but for most classes init is not needed at all. I only want 
>>> to keep what's necessary and remove everything that's not needed. I think 
>>> that makes the device model easier to understand.
>> 
>> I've checked documentation here:
>> https://www.qemu.org/docs/master/devel/qdev-api.html
>> but it's not really clear on what's the preferred way of using init and 
>> realize. It's not even very clear on when to use which to me. So becuase 
>> that did not help I did a quick survey on what other pci-host models do. Of 
>> the 32 .c files in hw/pci-host 16 have an init method:
>> 
>> aspeed_pcie.c, astro.c, designware.c, gpex.c, grackle.c, i440fx.c, 
>> pnv_phb3.c, pnv_phb3_msi.c, pnv_phb3_pbcq.c, pnv_phb4.c, q35.c, raven.c, 
>> sabre.c, uninorth.c, versatile.c, xilinx-pcie.c
>> 
>> Of these astro.c has an empty init function that should be removed; 
>> grackle.c, sabre.c and uninorth.c are maintained by you so I'll ignore them 
>> here; we're discussing raven.c now and i440fx.c has two 
>> memory_region_init_io calls in init that could be in realize where all 
>> others are and otherwise all other models do this in realize and only init 
>> child objects and add properties in init methods when that's needed because 
>> they need to be available before realize. The other 16 device models don't 
>> have an init method at all and do all in the realize like I proposed in 
>> this patch for raven. Since only device models that you maintain do it 
>> differently I think what you say is not following the preferred way so you 
>> should not block this patch.
>> 
>> I'd be interested if there is a consensus on this or can we cone to one 
>> that we can document to avoid this repeating every time.
>
> I've been told to stop arguing about QDev on the mailing list, and
> instead spend my time and energy in documenting QDev, so we'll discuss
> the documentation patches :)
>
> Also we'll try to provide a QDev meaningful state machine, which will
> help to enforce doing in the correct places.
>
>
> Meanwhile...
>
> .instance_init is actually QOM layer, it is called once, and can
> not fail. What is allocated here has to be de-allocated in 
> .instance_finalize.
>
> .realize is QDev where we check the device properties, reporting error.
> What is allocated/configured there has to be de-allocated in .unrealize.
>
> The big difference is for hot-pluggable devices, where unplug calls
> unrealize(), keeping the device initialized. Re-plug calls .realize()
> again, and we should be able to do that multiple times.
>
> With that in mind, IMO it is better to allocate all we can once in
> .instance_init().

I'd really like if simple devices could be implemented without further 
complication. I don't mind if the method is called init or realize and 
when it's called but most devices should only need one of them and not 
have to care about where each step in their init phase should go when most 
of the time they are just created once and never finalized like this one. 
For these classes having two init methods just distracts from the actual 
functionality of the class and makes it more difficult to write them and 
understand what they do. The way that a lot of classes follow currently 
that they only have realize and only need init if some properties or child 
objects providing properties need to be created before realize to be 
possible to set them is easy to understand and keeps devices simple. So is 
there an advantage for hot-pluggable devices are not deinit when they are 
unplugged or is it a big performance issue to rerun realize on re-plug? 
Given that such classes are not common I'd trade that for keeping most 
other classes simple and more easily understandable and only require 
multiple methods where really needed.

Regards,
BALATON Zoltan
--3866299591-1145709054-1761423916=:44805--

