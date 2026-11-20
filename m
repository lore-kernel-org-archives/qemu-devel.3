Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA3960A261F
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 18:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=LoKcUexC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUTOl-00051A-Ek; Fri, 20 Nov 2026 13:31:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xUTOj-00050z-R9
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 13:31:46 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xUTOh-0001Dj-SY
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 13:31:45 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-3adac5b29ebso759753a91.2
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 10:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795199502; x=1795804302; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+3B/WAfND6WRjUhyubdfJSzBMxVhilaDBkj/XXNlINk=;
 b=LoKcUexCOHtOWY2KPN+eL1VFwCFw4WaY6wIwkLFf+YWZbXQPZ4BN8w0iWsAV6Y0Ri4
 1P3l9fFMtYU55mADYmgHw37c0kRzOGQoLhKqfaF2E0Kmwsd486I5w01IB1vZ/SWcS38u
 Cupx/LqxsxDQMLRXIoDZtWvuau+Q9yAtscE2z0CqYmYiGKxOJelJgj5zB/J0WhJOpdhS
 h9sB3ipHLPsSrgd5HRTUM/5X3cc5t9YfDmLnBHXMR3/ZxbAo4ggUfGob7Q+GpsBV8Lom
 swhNLS0jWEHkyYWNY/jgNaPXQwYvBo5ukxFfPT8j50qM8x2W5vMzaN5p6wcZWPvAqVgS
 Tc7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795199502; x=1795804302;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+3B/WAfND6WRjUhyubdfJSzBMxVhilaDBkj/XXNlINk=;
 b=q60wKI4E9wC4AhCIjn46SwyjIE3kJXf+7GpjqhM6Q8PJLndh7mzv0IhbATkhNZqiDJ
 m0zT9qMOq5Ok2PCyRkWRMBvaL8gG43eStBr4gfYMUskFi9kifViXF2cl405VXp1Logfs
 d/cN/pPbDeMYs470w9iwf1m/c3OpbqGEtvJxZf4Mb/yrfXpBcdPF2dUmZFILsI4RDu76
 JXuQcz2LjPUA/XwNIlu0H75ykK4boyR6yrVWI+X4hCH9tmWusm3TKDC5jpGnSucFVy/F
 +bRaZCC4D/C9/sow4W/3jCLfnWgMvOEE/4PzD5EuK1iYq23kxCOrXVSnSNrUVqikI4bT
 RBqw==
X-Forwarded-Encrypted: i=1;
 AL+hErGfwAQmJPw0UOSnb5c+9gcbFRvx2tmK0X+ZC0dCCCzfqx9ohQiCRROu/aj7NemGpRzCGIcwsepiZV65@nongnu.org
X-Gm-Message-State: APuU4Z+9x2SC+pAxXlxSdTqWerdcAxbgBNHk1lSVt+xOz7y/Vbpd7GAU
 Ea5HKhCVvcu9ynB3yywARNIj3b1eo5r+MMsIoc1lWow5UW2XXfDD01bmpWFigFiUl1Q=
X-Gm-Gg: AZFdTZdN+ngdTvNmPr0VkZKfMPjIk2XzdPacJaaR2R+DhNHy3SznpkDc9OEtoBm3aiZ
 nwTt60+fcXmKEXHnCP+89Gjs/14JQh0P3zupwuFIsTYr/UwpTvHqgiRKlc9t/GwQJPVtjr2gkRH
 EyRQ9SdANDPhTVTWpVKYLMPNyRwSxk6esvxehWN0m/W0Q0P22jAxIo+SzlQIsjWJlHEnuTWYGNh
 PnM/M+AMLX66xWNEkvtKkPkz9m1zv+GQeebLgXCVc9BFQyNpHOqMxX1U4vhvi+3Co8LTtRK4fJX
 oYZ93kdysVA7iDXOIgR2Smew9MvpmqH27IbLUykPRJWX9NYU9DCtkVqAJMdnno8MW/48/67X+i8
 4M4tm1mFJPt6KLCt+N3XwbHOGNHXjItIf5g7HD2EuNaB/Kk3am06jNab8H0bBwkrO/udHoamUJd
 PlnDBJoBbD0ZJ8wVxZh27HCu5GUoP2dxSywLK/tRRD3RnhKnHgixtd4uxQdplkHFdgURfmX4gG2
 QNZlqNHJjCZRRHGVo6+FEmpiKLSrExr6n/Pw2w428fxoGwF6/2uJLXbfrtlA4yY3sSSEqHrr2oe
 GgEms/vPvPm/WRIpg3lFc9s6TcZIKS34F1sV60wLvi5U488B71O4vZXnB+szzgzS6G++pJY=
