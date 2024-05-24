Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9D84C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 09:11:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAQwl-0001U1-Mj; Fri, 24 May 2024 05:10:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sAQwj-0001SP-0E
 for qemu-devel@nongnu.org; Fri, 24 May 2024 05:10:41 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sAQwg-0004Ir-MO
 for qemu-devel@nongnu.org; Fri, 24 May 2024 05:10:40 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-68187b5d3fcso454113a12.0
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 02:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1716541836; x=1717146636; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PUayGeUQIvfFZN4HQaKSEXR8r/IDAezjvjRrFIAqENI=;
 b=Ck7zf3astU+GjJSgFMgAzdWL7GXl8IZV5+G9izdw+AL6x5QsAa0eUQIogZbo9qjruX
 mhkR8ax8Gapq5wpgieEj8AkVLwQHd0HyEMTJsv8ro1VKtHcxnp2u0mp94nNrMhvcjQlq
 AraDRBK1ZrNuI4JX4jehx12bQXkmeJCzdcX6Y4fIpz1tvYE9DRgUfP9Fz8xPOiZKT/I0
 X9VtsfxEQOXJvbMjctkgNZH/oxtTvvoHJkJLS5enGGhcPbShPKvHFPQq2V+0g1u7aM0+
 yYlZVDUyqHAA+E7desr7E9Mu1GG5G5UUmfgZDqmQJ3Mbnwgxmj7Vh/5opYFI5480F/p5
 jOrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716541836; x=1717146636;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PUayGeUQIvfFZN4HQaKSEXR8r/IDAezjvjRrFIAqENI=;
 b=v7zgvctuo2ICIMHWwFxHc18PrjY6YMRB4Y/LReNnXdVd6h8B5JqO4y7nxwCOewRbkU
 mL54tKv8fuYqWeSkqiE3GLlw+YCUxAEfyVznh2ZuMe7FoXRl7HefuNRy173UYK1aj2NR
 vyczsIHUpBQ5EdGpKY3JY+gXcsauygZ2h7wfzVoJ0nXPvL19NHxqTOObC5fF6S8w/nR3
 Lo1A3a8eFzkka5245ldFkSwGrpsmhrjYn0SaJoAR+Jymu0o5w7PVrtmp3PIDuJGkdDgE
 i4RP5q7c71IiVc6CA48WqiTzzGoyP6fUUrXwgL88RN3pvCppNL30DjU825GeciUpCGCY
 ppFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRs4V4YelMNJSM2bGKFoz9/oLgRhMd2yQFpp77vguTpgmi1VqNYJPAqoGHHbBAedxRiRWxYYlG2AjSbEK7KKFbXVn1hCU=
X-Gm-Message-State: AOJu0YxjYx+uJrEwVMnYkWqN/hxPwMq4qMSGZazymiSL7He99QijTmXS
 9FzVbLYyR4a9W3c8OC/DAMbRSbrEFceqy4rN7xQ+hnEwsJyOJCfpUKRi6AMkgkj55/4sZzNKCOX
 9
X-Google-Smtp-Source: AGHT+IFtl0v/+eHT1/HcbndRDjJ9LGwZVmpciGJxtcpwmcr6MShxJW+D++lfYFyAupILYZEixyldNQ==
X-Received: by 2002:a05:6a20:d42f:b0:1af:dc83:75bc with SMTP id
 adf61e73a8af0-1b212d39189mr1689216637.3.1716541835836; 
 Fri, 24 May 2024 02:10:35 -0700 (PDT)
