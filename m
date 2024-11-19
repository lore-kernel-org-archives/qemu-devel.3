Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36577D60D06
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 01:28:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDD2L-0007yZ-3i; Mon, 18 Nov 2024 20:28:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tDD2H-0007yN-Ds; Mon, 18 Nov 2024 20:28:09 -0500
Received: from mail-ua1-x92e.google.com ([2607:f8b0:4864:20::92e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tDD2F-0004WN-Ax; Mon, 18 Nov 2024 20:28:09 -0500
Received: by mail-ua1-x92e.google.com with SMTP id
 a1e0cc1a2514c-8570543feaaso161772241.2; 
 Mon, 18 Nov 2024 17:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731979686; x=1732584486; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a9XRrNHNXfYGtVckSJDJdP4A7I5jUIJXKyWIci6BPU8=;
 b=afcGh8guqHipDavjiWN3FIWEYmnWFeiDNX46MDOdQIrz4iG5dlYtAQAjWNvTAZCJtH
 e07hTnZBgt4K4hwmegooSg/ykfncMCIkt04W84gw90IVBp19xykYe/px1vmIyXqFSam1
 MvmyGDDvG0R02MkrPpuOcuFL/U9QjWi62M+1uJemQ9UwZoLpargg+KhGy8HbyfFcTxl5
 No3YuDiZp9x7oh1mF/cdTWBA/+DolAwyHIjLaf849bvm0nGqxhAr9i/+3m40/P/o+s4i
 ZWO9kO0QALykh0rv5czh4OQk1/Dj77IVKHmMv7h2dYkZLw7V2cwCz3NueCMugb6SNYsL
 4RLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731979686; x=1732584486;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a9XRrNHNXfYGtVckSJDJdP4A7I5jUIJXKyWIci6BPU8=;
 b=Xh4M1qyzpk2XrUgf9Mh4A5qZEfx22OCX1RQSFUsJB5VPU1CAT7Zlo+xYiEIVcY602G
 Jc9vEA9HxZ0D8ubgic4yPqK79IXu8w3FuDZHGuFmlOl/L//uq/Tk8qNRN7tvlJmZj11P
 qNrxyjAiWZn0dhE9WoKwgXC81Tjl0FXpK9y3mxWWSD7lv1pon5EURsQxGC9lx5DijDiL
 jHP9PL/xNsWCR7duth2BUTRGAY3cf6xLoRoGteL1u6IRRvqMTro0bJX+60j0GAOLJDRA
 mdnGIq/p+7RBYWntwrQnCmhXMu3uc8kRWIRygWN6AG3sDX6tvrNmbTo7TBmkVhj/+mRt
 ov3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7KnFG9Vq9Y6dwPV82UEJtxiTG6iL14Zv7zDoRbK3nWev7p2HjL4OlXVEwHbnCThAYVKn8LqwlMo73@nongnu.org
X-Gm-Message-State: AOJu0YzvxPG6H8UY9E0SPM/UmT1kpVmrOKsO0eKNheubplHa+LUR0IEI
 6DQObBmEWvU+wya7YEgATKn+fXjpLobz+hdAXamAw60r/5xE6oY7QUYqX5OZ70/yKLXYprCDaBd
 CtWKGseE01QF8PPF3Bgl8XTebI1E=
X-Google-Smtp-Source: AGHT+IHWIFEgHWoNRfhq8vLFqjsxKJ/DjIm3P3IC1Cjs4rpp4Vc/jX2LQe+Uv5RcMo484H2DeN1/Bxgx7AtTCSmz3c8=
X-Received: by 2002:a05:6102:3ec6:b0:4a9:5dbd:6ff with SMTP id
 ada2fe7eead31-4ad631d15b5mr12908725137.27.1731979685706; Mon, 18 Nov 2024
 17:28:05 -0800 (PST)
MIME-Version: 1.0
References: <20241106133407.604587-1-dbarboza@ventanamicro.com>
 <20241106133407.604587-4-dbarboza@ventanamicro.com>
In-Reply-To: <20241106133407.604587-4-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 19 Nov 2024 11:27:39 +1000
Message-ID: <CAKmqyKN4avyt2+SJw+b9k+7b+65TYtqsLRaCiN5=F1vGxLW=7Q@mail.gmail.com>
Subject: Re: [PATCH for-10.0 3/7] hw/riscv: add riscv-iommu-sys platform device
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, Tomasz Jeznach <tjeznach@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92e;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92e.google.com
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

On Wed, Nov 6, 2024 at 11:39=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> From: Tomasz Jeznach <tjeznach@rivosinc.com>
>
> This device models the RISC-V IOMMU as a sysbus device. The same design
> decisions taken in the riscv-iommu-pci device were kept, namely the
> existence of 4 vectors are available for each interrupt cause.
>
> The WSIs are emitted using the input of the s->notify() callback as a
> index to an IRQ list. The IRQ list starts at 'base_irq' and goes until
> base_irq + 3. This means that boards must have 4 contiguous IRQ lines
> available, starting from 'base_irq'.
>
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/meson.build       |   2 +-
>  hw/riscv/riscv-iommu-sys.c | 128 +++++++++++++++++++++++++++++++++++++
>  hw/riscv/riscv-iommu.c     |   3 +-
>  include/hw/riscv/iommu.h   |   4 ++
>  4 files changed, 134 insertions(+), 3 deletions(-)
>  create mode 100644 hw/riscv/riscv-iommu-sys.c
>
> diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
> index adbef8a9b2..3be13d7774 100644
> --- a/hw/riscv/meson.build
> +++ b/hw/riscv/meson.build
> @@ -10,6 +10,6 @@ riscv_ss.add(when: 'CONFIG_SIFIVE_U', if_true: files('s=
ifive_u.c'))
>  riscv_ss.add(when: 'CONFIG_SPIKE', if_true: files('spike.c'))
>  riscv_ss.add(when: 'CONFIG_MICROCHIP_PFSOC', if_true: files('microchip_p=
fsoc.c'))
>  riscv_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
> -riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files('riscv-iommu.c',=
 'riscv-iommu-pci.c'))
> +riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files('riscv-iommu.c',=
 'riscv-iommu-pci.c', 'riscv-iommu-sys.c'))
>
>  hw_arch +=3D {'riscv': riscv_ss}
> diff --git a/hw/riscv/riscv-iommu-sys.c b/hw/riscv/riscv-iommu-sys.c
> new file mode 100644
> index 0000000000..4b82046ce9
> --- /dev/null
> +++ b/hw/riscv/riscv-iommu-sys.c
> @@ -0,0 +1,128 @@
> +/*
> + * QEMU emulation of an RISC-V IOMMU Platform Device
> + *
> + * Copyright (C) 2022-2023 Rivos Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
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
> +#include "hw/irq.h"
> +#include "hw/pci/pci_bus.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/sysbus.h"
> +#include "qapi/error.h"
> +#include "qemu/error-report.h"
> +#include "qemu/host-utils.h"
> +#include "qemu/module.h"
> +#include "qom/object.h"
> +
> +#include "riscv-iommu.h"
> +
> +#define RISCV_IOMMU_SYSDEV_ICVEC_VECTORS 0x3333
> +
> +/* RISC-V IOMMU System Platform Device Emulation */
> +
> +struct RISCVIOMMUStateSys {
> +    SysBusDevice     parent;
> +    uint64_t         addr;
> +    uint32_t         base_irq;
> +    DeviceState      *irqchip;
> +    RISCVIOMMUState  iommu;
> +    qemu_irq         irqs[RISCV_IOMMU_INTR_COUNT];
> +};
> +
> +static void riscv_iommu_sysdev_notify(RISCVIOMMUState *iommu,
> +                                      unsigned vector)
> +{
> +    RISCVIOMMUStateSys *s =3D container_of(iommu, RISCVIOMMUStateSys, io=
mmu);
> +    uint32_t fctl =3D  riscv_iommu_reg_get32(iommu, RISCV_IOMMU_REG_FCTL=
);
> +
> +    /* We do not support MSIs yet */
> +    if (!(fctl & RISCV_IOMMU_FCTL_WSI)) {
> +        return;
> +    }
> +
> +    qemu_irq_pulse(s->irqs[vector]);
> +}
> +
> +static void riscv_iommu_sys_realize(DeviceState *dev, Error **errp)
> +{
> +    RISCVIOMMUStateSys *s =3D RISCV_IOMMU_SYS(dev);
> +    SysBusDevice *sysdev =3D SYS_BUS_DEVICE(s);
> +    PCIBus *pci_bus;
> +    qemu_irq irq;
> +
> +    qdev_realize(DEVICE(&s->iommu), NULL, errp);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iommu.regs_mr);
> +    if (s->addr) {
> +        sysbus_mmio_map(SYS_BUS_DEVICE(s), 0, s->addr);
> +    }
> +
> +    pci_bus =3D (PCIBus *) object_resolve_path_type("", TYPE_PCI_BUS, NU=
LL);
> +    if (pci_bus) {
> +        riscv_iommu_pci_setup_iommu(&s->iommu, pci_bus, errp);
> +    }
> +
> +    s->iommu.notify =3D riscv_iommu_sysdev_notify;
> +
> +    /* 4 IRQs are defined starting from s->base_irq */
> +    for (int i =3D 0; i < RISCV_IOMMU_INTR_COUNT; i++) {
> +        sysbus_init_irq(sysdev, &s->irqs[i]);
> +        irq =3D qdev_get_gpio_in(s->irqchip, s->base_irq + i);
> +        sysbus_connect_irq(sysdev, i, irq);
> +    }
> +}
> +
> +static void riscv_iommu_sys_init(Object *obj)
> +{
> +    RISCVIOMMUStateSys *s =3D RISCV_IOMMU_SYS(obj);
> +    RISCVIOMMUState *iommu =3D &s->iommu;
> +
> +    object_initialize_child(obj, "iommu", iommu, TYPE_RISCV_IOMMU);
> +    qdev_alias_all_properties(DEVICE(iommu), obj);
> +
> +    iommu->icvec_avail_vectors =3D RISCV_IOMMU_SYSDEV_ICVEC_VECTORS;
> +    riscv_iommu_set_cap_igs(iommu, RISCV_IOMMU_CAP_IGS_WSI);
> +}
> +
> +static Property riscv_iommu_sys_properties[] =3D {
> +    DEFINE_PROP_UINT64("addr", RISCVIOMMUStateSys, addr, 0),
> +    DEFINE_PROP_UINT32("base-irq", RISCVIOMMUStateSys, base_irq, 0),
> +    DEFINE_PROP_LINK("irqchip", RISCVIOMMUStateSys, irqchip,
> +                     TYPE_DEVICE, DeviceState *),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void riscv_iommu_sys_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    dc->realize =3D riscv_iommu_sys_realize;
> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> +    device_class_set_props(dc, riscv_iommu_sys_properties);
> +}
> +
> +static const TypeInfo riscv_iommu_sys =3D {
> +    .name          =3D TYPE_RISCV_IOMMU_SYS,
> +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> +    .class_init    =3D riscv_iommu_sys_class_init,
> +    .instance_init =3D riscv_iommu_sys_init,
> +    .instance_size =3D sizeof(RISCVIOMMUStateSys),
> +};
> +
> +static void riscv_iommu_register_sys(void)
> +{
> +    type_register_static(&riscv_iommu_sys);
> +}
> +
> +type_init(riscv_iommu_register_sys)
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index d95b4b95d8..239f83f5bd 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -94,10 +94,9 @@ static uint8_t riscv_iommu_get_icvec_vector(uint32_t i=
cvec, uint32_t vec_type)
>
>  static void riscv_iommu_notify(RISCVIOMMUState *s, int vec_type)
>  {
> -    const uint32_t fctl =3D riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_FCT=
L);
>      uint32_t ipsr, icvec, vector;
>
> -    if (fctl & RISCV_IOMMU_FCTL_WSI || !s->notify) {
> +    if (!s->notify) {
>          return;
>      }
>
> diff --git a/include/hw/riscv/iommu.h b/include/hw/riscv/iommu.h
> index 80769a1400..fc20808553 100644
> --- a/include/hw/riscv/iommu.h
> +++ b/include/hw/riscv/iommu.h
> @@ -33,4 +33,8 @@ typedef struct RISCVIOMMUSpace RISCVIOMMUSpace;
>  OBJECT_DECLARE_SIMPLE_TYPE(RISCVIOMMUStatePci, RISCV_IOMMU_PCI)
>  typedef struct RISCVIOMMUStatePci RISCVIOMMUStatePci;
>
> +#define TYPE_RISCV_IOMMU_SYS "riscv-iommu-device"
> +OBJECT_DECLARE_SIMPLE_TYPE(RISCVIOMMUStateSys, RISCV_IOMMU_SYS)
> +typedef struct RISCVIOMMUStateSys RISCVIOMMUStateSys;
> +
>  #endif
> --
> 2.45.2
>
>

