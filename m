Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36E04CCFA18
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 06:43:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJR2E-0000Y4-R0; Thu, 13 Nov 2025 01:42:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1vJR1v-0000Ji-He; Thu, 13 Nov 2025 01:42:03 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1vJR1t-0000sx-7Q; Thu, 13 Nov 2025 01:42:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=dCeY5p81Ls/MZLjNNYza3pCsGo+7JvkpUjmeR/wn3Eo=; b=RVQYQNC9NeUb0QIu7r0AIwsAgE
 naOh+WowD1knhAVCM0dObpYzHpHWmXEIS2hf2+YQMqdSFibyBib4BY8ue2LnltJgZVWt+5XOuAF43
 vnzMqwIRUnTcuPuUwxKFpl0a6XJ+CfRvwdup9xZznOyk4UVo3LBVOzleXsdrrqA4mvQ5j+mXVXAPH
 BWcXmj0XEpsSWSY1Jvbxz5IBzErhdY3d8ytSg+qfPWUNZf9WEwnVcYSNZoMA0IoAZa+bvg4wvQQTw
 SLERngYZfeOujNQF1Pd/FqagAHwVN6Mz/wBoowyBbJZ6T96L2HkWmG3FVHquwxO5lGUxN9PBD5hz1
 ZglxzkOGHDkdpG3HtC9WaH/qHiiPnhippbJZQdKdIsqBvJJQJKu77TckHgfHenMTeijsjNsHDT7GZ
 Oj5th2AKjIAAVb+xQluWtLPM/NqS30jODduxO/HfLQiuMmzACSiDJ9zm5FhTzroW4Xtp9X9X60AcD
 EgSCEicz0riPqLT7gmGugeu40D3Lmxrojr06nwWiQvNjvD/DhEBuKivPUwK5++FwY6apqRLzsfkY0
 0XxW73vgEkftqUz8Mb7k6s8dcaSCZlhcVvyTyoyif87P3sFeXxNnRWj8QicicK56CrDHUGBBz9RVk
 gefbq8+ifVfC3FZzRTZLNGt9BoYsX/t99KRpnA9eA=;
Received: from [2a02:8012:2f01:0:d1be:3a37:c7f0:f7cd]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1vJQzV-0008BE-Sv; Thu, 13 Nov 2025 06:39:34 +0000
Message-ID: <3f6926c5-61d2-418b-9e82-428eb270f7bf@ilande.co.uk>
Date: Thu, 13 Nov 2025 06:41:52 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Michael Levit <michael@videogpu.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, philmd@linaro.org, pbonzini@redhat.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 liwei1518@gmail.com, smishash@gmail.com
References: <20251109191532.32419-1-michael@videogpu.com>
 <20251109191532.32419-4-michael@videogpu.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 xsBNBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAHNME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPsLA
 eAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63M7ATQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABwsBfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
In-Reply-To: <20251109191532.32419-4-michael@videogpu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:d1be:3a37:c7f0:f7cd
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v4 3/5] hw/char: add NEORV32 UART (CTRL/DATA, fifo,
 chardev)
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
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

On 09/11/2025 19:15, Michael Levit wrote:

