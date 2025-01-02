Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAAF6E77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 08:29:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTGa4-0004ZG-36; Thu, 02 Jan 2025 03:29:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=YAii=T2=kaod.org=clg@ozlabs.org>)
 id 1tTGZy-0004YU-5W; Thu, 02 Jan 2025 03:29:18 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=YAii=T2=kaod.org=clg@ozlabs.org>)
 id 1tTGZu-0005fT-Qf; Thu, 02 Jan 2025 03:29:17 -0500
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4YP0Gx6Qj9z4xdw;
 Thu,  2 Jan 2025 19:28:57 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4YP0Gt2RmCz4x07;
 Thu,  2 Jan 2025 19:28:53 +1100 (AEDT)
Message-ID: <513c95c7-8084-460c-86b8-c89612de48dd@kaod.org>
Date: Thu, 2 Jan 2025 09:28:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] aspeed: Introduce AST27x0 SoC with Cortex-M4 support
To: Steven Lee <steven_lee@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
References: <20241225020311.3718080-1-steven_lee@aspeedtech.com>
 <20241225020311.3718080-4-steven_lee@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20241225020311.3718080-4-steven_lee@aspeedtech.com>
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

Hello Steven,

On 12/25/24 03:03, Steven Lee wrote:
> This initial module adds support for the AST27x0 SoC, which features
> four Cortex-A35 cores and two Cortex-M4 cores. The patch enables emulation
> of the Cortex-M4 cores, laying the groundwork for co-processor support.

These changes introduce implementation of 2 SoCs. Please split.

