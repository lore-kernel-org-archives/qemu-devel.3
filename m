Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62987C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 07:22:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1LKW-00021N-4e; Mon, 29 Apr 2024 03:21:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1s1LKK-0001yy-PP
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 03:21:30 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1s1LKG-0005HH-JT
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 03:21:28 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-51b09c3a111so5890447e87.1
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 00:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1714375282; x=1714980082; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KpGGURb2m7noh8rGD5W4um5LzyOWklfzBNB5ih9FIUA=;
 b=KbZgvgCnJ0ByBdbmMe16Up1o27DmuSTgRnQ7DkoD3hUocbOuqBdeU2WA6WLTqQqHhc
 Hr1ffRUlhB7hH3VDrp0vklu6jW0DhGG0jRE0ArtXkW0nYxkTYhAAkG03lIgIh6etQF0f
 we+nsoUn9LJqbavAndlnb3fx2wDl3cUEr5LotYb7RM/E1oAcFd2AFrBvmUmRm3lG46YE
 Hjrwiq5ImINCPbwUo8vRB4VYj4KSGRBa47gOiSE8BouLkKm/krK1JGooolMpGrjdNpPf
 qJq5ep+Miihn80W3ZIu/7I4LM2QEcVRt5H454gNPzPDyM5DIjzyV5OHBWKwdszn2aR8f
 PoPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714375282; x=1714980082;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KpGGURb2m7noh8rGD5W4um5LzyOWklfzBNB5ih9FIUA=;
 b=KhbZBN6Xc8/wsT//uw3r7FJa984I8lIosN4ltnxHnCGIy9GEGdCmk+EDTI2gfQ67jJ
 5ibuZ9eWwPRkDPanCuq7O5I6FhVVyBFA5momk/rDUDDYif2IvKZCAZ6V5HgZEfnvdyJ8
 1dBqmIeH61kOwJ4IV5G2BWNaHoLqNfObuywJRDyRvfkRBmHG3TnquJ/CJrSte56IHFzU
 AdlqQ4bCeJDrnJvBXVUPv+CY5hcI/ulyCcEf2ak+Le0z6Ls/zHztWK0TfNDWY4j6qD1v
 VbFO6eoWG4qOEMYcJk8xSOhjxkknZ4MCH17eYIfSUWDf+oz0AtApAT1G0W3ap8l518Ok
 xxkA==
X-Gm-Message-State: AOJu0YztUNvAcPGq868IVxpRRCYxxHLiquZPo/ZIfNwVaZEdQMBjVyir
 3DHGBSjeEqm08mXR87lhlWvw2uT6QiBWgl9xzRDN1ijOJG83n2OfsT5ISWJ+D+mYqy6MunARxLR
 5KW85FEumVmqwz2IH3bOmHDdw5PEP+nLmngdWehwe7OycYBYo7r+SIBR7vgWR/t76ddBsY6lzLa
 Gz287MhyDLFNCNLIpvoplWhNGx+MUyGXoBS8RWJymfVQ==
X-Google-Smtp-Source: AGHT+IHqwTrGOS9FDZH1Tkw/kVymDQ7ure4FfQyP+BzW/ImkBwbFpRj2Cf2ol3tjLPLoZiFp3uQPxw==
X-Received: by 2002:ac2:5981:0:b0:51d:ace0:c2a2 with SMTP id
 w1-20020ac25981000000b0051dace0c2a2mr1557928lfn.29.1714375281551; 
 Mon, 29 Apr 2024 00:21:21 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com.
 [209.85.208.175]) by smtp.gmail.com with ESMTPSA id
 g28-20020a0565123b9c00b00518be964835sm4002337lfv.53.2024.04.29.00.21.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 00:21:20 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id
 38308e7fff4ca-2dfb4ea2bbfso19384131fa.2; 
 Mon, 29 Apr 2024 00:21:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCU2KOtf7Y+ueH/60ysJ8kif44ZOcnt+03r/ZL2H9NkCZqZ74SN/RVpI9rnnyPdxfRpGU+d3eksvy1NFt4pf0L01wigDVvM=
X-Received: by 2002:a2e:9b0d:0:b0:2dd:372e:959 with SMTP id
 u13-20020a2e9b0d000000b002dd372e0959mr6314478lji.8.1714375280086; Mon, 29 Apr
 2024 00:21:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240307160319.675044-1-dbarboza@ventanamicro.com>
 <20240307160319.675044-5-dbarboza@ventanamicro.com>
