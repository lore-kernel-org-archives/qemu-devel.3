Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F53C021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 15:21:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlUp6-0000kl-Ev; Fri, 21 Feb 2025 10:20:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tlUp3-0000iX-Pn
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 10:20:13 -0500
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tlUp1-0004rG-Ku
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 10:20:13 -0500
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e53c9035003so1794911276.2
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 07:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740151209; x=1740756009; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XSDAHvEbkT5xksXiEVIMCA8IVl9lUdWp1T6qXeFjpRk=;
 b=aTyF8VN/pN8qEfsAXr+kfHVqNHvIxJUjCfZFMZH25tYdi2P1DV74JMoprjdDpq1mLP
 nbMvcM2oJ4BsOGYQp0gPh+efeRqr34ho4rcptNxZZK+tZedxaDeHtQTggHdb5FaP1fEt
 X1j66PMvJm7Q2cXErfhG0c6L6hI5qm4GEyZsNXFQKJKJ4ZwgJdygpLHV6jPpYeTsAg3u
 /HSzlPOaVtWZN21a/A2FMIyXNo3SxTxbAo8YuRc1MQVEPtxaOKNm6oioVb4K00ykBXK9
 giLSvh/KtIZz8GdgPHw7QGrT+LzpyWGpvymGxjBkdHMiKsVEFkC3DqB5hGoFTIYGVQIK
 tLIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740151209; x=1740756009;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XSDAHvEbkT5xksXiEVIMCA8IVl9lUdWp1T6qXeFjpRk=;
 b=sgnm2MTm01m05B2kWr4OEcuP1usN12Aa+DzF3Oyv+pE8LgI1cg2ySgMss0ci1SW/hC
 8AeZNWzXwdbk5EyY7+dYl2JxLVw2BzU9AoAL1yxSZ2raWEw4Hl3gnbnW0AQViAIls1js
 L649c13mwpmCDHJNdpu+lcFRFaPR7bGs0VkxT5aSGEJIgxq/Mf3NSYArbxMirMDNVSk2
 bmFGsfEM4ViCvajceWmTUzlGS7gisTzYqUqvMJro2RolXD4z0BFZsiGvgRg1IwqY8jjZ
 3c+pzjdh0QCucuCKlq4LJG/u9SeTkwEA9t76hEWTtU31+wcIn2HI9CXy1N5PIrYbeY7F
 0xLw==
X-Gm-Message-State: AOJu0YyrkXfqjTtLAYMczIua0cMPnD3uvVlb3qJByEGeRGRfdXObWIcu
 utjLjrBCDCydK9GifMIz6F3bVlI6ZiFIWVB+2hoPsKklrnEKzQFYT6WyX2Q0hotcRd2hsevvwGI
 5pC8rgF3R0EhHRSdf0oL/YLNN0UWwV4iqbN5h0A==
X-Gm-Gg: ASbGncvVxbkBOBh6rklfEs73vwY7fQHC7WIg97TfxYe8WZ9GDZhN3kHW/DqVVPZW5nZ
 NNNOkvV52GUJxyL2JYuZaFLlxooYGlcAy+hE+cgkm93Z3GTidTQJxdp8Z/1O4avI+nD3AvjcQ/c
 0qx3EdF5mP
X-Google-Smtp-Source: AGHT+IHW1IWaWzuXpvpIgVzFwIYltGnSg21EgRGDrBiO+PR+h46T+GVpSDPUFsKRHRx4Ubu5kRY3OmkKV74q0yVRsCQ=
X-Received: by 2002:a05:6902:1009:b0:e58:493c:e9c0 with SMTP id
 3f1490d57ef6-e5e246016f6mr2870004276.22.1740151209614; Fri, 21 Feb 2025
 07:20:09 -0800 (PST)
MIME-Version: 1.0
References: <20250217125055.160887-1-peter.maydell@linaro.org>
 <93307c7c-c29f-4061-94ae-461bf196ff41@linaro.org>
In-Reply-To: <93307c7c-c29f-4061-94ae-461bf196ff41@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Feb 2025 15:19:58 +0000
X-Gm-Features: AWEUYZlIL0X-Z4r2h3R20CvlZNI_aKi1J5g88vpQJVzJfRPCMW9Z45biQ4rCaHQ
Message-ID: <CAFEAcA9A018e6FuVuY8YcWw+jHAxLZ5qVQ25P7ym4nE6qWeQAg@mail.gmail.com>
Subject: Re: [PATCH 00/10] fpu: Remove remaining target ifdefs and build only
 once
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2e.google.com
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

On Fri, 21 Feb 2025 at 14:41, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 17/2/25 13:50, Peter Maydell wrote:
>
> > (1) floatx80 behaviours
> >
> > Two QEMU targets implement floatx80: x86 and m68k. (PPC also has one
> > use in the xsrqpxp round-to-80-bit-precision operation, and the
> > Linux-user NWFPE emulation nominally supports it, but these are
> > minor.) x86 and m68k disagree about some of the corner cases of
> > floatx80 where the value has the explicit Integer bit wrongly set.  At
> > the moment the fpu code defaults to "floatx80 behaves like x86", with
> > TARGET_M68K ifdefs to get the other option.
> >
> > The first six patches in this series remove those ifdefs, replacing
> > them with a floatx80_behaviour field in float_status which can have
> > various flags set to select the individual behaviours. The default is
> > "like x86", which allows us to set these only for m68k and not worry
> > about the minor "technically makes some use of floatx80" cases.
>
>
> > Peter Maydell (10):
> >    fpu: Make targets specify floatx80 default Inf at runtime
> >    target/m68k: Avoid using floatx80_infinity global const
> >    target/i386: Avoid using floatx80_infinity global const
>
> Bothering again, we can add the floatx80_default_inf() refactor as the
> first patch:

I really think at this point this is just doing extra
work shuffling code changes between patches for no real benefit.
The patches aren't super huge and they've already been
reviewed. I'm OK with splitting out the "add the status
argument" part as you suggested previously, as that
makes the patches more reasonably split between "just
mechanical" and "interesting change" which is not a big
split to do and could be helpful for potential bisection
later, but churning the patchset beyond that doesn't
seem worthwhile to me.

-- PMM

