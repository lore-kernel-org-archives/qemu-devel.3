Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD4EBCD1283
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 15:58:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rps7R-0004aU-Qd; Thu, 28 Mar 2024 11:56:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rps6v-0003vD-6y
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:56:15 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rps6t-0002M6-Bp
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:56:12 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-56c4ca65dc6so1405222a12.1
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 08:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711641370; x=1712246170; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PiRqlA5GcAD1q2/Pos+ij4Tpv0vslRdxK+QP0+B9dzE=;
 b=nlE/0mal19eabfskNB5Jj8fc9P7LVtR0vCjK7N4q84Q4/aIjyZRMIku9Ard1wbqsVK
 rFoZNdp7/PolnwuCoMzQBdbrZrFyQuByES5FY+jtNY3BwXC0oIoTvxwNm/Hn9Zx7D5iQ
 2McaUop0zioSVYf9DLLPjfNQ5+z5lvGNgv0vo4Esm64jIM6cO1FAx8gwvHdIbbxyhNoq
 2tFxalLns/noLV7RMrvBcc7t0mI0yHwIbTvbnJvm/4r3yT62SIW7Iw1+lpkrPorkCFnw
 OuOnJu4Q2YX+5w78lW8OA42/OxKrX+EXpUY7BZwtRBaA6owce4kB94Gr4RNh7ryww/Gf
 HlCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711641370; x=1712246170;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PiRqlA5GcAD1q2/Pos+ij4Tpv0vslRdxK+QP0+B9dzE=;
 b=gqOJ8zslGiR3szoE6PaADZNMTvwueGDGtGbmKuaVkDBzyke6kXApmSRYReWJNFpB2c
 2zGHOgosmiqpxejT4dAUzLxf/Y6N60ILgT87OHQxyWw411y28gIyzsKBAC/277fn1OMs
 5GSuw+ySUQg6vdyU7S/sLWmvi1ayS2hGBV+CvkHYd2hbbHyG7p6nWf5GW5cUMwQLnBK5
 QAvTTj+r3Aqy6jZLklkSGZ/87QaG7qVX6yafCDIRbpwYZDCrCpEvLohfquUXspQP//bI
 M0w0j14x4s5IU07qlWRke36uYgVXpDLPG6/iRNBljzLESOytOIb3c2yn3jpBzh1Jt6zg
 4Fwg==
X-Gm-Message-State: AOJu0YxDLgcqyoFxq5ewYs6ILx5YldrTAB8zN/GSma3hVUFxRhHnVVRT
 D53kbT755CIWgrvLJSso8O7FfqYS2t3EXPXyE+SXy98g/v8IcfRhcVvcQWC4nNi0z157vLK9kcD
 9SMVx8Dksr+Quk1I2+YXiUZElkZfddQtkOpjmEw==
X-Google-Smtp-Source: AGHT+IECfFH6/i9aDaqo9Y4pIBJD6rIPgpg4RBubEUZiVQM9qxCKpEkOMr2fTkjHBK7Lw289gvDaNpWFO7vLm2Fo8is=
X-Received: by 2002:a50:870b:0:b0:56c:36e3:b74d with SMTP id
 i11-20020a50870b000000b0056c36e3b74dmr2254450edb.25.1711641370017; Thu, 28
 Mar 2024 08:56:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240324165545.201908-1-arnaud.minier@telecom-paris.fr>
 <20240324165545.201908-3-arnaud.minier@telecom-paris.fr>
In-Reply-To: <20240324165545.201908-3-arnaud.minier@telecom-paris.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Mar 2024 15:55:59 +0000
Message-ID: <CAFEAcA9SCD3EZFXN7O2+X9sSFXRJ7UiRSwwQHir8a8MneT75Qg@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] hw/char: Implement STM32L4x5 USART skeleton
To: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>, 
 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>
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

