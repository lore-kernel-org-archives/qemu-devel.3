Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4523FC25B74
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2024 17:24:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8Nmo-00069b-IP; Sat, 18 May 2024 13:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1s8Nmh-00068N-UF
 for qemu-devel@nongnu.org; Sat, 18 May 2024 13:23:52 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1s8Nmf-0000jA-LF
 for qemu-devel@nongnu.org; Sat, 18 May 2024 13:23:51 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6f4603237e0so825383b3a.0
 for <qemu-devel@nongnu.org>; Sat, 18 May 2024 10:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1716053028; x=1716657828; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iszXkN601Kkbc6mv1er9EvPc1GseDIvNqOx56GUVoj4=;
 b=gIPwOX/Wr5uFF8vpNlEexKoC4Nt2xpHVGdpmzgP7XaHWEZboDG/MCcklZJ91FRGhdM
 1zkz2+XIn8wt9MvmPQSvNfLqupEJsU4940lDIll2srYkcANoJgt1+zC7uOg94+lDqDs1
 96UNj1yz0dyyNDv8IyGyQbEGnQjfMFWYcuaPLksGz/iXwkycK2BYe+emWV8K0clGiow4
 Q9TS6oF7ntSEQSVAT98Be9iM0Ns00g7MpvG72n2SuUH29/zs5g80aQ3ldd6C2zgLurjZ
 nuUinI590GW5m75hv/ciAT6Lf2mtoW+HPFjj+1X6gmGH63TD2ZfSsRjwnh1YmInSxklz
 HMJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716053028; x=1716657828;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iszXkN601Kkbc6mv1er9EvPc1GseDIvNqOx56GUVoj4=;
 b=eSoUTsd/EIwSqPDYk2dglx3NeVSmVdejUfAgtyLfblG2OOiU+W8KfyqGSkXFjdG59b
 qtTgneEJYi4Eas0IGNtC0qSUpxB0wgMvzNQRwwqn6VeFH7tl6/79fcfCNVuaVY/U3/gm
 gVcLe46AjV4SQ9K6eLbcN5byHeQvFfH7DCBOsBbkU+pBakAPNVV1X7FRmtDvWnxzdX1G
 1zv3TtBQneArBdRDHjUa5v0Fsvd5IguLbZ1hMn3uZtN+6APMBwzXf9CdrtqhSQ99b6TI
 T4xj3EO3Nlv1Uqyte9nkrcWY+JaV78lFL3/O+dVfu5C82ELPGy9m2UtMuj19O3+oV9XZ
 Ze/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX98Bxelg+wWg/c8eRxX8ur6fIhKrEqzLXfIGkkid6sHDU5bRpGCO+avcuGN+Sw4/M7qorqiEZjjiARYJGdCNwBQOdcXwI=
X-Gm-Message-State: AOJu0YwtouCWcHtWjiQfDv+tdWVnvI1P4Js0SLGbM+2PW1hCMCTlRILI
 WQQhVnJIOvE5AMAdYod2r4Z5O0i554oLPMJXODXRvkBCoH9RZTj8eW4jDEFr1jQ=
X-Google-Smtp-Source: AGHT+IFsbwSLikFznCbTSQ5rGGQ+WU0X8ROrwFK3ChaHvJ2bf1jDeTWMj6fmWuLckroMEPJvFaWB2w==
X-Received: by 2002:a05:6a00:3c89:b0:6f4:d5d8:e0a3 with SMTP id
 d2e1a72fcca58-6f69fbe0465mr3452789b3a.9.1716053027800; 
 Sat, 18 May 2024 10:23:47 -0700 (PDT)
Received: from [192.168.68.110] ([177.94.42.57])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f67b526b44sm5906474b3a.149.2024.05.18.10.23.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 May 2024 10:23:47 -0700 (PDT)
Message-ID: <3cb00bbb-7742-40b7-858c-4bdd2f9cc79b@ventanamicro.com>
Date: Sat, 18 May 2024 14:23:40 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/riscv/virt: Add hotplugging and virtio-md-pci support
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 David Hildenbrand <david@redhat.com>
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Santosh Mamila <santosh.mamila@catalinasystems.io>,
 Chethan Seshadri <Chethan.Seshadri@catalinasystems.io>,
 Sivakumar Munnangi <siva.munnangi@catalinasystems.io>
References: <20240514110615.399065-1-bjorn@kernel.org>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240514110615.399065-1-bjorn@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x429.google.com
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

Hi Björj,

