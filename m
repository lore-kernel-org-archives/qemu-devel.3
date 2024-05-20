Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED49C3DA40
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 14:32:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s942W-0006u2-5Q; Mon, 20 May 2024 10:31:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s942C-0006qx-A2
 for qemu-devel@nongnu.org; Mon, 20 May 2024 10:30:53 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s9429-0006Ns-Gk
 for qemu-devel@nongnu.org; Mon, 20 May 2024 10:30:39 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-574f7c0bab4so9425302a12.0
 for <qemu-devel@nongnu.org>; Mon, 20 May 2024 07:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716215434; x=1716820234; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uNkndTB/EfiXIMFigE3HW7JUkwKzX31GL4b5ChXEUvA=;
 b=ZfCjfX0ZaA1qC96S8HbwulkKnFLZH0a4Iej3/2EkmSBLsda8uzW2Gcc+WXLRv3ptKR
 bN8fcICM/9+2pY0GbuTLWapzybr72PFoYPxr8nFh+TkcRJeIabcND9lax50lMpO12OYT
 PkS0I1p2apKZgM+T4tVZ7lnHLEOH+ieH5XhD6aGEcWaYQGtIuIqXXV95HYID2wyNdLuq
 hTyVWl0WpRUyTSCL2ZYvLukSnn0XM3sLm6KOnTZZTVtBv0QNKXZ4nhJ54K8X5FVrqb/7
 HAywSBmRSelA6wHIHi4q1yeb00DZOz31mvR643JwO18WPY4wmo1U2jA1ji1PViR6wPF5
 gUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716215434; x=1716820234;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uNkndTB/EfiXIMFigE3HW7JUkwKzX31GL4b5ChXEUvA=;
 b=aAWfgKKRJdXaAOgMiP4cMbT/aRNUibS3tkgUSBd2BMNFiM4VhU2uPQccjCqHGFJL6t
 cqscHMaqGqnK8vkHU41CElBDZbmpVNYgHk9UhKCSxRV4u9DZGid5sistOahPO3F6dgMe
 gKB04VvDYkuVJbEpc3xnCkj3bk50+HyhImkBATi33/mbKYpJlp1Z/38+dAobkSlBZ0A9
 fk7gURlXPYcrD2v/51SgUaktknqhsLpNZwJ1NGWkoT5IuOxwF0tUOX/d67t2o0GlfSb3
 s4U6kPGNL/TQBjbiX4YcHht1LeKsJAMuxk65QSe4fTixxgz1KDrPOe3vieu3vFuw6K1A
 nMgw==
X-Gm-Message-State: AOJu0Yz/P2epsfzTbjoIKuNc8mSLAsmUxvGs6p0W3kHoeY2IPSrVKgH+
 qd4FU0xyqzVxPis1dzPdzhhU80Db+xWfkde9QfQnwP99tEfoA5WdUPy5eG1OscVWKMrwwmHGD8y
 bQV3TVt7TbveFcbsJc2y7llRPLzquigHjIKGtug==
X-Google-Smtp-Source: AGHT+IG+4oFTocgXk3/VAjefRi0K1IqkKqpfB6hfqv/iJ6iHqPvE7ATa9LBiNqAUfyT+rT4NBxNiPuWzKLtOQVYA6z4=
X-Received: by 2002:a17:906:3791:b0:a5c:dce0:9f4e with SMTP id
 a640c23a62f3a-a5d5ecdc434mr601716266b.28.1716215433700; Mon, 20 May 2024
 07:30:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240512102013.211127-1-ines.varhol@telecom-paris.fr>
 <20240512102013.211127-3-ines.varhol@telecom-paris.fr>
In-Reply-To: <20240512102013.211127-3-ines.varhol@telecom-paris.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 May 2024 15:30:23 +0100
Message-ID: <CAFEAcA_tPLe7_rzmzOds7wAEFaP7Npk_4WqoBACC6nUTWTBfGw@mail.gmail.com>
Subject: Re: [PATCH 2/3] hw/misc: In STM32L4x5 EXTI,
 handle direct line interrupts
To: =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Arnaud Minier <arnaud.minier@telecom-paris.fr>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Sun, 12 May 2024 at 11:20, In=C3=A8s Varhol <ines.varhol@telecom-paris.f=
r> wrote:
>
> The previous implementation for EXTI interrupts only handled
> "configurable" interrupts, like those originating from STM32L4x5 SYSCFG
> (the only device currently connected to the EXTI up until now).
> In order to connect STM32L4x5 USART to the EXTI, this commit adds
> handling for direct interrupts (interrupts without configurable edge),
> as well as a comment that will be useful to connect other devices to the
> EXTI.
>
> Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
> ---
>  hw/misc/stm32l4x5_exti.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/hw/misc/stm32l4x5_exti.c b/hw/misc/stm32l4x5_exti.c
> index eebefc6cd3..1817bbdad2 100644
> --- a/hw/misc/stm32l4x5_exti.c
> +++ b/hw/misc/stm32l4x5_exti.c
> @@ -106,6 +106,27 @@ static void stm32l4x5_exti_set_irq(void *opaque, int=
 irq, int level)
>          return;
>      }
>
> +    /* In case of a direct line interrupt */
> +    if (extract32(exti_romask[bank], irq, 1)) {
> +        if (level) {
> +            qemu_irq_raise(s->irq[oirq]);
> +        } else {
> +            qemu_irq_lower(s->irq[oirq]);
> +        }

You can say this more concisely as
           qemu_set_irq(s->irq[oirq], level);

> +        return;
> +    }
> +
> +    /*
> +     * In case of a configurable interrupt
> +     *
> +     * Note that while the real EXTI uses edge detection to tell
> +     * apart a line rising (the level changes from 0 to 1) and a line
> +     * staying high (the level was 1 and is set to 1), the current
> +     * implementation relies on the fact that this handler will only
> +     * be called when there's a level change. That means that the
> +     * devices creating a configurable interrupt (like STM32L4x5 GPIO)
> +     * have to set their IRQs only on a change.
> +     */

You cannot rely on this in QEMU's qemu_irq API. The set
function may be called multiple times with the same input
level value. If you need to detect rising edges then this
device needs to have a state field that records the current
value so it can compare the 'level' argument here against
what it was previously.

>      if (((1 << irq) & s->rtsr[bank]) && level) {
>          /* Rising Edge */
>          s->pr[bank] |=3D 1 << irq;
> @@ -116,7 +137,7 @@ static void stm32l4x5_exti_set_irq(void *opaque, int =
irq, int level)
>          qemu_irq_pulse(s->irq[oirq]);
>      }
>      /*
> -     * In the following situations :
> +     * In the following situations (for configurable interrupts) :
>       * - falling edge but rising trigger selected
>       * - rising edge but falling trigger selected
>       * - no trigger selected

thanks
-- PMM

