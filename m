Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16ADCC77B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 16:22:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTjvn-0001xc-Ro; Mon, 23 Jun 2025 12:22:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTjvl-0001ws-Ib
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 12:22:01 -0400
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTjvi-00040n-TN
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 12:22:01 -0400
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e8275f110c6so3299630276.2
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 09:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750695717; x=1751300517; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1+2Aza83jIseJFByeU1BU+0/ukEAJZYh9RPpphHgJ94=;
 b=QamZeoFHtHscFskwPIGVqDVy3YidGU6enZ2wyed0lMvVd69DeMbU860kxn8r6gtb0W
 +fXcYQE5ZOssKgGZI1Du7raLXAyoXb6DoaJNdgtP36zt/TYL2o0f9e8oEzs1ZEvUthR/
 +BSLG9M4DBCvG/TlY7Qd3+43OGVJ9p7Y3M2dK3mFPQYjQC8mmWMpSBAWTTqi+Qv4Ozws
 92tq4EGOFdv7ma+YVsxesSy0y7AdhjVI0So8idsHDUc67APfG3uqEtiyb4lf8HTBVAnE
 caqCgVKKNzVmfGxyKXAKk+7z4OPkQfECxLq/njQcbOvwQQipNGNa/MeGDTxinZ+F1un+
 KGkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750695717; x=1751300517;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1+2Aza83jIseJFByeU1BU+0/ukEAJZYh9RPpphHgJ94=;
 b=d7+G7eB8tPnZX6lfIcTYHLkhuA3Nvzj6YbyMFM3Zw/PjWmL3256/HWdmacU5iG/+oj
 HNKnIHr04IAVpgbonH6E+O+VWUB9YEtvn0jao0p7Kxt5QX3Dm1wAck5wE/DnIhhEJhrx
 IRWnIV0xozz3U+waAkWVwJfP2uncOf9aOr4TFzcwUHJh3J+Mx2qLdF9m27gUf+5bUVtz
 AwopTy5ln7oHWpYq/zsLNadVZ7FA/AUmyPh78fgIKsgqHayIEBIr79CfkH0Jvee9CsTD
 A2HstcIdSLiSr8dA9yWd/1yt1Ssca9qkx4TU05pRw2X9DwIRINYO17CHP2VpXslOFGaR
 t72g==
X-Gm-Message-State: AOJu0YwAmKCLPeygreOBew12ozcg8nllWhq+aehZpp7Z6jvqV7ioV/Gx
 Luexo1DaPkYREoz56IIxjAffGHGxGB8xT+rJEunTHWYoGKcY9anFWNPWv1QJ7Y4oeU5DBcU3Kr2
 6x0J5MOrU7hlgDL7mES3KH56myUGFGVxrid42dKWKpsbBQl+nfxYI
X-Gm-Gg: ASbGncvhjFVwKX8vQ1H4e9BGECIIFchVvPX6/YFI8BDxChUFy7syLXAzVfc9h0kP6CG
 3NnH81C2wDtNNBwHq5pBmnLR7Ze449MquVHCO3DuMvfrMHYDor13NwvSJRtn14K0oLQhUSfzF5y
 GKK8hmJ/1p26rXof3xh9moHk0F0J73h4EHxDsCiqZDYdTY
X-Google-Smtp-Source: AGHT+IE5caHd+tX4+QyRfUoFx4OUk8IMdJOnFC4US0UCD9I4N6yG4a5Gfit9nq4pC8cBdEoi9Hme0WneIQ4+hps60mQ=
X-Received: by 2002:a05:690c:498b:b0:70e:731f:d4c7 with SMTP id
 00721157ae682-712c6389c0amr188827317b3.8.1750695717061; Mon, 23 Jun 2025
 09:21:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-34-richard.henderson@linaro.org>
