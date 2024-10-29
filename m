Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A638CD3A661
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 15:45:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5oOi-0002CR-QI; Tue, 29 Oct 2024 11:44:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1t5oOg-00029F-Q0; Tue, 29 Oct 2024 11:44:42 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1t5oOd-0003T5-7C; Tue, 29 Oct 2024 11:44:42 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2fb470a8b27so59619121fa.1; 
 Tue, 29 Oct 2024 08:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730216676; x=1730821476; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GUuXeBwtRSCi/wB1l3gh3uVbCAyJYgngbocT4ORaf5w=;
 b=G5UWjKlSoPaYHNtlZn++jvU1CRNAo/FlMLyyCuemAlYC+zjcfzgdM/3uKyzPqbrBir
 vnN4vNA7UcILHozSTaZ2PbK4Ps4k9GHmD/3hQ3yFMSi5586kjJjkucR9HUSqcBSX5dBU
 xbylr1sCgsD8bhIbzl0KOMcwCVyyv14dkQ8tMFAzzr1b4QPrjFTvhCAb87vFnAKctqlI
 uu7X4FvE8Hd39H5Smc2FpJQAX4y0N5kJ7DPFH7ypafAJPG/oxk4VGlgGy5d0q1FDyfwh
 A1lDYUOiTtAfPBCHQZ9l+unx9+q8Vs2F+BlvucxUVTW9fWpPDvfufgiX7E6cq8lx84z7
 OnWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730216676; x=1730821476;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GUuXeBwtRSCi/wB1l3gh3uVbCAyJYgngbocT4ORaf5w=;
 b=W9T01DQmBppubFgeE/cnMGyRC6qAiSmkF3RZy6lrFUtKarZLJ6TGJfiFU1FBYCE3L6
 tDvLTEioNMQ1emhRB4w/Gmo+VfcLZgKhLw94P0ZdA5GMAiWLllh8+eZN5bEc5Tc7xgGI
 AcdgU85+lsKjLkk1rxcT6HofG1x+R0sYu92kyxp6f7e2qUAR6Fgt7yyXS/HmOBszqboH
 H17GLfjl39VvAEuiI/+XEj5yMDXdQwOCal8Grb3RS7Nj7kclT1CCCgm2DMjgnl52Ac82
 pT4aD06rBOWR6eLwlDpyA/1JfIIrDUBARoYyKNWV9g3Gc7wFSdMoBBcwK6/9/NKX3aEl
 Vp3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9+nkCcnk7u6zUvNWCWK3/grMOcOH9H2fVFwb7oMTMGdyXwripmszw+Ap+9tnq2rdmbyJTtcWQiSJa@nongnu.org
X-Gm-Message-State: AOJu0Ywe3uRM/OCRKypHvzWY5buT3Jr1Hwp611zoYxhD/neKsbcQgPWh
 9Nxyil66w9C6XJwUK6G5aZXD+2sQHKC4hg7T3a+W/N9y44Rv1qWx
X-Google-Smtp-Source: AGHT+IHIc4lAop81hSpE2zNgFTVYgb/MnB7sfm7vAK9BNpreHxFsigPzzLPY3PUXeM8PGPFAvAO/Nw==
X-Received: by 2002:a05:651c:1504:b0:2fb:579a:fff with SMTP id
 38308e7fff4ca-2fcdc7891e4mr6832181fa.8.1730216675483; 
 Tue, 29 Oct 2024 08:44:35 -0700 (PDT)
