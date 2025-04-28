Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0505BC369D3
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 10:32:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9Llm-0000Kx-BL; Mon, 28 Apr 2025 06:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1u9Lld-0008P9-2K
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 06:31:17 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1u9LlY-0004AK-Fh
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 06:31:15 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 1F8A855D22A;
 Mon, 28 Apr 2025 12:31:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id yCvVJ2_XAtYS; Mon, 28 Apr 2025 12:31:08 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 0923455D232; Mon, 28 Apr 2025 12:31:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 06FD0745683;
 Mon, 28 Apr 2025 12:31:08 +0200 (CEST)
Date: Mon, 28 Apr 2025 12:31:07 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: Richard Henderson <richard.henderson@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org, 
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, 
 Anton Johansson <anjo@rev.ng>
Subject: Re: [RFC PATCH v5 08/21] hw/arm: Add DEFINE_MACHINE_[ARM_]AARCH64()
 macros
In-Reply-To: <c4479348-00b2-4604-adad-e8d8911c75a6@linaro.org>
Message-ID: <21e6cbae-54fe-2d11-307f-2fe36a08c97b@eik.bme.hu>
References: <20250424222112.36194-1-philmd@linaro.org>
 <20250424222112.36194-9-philmd@linaro.org>
 <1332b395-1e3e-2be7-83f2-15f2d89b0449@eik.bme.hu>
 <51f3a96b-9c7a-4242-a822-145d68e068d9@linaro.org>
 <f84a52af-aecf-5235-7971-689580ffb71f@eik.bme.hu>
 <29f67d66-9eef-493a-9d96-99240ca25a14@linaro.org>
 <75b7e110-9293-32b2-64c8-26eabaace8b7@eik.bme.hu>
 <033d94c7-ac74-4a44-87ae-aeac964afd10@linaro.org>
 <c4479348-00b2-4604-adad-e8d8911c75a6@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-523160171-1745836268=:12513"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