Received: from [192.168.68.110] ([177.94.42.4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c7592c1sm9210285ad.57.2024.05.24.02.10.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 May 2024 02:10:35 -0700 (PDT)
Message-ID: <40ae0cb9-1596-4cec-994c-71e0abaa0d1e@ventanamicro.com>
Date: Fri, 24 May 2024 06:10:30 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] hw/riscv/virt: Add ACPI GED and PC-DIMM MHP support
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 David Hildenbrand <david@redhat.com>, Atish Patra <atishp@atishpatra.org>,
 Atish Patra <atishp@rivosinc.com>
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Santosh Mamila <santosh.mamila@catalinasystems.io>,
 Chethan Seshadri <Chethan.Seshadri@catalinasystems.io>,
 Sivakumar Munnangi <siva.munnangi@catalinasystems.io>
References: <20240521105635.795211-1-bjorn@kernel.org>
 <20240521105635.795211-4-bjorn@kernel.org>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240521105635.795211-4-bjorn@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x529.google.com
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



On 5/21/24 07:56, Björn Töpel wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> Add ACPI GED for the RISC-V "virt" machine, and wire up PC-DIMM memory
> hotplugging support. Heavily based/copied from hw/arm/virt.c.
> 
> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
> ---
>   hw/riscv/Kconfig           |   3 ++
>   hw/riscv/virt-acpi-build.c |  16 ++++++
>   hw/riscv/virt.c            | 104 ++++++++++++++++++++++++++++++++++++-
>   include/hw/riscv/virt.h    |   6 ++-
>   4 files changed, 126 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index 08f82dbb681a..bebe412f2107 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -56,6 +56,9 @@ config RISCV_VIRT
>       select PLATFORM_BUS
>       select ACPI
>       select ACPI_PCI
> +    select MEM_DEVICE
> +    select DIMM
> +    select ACPI_HW_REDUCED
>       select VIRTIO_MEM_SUPPORTED
>       select VIRTIO_PMEM_SUPPORTED
>   
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index 6dc3baa9ec86..61813abdef3f 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -27,6 +27,8 @@
>   #include "hw/acpi/acpi-defs.h"
>   #include "hw/acpi/acpi.h"
>   #include "hw/acpi/aml-build.h"
> +#include "hw/acpi/memory_hotplug.h"
> +#include "hw/acpi/generic_event_device.h"
>   #include "hw/acpi/pci.h"
>   #include "hw/acpi/utils.h"
>   #include "hw/intc/riscv_aclint.h"
> @@ -432,6 +434,20 @@ static void build_dsdt(GArray *table_data,
>           acpi_dsdt_add_gpex_host(scope, PCIE_IRQ + VIRT_IRQCHIP_NUM_SOURCES * 2);
>       }
>   
> +    if (s->acpi_dev) {
> +        uint32_t event = object_property_get_uint(OBJECT(s->acpi_dev),
> +                                                  "ged-event", &error_abort);
> +
> +        build_ged_aml(scope, "\\_SB."GED_DEVICE, HOTPLUG_HANDLER(s->acpi_dev),
> +                      GED_IRQ, AML_SYSTEM_MEMORY, memmap[VIRT_ACPI_GED].base);
> +
> +        if (event & ACPI_GED_MEM_HOTPLUG_EVT) {
> +            build_memory_hotplug_aml(scope, ms->ram_slots, "\\_SB", NULL,
> +                                     AML_SYSTEM_MEMORY,
> +                                     memmap[VIRT_PCDIMM_ACPI].base);
> +        }
> +    }
> +
>       aml_append(dsdt, scope);
>   
>       /* copy AML table into ACPI tables blob and patch header there */
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 443902f919d2..2e35890187f2 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -53,10 +53,13 @@
>   #include "hw/pci-host/gpex.h"
>   #include "hw/display/ramfb.h"
>   #include "hw/acpi/aml-build.h"
> +#include "hw/acpi/generic_event_device.h"
> +#include "hw/acpi/memory_hotplug.h"
>   #include "hw/mem/memory-device.h"
>   #include "hw/virtio/virtio-mem-pci.h"
>   #include "qapi/qapi-visit-common.h"
>   #include "hw/virtio/virtio-iommu.h"
> +#include "hw/mem/pc-dimm.h"
>   
>   /* KVM AIA only supports APLIC MSI. APLIC Wired is always emulated by QEMU. */
>   static bool virt_use_kvm_aia(RISCVVirtState *s)
> @@ -84,6 +87,8 @@ static const MemMapEntry virt_memmap[] = {
>       [VIRT_UART0] =        { 0x10000000,         0x100 },
>       [VIRT_VIRTIO] =       { 0x10001000,        0x1000 },
>       [VIRT_FW_CFG] =       { 0x10100000,          0x18 },
> +    [VIRT_PCDIMM_ACPI] =  { 0x10200000, MEMORY_HOTPLUG_IO_LEN },
> +    [VIRT_ACPI_GED] =     { 0x10210000, ACPI_GED_EVT_SEL_LEN },
>       [VIRT_FLASH] =        { 0x20000000,     0x4000000 },
>       [VIRT_IMSIC_M] =      { 0x24000000, VIRT_IMSIC_MAX_SIZE },
>       [VIRT_IMSIC_S] =      { 0x28000000, VIRT_IMSIC_MAX_SIZE },
> @@ -1400,6 +1405,28 @@ static void virt_machine_done(Notifier *notifier, void *data)
>       }
>   }
>   
> +static DeviceState *create_acpi_ged(RISCVVirtState *s)
> +{
> +    DeviceState *dev;
> +    MachineState *ms = MACHINE(s);
> +    uint32_t event = 0;
> +
> +    if (ms->ram_slots) {
> +        event |= ACPI_GED_MEM_HOTPLUG_EVT;
> +    }
> +
> +    dev = qdev_new(TYPE_ACPI_GED);
> +    qdev_prop_set_uint32(dev, "ged-event", event);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, s->memmap[VIRT_ACPI_GED].base);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, s->memmap[VIRT_PCDIMM_ACPI].base);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, qdev_get_gpio_in(s->irqchip[0],
> +                                                                GED_IRQ));
> +
> +    return dev;
> +}
> +
>   static void virt_machine_init(MachineState *machine)
>   {
>       const MemMapEntry *memmap = virt_memmap;
> @@ -1612,6 +1639,10 @@ static void virt_machine_init(MachineState *machine)
>   
>       gpex_pcie_init(system_memory, pcie_irqchip, s);
>   
> +    if (virt_is_acpi_enabled(s)) {
> +        s->acpi_dev = create_acpi_ged(s);
> +    }
> +
>       create_platform_bus(s, mmio_irqchip);
>   
>       serial_mm_init(system_memory, memmap[VIRT_UART0].base,
> @@ -1752,6 +1783,7 @@ static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
>       MachineClass *mc = MACHINE_GET_CLASS(machine);
>   
>       if (device_is_dynamic_sysbus(mc, dev) ||
> +        object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) ||
>           object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI) ||
>           object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
>           return HOTPLUG_HANDLER(machine);
> @@ -1759,14 +1791,42 @@ static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
>       return NULL;
>   }
>   
> +static void virt_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
> +                                 Error **errp)
> +{
> +    RISCVVirtState *s = RISCV_VIRT_MACHINE(hotplug_dev);
> +
> +    if (!s->acpi_dev) {
> +        error_setg(errp,
> +                   "memory hotplug is not enabled: missing acpi-ged device");
> +        return;
> +    }
> +
> +    pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev), NULL, errp);
> +}
> +

