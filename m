Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17978C71148
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 16:04:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ6su-0005m5-7P; Fri, 13 Jun 2025 12:04:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uQ6so-0005iu-8n
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 12:03:59 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uQ6sm-0000Yr-3b
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 12:03:57 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-70e302191a3so19171437b3.2
 for <qemu-devel@nongnu.org>; Fri, 13 Jun 2025 09:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749830634; x=1750435434; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dtrjAAF2JsKWfSl1rUQw6akguXOFuEAjIn4T5vBWltw=;
 b=O10bt+TsMEdqFrSRoz7iYf9O9rnJGKoLymCQz0U1sMxwvH4pUZORB484PU9fJ8f8PU
 2cNiYBeBGlk0A4bcZjYJzeFon7Lb1BgPycogQ3TaO3vCMnbMS9bZuP2N1S5GKJlQL74I
 sNPIqfC2V/CpsX/iY2PYVfxCeNljNBzdZ/AFwZO3wA3AyfH2carDz3kyAdY5aaC4dcaT
 Yu8V51b3dRaEjPbJndy6HBEbCCix92+vh8cFnLxJ+SoyX+/TQjINPtNhmqIjUzlBa4b8
 7qNh43gpgz4BeG3OPl7Hl8kxeVocM3H2T7RhC4JuFlOLLOwcoWNgyH2jjt8+kNv4s3MD
 jlkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749830634; x=1750435434;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dtrjAAF2JsKWfSl1rUQw6akguXOFuEAjIn4T5vBWltw=;
 b=P9f9HGlkHMnN9vSvJb172k1c7fTsnfTRz9ZlMTJtjHeFArWtBQzC+giGXsQxKv7S5g
 fLCDJ1OQxz+1SyvmOtJ8t0rD3/9PHILQ2XwEEG7QUtKRATWDlKFqaWNMttcBmhvtmSRl
 fiitMAsvexrcadvOp16rlHN9QPptUsYw3RxdV9hTPuazuMR4EyjlSfERRcxXcI5VN8A8
 M104bHG7ujEfRNymn3Wl8fRoB1AuhA55G4rDE83nsSw5tMtCviOplHEPgnJrmvui4pKY
 pJTt7eJwS6+FyjujcwUfQztKaQD4zuDKh+9j83VBJiW10gwPBpuK89PjclikV1GpcY3e
 Tvng==
X-Gm-Message-State: AOJu0Yx1t15ZkkDhSpIT50oM3248Ld2hyBvsr9YmFvDc6kskXvVNXKda
 WjcUUh7Fvgp4EYaySwsyyc6HMxDj2R5DUpx3OFaEPPDDEpHuu7124z9MleDMFePGiSRPEj1BTs/
 SgJO0X1JWIu84YP7iH5NPUL4avjmygKnqcUGphuj0Iw==
X-Gm-Gg: ASbGnctIo8fNileyOtdG4CZRjFmA5RyODiFWuxLkHR0/YJuZe3s7Bu0c1EH68XFfot6
 648zddqZScEXO0F8HzYoTYXEfa3VZ9QnGdMf/JnPDWHkD6FXGJ9prciC+8DpNsI6pnSc6VOe7LO
 wuQrA4n5rxm/rJYcv3qd/mvMJUapRNbhhrHydnTg8hVLbf
X-Google-Smtp-Source: AGHT+IEbvQ2t0rlhNGcYtZxRvjX+41IJyO/oGENArEjD2nxlz/CWCprp9uBNYzRcvBHCj++PhIbc0XFgF0LZ5hlI8sI=
X-Received: by 2002:a05:690c:19:b0:70e:73ce:80de with SMTP id
 00721157ae682-7116380b361mr53822767b3.25.1749830634369; Fri, 13 Jun 2025
 09:03:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250510042043.2056265-1-jcksn@duck.com>
 <B389ED9F-EC29-47F0-90DD-93E89826912D.1@smtp-inbound1.duck.com>
In-Reply-To: <B389ED9F-EC29-47F0-90DD-93E89826912D.1@smtp-inbound1.duck.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Jun 2025 17:03:41 +0100
X-Gm-Features: AX0GCFsWPTjByzwpmUYTYbYvppDbBwEi2-6gy_NF0bdGSyy09DakhB9y9UyMnRc
Message-ID: <CAFEAcA9sYQ0r_e4y0vaH0FmfNm5ezDPixT60uRSx5C2cW2KB=g@mail.gmail.com>
Subject: Re: [PATCH 3/6] MAX78000 UART implementation
To: jcksn@duck.com
Cc: qemu-devel@nongnu.org, alistair@alistair.me
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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
> This patch implements UART support for the MAX78000 SOC
>
> Signed-off-by: Jackson Donaldson <jcksn@duck.com>
> ---
>  hw/arm/Kconfig                  |   1 +
>  hw/arm/max78000_soc.c           |  27 +++-
>  hw/char/Kconfig                 |   3 +
>  hw/char/max78000_uart.c         | 263 ++++++++++++++++++++++++++++++++
>  hw/char/meson.build             |   1 +
>  include/hw/arm/max78000_soc.h   |   3 +
>  include/hw/char/max78000_uart.h |  77 ++++++++++
>  7 files changed, 370 insertions(+), 5 deletions(-)
>  create mode 100644 hw/char/max78000_uart.c
>  create mode 100644 include/hw/char/max78000_uart.h

