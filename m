Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35DC2C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 09:38:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2StA-0006qd-Mq; Thu, 02 May 2024 05:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1s2St3-0006nI-QJ
 for qemu-devel@nongnu.org; Thu, 02 May 2024 05:37:57 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1s2St1-0006MZ-98
 for qemu-devel@nongnu.org; Thu, 02 May 2024 05:37:57 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1ecddf96313so5772575ad.2
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 02:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1714642673; x=1715247473; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m0k0h5hPaivitv0RCvHuY2gfDDKuRs1xOl9Nj6FdJIE=;
 b=j4i2tdGqqDminWKy3prpHyLbIa7xLvVjYsJmhvCt9oKpmprDxbtAe89mXt37Mmm6Lv
 8jbR9skRm1mL2q0B9sYWTmuuw+2XAca+9zS8UwLLHkfoX1KxeErv6P+whZbgZPu5MNCG
 /qxOJOxI8sYA26N4iFAUoC05mjYd/GJyUseDEPHTs0xZq41oaI7rmFlCMLWDvUOABXCc
 ra2ubR3lk0kBKlh32BJSZnBCtYBECfMipb2N1yF+IUbTlBg2bXvVuX0NgPQjyOIWR/8c
 kT43pzJHgbRfzs5ec4DfMF3KEid3LwlK0tq5RGMVLvOWAOg8rHmQ6ICpWRzZi4aq15+k
 Qlqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714642673; x=1715247473;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m0k0h5hPaivitv0RCvHuY2gfDDKuRs1xOl9Nj6FdJIE=;
 b=ICYRZQjyKmTofwW2LRE9TZ68PXvFS1CJ2UvJcLRayW3O1njVQ7rTjZ8P+JZOQjspdf
 +dD02Q4qLm78tMQ6EFICtTZFnjojZec8LlojUoBu/KOb39lvuow0sYU+fKnyYQktJHbr
 /OydLISY3Jfbm/sbcOImk488W0PH0vaIeeGKQcJJFkJtdv7OIu2PdIQ5IMif3kptNoDF
 GFLBBHMlGi1iUndBO6j2i39QheWeV0JHAY93vs8b9qFj5ZVSk7X79jIeS6yjJuCt01p4
 Mja9sTKmJpeiMYvu4DGmerbkKwkP7M99G2iR4A43wTROKwA1PZ4w4tldSbbOG1j9oHpy
 qBlg==
X-Gm-Message-State: AOJu0YyptcMNtjI8sIQW/yMdO3YNpqDQkL8hFycXPcMR1xjyhaVNhM6P
 fskW1qfvlGjdGWkb4stKpxCPzkX7jnUjroreVVPE5gU7Ht4TocrUCCoPK2dSO1E=
X-Google-Smtp-Source: AGHT+IH8LOTBKHURBIUKcX9GgZdvlZlgdgic/VHYX4Qr8lYtWiMskrfR0cLlidLd26wVLEiC2NF+eA==
X-Received: by 2002:a17:903:191:b0:1e8:5cf9:37fc with SMTP id
 z17-20020a170903019100b001e85cf937fcmr1945367plg.35.1714642672613; 
 Thu, 02 May 2024 02:37:52 -0700 (PDT)
Received: from [192.168.68.110] ([187.11.154.208])
 by smtp.gmail.com with ESMTPSA id
 n17-20020a170903111100b001ec4e457c39sm825442plh.195.2024.05.02.02.37.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 May 2024 02:37:52 -0700 (PDT)
Message-ID: <471027a0-20e0-4d42-b5ed-2f6fb4da7b8a@ventanamicro.com>
Date: Thu, 2 May 2024 06:37:47 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/15] hw/riscv: add riscv-iommu-pci device
Content-Language: en-US
To: Frank Chang <frank.chang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 palmer@rivosinc.com, ajones@ventanamicro.com, tjeznach@rivosinc.com
References: <20240307160319.675044-1-dbarboza@ventanamicro.com>
 <20240307160319.675044-5-dbarboza@ventanamicro.com>
 <CANzO1D3gOh23xhPhjcrGqSanf=aX_o-V+mBQY7yW6P+0hOR6Nw@mail.gmail.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <CANzO1D3gOh23xhPhjcrGqSanf=aX_o-V+mBQY7yW6P+0hOR6Nw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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



