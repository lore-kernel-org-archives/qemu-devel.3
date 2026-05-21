Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63480CD5BB0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 08:55:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPzAm-0008FR-9M; Thu, 21 May 2026 04:54:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wPzAk-0008Ex-Bf
 for qemu-devel@nongnu.org; Thu, 21 May 2026 04:54:30 -0400
Received: from smtpout4.mo534.mail-out.ovh.net ([188.165.54.92])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wPzAh-0007pF-7p
 for qemu-devel@nongnu.org; Thu, 21 May 2026 04:54:30 -0400
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net [79.137.60.37])
 by mo534.mail-out.ovh.net (Postfix) with ESMTPS id 4gLhzg15lNz6BlW;
 Thu, 21 May 2026 08:54:23 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net. [127.0.0.1])
 by director4.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Thu, 21 May 2026 08:54:23 +0000 (UTC)
Received: from mta7.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.43.59])
 by director4.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4gLhzg0Qbkz1xp5;
 Thu, 21 May 2026 08:54:23 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.0])
 (Authenticated sender: clg@kaod.org)
 by mta7.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id DCCC0203B6A; 
 Thu, 21 May 2026 08:54:21 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-96R0018d12b7c8-2e5e-496c-8f8c-dd08d6abb7db,
 155D954443A34AB19E7EFB78D45315E373F1C727) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <b3a51fa2-9486-4f2f-b952-4dd51e3a7402@kaod.org>
Date: Thu, 21 May 2026 10:54:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] hw/arm/aspeed: Introduce AST1040 A0 SoC model
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260521065203.3713466-1-jamin_lin@aspeedtech.com>
 <20260521065203.3713466-4-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260521065203.3713466-4-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 14429251733575805963
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGpXznD9slKRIXOZg7Wqf7oh8jfFCxgHm4cnuSK0dnNSuaPCO5yRzhbhzD0Rfo9VOmoJMXNODbfqdDBbGScohG0cnxEyXunktkNY1bOOHVGDJ3tvMyqZYILQyh9LasV42Qo4oFVQgaUyWr8D6Vf0KIpM+r/tAK2jRDyYdbXDKfHooQ3Fpe5l++YS1TcV3ZQP7SZILt8TXha5IQKiYkuZVvXHJeDFRV9B8LxQnV7S63gcdMNXlfROFDoprwZZrTO+vKGyS//un46qRJrPgOQTErhW3LzDfI+ifNIHvuSqXglQ8D/rtKbM/wBwdZSb7enPB4xJz9EC+59Iv3F+VojriMWmqF7fOskJ8C+rJhnb26ZKzYF4ewU+q588iH2bsBMD3qNs4uTG0rDFay6FLEfwyD7DQucfYTlhuy+LBnGbYFRRfcVpcBRyfBiBXWw/ihsZ/Xo+bloqHLfMLMVWd8NnhquaqW4N5e7hjJ9VHavhQuq8emgZ53SeoFfNqG/5B+fV+uJm/j9mjkTkT/WG2VZqhsCcInLouqr5p7TJgozOojtrcFkizYRwn21I4VD6LGPqPt0HLdvuElmbnJc39f0UGS2fs0Z3fukOcMfT6fzoM6mpLqwr2K5NJQX4I7nXU5wp+qB8+a8ssKK09Rlzz8Fu3BHGL7Psv+8Hxv0TC8TlN5oyg
DKIM-Signature: a=rsa-sha256; bh=OF27dA97UprNPiF+ezzcNE+A46sM7aHcK7wyXllw7fU=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1779353664; v=1;
 b=M80066DfULveWNZFQ4rCCTre86O04WUZudsIgYbB/i7tIqMUOjVea++d1tbRk/bk66rL3qGz
 3zjtLUxdTKBwYaL8E0lRWyhrvsrffJESfGcyc6Rlbw/EE6JrGfogf9mIFd/vB8IVZVmvTR+Rnkp
 W8CzYJEXccC7h9F3VdJ/gfIJmBrlF5k3OxU0C1vcID+ucPrKC4Dc3lZ2mygYZobccFxNtxb7nr/
 nFYMjDFdEfQn6wHj5Z+AqE9iqTPnUR0AYGIxdgMzDYIjXXZ/GPrgW6sQWsV+zkgTxaDHT+edq9y
 eHX/m4lGkFkpHGkKCNcn8gnOkozpAjvpDHRFl6fkam5JA==
Received-SPF: pass client-ip=188.165.54.92; envelope-from=clg@kaod.org;
 helo=smtpout4.mo534.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/21/26 08:52, Jamin Lin wrote:
