Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A909CC47258
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jan 2024 17:36:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSKgE-000065-KP; Tue, 23 Jan 2024 12:35:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rSKgB-0008V4-Tg
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 12:35:20 -0500
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rSKg9-0006UA-Fb
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 12:35:19 -0500
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2cf0e9f76b4so12518881fa.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 09:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706031314; x=1706636114; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=paIsa4xyA7FzF8RxzgnnwI2DhQRer0e6faRBj+BRK1s=;
 b=lCKIwYfWz18Ie5P8xvs5sYGV36U78bZXwjcYpPVidWZY9ilQKicGqsSDA6rwjteO9V
 FLfsedYzEwexSaiB4ToJ+IfqfIQdYAOwv209VELjSutJHU4TLDmNzSLN7JT9z1EXSiL9
 m8OSijYxN1RAHYjAZTVzD65gjhYDkQ4isk1/04zf0f2B1nzo6z+p8KCjMIOtl8YrZwXS
 OmNL/F43kSP4C9it1o7ygqcG+Cj67EHqsBVBrALT/MHObISyS89pbLi+PwYJLEdbib4Y
 xf1RhDIv4x2p9ABnhsPEob6Rg7ajav3hfEqnVdeeWiyfppnrOu81gOJbQMzDVKrBv3DG
 C3wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706031314; x=1706636114;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=paIsa4xyA7FzF8RxzgnnwI2DhQRer0e6faRBj+BRK1s=;
 b=O36lUzsGfKyOFhzdtcilAbzxyXHu7Cw/OAr8+Oi3vZg8vCfzH1Xp93f+6FZirJijZK
 Ly5yAg4bUAVB+VqaMORGaQT9VaMOEOD1Z1rEz1gEmpy104p9OJ9o4SuQzkQCpG6eBQBO
 awOeG9FWPGZ7IWG09XehxIlmnbrGZMUP1nERfruE371MNkHz9z1D43aHYq27Hlp2lhRX
 hB2ep110bnPILnBD1IBJy8nytlgpUDHqP5JwA6yHHHdyYZA9GspozBCllurWAwXOiLiT
 GwmmXjEin2u76XuoQvoc6LNhUfb5TWe6r/XArhgF0CoKkgD9Del4HVPkx0cDQ+MCffsX
 PR1w==
X-Gm-Message-State: AOJu0Ywg2WSHewBxJPz2UprsTpWrLN36H80VPz4UyCHojl7R+vVKZOYW
 8DZmABBM3YbIBKYd/cfymKexTwo2ezqdHy9ux75Q4r6JYAbAJFK8ILsUM2P2hINWlUSS/iMKdgd
 +JLSsoB5horUoDhbqrzn/VEeDNchGckFXjy79n2GSEq7mXtYY
X-Google-Smtp-Source: AGHT+IFvn9Yuj96pUlRRn3cZmgzMs3auBztK5Li3ptsTYWYxhwQydC7bFy6sjZSsiOI9I29v1WNvYDWrCv22rIvIa+M=
X-Received: by 2002:a2e:9bc4:0:b0:2cc:6f7f:6ba4 with SMTP id
 w4-20020a2e9bc4000000b002cc6f7f6ba4mr49199ljj.199.1706031314210; Tue, 23 Jan
 2024 09:35:14 -0800 (PST)
MIME-Version: 1.0
References: <20240118074749.2299959-1-rayhan.faizel@gmail.com>
In-Reply-To: <20240118074749.2299959-1-rayhan.faizel@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 23 Jan 2024 17:35:03 +0000
Message-ID: <CAFEAcA9xYiTWU1Nk2_G8gAbC=spQZDFbQazEeVWJYKJu=PFs2Q@mail.gmail.com>
Subject: Re: [PATCH v3] hw/char/imx_serial: Implement receive FIFO and ageing
 timer for imx serial.
To: Rayhan Faizel <rayhan.faizel@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:i.MX31 (kzm)" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x232.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu, 18 Jan 2024 at 07:49, Rayhan Faizel <rayhan.faizel@gmail.com> wrote:
>
> This patch implements a 32 half word FIFO as per imx serial device
> specifications. If a non empty FIFO is below the trigger level, an ageing
> timer will tick for a duration of 8 characters. On expiry, AGTIM will be set
> triggering an interrupt. AGTIM timer resets when there is activity in
> the receive FIFO.
>
> Otherwise, RRDY is set when trigger level is
> exceeded. The receive trigger level is 8 in newer kernel versions and 1 in
> older ones.
>
> This change will break migration compatibility.
>
> [Changes in v3]
>
> - Caught more whitespace changes that went overlooked
> - Moved fifo and timer initialization to realize
>
> [Changes in v2]
>
> As per Peter Maydell's suggestions,
>
> - Use generic FIFO32 implementation in place of handmade impl.
> - Moved timer_init to serial init and use timer_del in reset
> - Removed stray whitespaces
> - Increment VMSTATE version
>
> Signed-off-by: Rayhan Faizel <rayhan.faizel@gmail.com>
> ---
>  hw/char/imx_serial.c         | 97 +++++++++++++++++++++++++++++++-----
>  include/hw/char/imx_serial.h | 18 ++++++-
>  2 files changed, 102 insertions(+), 13 deletions(-)

Thanks; this looks good and was easy to review.
I have a couple of comments about corner cases of the device
behaviour and a few final coding style nits, and that's all.

