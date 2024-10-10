Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56AC0CEDDA6
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 00:39:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syhCf-0000AH-Jc; Wed, 09 Oct 2024 20:38:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1syhCd-00009t-FJ
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 20:38:51 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1syhCb-00069n-Jj
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 20:38:51 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-71e053cf1f3so355355b3a.2
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 17:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728520728; x=1729125528; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a64vWiWPLo+X43snZHQh9Hls5UpsRt7O58ceEY2mxPM=;
 b=KzKhON9GAqmxhykG6bW+wWE6zFzKEaIC7PGCqW/ZrnCjErG/4osefO8VeF3OTlJJCr
 Nuq1PNkNYxc3N2yOALefvv5oUfo+F//IxD88S6c3B9hyxp30Lbt2c34RsW5EmU2GOWTs
 8s2ZZ9CVDk+FB2AH0K7Ys088irQR85ifFdSwYKlwk9jm0B+Kzj4BMDBiRDahkiJY8jCQ
 eyxTycum1C0KdGIpLJC11l8UzBdFp1JdmpSGs/BxSnhY4fLbwJrrnnB3vW0waSUoMxya
 FC1NSIuukScshDTIaE7tra/J/E6SC8H86GhuLhbmCv6EXPiMhIkDk74LXGOopMz455ON
 mDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728520728; x=1729125528;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a64vWiWPLo+X43snZHQh9Hls5UpsRt7O58ceEY2mxPM=;
 b=Snvazt88687qlKVphbdm75hDZPgjcvMEsG2/wwY7QSFoO2wiJRLWVCBD36z+8jh+Oa
 7WTflPyiNPYzmp0ZJcd826d3v5EoHK5j+msD0XLpyuigPPvihzr5Sg7ClZys+oji30Pk
 6biw4VfrTQCHguVtedYriouBP7vm3v/4Zyq1Hx34vbx4Bx8AV+TJzZoNETeYDrKb22Eq
 eoJALSNV980bQ4ebfEcUlEX/BJx0WXSsZ+zyW3nhH39kLCM7/+xQ4suD/v3IeLGB+Bth
 Lkq/jiHT0Ptoilgw5eSKHuc8vUK/kygvss4XRjt69phycKvrnUQHl1zY872SS2y7LBEs
 1mcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJRUQifW4zhT/xqZFfj2RpcmMoQzvoP3RFU47jOzQYkvUSGuhW/46TMT27MdpbUjcL/vRnbmcSBGgd@nongnu.org
X-Gm-Message-State: AOJu0YxXbeU8Kywn71X7vKg/GMrcxe0MKQakV+Vax3Dm0tN78r8el8uQ
 TJ6c6ZlgRrn8Jqi6uFfOWX9/RuisMFoEU1bMetWqBYAitg2c0JdFuMUAn9gOafk//co+p1tponk
 iI3o=
X-Google-Smtp-Source: AGHT+IEacUt2Fhf8nsz9LBCP1tEWyeAerANlOwNMruT5QilBkv5yWF8qrrLw5OhTygv1TgWPHq1eZg==
X-Received: by 2002:a05:6a21:1709:b0:1cf:3c60:b8d3 with SMTP id
 adf61e73a8af0-1d8a3c0e379mr8184824637.19.1728520727626; 
 Wed, 09 Oct 2024 17:38:47 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ea4496816esm32410a12.89.2024.10.09.17.38.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Oct 2024 17:38:47 -0700 (PDT)
Message-ID: <f95b79b3-e1b1-4d24-9c78-b4c6c28c1695@linaro.org>
Date: Wed, 9 Oct 2024 17:38:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/23] accel/tcg: Remove CPUTLBDesc.fulltlb
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241009150855.804605-1-richard.henderson@linaro.org>
 <20241009150855.804605-22-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241009150855.804605-22-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
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
> This array is now write-only, and may be remove.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/hw/core/cpu.h |  1 -
>   accel/tcg/cputlb.c    | 39 ++++++++-------------------------------
>   2 files changed, 8 insertions(+), 32 deletions(-)
> 
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 6b1c2bfadd..3022529733 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -216,7 +216,6 @@ typedef struct CPUTLBDesc {
>       /* maximum number of entries observed in the window */
>       size_t window_max_entries;
>       size_t n_used_entries;
> -    CPUTLBEntryFull *fulltlb;
>       /* All active tlb entries for this address space. */
>       IntervalTreeRoot iroot;
>   } CPUTLBDesc;
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 2a8d1b4fb2..47b9557bb8 100644
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
> @@ -382,15 +370,9 @@ void tlb_init(CPUState *cpu)
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
> @@ -1090,7 +1072,7 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
>       CPUTLB *tlb = &cpu->neg.tlb;
>       CPUTLBDesc *desc = &tlb->d[mmu_idx];
>       MemoryRegionSection *section;
> -    unsigned int index, read_flags, write_flags;
> +    unsigned int read_flags, write_flags;
>       uintptr_t addend;
>       CPUTLBEntry *te;
>       CPUTLBEntryTree *node;
> @@ -1169,7 +1151,6 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
>       wp_flags = cpu_watchpoint_address_matches(cpu, addr_page,
>                                                 TARGET_PAGE_SIZE);
>   
> -    index = tlb_index(cpu, mmu_idx, addr_page);
>       te = tlb_entry(cpu, mmu_idx, addr_page);
>   
>       /*
> @@ -1208,8 +1189,8 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
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
> @@ -1232,7 +1213,6 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
>       tlb_set_compare(full, &node->copy, addr_page, write_flags,
>                       MMU_DATA_STORE, prot & PAGE_WRITE);
>   
> -    node->full = *full;
>       copy_tlb_helper_locked(te, &node->copy);
>       tlb_n_used_entries_inc(cpu, mmu_idx);
>       qemu_spin_unlock(&tlb->c.lock);
> @@ -1343,7 +1323,6 @@ static bool tlbtree_hit(CPUState *cpu, int mmu_idx,
>       CPUTLBDesc *desc = &cpu->neg.tlb.d[mmu_idx];
>       CPUTLBDescFast *fast = &cpu->neg.tlb.f[mmu_idx];
>       CPUTLBEntryTree *node;
> -    size_t index;
>   
>       assert_cpu_is_self(cpu);
>       node = tlbtree_lookup_addr(desc, addr);
> @@ -1358,12 +1337,10 @@ static bool tlbtree_hit(CPUState *cpu, int mmu_idx,
>       }
>   
>       /* Install the cached entry. */
> -    index = tlbfast_index(fast, addr);
>       qemu_spin_lock(&cpu->neg.tlb.c.lock);
> -    copy_tlb_helper_locked(&fast->table[index], &node->copy);
> +    copy_tlb_helper_locked(tlbfast_entry(fast, addr), &node->copy);
>       qemu_spin_unlock(&cpu->neg.tlb.c.lock);
>   
> -    desc->fulltlb[index] = node->full;
>       return true;
>   }
>   

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