> 
> Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> ---
>   hw/arm/aspeed_ast27x0-cm4.c | 397 ++++++++++++++++++++++++++++++++++++
>   hw/arm/meson.build          |   1 +
>   include/hw/arm/aspeed_soc.h |  23 +++
>   3 files changed, 421 insertions(+)
>   create mode 100644 hw/arm/aspeed_ast27x0-cm4.c
> 
> diff --git a/hw/arm/aspeed_ast27x0-cm4.c b/hw/arm/aspeed_ast27x0-cm4.c
> new file mode 100644
> index 0000000000..591e54f0a7
> --- /dev/null
> +++ b/hw/arm/aspeed_ast27x0-cm4.c
> @@ -0,0 +1,397 @@
> +/*
> + * ASPEED Ast27x0 CM4 SoC
> + *
> + * Copyright (C) 2024 ASPEED Technology Inc.
> + *
> + * This code is licensed under the GPL version 2 or later.  See
> + * the COPYING file in the top-level directory.

Please add an SPDX-License-Identifier tag in all new files.

> + *
> + * Implementation extracted from the AST2600 and adapted for Ast10x0.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "exec/address-spaces.h"
> +#include "hw/qdev-clock.h"
> +#include "hw/misc/unimp.h"
> +#include "hw/arm/aspeed_soc.h"
> +
> +#define ASPEED_SOC_IOMEM_SIZE 0x00200000
> +
> +static const hwaddr aspeed_soc_ast27x0ssp_memmap[] = {
> +    [ASPEED_DEV_SRAM]      =  0x00000000,
> +    [ASPEED_DEV_INTC]      =  0x72100000,
> +    [ASPEED_DEV_INTC0]     =  0x72102000,
> +    [ASPEED_DEV_INTC1]     =  0x72102100,
> +    [ASPEED_DEV_INTC2]     =  0x72102200,
> +    [ASPEED_DEV_INTC3]     =  0x72102300,
> +    [ASPEED_DEV_INTC4]     =  0x72102400,
> +    [ASPEED_DEV_INTC5]     =  0x72102500,
> +    [ASPEED_DEV_INTC6]     =  0x72102600,
> +    [ASPEED_DEV_INTC7]     =  0x72102700,
> +    [ASPEED_DEV_INTC8]     =  0x72102800,
> +    [ASPEED_DEV_SCU]       =  0x72C02000,
> +    [ASPEED_DEV_SCUIO]     =  0x74C02000,
> +    [ASPEED_DEV_UART0]     =  0X74C33000,
> +    [ASPEED_DEV_UART1]     =  0X74C33100,
> +    [ASPEED_DEV_UART2]     =  0X74C33200,
> +    [ASPEED_DEV_UART3]     =  0X74C33300,
> +    [ASPEED_DEV_UART4]     =  0X72C1A000,
> +    [ASPEED_DEV_IPC0]      =  0x72C1C000,
> +    [ASPEED_DEV_IPC1]      =  0x72C1C200,
> +    [ASPEED_DEV_IPC2]      =  0x72C1C800,
> +    [ASPEED_DEV_UART5]     =  0X74C33400,
> +    [ASPEED_DEV_UART6]     =  0X74C33500,
> +    [ASPEED_DEV_UART7]     =  0X74C33600,
> +    [ASPEED_DEV_UART8]     =  0X74C33700,
> +    [ASPEED_DEV_UART9]     =  0X74C33800,
> +    [ASPEED_DEV_UART10]    =  0X74C33900,
> +    [ASPEED_DEV_UART11]    =  0X74C33A00,
> +    [ASPEED_DEV_UART12]    =  0X74C33B00,
> +    [ASPEED_DEV_TIMER1]    =  0x72C10000,
> +};
> +
> +static const int aspeed_soc_ast27x0ssp_irqmap[] = {
> +    [ASPEED_DEV_SCU]       = 12,
> +    [ASPEED_DEV_UART0]     = 132,
> +    [ASPEED_DEV_UART1]     = 132,
> +    [ASPEED_DEV_UART2]     = 132,
> +    [ASPEED_DEV_UART3]     = 132,
> +    [ASPEED_DEV_UART4]     = 8,
> +    [ASPEED_DEV_UART5]     = 132,
> +    [ASPEED_DEV_UART6]     = 140,
> +    [ASPEED_DEV_UART7]     = 132,
> +    [ASPEED_DEV_UART8]     = 132,
> +    [ASPEED_DEV_UART9]     = 132,
> +    [ASPEED_DEV_UART10]    = 132,
> +    [ASPEED_DEV_UART11]    = 132,
> +    [ASPEED_DEV_UART12]    = 132,
> +    [ASPEED_DEV_TIMER1]    = 16,
> +};
> +
> +static const hwaddr aspeed_soc_ast27x0tsp_memmap[] = {
> +    [ASPEED_DEV_SRAM]      =  0x00000000,
> +    [ASPEED_DEV_INTC]      =  0x72100000,
> +    [ASPEED_DEV_INTC0]     =  0x72103000,
> +    [ASPEED_DEV_INTC1]     =  0x72103100,
> +    [ASPEED_DEV_INTC2]     =  0x72103200,
> +    [ASPEED_DEV_INTC3]     =  0x72103300,
> +    [ASPEED_DEV_INTC4]     =  0x72103400,
> +    [ASPEED_DEV_INTC5]     =  0x72103500,
> +    [ASPEED_DEV_INTC6]     =  0x72103600,
> +    [ASPEED_DEV_INTC7]     =  0x72103700,
> +    [ASPEED_DEV_INTC8]     =  0x72103800,
> +    [ASPEED_DEV_SCU]       =  0x72C02000,
> +    [ASPEED_DEV_SCUIO]     =  0x74C02000,
> +    [ASPEED_DEV_UART0]     =  0X74C33000,
> +    [ASPEED_DEV_UART1]     =  0X74C33100,
> +    [ASPEED_DEV_UART2]     =  0X74C33200,
> +    [ASPEED_DEV_UART3]     =  0X74C33300,
> +    [ASPEED_DEV_UART4]     =  0X72C1A000,
> +    [ASPEED_DEV_IPC0]      =  0x72C1C400,
> +    [ASPEED_DEV_IPC1]      =  0x72C1C600,
> +    [ASPEED_DEV_IPC2]      =  0x72C1C800,
> +    [ASPEED_DEV_UART5]     =  0X74C33400,
> +    [ASPEED_DEV_UART6]     =  0X74C33500,
> +    [ASPEED_DEV_UART7]     =  0X74C33600,
> +    [ASPEED_DEV_UART8]     =  0X74C33700,
> +    [ASPEED_DEV_UART9]     =  0X74C33800,
> +    [ASPEED_DEV_UART10]    =  0X74C33900,
> +    [ASPEED_DEV_UART11]    =  0X74C33A00,
> +    [ASPEED_DEV_UART12]    =  0X74C33B00,
> +    [ASPEED_DEV_TIMER1]    =  0x72C10000,
> +};
> +
> +static const int aspeed_soc_ast27x0tsp_irqmap[] = {
> +    [ASPEED_DEV_SCU]       = 12,
> +    [ASPEED_DEV_UART0]     = 132,
> +    [ASPEED_DEV_UART1]     = 132,
> +    [ASPEED_DEV_UART2]     = 132,
> +    [ASPEED_DEV_UART3]     = 132,
> +    [ASPEED_DEV_UART4]     = 8,
> +    [ASPEED_DEV_UART5]     = 132,
> +    [ASPEED_DEV_UART6]     = 140,
> +    [ASPEED_DEV_UART7]     = 132,
> +    [ASPEED_DEV_UART8]     = 132,
> +    [ASPEED_DEV_UART9]     = 132,
> +    [ASPEED_DEV_UART10]    = 132,
> +    [ASPEED_DEV_UART11]    = 132,
> +    [ASPEED_DEV_UART12]    = 132,
> +    [ASPEED_DEV_TIMER1]    = 16,
> +};
> +
> +static qemu_irq aspeed_soc_ast27x0ssp_get_irq(AspeedSoCState *s, int dev)
> +{
> +    Aspeed27x0CM4SoCState *a = ASPEED27X0CM4_SOC(s);
> +    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
> +
> +    return qdev_get_gpio_in(DEVICE(&a->armv7m), sc->irqmap[dev]);
> +}
> +
> +static void aspeed_soc_ast27x0ssp_init(Object *obj)
> +{
> +    Aspeed27x0CM4SoCState *a = ASPEED27X0CM4_SOC(obj);
> +    AspeedSoCState *s = ASPEED_SOC(obj);
> +    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
> +    char socname[8];
> +    char typename[64];
> +    int i;
> +
> +    if (sscanf(sc->name, "%7s", socname) != 1) {
> +        g_assert_not_reached();
> +    }
> +
> +    object_initialize_child(obj, "armv7m", &a->armv7m, TYPE_ARMV7M);
> +
> +    s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
> +
> +    snprintf(typename, sizeof(typename), "aspeed.scu-%s", socname);
> +    object_initialize_child(obj, "scu", &s->scu, typename);
> +    qdev_prop_set_uint32(DEVICE(&s->scu), "silicon-rev", sc->silicon_rev);
> +> +    for (i = 0; i < sc->uarts_num; i++) {
> +        object_initialize_child(obj, "uart[*]", &s->uart[i], TYPE_SERIAL_MM);
> +    }
> +
> +    object_initialize_child(obj, "timerctrl", &s->timerctrl,
> +                            TYPE_UNIMPLEMENTED_DEVICE);
> +    object_initialize_child(obj, "intc", &s->intc,
> +                            TYPE_UNIMPLEMENTED_DEVICE);
> +    object_initialize_child(obj, "ipc", &s->ipc,
> +                            TYPE_UNIMPLEMENTED_DEVICE);
> +}
> +
> +static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
> +{
> +    Aspeed27x0CM4SoCState *a = ASPEED27X0CM4_SOC(dev_soc);
> +    AspeedSoCState *s = ASPEED_SOC(dev_soc);
> +    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
> +    DeviceState *armv7m;
> +    Error *err = NULL;
> +    g_autofree char *sram_name = NULL;
> +
> +    if (!clock_has_source(s->sysclk)) {
> +        error_setg(errp, "sysclk clock must be wired up by the board code");
> +        return;
> +    }
> +
> +    /* AST27X0 SSP Core */
> +    armv7m = DEVICE(&a->armv7m);
> +    qdev_prop_set_uint32(armv7m, "num-irq", 256);
> +    qdev_prop_set_string(armv7m, "cpu-type", aspeed_soc_cpu_type(sc));
> +    qdev_connect_clock_in(armv7m, "cpuclk", s->sysclk);
> +    object_property_set_link(OBJECT(&a->armv7m), "memory",
> +                             OBJECT(s->memory), &error_abort);
> +    sysbus_realize(SYS_BUS_DEVICE(&a->armv7m), &error_abort);
> +
> +    /* Internal SRAM */
> +    sram_name = g_strdup_printf("aspeed.sram.%d",
> +                                CPU(a->armv7m.cpu)->cpu_index);
> +    memory_region_init_ram(&s->sram, OBJECT(s), sram_name, sc->sram_size, &err);

