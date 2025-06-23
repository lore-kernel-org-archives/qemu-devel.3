Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 914CBC7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 14:33:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTiDg-0004vg-Ir; Mon, 23 Jun 2025 10:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTiDe-0004ul-6F
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 10:32:22 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTiDb-00046M-6q
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 10:32:21 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-7111d02c777so35100267b3.3
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 07:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750689137; x=1751293937; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EsNYeU0JCF0wsTYaAeBcb83GsOzowHpATZliBGlU8Ak=;
 b=y05Tb5IvIZT84u0XnlCfcyiJOFoe5QrPq7cHjVea4ziykds5GmrF4BIjX7JOpWQDFf
 92EdfchkoqOCsG6wGpzeDkS6w9a8WYMd2Ay+DvX28XDuRbPO8n1i0hJOPxRyIxIS1gmX
 7ijj3DfVfu8MjYYUOEPP5awBfCdVI0zFIk0p2FLtC9N5GFaCcjWm6g/PAxw8dZfnlWHh
 pNxrNZYgda9AdwB9BYkh7vh5EJTscyL6MEC4/uBHU4yT4ccwdxdEBsKP7vCVbI3HYKSa
 S5uVv0qbVYzSekrPqSlcBK2h9SGaBRDYBOuAUi3wqrotYS/oj7lOOW83+iU+AKsNVEeo
 ndIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750689137; x=1751293937;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EsNYeU0JCF0wsTYaAeBcb83GsOzowHpATZliBGlU8Ak=;
 b=qx23Pdox0uWJslkP6/3rJbhgzpLtr6svJJb2GoI6Ildjvy7nqonEy+Vbp0C79ftqOW
 N74NcCoBTKkXtwPO8dlaapenh+QIIUzn+9q2gParACr6hPJ+xbZm7fBvYHe2TqvhfAdH
 QMDKbOk5WycSRPNM57rgyiUwiuQgpUlKySzc8uhTjA+4RzdKb245R1YzlkwCUL0thlWy
 BJgWCiUyJlHWzE9b4+ZZWnkaBMc7RGncbrUsTKwldKYslTpvk6dvxyvzn33Bo3Ea2VsD
 TxFzX5nrEcKhJyP8iJYBp3zqJBNTmI+1OmXtnY8OgeWBEIMtTMivlS5Zy8MOz9i7TmEf
 wRKg==
X-Gm-Message-State: AOJu0YzxDfm6xufVBSoi5TA2NvIs2Pgve1KEYBmCFCQvLfaZGppKt1VS
 MyJCgG7FdDR0R1/8NnbNz3F4Wli1L/iA61BHmhbefSOR/JieIp8Cp6PO5CFrLhwFELGbmz98scR
 UGU8mFQC/RS70d7ad8OGVftQo+sswkMdRvnpGPC7paA==
X-Gm-Gg: ASbGnct/KVYLwTBHt9pprF4k2MfnpF2yRF6yjNcWQosn4iVnBvY07PvRe6v6XYFY3pK
 bgxLk5nCk/wiG8pqNHIHCyhqVPqzkS5+01pZnSSWvmM55dgUgVqDg0RWDSdS2nnvzYYRsJxJoXC
 C2NbX1AHdscbIdP/4MHSAbte4wP0vd+cgpQP3ijuRK3Je+
X-Google-Smtp-Source: AGHT+IHoqnTb+BWqFqJS8rVSf99unHlJA9Mz06Ioq0C/cMY7gnKvXSYCSpHJRyl/ZZ+UTJBaXtaGE5C+uylv0crdF90=
X-Received: by 2002:a05:690c:4b07:b0:710:f55f:7922 with SMTP id
 00721157ae682-712c6753483mr173389857b3.34.1750689136634; Mon, 23 Jun 2025
 07:32:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-25-richard.henderson@linaro.org>
In-Reply-To: <20250621235037.74091-25-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jun 2025 15:32:05 +0100
X-Gm-Features: AX0GCFvXFwJMfB_up9ZQDIGIbinesOLEUpWvCUTwtz5bPHymHdaFPnDosTm9HgQ
Message-ID: <CAFEAcA_V12wZRVu7cjOVfduvG9SoXxSu1AE3HkjBg7J+VK+How@mail.gmail.com>
Subject: Re: [PATCH v2 024/101] target/arm: Split out get_zarray
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Sun, 22 Jun 2025 at 00:52, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Prepare for MOVA array to/from vector with multiple registers
> by adding a div_len parameter, herein always 1.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-sme.c | 40 ++++++++++++++++++----------------
>  1 file changed, 21 insertions(+), 19 deletions(-)


> @@ -234,7 +241,7 @@ static bool do_mova_tile_n(DisasContext *s, arg_mova_t *a, int n, bool to_vec)
>          for (int i = 0; i < n; ++i) {
>              TCGv_ptr t_zr = vec_full_reg_ptr(s, a->zr * n + i);
>              t_za = get_tile_rowcol(s, a->esz, a->rs, a->za,
> -                                   a->off * n + i, a->v);
> +                                   a->off * n + i, 1, a->v);
>              if (to_vec) {
>                  zc_fns[a->esz](t_zr, t_za, t_desc);
>              } else {
> @@ -243,13 +250,13 @@ static bool do_mova_tile_n(DisasContext *s, arg_mova_t *a, int n, bool to_vec)
>          }
>      } else {
>          for (int i = 0; i < n; ++i) {
> -            int zr_ofs = vec_full_reg_offset(s, a->zr * n + i);
> +            int o_zr = vec_full_reg_offset(s, a->zr * n + i);

This variable rename should be squashed into the previous patch
where we added this function.

>              t_za = get_tile_rowcol(s, a->esz, a->rs, a->za,
> -                                   a->off * n + i, a->v);
> +                                   a->off * n + i, 1, a->v);
>              if (to_vec) {
> -                tcg_gen_gvec_mov_var(MO_8, tcg_env, zr_ofs, t_za, 0, svl, svl);
> +                tcg_gen_gvec_mov_var(MO_8, tcg_env, o_zr, t_za, 0, svl, svl);
>              } else {
> -                tcg_gen_gvec_mov_var(MO_8, t_za, 0, tcg_env, zr_ofs, svl, svl);
> +                tcg_gen_gvec_mov_var(MO_8, t_za, 0, tcg_env, o_zr, svl, svl);
>              }
>          }
>      }

Otherwise

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

