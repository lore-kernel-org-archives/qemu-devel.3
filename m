Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94852CCF9E3
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Oct 2025 16:48:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vChRH-0000BX-GJ; Sat, 25 Oct 2025 12:48:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vChRF-0000Aw-9L
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 12:48:21 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vChRC-0008Dg-UO
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 12:48:21 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-4270a3464caso1456858f8f.1
 for <qemu-devel@nongnu.org>; Sat, 25 Oct 2025 09:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761410897; x=1762015697; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8b9xRaJlWL+nt1fXH4LsscZYHwjDggsC/SQS05yNr9E=;
 b=WAblNiKSRaWPn9pGIJr5pJLwYLdNV1zwevI/P+mV0e0ftoQd0ukvnqXoYVnM7ZjckR
 s+0XM3ceaoKjjx4un34mm11gGasoz9ye8vc/MsiTbGCKdVyzrImEVkpdYwq5I9/rdKyx
 yXyXEjYt1BwkjdlQtLIs365s3ud6uhMQ1W2Y14YJ5J3LNYbrr9tZB38xxOwvecAteJN1
 SojuYZX7EFSixeFxH1IFmBZn7Ibb+I9jwxB18xgw0M51tmE5CuaaxZCYzZXctYeSSmPv
 rWo4p7yRwuGOq0LUx8IeNvnpSyBM11iVjbWhe/cAmGLxu2kWdyMidNx23Nb7YTe2QZdZ
 GsZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761410897; x=1762015697;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8b9xRaJlWL+nt1fXH4LsscZYHwjDggsC/SQS05yNr9E=;
 b=Wu88zjaUxwaxw3U9HRM95m/xaurZyd+3iZi78bCmX2jlf2RjX0bNQ3t41lhsQMtRDo
 Shpy1L2iJIbfF421xN98j6uVZ8H77ButlBunuY42ZdBKnLjOXWkBvIubtdVjRV6/rqJY
 5p14J14txs2r4/UyBh0HE6WUNwLXB6XNPMs0bG7ccjuTVX+zQwiyWjnjFwzzL8zYZV3c
 RzLRkb0KCWOsDpEUe1FvdZ1rcpNCJjpxIHTTo2qYgbPhzm0BfHi1AhoalIf+DkEwPPSI
 lqv6Fttn0Yom3NTF6lEqc5zCjvCygfEWSjddrKKxL2aWLTeaFlzLn/VkpHEZdpHOR0oW
 PIwg==
X-Gm-Message-State: AOJu0Yys/WFIQ4+mjMeFfCCNiX4Eg5/Po6vLwn+QVKldPV3yhw3p92JP
 0ifZCGuRy/aITfc9Rgck7S+nhlV9KYD2eqecABHiiXlKIXcPu8aGcWEcITD05hmtw9E=
X-Gm-Gg: ASbGncu1IoOzt+ocGBp8eDpTFK8jjTFTtyZB/beIP/hlp1BlsrHhP8BNcKyDhzXSQzO
 6gFu2f+iUnxEEaFxxpIQdUZx2vCXnkHGWkv/KqOAWanACXsqDP0hOziIDYdoekXLwt3L3u4E8fq
 ZebirDPMnTjsLnOYXg9sfCQmwuOyBZA67GSEAD15ms69RQ+Fweq8KAdZ5Xfl43Gc68Ug76aArlY
 2btgzmPEz+UAoUa19mMcv4yJPIQrSvolq/J86r5XoVfNDudSwQ1ZaSooR4Q27uwIgSszg4C9oPr
 a6bYMa9KTOXfwGzICsVl2lu0rYwvMSDkngcc2N1HlxCH6xubAUZpEg4LpKN44VpwFCZUJkz+zAN
 80fQk/zzA/EyHh0VsgjT2WLdCbaVMf04EdtST8cahoz7YuTEatI2ZXjBWTfIvOmO6sNfVPZwFPQ
 e9+n/y0k4JVaBnFnNgIcPaMFKDtNXsvJ5sL51Z0TZSpQk=
X-Google-Smtp-Source: AGHT+IGZ/hKZsKg7fTySQTIzCPM2+0XG00VcSx5LKzVRwpTeIpv9gKt/sgKUAfuh+4TLI0DsmVqT4Q==
X-Received: by 2002:a05:6000:2890:b0:428:3fcb:197f with SMTP id
 ffacd0b85a97d-4298a0ed388mr8717808f8f.63.1761410896852; 
 Sat, 25 Oct 2025 09:48:16 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952b7badsm4414143f8f.7.2025.10.25.09.48.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Oct 2025 09:48:16 -0700 (PDT)
