Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7EA1D6A224
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 18:13:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBeLG-0003tY-WE; Thu, 14 Nov 2024 13:13:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBeLD-0003lf-Vd
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:13:16 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBeLC-00059c-4v
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:13:15 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-72041ff06a0so692984b3a.2
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 10:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731607992; x=1732212792; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lbMmsPgDZJMgiCoFDCuQQMwZJcmBrhKOhqhPttV2O8E=;
 b=TJPEeuiKHv6PRz9M1OZuFLacMttkU9q2edFsNfCjYV5FsIVr+X84lfiCv6GZeZ9E0L
 dNp1jH8dbkIG0m4cjLgREyyWvlhor0n/qH8ULqbcskNwXCrXwzo3ZswuUjl82LFAEl8b
 /BZ+qf5ywtFw+tfd2upULWJ3/z8SycL78H9fhnk3n5X18soISJyY7LvLGccylQLH+Krb
 tl4pDTFZIBryc4bHKJhmxdlZmDM+tyCHYnmWYVbvUy+HujBWuJbzELFPzJ0Bgvw2+XvG
 N+q0J0XUirGjQ0QyPBksFNG9oxUlSaDpo9Eypd5qRIOzMwErAMd1tlC4B79P1OrhQLsP
 pQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731607992; x=1732212792;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lbMmsPgDZJMgiCoFDCuQQMwZJcmBrhKOhqhPttV2O8E=;
 b=CQ90uakilrIUNsCUropQy4WFZFexjvdmuTNGe0iY9JzEEleudJZxI84RTeK52jEu1t
 FKUXqBHDzUKVlx7nI6h3DhzBFEpFr6Kd1TKxN64cSZb1LkUxfiVlKvXmdjhhqME7iKiJ
 53A5HGtc2lyrMTTyIyIL6D4XOuS5V7gpZEjbjhJxtKC4Q1y/5XDtfpibMNwttrmqd2la
 HzD9WRlq2nw3usO5mOpPYnteXFHdlvfkloTmxv1yYfWcFVJpgBrWGhWpUQdKTPF0wKCO
 dyB6plqyEb6p2dsmPACKkPFw7iCBr5yhNNhO35mij8kz7RjimRf4f0R51XqqOEGOjyxc
 QUng==
X-Forwarded-Encrypted: i=1;
 AJvYcCWu5XgKtLDgJfHapAOOODs8d/ttfqQKgsRv/9pjJS5Ajz+YxvjWCMhBmpzv+nC47PDbg8oQufPj5sPZ@nongnu.org
X-Gm-Message-State: AOJu0Yy21NzbsHXTZ/NML/1LyPfFTJmleMOxX5zvrs3sTOVROvu9Lfns
 cux9/PH04YmAMKetWr1/gO7IPLKq9owepoMOUGfG0wtBKcH/1OYLN/5WLBRE4hM=
X-Google-Smtp-Source: AGHT+IFYpsT+QH9manvfD0hDsDn5I5oQl923vrha/6NqJuUhhMk6Rl93YifGys3iIQqrMpcSKZ6meA==
X-Received: by 2002:a17:90b:2e8e:b0:2e0:f896:9d6d with SMTP id
 98e67ed59e1d1-2ea06375513mr3833339a91.16.1731607992218; 
 Thu, 14 Nov 2024 10:13:12 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211c7c29475sm13688185ad.37.2024.11.14.10.13.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 10:13:11 -0800 (PST)
Message-ID: <71459969-edeb-4366-b819-b4cda19d5884@linaro.org>
Date: Thu, 14 Nov 2024 10:13:11 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 27/54] accel/tcg: Return CPUTLBEntryFull not pointer in
 probe_access_internal
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241114160131.48616-1-richard.henderson@linaro.org>
 <20241114160131.48616-28-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114160131.48616-28-richard.henderson@linaro.org>
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