This is better :

     if (!memory_region_init_ram(&s->sram, OBJECT(s), sram_name, sc->sram_size, errp)) {
            return
     }

and aspeed_soc_ast1030_realize() needs a fix too btw.

> +    if (err != NULL) {
> +        error_propagate(errp, err);
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
> +    /* UART */
> +    if (!aspeed_soc_uart_realize(s, errp)) {
> +        return;
> +    }
> +
> +    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->timerctrl),
> +                                  "aspeed.timerctrl",
> +                                  sc->memmap[ASPEED_DEV_TIMER1], 0x200);
> +    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->intc),
> +                                  "aspeed.intc",
> +                                  sc->memmap[ASPEED_DEV_INTC], 0x4000);
> +    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->ipc),
> +                                  "aspeed.ipc",
> +                                  sc->memmap[ASPEED_DEV_IPC0], 0x1000);
> +}
> +
> +static void aspeed_soc_ast27x0ssp_class_init(ObjectClass *klass, void *data)
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
> +    dc->realize = aspeed_soc_ast27x0ssp_realize;
> +
> +    sc->name = "ast2700ssp-a0";
> +    sc->valid_cpu_types = valid_cpu_types;
> +    sc->silicon_rev = AST2700_A0_SILICON_REV;
> +    sc->sram_size = 0x1000000;
> +    sc->spis_num = 0;
> +    sc->ehcis_num = 0;
> +    sc->wdts_num = 0;
> +    sc->macs_num = 0;
> +    sc->uarts_num = 13;
> +    sc->uarts_base = ASPEED_DEV_UART0;
> +    sc->irqmap = aspeed_soc_ast27x0ssp_irqmap;
> +    sc->memmap = aspeed_soc_ast27x0ssp_memmap;
> +    sc->num_cpus = 1;
> +    sc->get_irq = aspeed_soc_ast27x0ssp_get_irq;
> +}
> +
> +static qemu_irq aspeed_soc_ast27x0tsp_get_irq(AspeedSoCState *s, int dev)
> +{
> +    Aspeed27x0CM4SoCState *a = ASPEED27X0CM4_SOC(s);
> +    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
> +
> +    return qdev_get_gpio_in(DEVICE(&a->armv7m), sc->irqmap[dev]);
> +}
> +
> +static void aspeed_soc_ast27x0tsp_init(Object *obj)
> +{
> +    Aspeed27x0CM4SoCState *a = ASPEED27X0CM4_SOC(obj);
> +    AspeedSoCState *s = ASPEED_SOC(obj);
> +    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
> +    char socname[8];
> +    char typename[64];
> +    int i;
> +
> +    if (sscanf(sc->name, "%7s", socname) != 1) {
> +        g_assert_not_reached();
> +    }
> +
> +    object_initialize_child(obj, "armv7m", &a->armv7m, TYPE_ARMV7M);
> +
> +    s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
> +
> +    snprintf(typename, sizeof(typename), "aspeed.scu-%s", socname);
> +    object_initialize_child(obj, "scu", &s->scu, typename);
> +    qdev_prop_set_uint32(DEVICE(&s->scu), "silicon-rev", sc->silicon_rev);
> +
> +    for (i = 0; i < sc->uarts_num; i++) {
> +        object_initialize_child(obj, "uart[*]", &s->uart[i], TYPE_SERIAL_MM);
> +    }
> +
> +    object_initialize_child(obj, "timerctrl", &s->timerctrl,
> +                            TYPE_UNIMPLEMENTED_DEVICE);
> +    object_initialize_child(obj, "intc", &s->intc,
> +                            TYPE_UNIMPLEMENTED_DEVICE);
> +    object_initialize_child(obj, "ipc", &s->ipc,
> +                            TYPE_UNIMPLEMENTED_DEVICE);
> +}
> +
> +static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
> +{
> +    Aspeed27x0CM4SoCState *a = ASPEED27X0CM4_SOC(dev_soc);
> +    AspeedSoCState *s = ASPEED_SOC(dev_soc);
> +    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
> +    DeviceState *armv7m;
> +    Error *err = NULL;
> +    g_autofree char *sram_name = NULL;
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
> +    /* Internal SRAM */
> +    sram_name = g_strdup_printf("aspeed.sram.%d",
> +                                CPU(a->armv7m.cpu)->cpu_index);
> +    memory_region_init_ram(&s->sram, OBJECT(s), sram_name, sc->sram_size, &err);
> +    if (err != NULL) {
> +        error_propagate(errp, err);
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
> +    /* UART */
> +    if (!aspeed_soc_uart_realize(s, errp)) {
> +        return;
> +    }
> +
> +    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->timerctrl),
> +                                  "aspeed.timerctrl",
> +                                  sc->memmap[ASPEED_DEV_TIMER1], 0x200);
> +    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->intc),
> +                                  "aspeed.intc",
> +                                  sc->memmap[ASPEED_DEV_INTC], 0x4000);
> +    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->ipc),
> +                                  "aspeed.ipc",
> +                                  sc->memmap[ASPEED_DEV_IPC0], 0x1000);
> +}
> +
> +static void aspeed_soc_ast27x0tsp_class_init(ObjectClass *klass, void *data)
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
> +    sc->name = "ast2700tsp-a0";
> +    sc->valid_cpu_types = valid_cpu_types;
> +    sc->silicon_rev = AST2700_A0_SILICON_REV;
> +    sc->sram_size = 0x1000000;
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
> +
> +static const TypeInfo aspeed_soc_ast27x0cm4_types[] = {
> +    {
> +        .name           = TYPE_ASPEED27X0CM4_SOC,
> +        .parent         = TYPE_ASPEED_SOC,
> +        .instance_size  = sizeof(Aspeed27x0CM4SoCState),
> +        .abstract       = true,
> +    }, {
> +        .name           = "ast2700ssp-a0",
> +        .parent         = TYPE_ASPEED27X0CM4_SOC,
> +        .instance_init  = aspeed_soc_ast27x0ssp_init,
> +        .class_init     = aspeed_soc_ast27x0ssp_class_init,
> +    }, {
> +        .name           = "ast2700tsp-a0",
> +        .parent         = TYPE_ASPEED27X0CM4_SOC,
> +        .instance_init  = aspeed_soc_ast27x0tsp_init,
> +        .class_init     = aspeed_soc_ast27x0tsp_class_init,
> +    },
> +};
> +
> +DEFINE_TYPES(aspeed_soc_ast27x0cm4_types)
> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
> index 490234b3b8..cd7780b997 100644
> --- a/hw/arm/meson.build
> +++ b/hw/arm/meson.build
> @@ -43,6 +43,7 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
>     'aspeed_soc_common.c',
>     'aspeed_ast2400.c',
>     'aspeed_ast2600.c',
> +  'aspeed_ast27x0-cm4.c',
>     'aspeed_ast10x0.c',
>     'aspeed_eeprom.c',
>     'fby35.c'))
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h

