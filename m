Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55546C77B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 10:16:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU0hF-0004No-Lq; Tue, 24 Jun 2025 06:16:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uU0h9-0004NA-Ow
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 06:16:03 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uU0h4-0006kn-Ca
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 06:16:01 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-7086dcab64bso44525407b3.1
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 03:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750760157; x=1751364957; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/cF8LoGdbqGpj4HjCevGqbbmCJLFftPWgzY3pbQcOF8=;
 b=zRWwqjpYip1PMruAaSx+cGvJnGmgfsTpjT+y961cUvRR9nA3Q+SEoxqCX09ntWqr7F
 NA74N81ORu0GvnLfs2ZxQWWvNcu0tFTlOAiNSqwsN034YWH3352A8ASQu/47q3gyFZdN
 iP7eb0ZJzJwSd4h4sV/UsM2r9ehFQK7kiE5ZXYi05lhOTNarnDgiIlOermBt++NyW4Rl
 BNcU40N8QhjDKERtgervsb/UfzS5ZNY6HDojPxJIZ6lrOxFyKu+dP+hl8ZEvgL9k30p5
 5f3zXzif6pWonRSWLHMe9xvS3j10byTawuHWFfZ/d3Fi82TOvXKg3uRBIjpVqFu4dls1
 n46Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750760157; x=1751364957;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/cF8LoGdbqGpj4HjCevGqbbmCJLFftPWgzY3pbQcOF8=;
 b=enMy5+GTfgPTHT5+8wlOYAPEHIU7K6DfbAd00c+KRz5QKyrO+GKH3C49Aw6IKzLd6z
 Ih5ltxgPEc5fNX+kG1zto4lyEomSzr1nZWn5dccShc5HQw0DDHf1n97a3KjcgRiN9EJ4
 EbBQ+tBcqU9GCKwbbIMxELHKYuSYrv5qW79phAVqJeJhj1+zdRZoPhFRmO6Q/N5P8IZH
 qluH1y4YTLm5qnGPILu+p7RwZD/v7yspXOLRIkPsoPF5pbTCztPMYQGZbn9F7Qwv4XW6
 gtDekKe3NBGO9idwFnXGPsIb9K4OUnj7X0qZ4w9TCrtx0d1UhN+5WmNavhYSMaYmqCiK
 YvnA==
X-Gm-Message-State: AOJu0YwEqyQNkZKQnul6oU4mFVjwx6mpMJ0S4FZSuAmT4qkbzunrvwHp
 /+2suo4pX8/ph8XKK0/OoPnMDM/nYYH3YSg5c3SFQPUf859IzZ+tdQme09WHDO48+il/VZTogil
 0bLzZbOPCyZkwejVcjRwNLh7bBMASGNVwLetkuOXwh3o1GMmNvfdx
X-Gm-Gg: ASbGncuTOkXZ6bxdJTQWekhcd5UrkaXTyl51CuRJYRaI2JpB7nLs7530Jws5FNXEhXd
 hzBieopHzpkIDQyvNiS2rCeH83VO1oNNX/yTfIgC05gv+s8NyVkMviBEBwOYzYTA1M8Dpr2643O
 RthmJ1/mMR8dpc8Q1yPUIBM95Lt1xQ6mmrBJhG3ueCml9C
X-Google-Smtp-Source: AGHT+IFSCtD0sg+7UPlE033pRIppHcugp4psHS3uCISknmZQgkPzaf8i+tfSXjf0yo1lWurZyf8acu5zDXYg4UU1xQo=
X-Received: by 2002:a05:690c:360e:b0:70e:2b60:1562 with SMTP id
 00721157ae682-712c63b1f77mr240683817b3.16.1750760156696; Tue, 24 Jun 2025
 03:15:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-44-richard.henderson@linaro.org>
