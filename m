Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38DC6C54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 17:07:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdZ0O-0006WJ-8d; Fri, 23 Feb 2024 12:06:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdYod-0007Bf-5F
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 11:54:27 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdYoN-0003a7-0N
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 11:54:26 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5658082d2c4so881947a12.1
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 08:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708707248; x=1709312048; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UE0Xd9bdykHpEmQMOX2ZhjBeXUGnR/Lfv6lcw5+pgys=;
 b=O3HJmwInn7TQZjAgQZFPAc2CeWo/J8hCjits6io88Kk82yYQladgZBsHCil/GscUKL
 gn368g2JwBeJRpOVGrAqMSiXyS76R5r24Tcj5cK9cPgfW5CGAi7/z5imhBpHevWI2jta
 ikBU/yHHDiQQ8EaJylS6IyQh6RUUSG3HMfGrUdpNqsI3a6mEkTLu0dKmmDcW481ZcPnG
 jvEgCF1gSylFAEHYfAB5LSDrE1AXkfKIxsQ1ORbuOk9V4up0APXZBWt8pfKyPbcoP9sw
 zTxOKDvRF9bRUg30x61lyai91+MjGEQxG+4Amxxmr50oBRHkctmlyQMaeJ3vX6l/w3e7
 TgMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708707248; x=1709312048;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UE0Xd9bdykHpEmQMOX2ZhjBeXUGnR/Lfv6lcw5+pgys=;
 b=H5UvqyReZBbH0Pak7Vy7lUzY3pPy2l3yVLHkcEno2cJ812POYFeIMQ4eYxbh1bZAAq
 xk7d6uAA4qLEKP8gOKC9o88377qoEsSPP8iB4csBCM1aL/9o33rylQOTY2i66gbjZfOx
 cvEw+lTek+SAInYOj0xZw9Jg3YAtv7aURiv6apB86pYxSFXiWf+OE0o534TLZ+yI3KyK
 pE7NDOS49EbZLcyIrh0RVvQ1tOh1lpyjZ77U918cnGlYkiRghh+BXHIxVvZgaSv9dl0x
 lt3Kfdw+UULnz3Pr+WTZoQzC3xWw+DskFlUrYpXpzHtlEneW7no59eLIdlR90B0i4jXw
 f/7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUbJJb2Vou0LmQ15l55a5ImI1BhtBjSLqf1ZRJycNj5m4uyUHh9l432KrwSvV47KpY+yuPGejf817oagI65q0ptQwS4pM=
X-Gm-Message-State: AOJu0YzvZFDz1XgEdoQQj6fgPodDAyzCjJVtB2SUnyW55Y6dossjLti+
 gxWAgQT8Ql9u8qXsDzdJB9sDIz2DfWKs0dUFBWNkV7ENeahguMt2u5eSVTgg3HbbUczwaLdPjlG
 d9hDRBaNqjuKS7cetyMYAwo7nOVuILcRuvboHyw==
X-Google-Smtp-Source: AGHT+IGw0drEB3ijh+qbdYOm4nyKqaqOegpkVRVB60MCK0nVv9U+Cu91UhXjMqwZqb+CNH01lbORtzkqzB0cuKlhCBE=
X-Received: by 2002:aa7:d907:0:b0:564:b822:9204 with SMTP id
 a7-20020aa7d907000000b00564b8229204mr263335edr.17.1708707247871; Fri, 23 Feb
 2024 08:54:07 -0800 (PST)
MIME-Version: 1.0
References: <20240219011739.2316619-1-sergey.kambalin@auriga.com>
 <20240219011739.2316619-18-sergey.kambalin@auriga.com>
