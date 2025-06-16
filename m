Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EEEEC71135
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 09:49:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR6SE-0007O4-K1; Mon, 16 Jun 2025 05:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uR6Rr-0007Lq-Gs
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 05:48:29 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uR6Rm-0001k7-7w
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 05:48:15 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-70e78e04e48so33494317b3.1
 for <qemu-devel@nongnu.org>; Mon, 16 Jun 2025 02:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750067289; x=1750672089; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bwBGyav45mYFg5Qk/FJZrwGz24J0qSZfM7lP6yYswZM=;
 b=ojy3wjykMu7R9uQN7GCE7SQ0HC84yYqdF3fviKaAwKKnsZ7nzvbVbCDxWurOMMc3Hh
 CMNvJYvism7rhShH78DnJnkf1YnEBFnrfCBEmQL0U7wNND4oDzdKzYMQINFqAksF5Ttg
 gp2cjnGKWHV7zA7FYeZMCHBKH29DtaEMSnwl1EENj13UYCgTsLwxhnZW06fSjrEfa4Vl
 HtRuU57XReaK7PAN9HjhmjKCBTwzX9PC2GOJ1mWHsyl72cJ//JsLyMU3MPK3yAZDrCR9
 OoIskS9dFRVi1vCSKZUdKiT187AK1eiM+a/V8OL1R9uKjdX6PK6ULNFsEUa4reF2iNJz
 VwYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750067289; x=1750672089;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bwBGyav45mYFg5Qk/FJZrwGz24J0qSZfM7lP6yYswZM=;
 b=GT118WoMmLuFqegXzi19MGJ/jwJIKiiLBfxkgOphzxGlrlJ9RVw7KQD8ZO+u46GvJw
 /8sJYLMnT/NL1pXyDPNEzSL/OLbqy+emPYQgfZloyRtUe2EUVKkAlRboyI1Yp/2G3iiB
 NO1kaucItjvCI7NWXmfMSRhU5uH1gAgzviIaInaB+9U/HEFF9Rc24N8LayuDFMHSkaTp
 Xr2XLRoN92ZKumsn0Uyr0JqV0CTHUpIcrE8XwrIM+b69xYR/evgn07y1Yo/oq+fI08l6
 ic//xzXaX75Z9vCzRSTRDpiheZn2zb2vR91+hOPYK1uiYHls+jsLTrlpNkArz2X62zpA
 iLLQ==
X-Gm-Message-State: AOJu0YyaiGM5UdxxkaO9PPZubE8CVdy6fFV0Hw4A0wJK5j3IasiJF7MF
 P/U/qtFwb+3L9Ulp50flmZCmdBitGSTYb1m8dAAlljefEGfmblaNjEF3VfF7UrvjCt1dhY2C9O9
 0jaeKtb4MfiOWkmALYO0Byufjga8LiMkRiKjfxswibw==
X-Gm-Gg: ASbGncvNQe2XSyqOshZD/h8fAje6NYxleUsQvNEkWn71RVZvSQM3ku+uMLOfqmwFvGC
 jlvURZEk69gaRxcda8LjQ9byQFljgZzGiJZF887tmXyF9MJiBRvj4FaXL17lXmx/QBdvgCr8R85
 3UZMlQY5gyoQwl10SDOhr23PW9CXx1mPC1rWZtkfbvnM6Gn1W7DMifl9k=
X-Google-Smtp-Source: AGHT+IFXUvGN29G4Iwdbxqw2b6uTN7N7lN4n+hCPo2VlObErLlLYmA03U/AP28+URA/MKS/Z/TKi2Rgc04VB0yPnplw=
X-Received: by 2002:a05:690c:6:b0:70f:84c8:3134 with SMTP id
 00721157ae682-71175384faamr111035257b3.3.1750067288599; Mon, 16 Jun 2025
 02:48:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250510042043.2056265-1-jcksn@duck.com>
 <ACFFEE84-30F3-4A74-93C0-5E18B0412D25.1@smtp-inbound1.duck.com>
