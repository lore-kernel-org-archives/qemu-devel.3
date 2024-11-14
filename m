Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2918BD6A226
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 18:58:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBf2m-0007Xv-00; Thu, 14 Nov 2024 13:58:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBf1G-0005Fl-16
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:56:44 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBf1E-0000cU-8l
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:56:41 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-71e681bc315so720397b3a.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 10:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731610599; x=1732215399; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CPbqcu8B2Th5H5BKQW1oRo6VOtmSpMQrOMtDuPqo3Gs=;
 b=wmNjk/foKjf5/endoh7TsR8m9p7jNfKl6/BJgsmKMKCm49YLwXV4pSr5NPPeR5RfvB
 2+gzFMKCfCM7bnUxOQqTSlCSoR6SBYeLba2X7HyZGSWRxKkeUcI4qsQlTuupfSctK5Ht
 wcGWFEi9bb5N3a+RsaSdC1BYYCvBS1hE5kKxXiXbr5pFZWMNbTTgAYFgMvghpzrcJY8p
 8k7OoothhgSluL3pFtCiqef4edQ4nyNhBdx5bBytA7byVNPVw7pfWYnWblsoF7/Cu7O7
 WHP2wx8HMU2chrhyD8AfrSEf/mlBnKrJGWsZS4p4iD0JAPKWJt9doYMLWlo1mmNA5oeM
 Bzng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731610599; x=1732215399;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CPbqcu8B2Th5H5BKQW1oRo6VOtmSpMQrOMtDuPqo3Gs=;
 b=fy6TYATuXLN9Kg++GQ59wdUK/o3OykFIVkKlzr1SLsradpLG/EAtAyy3XltgTdKIQl
 T35TwopuoFRbr+je7WLd6C9TfkNQcUwyQvJqpXqCRQLjnPIQzRtro6Co3mYRW6qekH4y
 TXAGo661PWGK/kX0XM/qF/YaSa9EZRkLMwY17ENlMJkZohQUP9vB0NPwz9eyNuMXva4a
 6jjI5PzDl1Q/Wjz4U5g0iEunFA0im+cLJuFsm7dgI7Ny/dEsB7iPwJU418+2fW3Fgk7c
 qTpHF5kx0bONENOnYg6tU6O8hpOwm85GMeztniDm4VlWh0WqEwITJIM/C5Vx0udI5hZ7
 G4sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnAisQJSZpQOFAhPnrkEfvg0gMLoWESrCRxag/4DK5P+bbHGjTjNQm3wgmyMWxSmfq6vdDM+Hf4LYg@nongnu.org
X-Gm-Message-State: AOJu0Yyprcdc0Nb6wFey+uUHEhmz3pk/VXlkTjnd72G+yaHvSZnx9Mdr
 0+WdlQ4QI6d/s7JzxUIJYpUpewS63QWbhO6pJvFWeECu9cpfS7C7m03mddYHxxo=
X-Google-Smtp-Source: AGHT+IEmVD+OQxqkg6C0sAaceAhZmJhT4bvTEuw8VYbgf4CH2cI615K9YWSH/jG8Tll+1r2olNiA/Q==
X-Received: by 2002:a05:6a00:4fd5:b0:71e:7f08:492c with SMTP id
 d2e1a72fcca58-72475f97182mr259562b3a.1.1731610598505; 
 Thu, 14 Nov 2024 10:56:38 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7246a9a89b5sm1622826b3a.103.2024.11.14.10.56.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 10:56:38 -0800 (PST)
