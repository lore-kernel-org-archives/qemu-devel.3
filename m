Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B21F1ECE57A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 10:24:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snbYS-0007O4-Ud; Mon, 09 Sep 2024 06:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snbYR-0007Ls-6M
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 06:23:31 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snbYO-0001XV-Jq
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 06:23:30 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a8a837cec81so162844966b.2
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 03:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725877407; x=1726482207; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J/HMTZVwB52D14P1e7i1YYF4JF97NTzpew1Q+6Ef6Q8=;
 b=zqZLgOH87QHglCvnyhLKt844tfDGthOEv+ZOL+rmXz7uZ7TjUnO8G44S4R2X3P3s5u
 xk3CpGrqc1A2IIafKA/3jngdG1DufFp4spJtO78g//l5h6kwy98kqqWab8DaeIdr9afk
 8JJHe9VsA/FF+4MYeUKm8HZQNTJLtgOrLSl7mpXfRqejnozWfV8tUtTSkNgLwZJ7jQ4Y
 WhGoJg5J3vUa5mtlqdwxY+Jp4+Rs4Sg0AnuQGkBgYG57VVIttXBu6Ob3Eigts0RDrYxT
 zhybma1T+kkbgPIen3GaDWqmFSxaATpF8q3mzizPNr0Ep2O2RhVq0SI+oN+ZEO/PfvDm
 rwMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725877407; x=1726482207;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J/HMTZVwB52D14P1e7i1YYF4JF97NTzpew1Q+6Ef6Q8=;
 b=FYjJWazFxlesOPjPl6Oh/KiRNAWyAQMbnw+ECzGKzrGv9A1cYChkzBmVj8jy2xoiRM
 pGwqdnEHmC5/KYqEVVeI078woNQ6dQQThwXr+w1TvniX2h5Efo98Nd+KrcoMSLIjQ7ny
 I5XRV7hlJf4r5UPqTjQRdA9lfOUDbOcfm5YdfPLBLyS6WSx172Iju05wpQq1MF9AC7wv
 SwNFfxlC4wzjpP/IOhSv9nXzHokaHzxl9usm8AWy65AaNCEBRFY0oee8QMDeW8ckw2e2
 qGWHmX4GyKzpKFNhzR5CAQyS6/2KOlcnN99W0XoSzQwHkqNiCBWISVoBDGk99rURkCm+
 z/cw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7alFvYUIidN13cCdEWDh5QRGT8NZJicRt4E7NSLoATKEWxrmHQnnjjnW6JOTbx84iO0hKFHBoROXx@nongnu.org
X-Gm-Message-State: AOJu0YyrARq8WgdGOpYhaKzPTKHJfwV1oNJUSH0ld83yg+2kQB57RreW
 1D1wwN/S7PTfUywwHUX6d9FanrmYMYXalRFs9dce1zQMtzx0RtIaOvyhL8FxSSQ=
X-Google-Smtp-Source: AGHT+IFeD3IsteqIZ3fXrHoA6vSkZVSnTaDqr9VxEIH+qylMif9A+byw+v3dv6pfZumBRloPB9edMg==
X-Received: by 2002:a05:6402:1e93:b0:5be:d687:9e6c with SMTP id
 4fb4d7f45d1cf-5c3dc7c9dbbmr7796531a12.36.1725877406935; 
 Mon, 09 Sep 2024 03:23:26 -0700 (PDT)
Received: from [192.168.69.100] (nsg93-h02-176-184-54-166.dsl.sta.abo.bbox.fr.
 [176.184.54.166]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd41bb2sm2821100a12.14.2024.09.09.03.23.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 03:23:26 -0700 (PDT)
Message-ID: <67c12d0c-30ca-48df-982d-807ec5fb6817@linaro.org>
Date: Mon, 9 Sep 2024 12:23:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] hw/char: sifive_uart: Print uart characters async
To: Alistair Francis <alistair23@gmail.com>, alex.bennee@linaro.org,
 qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: dbarboza@ventanamicro.com, palmer@dabbelt.com,
 zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 liwei1518@gmail.com, Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 atishp@rivosinc.com, Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20240909021317.58192-1-alistair.francis@wdc.com>
 <20240909021317.58192-3-alistair.francis@wdc.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240909021317.58192-3-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
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

Hi Alistair,

