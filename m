Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 396FFC25B75
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2024 09:25:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8cmX-0007Wq-2P; Sun, 19 May 2024 05:24:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1s8cmR-0007WS-HD
 for qemu-devel@nongnu.org; Sun, 19 May 2024 05:24:35 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1s8cmO-0001Sp-OD
 for qemu-devel@nongnu.org; Sun, 19 May 2024 05:24:34 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1ee7963db64so50286365ad.1
 for <qemu-devel@nongnu.org>; Sun, 19 May 2024 02:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1716110671; x=1716715471; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YV0NnIhXRzFdTmmqut057LfXxlesO2gOd0FPWMAf71Q=;
 b=KOM7r9uNAFJueRI8YheWStYwxVO/aTHxLYVk76BCxJxMKUVHbnVtR6+rM193JuX05m
 5jjtxLeHg3jcpLAgWyZ6+GvM4SdYTPFBOr16wxsSaIM4agpOSKq9mJBqis8GfwWwy/IZ
 ld8sBjeKiSnYOtjnUAT55bpXlTQB38kB7MDk6eFFNMH1wl+C3s/4NA7M8UbotyFrX4Ft
 7LSIfrAVTzb3bRMVWE2KV5t9TFCdE8pRdTbENEORq9iFVbdlJ8uD5zJuuM/nUZZgvdDs
 hcmEoeIt07eAleDKc0UWoXIpym4vAqZiFePwejVEmgDnt4S+ntZczLq8CX6+Ax+uZzZ5
 KXxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716110671; x=1716715471;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YV0NnIhXRzFdTmmqut057LfXxlesO2gOd0FPWMAf71Q=;
 b=nwb6q1H4OnsHuwlidVNQbgEUntzg9z86bAEIcTINK683pARJ4n/ySXJ5DugW0qi3L8
 4XNnmGz5mJ2uMIey1qeM5Ia+pd3qVFzPmBDUG9vYOfx1ubFVqZwL2UNWW6sQE5ls6q+U
 2dPFKXp/FBLk+z7cGWInvqAjJKTbN9Tzo5LDq4e9wLOjIFFjNCPQ+zJuwUpYm4spvFqq
 LWKPuJICXJ3rc5Ky8GinpHrZakirBmDIn5TXnxf7Es7GJjXh6lLcBg2EpRV5D4jOFrcZ
 50SkaAL3uh54l+jwGUiE0b3ZASzyUrLHG1WGph4ycmQJtLHxl+sP6bOeRyqmZJRAu323
 RmaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/pe7uP89YrM4PNMtr115Hh0DNHDCgL6YRGpGGyZHqwu9CXzDexd9DpevvPCRDCy45AQInd9mPymldXg8kqzhKbyO4lk4=
X-Gm-Message-State: AOJu0Yz1RIXNM0YFxoBMYt7F0ogtLOCrIb9g012JV846OSUAH3Z/mOP+
 D3e3VR4rFaviHqyaGfyf3w27LmO7vrKSUQTOHd4EChKES13cgHAKnCHBBr8Dpxo=
X-Google-Smtp-Source: AGHT+IG4Lg7YVayGWha2kblJdJje6RwdJ0zeG3A1RGVWpPQsXKXUQ7ZA4uvytiDjGCGupwlsC4I4uw==
X-Received: by 2002:a17:90a:cb8b:b0:2bd:76f6:8d30 with SMTP id
 98e67ed59e1d1-2bd76f68da6mr503251a91.32.1716110670757; 
 Sun, 19 May 2024 02:24:30 -0700 (PDT)
Received: from [192.168.68.110] ([177.94.42.57])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2b6c51b3482sm16743763a91.20.2024.05.19.02.24.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 May 2024 02:24:30 -0700 (PDT)
Message-ID: <afbd3799-fa2a-4c7d-8097-aeaedecf4ec3@ventanamicro.com>
Date: Sun, 19 May 2024 06:24:23 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/riscv/virt: Add hotplugging and virtio-md-pci support
To: David Hildenbrand <david@redhat.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
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
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <91086379-1fbc-4179-863a-6bb2e797d564@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x629.google.com
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


