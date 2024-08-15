Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48A50C52D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 08:27:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seVp1-0007fh-1Y; Thu, 15 Aug 2024 04:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1seVoy-0007Wf-Sf; Thu, 15 Aug 2024 04:27:00 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1seVow-0004ks-Vf; Thu, 15 Aug 2024 04:27:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=9++bb6v9NOQCbpse9X23jTgVgHAdPwkZGLo3PG+vCqw=; b=SX3x0smxnUz+5M1mywMZpW4ea9
 //qqRXnWv12gSty/AqCOh63CmM+wrhgz6D7hchBQrRHf0VUo+Y4DBuRsIp3uRC+l6JpVvv+oQatE1
 R0exjGG5n/vPGTt/BM4oVaHhubqO3bX2LpEQgzTjDTqdGNYi0/vp+o1RhBDe1vKKAG2GiHWvaikIs
 jIufWfzckiJpOiC0uZnhpaq/7q+W4Z2WY0up2Ync6pIu6qQl+5YFdDacm+ErRIQ2QOXvT9bW5fDRL
 AxhCVnnELT0tu2Qm8WdcZNRfX+CatByCDx8Jeap78xNGZFUgTcSbESNU1DihwDpwv1lRtioeKrogr
 K1gD86rCGj419oAubEuw9fGcWTLj2nxeksbMZgI7FIrtwPgEiPSsBmZlVY+HIWXla6qHWz7eAtB0T
 N1aTzAqhU8gpRAscfTB/c3K1DvMuxMgS4hTU//a0G2Jlfz9rOyVkh/xae7+ragmTvKofbPaA/MnYp
 MyGxL0jy8RzXUfJtT4r3MZObV33TAq16YDPUi0zvSuS76maqyyggUCBm1UEYLX1zZHrs4u+zbkCTU
 lCzPLTj5DRGmXAx+d7p9KQTea/6jfQYAJC1oKkK58XJDmsutYKSxxXMtDoefsOrQCcAPQYVt6tlZg
 odkytPuLu03hUfIIdWlsApwi+TD4+RVtS5uQf0nls=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1seVoi-0000st-Nc; Thu, 15 Aug 2024 09:26:48 +0100
Message-ID: <c9b7b9aa-9c2e-4275-a7fb-ff994d74d3f4@ilande.co.uk>
Date: Thu, 15 Aug 2024 09:26:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Alistair Francis <alistair23@gmail.com>, alex.bennee@linaro.org,
 qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: dbarboza@ventanamicro.com, palmer@dabbelt.com, qemu-riscv@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 zhiwei_liu@linux.alibaba.com, atishp@rivosinc.com,
 Bin Meng <bmeng.cn@gmail.com>, liwei1518@gmail.com,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240815015410.369925-1-alistair.francis@wdc.com>
 <20240815015410.369925-3-alistair.francis@wdc.com>
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
In-Reply-To: <20240815015410.369925-3-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 2/2] hw/char: sifive_uart: Print uart charecters async
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 15/08/2024 02:54, Alistair Francis wrote:

