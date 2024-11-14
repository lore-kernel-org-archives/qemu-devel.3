Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2FBED6A226
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 18:50:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBeug-0006Es-58; Thu, 14 Nov 2024 13:49:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBeuf-0006Ei-0b
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:49:53 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBeud-0006km-2T
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:49:52 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-20e6981ca77so12177405ad.2
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 10:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731610189; x=1732214989; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Zmq7vzIm/HC+LuJD7ybvhlyPB5WkgMpCIfu/FrdCS+0=;
 b=Mr3/Jv+YJsFhQi4yfNvFt7CpYVyuKMc1ZDPw/kehlnnqqova+U74SJUKuQDsJB6h2O
 8AJpgRBYe56p6tLq33VmYbfWZeB7EqwUnTJnSeGONNXNICX1OmHfNvkh5AmKPAmIWy/M
 gBX+q/Y/988Qgj0xbZb7g6HHCROF4mrcnj+qP/W3P6RfOubdJ/zaKWGsAFQ87U55jAEB
 OmR0YknwXuJWr37TAzsPsSEA9tDkT66STl5ojnn+ML9VfdV7NhqQHnmiVme/MYu1q+Va
 t9AIMjxyX4EITCAcZwt9Yqz/5dNOczzgW0TaWU+8cut4crhMIzzH3/LvFodkdCdbmzN/
 bR4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731610189; x=1732214989;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Zmq7vzIm/HC+LuJD7ybvhlyPB5WkgMpCIfu/FrdCS+0=;
 b=fnsFMou9ARwiUUmmPBqNkThNQj2n7ASuKvFL2PrFpJn4smBWeak14sQk7ozXPS9iYV
 Ym8a+1HlIbsUBo8by+yQfU4Hoc8lhPEeQvrLlS4bnosZ+INKwRlaXKoNQ1bYJL9bKIqg
 uTkadi5trI3f9BinlfQBs0j9Sg3//rJjNKz9DKIZ8fc+rwo04RhDWDsqXkq7vyyMKoON
 zrIbHTtHHkpkubUm/2iwg50eeaxFYn/ogUYoNdwekXf+HtRQNZG1x9IphygQmhz3fkzs
 CEMA+Nw2kuopLr5qZ7gOrCOoiQOhUwETGv4B0cDO70FhEeAa/fUsZahWIqefhfW3+juG
 KcUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1i51C8IHDBns+kWpefFsrr2N0vZh/ALaysVtCh2zetbX6SU6U7gnuduJ6IGMmHecmh79z8AkrMnsK@nongnu.org
X-Gm-Message-State: AOJu0YwZDhk0RbaGlBsh8dDBFZhp/H/1ibSN+bc9IvpNW1SBvIUtIARt
 NlCGkN7ATW4lu3nZ3izqd9RQr2vZo9NL0DsmGYrNZdv2TJOJCoivftzdEcfL/cE=
X-Google-Smtp-Source: AGHT+IEgcjomS0WCoHN9AdVqaZQzNHsGwbMufAqQy59bVeEaDcwVmfhVNSj2hg4OumjIZKwxOKkTYg==
X-Received: by 2002:a17:903:1248:b0:211:ebd:e35f with SMTP id
 d9443c01a7336-211b5d28d67mr102231815ad.39.1731610189047; 
 Thu, 14 Nov 2024 10:49:49 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211c7d0175asm13924825ad.178.2024.11.14.10.49.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 10:49:48 -0800 (PST)
Message-ID: <057e02e0-eb01-43b2-b48c-602bb84d0989@linaro.org>
Date: Thu, 14 Nov 2024 10:49:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 33/54] accel/tcg: Remove CPUTLBDesc.fulltlb
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241114160131.48616-1-richard.henderson@linaro.org>
 <20241114160131.48616-34-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114160131.48616-34-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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