On 5/18/24 16:50, David Hildenbrand wrote:
> 
> Hi,
> 
> 
>>> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
>>> index 4fdb66052587..16c2bdbfe6b6 100644
>>> --- a/hw/riscv/virt.c
>>> +++ b/hw/riscv/virt.c
>>> @@ -53,6 +53,8 @@
>>>    #include "hw/pci-host/gpex.h"
>>>    #include "hw/display/ramfb.h"
>>>    #include "hw/acpi/aml-build.h"
>>> +#include "hw/mem/memory-device.h"
>>> +#include "hw/virtio/virtio-mem-pci.h"
>>>    #include "qapi/qapi-visit-common.h"
>>>    #include "hw/virtio/virtio-iommu.h"
>>> @@ -1407,6 +1409,7 @@ static void virt_machine_init(MachineState *machine)
>>>        DeviceState *mmio_irqchip, *virtio_irqchip, *pcie_irqchip;
>>>        int i, base_hartid, hart_count;
>>>        int socket_count = riscv_socket_count(machine);
>>> +    hwaddr device_memory_base, device_memory_size;
>>>        /* Check socket count limit */
>>>        if (VIRT_SOCKETS_MAX < socket_count) {
>>> @@ -1553,6 +1556,25 @@ static void virt_machine_init(MachineState *machine)
>>>        memory_region_add_subregion(system_memory, memmap[VIRT_MROM].base,
>>>                                    mask_rom);
>>> +    device_memory_base = ROUND_UP(s->memmap[VIRT_DRAM].base + machine->ram_size,
>>> +                                  GiB);
>>> +    device_memory_size = machine->maxram_size - machine->ram_size;
>>> +
>>> +    if (riscv_is_32bit(&s->soc[0])) {
>>> +        hwaddr memtop = device_memory_base + ROUND_UP(device_memory_size, GiB);
>>> +
>>> +        if (memtop > UINT32_MAX) {
>>> +            error_report("Memory exceeds 32-bit limit by %lu bytes",
>>> +                         memtop - UINT32_MAX);
>>> +            exit(EXIT_FAILURE);
>>> +        }
>>> +    }
>>> +
>>> +    if (device_memory_size > 0) {
>>> +        machine_memory_devices_init(machine, device_memory_base,
>>> +                                    device_memory_size);
>>> +    }
>>> +
>>
>> I think we need a design discussion before proceeding here. You're allocating all
>> available memory as a memory device area, but in theory we might also support
>> pc-dimm hotplugs (which would be the equivalent of adding physical RAM dimms to
>> the board.) in the future too. If you're not familiar with this feature you can
>> check it out the docs in [1].
> 
> Note that DIMMs are memory devices as well. You can plug into the memory device area both, ACPI-based memory devices (DIMM, NVDIMM) or virtio-based memory devices (virtio-mem, virtio-pmem).
> 
>>
>> As an example, the 'virt' ARM board (hw/arm/virt.c) reserves a space for this
>> type of hotplug by checking how much 'ram_slots' we're allocating for it:
>>
>> device_memory_size = ms->maxram_size - ms->ram_size + ms->ram_slots * GiB;
>>
> 
> Note that we increased the region size to be able to fit most requests even if alignment of memory devices is weird. See below.
> 
> In sane setups, this is usually not required (adding a single additional GB for some flexiility might be good enough).
> 
>> Other boards do the same with ms->ram_slots. We should consider doing it as well,
>> now, even if we're not up to the point of supporting pc-dimm hotplug, to avoid
>> having to change the memory layout later in the road and breaking existing
>> setups.
>>
>> If we want to copy the ARM board, ram_slots is capped to ACPI_MAX_RAM_SLOTS (256).
>> Each RAM slot is considered to be a 1GiB dimm, i.e. we would reserve 256GiB for
>> them.
> 
> This only reserves some *additional* space to fixup weird alignment of memory devices. *not* the actual space for these devices.
> 
> We don't consider each DIMM to be 1 GiB in size, but add an additional 1 GiB in case we have to align DIMMs in physical address space.
> 
> I *think* this dates back to old x86 handling where we aligned the address of each DIMM to be at a 1 GiB boundary. So if you would have plugged two 128 MiB DIMMs, you'd have required more than 256 MiB of space in the area after aligning inside the memory device area.
> 

Thanks for the explanation. I missed the part where the ram_slots were being
used just to solve potential alignment issues and pc-dimms could occupy the same
space being allocated via machine_memory_devices_init().

This patch isn't far off then. If we take care to avoid plugging unaligned memory
we might not even need this spare area.

>>
>> Note: I do not have the visibility of discussions on the memory management space,
>> and I might be missing details such as "we don't care about pc-dimm hotplug
>> anymore, it's legacy, we're going to support only virtio-md-pci from now on". We
>> had a situation like that with virtio-balloon and virtio-mem in the past, and I'm
>> not sure if this might fall in the same category.
> 
> Not sure if I got your comment right, but virtio-mem was never supposed to be a virtio-balloon replacement (especially of the free-page-reporting and memory stats part).

I was trying to refer to a situation we faced 3+ years ago in the powerpc machines,
where we were trying to add virtio-mem support there given that virtio-mem is/was
been seen (as far as I can remember anyways) as a more robust solution than
virtio-balloon + DIMM hotplug for guest memory management from the host point of
view.

I'm probably misrepresenting the whole situation though, it has been awhile :)


Thanks,


Daniel


> 
>>
>> I see that David Hildenbrand is also CCed in the patch so he'll let us know if
>> I'm out of line with what I'm asking.
> 
> Supporting PC-DIMMs might be required at some point when dealing with OSes that don't support virtio-mem and friends.
> 

