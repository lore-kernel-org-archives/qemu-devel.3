Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0932FD3398F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 16:20:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRYXp-0004CK-6h; Fri, 05 Dec 2025 11:20:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vRYXo-0004C5-Fw
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 11:20:32 -0500
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vRYXm-0001cR-RN
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 11:20:32 -0500
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-78a6a7654a4so24016427b3.0
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 08:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764951629; x=1765556429; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+l5cEhnIun7wAe0MRo0wVWMMNn86PpFQzKbyjtfNbmA=;
 b=Zt5raBxNeCTEbP2SxpFTSxIxhs/JtiZSaLhGXUTyvC2M5gmn5Um97BKvvAE/AxS4IA
 xeHOS4TI34QBdkuxCpMSBicqgj5dKPI3ExDZalPVaEEJWkIEzr8t5qeSWL8y1yg0Tk58
 5A2ZdfjW2qPqiR9xR5Hu9JoaP+AKFKx2fu3zqQBpl+lmh40HRX60EXRX10Lp9v8618mh
 c1VnrmKgsLvrJEMVTf0WW+iw2P8Idy7F9AZ/XkArIFph5oyPUgwyZ9wCZUZxm/1mqDm1
 RmoaqBrLALYdg8osB2QEKofuyoHVwoIQLEfkQeABbK90dwX6TjzLWHEldBdB2wsvnf8j
 sDhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764951629; x=1765556429;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+l5cEhnIun7wAe0MRo0wVWMMNn86PpFQzKbyjtfNbmA=;
 b=OyD6PDaeZ7Awky6dvesxiFtSR0MvDtIqXB/Pl3CbGE/I4g4dO87+kwXoClPDJF7adQ
 kVqnu2htrp9XeonwUle8ht7S3eqtgTEMn1gelR+odbq60L7CqTMSxA0rJ7r1tuAdXg+c
 olOkaxs8LQRdqngg9elsNdzQJrN4KV2rxwCqeHh41+HkkjxL4frt3EsvB/lUkytj9aSr
 4YHwpYZkThoB19bD7ar462lF4yKf5So6WA4Zxtrj61YIR5Jv7T3FkDfbLZVH64P5QCpJ
 +ogHfigOd7DSdGqe0CmkKVkbUQquQ8aNBHr3RbIcB+RSfDoFn1E8AjwGM07qAVzxb77j
 PAbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXo8NYOz3GcqQ12ZLn8tKDL4URDM/UgSDzbUwsMN2FyHRY1E+ZLaySf4sgXhxoIYwaz7vAk/MrlMtD/@nongnu.org
X-Gm-Message-State: AOJu0YzdsH4RUNanxwIDM124zUFWDT0aGpKnR0PuZIduM3tvkjM7fFNo
 sCzjyGzlZ0hZl+w3FRg1cbwjZbSEFyBsqRnr8CwcrhXT1CRMsc71WVfk9NMwrZ9s5qzmp6WQmFs
 Eo6c4aFmYWBe3XSrYuFRGgyhpleTPNN8Bnp3jHxerbA==
X-Gm-Gg: ASbGncsPiey1c/32JjeOERNdxHVF6TQK1pooJdUlJzwQFDXjd1LtjjEpVyVhLO4J0jD
 rvmz4G90OxVqrTWzk7jA+L34KQQNGy7A/cZdo/GgTrj5YiZ0q7lAZ5IAgn0hDUkWZfZ2bSjYbLR
 Y7Sx0uezI+CzzDU2Y2LXHUgTQE5wYdGqp6KN6QkRVmEKR7HObaD9DyoamdavpY4Ob7Szx5MURxl
 J7IIvtoVeL4XkqOwoixbW22wn+4qdc2L2o7aL37O0Nhyz942FDwPDaITeB/vGJt/Ebjv7Bq
X-Google-Smtp-Source: AGHT+IHjb4c7l3Fi3AeQSL7G0fneFH1bFxW9SPVfgQAyNV/oG4dDr1psPxVQXm02Xv6uNYzI1qj8qAN3o9EV1uxGwHI=
X-Received: by 2002:a05:690c:dc4:b0:786:a39e:e836 with SMTP id
 00721157ae682-78c0c1cdabcmr85583937b3.60.1764951629591; Fri, 05 Dec 2025
 08:20:29 -0800 (PST)
MIME-Version: 1.0
References: <20251204193311.1281133-1-jim.macarthur@linaro.org>
 <87qztarkyf.fsf@draig.linaro.org>
 <a605c0b2-8122-424c-a917-7d6ad8371c34@linaro.org>
 <364a1c91-c7a0-41b1-8ae9-902b3158914c@linaro.org>
In-Reply-To: <364a1c91-c7a0-41b1-8ae9-902b3158914c@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Dec 2025 16:20:18 +0000
X-Gm-Features: AWmQ_bl4XzyAgDYRoHaQwDc-iA3SiHR3UJYIa1b6JsQQ8Ih4-8Dw8D4aCfh37wM
Message-ID: <CAFEAcA8rj4oFV57QSiMmtz4WF8zRu04O6nF0auZv8m4tLiATyg@mail.gmail.com>
Subject: Re: [PATCH] hw/dma/omap_dma.c: Use 64 bit maths for
 omap_dma_transfer_setup
To: Jim MacArthur <jim.macarthur@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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

On Fri, 5 Dec 2025 at 16:11, Jim MacArthur <jim.macarthur@linaro.org> wrote=
:
>
>
> On 12/5/25 15:57, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 4/12/25 22:33, Alex Benn=C3=A9e wrote:
> >> Jim MacArthur <jim.macarthur@linaro.org> writes:
> >>
> >>> If both frame and element count are 65535, which appears valid from m=
y
> >>> reading of the OMAP5912 documentation, then some of the calculations
> >>> will overflow the 32-bit signed integer range and produce a negative
> >>> min_elems value.
> >>>
> >>> Raised by #3204 (https://gitlab.com/qemu-project/qemu/-/issues/3204).
> >>>
> >>
> >> nit:
> >>
> >> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/3204
> >
> > Format is:
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3204
> > Fixes: afbb5194d43 ("Handle on-chip DMA controllers in one place")
> >
> I'm unclear on whether this actually resolves or fixes the issue, so I
> just said 'Raised by'. The bug only includes a test case, not a text
> description of the problem. The test case will give a different error if
> this patch is applied, but still doesn't pass. I've mentioned this on
> the bug page.

Generally for this kind of fuzzer-generated bug report, the
bug is "it is possible to make QEMU assert/crash/etc". They
don't come with textual analysis of why exactly we ended up
crashing, because the crash was auto-generated. So the
"what actually happened here" is one of the things you have
to figure out as part of fixing the bug.

If you're satisfied that your fix deals with the problem,
then you can mark it as "Resolves:" for that bug. If it
turns out that the fix accidentally failed to catch the whole
class of problems, then the people running fuzzers will let
us know by filing a fresh bug report at some future point.

thanks
-- PMM