> +static void imx_serial_rx_fifo_push(IMXSerialState *s, uint32_t value)
> +{
> +    if (fifo32_is_full(&s->rx_fifo)) {
> +        /* Discard lost character on overflow */
> +        fifo32_pop(&s->rx_fifo);

Is this the right behaviour on rx overflow? The imx6 TRM
I have says the behaviour is:

 * when we put the 32nd character into the RX FIFO
   (i.e. the last one which will fit) then we we need
   to arrange that when it is read it has the
   URXD.OVRRUN and URXD.ERR bits associated with it,
   which we can achieve by ORing them in before we push
   the char into the FIFO here
 * when the 33rd character arrives, we set USR2.ORE and
   discard this 33rd character (i.e. never put it in the fifo)

> +    }
> +    fifo32_push(&s->rx_fifo, value);
> +}
> +
> +static uint32_t imx_serial_rx_fifo_pop(IMXSerialState *s)
> +{
> +    if (fifo32_is_empty(&s->rx_fifo)) {
> +        return URXD_ERR;

Similarly, I don't think this is how the UART signals that
you just tried to read from an empty FIFO either. My reading
of the TRM is that if there's data in the FIFO you get it
in the low 8 bits, and CHARRDY is set in bit 15. If the
FIFO is empty and the guest tries to read it then it gets
a word with CHARRDY clear and the other bits don't have
valid data (an entirely 0 word would do). The ERR bit is
only set for the OVRRUN/FRMERR/BRK/PRERR cases.

> +    }
> +    return fifo32_pop(&s->rx_fifo);
> +}
> +
> +static void imx_serial_rx_fifo_ageing_timer_int(void *opaque)
> +{
> +    IMXSerialState *s = (IMXSerialState *) opaque;
> +    s->usr1 |= USR1_AGTIM;
> +
> +    imx_update(s);
> +}
> +
> +static void imx_serial_rx_fifo_ageing_timer_restart(void *opaque)
> +{
> +    /*
> +     * Ageing timer starts ticking when
> +     * RX FIFO is non empty and below trigger level.
> +     * Timer is reset if new character is received or
> +     * a FIFO read occurs.
> +     * Timer triggers an interrupt when duration of
> +     * 8 characters has passed ( assuming 115200 baudrate ).

We don't need the spaces after ( and before ) here.

> +     */
> +    IMXSerialState *s = (IMXSerialState *) opaque;
> +    uint8_t rxtl = s->ufcr & TL_MASK;
> +    int rx_used = fifo32_num_used(&s->rx_fifo);
> +
> +    if (rx_used > 0 && rx_used < rxtl) {

Rather than checking rx_used against rxtl, can we do what the
datasheet says and check against "is USR1.RRDY == 0" ?

> +        timer_mod_ns(&s->ageing_timer,
> +            qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + AGE_DURATION_NS);
> +    } else {
> +        timer_del(&s->ageing_timer);
> +    }
> +}
> +
>  static void imx_serial_reset(IMXSerialState *s)
>  {

> @@ -345,6 +414,10 @@ static void imx_serial_realize(DeviceState *dev, Error **errp)
>  {
>      IMXSerialState *s = IMX_SERIAL(dev);
>
> +    fifo32_create(&s->rx_fifo, FIFO_SIZE);
> +    timer_init_ns(&s->ageing_timer, QEMU_CLOCK_VIRTUAL,
> +        imx_serial_rx_fifo_ageing_timer_int, s);

Generally for indent on function calls we make the second line
line up with the first character after the '(' on the preceding line.

> +
>      DPRINTF("char dev for uart: %p\n", qemu_chr_fe_get_driver(&s->chr));
>
>      qemu_chr_fe_set_handlers(&s->chr, imx_can_receive, imx_receive,
> diff --git a/include/hw/char/imx_serial.h b/include/hw/char/imx_serial.h
> index b823f94519..b5f714add1 100644
> --- a/include/hw/char/imx_serial.h
> +++ b/include/hw/char/imx_serial.h
> @@ -21,10 +21,13 @@
>  #include "hw/sysbus.h"
>  #include "chardev/char-fe.h"
>  #include "qom/object.h"
> +#include "qemu/fifo32.h"
>
>  #define TYPE_IMX_SERIAL "imx.serial"
>  OBJECT_DECLARE_SIMPLE_TYPE(IMXSerialState, IMX_SERIAL)
>
> +#define FIFO_SIZE       32
> +
>  #define URXD_CHARRDY    (1<<15)   /* character read is valid */
>  #define URXD_ERR        (1<<14)   /* Character has error */
>  #define URXD_FRMERR     (1<<12)   /* Character has frame error */
> @@ -65,6 +68,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(IMXSerialState, IMX_SERIAL)
>  #define UCR1_TXMPTYEN   (1<<6)    /* Tx Empty Interrupt Enable */
>  #define UCR1_UARTEN     (1<<0)    /* UART Enable */
>
> +#define UCR2_ATEN       BIT(3)    /* Ageing Timer Enable */

Can you define this as (1<<3), for consistency with how all
the other defines in this file are written, please?

>  #define UCR2_TXEN       (1<<2)    /* Transmitter enable */
>  #define UCR2_RXEN       (1<<1)    /* Receiver enable */
>  #define UCR2_SRST       (1<<0)    /* Reset complete */

thanks
-- PMM

