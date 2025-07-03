Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92182C83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 10:39:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHLU-0004CO-0G; Thu, 03 Jul 2025 06:39:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXHLS-0004Bn-HN
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:39:10 -0400
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXHLP-0002En-8V
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:39:10 -0400
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e81a7d90835so4501737276.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751539146; x=1752143946; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=m7ZhX30w+SUHKxcEOBIia1xGdqedQEidjKYU/P0aAHc=;
 b=S69C80JzvhWZamBL7Fs9CWthIJxZSkxlUlBtcFaM6V6ZOpdQQZKESqAIk6Z5GunMbW
 tXuEIIrktBHCryqCWUrjX1RfkRfEsiPSPoDfqNND4SSrCz654kZTn7AVLBlkzMooWSGZ
 TDD+mJhyaXmevCBo7SUjni9kgIoFevM0V7YEKejyaKT5yKJNjHkiojtbrPXM7J2OlgAV
 OWJk9yeZmrvItcl2GPHLNchciIsNua0NGVYLdU6RJTiCpqBjBAMy+ZpypFD9n5Xfwg97
 4g0tklWf/VGD0fcziDyG2d5oX2qj7woXF6ldTRzVVFRSRxhYppwq6XpxhqcZDD/3Xph9
 9n8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751539146; x=1752143946;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m7ZhX30w+SUHKxcEOBIia1xGdqedQEidjKYU/P0aAHc=;
 b=O7eTXs+ZGg6gQlFbKBIFMljm44AdbzJLg6uedcVXdGm9Zr5QIG/se04RFR1AlXq9yU
 kOoqdvYX7R/0o+KVu1CLBXY0G+ONvlaeoQf1BEiQtuNSOjG2KhUMmBok696g8LFLdp5v
 j62nfTmFho5w3VWOj49D43HNiHRc60xsh5AJVgQS25ltn/ROklBDSMM6p9VFaUIHYlxL
 7MImMhZNYMOJm5rmyqAGyzYSGpA9v4KIyunzpXuKqCBrlmov6sqOJIS1fVUSywgbS51c
 /3UH43whxN/j4API3QSA4izSx5Z4/m/BJYlLcxl7T+ABJbBKoGCT6ECSsD8np2CxB4Pt
 jJ7w==
X-Gm-Message-State: AOJu0YzVXyfLa85DNPzauFMjbBndUNaB0AJOxhh68AYDjwFPI/X+KlSt
 feiOVp5orRTEjthHCALTNwQdKAJ3X/DLO298zLDGdVe1ieqYhHOIV50A0+CgIGAe5sjdOIjmUg5
 zFsyp67POuX0Zl1IjMv9YrVT36ZAwpPmmM9UDH8KGGA==
X-Gm-Gg: ASbGncsaySphpAaRlFKWy8tSApz8cVFZChFDnJ7muV8y43ebN5A1VbxHDGrdRe3+cQk
 ryRsDW/he6UiE31YbV/cWrxXgWiGehNbD8B81e0udr4eKLCLE9zqqUUpJFBEJDAjiNMPnCu2vHk
 IlJlxGnYDQUa11ZlFvlFRCfcfucipaMteZh5XYmKwQa70+
X-Google-Smtp-Source: AGHT+IHEJ5Nx5bkz+9Zu9SHsA1fb2e1wqeQOx/8MvHkckbKJnJypPxGyYeR06okWn7DYg2oWHl2QGNCQBq/04oyS2GY=
X-Received: by 2002:a05:690c:c09:b0:711:af14:3981 with SMTP id
 00721157ae682-7164d470778mr94959007b3.31.1751539145807; Thu, 03 Jul 2025
 03:39:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-63-richard.henderson@linaro.org>
In-Reply-To: <20250702123410.761208-63-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 11:38:54 +0100
X-Gm-Features: Ac12FXxCxzKyizBcCofBFylPh1SNA-Y29KhJca5O_hv4XKWCDbD4jcoL69RBx5s
Message-ID: <CAFEAcA8=25c3yADyE0nD7N6SmZnrTE+Km5YC9-pDZWKT962uNg@mail.gmail.com>
Subject: Re: [PATCH v3 62/97] target/arm: Split out do_whilel from
 helper_sve_whilel
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2b.google.com
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
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/sve_helper.c | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)
>
> diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
> index 5014fd135d..4497e9107b 100644
> --- a/target/arm/tcg/sve_helper.c
> +++ b/target/arm/tcg/sve_helper.c
> @@ -4113,26 +4113,30 @@ static uint32_t pred_count_test(uint32_t elements, uint32_t count, bool invert)
>      return flags;
>  }
>
> -uint32_t HELPER(sve_whilel)(void *vd, uint32_t count, uint32_t pred_desc)
> +static void do_whilel(uint64_t *d, uint64_t esz_mask,
> +                      uint32_t count, uint32_t oprbits)

Does the compiler generate worse code if we give the right
typed argument for d here (ArmPredicateReg *d) vs uint64_t * ?

>  {
> -    intptr_t oprsz = FIELD_EX32(pred_desc, PREDDESC, OPRSZ);
> -    intptr_t esz = FIELD_EX32(pred_desc, PREDDESC, ESZ);
> -    uint64_t esz_mask = pred_esz_masks[esz];
> -    ARMPredicateReg *d = vd;
> -    intptr_t i, oprbits = oprsz * 8;
> +    uint32_t i;
>
>      tcg_debug_assert(count <= oprbits);
>
> -    /* Begin with a zero predicate register.  */
> -    do_zero(d, oprsz);
> -
> -    /* Set all of the requested bits.  */
>      for (i = 0; i < count / 64; ++i) {
> -        d->p[i] = esz_mask;
> +        d[i] = esz_mask;
>      }
>      if (count & 63) {
> -        d->p[i] = MAKE_64BIT_MASK(0, count & 63) & esz_mask;
> +        d[i] = MAKE_64BIT_MASK(0, count & 63) & esz_mask;
>      }
> +}

Either way
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

