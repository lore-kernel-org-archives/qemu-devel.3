Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDC34E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 14:41:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJZVQ-0001u9-J4; Fri, 06 Dec 2024 09:40:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJZVN-0001ta-DU
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 09:40:30 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJZVK-0005TD-It
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 09:40:29 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5cece886771so3955129a12.0
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 06:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733496024; x=1734100824; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dKWsYe3dnMt1bAU3N0u0ZdoPsnUZIkj/ikSFbpwzhys=;
 b=EdTkpuAGIjd7G5H5+mcKZdkl5ZIKFTHFDSAFs3e3dY9yv93tujlNW3GFd73OPWnTGB
 Tj9dH/bBEEl3kjlf9r7OOX/h/xWJydqbVkPbtMMS+ZLoJhEZn1FZmOWqiywAS8OtpUhY
 RXBGnrCTc7ae2tT9GprGqbUXtW2DUHgn0Hnc8zm+1EuAopkTokOiljsgFN8mpLpDEZMP
 sL46WzhV0Ix8gac7JHATdrP7+dkL/If7GAmmICoDM8D3NP0BsXC7F6E43WFniIJfL6Of
 xnwzi0576utX3WeXFOcR+bZGb4+JLfZmQy5CTnhnY7iKl+05wVKMi2pc8MSVdUJqKozr
 Lirw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733496024; x=1734100824;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dKWsYe3dnMt1bAU3N0u0ZdoPsnUZIkj/ikSFbpwzhys=;
 b=gzh9RKHpZpdZBVWT+bul1sGz25WGMyp1tET9CaE8IK7My2tImF0pKZ+A8YH7XduIO/
 3tpkBGx/QatVWG81HD0XF2LBUV/lDP9R3DNWrqxlRhdEyRHTKrhaSIC9itTqgoiFmPtR
 92QoTCS09GmBdxNTR52RF4KNWfCiI6/3dZ7GOqqqs2Cscz5GGFvqfUWJ3d4gndnTaZ43
 onxEOHccJoHb73e5Fb40+do/Hp8/bRV2gLvYyVAKstXIzJPR/FZX3x3epQhpu5UdOxOy
 fCq8CP0Fe97BMC/dE2oeko55oi3ZKsDGwcN4kd3bz8vIxNAQGQmuuNUSKutYXjtWRM14
 Hf5w==
X-Gm-Message-State: AOJu0YyBNlXzPXDouQS61X0d8XB9D9CHd1sDbv+GvIaawQTfJY43kKw9
 ueLSxh0sL2FPYBSl1MKf4ZzDAfwWqCT930TGHYtGNrcWZIJ8G3hc+mn0YFW4c5oGEyCG5sTwvbP
 S6q0bFudh24LrBEz2XFLdHibHQBTKxSYIHG1vaw==
X-Gm-Gg: ASbGncsoR6druBG+b9IAh2y7HmFdHPptgKHDoagbMBhNuX7hGCxaUhjjWXdrTcEPNQ7
 N0EKtlVXLgJfcfj+/ww5JQnqggeGk4JN6
X-Google-Smtp-Source: AGHT+IEVKfY88tdKA1b6dB4TV2zpAC699jPRUl5HZ8uedBj/bJO1IHnFvfLEnS8176yqmy7FjqqcTU81xNJ3qGX19cs=
X-Received: by 2002:a05:6402:27ce:b0:5d0:d06b:cdc4 with SMTP id
 4fb4d7f45d1cf-5d3bdccdb54mr3046377a12.15.1733496024517; Fri, 06 Dec 2024
 06:40:24 -0800 (PST)
MIME-Version: 1.0
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-38-richard.henderson@linaro.org>
In-Reply-To: <20241201150607.12812-38-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2024 14:40:13 +0000
Message-ID: <CAFEAcA8-GkpSxLc98y8ZopV9PMej7U4+Ruk8D+zUoEDPZYJ8aA@mail.gmail.com>
Subject: Re: [PATCH 37/67] target/arm: Convert CLS, CLZ (vector) to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Sun, 1 Dec 2024 at 15:10, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-a64.c | 37 ++++++++++++++++------------------
>  target/arm/tcg/a64.decode      |  2 ++
>  2 files changed, 19 insertions(+), 20 deletions(-)
>
> diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
> index 4abc786cf6..312bf48020 100644
> --- a/target/arm/tcg/translate-a64.c
> +++ b/target/arm/tcg/translate-a64.c
> @@ -8920,6 +8920,20 @@ static bool do_gvec_fn2(DisasContext *s, arg_qrr_e *a, GVecGen2Fn *fn)
>  TRANS(ABS_v, do_gvec_fn2, a, tcg_gen_gvec_abs)
>  TRANS(NEG_v, do_gvec_fn2, a, tcg_gen_gvec_neg)
>
> +static bool do_gvec_fn2_bhs(DisasContext *s, arg_qrr_e *a, GVecGen2Fn *fn)
> +{
> +    if (a->esz == MO_64) {
> +        return false;
> +    }
> +    if (fp_access_check(s)) {
> +        gen_gvec_fn2(s, a->q, a->rd, a->rn, fn, a->esz);
> +    }
> +    return true;
> +}
> +
> +TRANS(CLS_v, do_gvec_fn2_bhs, a, gen_gvec_cls)
> +TRANS(CLZ_v, do_gvec_fn2_bhs, a, gen_gvec_clz)
> +
>  /* Common vector code for handling integer to FP conversion */
>  static void handle_simd_intfp_conv(DisasContext *s, int rd, int rn,
>                                     int elements, int is_signed,
> @@ -9219,13 +9233,6 @@ static void handle_2misc_64(DisasContext *s, int opcode, bool u,
>      TCGCond cond;
>
>      switch (opcode) {
> -    case 0x4: /* CLS, CLZ */
> -        if (u) {
> -            tcg_gen_clzi_i64(tcg_rd, tcg_rn, 64);
> -        } else {
> -            tcg_gen_clrsb_i64(tcg_rd, tcg_rn);
> -        }
> -        break;
>      case 0x5: /* NOT */

This was dead code, right? We only call handle_2misc_64()
for size == 3, but size == 3 is an unallocated encoding for
"CLS/CLZ (vector)", which only deals with elements sizes up
to 32 bits. Worth mentioning in the commit message, I think.

(I was wondering why the new code doesn't have any cases for
operating on 64-bit elements whereas this old code did seem
to handle it.)

>          /* This opcode is shared with CNT and RBIT but we have earlier
>           * enforced that size == 3 if and only if this is the NOT insn.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

