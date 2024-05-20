Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73617C25B77
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 20:05:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s99Fy-0005d0-7M; Mon, 20 May 2024 16:05:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1s99Fx-0005cX-CP
 for qemu-devel@nongnu.org; Mon, 20 May 2024 16:05:13 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1s99Ft-0003nA-Hg
 for qemu-devel@nongnu.org; Mon, 20 May 2024 16:05:13 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1ecd3867556so89487725ad.0
 for <qemu-devel@nongnu.org>; Mon, 20 May 2024 13:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1716235505; x=1716840305; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4mvCA9w6FdFTW0YLCl1SxGRRGxyiZKa7vF0l/I6UfVw=;
 b=KhAXEtDWG7alrsBRq848n9qYrR4E07cLi2gN5UUPPfcbQsmagrqhZR0VL6vxFJOfVP
 ij5cQQB9Na/08wGwUxU5qaCa9KatKbQFakvbRCiL2krSFI+qYxJ4Teyy9N9XM+2zeROX
 SqxtuMR0Qa+Wv0ox7dmnzFu+i6qQ4SwqLq1P0kGmcwsIzBpBW7g8pUTgO+v57LiOMjA8
 tAOjiHOFQPJ3ZCPqQRKYRjJrLdQUWQIzvQVZHEWIJXCZBtpKIStZqUWSsghj47GOx/0T
 VBINK1ChxZjC6AJe7AnAIk4oVhsa0WjTPz/ko2eG9TMGKR64d+2BkS8BcPriLFJkwr0T
 VbOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716235505; x=1716840305;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4mvCA9w6FdFTW0YLCl1SxGRRGxyiZKa7vF0l/I6UfVw=;
 b=uKpwO+KhAmMLtPEWhlrGjIWCpH6aZG6yCO9gxzX2WCbtKYntArB+AD2ois8slFjM2I
 zLfL3mD9cDqRA0wFJ7PXH0lp7DSpDNeWFJ5tOBlXTYo8WZrZCFC0PoUx85htytRfs54D
 la7Ljl/vH5uZ/dQb3NGCBOd31N1TMDisgl45WJnCLEWEo/p1dMM98h07YPko5jDN1u8m
 2SAFN1RG70QvXoR4CJkkdpfxaEVxfIQZa1muP+cu7cxo0SJ8uIM69i2CZQ3OJntGHRnn
 gjYYqXBHvQJpDY2IAM45GVm0c9fiGmP44QNQu2NoyPVt8BzVdmgdrngoNEqJ2R9eF/L5
 VX5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGVzFMtufmOPQp+Tf1BbA2+xc8fP9iYQZPRkDdIuqbiY4VpQjGp1XP9T83Rvx2BP0hwIeJkIHAgCvqyu+i1Jt2fLSOMRI=
X-Gm-Message-State: AOJu0YwQu1JLDxHKXJYV137/tABasuLZzOx4Tc6hgdnLay063VJHFuuC
 tZIp9TXN65DS6YwlTwcW2xnDuJTz4USIcAixDu37+AXynsGZ5QV4d8889Vm7OL8=
X-Google-Smtp-Source: AGHT+IEFLRCu2IJdZL1uHp3RA9ZpBhTIE/6+jTWm5NAhke9OSOlFVllfnJvBjnP7w1vDmBAS7Bcoww==
X-Received: by 2002:a17:902:f54e:b0:1f3:a22:7c4e with SMTP id
 d9443c01a7336-1f30a228073mr17712195ad.17.1716235505493; 
 Mon, 20 May 2024 13:05:05 -0700 (PDT)
Received: from ?IPV6:2804:7f0:bcc0:4196:f8dc:1a46:f594:fa63?
 ([2804:7f0:bcc0:4196:f8dc:1a46:f594:fa63])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f3044a81c9sm19062075ad.43.2024.05.20.13.05.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 May 2024 13:05:05 -0700 (PDT)