On 11/14/24 08:01, Richard Henderson wrote:
> Return a copy of the structure, not a pointer.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cputlb.c | 40 ++++++++++++++++++----------------------
>   1 file changed, 18 insertions(+), 22 deletions(-)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 84e7e633e3..41b2f76cc9 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1364,7 +1364,7 @@ static void notdirty_write(CPUState *cpu, vaddr mem_vaddr, unsigned size,
>   static int probe_access_internal(CPUState *cpu, vaddr addr,
>                                    int fault_size, MMUAccessType access_type,
>                                    int mmu_idx, bool nonfault,
> -                                 void **phost, CPUTLBEntryFull **pfull,
> +                                 void **phost, CPUTLBEntryFull *pfull,
>                                    uintptr_t retaddr, bool check_mem_cbs)
>   {
>       uintptr_t index = tlb_index(cpu, mmu_idx, addr);
> @@ -1379,7 +1379,7 @@ static int probe_access_internal(CPUState *cpu, vaddr addr,
>                                   0, fault_size, nonfault, retaddr)) {
>                   /* Non-faulting page table read failed.  */
>                   *phost = NULL;
> -                *pfull = NULL;
> +                memset(pfull, 0, sizeof(*pfull));
>                   return TLB_INVALID_MASK;
>               }
>   
> @@ -1398,8 +1398,9 @@ static int probe_access_internal(CPUState *cpu, vaddr addr,
>       }
>       flags &= tlb_addr;
>   
> -    *pfull = full = &cpu->neg.tlb.d[mmu_idx].fulltlb[index];
> +    full = &cpu->neg.tlb.d[mmu_idx].fulltlb[index];
>       flags |= full->slow_flags[access_type];
> +    *pfull = *full;
>   
>       /*
>        * Fold all "mmio-like" bits, and required plugin callbacks, to TLB_MMIO.
> @@ -1423,19 +1424,17 @@ int probe_access_full(CPUArchState *env, vaddr addr, int size,
>                         bool nonfault, void **phost, CPUTLBEntryFull *pfull,
>                         uintptr_t retaddr)
>   {
> -    CPUTLBEntryFull *full;
>       int flags = probe_access_internal(env_cpu(env), addr, size, access_type,
> -                                      mmu_idx, nonfault, phost, &full, retaddr,
> +                                      mmu_idx, nonfault, phost, pfull, retaddr,
>                                         true);
>   
>       /* Handle clean RAM pages.  */
>       if (unlikely(flags & TLB_NOTDIRTY)) {
>           int dirtysize = size == 0 ? 1 : size;
> -        notdirty_write(env_cpu(env), addr, dirtysize, full, retaddr);
> +        notdirty_write(env_cpu(env), addr, dirtysize, pfull, retaddr);
>           flags &= ~TLB_NOTDIRTY;
>       }
>   
> -    *pfull = *full;
>       return flags;
>   }
>   
> @@ -1444,25 +1443,22 @@ int probe_access_full_mmu(CPUArchState *env, vaddr addr, int size,
>                             void **phost, CPUTLBEntryFull *pfull)
>   {
>       void *discard_phost;
> -    CPUTLBEntryFull *full;
> +    CPUTLBEntryFull discard_full;
>   
>       /* privately handle users that don't need full results */
>       phost = phost ? phost : &discard_phost;
> +    pfull = pfull ? pfull : &discard_full;
>   
>       int flags = probe_access_internal(env_cpu(env), addr, size, access_type,
> -                                      mmu_idx, true, phost, &full, 0, false);
> +                                      mmu_idx, true, phost, pfull, 0, false);
>   
>       /* Handle clean RAM pages.  */
>       if (unlikely(flags & TLB_NOTDIRTY)) {
>           int dirtysize = size == 0 ? 1 : size;
> -        notdirty_write(env_cpu(env), addr, dirtysize, full, 0);
> +        notdirty_write(env_cpu(env), addr, dirtysize, pfull, 0);
>           flags &= ~TLB_NOTDIRTY;
>       }
>   
> -    if (pfull) {
> -        *pfull = *full;
> -    }
> -
>       return flags;
>   }
>   
> @@ -1470,7 +1466,7 @@ int probe_access_flags(CPUArchState *env, vaddr addr, int size,
>                          MMUAccessType access_type, int mmu_idx,
>                          bool nonfault, void **phost, uintptr_t retaddr)
>   {
> -    CPUTLBEntryFull *full;
> +    CPUTLBEntryFull full;
>       int flags;
>   
>       g_assert(-(addr | TARGET_PAGE_MASK) >= size);
> @@ -1482,7 +1478,7 @@ int probe_access_flags(CPUArchState *env, vaddr addr, int size,
>       /* Handle clean RAM pages. */
>       if (unlikely(flags & TLB_NOTDIRTY)) {
>           int dirtysize = size == 0 ? 1 : size;
> -        notdirty_write(env_cpu(env), addr, dirtysize, full, retaddr);
> +        notdirty_write(env_cpu(env), addr, dirtysize, &full, retaddr);
>           flags &= ~TLB_NOTDIRTY;
>       }
>   
> @@ -1492,7 +1488,7 @@ int probe_access_flags(CPUArchState *env, vaddr addr, int size,
>   void *probe_access(CPUArchState *env, vaddr addr, int size,
>                      MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
>   {
> -    CPUTLBEntryFull *full;
> +    CPUTLBEntryFull full;
>       void *host;
>       int flags;
>   
> @@ -1513,12 +1509,12 @@ void *probe_access(CPUArchState *env, vaddr addr, int size,
>               int wp_access = (access_type == MMU_DATA_STORE
>                                ? BP_MEM_WRITE : BP_MEM_READ);
>               cpu_check_watchpoint(env_cpu(env), addr, size,
> -                                 full->attrs, wp_access, retaddr);
> +                                 full.attrs, wp_access, retaddr);
>           }
>   
>           /* Handle clean RAM pages.  */
>           if (flags & TLB_NOTDIRTY) {
> -            notdirty_write(env_cpu(env), addr, size, full, retaddr);
> +            notdirty_write(env_cpu(env), addr, size, &full, retaddr);
>           }
>       }
>   
> @@ -1528,7 +1524,7 @@ void *probe_access(CPUArchState *env, vaddr addr, int size,
>   void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr addr,
>                           MMUAccessType access_type, int mmu_idx)
>   {
> -    CPUTLBEntryFull *full;
> +    CPUTLBEntryFull full;
>       void *host;
>       int flags;
>   
> @@ -1552,7 +1548,7 @@ void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr addr,
>   tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, vaddr addr,
>                                           void **hostp)
>   {
> -    CPUTLBEntryFull *full;
> +    CPUTLBEntryFull full;
>       void *p;
>   
>       (void)probe_access_internal(env_cpu(env), addr, 1, MMU_INST_FETCH,
> @@ -1562,7 +1558,7 @@ tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, vaddr addr,
>           return -1;
>       }
>   
> -    if (full->lg_page_size < TARGET_PAGE_BITS) {
> +    if (full.lg_page_size < TARGET_PAGE_BITS) {
>           return -1;
>       }
>   

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


