Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29165C47DD9
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 00:10:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reOYb-00074n-UH; Sun, 25 Feb 2024 19:09:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1reOY9-0006i5-CP; Sun, 25 Feb 2024 19:08:55 -0500
Received: from mail-ua1-x935.google.com ([2607:f8b0:4864:20::935])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1reOY2-0001xj-H7; Sun, 25 Feb 2024 19:08:48 -0500
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-7cedcea89a0so1679431241.1; 
 Sun, 25 Feb 2024 16:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708906125; x=1709510925; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9oXWvLBhmXWKmclMs2SgW8qE+t3mFOBzF7BBgUy0c5s=;
 b=iBydyl82owwzpUGZAiXlbx6k0qbfuEWSWrC1yBNKMD6JicnwfQN8bEaEzCI9g5BI7C
 dGTeMH6XBNAdMWaxkFeUYP1wba2ENiE3F7ZA7kyM3vUNW86A0Rj3ya1cJvxjpJUstyeQ
 QEX3cBsWDMUXfMf7sfIwEcsjlvBAHN5JXZHnwX+mBZxn+C+FUGmWjDYCGDjhxLWXV5Qy
 ba+f+6K/v7rwQoRxFUJIijfBqMvSe1S+TM1qkNFRaLBbZFg7LBpJaGj++/pcrQX/4zn/
 6yIHSPScSKwV49M8FeeR31n9QLf0xDiYR2NP30avuYZlfNZrrz7RskqV4Y/eGSuN5kHd
 dc0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708906125; x=1709510925;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9oXWvLBhmXWKmclMs2SgW8qE+t3mFOBzF7BBgUy0c5s=;
 b=SiPGW7qPIosIsAH++lZAGD4Cb7V5PyNQO1EpsoESemrjd+KDActkkFKqfC9wvzmpLl
 7Fb2F5aVFCyIVcU2CKjZ/4hVzUngDZDIvaEdq9xM+V2CHP8hTTrvXDa9D51iFHFqpmwK
 s3eqaWadG3FG+r/FXHk/stgagB1KMyEtfMuQ/FUfcNi/jfNhAN8jvRUe5VY8SRRxR1E5
 Orw7VeKaHmxPI4RFt3SyPn1mcvSk94SIykh6uWfEGkP22ed8yZrP9rhGlkUHm57SZByp
 S9Yv9M6kWxwmC33MxswPLx07wH4YqmPLc5WjuVzFQMeWpxS/Mek7dRKrhxL61f2XNfIP
 MLLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV73Mf05atPDD/7icfiMOQy86Chi9T8DLBQJv61DwZGi6Ie5rhevNgDXbCT9rl2iq9p3Up4mgHM20Dgq3snz0dQJGaM
X-Gm-Message-State: AOJu0YwYtP7b25Y824ADoRGpHCjtcoCy8RpX2B+F8agzFMhJ7Ullx1Bw
 AUvaQRk5ymoKcvQhfN+G2j8KGBTtIdrWXn1rAoBwOqoLl+YVX2FRUWHCtQ7kG0DZ8SZa2y3PfE6
 gUvoVp2ecIbzCAXanflKKlqsvFpM=
X-Google-Smtp-Source: AGHT+IFvVaahOlFs5AKVDtqqFvziPFmo+fmi4H2JUvH86M5yeft1q5fP37+APmY/SQNNgV2nJcbohwd4wa71jEZ9WqI=
X-Received: by 2002:a67:be06:0:b0:471:e254:ea29 with SMTP id
 x6-20020a67be06000000b00471e254ea29mr1865933vsq.9.1708906125018; Sun, 25 Feb
 2024 16:08:45 -0800 (PST)
MIME-Version: 1.0
References: <20240224105417.195674-1-ines.varhol@telecom-paris.fr>
 <20240224105417.195674-3-ines.varhol@telecom-paris.fr>
