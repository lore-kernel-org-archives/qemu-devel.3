Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56576D7832F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 15:30:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI8Ma-0004Ou-AT; Mon, 02 Dec 2024 10:29:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI8MY-0004Ok-HX
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 10:29:26 -0500
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI8MW-0007kg-4S
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 10:29:26 -0500
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2ffa97d99d6so46211851fa.1
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 07:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733153361; x=1733758161; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2pRwQKRAeH+gi72LO152/CPr1DqppsF29d5iSSizuOw=;
 b=LrlbfadxMeSyl3wTwBrCc+xY+/I9ock8+Kg/IV8niruFKBL59nWQnv8aQl+MzfcGSE
 /V6JKYGt3Y0a5z9YSz6QpixbUpgdMjgCUb2e9rew/fjWehapI4HXPSQIa65iLsJiCO81
 avQEQ26eEJB0NlaQLh+PJzt8OiJO75/zVO550n3DK9mDpWaHvtm2+xMglDUI31YOIYUv
 Ec/oMx6Ydz1LQACVOFZugvVvRd3e6fVseHxx+uKhCsvrMqFwj1cTp6pWAF9Y/IusC7PE
 N7/bbkZ/brttbsdyC/0Y91aomN4vABzE5nXeNQKdiio0ivQo6adzRO7XqmaN0YhG2NvV
 OJ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733153361; x=1733758161;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2pRwQKRAeH+gi72LO152/CPr1DqppsF29d5iSSizuOw=;
 b=KGuCf95zo6kxoKbVjUedq/xJj579g/tZchrcIphL0sGy2ZgvM05vS3raSulacyWf3B
 qNnTiL3vniEGDBixLoyj3ksGQZEHqGwzUkPKK5rjHSm7fENF6+NNjefL1tnaQJIt1bJB
 ySSkFVxJMtabEcmW1zFNBjYAHc79ClvmSvTY8Uhcaga7vKyWSwxXk1Zj9maEOfDRwODQ
 34+Fm0JOElDcyqtTMaMgV0PHC86IQc9XIpBqS6a0aMblR7vsTORkncz8WP3YfZiE1S4x
 QtnYzW8biWz6i+5NBULRSpzZry5XB6XOjFaRsmeMhNO9U0Gr73UKq7EhOD/9n7p/+rwT
 rADg==
X-Gm-Message-State: AOJu0YyAcOfezqTYEnSP8qZcZ+j3EGI4ejq8WvO28One72IBfgQgsZyP
 ZzI9seuM3VvxIr3iaRagUYUQ4zqeGWYUicWEWN1fKpG+CFYnMltOYAm5RBm2HP3pWg5iHaOIlPD
 AgoIrYM4VetnOUxyELMvBJ8wEIREU1AhI1s6KdKq7vxFq90Y1
X-Gm-Gg: ASbGncvRH9Pxma67Xoa/OvduHmvhWtwM+exatsMkow7Z6Ib0ZpFMS6byzls8mn7bHCv
 x8M15xX1WikHSjqgh5Mj6vJsHDqXOLHJu
X-Google-Smtp-Source: AGHT+IHtulK2WA+wZaD0s2uzoIMCUTVCsig62VZDEQ4pqJxvkl/82UgkEEr0JO+hVzi1VJf3ZSygrvlVSwPOalQFZNE=
X-Received: by 2002:a2e:be0d:0:b0:2ff:ce85:8c98 with SMTP id
 38308e7fff4ca-2ffd61429e7mr153475811fa.33.1733153360498; Mon, 02 Dec 2024
 07:29:20 -0800 (PST)
MIME-Version: 1.0
References: <20241117225643.768322-1-ioan-cristian.cirstea@tutanota.com>
 <20241117225643.768322-3-ioan-cristian.cirstea@tutanota.com>