> The current approach of using qemu_chr_fe_write() and ignoring the
> return values results in dropped charecters [1].
> 
> Let's update the SiFive UART to use a async sifive_uart_xmit() function
> to transmit the charecters and apply back preassure to the guest with
> the SIFIVE_UART_TXFIFO_FULL status.
> 
> This should avoid dropped charecters and more realisiticly model the
> hardware.
> 
> 1: https://gitlab.com/qemu-project/qemu/-/issues/2114
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   include/hw/char/sifive_uart.h | 17 +++++++-
>   hw/char/sifive_uart.c         | 81 +++++++++++++++++++++++++++++++++--
>   2 files changed, 92 insertions(+), 6 deletions(-)
> 
> diff --git a/include/hw/char/sifive_uart.h b/include/hw/char/sifive_uart.h
> index 7f6c79f8bd..73379457a0 100644
> --- a/include/hw/char/sifive_uart.h
> +++ b/include/hw/char/sifive_uart.h
> @@ -48,9 +48,13 @@ enum {
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
> @@ -63,13 +67,22 @@ struct SiFiveUARTState {
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
> +    uint8_t tx_fifo[SIFIVE_UART_TX_FIFO_SIZE];
> +    uint32_t tx_level;
> +
> +    QEMUTimer *fifo_trigger_handle;
> +    uint64_t char_tx_time;
>   };
>   
>   SiFiveUARTState *sifive_uart_create(MemoryRegion *address_space, hwaddr base,
> diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
> index 7fc6787f69..f517500df4 100644
> --- a/hw/char/sifive_uart.c
> +++ b/hw/char/sifive_uart.c
> @@ -64,6 +64,64 @@ static void sifive_uart_update_irq(SiFiveUARTState *s)
>       }
>   }
>   
> +static gboolean sifive_uart_xmit(void *do_not_use, GIOCondition cond,
> +                                 void *opaque)
> +{
> +    SiFiveUARTState *s = opaque;
> +    int ret;
> +
> +    /* instant drain the fifo when there's no back-end */
> +    if (!qemu_chr_fe_backend_connected(&s->chr)) {
> +        s->tx_level = 0;
> +        return G_SOURCE_REMOVE;
> +    }
> +
> +    ret = qemu_chr_fe_write(&s->chr, s->tx_fifo, s->tx_level);
> +
> +    if (ret >= 0) {
> +        s->tx_level -= ret;
> +        memmove(s->tx_fifo, s->tx_fifo + ret, s->tx_level);
> +    }
> +
> +    if (s->tx_level) {
> +        guint r = qemu_chr_fe_add_watch(&s->chr, G_IO_OUT | G_IO_HUP,
> +                                        sifive_uart_xmit, s);
> +        if (!r) {
> +            s->tx_level = 0;
> +            return G_SOURCE_REMOVE;
> +        }
> +    }
> +
> +    /* Clear the TX Full bit */
> +    if (s->tx_level != SIFIVE_UART_TX_FIFO_SIZE) {
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
> +    if (size > SIFIVE_UART_TX_FIFO_SIZE - s->tx_level) {
> +        size = SIFIVE_UART_TX_FIFO_SIZE - s->tx_level;
> +        qemu_log_mask(LOG_GUEST_ERROR, "sifive_uart: TX FIFO overflow");
> +    }
> +
> +    memcpy(s->tx_fifo + s->tx_level, buf, 1);
> +    s->tx_level += 1;
> +
> +    if (s->tx_level == SIFIVE_UART_TX_FIFO_SIZE) {
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
> @@ -82,7 +140,7 @@ sifive_uart_read(void *opaque, hwaddr addr, unsigned int size)
>           return 0x80000000;
>   
>       case SIFIVE_UART_TXFIFO:
> -        return 0; /* Should check tx fifo */
> +        return s->txfifo;
>       case SIFIVE_UART_IE:
>           return s->ie;
>       case SIFIVE_UART_IP:
> @@ -106,12 +164,10 @@ sifive_uart_write(void *opaque, hwaddr addr,
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
> @@ -131,6 +187,13 @@ sifive_uart_write(void *opaque, hwaddr addr,
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
> @@ -197,6 +260,9 @@ static void sifive_uart_realize(DeviceState *dev, Error **errp)
>   {
>       SiFiveUARTState *s = SIFIVE_UART(dev);
>   
> +    s->fifo_trigger_handle = timer_new_ns(QEMU_CLOCK_VIRTUAL,
> +                                          fifo_trigger_update, s);
> +
>       qemu_chr_fe_set_handlers(&s->chr, sifive_uart_can_rx, sifive_uart_rx,
>                                sifive_uart_event, sifive_uart_be_change, s,
>                                NULL, true);
> @@ -206,12 +272,19 @@ static void sifive_uart_realize(DeviceState *dev, Error **errp)
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
> +    s->tx_level = 0;
>       s->rx_fifo_len = 0;
> +
> +    memset(s->rx_fifo, 0, SIFIVE_UART_RX_FIFO_SIZE);
> +    memset(s->tx_fifo, 0, SIFIVE_UART_TX_FIFO_SIZE);
>   }
>   
>   static void sifive_uart_reset_hold(Object *obj, ResetType type)

Have you considered using a Fifo8 here? This avoids having to manually roll your own 
FIFO implementation.


ATB,

Mark.


