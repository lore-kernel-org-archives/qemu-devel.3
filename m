Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8CCCD78321
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 15:08:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI81n-0000q7-ES; Mon, 02 Dec 2024 10:07:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI81l-0000pe-3M
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 10:07:57 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI81j-0001JK-55
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 10:07:56 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5d0bf77af4dso3416620a12.3
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 07:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733152073; x=1733756873; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lK3GI4m8gOCgH/D5+dV7VGvspjnGSUcM8cOyJSiglJE=;
 b=PyznQ8JelFnKhU12o5n+2F4cT81aLXLZ9MSvwJsbj7qijgg0Ada/A7v9KweHbSSwrh
 NtKcdFPIiwz6B54ev4eG+Zwnv3r3JrttllzQUC+b9z/7yY+Cis4sg2zb6Oggdh6Nw6Uh
 5iV6RuZQX0Vr793pvtnECsts/4cLXE9bVlo5dr6wywswMA2eq9a/phi49GKf5OiVlrJw
 ZDjJ492+mUH5apONBXsTuRROtnocNpO9lvMWjLdjQ9mD2sErMyfmniIfjNzx7OY1P8Ey
 4mc2n/SOSq6gz5h3lKdCt6PLAUL1kbM+0uD6UDb0f4SjaNDF9F3LoBE7In+Hk+aqbF1I
 P+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733152073; x=1733756873;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lK3GI4m8gOCgH/D5+dV7VGvspjnGSUcM8cOyJSiglJE=;
 b=rwJN6ZqPmKrIuevsvngCD3Jy0ffiaxlr80zUYibHAU1m36ZjNG2TpRvqw4Yg0TQ1yu
 /1zvTD/kijum+oVH+8Palazw0tXbSEPF6ubqw7Cj1+GPfSSoLSk7vJ6ScQWme6IWXowv
 006uljBMWGfypz1iQcq6a+1O735FwvkVGaKH+SkNPIUUimSZhSvPFvjw8LchdbNdOtQT
 PCy2WTYjaL31M5oQbRA0BHf17tbfSZ28dQZtB/lWTDDdEijEwTWlyppno4R1syLmtafC
 XrwHkajKrefCE+1ubHOxqmvHd3zxB0nCJaNP84J1Jx6LO/lKiruTSipHK6Bk+nalL80g
 TuSQ==
X-Gm-Message-State: AOJu0YwkBfvay5B/E8Osc48asvf4qjhmODJkel4eu7HICSpNqyzborvG
 XyPvWoB3rK0AZwE/6+zQeGXURwRh5XV0a0KrJjwRNK6L/q6pPLhd52XrP84xRTQQ/amNrRau/Og
 GpRjkwcbw30rHoeH12jiz/MEtURahetpNKHM6PQ==
X-Gm-Gg: ASbGncuz1xzJ3QSFx/jm31QPQnep6x3ZJfBQzBchoSWcqE2gnSjUzCrCJ3GkvNQi3nV
 +D8BxAEkStfrhWbQq3Rdz2K1ZGRQ9nWye
X-Google-Smtp-Source: AGHT+IFezel3cxYDtOXoy/2y4cQEpxH7led47x5R1cIrFpWHf86I76kEg5VxUQtHDYwza0/yOo1vPg7ay25e+24Ko0k=
X-Received: by 2002:a50:cd9d:0:b0:5d0:ca1f:2fc1 with SMTP id
 4fb4d7f45d1cf-5d0ca1f32d4mr8456141a12.23.1733152070823; Mon, 02 Dec 2024
 07:07:50 -0800 (PST)
