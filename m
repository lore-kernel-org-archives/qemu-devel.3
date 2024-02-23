Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6399BC54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 12:18:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdUUu-0000na-VM; Fri, 23 Feb 2024 07:17:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rdUUZ-0000O5-Td
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 07:17:27 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rdUUL-0006QH-Jj
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 07:17:27 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a3e5d82ad86so105227066b.2
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 04:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708690629; x=1709295429; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e2Gxu7VThFBCq3d6GPEOXRRcZ9fy6TogGFJxSBoCh7Q=;
 b=E6c0IsR3kdTWEZg7aL7nEJr+PHgyB+HHwVJMU2E/MTY1fkGM2K73uV+Punn4nJm2uN
 uZ79F1XQFBG/Sn+M9XJV9WUfr2TVqpVhDFDoXLbq5InQ47Pq8VpMytd2Znhuzfe3cApT
 WEGrLnIqFkhjPUBIjxdYiSZ2ztVo/+hIgXrHjSSgZukJ7FVuv2JSs9EIy3hsYFwxwkG8
 kEnua/gDDkSBFjagG94leeOGptVgNJYY7tGEWdgX12lAGfUQ8pmu7CcnTotyaKK9BI3D
 wtGPcJOhg2X9loeA4K5p6nJ9QsoloAXcG1mv6JusRo4GAO0o9xIG0/9ImvTsSxfvuxSO
 Ms+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708690629; x=1709295429;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e2Gxu7VThFBCq3d6GPEOXRRcZ9fy6TogGFJxSBoCh7Q=;
 b=qaan3KLkgoL3vqRxaQBFNifFHpQsEGFsVVwuXbbcOCScIZxDqJcYTro8F6AwCLe2FH
 r4y/etsrDPW4mD1wwbHdHAzf+xBdexmMD0yWj2TzGj23QDAQEQSsafWHnHBAT7rMF2va
 YGTD6oahCS1dqS33YCuzoEZLJD/I5G/F4RdZP7/oCFsyMO7RU1e6bpbot/zDCMGVUsLQ
 x26lC9j1DRYfZskvzCURqFncuGxmY5zWz1nMbIykcYBjZGpNL8iEwIEMwD3QgDfWJzq1
 iUsA15ApzFrIGvoRTOkGGHHGVtTGkZtR/84OMA8SXx2oNPkqBs5Tawnc0z5XMc2r0r0P
 WaBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqSPq4Y1BnNKmb+WZQmtr1NTgYa3eiCyUd+MzEsh3iJQVE2YWyRSXa7Iq8c2MyT6HCpl8tV70fqchtFXSPYigimAokRX8=
X-Gm-Message-State: AOJu0Yxa+OJCI4fGq8QQ+8/ZtL792iiyT4C0uWJ0uUBMERSnxahLPwd9
 b1DYm5zcPSePbLEAMKzOsyvJdyxnIM6Zbo00i3gz03U6q2+PXlyHg9dJDYbWLKM=
X-Google-Smtp-Source: AGHT+IGBd9Ddb4VGoDFR2Sjl+3OB2H/pkgAqW0feExsWa5XN8rMam1R8lSYOXYuEKJP2snAJuWQXTQ==
X-Received: by 2002:a17:906:bcdb:b0:a3e:849b:abab with SMTP id
 lw27-20020a170906bcdb00b00a3e849bababmr1155854ejb.27.1708690629072; 
 Fri, 23 Feb 2024 04:17:09 -0800 (PST)
Received: from [192.168.69.100] (sto95-h01-176-184-18-96.dsl.sta.abo.bbox.fr.
 [176.184.18.96]) by smtp.gmail.com with ESMTPSA id
 ts4-20020a170907c5c400b00a3e0119b4a3sm6982858ejc.140.2024.02.23.04.17.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Feb 2024 04:17:08 -0800 (PST)
Message-ID: <07c76db3-b52a-46a9-8b0f-9230ba771bc7@linaro.org>
Date: Fri, 23 Feb 2024 13:17:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] hw/gpio: Implement STM32L4x5 GPIO
Content-Language: en-US
To: =?UTF-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Alistair Francis <alistair@alistair23.me>,
 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>,
 Thomas Huth <thuth@redhat.com>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>
