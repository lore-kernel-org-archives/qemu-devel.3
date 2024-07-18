Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40058C3DA60
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 04:43:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUIzJ-0004eG-5J; Thu, 18 Jul 2024 00:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sUIzI-0004dJ-7o; Thu, 18 Jul 2024 00:43:28 -0400
Received: from mail-ua1-x92f.google.com ([2607:f8b0:4864:20::92f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sUIzG-0000q0-5w; Thu, 18 Jul 2024 00:43:27 -0400
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-8218de5e3beso125360241.3; 
 Wed, 17 Jul 2024 21:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721277804; x=1721882604; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7jLiOTKC4+D81of3UMAc+E5tU6ddzz6cy39KjKsTOM0=;
 b=lX2YzngsRZR5I7H6MB9pT88RVd7AR2Cf8rwc1RgrVO/lA3q2SBRqbOde0XqUajzH2E
 EhMcQQl9Mw79EpIKuTC8Z0U/DqWpFHBsEDwhK5lF9s7Z1u4PgmiwUWzfH0kiPVkBM20j
 EwwaoppbF29tEINh4kZsgy6ERhSn08EnQ6+Tw5caUeWwFleWPBHETrUj0OMUSjqYonGV
 XWbkFHg0MEIT1D55L4WYUGjeMrnCv2C7QVVTvK1dO8mn9ub7yZyUk3w+EWZzDJVCeTVD
 Zpnf+g4773eXM+yXNUZw7B+Q/KWORb65ns5a4XSfjPcnqZ0VIc1pJqNjZ58jVhkh5KKg
 bdNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721277804; x=1721882604;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7jLiOTKC4+D81of3UMAc+E5tU6ddzz6cy39KjKsTOM0=;
 b=VQ8Q6SfIGk0jfWrLwuskuD81j3s5Vs8Hgwb4tpmGd3EBGKyDb+p6yMd23xf3nwNETa
 J9Ahbr0C18GXaBA9pmg2uLJ02MYL1wvRhOS8Y7bJbjH7XYZD1QvDhzt5JCYgw0b4hxIL
 BcMZmBj1/u7wGMZCBirCTSEitdOAR09sjQX6GDMs4Mz7pkcqNkhQ6i4dtkvTq1OHJQxK
 68Sw9WsQnG99OkZulqw3xIRAMRNSTNTULg4vJYUSt/ct4qHmHD8I0HuXkc81PkQs7REC
 5IOBHFjOGS8QU+WyoqBqn76tXZAUqxZLzxtICd6FT6bCLaGOBepwHbnI7N0MUAMb+pmO
 KtQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVn3xvwYaHUqQcpWINXi5PsAEPVfpIai1qkMgpmK+s6IX0tIzRzNmNLMokTSXTyiWPtAjxnDJvYY25V/ID7e8+e0GKDFB8=
X-Gm-Message-State: AOJu0YxnCItoyZGDLhbNMk+xEo5ZVA74GdXgAiokS28kD4C1zIe2YAJp
 3xfT3p63myCFqigUlkVpCUVQmgDHHJ2XrN6YwjsEho9Eukp+JKlAVWka1d5h6CG1CakrRCwR2KW
 vRSIbIjHD1TA84UDPO78Z8qFSg8w=
X-Google-Smtp-Source: AGHT+IHFYsKHGKgsNqlNGsnXX3blawhRo/hAD1si75aASdOnbUyjv4ITjo6A8u13vSuygOZ58/6D42PbW0a4lwJMcEE=
X-Received: by 2002:a05:6102:15aa:b0:48f:79de:909e with SMTP id
 ada2fe7eead31-49159849e1cmr5648062137.18.1721277804115; Wed, 17 Jul 2024
 21:43:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240708173501.426225-1-dbarboza@ventanamicro.com>
 <20240708173501.426225-6-dbarboza@ventanamicro.com>
In-Reply-To: <20240708173501.426225-6-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 18 Jul 2024 14:42:58 +1000
Message-ID: <CAKmqyKM+WMqAK+O7UNLf=GQJ-QpnST=q+qa2MVARdKwb97UOgw@mail.gmail.com>
Subject: Re: [PATCH v5 05/13] hw/riscv: add riscv-iommu-pci reference device
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, frank.chang@sifive.com, tjeznach@rivosinc.com, 
 jason.chien@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92f;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Tue, Jul 9, 2024 at 3:38=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> From: Tomasz Jeznach <tjeznach@rivosinc.com>
>
> The RISC-V IOMMU can be modelled as a PCIe device following the
> guidelines of the RISC-V IOMMU spec, chapter 7.1, "Integrating an IOMMU
> as a PCIe device".
>
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/meson.build       |   2 +-
>  hw/riscv/riscv-iommu-pci.c | 178 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 179 insertions(+), 1 deletion(-)
>  create mode 100644 hw/riscv/riscv-iommu-pci.c
>
> diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
> index cbc99c6e8e..adbef8a9b2 100644
> --- a/hw/riscv/meson.build
> +++ b/hw/riscv/meson.build
> @@ -10,6 +10,6 @@ riscv_ss.add(when: 'CONFIG_SIFIVE_U', if_true: files('s=
ifive_u.c'))
>  riscv_ss.add(when: 'CONFIG_SPIKE', if_true: files('spike.c'))
>  riscv_ss.add(when: 'CONFIG_MICROCHIP_PFSOC', if_true: files('microchip_p=
fsoc.c'))
>  riscv_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
> -riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files('riscv-iommu.c')=
)
> +riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files('riscv-iommu.c',=
 'riscv-iommu-pci.c'))
>
>  hw_arch +=3D {'riscv': riscv_ss}
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
> + * You should have received a copy of the GNU General Public License alo=
ng
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
> +static void riscv_iommu_pci_notify(RISCVIOMMUState *iommu, unsigned vect=
or)
> +{
> +    RISCVIOMMUStatePci *s =3D container_of(iommu, RISCVIOMMUStatePci, io=
mmu);
> +
> +    if (msix_enabled(&(s->pci))) {
> +        msix_notify(&(s->pci), vector);
> +    }
> +}
> +
> +static void riscv_iommu_pci_realize(PCIDevice *dev, Error **errp)
> +{
> +    RISCVIOMMUStatePci *s =3D DO_UPCAST(RISCVIOMMUStatePci, pci, dev);
> +    RISCVIOMMUState *iommu =3D &s->iommu;
> +    uint8_t *pci_conf =3D dev->config;
> +    Error *err =3D NULL;
> +
> +    pci_set_word(pci_conf + PCI_VENDOR_ID, s->vendor_id);
> +    pci_set_word(pci_conf + PCI_SUBSYSTEM_VENDOR_ID, s->vendor_id);
> +    pci_set_word(pci_conf + PCI_DEVICE_ID, s->device_id);
> +    pci_set_word(pci_conf + PCI_SUBSYSTEM_ID, s->device_id);
> +    pci_set_byte(pci_conf + PCI_REVISION_ID, s->revision);
> +
> +    /* Set device id for trace / debug */
> +    DEVICE(iommu)->id =3D g_strdup_printf("%02x:%02x.%01x",
> +        pci_dev_bus_num(dev), PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn)=
);
> +    qdev_realize(DEVICE(iommu), NULL, errp);
> +
> +    memory_region_init(&s->bar0, OBJECT(s), "riscv-iommu-bar0",
> +        QEMU_ALIGN_UP(memory_region_size(&iommu->regs_mr), TARGET_PAGE_S=
IZE));
> +    memory_region_add_subregion(&s->bar0, 0, &iommu->regs_mr);
> +
> +    pcie_endpoint_cap_init(dev, 0);
> +
> +    pci_register_bar(dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY |
> +                     PCI_BASE_ADDRESS_MEM_TYPE_64, &s->bar0);
> +
> +    int ret =3D msix_init(dev, RISCV_IOMMU_INTR_COUNT,
> +                        &s->bar0, 0, RISCV_IOMMU_REG_MSI_CONFIG,
> +                        &s->bar0, 0, RISCV_IOMMU_REG_MSI_CONFIG + 256, 0=
, &err);
> +
> +    if (ret =3D=3D -ENOTSUP) {
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
> +        iommu->notify =3D riscv_iommu_pci_notify;
> +    }
> +
> +    PCIBus *bus =3D pci_device_root_bus(dev);
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
> +static const VMStateDescription riscv_iommu_vmstate =3D {
> +    .name =3D "riscv-iommu",
> +    .unmigratable =3D 1
> +};
> +
> +static void riscv_iommu_pci_init(Object *obj)
> +{
> +    RISCVIOMMUStatePci *s =3D RISCV_IOMMU_PCI(obj);
> +    RISCVIOMMUState *iommu =3D &s->iommu;
> +
> +    object_initialize_child(obj, "iommu", iommu, TYPE_RISCV_IOMMU);
> +    qdev_alias_all_properties(DEVICE(iommu), obj);
> +}
> +
> +static Property riscv_iommu_pci_properties[] =3D {
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
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
> +
> +    k->realize =3D riscv_iommu_pci_realize;
> +    k->exit =3D riscv_iommu_pci_exit;
> +    k->class_id =3D RISCV_PCI_CLASS_SYSTEM_IOMMU;
> +    dc->desc =3D "RISCV-IOMMU DMA Remapping device";
> +    dc->vmsd =3D &riscv_iommu_vmstate;
> +    dc->hotpluggable =3D false;
> +    dc->user_creatable =3D true;
> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> +    device_class_set_props(dc, riscv_iommu_pci_properties);
> +}
> +
> +static const TypeInfo riscv_iommu_pci =3D {
> +    .name =3D TYPE_RISCV_IOMMU_PCI,
> +    .parent =3D TYPE_PCI_DEVICE,
> +    .class_init =3D riscv_iommu_pci_class_init,
> +    .instance_init =3D riscv_iommu_pci_init,
> +    .instance_size =3D sizeof(RISCVIOMMUStatePci),
> +    .interfaces =3D (InterfaceInfo[]) {
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
> --
> 2.45.2
>
>

