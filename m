Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7652EC4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Apr 2024 16:34:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rya8q-0005OB-FE; Sun, 21 Apr 2024 12:34:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rya8n-0005Nt-TX
 for qemu-devel@nongnu.org; Sun, 21 Apr 2024 12:34:09 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rya8k-0000A3-JQ
 for qemu-devel@nongnu.org; Sun, 21 Apr 2024 12:34:08 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1e4c4fb6af3so23922685ad.0
 for <qemu-devel@nongnu.org>; Sun, 21 Apr 2024 09:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713717244; x=1714322044; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6xVbTPnDoAV5gEk31Pa140L8Q1vO5PkKhqRIznBexlc=;
 b=itknpTettY3G7jLMpVbV9r3u3WDi8UK9O85Fw3jTMEvnalmoQcTzs+E9ikNlit0P8b
 oh2nkLsgkP9oL4zXArtBqA4MzvNCafeVF43847HAAMQthouO3vLdDqc+CJA/sa7ZzrBY
 B1hgrHwtoiO7wz4TRsvGdqz/wf2M8pjp5FABlztGy28l2Qz/cID10y0TfUdKJHS0MjVe
 9bkXpX9pE2cvZfk58EK7da9oMxkgpQCIRJS9b+lTL96tSXRDr4L3Eplni0AUTQqT7Kns
 VY7fwssjEI9KPxcHP60uwXEaUvMwbxTXABYwq7G+RP7heGtXuzs69EA9a3fAOMOE159T
 Pn5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713717244; x=1714322044;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6xVbTPnDoAV5gEk31Pa140L8Q1vO5PkKhqRIznBexlc=;
 b=UZJyZebHVD5snztzabKJPRIuLA2oImSyWc9v7QdEOqd/26huqsCGSOgYBhkHwfptcx
 rAsTrl5B9dX++KgdqfqufT3NmqNXzvO5VqroAUOOT7J0YbnDYHo40Gc63ZTUO5KaZyta
 pg9euHmArm0B1OrEbxGUdHGMCVOYIf9NXi45k32/7RtgjAahnq9tlJxxLyqWiLhZyoqI
 QL/CXvUYWcqDK89jkN7KxOZpMBQJlbMRYR1KKsR/XEhyoPL/OCIHXTlkGuMgCEkcsPhG
 ZNVSdg660F6weDrE0fMQQBFksfOo2ZHMOAKl1VzRt9LeDXW3H3BQT3Q3Pp+/06C1YT1j
 EbwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrmCIjhzvlX2oEpJ7cGIvddV9wGmvOxacGsyv/CPT3/GIJD71ic454/huPsWk8u9h1oCoPVQ+JiLT6Iksk3LiUGtEDsKI=
X-Gm-Message-State: AOJu0YybR5pUUhm7DYxQjcsP0fzGNUOgPDzmiD1BZIYn95lkBwdXWOMT
 0NzMWBwiDBbY1fL9Kdl9/GqYFfJbyjTj+SMtRx640zO2cT1oB0wS3XOufrqj0NgXwBbakRWShDs
 x
X-Google-Smtp-Source: AGHT+IFFj/Fx5A0s2gU9sNEvpslXrPfF590bAEAu0fnXGaJxXO7zJ7sUiLq7GZpm187cbgCNPkudWQ==
X-Received: by 2002:a17:902:c945:b0:1e7:b6f4:2d77 with SMTP id
 i5-20020a170902c94500b001e7b6f42d77mr11163373pla.22.1713717243727; 
 Sun, 21 Apr 2024 09:34:03 -0700 (PDT)
Received: from [192.168.91.227] ([156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 ki14-20020a170903068e00b001e434923462sm6522732plb.50.2024.04.21.09.34.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 Apr 2024 09:34:03 -0700 (PDT)
Message-ID: <653965ac-574c-46be-9eb3-94e0b79530b8@linaro.org>
Date: Sun, 21 Apr 2024 09:33:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/24] exec: Un-inline tlb_vaddr_to_host() and declare it
 in 'exec/cputlb.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240418192525.97451-1-philmd@linaro.org>
 <20240418192525.97451-8-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240418192525.97451-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 4/18/24 12:25, Philippe Mathieu-Daudé wrote:
> Declare tlb_vaddr_to_host() in "exec/cputlb.h" with the CPU TLB
> API. Un-inline the user emulation definition to avoid including
> "exec/cpu_ldst.h" (which declares g2h) in "exec/cputlb.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/exec/cpu_ldst.h      | 24 ------------------------
>   include/exec/cputlb.h        | 18 ++++++++++++++++++
>   accel/tcg/user-exec.c        |  7 +++++++
>   target/arm/tcg/helper-a64.c  |  1 +
>   target/riscv/vector_helper.c |  1 +
>   target/sparc/mmu_helper.c    |  1 +
>   6 files changed, 28 insertions(+), 24 deletions(-)
> 
> diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
> index 63186b07e4..7032949dba 100644
> --- a/include/exec/cpu_ldst.h
> +++ b/include/exec/cpu_ldst.h
> @@ -418,28 +418,4 @@ static inline int cpu_ldsw_code(CPUArchState *env, abi_ptr addr)
>       return (int16_t)cpu_lduw_code(env, addr);
>   }
>   
> -/**
> - * tlb_vaddr_to_host:
> - * @env: CPUArchState
> - * @addr: guest virtual address to look up
> - * @access_type: 0 for read, 1 for write, 2 for execute
> - * @mmu_idx: MMU index to use for lookup
> - *
> - * Look up the specified guest virtual index in the TCG softmmu TLB.
> - * If we can translate a host virtual address suitable for direct RAM
> - * access, without causing a guest exception, then return it.
> - * Otherwise (TLB entry is for an I/O access, guest software
> - * TLB fill required, etc) return NULL.
> - */
> -#ifdef CONFIG_USER_ONLY
> -static inline void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr addr,
> -                                      MMUAccessType access_type, int mmu_idx)
> -{
> -    return g2h(env_cpu(env), addr);
> -}
> -#else
> -void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr addr,
> -                        MMUAccessType access_type, int mmu_idx);
> -#endif
> -
>   #endif /* CPU_LDST_H */
> diff --git a/include/exec/cputlb.h b/include/exec/cputlb.h
> index ef18642a32..173eb98b9a 100644
> --- a/include/exec/cputlb.h
> +++ b/include/exec/cputlb.h
> @@ -20,10 +20,28 @@
>   #ifndef CPUTLB_H
>   #define CPUTLB_H
>   
> +#include "exec/abi_ptr.h"
>   #include "exec/cpu-common.h"
> +#include "exec/mmu-access-type.h"
>   
>   #ifdef CONFIG_TCG
>   
> +/**
> + * tlb_vaddr_to_host:
> + * @env: CPUArchState
> + * @addr: guest virtual address to look up
> + * @access_type: 0 for read, 1 for write, 2 for execute
> + * @mmu_idx: MMU index to use for lookup
> + *
> + * Look up the specified guest virtual index in the TCG softmmu TLB.
> + * If we can translate a host virtual address suitable for direct RAM
> + * access, without causing a guest exception, then return it.
> + * Otherwise (TLB entry is for an I/O access, guest software
> + * TLB fill required, etc) return NULL.
> + */
> +void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr addr,
> +                        MMUAccessType access_type, int mmu_idx);
> +

Why have you chosen cputlb.h, when the other probe functions are in exec-all.h?

Alternately, we only have two users remaining, which could be migrated to the newer 
interfaces...


r~

