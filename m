Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B72D5E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 17:11:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL3lV-0002de-Gn; Tue, 10 Dec 2024 12:11:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tL3lT-0002ca-Lt
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 12:11:15 -0500
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tL3lP-0000Ls-KE
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 12:11:15 -0500
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-6ef0ef11aafso52167277b3.2
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 09:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733850670; x=1734455470; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VPMBw/1Iv66KEekGuzsqQKAoxREnBno9uQv69SWnPFY=;
 b=dPYIznv+YhKX8Z/Twt+OblXOaLsj2rbqayKrahlSp0K1un8nmsWJlg+ygXglTO0NAf
 kaSuOWARU00xPJl31r6aqOLr9VEYf6cdc1zGpdlL33tkMEaTxFBxkbjWh1Mjwn9EiS9F
 CluebwOHow0V8CaR8Df47Vuo7wLe7rg8kteNgcSD9BIU1n89FEjjp6M85RcQPYrbeIjP
 xM8uFklq5V5tEBwgzq69zF8pxUMT8WPQGC6flGXdzVb2pT25+Zq2ZFodoVjr1mFHwUJI
 F6Iz2ExGJyNsIeetamN39XMpC60QGw+UQvl76EdREV8bzfv8ueVgZAXtJCBPIjZrDZGU
 hIMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733850670; x=1734455470;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VPMBw/1Iv66KEekGuzsqQKAoxREnBno9uQv69SWnPFY=;
 b=Gy1xFhBaTm4om90Ff+0hBT40qk5ivMSExEgxjE0JGTskDgZ3aNdsbP8GkQsV5Rwuqw
 PwdOrC/vDEs6XsUz2CZNd9OnCrNbOiTZyLtVfPbsQmODIpDSSzZWtc2rofvJuNDdvjJb
 Z+XLDdKBkJIYoK4fQWinn06eQJxCG2ciUcFlD9zly71QJcd2Bsoll9dG77mzDz7RoaYr
 8K8MOuzDi84TPu+UGclRON1SuYqgxK8EUnM9zkkLY/FmldX+GWF/owxNQTE9lpge31gY
 Lb9dBafydvl0Oh7I00rWWBZYAKevhvRjqO5cdTsnHsb+rlXGSB/2doxg0QI+ZoieXLXz
 k4Kw==
X-Gm-Message-State: AOJu0YxM3iWSgeFuJWLHc0OsnXsTE81AgAfG00X6M5RMBfLJc2yyf/6J
 ehsHjwHPffma+7yR3DjkRHTf78xJTGkCTpSdKcXXPUS18WX6vUE0CbcJv+FNFEgLkjFH0c98CR9
 fSVFA8Kqi3Y4jfwjJ4jxbAnDw8j5swBTrTcmYUQ==
X-Gm-Gg: ASbGncsyxy6qeGSJwMGmSFvnpXaPo2GGDYpyI9JCtdVsl1vAz0+R/DMjBbRUbD6jqN4
 hX4d9FvnzeGyoLtURiB5BEM8wBszU3rnxZNGN
X-Google-Smtp-Source: AGHT+IE2wdF83/kgdmNv/gFQ+D7NESFoGzOsELqFyppN2+OiqyvyV/RBlEv93t6MqW5VRwqFrFzuZh5qXYBsclUa3B4=
X-Received: by 2002:a05:690c:630e:b0:6ef:96f9:2f48 with SMTP id
 00721157ae682-6f022f778b4mr63190717b3.37.1733850670405; Tue, 10 Dec 2024
 09:11:10 -0800 (PST)
MIME-Version: 1.0
References: <20241203203949.483774-1-richard.henderson@linaro.org>
 <20241203203949.483774-8-richard.henderson@linaro.org>
In-Reply-To: <20241203203949.483774-8-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Dec 2024 17:10:58 +0000
Message-ID: <CAFEAcA9HT3mTK8TeD5XHWeKKpZ-kMpWhsOfDms39LtoC2uF1ew@mail.gmail.com>
Subject: Re: [PATCH 07/11] softfloat: Use parts_pick_nan in
 propagateFloatx80NaN
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Tue, 3 Dec 2024 at 20:39, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Unpacking and repacking the parts may be slightly more work
> than we did before, but we get to reuse more code.  For a
> code path handling exceptional values, this is an improvement.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  fpu/softfloat.c | 43 +++++--------------------------------------
>  1 file changed, 5 insertions(+), 38 deletions(-)
>
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index 6ba1cfd32a..8de8d5f342 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -4928,48 +4928,15 @@ void normalizeFloatx80Subnormal(uint64_t aSig, int32_t *zExpPtr,
>
>  floatx80 propagateFloatx80NaN(floatx80 a, floatx80 b, float_status *status)

This is a curious function, because although it looks like it
ought to be part of softfloat itself in fact it is used in
exactly one function in target/m68k: floatx80_scale().

>  {
> -    bool aIsLargerSignificand;
> -    FloatClass a_cls, b_cls;
> +    FloatParts128 pa, pb, *pr;
>
> -    /* This is not complete, but is good enough for pickNaN.  */
> -    a_cls = (!floatx80_is_any_nan(a)
> -             ? float_class_normal
> -             : floatx80_is_signaling_nan(a, status)
> -             ? float_class_snan
> -             : float_class_qnan);
> -    b_cls = (!floatx80_is_any_nan(b)
> -             ? float_class_normal
> -             : floatx80_is_signaling_nan(b, status)
> -             ? float_class_snan
> -             : float_class_qnan);
> -
> -    if (is_snan(a_cls) || is_snan(b_cls)) {
> -        float_raise(float_flag_invalid, status);
> -    }
> -
> -    if (status->default_nan_mode) {
> +    if (!floatx80_unpack_canonical(&pa, a, status) ||
> +        !floatx80_unpack_canonical(&pb, b, status)) {
>          return floatx80_default_nan(status);
>      }
>
> -    if (a.low < b.low) {
> -        aIsLargerSignificand = 0;
> -    } else if (b.low < a.low) {
> -        aIsLargerSignificand = 1;
> -    } else {
> -        aIsLargerSignificand = (a.high < b.high) ? 1 : 0;
> -    }
> -
> -    if (pickNaN(a_cls, b_cls, aIsLargerSignificand, status)) {
> -        if (is_snan(b_cls)) {
> -            return floatx80_silence_nan(b, status);
> -        }
> -        return b;
> -    } else {
> -        if (is_snan(a_cls)) {
> -            return floatx80_silence_nan(a, status);
> -        }
> -        return a;
> -    }
> +    pr = parts_pick_nan(&pa, &pb, status);
> +    return floatx80_round_pack_canonical(pr, status);
>  }

If we were using this on anything except m68k this would
be a behaviour change for invalid-encoding floatx80,
but m68k currently makes floatx80_invalid_encoding()
always return false. So I think this should be OK:

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

-- PMM

