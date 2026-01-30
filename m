Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A23C3E6BF39
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 20:09:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlunC-000870-At; Fri, 30 Jan 2026 15:08:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1vlunB-00086p-Jm
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 15:08:33 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1vlun9-0006sT-KX
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 15:08:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=sMCz0cdm6QpMZgKf2sROd4yl0XbaShEK/qXZhfSxHFY=; b=IOjYozwne7QdEFv3x6Ex2xPPWi
 hW0UUBXz9WXxZDkJxdQp0GckRdskG8Z17GDIzk2pwPPOqkIRe6H07EbXZL0QqfXcuCgVm5MIkaBZN
 YZ7DXTksl2w4URaxeAOSStQLUtHsOuvQg7c+0Nper5t7mNWyawXbwLl1oC3lwxDnH75AA2EkFNt3i
 iK2GqMALCmYcZp3zbAbTXAaI+jQw5qHlVMDen7LPvq8/YLxqL0E9HC9okErxZDF+2yQBScjnUQx66
 a9TCgd5PVAp2NAOPkcFdWxR2gkcGlgsoSjZjqakF3nxfevEmGtHMIlR852lQN9TZnkIjJLxxiB6D1
 YJQg2uXICSrDAAGySQRfiPz6q+azFg7XV5IEWI1kyNPZx60fA7G2aIptjp3Nj/C8/V8Ig1EI9nHU1
 2aLE7RJA62muCHKvhXppqMv2Pl/3QuvsbdztZlf0bEtkvgnnP0FW5DnyTiLHRCykinOU34FDxpSlr
 eoXdE1xiEZLzU+vmdamxJ5NvIWPXuWILfjmY2o1yDe6VnzxQTQvdg3WuXaVOXDZEtOwwLNAXdSUUq
 p6lIDVkPASL83pa85j+VZ5EexTNi9YgdIGj0huYY7ba0j1KjhmK2lC2oY2Iea7KqWLKbyt82Yl00J
 e2KoQaIeNUpuNIb0ruDIxI95VS7kOpEUX0vohuLQo=;
Received: from [2a02:8012:2f01:0:627e:3663:264b:92cd]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1vlukO-0007f3-EI; Fri, 30 Jan 2026 20:05:40 +0000
Message-ID: <0652ec1f-2861-4550-9174-2183cc78ad87@ilande.co.uk>
Date: Fri, 30 Jan 2026 20:08:24 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 BALATON Zoltan <balaton@eik.bme.hu>, Peter Maydell <peter.maydell@linaro.org>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <cover.1769362313.git.balaton@eik.bme.hu>
 <CAFEAcA_jS3hef=dhxZ5s7MReSW4ir+jMUGwu+RjD_JP7ZRrRXQ@mail.gmail.com>
 <0118dc9b-d467-7f6b-92a8-4f42760ecb6c@eik.bme.hu> <aXkXWGho7lnJ-gwX@x1.local>
 <2fa59d39-5634-0b8c-27ee-9e9548a7f92a@eik.bme.hu>
 <562f0e5c-7ae8-4d95-9dd4-674447362ef7@rsg.ci.i.u-tokyo.ac.jp>
 <cfacf068-7663-6c7f-4908-928bb63e803c@eik.bme.hu>
 <CAFEAcA-8-jC-HJix5YFVbmg3sEuhcSMD8gKJxzAiz=GPy0sw9Q@mail.gmail.com>
 <b5721fa1-e613-889a-03de-77c46aa01da4@eik.bme.hu>
 <d83ac948-afb4-4128-9e23-44aa8a8e31c4@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 xsBNBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAHNME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPsLA
 eAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63M7ATQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABwsBfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
In-Reply-To: <d83ac948-afb4-4128-9e23-44aa8a8e31c4@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:627e:3663:264b:92cd
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2 00/10] Implement memory_region_new_* functions
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 29/01/2026 04:41, Akihiko Odaki wrote:

