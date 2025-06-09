Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E72C61CE8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 23:30:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOlwG-0005wG-3T; Mon, 09 Jun 2025 19:30:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uOlwD-0005vq-QQ; Mon, 09 Jun 2025 19:29:57 -0400
Received: from mail-vs1-xe2d.google.com ([2607:f8b0:4864:20::e2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uOlwB-0004Zu-9s; Mon, 09 Jun 2025 19:29:57 -0400
Received: by mail-vs1-xe2d.google.com with SMTP id
 ada2fe7eead31-4e45cfc3a26so3475664137.0; 
 Mon, 09 Jun 2025 16:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749511793; x=1750116593; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=41KS+EvzM+HxWZW/o/c5RMs5NBA/QLxXEZCSlCE9Gl8=;
 b=fkFfzBmIFtC37j3FI/zsfvo/2zYJ6uweQchy6yUu5j7YAGYf7dbvq3GMQldtb7LAqj
 iDMlCVNo7gj4eRACuMB58MjOHJEBGkwM2Fk2A2WhFEJp7Z8wnHfOo/xMF+KR9PeT1Ffm
 Lbk26fwMMff6P4QuxWXN/agTdskajElSQ+3GdMVgMWrTY//+Ny5ZkEx4y4T2d/hgfsY2
 ffsLlYavA5i+AKD5iB70br/fgkzrjhRPr1j1I1q3ci2rU218NbR2YRPQQEqnJ3iQmstY
 ejR4jQI6vUDUUxxCJQJdFzk4dW2y7QONYYQ3OaCBOedpw4cBTQfAihyvhkOQ+wMyLd26
 vn2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749511793; x=1750116593;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=41KS+EvzM+HxWZW/o/c5RMs5NBA/QLxXEZCSlCE9Gl8=;
 b=SdtCwjjdwdFx57ujk0PEGpkNGqNpyaeDjI2VXnG6h8L6bAWd5RxUaiOFBohLAlvLKm
 pllnzomc35OuwaokZyDggVSNUZ4wECcjonKrEJ6tpzbogP1kiBKypJWTjq9iXOPsU47h
 VsBNBGBhmnCK9v1W1R2NzLAl0HQlsDoy0Rx7RstVLAfrJpPuzLRoKCbwiixan6oPgcPM
 lEOrMVAZ60plKopTu88zCr3xtN8O5LOhDaj709jUn+HhR6doVrmTZUtMiKOng8jUENG4
 NZCJHug3oBBCMlA0Cxv6WWOya1UVByX2xctRwaBDqIgb0Et0rend4g+8piMRSpYqgUXk
 5onw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX54oJgkROqyO4HGBF8TXCceTumYI+4/CubS7LoP0fZ4M8+cRIfRXzw8zfEc5t2a1w4nL+kcBvzY8gJ@nongnu.org,
 AJvYcCXUswuC5SnCvohNYYiniipKjkdanw3HUlDGlxmljf7Y8l3hCwoSFDMhjCegN2MqJQq/7wlYZqyc4FLmLg==@nongnu.org
X-Gm-Message-State: AOJu0YwBqItFt9a6Ge0VT1dwfmfP1a/4ka/KOipfVfOtLejpoAzFERNR
 eWq7826tgMXOpGforJiJeT4V78kNebj/Lkt1XWpuhWYhl3f62hjg/KzHAAtoxTK0mLwjjNDy09f
 kYHp54EX6XhJWK7DpmpqjVfDslrSkPrS0EGJB
X-Gm-Gg: ASbGncuGcdpvq98jg9ErMQIcZefwz8Jm8gufhmG8hS+AbU+R41br2xJy0To4mp/ITSd
 WwozJJk0wW8yxH3EiojAbZg2kNJ6AirDZZeUWrYfxQjMmEA+jfichFDs1hBYvxEHZn15DU7sPUo
 uwLWD6NsIJmkNexyPb/HYKkIlNUNgYJnCNZzknx0T9cvL0YjazK2qbHU2M47MSLCoP2q+8QQdqh
 mey02LAgLCQ
X-Google-Smtp-Source: AGHT+IH9buquWHySMrAWPYoUKjQPSqjn0QH6RlVIf6937D3egfujA+GHKmWrHC9wRMNUxEo+lQ4yB/o1ATWNjM1yDpY=
X-Received: by 2002:a05:6102:6c6:b0:4e7:70f2:fa9b with SMTP id
 ada2fe7eead31-4e7a5dde219mr1831474137.10.1749511793139; Mon, 09 Jun 2025
 16:29:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250609131731.1464616-1-ben.dooks@codethink.co.uk>
 <20250609131731.1464616-2-ben.dooks@codethink.co.uk>
In-Reply-To: <20250609131731.1464616-2-ben.dooks@codethink.co.uk>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 10 Jun 2025 09:29:26 +1000
X-Gm-Features: AX0GCFt66L9gy_TyQ2M30_eRZr8BjAEua_EngW64xajE-U1-CshkBqPKWCsyTSg
Message-ID: <CAKmqyKMygMLtd16siWxtcsHkoyvy-Vm1OynYQfy2VgOh+i0GNw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] hw/riscv: add CVA6 machine
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: nazar.kazakov@codethink.co.uk, joseph.baker@codethink.co.uk, 
 fran.redondo@codethink.co.uk, lawrence.hunter@codethink.co.uk, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 alistair.francis@wdc.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2d;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2d.google.com
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

On Mon, Jun 9, 2025 at 11:19=E2=80=AFPM Ben Dooks <ben.dooks@codethink.co.u=
k> wrote:
>
> Add a (currently Genesy2 based) CVA6 machine.
>
> Has SPI and UART, the GPIO and Ethernet are currently black-holed
> as there is no hardware model for them (lowRISC ethernet and Xilinx
> GPIO)
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
> v3:
> - fix missed plic comment
> - made 64bit only for now
> v2:
> - whitespace fixes
> - use g_autofree on plic
> v1:
> - squashed in fixes for sd-card and new qemu init
> - move to spdx for cva6 machine
> - code cleanups missed in first review
>
> updated plic regmap
>
> make cva6 64bit for now
> ---
>  hw/riscv/Kconfig        |  11 ++
>  hw/riscv/cva6.c         | 229 ++++++++++++++++++++++++++++++++++++++++
>  hw/riscv/meson.build    |   1 +
>  include/hw/riscv/cva6.h |  88 +++++++++++++++
>  4 files changed, 329 insertions(+)
>  create mode 100644 hw/riscv/cva6.c
>  create mode 100644 include/hw/riscv/cva6.h
>
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index e6a0ac1fa1..033e29dab1 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -9,6 +9,17 @@ config IBEX
>
>  # RISC-V machines in alphabetical order
>
> +# technically it might be possible to build cva6 32bit
> +config CVA6
> +    bool
> +    default y
> +    depends on RISCV64
> +    select DEVICE_TREE
> +    select SIFIVE_PLIC
> +    select XILINX_SPI
> +    select RISCV_ACLINT
> +    select UNIMP
> +
>  config MICROCHIP_PFSOC
>      bool
>      default y
> diff --git a/hw/riscv/cva6.c b/hw/riscv/cva6.c
> new file mode 100644
> index 0000000000..3adfa8b5cc
> --- /dev/null
> +++ b/hw/riscv/cva6.c
> @@ -0,0 +1,229 @@
> +/*
> + * QEMU RISC-V Board for OpenHW CVA6 SoC
> + *
> + * Copyright (c) 2025 Codethink Ltd
> + * Ben Dooks <ben.dooks@codethink.co.uk>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/error-report.h"
> +#include "qemu/units.h"
> +#include "qapi/error.h"
> +#include "qapi/visitor.h"
> +#include "hw/boards.h"
> +#include "hw/irq.h"
> +#include "hw/loader.h"
> +#include "hw/sysbus.h"
> +#include "hw/misc/unimp.h"
> +
> +#include "hw/sd/sd.h"
> +#include "hw/ssi/ssi.h"
> +
> +#include "hw/riscv/cva6.h"
> +#include "hw/riscv/boot.h"
> +#include "hw/intc/riscv_aclint.h"
> +
> +#include "system/system.h"
> +
> +#include <libfdt.h>
> +
> +#define CVA6_ROM_BASE  0x10000
> +
> +static const MemMapEntry cva6_memmap[] =3D {
> +    [CVA6_DEBUG] =3D              {  0x0000000,  0x1000 },
> +    [CVA6_ROM] =3D                { CVA6_ROM_BASE, 0x10000 },
> +    [CVA6_CLINT] =3D              {  0x2000000, 0xC0000 },
> +    [CVA6_PLIC] =3D               {  0xC000000, 0x4000000 },
> +    [CVA6_UART] =3D               { 0x10000000, 0x1000 },
> +    [CVA6_TIMER] =3D              { 0x18000000, 0x10000 },
> +    [CVA6_SPI] =3D                { 0x20000000, 0x800000 },
> +    [CVA6_ETHERNET] =3D           { 0x30000000, 0x10000 },
> +    [CVA6_GPIO] =3D               { 0x40000000, 0x1000 },
> +    [CVA6_DRAM] =3D               { 0x80000000, 0x40000000 },
> +};
> +
> +static void cva6_machine_init(MachineState *machine)
> +{
> +    MachineClass *mc =3D MACHINE_GET_CLASS(machine);
> +    MemoryRegion *sys_mem =3D get_system_memory();
> +    hwaddr dram_addr =3D cva6_memmap[CVA6_DRAM].base;
> +    CVA6State *s =3D CVA6_MACHINE(machine);
> +    RISCVBootInfo boot_info;
> +
> +    object_initialize_child(OBJECT(machine), "soc", &s->soc, TYPE_RISCV_=
CVA6);
> +    qdev_realize(DEVICE(&s->soc), NULL, &error_fatal);
> +
> +    if (machine->ram_size > mc->default_ram_size) {

This should compare against cva6_memmap[CVA6_DRAM].size instead

> +        error_report("RAM size is too big for DRAM area");
> +        exit(EXIT_FAILURE);
> +    }
> +
> +    memory_region_add_subregion(sys_mem, dram_addr, machine->ram);
> +    riscv_boot_info_init(&boot_info, &s->soc.cpus);
> +
> +    if (machine->firmware) {
> +         hwaddr firmware_load_addr =3D cva6_memmap[CVA6_ROM].base;
> +         riscv_load_firmware(machine->firmware, &firmware_load_addr, NUL=
L);
> +    }
> +
> +     if (machine->kernel_filename) {
> +         /* note - we've not tested just loading the kernel w/o uboot */

I don't think this is a useful comment, users can't see it and it
seems prone to becoming stale.

If you want you can put something like this in the user documentation
(or the wiki page) but it shouldn't be here

> +         riscv_load_kernel(machine, &boot_info, dram_addr, false, NULL);
> +    }
> +
> +}
> +
> +static void cva6_machine_class_init(ObjectClass *oc, const void *data)
> +{
> +    MachineClass *mc =3D MACHINE_CLASS(oc);
> +
> +    mc->desc =3D "RISC-V board for CVA6";
> +    mc->init =3D cva6_machine_init;
> +    mc->max_cpus =3D 1;
> +    mc->default_ram_id =3D "cva6.ram";
> +    /* start with "max" cpu type until we sort out CVA6 type */
> +    mc->default_cpu_type =3D TYPE_RISCV_CPU_MAX;
> +    mc->default_ram_size =3D cva6_memmap[CVA6_DRAM].size;
> +};
> +
> +static void cva6_soc_init(Object *obj)
> +{
> +    CVA6SoCState *s =3D RISCV_CVA6(obj);
> +
> +    object_initialize_child(obj, "cpus", &s->cpus, TYPE_RISCV_HART_ARRAY=
);
> +}
> +
> +static void cva6_add_spi(CVA6SoCState *s, const MemMapEntry *map)
> +{
> +    DriveInfo *dinfo;
> +    BlockBackend *blk;
> +    DeviceState *card_dev;
> +    qemu_irq sd_cs;
> +    DeviceState *sddev;
> +    SysBusDevice *busdev;
> +    DeviceState *spi_dev;
> +    SSIBus *spi;
> +
> +    spi_dev =3D qdev_new("xlnx.xps-spi");
> +    qdev_prop_set_uint8(spi_dev, "num-ss-bits", 1);
> +    qdev_prop_set_string(spi_dev, "endianness", "little");
> +
> +    busdev =3D SYS_BUS_DEVICE(spi_dev);
> +    sysbus_realize_and_unref(busdev, &error_fatal);
> +    sysbus_mmio_map(busdev, 0, map->base);
> +    sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(DEVICE(s->plic), CVA6=
_SPI_IRQ));
> +
> +    spi =3D (SSIBus *)qdev_get_child_bus(spi_dev, "spi");
> +
> +    sddev =3D ssi_create_peripheral(spi, "ssi-sd");
> +    sd_cs =3D qdev_get_gpio_in_named(sddev, SSI_GPIO_CS, 0);
> +    sysbus_connect_irq(busdev, 1, sd_cs);
> +
> +    dinfo =3D drive_get(IF_SD, 0, 0);
> +    blk =3D dinfo ? blk_by_legacy_dinfo(dinfo) : NULL;
> +    card_dev =3D qdev_new(TYPE_SD_CARD_SPI);
> +    qdev_prop_set_drive_err(card_dev, "drive", blk, &error_fatal);
> +
> +    qdev_realize_and_unref(card_dev, qdev_get_child_bus(sddev, "sd-bus")=
, &error_fatal);
> +}
> +
> +static void not_implemented(const char *name, const MemMapEntry *map)
> +{
> +    create_unimplemented_device(name, map->base, map->size);
> +}
> +
> +static void cva6_soc_realize(DeviceState *dev_soc, Error **errp)
> +{
> +    MemoryRegion *system_memory =3D get_system_memory();
> +    MachineState *ms =3D MACHINE(qdev_get_machine());
> +    CVA6SoCState *s =3D RISCV_CVA6(dev_soc);
> +    const MemMapEntry *memmap =3D cva6_memmap;
> +    MemoryRegion *rom =3D g_new(MemoryRegion, 1);
> +    g_autofree char *plic_hart_config;
> +
> +    object_property_set_str(OBJECT(&s->cpus), "cpu-type", ms->cpu_type,
> +                            &error_abort);
> +    object_property_set_int(OBJECT(&s->cpus), "num-harts", ms->smp.cpus,
> +                            &error_abort);
> +    object_property_set_int(OBJECT(&s->cpus), "resetvec", CVA6_ROM_BASE,
> +                            &error_abort);
> +    sysbus_realize(SYS_BUS_DEVICE(&s->cpus), &error_fatal);
> +
> +    /* boot rom */
> +    memory_region_init_rom(rom, OBJECT(dev_soc), "riscv.cva6.bootrom",
> +                           memmap[CVA6_ROM].size, &error_fatal);
> +    memory_region_add_subregion(system_memory, memmap[CVA6_ROM].base,
> +                                rom);
> +
> +    /* create PLIC hart topology configuration string */
> +    plic_hart_config =3D riscv_plic_hart_config_string(ms->smp.cpus);
> +
> +    /* MMIO */
> +    s->plic =3D sifive_plic_create(memmap[CVA6_PLIC].base,
> +        plic_hart_config, ms->smp.cpus, 0,
> +        CVA6_PLIC_NUM_SOURCES,
> +        CVA6_PLIC_NUM_PRIORITIES,
> +        CVA6_PLIC_PRIORITY_BASE,
> +        CVA6_PLIC_PENDING_BASE,
> +        CVA6_PLIC_ENABLE_BASE,
> +        CVA6_PLIC_ENABLE_STRIDE,
> +        CVA6_PLIC_CONTEXT_BASE,
> +        CVA6_PLIC_CONTEXT_STRIDE,
> +        memmap[CVA6_PLIC].size);
> +
> +    riscv_aclint_swi_create(memmap[CVA6_CLINT].base, 0,
> +                            ms->smp.cpus, false);
> +
> +    riscv_aclint_mtimer_create(
> +        memmap[CVA6_CLINT].base + RISCV_ACLINT_SWI_SIZE,
> +        RISCV_ACLINT_DEFAULT_MTIMER_SIZE, 0, ms->smp.cpus,
> +        RISCV_ACLINT_DEFAULT_MTIMECMP, RISCV_ACLINT_DEFAULT_MTIME,
> +        CLINT_TIMEBASE_FREQ, true);
> +
> +    /* something in cva6-sdk uboot seems to prod the debug
> +     * unit by accident, so make it not implemented */

The comment should follow the QEMU code style

https://www.qemu.org/docs/master/devel/style.html#comment-style

> +    not_implemented("debug", &memmap[CVA6_DEBUG]);
> +
> +    /* 16550 uart, one 32bit register per 32bit word */
> +
> +    serial_mm_init(system_memory, memmap[CVA6_UART].base, 2,
> +                   qdev_get_gpio_in(DEVICE(s->plic), CVA6_UART_IRQ),
> +                   50*1000*10000,
> +                   serial_hd(0), DEVICE_LITTLE_ENDIAN);
> +
> +    /* just unimplement the timers, network and gpio here for now.
> +     * no-one seems to be using the apb timer block anyway*/
> +    not_implemented("net", &memmap[CVA6_ETHERNET]);
> +    not_implemented("gpio", &memmap[CVA6_GPIO]);
> +    not_implemented("timer", &memmap[CVA6_TIMER]);
> +
> +    /* connect xilinx spi block here */
> +    cva6_add_spi(s, &memmap[CVA6_SPI]);

Is the SPI really part of the SoC? Usually SPI blocks are part of the
machine/board.

Alistair

> +}
> +
> +static void cva6_soc_class_init(ObjectClass *oc, const void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(oc);
> +
> +    dc->realize =3D cva6_soc_realize;
> +    dc->user_creatable =3D false;
> +};
> +
> +static const TypeInfo cva6_types[] =3D {
> +    {
> +        .name           =3D TYPE_RISCV_CVA6,
> +        .parent         =3D TYPE_DEVICE,
> +        .instance_size  =3D sizeof(CVA6SoCState),
> +        .instance_init  =3D cva6_soc_init,
> +        .class_init     =3D cva6_soc_class_init,
> +    }, {
> +        .name           =3D TYPE_CVA6_MACHINE,
> +        .parent         =3D TYPE_MACHINE,
> +        .instance_size  =3D sizeof(CVA6State),
> +        .class_init     =3D cva6_machine_class_init,
> +    }
> +};
> +
> +DEFINE_TYPES(cva6_types)
> diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
> index c22f3a7216..a32fffab63 100644
> --- a/hw/riscv/meson.build
> +++ b/hw/riscv/meson.build
> @@ -2,6 +2,7 @@ riscv_ss =3D ss.source_set()
>  riscv_ss.add(files('boot.c'))
>  riscv_ss.add(when: 'CONFIG_RISCV_NUMA', if_true: files('numa.c'))
>  riscv_ss.add(files('riscv_hart.c'))
> +riscv_ss.add(when: 'CONFIG_CVA6', if_true: files('cva6.c'))
>  riscv_ss.add(when: 'CONFIG_OPENTITAN', if_true: files('opentitan.c'))
>  riscv_ss.add(when: 'CONFIG_RISCV_VIRT', if_true: files('virt.c'))
>  riscv_ss.add(when: 'CONFIG_SHAKTI_C', if_true: files('shakti_c.c'))
> diff --git a/include/hw/riscv/cva6.h b/include/hw/riscv/cva6.h
> new file mode 100644
> index 0000000000..48e0979a0a
> --- /dev/null
> +++ b/include/hw/riscv/cva6.h
> @@ -0,0 +1,88 @@
> +/*
> + * QEMU RISC-V Board for OpenHW CVA6 SoC
> + * https://github.com/openhwgroup/cva6/tree/master/corev_apu
> + *
> + * Copyright (c) 2025 Codethink Ltd
> + * Ben Dooks <ben.dooks@codethink.co.uk>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_CVA6_H
> +#define HW_CVA6_H
> +
> +#include "hw/riscv/riscv_hart.h"
> +#include "hw/intc/sifive_plic.h"
> +#include "hw/char/serial-mm.h"
> +
> +#include "hw/boards.h"
> +#include "hw/sysbus.h"
> +#include "qom/object.h"
> +
> +#define TYPE_RISCV_CVA6 "riscv.cva6.soc"
> +OBJECT_DECLARE_SIMPLE_TYPE(CVA6SoCState, RISCV_CVA6)
> +
> +typedef struct CVA6SoCState {
> +    /*< private >*/
> +    DeviceState parent_obj;
> +
> +    /*< public >*/
> +    RISCVHartArrayState cpus;
> +    DeviceState *plic;
> +    MemoryRegion rom;
> +
> +    uint32_t resetvec;
> +} CVA6SoCState;
> +
> +#define TYPE_CVA6_MACHINE MACHINE_TYPE_NAME("cva6")
> +OBJECT_DECLARE_SIMPLE_TYPE(CVA6State, CVA6_MACHINE)
> +
> +typedef struct CVA6State {
> +    /*< private >*/
> +    MachineState parent_obj;
> +
> +    /*< public >*/
> +    CVA6SoCState soc;
> +}
> +CVA6State;
> +
> +enum {
> +    CVA6_DEBUG,
> +    CVA6_ROM,
> +    CVA6_CLINT,
> +    CVA6_PLIC,
> +    CVA6_UART,
> +    CVA6_TIMER,
> +    CVA6_SPI,
> +    CVA6_ETHERNET,
> +    CVA6_GPIO,
> +    CVA6_DRAM,
> +};
> +
> +enum {
> +    CVA6_UART_IRQ       =3D 1,
> +    CVA6_SPI_IRQ        =3D 2,
> +    CVA6_ETH_IRQ        =3D 3,
> +    CVA6_TIMER0_OVF_IRQ =3D 4,
> +    CVA6_TIMER0_CMP_IRQ =3D 5,
> +    CVA6_TIMER1_OVF_IRQ =3D 6,
> +    CVA6_TIMER1_CMP_IRQ =3D 7,
> +};
> +
> +#define CLINT_TIMEBASE_FREQ 25000000
> +
> +/*
> + * plic register interface in corev_apu/rv_plic/rtl/plic_regmap.sv
> + * https://github.com/pulp-platform/rv_plic/blob/master/rtl/plic_regmap.=
sv
> +*/
> +
> +#define CVA6_PLIC_NUM_SOURCES           32
> +#define CVA6_PLIC_NUM_PRIORITIES        7
> +#define CVA6_PLIC_PRIORITY_BASE         0x0000
> +#define CVA6_PLIC_PENDING_BASE          0x1000
> +#define CVA6_PLIC_ENABLE_BASE           0x2000
> +#define CVA6_PLIC_ENABLE_STRIDE         0x80
> +#define CVA6_PLIC_CONTEXT_BASE          0x200000
> +#define CVA6_PLIC_CONTEXT_STRIDE        0x1000
> +
> +#endif /* HW_CVA6_H */
> --
> 2.37.2.352.g3c44437643
>
>

