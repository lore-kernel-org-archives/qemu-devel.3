Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B3BC3DA49
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2024 15:06:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVBem-00048w-33; Sat, 20 Jul 2024 11:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sVBel-00048T-8m
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 11:05:55 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sVBej-0004VP-Jb
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 11:05:55 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5a156557026so2068543a12.2
 for <qemu-devel@nongnu.org>; Sat, 20 Jul 2024 08:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721487952; x=1722092752; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RFkQFABEHMPsF0yeK38TFcv0Y5VICfmj1GCAN/YKJ4I=;
 b=pqVdgID4ZpUzEnjwH8+IDSBJFj5MMymk/CzhgP51i+AZM6++/ZGvAWMdHfjYx6mIqs
 oX9SpUiq6I34DHiRQhwS9cEbVSk+JnNA4XwM16ICUDnV6KPL/Okh77K5puIzi/FhbZmn
 hAVjfP19LGUpqTJOUJOh6O0VPwVsRMx8yXp1ZOfQC4OgodGuEU+MahBOfW/eSsUq6N8w
 qbEdrDe9rP2Yda54QER9iKRN+b7wli1rp6F0zln36BbuhlaVWhKE93Z7a7p8zx5FXwXQ
 ej3+If8lT6zr3/YcuE+EfJA19NcYEMgiMy4u7HKKVgf4bBVHzua0+qw0UJX6+rWexiBg
 y5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721487952; x=1722092752;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RFkQFABEHMPsF0yeK38TFcv0Y5VICfmj1GCAN/YKJ4I=;
 b=Ybs9pfE5XTdYgoOokkHP6Cxc4CgrVyvxePQWDqIPHbK2L9idf0U0sqQjMdh7HNtqHv
 F0oNVox63GAB7jKJngy8rvpqA8awPhLHJbLZTgeiG0lf3NEfbth9A5YKigcYl44f0lqB
 QBEqn42th5+6kpeFntGqcxtr+cFsePJeSukJOdijkntEvf0p9zZwAaFUmzwqSdGTi7VS
 GNPWHxISFdWQJW7m88KpDmBsQ2UOzl/OnhcoIPtl1JW8F1sFtCOeC0b8YcJ63QEnVz7u
 PRshQv5w+SA7/Pey5rQ2wnDxABYiutN5c36yWO8kGSKHEUqbjXNwJR7ACsjpSmzUpSXh
 D4/Q==
X-Gm-Message-State: AOJu0YzfPQSpUIdwL+N5T4fkvz3F5JusuGP0W76o2hXJjyrjIegXH4bY
 uhSkAAgT7kqgvljav9zUagy6R0XKlaiIBylvR7NirIgzHzYFoj3OpdejZSdv9I+i9l3bUTE+PPC
 ixHF2zUAqKcHY7L1oEHudpfLtDOgRXvM7VYvON8+e/JCUVeFMIUY=
X-Google-Smtp-Source: AGHT+IF+RGeZh46vn44O22ONiFZTyJgDfwe5PdhzZw+ZakZODiutUSgr5v74DSJCw+J0JSC62siWps0KPPjiUzxAg10=
X-Received: by 2002:a50:cc8a:0:b0:5a1:1:27a9 with SMTP id
 4fb4d7f45d1cf-5a4798755f1mr1179894a12.18.1721487951183; 
 Sat, 20 Jul 2024 08:05:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240718132028.697927-1-peter.maydell@linaro.org>
 <20240718132028.697927-22-peter.maydell@linaro.org>
In-Reply-To: <20240718132028.697927-22-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 20 Jul 2024 16:05:40 +0100
Message-ID: <CAFEAcA-H=n-3mHC+eL6YjfL1m+x+b+Fk3mkgZbN74WNxifFVow@mail.gmail.com>
Subject: Re: [PULL 21/26] hw/arm/smmu: Refactor SMMU OAS
To: qemu-devel@nongnu.org
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

On Thu, 18 Jul 2024 at 14:20, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> From: Mostafa Saleh <smostafa@google.com>
>
> SMMUv3 OAS is currently hardcoded in the code to 44 bits, for nested
> configurations that can be a problem, as stage-2 might be shared with
> the CPU which might have different PARANGE, and according to SMMU manual
> ARM IHI 0070F.b:
>     6.3.6 SMMU_IDR5, OAS must match the system physical address size.
>
> This patch doesn't change the SMMU OAS, but refactors the code to
> make it easier to do that:
> - Rely everywhere on IDR5 for reading OAS instead of using the
>   SMMU_IDR5_OAS macro, so, it is easier just to change IDR5 and
>   it propagages correctly.
> - Add additional checks when OAS is greater than 48bits.
> - Remove unused functions/macros: pa_range/MAX_PA.

Hi; Coverity has spotted a possible problem with the OAS handling
in this code (CID 1558464). I'm not sure if that's directly because of
this patch or if it's just that the code change has caused Coverity to
flag up a preexisting problem.

It's quite possible this is a false-positive because Coverity hasn't
noticed that the situation can't happen; but if so I think it's also
sufficiently unclear to a human reader to be worth addressing anyway.

> -static int decode_ste_s2_cfg(SMMUTransCfg *cfg, STE *ste)
> +static int decode_ste_s2_cfg(SMMUv3State *s, SMMUTransCfg *cfg,
> +                             STE *ste)
>  {
> +    uint8_t oas = FIELD_EX32(s->idr[5], IDR5, OAS);
> +
>      if (STE_S2AA64(ste) == 0x0) {
>          qemu_log_mask(LOG_UNIMP,
>                        "SMMUv3 AArch32 tables not supported\n");
> @@ -460,7 +463,15 @@ static int decode_ste_s2_cfg(SMMUTransCfg *cfg, STE *ste)
>      }
>
>      /* For AA64, The effective S2PS size is capped to the OAS. */
> -    cfg->s2cfg.eff_ps = oas2bits(MIN(STE_S2PS(ste), SMMU_IDR5_OAS));
> +    cfg->s2cfg.eff_ps = oas2bits(MIN(STE_S2PS(ste), oas));

oas2bits() is implemented as a function that returns -1 if the input
isn't a valid OAS. But we don't check for that failure here, so we put
the result into a uint8_t, which ends up as 255. Then later in
the function we will do
  MAKE_64BIT_MASK(0, cfg->s2cfg.eff_ps)
which will do an undefined-behaviour shift by a negative number
if eff_ps is 255.

If the invalid-OAS case is impossible we should assert rather
than returning -1; if it's not impossible we should handle it.

Mostafa, could you have a look at this, please?

thanks
-- PMM

