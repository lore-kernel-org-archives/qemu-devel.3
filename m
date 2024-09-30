Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A7CDCEB2C9
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 21:29:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svNwk-0002iu-3c; Mon, 30 Sep 2024 17:28:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <strahinjapjankovic@gmail.com>)
 id 1svNwi-0002gs-B5; Mon, 30 Sep 2024 17:28:44 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <strahinjapjankovic@gmail.com>)
 id 1svNwe-00061t-5j; Mon, 30 Sep 2024 17:28:44 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5c88c9e45c2so3660096a12.0; 
 Mon, 30 Sep 2024 14:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727731717; x=1728336517; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FSnMSYMEpBNjLlZ8EK5cN8z+08Q/PvDJLqFw8NntJ9w=;
 b=V5ALziC+0+C4AdlxMJjpreLgXy62YU3tYNYE3oaqp5Y6l8g9Dz6R3SZMVIhJMQ3MnU
 jYL/DGZ602+QPNS3u5alYRdTw5/PfvZM5JBcgsm0GrGTFeklWILTKrR+bYjqXWRpNwcp
 CVhCEkViVCX9u13mYIdvegvdekHJb0SHeuBdAnX45/erjl3GTUr1TgZym1Ucf2SpKyCs
 vtOQftHuWAGRcblD+CA0r6voBDq2DkarMsX+241U+MB94P2rzzZeWrE6oicJuXKwZO46
 8rlfP3MBd+OZgozO6j5kDAxpn2BQ64V8I8/tzGZEdzWc94yQ5uVyFj5cYDs4tCf3LbFj
 L+SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727731717; x=1728336517;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FSnMSYMEpBNjLlZ8EK5cN8z+08Q/PvDJLqFw8NntJ9w=;
 b=J0Oh1j98uJ+CRU04dYblfs736WuUKc7R2f+eV2oQD1ZK01+qI9B4XFhhC29QveAsWc
 Q/QnGzPYMnoYNJNBCsHT4E5WjQOPeuMV9PoOSKt2rKMwCvmzU98boQYZ7ZKnStqM14sF
 NghQFEmP1Z0yp2YVH1aIxMBfYtLDF462hb8jQm3WGHTDt0Jpw9vuOB5XDEJ2NsHSEIyL
 u83fCCjeR0NB0HE1unzj0lJdaPPEIidEj1Oi901jonssJLBNSYMXOjk7uTRiTe9S4trF
 LkDwIB66p2jDFr/5iUBvL4USQiyYpii++u6dFrXVFUt2wwaaX0Y5iaaMwbEVyChrvzL9
 vj8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWk66nuybEAN1ORquTWCDmEZPiXIJCRKkrI0Gg2jbKT85luM4DKGZZyqcQcV2qsDM0JqdALCxWIud/WIQ==@nongnu.org,
 AJvYcCWlwCNTna4gTMx2i4jAAw4DfS/CIjSx232+K/xoaoMoKVuo4wnyKlBdflQtiN4Nb0/Sb9r+8SA1Hg==@nongnu.org
X-Gm-Message-State: AOJu0YzI9nuwKjx6ftozbz3P27dTbhN4Rtszdj2XtKbL8xZTKkN2s2Ku
 D5061kCjZCXnE5JmYqPeVET2KA+uK+ces/SH1aLA7EGGv15dzNsPIuyGHuzU9PnVzLmvwZTuns5
 D2whOt2lrJ9j5LkAJqXKRswm3i2XRjs/l
X-Google-Smtp-Source: AGHT+IGH4WqDlZhb0XLM14ifZLBM0j6H5kNyDm1oRp2sv6wvN6kuFF9+UIYB/PQQWaayS8THKUH186Jqhdfx1gE8ApA=
X-Received: by 2002:a05:6402:5419:b0:5c8:a2b8:cab3 with SMTP id
 4fb4d7f45d1cf-5c8a2b8ce3cmr1069849a12.4.1727731717185; Mon, 30 Sep 2024
 14:28:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240919215525.22398-1-strahinja.p.jankovic@gmail.com>
 <CAFEAcA_RkwPgTksJCEP4=V0WY0wp0OiYP28PzXDJKRvpi_KWvw@mail.gmail.com>
In-Reply-To: <CAFEAcA_RkwPgTksJCEP4=V0WY0wp0OiYP28PzXDJKRvpi_KWvw@mail.gmail.com>
From: Strahinja Jankovic <strahinjapjankovic@gmail.com>
Date: Mon, 30 Sep 2024 23:28:22 +0200
Message-ID: <CABtshVSsXPoMQy1EZaq2veo-80UMrUX+cqkvh5wq6cujW60s7A@mail.gmail.com>
Subject: Re: [PATCH] {hw/ssi,docs/system/arm}: Allwinner A10 SPI emulation
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Beniamino Galvani <b.galvani@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000045296306235ce33c"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=strahinjapjankovic@gmail.com; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--00000000000045296306235ce33c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peter,

Thank you very much for the review and detailed comments.

I will try to address all comments in the v2 of the patches, but I have
some questions I added below.

On Mon, Sep 30, 2024 at 4:45=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org>
wrote:

> On Thu, 19 Sept 2024 at 22:55, Strahinja Jankovic
> <strahinjapjankovic@gmail.com> wrote:
> >
> > This patch implements Allwinner A10 SPI controller emulation.
> > Only master-mode functionality is implemented.
> >
> > Since U-Boot and Linux SPI drivers for Allwinner A10 perform only
> > byte-wide CPU access (no DMA) to the peripheral, the emulated
> > controller does not implement DMA control and supports only byte-wide
> > access.
> >
> > Docs are also updated for Cubieboard to indicate SPI availability.
> >
> > Signed-off-by: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
>
> Hi; thanks for this patch. It generally looks good to me;
> my comments below are not major.
>
> >  docs/system/arm/cubieboard.rst     |   1 +
> >  hw/arm/Kconfig                     |   1 +
> >  hw/arm/allwinner-a10.c             |   8 +
> >  hw/ssi/Kconfig                     |   4 +
> >  hw/ssi/allwinner-a10-spi.c         | 534 +++++++++++++++++++++++++++++
> >  hw/ssi/meson.build                 |   1 +
> >  hw/ssi/trace-events                |  10 +
> >  include/hw/arm/allwinner-a10.h     |   2 +
> >  include/hw/ssi/allwinner-a10-spi.h |  56 +++
>
> For "add new device to existing board" changes we generally
> prefer them to be two commits:
>  * add the new device model
>  * wire up the device in the board model
>
> Could you split this patch in two, please?
>

