Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E28C54ED0
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 01:26:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHugB-0002NE-S6; Wed, 21 May 2025 21:25:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uHugA-0002Mx-1O; Wed, 21 May 2025 21:25:02 -0400
Received: from mail-vk1-xa2c.google.com ([2607:f8b0:4864:20::a2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uHug4-00022K-RB; Wed, 21 May 2025 21:25:01 -0400
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-52dc131419cso1637566e0c.2; 
 Wed, 21 May 2025 18:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747877095; x=1748481895; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BgnVxAiGKjj02++jraTBMqSAl9FX4G6AdDVe2ignLAU=;
 b=fPSoE3vDymhcpKAJjqRgXXVRNSGcMU4wDgA+eV2zIYVGQTFf7A4jrbMXowS1inA5Di
 5rjGHbDwD8aOwF+KaXLqphEFUoPytu4qxugCTUp99lCwaFEhkp83PnO1KSQDMQmWGv5I
 gI2gWzMqSq9i1LOk6eFfdmzSgt1052Onz9DR7Gmbhdglv0iE4svQBz5uhWqOe3Q9H8D+
 fCtmEP23/MA2QMDkm39hep5QHv6jMe2frHlYJhETgKuga6SHefWNK80XScXCbfyf2Phk
 ZEpuvmY5FWBLKLULMO5kt5JtsjTx0Fa31xqXg4Mjbh5Ew2zgYW13uT11Cr6L7wmWgmJk
 yQFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747877095; x=1748481895;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BgnVxAiGKjj02++jraTBMqSAl9FX4G6AdDVe2ignLAU=;
 b=nt4krodIvmX14HJSot1IDV2EFsQy24KaH86Gv8JbbB+M60cdnChbjKf+M2v7JJP3fV
 DIEAAY9LVy8qlpiWRZm2DBIMDNJa2Mrg3TSkKKMvSeh84BiE5v4k5c5qEwJ2nN6ahNi5
 l0n/zPyiZQdh6MpmPm24Plaoyn/Q6aqRPAfkyktJqb6Zwygrgvn5srXqPl603qtGFZTR
 H9TEAs4MZgx3BqBuosBffptvKGxtpL8llYh5W7jwOWNPiwA53SV19QqqUfHPHYze1TBH
 ScdTHqftfbFvtPDPRjOB4p3GfDlMiipU9S7/BLkX6d8o+yTc7O+/dwEEkq/lT7KXJUPB
 eXxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPQhI+EY8DU/H1vxJZ/WmeB5/sEWJ1hVi0pEgj2YykWNRBHQoeRy1rV4n7xFD00WAwbZWXz5vKKfsY@nongnu.org
X-Gm-Message-State: AOJu0YzuRUMmwEVTtj2kknjHGnDqaOuafTC/1TZgQ6tupNyEDTLS9aAY
 5qULYTGhdD/PPBFezoNGZ/e0sqEElKCM/xiK0xNYuXjGVDuXCpCrYF+2uVvw8vi5BQwHdh2QdOA
 sVpXRHFVdw7Jkq14sf6yIe8M3jtct2wM=
X-Gm-Gg: ASbGncvqmlAeeHL6hj/mGem1KeYzzQsotGkSJqJJOK0hpR5DkCe0CYWikidQjREOvuK
 P2dlfuBYiMLkVoOpyW0Jg9jmYkAucFqdh9v0Vm9wac2taw29/pQpFwncT78nMH5yf1zOrC/u7UP
 owkkIyFbe+en8v98PooQ+4nI0svt9CSof7udMC35UzOepVh9lwkchBLw8j221dgWs=
X-Google-Smtp-Source: AGHT+IFjnPPKdZ4eSEY4SQiqQnLm4Y5yNasd5VQP+xbl+QPFXNdlmiLfZZcrNehDKVD2ri2uiKYzfvfw1mqbN+ebGHo=
X-Received: by 2002:a05:6122:1b07:b0:52c:49b6:7f05 with SMTP id
 71dfb90a1353d-52dbcd6d4a1mr20938350e0c.6.1747877094816; Wed, 21 May 2025
 18:24:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250312093735.1517740-1-ethan84@andestech.com>
 <20250312093735.1517740-9-ethan84@andestech.com>
In-Reply-To: <20250312093735.1517740-9-ethan84@andestech.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 22 May 2025 11:24:28 +1000
X-Gm-Features: AX0GCFsrlBvWgqLzaAvwdDmzKYeemvmNTi8b2W6bcUK_Tq5Caoyc0qs-EbVyUG4
Message-ID: <CAKmqyKMwfjYbYeCNHdVcCcfEUQZyE12isetwmky0V9WbPjabJw@mail.gmail.com>
Subject: Re: [PATCH v11 8/8] hw/riscv/virt: Add IOPMP support
To: Ethan Chen <ethan84@andestech.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, pbonzini@redhat.com, 
 palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, peterx@redhat.com, 
 david@redhat.com, philmd@linaro.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2c;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
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

On Wed, Mar 12, 2025 at 7:43=E2=80=AFPM Ethan Chen via <qemu-devel@nongnu.o=
rg> wrote:
>
> - Add 'iopmp=3Don' option to enable IOPMP. It adds iopmp devices virt mac=
hine
>   to protect all regions of system memory.
>
> Signed-off-by: Ethan Chen <ethan84@andestech.com>
> ---
>  docs/specs/index.rst       |  1 +
>  docs/specs/riscv-iopmp.rst | 60 ++++++++++++++++++++++++++++++
>  docs/system/riscv/virt.rst |  9 +++++
>  hw/riscv/Kconfig           |  1 +
>  hw/riscv/virt.c            | 75 ++++++++++++++++++++++++++++++++++++++
>  include/hw/riscv/virt.h    |  3 ++
>  6 files changed, 149 insertions(+)
>  create mode 100644 docs/specs/riscv-iopmp.rst
>
> diff --git a/docs/specs/index.rst b/docs/specs/index.rst
> index f19d73c9f6..0871c17b8f 100644
> --- a/docs/specs/index.rst
> +++ b/docs/specs/index.rst
> @@ -39,3 +39,4 @@ guest hardware that is specific to QEMU.
>     riscv-iommu
>     riscv-aia
>     aspeed-intc
> +   riscv-iopmp
> diff --git a/docs/specs/riscv-iopmp.rst b/docs/specs/riscv-iopmp.rst
> new file mode 100644
> index 0000000000..36a395e552
> --- /dev/null
> +++ b/docs/specs/riscv-iopmp.rst
> @@ -0,0 +1,60 @@
> +.. _riscv-iopmp:
> +
> +RISC-V IOPMP support for RISC-V machines
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +IOPMP support is based on `IOPMP specification version 0.7`_. The device=
 is
> +available on the RISC-V virt machine but is disabled by default. To enab=
le
> +iopmp device, use the 'iopmp' machine option
> +
> +.. code-block:: bash
> +
> +  $ qemu-system-riscv64 -M virt,iopmp=3Don
> +
> +On the virt board, the number of IOPMP device is fixed at 1, and its pro=
tect
> +region is fixed to 0x0~0xFFFFFFFF.
> +
> +To configure IOPMP device, modify gloal driver property
> +
> +.. code-block:: bash
> +
> +  -global driver=3Driscv_iopmp, property=3D<property>, value=3D<value>
> +
> +Below are the IOPMP device properties and their default values:
> +
> +- mdcfg_fmt: 1 (Options: 0/1/2)
> +- srcmd_fmt: 0 (Options: 0/1/2)
> +- tor_en: true (Options: true/false)
> +- sps_en: false (Options: true/false)
> +- prient_prog: true (Options: true/false)
> +- rrid_transl_en: false (Options: true/false)
> +- rrid_transl_prog: false (Options: true/false)
> +- chk_x: true (Options: true/false)
> +- no_x: false (Options: true/false)
> +- no_w: false (Options: true/false)
> +- stall_en: false (Options: true/false)
> +- peis: true (Options: true/false)
> +- pees: true (Options: true/false)
> +- mfr_en: true (Options: true/false)
> +- md_entry_num: 5 (IMP: Valid only for mdcfg_fmt 1/2)
> +- md_num: 8 (Range: 0-63)
> +- rrid_num: 16 (Range: srcmd_fmt =E2=89=A0 2: 0-65535, srcmd_fmt =3D 2: =
0-32)
> +- entry_num: 48 (Range: 0-IMP. For mdcfg_fmt =3D 1,
> +  it is fixed as md_num * (md_entry_num + 1).
> +  Entry registers must not overlap with other registers.)
> +- prio_entry: 65535 (Range: 0-IMP. If prio_entry > entry_num,
> +  it will be set to entry_num.)
> +- rrid_transl: 0x0 (Range: 0-65535)
> +- entry_offset: 0x4000 (IMP: Entry registers must not overlap
> +  with other registers.)
> +- err_rdata: 0x0 (uint32. Specifies the value used in responses to
> +  read transactions when errors are suppressed)
> +- msi_en: false (Options: true/false)
> +- msidata: 12 (Range: 1-1023)
> +- stall_violation_en: true (Options: true/false)
> +- err_msiaddr: 0x24000000 (lower-part 32-bit address)
> +- err_msiaddrh: 0x0 (higher-part 32-bit address)
> +- msi_rrid: 0 (Range: 0-65535. Specifies the rrid used by the IOPMP to s=
end
> +  the MSI.)

I'm not sure this is clear to a user, what are people supposed to do
with all these values?

Alistair

> +
> +.. _IOPMP specification version 0.7: https://github.com/riscv-non-isa/io=
pmp-spec/releases/download/v0.7/iopmp-v0.7.pdf
> diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
> index 60850970ce..77c8d386d5 100644
> --- a/docs/system/riscv/virt.rst
> +++ b/docs/system/riscv/virt.rst
> @@ -146,6 +146,15 @@ The following machine-specific options are supported=
:
>
>    Enables the riscv-iommu-sys platform device. Defaults to 'off'.
>
> +- iopmp=3D[on|off]
> +
> +  When this option is "on", IOPMP devices are added to machine. IOPMP ch=
ecks
> +  memory transcations in system memory. This option is assumed to be "of=
f". To
> +  enable the CPU to perform transactions with a specified RRID, use the =
CPU
> +  option "-cpu <cpu>,iopmp=3Dtrue,iopmp_rrid=3D<rrid>"
> +
> +  See :ref:`riscv-iopmp` for configurations of IOPMP
> +
>  Running Linux kernel
>  --------------------
>
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index e6a0ac1fa1..637438af2c 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -68,6 +68,7 @@ config RISCV_VIRT
>      select PLATFORM_BUS
>      select ACPI
>      select ACPI_PCI
> +    select RISCV_IOPMP
>
>  config SHAKTI_C
>      bool
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index dae46f4733..0d62e7786c 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -57,6 +57,8 @@
>  #include "hw/acpi/aml-build.h"
>  #include "qapi/qapi-visit-common.h"
>  #include "hw/virtio/virtio-iommu.h"
> +#include "hw/misc/riscv_iopmp.h"
> +#include "hw/misc/riscv_iopmp_dispatcher.h"
>
>  /* KVM AIA only supports APLIC MSI. APLIC Wired is always emulated by QE=
MU. */
>  static bool virt_use_kvm_aia_aplic_imsic(RISCVVirtAIAType aia_type)
> @@ -94,6 +96,7 @@ static const MemMapEntry virt_memmap[] =3D {
>      [VIRT_UART0] =3D        { 0x10000000,         0x100 },
>      [VIRT_VIRTIO] =3D       { 0x10001000,        0x1000 },
>      [VIRT_FW_CFG] =3D       { 0x10100000,          0x18 },
> +    [VIRT_IOPMP] =3D        { 0x10200000,      0x100000 },
>      [VIRT_FLASH] =3D        { 0x20000000,     0x4000000 },
>      [VIRT_IMSIC_M] =3D      { 0x24000000, VIRT_IMSIC_MAX_SIZE },
>      [VIRT_IMSIC_S] =3D      { 0x28000000, VIRT_IMSIC_MAX_SIZE },
> @@ -102,6 +105,11 @@ static const MemMapEntry virt_memmap[] =3D {
>      [VIRT_DRAM] =3D         { 0x80000000,           0x0 },
>  };
>
> +static const MemMapEntry iopmp_protect_memmap[] =3D {
> +    /* IOPMP protect all regions by default */
> +    {0x0, 0xFFFFFFFF},
> +};
> +
>  /* PCIe high mmio is fixed for RV32 */
>  #define VIRT32_HIGH_PCIE_MMIO_BASE  0x300000000ULL
>  #define VIRT32_HIGH_PCIE_MMIO_SIZE  (4 * GiB)
> @@ -1118,6 +1126,24 @@ static void create_fdt_iommu(RISCVVirtState *s, ui=
nt16_t bdf)
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
> @@ -1142,6 +1168,10 @@ static void finalize_fdt(RISCVVirtState *s)
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
> @@ -1532,6 +1562,8 @@ static void virt_machine_init(MachineState *machine=
)
>      DeviceState *mmio_irqchip, *virtio_irqchip, *pcie_irqchip;
>      int i, base_hartid, hart_count;
>      int socket_count =3D riscv_socket_count(machine);
> +    DeviceState *iopmp_dev, *iopmp_disp_dev;
> +    StreamSink *iopmp_ss, *iopmp_disp_ss;
>
>      /* Check socket count limit */
>      if (VIRT_SOCKETS_MAX < socket_count) {
> @@ -1713,6 +1745,29 @@ static void virt_machine_init(MachineState *machin=
e)
>      }
>      virt_flash_map(s, system_memory);
>
> +    if (s->have_iopmp) {
> +        iopmp_dev =3D iopmp_create(memmap[VIRT_IOPMP].base,
> +            qdev_get_gpio_in(DEVICE(mmio_irqchip), IOPMP_IRQ));
> +
> +        iopmp_setup_system_memory(iopmp_dev, &iopmp_protect_memmap[0], 1=
, 0);
> +
> +        iopmp_disp_dev =3D qdev_new(TYPE_RISCV_IOPMP_DISP);
> +        qdev_prop_set_uint32(DEVICE(iopmp_disp_dev), "target-num", 1);
> +        qdev_prop_set_uint32(DEVICE(iopmp_disp_dev), "stage-num", 1);
> +        qdev_realize(DEVICE(iopmp_disp_dev), NULL, &error_fatal);
> +
> +        /* Add memmap inforamtion to dispatcher */
> +        iopmp_ss =3D (StreamSink *)&(RISCV_IOPMP(iopmp_dev)->txn_info_si=
nk);
> +        iopmp_dispatcher_add_target(DEVICE(iopmp_disp_dev), iopmp_ss,
> +                                    iopmp_protect_memmap[0].base,
> +                                    iopmp_protect_memmap[0].size,
> +                                    0, 0);
> +
> +        iopmp_disp_ss =3D
> +            (StreamSink *)&(RISCV_IOPMP_DISP(iopmp_disp_dev)->txn_info_s=
ink);
> +        iopmp_setup_sink(iopmp_dev, iopmp_disp_ss);
> +    }
> +
>      /* load/create device tree */
>      if (machine->dtb) {
>          machine->fdt =3D load_device_tree(machine->dtb, &s->fdt_size);
> @@ -1848,6 +1903,20 @@ static void virt_set_iommu_sys(Object *obj, Visito=
r *v, const char *name,
>      visit_type_OnOffAuto(v, name, &s->iommu_sys, errp);
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
> @@ -1975,6 +2044,12 @@ static void virt_machine_class_init(ObjectClass *o=
c, void *data)
>                                NULL, NULL);
>      object_class_property_set_description(oc, "iommu-sys",
>                                            "Enable IOMMU platform device"=
);
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
> index 48a14bea2e..cf1e5bd872 100644
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
> @@ -87,11 +88,13 @@ enum {
>      VIRT_PLATFORM_BUS,
>      VIRT_PCIE_ECAM,
>      VIRT_IOMMU_SYS,
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