> From: Michael <michael@videogpu.com>
> 
> Add NEORV32 UART device: CTRL/DATA registers, RX FIFO, TX to chardev.
> Includes Kconfig/meson and public header.
> 
> Signed-off-by: Michael Levit <michael@videogpu.com>
> ---
>   hw/char/Kconfig                |   3 +
>   hw/char/meson.build            |   1 +
>   hw/char/neorv32_uart.c         | 285 +++++++++++++++++++++++++++++++++
>   include/hw/char/neorv32_uart.h |  54 +++++++
>   4 files changed, 343 insertions(+)
>   create mode 100644 hw/char/neorv32_uart.c
>   create mode 100644 include/hw/char/neorv32_uart.h
> 
> diff --git a/hw/char/Kconfig b/hw/char/Kconfig
> index 020c0a84bb..1fd39c2b30 100644
> --- a/hw/char/Kconfig
> +++ b/hw/char/Kconfig
> @@ -95,3 +95,6 @@ config IP_OCTAL_232
>       bool
>       default y
>       depends on IPACK
> +
> +config NEORV32_UART
> +    bool
> diff --git a/hw/char/meson.build b/hw/char/meson.build
> index a9e1dc26c0..2f5bf827a7 100644
> --- a/hw/char/meson.build
> +++ b/hw/char/meson.build
> @@ -31,6 +31,7 @@ system_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_uart.c'))
>   system_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_aux.c'))
>   system_ss.add(when: 'CONFIG_RENESAS_SCI', if_true: files('renesas_sci.c'))
>   system_ss.add(when: 'CONFIG_SIFIVE_UART', if_true: files('sifive_uart.c'))
> +system_ss.add(when: 'CONFIG_NEORV32_UART', if_true: files('neorv32_uart.c'))
>   system_ss.add(when: 'CONFIG_SH_SCI', if_true: files('sh_serial.c'))
>   system_ss.add(when: 'CONFIG_STM32F2XX_USART', if_true: files('stm32f2xx_usart.c'))
>   system_ss.add(when: 'CONFIG_STM32L4X5_USART', if_true: files('stm32l4x5_usart.c'))
> diff --git a/hw/char/neorv32_uart.c b/hw/char/neorv32_uart.c
> new file mode 100644
> index 0000000000..a21066d194
> --- /dev/null
> +++ b/hw/char/neorv32_uart.c
> @@ -0,0 +1,285 @@
> +/*
> + * Neorv32-specific UART.
> + *
> + * Copyright (c) 2025 Michael Levit
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu/log.h"
> +#include "migration/vmstate.h"
> +#include "chardev/char.h"
> +#include "chardev/char-fe.h"
> +#include "hw/irq.h"
> +#include "hw/char/neorv32_uart.h"
> +#include "hw/qdev-properties-system.h"
> +
> +#define NEORV32_UART_IO_REGION_SIZE  (32)
> +
> +static Property neorv32_uart_properties[] = {

This should be static const Property now.

> +    DEFINE_PROP_CHR("chardev", Neorv32UARTState, chr),
> +};
> +
> +enum {
> +    NEORV32_UART_CTRL = 0,  /**< offset 0: control register */
> +    NEORV32_UART_DATA = 4  /**< offset 4: data register  */
> +};
> +
> +/** UART control register bits */
> +enum NEORV32_UART_CTRL_enum {
> +    UART_CTRL_EN            = 0,  /* enable */
> +    UART_CTRL_SIM_MODE      = 1,  /* sim override */
> +    UART_CTRL_HWFC_EN       = 2,  /* RTS/CTS */
> +    UART_CTRL_PRSC_LSB      = 3,  /* prescaler sel LSB */
> +    UART_CTRL_PRSC_MSB      = 5,  /* prescaler sel MSB */
> +    UART_CTRL_BAUD_LSB      = 6,  /* baud div LSB */
> +    UART_CTRL_BAUD_MSB      = 15, /* baud div MSB */
> +    UART_CTRL_RX_NEMPTY     = 16, /* RX not empty */
> +    UART_CTRL_RX_FULL       = 17, /* RX full */
> +    UART_CTRL_TX_EMPTY      = 18, /* TX empty */
> +    UART_CTRL_TX_NFULL      = 19, /* TX not full */
> +    UART_CTRL_IRQ_RX_NEMPTY = 20, /* IRQ on RX not empty */
> +    UART_CTRL_IRQ_RX_FULL   = 21, /* IRQ on RX full */
> +    UART_CTRL_IRQ_TX_EMPTY  = 22, /* IRQ on TX empty */
> +    UART_CTRL_IRQ_TX_NFULL  = 23, /* IRQ on TX not full */
> +
> +    UART_CTRL_RX_OVER       = 30, /* RX overflow */
> +    UART_CTRL_TX_BUSY       = 31  /* TX busy or not empty */
> +};
> +
> +/**  bits */
> +enum NEORV32_UART_DATA_enum {
> +    UART_DATA_RTX_LSB = 0, /**< (r/w): UART rx/tx data, LSB */
> +    UART_DATA_RTX_MSB = 7, /**< (r/w): UART rx/tx data, MSB */
> +
> +    UART_DATA_RX_FIFO_SIZE_LSB = 8, /**< (r/-): log2(RX FIFO size), LSB */
> +    UART_DATA_RX_FIFO_SIZE_MSB = 11, /**< (r/-): log2(RX FIFO size), MSB */
> +
> +    UART_DATA_TX_FIFO_SIZE_LSB = 12, /**< (r/-): log2(RX FIFO size), LSB */
> +    UART_DATA_TX_FIFO_SIZE_MSB = 15, /**< (r/-): log2(RX FIFO size), MSB */
> +};
> +/**@}*/
> +
> +static void neorv32_uart_update_irq(Neorv32UARTState *s)
> +{
> +    int cond = 0;
> +    if ((s->ie & NEORV32_UART_IE_TXWM) ||
> +       ((s->ie & NEORV32_UART_IE_RXWM) && s->rx_fifo_len)) {
> +        cond = 1;
> +    }
> +    if (cond) {
> +        qemu_irq_raise(s->irq);
> +    } else {
> +        qemu_irq_lower(s->irq);
> +    }
> +}
> +
> +static uint64_t
> +neorv32_uart_read(void *opaque, hwaddr addr, unsigned int size)
> +{
> +  Neorv32UARTState *s = opaque;
> +  unsigned char r;
> +
> +    switch (addr) {
> +    case NEORV32_UART_CTRL:
> +        if (s->rx_fifo_len) {
> +            s->CTRL |= (1 << UART_CTRL_RX_NEMPTY); /* set data available */
> +        } else {
> +            s->CTRL &= ~(1 << UART_CTRL_RX_NEMPTY); /* clear data available */
> +        }
> +        /* TODO: assuming here TX is always avalable, fix it. */
> +        s->CTRL |= (1 << UART_CTRL_TX_NFULL); /* set TX not full */
> +
> +        return s->CTRL;
> +
> +    case NEORV32_UART_DATA:
> +        if (s->rx_fifo_len) {
> +            r = s->rx_fifo[0];
> +            memmove(s->rx_fifo, s->rx_fifo + 1, s->rx_fifo_len - 1);
> +            s->rx_fifo_len--;
> +            qemu_chr_fe_accept_input(&s->chr);
> +            s->DATA = r;
> +
> +            neorv32_uart_update_irq(s); /* TODO: check if need to call */
> +            return r;
> +        }
> +    }
> +
> +    qemu_log_mask(LOG_GUEST_ERROR, "%s: bad read: addr = 0x%x\n",
> +    __func__, (int)addr);
> +    return 0;
> +}
> +
> +
> +
> +static void
> +neorv32_uart_write(void *opaque, hwaddr addr, uint64_t val64, unsigned int size)
> +{
> +    Neorv32UARTState *s = opaque;
> +    uint32_t value = val64;
> +    unsigned char ch = value;
> +
> +    /* TODO: check if need to update data and control bits */
> +    switch (addr) {
> +    case NEORV32_UART_CTRL:
> +        s->CTRL = value;
> +        /* TODO: check if need to call, depending on IRQ flags */
> +        /* neorv32_uart_update_irq(s); */
> +        return;
> +    case NEORV32_UART_DATA:
> +        s->DATA = value;
> +        qemu_chr_fe_write(&s->chr, &ch, 1);
> +        /* neorv32_uart_update_irq(s); TODO: check if need to call */
> +    return;
> +    }
> +
> +    qemu_log_mask(LOG_GUEST_ERROR, "%s: bad write: addr = 0x%x v = 0x%x\n",
> +    __func__, (int)addr, (int)value);
> +}
> +
> +static const MemoryRegionOps neorv32_uart_ops = {
> +    .read = neorv32_uart_read,
> +    .write = neorv32_uart_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .valid = {
> +    .min_access_size = 4,
> +    .max_access_size = 4
> +    }
> +};
> +
> +static void neorv32_uart_init(Object *obj)
> +{
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> +    Neorv32UARTState *s = NEORV32_UART(obj);
> +
> +    memory_region_init_io(&s->mmio, OBJECT(s), &neorv32_uart_ops, s,
> +    TYPE_NEORV32_UART, NEORV32_UART_IO_REGION_SIZE);
> +    sysbus_init_mmio(sbd, &s->mmio);
> +    sysbus_init_irq(sbd, &s->irq);
> +}
> +
> +
> +static void neorv32_uart_rx(void *opaque, const uint8_t *buf, int size)
> +{
> +    Neorv32UARTState *s = opaque;
> +
> +    /* Got a byte.  */
> +    if (s->rx_fifo_len >= sizeof(s->rx_fifo)) {
> +        printf("WARNING: UART dropped char.\n");
> +        return;
> +    }
> +    s->rx_fifo[s->rx_fifo_len++] = *buf;
> +
> +    neorv32_uart_update_irq(s);
> +}
> +
> +static int neorv32_uart_can_rx(void *opaque)
> +{
> +    Neorv32UARTState *s = opaque;
> +
> +    return s->rx_fifo_len < sizeof(s->rx_fifo);
> +}
> +
> +static void neorv32_uart_event(void *opaque, QEMUChrEvent event)
> +{
> +}
> +
> +static int  neorv32_uart_be_change(void *opaque)
> +{
> +    Neorv32UARTState *s = opaque;
> +
> +    qemu_chr_fe_set_handlers(&s->chr, neorv32_uart_can_rx, neorv32_uart_rx,
> +    neorv32_uart_event, neorv32_uart_be_change, s,
> +    NULL, true);
> +
> +    return 0;
> +}
> +
> +static void neorv32_uart_realize(DeviceState *dev, Error **errp)
> +{
> +    Neorv32UARTState *s = NEORV32_UART(dev);
> +
> +    qemu_chr_fe_set_handlers(&s->chr, neorv32_uart_can_rx, neorv32_uart_rx,
> +    neorv32_uart_event, neorv32_uart_be_change, s,
> +    NULL, true);
> +}
> +
> +static const VMStateDescription vmstate_neorv32_uart = {
> +    .name = TYPE_NEORV32_UART,
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +    VMSTATE_UINT8_ARRAY(rx_fifo, Neorv32UARTState,
> +    NEORV32_UART_RX_FIFO_SIZE),
> +    VMSTATE_UINT8(rx_fifo_len, Neorv32UARTState),
> +    VMSTATE_UINT32(ie, Neorv32UARTState),
> +    VMSTATE_END_OF_LIST()
> +    },
> +};
> +
> +static void neorv32_uart_reset_enter(Object *obj, ResetType type)
> +{
> +    Neorv32UARTState *s = NEORV32_UART(obj);
> +    s->rx_fifo_len = 0;
> +    s->ie = 0;
> +}
> +
> +static void neorv32_uart_reset_hold(Object *obj, ResetType type)
> +{
> +    Neorv32UARTState *s = NEORV32_UART(obj);
> +    qemu_irq_lower(s->irq);
> +}
> +
> +static void neorv32_uart_class_init(ObjectClass *oc, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(oc);
> +    ResettableClass *rc = RESETTABLE_CLASS(oc);
> +
> +    dc->realize = neorv32_uart_realize;
> +    dc->vmsd = &vmstate_neorv32_uart;
> +    rc->phases.enter = neorv32_uart_reset_enter;
> +    rc->phases.hold = neorv32_uart_reset_hold;
> +    device_class_set_props(dc, neorv32_uart_properties);
> +    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
> +}
> +
> +static const TypeInfo neorv32_uart_info = {
> +    .name = TYPE_NEORV32_UART,
> +    .parent = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(Neorv32UARTState),
> +    .instance_init = neorv32_uart_init,
> +    .class_init = neorv32_uart_class_init,
> +};
> +
> +static void neorv32_uart_register_types(void)
> +{
> +    type_register_static(&neorv32_uart_info);
> +}
> +
> +type_init(neorv32_uart_register_types)
> +/*
> + * Create UART device.
> + */
> +Neorv32UARTState *neorv32_uart_create(MemoryRegion *address_space, hwaddr base,
> +  Chardev *chr)
> +{
> +    DeviceState *dev;
> +    SysBusDevice *s;
> +    bool succed = false;
> +
> +    dev = qdev_new("riscv.neorv32.uart");
> +
> +    qdev_prop_set_chr(dev, "chardev", chr);
> +    s = SYS_BUS_DEVICE(dev);
> +    succed = sysbus_realize_and_unref(s, &error_fatal);
> +
> +    if (succed) {
> +        memory_region_add_subregion(address_space, base,
> +        sysbus_mmio_get_region(s, 0));
> +        return NEORV32_UART(dev);
> +    } else {
> +        return NULL;
> +    }
> +} /* neorv32_uart_create */

