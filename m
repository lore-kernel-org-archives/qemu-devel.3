Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C7BCD11DD
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 16:04:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpsER-0006Am-W0; Thu, 28 Mar 2024 12:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rpsE9-0005xh-Ji
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 12:03:45 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rpsE4-0004LE-H9
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 12:03:41 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-513cf9bacf1so1390750e87.0
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 09:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711641814; x=1712246614; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5XBacfW3jn71sz35HEbo3TB+Ib+Z2fotei/WqaV02b8=;
 b=fgs5zYORMp/yNPk+m9NsL63EJfQZo93ZKQmN0BhYvUrWRKjSQht2TDGflVAcjT/dSF
 C9/utmG7k+Kb5PW0+mrppDXGtGmOXBudEM8PE87zfuOZDRgQkADFKS6i6slFLN0DKmVO
 J6tfipmVoilwmkpPgYpdLn5+ZNFtlpCLoG84hD5amPZATsZ9D3rmpF3+UwXQl2dDBQKC
 P9gRjC8kxQlSJ2tXm6UDp4i707luhOMcRM8FeAEg47qPMIZzc8rgzXxIlJeclrcuayrr
 uN4mTlPiLucCfxHLMgjN6/IjeZGJvqVbh7Ii+lzIuo9f1WR0K/cxl5HrzRXg5genW++G
 eKoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711641814; x=1712246614;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5XBacfW3jn71sz35HEbo3TB+Ib+Z2fotei/WqaV02b8=;
 b=uEXKk/OnVGqGesG/wVdxa3V4E5Ix/DVkbzu+FRIwyYO4bvCoMuUGqqQ2+rQgsfZU/d
 X+6dyCd1Ulx1xV6Pwj6fklF+i2FtiXBUn/p95caEpbsib4jVmI3JiNLPxAWdHAszQhom
 apC9qvapze+o2tgLsmtzqvANghdamJUvTXxSXE+74SDwB2HlIgg637pn2/gfknrIzNPx
 taTMHW91zuQgbkZi19mrnUlV667fsSg52LMHl7Rp6Ng68+LTkSuGgWCird20GdNfLG0w
 KDh9WrDHWVDXp1+rMtwbyvXVK7Hg3LtruBLNY1nQWPM2HJuA4loEcuUZhP+MM3wGYvUq
 BJ+g==
X-Gm-Message-State: AOJu0Ywyccxt2QpPOd/HN55y11iWbjC4neLJKntRP/5pxRQVSPcDIkYo
 u/YzqN+YlciVs1oT3gvuBZj3ZNubTI66QU/ufy/6AXlp54L0YBdhCkPhJq1qlu3EMn9sB7PZ2kO
 E6oAf0paoIabYUNcKz+JvCxHyihubtuKuwTBM4A==
X-Google-Smtp-Source: AGHT+IHFl0cszrLlBjWJTjR2B7J/dZMedAKqI5PYxw3tj/h6qnD3pLZyEyYLAP8+kpJJOjkuwsiOSarwgQPbIHODvy0=
X-Received: by 2002:a19:5f57:0:b0:515:b0c1:aeb3 with SMTP id
 a23-20020a195f57000000b00515b0c1aeb3mr2211122lfj.67.1711641814467; Thu, 28
 Mar 2024 09:03:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240324165545.201908-1-arnaud.minier@telecom-paris.fr>
 <20240324165545.201908-5-arnaud.minier@telecom-paris.fr>
In-Reply-To: <20240324165545.201908-5-arnaud.minier@telecom-paris.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Mar 2024 16:03:22 +0000
Message-ID: <CAFEAcA9n8g6USCpYzBQSOns9HOyXx_QNFAfwj1YY1+J1tEDYFw@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] hw/char/stm32l4x5_usart: Add options for serial
 parameters setting
To: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>, 
 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x131.google.com
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

On Sun, 24 Mar 2024 at 16:57, Arnaud Minier
<arnaud.minier@telecom-paris.fr> wrote:
>
> Add a function to change the settings of the
> serial connection.
>
> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
> ---
>  hw/char/stm32l4x5_usart.c | 98 +++++++++++++++++++++++++++++++++++++++
>  hw/char/trace-events      |  1 +
>  2 files changed, 99 insertions(+)
>
> diff --git a/hw/char/stm32l4x5_usart.c b/hw/char/stm32l4x5_usart.c
> index ec8c2f6e63..b4d11dd826 100644
> --- a/hw/char/stm32l4x5_usart.c
> +++ b/hw/char/stm32l4x5_usart.c
> @@ -267,6 +267,92 @@ static void usart_cancel_transmit(Stm32l4x5UsartBase=
State *s)
>      }
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
> +    switch (FIELD_EX32(s->cr2, CR2, STOP)) {
> +    case 0:
> +        stop_bits =3D 1;
> +        break;
> +    case 2:
> +        stop_bits =3D 2;
> +        break;
> +    default:
> +        qemu_log_mask(LOG_UNIMP,
> +            "UNIMPLEMENTED: fractionnal stop bits; CR2[13:12] =3D %x",

%x without a leading 0x is a bit odd. In this case since
the possible values are 0-3 it doesn't make a difference,
but maybe better to use %u ?

> +            FIELD_EX32(s->cr2, CR2, STOP));
> +        return;
> +    }
> +
> +    /* Select the length of the word */
> +    switch ((FIELD_EX32(s->cr1, CR1, M1) << 1) | FIELD_EX32(s->cr1, CR1,=
 M0)) {
> +    case 0:
> +        data_bits =3D 8;
> +        break;
> +    case 1:
> +        data_bits =3D 9;
> +        break;
> +    case 2:
> +        data_bits =3D 7;
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +            "UNDEFINED: invalid word length, CR1.M =3D 0b11");
> +        return;
> +    }
> +
> +    /* Select the baud rate */
> +    value =3D FIELD_EX32(s->brr, BRR, BRR);
> +    if (value < 16) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +            "UNDEFINED: BRR lesser than 16: %u", value);

"less than"

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
> +    trace_stm32l4x5_usart_update_params(speed, parity, data_bits, stop_b=
its);
> +}

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

