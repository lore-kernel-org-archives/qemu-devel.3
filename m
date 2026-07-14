Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F72C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 21:57:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjl81-00021A-OP; Tue, 14 Jul 2026 17:57:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1wjl80-00020v-EL; Tue, 14 Jul 2026 17:57:24 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1wjl7y-0002I6-FQ; Tue, 14 Jul 2026 17:57:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=BrV5d9Mm7BiFClq5qmDvy8+/kXlhQ8lLHGZbfXuY4j0=; b=zjpSCmklOH7UkDo76qUSrQUPyJ
 ryKAYBm+CrVSplxGV8NDGSjASsIb40aSrAoDvQmBv1sXPwBYFOjRNJbSb+fndA5wF0GeCNq2sfvMw
 eLwOfoDgxg7fjXeLfgssWIdg0kHI9RpnG1RDczAMG4WFpjcyR5LmOW5xsRywAt/ug+OPK+pdW32XN
 a9eVJL6thVzHahrfwdFFJRusHUADAClay//2JJPmFWj0Bb1qzOvSbCyBQtt+Kl82o+vMie9ZWydAV
 Zgbb+tqN6UOYX2eiA0nJygPceKebVQz7NwZBbBUSk2z88ASQbwgcrxi9CfRuIff/Kv8KG94ku9pOO
 wqIJl6JDxyL2eqMpsguWCDHBM3LECrn8CD7uWTy9CoI4CL7RZ0rcAnWCZyYY7HridUejpr8xuTScM
 r04Lf5Yppvy/Nj3vWalDvh+2kJIXkkczRNp098pbGCN/Lx+GZTMeSizQNeMcQQdnLtrNoKeOEKyup
 ipA9XBhii9V2kVexdsgXRujh3qcmJ9Y4U3VLOa7qDlGu+tfA39E7xqBGtfqYsOc9vMbdjn/w+EM15
 6iBlW8rVvPPj9d1d5mAXV2yjiak75t2iMvQSaznbkl+RAVnaYLg86IoTluWJBiN4DixfJlNGoVI/K
 ydl29KjueC8sO8J1lRIhc8nRaVZU+HbjQ9XUkMlN0=;
Received: from [2a02:8012:2f01:0:15be:353c:5920:3156]
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1wjl7k-002fcN-G5; Tue, 14 Jul 2026 22:57:09 +0100
Message-ID: <6e2e63aa-5002-41ee-969c-2fc9050aa8e7@ilande.co.uk>
Date: Tue, 14 Jul 2026 22:57:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Artyom Tarasenko <atar4qemu@gmail.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>
References: <20260309181452.83702-1-thuth@redhat.com>
 <00c4ab4b-a58b-4de4-8e41-566b2cb7f920@redhat.com>
 <124bd918-f2ab-43e2-bd2d-fc824de62c40@tls.msk.ru>
 <fcbe3d7f-64d4-4b13-b930-a81e77db4784@ilande.co.uk>
 <df7a091c-a8a1-416a-acf3-28a0cbd8dd2f@redhat.com>
 <c7d6b801-449e-4f55-9c1d-ebec7a0e9595@redhat.com>
 <c0cd50bd-e054-48b6-af54-1050e13bb720@ilande.co.uk>
 <baf0b727-d53c-4717-b4e8-9c8603b2fa75@oss.qualcomm.com>
 <d1a5abca-18c2-4b07-ac77-cc8f9a4fefc1@oss.qualcomm.com>
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
In-Reply-To: <d1a5abca-18c2-4b07-ac77-cc8f9a4fefc1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:15be:353c:5920:3156
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2] hw/sparc64/sun4u: Mark unusable PCI busses as full to
 ease device plugging
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
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

On 13/07/2026 13:10, Philippe Mathieu-Daudé wrote:

