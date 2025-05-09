Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 046ABC3ABC9
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 18:16:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDSGP-0004WP-9Y; Fri, 09 May 2025 14:16:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uDSGG-0004Un-Sn
 for qemu-devel@nongnu.org; Fri, 09 May 2025 14:15:52 -0400
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uDSGB-0003Pz-EG
 for qemu-devel@nongnu.org; Fri, 09 May 2025 14:15:51 -0400
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e78f44034ffso2034425276.1
 for <qemu-devel@nongnu.org>; Fri, 09 May 2025 11:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746814545; x=1747419345; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hbHexezCIniT6/VJMLj+dlfWes0HT/WTRJqM0dokmng=;
 b=TJtMxb6tX/71BjnJjcESRU7ukhkZRQ2AaTJyto/tSfKPBe0VRZK6aAzIxEv+0ZSinD
 5p4xQBPxgi1OnsHRkVOycFFobTqpT+57uM47lQB7qZwG/O3JdE9rQT6tZGcCK50gctPJ
 zFNnHslohA9U9jFJj2yuK9nVRaQgdo/7KGQ3P6HLW4BzFCOo2je88h3MD4vJEYHAX6FT
 3O/+TwzoGcRJ30Q71k60XT1QUtfEmf8OUyD8kptaHf+6hVQX3swBTyXKThUqd3LYVrgE
 peWjiUEN+jOscH2SCyaIHWEVHQ/nTflW7OhiRI9aKs3xHnQwushX6BSHPjcf86T7y3tO
 FbzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746814545; x=1747419345;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hbHexezCIniT6/VJMLj+dlfWes0HT/WTRJqM0dokmng=;
 b=c/YIuHIF01Q3721z0OMYd3wOB88NBKHzGN68pbuoDnQaZWnb5BDmBBx2/b4tl38Szw
 ZfZgUY/ScEYplslihW9Y6eUoCFthQB8FKQd8m9ZsM6WEJeOpw4HnlgC7XZ1YqKg+24c1
 Bn+oWP6l7262deOBY9p0/WFQ88uTzSHgFxEFD/cW5YSqJ9z8Klar0bi4yaOe2uPMsvfB
 p3PcDMM7A76PkytaRsQxX1CWgnVjUcr28D36HNGlp8jAhd+f6Ug/a528eahdB5kMAPYm
 M6NmEUEAfmtoYyM4yabZcLVj1LIg+DHniPKf41esR7IjBmQUKw3hdYF1xUbmdZK6bdkN
 A3bA==
X-Gm-Message-State: AOJu0YwFqsTN45kIqrRm9yXgWqlTvnd9nB7dFLGCur2Cf/Hke03k1phT
 8R30VDLRoi8B/TvDPGrLihCsjk6MHKLYfmSNP0ajgKHAyqXPKNyKcuvd+Fd9+axwX8vschzwErs
 kNsL8NqEAyqmC0EHKGuOrawpOoHaCkub1tsW8omAm45T33ZKb
X-Gm-Gg: ASbGncvnpQIL7JET3AxllPDZ910EoiP7MiVmE20W8vi+ygEgfA5kA9X9LPg7uZEbO4I
 kkwlqQkwg0jAs4LPeC+skb6uK3tWVOWpPpgmfYYe2sH4p7nK3qyjmlg6FL4CfqtzJorKh1zFv3H
 4a5vYBZP2Pnb1412XQ0E/6GQE=
X-Google-Smtp-Source: AGHT+IE2Kqqf03yX4pxob22+Hqw0tiBwMgrTtxIA/ynhGSWxfJ3M4Hdkjo8WwO39Jscb0gFkZGNb9vYtp+NcskbRK8g=
X-Received: by 2002:a05:6902:848:b0:e78:f39f:a2f with SMTP id
 3f1490d57ef6-e78fdc0fd32mr6365756276.16.1746814545198; Fri, 09 May 2025
 11:15:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250504103538.888-1-kaidokert@gmail.com>
