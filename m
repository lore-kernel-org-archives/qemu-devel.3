Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95336C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 14:30:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk28Q-0004q9-Nr; Mon, 17 Feb 2025 09:30:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tk28O-0004nV-03
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 09:30:08 -0500
Received: from mail-yb1-xb2d.google.com ([2607:f8b0:4864:20::b2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tk28K-0001nT-8T
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 09:30:05 -0500
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e479e529ebcso3248649276.3
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 06:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739802603; x=1740407403; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=liAnHmT5fS5HSmio2jxDsDuUAn+/oAc2qvcRTq1qX04=;
 b=gT9vyfEqQW21WLjG2gQh7q7YjTlRL0AKLs9p9ZldJFgXwDMsztQXsUqNZlFOcFpGdk
 h1V76t4w9hQg3wbyXCMIXPetY/LylBhdjn6Zqq03LFNHMHHDah5cq2a0tw6EVCjqZqlk
 1RMT1I1QRymJVF7NkIIFwK2yEdmeg4lJoqxSqMGd6VjCV/jMpXiryixqauOn110amKBu
 bom3L9C1kMlmNG/vygkSG85j5dlyTDJW4NiGHUsuYOIYbyI0SOPNqySFLCDzIpsniYdi
 r5uVulErxR0LhhD2b9HQN/kOYP1u0waaFi0OmzBbM6kcbqcWbwIM9zhSz1czzDk0WDVw
 uXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739802603; x=1740407403;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=liAnHmT5fS5HSmio2jxDsDuUAn+/oAc2qvcRTq1qX04=;
 b=BCfLiQwb1BoZ7OFL3IQLUf7DD/le+7KfZswkBT0SC9rK6fVNZiimLdS0W23fEPP4Me
 x6NoKnnhKFGoY7HXOjrRsnxf9o0KfWRMlyGxufM+yw/s5/NUal7CULM3DyrdIbVVYLXX
 cWj0vkd1SqNbTOMJvG87JzaoBIB8BojfevkQaLaa2J7yhQXzRXCAf/rAPpKOsgToWEFO
 MK0+dytYtKPIehEWozxngydkRhhJeSc/m41Apj+dfwJ4W8qk7ne9bRPzEiGwbR8bANkd
 ywS84CJgTF7YABi6Q7qP5jPgQ/yrRIL4T+kO2PCEdbo78cMaXBZnvmn7WnfkPEHUVkZ0
 lifQ==
X-Gm-Message-State: AOJu0YxU/y3NE/r0ddyyvflU4Aqh32GXNkSXTHGvuvhtZlKR7kKs9MF4
 zSdaBTp+dvxocBaWiuTRn/Ngv57i+ZJ8NPkKdarJ/nEGG3wpVgFN2k/La64tGG+MCg8DYUYnleB
 eHWVINnLgcf+ioLv7g5u6oWg+KaGGQtlwC5Vnfg==
X-Gm-Gg: ASbGnctC5whXQfYqiTPy6QaWcqyJX2KTh7i90WMiIx6XE4msMrfqF9uAgAKwUWlqW4A
 UuHOiAcOM2EOtKIsCIAfeye0sy0l0uTm+biy2WWq83WvmWt8xguUySil5hUIosemPit3D+zLGgA
 ==
X-Google-Smtp-Source: AGHT+IG50ql8EQiHUVNWvGjBgvI5c/kmmunIki99/t0huXXueWLxUaVzQfeucE+X8qbvWvU20j9f8DIEnbY6JZ91IME=
X-Received: by 2002:a05:6902:2283:b0:e5d:d514:3b5e with SMTP id
 3f1490d57ef6-e5dd5143c3cmr3965017276.37.1739802603061; Mon, 17 Feb 2025
 06:30:03 -0800 (PST)
MIME-Version: 1.0
References: <20250208163911.54522-1-philmd@linaro.org>
 <20250208163911.54522-6-philmd@linaro.org>
In-Reply-To: <20250208163911.54522-6-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Feb 2025 14:29:51 +0000
X-Gm-Features: AWEUYZnUxAf4Ru77U3xAqCkMj9tdTGm2v0XTUscKEcCf_6EjA_UYhitmEbbzrx0
Message-ID: <CAFEAcA8ZSSD=TxCier0Ji8+DVDspgqKQeKJyVDZ+LEBy=j9=Lw@mail.gmail.com>
Subject: Re: [PATCH v6 5/7] hw/char/pl011: Consider TX FIFO overrun error
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2d.google.com
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

On Sat, 8 Feb 2025 at 16:39, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> When transmission is disabled, characters are still queued
> to the FIFO which eventually overruns. Report that error
> condition in the status register.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/char/pl011.c      | 20 ++++++++++++++++++++
>  hw/char/trace-events |  2 ++
>  2 files changed, 22 insertions(+)
>
> diff --git a/hw/char/pl011.c b/hw/char/pl011.c
> index 447f185e2d5..ef39ab666a2 100644
> --- a/hw/char/pl011.c
> +++ b/hw/char/pl011.c
> @@ -61,6 +61,9 @@ DeviceState *pl011_create(hwaddr addr, qemu_irq irq, Ch=
ardev *chr)
>  /* Data Register, UARTDR */
>  #define DR_BE   (1 << 10)
>
> +/* Receive Status Register/Error Clear Register, UARTRSR/UARTECR */
> +#define RSR_OE  (1 << 3)
> +
>  /* Interrupt status bits in UARTRIS, UARTMIS, UARTIMSC */
>  #define INT_OE (1 << 10)
>  #define INT_BE (1 << 9)
> @@ -158,6 +161,16 @@ static inline unsigned pl011_get_fifo_depth(PL011Sta=
te *s)
>      return pl011_is_fifo_enabled(s) ? PL011_FIFO_DEPTH : 1;
>  }
>
> +static bool pl011_is_tx_fifo_full(PL011State *s)
> +{
> +    if (pl011_is_fifo_enabled(s)) {
> +        trace_pl011_fifo_tx_is_full("FIFO", fifo8_is_full(&s->xmit_fifo)=
);
> +        return fifo8_is_full(&s->xmit_fifo);
> +    }
> +    trace_pl011_fifo_tx_is_full("CHAR", !fifo8_is_empty(&s->xmit_fifo));
> +    return !fifo8_is_empty(&s->xmit_fifo);

More repetition of expressions, but anyway
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

