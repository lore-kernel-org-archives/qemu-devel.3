Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D56C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 13:23:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rabhM-0008EO-TN; Thu, 15 Feb 2024 08:22:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rabhL-0008Dx-Fm
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 08:22:43 -0500
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rabhI-0003Tx-2i
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 08:22:43 -0500
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-51187830d6dso952939e87.3
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 05:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708003358; x=1708608158; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lBGrsfvccFKt+n/qT2pY8JZycZj3V9kOv4t/FoyyIlU=;
 b=y0JUlorCkSmGJeeRcEH7Pm42xuSa5Wnf+8StZoAZYLqSS1J0sWLQ9r0UGkcaHr6Ax9
 b3Nu5qvCTMAAz6d4rtMK3c/46iW3eLX/xaT3IyNUSPjHICLc8PLAqa4g65vpAjnL7qi2
 /H/A969j61qC90O6oHJV0saj9BDXJU5JnvqcElNkDFr4u2o6dTqegwTfmWC4pxtWQjWV
 lLuLHHd81bHn1aKVWbCGL4FAsGGA2sSGzxfFeVyzEIsQMptyWGpy400QzGVdsA5EBuNf
 /mCgo2mCzabhAeST1BSi9fFDZ07usADFhIxjP0kiXZoWcy8tiUYmK5LixGB6BtU3bBml
 a7kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708003358; x=1708608158;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lBGrsfvccFKt+n/qT2pY8JZycZj3V9kOv4t/FoyyIlU=;
 b=Hm6oZYot3Z5+WxkWGO9loUyRFlT11RelTw09+kW4cqM5vNb3aaYLZhOGddq5GSvaM0
 9qRVgkyOIcnolIFOtXTmE7HDyGiAznqekqhHc+heM90s1LeoF2uLbVZEVo/XZ0bVa3hf
 lTtjbm7gBOZ+41jitKLtF0QM2J9NKYRRBskgZug0/dE7qaDpsJMWHSPBxlqQEx/+3fQQ
 KopWJth4ietJqC+7DsF4u6nY/b4ld+2IPnjqvt85vr5T9ZXmXnZZb+zW6zPeGpOVQ6RA
 Co/4ZcsmVKnOGW05Sjdw1p6AU+go0SW/FbEKwin2aQpYI3m9lEBCelGurJq5yaqjVBx9
 nq+Q==
X-Gm-Message-State: AOJu0YxeXN8tXBtlTVSXvtiVfKF3uvrgFAHkuhbIsUM2Q98XDW9VBOR2
 rwUfZ9wIniWJSkOVR3emdK64Kav4yatcPcf6J26n0bKR7bKGl52JOGKTvVj5RuEFILpJtkuLzBF
 tNStNRdvxdTDNWmF3HcQ9zX06Ji8/uGfVAc86tA==
X-Google-Smtp-Source: AGHT+IEVcdnxMu/+8B7A5wET1PWgSOSvs++sShzqPz5Es/RukAniXCqeoW9Xh9AgYto4LIvWjup9LuL9wrbdj0K+W6c=
X-Received: by 2002:ac2:46e1:0:b0:511:89b4:a6d9 with SMTP id
 q1-20020ac246e1000000b0051189b4a6d9mr1101972lfo.61.1708003358135; Thu, 15 Feb
 2024 05:22:38 -0800 (PST)
MIME-Version: 1.0
References: <20240212163446.227802-1-ines.varhol@telecom-paris.fr>
 <20240212163446.227802-2-ines.varhol@telecom-paris.fr>
In-Reply-To: <20240212163446.227802-2-ines.varhol@telecom-paris.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Feb 2024 13:22:27 +0000
Message-ID: <CAFEAcA-6G6xwX6q6Da7Zg_n-nHHpJ-d2GeLrC7FS8APcRZwShw@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/arm: Use TYPE_OR_IRQ when connecting STM32L4x5
 EXTI fan-in IRQs
To: =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-arm@nongnu.org, Arnaud Minier <arnaud.minier@telecom-paris.fr>, 
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12b.google.com
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