In-Reply-To: <20250504103538.888-1-kaidokert@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 May 2025 19:15:33 +0100
X-Gm-Features: ATxdqUFI084Pxy6k2GZFfdQKCHJ1aYnQZH_kAmXROSt0sYWbbffwZNT5Kuz9Ypo
Message-ID: <CAFEAcA_7O9hQGXg-aLGjrM5wU3nocrFd1V-42HmQA0aH2Vvd0A@mail.gmail.com>
Subject: Re: [PATCH v1] Implement RTC timer for nRF51
To: Kaido Kert <kaidokert@gmail.com>
Cc: qemu-devel@nongnu.org, joel@jms.id.au, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2b.google.com
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

On Sun, 4 May 2025 at 11:36, Kaido Kert <kaidokert@gmail.com> wrote:
>
> Implements the RTC timer. Implementation is based on
> existing nrf51_timer and other RTCs.
> Event signaling through PPI peripheral is not implemented.
> Tests added in microbit board.
>
> Signed-off-by: Kaido Kert <kaidokert@gmail.com>

Hi; thanks for this patch; generally it looks good. I have some
minor comments below and also one more significant one (about
how you set up the timer).

I note that your email does not seem to have made it to the qemu-devel
mailing list. This may be because there's something wrong at your
end that caused it to fail the dmarc checks; from the headers
in the copy I received because I was directly cc'd:

>Received: from Kaidos-MacBook-Pro.local (static-119-110-246-4.violin.co.th. [119.110.246.4])

