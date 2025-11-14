Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D11CE7B0E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 14:04:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJuPV-00033c-RU; Fri, 14 Nov 2025 09:04:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vJuMv-0001sC-Pl
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 09:01:42 -0500
Received: from 2.mo552.mail-out.ovh.net ([178.33.105.233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vJuMl-0000pe-7s
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 09:01:34 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.54.226])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4d7Jhl4CqTz6PdD;
 Fri, 14 Nov 2025 14:01:27 +0000 (UTC)
Received: from kaod.org (37.59.142.103) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Fri, 14 Nov
 2025 15:01:26 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-103G005f078d718-6304-44e7-9f7d-53eebb87d057,
 DCBE4845A3BE020BB938A31E73221960BF2A3C2F) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <014cac89-9a40-457c-8304-f36ea1b02de8@kaod.org>
Date: Fri, 14 Nov 2025 15:01:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/gpio: Add the skeleton of Aspeed Serial gpio
To: Yubin Zou <yubinz@google.com>, <qemu-devel@nongnu.org>
CC: Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent
 Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 <qemu-arm@nongnu.org>
References: <20251106-aspeed-sgpio-v1-0-b026093716fa@google.com>
 <20251106-aspeed-sgpio-v1-1-b026093716fa@google.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20251106-aspeed-sgpio-v1-1-b026093716fa@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.103]
X-ClientProxiedBy: DAG3EX2.mxp5.local (172.16.2.22) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: b2a10a5d-0261-4238-8273-e134047b62b4
X-Ovh-Tracer-Id: 3906591202490485752
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFMy7SjX48zi38z/Rmzf+J/9ESmsEXA2equ1GE1iDa6MS2T8NgKsGj2ORKN3+Hh8mZ+A8msrLlg53PrbTI4f8pKWu9Y8uorXsntG9NTThA8fUmylugXbmz/opYLYutqfTWBl8woxAFpsU6MwSb9KuOP7lJ62jWTvYdo3eE0AV7RdwpZ7MjnLCoC5czY4DQ+mZ5UY3Nlw9BUe9FE5Q9NzQ0Zuw4Rbo5E2yxuKKXdZ4I4sw9qhgehbicpGlEQBayRkcPTvXFzt8qh0xg345P/ivzpYWggUGKaJx47ZvXvuHXfMmg1xs73ZBAgKUw29iN7YiftPxSS6uSGj/BTlRSEq/1MCYxoHASXLYQTD0fNRYQxl00HHdH6OxOLzBf/RpymaGKlLLUfWNz7RNHgPmRPUYv8+7lrPPicL+dunE/Wgoyasue9n+4LgSdADA7n2ySo0UvtmlAlXj4eJlULiN+mkiJkp4ShRIkX+Ty33kJPZJM8wOwLY7qzd1oDmIedkiZkFxlZmbPwrQwVV/Ju4yUaD0AdsaQiM54lqrpZkMKNQe+8+f8kdajOjBEnfg/nEdnvUUQof80IHfnPzBzE9Znom50HQ0GaFIoQEgoQG11l2f2c1RMcIsW3GiesKjKWnUCLLuwvsoz0wTl3J898ZF5AQHY7aNF4wKcThiRCM6QaEdEp6g
DKIM-Signature: a=rsa-sha256; bh=TxNlucVcDFCdJZjdX8E0xeIXWZfWxkxzzSEZxW+WzMc=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1763128887; v=1;
 b=wXF4FBsubnt+KleqqIhMS5b9n3dPB6yCp8HAIfuvUevD5nsijDztAqR4CWBUJBTXzr1di+Td
 8IJ+iKm4CIRJZ9FAnCL4j8iZF7iM0MN1bJU9FPxLWJrO7YaXbJsPAK65ygy3T8mCUPZeuRnaqkr
 fIkKgiTN72JR9UNL580FVGyTNPrV+PBtdCzt4pdtOjYbdCML0QkX7xyolvG3h01MvtxqDo/8UhD
 Z9vc6MZuDAG9G7QmJ43jvJ9GU4k85OaNRNu4WLZ/GXy0DAK1heYtoq6Z3BY79hVQ2hFGZC/Erqm
 AfWNOO9z/YCX62c67jv4bVzo8gREhC1OIZ7FiXRVmpOwg==
Received-SPF: pass client-ip=178.33.105.233; envelope-from=clg@kaod.org;
 helo=2.mo552.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hello Yubin,

