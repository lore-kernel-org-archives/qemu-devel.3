Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA319CCFA1A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 03:57:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJ1z1-0002L0-9e; Tue, 11 Nov 2025 22:57:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vJ1yt-0002Eg-7j
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 22:57:15 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vJ1yn-0006Hp-KM
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 22:57:13 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-641677916b5so640661a12.0
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 19:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762919828; x=1763524628; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eVDzwRHjN/AY3K1BQ8UvaIjcqSvVJSb+UWkTPvFtTJQ=;
 b=YH/LrndkKIypTQw30IVH2uOBdggNlgpJc0lIW9kTlyxOV8OUrm0UYZoKMoaidoCNQj
 7I3GT96TALr6DG1EYR55G8VS+hbZlCqo3tkXntKWlM8QtPrlQkDPhPYWLNx54XzGPgjL
 80teaqayqh8Vtp7OqrOzLPc+Dy/TeCd72shllo6v2b69dgVRaTQxpOapWAa5T1Pat3cK
 i0O2AbuVj1edCD5zNz2jQf3DKVOTQvUqS2dwDO0m4W2r3O7ymqB6Zy5Snol8SZTGXtz8
 WPvRA5BuV1Np+kHrEkidbcQl5rBFOxF2QpHpLpmWnewnas5uHa+JZCBr2HpgN8/KSn44
 ulvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762919828; x=1763524628;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eVDzwRHjN/AY3K1BQ8UvaIjcqSvVJSb+UWkTPvFtTJQ=;
 b=QWHaO9M75JAF+0/IsI4fg61AIWl2+5hKjffI7Q86pUKBJya9ClrMgwf4ycJdnofrEV
 r/48NNgHrmbV2P8FRLMNRk4SJ1d9IIsduyGhHGDTv9lEkmFDbbPy8LlR2ZuoPesT6jnS
 yvQfCy0HWmQ00Xo+vXFXw3Vh10WgMgSd1NI/qDwyN/pGJ+y5i5bDZZxwOgNgBrMPmNcG
 /lU1BX5XbOO6wAVca1V7OF5W4HT7w9mIIYn7Bb0kPGxX0zqD5o4TRlkEEzLbWOc6uCR9
 jBpwPGKVglAPWkfWMQOVJggp5D1TEYbjG9Mul2T+sI9k5H03vz7gF5a0XVobh03o3IJV
 hKZg==
X-Gm-Message-State: AOJu0YxSNmfcawdMdE0DOQC33jGBR8MoGVGwkJKtd/5VqFRstiAtJ6Tw
 EYaRa8naHCMb1HgWnaMUjC7bCaV3ykFdUcr9XZYreO6xqr18/N+WMMpcobcWQFxsYnYGBTW94Xl
 uc97h0vUg2jGKEokwNhy9mgttdS12v/ZSng==
X-Gm-Gg: ASbGncuJsy7uZFj4uYXx6aN4tBzWfCjVquRfg07PTARtgz8TK056R2CVjiisQ+vjuBc
 M+Ys5p3hxqlB6B63WP6TR/ywuREepMhv6VRK4wj/P0WJmh9DSLLyYhLluwoROWhqI6So2a47lAx
 AU2SVmUz6SR2YwtbJjONSuWS8ggHchcz7iYHeQyJSY5LB1G7IfVEsDTvwvSzQujstmeBKmmwnJ4
 Zn+l8grJGvQOUbvjBaXridw7c/jkUqKU7gXNz4H42Grl2rJEr+/snVfRcyvg6ek6N1zOg1YtpYg
 29gId3WZdCIVKZk=
X-Google-Smtp-Source: AGHT+IFCOW+e+xwLX8SjzCkrKStP7gDjOEA0D07xaR9Dyy2G4tnEA7NhrZNs0MjPX++AHFY/zdOMwzGB2pZgulk6bW4=
X-Received: by 2002:a17:907:8687:b0:b71:f9d5:70d5 with SMTP id
 a640c23a62f3a-b73319b06f0mr159048566b.27.1762919827569; Tue, 11 Nov 2025
 19:57:07 -0800 (PST)
