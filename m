Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91423CA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 16:38:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoPKt-0004vo-06; Tue, 19 Aug 2025 12:37:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uoPKr-0004v7-W2
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 12:37:22 -0400
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uoPKp-0004F5-31
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 12:37:21 -0400
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e931cad1fd8so5635411276.1
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 09:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755621437; x=1756226237; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jPbJtNIGuJmeIzk0bISBJpiUo0zbOAnZL91+3MTt5qI=;
 b=Oh70uLNumK+No+VqlJNRnCRNhadTfsx/5lKF6HrQxu9mlpAOKGk43LkA/Q97SqF7hY
 NVMKFZaRq813pLv0KS1+ifdovjBUe8opnhdSSznc7WYWq6CJBC+z2uhj675IGClH9WNr
 ZlzdBATyV+uGueLxICLi0T5hjk0Wrsz5tyfF2RR2i+5UXeg518+RHpWM7bfBd+eILUOU
 jteBp6XVppCdQiodpvEfnDvA3Xekana7V1A7h4EgBhmzo2121dpgO0leqcLm0qdktYkk
 CJvywSoBXUlntxfRK2O6wHyViuoOCXI6OVJltB3s6eJiQRTbIXPAwCwZvvQFVxAbTyyq
 MuRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755621437; x=1756226237;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jPbJtNIGuJmeIzk0bISBJpiUo0zbOAnZL91+3MTt5qI=;
 b=cWvzGekHef+UuHzGfSnnbqcvHNfHaEqAvv6mnWCNyY030kNPWudi9OiY5oMKmIFMdh
 JRtK54a/jLIureHwqNbYRa7Ch+KtdRh76fyOck93OxIE6NR1uzGy5ACV72P+UpoXycMq
 etbcuXYNpPzctpvpflUbOK0kr0AXHM8IiiAkfjF557sxqQ5M9pfFn0XFcy2Oij35ixEa
 Q1WWYWtPEadI7mzzA6Ah9Gmc10hqxvcf0YZwSdJp1esvITYEmXkPSpDOXmPr0mg5qyw2
 uGul+HOemval7M62Zy1ZxQAXh5gJl4toEuBmVOMl4uYCViApE8fFKboItYSOs8oMXFfg
 2LDQ==
X-Gm-Message-State: AOJu0Yw6hdpTn4DyusxCoJnp/9UfEZnvvWaxHpQiu7ub8vK29f+zsiXM
 p1IQtZrhG5v6hOvdJhfCxGPY8nV8+gbtsmlVZF5uXW19J60vIsToj3HD3FrOJ2aOKr9jwcGIhPh
 KHIh1zE6zTW7O1SNvA1QzVTUXj15ca1JZmSJxyDNA1Q==
X-Gm-Gg: ASbGncu6eBZxdRZj71syHR5KfyIs+P8dhlV5JzlbPo4mZVdfGIOI6dBWHYSge7+R83I
 Ih1a8vM9tUtsuP3SWl4F9TlC5/oWQLuTJfGrN62DFp8tQerMXRjU4GK4goAclZiY2AuaeO+AWZx
 M4W3JEgtMqdOxLRL0ahGpQC6ogI3lDffCCl4dGHHISfPAzl3Hhijz0v3O/nsZD86Ok/XSyezwyk
 SpxWlYb
X-Google-Smtp-Source: AGHT+IHU0PZOrNF+G6CogaiPvgUR2da6Yfk3aK1TtxrsEigdlLwed+dnkQ7qPa714VRqoyGCV9Uphl0IHU7ABopoJWw=
X-Received: by 2002:a05:6902:240c:b0:e94:e1e5:377e with SMTP id
 3f1490d57ef6-e94e63ea925mr3537147276.52.1755621436699; Tue, 19 Aug 2025
 09:37:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250815090113.141641-1-corvin.koehne@gmail.com>
 <20250815090113.141641-2-corvin.koehne@gmail.com>
