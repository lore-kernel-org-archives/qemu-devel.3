Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF47CE7717D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 16:04:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJanh-00081M-58; Fri, 06 Dec 2024 11:03:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJand-00080v-QP
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 11:03:26 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJanb-0006ek-J9
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 11:03:24 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5cecbddb574so2570804a12.1
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 08:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733501002; x=1734105802; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VYpU7huxerH/xbD8v7ChQtnPggNL6qf14qnBxnoC1oI=;
 b=WRwhkS61AoxTnnz0rKZntBeA6O3V6Kj4UebYOkxnMGLv44vcg7Bc74/vBQIiOkQqBC
 oOrLz+niCw8j37xK1roiJXA0FPN7W9odSItdVOD9++F/ytlcqcI4Rqa0n/E9jy8z7rKF
 dIDgPaoETysp9uSntJGP8zGUGiuRm6C35UPQqvuLYUqMt+VR4QX0UjVJVzH1Pb1ejHBN
 d+BX19rvGeJKYF4K1NIfTiQJguPyBGoY/AKbv0kmHbo0GAJ2fTyZx5ccuiZNPVuOMVQV
 /bJ9EcjhEOabfbEyEq/8yGjSgtzQPX4UYvPCfDiARN6sUlVM44sCTA4wBCeKK8BDtuC0
 /b6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733501002; x=1734105802;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VYpU7huxerH/xbD8v7ChQtnPggNL6qf14qnBxnoC1oI=;
 b=i9457XFeesBmyoB5bgZdEWxtkk2aaLxltZYfOrBLKlGoH5gZZkSy+J6cRys8o3bkXm
 UkNHd8Fny/kREBjtdKgn5GIFZKQ935Ot8LK5wOqgTrrARXxrCfU8fvcazjDd23XCTx8y
 ONiobSusvmZJzGNNsySMEgyZd4mousDlRsuyNoeTByqoVGKTc8MPtO15kWuiSmu3O/QO
 MnoquMcGV8INDXJ0JrcCkkDn4iGaPJ5B1q1ezdNZ5hHRYGB+qzbk6EibbsstRte7VdQQ
 QbNbx94yXlIjhxZE8vGPolYnyxQNb4d+gUn7nTkGFh9bRMs1pzxfSoEn4oS7wjl1KqKn
 8TpA==
X-Gm-Message-State: AOJu0YxyZO3cKRxYZBILTP8XSbwfArozwC7+zaZH4yxPqvt0rlSF2WLr
 Vl2+eXy2Q5aKfNFZnZK3blUeGFZ+NuH/bDzFV8RwJRmDcslUDNG3V2m2zyD0YTdCZMxuOo69kUW
 ZU7FdbuI7QUzsY5xqPaPvqsOZt2kiuVo+6+apkFjCfbL0l9uw
X-Gm-Gg: ASbGncs5TOIsFySZnZu6VCS3A6MOH/W+XRfdRamjP07GYj8JfLSGPhCu9hMGDG6F5R4
 K8CCsOGfHTEKl5Avu7qce3zU3SpRRJKkH
X-Google-Smtp-Source: AGHT+IEreAFspqL0AOwuuu47nU2GXVOINmLqdg+fePx1E/ZW/CpI/UOrWQu6vgJhW9Vusl4IEdbM7uOb9ewLi0Qv7Dw=
X-Received: by 2002:a05:6402:3881:b0:5cf:c97c:821d with SMTP id
 4fb4d7f45d1cf-5d3be462da9mr2885114a12.0.1733501001674; Fri, 06 Dec 2024
 08:03:21 -0800 (PST)
MIME-Version: 1.0
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-53-richard.henderson@linaro.org>
In-Reply-To: <20241201150607.12812-53-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2024 16:03:10 +0000
Message-ID: <CAFEAcA84cd_q8WJ8ZVg05qbxb=FfsKgN2fBndoyT8VGOBsZixA@mail.gmail.com>
Subject: Re: [PATCH 52/67] target/arm: Convert FABS,
 FNEG (vector) to decodetree
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

On Sun, 1 Dec 2024 at 15:19, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-a64.c | 61 ++++++++++++++++++----------------
>  target/arm/tcg/a64.decode      |  7 ++++
>  2 files changed, 39 insertions(+), 29 deletions(-)
>
> diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
> index 613dcdb9a2..31272c1878 100644
> --- a/target/arm/tcg/translate-a64.c
> +++ b/target/arm/tcg/translate-a64.c
> @@ -9153,6 +9153,28 @@ static bool trans_SHLL_v(DisasContext *s, arg_qrr_e *a)
>      return true;
>  }
>
> +static bool do_fabs_fneg_v(DisasContext *s, arg_qrr_e *a, bool neg)
> +{
> +    int check = fp_access_check_vector_hsd(s, a->q, a->esz);
> +    uint64_t sign;
> +
> +    if (check <= 0) {
> +        return check == 0;
> +    }
> +
> +    sign = 1ull << ((8 << a->esz) - 1);
> +    if (neg) {
> +        gen_gvec_fn2i(s, a->q, a->rd, a->rn, sign,
> +                      tcg_gen_gvec_xori, a->esz);
> +    } else {
> +        gen_gvec_fn2i(s, a->q, a->rd, a->rn, sign - 1,
> +                      tcg_gen_gvec_andi, a->esz);
> +    }
> +    return true;
> +}

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Annoying FEAT_AFP wrinkle: for FPCR.AH=1 we will need to make
fabs and fneg not flip the sign bit for NaNs. I guess that means
AH will need to be a tbflags bit so we can generate the nice
vector code for AH=0 and fall back to something else for AH=1.

thanks
-- PMM

