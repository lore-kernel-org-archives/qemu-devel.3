Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA8DC3ABAA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 11:12:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAoJj-0001sT-Lw; Fri, 02 May 2025 07:12:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=zHgX=XS=kaod.org=clg@ozlabs.org>)
 id 1uAoJU-0001nh-Od; Fri, 02 May 2025 07:12:18 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=zHgX=XS=kaod.org=clg@ozlabs.org>)
 id 1uAoJR-0004st-Pq; Fri, 02 May 2025 07:12:16 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4ZppCv2mMhz4xN3;
 Fri,  2 May 2025 21:12:11 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4ZppCq3pCLz4x8P;
 Fri,  2 May 2025 21:12:07 +1000 (AEST)
Message-ID: <44e57467-9967-4942-a006-ad6a70bc06b7@kaod.org>
Date: Fri, 2 May 2025 13:12:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/9] hw/arm: Introduce ASPEED AST2700 A1 full core
 machine
To: Steven Lee <steven_lee@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, longzl2@lenovo.com, yunlin.tang@aspeedtech.com
References: <20250502103449.3091642-1-steven_lee@aspeedtech.com>
 <20250502103449.3091642-8-steven_lee@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250502103449.3091642-8-steven_lee@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=zHgX=XS=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/2/25 12:34, Steven Lee wrote:
> - Added new machine type `ast2700fc` with full core support.
> - Defined `Ast2700FCState` structure for the new machine type.
> - Implemented initialization functions for CA35, SSP, and TSP components.
> - Updated `ast2700fc_types` to include the new machine type.
> - Set machine class properties for `ast2700fc`.
> 
> Test Step:
> - Download ast2700-default-obmc.tar.gz from AspeedTech-BMC OpenBmc
>    release page.
> - Run the following QEMU command:
> 
>    ```
>    IMGDIR=~/path/to/image
>    UBOOT_SIZE=$(stat --format=%s -L ${IMGDIR}/u-boot-nodtb.bin)
> 
>    ./qemu-system-aarch64 -machine ast2700fc \
>    -device loader,force-raw=on,addr=0x400000000,file=${IMGDIR}/u-boot-nodtb.bin \
>    -device loader,force-raw=on,addr=$((0x400000000 + ${UBOOT_SIZE})),file=${IMGDIR}/u-boot.dtb \
>    -device loader,force-raw=on,addr=0x430000000,file=${IMGDIR}/bl31.bin \
>    -device loader,force-raw=on,addr=0x430080000,file=${IMGDIR}/tee-raw.bin \
>    -device loader,cpu-num=0,addr=0x430000000 \
>    -device loader,cpu-num=1,addr=0x430000000 \
>    -device loader,cpu-num=2,addr=0x430000000 \
>    -device loader,cpu-num=3,addr=0x430000000 \
>    -device loader,file=${IMGDIR}/ast2700-ssp.elf,cpu-num=4 \
>    -device loader,file=${IMGDIR}/ast2700-tsp.elf,cpu-num=5 \
>    -drive file=${IMGDIR}/image-bmc,if=mtd,format=raw \
>    -serial pty -serial pty -serial pty \
>    -snapshot \
>    -S -nographic
>    ```
> 
> - After starting QEMU, serial devices will be redirected:
> 
>    char device redirected to /dev/pts/51 (label serial0)
>    char device redirected to /dev/pts/52 (label serial1)
>    char device redirected to /dev/pts/53 (label serial2)
> 
> - serial0 is the console for the four Cortex-A35 primary processors,
>    serial1 and serial2 are the consoles for the two Cortex-M4 coprocessors.
> 
> - Connect to the consoles using a terminal emulator.
> 
> Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> Change-Id: I32447b9372a78eb53a07135afef59c2a19202328


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/arm/aspeed_ast27x0-fc.c | 192 +++++++++++++++++++++++++++++++++++++
>   hw/arm/meson.build         |   4 +-
>   2 files changed, 195 insertions(+), 1 deletion(-)
>   create mode 100644 hw/arm/aspeed_ast27x0-fc.c
> 
> diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
> new file mode 100644
> index 0000000000..125a3ade40
> --- /dev/null
> +++ b/hw/arm/aspeed_ast27x0-fc.c
> @@ -0,0 +1,192 @@
> +/*
> + * ASPEED SoC 2700 family
> + *
> + * Copyright (C) 2025 ASPEED Technology Inc.
> + *
> + * This code is licensed under the GPL version 2 or later.  See
> + * the COPYING file in the top-level directory.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/units.h"
> +#include "qapi/error.h"
> +#include "system/block-backend.h"
> +#include "system/system.h"
> +#include "hw/arm/aspeed.h"
> +#include "hw/boards.h"
> +#include "hw/qdev-clock.h"
> +#include "hw/arm/aspeed_soc.h"
> +#include "hw/loader.h"
> +#include "hw/arm/boot.h"
> +#include "hw/block/flash.h"
> +
> +
> +#define TYPE_AST2700A1FC MACHINE_TYPE_NAME("ast2700fc")
> +OBJECT_DECLARE_SIMPLE_TYPE(Ast2700FCState, AST2700A1FC);
> +
> +static struct arm_boot_info ast2700fc_board_info = {
> +    .board_id = -1, /* device-tree-only board */
> +};
> +
> +struct Ast2700FCState {
> +    MachineState parent_obj;
> +
> +    MemoryRegion ca35_memory;
> +    MemoryRegion ca35_dram;
> +    MemoryRegion ssp_memory;
> +    MemoryRegion tsp_memory;
> +
> +    Clock *ssp_sysclk;
> +    Clock *tsp_sysclk;
> +
> +    Aspeed27x0SoCState ca35;
> +    Aspeed27x0SSPSoCState ssp;
> +    Aspeed27x0TSPSoCState tsp;
> +
> +    bool mmio_exec;
> +};
> +
> +#define AST2700FC_BMC_RAM_SIZE (2 * GiB)
> +#define AST2700FC_CM4_DRAM_SIZE (32 * MiB)
> +
> +#define AST2700FC_HW_STRAP1 0x000000C0
> +#define AST2700FC_HW_STRAP2 0x00000003
> +#define AST2700FC_FMC_MODEL "w25q01jvq"
> +#define AST2700FC_SPI_MODEL "w25q512jv"
> +
> +static void ast2700fc_ca35_init(MachineState *machine)
> +{
> +    Ast2700FCState *s = AST2700A1FC(machine);
> +    AspeedSoCState *soc;
> +    AspeedSoCClass *sc;
> +
> +    object_initialize_child(OBJECT(s), "ca35", &s->ca35, "ast2700-a1");
> +    soc = ASPEED_SOC(&s->ca35);
> +    sc = ASPEED_SOC_GET_CLASS(soc);
> +
> +    memory_region_init(&s->ca35_memory, OBJECT(&s->ca35), "ca35-memory",
> +                       UINT64_MAX);
> +
> +    if (!memory_region_init_ram(&s->ca35_dram, OBJECT(&s->ca35), "ca35-dram",
> +                                AST2700FC_BMC_RAM_SIZE, &error_abort)) {
> +        return;
> +    }
> +    if (!object_property_set_link(OBJECT(&s->ca35), "memory",
> +                                  OBJECT(&s->ca35_memory),
> +                                  &error_abort)) {
> +        return;
> +    };
> +    if (!object_property_set_link(OBJECT(&s->ca35), "dram",
> +                                  OBJECT(&s->ca35_dram), &error_abort)) {
> +        return;
> +    }
> +    if (!object_property_set_int(OBJECT(&s->ca35), "ram-size",
> +                                 AST2700FC_BMC_RAM_SIZE, &error_abort)) {
> +        return;
> +    }
> +    if (!object_property_set_int(OBJECT(&s->ca35), "hw-strap1",
> +                                 AST2700FC_HW_STRAP1, &error_abort)) {
> +        return;
> +    }
> +    if (!object_property_set_int(OBJECT(&s->ca35), "hw-strap2",
> +                                 AST2700FC_HW_STRAP2, &error_abort)) {
> +        return;
> +    }
> +    aspeed_soc_uart_set_chr(soc, ASPEED_DEV_UART12, serial_hd(0));
> +    if (!qdev_realize(DEVICE(&s->ca35), NULL, &error_abort)) {
> +        return;
> +    }
> +
> +    /*
> +     * AST2700 EVB has a LM75 temperature sensor on I2C bus 0 at address 0x4d.
> +     */
> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 0), "tmp105", 0x4d);
> +
> +    aspeed_board_init_flashes(&soc->fmc, AST2700FC_FMC_MODEL, 2, 0);
> +    aspeed_board_init_flashes(&soc->spi[0], AST2700FC_SPI_MODEL, 1, 2);
> +
> +    ast2700fc_board_info.ram_size = machine->ram_size;
> +    ast2700fc_board_info.loader_start = sc->memmap[ASPEED_DEV_SDRAM];
> +
> +    arm_load_kernel(ARM_CPU(first_cpu), machine, &ast2700fc_board_info);
> +}
> +
> +static void ast2700fc_ssp_init(MachineState *machine)
> +{
> +    AspeedSoCState *soc;
> +    Ast2700FCState *s = AST2700A1FC(machine);
> +    s->ssp_sysclk = clock_new(OBJECT(s), "SSP_SYSCLK");
> +    clock_set_hz(s->ssp_sysclk, 200000000ULL);
> +
> +    object_initialize_child(OBJECT(s), "ssp", &s->ssp, TYPE_ASPEED27X0SSP_SOC);
> +    memory_region_init(&s->ssp_memory, OBJECT(&s->ssp), "ssp-memory",
> +                       UINT64_MAX);
> +
> +    qdev_connect_clock_in(DEVICE(&s->ssp), "sysclk", s->ssp_sysclk);
> +    if (!object_property_set_link(OBJECT(&s->ssp), "memory",
> +                                  OBJECT(&s->ssp_memory), &error_abort)) {
> +        return;
> +    }
> +
> +    soc = ASPEED_SOC(&s->ssp);
> +    aspeed_soc_uart_set_chr(soc, ASPEED_DEV_UART4, serial_hd(1));
> +    if (!qdev_realize(DEVICE(&s->ssp), NULL, &error_abort)) {
> +        return;
> +    }
> +}
> +
> +static void ast2700fc_tsp_init(MachineState *machine)
> +{
> +    AspeedSoCState *soc;
> +    Ast2700FCState *s = AST2700A1FC(machine);
> +    s->tsp_sysclk = clock_new(OBJECT(s), "TSP_SYSCLK");
> +    clock_set_hz(s->tsp_sysclk, 200000000ULL);
> +
> +    object_initialize_child(OBJECT(s), "tsp", &s->tsp, TYPE_ASPEED27X0TSP_SOC);
> +    memory_region_init(&s->tsp_memory, OBJECT(&s->tsp), "tsp-memory",
> +                       UINT64_MAX);
> +
> +    qdev_connect_clock_in(DEVICE(&s->tsp), "sysclk", s->tsp_sysclk);
> +    if (!object_property_set_link(OBJECT(&s->tsp), "memory",
> +                                  OBJECT(&s->tsp_memory), &error_abort)) {
> +        return;
> +    }
> +
> +    soc = ASPEED_SOC(&s->tsp);
> +    aspeed_soc_uart_set_chr(soc, ASPEED_DEV_UART7, serial_hd(2));
> +    if (!qdev_realize(DEVICE(&s->tsp), NULL, &error_abort)) {
> +        return;
> +    }
> +}
> +
> +static void ast2700fc_init(MachineState *machine)
> +{
> +    ast2700fc_ca35_init(machine);
> +    ast2700fc_ssp_init(machine);
> +    ast2700fc_tsp_init(machine);
> +}
> +
> +static void ast2700fc_class_init(ObjectClass *oc, const void *data)
> +{
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +
> +    mc->alias = "ast2700fc";
> +    mc->desc = "ast2700 full core support";
> +    mc->init = ast2700fc_init;
> +    mc->no_floppy = 1;
> +    mc->no_cdrom = 1;
> +    mc->min_cpus = mc->max_cpus = mc->default_cpus = 6;
> +}
> +
> +static const TypeInfo ast2700fc_types[] = {
> +    {
> +        .name           = MACHINE_TYPE_NAME("ast2700fc"),
> +        .parent         = TYPE_MACHINE,
> +        .class_init     = ast2700fc_class_init,
> +        .instance_size  = sizeof(Ast2700FCState),
> +    },
> +};
> +
> +DEFINE_TYPES(ast2700fc_types)
> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
> index 98c5631506..5098795f61 100644
> --- a/hw/arm/meson.build
> +++ b/hw/arm/meson.build
> @@ -49,7 +49,9 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
>     'aspeed_ast10x0.c',
>     'aspeed_eeprom.c',
>     'fby35.c'))
> -arm_common_ss.add(when: ['CONFIG_ASPEED_SOC', 'TARGET_AARCH64'], if_true: files('aspeed_ast27x0.c'))
> +arm_common_ss.add(when: ['CONFIG_ASPEED_SOC', 'TARGET_AARCH64'], if_true: files(
> +  'aspeed_ast27x0.c',
> +  'aspeed_ast27x0-fc.c',))
>   arm_common_ss.add(when: 'CONFIG_MPS2', if_true: files('mps2.c'))
>   arm_common_ss.add(when: 'CONFIG_MPS2', if_true: files('mps2-tz.c'))
>   arm_common_ss.add(when: 'CONFIG_MSF2', if_true: files('msf2-soc.c'))