In-Reply-To: <20250815090113.141641-2-corvin.koehne@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Aug 2025 17:37:04 +0100
X-Gm-Features: Ac12FXxU1KiaO6nl9P_kPL-RDuDO0lX5HE7-V1qW95Svbphp6nil93_osFbPvBY
Message-ID: <CAFEAcA8opzjChTA7UONEPtrUnQ-xayoMgxH5gK9Bi-_VnMXjUQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/14] hw/timer: Make frequency configurable
To: =?UTF-8?Q?Corvin_K=C3=B6hne?= <corvin.koehne@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Corvin_K=C3=B6hne?= <c.koehne@beckhoff.com>, 
 qemu-arm@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, 
 =?UTF-8?Q?Yannick_Vo=C3=9Fen?= <y.vossen@beckhoff.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b33;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb33.google.com
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

On Fri, 15 Aug 2025 at 10:01, Corvin K=C3=B6hne <corvin.koehne@gmail.com> w=
rote:
>
> From: YannickV <Y.Vossen@beckhoff.com>
>
> The a9 global timer and arm mp timers rely on the PERIPHCLK as
> their clock source. The current implementation does not take
> that into account. That causes problems for applications assuming
> other frequencies than 1 GHz.
>
> We can now configure frequencies for the a9 global timer and
> arm mp timer. By allowing these values to be set according to
> the application's needs, we ensure that the timers behave
> consistently with the expected system configuration.
>
> The frequency can also be set via the command line, for example
> for the a9 global timer:
> -global driver=3Darm.cortex-a9-global-timer,
>         property=3Dcpu-freq,value=3D1000000000

-global is a rare thing for special cases, you don't
need to mention it here. The standard case should be
"the SoC configures the device correctly".

> Information can be found in the Zynq 7000 SoC Technical
> Reference Manual under Timers.
> https://docs.amd.com/r/en-US/ug585-zynq-7000-SoC-TRM
>
> Signed-off-by: Yannick Vo=C3=9Fen <y.vossen@beckhoff.com>
> ---
>  hw/timer/a9gtimer.c            |  8 +++++---
>  hw/timer/arm_mptimer.c         | 15 +++++++++++----
>  include/hw/timer/a9gtimer.h    |  1 +
>  include/hw/timer/arm_mptimer.h |  2 ++
>  4 files changed, 19 insertions(+), 7 deletions(-)
>
> diff --git a/hw/timer/a9gtimer.c b/hw/timer/a9gtimer.c
> index 9835c35483..a1f5540e75 100644
> --- a/hw/timer/a9gtimer.c
> +++ b/hw/timer/a9gtimer.c
> @@ -63,9 +63,9 @@ static inline int a9_gtimer_get_current_cpu(A9GTimerSta=
te *s)
>  static inline uint64_t a9_gtimer_get_conv(A9GTimerState *s)
>  {
>      uint64_t prescale =3D extract32(s->control, R_CONTROL_PRESCALER_SHIF=
T,
> -                                  R_CONTROL_PRESCALER_LEN);
> -
> -    return (prescale + 1) * 10;
> +                                  R_CONTROL_PRESCALER_LEN) + 1;
> +    uint64_t ret =3D NANOSECONDS_PER_SECOND * prescale * 10;
> +    return (uint32_t) (ret / s->cpu_clk_freq_hz);

Why the cast to uint32_t here ?

If you are doing an "x * NANOSECONDS_PER_SECOND / frequency"
calculation, use muldiv64(). (This does the calculation with a
96 bit intermediate result.)

>  }
>
>  static A9GTimerUpdate a9_gtimer_get_update(A9GTimerState *s)
> @@ -374,6 +374,8 @@ static const VMStateDescription vmstate_a9_gtimer =3D=
 {
>  };
>
>  static const Property a9_gtimer_properties[] =3D {
> +    DEFINE_PROP_UINT64("cpu-freq", A9GTimerState, cpu_clk_freq_hz,
> +                       NANOSECONDS_PER_SECOND),

You could have a comment mentioning that this default is 1GHz.

The modern way to do this is to have a Clock property, but
we have enough existing timer devices that take an integer
frequency that I don't object to another one.

>      DEFINE_PROP_UINT32("num-cpu", A9GTimerState, num_cpu, 0),
>  };
>
> diff --git a/hw/timer/arm_mptimer.c b/hw/timer/arm_mptimer.c
> index 803dad1e8a..a748b6ab1a 100644
> --- a/hw/timer/arm_mptimer.c
> +++ b/hw/timer/arm_mptimer.c
> @@ -59,9 +59,11 @@ static inline void timerblock_update_irq(TimerBlock *t=
b)
>  }
>
>  /* Return conversion factor from mpcore timer ticks to qemu timer ticks.=
  */
