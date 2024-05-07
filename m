Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D94AEC10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 09:50:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4HT6-0000Wq-Jq; Tue, 07 May 2024 05:50:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s4HT4-0000TK-SP
 for qemu-devel@nongnu.org; Tue, 07 May 2024 05:50:39 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s4HT2-0004Cm-CZ
 for qemu-devel@nongnu.org; Tue, 07 May 2024 05:50:38 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-51ff65b1e14so3491675e87.2
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 02:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715075434; x=1715680234; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3xB9y6e7IAHiEp8If4b36zppCTyWuRdj3rszw6jl/hw=;
 b=IJc+WXK6HtSlblDOV5+gdz3HBoTCII7iiH3y9gDqFUSpTnv0Yqtgw1K281jsZPKy0C
 Oo53mgakvN4UO2cr5+QyxhuPz+thxhgx1R/ze0OvVpZo9VNmpJN9nbgr0+Q7uRZ/M6/Q
 Xp81VG1JVXHDhcKAyMfOZjFA0P6JRHZa9bU44shjG9LxUQ0NsaXL6I8ToADYNqGzv2t8
 fkcZbiWRnoaHSwUssBbd74DMQJwMaom7H+8gqA0tZrPg7XzMRlOzmTn9kwi61pZZpas4
 kkfhCdQH0fNkN75FDCq08NtNAGVFkAUAQH+Xsc6VjTVbb871MyFwWf3QTQWLfJrNecDj
 cb+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715075434; x=1715680234;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3xB9y6e7IAHiEp8If4b36zppCTyWuRdj3rszw6jl/hw=;
 b=CtgldbsaDhU7d5RUCgesDRA6fw2kKm6GibOyEOEKkI1mbEruZ1O2eDOrOGlpOUNvPa
 6qtQ1Dj3/JaIFroq47Aj/JCxJkivZCsOV6Lt0E4g9IAETL8mmG+sDPfglmLH6z3RGmRT
 hqNpZi9+irPTcptF5YmVy3lUU5V50RLUJWWO/DoztQbFj5AVC62PTl4GT+cWhPD09gyl
 6VSPjzBWrYXv7oN8boAYmegWOaVcVnjIWNpiA5ic0HGoHG2udxWGSINvDs3SgjWf3LED
 MjvRpkdnWpAhbwQYVBGYZUp9ZTGzT3ldRWzXQ3KfoXDugHe7R3vWTXHVokafczT/oL+0
 0Ucw==
X-Gm-Message-State: AOJu0YyxQPyLlV7jZe67VKubGV5IMj6tmaGjuelyYqM82PHHk2boSBTh
 qYJ4H//SjyJcoLBpMRJu5+P7wdpfLs0kULrfJdPEYmeYaH+mmpFhe3uirfYZ2cqxfbRpunTD06l
 8XruTwcHmlbnZYAYPbztK3/YSlNUihPUuGO/ozw==
X-Google-Smtp-Source: AGHT+IEj87l3Os/7f28LGWBqFgOJgrYCa4SeLJlf2BqRyivpBEGkMQ34Y/oBriNav023s80bNSpTol67tGKh+RzfJp8=
X-Received: by 2002:a19:c201:0:b0:51b:79b7:8322 with SMTP id
 l1-20020a19c201000000b0051b79b78322mr6740846lfc.52.1715075433728; Tue, 07 May
 2024 02:50:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240505140556.373711-1-ines.varhol@telecom-paris.fr>
 <20240505140556.373711-2-ines.varhol@telecom-paris.fr>
In-Reply-To: <20240505140556.373711-2-ines.varhol@telecom-paris.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 May 2024 10:50:23 +0100
Message-ID: <CAFEAcA9kOhzn+9pXOTBwRdLmMcFfPQzwwX6Nv_90RLPiUH6JAA@mail.gmail.com>
Subject: Re: [PATCH 1/4] hw/misc: Create STM32L4x5 SYSCFG clock
To: =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Laurent Vivier <lvivier@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Alistair Francis <alistair@alistair23.me>,
 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sun, 5 May 2024 at 15:06, In=C3=A8s Varhol <ines.varhol@telecom-paris.fr=
> wrote:
>
> Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>

In general you should try to avoid commits with no commit message.
Sometimes there really isn't anything to say beyond what the
subject line is, but that should be the exception rather than
the usual thing.

