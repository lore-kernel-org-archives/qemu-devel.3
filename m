Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A9BFC3DA62
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 07:07:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sULEI-0000ZK-RI; Thu, 18 Jul 2024 03:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1sULEF-0000M0-Bh
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 03:07:03 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1sULED-0002iU-0m
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 03:07:03 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-70af22a9c19so309409b3a.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 00:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1721286415; x=1721891215; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dPEqvxtfgGgFrES4Ao0UX9lIcl0GQEr6PDMc2/65FIc=;
 b=TjMTYaKeTixBL0VVyGsHb+xuHPgowmKBo5r1P2xfC+3JmDrY1tjQWM69koJoE7v5/G
 92mUHY1J5Njuiz5rOy2Zs2pqBu9JNxHHQJ7ZjYqpV6M6NtxjZyUr4/8DV/HPPfvDUUyJ
 xVgQ6jmMDPVLtaCSWmoYzwgef5iD3cSF/dOIwuShIzcDZFVDZ0Hho32Ddca1HW/Ezqb0
 WKgWCPqNz7CyfsLpdYvRmptxZ/wVZBHDtQQczVTcxpU9jL5Rz62zJW35rgyEZbDYmNfB
 lT/DWkeop3nOYfiFdX/YxBu6ZtXkmaXWSvklATDfyTZx+smy3OuYX23R1/n3b8ID16Bb
 3Y4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721286415; x=1721891215;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dPEqvxtfgGgFrES4Ao0UX9lIcl0GQEr6PDMc2/65FIc=;
 b=vKr0YJgx/N5AoT/MBBe838wZuSDgYQ/43CK9PLflVHD9cu0nB3j1scrQ/V8q9hl5wP
 VVinFK+g91fmmvIv16BCmyWwZ5wwXUY5coCJc0OZo6JFxemBGB9JOCnuEAFxTFIQvUbY
 /0VuEHayFFtiELbNYtYFIJhuOe4gk28t4zRz0S1WlGK2VFOwe8jOO75AQlJvuBqGSLgw
 0eslbDZHu4ZaEjhPrYmQOtnrtJ+uPbB1zyI/eCIDDkQODFSeuDCXnEodd2ZAqT50kNTp
 Cn2cC+jTjPdm4KqZ0PX0Qqy4gBqVUK0Cv1N8xhBCJicoVy7xTMXOpiNu+9bC17r9L7uv
 HjWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU61Fl0CM/tC4Rx+o2kImIIplWq0FyJlzGVbSwILUKWYITrz0iuA6ZjBDWDuOxszZmZ+YOj5hwVXjENwloKnAjqhd682IM=
X-Gm-Message-State: AOJu0YzAZ0yNl7Y7aFXyvttCypcMlPVCZMXPF1Ofqk9PN+Gh2VvrW7vN
 FYn+lK5Z3mACPmaxfJmX2rCieVY7FltSoiW8Rfjw6aaz9CHcPnIJKXmDxTMinoI=
X-Google-Smtp-Source: AGHT+IELf1FZcm6fD9RiH00IlQEJx2gwsc1IRv3LXbEG7wAowoxtJ1gZ2qGeuMOTuwaVZL+fPLNXsQ==
X-Received: by 2002:a05:6a00:22cc:b0:706:9030:895c with SMTP id
 d2e1a72fcca58-70ce4f47ff6mr5104487b3a.3.1721286414333; 
 Thu, 18 Jul 2024 00:06:54 -0700 (PDT)
Received: from [192.168.100.252] (59-124-168-89.hinet-ip.hinet.net.
 [59.124.168.89]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b7ec7d90bsm9305971b3a.138.2024.07.18.00.06.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jul 2024 00:06:53 -0700 (PDT)
Message-ID: <cc4f842c-e331-41a5-b9b5-8598c719ec2f@sifive.com>
Date: Thu, 18 Jul 2024 15:06:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/13] hw/riscv: add riscv-iommu-pci reference device
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 frank.chang@sifive.com, tjeznach@rivosinc.com
References: <20240708173501.426225-1-dbarboza@ventanamicro.com>
 <20240708173501.426225-6-dbarboza@ventanamicro.com>
Content-Language: en-US
From: Jason Chien <jason.chien@sifive.com>
In-Reply-To: <20240708173501.426225-6-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=jason.chien@sifive.com; helo=mail-pf1-x435.google.com
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

Hi Daniel,

