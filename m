Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17703C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 13:19:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBaGB-0001MM-4t; Mon, 27 May 2024 09:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sBaG8-0001Lp-Md
 for qemu-devel@nongnu.org; Mon, 27 May 2024 09:19:28 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sBaG6-0004mv-FL
 for qemu-devel@nongnu.org; Mon, 27 May 2024 09:19:28 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-6818e31e5baso2744596a12.1
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 06:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1716815965; x=1717420765; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8vfUxTZGJ+eSUTYdSnZrh0t/6pEj9cIoMqnbXJF5u3Y=;
 b=hLCiK9kQL1E3Yyat8QavhO4Pgzfo2J7qpUwkFxtZbN8ldgQso4kAsQqwWBJwAg3gTn
 kPog4oFTZmmnbiMEvIp1ZCL2JRKTVu0X+RMMUZVm4vlci3x8kt1YbhUyzo2ZzeydvVP6
 A61C5hFae4BmCD8qLaZpFBMcY8so3ALkB2okqRINdPXXCYLceGN35XtLl4KEl9Lt4/pv
 JSLYsBTs+hzEiBysOu3xPlIzrNejMnagvExthHKOlzM7LGUuB6fEucXx+uq2TSIT6R7+
 8IIGME4pwkkvyMdf2L7QkgJDjxlmMQVLpTfG6ANxTk/7tSXOXO5gHrPt5zcYmeZxajDe
 dAJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716815965; x=1717420765;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8vfUxTZGJ+eSUTYdSnZrh0t/6pEj9cIoMqnbXJF5u3Y=;
 b=TUKc8zAZqwHXxeBwdoeGfKrODNIcDrh8EOgBi739obIrHxefVRBi1K2Ti0OdwG1AnT
 dDhR250tv4kSSkSlXCz8lbVXOwOObkgo6VczoSkQb3rAR8QqQGF76HzkC44jACbgncmg
 98ZJ+Xq0wlI2BsErvurt1DL5mU/Hfi0zmoLLdyLLpW9d0D7gnkWJgOSQZpDtjdI/+Kaf
 azuFEZYd01YhFZRCeH8OEk0IIPk3T1yN63VnUk+KcZKdHHIyMic5PuD80y4gBM9fv1Kr
 L5dzCp6rA/CgdJ+r49gPMQ78D6Mg6vAsADLurjReJTS848EMvmVNP+XIVQC97W0EDjvU
 sb+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdQ4Q/AcoWGfDLQXg4KrQH1bh8CmcuJ1QhjhsQQcNFieIFSKlM7Ri0pii1UipL4TpabVCLiHgonu8SS6NObDAy+Ieg/aM=
X-Gm-Message-State: AOJu0Yx9XYIr7W0p2YeX1smHxPIvS5NF2SdNijiQ8HYC6xjFV9hwuQzm
 vDSM8mcc5qfafaJGwrJmkD8VtxEsQbsVBIh06OBKKex0ddSs5hcLPk0lGDE+pRk=
X-Google-Smtp-Source: AGHT+IHBSUk4YNFT/m9hTvb2N2kKNQepDrMSt+iYW43E1ccXseEkfydTxPOYY2rzxs38RUs0IL9ECA==
X-Received: by 2002:a17:903:41ce:b0:1f3:2d51:17a with SMTP id
 d9443c01a7336-1f4486fe1ddmr108097335ad.18.1716815964791; 
 Mon, 27 May 2024 06:19:24 -0700 (PDT)
