Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 351DAD6A221
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 18:55:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBez6-0001KW-1y; Thu, 14 Nov 2024 13:54:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBeyp-00018a-Q2
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:54:12 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBeyf-000812-NQ
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:54:11 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-720d5ada03cso883252b3a.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 10:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731610440; x=1732215240; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FM6BogwlYmVNulP09u5smdsnPirk6PRaKczBu4gYi2c=;
 b=CjcYj6ZDfx56BUWXcVoMn7U0C/n0nSfUM++K3yPCD58/QfDU09ZtGFw3NYVjWR3sdW
 DOhY5O13bYSFxAUG8YTiRgiNudUR1FyDbyx4EhKOH7BVPKN5GWJmErc4ornHdCFHCbjL
 IT9eljzsICDmmsWM+y9Vcg0INVnNgmr7YS0/uhfaMJTP+d4xkywQWuQUaa3gnKnjHcce
 nL8UnJ8VWEJLf4ppcA25vyBMNKHJCAFo7cPBSJEgjfRgjIv5tRwhn3tBF3JqgqvxrsuI
 uEJu7gtXTc5F+LpAjYcpZGX2ta7fdOwMd+f3Yq/MCjNSjZUjgs5HRObCQ/MRzeJIfsUF
 s8Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731610440; x=1732215240;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FM6BogwlYmVNulP09u5smdsnPirk6PRaKczBu4gYi2c=;
 b=Nah2lOAH3+NTSjYl6Sr+Vv2ReXavwmmVHOhwfJe8c4gN+loTpzwGUQaEkoBDJwps45
 MyhkqZzl6R+NztVtHClxYgw77lYTX9ewU2NlNwOmtrkyQvjq6Rn0Y7V+yX8X+gm27hUg
 spOfgKDwbaSCKBE6rWEr801jJq033fVvBgQMgxCyz3lA7L0FZG07xW2dHzPRz7go0aaV
 icD0QAY+9O2fjtai3Q1yGywWqil6kLeaKgZqWrdruvUgwAaf90IrUZV4TWWkixS+/KWe
 6z6xq1gEvbKTSToo7aUCspJ0DYDNFxynMzQ3cNONqatTZU6fYqQxIfEyaSEVZVAPTrbY
 Ey3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgOCMrbkgnfjdi62oNwc/P2+MrwUtjFyuJzUGJ1eeMW32aqiEPmD1TJZRwIf9279brsuMD/KTp69N2@nongnu.org
X-Gm-Message-State: AOJu0YwsbXYHXIYOubdEVTLe1ZhfCj0OlrDFKxe0tG7uvTwIEo/lSkpv
 dP4LBDscapdtsERpMYMUzyLbq/RGou9D0U/AA2iDckEAeu9zpl6A/2hfEd6Phj8=
X-Google-Smtp-Source: AGHT+IGDA7sEJGKueFIBVrd+fKsYAaOPfdB3URKSd3uv8z8jfrcX8BgkHfaXtccPbFJ55Q1tEweV9Q==
X-Received: by 2002:a05:6a00:a88:b0:71e:4296:2e with SMTP id
 d2e1a72fcca58-724579bb792mr8643169b3a.11.1731610440221; 
 Thu, 14 Nov 2024 10:54:00 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7246a5ceda0sm1592394b3a.1.2024.11.14.10.53.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 10:53:59 -0800 (PST)
Message-ID: <4d2feb7d-b77f-492e-9d08-6bb684b65523@linaro.org>
Date: Thu, 14 Nov 2024 10:53:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 43/54] target/ppc: Convert to TCGCPUOps.tlb_fill_align
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241114160131.48616-1-richard.henderson@linaro.org>
 <20241114160131.48616-44-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114160131.48616-44-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/ppc/internal.h   |  7 ++++---
>   target/ppc/cpu_init.c   |  2 +-
>   target/ppc/mmu_helper.c | 21 ++++++++++++++++-----
>   3 files changed, 21 insertions(+), 9 deletions(-)
> 
> diff --git a/target/ppc/internal.h b/target/ppc/internal.h
> index 20fb2ec593..9d132d35a1 100644
> --- a/target/ppc/internal.h
> +++ b/target/ppc/internal.h
> @@ -273,9 +273,10 @@ void ppc_cpu_record_sigsegv(CPUState *cs, vaddr addr,
>                               MMUAccessType access_type,
>                               bool maperr, uintptr_t ra);
>   #else
> -bool ppc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> -                      MMUAccessType access_type, int mmu_idx,
> -                      bool probe, uintptr_t retaddr);
> +bool ppc_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out,
> +                            vaddr addr, MMUAccessType access_type,
> +                            int mmu_idx, MemOp memop, int size,
> +                            bool probe, uintptr_t ra);
>   G_NORETURN void ppc_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
>                                               MMUAccessType access_type, int mmu_idx,
>                                               uintptr_t retaddr);
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index efcb80d1c2..387c7ff2da 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -7422,7 +7422,7 @@ static const TCGCPUOps ppc_tcg_ops = {
>   #ifdef CONFIG_USER_ONLY
>     .record_sigsegv = ppc_cpu_record_sigsegv,
>   #else
> -  .tlb_fill = ppc_cpu_tlb_fill,
> +  .tlb_fill_align = ppc_cpu_tlb_fill_align,
>     .cpu_exec_interrupt = ppc_cpu_exec_interrupt,
>     .cpu_exec_halt = ppc_cpu_has_work,
>     .do_interrupt = ppc_cpu_do_interrupt,
> diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
> index b167b37e0a..bf98e0efb0 100644
> --- a/target/ppc/mmu_helper.c
> +++ b/target/ppc/mmu_helper.c
> @@ -1357,18 +1357,29 @@ void helper_check_tlb_flush_global(CPUPPCState *env)
>   }
>   
>   
> -bool ppc_cpu_tlb_fill(CPUState *cs, vaddr eaddr, int size,
> -                      MMUAccessType access_type, int mmu_idx,
> -                      bool probe, uintptr_t retaddr)
> +bool ppc_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out,
> +                            vaddr eaddr, MMUAccessType access_type,
> +                            int mmu_idx, MemOp memop, int size,
> +                            bool probe, uintptr_t retaddr)
>   {
>       PowerPCCPU *cpu = POWERPC_CPU(cs);
>       hwaddr raddr;
>       int page_size, prot;
>   
> +    if (eaddr & ((1 << memop_alignment_bits(memop)) - 1)) {
> +        if (probe) {
> +            return false;
> +        }
> +        ppc_cpu_do_unaligned_access(cs, eaddr, access_type, mmu_idx, retaddr);
> +    }
> +
>       if (ppc_xlate(cpu, eaddr, access_type, &raddr,
>                     &page_size, &prot, mmu_idx, !probe)) {
> -        tlb_set_page(cs, eaddr & TARGET_PAGE_MASK, raddr & TARGET_PAGE_MASK,
> -                     prot, mmu_idx, 1UL << page_size);
> +        memset(out, 0, sizeof(*out));
> +        out->phys_addr = raddr;
> +        out->prot = prot;
> +        out->lg_page_size = page_size;
> +        out->attrs = MEMTXATTRS_UNSPECIFIED;
>           return true;
>       }
>       if (probe) {

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