MIME-Version: 1.0
References: <20241117225643.768322-1-ioan-cristian.cirstea@tutanota.com>
In-Reply-To: <20241117225643.768322-1-ioan-cristian.cirstea@tutanota.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Dec 2024 15:07:39 +0000
Message-ID: <CAFEAcA96j0B3=g6JwNR7zAXtWP-L6sRP6DpuwERdvDRnarPH-Q@mail.gmail.com>
Subject: Re: [PATCH 1/7] [BCM2835 AUX 1/7] Replace hard-coded FIFO
To: =?UTF-8?Q?Ioan=2DCristian_C=C3=8ERSTEA?= <jean.christian.cirstea@gmail.com>
Cc: qemu-devel@nongnu.org, 
 =?UTF-8?Q?Ioan=2DCristian_C=C3=8ERSTEA?= <ioan-cristian.cirstea@tutanota.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Sun, 17 Nov 2024 at 23:01, Ioan-Cristian C=C3=8ERSTEA
<jean.christian.cirstea@gmail.com> wrote:
>
> The previous BCM2835 mini UART implementation used a hard-coded FIFO.
> This commit changes the implementation by making use of the provided
> Fifo8.
>
> Signed-off-by: Ioan-Cristian C=C3=8ERSTEA <ioan-cristian.cirstea@tutanota=
.com>

Hi; thanks for this patchset.

For future multi-patch submissions, could you include a cover
letter email, please? Some of our automated tooling relies on
the cover letter. (No cover letter needed for single standalone
patches.) It also gives you a place to explain the purpose/aim
of the patchset.

> ---
>  hw/char/bcm2835_aux.c         | 61 ++++++++++++++++++-----------------
>  include/hw/char/bcm2835_aux.h | 10 +++---
>  2 files changed, 37 insertions(+), 34 deletions(-)
>
> diff --git a/hw/char/bcm2835_aux.c b/hw/char/bcm2835_aux.c
> index fca2f27a55..540cb30872 100644
> --- a/hw/char/bcm2835_aux.c
> +++ b/hw/char/bcm2835_aux.c
> @@ -47,14 +47,23 @@
>  #define RX_INT  0x1
>  #define TX_INT  0x2
>
> +/* FIFOs length */
> +#define BCM2835_AUX_RX_FIFO_LEN 8
> +#define BCM2835_AUX_TX_FIOF_LEN 8

Typo: "FIFO".

> +
> +/* TODO: Add separate functions for RX and TX interrupts */

Why? Usually we just have one function for this kind of
"update the outgoing interrupt state".

