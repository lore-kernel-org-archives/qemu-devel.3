Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4EC4C25B75
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 08:16:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9KfA-0007R1-Gd; Tue, 21 May 2024 04:16:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1s9Kf9-0007QQ-4B
 for qemu-devel@nongnu.org; Tue, 21 May 2024 04:15:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1s9Kf5-0003S6-Bp
 for qemu-devel@nongnu.org; Tue, 21 May 2024 04:15:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716279352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+xCs0UxdAJzUtq846EqQz/nKKXT5zzbrJMLqJxklm2I=;
 b=W9+WNvjxbQoP182f4CnP2r4SL9jzCu4enCShzDSiy4iWkYPDSS0suPBEMPj1VWxum8YSSC
 zNh2vI7EYDrKDS6qXjsDig+vcxKYlaCEQHWpafp6RhCkfSOoP73LCHnNr1PJ4mQLzRT+5S
 dHglPPDhtkoVi0yHrHTP5zXBEvtnsqQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-IeVNIg4eMOq7LkPReLytsA-1; Tue, 21 May 2024 04:15:50 -0400
X-MC-Unique: IeVNIg4eMOq7LkPReLytsA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-41ffb6bc28fso48100005e9.2
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 01:15:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716279349; x=1716884149;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=+xCs0UxdAJzUtq846EqQz/nKKXT5zzbrJMLqJxklm2I=;
 b=PIIecRrRg9x9KVmwLVU4KTDFVlTJOERpDPJ6NH0A4UmMqBqTi2K5XI0TnpnretiOhx
 YgGYzik2a8HIVEBByvrNCgU/2xkY5jpEzGOwq+/ubZXDh/0ZyOQmuHXFXjayPrcGgiNE
 BB4xP3PiWBACeqvcIramhu7lNHMnUtvPS7lSG1go3mB9oEmRDj/pvs2YY7tjOKyI7R+v
 FDRZ0PUgxNTMF1F3aqYookwyxC0JCGDE8zneLosBKzDxGn4DKPwLe1YZxwOAp53wZu+X
 ZcY9A/SpQEFMgM/IwwNGy42LpnBfTDbssgrzarugEXMETRYMg9edGIzrIF6Z4IGchn75
 26ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCVENeo0nL/FpNGnxisXc9vU7oQzk5CclfstW/iIgM8tePP9lyln3GP6c/aFjKQzwZtbL9ReR0jfTM/33I29V2C+0YX/qZo=
X-Gm-Message-State: AOJu0Ywm77lEe0fMFN1SyiwaC9KXbgs1WhC2FwZvymC88L7DFGakCUmd
 OouVSqWnYkrwsNLkOd5DYxzUAZsL69XfX4pYoHpl6sigBvVcbl93y+nfwvlVRSfBUUfI3/55obn
 IO2QfKBwYcLmGX6GF3afLzRCaFG31Kx5PJCclNDf24FZMclRi66a1
X-Received: by 2002:a05:600c:1f87:b0:41a:aa6:b59e with SMTP id
 5b1f17b1804b1-41fea931b71mr367550565e9.5.1716279348984; 
 Tue, 21 May 2024 01:15:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2WKNYnS6Ngw1eQeLF5BrIrliMZOG6k4q6x2JX16CQvcv3Ac8JB6u1ejIS6XBMvJ5oqQvrww==
X-Received: by 2002:a05:600c:1f87:b0:41a:aa6:b59e with SMTP id
 5b1f17b1804b1-41fea931b71mr367550285e9.5.1716279348477; 
 Tue, 21 May 2024 01:15:48 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7?
 ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42010940845sm375788025e9.35.2024.05.21.01.15.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 May 2024 01:15:48 -0700 (PDT)
Message-ID: <b74a118b-d943-4ab5-a91d-e4e99d41a003@redhat.com>
Date: Tue, 21 May 2024 10:15:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/riscv/virt: Add hotplugging and virtio-md-pci support
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Santosh Mamila <santosh.mamila@catalinasystems.io>,
 Chethan Seshadri <Chethan.Seshadri@catalinasystems.io>,
 Sivakumar Munnangi <siva.munnangi@catalinasystems.io>
References: <20240514110615.399065-1-bjorn@kernel.org>
 <3cb00bbb-7742-40b7-858c-4bdd2f9cc79b@ventanamicro.com>
 <91086379-1fbc-4179-863a-6bb2e797d564@redhat.com>
 <afbd3799-fa2a-4c7d-8097-aeaedecf4ec3@ventanamicro.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <afbd3799-fa2a-4c7d-8097-aeaedecf4ec3@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 19.05.24 11:24, Daniel Henrique Barboza wrote:
> 
> On 5/18/24 16:50, David Hildenbrand wrote:
>>
>> Hi,
>>
>>
>>>> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
>>>> index 4fdb66052587..16c2bdbfe6b6 100644
>>>> --- a/hw/riscv/virt.c
>>>> +++ b/hw/riscv/virt.c
>>>> @@ -53,6 +53,8 @@
>>>>     #include "hw/pci-host/gpex.h"
>>>>     #include "hw/display/ramfb.h"
>>>>     #include "hw/acpi/aml-build.h"
>>>> +#include "hw/mem/memory-device.h"
>>>> +#include "hw/virtio/virtio-mem-pci.h"
>>>>     #include "qapi/qapi-visit-common.h"
>>>>     #include "hw/virtio/virtio-iommu.h"
>>>> @@ -1407,6 +1409,7 @@ static void virt_machine_init(MachineState *machine)
>>>>         DeviceState *mmio_irqchip, *virtio_irqchip, *pcie_irqchip;
>>>>         int i, base_hartid, hart_count;
>>>>         int socket_count = riscv_socket_count(machine);
>>>> +    hwaddr device_memory_base, device_memory_size;
>>>>         /* Check socket count limit */
>>>>         if (VIRT_SOCKETS_MAX < socket_count) {
>>>> @@ -1553,6 +1556,25 @@ static void virt_machine_init(MachineState *machine)
>>>>         memory_region_add_subregion(system_memory, memmap[VIRT_MROM].base,
>>>>                                     mask_rom);
>>>> +    device_memory_base = ROUND_UP(s->memmap[VIRT_DRAM].base + machine->ram_size,
>>>> +                                  GiB);
>>>> +    device_memory_size = machine->maxram_size - machine->ram_size;
>>>> +
>>>> +    if (riscv_is_32bit(&s->soc[0])) {
>>>> +        hwaddr memtop = device_memory_base + ROUND_UP(device_memory_size, GiB);
>>>> +
>>>> +        if (memtop > UINT32_MAX) {
>>>> +            error_report("Memory exceeds 32-bit limit by %lu bytes",
>>>> +                         memtop - UINT32_MAX);
>>>> +            exit(EXIT_FAILURE);
>>>> +        }
>>>> +    }
>>>> +
>>>> +    if (device_memory_size > 0) {
>>>> +        machine_memory_devices_init(machine, device_memory_base,
>>>> +                                    device_memory_size);
>>>> +    }
>>>> +
>>>
>>> I think we need a design discussion before proceeding here. You're allocating all
>>> available memory as a memory device area, but in theory we might also support
>>> pc-dimm hotplugs (which would be the equivalent of adding physical RAM dimms to
>>> the board.) in the future too. If you're not familiar with this feature you can
>>> check it out the docs in [1].
>>
>> Note that DIMMs are memory devices as well. You can plug into the memory device area both, ACPI-based memory devices (DIMM, NVDIMM) or virtio-based memory devices (virtio-mem, virtio-pmem).
>>
>>>
>>> As an example, the 'virt' ARM board (hw/arm/virt.c) reserves a space for this
>>> type of hotplug by checking how much 'ram_slots' we're allocating for it:
>>>
>>> device_memory_size = ms->maxram_size - ms->ram_size + ms->ram_slots * GiB;
>>>
>>
>> Note that we increased the region size to be able to fit most requests even if alignment of memory devices is weird. See below.
>>
>> In sane setups, this is usually not required (adding a single additional GB for some flexiility might be good enough).
>>
>>> Other boards do the same with ms->ram_slots. We should consider doing it as well,
>>> now, even if we're not up to the point of supporting pc-dimm hotplug, to avoid
>>> having to change the memory layout later in the road and breaking existing
>>> setups.
>>>
>>> If we want to copy the ARM board, ram_slots is capped to ACPI_MAX_RAM_SLOTS (256).
>>> Each RAM slot is considered to be a 1GiB dimm, i.e. we would reserve 256GiB for
>>> them.
>>
>> This only reserves some *additional* space to fixup weird alignment of memory devices. *not* the actual space for these devices.
>>
>> We don't consider each DIMM to be 1 GiB in size, but add an additional 1 GiB in case we have to align DIMMs in physical address space.
>>
>> I *think* this dates back to old x86 handling where we aligned the address of each DIMM to be at a 1 GiB boundary. So if you would have plugged two 128 MiB DIMMs, you'd have required more than 256 MiB of space in the area after aligning inside the memory device area.
>>
> 
> Thanks for the explanation. I missed the part where the ram_slots were being
> used just to solve potential alignment issues and pc-dimms could occupy the same
> space being allocated via machine_memory_devices_init().
> 
> This patch isn't far off then. If we take care to avoid plugging unaligned memory
> we might not even need this spare area.

Right.

> 
>>>
>>> Note: I do not have the visibility of discussions on the memory management space,
>>> and I might be missing details such as "we don't care about pc-dimm hotplug
>>> anymore, it's legacy, we're going to support only virtio-md-pci from now on". We
>>> had a situation like that with virtio-balloon and virtio-mem in the past, and I'm
>>> not sure if this might fall in the same category.
>>
>> Not sure if I got your comment right, but virtio-mem was never supposed to be a virtio-balloon replacement (especially of the free-page-reporting and memory stats part).
> 
> I was trying to refer to a situation we faced 3+ years ago in the powerpc machines,
> where we were trying to add virtio-mem support there given that virtio-mem is/was
> been seen (as far as I can remember anyways) as a more robust solution than
> virtio-balloon + DIMM hotplug for guest memory management from the host point of
> view.

I only heard once that ppc support was being worked on, but don't know 
of any details what the issue was. PPC+KVM is not really a priority 
anymore, so my primary focus for the future is adding s390x support (I 
had prototypes but some things are tricky).

Supporting architectures that do their own weird paravirtualized stuff 
already or don't really support memory hotplug is a bit more tricky than 
the others. PPC with dlpar falls into that category :)

-- 
Cheers,

David / dhildenb


