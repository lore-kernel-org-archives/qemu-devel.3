Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10285CAC5B1
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 14:12:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1mgJ-0002Av-1l; Thu, 25 Sep 2025 10:10:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v1mgE-00029b-2p
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 10:10:42 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v1mgA-000648-Dr
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 10:10:41 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-71d6014810fso9257947b3.0
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 07:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758809432; x=1759414232; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GNCCOulXFWBeqJ1DFKP0YVB2uQ25Uimld+yTpJ41gA4=;
 b=igEPel/29dwEVTWqvEXrCxAgP4pUbVQzJ+cCt5DrbQenP0idORJMVy71JDCxV01KHI
 tQ/2c6gMsW6nRxlD24PkrHlnqs16X6ibLilJHR8jymXWEo5REqFsye9re17OoHFgaYLp
 kQVe0hlyZd0coItkaD+G2sROah6FltdXJim6GaWtV1qxSaBJ1+VQrB+GpC7jX0VZqCAb
 eDBwyAs2rOlSqtFr6REsLJmwcWyJ9kEsS34eo2TN9MAj5yb5O4qCWyG76ZPydUeKvCDK
 WVjhXkNGkbPjbHR67qZkDhDbzm3saWQ/3xV6FuH4Eheb53zA2XfGtPEvpkvfEWyl0The
 jiFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758809432; x=1759414232;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GNCCOulXFWBeqJ1DFKP0YVB2uQ25Uimld+yTpJ41gA4=;
 b=h8utYHCqed8IQ0Cj7/CTIm/JpAzHm1RnnvUGui7BaVqEE63M2mN1tvOL8btGCS1F08
 TAnL+7rLhC9wOuvhZhrwPMD6TKNG7za3dncj197bWgpb0CPDsKlV1KFuOZad95xW3OnM
 dqgzMilr2oejCHcI7jgSXznhCJiuux15MEyF/kUlf+lSS0ngK0mxti+Di/7Eh14uQwaA
 MLDIVI3AN7OU9qSR027Vg5y+4wKX3+KAh5Ppr+eLBUsbcEpjdEVm8UI5YquwsC7MzTwm
 wlFxLn0hifv2s/3sIJLlhfPcoZ+cVvjQAJxmw1YAcflRLQYn2J73a4v3GAo8Gx64wTgb
 AVOw==
X-Gm-Message-State: AOJu0YwK4y7EO/vvZD2STn4zZqmiYk9wk+ZLOQFeb+r5GjxB1Bo0rKTA
 pb+864+xDBhOERmL4hyt4TNavdKd3p+hjycEIYx2ccUciVWMK7d2yEVv2J2sJZjyPfnVYnd8H5y
 zYaUeHo4fcfRwcvM7O/AxLUyvebRzFUN9aizBlBjb32UZd5LFnCyb
X-Gm-Gg: ASbGnctyGbJe9ziKuI5yx/LS8t35Fz4Pyxmo6tNYL1tDB4S8/GvAUlz8jP6NnV5Jrso
 N+V9paepA9ddVO03vp+wWnMoJMeS1sbEeABViPAzQC5evcIZgaiKnjkZUi2oes2Y5hPS/7W72d/
 W04SDu8yyra07ijwqoCjUWxi4bwuns/gmlU70eyLA2D4cbJo56XBP1/bxoY4zzdPHy2tSprjkjt
 lfUSBCH
X-Google-Smtp-Source: AGHT+IEdzWCZzw7y6R5WWPbBJoqJb947idyItJq30+1hQKKLYf+y6MhNht8W7lQFoSrBjHnS6JY7jTxfNkZuawFpOqU=
X-Received: by 2002:a05:6902:4202:b0:ea5:b99f:e910 with SMTP id
 3f1490d57ef6-eb37fc0deeemr3226147276.23.1758809431892; Thu, 25 Sep 2025
 07:10:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250916142238.664316-1-richard.henderson@linaro.org>
 <20250916142238.664316-34-richard.henderson@linaro.org>
 <CAFEAcA8iTS6gpHwchagCFTOwjU=KKOJrmp+d7m4oMR2_xRfvkQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8iTS6gpHwchagCFTOwjU=KKOJrmp+d7m4oMR2_xRfvkQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Sep 2025 15:10:20 +0100
X-Gm-Features: AS18NWAfOEUUmmVdW5aJzZ4Gl5zreQeWjYicctzs9nzhKHdYLzp0QG-OadjYtkw
Message-ID: <CAFEAcA-RToeeQr9x1yhJJhf1UuxYX1hVopatoUkimeQ11iAMGQ@mail.gmail.com>
Subject: Re: [PATCH v2 33/36] target/arm: Redirect VHE FOO_EL1 -> FOO_EL2
 during translation
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 25 Sept 2025 at 14:54, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 16 Sept 2025 at 15:23, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > ---
> >  target/arm/cpregs.h            |  6 ++++
> >  target/arm/gdbstub.c           |  5 ++++
> >  target/arm/helper.c            | 53 +---------------------------------
> >  target/arm/tcg/translate-a64.c |  9 ++++++
> >  4 files changed, 21 insertions(+), 52 deletions(-)
>
> > -/* Test if system register redirection is to occur in the current state.  */
> > -static bool redirect_for_e2h(CPUARMState *env)
> > -{
> > -    return arm_current_el(env) == 2 && (arm_hcr_el2_eff(env) & HCR_E2H);
> > -}
>
> > diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
> > index c0fa2137b6..3ef24fb0c3 100644
> > --- a/target/arm/tcg/translate-a64.c
> > +++ b/target/arm/tcg/translate-a64.c
> > @@ -2573,6 +2573,15 @@ static void handle_sys(DisasContext *s, bool isread,
> >          }
> >      }
> >
> > +    if (ri->vhe_redir_to_el2 && s->current_el == 2 && s->e2h) {
> > +        /*
> > +         * This one of the FOO_EL1 registers which redirect to FOO_EL2
> > +         * from EL2 when HCR_EL2.E2H is set.
> > +         */
> > +        key = ri->vhe_redir_to_el2;
> > +        ri = redirect_cpreg(s, key, isread);
> > +    }
>
> I was looking through the details for this one, and noticed that
> R_PHHPL says the redirects from FOO_EL12 to FOO_EL1 apply
> when "the PE is executing at EL2 or EL3", so I think our
> check on "EL == 2" isn't actually correct.

No, I'm wrong here -- R_PHHPL is for the registers handled in
patch 34. This codepath is for E2H redirects as listed in
R_JGGMV, and those do only happen at EL2, not at EL3.

-- PMM