X-Received: by 2002:a17:90a:e70c:b0:3b3:c04e:4b61 with SMTP id
 98e67ed59e1d1-3b41cafe407mr3903665a91.47.1795199501774; 
 Fri, 20 Nov 2026 10:31:41 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b41ad92c07sm5187188a91.13.2026.11.20.10.31.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Nov 2026 10:31:41 -0800 (PST)
Message-ID: <e4159fa3-e122-43f7-8ce3-e108ce8dcbf9@linaro.org>
Date: Fri, 20 Nov 2026 10:31:39 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] target/i386: use separate MMU indexes for
 instruction fetch
To: Tim <mdspan.github@gmail.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, zhao1.liu@intel.com
References: <20261120104431.733136-1-mdspan.github@gmail.com>
 <20261120104431.733136-4-mdspan.github@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261120104431.733136-4-mdspan.github@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/20/26 02:44, Tim wrote:
> x86_cpu_mmu_index() ignores ifetch, so instruction fetches and data
> accesses at the same privilege level share a TLB.  Add user and
> supervisor fetch indexes, each in 64-bit and 32-bit forms, and return
> them for fetches.  Supervisor fetches need no SMAP variant, since SMAP
> does not apply to instruction fetches.
> 
> This lets the fetch and data translations of a linear address differ,
> which LAM needs.
> 
> Signed-off-by: Tim <mdspan.github@gmail.com>
> ---
> v2: new patch, as suggested in review of v1.
> 
>   target/i386/cpu.h         | 11 ++++++++---
>   target/i386/tcg/tcg-cpu.c |  9 ++++++++-
>   2 files changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 3945e903..5bc19d5e 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -2838,8 +2838,12 @@ uint64_t cpu_get_tsc(CPUX86State *env);
>   #define MMU_USER32_IDX     3
>   #define MMU_KNOSMAP64_IDX  4
>   #define MMU_KNOSMAP32_IDX  5
> -#define MMU_PHYS_IDX       6
> -#define MMU_NESTED_IDX     7
> +#define MMU_KFETCH64_IDX   6
> +#define MMU_KFETCH32_IDX   7
> +#define MMU_UFETCH64_IDX   8
> +#define MMU_UFETCH32_IDX   9
> +#define MMU_PHYS_IDX       10
> +#define MMU_NESTED_IDX     11
>   
>   #ifdef CONFIG_USER_ONLY
>   #ifdef TARGET_X86_64
> @@ -2856,7 +2860,8 @@ static inline bool is_mmu_index_smap(int mmu_index)
>   
>   static inline bool is_mmu_index_user(int mmu_index)
>   {
> -    return (mmu_index & ~1) == MMU_USER64_IDX;
> +    return (mmu_index & ~1) == MMU_USER64_IDX ||
> +           (mmu_index & ~1) == MMU_UFETCH64_IDX;
>   }
>   
>   static inline bool is_mmu_index_32(int mmu_index)
> diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
> index 167ff769..b8f20f20 100644
> --- a/target/i386/tcg/tcg-cpu.c
> +++ b/target/i386/tcg/tcg-cpu.c
> @@ -130,7 +130,14 @@ int x86_mmu_index_pl(CPUX86State *env, unsigned pl)
>   static int x86_cpu_mmu_index(CPUState *cs, bool ifetch)
>   {
>       CPUX86State *env = cpu_env(cs);
> -    return x86_mmu_index_pl(env, env->hflags & HF_CPL_MASK);
> +    unsigned pl = env->hflags & HF_CPL_MASK;
> +
> +    if (ifetch) {
> +        int mmu_index_32 = (env->hflags & HF_CS64_MASK) ? 0 : 1;
> +
> +        return (pl == 3 ? MMU_UFETCH64_IDX : MMU_KFETCH64_IDX) + mmu_index_32;
> +    }
> +    return x86_mmu_index_pl(env, pl);
>   }
Instead of "normal" vs "fetch", I suggest "normal" vs "masked".

This way, if no mask is enabled, only one mmu_idx is used and fewer page 
table walks are required.

Thus ifetch would always be "normal".


r~


r~