Some of the comments I had on patch 2 apply also to this
and the other devices:
 * separate patches for "new device" and "wire up new
   device into the SoC"
 * missing migration state support
 * use DEVICE_LITTLE_ENDIAN
 * set .impl.min_access_size and .impl_max_access_size
   appropriately for the device
 * make sure you've implemented a reset method (this device
   has one but some of the later ones don't)
 * fix case indent and excess braces if necessary
 * make sure you're not using the _realize_and_unref functions


> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 3f23af3244..59450dc3cb 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -368,6 +368,7 @@ config MAX78000_SOC
>      bool
>      select ARM_V7M
>      select MAX78000_ICC
> +    select MAX78000_UART
>
>  config RASPI
>      bool
> diff --git a/hw/arm/max78000_soc.c b/hw/arm/max78000_soc.c
> index 4d598bddd4..6334d8b49b 100644
> --- a/hw/arm/max78000_soc.c
> +++ b/hw/arm/max78000_soc.c
> @@ -16,7 +16,11 @@
>  #include "hw/qdev-clock.h"
>  #include "hw/misc/unimp.h"
>
> -static const uint32_t max78000_icc_addr[] = {0x4002a000, 0x4002a800};
> +static const uint32_t max78000_icc_addr[] =  {0x4002a000, 0x4002a800};
> +static const uint32_t max78000_uart_addr[] = {0x40042000, 0x40043000,
> +                                              0x40044000};
> +
> +static const int max78000_uart_irq[] = {30, 31, 50};

The GPIO inputs to the ARM7M object are only the external
interrupt lines, so GPIO 0 is the first external interrupt,
which is 16 in the datasheet's Table 3-3. So you need to
subtract 16 from all the numbers in the table to get
the right GPIO index. The UARTs here are at 14, 15, 34.

