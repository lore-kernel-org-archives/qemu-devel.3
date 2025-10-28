Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16FABCCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 21:30:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDrEu-00068p-La; Tue, 28 Oct 2025 17:28:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vDrEs-00068J-DY; Tue, 28 Oct 2025 17:28:22 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vDrEm-0005D6-VF; Tue, 28 Oct 2025 17:28:22 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A80D75972FD;
 Tue, 28 Oct 2025 22:28:03 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id o50hu3AVEoAW; Tue, 28 Oct 2025 22:28:01 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 2EB9F5972E3; Tue, 28 Oct 2025 22:28:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2C01F5972E9;
 Tue, 28 Oct 2025 22:28:01 +0100 (CET)
Date: Tue, 28 Oct 2025 22:28:01 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
cc: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [PATCH 2/4] hw/pci-host/articia: Map PCI memory windows in realize
In-Reply-To: <802b77f2-2c23-4b5a-a739-d56b09c335de@rsg.ci.i.u-tokyo.ac.jp>
Message-ID: <28c6f065-ba8d-e5e2-922e-d5fd1fb58b60@eik.bme.hu>
References: <cover.1761346145.git.balaton@eik.bme.hu>
 <ceda4c28887c40e1c8eae3f561ee381ca98b0484.1761346145.git.balaton@eik.bme.hu>
 <7747275c-8e0a-4983-8613-fc39fc03bb39@linaro.org>
 <87b009e6-0d51-7409-61ad-dd65582eb13e@eik.bme.hu>
 <d23d5106-645c-466f-86e1-30ce20cc61d3@linaro.org>
 <dbdbc78f-3d4b-c0b2-87ac-85e24568a115@eik.bme.hu>
 <802b77f2-2c23-4b5a-a739-d56b09c335de@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-2050017950-1761686881=:49727"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--3866299591-2050017950-1761686881=:49727
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 29 Oct 2025, Akihiko Odaki wrote:
> On 2025/10/28 21:59, BALATON Zoltan wrote:
>> On Tue, 28 Oct 2025, Philippe Mathieu-Daudé wrote:
>>> On 27/10/25 20:47, BALATON Zoltan wrote:
>>>> On Mon, 27 Oct 2025, Philippe Mathieu-Daudé wrote:
>>>>> On 25/10/25 01:31, BALATON Zoltan wrote:
>>>>>> These memory windows are a result of the address decoding in the
>>>>>> Articia S north bridge so better model it there and not in board code.
>>>>>> 
>>>>>> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>>>> ---
>>>>>>   hw/pci-host/articia.c | 15 ++++++++++++++-
>>>>>>   hw/ppc/amigaone.c     | 28 +++++-----------------------
>>>>>>   hw/ppc/pegasos2.c     | 13 -------------
>>>>>>   3 files changed, 19 insertions(+), 37 deletions(-)
>>>>> 
>>>>> 
>>>>>> @@ -169,6 +174,7 @@ static void articia_realize(DeviceState *dev, Error 
>>>>>> **errp)
>>>>>>   {
>>>>>>       ArticiaState *s = ARTICIA(dev);
>>>>>>       PCIHostState *h = PCI_HOST_BRIDGE(dev);
>>>>>> +    MemoryRegion *mr;
>>>>>>       PCIDevice *pdev;
>>>>>>         bitbang_i2c_init(&s->smbus, i2c_init_bus(dev, "smbus"));
>>>>>> @@ -180,6 +186,14 @@ static void articia_realize(DeviceState *dev, 
>>>>>> Error **errp)
>>>>>>       memory_region_init_io(&s->reg, OBJECT(s), &articia_reg_ops, s,
>>>>>>                             TYPE_ARTICIA, 0x1000000);
>>>>>>       memory_region_add_subregion_overlap(&s->reg, 0, &s->io, 1);
>>>>>> +    mr = g_new(MemoryRegion, 1);
>>>>> 
>>>>> Won't Coverity or other analysis tools complain about the leak?
>>>>> (this is why we usually keep a reference in the device state, here
>>>>> ArticiaState). Otherwise:
>>>> 
>>>> According to https://www.qemu.org/docs/master/devel/ memory.html#region- 
>>>> lifecycle
>>>> there should be no leak and keeping a reference should not be necessary 
>>>> as the lifetime is managed by attaching it to the owner object so no need 
>>>> to keep a reference when it's not needed otherwise. Not littering the 
>>>> state struct with unneded references makes it easier to comprehend so I'd 
>>>> only keep things there that are necessary.
>>> 
>>> IIUC this doc is about what happens within the allocated MemoryRegion,
>>> regardless of where it is allocated.
>> 
>> That doc explicitely says:
>> 
>> "Destruction of a memory region happens automatically when the owner object 
>> dies. When there are multiple memory regions under the same owner object, 
>> the memory API will guarantee all memory regions will be properly detached 
>> and finalized one by one. The order in which memory regions will be 
>> finalized is not guaranteed."
>
> Destruction in this context does not imply freeing the storage.
>
> The documentation describes destruction in QOM. QOM performs the following 
> steps during destruction:
> 1. Delete properties
> 2. Call finalization callbacks
> 3. Free the storage
>
> However, 3 will not happen in this case since you allocate the storage by 
> yourself and it is not managed by QOM.
>
> Please also note that the documentation also says:
>> If however the memory region is part of a dynamically allocated data
>> structure, you should free the memory region in the instance_finalize
>> callback.  For an example see VFIOMSIXInfo and VFIOQuirk in
>> hw/vfio/pci.c.

So the problem is probably using g_new() to allocate it. Maybe this should 
be object_new() instead? I was trying to figure out how this should work 
but not sure I understand everything. It looks like as long as the mr has 
a name, memory_region_init() will add the mr as a child property to the 
owner and unref it so the reference will be passed to the owner which will 
own this mr after that. On destructing the owner it will delete all its 
properties which should dereference the memory region so it would be freed 
then if it had a free function set but it seems allocating with g_new and 
init-ing the region with memory_region_init() won't set the free function. 
Only way to set that seems to be object_new() but that also inits the 
object so maybe using it would double init the mr or add an extra 
reference so that may also not work. The extra ref could be solved by 
unref'ing after memory_region_init() but double init seems to be 
unnecessary. Maybe we need a memory_region_new_* set of functions or 
simpler than that an object_alloc() that allocates the object without
init it that could be used in this case when init is done by other 
function like memory_region_init in this case?

>> (and these pci-host objects are created once at machine init and never die 
>> so the question seems quite theoretical). I'd like to keep object state 
>> simple and not keep around references in it that nothing uses and should be 
>> managed automatically. I'd only add fields to the state struct that other 
>> methods need.
>
> It is indeed theoretical. That said, I prefer the memory region to be 
> embedded into the device state struct as it will clarify that the lifetime of 
> the memory region is bound to the device.

But that way a lot of otherwise not needed fields would make the state 
struct more crowded and harder to see what's actually used there. Maybe 
this could be remedied by grouping these at the end below a comment but if 
ref counting worked as the docs state it this should not be necessary.

Before my cleanup the state strcut in raven.c looked like this:

struct PRePPCIState {
     PCIHostState parent_obj;

     OrIRQState *or_irq;
     qemu_irq pci_irqs[PCI_NUM_PINS];
     PCIBus pci_bus;
     AddressSpace pci_io_as;
     MemoryRegion pci_io;
     MemoryRegion pci_io_non_contiguous;
     MemoryRegion pci_memory;
     MemoryRegion pci_intack;
     MemoryRegion bm;
     MemoryRegion bm_ram_alias;
     MemoryRegion bm_pci_memory_alias;
     AddressSpace bm_as;
     RavenPCIState pci_dev;

     int contiguous_map;
};

which would become this after this series:

struct PREPPCIState {
     PCIHostState parent_obj;

     qemu_irq irq;
     MemoryRegion pci_io;
     MemoryRegion pci_discontiguous_io;
     MemoryRegion pci_memory;
     MemoryRegion pci_intack;
     AddressSpace bm_as;
};

if we don't have to keep regions we don't use after realize so those can 
be managed by QOM which is much more readable and comprehensible to me.

(Unrelated question but I'm still not sure what the bm_as is for. This 
seems to be present in some pci-hosts and may be needed for bus master 
cards but I just carried it over to my devices as a cargo cult without 
really getting why is it needed and why is it needed here and not in 
PCIHostState. Is there any explanation on that somewhere?)

Regards,
BALATON Zoltan
--3866299591-2050017950-1761686881=:49727--

