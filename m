Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 273FBC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:11:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqd6Z-0004es-Hp; Fri, 07 Mar 2025 14:11:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqd6W-0004Y6-AG
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:11:28 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqd6S-0005yI-KH
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:11:27 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2fee4d9c2efso4039905a91.3
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 11:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741374683; x=1741979483; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8rdRRuRUBzxrt5SMTYr25b430C+FWF9U4qpYfx110Mo=;
 b=i6KWJ6aVqQXFRKIrz2ZseGPG05WKhoXYZ4zteq9tpE3DNrSyG/5g4MXu+r13YN58s/
 erkwfUncR6/wlAR36EfZ5vR6xcsHD7MQMMFPrAWUo7vZA1lUL7fvxUP0X46sY7cpsszQ
 oIEJzLvCJDB1uBjdScCQ55PyZlpEvZWbpu1YO4UPh3p798fMJOGe4UhMSFnTXYQZlkF+
 PzPU94jtRh+i2CajCsXxO51CJvutg0aEnkbuO8fwre7p3K9UaBJUKgLT23Qz2KiBOfss
 MgYh90xAMBCNKDmUUnK6ZbDZ2+sZgmtXYczfP+23gNEi1IRDnyxNxhl89Jaw7W6/3WvZ
 ZYsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741374683; x=1741979483;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8rdRRuRUBzxrt5SMTYr25b430C+FWF9U4qpYfx110Mo=;
 b=PSQwbZ8GmOmNuY9OHvsvr+j3/LFj6mN29IH29W8XqZ8HcUFbgjycJVzLZ6MM/AUmyH
 6qHewkC9Oh4xoMnFtBKcJ7H9VwZ594f3WRUGtBtzVhvjGLUuhxlws2sbu2cp0aqtmIua
 FWnf3PYs99iZoZR1eYWWck+qzLpA64Ur+9eTox6dVhFWG+VNp4dBKWNlQGHNaijs9KI2
 TKaoUykkTOjFlzcLHXQmwirw96KZXY7lS9mzX32S32iOkvUESU3FEkv05hYcw0t2+Njl
 nZ6E5QY/y3Iitrwu/eWr5uH0ZcXFLgO0eEAwGxWYdmo8sTFzc8aZQr/lUhSGTwH4zSnx
 Eqiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYEehhab0GmzCk2c35EK4d5ezyIqWcdHMEQsBTjrdmARZ3+8YKHnLknZZ9PF6/LqTaodLNl4WvbWzT@nongnu.org
X-Gm-Message-State: AOJu0Yz+1ewZCxR5PEoqicyTPv/YqokdaU0MCD5pURokJCE1z5j81duk
 CJVes1cDQFgnvoSZnEqHN3DAqqcrO9i/kyad5P0Dtut3IMYkmQiqvH2uINggu48DArKfvrmXmnO
 5
X-Gm-Gg: ASbGncsC2VdKS/1GLV9DnBNGtAK7OFqbAXixlFq3OgXKlnpkEpCXzw3dGRFOd3gNtat
 3K3+gq9+n5YD64F/jXtvaFg8GbbPoa9vxqlTWP0edDwyysngwA0o2Zh8/uYYnnbQdFBQZl3Z8+Y
 /WaLYkPMvifsFs4JNc3yU9ExpmsVokRLNlmhI+b6CatewVbCQjUgkkOWboNhs+0I02JvfDKtPTO
 ts1wZN7YDGV0tWafEF4evp3Af5DA4u9Zya+ajHWcTRpEN5FzRUECiZOoNIEID2yG1UHpX7/wsuO
 kaACQwjHXFeZAxYuFmJwMLS2QS6IwtvRPeJNxuoGknw1NyyqVq4W/9uasg==
X-Google-Smtp-Source: AGHT+IFY3DtZo2klkkjLU8omvHh+PgiaSZeCteu9AlOVQwp5zKMqhjsXz5nFMqE1FF0HXjOlZ6NgSg==
X-Received: by 2002:a17:90b:4f8d:b0:2f5:747:cbd with SMTP id
 98e67ed59e1d1-2ff7ce89c80mr8104864a91.18.1741374682971; 
 Fri, 07 Mar 2025 11:11:22 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff6937494esm3430586a91.28.2025.03.07.11.11.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 11:11:22 -0800 (PST)