On 4/29/24 04:21, Frank Chang wrote:
> Daniel Henrique Barboza <dbarboza@ventanamicro.com <mailto:dbarboza@ventanamicro.com>> 於 2024年3月8日 週五 上午12:04寫道：
>  >
>  > From: Tomasz Jeznach <tjeznach@rivosinc.com <mailto:tjeznach@rivosinc.com>>
>  >
>  > The RISC-V IOMMU can be modelled as a PCIe device following the
>  > guidelines of the RISC-V IOMMU spec, chapter 7.1, "Integrating an IOMMU
>  > as a PCIe device".
>  >
>  > Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com <mailto:tjeznach@rivosinc.com>>
>  > Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com <mailto:dbarboza@ventanamicro.com>>
>  > ---
>  >  hw/riscv/meson.build       |   2 +-
>  >  hw/riscv/riscv-iommu-pci.c | 173 +++++++++++++++++++++++++++++++++++++
>  >  2 files changed, 174 insertions(+), 1 deletion(-)
>  >  create mode 100644 hw/riscv/riscv-iommu-pci.c
>  >
>  > diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
>  > index ba9eebd605..4674cec6c4 100644
>  > --- a/hw/riscv/meson.build
>  > +++ b/hw/riscv/meson.build
>  > @@ -10,6 +10,6 @@ riscv_ss.add(when: 'CONFIG_SIFIVE_U', if_true: files('sifive_u.c'))
>  >  riscv_ss.add(when: 'CONFIG_SPIKE', if_true: files('spike.c'))
>  >  riscv_ss.add(when: 'CONFIG_MICROCHIP_PFSOC', if_true: files('microchip_pfsoc.c'))
>  >  riscv_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
>  > -riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files('riscv-iommu.c'))
>  > +riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files('riscv-iommu.c', 'riscv-iommu-pci.c'))
>  >
>  >  hw_arch += {'riscv': riscv_ss}
>  > diff --git a/hw/riscv/riscv-iommu-pci.c b/hw/riscv/riscv-iommu-pci.c
>  > new file mode 100644
>  > index 0000000000..4eb1057210
>  > --- /dev/null
>  > +++ b/hw/riscv/riscv-iommu-pci.c
>  > @@ -0,0 +1,173 @@
>  > +/*
>  > + * QEMU emulation of an RISC-V IOMMU (Ziommu)
>  > + *
>  > + * Copyright (C) 2022-2023 Rivos Inc.
>  > + *
>  > + * This program is free software; you can redistribute it and/or modify
>  > + * it under the terms of the GNU General Public License as published by
>  > + * the Free Software Foundation; either version 2 of the License.
>  > + *
>  > + * This program is distributed in the hope that it will be useful,
>  > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>  > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>  > + * GNU General Public License for more details.
>  > + *
>  > + * You should have received a copy of the GNU General Public License along
>  > + * with this program; if not, see <http://www.gnu.org/licenses/ <http://www.gnu.org/licenses/>>.
>  > + */
>  > +
>  > +#include "qemu/osdep.h"
>  > +#include "hw/pci/msi.h"
>  > +#include "hw/pci/msix.h"
>  > +#include "hw/pci/pci_bus.h"
>  > +#include "hw/qdev-properties.h"
>  > +#include "hw/riscv/riscv_hart.h"
>  > +#include "migration/vmstate.h"
>  > +#include "qapi/error.h"
>  > +#include "qemu/error-report.h"
>  > +#include "qemu/host-utils.h"
>  > +#include "qom/object.h"
>  > +
>  > +#include "cpu_bits.h"
>  > +#include "riscv-iommu.h"
>  > +#include "riscv-iommu-bits.h"
>  > +
>  > +#ifndef PCI_VENDOR_ID_RIVOS
>  > +#define PCI_VENDOR_ID_RIVOS           0x1efd
>  > +#endif
>  > +
>  > +#ifndef PCI_DEVICE_ID_RIVOS_IOMMU
>  > +#define PCI_DEVICE_ID_RIVOS_IOMMU     0xedf1
>  > +#endif
>  > +
>  > +/* RISC-V IOMMU PCI Device Emulation */
>  > +
>  > +typedef struct RISCVIOMMUStatePci {
>  > +    PCIDevice        pci;     /* Parent PCIe device state */
>  > +    MemoryRegion     bar0;    /* PCI BAR (including MSI-x config) */
>  > +    RISCVIOMMUState  iommu;   /* common IOMMU state */
>  > +} RISCVIOMMUStatePci;
>  > +
>  > +/* interrupt delivery callback */
>  > +static void riscv_iommu_pci_notify(RISCVIOMMUState *iommu, unsigned vector)
>  > +{
>  > +    RISCVIOMMUStatePci *s = container_of(iommu, RISCVIOMMUStatePci, iommu);
>  > +
>  > +    if (msix_enabled(&(s->pci))) {
>  > +        msix_notify(&(s->pci), vector);
>  > +    }
>  > +}
>  > +
>  > +static void riscv_iommu_pci_realize(PCIDevice *dev, Error **errp)
>  > +{
>  > +    RISCVIOMMUStatePci *s = DO_UPCAST(RISCVIOMMUStatePci, pci, dev);
>  > +    RISCVIOMMUState *iommu = &s->iommu;
>  > +    Error *err = NULL;
>  > +
>  > +    /* Set device id for trace / debug */
>  > +    DEVICE(iommu)->id = g_strdup_printf("%02x:%02x.%01x",
>  > +        pci_dev_bus_num(dev), PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
> 
> pci_dev_bus_num() calls pci_bus_num(),
> and pci_bus_num() is assigned to pcibus_num(),
> which returns bus->parent_dev->config[PCI_SECONDARY_BUS]
> However, PCI bus number is not initialized by SW when IOMMU is initialized.
> So pci_bus_num() will always return 0, IIRC.
> Same issue as pci_bus_num() above.
> 
>  > +    qdev_realize(DEVICE(iommu), NULL, errp);
>  > +
>  > +    memory_region_init(&s->bar0, OBJECT(s), "riscv-iommu-bar0",
>  > +        QEMU_ALIGN_UP(memory_region_size(&iommu->regs_mr), TARGET_PAGE_SIZE));
>  > +    memory_region_add_subregion(&s->bar0, 0, &iommu->regs_mr);
>  > +
>  > +    pcie_endpoint_cap_init(dev, 0);
>  > +
>  > +    pci_register_bar(dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY |
>  > +                     PCI_BASE_ADDRESS_MEM_TYPE_64, &s->bar0);
>  > +
>  > +    int ret = msix_init(dev, RISCV_IOMMU_INTR_COUNT,
>  > +                        &s->bar0, 0, RISCV_IOMMU_REG_MSI_CONFIG,
>  > +                        &s->bar0, 0, RISCV_IOMMU_REG_MSI_CONFIG + 256, 0, &err);
>  > +
>  > +    if (ret == -ENOTSUP) {
>  > +        /*
>  > +         * MSI-x is not supported by the platform.
>  > +         * Driver should use timer/polling based notification handlers.
>  > +         */
>  > +        warn_report_err(err);
>  > +    } else if (ret < 0) {
>  > +        error_propagate(errp, err);
>  > +        return;
>  > +    } else {
>  > +        /* mark all allocated MSIx vectors as used. */
>  > +        msix_vector_use(dev, RISCV_IOMMU_INTR_CQ);
>  > +        msix_vector_use(dev, RISCV_IOMMU_INTR_FQ);
>  > +        msix_vector_use(dev, RISCV_IOMMU_INTR_PM);
>  > +        msix_vector_use(dev, RISCV_IOMMU_INTR_PQ);
>  > +        iommu->notify = riscv_iommu_pci_notify;
>  > +    }
>  > +
>  > +    PCIBus *bus = pci_device_root_bus(dev);
>  > +    if (!bus) {
>  > +        error_setg(errp, "can't find PCIe root port for %02x:%02x.%x",
>  > +            pci_bus_num(pci_get_bus(dev)), PCI_SLOT(dev->devfn),
> 
> Same issue to pci_dev_bus_num() above.
> 
>  > +            PCI_FUNC(dev->devfn));
>  > +        return;
>  > +    }
>  > +
>  > +    riscv_iommu_pci_setup_iommu(iommu, bus, errp);
>  > +}
>  > +
>  > +static void riscv_iommu_pci_exit(PCIDevice *pci_dev)
>  > +{
>  > +    pci_setup_iommu(pci_device_root_bus(pci_dev), NULL, NULL);
>  > +}
>  > +
>  > +static const VMStateDescription riscv_iommu_vmstate = {
>  > +    .name = "riscv-iommu",
>  > +    .unmigratable = 1
>  > +};
>  > +
>  > +static void riscv_iommu_pci_init(Object *obj)
>  > +{
>  > +    RISCVIOMMUStatePci *s = RISCV_IOMMU_PCI(obj);
>  > +    RISCVIOMMUState *iommu = &s->iommu;
>  > +
>  > +    object_initialize_child(obj, "iommu", iommu, TYPE_RISCV_IOMMU);
>  > +    qdev_alias_all_properties(DEVICE(iommu), obj);
>  > +}
>  > +
>  > +static Property riscv_iommu_pci_properties[] = {
>  > +    DEFINE_PROP_END_OF_LIST(),
>  > +};
> 
> Do we need to assign the empty properties?
> 
>  > +
>  > +static void riscv_iommu_pci_class_init(ObjectClass *klass, void *data)
>  > +{
>  > +    DeviceClass *dc = DEVICE_CLASS(klass);
>  > +    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
>  > +
>  > +    k->realize = riscv_iommu_pci_realize;
>  > +    k->exit = riscv_iommu_pci_exit;
>  > +    k->vendor_id = PCI_VENDOR_ID_RIVOS;
>  > +    k->device_id = PCI_DEVICE_ID_RIVOS_IOMMU;
> 
> I know RIVOS originally modeled this IOMMU,
> but we (SiFive) also have our IOMMU based on RISC-V IOMMU:
> https://open-src-soc.org/2022-05/media/slides/RISC-V-International-Day-2022-05-05-14h10-Perinne-Peresse.pdf <https://open-src-soc.org/2022-05/media/slides/RISC-V-International-Day-2022-05-05-14h10-Perinne-Peresse.pdf>
> Do we have the guidelines on how to extend the vendor IOMMU?

We'll use a generic PCI ID for the QEMU IOMMU model. Drew is giving a
hand looking into it. We'll either send a separated patch to add
the new PCI ID or fold the patch into this series.

As for extend the generic IOMMU, you can use this base implementation
(that doesn't have anything specific to Rivos, it's a generic spec
implementation) to implement the Si-Five device if you want. It
woud a device like:

>  > +static const TypeInfo riscv_sifive_iommu_pci = {
>  > +    .name = TYPE_RISCV_SIFIVE_IOMMU_PCI,
>  > +    .parent = TYPE_RISCV_IOMMU_PCI,

Same thing with the base emulation code. You can use it as a base and then
add the logic that is exclusive to Si-Five on top of it.


Thanks,

Daniel



> 
>  > +    k->revision = 0;
>  > +    k->class_id = 0x0806;
> 
> We should add
> #define PCI_CLASS_SYSTEM_IOMMU 0x0806
> instead of the hard-coded value.
> 
> P.S. AMD's IOMMU also uses hard-coded value 0x0806 in: hw/i386/amd_iommu.c.
> 
>  > +    dc->desc = "RISCV-IOMMU DMA Remapping device";
>  > +    dc->vmsd = &riscv_iommu_vmstate;
>  > +    dc->hotpluggable = false;
>  > +    dc->user_creatable = true;
>  > +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>  > +    device_class_set_props(dc, riscv_iommu_pci_properties);
>  > +}
>  > +
>  > +static const TypeInfo riscv_iommu_pci = {
>  > +    .name = TYPE_RISCV_IOMMU_PCI,
>  > +    .parent = TYPE_PCI_DEVICE,
>  > +    .class_init = riscv_iommu_pci_class_init,
>  > +    .instance_init = riscv_iommu_pci_init,
>  > +    .instance_size = sizeof(RISCVIOMMUStatePci),
>  > +    .interfaces = (InterfaceInfo[]) {
>  > +        { INTERFACE_PCIE_DEVICE },
>  > +        { },
>  > +    },
>  > +};
>  > +
>  > +static void riscv_iommu_register_pci_types(void)
>  > +{
>  > +    type_register_static(&riscv_iommu_pci);
>  > +}
>  > +
>  > +type_init(riscv_iommu_register_pci_types);
>  > --
>  > 2.43.2
>  >
>  >