In-Reply-To: <20240307160319.675044-5-dbarboza@ventanamicro.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Mon, 29 Apr 2024 15:21:08 +0800
X-Gmail-Original-Message-ID: <CANzO1D3gOh23xhPhjcrGqSanf=aX_o-V+mBQY7yW6P+0hOR6Nw@mail.gmail.com>
Message-ID: <CANzO1D3gOh23xhPhjcrGqSanf=aX_o-V+mBQY7yW6P+0hOR6Nw@mail.gmail.com>
Subject: Re: [PATCH v2 04/15] hw/riscv: add riscv-iommu-pci device
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com, tjeznach@rivosinc.com
Content-Type: multipart/alternative; boundary="00000000000094df19061737191f"
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=frank.chang@sifive.com; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=unavailable autolearn_force=no
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

--00000000000094df19061737191f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Daniel Henrique Barboza <dbarboza@ventanamicro.com> =E6=96=BC 2024=E5=B9=B4=
3=E6=9C=888=E6=97=A5 =E9=80=B1=E4=BA=94
=E4=B8=8A=E5=8D=8812:04=E5=AF=AB=E9=81=93=EF=BC=9A
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
>  hw/riscv/riscv-iommu-pci.c | 173 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 174 insertions(+), 1 deletion(-)
>  create mode 100644 hw/riscv/riscv-iommu-pci.c
>
> diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
> index ba9eebd605..4674cec6c4 100644
> --- a/hw/riscv/meson.build
> +++ b/hw/riscv/meson.build
> @@ -10,6 +10,6 @@ riscv_ss.add(when: 'CONFIG_SIFIVE_U', if_true:
files('sifive_u.c'))
>  riscv_ss.add(when: 'CONFIG_SPIKE', if_true: files('spike.c'))
>  riscv_ss.add(when: 'CONFIG_MICROCHIP_PFSOC', if_true:
files('microchip_pfsoc.c'))
>  riscv_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
> -riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files('riscv-iommu.c')=
)
> +riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files('riscv-iommu.c',
'riscv-iommu-pci.c'))
>
>  hw_arch +=3D {'riscv': riscv_ss}
> diff --git a/hw/riscv/riscv-iommu-pci.c b/hw/riscv/riscv-iommu-pci.c
> new file mode 100644
> index 0000000000..4eb1057210
> --- /dev/null
> +++ b/hw/riscv/riscv-iommu-pci.c
> @@ -0,0 +1,173 @@
> +/*
> + * QEMU emulation of an RISC-V IOMMU (Ziommu)
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
> + * You should have received a copy of the GNU General Public License
along
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
> +#ifndef PCI_VENDOR_ID_RIVOS
> +#define PCI_VENDOR_ID_RIVOS           0x1efd
> +#endif
> +
> +#ifndef PCI_DEVICE_ID_RIVOS_IOMMU
> +#define PCI_DEVICE_ID_RIVOS_IOMMU     0xedf1
> +#endif
> +
> +/* RISC-V IOMMU PCI Device Emulation */
> +
> +typedef struct RISCVIOMMUStatePci {
> +    PCIDevice        pci;     /* Parent PCIe device state */
> +    MemoryRegion     bar0;    /* PCI BAR (including MSI-x config) */
> +    RISCVIOMMUState  iommu;   /* common IOMMU state */
> +} RISCVIOMMUStatePci;
> +
> +/* interrupt delivery callback */
> +static void riscv_iommu_pci_notify(RISCVIOMMUState *iommu, unsigned
vector)
> +{
> +    RISCVIOMMUStatePci *s =3D container_of(iommu, RISCVIOMMUStatePci,
iommu);
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
> +    Error *err =3D NULL;
> +
> +    /* Set device id for trace / debug */
> +    DEVICE(iommu)->id =3D g_strdup_printf("%02x:%02x.%01x",
> +        pci_dev_bus_num(dev), PCI_SLOT(dev->devfn),
PCI_FUNC(dev->devfn));

pci_dev_bus_num() calls pci_bus_num(),
and pci_bus_num() is assigned to pcibus_num(),
which returns bus->parent_dev->config[PCI_SECONDARY_BUS]
However, PCI bus number is not initialized by SW when IOMMU is initialized.
So pci_bus_num() will always return 0, IIRC.
Same issue as pci_bus_num() above.

> +    qdev_realize(DEVICE(iommu), NULL, errp);
> +
> +    memory_region_init(&s->bar0, OBJECT(s), "riscv-iommu-bar0",
> +        QEMU_ALIGN_UP(memory_region_size(&iommu->regs_mr),
TARGET_PAGE_SIZE));
> +    memory_region_add_subregion(&s->bar0, 0, &iommu->regs_mr);
> +
> +    pcie_endpoint_cap_init(dev, 0);
> +
> +    pci_register_bar(dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY |
> +                     PCI_BASE_ADDRESS_MEM_TYPE_64, &s->bar0);
> +
> +    int ret =3D msix_init(dev, RISCV_IOMMU_INTR_COUNT,
> +                        &s->bar0, 0, RISCV_IOMMU_REG_MSI_CONFIG,
> +                        &s->bar0, 0, RISCV_IOMMU_REG_MSI_CONFIG + 256,
0, &err);
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

Same issue to pci_dev_bus_num() above.

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
> +    DEFINE_PROP_END_OF_LIST(),
> +};