In-Reply-To: <20240224105417.195674-3-ines.varhol@telecom-paris.fr>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 26 Feb 2024 10:08:19 +1000
Message-ID: <CAKmqyKOvHDMAidNsWUcYKv5TZBfiHwFREfcVvDcMqTxy+C3cWQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] hw/arm: Connect STM32L4x5 GPIO to STM32L4x5 SoC
To: =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>
Cc: qemu-devel@nongnu.org, Samuel Tardieu <samuel.tardieu@telecom-paris.fr>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Alistair Francis <alistair@alistair23.me>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>, 
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::935;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x935.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sat, Feb 24, 2024 at 8:56=E2=80=AFPM In=C3=A8s Varhol
<ines.varhol@telecom-paris.fr> wrote:
>
> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  include/hw/arm/stm32l4x5_soc.h     |  2 +
>  include/hw/gpio/stm32l4x5_gpio.h   |  1 +
>  include/hw/misc/stm32l4x5_syscfg.h |  3 +-
>  hw/arm/stm32l4x5_soc.c             | 71 +++++++++++++++++++++++-------
>  hw/misc/stm32l4x5_syscfg.c         |  1 +
>  hw/arm/Kconfig                     |  3 +-
>  6 files changed, 63 insertions(+), 18 deletions(-)
>
> diff --git a/include/hw/arm/stm32l4x5_soc.h b/include/hw/arm/stm32l4x5_so=
c.h
> index 1f71298b45..cb4da08629 100644
> --- a/include/hw/arm/stm32l4x5_soc.h
> +++ b/include/hw/arm/stm32l4x5_soc.h
> @@ -29,6 +29,7 @@
>  #include "hw/misc/stm32l4x5_syscfg.h"
>  #include "hw/misc/stm32l4x5_exti.h"
>  #include "hw/misc/stm32l4x5_rcc.h"
> +#include "hw/gpio/stm32l4x5_gpio.h"
>  #include "qom/object.h"
>
>  #define TYPE_STM32L4X5_SOC "stm32l4x5-soc"
> @@ -45,6 +46,7 @@ struct Stm32l4x5SocState {
>      Stm32l4x5ExtiState exti;
>      Stm32l4x5SyscfgState syscfg;
>      Stm32l4x5RccState rcc;
> +    Stm32l4x5GpioState gpio[NUM_GPIOS];
>
>      MemoryRegion sram1;
>      MemoryRegion sram2;
> diff --git a/include/hw/gpio/stm32l4x5_gpio.h b/include/hw/gpio/stm32l4x5=
_gpio.h
> index 0d361f3410..878bd19fc9 100644
> --- a/include/hw/gpio/stm32l4x5_gpio.h
> +++ b/include/hw/gpio/stm32l4x5_gpio.h
> @@ -25,6 +25,7 @@
>  #define TYPE_STM32L4X5_GPIO "stm32l4x5-gpio"
>  OBJECT_DECLARE_SIMPLE_TYPE(Stm32l4x5GpioState, STM32L4X5_GPIO)
>
> +#define NUM_GPIOS 8
>  #define GPIO_NUM_PINS 16
>
>  struct Stm32l4x5GpioState {
> diff --git a/include/hw/misc/stm32l4x5_syscfg.h b/include/hw/misc/stm32l4=
x5_syscfg.h
> index 29c3522f9d..23bb564150 100644
> --- a/include/hw/misc/stm32l4x5_syscfg.h
> +++ b/include/hw/misc/stm32l4x5_syscfg.h
> @@ -26,12 +26,11 @@
>
>  #include "hw/sysbus.h"
>  #include "qom/object.h"
> +#include "hw/gpio/stm32l4x5_gpio.h"
>
>  #define TYPE_STM32L4X5_SYSCFG "stm32l4x5-syscfg"
>  OBJECT_DECLARE_SIMPLE_TYPE(Stm32l4x5SyscfgState, STM32L4X5_SYSCFG)
>
> -#define NUM_GPIOS 8
> -#define GPIO_NUM_PINS 16
>  #define SYSCFG_NUM_EXTICR 4
>
>  struct Stm32l4x5SyscfgState {
> diff --git a/hw/arm/stm32l4x5_soc.c b/hw/arm/stm32l4x5_soc.c
> index 347a5377e5..072671bdfb 100644
> --- a/hw/arm/stm32l4x5_soc.c
> +++ b/hw/arm/stm32l4x5_soc.c
> @@ -27,6 +27,7 @@
>  #include "exec/address-spaces.h"
>  #include "sysemu/sysemu.h"
>  #include "hw/arm/stm32l4x5_soc.h"
> +#include "hw/gpio/stm32l4x5_gpio.h"
>  #include "hw/qdev-clock.h"
>  #include "hw/misc/unimp.h"
>
> @@ -78,6 +79,22 @@ static const int exti_irq[NUM_EXTI_IRQ] =3D {
>  #define RCC_BASE_ADDRESS 0x40021000
>  #define RCC_IRQ 5
>
> +static const struct {
> +    uint32_t addr;
> +    uint32_t moder_reset;
> +    uint32_t ospeedr_reset;
> +    uint32_t pupdr_reset;
> +} stm32l4x5_gpio_cfg[NUM_GPIOS] =3D {
> +    { 0x48000000, 0xABFFFFFF, 0x0C000000, 0x64000000 },
> +    { 0x48000400, 0xFFFFFEBF, 0x00000000, 0x00000100 },
> +    { 0x48000800, 0xFFFFFFFF, 0x00000000, 0x00000000 },
> +    { 0x48000C00, 0xFFFFFFFF, 0x00000000, 0x00000000 },
> +    { 0x48001000, 0xFFFFFFFF, 0x00000000, 0x00000000 },
> +    { 0x48001400, 0xFFFFFFFF, 0x00000000, 0x00000000 },
> +    { 0x48001800, 0xFFFFFFFF, 0x00000000, 0x00000000 },
> +    { 0x48001C00, 0x0000000F, 0x00000000, 0x00000000 },
> +};
> +
>  static void stm32l4x5_soc_initfn(Object *obj)
>  {
>      Stm32l4x5SocState *s =3D STM32L4X5_SOC(obj);
> @@ -85,6 +102,11 @@ static void stm32l4x5_soc_initfn(Object *obj)
>      object_initialize_child(obj, "exti", &s->exti, TYPE_STM32L4X5_EXTI);
>      object_initialize_child(obj, "syscfg", &s->syscfg, TYPE_STM32L4X5_SY=
SCFG);
>      object_initialize_child(obj, "rcc", &s->rcc, TYPE_STM32L4X5_RCC);
> +
> +    for (unsigned i =3D 0; i < NUM_GPIOS; i++) {
> +        g_autofree char *name =3D g_strdup_printf("gpio%c", 'a' + i);
> +        object_initialize_child(obj, name, &s->gpio[i], TYPE_STM32L4X5_G=
PIO);
> +    }
>  }
>
>  static void stm32l4x5_soc_realize(DeviceState *dev_soc, Error **errp)
> @@ -93,8 +115,9 @@ static void stm32l4x5_soc_realize(DeviceState *dev_soc=
, Error **errp)
>      Stm32l4x5SocState *s =3D STM32L4X5_SOC(dev_soc);
>      const Stm32l4x5SocClass *sc =3D STM32L4X5_SOC_GET_CLASS(dev_soc);
>      MemoryRegion *system_memory =3D get_system_memory();
> -    DeviceState *armv7m;
> +    DeviceState *armv7m, *dev;
>      SysBusDevice *busdev;
> +    uint32_t pin_index;
>
>      if (!memory_region_init_rom(&s->flash, OBJECT(dev_soc), "flash",
>                                  sc->flash_size, errp)) {
> @@ -135,17 +158,43 @@ static void stm32l4x5_soc_realize(DeviceState *dev_=
soc, Error **errp)
>          return;
>      }
>
> +    /* GPIOs */
> +    for (unsigned i =3D 0; i < NUM_GPIOS; i++) {
> +        g_autofree char *name =3D g_strdup_printf("%c", 'A' + i);
> +        dev =3D DEVICE(&s->gpio[i]);
> +        qdev_prop_set_string(dev, "name", name);
> +        qdev_prop_set_uint32(dev, "mode-reset",
> +                             stm32l4x5_gpio_cfg[i].moder_reset);
> +        qdev_prop_set_uint32(dev, "ospeed-reset",
> +                             stm32l4x5_gpio_cfg[i].ospeedr_reset);
> +        qdev_prop_set_uint32(dev, "pupd-reset",
> +                            stm32l4x5_gpio_cfg[i].pupdr_reset);
> +        busdev =3D SYS_BUS_DEVICE(&s->gpio[i]);
> +        g_free(name);
> +        name =3D g_strdup_printf("gpio%c-out", 'a' + i);
> +        qdev_connect_clock_in(DEVICE(&s->gpio[i]), "clk",
> +            qdev_get_clock_out(DEVICE(&(s->rcc)), name));
> +        if (!sysbus_realize(busdev, errp)) {
> +            return;
> +        }
> +        sysbus_mmio_map(busdev, 0, stm32l4x5_gpio_cfg[i].addr);
> +    }
> +
>      /* System configuration controller */
>      busdev =3D SYS_BUS_DEVICE(&s->syscfg);
>      if (!sysbus_realize(busdev, errp)) {
>          return;
>      }
>      sysbus_mmio_map(busdev, 0, SYSCFG_ADDR);
> -    /*
> -     * TODO: when the GPIO device is implemented, connect it
> -     * to SYCFG using `qdev_connect_gpio_out`, NUM_GPIOS and
> -     * GPIO_NUM_PINS.
> -     */
> +
> +    for (unsigned i =3D 0; i < NUM_GPIOS; i++) {
> +        for (unsigned j =3D 0; j < GPIO_NUM_PINS; j++) {
> +            pin_index =3D GPIO_NUM_PINS * i + j;
> +            qdev_connect_gpio_out(DEVICE(&s->gpio[i]), j,
> +                                  qdev_get_gpio_in(DEVICE(&s->syscfg),
> +                                  pin_index));
> +        }
> +    }
>
>      /* EXTI device */
>      busdev =3D SYS_BUS_DEVICE(&s->exti);
> @@ -157,7 +206,7 @@ static void stm32l4x5_soc_realize(DeviceState *dev_so=
c, Error **errp)
>          sysbus_connect_irq(busdev, i, qdev_get_gpio_in(armv7m, exti_irq[=
i]));
>      }
>
> -    for (unsigned i =3D 0; i < 16; i++) {
> +    for (unsigned i =3D 0; i < GPIO_NUM_PINS; i++) {
>          qdev_connect_gpio_out(DEVICE(&s->syscfg), i,
>                                qdev_get_gpio_in(DEVICE(&s->exti), i));
>      }
> @@ -242,14 +291,6 @@ static void stm32l4x5_soc_realize(DeviceState *dev_s=
oc, Error **errp)
>      /* RESERVED:    0x40024400, 0x7FDBC00 */
>
>      /* AHB2 BUS */
> -    create_unimplemented_device("GPIOA",     0x48000000, 0x400);
> -    create_unimplemented_device("GPIOB",     0x48000400, 0x400);
> -    create_unimplemented_device("GPIOC",     0x48000800, 0x400);
> -    create_unimplemented_device("GPIOD",     0x48000C00, 0x400);
> -    create_unimplemented_device("GPIOE",     0x48001000, 0x400);
> -    create_unimplemented_device("GPIOF",     0x48001400, 0x400);
> -    create_unimplemented_device("GPIOG",     0x48001800, 0x400);
> -    create_unimplemented_device("GPIOH",     0x48001C00, 0x400);
>      /* RESERVED:    0x48002000, 0x7FDBC00 */
>      create_unimplemented_device("OTG_FS",    0x50000000, 0x40000);
>      create_unimplemented_device("ADC",       0x50040000, 0x400);
> diff --git a/hw/misc/stm32l4x5_syscfg.c b/hw/misc/stm32l4x5_syscfg.c
> index fd68cb800b..3dafc00b49 100644
> --- a/hw/misc/stm32l4x5_syscfg.c
> +++ b/hw/misc/stm32l4x5_syscfg.c
> @@ -27,6 +27,7 @@
>  #include "hw/irq.h"
>  #include "migration/vmstate.h"
>  #include "hw/misc/stm32l4x5_syscfg.h"
> +#include "hw/gpio/stm32l4x5_gpio.h"
>
>  #define SYSCFG_MEMRMP 0x00
>  #define SYSCFG_CFGR1 0x04
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 92b72d56dc..5776dbb19f 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -463,9 +463,10 @@ config STM32L4X5_SOC
>      bool
>      select ARM_V7M
>      select OR_IRQ
> -    select STM32L4X5_SYSCFG
>      select STM32L4X5_EXTI
> +    select STM32L4X5_SYSCFG
>      select STM32L4X5_RCC
> +    select STM32L4X5_GPIO
>
>  config XLNX_ZYNQMP_ARM
>      bool
> --
> 2.43.2
>
>