Note that we're not doing any aligment checks in this pre_plug(), meaning that
we're kind of accepting whatever the pc-dimm device throw at us.

Testing in an AMD x86 machine will force the pc-dimm to be 2Mb aligned:

$ ./build/qemu-system-riscv64 -M virt -m 2G,slots=4,maxmem=8G -nographic
(...)
(qemu) object_add memory-backend-ram,id=ram0,size=111M
(qemu) device_add pc-dimm,id=dimm0,memdev=ram0
Error: backend memory size must be multiple of 0x200000
(qemu) object_del ram0

This happens because the DIMM must be aligned with its own backend, in this case
the host memory itself (backends/hostmem.c).

There's no guarantee that we'll always run in a host that is mem aligned with the board,
so it would be nice to add align checks in virt_memory_pre_plug().

>   static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>                                               DeviceState *dev, Error **errp)
>   {
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> +        virt_memory_pre_plug(hotplug_dev, dev, errp);
> +    }
> +
>       if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
>           virtio_md_pci_pre_plug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev), errp);
>       }
>   }
>   
> +static void virt_memory_plug(HotplugHandler *hotplug_dev,
> +                             DeviceState *dev, Error **errp)
> +{
> +    RISCVVirtState *s = RISCV_VIRT_MACHINE(hotplug_dev);
> +
> +    pc_dimm_plug(PC_DIMM(dev), MACHINE(s));
> +
> +    hotplug_handler_plug(HOTPLUG_HANDLER(s->acpi_dev), dev, &error_abort);
> +}
> +
>   static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
>                                           DeviceState *dev, Error **errp)
>   {
> @@ -1785,16 +1845,36 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
>           create_fdt_virtio_iommu(s, pci_get_bdf(PCI_DEVICE(dev)));
>       }
>   
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> +        virt_memory_plug(hotplug_dev, dev, errp);
> +    }
> +
>       if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
>           virtio_md_pci_plug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev), errp);
>       }
>   }
>   
> +static void virt_dimm_unplug_request(HotplugHandler *hotplug_dev,
> +                                     DeviceState *dev, Error **errp)
> +{
> +    RISCVVirtState *s = RISCV_VIRT_MACHINE(hotplug_dev);
> +
> +    if (!s->acpi_dev) {
> +        error_setg(errp,
> +                   "memory hotplug is not enabled: missing acpi-ged device");
> +        return;
> +    }
> +
> +    hotplug_handler_unplug_request(HOTPLUG_HANDLER(s->acpi_dev), dev, errp);
> +}
> +

