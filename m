Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20791D6A224
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 18:31:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBecU-0003VU-Sg; Thu, 14 Nov 2024 13:31:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBecT-0003Ql-8i
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:31:05 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBecR-0001PQ-F6
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:31:05 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-72041ff06a0so705503b3a.2
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 10:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731609062; x=1732213862; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yL71ZSjPjfQX1PHbtlmzcRG/djAdsJR2bY5b4QiKajY=;
 b=hoTeqiiAVHgR5NilmgcLGKAgX4X9s3bt7pMZt8b3L//x4seQ+4EfmBMLQN+WefKr5i
 B1WTbJfDXvcyShyH71HZZrwYjkn5Crif23VpGDfVdEpoJMdXQqjT7LROhLqfcze1V0VK
 8k9Jl6BAveS/HFkguopNZ2ZsmRAmGAChFkJAM4hpJsecKGvrKWJy2t7N9CGCmfPn3fwt
 yV8oRNuq/lN//WkixJRb/rKbDSkPYLDqWXA6FPvzaTBWWCG1MV6B4aPRsBNz5F95mDUY
 W4sik2qsap3ZxdVUO2qerTn37Ku4+QKHUGzdmBuUr0sBo2XC+c9InK+AxHaf0ErjUroh
 xgvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731609062; x=1732213862;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yL71ZSjPjfQX1PHbtlmzcRG/djAdsJR2bY5b4QiKajY=;
 b=kMx5oHDCrvPI7dxda4nHNUZ28zGBymbqaL0C7KCySvNjwRSho0N2kYABo8lHv+QVaQ
 fPQ6gWQdCrHUg051zp9EkBhbp/H3b6Y50AWn4C+MlC+dBQrRStmGX1+krl4feMCKBSoi
 4xBKxsgkHkXtv2qDtmBzYByJHTzkmqRgyIG1HTboj6keRccZnJWIQQuDeigHgdbYlAB/
 ZaZjCdBMiy3ElvDpJk+LWD1NDkwpOCQnqaCFS4S7jBY+RoN3BYcakqDlkxUjIZQbWQ6B
 qezM1FqCNWm2JIVYNWBkcefGzTULn8r6xzmb/t03+9Iii1MWR41PkDDPiUft3ke7ICdi
 zx0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpWQmwXQ34V2FVnBoEo0n6d3jPBFDAMreszgVyhZKYEUbSCfMdsBN+n/RVjnyRVzl+7voWt1C7G46A@nongnu.org
X-Gm-Message-State: AOJu0Yy83mL7iPa/rusfGmlochyAMSBXn9Eird+WcOHRc+6VbHXGMF5y
 bwPxSF0hO38nYS+5KDcjCI0vrDUshbOcXoVoOhO4hcsSNWmcoE+VDOCjpSEWtks=
X-Google-Smtp-Source: AGHT+IEngjwDq6GBSHsKu+zhuZa4b56r9XTyDU8Bfn/PawzKfsWAkt+bgspPZTSJ1O1qckdLn4ueFQ==
X-Received: by 2002:a05:6a00:a13:b0:71e:a3:935b with SMTP id
 d2e1a72fcca58-72469e28b41mr3521116b3a.25.1731609062135; 
 Thu, 14 Nov 2024 10:31:02 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7246a9ba511sm1604306b3a.147.2024.11.14.10.31.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 10:31:01 -0800 (PST)
Message-ID: <3432fbb5-c7b5-4ead-8ed0-b8ff61763345@linaro.org>
Date: Thu, 14 Nov 2024 10:31:01 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 30/54] accel/tcg: Merge mmu_lookup1 into mmu_lookup
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241114160131.48616-1-richard.henderson@linaro.org>
 <20241114160131.48616-31-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114160131.48616-31-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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
