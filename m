Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24706C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 10:15:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXGyF-00031c-QQ; Thu, 03 Jul 2025 06:15:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXGyC-0002uc-1V
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:15:08 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXGy8-0001LQ-Hk
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:15:07 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-70e5d953c0bso88085417b3.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751537701; x=1752142501; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aViMPGx1ruWJPe6ev1NB/jE9/Yb5UbdOnAcP1umvZrQ=;
 b=yYo0cGX5JwcIcRXtGO/FTvWgaCKOJUQ07ru8ckFIRqXN1rz6xNvojejwEEf9jvu06X
 So+FQEIdXQp+5gHIQ6P1UNfcT6/ZpKTuyOGaOub1zSen2LBtvtXAKOTkyMMmXeS/Np9C
 s59hd36TKSSOSGMlLzJIibGhLNjzm2Fj5CFTGTXXYls4MO9fGQt1Adn8rZwupOFblzM9
 oE76C4DyRkVGDOVKzsNrxBjhtgGcPwI1El1GkqLS3/fBJrfRMMSBmTOE3yaEkipPMrob
 Wx97OmYyMB5O61/5mKUjeI+7ot6ejDOro8mK9fKuBOXpQ7tJaDNxhxz71mIGGWeFRSgk
 kM2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751537701; x=1752142501;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aViMPGx1ruWJPe6ev1NB/jE9/Yb5UbdOnAcP1umvZrQ=;
 b=uGmIA4fewrfsH1oraKfV3ZphV5750Pk2biLasEk/2KF1KcBs6xed6pNv7BOgCY6wRo
 s6MK9lSuABfJtnWtwbaKr8mCmQbOP0kqyi6Ajp2MPPbrEYwhJrZlDEW8xCeBHerVPeZR
 wo9rLXHonLgDhDOOWd/1+tfAyQr73fvdvU2aIO/+gMxAif8MyHVvRA8t3GYh7NmwNuFT
 inlPgwTLEAG9bzo5kwYcTuqdF80dlwGfjh+QoZlqLEyqIBcqAqr53Ee22yEoApMsiBZV
 itFecLrXiuT+Z0vY6JnfRaURLr19AjFw2K0/du5It+ZrcayIlAyDW0ApEhmZLNR7qPc5
 om9Q==
X-Gm-Message-State: AOJu0YxryW9XC57bqhDKVo8Hsyi6rhmvQpouUZlZexLkSxb2jiLTP9fY
 +enmtZym273LQ9m+lInVLQql2trCy3bDY8MX4YmjDdIur3WSdHL9TQWlx9ipf5lzjW3Rv+4PFnI
 4b84xV0R59Q83poJ6p4hpYrWOJZcMfcsttwGALNxs4g==
X-Gm-Gg: ASbGnctLKUD1MSMNO8MUQgyanjqSG14ESO644uhWa5JumgFOGm//YbOfjdQfwKFZ22r
 VAud7dIi2QoX9t6NEPMYOQyFJgntQqDyYbU81swBKfgeSFJD4OaUvNfSryIJa4h/vDl5bhSStJB
 SQYdEZQVl4JZrZBTg1qpxcbY1ikio4EooFU8W3eNr8p32H
X-Google-Smtp-Source: AGHT+IFbyLhxKvTG+oTtk7hgNcljrDmrvKEtP9GQgFZn9k3RAYL3mIrLs2RXhFzhFV7+La9FR+Xy0h/N8udEEIw/mbE=
X-Received: by 2002:a05:690c:6982:b0:708:be8b:841e with SMTP id
 00721157ae682-71659100e33mr41078887b3.36.1751537700768; Thu, 03 Jul 2025
 03:15:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-47-richard.henderson@linaro.org>
In-Reply-To: <20250702123410.761208-47-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 11:14:49 +0100
X-Gm-Features: Ac12FXw3GlEW7Zjmmy-bx3hJUmx3y2zBiocLJ95Hnufx0w0Cw9W3gHUEIA6Jt-g
Message-ID: <CAFEAcA-Oc+Hk97gsEO82m1ugVxJWXPn6K07VL9ga_qTw6MoJyQ@mail.gmail.com>
Subject: Re: [PATCH v3 46/97] target/arm: Implement SME2 FRINTN, FRINTP,
 FRINTM, FRINTA
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Wed, 2 Jul 2025 at 13:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-sme.c | 9 +++++++++
>  target/arm/tcg/sme.decode      | 9 +++++++++
>  2 files changed, 18 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

