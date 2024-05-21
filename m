Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78EB6C25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 16:17:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9SAh-00034m-Qo; Tue, 21 May 2024 12:17:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s9SAf-00032o-RS
 for qemu-devel@nongnu.org; Tue, 21 May 2024 12:17:02 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s9SAe-0004hz-8o
 for qemu-devel@nongnu.org; Tue, 21 May 2024 12:17:01 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-57825ff689bso955649a12.3
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 09:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716308218; x=1716913018; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=M6LTUce7TaSwInTvTRjvM35KB8kdU6NokoPpAiG5K3M=;
 b=EjUrCBYWFnUIS1Oa4KwbIauClRVlqb6p0j+f5/yA39JmfDqBMP7RdxV0vkSaCWBQyW
 mQrDIu49SvKjwaY7Xcx5Es4VcwX/AxCa5uytp5w77mout4haX147MEyxWQaidA8r27tr
 qJfuKMvsDhTVvrtaxH3Aw6ToLRs1ggcV/gdfy45mow2LYh05cfdYipkDKhsJSLQbNP4h
 aKDX7FrBOH+3EqxKSbyk2l7RU06vv+PLXkzZJ4BD/oXi3M0ifPLVyP1bd+toHgKBZ/Hc
 DWR7nO2XU59mvz1alu/AADFdaa2XTGyq61fZR7xkHoRfzYfErgHYEbsGMddraAm7Rqo4
 O2gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716308218; x=1716913018;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M6LTUce7TaSwInTvTRjvM35KB8kdU6NokoPpAiG5K3M=;
 b=ZU1xYMveCMKOQGsEumbm3GtIocjnl+MyEUP6cnUPy6mYpWyuSvxirU9IrpJQOZw2TI
 QqSvML/mHyYwPd6BCwYyXyoYKqZL1gWMLP+Yj3929Iu8QCxyl52ud6YhDiWYvPE5FNo6
 ynt7IHwj/TCX22n+Q7viaRzDXDZEc+Av/8sslhC/xoBQwLQeoKGxYPmQ9UVRgB/9v6A1
 A3QAJ+R6VvKybWYZTjwyllq8Cd619tSAodcYK/E0NzpM07kKLVr+o2Dueqmdz3z0p3G1
 sGPqYUKZzlUEhXEYJKqrcUhXOaJ7rozGx1mBPU9Yq8ivs86ceFvu1z08pme4gkpabXpi
 4Vlg==
X-Gm-Message-State: AOJu0Yw6/Q3OkjyF/aRSFizvAFgauCWoiy4HREHsIsMPcVbBuYExGSsP
 Vjm8bL6WPCBbZw431H97Dsxi/CMkIPL4T9yVUwS41p8Ur3uNPvTZoJKvXA5b9FzLMidm/196Bas
 5BsDq/sDcsa41+O70HAkjzufKfLfwv0MTgnep/w==
X-Google-Smtp-Source: AGHT+IGPIt/AhcgKISwBQfoPANe4hpPV4xmviTBhnj8+x0izsfuQYdKFXe6xWCt+8FTyuhhB5zdk7hekGoiL1MtWi2w=
X-Received: by 2002:a50:cd44:0:b0:572:df77:c1bf with SMTP id
 4fb4d7f45d1cf-575750f4033mr6184196a12.3.1716308217894; Tue, 21 May 2024
 09:16:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240506010403.6204-1-richard.henderson@linaro.org>
 <20240506010403.6204-58-richard.henderson@linaro.org>
In-Reply-To: <20240506010403.6204-58-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 May 2024 17:16:46 +0100
Message-ID: <CAFEAcA8YQURkn5-SjVFmR16xcv6m2WRmnJpkeg9PVZ+eFGW8fg@mail.gmail.com>
Subject: Re: [PATCH 57/57] target/arm: Convert SQDMULH, SQRDMULH to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Mon, 6 May 2024 at 02:10, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> These are the last instructions within disas_simd_three_reg_same
> and disas_simd_scalar_three_reg_same, so remove them.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.h            |  10 ++
>  target/arm/tcg/a64.decode      |  18 +++
>  target/arm/tcg/translate-a64.c | 276 ++++++++++-----------------------
>  target/arm/tcg/vec_helper.c    |  64 ++++++++
>  4 files changed, 172 insertions(+), 196 deletions(-)


> +void HELPER(neon_sqdmulh_idx_s)(void *vd, void *vn, void *vm,
> +                                void *vq, uint32_t desc)
> +{
> +    intptr_t i, j, opr_sz = simd_oprsz(desc);
> +    int idx = simd_data(desc);
> +    int32_t *d = vd, *n = vn, *m = (int32_t *)vm + H4(idx);
> +
> +    for (i = 0; i < opr_sz / 4; i += 16 / 4) {
> +        int32_t mm = m[i];
> +        for (j = 0; j < 16 / 4; ++j) {
> +            d[i + j] = do_sqrdmlah_s(n[i + j], mm, 0, false, false, vq);
> +        }
> +    }
> +    clear_tail(d, opr_sz, simd_maxsz(desc));
> +}
> +
> +void HELPER(neon_sqrdmulh_idx_s)(void *vd, void *vn, void *vm,
> +                                 void *vq, uint32_t desc)
> +{
> +    intptr_t i, j, opr_sz = simd_oprsz(desc);
> +    int idx = simd_data(desc);
> +    int32_t *d = vd, *n = vn, *m = (int32_t *)vm + H4(idx);
> +
> +    for (i = 0; i < opr_sz / 4; i += 16 / 4) {
> +        int16_t mm = m[i];

Wrong type -- this is the 's' version so should be int32_t,
I think.

> +        for (j = 0; j < 16 / 4; ++j) {
> +            d[i + j] = do_sqrdmlah_s(n[i + j], mm, 0, false, true, vq);
> +        }
> +    }
> +    clear_tail(d, opr_sz, simd_maxsz(desc));
> +}
> +
>  void HELPER(sve2_sqrdmlah_s)(void *vd, void *vn, void *vm,
>                               void *va, uint32_t desc)
>  {

-- PMM

