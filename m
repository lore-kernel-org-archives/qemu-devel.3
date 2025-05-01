Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7533FC3ABAA
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 23:36:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAdRA-0002aO-Vr; Thu, 01 May 2025 19:35:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uAdR4-0002ZA-SI
 for qemu-devel@nongnu.org; Thu, 01 May 2025 19:35:23 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uAdR1-00043p-So
 for qemu-devel@nongnu.org; Thu, 01 May 2025 19:35:22 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3EA7F55D25C;
 Fri, 02 May 2025 01:35:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id tHK8x78EK4YV; Fri,  2 May 2025 01:35:12 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E2CAF55D25A; Fri, 02 May 2025 01:35:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E0B82745682;
 Fri, 02 May 2025 01:35:12 +0200 (CEST)
Date: Fri, 2 May 2025 01:35:12 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
cc: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, 
 Anton Johansson <anjo@rev.ng>
Subject: Re: [RFC PATCH v5 08/21] hw/arm: Add DEFINE_MACHINE_[ARM_]AARCH64()
 macros
In-Reply-To: <afe9878a-1710-4994-81ee-f308f5be2900@linaro.org>
Message-ID: <164fe2df-50a5-79ce-597c-0c5aed6f0365@eik.bme.hu>
References: <20250424222112.36194-1-philmd@linaro.org>
 <20250424222112.36194-9-philmd@linaro.org>
 <1332b395-1e3e-2be7-83f2-15f2d89b0449@eik.bme.hu>
 <51f3a96b-9c7a-4242-a822-145d68e068d9@linaro.org>
 <f84a52af-aecf-5235-7971-689580ffb71f@eik.bme.hu>
 <29f67d66-9eef-493a-9d96-99240ca25a14@linaro.org>
 <75b7e110-9293-32b2-64c8-26eabaace8b7@eik.bme.hu>
 <033d94c7-ac74-4a44-87ae-aeac964afd10@linaro.org>
 <c4479348-00b2-4604-adad-e8d8911c75a6@linaro.org>
 <21e6cbae-54fe-2d11-307f-2fe36a08c97b@eik.bme.hu>
 <6d7f8b57-b8d4-49cd-b0fd-72e5428bc94a@linaro.org>
 <29bf183a-957b-6c03-be66-bee38f106fc5@eik.bme.hu>
 <b711cddb-0a68-4dba-a492-4c51683eb116@linaro.org>
 <d454c53d-dba3-e665-39c6-267bbbab8aed@eik.bme.hu>
 <afe9878a-1710-4994-81ee-f308f5be2900@linaro.org>
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

