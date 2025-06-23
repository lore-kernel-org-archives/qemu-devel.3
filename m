Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C120BC77B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 16:39:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTkBr-0006rv-SP; Mon, 23 Jun 2025 12:38:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTkBo-0006rW-Qb
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 12:38:37 -0400
Received: from mail-yb1-xb2f.google.com ([2607:f8b0:4864:20::b2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTkBn-00069w-9r
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 12:38:36 -0400
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e8275f110c6so3315445276.2
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 09:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750696714; x=1751301514; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sZSW/9macfqEAneXwcaRlqSymD/KMG94TDETorpAEpA=;
 b=II29ceQnbRLk7AQX+GljFBP+eRcEHYtwivLqrbSuyq8saCjwfE4lrUfeoRsh7r8ARf
 M4pECUJQbXckLh0Nb527+XN0GPbfUOyStYub8iuDniQMV+h/Kl+1DcqmHvd9B7WdSny1
 6oe0PdIRgbXGkPCVKB4cdMyc6tj4St6XMi/aHaCyXBfPzJm7PT+u07/Dg+h/OxNEw2EB
 FIZvui0YkLSkAFFVWPCHRChhVM9Dz9O7F/PQz6Cyb+LUfaPZa7C+f2+z221bcl5AVL7X
 TFmv2WnLkfkTFWm1mNOMOL7lZICPYhQ9UugyG6cVpOKjavtgFSe67OpH29Y2o1RUhe0x
 KqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750696714; x=1751301514;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sZSW/9macfqEAneXwcaRlqSymD/KMG94TDETorpAEpA=;
 b=ihx2ukvvxeTmbEX83LYj45EhmDFyAmz0qAKFrTFL8EkzPoWMylo/eunXJ5o4vuzj2g
 SDJ75/G5Zl2RtMOj7GhEWqalzsXMoudeFcZGLpVxMhZpbQtoIscrpixI8x6fGLnwAtg5
 3ry4OZZrEiq9N4iq2IuRnwmth1ogpcghd5ctnp+fo2XnfX34ao9DLpm2P9670fJU7NIN
 hSJLvIzHe4xajXr42VPikeUs0L7ZymTUv3CAOORQQ8/PV8a0Rr76W4y0mh8L9y7sn/Tn
 qOWwe1AE6FDMMxIavzbiVbL4Uo1DZQdpCeP0Kipfh2SAr8fQY0+pmWxkwEsV1bTvOAC/
 nK/w==
X-Gm-Message-State: AOJu0YxXRhfqDWDARu+FhYuB8Nz8yZDN8v7MQZFBEasohmu96umUCX/X
 K4wHAhcmVElRVU/W/8SXkg8m14pX85dDxHGKXWPmFXKmZGgybFYnk1aMl5DAOTaAYDk83PxNF4k
 qnXVNzHapkP5Ju1twY+xiGKzMRRfZuPKWH2xdinBIWA==
X-Gm-Gg: ASbGncvBs3rNYf5VjNrVfy+Wj8EmY8j3oEZbL1QeZiN5M4fN+nCKh3mjMUNbiweLHZF
 +hWmz7Sd1m9dnuucYU73QXqkXYx8oUVjS6zVDFZK2DkFhz55GJ8H9v3JtrtXUcJJav3bPXtKza9
 ejXWxy3KNElYsVTglmx0OToliLM+nzwI616n5vENLj+qFpI+nUPHhBGlo=
X-Google-Smtp-Source: AGHT+IGIu6wn0N9DcmLmFZ/rj9JGAn3exQpzYxbvt8hUvsiIgfwzDHvEM1DniHf6buz0sfno9RAOjk3pEV+a1ei6spk=
X-Received: by 2002:a05:690c:6b89:b0:70c:a0c9:c648 with SMTP id
 00721157ae682-712c64e578emr200014247b3.19.1750696713843; Mon, 23 Jun 2025
 09:38:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-36-richard.henderson@linaro.org>
In-Reply-To: <20250621235037.74091-36-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jun 2025 17:38:21 +0100
X-Gm-Features: AX0GCFtDGuzek7lZOoU4cxVtAzVPpvMUN2zw2s6l7KF4uKNKKQ_0hh_8g5NXHA0
Message-ID: <CAFEAcA87DoZhX0NNEf7nao48VGu7nfpmO0wug6JduYLtEKp35w@mail.gmail.com>
Subject: Re: [PATCH v2 035/101] target/arm: Implement SME2 FDOT
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2f.google.com
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

On Sun, 22 Jun 2025 at 00:54, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/helper-sme.h    |  5 ++++
>  target/arm/tcg/sme_helper.c    | 44 ++++++++++++++++++++++++++++++++++
>  target/arm/tcg/translate-sme.c | 18 ++++++++++++++
>  target/arm/tcg/translate-sve.c |  5 ++++
>  target/arm/tcg/sme.decode      | 14 +++++++++++
>  target/arm/tcg/sve.decode      |  8 +++++--
>  6 files changed, 92 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
> index cdd7058aed..ec93ff57ff 100644
> --- a/target/arm/tcg/helper-sme.h
> +++ b/target/arm/tcg/helper-sme.h
> @@ -173,3 +173,8 @@ DEF_HELPER_FLAGS_5(gvec_fmaxnum_b16, TCG_CALL_NO_RWG,
>                     void, ptr, ptr, ptr, fpst, i32)
>  DEF_HELPER_FLAGS_5(gvec_fminnum_b16, TCG_CALL_NO_RWG,
>                     void, ptr, ptr, ptr, fpst, i32)
> +
> +DEF_HELPER_FLAGS_6(sme2_fdot_h, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_FLAGS_6(sme2_fdot_idx_h, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, ptr, env, i32)
> diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
> index 194560eafa..bd9b81d5aa 100644
> --- a/target/arm/tcg/sme_helper.c
> +++ b/target/arm/tcg/sme_helper.c
> @@ -1122,6 +1122,50 @@ void HELPER(sme_fmopa_h)(void *vza, void *vzn, void *vzm, void *vpn,
>      }
>  }
>
> +void HELPER(sme2_fdot_h)(void *vd, void *vn, void *vm, void *va,
> +                         CPUARMState *env, uint32_t desc)
> +{
> +    intptr_t i, oprsz = simd_maxsz(desc);
> +    bool za = extract32(desc, SIMD_DATA_SHIFT, 1);
> +    float_status *fpst_std = &env->vfp.fp_status[za ? FPST_ZA : FPST_A64];
> +    float_status *fpst_f16 = &env->vfp.fp_status[za ? FPST_ZA_F16 : FPST_A64_F16];
> +    float_status fpst_odd = *fpst_std;
> +    float32 *d = vd, *a = va;
> +    uint32_t *n = vn, *m = vm;
> +
> +    set_float_rounding_mode(float_round_to_odd, &fpst_odd);
> +
> +    for (i = 0; i < oprsz / sizeof(float32); ++i) {
> +        d[H4(i)] = f16_dotadd(a[H4(i)], n[H4(i)], m[H4(i)],
> +                              fpst_f16, fpst_std, &fpst_odd);

I can never figure out with these helpers when we need the H
macros and when we don't...

> +    }
> +}

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

