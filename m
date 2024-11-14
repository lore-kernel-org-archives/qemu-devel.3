Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE376D6A226
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 18:59:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBf3H-00008s-Iv; Thu, 14 Nov 2024 13:58:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBf1u-00064K-0i
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:57:23 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBf1s-0000et-Ag
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:57:21 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2e91403950dso784507a91.3
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 10:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731610639; x=1732215439; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6YOZoaCYvf0qY4YxHZjVnj94gYZ4lMNH/ve3DujEf+g=;
 b=D9XIwMua3UP0TV3IbSLlTJXi9NuBNQ14YesSRU8MM277WdSev7rspjAjLOczB7IMl5
 mC52FLB7kPPz7hWOH4H+0zUlnVpJtpV2nNYMS39JxYl8+xi9VBelzKYVVBfrir1Nr8gG
 MTT40j7RcMgnosLyye0ANN/cQABqpSOXY0ZLM/e56o5bWzUnBfEx5uX0t5zvAz4LnQFv
 mwgu5dMWeP3Lza7CMs+08e3GRZzHvGDMc+cOeFYoKMgjfiveidDT4F1JffLwYE3qoXJc
 w6pLTkHyqhuoe/DSZRIgXR7Cpi9kgQejJSvXQxzMWUvbO/3InoRTOFa7IBKHhDnFnKTn
 y04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731610639; x=1732215439;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6YOZoaCYvf0qY4YxHZjVnj94gYZ4lMNH/ve3DujEf+g=;
 b=cIMvEoJCYbV+n2Yj/eY/w/OBUFc1MkE+8RXzUS6bV8QGOKFgmkDdtC5jKS+Ssg+d0p
 Z3/e8v6xTToFn5db2fA1zhwLZJ6cV+5Uvez0++It0YIP5oaiPgDhz7QNM6ifupst2uI1
 V5A+gZN/DiHKU6ZoAflRrRLRKwPDG+sb0RNtAUuhnLUyWNH6S2nE0Vhf+5sZhPONYxuR
 JoWXuTM3EMOSD+GyfJ8CtLynGRpWfchJzGJLD9tXqPiuvQWWFjtDJ2IDr32guqmuLjoi
 bgBOVpkWKyFAxot7d8J9Of7g9/oh7foVM0Iw7lxYmv6QzbgfzRx2RbCmWBSSv8qlnbrT
 pXrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdkhDQhCZ/WskTswTBqkZRq+wbtTZS9xM8LtIVn0SgDPOee92+FbJQhe48AmHw9Mtv5NDVtHWOEmCc@nongnu.org
X-Gm-Message-State: AOJu0YxhrLdNBZrEcwp+KFiNUw9H5yXLgcjWq8EFuIZ9jC4TaQBgrNTP
 CXsBQykwLFeDQP6m8y/SR4HXr+ggl+KPpyDwEgn9mK2aWmmfcT4YRsZzwlkYrzzEurWiTJQrBsc
 UkQeoww==
X-Google-Smtp-Source: AGHT+IEMY71hTTKOcq+HeXESNRiOYV7XXEA0KNDcMYLuBy76s/aMbWHdz2vInfKHZ6J2/ktUoyZhUg==
X-Received: by 2002:a17:90b:314a:b0:2e2:c406:ec8d with SMTP id
 98e67ed59e1d1-2e9b17962a1mr32904859a91.31.1731610638992; 
 Thu, 14 Nov 2024 10:57:18 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea024c0739sm1642008a91.37.2024.11.14.10.57.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 10:57:18 -0800 (PST)
Message-ID: <906235d3-167b-4cba-b054-6fbd294772f5@linaro.org>
Date: Thu, 14 Nov 2024 10:57:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 53/54] accel/tcg: Merge tlb_fill_align into callers
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241114160131.48616-1-richard.henderson@linaro.org>
 <20241114160131.48616-54-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114160131.48616-54-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1029.google.com
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

On 11/14/24 08:01, Richard Henderson wrote:
> In tlb_lookup, we still call tlb_set_page_full.
> In atomic_mmu_lookup, we're expecting noreturn.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cputlb.c | 31 ++++++-------------------------
>   1 file changed, 6 insertions(+), 25 deletions(-)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 3d731b8f3d..20af48c6c5 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1189,27 +1189,6 @@ static void tlb_set_page_full(CPUState *cpu, int mmu_idx,
>       qemu_spin_unlock(&tlb->c.lock);
>   }
>   
> -/*
> - * Note: tlb_fill_align() can trigger a resize of the TLB.
> - * This means that all of the caller's prior references to the TLB table
> - * (e.g. CPUTLBEntry pointers) must be discarded and looked up again
> - * (e.g. via tlb_entry()).
> - */
> -static bool tlb_fill_align(CPUState *cpu, vaddr addr, MMUAccessType type,
> -                           int mmu_idx, MemOp memop, int size,
> -                           bool probe, uintptr_t ra)
> -{
> -    CPUTLBEntryFull full;
> -
> -    if (cpu->cc->tcg_ops->tlb_fill_align(cpu, &full, addr, type, mmu_idx,
> -                                         memop, size, probe, ra)) {
> -        tlb_set_page_full(cpu, mmu_idx, addr, &full);
> -        return true;
> -    }
> -    assert(probe);
> -    return false;
> -}
> -
>   static inline void cpu_unaligned_access(CPUState *cpu, vaddr addr,
>                                           MMUAccessType access_type,
>                                           int mmu_idx, uintptr_t retaddr)
> @@ -1281,11 +1260,13 @@ static bool tlb_lookup(CPUState *cpu, TLBLookupOutput *o,
>       }
>   
>       /* Finally, query the target hook. */
> -    if (!tlb_fill_align(cpu, addr, access_type, i->mmu_idx,
> -                        memop, i->size, probe, i->ra)) {
> +    if (!cpu->cc->tcg_ops->tlb_fill_align(cpu, &o->full, addr, access_type,
> +                                          i->mmu_idx, memop, i->size,
> +                                          probe, i->ra)) {
>           tcg_debug_assert(probe);
>           return false;
>       }
> +    tlb_set_page_full(cpu, i->mmu_idx, addr, &o->full);
>       o->did_tlb_fill = true;
>   
>       if (access_type == MMU_INST_FETCH) {
> @@ -1794,8 +1775,8 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
>        * We have just verified that the page is writable.
>        */
>       if (unlikely(!(o.full.prot & PAGE_READ))) {
> -        tlb_fill_align(cpu, addr, MMU_DATA_LOAD, i.mmu_idx,
> -                       0, i.size, false, i.ra);
> +        cpu->cc->tcg_ops->tlb_fill_align(cpu, &o.full, addr, MMU_DATA_LOAD,
> +                                         i.mmu_idx, 0, i.size, false, i.ra);
>           /*
>            * Since we don't support reads and writes to different
>            * addresses, and we do have the proper page loaded for

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


