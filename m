Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DD64C77B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 17:01:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTkXV-0006SA-J1; Mon, 23 Jun 2025 13:01:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTkXA-0006GD-Rn
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 13:00:45 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTkX4-0000v6-Tk
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 13:00:36 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-70a57a8ffc3so37943427b3.0
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 10:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750698033; x=1751302833; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mhpSFxHJgGjBSBDtNydENANMLijeMQOiEBizElaSN/A=;
 b=HjCS1GEJWOBw5meu7cX8ylf4Y8sLl+pM6IWxAonhn85VHiG6IEwPPS0v6yeHtCXtbf
 r2YE1LE5VcUymiJUzTBfWUNOQ9z3bkohA2oONBEVG57hU0DIX+DshybCAb3w1IAOf/sF
 JjhNy9aJmkab0YOIzViGyjpdkpSRfYRzWqls7uifDfYeUmkg2AbwCjn3FP/kyzDa6xRo
 e8ZknEcqTi/VGIsnzCxg8R5+sYg30o8Pxpsml033BWBZsItK3HShiBO6LegdjTTG7MzX
 zUzAmwjWMH5bwjZHOZqaYX5fTxzKT+z0+kQzaACbsZ6yOZCEGMNQFFGmvm6J66o1yfdG
 vNfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750698033; x=1751302833;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mhpSFxHJgGjBSBDtNydENANMLijeMQOiEBizElaSN/A=;
 b=j0MPFaULiHBqDwJROiN3vmu03fhylyzkrVhGIUT6Vo9iL362AzbJwgZgjlcTTXwnNO
 BNh9jgb9VH0VAWdnwk6xL5WASsHZiiZ8PYDfCLtZzRk4BvAuAKn+ytypl/LneDpT19Dt
 i7gEWUJ658Inv+DFlG35G1JEI/qvd0moEWt3QGGKetXT+Gv1Wxcg3ZoVC9PINInK8LXw
 2uDIpXw1M3vHuWRibuf8ji+ie07klhMXD58jQ8GaoPpRXO5qy8NCEd5GHEh04fT/9uZo
 0c+yGQA/WkhIjXDR/vhXIHo3Xg85rCPg50he8SFn9v27Pi6bujS+HcOB/E3xsv9d0GTm
 krXA==
X-Gm-Message-State: AOJu0Yz0RsvaphZebGKOOyP31GGIJLzed56V7gbVReEk1PanPpllPBD0
 oK642Np9oEJGWY6VSXo316olDzfJ+ZiyCB9xyn5mcMK34o35xlrE9wEeUxbd3kzdkVlo98SKD6S
 gDh+bLpo8di/y9JCsEZ0SYCmrG3iTD4j++WYApyW1F0a/KkK6hrpE
X-Gm-Gg: ASbGncvjTPl5x9oeelMoRSwOTdfgWZUpUuTUZFXqDX2k1HH1Gs1YauJ7/3fhe+gnlW3
 5Txh6lcufA90amm9QLTUoDg0StMXuKB1khDU2tMR4nILuN1sBYmHdJDLnMSit1+FOM0DW/bnmbr
 00hl5TpzHjRSS82lAvxqyj8JifjRDkGMZOtJi+6Dqo4GbW
X-Google-Smtp-Source: AGHT+IF8vhgi8xq2zRIM1jLwMLKQOeDPO3ib9aykK2Hwn05MwYAqMc99dWafAk0Is+q3z9IYUsQqP+E73CUY85RZw/4=
X-Received: by 2002:a05:690c:5506:20b0:711:9770:161f with SMTP id
 00721157ae682-712c63b2b02mr133532757b3.2.1750698031401; Mon, 23 Jun 2025
 10:00:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-40-richard.henderson@linaro.org>
In-Reply-To: <20250621235037.74091-40-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jun 2025 18:00:19 +0100
X-Gm-Features: AX0GCFsf06jkhsiH1ccFp71haoSMnTyu4Ib2uPzGpCWC-X3i6gmVfTjDtoTYVFU
Message-ID: <CAFEAcA_6egE3UjyPHS-H7s+LuNc8je6=2YqLo42rTLRsXhdzDg@mail.gmail.com>
Subject: Re: [PATCH v2 039/101] target/arm: Remove helper_gvec_sudot_idx_4b
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Sun, 22 Jun 2025 at 00:53, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Add gen_helper_gvec_sudot_idx_4b as an expander which
> swaps arguments and uses helper_gvec_usdot_idx_4b.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/helper.h     | 2 --
>  target/arm/tcg/translate.h  | 3 +++
>  target/arm/tcg/gengvec.c    | 6 ++++++
>  target/arm/tcg/vec_helper.c | 1 -
>  4 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/target/arm/tcg/helper.h b/target/arm/tcg/helper.h
> index c459eba079..2702627eab 100644
> --- a/target/arm/tcg/helper.h
> +++ b/target/arm/tcg/helper.h
> @@ -622,8 +622,6 @@ DEF_HELPER_FLAGS_5(gvec_sdot_idx_4h, TCG_CALL_NO_RWG,
>                     void, ptr, ptr, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_5(gvec_udot_idx_4h, TCG_CALL_NO_RWG,
>                     void, ptr, ptr, ptr, ptr, i32)
> -DEF_HELPER_FLAGS_5(gvec_sudot_idx_4b, TCG_CALL_NO_RWG,
> -                   void, ptr, ptr, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_5(gvec_usdot_idx_4b, TCG_CALL_NO_RWG,
>                     void, ptr, ptr, ptr, ptr, i32)
>
> diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
> index 8cf6324e2f..90a03a4642 100644
> --- a/target/arm/tcg/translate.h
> +++ b/target/arm/tcg/translate.h
> @@ -627,6 +627,9 @@ void gen_gvec_urecpe(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
>  void gen_gvec_ursqrte(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
>                        uint32_t opr_sz, uint32_t max_sz);
>
> +void gen_helper_gvec_sudot_idx_4b(TCGv_ptr d, TCGv_ptr n, TCGv_ptr m,
> +                                  TCGv_ptr a, TCGv_i32 desc);
> +
>  /*
>   * Forward to the isar_feature_* tests given a DisasContext pointer.
>   */
> diff --git a/target/arm/tcg/gengvec.c b/target/arm/tcg/gengvec.c
> index 01867f8ace..c182e5ab6f 100644
> --- a/target/arm/tcg/gengvec.c
> +++ b/target/arm/tcg/gengvec.c
> @@ -23,6 +23,12 @@
>  #include "translate.h"
>
>
> +void gen_helper_gvec_sudot_idx_4b(TCGv_ptr d, TCGv_ptr n, TCGv_ptr m,
> +                                  TCGv_ptr a, TCGv_i32 desc)
> +{
> +    gen_helper_gvec_usdot_idx_4b(d, m, n, a, desc);
> +}
> +

How does this work? In the DO_DOT_IDX() helper functions
the 'm' argument is indexed, so I don't see how we can
just flip the n and m arguments around.

-- PMM

