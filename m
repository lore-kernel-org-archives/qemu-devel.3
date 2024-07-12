Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16484C3DA45
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 02:04:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sS5cv-000709-1X; Thu, 11 Jul 2024 22:03:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sS5cs-0006rn-Io; Thu, 11 Jul 2024 22:03:11 -0400
Received: from mail-ua1-x934.google.com ([2607:f8b0:4864:20::934])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sS5cq-0001h1-46; Thu, 11 Jul 2024 22:03:10 -0400
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-8102193c82bso426127241.3; 
 Thu, 11 Jul 2024 19:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720749785; x=1721354585; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hJLJihW92UKZeEDqUylrm4161EB279feN4dEb1aY+A0=;
 b=N+aASMGMkSxSvvK2xTxHmiipYHsj4jQmk32SYk17KKgegBILtiLUfMyBfSWaoXi/gO
 m1cLE4eJ/rUZVI2XgyNX+8qTgzHkb5kGk0wg/1XSLoOOmglEj2QAEoP7QF/uxfZZN4a/
 AqlIkg1w1OftTXWoVsQuOoO3nHjSVT3qwY8Tb0ib8vn6xbNa8adY+7LkyEaes+Aw46Lu
 1fWhc9SoL3uS/axrO2QTbMgc2aKqrGB5aEaigUsPxGXGy/cflMWq8za/G0ERvbg2lL1M
 XUZwDrB9V8XKRgsm991vnIoKa+hrK30aR5QaDYvgDrjfsYuBMCSyTELMr4BOGzhwxZsU
 e2/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720749785; x=1721354585;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hJLJihW92UKZeEDqUylrm4161EB279feN4dEb1aY+A0=;
 b=PfQD+VhTM1wSPXfNabeTDLFabcTyxJ5zNvlzud16n5DXMG1xVX4jI8q47GLpS6nQKh
 03wmnO4m708AEnsPIH91iHhysBqbUh2nJ/BoIWe1cdVlP1uosJas8TH3g/rY346tpm0N
 lUal35UbxY1RMuhNV+oJANB7tjn9VcienxWjKkl5F5EwxF86W3QKI81M3oFIXrHW5dyx
 jIBCSIV0hiNmrxwBeiPszu0J+QuIG/4yNY2Blx3oilgfXzGFBF86tEdvsgm97obyh0+T
 7LF5ssOubj6xr1qLbuADnvKyUv/KQCh06FIeUWXCKuSluAz7VjklSJ9FWeXLnt7s5RY5
 1w/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZCmioqpHrJoRGagh3BsQ4ll/8/xMLyivExHjennk69gdv/q0YNwE0XkAjw+IXXfGUsBs5U85h9qm+zNbxFRiBUSGNtn1HbpLQvBC4gjftQtvsak2K5lJac7FBqbgrszX0m2BUaPOsKmU46opG4yD9mAuMfbFsUZUaw+mhHm6SWtCqCA1fmw==
X-Gm-Message-State: AOJu0YwNPpcGQo8348mbWO9ZMxwhy3+yc0UArV4JDR0voM0PEkDkAXsV
 q/uhzyEF/U21v6Eatjaygq+vZCPTgA4oeDL+g5sCJEkFDaIwx0COmqcIic9T20xp2e1Mqpe9AtG
 fvc0KqR2knd9l0NHPR5ACPli4Y4Y=
X-Google-Smtp-Source: AGHT+IHgwax1mdkV0O0dyTVB27ZGNtHeX3SEHLI6D+Kg1oGEGtvdjrCV/monPLQLhAq6KhhPBHP+HPFN2EBJPM6+CaY=
X-Received: by 2002:a05:6102:f10:b0:48f:9dea:bec6 with SMTP id
 ada2fe7eead31-4903215451bmr12786910137.18.1720749785431; Thu, 11 Jul 2024
 19:03:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240612081416.29704-1-jim.shu@sifive.com>
 <20240612081416.29704-17-jim.shu@sifive.com>
In-Reply-To: <20240612081416.29704-17-jim.shu@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 12 Jul 2024 12:02:39 +1000
Message-ID: <CAKmqyKMXPttUZRVbUYM0pctTicAeqcFkHK3tyfvCS43eKw3twQ@mail.gmail.com>
Subject: Re: [RFC PATCH 16/16] hw/riscv: virt: Add WorldGuard support
To: Jim Shu <jim.shu@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Peter Xu <peterx@redhat.com>, 
 David Hildenbrand <david@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>, 
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>, 
 Nicholas Piggin <npiggin@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>, 
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::934;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x934.google.com
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

