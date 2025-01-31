Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D5DC02192
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 13:10:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdqm9-0005tc-35; Fri, 31 Jan 2025 08:09:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tdqm5-0005tD-JW
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 08:09:34 -0500
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tdqm4-0001bk-6S
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 08:09:33 -0500
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e53ef7462b6so2652943276.3
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 05:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738328970; x=1738933770; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Stt/WuqebF885zS+LXLGMY2KW39tdPe4GGsXi8oHJug=;
 b=PblW5x75gTbrRsMX1hxO5vFjDx8Cl6xxH2Kop51pPQZI1AAbo1CfalM8DYBIzTSnDX
 oE/+d5JukhJMOjSyn3ZufJMDkBePbsEWh2ibbv0+shePoNUw+gGMQnvvkCWveyJr4+u7
 hCaRe+Zpkc3lH4/YPKOIuXd9qzJPRe7ZPy2g0PRVIGLmVk6ticc620J3120aYZs461Dk
 XxtpIqL1zgo51o9vT8CwqkiCZiyaQ2LbsdppqZCPQeEkyR90EIyE1kGqAiQdM2r/LPPZ
 t+FCMUTWycMsBoPxuWtEtwoH30eBKr1r3GbwS0SEw0rpgsrP1UEQ8z3/OnpxT0L0YpYF
 VwOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738328970; x=1738933770;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Stt/WuqebF885zS+LXLGMY2KW39tdPe4GGsXi8oHJug=;
 b=IL+S06UflvuR+S26AK6MarSWmn7nEwQt5KxAIcDzpmYZL3aIqKW3tu7LiTLuUCF2ky
 /7nvEGOYc+DRYGSSCvtqMX43u/T0znDNv6E3pvymIZH2MZQCgMOL+sr4koQfC3Kh8X5M
 xzRZCDTym+nsidvmyZsL5DrmlE3y+nm3yXQOmQWOoTj6lM2E0toDYSv93548IEIwLlmx
 u8M18a2ps8bMeinwC8EUYgJHTNFK+oLZc1x7d+cUKRqgT100n39h/n2fqXYL9/BUZbfw
 rDEN99fv9bv6bVcJdqrJcma/hJG0ZMxj5N5TP8nHha10hdLNhv1Ojd7P6NmmzIQk5SQj
 IdxA==
X-Gm-Message-State: AOJu0YzJT7wJE6kiuR21J4p/aY5SreaaIYZbHpuHA9/tMul+6uUsaxsx
 auuRiul7jyU4pQHK6Z5zWlVHjVp6sxjpvl3ih4c59mQ72YgXwNasizuiwPpappsNKHf6leMThMv
 /8nAqyNsFJ34wVd5mHJuKzcJL6hpoFJedrkv3Ig==
X-Gm-Gg: ASbGncvRN/3gYECqCJuIxgSJMAI3H6aFVTjIidqNu9Xjn6rjU8UNHnuSxLb/VU04cS8
 P3uIUkmOQgZFb8W+/bur/LwJwna8bzrhg8z0Y53KbTkxEUazOkDFqJCk/khp6VATSF3rA9FnEkw
 ==
X-Google-Smtp-Source: AGHT+IG7NE9z5H/PmE5SkqoM4XeTPxDQZBuH16FTwUJSNeKl9+NbtFOeaorcTFW6jAluEZllkJoRo9srGdFCva/0E54=
X-Received: by 2002:a05:6902:1a41:b0:e57:4226:8ae0 with SMTP id
 3f1490d57ef6-e58a4ae962amr8453708276.18.1738328970346; Fri, 31 Jan 2025
 05:09:30 -0800 (PST)
MIME-Version: 1.0
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-46-peter.maydell@linaro.org>
 <7e368ef4-a60e-4308-aeb9-ec910361c424@linaro.org>
In-Reply-To: <7e368ef4-a60e-4308-aeb9-ec910361c424@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 31 Jan 2025 13:09:19 +0000
X-Gm-Features: AWEUYZkTj5D_Ijm-qg-bcTju_hDvfML4NGKTpZWPae7VS1Yu1_iUFkNjwFUrMZw
Message-ID: <CAFEAcA9RbsEpp3yyXe2Nf2KJ6yTXp36oEP7SHSrvX1NyPS3k1Q@mail.gmail.com>
Subject: Re: [PATCH 45/76] target/arm: Implement FPCR.AH semantics for scalar
 FMIN/FMAX
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2a.google.com
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

On Sun, 26 Jan 2025 at 12:44, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 1/24/25 08:28, Peter Maydell wrote:
> > diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
> > index 05036089dd7..406d76e1129 100644
> > --- a/target/arm/tcg/helper-a64.c
> > +++ b/target/arm/tcg/helper-a64.c
> > @@ -399,6 +399,42 @@ float32 HELPER(fcvtx_f64_to_f32)(float64 a, float_status *fpst)
> >       return r;
> >   }
> >
> > +/*
> > + * AH=1 min/max have some odd special cases:
> > + * comparing two zeroes (even of different sign), (NaN, anything),
> > + * or (anything, NaN) should return the second argument (possibly
> > + * squashed to zero).
> > + * Also, denormal outputs are not squashed to zero regardless of FZ or FZ16.
> > + */
> > +#define AH_MINMAX_HELPER(NAME, CTYPE, FLOATTYPE, MINMAX)                \
> > +    CTYPE HELPER(NAME)(CTYPE a, CTYPE b, float_status *fpst)            \
> > +    {                                                                   \
> > +        bool save;                                                      \
> > +        CTYPE r;                                                        \
> > +        a = FLOATTYPE ## _squash_input_denormal(a, fpst);               \
> > +        b = FLOATTYPE ## _squash_input_denormal(b, fpst);               \
> > +        if (FLOATTYPE ## _is_zero(a) && FLOATTYPE ## _is_zero(b)) {     \
>
> The comment says "even of different sign", the pseudocode explicitly checks different
> sign.  But of course if they're the same sign a and b are indistinguishable.  Perhaps
> slightly different wording?

Sure. I changed from "(even of different sign)" to
"(regardless of sign)". Let me know if you have a
more specific tweak you'd like.

thanks
-- PMM

