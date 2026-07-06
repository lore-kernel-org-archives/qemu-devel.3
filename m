Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3075C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 21:16:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgqfz-0001H5-SD; Mon, 06 Jul 2026 17:16:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1wgqfs-0001FC-4U; Mon, 06 Jul 2026 17:16:21 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1wgqfq-00056R-65; Mon, 06 Jul 2026 17:16:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=kOsomt8mCr62O+0LhqBZdVk01ekIvRUdGGbbg6oOnj0=; b=iuV+ClKc29vYY1vlEv2S056iPp
 G2qea4n5qMAuIggSMamaMBIcm39lm9+dq1JrRAq2FY8ZRLErqzAcgOqSEQxZNUMh8zfNliJ8iG2ty
 Umi6FWcENHsCoGr37bZP/4v8LkZrZQTtbIUL6x/eZx2f4l2ZeFKKpnKbk/F7vGuFiJowmy90Ai+Wz
 HdegY8NWjvKuHevCeKNvQMKdWQ56+8/VBAtXSrh92djz1LxQnEyo7HaNfQG3oqM8J47qvMZq4vJDF
 CG/0rSRHTvYL3tENHbw+nXnWySndbYBjnk46ugNjNEvxAV/njN2UMIYgam3Rt5smljWUcx7V7JQxJ
 vtCIvS6XX07es4wdrobyOxf+aUjG/1sMTVPNXiyO1/Zw93PCrDLhTTjEeZZnOf/wu/Ep4b1GgL4WW
 GAxlEmsB1RsX/XpkvH8gSOnIrrHGguMPAPS/RfdZvQIPYH2GEEnJFPzbxIh5AgEwGa5gfqnC0d9Bv
 2IbwzOJ9HT1GqeEN04VvLVoXeik0PZ/ulTvoMXGhDL43NX6Ke/QwacTEmCZBRCCHcodDv16q3ssqw
 fv3fLdX3tAsq1rPVwRWoVFOGrXWTyZXpJ+ryoam5oSNIFVWBLdpxH0M55BbvqpPEWX865JT51j2ZH
 bLTsvqwmq7G+o5j5wnUOaHGlG26KwOdslWhAcYFNQ=;
Received: from [2a02:8012:2f01:0:76dc:834a:3475:8909]
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1wgqfd-001Nj0-VO; Mon, 06 Jul 2026 22:16:06 +0100
Message-ID: <c7b0d42c-4243-4f52-88ec-7f1deac160fc@ilande.co.uk>
Date: Mon, 6 Jul 2026 22:16:06 +0100
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
 <a60309be-c514-4b22-8970-ecfcf2b4fde7@oss.qualcomm.com>
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
In-Reply-To: <a60309be-c514-4b22-8970-ecfcf2b4fde7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:76dc:834a:3475:8909
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

On 06/07/2026 21:29, Philippe Mathieu-Daudé wrote:

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
> 
> 
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
>> +    qbus_mark_full(&phb->bus->qbus);
>>   }
>>
>>   static void sabre_init(Object *obj)
>> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
>> index d69ed9a81ac..b65f3d1a140 100644
>> --- a/hw/sparc64/sun4u.c
>> +++ b/hw/sparc64/sun4u.c
>> @@ -546,7 +546,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
>>       unsigned int i;
>>       uint64_t initrd_addr, initrd_size, kernel_addr, kernel_size, kernel_entry;
>>       SabreState *sabre;
>> -    PCIBus *pci_bus, *pci_busA, *pci_busB;
>> +    PCIBus *pci_busA, *pci_busB;
>>       PCIDevice *ebus, *pci_dev;
>>       SysBusDevice *s;
>>       DeviceState *iommu, *dev;
>> @@ -588,14 +588,13 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
>>               qdev_get_gpio_in_named(DEVICE(cpu), "ivec-irq", i));
>>       }
>>
>> -    pci_bus = PCI_HOST_BRIDGE(sabre)->bus;
>>       pci_busA = pci_bridge_get_sec_bus(sabre->bridgeA);
>>       pci_busB = pci_bridge_get_sec_bus(sabre->bridgeB);
>>
>> -    /* Only in-built Simba APBs can exist on the root bus, slot 0 on busA is
>> -       reserved (leaving no slots free after on-board devices) however slots
>> -       0-3 are free on busB */
>> -    pci_bus_set_slot_reserved_mask(pci_bus, 0xfffffffc);
>> +    /*
>> +     * Slot 0 on busA is reserved (leaving no slots free after on-board
>> +     * devices) however slots 0-3 are free on busB
>> +     */
>>       pci_bus_set_slot_reserved_mask(pci_busA, 0xfffffff1);
>>       pci_bus_set_slot_reserved_mask(pci_busB, 0xfffffff0);
>>
>> ---
>>
>> I'm still looking at the 2nd part, the reserved slots.
> 
> (Because with this patch, the test passes as we can plug devices from
> the command line, but they end plugged on pciA instead of pciB -- thus
> the 2nd part missing).

Thanks for taking a look, Phil. IIRC the reason I added slot_reserved_mask was so 
that it was possible to populate pciA programatically in sun4uv_init(), and then 
enable the mask so that specifying an additional PCI device using -device on the 
command line without an explict PCI bus would cause the automatic allocation to place 
the device on pciB.


ATB,

Mark.


