Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 867BBC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 13:29:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0LdI-0003TS-Hl; Fri, 26 Apr 2024 09:28:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s0LdE-0003Pz-7L
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 09:28:53 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s0Ld9-00055u-N0
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 09:28:50 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-57232e47a81so3664598a12.0
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 06:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714138125; x=1714742925; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jatnww9NRbQOfViMHrcl/hzzBD0uBtQqz7689R7WhE8=;
 b=dJ3poKabWF1xB7onMxT13TDdh9buyW387laNfMi9C/DrX3+HbNFO2gWEtZdypm2t4P
 Loi4kcEogbg+KBeVUCWDcSou51+sryD1zZ85u2kMbh/ZbAj88TqOv1FoT8XaBq5ZuA/m
 zrEvzwKDxuwnbuAMnfou2py7ckJKjl+0T3seVB+sQBpbeldaUturvIOFPopDOhixPfff
 ZzygWq30xxUjNrkMQo2LfAeh0EV2qUJ6cQVo0X96x0Qwc1J55/Jt/fI2jB8VtoqerIEm
 mYrrTmp5lMRhRC1f00kIhBhIcPf7xzhN6ogQ6cbFMJU1a8yrohf7gT+cE2GkLf84KPDY
 WjFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714138125; x=1714742925;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jatnww9NRbQOfViMHrcl/hzzBD0uBtQqz7689R7WhE8=;
 b=AK904lMWaQFG8p+gc5W6fQFq8oYRLy2yQdZ4ArDsxnnK+epc2d6rcJv+BHLG4XeqbJ
 oCFdv3ds3rDuLrqH+jIBsqg+G8z1SZwEB5ZeA0W2wy0GLfhXIbC6ikfQoHaPrmUVYj7s
 3ku2qZUyKUAkcxs/w94Y0FYK6zLGhPFZDQd7h/YKjfBSMXgQgLOqbtzKJaNQ/X2WQHbs
 cwWxp0qXu/ZpFACvmWGbgxh/wh5EG7DubDwi1x21odXRpja1CxkAZ58+38lg9ST2+tSZ
 Rd/Xo6OeIVE39BNJm26J+RdNfof57iMhhs35dkkzu+G2+UHQtMubFyEfoTnDi1AXxID4
 f4kQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVa+TykI94rw9qb9XUEGhDSsTkAH7e31gBNbDDC9PgzCR8tHRB/GzcKhRYtFDdjhDuKHCIY4Lp4SwN2iny9f0o8xGdlTus=
X-Gm-Message-State: AOJu0YzneZ+ccG6YuwmOK0Uuoi7rXvAzJYrABeGCpu+oj7I17VNwpZaz
 f3Wm4Ql5vc6fdntNbw2bFcabxqCPSZ5xarZY9J2ZklIYtIQH+xBvxcHG+NR5TmWY3Q67GCM3qqs
 pyyVnf8QouG3oMgmId2JLuZ8y8znyASGwmxVAHA==
X-Google-Smtp-Source: AGHT+IEqwjfhsNj9zLi7H96bL4pYjZJxhsZm/9MkvJIav7gLFsNN8Y7ZlRxUN/16A4J0MjeDsES3r5IBgm9cjudTbZE=
X-Received: by 2002:a50:c044:0:b0:572:3f71:161f with SMTP id
 u4-20020a50c044000000b005723f71161fmr4494451edd.12.1714138125068; Fri, 26 Apr
 2024 06:28:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240426122913.3427983-1-peter.maydell@linaro.org>
 <20240426122913.3427983-4-peter.maydell@linaro.org>
 <36b9a714-44ff-4b60-a23d-89672a98f46e@linaro.org>
In-Reply-To: <36b9a714-44ff-4b60-a23d-89672a98f46e@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Apr 2024 14:28:33 +0100
Message-ID: <CAFEAcA-ajhEXq4wJW-qp_scL0JqfJXCzZNvtmHtQEJLcRhj7-A@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] hw/watchdog/sbsa_gwdt: Make watchdog timer
 frequency a QOM property
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Radoslaw Biernacki <rad@semihalf.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>, 
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Fri, 26 Apr 2024 at 13:46, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Hi Peter,
>
> On 26/4/24 14:29, Peter Maydell wrote:
> > Currently the sbsa_gdwt watchdog device hardcodes its frequency at
> > 62.5MHz. In real hardware, this watchdog is supposed to be driven
> > from the system counter, which also drives the CPU generic timers.
> > Newer CPU types (in particular from Armv8.6) should have a CPU
> > generic timer frequency of 1GHz, so we can't leave the watchdog
> > on the old QEMU default of 62.5GHz.
> >
> > Make the frequency a QOM property so it can be set by the board,
> > and have our only board that uses this device set that frequency
> > to the same value it sets the CPU frequency.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   include/hw/watchdog/sbsa_gwdt.h |  3 +--
> >   hw/arm/sbsa-ref.c               |  1 +
> >   hw/watchdog/sbsa_gwdt.c         | 15 ++++++++++++++-
> >   3 files changed, 16 insertions(+), 3 deletions(-)
>
>
> > diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> > index 36f6f717b4b..57c337fd92a 100644
> > --- a/hw/arm/sbsa-ref.c
> > +++ b/hw/arm/sbsa-ref.c
> > @@ -543,6 +543,7 @@ static void create_wdt(const SBSAMachineState *sms)
> >       SysBusDevice *s =3D SYS_BUS_DEVICE(dev);
> >       int irq =3D sbsa_ref_irqmap[SBSA_GWDT_WS0];
> >
> > +    qdev_prop_set_uint64(dev, "clock-frequency", SBSA_GTIMER_HZ);
>
> Since we have access to the CPU and its generic timer, what about
> just keep the wdg in sync, as smth like:
>
>    qdev_prop_set_uint64(dev, "clock-frequency",
>                         object_property_get_uint(OBJECT(some_cpu),
>                                                  "cntfrq", errp));

That introduces an implicit ordering requirement that
the CPU has been created before the watchdog, which I'm
not super enthusiastic about. "The platform knows the
frequency and sets it on the devices that care" seems
more straightforward to me.

(The really-follow-the-hardware approach here would be to
model the memory mapped system counter and then wire that
up to both the CPUs and the watchdog, but that's a lot
of extra work. I have some half-baked patches in that
direction but for the moment I figure doing the simple
thing is all we need.)

-- PMM