Do we need to assign the empty properties?

> +
> +static void riscv_iommu_pci_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
> +
> +    k->realize =3D riscv_iommu_pci_realize;
> +    k->exit =3D riscv_iommu_pci_exit;
> +    k->vendor_id =3D PCI_VENDOR_ID_RIVOS;
> +    k->device_id =3D PCI_DEVICE_ID_RIVOS_IOMMU;

I know RIVOS originally modeled this IOMMU,
but we (SiFive) also have our IOMMU based on RISC-V IOMMU:
https://open-src-soc.org/2022-05/media/slides/RISC-V-International-Day-2022=
-05-05-14h10-Perinne-Peresse.pdf
Do we have the guidelines on how to extend the vendor IOMMU?

> +    k->revision =3D 0;
> +    k->class_id =3D 0x0806;

We should add
#define PCI_CLASS_SYSTEM_IOMMU 0x0806
instead of the hard-coded value.

P.S. AMD's IOMMU also uses hard-coded value 0x0806 in: hw/i386/amd_iommu.c.

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
> 2.43.2
>
>

--00000000000094df19061737191f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Daniel Henrique Barboza &lt;<a href=3D"mailto:dbarboza@ven=
tanamicro.com">dbarboza@ventanamicro.com</a>&gt; =E6=96=BC 2024=E5=B9=B43=
=E6=9C=888=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=8812:04=E5=AF=AB=E9=
=81=93=EF=BC=9A<br>&gt;<br>&gt; From: Tomasz Jeznach &lt;<a href=3D"mailto:=
tjeznach@rivosinc.com">tjeznach@rivosinc.com</a>&gt;<br>&gt;<br>&gt; The RI=
SC-V IOMMU can be modelled as a PCIe device following the<br>&gt; guideline=
s of the RISC-V IOMMU spec, chapter 7.1, &quot;Integrating an IOMMU<br>&gt;=
 as a PCIe device&quot;.<br>&gt;<br>&gt; Signed-off-by: Tomasz Jeznach &lt;=