In-Reply-To: <20241117225643.768322-3-ioan-cristian.cirstea@tutanota.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Dec 2024 15:29:09 +0000
Message-ID: <CAFEAcA8UdNagtbu96WZcEFsreh+xFwOYaNRvDAfWocnipEXBsQ@mail.gmail.com>
Subject: Re: [PATCH 3/7] [BCM2835 AUX 3/7] Asynchronous transmit
To: =?UTF-8?Q?Ioan=2DCristian_C=C3=8ERSTEA?= <jean.christian.cirstea@gmail.com>
Cc: qemu-devel@nongnu.org, 
 =?UTF-8?Q?Ioan=2DCristian_C=C3=8ERSTEA?= <ioan-cristian.cirstea@tutanota.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x236.google.com
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
> This commit changes data transmission: instead of using the blocking
> function `qemu_chr_fe_write_all()`, the transmit logic using the
> asynchronous counterpart `qemu_chr_fe_write()`.

This is a nice cleanup -- it's nice to reduce the number
of old serial devices we have that are still using the
blocking write.

> Signed-off-by: Ioan-Cristian C=C3=8ERSTEA <ioan-cristian.cirstea@tutanota=
.com>
> ---
>  hw/char/bcm2835_aux.c         | 110 ++++++++++++++++++++++++++++++----
>  include/hw/char/bcm2835_aux.h |   5 +-
>  2 files changed, 101 insertions(+), 14 deletions(-)
>
> diff --git a/hw/char/bcm2835_aux.c b/hw/char/bcm2835_aux.c
> index ebc7f5ade5..2ef3459566 100644
> --- a/hw/char/bcm2835_aux.c
> +++ b/hw/char/bcm2835_aux.c
> @@ -55,17 +55,29 @@
>  #define RX_ENABLE 0x1
>  #define TX_ENABLE 0x2
>
> +/* bits in STAT register */
> +#define STAT_TRANSMITTER_DONE 0x200
> +
>  /* FIFOs length */
>  #define BCM2835_AUX_RX_FIFO_LEN 8
> -#define BCM2835_AUX_TX_FIOF_LEN 8
> +#define BCM2835_AUX_TX_FIFO_LEN 8

Oh, here's the typo fix -- it should be in patch 1.

> +
> +#define log_guest_error(fmt, ...) \
> +    qemu_log_mask(LOG_GUEST_ERROR, \
> +                  "bcm2835_aux:%s:%d: " fmt, \
> +                  __func__, \
> +                  __LINE__, \
> +                  ##__VA_ARGS__ \
> +                  )

Please don't wrap qemu_log_mask() in a macro like this;
we only use it once anyway. Also, LOG_GUEST_ERROR messages
are going to be seen by users and they're for guest bugs,
not QEMU bugs -- so it's better to write them in a way
that's clear about the problem and doesn't include QEMU
line numbers that imply that the reader ought to go and
look up the QEMU source code. (Function names are a
borderline case -- we often print those but we hope they're
named clearly enough to imply what they mean...)

>  /* TODO: Add separate functions for RX and TX interrupts */
> -static void bcm2835_aux_update(BCM2835AuxState *s)
> +static void bcm2835_aux_update_irq(BCM2835AuxState *s)
>  {
>      /* TODO: this should be a pointer to const data. However, the fifo8 =
API
>       * requires a pointer to non-const data.
>       */
>      Fifo8 *rx_fifo =3D &s->rx_fifo;
> +    Fifo8 *tx_fifo =3D &s->tx_fifo;
>      /* signal an interrupt if either:
>       * 1. rx interrupt is enabled and we have a non-empty rx fifo, or
>       * 2. the tx interrupt is enabled (since we instantly drain the tx f=
ifo)
> @@ -74,13 +86,19 @@ static void bcm2835_aux_update(BCM2835AuxState *s)
>      if ((s->ier & RX_INT) && fifo8_is_empty(rx_fifo) =3D=3D false) {
>          s->iir |=3D RX_INT;
>      }
> -    if (s->ier & TX_INT) {
> +    if (s->ier & TX_INT && fifo8_is_empty(tx_fifo)) {
>          s->iir |=3D TX_INT;
>      }
>      qemu_set_irq(s->irq, s->iir !=3D 0);
>  }
>
> -static bool bcm2835_aux_is_tx_enabled(BCM2835AuxState *s)
> +static void bcm2835_aux_update(BCM2835AuxState *s)
> +{
> +    /* Currently, only IRQ registers are updated */
> +    bcm2835_aux_update_irq(s);

What other kind of update were you envisaging? This
kind of foo_update() function in a QEMU device model
is usually "update the interrupt state".

Please don't add this wrapper function until/unless we
actually need it.

> +}
> +
> +static bool bcm2835_aux_is_tx_enabled(const BCM2835AuxState *s)
>  {
>      return (s->cntl & TX_ENABLE) !=3D 0;
>  }
> @@ -90,6 +108,70 @@ static bool bcm2835_aux_is_rx_enabled(BCM2835AuxState=
 *s)