On 5/14/24 08:06, Björn Töpel wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> Virtio-based memory devices allows for dynamic resizing of virtual
> machine memory, and requires proper hotplugging (add/remove) support
> to work.
> 
> Enable virtio-md-pci with the corresponding missing hotplugging
> callbacks for the RISC-V "virt" machine.
> 
> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
> ---
> This is basic support for MHP that works with DT. There some minor
> ACPI SRAT plumbing in there as well. Ideally we'd like proper ACPI MHP
> support as well. I have a branch [1], where I've applied this patch,
> plus ACPI GED/PC-DIMM MHP support on top of Sunil's QEMU branch
> (contains some ACPI DSDT additions) [2], for the curious/brave ones.
> However, the ACPI MHP support this is not testable on upstream Linux
> yet (ACPI AIA support, and ACPI NUMA SRAT series are ongoing).
> 
> I'll follow-up with proper ACPI GED/PC-DIMM MHP patches, once the
> dependencies land (Linux kernel and QEMU).
> 
> I'll post the Linux MHP/virtio-mem v2 patches later this week!
> 
> 
> Cheers,
> Björn
> 
> [1] https://github.com/bjoto/qemu/commits/virtio-mem-pc-dimm-mhp-acpi/
> [2] https://lore.kernel.org/linux-riscv/20240501121742.1215792-1-sunilvl@ventanamicro.com/
> ---
>   hw/riscv/Kconfig           |  2 ++
>   hw/riscv/virt-acpi-build.c |  7 +++++
>   hw/riscv/virt.c            | 64 +++++++++++++++++++++++++++++++++++++-
>   hw/virtio/virtio-mem.c     |  2 +-
>   4 files changed, 73 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index a2030e3a6ff0..08f82dbb681a 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -56,6 +56,8 @@ config RISCV_VIRT
>       select PLATFORM_BUS
>       select ACPI
>       select ACPI_PCI
> +    select VIRTIO_MEM_SUPPORTED
> +    select VIRTIO_PMEM_SUPPORTED
>   
>   config SHAKTI_C
>       bool
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index 0925528160f8..6dc3baa9ec86 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -610,6 +610,13 @@ build_srat(GArray *table_data, BIOSLinker *linker, RISCVVirtState *vms)
>           }
>       }
>   
> +    if (ms->device_memory) {
> +        build_srat_memory(table_data, ms->device_memory->base,
> +                          memory_region_size(&ms->device_memory->mr),
> +                          ms->numa_state->num_nodes - 1,
> +                          MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENABLED);
> +    }
> +
>       acpi_table_end(linker, &table);

When the time comes I believe we'll want this chunk in a separated ACPI patch.

