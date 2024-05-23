Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 500CBC25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 16:30:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sABJu-0007gL-N4; Thu, 23 May 2024 12:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sABJr-0007ek-Og
 for qemu-devel@nongnu.org; Thu, 23 May 2024 12:29:32 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sABJp-0004sn-OK
 for qemu-devel@nongnu.org; Thu, 23 May 2024 12:29:31 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-572e48f91e9so13010617a12.0
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 09:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716481766; x=1717086566; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WjETyjrfThdWJ6XZACIryPyXtUeRjsjpNxtdDIp7xkA=;
 b=NG+p/QP+pE2KT8AUeP2S0I3G0lnpbMosPzd47qKiYI0AMrhBsHBmYOPfVf6ymSxI5X
 HHYmQX77AnLCjt2fgCHxz4rKe/dKKJbsIzjXd14ZsAr6gNxNoNa3aZcgPovg/XPUIlWP
 28o91Cccg9ZGkKsJ7L+5UUTicGQl2cLmm0+1JBN88np7pGsPEIxOp7C/qMM3SdD6r2FF
 weFhvVE51K9jnbm21Zt7agdJWNDrF74bEmZk5bGtDNIuctc6Z+wfTqv6gbJf9UiqM8vY
 +8zGw8FK1rdQrEw5ptmN8OcKLLEDbhTpMGqMc6KgsAk7dPvZpuVT67NCVgkviYJlRaRL
 HRUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716481766; x=1717086566;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WjETyjrfThdWJ6XZACIryPyXtUeRjsjpNxtdDIp7xkA=;
 b=FibVUQOSnolhHgYGDCpWB/URA8LfXklevNWxrZ/bhtcVLNC6elGl4aoxLv/kOIhc5/
 aa5bIjsivRqDBYH/grC9PImJ5NnxoFYjQJLDUpBhepyUWnG51vXcw1kYEVXA4xK/WvxY
 dlS8grZl7Ymnqlkdh+YCjp9JNEkkt5eKOflzgvA9P3ps7xlfZpnYRqtr6I9DloVTkAcX
 rc672NkgtQOtwPR3C40Kuk4rgm47PaGbtcuzN5wIMYPzImjlZTKLCxP8N0jB2L6j1jz3
 f8wem5r7TqIuOctIVqM/y0tSAO5WTaizIX4NChj1sdLks6UqPBRf04f+Q3Bt02EdeoO+
 sPzA==
X-Gm-Message-State: AOJu0Yy3FHDVD9VtRbXb6RD1Aly5HIQ24VaAE5+A64xZiy5mmFpDXM+K
 GQMORPOBgXrTl2qtp1hcUxNdGnBSO0VEbyGf1LjD58BvT19sSSkEJYVjFBzMa7YFkJhJOnn5zEl
 qxXydabwkz+Q60+0Iq6VRO63loenPx701JT6/wA==
X-Google-Smtp-Source: AGHT+IH6pND1CUUau5OrmQ4TWPzyW54E+8UXfn4dhSO7jl3r0m9Nju8rcnN65UpaQPWr90pgDyYkxoRpPKhJYGhxmew=
X-Received: by 2002:a50:d5dc:0:b0:572:a167:65c6 with SMTP id
 4fb4d7f45d1cf-57832ac45abmr3140183a12.25.1716481766073; Thu, 23 May 2024
 09:29:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240506010403.6204-1-richard.henderson@linaro.org>
 <20240506010403.6204-16-richard.henderson@linaro.org>
In-Reply-To: <20240506010403.6204-16-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 May 2024 17:29:14 +0100
Message-ID: <CAFEAcA-cc0NhU728ysdsq9QSaF7D487onvG1cbcKH4wvQG+nAg@mail.gmail.com>
Subject: Re: [PATCH 15/57] target/arm: Expand vfp neg and abs inline
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Mon, 6 May 2024 at 02:06, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.h            |  6 ----
>  target/arm/tcg/translate.h     | 30 +++++++++++++++++++
>  target/arm/tcg/translate-a64.c | 44 +++++++++++++--------------
>  target/arm/tcg/translate-vfp.c | 54 +++++++++++++++++-----------------
>  target/arm/vfp_helper.c        | 30 -------------------
>  5 files changed, 79 insertions(+), 85 deletions(-)


> +static inline void gen_vfp_absh(TCGv_i32 d, TCGv_i32 s)
> +{
> +    tcg_gen_andi_i32(d, s, INT16_MAX);
> +}
> +
> +static inline void gen_vfp_abss(TCGv_i32 d, TCGv_i32 s)
> +{
> +    tcg_gen_andi_i32(d, s, INT32_MAX);
> +}
> +
> +static inline void gen_vfp_absd(TCGv_i64 d, TCGv_i64 s)
> +{
> +    tcg_gen_andi_i64(d, s, INT64_MAX);
> +}
> +
> +static inline void gen_vfp_negh(TCGv_i32 d, TCGv_i32 s)
> +{
> +    tcg_gen_xori_i32(d, s, 1u << 15);

Just noticed something here -- we take a 32-bit input,
so if there is junk in the top half, we will leave it.
In contrast the old helper function:

> -dh_ctype_f16 VFP_HELPER(neg, h)(dh_ctype_f16 a)
> -{
> -    return float16_chs(a);
> -}

passed the value through the float16 type which the
float16_chs() function passes and returns, which is
a uint16_t. So it will zero out the top half, which
I think is the semantics we want for halfprec ops.

Maybe

static inline void gen_vfp_negh(TCGv_i32 d, TCGv_i32 s)
{
    tcg_gen_xori_i32(d, s, 1u << 15);
    tcg_gen_ext16u_i32(d, d);
}

?

There are probably places where the zero-extend
is redundant, but there are definitely places where
it is not, eg A32 VFP vneg.f16, because do_vfp_2op_hp()
doesn't do a "load a 16 bit float value", it does
vfp_load_reg32(), which is just a ld_i32.

Or we could change the VFP codegen to work like the A64
codegen, which has a read_fp_hreg() that does a
ld16u to read the input value.

gen_vfp_absh() doesn't have this problem because the
AND operation clears out the top half anyway.

thanks
-- PMM