> The AST1040 is based on an ARM Cortex-M4F CPU core. Since QEMU
> currently does not provide Cortex-M4F support, use the existing
> Cortex-M4 CPU model as a temporary replacement.
> 
> This initial implementation provides the basic infrastructure
> required to boot firmware and run a minimal firmware shell,
> including:
> 
> - ARM Cortex-M4 CPU integration
> - NVIC interrupt controller support
> - Internal SDRAM and SRAM memory regions
> - SCU integration
> - UART devices and interrupt wiring
> 
> AST1040 SCU behavior is compatible with the AST2700 SCUIO model,
> so reuse the existing AST2700 SCUIO implementation directly
> instead of introducing another identical SCU model. This reduces
> duplicate code and helps minimize long-term codebase maintenance.
> 
> Several peripherals are currently modeled as unimplemented
> devices and can be added incrementally in future updates.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/arm/aspeed_ast1040.c | 246 ++++++++++++++++++++++++++++++++++++++++
>   hw/arm/meson.build      |   3 +-
>   2 files changed, 248 insertions(+), 1 deletion(-)
>   create mode 100644 hw/arm/aspeed_ast1040.c
> 
> diff --git a/hw/arm/aspeed_ast1040.c b/hw/arm/aspeed_ast1040.c
> new file mode 100644
> index 0000000000..615f9c4e15
> --- /dev/null
> +++ b/hw/arm/aspeed_ast1040.c
> @@ -0,0 +1,246 @@
> +/*
> + * ASPEED AST1040 SoC
> + *
> + * Copyright (C) 2026 ASPEED Technology Inc.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "system/address-spaces.h"
> +#include "system/system.h"
> +#include "hw/core/qdev-clock.h"
> +#include "hw/misc/unimp.h"
> +#include "hw/arm/aspeed_soc.h"
> +
> +static const hwaddr aspeed_soc_ast1040_memmap[] = {
> +    [ASPEED_DEV_SDRAM]     = 0x00000000,
> +    [ASPEED_DEV_FMC]       = 0x74000000,
> +    [ASPEED_DEV_SPI0]      = 0x74010000,
> +    [ASPEED_DEV_SPI1]      = 0x74020000,
> +    [ASPEED_DEV_PWM]       = 0x740C0000,
> +    [ASPEED_DEV_UDC]       = 0x74120000,
> +    [ASPEED_DEV_SRAM]      = 0x74B80000,
> +    [ASPEED_DEV_ADC]       = 0x74C00000,
> +    [ASPEED_DEV_JTAG0]     = 0x74C01000,
> +    [ASPEED_DEV_SCU]       = 0x74C02000,
> +    [ASPEED_DEV_ESPI]      = 0x74C05000,
> +    [ASPEED_DEV_JTAG1]     = 0x74C09000,
> +    [ASPEED_DEV_GPIO]      = 0x74C0B000,
> +    [ASPEED_DEV_SGPIOM0]   = 0x74C0C000,
> +    [ASPEED_DEV_SGPIOM1]   = 0x74C0D000,> +    [ASPEED_DEV_I2C]       = 0x74C0F000,
> +    [ASPEED_DEV_I3C]       = 0x74C20000,
> +    [ASPEED_DEV_UART0]     = 0x74C33000,
> +    [ASPEED_DEV_UART1]     = 0x74C33100,
> +    [ASPEED_DEV_UART2]     = 0x74C33200,
> +    [ASPEED_DEV_UART3]     = 0x74C33300,
> +    [ASPEED_DEV_UART4]     = 0x74C33400,
> +    [ASPEED_DEV_UART5]     = 0x74C33500,
> +    [ASPEED_DEV_UART6]     = 0x74C33600,
> +    [ASPEED_DEV_UART7]     = 0x74C33700,
> +    [ASPEED_DEV_UART8]     = 0x74C33800,
> +    [ASPEED_DEV_UART9]     = 0x74C33900,
> +    [ASPEED_DEV_UART10]    = 0x74C33A00,
> +    [ASPEED_DEV_UART11]    = 0x74C33B00,
> +    [ASPEED_DEV_UART12]    = 0x74C33C00,
> +    [ASPEED_DEV_WDT]       = 0x74C37000,
> +    [ASPEED_DEV_TIMER1]    = 0x74C3A000,
> +};
> +
> +static const int aspeed_soc_ast1040_irqmap[] = {
> +    [ASPEED_DEV_ESPI]      = 10,
> +    [ASPEED_DEV_I2C]       = 64, /* 64 ~ 77 */
> +    [ASPEED_DEV_ADC]       = 80,
> +    [ASPEED_DEV_GPIO]      = 82,
> +    [ASPEED_DEV_SGPIOM0]   = 85,
> +    [ASPEED_DEV_TIMER1]    = 92,
> +    [ASPEED_DEV_I3C]       = 96, /* 96 ~ 103 */
> +    [ASPEED_DEV_WDT]       = 112,
> +    [ASPEED_DEV_FMC]       = 121,
> +    [ASPEED_DEV_SPI0]      = 122,
> +    [ASPEED_DEV_SPI1]      = 123,
> +    [ASPEED_DEV_PWM]       = 125,
> +    [ASPEED_DEV_UART0]     = 135,
> +    [ASPEED_DEV_UART1]     = 136,
> +    [ASPEED_DEV_UART2]     = 137,
> +    [ASPEED_DEV_UART3]     = 138,
> +    [ASPEED_DEV_UART4]     = 139,
> +    [ASPEED_DEV_UART5]     = 140,
> +    [ASPEED_DEV_UART6]     = 141,
> +    [ASPEED_DEV_UART7]     = 142,
> +    [ASPEED_DEV_UART8]     = 143,
> +    [ASPEED_DEV_UART9]     = 144,
> +    [ASPEED_DEV_UART10]    = 145,
> +    [ASPEED_DEV_UART11]    = 146,
> +    [ASPEED_DEV_UART12]    = 147,
> +    [ASPEED_DEV_JTAG0]     = 162,
> +};
> +
> +static qemu_irq aspeed_soc_ast1040_get_irq(AspeedSoCState *s, int dev)
> +{
> +    Aspeed10x0SoCState *a = ASPEED10X0_SOC(s);
> +    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
> +
> +    return qdev_get_gpio_in(DEVICE(&a->armv7m), sc->irqmap[dev]);
> +}
> +
> +static void aspeed_soc_ast1040_init(Object *obj)
> +{
> +    Aspeed10x0SoCState *a = ASPEED10X0_SOC(obj);
> +    AspeedSoCState *s = ASPEED_SOC(obj);
> +    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
> +    int i;
> +    object_initialize_child(obj, "armv7m", &a->armv7m, TYPE_ARMV7M);
> +
> +    s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
> +
> +    /* AST1040 uses the AST2700 IO SCU model */
> +    object_initialize_child(obj, "scu", &s->scu, TYPE_ASPEED_2700_SCUIO);
> +    qdev_prop_set_uint32(DEVICE(&s->scu), "silicon-rev", sc->silicon_rev);
> +
> +    object_property_add_alias(obj, "hw-strap1", OBJECT(&s->scu), "hw-strap1");
> +    object_property_add_alias(obj, "hw-strap2", OBJECT(&s->scu), "hw-strap2");
> +
> +    for (i = 0; i < sc->uarts_num; i++) {
> +        object_initialize_child(obj, "uart[*]", &s->uart[i], TYPE_SERIAL_MM);
> +    }
> +
> +    object_initialize_child(obj, "pwm", &s->pwm, TYPE_UNIMPLEMENTED_DEVICE);
> +    object_initialize_child(obj, "espi", &s->espi, TYPE_UNIMPLEMENTED_DEVICE);
> +    object_initialize_child(obj, "udc", &s->udc, TYPE_UNIMPLEMENTED_DEVICE);
> +    object_initialize_child(obj, "sgpiom", &s->sgpiom[0],
> +                            TYPE_UNIMPLEMENTED_DEVICE);
> +    object_initialize_child(obj, "jtag[0]", &s->jtag[0],
> +                            TYPE_UNIMPLEMENTED_DEVICE);
> +    object_initialize_child(obj, "jtag[1]", &s->jtag[1],
> +                            TYPE_UNIMPLEMENTED_DEVICE);
> +}
> +
> +static void aspeed_soc_ast1040_realize(DeviceState *dev_soc, Error **errp)
> +{
> +    Aspeed10x0SoCState *a = ASPEED10X0_SOC(dev_soc);
> +    AspeedSoCState *s = ASPEED_SOC(dev_soc);
> +    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
> +    DeviceState *armv7m;
> +    Error *err = NULL;
> +    char name[64];
> +    int uart;
> +    int i;
> +
> +    if (!clock_has_source(s->sysclk)) {
> +        error_setg(errp, "sysclk clock must be wired up by the board code");
> +        return;
> +    }
> +
> +    /* AST1040 CPU Core */
> +    armv7m = DEVICE(&a->armv7m);
> +    qdev_prop_set_uint32(armv7m, "num-irq", 256);
> +    qdev_prop_set_string(armv7m, "cpu-type",
> +                         aspeed_soc_cpu_type(sc->valid_cpu_types));
> +    qdev_connect_clock_in(armv7m, "cpuclk", s->sysclk);
> +    object_property_set_link(OBJECT(&a->armv7m), "memory",
> +                             OBJECT(s->memory), &error_abort);
> +    sysbus_realize(SYS_BUS_DEVICE(&a->armv7m), &error_abort);
> +
> +    /* Internal SDRAM */
> +    snprintf(name, sizeof(name), "aspeed.sdram.%d",
> +             CPU(a->armv7m.cpu)->cpu_index);

please use a g_autofree variable.

> +    memory_region_init_ram(&s->sdram, OBJECT(s), name, sc->sdram_size, &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +    memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SDRAM],
> +                                &s->sdram);
> +
> +    /* Internal SRAM */
> +    snprintf(name, sizeof(name), "aspeed.sram.%d",
> +             CPU(a->armv7m.cpu)->cpu_index);
> +    memory_region_init_ram(&s->sram, OBJECT(s), name, sc->sram_size, &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +    memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SRAM],
> +                                &s->sram);
> +
> +    /* SCU */
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
> +        return;
> +    }
> +    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->scu), 0,
> +                    sc->memmap[ASPEED_DEV_SCU]);
> +
> +    /* UART */
> +    for (i = 0, uart = sc->uarts_base; i < sc->uarts_num; i++, uart++) {
> +        if (!aspeed_soc_uart_realize(s->memory, &s->uart[i],
> +                                     sc->memmap[uart], errp)) {
> +            return;
> +        }
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart[i]), 0,
> +                           aspeed_soc_ast1040_get_irq(s, uart));
> +    }
> +
> +    /* Unimplemented peripherals */
> +    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->pwm),
> +                                  "aspeed.pwm",
> +                                  sc->memmap[ASPEED_DEV_PWM], 0x10000);
> +
> +    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->espi),
> +                                  "aspeed.espi",
> +                                  sc->memmap[ASPEED_DEV_ESPI], 0x1000);
> +
> +    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->udc),
> +                                  "aspeed.udc",
> +                                  sc->memmap[ASPEED_DEV_UDC], 0x4000);
> +
> +    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->sgpiom[0]),
> +                                  "aspeed.sgpiom",
> +                                  sc->memmap[ASPEED_DEV_SGPIOM0], 0x1000);

