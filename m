Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0979410706E4
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2026 16:19:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1Rh3-0002ex-Fw; Sat, 14 Mar 2026 12:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1w1Rgz-0002eG-IY
 for qemu-devel@nongnu.org; Sat, 14 Mar 2026 12:18:22 -0400
Received: from mail-dl1-x1243.google.com ([2607:f8b0:4864:20::1243])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1w1Rgy-0007Mi-11
 for qemu-devel@nongnu.org; Sat, 14 Mar 2026 12:18:21 -0400
Received: by mail-dl1-x1243.google.com with SMTP id
 a92af1059eb24-128d2e3074fso4318647c88.0
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2026 09:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773505098; x=1774109898; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NegWRXHaTY4H+PVwmiHKuThO5ICqz2enr0lbL5cn+DI=;
 b=TkZcxafuQhNk0hEiPxLvpcV+m4TVYvwE0zhG02nTpXYPFfulMVlZdxlMonUD0BAKh+
 E6ygoMF3LsoQW3OocMLk14m52PFsxjWcKPq7et6uWsl3yjXWX6Zx4sJo7Td9qBxGA9kA
 kGh3xpIlz8qhs8WE6/30O5aJIRK6sFcpl+Af9jmyInw73C5O//pCmkcKZgnZwTSX9RNy
 P1z3u8znLCORdDRMi0cng4kPqYLTc5dG910TR5CCkXslpa3+1MgFYZ8r/nPfnvKuDoU0
 miG2F44qUbWUczcUJCI8vLRyzjX9+JXpO6+1WWpwy4QKUl+D8aqCI6W6rP6pN/1QJs+/
 GP+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773505098; x=1774109898;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NegWRXHaTY4H+PVwmiHKuThO5ICqz2enr0lbL5cn+DI=;
 b=pV3ixQhnZO4xJKnKiVt1GpS7w5zDnl3dyxEZeTgwoheZqP2MH9RKQaghnhDVoNllla
 Syc+mjbz3CCvOH6smLiKtaaIdb8Jcp3FeXDZjnuP8TaKZ7GVBTSYGgd5s/hIHXJUU8Wd
 78mldXdEVUOjnHO/FrddMNkvEFxybtQyoci1AHmUrIprBmHvUWYcEeDmpvAVqyiXSTMo
 WO8H5RkHmITM19d7oTUC8vWsZWSg0Tikx5pZTx5CHMfQoPEZBnR5CbA67nAWK94mRXmr
 5eUmYlN/psrsUz3jTvku403NBWVEGAeZJD3BnlyoPEviVKcmQ3l8fG7N5uBqDgMZ6ens
 wsiQ==
X-Gm-Message-State: AOJu0YwACCl7Xpaey8EjAL3QDOWq42+5ru1jKWNvheYnMF5IqFsCEe6x
 uVa3teWj3DEFL0NmI5zS1a/0sdJqj64Y1XUrgi5f4TWCh+NCYHjARTa1
X-Gm-Gg: ATEYQzzDP/+QvPbmH/v9JJe9lwOED3Tj160qmPFYDmbSDvwrPHahlyYyYTjzSDUQIgh
 Z/49OZw0VPHTOdN7fBcbmXQPuNFz3FDmLLbVnvuOri5OFQ0IQQCMp/ucAdRbV7vJD9VvOg7D2HK
 q5WPMaq9j3vRsyRlInqkok/AXJjjSdksma1RwGxXeEAfYXbThB0Orun64VCOI9fIo+oIrSstRGN
 gM9hml8YX/iSC0OaegtNW1DLp0tcK303nmoaKFwA30z2qHwMAPIUiAXHf8ANrIiv8sQxH+2Wf6M
 oxH+TWJSyQvBvw0kgK/+kWXNxgDVapty9nfeUO436eUKSr0TdQXHsAgI0zXFUsjZUwdfG7wbVPY
 7kl++Ql1wcUXZ/DL/FIozj3U9qTLv1voP7auLBGk4Fxb7hbOUhHOFV7w/RMuWtKp7/ln7t2Ih9z
 bc9mUeAKMXP2yxmgxRK/S1ve7g/f5dfzJpOzkMjLtLq0Qnh0X5zgdOAsPQch/DGLpwwyw+GlO1q
 oTdoPr184m2QZaY4f1IeWwQpnwip6A=