--3866299591-523160171-1745836268=:12513
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 28 Apr 2025, Philippe Mathieu-Daudé wrote:
> On 25/4/25 22:36, Pierrick Bouvier wrote:
>> On 4/25/25 13:29, BALATON Zoltan wrote:
>>> On Fri, 25 Apr 2025, Pierrick Bouvier wrote:
>>>> On 4/25/25 02:43, BALATON Zoltan wrote:
>>>>> On Thu, 24 Apr 2025, Pierrick Bouvier wrote:
>>>>>> On 4/24/25 17:16, BALATON Zoltan wrote:
>>>>>>> On Fri, 25 Apr 2025, Philippe Mathieu-Daudé wrote:
>>>>>>>> A machine defined with the DEFINE_MACHINE_ARM_AARCH64() macro
>>>>>>>> will be available on qemu-system-arm and qemu-system-aarch64
>>>>>>>> binaries.
>>>>>>>> 
>>>>>>>> One defined with DEFINE_MACHINE_AARCH64() will only be available
>>>>>>>> in the qemu-system-aarch64 binary.
>>>>>>>> 
>>>>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>>>>> ---
>>>>>>>> include/hw/arm/machines-qom.h | 13 +++++++++++++
>>>>>>>> target/arm/machine.c          | 12 ++++++++++++
>>>>>>>> 2 files changed, 25 insertions(+)
>>>>>>>> 
>>>>>>>> diff --git a/include/hw/arm/machines-qom.h
>>>>>>>> b/include/hw/arm/machines-qom.h
>>>>>>>> index a17225f5f92..6277ee986d9 100644
>>>>>>>> --- a/include/hw/arm/machines-qom.h
>>>>>>>> +++ b/include/hw/arm/machines-qom.h
>>>>>>>> @@ -9,10 +9,23 @@
>>>>>>>> #ifndef HW_ARM_MACHINES_QOM_H
>>>>>>>> #define HW_ARM_MACHINES_QOM_H
>>>>>>>> 
>>>>>>>> +#include "hw/boards.h"
>>>>>>>> +
>>>>>>>> #define TYPE_TARGET_ARM_MACHINE \
>>>>>>>>            "target-info-arm-machine"
>>>>>>>> 
>>>>>>>> #define TYPE_TARGET_AARCH64_MACHINE \
>>>>>>>>            "target-info-aarch64-machine"
>>>>>>>> 
>>>>>>>> +extern InterfaceInfo arm_aarch64_machine_interfaces[];
>>>>>>>> +extern InterfaceInfo aarch64_machine_interfaces[];
>>>>>>>> +
>>>>>>>> +#define DEFINE_MACHINE_ARM_AARCH64(namestr, machine_initfn) \
>>>>>>>> +        DEFINE_MACHINE_WITH_INTERFACES(namestr, machine_initfn, \
>>>>>>>> + 
>>>>>>>> arm_aarch64_machine_interfaces)
>>>>>>>> +
>>>>>>>> +#define DEFINE_MACHINE_AARCH64(namestr, machine_initfn) \
>>>>>>>> +        DEFINE_MACHINE_WITH_INTERFACES(namestr, machine_initfn, \
>>>>>>>> +                                       aarch64_machine_interfaces)
>>>>>>>> +
>>>>>>>> #endif
>>>>>>>> diff --git a/target/arm/machine.c b/target/arm/machine.c
>>>>>>>> index 978249fb71b..193c7a9cff0 100644
>>>>>>>> --- a/target/arm/machine.c
>>>>>>>> +++ b/target/arm/machine.c
>>>>>>>> @@ -8,6 +8,7 @@
>>>>>>>> #include "cpu-features.h"
>>>>>>>> #include "migration/cpu.h"
>>>>>>>> #include "target/arm/gtimer.h"
>>>>>>>> +#include "hw/arm/machines-qom.h"
>>>>>>>> 
>>>>>>>> static bool vfp_needed(void *opaque)
>>>>>>>> {
>>>>>>>> @@ -1111,3 +1112,14 @@ const VMStateDescription vmstate_arm_cpu = {
>>>>>>>>            NULL
>>>>>>>>        }
>>>>>>>> };
>>>>>>>> +
>>>>>>>> +InterfaceInfo arm_aarch64_machine_interfaces[] = {
>>>>>>>> +    { TYPE_TARGET_ARM_MACHINE },
>>>>>>>> +    { TYPE_TARGET_AARCH64_MACHINE },
>>>>>>>> +    { }
>>>>>>>> +};
>>>>>>>> +
>>>>>>>> +InterfaceInfo aarch64_machine_interfaces[] = {
>>>>>>>> +    { TYPE_TARGET_AARCH64_MACHINE },
>>>>>>>> +    { }
>>>>>>>> +};
>>>>>>> 
>>>>>>> Why do you need these? If you define DEFINE_MACHINE_WITH_INTERFACES as
>>>>>>> OBJECT_DEFINE_TYPE_WITH_INTERFACES then you can write:
>>>>>>> 
>>>>>> 
>>>>>> This was requested in v4 by Richard to remove anonymous array 
>>>>>> duplication
>>>>>> in
>>>>>> .data.
>>>>>> 
>>>>>>> DEFINE_MACHINE_WITH_INTERFACES(name, initfn, { TYPE_TARGET_ARM_MACHINE 
>>>>>>> },
>>>>>>>         { TYPE_TARGET_AARCH64_MACHINE }, { })
>>>>>>> 
>>>>>>> and no more macros needed. Ideally those places that are now blown up
>>>>>>> should use DEFINE_MACHINE too. Maybe they don't yet because the parent
>>>>>>> type  is hardcoded so we should really have
>>>>>>> 
>>>>>> 
>>>>>> Not sure what you mean by "no more macros needed".
>>>>> 
>>>>> No other specialised macros needed for each machine type other than
>>>>> DEFINE_MACHINE_WITH_INTERFACES or DEFINE_MACHINE_EXTENDED. So I 
>>>>> suggested
>>>>> to keep DEFINE_MACHINE by making it more general so it can cover the new
>>>>> uses instead of bringing back the boiler plate and losing the clarity
>>>>> hinding these behind the macros.
>>>>> 
>>>> 
>>>> This is exactly what we have in this series.
>>>> Patch 7 introduces DEFINE_MACHINE_WITH_INTERFACES.
>>>> I guess Philippe chose a new name to avoid modifying all existing
>>>> DEFINE_MACHINE, and I think it's understandable, as we want those changes 
>>>> to
>>>> impact hw/arm only first. That said, it would be very easy to 
>>>> refactor/modify
>>>> later, so it's not a big deal.
>>>> 
>>>> This patch introduces DEFINE_MACHINE_ARM_AARCH64 and 
>>>> DEFINE_MACHINE_AARCH64.
>>>> 
>>>> Is the problem with those specialized DEFINE_MACHINE_{ARM, AARCH64}
>>>> definition?
>>>> If yes, and if you prefer an explicit DEFINE_MACHINE_WITH_INTERFACES(...,
>>>> arm_aarch64_machine_interfaces), I'm sure Philippe would be open to make 
>>>> such
>>>> a change to satisfy reviews.
>>>> 
>>>> Let's just try to decide something, and move on.
>>>> 
>>>>>> arm_aarch64_machine_interfaces or aarch64_machine_interfaces are arrays
>>>>>> (defined only once), which are passed as a parameter to
>>>>>> DEFINE_MACHINE_WITH_INTERFACES, or manually set with ".interfaces =".
>>>>> 
>>>>> Look at how OBJECT_DEFINE_TYPE_WITH_INTERFACES is defined.
>>>>> 
>>>> 
>>>> This macro is not used for any machine definition so far, and 
>>>> DEFINE_MACHINE
>>>> is the "standard" macro used, at least the one most commonly used in the
>>>> codebase. So it makes sense to simply expand the latter.
>>> 
>>> I was referring to that as an example how a DEFINE_MACHINE_WITH_INTERFACES
>>> should work not suggesting to use OBJECT_DEFINE_TYPE_WITH_INTERFACES.
>>> 
>>>>>>> DEFINE_MACHINE_EXTENDED(name, parent, initfn, interfaces...)
>>>>>>> 
>>>>>>> and remove more bolier plate that way?
>>>>>>> 
>>>>>> 
>>>>>> Could you can share a concrete example of what you expect, with the new
>>>>>> macros to add, and how to use them for a given board?
>>>>> 
>>>>> I tried to do that in this message you replied to.
>>>>> 
>>>> 
>>>> If you refer to "DEFINE_MACHINE_EXTENDED(name, parent, initfn,
>>>> interfaces...)", this is almost exactly what patch 7 is introducing with
>>>> DEFINE_MACHINE_WITH_INTERFACES(namestr, machine_initfn, ifaces).
>>> 
>>> The difference is that OBJECT_DEFINE_TYPE_WITH_INTERFACES takes a list of
>>> interfaces and defines the array itself and you pass the array which is
>>> limiting as you then need to define a lot of arrays to pass to your macro
>>> instead of only passing the elements and let it define tha array.
>>> 
>>> I just want to see instead of
>>> 
>>> static const TypeInfo machine_types[] = {
>>> ...lots of boiler plate code here
>>> };
>>> 
>>> something like
>>> 
>>> DEFINE_MACHINE_EXTENDED(machine1, TYPE_WHATEVER_MACHINE, {INTERFACE1}, 
>>> {INTERFACE2}, {})
>>> DEFINE_MACHINE_EXTENDED(machine2, TYPE_OTHER_MACHINE, {INTERFACE1}, 
>>> {INTERFACE3}, {})
>>> DEFINE_MACHINE_EXTENDED(machine3, TYPE_THIRD_MACHINE, {INTERFACE1}, {})
>>> 
>> 
>> Ok, I understand better.
>> 
>> It was my point as well on v4, that introducing those symbols is less 
>> readable and less scalable, for a negligible benefit in terms of code size, 
>> which was the primary concern.
>> We can always reconsider this later, especially when adding another 
>> architecture to single binary, it's not a problem and something set in 
>> stone.
>> 
>> Would you be ok if we proceed with the current version, knowing those 
>> limitations, for now?
>
> If Zoltan disagrees, we need Richard to agree to go back on v4.
>
> Keep in mind that what we are trying to achieve is quite more complex
> than code style or .rodata savings, besides we eventually want to have
> dynamic machines & DSL.

Since you are touching the lines using DEFINE_MACHINE it's a good 
opportunity to change the macro to be more general to be able to keep 
using it instead of replacing it with the boiler plate it's supposed to 
hide. Adding one or two more parameters to the macro is not a big change 
so I don't see why you don't want to do it. This could be addressed later 
to revert to use the macro again but in practice it will not be addressed 
because everybody will be busy doing other things and doing that now would 
prevent some churn. I too, don't like doing unrelated clean up which is 
not the main goal, but if it's not much more work then it's not 
unreasonable to do it. I only oppose to that if it's a lot of work so I 
would not ask such change but what I asked is not unrelated and quite 
simple change.

That said, I can't stop you so if you still don't want to do it now then 
you can move on. I don't care that much as long as you stay within hw/arm, 
but will raise my concern again when you submit a similar patch that 
touches parts I care more about. If others don't think it's a problem and 
not bothered by the boiler plate code then it's not so important but 
otherwise I think I have a valid point. I remember when I started to get 
to know QEMU it was quite difficult to wade through all the QOM boiler 
plate just to see what is related to the actual functionality. These 
macros help to make code more readable and accessible for new people.

Regards,
BALATON Zoltan
--3866299591-523160171-1745836268=:12513--

