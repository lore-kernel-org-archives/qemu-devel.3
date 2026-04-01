Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FE63D35179
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 12:14:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7uS3-0005h6-9E; Wed, 01 Apr 2026 08:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7uS1-0005gh-MQ
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 08:13:37 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7uRz-00046P-LE
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 08:13:37 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-487035181a7so45913635e9.2
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 05:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775045613; x=1775650413; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bepM9FIpEtnfGoflw+qrPAiPV0BrUC8KLp7KrGeD36g=;
 b=l37zbTqn8XDKqdGTTdcolSHMq0N6TsXo30LJ+/mkvwDMCxSwNw6/DTfS5cFmH3E8yJ
 +hVe4hUnch8PUcwAlAHXG/4gLbdDJaSsQOU1/ugglYL8SNnAqWI49v6siwZEGzk49Btp
 sStV1vhaxIrmrx6wUa5XtD7CTFnH8Oi+pi/m9zOEXHQ6l2m7Ym6JEEqUeFiWf1X474sT
 8k8d6oo5seMnRIgAbo6DOmFl99Gag9LONpTwMQ9JVPjyfIK5zZh3FUdxbNomWChRAK9L
 ch1ctCh0WA29pAScPAhCnAW7uZ32k2CZ7lMzVtiqpPy9fdhZwI/ZBCgcbJCS0l2NLykI
 nBXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775045613; x=1775650413;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bepM9FIpEtnfGoflw+qrPAiPV0BrUC8KLp7KrGeD36g=;
 b=qV1MK4j4RAYNmMhHouq+YcOZN7cG6gcrHWt3nTsriEjFaa7l4JAbV7NkW/CpLEywt2
 QC0AriNjUdm7chXnfDGychcjdB9n6ra/GJ4HX2LsNJ8nBlRPGHYKBeOMT5/wNY23wdlP
 GlKm3h33bMpEVrUAYwAwvs+pP01wM5aBuiQ8M1NxwacGT8Jt+W2UTVrt7fH7ekHOGW/D
 5eaaFbjScylq+RcKMtL7Jp1dWqdEK2rUlKHPPH3IzIrxLhPn6/1NNzy95+pdmFicjiil
 3sU5APHapdOOiwq+SJw7oNI55Kcyfu5fNn2TXkaijCoUZBYLrP8Sbsbm7di80DLssJ+y
 wyUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkV+SSSKdwmXc4HNZegmaCx80SphSMuQ7OcHQRiw6+UTfAkUVPPbyGhVwN6U9hkq7lWbXmDH20QX5o@nongnu.org
X-Gm-Message-State: AOJu0YyUPTcMp8fXRAiaJJNTcLVChrrDDJ8FSm5CJ3+YMlVWzGVLZACe
 Ht+bHoK7uKRFgxiuJdc6Kq/egc56Fq+nVjegckoe28Th/JRAId/7r12xTKHgoOq5sus=
X-Gm-Gg: ATEYQzx+iiY79qmToyEojWm/fetwhgPnKlhCJSLCqTm+Cypx+yJPSQpLvYab5q0rzma
 rP8qawq1yorqY8PDHbGOIUHdPkzLonURHNmsKE/wDi+0Bf4DNebKnf5qG3vTBQV9R9+xAIEIPCW
 J+GnWxYdxVL7vHdRA16+n95Jxfp3f240vjm09oRAD0zpHNloicfrDHUL0B/KsaM77EC+Erf2W80
 +TE0307HgmLbvWBgdvgihDsh4oA817esz+MR8pwLYWT/e5yDbYjBSTB3+R7kzjBa51CVMhwDIsa
 jYEYclxFrK02p2I7gcL380dzVd6MP/XGXEvfbAllcE1vEfvCuml/+P3cvHj+/2uYDM7qFUyogmc
 q1rp1Slk5Aj8MkmM/EvpLxcjbEbZ28uh6hIoFX87ZEPjEbdUvSCMO2bT88295UwaotQs9eiLJMa
 Hfh+LozuwXuKhmdvsspD3fNJTKsZxvMWuY4JJmtpfCuTIUIkT/hlnen6sauOkI55WYng==
