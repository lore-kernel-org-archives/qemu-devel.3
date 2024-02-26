Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63FBEC54E49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 00:19:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reOhC-0005ql-0O; Sun, 25 Feb 2024 19:18:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1reOhA-0005qX-7z; Sun, 25 Feb 2024 19:18:12 -0500
Received: from mail-ua1-x933.google.com ([2607:f8b0:4864:20::933])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1reOh8-0005St-8d; Sun, 25 Feb 2024 19:18:11 -0500
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-7d2940ad0e1so1471698241.1; 
 Sun, 25 Feb 2024 16:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708906688; x=1709511488; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QhaANUWuN8fK3c9zHQX7xQLw2JO7i6h0XPTTn/pdIBQ=;
 b=WvD3O5jc8mNtGxOR1xKkbOixoZjk4gKrhpUsuS7O01fD4z6mClrlJzSPz+2bebh7XS
 WEAgi/NhCwXtopI/rpi2avGLcdWrYnv19IRf0+szjEeQH7DcKoTbjaWNxpMhT33nYBQk
 oV2XmP3gkMMC8RlWfRNh6wAFeM8dqzTTYbRoG7zPyu1RWKnuSq37wyT3GsiZ8M6V6CkI
 6f8/ZoNAd3ZYyvWQy5r3EOs2WMXVOYQ1oSRQSvkMsf88sPTAjSVHaPyKfW5h2MoAhElr
 3710/Vt7hN5P04vaMmEoy7YSSm3jXkz5Gz9tEntSvV1GmzNEAM/EmvVLLmgS8DWhCDPp
 JpmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708906688; x=1709511488;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QhaANUWuN8fK3c9zHQX7xQLw2JO7i6h0XPTTn/pdIBQ=;
 b=adXe/UuwFtjtEUOjLA6WEA1awz+0NCtIjSyw/ezEwQVD6B9lYgnekUtOwZUQoe0khz
 dHp6Y3VQed7qOW+IHe+tdxl5LsuiFrPbNqe6ejNl++BBSt4QF/XocmhLZ7cHapVAznIa
 hc9rZCzNZEQ3tL3iXs85MGTj22vA/RV1eQ8cn1RG0tep0A24XyI0aZ2j8WPJjs138mQd
 kSG9JRZ6HCxjGJGwFzJ1Pjlk3P6l5C5SV1NWgsftFkFFmL3asKS/6c1YP3BsOvq+x5AD
 oF2osFraXciSFXh1J/YMuyXPOcr+nuFaaiZvQMFor4UUEiLIdxdoF3fxHUnHzTHlTvAE
 JKQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4uLX+qF+H2B4z94aUUfLUhodXP+A/+tnyOiJ1ZBKAKFHMjYCQfdvfx6YdeAJ0Jry9ztwVmJ+HmiUKmh+btFzz5hBO
X-Gm-Message-State: AOJu0YyZwE+pv1UzXfybapijQ9G0lCukFSkc6xE2Ux7x6Jc9UEHRjQPD
 Qa22EozqVXLOsPv3BohqPkUNlD/VFYE67Ut0QS2d1OID2ATJXaBMnJcSR63jkX+mUnQamv+/+Pd
 4LVvvaUCF2ymxjTKoO+3ZUrMiJSg=
X-Google-Smtp-Source: AGHT+IFiexFvrVA3is6kMdqYuf4XxOoe92RAolGi+Wy9gSHVxaoV3ymPsRLeS0qgJN0Uicn0h48x7q78DXh3r5p/Lyc=
X-Received: by 2002:a05:6102:3234:b0:470:3a5d:a711 with SMTP id
 x20-20020a056102323400b004703a5da711mr2608860vsf.6.1708906688588; Sun, 25 Feb
 2024 16:18:08 -0800 (PST)
MIME-Version: 1.0
References: <20240220184145.106107-1-ines.varhol@telecom-paris.fr>
 <20240220184145.106107-2-ines.varhol@telecom-paris.fr>
In-Reply-To: <20240220184145.106107-2-ines.varhol@telecom-paris.fr>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 26 Feb 2024 10:17:42 +1000
Message-ID: <CAKmqyKMSUNBgMnNA1H8=suyotrmM-cN9=V_d7iRTbR0zbBVAhQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] hw/arm: Use TYPE_OR_IRQ when connecting STM32L4x5
 EXTI fan-in IRQs
To: =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>,
 Alistair Francis <alistair@alistair23.me>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::933;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x933.google.com
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