>      return (s->cntl & RX_ENABLE) !=3D 0;
>  }
>
> +static bool bcm2835_aux_put_tx_fifo(BCM2835AuxState *s, char ch)
> +{
> +    Fifo8 *tx_fifo =3D &s->tx_fifo;
> +
> +    if (fifo8_is_full(tx_fifo)) {
> +        log_guest_error("TX buffer overflow");
> +
> +        return false;
> +    }
> +
> +    fifo8_push(tx_fifo, ch);
> +
> +    return true;
> +}
> +
> +static gboolean bcm2835_aux_xmit_handler(void *do_not_use, GIOCondition =
cond,
> +                                         void *opaque)
> +{
> +    BCM2835AuxState *s =3D opaque;
> +    Fifo8 *tx_fifo =3D &s->tx_fifo;
> +
> +    if (!fifo8_is_empty(tx_fifo)) {
> +        const uint8_t ch =3D fifo8_pop(&s->tx_fifo);
> +        qemu_chr_fe_write(&s->chr, &ch, 1);

You can write more than one character at a time here.
See hw/char/cadence_uart.c as an example of how to
do a non-blocking write with a UART with a FIFO,
or sifive_uart.c for one that uses a fifo8.

> +
> +        return G_SOURCE_CONTINUE;

No other code in hw/char uses G_SOURCE_CONTINUE, so chances
are high this device should not either.

> +    } else {
> +        bcm2835_aux_update(s);
> +
> +        return G_SOURCE_REMOVE;
> +    }
> +}
> +
> +static bool bcm2835_aux_is_tx_busy(const BCM2835AuxState *s)
> +{
> +    return !(s->stat & STAT_TRANSMITTER_DONE);
> +}
> +
> +static bool bcm2835_aux_can_send(const BCM2835AuxState *s)
> +{
> +    return bcm2835_aux_is_tx_enabled(s) && !bcm2835_aux_is_tx_busy(s);
> +}
> +
> +static void bcm2835_aux_send(BCM2835AuxState *s)
> +{
> +    if (bcm2835_aux_can_send(s)) {
> +        const uint8_t ch =3D fifo8_pop(&s->tx_fifo);
> +        qemu_chr_fe_write(&s->chr, &ch, 1);
> +        qemu_chr_fe_add_watch(&s->chr, G_IO_OUT | G_IO_HUP,
> +                              bcm2835_aux_xmit_handler, s);

There's a nice way to structure the code so that both the
initial "try to send the data to the chardev frontend" and the
later "glib told us we should try to send again" are the same
function -- again, see the cadence UART or some other existing
device for examples. If you use the same pattern as existing
code it's easier to review.

You're also missing the "instant drain the fifo when there's
no back-end" check which those other devices have.

> +    }
> +}
> +
> +static void bcm2835_aux_transmit(BCM2835AuxState *s, uint8_t ch)
> +{
> +    const bool result =3D bcm2835_aux_put_tx_fifo(s, ch);
> +
> +    if (result) {
> +        bcm2835_aux_send(s);
> +    }
> +
> +    bcm2835_aux_update(s);
> +}
> +
>  static uint64_t bcm2835_aux_read(void *opaque, hwaddr offset, unsigned s=
ize)
>  {
>      BCM2835AuxState *s =3D opaque;
> @@ -205,9 +287,7 @@ static void bcm2835_aux_write(void *opaque, hwaddr of=
fset, uint64_t value,
>          ch =3D value;
>          /* XXX this blocks entire thread. Rewrite to use
>           * qemu_chr_fe_write and background I/O callbacks */

We've fixed this issue, so we can remove the XXX comment now.

> -        if (bcm2835_aux_is_tx_enabled(s)) {
> -            qemu_chr_fe_write_all(&s->chr, &ch, 1);
> -        }
> +        bcm2835_aux_transmit(s, ch);
>          break;
>
>      case AUX_MU_IER_REG:
> @@ -264,7 +344,6 @@ static int bcm2835_aux_can_receive(void *opaque)
>
>  static void bcm2835_aux_put_fifo(BCM2835AuxState *s, uint8_t value)
>  {
> -    BCM2835AuxState *s =3D opaque;

This looks like a change that should be in some other patch ?

>      Fifo8 *rx_fifo =3D &s->rx_fifo;
>
>      if (fifo8_is_full(rx_fifo) =3D=3D false) {
> @@ -298,10 +377,11 @@ static const VMStateDescription vmstate_bcm2835_aux=
 =3D {
>      .minimum_version_id =3D 1,
>      .fields =3D (const VMStateField[]) {
>          VMSTATE_FIFO8(rx_fifo, BCM2835AuxState),
> -        VMSTATE_FIFO8(_tx_fifo, BCM2835AuxState),
> +        VMSTATE_FIFO8(tx_fifo, BCM2835AuxState),
>          VMSTATE_UINT32(ier, BCM2835AuxState),
>          VMSTATE_UINT32(iir, BCM2835AuxState),
>          VMSTATE_UINT32(cntl, BCM2835AuxState),
> +        VMSTATE_UINT32(stat, BCM2835AuxState),
>          VMSTATE_END_OF_LIST()
>      }
>  };
> @@ -311,8 +391,6 @@ static void bcm2835_aux_init(Object *obj)
>      SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
>      BCM2835AuxState *s =3D BCM2835_AUX(obj);
>
> -    fifo8_create(&s->rx_fifo, BCM2835_AUX_RX_FIFO_LEN);
> -
>      memory_region_init_io(&s->iomem, OBJECT(s), &bcm2835_aux_ops, s,
>                            TYPE_BCM2835_AUX, 0x100);
>      sysbus_init_mmio(sbd, &s->iomem);
> @@ -323,6 +401,16 @@ static void bcm2835_aux_realize(DeviceState *dev, Er=
ror **errp)
>  {
>      BCM2835AuxState *s =3D BCM2835_AUX(dev);
>
> +    fifo8_create(&s->rx_fifo, BCM2835_AUX_RX_FIFO_LEN);
> +    fifo8_create(&s->tx_fifo, BCM2835_AUX_TX_FIFO_LEN);
> +    s->ier =3D 0x0;
> +    /* FIFOs enabled and interrupt pending */
> +    s->iir =3D 0xC1;
> +    /* Both transmitter and receiver are initially enabled */
> +    s->cntl =3D 0x3;
> +    /* Transmitter done and FIFO empty */
> +    s->stat =3D 0x300;
>
>      qemu_chr_fe_set_handlers(&s->chr, bcm2835_aux_can_receive,
>                               bcm2835_aux_receive, NULL, NULL, s, NULL, t=
rue);
>  }
> diff --git a/include/hw/char/bcm2835_aux.h b/include/hw/char/bcm2835_aux.=
h
> index feaedc9e2f..f024277169 100644
> --- a/include/hw/char/bcm2835_aux.h
> +++ b/include/hw/char/bcm2835_aux.h
> @@ -27,10 +27,9 @@ struct BCM2835AuxState {
>      qemu_irq irq;
>
>      Fifo8 rx_fifo;
> -    /* Unused for now */
> -    Fifo8 _tx_fifo;
> +    Fifo8 tx_fifo;
>      /* Registers */
> -    uint32_t ier, iir, cntl;
> +    uint32_t ier, iir, cntl, stat;
>  };

thanks
-- PMM

