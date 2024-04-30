Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BCC8C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 01:36:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1cOz-0005M7-1q; Mon, 29 Apr 2024 21:35:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1s1cOv-0005Li-Sr
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 21:35:21 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1s1cOt-0002ZA-TU
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 21:35:21 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2e01d666c88so21639891fa.2
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 18:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1714440917; x=1715045717; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JK6AfpJ2aW8PjDzkKlJGD7mCKDCqNFkZFV/kQYcm4yw=;
 b=dUzTNXWe5/uL/dTO0Q9vAa7RT7NlG/JkHun6gyM5FosF4xWvaEMGNYjuHTRVhitFed
 sVyBgoXaxZZ78Nvn8xvr2dL+m3Xj/mab+nwCSKkyetlZoo+ULAS5NjkhP9u0CbBEecWT
 gcvULIRFdh3cm1S16jRrwFQ/onPcfcoGNbU3prqzZzqFTi8ZuyATjdjJSK9kleLQxkao
 caSRr2t3t+wP7szDmmR5IQ4jIOm7Ul/Ut+Mxz9Uzc/TNM+chBJPZP5nbUFRgToHDyFJD
 nDRqKCYni+HcgxXtzV0e1Vrcu7N2CIw92PRNxyoGrjmxhUS+iX7AKRgN6cSTz49vXcPS
 3ccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714440917; x=1715045717;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JK6AfpJ2aW8PjDzkKlJGD7mCKDCqNFkZFV/kQYcm4yw=;
 b=uFrDDnWN+Psen94bNU6zImT+9yTodz0wu/+9BWLML/XIhHJXXM4anffYTS/zOOQJZA
 mT/SCPLilJ8L4eDonbHGUxeLhoyae8xMv0W9WEIAHSuHTnrBVUhbJNgwEjwkiLuYqinH
 l6DeR/BDZJQQ2nTNUGFC86u4so7KCHeJX/sUdnCvSgTz7JJC1HgAlRVvI12LR9SWx7KO
 NN7CgNsHRBBYMytRgoAOW5roaPQ6wM5hYiD9LhW0OGG7WA8gDdh5+hYueFKa52u7X00d
 CFtxAGhhDMl8qe/buxoYHYZDT8siTGdpfzTOhCkIdqJHiKzioFpClv5AsQDNn6JuYmSs
 ypZg==
X-Gm-Message-State: AOJu0Yyv4vgpT2cCoPd8eoBIUwFSpGC8QnlyrUkcvcUulswelulyxWnn
 3/kTJzJWxBIaWOnQ57kb8Ze6ZDPptx3QwAp/qmh/70SL0Sv8ntPmq+xS5d8awVEfU4l/hURtnBf
 0YH0LIsVwY2h64MBo066pBLwbMSxLAcFXKcAKeVRR9wVgpS4aLnLYBIBv6Fjeap5DIiCwUhqMTF
 hRHPa7tVyl6RuN6BWcY7nWDBcRaSlj6xhhX1weoqdNXQ==
X-Google-Smtp-Source: AGHT+IGK0gaKdi5G8gLJqXIoyFev/24M/5mj93qW/ejsy78UHLv8g21Upb2imX+BXZXe1h6mgadvSg==
X-Received: by 2002:a2e:a0c9:0:b0:2dd:ceb9:8ef5 with SMTP id
 f9-20020a2ea0c9000000b002ddceb98ef5mr836283ljm.12.1714440916020; 
 Mon, 29 Apr 2024 18:35:16 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com.
 [209.85.208.182]) by smtp.gmail.com with ESMTPSA id
 z21-20020a2e8415000000b002db98d0f2c8sm3683228ljg.85.2024.04.29.18.35.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 18:35:15 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id
 38308e7fff4ca-2d858501412so65973831fa.0; 
 Mon, 29 Apr 2024 18:35:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCWRdpKZ/1dv2FJktRgNHCMcSYq65YSwLduVVNhPAKJF63uDiarI8NAuaFUQ3yw9+ngRkCJCVBT/75pN56+FCN6MhsvDNc8=
