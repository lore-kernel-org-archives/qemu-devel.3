Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 273F1C021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 13:23:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmYQ9-0001dr-JW; Mon, 24 Feb 2025 08:22:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmYQ5-0001dF-4W
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 08:22:49 -0500
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmYQ2-0005Yj-G2
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 08:22:47 -0500
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-6f754678c29so38102247b3.0
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 05:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740403363; x=1741008163; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mL5wk++DSiVxVe0X4baydx3zkyf30Ey6UdpzjUwsx6c=;
 b=aDBVu3P0InHLakPJplal2s+yKoSWlplkucHMBgLtzerNlwIHiH1pLkJgKxzZiHK476
 CQYXS7PF23n3z3/yN+FiZ51M8bxSfiGQ0L4VWELxTay4hH6f0j34dIyb/h1lOTpcs/r4
 ZEUIhGkDElL1pIXb8ozJswkwUNN0jCADuXU+RXwc9FiFYICB/39FPDVcS/WsU3npTQBc
 olk6hvllbOcS+GHamF0lEZukFLcXS7fg53zPz7tFHLwpFL4Hgu69tszq78umuFvisk/p
 4WUAKaFrsKcvptURmKhmex0+lDMH/8vmNEW+4cJPx40w0Sc8QQCkwdcwwN97lujWIFtF
 EG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740403363; x=1741008163;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mL5wk++DSiVxVe0X4baydx3zkyf30Ey6UdpzjUwsx6c=;
 b=aXUjQw7z6pc979TXvHdCFtRwGdIiQpij9b9z8mpSXJg4nL1G2Hq/awLrTKK56BdvDd
 71TAx+CbZuGMv/rFofaI4HI31kMPvAMB6x39812tcNUGGRzgmfP466odTz4H3Lyxp4Fe
 QGGn2q4mkT840RE3jcoIIbOIr3EF8M2rzRirkT3N7hxqFIWBkG9pF0UZ9lXToL+d7DqX
 rYusiRPYYIN2ounQjbVRBdm/eJjrrsfzaknrJa0BC8iNsPoczdZPOUoZSzim+33egQNg
 8AyswiUOvfZwxlf2Qr3EjgAUg5jRqgDUNcGoSqeZV+IW9Cfjv3Bkdo1n4bqlDVONChnx
 YhiQ==
X-Gm-Message-State: AOJu0YxqSlzkqOaLVW83GcysMsDeHNHt9oi9Cy6910/0Cko2tcapt9Vy
 5BrVZsS5ZtFJoo+ZfIDNMiL8dTBo7jAVd5tRyDkLsv/xpgqrIADEOuUqR1jxGYOQfiWL6gItpj6
 LPo9BlAncALOtgAp/UsSd4U9COmpySC+qvuVL11Eq5vC42PP/
X-Gm-Gg: ASbGncuXKBw9jw89pYxWCLZs4sPfCEJJYAWKNzBr27MxRSA8NusohmtgefmQV0SbezM
 VhATzGONAMx1SeDMcpQ7xY9SiBMpyEO7aYaRDJevZNRohy/z4kWPQHuqx2MxN7UlX8lFCiFSobU
 AY0xL5PXuB
X-Google-Smtp-Source: AGHT+IE8DzPAeY9wH6p2LWIu/pZZjXzLfaAhDpCilmQ4OQSUpPsWOUODnP01TYjbrCg66FP5/ZAgkjFzImwxq7bh5TM=
X-Received: by 2002:a05:690c:6405:b0:6fb:2980:b0bd with SMTP id
 00721157ae682-6fbcc241d85mr124694927b3.11.1740403363398; Mon, 24 Feb 2025
 05:22:43 -0800 (PST)