> On 2026/01/29 0:46, BALATON Zoltan wrote:
>> On Wed, 28 Jan 2026, Peter Maydell wrote:
>>> On Wed, 28 Jan 2026 at 11:40, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>>>> OK I try to summarise the motivation again:
>>>>
>>>> 1. Documentation in docs/devel/memory.rst says that memory regions'
>>>> lifecycle is managed by QOM and they are freed with their owner or when
>>>> nothing else uses them. This is also already implemented for a long time
>>>> as described but cannot be used because the only constructors available
>>>> kill this feature when calling object_initialize that clears the free
>>>> function added by object_new. (The life time management is implemented
>>>> through adding memory regions as children to the owner and unparenting
>>>> them on freeing the owner which decreases ref count of the memory region
>>>> and will free it when nothing else references it as far as I can tell.)
>>>
>>> If we have leaks because of our very common pattern of "embed
>>> a MemoryRegion struct in the device state struct" then we must
>>> fix those, because there's no way we're going to convert all
>>> that existing code to a new set of APIs. But I was under the
>>> impression we had already dealt with those, because MRs track
>>> their owner's refcount, and don't have their own independent one ?
>>
>> I'm not sure if all those leaks are resolved as there were some patches and 
>> discussion about this recently but I think that problem or the need to use the 
>> owner's ref count to circumwent it instead of using the memory region's own ref 
>> count may also come from that there's currently no way to allocate memory regions 
>> that are ref counted and automatically freed as it should work with QOM and the 
>> documentation implies. (Only the constuctor is missing that is all this series 
>> adds, the mechanism is already there and implemented.) There may still be a problem 
>> with circular references if the memory region needs the owner so the owner can't be 
>> freed until the memory region is also freed but the memory region is not freed 
>> until the owner is freed but if both the owner and memory region used their own ref 
>> count things may become a bit less confusing and could be easier to find a way to 
>> break circular reference (e.g. by owner unparent child regions on unrealize but 
>> isn't freed until memory regions unref owner in their free method).
>>
>>>> These are my motivation for this change. What is the motivation for using
>>>> embedded memory regions instead and against this change?
>>>
>>> Simply that it's a consistent pattern we use in a lot of the codebase:
>>> the device embeds a lot of the structs it uses, rather than allocating
>>> memory for them and keeping pointers to that allocated memory. We
>>
>> You mix in the issue of SoCs and complex devices using other devices in which case 
>> the recommendation was to embed those in the parent device so they don't have to be 
>> freed or kept track of by a pointer but won't be leaked. This series does not mean 
>> to change that, it's only limited to memory regions. (Although that problem may 
>> also stem from similar issue with object_initialize_child not allowing creating 
>> reference counted objects only initializing preallocated instances but that's not 
>> something this series touches.)
>>
>> We can say that memory regions are like other embedded objects but they are often 
>> used for sysbus and PCI devices only to be registered in the parent device that 
>> already has pointers in their state to track these so there's no need to keep track 
>> of them in the subclass if we can rely on QOM freeing them when not needed any more 
>> and this is already implemented and documented that way. So even if we keep 
>> embedding other child devices into complex parent devices that I think does not 
>> directly apply to memory regions and we could use what the documentation and 
>> implementation already allows and says for memory regions at least.
>>
>>> still have also various older device models that use the previous
>>> pattern of "allocate memory and have pointers" too, but most new
>>> code doesn't do that. I think we should for preference write code
>>> in one pattern, not two, and "embed structs" seems to be what
>>> we have mostly settled on for new code.
>>>
>>> There is an argument to be made that the pointer model would
>>> fit better with a possible future world of "the user can wire
>>> configurably wire up their own board model from devices", and
>>> that it works better in a part-Rust-part-C world where the two
>>> different languages don't have convenient access to the exact
>>> size of structs defined in the other language. But that future
>>> model is not something anybody has yet really fleshed out in any
>>> detail, so it's still a bit speculative.
>>
>> You keep mentioning pointers but the point of ref counts and regisrering memory 
>> region as child of an owner is to avoid needing a pointer or embedding it in the 
>> subclass state as the relationship and lifecycle management are then handled by 
>> QOM. If we don't use that we could remove this from QOM and memory regions to 
>> simplify it but if it's already there and makes the device state simpler I think we 
>> better use it.
>>
>>> I'm not actually opposed to the idea of making a design decision
>>> that this struct-embedding is no longer what we want to do, and defining
>>> that something else is our new best practice for how to write devices.
>>> But I think we would need to start by reaching a consensus that that
>>> *is* what we want to do, and documenting that "best practice" somewhere
>>> in docs/devel/. Then we can examine proposed new APIs and all be
>>> on the same page about the design patterns we want and it will
>>> be clearer to reviewers whether the new APIs fit into those
>>> patterns or not.
>>
>> I think we're in that discussion now in this thread. I don't propose to change the 
>> struct-embedding for sub devices used in SoC or south bridge or other complex 
>> devices but only propose to not embed memory regions that are already documented as 
>> and handled by QOM and simply allocate them and let QOM handle them so we only need 
>> to reference them in the devices state unless they are needed for some reason by 
>> the device methods which is rarely the case. So this is limited to memory regions 
>> and the series only seems to add a lot of lines because of the extensive 
>> documentation comments. The actual change is just factoring out actual memory 
>> region init from memory_region_init functions then add a memory_region_new variant 
>> that does object_new; do_init and keep the memory_region_init do object_initializel 
>> do_init. Nothing else is changed, the way to manage and free regions based on ref 
>> counting is already there this series just enables them to be actually used becase 
>> currently despite what the docs say memory regions are either leaked or must be 
>> embedded.
> 
> I actually think deprecating struct-embedding for all QOM objects is a good idea.
> 
> The problem initially stated in this thread is that embedding requires having extra 
> field, but people see the benefit is too small. There is no real logic involved in 
> having such fields so it does not reduce code complexity much; it saves some lines 
> and that's it.
> 
> However, I see another problem in struct embedding; it breaks object_ref(). When 
> embedding, the child object effectively takes the reference to the storage of the 
> parent object, but this reference is not counted, so use-after-free can happen if 
> someone takes a reference to the child object with object_ref(). That is why the 
> wrapper of object_ref() in rust/qom/src/qom.rs needs to be marked unsafe. Memory 
> regions workaround this with memory_region_ref(), but it's not perfect since it 
> relies on object_ref() in the end.
> 
> For this reason I think object_initialize(), object_initialize_child(), and the like 
> are better to be noted as deprecated in
> include/qom/object.h. Then memory_region_init() can be deprecated referring to them.

FWIW this is something I've been thinking about for some time: possibly I had a chat 
with Phil about it at some point? Once example could be if you want to have a 
reference to a parent type like PCIDevice that can change at runtime e.g. it could be 
PCINE2000State or PCIPCNetState then you can never embed it, because you don't know 
the size at compile time. So then why not use object_property_add_child() everywhere 
so there is just a single way of doing things?

For memory regions it's a bit trickier because as per the virtio-gpu issues you've 
been looking at, it is possible for the memory region to exist outside of its parent 
device until it is destroyed later by the RCU thread. Is this something that can be 
solved by manipulating the refcount?

I do agree with Peter too that we don't want to add yet another way of doing things: 
if we decide to change the way memory regions work, we should go all-in and update 
all callers to reflect the new API and remove the old one. Having one easily 
understood way of modelling things makes life much easier for contributors and 
reviewers alike.


ATB,

Mark.


