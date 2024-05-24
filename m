Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F592C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 15:02:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAWRG-0003XP-Mz; Fri, 24 May 2024 11:02:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sAWRE-0003Wk-RM
 for qemu-devel@nongnu.org; Fri, 24 May 2024 11:02:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sAWRC-0001b8-Dz
 for qemu-devel@nongnu.org; Fri, 24 May 2024 11:02:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716562949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gPb1G/LuipKDJagieX/8SWiRsr6wtaG00z4ndQJw86M=;
 b=aa1uSM2ooGjddAbjl3qVdQ304CRV1YxxbaxhZsdcaSDDIXpc0QxlWS/s1+X0SxJrLDhuef
 9bP369TQ78KhUQu7kmHnzfUWr/gQIspayeEYUnKto3nOVVO7olOqpyjlPa+vfKt6M+lr/V
 Kkgec0YybGxhpSMvhI9T4HjRC2BsIA4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-ra7nve1NM7a8jMXKry66kw-1; Fri, 24 May 2024 11:02:27 -0400
X-MC-Unique: ra7nve1NM7a8jMXKry66kw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-355b9d2477bso209472f8f.3
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 08:02:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716562946; x=1717167746;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=gPb1G/LuipKDJagieX/8SWiRsr6wtaG00z4ndQJw86M=;
 b=g2yfwpxFZCPA1iC5t1w2ZFRo1YbKfdzrLj16cu7v6AQfqPij7aM4uq7VSDPB3Q0V56
 sDEZfrNFnVJARFmo6vrNNFSucpZeS7/0kikt/CLc+bYrP17Vam1kKpuwEo4waOVTMWr+
 M5rMa3n4BnbV6ZmxIGCIbYzHvzFUINbjKH0jmIRDrjD+DsazUd2A8tlfComAKiVCfLv8
 DP8Ew9yLjnQzONqELjRwCP+mhEEa8n9D6Vn8pfIOFTImq9gVxm/t1lIS9v84J5FvNu3j
 KlR/sqiguJSRdWXyOIPkYw9fCYrkDZLbXR13bQtvJtMQbZFlMsq5haOMAgHVLYxEhbf2
 vn3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqN1OISml4We5GXhRdX1JRGfyV9OY7dZyRD38/W/dEiMzGF/ogQVTGo+h5EX7M6AxPxgWMe2T6Tb5PHchjkgYDlMr4VOs=
X-Gm-Message-State: AOJu0YxR2d9QtxFqZYCHfUkDetHRc6a+ge3kHBUVMuUG8Y0OqAZmLBna
 8owfo2G0nv39DsCgbOF21kZXV4TkcQ406Lr99CKwXaUouuTAepAzYKgJZ1PfRFYdi8t5+DKifvb
 MhyRw79jZYj7ZGEz0UnCcuCW1vCwVPY4blCAKAiUElm/JUshBz8+x
X-Received: by 2002:a5d:58f1:0:b0:34c:65ba:5d43 with SMTP id
 ffacd0b85a97d-3552fde04c5mr2007815f8f.46.1716562946375; 
 Fri, 24 May 2024 08:02:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQr8RFgVeA+BaNoFjnttCagwM+5slhaHdZ6nYvg4Sx21ZKLYAm/kpLMkp/M0N02nrCw99hsg==
X-Received: by 2002:a5d:58f1:0:b0:34c:65ba:5d43 with SMTP id
 ffacd0b85a97d-3552fde04c5mr2007733f8f.46.1716562945407; 
 Fri, 24 May 2024 08:02:25 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7?
 ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35579d7d963sm1824715f8f.21.2024.05.24.08.02.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 May 2024 08:02:24 -0700 (PDT)
Message-ID: <51ef570c-da63-4e25-9c48-dbdf8a40a34d@redhat.com>
Date: Fri, 24 May 2024 17:02:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] hw/riscv/virt: Add memory hotplugging and
 virtio-md-pci support
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
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
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <55810d52-0360-40ad-a8d2-3b6a8aa220ae@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
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

