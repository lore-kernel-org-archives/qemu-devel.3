Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B2EC3ABA3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 11:11:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAoIw-00019k-CS; Fri, 02 May 2025 07:11:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=zHgX=XS=kaod.org=clg@ozlabs.org>)
 id 1uAoIr-0000zi-Bv; Fri, 02 May 2025 07:11:37 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=zHgX=XS=kaod.org=clg@ozlabs.org>)
 id 1uAoIo-0004nQ-Ft; Fri, 02 May 2025 07:11:36 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4ZppC76Fnfz4x5g;
 Fri,  2 May 2025 21:11:31 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4ZppC40KJdz4x4d;
 Fri,  2 May 2025 21:11:27 +1000 (AEST)
Message-ID: <ed19f710-3f25-4138-bc1a-7d6347d0ba24@kaod.org>
Date: Fri, 2 May 2025 13:11:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/9] hw/arm/aspeed_ast27x0-tsp: Introduce AST27x0 A1
 TSP SoC
To: Steven Lee <steven_lee@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, longzl2@lenovo.com, yunlin.tang@aspeedtech.com
References: <20250502103449.3091642-1-steven_lee@aspeedtech.com>
 <20250502103449.3091642-7-steven_lee@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250502103449.3091642-7-steven_lee@aspeedtech.com>
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
> AST2700 TSP(Tertiary Service Processor) is a Cortex-M4 coprocessor
> The patch adds support for TSP with following update:
> 
> - Introduce Aspeed27x0TSPSoCState structure in aspeed_soc.h
> - Implement initialization and realization functions
> - Add support for UART, INTC, and SCU devices
> - Map unimplemented devices for IPC and SCUIO
> - Defined memory map and IRQ maps for AST27x0 A1 TSP SoC
> 
> The IRQ mapping is similar to AST2700 CA35 SoC, featuring a two-level
> interrupt controller.
> 
> Difference from AST2700:
> 
>      - AST2700
>        - Support GICINT128 to GICINT136 in INTC
>        - The INTCIO GIC_192_201 has 10 output pins, mapped as follows:
>            Bit 0 -> GIC 192
>            Bit 1 -> GIC 193
>            Bit 2 -> GIC 194
>            Bit 3 -> GIC 195
>            Bit 4 -> GIC 196
> 
>      - AST2700-tsp
>        - Support TSPINT128 to TSPINT136 in INTC
>        - The INTCIO TSPINT_160_169 has 10 output pins, mapped as follows:
>            Bit 0 -> TSPINT 160
>            Bit 1 -> TSPINT 161
>            Bit 2 -> TSPINT 162
>            Bit 3 -> TSPINT 163
>            Bit 4 -> TSPINT 164
> 
> Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> Change-Id: I69eec2b68b26ef04187b2922c5f2e584b9076c66
> ---
>   include/hw/arm/aspeed_soc.h |  12 ++
>   hw/arm/aspeed_ast27x0-tsp.c | 295 ++++++++++++++++++++++++++++++++++++
>   hw/arm/meson.build          |   1 +
>   3 files changed, 308 insertions(+)
>   create mode 100644 hw/arm/aspeed_ast27x0-tsp.c
> 
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index 32be90bc35..217ef0eafd 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -158,6 +158,18 @@ struct Aspeed27x0SSPSoCState {
>   #define TYPE_ASPEED27X0SSP_SOC "aspeed27x0ssp-soc"
>   OBJECT_DECLARE_SIMPLE_TYPE(Aspeed27x0SSPSoCState, ASPEED27X0SSP_SOC)
>   
> +struct Aspeed27x0TSPSoCState {
> +    AspeedSoCState parent;
> +    AspeedINTCState intc[2];
> +    UnimplementedDeviceState ipc[2];
> +    UnimplementedDeviceState scuio;
> +
> +    ARMv7MState armv7m;
> +};
> +
> +#define TYPE_ASPEED27X0TSP_SOC "aspeed27x0tsp-soc"
> +OBJECT_DECLARE_SIMPLE_TYPE(Aspeed27x0TSPSoCState, ASPEED27X0TSP_SOC)
> +
>   #define TYPE_ASPEED10X0_SOC "aspeed10x0-soc"
>   OBJECT_DECLARE_SIMPLE_TYPE(Aspeed10x0SoCState, ASPEED10X0_SOC)
>   
> diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c
> new file mode 100644
> index 0000000000..5d66d2609d
> --- /dev/null
> +++ b/hw/arm/aspeed_ast27x0-tsp.c
> @@ -0,0 +1,295 @@
> +/*
> + * ASPEED Ast27x0 TSP SoC
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
> +#include "qapi/error.h"
> +#include "hw/qdev-clock.h"
> +#include "hw/misc/unimp.h"
> +#include "hw/arm/aspeed_soc.h"
> +
> +#define AST2700_TSP_RAM_SIZE (32 * MiB)
> +
> +static const hwaddr aspeed_soc_ast27x0tsp_memmap[] = {
> +    [ASPEED_DEV_SRAM]      =  0x00000000,
> +    [ASPEED_DEV_INTC]      =  0x72100000,
> +    [ASPEED_DEV_SCU]       =  0x72C02000,
> +    [ASPEED_DEV_SCUIO]     =  0x74C02000,
> +    [ASPEED_DEV_UART0]     =  0x74C33000,
> +    [ASPEED_DEV_UART1]     =  0x74C33100,
> +    [ASPEED_DEV_UART2]     =  0x74C33200,
> +    [ASPEED_DEV_UART3]     =  0x74C33300,
> +    [ASPEED_DEV_UART4]     =  0x72C1A000,
> +    [ASPEED_DEV_INTCIO]    =  0x74C18000,
> +    [ASPEED_DEV_IPC0]      =  0x72C1C000,
> +    [ASPEED_DEV_IPC1]      =  0x74C39000,
> +    [ASPEED_DEV_UART5]     =  0x74C33400,
> +    [ASPEED_DEV_UART6]     =  0x74C33500,
> +    [ASPEED_DEV_UART7]     =  0x74C33600,
> +    [ASPEED_DEV_UART8]     =  0x74C33700,
> +    [ASPEED_DEV_UART9]     =  0x74C33800,
> +    [ASPEED_DEV_UART10]    =  0x74C33900,
> +    [ASPEED_DEV_UART11]    =  0x74C33A00,
> +    [ASPEED_DEV_UART12]    =  0x74C33B00,
> +    [ASPEED_DEV_TIMER1]    =  0x72C10000,
> +};
> +
> +static const int aspeed_soc_ast27x0tsp_irqmap[] = {
> +    [ASPEED_DEV_SCU]       = 12,
> +    [ASPEED_DEV_UART0]     = 164,
> +    [ASPEED_DEV_UART1]     = 164,
> +    [ASPEED_DEV_UART2]     = 164,
> +    [ASPEED_DEV_UART3]     = 164,
> +    [ASPEED_DEV_UART4]     = 8,
> +    [ASPEED_DEV_UART5]     = 164,
> +    [ASPEED_DEV_UART6]     = 164,
> +    [ASPEED_DEV_UART7]     = 164,
> +    [ASPEED_DEV_UART8]     = 164,
> +    [ASPEED_DEV_UART9]     = 164,
> +    [ASPEED_DEV_UART10]    = 164,
> +    [ASPEED_DEV_UART11]    = 164,
> +    [ASPEED_DEV_UART12]    = 164,
> +    [ASPEED_DEV_TIMER1]    = 16,
> +};
> +
> +/* TSPINT 164 */
> +static const int ast2700_tsp132_tsp164_intcmap[] = {
> +    [ASPEED_DEV_UART0]     = 7,
> +    [ASPEED_DEV_UART1]     = 8,
> +    [ASPEED_DEV_UART2]     = 9,
> +    [ASPEED_DEV_UART3]     = 10,
> +    [ASPEED_DEV_UART5]     = 11,
> +    [ASPEED_DEV_UART6]     = 12,
> +    [ASPEED_DEV_UART7]     = 13,
> +    [ASPEED_DEV_UART8]     = 14,
> +    [ASPEED_DEV_UART9]     = 15,
> +    [ASPEED_DEV_UART10]    = 16,
> +    [ASPEED_DEV_UART11]    = 17,
> +    [ASPEED_DEV_UART12]    = 18,
> +};
> +
> +struct nvic_intc_irq_info {
> +    int irq;
> +    int intc_idx;
> +    int orgate_idx;
> +    const int *ptr;
> +};
> +
> +static struct nvic_intc_irq_info ast2700_tsp_intcmap[] = {
> +    {160, 1, 0, NULL},
> +    {161, 1, 1, NULL},
> +    {162, 1, 2, NULL},
> +    {163, 1, 3, NULL},
> +    {164, 1, 4, ast2700_tsp132_tsp164_intcmap},
> +    {165, 1, 5, NULL},
> +    {166, 1, 6, NULL},
> +    {167, 1, 7, NULL},
> +    {168, 1, 8, NULL},
> +    {169, 1, 9, NULL},
> +    {128, 0, 1, NULL},
> +    {129, 0, 2, NULL},
> +    {130, 0, 3, NULL},
> +    {131, 0, 4, NULL},
> +    {132, 0, 5, ast2700_tsp132_tsp164_intcmap},
> +    {133, 0, 6, NULL},
> +    {134, 0, 7, NULL},
> +    {135, 0, 8, NULL},
> +    {136, 0, 9, NULL},
> +};
> +
> +static qemu_irq aspeed_soc_ast27x0tsp_get_irq(AspeedSoCState *s, int dev)
> +{
> +    Aspeed27x0TSPSoCState *a = ASPEED27X0TSP_SOC(s);
> +    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
> +
> +    int or_idx;
> +    int idx;
> +    int i;
> +
> +    for (i = 0; i < ARRAY_SIZE(ast2700_tsp_intcmap); i++) {
> +        if (sc->irqmap[dev] == ast2700_tsp_intcmap[i].irq) {
> +            assert(ast2700_tsp_intcmap[i].ptr);
> +            or_idx = ast2700_tsp_intcmap[i].orgate_idx;
> +            idx = ast2700_tsp_intcmap[i].intc_idx;
> +            return qdev_get_gpio_in(DEVICE(&a->intc[idx].orgates[or_idx]),
> +                                    ast2700_tsp_intcmap[i].ptr[dev]);
> +        }
> +    }
> +
> +    return qdev_get_gpio_in(DEVICE(&a->armv7m), sc->irqmap[dev]);
> +}
> +
> +static void aspeed_soc_ast27x0tsp_init(Object *obj)
> +{
> +    Aspeed27x0TSPSoCState *a = ASPEED27X0TSP_SOC(obj);
> +    AspeedSoCState *s = ASPEED_SOC(obj);
> +    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
> +    int i;
> +
> +    object_initialize_child(obj, "armv7m", &a->armv7m, TYPE_ARMV7M);
> +    object_initialize_child(obj, "scu", &s->scu, TYPE_ASPEED_2700_SCU);
> +    s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
> +    qdev_prop_set_uint32(DEVICE(&s->scu), "silicon-rev", sc->silicon_rev);
> +
> +    for (i = 0; i < sc->uarts_num; i++) {
> +        object_initialize_child(obj, "uart[*]", &s->uart[i], TYPE_SERIAL_MM);
> +    }
> +
> +    object_initialize_child(obj, "intc0", &a->intc[0],
> +                            TYPE_ASPEED_2700TSP_INTC);
> +    object_initialize_child(obj, "intc1", &a->intc[1],
> +                            TYPE_ASPEED_2700TSP_INTCIO);
> +
> +    object_initialize_child(obj, "timerctrl", &s->timerctrl,
> +                            TYPE_UNIMPLEMENTED_DEVICE);
> +    object_initialize_child(obj, "ipc0", &a->ipc[0],
> +                            TYPE_UNIMPLEMENTED_DEVICE);
> +    object_initialize_child(obj, "ipc1", &a->ipc[1],
> +                            TYPE_UNIMPLEMENTED_DEVICE);
> +    object_initialize_child(obj, "scuio", &a->scuio,
> +                            TYPE_UNIMPLEMENTED_DEVICE);
> +}
> +
> +static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
> +{
> +    Aspeed27x0TSPSoCState *a = ASPEED27X0TSP_SOC(dev_soc);
> +    AspeedSoCState *s = ASPEED_SOC(dev_soc);
> +    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
> +    DeviceState *armv7m;
> +    Error *err = NULL;
> +    g_autofree char *sram_name = NULL;
> +    int i;
> +
> +    if (!clock_has_source(s->sysclk)) {
> +        error_setg(errp, "sysclk clock must be wired up by the board code");
> +        return;
> +    }
> +
> +    /* AST27X0 TSP Core */
> +    armv7m = DEVICE(&a->armv7m);
> +    qdev_prop_set_uint32(armv7m, "num-irq", 256);
> +    qdev_prop_set_string(armv7m, "cpu-type", aspeed_soc_cpu_type(sc));
> +    qdev_connect_clock_in(armv7m, "cpuclk", s->sysclk);
> +    object_property_set_link(OBJECT(&a->armv7m), "memory",
> +                             OBJECT(s->memory), &error_abort);
> +    sysbus_realize(SYS_BUS_DEVICE(&a->armv7m), &error_abort);
> +
> +    sram_name = g_strdup_printf("aspeed.dram.%d",
> +                                CPU(a->armv7m.cpu)->cpu_index);
> +
> +    if (!memory_region_init_ram(&s->sram, OBJECT(s), sram_name, sc->sram_size,
> +                                &err)) {

Same comment as on patch 5. I will fix. So


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> +        return;
> +    }
> +    memory_region_add_subregion(s->memory,
> +                                sc->memmap[ASPEED_DEV_SRAM],
> +                                &s->sram);
> +
> +    /* SCU */
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
> +        return;
> +    }
> +    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->scu), 0, sc->memmap[ASPEED_DEV_SCU]);
> +
> +    /* INTC */
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc[0]), errp)) {
> +        return;
> +    }
> +
> +    aspeed_mmio_map(s, SYS_BUS_DEVICE(&a->intc[0]), 0,
> +                    sc->memmap[ASPEED_DEV_INTC]);
> +
> +    /* INTCIO */
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc[1]), errp)) {
> +        return;
> +    }
> +
> +    aspeed_mmio_map(s, SYS_BUS_DEVICE(&a->intc[1]), 0,
> +                    sc->memmap[ASPEED_DEV_INTCIO]);
> +
> +    /* irq source orgates -> INTC */
> +    for (i = 0; i < ASPEED_INTC_GET_CLASS(&a->intc[0])->num_inpins; i++) {
> +        qdev_connect_gpio_out(DEVICE(&a->intc[0].orgates[i]), 0,
> +                              qdev_get_gpio_in(DEVICE(&a->intc[0]), i));
> +    }
> +    for (i = 0; i < ASPEED_INTC_GET_CLASS(&a->intc[0])->num_outpins; i++) {
> +        assert(i < ARRAY_SIZE(ast2700_tsp_intcmap));
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&a->intc[0]), i,
> +                           qdev_get_gpio_in(DEVICE(&a->armv7m),
> +                                            ast2700_tsp_intcmap[i].irq));
> +    }
> +    /* irq source orgates -> INTC */
> +    for (i = 0; i < ASPEED_INTC_GET_CLASS(&a->intc[1])->num_inpins; i++) {
> +        qdev_connect_gpio_out(DEVICE(&a->intc[1].orgates[i]), 0,
> +                              qdev_get_gpio_in(DEVICE(&a->intc[1]), i));
> +    }
> +    /* INTCIO -> INTC */
> +    for (i = 0; i < ASPEED_INTC_GET_CLASS(&a->intc[1])->num_outpins; i++) {
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&a->intc[1]), i,
> +                        qdev_get_gpio_in(DEVICE(&a->intc[0].orgates[0]), i));
> +    }
> +    /* UART */
> +    if (!aspeed_soc_uart_realize(s, errp)) {
> +        return;
> +    }
> +
> +    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->timerctrl),
> +                                  "aspeed.timerctrl",
> +                                  sc->memmap[ASPEED_DEV_TIMER1], 0x200);
> +    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&a->ipc[0]),
> +                                  "aspeed.ipc0",
> +                                  sc->memmap[ASPEED_DEV_IPC0], 0x1000);
> +    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&a->ipc[1]),
> +                                  "aspeed.ipc1",
> +                                  sc->memmap[ASPEED_DEV_IPC1], 0x1000);
> +    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&a->scuio),
> +                                  "aspeed.scuio",
> +                                  sc->memmap[ASPEED_DEV_SCUIO], 0x1000);
> +}
> +
> +static void aspeed_soc_ast27x0tsp_class_init(ObjectClass *klass, const void *data)
> +{
> +    static const char * const valid_cpu_types[] = {
> +        ARM_CPU_TYPE_NAME("cortex-m4"), /* TODO cortex-m4f */
> +        NULL
> +    };
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    AspeedSoCClass *sc = ASPEED_SOC_CLASS(dc);
> +
> +    /* Reason: The Aspeed SoC can only be instantiated from a board */
> +    dc->user_creatable = false;
> +    dc->realize = aspeed_soc_ast27x0tsp_realize;
> +
> +    sc->valid_cpu_types = valid_cpu_types;
> +    sc->silicon_rev = AST2700_A1_SILICON_REV;
> +    sc->sram_size = AST2700_TSP_RAM_SIZE;
> +    sc->spis_num = 0;
> +    sc->ehcis_num = 0;
> +    sc->wdts_num = 0;
> +    sc->macs_num = 0;
> +    sc->uarts_num = 13;
> +    sc->uarts_base = ASPEED_DEV_UART0;
> +    sc->irqmap = aspeed_soc_ast27x0tsp_irqmap;
> +    sc->memmap = aspeed_soc_ast27x0tsp_memmap;
> +    sc->num_cpus = 1;
> +    sc->get_irq = aspeed_soc_ast27x0tsp_get_irq;
> +}
> +
> +static const TypeInfo aspeed_soc_ast27x0tsp_types[] = {
> +    {
> +        .name           = TYPE_ASPEED27X0TSP_SOC,
> +        .parent         = TYPE_ASPEED_SOC,
> +        .instance_size  = sizeof(Aspeed27x0TSPSoCState),
> +        .instance_init  = aspeed_soc_ast27x0tsp_init,
> +        .class_init     = aspeed_soc_ast27x0tsp_class_init,
> +    },
> +};
> +
> +DEFINE_TYPES(aspeed_soc_ast27x0tsp_types)
> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
> index 39b74a89ed..98c5631506 100644
> --- a/hw/arm/meson.build
> +++ b/hw/arm/meson.build
> @@ -45,6 +45,7 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
>     'aspeed_ast2400.c',
>     'aspeed_ast2600.c',
>     'aspeed_ast27x0-ssp.c',
> +  'aspeed_ast27x0-tsp.c',
>     'aspeed_ast10x0.c',
>     'aspeed_eeprom.c',
>     'fby35.c'))


