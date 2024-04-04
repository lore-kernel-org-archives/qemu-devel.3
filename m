Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09CC5CD1284
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 16:40:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsQ85-0007cW-Mj; Thu, 04 Apr 2024 12:39:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rsQ83-0007b9-Sb
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 12:39:55 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rsQ81-0000ni-RQ
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 12:39:55 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-56e22574eb3so1124112a12.3
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 09:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712248792; x=1712853592; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rpSNZ3/72N8WGXgt60s/omtMEtRgwTlNcwcpc56ND78=;
 b=QL7FvpGYLyr0pYfm1AT+mGFlhWYAFXrdEq84G3e1FyETUfN5abn+uBY26IeuKvCiRs
 Lu69Xz2dYDIcUH2FKNva93oHKXXllClwCeflHacPUvevdNqEijpsTApW83dOO/kT/77o
 6pOCp0abEURwMterwsNCPGFwsQnnBxPXg0LttlvjFT+ulCBZq89YwQFc0ivbSkP9V2bv
 itMtsEWFXJqX3AcIRVgfScT1azuQMyV5ij3nFV4hvONlzJiBVWdbJSl1W96D+dC6Zpps
 7Bw3qmVBRh6DTVOOd5NNTMPxx/NdoR/Upu4Mx+c27igz+w+O7/AKVe+q1gbH/l3H2+AL
 Qt9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712248792; x=1712853592;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rpSNZ3/72N8WGXgt60s/omtMEtRgwTlNcwcpc56ND78=;
 b=UwFZ0KZsNhi8rG0gHhQAiLyKLYFh2mKDdp9MeSynAinFKhVXxMGg7DVKMHzlwBt7Op
 83WBYBNzadwIfLTiRf86PmR1+mFZYXDgMdgH3V+vfwrbONxmyt3qoakECL7O7Ho+e9Gd
 +PXMICQZk8+FfcO41y7Aa3DFEz0PN1avmz2vcVBPe4sgxO/IvnFSwX0AkXRjmjjx2yn5
 olUcFYoDA8TqcnnMcqkNNflkg605yDTo/acEVVrfUlBu8USLQKVx7n3RZYK4TVvPTonw
 xBN1RB4a/2ZV0QU2jTtyELEjCyT1Uf81Mswmw6xK0sTmiSg1eOEOxBKj1S2MpI470U7j
 Nb+Q==
X-Gm-Message-State: AOJu0YxY6ohz+u6+9yaHudJr0MXNPZk+joaCzvWQWdFHcwfKwL1yOr7F
 LOr9qdILZlN4NfALuC3SV5gxkSrEojDCm6d0EhkRfQJC8wJnBm7gDFLQDPhs+FmpWZFr+lRlwEZ
 I7A2NnzWNk4F3EgZSDsz74NbIXNHVxujmVrC5XZcFI4/9Tm+R
X-Google-Smtp-Source: AGHT+IFkShKXyzeeqLlF2uJVrFA+/9t6qlSNOXNpm8SY0R59Fv8yq4t/dNSF5MiYpVi93sIsZ3ioTALj0FvJbphF6V0=
X-Received: by 2002:a50:d5d3:0:b0:56e:246b:2896 with SMTP id
 g19-20020a50d5d3000000b0056e246b2896mr660704edj.3.1712248791994; Thu, 04 Apr
 2024 09:39:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA-VQ0yZMoFEuYWD2twe129OZHaer+-_49inW1exANKV2w@mail.gmail.com>
 <20240404162641.27528-2-zack@buhman.org>