On 24.05.24 15:14, Daniel Henrique Barboza wrote:
> 
> 
> On 5/21/24 07:56, Björn Töpel wrote:
>> From: Björn Töpel <bjorn@rivosinc.com>
>>
>> Virtio-based memory devices (virtio-mem/virtio-pmem) allows for
>> dynamic resizing of virtual machine memory, and requires proper
>> hotplugging (add/remove) support to work.
>>
>> Add device memory support for RISC-V "virt" machine, and enable
>> virtio-md-pci with the corresponding missing hotplugging callbacks.
>>
>> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
>> ---
>>    hw/riscv/Kconfig       |  2 +
>>    hw/riscv/virt.c        | 83 +++++++++++++++++++++++++++++++++++++++++-
>>    hw/virtio/virtio-mem.c |  5 ++-
>>    3 files changed, 87 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
>> index a2030e3a6ff0..08f82dbb681a 100644
>> --- a/hw/riscv/Kconfig
>> +++ b/hw/riscv/Kconfig
>> @@ -56,6 +56,8 @@ config RISCV_VIRT
>>        select PLATFORM_BUS
>>        select ACPI
>>        select ACPI_PCI
>> +    select VIRTIO_MEM_SUPPORTED
>> +    select VIRTIO_PMEM_SUPPORTED
>>    
>>    config SHAKTI_C
>>        bool
>> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
>> index 4fdb66052587..443902f919d2 100644
>> --- a/hw/riscv/virt.c
>> +++ b/hw/riscv/virt.c
>> @@ -53,6 +53,8 @@
>>    #include "hw/pci-host/gpex.h"
>>    #include "hw/display/ramfb.h"
>>    #include "hw/acpi/aml-build.h"
>> +#include "hw/mem/memory-device.h"
>> +#include "hw/virtio/virtio-mem-pci.h"
>>    #include "qapi/qapi-visit-common.h"
>>    #include "hw/virtio/virtio-iommu.h"
>>    
>> @@ -1407,6 +1409,7 @@ static void virt_machine_init(MachineState *machine)
>>        DeviceState *mmio_irqchip, *virtio_irqchip, *pcie_irqchip;
>>        int i, base_hartid, hart_count;
>>        int socket_count = riscv_socket_count(machine);
>> +    hwaddr device_memory_base, device_memory_size;
>>    
>>        /* Check socket count limit */
>>        if (VIRT_SOCKETS_MAX < socket_count) {
>> @@ -1420,6 +1423,12 @@ static void virt_machine_init(MachineState *machine)
>>            exit(1);
>>        }
>>    
>> +    if (machine->ram_slots > ACPI_MAX_RAM_SLOTS) {
>> +        error_report("unsupported amount of memory slots: %"PRIu64,
>> +                     machine->ram_slots);
>> +        exit(EXIT_FAILURE);
>> +    }
>> +
>>        /* Initialize sockets */
>>        mmio_irqchip = virtio_irqchip = pcie_irqchip = NULL;
>>        for (i = 0; i < socket_count; i++) {
>> @@ -1553,6 +1562,37 @@ static void virt_machine_init(MachineState *machine)
>>        memory_region_add_subregion(system_memory, memmap[VIRT_MROM].base,
>>                                    mask_rom);
>>    
>> +    /* device memory */
>> +    device_memory_base = ROUND_UP(s->memmap[VIRT_DRAM].base + machine->ram_size,
>> +                                  GiB);
>> +    device_memory_size = machine->maxram_size - machine->ram_size;
>> +    if (device_memory_size > 0) {
>> +        /*
>> +         * Each DIMM is aligned based on the backend's alignment value.
>> +         * Assume max 1G hugepage alignment per slot.
>> +         */
>> +        device_memory_size += machine->ram_slots * GiB;
> 
> We don't need to align to 1GiB. This calc can use 2MiB instead (or 4MiB if we're
> running 32 bits).
> 
>> +
>> +        if (riscv_is_32bit(&s->soc[0])) {
>> +            hwaddr memtop = device_memory_base + ROUND_UP(device_memory_size,
>> +                                                          GiB);
> 
> Same here - alignment is 2/4 MiB.
> 
>> +
>> +            if (memtop > UINT32_MAX) {
>> +                error_report("memory exceeds 32-bit limit by %lu bytes",
>> +                             memtop - UINT32_MAX);
>> +                exit(EXIT_FAILURE);
>> +            }
>> +        }
>> +
>> +        if (device_memory_base + device_memory_size < device_memory_size) {
>> +            error_report("unsupported amount of device memory");
>> +            exit(EXIT_FAILURE);
>> +        }
> 
> Took another look and found this a bit strange. These are all unsigned vars, so
> if (unsigned a + unsigned b < unsigned b) will always be 'false'. The compiler is
> probably cropping this out.

No. Unsigned interger overflow is defined behavior and this is a common 
check to detect such overflow. tI's consistent with what we do for other 
architectures.

> 
> The calc we need to do is to ensure that the extra ram_slots * alignment will fit into
> the VIRT_DRAM block, i.e. maxram_size + (ram_slots * alignment) < memmap[VIRT_DRAM].size.
> 
> 
> TBH I'm starting to have second thoughts about letting users hotplug whatever they want.
> It seems cleaner to just force the 2/4 Mb alignment in pre_plug() and be done with it,
> no need to allocate ram_slots * alignment and doing all these extra checks.

It's worth noting that if user space decides to specify addresses 
manually, it can mess up everything already. There are other events that 
can result in fragmentation of the memory device area (repeated 
hot(un)plug of differing DIMMs).

Assume you have 1 GiB range and hotplug a 512 MiB DIMM at offset 256 
MiB. You won't be able to hotplug another 512 MiB DIMM even though we 
reserved space.

My take so far is: if the user wants to do such stuff it should size the 
area (maxmem) much larger or deal with the concequences (not being able 
to hotplug memory).

It usually does not happen in practice ...

> 
> As I sent in an earlier email, users must already comply to the alignment of the host
> memory when plugging pc-dimms, so I'm not sure our value/proposition with all this
> extra code is worth it - the alignment will most likely be forced by the host memory
> backend, so might as well force ourselves in pre_plug().

At least on x86-64, the 2 MiB alignment requirement is handled 
automatically. QEMU_VMALLOC_ALIGN implicitly enforces that.

Maybe RISCV also wants to set QEMU_VMALLOC_ALIGN?

-- 
Cheers,

David / dhildenb


