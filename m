Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C763810FC440
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 21:22:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAaLi-0005xa-Hf; Wed, 08 Apr 2026 17:22:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wAaLh-0005wU-FV
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 17:22:09 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wAaLe-0004ab-MH
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 17:22:09 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-82ce0a9b3f7so153475b3a.0
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 14:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775683325; x=1776288125; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=38LV6cTloIQIKNx6vlMzcV5/CyU1yfLErDb+TIbw+ek=;
 b=HZkZ4IWi964CcjuGtl7xdbxWqG81YYTATXTiMsUd+a6wo3LHpXDT0zC/hSWvN5h2VH
 gSeAYag90PfRxXMXgp9G5s422JB7VRjBxZgslZvM6kJzpPDP9sxRizdvYm5ZbeInUpz0
 rDuauGGWPbM+HJ/A/dNec4diFZcJzrhMrOHU3UTPXyv/rC29ImaK+xZhNCn9PGMfv5lU
 YXhbj6kZDXEaKeFPgwmOgZbYQJd5Uo93V47HKAuWRAUeIDBCx6kZGat30THyM3O5H95J
 POp/+XDup7pW+ZD9RPfrrb3J2wcwM2B1djEW3cUg2DjuO1SYVq7dJkRYr7ustp0mR/VR
 d/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775683325; x=1776288125;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=38LV6cTloIQIKNx6vlMzcV5/CyU1yfLErDb+TIbw+ek=;
 b=Igb/vZPOLIRNt93rJr2OcWBNyHfnK58yYewYDGIkdQPIT93uMxuO/APphMkFXEDztZ
 XUfBhNs7rFbfi6jpuCHNBshoYePowQlhT4+tJOFhIwwyFmmoR13aGEKFt4igRuTpjImC
 T+pZGWWkwE0m9WZcKavHGctb1lGctBXdZXg7yUVPVnLxryLZSaBuhnSaL1AhB0P+Am3M
 YH4F/vxl5huxfONNb0ffUWzmRfUIOTNnoXmgmz/KnuEwEnY6EYqvK61Y9uLrk/0SWT2V
 DjgWJ7653KRRBc0TEmYOXb+K/ET3IawQHmvk/P7DtHhnn8kKHLHhwfcwKuoYQRva1Ey5
 EoTA==
X-Gm-Message-State: AOJu0Yzl1igVY7oBXvn4JjYcq12gmDcIy9+gHRBWjV4bDr9lYF1OIq/M
 scmrIbnlahPHRAIUa7DlCdreNON3rQZ9Rg3j4ZddKRS4XrDuLS0UFRh8hwcoHNZ0tE9uxy78drH
 TtRZtjSA=
X-Gm-Gg: AeBDieujACNZClgTK9CHVkjmF47a5Wd2egD/qrjUrI6dsFxZy3JLUZ+tGMIHd0yz4Dm
 tLLxWHnp+T4lY8laVSs20rBgheYV7VCx/FNnMwfBhxU05iuJYh1bg/sr+RJzTT4NymOydej2gSC
 Agi20XtgkyStW7BPCNmk60BAcBnkMRpUnJXPN0dAB5PUdG3V9TR8hNdtxz1unc9GRWepXMbnK24
 lc5p2mc1XVuASUc5BiEKzY4MRKSxQQbtl7R2v7k/jfT5PQDf9eo3ODvt1vJtYr8iOgRg4vWtx4S
 Y69f93rzXLBPFCGJFIPrgzbbYpVFpiKFYBnJkwJOb94NT9lOIqbvcj7ha5QqBjW+NuU2xccGLcu
 ZYskPt2lnr3ORwwsddlT6CRB4su2l2sEKouAzqXluB2RSWBh7oeKeM+N1rafswCo7xVW3gxX4Id
 Ob+eq9l0muMchQ9Wvd0sq3k7AScbFxDhaTRQBIj0wJGBjxo3rmpTQn40phAOcmlspZl1A=
X-Received: by 2002:a05:6a00:1d99:b0:82c:dc9c:e765 with SMTP id
 d2e1a72fcca58-82dcc60c5demr1000645b3a.0.1775683324698; 
 Wed, 08 Apr 2026 14:22:04 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9c6fdd7sm21837879b3a.48.2026.04.08.14.22.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Apr 2026 14:22:04 -0700 (PDT)
Message-ID: <fc59c646-a503-42f1-9e3b-fb73cae0b6bd@linaro.org>
Date: Thu, 9 Apr 2026 07:21:58 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] linux-user/arm: Improve get_user_code_u32 and usage
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20260408013309.56122-1-richard.henderson@linaro.org>
 <20260408013309.56122-2-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260408013309.56122-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 4/8/26 11:33, Richard Henderson wrote:
> Force a little-endian load before applying SCTLR.B.
> Handle the BE32 swap correctly in thumb mode.  This
> fixes a bug with its later usage in insn_is_linux_bkpt.
> 
> Handle lock_user failure: in one case by simply falling back
> to the original SIGILL and the other by raising SIGSEGV.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/arm/cpu_loop.c | 64 ++++++++++++++++++++++++---------------
>   1 file changed, 40 insertions(+), 24 deletions(-)
> 
> diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
> index 19874f4c72..419136fdee 100644
> --- a/linux-user/arm/cpu_loop.c
> +++ b/linux-user/arm/cpu_loop.c
> @@ -29,13 +29,34 @@
>   #include "user/page-protection.h"
>   #include "target/arm/syndrome.h"
>   
> -#define get_user_code_u32(x, gaddr, env)                \
> -    ({ abi_long __r = get_user_u32((x), (gaddr));       \
> -        if (!__r && bswap_code(arm_sctlr_b(env))) {     \
> -            (x) = bswap32(x);                           \
> -        }                                               \
> -        __r;                                            \
> -    })
> +static bool get_user_code_u32(uint32_t *ret, uint32_t va, CPUARMState *env)
> +{
> +    uint32_t insn, *hptr;
> +
> +    hptr = lock_user(VERIFY_READ, va, sizeof(uint32_t), 1);
> +    if (!hptr) {
> +        *ret = 0;
> +        return false;
> +    }
> +
> +    /* Load as little-endian by default. */
> +    __get_user_e(insn, hptr, le);
> +    unlock_user(hptr, va, 0);
> +
> +    /*
> +     * Adjust the little-endian load for BE32 as required.
> +     * In thumb mode, bswap both halfwords by bswap of word then
> +     * swapping the halfwords again to restore the original order.
> +     */
> +    if (arm_sctlr_b(env)) {
> +        insn = bswap32(insn);
> +        if (env->thumb) {
> +            insn = hswap32(insn);
> +        }
> +    }
> +    *ret = insn;
> +    return true;
> +}

This isn't right for thumb be32, at least not matching translate.c.

Translate loads 2 halfwords from

   va ^ 2
   (va + 2) ^ 2

Let va = A + 2, where A % 4 == 0:

   (A + 2) ^ 2 == A
   ((A + 2) + 2) ^ 2 = (A + 4) ^ 2 = A + 6

We'd need to lock 8 bytes in this case, loading the first and last two.

It is tempting to have translate.c store the instruction that it loaded as part of raising 
the exception so that we don't have to think about such things again here.

Peter, what do you think?


r~

