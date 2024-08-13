Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B901C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 12:14:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdqPC-00045b-Md; Tue, 13 Aug 2024 08:13:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sdqOx-0003uU-K8
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 08:13:28 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sdqOv-0007v7-MT
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 08:13:23 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2f1870c355cso51182361fa.1
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 05:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723551199; x=1724155999; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kWsktjKwmcd8WRnSV7pR1/+wwmW/m1PAvw8UnYHK1/E=;
 b=adDJ6INj81EqSxo7jEJQo4PHuGXCYNTv4MQY9/t8he3j0zURSD7aTTjlFfVW36d9En
 NU4C1s/kJ+B0eIrWAHJTADk+6uEJjRLLWJayQ26Cs+hAgHkBdbBPlOQQXFqTkB8uiJhK
 ZVWx2DAgm7NBx9cjvJAjIFZitOmLlxDbx1zrf+X9MJeaP97lnYU0A0yRVQ67WMw9geg1
 5f0ydnaJQAq+xCCMIC5ZLJiuiMngJfrLGb0eE8CQmbsxjxOxKc1a4SdsLNdco+dD3CCQ
 e0CoPquTdLuWb2qPEdsoiCdihJ37FgFcEcRa3U/bLYczlLIcnRkcNIgVi+dU45llyGxM
 3aVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723551199; x=1724155999;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kWsktjKwmcd8WRnSV7pR1/+wwmW/m1PAvw8UnYHK1/E=;
 b=ZihptWHyWYZEa7EMhrF/Rfi1ZlpTbwvgGUdVPU4Arb4nvCrrU/LDdYs00+x1YwBxVy
 c0RiKD/cT6kMFQae3ZiuhGDvnPVkc3UNUPliYt6n48ipKX/5SGDdBO39pKgCWK3tenUZ
 5bqXa4t2qYqACJqDH8NqQigJ5Jv5FlytllyxsbRxYngZLKh7dCm/xR0LjVAmWaQv7/5J
 x5z+IZhsmrR5UGWcVZoRIv1Tf3Bgh8YU8oFgkmwOm0AtFBvzVxX/sSZ0/P0FQEiKyVbv
 1zs4nEYPV/LtYen2OWPyXwwNxC9Ivnqk9K/3KAFp5iq7rtY6PF0lYxpmltAAQXYEnvBS
 2wFg==
X-Gm-Message-State: AOJu0YwPXn7r0WEeBdglmzFwumWUXonaGRnb5/Tpc7DNE0kdsf7Zagfs
 8hgd7JnZ2mzNXyOn9Ytf9i2qdck6KGHzAGaJzI274cQGkorTLIivKaibMvR1jig7dmBaLjZ+H0D
 +z7qjMoDW6MyMmF6Z8lCzGBi+yc0k/1JcjnMCBkxQ0pisCX7j
X-Google-Smtp-Source: AGHT+IEQKAO7oOqJU829h8PqrNQlAw3CwMjp1JU7WuvpXVzz+FfzyUObrbkSTB70z5QrGtdcOc8s2xyT0pbAgFqcr6I=
X-Received: by 2002:a2e:a7c1:0:b0:2ef:28da:2476 with SMTP id
 38308e7fff4ca-2f2b712f259mr23238631fa.5.1723551198474; Tue, 13 Aug 2024
 05:13:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240615185423.49474-1-florian.lugou@provenrun.com>
 <CAFEAcA_+WrzM4fXQMUxMi3L5yiUWMrUGTSZH=NDdYDKUCP+8NQ@mail.gmail.com>
 <20240620135627.qxcrkdx5v7wdurx4@flugou-latitude5401>
 <CAFEAcA-ngrrEUDD7eA_sOLGF+_wRCuQVxTwuCA4pXjRcuJucmA@mail.gmail.com>
 <20240621140725.f4hsasmhrhh4joxm@flugou-latitude5401>
In-Reply-To: <20240621140725.f4hsasmhrhh4joxm@flugou-latitude5401>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Aug 2024 13:13:07 +0100
Message-ID: <CAFEAcA9c9hbpsdyc7+=QEOZGrNY2m-urk6VrWdwCdfk9ipkwpw@mail.gmail.com>
Subject: Re: [PATCH] target/arm/helper: Fix timer interrupt masking when
 HCR_EL2.E2H == 0
To: Florian Lugou <florian.lugou@provenrun.com>
Cc: qemu-devel@nongnu.org, "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x234.google.com
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

On Fri, 21 Jun 2024 at 15:07, Florian Lugou <florian.lugou@provenrun.com> wrote:
>
> On Thu, Jun 20, 2024 at 08:01:01PM +0100, Peter Maydell wrote:
> > On Thu, 20 Jun 2024 at 14:56, Florian Lugou <florian.lugou@provenrun.com> wrote:
> > >
> > > On Thu, Jun 20, 2024 at 11:43:17AM +0100, Peter Maydell wrote:
> > > > For this timer check, we're doing I think the same thing as the
> > > > pseudocode AArch64.CheckTimerConditions(), which does:
> > > >
> > > >   if (IsFeatureImplemented(FEAT_RME) && ss IN {SS_Root, SS_Realm} &&
> > > >       CNTHCTL_EL2.CNTPMASK == '1') then
> > > >      imask = '1';
> > > >
> > > > so I'm inclined to say that our current implementation in QEMU is correct.
> > >
> > > Indeed. I got confused with the specification, my apologies.
> > >
> > > I am facing an issue with QEMU freezing waiting for a timer interrupt when
> > > running with -icount shift=0,sleep=off. Bissection has shown that the issue
> > > appeared with f6fc36deef6abcee406211f3e2f11ff894b87fa4.
> > >
> > > Further testing suggests that the issue may come from gt_recalc_timer. Calling
> > > gt_update_irq before timer_mod (as it was done before f6fc36deef6a) rather than
> > > at the end of the function solves the issue. Is it possible that timer_mod
> > > relies on cpu->gt_timer_outputs, which has not been modified at this point to
> > > reflect the timer triggering?
> >
> > I don't *think* it ought to care -- timer_mod() tells QEMU's timer
> > infrastructure when to schedule the next timer callback for,
> > and the gt_timer_outputs qemu_irqs tell the interrupt controller
> > that the interrupt lines have changed state.
> >
> > Do you have a reproduce case?
>
> I do:

(Sorry I didn't get back to you on this earlier.)

> $ aarch64-none-elf-gcc -ffreestanding -nostdlib -T qemu/tests/tcg/aarch64/system/kernel.ld -o test test.S
>
> $ qemu-system-aarch64 \
>         -machine virt,secure=on,gic-version=3 \
>         -cpu cortex-a57 \
>         -kernel test \
>         -display none \
>         -semihosting
>
> $ # Exits after ~1s
>
> $ qemu-system-aarch64 \
>         -machine virt,secure=on,gic-version=3 \
>         -cpu cortex-a57 \
>         -kernel test \
>         -display none \
>         -semihosting \
>         -icount shift=0,sleep=off
>
> ... (hangs until QEMU is killed)

For me, with QEMU commit 9eb51530c12ae645b, this test case
exits (doesn't hang) with both these command lines. Do you
still see this bug? I guess it's possible we fixed it in
the last month or so, though I can't see anything obviously
relevant in the git logs.

thanks
-- PMM

