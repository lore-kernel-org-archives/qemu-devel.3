Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E37CA10706E7
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2026 16:17:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1Rfg-0002AK-L4; Sat, 14 Mar 2026 12:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1w1Rfd-00029k-SH
 for qemu-devel@nongnu.org; Sat, 14 Mar 2026 12:16:57 -0400
Received: from mail-dy1-x1344.google.com ([2607:f8b0:4864:20::1344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1w1Rfc-0007Hr-7J
 for qemu-devel@nongnu.org; Sat, 14 Mar 2026 12:16:57 -0400
Received: by mail-dy1-x1344.google.com with SMTP id
 5a478bee46e88-2be19f05d7dso419253eec.1
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2026 09:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773505014; x=1774109814; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vuU6BXhwTF08MbxU6wD2TWkgVd1F1wsD/sQmeAgy0s0=;
 b=YiaVY1Z4DYQejqgD58hVXg+HfXg8RlM4ne8D2lHlFvtRONNMQsXg2AOyuA3ogQM5aR
 o5kM7HJoBD0Pfty9pCfNiD72WheBNLd1C67WtnV9o2sRPEV99FBBoV0J55aqQfoVban2
 AXDegDyyfg/+ehrJG1+92o16QO6kNG2/1PK/bcjeMs3lLwlZFpUXMN6OF+S/HGxGTi6M
 Q4wafNtQowkQUOGiumIZqS/Fica5dUp0QxSY0dK8ZScyLLv8qOMKS+MDTHbK8yE9K/Wm
 039YlrFjIz6aHcMzz52kYKyvpABYEh0jX6PFEITaBBWnwQue+GkTDF/qnsPFLfs8QLq4
 m3OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773505014; x=1774109814;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vuU6BXhwTF08MbxU6wD2TWkgVd1F1wsD/sQmeAgy0s0=;
 b=pw5wg0RCM08BKh1paxo+nY5x0e7vgcHCxjJ6FKZYB590AjunXTlX9xIIs4I6RGygwi
 f7wz9qbFhe2VZBw96NlRbT47ulvwrY2vqlixjtCq9a1tLBOXFa3c0BUpYdtuGKv+zVZA
 I9iy+QuuY4RrlAMu0D2/tLkdh7YV8uP1MhbrKZhwSGeoKpU836kbOgSI75iE1ez+EklE
 8g6G1jnaUODIPrQ5pg4EVLJxMIwOq6KjoN7piNTdZlaRGihzQN6Ud0wHGJDcp7rE1aX5
 2sNTWsRxNoNn+BmGWjzIsxiUtvaJ2dP7BwRPM3W+EfxaSXJlFZSGa3FdXJdio11thhE8
 UaUg==
X-Gm-Message-State: AOJu0YzmzTxKiZ9qM4BrPQvfqfCrL/LWgv4ktqmsbASD3IFs5NHoii+T
 iNeKXK+o/gWwaoMZz/uA4tos7hMlNZBUHT9zJ2R2vH8BuxMeOatZvUVV
X-Gm-Gg: ATEYQzw4tdf++zZaYrVjlD/Vc0K7i9FNYSEAs7HrMJp2AlT78SkIJBW3/g/v+efzRZt
 Rc9fl8lxHchmamS8R5mQX3tS/mAYTywWDeCs/VdyscZzZ0lAOmCarlh/LKNZqsnEDKdv9hY0rsa
 rA6SxSQCulyJQ21wO3Ojbo6hg84w9mTF4tU0YgUpyoKxwsuRREaIFGezRi0KstAOKQrI5G6IRif
 GUgIvt9fxFHm09jKZplcDx3FebjnRpnkch4fE6HXoiAN24yPVUi28Uw1y5440/IARfl81N9U5z/
 OE12LBLKTHQAvR5EAXtyUNywDf9Esl1biKBVU+W3HgJ+cBsS757uNtvOKktZ5wDorcGi+RLxwvt
 KmOe7DBnLCuVYBNzFMhRekNef0hvTtNAw6sUsyeBEF0wqHgwAlpIgYJKMs4aQj/yHg0xyOI9n2B
 602ZhU4JjnjARaN87w/4oFwp420PrJLbREEsd2Uh2tdh/IyCG2R/rrqsCl+LHfFX60J6s3oLoXu
 GMGR3Yt+uCrtjugo50g2VSNvNnMKQvMY61JFReCSg==
X-Received: by 2002:a05:693c:608d:b0:2be:2e4c:209c with SMTP id
 5a478bee46e88-2bea5523f83mr2854218eec.20.1773505013788; 
 Sat, 14 Mar 2026 09:16:53 -0700 (PDT)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c0b1fc876csm1692905eec.29.2026.03.14.09.16.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Mar 2026 09:16:53 -0700 (PDT)
Date: Sun, 15 Mar 2026 00:16:48 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:SiFive Machines" <qemu-riscv@nongnu.org>
Subject: Re: [PATCH v3 1/4] hw/char: sifive_uart: Implement txctrl.txen and
 rxctrl.rxen
Message-ID: <abWElLTcZWjYRZ9J@ZEVORN-PC.localdomain>
References: <20260312033201.1619554-1-frank.chang@sifive.com>
 <20260312033201.1619554-2-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312033201.1619554-2-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1344;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1344.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Mar 12, 2026 at 11:31:58AM +0800, frank.chang@sifive.com wrote:
> From: Frank Chang <frank.chang@sifive.com>
> 
> Implement txctrl.txen and rxctrl.rxen as follows:
> 
> * txctrl.txen
>   The txen bit controls whether the Tx channel is active. When cleared,
>   transmission of Tx FIFO contents is suppressed, and the txd pin is
>   driven high.
> 
> * rxctrl.rxen:
>   The rxen bit controls whether the Rx channel is active. When cleared,
>   the state of the rxd pin is ignored, and no characters will be
>   enqueued into the Rx FIFO.
> 
> Therefore, the Tx FIFO should not be dequeued when txctrl.txen is
> cleared, and the Rx FIFO should not be enqueued when rxctrl.rxen is
> cleared.
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---
>  hw/char/sifive_uart.c         | 27 ++++++++++++++++++++-------
>  include/hw/char/sifive_uart.h |  2 ++
>  2 files changed, 22 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
> index af17cf9a6ce..3ce6a4ee76a 100644
> --- a/hw/char/sifive_uart.c
> +++ b/hw/char/sifive_uart.c
> @@ -78,6 +78,11 @@ static gboolean sifive_uart_xmit(void *do_not_use, GIOCondition cond,
>          return G_SOURCE_REMOVE;
>      }
>  
> +    /* Don't pop the FIFO if transmit is disabled. */
> +    if (!SIFIVE_UART_TXEN(s->txctrl)) {
> +        return G_SOURCE_REMOVE;
> +    }
> +
>      /* Don't pop the FIFO in case the write fails */
>      characters = fifo8_peek_bufptr(&s->tx_fifo,
>                                     fifo8_num_used(&s->tx_fifo), &numptr);
> @@ -106,11 +111,19 @@ static gboolean sifive_uart_xmit(void *do_not_use, GIOCondition cond,
>      return G_SOURCE_REMOVE;
>  }
>  
> -static void sifive_uart_write_tx_fifo(SiFiveUARTState *s, const uint8_t *buf,
> -                                      int size)
> +static void sifive_uart_trigger_tx_fifo(SiFiveUARTState *s)
>  {
>      uint64_t current_time = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>  
> +    if (!timer_pending(s->fifo_trigger_handle)) {
> +        timer_mod(s->fifo_trigger_handle, current_time +
> +            TX_INTERRUPT_TRIGGER_DELAY_NS);
> +    }
> +}
> +
> +static void sifive_uart_write_tx_fifo(SiFiveUARTState *s, const uint8_t *buf,
> +                                      int size)
> +{
>      if (size > fifo8_num_free(&s->tx_fifo)) {
>          size = fifo8_num_free(&s->tx_fifo);
>          qemu_log_mask(LOG_GUEST_ERROR, "sifive_uart: TX FIFO overflow.\n");
> @@ -124,10 +137,7 @@ static void sifive_uart_write_tx_fifo(SiFiveUARTState *s, const uint8_t *buf,
>          s->txfifo |= SIFIVE_UART_TXFIFO_FULL;
>      }
>  
> -    if (!timer_pending(s->fifo_trigger_handle)) {
> -        timer_mod(s->fifo_trigger_handle, current_time +
> -                      TX_INTERRUPT_TRIGGER_DELAY_NS);
> -    }
> +    sifive_uart_trigger_tx_fifo(s);
>  }
>  
>  static uint64_t
> @@ -184,6 +194,9 @@ sifive_uart_write(void *opaque, hwaddr addr,
>          return;
>      case SIFIVE_UART_TXCTRL:
>          s->txctrl = val64;
A sifive_uart_update_irq() call is also needed here.
When txctrl is written, the watermark (txcnt) may
change, or txen may toggle(you can see SiFive FE310-G002
datasheet), both of which can alter the txwm pending state.

Patch 3/4 adds this call for RXCTRL with the rationale "the
user may activate the Rx channel or change the Rx FIFO
watermark level" -- the same reasoning applies to TXCTRL.

Without this, there's a window where the IRQ line
doesn't reflect the actual pending state after a
txctrl write that changes the watermark.

Everything else looks good to me.

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Thanks,
Chao

> +        if (SIFIVE_UART_TXEN(s->txctrl) && !fifo8_is_empty(&s->tx_fifo)) {
> +            sifive_uart_trigger_tx_fifo(s);
> +        }
>          return;
>      case SIFIVE_UART_RXCTRL:
>          s->rxctrl = val64;
> @@ -231,7 +244,7 @@ static int sifive_uart_can_rx(void *opaque)
>  {
>      SiFiveUARTState *s = opaque;
>  
> -    return s->rx_fifo_len < sizeof(s->rx_fifo);
> +    return SIFIVE_UART_RXEN(s->rxctrl) && (s->rx_fifo_len < sizeof(s->rx_fifo));
>  }
>  
>  static void sifive_uart_event(void *opaque, QEMUChrEvent event)
> diff --git a/include/hw/char/sifive_uart.h b/include/hw/char/sifive_uart.h
> index 414564b0266..c78d9bd1fc6 100644
> --- a/include/hw/char/sifive_uart.h
> +++ b/include/hw/char/sifive_uart.h
> @@ -51,6 +51,8 @@ enum {
>  
>  #define SIFIVE_UART_TXFIFO_FULL    0x80000000
>  
> +#define SIFIVE_UART_TXEN(txctrl)        (txctrl & 0x1)
> +#define SIFIVE_UART_RXEN(rxctrl)        (rxctrl & 0x1)
macro arguments should be parenthesized to avoid precedence surprises.

e.g. if the argument is ever an expression like (a | b), & binds tighter
than |. I suggest:

  #define SIFIVE_UART_TXEN(txctrl)   ((txctrl) & 0x1)
  #define SIFIVE_UART_RXEN(rxctrl)   ((rxctrl) & 0x1)

The existing GET_TXCNT / GET_RXCNT macros have the
same issue, so this could be a follow-up cleanup.

>  #define SIFIVE_UART_GET_TXCNT(txctrl)   ((txctrl >> 16) & 0x7)
>  #define SIFIVE_UART_GET_RXCNT(rxctrl)   ((rxctrl >> 16) & 0x7)
>  
> -- 
> 2.43.0
> 
> 

