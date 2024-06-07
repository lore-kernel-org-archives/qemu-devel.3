Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21218C27C53
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 00:35:24 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFdOT-0008Mk-Tc; Fri, 07 Jun 2024 13:28:49 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sFdOS-0008MZ-0a
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 13:28:48 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sFdOQ-0008SF-1Q
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 13:28:47 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1f6c7cdec83so16063965ad.0
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2024 10:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717781324; x=1718386124; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d1BVORadwbgcC2qB1Dfekv5MbRyaml+FuaXKMyoz0sY=;
 b=Rm2WUjUCo+w6nZnkIIgc42kXChGkQiOqUFI4ub+E1oCRGTO59T8mHeV2tnbEFUt8Aw
 me+oJr3XBupCaF3ZR0lQ2i0GqgCSiq6lonKjqqLIuRQGCvQmLciaI4jlSowKV7j9CV1k
 box0YV9Wm1LZLgn5ZvVljLGfrJZvnwA1E0S11g6TjosNkzuy4603HxtEWREtG4/ZuJh3
 w6hfQNG/TQCyxx2uO0H+lBaqa2d7Ggd0x5+8n3htoNyi+dVQnc7U5R5CUo2u2IYh21YO
 Gq1KUrxJ6qvrVrDXfQ2Y5btkkHKnfMhxuokxA67u1inpCEu3vzSb4i5eUH3kEkhiotxo
 IW7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717781324; x=1718386124;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d1BVORadwbgcC2qB1Dfekv5MbRyaml+FuaXKMyoz0sY=;
 b=hstRd6pnC/Gj6ackmYJRvlYb80I4HqTa7mtZrpS6EymdLGKX6KmHD7C6jBQoHX6GZU
 64MoY3k/rPwZ/BTf/FAYxC8qm8Z+4DWpxl6o/6StYbExB9YPefg5yn/1+6wXpLlpwJay
 qljj0nBoCCOSSyppVZ4eWmZmP36of0K5Fbb+KVdYKATFSijntUeC1rczCQBka6I/LOrn
 vPv1O3D8k6aEU+POA0sow8zjsp5Fq6hMwVWm/EUTRnKzmipsF8CnVETsUnEwNZCCM/vr
 Abz9d1hDwNar9TK1qn+rS+x7FJryiVpd4VJDJuOgwcM3LqA0/y43mRpBkeQeitGNrxGg
 SiUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/q112a9R1mEXesWjvple0PGNznDS30naw/CBoPelYpO8Pklwr21tnR6rG5oKont7TZpW1MIVYhB6WHGoZZalbFJxxuwQ=
X-Gm-Message-State: AOJu0YwkXxtpbUy3lESCd1mbbTG+kROVqm+cGoaGpfyA8FLSfJTIkN8O
 wO2p5nDC7s2N3bxnGJvSt06ljbW4gf2MB1CsnKOn/ouHZPdzV6lj2o72MFoK+aY=
X-Google-Smtp-Source: AGHT+IHQlstcDi7HBiBSaCAhGEpZ2juxLrhzdDzDYuUcLdJxjgzR1Ej2Fg0RxITRzwIwYn9hEFMZ4g==
X-Received: by 2002:a17:903:32d2:b0:1f6:39d8:dc4f with SMTP id
 d9443c01a7336-1f6d02c0542mr36295675ad.10.1717781324341; 
 Fri, 07 Jun 2024 10:28:44 -0700 (PDT)
Received: from [192.168.223.227] ([75.147.178.105])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6bd7eeebcsm36863145ad.250.2024.06.07.10.28.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jun 2024 10:28:43 -0700 (PDT)
Message-ID: <d331bf57-9d2a-480e-8af5-a4715fcd28f1@linaro.org>
Date: Fri, 7 Jun 2024 10:28:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] Convert x86_mmu_translate() to use common code.
To: Don Porter <porter@cs.unc.edu>, qemu-devel@nongnu.org
Cc: dave@treblig.org, peter.maydell@linaro.org, nadav.amit@gmail.com,
 philmd@linaro.org
References: <20240606140253.2277760-1-porter@cs.unc.edu>
 <20240606140253.2277760-7-porter@cs.unc.edu>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240606140253.2277760-7-porter@cs.unc.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/6/24 07:02, Don Porter wrote:
> Signed-off-by: Don Porter <porter@cs.unc.edu>
> ---
>   target/i386/arch_memory_mapping.c    |  44 +++-
>   target/i386/cpu.h                    |   5 +-
>   target/i386/helper.c                 | 374 +++++++--------------------
>   target/i386/tcg/sysemu/excp_helper.c |   2 +-
>   4 files changed, 129 insertions(+), 296 deletions(-)
> 
> diff --git a/target/i386/arch_memory_mapping.c b/target/i386/arch_memory_mapping.c
> index b52e98133c..bccd290b9f 100644
> --- a/target/i386/arch_memory_mapping.c
> +++ b/target/i386/arch_memory_mapping.c
> @@ -228,9 +228,38 @@ static void _mmu_decode_va_parameters(CPUState *cs, int height,
>   }
>   
>   /**
> - * get_pte - Copy the contents of the page table entry at node[i] into pt_entry.
> - *           Optionally, add the relevant bits to the virtual address in
> - *           vaddr_pte.
> + * x86_virtual_to_pte_index - Given a virtual address and height in
> + *       the page table radix tree, return the index that should be
> + *       used to look up the next page table entry (pte) in
> + *       translating an address.
> + *
> + * @cs - CPU state
> + * @vaddr - The virtual address to translate
> + * @height - height of node within the tree (leaves are 1, not 0).
> + *
> + * Example: In 32-bit x86 page tables, the virtual address is split
> + * into 10 bits at height 2, 10 bits at height 1, and 12 offset bits.
> + * So a call with VA and height 2 would return the first 10 bits of va,
> + * right shifted by 22.
> + */
> +
> +int x86_virtual_to_pte_index(CPUState *cs, target_ulong vaddr, int height)
> +{
> +    int shift = 0;
> +    int width = 0;
> +    int mask = 0;
> +
> +    _mmu_decode_va_parameters(cs, height, &shift, &width);
> +
> +    mask = (1 << width) - 1;
> +
> +    return (vaddr >> shift) & mask;
> +}
> +
> +/**
> + * x86_get_pte - Copy the contents of the page table entry at node[i]
> + *               into pt_entry.  Optionally, add the relevant bits to
> + *               the virtual address in vaddr_pte.
>    *
>    * @cs - CPU state
>    * @node - physical address of the current page table node
> @@ -249,7 +278,6 @@ void
>   x86_get_pte(CPUState *cs, hwaddr node, int i, int height,
>               PTE_t *pt_entry, vaddr vaddr_parent, vaddr *vaddr_pte,
>               hwaddr *pte_paddr)
> -
>   {
>       X86CPU *cpu = X86_CPU(cs);
>       CPUX86State *env = &cpu->env;

Some fixes to be merged back into previous patches.


> --- a/target/i386/helper.c
> +++ b/target/i386/helper.c
> @@ -308,7 +308,8 @@ static bool ptw_translate(X86PTETranslate *inout, hwaddr addr, uint64_t ra)
>   
>   static bool x86_mmu_translate(CPUX86State *env, const X86TranslateParams *in,
>                                 X86TranslateResult *out,
> -                              X86TranslateFault *err, uint64_t ra)
> +                              X86TranslateFault *err, uint64_t ra,
> +                              bool read_only)
>   {
>       const target_ulong addr = in->addr;
>       const int pg_mode = in->pg_mode;
> @@ -324,6 +325,10 @@ static bool x86_mmu_translate(CPUX86State *env, const X86TranslateParams *in,
>       uint32_t pkr;
>       int page_size;
>       int error_code;
> +    CPUState *cs = env_cpu(env);
> +    int height;
> +    bool pae_enabled = env->cr[4] & CR4_PAE_MASK;
> +    bool long_mode_enabled = env->hflags & HF_LMA_MASK;

Incorrect.  These bits are in pg_mode...

> -    if (pg_mode & PG_MODE_PAE) {
> -#ifdef TARGET_X86_64
> -        if (pg_mode & PG_MODE_LMA) {
> -            if (pg_mode & PG_MODE_LA57) {

... like so.

> +    /*
> +     * ptep is really an accumulator for the permission bits.
> +     * Thus, the xor-ing totally trashes the high bits, and that is
> +     * ok - we only care about the low ones.
> +     */
> +    ptep = PG_NX_MASK | PG_USER_MASK | PG_RW_MASK;
> +    hwaddr pt_node = x86_page_table_root(cs, &height);
>   
> +    /* Special case for PAE paging */
> +    if (height == 3 && pg_mode & PG_MODE_PAE) {
> +        rsvd_mask |= PG_HI_USER_MASK;
> +    }
>   
> +    int i = height;
> +    do {
> +        int index = x86_virtual_to_pte_index(cs, addr, i);
> +        PTE_t pt_entry;
> +        uint64_t my_rsvd_mask = rsvd_mask;
> +
> +        x86_get_pte(cs, pt_node, index, i, &pt_entry, 0, NULL, &pte_addr);
> +        /* Check that we can access the page table entry */
>           if (!ptw_translate(&pte_trans, pte_addr, ra)) {
>               return false;
>           }

You "get" the pte and only afterward you check that it is accessible.
I think you've missed the point of ptw_translate.


> +
> +    restart:
> +        if (!x86_pte_present(cs, &pt_entry)) {
>               goto do_fault;
>           }
>   
> +        /* For height > 3, check and reject PSE mask */
> +        if (i > 3) {
> +            my_rsvd_mask |= PG_PSE_MASK;
>           }
> +
> +        if (x86_pte_check_bits(cs, &pt_entry, my_rsvd_mask)) {
>               goto do_fault_rsvd;
>           }

Surely the reserved bit checking should be part of the generic walker.
Is there some reason those should be ignored for "info pg", for example?

> +        if (long_mode_enabled) {
> +            pte = pt_entry.pte64_t;
> +        } else {
> +            pte = pt_entry.pte32_t;
>           }

This is pretty ugly.  Ignoring 128-bit ptes for the moment, surely we should just 
zero-extend 32-bit ptes into the 64-bit entry data slot right from the start.

> +            break; /* goto do_check_protect; */

What's with the comment.

> +        if ((!read_only) &&
> +            (!ptw_setl(&pte_trans, pte, PG_ACCESSED_MASK))) {

Again with the extra ().


r~