In-Reply-To: <ACFFEE84-30F3-4A74-93C0-5E18B0412D25.1@smtp-inbound1.duck.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Jun 2025 10:47:57 +0100
X-Gm-Features: AX0GCFvPi8tISK6a1ZNjQHJn_iuxgIkFp9m713eUBXOMh9uYxF3kjTjFaVg53aE
Message-ID: <CAFEAcA8+FqdRMcn2MskEjtmrvz1qCQuAzbLZFTC6zuhWRJ=oCw@mail.gmail.com>
Subject: Re: [PATCH 4/6] MAX78000 GCR implementation
To: jcksn@duck.com
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Sat, 10 May 2025 at 07:57, <jcksn@duck.com> wrote:
>
> This patch implements the Global Control Register for the MAX78000 SOC
>
> Signed-off-by: Jackson Donaldson <jcksn@duck.com>
> ---
>  hw/arm/Kconfig                 |   1 +
>  hw/arm/max78000_soc.c          |   9 +-
>  hw/misc/Kconfig                |   3 +
>  hw/misc/max78000_gcr.c         | 285 +++++++++++++++++++++++++++++++++
>  hw/misc/meson.build            |   1 +
>  include/hw/arm/max78000_soc.h  |   2 +
>  include/hw/misc/max78000_gcr.h | 122 ++++++++++++++
>  7 files changed, 422 insertions(+), 1 deletion(-)
>  create mode 100644 hw/misc/max78000_gcr.c
>  create mode 100644 include/hw/misc/max78000_gcr.h
>
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 59450dc3cb..211b201629 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -369,6 +369,7 @@ config MAX78000_SOC
>      select ARM_V7M
>      select MAX78000_ICC
>      select MAX78000_UART
> +    select MAX78000_GCR
>
>  config RASPI
>      bool
> diff --git a/hw/arm/max78000_soc.c b/hw/arm/max78000_soc.c
> index 6334d8b49b..7a012c6ef7 100644
> --- a/hw/arm/max78000_soc.c
> +++ b/hw/arm/max78000_soc.c
> @@ -29,6 +29,8 @@ static void max78000_soc_initfn(Object *obj)
>
>      object_initialize_child(obj, "armv7m", &s->armv7m, TYPE_ARMV7M);
>
> +    object_initialize_child(obj, "gcr", &s->gcr, TYPE_MAX78000_GCR);
> +
>      for (i = 0; i < MAX78000_NUM_ICC; i++) {
>          object_initialize_child(obj, "icc[*]", &s->icc[i], TYPE_MAX78000_ICC);
>      }
> @@ -104,6 +106,10 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
>          return;
>      }
>
> +    dev = DEVICE(&s->gcr);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), errp);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0x40000000);
> +
>      for (i = 0; i < MAX78000_NUM_ICC; i++) {
>          dev = DEVICE(&(s->icc[i]));
>          sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), errp);
> @@ -116,6 +122,8 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
>          if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), errp)) {
>              return;
>          }
> +        dev->id = g_strdup_printf("uart%d", i);
> +
>          busdev = SYS_BUS_DEVICE(dev);
>          sysbus_mmio_map(busdev, 0, max78000_uart_addr[i]);
>          sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m,
> @@ -123,7 +131,6 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
>      }
>
>
> -    create_unimplemented_device("globalControl",    0x40000000, 0x400);
>      create_unimplemented_device("systemInterface",  0x40000400, 0x400);
>      create_unimplemented_device("functionControl",  0x40000800, 0x3400);
>      create_unimplemented_device("watchdogTimer0",   0x40003000, 0x400);
> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index 781bcf74cc..fde2266b8f 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -47,6 +47,9 @@ config A9SCU
>  config ARM11SCU
>      bool
>
> +config MAX78000_GCR
> +    bool
> +
>  config MAX78000_ICC
>      bool
>
> diff --git a/hw/misc/max78000_gcr.c b/hw/misc/max78000_gcr.c
> new file mode 100644
> index 0000000000..657b7fc490
> --- /dev/null
> +++ b/hw/misc/max78000_gcr.c
> @@ -0,0 +1,285 @@
> +/*
> + * MAX78000 Global Control Registers
> + *
> + * Copyright (c) 2025 Jackson Donaldson <jcksn@duck.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "trace.h"
> +#include "hw/irq.h"
> +#include "system/runstate.h"
> +#include "migration/vmstate.h"
> +#include "hw/misc/max78000_gcr.h"
> +
> +static void max78000_gcr_reset(DeviceState *dev)
> +{
> +    Max78000GcrState *s = MAX78000_GCR(dev);
> +    s->sysctrl = 0x21002;
> +    s->rst0 = 0;
> +    /* All clocks are always ready */
> +    s->clkctrl = 0x3e140008;
> +    s->pm = 0x3f000;
> +    s->pclkdiv = 0;
> +    s->pclkdis0 = 0xffffffff;
> +    s->memctrl = 0x5;
> +    s->memz = 0;
> +    s->sysst = 0;
> +    s->rst1 = 0;
> +    s->pckdis1 = 0xffffffff;
> +    s->eventen = 0;
> +    s->revision = 0xa1;
> +    s->sysie = 0;
> +    s->eccerr = 0;
> +    s->ecced = 0;
> +    s->eccie = 0;
> +    s->eccaddr = 0;
> +}
> +
> +static uint64_t max78000_gcr_read(void *opaque, hwaddr addr,
> +                                     unsigned int size)
> +{
> +    Max78000GcrState *s = opaque;
> +
> +    switch (addr) {
> +        case SYSCTRL:{
> +            return s->sysctrl;
> +        }
> +        case RST0:{
> +            return s->rst0;
> +        }
> +        case CLKCTRL:{
> +            return s->clkctrl;
> +        }
> +        case PM:{
> +            return s->pm;
> +        }
> +        case PCLKDIV:{
> +            return s->pclkdiv;
> +        }
> +        case PCLKDIS0:{
> +            return s->pclkdis0;
> +        }
> +        case MEMCTRL:{
> +            return s->memctrl;
> +        }
> +        case MEMZ:{
> +            return s->memz;
> +        }
> +        case SYSST:{
> +            return s->sysst;
> +        }
> +        case RST1:{
> +            return s->rst1;
> +        }
> +        case PCKDIS1:{
> +            return s->pckdis1;
> +        }
> +        case EVENTEN:{
> +            return s->eventen;
> +        }
> +        case REVISION:{
> +            return s->revision;
> +        }
> +        case SYSIE:{
> +            return s->sysie;
> +        }
> +        case ECCERR:{
> +            return s->eccerr;
> +        }
> +        case ECCED:{
> +            return s->ecced;
> +        }
> +        case ECCIE:{
> +            return s->eccie;
> +        }
> +        case ECCADDR:{
> +            return s->eccaddr;
> +        }
> +        default:{
> +            return 0;
> +        }
> +    }
> +}
> +
> +static void max78000_gcr_reset_device(const char *device_name)
> +{
> +    DeviceState *dev = qdev_find_recursive(sysbus_get_default(), device_name);
> +    if (dev) {
> +        device_cold_reset(dev);
> +    } else {
> +        qemu_log_mask(LOG_GUEST_ERROR, "no device %s for reset\n", device_name);
> +    }
> +}

