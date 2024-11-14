Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37249D6A224
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 18:40:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBeky-0000nv-9c; Thu, 14 Nov 2024 13:39:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBekn-0000i4-1M
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:39:43 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBekh-0003nd-SW
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:39:40 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-20c6f492d2dso11358475ad.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 10:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731609574; x=1732214374; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V8AOf2sY/+vxF4Ditw7yN2puZ+W43AFPfoEVRb4eRsI=;
 b=AkdtWC6rbjrV86S1K2nSnDm4vwpHJTfTxAhtZebyHWcU9XR1Q9NHn12IdP8LcMK79Z
 cXsTfsqzvWXjQXxq3FuC8oFfaDNKgGteGKkCCt94WUFcrfTygzk6fnnxnR4dLS3K99Jc
 23yP14EGjGPuPGBpFUm4MWsyXJXpZzryyQ7XBGkOHRx0Xq5pih2ml/CDkivf+bKTqpXx
 rNOWUsQHm64fexFlGxoAV1NsdJY2IaVf8Kh20WsX5USjHdaZbdOVIUlBZnFPqvo+3urS
 U4kFiXsPPtl35U7yhIuAonip6LTU+M3EAr/Ld17Uhv6R+x5rBbno8opx02Rt7PJfcHnD
 7mKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731609574; x=1732214374;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V8AOf2sY/+vxF4Ditw7yN2puZ+W43AFPfoEVRb4eRsI=;
 b=dUVUmvlwgnW2wk0/wjAkkmV7wWdHwO0D7780r8U0Nfpo65DTQvs2xVutoNsQJUxDnI
 I074BQBr2NjMjNyA/wLF9GurPUZD5eWUQzYYFYtVH+wVcShPwYvzs9GwD8JcP5EJ2NTK
 tHwzfamPteLjArSZBfSqUM+BLClCkydpOew/eZcxU8f9q5F6atYwAlRieORz4f3sfg/t
 42bzSeluC1fSaLGtOYRyOF4I147vebBbfOwKP4yT2sTefahsEm4hxAnpx+4V5pSv/c5x
 kNnRcqNRax2/ZkUvum/LlcYH5m2Elc/Uz5/cQ9FIpF6vx3uDgyMtqq92pF1E8t3jySXy
 c54Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfYoZYG6u+NbFP/iVkMWpp5bWl0YEwLg1TTsWGedzH+UloK/bJIMu24qSn4vYHBZsqqL5BVgFhQ1D2@nongnu.org
X-Gm-Message-State: AOJu0Yx2+oasFq4zwHuCjW/Np0w5phe8qk0eQjYxAnqiUF3eFc+GeSiL
 vnVVxySNvj3Uad5jwCKTXThDhG5jzYsLA5H40hWMX/qIX9ERZTodunZMbUtZAb0=
X-Google-Smtp-Source: AGHT+IExmgoWxZGmB2srI6G02WoR7WYvA2vLQCnIwv9HVmvvOiX5w2/ikZ/XEmmrfdneoAyZ6bsv5w==
X-Received: by 2002:a17:903:1110:b0:211:31ac:89f1 with SMTP id
 d9443c01a7336-211c4f9aa1cmr39592855ad.8.1731609573994; 
 Thu, 14 Nov 2024 10:39:33 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea06ef6db2sm1480319a91.6.2024.11.14.10.39.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 10:39:33 -0800 (PST)
Message-ID: <729761a6-6db8-4678-bc0b-86293caf8115@linaro.org>
Date: Thu, 14 Nov 2024 10:39:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 32/54] accel/tcg: Link CPUTLBEntry to CPUTLBEntryTree
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241114160131.48616-1-richard.henderson@linaro.org>
 <20241114160131.48616-33-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114160131.48616-33-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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