On 11/6/25 20:14, Yubin Zou wrote:
> This commit includes a minimal implementation for reading serial input
> pin and sets up the necessary device registration on Aspeed 2700 SoC.


The commit log will need to be improved to present the SGPIO controller
of the AST2700 SoC. 
> Signed-off-by: Yubin Zou <yubinz@google.com>
> ---
>   hw/arm/aspeed_ast10x0.c          |   6 +-
>   hw/arm/aspeed_ast27x0.c          |  26 ++++
>   hw/gpio/aspeed_sgpio.c           | 266 +++++++++++++++++++++++++++++++++++++++
>   hw/gpio/meson.build              |   1 +
>   include/hw/arm/aspeed_soc.h      |   8 +-
>   include/hw/gpio/aspeed_sgpio.h   |  38 ++++++
>   tests/qtest/ast2700-sgpio-test.c |  94 ++++++++++++++
>   tests/qtest/meson.build          |   1 +
>   8 files changed, 435 insertions(+), 5 deletions(-)
Please add to your .git/config :

   [diff]
	orderFile = /path/to/qemu/scripts/git.orderfile

Overall, the changes look good, but they need to be split. Could you
please respin the proposal following this layout ?

1. Prereq changes in the existing models
2. "minimal" implementation of the Aspeed SGPIO device model.
    What's below should be fine. The property accessors could be proposed
    in their own patch, as you wish.
3. Wiring in the Aspeed machines, one patch per machine
4. Unit tests
5. Documentation updates

Then, the extra features.

This will help the reviewers.

Thanks,

C.


> diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c
> index 7f49c13391be0b923e317409a0fccfa741f5e658..c141cc080422579ca6b6965369d84dfbe416247b 100644
> --- a/hw/arm/aspeed_ast10x0.c
> +++ b/hw/arm/aspeed_ast10x0.c
> @@ -36,7 +36,7 @@ static const hwaddr aspeed_soc_ast1030_memmap[] = {
>       [ASPEED_DEV_ESPI]      = 0x7E6EE000,
>       [ASPEED_DEV_SBC]       = 0x7E6F2000,
>       [ASPEED_DEV_GPIO]      = 0x7E780000,
> -    [ASPEED_DEV_SGPIOM]    = 0x7E780500,
> +    [ASPEED_DEV_SGPIOM0]   = 0x7E780500,
>       [ASPEED_DEV_TIMER1]    = 0x7E782000,
>       [ASPEED_DEV_UART1]     = 0x7E783000,
>       [ASPEED_DEV_UART2]     = 0x7E78D000,
> @@ -94,7 +94,7 @@ static const int aspeed_soc_ast1030_irqmap[] = {
>       [ASPEED_DEV_I2C]       = 110, /* 110 ~ 123 */
>       [ASPEED_DEV_KCS]       = 138, /* 138 -> 142 */
>       [ASPEED_DEV_UDC]       = 9,
> -    [ASPEED_DEV_SGPIOM]    = 51,
> +    [ASPEED_DEV_SGPIOM0]   = 51,
>       [ASPEED_DEV_JTAG0]     = 27,
>       [ASPEED_DEV_JTAG1]     = 53,
>   };
> @@ -427,7 +427,7 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
>                                     sc->memmap[ASPEED_DEV_UDC], 0x1000);
>       aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->sgpiom),
>                                     "aspeed.sgpiom",
> -                                  sc->memmap[ASPEED_DEV_SGPIOM], 0x100);
> +                                  sc->memmap[ASPEED_DEV_SGPIOM0], 0x100);
>   
>       aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->jtag[0]),
>                                     "aspeed.jtag",
> diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
> index c484bcd4e22fb49faf9c16992ae2cdfd6cd82da4..787accadbecae376d0c747d054ec6372785375b1 100644
> --- a/hw/arm/aspeed_ast27x0.c
> +++ b/hw/arm/aspeed_ast27x0.c
> @@ -69,6 +69,8 @@ static const hwaddr aspeed_soc_ast2700_memmap[] = {
>       [ASPEED_DEV_ADC]       =  0x14C00000,
>       [ASPEED_DEV_SCUIO]     =  0x14C02000,
>       [ASPEED_DEV_GPIO]      =  0x14C0B000,
> +    [ASPEED_DEV_SGPIOM0]   =  0x14C0C000,
> +    [ASPEED_DEV_SGPIOM1]   =  0x14C0D000,
>       [ASPEED_DEV_I2C]       =  0x14C0F000,
>       [ASPEED_DEV_INTCIO]    =  0x14C18000,
>       [ASPEED_DEV_PCIE_PHY2] =  0x14C1C000,
> @@ -122,6 +124,8 @@ static const int aspeed_soc_ast2700a0_irqmap[] = {
>       [ASPEED_DEV_KCS]       = 128,
>       [ASPEED_DEV_ADC]       = 130,
>       [ASPEED_DEV_GPIO]      = 130,
> +    [ASPEED_DEV_SGPIOM0]   = 130,
> +    [ASPEED_DEV_SGPIOM1]   = 130,
>       [ASPEED_DEV_I2C]       = 130,
>       [ASPEED_DEV_FMC]       = 131,
>       [ASPEED_DEV_WDT]       = 131,
> @@ -173,6 +177,8 @@ static const int aspeed_soc_ast2700a1_irqmap[] = {
>       [ASPEED_DEV_I2C]       = 194,
>       [ASPEED_DEV_ADC]       = 194,
>       [ASPEED_DEV_GPIO]      = 194,
> +    [ASPEED_DEV_SGPIOM0]   = 194,
> +    [ASPEED_DEV_SGPIOM1]   = 194,
>       [ASPEED_DEV_FMC]       = 195,
>       [ASPEED_DEV_WDT]       = 195,
>       [ASPEED_DEV_PWM]       = 195,
> @@ -214,6 +220,8 @@ static const int ast2700_gic130_gic194_intcmap[] = {
>       [ASPEED_DEV_I2C]        = 0,
>       [ASPEED_DEV_ADC]        = 16,
>       [ASPEED_DEV_GPIO]       = 18,
> +    [ASPEED_DEV_SGPIOM0]    = 21,
> +    [ASPEED_DEV_SGPIOM1]    = 24,
>   };
>   
>   /* GICINT 131 */
> @@ -511,6 +519,11 @@ static void aspeed_soc_ast2700_init(Object *obj)
>       snprintf(typename, sizeof(typename), "aspeed.gpio-%s", socname);
>       object_initialize_child(obj, "gpio", &s->gpio, typename);
>   
> +    snprintf(typename, sizeof(typename), "aspeed.sgpio-%s", socname);
> +    for (i = 0; i < sc->sgpio_num; i++) {
> +        object_initialize_child(obj, "sgpio[*]", &s->sgpiom[i], typename);
> +    }
> +
>       object_initialize_child(obj, "rtc", &s->rtc, TYPE_ASPEED_RTC);
>   
>       snprintf(typename, sizeof(typename), "aspeed.sdhci-%s", socname);
> @@ -965,6 +978,17 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
>       sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), 0,
>                          aspeed_soc_ast2700_get_irq(s, ASPEED_DEV_GPIO));
>   
> +    /* SGPIO */
> +    for (i = 0; i < sc->sgpio_num; i++) {
> +        if (!sysbus_realize(SYS_BUS_DEVICE(&s->sgpiom[i]), errp)) {
> +            return;
> +        }
> +        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->sgpiom[i]), 0,
> +                        sc->memmap[ASPEED_DEV_SGPIOM0 + i]);
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->sgpiom[i]), 0,
> +                        aspeed_soc_ast2700_get_irq(s, ASPEED_DEV_SGPIOM0 + i));
> +    }
> +
>       /* RTC */
>       if (!sysbus_realize(SYS_BUS_DEVICE(&s->rtc), errp)) {
>           return;
> @@ -1061,6 +1085,7 @@ static void aspeed_soc_ast2700a0_class_init(ObjectClass *oc, const void *data)
>       sc->sram_size    = 0x20000;
>       sc->pcie_num     = 0;
>       sc->spis_num     = 3;
> +    sc->sgpio_num    = 2;
>       sc->ehcis_num    = 2;
>       sc->wdts_num     = 8;
>       sc->macs_num     = 1;
> @@ -1089,6 +1114,7 @@ static void aspeed_soc_ast2700a1_class_init(ObjectClass *oc, const void *data)
>       sc->sram_size    = 0x20000;
>       sc->pcie_num     = 3;
>       sc->spis_num     = 3;
> +    sc->sgpio_num    = 2;
>       sc->ehcis_num    = 4;
>       sc->wdts_num     = 8;
>       sc->macs_num     = 3;
> diff --git a/hw/gpio/aspeed_sgpio.c b/hw/gpio/aspeed_sgpio.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..a6f0f32d72aef3c26a143df4e7a49384aa216643
> --- /dev/null
> +++ b/hw/gpio/aspeed_sgpio.c
> @@ -0,0 +1,266 @@
> +/*
> + * ASPEED Serial GPIO Controller
> + *
> + * Copyright 2025 Google LLC.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/host-utils.h"
> +#include "qemu/log.h"
> +#include "qemu/error-report.h"
> +#include "qapi/error.h"
> +#include "qapi/visitor.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/gpio/aspeed_sgpio.h"
> +#include "hw/registerfields.h"
> +
> +/* AST2700 SGPIO Register Address Offsets */
> +REG32(SGPIO_INT_STATUS_0, 0x40)
> +REG32(SGPIO_INT_STATUS_1, 0x44)
> +REG32(SGPIO_INT_STATUS_2, 0x48)
> +REG32(SGPIO_INT_STATUS_3, 0x4C)
> +REG32(SGPIO_INT_STATUS_4, 0x50)
> +REG32(SGPIO_INT_STATUS_5, 0x54)
> +REG32(SGPIO_INT_STATUS_6, 0x58)
> +REG32(SGPIO_INT_STATUS_7, 0x5C)
> +/* AST2700 SGPIO_0 - SGPIO_255 Control Register */
> +REG32(SGPIO_0_CONTROL, 0x80)
> +    SHARED_FIELD(SGPIO_SERIAL_OUT_VAL, 0, 1)
> +    SHARED_FIELD(SGPIO_PARALLEL_OUT_VAL, 1, 1)
> +    SHARED_FIELD(SGPIO_INT_EN, 2, 1)
> +    SHARED_FIELD(SGPIO_INT_TYPE0, 3, 1)
> +    SHARED_FIELD(SGPIO_INT_TYPE1, 4, 1)
> +    SHARED_FIELD(SGPIO_INT_TYPE2, 5, 1)
> +    SHARED_FIELD(SGPIO_RESET_POLARITY, 6, 1)
> +    SHARED_FIELD(SGPIO_RESERVED_1, 7, 2)
> +    SHARED_FIELD(SGPIO_INPUT_MASK, 9, 1)
> +    SHARED_FIELD(SGPIO_PARALLEL_EN, 10, 1)
> +    SHARED_FIELD(SGPIO_PARALLEL_IN_MODE, 11, 1)
> +    SHARED_FIELD(SGPIO_INTERRUPT_STATUS, 12, 1)
> +    SHARED_FIELD(SGPIO_SERIAL_IN_VAL, 13, 1)
> +    SHARED_FIELD(SGPIO_PARALLEL_IN_VAL, 14, 1)
> +    SHARED_FIELD(SGPIO_RESERVED_2, 15, 12)
> +    SHARED_FIELD(SGPIO_WRITE_PROTECT, 31, 1)
> +REG32(SGPIO_255_CONTROL, 0x47C)
> +
> +static uint64_t aspeed_sgpio_2700_read_int_status_reg(AspeedSGPIOState *s,
> +                                uint32_t reg)
> +{
> +    /* TODO: b/430606659 - Implement aspeed_sgpio_2700_read_int_status_reg */
> +    return 0;
> +}
> +
> +static uint64_t aspeed_sgpio_2700_read_control_reg(AspeedSGPIOState *s,
> +                                uint32_t reg)
> +{
> +    AspeedSGPIOClass *agc = ASPEED_SGPIO_GET_CLASS(s);
> +    uint32_t pin = reg - R_SGPIO_0_CONTROL;
> +    if (pin >= agc->nr_sgpio_pin_pairs) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: pin index: %d, out of bounds\n",
> +                      __func__, pin);
> +        return 0;
> +    }
> +    return s->ctrl_regs[pin];
> +}
> +
> +static void aspeed_sgpio_2700_write_control_reg(AspeedSGPIOState *s,
> +                                uint32_t reg, uint64_t data)
> +{
> +    AspeedSGPIOClass *agc = ASPEED_SGPIO_GET_CLASS(s);
> +    uint32_t pin = reg - R_SGPIO_0_CONTROL;
> +    if (pin >= agc->nr_sgpio_pin_pairs) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: pin index: %d, out of bounds\n",
> +                      __func__, pin);
> +        return;
> +    }
> +    s->ctrl_regs[pin] = data;
> +}
> +
> +static uint64_t aspeed_sgpio_2700_read(void *opaque, hwaddr offset,
> +                                uint32_t size)
> +{
> +    AspeedSGPIOState *s = ASPEED_SGPIO(opaque);
> +    uint64_t value = 0;
> +    uint64_t reg;
> +
> +    reg = offset >> 2;
> +
> +    switch (reg) {
> +    case R_SGPIO_INT_STATUS_0 ... R_SGPIO_INT_STATUS_7:
> +        aspeed_sgpio_2700_read_int_status_reg(s, reg);
> +        break;
> +    case R_SGPIO_0_CONTROL ... R_SGPIO_255_CONTROL:
> +        value = aspeed_sgpio_2700_read_control_reg(s, reg);
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: no getter for offset 0x%"
> +                      PRIx64"\n", __func__, offset);
> +        return 0;
> +    }
> +
> +    return value;
> +}
> +
> +static void aspeed_sgpio_2700_write(void *opaque, hwaddr offset, uint64_t data,
> +                                uint32_t size)
> +{
> +    AspeedSGPIOState *s = ASPEED_SGPIO(opaque);
> +    uint64_t reg;
> +
> +    reg = offset >> 2;
> +
> +    switch (reg) {
> +    case R_SGPIO_INT_STATUS_0 ... R_SGPIO_INT_STATUS_7:
> +        break;
> +    case R_SGPIO_0_CONTROL ... R_SGPIO_255_CONTROL:
> +        aspeed_sgpio_2700_write_control_reg(s, reg, data);
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: no setter for offset 0x%"
> +                      PRIx64"\n", __func__, offset);
> +        return;
> +    }
> +}
> +
> +static bool aspeed_sgpio_get_pin_level(AspeedSGPIOState *s, int pin)
> +{
> +    uint32_t value = s->ctrl_regs[pin >> 1];
> +    bool is_input = !(pin % 2);
> +    uint32_t bit_mask = 0;
> +
> +    if (is_input) {
> +        bit_mask = SGPIO_SERIAL_IN_VAL_MASK;
> +    } else {
> +        bit_mask = SGPIO_SERIAL_OUT_VAL_MASK;
> +    }
> +
> +    return value & bit_mask;
> +}
> +
> +static void aspeed_sgpio_set_pin_level(AspeedSGPIOState *s, int pin, bool level)
> +{
> +    uint32_t value = s->ctrl_regs[pin >> 1];
> +    bool is_input = !(pin % 2);
> +    uint32_t bit_mask = 0;
> +
> +    if (is_input) {
> +        bit_mask = SGPIO_SERIAL_IN_VAL_MASK;
> +    } else {
> +        bit_mask = SGPIO_SERIAL_OUT_VAL_MASK;
> +    }
> +
> +    if (level) {
> +        value |= bit_mask;
> +    } else {
> +        value &= ~bit_mask;
> +    }
> +    s->ctrl_regs[pin >> 1] = value;
> +    /* TODO: b/430606659 - Implement the SGPIO Interrupt */
> +}
> +
> +static void aspeed_sgpio_get_pin(Object *obj, Visitor *v, const char *name,
> +                                void *opaque, Error **errp)
> +{
> +    bool level = true;
> +    int pin = 0xfff;
> +    AspeedSGPIOState *s = ASPEED_SGPIO(obj);
> +
> +    if (sscanf(name, "sgpio%d", &pin) != 1) {
> +        error_setg(errp, "%s: error reading %s", __func__, name);
> +        return;
> +    }
> +    level = aspeed_sgpio_get_pin_level(s, pin);
> +    visit_type_bool(v, name, &level, errp);
> +}
> +
> +static void aspeed_sgpio_set_pin(Object *obj, Visitor *v, const char *name,
> +                                void *opaque, Error **errp)
> +{
> +    bool level;
> +    int pin = 0xfff;
> +    AspeedSGPIOState *s = ASPEED_SGPIO(obj);
> +
> +    if (!visit_type_bool(v, name, &level, errp)) {
> +        return;
> +    }
> +    if (sscanf(name, "sgpio%d", &pin) != 1) {
> +        error_setg(errp, "%s: error reading %s", __func__, name);
> +        return;
> +    }
> +    aspeed_sgpio_set_pin_level(s, pin, level);
> +
> +}
> +static const MemoryRegionOps aspeed_gpio_2700_ops = {
> +  .read       = aspeed_sgpio_2700_read,
> +  .write      = aspeed_sgpio_2700_write,
> +  .endianness = DEVICE_LITTLE_ENDIAN,
> +  .valid.min_access_size = 4,
> +  .valid.max_access_size = 4,
> +};
> +
> +static void aspeed_sgpio_realize(DeviceState *dev, Error **errp)
> +{
> +    AspeedSGPIOState *s = ASPEED_SGPIO(dev);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> +    AspeedSGPIOClass *agc = ASPEED_SGPIO_GET_CLASS(s);
> +
> +    /* Interrupt parent line */
> +    sysbus_init_irq(sbd, &s->irq);
> +
> +    memory_region_init_io(&s->iomem, OBJECT(s), agc->reg_ops, s,
> +                          TYPE_ASPEED_SGPIO, agc->mem_size);
> +
> +    sysbus_init_mmio(sbd, &s->iomem);
> +}
> +
> +static void aspeed_sgpio_init(Object *obj)
> +{
> +    for (int i = 0; i < ASPEED_SGPIO_MAX_PIN_PAIR * 2; i++) {
> +        char *name = g_strdup_printf("sgpio%d", i);
> +        object_property_add(obj, name, "bool", aspeed_sgpio_get_pin,
> +                            aspeed_sgpio_set_pin, NULL, NULL);
> +        g_free(name);
> +    }
> +}
> +
> +static void aspeed_sgpio_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->realize = aspeed_sgpio_realize;
> +    dc->desc = "Aspeed SGPIO Controller";
> +}
> +
> +static void aspeed_sgpio_2700_class_init(ObjectClass *klass, const void *data)
> +{
> +    AspeedSGPIOClass *agc = ASPEED_SGPIO_CLASS(klass);
> +    agc->nr_sgpio_pin_pairs = 256;
> +    agc->mem_size = 0x1000;
> +    agc->reg_ops = &aspeed_gpio_2700_ops;
> +}
> +
> +static const TypeInfo aspeed_sgpio_info = {
> +    .name           = TYPE_ASPEED_SGPIO,
> +    .parent         = TYPE_SYS_BUS_DEVICE,
> +    .instance_size  = sizeof(AspeedSGPIOState),
> +    .class_size     = sizeof(AspeedSGPIOClass),
> +    .class_init     = aspeed_sgpio_class_init,
> +    .abstract       = true,
> +};
> +
> +static const TypeInfo aspeed_sgpio_ast2700_info = {
> +  .name           = TYPE_ASPEED_SGPIO "-ast2700",
> +  .parent         = TYPE_ASPEED_SGPIO,
> +  .class_init     = aspeed_sgpio_2700_class_init,
> +  .instance_init  = aspeed_sgpio_init,
> +};
> +
> +static void aspeed_sgpio_register_types(void)
> +{
> +    type_register_static(&aspeed_sgpio_info);
> +    type_register_static(&aspeed_sgpio_ast2700_info);
> +}
> +
> +type_init(aspeed_sgpio_register_types);
> diff --git a/hw/gpio/meson.build b/hw/gpio/meson.build
> index 74840619c01bf4d9a02c058c434c3ec9d2a55bee..6a67ee958faace69ffd3fe08e8ade31ced0faf7e 100644
> --- a/hw/gpio/meson.build
> +++ b/hw/gpio/meson.build
> @@ -16,5 +16,6 @@ system_ss.add(when: 'CONFIG_RASPI', if_true: files(
>   ))
>   system_ss.add(when: 'CONFIG_STM32L4X5_SOC', if_true: files('stm32l4x5_gpio.c'))
>   system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_gpio.c'))
> +system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_sgpio.c'))
>   system_ss.add(when: 'CONFIG_SIFIVE_GPIO', if_true: files('sifive_gpio.c'))
>   system_ss.add(when: 'CONFIG_PCF8574', if_true: files('pcf8574.c'))
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index 4b8e599f1a53bfb2e4d3196d5495cd316f799354..18ff961a38508c5df83b46e187f732d736443f20 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -32,6 +32,7 @@
>   #include "hw/net/ftgmac100.h"
>   #include "target/arm/cpu.h"
>   #include "hw/gpio/aspeed_gpio.h"
> +#include "hw/gpio/aspeed_sgpio.h"
>   #include "hw/sd/aspeed_sdhci.h"
>   #include "hw/usb/hcd-ehci.h"
>   #include "qom/object.h"
> @@ -46,6 +47,7 @@
>   #define VBOOTROM_FILE_NAME  "ast27x0_bootrom.bin"
>   
>   #define ASPEED_SPIS_NUM  3
> +#define ASPEED_SGPIO_NUM 2
>   #define ASPEED_EHCIS_NUM 4
>   #define ASPEED_WDTS_NUM  8
>   #define ASPEED_CPUS_NUM  4
> @@ -89,6 +91,7 @@ struct AspeedSoCState {
>       AspeedMiiState mii[ASPEED_MACS_NUM];
>       AspeedGPIOState gpio;
>       AspeedGPIOState gpio_1_8v;
> +    AspeedSGPIOState sgpiom[ASPEED_SGPIO_NUM];
>       AspeedSDHCIState sdhci;
>       AspeedSDHCIState emmc;
>       AspeedLPCState lpc;
> @@ -106,7 +109,6 @@ struct AspeedSoCState {
>       UnimplementedDeviceState pwm;
>       UnimplementedDeviceState espi;
>       UnimplementedDeviceState udc;
> -    UnimplementedDeviceState sgpiom;
>       UnimplementedDeviceState ltpi;
>       UnimplementedDeviceState jtag[ASPEED_JTAG_NUM];
>       AspeedAPB2OPBState fsi[2];
> @@ -166,6 +168,7 @@ struct AspeedSoCClass {
>       uint64_t secsram_size;
>       int pcie_num;
>       int spis_num;
> +    int sgpio_num;
>       int ehcis_num;
>       int wdts_num;
>       int macs_num;
> @@ -221,6 +224,8 @@ enum {
>       ASPEED_DEV_SDHCI,
>       ASPEED_DEV_GPIO,
>       ASPEED_DEV_GPIO_1_8V,
> +    ASPEED_DEV_SGPIOM0,
> +    ASPEED_DEV_SGPIOM1,
>       ASPEED_DEV_RTC,
>       ASPEED_DEV_TIMER1,
>       ASPEED_DEV_TIMER2,
> @@ -263,7 +268,6 @@ enum {
>       ASPEED_DEV_I3C,
>       ASPEED_DEV_ESPI,
>       ASPEED_DEV_UDC,
> -    ASPEED_DEV_SGPIOM,
>       ASPEED_DEV_JTAG0,
>       ASPEED_DEV_JTAG1,
>       ASPEED_DEV_FSI1,
> diff --git a/include/hw/gpio/aspeed_sgpio.h b/include/hw/gpio/aspeed_sgpio.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..a7d4868eeeb2f2caedcdff9858a6047ce5a1fcd8
> --- /dev/null
> +++ b/include/hw/gpio/aspeed_sgpio.h
> @@ -0,0 +1,38 @@
> +/*
> + * ASPEED Serial GPIO Controller
> + *
> + * Copyright 2025 Google LLC.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#ifndef ASPEED_SGPIO_H
> +#define ASPEED_SGPIO_H
> +
> +#include "hw/sysbus.h"
> +#include "qom/object.h"
> +
> +#define TYPE_ASPEED_SGPIO "aspeed.sgpio"
> +OBJECT_DECLARE_TYPE(AspeedSGPIOState, AspeedSGPIOClass, ASPEED_SGPIO)
> +
> +#define ASPEED_SGPIO_MAX_PIN_PAIR 256
> +#define ASPEED_SGPIO_MAX_INT 8
> +
> +struct AspeedSGPIOClass {
> +    SysBusDevice parent_obj;
> +    uint32_t nr_sgpio_pin_pairs;
> +    uint64_t mem_size;
> +    const MemoryRegionOps *reg_ops;
> +};
> +
> +struct AspeedSGPIOState {
> +  /* <private> */
> +  SysBusDevice parent;
> +
> +  /*< public >*/
> +  MemoryRegion iomem;
> +  qemu_irq irq;
> +  uint32_t ctrl_regs[ASPEED_SGPIO_MAX_PIN_PAIR];
> +  uint32_t int_regs[ASPEED_SGPIO_MAX_INT];
> +};
> +
> +#endif /* ASPEED_SGPIO_H */
> diff --git a/tests/qtest/ast2700-sgpio-test.c b/tests/qtest/ast2700-sgpio-test.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..a24fa29250d0c47b1ca7564280055de2c53f525b
> --- /dev/null
> +++ b/tests/qtest/ast2700-sgpio-test.c
> @@ -0,0 +1,94 @@
> +/*
> + * QTest testcase for the ASPEED AST2700 GPIO Controller.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + * Copyright (C) 2025 Google LLC.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qobject/qdict.h"
> +#include "qemu/bitops.h"
> +#include "qemu/timer.h"
> +#include "qobject/qdict.h"
> +#include "libqtest-single.h"
> +#include "qemu/error-report.h"
> +
> +#define ASPEED_SGPIO_MAX_PIN_PAIR 256
> +#define AST2700_SGPIO0_BASE 0x14C0C000
> +#define AST2700_SGPIO1_BASE 0x14C0D000
> +#define SGPIO_0_CONTROL 0x80
> +
> +static void test_output_pins(const char *machine, const uint32_t base, int idx)
> +{
> +    QTestState *s = qtest_init(machine);
> +    char name[16];
> +    char qom_path[64];
> +    uint32_t offset = 0;
> +    uint32_t value = 0;
> +    for (int i = 0; i < ASPEED_SGPIO_MAX_PIN_PAIR; i++) {
> +        /* Odd index is output port */
> +        sprintf(name, "sgpio%d", i * 2 + 1);
> +        sprintf(qom_path, "/machine/soc/sgpio[%d]", idx);
> +        offset = base + SGPIO_0_CONTROL + (i * 4);
> +        /* set serial output */
> +        qtest_writel(s, offset, 0x00000001);
> +        value = qtest_readl(s, offset);
> +        g_assert_cmphex(value, ==, 0x00000001);
> +        g_assert_cmphex(qtest_qom_get_bool(s, qom_path, name), ==, true);
> +
> +        /* clear serial output */
> +        qtest_writel(s, offset, 0x00000000);
> +        value = qtest_readl(s, offset);
> +        g_assert_cmphex(value, ==, 0);
> +        g_assert_cmphex(qtest_qom_get_bool(s, qom_path, name), ==, false);
> +    }
> +    qtest_quit(s);
> +}
> +
> +static void test_input_pins(const char *machine, const uint32_t base, int idx)
> +{
> +    QTestState *s = qtest_init(machine);
> +    char name[16];
> +    char qom_path[64];
> +    uint32_t offset = 0;
> +    uint32_t value = 0;
> +    for (int i = 0; i < ASPEED_SGPIO_MAX_PIN_PAIR; i++) {
> +        /* Even index is input port */
> +        sprintf(name, "sgpio%d", i * 2);
> +        sprintf(qom_path, "/machine/soc/sgpio[%d]", idx);
> +        offset = base + SGPIO_0_CONTROL + (i * 4);
> +        /* set serial input */
> +        qtest_qom_set_bool(s, qom_path, name, true);
> +        value = qtest_readl(s, offset);
> +        g_assert_cmphex(value, ==, 0x00002000);
> +        g_assert_cmphex(qtest_qom_get_bool(s, qom_path, name), ==, true);
> +
> +        /* clear serial input */
> +        qtest_qom_set_bool(s, qom_path, name, false);
> +        value = qtest_readl(s, offset);
> +        g_assert_cmphex(value, ==, 0);
> +        g_assert_cmphex(qtest_qom_get_bool(s, qom_path, name), ==, false);
> +    }
> +    qtest_quit(s);
> +}
> +
> +static void test_2700_input_pins(void)
> +{
> +    test_input_pins("-machine ast2700-evb",
> +                    AST2700_SGPIO0_BASE, 0);
> +    test_input_pins("-machine ast2700-evb",
> +                    AST2700_SGPIO1_BASE, 1);
> +    test_output_pins("-machine ast2700-evb",
> +                    AST2700_SGPIO0_BASE, 0);
> +    test_output_pins("-machine ast2700-evb",
> +                    AST2700_SGPIO1_BASE, 1);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +
> +    qtest_add_func("/ast2700/sgpio/input_pins", test_2700_input_pins);
> +
> +    return g_test_run();
> +}
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 669d07c06bdedc6be0c69acadeba989dc15ddf3f..5c80b2ed6de1f453d2483db482c1b0e7801ba980 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -221,6 +221,7 @@ qtests_aspeed = \
>   qtests_aspeed64 = \
>     ['ast2700-gpio-test',
>      'ast2700-hace-test',
> +   'ast2700-sgpio-test',
>      'ast2700-smc-test']
>   
>   qtests_stm32l4x5 = \
> 


