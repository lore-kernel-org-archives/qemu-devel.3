Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A03CEDE9BA
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 20:35:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so7Zz-0002Qf-Qs; Tue, 10 Sep 2024 16:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1so7Zw-0002PQ-Ds; Tue, 10 Sep 2024 16:35:12 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1so7Zu-0005uq-6z; Tue, 10 Sep 2024 16:35:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=zHnOqHVEQJmkInTlASwxCPY5g9ucz3r3LlAQPP57ncc=; b=hYD9MOKnjK+t75WzTYHlmPj3Bo
 NTikCEg+jWRuNHXMuG+fnLgWUBpVTl5TPtOUoMbgHGWdVtuGJMgXxMdJMcx3CNCbgJxnm85OQfkJJ
 et0Xsi0pQmlEqbjorAlcaMsIUxbU9iT+V0Ym/A6RKf+sns1tr/VASRgqVuUKo+JMcY+yto367oVuv
 QDQlX9U6YowAgmRfRmsCeVR8jTdajJLuXT8czawKB7QWIt7TgbvG8VGbPBabWEJeyw2o2sQrVoG9l
 leLXBwR7sZ5pRF6kiXdU+0DR+f1VfUxEgEW7ynJnrkOJs6YWWj5/Il8jv4GygY6zDm9rPunpWPjFi
 S0UEL21zSW4ZjSr4uQqt2j+E1JVAkrUIryR10IvgMqqPZ+iOZVLHVg8CDAUQRoVNp4vCCHjsdM47Z
 y9b9ecvyDEIlJE9n8b4p+tuhND0hVVcmqQn44B9LKm70gjPvJ7Y0O7a0fUXWvjZ2TW3u3q11WTSLJ
 2u2p3yLAbkTvVLIHlmZFKP8Ju5EkXUQygMXbV5ZKkGcjm2m274IOsMDPQDw7ZU2TW08Zp4qZlDpJd
 W4r2pkRMzlnLxD9/klCWebtoHJftwVX+RxHYwnxxRqJ1aV3zIWtSVOjiuFlDM4WMEOodVoXAWEGlD
 6uB5rTxVN+9qqBZDEaDZt7Ib45FMgFLNkWpBhJsec=;
Received: from [2a00:23c4:8bb8:1400:b001:a616:651c:c1d5]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1so7Zk-0000r1-RT; Tue, 10 Sep 2024 21:35:04 +0100
Message-ID: <1eadf79e-ffe3-4d46-93a8-bebebf38e03c@ilande.co.uk>
Date: Tue, 10 Sep 2024 21:34:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Alistair Francis <alistair23@gmail.com>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, peter.maydell@linaro.org
Cc: Bin Meng <bmeng.cn@gmail.com>, palmer@dabbelt.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 atishp@rivosinc.com, dbarboza@ventanamicro.com,
 Thomas Huth <thuth@redhat.com>
References: <20240910045419.1252277-1-alistair.francis@wdc.com>
 <20240910045419.1252277-3-alistair.francis@wdc.com>
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
In-Reply-To: <20240910045419.1252277-3-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb8:1400:b001:a616:651c:c1d5
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v4 2/2] hw/char: sifive_uart: Print uart characters async
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

On 10/09/2024 05:54, Alistair Francis wrote:

> The current approach of using qemu_chr_fe_write() and ignoring the
> return values results in dropped characters [1].
> 
> Let's update the SiFive UART to use a async sifive_uart_xmit() function
> to transmit the characters and apply back pressure to the guest with
> the SIFIVE_UART_TXFIFO_FULL status.
> 
> This should avoid dropped characters and more realisticly model the
> hardware.

Does the UART work reliably using the fifo8_*_bufptr() functions? One of the 
motivations for my recent Fifo8 series is that these functions don't handle the 
wraparound correctly, unlike the fifo8_*_buf() functions in my recent Fifo8 series 
which do. This was the cause of Phil's async issue in 
https://mail.gnu.org/archive/html/qemu-devel/2024-07/msg05028.html.

