Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B863AC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 05:32:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfv0M-00056X-VV; Mon, 19 Aug 2024 01:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sfv0L-0004zj-DK; Mon, 19 Aug 2024 01:32:33 -0400
Received: from mail-vs1-xe31.google.com ([2607:f8b0:4864:20::e31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sfv0J-00058J-CT; Mon, 19 Aug 2024 01:32:33 -0400
Received: by mail-vs1-xe31.google.com with SMTP id
 ada2fe7eead31-493e8ef36b4so1495996137.2; 
 Sun, 18 Aug 2024 22:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724045550; x=1724650350; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6J/8YeXFN7bzIgFX2O2QItwvTyckBanYu33C2tky+1U=;
 b=Kqq2e9vcnzpEYqy8plm79qUiS6Plpnngt4juQJP8pellvMls9vL8retim7N9VeDNRi
 d7i7mxowzIjqWZw2JIrzNoWutkj/lgv1ZYMirE1iHLVWVE37PXirPzpixWOjgmMJ5SB9
 DTJNEL63XBV1c9S8dUOGwWY7cyh5IywEl1X0JkhkSac6BTboYuEYNu3JlPPXEFAAvkym
 81LgZZqk10PKEIVS5IkOsdUq2H8rwQ0osA8ZZrpCItXWmBAmkwGaMiYTRtSDuJYexv1D
 mg1OvBZ/z8Pru9cT0HHrwKrcNg3S9XqHc8hKz9AJVPA1ECPFz9v9AA77P/t5EIJI2Zqc
 qsMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724045550; x=1724650350;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6J/8YeXFN7bzIgFX2O2QItwvTyckBanYu33C2tky+1U=;
 b=Np/YAEOF4kyzOUYfxY94KYOCbdPtRjPe1Ve9vFOt+oZXo3fGjjp4yD8ghXlmyJFh9C
 mKIHLNP4UjcNjU3ddOlhjIN8t4YqaFzYLlT1O+qmErOImi0zs6wQ49Dz7MwdEmSRVVb7
 rIJKvAuC+elCeryxfn8cO1mX5eugwPu2p0szZFDsQDtzYzOxS6+BToV9/UEJeX4JbOSa
 gJImqZfdKsv+k7pAAkTPiVFCaTczK9XfojrRy2mc7uwb6VMDg3fGdx3PnQNbjbbG3VuH
 moEBAtpARjImfV9aXEAA8Xzdc2B9ha971DaVA1YzUMH4HBaMKHMhnVz1yf2HaFBCTewn
 yeMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOZHQ/D+3KECBdiQP5l9NbHjDsqFgF6aLlUhh+SkCAmJQkoN2xYvNsRFQ9b0s6I2Ydb7eJSO7ECfrej4hxAkc2yPyd+7q+suFOxGGdemXRsR7Fy2QZ4ZoCNbaZIA==
X-Gm-Message-State: AOJu0YwOMYkWNd95lfwwoQAkzU6GkPDSd8xq/ro4wo2achAYLd0RElGv
 I1673cSXCt6kZxRe4FhBmCLglBhkNLf7DEyOMc+jnZlSkvVQDzkEtI6RVzZBMUwnJwEf9KJbxgg
 dmtzDxupNv8gNZYQK5vPD1cWJ/Pg=
X-Google-Smtp-Source: AGHT+IFE22RyGTWkMr2qzAybHouLq77ocfSEp5rCkN0NkOZLHfzC9zBnvM7MQPooPdmPqkFxm5DMcbWZ2PXmX6za9JE=
X-Received: by 2002:a05:6102:304a:b0:492:9e3a:9f48 with SMTP id
 ada2fe7eead31-49779892fb2mr12213168137.2.1724045549553; Sun, 18 Aug 2024
 22:32:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240815015410.369925-1-alistair.francis@wdc.com>
 <20240815015410.369925-3-alistair.francis@wdc.com>
 <c9b7b9aa-9c2e-4275-a7fb-ff994d74d3f4@ilande.co.uk>
In-Reply-To: <c9b7b9aa-9c2e-4275-a7fb-ff994d74d3f4@ilande.co.uk>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 19 Aug 2024 15:32:03 +1000
Message-ID: <CAKmqyKMr_riTX+2TdiWqkeYC_YMMZaaj55XiDgBfTx5yJ7eQsw@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/char: sifive_uart: Print uart charecters async
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: alex.bennee@linaro.org, qemu-devel@nongnu.org, peter.maydell@linaro.org, 
 dbarboza@ventanamicro.com, palmer@dabbelt.com, qemu-riscv@nongnu.org, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 zhiwei_liu@linux.alibaba.com, atishp@rivosinc.com, 
 Bin Meng <bmeng.cn@gmail.com>, liwei1518@gmail.com, 
 Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e31;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe31.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Aug 15, 2024 at 6:27=E2=80=AFPM Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> On 15/08/2024 02:54, Alistair Francis wrote:
>
> > The current approach of using qemu_chr_fe_write() and ignoring the
> > return values results in dropped charecters [1].
> >
> > Let's update the SiFive UART to use a async sifive_uart_xmit() function
> > to transmit the charecters and apply back preassure to the guest with
> > the SIFIVE_UART_TXFIFO_FULL status.
> >
> > This should avoid dropped charecters and more realisiticly model the
> > hardware.
> >
> > 1: https://gitlab.com/qemu-project/qemu/-/issues/2114
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >   include/hw/char/sifive_uart.h | 17 +++++++-
> >   hw/char/sifive_uart.c         | 81 +++++++++++++++++++++++++++++++++-=
-
> >   2 files changed, 92 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/hw/char/sifive_uart.h b/include/hw/char/sifive_uar=
t.h
> > index 7f6c79f8bd..73379457a0 100644
> > --- a/include/hw/char/sifive_uart.h
> > +++ b/include/hw/char/sifive_uart.h
> > @@ -48,9 +48,13 @@ enum {
> >       SIFIVE_UART_IP_RXWM       =3D 2  /* Receive watermark interrupt p=
ending */
> >   };
> >
> > +#define SIFIVE_UART_TXFIFO_FULL    0x80000000
> > +
> >   #define SIFIVE_UART_GET_TXCNT(txctrl)   ((txctrl >> 16) & 0x7)
> >   #define SIFIVE_UART_GET_RXCNT(rxctrl)   ((rxctrl >> 16) & 0x7)
> > +
> >   #define SIFIVE_UART_RX_FIFO_SIZE 8
> > +#define SIFIVE_UART_TX_FIFO_SIZE 8
> >
> >   #define TYPE_SIFIVE_UART "riscv.sifive.uart"
> >   OBJECT_DECLARE_SIMPLE_TYPE(SiFiveUARTState, SIFIVE_UART)
> > @@ -63,13 +67,22 @@ struct SiFiveUARTState {
> >       qemu_irq irq;
> >       MemoryRegion mmio;
> >       CharBackend chr;
> > -    uint8_t rx_fifo[SIFIVE_UART_RX_FIFO_SIZE];
> > -    uint8_t rx_fifo_len;
> > +
> > +    uint32_t txfifo;
> >       uint32_t ie;
> >       uint32_t ip;
> >       uint32_t txctrl;
> >       uint32_t rxctrl;
> >       uint32_t div;
> > +
> > +    uint8_t rx_fifo[SIFIVE_UART_RX_FIFO_SIZE];
> > +    uint8_t rx_fifo_len;
> > +
> > +    uint8_t tx_fifo[SIFIVE_UART_TX_FIFO_SIZE];
> > +    uint32_t tx_level;
> > +
> > +    QEMUTimer *fifo_trigger_handle;
> > +    uint64_t char_tx_time;
> >   };
> >
> >   SiFiveUARTState *sifive_uart_create(MemoryRegion *address_space, hwad=
dr base,
> > diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
> > index 7fc6787f69..f517500df4 100644
> > --- a/hw/char/sifive_uart.c
> > +++ b/hw/char/sifive_uart.c
> > @@ -64,6 +64,64 @@ static void sifive_uart_update_irq(SiFiveUARTState *=
s)
> >       }
> >   }
> >
> > +static gboolean sifive_uart_xmit(void *do_not_use, GIOCondition cond,
> > +                                 void *opaque)
> > +{
> > +    SiFiveUARTState *s =3D opaque;
> > +    int ret;
> > +
> > +    /* instant drain the fifo when there's no back-end */
> > +    if (!qemu_chr_fe_backend_connected(&s->chr)) {
> > +        s->tx_level =3D 0;
> > +        return G_SOURCE_REMOVE;
> > +    }
> > +
> > +    ret =3D qemu_chr_fe_write(&s->chr, s->tx_fifo, s->tx_level);
> > +
> > +    if (ret >=3D 0) {
> > +        s->tx_level -=3D ret;
> > +        memmove(s->tx_fifo, s->tx_fifo + ret, s->tx_level);
> > +    }
> > +
> > +    if (s->tx_level) {
> > +        guint r =3D qemu_chr_fe_add_watch(&s->chr, G_IO_OUT | G_IO_HUP=
,
> > +                                        sifive_uart_xmit, s);
> > +        if (!r) {
> > +            s->tx_level =3D 0;
> > +            return G_SOURCE_REMOVE;
> > +        }
> > +    }
> > +
> > +    /* Clear the TX Full bit */
> > +    if (s->tx_level !=3D SIFIVE_UART_TX_FIFO_SIZE) {
> > +        s->txfifo &=3D ~SIFIVE_UART_TXFIFO_FULL;
> > +    }
> > +
> > +    sifive_uart_update_irq(s);
> > +    return G_SOURCE_REMOVE;
> > +}
> > +
> > +static void sifive_uart_write_tx_fifo(SiFiveUARTState *s, const uint8_=
t *buf,
> > +                                      int size)
> > +{
> > +    uint64_t current_time =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> > +
> > +    if (size > SIFIVE_UART_TX_FIFO_SIZE - s->tx_level) {
> > +        size =3D SIFIVE_UART_TX_FIFO_SIZE - s->tx_level;
> > +        qemu_log_mask(LOG_GUEST_ERROR, "sifive_uart: TX FIFO overflow"=
);
> > +    }
> > +
> > +    memcpy(s->tx_fifo + s->tx_level, buf, 1);
> > +    s->tx_level +=3D 1;
> > +
> > +    if (s->tx_level =3D=3D SIFIVE_UART_TX_FIFO_SIZE) {
> > +        s->txfifo |=3D SIFIVE_UART_TXFIFO_FULL;
> > +    }
> > +
> > +    timer_mod(s->fifo_trigger_handle, current_time +
> > +              (s->char_tx_time * 4));
> > +}
> > +
> >   static uint64_t
> >   sifive_uart_read(void *opaque, hwaddr addr, unsigned int size)
> >   {
> > @@ -82,7 +140,7 @@ sifive_uart_read(void *opaque, hwaddr addr, unsigned=
 int size)
> >           return 0x80000000;
> >
> >       case SIFIVE_UART_TXFIFO:
> > -        return 0; /* Should check tx fifo */
> > +        return s->txfifo;
> >       case SIFIVE_UART_IE:
> >           return s->ie;
> >       case SIFIVE_UART_IP:
> > @@ -106,12 +164,10 @@ sifive_uart_write(void *opaque, hwaddr addr,
> >   {
> >       SiFiveUARTState *s =3D opaque;
> >       uint32_t value =3D val64;
> > -    unsigned char ch =3D value;
> >
> >       switch (addr) {
> >       case SIFIVE_UART_TXFIFO:
> > -        qemu_chr_fe_write(&s->chr, &ch, 1);
> > -        sifive_uart_update_irq(s);
> > +        sifive_uart_write_tx_fifo(s, (uint8_t *) &value, 1);
> >           return;
> >       case SIFIVE_UART_IE:
> >           s->ie =3D val64;
> > @@ -131,6 +187,13 @@ sifive_uart_write(void *opaque, hwaddr addr,
> >                     __func__, (int)addr, (int)value);
> >   }
> >
> > +static void fifo_trigger_update(void *opaque)
> > +{
> > +    SiFiveUARTState *s =3D opaque;
> > +
> > +    sifive_uart_xmit(NULL, G_IO_OUT, s);
> > +}
> > +
> >   static const MemoryRegionOps sifive_uart_ops =3D {
> >       .read =3D sifive_uart_read,
> >       .write =3D sifive_uart_write,
> > @@ -197,6 +260,9 @@ static void sifive_uart_realize(DeviceState *dev, E=
rror **errp)
> >   {
> >       SiFiveUARTState *s =3D SIFIVE_UART(dev);
> >
> > +    s->fifo_trigger_handle =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
> > +                                          fifo_trigger_update, s);
> > +
> >       qemu_chr_fe_set_handlers(&s->chr, sifive_uart_can_rx, sifive_uart=
_rx,
> >                                sifive_uart_event, sifive_uart_be_change=
, s,
> >                                NULL, true);
> > @@ -206,12 +272,19 @@ static void sifive_uart_realize(DeviceState *dev,=
 Error **errp)
> >   static void sifive_uart_reset_enter(Object *obj, ResetType type)
> >   {
> >       SiFiveUARTState *s =3D SIFIVE_UART(obj);
> > +
> > +    s->txfifo =3D 0;
> >       s->ie =3D 0;
> >       s->ip =3D 0;
> >       s->txctrl =3D 0;
> >       s->rxctrl =3D 0;
> >       s->div =3D 0;
> > +
> > +    s->tx_level =3D 0;
> >       s->rx_fifo_len =3D 0;
> > +
> > +    memset(s->rx_fifo, 0, SIFIVE_UART_RX_FIFO_SIZE);
> > +    memset(s->tx_fifo, 0, SIFIVE_UART_TX_FIFO_SIZE);
> >   }
> >
> >   static void sifive_uart_reset_hold(Object *obj, ResetType type)
>
> Have you considered using a Fifo8 here? This avoids having to manually ro=
ll your own
> FIFO implementation.

Yeah, I will convert it to a Fifo8.

Alistair

>
>
> ATB,
>
> Mark.
>

