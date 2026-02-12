Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0D9AEE36AE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 17:38:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqadB-0006c1-J3; Thu, 12 Feb 2026 12:37:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vqadA-0006bo-An
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 12:37:32 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vqad6-0000nk-SH
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 12:37:32 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D4FE85969F0;
 Thu, 12 Feb 2026 18:37:24 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 0zWBmbooAaDa; Thu, 12 Feb 2026 18:37:22 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 4D20B597383; Thu, 12 Feb 2026 18:37:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4B005597382;
 Thu, 12 Feb 2026 18:37:22 +0100 (CET)
Date: Thu, 12 Feb 2026 18:37:22 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Xu <peterx@redhat.com>
cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Gerd Hoffmann <kraxel@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 0/6] Implement memory_region_new_* functions
In-Reply-To: <aYyTtz1B2Qz3aQWA@x1.local>
Message-ID: <e3fdbd4f-df7b-0adc-06ff-4c5a25ab80cc@eik.bme.hu>
References: <cover.1770753117.git.balaton@eik.bme.hu>
 <CABgObfYpW0YMofv4O8gf4p-aWVxfvQ+BCMPsm2w+5MtD8-9s0Q@mail.gmail.com>
 <42233b06-f058-152d-645e-e16528a1640d@eik.bme.hu> <aYyTtz1B2Qz3aQWA@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_SBL=1.623 autolearn=no autolearn_force=no
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

