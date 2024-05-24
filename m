Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18115C25B7A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 15:30:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAWr7-0006zp-Rq; Fri, 24 May 2024 11:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sAWr6-0006zD-IG
 for qemu-devel@nongnu.org; Fri, 24 May 2024 11:29:16 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sAWr3-0006L8-WE
 for qemu-devel@nongnu.org; Fri, 24 May 2024 11:29:16 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1f44b42e9a6so6613355ad.0
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 08:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1716564552; x=1717169352; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hBPXrV38OXO9F8T1Vdf9bcSvzLhczAHuYwDFA5awb5U=;
 b=OBZ7Pe+LGP3+jzRP+sqfdpZ9KuUb6d2jyoWuqvh7J99zQ7I1VrxCsuUxwS+8pE7pZh
 8rUqMlwB4jgRWUUZ46KMwIkjEjy7HFVH45Wf1r6SYLmkURqZVtS78JXplH1SirA6bqHy
 MQgo2c84BC3wcII6Fyp0c7qEOl75UiVYaRpA4ZIH5I3g7WHHVS758xoIKo71hyGQSmUc
 J0kCLgRsJZx5erQx82v1WGWZF6tqnDRLRriqtjBiVNuKaaFDZKv7uZsmuhmeK7cLkJFw
 kggWkvM/bN4+X0ChXuvQGekZGvZAkTEU8HtnODzrGA0A2Be3zgOaAeqA9EPbBv0915Le
 3IVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716564552; x=1717169352;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hBPXrV38OXO9F8T1Vdf9bcSvzLhczAHuYwDFA5awb5U=;
 b=f2CMS6cBGseClpN+jtXPggrzXdA3EAAo+yAiknZ2SAx9ZMYI6SGyhz78757L8+vPf9
 pMrwL+EKzdqR1QzdHdI+Vyj9Bm+hp0cV2O+WCHyGIKZOx9PR7cfVi7LJRqPjI61etfbC
 Apmob1PRRGJx/H6OIBFEFqL0DeQOfAYdQ/z2S3m2ZyZV9Hq2XeH5oC2aFsbvLrffrMdr
 vQg8Ox4LzkoCsPb1IkamEsKJ+7pGeCYc0uoEleSYR7Q5oRHT9YjeAVaw0yEZpkAK9MZm
 06VieFzG1BUxJPXHTX3Rvk4mYw+TTiQhIkLvY1oi6XG2IAplWYBrKjpOQsYGjkDuLjib
 Jvmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9dExwOEjcoehw3wXupYNF7FwS/DImA/fSIM9pKeV4HoscqRctIUoP7odeHitOSiFiVmdsfhJmtwmg08fpdb8GPhjuly0=
X-Gm-Message-State: AOJu0YzxjOfWMgJtS1IcZR8Nn5IfUgiD/5Pro5XB19pOuGWg5CRst9Fr
 KXHsvj8VirJ/xAZNU/hIQJhjvc+kwuUtoDpeOQUPICFyqI1UhXzy1WcQgk/+zrQ=
X-Google-Smtp-Source: AGHT+IFMYzJbiQG3tN+TYLIYxGG8/rkHEeMGQTMU/5PaAaFzgC2my81AHuSwfJzMTyfO1YPMn98tlg==
X-Received: by 2002:a17:902:684c:b0:1f3:b2:e26 with SMTP id
 d9443c01a7336-1f44870eb1dmr28857375ad.28.1716564552203; 
 Fri, 24 May 2024 08:29:12 -0700 (PDT)