Received: from [192.168.68.110] ([177.94.42.4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c7c114fsm60508925ad.97.2024.05.27.06.19.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 May 2024 06:19:24 -0700 (PDT)
Message-ID: <69bb0364-e2a8-4de1-afa7-e9cb5b569f77@ventanamicro.com>
Date: Mon, 27 May 2024 10:19:18 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] hw/riscv/virt: Add memory hotplugging and
 virtio-md-pci support
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 David Hildenbrand <david@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
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
 <87sey38nsf.fsf@all.your.base.are.belong.to.us>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <87sey38nsf.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 5/27/24 09:03, Björn Töpel wrote:
> David Hildenbrand <david@redhat.com> writes:
> 
>> On 24.05.24 15:14, Daniel Henrique Barboza wrote:
>>>
>>>
>>> On 5/21/24 07:56, Björn Töpel wrote:
>>>> From: Björn Töpel <bjorn@rivosinc.com>
>>>>
>>>> Virtio-based memory devices (virtio-mem/virtio-pmem) allows for
>>>> dynamic resizing of virtual machine memory, and requires proper
>>>> hotplugging (add/remove) support to work.
>>>>
>>>> Add device memory support for RISC-V "virt" machine, and enable
>>>> virtio-md-pci with the corresponding missing hotplugging callbacks.
>>>>
>>>> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
>>>> ---
>>>>     hw/riscv/Kconfig       |  2 +
>>>>     hw/riscv/virt.c        | 83 +++++++++++++++++++++++++++++++++++++++++-
>>>>     hw/virtio/virtio-mem.c |  5 ++-
>>>>     3 files changed, 87 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
>>>> index a2030e3a6ff0..08f82dbb681a 100644
>>>> --- a/hw/riscv/Kconfig
>>>> +++ b/hw/riscv/Kconfig
>>>> @@ -56,6 +56,8 @@ config RISCV_VIRT
>>>>         select PLATFORM_BUS
>>>>         select ACPI
>>>>         select ACPI_PCI
>>>> +    select VIRTIO_MEM_SUPPORTED
>>>> +    select VIRTIO_PMEM_SUPPORTED
>>>>     
>>>>     config SHAKTI_C
>>>>         bool
>>>> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
>>>> index 4fdb66052587..443902f919d2 100644
>>>> --- a/hw/riscv/virt.c
>>>> +++ b/hw/riscv/virt.c
>>>> @@ -53,6 +53,8 @@
>>>>     #include "hw/pci-host/gpex.h"
>>>>     #include "hw/display/ramfb.h"
>>>>     #include "hw/acpi/aml-build.h"
>>>> +#include "hw/mem/memory-device.h"
>>>> +#include "hw/virtio/virtio-mem-pci.h"
>>>>     #include "qapi/qapi-visit-common.h"
>>>>     #include "hw/virtio/virtio-iommu.h"
>>>>     
>>>> @@ -1407,6 +1409,7 @@ static void virt_machine_init(MachineState *machine)
>>>>         DeviceState *mmio_irqchip, *virtio_irqchip, *pcie_irqchip;
>>>>         int i, base_hartid, hart_count;
>>>>         int socket_count = riscv_socket_count(machine);
>>>> +    hwaddr device_memory_base, device_memory_size;
>>>>     
>>>>         /* Check socket count limit */
>>>>         if (VIRT_SOCKETS_MAX < socket_count) {
>>>> @@ -1420,6 +1423,12 @@ static void virt_machine_init(MachineState *machine)
>>>>             exit(1);
>>>>         }
>>>>     
>>>> +    if (machine->ram_slots > ACPI_MAX_RAM_SLOTS) {
>>>> +        error_report("unsupported amount of memory slots: %"PRIu64,
>>>> +                     machine->ram_slots);
>>>> +        exit(EXIT_FAILURE);
>>>> +    }
>>>> +
>>>>         /* Initialize sockets */
>>>>         mmio_irqchip = virtio_irqchip = pcie_irqchip = NULL;
>>>>         for (i = 0; i < socket_count; i++) {
>>>> @@ -1553,6 +1562,37 @@ static void virt_machine_init(MachineState *machine)
>>>>         memory_region_add_subregion(system_memory, memmap[VIRT_MROM].base,
>>>>                                     mask_rom);
>>>>     
>>>> +    /* device memory */
>>>> +    device_memory_base = ROUND_UP(s->memmap[VIRT_DRAM].base + machine->ram_size,
>>>> +                                  GiB);
>>>> +    device_memory_size = machine->maxram_size - machine->ram_size;
>>>> +    if (device_memory_size > 0) {
>>>> +        /*
>>>> +         * Each DIMM is aligned based on the backend's alignment value.
>>>> +         * Assume max 1G hugepage alignment per slot.
>>>> +         */
>>>> +        device_memory_size += machine->ram_slots * GiB;
>>>
>>> We don't need to align to 1GiB. This calc can use 2MiB instead (or 4MiB if we're
>>> running 32 bits).
>>>
>>>> +
>>>> +        if (riscv_is_32bit(&s->soc[0])) {
>>>> +            hwaddr memtop = device_memory_base + ROUND_UP(device_memory_size,
>>>> +                                                          GiB);
>>>
>>> Same here - alignment is 2/4 MiB.
>>>
>>>> +
>>>> +            if (memtop > UINT32_MAX) {
>>>> +                error_report("memory exceeds 32-bit limit by %lu bytes",
>>>> +                             memtop - UINT32_MAX);
>>>> +                exit(EXIT_FAILURE);
>>>> +            }
>>>> +        }
>>>> +
>>>> +        if (device_memory_base + device_memory_size < device_memory_size) {
>>>> +            error_report("unsupported amount of device memory");
>>>> +            exit(EXIT_FAILURE);
>>>> +        }
>>>
>>> Took another look and found this a bit strange. These are all unsigned vars, so
>>> if (unsigned a + unsigned b < unsigned b) will always be 'false'. The compiler is
>>> probably cropping this out.
>>
>> No. Unsigned interger overflow is defined behavior and this is a common
>> check to detect such overflow. tI's consistent with what we do for other
>> architectures.
>>
>>>
>>> The calc we need to do is to ensure that the extra ram_slots * alignment will fit into
>>> the VIRT_DRAM block, i.e. maxram_size + (ram_slots * alignment) < memmap[VIRT_DRAM].size.
>>>
>>>
>>> TBH I'm starting to have second thoughts about letting users hotplug whatever they want.
>>> It seems cleaner to just force the 2/4 Mb alignment in pre_plug() and be done with it,
>>> no need to allocate ram_slots * alignment and doing all these extra checks.
>>
>> It's worth noting that if user space decides to specify addresses
>> manually, it can mess up everything already. There are other events that
>> can result in fragmentation of the memory device area (repeated
>> hot(un)plug of differing DIMMs).
>>
>> Assume you have 1 GiB range and hotplug a 512 MiB DIMM at offset 256
>> MiB. You won't be able to hotplug another 512 MiB DIMM even though we
>> reserved space.
>>
>> My take so far is: if the user wants to do such stuff it should size the
>> area (maxmem) much larger or deal with the concequences (not being able
>> to hotplug memory).
>>
>> It usually does not happen in practice ...
> 
> Daniel/David, again thanks for spending time on the patches.
> 
> The reason I picked 1 GiB per slot was because the alignment is also
> dependent on the backend AFAIU. Rationale in commit 085f8e88ba73 ("pc:
> count in 1Gb hugepage alignment when sizing hotplug-memory container").
> 
> What I'm reading from you guys are: Just depend on whatever maxmem says
> (modulo 2/4M alignment), and leave at that. I agree that that's much
> easier to reason about.
> 
> Correct?

We could opt for the more conservative approach and keep the 1Gb per dimm to
account for hugepage mem fragmentation that the commit is talking about, assuming
that this scenario is still feasible to happen.

riscv64 can take this extra restriction (i.e. an extra 256GiB RAM just for that)
but I'm afraid this would eradicate hotplug support for riscv32 since it'll never
has enough memory to deal with a spare 1Gb per slot.

I'm aware that you're working in the RISC-V kernel support for memory hotplug, so
you can answer this better than I can: do we care about hugepage support for
riscv32? Assuming we don't, then we could keep 4MiB alignment for riscv32 but do
1GiB for riscv64 to account for this potential hugepage fragmentation.


Thanks,

Daniel

> 
>>> As I sent in an earlier email, users must already comply to the alignment of the host
>>> memory when plugging pc-dimms, so I'm not sure our value/proposition with all this
>>> extra code is worth it - the alignment will most likely be forced by the host memory
>>> backend, so might as well force ourselves in pre_plug().
>>
>> At least on x86-64, the 2 MiB alignment requirement is handled
>> automatically. QEMU_VMALLOC_ALIGN implicitly enforces that.
>>
>> Maybe RISCV also wants to set QEMU_VMALLOC_ALIGN?
> 
> I'll look into this for the next rev!
> 
> 
> Björn