> On 6/7/26 19:29, Philippe Mathieu-DaudÃ© wrote:
>> Hi,
>>
>> On 30/6/26 00:20, Mark Cave-Ayland wrote:
>>> On 29/06/2026 14:43, Thomas Huth wrote:
>>>
>>>> On 09/06/2026 08.02, Thomas Huth wrote:
>>>>> On 08/06/2026 23.29, Mark Cave-Ayland wrote:
>>>>>> On 08/06/2026 09:26, Michael Tokarev wrote:
>>>>>>
>>>>>>> On 30.04.2026 12:50, Thomas Huth wrote:
>>>>>>>> On 09/03/2026 19.14, Thomas Huth wrote:
>>>>>>>>> From: Thomas Huth <thuth@redhat.com>
>>>>>>>>>
>>>>>>>>> When trying to plug a PCI device to a Sparc64 machine, you currently
>>>>>>>>> have to specify the right bus ("bus=pciB"), otherwise you get this error:
>>>>>>>>>
>>>>>>>>>   $ qemu-system-sparc64 -device virtio-scsi-pci
>>>>>>>>>   qemu-system-sparc64: -device virtio-scsi-pci: PCI: no slot/ function
>>>>>>>>>   available for virtio-scsi-pci, all in use or reserved
>>>>>>>>>
>>>>>>>>> This is quite annoying for the unexperienced users, and it also breaks
>>>>>>>>> e.g. the iotests ("make check-block") when running with qemu- system- sparc64.
>>>>>>>>>
>>>>>>>>> Mark the non-usable PCI busses as full now, so that QEMU can automatically
>>>>>>>>> plug new PCI devices to the right "pciB" bus.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>>>>>>> ---
>>>>>>>>>   v2: Do the change in the machine code, not in the sabre device
>>>>>>>>>
>>>>>>>>>   hw/sparc64/sun4u.c | 7 +++++++
>>>>>>>>>   1 file changed, 7 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
>>>>>>>>> index b8bda1eb816..37539535c6c 100644
>>>>>>>>> --- a/hw/sparc64/sun4u.c
>>>>>>>>> +++ b/hw/sparc64/sun4u.c
>>>>>>>>> @@ -723,6 +723,13 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
>>>>>>>>>       fw_cfg_add_i16(fw_cfg, FW_CFG_SPARC64_DEPTH, graphic_depth);
>>>>>>>>>       qemu_register_boot_set(fw_cfg_boot_set, fw_cfg);
>>>>>>>>> +
>>>>>>>>> +    /*
>>>>>>>>> +     * Mark internal PCI busses as full so that the plugging of additional
>>>>>>>>> +     * PCI devices happens on the right bus that still has free slots:
>>>>>>>>> +     */
>>>>>>>>> +    qbus_mark_full(&pci_bus->qbus);
>>>>>>>>> +    qbus_mark_full(&pci_busA->qbus);
>>>>>>>>>   }
>>>>>>>>>   enum {
>>>>>>>>
>>>>>>>> Friendly ping!
>>>>>>>
>>>>>>> This, being a simple change, somehow has not been reviewed still, so
>>>>>>> it's sitting in the queue...
>>>>>>
>>>>>> Yes, apologies - I've been absolutely flat out recently, and I've got a note to 
>>>>>> take a look at this and Peter's patch as soon as I can.
>>>>>>
>>>>>> Is this fixing an urgent issue with "make check-block" or similar?
>>>>>
>>>>> It's not urgent since this has been broken forever, but yes, it fixes "make 
>>>>> check- block" for the case where sparc64 is the only available target during 
>>>>> "configure -- target-list=sparc64-softmmu" and thus the iotests run with qemu- 
>>>>> system-sparc64.
>>>> Ping!
>>>>
>>>> While it's not urgent, soft-freeze date is in a week, so it would be nice to get 
>>>> this merged before it misses another release ... WDYT?
>>>
>>> Hi Thomas,
>>>
>>> I'm still playing catch-up a bit here, but I can't immediately find my notes on 
>>> using pciA under QEMU. I think if it fixes the iotests then go ahead and merge it 
>>> for now, which gives me time in freeze to investigate any reported issues.
>>
>> I wasn't sure whether merging this patch now or wait for your update
>> during the freeze so hold my PR for a bit; today I looked a bit at it.
>>
>> Some notes:
>>
>> - pci_bus_*_slot_reserved_mask() API isn't much used. I supposed it
>>    worked for a pair of corner cases but doesn't scale (I expect it
>>    to be called in more code paths).
>>
>> - Bus capacity is odd. We have a generic Bus-class @max_dev field but
>>    do not use it with PCI variants. If set, it limit the instances
>>    capacity. The capacity is tracked in the instance state, and when
>>    no @max_dev is set the only way to mark a bus full is using the
>>    qbus_mark_full() helper. Then if we remove devices, the bus remains
>>    full, and there is no helper to restore available slots.
>>
>>
>> Anyway, back to the problem here, the first part is indeed as noticed
>> Thomas to use qbus_mark_full() for the root bus:
>>
>> -- >8 --
>> diff --git a/hw/pci-host/sabre.c b/hw/pci-host/sabre.c
>> index cd2328ad53f..6a8d0b6c6d2 100644
>> --- a/hw/pci-host/sabre.c
>> +++ b/hw/pci-host/sabre.c
>> @@ -400,6 +400,9 @@ static void sabre_realize(DeviceState *dev, Error **errp)
>>       s->bridgeA = PCI_BRIDGE(pci_dev);
>>       pci_bridge_map_irq(s->bridgeA, "pciA", pci_simbaA_map_irq);
>>       pci_realize_and_unref(pci_dev, phb->bus, &error_fatal);
>> +
>> +    /* Only in-built Simba APBs can exist on the root bus */
> 
> Per the manual "Up to four Advanced PCI Bridge ASICs (APB)s may be used
> with the UltraSPARC-IIi".

That sounds about right. IIRC the UPA bus used by the UltraSPARC-IIi CPU can have up 
to 32 devices connected to it which are typically CPUs, but there are also 4 UPA IDs 
reserved for APBs. However the real life Ultra-5 machine (which is the closest to 
what QEMU emulates) is physically limited to a single CPU and a single APB with two 
of the slots on the PCI bus containing the integrated Simba PCI-PCI bridges.

Which thinking about it means the comment above is wrong i.e. it should say something 
like "Only in-built Simba PCI-PCI bridges can exist on the root bus".


ATB,

Mark.


