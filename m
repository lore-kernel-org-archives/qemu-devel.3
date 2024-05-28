Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5120C25B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 15:37:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBytO-0007Sj-1U; Tue, 28 May 2024 11:37:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBytK-0007S6-P4
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:37:34 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBytJ-0004IU-7p
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:37:34 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-57857e0f462so1213859a12.0
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 08:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716910650; x=1717515450; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oFaEL3/ajUvsHYgVR7FBeteVoZbSYcqZKWXU7bOEY+A=;
 b=A3saABWbbIlctKWxZsnjl1maoIv/ELKLKUAuU1XVcGnifvBYqSUM9AubIGJ3lj/AVm
 JfEMF8dxtV/Yha6JQrcWS/Pw8y6ajb2u8ugirUP0w9rcKj55Od/vTl5myRBdVeAbZ1pr
 sejCToLfMlLhHZ3z2l4/UOKE5yILfaI4f+mpagj6etkztwF8yct7MInPgW4r8B946P/Y
 e8sdDug/OQv5ETUPYnz8yVB4B78KqRdqs8ildbAUpJAWAWuUQnpLdgnv9P6FBeaKnphu
 vlptpTjUvdQp2B5AkJHXhWP/S9aPE285ySOWRZVARV+EyEsl1QQpCzhTTt5GkO5Vx+At
 hazw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716910650; x=1717515450;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oFaEL3/ajUvsHYgVR7FBeteVoZbSYcqZKWXU7bOEY+A=;
 b=uPaEPIqr2U3S5Asowh4DVNTRfV4Oeju92B0WwCCl4BgUksYYpV2jZLUaZTRlYC/8Qt
 Y6ew8jdHU20GiJWZECosM07ztwkj0mgR06f6Jc/s/KORp8bxZMQwjD8nYLbs6hF4wfpG
 oy6wVijMQtjU888ic4oQ4lPiLHWTW/NN4A4SljCIUoUlWPKAX/pCHJ+NiL3ewG+OZwCv
 suDvzL094/pRCldCCisrGNlctzZpcvVOM+kh4VNmkjjIhrfrCG0OPaIlge4oq5B/d/pM
 cgO2ivtZhMiLj1pQZxIyqXetjnMDoU9xAxN1/kZ6nL/0pBHGzvjZm9CfxNNkazB0stF6
 JBhg==
X-Gm-Message-State: AOJu0YxbtKLQ+Y6tjKG6ieIRC1ZmDGuuxU05aJacmNHQndl/mMtqYYbp
 fdJmcRgfzfUDIGSWimuaBiDKxV8CtHVezoOlu0GjibPn8jKYmGX11Zpch6ukeRF+nyaNBl8NhA/
 O/cY47lDx0vaqk1V9QhHaPTN0QVJzJM8yCKII5A==
X-Google-Smtp-Source: AGHT+IHM805mIJ7N3Z50oQVipkTYb39Ja2auesIQ76K3Rc9Knwl7WbSiZwIODPdvVJu5FClJCkMU36HQJPBL6lElQOw=
X-Received: by 2002:a50:d659:0:b0:579:c015:5377 with SMTP id
 4fb4d7f45d1cf-579c01555c7mr5468253a12.8.1716910650462; Tue, 28 May 2024
 08:37:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240524232121.284515-1-richard.henderson@linaro.org>
 <20240524232121.284515-39-richard.henderson@linaro.org>
In-Reply-To: <20240524232121.284515-39-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 May 2024 16:37:19 +0100
Message-ID: <CAFEAcA9oBzyrjBKcX6NdkDGde5YJzfHUYpPKfx4w20KaqhpS_Q@mail.gmail.com>
Subject: Re: [PATCH v2 38/67] target/arm: Convert SUQADD and USQADD to gvec
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sat, 25 May 2024 at 00:32, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.h            |  16 +++++
>  target/arm/tcg/translate-a64.h |   6 ++
>  target/arm/tcg/gengvec64.c     | 106 +++++++++++++++++++++++++++++++
>  target/arm/tcg/translate-a64.c | 113 ++++++++++++++-------------------
>  target/arm/tcg/vec_helper.c    |  64 +++++++++++++++++++
>  5 files changed, 241 insertions(+), 64 deletions(-)

> diff --git a/target/arm/tcg/gengvec64.c b/target/arm/tcg/gengvec64.c
> index 093b498b13..4b76e476a0 100644
> --- a/target/arm/tcg/gengvec64.c
> +++ b/target/arm/tcg/gengvec64.c
> @@ -188,3 +188,109 @@ void gen_gvec_bcax(unsigned vece, uint32_t d, uint32_t n, uint32_t m,
>      tcg_gen_gvec_4(d, n, m, a, oprsz, maxsz, &op);
>  }
>
> +static void gen_suqadd_vec(unsigned vece, TCGv_vec t, TCGv_vec qc,
> +                           TCGv_vec a, TCGv_vec b)
> +{
> +    TCGv_vec max =
> +        tcg_constant_vec_matching(t, vece, (1ull << ((8 << vece) - 1)) - 1);
> +    TCGv_vec u = tcg_temp_new_vec_matching(t);
> +
> +    /* Maximum value that can be added to @a without overflow. */
> +    tcg_gen_sub_vec(vece, u, max, a);
> +
> +    /* Constrain addend so that the next addition never overflows. */
> +    tcg_gen_umin_vec(vece, u, u, b);
> +    tcg_gen_add_vec(vece, t, u, a);
> +
> +    /* Compute QC by comparing the adjusted @b. */
> +    tcg_gen_xor_vec(vece, u, u, b);
> +    tcg_gen_or_vec(vece, qc, qc, u);

With this kind of code where we wind up doing a vector op
into vfp.qc, is there anything somewhere that asserts that
we don't try to do it with a vector length bigger than
sizeof(vfp.qc) (i.e. 128) ?

thanks
-- PMM