In-Reply-To: <20240404162641.27528-2-zack@buhman.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Apr 2024 17:39:40 +0100
Message-ID: <CAFEAcA_duQyCLGyu4f4KwOCEhnEeELDHGqCM9cQtC4d6rF4piQ@mail.gmail.com>
Subject: Re: [PATCH v2] sh4: mac.l: implement saturation arithmetic logic
To: Zack Buhman <zack@buhman.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Thu, 4 Apr 2024 at 17:26, Zack Buhman <zack@buhman.org> wrote:
>
> The saturation arithmetic logic in helper_macl is not correct.
>
> I tested and verified this behavior on a SH7091, the general pattern
> is a code sequence such as:
>
>         sets
>
>         mov.l _mach,r2
>         lds r2,mach
>         mov.l _macl,r2
>         lds r2,macl
>
>         mova _n,r0
>         mov r0,r1
>         mova _m,r0
>         mac.l @r0+,@r1+
>
>     _mach: .long 0x00007fff
>     _macl: .long 0x12345678
>     _m:    .long 0x7fffffff
>     _n:    .long 0x7fffffff
>
> Test case 0: (no int64_t overflow)
>   given; prior to saturation mac.l:
>     mach = 0x00007fff macl = 0x12345678
>     @r0  = 0x7fffffff @r1  = 0x7fffffff
>
>   expected saturation mac.l result:
>     mach = 0x00007fff macl = 0xffffffff
>
>   qemu saturation mac.l result (prior to this commit):
>     mach = 0x00007ffe macl = 0x12345678
>
> Test case 1: (no int64_t overflow)
>   given; prior to saturation mac.l:
>     mach = 0xffff8000 macl = 0x00000000
>     @r0  = 0xffffffff @r1  = 0x00000001
>
>   expected saturation mac.l result:
>     mach = 0xffff8000 macl = 0x00000000
>
>   qemu saturation mac.l result (prior to this commit):
>     mach = 0xffff7fff macl = 0xffffffff
>
> Test case 2: (int64_t addition overflow)
>   given; prior to saturation mac.l:
>     mach = 0x80000000 macl = 0x00000000
>     @r0  = 0xffffffff @r1  = 0x00000001
>
>   expected saturation mac.l result:
>     mach = 0xffff8000 macl = 0x00000000
>
>   qemu saturation mac.l result (prior to this commit):
>     mach = 0xffff7fff macl = 0xffffffff
>
> Test case 3: (int64_t addition overflow)
>   given; prior to saturation mac.l:
>     mach = 0x7fffffff macl = 0x00000000
>     @r0 = 0x7fffffff @r1 = 0x7fffffff
>
>   expected saturation mac.l result:
>     mach = 0x00007fff macl = 0xffffffff
>
>   qemu saturation mac.l result (prior to this commit):
>     mach = 0xfffffffe macl = 0x00000001
>
> All of the above also matches the description of MAC.L as documented
> in cd00147165-sh-4-32-bit-cpu-core-architecture-stmicroelectronics.pdf

Hi. I just noticed that you didn't include a signed-off-by line
in your commit message. We need these as they're how you say
that you're legally OK to contribute this code to QEMU and
you're happy for it to go into the project:

https://www.qemu.org/docs/master/devel/submitting-a-patch.html#patch-emails-must-include-a-signed-off-by-line
has links to what exactly this means, but basically the
requirement is that the last line of your commit message should be
"Signed-off-by: Your Name <your@email>"

In this case, if you just reply to this email with that, we
can pick it up and fix up the commit message when we apply the
patch.

> ---
>  target/sh4/op_helper.c | 31 +++++++++++++++++++++----------
>  1 file changed, 21 insertions(+), 10 deletions(-)
>
> diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
> index 4559d0d376..ee16524083 100644
> --- a/target/sh4/op_helper.c
> +++ b/target/sh4/op_helper.c
> @@ -160,18 +160,29 @@ void helper_ocbi(CPUSH4State *env, uint32_t address)
>
>  void helper_macl(CPUSH4State *env, uint32_t arg0, uint32_t arg1)
>  {
> -    int64_t res;
> -
> -    res = ((uint64_t) env->mach << 32) | env->macl;
> -    res += (int64_t) (int32_t) arg0 *(int64_t) (int32_t) arg1;
> -    env->mach = (res >> 32) & 0xffffffff;
> -    env->macl = res & 0xffffffff;
> +    int32_t value0 = (int32_t)arg0;
> +    int32_t value1 = (int32_t)arg1;
> +    int64_t mul = ((int64_t)value0) * ((int64_t)value1);
> +    int64_t mac = (((uint64_t)env->mach) << 32) | env->macl;
> +    int64_t result;
> +    bool overflow = sadd64_overflow(mac, mul, &result);
> +    /* Perform 48-bit saturation arithmetic if the S flag is set */
>      if (env->sr & (1u << SR_S)) {
> -        if (res < 0)
> -            env->mach |= 0xffff0000;
> -        else
> -            env->mach &= 0x00007fff;
> +        /*
> +         * The sign bit of `mac + mul` may overflow. The MAC unit on
> +         * real SH-4 hardware has equivalent carry/saturation logic:
> +         */
> +        const int64_t upper_bound =  ((1ull << 47) - 1);
> +        const int64_t lower_bound = -((1ull << 47) - 0);
> +
> +        if (overflow) {
> +            result = (mac < 0) ? lower_bound : upper_bound;
> +        } else {
> +            result = MIN(MAX(result, lower_bound), upper_bound);
> +        }
>      }
> +    env->macl = result;
> +    env->mach = result >> 32;
>  }

I haven't checked the sh4 docs but the change looks right, so

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

