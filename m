Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD775C47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 18:21:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnjW7-000734-Vy; Fri, 22 Mar 2024 14:21:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rnjW6-00072h-Vu
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 14:21:23 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rnjW5-00012N-0z
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 14:21:22 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-56845954ffeso3107585a12.2
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 11:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711131679; x=1711736479; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KTfuxbFKM0YI/QdhTdtWOQixoVYjOynDlcfVortCCeI=;
 b=FiNLQXzCq/nzo4lgZNUU04LM0UQ6wKwNErzXYxUndFH8ZLClv/KuDO9OTfRSeyLerv
 fvLhzZjclXZM3qawKt422e0bA+6Wr889V3oA+3ksY/y0C/rR9qIeXHUJMiI4I4tFMWtg
 5XbpwvIz8DNnr0yq6xHCGrc5lNG6IuymPHUe9dL2TrTOGN/XuhfuCthTuOpHSg+CBAXR
 zFF2aYraBgD9eIHVUIS8xNB1AZ9R46ET9r90/rTfbGaI4E8SsaqmoyVtwvJwavp5B52m
 nQrNk+Zvt3y3jvuyhcKO/vc7GBCGt6Y/2gR+SHcqI8jh0jXye9y3HxL9VqokUdGdgr/X
 SqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711131679; x=1711736479;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KTfuxbFKM0YI/QdhTdtWOQixoVYjOynDlcfVortCCeI=;
 b=lKKCTqF7R1RccYMGgx4MI3WdjJNEbptKrkZESACMjgENaCR55gGLXjIMiuCY8oZrda
 ipJP0saumPhZcSgr7LFlzlTWWL+mcY5Uacywq3VFOvaGw7x79YfCtKvGHGu8N1djVqwO
 sWxDd+WoijX5+d/YzMzRIGj16oL/HoBbTuB78Q8hIvCbzi1a17T39eXvou/6uwQV5HCh
 4eSZ/Xhe+Kx1gS/DacDm/G7KOnaGSVA0kPMEIenfuK9fuEfB0ikM1cYqYAAKR2ixoAQ/
 bH/LEWNzOACcXC1QVQ4FTsPUOWEr2sgBjSbV0Ogm5ALrFpfF9nUsNfG005Fif5oKsqbQ
 tQBQ==
X-Gm-Message-State: AOJu0YxGkjkQK3EPpt+Py5a2biEQd+nCql3gR113bmQS8grReOmsh8us
 tbpmCqULh/KZudvtgKaSVuDUNHDQXowOVsWtjjvG+3qwr7k9VhS9LRETwEIOJj+t/7GiX5SMweO
 pZO+E1Huixuc45OsUzl55Ca7Pc1BTc99dl969eA==
X-Google-Smtp-Source: AGHT+IE153Pobin4INEhOztL1vuPAK125mPUvWSMB3iuxmdSNNMXfahZ1pjcs1VcNhcRUfeigTsbbO9aNMPa23PqNnA=
X-Received: by 2002:a50:ab5d:0:b0:565:59a:a103 with SMTP id
 t29-20020a50ab5d000000b00565059aa103mr209124edc.33.1711131679204; Fri, 22 Mar
 2024 11:21:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240317103918.44375-1-arnaud.minier@telecom-paris.fr>
 <20240317103918.44375-7-arnaud.minier@telecom-paris.fr>
In-Reply-To: <20240317103918.44375-7-arnaud.minier@telecom-paris.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Mar 2024 18:21:07 +0000
Message-ID: <CAFEAcA-6b6LDNr_d0m-DD3THxmmzC1w5vk-AE-E5b33CcNx6fQ@mail.gmail.com>
Subject: Re: [PATCH 6/7] hw/arm: Add the USART to the stm32l4x5 SoC
To: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Cc: qemu-devel@nongnu.org, Samuel Tardieu <samuel.tardieu@telecom-paris.fr>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Alistair Francis <alistair@alistair23.me>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>, 
 qemu-arm@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Sun, 17 Mar 2024 at 10:42, Arnaud Minier
<arnaud.minier@telecom-paris.fr> wrote:
>
> Add the USART to the SoC and connect it to the other implemented devices.
>
> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>


> @@ -143,6 +172,7 @@ static void stm32l4x5_soc_realize(DeviceState *dev_so=
c, Error **errp)
>      DeviceState *armv7m, *dev;
>      SysBusDevice *busdev;
>      uint32_t pin_index;
> +    g_autofree char *name;