MIME-Version: 1.0
References: <3cca4eb3-09d1-4467-81fd-27a5bfe19a3e@csclub.uwaterloo.ca>
In-Reply-To: <3cca4eb3-09d1-4467-81fd-27a5bfe19a3e@csclub.uwaterloo.ca>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Feb 2025 13:22:32 +0000
X-Gm-Features: AWEUYZmN9CYG-k9N3IuMpCFHV6ZTK_bjGmqnZIcDy9nDjpkfa9fAru_dKSdLK_I
Message-ID: <CAFEAcA9kED+fB1repp2+r-zMfZ_5ZeAkZq2ChyxjSUo1j5gAFQ@mail.gmail.com>
Subject: Re: [PATCH] bcm2838: Add GIC-400 timer interupt connections
To: Sourojeet Adhikari <s23adhik@csclub.uwaterloo.ca>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Sun, 16 Feb 2025 at 03:54, Sourojeet Adhikari
<s23adhik@csclub.uwaterloo.ca> wrote:
>
> Hello everyone,
>
> This patch adds support for the system timer interrupts
> in QEMU's BCM2838 model. It defines a new constant
> called GIC400_TIMER_INT, and connects 4 timer interupts
> to the GIC-400.
> Previously timer interupts were not being routed to the
> interupt controller, causing scheduling, and some other
> stuff to have issues (me and a few friends bumped into
> this, and that's why this was written lol).
>
> Signed-off-by: Sourojeet Adhikari <s23adhik@csclub.uwaterloo.ca>

Hi; thanks for sending this patch, but I'm afraid this doesn't
look like a correct fix for the bug you've run into.

> ---
>   hw/arm/bcm2838.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/hw/arm/bcm2838.c b/hw/arm/bcm2838.c
> index ddb7c5f..0a4179f 100644
> --- a/hw/arm/bcm2838.c
> +++ b/hw/arm/bcm2838.c
> @@ -21,6 +21,8 @@
>   #define GIC400_TIMER_S_EL1_IRQ      13
>   #define GIC400_TIMER_NS_EL1_IRQ     14
>   #define GIC400_LEGACY_IRQ           15
> +#define GIC400_TIMER_INT            (96 - 32)
> +
>
>   /* Number of external interrupt lines to configure the GIC with */
>   #define GIC_NUM_IRQS                192
> @@ -176,6 +178,15 @@ static void bcm2838_realize(DeviceState *dev, Error
> **errp)
>                       qdev_get_gpio_in(gicdev, PPI(n, VIRTUAL_PMU_IRQ)));
>       }
>
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&ps_base->systmr), 0,
> +        qdev_get_gpio_in(DEVICE(&s->gic), GIC400_TIMER_INT +
> INTERRUPT_TIMER0));

The values passed to qdev_get_gpio_in(DEVICE(&s->gic), ...)
should be GIC_SPI_INTERRUPT_* values, which we define in
include/hw/arm/bcm2838_peripherals.h. You can add new ones for
the four timers.

> +    sysbus_connect_irq(SYS_BUS_DEVICE(&ps_base->systmr), 1,
> +        qdev_get_gpio_in(DEVICE(&s->gic), GIC400_TIMER_INT +
> INTERRUPT_TIMER1));
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&ps_base->systmr), 2,
> +        qdev_get_gpio_in(DEVICE(&s->gic), GIC400_TIMER_INT +
> INTERRUPT_TIMER2));
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&ps_base->systmr), 3,
> +        qdev_get_gpio_in(DEVICE(&s->gic), GIC400_TIMER_INT +
> INTERRUPT_TIMER3));

The systmr INTERRUPT_TIMER0..3 sysbus IRQ outputs are already
being wired up in the function bcm_soc_peripherals_common_realize()
in hw/arm/bcm2835_peripherals.c (to the TYPE_BCM2835_IC
interrupt controller), and it isn't valid to wire one input
directly to multiple outputs.

In fact it looks like we are currently getting this wrong for
all of the interrupts that need to be wired to both the
"legacy interrupt controller" and the GIC. I think at the moment
what happens is that the wiring to the GIC will happen last
and this overrides the earlier wiring to the legacy interrupt
controller, so code using the latter won't work correctly.

thanks
-- PMM