X-Received: by 2002:a05:7022:10c:b0:127:3f2a:af21 with SMTP id
 a92af1059eb24-128f3d35440mr3032430c88.15.1773505098203; 
 Sat, 14 Mar 2026 09:18:18 -0700 (PDT)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-128f6384e7asm5919005c88.11.2026.03.14.09.18.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Mar 2026 09:18:17 -0700 (PDT)
Date: Sun, 15 Mar 2026 00:18:12 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:SiFive Machines" <qemu-riscv@nongnu.org>
Subject: Re: [PATCH v3 2/4] hw/char: sifive_uart: Sync txwm interrupt pending
 status after TX FIFO enqueue
Message-ID: <abWKCQ3GJ86VlHri@ZEVORN-PC.localdomain>
References: <20260312033201.1619554-1-frank.chang@sifive.com>
 <20260312033201.1619554-3-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312033201.1619554-3-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1243;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dl1-x1243.google.com
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

On Thu, Mar 12, 2026 at 11:31:59AM +0800, frank.chang@sifive.com wrote:
> From: Frank Chang <frank.chang@sifive.com>
> 
> Currently, the txwm interrupt pending status is only updated when the
> asynchronous transmit handler runs. This can cause the txwm interrupt
> state to become unsynchronized between the SiFive UART and the
> interrupt controller.
> 
> For example, when a txwm interrupt is raised, the corresponding APLIC
> pending bit is also set. However, if software later enqueues additional
> characters into the TX FIFO exceeding the transmit watermark, the
> APLIC pending bit may remain set because the txwm interrupt pending
> status is not updated at enqueue time.
> 
> This issue has been observed on resource-constrained machines, where
> Linux reports spurious IRQ errors. In these cases, the asynchronous
> transmit handler is unable to drain the TX FIFO quickly enough to update
> the txwm pending status before software reads the ip register, which
> derives the txwm pending state directly from the actual number of
> characters in the TX FIFO.
> 
> This commit fixes the issue by updating the txwm interrupt pending
> status immediately after enqueuing data into the TX FIFO, ensuring that
> the interrupt pending status between the SiFive UART and the interrupt
> controller remains synchronized.
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---
>  hw/char/sifive_uart.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
> index 3ce6a4ee76a..ae71a15a2a4 100644
> --- a/hw/char/sifive_uart.c
> +++ b/hw/char/sifive_uart.c
> @@ -124,12 +124,20 @@ static void sifive_uart_trigger_tx_fifo(SiFiveUARTState *s)
>  static void sifive_uart_write_tx_fifo(SiFiveUARTState *s, const uint8_t *buf,
>                                        int size)
>  {
> +    uint32_t txcnt = SIFIVE_UART_GET_TXCNT(s->txctrl);
> +    bool update_irq = false;
> +
>      if (size > fifo8_num_free(&s->tx_fifo)) {
>          size = fifo8_num_free(&s->tx_fifo);
>          qemu_log_mask(LOG_GUEST_ERROR, "sifive_uart: TX FIFO overflow.\n");
>      }
>  
>      if (size > 0) {
> +        if (fifo8_num_used(&s->tx_fifo) < txcnt &&
> +            (fifo8_num_used(&s->tx_fifo) + size) >= txcnt) {
> +            update_irq = true;
> +        }
> +
>          fifo8_push_all(&s->tx_fifo, buf, size);
>      }
>  
> @@ -137,6 +145,14 @@ static void sifive_uart_write_tx_fifo(SiFiveUARTState *s, const uint8_t *buf,
>          s->txfifo |= SIFIVE_UART_TXFIFO_FULL;
>      }
>  
> +    /*
> +     * Update txwm interrupt pending status when the number of entries
> +     * in the transmit FIFO crosses or reaches the watermark.
> +     */
> +    if (update_irq) {
> +        sifive_uart_update_irq(s);
> +    }
The watermark crossing detection logic looks correct, and commit message
is clear and well-written.

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Thanks,
Chao
> +
>      sifive_uart_trigger_tx_fifo(s);
>  }
>  
> -- 
> 2.43.0
> 
> 