MIME-Version: 1.0
References: <20251026105320.5591-1-fanyihao@rt-thread.org>
 <20251026105320.5591-2-fanyihao@rt-thread.org>
In-Reply-To: <20251026105320.5591-2-fanyihao@rt-thread.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 12 Nov 2025 13:56:41 +1000
X-Gm-Features: AWmQ_bmUPUHLUPqhXuKHLDrVWB0OlyinMKNgJUVGdtzGbsmxV1hT9vY_ax97CLE
Message-ID: <CAKmqyKMYMzpSvf05EB6_G_W+HEVk7xZ7M6vwVAyhnvOPtU-qkw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] hw/arm: Add support for the STM32F407 SoC|
To: fanyihao@rt-thread.org
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x534.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Sun, Oct 26, 2025 at 9:02=E2=80=AFPM <fanyihao@rt-thread.org> wrote:
>
> From: Yihao Fan <fanyihao@rt-thread.org>
>
> This patch introduces a new QEMU machine type for the STM32F407 SoC featu=
ring a Cortex-M4 core.
> This will be used by the RT-Spark to create a machine.
> Furthermore, I have updated the reusable USART, timer,
> and RCC drivers to align with the existing driver implementations.
>
> Signed-off-by: Yihao Fan <fanyihao@rt-thread.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  MAINTAINERS                    |   7 ++
>  hw/arm/Kconfig                 |   6 +
>  hw/arm/meson.build             |   1 +
>  hw/arm/stm32f407_soc.c         | 208 +++++++++++++++++++++++++++++++++
>  include/hw/arm/stm32f407_soc.h |  74 ++++++++++++
>  5 files changed, 296 insertions(+)
>  create mode 100644 hw/arm/stm32f407_soc.c
>  create mode 100644 include/hw/arm/stm32f407_soc.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 36eef27b419..ceef177740b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1163,6 +1163,13 @@ F: hw/misc/stm32f4xx_exti.c
>  F: hw/misc/stm32_rcc.c
>  F: include/hw/misc/stm32_rcc.h
>
> +STM32F407
> +M: yanl1229 <yanl1229@rt-thread.org>
> +M: Yihao Fan <fanyihao@rt-thread.org>
> +L: qemu-arm@nongnu.org
> +S: Maintained
> +F: hw/arm/stm32f407_soc.c
> +
>  Netduino 2
>  M: Alistair Francis <alistair@alistair23.me>
>  M: Peter Maydell <peter.maydell@linaro.org>
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index b44b85f4361..bbf675c158c 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -406,6 +406,12 @@ config STM32F405_SOC
>      select STM32F4XX_SYSCFG
>      select STM32F4XX_EXTI
>
> +config STM32F407_SOC
> +    bool
> +    select ARM_V7M
> +    select STM32F4XX_SYSCFG
> +    select STM32F4XX_EXTI
> +
>  config B_L475E_IOT01A
>      bool
>      default y
> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
> index b88b5b06d7e..1de2642620a 100644
> --- a/hw/arm/meson.build
> +++ b/hw/arm/meson.build
> @@ -33,6 +33,7 @@ arm_common_ss.add(when: ['CONFIG_RASPI', 'TARGET_AARCH6=
4'], if_true: files('bcm2
>  arm_common_ss.add(when: 'CONFIG_STM32F100_SOC', if_true: files('stm32f10=
0_soc.c'))
>  arm_common_ss.add(when: 'CONFIG_STM32F205_SOC', if_true: files('stm32f20=
5_soc.c'))
>  arm_common_ss.add(when: 'CONFIG_STM32F405_SOC', if_true: files('stm32f40=
5_soc.c'))
> +arm_common_ss.add(when: 'CONFIG_STM32F407_SOC', if_true: files('stm32f40=
7_soc.c'))
>  arm_common_ss.add(when: 'CONFIG_B_L475E_IOT01A', if_true: files('b-l475e=
-iot01a.c'))
>  arm_common_ss.add(when: 'CONFIG_STM32L4X5_SOC', if_true: files('stm32l4x=
5_soc.c'))
>  arm_common_ss.add(when: 'CONFIG_XLNX_ZYNQMP_ARM', if_true: files('xlnx-z=
ynqmp.c', 'xlnx-zcu102.c'))
> diff --git a/hw/arm/stm32f407_soc.c b/hw/arm/stm32f407_soc.c
> new file mode 100644
> index 00000000000..8e20ddcd5b1
> --- /dev/null
> +++ b/hw/arm/stm32f407_soc.c
> @@ -0,0 +1,208 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +/*
> + * Copyright (c) liang yan <yanl1229@rt-thread.org>
> + * Copyright (c) Yihao Fan <fanyihao@rt-thread.org>
> + * The reference used is the STMicroElectronics RM0090 Reference manual
> + * https://www.st.com/en/microcontrollers-microprocessors/stm32f407-417/=
documentation.html
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "system/address-spaces.h"
> +#include "system/system.h"
> +#include "hw/arm/stm32f407_soc.h"
> +#include "hw/qdev-clock.h"
> +#include "hw/misc/unimp.h"
> +#include "hw/sd/sd.h"
> +#include "hw/boards.h"
> +#include "qom/object.h"
> +
> +static const uint32_t syscfg_addr =3D 0x40013800;
> +static const uint32_t exti_addr =3D 0x40013C00;
> +static const uint32_t usart_addr[STM_NUM_USARTS] =3D {
> +    STM32F407_USART1, STM32F407_USART2, STM32F407_USART3,
> +    STM32F407_USART6
> +};
> +/* At the moment only Timer 2 to 5 are modelled */
> +static const uint32_t timer_addr[STM_NUM_TIMERS] =3D {
> +    STM32F407_TIM2, STM32F407_TIM3, STM32F407_TIM4,
> +    STM32F407_TIM5
> +};
> +static const int syscfg_irq =3D 71;
> +static const int exti_irq[] =3D {
> +    6, 7, 8, 9, 10, 23, 23, 23, 23, 23, 40,
> +    40, 40, 40, 40, 40
> +};
> +static const int usart_irq[STM_NUM_USARTS] =3D {
> +    37, 38, 39, 71
> +};
> +static const int timer_irq[STM_NUM_TIMERS] =3D {
> +    28, 29, 30, 50
> +};
> +
> +static void stm32f407_soc_initfn(Object *obj)
> +{
> +    int i;
> +
> +    STM32F407State *s =3D STM32F407_SOC(obj);
> +
> +    object_initialize_child(obj, "armv7m", &s->armv7m, TYPE_ARMV7M);
> +    object_initialize_child(obj, "syscfg", &s->syscfg, TYPE_STM32F4XX_SY=
SCFG);
> +    object_initialize_child(obj, "exti", &s->exti, TYPE_STM32F4XX_EXTI);
> +    object_initialize_child(obj, "rcc", &s->rcc, TYPE_STM32_RCC);
> +
> +    for (i =3D 0; i < STM_NUM_USARTS; i++) {
> +        object_initialize_child(obj, "usart[*]", &s->usart[i],
> +                                TYPE_STM32F2XX_USART);
> +    }
> +
> +    for (i =3D 0; i < STM_NUM_TIMERS; i++) {
> +        object_initialize_child(obj, "timer[*]", &s->timer[i],
> +                                TYPE_STM32F2XX_TIMER);
> +    }
> +
> +    s->sysclk =3D qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0)=
;
> +    s->refclk =3D qdev_init_clock_in(DEVICE(s), "refclk", NULL, NULL, 0)=
;
> +}
> +
> +static void stm32f407_soc_realize(DeviceState *dev_soc, Error **errp)
> +{
> +    STM32F407State *s =3D STM32F407_SOC(dev_soc);
> +    DeviceState *dev, *armv7m;
> +    SysBusDevice *busdev;
> +    DriveInfo *dinfo;
> +    int i, j;
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
> +    memory_region_init_rom(&s->flash, OBJECT(dev_soc), "STM32F407.flash"=
,
> +                           FLASH_SIZE, &error_fatal);
> +    memory_region_init_alias(&s->flash_alias, OBJECT(dev_soc),
> +                             "STM32F407.flash.alias", &s->flash, 0, FLAS=
H_SIZE);
> +
> +    memory_region_add_subregion(system_memory, FLASH_BASE_ADDRESS, &s->f=
lash);
> +    memory_region_add_subregion(system_memory, 0, &s->flash_alias);
> +
> +    memory_region_init_ram(&s->sram, NULL, "STM32F407.sram", SRAM_SIZE,
> +                           &error_fatal);
> +    memory_region_add_subregion(system_memory, SRAM_BASE_ADDRESS, &s->sr=
am);
> +
> +    memory_region_init_ram(&s->ccm, NULL, "STM32F407.ccm", CCM_SIZE,
> +                           &error_fatal);
> +    memory_region_add_subregion(system_memory, CCM_BASE_ADDRESS, &s->ccm=
);
> +
> +    armv7m =3D DEVICE(&s->armv7m);
> +    qdev_prop_set_uint32(armv7m, "num-irq", 98);
> +    qdev_prop_set_string(armv7m, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m=
4"));
> +    qdev_prop_set_bit(armv7m, "enable-bitband", true);
> +    qdev_connect_clock_in(armv7m, "cpuclk", s->sysclk);
> +    qdev_connect_clock_in(armv7m, "refclk", s->refclk);
> +    object_property_set_link(OBJECT(&s->armv7m), "memory",
> +                             OBJECT(system_memory), &error_abort);
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->armv7m), errp)) {
> +        return;
> +    }
> +
> +    /* Reset and clock controller */
> +    dev =3D DEVICE(&s->rcc);
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->rcc), errp)) {
> +        return;
> +    }
> +    busdev =3D SYS_BUS_DEVICE(dev);
> +    sysbus_mmio_map(busdev, 0, RCC_BASE_ADDR);
> +
> +    /* System configuration controller */
> +    dev =3D DEVICE(&s->syscfg);
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->syscfg), errp)) {
> +        return;
> +    }
> +    busdev =3D SYS_BUS_DEVICE(dev);
> +    sysbus_mmio_map(busdev, 0, syscfg_addr);
> +    sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, syscfg_irq));
> +
> +    /* EXTI device */
> +    dev =3D DEVICE(&s->exti);
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->exti), errp)) {
> +        return;
> +    }
> +    busdev =3D SYS_BUS_DEVICE(dev);
> +    sysbus_mmio_map(busdev, 0, exti_addr);
> +    for (i =3D 0; i < 16; i++) {
> +        sysbus_connect_irq(busdev, i, qdev_get_gpio_in(armv7m, exti_irq[=
i]));
> +    }
> +    for (i =3D 0; i < 16; i++) {
> +        qdev_connect_gpio_out(DEVICE(&s->syscfg), i, qdev_get_gpio_in(de=
v, i));
> +    }
> +
> +    /* Attach UART (uses USART registers) and USART controllers */
> +    for (i =3D 0; i < STM_NUM_USARTS; i++) {
> +        dev =3D DEVICE(&(s->usart[i]));
> +        qdev_prop_set_chr(dev, "chardev", serial_hd(i));
> +        if (!sysbus_realize(SYS_BUS_DEVICE(&s->usart[i]), errp)) {
> +            return;
> +        }
> +        busdev =3D SYS_BUS_DEVICE(dev);
> +        sysbus_mmio_map(busdev, 0, usart_addr[i]);
> +        sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, usart_irq=
[i]));
> +    }
> +
> +    /* Timer 2 to 5 contoller */
> +    for (i =3D 0; i < STM_NUM_TIMERS; i++) {
> +        dev =3D DEVICE(&(s->timer[i]));
> +        qdev_prop_set_uint64(dev, "clock-frequency", 1000000000);
> +        if (!sysbus_realize(SYS_BUS_DEVICE(&s->timer[i]), errp)) {
> +            return;
> +        }
> +        busdev =3D SYS_BUS_DEVICE(dev);
> +        sysbus_mmio_map(busdev, 0, timer_addr[i]);
> +        sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, timer_irq=
[i]));
> +    }
> +
> +}
> +
> +static void stm32f407_soc_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    dc->realize =3D stm32f407_soc_realize;
> +}
> +
> +static const TypeInfo stm32f407_soc_info =3D {
> +    .name          =3D TYPE_STM32F407_SOC,
> +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_size =3D sizeof(STM32F407State),
> +    .instance_init =3D stm32f407_soc_initfn,
> +    .class_init    =3D stm32f407_soc_class_init,
> +};
> +
> +static void stm32f407_soc_types(void)
> +{
> +    type_register_static(&stm32f407_soc_info);
> +}
> +
> +type_init(stm32f407_soc_types)
> diff --git a/include/hw/arm/stm32f407_soc.h b/include/hw/arm/stm32f407_so=
c.h
> new file mode 100644
> index 00000000000..3497e91aa1c
> --- /dev/null
> +++ b/include/hw/arm/stm32f407_soc.h
> @@ -0,0 +1,74 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +/*
> + * Copyright (c) liang yan <yanl1229@rt-thread.org>
> + * Copyright (c) Yihao Fan <fanyihao@rt-thread.org>
> + * The reference used is the STMicroElectronics RM0090 Reference manual
> + * https://www.st.com/en/microcontrollers-microprocessors/stm32f407-417/=
documentation.html
> + */
> +
> +#ifndef STM32F407_SOC_H
> +#define STM32F407_SOC_H
> +
> +#include "hw/or-irq.h"
> +#include "hw/arm/armv7m.h"
> +#include "hw/misc/stm32f4xx_syscfg.h"
> +#include "hw/misc/stm32f4xx_exti.h"
> +#include "hw/char/stm32f2xx_usart.h"
> +#include "hw/timer/stm32f2xx_timer.h"
> +#include "hw/misc/stm32_rcc.h"
> +#include "qom/object.h"
> +
> +#define TYPE_STM32F407_SOC "stm32f407-soc"
> +OBJECT_DECLARE_SIMPLE_TYPE(STM32F407State, STM32F407_SOC)
> +
> +#define STM_NUM_USARTS      4
> +#define STM32F407_USART1    0x40011000
> +#define STM32F407_USART2    0x40004400
> +#define STM32F407_USART3    0x40004800
> +#define STM32F407_USART6    0x40011400
> +
> +#define STM_NUM_TIMERS      4
> +#define STM32F407_TIM1      0x40010000
> +#define STM32F407_TIM2      0x40000000
> +#define STM32F407_TIM3      0x40000400
> +#define STM32F407_TIM4      0x40000800
> +#define STM32F407_TIM5      0x40000c00
> +
> +#define RCC_BASE_ADDR       0x40023800
> +#define SYSCFG_BASE_ADDRESS 0x40013800
> +#define SYSCFG_IRQ  71
> +#define EXIT_BASE_ADDRESS 0x40013C00
> +
> +#define FLASH_BASE_ADDRESS  0x8000000
> +#define FLASH_SIZE          0x100000
> +#define SRAM_BASE_ADDRESS   0x20000000
> +#define SRAM_SIZE           (192 * 1024)
> +#define CCM_BASE_ADDRESS    0x10000000
> +#define CCM_SIZE            (64 * 1024)
> +
> +typedef struct STM32F407State {
> +    /*< private >*/
> +    SysBusDevice parent_obj;
> +    /*< public >*/
> +
> +    ARMv7MState armv7m;
> +
> +    STM32RccState rcc;
> +    STM32F4xxSyscfgState syscfg;
> +    STM32F4xxExtiState exti;
> +    STM32F2XXUsartState usart[STM_NUM_USARTS];
> +    STM32F2XXTimerState timer[STM_NUM_TIMERS];
> +
> +    MemoryRegion ccm;
> +    MemoryRegion sram;
> +    MemoryRegion flash;
> +    MemoryRegion flash_alias;
> +
> +    Clock *sysclk;
> +    Clock *refclk;
> +
> +
> +} STM32F407State;
> +
> +#endif
> --
> 2.43.0
>
>