>
>  static void max78000_soc_initfn(Object *obj)
>  {
> @@ -29,6 +33,10 @@ static void max78000_soc_initfn(Object *obj)
>          object_initialize_child(obj, "icc[*]", &s->icc[i], TYPE_MAX78000_ICC);
>      }
>
> +    for (i = 0; i < MAX78000_NUM_UART; i++) {
> +        object_initialize_child(obj, "uart[*]", &s->uart[i], TYPE_MAX78000_UART);

I didn't notice this for the icc patch, but rather than using the
same string for each UART, you can give them unique names with
           g_autofree char *name = g_strdup_printf("uart%d", i);
           object_initialize_child(obj, name, ...)

See eg hw/arm/stm32l4x5_soc.c for examples.

> +    }
> +
>      s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
>      s->refclk = qdev_init_clock_in(DEVICE(s), "refclk", NULL, NULL, 0);
>  }
> @@ -38,6 +46,7 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
>      MAX78000State *s = MAX78000_SOC(dev_soc);
>      MemoryRegion *system_memory = get_system_memory();
>      DeviceState *dev, *armv7m;
> +    SysBusDevice *busdev;
>      Error *err = NULL;
>      int i;
>
> @@ -101,6 +110,18 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
>          sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, max78000_icc_addr[i]);
>      }
>
> +    for (i = 0; i < MAX78000_NUM_UART; i++) {
> +        dev = DEVICE(&(s->uart[i]));
> +        qdev_prop_set_chr(dev, "chardev", serial_hd(i));
> +        if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), errp)) {
> +            return;
> +        }
> +        busdev = SYS_BUS_DEVICE(dev);
> +        sysbus_mmio_map(busdev, 0, max78000_uart_addr[i]);
> +        sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m,
> +                                                       max78000_uart_irq[i]));
> +    }
> +
>
>      create_unimplemented_device("globalControl",    0x40000000, 0x400);
>      create_unimplemented_device("systemInterface",  0x40000400, 0x400);
> @@ -140,10 +161,6 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
>      create_unimplemented_device("oneWireMaster",    0x4003d000, 0x1000);
>      create_unimplemented_device("semaphore",        0x4003e000, 0x1000);
>
> -    create_unimplemented_device("uart0",            0x40042000, 0x1000);
> -    create_unimplemented_device("uart1",            0x40043000, 0x1000);
> -    create_unimplemented_device("uart2",            0x40044000, 0x1000);
> -
>      create_unimplemented_device("spi1",             0x40046000, 0x2000);
>      create_unimplemented_device("trng",             0x4004d000, 0x1000);
>      create_unimplemented_device("i2s",              0x40060000, 0x1000);
> diff --git a/hw/char/Kconfig b/hw/char/Kconfig
> index 9d517f3e28..020c0a84bb 100644
> --- a/hw/char/Kconfig
> +++ b/hw/char/Kconfig
> @@ -48,6 +48,9 @@ config VIRTIO_SERIAL
>      default y
>      depends on VIRTIO
>
> +config MAX78000_UART
> +    bool
> +
>  config STM32F2XX_USART
>      bool
>
> diff --git a/hw/char/max78000_uart.c b/hw/char/max78000_uart.c
> new file mode 100644
> index 0000000000..edd39c5a8b
> --- /dev/null
> +++ b/hw/char/max78000_uart.c
> @@ -0,0 +1,263 @@
> +/*
> + * MAX78000 UART
> + *
> + * Copyright (c) 2025 Jackson Donaldson <jcksn@duck.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/char/max78000_uart.h"
> +#include "hw/irq.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "trace.h"
> +
> +static int max78000_uart_can_receive(void *opaque)
> +{
> +    Max78000UartState *s = opaque;
> +    if (!(s->ctrl & UART_BCLKEN)) {
> +        return 0;
> +    }
> +    return fifo8_num_free(&s->rx_fifo);
> +}
> +
> +static void max78000_update_irq(Max78000UartState *s)
> +{
> +    int interrupt_level = 0;
> +    uint32_t rx_threshold = s->ctrl & 0xf;
> +
> +    /*
> +     * Because tx is synchronous and we should have no frame errors, the only
> +     * possible interrupt is receive fifo threshold
> +     */
> +    if ((s->int_en & UART_RX_THD) && fifo8_num_used(&s->rx_fifo) >= rx_threshold) {
> +        interrupt_level = 1;
> +        s->int_fl = s->int_fl & UART_RX_THD;
> +    } else{
> +        s->int_fl = s->int_fl & ~UART_RX_THD;
> +    }

This looks a little odd. The usual pattern for interrupt
status bits is:
 * when we notice the condition (in this case, when we receive
   a char and it puts us above the rx threshold), set the
   bit in the int_fl register
 * option A: devices where the flag bit tracks the underlying
   condition:
     - when we notice that the condition is no longer true (in this
       case, when the guest reads a char from the rx fifo and it
       puts us below the rx threshold again), clear the int_fl bit,
 * option B: devices where the flag bit latches and the guest must
   explicitly clear it:
     - no action when the condition is no longer true

   The MAX78000 UART is an "option B" device -- see section 12.5.
 * in the update_irq() function, set the interrupt if
   the int_fl bit and the int_en bit are set, otherwise clear it.
   If the bit definitions in the two registers line up, this is
   as simple as
    bool interrupt_level = s->int_fl & s->int_en;
   If they don't line up then it needs a bit more manual work.

The code you have at the moment doesn't implement the "int_fl
bits latch and must be explicitly cleared by software" behaviour.

> +    qemu_set_irq(s->irq, interrupt_level);
> +}
> +
> +static void max78000_uart_receive(void *opaque, const uint8_t *buf, int size)
> +{
> +    Max78000UartState *s = opaque;
> +
> +    if (size <= fifo8_num_free(&s->rx_fifo)) {
> +        fifo8_push_all(&s->rx_fifo, buf, size);
> +    } else{
> +        fifo8_push_all(&s->rx_fifo, buf, fifo8_num_free(&s->rx_fifo));
> +        printf("rx_fifo overrun!\n");

This should be a "can't happen" condition -- your receive
method will never be passed more bytes of data than you
said you could handle in can_receive.

Don't printf() in device code. Your options are:
 * if it's something that the device spec says is
   forbidden but a badly behaved guest can trigger,
   use qemu_log(LOG_GUEST_ERROR, ...)
 * if it's something that the device should implement but
   we don't, use qemu_log(LOG_UNIMP, ...)
 * if it's something that can't happen unless there's a bug
   in QEMU, use some kind of assert()
 * if it's nice-to-have information for debugging or for
   a user to see what the device is doing, use a tracepoint
   (trace_* functions, see docs/devel/tracing.rst)


From your register write function:

> +    case UART_INT_FL:
> +        s->int_fl = value;
> +        return;

This register's bits are W1C, i.e. write-1-to-clear.

thanks
-- PMM

