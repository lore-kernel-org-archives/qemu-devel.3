Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C2F4D74957
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 02:56:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5yrs-0005lH-5b; Tue, 29 Oct 2024 22:55:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t5yrg-0005kf-Pu; Tue, 29 Oct 2024 22:55:21 -0400
Received: from mail-vk1-xa35.google.com ([2607:f8b0:4864:20::a35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t5yre-00089g-Dk; Tue, 29 Oct 2024 22:55:20 -0400
Received: by mail-vk1-xa35.google.com with SMTP id
 71dfb90a1353d-51013e05707so1212743e0c.2; 
 Tue, 29 Oct 2024 19:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730256914; x=1730861714; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SOiLdnbNBp/QLSwIISh4RlGRu4Sblzr1MCgttwRjjjo=;
 b=S/TxErbd4ucz4auGIyA+++/kVVBD9FwS03S3WElkIupSxyeT/Hg/GQWbw+Ek0xPxdu
 RfZFPSFwpjjqVFmyl4YbTdULrTGFI2uAmgjSjEVXZDjgi1G4hysT6jl7OsMs+aULy2uA
 84rNX5QhTdxmB00q5AMClyVU1eAlFYsDRzA9vZdcDxH95H01pBEj6IpxNx6YaJO4TGBr
 ZNQaGs2HB78tp4/LYXQ//ROXYqyLm3XfTHMrRIC5ukBWI/Q08lXQbDV60fHBbywiMHgD
 HBYvtCY1Gv2iAdQ0J6IDi99N/y41T7GjlgSZ/2TCGh671mbQ4T16Oa3i8KdH5Bb4m/qg
 V6Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730256914; x=1730861714;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SOiLdnbNBp/QLSwIISh4RlGRu4Sblzr1MCgttwRjjjo=;
 b=ZAbVmxqTyJ0hDypm/x+AYh/zFF8u9ANAs87OtjSpGlIV6LDA60/IDdGP0S5pEPilQJ
 lLlGrgxZVEyrKW7cVvwvhHTImi2AH+5WlQSYDB4mPQ5I0PUuZtIN7mqVXiDB4FDPR9SL
 SyQXq4xBg5UEWArS+C/cW1zFZSsLqa39oWImlTDKR1iAnUBhsjnow/1iJ6yYWNMGfUI5
 P5FmE7sabVu0RBt01jasRxkL3ZzenvbleUsiVRqiV/hEiFWro/Ew/j7b9Gk4q0wFw20I
 PlGLZW9UoQkC/yWIku3b8cWuSB5XfRjrRD5cG8NTQ+H/wXBYe6hki4zJ3z73sA2rPkyN
 Byyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCHevzmYBe/JyK0qwY1K+AyDEzouoLK2V4ssZQ8EID7GTTz7BJlPBZ7ts8q/iiIGbsgkzOhMn23mi3@nongnu.org
X-Gm-Message-State: AOJu0Yxh7B+id1VASE8UPFGpltudc9NKm6ourIHubsnweQxjQUurg05p
 KsZUlQCVJHs6WTCki2IIbJlo3D/j8hG++eQn8bvLbhQs4UZGM1GvzoR88G5a6G9a+Q2VGfm+8gv
 SLOqOWC39UdFNAZILtoVBfujLIuQ=
X-Google-Smtp-Source: AGHT+IFfBOLo47QM/+uEd4a/Rt9rOi4tWKQvjFW1bqBKmVslOv739PJeVZX1ktuW4RG/aTtrjv7dnQxO6CAloAhxBmw=
X-Received: by 2002:a05:6122:3101:b0:50d:35d9:ad55 with SMTP id
 71dfb90a1353d-5101535b2f7mr11379899e0c.13.1730256914241; Tue, 29 Oct 2024
 19:55:14 -0700 (PDT)
MIME-Version: 1.0
References: <20241017072507.4033413-1-sai.pavan.boddu@amd.com>
In-Reply-To: <20241017072507.4033413-1-sai.pavan.boddu@amd.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 30 Oct 2024 12:54:47 +1000
Message-ID: <CAKmqyKNfoakaJ66PCN49x5+=gVkAnQVV1UWTdPe7ARr3RA8ouA@mail.gmail.com>
Subject: Re: [PATCH v2] hw/riscv: Add Microblaze V 32bit virt board
To: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Michal Simek <michal.simek@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a35;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa35.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

On Thu, Oct 17, 2024 at 5:26=E2=80=AFPM Sai Pavan Boddu <sai.pavan.boddu@am=
d.com> wrote:
>
> Add a basic board with interrupt controller (intc), timer, serial
> (uartlite), small memory called LMB@0 (128kB) and DDR@0x80000000
> (configured via command line eg. -m 2g).
> This is basic configuration which matches HW generated out of AMD Vivado
> (design tools). But initial configuration is going beyond what it is
> configured by default because validation should be done on other
> configurations too. That's why wire also additional uart16500, axi
> ethernet(with axi dma).
> GPIOs, i2c and qspi is also listed for completeness.
>
> IRQ map is: (addr)
> 0 - timer (0x41c00000)
> 1 - uartlite (0x40600000)
> 2 - i2c (0x40800000)
> 3 - qspi (0x44a00000)
> 4 - uart16550 (0x44a10000)
> 5 - emaclite (0x40e00000)
> 6 - timer2 (0x41c10000)
> 7 - axi emac (0x40c00000)
> 8 - axi dma (0x41e00000)
> 9 - axi dma
> 10 - gpio (0x40000000)
> 11 - gpio2 (0x40010000)
> 12 - gpio3 (0x40020000)
>
> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> Changes for V2:
>     Make changes to support -cpu switch
>     Remove setting of default board
>     Include doc to toctree
>     Remove setting of 'imac' extensions as they are available by default.
>
>  MAINTAINERS                             |   6 +
>  docs/system/riscv/microblaze-v-virt.rst |  39 +++++
>  docs/system/target-riscv.rst            |   1 +
>  hw/riscv/microblaze-v-virt.c            | 181 ++++++++++++++++++++++++
>  hw/riscv/Kconfig                        |   8 ++
>  hw/riscv/meson.build                    |   1 +
>  6 files changed, 236 insertions(+)
>  create mode 100644 docs/system/riscv/microblaze-v-virt.rst
>  create mode 100644 hw/riscv/microblaze-v-virt.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d7a11fe6017..b104b6d0f7f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1274,6 +1274,12 @@ M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
>  S: Maintained
>  F: hw/microblaze/petalogix_ml605_mmu.c
>
> +amd-microblaze-v-virt

This should probably be more like

"AMD Microblaze-V Virt Board"

Also, this should be with the RISC-V boards

> +M: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
> +S: Maintained
> +F: hw/riscv/microblaze-v-virt.c
> +F: docs/system/riscv/microblaze-v-virt.rst
> +
>  MIPS Machines
>  -------------
>  Overall MIPS Machines
> diff --git a/docs/system/riscv/microblaze-v-virt.rst b/docs/system/riscv/=
microblaze-v-virt.rst
> new file mode 100644
> index 00000000000..d2ad6a60266
> --- /dev/null
> +++ b/docs/system/riscv/microblaze-v-virt.rst
> @@ -0,0 +1,39 @@
> +Microblaze-V virt board (``amd-microblaze-v-virt``)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> +The AMD MicroBlaze=E2=84=A2 V processor is a soft-core RISC-V processor =
IP for AMD adaptive SoCs and FPGAs.
> +The MicroBlaze V processor is based on a 32-bit RISC-V instruction set a=
rchitecture (ISA).
> +
> +More details here:
> +https://docs.amd.com/r/en-US/ug1629-microblaze-v-user-guide/MicroBlaze-V=
-Architecture
> +
> +The microblaze-v virt board in QEMU is a virtual board with
> +following supported devices
> +
> +Implemented CPU cores:
> +
> +1 RISCV32 core

Maybe details on the extensions supported?

> +
> +Implemented devices:
> +
> +    - timer
> +    - uartlite
> +    - uart16550
> +    - emaclite
> +    - timer2
> +    - axi emac
> +    - axi dma
> +
> +Running
> +"""""""
> +Running U-boot
> +
> +.. code-block:: bash
> +
> +
> +   $ qemu-system-riscv32 -M amd-microblaze-v-virt \
> +     -display none \
> +     -device loader,addr=3D0x80000000,file=3Du-boot-spl.bin,cpu-num=3D0 =
\
> +     -device loader,addr=3D0x80200000,file=3Du-boot.img \
> +     -serial mon:stdio \
> +     -device loader,addr=3D0x83000000,file=3Dsystem.dtb \
> +     -m 2g
> diff --git a/docs/system/target-riscv.rst b/docs/system/target-riscv.rst
> index ba195f1518a..cd5c5ce1883 100644
> --- a/docs/system/target-riscv.rst
> +++ b/docs/system/target-riscv.rst
> @@ -66,6 +66,7 @@ undocumented; you can get a complete list by running
>  .. toctree::
>     :maxdepth: 1
>
> +   riscv/microblaze-v-virt
>     riscv/microchip-icicle-kit
>     riscv/shakti-c
>     riscv/sifive_u
> diff --git a/hw/riscv/microblaze-v-virt.c b/hw/riscv/microblaze-v-virt.c
> new file mode 100644
> index 00000000000..6603e6d6b06
> --- /dev/null
> +++ b/hw/riscv/microblaze-v-virt.c
> @@ -0,0 +1,181 @@
> +/*
> + * QEMU model of Microblaze V (32bit version)
> + *
> + * based on hw/microblaze/petalogix_ml605_mmu.c

Just a question, are you sure the virt board should be based on the
petalogix_ml605_mmu?

This will be the reference Microblaze V implementation in QEMU, and
the petalogix_ml605_mmu might be a bit old now. It also uses a lot of
the Microblaze architecture components (like the interrupt controller)
compared to the RISC-V architecture components which might cause
issues for you in the future.

Just something to keep in mind

> + *
> + * Copyright (c) 2011 Michal Simek <monstr@monstr.eu>
> + * Copyright (c) 2011 PetaLogix
> + * Copyright (c) 2009 Edgar E. Iglesias.
> + * Copyright (C) 2024, Advanced Micro Devices, Inc.
> + * SPDX-License-Identifier: GPL-2.0-or-later

I think the SPDX-License-Identifier should be at the top of the file

> + * Written by Sai Pavan Boddu <sai.pavan.boddu@amd.com>
> + *     and by Michal Simek <michal.simek@amd.com>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/units.h"
> +#include "qapi/error.h"
> +#include "cpu.h"
> +#include "hw/sysbus.h"
> +#include "sysemu/sysemu.h"
> +#include "net/net.h"
> +#include "hw/boards.h"
> +#include "hw/char/serial-mm.h"
> +#include "exec/address-spaces.h"
> +#include "hw/char/xilinx_uartlite.h"
> +#include "hw/misc/unimp.h"
> +
> +#define LMB_BRAM_SIZE (128 * KiB)
> +#define MEMORY_BASEADDR 0x80000000
> +#define INTC_BASEADDR 0x41200000
> +#define TIMER_BASEADDR 0x41c00000
> +#define TIMER_BASEADDR2 0x41c10000
> +#define UARTLITE_BASEADDR 0x40600000
> +#define ETHLITE_BASEADDR 0x40e00000
> +#define UART16550_BASEADDR 0x44a10000
> +#define AXIENET_BASEADDR 0x40c00000
> +#define AXIDMA_BASEADDR 0x41e00000
> +#define GPIO_BASEADDR 0x40000000
> +#define GPIO_BASEADDR2 0x40010000
> +#define GPIO_BASEADDR3 0x40020000
> +#define I2C_BASEADDR 0x40800000
> +#define QSPI_BASEADDR 0x44a00000
> +
> +#define TIMER_IRQ           0
> +#define UARTLITE_IRQ        1
> +#define UART16550_IRQ       4
> +#define ETHLITE_IRQ         5
> +#define TIMER_IRQ2          6
> +#define AXIENET_IRQ         7
> +#define AXIDMA_IRQ1         8
> +#define AXIDMA_IRQ0         9
> +
> +static void mb_v_virt_init(MachineState *machine)
> +{
> +    ram_addr_t ram_size =3D machine->ram_size;
> +    DeviceState *dev, *dma, *eth0;
> +    Object *ds, *cs;
> +    int i;
> +    RISCVCPU *cpu;
> +    hwaddr ddr_base =3D MEMORY_BASEADDR;
> +    MemoryRegion *phys_lmb_bram =3D g_new(MemoryRegion, 1);
> +    MemoryRegion *phys_ram =3D g_new(MemoryRegion, 1);
> +    qemu_irq irq[32];
> +    MemoryRegion *sysmem =3D get_system_memory();
> +
> +    cpu =3D RISCV_CPU(object_new(machine->cpu_type));
> +    qdev_realize(DEVICE(cpu), NULL, &error_abort);
> +    /* Attach emulated BRAM through the LMB.  */
> +    memory_region_init_ram(phys_lmb_bram, NULL,
> +                           "mb_v.lmb_bram", LMB_BRAM_SIZE,
> +                           &error_fatal);
> +    memory_region_add_subregion(sysmem, 0x00000000, phys_lmb_bram);
> +
> +    memory_region_init_ram(phys_ram, NULL, "mb_v.ram",
> +                           ram_size, &error_fatal);
> +    memory_region_add_subregion(sysmem, ddr_base, phys_ram);
> +
> +    dev =3D qdev_new("xlnx.xps-intc");
> +    qdev_prop_set_uint32(dev, "kind-of-intr",
> +                         1 << UARTLITE_IRQ);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, INTC_BASEADDR);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
> +                       qdev_get_gpio_in(DEVICE(cpu), 11));
> +    for (i =3D 0; i < 32; i++) {
> +        irq[i] =3D qdev_get_gpio_in(dev, i);
> +    }
> +
> +    /* Uartlite */
> +    dev =3D qdev_new(TYPE_XILINX_UARTLITE);
> +    qdev_prop_set_chr(dev, "chardev", serial_hd(0));
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, UARTLITE_BASEADDR);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[UARTLITE_IRQ]);
> +
> +    /* Full uart */
> +    serial_mm_init(sysmem, UART16550_BASEADDR + 0x1000, 2,
> +                   irq[UART16550_IRQ], 115200, serial_hd(1),
> +                   DEVICE_LITTLE_ENDIAN);
> +
> +    /* 2 timers at irq 0 @ 100 Mhz.  */
> +    dev =3D qdev_new("xlnx.xps-timer");
> +    qdev_prop_set_uint32(dev, "one-timer-only", 0);
> +    qdev_prop_set_uint32(dev, "clock-frequency", 100000000);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, TIMER_BASEADDR);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[TIMER_IRQ]);
> +
> +    /* 2 timers at irq 3 @ 100 Mhz.  */
> +    dev =3D qdev_new("xlnx.xps-timer");
> +    qdev_prop_set_uint32(dev, "one-timer-only", 0);
> +    qdev_prop_set_uint32(dev, "clock-frequency", 100000000);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, TIMER_BASEADDR2);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[TIMER_IRQ2]);
> +
> +    /* Emaclite */
> +    dev =3D qdev_new("xlnx.xps-ethernetlite");
> +    qemu_configure_nic_device(dev, true, NULL);
> +    qdev_prop_set_uint32(dev, "tx-ping-pong", 0);
> +    qdev_prop_set_uint32(dev, "rx-ping-pong", 0);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, ETHLITE_BASEADDR);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[ETHLITE_IRQ]);
> +
> +    /* axi ethernet and dma initialization. */
> +    eth0 =3D qdev_new("xlnx.axi-ethernet");
> +    dma =3D qdev_new("xlnx.axi-dma");
> +
> +    /* FIXME: attach to the sysbus instead */
> +    object_property_add_child(qdev_get_machine(), "xilinx-eth", OBJECT(e=
th0));
> +    object_property_add_child(qdev_get_machine(), "xilinx-dma", OBJECT(d=
ma));
> +
> +    ds =3D object_property_get_link(OBJECT(dma),
> +                                  "axistream-connected-target", NULL);
> +    cs =3D object_property_get_link(OBJECT(dma),
> +                                  "axistream-control-connected-target", =
NULL);
> +    qemu_configure_nic_device(eth0, true, NULL);
> +    qdev_prop_set_uint32(eth0, "rxmem", 0x1000);
> +    qdev_prop_set_uint32(eth0, "txmem", 0x1000);
> +    object_property_set_link(OBJECT(eth0), "axistream-connected", ds,
> +                             &error_abort);
> +    object_property_set_link(OBJECT(eth0), "axistream-control-connected"=
, cs,
> +                             &error_abort);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(eth0), &error_fatal);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(eth0), 0, AXIENET_BASEADDR);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(eth0), 0, irq[AXIENET_IRQ]);
> +
> +    ds =3D object_property_get_link(OBJECT(eth0),
> +                                  "axistream-connected-target", NULL);
> +    cs =3D object_property_get_link(OBJECT(eth0),
> +                                  "axistream-control-connected-target", =
NULL);
> +    qdev_prop_set_uint32(dma, "freqhz", 100000000);
> +    object_property_set_link(OBJECT(dma), "axistream-connected", ds,
> +                             &error_abort);
> +    object_property_set_link(OBJECT(dma), "axistream-control-connected",=
 cs,
> +                             &error_abort);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dma), &error_fatal);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dma), 0, AXIDMA_BASEADDR);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(dma), 0, irq[AXIDMA_IRQ0]);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(dma), 1, irq[AXIDMA_IRQ1]);
> +
> +    /* unimplemented devices */
> +    create_unimplemented_device("gpio", GPIO_BASEADDR, 0x10000);
> +    create_unimplemented_device("gpio2", GPIO_BASEADDR2, 0x10000);
> +    create_unimplemented_device("gpio3", GPIO_BASEADDR3, 0x10000);
> +    create_unimplemented_device("i2c", I2C_BASEADDR, 0x10000);
> +    create_unimplemented_device("qspi", QSPI_BASEADDR, 0x10000);
> +}
> +
> +static void mb_v_virt_machine_init(MachineClass *mc)
> +{
> +    mc->desc =3D "AMD Microblaze-V Virt platform";
> +    mc->init =3D mb_v_virt_init;
> +    mc->min_cpus =3D 1;
> +    mc->max_cpus =3D 1;
> +    mc->default_cpu_type =3D TYPE_RISCV_CPU_BASE32;
> +    mc->default_cpus =3D 1;
> +}
> +
> +DEFINE_MACHINE("amd-microblaze-v-virt", mb_v_virt_machine_init)
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index 44695ff9f2c..5424803a82e 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -22,6 +22,14 @@ config MICROCHIP_PFSOC
>      select SIFIVE_PLIC
>      select UNIMP
>
> +config MICROBLAZE_V
> +    bool
> +    default y
> +    depends on RISCV32
> +    select XILINX
> +    select XILINX_AXI
> +    select XILINX_ETHLITE
> +
>  config OPENTITAN
>      bool
>      default y
> diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
> index f872674093a..8ea0412a376 100644
> --- a/hw/riscv/meson.build
> +++ b/hw/riscv/meson.build
> @@ -10,5 +10,6 @@ riscv_ss.add(when: 'CONFIG_SIFIVE_U', if_true: files('s=
ifive_u.c'))
>  riscv_ss.add(when: 'CONFIG_SPIKE', if_true: files('spike.c'))
>  riscv_ss.add(when: 'CONFIG_MICROCHIP_PFSOC', if_true: files('microchip_p=
fsoc.c'))
>  riscv_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
> +riscv_ss.add(when: 'CONFIG_MICROBLAZE_V', if_true: files('microblaze-v-v=
irt.c'))
>
>  hw_arch +=3D {'riscv': riscv_ss}
> --
> 2.34.1
>
>

