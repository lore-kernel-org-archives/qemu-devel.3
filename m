Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12064E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 23:40:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX7Yo-0000ei-6h; Sun, 12 Jan 2025 18:40:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tX7Yk-0000dv-H5; Sun, 12 Jan 2025 18:39:59 -0500
Received: from mail-ua1-x92d.google.com ([2607:f8b0:4864:20::92d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tX7Yi-0006s4-T3; Sun, 12 Jan 2025 18:39:58 -0500
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-85bad9e0214so1569344241.3; 
 Sun, 12 Jan 2025 15:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736725195; x=1737329995; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1LD6iflLB0gH4nA2fp+FkFqrD38sUdaRnXC9vr+9Irs=;
 b=cCNMWVSQtchnpSnoqGzcjSVlqB5dRSQpda44FYn2qarYtkrA0/F+6yZc+EWjUt0dyP
 eHK+0sR5GWBzVN4anU8Y4OYHxOEF4LvJ9pGPRlgeCCebftQ2MqhficK4HSNH30epgvuo
 kmVFjDX1rgdADfZWy1hR50KF05XIGgXkhYSryG052TycILJFUYry6+m2A/f6IHewjm4E
 p8Qn1WgBaLultBhyCTbVubMFswjxJxsuv/OnFCB0pJsYZwHCe9HH/sgJ/RGgG8WnV2Dy
 vIhv4R3KzW+N0LFwRSoVGAN0FI5WoK4/NCz5vmNDN2LS/WLRlcYisuC+h/1n71YmTX9R
 P4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736725195; x=1737329995;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1LD6iflLB0gH4nA2fp+FkFqrD38sUdaRnXC9vr+9Irs=;
 b=J99xjAsTO33Ql0Dn1qdu/E591jdD6yRB5yVOWeKNsbIVmzBI25tWDxYPsNVAVUAZa5
 8WGvTTbOgrugBWHYYGNdL2y+Qe9QdfQX+yRvy+HczT61eBjeg5K6P/9bBf1ks825zTF0
 KWSz1rXU4QzugaPBcDVM8sr/LqEzn+QrPCj8wxgOZ8uTqJQJ84PzIOBfqHmZAeo1D75F
 eAbxX7a4zH519mr8cuwGycIZwmQRGLcAOzsbsLxzhxkTGd+cwm0Cq7N4rR48QWEOEEgp
 Hx+fEjGxN8sApcK25hgnpG0I3BKiZYsZUCN6a6UYbZhmTHEG5X5oqxO/oMzpOlSHai9j
 6P1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPcVNl8Ec1vBCnvFj8ithZlGBOUyqd65D2LfBI1Y9YL6cJXxWTPvjh/lFeIgBv/hLNCwm6f+bK4Q==@nongnu.org
X-Gm-Message-State: AOJu0YwWP/pwrajZOC2cd6DlIRnFsMrsbYaXbZgzBm05JKjG/wJO0/zX
 +H4ioOtd/PolORKuSKjjAQKWQ21+UunZD0lnh7K310RVc9WLOp5uHwSJzfkdRWnO+cXjkKy+jFg
 jUad8tvG+zh1NzWCBWmnI2k4thkw=
X-Gm-Gg: ASbGncu1rYaBL9aMDuZe4YEFtPjFB3OBSGQHXx0jKA9+A20zJqwhj/56oE93y5nH8tW
 CAjdW5AgI/Vbsu1EO24nyny1vmmftZnCsDjDjwXvMPcBmDFScbbrAjwFJUqmFJK70MZw=
X-Google-Smtp-Source: AGHT+IEwcFzXVZUKhdpNBzFj+YBWLJ1k0iIRET3SRZainwFYim4RtSkKxApaDxAhRGfHF9/maKZTz1W+sErz4RP52dU=
X-Received: by 2002:a05:6102:3c92:b0:4b6:1ce1:30a3 with SMTP id
 ada2fe7eead31-4b61ce132e1mr11788993137.4.1736725195075; Sun, 12 Jan 2025
 15:39:55 -0800 (PST)
MIME-Version: 1.0
References: <20250112225614.33723-1-philmd@linaro.org>
 <20250112225614.33723-2-philmd@linaro.org>
In-Reply-To: <20250112225614.33723-2-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 13 Jan 2025 09:39:29 +1000
X-Gm-Features: AbW1kvaMwoU4MFmHNT1IfOzbI8NBbLW3fFt7La_jRbubwpAc0WBJKabpw1NhRtE
Message-ID: <CAKmqyKOsO_og4HaGN94DmVaBtighS_QowtBvhqRnwyg_g4L37A@mail.gmail.com>
Subject: Re: [PATCH 1/3] hw/arm/nrf51: Rename ARMv7MState 'cpu' -> 'armv7m'
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Samuel Tardieu <sam@rfc1149.net>,
 qemu-arm@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, Felipe Balbi <balbi@kernel.org>, 
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, 
 Joel Stanley <joel@jms.id.au>, Alexandre Iooss <erdnaxe@crans.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92d;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92d.google.com
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

On Mon, Jan 13, 2025 at 8:57=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> The ARMv7MState object is not simply a CPU, it also
> contains the NVIC, SysTick timer, and various MemoryRegions.
>
> Rename the field as 'armv7m', like other Cortex-M boards.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  include/hw/arm/nrf51_soc.h |  2 +-
>  hw/arm/nrf51_soc.c         | 18 +++++++++---------
>  2 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/include/hw/arm/nrf51_soc.h b/include/hw/arm/nrf51_soc.h
> index e52a56e75e0..f88ab1b7d3e 100644
> --- a/include/hw/arm/nrf51_soc.h
> +++ b/include/hw/arm/nrf51_soc.h
> @@ -30,7 +30,7 @@ struct NRF51State {
>      SysBusDevice parent_obj;
>
>      /*< public >*/
> -    ARMv7MState cpu;
> +    ARMv7MState armv7m;
>
>      NRF51UARTState uart;
>      NRF51RNGState rng;
> diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
> index 37dd4cf5f40..dee06ab5654 100644
> --- a/hw/arm/nrf51_soc.c
> +++ b/hw/arm/nrf51_soc.c
> @@ -76,16 +76,16 @@ static void nrf51_soc_realize(DeviceState *dev_soc, E=
rror **errp)
>      }
>      /* This clock doesn't need migration because it is fixed-frequency *=
/
>      clock_set_hz(s->sysclk, HCLK_FRQ);
> -    qdev_connect_clock_in(DEVICE(&s->cpu), "cpuclk", s->sysclk);
> +    qdev_connect_clock_in(DEVICE(&s->armv7m), "cpuclk", s->sysclk);
>      /*
>       * This SoC has no systick device, so don't connect refclk.
>       * TODO: model the lack of systick (currently the armv7m object
>       * will always provide one).
>       */
>
> -    object_property_set_link(OBJECT(&s->cpu), "memory", OBJECT(&s->conta=
iner),
> +    object_property_set_link(OBJECT(&s->armv7m), "memory", OBJECT(&s->co=
ntainer),
>                               &error_abort);
> -    if (!sysbus_realize(SYS_BUS_DEVICE(&s->cpu), errp)) {
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->armv7m), errp)) {
>          return;
>      }
>
> @@ -104,7 +104,7 @@ static void nrf51_soc_realize(DeviceState *dev_soc, E=
rror **errp)
>      mr =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->uart), 0);
>      memory_region_add_subregion_overlap(&s->container, NRF51_UART_BASE, =
mr, 0);
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart), 0,
> -                       qdev_get_gpio_in(DEVICE(&s->cpu),
> +                       qdev_get_gpio_in(DEVICE(&s->armv7m),
>                         BASE_TO_IRQ(NRF51_UART_BASE)));
>
>      /* RNG */
> @@ -115,7 +115,7 @@ static void nrf51_soc_realize(DeviceState *dev_soc, E=
rror **errp)
>      mr =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->rng), 0);
>      memory_region_add_subregion_overlap(&s->container, NRF51_RNG_BASE, m=
r, 0);
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->rng), 0,
> -                       qdev_get_gpio_in(DEVICE(&s->cpu),
> +                       qdev_get_gpio_in(DEVICE(&s->armv7m),
>                         BASE_TO_IRQ(NRF51_RNG_BASE)));
>
>      /* UICR, FICR, NVMC, FLASH */
> @@ -161,7 +161,7 @@ static void nrf51_soc_realize(DeviceState *dev_soc, E=
rror **errp)
>
>          sysbus_mmio_map(SYS_BUS_DEVICE(&s->timer[i]), 0, base_addr);
>          sysbus_connect_irq(SYS_BUS_DEVICE(&s->timer[i]), 0,
> -                           qdev_get_gpio_in(DEVICE(&s->cpu),
> +                           qdev_get_gpio_in(DEVICE(&s->armv7m),
>                                              BASE_TO_IRQ(base_addr)));
>      }
>
> @@ -185,10 +185,10 @@ static void nrf51_soc_init(Object *obj)
>
>      memory_region_init(&s->container, obj, "nrf51-container", UINT64_MAX=
);
>
> -    object_initialize_child(OBJECT(s), "armv6m", &s->cpu, TYPE_ARMV7M);
> -    qdev_prop_set_string(DEVICE(&s->cpu), "cpu-type",
> +    object_initialize_child(OBJECT(s), "armv6m", &s->armv7m, TYPE_ARMV7M=
);
> +    qdev_prop_set_string(DEVICE(&s->armv7m), "cpu-type",
>                           ARM_CPU_TYPE_NAME("cortex-m0"));
> -    qdev_prop_set_uint32(DEVICE(&s->cpu), "num-irq", 32);
> +    qdev_prop_set_uint32(DEVICE(&s->armv7m), "num-irq", 32);
>
>      object_initialize_child(obj, "uart", &s->uart, TYPE_NRF51_UART);
>      object_property_add_alias(obj, "serial0", OBJECT(&s->uart), "chardev=
");
> --
> 2.47.1
>
>

