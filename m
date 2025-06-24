Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 062ADC77B7F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 10:03:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU0UZ-0001U5-5k; Tue, 24 Jun 2025 06:03:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uU0UX-0001Ta-Az
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 06:03:01 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uU0UV-0004mu-Hx
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 06:03:01 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-710e344bbf9so50840277b3.2
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 03:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750759377; x=1751364177; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=upFslYfqtj56iE4kGhFvXSGfyZtwe0HFAGXIlWMH2q0=;
 b=N4GoTrqrJQH6kTdSTcIVauYbodADzZ38RNKi9C410Fa0WZTKFVa8jkth9Al6hii2oe
 Ee+jb8rNf34Gp0C+n01OeYqMS+lkT/KneX84/aT8h3++N4yRYjmkiYyq783i34j+MWPH
 sB0xGTXpau/boMfPl2kQbywatikKEM+k2KTORoP6QkRrn28kraTVBSSKNib74BAig1sZ
 XCdiUBJGKLDTfdMQL1tBnmc6QFA4oLsYX4G2mFbt4s3kznFp5jEIJSY6No69UvPke6rM
 uI+k3SmLXvJirQK1YwzaenvrvNzAIQHLzKahx1K1XYgsicnlugOkcW7z2zK8zgH6joLA
 vHyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750759377; x=1751364177;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=upFslYfqtj56iE4kGhFvXSGfyZtwe0HFAGXIlWMH2q0=;
 b=nY4SpnReALEoQuh47i4eg/W+Zz1vW/y4NllZLvf4ZsS3F7ked0ovsywlJCf+9FubUl
 YXT6jqd3qybq+I07X4vE80v3ezTTZZW6tybzhYhTqVU3ZGmKch06ByZCUQtqHh5qPLvX
 W85/QRsKI2XKKeiHgbCi3jA1eB60hbnpuLqhHxKc43bwgLZRY4AIDFJPkgqUeD/jzac0
 BERWWR+H5R2LXUMx4NgY82lymbxeLLwLDHUCHAhEQ7G7y5nDkVj1G9/33tNLbeBH/blx
 Re3sJ8+d9bpMrJNFntZO1oTrh0Qhnyb0TFiH/m/9/PImT8RSQmzK72TjXBbZCGEcH/sO
 0L9A==
X-Gm-Message-State: AOJu0YyfXQl2lbaC0ZtS7hGRyFFnw+3sRvgJZIzCvsKJsfx6CpZsOWZg
 DKwpWS+mvzh7OWar7aBfjF2lWNrbXiZRA2Fq7GhqRSl+DXp5aHkR1vpld7oS+Sw4hGXd+rFnPx9
 k/wzy709IoyyYpG4z8nv9mWWxkqz1h3GQUOry3fWS/Q==
X-Gm-Gg: ASbGnctyaVWxvNCYKXMJtAEjiurtSMPokLGX+5mhNGwv250a+lli9NPHp6s8j3jOd2e
 fJjDjhNNGJJAEoGVM9z77Qj7ogGhu3ZBIpOVy/2xmj0bbCW3ckI2k0qEQGRno2AYmHhJpRAMzm3
 AGP7LUnrMOdN+5kItz3/ZKKmQ0ybJSwf959hChW70HIyyS
X-Google-Smtp-Source: AGHT+IFSfJBGJ+CRZsqvf3qeNhMHnK7wk0GJWAtysOUMg9pyphiZE0+p1qxK5yqTy2Z6fsoZuqJGo7HrZwNGcu1pRqU=
X-Received: by 2002:a05:690c:4b90:b0:709:176d:2b5 with SMTP id
 00721157ae682-712c6394653mr250524957b3.2.1750759377278; Tue, 24 Jun 2025
 03:02:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-41-richard.henderson@linaro.org>
In-Reply-To: <20250621235037.74091-41-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Jun 2025 11:02:44 +0100
X-Gm-Features: AX0GCFsJzV7dFfxbnM5dVrpeNotWX5r0SoIB1bX4mTCeL4oy2M1iDn9slxUNAV8
Message-ID: <CAFEAcA9=Nix2pj6Sc6-Ar=em6LAPhXa69bcSyZzW2jJfBmmUCA@mail.gmail.com>
Subject: Re: [PATCH v2 040/101] target/arm: Implemement SME2 SDOT, UDOT,
 USDOT, SUDOT
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Sun, 22 Jun 2025 at 00:58, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/helper.h        |  8 ++++
>  target/arm/tcg/translate-sme.c | 85 ++++++++++++++++++++++++++++++++++
>  target/arm/tcg/vec_helper.c    | 51 ++++++++++++++++++++
>  target/arm/tcg/sme.decode      | 63 ++++++++++++++++++++++++-
>  4 files changed, 206 insertions(+), 1 deletion(-)
>


> +static void gen_helper_gvec_sudot_4b(TCGv_ptr d, TCGv_ptr n, TCGv_ptr m,
> +                                     TCGv_ptr a, TCGv_i32 desc)
> +{
> +    gen_helper_gvec_usdot_4b(d, m, n, a, desc);
> +}

This one also needs its own helper, rather than a wrapper of usdot.

-- PMM

