Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC0BC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 09:54:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHKfc-0001gQ-EN; Wed, 12 Jun 2024 05:53:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sHKfa-0001fH-8s
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 05:53:30 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sHKfX-0007HB-9S
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 05:53:30 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-704261a1f67so2194724b3a.3
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 02:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1718186005; x=1718790805; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eRw+ewEaVXnQNkTi8cUQjq6NJJAzmOhN4Tw/l4XgNlo=;
 b=SHIB1TSjY9KsT1+ESFY802u12+80398RNqvZEM663wjo4OiqJLL9IgixtEkKQutgsD
 dqlOrPf0w7Lug/DPQvM1XOZabLy17AldA7XcicGdHhS1ZeCMvzNFgVtVSOIAOJBaD53v
 GDZsuDSqkJZfVacde4GksJuLXPzOaZVgSIiLTaCMv2ytzUcL5QJVEOtnrWM7PLgc9T8M
 8sUdFkl5g06dG93k7oOPjyAhWDCX7VzaLPKZDy6X6h1+l1kVD+yR23ek+vWBKNANFFTl
 oCsOrwc1lDP2fDpopEncvCEcqM+dTs/fuFAUmWAdA9jJ3wA51VFOdPMCBnQ/fVT7LMBh
 IfPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718186005; x=1718790805;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eRw+ewEaVXnQNkTi8cUQjq6NJJAzmOhN4Tw/l4XgNlo=;
 b=P3Ef58ovLPufsjOSmovYnm+b/HLP5KlVCz/VTQM6SRdqxFNBY5wZAj3HoaSvk8hUbT
 rVmI4nRNWmw/8vaYx4jKEpIR8mCLd/YIFWj7iJJ7fhrPb979FAbprCOXg0l6y0vkuwt0
 xz6dfXdlJ3WedsWpFD/Z2I84uhKu0CQFR4Oq/2I/jj/xk5os5y1Xx9vb1YCXWhOQcD6i
 miGuUE4JyB42NKUtVJpDqNBV644AqLDBAdyr458T+VkDArMNv07ZD8cM66d/mZTRkvMg
 g7jUpOwoC6O2UDll6CHaSNj2/F62JEYUCbZ9n93IEK2TGmO/ofL50NRyx/DMOLsUSc/m
 0WOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXj6jLt8/EenUNpx/Mhh7kIrRx9nT0vdMroWQuENZARWivDQWh7rFdc2vSZedvI6dovVp6vMcVsWMLVUXnj1x3WndW9f4=
X-Gm-Message-State: AOJu0Yx2rZnJFSOz5tosB6u56sRyH/HIu0luNlebzK6ljUwnskSNDjrV
 GRbQprxOJg6oBeiwikMw0OR/tA8V8kIiHjmHdbS/jh8gEeDhZ8ugg/w1PP/NlWc=
X-Google-Smtp-Source: AGHT+IG4WAxNUiiT1zqwxu1uI42ZuCL2nZqu/G56jO+Qm6rd5vb8yzogVuykXGiesljw7ZnyA/jXPQ==
X-Received: by 2002:a05:6a00:c8e:b0:705:b9da:8148 with SMTP id
 d2e1a72fcca58-705bce9924amr1506048b3a.26.1718186005117; 
 Wed, 12 Jun 2024 02:53:25 -0700 (PDT)
