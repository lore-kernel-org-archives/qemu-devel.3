Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75373C0218D
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 01:15:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdJ8m-00014C-FN; Wed, 29 Jan 2025 20:14:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1tdJ8j-00013p-H8
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 20:14:41 -0500
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1tdJ8g-0000eB-FO
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 20:14:40 -0500
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-543e49a10f5so252305e87.1
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2025 17:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1738199676; x=1738804476;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fH4OIUNdVWfzUHgy/iybx/I5U4iA6wYbbqktoccN824=;
 b=R3981UPQYF3HcyDJNob0ngSuYwzqXcaPXrCMT5+fJwIov9MiKeF5NNVuenAXJnVnWU
 NF3R9jqjaJmK9aN0zwiFEhCZQpyhzG9Xyc5Qb6LH2UKuYRRKTs2wZrwF+5SPp61xKKUq
 eK9aHpcdYxm/5blK/3d/AlzUCPpavKNpwl5hwcJiBVXlv1bUN9vblr8OnCQwmpsMuFm8
 v+s7dgvnrPB0OQdat37YYu7S6xodPeME+EcwF1GDD1BgHJhhfFxO/xqJ/REYWCeiWzFW
 MRE2ttSFmaiOnmhb6yTAj/K4hLiUp5udNCk4EUefPGf4HS76PESSp7ycSYWApZLss1A2
 2TFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738199676; x=1738804476;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fH4OIUNdVWfzUHgy/iybx/I5U4iA6wYbbqktoccN824=;
 b=rajwQOpj3+ctioAOrUwZvbrB0GguuZ5jbEQ3hAyxtM3FNtvJQwyCASvbWhkD1J/o74
 sDmj1/m+w8tio2WiSIYAhHmDnJi4vOlpxOHpQKKVNsW3GlFSSGL1KqClxgfNKuUVlW2w
 wDUERB5PhJjfPETilKJk7MjcmcB4puk+RPktxH6rgNb1JAh1PLU0xm/MUXpRTI2Kdpbj
 7Dn1tzCecFq28oBHhGtKlQAPZuY8S/SBT3Kly3ZczeYKDOX6tzJXzezQ+xhui/9aI6pC
 +9FpR5E6kKsTIGxr+AYGiowh3Fn+E0f+9h1a/yg+Zv9dfmv5Oq4LI/+yK1zd5vT/9D++
 GBCA==
X-Gm-Message-State: AOJu0YzTUbwA0S5ur9tMc39Pc9lULwV1pTFGPvK3H+oH+xRlqlDBexO4
 XhoO9gBYBW2P5uPQXz3dwRsAFZao3E5z0te57N0mlsAkQaroAsOxOzbrJvbtGdVEDf3IX09Bslp
 XlOazLtxt0xK4VtM9teD4lP88q0Chy7LS8LERTQ==
X-Gm-Gg: ASbGncsxCc6ljweuogQb0Y7+pYD9sZOIPgi3PrxB3TzNze1a3MfU8GCjB3JweM1Weqj
 TEHzMfkXwPPTMJRjSuOV9NUqqRp55fu2esXev03xyaIHny1sb8BvsXN0NPcN0lcXM3+CZfG2OvQ
 ==
X-Google-Smtp-Source: AGHT+IFMCaOsUkJnl7w04LpN49l6ZjkR1gS3e0uCEjJDkX+rLbbYi2UtIJtu3/RwUl5gHc1+Us+BBR5Egtkc8hwy6aU=
X-Received: by 2002:a05:6512:3094:b0:542:8da7:242f with SMTP id
 2adb3069b0e04-543e4bdffb1mr1481346e87.10.1738199675793; Wed, 29 Jan 2025
 17:14:35 -0800 (PST)
MIME-Version: 1.0
References: <20250120203748.4687-1-shentey@gmail.com>
 <20250120203748.4687-21-shentey@gmail.com>
