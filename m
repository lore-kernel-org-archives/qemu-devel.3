Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14173C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 20:29:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgpwL-0002gS-TN; Mon, 06 Jul 2026 16:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgpwG-0002ff-SE
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 16:29:13 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgpwD-0007mr-V7
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 16:29:12 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KEVXn1496587
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 20:29:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XgZ5jQA5manY1niBMM7UAgeZUpljK+RueM5KPGWLHhQ=; b=NTp80+jUsjmEuSfx
 rswLn5mlQF62BW2jv63fiyKmW7NhR/dgW3UCvfPVv9tMNHhpu9LZ/4+8z+w49R7g
 rWRgBXupQnWj07EQOk1lTeAe4fOFr2Oqbf3Qs4GWFM0oocWZpz4wNHkxFpUwoU0I
 6NeOFZEXuZ50bzlRyHb+SjuE0H4UEDO/o78UnXtLq77TO0vAF0c33i9tPngYcRmz
 XdHS14MR3+i2StezW3O7jKSMSroUGm7IfrUa1BwRFgud6GNrafNKSUds6MJqJ18K
 iZnwTylA5AXq4QhF73njCMHXOt/AqlnG2PxxhbZ7klVRzsDRlvRjCGmxS/TIeNR0
 Ua2jHw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88t8b426-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 20:29:08 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e8004d60eso544286185a.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 13:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783369747; x=1783974547; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XgZ5jQA5manY1niBMM7UAgeZUpljK+RueM5KPGWLHhQ=;
 b=bjUmKzEUuesITSzJdb3UyJBCHKuMGG28B7l75TwwrFUB+hdZHZUeoM9pm3lHgBP6iX
 3taStMjUv/BBZgCdcH0rNoEiYpm+A8D8Qg+L/9ICf15Q+Ij3AKHgnUDqajxzUDJSDdF7
 BRBmVYAsCPS7FaZW3K+52/jJIn6T0l3XLEp9aSPJpueut4qHhWC7hK8ZwuDwXt1OTzgO
 4buG/e2ikDgbCK//hvOVI5hQt4EZ0hVRccv9hH7jv44AjUSvWP11QcTaAkLQCzf+a/xq
 bkyd8vnbD0I40Qa7Ia1K18m/cWI2Gk2S3Hkq4naIC7DiTNseHE/vHRRNbkpg6/wV8qzw
 dqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783369747; x=1783974547;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XgZ5jQA5manY1niBMM7UAgeZUpljK+RueM5KPGWLHhQ=;
 b=k7q8f70lGlrJW6fbN3Oofq4TiIw8INyQKS3OEQj5UtbZQwIhngktaWFcpruq+iiPpK
 d17nXj+p4w5+rdOxqnL3sj1yMzkDZQ4f4w70rlFHMK4b9pISVOoJR+TahdLqaRZL35sO
 Nrx7Bc/pAg5/NVUTzadq64gg0ojDUeQJtst1o3vNMv4LJ2u/Zyz4MHYDIaWEyAnMoXM2
 A5TLpj/bSZgvw5aEtwHXiDPZWRcTmYlnfjMfS2+ntT9ejf/EH5XfHSz24FxfOGyrGgg7
 FNyRzvIfUGQk3RlGA09vJ9Jd/ek+TUwhwM8VTZ4/Bc0lRCwAJ+96Nbxzoz5iFQJDVpzy
 Q8ng==
X-Forwarded-Encrypted: i=1;
 AHgh+RqFhzfoGaX/tW60YqX+WnQLr3fQsBbdj5c942Bl0GNugaylkS0DT4KoMEhq7QsfFOnvP40MgeraY8CL@nongnu.org