In-Reply-To: <20240219011739.2316619-18-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2024 16:53:57 +0000
Message-ID: <CAFEAcA9e+7aB7PdxfHLDmhBfhvDy2Njtj4BMXbssJi+6E=WkZw@mail.gmail.com>
Subject: Re: [PATCH v5 17/41] Implement BCM2838 thermal sensor
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 19 Feb 2024 at 01:21, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---
>  hw/arm/bcm2838_peripherals.c         | 27 ++++++--
>  hw/arm/raspi4b.c                     |  1 -
>  hw/misc/bcm2838_thermal.c            | 98 ++++++++++++++++++++++++++++
>  hw/misc/meson.build                  |  3 +-
>  include/hw/arm/bcm2838_peripherals.h |  2 +
>  include/hw/misc/bcm2838_thermal.h    | 24 +++++++
>  6 files changed, 147 insertions(+), 8 deletions(-)
>  create mode 100644 hw/misc/bcm2838_thermal.c
>  create mode 100644 include/hw/misc/bcm2838_thermal.h
>
> diff --git a/hw/arm/bcm2838_peripherals.c b/hw/arm/bcm2838_peripherals.c
> index 6b4c840c5b..48c5fd5978 100644
> --- a/hw/arm/bcm2838_peripherals.c
> +++ b/hw/arm/bcm2838_peripherals.c
> @@ -37,6 +37,9 @@ static void bcm2838_peripherals_init(Object *obj)
>      /* Random Number Generator */
>      object_initialize_child(obj, "rng200", &s->rng200, TYPE_BCM2838_RNG200);
>
> +    /* Thermal */
> +    object_initialize_child(obj, "thermal", &s->thermal, TYPE_BCM2838_THERMAL);
> +
>      /* PCIe Host Bridge */
>      object_initialize_child(obj, "pcie-host", &s->pcie_host,
>                              TYPE_BCM2838_PCIE_HOST);
> @@ -78,6 +81,9 @@ static void bcm2838_peripherals_realize(DeviceState *dev, Error **errp)
>      BCMSocPeripheralBaseState *s_base = BCM_SOC_PERIPHERALS_BASE(dev);
>      MemoryRegion *regs_mr;
>      MemoryRegion *mmio_mr;
> +    MemoryRegion *rng200_mr;
> +    MemoryRegion *thermal_mr;
> +    qemu_irq rng_200_irq;
>
>      int n;
>
> @@ -95,12 +101,20 @@ static void bcm2838_peripherals_realize(DeviceState *dev, Error **errp)
>      if (!sysbus_realize(SYS_BUS_DEVICE(&s->rng200), errp)) {
>          return;
>      }
> -    memory_region_add_subregion(
> -        &s_base->peri_mr, RNG_OFFSET,
> -        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->rng200), 0));
> -    sysbus_connect_irq(SYS_BUS_DEVICE(&s->rng200), 0,
> -        qdev_get_gpio_in_named(DEVICE(&s_base->ic), BCM2835_IC_GPU_IRQ,
> -                               INTERRUPT_RNG));
> +    rng200_mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->rng200), 0);
> +    memory_region_add_subregion(&s_base->peri_mr, RNG_OFFSET, rng200_mr);
> +
> +    rng_200_irq = qdev_get_gpio_in_named(DEVICE(&s_base->ic),
> +                                         BCM2835_IC_GPU_IRQ, INTERRUPT_RNG);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->rng200), 0, rng_200_irq);

These are RNG200 related and look like they should be squashed into
the patch that added the RNG200 to the SoC.

> +
> +
> +    /* THERMAL */
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->thermal), errp)) {
> +        return;
> +    }
> +    thermal_mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->thermal), 0);
> +    memory_region_add_subregion( &s->peri_low_mr, 0x15D2000, thermal_mr);
>
>      /* Extended Mass Media Controller 2 */
>      object_property_set_uint(OBJECT(&s->emmc2), "sd-spec-version", 3,
> @@ -201,6 +215,7 @@ static void bcm2838_peripherals_realize(DeviceState *dev, Error **errp)
>                               BCM2838_MPHI_SIZE);
>      memory_region_add_subregion(&s_base->peri_mr, BCM2838_MPHI_OFFSET,
>                                  &s->mphi_mr_alias);
> +

Stray whitespace change: should be in some other patch, I suspect
(maybe the one adding the pcie to the SoC?)

>      /* PCIe Root Complex */
>      if (!sysbus_realize(SYS_BUS_DEVICE(&s->pcie_host), errp)) {
>          return;

> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index 7c769fd2a4..8a8c5ce659 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -91,7 +91,8 @@ system_ss.add(when: 'CONFIG_RASPI', if_true: files(
>    'bcm2835_thermal.c',
>    'bcm2835_cprman.c',
>    'bcm2835_powermgt.c',
> -  'bcm2838_rng200.c'
> +  'bcm2838_rng200.c',
> +  'bcm2838_thermal.c'

If you always keep a trailing comma on the end of this kind of list,
then you don't have to modify the preceding line when you add a new one.

>  ))
>  system_ss.add(when: 'CONFIG_SLAVIO', if_true: files('slavio_misc.c'))
>  system_ss.add(when: 'CONFIG_ZYNQ', if_true: files('zynq_slcr.c'))

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

