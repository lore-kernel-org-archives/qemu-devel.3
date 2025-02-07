Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D66A2C02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 15:46:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgQYU-0001b7-C5; Fri, 07 Feb 2025 10:46:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tgQYS-0001Zz-0c
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 10:46:08 -0500
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tgQYQ-0001UC-4D
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 10:46:07 -0500
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e549be93d5eso2121787276.1
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 07:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738943164; x=1739547964; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8qHfuiv8szYGuQBfQUNagT+/VtxVwpzCJYe+xzLSfJI=;
 b=iQ6lae0LICGASnHx291Egax+43yQhvIBIYg1/vJUwBO5Y7vwqMKCT92t44wl+IC9Rg
 FkDYhAWuJS2+lD/qLHdJZGMvrS9yTpCn6b14eLTg2ggjEtYiwA/XkpDnGZ2hyovqZN38
 +BCeaVkmnSjySG8nLU6kaZp0CCTp8xYxtjm8xCSHTEr07ymmki9SCIsI19eyl/6nL8yf
 kcFHWFYWM2f88BWC45qMNBF+HCIWWQQ3jsLvJXsq7fvMV5CnKu+QyChCP/Uty4u9Vim/
 W52Qz0uFVXXJiVgpJTI1r1uXRhder3dKgyxBRU4aHuS5fZfttjNekvJXfWddLE2WQisV
 jVHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738943164; x=1739547964;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8qHfuiv8szYGuQBfQUNagT+/VtxVwpzCJYe+xzLSfJI=;
 b=TTtJadZ96mNmlA5xoFFHss5Gec6f/uN4w2lfGOVMAsnuonOrUqhaER8pJxlwmkONiG
 BEztHxikALUAVBsZLExl3Xj93KXYhKJN1O3kN/y7s5uDmBHqxePOOgTQda+uONj0tMuN
 UlkneFnCxZSNGETS0J4e5GH2RWIXk6UWfbcdfn7Xc62u5hcrrXN6+ObQHCV4jH1ZSwxu
 kP+rc2qrhn3G/Mn5Fl6HL6dzrUEFvBh85bnizqEbo+EV5bBa9COS4AoLk4ZgB0ci/5F2
 2txiL5+At9K73odP54+kFBOSQjEGsIg/n19bN3Gcl8Ag7mXv3NCVSkc4MZABx6IL3r56
 iSAQ==
X-Gm-Message-State: AOJu0YzUCvUFqi8cxFcndfC5d8injoKPN/JgqtctlYG3YaA7q3rgyGR5
 lpULEXuCW8TU1owm6ZEYSG58NGfKBWtOdJRGdYhCEWPTtqIbIrubojU36CAHpQvAYY4IpMffL9s
 lVNDXsWsZrsUvftWK/p0UFNq22D9+3Ec5wwIaScRqT89oXdQP
X-Gm-Gg: ASbGncuecW8+LDgL+6SDZJoQDClIMYqU9s2X7PxzG5nBhDbLZEQ6bwrXQSFcHy4LsAk
 lxvf/ajBv3ux7vGudKJ0agzxOgi5br+lKBZHYWGVnZxyIp0U9QWJH2aBvTTAXekJNnjwYzS/EmA
 ==
X-Google-Smtp-Source: AGHT+IG96PO/WT4Y1iZvBDavJypKJGCuobMLX37Y8etZTCazGr9wNy9osAjN4dIa4/vXxIH3quCxdfD9G9IncTROsOk=
X-Received: by 2002:a05:6902:1249:b0:e5b:248a:bf2f with SMTP id
 3f1490d57ef6-e5b4626c51cmr3228852276.31.1738943164092; Fri, 07 Feb 2025
 07:46:04 -0800 (PST)
MIME-Version: 1.0
References: <20240615185423.49474-1-florian.lugou@provenrun.com>
 <CAFEAcA_+WrzM4fXQMUxMi3L5yiUWMrUGTSZH=NDdYDKUCP+8NQ@mail.gmail.com>
 <20240620135627.qxcrkdx5v7wdurx4@flugou-latitude5401>
 <CAFEAcA-ngrrEUDD7eA_sOLGF+_wRCuQVxTwuCA4pXjRcuJucmA@mail.gmail.com>
 <20240621140725.f4hsasmhrhh4joxm@flugou-latitude5401>
 <CAFEAcA9c9hbpsdyc7+=QEOZGrNY2m-urk6VrWdwCdfk9ipkwpw@mail.gmail.com>
 <20240820113024.53tmzejw2omm6bbx@flugou-latitude5401>
 <CAFEAcA9X0w5QW2qnnhF2k72ZrS8SALWiXV7uNr1e=jQnZvrQ7Q@mail.gmail.com>
In-Reply-To: <CAFEAcA9X0w5QW2qnnhF2k72ZrS8SALWiXV7uNr1e=jQnZvrQ7Q@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Feb 2025 15:45:51 +0000
X-Gm-Features: AWEUYZkJW5JQOCs7l_XTcs6Ajx6AeMqHFF_9wUObdj7LlibeladJiY8WEkVxmnI
Message-ID: <CAFEAcA-MrouAPdwpsyojMC-bx4aFtuL=tYZD=2pBS1vP5iicaw@mail.gmail.com>
Subject: Re: [PATCH] target/arm/helper: Fix timer interrupt masking when
 HCR_EL2.E2H == 0