X-Gm-Message-State: AOJu0Yzd+Q3mZuGLjXcCyWZVwzYYPzqQKKZLZEI3WTE/r8c5J7qf6nVt
 Wn/sQ/E6E0tAj+peoWwPYuWClAGJysgjrwiXvmp9W6MVFif2wee8P8clEW/PYQhNGq8T62tGLKL
 yowGLhPehWrVXnQqoAHI9v5xWjsf1Vrjpiy6eRSH6zSP6NrVMS4GpW9L8lw==
X-Gm-Gg: AfdE7ckP7t60VNpJGlo0ip4TyhqwXN6h1NA6T0bsPvTvhq05cTJ/bHEOiQk5Zk1NTUw
 g4pRU8S84Pz+2mA+OKn2lsTNWfeZBeEYLiK5z5BBnniSvwcdA7g9aCZCQgv4hTtIlpJqj3oW5Hp
 D2z5grN6AHu5siPYfnX8awklvfIUOkPem1EQZB4ad5zQpX9J+uY4FBF3fthMsXSZS8vXkB6xTY+
 4u2MNYcRjYd3Gx239/JwggCnNt/U1iHpkTR+is99KlBFEDjREHVuzrxQEMgkWgNmlIgHmTfOPUc
 tReRKVRjdBejCkDWmuseYhqRpwKTkEwa2ynJ6LwmF6Hf9EM5LdjJBXzAUm3fczGDYQ0CmLlrqge
 rVZA/SsZkCYofqqrBw8xrngK9u6jDfuE8SpNVmkK03RKa8ajKcndpyArAhEGgZA==
X-Received: by 2002:a05:620a:40cf:b0:92e:44be:bbd2 with SMTP id
 af79cd13be357-92ebb52fc46mr303018885a.9.1783369747185; 
 Mon, 06 Jul 2026 13:29:07 -0700 (PDT)
X-Received: by 2002:a05:620a:40cf:b0:92e:44be:bbd2 with SMTP id
 af79cd13be357-92ebb52fc46mr303013785a.9.1783369746635; 
 Mon, 06 Jul 2026 13:29:06 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039ae4fsm28454276f8f.18.2026.07.06.13.29.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 13:29:05 -0700 (PDT)
Message-ID: <a60309be-c514-4b22-8970-ecfcf2b4fde7@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 22:29:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/sparc64/sun4u: Mark unusable PCI busses as full to
 ease device plugging
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
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
In-Reply-To: <baf0b727-d53c-4717-b4e8-9c8603b2fa75@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIwNyBTYWx0ZWRfX3dVKZvXWaXoL
 Vu9YXKj+Sq7cj/4PYs5KLIDXBLBiTIZ4bPt3wdvSkwdbLjeyF5x6ur794helnLXhWQOjccZUlyC
 bo408/WUtLLzKL3uS/LYLnC3L13wOKk=
