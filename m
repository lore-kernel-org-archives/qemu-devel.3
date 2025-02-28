Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD00AC282C5
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 06:03:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tntTC-00050N-TW; Fri, 28 Feb 2025 01:03:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tntSy-0004xl-2k; Fri, 28 Feb 2025 01:03:20 -0500
Received: from mail-ua1-x933.google.com ([2607:f8b0:4864:20::933])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tntSw-00029O-3B; Fri, 28 Feb 2025 01:03:19 -0500
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-868f169bb56so769525241.0; 
 Thu, 27 Feb 2025 22:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740722596; x=1741327396; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/NQnRoZ1YtIhkUe24kXp85VFeybIdqgaIMY7VOmPdhI=;
 b=ej0OhgQHXIwheqFVhUCq4NxTGQgBklQxXOgFWC3VbPh1v2r1b1h+RCHP8qzn0MIidf
 37ccbCoWb64kJh2Qklz1pVzt+6s7rTqNvLF6r7cNpUzNsB6e8c1ozX1F8m/NtqnhaZBK
 O+8T7HKHAjAZxWsuAdtHc8dOAEmsuaEhJvNm3AELAe7oDF2ruV+xltA6iYOlUDrXNbCx
 yiYq40GCqa1pEdIlLQIeIOxz3WJJxdggjiI7Mf/rCJQ5FeOdDft/8WuNooi0dYpnGpl0
 2ufY01Vkzam3OO7ZKeNIW6othki7qhW/4fKSgstXaPkMQ0mWqZbKH53FNTLXW27AK8FF
 wNhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740722596; x=1741327396;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/NQnRoZ1YtIhkUe24kXp85VFeybIdqgaIMY7VOmPdhI=;
 b=CoS+wXp9/4npIpEnHBfN+Wi7K95mR8oBj62oSP3UxGxCwifKhTShx+4zsktSrRAxTX
 KPnoYk68/KaGir1vhYrJZ7Jtx3xIGD/E9s3buUcr+cf4mhB8MIkZNCWky+jE1S64xdyA
 n61oX/lutpsCPdiET5bRuA9B2ZiN9XYVbPf9Kq//w0OUSpsMIemVxe/Dm9zGPkWEltve
 yGUC+uEWUDKA5KeaoVCPnCrIzdf/woP+yHUKJyYZ48Cvj77Hj1VBvrl/AOumF79vqVOG
 6qIY52HgyZxprDWlvxXPC9hdw1v9tIJxJvzGVNNRdZBNrvXua0VzAg7gMMuszgaVbRlk
 dYYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1Xhw+4n6Y9B52yHdN/6cbMM9DA/KzsIbPaXsWS71LPNFK2Gw4wHmaB/dGs7dAGpvzQW0JmXVlcU8B@nongnu.org
X-Gm-Message-State: AOJu0YwvirbuKFYEeTVKjf4ONPz7dF1v6WITes1rPWRa7ueINprqhyDb
 ZBNRC40zP70OC+ZRpaxdxslzSt3BA4tePmfVAImYVLvB2c8imNSVr15A8OKwZXnq/Gh6wfeb8QV
 hoe7ntmpt/nOmJC/PNPdEbbHXhS0=
X-Gm-Gg: ASbGncvgYSyauW7VdxaR2vW8xvmI4jwQ9Ng75Ai2tGNSPih5Wj9zZNsTEZVLSq802gE
 bEbxKLbmyLyx5xI4HU5Q5GcpwYj0NOrSFhLmx/i0mM3WRXGNw9TPmZrKa+pFFeQSnk66wRTWqX9
 cNAAUDjNVOKx5G2upGSRAUh6OKz6GK6jxcwSMt