This device shouldn't be finding the devices it needs to reset
by looking them up by name. I don't think we really have any
pre-existing examples of reset controllers in the tree, so
here's the off-the-top-of-my-head suggestion:
 * have this device define link properties with DEFINE_PROP_LINK
   for the devices it needs to reset
 * have the SoC set those link properties when it creates this
   device
 * then in the code that does the reset you have a direct pointer
   to the DeviceState* that you want to reset

> +static void max78000_gcr_write(void *opaque, hwaddr addr,
> +                       uint64_t val64, unsigned int size)
> +{
> +    Max78000GcrState *s = opaque;
> +    uint32_t val = val64;
> +    uint8_t zero[0xc000] = {0};
> +    switch (addr) {
> +        case SYSCTRL:{
> +            /* Checksum calculations always pass immediately */
> +            s->sysctrl = (val & 0x30000) | 0x1002;
> +            break;
> +        }
> +        case RST0:{
> +            if (val & SYSTEM_RESET) {
> +                qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> +            }
> +            if (val & PERIPHERAL_RESET) {
> +                /*
> +                 * Peripheral reset resets all peripherals. The CPU
> +                 * retains its state. The GPIO, watchdog timers, AoD,
> +                 * RAM retention, and general control registers (GCR),
> +                 * including the clock configuration, are unaffected.
> +                 */
> +                val = UART2_RESET | UART1_RESET | UART0_RESET |
> +                      ADC_RESET | CNN_RESET | TRNG_RESET |
> +                      RTC_RESET | I2C0_RESET | SPI1_RESET |
> +                      TMR3_RESET | TMR2_RESET | TMR1_RESET |
> +                      TMR0_RESET | WDT0_RESET | DMA_RESET;
> +            }
> +            if (val & SOFT_RESET) {
> +                /* Soft reset also resets GPIO */
> +                val = UART2_RESET | UART1_RESET | UART0_RESET |
> +                      ADC_RESET | CNN_RESET | TRNG_RESET |
> +                      RTC_RESET | I2C0_RESET | SPI1_RESET |
> +                      TMR3_RESET | TMR2_RESET | TMR1_RESET |
> +                      TMR0_RESET | GPIO1_RESET | GPIO0_RESET |
> +                      DMA_RESET;
> +            }
> +            if (val & UART2_RESET) {
> +                max78000_gcr_reset_device("uart2");
> +            }
> +            if (val & UART1_RESET) {
> +                max78000_gcr_reset_device("uart1");
> +            }
> +            if (val & UART0_RESET) {
> +                max78000_gcr_reset_device("uart0");
> +            }
> +            /* TODO: As other devices are implemented, add them here */
> +            break;
> +        }
> +        case CLKCTRL:{
> +            s->clkctrl = val | SYSCLK_RDY;
> +            break;
> +        }
> +        case PM:{
> +            s->pm = val;
> +            break;
> +        }
> +        case PCLKDIV:{
> +            s->pclkdiv = val;
> +            break;
> +        }
> +        case PCLKDIS0:{
> +            s->pclkdis0 = val;
> +            break;
> +        }
> +        case MEMCTRL:{
> +            s->memctrl = val;
> +            break;
> +        }
> +        case MEMZ:{
> +            if (val & ram0) {
> +                cpu_physical_memory_write(SYSRAM0_START, zero, 0x8000);
> +            }
> +            if (val & ram1) {
> +                cpu_physical_memory_write(SYSRAM1_START, zero, 0x8000);
> +            }
> +            if (val & ram2) {
> +                cpu_physical_memory_write(SYSRAM2_START, zero, 0xC000);
> +            }
> +            if (val & ram3) {
> +                cpu_physical_memory_write(SYSRAM3_START, zero, 0x4000);
> +            }

New devices shouldn't use cpu_physical_memory_write(), please.
Take a link property to a MemoryRegion, which you then convert
into an AddressSpace you can pass to address_space_write().

> +            break;
> +        }

thanks
-- PMM