Message-ID: <4dc7b5ba-176b-4e2a-876c-a911793dab13@linaro.org>
Date: Sat, 25 Oct 2025 18:48:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/13] hw/pci-host/raven: Do not map regions in init
 method
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <cover.1761232472.git.balaton@eik.bme.hu>
 <586026b62dd514cc2c4bc0a67346d9e79d13dee6.1761232473.git.balaton@eik.bme.hu>
 <809dd471-4acd-4f14-80eb-3454a365b69a@ilande.co.uk>
 <370952a5-c0a0-98db-3c05-328bf773af60@eik.bme.hu>
 <58055dac-2263-4a29-7bb6-424bb38e4ef3@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <58055dac-2263-4a29-7bb6-424bb38e4ef3@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 25/10/25 16:49, BALATON Zoltan wrote:
> Hello,
> 
> Added a few more people to cc hoping to get some opinion to clear this 
> up. This is brought up by my patch trying to simplify hw/pci-host/ 
> raven.c part of this series:
> https://patchew.org/QEMU/cover.1761232472.git.balaton@eik.bme.hu/
> (First submitted in May here:
> https://patchew.org/QEMU/cover.1746374076.git.balaton@eik.bme.hu/
> but that went relatively unnoticed and missed the previous release.)
> Find discussion below the patch.
> 
> On Sat, 25 Oct 2025, BALATON Zoltan wrote:
>> On Fri, 24 Oct 2025, Mark Cave-Ayland wrote:
>>> On 23/10/2025 16:26, BALATON Zoltan wrote:
>>>> Export memory regions as sysbus mmio regions and let the board code
>>>> map them similar to how it is done in grackle. While at it rename
>>>> raven_pcihost_realizefn to raven_pcihost_realize.
>>>>
>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> ---
>>>>   hw/pci-host/raven.c | 38 +++++++++++++-------------------------
>>>>   hw/ppc/prep.c       | 10 ++++++++--
>>>>   2 files changed, 21 insertions(+), 27 deletions(-)


>>>> @@ -180,7 +178,18 @@ static void raven_pcihost_realizefn(DeviceState 
>>>> *d, Error **errp)
>>>>         qdev_init_gpio_in(d, raven_change_gpio, 1);
>>>>   +    memory_region_init(&s->pci_io, o, "pci-io", 0x3f800000);
>>>> +    memory_region_init_io(&s->pci_discontiguous_io, o,
>>>> +                          &raven_io_ops, &s->pci_io,
>>>> +                          "pci-discontiguous-io", 8 * MiB);
>>>> +    memory_region_set_enabled(&s->pci_discontiguous_io, false);
>>>> +    memory_region_init(&s->pci_memory, o, "pci-memory", 0x3f000000);
>>>> +
>>>> +    sysbus_init_mmio(dev, &s->pci_io);
>>>> +    sysbus_init_mmio(dev, &s->pci_discontiguous_io);
>>>> +    sysbus_init_mmio(dev, &s->pci_memory);
>>>>       sysbus_init_irq(dev, &s->irq);
>>>> +
>>>>       h->bus = pci_register_root_bus(d, NULL, raven_set_irq, 
>>>> raven_map_irq,
>>>>                                      &s->irq, &s->pci_memory, &s- 
>>>> >pci_io, 0, 1,
>>>>                                      TYPE_PCI_BUS);
>>>> @@ -219,32 +228,12 @@ static void 
>>>> raven_pcihost_realizefn(DeviceState *d, Error **errp)
>>>>       pci_setup_iommu(h->bus, &raven_iommu_ops, s);
>>>>   }
>>>>   -static void raven_pcihost_initfn(Object *obj)
>>>> -{
>>>> -    PREPPCIState *s = RAVEN_PCI_HOST_BRIDGE(obj);
>>>> -    MemoryRegion *address_space_mem = get_system_memory();
>>>> -
>>>> -    memory_region_init(&s->pci_io, obj, "pci-io", 0x3f800000);
>>>> -    memory_region_init_io(&s->pci_discontiguous_io, obj,
>>>> -                          &raven_io_ops, &s->pci_io,
>>>> -                          "pci-discontiguous-io", 8 * MiB);
>>>> -    memory_region_init(&s->pci_memory, obj, "pci-memory", 0x3f000000);
>>>> -
>>>> -    /* CPU address space */
>>>> -    memory_region_add_subregion(address_space_mem, PCI_IO_BASE_ADDR,
>>>> -                                &s->pci_io);
>>>> -    memory_region_add_subregion_overlap(address_space_mem, 
>>>> PCI_IO_BASE_ADDR,
>>>> -                                        &s->pci_discontiguous_io, 1);
>>>> -    memory_region_set_enabled(&s->pci_discontiguous_io, false);
>>>> -    memory_region_add_subregion(address_space_mem, 0xc0000000, &s- 
>>>> >pci_memory);
>>>> -}
>>>> -


