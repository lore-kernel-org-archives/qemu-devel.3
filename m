Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72239D3F081
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 15:47:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl7kn-0008Fm-GS; Wed, 28 Jan 2026 10:46:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vl7kb-0008AR-4u
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 10:46:37 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vl7kX-0003kr-Ns
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 10:46:36 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C34915969F3;
 Wed, 28 Jan 2026 16:46:29 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 6l8yavbCFeT3; Wed, 28 Jan 2026 16:46:25 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id AB9BF5969F2; Wed, 28 Jan 2026 16:46:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A97305969F0;
 Wed, 28 Jan 2026 16:46:25 +0100 (CET)
Date: Wed, 28 Jan 2026 16:46:25 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Maydell <peter.maydell@linaro.org>
cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Peter Xu <peterx@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v2 00/10] Implement memory_region_new_* functions
In-Reply-To: <CAFEAcA-8-jC-HJix5YFVbmg3sEuhcSMD8gKJxzAiz=GPy0sw9Q@mail.gmail.com>
Message-ID: <b5721fa1-e613-889a-03de-77c46aa01da4@eik.bme.hu>
References: <cover.1769362313.git.balaton@eik.bme.hu>
 <CAFEAcA_jS3hef=dhxZ5s7MReSW4ir+jMUGwu+RjD_JP7ZRrRXQ@mail.gmail.com>
 <0118dc9b-d467-7f6b-92a8-4f42760ecb6c@eik.bme.hu> <aXkXWGho7lnJ-gwX@x1.local>
 <2fa59d39-5634-0b8c-27ee-9e9548a7f92a@eik.bme.hu>
 <562f0e5c-7ae8-4d95-9dd4-674447362ef7@rsg.ci.i.u-tokyo.ac.jp>
 <cfacf068-7663-6c7f-4908-928bb63e803c@eik.bme.hu>
 <CAFEAcA-8-jC-HJix5YFVbmg3sEuhcSMD8gKJxzAiz=GPy0sw9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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

On Wed, 28 Jan 2026, Peter Maydell wrote:
> On Wed, 28 Jan 2026 at 11:40, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>> OK I try to summarise the motivation again:
>>
>> 1. Documentation in docs/devel/memory.rst says that memory regions'
>> lifecycle is managed by QOM and they are freed with their owner or when
>> nothing else uses them. This is also already implemented for a long time
>> as described but cannot be used because the only constructors available
>> kill this feature when calling object_initialize that clears the free
>> function added by object_new. (The life time management is implemented
>> through adding memory regions as children to the owner and unparenting
>> them on freeing the owner which decreases ref count of the memory region
>> and will free it when nothing else references it as far as I can tell.)
>
> If we have leaks because of our very common pattern of "embed
> a MemoryRegion struct in the device state struct" then we must
> fix those, because there's no way we're going to convert all
> that existing code to a new set of APIs. But I was under the
> impression we had already dealt with those, because MRs track
> their owner's refcount, and don't have their own independent one ?

I'm not sure if all those leaks are resolved as there were some patches 
and discussion about this recently but I think that problem or the need to 
use the owner's ref count to circumwent it instead of using the memory 
region's own ref count may also come from that there's currently no way to 
allocate memory regions that are ref counted and automatically freed as it 
should work with QOM and the documentation implies. (Only the constuctor 
is missing that is all this series adds, the mechanism is already there 
and implemented.) There may still be a problem with circular references if 
the memory region needs the owner so the owner can't be freed until the 
memory region is also freed but the memory region is not freed until the 
owner is freed but if both the owner and memory region used their own ref 
count things may become a bit less confusing and could be easier to find a 
way to break circular reference (e.g. by owner unparent child regions on 
unrealize but isn't freed until memory regions unref owner in their free 
method).

>> These are my motivation for this change. What is the motivation for using
>> embedded memory regions instead and against this change?
>
> Simply that it's a consistent pattern we use in a lot of the codebase:
> the device embeds a lot of the structs it uses, rather than allocating
> memory for them and keeping pointers to that allocated memory. We

You mix in the issue of SoCs and complex devices using other devices in 
which case the recommendation was to embed those in the parent device so 
they don't have to be freed or kept track of by a pointer but won't be 
leaked. This series does not mean to change that, it's only limited to 
memory regions. (Although that problem may also stem from similar issue 
with object_initialize_child not allowing creating reference counted 
objects only initializing preallocated instances but that's not 
something this series touches.)

We can say that memory regions are like other embedded objects but they 
are often used for sysbus and PCI devices only to be registered in the 
parent device that already has pointers in their state to track these so 
there's no need to keep track of them in the subclass if we can rely on 
QOM freeing them when not needed any more and this is already implemented 
and documented that way. So even if we keep embedding other child devices 
into complex parent devices that I think does not directly apply to memory 
regions and we could use what the documentation and implementation 
already allows and says for memory regions at least.

> still have also various older device models that use the previous
> pattern of "allocate memory and have pointers" too, but most new
> code doesn't do that. I think we should for preference write code
> in one pattern, not two, and "embed structs" seems to be what
> we have mostly settled on for new code.
>
> There is an argument to be made that the pointer model would
> fit better with a possible future world of "the user can wire
> configurably wire up their own board model from devices", and
> that it works better in a part-Rust-part-C world where the two
> different languages don't have convenient access to the exact
> size of structs defined in the other language. But that future
> model is not something anybody has yet really fleshed out in any
> detail, so it's still a bit speculative.

You keep mentioning pointers but the point of ref counts and regisrering 
memory region as child of an owner is to avoid needing a pointer or 
embedding it in the subclass state as the relationship and lifecycle 
management are then handled by QOM. If we don't use that we could remove 
this from QOM and memory regions to simplify it but if it's already there 
and makes the device state simpler I think we better use it.

> I'm not actually opposed to the idea of making a design decision
> that this struct-embedding is no longer what we want to do, and defining
> that something else is our new best practice for how to write devices.
> But I think we would need to start by reaching a consensus that that
> *is* what we want to do, and documenting that "best practice" somewhere
> in docs/devel/. Then we can examine proposed new APIs and all be
> on the same page about the design patterns we want and it will
> be clearer to reviewers whether the new APIs fit into those
> patterns or not.

I think we're in that discussion now in this thread. I don't propose to 
change the struct-embedding for sub devices used in SoC or south bridge or 
other complex devices but only propose to not embed memory regions that 
are already documented as and handled by QOM and simply allocate them and 
let QOM handle them so we only need to reference them in the devices state 
unless they are needed for some reason by the device methods which is 
rarely the case. So this is limited to memory regions and the series only 
seems to add a lot of lines because of the extensive documentation 
comments. The actual change is just factoring out actual memory region 
init from memory_region_init functions then add a memory_region_new 
variant that does object_new; do_init and keep the memory_region_init do 
object_initializel do_init. Nothing else is changed, the way to manage and 
free regions based on ref counting is already there this series just 
enables them to be actually used becase currently despite what the docs 
say memory regions are either leaked or must be embedded.

Regards,
BALATON Zoltan

