Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C2E3D6A224
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 18:33:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBeeI-0005Cp-1Z; Thu, 14 Nov 2024 13:32:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBeeG-0005A6-HX
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:32:56 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBeeE-0001ue-Fj
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:32:56 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-7f8b37edeb7so805771a12.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 10:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731609173; x=1732213973; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LCqRro3ta5gxij3xvjRkAqVZCClwASQ/5fCiXQPHg8s=;
 b=RzoyeU42tRF0C/l3gNx07h+32iWQm4jUTGKobnh2md9si/tg06gWPtZpG4EB/uqdl1
 LpU7vYjpIkT0RkV/xw6gNMVNSWCnIuMjwEGIQDwVyZmCQd2ivzph9nmFOzp6Sz/x97Fy
 kf0YkM64dP48m+pwuv5Pdb2w53nWAH0pdEeqmQyNJeu6g4t9Ce99uhvNpf67ai33X49l
 PqGMChL8+bH68Gjn/hPlbEIbEkhinGUsZocWzWVF8JyJNTvTvnMFRrZf2Z/mQzHoCUVj
 7nEc/NzFkvuXvUXlRg86GQNM2Hd28b4jb++LZy1fgnrHGPrvG4tb3r6ywA1Y7p0plDIa
 D6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731609173; x=1732213973;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LCqRro3ta5gxij3xvjRkAqVZCClwASQ/5fCiXQPHg8s=;
 b=rf05TQZEzT+3/mZxiY/3K+89oweAvlHt0Me3Jlf1kzWKGv6JaK7qo7oxlz9QGq8k0l
 3ThjSI7Zyy/BbiHKIWf6xdDBIDfkpf/FNwYLDbYQhd9Pckx31hCoAy7x+ZYhY1o9MJbt
 HpttA60z2jpdXitWp6vDYKPoWYfhY7uWAI3tLTriwET0q3cZdQUQtuFg2FQOsllh6Otn
 aTljOWh9it0QfqVGTnNrJk0GdSsBujXVYF7iYsxBfL5xxdKgZj65UFQfuXk3/BPyAlxa
 ImkBXccWRMwjRkP0JgYP5U4Pi+jqaM6Ss+lCMu0utWV9g0goqjvEzCBCWhW0trXvxzxQ
 QC4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU51tXhr05ui79IBTCMt3JfHUp+iKHGT4VglmxNa38efj5lcUS4Bj+o81aEne6efi07wxIQ1G1tf9k+@nongnu.org
X-Gm-Message-State: AOJu0YxUcPglMhy85rsVjNsHyFrO/bAl/Bgwt4SYAP2JBz62WfOuPpRQ
 hNtqEKMlo7ZChY5pIuZomtNz3b+lB8jKmgyvErAKFGfyryVFo2u4Qj+C3wlTXuE=
X-Google-Smtp-Source: AGHT+IF1XVw7UQ+8upvbOhYql61I58HJNLYXljP2ICajEtgXkMQdp17H6zTBZY/9UG/czHoVNNS1Mw==
X-Received: by 2002:a05:6a20:8412:b0:1d9:386d:9441 with SMTP id
 adf61e73a8af0-1dc5f8eb321mr14826134637.10.1731609173004; 
 Thu, 14 Nov 2024 10:32:53 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7f8b39f226bsm1413176a12.86.2024.11.14.10.32.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 10:32:52 -0800 (PST)
