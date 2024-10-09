Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B3F2CED611
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 23:06:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syfkJ-0005Xu-Cn; Wed, 09 Oct 2024 19:05:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1syfkH-0005XU-F5
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 19:05:29 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1syfk6-0000Fg-07
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 19:05:29 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-71e1ea994edso265955b3a.0
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 16:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728515116; x=1729119916; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7K53yX74ROpKB24ZPkFAVrgtQ2lKALmE+phOarFwK5E=;
 b=uFK0EenHsQxOL3MmDWgZZDWrK1PAqyVCIDwFq6LuF57PzfpTh4jEXqIb1wfiYIfrM/
 oYzy5VLKPLlvWnf51lbq/gA2WNFW3V0jS7uJNsh0uWHs4v/iZXYUjubgJdbDB8KJnjZt
 rNoxcq9JIvROG5hlkyOJOYpsQ0gMpW90XWr3Eqc06YHW8DeY/7NWt3S5RDFbcX+YZvJz
 0bbDRirLL3BrpTs0ECM6UHFcGIAQxvT1DyCkzqLUUnQGZFv0bHGqlmPbp0oEorbRqyqm
 a0EUYoq+zHrBTpCMkY1tL4C3CCN4ixjv4u7rNa2frF2gYmCU3uWj4oAMwUh8OaMYA4og
 6pQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728515116; x=1729119916;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7K53yX74ROpKB24ZPkFAVrgtQ2lKALmE+phOarFwK5E=;
 b=wE4DG4HTk96BV3NZk7+urTyjpygmDt4RHvyWPwa0pRhuh/lEOOkKO/jR/acX0KB3Td
 CdjXzjpqZyuXO7YoCYTP7dXxoyaEHxhp3iaK4iFP7WfWOASGiK65G+aY1zv/x/4+Ewui
 B6q9wx3xro1yPbVJ6ToFhhPCftDJJz7iE8t+WlQOYdHOObg+IjgLXQ0dqFmbdeikR2Jh
 fzuSPLAtYUK06j/B0U9Zjx80jo5FjJRxDVzxzUyUoMoFVnkyU1s1JzqogSStufei/8xM
 5Dpb3NuzF0x0/duoQaX8GXTWMqIKiZYgIuPqR2dA0Ube+1dav3qAKb5uG6YwVRD0V74o
 O6kA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYx6RB0fls7n1mYmOUOzzEXXWqN7KLGRMuYYtuIj0IJGtCCGpit15OYX2w6DgBSAJHyPBF/3zePnXe@nongnu.org
X-Gm-Message-State: AOJu0YyNOpSBb2estiUAWyOvCMChj4n1kdV6XHy1iS2Y1xGDRq3Y2Gwx
 v7SgbX8twMlZ97LhN6qnayW3dBy+8yoYeccj6I7hl9svXbnUnB6VYFAwlwXFkes=
X-Google-Smtp-Source: AGHT+IGFFqi8i45+cX+fkL54NVY6Y8pco+ssXXduZI5cssvjl8v29L8RdoWDiJCUVbTY/xr2v4xRRw==
X-Received: by 2002:a05:6a00:2d8f:b0:71e:69e:596a with SMTP id
 d2e1a72fcca58-71e1dbc766dmr6383919b3a.25.1728515115858; 
 Wed, 09 Oct 2024 16:05:15 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0d4665dsm8273594b3a.116.2024.10.09.16.05.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Oct 2024 16:05:15 -0700 (PDT)
Message-ID: <8bbac2bf-704a-4c4c-ae7a-996f5a04038f@linaro.org>
Date: Wed, 9 Oct 2024 16:05:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/23] accel/tcg: Split out tlbfast_flush_range_locked
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241009150855.804605-1-richard.henderson@linaro.org>
 <20241009150855.804605-5-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241009150855.804605-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
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