Message-ID: <4408a91a-d701-4234-8f8a-87a469b168e3@linaro.org>
Date: Fri, 7 Mar 2025 11:11:21 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] include/exec: Move TARGET_PAGE_{SIZE, MASK, BITS} to
 target_page.h
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250307185645.970034-1-richard.henderson@linaro.org>
 <20250307185645.970034-2-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <20250307185645.970034-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102a.google.com
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

On 3/7/25 10:56, Richard Henderson wrote:
> Re-use the TARGET_PAGE_BITS_VARY mechanism to define
> TARGET_PAGE_SIZE and friends when not compiling per-target.
> Inline qemu_target_page_{size,mask,bits} as they are now trivial.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> 
> After this, we could in fact remove qemu_target_page_foo(), etc.
> We certainly don't need to convert any more uses of TARGET_PAGE_FOO.
> 
> r~
> 
> ---
>   include/exec/cpu-all.h     | 21 +-------------
>   include/exec/poison.h      |  5 ----
>   include/exec/target_page.h | 58 ++++++++++++++++++++++++++++++++++----
>   page-target.c              | 18 ------------
>   page-vary-target.c         |  2 ++
>   5 files changed, 55 insertions(+), 49 deletions(-)
> 
> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
> index 09f537d06f..8f7aebb088 100644
> --- a/include/exec/cpu-all.h
> +++ b/include/exec/cpu-all.h
> @@ -105,26 +105,7 @@ static inline void stl_phys_notdirty(AddressSpace *as, hwaddr addr, uint32_t val
>   
>   /* page related stuff */
>   #include "exec/cpu-defs.h"
> -#ifdef TARGET_PAGE_BITS_VARY
> -# include "exec/page-vary.h"
> -extern const TargetPageBits target_page;
> -# ifdef CONFIG_DEBUG_TCG
> -#  define TARGET_PAGE_BITS   ({ assert(target_page.decided); \
> -                                target_page.bits; })
> -#  define TARGET_PAGE_MASK   ({ assert(target_page.decided); \
> -                                (target_long)target_page.mask; })
> -# else
> -#  define TARGET_PAGE_BITS   target_page.bits
> -#  define TARGET_PAGE_MASK   ((target_long)target_page.mask)
> -# endif
> -# define TARGET_PAGE_SIZE    (-(int)TARGET_PAGE_MASK)
> -#else
> -# define TARGET_PAGE_BITS_MIN TARGET_PAGE_BITS
> -# define TARGET_PAGE_SIZE    (1 << TARGET_PAGE_BITS)
> -# define TARGET_PAGE_MASK    ((target_long)-1 << TARGET_PAGE_BITS)
> -#endif
> -
> -#define TARGET_PAGE_ALIGN(addr) ROUND_UP((addr), TARGET_PAGE_SIZE)
> +#include "exec/target_page.h"
>   
>   CPUArchState *cpu_copy(CPUArchState *env);
>   
> diff --git a/include/exec/poison.h b/include/exec/poison.h
> index f4283f693a..ce43a12965 100644
> --- a/include/exec/poison.h
> +++ b/include/exec/poison.h
> @@ -44,11 +44,6 @@
>   #pragma GCC poison TARGET_FMT_ld
>   #pragma GCC poison TARGET_FMT_lu
>   
> -#pragma GCC poison TARGET_PAGE_SIZE
> -#pragma GCC poison TARGET_PAGE_MASK
> -#pragma GCC poison TARGET_PAGE_BITS
> -#pragma GCC poison TARGET_PAGE_ALIGN
> -
>   #pragma GCC poison CPU_INTERRUPT_HARD
>   #pragma GCC poison CPU_INTERRUPT_EXITTB
>   #pragma GCC poison CPU_INTERRUPT_HALT
> diff --git a/include/exec/target_page.h b/include/exec/target_page.h
> index 98ffbb5c23..8e89e5cbe6 100644
> --- a/include/exec/target_page.h
> +++ b/include/exec/target_page.h
> @@ -14,10 +14,56 @@
>   #ifndef EXEC_TARGET_PAGE_H
>   #define EXEC_TARGET_PAGE_H
>   
> -size_t qemu_target_page_size(void);
> -int qemu_target_page_mask(void);
> -int qemu_target_page_bits(void);
> -int qemu_target_page_bits_min(void);
> -
> -size_t qemu_target_pages_to_MiB(size_t pages);
> +/*
> + * If compiling per-target, get the real values.
> + * For generic code, reuse the mechanism for variable page size.
> + */
> +#ifdef COMPILING_PER_TARGET
> +#include "cpu-param.h"
> +#include "exec/target_long.h"
> +#define TARGET_PAGE_TYPE  target_long
> +#else
> +#define TARGET_PAGE_BITS_VARY
> +#define TARGET_PAGE_TYPE  int
> +#endif
> +
> +#ifdef TARGET_PAGE_BITS_VARY
> +# include "exec/page-vary.h"
> +extern const TargetPageBits target_page;
> +# ifdef CONFIG_DEBUG_TCG
> +#  define TARGET_PAGE_BITS   ({ assert(target_page.decided); \
> +                                target_page.bits; })
> +#  define TARGET_PAGE_MASK   ({ assert(target_page.decided); \
> +                                (TARGET_PAGE_TYPE)target_page.mask; })
> +# else
> +#  define TARGET_PAGE_BITS   target_page.bits
> +#  define TARGET_PAGE_MASK   ((TARGET_PAGE_TYPE)target_page.mask)
> +# endif
> +# define TARGET_PAGE_SIZE    (-(int)TARGET_PAGE_MASK)
> +#else
> +# define TARGET_PAGE_BITS_MIN TARGET_PAGE_BITS
> +# define TARGET_PAGE_SIZE    (1 << TARGET_PAGE_BITS)
> +# define TARGET_PAGE_MASK    ((TARGET_PAGE_TYPE)-1 << TARGET_PAGE_BITS)
> +#endif
> +
> +#define TARGET_PAGE_ALIGN(addr) ROUND_UP((addr), TARGET_PAGE_SIZE)
> +
> +static inline size_t qemu_target_page_size(void)
> +{
> +    return TARGET_PAGE_SIZE;
> +}
> +
> +static inline int qemu_target_page_mask(void)
> +{
> +    return TARGET_PAGE_MASK;
> +}
> +
> +static inline int qemu_target_page_bits(void)
> +{
> +    return TARGET_PAGE_BITS;
> +}
> +
> +int qemu_target_page_bits_min(void);
> +size_t qemu_target_pages_to_MiB(size_t pages);
> +
>   #endif
> diff --git a/page-target.c b/page-target.c
> index 82211c8593..321e43d06f 100644
> --- a/page-target.c
> +++ b/page-target.c
> @@ -8,24 +8,6 @@
>   
>   #include "qemu/osdep.h"
>   #include "exec/target_page.h"
> -#include "exec/cpu-defs.h"
> -#include "cpu.h"
> -#include "exec/cpu-all.h"
> -
> -size_t qemu_target_page_size(void)
> -{
> -    return TARGET_PAGE_SIZE;
> -}
> -
> -int qemu_target_page_mask(void)
> -{
> -    return TARGET_PAGE_MASK;
> -}
> -
> -int qemu_target_page_bits(void)
> -{
> -    return TARGET_PAGE_BITS;
> -}
>   
>   int qemu_target_page_bits_min(void)
>   {
> diff --git a/page-vary-target.c b/page-vary-target.c
> index 343b4adb95..1b4a9a10be 100644
> --- a/page-vary-target.c
> +++ b/page-vary-target.c
> @@ -37,5 +37,7 @@ void finalize_target_page_bits(void)
>   {
>   #ifdef TARGET_PAGE_BITS_VARY
>       finalize_target_page_bits_common(TARGET_PAGE_BITS_MIN);
> +#else
> +    finalize_target_page_bits_common(TARGET_PAGE_BITS);
>   #endif
>   }

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