Message-ID: <9bb054fd-40c6-4c44-aa02-52deba8bbc51@linaro.org>
Date: Thu, 14 Nov 2024 10:32:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 31/54] accel/tcg: Always use IntervalTree for code
 lookups
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241114160131.48616-1-richard.henderson@linaro.org>
 <20241114160131.48616-32-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114160131.48616-32-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x536.google.com
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
> Because translation is special, we don't need the speed
> of the direct-mapped softmmu tlb.  We cache a lookups in
> DisasContextBase within the translator loop anyway.
> 
> Drop the addr_code comparator from CPUTLBEntry.
> Go directly to the IntervalTree for MMU_INST_FETCH.
> Derive exec flags from read flags.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/cpu-all.h    |  3 ++
>   include/exec/tlb-common.h |  5 ++-
>   accel/tcg/cputlb.c        | 76 ++++++++++++++++++++++++---------------
>   3 files changed, 52 insertions(+), 32 deletions(-)
> 
> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
> index 45e6676938..ad160c328a 100644
> --- a/include/exec/cpu-all.h
> +++ b/include/exec/cpu-all.h
> @@ -339,6 +339,9 @@ static inline int cpu_mmu_index(CPUState *cs, bool ifetch)
>       (TLB_INVALID_MASK | TLB_NOTDIRTY | TLB_MMIO \
>       | TLB_FORCE_SLOW | TLB_DISCARD_WRITE)
>   
> +/* Filter read flags to exec flags. */
> +#define TLB_EXEC_FLAGS_MASK  (TLB_MMIO)
> +
>   /*
>    * Flags stored in CPUTLBEntryFull.slow_flags[x].
>    * TLB_FORCE_SLOW must be set in CPUTLBEntry.addr_idx[x].
> diff --git a/include/exec/tlb-common.h b/include/exec/tlb-common.h
> index 300f9fae67..feaa471299 100644
> --- a/include/exec/tlb-common.h
> +++ b/include/exec/tlb-common.h
> @@ -26,7 +26,6 @@ typedef union CPUTLBEntry {
>       struct {
>           uint64_t addr_read;
>           uint64_t addr_write;
> -        uint64_t addr_code;
>           /*
>            * Addend to virtual address to get host address.  IO accesses
>            * use the corresponding iotlb value.
> @@ -35,7 +34,7 @@ typedef union CPUTLBEntry {
>       };
>       /*
>        * Padding to get a power of two size, as well as index
> -     * access to addr_{read,write,code}.
> +     * access to addr_{read,write}.
>        */
>       uint64_t addr_idx[(1 << CPU_TLB_ENTRY_BITS) / sizeof(uint64_t)];
>   } CPUTLBEntry;
> @@ -92,7 +91,7 @@ struct CPUTLBEntryFull {
>        * Additional tlb flags for use by the slow path. If non-zero,
>        * the corresponding CPUTLBEntry comparator must have TLB_FORCE_SLOW.
>        */
> -    uint8_t slow_flags[MMU_ACCESS_COUNT];
> +    uint8_t slow_flags[2];
>   
>       /*
>        * Allow target-specific additions to this structure.
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 981098a6f2..be2ea1bc70 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -114,8 +114,9 @@ static inline uint64_t tlb_read_idx(const CPUTLBEntry *entry,
>                         MMU_DATA_LOAD * sizeof(uint64_t));
>       QEMU_BUILD_BUG_ON(offsetof(CPUTLBEntry, addr_write) !=
>                         MMU_DATA_STORE * sizeof(uint64_t));
> -    QEMU_BUILD_BUG_ON(offsetof(CPUTLBEntry, addr_code) !=
> -                      MMU_INST_FETCH * sizeof(uint64_t));
> +
> +    tcg_debug_assert(access_type == MMU_DATA_LOAD ||
> +                     access_type == MMU_DATA_STORE);
>   
>   #if TARGET_LONG_BITS == 32
>       /* Use qatomic_read, in case of addr_write; only care about low bits. */
> @@ -480,8 +481,7 @@ static bool tlb_hit_page_mask_anyprot(CPUTLBEntry *tlb_entry,
>       mask &= TARGET_PAGE_MASK | TLB_INVALID_MASK;
>   
>       return (page == (tlb_entry->addr_read & mask) ||
> -            page == (tlb_addr_write(tlb_entry) & mask) ||
> -            page == (tlb_entry->addr_code & mask));
> +            page == (tlb_addr_write(tlb_entry) & mask));
>   }
>   
>   /* Called with tlb_c.lock held */
> @@ -1184,9 +1184,6 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
>       /* Now calculate the new entry */
>       node->copy.addend = addend - addr_page;
>   
> -    tlb_set_compare(full, &node->copy, addr_page, read_flags,
> -                    MMU_INST_FETCH, prot & PAGE_EXEC);
> -
>       if (wp_flags & BP_MEM_READ) {
>           read_flags |= TLB_WATCHPOINT;
>       }
> @@ -1308,22 +1305,30 @@ static bool tlb_lookup(CPUState *cpu, TLBLookupOutput *o,
>       /* Primary lookup in the fast tlb. */
>       entry = tlbfast_entry(fast, addr);
>       full = &desc->fulltlb[tlbfast_index(fast, addr)];
> -    cmp = tlb_read_idx(entry, access_type);
> -    if (tlb_hit(cmp, addr)) {
> -        goto found;
> +    if (access_type != MMU_INST_FETCH) {
> +        cmp = tlb_read_idx(entry, access_type);
> +        if (tlb_hit(cmp, addr)) {
> +            goto found_data;
> +        }
>       }
>   
>       /* Secondary lookup in the IntervalTree. */
>       node = tlbtree_lookup_addr(desc, addr);
>       if (node) {
> -        cmp = tlb_read_idx(&node->copy, access_type);
> -        if (tlb_hit(cmp, addr)) {
> -            /* Install the cached entry. */
> -            qemu_spin_lock(&cpu->neg.tlb.c.lock);
> -            copy_tlb_helper_locked(entry, &node->copy);
> -            qemu_spin_unlock(&cpu->neg.tlb.c.lock);
> -            *full = node->full;
> -            goto found;
> +        if (access_type == MMU_INST_FETCH) {
> +            if (node->full.prot & PAGE_EXEC) {
> +                goto found_code;
> +            }
> +        } else {
> +            cmp = tlb_read_idx(&node->copy, access_type);
> +            if (tlb_hit(cmp, addr)) {
> +                /* Install the cached entry. */
> +                qemu_spin_lock(&cpu->neg.tlb.c.lock);
> +                copy_tlb_helper_locked(entry, &node->copy);
> +                qemu_spin_unlock(&cpu->neg.tlb.c.lock);
> +                *full = node->full;
> +                goto found_data;
> +            }
>           }
>       }
>   
> @@ -1333,9 +1338,14 @@ static bool tlb_lookup(CPUState *cpu, TLBLookupOutput *o,
>           tcg_debug_assert(probe);
>           return false;
>       }
> -
>       o->did_tlb_fill = true;
>   
> +    if (access_type == MMU_INST_FETCH) {
> +        node = tlbtree_lookup_addr(desc, addr);
> +        tcg_debug_assert(node);
> +        goto found_code;
> +    }
> +
>       entry = tlbfast_entry(fast, addr);
>       full = &desc->fulltlb[tlbfast_index(fast, addr)];
>       cmp = tlb_read_idx(entry, access_type);
> @@ -1345,14 +1355,29 @@ static bool tlb_lookup(CPUState *cpu, TLBLookupOutput *o,
>        * called tlb_fill_align, so we know that this entry *is* valid.
>        */
>       flags &= ~TLB_INVALID_MASK;
> +    goto found_data;
> +
> + found_data:
> +    flags &= cmp;
> +    flags |= full->slow_flags[access_type];
> +    o->flags = flags;
> +    o->full = *full;
> +    o->haddr = (void *)((uintptr_t)addr + entry->addend);
>       goto done;
>   
> - found:
> -    /* Alignment has not been checked by tlb_fill_align. */
> -    {
> + found_code:
> +    o->flags = node->copy.addr_read & TLB_EXEC_FLAGS_MASK;
> +    o->full = node->full;
> +    o->haddr = (void *)((uintptr_t)addr + node->copy.addend);
> +    goto done;
> +
> + done:
> +    if (!o->did_tlb_fill) {
>           int a_bits = memop_alignment_bits(memop);
>   
>           /*
> +         * Alignment has not been checked by tlb_fill_align.
> +         *
>            * The TLB_CHECK_ALIGNED check differs from the normal alignment
>            * check, in that this is based on the atomicity of the operation.
>            * The intended use case is the ARM memory type field of each PTE,
> @@ -1366,13 +1391,6 @@ static bool tlb_lookup(CPUState *cpu, TLBLookupOutput *o,
>               cpu_unaligned_access(cpu, addr, access_type, i->mmu_idx, i->ra);
>           }
>       }
> -
> - done:
> -    flags &= cmp;
> -    flags |= full->slow_flags[access_type];
> -    o->flags = flags;
> -    o->full = *full;
> -    o->haddr = (void *)((uintptr_t)addr + entry->addend);
>       return true;
>   }
>   

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