In-Reply-To: <20250621235037.74091-34-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jun 2025 17:21:45 +0100
X-Gm-Features: AX0GCFvcrKpLMV1l2skbldPblubHJgwySWFtmp2S7ea6XpduAYM6KCj8fTk284k
Message-ID: <CAFEAcA9YcT+ridRA0ZHPm1oVXOxXMh7HSmr8icb-3QRO4_yzjg@mail.gmail.com>
Subject: Re: [PATCH v2 033/101] target/arm: Pass ZA to
 helper_sve2_fmlal_zz[zx]w_s
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b35;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb35.google.com
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

On Sun, 22 Jun 2025 at 00:55, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Indicate whether to use FPST_FPCR or FPST_ZA via bit 2 of
> simd_data(desc).  For SVE, this bit remains zero.
> For do_FMLAL_zzzw, this requires no change.
> For do_FMLAL_zzxw, move the index up one bit.
>
> Read fz16 directly from env->fpcr.

This line of the commit message doesn't seem related to the change?
We were already reading fz16 from env->fpcr.

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-sve.c | 2 +-
>  target/arm/tcg/vec_helper.c    | 8 +++++---
>  2 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
> index 87b6e4a88e..7f8ca78a91 100644
> --- a/target/arm/tcg/translate-sve.c
> +++ b/target/arm/tcg/translate-sve.c
> @@ -7168,7 +7168,7 @@ static bool do_FMLAL_zzxw(DisasContext *s, arg_rrxr_esz *a, bool sub, bool sel)
>  {
>      return gen_gvec_ptr_zzzz(s, gen_helper_sve2_fmlal_zzxw_s,
>                               a->rd, a->rn, a->rm, a->ra,
> -                             (a->index << 2) | (sel << 1) | sub, tcg_env);
> +                             (a->index << 3) | (sel << 1) | sub, tcg_env);
>  }
>
>  TRANS_FEAT(FMLALB_zzxw, aa64_sve2, do_FMLAL_zzxw, a, false, false)
> diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
> index 671777ce52..16ddd35239 100644
> --- a/target/arm/tcg/vec_helper.c
> +++ b/target/arm/tcg/vec_helper.c
> @@ -2191,7 +2191,8 @@ void HELPER(sve2_fmlal_zzzw_s)(void *vd, void *vn, void *vm, void *va,
>      intptr_t i, oprsz = simd_oprsz(desc);
>      bool is_s = extract32(desc, SIMD_DATA_SHIFT, 1);
>      intptr_t sel = extract32(desc, SIMD_DATA_SHIFT + 1, 1) * sizeof(float16);
> -    float_status *status = &env->vfp.fp_status[FPST_A64];
> +    bool za = extract32(desc, SIMD_DATA_SHIFT + 2, 1);
> +    float_status *status = &env->vfp.fp_status[za ? FPST_ZA : FPST_A64];
>      bool fz16 = env->vfp.fpcr & FPCR_FZ16;
>      int negx = 0, negf = 0;
>
> @@ -2274,8 +2275,9 @@ void HELPER(sve2_fmlal_zzxw_s)(void *vd, void *vn, void *vm, void *va,
>      intptr_t i, j, oprsz = simd_oprsz(desc);
>      bool is_s = extract32(desc, SIMD_DATA_SHIFT, 1);
>      intptr_t sel = extract32(desc, SIMD_DATA_SHIFT + 1, 1) * sizeof(float16);
> -    intptr_t idx = extract32(desc, SIMD_DATA_SHIFT + 2, 3) * sizeof(float16);
> -    float_status *status = &env->vfp.fp_status[FPST_A64];
> +    bool za = extract32(desc, SIMD_DATA_SHIFT + 2, 1);
> +    intptr_t idx = extract32(desc, SIMD_DATA_SHIFT + 3, 3) * sizeof(float16);
> +    float_status *status = &env->vfp.fp_status[za ? FPST_ZA : FPST_A64];
>      bool fz16 = env->vfp.fpcr & FPCR_FZ16;
>      int negx = 0, negf = 0;
>

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

