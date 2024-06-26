Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21CB2C2BBCA
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 01:20:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMHAN-0005Bg-9R; Tue, 25 Jun 2024 21:09:45 -0400
Received: from eggs.gnu.org ([209.51.188.92])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMHA9-00058M-2k
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 21:09:32 -0400
Received: from [2607:f8b0:4864:20::e2f] (helo=mail-vs1-xe2f.google.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMH9R-0005NB-Qa
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 21:09:12 -0400
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-48f415262f5so1139005137.1; 
 Tue, 25 Jun 2024 18:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719364024; x=1719968824; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iGPFeBZZiHgpDl06rI+pEsd2nQmrebTXsgwZfr6aISI=;
 b=QpSjeYHjciotGnEH0xtbRwWyDG3hGzIauL5NLMH2i5sLV6AgaYDv4z2n4mEUX5uV1q
 QnTCgbyfEGRECSIKWxwL3dZwK2rKrdttSDgy7t7ixiFmDeQ4MasIIhQqxSL0qF5onLTG
 fSt4ygsxWDiQXrkHMzgHR+rPpnvYivRx1xE72YSWNBkvXSSM1MYLb305fsW+FYrD5qd3
 4HLdiGT69RqdL+sV5wEsRG400NwdYWrGeIHCmoKACRc0a4nC20zLZ8Kp+0b7XfE8d4xV
 oNIQuK35pdyVMQhixEY3PyNAAzm+QE4fZlu1e8umh+caU2jH8pkVieErYIinCIe49xf8
 JtjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719364024; x=1719968824;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iGPFeBZZiHgpDl06rI+pEsd2nQmrebTXsgwZfr6aISI=;
 b=BKzGUlONL7Y/w6cfsqseNJUzUbYkvhtC7io9zXMwxk4Ikc82JJRYwIAeHjlD7mi9dg
 qPsi9/CPQtONECB3UORLp6kFpWtJHYkCfjhlWylD/8YBR0YekWHy/vyorFTWJZ2wHVPL
 CUkSxAbwt3S1WB/2kadbkZUpOo8NbS7w9RNh4ZnlZoVT9xmioTHzRclVMAeEa5yL9Cja
 pFE7F3tlrXiElCrEolAKNmy5qW+JOnXjK6k3minFXWCTGkYFECVk0YXGVxYIQkYfeCrV
 IIdcFt45ull3POKDQtryJEKw6h2DUKau4z1YE6gSxTeZNYnrKQAf0o5TYtTAff6Q8+gF
 3cvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUVca7BDAQLIHzPJ2USwJgxYpRaT+KiU8wk+toLPzRhxSVT4kvn/V+0kWcxGgxAzJiRFw6heUEcj6e8xeGc3ntZqN2B4o=
X-Gm-Message-State: AOJu0Yze7yz33juIZgOifDhYS120GPPuzo/1eZsKkJtGrue6B9bMAdtP
 KgTrNCrzR2P3gm8XrOjXxBFQyZiYlp4RM2PPJyaqtiPehmZ0xK3YMu6Z4j9ANuF+c59wTlFqKJr
 kLGXE7ElKOB+el4a1QSuqVvuN59c=
X-Google-Smtp-Source: AGHT+IHGEI+1EgxU1Www3XEJbhJFuAW9ZphsG4MIhhh292WnCIetW72Lt0dIqc6mOF52Es6TDhxUCZ1/CeqET6QkgI8=
X-Received: by 2002:a05:6102:34c5:b0:48f:3fe0:34d8 with SMTP id
 ada2fe7eead31-48f4f16db55mr8721616137.24.1719364023786; Tue, 25 Jun 2024
 18:07:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240624201825.1054980-1-dbarboza@ventanamicro.com>
 <20240624201825.1054980-7-dbarboza@ventanamicro.com>
In-Reply-To: <20240624201825.1054980-7-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 26 Jun 2024 11:06:37 +1000
Message-ID: <CAKmqyKM3i2OzvgPq8-gYUB6tcZxO9xLDO_4q0mVTCgPBBuJThg@mail.gmail.com>
Subject: Re: [PATCH v4 06/14] hw/riscv/virt.c: support for RISC-V IOMMU
 PCIDevice hotplug
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com, tjeznach@rivosinc.com, 
 frank.chang@sifive.com, jason.chien@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Host-Lookup-Failed: Reverse DNS lookup failed for 2607:f8b0:4864:20::e2f
 (deferred)
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2f;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2f.google.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 PDS_HP_HELO_NORDNS=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793,
 SPOOFED_FREEMAIL_NO_RDNS=0.001, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On Tue, Jun 25, 2024 at 6:21=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> From: Tomasz Jeznach <tjeznach@rivosinc.com>
>
> Generate device tree entry for riscv-iommu PCI device, along with
> mapping all PCI device identifiers to the single IOMMU device instance.
>
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/virt.c | 33 ++++++++++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 5676d66d12..72ab563007 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -32,6 +32,7 @@
>  #include "hw/core/sysbus-fdt.h"
>  #include "target/riscv/pmu.h"
>  #include "hw/riscv/riscv_hart.h"
> +#include "hw/riscv/iommu.h"
>  #include "hw/riscv/virt.h"
>  #include "hw/riscv/boot.h"
>  #include "hw/riscv/numa.h"
> @@ -1006,6 +1007,30 @@ static void create_fdt_virtio_iommu(RISCVVirtState=
 *s, uint16_t bdf)
>                             bdf + 1, iommu_phandle, bdf + 1, 0xffff - bdf=
);
>  }
>
> +static void create_fdt_iommu(RISCVVirtState *s, uint16_t bdf)
> +{
> +    const char comp[] =3D "riscv,pci-iommu";
> +    void *fdt =3D MACHINE(s)->fdt;
> +    uint32_t iommu_phandle;
> +    g_autofree char *iommu_node =3D NULL;
> +    g_autofree char *pci_node =3D NULL;
> +
> +    pci_node =3D g_strdup_printf("/soc/pci@%lx",
> +                               (long) virt_memmap[VIRT_PCIE_ECAM].base);
> +    iommu_node =3D g_strdup_printf("%s/iommu@%x", pci_node, bdf);
> +    iommu_phandle =3D qemu_fdt_alloc_phandle(fdt);
> +    qemu_fdt_add_subnode(fdt, iommu_node);
> +
> +    qemu_fdt_setprop(fdt, iommu_node, "compatible", comp, sizeof(comp));
> +    qemu_fdt_setprop_cell(fdt, iommu_node, "#iommu-cells", 1);
> +    qemu_fdt_setprop_cell(fdt, iommu_node, "phandle", iommu_phandle);
> +    qemu_fdt_setprop_cells(fdt, iommu_node, "reg",
> +                           bdf << 8, 0, 0, 0, 0);
> +    qemu_fdt_setprop_cells(fdt, pci_node, "iommu-map",
> +                           0, iommu_phandle, 0, bdf,
> +                           bdf + 1, iommu_phandle, bdf + 1, 0xffff - bdf=
);
> +}
> +
>  static void finalize_fdt(RISCVVirtState *s)
>  {
>      uint32_t phandle =3D 1, irq_mmio_phandle =3D 1, msi_pcie_phandle =3D=
 1;
> @@ -1712,9 +1737,11 @@ static HotplugHandler *virt_machine_get_hotplug_ha=
ndler(MachineState *machine,
>      MachineClass *mc =3D MACHINE_GET_CLASS(machine);
>
>      if (device_is_dynamic_sysbus(mc, dev) ||
> -        object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
> +        object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI) ||
> +        object_dynamic_cast(OBJECT(dev), TYPE_RISCV_IOMMU_PCI)) {
>          return HOTPLUG_HANDLER(machine);
>      }
> +
>      return NULL;
>  }
>
> @@ -1735,6 +1762,10 @@ static void virt_machine_device_plug_cb(HotplugHan=
dler *hotplug_dev,
>      if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
>          create_fdt_virtio_iommu(s, pci_get_bdf(PCI_DEVICE(dev)));
>      }
> +
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_RISCV_IOMMU_PCI)) {
> +        create_fdt_iommu(s, pci_get_bdf(PCI_DEVICE(dev)));
> +    }
>  }
>
>  static void virt_machine_class_init(ObjectClass *oc, void *data)
> --
> 2.45.2
>
>