> This array is now write-only, and may be removed.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/hw/core/cpu.h |  1 -
>   accel/tcg/cputlb.c    | 34 +++++++---------------------------
>   2 files changed, 7 insertions(+), 28 deletions(-)
> 
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 4364ddb1db..5c069f2a00 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -219,7 +219,6 @@ typedef struct CPUTLBDesc {
>       /* maximum number of entries observed in the window */
>       size_t window_max_entries;
>       size_t n_used_entries;
> -    CPUTLBEntryFull *fulltlb;
>       /* All active tlb entries for this address space. */
>       IntervalTreeRoot iroot;
>   } CPUTLBDesc;
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 3282436752..7f63dc3fd8 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -149,13 +149,6 @@ static inline CPUTLBEntry *tlbfast_entry(CPUTLBDescFast *fast, vaddr addr)
>       return fast->table + tlbfast_index(fast, addr);
>   }
>   
> -/* Find the TLB index corresponding to the mmu_idx + address pair.  */
> -static inline uintptr_t tlb_index(CPUState *cpu, uintptr_t mmu_idx,
> -                                  vaddr addr)
> -{
> -    return tlbfast_index(&cpu->neg.tlb.f[mmu_idx], addr);
> -}
> -
>   /* Find the TLB entry corresponding to the mmu_idx + address pair.  */
>   static inline CPUTLBEntry *tlb_entry(CPUState *cpu, uintptr_t mmu_idx,
>                                        vaddr addr)
> @@ -270,22 +263,20 @@ static void tlb_mmu_resize_locked(CPUTLBDesc *desc, CPUTLBDescFast *fast,
>       }
>   
>       g_free(fast->table);
> -    g_free(desc->fulltlb);
>   
>       tlb_window_reset(desc, now, 0);
>       /* desc->n_used_entries is cleared by the caller */
>       fast->mask = (new_size - 1) << CPU_TLB_ENTRY_BITS;
>       fast->table = g_try_new(CPUTLBEntry, new_size);
> -    desc->fulltlb = g_try_new(CPUTLBEntryFull, new_size);
>   
>       /*
> -     * If the allocations fail, try smaller sizes. We just freed some
> +     * If the allocation fails, try smaller sizes. We just freed some
>        * memory, so going back to half of new_size has a good chance of working.
>        * Increased memory pressure elsewhere in the system might cause the
>        * allocations to fail though, so we progressively reduce the allocation
>        * size, aborting if we cannot even allocate the smallest TLB we support.
>        */
> -    while (fast->table == NULL || desc->fulltlb == NULL) {
> +    while (fast->table == NULL) {
>           if (new_size == (1 << CPU_TLB_DYN_MIN_BITS)) {
>               error_report("%s: %s", __func__, strerror(errno));
>               abort();
> @@ -294,9 +285,7 @@ static void tlb_mmu_resize_locked(CPUTLBDesc *desc, CPUTLBDescFast *fast,
>           fast->mask = (new_size - 1) << CPU_TLB_ENTRY_BITS;
>   
>           g_free(fast->table);
> -        g_free(desc->fulltlb);
>           fast->table = g_try_new(CPUTLBEntry, new_size);
> -        desc->fulltlb = g_try_new(CPUTLBEntryFull, new_size);
>       }
>   }
>   
> @@ -350,7 +339,6 @@ static void tlb_mmu_init(CPUTLBDesc *desc, CPUTLBDescFast *fast, int64_t now)
>       desc->n_used_entries = 0;
>       fast->mask = (n_entries - 1) << CPU_TLB_ENTRY_BITS;
>       fast->table = g_new(CPUTLBEntry, n_entries);
> -    desc->fulltlb = g_new(CPUTLBEntryFull, n_entries);
>       memset(&desc->iroot, 0, sizeof(desc->iroot));
>       tlb_mmu_flush_locked(desc, fast);
>   }
> @@ -372,15 +360,9 @@ void tlb_init(CPUState *cpu)
>   
>   void tlb_destroy(CPUState *cpu)
>   {
> -    int i;
> -
>       qemu_spin_destroy(&cpu->neg.tlb.c.lock);
> -    for (i = 0; i < NB_MMU_MODES; i++) {
> -        CPUTLBDesc *desc = &cpu->neg.tlb.d[i];
> -        CPUTLBDescFast *fast = &cpu->neg.tlb.f[i];
> -
> -        g_free(fast->table);
> -        g_free(desc->fulltlb);
> +    for (int i = 0; i < NB_MMU_MODES; i++) {
> +        g_free(cpu->neg.tlb.f[i].table);
>           interval_tree_free_nodes(&cpu->neg.tlb.d[i].iroot,
>                                    offsetof(CPUTLBEntryTree, itree));
>       }
> @@ -1061,7 +1043,7 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
>       CPUTLB *tlb = &cpu->neg.tlb;
>       CPUTLBDesc *desc = &tlb->d[mmu_idx];
>       MemoryRegionSection *section;
> -    unsigned int index, read_flags, write_flags;
> +    unsigned int read_flags, write_flags;
>       uintptr_t addend;
>       CPUTLBEntry *te;
>       CPUTLBEntryTree *node;
> @@ -1140,7 +1122,6 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
>       wp_flags = cpu_watchpoint_address_matches(cpu, addr_page,
>                                                 TARGET_PAGE_SIZE);
>   
> -    index = tlb_index(cpu, mmu_idx, addr_page);
>       te = tlb_entry(cpu, mmu_idx, addr_page);
>   
>       /*
> @@ -1179,8 +1160,8 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
>        * subtract here is that of the page base, and not the same as the
>        * vaddr we add back in io_prepare()/get_page_addr_code().
>        */
> -    desc->fulltlb[index] = *full;
> -    full = &desc->fulltlb[index];
> +    node->full = *full;
> +    full = &node->full;
>       full->xlat_section = iotlb - addr_page;
>       full->phys_addr = paddr_page;
>   
> @@ -1203,7 +1184,6 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
>       tlb_set_compare(full, &node->copy, addr_page, write_flags,
>                       MMU_DATA_STORE, prot & PAGE_WRITE);
>   
> -    node->full = *full;
>       copy_tlb_helper_locked(te, &node->copy);
>       desc->n_used_entries++;
>       qemu_spin_unlock(&tlb->c.lock);

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