<a href=3D"mailto:tjeznach@rivosinc.com">tjeznach@rivosinc.com</a>&gt;<br>&=
gt; Signed-off-by: Daniel Henrique Barboza &lt;<a href=3D"mailto:dbarboza@v=
entanamicro.com">dbarboza@ventanamicro.com</a>&gt;<br>&gt; ---<br>&gt; =C2=
=A0hw/riscv/meson.build =C2=A0 =C2=A0 =C2=A0 | =C2=A0 2 +-<br>&gt; =C2=A0hw=
/riscv/riscv-iommu-pci.c | 173 +++++++++++++++++++++++++++++++++++++<br>&gt=
; =C2=A02 files changed, 174 insertions(+), 1 deletion(-)<br>&gt; =C2=A0cre=
ate mode 100644 hw/riscv/riscv-iommu-pci.c<br>&gt;<br>&gt; diff --git a/hw/=
riscv/meson.build b/hw/riscv/meson.build<br>&gt; index ba9eebd605..4674cec6=
c4 100644<br>&gt; --- a/hw/riscv/meson.build<br>&gt; +++ b/hw/riscv/meson.b=
uild<br>&gt; @@ -10,6 +10,6 @@ riscv_ss.add(when: &#39;CONFIG_SIFIVE_U&#39;=
, if_true: files(&#39;sifive_u.c&#39;))<br>&gt; =C2=A0riscv_ss.add(when: &#=
39;CONFIG_SPIKE&#39;, if_true: files(&#39;spike.c&#39;))<br>&gt; =C2=A0risc=
v_ss.add(when: &#39;CONFIG_MICROCHIP_PFSOC&#39;, if_true: files(&#39;microc=
hip_pfsoc.c&#39;))<br>&gt; =C2=A0riscv_ss.add(when: &#39;CONFIG_ACPI&#39;, =
if_true: files(&#39;virt-acpi-build.c&#39;))<br>&gt; -riscv_ss.add(when: &#=
39;CONFIG_RISCV_IOMMU&#39;, if_true: files(&#39;riscv-iommu.c&#39;))<br>&gt=
; +riscv_ss.add(when: &#39;CONFIG_RISCV_IOMMU&#39;, if_true: files(&#39;ris=
cv-iommu.c&#39;, &#39;riscv-iommu-pci.c&#39;))<br>&gt;<br>&gt; =C2=A0hw_arc=
h +=3D {&#39;riscv&#39;: riscv_ss}<br>&gt; diff --git a/hw/riscv/riscv-iomm=
u-pci.c b/hw/riscv/riscv-iommu-pci.c<br>&gt; new file mode 100644<br>&gt; i=
ndex 0000000000..4eb1057210<br>&gt; --- /dev/null<br>&gt; +++ b/hw/riscv/ri=
scv-iommu-pci.c<br>&gt; @@ -0,0 +1,173 @@<br>&gt; +/*<br>&gt; + * QEMU emul=
ation of an RISC-V IOMMU (Ziommu)<br>&gt; + *<br>&gt; + * Copyright (C) 202=
2-2023 Rivos Inc.<br>&gt; + *<br>&gt; + * This program is free software; yo=
u can redistribute it and/or modify<br>&gt; + * it under the terms of the G=
NU General Public License as published by<br>&gt; + * the Free Software Fou=
ndation; either version 2 of the License.<br>&gt; + *<br>&gt; + * This prog=
ram is distributed in the hope that it will be useful,<br>&gt; + * but WITH=
OUT ANY WARRANTY; without even the implied warranty of<br>&gt; + * MERCHANT=
ABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the<br>&gt; + * GNU =
General Public License for more details.<br>&gt; + *<br>&gt; + * You should=
 have received a copy of the GNU General Public License along<br>&gt; + * w=
ith this program; if not, see &lt;<a href=3D"http://www.gnu.org/licenses/">=
http://www.gnu.org/licenses/</a>&gt;.<br>&gt; + */<br>&gt; +<br>&gt; +#incl=
ude &quot;qemu/osdep.h&quot;<br>&gt; +#include &quot;hw/pci/msi.h&quot;<br>=
&gt; +#include &quot;hw/pci/msix.h&quot;<br>&gt; +#include &quot;hw/pci/pci=
_bus.h&quot;<br>&gt; +#include &quot;hw/qdev-properties.h&quot;<br>&gt; +#i=
nclude &quot;hw/riscv/riscv_hart.h&quot;<br>&gt; +#include &quot;migration/=
vmstate.h&quot;<br>&gt; +#include &quot;qapi/error.h&quot;<br>&gt; +#includ=
e &quot;qemu/error-report.h&quot;<br>&gt; +#include &quot;qemu/host-utils.h=
&quot;<br>&gt; +#include &quot;qom/object.h&quot;<br>&gt; +<br>&gt; +#inclu=
de &quot;cpu_bits.h&quot;<br>&gt; +#include &quot;riscv-iommu.h&quot;<br>&g=
t; +#include &quot;riscv-iommu-bits.h&quot;<br>&gt; +<br>&gt; +#ifndef PCI_=
VENDOR_ID_RIVOS<br>&gt; +#define PCI_VENDOR_ID_RIVOS =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 0x1efd<br>&gt; +#endif<br>&gt; +<br>&gt; +#ifndef PCI_DEVICE_=
ID_RIVOS_IOMMU<br>&gt; +#define PCI_DEVICE_ID_RIVOS_IOMMU =C2=A0 =C2=A0 0xe=
df1<br>&gt; +#endif<br>&gt; +<br>&gt; +/* RISC-V IOMMU PCI Device Emulation=
 */<br>&gt; +<br>&gt; +typedef struct RISCVIOMMUStatePci {<br>&gt; + =C2=A0=
 =C2=A0PCIDevice =C2=A0 =C2=A0 =C2=A0 =C2=A0pci; =C2=A0 =C2=A0 /* Parent PC=
Ie device state */<br>&gt; + =C2=A0 =C2=A0MemoryRegion =C2=A0 =C2=A0 bar0; =
=C2=A0 =C2=A0/* PCI BAR (including MSI-x config) */<br>&gt; + =C2=A0 =C2=A0=
RISCVIOMMUState =C2=A0iommu; =C2=A0 /* common IOMMU state */<br>&gt; +} RIS=
CVIOMMUStatePci;<br>&gt; +<br>&gt; +/* interrupt delivery callback */<br>&g=
t; +static void riscv_iommu_pci_notify(RISCVIOMMUState *iommu, unsigned vec=
tor)<br>&gt; +{<br>&gt; + =C2=A0 =C2=A0RISCVIOMMUStatePci *s =3D container_=
of(iommu, RISCVIOMMUStatePci, iommu);<br>&gt; +<br>&gt; + =C2=A0 =C2=A0if (=
msix_enabled(&amp;(s-&gt;pci))) {<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0msix=
_notify(&amp;(s-&gt;pci), vector);<br>&gt; + =C2=A0 =C2=A0}<br>&gt; +}<br>&=
gt; +<br>&gt; +static void riscv_iommu_pci_realize(PCIDevice *dev, Error **=
errp)<br>&gt; +{<br>&gt; + =C2=A0 =C2=A0RISCVIOMMUStatePci *s =3D DO_UPCAST=
(RISCVIOMMUStatePci, pci, dev);<br>&gt; + =C2=A0 =C2=A0RISCVIOMMUState *iom=
mu =3D &amp;s-&gt;iommu;<br>&gt; + =C2=A0 =C2=A0Error *err =3D NULL;<br>&gt=
; +<br>&gt; + =C2=A0 =C2=A0/* Set device id for trace / debug */<br>&gt; + =
=C2=A0 =C2=A0DEVICE(iommu)-&gt;id =3D g_strdup_printf(&quot;%02x:%02x.%01x&=
quot;,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0pci_dev_bus_num(dev), PCI_SLOT(=
dev-&gt;devfn), PCI_FUNC(dev-&gt;devfn));<br><br>pci_dev_bus_num() calls pc=
i_bus_num(),<br>and pci_bus_num() is assigned to pcibus_num(),<br>which ret=
urns bus-&gt;parent_dev-&gt;config[PCI_SECONDARY_BUS]<br>However, PCI bus n=
umber is not initialized by SW when IOMMU is initialized.<br>So pci_bus_num=
() will always return 0, IIRC.<br>Same issue as pci_bus_num() above.<br><br=
>&gt; + =C2=A0 =C2=A0qdev_realize(DEVICE(iommu), NULL, errp);<br>&gt; +<br>=
&gt; + =C2=A0 =C2=A0memory_region_init(&amp;s-&gt;bar0, OBJECT(s), &quot;ri=
scv-iommu-bar0&quot;,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0QEMU_ALIGN_UP(me=
mory_region_size(&amp;iommu-&gt;regs_mr), TARGET_PAGE_SIZE));<br>&gt; + =C2=
=A0 =C2=A0memory_region_add_subregion(&amp;s-&gt;bar0, 0, &amp;iommu-&gt;re=
gs_mr);<br>&gt; +<br>&gt; + =C2=A0 =C2=A0pcie_endpoint_cap_init(dev, 0);<br=
>&gt; +<br>&gt; + =C2=A0 =C2=A0pci_register_bar(dev, 0, PCI_BASE_ADDRESS_SP=
ACE_MEMORY |<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 PCI_BASE_ADDRESS_MEM_TYPE_64, &amp;s-&gt;bar0);<br>&gt; +=
<br>&gt; + =C2=A0 =C2=A0int ret =3D msix_init(dev, RISCV_IOMMU_INTR_COUNT,<=
br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0&amp;s-&gt;bar0, 0, RISCV_IOMMU_REG_MSI_CONFIG,<br>&gt;=
 + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0&amp;s-&gt;bar0, 0, RISCV_IOMMU_REG_MSI_CONFIG + 256, 0, &amp;=
err);<br>&gt; +<br>&gt; + =C2=A0 =C2=A0if (ret =3D=3D -ENOTSUP) {<br>&gt; +=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 * MSI-=
x is not supported by the platform.<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 *=
 Driver should use timer/polling based notification handlers.<br>&gt; + =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 */<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0warn_repor=
t_err(err);<br>&gt; + =C2=A0 =C2=A0} else if (ret &lt; 0) {<br>&gt; + =C2=
=A0 =C2=A0 =C2=A0 =C2=A0error_propagate(errp, err);<br>&gt; + =C2=A0 =C2=A0=
 =C2=A0 =C2=A0return;<br>&gt; + =C2=A0 =C2=A0} else {<br>&gt; + =C2=A0 =C2=
=A0 =C2=A0 =C2=A0/* mark all allocated MSIx vectors as used. */<br>&gt; + =
=C2=A0 =C2=A0 =C2=A0 =C2=A0msix_vector_use(dev, RISCV_IOMMU_INTR_CQ);<br>&g=
t; + =C2=A0 =C2=A0 =C2=A0 =C2=A0msix_vector_use(dev, RISCV_IOMMU_INTR_FQ);<=
br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0msix_vector_use(dev, RISCV_IOMMU_INTR_=
PM);<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0msix_vector_use(dev, RISCV_IOMMU_=
INTR_PQ);<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0iommu-&gt;notify =3D riscv_i=
ommu_pci_notify;<br>&gt; + =C2=A0 =C2=A0}<br>&gt; +<br>&gt; + =C2=A0 =C2=A0=
PCIBus *bus =3D pci_device_root_bus(dev);<br>&gt; + =C2=A0 =C2=A0if (!bus) =
{<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;can&#39;t fin=
d PCIe root port for %02x:%02x.%x&quot;,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0pci_bus_num(pci_get_bus(dev)), PCI_SLOT(dev-&gt;devfn),<br=
><br>Same issue to pci_dev_bus_num() above.<br><br>&gt; + =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0PCI_FUNC(dev-&gt;devfn));<br>&gt; + =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return;<br>&gt; + =C2=A0 =C2=A0}<br>&gt; +<br>&gt; + =C2=A0 =
=C2=A0riscv_iommu_pci_setup_iommu(iommu, bus, errp);<br>&gt; +}<br>&gt; +<b=
r>&gt; +static void riscv_iommu_pci_exit(PCIDevice *pci_dev)<br>&gt; +{<br>=
&gt; + =C2=A0 =C2=A0pci_setup_iommu(pci_device_root_bus(pci_dev), NULL, NUL=
L);<br>&gt; +}<br>&gt; +<br>&gt; +static const VMStateDescription riscv_iom=
mu_vmstate =3D {<br>&gt; + =C2=A0 =C2=A0.name =3D &quot;riscv-iommu&quot;,<=
br>&gt; + =C2=A0 =C2=A0.unmigratable =3D 1<br>&gt; +};<br>&gt; +<br>&gt; +s=
tatic void riscv_iommu_pci_init(Object *obj)<br>&gt; +{<br>&gt; + =C2=A0 =
=C2=A0RISCVIOMMUStatePci *s =3D RISCV_IOMMU_PCI(obj);<br>&gt; + =C2=A0 =C2=
=A0RISCVIOMMUState *iommu =3D &amp;s-&gt;iommu;<br>&gt; +<br>&gt; + =C2=A0 =
=C2=A0object_initialize_child(obj, &quot;iommu&quot;, iommu, TYPE_RISCV_IOM=
MU);<br>&gt; + =C2=A0 =C2=A0qdev_alias_all_properties(DEVICE(iommu), obj);<=
br>&gt; +}<br>&gt; +<br>&gt; +static Property riscv_iommu_pci_properties[] =
=3D {<br>&gt; + =C2=A0 =C2=A0DEFINE_PROP_END_OF_LIST(),<br>&gt; +};<br><br>=
Do we need to assign the empty properties?<br><br>&gt; +<br>&gt; +static vo=
id riscv_iommu_pci_class_init(ObjectClass *klass, void *data)<br>&gt; +{<br=
>&gt; + =C2=A0 =C2=A0DeviceClass *dc =3D DEVICE_CLASS(klass);<br>&gt; + =C2=
=A0 =C2=A0PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);<br>&gt; +<br>&gt; =
+ =C2=A0 =C2=A0k-&gt;realize =3D riscv_iommu_pci_realize;<br>&gt; + =C2=A0 =
=C2=A0k-&gt;exit =3D riscv_iommu_pci_exit;<br>&gt; + =C2=A0 =C2=A0k-&gt;ven=
dor_id =3D PCI_VENDOR_ID_RIVOS;<br>&gt; + =C2=A0 =C2=A0k-&gt;device_id =3D =
PCI_DEVICE_ID_RIVOS_IOMMU;<br><br>I know RIVOS originally modeled this IOMM=
U,<br>but we (SiFive) also have our IOMMU based on RISC-V IOMMU:<br><a href=
=3D"https://open-src-soc.org/2022-05/media/slides/RISC-V-International-Day-=
2022-05-05-14h10-Perinne-Peresse.pdf">https://open-src-soc.org/2022-05/medi=
a/slides/RISC-V-International-Day-2022-05-05-14h10-Perinne-Peresse.pdf</a><=
br>Do we have the guidelines on how to extend the vendor IOMMU?<br><br>&gt;=
 + =C2=A0 =C2=A0k-&gt;revision =3D 0;<br>&gt; + =C2=A0 =C2=A0k-&gt;class_id=
 =3D 0x0806;<br><br>We should add<br>#define PCI_CLASS_SYSTEM_IOMMU 0x0806<=
br>instead of the hard-coded value.<br><br>P.S. AMD&#39;s IOMMU also uses h=
ard-coded value 0x0806 in: hw/i386/amd_iommu.c.<br><br>&gt; + =C2=A0 =C2=A0=
dc-&gt;desc =3D &quot;RISCV-IOMMU DMA Remapping device&quot;;<br>&gt; + =C2=
=A0 =C2=A0dc-&gt;vmsd =3D &amp;riscv_iommu_vmstate;<br>&gt; + =C2=A0 =C2=A0=
dc-&gt;hotpluggable =3D false;<br>&gt; + =C2=A0 =C2=A0dc-&gt;user_creatable=
 =3D true;<br>&gt; + =C2=A0 =C2=A0set_bit(DEVICE_CATEGORY_MISC, dc-&gt;cate=
gories);<br>&gt; + =C2=A0 =C2=A0device_class_set_props(dc, riscv_iommu_pci_=
properties);<br>&gt; +}<br>&gt; +<br>&gt; +static const TypeInfo riscv_iomm=
u_pci =3D {<br>&gt; + =C2=A0 =C2=A0.name =3D TYPE_RISCV_IOMMU_PCI,<br>&gt; =
+ =C2=A0 =C2=A0.parent =3D TYPE_PCI_DEVICE,<br>&gt; + =C2=A0 =C2=A0.class_i=
nit =3D riscv_iommu_pci_class_init,<br>&gt; + =C2=A0 =C2=A0.instance_init =
=3D riscv_iommu_pci_init,<br>&gt; + =C2=A0 =C2=A0.instance_size =3D sizeof(=
RISCVIOMMUStatePci),<br>&gt; + =C2=A0 =C2=A0.interfaces =3D (InterfaceInfo[=
]) {<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0{ INTERFACE_PCIE_DEVICE },<br>&gt=
; + =C2=A0 =C2=A0 =C2=A0 =C2=A0{ },<br>&gt; + =C2=A0 =C2=A0},<br>&gt; +};<b=
r>&gt; +<br>&gt; +static void riscv_iommu_register_pci_types(void)<br>&gt; =
+{<br>&gt; + =C2=A0 =C2=A0type_register_static(&amp;riscv_iommu_pci);<br>&g=
t; +}<br>&gt; +<br>&gt; +type_init(riscv_iommu_register_pci_types);<br>&gt;=
 --<br>&gt; 2.43.2<br>&gt;<br>&gt;</div>

--00000000000094df19061737191f--

