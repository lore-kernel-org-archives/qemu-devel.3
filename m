Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 222B5D1F9C6
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 19:58:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0nfx-0003bD-FV; Tue, 15 Oct 2024 15:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t0nfu-0003WM-G7
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 15:57:46 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t0nfr-0005xt-Oh
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 15:57:46 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-20c70abba48so39391955ad.0
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 12:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1729022262; x=1729627062; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9l9CKVaejjdosgozQARhmHB0E/h6yTOqM5eVMqGQ3Nk=;
 b=WRPOBS0icrUuu9XcGfy3tiwOdYwY60RzeLJYDPUQKUuCWJnj7AThCM8WlKAEr8QOg6
 BlLxoOq3vKuW0P9XLVDpcIAJprdmQ8G9XbmsZDnhg+0aqh/sX3DrBCZSHD9ikTzYQ2Iq
 B3uK2phSDGXxxij691EzZcVuFzBYGO2XsI7NG2P3XoOrdET5YdsGMLxvB3n/0gJynxDA
 UGqzti/QLpLluQEjsuCYe8ktiWAAr7XKV5ZR6sCjbkaotIdKmkktgO7wJFszrC4XAmah
 B+ArDKyqwR9PNRXvWQ8vHgTtaXW4/iTjtn6wFaw4XcE/ibXsy2YDG/SWXjWsVKfAKePF
 eDEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729022262; x=1729627062;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9l9CKVaejjdosgozQARhmHB0E/h6yTOqM5eVMqGQ3Nk=;
 b=tuBeWx7mbaZU5eDfy896LHuhdAIkgcoQi0GAEGFmrcROsgVQtQLptgdqjmQYzL/Q2U
 Op7nVhpWg3et6wlPrA+7OnG4FVINOO8r+78g+coPObTLZy7WXnHIHZFDhcHxCuWFHzxJ
 DrxKY3KPo/eHn85fJSxKtqNjm+4yM/+2l51LgVMo96z04nSEQ/0HgzL0+uH6XTncu7w6
 AVKAUWyEAGTfFhxQ9ucGfyMKaA25Ti0Q7XBdYBK5xAQIxov8trZRCO+hoefNuhVgvarH
 WbeYqx2YHQu2/glgnqhzRuDguxIeHivAXrvhQ/X5ZukNDgoWCwjOHLROvjGK3FKAmDxx
 WAug==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRk1O1dSLx5XEsxOpmfR2OBJvGrz9s+vACs+U9AMsWrWLbglaqy48Shivee4KdYHPC/IjxeAmU6+Qh@nongnu.org
X-Gm-Message-State: AOJu0YyyG1Z5pzJz+eWXDYp+Aj5wfyUWtxkF/zmWYbVVcTX6oI6N8YgW
 5a6Ur95IoOwAD+KWsCAf11vNBmFcuYlw9W9+N0P6+CqG1noXqd2wukzU36t9G9o=
X-Google-Smtp-Source: AGHT+IFLfsSolU0Ll+XJMBsuvrDesxJyrjScwFsyPEudbn6VbPtWKTUsorxkDrW6NAxlq8yNrj1Qmg==
X-Received: by 2002:a17:902:ce87:b0:20b:8c13:5307 with SMTP id
 d9443c01a7336-20cbb1c277emr205741965ad.33.1729022261736; 
 Tue, 15 Oct 2024 12:57:41 -0700 (PDT)
Received: from [192.168.68.110] ([177.188.133.9])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20d17f828adsm15793405ad.41.2024.10.15.12.57.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Oct 2024 12:57:41 -0700 (PDT)
Message-ID: <fb7e4111-2885-4aaa-a104-8a54ba795f96@ventanamicro.com>
Date: Tue, 15 Oct 2024 16:57:36 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/riscv: Add Microblaze V 32bit virt board
To: Sai Pavan Boddu <sai.pavan.boddu@amd.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Michal Simek <michal.simek@amd.com>
References: <20241015133921.3470901-1-sai.pavan.boddu@amd.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20241015133921.3470901-1-sai.pavan.boddu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=unavailable autolearn_force=no
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

Hi,


The doc file included in the patch will break the build:

/home/danielhb/work/qemu/docs/system/riscv/microblaze-v-virt.rst:document isn't included in any toctree

You'll need this extra change:


$ git diff
diff --git a/docs/system/target-riscv.rst b/docs/system/target-riscv.rst
index ba195f1518..6161f01d21 100644
--- a/docs/system/target-riscv.rst
+++ b/docs/system/target-riscv.rst
@@ -70,6 +70,7 @@ undocumented; you can get a complete list by running
     riscv/shakti-c
     riscv/sifive_u
     riscv/virt
+   riscv/microblaze-v-virt
  
  RISC-V CPU firmware