References: <20240207132517.198348-1-ines.varhol@telecom-paris.fr>
 <20240207132517.198348-2-ines.varhol@telecom-paris.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240207132517.198348-2-ines.varhol@telecom-paris.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hi Inès,

On 7/2/24 14:23, Inès Varhol wrote:
> Features supported :
> - the 8 STM32L4x5 GPIOs are initialized with their reset values
>      (except IDR, see below)
> - input mode : setting a pin in input mode "externally" (using input
>      irqs) results in an out irq (transmitted to SYSCFG)
> - output mode : setting a bit in ODR sets the corresponding out irq
>      (if this line is configured in output mode)
> - pull-up, pull-down
> - push-pull, open-drain
> 
> Difference with the real GPIOs :
> - Alternate Function and Analog mode aren't implemented :
>      pins in AF/Analog behave like pins in input mode
> - floating pins stay at their last value
> - register IDR reset values differ from the real one :
>      values are coherent with the other registers reset values
>      and the fact that AF/Analog modes aren't implemented
> - setting I/O output speed isn't supported
> - locking port bits isn't supported
> - ADC function isn't supported
> - GPIOH has 16 pins instead of 2 pins
> - writing to registers LCKR, AFRL, AFRH and ASCR is ineffective
> 
> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
> ---
>   MAINTAINERS                        |   1 +
>   docs/system/arm/b-l475e-iot01a.rst |   2 +-
>   include/hw/gpio/stm32l4x5_gpio.h   |  70 +++++
>   hw/gpio/stm32l4x5_gpio.c           | 456 +++++++++++++++++++++++++++++
>   hw/gpio/Kconfig                    |   3 +
>   hw/gpio/meson.build                |   1 +
>   hw/gpio/trace-events               |   6 +
>   7 files changed, 538 insertions(+), 1 deletion(-)
>   create mode 100644 include/hw/gpio/stm32l4x5_gpio.h
>   create mode 100644 hw/gpio/stm32l4x5_gpio.c


