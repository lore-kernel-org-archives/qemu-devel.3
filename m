Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2553C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 05:55:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKXEU-0004kE-37; Fri, 21 Jun 2024 01:54:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sKXET-0004k2-1o; Fri, 21 Jun 2024 01:54:45 -0400
Received: from mail-vs1-xe32.google.com ([2607:f8b0:4864:20::e32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sKXER-0000Ru-6o; Fri, 21 Jun 2024 01:54:44 -0400
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-48c4f2ff8c2so510239137.0; 
 Thu, 20 Jun 2024 22:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718949281; x=1719554081; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eG0VzWzhFRIIrZGPHESycEZGThZj/rlEvuJmzj1AfFw=;
 b=GshrOzNhpN6cx64En7yV9OPC/YlGBAgkhMs+2LG/9nk4wxTALr6KFjqjV6XqlqcyT+
 UWKnG871VsqMa61ofMD8CVk2sSYBqkHLipersm3eiMFmoWHZWFTFOzKbg5M2qgx4oS8e
 UOCzsnuaRlLhchjTT1sT+xXaVgencNhM8w6lqyIWpm7MivBvzXUgxqyc4QBQ2LG5nqmQ
 7WVqgfwWYHIt7uj3ywLuJLPbftj/oO/5qffoSYbRFzl1k8VptyAVakimiG8f7HSsJi8J
 8PjQ72Almnkhyhh0c/QzoH8aBOcRyzAPD9v+M+fRjfGn476iLLQ5GZewPPQxyd5dt64F
 yycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718949281; x=1719554081;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eG0VzWzhFRIIrZGPHESycEZGThZj/rlEvuJmzj1AfFw=;
 b=iMosrnGgsMpLAzo+0kBELn/zp8j+mh+A5ejCWfZd17pHBdp7QEv9660qRGLg9YgTA5
 sF5+YBCwRCHy70kfJway1wLxNJi46rfYCVhlbpLXW8xYSSWX7UqN+871Giac4zwEhpmn
 ak3kKKo8xroSAvPvT3IGPlCS/lha/F6goMhqrxggCQVKlW0Pv9T+qazQ0I7nYO/vfdmI
 2UiK/BZFyoTJ+/dECtEbsJePFbUP9IIgQ2yKvIlyHyvgBrBV0DtD2QOWAFIC0Nx3X41R
 9k7elbhC8ploagjGa9O47aCmlbT6btoX9rr0DXDokwH2XdGL4Rooj49DvVSz4hx2/H4/
 FKAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWot15tvemgsPp0hvEKhPO8M6uks7be/OWTt5IIsGLlgloX9kBiPV6/EX5OzwHxu1iObmrtbnTwdKikuQPmJauRVPDlTvs=
X-Gm-Message-State: AOJu0YxFb6dZ/Y9Fwanemuu/RIkQSY/F/j719xHjHBZpfZu+gwKVyT81
 QZeZcNge6UUqZFvwEzIlPeu4dxjy8IIvEP0NGetRWfyWYuy0d9L3WVIRgtEWx1oo0S+1MVJ6pKP
 cXn160Sg5Sp89isTlfDQYu9JXmMc=
X-Google-Smtp-Source: AGHT+IH6P7kjZ18QI1Zsh6xoWjC+ZSZnw3j+/mL7MwMMSNt+KjaJzqMaPxQzuRdT40jGdXHNC02rSQMA7ILqUnLCisY=
X-Received: by 2002:a67:ce02:0:b0:48d:9106:362c with SMTP id
 ada2fe7eead31-48f13097574mr8410212137.27.1718949281404; Thu, 20 Jun 2024
 22:54:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240612031706.2927602-1-ethan84@andestech.com>
 <20240612031706.2927602-3-ethan84@andestech.com>
In-Reply-To: <20240612031706.2927602-3-ethan84@andestech.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 21 Jun 2024 15:54:15 +1000
Message-ID: <CAKmqyKM+dSQfGAUcU9w+hHA1SVA-OSLhsfYHh7rV1uutaeppfw@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] hw/riscv/virt: Add IOPMP support
To: Ethan Chen <ethan84@andestech.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e32;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe32.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Wed, Jun 12, 2024 at 1:25=E2=80=AFPM Ethan Chen via <qemu-devel@nongnu.o=
rg> wrote:
>
> If a requestor device is connected to the IOPMP device, its memory access=
 will
> be checked by the IOPMP rule.
>
> - Add 'iopmp=3Don' option to add an iopmp device and make the Generic PCI=
 Express
>   Bridge connect to IOPMP.

I have only had a chance to have a quick look at this series and the spec.

But the IOPMP spec applies to all devices right, but this series seems
to only work with PCI. Am I missing something?

Alistair

>
> Signed-off-by: Ethan Chen <ethan84@andestech.com>
> ---
>  docs/system/riscv/virt.rst |  6 ++++
>  hw/riscv/Kconfig           |  1 +
>  hw/riscv/virt.c            | 57 ++++++++++++++++++++++++++++++++++++--
>  include/hw/riscv/virt.h    |  5 +++-
>  4 files changed, 66 insertions(+), 3 deletions(-)
>
> diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
> index 9a06f95a34..3b2576f905 100644
> --- a/docs/system/riscv/virt.rst
> +++ b/docs/system/riscv/virt.rst
> @@ -116,6 +116,12 @@ The following machine-specific options are supported=
:
>    having AIA IMSIC (i.e. "aia=3Daplic-imsic" selected). When not specifi=
ed,
>    the default number of per-HART VS-level AIA IMSIC pages is 0.
>
> +- iopmp=3D[on|off]
> +
> +  When this option is "on", an IOPMP device is added to machine. It chec=
ks dma
> +  operations from the generic PCIe host bridge. This option is assumed t=
o be
> +  "off".
> +
>  Running Linux kernel
>  --------------------
>
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index a2030e3a6f..0b45a5ade2 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -56,6 +56,7 @@ config RISCV_VIRT
>      select PLATFORM_BUS
>      select ACPI
>      select ACPI_PCI
> +    select RISCV_IOPMP
>
>  config SHAKTI_C
>      bool
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 4fdb660525..53a1b71c71 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -55,6 +55,7 @@
>  #include "hw/acpi/aml-build.h"
>  #include "qapi/qapi-visit-common.h"
>  #include "hw/virtio/virtio-iommu.h"
> +#include "hw/misc/riscv_iopmp.h"
>
>  /* KVM AIA only supports APLIC MSI. APLIC Wired is always emulated by QE=
MU. */
>  static bool virt_use_kvm_aia(RISCVVirtState *s)
> @@ -82,6 +83,7 @@ static const MemMapEntry virt_memmap[] =3D {
>      [VIRT_UART0] =3D        { 0x10000000,         0x100 },
>      [VIRT_VIRTIO] =3D       { 0x10001000,        0x1000 },
>      [VIRT_FW_CFG] =3D       { 0x10100000,          0x18 },
> +    [VIRT_IOPMP] =3D        { 0x10200000,      0x100000 },
>      [VIRT_FLASH] =3D        { 0x20000000,     0x4000000 },
>      [VIRT_IMSIC_M] =3D      { 0x24000000, VIRT_IMSIC_MAX_SIZE },
>      [VIRT_IMSIC_S] =3D      { 0x28000000, VIRT_IMSIC_MAX_SIZE },
> @@ -1006,6 +1008,24 @@ static void create_fdt_virtio_iommu(RISCVVirtState=
 *s, uint16_t bdf)
>                             bdf + 1, iommu_phandle, bdf + 1, 0xffff - bdf=
);
>  }
>
> +static void create_fdt_iopmp(RISCVVirtState *s, const MemMapEntry *memma=
p,
> +                             uint32_t irq_mmio_phandle) {
> +    g_autofree char *name =3D NULL;
> +    MachineState *ms =3D MACHINE(s);
> +
> +    name =3D g_strdup_printf("/soc/iopmp@%lx", (long)memmap[VIRT_IOPMP].=
base);
> +    qemu_fdt_add_subnode(ms->fdt, name);
> +    qemu_fdt_setprop_string(ms->fdt, name, "compatible", "riscv_iopmp");
> +    qemu_fdt_setprop_cells(ms->fdt, name, "reg", 0x0, memmap[VIRT_IOPMP]=
.base,
> +        0x0, memmap[VIRT_IOPMP].size);
> +    qemu_fdt_setprop_cell(ms->fdt, name, "interrupt-parent", irq_mmio_ph=
andle);
> +    if (s->aia_type =3D=3D VIRT_AIA_TYPE_NONE) {
> +        qemu_fdt_setprop_cell(ms->fdt, name, "interrupts", IOPMP_IRQ);
> +    } else {
> +        qemu_fdt_setprop_cells(ms->fdt, name, "interrupts", IOPMP_IRQ, 0=
x4);
> +    }
> +}
> +
>  static void finalize_fdt(RISCVVirtState *s)
>  {
>      uint32_t phandle =3D 1, irq_mmio_phandle =3D 1, msi_pcie_phandle =3D=
 1;
> @@ -1024,6 +1044,10 @@ static void finalize_fdt(RISCVVirtState *s)
>      create_fdt_uart(s, virt_memmap, irq_mmio_phandle);
>
>      create_fdt_rtc(s, virt_memmap, irq_mmio_phandle);
> +
> +    if (s->have_iopmp) {
> +        create_fdt_iopmp(s, virt_memmap, irq_mmio_phandle);
> +    }
>  }
>
>  static void create_fdt(RISCVVirtState *s, const MemMapEntry *memmap)
> @@ -1404,7 +1428,7 @@ static void virt_machine_init(MachineState *machine=
)
>      RISCVVirtState *s =3D RISCV_VIRT_MACHINE(machine);
>      MemoryRegion *system_memory =3D get_system_memory();
>      MemoryRegion *mask_rom =3D g_new(MemoryRegion, 1);
> -    DeviceState *mmio_irqchip, *virtio_irqchip, *pcie_irqchip;
> +    DeviceState *mmio_irqchip, *virtio_irqchip, *pcie_irqchip, *gpex_dev=
;
>      int i, base_hartid, hart_count;
>      int socket_count =3D riscv_socket_count(machine);
>
> @@ -1570,7 +1594,7 @@ static void virt_machine_init(MachineState *machine=
)
>              qdev_get_gpio_in(virtio_irqchip, VIRTIO_IRQ + i));
>      }
>
> -    gpex_pcie_init(system_memory, pcie_irqchip, s);
> +    gpex_dev =3D gpex_pcie_init(system_memory, pcie_irqchip, s);
>
>      create_platform_bus(s, mmio_irqchip);
>
> @@ -1581,6 +1605,14 @@ static void virt_machine_init(MachineState *machin=
e)
>      sysbus_create_simple("goldfish_rtc", memmap[VIRT_RTC].base,
>          qdev_get_gpio_in(mmio_irqchip, RTC_IRQ));
>
> +    if (s->have_iopmp) {
> +        DeviceState *iopmp_dev =3D sysbus_create_simple(TYPE_IOPMP,
> +            memmap[VIRT_IOPMP].base,
> +            qdev_get_gpio_in(DEVICE(mmio_irqchip), IOPMP_IRQ));
> +
> +        iopmp_setup_pci(iopmp_dev, PCI_HOST_BRIDGE(gpex_dev)->bus);
> +    }
> +
>      for (i =3D 0; i < ARRAY_SIZE(s->flash); i++) {
>          /* Map legacy -drive if=3Dpflash to machine properties */
>          pflash_cfi01_legacy_drive(s->flash[i],
> @@ -1684,6 +1716,21 @@ static void virt_set_aclint(Object *obj, bool valu=
e, Error **errp)
>      s->have_aclint =3D value;
>  }
>
> +static bool virt_get_iopmp(Object *obj, Error **errp)
> +{
> +    RISCVVirtState *s =3D RISCV_VIRT_MACHINE(obj);
> +
> +    return s->have_iopmp;
> +}
> +
> +static void virt_set_iopmp(Object *obj, bool value, Error **errp)
> +{
> +    RISCVVirtState *s =3D RISCV_VIRT_MACHINE(obj);
> +
> +    s->have_iopmp =3D value;
> +}
> +
> +
>  bool virt_is_acpi_enabled(RISCVVirtState *s)
>  {
>      return s->acpi !=3D ON_OFF_AUTO_OFF;
> @@ -1794,6 +1841,12 @@ static void virt_machine_class_init(ObjectClass *o=
c, void *data)
>                                NULL, NULL);
>      object_class_property_set_description(oc, "acpi",
>                                            "Enable ACPI");
> +
> +    object_class_property_add_bool(oc, "iopmp", virt_get_iopmp,
> +                                   virt_set_iopmp);
> +    object_class_property_set_description(oc, "iopmp",
> +                                          "Set on/off to enable/disable =
"
> +                                          "iopmp device");
>  }
>
>  static const TypeInfo virt_machine_typeinfo =3D {
> diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
> index 3db839160f..81460e29c4 100644
> --- a/include/hw/riscv/virt.h
> +++ b/include/hw/riscv/virt.h
> @@ -55,6 +55,7 @@ struct RISCVVirtState {
>
>      int fdt_size;
>      bool have_aclint;
> +    bool have_iopmp;
>      RISCVVirtAIAType aia_type;
>      int aia_guests;
>      char *oem_id;
> @@ -84,12 +85,14 @@ enum {
>      VIRT_PCIE_MMIO,
>      VIRT_PCIE_PIO,
>      VIRT_PLATFORM_BUS,
> -    VIRT_PCIE_ECAM
> +    VIRT_PCIE_ECAM,
> +    VIRT_IOPMP,
>  };
>
>  enum {
>      UART0_IRQ =3D 10,
>      RTC_IRQ =3D 11,
> +    IOPMP_IRQ =3D 12,
>      VIRTIO_IRQ =3D 1, /* 1 to 8 */
>      VIRTIO_COUNT =3D 8,
>      PCIE_IRQ =3D 0x20, /* 32 to 35 */
> --
> 2.34.1
>
>