> -static inline uint32_t timerblock_scale(uint32_t control)
> +static inline uint32_t timerblock_scale(TimerBlock *tb, uint32_t control=
)
>  {
> -    return (((control >> 8) & 0xff) + 1) * 10;
> +    uint64_t prescale =3D (((control >> 8) & 0xff) + 1);
> +    uint64_t ret =3D NANOSECONDS_PER_SECOND * prescale * 10;
> +    return (uint32_t) (ret / tb->freq_hz);
>  }
>
>  /* Must be called within a ptimer transaction block */
> @@ -155,7 +157,7 @@ static void timerblock_write(void *opaque, hwaddr add=
r,
>              ptimer_stop(tb->timer);
>          }
>          if ((control & 0xff00) !=3D (value & 0xff00)) {
> -            ptimer_set_period(tb->timer, timerblock_scale(value));
> +            ptimer_set_period(tb->timer, timerblock_scale(tb, value));
>          }
>          if (value & 1) {
>              uint64_t count =3D ptimer_get_count(tb->timer);
> @@ -222,7 +224,8 @@ static void timerblock_reset(TimerBlock *tb)
>          ptimer_transaction_begin(tb->timer);
>          ptimer_stop(tb->timer);
>          ptimer_set_limit(tb->timer, 0, 1);
> -        ptimer_set_period(tb->timer, timerblock_scale(0));
> +        ptimer_set_period(tb->timer,
> +            timerblock_scale(tb, tb->control));
>          ptimer_transaction_commit(tb->timer);
>      }
>  }
> @@ -269,6 +272,7 @@ static void arm_mptimer_realize(DeviceState *dev, Err=
or **errp)
>       */
>      for (i =3D 0; i < s->num_cpu; i++) {
>          TimerBlock *tb =3D &s->timerblock[i];
> +        tb->freq_hz =3D s->clk_freq_hz;
>          tb->timer =3D ptimer_init(timerblock_tick, tb, PTIMER_POLICY);
>          sysbus_init_irq(sbd, &tb->irq);
>          memory_region_init_io(&tb->iomem, OBJECT(s), &timerblock_ops, tb=
,
> @@ -283,6 +287,7 @@ static const VMStateDescription vmstate_timerblock =
=3D {
>      .minimum_version_id =3D 3,
>      .fields =3D (const VMStateField[]) {
>          VMSTATE_UINT32(control, TimerBlock),
> +        VMSTATE_UINT64(freq_hz, TimerBlock),
>          VMSTATE_UINT32(status, TimerBlock),
>          VMSTATE_PTIMER(timer, TimerBlock),
>          VMSTATE_END_OF_LIST()

You cannot add fields to a VMStateDescription without doing
something to handle migration compatibility. Fortunately,
in this case you don't need to add the field at all -- freq_hz
is a property value that cannot be updated by the guest at
runtime, so it doesn't need to be saved for migration.

> @@ -301,6 +306,8 @@ static const VMStateDescription vmstate_arm_mptimer =
=3D {
>  };
>
>  static const Property arm_mptimer_properties[] =3D {
> +    DEFINE_PROP_UINT64("clk-freq", ARMMPTimerState, clk_freq_hz,
> +                       NANOSECONDS_PER_SECOND),

Can we be consistent about the property name and state struct
field that we use, please?

The one that seems to be most used in hw/timer/ is
a property name "clock-frequency" and a field name freq_hz.

thanks
-- PMM

