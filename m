Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF8CEC54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 18:26:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnjad-0000mf-50; Fri, 22 Mar 2024 14:26:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rnjaZ-0000iw-Fl
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 14:25:59 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rnjaX-0002FS-Go
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 14:25:59 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-56b85146589so4175258a12.0
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 11:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711131956; x=1711736756; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M4QuTnMNy2QhRGnYd/1O8inzqWgELKkSsv5Kf67p/eI=;
 b=cwOHTq0gG9YSxXfB9oAvFXh90k5c4VLNGXHuqj+kEv9aPD34BNEA29rtfdLXv4wnaX
 vL3rE5DxRnl2f3UXTCmEAAOYW+GQGvtx0SRZGMwjRyyyo5tdgPcr4n5MBqS5wV/iVWv2
 u9fXeG5w4rP9CW8JC8WGIjNAyLmTztdZQyGna0wAedcseJYlQyd+1Ya4jSlA5hegcpUl
 NiEGrsofKTuYEQY6xa8AqacXWkvssPifQ7CUL8v+AIVW3BrS4xZhf5qWomT8NeVrVP+U
 7Ole8C+l4fF36YkvHQGp8T8/JdaAMu9Dpa/r02MdwjDXBwNoGSKWIrpnT0pYZSFb/lIi
 SI9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711131956; x=1711736756;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M4QuTnMNy2QhRGnYd/1O8inzqWgELKkSsv5Kf67p/eI=;
 b=LSxrCQzFCVMjv3frR4B7HHP7A5nNyX88C3NMl9Aa5/81SN+DX8xzFr/11qD1WUgBqM
 U2PqMsGfn+QU79jSdUg/qyZUn+C5Dhp/tkkilcql8pNjorhhFBJi89GFAZcNeKBJA1xe
 638yHfXdyZl48U4jXk+fVqYZVqj7wgNsxmijpVCyLxMgfROggi/eXnt4SQVJNCus7dxq
 3+J5zlVu71n0eEBzk9OfzKl8l4y+8ZWrzQ+IqXtEO6pU6lBBh2KUj3HS1EF9IGQLtLCM
 ebIEed0r/ySG+PGvCEEkuXZzMSamCEc9FTlTP9f8hCIy/1YihY1VfUS02cEBLNhkabEM
 RTCA==
X-Gm-Message-State: AOJu0YxLgSxUiLc6wqPO1/IdDhs5ZNQ1eHIC77CLrDLvvlwnePIBOu5F
 F8ZbqKX/AfHjnYMBBdhPGa7VnJjV6bmaJFKzEqiS/bWldMo7Hi3+BbAFD1VNmVe9HWvZpqkuV7P
 dp5HFxgBaxfnLzBApN4v4eJGSu6cqNzLQ+OjtIw==
X-Google-Smtp-Source: AGHT+IEumminvE6Eff9f1Uo7mFj45lZvWdLK05yz1lUqghD+Y+3Dn+EQJWCmADBrPce8Hsz5cjt7OaVd9is6AUIoUxw=
X-Received: by 2002:a50:c343:0:b0:568:d6a2:716 with SMTP id
 q3-20020a50c343000000b00568d6a20716mr2592917edb.7.1711131955719; Fri, 22 Mar
 2024 11:25:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240317103918.44375-1-arnaud.minier@telecom-paris.fr>
 <20240317103918.44375-6-arnaud.minier@telecom-paris.fr>
In-Reply-To: <20240317103918.44375-6-arnaud.minier@telecom-paris.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Mar 2024 18:25:45 +0000
Message-ID: <CAFEAcA_J9HPQ=C9wF_jG5=Z2cxD9P3Ph3urvY=Wv2LsRhmcMWg@mail.gmail.com>
Subject: Re: [PATCH 5/7] hw/char/stm32l4x5_usart: Add options for serial
 parameters setting
To: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Cc: qemu-devel@nongnu.org, Samuel Tardieu <samuel.tardieu@telecom-paris.fr>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Alistair Francis <alistair@alistair23.me>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>, 
 qemu-arm@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Sun, 17 Mar 2024 at 10:41, Arnaud Minier
