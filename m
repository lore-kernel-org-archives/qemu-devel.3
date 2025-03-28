Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73CB7C28B20
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 20:26:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyGHY-0007Mj-4y; Fri, 28 Mar 2025 16:26:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tyGH1-0007GP-98
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 16:25:53 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tyGGz-0002jG-Av
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 16:25:50 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ac25520a289so425229166b.3
 for <qemu-devel@nongnu.org>; Fri, 28 Mar 2025 13:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743193547; x=1743798347; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W8zVJDJxS7RMdKVdjGz+/CzKx3vpuLTSJoBgKMw6fEk=;
 b=Hu2HXCA3zH1LL+61tCAlDJC+xHeOnVwS2N0v8mN7U723KOfTZSVQaOJ/ob7kWDIHzx
 rYhCNaZBiTemLp/ERGvcbGfGtJn3ff2A68ZVxJPCiNXeisevjRHqRzya+H4T8y/kdBRu
 Ah5MtSdRNBW14WfKDU580bHTi6gWPLOCCIxlFjv5iI0KRAPJcTa3V37YGPDknGAT3uhT
 rajpJy1xxLm9vxoJM8QVaoon0YZCPRJ2qJiVb38JQ6gMUpjG9OM4uyLKfoFt/Z67CQbB
 NXFk/XyJo4f+4/6y4x1EwzsHwnHEW/9mT3V6fXSbe+lDh/tG4ifH3Q0AiMe/Ri3UGprv
 0fqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743193547; x=1743798347;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W8zVJDJxS7RMdKVdjGz+/CzKx3vpuLTSJoBgKMw6fEk=;
 b=inQbwtZfUOWZZdeYZytXev0+ik6IFxWrAP1/0I8z6at2ys7phJSwoI+w7vkgvhfGVm
 cuKRR2Nvv87b6T+nH0U7P5LGkHQbLdh52OO1mmNhZwml/zVxkaDFJ6pt/mhdLdoaDJ8O
 wzA1RpbTqESYOm6/4N6Yqk89eQF83iyDv6HhmtsrB6YBpGAcBbekQu5N5vCihswBIJse
 4VRJ4+KaU8hC5NTzLkTsLtbQmsRi00dK9w/APhAfNnJxTS3FevKhiKjzA3TXb8f5akVT
 J/wOUq5fpMd9Ms2gSx7DBvz8JmqE7uPfzQzLRPrvrXFDhPrhigF7dnwijLb8jBQrbx+3
 35CA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXX9VZs3TvZKAZmU0Cu8hGmSs6jc6/HvDtpLtyKgGCxH3tMGDOE39HVrMHmeTe3hQpXxxAyESyhPPmd@nongnu.org
X-Gm-Message-State: AOJu0Yxav7PokEOG3veH54R405CA9HHhtsDZrtTy4DMLfxFjCLNhW7bs
 PuPOgkmBzVpCnaoX9cbjmxPy5RXEOSse0YhaVH8xfHe5WMm7+FdST4PpyDWeQrU3nyGJLTIUosb
 xBkE=
X-Gm-Gg: ASbGncvvI0DI9xv9lgbUmFL/KI5Cz/9vk+q+01T2qiUfvsY7bnV6/k4OGZaiLNjfXf4
 s28vqmwsSwtGrIrnlzJVrtWve5+sE8tpIhjkwDT4QMncCSRnODuy977O2pQlLDJZCLNbGanW6Rt
 +1PFp32NIdVxO4zR4fGhApdz0gUIbkfs3QyOV/Td/a/BILqVNV7CK0vhOPev+/25mD50A4pGT1h
 2hxTAPHmTo9DnwPvygvLxmeEGP55khKvD9xISZYQHaqJuqrWutSNM1Whc6+4AEYsfCK/uQjBns6
 EJh/6A/QwqOOyVw+sfdbZRBvNs39fCvFRzZVa+RqGyCZy2MZnlyLBskewKA=
X-Google-Smtp-Source: AGHT+IHPakmQ1zZb0FKa5i3yt7o7c1+8lJvllfTHv3dpsCQSDxUKOnDaiW13DsuZaOeDyGu5Mp4mJQ==
X-Received: by 2002:a17:906:180f:b0:ac7:391a:e2d5 with SMTP id
 a640c23a62f3a-ac7391ae46bmr30953266b.60.1743193547446; 
 Fri, 28 Mar 2025 13:25:47 -0700 (PDT)
Received: from [10.154.28.14] ([193.32.126.156])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7196f7a6csm208318866b.176.2025.03.28.13.25.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Mar 2025 13:25:46 -0700 (PDT)
Message-ID: <b0706f97-f3c5-49e4-9009-c9248093c48b@linaro.org>
Date: Fri, 28 Mar 2025 13:25:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] accel/tcg: Split out tlb-bounds.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250328200459.483089-1-richard.henderson@linaro.org>
 <20250328200459.483089-7-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250328200459.483089-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-ej1-x62f.google.com
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