Received: from fralle-dell (217-76-87-122.cust.bredband2.com. [217.76.87.122])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2fcb45d1adfsm15578721fa.88.2024.10.29.08.44.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 08:44:33 -0700 (PDT)
Date: Tue, 29 Oct 2024 15:44:30 +0000
From: Francisco Iglesias <frasse.iglesias@gmail.com>
To: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH v2] hw/riscv: Add Microblaze V 32bit virt board
Message-ID: <ZyEC3qFBcbMF4vDH@fralle-dell>
References: <20241017072507.4033413-1-sai.pavan.boddu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241017072507.4033413-1-sai.pavan.boddu@amd.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=frasse.iglesias@gmail.com; helo=mail-lj1-x232.google.com
X-Spam_score_int: -1020
X-Spam_score: -102.1
X-Spam_bar: ---------------------------------------------------
X-Spam_report: (-102.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_WELCOMELIST=-0.01, USER_IN_WHITELIST=-100,
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

On [2024 Oct 17] Thu 12:55:07, Sai Pavan Boddu wrote:
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

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>


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
> +M: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
> +S: Maintained
> +F: hw/riscv/microblaze-v-virt.c
> +F: docs/system/riscv/microblaze-v-virt.rst
> +
>  MIPS Machines
>  -------------
>  Overall MIPS Machines
> diff --git a/docs/system/riscv/microblaze-v-virt.rst b/docs/system/riscv/microblaze-v-virt.rst
> new file mode 100644
> index 00000000000..d2ad6a60266
> --- /dev/null
> +++ b/docs/system/riscv/microblaze-v-virt.rst
> @@ -0,0 +1,39 @@
> +Microblaze-V virt board (``amd-microblaze-v-virt``)
> +===================================================
> +The AMD MicroBlaze™ V processor is a soft-core RISC-V processor IP for AMD adaptive SoCs and FPGAs.
> +The MicroBlaze V processor is based on a 32-bit RISC-V instruction set architecture (ISA).
> +
> +More details here:
> +https://docs.amd.com/r/en-US/ug1629-microblaze-v-user-guide/MicroBlaze-V-Architecture
> +
> +The microblaze-v virt board in QEMU is a virtual board with
> +following supported devices
> +
> +Implemented CPU cores:
> +
> +1 RISCV32 core
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
> +     -device loader,addr=0x80000000,file=u-boot-spl.bin,cpu-num=0 \
> +     -device loader,addr=0x80200000,file=u-boot.img \
> +     -serial mon:stdio \
> +     -device loader,addr=0x83000000,file=system.dtb \
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
> + *
> + * Copyright (c) 2011 Michal Simek <monstr@monstr.eu>
> + * Copyright (c) 2011 PetaLogix
> + * Copyright (c) 2009 Edgar E. Iglesias.
> + * Copyright (C) 2024, Advanced Micro Devices, Inc.
> + * SPDX-License-Identifier: GPL-2.0-or-later
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
> +    ram_addr_t ram_size = machine->ram_size;
> +    DeviceState *dev, *dma, *eth0;
> +    Object *ds, *cs;
> +    int i;
> +    RISCVCPU *cpu;
> +    hwaddr ddr_base = MEMORY_BASEADDR;
> +    MemoryRegion *phys_lmb_bram = g_new(MemoryRegion, 1);
> +    MemoryRegion *phys_ram = g_new(MemoryRegion, 1);
> +    qemu_irq irq[32];
> +    MemoryRegion *sysmem = get_system_memory();
> +
> +    cpu = RISCV_CPU(object_new(machine->cpu_type));
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
> +    dev = qdev_new("xlnx.xps-intc");
> +    qdev_prop_set_uint32(dev, "kind-of-intr",
> +                         1 << UARTLITE_IRQ);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, INTC_BASEADDR);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
> +                       qdev_get_gpio_in(DEVICE(cpu), 11));
> +    for (i = 0; i < 32; i++) {
> +        irq[i] = qdev_get_gpio_in(dev, i);
> +    }
> +
> +    /* Uartlite */
> +    dev = qdev_new(TYPE_XILINX_UARTLITE);
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
> +    dev = qdev_new("xlnx.xps-timer");
> +    qdev_prop_set_uint32(dev, "one-timer-only", 0);
> +    qdev_prop_set_uint32(dev, "clock-frequency", 100000000);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, TIMER_BASEADDR);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[TIMER_IRQ]);
> +
> +    /* 2 timers at irq 3 @ 100 Mhz.  */
> +    dev = qdev_new("xlnx.xps-timer");
> +    qdev_prop_set_uint32(dev, "one-timer-only", 0);
> +    qdev_prop_set_uint32(dev, "clock-frequency", 100000000);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, TIMER_BASEADDR2);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[TIMER_IRQ2]);
> +
> +    /* Emaclite */
> +    dev = qdev_new("xlnx.xps-ethernetlite");
> +    qemu_configure_nic_device(dev, true, NULL);
> +    qdev_prop_set_uint32(dev, "tx-ping-pong", 0);
> +    qdev_prop_set_uint32(dev, "rx-ping-pong", 0);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, ETHLITE_BASEADDR);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[ETHLITE_IRQ]);
> +
> +    /* axi ethernet and dma initialization. */
> +    eth0 = qdev_new("xlnx.axi-ethernet");
> +    dma = qdev_new("xlnx.axi-dma");
> +
> +    /* FIXME: attach to the sysbus instead */
> +    object_property_add_child(qdev_get_machine(), "xilinx-eth", OBJECT(eth0));
> +    object_property_add_child(qdev_get_machine(), "xilinx-dma", OBJECT(dma));
> +
> +    ds = object_property_get_link(OBJECT(dma),
> +                                  "axistream-connected-target", NULL);
> +    cs = object_property_get_link(OBJECT(dma),
> +                                  "axistream-control-connected-target", NULL);
> +    qemu_configure_nic_device(eth0, true, NULL);
> +    qdev_prop_set_uint32(eth0, "rxmem", 0x1000);
> +    qdev_prop_set_uint32(eth0, "txmem", 0x1000);
> +    object_property_set_link(OBJECT(eth0), "axistream-connected", ds,
> +                             &error_abort);
> +    object_property_set_link(OBJECT(eth0), "axistream-control-connected", cs,
> +                             &error_abort);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(eth0), &error_fatal);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(eth0), 0, AXIENET_BASEADDR);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(eth0), 0, irq[AXIENET_IRQ]);
> +
> +    ds = object_property_get_link(OBJECT(eth0),
> +                                  "axistream-connected-target", NULL);
> +    cs = object_property_get_link(OBJECT(eth0),
> +                                  "axistream-control-connected-target", NULL);
> +    qdev_prop_set_uint32(dma, "freqhz", 100000000);
> +    object_property_set_link(OBJECT(dma), "axistream-connected", ds,
> +                             &error_abort);
> +    object_property_set_link(OBJECT(dma), "axistream-control-connected", cs,
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
> +    mc->desc = "AMD Microblaze-V Virt platform";
> +    mc->init = mb_v_virt_init;
> +    mc->min_cpus = 1;
> +    mc->max_cpus = 1;
> +    mc->default_cpu_type = TYPE_RISCV_CPU_BASE32;
> +    mc->default_cpus = 1;
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
> @@ -10,5 +10,6 @@ riscv_ss.add(when: 'CONFIG_SIFIVE_U', if_true: files('sifive_u.c'))
>  riscv_ss.add(when: 'CONFIG_SPIKE', if_true: files('spike.c'))
>  riscv_ss.add(when: 'CONFIG_MICROCHIP_PFSOC', if_true: files('microchip_pfsoc.c'))
>  riscv_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
> +riscv_ss.add(when: 'CONFIG_MICROBLAZE_V', if_true: files('microblaze-v-virt.c'))
>  
>  hw_arch += {'riscv': riscv_ss}
> -- 
> 2.34.1
> 
> 