Message-ID: <18e38d35-6646-44c4-aea5-c219c20cf2f3@linaro.org>
Date: Thu, 14 Nov 2024 10:56:37 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 52/54] accel/tcg: Unexport tlb_set_page*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241114160131.48616-1-richard.henderson@linaro.org>
 <20241114160131.48616-53-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114160131.48616-53-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
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
> The new tlb_fill_align hook returns page data via structure
> rather than by function call, so we can make tlb_set_page_full
> be local to cputlb.c.  There are no users of tlb_set_page
> or tlb_set_page_with_attrs, so those can be eliminated.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/exec-all.h | 57 -----------------------------------------
>   accel/tcg/cputlb.c      | 27 ++-----------------
>   2 files changed, 2 insertions(+), 82 deletions(-)
> 
> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
> index 69bdb77584..b65fc547bd 100644
> --- a/include/exec/exec-all.h
> +++ b/include/exec/exec-all.h
> @@ -184,63 +184,6 @@ void tlb_flush_range_by_mmuidx_all_cpus_synced(CPUState *cpu,
>                                                  vaddr len,
>                                                  uint16_t idxmap,
>                                                  unsigned bits);
> -
> -/**
> - * tlb_set_page_full:
> - * @cpu: CPU context
> - * @mmu_idx: mmu index of the tlb to modify
> - * @addr: virtual address of the entry to add
> - * @full: the details of the tlb entry
> - *
> - * Add an entry to @cpu tlb index @mmu_idx.  All of the fields of
> - * @full must be filled, except for xlat_section, and constitute
> - * the complete description of the translated page.
> - *
> - * This is generally called by the target tlb_fill function after
> - * having performed a successful page table walk to find the physical
> - * address and attributes for the translation.
> - *
> - * At most one entry for a given virtual address is permitted. Only a
> - * single TARGET_PAGE_SIZE region is mapped; @full->lg_page_size is only
> - * used by tlb_flush_page.
> - */
> -void tlb_set_page_full(CPUState *cpu, int mmu_idx, vaddr addr,
> -                       CPUTLBEntryFull *full);
> -
> -/**
> - * tlb_set_page_with_attrs:
> - * @cpu: CPU to add this TLB entry for
> - * @addr: virtual address of page to add entry for
> - * @paddr: physical address of the page
> - * @attrs: memory transaction attributes
> - * @prot: access permissions (PAGE_READ/PAGE_WRITE/PAGE_EXEC bits)
> - * @mmu_idx: MMU index to insert TLB entry for
> - * @size: size of the page in bytes
> - *
> - * Add an entry to this CPU's TLB (a mapping from virtual address
> - * @addr to physical address @paddr) with the specified memory
> - * transaction attributes. This is generally called by the target CPU
> - * specific code after it has been called through the tlb_fill()
> - * entry point and performed a successful page table walk to find
> - * the physical address and attributes for the virtual address
> - * which provoked the TLB miss.
> - *
> - * At most one entry for a given virtual address is permitted. Only a
> - * single TARGET_PAGE_SIZE region is mapped; the supplied @size is only
> - * used by tlb_flush_page.
> - */
> -void tlb_set_page_with_attrs(CPUState *cpu, vaddr addr,
> -                             hwaddr paddr, MemTxAttrs attrs,
> -                             int prot, int mmu_idx, vaddr size);
> -/* tlb_set_page:
> - *
> - * This function is equivalent to calling tlb_set_page_with_attrs()
> - * with an @attrs argument of MEMTXATTRS_UNSPECIFIED. It's provided
> - * as a convenience for CPUs which don't use memory transaction attributes.
> - */
> -void tlb_set_page(CPUState *cpu, vaddr addr,
> -                  hwaddr paddr, int prot,
> -                  int mmu_idx, vaddr size);
>   #else
>   static inline void tlb_init(CPUState *cpu)
>   {
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index ec597ed6f5..3d731b8f3d 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1037,8 +1037,8 @@ static inline void tlb_set_compare(CPUTLBEntryFull *full, CPUTLBEntry *ent,
>    * Called from TCG-generated code, which is under an RCU read-side
>    * critical section.
>    */
> -void tlb_set_page_full(CPUState *cpu, int mmu_idx,
> -                       vaddr addr, CPUTLBEntryFull *full)
> +static void tlb_set_page_full(CPUState *cpu, int mmu_idx,
> +                              vaddr addr, CPUTLBEntryFull *full)
>   {
>       CPUTLB *tlb = &cpu->neg.tlb;
>       CPUTLBDesc *desc = &tlb->d[mmu_idx];
> @@ -1189,29 +1189,6 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
>       qemu_spin_unlock(&tlb->c.lock);
>   }
>   
> -void tlb_set_page_with_attrs(CPUState *cpu, vaddr addr,
> -                             hwaddr paddr, MemTxAttrs attrs, int prot,
> -                             int mmu_idx, uint64_t size)
> -{
> -    CPUTLBEntryFull full = {
> -        .phys_addr = paddr,
> -        .attrs = attrs,
> -        .prot = prot,
> -        .lg_page_size = ctz64(size)
> -    };
> -
> -    assert(is_power_of_2(size));
> -    tlb_set_page_full(cpu, mmu_idx, addr, &full);
> -}
> -
> -void tlb_set_page(CPUState *cpu, vaddr addr,
> -                  hwaddr paddr, int prot,
> -                  int mmu_idx, uint64_t size)
> -{
> -    tlb_set_page_with_attrs(cpu, addr, paddr, MEMTXATTRS_UNSPECIFIED,
> -                            prot, mmu_idx, size);
> -}
> -
>   /*
>    * Note: tlb_fill_align() can trigger a resize of the TLB.
>    * This means that all of the caller's prior references to the TLB table

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


