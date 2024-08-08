Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 951A6C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 04:02:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbuLV-0003D2-4O; Thu, 08 Aug 2024 00:01:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sbuLR-0003BW-Ij; Thu, 08 Aug 2024 00:01:46 -0400
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sbuLN-0000yW-Nd; Thu, 08 Aug 2024 00:01:44 -0400
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-4f511fddfcfso208246e0c.1; 
 Wed, 07 Aug 2024 21:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723089699; x=1723694499; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ImVw3KpB6f0URDBOEqLJAECU4TaJZt1MKxJyeKd3mt8=;
 b=Q+toSpK52cknUYaLbAxglnhmwlg6FnqaTbWQQawUEe/agXsdD3rG3xkkpATi7t/TyS
 0mJZLTjp5i50rnnLYTftKzEJ5WWVwvvuvSuQUO4OsIg6ColtOunprymy3crySPdTOaOa
 Zk4FtfADZuqIlNgJOPq44EHmQFfOivaexl8TN+sGGyCr4Dc/CJNwbmRkXLeZrzuRZiMg
 PBnIOSItKB6LVufaPmVlZrAexcI5GYngZXcY59GUHRP26dDurUBJpKB6pJTSSp1rDzaB
 JyxwIFZq3IFYDbhbpxamoanbbrNF4aC3mix6BK9fzFho4MaxcOwMP/zzXz75qmOV0PAq
 JD+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723089699; x=1723694499;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ImVw3KpB6f0URDBOEqLJAECU4TaJZt1MKxJyeKd3mt8=;
 b=r6Tp394plL8AXDpsqh/u/EAAxxNjhGFf5R3FHM0fDEEFWt1M2l3oITKAU5fqW2Jozf
 PClvMFuB6lyNmMxXaro7eP+j095ZEEgaGQYR9vUybeJTK/ORkRKHM2cGJ8c+tHf7PrwQ
 xT6cxtM0hQqbvB/l3C7Tvn5zZp1h+cbPxC0ZGkuGvt9TPGD3sPW3lXnbgul7+Yy7o+ck
 0UgNBQDLMJjN2i1OzepLrJbTqiRGR763sJIc2E1ejZRBTykvXl+4Khy5ns88A96U4gWQ
 CCQOU4h698XSXeGUYURU98NFJkaIdhFoGbuvWJ/p99Q3g95XbKUP+U2SXkAxZSLBAMTD
 zpaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjlLuG7w54e6DI37DbtJ85bGTVafYpSY37esiOztAaVwj/L+TQsoTs28Lw2F06imZdj1MuvagpR7Ir2B74LEt581am6+4=
X-Gm-Message-State: AOJu0YysS0GHtU0PnkO87E5NxqN6IGcY7t2yruaVHr+OaaREHcZWtSO4
 TPYrTbgsKH/HOTrGcFH+zUkTb3ktXP5RZAi6Srg1E49PJxOXzC6jDBhbE3PRTZ94WqXhkvMwmQ+
 Vt9aQiSBEppch9a9uPndBLqoJzAw=
X-Google-Smtp-Source: AGHT+IHW+gyzZVlUFXxPgPShSmSXY3LJIZj4hEnjjxe3MoiALtdCNlseMUHSzLN2P6Q7MjFtkamw2bV7Dny6w5vI9fQ=
X-Received: by 2002:a05:6122:3bc5:b0:4ef:64a2:8e18 with SMTP id
 71dfb90a1353d-4f90298c979mr896151e0c.12.1723089698959; Wed, 07 Aug 2024
 21:01:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240715095702.1222213-1-ethan84@andestech.com>
 <20240715101434.1249621-1-ethan84@andestech.com>
In-Reply-To: <20240715101434.1249621-1-ethan84@andestech.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 8 Aug 2024 14:01:13 +1000
Message-ID: <CAKmqyKPgqNaT1A0+pk6srrtPQqs6=SUX_etg55hU3rxPbuFVsA@mail.gmail.com>
Subject: Re: [PATCH v8 8/8] hw/riscv/virt: Add IOPMP support
To: Ethan Chen <ethan84@andestech.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, pbonzini@redhat.com, 
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a29;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa29.google.com
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

