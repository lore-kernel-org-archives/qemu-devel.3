Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00261C83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 10:32:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHEX-0006p0-Rb; Thu, 03 Jul 2025 06:32:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXHEW-0006oE-9z
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:32:00 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXHEU-0007z5-Ez
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:32:00 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-70f862dbeaeso56895987b3.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751538716; x=1752143516; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CgRI0mf69C93B+5/xP8v1dE/4zxG0F2LakoLMXmkSyw=;
 b=UVQn9DS5m58jPl9kUl2jI6nYHScz0/0SgZ9PliOHxkBl/N5e9yl6obxuNxkp6wjaH6
 ebjAQakO2rDWLi14YFiclYkg1yAEAA+DzgElZBaXhVMGQv54W7G+i/hvgm67GnipYhhv
 JWDrxuqS9k59RQJuhxATEULZKAkhd+0wyH7TXGJavA8Rbjk9nAyHdfDAmHn/vP1NzB1l
 5ByVawkkGTKH1t0Msudu6F88Uuob65b0iXAfUSpuCWGxrqyU4gTxV9IFjC0pZ1hY/7mf
 BrtqlIBOJWtGVH7Exx6EFvhagBkl6MflvHfODgQC6XRfCZVXn2C+ayxpKhwx4QYiE4zl
 LsNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751538716; x=1752143516;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CgRI0mf69C93B+5/xP8v1dE/4zxG0F2LakoLMXmkSyw=;
 b=MQa5mFhsAWcSe4+uc7Ir+WUbSRr6VCOjXJXsVV7PPYozjZqJUcHebQKMDPz8uaWW2m
 4aKz6lJEB3BqEEXrbfNF9MrqxprJ3D4eipwnKMfeajs+vKEQV0Cfu9F4toyt1OAH3eyr
 WqyZOtg+nDF+SnEH4We04Zw/vSEV0OmljPD23MoKAjRFsBBFHT7EqkbDFNzPP4ndFLZq
 9gOcJ19zUbRpz2VDgU0mDa4yAUe+qZ9FkbwXOO3J/cjhmnzp/xFAGHkdA4Ls5YYmXqsZ
 +tfUchmQYii6KLQhUl4n+c97PRKajgTAa3We8oJaUyksXQTTtGGDzkNewUwQ5s8Trr7W
 wTEQ==
X-Gm-Message-State: AOJu0YwUP/qeHIncHaN8UeCXY81vG/VKjqY4vN0jd3qJ/XIQxYva0Fwd
 Q6B5QuqDKFBChhTXff++TvXSyM4TA9VwMefg8siTJ2mD7ZlA4od11dHaSWI83qwCSOUUl++9T6x
 q5vVBLIyJkftMitWOylfyoj/worYyJQjuolaJAAmhMw==
X-Gm-Gg: ASbGncvWka8EfUE2mcAoqLif6bMjFYNhMrmx4hcFLi+IPvSxeY4Bd62vPcmnVopG3gE
 W90UiSZZwLzgUKdo4Y2vZU5PYHYSH43ce+qIPd6SvMYsmfOYJbTtj+Pq5f62aramdug0seiIZ8L
 7Wgb/S86Ef6OzWGpEdJ2W+VeYQXOaDX3xbH5axiQFKQLpt
X-Google-Smtp-Source: AGHT+IFB2pdwLeVBDVjZHgyzcu92hjBGk74ocn0/3ntEyO3ORmnL2OAYobpC3Rm2fYFneGMJA/4+YyDiXxg5hkMC0ek=
X-Received: by 2002:a05:690c:48c6:b0:70c:a5c2:ceed with SMTP id
 00721157ae682-716590e59ccmr42416697b3.25.1751538716304; Thu, 03 Jul 2025
 03:31:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-57-richard.henderson@linaro.org>
In-Reply-To: <20250702123410.761208-57-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 11:31:44 +0100
X-Gm-Features: Ac12FXzIOe0znHhi022o-baUYMo5L0pMKOEC86Od6da3qeTrip-we45jy5u7yoQ
Message-ID: <CAFEAcA91iFK-WtXL6pYRngjVU+8bDx+TgjAXhhMBUSd03wSU0w@mail.gmail.com>
Subject: Re: [PATCH v3 56/97] target/arm: Implement SME2 FCLAMP, SCLAMP, UCLAMP
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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
>  target/arm/tcg/helper-sme.h    | 15 +++++++
>  target/arm/tcg/sme_helper.c    | 52 +++++++++++++++++++++++
>  target/arm/tcg/translate-sme.c | 75 ++++++++++++++++++++++++++++++++++
>  target/arm/tcg/sme.decode      | 17 ++++++++
>  4 files changed, 159 insertions(+)

> +#define FCLAMP(NAME, TYPE, H) \
> +void HELPER(NAME)(void *vd, void *vn, void *vm,                 \
> +                  float_status *fpst, uint32_t desc)            \
> +{                                                               \
> +    size_t stride = sizeof(ARMVectorReg) / sizeof(TYPE);        \
> +    size_t elements = simd_oprsz(desc) / sizeof(TYPE);          \
> +    size_t nreg = simd_data(desc);                              \
> +    TYPE *d = vd, *n = vn, *m = vm;                             \
> +    for (size_t e = 0; e < elements; e++) {                     \
> +        TYPE nn = n[H(e)], mm = m[H(e)];                        \
> +        for (size_t r = 0; r < nreg; r++) {                     \
> +            TYPE *dd = &d[r * stride + H(e)];                   \

Probably worth a comment here that the order of the operands
to the min and max is important to get the right result when
some of the inputs are NaNs.

> +            *dd = TYPE##_minnum(TYPE##_maxnum(nn, *dd, fpst), mm, fpst); \
> +        }                                                       \
> +    }                                                           \
> +}
> +

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