Yes, I will split this into two patches.


>
> > diff --git a/hw/ssi/allwinner-a10-spi.c b/hw/ssi/allwinner-a10-spi.c
> > new file mode 100644
> > index 0000000000..ea44ae46a3
> > --- /dev/null
> > +++ b/hw/ssi/allwinner-a10-spi.c
> > @@ -0,0 +1,534 @@
> > +/*
> > + *  Allwinner SPI Bus Serial Interface Emulation
> > + *
> > + *  Copyright (C) 2024 Strahinja Jankovic <
> strahinja.p.jankovic@gmail.com>
> > + *
> > + *  This program is free software; you can redistribute it and/or
> modify it
> > + *  under the terms of the GNU General Public License as published by
> the
> > + *  Free Software Foundation; either version 2 of the License, or
> > + *  (at your option) any later version.
> > + *
> > + *  This program is distributed in the hope that it will be useful, bu=
t
> WITHOUT
> > + *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
> or
> > + *  FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public Licen=
se
> > + *  for more details.
> > + *
> > + *  You should have received a copy of the GNU General Public License
> along
> > + *  with this program; if not, see <http://www.gnu.org/licenses/>.
> > + *
> > + * SPDX-License-Identifier: MIT
>
> This SPDX tag does not match the human-readable license. We're OK with
> either GPL-2.0-or-later or MIT, but which one do you want?
>
> Also, the .h file license-and-copyright comment has no SPDX tag;
> we don't currently insist on SPDX tags, but you might wish to
> be consistent.
>

Good points, I will update this.


>
> > +/* Control register */
> > +#define SPI_CTL_SDC      (1 << 19)
> > +#define SPI_CTL_TP_EN    (1 << 18)
> > +#define SPI_CTL_SS_LEVEL (1 << 17)
> > +#define SPI_CTL_SS_CTRL  (1 << 16)
> > +#define SPI_CTL_DHB      (1 << 15)
> > +#define SPI_CTL_DDB      (1 << 14)
> > +#define SPI_CTL_SS       (3 << 12)
> > +#define SPI_CTL_SS_SHIFT (12)
> > +#define SPI_CTL_RPSM     (1 << 11)
> > +#define SPI_CTL_XCH      (1 << 10)
> > +#define SPI_CTL_RF_RST   (1 << 9)
> > +#define SPI_CTL_TF_RST   (1 << 8)
> > +#define SPI_CTL_SSCTL    (1 << 7)
> > +#define SPI_CTL_LMTF     (1 << 6)
> > +#define SPI_CTL_DMAMC    (1 << 5)
> > +#define SPI_CTL_SSPOL    (1 << 4)
> > +#define SPI_CTL_POL      (1 << 3)
> > +#define SPI_CTL_PHA      (1 << 2)
> > +#define SPI_CTL_MODE     (1 << 1)
> > +#define SPI_CTL_EN       (1 << 0)
> > +#define SPI_CTL_MASK     (0xFFFFFu)
> > +#define SPI_CTL_RESET    (0x0002001Cu)
>
> Brackets aren't necessary around single integer values,
> only around expressions.
>
>
> > +static void allwinner_a10_spi_update_irq(AWA10SPIState *s)
> > +{
> > +    int level;
> > +
> > +    if (fifo8_is_empty(&s->rx_fifo)) {
> > +        s->regs[REG_INDEX(SPI_INT_STA_REG)] &=3D ~SPI_INT_STA_RR;
> > +    } else {
> > +        s->regs[REG_INDEX(SPI_INT_STA_REG)] |=3D SPI_INT_STA_RR;
> > +    }
> > +
> > +    if (fifo8_num_used(&s->rx_fifo) >=3D (AW_A10_SPI_FIFO_SIZE >> 2)) =
{
> > +        s->regs[REG_INDEX(SPI_INT_STA_REG)] |=3D SPI_INT_STA_RF14;
> > +    } else {
> > +        s->regs[REG_INDEX(SPI_INT_STA_REG)] &=3D ~SPI_INT_STA_RF14;
> > +    }
> > +
> > +    if (fifo8_num_used(&s->rx_fifo) >=3D (AW_A10_SPI_FIFO_SIZE >> 1)) =
{
> > +        s->regs[REG_INDEX(SPI_INT_STA_REG)] |=3D SPI_INT_STA_RHF;
> > +    } else {
> > +        s->regs[REG_INDEX(SPI_INT_STA_REG)] &=3D ~SPI_INT_STA_RHF;
> > +    }
> > +
> > +    if (fifo8_num_free(&s->rx_fifo) <=3D (AW_A10_SPI_FIFO_SIZE >> 2)) =
{
> > +        s->regs[REG_INDEX(SPI_INT_STA_REG)] |=3D SPI_INT_STA_RF34;
> > +    } else {
> > +        s->regs[REG_INDEX(SPI_INT_STA_REG)] &=3D ~SPI_INT_STA_RF34;
> > +    }
> > +
> > +    if (fifo8_is_full(&s->rx_fifo)) {
> > +        s->regs[REG_INDEX(SPI_INT_STA_REG)] |=3D SPI_INT_STA_RF;
> > +    } else {
> > +        s->regs[REG_INDEX(SPI_INT_STA_REG)] &=3D ~SPI_INT_STA_RF;
> > +    }
> > +
> > +    if (fifo8_is_empty(&s->tx_fifo)) {
> > +        s->regs[REG_INDEX(SPI_INT_STA_REG)] |=3D SPI_INT_STA_TE;
> > +    } else {
> > +        s->regs[REG_INDEX(SPI_INT_STA_REG)] &=3D ~SPI_INT_STA_TE;
> > +    }
> > +
> > +    if (fifo8_num_free(&s->tx_fifo) >=3D (AW_A10_SPI_FIFO_SIZE >> 2)) =
{
> > +        s->regs[REG_INDEX(SPI_INT_STA_REG)] |=3D SPI_INT_STA_TE14;
> > +    } else {
> > +        s->regs[REG_INDEX(SPI_INT_STA_REG)] &=3D ~SPI_INT_STA_TE14;
> > +    }
> > +
> > +    if (fifo8_num_free(&s->tx_fifo) >=3D (AW_A10_SPI_FIFO_SIZE >> 1)) =
{
> > +        s->regs[REG_INDEX(SPI_INT_STA_REG)] |=3D SPI_INT_STA_THE;
> > +    } else {
> > +        s->regs[REG_INDEX(SPI_INT_STA_REG)] &=3D ~SPI_INT_STA_THE;
> > +    }
> > +
> > +    if (fifo8_num_used(&s->tx_fifo) <=3D (AW_A10_SPI_FIFO_SIZE >> 2)) =
{
> > +        s->regs[REG_INDEX(SPI_INT_STA_REG)] |=3D SPI_INT_STA_TE34;
> > +    } else {
> > +        s->regs[REG_INDEX(SPI_INT_STA_REG)] &=3D ~SPI_INT_STA_TE34;
> > +    }
> > +
> > +    if (fifo8_is_full(&s->rx_fifo)) {
> > +        s->regs[REG_INDEX(SPI_INT_STA_REG)] |=3D SPI_INT_STA_TF;
> > +    } else {
> > +        s->regs[REG_INDEX(SPI_INT_STA_REG)] &=3D ~SPI_INT_STA_TF;
> > +    }
> > +
> > +    level =3D s->regs[REG_INDEX(SPI_INT_STA_REG)] &
> > +                    s->regs[REG_INDEX(SPI_INTCTL_REG)] ?
> > +                1 :
> > +                0;
>
> If you declare 'level' as a 'bool' you can avoid this
> awkward "? 1 : 0" expression.
>
> > +
> > +    qemu_set_irq(s->irq, level);
> > +
> > +    trace_allwinner_a10_spi_update_irq(level);
> > +}
> > +
> > +static void allwinner_a10_spi_flush_txfifo(AWA10SPIState *s)
> > +{
> > +    uint8_t tx;
> > +    uint8_t rx;
> > +    uint32_t burst_count =3D s->regs[REG_INDEX(SPI_BC_REG)];
> > +    uint32_t tx_burst =3D s->regs[REG_INDEX(SPI_TC_REG)];
> > +    trace_allwinner_a10_spi_burst_length(tx_burst);
> > +
> > +
> trace_allwinner_a10_spi_flush_txfifo_begin(fifo8_num_used(&s->tx_fifo),
> > +
>  fifo8_num_used(&s->rx_fifo));
> > +
> > +    while (!fifo8_is_empty(&s->tx_fifo)) {
> > +        tx =3D fifo8_pop(&s->tx_fifo);
> > +        rx =3D 0;
> > +        bool fill_rx =3D true;
>
> Variable declarations should always go at the start of a block,
> not in the middle of one. (Since tx and rx are not used
> outside the loop, you could fix this by declaring them
> here rather than at the top of the function if you like.)
>
> > +
> > +        trace_allwinner_a10_spi_tx(tx);
> > +
> > +        /* Write one byte at a time */
> > +        rx =3D ssi_transfer(s->bus, tx);
> > +
> > +        trace_allwinner_a10_spi_rx(rx);
> > +
> > +        /* Check DHB here to determing if RX bytes should be stored */
>
> Typo: "determine"
>
> > +        if (s->regs[REG_INDEX(SPI_CTL_REG)] & SPI_CTL_DHB) {
> > +            /* Store rx bytes only after WTC transfers */
> > +            if (tx_burst > 0u) {
> > +                fill_rx =3D false;
> > +                tx_burst--;
> > +            }
> > +        }
> > +
> > +        if (fill_rx) {
> > +            if (fifo8_is_full(&s->rx_fifo)) {
> > +                s->regs[REG_INDEX(SPI_INT_STA_REG)] |=3D SPI_INT_STA_R=
F;
> > +            } else {
> > +                fifo8_push(&s->rx_fifo, rx);
> > +            }
> > +        }
> > +
> > +        allwinner_a10_spi_update_irq(s);
> > +
> > +        burst_count--;
> > +
> > +        if (burst_count =3D=3D 0) {
> > +            s->regs[REG_INDEX(SPI_INT_STA_REG)] |=3D SPI_INT_STA_TC;
> > +            s->regs[REG_INDEX(SPI_CTL_REG)] &=3D ~SPI_CTL_XCH;
> > +            break;
> > +        }
> > +    }
> > +
> > +    if (fifo8_is_empty(&s->tx_fifo)) {
> > +        s->regs[REG_INDEX(SPI_INT_STA_REG)] |=3D SPI_INT_STA_TC;
> > +        s->regs[REG_INDEX(SPI_CTL_REG)] &=3D ~SPI_CTL_XCH;
> > +    }
> > +
> > +
> trace_allwinner_a10_spi_flush_txfifo_end(fifo8_num_used(&s->tx_fifo),
> > +
>  fifo8_num_used(&s->rx_fifo));
> > +}
> > +
> > +static uint64_t allwinner_a10_spi_read(void *opaque, hwaddr offset,
> > +                                       unsigned size)
> > +{
> > +    uint32_t value =3D 0;
> > +    AWA10SPIState *s =3D opaque;
> > +    uint32_t index =3D offset >> 2;
>
> The MemoryRegionOps defines that size =3D=3D 1 is permitted,
> but this calculation of index without any validation
> of offset means that if the guest writes a byte to
> offset 1 we will treat that identically to writing a byte
> to offset 0. This probably isn't what the hardware does.
>

I checked once more the User manual, and it does not mention unaligned
access (example for RXDATA)

In 8-bits SPI bus width, this register can be accessed in byte,
half-word or word unit by AHB. In byte accessing method,
if there are words in RXFIFO, the top word is returned and
the RXFIFO depth is decreased by 1. In half-word accessing
method, the two SPI bursts are returned and the RXFIFO
depth is decrease by 2. In word accessing method, the four
SPI bursts are returned and the RXFIFO depth is decreased
by 4.

I chose not to cover the half-word and word access methods, since neither
Linux kernel nor U-Boot use it
(both use only byte access).

I guess that I could add `.valid.unaligned =3D false` when initializing
`MemoryRegionOps`?

Best regards,
Strahinja



>
> > +
> > +    if (offset > SPI_FIFO_STA_REG) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "[%s]%s: Bad register at offset 0x%" HWADDR_PRIx
> "\n",
> > +                      TYPE_AW_A10_SPI, __func__, offset);
> > +        return 0;
> > +    }
> > +
> > +    value =3D s->regs[index];
> > +
> > +    if (allwinner_a10_spi_is_enabled(s)) {
> > +        switch (offset) {
> > +        case SPI_RXDATA_REG:
> > +            if (fifo8_is_empty(&s->rx_fifo)) {
> > +                /* value is undefined */
> > +                value =3D 0xdeadbeef;
> > +            } else {
> > +                /* read from the RX FIFO */
> > +                value =3D fifo8_pop(&s->rx_fifo);
> > +            }
> > +            break;
> > +        case SPI_TXDATA_REG:
> > +            qemu_log_mask(LOG_GUEST_ERROR,
> > +                          "[%s]%s: Trying to read from TX FIFO\n",
> > +                          TYPE_AW_A10_SPI, __func__);
> > +
> > +            /* Reading from TXDATA gives 0 */
> > +            break;
> > +        case SPI_FIFO_STA_REG:
> > +            /* Read current tx/rx fifo data count */
> > +            value =3D fifo8_num_used(&s->tx_fifo) <<
> SPI_FIFO_STA_TF_CNT_SHIFT |
> > +                    fifo8_num_used(&s->rx_fifo) <<
> SPI_FIFO_STA_RF_CNT_SHIFT;
> > +        default:
> > +            break;
> > +        }
> > +
> > +        allwinner_a10_spi_update_irq(s);
> > +    }
> > +    trace_allwinner_a10_spi_read(allwinner_a10_spi_get_regname(offset)=
,
> value);
> > +
> > +    return (uint64_t)value;
>
> The cast here is unnecessary as the function return type is uint64_t.
>
> > +}
> > +
> > +static void allwinner_a10_spi_write(void *opaque, hwaddr offset,
> uint64_t value,
> > +                                    unsigned size)
> > +{
> > +    AWA10SPIState *s =3D opaque;
> > +    uint32_t index =3D offset >> 2;
>
> Similar remarks here about byte and halfword writes to
> non-4-aligned offsets.
>
> > +    int i =3D 0;
> > +
> > +    if (offset > SPI_FIFO_STA_REG) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "[%s]%s: Bad register at offset 0x%" HWADDR_PRIx
> "\n",
> > +                      TYPE_AW_A10_SPI, __func__, offset);
> > +        return;
> > +    }
> > +
> > +    trace_allwinner_a10_spi_write(allwinner_a10_spi_get_regname(offset=
),
> > +                                  (uint32_t)value);
> > +
> > +    if (!allwinner_a10_spi_is_enabled(s)) {
> > +        /* Block is disabled */
> > +        if (offset !=3D SPI_CTL_REG) {
> > +            /* Ignore access */
> > +            return;
> > +        }
> > +    }
> > +
> > +    switch (offset) {
> > +    case SPI_RXDATA_REG:
> > +        qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: Trying to write to RX
> FIFO\n",
> > +                      TYPE_AW_A10_SPI, __func__);
> > +        break;
> > +    case SPI_TXDATA_REG:
> > +        if (fifo8_is_full(&s->tx_fifo)) {
> > +            /* Ignore writes if queue is full */
> > +            break;
> > +        }
> > +
> > +        fifo8_push(&s->tx_fifo, (uint8_t)value);
> > +
> > +        break;
> > +    case SPI_INT_STA_REG:
> > +        /* Handle W1C bits - everything except SPI_INT_STA_INT_CBF. */
> > +        value &=3D ~SPI_INT_STA_INT_CBF;
> > +        s->regs[REG_INDEX(SPI_INT_STA_REG)] &=3D ~(value &
> SPI_INT_STA_MASK);
> > +        break;
> > +    case SPI_CTL_REG:
> > +        s->regs[REG_INDEX(SPI_CTL_REG)] =3D value;
> > +
> > +        for (i =3D 0; i < AW_A10_SPI_CS_LINES_NR; i++) {
> > +            qemu_set_irq(
> > +                s->cs_lines[i],
> > +                i =3D=3D allwinner_a10_spi_selected_channel(s) ?
> > +                    !!(s->regs[REG_INDEX(SPI_CTL_REG)] &
> SPI_CTL_SS_LEVEL) :
> > +                    !(s->regs[REG_INDEX(SPI_CTL_REG)] & SPI_CTL_SSPOL)=
);
>
> This might be easier to read if we factored out the ?:
> expression into a function with a descriptive name.
>
> > +        }
> > +
> > +        if (s->regs[REG_INDEX(SPI_CTL_REG)] & SPI_CTL_XCH) {
> > +            /* Request to start emitting */
> > +            allwinner_a10_spi_flush_txfifo(s);
> > +        }
> > +        if (s->regs[REG_INDEX(SPI_CTL_REG)] & SPI_CTL_TF_RST) {
> > +            allwinner_a10_spi_txfifo_reset(s);
> > +            s->regs[REG_INDEX(SPI_CTL_REG)] &=3D ~SPI_CTL_TF_RST;
> > +        }
> > +        if (s->regs[REG_INDEX(SPI_CTL_REG)] & SPI_CTL_RF_RST) {
> > +            allwinner_a10_spi_rxfifo_reset(s);
> > +            s->regs[REG_INDEX(SPI_CTL_REG)] &=3D ~SPI_CTL_RF_RST;
> > +        }
> > +        break;
> > +    default:
> > +        s->regs[index] =3D value;
> > +        break;
> > +    }
> > +
> > +    allwinner_a10_spi_update_irq(s);
> > +}
> > +
> > +static const MemoryRegionOps allwinner_a10_spi_ops =3D {
> > +    .read =3D allwinner_a10_spi_read,
> > +    .write =3D allwinner_a10_spi_write,
> > +    .valid.min_access_size =3D 1,
> > +    .valid.max_access_size =3D 4,
> > +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> > +};
> > +
> > +static const VMStateDescription allwinner_a10_spi_vmstate =3D {
> > +    .name =3D TYPE_AW_A10_SPI,
> > +    .version_id =3D 1,
> > +    .minimum_version_id =3D 1,
> > +    .fields =3D
> > +        (const VMStateField[]){
> > +            VMSTATE_FIFO8(tx_fifo, AWA10SPIState),
> > +            VMSTATE_FIFO8(rx_fifo, AWA10SPIState),
> > +            VMSTATE_UINT32_ARRAY(regs, AWA10SPIState,
> AW_A10_SPI_REGS_NUM),
> > +            VMSTATE_END_OF_LIST() }
>
> Our usual indent for this is
>     .fields =3D (const VMStateField[]) {
>          VMSTATE_FOO(...),
>          ...
>          VMSTATE_END_OF_LIST()
>     }

> +};
> > +
>
> > --- a/hw/ssi/trace-events
> > +++ b/hw/ssi/trace-events
> > @@ -53,3 +53,13 @@ pnv_spi_rx_read_N2frame(void) ""
> >  pnv_spi_shift_rx(uint8_t byte, uint32_t index) "byte =3D 0x%2.2x into =
RDR
> from payload index %d"
> >  pnv_spi_sequencer_stop_requested(const char* reason) "due to %s"
> >  pnv_spi_RDR_match(const char* result) "%s"
> > +
> > +# allwinner_a10_spi.c
> > +allwinner_a10_spi_update_irq(uint32_t level) "IRQ level is %d"
> > +allwinner_a10_spi_flush_txfifo_begin(uint32_t tx, uint32_t rx) "Begin:
> TX Fifo Size =3D %d, RX Fifo Size =3D %d"
> > +allwinner_a10_spi_flush_txfifo_end(uint32_t tx, uint32_t rx) "End: TX
> Fifo Size =3D %d, RX Fifo Size =3D %d"
> > +allwinner_a10_spi_burst_length(uint32_t len) "Burst length =3D %d"
> > +allwinner_a10_spi_tx(uint8_t byte) "write 0x%02x"
> > +allwinner_a10_spi_rx(uint8_t byte) "read 0x%02x"
> > +allwinner_a10_spi_read(const char* regname, uint32_t value) "reg[%s] =
=3D>
> 0x%" PRIx32
> > +allwinner_a10_spi_write(const char* regname, uint32_t value) "reg[%s]
> <=3D 0x%" PRIx32
>
> Be consistent about whether you want to use PRI* macros
> for uint32_t types or not, please. (Admittedly QEMU itself is
> not super consistent here either, but I think the more common
> option is to use %d, %x etc for uint32_t, because we can assume
> that 'int' is a 32-bit type. It's only uint64_t that requires the
> PRI macros.)
>
> thanks
> -- PMM
>