On Sun, 24 Mar 2024 at 16:56, Arnaud Minier
<arnaud.minier@telecom-paris.fr> wrote:
>
> Add the basic infrastructure (register read/write, type...)
> to implement the STM32L4x5 USART.
>
> Also create different types for the USART, UART and LPUART
> of the STM32L4x5 to deduplicate code and enable the
> implementation of different behaviors depending on the type.
>
> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
> ---
>  MAINTAINERS                       |   1 +
>  hw/char/Kconfig                   |   3 +
>  hw/char/meson.build               |   1 +
>  hw/char/stm32l4x5_usart.c         | 395 ++++++++++++++++++++++++++++++
>  hw/char/trace-events              |   4 +
>  include/hw/char/stm32l4x5_usart.h |  66 +++++
>  6 files changed, 470 insertions(+)
>  create mode 100644 hw/char/stm32l4x5_usart.c
>  create mode 100644 include/hw/char/stm32l4x5_usart.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 409d7db4d4..deba4a54ce 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1128,6 +1128,7 @@ M: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
>  L: qemu-arm@nongnu.org
>  S: Maintained
>  F: hw/arm/stm32l4x5_soc.c
> +F: hw/char/stm32l4x5_usart.c
>  F: hw/misc/stm32l4x5_exti.c
>  F: hw/misc/stm32l4x5_syscfg.c
>  F: hw/misc/stm32l4x5_rcc.c
> diff --git a/hw/char/Kconfig b/hw/char/Kconfig
> index 6b6cf2fc1d..4fd74ea878 100644
> --- a/hw/char/Kconfig
> +++ b/hw/char/Kconfig
> @@ -41,6 +41,9 @@ config VIRTIO_SERIAL
>  config STM32F2XX_USART
>      bool
>
> +config STM32L4X5_USART
> +    bool
> +
>  config CMSDK_APB_UART
>      bool
>
> diff --git a/hw/char/meson.build b/hw/char/meson.build
> index 006d20f1e2..e5b13b6958 100644
> --- a/hw/char/meson.build
> +++ b/hw/char/meson.build
> @@ -31,6 +31,7 @@ system_ss.add(when: 'CONFIG_RENESAS_SCI', if_true: file=
s('renesas_sci.c'))
>  system_ss.add(when: 'CONFIG_SIFIVE_UART', if_true: files('sifive_uart.c'=
))
>  system_ss.add(when: 'CONFIG_SH_SCI', if_true: files('sh_serial.c'))
>  system_ss.add(when: 'CONFIG_STM32F2XX_USART', if_true: files('stm32f2xx_=
usart.c'))
> +system_ss.add(when: 'CONFIG_STM32L4X5_USART', if_true: files('stm32l4x5_=
usart.c'))
>  system_ss.add(when: 'CONFIG_MCHP_PFSOC_MMUART', if_true: files('mchp_pfs=
oc_mmuart.c'))
>  system_ss.add(when: 'CONFIG_HTIF', if_true: files('riscv_htif.c'))
>  system_ss.add(when: 'CONFIG_GOLDFISH_TTY', if_true: files('goldfish_tty.=
c'))
> diff --git a/hw/char/stm32l4x5_usart.c b/hw/char/stm32l4x5_usart.c
> new file mode 100644
> index 0000000000..46e69bb096
> --- /dev/null
> +++ b/hw/char/stm32l4x5_usart.c
> @@ -0,0 +1,395 @@
> +/*
> + * STM32L4X5 USART (Universal Synchronous Asynchronous Receiver Transmit=
ter)
> + *
> + * Copyright (c) 2023 Arnaud Minier <arnaud.minier@telecom-paris.fr>
> + * Copyright (c) 2023 In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + *
> + * The STM32L4X5 USART is heavily inspired by the stm32f2xx_usart
> + * by Alistair Francis.
> + * The reference used is the STMicroElectronics RM0351 Reference manual
> + * for STM32L4x5 and STM32L4x6 advanced Arm =C2=AE -based 32-bit MCUs.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "qapi/error.h"
> +#include "chardev/char-fe.h"
> +#include "chardev/char-serial.h"
> +#include "migration/vmstate.h"
> +#include "hw/char/stm32l4x5_usart.h"
> +#include "hw/clock.h"
> +#include "hw/irq.h"
> +#include "hw/qdev-clock.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
> +#include "hw/registerfields.h"
> +#include "trace.h"
> +
> +
> +REG32(CR1, 0x00)
> +    FIELD(CR1, M1, 28, 1)    /* Word length (part 2, see M0)*/

Missing space before "*/"

> +static const TypeInfo stm32l4x5_usart_types[] =3D {
> +    {
> +        .name           =3D TYPE_STM32L4X5_USART_BASE,
> +        .parent         =3D TYPE_SYS_BUS_DEVICE,
> +        .instance_size  =3D sizeof(Stm32l4x5UsartBaseState),
> +        .instance_init  =3D stm32l4x5_usart_base_init,
> +        .class_init     =3D stm32l4x5_usart_base_class_init,

This should also have
    .abstract =3D true,

so you can't create an instance of this class, only of
the specific subclasses.

> +    }, {
> +        .name           =3D TYPE_STM32L4X5_USART,
> +        .parent         =3D TYPE_STM32L4X5_USART_BASE,
> +        .class_init     =3D stm32l4x5_usart_class_init,
> +    }, {
> +        .name           =3D TYPE_STM32L4X5_UART,
> +        .parent         =3D TYPE_STM32L4X5_USART_BASE,
> +        .class_init     =3D stm32l4x5_uart_class_init,
> +    }, {
> +        .name           =3D TYPE_STM32L4X5_LPUART,
> +        .parent         =3D TYPE_STM32L4X5_USART_BASE,
> +        .class_init     =3D stm32l4x5_lpuart_class_init,
> +    }
> +};
> +

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

