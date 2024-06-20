Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7084DC27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 19:02:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKN29-0004gc-P9; Thu, 20 Jun 2024 15:01:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKN24-0004cW-QX
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 15:01:16 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKN22-0000FB-5v
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 15:01:16 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2ec10324791so13750841fa.1
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 12:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718910072; x=1719514872; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gTzdX5i1gK5T9S5q6ncHTjeUoQ5rRfQBqxKZAfFTfKQ=;
 b=wpQUzmxpsLYRLtRhjyzRkwXtcu2u7joWFm3A7AqwY3m6auBqW+nLv0f/hNL6BgXLq4
 jmzWcRJgoLyJ3QyQIVZTy67+zHuNntF9GyeXT7VyRJCxJ3rLA6qveafllt+T1XHcGJco
 qb8+z1OSIX8QY3ZpGj8SfF44tUVUrK6MmjM1ZGZQV5b134okBwR5yiZl761aIwXQzFlc
 EtsASH0QditIIYzb0pSoWKHllRjS86w5RaqRwLtzsYaIrW20U88AyxT1y/WocWJUggeG
 8bBNJK4Qz7B0UvSRPlM/8l9k+3MJes7NMKDBQGRHFLVXCQKktOxy/jOPvJpTIl8TWGOK
 6C+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718910072; x=1719514872;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gTzdX5i1gK5T9S5q6ncHTjeUoQ5rRfQBqxKZAfFTfKQ=;
 b=Nxl4Dc+y4lhYDWuMvmlBC+4VzyZbY2jmBepAOrJvoLgh4GcNqBlvsPC3P0C5gu3WMq
 +nD4VyrgZfclKIyBBqvYscBr5JcKjJlaJlxvF+FbaM6bjvIsrbJatn4TMB8Sixf5EmHz
 L/of+v0HhHbwcrURZTgmZ4sDdfbynLm0E3aRAIlLrh4DV1kRPTWdYBxu12zSTS5U4Y8e
 wf8/Xwvo2LAd8wgfjrUYV3F/4dpPwt6IWKEKg6O7R59QlRbNWy0EVCDz1fIf/7gNga9j
 WPfF690khih4Z/Z4VQNTQLP5oJQMYioncWywECUYdzOK1hrmqVZpPAeQHSRZJ0pDZhJg
 RrxA==
X-Gm-Message-State: AOJu0YyFasM8gvok2xBjE7NnQ9xAnmX8IT9AT/r9p1tuUFMNC2men+GJ
 j0OfSjV3SrYZMCgm9v/8i7aOIVYs+e1SoWNlX4azumax//qgZ/qEiwHeE6A0OEw7QNuTb6Dum9p
 ijEwmGYIkpD7iK4fC/nJuxki7KJFJVWwrF/1R7g==
X-Google-Smtp-Source: AGHT+IHwCDEc292zkpe/BiBLeaouFUn0J5xYUhe59x1YP7+HRVwuz1VS5rbDQBoNvVGd4XJM6wpAhxivzZ5VyTisumg=
X-Received: by 2002:a2e:9e4c:0:b0:2eb:e471:dc39 with SMTP id
 38308e7fff4ca-2ec3ce9a910mr43665901fa.10.1718910071937; Thu, 20 Jun 2024
 12:01:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240615185423.49474-1-florian.lugou@provenrun.com>
 <CAFEAcA_+WrzM4fXQMUxMi3L5yiUWMrUGTSZH=NDdYDKUCP+8NQ@mail.gmail.com>
 <20240620135627.qxcrkdx5v7wdurx4@flugou-latitude5401>
In-Reply-To: <20240620135627.qxcrkdx5v7wdurx4@flugou-latitude5401>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Jun 2024 20:01:01 +0100
Message-ID: <CAFEAcA-ngrrEUDD7eA_sOLGF+_wRCuQVxTwuCA4pXjRcuJucmA@mail.gmail.com>
Subject: Re: [PATCH] target/arm/helper: Fix timer interrupt masking when
 HCR_EL2.E2H == 0
To: Florian Lugou <florian.lugou@provenrun.com>
Cc: qemu-devel@nongnu.org, "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22d.google.com
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

On Thu, 20 Jun 2024 at 14:56, Florian Lugou <florian.lugou@provenrun.com> wrote:
>
> On Thu, Jun 20, 2024 at 11:43:17AM +0100, Peter Maydell wrote:
> > For this timer check, we're doing I think the same thing as the
> > pseudocode AArch64.CheckTimerConditions(), which does:
> >
> >   if (IsFeatureImplemented(FEAT_RME) && ss IN {SS_Root, SS_Realm} &&
> >       CNTHCTL_EL2.CNTPMASK == '1') then
> >      imask = '1';
> >
> > so I'm inclined to say that our current implementation in QEMU is correct.
>
> Indeed. I got confused with the specification, my apologies.
>
> I am facing an issue with QEMU freezing waiting for a timer interrupt when
> running with -icount shift=0,sleep=off. Bissection has shown that the issue
> appeared with f6fc36deef6abcee406211f3e2f11ff894b87fa4.
>
> Further testing suggests that the issue may come from gt_recalc_timer. Calling
> gt_update_irq before timer_mod (as it was done before f6fc36deef6a) rather than
> at the end of the function solves the issue. Is it possible that timer_mod
> relies on cpu->gt_timer_outputs, which has not been modified at this point to
> reflect the timer triggering?

I don't *think* it ought to care -- timer_mod() tells QEMU's timer
infrastructure when to schedule the next timer callback for,
and the gt_timer_outputs qemu_irqs tell the interrupt controller
that the interrupt lines have changed state.

Do you have a reproduce case?

-- PMM

