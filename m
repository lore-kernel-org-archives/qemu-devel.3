Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC30EC02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 14:23:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcPzw-0003MT-Ci; Mon, 27 Jan 2025 09:21:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcPze-00037R-DM
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 09:21:42 -0500
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcPzc-0002on-Il
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 09:21:37 -0500
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e3a1cfeb711so6380304276.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 06:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737987695; x=1738592495; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IqT9Pqud4yyi1nkIL9hnP/ngJ2ww+fjlQNiSnOSjGhA=;
 b=W+oe4XqAJLu5xB1dHIAtTwgvjLN0cmoTT6+L65JDyThbcVN71y/1rsH534+RBMK+fq
 StzEJlqTYKQqZ4JU/khw3qUlMQMg8InbJu4pW8GcnbH5cDBCcPbErhZB0C1wJI33JJ+c
 y1qUp1v2z5odTQM/lQCuedPC6oDovpAGmXr3ONHaWo3yE88t4h931nkoKozGoC0YSKnI
 /o1mV94W9TMdoFgiZev6g+k2FJjyM1OoUI3MF4J8/kQ3IyIB3MoaSxkGUUFOl2Sqx+BW
 oe7GUd4qdoJg4iTJQA5c9c7WdbEslZLOs4rK8CMl09YYwUmC4gMT+SQ9fwxyUO6QupNy
 9enw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737987695; x=1738592495;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IqT9Pqud4yyi1nkIL9hnP/ngJ2ww+fjlQNiSnOSjGhA=;
 b=Zwy64sWZDs5Ja/ZCGS05gS4EE4GnTj/oo7a04GOjhq3QIBz1Zg5ekDsrOGpOtstDm2
 mb5ZhcOsX/RVS2U6Lk3Y/waATM1ToeNpfmF0XwNVeqFwAiEhzj3jGEQBASSym1QPO2De
 kYnTqdG/eClgtRF0qF+TYx2/ADDggBTU1GIWZQLMgOukPSjbWmT8JEVXoviM9LahUv1p
 SxBvBuTfotTcVeJRWsH+OaU79dI8NJJgz9Jrweb2ORb5Lh2tFTCOcoHf1FU5+WulpWrg
 RdNEglkyL9mmncrQsUHSw6sFyKlbuCwH07/ZB2GqyErueOIpPBR11cqzJHtPReUBmBwe
 By7A==
X-Gm-Message-State: AOJu0Yzl7Ex9LKUVbMDnAiDWDF04Av2GTrOUgp/Uiiacp/YI//AMjAwY
 lQH6LIF/tmCiwPqpRtkZpcaf+3E2m1ZbdL4Rk/zRgyaP7BDDwJufunhPiZjlQOpav9loJ5OQArm
 duIQc8nEh6VXgcDSb+EJKsVP4vi88vXL/dbsSPw==
X-Gm-Gg: ASbGncu3ktJZgAFU8iFd1HIRh5cVjhrc6UPfAgl+UzNCPbJes9Unbuos0FP9BrMnwsO
 +a7jYLuTnoAVcMt5Gvv+BaN8GiG2odm9NT6Jr4jZcItvDB9ffYw/JkYnjfVC6fdk=
X-Google-Smtp-Source: AGHT+IES1lnPe9WOF6RLhlvSDLSQb9z3UHaiH8CTxK2FsNtXKr3x0e0zFvPMl2ujRgc1sNUaz6/rYTP1JYFlDxsdADU=
X-Received: by 2002:a05:6902:2b89:b0:e39:73f7:b13f with SMTP id
 3f1490d57ef6-e57b106357bmr25841645276.18.1737987695340; Mon, 27 Jan 2025
 06:21:35 -0800 (PST)
MIME-Version: 1.0
References: <20250110160204.74997-1-philmd@linaro.org>
 <20250110160204.74997-10-philmd@linaro.org>