On 9/9/24 04:13, Alistair Francis wrote:
> The current approach of using qemu_chr_fe_write() and ignoring the
> return values results in dropped characters [1].
> 
> Let's update the SiFive UART to use a async sifive_uart_xmit() function
> to transmit the characters and apply back pressure to the guest with
> the SIFIVE_UART_TXFIFO_FULL status.
> 
> This should avoid dropped characters and more realisticly model the
> hardware.
> 
> 1: https://gitlab.com/qemu-project/qemu/-/issues/2114
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Tested-by: Thomas Huth <thuth@redhat.com>
> ---
>   include/hw/char/sifive_uart.h | 17 ++++++-
>   hw/char/sifive_uart.c         | 88 +++++++++++++++++++++++++++++++++--
>   2 files changed, 99 insertions(+), 6 deletions(-)
> 
> diff --git a/include/hw/char/sifive_uart.h b/include/hw/char/sifive_uart.h
> index 7f6c79f8bd..b43109bb8b 100644
> --- a/include/hw/char/sifive_uart.h
> +++ b/include/hw/char/sifive_uart.h
> @@ -24,6 +24,7 @@
>   #include "hw/qdev-properties.h"
>   #include "hw/sysbus.h"
>   #include "qom/object.h"
> +#include "qemu/fifo8.h"
>   
>   enum {
>       SIFIVE_UART_TXFIFO        = 0,
> @@ -48,9 +49,13 @@ enum {
>       SIFIVE_UART_IP_RXWM       = 2  /* Receive watermark interrupt pending */
>   };
>   
> +#define SIFIVE_UART_TXFIFO_FULL    0x80000000
> +
>   #define SIFIVE_UART_GET_TXCNT(txctrl)   ((txctrl >> 16) & 0x7)
>   #define SIFIVE_UART_GET_RXCNT(rxctrl)   ((rxctrl >> 16) & 0x7)
> +
>   #define SIFIVE_UART_RX_FIFO_SIZE 8
> +#define SIFIVE_UART_TX_FIFO_SIZE 8
>   
>   #define TYPE_SIFIVE_UART "riscv.sifive.uart"
>   OBJECT_DECLARE_SIMPLE_TYPE(SiFiveUARTState, SIFIVE_UART)
> @@ -63,13 +68,21 @@ struct SiFiveUARTState {
>       qemu_irq irq;
>       MemoryRegion mmio;
>       CharBackend chr;
> -    uint8_t rx_fifo[SIFIVE_UART_RX_FIFO_SIZE];
> -    uint8_t rx_fifo_len;
> +
> +    uint32_t txfifo;
>       uint32_t ie;
>       uint32_t ip;
>       uint32_t txctrl;
>       uint32_t rxctrl;
>       uint32_t div;
> +
> +    uint8_t rx_fifo[SIFIVE_UART_RX_FIFO_SIZE];
> +    uint8_t rx_fifo_len;
> +
> +    Fifo8 tx_fifo;
> +
> +    QEMUTimer *fifo_trigger_handle;
> +    uint64_t char_tx_time;

Unfortunately some fields now need to be migrated and
tracked in vmstate_sifive_uart[].

>   };
>   
>   SiFiveUARTState *sifive_uart_create(MemoryRegion *address_space, hwaddr base,
> diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
> index 7fc6787f69..ab899b60d6 100644
> --- a/hw/char/sifive_uart.c
> +++ b/hw/char/sifive_uart.c
> @@ -64,6 +64,72 @@ static void sifive_uart_update_irq(SiFiveUARTState *s)
>       }
>   }
>   
> +static gboolean sifive_uart_xmit(void *do_not_use, GIOCondition cond,
> +                                 void *opaque)
> +{
> +    SiFiveUARTState *s = opaque;
> +    int ret;
> +    const uint8_t *charecters;

"characters" ;)

> +    uint32_t numptr = 0;
> +
> +    /* instant drain the fifo when there's no back-end */
> +    if (!qemu_chr_fe_backend_connected(&s->chr)) {
> +        fifo8_reset(&s->tx_fifo);
> +        return G_SOURCE_REMOVE;
> +    }
> +
> +    if (fifo8_is_empty(&s->tx_fifo)) {
> +        return G_SOURCE_REMOVE;
> +    }
> +
> +    /* Don't pop the FIFO in case the write fails */
> +    charecters = fifo8_peek_bufptr(&s->tx_fifo,
> +                                   fifo8_num_used(&s->tx_fifo), &numptr);
> +    ret = qemu_chr_fe_write(&s->chr, charecters, numptr);
> +
> +    if (ret >= 0) {
> +        /* We wrote the data, actually pop the fifo */
> +        fifo8_pop_bufptr(&s->tx_fifo, ret, NULL);
> +    }
> +
> +    if (!fifo8_is_empty(&s->tx_fifo)) {
> +        guint r = qemu_chr_fe_add_watch(&s->chr, G_IO_OUT | G_IO_HUP,
> +                                        sifive_uart_xmit, s);
> +        if (!r) {
> +            fifo8_reset(&s->tx_fifo);
> +            return G_SOURCE_REMOVE;
> +        }
> +    }
> +
> +    /* Clear the TX Full bit */
> +    if (!fifo8_is_full(&s->tx_fifo)) {
> +        s->txfifo &= ~SIFIVE_UART_TXFIFO_FULL;
> +    }
> +
> +    sifive_uart_update_irq(s);
> +    return G_SOURCE_REMOVE;