Please to your ~/.gitconfig

[diff]
	orderFile = /path/to/qemu/scripts/git.orderfile

> index bf885da3fc..7de69dc57d 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -101,6 +101,8 @@ struct AspeedSoCState {
>       UnimplementedDeviceState sgpiom;
>       UnimplementedDeviceState ltpi;
>       UnimplementedDeviceState jtag[ASPEED_JTAG_NUM];
> +    UnimplementedDeviceState intc;
> +    UnimplementedDeviceState ipc;

Shouldn't these 2 new attributes be moved to Aspeed27x0CM4SoCState ?
I think each should be introduced in a separate patch with a small
description.

>       AspeedAPB2OPBState fsi[2];
>   };
>   
> @@ -127,6 +129,15 @@ struct Aspeed2600SoCState {
>   #define TYPE_ASPEED2600_SOC "aspeed2600-soc"
>   OBJECT_DECLARE_SIMPLE_TYPE(Aspeed2600SoCState, ASPEED2600_SOC)
>   
> +struct Aspeed27x0CM4SoCState {
> +    AspeedSoCState parent;
> +
> +    ARMv7MState armv7m;

Why not use Aspeed10x0SoCState instead ?


Thanks,

C.



> +};
> +
> +#define TYPE_ASPEED27X0CM4_SOC "aspeed27x0cm4-soc"
> +OBJECT_DECLARE_SIMPLE_TYPE(Aspeed27x0CM4SoCState, ASPEED27X0CM4_SOC)
> +
>   struct Aspeed27x0SoCState {
>       AspeedSoCState parent;
>   
> @@ -201,6 +212,15 @@ enum {
>       ASPEED_DEV_EHCI2,
>       ASPEED_DEV_VIC,
>       ASPEED_DEV_INTC,
> +    ASPEED_DEV_INTC0,
> +    ASPEED_DEV_INTC1,
> +    ASPEED_DEV_INTC2,
> +    ASPEED_DEV_INTC3,
> +    ASPEED_DEV_INTC4,
> +    ASPEED_DEV_INTC5,
> +    ASPEED_DEV_INTC6,
> +    ASPEED_DEV_INTC7,
> +    ASPEED_DEV_INTC8,
>       ASPEED_DEV_SDMC,
>       ASPEED_DEV_SCU,
>       ASPEED_DEV_ADC,
> @@ -253,6 +273,9 @@ enum {
>       ASPEED_DEV_SCUIO,
>       ASPEED_DEV_SLI,
>       ASPEED_DEV_SLIIO,
> +    ASPEED_DEV_IPC0,
> +    ASPEED_DEV_IPC1,
> +    ASPEED_DEV_IPC2,
>       ASPEED_GIC_DIST,
>       ASPEED_GIC_REDIST,
>   };