>   }
>   
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 4fdb66052587..16c2bdbfe6b6 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -53,6 +53,8 @@
>   #include "hw/pci-host/gpex.h"
>   #include "hw/display/ramfb.h"
>   #include "hw/acpi/aml-build.h"
> +#include "hw/mem/memory-device.h"
> +#include "hw/virtio/virtio-mem-pci.h"
>   #include "qapi/qapi-visit-common.h"
>   #include "hw/virtio/virtio-iommu.h"
>   
> @@ -1407,6 +1409,7 @@ static void virt_machine_init(MachineState *machine)
>       DeviceState *mmio_irqchip, *virtio_irqchip, *pcie_irqchip;
>       int i, base_hartid, hart_count;
>       int socket_count = riscv_socket_count(machine);
> +    hwaddr device_memory_base, device_memory_size;
>   
>       /* Check socket count limit */
>       if (VIRT_SOCKETS_MAX < socket_count) {
> @@ -1553,6 +1556,25 @@ static void virt_machine_init(MachineState *machine)
>       memory_region_add_subregion(system_memory, memmap[VIRT_MROM].base,
>                                   mask_rom);
>   
> +    device_memory_base = ROUND_UP(s->memmap[VIRT_DRAM].base + machine->ram_size,
> +                                  GiB);
> +    device_memory_size = machine->maxram_size - machine->ram_size;
> +
> +    if (riscv_is_32bit(&s->soc[0])) {
> +        hwaddr memtop = device_memory_base + ROUND_UP(device_memory_size, GiB);
> +
> +        if (memtop > UINT32_MAX) {
> +            error_report("Memory exceeds 32-bit limit by %lu bytes",
> +                         memtop - UINT32_MAX);
> +            exit(EXIT_FAILURE);
> +        }
> +    }
> +
> +    if (device_memory_size > 0) {
> +        machine_memory_devices_init(machine, device_memory_base,
> +                                    device_memory_size);
> +    }
> +

I think we need a design discussion before proceeding here. You're allocating all
available memory as a memory device area, but in theory we might also support
pc-dimm hotplugs (which would be the equivalent of adding physical RAM dimms to
the board.) in the future too. If you're not familiar with this feature you can
check it out the docs in [1].

As an example, the 'virt' ARM board (hw/arm/virt.c) reserves a space for this
type of hotplug by checking how much 'ram_slots' we're allocating for it:

device_memory_size = ms->maxram_size - ms->ram_size + ms->ram_slots * GiB;

Other boards do the same with ms->ram_slots. We should consider doing it as well,
now, even if we're not up to the point of supporting pc-dimm hotplug, to avoid
having to change the memory layout later in the road and breaking existing
setups.

If we want to copy the ARM board, ram_slots is capped to ACPI_MAX_RAM_SLOTS (256).
Each RAM slot is considered to be a 1GiB dimm, i.e. we would reserve 256GiB for
them.

Note: I do not have the visibility of discussions on the memory management space,
and I might be missing details such as "we don't care about pc-dimm hotplug
anymore, it's legacy, we're going to support only virtio-md-pci from now on". We
had a situation like that with virtio-balloon and virtio-mem in the past, and I'm
not sure if this might fall in the same category.

I see that David Hildenbrand is also CCed in the patch so he'll let us know if
I'm out of line with what I'm asking.


[1] https://github.com/qemu/qemu/blob/master/docs/memory-hotplug.txt


Thanks,

Daniel




>       /*
>        * Init fw_cfg. Must be done before riscv_load_fdt, otherwise the
>        * device tree cannot be altered and we get FDT_ERR_NOSPACE.
> @@ -1712,12 +1734,21 @@ static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
>       MachineClass *mc = MACHINE_GET_CLASS(machine);
>   
>       if (device_is_dynamic_sysbus(mc, dev) ||
> -        object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
> +        object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI) ||
> +        object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
>           return HOTPLUG_HANDLER(machine);
>       }
>       return NULL;
>   }
>   
> +static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
> +                                            DeviceState *dev, Error **errp)
> +{
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
> +        virtio_md_pci_pre_plug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev), errp);
> +    }
> +}
> +
>   static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
>                                           DeviceState *dev, Error **errp)
>   {
> @@ -1735,6 +1766,34 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
>       if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
>           create_fdt_virtio_iommu(s, pci_get_bdf(PCI_DEVICE(dev)));
>       }
> +
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
> +        virtio_md_pci_plug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev), errp);
> +    }
> +}
> +
> +static void virt_machine_device_unplug_request_cb(HotplugHandler *hotplug_dev,
> +                                                  DeviceState *dev,
> +                                                  Error **errp)
> +{
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
> +        virtio_md_pci_unplug_request(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev),
> +                                     errp);
> +    } else {
> +        error_setg(errp, "device unplug request for unsupported device type: %s",
> +                   object_get_typename(OBJECT(dev)));
> +    }
> +}
> +
> +static void virt_machine_device_unplug_cb(HotplugHandler *hotplug_dev,
> +                                          DeviceState *dev, Error **errp)
> +{
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
> +        virtio_md_pci_unplug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev), errp);
> +    } else {
> +        error_setg(errp, "virt: device unplug for unsupported device"
> +                   " type: %s", object_get_typename(OBJECT(dev)));
> +    }
>   }
>   
>   static void virt_machine_class_init(ObjectClass *oc, void *data)
> @@ -1757,7 +1816,10 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
>       assert(!mc->get_hotplug_handler);
>       mc->get_hotplug_handler = virt_machine_get_hotplug_handler;
>   
> +    hc->pre_plug = virt_machine_device_pre_plug_cb;
>       hc->plug = virt_machine_device_plug_cb;
> +    hc->unplug_request = virt_machine_device_unplug_request_cb;
> +    hc->unplug = virt_machine_device_unplug_cb;
>   
>       machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
>   #ifdef CONFIG_TPM
> diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
> index ffd119ebacb7..26c976a3b9b8 100644
> --- a/hw/virtio/virtio-mem.c
> +++ b/hw/virtio/virtio-mem.c
> @@ -161,7 +161,7 @@ static bool virtio_mem_has_shared_zeropage(RAMBlock *rb)
>    * necessary (as the section size can change). But it's more likely that the
>    * section size will rather get smaller and not bigger over time.
>    */
> -#if defined(TARGET_X86_64) || defined(TARGET_I386)
> +#if defined(TARGET_X86_64) || defined(TARGET_I386)  || defined(TARGET_RISCV)
>   #define VIRTIO_MEM_USABLE_EXTENT (2 * (128 * MiB))
>   #elif defined(TARGET_ARM)
>   #define VIRTIO_MEM_USABLE_EXTENT (2 * (512 * MiB))
> 
> base-commit: 9360070196789cc8b9404b2efaf319384e64b107

