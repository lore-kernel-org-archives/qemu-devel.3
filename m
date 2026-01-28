Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38DFFD25B47
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 11:41:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl3up-0000yg-Q8; Wed, 28 Jan 2026 06:40:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vl3uk-0000tm-E2
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 06:40:51 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vl3ue-0007YO-9c
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 06:40:48 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D2707596A10;
 Wed, 28 Jan 2026 12:40:39 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 2JfOGDtp-yEm; Wed, 28 Jan 2026 12:40:37 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 518495969F3; Wed, 28 Jan 2026 12:40:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4E8465969F0;
 Wed, 28 Jan 2026 12:40:37 +0100 (CET)
Date: Wed, 28 Jan 2026 12:40:37 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
cc: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v2 00/10] Implement memory_region_new_* functions
In-Reply-To: <562f0e5c-7ae8-4d95-9dd4-674447362ef7@rsg.ci.i.u-tokyo.ac.jp>
Message-ID: <cfacf068-7663-6c7f-4908-928bb63e803c@eik.bme.hu>
References: <cover.1769362313.git.balaton@eik.bme.hu>
 <CAFEAcA_jS3hef=dhxZ5s7MReSW4ir+jMUGwu+RjD_JP7ZRrRXQ@mail.gmail.com>
 <0118dc9b-d467-7f6b-92a8-4f42760ecb6c@eik.bme.hu> <aXkXWGho7lnJ-gwX@x1.local>
 <2fa59d39-5634-0b8c-27ee-9e9548a7f92a@eik.bme.hu>
 <562f0e5c-7ae8-4d95-9dd4-674447362ef7@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1854189089-1769600437=:26921"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1854189089-1769600437=:26921
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 28 Jan 2026, Akihiko Odaki wrote:
> On 2026/01/28 5:22, BALATON Zoltan wrote:
>> On Tue, 27 Jan 2026, Peter Xu wrote:
>>> On Tue, Jan 27, 2026 at 03:10:28PM +0100, BALATON Zoltan wrote:
>>>> This series does not convert everything but opens the way to do that and
>>>> simplify objects by only storing things in the state that are really 
>>>> needed
>>>> by the object and let QOM manage what it can. I'd really like to avoid
>>>> having a list of unused stuff in the state struct just because I can't 
>>>> use
>>>> something that works and documented just no API to actually use it. Cf.
>>>> sii3112 state after this series:
>>>> 
>>>> struct SiI3112PCIState {
>>>>     PCIIDEState i;
>>>> 
>>>>     SiI3112Regs regs[2];
>>>> };
>>>> 
>>>> vs. your standard:
>>>> 
>>>> struct SiI3112PCIState {
>>>>     PCIIDEState i;
>>>> 
>>>>     MemoryRegion mmio;
>>>>     MemoryRegion bar0;
>>>>     MemoryRegion bar1;
>>>>     MemoryRegion bar2;
>>>>     MemoryRegion bar3;
>>>>     MemoryRegion bar4;
>>>>     SiI3112Regs regs[2];
>>>> };
>>> 
>>> The latter solution is fine at least to me.
>>> 
>>> I respect your preference on how it can be done, but IMHO it is 
>>> subjective,
>>> and I tend to agree with Peter that we should try to stick with one way of
>>> solving problems, unless very necessary.
>>> 
>>> In the last three patches the MRs do not look need dynamic deallocation to
>>> me at all..  Introducing fully dynamic MR allocations only for those is an
>>> overkill to me.  I'm not fully convinced we need to merge 600+ new LOCs 
>>> for
>>> new APIs just for them.
>> 
>> It's not a new API in the sense that it's the same as existing 
>> memory_region_init functions just a variant of it to allow using QOM to 
>> manage the lifetime of the memory region which the current API does not 
>> allow. Also this series does not introduce this dynamic lifetime 
>> management, it's already implemented and documented just there's currently 
>> no way to use it. The actual change is much less, most of the lines are 
>> just the documentation comments. If it's a problem to increase 
>> documentation size I could make it much shorter not duplicating a separate 
>> doc comment for these just mention in the corresponding memory_region_init 
>> doc comment that there's also an analogous memory_region_new variant of it. 
>> That also shows there's no new API just two ways of using the same API.
>> 
>>> We have real but rare users of dynamically allocated MRs, currently AFAIU
>> 
>> Since it's already implemented why not use it if it makes the object state 
>> simpler? Adding additional fields that would already be managed by QOM 
>> seems to be unnecessary duplication and complication to me so I'd like to 
>> avoid that and keep the subclass simple.
>
> I feel the discussion is going a wrong direction. This thread and the cover 
> letter talks different things as the motivation of this series; The cover 
> letter says the documentation mismatches with the implementation and that is 
> the motivation for this series. This thread talks about duplicate memory 
> management and extra fields, which is not mentioned in the cover letter.
>
> Besides, the "extra fields" problem should have been already discussed in [1] 
> and I don't see a new argument here. So, in summary, for a constructive 
> discussion I think:
> - There should be a consistent goal of discussion or patch series
>  (documentation mismatch or extra fields) and
> - A new point needs to be made; reminding the points of past discussion
>  may be worthwhile but is insufficient.
>
> [1] 
> https://lore.kernel.org/qemu-devel/ceda4c28887c40e1c8eae3f561ee381ca98b0484.1761346145.git.balaton@eik.bme.hu/

Adding some QOM people in case they have something to add.

OK I try to summarise the motivation again:

1. Documentation in docs/devel/memory.rst says that memory regions' 
lifecycle is managed by QOM and they are freed with their owner or when 
nothing else uses them. This is also already implemented for a long time 
as described but cannot be used because the only constructors available 
kill this feature when calling object_initialize that clears the free 
function added by object_new. (The life time management is implemented 
through adding memory regions as children to the owner and unparenting 
them on freeing the owner which decreases ref count of the memory region 
and will free it when nothing else references it as far as I can tell.)

2. This also allows to keep subclasses' state simpler as demonstrated by 
the last two patches by allowing QOM to manage memory regions as 
originally intended (based on the documentation and implementation) and 
not needing to embed memory regions not otherwise needed in the subclass 
as they are already handled by super classes (e.g. registering as PCI 
regions or sysbus mmio regions and their lifetime managed by QOM; this way 
the subclass only contains what it has to add to the superclass and kept 
simpler as expected in an object oriented design).

So the motivation is to match documentation and allow using already 
implemented memory region lifecycle management to make device models 
simpler.

These are my motivation for this change. What is the motivation for using 
embedded memory regions instead and against this change? If that is found 
to be a better way then the lifecycle management as implementated and 
documentated is likely no longer needed as it cannot and will not be used 
with embedded memory regions that are initialsed with object_initialize 
and thus could be removed. But I think that would lead to more complex 
device models not using what QOM and QDev was meant to help with. (More 
complex device models is a problem because they are harder to understand 
and find bugs in them having additional things that disctract from actual 
functionality of the subclass so I'd like to make them as simple as 
possible only containing things that are related to the subclass. So 
less QOM boilet plate, less additional static fields in the state is the 
better.)

Regards,
BALATON Zoltan
--3866299591-1854189089-1769600437=:26921--