X-Received: by 2002:a05:600c:45c5:b0:485:3193:6ddb with SMTP id
 5b1f17b1804b1-4888356a036mr54704795e9.3.1775045613053; 
 Wed, 01 Apr 2026 05:13:33 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887c8dca46sm47590355e9.30.2026.04.01.05.13.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 05:13:31 -0700 (PDT)
Message-ID: <75a472a5-3b7e-4fc3-864a-4d726eb0d88f@linaro.org>
Date: Wed, 1 Apr 2026 14:13:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/12] include/tcg/tcg-op: extract memory operations to
 tcg-op-mem.h
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, jim.macarthur@linaro.org
References: <20260327165042.604105-1-pierrick.bouvier@linaro.org>
 <20260327165042.604105-2-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260327165042.604105-2-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 27/3/26 17:50, Pierrick Bouvier wrote:
> This new header defines a new type for target virtual address,
> independent from TCGv and is parameterized by a new define
> TCG_ADDRESS_BITS (name was suggested by Paolo instead of
> TARGET_ADDRESS_BITS).
> 
> By default, tcg-op.h include set this define to TARGET_LONG_BITS, but
> it's also possible to include only tcg-op-common.h and tcg-op-mem.h and
> set TCG_ADDRESS_BITS manually, which is what next commits will do.
> 
> We preserve existing MIT license when extracting this new header.
> 
> Implemented from:
> https://lore.kernel.org/qemu-devel/a68321f0-3d54-4909-864c-9793cda05b2a@linaro.org/
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/tcg/tcg-op-mem.h | 126 +++++++++++++++++++++++++++++++++++++++
>   include/tcg/tcg-op.h     | 100 +------------------------------
>   2 files changed, 129 insertions(+), 97 deletions(-)
>   create mode 100644 include/tcg/tcg-op-mem.h
> 
> diff --git a/include/tcg/tcg-op-mem.h b/include/tcg/tcg-op-mem.h
> new file mode 100644
> index 00000000000..36931d1dd57
> --- /dev/null
> +++ b/include/tcg/tcg-op-mem.h
> @@ -0,0 +1,126 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Target dependent memory related functions.
> + *
> + * Copyright (c) 2008 Fabrice Bellard
> + */
> +
> +#ifndef TCG_TCG_OP_MEM_H
> +#define TCG_TCG_OP_MEM_H
> +
> +#ifndef TCG_ADDRESS_BITS
> +#error TCG_ADDRESS_BITS must be defined

Alternatively rename as tcg-op-mem.h.inc and check for TCG_TCG_OP_H,
erroring "this header can't be included directly" or "can only be
included by "tcg/tcg-op.h"?

> +#endif
> +
> +#if TCG_ADDRESS_BITS == 32
> +typedef TCGv_i32 TCGv_va;
> +#define TCG_TYPE_VA TCG_TYPE_I32
> +#define tcgv_va_temp tcgv_i32_temp
> +#define tcgv_va_temp_new tcg_temp_new_i32
> +#elif TCG_ADDRESS_BITS == 64
> +typedef TCGv_i64 TCGv_va;
> +#define TCG_TYPE_VA TCG_TYPE_I64
> +#define tcgv_va_temp tcgv_i64_temp
> +#define tcgv_va_temp_new tcg_temp_new_i64
> +#else
> +#error
> +#endif
> +

...

> +
> +#endif /* TCG_TCG_OP_MEM_H */
> diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
> index 7024be938e6..96a5af1a298 100644
> --- a/include/tcg/tcg-op.h
> +++ b/include/tcg/tcg-op.h
> @@ -16,6 +16,9 @@
>   #error must include QEMU headers
>   #endif
>   
> +#define TCG_ADDRESS_BITS TARGET_LONG_BITS
> +#include "tcg/tcg-op-mem.h"
> +
>   #if TARGET_LONG_BITS == 32
>   # define TCG_TYPE_TL  TCG_TYPE_I32
>   #elif TARGET_LONG_BITS == 64
> @@ -46,103 +49,6 @@ typedef TCGv_i64 TCGv;
>   #error Unhandled TARGET_LONG_BITS value
>   #endif

...