--00000000000045296306235ce33c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Peter,<div><br></div><div>Thank you ve=
ry much for the review and detailed comments.</div><div><br></div><div>I wi=
ll try to address all comments in the v2 of the patches, but I have some qu=
estions I added below.</div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Mon, Sep 30, 2024 at 4:45=E2=80=AFPM Peter=
 Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org" target=3D"_blank">=
peter.maydell@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">On Thu, 19 Sept 2024 at 22:55, Strahinja Jankovic<b=
r>
&lt;<a href=3D"mailto:strahinjapjankovic@gmail.com" target=3D"_blank">strah=
injapjankovic@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; This patch implements Allwinner A10 SPI controller emulation.<br>
&gt; Only master-mode functionality is implemented.<br>
&gt;<br>
&gt; Since U-Boot and Linux SPI drivers for Allwinner A10 perform only<br>
&gt; byte-wide CPU access (no DMA) to the peripheral, the emulated<br>
&gt; controller does not implement DMA control and supports only byte-wide<=
br>
&gt; access.<br>
&gt;<br>
&gt; Docs are also updated for Cubieboard to indicate SPI availability.<br>
&gt;<br>
&gt; Signed-off-by: Strahinja Jankovic &lt;<a href=3D"mailto:strahinja.p.ja=
nkovic@gmail.com" target=3D"_blank">strahinja.p.jankovic@gmail.com</a>&gt;<=
br>
<br>
Hi; thanks for this patch. It generally looks good to me;<br>
my comments below are not major.<br>
<br>
&gt;=C2=A0 docs/system/arm/cubieboard.rst=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0=
1 +<br>
&gt;=C2=A0 hw/arm/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 hw/arm/allwinner-a10.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 =C2=A08 +<br>
&gt;=C2=A0 hw/ssi/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A04 +<br>
&gt;=C2=A0 hw/ssi/allwinner-a10-spi.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 53=
4 +++++++++++++++++++++++++++++<br>
&gt;=C2=A0 hw/ssi/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 hw/ssi/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 10 +<br>
&gt;=C2=A0 include/hw/arm/allwinner-a10.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0=
2 +<br>
&gt;=C2=A0 include/hw/ssi/allwinner-a10-spi.h |=C2=A0 56 +++<br>
<br>
For &quot;add new device to existing board&quot; changes we generally<br>
prefer them to be two commits:<br>
=C2=A0* add the new device model<br>
=C2=A0* wire up the device in the board model<br>
<br>
Could you split this patch in two, please?<br></blockquote><div><br></div><=
div>Yes, I will split this into two patches.</div><div>=C2=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; diff --git a/hw/ssi/allwinner-a10-spi.c b/hw/ssi/allwinner-a10-spi.c<b=
r>
&gt; new file mode 100644<br>
&gt; index 0000000000..ea44ae46a3<br>
&gt; --- /dev/null<br>
&gt; +++ b/hw/ssi/allwinner-a10-spi.c<br>
&gt; @@ -0,0 +1,534 @@<br>
&gt; +/*<br>
&gt; + *=C2=A0 Allwinner SPI Bus Serial Interface Emulation<br>
&gt; + *<br>
&gt; + *=C2=A0 Copyright (C) 2024 Strahinja Jankovic &lt;<a href=3D"mailto:=
strahinja.p.jankovic@gmail.com" target=3D"_blank">strahinja.p.jankovic@gmai=
l.com</a>&gt;<br>
&gt; + *<br>
&gt; + *=C2=A0 This program is free software; you can redistribute it and/o=
r modify it<br>
&gt; + *=C2=A0 under the terms of the GNU General Public License as publish=
ed by the<br>
&gt; + *=C2=A0 Free Software Foundation; either version 2 of the License, o=
r<br>
&gt; + *=C2=A0 (at your option) any later version.<br>
&gt; + *<br>
&gt; + *=C2=A0 This program is distributed in the hope that it will be usef=
ul, but WITHOUT<br>
&gt; + *=C2=A0 ANY WARRANTY; without even the implied warranty of MERCHANTA=
BILITY or<br>
&gt; + *=C2=A0 FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public=
 License<br>
&gt; + *=C2=A0 for more details.<br>
&gt; + *<br>
&gt; + *=C2=A0 You should have received a copy of the GNU General Public Li=
cense along<br>
&gt; + *=C2=A0 with this program; if not, see &lt;<a href=3D"http://www.gnu=
.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.org/lic=
enses/</a>&gt;.<br>
&gt; + *<br>
&gt; + * SPDX-License-Identifier: MIT<br>
<br>
This SPDX tag does not match the human-readable license. We&#39;re OK with<=
br>
either GPL-2.0-or-later or MIT, but which one do you want?<br>
<br>
Also, the .h file license-and-copyright comment has no SPDX tag;<br>
we don&#39;t currently insist on SPDX tags, but you might wish to<br>
be consistent.<br></blockquote><div><br></div><div>Good points, I will upda=
te this.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
<br>
&gt; +/* Control register */<br>
&gt; +#define SPI_CTL_SDC=C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; 19)<br>
&gt; +#define SPI_CTL_TP_EN=C2=A0 =C2=A0 (1 &lt;&lt; 18)<br>
&gt; +#define SPI_CTL_SS_LEVEL (1 &lt;&lt; 17)<br>
&gt; +#define SPI_CTL_SS_CTRL=C2=A0 (1 &lt;&lt; 16)<br>
&gt; +#define SPI_CTL_DHB=C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; 15)<br>
&gt; +#define SPI_CTL_DDB=C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; 14)<br>
&gt; +#define SPI_CTL_SS=C2=A0 =C2=A0 =C2=A0 =C2=A0(3 &lt;&lt; 12)<br>
&gt; +#define SPI_CTL_SS_SHIFT (12)<br>
&gt; +#define SPI_CTL_RPSM=C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; 11)<br>
&gt; +#define SPI_CTL_XCH=C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; 10)<br>
&gt; +#define SPI_CTL_RF_RST=C2=A0 =C2=A0(1 &lt;&lt; 9)<br>
&gt; +#define SPI_CTL_TF_RST=C2=A0 =C2=A0(1 &lt;&lt; 8)<br>
&gt; +#define SPI_CTL_SSCTL=C2=A0 =C2=A0 (1 &lt;&lt; 7)<br>
&gt; +#define SPI_CTL_LMTF=C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; 6)<br>
&gt; +#define SPI_CTL_DMAMC=C2=A0 =C2=A0 (1 &lt;&lt; 5)<br>
&gt; +#define SPI_CTL_SSPOL=C2=A0 =C2=A0 (1 &lt;&lt; 4)<br>
&gt; +#define SPI_CTL_POL=C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; 3)<br>
&gt; +#define SPI_CTL_PHA=C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; 2)<br>
&gt; +#define SPI_CTL_MODE=C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; 1)<br>
&gt; +#define SPI_CTL_EN=C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; 0)<br>
&gt; +#define SPI_CTL_MASK=C2=A0 =C2=A0 =C2=A0(0xFFFFFu)<br>
&gt; +#define SPI_CTL_RESET=C2=A0 =C2=A0 (0x0002001Cu)<br>
<br>
Brackets aren&#39;t necessary around single integer values,<br>
only around expressions.<br>
<br>
<br>
&gt; +static void allwinner_a10_spi_update_irq(AWA10SPIState *s)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 int level;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (fifo8_is_empty(&amp;s-&gt;rx_fifo)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(SPI_INT_STA_REG)] &a=
mp;=3D ~SPI_INT_STA_RR;<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(SPI_INT_STA_REG)] |=
=3D SPI_INT_STA_RR;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (fifo8_num_used(&amp;s-&gt;rx_fifo) &gt;=3D (AW_A10_=
SPI_FIFO_SIZE &gt;&gt; 2)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(SPI_INT_STA_REG)] |=
=3D SPI_INT_STA_RF14;<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(SPI_INT_STA_REG)] &a=
mp;=3D ~SPI_INT_STA_RF14;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (fifo8_num_used(&amp;s-&gt;rx_fifo) &gt;=3D (AW_A10_=
SPI_FIFO_SIZE &gt;&gt; 1)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(SPI_INT_STA_REG)] |=
=3D SPI_INT_STA_RHF;<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(SPI_INT_STA_REG)] &a=
mp;=3D ~SPI_INT_STA_RHF;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (fifo8_num_free(&amp;s-&gt;rx_fifo) &lt;=3D (AW_A10_=
SPI_FIFO_SIZE &gt;&gt; 2)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(SPI_INT_STA_REG)] |=
=3D SPI_INT_STA_RF34;<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(SPI_INT_STA_REG)] &a=
mp;=3D ~SPI_INT_STA_RF34;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (fifo8_is_full(&amp;s-&gt;rx_fifo)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(SPI_INT_STA_REG)] |=
=3D SPI_INT_STA_RF;<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(SPI_INT_STA_REG)] &a=
mp;=3D ~SPI_INT_STA_RF;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (fifo8_is_empty(&amp;s-&gt;tx_fifo)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(SPI_INT_STA_REG)] |=
=3D SPI_INT_STA_TE;<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(SPI_INT_STA_REG)] &a=
mp;=3D ~SPI_INT_STA_TE;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (fifo8_num_free(&amp;s-&gt;tx_fifo) &gt;=3D (AW_A10_=
SPI_FIFO_SIZE &gt;&gt; 2)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(SPI_INT_STA_REG)] |=
=3D SPI_INT_STA_TE14;<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(SPI_INT_STA_REG)] &a=
mp;=3D ~SPI_INT_STA_TE14;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (fifo8_num_free(&amp;s-&gt;tx_fifo) &gt;=3D (AW_A10_=
SPI_FIFO_SIZE &gt;&gt; 1)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(SPI_INT_STA_REG)] |=
=3D SPI_INT_STA_THE;<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(SPI_INT_STA_REG)] &a=
mp;=3D ~SPI_INT_STA_THE;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (fifo8_num_used(&amp;s-&gt;tx_fifo) &lt;=3D (AW_A10_=
SPI_FIFO_SIZE &gt;&gt; 2)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(SPI_INT_STA_REG)] |=
=3D SPI_INT_STA_TE34;<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(SPI_INT_STA_REG)] &a=
mp;=3D ~SPI_INT_STA_TE34;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (fifo8_is_full(&amp;s-&gt;rx_fifo)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(SPI_INT_STA_REG)] |=
=3D SPI_INT_STA_TF;<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(SPI_INT_STA_REG)] &a=
mp;=3D ~SPI_INT_STA_TF;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 level =3D s-&gt;regs[REG_INDEX(SPI_INT_STA_REG)] &amp;<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 s-&gt;regs[REG_INDEX(SPI_INTCTL_REG)] ?<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1 :<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0;<br>
<br>
If you declare &#39;level&#39; as a &#39;bool&#39; you can avoid this<br>
awkward &quot;? 1 : 0&quot; expression.<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qemu_set_irq(s-&gt;irq, level);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 trace_allwinner_a10_spi_update_irq(level);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void allwinner_a10_spi_flush_txfifo(AWA10SPIState *s)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 uint8_t tx;<br>
&gt; +=C2=A0 =C2=A0 uint8_t rx;<br>
&gt; +=C2=A0 =C2=A0 uint32_t burst_count =3D s-&gt;regs[REG_INDEX(SPI_BC_RE=
G)];<br>
&gt; +=C2=A0 =C2=A0 uint32_t tx_burst =3D s-&gt;regs[REG_INDEX(SPI_TC_REG)]=
;<br>
&gt; +=C2=A0 =C2=A0 trace_allwinner_a10_spi_burst_length(tx_burst);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 trace_allwinner_a10_spi_flush_txfifo_begin(fifo8_num_us=
ed(&amp;s-&gt;tx_fifo),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0fifo8_num_used(&amp;s-&gt;rx_fifo));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 while (!fifo8_is_empty(&amp;s-&gt;tx_fifo)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tx =3D fifo8_pop(&amp;s-&gt;tx_fifo);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 rx =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool fill_rx =3D true;<br>
<br>
Variable declarations should always go at the start of a block,<br>
not in the middle of one. (Since tx and rx are not used<br>
outside the loop, you could fix this by declaring them<br>
here rather than at the top of the function if you like.)<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_allwinner_a10_spi_tx(tx);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Write one byte at a time */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 rx =3D ssi_transfer(s-&gt;bus, tx);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_allwinner_a10_spi_rx(rx);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Check DHB here to determing if RX byte=
s should be stored */<br>
<br>
Typo: &quot;determine&quot;<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;regs[REG_INDEX(SPI_CTL_REG)] &a=
mp; SPI_CTL_DHB) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Store rx bytes only afte=
r WTC transfers */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tx_burst &gt; 0u) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fill_rx =3D f=
alse;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tx_burst--;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fill_rx) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fifo8_is_full(&amp;s-&g=
t;rx_fifo)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[RE=
G_INDEX(SPI_INT_STA_REG)] |=3D SPI_INT_STA_RF;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fifo8_push(&a=
mp;s-&gt;rx_fifo, rx);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 allwinner_a10_spi_update_irq(s);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 burst_count--;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (burst_count =3D=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(SPI_IN=
T_STA_REG)] |=3D SPI_INT_STA_TC;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(SPI_CT=
L_REG)] &amp;=3D ~SPI_CTL_XCH;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (fifo8_is_empty(&amp;s-&gt;tx_fifo)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(SPI_INT_STA_REG)] |=
=3D SPI_INT_STA_TC;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(SPI_CTL_REG)] &amp;=
=3D ~SPI_CTL_XCH;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 trace_allwinner_a10_spi_flush_txfifo_end(fifo8_num_used=
(&amp;s-&gt;tx_fifo),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0fifo8_num_used(&amp;s-&gt;rx_fifo));<br>
&gt; +}<br>
&gt; +<br>
&gt; +static uint64_t allwinner_a10_spi_read(void *opaque, hwaddr offset,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsig=
ned size)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 uint32_t value =3D 0;<br>
&gt; +=C2=A0 =C2=A0 AWA10SPIState *s =3D opaque;<br>
&gt; +=C2=A0 =C2=A0 uint32_t index =3D offset &gt;&gt; 2;<br>
<br>
The MemoryRegionOps defines that size =3D=3D 1 is permitted,<br>
but this calculation of index without any validation<br>
of offset means that if the guest writes a byte to<br>
offset 1 we will treat that identically to writing a byte<br>
to offset 0. This probably isn&#39;t what the hardware does.<br></blockquot=
e><div><br></div><div>I checked once more the User manual, and it does not =
mention unaligned access (example for RXDATA)</div><div><br></div>In 8-bits=
 SPI bus width, this register can be accessed in byte, <br>half-word or wor=