On Wed, 11 Feb 2026, Peter Xu wrote:
> On Wed, Feb 11, 2026 at 12:47:53PM +0100, BALATON Zoltan wrote:
>> On Wed, 11 Feb 2026, Paolo Bonzini wrote:
>>> Il mar 10 feb 2026, 21:02 BALATON Zoltan <balaton@eik.bme.hu> ha scritto:
>>>
>>>> Our documentation says that memory regions are automatically freed
>>>> when the owner dies and the reference counting to do this is also
>>>> implemented. However this relies on the QOM free funtion that can only
>>>> be set by creating objects with object_new but memory API only
>>>> provides constructors that call object_initialize which clears the
>>>> free function that prevents QOM to manage the memory region lifetime.
>>>> Implement corresponding memory_region_new_* functions that do the same
>>>> as the memory_region_init_* functions but create the memory region
>>>> with object_new so the lifetime can be automatically managed by QOM as
>>>> documented. The memory_region_init functions are kept because they are
>>>> useful for memory regions embedded in other object or managed
>>>> externally and not by QOM for some reason.
>>>>
>>>
>>> I think there was pretty much agreement *not* to do this?
>>
>> Who agreed on that? So far I got concerns that this was too big (that's why
>> I split it from the clean ups to show it's not that big change, less than
>> 200 lines plus the docs but the clean ups removed as many lines as the doc
>> comments add) and others saying this should replace memory_region_init
>> altogether (that's way too much churn and not needed IMO) but no clear
>> explanation of why this was *not* needed. You as maintainer can say no but
>> then please give a justification for why and some solution to the problems
>> this tries to fix.
>
> I didn't participate much on this discussion, because I don't think I know
> well on this topic.. especially on the Rust implications, comparing to most
> of others who should be more familiar with.
>
> However, IMHO, what we really need here is a justification on "why this is
> needed", instead of requesting maintainer to say "why it's not needed"..
>
> The rational should be simple to me: by default, we change nothing.  We fix
> bugs, but that justifies itself.  If we change something else, we need to
> justify the change worthwhile (by the author of the proposal).  If we
> change a lot of things, we need serious and strong justifications.

When somebody submits a patch, the cover letter and commit messages 
describe what and why is prpoposed to be changed. I tried to do that and 
also replied to review comments trying to explain why I think the change 
would help. So I think I gave justification. If I get a reply saying that 
the proposed change is broken, won't work or breaks something then it's 
clear why it's not a good idea. If I get a reply that this would work but 
I don't think it's a good idea then I'd like to also get some explanation 
on why it's not a good idea and if there's a better solution for the 
problems that the poropsed patch tries to fix. That's where the maintainer 
should say why it's not needed.

I try to summarise the problem again briefly as it seems I did not manage 
to explain it in previous messages (or I wrote too much and people did not 
even read it). This again got a bit long but I don't know how to explain 
it better with less words.

Memory regions are registered as a child with an owner and when the owner 
is destroyed it unparents the memory region which decreases its ref count 
so it would be freed if there are no other uses of the memory region. This 
is implemented and documented like that but there's currently no way to 
actually create a memory region that would be managed and freed by QOM 
that way and a memory region created with memory_region_init would never 
be freed and the code to manage memory region lifecycle is effectively 
dead. Because of this we have all sorts of hacks to solve problems that 
arise from this such as memory_region_ref/unref not using the ref count of 
the memory region itself but the ref count of the owner and we embed 
memory regions in devices to avoid leaking them.

My immediate motivation was trying to keep device models simple and avoid 
any additional state or boiler plate code as much as possible because I 
think simple device models are easier to write and easier to find bugs in 
if boiler plate code is not obscuring the actual device functionality. 
Therefore the less additional lines we have to add to a device model is 
the better. A typical example is a memory region of a sysbus or PCI device 
where this would be created with the device and registered via 
sysbus_init_mmio or pci_register_bar. The SysBusDevice state has 
mmio[QDEV_MAX_MMIO] with a MemoryRegion *memory pointer in it and 
PCIDevice has PCIIORegion io_regions[PCI_NUM_REGIONS] where PCIIORegion 
has MemoryRegion *memory so the subclass should not need to store or embed 
these memory regions as QOM should be able to store and manage it. All 
that should be needed in the device model is to define memory ops, create 
the memory region and register it with the superclass and forget about it. 
Reading the documentation of memory regions I was under the impression it 
also works like that but when trying to create such memory regions I was 
told this would leak. Then I looked at why.

I've found that QOM lifecycle management relies on a free function that is 
set by object_new so anything not created with object_new won't be freed. 
QOM has two ways to create objects: object_new and object_initialize 
(latter of which zeroes the free function so this will never be freed by 
QOM) and there's no way to set a free function any other way. The 
memory_region_init* functions call object_initialze so they cannot create 
regions that QOM will manage. To understand this better look at: 
system/memory.c::memory_region_init(), qom/object.c::object_finalize(), 
qom/object.c::object_new() and qom/object.c::object_initialize_with_type() 
(note the memset in object_initialize_with_type).

There are two possible ways to fix this: remove object_initialize from 
memory_region_init so callers could do object_new; memory_region_init or 
object_initialize; memory_region_init or add corresponding 
memory_region_new functions. The latter seems to be less churn and more 
convenient to use so that's what this series does.

With this series we can have

struct SiI3112PCIState {
     PCIIDEState i;

     SiI3112Regs regs[2];
};

instead of

struct SiI3112PCIState {
     PCIIDEState i;

     MemoryRegion mmio;
     MemoryRegion bar0;
     MemoryRegion bar1;
     MemoryRegion bar2;
     MemoryRegion bar3;
     MemoryRegion bar4;
     SiI3112Regs regs[2];
};

or drop an unneeded field from PCIHostState as proposed here:

https://patchew.org/QEMU/cover.1761232472.git.balaton@eik.bme.hu/797587b52159d2db79ed924b4962be7e7ba84207.1761232472.git.balaton@eik.bme.hu/

and several similar simplifications in a lot of devices, that would be 
done as follow up patches not all in this series.

We may also be able to untangle memory_region_ref/unref and just use 
object_ref/unref with memory regions that would be more regular QOM usage 
and may be simpler to follow than the current way of piggy-backing on the 
owner which recently was also found to have some issues.

> At least I didn't see any Rust mentioned in this cover letter explaining
> why we need this change.  I also don't know if the "documentation" issue is
> a major flaw to introduce these whole set of new APIs.  For example, could
> we fix the doc instead if it is flawed?

I don't know if this helps Rust or not, that wasn't brought up by me but I 
guess making memory regions normally managed QOM objects would fit more 
with what Rust expects or can handle than the current way of embedding or 
strangely ref counting regions. As described above the main motivation is 
not to fix documentation but to make it possible to use memory regions as 
documented and intended to avoid some hacks that I think arise from not 
being able to create normal ref counted memory regions that would be freed 
by QOM.

If you think the above is not a problem or this is not the right solution 
for it then I'd like to see a justification on why and what would be a 
better solution. So far I got that it might be that people did not get why 
it is a problem and it works good enough as it is so best not touch it but 
I think the porposed change is simple enough and would allow removing some 
hacks so allow simplifying code and as it does not touch existing 
memory_region_init functions it would also not break anything. Again if 
this was not clear above the series does not add any new way of managing 
memory regions, that's already implemented and always was, this just adds 
the functions that allow it to be used.

Regards,
BALATON Zoltan

