Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98260C0218A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 14:25:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcPxE-00004w-4B; Mon, 27 Jan 2025 09:19:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcPxC-0008VX-AN
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 09:19:06 -0500
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcPxA-0002OO-ML
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 09:19:06 -0500
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e549be93d5eso7790840276.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 06:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737987543; x=1738592343; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6CLGgHNii1ozqng84Wbew/T8Evy/NM7+mE0AjRrB5xk=;
 b=dTzYlYtBI1UTXNWYKWrucqEccAMkcenEmJLBhE6M004sEfGCGgt0ENhVcbDs7KR4Rh
 R1k0/hJ0Q755g79qXXdASfiNA2Dukq053mgfW8BkEdtJP1TwTbJbMv++Vv/rTai6jEE8
 gQAJNGD2wercOu396hpOF3FF3KwodDvQReB7e19W87ON2XlC28hTPM+QreUYUadfOgxv
 o9Fp/CF7Lv8cZa7TXq+D0FeXOnBRJ6oQR2NIYwZ9/yB3/I7QzuGi8l3bECW926JQwxGv
 BeH1uj8dV7brn2DXr6umMYcAzhhamfSRnsRr1pbb240cCHAu2eVFYTn3vvWbivmccoiF
 +WMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737987543; x=1738592343;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6CLGgHNii1ozqng84Wbew/T8Evy/NM7+mE0AjRrB5xk=;
 b=A9/789bClttVSF0IzAdaIysPR4rNkAr8ONEfNIBi9vUPTuVdHujq1Aq++Xb01vFDVz
 SZPv3DPRMxaEDPe3kylQ8EbY6awrldnOT2khtbEYMbpBcnqcc/pmzH8Sial7WOnJy9VN
 G3YIs7mMF8c24woBxahXmqhVRyBZvsO8WW9jIfPF/AJpJld4js9dCTiKjWrmjwW+YD/W
 LCdcxnUBQuVivgUPIG/unwszQc0rr3AJVPUfZkqBcdlfYE4kT+xPz+OHLWKPwfmWEM9u
 K+iY698tJjqn+/wHdJw7+SKqAUbB/c1RWcj8Z3W2huXaZCGCGIhbUY3xJACYrhNgaXY1
 fWWA==
X-Gm-Message-State: AOJu0YwR8tHw98bBOlv9kh4ju3WgS/jY/iQdqcMFJnfAtV7MYuficHFm
 Yep3ykrmk3wBEGbXxCKL/HFfuut9OWCul5Lj/ANz0IzWOquTsReDA9ma9XaVkRrV0DKHHSPZnp0
 2oGKHEMVfMtHniMRKKJlkL1uddPEgXB5GM4qCFPih+FXT7cUz
X-Gm-Gg: ASbGncvgmz8OAEMAT1S1eRjoLUCmyKLCEszay536+OZKE1+XLLX0Ki2PoaJcd/bkF3j
 +Im6McZYlFKLRMoobwmrCxP1BoK3tlx4ZiyT2+B8GFY4+rh8tjbwf97EeOW83pjk=
X-Google-Smtp-Source: AGHT+IEX3fbZ/1IfJS3x/pKCagJIwM4egehJcygLcrfMUNk/YjJW/3Eq1LT+D9dHQNNbUEu0zBT0uajbxmLEDE6fap4=
X-Received: by 2002:a05:6902:270a:b0:e4e:4337:68e9 with SMTP id
 3f1490d57ef6-e57b1046ba1mr31958039276.4.1737987543380; Mon, 27 Jan 2025
 06:19:03 -0800 (PST)
MIME-Version: 1.0
References: <20250110160204.74997-1-philmd@linaro.org>
 <20250110160204.74997-9-philmd@linaro.org>
In-Reply-To: <20250110160204.74997-9-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Jan 2025 14:18:51 +0000
X-Gm-Features: AWEUYZn9cgaSR3nCalrAJsa4i3UcG8jczD7kL__v5XWI9iHKvDIgRkisZhzWcg8
Message-ID: <CAFEAcA-+fCQOAqxLxP=G+G15dhoNo4hyd7wbJf57dYpZ8iQhew@mail.gmail.com>
Subject: Re: [PATCH 8/9] hw/arm/stellaris: Only map existing devices as
 unimplemented
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2a.google.com
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

On Fri, 10 Jan 2025 at 16:02, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/arm/stellaris.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
> index d87587225c2..c89522332e2 100644
> --- a/hw/arm/stellaris.c
> +++ b/hw/arm/stellaris.c
> @@ -1390,11 +1390,21 @@ static void stellaris_init(MachineState *ms, stel=
laris_board_info *board)
>      /* Add dummy regions for the devices we don't implement yet,
>       * so guest accesses don't cause unlogged crashes.
>       */
> -    create_unimplemented_device("PWM", 0x40028000, 0x1000);
> -    create_unimplemented_device("QEI-0", 0x4002c000, 0x1000);
> -    create_unimplemented_device("QEI-1", 0x4002d000, 0x1000);
> -    create_unimplemented_device("analogue-comparator", 0x4003c000, 0x100=
0);
> -    create_unimplemented_device("hibernation", 0x400fc000, 0x1000);
> +    if (DEV_CAP(1, PWM)) {
> +        create_unimplemented_device("PWM", 0x40028000, 0x1000);
> +    }
> +    if (DEV_CAP(2, QEI(0))) {
> +        create_unimplemented_device("QEI-0", 0x4002c000, 0x1000);
> +    }
> +    if (DEV_CAP(2, QEI(0))) {

Should be QEI(1), I guess.

> +        create_unimplemented_device("QEI-1", 0x4002d000, 0x1000);
> +    }
> +    if (DEV_CAP(2, COMP(0))) {
> +        create_unimplemented_device("analogue-comparator", 0x4003c000, 0=
x1000);
> +    }
> +    if (DEV_CAP(1, HIB)) {
> +        create_unimplemented_device("hibernation", 0x400fc000, 0x1000);
> +    }

Again, it would be helpful to flag up the behaviour changes here.
I think:

 * both boards have the PWM bit set : no change
 * both boards have COMP(0) set : no change
 * both boards have HIB set : no change
 * LM3S6965EVB sets QEI(0) and QEI(1), but LM3S811EVB does not:
   so we are (correctly) removing the unimplemented-device regions
   on that board type.

thanks
-- PMM