> Reuse most of TLBLookupInput between calls to tlb_lookup.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cputlb.c | 65 ++++++++++++++++++----------------------------
>   1 file changed, 25 insertions(+), 40 deletions(-)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 8f459be5a8..981098a6f2 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1695,34 +1695,6 @@ typedef struct MMULookupLocals {
>       int mmu_idx;
>   } MMULookupLocals;
>   
> -/**
> - * mmu_lookup1: translate one page
> - * @cpu: generic cpu state
> - * @data: lookup parameters
> - * @memop: memory operation for the access, or 0
> - * @mmu_idx: virtual address context
> - * @access_type: load/store/code
> - * @ra: return address into tcg generated code, or 0
> - *
> - * Resolve the translation for the one page at @data.addr, filling in
> - * the rest of @data with the results.  If the translation fails,
> - * tlb_fill_align will longjmp out.
> - */
> -static void mmu_lookup1(CPUState *cpu, MMULookupPageData *data, MemOp memop,
> -                        int mmu_idx, MMUAccessType access_type, uintptr_t ra)
> -{
> -    TLBLookupInput i = {
> -        .addr = data->addr,
> -        .ra = ra,
> -        .access_type = access_type,
> -        .memop_probe = memop,
> -        .size = data->size,
> -        .mmu_idx = mmu_idx,
> -    };
> -
> -    tlb_lookup_nofail(cpu, &data->o, &i);
> -}
> -
>   /**
>    * mmu_watch_or_dirty
>    * @cpu: generic cpu state
> @@ -1769,26 +1741,36 @@ static void mmu_watch_or_dirty(CPUState *cpu, MMULookupPageData *data,
>   static bool mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
>                          uintptr_t ra, MMUAccessType type, MMULookupLocals *l)
>   {
> +    MemOp memop = get_memop(oi);
> +    int mmu_idx = get_mmuidx(oi);
> +    TLBLookupInput i = {
> +        .addr = addr,
> +        .ra = ra,
> +        .access_type = type,
> +        .memop_probe = memop,
> +        .size = memop_size(memop),
> +        .mmu_idx = mmu_idx,
> +    };
>       bool crosspage;
>       int flags;
>   
> -    l->memop = get_memop(oi);
> -    l->mmu_idx = get_mmuidx(oi);
> +    l->memop = memop;
> +    l->mmu_idx = mmu_idx;
>   
> -    tcg_debug_assert(l->mmu_idx < NB_MMU_MODES);
> +    tcg_debug_assert(mmu_idx < NB_MMU_MODES);
>   
>       l->page[0].addr = addr;
> -    l->page[0].size = memop_size(l->memop);
> -    l->page[1].addr = (addr + l->page[0].size - 1) & TARGET_PAGE_MASK;
> +    l->page[0].size = i.size;
> +    l->page[1].addr = (addr + i.size - 1) & TARGET_PAGE_MASK;
>       l->page[1].size = 0;
>       crosspage = (addr ^ l->page[1].addr) & TARGET_PAGE_MASK;
>   
>       if (likely(!crosspage)) {
> -        mmu_lookup1(cpu, &l->page[0], l->memop, l->mmu_idx, type, ra);
> +        tlb_lookup_nofail(cpu, &l->page[0].o, &i);
>   
>           flags = l->page[0].o.flags;
>           if (unlikely(flags & (TLB_WATCHPOINT | TLB_NOTDIRTY))) {
> -            mmu_watch_or_dirty(cpu, &l->page[0], type, ra);
> +            mmu_watch_or_dirty(cpu, &l->page[0], i.access_type, i.ra);
>           }
>           if (unlikely(flags & TLB_BSWAP)) {
>               l->memop ^= MO_BSWAP;
> @@ -1796,17 +1778,20 @@ static bool mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
>       } else {
>           /* Finish compute of page crossing. */
>           int size0 = l->page[1].addr - addr;
> -        l->page[1].size = l->page[0].size - size0;
> +        l->page[1].size = i.size - size0;
>           l->page[0].size = size0;
>   
>           /* Lookup both pages, recognizing exceptions from either. */
> -        mmu_lookup1(cpu, &l->page[0], l->memop, l->mmu_idx, type, ra);
> -        mmu_lookup1(cpu, &l->page[1], 0, l->mmu_idx, type, ra);
> +        i.size = size0;
> +        tlb_lookup_nofail(cpu, &l->page[0].o, &i);
> +        i.addr = l->page[1].addr;
> +        i.size = l->page[1].size;
> +        tlb_lookup_nofail(cpu, &l->page[1].o, &i);
>   
>           flags = l->page[0].o.flags | l->page[1].o.flags;
>           if (unlikely(flags & (TLB_WATCHPOINT | TLB_NOTDIRTY))) {
> -            mmu_watch_or_dirty(cpu, &l->page[0], type, ra);
> -            mmu_watch_or_dirty(cpu, &l->page[1], type, ra);
> +            mmu_watch_or_dirty(cpu, &l->page[0], i.access_type, i.ra);
> +            mmu_watch_or_dirty(cpu, &l->page[1], i.access_type, i.ra);
>           }
>   
>           /*

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