X-Proofpoint-GUID: mYhm3nCK_5eLVkv9IuvFOJ2HaYgzlXAd
X-Authority-Analysis: v=2.4 cv=C6zZDwP+ c=1 sm=1 tr=0 ts=6a4c1014 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=20KFwNOVAAAA:8 a=2EVM4Ly4wgp9MTM8yY4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: mYhm3nCK_5eLVkv9IuvFOJ2HaYgzlXAd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIwNyBTYWx0ZWRfXyAdGyf2XihfM
 QLqa5rTON7nPEAt1bPDoxgZ59kaW/aWvUsqO3ewiapkCn/ttEVYubAaeEPE5aM6PzdcdKp7WPU9
 /JBCE7WyxozH0xjWTGlgqmpXouDqI9S4F0vZJXdAZwN1vfgAR6ys8orgt8qmIL9R7jYx3zCnCxU
 DLoYr8ydAw4VS+eXUpZqWLrsuiznp5/jLkAj8vMpHrUVRak6iQJUNNv4MK4jnbUcs6YIRLdvQxz
 mUNnaTciSjTnTJZNPDlX9rJUvy8t5C+UCms0z07xoqeeEs0qIJOVU23AEyHFylp/7vBYhnaplXx
 BRuETkAfXcnW6IFLXR2pw8TqOmCPu3J37rKCU3BCBQwV0OyFQDF7yHKwpIGHiHdsqaUNPPtEWy2
 WBpPb0X2xnP5kQkSH7DM6EOeuUKPKm9OkYYN3cjpe7OZNofX6vAz5Pe2iqB89nwZ0e8Y/6BiPth
 19pJhnoePjAKMXhdoew==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060207
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 6/7/26 19:29, Philippe Mathieu-DaudÃ© wrote:
> Hi,
> 
> On 30/6/26 00:20, Mark Cave-Ayland wrote:
>> On 29/06/2026 14:43, Thomas Huth wrote:
>>
>>> On 09/06/2026 08.02, Thomas Huth wrote:
>>>> On 08/06/2026 23.29, Mark Cave-Ayland wrote:
>>>>> On 08/06/2026 09:26, Michael Tokarev wrote:
>>>>>
>>>>>> On 30.04.2026 12:50, Thomas Huth wrote:
>>>>>>> On 09/03/2026 19.14, Thomas Huth wrote:
>>>>>>>> From: Thomas Huth <thuth@redhat.com>
>>>>>>>>
>>>>>>>> When trying to plug a PCI device to a Sparc64 machine, you 
>>>>>>>> currently
>>>>>>>> have to specify the right bus ("bus=pciB"), otherwise you get 
>>>>>>>> this error:
>>>>>>>>
>>>>>>>>   $ qemu-system-sparc64 -device virtio-scsi-pci
>>>>>>>>   qemu-system-sparc64: -device virtio-scsi-pci: PCI: no slot/ 
>>>>>>>> function
>>>>>>>>   available for virtio-scsi-pci, all in use or reserved
>>>>>>>>
>>>>>>>> This is quite annoying for the unexperienced users, and it also 
>>>>>>>> breaks
>>>>>>>> e.g. the iotests ("make check-block") when running with qemu- 
>>>>>>>> system- sparc64.
>>>>>>>>
>>>>>>>> Mark the non-usable PCI busses as full now, so that QEMU can 
>>>>>>>> automatically
>>>>>>>> plug new PCI devices to the right "pciB" bus.
>>>>>>>>
>>>>>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>>>>>> ---
>>>>>>>>   v2: Do the change in the machine code, not in the sabre device
>>>>>>>>
>>>>>>>>   hw/sparc64/sun4u.c | 7 +++++++
>>>>>>>>   1 file changed, 7 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
>>>>>>>> index b8bda1eb816..37539535c6c 100644
>>>>>>>> --- a/hw/sparc64/sun4u.c
>>>>>>>> +++ b/hw/sparc64/sun4u.c
>>>>>>>> @@ -723,6 +723,13 @@ static void sun4uv_init(MemoryRegion 
>>>>>>>> *address_space_mem,
>>>>>>>>       fw_cfg_add_i16(fw_cfg, FW_CFG_SPARC64_DEPTH, graphic_depth);
>>>>>>>>       qemu_register_boot_set(fw_cfg_boot_set, fw_cfg);
>>>>>>>> +
>>>>>>>> +    /*
>>>>>>>> +     * Mark internal PCI busses as full so that the plugging of 
>>>>>>>> additional
>>>>>>>> +     * PCI devices happens on the right bus that still has free 
>>>>>>>> slots:
>>>>>>>> +     */
>>>>>>>> +    qbus_mark_full(&pci_bus->qbus);
>>>>>>>> +    qbus_mark_full(&pci_busA->qbus);
>>>>>>>>   }
>>>>>>>>   enum {
>>>>>>>
>>>>>>> Friendly ping!
>>>>>>
>>>>>> This, being a simple change, somehow has not been reviewed still, so
>>>>>> it's sitting in the queue...
>>>>>
>>>>> Yes, apologies - I've been absolutely flat out recently, and I've 
>>>>> got a note to take a look at this and Peter's patch as soon as I can.
>>>>>
>>>>> Is this fixing an urgent issue with "make check-block" or similar?
>>>>
>>>> It's not urgent since this has been broken forever, but yes, it 
>>>> fixes "make check- block" for the case where sparc64 is the only 
>>>> available target during "configure -- target-list=sparc64-softmmu" 
>>>> and thus the iotests run with qemu-system-sparc64.
>>> Ping!
>>>
>>> While it's not urgent, soft-freeze date is in a week, so it would be 
>>> nice to get this merged before it misses another release ... WDYT?
>>
>> Hi Thomas,
>>
>> I'm still playing catch-up a bit here, but I can't immediately find my 
>> notes on using pciA under QEMU. I think if it fixes the iotests then 
>> go ahead and merge it for now, which gives me time in freeze to 
>> investigate any reported issues.


> Anyway, back to the problem here, the first part is indeed as noticed
> Thomas to use qbus_mark_full() for the root bus:
> 
> -- >8 --
> diff --git a/hw/pci-host/sabre.c b/hw/pci-host/sabre.c
> index cd2328ad53f..6a8d0b6c6d2 100644
> --- a/hw/pci-host/sabre.c
> +++ b/hw/pci-host/sabre.c
> @@ -400,6 +400,9 @@ static void sabre_realize(DeviceState *dev, Error 
> **errp)
>       s->bridgeA = PCI_BRIDGE(pci_dev);
>       pci_bridge_map_irq(s->bridgeA, "pciA", pci_simbaA_map_irq);
>       pci_realize_and_unref(pci_dev, phb->bus, &error_fatal);
> +
> +    /* Only in-built Simba APBs can exist on the root bus */
> +    qbus_mark_full(&phb->bus->qbus);
>   }
> 
>   static void sabre_init(Object *obj)
> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> index d69ed9a81ac..b65f3d1a140 100644
> --- a/hw/sparc64/sun4u.c
> +++ b/hw/sparc64/sun4u.c
> @@ -546,7 +546,7 @@ static void sun4uv_init(MemoryRegion 
> *address_space_mem,
>       unsigned int i;
>       uint64_t initrd_addr, initrd_size, kernel_addr, kernel_size, 
> kernel_entry;
>       SabreState *sabre;
> -    PCIBus *pci_bus, *pci_busA, *pci_busB;
> +    PCIBus *pci_busA, *pci_busB;
>       PCIDevice *ebus, *pci_dev;
>       SysBusDevice *s;
>       DeviceState *iommu, *dev;
> @@ -588,14 +588,13 @@ static void sun4uv_init(MemoryRegion 
> *address_space_mem,
>               qdev_get_gpio_in_named(DEVICE(cpu), "ivec-irq", i));
>       }
> 
> -    pci_bus = PCI_HOST_BRIDGE(sabre)->bus;
>       pci_busA = pci_bridge_get_sec_bus(sabre->bridgeA);
>       pci_busB = pci_bridge_get_sec_bus(sabre->bridgeB);
> 
> -    /* Only in-built Simba APBs can exist on the root bus, slot 0 on 
> busA is
> -       reserved (leaving no slots free after on-board devices) however 
> slots
> -       0-3 are free on busB */
> -    pci_bus_set_slot_reserved_mask(pci_bus, 0xfffffffc);
> +    /*
> +     * Slot 0 on busA is reserved (leaving no slots free after on-board
> +     * devices) however slots 0-3 are free on busB
> +     */
>       pci_bus_set_slot_reserved_mask(pci_busA, 0xfffffff1);
>       pci_bus_set_slot_reserved_mask(pci_busB, 0xfffffff0);
> 
> ---
> 
> I'm still looking at the 2nd part, the reserved slots.

(Because with this patch, the test passes as we can plug devices from
the command line, but they end plugged on pciA instead of pciB -- thus
the 2nd part missing).