On Mon, 12 Feb 2024 at 16:34, In=C3=A8s Varhol <ines.varhol@telecom-paris.f=
r> wrote:
>
> Fixes: 52671f69f7a4 ("[PATCH v8 0/3] Add device STM32L4x5 EXTI")
> Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
> ---
>  hw/arm/stm32l4x5_soc.c | 69 ++++++++++++++++++++++++++++++++++++------
>  1 file changed, 59 insertions(+), 10 deletions(-)
>
> diff --git a/hw/arm/stm32l4x5_soc.c b/hw/arm/stm32l4x5_soc.c
> index f470ff74ec..df5bb02315 100644
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
> @@ -48,15 +49,14 @@ static const int exti_irq[NUM_EXTI_IRQ] =3D {
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
> @@ -69,13 +69,29 @@ static const int exti_irq[NUM_EXTI_IRQ] =3D {
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
> +#define NUM_EXTI_OR_GATES 4
> +static const int exti_or_gates_out[NUM_EXTI_OR_GATES] =3D {
> +    23, 40, 63, 1,
> +};
> +
> +#define NUM_EXTI_SIMPLE_FANIN_IRQ 3
> +static const int exti_or_gates_num_lines_in[NUM_EXTI_SIMPLE_FANIN_IRQ] =
=3D {
> +    5, 6, 2,
> +};

This array only has three elements, but you always set the
num-lines property on the OR gate using this array for all
NUM_EXTI_OR_GATES gates. I think the array should be size
NUM_EXTI_OR_GATES and have an extra element '5' at the end.

> +
> +static const int exti_or_gates_first_line_in[NUM_EXTI_SIMPLE_FANIN_IRQ] =
=3D {
> +    5, 10, 21,
> +};



> +
> +#define NUM_EXTI_OR_GATE1_NUM_LINES_IN 5
> +static const int exti_or_gate1_lines_in[NUM_EXTI_OR_GATE1_NUM_LINES_IN] =
=3D {
> +    16, 35, 36, 37, 38,
> +};



> +
>  static void stm32l4x5_soc_initfn(Object *obj)
>  {
>      Stm32l4x5SocState *s =3D STM32L4X5_SOC(obj);
> @@ -175,8 +191,41 @@ static void stm32l4x5_soc_realize(DeviceState *dev_s=
oc, Error **errp)
>          return;
>      }
>      sysbus_mmio_map(busdev, 0, EXTI_ADDR);
> +
> +    /* IRQs with fan-in that require an OR gate */
> +    for (unsigned i =3D 0; i < NUM_EXTI_OR_GATES; i++) {
> +        Object *orgate =3D object_new(TYPE_OR_IRQ);
> +        object_property_set_int(orgate, "num-lines",
> +            exti_or_gates_num_lines_in[i], &error_fatal);
> +        /* Should unref be used? */
> +        qdev_realize(DEVICE(orgate), NULL, &error_fatal);

There are two patterns for create-and-realize:
 (1) create with qdev_new() etc, realize with qdev_realize_and_unref()
 (2) create with object_initialize_child(), realize with qdev_realize()
(the doc comments in qdev-core.h try to explain these two patterns.)

This is an SoC container object, so it's better to use the
pattern where the sub-devices of it (like these OR gates) are
given fields in the SoC's state struct, initialized with
object_initialize_child() in the SoC init function, and then
realized here with qdev_realize().

There's an example of doing it this way in hw/arm/armsse.c.

> +
> +        qdev_connect_gpio_out(DEVICE(orgate), 0,
> +            qdev_get_gpio_in(armv7m, exti_or_gates_out[i]));
> +
> +        /* consecutive inputs for OR gates 23, 40, 63 */
> +        if (i < NUM_EXTI_SIMPLE_FANIN_IRQ) {
> +            for (unsigned j =3D 0; j < exti_or_gates_num_lines_in[i]; j+=
+) {
> +                sysbus_connect_irq(SYS_BUS_DEVICE(&s->exti),
> +                    exti_or_gates_first_line_in[i] + j,
> +                    qdev_get_gpio_in(DEVICE(orgate), j));
> +            }
> +        /* non-consecutive inputs for OR gate 1 */

This comment would be better inside the block of the 'else', I think.

> +        } else {
> +            for (unsigned j =3D 0; j < NUM_EXTI_OR_GATE1_NUM_LINES_IN; j=
++) {
> +                sysbus_connect_irq(SYS_BUS_DEVICE(&s->exti),
> +                    exti_or_gate1_lines_in[j],
> +                    qdev_get_gpio_in(DEVICE(orgate), j));
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

thanks
-- PMM