On Wed, Feb 21, 2024 at 4:42=E2=80=AFAM In=C3=A8s Varhol
<ines.varhol@telecom-paris.fr> wrote:
>
> Fixes: 52671f69f7a4 ("[PATCH v8 0/3] Add device STM32L4x5 EXTI")
> Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  include/hw/arm/stm32l4x5_soc.h |  4 ++
>  hw/arm/stm32l4x5_soc.c         | 80 +++++++++++++++++++++++++++++-----
>  2 files changed, 74 insertions(+), 10 deletions(-)
>
> diff --git a/include/hw/arm/stm32l4x5_soc.h b/include/hw/arm/stm32l4x5_so=
c.h
> index baf70410b5..4f314b7a93 100644
> --- a/include/hw/arm/stm32l4x5_soc.h
> +++ b/include/hw/arm/stm32l4x5_soc.h
> @@ -26,6 +26,7 @@
>
>  #include "exec/memory.h"
>  #include "hw/arm/armv7m.h"
> +#include "hw/or-irq.h"
>  #include "hw/misc/stm32l4x5_syscfg.h"
>  #include "hw/misc/stm32l4x5_exti.h"
>  #include "qom/object.h"
> @@ -36,12 +37,15 @@
>  #define TYPE_STM32L4X5XG_SOC "stm32l4x5xg-soc"
>  OBJECT_DECLARE_TYPE(Stm32l4x5SocState, Stm32l4x5SocClass, STM32L4X5_SOC)
>
> +#define NUM_EXTI_OR_GATES 4
> +
>  struct Stm32l4x5SocState {
>      SysBusDevice parent_obj;
>
>      ARMv7MState armv7m;
>
>      Stm32l4x5ExtiState exti;
> +    OrIRQState exti_or_gates[NUM_EXTI_OR_GATES];
>      Stm32l4x5SyscfgState syscfg;
>
>      MemoryRegion sram1;
> diff --git a/hw/arm/stm32l4x5_soc.c b/hw/arm/stm32l4x5_soc.c
> index f470ff74ec..d1786e0da1 100644
> --- a/hw/arm/stm32l4x5_soc.c
> +++ b/hw/arm/stm32l4x5_soc.c
> @@ -26,6 +26,7 @@
>  #include "qapi/error.h"
>  #include "exec/address-spaces.h"
>  #include "sysemu/sysemu.h"
> +#include "hw/or-irq.h"
>  #include "hw/arm/stm32l4x5_soc.h"
>  #include "hw/qdev-clock.h"
>  #include "hw/misc/unimp.h"
> @@ -42,21 +43,24 @@
>  #define NUM_EXTI_IRQ 40
>  /* Match exti line connections with their CPU IRQ number */
>  /* See Vector Table (Reference Manual p.396) */
> +/*
> + * Some IRQs are connected to the same CPU IRQ (denoted by -1)
> + * and require an intermediary OR gate to function correctly.
> + */
>  static const int exti_irq[NUM_EXTI_IRQ] =3D {
>      6,                      /* GPIO[0]                 */
>      7,                      /* GPIO[1]                 */
>      8,                      /* GPIO[2]                 */
>      9,                      /* GPIO[3]                 */
>      10,                     /* GPIO[4]                 */
> -    23, 23, 23, 23, 23,     /* GPIO[5..9]              */
> -    40, 40, 40, 40, 40, 40, /* GPIO[10..15]            */
> -    1,                      /* PVD                     */
> +    -1, -1, -1, -1, -1,     /* GPIO[5..9] OR gate 23   */
> +    -1, -1, -1, -1, -1, -1, /* GPIO[10..15] OR gate 40 */
> +    -1,                     /* PVD OR gate 1           */
>      67,                     /* OTG_FS_WKUP, Direct     */
>      41,                     /* RTC_ALARM               */
>      2,                      /* RTC_TAMP_STAMP2/CSS_LSE */
>      3,                      /* RTC wakeup timer        */
> -    63,                     /* COMP1                   */
> -    63,                     /* COMP2                   */
> +    -1, -1,                 /* COMP[1..2] OR gate 63   */
>      31,                     /* I2C1 wakeup, Direct     */
>      33,                     /* I2C2 wakeup, Direct     */
>      72,                     /* I2C3 wakeup, Direct     */
> @@ -69,18 +73,39 @@ static const int exti_irq[NUM_EXTI_IRQ] =3D {
>      65,                     /* LPTIM1, Direct          */
>      66,                     /* LPTIM2, Direct          */
>      76,                     /* SWPMI1 wakeup, Direct   */
> -    1,                      /* PVM1 wakeup             */
> -    1,                      /* PVM2 wakeup             */
> -    1,                      /* PVM3 wakeup             */
> -    1,                      /* PVM4 wakeup             */
> +    -1, -1, -1, -1,         /* PVM[1..4] OR gate 1     */
>      78                      /* LCD wakeup, Direct      */
>  };
>
> +static const int exti_or_gates_out[NUM_EXTI_OR_GATES] =3D {
> +    23, 40, 63, 1,
> +};
> +
> +static const int exti_or_gates_num_lines_in[NUM_EXTI_OR_GATES] =3D {
> +    5, 6, 2, 5,
> +};
> +
> +/* 3 OR gates with consecutive inputs */
> +#define NUM_EXTI_SIMPLE_OR_GATES 3
> +static const int exti_or_gates_first_line_in[NUM_EXTI_SIMPLE_OR_GATES] =
=3D {
> +    5, 10, 21,
> +};
> +
> +/* 1 OR gate with non-consecutive inputs */
> +#define EXTI_OR_GATE1_NUM_LINES_IN 5
> +static const int exti_or_gate1_lines_in[EXTI_OR_GATE1_NUM_LINES_IN] =3D =
{
> +    16, 35, 36, 37, 38,
> +};
> +
>  static void stm32l4x5_soc_initfn(Object *obj)
>  {
>      Stm32l4x5SocState *s =3D STM32L4X5_SOC(obj);
>
>      object_initialize_child(obj, "exti", &s->exti, TYPE_STM32L4X5_EXTI);
> +    for (unsigned i =3D 0; i < NUM_EXTI_OR_GATES; i++) {
> +        object_initialize_child(obj, "exti_or_gates[*]", &s->exti_or_gat=
es[i],
> +                                TYPE_OR_IRQ);
> +    }
>      object_initialize_child(obj, "syscfg", &s->syscfg, TYPE_STM32L4X5_SY=
SCFG);
>
>      s->sysclk =3D qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0)=
;
> @@ -175,8 +200,43 @@ static void stm32l4x5_soc_realize(DeviceState *dev_s=
oc, Error **errp)
>          return;
>      }
>      sysbus_mmio_map(busdev, 0, EXTI_ADDR);
> +
> +    /* IRQs with fan-in that require an OR gate */
> +    for (unsigned i =3D 0; i < NUM_EXTI_OR_GATES; i++) {
> +        if (!object_property_set_int(OBJECT(&s->exti_or_gates[i]), "num-=
lines",
> +                                     exti_or_gates_num_lines_in[i], errp=
)) {
> +            return;
> +        }
> +        if (!qdev_realize(DEVICE(&s->exti_or_gates[i]), NULL, errp)) {
> +            return;
> +        }
> +
> +        qdev_connect_gpio_out(DEVICE(&s->exti_or_gates[i]), 0,
> +            qdev_get_gpio_in(armv7m, exti_or_gates_out[i]));
> +
> +        if (i < NUM_EXTI_SIMPLE_OR_GATES) {
> +            /* consecutive inputs for OR gates 23, 40, 63 */
> +            for (unsigned j =3D 0; j < exti_or_gates_num_lines_in[i]; j+=
+) {
> +                sysbus_connect_irq(SYS_BUS_DEVICE(&s->exti),
> +                    exti_or_gates_first_line_in[i] + j,
> +                    qdev_get_gpio_in(DEVICE(&s->exti_or_gates[i]), j));
> +            }
> +        } else {
> +            /* non-consecutive inputs for OR gate 1 */
> +            for (unsigned j =3D 0; j < EXTI_OR_GATE1_NUM_LINES_IN; j++) =
{
> +                sysbus_connect_irq(SYS_BUS_DEVICE(&s->exti),
> +                    exti_or_gate1_lines_in[j],
> +                    qdev_get_gpio_in(DEVICE(&s->exti_or_gates[i]), j));
> +            }
> +        }
> +    }
> +
> +    /* IRQs that don't require fan-in */
>      for (unsigned i =3D 0; i < NUM_EXTI_IRQ; i++) {
> -        sysbus_connect_irq(busdev, i, qdev_get_gpio_in(armv7m, exti_irq[=
i]));
> +        if (exti_irq[i] !=3D -1) {
> +            sysbus_connect_irq(busdev, i,
> +                               qdev_get_gpio_in(armv7m, exti_irq[i]));
> +        }
>      }
>
>      for (unsigned i =3D 0; i < 16; i++) {
> --
> 2.43.2
>
>

