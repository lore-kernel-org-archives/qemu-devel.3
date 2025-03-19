Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7033C35FF1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 04:17:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tukrX-00059D-I8; Wed, 19 Mar 2025 00:17:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tukrU-00058Q-0X; Wed, 19 Mar 2025 00:17:00 -0400
Received: from mail-ua1-x931.google.com ([2607:f8b0:4864:20::931])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tukrR-0005Xg-K4; Wed, 19 Mar 2025 00:16:59 -0400
Received: by mail-ua1-x931.google.com with SMTP id
 a1e0cc1a2514c-86b9ea43955so2794627241.2; 
 Tue, 18 Mar 2025 21:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742357816; x=1742962616; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wlOVB5WPqJhpxlKhXTunoUt8pM2lCjNiaQVwZ8ohngk=;
 b=gIFb7dy7JgyNkt5Zgmy0rYqk1KxGySQyaGCrr7DBX8J24zbdWaLCPVQh6fgWoYOmdO
 X0ArRTy2wuEMrrWIBWGg6p4KWtFFhPp5oPjJT5fMmmbPgujY0Vup5bXmMNEMxGotGJFS
 DPjdI7fl+6T056Qor5Y+DzY55TR7GQPNN9DuJOR2NyjCtI49TWwoeHy0XoFI1WTPCf72
 EFfjILH9rFp/1YIdHetfT/IrLpvJDMbPLdTtn7OjZViGejxmeHsLC0FMTvchwbGqKzP7
 v7cZxd5oNlbtd5iHnbKAErGrLhSoLQcHcp2OXuorDqg9iCOz6g3FyKOxBpcRAJlQHv6C
 h7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742357816; x=1742962616;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wlOVB5WPqJhpxlKhXTunoUt8pM2lCjNiaQVwZ8ohngk=;
 b=BigZ3G4ura+OXSqffyg8xHaeXcoU/MfUxl0qOWgEG7gZkxZ9W8jKAwOKvng3nFA1P3
 V6qEoYj7bsuFdyNqNPP6MJD/2lv40qvgpw89ubr8QtjPpGmSNMR8mATm4YwH4uDP81AF
 FAtoaH7K+F7HOzTe+IVPPSXlzAOuWQIxLFc0207iewv+0WbBULe+rS4l8IQV+TGpZV5k
 Fuj5s8eDFrjT61mNjjPqXajxb7U+P+CWCPWMvJowwN8XvJilyWM0ZfbpKcs0Maoo2FyB
 LSARVY2Z34EYRX27Ph9BYrf4USJTGnYI/7VB8Vb/hhdwOKwdorTTQH/oIgddj9oOtCSo
 21VQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnd1tH+3X4wwyW4icgPIQDVukdPBEdW9CwQ1bkBkdHipTyhX7JFz0pIvO6pAQmfrr0cgfstkfeT2oj@nongnu.org
X-Gm-Message-State: AOJu0Yx3kECITfp8p7qWwKMyYLl3P7FtN61jQF2d+n4IdLd4p5GXJF/t
 KMThZaOeViK6Yb+EETa+KlIl3b9rrzIUba8h7j21uNECbRFLnDT+B109D0HRnZOSOBN3LfJkzzN
 5mm2hx9mwt1Wzyz60GyQoMlzS2j0=
X-Gm-Gg: ASbGnctqwFHuS80pbl5x/zzWkAto+dPY4oZ1/PX6ky4k+2atoUK7pn2nEVMKKuEzX3C
 6ogfQ30MO/xCG1aHrHwo1+VxGwgtGgub5GqSoy19xRAmTvE0kI7vPi7Lf4HmS4LxhRQ30XzeWEY
 bzPTfl5kEAD54NGJbn89sjlKi434niJh8hN9GXgi9LJfuJvpCy6NljkSQ=
