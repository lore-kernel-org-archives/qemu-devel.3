Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33409C7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 15:26:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTj3K-0004Rt-K7; Mon, 23 Jun 2025 11:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTj3G-0004QD-FI
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 11:25:42 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTj3E-0003nq-TA
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 11:25:42 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-708d90aa8f9so41774897b3.3
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 08:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750692339; x=1751297139; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ywUg36zUdXmmBW1uqClQzzlDUWoO2Ygb+zPwHU4DuUw=;
 b=SrKAnkgF3y+fBwW+h/+TeltQYxzbxvHVyH+FbieRwjGdz4/S96lUbO/uyGN+aZJ8Ec
 5Gh6uxRVJOhorqXyYeYRfJjLG9jOuCGgFxVbLtnvHciM+uauMAuxUHGkRCX+gyo97abG
 6/mkOrA8D0wiy4fZJ0HTxW2A232GsTx3HZog88UX+ugiwhieZvOh15i3u1gl6zdh6/NF
 ZXALRiUzPB00pYVdXQwxMtQtA597cvJBHQhWyLFneRVgWLGAAXFVozh2enzmX/5TPJBe
 zX8+WUtXDtSJqEvyL/ACcU+U2Ix6UbeJDYT0d+fPzlrnc4kig9Bois5A8Y9RCGMXu01g
 wxlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750692339; x=1751297139;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ywUg36zUdXmmBW1uqClQzzlDUWoO2Ygb+zPwHU4DuUw=;
 b=EmxBWr44ViOo6nIxx3BQUR4STeVKqOCijD+fiUOzqF6JM5kReT0DvkmDuKViqFnHxJ
 kuMVKx3hxZVJoI4ka/lLLik8XA+8R4UNLl7/gbF9NAWE4bQ6OhR1ZG0f1pS4Oyar7nP+
 kMPWPoNZjNHWmDu2or5TyEGZgvB3hutkj5XL3j3Vjp5JPJ1FM2LDb92bGUo+YIMGeBS9
 5CN1UdKdf0wyGxjVW1Fv0jB9xvzs4tRjzYhNZCB/PW/c0pV0P6Mvl3SIAaN53Lsqzjg/
 cmgqvjpHxoNHiv3gIwSC39l4NavkTACsGwed24L1UndUT+D6xjEnOf+W35xGgsmwytBs
 NJdA==
X-Gm-Message-State: AOJu0Yz3Ug9jy//dwIx+/5Fz/YT+0cvIp85Zr7Lt4Q/xtdY5x8rrOleI
 qaqpKjo6BMlGyR6ZlojJeMQtjiAR8VMSqdl3vMAYAuTyXafK3zhQskrBp1e326veJiAq5nu2xU8
 INmfBlbP0a83hp+f195p7MRYlUn0T8Crgk9z7sPlG0A==
X-Gm-Gg: ASbGncteeNSxVXx4Utf17o8357KZtm7lc1th8ralbf5aq+eav4VJof0GBVmBnz20hJ3
 OXdLgVGicF3uToUHzPCZuumTiExD9n3dCW48FRGIPrXDEA3HfdaEjVFfWvt3KPZQlr+giDS1VzM
 HA8GikADWcmSvpX+vy8sOC9kQI3XTja/EPEUUf9ZNPqNgPZYsPFN7D3n4=
X-Google-Smtp-Source: AGHT+IGl9n+P4W94AH0sQ++YWQeQED1Ubs31P/ik+wY0lpvxgEQSdruSl9Sunxgmq5mNxQiXQ3gAiVXMqJooGMHjRkQ=
X-Received: by 2002:a05:690c:931c:10b0:710:ee40:1891 with SMTP id
 00721157ae682-712c63ec4c9mr132822687b3.10.1750692338854; Mon, 23 Jun 2025
 08:25:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-31-richard.henderson@linaro.org>
In-Reply-To: <20250621235037.74091-31-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jun 2025 16:25:27 +0100
X-Gm-Features: AX0GCFuutfI2whWZMs2TIvEWJOgxTbpVOIhebB_glKVgf-A_VHbbAxudJ_XDsN4
Message-ID: <CAFEAcA-1t=MYCnE=Pd=sy+BvwqV0m7YU9uNkkNaATU4AEyqGkg@mail.gmail.com>
Subject: Re: [PATCH v2 030/101] target/arm: Implement SME2 Multiple Vectors
 SVE Destructive
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Sun, 22 Jun 2025 at 00:58, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-sme.c | 65 ++++++++++++++++++++++++++++++++++
>  target/arm/tcg/sme.decode      | 36 +++++++++++++++++++
>  2 files changed, 101 insertions(+)
>
> diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
> index 0e05153924..617621d663 100644
> --- a/target/arm/tcg/translate-sme.c
> +++ b/target/arm/tcg/translate-sme.c
> @@ -550,6 +550,37 @@ TRANS_FEAT(SRSHL_n1, aa64_sme2, do_z2z_n1, a, gen_gvec_srshl)
>  TRANS_FEAT(URSHL_n1, aa64_sme2, do_z2z_n1, a, gen_gvec_urshl)
>  TRANS_FEAT(SQDMULH_n1, aa64_sme2, do_z2z_n1, a, gen_gvec_sve2_sqdmulh)
>
> +static bool do_z2z_nn(DisasContext *s, arg_z2z_en *a, GVecGen3Fn *fn)
> +{
> +    int esz, dn, dm, vsz, n;
> +
> +    if (!sme_sm_enabled_check(s)) {
> +        return true;
> +    }
> +
> +    esz = a->esz;
> +    n = a->n;
> +    dn = a->zdn;
> +    dm = a->zm;
> +    vsz = streaming_vec_reg_size(s);
> +
> +    for (int i = 0; i < n; i++) {
> +        int dofs = vec_full_reg_offset(s, dn + i);
> +        int mofs = vec_full_reg_offset(s, dm + i);
> +
> +        fn(esz, dofs, dofs, mofs, vsz, vsz);
> +    }
> +    return true;
> +}

Don't we need to handle Dn and Dm overlapping here, the way
we did in the previous patch ?

-- PMM

