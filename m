Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 042E9D60D0B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 02:14:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDDkT-0005ui-A1; Mon, 18 Nov 2024 21:13:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tDDkS-0005uW-8v; Mon, 18 Nov 2024 21:13:48 -0500
Received: from mail-vk1-xa2a.google.com ([2607:f8b0:4864:20::a2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tDDkQ-0001XI-Aw; Mon, 18 Nov 2024 21:13:48 -0500
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-50d2d300718so1018494e0c.1; 
 Mon, 18 Nov 2024 18:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731982425; x=1732587225; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jLU2k1QIIkzaxbVotBjkfsUemgQB6ng7cQ0oDZ0pPuk=;
 b=KEJGxRHIAjlpbtQbtVt/MlQhS6YIAvPxShi2pf6Aot1NGvfAZksYas2yc34vV6FTaY
 vodpWzZa9xKA0/UvvSkDewx0JWdqa3dDGqO08wNb2DrS6yqQjw6bAqhmcv5czII+O2g6
 z1lfC+GTJnFxiyNr/uO5rq5ggMl2yNMCysE3Dw6sBmrJRH24zm4GgeUzlcWKjfxBFfga
 CVn2dfmiF2bSH56ROtnbXaWIyfjaX32k5hEThJzE3A+DhbBHWTm6QfQgmfNUCp02PglV
 IqG6GqRrBskiY3xQBlzPGU9ElftEWnKeT/owu6ftP7sBhC3QjcxKEvve44Sl3WkV3xrg
 7qnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731982425; x=1732587225;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jLU2k1QIIkzaxbVotBjkfsUemgQB6ng7cQ0oDZ0pPuk=;
 b=YVk6BvLNIUB7rHTO2zOe9kLM2cf1UJwtTRYr3kUv5jHUOryVg9syNRsmZRSzOhGpQB
 ZrNVx4HtxoB4YOcS2Y1hoOyDCrgzbcCx72X7Ca9iw5WA8FgfazS/XwNhqfoxwhit5Dp8
 Bmvm21Aeu70Hr49NhOuZltlo8CnlTX2k7xSDpz6ymeYoDIAJoIriGD/ZZjahw6VYiQeF
 CVJeRCpIPT9F+yWw+n2H+pbTXVANzFbHSWfY3RhmbkhgxD50WS81SmUsYEMKfjfz8HOW
 u0cWT5zCf7oE16X1iPbw/HLOre6AVmatp1qS8VbbMUIIzpU8oxcXoOQFFBiHE7gbtgl8
 +L2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8vai+t5HeySf86ZlrUzlUMG4rB/fGuPM2GCmeHdLRIv5T6AshuLuqKe3kZFClGdIuqRYEfmTQsZr1@nongnu.org
X-Gm-Message-State: AOJu0YyYotY88Jp0QICxIaq+bNv26MX41JVaVBNGTuhM+0MbekGTW3Wg
 N7niBTeLCFqxfbaARzPPEP1A7uwJezE9j6UqHquI/4tsRHNf3odnl3jZPb7YOCas5lvD58Rm7D2
 11XHcO2Ks7C24tjYciNk4jXCirQ8=
X-Google-Smtp-Source: AGHT+IHcpIO6F1S96pR26L+sClUITpQrrxynkOxYEcERGplRor3+Gt/PRythPoqqo2+paVZAluIMSFvCapCfUu1QMxo=
X-Received: by 2002:a05:6102:dcb:b0:4ad:4f0b:d187 with SMTP id
 ada2fe7eead31-4ad62bfa7dbmr12535542137.12.1731982424842; Mon, 18 Nov 2024
 18:13:44 -0800 (PST)
MIME-Version: 1.0
References: <20241106133407.604587-1-dbarboza@ventanamicro.com>
 <20241106133407.604587-6-dbarboza@ventanamicro.com>
In-Reply-To: <20241106133407.604587-6-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 19 Nov 2024 12:13:18 +1000
Message-ID: <CAKmqyKN+q-UxZJwzE9jhx0jizs8Q79Y9f78xTUi4Ab04=fPXpQ@mail.gmail.com>
Subject: Re: [PATCH for-10.0 5/7] hw/riscv/virt.c,
 riscv-iommu-sys.c: add MSIx support
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2a;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2a.google.com
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

On Wed, Nov 6, 2024 at 11:36=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> MSIx support is added in the RISC-V IOMMU platform device by including
> the required MSIx facilities to alow software to properly setup the MSIx
> subsystem.
>
> We took inspiration of what is being done in the riscv-iommu-pci device,
> mainly msix_init() and msix_notify(), while keeping in mind that
> riscv-iommu-sys isn't a true PCI device and we don't need to copy/paste
> all the contents of these MSIx functions.
>
> Two extra MSI MemoryRegions were added: 'msix-table' and 'msix-pba'.
> They are used to manage r/w of the MSI table and Pending Bit Array (PBA)
> respectively. Both are subregions of the main IOMMU memory region,
> iommu->regs_mr, initialized during riscv_iommu_realize(), and each one
> has their own handlers for MSIx reads and writes.
>
> This is the expected memory map when using this device in the 'virt'
> machine:
>
>     0000000003010000-0000000003010fff (prio 0, i/o): riscv-iommu-regs
>       0000000003010300-000000000301034f (prio 0, i/o): msix-table
>       0000000003010400-0000000003010407 (prio 0, i/o): msix-pba
>
> We're now able to set IGS to RISCV_IOMMU_CAP_IGS_BOTH, and userspace is
> free to decide which interrupt model to use.
>
> Enabling MSIx support for this device in the 'virt' machine requires
> adding 'msi-parent' in the iommu-sys DT.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/riscv-iommu-sys.c | 116 +++++++++++++++++++++++++++++++++++--
>  hw/riscv/trace-events      |   2 +
>  hw/riscv/virt.c            |   6 +-
>  3 files changed, 119 insertions(+), 5 deletions(-)
>
> diff --git a/hw/riscv/riscv-iommu-sys.c b/hw/riscv/riscv-iommu-sys.c
> index 4b82046ce9..a0ef67a20b 100644
> --- a/hw/riscv/riscv-iommu-sys.c
> +++ b/hw/riscv/riscv-iommu-sys.c
> @@ -26,11 +26,15 @@
>  #include "qemu/host-utils.h"
>  #include "qemu/module.h"
>  #include "qom/object.h"
> +#include "exec/exec-all.h"
> +#include "trace.h"
>
>  #include "riscv-iommu.h"
>
>  #define RISCV_IOMMU_SYSDEV_ICVEC_VECTORS 0x3333
>
> +#define RISCV_IOMMU_PCI_MSIX_VECTORS 5
> +
>  /* RISC-V IOMMU System Platform Device Emulation */
>
>  struct RISCVIOMMUStateSys {
> @@ -39,21 +43,123 @@ struct RISCVIOMMUStateSys {
>      uint32_t         base_irq;
>      DeviceState      *irqchip;
>      RISCVIOMMUState  iommu;
> +
> +    /* Wired int support */
>      qemu_irq         irqs[RISCV_IOMMU_INTR_COUNT];
> +
> +    /* Memory Regions for MSIX table and pending bit entries. */
> +    MemoryRegion msix_table_mmio;
> +    MemoryRegion msix_pba_mmio;
> +    uint8_t *msix_table;
> +    uint8_t *msix_pba;
> +};
> +
> +static uint64_t msix_table_mmio_read(void *opaque, hwaddr addr,
> +                                     unsigned size)
> +{
> +    RISCVIOMMUStateSys *s =3D opaque;
> +
> +    g_assert(addr + size <=3D RISCV_IOMMU_PCI_MSIX_VECTORS * PCI_MSIX_EN=
TRY_SIZE);
> +    return pci_get_long(s->msix_table + addr);
> +}
> +
> +static void msix_table_mmio_write(void *opaque, hwaddr addr,
> +                                  uint64_t val, unsigned size)
> +{
> +    RISCVIOMMUStateSys *s =3D opaque;
> +
> +    g_assert(addr + size <=3D RISCV_IOMMU_PCI_MSIX_VECTORS * PCI_MSIX_EN=
TRY_SIZE);
> +    pci_set_long(s->msix_table + addr, val);
> +}
> +
> +static const MemoryRegionOps msix_table_mmio_ops =3D {
> +    .read =3D msix_table_mmio_read,
> +    .write =3D msix_table_mmio_write,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> +    .valid =3D {
> +        .min_access_size =3D 4,
> +        .max_access_size =3D 8,
> +    },
> +    .impl =3D {
> +        .max_access_size =3D 4,
> +    },
> +};
> +
> +static uint64_t msix_pba_mmio_read(void *opaque, hwaddr addr,
> +                                   unsigned size)
> +{
> +    RISCVIOMMUStateSys *s =3D opaque;
> +
> +    return pci_get_long(s->msix_pba + addr);
> +}
> +
> +static void msix_pba_mmio_write(void *opaque, hwaddr addr,
> +                                uint64_t val, unsigned size)
> +{
> +}
> +
> +static const MemoryRegionOps msix_pba_mmio_ops =3D {
> +    .read =3D msix_pba_mmio_read,
> +    .write =3D msix_pba_mmio_write,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> +    .valid =3D {
> +        .min_access_size =3D 4,
> +        .max_access_size =3D 8,
> +    },
> +    .impl =3D {
> +        .max_access_size =3D 4,
> +    },
>  };
>
> +static void riscv_iommu_sysdev_init_msi(RISCVIOMMUStateSys *s,
> +                                        uint32_t n_vectors)
> +{
> +    RISCVIOMMUState *iommu =3D &s->iommu;
> +    uint32_t table_size =3D table_size =3D n_vectors * PCI_MSIX_ENTRY_SI=
ZE;
> +    uint32_t table_offset =3D RISCV_IOMMU_REG_MSI_CONFIG;
> +    uint32_t pba_size =3D QEMU_ALIGN_UP(n_vectors, 64) / 8;
> +    uint32_t pba_offset =3D RISCV_IOMMU_REG_MSI_CONFIG + 256;
> +
> +    s->msix_table =3D g_malloc0(table_size);
> +    s->msix_pba =3D g_malloc0(pba_size);
> +
> +    memory_region_init_io(&s->msix_table_mmio, OBJECT(s), &msix_table_mm=
io_ops,
> +                          s, "msix-table", table_size);
> +    memory_region_add_subregion(&iommu->regs_mr, table_offset,
> +                                &s->msix_table_mmio);
> +
> +    memory_region_init_io(&s->msix_pba_mmio, OBJECT(s), &msix_pba_mmio_o=
ps, s,
> +                          "msix-pba", pba_size);
> +    memory_region_add_subregion(&iommu->regs_mr, pba_offset,
> +                                &s->msix_pba_mmio);
> +}
> +
> +static void riscv_iommu_sysdev_send_MSI(RISCVIOMMUStateSys *s,
> +                                        uint32_t vector)
> +{
> +    uint8_t *table_entry =3D s->msix_table + vector * PCI_MSIX_ENTRY_SIZ=
E;
> +    uint64_t msi_addr =3D pci_get_quad(table_entry + PCI_MSIX_ENTRY_LOWE=
R_ADDR);
> +    uint32_t msi_data =3D pci_get_long(table_entry + PCI_MSIX_ENTRY_DATA=
);
> +    MemTxResult result;
> +
> +    address_space_stl_le(&address_space_memory, msi_addr,
> +                         msi_data, MEMTXATTRS_UNSPECIFIED, &result);
> +    trace_riscv_iommu_sys_msi_sent(vector, msi_addr, msi_data, result);
> +}
> +
>  static void riscv_iommu_sysdev_notify(RISCVIOMMUState *iommu,
>                                        unsigned vector)
>  {
>      RISCVIOMMUStateSys *s =3D container_of(iommu, RISCVIOMMUStateSys, io=
mmu);
>      uint32_t fctl =3D  riscv_iommu_reg_get32(iommu, RISCV_IOMMU_REG_FCTL=
);
>
> -    /* We do not support MSIs yet */
> -    if (!(fctl & RISCV_IOMMU_FCTL_WSI)) {
> +    if (fctl & RISCV_IOMMU_FCTL_WSI) {
> +        qemu_irq_pulse(s->irqs[vector]);
> +        trace_riscv_iommu_sys_irq_sent(vector);
>          return;
>      }
>
> -    qemu_irq_pulse(s->irqs[vector]);
> +    riscv_iommu_sysdev_send_MSI(s, vector);
>  }
>
>  static void riscv_iommu_sys_realize(DeviceState *dev, Error **errp)
> @@ -82,6 +188,8 @@ static void riscv_iommu_sys_realize(DeviceState *dev, =
Error **errp)
>          irq =3D qdev_get_gpio_in(s->irqchip, s->base_irq + i);
>          sysbus_connect_irq(sysdev, i, irq);
>      }
> +
> +    riscv_iommu_sysdev_init_msi(s, RISCV_IOMMU_PCI_MSIX_VECTORS);
>  }
>
>  static void riscv_iommu_sys_init(Object *obj)
> @@ -93,7 +201,7 @@ static void riscv_iommu_sys_init(Object *obj)
>      qdev_alias_all_properties(DEVICE(iommu), obj);
>
>      iommu->icvec_avail_vectors =3D RISCV_IOMMU_SYSDEV_ICVEC_VECTORS;
> -    riscv_iommu_set_cap_igs(iommu, RISCV_IOMMU_CAP_IGS_WSI);
> +    riscv_iommu_set_cap_igs(iommu, RISCV_IOMMU_CAP_IGS_BOTH);
>  }
>
>  static Property riscv_iommu_sys_properties[] =3D {
> diff --git a/hw/riscv/trace-events b/hw/riscv/trace-events
> index 0527c56c91..94facbb8b1 100644
> --- a/hw/riscv/trace-events
> +++ b/hw/riscv/trace-events
> @@ -15,3 +15,5 @@ riscv_iommu_icvec_write(uint32_t orig, uint32_t actual)=
 "ICVEC write: incoming 0
>  riscv_iommu_ats(const char *id, unsigned b, unsigned d, unsigned f, uint=
64_t iova) "%s: translate request %04x:%02x.%u iova: 0x%"PRIx64
>  riscv_iommu_ats_inval(const char *id) "%s: dev-iotlb invalidate"
>  riscv_iommu_ats_prgr(const char *id) "%s: dev-iotlb page request group r=
esponse"
> +riscv_iommu_sys_irq_sent(uint32_t vector) "IRQ sent to vector %u"
> +riscv_iommu_sys_msi_sent(uint32_t vector, uint64_t msi_addr, uint32_t ms=
i_data, uint32_t result) "MSI sent to vector %u msi_addr 0x%lx msi_data 0x%=
x result %u"
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 23d1380b86..281fc65cc6 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -1043,6 +1043,7 @@ static void create_fdt_virtio_iommu(RISCVVirtState =
*s, uint16_t bdf)
>  }
>
>  static void create_fdt_iommu_sys(RISCVVirtState *s, uint32_t irq_chip,
> +                                 uint32_t msi_phandle,
>                                   uint32_t *iommu_sys_phandle)
>  {
>      const char comp[] =3D "riscv,iommu";
> @@ -1077,6 +1078,8 @@ static void create_fdt_iommu_sys(RISCVVirtState *s,=
 uint32_t irq_chip,
>          iommu_irq_map[2], FDT_IRQ_TYPE_EDGE_LOW,
>          iommu_irq_map[3], FDT_IRQ_TYPE_EDGE_LOW);
>
> +    qemu_fdt_setprop_cell(fdt, iommu_node, "msi-parent", msi_phandle);
> +
>      *iommu_sys_phandle =3D iommu_phandle;
>  }
>
> @@ -1117,7 +1120,8 @@ static void finalize_fdt(RISCVVirtState *s)
>      create_fdt_virtio(s, virt_memmap, irq_virtio_phandle);
>
>      if (virt_is_iommu_sys_enabled(s)) {
> -        create_fdt_iommu_sys(s, irq_mmio_phandle, &iommu_sys_phandle);
> +        create_fdt_iommu_sys(s, irq_mmio_phandle, msi_pcie_phandle,
> +                             &iommu_sys_phandle);
>      }
>      create_fdt_pcie(s, virt_memmap, irq_pcie_phandle, msi_pcie_phandle,
>                      iommu_sys_phandle);
> --
> 2.45.2
>
>