On 10/9/24 08:08, Richard Henderson wrote:
> While this may at present be overly complicated for use
> by single page flushes, do so with the expectation that
> this will eventually allow simplification of large pages.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cputlb.c | 61 +++++++++++++++++++++++++---------------------
>   1 file changed, 33 insertions(+), 28 deletions(-)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index e37af24525..6773874f2d 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -520,10 +520,37 @@ static inline void tlb_flush_vtlb_page_locked(CPUState *cpu, int mmu_idx,
>       tlb_flush_vtlb_page_mask_locked(cpu, mmu_idx, page, -1);
>   }
>   
> +static void tlbfast_flush_range_locked(CPUTLBDesc *desc, CPUTLBDescFast *fast,
> +                                       vaddr addr, vaddr len, vaddr mask)
> +{
> +    /*
> +     * If @mask is smaller than the tlb size, there may be multiple entries
> +     * within the TLB; for now, just flush the entire TLB.
> +     * Otherwise all addresses that match under @mask hit the same TLB entry.
> +     *
> +     * If @len is larger than the tlb size, then it will take longer to
> +     * test all of the entries in the TLB than it will to flush it all.
> +     */
> +    if (mask < fast->mask || len > fast->mask) {
> +        tlbfast_flush_locked(desc, fast);
> +        return;
> +    }
> +
> +    for (vaddr i = 0; i < len; i += TARGET_PAGE_SIZE) {
> +        vaddr page = addr + i;
> +        CPUTLBEntry *entry = tlbfast_entry(fast, page);
> +
> +        if (tlb_flush_entry_mask_locked(entry, page, mask)) {
> +            desc->n_used_entries--;
> +        }
> +    }
> +}
> +
>   static void tlb_flush_page_locked(CPUState *cpu, int midx, vaddr page)
>   {
> -    vaddr lp_addr = cpu->neg.tlb.d[midx].large_page_addr;
> -    vaddr lp_mask = cpu->neg.tlb.d[midx].large_page_mask;
> +    CPUTLBDesc *desc = &cpu->neg.tlb.d[midx];
> +    vaddr lp_addr = desc->large_page_addr;
> +    vaddr lp_mask = desc->large_page_mask;
>   
>       /* Check if we need to flush due to large pages.  */
>       if ((page & lp_mask) == lp_addr) {
> @@ -532,9 +559,8 @@ static void tlb_flush_page_locked(CPUState *cpu, int midx, vaddr page)
>                     midx, lp_addr, lp_mask);
>           tlb_flush_one_mmuidx_locked(cpu, midx, get_clock_realtime());
>       } else {
> -        if (tlb_flush_entry_locked(tlb_entry(cpu, midx, page), page)) {
> -            tlb_n_used_entries_dec(cpu, midx);
> -        }
> +        tlbfast_flush_range_locked(desc, &cpu->neg.tlb.f[midx],
> +                                   page, TARGET_PAGE_SIZE, -1);
>           tlb_flush_vtlb_page_locked(cpu, midx, page);
>       }
>   }
> @@ -689,24 +715,6 @@ static void tlb_flush_range_locked(CPUState *cpu, int midx,
>       CPUTLBDescFast *f = &cpu->neg.tlb.f[midx];
>       vaddr mask = MAKE_64BIT_MASK(0, bits);
>   
> -    /*
> -     * If @bits is smaller than the tlb size, there may be multiple entries
> -     * within the TLB; otherwise all addresses that match under @mask hit
> -     * the same TLB entry.
> -     * TODO: Perhaps allow bits to be a few bits less than the size.
> -     * For now, just flush the entire TLB.
> -     *
> -     * If @len is larger than the tlb size, then it will take longer to
> -     * test all of the entries in the TLB than it will to flush it all.
> -     */
> -    if (mask < f->mask || len > f->mask) {
> -        tlb_debug("forcing full flush midx %d ("
> -                  "%016" VADDR_PRIx "/%016" VADDR_PRIx "+%016" VADDR_PRIx ")\n",
> -                  midx, addr, mask, len);
> -        tlb_flush_one_mmuidx_locked(cpu, midx, get_clock_realtime());
> -        return;
> -    }
> -
>       /*
>        * Check if we need to flush due to large pages.
>        * Because large_page_mask contains all 1's from the msb,
> @@ -720,13 +728,10 @@ static void tlb_flush_range_locked(CPUState *cpu, int midx,
>           return;
>       }
>   
> +    tlbfast_flush_range_locked(d, f, addr, len, mask);
> +
>       for (vaddr i = 0; i < len; i += TARGET_PAGE_SIZE) {
>           vaddr page = addr + i;
> -        CPUTLBEntry *entry = tlb_entry(cpu, midx, page);
> -
> -        if (tlb_flush_entry_mask_locked(entry, page, mask)) {
> -            tlb_n_used_entries_dec(cpu, midx);
> -        }
>           tlb_flush_vtlb_page_mask_locked(cpu, midx, page, mask);
>       }
>   }

Why don't we have the same kind of change for 
tlb_flush_vtlb_page_mask_locked?

We know have two loops (for entry mask, and for page mask).