X-Received: by 2002:a2e:a363:0:b0:2e0:c6ec:bcf8 with SMTP id
 i3-20020a2ea363000000b002e0c6ecbcf8mr775279ljn.41.1714440915302; Mon, 29 Apr
 2024 18:35:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240307160319.675044-1-dbarboza@ventanamicro.com>
 <20240307160319.675044-6-dbarboza@ventanamicro.com>
In-Reply-To: <20240307160319.675044-6-dbarboza@ventanamicro.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Tue, 30 Apr 2024 09:35:03 +0800
X-Gmail-Original-Message-ID: <CANzO1D1-JgOR-A7+TWAFcU5xMn3Lw8jiMtEriS65ziVnk8ni=Q@mail.gmail.com>
Message-ID: <CANzO1D1-JgOR-A7+TWAFcU5xMn3Lw8jiMtEriS65ziVnk8ni=Q@mail.gmail.com>
Subject: Re: [PATCH v2 05/15] hw/riscv: add riscv-iommu-sys platform device
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com, tjeznach@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=frank.chang@sifive.com; helo=mail-lj1-x233.google.com
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

Reviewed-by: Frank Chang <frank.chang@sifive.com>

Daniel Henrique Barboza <dbarboza@ventanamicro.com> =E6=96=BC 2024=E5=B9=B4=
3=E6=9C=888=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=8812:05=E5=AF=AB=E9=
=81=93=EF=BC=9A
>
> From: Tomasz Jeznach <tjeznach@rivosinc.com>
>
> This device models the RISC-V IOMMU as a sysbus device.
>
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  hw/riscv/meson.build       |  2 +-
>  hw/riscv/riscv-iommu-sys.c | 93 ++++++++++++++++++++++++++++++++++++++
>  include/hw/riscv/iommu.h   |  4 ++
>  3 files changed, 98 insertions(+), 1 deletion(-)
>  create mode 100644 hw/riscv/riscv-iommu-sys.c
>
> diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
> index 4674cec6c4..e37c5d78e2 100644
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
> index 0000000000..4305cf8d79
> --- /dev/null
> +++ b/hw/riscv/riscv-iommu-sys.c
> @@ -0,0 +1,93 @@
> +/*
> + * QEMU emulation of an RISC-V IOMMU (Ziommu) - Platform Device
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
> +#include "hw/pci/pci_bus.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/sysbus.h"
> +#include "qapi/error.h"
> +#include "qapi/error.h"
> +#include "qemu/error-report.h"
> +#include "qemu/host-utils.h"
> +#include "qemu/module.h"
> +#include "qemu/osdep.h"
> +#include "qom/object.h"
> +
> +#include "riscv-iommu.h"
> +
> +/* RISC-V IOMMU System Platform Device Emulation */
> +
> +struct RISCVIOMMUStateSys {
> +    SysBusDevice     parent;
> +    uint64_t         addr;
> +    RISCVIOMMUState  iommu;
> +};
> +
> +static void riscv_iommu_sys_realize(DeviceState *dev, Error **errp)
> +{
> +    RISCVIOMMUStateSys *s =3D RISCV_IOMMU_SYS(dev);
> +    PCIBus *pci_bus;
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
> +}
> +
> +static void riscv_iommu_sys_init(Object *obj)
> +{
> +    RISCVIOMMUStateSys *s =3D RISCV_IOMMU_SYS(obj);
> +    RISCVIOMMUState *iommu =3D &s->iommu;
> +
> +    object_initialize_child(obj, "iommu", iommu, TYPE_RISCV_IOMMU);
> +    qdev_alias_all_properties(DEVICE(iommu), obj);
> +}
> +
> +static Property riscv_iommu_sys_properties[] =3D {
> +    DEFINE_PROP_UINT64("addr", RISCVIOMMUStateSys, addr, 0),
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
> diff --git a/include/hw/riscv/iommu.h b/include/hw/riscv/iommu.h
> index 403b365893..c8d28a79a1 100644
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
> 2.43.2
>
>

