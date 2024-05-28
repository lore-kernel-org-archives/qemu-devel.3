Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E5B2C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 14:34:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBxtq-0007NF-Kp; Tue, 28 May 2024 10:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBxto-0007Mp-Tp
 for qemu-devel@nongnu.org; Tue, 28 May 2024 10:34:00 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBxtm-0002rC-Vw
 for qemu-devel@nongnu.org; Tue, 28 May 2024 10:34:00 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5766cd9ca1bso1261132a12.0
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 07:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716906837; x=1717511637; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c5LCgVEizw6DtouBqcgIIvIsuJPil9t/nZVk415WmuY=;
 b=dpzPMXJ1snLtUCv4RfpYREiffmXNo6/LmzclOei1uTOTvB1rMyHkXI2ALd1nbJ0R5e
 Nno72DXk+sNxCqWzN6gsFVBYqINstO3hGvIfUbGRIK4V/X6EFDgf6AEy38/B+wgiQjId
 SLdwSspbbQiPtbTCXninlH1KZfa+eeg7M1xxhwGUdN43KItW10jAecb8afA9WoVF68qG
 TTaZu8nx8hgSzYSXUQTbxWtcTdouktsnehvWF87biSJ4hEOiCWn94H4ZJs66uxIh1HuQ
 sac4H07uOoFCqjnd0KeXvIvL7YcBpjyeXcsnfTx5/XtQ8PbTSwrJpejeGrU+0yvUU0E+
 Ll0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716906837; x=1717511637;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c5LCgVEizw6DtouBqcgIIvIsuJPil9t/nZVk415WmuY=;
 b=d9xsjtbSYmZW13LGJIvumB9tdjoiTgTFxg8RAR3D9p94qel9nRUowvAxWVWUUf2FJ0
 uzYsA+5rrOtj3UXMwMfuHs+nPVdU/f3pwPX1dRWm9aSe78PZRWOC+r8BG4f5StykJS7i
 AzMjACTwjvuq0hYgSJCZ6XQu7w3AhHBHVm++xy3PVwG+qzNZv/2IEM84tMJP23JVmg1d
 kdc5/YT6asadQUfrY0+XkNK40yuRehAH3EH4+NLTUG1El4iIpWFZslDBpPAqgC9ExLxi
 pOmOYBRbZcXNifB0BLaN92ogBzL9zR3QsQynFMhDuQh0fkOUJhFhRuUiWiL+mYCH+92i
 41Lg==
X-Gm-Message-State: AOJu0YxYWSTFzox/7MBwUywSMGsTyH5dpNnF1wLH3ZQUgZ/xhWFmxmou
 +B9OkJhmue2tZ1/qGk+dCgeCKfuNpEphkpISuoBhS92XhtCZswUHTglbs7/qGVhWJY/kfFHy4Xt
 2TScTehls9yhtSrobTPWmwXTJSokxxYYvfgL+VQ==
X-Google-Smtp-Source: AGHT+IH5O5IpkQTxFJXyR8oS5+emshOmt3ZVjPvtHjXyEVC18S/ViDYo0O++25XAoclPD0KJxbkH7i7GKvf9/CiRofk=
X-Received: by 2002:a50:d6c9:0:b0:578:4b06:fdf7 with SMTP id
 4fb4d7f45d1cf-5785198a027mr8495091a12.25.1716906837143; Tue, 28 May 2024
 07:33:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240522204020.203905-1-ines.varhol@telecom-paris.fr>
 <20240522204020.203905-3-ines.varhol@telecom-paris.fr>
In-Reply-To: <20240522204020.203905-3-ines.varhol@telecom-paris.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 May 2024 15:33:45 +0100
Message-ID: <CAFEAcA88uoTwqa1OaQj_u+M2BgB9MHagizE3zdvLUCjczQ1_bg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] hw/misc: In STM32L4x5 EXTI, handle direct and
 configurable interrupts
To: =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>
Cc: qemu-devel@nongnu.org, Arnaud Minier <arnaud.minier@telecom-paris.fr>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, 22 May 2024 at 21:40, In=C3=A8s Varhol <ines.varhol@telecom-paris.f=
r> wrote:
>
> The previous implementation for EXTI interrupts only handled
> "configurable" interrupts, like those originating from STM32L4x5 SYSCFG
> (the only device currently connected to the EXTI up until now).
>
> In order to connect STM32L4x5 USART to the EXTI, this commit adds
> handling for direct interrupts (interrupts without configurable edge).
>
> The implementation of configurable interrupts (interrupts supporting
> edge selection) was incorrectly expecting alternating input levels :
> this commits adds a new status field `irq_levels` to actually detect
> edges.

This patch is now doing two different things:
 * correcting the handling of detecting of rising/falling edges
 * adding the direct-interrupt support

These should be two separate patches, I think.

> Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
> ---
>  include/hw/misc/stm32l4x5_exti.h |  2 ++
>  hw/misc/stm32l4x5_exti.c         | 25 ++++++++++++++++++++-----
>  2 files changed, 22 insertions(+), 5 deletions(-)
>
> diff --git a/include/hw/misc/stm32l4x5_exti.h b/include/hw/misc/stm32l4x5=
_exti.h
> index 82f75a2417..62f79362f2 100644
> --- a/include/hw/misc/stm32l4x5_exti.h
> +++ b/include/hw/misc/stm32l4x5_exti.h
> @@ -45,6 +45,8 @@ struct Stm32l4x5ExtiState {
>      uint32_t swier[EXTI_NUM_REGISTER];
>      uint32_t pr[EXTI_NUM_REGISTER];
>
> +    /* used for edge detection */
> +    uint32_t irq_levels[EXTI_NUM_REGISTER];
>      qemu_irq irq[EXTI_NUM_LINES];
>  };
>
> diff --git a/hw/misc/stm32l4x5_exti.c b/hw/misc/stm32l4x5_exti.c
> index eebefc6cd3..bdc3dc10d6 100644
> --- a/hw/misc/stm32l4x5_exti.c
> +++ b/hw/misc/stm32l4x5_exti.c
> @@ -87,6 +87,7 @@ static void stm32l4x5_exti_reset_hold(Object *obj, Rese=
tType type)
>          s->ftsr[bank] =3D 0x00000000;
>          s->swier[bank] =3D 0x00000000;
>          s->pr[bank] =3D 0x00000000;
> +        s->irq_levels[bank] =3D 0x00000000;
>      }
>  }
>
> @@ -106,17 +107,30 @@ static void stm32l4x5_exti_set_irq(void *opaque, in=
t irq, int level)
>          return;
>      }
>
> +    /* In case of a direct line interrupt */
> +    if (extract32(exti_romask[bank], irq, 1)) {
> +        qemu_set_irq(s->irq[oirq], level);
> +        return;
> +    }
> +
> +    /* In case of a configurable interrupt */
>      if (((1 << irq) & s->rtsr[bank]) && level) {
>          /* Rising Edge */
> -        s->pr[bank] |=3D 1 << irq;
> -        qemu_irq_pulse(s->irq[oirq]);
> +        if (!extract32(s->irq_levels[bank], irq, 1)) {
> +            s->pr[bank] |=3D 1 << irq;
> +            qemu_irq_pulse(s->irq[oirq]);
> +        }
> +        s->irq_levels[bank] |=3D 1 << irq;
>      } else if (((1 << irq) & s->ftsr[bank]) && !level) {
>          /* Falling Edge */
> -        s->pr[bank] |=3D 1 << irq;
> -        qemu_irq_pulse(s->irq[oirq]);
> +        if (extract32(s->irq_levels[bank], irq, 1)) {
> +            s->pr[bank] |=3D 1 << irq;
> +            qemu_irq_pulse(s->irq[oirq]);
> +        }
> +        s->irq_levels[bank] &=3D ~(1 << irq);
>      }

The irq_levels[] array should be updated based on 'level'
separately from determining whether it's a rising or falling
edge. With this code, if for instance the line is
configured for rising-edge detection then we never clear
the irq_levels[] bit when the level falls again, because
the only place we're clearing irq_levels bits is inside the
falling-edge-detected codepath.

We also don't get the case of "guest set the bit in both the
RTSR and FTSR right, which the datasheet specifically calls out
as permitted.

I think something like this will do the right thing:

    if (level =3D=3D extract32(s->irq_levels[bank], irq, 1)) {
        /* No change in IRQ line state: do nothing */
        return;
    }
    s->irq_levels[bank] =3D deposit32(s->irq_levels[bank], irq, level);

    if ((level && extract32(s->rtsr[bank], irq, 1) ||
        (!level && extract32(s->ftsr[bank], irq, 1)) {
        /*
         * Trigger on this rising or falling edge. Note that the guest
         * can configure the same interrupt line to trigger on both
         * rising and falling edges if it wishes, or to not trigger
         * at all.
         */
        s->pr[bank] |=3D 1 << irq;
        qemu_irq_pulse(s->irq[oirq]);
    }

(I would then consider the "In the following situations" comment
to be a bit redundant and deleteable, but that's a matter of taste.)

>      /*
> -     * In the following situations :
> +     * In the following situations (for configurable interrupts) :
>       * - falling edge but rising trigger selected
>       * - rising edge but falling trigger selected
>       * - no trigger selected
> @@ -262,6 +276,7 @@ static const VMStateDescription vmstate_stm32l4x5_ext=
i =3D {
>          VMSTATE_UINT32_ARRAY(ftsr, Stm32l4x5ExtiState, EXTI_NUM_REGISTER=
),
>          VMSTATE_UINT32_ARRAY(swier, Stm32l4x5ExtiState, EXTI_NUM_REGISTE=
R),
>          VMSTATE_UINT32_ARRAY(pr, Stm32l4x5ExtiState, EXTI_NUM_REGISTER),
> +        VMSTATE_UINT32_ARRAY(irq_levels, Stm32l4x5ExtiState, EXTI_NUM_RE=
GISTER),
>          VMSTATE_END_OF_LIST()
>      }

If you add a new field to vmstate you must always bump the version numbers.

thanks
-- PMM