To: qemu-devel@nongnu.org
Cc: "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 Florian Lugou <florian.lugou@provenrun.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b36;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb36.google.com
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

On Thu, 6 Feb 2025 at 15:41, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 20 Aug 2024 at 12:30, Florian Lugou <florian.lugou@provenrun.com> wrote:
> >
> > > > $ aarch64-none-elf-gcc -ffreestanding -nostdlib -T qemu/tests/tcg/aarch64/system/kernel.ld -o test test.S
> > > >
> > > > $ qemu-system-aarch64 \
> > > >         -machine virt,secure=on,gic-version=3 \
> > > >         -cpu cortex-a57 \
> > > >         -kernel test \
> > > >         -display none \
> > > >         -semihosting
> > > >
> > > > $ # Exits after ~1s
> > > >
> > > > $ qemu-system-aarch64 \
> > > >         -machine virt,secure=on,gic-version=3 \
> > > >         -cpu cortex-a57 \
> > > >         -kernel test \
> > > >         -display none \
> > > >         -semihosting \
> > > >         -icount shift=0,sleep=off
> > > >
> > > > ... (hangs until QEMU is killed)

> Somebody else reported a similar issue to this to me this week,
> which reminded me of a different bug that we'd found and fixed
> in the interim, which was enough of a hint that I figured out
> why this wasn't reproducible for me.
>
> This bug only reproduces if your QEMU binary isn't compiled
> with slirp support (which will happen if your host system
> doesn't have libslirp-dev or libslirp-devel installed).
> If slirp is present then the usermode networking backend
> will be present and it always has an active timer. Without
> slirp, the problem manifests when there are no active timers.
>
> You can also repro it on a with-slirp compile by adding
> "-net none" to the command line.
>
> I'll have a look at what the underlying bug is... thanks again
> for the handy test case.

So I've looked at this, and I can see *why* it hangs, but
it looks like a structural problem with icount, which I'm
not super familiar with. Richard, Alex, any suggestions?

The sequence of events is that the test case sets up the
timer with an expiry in the future, enables interrupts,
and then executes a WFI insn. What's supposed to happen is
that the interrupt fires and the test case exits.

In helper_wfi, we set cs->halted and do a cpu_loop_exit(),
so the WFI definitely goes to sleep.

We do fire the timer's callback:
#0  arm_gt_stimer_cb (opaque=0x55870482d670) at ../../target/arm/helper.c:2962
#1  0x00005587013c3c86 in timerlist_run_timers
(timer_list=0x5587042f5950) at ../../util/qemu-timer.c:566
#2  0x00005587013c3d3c in qemu_clock_run_timers
(type=QEMU_CLOCK_VIRTUAL) at ../../util/qemu-timer.c:580
#3  0x0000558701102f4c in icount_notify_aio_contexts () at
../../accel/tcg/tcg-accel-ops-icount.c:73
#4  0x0000558701102faf in icount_handle_deadline () at
../../accel/tcg/tcg-accel-ops-icount.c:88
#5  0x0000558701103ac9 in rr_cpu_thread_fn (arg=0x55870482d670) at
../../accel/tcg/tcg-accel-ops-rr.c:234

and the timer count is correct for the timer expiry, so
this part is OK.

First the arm generic timer code reprograms the QEMU timer
(for an expiry at INT64_MAX, ie "far far future")
by calling timer_mod_ns(). timer_mod_ns() ends up calling
timerlist_rearm(), which calls icount_start_warp_timer().

This is where things go wrong -- icount_start_warp_timer()
notices that all CPU threads are currently idle, and
decides it needs to warp the timer forwards to the
next deadline, which is at the end of time -- INT64_MAX.

But once timer_mod_ns() returns, the generic timer code
is going to raise an interrupt (this goes through the GIC
code and comes back into the CPU which calls cpu_interrupt()),
so we don't want to warp the timer at all. The clock should
stay exactly at the value it has and the CPU is going to
have more work to do.

How is this supposed to work? Shouldn't we only be doing
the "start moving the icount forward to the next deadline"
once we've completed all the "run timers and AIO stuff" that
icount_handle_deadline() triggers, not randomly in the middle
of that when this timer callback or some other one might do
something to trigger an interrupt?

If the arm_gt_stimer_cb() was written in the other order,
so that it first raised the interrupt and then modified
the QEMU timer second, this would happen to work, because
raising the interrupt sets cpu->interrupt_request, which
means that arm_cpu_has_work() returns true, so when
icount_start_warp_timer() calls all_cpu_threads_idle() it
returns false and icount_start_warp_timer() returns without
doing anything. But I don't think there's any reason why
timer callbacks should be obliged to reprogram their timers
last, and in any case you can imagine scenarios where there
are multiple timer callbacks for different timers and it's
only the second timer that raises an interrupt...

thanks
-- PMM

