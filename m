Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A1C4C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 18:44:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOM0O-0005ST-VW; Mon, 01 Jul 2024 14:44:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1sOM0D-0005OM-GG; Mon, 01 Jul 2024 14:43:51 -0400
Received: from pharaoh.lmichel.fr ([149.202.28.74])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1sOM0B-0001hJ-Mu; Mon, 01 Jul 2024 14:43:49 -0400
Received: from localhost (sekoia-laptop.home.lmichel.fr [192.168.61.102])
 by pharaoh.lmichel.fr (Postfix) with ESMTPSA id E6FFDC602A4;
 Mon,  1 Jul 2024 20:43:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr; s=pharaoh; 
 t=1719859424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/t08kRa44q9W+ptTF51auBXzrEFnH8rCANtuh2eLx3c=;
 b=Ag0hLRKTOxwRFUjsso0s7BZkHFomoTxYvOK8EFlH0r9gWatsJt13RWhkllphe5LIuOUQTa
 M7ZA0px/4XydmOzPSAg1dp8R/6lQwhyFmOU5B+xxkd6/mO3BJPGtQcEGQ874jNnl0Rx9VG
 i6G2bH4QGLUlICKpN5erILzUeoWGJWcPIUK/qeARZVkwbNnlZWB9uMZOiv0UyJ/qyu4hNH
 0tXf4Jzp8JQEbHAaA6WZ9dXX0du14Rs7xRhrCMQ9BJEAetMvvfNGBaxyPVOD6+g39gmtmV
 YxZH8rRFycwl016bY1De2ykFXqoFGo9wITTD2faaHE8doPbaR9iRxLv25ctXHw==
Date: Mon, 1 Jul 2024 20:43:43 +0200
From: Luc Michel <luc@lmichel.fr>
To: =?utf-8?B?SW7DqHM=?= Varhol <ines.varhol@telecom-paris.fr>
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Damien Hedde <damien.hedde@dahe.fr>
Subject: Re: [PATCH v4 1/3] hw/misc: Create STM32L4x5 SYSCFG clock
Message-ID: <ZoL43zSdOE0qQ9pv@michell-laptop.localdomain>
References: <20240622094402.244604-1-ines.varhol@telecom-paris.fr>
 <20240622094402.244604-2-ines.varhol@telecom-paris.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240622094402.244604-2-ines.varhol@telecom-paris.fr>
Received-SPF: pass client-ip=149.202.28.74; envelope-from=luc@lmichel.fr;
 helo=pharaoh.lmichel.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 11:43 Sat 22 Jun     , Inès Varhol wrote:
> This commit creates a clock in STM32L4x5 SYSCFG and wires it up to the
> corresponding clock from STM32L4x5 RCC.
> 
> Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Luc Michel <luc@lmichel.fr>

> ---
>  include/hw/misc/stm32l4x5_syscfg.h |  1 +
>  hw/arm/stm32l4x5_soc.c             |  2 ++
>  hw/misc/stm32l4x5_syscfg.c         | 19 +++++++++++++++++--
>  3 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/misc/stm32l4x5_syscfg.h b/include/hw/misc/stm32l4x5_syscfg.h
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
> @@ -236,6 +236,8 @@ static void stm32l4x5_soc_realize(DeviceState *dev_soc, Error **errp)
>  
>      /* System configuration controller */
>      busdev = SYS_BUS_DEVICE(&s->syscfg);
> +    qdev_connect_clock_in(DEVICE(&s->syscfg), "clk",
> +        qdev_get_clock_out(DEVICE(&(s->rcc)), "syscfg-out"));
>      if (!sysbus_realize(busdev, errp)) {
>          return;
>      }
> diff --git a/hw/misc/stm32l4x5_syscfg.c b/hw/misc/stm32l4x5_syscfg.c
> index a5a1ce2680..a947a9e036 100644
> --- a/hw/misc/stm32l4x5_syscfg.c
> +++ b/hw/misc/stm32l4x5_syscfg.c
> @@ -26,6 +26,9 @@
>  #include "trace.h"
>  #include "hw/irq.h"
>  #include "migration/vmstate.h"
> +#include "hw/clock.h"
> +#include "hw/qdev-clock.h"
> +#include "qapi/error.h"
>  #include "hw/misc/stm32l4x5_syscfg.h"
>  #include "hw/gpio/stm32l4x5_gpio.h"
>  
> @@ -225,12 +228,22 @@ static void stm32l4x5_syscfg_init(Object *obj)
>      qdev_init_gpio_in(DEVICE(obj), stm32l4x5_syscfg_set_irq,
>                        GPIO_NUM_PINS * NUM_GPIOS);
>      qdev_init_gpio_out(DEVICE(obj), s->gpio_out, GPIO_NUM_PINS);
> +    s->clk = qdev_init_clock_in(DEVICE(s), "clk", NULL, s, 0);
> +}
> +
> +static void stm32l4x5_syscfg_realize(DeviceState *dev, Error **errp)
> +{
> +    Stm32l4x5SyscfgState *s = STM32L4X5_SYSCFG(dev);
> +    if (!clock_has_source(s->clk)) {
> +        error_setg(errp, "SYSCFG: clk input must be connected");
> +        return;
> +    }
>  }
>  
>  static const VMStateDescription vmstate_stm32l4x5_syscfg = {
>      .name = TYPE_STM32L4X5_SYSCFG,
> -    .version_id = 1,
> -    .minimum_version_id = 1,
> +    .version_id = 2,
> +    .minimum_version_id = 2,
>      .fields = (VMStateField[]) {
>          VMSTATE_UINT32(memrmp, Stm32l4x5SyscfgState),
>          VMSTATE_UINT32(cfgr1, Stm32l4x5SyscfgState),
> @@ -241,6 +254,7 @@ static const VMStateDescription vmstate_stm32l4x5_syscfg = {
>          VMSTATE_UINT32(swpr, Stm32l4x5SyscfgState),
>          VMSTATE_UINT32(skr, Stm32l4x5SyscfgState),
>          VMSTATE_UINT32(swpr2, Stm32l4x5SyscfgState),
> +        VMSTATE_CLOCK(clk, Stm32l4x5SyscfgState),
>          VMSTATE_END_OF_LIST()
>      }
>  };
> @@ -251,6 +265,7 @@ static void stm32l4x5_syscfg_class_init(ObjectClass *klass, void *data)
>      ResettableClass *rc = RESETTABLE_CLASS(klass);
>  
>      dc->vmsd = &vmstate_stm32l4x5_syscfg;
> +    dc->realize = stm32l4x5_syscfg_realize;
>      rc->phases.hold = stm32l4x5_syscfg_hold_reset;
>  }
>  
> -- 
> 2.43.2
> 

-- 