> Link from the fast tlb entry to the interval tree node.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/tlb-common.h |  2 ++
>   accel/tcg/cputlb.c        | 26 +++++++++++++-------------
>   2 files changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/include/exec/tlb-common.h b/include/exec/tlb-common.h
> index feaa471299..3b57d61112 100644
> --- a/include/exec/tlb-common.h
> +++ b/include/exec/tlb-common.h
> @@ -31,6 +31,8 @@ typedef union CPUTLBEntry {
>            * use the corresponding iotlb value.
>            */
>           uintptr_t addend;
> +        /* The defining IntervalTree entry. */
> +        struct CPUTLBEntryTree *tree;
>       };
>       /*
>        * Padding to get a power of two size, as well as index
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index be2ea1bc70..3282436752 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -490,7 +490,10 @@ static bool tlb_flush_entry_mask_locked(CPUTLBEntry *tlb_entry,
>                                           vaddr mask)
>   {
>       if (tlb_hit_page_mask_anyprot(tlb_entry, page, mask)) {
> -        memset(tlb_entry, -1, sizeof(*tlb_entry));
> +        tlb_entry->addr_read = -1;
> +        tlb_entry->addr_write = -1;
> +        tlb_entry->addend = 0;
> +        tlb_entry->tree = NULL;
>           return true;
>       }
>       return false;
> @@ -1183,6 +1186,7 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
>   
>       /* Now calculate the new entry */
>       node->copy.addend = addend - addr_page;
> +    node->copy.tree = node;
>   
>       if (wp_flags & BP_MEM_READ) {
>           read_flags |= TLB_WATCHPOINT;
> @@ -1291,7 +1295,6 @@ static bool tlb_lookup(CPUState *cpu, TLBLookupOutput *o,
>       CPUTLBDescFast *fast = &cpu->neg.tlb.f[i->mmu_idx];
>       vaddr addr = i->addr;
>       MMUAccessType access_type = i->access_type;
> -    CPUTLBEntryFull *full;
>       CPUTLBEntryTree *node;
>       CPUTLBEntry *entry;
>       uint64_t cmp;
> @@ -1304,9 +1307,9 @@ static bool tlb_lookup(CPUState *cpu, TLBLookupOutput *o,
>   
>       /* Primary lookup in the fast tlb. */
>       entry = tlbfast_entry(fast, addr);
> -    full = &desc->fulltlb[tlbfast_index(fast, addr)];
>       if (access_type != MMU_INST_FETCH) {
>           cmp = tlb_read_idx(entry, access_type);
> +        node = entry->tree;
>           if (tlb_hit(cmp, addr)) {
>               goto found_data;
>           }
> @@ -1326,7 +1329,6 @@ static bool tlb_lookup(CPUState *cpu, TLBLookupOutput *o,
>                   qemu_spin_lock(&cpu->neg.tlb.c.lock);
>                   copy_tlb_helper_locked(entry, &node->copy);
>                   qemu_spin_unlock(&cpu->neg.tlb.c.lock);
> -                *full = node->full;
>                   goto found_data;
>               }
>           }
> @@ -1347,8 +1349,8 @@ static bool tlb_lookup(CPUState *cpu, TLBLookupOutput *o,
>       }
>   
>       entry = tlbfast_entry(fast, addr);
> -    full = &desc->fulltlb[tlbfast_index(fast, addr)];
>       cmp = tlb_read_idx(entry, access_type);
> +    node = entry->tree;
>       /*
>        * With PAGE_WRITE_INV, we set TLB_INVALID_MASK immediately,
>        * to force the next access through tlb_fill_align.  We've just
> @@ -1359,19 +1361,18 @@ static bool tlb_lookup(CPUState *cpu, TLBLookupOutput *o,
>   
>    found_data:
>       flags &= cmp;
> -    flags |= full->slow_flags[access_type];
> +    flags |= node->full.slow_flags[access_type];
>       o->flags = flags;
> -    o->full = *full;
> -    o->haddr = (void *)((uintptr_t)addr + entry->addend);
> -    goto done;
> +    goto found_common;
>   
>    found_code:
>       o->flags = node->copy.addr_read & TLB_EXEC_FLAGS_MASK;
> +    goto found_common;
> +
> + found_common:
>       o->full = node->full;
>       o->haddr = (void *)((uintptr_t)addr + node->copy.addend);
> -    goto done;
>   
> - done:
>       if (!o->did_tlb_fill) {
>           int a_bits = memop_alignment_bits(memop);
>   
> @@ -1669,7 +1670,6 @@ bool tlb_plugin_lookup(CPUState *cpu, vaddr addr, int mmu_idx,
>                          bool is_store, struct qemu_plugin_hwaddr *data)
>   {
>       CPUTLBEntry *tlbe = tlb_entry(cpu, mmu_idx, addr);
> -    uintptr_t index = tlb_index(cpu, mmu_idx, addr);
>       MMUAccessType access_type = is_store ? MMU_DATA_STORE : MMU_DATA_LOAD;
>       uint64_t tlb_addr = tlb_read_idx(tlbe, access_type);
>       CPUTLBEntryFull *full;
> @@ -1678,7 +1678,7 @@ bool tlb_plugin_lookup(CPUState *cpu, vaddr addr, int mmu_idx,
>           return false;
>       }
>   
> -    full = &cpu->neg.tlb.d[mmu_idx].fulltlb[index];
> +    full = &tlbe->tree->full;
>       data->phys_addr = full->phys_addr | (addr & ~TARGET_PAGE_MASK);
>   
>       /* We must have an iotlb entry for MMIO */

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