In-Reply-To: <20250110160204.74997-10-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Jan 2025 14:21:24 +0000
X-Gm-Features: AWEUYZlznFRi5lhN7GGj6NwdgjXJhdWPd5AZ8pDgARaGIOX2cLir86Q4xQHQzdk
Message-ID: <CAFEAcA9u2YpHLPuU+268Ft=QKxTr5S_b+jtQCR1SEf7O3jNvbQ@mail.gmail.com>
Subject: Re: [PATCH 9/9] hw/arm/stellaris: Wire GPTM[#n] output to ADC input #n
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b32;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, 10 Jan 2025 at 16:02, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> The ADC model is very simple, and only consider the 4 GPTM
> IRQs as trigger. Currently they are all wired to the same
> input IRQ. This is a QDev design mistake. We could use a
> OR_IRQ, but the ADC actually really has one input for each
> GPTM, so have the ADC create 4 inputs and wire each GPTM
> output to them.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/arm/stellaris.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
>
> diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
> index c89522332e2..446d6595a6d 100644
> --- a/hw/arm/stellaris.c
> +++ b/hw/arm/stellaris.c
> @@ -701,8 +701,16 @@ static void stellaris_i2c_init(Object *obj)
>      sysbus_init_mmio(sbd, &s->iomem);
>  }
>
> -/* Analogue to Digital Converter.  This is only partially implemented,
> -   enough for applications that use a combined ADC and timer tick.  */
> +/*
> + * Analogue to Digital Converter.
> + *
> + * Each of the 4 trigger inputs has a MUX for 5 inputs
> + * (see Stellaris Data Sheet Figure 11-1: "ADC Module Block Diagram").
> + *
> + * This model only consider the GPTM inputs, thus MUX is not implemented=
.
> + */
> +
> +#define STELLARIS_ADC_TRIGGERS      4
>
>  #define STELLARIS_ADC_EM_CONTROLLER 0
>  #define STELLARIS_ADC_EM_COMP       1
> @@ -986,7 +994,7 @@ static void stellaris_adc_init(Object *obj)
>      memory_region_init_io(&s->iomem, obj, &stellaris_adc_ops, s,
>                            "adc", 0x1000);
>      sysbus_init_mmio(sbd, &s->iomem);
> -    qdev_init_gpio_in(dev, stellaris_adc_trigger, 1);
> +    qdev_init_gpio_in(dev, stellaris_adc_trigger, STELLARIS_ADC_TRIGGERS=
);
>  }
>
>  /* Board init.  */
> @@ -1061,7 +1069,7 @@ static void stellaris_init(MachineState *ms, stella=
ris_board_info *board)
>      DeviceState *gpio_dev[NUM_GPIO], *nvic;
>      qemu_irq gpio_in[NUM_GPIO][8];
>      qemu_irq gpio_out[NUM_GPIO][8];
> -    qemu_irq adc;
> +    DeviceState *adc;
>      int sram_size;
>      int flash_size;
>      DeviceState *i2c_dev[NUM_I2C];
> @@ -1144,15 +1152,12 @@ static void stellaris_init(MachineState *ms, stel=
laris_board_info *board)
>      sysbus_connect_irq(SYS_BUS_DEVICE(ssys_dev), 0, qdev_get_gpio_in(nvi=
c, 28));
>
>      if (DEV_CAP(1, ADC)) {
> -        dev =3D sysbus_create_varargs(TYPE_STELLARIS_ADC, 0x40038000,
> +        adc =3D sysbus_create_varargs(TYPE_STELLARIS_ADC, 0x40038000,
>                                      qdev_get_gpio_in(nvic, 14),
>                                      qdev_get_gpio_in(nvic, 15),
>                                      qdev_get_gpio_in(nvic, 16),
>                                      qdev_get_gpio_in(nvic, 17),
>                                      NULL);
> -        adc =3D qdev_get_gpio_in(dev, 0);
> -    } else {
> -        adc =3D NULL;
>      }

Here you remove the code path that initializes adc to NULL
if the device doesn't have an ADC...

>      for (i =3D 0; i < NUM_GPTM; i++) {
>          if (DEV_CAP(2, GPTM(i))) {
> @@ -1166,9 +1171,12 @@ static void stellaris_init(MachineState *ms, stell=
aris_board_info *board)
>              sysbus_realize_and_unref(sbd, &error_fatal);
>              sysbus_mmio_map(sbd, 0, 0x40030000 + i * 0x1000);
>              sysbus_connect_irq(sbd, 0, qdev_get_gpio_in(nvic, timer_irq[=
i]));
> +
>              /* TODO: This is incorrect, but we get away with it because
>                 the ADC output is only ever pulsed.  */
> -            qdev_connect_gpio_out(dev, 0, adc);
> +            if (adc) {
> +                qdev_connect_gpio_out(dev, 0, qdev_get_gpio_in(adc, i));
> +            }

...but here you add a test on whether adc is set or not.

>          }
>      }

thanks
-- PMM

