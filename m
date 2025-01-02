Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18FAAE77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 08:43:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTGm6-0007bQ-Jk; Thu, 02 Jan 2025 03:41:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=YAii=T2=kaod.org=clg@ozlabs.org>)
 id 1tTGm4-0007ai-Qx; Thu, 02 Jan 2025 03:41:48 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=YAii=T2=kaod.org=clg@ozlabs.org>)
 id 1tTGm1-0008IK-Tk; Thu, 02 Jan 2025 03:41:48 -0500
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4YP0YV4yBZz4xdw;
 Thu,  2 Jan 2025 19:41:34 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4YP0YQ6jcjz4x07;
 Thu,  2 Jan 2025 19:41:30 +1100 (AEDT)
Message-ID: <ad3fcdca-22e7-4a2c-9403-5b54c2352573@kaod.org>
Date: Thu, 2 Jan 2025 09:41:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] aspeed: Introduce ast2700-fc machine
To: Steven Lee <steven_lee@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
References: <20241225020311.3718080-1-steven_lee@aspeedtech.com>
 <20241225020311.3718080-5-steven_lee@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20241225020311.3718080-5-steven_lee@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=YAii=T2=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.222, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 12/25/24 03:03, Steven Lee wrote:
> This patch introduces a new machine, ast2700-fc, which supports all cores
> available in the AST27x0 SoC. In this machine
> - The first 4 cores are Cortex-A35 cores.
> - CPU 4 is designated as the SSP core.
> - CPU 5 is designated as the TSP core.
> 
> Test Step:
>      wget https://github.com/stevenlee7189/zephyr/releases/download/1.0.0/ast2700-ssp.elf
>      wget https://github.com/stevenlee7189/zephyr/releases/download/1.0.0/ast2700-tsp.elf
>      wget https://github.com/stevenlee7189/zephyr/releases/download/1.0.0/bl31.bin
>      wget https://github.com/stevenlee7189/zephyr/releases/download/1.0.0/tee-raw.bin
>      wget https://github.com/stevenlee7189/zephyr/releases/download/1.0.0/u-boot-nodtb.bin
>      wget https://github.com/stevenlee7189/zephyr/releases/download/1.0.0/u-boot.dtb
>      wget https://github.com/stevenlee7189/zephyr/releases/download/1.0.0/image-bmc.tar.zst
>      tar --zstd -xvf image-bmc.tar.zst
> 
>      qemu-system-aarch64 -machine ast2700fc \
>        -device loader,force-raw=on,addr=0x400000000,file=u-boot-nodtb.bin \
>        -device loader,force-raw=on,addr=$((0x400000000 + 748896)),file=u-boot.dtb\
>        -device loader,force-raw=on,addr=0x430000000,file=bl31.bin\
>        -device loader,force-raw=on,addr=0x430080000,file=tee-raw.bin\
>        -device loader,file=ast2700-ssp.elf,cpu-num=4 \
>        -device loader,file=ast2700-tsp.elf,cpu-num=5 \
>        -device loader,cpu-num=0,addr=0x430000000 \
>        -device loader,cpu-num=1,addr=0x430000000 \
>        -device loader,cpu-num=2,addr=0x430000000 \
>        -device loader,cpu-num=3,addr=0x430000000 \
>        -m 1G \
>        -drive file=image-bmc,if=mtd,format=raw \
>        -serial pty -serial pty -serial pty \
>        -S -nographic
>      char device redirected to /dev/pts/51 (label serial0)
>      char device redirected to /dev/pts/52 (label serial1)
>      char device redirected to /dev/pts/53 (label serial2)
> 
>      tio /dev/pts/51
>      tio /dev/pts/52
>      tio /dev/pts/53
>      (qemu) c
> 
> Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> ---
>   hw/arm/aspeed_ast27x0-fc.c  | 211 ++++++++++++++++++++++++++++++++++++
>   hw/arm/meson.build          |   4 +-
>   include/hw/arm/aspeed_soc.h |  12 ++
>   3 files changed, 226 insertions(+), 1 deletion(-)
>   create mode 100644 hw/arm/aspeed_ast27x0-fc.c
> 
> diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
> new file mode 100644
> index 0000000000..aeb0996a97
> --- /dev/null
> +++ b/hw/arm/aspeed_ast27x0-fc.c
> @@ -0,0 +1,211 @@
> +/*
> + * ASPEED SoC 2700 family
> + *
> + * Copyright (C) 2024 ASPEED Technology Inc.
> + *
> + * This code is licensed under the GPL version 2 or later.  See
> + * the COPYING file in the top-level directory.
> + *
> + * Implementation extracted from the AST2600 and adapted for AST2700.
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
> +#define TYPE_AST2700FC MACHINE_TYPE_NAME("ast2700fc")
> +OBJECT_DECLARE_SIMPLE_TYPE(Ast2700FCState, AST2700FC);
> +
> +static struct arm_boot_info ast2700fc_board_binfo = {
> +    .board_id = -1, /* device-tree-only board */
> +};
> +
> +struct Ast2700FCState {
> +    MachineState parent_obj;
> +
> +    MemoryRegion ca35_memory;
> +    MemoryRegion ca35_dram;
> +    MemoryRegion ca35_boot_rom;
> +    MemoryRegion ssp_memory;
> +    MemoryRegion tsp_memory;
> +
> +    Clock *ssp_sysclk;
> +    Clock *tsp_sysclk;
> +
> +    Aspeed27x0SoCState ca35;
> +    Aspeed27x0CM4SoCState ssp;
> +    Aspeed27x0CM4SoCState tsp;
> +
> +    bool mmio_exec;
> +};
> +
> +#define AST2700FC_BMC_RAM_SIZE (1 * GiB)
> +#define AST2700FC_BMC_SRAM_SIZE (1 * GiB)
> +> +#define AST2700FC_HW_STRAP1 0x000000C0
> +#define AST2700FC_HW_STRAP2 0x00000003
> +#define AST2700FC_FMC_MODEL "w25q01jvq"
> +#define AST2700FC_SPI_MODEL "w25q512jv"
> +
> +static void ast2700fc_install_boot_rom(Ast2700FCState *s, BlockBackend *blk,
> +                                    uint64_t rom_size)
> +{
> +    AspeedSoCState *soc = ASPEED_SOC(&s->ca35);
> +    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(soc);
> +
> +    memory_region_init_rom(&s->ca35_boot_rom, NULL, "aspeed.boot_rom", rom_size,
> +                           &error_abort);
> +    memory_region_add_subregion_overlap(&soc->spi_boot_container, 0,
> +                                        &s->ca35_boot_rom, 1);
> +    write_boot_rom(blk, sc->memmap[ASPEED_DEV_SPI_BOOT],
> +                   rom_size, &error_abort);
> +}
> +
> +static void ast2700fc_ca35_init(MachineState *machine)
> +{
> +    Ast2700FCState *s = AST2700FC(machine);
> +    AspeedSoCState *soc;
> +    AspeedSoCClass *sc;
> +    DriveInfo *emmc0 = NULL;
> +    bool boot_emmc;
> +    int i;
> +
> +    object_initialize_child(OBJECT(s), "ca35", &s->ca35, "ast2700-a0");
> +    soc = ASPEED_SOC(&s->ca35);
> +    sc = ASPEED_SOC_GET_CLASS(soc);
> +
> +    memory_region_init(&s->ca35_memory, OBJECT(&s->ca35), "ca35-memory",
> +                       UINT64_MAX);
> +
> +    memory_region_init_ram(&s->ca35_dram, OBJECT(&s->ca35), "ca35-dram",
> +                           AST2700FC_BMC_SRAM_SIZE, &error_abort);
> +    object_property_set_link(OBJECT(&s->ca35), "memory",
> +                             OBJECT(&s->ca35_memory),
> +                             &error_abort);
> +    object_property_set_link(OBJECT(&s->ca35), "dram", OBJECT(&s->ca35_dram),
> +                             &error_abort);
> +    object_property_set_int(OBJECT(&s->ca35), "ram-size",
> +                            AST2700FC_BMC_RAM_SIZE,
> +                            &error_abort);
> +    object_property_set_int(OBJECT(&s->ca35), "hw-strap1", AST2700FC_HW_STRAP1,
> +                            &error_abort);
> +    object_property_set_int(OBJECT(&s->ca35), "hw-strap2", AST2700FC_HW_STRAP2,
> +                            &error_abort);
> +    aspeed_soc_uart_set_chr(soc, ASPEED_DEV_UART12, serial_hd(0));
> +    qdev_realize(DEVICE(&s->ca35), NULL, &error_abort);
> +
> +    aspeed_board_init_flashes(&soc->fmc, AST2700FC_FMC_MODEL, 2, 0);
> +    aspeed_board_init_flashes(&soc->spi[0], AST2700FC_SPI_MODEL, 1, 2);
> +
> +    for (i = 0; i < soc->sdhci.num_slots; i++) {
> +        sdhci_attach_drive(&soc->sdhci.slots[i],
> +                           drive_get(IF_SD, 0, i), false, false);
> +    }
> +    boot_emmc = sc->boot_from_emmc(soc);
> +
> +    if (soc->emmc.num_slots) {
> +        emmc0 = drive_get(IF_SD, 0, soc->sdhci.num_slots);
> +        sdhci_attach_drive(&soc->emmc.slots[0], emmc0, true, boot_emmc);
> +    }
> +
> +    if (!s->mmio_exec) {
> +        DeviceState *dev = ssi_get_cs(soc->fmc.spi, 0);
> +        BlockBackend *fmc0 = dev ? m25p80_get_blk(dev) : NULL;
> +
> +        if (fmc0 && !boot_emmc) {
> +            uint64_t rom_size = memory_region_size(&soc->spi_boot);
> +            ast2700fc_install_boot_rom(s, fmc0, rom_size);
> +        } else if (emmc0) {
> +            ast2700fc_install_boot_rom(s, blk_by_legacy_dinfo(emmc0), 64 * KiB);
> +        }
> +    }

could you please remove the sdhci and emmc parts as they seem unused.

> +    ast2700fc_board_binfo.ram_size = machine->ram_size;
> +    ast2700fc_board_binfo.loader_start = sc->memmap[ASPEED_DEV_SDRAM];
> +
> +    arm_load_kernel(ARM_CPU(first_cpu), machine, &ast2700fc_board_binfo);
> +}
> +
> +static void ast2700fc_ssp_init(MachineState *machine)
> +{
> +    AspeedSoCState *soc;
> +    Ast2700FCState *s = AST2700FC(machine);
> +    s->ssp_sysclk = clock_new(OBJECT(s), "SSP_SYSCLK");
> +    clock_set_hz(s->ssp_sysclk, 200000000ULL);
> +
> +    object_initialize_child(OBJECT(s), "ssp", &s->ssp, "ast2700ssp-a0");
> +    memory_region_init(&s->ssp_memory, OBJECT(&s->ssp), "ssp-memory",
> +                       UINT64_MAX);
> +
> +    qdev_connect_clock_in(DEVICE(&s->ssp), "sysclk", s->ssp_sysclk);
> +    object_property_set_link(OBJECT(&s->ssp), "memory", OBJECT(&s->ssp_memory),
> +                             &error_abort);

What is the RAM size ?

> +    soc = ASPEED_SOC(&s->ssp);
> +    aspeed_soc_uart_set_chr(soc, ASPEED_DEV_UART4, serial_hd(1));
> +    qdev_realize(DEVICE(&s->ssp), NULL, &error_abort);
> +}
> +
> +static void ast2700fc_tsp_init(MachineState *machine)
> +{
> +    AspeedSoCState *soc;
> +    Ast2700FCState *s = AST2700FC(machine);
> +    s->tsp_sysclk = clock_new(OBJECT(s), "TSP_SYSCLK");
> +    clock_set_hz(s->tsp_sysclk, 200000000ULL);
> +
> +    object_initialize_child(OBJECT(s), "tsp", &s->tsp, "ast2700tsp-a0");
> +    memory_region_init(&s->tsp_memory, OBJECT(&s->tsp), "tsp-memory",
> +                       UINT64_MAX);
> +
> +    qdev_connect_clock_in(DEVICE(&s->tsp), "sysclk", s->tsp_sysclk);
> +    object_property_set_link(OBJECT(&s->tsp), "memory", OBJECT(&s->tsp_memory),
> +                             &error_abort);
> +
> +    soc = ASPEED_SOC(&s->tsp);
> +    aspeed_soc_uart_set_chr(soc, ASPEED_DEV_UART4, serial_hd(2));
> +    qdev_realize(DEVICE(&s->tsp), NULL, &error_abort);
> +}
> +
> +static void ast2700fc_init(MachineState *machine)
> +{
> +    ast2700fc_ca35_init(machine);
> +    ast2700fc_ssp_init(machine);
> +    ast2700fc_tsp_init(machine);
> +}
> +
> +static void ast2700fc_instance_init(Object *obj)
> +{
> +    AST2700FC(obj)->mmio_exec = false;
> +}
> +
> +static void ast2700fc_class_init(ObjectClass *oc, void *data)
> +{
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +
> +    mc->desc = "ast2700 full cores support";
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
> +        .instance_init  = ast2700fc_instance_init,
> +    },
> +};
> +
> +DEFINE_TYPES(ast2700fc_types)
> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
> index cd7780b997..7b99f78aed 100644
> --- a/hw/arm/meson.build
> +++ b/hw/arm/meson.build
> @@ -47,7 +47,9 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
>     'aspeed_ast10x0.c',
>     'aspeed_eeprom.c',
>     'fby35.c'))
> -arm_ss.add(when: ['CONFIG_ASPEED_SOC', 'TARGET_AARCH64'], if_true: files('aspeed_ast27x0.c'))
> +arm_ss.add(when: ['CONFIG_ASPEED_SOC', 'TARGET_AARCH64'], if_true: files(
> +  'aspeed_ast27x0.c',
> +  'aspeed_ast27x0-fc.c'))
>   arm_ss.add(when: 'CONFIG_MPS2', if_true: files('mps2.c'))
>   arm_ss.add(when: 'CONFIG_MPS2', if_true: files('mps2-tz.c'))
>   arm_ss.add(when: 'CONFIG_MSF2', if_true: files('msf2-soc.c'))
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index 7de69dc57d..f6b38a0666 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -129,6 +129,18 @@ struct Aspeed2600SoCState {
>   #define TYPE_ASPEED2600_SOC "aspeed2600-soc"
>   OBJECT_DECLARE_SIMPLE_TYPE(Aspeed2600SoCState, ASPEED2600_SOC)
>   
> +struct Aspeed27x0CA35SoCState {
> +    AspeedSoCState parent;
> +
> +    ARMCPU cpu[ASPEED_CPUS_NUM];
> +    AspeedINTCState intc;
> +    GICv3State gic;
> +    MemoryRegion dram_empty;
> +};
> +
> +#define TYPE_ASPEED27X0CA35_SOC "aspeed27x0ca35-soc"
> +OBJECT_DECLARE_SIMPLE_TYPE(Aspeed27x0CA35SoCState, ASPEED27X0CA35_SOC)
> +


This is unused.


Thanks,

C.


>   struct Aspeed27x0CM4SoCState {
>       AspeedSoCState parent;
>   