Alex suggested to see if we can have a generic (abstract?) FIFO char
implementation. I might have a look later when I get the PL011 series
in.

> +}
> +
> +static void sifive_uart_write_tx_fifo(SiFiveUARTState *s, const uint8_t *buf,
> +                                      int size)
> +{
> +    uint64_t current_time = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +
> +    if (size > fifo8_num_free(&s->tx_fifo)) {
> +        size = fifo8_num_free(&s->tx_fifo);
> +        qemu_log_mask(LOG_GUEST_ERROR, "sifive_uart: TX FIFO overflow");
> +    }
> +
> +    fifo8_push_all(&s->tx_fifo, buf, size);
> +
> +    if (fifo8_is_full(&s->tx_fifo)) {
> +        s->txfifo |= SIFIVE_UART_TXFIFO_FULL;
> +    }
> +
> +    timer_mod(s->fifo_trigger_handle, current_time +
> +              (s->char_tx_time * 4));
> +}
> +
>   static uint64_t
>   sifive_uart_read(void *opaque, hwaddr addr, unsigned int size)
>   {
> @@ -82,7 +148,7 @@ sifive_uart_read(void *opaque, hwaddr addr, unsigned int size)
>           return 0x80000000;
>   
>       case SIFIVE_UART_TXFIFO:
> -        return 0; /* Should check tx fifo */
> +        return s->txfifo;
>       case SIFIVE_UART_IE:
>           return s->ie;
>       case SIFIVE_UART_IP:
> @@ -106,12 +172,10 @@ sifive_uart_write(void *opaque, hwaddr addr,
>   {
>       SiFiveUARTState *s = opaque;
>       uint32_t value = val64;
> -    unsigned char ch = value;
>   
>       switch (addr) {
>       case SIFIVE_UART_TXFIFO:
> -        qemu_chr_fe_write(&s->chr, &ch, 1);
> -        sifive_uart_update_irq(s);
> +        sifive_uart_write_tx_fifo(s, (uint8_t *) &value, 1);
>           return;
>       case SIFIVE_UART_IE:
>           s->ie = val64;
> @@ -131,6 +195,13 @@ sifive_uart_write(void *opaque, hwaddr addr,
>                     __func__, (int)addr, (int)value);
>   }
>   
> +static void fifo_trigger_update(void *opaque)
> +{
> +    SiFiveUARTState *s = opaque;
> +
> +    sifive_uart_xmit(NULL, G_IO_OUT, s);
> +}
> +
>   static const MemoryRegionOps sifive_uart_ops = {
>       .read = sifive_uart_read,
>       .write = sifive_uart_write,
> @@ -197,6 +268,9 @@ static void sifive_uart_realize(DeviceState *dev, Error **errp)
>   {
>       SiFiveUARTState *s = SIFIVE_UART(dev);
>   
> +    s->fifo_trigger_handle = timer_new_ns(QEMU_CLOCK_VIRTUAL,
> +                                          fifo_trigger_update, s);
> +
>       qemu_chr_fe_set_handlers(&s->chr, sifive_uart_can_rx, sifive_uart_rx,
>                                sifive_uart_event, sifive_uart_be_change, s,
>                                NULL, true);
> @@ -206,12 +280,18 @@ static void sifive_uart_realize(DeviceState *dev, Error **errp)
>   static void sifive_uart_reset_enter(Object *obj, ResetType type)
>   {
>       SiFiveUARTState *s = SIFIVE_UART(obj);
> +
> +    s->txfifo = 0;
>       s->ie = 0;
>       s->ip = 0;
>       s->txctrl = 0;
>       s->rxctrl = 0;
>       s->div = 0;
> +
>       s->rx_fifo_len = 0;
> +
> +    memset(s->rx_fifo, 0, SIFIVE_UART_RX_FIFO_SIZE);
> +    fifo8_create(&s->tx_fifo, SIFIVE_UART_TX_FIFO_SIZE);
>   }
>   
>   static void sifive_uart_reset_hold(Object *obj, ResetType type)