In-Reply-To: <20250120203748.4687-21-shentey@gmail.com>
From: Corey Minyard <corey@minyard.net>
Date: Wed, 29 Jan 2025 17:14:23 -0800
X-Gm-Features: AWEUYZnxI3pCn05rO_lH0h3KTRYmbDBjY9XbFtcrSvD7GUQeIWTQMcW_XqZFUYI
Message-ID: <CAB9gMfo-85-nWdLaEH0KD+uBy7LWobi+EQFZ5HiS_hWZfGJ4SA@mail.gmail.com>
Subject: Re: [PATCH 20/21] hw/i2c: Import TCA6416 emulation from Xilinx
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org, 
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2a00:1450:4864:20::136;
 envelope-from=corey@minyard.net; helo=mail-lf1-x136.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

I'm not sure about ownership here, but from an I2C point of view this
all looks ok.

Reviewed-by: Corey Minyard <cminyard@mvista.com>

On Mon, Jan 20, 2025 at 12:43=E2=80=AFPM Bernhard Beschow <shentey@gmail.co=
m> wrote:
>
> Xilinx QEMU implements a TCA6416 device model which may be useful for the
> broader QEMU community, so upstream it. In the Xilinx fork, the device mo=
del
> gets compiled whenever CONFIG_CADENCE is true, so have it maintained by t=
he
> "hw/*/cadence_*" maintainers.
>
> The code is based on Xilinx QEMU version xilinx_v2024.2 plus the followin=
g
> modifications:
> * Use OBJECT_DECLARE_SIMPLE_TYPE()
> * Port from DPRINTF() to trace events
> * Follow QEMU conventions for naming of state struct
> * Rename type to not contain a ','
> * Use DEFINE_TYPES() macro
> * Implement under hw/gpio since device is i2c client and gpio provider
> * Have dedicated Kconfig switch
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
>
> --
> I have a use for TCA6416 emulation. Question: Are Xilinx Zynq maintainers
> willing to maintain this device model?
> ---
>  MAINTAINERS          |   1 +
>  hw/gpio/tca6416.c    | 122 +++++++++++++++++++++++++++++++++++++++++++
>  hw/gpio/Kconfig      |   5 ++
>  hw/gpio/meson.build  |   1 +
>  hw/gpio/trace-events |   4 ++
>  5 files changed, 133 insertions(+)
>  create mode 100644 hw/gpio/tca6416.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7531d65429..0cac9c90bc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1030,6 +1030,7 @@ S: Maintained
>  F: hw/*/xilinx_*
>  F: hw/*/cadence_*
>  F: hw/misc/zynq_slcr.c
> +F: hw/gpio/tca6416.c
>  F: hw/adc/zynq-xadc.c
>  F: include/hw/misc/zynq_slcr.h
>  F: include/hw/adc/zynq-xadc.h
> diff --git a/hw/gpio/tca6416.c b/hw/gpio/tca6416.c
> new file mode 100644
> index 0000000000..81ed7a654d
> --- /dev/null
> +++ b/hw/gpio/tca6416.c
> @@ -0,0 +1,122 @@
> +/*
> + * QEMU model of TCA6416 16-Bit I/O Expander
> + *
> + * Copyright (c) 2018 Xilinx Inc.
> + *
> + * Written by Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
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
> +#include "qemu/osdep.h"
> +#include "hw/i2c/i2c.h"
> +#include "trace.h"
> +
> +#define TYPE_TCA6416 "tca6416"
> +OBJECT_DECLARE_SIMPLE_TYPE(Tca6416State, TCA6416)
> +
> +#define IN_PORT0    0
> +#define IN_PORT1    1
> +#define OUT_PORT0   2
> +#define OUT_PORT1   3
> +#define POL_INV0    4
> +#define POL_INV1    5
> +#define CONF_PORT0  6
> +#define CONF_PORT1  7
> +#define RMAX (CONF_PORT1 + 1)
> +
> +enum tca6416_events {
> +     ADDR_DONE,
> +     ADDRESSING,
> +};
> +
> +struct Tca6416State {
> +     I2CSlave i2c;
> +
> +     uint8_t addr;
> +     uint8_t state;
> +     uint8_t regs[RMAX];
> +};
> +
> +static uint8_t tca6416_read(I2CSlave *i2c)
> +{
> +    Tca6416State *s =3D TCA6416(i2c);
> +    uint8_t ret;
> +
> +    ret =3D s->regs[s->addr];
> +    trace_tca6416_read(ret);
> +    return ret;
> +}
> +
> +static int tca6416_write(I2CSlave *i2c, uint8_t data)
> +{
> +    Tca6416State *s =3D TCA6416(i2c);
> +
> +    trace_tca6416_write(data);
> +    if (s->state =3D=3D ADDRESSING) {
> +        s->addr =3D data;
> +    } else {
> +        s->regs[s->addr] =3D data;
> +    }
> +
> +    return 0;
> +}
> +
> +static void tca6416_realize(DeviceState *dev, Error **errp)
> +{
> +    Tca6416State *s =3D TCA6416(dev);
> +
> +    s->regs[CONF_PORT0] =3D 0xFF;
> +    s->regs[CONF_PORT1] =3D 0xFF;
> +}
> +
> +static int tca6416_event(I2CSlave *i2c, enum i2c_event event)
> +{
> +    Tca6416State *s =3D TCA6416(i2c);
> +
> +    switch (event) {
> +    case I2C_START_SEND:
> +        s->state =3D ADDRESSING;
> +        break;
> +    default:
> +         s->state =3D ADDR_DONE;
> +    };
> +    return 0;
> +}
> +
> +static void tca6416_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    I2CSlaveClass *k =3D I2C_SLAVE_CLASS(klass);
> +
> +    dc->realize =3D tca6416_realize;
> +    k->recv =3D tca6416_read;
> +    k->send =3D tca6416_write;
> +    k->event =3D tca6416_event;
> +}
> +
> +static const TypeInfo tca6416_types[] =3D {
> +    {
> +        .name =3D TYPE_TCA6416,
> +        .parent =3D TYPE_I2C_SLAVE,
> +        .class_init =3D tca6416_class_init,
> +        .instance_size =3D sizeof(Tca6416State),
> +    }
> +};
> +
> +DEFINE_TYPES(tca6416_types)
> diff --git a/hw/gpio/Kconfig b/hw/gpio/Kconfig
> index c423e10f59..a240cf2de2 100644
> --- a/hw/gpio/Kconfig
> +++ b/hw/gpio/Kconfig
> @@ -20,5 +20,10 @@ config PCF8574
>      bool
>      depends on I2C
>
> +config TCA6416
> +    bool
> +    depends on I2C
> +    default y if I2C_DEVICES
> +
>  config ZAURUS_SCOOP
>      bool
> diff --git a/hw/gpio/meson.build b/hw/gpio/meson.build
> index 74840619c0..b3ff7c7460 100644
> --- a/hw/gpio/meson.build
> +++ b/hw/gpio/meson.build
> @@ -18,3 +18,4 @@ system_ss.add(when: 'CONFIG_STM32L4X5_SOC', if_true: fi=
les('stm32l4x5_gpio.c'))
>  system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_gpio.c')=
)
>  system_ss.add(when: 'CONFIG_SIFIVE_GPIO', if_true: files('sifive_gpio.c'=
))
>  system_ss.add(when: 'CONFIG_PCF8574', if_true: files('pcf8574.c'))
> +system_ss.add(when: 'CONFIG_TCA6416', if_true: files('tca6416.c'))
> diff --git a/hw/gpio/trace-events b/hw/gpio/trace-events
> index cea896b28f..6724f2efb8 100644
> --- a/hw/gpio/trace-events
> +++ b/hw/gpio/trace-events
> @@ -46,3 +46,7 @@ stm32l4x5_gpio_read(char *gpio, uint64_t addr) "GPIO%s =
addr: 0x%" PRIx64 " "
>  stm32l4x5_gpio_write(char *gpio, uint64_t addr, uint64_t data) "GPIO%s a=
ddr: 0x%" PRIx64 " val: 0x%" PRIx64 ""
>  stm32l4x5_gpio_update_idr(char *gpio, uint32_t old_idr, uint32_t new_idr=
) "GPIO%s from: 0x%x to: 0x%x"
>  stm32l4x5_gpio_pins(char *gpio, uint16_t disconnected, uint16_t high) "G=
PIO%s disconnected pins: 0x%x levels: 0x%x"
> +
> +# tca6416.c
> +tca6416_write(uint8_t value) "0x%02x"
> +tca6416_read(uint8_t value) "0x%02x"
> --
> 2.48.1
>
>