On 2024/7/9 上午 01:34, Daniel Henrique Barboza wrote:
> From: Tomasz Jeznach <tjeznach@rivosinc.com>
>
> The RISC-V IOMMU can be modelled as a PCIe device following the
> guidelines of the RISC-V IOMMU spec, chapter 7.1, "Integrating an IOMMU
> as a PCIe device".
>
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> ---
>   hw/riscv/meson.build       |   2 +-
>   hw/riscv/riscv-iommu-pci.c | 178 +++++++++++++++++++++++++++++++++++++
>   2 files changed, 179 insertions(+), 1 deletion(-)
>   create mode 100644 hw/riscv/riscv-iommu-pci.c
>
> diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
> index cbc99c6e8e..adbef8a9b2 100644
> --- a/hw/riscv/meson.build
> +++ b/hw/riscv/meson.build
> @@ -10,6 +10,6 @@ riscv_ss.add(when: 'CONFIG_SIFIVE_U', if_true: files('sifive_u.c'))
>   riscv_ss.add(when: 'CONFIG_SPIKE', if_true: files('spike.c'))
>   riscv_ss.add(when: 'CONFIG_MICROCHIP_PFSOC', if_true: files('microchip_pfsoc.c'))
>   riscv_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
> -riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files('riscv-iommu.c'))
> +riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files('riscv-iommu.c', 'riscv-iommu-pci.c'))
>   
>   hw_arch += {'riscv': riscv_ss}
> diff --git a/hw/riscv/riscv-iommu-pci.c b/hw/riscv/riscv-iommu-pci.c
> new file mode 100644
> index 0000000000..7b82ce0645
> --- /dev/null
> +++ b/hw/riscv/riscv-iommu-pci.c
> @@ -0,0 +1,178 @@
> +/*
> + * QEMU emulation of an RISC-V IOMMU
> + *
> + * Copyright (C) 2022-2023 Rivos Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/pci/msi.h"
> +#include "hw/pci/msix.h"
> +#include "hw/pci/pci_bus.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/riscv/riscv_hart.h"
> +#include "migration/vmstate.h"
> +#include "qapi/error.h"
> +#include "qemu/error-report.h"
> +#include "qemu/host-utils.h"
> +#include "qom/object.h"
> +
> +#include "cpu_bits.h"
> +#include "riscv-iommu.h"
> +#include "riscv-iommu-bits.h"
> +
> +/* RISC-V IOMMU PCI Device Emulation */
> +#define RISCV_PCI_CLASS_SYSTEM_IOMMU     0x0806
> +
> +typedef struct RISCVIOMMUStatePci {
> +    PCIDevice        pci;     /* Parent PCIe device state */
> +    uint16_t         vendor_id;
> +    uint16_t         device_id;
> +    uint8_t          revision;
> +    MemoryRegion     bar0;    /* PCI BAR (including MSI-x config) */
> +    RISCVIOMMUState  iommu;   /* common IOMMU state */
> +} RISCVIOMMUStatePci;
> +
> +/* interrupt delivery callback */
> +static void riscv_iommu_pci_notify(RISCVIOMMUState *iommu, unsigned vector)
> +{
> +    RISCVIOMMUStatePci *s = container_of(iommu, RISCVIOMMUStatePci, iommu);
> +
> +    if (msix_enabled(&(s->pci))) {
> +        msix_notify(&(s->pci), vector);
> +    }
> +}
> +
> +static void riscv_iommu_pci_realize(PCIDevice *dev, Error **errp)
> +{
> +    RISCVIOMMUStatePci *s = DO_UPCAST(RISCVIOMMUStatePci, pci, dev);
> +    RISCVIOMMUState *iommu = &s->iommu;
> +    uint8_t *pci_conf = dev->config;
> +    Error *err = NULL;
> +
> +    pci_set_word(pci_conf + PCI_VENDOR_ID, s->vendor_id);
> +    pci_set_word(pci_conf + PCI_SUBSYSTEM_VENDOR_ID, s->vendor_id);
> +    pci_set_word(pci_conf + PCI_DEVICE_ID, s->device_id);
> +    pci_set_word(pci_conf + PCI_SUBSYSTEM_ID, s->device_id);
> +    pci_set_byte(pci_conf + PCI_REVISION_ID, s->revision);
> +
> +    /* Set device id for trace / debug */
> +    DEVICE(iommu)->id = g_strdup_printf("%02x:%02x.%01x",
> +        pci_dev_bus_num(dev), PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
> +    qdev_realize(DEVICE(iommu), NULL, errp);
> +
> +    memory_region_init(&s->bar0, OBJECT(s), "riscv-iommu-bar0",
> +        QEMU_ALIGN_UP(memory_region_size(&iommu->regs_mr), TARGET_PAGE_SIZE));
> +    memory_region_add_subregion(&s->bar0, 0, &iommu->regs_mr);
> +
> +    pcie_endpoint_cap_init(dev, 0);
> +
> +    pci_register_bar(dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY |
> +                     PCI_BASE_ADDRESS_MEM_TYPE_64, &s->bar0);
> +
> +    int ret = msix_init(dev, RISCV_IOMMU_INTR_COUNT,
> +                        &s->bar0, 0, RISCV_IOMMU_REG_MSI_CONFIG,
> +                        &s->bar0, 0, RISCV_IOMMU_REG_MSI_CONFIG + 256, 0, &err);
> +
> +    if (ret == -ENOTSUP) {
> +        /*
> +         * MSI-x is not supported by the platform.
> +         * Driver should use timer/polling based notification handlers.
> +         */
> +        warn_report_err(err);
> +    } else if (ret < 0) {
> +        error_propagate(errp, err);
> +        return;
> +    } else {
> +        /* mark all allocated MSIx vectors as used. */
> +        msix_vector_use(dev, RISCV_IOMMU_INTR_CQ);
> +        msix_vector_use(dev, RISCV_IOMMU_INTR_FQ);
> +        msix_vector_use(dev, RISCV_IOMMU_INTR_PM);
> +        msix_vector_use(dev, RISCV_IOMMU_INTR_PQ);
In ICVEC register, each interrupt cause has a 4-bit field, which can be 
configured with values within 0 to 15. We only allow vector values being 
0 to 3 here, but software may want to use other vector number.
> +        iommu->notify = riscv_iommu_pci_notify;
> +    }
> +
> +    PCIBus *bus = pci_device_root_bus(dev);
> +    if (!bus) {
> +        error_setg(errp, "can't find PCIe root port for %02x:%02x.%x",
> +            pci_bus_num(pci_get_bus(dev)), PCI_SLOT(dev->devfn),
> +            PCI_FUNC(dev->devfn));
> +        return;
> +    }
> +
> +    riscv_iommu_pci_setup_iommu(iommu, bus, errp);
> +}
> +
> +static void riscv_iommu_pci_exit(PCIDevice *pci_dev)
> +{
> +    pci_setup_iommu(pci_device_root_bus(pci_dev), NULL, NULL);
> +}
> +
> +static const VMStateDescription riscv_iommu_vmstate = {
> +    .name = "riscv-iommu",
> +    .unmigratable = 1
> +};
> +
> +static void riscv_iommu_pci_init(Object *obj)
> +{
> +    RISCVIOMMUStatePci *s = RISCV_IOMMU_PCI(obj);
> +    RISCVIOMMUState *iommu = &s->iommu;
> +
> +    object_initialize_child(obj, "iommu", iommu, TYPE_RISCV_IOMMU);
> +    qdev_alias_all_properties(DEVICE(iommu), obj);
> +}
> +
> +static Property riscv_iommu_pci_properties[] = {
> +    DEFINE_PROP_UINT16("vendor-id", RISCVIOMMUStatePci, vendor_id,
> +                       PCI_VENDOR_ID_REDHAT),
> +    DEFINE_PROP_UINT16("device-id", RISCVIOMMUStatePci, device_id,
> +                       PCI_DEVICE_ID_REDHAT_RISCV_IOMMU),
> +    DEFINE_PROP_UINT8("revision", RISCVIOMMUStatePci, revision, 0x01),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void riscv_iommu_pci_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
> +
> +    k->realize = riscv_iommu_pci_realize;
> +    k->exit = riscv_iommu_pci_exit;
> +    k->class_id = RISCV_PCI_CLASS_SYSTEM_IOMMU;
> +    dc->desc = "RISCV-IOMMU DMA Remapping device";
> +    dc->vmsd = &riscv_iommu_vmstate;
> +    dc->hotpluggable = false;
> +    dc->user_creatable = true;
> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> +    device_class_set_props(dc, riscv_iommu_pci_properties);
> +}
> +
> +static const TypeInfo riscv_iommu_pci = {
> +    .name = TYPE_RISCV_IOMMU_PCI,
> +    .parent = TYPE_PCI_DEVICE,
> +    .class_init = riscv_iommu_pci_class_init,
> +    .instance_init = riscv_iommu_pci_init,
> +    .instance_size = sizeof(RISCVIOMMUStatePci),
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_PCIE_DEVICE },
> +        { },
> +    },
> +};
> +
> +static void riscv_iommu_register_pci_types(void)
> +{
> +    type_register_static(&riscv_iommu_pci);
> +}
> +
> +type_init(riscv_iommu_register_pci_types);