The idea with g_autofree is that you put it in a variable scope
which is the right size so that the automatic free on going out
of the scope is all that you need for freeing it. You've put this
one at the top function level, which then means you needed
to add extra manual g_free() calls.
>
>      if (!memory_region_init_rom(&s->flash, OBJECT(dev_soc), "flash",
>                                  sc->flash_size, errp)) {
> @@ -185,7 +215,7 @@ static void stm32l4x5_soc_realize(DeviceState *dev_so=
c, Error **errp)
>
>      /* GPIOs */
>      for (unsigned i =3D 0; i < NUM_GPIOS; i++) {
> -        g_autofree char *name =3D g_strdup_printf("%c", 'A' + i);
> +        name =3D g_strdup_printf("%c", 'A' + i);
>          dev =3D DEVICE(&s->gpio[i]);
>          qdev_prop_set_string(dev, "name", name);
>          qdev_prop_set_uint32(dev, "mode-reset",
> @@ -199,6 +229,7 @@ static void stm32l4x5_soc_realize(DeviceState *dev_so=
c, Error **errp)
>          name =3D g_strdup_printf("gpio%c-out", 'a' + i);
>          qdev_connect_clock_in(DEVICE(&s->gpio[i]), "clk",
>              qdev_get_clock_out(DEVICE(&(s->rcc)), name));
> +        g_free(name);
>          if (!sysbus_realize(busdev, errp)) {
>              return;
>          }

For instance this code was correctly using the g_autofree, and
no longer is.

> @@ -279,6 +310,55 @@ static void stm32l4x5_soc_realize(DeviceState *dev_s=
oc, Error **errp)
>      sysbus_mmio_map(busdev, 0, RCC_BASE_ADDRESS);
>      sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, RCC_IRQ));
>
> +    /* USART devices */
> +    for (int i =3D 0; i < STM_NUM_USARTS; i++) {
> +        dev =3D DEVICE(&(s->usart[i]));
> +        qdev_prop_set_chr(dev, "chardev", serial_hd(i));
> +        name =3D g_strdup_printf("usart%d-out", i + 1);
> +        qdev_connect_clock_in(dev, "clk",
> +            qdev_get_clock_out(DEVICE(&(s->rcc)), name));
> +        g_free(name);

You should declare a new local g_autofree char *name inside
this loop body, and then the g_free() isn't needed.

> +        busdev =3D SYS_BUS_DEVICE(dev);
> +        if (!sysbus_realize(busdev, errp)) {
> +            return;
> +        }
> +        sysbus_mmio_map(busdev, 0, usart_addr[i]);
> +        sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, usart_irq=
[i]));
> +    }
> +
> +    /*
> +     * TODO: Connect the USARTs, UARTs and LPUART to the EXTI once the E=
XTI
> +     * can handle other gpio-in than the gpios. (e.g. Direct Lines for t=
he usarts)
> +     */
> +
> +    /* UART devices */
> +    for (int i =3D 0; i < STM_NUM_UARTS; i++) {
> +        dev =3D DEVICE(&(s->uart[i]));
> +        qdev_prop_set_chr(dev, "chardev", serial_hd(STM_NUM_USARTS + i))=
;
> +        name =3D g_strdup_printf("uart%d-out", STM_NUM_USARTS + i + 1);
> +        qdev_connect_clock_in(dev, "clk",
> +            qdev_get_clock_out(DEVICE(&(s->rcc)), name));
> +        g_free(name);

Similarly here.

> +        busdev =3D SYS_BUS_DEVICE(dev);
> +        if (!sysbus_realize(busdev, errp)) {
> +            return;
> +        }
> +        sysbus_mmio_map(busdev, 0, uart_addr[i]);
> +        sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, uart_irq[=
i]));
> +    }
> +
> +    /* LPUART device*/
> +    dev =3D DEVICE(&(s->lpuart));
> +    qdev_prop_set_chr(dev, "chardev", serial_hd(STM_NUM_USARTS + STM_NUM=
_UARTS));
> +    qdev_connect_clock_in(dev, "clk",
> +        qdev_get_clock_out(DEVICE(&(s->rcc)), "lpuart1-out"));
> +    busdev =3D SYS_BUS_DEVICE(dev);
> +    if (!sysbus_realize(busdev, errp)) {
> +        return;
> +    }
> +    sysbus_mmio_map(busdev, 0, LPUART_BASE_ADDRESS);
> +    sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, LPUART_IRQ));
> +
>      /* APB1 BUS */
>      create_unimplemented_device("TIM2",      0x40000000, 0x400);
>      create_unimplemented_device("TIM3",      0x40000400, 0x400);

thanks
-- PMM