On Wed, Jun 12, 2024 at 6:18=E2=80=AFPM Jim Shu <jim.shu@sifive.com> wrote:
>
> * Add 'wg=3Don' option to enable RISC-V WorldGuard
> * Add wgChecker to protect several resources:
>   DRAM, FLASH, UART.
>
> Signed-off-by: Jim Shu <jim.shu@sifive.com>
> ---
>  docs/system/riscv/virt.rst |  10 +++
>  hw/riscv/Kconfig           |   1 +
>  hw/riscv/virt.c            | 163 ++++++++++++++++++++++++++++++++++++-
>  include/hw/riscv/virt.h    |  17 +++-
>  4 files changed, 186 insertions(+), 5 deletions(-)
>
> diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
> index 9a06f95a34..2d2992dc34 100644
> --- a/docs/system/riscv/virt.rst
> +++ b/docs/system/riscv/virt.rst
> @@ -116,6 +116,16 @@ The following machine-specific options are supported=
:
>    having AIA IMSIC (i.e. "aia=3Daplic-imsic" selected). When not specifi=
ed,
>    the default number of per-HART VS-level AIA IMSIC pages is 0.
>
> +- wg=3D[on|off]
> +
> +  When this option is "on", RISC-V WorldGuard will be enabled in the sys=
tem
> +  to provide the isolation of multiple worlds. RISC-V HARTS will enable =
WG
> +  extensions to have WID in memory transaction. wgCheckers in front of R=
AMs
> +  and device MMIO will be enabled to provide the access control of resou=
rces
> +  if the transaction contains WID. When not specified, this option is as=
sumed
> +  to be "off".
> +  This option is restricted to the TCG accelerator.

We need a lot more documentation here.

The WID of M-mode for example is set by an external environment. How
are users going to set that in QEMU?

Are the Smwg, Smwgd, and Sswg extensions enabled? Or is it hard coded
one world per hart?

We should make it clear to users how this is setup as the spec leaves
a lot of this up to implementations. We also don't expect users to
read the code or commit messages to figure it out.

Alistair