On 3/28/25 13:04, Richard Henderson wrote:
> The CPU_TLB_DYN_{MIN,MAX}_BITS definitions are not required
> outside of cputlb.c and translate-all.c.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/tb-internal.h   | 27 ---------------------------
>   accel/tcg/tlb-bounds.h    | 32 ++++++++++++++++++++++++++++++++
>   accel/tcg/cputlb.c        |  1 +
>   accel/tcg/translate-all.c |  1 +
>   4 files changed, 34 insertions(+), 27 deletions(-)
>   create mode 100644 accel/tcg/tlb-bounds.h
> 
> diff --git a/accel/tcg/tb-internal.h b/accel/tcg/tb-internal.h
> index f9a06bcbab..08538e2896 100644
> --- a/accel/tcg/tb-internal.h
> +++ b/accel/tcg/tb-internal.h
> @@ -22,33 +22,6 @@
>    */
>   #define GETPC_ADJ   2
>   
> -#ifdef CONFIG_SOFTMMU
> -
> -#define CPU_TLB_DYN_MIN_BITS 6
> -#define CPU_TLB_DYN_DEFAULT_BITS 8
> -
> -# if HOST_LONG_BITS == 32
> -/* Make sure we do not require a double-word shift for the TLB load */
> -#  define CPU_TLB_DYN_MAX_BITS (32 - TARGET_PAGE_BITS)
> -# else /* HOST_LONG_BITS == 64 */
> -/*
> - * Assuming TARGET_PAGE_BITS==12, with 2**22 entries we can cover 2**(22+12) ==
> - * 2**34 == 16G of address space. This is roughly what one would expect a
> - * TLB to cover in a modern (as of 2018) x86_64 CPU. For instance, Intel
> - * Skylake's Level-2 STLB has 16 1G entries.
> - * Also, make sure we do not size the TLB past the guest's address space.
> - */
> -#  ifdef TARGET_PAGE_BITS_VARY
> -#   define CPU_TLB_DYN_MAX_BITS                                  \
> -    MIN(22, TARGET_VIRT_ADDR_SPACE_BITS - TARGET_PAGE_BITS)
> -#  else
> -#   define CPU_TLB_DYN_MAX_BITS                                  \
> -    MIN_CONST(22, TARGET_VIRT_ADDR_SPACE_BITS - TARGET_PAGE_BITS)
> -#  endif
> -# endif
> -
> -#endif /* CONFIG_SOFTMMU */
> -
>   void tb_lock_page0(tb_page_addr_t);
>   
>   #ifdef CONFIG_USER_ONLY
> diff --git a/accel/tcg/tlb-bounds.h b/accel/tcg/tlb-bounds.h
> new file mode 100644
> index 0000000000..efd34d4793
> --- /dev/null
> +++ b/accel/tcg/tlb-bounds.h
> @@ -0,0 +1,32 @@
> +/*
> + * softmmu size bounds
> + * SPDX-License-Identifier: LGPL-2.1-or-later
> + */
> +
> +#ifndef ACCEL_TCG_TLB_BOUNDS_H
> +#define ACCEL_TCG_TLB_BOUNDS_H
> +
> +#define CPU_TLB_DYN_MIN_BITS 6
> +#define CPU_TLB_DYN_DEFAULT_BITS 8
> +
> +# if HOST_LONG_BITS == 32
> +/* Make sure we do not require a double-word shift for the TLB load */
> +#  define CPU_TLB_DYN_MAX_BITS (32 - TARGET_PAGE_BITS)
> +# else /* HOST_LONG_BITS == 64 */
> +/*
> + * Assuming TARGET_PAGE_BITS==12, with 2**22 entries we can cover 2**(22+12) ==
> + * 2**34 == 16G of address space. This is roughly what one would expect a
> + * TLB to cover in a modern (as of 2018) x86_64 CPU. For instance, Intel
> + * Skylake's Level-2 STLB has 16 1G entries.
> + * Also, make sure we do not size the TLB past the guest's address space.
> + */
> +#  ifdef TARGET_PAGE_BITS_VARY
> +#   define CPU_TLB_DYN_MAX_BITS                                  \
> +    MIN(22, TARGET_VIRT_ADDR_SPACE_BITS - TARGET_PAGE_BITS)
> +#  else
> +#   define CPU_TLB_DYN_MAX_BITS                                  \
> +    MIN_CONST(22, TARGET_VIRT_ADDR_SPACE_BITS - TARGET_PAGE_BITS)
> +#  endif
> +# endif
> +
> +#endif /* ACCEL_TCG_TLB_BOUNDS_H */
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 28c47d4872..a717f357d5 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -41,6 +41,7 @@
>   #include "trace.h"
>   #include "tb-hash.h"
>   #include "tb-internal.h"
> +#include "tlb-bounds.h"
>   #include "internal-common.h"
>   #include "internal-target.h"
>   #ifdef CONFIG_PLUGIN
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index bb161ae61a..87fb6c51d3 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -47,6 +47,7 @@
>   #include "exec/page-protection.h"
>   #include "exec/mmap-lock.h"
>   #include "tb-internal.h"
> +#include "tlb-bounds.h"
>   #include "exec/translator.h"
>   #include "exec/tb-flush.h"
>   #include "qemu/bitmap.h"

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