More comments below:

On 10/15/24 10:39 AM, Sai Pavan Boddu wrote:
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
>   MAINTAINERS                             |   6 +
>   docs/system/riscv/microblaze-v-virt.rst |  39 +++++
>   hw/riscv/microblaze-v-virt.c            | 182 ++++++++++++++++++++++++
>   hw/riscv/Kconfig                        |   8 ++
>   hw/riscv/meson.build                    |   1 +
>   5 files changed, 236 insertions(+)
>   create mode 100644 docs/system/riscv/microblaze-v-virt.rst
>   create mode 100644 hw/riscv/microblaze-v-virt.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d7a11fe6017..b104b6d0f7f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1274,6 +1274,12 @@ M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
>   S: Maintained
>   F: hw/microblaze/petalogix_ml605_mmu.c
>   
> +amd-microblaze-v-virt
> +M: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
> +S: Maintained
> +F: hw/riscv/microblaze-v-virt.c
> +F: docs/system/riscv/microblaze-v-virt.rst
> +
>   MIPS Machines
>   -------------
>   Overall MIPS Machines
> diff --git a/docs/system/riscv/microblaze-v-virt.rst b/docs/system/riscv/microblaze-v-virt.rst
> new file mode 100644
> index 00000000000..42cac9ac475
> --- /dev/null
> +++ b/docs/system/riscv/microblaze-v-virt.rst
> @@ -0,0 +1,39 @@
> +microblaze-v virt board (``amd-microblaze-v-virt``)
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
> diff --git a/hw/riscv/microblaze-v-virt.c b/hw/riscv/microblaze-v-virt.c
> new file mode 100644
> index 00000000000..d9cdfe39857
> --- /dev/null
> +++ b/hw/riscv/microblaze-v-virt.c
> @@ -0,0 +1,182 @@
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
> +    cpu = RISCV_CPU(object_new(TYPE_RISCV_CPU_BASE32));
> +    object_property_set_bool(OBJECT(cpu), "i", true, NULL);
> +    object_property_set_bool(OBJECT(cpu), "m", true, NULL);
> +    object_property_set_bool(OBJECT(cpu), "a", true, NULL);
> +    object_property_set_bool(OBJECT(cpu), "c", true, NULL);
> +    qdev_realize(DEVICE(cpu), NULL, &error_abort);


We usually do not instantiate the CPU in the middle of the board code. The idea
is that the board must be able to deal with the '-cpu' option that the user
might pass via command line, i.e. a board can run with multiple CPU types.

But the board can determine CPU defaults like the default cpu type, number of
cpus and so on in the machine class init. In your case, mb_v_virt_machine_init().

For example, if you want this board to have only one CPU of the 'rv32' type:


     mc->max_cpus = 1;
     mc->min_cpus = 1;
     mc->default_cpu_type = TYPE_RISCV_CPU_BASE32;
     mc->default_cpus = 1;


This will make sure that if no '-cpu' arg is passed the board will have exactly
one rv32 CPU.

Note that rv32 will have by default rv32imafdch, i.e more extensions that you're
setting (imac). If you want the board to not have access to all these extensions
by default, you can create a new CPU type in target/riscv/cpu.c and use it as
default_cpu_type for this board. See hw/riscv/sifive_u.c for an example.

One more thing:


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
> +    mc->is_default = true;

Setting mc->is_default will overwrite the current default board for qemu-system-riscv32
(spike). I'm not sure if this is your intention here.


Thanks,

Daniel

> +}
> +
> +DEFINE_MACHINE("amd-microblaze-v-virt", mb_v_virt_machine_init)
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index 44695ff9f2c..5424803a82e 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -22,6 +22,14 @@ config MICROCHIP_PFSOC
>       select SIFIVE_PLIC
>       select UNIMP
>   
> +config MICROBLAZE_V
> +    bool
> +    default y
> +    depends on RISCV32
> +    select XILINX
> +    select XILINX_AXI
> +    select XILINX_ETHLITE
> +
>   config OPENTITAN
>       bool
>       default y
> diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
> index f872674093a..8ea0412a376 100644
> --- a/hw/riscv/meson.build
> +++ b/hw/riscv/meson.build
> @@ -10,5 +10,6 @@ riscv_ss.add(when: 'CONFIG_SIFIVE_U', if_true: files('sifive_u.c'))
>   riscv_ss.add(when: 'CONFIG_SPIKE', if_true: files('spike.c'))
>   riscv_ss.add(when: 'CONFIG_MICROCHIP_PFSOC', if_true: files('microchip_pfsoc.c'))
>   riscv_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
> +riscv_ss.add(when: 'CONFIG_MICROBLAZE_V', if_true: files('microblaze-v-virt.c'))
>   
>   hw_arch += {'riscv': riscv_ss}

