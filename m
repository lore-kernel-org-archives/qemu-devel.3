Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3793C54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 16:20:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnhcT-00074R-Kf; Fri, 22 Mar 2024 12:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rnhcD-00072N-Ec
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 12:19:33 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rnhcA-0001hZ-IB
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 12:19:33 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-56829f41f81so2806081a12.2
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 09:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711124369; x=1711729169; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=28LQpv9NKDyhE67yDxXNT/0dlTzgFiieairmBpny4Qg=;
 b=lg2KXCD0gMG/cjBHWF+SmT5L5KMHFz1+x8IQHCnLeGJQj6d33noLWb5wpoaO/dW61K
 ZZ2geP3GHmqFPZnE83/yYmpwWvKmxTQzQgb09P7aAKcOgpC7AGSTC1wXi9Yq+9l5LiD/
 VWBif97WPW+BhSfUbMiJwTrMO/Fz20PWPrHRSENHJlwy3g1fMXb/oOZVHGBOdhaot2IX
 ywn9hqAFgqlBYPsjIcAOpXlg9m6OI02N1SxZO383kFC45J7vn3q+ugOL/PnTSxPY+6pL
 LgpMzR3pm6Qx5yluqOwkL5c4WwXwIiB9RQOLviG9gzNLl0Xp1w/zFLWalM+Z15T1X3ry
 Ifag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711124369; x=1711729169;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=28LQpv9NKDyhE67yDxXNT/0dlTzgFiieairmBpny4Qg=;
 b=p2Q+N/8om5ZD5b6D8njiduJXpT6sSsOBti+4iCPT/mDQXX6F/nSVPkjDPgXWNSItaM
 HXfVlOQFRY+NdZmXf4yFe5OvEbKBpWjDmBQqQ3hQgEQPXbYz2yNupULmKvTOuuw7PUXA
 WDy4YhYi2HL/z++592JcUU0FKWNmidzJVCvilkH/79fHABCRAW7csDcFFWp7oE/8bUH2
 xLnsQ0hi87HkQqAFN5Lxl+t4vGQR+6T5ASq3c4/XwL0vXPesssjBZ4k3pwyyzpcyyeB2
 6Nc6JPPcD1MTR/vth2xpczAQvlIkSH46/ZoMHmaGS6Vtuy/SH2iDtXb+KFklPCFVbwsF
 SHAw==
X-Gm-Message-State: AOJu0Yw6earnpJsnp3LyZgiY+gU0z8osp/qOpZ0vXShg9/pXi6Krw1Ej
 qL6cDeEuRLSWrTt6nWSDJyGpYKmTRSUr7fBqTvEqSKPUa8FLu9Km58c5/Hqkr0FwaLDIPz26TRS
 FihqRV6j++FWaT83Zu40dZBaV7P32L8mXJIHph7sbarRl2r/KQsQ=
X-Google-Smtp-Source: AGHT+IE0ehZre/zLDmcviAwQkz8tMBt38uWu8hAbsjOritE6Bn3v70bLFT4PSl2vrt1+NqE33aFlRzJLfJHDZViiPGQ=
X-Received: by 2002:a50:999d:0:b0:56b:c003:16a6 with SMTP id
 m29-20020a50999d000000b0056bc00316a6mr2312012edb.23.1711124368880; Fri, 22
 Mar 2024 09:19:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240320202100.820228-1-balbi@kernel.org>
 <20240320202100.820228-2-balbi@kernel.org>
In-Reply-To: <20240320202100.820228-2-balbi@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Mar 2024 16:19:17 +0000
Message-ID: <CAFEAcA9ohYQZ6MwMtshBtaAjHTJ8nrM3bHPD9qyLH6DW7WN62g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] hw/arm: Add support for stm32g000 SoC family
To: Felipe Balbi <balbi@kernel.org>
Cc: qemu-devel@nongnu.org, Samuel Tardieu <sam@rfc1149.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, 20 Mar 2024 at 20:21, Felipe Balbi <balbi@kernel.org> wrote:
>
> Minimal support with USARTs and SPIs working. This SoC will be used to
> create and nucleo-g071rb board.
>
> Signed-off-by: Felipe Balbi <balbi@kernel.org>