>  static void bcm2835_aux_update(BCM2835AuxState *s)
>  {
> +    /* TODO: this should be a pointer to const data. However, the fifo8 =
API
> +     * requires a pointer to non-const data.
> +     */

QEMU coding style for multi-line comments has the initial
"/*" on a line of its own. (There's some existing code
which is old enough that it doesn't follow the current
style guidelines; generally we leave that alone unless
it needs changing anyway, but ask for newly added code
to follow style. A rough rule of thumb is "fix stuff
that checkpatch.pl complains about in your patch", but
bear in mind that checkpatch sometimes complains about
stuff that isn't a problem.)

> +    Fifo8 *rx_fifo =3D &s->rx_fifo;
>      /* signal an interrupt if either:
>       * 1. rx interrupt is enabled and we have a non-empty rx fifo, or
>       * 2. the tx interrupt is enabled (since we instantly drain the tx f=
ifo)
>       */
>      s->iir =3D 0;
> -    if ((s->ier & RX_INT) && s->read_count !=3D 0) {
> +    if ((s->ier & RX_INT) && fifo8_is_empty(rx_fifo) =3D=3D false) {

Why the local variable when you could write
 fifo8_is_empty(&s->rx_fifo)
?

>          s->iir |=3D RX_INT;
>      }
>      if (s->ier & TX_INT) {
> @@ -66,7 +75,10 @@ static void bcm2835_aux_update(BCM2835AuxState *s)
>  static uint64_t bcm2835_aux_read(void *opaque, hwaddr offset, unsigned s=
ize)
>  {
>      BCM2835AuxState *s =3D opaque;
> -    uint32_t c, res;
> +    Fifo8 *rx_fifo =3D &s->rx_fifo;
> +    const bool is_rx_fifo_not_empty =3D !fifo8_is_empty(rx_fifo);
> +    const uint32_t rx_fifo_fill_level =3D fifo8_num_used(rx_fifo);

Do we need these?

> +    uint32_t c =3D 0, res;
>
>      switch (offset) {
>      case AUX_IRQ:
> @@ -77,12 +89,8 @@ static uint64_t bcm2835_aux_read(void *opaque, hwaddr =
offset, unsigned size)
>
>      case AUX_MU_IO_REG:
>          /* "DLAB bit set means access baudrate register" is NYI */
> -        c =3D s->read_fifo[s->read_pos];
> -        if (s->read_count > 0) {
> -            s->read_count--;
> -            if (++s->read_pos =3D=3D BCM2835_AUX_RX_FIFO_LEN) {
> -                s->read_pos =3D 0;
> -            }
> +        if (is_rx_fifo_not_empty) {

For instance here can we directly write

       if (!fifo8_is_empty(&s->rx_fifo) {
           c =3D fifo8_pop(&s->rx_fifo);
       }

That is the way other QEMU code generally does this.

> +            c =3D fifo8_pop(rx_fifo);
>          }
>          qemu_chr_fe_accept_input(&s->chr);
>          bcm2835_aux_update(s);
> @@ -98,7 +106,7 @@ static uint64_t bcm2835_aux_read(void *opaque, hwaddr =
offset, unsigned size)
>           * interrupts are active, besides that this cannot occur. At
>           * present, we choose to prioritise the rx interrupt, since
>           * the tx fifo is always empty. */
> -        if (s->read_count !=3D 0) {
> +        if (is_rx_fifo_not_empty) {
>              res |=3D 0x4;
>          } else {
>              res |=3D 0x2;
> @@ -118,7 +126,7 @@ static uint64_t bcm2835_aux_read(void *opaque, hwaddr=
 offset, unsigned size)
>
>      case AUX_MU_LSR_REG:
>          res =3D 0x60; /* tx idle, empty */
> -        if (s->read_count !=3D 0) {
> +        if (is_rx_fifo_not_empty) {
>              res |=3D 0x1;
>          }
>          return res;
> @@ -136,10 +144,10 @@ static uint64_t bcm2835_aux_read(void *opaque, hwad=
dr offset, unsigned size)
>
>      case AUX_MU_STAT_REG:
>          res =3D 0x30e; /* space in the output buffer, empty tx fifo, idl=
e tx/rx */
> -        if (s->read_count > 0) {
> +        if (is_rx_fifo_not_empty) {
>              res |=3D 0x1; /* data in input buffer */
> -            assert(s->read_count <=3D BCM2835_AUX_RX_FIFO_LEN);
> -            res |=3D ((uint32_t)s->read_count) << 16; /* rx fifo fill le=
vel */
> +            assert(rx_fifo_fill_level <=3D BCM2835_AUX_RX_FIFO_LEN);
> +            res |=3D ((uint32_t)rx_fifo_fill_level) << 16; /* rx fifo fi=
ll level */
>          }
>          return res;
>
> @@ -158,6 +166,7 @@ static void bcm2835_aux_write(void *opaque, hwaddr of=
fset, uint64_t value,
>                                unsigned size)
>  {
>      BCM2835AuxState *s =3D opaque;
> +    Fifo8 *rx_fifo =3D &s->rx_fifo;
>      unsigned char ch;
>
>      switch (offset) {
> @@ -185,7 +194,7 @@ static void bcm2835_aux_write(void *opaque, hwaddr of=
fset, uint64_t value,
>
>      case AUX_MU_IIR_REG:
>          if (value & 0x2) {
> -            s->read_count =3D 0;
> +            fifo8_reset(rx_fifo);
>          }
>          break;
>
> @@ -221,24 +230,18 @@ static int bcm2835_aux_can_receive(void *opaque)
>  {
>      BCM2835AuxState *s =3D opaque;
>
> -    return s->read_count < BCM2835_AUX_RX_FIFO_LEN;
> +    return !fifo8_is_full(&s->rx_fifo);
>  }
>
>  static void bcm2835_aux_put_fifo(void *opaque, uint8_t value)
>  {
>      BCM2835AuxState *s =3D opaque;
> -    int slot;
> +    Fifo8 *rx_fifo =3D &s->rx_fifo;
>
> -    slot =3D s->read_pos + s->read_count;
> -    if (slot >=3D BCM2835_AUX_RX_FIFO_LEN) {
> -        slot -=3D BCM2835_AUX_RX_FIFO_LEN;
> -    }
> -    s->read_fifo[slot] =3D value;
> -    s->read_count++;
> -    if (s->read_count =3D=3D BCM2835_AUX_RX_FIFO_LEN) {
> -        /* buffer full */
> +    if (fifo8_is_full(rx_fifo) =3D=3D false) {
> +        fifo8_push(rx_fifo, value);
> +        bcm2835_aux_update(s);
>      }
> -    bcm2835_aux_update(s);
>  }
>
>  static void bcm2835_aux_receive(void *opaque, const uint8_t *buf, int si=
ze)
> @@ -261,10 +264,8 @@ static const VMStateDescription vmstate_bcm2835_aux =
=3D {
>      .version_id =3D 1,
>      .minimum_version_id =3D 1,
>      .fields =3D (const VMStateField[]) {
> -        VMSTATE_UINT8_ARRAY(read_fifo, BCM2835AuxState,
> -                            BCM2835_AUX_RX_FIFO_LEN),
> -        VMSTATE_UINT8(read_pos, BCM2835AuxState),
> -        VMSTATE_UINT8(read_count, BCM2835AuxState),
> +        VMSTATE_FIFO8(rx_fifo, BCM2835AuxState),
> +        VMSTATE_FIFO8(_tx_fifo, BCM2835AuxState),
>          VMSTATE_UINT8(ier, BCM2835AuxState),
>          VMSTATE_UINT8(iir, BCM2835AuxState),
>          VMSTATE_END_OF_LIST()

If you change the vmstate you need to also bump the
version_id and minimum_version_id fields, and note in the
commit message that this is a migration-compatibility break
for the affected machine types.

> @@ -276,6 +277,8 @@ static void bcm2835_aux_init(Object *obj)
>      SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
>      BCM2835AuxState *s =3D BCM2835_AUX(obj);
>
> +    fifo8_create(&s->rx_fifo, BCM2835_AUX_RX_FIFO_LEN);
> +
>      memory_region_init_io(&s->iomem, OBJECT(s), &bcm2835_aux_ops, s,
>                            TYPE_BCM2835_AUX, 0x100);
>      sysbus_init_mmio(sbd, &s->iomem);
> diff --git a/include/hw/char/bcm2835_aux.h b/include/hw/char/bcm2835_aux.=
h
> index 9e081793a0..cb1a824994 100644
> --- a/include/hw/char/bcm2835_aux.h
> +++ b/include/hw/char/bcm2835_aux.h
> @@ -9,15 +9,14 @@
>  #ifndef BCM2835_AUX_H
>  #define BCM2835_AUX_H
>
> -#include "hw/sysbus.h"
>  #include "chardev/char-fe.h"
> +#include "hw/sysbus.h"
> +#include "qemu/fifo8.h"
>  #include "qom/object.h"
>
>  #define TYPE_BCM2835_AUX "bcm2835-aux"
>  OBJECT_DECLARE_SIMPLE_TYPE(BCM2835AuxState, BCM2835_AUX)
>
> -#define BCM2835_AUX_RX_FIFO_LEN 8
> -
>  struct BCM2835AuxState {
>      /*< private >*/
>      SysBusDevice parent_obj;
> @@ -27,8 +26,9 @@ struct BCM2835AuxState {
>      CharBackend chr;
>      qemu_irq irq;
>
> -    uint8_t read_fifo[BCM2835_AUX_RX_FIFO_LEN];
> -    uint8_t read_pos, read_count;
> +    Fifo8 rx_fifo;
> +    /* Unused for now */
> +    Fifo8 _tx_fifo;

Please don't use underscores at the start of identifiers,
and don't add fields that aren't used yet.

>      uint8_t ier, iir;
>  };

thanks
-- PMM

