Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F666C27C55
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Jun 2024 08:53:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGEIn-0003Rm-Mp; Sun, 09 Jun 2024 04:53:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sGEIm-0003No-89
 for qemu-devel@nongnu.org; Sun, 09 Jun 2024 04:53:24 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sGEIk-00088i-30
 for qemu-devel@nongnu.org; Sun, 09 Jun 2024 04:53:23 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2eaafda3b5cso44513031fa.3
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2024 01:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1717923199; x=1718527999; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c20yAxQHuZXk0BqdY5ci1COmLFuuPoQ/ZAGEXtsz2bA=;
 b=I9Ny3xBL9HkRcz6KfUw74An7Qof5XZJles/9UqImzAJZELNFktefVkEwtS3tL53ib3
 XrMyN6LMFALqzMH2l1vOTXFtn5J/By6zNTy29S/dQpfRB/QwzJ21+JqHUfr3tDSCQXLY
 MYJmoPGeA9je9If1obCvwWpiifq6rnsl9On7Nr/fnQyEp0gbKMMLJnGtiLEUf96pioXc
 KRMdWcLyfxppcyItjebTpimM4643csEdMu4A2DUui8qdLUkXXchwmm4h2PKRp3gFCtM2
 KxB/3kA9woCDhvM6jYGOzrXzPI8Ggt2thA25/WllTLI4tAiJX6hhCUppFW3wxncs4+EA
 /fVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717923199; x=1718527999;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c20yAxQHuZXk0BqdY5ci1COmLFuuPoQ/ZAGEXtsz2bA=;
 b=kOU3RPPvozXm0Za5eYwysULrbvGAO27pQm0uzfSmTOG+J6LpRH6DsFOHsYUbPYDpLV
 U1FgvEvfzThdCmW0MeyeehR7y11bvPbc993Rp6cVTc0b+TCefN2pDdrOmfh8tbweHHf1
 XqA8a7m2TRgRUK9uC2bNvXi4bTc2TdqKQU8fFsq61rHVkuxvxDfYzFRoASrGOWF8R0MV
 cyIb/6tPPpYUBW/cBBiXILnfj49DEE3F3BzznNluSKNjVhaL4n0j3aBtgnSqzH+UVtUI
 f7JU72WO9rxYKWACrtnZUJU8qu1bMQNzgnpgKFuJiQjRn2S5Nf5zmr32nyQn/sstoALr
 UpHg==
X-Gm-Message-State: AOJu0YwjZRRWUTXI+RXYXbxYyAM/4pfCAB9/VMubmwkNGeE0m8wRqcZ4
 3mjJqlWo2KuL/Jt4yow0BzuTINPHYpmDKpz2fiLZwMHbI4wnCE0SVhOg3eaYltqTybOiNEt5RtR
 NqzpCQlnedbs1Tw/UI4CWqJs2oJ/OKD63pWYobACosuVfec63IhtRT/jKdCConaJzKPWKlq0an3
 zBHeVA+//FWdi5n683lDC/Rw4ijxrMuuP8Nlw12Dx0GA==
X-Google-Smtp-Source: AGHT+IHk2q9wvR+1VexunP40jKrHmFwcPKyHq3BkRQTRWtL3deMx/PPdU3toXbxlGNuPrvghHNdmcg==
X-Received: by 2002:a05:651c:19aa:b0:2eb:d9ba:96a2 with SMTP id
 38308e7fff4ca-2ebd9ba987cmr19280631fa.17.1717923198858; 
 Sun, 09 Jun 2024 01:53:18 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com.
 [209.85.167.42]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2ebe33549bbsm1728171fa.20.2024.06.09.01.53.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Jun 2024 01:53:18 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id
 2adb3069b0e04-52c85a7f834so408422e87.0; 
 Sun, 09 Jun 2024 01:53:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCWIPd+Ux09I1pL15llLDBCN2GbLCWpKiyMXeEWh7cqF48WTzGI2pGsSZtTSbt1C1I8Ci/VBT+Aw1qLlmG/Js55Iv7Qxu4A=
X-Received: by 2002:a05:6512:6c4:b0:51e:11d5:bca5 with SMTP id
 2adb3069b0e04-52bb9fc45ffmr4926088e87.54.1717923198085; Sun, 09 Jun 2024
 01:53:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240523173955.1940072-1-dbarboza@ventanamicro.com>
 <20240523173955.1940072-6-dbarboza@ventanamicro.com>
In-Reply-To: <20240523173955.1940072-6-dbarboza@ventanamicro.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Sun, 9 Jun 2024 16:53:06 +0800
X-Gmail-Original-Message-ID: <CANzO1D22=2A0Mda3oWqPZLFqXHZkazb3qh1z+N3+z49s82NHnQ@mail.gmail.com>
Message-ID: <CANzO1D22=2A0Mda3oWqPZLFqXHZkazb3qh1z+N3+z49s82NHnQ@mail.gmail.com>
Subject: Re: [PATCH v3 05/13] hw/riscv: add riscv-iommu-pci reference device
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, tjeznach@rivosinc.com, ajones@ventanamicro.com, 
 frank.chang@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=frank.chang@sifive.com; helo=mail-lj1-x230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Daniel Henrique Barboza <dbarboza@ventanamicro.com> =E6=96=BC 2024=E5=B9=B4=
5=E6=9C=8824=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=881:42=E5=AF=AB=E9=
=81=93=EF=BC=9A
>
> From: Tomasz Jeznach <tjeznach@rivosinc.com>
>
> The RISC-V IOMMU can be modelled as a PCIe device following the
> guidelines of the RISC-V IOMMU spec, chapter 7.1, "Integrating an IOMMU
> as a PCIe device".
>
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  hw/riscv/meson.build       |   2 +-
>  hw/riscv/riscv-iommu-pci.c | 177 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 178 insertions(+), 1 deletion(-)
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
> index 0000000000..7635cc64ff
> --- /dev/null
> +++ b/hw/riscv/riscv-iommu-pci.c
> @@ -0,0 +1,177 @@
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
> +    k->class_id =3D 0x0806;

Replace 0x0806 with PCI_CLASS_SYSTEM_IOMMU.

Otherwise,
Reviewed-by: Frank Chang <frank.chang@sifive.com>

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
> 2.44.0
>
>