>>>> @@ -293,6 +296,9 @@ static void ibm_40p_init(MachineState *machine)
>>>>       pcihost = SYS_BUS_DEVICE(dev);
>>>>       object_property_add_child(qdev_get_machine(), "raven", 
>>>> OBJECT(dev));
>>>>       sysbus_realize_and_unref(pcihost, &error_fatal);
>>>> +    sysbus_mmio_map(pcihost, 0, PCI_IO_BASE_ADDR);
>>>> +    sysbus_mmio_map_overlap(pcihost, 1, PCI_IO_BASE_ADDR, 1);
>>>> +    sysbus_mmio_map(pcihost, 2, PCI_MEM_BASE_ADDR);
>>>>       pci_bus = PCI_BUS(qdev_get_child_bus(dev, "pci.0"));
>>>>       if (!pci_bus) {
>>>>           error_report("could not create PCI host controller");
>>>
>>> In general the expectation is that memory regions should be 
>>> initialised in the _init() function, unless they depend upon a 
>>> property in which case they should be initialised in the _realize() 
>>> function. Why do you feel this needs to be different?
>>
>> Is any of it needed before realize? If not why have an init method at 
>> all? As shown here this works perfectly without one and is more 
>> comprehensible that way for people reading it without deep knowledge 
>> about Qdev. In general I think simple devices only need a realize 
>> method and the init method is rarely needed, e.g. if there are some 
>> child objects that need to be init for passing properties that can be 
>> set before realize or similar unusual cases but for most classes init 
>> is not needed at all. I only want to keep what's necessary and remove 
>> everything that's not needed. I think that makes the device model 
>> easier to understand.
> 
> I've checked documentation here:
> https://www.qemu.org/docs/master/devel/qdev-api.html
> but it's not really clear on what's the preferred way of using init and 
> realize. It's not even very clear on when to use which to me. So becuase 
> that did not help I did a quick survey on what other pci-host models do. 
> Of the 32 .c files in hw/pci-host 16 have an init method:
> 
> aspeed_pcie.c, astro.c, designware.c, gpex.c, grackle.c, i440fx.c, 
> pnv_phb3.c, pnv_phb3_msi.c, pnv_phb3_pbcq.c, pnv_phb4.c, q35.c, raven.c, 
> sabre.c, uninorth.c, versatile.c, xilinx-pcie.c
> 
> Of these astro.c has an empty init function that should be removed; 
> grackle.c, sabre.c and uninorth.c are maintained by you so I'll ignore 
> them here; we're discussing raven.c now and i440fx.c has two 
> memory_region_init_io calls in init that could be in realize where all 
> others are and otherwise all other models do this in realize and only 
> init child objects and add properties in init methods when that's needed 
> because they need to be available before realize. The other 16 device 
> models don't have an init method at all and do all in the realize like I 
> proposed in this patch for raven. Since only device models that you 
> maintain do it differently I think what you say is not following the 
> preferred way so you should not block this patch.
> 
> I'd be interested if there is a consensus on this or can we cone to one 
> that we can document to avoid this repeating every time.

I've been told to stop arguing about QDev on the mailing list, and
instead spend my time and energy in documenting QDev, so we'll discuss
the documentation patches :)

Also we'll try to provide a QDev meaningful state machine, which will
help to enforce doing in the correct places.


Meanwhile...

.instance_init is actually QOM layer, it is called once, and can
not fail. What is allocated here has to be de-allocated in 
.instance_finalize.

.realize is QDev where we check the device properties, reporting error.
What is allocated/configured there has to be de-allocated in .unrealize.

The big difference is for hot-pluggable devices, where unplug calls
unrealize(), keeping the device initialized. Re-plug calls .realize()
again, and we should be able to do that multiple times.

With that in mind, IMO it is better to allocate all we can once in
.instance_init().