>         by mx.google.com with ESMTP id d2e1a72fcca58-7405902815esi7940223b3a.205.2025.05.04.03.36.51
>         for <peter.maydell@linaro.org>;
>         Sun, 04 May 2025 03:36:52 -0700 (PDT)
> Received-SPF: none (google.com: kaidokert@kaidos-macbook-pro.local does not designate permitted sender hosts) client-ip=119.110.246.4;
> Authentication-Results: mx.google.com;
>        spf=none (google.com: kaidokert@kaidos-macbook-pro.local does not designate permitted sender hosts) smtp.mailfrom=kaidokert@kaidos-macbook-pro.local;
>        dmarc=fail (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
> Received: by Kaidos-MacBook-Pro.local (Postfix, from userid 501) id A1F8F4FFB373; Sun,
>   4 May 2025 17:36:50 +0700 (+07)
> From: Kaido Kert <kaidokert@gmail.com>

You might want to have a look at that. (Though occasionally
the mailing list does just silently drop emails it doesn't
like, so the dmarc issue isn't 100% the cause.)

> ---
>  hw/arm/nrf51_soc.c          |  13 ++
>  hw/rtc/Kconfig              |   3 +
>  hw/rtc/meson.build          |   1 +
>  hw/rtc/nrf51_rtc.c          | 373 ++++++++++++++++++++++++++++++++++++
>  hw/rtc/trace-events         |   4 +
>  include/hw/arm/nrf51.h      |   1 +
>  include/hw/arm/nrf51_soc.h  |   2 +
>  include/hw/rtc/nrf51_rtc.h  |  68 +++++++
>  tests/qtest/microbit-test.c | 249 ++++++++++++++++++++++++
>  9 files changed, 714 insertions(+)

This is a pretty big patch, which makes it harder to review.
I would suggest splitting it into three:
 * patch 1: add the new nrf51_rtc device model
 * patch 2: make the nrf51_soc create and connect the RTC device
 * patch 3: add the test case


> diff --git a/hw/rtc/Kconfig b/hw/rtc/Kconfig
> index 315b0e4ecc..18306c5db2 100644
> --- a/hw/rtc/Kconfig
> +++ b/hw/rtc/Kconfig
> @@ -31,3 +31,6 @@ config RS5C372_RTC
>      bool
>      depends on I2C
>      default y if I2C_DEVICES
> +
> +config NRF51_RTC
> +    bool

If you're using a separate CONFIG_NRF51_RTC symbol for this
device, then the hw/arm/Kconfig entry for NFR51_SOC also will need a
"select NRF51_RTC" line, so that when you build a QEMU with
the nrf51 it causes the RTC device to also be built.

> diff --git a/hw/rtc/meson.build b/hw/rtc/meson.build
> index 6c87864dc0..b959c9efe3 100644
> --- a/hw/rtc/meson.build
> +++ b/hw/rtc/meson.build
> @@ -14,3 +14,4 @@ system_ss.add(when: 'CONFIG_LS7A_RTC', if_true: files('ls7a_rtc.c'))
>  system_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-rtc.c'))
>  system_ss.add(when: 'CONFIG_MC146818RTC', if_true: files('mc146818rtc.c'))
>  system_ss.add(when: 'CONFIG_RS5C372_RTC', if_true: files('rs5c372.c'))
> +system_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_rtc.c'))

If you're giving the RTC device its own CONFIG_NRF51_RTC
symbol (which is a reasonable thing to do) then you need to
specify that here. On the other hand if you prefer to follow
what the existing NRF51 devices do and just use CONFIG_NRF51_SOC,
then you don't need an entry in hw/rtc/Kconfig defining
NRF51_RTC. (I don't mind which approach we take.)

> diff --git a/hw/rtc/nrf51_rtc.c b/hw/rtc/nrf51_rtc.c
> new file mode 100644
> index 0000000000..5ffb269133
> --- /dev/null
> +++ b/hw/rtc/nrf51_rtc.c
> @@ -0,0 +1,373 @@
> +/*
> + * nRF51 SoC RTC emulation
> + *
> + * Copyright 2025 Kaido Kert <kaidokert@gmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/rtc/nrf51_rtc.h"
> +#include "hw/irq.h"
> +#include "hw/registerfields.h"
> +#include "hw/sysbus.h"
> +#include "migration/vmstate.h"
> +#include "qemu/log.h"
> +#include "qemu/timer.h"
> +#include "qemu/units.h"
> +#include "system/rtc.h"
> +#include "system/system.h"
> +#include "trace.h"
> +
> +#define NRF51_RTC_SIZE 0x1000
> +#define NRF51_RTC_TICK_HZ 32768 /* 32.768 kHz LFCLK */
> +#define NRF51_RTC_TICK_NS (NANOSECONDS_PER_SECOND / NRF51_RTC_TICK_HZ)
> +
> +/* Register field definitions */
> +FIELD(NRF51_RTC_INTEN, TICK, 0, 1)
> +FIELD(NRF51_RTC_INTEN, OVRFLW, 1, 1)
> +FIELD(NRF51_RTC_INTEN, COMPARE0, 16, 1)
> +FIELD(NRF51_RTC_INTEN, COMPARE1, 17, 1)
> +FIELD(NRF51_RTC_INTEN, COMPARE2, 18, 1)
> +FIELD(NRF51_RTC_INTEN, COMPARE3, 19, 1)
> +
> +/* 24-bit counter mask */
> +#define BIT24_MASK 0xFFFFFF
> +
> +/* Map event address to s->events index */
> +static int nrf51_rtc_event_index(hwaddr addr)
> +{
> +    switch (addr) {
> +    case NRF51_RTC_EVENTS_TICK:
> +        return 0;
> +    case NRF51_RTC_EVENTS_OVRFLW:
> +        return 1;
> +    case NRF51_RTC_EVENTS_COMPARE0:
> +        return 2;
> +    case NRF51_RTC_EVENTS_COMPARE1:
> +        return 3;
> +    case NRF51_RTC_EVENTS_COMPARE2:
> +        return 4;
> +    case NRF51_RTC_EVENTS_COMPARE3:
> +        return 5;
> +    default:
> +        return -1; /* Invalid */

Unless I missed a callsite, I think we only call this
from the switch statements in the read and write
functions, where we can guarantee that the 'addr'
argument is one of the 6 valid values.

If that's the case, then we can g_assert_not_reached()
in the default case, and don't need to handle -1
in the callsites.

> +    }
> +}

> +static void nrf51_rtc_tick(void *opaque)
> +{
> +    NRF51RTCState *s = opaque;
> +    uint64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +    uint64_t elapsed_ns = now - s->last_update;
> +    uint64_t tick_period_ns = NRF51_RTC_TICK_NS * (s->prescaler + 1);
> +    uint32_t num_ticks = elapsed_ns / tick_period_ns;
> +
> +    /* Schedule next tick before any early returns */
> +    timer_mod_ns(s->timer, now + tick_period_ns);
> +
> +    if (!s->powered || s->last_update == 0) {
> +        s->last_update = now;
> +        /*  Skip increment on first tick */
> +        return;
> +    }
> +
> +    for (uint32_t tick = 0; tick < num_ticks; tick++) {
> +        s->tick_count = (s->tick_count + 1) & BIT24_MASK; /* 24-bit counter */
> +        /*
> +         * Check for tick event. Note: Events are always generated
> +         * regardless of EVTEN register settings. EVTEN only controls
> +         * PPI routing of events.
> +         */
> +        s->events[NRF51_RTC_EVENT_TICK] = 1;
> +
> +        /* Check for overflow (24-bit counter) */
> +        if (s->tick_count == 0) {
> +            s->events[NRF51_RTC_EVENT_OVRFLW] = 1;
> +        }
> +
> +        /* Check compare registers */
> +        for (int i = 0; i < 4; i++) {
> +            if (s->tick_count == s->cc[i]) {
> +                s->events[NRF51_RTC_EVENT_COMPARE + i] = 1;
> +            }
> +        }
> +    }
> +
> +    s->last_update += num_ticks * tick_period_ns;
> +    nrf51_rtc_update_irq(s);
> +}


> +static void nrf51_rtc_write(void *opaque,
> +                            hwaddr addr,
> +                            uint64_t value,
> +                            unsigned size) {
> +    NRF51RTCState *s = opaque;
> +
> +    if (!s->powered && addr != NRF51_RTC_POWER) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: write at 0x%" HWADDR_PRIx " when powered off\n",
> +                      __func__,
> +                      addr);
> +        return;
> +    }
> +
> +    switch (addr) {
> +    case NRF51_RTC_TASKS_START:
> +        if (value == 1) {
> +            s->running = true;
> +            s->last_update = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +            timer_mod_ns(s->timer,
> +                         s->last_update +
> +                             NRF51_RTC_TICK_NS * (s->prescaler + 1));

This logic looks like it's setting a timer to tick at
whatever the RTC tick rate is, and then in the tick handler
checking against the events[] and for overflow. This is
inefficient and you should avoid it. Instead you do the
calculation of when the next actual interesting tick
will be (closest event, or the rollover tick if that's closer),
and set the timer to only fire then. Otherwise we spend a lot
of time firing the timer and having the timer event handler
say "actually nothing to do here".

> +static const VMStateDescription nrf51_rtc_vmstate = {
> +    .name = TYPE_NRF51_RTC,
> +    .version_id = 1,
> +    .fields = (const VMStateField[]){VMSTATE_UINT32(tick_count, NRF51RTCState),
> +                                     VMSTATE_UINT64(last_update, NRF51RTCState),
> +                                     VMSTATE_UINT32(prescaler, NRF51RTCState),
> +                                     VMSTATE_BOOL(running, NRF51RTCState),
> +                                     VMSTATE_BOOL(powered, NRF51RTCState),
> +                                     VMSTATE_BOOL(irq_pending, NRF51RTCState),
> +                                     VMSTATE_UINT32(inten, NRF51RTCState),
> +                                     VMSTATE_UINT32(evten, NRF51RTCState),
> +                                     VMSTATE_UINT32_ARRAY(cc, NRF51RTCState, 4),
> +                                     VMSTATE_UINT32_ARRAY(events,
> +                                                          NRF51RTCState,
> +                                                          6),
> +                                     VMSTATE_END_OF_LIST()},

This is oddly indented. Follow the indent approach in e.g.
hw/timer/nrf51_timer.c for the vmstate struct array, please.

thanks
-- PMM