X-Google-Smtp-Source: AGHT+IGUtwTK+L6xwIdn+7QXzEWBaLda8zRCr77g6LDvyDMF0/jeEIOFVkgzoVLzSriJ0DLi1FQayBY9AgQkThh427I=
X-Received: by 2002:a05:6102:512b:b0:4ba:971a:41fd with SMTP id
 ada2fe7eead31-4c4ec827919mr835618137.19.1742357815655; Tue, 18 Mar 2025
 21:16:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250319021626.11646-1-huangborong@bosc.ac.cn>
In-Reply-To: <20250319021626.11646-1-huangborong@bosc.ac.cn>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 19 Mar 2025 14:16:29 +1000
X-Gm-Features: AQ5f1JpbhcrF6HtcTtYxCMwlgrEUheywo6rV8Q_HaewgpOV2lu4ajd9zFN78dsA
Message-ID: <CAKmqyKP7uykMOoJOe5gdydvjOvcM+wCSoyeVrneHks5CeSjL=Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] hw/riscv: initial support for BOSC's Xiangshan
 Kunminghu SoC
To: Huang Borong <huangborong@bosc.ac.cn>
Cc: qemu-riscv@nongnu.org, pbonzini@redhat.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com, liwei1518@gmail.com, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::931;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x931.google.com
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

On Wed, Mar 19, 2025 at 12:22=E2=80=AFPM Huang Borong <huangborong@bosc.ac.=
cn> wrote:
>
> This implementation provides emulation for the Xiangshan Kunminghu SoC,
> including support for UART, CLINT, IMSIC, and APLIC devices.
> More details can be found at
> https://github.com/OpenXiangShan/XiangShan

Can you add an entry to `docs/system/riscv/` documenting the new machine.

Also, the commit message describes this patch as adding the SoC, but
it's actually adding a machine (and a SoC, but mostly a machine).

>
> Please note the following parameters when running the Xiangshan Kunminghu=
 machine:
> 1.`-m`: Configure RAM size of the machine.
> 1.`-cpu`: Only the `xiangshan-kunminghu` type is acceptable.
> 2.`-smp`: Specify the number of harts, ranging from 1 to 16.
> 3.`-bios`: This is the only parameter accepted by the Xiangshan Kunminghu=
 machine
>   to obtain the boot image. You need to compile and link the firmware, ke=
rnel,
>   and Device Tree (FDT) into a single binary file, such as `fw_payload.bi=
n`.

Why have this limitation?