> +
>  Running Linux kernel
>  --------------------
>
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index a2030e3a6f..7804fdbb7a 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -56,6 +56,7 @@ config RISCV_VIRT
>      select PLATFORM_BUS
>      select ACPI
>      select ACPI_PCI
> +    select RISCV_WORLDGUARD
>
>  config SHAKTI_C
>      bool
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 4fdb660525..eed49ebd02 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -55,6 +55,7 @@
>  #include "hw/acpi/aml-build.h"
>  #include "qapi/qapi-visit-common.h"
>  #include "hw/virtio/virtio-iommu.h"
> +#include "hw/misc/riscv_worldguard.h"
>
>  /* KVM AIA only supports APLIC MSI. APLIC Wired is always emulated by QE=
MU. */
>  static bool virt_use_kvm_aia(RISCVVirtState *s)
> @@ -76,6 +77,9 @@ static const MemMapEntry virt_memmap[] =3D {
>      [VIRT_ACLINT_SSWI] =3D  {  0x2F00000,        0x4000 },
>      [VIRT_PCIE_PIO] =3D     {  0x3000000,       0x10000 },
>      [VIRT_PLATFORM_BUS] =3D {  0x4000000,     0x2000000 },
> +    [VIRT_WGC_DRAM] =3D     {  0x6000000,        0x1000 },
> +    [VIRT_WGC_FLASH] =3D    {  0x6001000,        0x1000 },
> +    [VIRT_WGC_UART] =3D     {  0x6002000,        0x1000 },
>      [VIRT_PLIC] =3D         {  0xc000000, VIRT_PLIC_SIZE(VIRT_CPUS_MAX *=
 2) },
>      [VIRT_APLIC_M] =3D      {  0xc000000, APLIC_SIZE(VIRT_CPUS_MAX) },
>      [VIRT_APLIC_S] =3D      {  0xd000000, APLIC_SIZE(VIRT_CPUS_MAX) },
> @@ -101,6 +105,38 @@ static MemMapEntry virt_high_pcie_memmap;
>
>  #define VIRT_FLASH_SECTOR_SIZE (256 * KiB)
>
> +/* wgChecker helpers */
> +typedef struct WGCInfo {
> +    int memmap_idx;
> +    uint32_t irq_num;
> +    uint32_t slot_count;
> +
> +    int num_of_child;
> +    MemoryRegion *c_region[WGC_NUM_REGIONS];
> +    uint64_t c_offset[WGC_NUM_REGIONS];
> +} WGCInfo;
> +
> +enum {
> +    WGC_DRAM,
> +    WGC_FLASH,
> +    WGC_UART,
> +    WGC_NUM,
> +};
> +
> +static WGCInfo virt_wgcinfo[] =3D {
> +    [WGC_DRAM]  =3D { VIRT_WGC_DRAM, WGC_DRAM_IRQ, 16 },
> +    [WGC_FLASH] =3D { VIRT_WGC_FLASH, WGC_FLASH_IRQ, 16 },
> +    [WGC_UART]  =3D { VIRT_WGC_UART, WGC_UART_IRQ, 1 },
> +};
> +
> +static void wgc_append_child(WGCInfo *info, MemoryRegion *region,
> +                             uint64_t offset)
> +{
> +    info->c_region[info->num_of_child] =3D region;
> +    info->c_offset[info->num_of_child] =3D offset;
> +    info->num_of_child +=3D 1;
> +}
> +
>  static PFlashCFI01 *virt_flash_create1(RISCVVirtState *s,
>                                         const char *name,
>                                         const char *alias_prop_name)
> @@ -151,7 +187,8 @@ static void virt_flash_map1(PFlashCFI01 *flash,
>  }
>
>  static void virt_flash_map(RISCVVirtState *s,
> -                           MemoryRegion *sysmem)
> +                           MemoryRegion *sysmem,
> +                           WGCInfo *info)
>  {
>      hwaddr flashsize =3D virt_memmap[VIRT_FLASH].size / 2;
>      hwaddr flashbase =3D virt_memmap[VIRT_FLASH].base;
> @@ -160,6 +197,15 @@ static void virt_flash_map(RISCVVirtState *s,
>                      sysmem);
>      virt_flash_map1(s->flash[1], flashbase + flashsize, flashsize,
>                      sysmem);
> +
> +    if (info) {
> +        wgc_append_child(info,
> +                         sysbus_mmio_get_region(SYS_BUS_DEVICE(s->flash[=
0]), 0),
> +                         flashbase);
> +        wgc_append_child(info,
> +                         sysbus_mmio_get_region(SYS_BUS_DEVICE(s->flash[=
1]), 0),
> +                         flashbase + flashsize);
> +    }
>  }
>
>  static void create_pcie_irq_map(RISCVVirtState *s, void *fdt, char *node=
name,
> @@ -1303,6 +1349,71 @@ static void virt_build_smbios(RISCVVirtState *s)
>      }
>  }
>
> +static DeviceState *create_wgc(WGCInfo *info, DeviceState *irqchip)
> +{
> +    MemoryRegion *system_memory =3D get_system_memory();
> +    DeviceState *wgc;
> +    MemoryRegion *upstream_mr, *downstream_mr;
> +    qemu_irq irq =3D qdev_get_gpio_in(irqchip, info->irq_num);
> +    hwaddr base, size;
> +
> +    /* Unmap downstream_mr from system_memory if it is already mapped. *=
/
> +    for (int i=3D0; i<info->num_of_child; i++) {
> +        downstream_mr =3D info->c_region[i];
> +
> +        g_assert(downstream_mr);
> +        if (downstream_mr->container =3D=3D system_memory) {
> +            memory_region_del_subregion(system_memory, downstream_mr);
> +        }
> +
> +        /*
> +         * Clear the offset of downstream_mr, so we could correctly do
> +         * address_space_init() to it in wgchecker.
> +         */
> +        memory_region_set_address(downstream_mr, 0);
> +    }
> +
> +    base =3D virt_memmap[info->memmap_idx].base;
> +    size =3D virt_memmap[info->memmap_idx].size;
> +
> +    wgc =3D riscv_wgchecker_create(
> +        base, size, irq, info->slot_count, 0, 0,
> +        info->num_of_child, info->c_region, info->c_offset, 0, NULL);
> +
> +    /* Map upstream_mr to system_memory */
> +    for (int i=3D0; i<info->num_of_child; i++) {
> +        upstream_mr =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(wgc), i+1)=
;
> +        g_assert(upstream_mr);
> +        memory_region_add_subregion(system_memory, info->c_offset[i], up=
stream_mr);
> +    }
> +
> +    return wgc;
> +}
> +
> +static void virt_create_worldguard(WGCInfo *wgcinfo, int wgc_num,
> +                                   DeviceState *irqchip)
> +{
> +    CPUState *cpu;
> +
> +    /* Global WG config */
> +    riscv_worldguard_create(VIRT_WG_NWORLDS,
> +                            VIRT_WG_TRUSTEDWID,
> +                            VIRT_WG_HWBYPASS,
> +                            VIRT_WG_TZCOMPAT);
> +
> +    /* Enable WG extension of each CPU */
> +    CPU_FOREACH(cpu) {
> +        CPURISCVState *env =3D cpu ? cpu_env(cpu) : NULL;
> +
> +        riscv_worldguard_apply_cpu(env->mhartid);
> +    }
> +
> +    /* Create all wgChecker devices */
> +    for (int i=3D0; i<wgc_num; i++) {
> +        create_wgc(&wgcinfo[i], DEVICE(irqchip));
> +    }
> +}
> +
>  static void virt_machine_done(Notifier *notifier, void *data)
>  {
>      RISCVVirtState *s =3D container_of(notifier, RISCVVirtState,
> @@ -1401,10 +1512,12 @@ static void virt_machine_done(Notifier *notifier,=
 void *data)
>  static void virt_machine_init(MachineState *machine)
>  {
>      const MemMapEntry *memmap =3D virt_memmap;
> +    WGCInfo *wgcinfo =3D virt_wgcinfo;
>      RISCVVirtState *s =3D RISCV_VIRT_MACHINE(machine);
>      MemoryRegion *system_memory =3D get_system_memory();
>      MemoryRegion *mask_rom =3D g_new(MemoryRegion, 1);
>      DeviceState *mmio_irqchip, *virtio_irqchip, *pcie_irqchip;
> +    SerialMM *uart;
>      int i, base_hartid, hart_count;
>      int socket_count =3D riscv_socket_count(machine);
>
> @@ -1420,6 +1533,11 @@ static void virt_machine_init(MachineState *machin=
e)
>          exit(1);
>      }
>
> +    if (!tcg_enabled() && s->have_wg) {
> +        error_report("'wg' is only available with TCG acceleration");
> +        exit(1);
> +    }
> +
>      /* Initialize sockets */
>      mmio_irqchip =3D virtio_irqchip =3D pcie_irqchip =3D NULL;
>      for (i =3D 0; i < socket_count; i++) {
> @@ -1547,6 +1665,10 @@ static void virt_machine_init(MachineState *machin=
e)
>      memory_region_add_subregion(system_memory, memmap[VIRT_DRAM].base,
>          machine->ram);
>
> +    if (tcg_enabled() && s->have_wg) {
> +        wgc_append_child(&wgcinfo[WGC_DRAM], machine->ram, memmap[VIRT_D=
RAM].base);
> +    }
> +
>      /* boot rom */
>      memory_region_init_rom(mask_rom, NULL, "riscv_virt_board.mrom",
>                             memmap[VIRT_MROM].size, &error_fatal);
> @@ -1574,10 +1696,16 @@ static void virt_machine_init(MachineState *machi=
ne)
>
>      create_platform_bus(s, mmio_irqchip);
>
> -    serial_mm_init(system_memory, memmap[VIRT_UART0].base,
> +    uart =3D serial_mm_init(system_memory, memmap[VIRT_UART0].base,
>          0, qdev_get_gpio_in(mmio_irqchip, UART0_IRQ), 399193,
>          serial_hd(0), DEVICE_LITTLE_ENDIAN);
>
> +    if (tcg_enabled() && s->have_wg) {
> +        wgc_append_child(&wgcinfo[WGC_UART],
> +                         sysbus_mmio_get_region(SYS_BUS_DEVICE(uart), 0)=
,
> +                         memmap[VIRT_UART0].base);
> +    }
> +
>      sysbus_create_simple("goldfish_rtc", memmap[VIRT_RTC].base,
>          qdev_get_gpio_in(mmio_irqchip, RTC_IRQ));
>
> @@ -1586,7 +1714,16 @@ static void virt_machine_init(MachineState *machin=
e)
>          pflash_cfi01_legacy_drive(s->flash[i],
>                                    drive_get(IF_PFLASH, 0, i));
>      }
> -    virt_flash_map(s, system_memory);
> +
> +    if (tcg_enabled() && s->have_wg) {
> +        virt_flash_map(s, system_memory, &wgcinfo[WGC_FLASH]);
> +    } else {
> +        virt_flash_map(s, system_memory, NULL);
> +    }
> +
> +    if (tcg_enabled() && s->have_wg) {
> +        virt_create_worldguard(wgcinfo, WGC_NUM, mmio_irqchip);
> +    }
>
>      /* load/create device tree */
>      if (machine->dtb) {
> @@ -1614,6 +1751,20 @@ static void virt_machine_instance_init(Object *obj=
)
>      s->acpi =3D ON_OFF_AUTO_AUTO;
>  }
>
> +static bool virt_get_wg(Object *obj, Error **errp)
> +{
> +    RISCVVirtState *s =3D RISCV_VIRT_MACHINE(obj);
> +
> +    return s->have_wg;
> +}
> +
> +static void virt_set_wg(Object *obj, bool value, Error **errp)
> +{
> +    RISCVVirtState *s =3D RISCV_VIRT_MACHINE(obj);
> +
> +    s->have_wg =3D value;
> +}
> +
>  static char *virt_get_aia_guests(Object *obj, Error **errp)
>  {
>      RISCVVirtState *s =3D RISCV_VIRT_MACHINE(obj);
> @@ -1794,6 +1945,12 @@ static void virt_machine_class_init(ObjectClass *o=
c, void *data)
>                                NULL, NULL);
>      object_class_property_set_description(oc, "acpi",
>                                            "Enable ACPI");
> +
> +    object_class_property_add_bool(oc, "wg", virt_get_wg,
> +                                   virt_set_wg);
> +    object_class_property_set_description(oc, "wg",
> +                                              "Set on/off to enable/disa=
ble the "
> +                                              "RISC-V WorldGuard.");
>  }
>
>  static const TypeInfo virt_machine_typeinfo =3D {
> diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
> index 3db839160f..4d78702daf 100644
> --- a/include/hw/riscv/virt.h
> +++ b/include/hw/riscv/virt.h
> @@ -57,6 +57,7 @@ struct RISCVVirtState {
>      bool have_aclint;
>      RISCVVirtAIAType aia_type;
>      int aia_guests;
> +    bool have_wg;
>      char *oem_id;
>      char *oem_table_id;
>      OnOffAuto acpi;
> @@ -84,12 +85,18 @@ enum {
>      VIRT_PCIE_MMIO,
>      VIRT_PCIE_PIO,
>      VIRT_PLATFORM_BUS,
> -    VIRT_PCIE_ECAM
> +    VIRT_PCIE_ECAM,
> +    VIRT_WGC_DRAM,
> +    VIRT_WGC_FLASH,
> +    VIRT_WGC_UART
>  };
>
>  enum {
>      UART0_IRQ =3D 10,
>      RTC_IRQ =3D 11,
> +    WGC_DRAM_IRQ =3D 15,
> +    WGC_FLASH_IRQ =3D 16,
> +    WGC_UART_IRQ =3D 17,
>      VIRTIO_IRQ =3D 1, /* 1 to 8 */
>      VIRTIO_COUNT =3D 8,
>      PCIE_IRQ =3D 0x20, /* 32 to 35 */
> @@ -99,7 +106,7 @@ enum {
>  #define VIRT_PLATFORM_BUS_NUM_IRQS 32
>
>  #define VIRT_IRQCHIP_NUM_MSIS 255
> -#define VIRT_IRQCHIP_NUM_SOURCES 96
> +#define VIRT_IRQCHIP_NUM_SOURCES 128
>  #define VIRT_IRQCHIP_NUM_PRIO_BITS 3
>  #define VIRT_IRQCHIP_MAX_GUESTS_BITS 3
>  #define VIRT_IRQCHIP_MAX_GUESTS ((1U << VIRT_IRQCHIP_MAX_GUESTS_BITS) - =
1U)
> @@ -153,4 +160,10 @@ uint32_t imsic_num_bits(uint32_t count);
>  #error "Can't accommodate all IMSIC groups in address space"
>  #endif
>
> +/* WorldGuard */
> +#define VIRT_WG_NWORLDS         4
> +#define VIRT_WG_TRUSTEDWID      3
> +#define VIRT_WG_HWBYPASS        true
> +#define VIRT_WG_TZCOMPAT        false
> +
>  #endif
> --
> 2.17.1
>
>