On Mon, 28 Apr 2025, Pierrick Bouvier wrote:
> On 4/28/25 6:10 PM, BALATON Zoltan wrote:
>> On Mon, 28 Apr 2025, Pierrick Bouvier wrote:
>>> On 4/28/25 11:44 AM, BALATON Zoltan wrote:
>>>> On Mon, 28 Apr 2025, Pierrick Bouvier wrote:
>>>>> On 4/28/25 3:31 AM, BALATON Zoltan wrote:
>>>>>> Since you are touching the lines using DEFINE_MACHINE it's a good
>>>>>> opportunity to change the macro to be more general to be able to keep
>>>>>> using it instead of replacing it with the boiler plate it's supposed to
>>>>>> hide. Adding one or two more parameters to the macro is not a big 
>>>>>> change
>>>>>> so I don't see why you don't want to do it. This could be addressed 
>>>>>> later
>>>>>> to revert to use the macro again but in practice it will not be 
>>>>>> addressed
>>>>>> because everybody will be busy doing other things and doing that now
>>>>>> would
>>>>>> prevent some churn. I too, don't like doing unrelated clean up which is
>>>>>> not the main goal, but if it's not much more work then it's not
>>>>>> unreasonable to do it. I only oppose to that if it's a lot of work so I
>>>>>> would not ask such change but what I asked is not unrelated and quite
>>>>>> simple change.
>>>>>> 
>>>>>> That said, I can't stop you so if you still don't want to do it now 
>>>>>> then
>>>>>> you can move on. I don't care that much as long as you stay within
>>>>>> hw/arm,
>>>>>> but will raise my concern again when you submit a similar patch that
>>>>>> touches parts I care more about. If others don't think it's a problem 
>>>>>> and
>>>>>> not bothered by the boiler plate code then it's not so important but
>>>>>> otherwise I think I have a valid point. I remember when I started to 
>>>>>> get
>>>>>> to know QEMU it was quite difficult to wade through all the QOM boiler
>>>>>> plate just to see what is related to the actual functionality. These
>>>>>> macros help to make code more readable and accessible for new people.
>>>>> 
>>>>> Having been through that recently, I agree with you that it can be hard 
>>>>> to
>>>>> follow at first. Luckily, we have perfect compiler based completion for
>>>>> all
>>>>> editors those days (I sincerely hope everyone spent 2 hours configuring
>>>>> this
>>>>> on their own favorite one), and it's easy to see where things are 
>>>>> defined
>>>>> and
>>>>> used, even when code is cryptic.
>>>> 
>>>> It's not about typing but reading it. The verbose struct definitions are
>>>> hard to follow and makes board code look more complex than it should be.
>>>> 
>>>>> That said, pushing to someone adding a new field the responsibility of
>>>>> cleaning up the whole thing is not a fair request. You can't expect your
>>>>> friends to clean your shared house because they brought a cake for 
>>>>> dinner.
>>>> 
>>>> I tend to get such requests to clean up unrelated things whenever I try 
>>>> to
>>>> change anything in PPC Mac emulation which I also complain about and 
>>>> think
>>>> is not reasonable to ask. But I did not ask for unrelated cleanup here 
>>>> and
>>>> changing the patch so you don't do this:
>>>> 
>>>> -DEFINE_MACHINE("none", machine_none_machine_init)
>>>> +static const TypeInfo null_machine_types[] = {
>>>> +    {
>>>> +        .name           = MACHINE_TYPE_NAME("none"),
>>>> +        .parent         = TYPE_MACHINE,
>>>> +        .class_init     = null_machine_class_init,
>>>> +    },
>>>> +};
>>>> +
>>>> +DEFINE_TYPES(null_machine_types)
>>>> 
>>>> but instead add the .interfaces field to a variant of DEFINE_MACHINE once
>>>> and keep the one line definition is not something unreasonable to ask. I
>>>> think you can ask your friends to not make a mess in the shared house
>>>> while having a party or at least clean up after that. Adding one more
>>>> parameter to the macro is also simple to do so I don't get why you're so
>>>> opposed to this.
>>>> 
>>> 
>>> Maybe there is a misunderstanding on my side, but it seems that what you
>>> asked is exactly patch 7, which introduce DEFINE_MACHINE_WITH_INTERFACES.
>> 
>> Almost but not quite. I don't know why I can't get this through to you. If
>> you compare patch 7 to how DO_OBJECT_DEFINE_TYPE_EXTENDED is defined do
>> you notice the difference in how .interfaces is set? With the same way as
>> in DO_OBJECT_DEFINE_TYPE_EXTENDED you don't need separate InterfaceInfo
>> arm_aarch64_machine_interfaces[] definitions or different macros in the
>> next patch just list the needed interfaces in the machine definitions.
>> 
>
> I'm sorry, I don't understand what you want exactly, despite asking several 
> times.
> I think it would be more clear if you could apply this series on your side, 
> write a small patch showing *exactly* what you expect, and applying this to 
> one of the board concerned. Then, we can do the change you request.

You can pick the patch from this series I've just posted:
https://patchew.org/QEMU/cover.1746139668.git.balaton@eik.bme.hu/ad355178b2a3fe285854ed2e25b288baf0fd6e05.1746139668.git.balaton@eik.bme.hu/
it is used in patch 12 of that series for an example.

Regards,
BALATON Zoltan