I'm unsure if we're ready to support both hotplug and hot-unplug, but I tested anyway.
Hotplug seems to work but hot-unplug doesn't:

$ ./build/qemu-system-riscv64 -M virt -m 2G,slots=4,maxmem=8G -nographic
(...)
(qemu) object_add memory-backend-ram,id=ram0,size=112M
(qemu) device_add pc-dimm,id=dimm0,memdev=ram0
(qemu)
(qemu) info memory-devices
Memory device [dimm]: "dimm0"
   addr: 0x100000000
   slot: 0
   node: 0
   size: 117440512
   memdev: /objects/ram0
   hotplugged: true
   hotpluggable: true
(qemu)
(qemu) device_del dimm0
(qemu) object_del ram0
Error: object 'ram0' is in use, can not be deleted
(qemu) info memory-devices
Memory device [dimm]: "dimm0"
   addr: 0x100000000
   slot: 0
   node: 0
   size: 117440512
   memdev: /objects/ram0
   hotplugged: true
   hotpluggable: true
(qemu)

In short: hotplugged a 112Mb DIMM, then tried to remove it. 'device_del' doesn't error
out but doesn't let me remove the memory backing created, i.e. the dimm0 device is
still around.

In a quick digging I see that we're hitting virt_dimm_unplug_request() all the way
down to acpi_memory_unplug_request_cb(), where an ACPI_MEMORY_HOTPLUG_STATUS is being
sent. We never reach virt_dimm_unplug() afterwards, so the PC_DIMM is never removed.

I'm not acquainted with ACPI enough to say if we're missing stuff in QEMU, or if we
need SW to be aware of this ACPI HP event to trigger the release of the dimm, or
anything in between.

I consider this more as a FYI. If we're up to the point of hotplugging pc-dimms it's
already an improvement worth having. Hot-unplugging can come later.


Thanks,

Daniel

>   static void virt_machine_device_unplug_request_cb(HotplugHandler *hotplug_dev,
>                                                     DeviceState *dev,
>                                                     Error **errp)
>   {
> -    if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> +        virt_dimm_unplug_request(hotplug_dev, dev, errp);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
>           virtio_md_pci_unplug_request(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev),
>                                        errp);
>       } else {
> @@ -1804,10 +1884,30 @@ static void virt_machine_device_unplug_request_cb(HotplugHandler *hotplug_dev,
>       }
>   }
>   
> +static void virt_dimm_unplug(HotplugHandler *hotplug_dev,
> +                             DeviceState *dev, Error **errp)
> +{
> +    RISCVVirtState *s = RISCV_VIRT_MACHINE(hotplug_dev);
> +    Error *local_err = NULL;
> +
> +    hotplug_handler_unplug(HOTPLUG_HANDLER(s->acpi_dev), dev, &local_err);
> +    if (local_err) {
> +        goto out;
> +    }
> +
> +    pc_dimm_unplug(PC_DIMM(dev), MACHINE(s));
> +    qdev_unrealize(dev);
> +
> +out:
> +    error_propagate(errp, local_err);
> +}
> +
>   static void virt_machine_device_unplug_cb(HotplugHandler *hotplug_dev,
>                                             DeviceState *dev, Error **errp)
>   {
> -    if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> +        virt_dimm_unplug(hotplug_dev, dev, errp);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
>           virtio_md_pci_unplug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev), errp);
>       } else {
>           error_setg(errp, "virt: device unplug for unsupported device"
> diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
> index 3db839160f95..adf460a4021e 100644
> --- a/include/hw/riscv/virt.h
> +++ b/include/hw/riscv/virt.h
> @@ -62,6 +62,7 @@ struct RISCVVirtState {
>       OnOffAuto acpi;
>       const MemMapEntry *memmap;
>       struct GPEXHost *gpex_host;
> +    DeviceState *acpi_dev;
>   };
>   
>   enum {
> @@ -84,12 +85,15 @@ enum {
>       VIRT_PCIE_MMIO,
>       VIRT_PCIE_PIO,
>       VIRT_PLATFORM_BUS,
> -    VIRT_PCIE_ECAM
> +    VIRT_PCIE_ECAM,
> +    VIRT_PCDIMM_ACPI,
> +    VIRT_ACPI_GED,
>   };
>   
>   enum {
>       UART0_IRQ = 10,
>       RTC_IRQ = 11,
> +    GED_IRQ = 12,
>       VIRTIO_IRQ = 1, /* 1 to 8 */
>       VIRTIO_COUNT = 8,
>       PCIE_IRQ = 0x20, /* 32 to 35 */