X-Google-Smtp-Source: AGHT+IEcNtdd7brnxmFHYhncLc4e1CofNOf0MhJKStrE4E9NDJOzGAv6si8p6uFT5Nlo6JH0nLNMvXTw7NGT/6nDkQM=
X-Received: by 2002:a05:6102:14a3:b0:4bb:d062:438 with SMTP id
 ada2fe7eead31-4c044858c74mr1695976137.1.1740722595807; Thu, 27 Feb 2025
 22:03:15 -0800 (PST)
MIME-Version: 1.0
References: <20250122083617.3940240-1-ethan84@andestech.com>
 <20250122084747.3971444-1-ethan84@andestech.com>
In-Reply-To: <20250122084747.3971444-1-ethan84@andestech.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 28 Feb 2025 16:02:49 +1000
X-Gm-Features: AQ5f1Jp-7GjXdbxKrS53jDAzfM93rWKD7YwfB_hqaB2ZnZHDefmiS7sfRYvG-2Q
Message-ID: <CAKmqyKMUm6p270E7bk4zMsR05HJxFT0Vru8ADLQxP+or2SenwQ@mail.gmail.com>
Subject: Re: [PATCH v10 8/8] hw/riscv/virt: Add IOPMP support
To: Ethan Chen <ethan84@andestech.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, pbonzini@redhat.com, 
 palmer@dabbelt.com, alistair.francis@wdc.com, bmeng.cn@gmail.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::933;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x933.google.com
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

On Wed, Jan 22, 2025 at 6:49=E2=80=AFPM Ethan Chen via <qemu-devel@nongnu.o=
rg> wrote:
>
> - Add 'iopmp=3Don' option to enable IOPMP. It adds iopmp devices virt mac=
hine
>   to protect all regions of system memory.
>
> Signed-off-by: Ethan Chen <ethan84@andestech.com>
> ---
>  docs/system/riscv/virt.rst |  7 ++++
>  hw/riscv/Kconfig           |  1 +
>  hw/riscv/virt.c            | 75 ++++++++++++++++++++++++++++++++++++++
>  include/hw/riscv/virt.h    |  4 ++
>  4 files changed, 87 insertions(+)
>
> diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
> index 60850970ce..6b5fc1d37d 100644
> --- a/docs/system/riscv/virt.rst
> +++ b/docs/system/riscv/virt.rst
> @@ -146,6 +146,13 @@ The following machine-specific options are supported=
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

We should include some details on the default implementation settings
here as well

Alistair

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
> index 241389d72f..c5a8f7173e 100644
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
> @@ -1117,6 +1125,24 @@ static void create_fdt_iommu(RISCVVirtState *s, ui=
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
> @@ -1141,6 +1167,10 @@ static void finalize_fdt(RISCVVirtState *s)
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
> @@ -1529,6 +1559,8 @@ static void virt_machine_init(MachineState *machine=
)
>      DeviceState *mmio_irqchip, *virtio_irqchip, *pcie_irqchip;
>      int i, base_hartid, hart_count;
>      int socket_count =3D riscv_socket_count(machine);
> +    DeviceState *iopmp_dev, *iopmp_disp_dev;
> +    StreamSink *iopmp_ss, *iopmp_disp_ss;
>
>      /* Check socket count limit */
>      if (VIRT_SOCKETS_MAX < socket_count) {
> @@ -1710,6 +1742,29 @@ static void virt_machine_init(MachineState *machin=
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
> @@ -1845,6 +1900,20 @@ static void virt_set_iommu_sys(Object *obj, Visito=
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
> @@ -1972,6 +2041,12 @@ static void virt_machine_class_init(ObjectClass *o=
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
> index 48a14bea2e..77dcbd5450 100644
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
> @@ -87,11 +88,14 @@ enum {
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
> +    DMA_IRQ =3D 13,
>      VIRTIO_IRQ =3D 1, /* 1 to 8 */
>      VIRTIO_COUNT =3D 8,
>      PCIE_IRQ =3D 0x20, /* 32 to 35 */
> --
> 2.34.1
>
>

