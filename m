Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA65EC25B79
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 14:15:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA9E5-0005Xz-HD; Thu, 23 May 2024 10:15:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sA9Do-0005Nk-Sf
 for qemu-devel@nongnu.org; Thu, 23 May 2024 10:15:15 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sA9Dk-0003YR-Vd
 for qemu-devel@nongnu.org; Thu, 23 May 2024 10:15:08 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2e3fa13f018so78428811fa.3
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 07:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716473701; x=1717078501; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=V5OOuRgXvHNipC+r1MzlWTh5qtBQmboK+WnzB/sfMMc=;
 b=qGg236bGnYmUT/v8redXcff67frKNoi2ACHSCE/Rmod/HRZcvlf37PBtcbY/SSx0Rw
 CcwpOr2GRtMUhXCE58+GmkjIglaTZkVMbdpxkwc/GJBITzIIE4O65WgThe/1zxGrksDn
 cFO40dGw8RPwoubcq3X8ohl0k0ELCBG4Qz3MviYGhtAx46FxF9v9suo9pMJxMT1FYuPt
 cI6UTG5FGRXpSgodBoK2YCjCBfum0ygkKA7tW2AETqenpYzdpTnNnAVGx8oXda8OQYHo
 iT9StC5uGVLtMHp632H9mh54QR4xa0bMOYaGkhgaF5CCViX74q5QD7QMl/S3fZP3vnov
 svqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716473701; x=1717078501;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V5OOuRgXvHNipC+r1MzlWTh5qtBQmboK+WnzB/sfMMc=;
 b=EOe/JGedv/VD6qOyU61gkzjh1yhQQwoRlsYiFDOtdEgpJxkHO/tKq7u8dgurfHajcL
 5Ha2NVZnICgXEWRUIQ+WladswD69W5UJJjHzBkZ2DFc7k0JvaqDkc8M8RZ4Q3Q5OmvQ7
 ZkUCuucupbvqQFO26bChYv3w+zZNmyjagWLKt76UNMkzJeqlX/a+LW/bP3zJL5Z9Jp75
 HGmUpkC21ajAuH4vtJ6N6irVvv1ohj4xuFQTiMjKOFQByap2IceSTl9gC9+mVh7mk9zY
 BZuuZrfEYaH6BTRDIzUL+ChoKWUQHr5Mq8PbNPPhEAgBgovaQDB1axehHNqY1tO2wwIr
 0iFg==
X-Gm-Message-State: AOJu0YxPb8baz5BH2wAWEa/B2Wn3CrQ2SG+beoMkKj6f1CdbhNFKhAAK
 30rwnUFxubE7LoJkufSZs1D8ZiYRiLLFz1COIIXfPkpweo9K9a0djpNmHiSUGOJRIFv5OjZx9Md
 G9yqCiKP9vqCL1JR80t4kFfxcBFn8H/Zm1SDPww==
X-Google-Smtp-Source: AGHT+IH1XPU3Fupy/mEfb1xDN03w0WYBVsGMRSP+U8yn6Doy2kTA0LhIds/XcPBv6FUvMmRJdVMtmQSGvVVoaNT3QMM=
X-Received: by 2002:a2e:90ca:0:b0:2dc:bf5c:9648 with SMTP id
 38308e7fff4ca-2e9494cb7bbmr32642171fa.19.1716473700689; Thu, 23 May 2024
 07:15:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240506010403.6204-1-richard.henderson@linaro.org>
 <20240506010403.6204-31-richard.henderson@linaro.org>
In-Reply-To: <20240506010403.6204-31-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 May 2024 15:14:49 +0100
Message-ID: <CAFEAcA8t=f15=FQeb4ZVKBDRfcUSS-=YqHETNFrF9U=TnFiBfA@mail.gmail.com>
Subject: Re: [PATCH 30/57] target/arm: Improve vector UQADD, UQSUB, SQADD,
 SQSUB
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x233.google.com
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

On Mon, 6 May 2024 at 02:07, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> No need for a full comparison; xor produces non-zero bits
> for QC just fine.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/gengvec.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/target/arm/tcg/gengvec.c b/target/arm/tcg/gengvec.c
> index 22c9d17dce..bfe6885a01 100644
> --- a/target/arm/tcg/gengvec.c
> +++ b/target/arm/tcg/gengvec.c
> @@ -1217,21 +1217,21 @@ void gen_gvec_sshl(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
>      tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
>  }
>
> -static void gen_uqadd_vec(unsigned vece, TCGv_vec t, TCGv_vec sat,
> +static void gen_uqadd_vec(unsigned vece, TCGv_vec t, TCGv_vec qc,
>                            TCGv_vec a, TCGv_vec b)
>  {
>      TCGv_vec x = tcg_temp_new_vec_matching(t);
>      tcg_gen_add_vec(vece, x, a, b);
>      tcg_gen_usadd_vec(vece, t, a, b);
> -    tcg_gen_cmp_vec(TCG_COND_NE, vece, x, x, t);
> -    tcg_gen_or_vec(vece, sat, sat, x);
> +    tcg_gen_xor_vec(vece, x, x, t);
> +    tcg_gen_or_vec(vece, qc, qc, x);
>  }
>
>  void gen_gvec_uqadd_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
>                         uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
>  {
>      static const TCGOpcode vecop_list[] = {
> -        INDEX_op_usadd_vec, INDEX_op_cmp_vec, INDEX_op_add_vec, 0
> +        INDEX_op_usadd_vec, INDEX_op_add_vec, 0
>      };

Why don't we need to add XOR to this list? Is it because we can
assume we have XOR-of-vector on all vector-capable hosts?

thanks
-- PMM