> +static void update_gpio_idr(Stm32l4x5GpioState *s)
> +{
> +    uint32_t new_idr_mask = 0;
> +    uint32_t new_idr = s->odr;
> +
> +    for (int i = 0; i < GPIO_NUM_PINS; i++) {
> +        /* output mode */
> +        if (extract32(s->moder, 2 * i, 2) == 1) {
> +            if (extract32(s->otyper, i, 1) == 0) {
> +                /* push-pull */
> +                new_idr_mask |= (1 << i);
> +            } else if (!(s->odr & (1 << i))) {
> +                /* open-drain ODR 0 */
> +                new_idr_mask |= (1 << i);
> +            } else if ((s->disconnected_pins & (1 << i)) &&
> +                       (extract32(s->pupdr, 2 * i, 2) == 1)) {
> +                /* open-drain pull-up ODR 1 with disconnected pin */
> +                new_idr_mask |= (1 << i);
> +            } else if ((s->disconnected_pins & (1 << i)) &&
> +                       (extract32(s->pupdr, 2 * i, 2) == 2)) {
> +                /* open-drain pull-down ODR 1 with disconnected pin */
> +                new_idr_mask |= (1 << i);
> +                new_idr &= ~(1 << i);
> +            } else if (!(s->pins_connected_high & (1 << i))) {
> +                /* open-drain ODR 1 with pin connected low */
> +                new_idr_mask |= (1 << i);
> +                new_idr &= ~(1 << i);
> +            }
> +            /*
> +             * The only case left is for open-drain ODR 1
> +             * with disconnected pin without pull-up or pull-down :
> +             * the value is floating.
> +             */
> +        /* input or analog mode with connected pin */
> +        } else if (!(s->disconnected_pins & (1 << i))) {
> +            if (s->pins_connected_high & (1 << i)) {
> +                /* pin high */
> +                new_idr_mask |= (1 << i);
> +                new_idr |= (1 << i);
> +            } else {
> +                /* pin low */
> +                new_idr_mask |= (1 << i);
> +                new_idr &= ~(1 << i);
> +            }
> +        /* input or analog mode with disconnected pin */
> +        } else {
> +            if (extract32(s->pupdr, 2 * i, 2) == 1) {
> +                /* pull-up */
> +                new_idr_mask |= (1 << i);
> +                new_idr |= (1 << i);
> +            } else if (extract32(s->pupdr, 2 * i, 2) == 2) {
> +                /* pull-down */

You can extract for clarity:

   static bool is_pull_up(Stm32l4x5GpioState *s, unsigned pin)
   {
       return extract32(s->pupdr, 2 * pin, 2) == 1;
   }

   static bool is_pull_down(Stm32l4x5GpioState *s, unsigned pin)
   {
       return extract32(s->pupdr, 2 * pin, 2) == 2;
   }

> +                new_idr_mask |= (1 << i);
> +                new_idr &= ~(1 << i);
> +            }
> +            /*
> +             * The only case left is for a disconnected pin
> +             * without pull-up or pull-down :
> +             * the value is floating.
> +             */
> +        }
> +    }
> +
> +    uint32_t old_idr = s->idr;

Please declare new variable at the beginning of the function.
(https://www.qemu.org/docs/master/devel/style.html#declarations)

> +    s->idr = (old_idr & ~new_idr_mask) | (new_idr & new_idr_mask);
> +    trace_stm32l4x5_gpio_update_idr(s->name, old_idr, s->idr);
> +
> +    for (int i = 0; i < GPIO_NUM_PINS; i++) {
> +        if (new_idr_mask & (1 << i)) {

Maybe evaluate (new_idr & (1 << i)) and (old_idr & (1 << i)) once
in local variables?

> +            if ((new_idr & (1 << i)) > (old_idr & (1 << i))) {
> +                qemu_irq_raise(s->pin[i]);
> +            } else if ((new_idr & (1 << i)) < (old_idr & (1 << i))) {
> +                qemu_irq_lower(s->pin[i]);
> +            }
> +        }
> +    }
> +}
> +
> +/*
> + * Return

"mask of"

> pins both configured in output mode
> + * and externally driven (except pins in open-drain
> + * mode externally set to 0).
> + */
> +static uint32_t get_gpio_pins_to_disconnect(Stm32l4x5GpioState *s)

Maybe get_gpio_pinmask_to_disconnect() is clearer.

> +{
> +    uint32_t pins_to_disconnect = 0;

> +    for (int i = 0; i < GPIO_NUM_PINS; i++) {
> +        /* for each connected pin in output mode */
> +        if ((~s->disconnected_pins & (1 << i)) &&
> +            (extract32(s->moder, 2 * i, 2) == 1)) {
> +            /* if either push-pull or high level */
> +            if ((extract32(s->otyper, i, 1) == 0) ||
> +                (extract16(s->pins_connected_high, i, 1)) == 1) { > +                pins_to_disconnect |= (1 << i);
> +                qemu_log_mask(LOG_GUEST_ERROR,
> +                              "Line %d can't be driven externally\n",
> +                              i);
> +            }
> +        }
> +    }
> +    return pins_to_disconnect;
> +}


> +static void stm32l4x5_gpio_init(Object *obj)
> +{
> +    Stm32l4x5GpioState *s = STM32L4X5_GPIO(obj);
> +
> +    memory_region_init_io(&s->mmio, obj, &stm32l4x5_gpio_ops, s,
> +                          TYPE_STM32L4X5_GPIO, 0x400);
> +
> +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
> +
> +    qdev_init_gpio_out(DEVICE(obj), s->pin, GPIO_NUM_PINS);
> +    qdev_init_gpio_in(DEVICE(obj), stm32l4x5_gpio_set, GPIO_NUM_PINS);
> +
> +    s->clk = qdev_init_clock_in(DEVICE(s), "clk", NULL, s, 0);
> +
> +    object_property_add(obj, "disconnected-pins", "uint16",
> +        disconnected_pins_get, disconnected_pins_set, NULL,
> +        &s->disconnected_pins);

(alignment is off)

> +    object_property_add(obj, "clock-freq-hz", "uint32",
> +        clock_freq_get, NULL, NULL, NULL);

(Ditto)

> +}
> +
> +static void stm32l4x5_gpio_realize(DeviceState *dev, Error **errp)
> +{
> +    Stm32l4x5GpioState *s = STM32L4X5_GPIO(dev);

> +    if (!clock_has_source(s->clk)) {
> +        error_setg(errp, "GPIO: clk input must be connected");
> +        return;
> +    }
> +}

Mostly style comments, otherwise:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