Hi; thanks for this patchset, it looks pretty good, so I think
my review comments are mostly going to be fairly minor.

A note on timing: we're currently in freeze for the QEMU 9.0 release,
so although we can code review this patchset now, it won't go
upstream until we've released 9.0 and reopened the git trunk for
development (that's scheduled for mid-to-late April).

Do you plan to contribute further devices for this SoC in future,
or is the subset modelled in this patchset sufficient for your
uses? (I don't mind either way, just curious.)


> ---
>
> Changes since v1:
>     - Convert tabs to spaces (checkpatch.pl)
>     - Correct lines longer than 80 characters (checkpatch.pl)
>     - Correct num-prio-bits (Samuel Tardieu)
>     - Correct num-irqs (Found reviewing RM0444)
>
>  MAINTAINERS                    |   7 +
>  hw/arm/Kconfig                 |   6 +
>  hw/arm/meson.build             |   1 +
>  hw/arm/stm32g000_soc.c         | 253 +++++++++++++++++++++++++++++++++
>  include/hw/arm/stm32g000_soc.h |  62 ++++++++

The reference manual calls this SoC family "STM32G0x0", so I
think we should be in line with that and use stm32g0x0 in
filenames etc rather than 000. (This also matches what we've
done with the stm32l4x5.)

>  5 files changed, 329 insertions(+)
>  create mode 100644 hw/arm/stm32g000_soc.c
>  create mode 100644 include/hw/arm/stm32g000_soc.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 409d7db4d457..bce2eb3ad70b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1134,6 +1134,13 @@ F: hw/misc/stm32l4x5_rcc.c
>  F: hw/gpio/stm32l4x5_gpio.c
>  F: include/hw/*/stm32l4x5_*.h
>
> +STM32G000 SoC Family
> +M: Felipe Balbi <balbi@kernel.org>
> +L: qemu-arm@nongnu.org
> +S: Maintained
> +F: hw/arm/stm32g000_soc.c
> +F: include/hw/*/stm32g000_*.h
> +
>  B-L475E-IOT01A IoT Node
>  M: Arnaud Minier <arnaud.minier@telecom-paris.fr>
>  M: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 893a7bff66b9..28a46d2b1ad3 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -463,6 +463,12 @@ config STM32F405_SOC
>      select STM32F4XX_SYSCFG
>      select STM32F4XX_EXTI
>
> +config STM32G000_SOC
> +    bool
> +    select ARM_V7M
> +    select STM32F2XX_USART
> +    select STM32F2XX_SPI
> +
>  config B_L475E_IOT01A
>      bool
>      default y
> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
> index 6808135c1f79..9c4137a988e1 100644
> --- a/hw/arm/meson.build
> +++ b/hw/arm/meson.build
> @@ -34,6 +34,7 @@ arm_ss.add(when: ['CONFIG_RASPI', 'TARGET_AARCH64'], if=
_true: files('bcm2838.c',
>  arm_ss.add(when: 'CONFIG_STM32F100_SOC', if_true: files('stm32f100_soc.c=
'))
>  arm_ss.add(when: 'CONFIG_STM32F205_SOC', if_true: files('stm32f205_soc.c=
'))
>  arm_ss.add(when: 'CONFIG_STM32F405_SOC', if_true: files('stm32f405_soc.c=
'))
> +arm_ss.add(when: 'CONFIG_STM32G000_SOC', if_true: files('stm32g000_soc.c=
'))
>  arm_ss.add(when: 'CONFIG_B_L475E_IOT01A', if_true: files('b-l475e-iot01a=
.c'))
>  arm_ss.add(when: 'CONFIG_STM32L4X5_SOC', if_true: files('stm32l4x5_soc.c=
'))
>  arm_ss.add(when: 'CONFIG_XLNX_ZYNQMP_ARM', if_true: files('xlnx-zynqmp.c=
', 'xlnx-zcu102.c'))
> diff --git a/hw/arm/stm32g000_soc.c b/hw/arm/stm32g000_soc.c
> new file mode 100644
> index 000000000000..48531d41fcc7
> --- /dev/null
> +++ b/hw/arm/stm32g000_soc.c
> @@ -0,0 +1,253 @@
> +/*
> + * STM32G000 SoC
> + *
> + * Copyright (c) 2024 Felipe Balbi <felipe@balbi.sh>
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
> + * of this software and associated documentation files (the "Software"),=
 to deal
> + * in the Software without restriction, including without limitation the=
 rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
> + * THE SOFTWARE.
> + */


Somewhere near the top of the file it's nice to include a URL and
title for the documentation, if publicly available. I think in this
case it's

RM0454 Reference manual STM32G0x0 advanced Arm-based 32-bit MCUs
https://www.st.com/resource/en/reference_manual/rm0454-stm32g0x0-advanced-a=
rmbased-32bit-mcus-stmicroelectronics.pdf

(unless I've found the manual for the wrong SoC!)

> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu/module.h"
> +#include "hw/arm/boot.h"
> +#include "exec/address-spaces.h"
> +#include "hw/arm/stm32g000_soc.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/qdev-clock.h"
> +#include "hw/misc/unimp.h"
> +#include "sysemu/sysemu.h"
> +
> +/* stm32g000_soc implementation is derived from stm32f100_soc */
> +
> +struct stm32g0_ip_config {
> +    const char  *name;
> +    uint32_t    addr;
> +    uint32_t    irq;
> +};
> +
> +#define STM32G0_DEFINE_IP(n, a, i)    \
> +{                                     \
> +    .name =3D (n),                      \
> +    .addr =3D (a),                      \
> +    .irq =3D (i),                       \
> +}
> +
> +static const struct stm32g0_ip_config usart_config[STM_NUM_USARTS] =3D {
> +    STM32G0_DEFINE_IP("USART1", 0x40013800, 27),
> +    STM32G0_DEFINE_IP("USART2", 0x40004000, 28),

Manual says USART2 is at 0x40004400, USART3 at 0x4004800,
USART4 at 0x40004c00, USART5 at 0x40005000, and USART6 at
0x40013c00.

> +    STM32G0_DEFINE_IP("USART3", 0x40004400, 29),
> +    STM32G0_DEFINE_IP("USART4", 0x40004800, 29),
> +    STM32G0_DEFINE_IP("USART5", 0x40004c00, 29),
> +    STM32G0_DEFINE_IP("USART6", 0x40005000, 29),
> +    STM32G0_DEFINE_IP("LPUSART1", 0x40008000, 29),
> +    STM32G0_DEFINE_IP("LPUSART2", 0x40008400, 28),

The LPUSART* aren't listed in the manual.

This plus the code below tries to connect multiple UARTs to
a single input line on the armv7m object. This won't have the
correct behaviour -- if multiple device IRQs are all wired to
the same NVIC input IRQ the SoC device needs to create an OR
gate device and connect the IRQs from the devices to the inputs
of that OR gate, and then connect the OR gate output to the NVIC.
Have a look at how the other stm32* soc models do this with
TYPE_OR_IRQ objects (they don't do it with the UARTs, but they
have other devices that share interrupt lines).

> +};
> +
> +static const struct stm32g0_ip_config spi_config[STM_NUM_SPIS] =3D {
> +    STM32G0_DEFINE_IP("SPI1", 0x40013000, 25),
> +    STM32G0_DEFINE_IP("SPI2", 0x40003800, 26),
> +
> +    /* Only on STM32G0B1xx and STM32G0C1xx */
> +    /* STM32G0_DEFINE_IP("SPI3", 0x4003c000, 26), */
> +};
> +
> +static void stm32g000_soc_initfn(Object *obj)
> +{
> +    STM32G000State *s =3D STM32G000_SOC(obj);
> +    int i;
> +
> +    object_initialize_child(obj, "armv7m", &s->armv7m, TYPE_ARMV7M);
> +
> +    for (i =3D 0; i < STM_NUM_USARTS; i++) {
> +        object_initialize_child(obj, "usart[*]", &s->usart[i],
> +                                TYPE_STM32F2XX_USART);
> +    }
> +
> +    for (i =3D 0; i < STM_NUM_SPIS; i++) {
> +        object_initialize_child(obj, "spi[*]", &s->spi[i], TYPE_STM32F2X=
X_SPI);
> +    }
> +
> +    s->sysclk =3D qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0)=
;
> +    s->refclk =3D qdev_init_clock_in(DEVICE(s), "refclk", NULL, NULL, 0)=
;
> +}
> +
> +static void stm32g000_soc_realize(DeviceState *dev_soc, Error **errp)
> +{
> +    STM32G000State *s =3D STM32G000_SOC(dev_soc);
> +    DeviceState *dev, *armv7m;
> +    SysBusDevice *busdev;
> +
> +    MemoryRegion *system_memory =3D get_system_memory();
> +
> +    /*
> +     * We use s->refclk internally and only define it with qdev_init_clo=
ck_in()
> +     * so it is correctly parented and not leaked on an init/deinit; it =
is not
> +     * intended as an externally exposed clock.
> +     */
> +    if (clock_has_source(s->refclk)) {
> +        error_setg(errp, "refclk clock must not be wired up by the board=
 code");
> +        return;
> +    }
> +
> +    if (!clock_has_source(s->sysclk)) {
> +        error_setg(errp, "sysclk clock must be wired up by the board cod=
e");
> +        return;
> +    }
> +
> +    /*
> +     * TODO: ideally we should model the SoC RCC and its ability to
> +     * change the sysclk frequency and define different sysclk sources.
> +     */
> +
> +    /* The refclk always runs at frequency HCLK / 8 */
> +    clock_set_mul_div(s->refclk, 8, 1);
> +    clock_set_source(s->refclk, s->sysclk);
> +
> +    /*
> +     * Init flash region
> +     * Flash starts at 0x08000000 and then is aliased to boot memory at =
0x0
> +     */
> +    memory_region_init_rom(&s->flash, OBJECT(dev_soc), "STM32G000.flash"=
,
> +                           FLASH_SIZE, &error_fatal);
> +    memory_region_init_alias(&s->flash_alias, OBJECT(dev_soc),
> +                             "STM32G000.flash.alias", &s->flash, 0, FLAS=
H_SIZE);
> +    memory_region_add_subregion(system_memory, FLASH_BASE_ADDRESS, &s->f=
lash);
> +    memory_region_add_subregion(system_memory, 0, &s->flash_alias);
> +
> +    /* Init SRAM region */
> +    memory_region_init_ram(&s->sram, NULL, "STM32G000.sram", SRAM_SIZE,
> +                           &error_fatal);
> +    memory_region_add_subregion(system_memory, SRAM_BASE_ADDRESS, &s->sr=
am);
> +
> +    /* Init ARMv7m */
> +    armv7m =3D DEVICE(&s->armv7m);
> +    qdev_prop_set_uint32(armv7m, "num-irq", 32);
> +    qdev_prop_set_uint8(armv7m, "num-prio-bits", 2);
> +    qdev_prop_set_string(armv7m, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m=
0"));
> +    qdev_prop_set_bit(armv7m, "enable-bitband", true);
> +    qdev_connect_clock_in(armv7m, "cpuclk", s->sysclk);
> +    qdev_connect_clock_in(armv7m, "refclk", s->refclk);
> +    object_property_set_link(OBJECT(&s->armv7m), "memory",
> +                             OBJECT(get_system_memory()), &error_abort);
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->armv7m), errp)) {
> +        return;
> +    }
> +
> +    /* Attach UART (uses USART registers) and USART controllers */
> +    for (unsigned i =3D 0; i < STM_NUM_USARTS; i++) {
> +        dev =3D DEVICE(&(s->usart[i]));
> +        qdev_prop_set_chr(dev, "chardev", serial_hd(i));
> +        if (!sysbus_realize(SYS_BUS_DEVICE(&s->usart[i]), errp)) {
> +            return;
> +        }
> +        busdev =3D SYS_BUS_DEVICE(dev);
> +        sysbus_mmio_map(busdev, 0, usart_config[i].addr);
> +        sysbus_connect_irq(busdev,
> +                           0,
> +                           qdev_get_gpio_in(armv7m, usart_config[i].irq)=
);
> +    }
> +
> +    /*
> +     * SPI 1 and 2
> +     *
> +     * REVISIT: STM32G0B1xx and STM32G0C1xx have a 3rd SPI
> +     */
> +    for (unsigned i =3D 0; i < STM_NUM_SPIS; i++) {
> +        dev =3D DEVICE(&(s->spi[i]));
> +        if (!sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), errp)) {
> +            return;
> +        }
> +        busdev =3D SYS_BUS_DEVICE(dev);
> +        sysbus_mmio_map(busdev, 0, spi_config[i].addr);
> +        sysbus_connect_irq(busdev,
> +                           0,
> +                           qdev_get_gpio_in(armv7m, spi_config[i].irq));
> +    }
> +
> +    /* Review addresses */

Good idea :-)

> +    create_unimplemented_device("timer[2]",  0x40000000, 0x400);

No TIM2.

> +    create_unimplemented_device("timer[3]",  0x40000400, 0x400);
> +    create_unimplemented_device("timer[4]",  0x40000800, 0x400);
> +    create_unimplemented_device("timer[6]",  0x40001000, 0x400);
> +    create_unimplemented_device("timer[7]",  0x40001400, 0x400);

There's a TIM14 at 0x40002000.

> +    create_unimplemented_device("RTC",       0x40002800, 0x400);
> +    create_unimplemented_device("WWDG",      0x40002c00, 0x400);
> +    create_unimplemented_device("IWDG",      0x40003000, 0x400);
> +    create_unimplemented_device("USB",       0x40005000, 0x400);

Missing I2C1 and I2C2 at 0x40005400, 0x40005800.

USB is at 0x40005c00.

> +    create_unimplemented_device("FDCAN1",    0x40006400, 0x400);
> +    create_unimplemented_device("FDCAN2",    0x40006800, 0x400);
> +    create_unimplemented_device("CRS",       0x40006c00, 0x400);

These three aren't listed in the manual.

> +    create_unimplemented_device("PWR",       0x40007000, 0x400);
> +    create_unimplemented_device("DAC",       0x40007400, 0x400);
> +    create_unimplemented_device("CEC",       0x40007800, 0x400);
> +    create_unimplemented_device("LPTIM1",    0x40007c00, 0x400);

No DAC, CEC, LPTIM1 listed.

> +    create_unimplemented_device("LPUART1",   0x40008000, 0x400);
> +    create_unimplemented_device("LPUART2",   0x40008400, 0x400);

These aren't listed, and you also create real UARTs in the code above
at these addresses.

> +    create_unimplemented_device("I2C3",      0x40008800, 0x400);

> +    create_unimplemented_device("LPTIM2",    0x40009400, 0x400);
> +    create_unimplemented_device("USB RAM1",  0x40009800, 0x400);
> +    create_unimplemented_device("USB RAM2",  0x40009c00, 0x400);
> +    create_unimplemented_device("UCPD1",     0x4000a000, 0x400);
> +    create_unimplemented_device("UCPD2",     0x4000a400, 0x400);

These 5 aren't listed.

> +    create_unimplemented_device("TAMP",      0x4000b000, 0x400);

Missing SYSCFG at 0x40010000 and SYSCFG(ITLINE) at 0x40010080.

> +    create_unimplemented_device("FDCAN",     0x4000b400, 0x800);

No FDCAN.

> +    create_unimplemented_device("ADC",       0x40012400, 0x400);
> +    create_unimplemented_device("timer[1]",  0x40012C00, 0x400);
> +    create_unimplemented_device("timer[15]", 0x40014000, 0x400);
> +    create_unimplemented_device("timer[16]", 0x40014400, 0x400);
> +    create_unimplemented_device("timer[17]", 0x40014800, 0x400);

Missing DBG at 0x40015800.

> +    create_unimplemented_device("DMA1",      0x40020000, 0x400);
> +    create_unimplemented_device("DMA2",      0x40020400, 0x400);
> +    create_unimplemented_device("DMAMUX",    0x40020800, 0x800);
> +    create_unimplemented_device("RCC",       0x40021000, 0x400);
> +    create_unimplemented_device("EXTI",      0x40021800, 0x400);
> +    create_unimplemented_device("FLASH",     0x40022000, 0x400);
> +    create_unimplemented_device("CRC",       0x40023000, 0x400);
> +    create_unimplemented_device("RNG",       0x40025000, 0x400);
> +    create_unimplemented_device("AES",       0x40026000, 0x400);

No RNG or AES.

> +    create_unimplemented_device("GPIOA",     0x50000000, 0x400);
> +    create_unimplemented_device("GPIOB",     0x50000400, 0x400);
> +    create_unimplemented_device("GPIOC",     0x50000800, 0x400);
> +    create_unimplemented_device("GPIOD",     0x50000c00, 0x400);
> +    create_unimplemented_device("GPIOE",     0x50001000, 0x400);
> +    create_unimplemented_device("GPIOF",     0x50001400, 0x400);
> +}
> +
> +static void stm32g000_soc_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    dc->realize =3D stm32g000_soc_realize;
> +    /* No vmstate or reset required: device has no internal state */
> +}
> +
> +static const TypeInfo stm32g000_soc_info =3D {
> +    .name          =3D TYPE_STM32G000_SOC,
> +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_size =3D sizeof(STM32G000State),
> +    .instance_init =3D stm32g000_soc_initfn,
> +    .class_init    =3D stm32g000_soc_class_init,
> +};
> +
> +static void stm32g000_soc_types(void)
> +{
> +    type_register_static(&stm32g000_soc_info);
> +}
> +
> +type_init(stm32g000_soc_types)
> diff --git a/include/hw/arm/stm32g000_soc.h b/include/hw/arm/stm32g000_so=
c.h
> new file mode 100644
> index 000000000000..dd3857c87189
> --- /dev/null
> +++ b/include/hw/arm/stm32g000_soc.h
> @@ -0,0 +1,62 @@
> +/*
> + * STM32G000 SoC
> + *
> + * Copyright (c) 2024 Felipe Balbi <felipe@balbi.sh>
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
> + * of this software and associated documentation files (the "Software"),=
 to deal
> + * in the Software without restriction, including without limitation the=
 rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
> + * THE SOFTWARE.
> + */
> +
> +#ifndef HW_ARM_STM32G000_SOC_H
> +#define HW_ARM_STM32G000_SOC_H
> +
> +#include "hw/gpio/stm32l4x5_gpio.h"
> +#include "hw/char/stm32f2xx_usart.h"
> +#include "hw/ssi/stm32f2xx_spi.h"
> +#include "hw/arm/armv7m.h"
> +#include "qom/object.h"
> +#include "hw/clock.h"
> +
> +#define TYPE_STM32G000_SOC "stm32g000-soc"
> +OBJECT_DECLARE_SIMPLE_TYPE(STM32G000State, STM32G000_SOC)
> +
> +#define STM_NUM_USARTS 8
> +#define STM_NUM_SPIS 2
> +
> +#define FLASH_BASE_ADDRESS 0x08000000
> +#define FLASH_SIZE (128 * 1024)
> +#define SRAM_BASE_ADDRESS 0x20000000
> +#define SRAM_SIZE (36 * 1024)

It looks like the different SoCs in this family have different
flash and SRAM sizes -- we're modelling the STM32G070xx here,
from the looks of these numbers. Is that right? I think it's
worth at least a comment that for the moment we're modelling
the settings for a particular SoC in the family.

> +
> +struct STM32G000State {
> +    SysBusDevice parent_obj;
> +
> +    ARMv7MState armv7m;
> +
> +    STM32F2XXUsartState usart[STM_NUM_USARTS];
> +    STM32F2XXSPIState spi[STM_NUM_SPIS];
> +
> +    MemoryRegion sram;
> +    MemoryRegion flash;
> +    MemoryRegion flash_alias;
> +
> +    Clock *sysclk;
> +    Clock *refclk;
> +};
> +
> +#endif
> --
> 2.44.0
>

thanks
-- PMM

