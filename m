Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD66C83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 10:32:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHF7-00070j-P4; Thu, 03 Jul 2025 06:32:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXHEx-0006wr-6x
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:32:27 -0400
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXHEv-00083F-EP
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:32:26 -0400
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e8986a25cbfso1327259276.0
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751538743; x=1752143543; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HIm8O6yQxUZiMQjMfCe0mL1nYxsRNbBZ9BAIqzig2us=;
 b=R1TR3aVUYsUc94iVnPnm7j54jq/4CW3c8lxPnsAuOAuup/11vc0Ua17Ni9V2ChEGFh
 BMNyl4EejJ8WqiInLb4pw9zd7zamVNTq9/Oo/SVIPB9JJOn0PTmvLbWuBnyg93HlpWjD
 pCublnNCPgfFgXpd5D5nWMDGS3ON2cPh0sc8nWPpvCqtj9xdQ+HFiMX8gd/P3TZ0fVU/
 Sh4lgSgWPuZz9t0tuCYcJNoYbw8Xlg7UQ7M6a6tUnNsarqtmcewpFXSshgJnqd+ZfUJH
 ivzL8F1bhF3l6l/5WD1nTPNunOws4kq9Xp3vh5EC1iFaFj0QetzcTaz0FoeKzyxW6Aym
 BJQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751538743; x=1752143543;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HIm8O6yQxUZiMQjMfCe0mL1nYxsRNbBZ9BAIqzig2us=;
 b=sDhAwdCF3DRX5vQwjD4vKfE8rlEOvFV/qF4q7GwFSgcLebnTQUjRwU0AbLcg/+9ixy
 pzCTt146oQ0cJzO05XJjRRYnFKMoBVYfIM7Jy0M66eGzma8EgIoSLq4q6Zy2jzY6tm/6
 581DpCYIjP+W0ozrMuG6MGVOZgnuC2pYOlqLrwsJu+rTdUNo2yr1JCgwlRxqp813agmq
 PKCgYlYM6HtZkCfDXrcSffOOAneu/K6h1TxonTVtS7n/8ME7viZJ0tfUs8eZitTn0ATe
 +Es+4AOXS5Py8bIK3KTjUTHPwkG8tj60/uLTlAA359yD1dQpFbVXhKRmJyF0wIiAj2Wi
 I4iQ==
X-Gm-Message-State: AOJu0YxODFns+09A3/oWqG7/Qq/7jJ/gCzAiEMzdYaXBBvt1RJKda3xU
 3U4WLxgbD9KaiazuSHOTJnWg6FPYlk7D/ioUWD3gX5fkwSLQxlxxGiWAA4FBBFikbZaYeiT6BLU
 vA5dRNZ4nKpLcGC9wo8D+f6QqWGyDIMCxk4ROUfncXA==
X-Gm-Gg: ASbGncuAe+90lDWwbaskJAJwdhtJNMiKnS4ggQtshRNQd69jyyxVDR4SnnrEQmzgAjX
 DnIFdJnCRkAarQAgkKoHW1JeSRTRixuPRLouSjpQdS/z2b6shG0L+FqHz+xP+7HsIf+qP59riQ6
 i0+m0HkE0G1X+bVNmAdyC/rZdonWztuwuWOObKShdSAMRr
X-Google-Smtp-Source: AGHT+IE8eRP4KJb6twQQt/A0tTe2S2oXo64hendXuoZ0mTTwMEC+Maz9u0XW66UEHoyMw6M4tks+idvgHFMAtf91RiI=
X-Received: by 2002:a05:690c:6708:b0:70c:a0c9:c648 with SMTP id
 00721157ae682-716590c00d2mr44906977b3.19.1751538743343; Thu, 03 Jul 2025
 03:32:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-58-richard.henderson@linaro.org>
In-Reply-To: <20250702123410.761208-58-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 11:32:11 +0100
X-Gm-Features: Ac12FXy2u7sZZgC5qNxk9NKbKHqUdnemFy6oa25ufg8rW19vejcAiMfwuOM-ZWk
Message-ID: <CAFEAcA-9d7HzAquXhfJZP-X1FYxoWh+2J9YtLMBK00GnZ3rqvw@mail.gmail.com>
Subject: Re: [PATCH v3 57/97] target/arm: Enable SCLAMP, UCLAMP for SVE2p1
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b30;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb30.google.com
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
> These instructions are present in both SME(1) and SVE2.1 extensions.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-sve.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
> index ac4dc7db46..ff70bf27b0 100644
> --- a/target/arm/tcg/translate-sve.c
> +++ b/target/arm/tcg/translate-sve.c
> @@ -7375,7 +7375,7 @@ static void gen_sclamp(unsigned vece, uint32_t d, uint32_t n, uint32_t m,
>      tcg_gen_gvec_4(d, n, m, a, oprsz, maxsz, &ops[vece]);
>  }
>
> -TRANS_FEAT(SCLAMP, aa64_sme, gen_gvec_fn_arg_zzzz, gen_sclamp, a)
> +TRANS_FEAT(SCLAMP, aa64_sme_or_sve2p1, gen_gvec_fn_arg_zzzz, gen_sclamp, a)
>
>  static void gen_uclamp_i32(TCGv_i32 d, TCGv_i32 n, TCGv_i32 m, TCGv_i32 a)
>  {
> @@ -7426,7 +7426,7 @@ static void gen_uclamp(unsigned vece, uint32_t d, uint32_t n, uint32_t m,
>      tcg_gen_gvec_4(d, n, m, a, oprsz, maxsz, &ops[vece]);
>  }
>
> -TRANS_FEAT(UCLAMP, aa64_sme, gen_gvec_fn_arg_zzzz, gen_uclamp, a)
> +TRANS_FEAT(UCLAMP, aa64_sme_or_sve2p1, gen_gvec_fn_arg_zzzz, gen_uclamp, a)
>
>  TRANS_FEAT(SQCVTN_sh, aa64_sme2_or_sve2p1, gen_gvec_ool_zz,
>             gen_helper_sme2_sqcvtn_sh, a->rd, a->rn, 0)
> --

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