> 1: https://gitlab.com/qemu-project/qemu/-/issues/2114
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Tested-by: Thomas Huth <thuth@redhat.com>
> ---
>   include/hw/char/sifive_uart.h | 16 +++++-
>   hw/char/sifive_uart.c         | 94 ++++++++++++++++++++++++++++++++---
>   2 files changed, 102 insertions(+), 8 deletions(-)
> 
> diff --git a/include/hw/char/sifive_uart.h b/include/hw/char/sifive_uart.h
> index 7f6c79f8bd..0846cf6218 100644
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
> @@ -63,13 +68,20 @@ struct SiFiveUARTState {
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
>   };
>   
>   SiFiveUARTState *sifive_uart_create(MemoryRegion *address_space, hwaddr base,
> diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
> index 7fc6787f69..16a70c7ad7 100644
> --- a/hw/char/sifive_uart.c
> +++ b/hw/char/sifive_uart.c
> @@ -64,6 +64,71 @@ static void sifive_uart_update_irq(SiFiveUARTState *s)
>       }
>   }
>   
> +static gboolean sifive_uart_xmit(void *do_not_use, GIOCondition cond,
> +                                 void *opaque)
> +{
> +    SiFiveUARTState *s = opaque;
> +    int ret;
> +    const uint8_t *characters;
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
> +    characters = fifo8_peek_bufptr(&s->tx_fifo,
> +                                   fifo8_num_used(&s->tx_fifo), &numptr);
> +    ret = qemu_chr_fe_write(&s->chr, characters, numptr);
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
> +    timer_mod(s->fifo_trigger_handle, current_time + 100);
> +}
> +
>   static uint64_t
>   sifive_uart_read(void *opaque, hwaddr addr, unsigned int size)
>   {
> @@ -82,7 +147,7 @@ sifive_uart_read(void *opaque, hwaddr addr, unsigned int size)
>           return 0x80000000;
>   
>       case SIFIVE_UART_TXFIFO:
> -        return 0; /* Should check tx fifo */
> +        return s->txfifo;
>       case SIFIVE_UART_IE:
>           return s->ie;
>       case SIFIVE_UART_IP:
> @@ -106,12 +171,10 @@ sifive_uart_write(void *opaque, hwaddr addr,
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
> @@ -131,6 +194,13 @@ sifive_uart_write(void *opaque, hwaddr addr,
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
> @@ -197,6 +267,9 @@ static void sifive_uart_realize(DeviceState *dev, Error **errp)
>   {
>       SiFiveUARTState *s = SIFIVE_UART(dev);
>   
> +    s->fifo_trigger_handle = timer_new_ns(QEMU_CLOCK_VIRTUAL,
> +                                          fifo_trigger_update, s);
> +
>       qemu_chr_fe_set_handlers(&s->chr, sifive_uart_can_rx, sifive_uart_rx,
>                                sifive_uart_event, sifive_uart_be_change, s,
>                                NULL, true);
> @@ -206,12 +279,18 @@ static void sifive_uart_realize(DeviceState *dev, Error **errp)
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
> @@ -222,8 +301,8 @@ static void sifive_uart_reset_hold(Object *obj, ResetType type)
>   
>   static const VMStateDescription vmstate_sifive_uart = {
>       .name = TYPE_SIFIVE_UART,
> -    .version_id = 1,
> -    .minimum_version_id = 1,
> +    .version_id = 2,
> +    .minimum_version_id = 2,
>       .fields = (const VMStateField[]) {
>           VMSTATE_UINT8_ARRAY(rx_fifo, SiFiveUARTState,
>                               SIFIVE_UART_RX_FIFO_SIZE),
> @@ -233,6 +312,9 @@ static const VMStateDescription vmstate_sifive_uart = {
>           VMSTATE_UINT32(txctrl, SiFiveUARTState),
>           VMSTATE_UINT32(rxctrl, SiFiveUARTState),
>           VMSTATE_UINT32(div, SiFiveUARTState),
> +        VMSTATE_UINT32(txfifo, SiFiveUARTState),
> +        VMSTATE_FIFO8(tx_fifo, SiFiveUARTState),
> +        VMSTATE_TIMER_PTR(fifo_trigger_handle, SiFiveUARTState),
>           VMSTATE_END_OF_LIST()
>       },
>   };


ATB,

Mark.