<arnaud.minier@telecom-paris.fr> wrote:
>
> Add a function to change the settings of the
> serial connection.
>
> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
> ---
>  hw/char/stm32l4x5_usart.c | 97 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 97 insertions(+)
>
> diff --git a/hw/char/stm32l4x5_usart.c b/hw/char/stm32l4x5_usart.c
> index 958d05a56d..95e792d09d 100644
> --- a/hw/char/stm32l4x5_usart.c
> +++ b/hw/char/stm32l4x5_usart.c
> @@ -165,6 +165,91 @@ static int stm32l4x5_usart_base_can_receive(void *op=
aque)
>      return 0;
>  }
>
> +static void stm32l4x5_update_params(Stm32l4x5UsartBaseState *s)
> +{
> +    int speed, parity, data_bits, stop_bits;
> +    uint32_t value, usart_div;
> +    QEMUSerialSetParams ssp;
> +
> +    /* Select the parity type */
> +    if (s->cr1 & R_CR1_PCE_MASK) {
> +        if (s->cr1 & R_CR1_PS_MASK) {
> +            parity =3D 'O';
> +        } else {
> +            parity =3D 'E';
> +        }
> +    } else {
> +        parity =3D 'N';
> +    }
> +
> +    /* Select the number of stop bits */
> +    value =3D FIELD_EX32(s->cr2, CR2, STOP);
> +    if (value =3D=3D 0b00) {
> +        stop_bits =3D 1;
> +    } else if (value =3D=3D 0b10) {
> +        stop_bits =3D 2;
> +    } else {

I think this would read a little more clearly as

     switch (FIELD_EX32(s->cr2, CR2, STOP)) {
     case 0:
          stop_bits =3D 1;
          break;
     case 2:
          stop_bits =3D 2;
          break;
     default:
          [error case code]
     }

rather than using an if-else ladder. Similarly below.

> +        /* TODO: raise an error here */
> +        stop_bits =3D 1;
> +        error_report(
> +            "UNIMPLEMENTED: fractionnal stop bits; CR2[13:12] =3D %x",
> +            value);

We generally use qemu_log_mask(LOG_UNIMP, ...) for
"this was a valid thing for the guest to do but our implementation
doesn't handle it", and qemu_log_mask(LOG_GUEST_ERROR, ...) for
"this was an invalid thing for the guest to do" (eg programming register
fields to reserved/undefined values), rather than using error_report().

> +        return;
> +    }
> +
> +    /* Select the length of the word */
> +    value =3D (FIELD_EX32(s->cr1, CR1, M1) << 1) | FIELD_EX32(s->cr1, CR=
1, M0);
> +    if (value =3D=3D 0b00) {
> +        data_bits =3D 8;
> +    } else if (value =3D=3D 0b01) {
> +        data_bits =3D 9;
> +    } else if (value =3D=3D 0b01) {
> +        data_bits =3D 7;

These two arms both check against the same value, so one of them
must be wrong...

> +    } else {
> +        /* TODO: Raise an error here */
> +        data_bits =3D 8;
> +        error_report("UNDEFINED: invalid word length, CR1.M =3D 0b11");
> +        return;
> +    }
> +
> +    /* Select the baud rate */
> +    value =3D FIELD_EX32(s->brr, BRR, BRR);
> +    if (value < 16) {
> +        /* TODO: Raise an error here */
> +        error_report("UNDEFINED: BRR lesser than 16: %u", value);
> +        return;
> +    }
> +
> +    if (FIELD_EX32(s->cr1, CR1, OVER8) =3D=3D 0) {
> +        /*
> +         * Oversampling by 16
> +         * BRR =3D USARTDIV
> +         */
> +        usart_div =3D value;
> +    } else {
> +        /*
> +         * Oversampling by 8
> +         * - BRR[2:0] =3D USARTDIV[3:0] shifted 1 bit to the right.
> +         * - BRR[3] must be kept cleared.
> +         * - BRR[15:4] =3D USARTDIV[15:4]
> +         * - The frequency is multiplied by 2
> +         */
> +        usart_div =3D ((value & 0xFFF0) | ((value & 0x0007) << 1)) / 2;
> +    }
> +
> +    speed =3D clock_get_hz(s->clk) / usart_div;
> +
> +    ssp.speed     =3D speed;
> +    ssp.parity    =3D parity;
> +    ssp.data_bits =3D data_bits;
> +    ssp.stop_bits =3D stop_bits;
> +
> +    qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_SERIAL_SET_PARAMS, &ssp);
> +
> +    trace_stm32l4x5_usart_update_params(
> +        speed, parity, data_bits, stop_bits, 0);

This is slightly weird indentation.

> +}
> +
>  static void stm32l4x5_update_irq(Stm32l4x5UsartBaseState *s)
>  {
>      if (((s->isr & R_ISR_WUF_MASK) && (s->cr3 & R_CR3_WUFIE_MASK))      =
  ||
> @@ -318,16 +403,19 @@ static void stm32l4x5_usart_base_write(void *opaque=
, hwaddr addr,
>      switch (addr) {
>      case A_CR1:
>          s->cr1 =3D value;
> +        stm32l4x5_update_params(s);
>          stm32l4x5_update_irq(s);
>          return;
>      case A_CR2:
>          s->cr2 =3D value;
> +        stm32l4x5_update_params(s);
>          return;
>      case A_CR3:
>          s->cr3 =3D value;
>          return;
>      case A_BRR:
>          s->brr =3D value;
> +        stm32l4x5_update_params(s);
>          return;
>      case A_GTPR:
>          s->gtpr =3D value;
> @@ -409,10 +497,19 @@ static void stm32l4x5_usart_base_init(Object *obj)
>      s->clk =3D qdev_init_clock_in(DEVICE(s), "clk", NULL, s, 0);
>  }
>
> +static int stm32l4x5_usart_base_post_load(void *opaque, int version_id)
> +{
> +    Stm32l4x5UsartBaseState *s =3D (Stm32l4x5UsartBaseState *)opaque;
> +
> +    stm32l4x5_update_params(s);
> +    return 0;
> +}
> +
>  static const VMStateDescription vmstate_stm32l4x5_usart_base =3D {
>      .name =3D TYPE_STM32L4X5_USART_BASE,
>      .version_id =3D 1,
>      .minimum_version_id =3D 1,
> +    .post_load =3D stm32l4x5_usart_base_post_load,
>      .fields =3D (VMStateField[]) {
>          VMSTATE_UINT32(cr1, Stm32l4x5UsartBaseState),
>          VMSTATE_UINT32(cr2, Stm32l4x5UsartBaseState),
> --

thanks
-- PMM