ASPEED_DEV_SGPIOM1 too may be. Or we don't care ?

> +
> +    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->jtag[0]),
> +                                  "aspeed.jtag0",
> +                                  sc->memmap[ASPEED_DEV_JTAG0], 0x100);
> +
> +    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->jtag[1]),
> +                                  "aspeed.jtag1",
> +                                  sc->memmap[ASPEED_DEV_JTAG1], 0x100);
> +}
> +
> +static void aspeed_soc_ast1040_class_init(ObjectClass *klass, const void *data)
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
> +    dc->realize = aspeed_soc_ast1040_realize;
> +
> +    sc->valid_cpu_types = valid_cpu_types;
> +    sc->silicon_rev     = AST1040_A0_SILICON_REV;
> +    sc->sdram_size      = 16 * MiB;
> +    sc->sram_size       = 512 * KiB;
> +    sc->uarts_num       = 13;
> +    sc->uarts_base      = ASPEED_DEV_UART0;
> +    sc->irqmap          = aspeed_soc_ast1040_irqmap;
> +    sc->memmap          = aspeed_soc_ast1040_memmap;
> +    sc->num_cpus        = 1;
> +}
> +
> +static const TypeInfo aspeed_soc_ast1040_types[] = {
> +    {
> +        .name           = "ast1040-a0",
> +        .parent         = TYPE_ASPEED10X0_SOC,
> +        .instance_init  = aspeed_soc_ast1040_init,
> +        .class_init     = aspeed_soc_ast1040_class_init,
> +    }
> +};
> +
> +DEFINE_TYPES(aspeed_soc_ast1040_types)
> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
> index 80068f70bb..fa3a848492 100644
> --- a/hw/arm/meson.build
> +++ b/hw/arm/meson.build
> @@ -62,7 +62,8 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
>     'aspeed_ast2600_gb200nvl.c',
>     'aspeed_ast2600_rainier.c',
>     'aspeed_ast10x0.c',
> -  'aspeed_ast10x0_evb.c'))
> +  'aspeed_ast10x0_evb.c',
> +  'aspeed_ast1040.c'))
>   arm_common_ss.add(when: ['CONFIG_ASPEED_SOC', 'TARGET_AARCH64'], if_true: files(
>     'aspeed_ast1700.c',
>     'aspeed_ast27x0.c',


