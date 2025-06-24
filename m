Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A930C71157
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 13:59:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU4AU-0008F4-Ni; Tue, 24 Jun 2025 09:58:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uU4AS-0008EW-KP
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 09:58:32 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uU4AP-0007kN-Ks
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 09:58:32 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-713fba639f3so5083207b3.1
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 06:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750773508; x=1751378308; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FXKCkD956h0fhArt/L7EeiE2+eI3bpiHFdOX3738bY8=;
 b=NaYKxtQVH7oI43m9dYaB5ylZVpiaJVmq1lZ2IwGZnYC6n0BCr9O2TdghAneHIY2jLl
 vKv6N/1fE/9yO4ml1ulOPRqF1F2dMjDINIWReP1ZXzPU9d61+aJXTi1UJbGlVT+elJJc
 0EATvjzM+BMlEklqAn6pQXh4kjQwdv/Jrcy764OFaS3eXKleUdcWm5GrKEWx566+X42s
 my37IR2CwlITn8GXLU9r6nezpJkK+/XkfM0K1UK+vxmdO6dUjKrM/FpkPbd3iYkhnye6
 +s65UEhU6P9fijhOyFz9obzWyuTWo2ajN2QWpbRmW04rb/8f1G3VINskoc7+G2V7rlh4
 P3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750773508; x=1751378308;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FXKCkD956h0fhArt/L7EeiE2+eI3bpiHFdOX3738bY8=;
 b=KM3rNE5NIHD/52dbYn7g/MI+JKSWBjjFa0JJ4wN6vv7J6xwRZ67MMaLDSbbuvOWyQL
 6URl1s31JvOirscVSGL9EaQ1gwOLnDk6OjviqwHBKqGL/pNKqV962nZTIJa2eyaO1Jtm
 tDvWXYHTIM4RoC0Ho0ajPHwbVqpsxz2W/vC05newPqv0xqKzByYuYUK8wdGyQ/yAU5Oh
 TQIQQSuSx6cxhTmqi0A7gWphbnyxHRnNCrD3q5u10GtcqAble5/i9SkNcZUYSMkVRRYg
 FH5dSuA76EBfmfqV4azPpA2i4IbD4PPKgAIS3RM4CGBy+i7Ib8k4RL9ZtxJMV+hHZPEW
 oVAA==
X-Gm-Message-State: AOJu0YwQiE+EZc3kSGm64MakzjX2d49vxmRjRSy3DWCLeznCj9PYDNhB
 hwDFmIs8g7EYaK/jg6giH8hN31VWNPtJNfhciy0u/Yxe4Z6yqpzT4d98hU8xzX5j1uWDh00tM9u
 uoL7/CJQ6t2up8fl0Od6xPZFt8WPmfjCZfQ7WeZF3vw==
X-Gm-Gg: ASbGnct6xzV4el+Qtow5K2IVwhDwDfItHi1FSG5vznrgajaLrTUIIQDhJEV2cedq9LE
 KAjWDygjIBdwUabkBIK/M5wf5RfXXmjqreeA2ea6cj/TuUsvQMDDHUi6HU3a5Cqiqu2Xq2BH+JB
 2hBjvdCffyN5P1sHCztMzTidQu31aym4BC70nDtLLHLptg
X-Google-Smtp-Source: AGHT+IGVkuml3DS6+EJMb+mTiAP6LYI0bUgRJF/f9JYbjtiZg6J2laT2n4JqmwTdBaCBMis9PdCppmDzm/AxpjSxlqM=
X-Received: by 2002:a05:690c:9418:10b0:714:13:3544 with SMTP id
 00721157ae682-7140013384dmr14453547b3.16.1750773507794; Tue, 24 Jun 2025
 06:58:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250622213509.277798-1-richard.henderson@linaro.org>
 <20250622213509.277798-3-richard.henderson@linaro.org>
In-Reply-To: <20250622213509.277798-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Jun 2025 14:58:16 +0100
X-Gm-Features: AX0GCFt5BDnu04b2_-UkT_c0v92eiWgUKPUbZzZlnAPghBpnMxwo7KFnE8xL954
Message-ID: <CAFEAcA8uoBSSro3CCfM6KWseZX52ZtgMvCkpbH4WczNxNKknkg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] target/arm: Fix sve_access_check for SME
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Sun, 22 Jun 2025 at 22:36, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Do not assume SME implies SVE.  Ensure that the
> non-streaming check is present along the SME path,
> since it is not implied by sme_*_enabled_check.
>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-a64.c | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
>
> diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
> index bb49a2ce90..d7b0c81773 100644
> --- a/target/arm/tcg/translate-a64.c
> +++ b/target/arm/tcg/translate-a64.c
> @@ -1387,11 +1387,8 @@ static bool fp_access_check_only(DisasContext *s)
>      return true;
>  }
>
> -static bool fp_access_check(DisasContext *s)
> +static bool nonstreaming_check(DisasContext *s)
>  {
> -    if (!fp_access_check_only(s)) {
> -        return false;
> -    }
>      if (s->sme_trap_nonstreaming && s->is_nonstreaming) {
>          gen_exception_insn(s, 0, EXCP_UDEF,
>                             syn_smetrap(SME_ET_Streaming, false));
> @@ -1400,6 +1397,11 @@ static bool fp_access_check(DisasContext *s)
>      return true;
>  }
>
> +static bool fp_access_check(DisasContext *s)
> +{
> +    return fp_access_check_only(s) && nonstreaming_check(s);
> +}
> +
>  /*
>   * Return <0 for non-supported element sizes, with MO_16 controlled by
>   * FEAT_FP16; return 0 for fp disabled; otherwise return >0 for success.
> @@ -1450,11 +1452,20 @@ static int fp_access_check_vector_hsd(DisasContext *s, bool is_q, MemOp esz)
>   */
>  bool sve_access_check(DisasContext *s)
>  {
> -    if (s->pstate_sm || !dc_isar_feature(aa64_sve, s)) {
> -        bool ret;
> +    bool ret;
>
> -        assert(dc_isar_feature(aa64_sme, s));
> -        ret = sme_sm_enabled_check(s);
> +    switch (dc_isar_feature(aa64_sme, s)) {
> +    case true:

Why this rather than
       if (dc_isar_feature(aa64_sme, s)) {

?

> +        if (s->pstate_sm) {
> +            ret = sme_enabled_check(s);
> +        } else if (!dc_isar_feature(aa64_sve, s)) {
> +            ret = sme_sm_enabled_check(s);
> +        } else {
> +            break;
> +        }
> +        if (ret) {
> +            ret = nonstreaming_check(s);
> +        }
>          s->sve_access_checked = (ret ? 1 : -1);
>          return ret;
>      }

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