In-Reply-To: <20250621235037.74091-44-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Jun 2025 11:15:45 +0100
X-Gm-Features: AX0GCFv_xSln3pU3QmG5s8T9Hs-ZKGBdDbkt5b3u0P25MyGY8bdI0VdX7sKTOCA
Message-ID: <CAFEAcA_-5Coo_Mn_uW6Ymsg6vyxyYrC8Xhrf5L4+5RrGvPj3WA@mail.gmail.com>
Subject: Re: [PATCH v2 043/101] target/arm: Implement SDOT,
 UDOT (2-way) for SME2/SVE2p1
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Sun, 22 Jun 2025 at 01:00, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-sve.c | 10 ++++++++++
>  target/arm/tcg/sve.decode      |  8 +++++++-
>  2 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
> index 29b6f09260..95121cce8e 100644
> --- a/target/arm/tcg/translate-sve.c
> +++ b/target/arm/tcg/translate-sve.c
> @@ -3409,6 +3409,11 @@ TRANS_FEAT(SUDOT_zzxw_4s, aa64_sve_i8mm, gen_gvec_ool_arg_zzxz,
>  TRANS_FEAT(USDOT_zzxw_4s, aa64_sve_i8mm, gen_gvec_ool_arg_zzxz,
>             gen_helper_gvec_usdot_idx_4b, a)
>
> +TRANS_FEAT(SDOT_zzxw_2s, aa64_sme2_or_sve2p1, gen_gvec_ool_arg_zzxz,
> +           gen_helper_gvec_sdot_idx_2h, a)
> +TRANS_FEAT(UDOT_zzxw_2s, aa64_sme2_or_sve2p1, gen_gvec_ool_arg_zzxz,
> +           gen_helper_gvec_udot_idx_2h, a)
> +
>  #define DO_SVE2_RRX(NAME, FUNC) \
>      TRANS_FEAT(NAME, aa64_sve, gen_gvec_ool_zzz, FUNC,          \
>                 a->rd, a->rn, a->rm, a->index)
> @@ -7108,6 +7113,11 @@ TRANS_FEAT(SQRDCMLAH_zzzz, aa64_sve2, gen_gvec_ool_zzzz,
>  TRANS_FEAT(USDOT_zzzz_4s, aa64_sve_i8mm, gen_gvec_ool_arg_zzzz,
>             gen_helper_gvec_usdot_4b, a, 0)
>
> +TRANS_FEAT(SDOT_zzzz_2s, aa64_sme2_or_sve2p1, gen_gvec_ool_arg_zzzz,
> +           gen_helper_gvec_sdot_2h, a, 0)
> +TRANS_FEAT(UDOT_zzzz_2s, aa64_sme2_or_sve2p1, gen_gvec_ool_arg_zzzz,
> +           gen_helper_gvec_udot_2h, a, 0)
> +
>  TRANS_FEAT_NONSTREAMING(AESMC, aa64_sve2_aes, gen_gvec_ool_zz,
>                          gen_helper_crypto_aesmc, a->rd, a->rd, 0)
>  TRANS_FEAT_NONSTREAMING(AESIMC, aa64_sve2_aes, gen_gvec_ool_zz,
> diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
> index 7ed186c9bd..5234d0f0ae 100644
> --- a/target/arm/tcg/sve.decode
> +++ b/target/arm/tcg/sve.decode
> @@ -856,6 +856,9 @@ SDOT_zzxw_4d    01000100 11 1 ..... 000000 ..... .....   @rrxr_1 esz=3
>  UDOT_zzxw_4s    01000100 10 1 ..... 000001 ..... .....   @rrxr_2 esz=2
>  UDOT_zzxw_4d    01000100 11 1 ..... 000001 ..... .....   @rrxr_1 esz=3
>
> +SDOT_zzxw_2s    01000100 10 0 ..... 110010 ..... .....   @rrxr_2 esz=2
> +UDOT_zzxw_2s    01000100 10 0 ..... 110011 ..... .....   @rrxr_2 esz=2
> +
>  # SVE2 integer multiply-add (indexed)
>  MLA_zzxz_h      01000100 0. 1 ..... 000010 ..... .....   @rrxr_3 esz=1
>  MLA_zzxz_s      01000100 10 1 ..... 000010 ..... .....   @rrxr_2 esz=2
> @@ -1597,7 +1600,10 @@ UMLSLT_zzzw     01000100 .. 0 ..... 010 111 ..... .....  @rda_rn_rm
>  CMLA_zzzz       01000100 esz:2 0 rm:5 0010 rot:2 rn:5 rd:5  ra=%reg_movprfx
>  SQRDCMLAH_zzzz  01000100 esz:2 0 rm:5 0011 rot:2 rn:5 rd:5  ra=%reg_movprfx
>
> -## SVE mixed sign dot product
> +## SVE dot product
> +
> +SDOT_zzzz_2s    01000100 00 0 ..... 110 010 ..... .....  @rda_rn_rm_e0
> +UDOT_zzzz_2s    01000100 00 0 ..... 110 011 ..... .....  @rda_rn_rm_e0

These also look like they have the wrong esz ?

-- PMM