Message-ID: <c9332de0-f36e-4e62-a46c-9d3fd8448795@ventanamicro.com>
Date: Mon, 20 May 2024 17:04:59 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/riscv/virt: Add hotplugging and virtio-md-pci support
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 David Hildenbrand <david@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
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
 <87v838uxk5.fsf@all.your.base.are.belong.to.us>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <87v838uxk5.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 5/20/24 15:51, Björn Töpel wrote:
> Daniel/David,
> 
> Daniel Henrique Barboza <dbarboza@ventanamicro.com> writes:
> 
>> On 5/18/24 16:50, David Hildenbrand wrote:
>>>
>>> Hi,
>>>
>>>
>>>>> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
>>>>> index 4fdb66052587..16c2bdbfe6b6 100644
>>>>> --- a/hw/riscv/virt.c
>>>>> +++ b/hw/riscv/virt.c
>>>>> @@ -53,6 +53,8 @@
>>>>>     #include "hw/pci-host/gpex.h"
>>>>>     #include "hw/display/ramfb.h"
>>>>>     #include "hw/acpi/aml-build.h"
>>>>> +#include "hw/mem/memory-device.h"
>>>>> +#include "hw/virtio/virtio-mem-pci.h"
>>>>>     #include "qapi/qapi-visit-common.h"
>>>>>     #include "hw/virtio/virtio-iommu.h"
>>>>> @@ -1407,6 +1409,7 @@ static void virt_machine_init(MachineState *machine)
>>>>>         DeviceState *mmio_irqchip, *virtio_irqchip, *pcie_irqchip;
>>>>>         int i, base_hartid, hart_count;
>>>>>         int socket_count = riscv_socket_count(machine);
>>>>> +    hwaddr device_memory_base, device_memory_size;
>>>>>         /* Check socket count limit */
>>>>>         if (VIRT_SOCKETS_MAX < socket_count) {
>>>>> @@ -1553,6 +1556,25 @@ static void virt_machine_init(MachineState *machine)
>>>>>         memory_region_add_subregion(system_memory, memmap[VIRT_MROM].base,
>>>>>                                     mask_rom);
>>>>> +    device_memory_base = ROUND_UP(s->memmap[VIRT_DRAM].base + machine->ram_size,
>>>>> +                                  GiB);
>>>>> +    device_memory_size = machine->maxram_size - machine->ram_size;
>>>>> +
>>>>> +    if (riscv_is_32bit(&s->soc[0])) {
>>>>> +        hwaddr memtop = device_memory_base + ROUND_UP(device_memory_size, GiB);
>>>>> +
>>>>> +        if (memtop > UINT32_MAX) {
>>>>> +            error_report("Memory exceeds 32-bit limit by %lu bytes",
>>>>> +                         memtop - UINT32_MAX);
>>>>> +            exit(EXIT_FAILURE);
>>>>> +        }
>>>>> +    }
>>>>> +
>>>>> +    if (device_memory_size > 0) {
>>>>> +        machine_memory_devices_init(machine, device_memory_base,
>>>>> +                                    device_memory_size);
>>>>> +    }
>>>>> +
>>>>
>>>> I think we need a design discussion before proceeding here. You're allocating all
>>>> available memory as a memory device area, but in theory we might also support
>>>> pc-dimm hotplugs (which would be the equivalent of adding physical RAM dimms to
>>>> the board.) in the future too. If you're not familiar with this feature you can
>>>> check it out the docs in [1].
>>>
>>> Note that DIMMs are memory devices as well. You can plug into the memory device area both, ACPI-based memory devices (DIMM, NVDIMM) or virtio-based memory devices (virtio-mem, virtio-pmem).
>>>
>>>>
>>>> As an example, the 'virt' ARM board (hw/arm/virt.c) reserves a space for this
>>>> type of hotplug by checking how much 'ram_slots' we're allocating for it:
>>>>
>>>> device_memory_size = ms->maxram_size - ms->ram_size + ms->ram_slots * GiB;
>>>>
>>>
>>> Note that we increased the region size to be able to fit most requests even if alignment of memory devices is weird. See below.
>>>
>>> In sane setups, this is usually not required (adding a single additional GB for some flexiility might be good enough).
>>>
>>>> Other boards do the same with ms->ram_slots. We should consider doing it as well,
>>>> now, even if we're not up to the point of supporting pc-dimm hotplug, to avoid
>>>> having to change the memory layout later in the road and breaking existing
>>>> setups.
>>>>
>>>> If we want to copy the ARM board, ram_slots is capped to ACPI_MAX_RAM_SLOTS (256).
>>>> Each RAM slot is considered to be a 1GiB dimm, i.e. we would reserve 256GiB for
>>>> them.
>>>
>>> This only reserves some *additional* space to fixup weird alignment of memory devices. *not* the actual space for these devices.
>>>
>>> We don't consider each DIMM to be 1 GiB in size, but add an additional 1 GiB in case we have to align DIMMs in physical address space.
>>>
>>> I *think* this dates back to old x86 handling where we aligned the address of each DIMM to be at a 1 GiB boundary. So if you would have plugged two 128 MiB DIMMs, you'd have required more than 256 MiB of space in the area after aligning inside the memory device area.
>>>
>>
>> Thanks for the explanation. I missed the part where the ram_slots were being
>> used just to solve potential alignment issues and pc-dimms could occupy the same
>> space being allocated via machine_memory_devices_init().
>>
>> This patch isn't far off then. If we take care to avoid plugging unaligned memory
>> we might not even need this spare area.
> 
> I'm a bit lost here, so please bare with me. We don't require the 1 GiB
> alignment on RV AFAIU. I'm having a hard time figuring out what missing
> in my patch.

Forget about the 1 GiB size. This is something that we won't need to deal with
because we don't align in 1 Gib.

Let's say for example that we want to support pc-dimm hotplug of 256 slots like the
'virt' ARM machine does. Let's also say that we will allow users to hotplug any
DIMM size they want, taking care of any alignment issues by ourselves.

In hw/riscv/boot.c I see that our alignment sizes are 4Mb for 32 bits and 2Mb for
64 bits. Forget 32 bits a bit and let's say that our alignment is 2Mb.

So, in a worst case scenario, an user could hotplug 256 slots, all of them unaligned,
and then we would need to align each one of them by adding 2Mb. So, to account for
this alignment fixup, we would need 256 * 2Mb RAM reserved for it.

What I said about "If we take care to avoid plugging unaligned memory we might not even
need this spare area" is a possible design where we would force every hotplugged DIMM
to always be memory aligned, avoiding the need for this spare RAM for alignment. This
would put a bit of extra straing in users/management apps to always deliver aligned
DIMMs.

In hindsight this is not needed. It's fairly easy to reserve ACPI_MAX_RAM_SLOTS * (2Mb/4Mb)
and let users hotplug whatever DIMM size they want.

Hope this explains the situation a bit. If we agree on allocating this spare RAM for
hotplugged mem alignment, we'll probalby need a pre-patch to do a little handling of
ms->ram_slots, limiting it to ACPI_MAX_RAM_SLOTS (ram_slots can be changed via command
line). Then it's a matter of reserving ms->ram_slots * align_size when calculating
device_memory_size.


Thanks,

Daniel

> 
> [...]
> 
>>>> I see that David Hildenbrand is also CCed in the patch so he'll let us know if
>>>> I'm out of line with what I'm asking.
>>>
>>> Supporting PC-DIMMs might be required at some point when dealing with OSes that don't support virtio-mem and friends.
> 
> ...and also for testing the PC-DIMM ACPI patching path. ;-)
> 
> 
> Cheers,
> Björn