> ---
>  include/hw/misc/stm32l4x5_syscfg.h |  1 +
>  hw/arm/stm32l4x5_soc.c             |  2 ++
>  hw/misc/stm32l4x5_syscfg.c         | 26 ++++++++++++++++++++++++++
>  3 files changed, 29 insertions(+)
>
> diff --git a/include/hw/misc/stm32l4x5_syscfg.h b/include/hw/misc/stm32l4=
x5_syscfg.h
> index 23bb564150..c450df2b9e 100644
> --- a/include/hw/misc/stm32l4x5_syscfg.h
> +++ b/include/hw/misc/stm32l4x5_syscfg.h
> @@ -48,6 +48,7 @@ struct Stm32l4x5SyscfgState {
>      uint32_t swpr2;
>
>      qemu_irq gpio_out[GPIO_NUM_PINS];
> +    Clock *clk;
>  };
>
>  #endif
> diff --git a/hw/arm/stm32l4x5_soc.c b/hw/arm/stm32l4x5_soc.c
> index 38f7a2d5d9..fb2afa6cfe 100644
> --- a/hw/arm/stm32l4x5_soc.c
> +++ b/hw/arm/stm32l4x5_soc.c
> @@ -236,6 +236,8 @@ static void stm32l4x5_soc_realize(DeviceState *dev_so=
c, Error **errp)
>
>      /* System configuration controller */
>      busdev =3D SYS_BUS_DEVICE(&s->syscfg);
> +    qdev_connect_clock_in(DEVICE(&s->syscfg), "clk",
> +        qdev_get_clock_out(DEVICE(&(s->rcc)), "syscfg-out"));
>      if (!sysbus_realize(busdev, errp)) {
>          return;
>      }
> diff --git a/hw/misc/stm32l4x5_syscfg.c b/hw/misc/stm32l4x5_syscfg.c
> index a5a1ce2680..a82864c33d 100644
> --- a/hw/misc/stm32l4x5_syscfg.c
> +++ b/hw/misc/stm32l4x5_syscfg.c
> @@ -26,6 +26,10 @@
>  #include "trace.h"
>  #include "hw/irq.h"
>  #include "migration/vmstate.h"
> +#include "hw/clock.h"
> +#include "hw/qdev-clock.h"
> +#include "qapi/visitor.h"
> +#include "qapi/error.h"
>  #include "hw/misc/stm32l4x5_syscfg.h"
>  #include "hw/gpio/stm32l4x5_gpio.h"
>
> @@ -202,6 +206,14 @@ static void stm32l4x5_syscfg_write(void *opaque, hwa=
ddr addr,
>      }
>  }
>
> +static void clock_freq_get(Object *obj, Visitor *v,
> +    const char *name, void *opaque, Error **errp)
> +{
> +    Stm32l4x5SyscfgState *s =3D STM32L4X5_SYSCFG(obj);
> +    uint32_t clock_freq_hz =3D clock_get_hz(s->clk);
> +    visit_type_uint32(v, name, &clock_freq_hz, errp);
> +}
> +
>  static const MemoryRegionOps stm32l4x5_syscfg_ops =3D {
>      .read =3D stm32l4x5_syscfg_read,
>      .write =3D stm32l4x5_syscfg_write,
> @@ -225,6 +237,18 @@ static void stm32l4x5_syscfg_init(Object *obj)
>      qdev_init_gpio_in(DEVICE(obj), stm32l4x5_syscfg_set_irq,
>                        GPIO_NUM_PINS * NUM_GPIOS);
>      qdev_init_gpio_out(DEVICE(obj), s->gpio_out, GPIO_NUM_PINS);
> +    s->clk =3D qdev_init_clock_in(DEVICE(s), "clk", NULL, s, 0);
> +    object_property_add(obj, "clock-freq-hz", "uint32", clock_freq_get, =
NULL,
> +                        NULL, NULL);

Why do we need this property? The clock on this device is an input,
so the device doesn't control its frequency.

> +}
> +
> +static void stm32l4x5_syscfg_realize(DeviceState *dev, Error **errp)
> +{
> +    Stm32l4x5SyscfgState *s =3D STM32L4X5_SYSCFG(dev);
> +    if (!clock_has_source(s->clk)) {
> +        error_setg(errp, "SYSCFG: clk input must be connected");
> +        return;
> +    }
>  }
>
>  static const VMStateDescription vmstate_stm32l4x5_syscfg =3D {
> @@ -241,6 +265,7 @@ static const VMStateDescription vmstate_stm32l4x5_sys=
cfg =3D {
>          VMSTATE_UINT32(swpr, Stm32l4x5SyscfgState),
>          VMSTATE_UINT32(skr, Stm32l4x5SyscfgState),
>          VMSTATE_UINT32(swpr2, Stm32l4x5SyscfgState),
> +        VMSTATE_CLOCK(clk, Stm32l4x5SyscfgState),

Adding a field to the vmstate means we must bump the version number,
since it's a migration compatibility break.

>          VMSTATE_END_OF_LIST()
>      }
>  };

thanks
-- PMM

