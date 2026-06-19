Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B50DCD98F2
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 20:01:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wafOE-00013H-4k; Fri, 19 Jun 2026 16:00:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wafOB-000132-SU
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 16:00:32 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wafO9-0001FQ-BK
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 16:00:31 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id DBFD159694F;
 Fri, 19 Jun 2026 22:00:25 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 7EdzfkSgkOPA; Fri, 19 Jun 2026 22:00:22 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 44D9E596944; Fri, 19 Jun 2026 22:00:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 425F8596941;
 Fri, 19 Jun 2026 22:00:22 +0200 (CEST)
Date: Fri, 19 Jun 2026 22:00:22 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Paolo Bonzini <pbonzini@redhat.com>
cc: =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@mailo.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Peter Xu <peterx@redhat.com>, 
 =?ISO-8859-15?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>, 
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Aurelien Jarno <aurelien@aurel32.net>, Fabiano Rosas <farosas@suse.de>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
Subject: Re: [RFC 4/7] system: add memory_region_new / memory_region_new_io
In-Reply-To: <78798c63-5ca9-4acc-a878-8638724d487c@redhat.com>
Message-ID: <3ad6b24d-5554-ab58-2d8a-ea5e3a07be35@eik.bme.hu>
References: <20260616155554.264412-1-berrange@redhat.com>
 <20260616155554.264412-5-berrange@redhat.com>
 <aa4d417e-2e61-44ef-a695-31bc19dbafd1@redhat.com>
 <9976f829-7c33-7dce-b38e-aa6f04d6ec9d@eik.bme.hu>
 <78798c63-5ca9-4acc-a878-8638724d487c@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-997753258-1781899222=:46357"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-997753258-1781899222=:46357
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 19 Jun 2026, Paolo Bonzini wrote:
> On 6/18/26 00:44, BALATON Zoltan wrote:
>> On Wed, 17 Jun 2026, Paolo Bonzini wrote:
>>> On 6/16/26 17:55, Daniel P. Berrangé wrote:
>>>> Prepare for the move to dynamically allocated memory regions by
>>>> introducing memory_region_new and memory_region_new_io functions
>>>> which call through to object_new instead of object_initialize.
>>> 
>>> MemoryRegionOps callback will certainly access fields in the parent. 
>>> Having a separate object gives you no benefit because you still have the 
>>> same use-after-free if the MemoryRegion outlives the device.  Likewise for 
>>> buses.
>>> 
>>> If the device itself is embedded, then all the invariants must hold 
>>> recursively:
>>> 
>>> - the device must be kept alive by mutual references between the device 
>>> itself and its parent;
>>> 
>>> - unparent for the device should wait for all guest memory accesses to be 
>>> either completed or cancelled.
>>> 
>>> So, the problem is that "QEMU automatically references the owning Device 
>>> to keep the MemoryRegion alive" is a hack that should die.
>>> [...] I disagree that removing embedding will fix any bugs
>> 
>> I'm trying to understand this better. The way it originally meant to work 
>> according to the memory region docs and implementation is that memory 
>> region is added to an owner as a child which takes a reference and when the 
>> owner is freed it will unparent its children which will then get unrefed 
>> and freed as well if nothing else increased their ref count.
>
> Yes, and that's broken.

Your replies are too brief to understand what you mean so I have to keep 
guessing. What breakage do you mean? The idea itself is not broken and 
would work and can be fixed to work as intended. It's just not working 
currently because memory regions are not allocated in a way that ref 
counting could free them. That's broken in QEMU currently but the 
above described way is not fundamentally broken. Or do you mean something 
else?

>> The problem is that when something accesses the memory region it has to 
>> keep the owner alive as well so instead of referencing the memory region it 
>> references the owner (not directly but using memory_region_ref which does 
>> this).
>
> A mechanism to keep the owner alive exists, and it is mutual references (so 
> that neither owner nor MR die) + unparent of owner (which should wait for 
> pending users to complete before returning).
>
> The fact that this mechanism is not used, i.e. unparent of a PCIDevice does 
> not wait for pending BAR accesses to complete, is a bug.

I don't know this part but I think ref counting is meant to be the way to 
track if there are pending accesses. How else would PCI code know if there 
are pending accesses from other unrelated parts of QEMU? I don't think PCI 
code could track all accesses itself which may come from a CPU or another 
device doing DMA. Even after registering as a BAR a memory region is just 
used as any other memory region so the PCI code does not know what 
accesses it without some tracking such as ref counts.

I think the current way of passing reference to the owner could work for a 
chain of owners too. All that would be needed is to add an owner field to 
QOM object and if that is non-NULL ref/unref is passed to the owner. I.e. 
just generalising what memory_region_ref/unref does. (Or do this for all 
prarent/child where children increase their parents' ref when they get a 
ref, but I'm not sure what exactly parent/child stands for in QOM so a 
separate owner relation may be needed as parent/child may be for 
qom-tree or not even well defined.)

>> So embedding seems unrelated to this passing refs on
>> memory regions to owner and could be fixed separately that my patches 
>> attempted.
>
> Your patches add the possibility of not embedding; I don't like having two 
> separate API, but I think we only have a disagreement on aesthetics.

OK so at least we've arrived at that there's no other problem than 
aesthetics. It's hard to argue about that but QOM already has two ways. 
From https://www.qemu.org/docs/master/devel/qom-api.html#qom-api

object_new:
This function will initialize a new object using heap allocated memory. 
The returned object has a reference count of 1, and will be freed when the 
last reference is dropped.

object_initialize:
This function will initialize an object. The memory for the object should 
have already been allocated. The returned object has a reference count of 
1, and will be finalized when the last reference is dropped.

So we should have corresponding API for memory_region too to support both 
allocated memory regions and ones managed by some other way. Currently the 
memory region API does not allow QOM managed memory regions so we're 
causing ourselves problems having to somehow manage the lifetime of these 
memory regions instead of just relying on the solution QOM already 
provides for this. Having both APIs would be consistent with QOM and allow 
to chose the way that fits each case better. I don't want to convert 
everything to object_new but I want to be able to allocate memory regions 
that are then managed by QOM so I can avoid the complexity of keeping 
track and managing them separately when this is already there and would 
work well for a lot of cases.

> This is different for Daniel's patches, which try to fix something by not 
> embedding, and I don't think they do.  Currently, if the owner dies, the 
> MemoryRegion dies with it while it shouldn't (which is a problem, 
> absolutely).  But these patches, while preventing the MR from dying, still 
> leave around a dangling pointer to the owner from the MR, so there's not much 
> gained if anything.

I'm not sure I understand all the problems but I don't think embedding 
solves anything other than not leaking memory regions that QOM does not 
free due to using object_initialize which means you're on your own 
managing your storage. I think a solution could be passing refs up in a 
chain of owners as I described above which is unrelated to embedding. This 
way works for a single owner with memory_region_ref/unref and could work 
for multiple owners while keeping the memory regions and owners separate 
objects. I'm not sure what you have in mind but if you say that owners 
would have to embed their children that alone does not solve that they are 
still separate objects and have to be finalized separately so we still 
need ref counting to know how long to keep alive owners when one of the 
children is accessed. Embedding does not solve that and just unnecessarily 
ties storage of separte objects together but we still need to fix ref 
counting and then we can also use that to free objects when no more 
references are there so we also don't need to embed them but keeping both 
_new and _init APIs would allow to chose either way whichever fits a 
given problem.

Regards.
BALATON Zoltan
--3866299591-997753258-1781899222=:46357--

