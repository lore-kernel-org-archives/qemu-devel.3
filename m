Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D457E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 16:24:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJb7A-0001sy-QQ; Fri, 06 Dec 2024 11:23:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJb78-0001sd-CW
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 11:23:34 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJb74-0004sL-Ro
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 11:23:33 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5d0e75dd846so3504292a12.3
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 08:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733502209; x=1734107009; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VN8H4a/ej0diCZx4UtFfJrU8VQ6J28t8MtBdVV2NU1s=;
 b=BjTuGzIJT/BBRHYcSc7l3VwPCc4eZcXB/6RgJU8kK5Fmdctku6N3NyMvteZpxQ+qCP
 tTdkodjR/laM05BipIwjH+7vzVG7Zrbat1dGpJfaG4j4l0PdTa8phTIqPUoC46ndJc+r
 UNE0o7UuNFFXdNTAM4R1RiNwAAMkeGt0th4tRCTQPi1MeBh3CFba7h/chItDfbNfWXvh
 eNYEfmx1qVXaLYcn5/6rC0K73l+5Kmli8h676EZAmlX8zZU6tu8fB1dvu5JJ0A2QzOqt
 eWj/hfC2ssV6rTKFbzg6wnnKGKYN1e5tIV5wUbfb/vL/YIz7K9En2V9L2fcAGX5aszws
 npbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733502209; x=1734107009;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VN8H4a/ej0diCZx4UtFfJrU8VQ6J28t8MtBdVV2NU1s=;
 b=RcgomK8FEcFnUyW8Hpo6ZiDYbxizQWPzKpmOMu26Gmc8JM+Yv+jEDXFFyomZl7hvxF
 fOqgc/4mr6gYCjB7H4Ey+L+8LYlr2nkX67/T/Ld42OjfiQMOMah0rz16tsFKZ2wFAgjO
 Q0brRd2bGzgmZ+q3HPJUgPj5J4jPJrg3Vfp9MPozjozW/fIyWTs0rUzdGm+DnkgsyOop
 ZzN1vTRyCR9ip4/+86oiS9TTFoN1Fzxm1QbXZjF/VDYxZJCt5VKn8DVsYAY6ioGLtzAV
 Rk5JEjALkUAK0o1kLOMTwj8lc6Oc0xs5o6EHIJfVyX8kjlxLKyvLTtZmG8/qEJow0LJ9
 3E6Q==
X-Gm-Message-State: AOJu0YwomA4lKAB6WA/80kAy+gfr3tAuOAimwTRhBJdoON49Mw5AaMqN
 gGS2vrWBP/9nQSQ+G5PuhI1XRiClil9alCRyH2sYcvL0EsDMABgfOpAtvbZmn2TA6uyKp5oUj2x
 gEGSGJegt2vl9s+RtYt0TD75s22w+onzU6WYsmA==
X-Gm-Gg: ASbGncvVxgFHRvjSR6CNfvVGDdS73jaldJC9jsAL1xpx5khjT0Th1XJHyfgePddnnP1
 Qkm3x3DUUm6iFtUGpHV2Co5ArnLXn6h3t
X-Google-Smtp-Source: AGHT+IGFa+nZUrcQGQDDedTrpmY5uBdujLW43tf8bjkXk4Q2uRIekgxeKYtzbIoszFO4dmm/iSQbow1WwUhv7Lxa0zg=
X-Received: by 2002:a05:6402:3888:b0:5d0:81af:4a43 with SMTP id
 4fb4d7f45d1cf-5d3be47b688mr4045433a12.0.1733502208677; Fri, 06 Dec 2024
 08:23:28 -0800 (PST)
MIME-Version: 1.0
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-56-richard.henderson@linaro.org>
In-Reply-To: <20241201150607.12812-56-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2024 16:23:17 +0000
Message-ID: <CAFEAcA8GO=NjWpoOM7mG5j-+4JXfx5qEK1_YwQHNmuFt3yH=Ag@mail.gmail.com>
Subject: Re: [PATCH 55/67] target/arm: Convert FCVT* (vector, integer) scalar
 to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Sun, 1 Dec 2024 at 15:21, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Arm silliness with naming, the scalar insns described
> as part of the vector instructions, as separate from
> the "regular" scalar insns which output to general registers.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-a64.c | 135 ++++++++++++++-------------------
>  target/arm/tcg/a64.decode      |  30 ++++++++
>  2 files changed, 87 insertions(+), 78 deletions(-)
>
> diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
> index 98a42feb7d..ad245f2c26 100644
> --- a/target/arm/tcg/translate-a64.c
> +++ b/target/arm/tcg/translate-a64.c
> @@ -8678,6 +8678,16 @@ static void do_fcvt_scalar(DisasContext *s, MemOp out, MemOp esz,
>                                   tcg_shift, tcg_fpstatus);
>              tcg_gen_extu_i32_i64(tcg_out, tcg_single);
>              break;
> +        case MO_16 | MO_SIGN:
> +            gen_helper_vfp_toshh(tcg_single, tcg_single,
> +                                 tcg_shift, tcg_fpstatus);
> +            tcg_gen_extu_i32_i64(tcg_out, tcg_single);
> +            break;
> +        case MO_16:
> +            gen_helper_vfp_touhh(tcg_single, tcg_single,
> +                                 tcg_shift, tcg_fpstatus);
> +            tcg_gen_extu_i32_i64(tcg_out, tcg_single);
> +            break;

This hunk adds calls to the toshh and touhh helpers,
but as far as I can see it doesn't remove any calls to
those helpers that were in the old decode functions or
any calls to the handle_simd_shift_fpint_conv() function
which was the only one that did call them. Should this
be in a different patch?

(Conversely, we remove calls to gen_helper_advsimd_f16tosinth
and gen_helper_advsimd_f16touinth but don't have those here.)

thnaks
-- PMM