Received: from [192.168.68.109] ([179.193.8.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7043b089b87sm5593051b3a.214.2024.06.12.02.53.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jun 2024 02:53:24 -0700 (PDT)
Message-ID: <04a1cedd-f5ff-42d4-a75f-7ef59e11abc0@ventanamicro.com>
Date: Wed, 12 Jun 2024 06:53:19 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/13] hw/riscv: add RISC-V IOMMU base emulation
To: Jason Chien <jason.chien@sifive.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 tjeznach@rivosinc.com, ajones@ventanamicro.com, frank.chang@sifive.com,
 Sebastien Boeuf <seb@rivosinc.com>, Peter Maydell
 <peter.maydell@linaro.org>, Andrey Smirnov <andrew.smirnov@gmail.com>,
 Cedric Le Goater <clg@kaod.org>
References: <20240523173955.1940072-1-dbarboza@ventanamicro.com>
 <20240523173955.1940072-4-dbarboza@ventanamicro.com>
 <6334e628-f823-4d9c-be24-9d721af2e5fe@sifive.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <6334e628-f823-4d9c-be24-9d721af2e5fe@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42e.google.com
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

Hi Jason,

(CCing designware folks and Cedric)

On 6/11/24 1:15 PM, Jason Chien wrote:
> Hi Daniel,
> 
> On 2024/5/24 上午 01:39, Daniel Henrique Barboza wrote:
>> From: Tomasz Jeznach <tjeznach@rivosinc.com>
>>
>> The RISC-V IOMMU specification is now ratified as-per the RISC-V
>> international process. The latest frozen specifcation can be found
>> at:
>>
>> https://github.com/riscv-non-isa/riscv-iommu/releases/download/v1.0/riscv-iommu.pdf
>>
>> Add the foundation of the device emulation for RISC-V IOMMU, which
>> includes an IOMMU that has no capabilities but MSI interrupt support and
>> fault queue interfaces. We'll add add more features incrementally in the
>> next patches.
>>
>> Co-developed-by: Sebastien Boeuf <seb@rivosinc.com>
>> Signed-off-by: Sebastien Boeuf <seb@rivosinc.com>
>> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> ---

[...]

>> +static const PCIIOMMUOps riscv_iommu_ops = {
>> +    .get_address_space = riscv_iommu_find_as,
>> +};
>> +
>> +void riscv_iommu_pci_setup_iommu(RISCVIOMMUState *iommu, PCIBus *bus,
>> +        Error **errp)
>> +{
>> +    if (bus->iommu_ops &&
>> +        bus->iommu_ops->get_address_space == riscv_iommu_find_as) {
>> +        /* Allow multiple IOMMUs on the same PCIe bus, link known devices */
>> +        RISCVIOMMUState *last = (RISCVIOMMUState *)bus->iommu_opaque;
>> +        QLIST_INSERT_AFTER(last, iommu, iommus);
>> +    } else if (!bus->iommu_ops && !bus->iommu_opaque) {
>> +        pci_setup_iommu(bus, &riscv_iommu_ops, iommu);
> 
> We use Designware PCIe with RISCV IOMMU internally and there is a problem that we would like to point out.
> 
> Both hw/riscv/riscv-iommu.c and hw/pci-host/designware.c utilize pci_setup_iommu(). When pci_setup_iommu() is invoked in hw/riscv/riscv-iommu.c, the iommu_ops set by Designware PCIe host is lost, which results in incorrect translation as the PCIe translation logic is overwritten and lost.
> 
> I think it may be a better choice to expose a memory region property in each PCIe host for the purpose of specifying the target memory region that the PCIe host should send requests to. By doing this, the Designware PCIe host can finish its translation and directs the request to the IOMMU memory region of the RISCV IOMMU.
> 
> The below code, based on riscv_iommu_v3, exposes a target memory region property in Designware PCIe and directs inbound requests to the target memory which can be specified to be the IOMMU memory region of RISCV IOMMU.
> 
> diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
> index c25d50f1c6..6b6d4ac1aa 100644
> --- a/hw/pci-host/designware.c
> +++ b/hw/pci-host/designware.c
> @@ -435,7 +435,7 @@ static void designware_pcie_root_realize(PCIDevice *dev, Error **errp)
>           viewport->cr[0]   = DESIGNWARE_PCIE_ATU_TYPE_MEM;
> 
>           source      = &host->pci.address_space_root;
> -        destination = get_system_memory();
> +        destination = host->target_mr;
>           direction   = "Inbound";
> 
>           /*
> @@ -713,6 +713,10 @@ static void designware_pcie_host_realize(DeviceState *dev, Error **errp)
>                          "pcie-bus-address-space");
>       pci_setup_iommu(pci->bus, &designware_iommu_ops, s);
> 
> +    if (!s->target_mr) {
> +        s->target_mr = get_system_memory();
> +    }
> +
>       qdev_realize(DEVICE(&s->root), BUS(pci->bus), &error_fatal);
>   }
> 
> @@ -730,6 +734,12 @@ static const VMStateDescription vmstate_designware_pcie_host = {
>       }
>   };
> 
> +static Property designware_pcie_host_properties[] = {
> +    DEFINE_PROP_LINK("target-mr", DesignwarePCIEHost, target_mr,
> +                     TYPE_MEMORY_REGION, MemoryRegion *),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
>   static void designware_pcie_host_class_init(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -740,6 +750,7 @@ static void designware_pcie_host_class_init(ObjectClass *klass, void *data)
>       set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>       dc->fw_name = "pci";
>       dc->vmsd = &vmstate_designware_pcie_host;
> +    device_class_set_props(dc, designware_pcie_host_properties);
>   }
> 
>   static void designware_pcie_host_init(Object *obj)
> diff --git a/include/hw/pci-host/designware.h b/include/hw/pci-host/designware.h
> index 908f3d946b..2530eacbb0 100644
> --- a/include/hw/pci-host/designware.h
> +++ b/include/hw/pci-host/designware.h
> @@ -91,6 +91,7 @@ struct DesignwarePCIEHost {
>       } pci;
> 
>       MemoryRegion mmio;
> +    MemoryRegion *target_mr;
>   };
> 
>   #endif /* DESIGNWARE_H */
> 
> We also need to specify the requester id (BDF) in the memory attribute when sending requests to the IOMMU memory region in order to distinguish the source endpoint, since all endpoints under Designware PCIe host write to the same IOMMU memory region.
> 
> diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
> index d3dd0f64b2..1fc64a2d1f 100644
> --- a/include/hw/pci/pci_device.h
> +++ b/include/hw/pci/pci_device.h
> @@ -249,8 +249,11 @@ static inline MemTxResult pci_dma_rw(PCIDevice *dev, dma_addr_t addr,
>   static inline MemTxResult pci_dma_read(PCIDevice *dev, dma_addr_t addr,
>                                          void *buf, dma_addr_t len)
>   {
> +    MemTxAttrs attrs = {};
> +    attrs.requester_id = pci_requester_id(dev);
> +
>       return pci_dma_rw(dev, addr, buf, len,
> -                      DMA_DIRECTION_TO_DEVICE, MEMTXATTRS_UNSPECIFIED);
> +                      DMA_DIRECTION_TO_DEVICE, attrs);
>   }
> 
>   /**
> @@ -268,8 +271,11 @@ static inline MemTxResult pci_dma_read(PCIDevice *dev, dma_addr_t addr,
>   static inline MemTxResult pci_dma_write(PCIDevice *dev, dma_addr_t addr,
>                                           const void *buf, dma_addr_t len)
>   {
> +    MemTxAttrs attrs = {};
> +    attrs.requester_id = pci_requester_id(dev);
> +
>       return pci_dma_rw(dev, addr, (void *) buf, len,
> -                      DMA_DIRECTION_FROM_DEVICE, MEMTXATTRS_UNSPECIFIED);
> +                      DMA_DIRECTION_FROM_DEVICE, attrs);
>   }
> 
>   #define PCI_DMA_DEFINE_LDST(_l, _s, _bits) \
> @@ -313,8 +319,11 @@ PCI_DMA_DEFINE_LDST(q_be, q_be, 64);
>   static inline void *pci_dma_map(PCIDevice *dev, dma_addr_t addr,
>                                   dma_addr_t *plen, DMADirection dir)
>   {
> +    MemTxAttrs attrs = {};
> +    attrs.requester_id = pci_requester_id(dev);
> +
>       return dma_memory_map(pci_get_address_space(dev), addr, plen, dir,
> -                          MEMTXATTRS_UNSPECIFIED);
> +                          attrs);
>   }
> 
> We hope not to call pci_setup_iommu() in hw/riscv/riscv-iommu.c to avoid conflicts of iommu_ops. Do you have any suggestion on this issue?

As far as the riscv-iommu changes might go, I'm ok with adding more properties
in the device to customize whether it creates its own iommu_ops (like it's
done today) or whether we should skip it since another entity might provide
it.

I can't comment much on the Designware changes. It seems sensible to me but
I'm not acquainted with how the Designware pci-host works. I couldn't find
the docs for it either in a (lazy) search I just did.

I appreciate if someone more knowledgeable with the Designware device can
comment.


Thanks,

Daniel


> 
> Thanks.
> 
>> +    } else {
>> +        error_setg(errp, "can't register secondary IOMMU for PCI bus #%d",
>> +            pci_bus_num(bus));
>> +    }
>> +}
>> +
>> +static int riscv_iommu_memory_region_index(IOMMUMemoryRegion *iommu_mr,
>> +    MemTxAttrs attrs)
>> +{
>> +    return attrs.unspecified ? RISCV_IOMMU_NOPASID : (int)attrs.pasid;
>> +}
>> +
>> +static int riscv_iommu_memory_region_index_len(IOMMUMemoryRegion *iommu_mr)
>> +{
>> +    RISCVIOMMUSpace *as = container_of(iommu_mr, RISCVIOMMUSpace, iova_mr);
>> +    return 1 << as->iommu->pasid_bits;
>> +}
>> +
>> +static void riscv_iommu_memory_region_init(ObjectClass *klass, void *data)
>> +{
>> +    IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_CLASS(klass);
>> +
>> +    imrc->translate = riscv_iommu_memory_region_translate;
>> +    imrc->notify_flag_changed = riscv_iommu_memory_region_notify;
>> +    imrc->attrs_to_index = riscv_iommu_memory_region_index;
>> +    imrc->num_indexes = riscv_iommu_memory_region_index_len;
>> +}
>> +
>> +static const TypeInfo riscv_iommu_memory_region_info = {
>> +    .parent = TYPE_IOMMU_MEMORY_REGION,
>> +    .name = TYPE_RISCV_IOMMU_MEMORY_REGION,
>> +    .class_init = riscv_iommu_memory_region_init,
>> +};
>> +
>> +static void riscv_iommu_register_mr_types(void)
>> +{
>> +    type_register_static(&riscv_iommu_memory_region_info);
>> +    type_register_static(&riscv_iommu_info);
>> +}
>> +
>> +type_init(riscv_iommu_register_mr_types);
>> diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
>> new file mode 100644
>> index 0000000000..31d3907d33
>> --- /dev/null
>> +++ b/hw/riscv/riscv-iommu.h
>> @@ -0,0 +1,141 @@
>> +/*
>> + * QEMU emulation of an RISC-V IOMMU
>> + *
>> + * Copyright (C) 2022-2023 Rivos Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License along
>> + * with this program; if not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#ifndef HW_RISCV_IOMMU_STATE_H
>> +#define HW_RISCV_IOMMU_STATE_H
>> +
>> +#include "qemu/osdep.h"
>> +#include "qom/object.h"
>> +
>> +#include "hw/riscv/iommu.h"
>> +
>> +struct RISCVIOMMUState {
>> +    /*< private >*/
>> +    DeviceState parent_obj;
>> +
>> +    /*< public >*/
>> +    uint32_t version;     /* Reported interface version number */
>> +    uint32_t pasid_bits;  /* process identifier width */
>> +    uint32_t bus;         /* PCI bus mapping for non-root endpoints */
>> +
>> +    uint64_t cap;         /* IOMMU supported capabilities */
>> +    uint64_t fctl;        /* IOMMU enabled features */
>> +
>> +    bool enable_off;      /* Enable out-of-reset OFF mode (DMA disabled) */
>> +    bool enable_msi;      /* Enable MSI remapping */
>> +
>> +    /* IOMMU Internal State */
>> +    uint64_t ddtp;        /* Validated Device Directory Tree Root Pointer */
>> +
>> +    dma_addr_t cq_addr;   /* Command queue base physical address */
>> +    dma_addr_t fq_addr;   /* Fault/event queue base physical address */
>> +    dma_addr_t pq_addr;   /* Page request queue base physical address */
>> +
>> +    uint32_t cq_mask;     /* Command queue index bit mask */
>> +    uint32_t fq_mask;     /* Fault/event queue index bit mask */
>> +    uint32_t pq_mask;     /* Page request queue index bit mask */
>> +
>> +    /* interrupt notifier */
>> +    void (*notify)(RISCVIOMMUState *iommu, unsigned vector);
>> +
>> +    /* IOMMU State Machine */
>> +    QemuThread core_proc; /* Background processing thread */
>> +    QemuMutex core_lock;  /* Global IOMMU lock, used for cache/regs updates */
>> +    QemuCond core_cond;   /* Background processing wake up signal */
>> +    unsigned core_exec;   /* Processing thread execution actions */
>> +
>> +    /* IOMMU target address space */
>> +    AddressSpace *target_as;
>> +    MemoryRegion *target_mr;
>> +
>> +    /* MSI / MRIF access trap */
>> +    AddressSpace trap_as;
>> +    MemoryRegion trap_mr;
>> +
>> +    GHashTable *ctx_cache;          /* Device translation Context Cache */
>> +
>> +    /* MMIO Hardware Interface */
>> +    MemoryRegion regs_mr;
>> +    QemuSpin regs_lock;
>> +    uint8_t *regs_rw;  /* register state (user write) */
>> +    uint8_t *regs_wc;  /* write-1-to-clear mask */
>> +    uint8_t *regs_ro;  /* read-only mask */
>> +
>> +    QLIST_ENTRY(RISCVIOMMUState) iommus;
>> +    QLIST_HEAD(, RISCVIOMMUSpace) spaces;
>> +};
>> +
>> +void riscv_iommu_pci_setup_iommu(RISCVIOMMUState *iommu, PCIBus *bus,
>> +         Error **errp);
>> +
>> +/* private helpers */
>> +
>> +/* Register helper functions */
>> +static inline uint32_t riscv_iommu_reg_mod32(RISCVIOMMUState *s,
>> +    unsigned idx, uint32_t set, uint32_t clr)
>> +{
>> +    uint32_t val;
>> +    qemu_spin_lock(&s->regs_lock);
>> +    val = ldl_le_p(s->regs_rw + idx);
>> +    stl_le_p(s->regs_rw + idx, (val & ~clr) | set);
>> +    qemu_spin_unlock(&s->regs_lock);
>> +    return val;
>> +}
>> +
>> +static inline void riscv_iommu_reg_set32(RISCVIOMMUState *s,
>> +    unsigned idx, uint32_t set)
>> +{
>> +    qemu_spin_lock(&s->regs_lock);
>> +    stl_le_p(s->regs_rw + idx, set);
>> +    qemu_spin_unlock(&s->regs_lock);
>> +}
>> +
>> +static inline uint32_t riscv_iommu_reg_get32(RISCVIOMMUState *s,
>> +    unsigned idx)
>> +{
>> +    return ldl_le_p(s->regs_rw + idx);
>> +}
>> +
>> +static inline uint64_t riscv_iommu_reg_mod64(RISCVIOMMUState *s,
>> +    unsigned idx, uint64_t set, uint64_t clr)
>> +{
>> +    uint64_t val;
>> +    qemu_spin_lock(&s->regs_lock);
>> +    val = ldq_le_p(s->regs_rw + idx);
>> +    stq_le_p(s->regs_rw + idx, (val & ~clr) | set);
>> +    qemu_spin_unlock(&s->regs_lock);
>> +    return val;
>> +}
>> +
>> +static inline void riscv_iommu_reg_set64(RISCVIOMMUState *s,
>> +    unsigned idx, uint64_t set)
>> +{
>> +    qemu_spin_lock(&s->regs_lock);
>> +    stq_le_p(s->regs_rw + idx, set);
>> +    qemu_spin_unlock(&s->regs_lock);
>> +}
>> +
>> +static inline uint64_t riscv_iommu_reg_get64(RISCVIOMMUState *s,
>> +    unsigned idx)
>> +{
>> +    return ldq_le_p(s->regs_rw + idx);
>> +}
>> +
>> +
>> +
>> +#endif
>> diff --git a/hw/riscv/trace-events b/hw/riscv/trace-events
>> new file mode 100644
>> index 0000000000..42a97caffa
>> --- /dev/null
>> +++ b/hw/riscv/trace-events
>> @@ -0,0 +1,11 @@
>> +# See documentation at docs/devel/tracing.rst
>> +
>> +# riscv-iommu.c
>> +riscv_iommu_new(const char *id, unsigned b, unsigned d, unsigned f) "%s: device attached %04x:%02x.%d"
>> +riscv_iommu_flt(const char *id, unsigned b, unsigned d, unsigned f, uint64_t reason, uint64_t iova) "%s: fault %04x:%02x.%u reason: 0x%"PRIx64" iova: 0x%"PRIx64
>> +riscv_iommu_pri(const char *id, unsigned b, unsigned d, unsigned f, uint64_t iova) "%s: page request %04x:%02x.%u iova: 0x%"PRIx64
>> +riscv_iommu_dma(const char *id, unsigned b, unsigned d, unsigned f, unsigned pasid, const char *dir, uint64_t iova, uint64_t phys) "%s: translate %04x:%02x.%u #%u %s 0x%"PRIx64" -> 0x%"PRIx64
>> +riscv_iommu_msi(const char *id, unsigned b, unsigned d, unsigned f, uint64_t iova, uint64_t phys) "%s: translate %04x:%02x.%u MSI 0x%"PRIx64" -> 0x%"PRIx64
>> +riscv_iommu_cmd(const char *id, uint64_t l, uint64_t u) "%s: command 0x%"PRIx64" 0x%"PRIx64
>> +riscv_iommu_notifier_add(const char *id) "%s: dev-iotlb notifier added"
>> +riscv_iommu_notifier_del(const char *id) "%s: dev-iotlb notifier removed"
>> diff --git a/hw/riscv/trace.h b/hw/riscv/trace.h
>> new file mode 100644
>> index 0000000000..8c0e3ca1f3
>> --- /dev/null
>> +++ b/hw/riscv/trace.h
>> @@ -0,0 +1 @@
>> +#include "trace/trace-hw_riscv.h"
>> diff --git a/include/hw/riscv/iommu.h b/include/hw/riscv/iommu.h
>> new file mode 100644
>> index 0000000000..070ee69973
>> --- /dev/null
>> +++ b/include/hw/riscv/iommu.h
>> @@ -0,0 +1,36 @@
>> +/*
>> + * QEMU emulation of an RISC-V IOMMU
>> + *
>> + * Copyright (C) 2022-2023 Rivos Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License along
>> + * with this program; if not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#ifndef HW_RISCV_IOMMU_H
>> +#define HW_RISCV_IOMMU_H
>> +
>> +#include "qemu/osdep.h"
>> +#include "qom/object.h"
>> +
>> +#define TYPE_RISCV_IOMMU "riscv-iommu"
>> +OBJECT_DECLARE_SIMPLE_TYPE(RISCVIOMMUState, RISCV_IOMMU)
>> +typedef struct RISCVIOMMUState RISCVIOMMUState;
>> +
>> +#define TYPE_RISCV_IOMMU_MEMORY_REGION "riscv-iommu-mr"
>> +typedef struct RISCVIOMMUSpace RISCVIOMMUSpace;
>> +
>> +#define TYPE_RISCV_IOMMU_PCI "riscv-iommu-pci"
>> +OBJECT_DECLARE_SIMPLE_TYPE(RISCVIOMMUStatePci, RISCV_IOMMU_PCI)
>> +typedef struct RISCVIOMMUStatePci RISCVIOMMUStatePci;
>> +
>> +#endif
>> diff --git a/meson.build b/meson.build
>> index a9de71d450..8099d8271c 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -3319,6 +3319,7 @@ if have_system
>>       'hw/pci-host',
>>       'hw/ppc',
>>       'hw/rtc',
>> +    'hw/riscv',
>>       'hw/s390x',
>>       'hw/scsi',
>>       'hw/sd',