On Mon, Jul 15, 2024 at 8:15=E2=80=AFPM Ethan Chen via <qemu-devel@nongnu.o=
rg> wrote:
>
> - Add 'iopmp=3Don' option to enable IOPMP. It adds an iopmp device virt m=
achine
>   to protect all regions of system memory, and configures RRID of CPU.
>
> Signed-off-by: Ethan Chen <ethan84@andestech.com>
> ---
>  docs/system/riscv/virt.rst |  5 +++
>  hw/riscv/Kconfig           |  1 +
>  hw/riscv/virt.c            | 63 ++++++++++++++++++++++++++++++++++++++
>  include/hw/riscv/virt.h    |  5 ++-
>  4 files changed, 73 insertions(+), 1 deletion(-)
>
> diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
> index 9a06f95a34..9fd006ccc2 100644
> --- a/docs/system/riscv/virt.rst
> +++ b/docs/system/riscv/virt.rst
> @@ -116,6 +116,11 @@ The following machine-specific options are supported=
:
>    having AIA IMSIC (i.e. "aia=3Daplic-imsic" selected). When not specifi=
ed,
>    the default number of per-HART VS-level AIA IMSIC pages is 0.
>
> +- iopmp=3D[on|off]
> +
> +  When this option is "on", an IOPMP device is added to machine. IOPMP c=
hecks
> +  memory transcations in system memory. This option is assumed to be "of=
f".

We probably should have a a little more here. You don't even mention
that this is the rapid-k model.

It might be worth adding a `model` field, to make it easier to add
other models in the future. Thoughts?

Alistair

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
> index bc0893e087..5a03c03c4a 100644
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
> @@ -90,6 +92,11 @@ static const MemMapEntry virt_memmap[] =3D {
>      [VIRT_DRAM] =3D         { 0x80000000,           0x0 },
>  };
>
> +static const MemMapEntry iopmp_protect_memmap[] =3D {
> +    /* IOPMP protect all regions by default */
> +    {0, 0xFFFFFFFF},
> +};
> +
>  /* PCIe high mmio is fixed for RV32 */
>  #define VIRT32_HIGH_PCIE_MMIO_BASE  0x300000000ULL
>  #define VIRT32_HIGH_PCIE_MMIO_SIZE  (4 * GiB)
> @@ -1024,6 +1031,24 @@ static void create_fdt_virtio_iommu(RISCVVirtState=
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
> @@ -1042,6 +1067,10 @@ static void finalize_fdt(RISCVVirtState *s)
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
> @@ -1425,6 +1454,7 @@ static void virt_machine_init(MachineState *machine=
)
>      DeviceState *mmio_irqchip, *virtio_irqchip, *pcie_irqchip;
>      int i, base_hartid, hart_count;
>      int socket_count =3D riscv_socket_count(machine);
> +    int cpu, socket;
>
>      /* Check socket count limit */
>      if (VIRT_SOCKETS_MAX < socket_count) {
> @@ -1606,6 +1636,19 @@ static void virt_machine_init(MachineState *machin=
e)
>      }
>      virt_flash_map(s, system_memory);
>
> +    if (s->have_iopmp) {
> +        DeviceState *iopmp_dev =3D sysbus_create_simple(TYPE_IOPMP,
> +            memmap[VIRT_IOPMP].base,
> +            qdev_get_gpio_in(DEVICE(mmio_irqchip), IOPMP_IRQ));
> +
> +        for (socket =3D 0; socket < socket_count; socket++) {
> +            for (cpu =3D s->soc[socket].num_harts - 1; cpu >=3D 0; cpu--=
) {
> +                iopmp_setup_cpu(&s->soc[socket].harts[cpu], 0);
> +            }
> +        }
> +        iopmp_setup_system_memory(iopmp_dev, iopmp_protect_memmap, 1);
> +    }
> +
>      /* load/create device tree */
>      if (machine->dtb) {
>          machine->fdt =3D load_device_tree(machine->dtb, &s->fdt_size);
> @@ -1702,6 +1745,20 @@ static void virt_set_aclint(Object *obj, bool valu=
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
>  bool virt_is_acpi_enabled(RISCVVirtState *s)
>  {
>      return s->acpi !=3D ON_OFF_AUTO_OFF;
> @@ -1814,6 +1871,12 @@ static void virt_machine_class_init(ObjectClass *o=
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
> index c0dc41ff9a..009b4ebea7 100644
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