New devices should never have their own global init functions such as 
neorv32_uart_create(): this needs to be done by the board instead.

> diff --git a/include/hw/char/neorv32_uart.h b/include/hw/char/neorv32_uart.h
> new file mode 100644
> index 0000000000..fa33906724
> --- /dev/null
> +++ b/include/hw/char/neorv32_uart.h
> @@ -0,0 +1,54 @@
> +/*
> + * Neorv32-specific UART.
> + *
> + * Copyright (c) 2025 Michael Levit
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_NEORV32_UART_H
> +#define HW_NEORV32_UART_H
> +
> +#include "chardev/char-fe.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/sysbus.h"
> +#include "qom/object.h"
> +
> +#define TYPE_NEORV32_UART "riscv.neorv32.uart"
> +OBJECT_DECLARE_SIMPLE_TYPE(Neorv32UARTState, NEORV32_UART)
> +
> +#define QEMU_UART_DATA_RX_FIFO_SIZE_LSB  8  /* log2 RX FIFO size LSB */
> +#define QEMU_UART_DATA_RX_FIFO_SIZE_MSB  11  /* log2 RX FIFO size MSB */
> +
> +#define NEORV32_UART_RX_FIFO_SIZE  32 /* in HW it is 2048 + 256 = _MSB + _LSB */
> +
> +enum {
> +    NEORV32_UART_IE_TXWM = 1, /* Transmit watermark interrupt enable */
> +    NEORV32_UART_IE_RXWM = 2  /* Receive watermark interrupt enable */
> +};
> +
> +enum {
> +    NEORV32_UART_IP_TXWM = 1, /* Transmit watermark interrupt pending */
> +    NEORV32_UART_IP_RXWM = 2  /* Receive watermark interrupt pending */
> +};
> +
> +
> +
> +struct Neorv32UARTState {
> +    /*< private >*/
> +    SysBusDevice parent_obj;
> +
> +    /*< public >*/
> +    qemu_irq irq;
> +    MemoryRegion mmio;
> +    CharFrontend chr;
> +    uint8_t rx_fifo[NEORV32_UART_RX_FIFO_SIZE];
> +    uint8_t rx_fifo_len;

Rather than re-invent your own FIFO, can you make use of the existing Fifo8? It has a 
much richer API, and as long as you don't use the deprecated _bufptr() APIs, it will 
aggressively defend against underflow/overflow.

> +    uint32_t ie; /* interrupt enable */
> +    uint32_t CTRL;
> +    uint32_t DATA;
> +};
> +
> +Neorv32UARTState *neorv32_uart_create(MemoryRegion *address_space, hwaddr base,
> +    Chardev *chr);

And again, new devices should not have their own global init functions.

> +#endif /* HW_NEORV32_UART_H */


ATB,

Mark.