>
> Signed-off-by: qinshaoqing <qinshaoqing@bosc.ac.cn>
> Signed-off-by: Yang Wang <wangyang@bosc.ac.cn>
> Signed-off-by: Yu Hu <huyu@bosc.ac.cn>
> Signed-off-by: Ran Wang <wangran@bosc.ac.cn>
> Signed-off-by: Borong Huang <huangborong@bosc.ac.cn>
> ---
>  configs/devices/riscv64-softmmu/default.mak |   1 +
>  hw/riscv/Kconfig                            |   9 +
>  hw/riscv/meson.build                        |   1 +
>  hw/riscv/xiangshan_kmh.c                    | 214 ++++++++++++++++++++
>  include/hw/riscv/xiangshan_kmh.h            |  77 +++++++
>  5 files changed, 302 insertions(+)
>  create mode 100644 hw/riscv/xiangshan_kmh.c
>  create mode 100644 include/hw/riscv/xiangshan_kmh.h
>
> diff --git a/configs/devices/riscv64-softmmu/default.mak b/configs/device=
s/riscv64-softmmu/default.mak
> index 39ed3a0061..e485bbd1a3 100644
> --- a/configs/devices/riscv64-softmmu/default.mak
> +++ b/configs/devices/riscv64-softmmu/default.mak
> @@ -11,3 +11,4 @@
>  # CONFIG_RISCV_VIRT=3Dn
>  # CONFIG_MICROCHIP_PFSOC=3Dn
>  # CONFIG_SHAKTI_C=3Dn
> +# CONFIG_XIANGSHAN_KUNMINGHU=3Dn
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index e6a0ac1fa1..fc9c35bd98 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -119,3 +119,12 @@ config SPIKE
>      select HTIF
>      select RISCV_ACLINT
>      select SIFIVE_PLIC
> +
> +config XIANGSHAN_KUNMINGHU
> +    bool
> +    default y
> +    depends on RISCV64
> +    select RISCV_ACLINT
> +    select RISCV_APLIC
> +    select RISCV_IMSIC
> +    select SERIAL_MM
> diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
> index c22f3a7216..2a8d5b136c 100644
> --- a/hw/riscv/meson.build
> +++ b/hw/riscv/meson.build
> @@ -13,5 +13,6 @@ riscv_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-=
acpi-build.c'))
>  riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files(
>         'riscv-iommu.c', 'riscv-iommu-pci.c', 'riscv-iommu-sys.c', 'riscv=
-iommu-hpm.c'))
>  riscv_ss.add(when: 'CONFIG_MICROBLAZE_V', if_true: files('microblaze-v-g=
eneric.c'))
> +riscv_ss.add(when: 'CONFIG_XIANGSHAN_KUNMINGHU', if_true: files('xiangsh=
an_kmh.c'))
>
>  hw_arch +=3D {'riscv': riscv_ss}
> diff --git a/hw/riscv/xiangshan_kmh.c b/hw/riscv/xiangshan_kmh.c
> new file mode 100644
> index 0000000000..c64b7fc2c7
> --- /dev/null
> +++ b/hw/riscv/xiangshan_kmh.c
> @@ -0,0 +1,214 @@
> +/*
> + * Xiangshan Kunminghu SoC emulation
> + *
> + * Copyright (c) 2025 Beijing Institute of Open Source Chip (BOSC)
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Provides a board compatible with the Xiangshan Kunminghu SoC platform=
:

Can you link to the platform documentation here?

Alistair

> + *
> + * 0) UART (16550A)
> + * 1) CLINT (Core-Local Interruptor)
> + * 2) IMSIC (Incoming MSI Controller)
> + * 3) APLIC (Advanced Platform-Level Interrupt Controller)
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOU=
T
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "exec/address-spaces.h"
> +#include "hw/boards.h"
> +#include "hw/char/serial-mm.h"
> +#include "hw/intc/riscv_aclint.h"
> +#include "hw/intc/riscv_aplic.h"
> +#include "hw/intc/riscv_imsic.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/riscv/boot.h"
> +#include "hw/riscv/xiangshan_kmh.h"
> +#include "hw/riscv/riscv_hart.h"
> +#include "system/system.h"
> +
> +static const MemMapEntry xiangshan_kmh_memmap[] =3D {
> +    [XIANGSHAN_KMH_ROM] =3D          {     0x1000,        0xF000 },
> +    [XIANGSHAN_KMH_UART0] =3D        { 0x310B0000,       0x10000 },
> +    [XIANGSHAN_KMH_CLINT] =3D        { 0x38000000,       0x10000 },
> +    [XIANGSHAN_KMH_APLIC_M] =3D      { 0x31100000,        0x4000 },
> +    [XIANGSHAN_KMH_APLIC_S] =3D      { 0x31120000,        0x4000 },
> +    [XIANGSHAN_KMH_IMSIC_M] =3D      { 0x3A800000,       0x10000 },
> +    [XIANGSHAN_KMH_IMSIC_S] =3D      { 0x3B000000,       0x80000 },
> +    [XIANGSHAN_KMH_DRAM] =3D         { 0x80000000,           0x0 },
> +};
> +
> +static DeviceState *xiangshan_kmh_create_aia(uint32_t num_harts)
> +{
> +    int i;
> +    const MemMapEntry *memmap =3D xiangshan_kmh_memmap;
> +    hwaddr addr =3D 0;
> +    DeviceState *aplic_m =3D NULL;
> +
> +    /* M-level IMSICs */
> +    addr =3D memmap[XIANGSHAN_KMH_IMSIC_M].base;
> +    for (i =3D 0; i < num_harts; i++) {
> +        riscv_imsic_create(addr + i * IMSIC_HART_SIZE(0), i, true,
> +                           1, XIANGSHAN_KMH_IMSIC_NUM_IDS);
> +    }
> +
> +    /* S-level IMSICs */
> +    addr =3D memmap[XIANGSHAN_KMH_IMSIC_S].base;
> +    for (i =3D 0; i < num_harts; i++) {
> +        riscv_imsic_create(addr +
> +                           i * IMSIC_HART_SIZE(XIANGSHAN_KMH_IMSIC_GUEST=
_BITS),
> +                           i, false, 1 + XIANGSHAN_KMH_IMSIC_GUEST_BITS,
> +                           XIANGSHAN_KMH_IMSIC_NUM_IDS);
> +    }
> +
> +    /* M-level APLIC */
> +    aplic_m =3D riscv_aplic_create(memmap[XIANGSHAN_KMH_APLIC_M].base,
> +                                 memmap[XIANGSHAN_KMH_APLIC_M].size,
> +                                 0, 0, XIANGSHAN_KMH_APLIC_NUM_SOURCES,
> +                                 1, true, true, NULL);
> +
> +    /* S-level APLIC */
> +    riscv_aplic_create(memmap[XIANGSHAN_KMH_APLIC_S].base,
> +                       memmap[XIANGSHAN_KMH_APLIC_S].size,
> +                       0, 0, XIANGSHAN_KMH_APLIC_NUM_SOURCES,
> +                       1, true, false, aplic_m);
> +
> +    return aplic_m;
> +}
> +
> +static void xiangshan_kmh_soc_realize(DeviceState *dev, Error **errp)
> +{
> +    MachineState *ms =3D MACHINE(qdev_get_machine());
> +    XiangshanKmhSoCState *s =3D XIANGSHAN_KMH_SOC(dev);
> +    const MemMapEntry *memmap =3D xiangshan_kmh_memmap;
> +    MemoryRegion *system_memory =3D get_system_memory();
> +    uint32_t num_harts =3D ms->smp.cpus;
> +
> +    qdev_prop_set_uint32(DEVICE(&s->cpus), "num-harts", num_harts);
> +    qdev_prop_set_uint32(DEVICE(&s->cpus), "hartid-base", 0);
> +    qdev_prop_set_string(DEVICE(&s->cpus), "cpu-type",
> +                         TYPE_RISCV_CPU_XIANGSHAN_KMH);
> +    sysbus_realize(SYS_BUS_DEVICE(&s->cpus), &error_fatal);
> +
> +    /* AIA */
> +    s->irqchip =3D xiangshan_kmh_create_aia(num_harts);
> +
> +    /* UART */
> +    serial_mm_init(system_memory, memmap[XIANGSHAN_KMH_UART0].base, 2,
> +                   qdev_get_gpio_in(s->irqchip, XIANGSHAN_KMH_UART0_IRQ)=
,
> +                   115200, serial_hd(0), DEVICE_LITTLE_ENDIAN);
> +
> +    /* CLINT */
> +    riscv_aclint_swi_create(memmap[XIANGSHAN_KMH_CLINT].base,
> +                            0, num_harts, false);
> +    riscv_aclint_mtimer_create(memmap[XIANGSHAN_KMH_CLINT].base +
> +                               RISCV_ACLINT_SWI_SIZE,
> +                               RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
> +                               0, num_harts, RISCV_ACLINT_DEFAULT_MTIMEC=
MP,
> +                               RISCV_ACLINT_DEFAULT_MTIME,
> +                               XIANGSHAN_KMH_CLINT_TIMEBASE_FREQ, true);
> +
> +    /* ROM */
> +    memory_region_init_rom(&s->rom, OBJECT(dev), "xiangshan.kunminghu.ro=
m",
> +                           memmap[XIANGSHAN_KMH_ROM].size, &error_fatal)=
;
> +    memory_region_add_subregion(system_memory,
> +                                memmap[XIANGSHAN_KMH_ROM].base, &s->rom)=
;
> +}
> +
> +static void xiangshan_kmh_soc_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    dc->realize =3D xiangshan_kmh_soc_realize;
> +    dc->user_creatable =3D false;
> +}
> +
> +static void xiangshan_kmh_soc_instance_init(Object *obj)
> +{
> +    XiangshanKmhSoCState *s =3D XIANGSHAN_KMH_SOC(obj);
> +
> +    object_initialize_child(obj, "cpus", &s->cpus, TYPE_RISCV_HART_ARRAY=
);
> +}
> +
> +static const TypeInfo xiangshan_kmh_soc_info =3D {
> +    .name =3D TYPE_XIANGSHAN_KMH_SOC,
> +    .parent =3D TYPE_DEVICE,
> +    .instance_size =3D sizeof(XiangshanKmhSoCState),
> +    .instance_init =3D xiangshan_kmh_soc_instance_init,
> +    .class_init =3D xiangshan_kmh_soc_class_init,
> +};
> +
> +static void xiangshan_kmh_soc_register_types(void)
> +{
> +    type_register_static(&xiangshan_kmh_soc_info);
> +}
> +type_init(xiangshan_kmh_soc_register_types)
> +
> +static void xiangshan_kmh_machine_init(MachineState *machine)
> +{
> +    XiangshanKmhState *s =3D XIANGSHAN_KMH_MACHINE(machine);
> +    const MemMapEntry *memmap =3D xiangshan_kmh_memmap;
> +    MemoryRegion *system_memory =3D get_system_memory();
> +    hwaddr start_addr =3D memmap[XIANGSHAN_KMH_DRAM].base;
> +
> +    /* Initialize SoC */
> +    object_initialize_child(OBJECT(machine), "soc", &s->soc,
> +                            TYPE_XIANGSHAN_KMH_SOC);
> +    qdev_realize(DEVICE(&s->soc), NULL, &error_fatal);
> +
> +    /* Register RAM */
> +    memory_region_add_subregion(system_memory,
> +                                memmap[XIANGSHAN_KMH_DRAM].base,
> +                                machine->ram);
> +
> +    /* ROM reset vector */
> +    riscv_setup_rom_reset_vec(machine, &s->soc.cpus,
> +                              start_addr,
> +                              memmap[XIANGSHAN_KMH_ROM].base,
> +                              memmap[XIANGSHAN_KMH_ROM].size, 0, 0);
> +    if (machine->firmware) {
> +        riscv_load_firmware(machine->firmware, &start_addr, NULL);
> +    }
> +
> +    /* Note: dtb has been integrated into firmware(OpenSBI) when compili=
ng */
> +}
> +
> +static void xiangshan_kmh_machine_class_init(ObjectClass *klass, void *d=
ata)
> +{
> +    MachineClass *mc =3D MACHINE_CLASS(klass);
> +    static const char *const valid_cpu_types[] =3D {
> +        TYPE_RISCV_CPU_XIANGSHAN_KMH,
> +        NULL
> +    };
> +
> +    mc->desc =3D "RISC-V Board compatible with Xiangshan Kunminghu SoC p=
latform";
> +    mc->init =3D xiangshan_kmh_machine_init;
> +    mc->max_cpus =3D XIANGSHAN_KMH_MAX_CPUS;
> +    mc->default_cpu_type =3D TYPE_RISCV_CPU_XIANGSHAN_KMH;
> +    mc->valid_cpu_types =3D valid_cpu_types;
> +    mc->default_ram_id =3D "xiangshan.kunminghu.ram";
> +}
> +
> +static const TypeInfo xiangshan_kmh_machine_info =3D {
> +    .name =3D TYPE_XIANGSHAN_KMH_MACHINE,
> +    .parent =3D TYPE_MACHINE,
> +    .instance_size =3D sizeof(XiangshanKmhState),
> +    .class_init =3D xiangshan_kmh_machine_class_init,
> +};
> +
> +static void xiangshan_kmh_machine_register_types(void)
> +{
> +    type_register_static(&xiangshan_kmh_machine_info);
> +}
> +type_init(xiangshan_kmh_machine_register_types)
> diff --git a/include/hw/riscv/xiangshan_kmh.h b/include/hw/riscv/xiangsha=
n_kmh.h
> new file mode 100644
> index 0000000000..41ce1eb69e
> --- /dev/null
> +++ b/include/hw/riscv/xiangshan_kmh.h
> @@ -0,0 +1,77 @@
> +/*
> + * Xiangshan Kunminghu SoC emulation
> + *
> + * Copyright (c) 2025 Beijing Institute of Open Source Chip (BOSC)
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOU=
T
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef HW_XIANGSHAN_KMH_H
> +#define HW_XIANGSHAN_KMH_H
> +
> +#include "hw/boards.h"
> +#include "hw/riscv/riscv_hart.h"
> +
> +#define XIANGSHAN_KMH_MAX_CPUS 16
> +
> +typedef struct XiangshanKmhSoCState {
> +    /*< private >*/
> +    DeviceState parent_obj;
> +
> +    /*< public >*/
> +    RISCVHartArrayState cpus;
> +    DeviceState *irqchip;
> +    MemoryRegion rom;
> +} XiangshanKmhSoCState;
> +
> +#define TYPE_XIANGSHAN_KMH_SOC "xiangshan.kunminghu.soc"
> +DECLARE_INSTANCE_CHECKER(XiangshanKmhSoCState, XIANGSHAN_KMH_SOC,
> +                         TYPE_XIANGSHAN_KMH_SOC)
> +
> +typedef struct XiangshanKmhState {
> +    /*< private >*/
> +    MachineState parent_obj;
> +
> +    /*< public >*/
> +    XiangshanKmhSoCState soc;
> +} XiangshanKmhState;
> +
> +#define TYPE_XIANGSHAN_KMH_MACHINE MACHINE_TYPE_NAME("xiangshan-kunmingh=
u")
> +DECLARE_INSTANCE_CHECKER(XiangshanKmhState, XIANGSHAN_KMH_MACHINE,
> +                         TYPE_XIANGSHAN_KMH_MACHINE)
> +
> +enum {
> +    XIANGSHAN_KMH_ROM,
> +    XIANGSHAN_KMH_UART0,
> +    XIANGSHAN_KMH_CLINT,
> +    XIANGSHAN_KMH_APLIC_M,
> +    XIANGSHAN_KMH_APLIC_S,
> +    XIANGSHAN_KMH_IMSIC_M,
> +    XIANGSHAN_KMH_IMSIC_S,
> +    XIANGSHAN_KMH_DRAM,
> +};
> +
> +enum {
> +    XIANGSHAN_KMH_UART0_IRQ =3D 10,
> +};
> +
> +/* Indicating Timebase-freq (1MHZ) */
> +#define XIANGSHAN_KMH_CLINT_TIMEBASE_FREQ 1000000
> +
> +#define XIANGSHAN_KMH_IMSIC_NUM_IDS 255
> +#define XIANGSHAN_KMH_IMSIC_NUM_GUESTS 7
> +#define XIANGSHAN_KMH_IMSIC_GUEST_BITS 3
> +
> +#define XIANGSHAN_KMH_APLIC_NUM_SOURCES 96
> +
> +#endif
> --
> 2.34.1
>
>