Received: from [192.168.68.110] ([177.94.42.4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c994626sm15150155ad.204.2024.05.24.08.29.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 May 2024 08:29:11 -0700 (PDT)
Message-ID: <18f217cf-6d68-4676-8674-d91f96e155fc@ventanamicro.com>
Date: Fri, 24 May 2024 12:29:06 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] hw/riscv/virt: Add memory hotplugging and
 virtio-md-pci support
To: David Hildenbrand <david@redhat.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Atish Patra <atishp@atishpatra.org>, Atish Patra <atishp@rivosinc.com>
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Santosh Mamila <santosh.mamila@catalinasystems.io>,
 Chethan Seshadri <Chethan.Seshadri@catalinasystems.io>,
 Sivakumar Munnangi <siva.munnangi@catalinasystems.io>
References: <20240521105635.795211-1-bjorn@kernel.org>
 <20240521105635.795211-2-bjorn@kernel.org>
 <55810d52-0360-40ad-a8d2-3b6a8aa220ae@ventanamicro.com>
 <51ef570c-da63-4e25-9c48-dbdf8a40a34d@redhat.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <51ef570c-da63-4e25-9c48-dbdf8a40a34d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x633.google.com
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



On 5/24/24 12:02, David Hildenbrand wrote:
> On 24.05.24 15:14, Daniel Henrique Barboza wrote:
>>
>>
>> On 5/21/24 07:56, Björn Töpel wrote:
>>> From: Björn Töpel <bjorn@rivosinc.com>
>>>
>>> Virtio-based memory devices (virtio-mem/virtio-pmem) allows for
>>> dynamic resizing of virtual machine memory, and requires proper
>>> hotplugging (add/remove) support to work.
>>>
>>> Add device memory support for RISC-V "virt" machine, and enable
>>> virtio-md-pci with the corresponding missing hotplugging callbacks.
>>>
>>> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
>>> ---
>>>    hw/riscv/Kconfig       |  2 +
>>>    hw/riscv/virt.c        | 83 +++++++++++++++++++++++++++++++++++++++++-
>>>    hw/virtio/virtio-mem.c |  5 ++-
>>>    3 files changed, 87 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
>>> index a2030e3a6ff0..08f82dbb681a 100644
>>> --- a/hw/riscv/Kconfig
>>> +++ b/hw/riscv/Kconfig
>>> @@ -56,6 +56,8 @@ config RISCV_VIRT
>>>        select PLATFORM_BUS
>>>        select ACPI
>>>        select ACPI_PCI
>>> +    select VIRTIO_MEM_SUPPORTED
>>> +    select VIRTIO_PMEM_SUPPORTED
>>>    config SHAKTI_C
>>>        bool
>>> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
>>> index 4fdb66052587..443902f919d2 100644
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
>>> @@ -1420,6 +1423,12 @@ static void virt_machine_init(MachineState *machine)
>>>            exit(1);
>>>        }
>>> +    if (machine->ram_slots > ACPI_MAX_RAM_SLOTS) {
>>> +        error_report("unsupported amount of memory slots: %"PRIu64,
>>> +                     machine->ram_slots);
>>> +        exit(EXIT_FAILURE);
>>> +    }
>>> +
>>>        /* Initialize sockets */
>>>        mmio_irqchip = virtio_irqchip = pcie_irqchip = NULL;
>>>        for (i = 0; i < socket_count; i++) {
>>> @@ -1553,6 +1562,37 @@ static void virt_machine_init(MachineState *machine)
>>>        memory_region_add_subregion(system_memory, memmap[VIRT_MROM].base,
>>>                                    mask_rom);
>>> +    /* device memory */
>>> +    device_memory_base = ROUND_UP(s->memmap[VIRT_DRAM].base + machine->ram_size,
>>> +                                  GiB);
>>> +    device_memory_size = machine->maxram_size - machine->ram_size;
>>> +    if (device_memory_size > 0) {
>>> +        /*
>>> +         * Each DIMM is aligned based on the backend's alignment value.
>>> +         * Assume max 1G hugepage alignment per slot.
>>> +         */
>>> +        device_memory_size += machine->ram_slots * GiB;
>>
>> We don't need to align to 1GiB. This calc can use 2MiB instead (or 4MiB if we're
>> running 32 bits).
>>
>>> +
>>> +        if (riscv_is_32bit(&s->soc[0])) {
>>> +            hwaddr memtop = device_memory_base + ROUND_UP(device_memory_size,
>>> +                                                          GiB);
>>
>> Same here - alignment is 2/4 MiB.
>>
>>> +
>>> +            if (memtop > UINT32_MAX) {
>>> +                error_report("memory exceeds 32-bit limit by %lu bytes",
>>> +                             memtop - UINT32_MAX);
>>> +                exit(EXIT_FAILURE);
>>> +            }
>>> +        }
>>> +
>>> +        if (device_memory_base + device_memory_size < device_memory_size) {
>>> +            error_report("unsupported amount of device memory");
>>> +            exit(EXIT_FAILURE);
>>> +        }
>>
>> Took another look and found this a bit strange. These are all unsigned vars, so
>> if (unsigned a + unsigned b < unsigned b) will always be 'false'. The compiler is
>> probably cropping this out.
> 
> No. Unsigned interger overflow is defined behavior and this is a common check to detect such overflow. tI's consistent with what we do for other architectures.
>

Oh, ok. We're so far away from UINT64_MAX that it didn't occur to me doing an overflow
check here. Fair enough.

  
>>
>> The calc we need to do is to ensure that the extra ram_slots * alignment will fit into
>> the VIRT_DRAM block, i.e. maxram_size + (ram_slots * alignment) < memmap[VIRT_DRAM].size.
>>
>>
>> TBH I'm starting to have second thoughts about letting users hotplug whatever they want.
>> It seems cleaner to just force the 2/4 Mb alignment in pre_plug() and be done with it,
>> no need to allocate ram_slots * alignment and doing all these extra checks.
> 
> It's worth noting that if user space decides to specify addresses manually, it can mess up everything already. There are other events that can result in fragmentation of the memory device area (repeated hot(un)plug of differing DIMMs).
> 
> Assume you have 1 GiB range and hotplug a 512 MiB DIMM at offset 256 MiB. You won't be able to hotplug another 512 MiB DIMM even though we reserved space.
> 
> My take so far is: if the user wants to do such stuff it should size the area (maxmem) much larger or deal with the concequences (not being able to hotplug memory).
> 
> It usually does not happen in practice ...
> 

I wonder if we should forbid users from removing memory that is 'out of place', i.e. users
should always remove pc-dimms in LIFO order. Usually this kind of control is done by
management, e.g. libvirt, but if we're not sure we'll keep consistency during memory
unplugs ...

>>
>> As I sent in an earlier email, users must already comply to the alignment of the host
>> memory when plugging pc-dimms, so I'm not sure our value/proposition with all this
>> extra code is worth it - the alignment will most likely be forced by the host memory
>> backend, so might as well force ourselves in pre_plug().
> 
> At least on x86-64, the 2 MiB alignment requirement is handled automatically. QEMU_VMALLOC_ALIGN implicitly enforces that.
> 
> Maybe RISCV also wants to set QEMU_VMALLOC_ALIGN?

Might be a good idea to experiment.



Thanks,


Daniel

> 