d unit by AHB. In byte accessing method, <br>if there are words in RXFIFO, =
the top word is returned and <br>the RXFIFO depth is decreased by 1. In hal=
f-word accessing <br>method, the two SPI bursts are returned and the RXFIFO=
 <br>depth is decrease by 2. In word accessing method, the four <br>SPI bur=
sts are returned and the RXFIFO depth is decreased <br><div>by 4.</div><div=
><br></div><div>I chose not to cover the half-word and word access methods,=
 since neither Linux kernel nor U-Boot use it</div><div>(both use only byte=
 access).</div><div><br></div><div>I guess that I could add `.valid.unalign=
ed =3D false` when initializing `MemoryRegionOps`?</div><div><br></div><div=
>Best regards,</div><div>Strahinja</div><div><br></div><div>=C2=A0</div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (offset &gt; SPI_FIFO_STA_REG) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 &quot;[%s]%s: Bad register at offset 0x%&quot; HWADDR_PRIx &quot;\n=
&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 TYPE_AW_A10_SPI, __func__, offset);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 value =3D s-&gt;regs[index];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (allwinner_a10_spi_is_enabled(s)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (offset) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case SPI_RXDATA_REG:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fifo8_is_empty(&amp;s-&=
gt;rx_fifo)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* value is u=
ndefined */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 value =3D 0xd=
eadbeef;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* read from =
the RX FIFO */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 value =3D fif=
o8_pop(&amp;s-&gt;rx_fifo);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case SPI_TXDATA_REG:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERR=
OR,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 &quot;[%s]%s: Trying to read from TX FIFO\n&quot;,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 TYPE_AW_A10_SPI, __func__);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Reading from TXDATA give=
s 0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case SPI_FIFO_STA_REG:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Read current tx/rx fifo =
data count */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 value =3D fifo8_num_used(&a=
mp;s-&gt;tx_fifo) &lt;&lt; SPI_FIFO_STA_TF_CNT_SHIFT |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 fifo8_num_used(&amp;s-&gt;rx_fifo) &lt;&lt; SPI_FIFO_STA_RF_CNT_SHIFT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 allwinner_a10_spi_update_irq(s);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 trace_allwinner_a10_spi_read(allwinner_a10_spi_get_regn=
ame(offset), value);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return (uint64_t)value;<br>
<br>
The cast here is unnecessary as the function return type is uint64_t.<br>
<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void allwinner_a10_spi_write(void *opaque, hwaddr offset, uint=
64_t value,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned size)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AWA10SPIState *s =3D opaque;<br>
&gt; +=C2=A0 =C2=A0 uint32_t index =3D offset &gt;&gt; 2;<br>
<br>
Similar remarks here about byte and halfword writes to<br>
non-4-aligned offsets.<br>
<br>
&gt; +=C2=A0 =C2=A0 int i =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (offset &gt; SPI_FIFO_STA_REG) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 &quot;[%s]%s: Bad register at offset 0x%&quot; HWADDR_PRIx &quot;\n=
&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 TYPE_AW_A10_SPI, __func__, offset);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 trace_allwinner_a10_spi_write(allwinner_a10_spi_get_reg=
name(offset),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (uint32_t)value);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!allwinner_a10_spi_is_enabled(s)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Block is disabled */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (offset !=3D SPI_CTL_REG) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Ignore access */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 switch (offset) {<br>
&gt; +=C2=A0 =C2=A0 case SPI_RXDATA_REG:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;[%s]=
%s: Trying to write to RX FIFO\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 TYPE_AW_A10_SPI, __func__);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case SPI_TXDATA_REG:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fifo8_is_full(&amp;s-&gt;tx_fifo)) {<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Ignore writes if queue i=
s full */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 fifo8_push(&amp;s-&gt;tx_fifo, (uint8_t)v=
alue);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case SPI_INT_STA_REG:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Handle W1C bits - everything except SP=
I_INT_STA_INT_CBF. */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 value &amp;=3D ~SPI_INT_STA_INT_CBF;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(SPI_INT_STA_REG)] &a=
mp;=3D ~(value &amp; SPI_INT_STA_MASK);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case SPI_CTL_REG:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(SPI_CTL_REG)] =3D va=
lue;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; AW_A10_SPI_CS_LINES_=
NR; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_set_irq(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;cs_line=
s[i],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i =3D=3D allw=
inner_a10_spi_selected_channel(s) ?<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 !!(s-&gt;regs[REG_INDEX(SPI_CTL_REG)] &amp; SPI_CTL_SS_LEVEL) :<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 !(s-&gt;regs[REG_INDEX(SPI_CTL_REG)] &amp; SPI_CTL_SSPOL));<br>
<br>
This might be easier to read if we factored out the ?:<br>
expression into a function with a descriptive name.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;regs[REG_INDEX(SPI_CTL_REG)] &a=
mp; SPI_CTL_XCH) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Request to start emittin=
g */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 allwinner_a10_spi_flush_txf=
ifo(s);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;regs[REG_INDEX(SPI_CTL_REG)] &a=
mp; SPI_CTL_TF_RST) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 allwinner_a10_spi_txfifo_re=
set(s);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(SPI_CT=
L_REG)] &amp;=3D ~SPI_CTL_TF_RST;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;regs[REG_INDEX(SPI_CTL_REG)] &a=
mp; SPI_CTL_RF_RST) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 allwinner_a10_spi_rxfifo_re=
set(s);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(SPI_CT=
L_REG)] &amp;=3D ~SPI_CTL_RF_RST;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[index] =3D value;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 allwinner_a10_spi_update_irq(s);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const MemoryRegionOps allwinner_a10_spi_ops =3D {<br>
&gt; +=C2=A0 =C2=A0 .read =3D allwinner_a10_spi_read,<br>
&gt; +=C2=A0 =C2=A0 .write =3D allwinner_a10_spi_write,<br>
&gt; +=C2=A0 =C2=A0 .valid.min_access_size =3D 1,<br>
&gt; +=C2=A0 =C2=A0 .valid.max_access_size =3D 4,<br>
&gt; +=C2=A0 =C2=A0 .endianness =3D DEVICE_NATIVE_ENDIAN,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const VMStateDescription allwinner_a10_spi_vmstate =3D {<br>
&gt; +=C2=A0 =C2=A0 .name =3D TYPE_AW_A10_SPI,<br>
&gt; +=C2=A0 =C2=A0 .version_id =3D 1,<br>
&gt; +=C2=A0 =C2=A0 .minimum_version_id =3D 1,<br>
&gt; +=C2=A0 =C2=A0 .fields =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 (const VMStateField[]){<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_FIFO8(tx_fifo, AWA1=
0SPIState),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_FIFO8(rx_fifo, AWA1=
0SPIState),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32_ARRAY(regs, =
AWA10SPIState, AW_A10_SPI_REGS_NUM),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_END_OF_LIST() }<br>
<br>
Our usual indent for this is<br>
=C2=A0 =C2=A0 .fields =3D (const VMStateField[]) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VMSTATE_FOO(...),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0...<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VMSTATE_END_OF_LIST()<br>
=C2=A0 =C2=A0 }=C2=A0</blockquote><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
&gt; +};<br>
&gt; +<br>
<br>
&gt; --- a/hw/ssi/trace-events<br>
&gt; +++ b/hw/ssi/trace-events<br>
&gt; @@ -53,3 +53,13 @@ pnv_spi_rx_read_N2frame(void) &quot;&quot;<br>
&gt;=C2=A0 pnv_spi_shift_rx(uint8_t byte, uint32_t index) &quot;byte =3D 0x=
%2.2x into RDR from payload index %d&quot;<br>
&gt;=C2=A0 pnv_spi_sequencer_stop_requested(const char* reason) &quot;due t=
o %s&quot;<br>
&gt;=C2=A0 pnv_spi_RDR_match(const char* result) &quot;%s&quot;<br>
&gt; +<br>
&gt; +# allwinner_a10_spi.c<br>
&gt; +allwinner_a10_spi_update_irq(uint32_t level) &quot;IRQ level is %d&qu=
ot;<br>
&gt; +allwinner_a10_spi_flush_txfifo_begin(uint32_t tx, uint32_t rx) &quot;=
Begin: TX Fifo Size =3D %d, RX Fifo Size =3D %d&quot;<br>
&gt; +allwinner_a10_spi_flush_txfifo_end(uint32_t tx, uint32_t rx) &quot;En=
d: TX Fifo Size =3D %d, RX Fifo Size =3D %d&quot;<br>
&gt; +allwinner_a10_spi_burst_length(uint32_t len) &quot;Burst length =3D %=
d&quot;<br>
&gt; +allwinner_a10_spi_tx(uint8_t byte) &quot;write 0x%02x&quot;<br>
&gt; +allwinner_a10_spi_rx(uint8_t byte) &quot;read 0x%02x&quot;<br>
&gt; +allwinner_a10_spi_read(const char* regname, uint32_t value) &quot;reg=
[%s] =3D&gt; 0x%&quot; PRIx32<br>
&gt; +allwinner_a10_spi_write(const char* regname, uint32_t value) &quot;re=
g[%s] &lt;=3D 0x%&quot; PRIx32<br>
<br>
Be consistent about whether you want to use PRI* macros<br>
for uint32_t types or not, please. (Admittedly QEMU itself is<br>
not super consistent here either, but I think the more common<br>
option is to use %d, %x etc for uint32_t, because we can assume<br>
that &#39;int&#39; is a 32-bit type. It&#39;s only uint64_t that requires t=
he<br>
PRI macros.)<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div></div>

--00000000000045296306235ce33c--

