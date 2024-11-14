Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1BABD6A221
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 18:59:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBeyR-00084T-0T; Thu, 14 Nov 2024 13:53:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBeyN-0007xU-W8
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:53:44 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBeyM-0007aB-5n
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:53:43 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7242f559a9fso949980b3a.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 10:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731610421; x=1732215221; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8I9i6XLZex+ricmPPZ4wirJMXyJDAZP2Gd0sZ17DbZA=;
 b=vx+oIHSfjOJVtXpWCXUA+GCYG7qqvpxIWA5YNHF+DnCs4l2ioWR0wJ3UYpx9cIyRgO
 7K+cjc5ed3KiUzx0Wsj3iDfUOuEHSoi0XvsHXEvRpP03AaWi5MZgBXewqYpN3L9sQHjC
 SJ9HlQ9/kIXzGRehHyETuGpG4kUT0Bu9VUetK2y7g4vZxcUpwRaia0Mm5SCMD0EaNliO
 +hQyBDMF3ps6cWpZGtInvPdbkB4vUSdKe2Z2NQOPU2KVMW+ZSrL0wRqiJep1MNJ4e9D4
 QCqOH/FVsXxxu/Yx/wHp1nykjtptMmfNB1b4ztU9maMe+YP8GuNg2mLPzYMgOm30ypFm
 9RVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731610421; x=1732215221;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8I9i6XLZex+ricmPPZ4wirJMXyJDAZP2Gd0sZ17DbZA=;
 b=vgsxQTdKroHKrQp9qzeCWxyCVM6+n8Z+lXlJ3wH5Fa/CfaVm/m0z1XmfHiGBsxP+Yk
 vwtvyGLrdcuxzR7bWfZdBkzlLWItlh4HPMf2PX8dLRjc2vgkPPDeH0Fdk9/2Ju43RaBa
 Tl0owRj6fPVWgbQhYjzackCvAYpQ+TBZeIh4t6SFUZas6g13MBPcQgCYQKcWJVk08jal
 Bl0DJbALJFyHcidFhouV7NFA8lCM4CrH51LzYietSyG0zZg3feJwX696wYU5h23PivWq
 NRUbcs2l2kMqjJppvQ5qv7R2nbMl0akJkXTY/zMIYTVi7JxVD5IimC80Hl5NSCoqbx7j
 IQSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlH9aWjpjeMZx0ahLw0v4sB1MYFVF9SBTm+0AMOfczADbXxSx+VNk3B1hMimlA4ql3woeu+IyEZwCl@nongnu.org
X-Gm-Message-State: AOJu0YxzslJDhBUV8Imtn573bq8zP+Y8M+MqpJ8UwkxGgH67ziWd8qGd
 dg3hqcmwsfmGiSGgRS3hSrQ1XUwQeRnDIE0WgETsm7BxQarpqCHoiR8+1FI6VrqMO9qD07qIrxN
 p5LAglQ==
X-Google-Smtp-Source: AGHT+IEkBB0sKTPFYiDQIvxrFwd+DrY1hwf0Vr/njzj+IAe/3JjVYFGOG9FqroScOXU2vBuxk+efiA==
X-Received: by 2002:aa7:8882:0:b0:71e:6c67:2ebf with SMTP id
 d2e1a72fcca58-724132bff58mr31418716b3a.11.1731610420746; 
 Thu, 14 Nov 2024 10:53:40 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7246a5ceda0sm1592394b3a.1.2024.11.14.10.53.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 10:53:40 -0800 (PST)
Message-ID: <c1a4fe45-cdd8-4c3f-93e5-f18067a36233@linaro.org>
Date: Thu, 14 Nov 2024 10:53:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 38/54] target/m68k: Convert to TCGCPUOps.tlb_fill_align
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241114160131.48616-1-richard.henderson@linaro.org>
 <20241114160131.48616-39-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114160131.48616-39-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
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
>   target/m68k/cpu.h    |  7 ++++---
>   target/m68k/cpu.c    |  2 +-
>   target/m68k/helper.c | 22 +++++++++++++---------
>   3 files changed, 18 insertions(+), 13 deletions(-)
> 
> diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
> index b5bbeedb7a..4401426a0b 100644
> --- a/target/m68k/cpu.h
> +++ b/target/m68k/cpu.h
> @@ -22,6 +22,7 @@
>   #define M68K_CPU_H
>   
>   #include "exec/cpu-defs.h"
> +#include "exec/memop.h"
>   #include "qemu/cpu-float.h"
>   #include "cpu-qom.h"
>   
> @@ -582,10 +583,10 @@ enum {
>   #define MMU_KERNEL_IDX 0
>   #define MMU_USER_IDX 1
>   
> -bool m68k_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> -                       MMUAccessType access_type, int mmu_idx,
> -                       bool probe, uintptr_t retaddr);
>   #ifndef CONFIG_USER_ONLY
> +bool m68k_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out, vaddr addr,
> +                             MMUAccessType access_type, int mmu_idx,
> +                             MemOp memop, int size, bool probe, uintptr_t ra);
>   void m68k_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
>                                    unsigned size, MMUAccessType access_type,
>                                    int mmu_idx, MemTxAttrs attrs,
> diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
> index 5fe335558a..5316cf8922 100644
> --- a/target/m68k/cpu.c
> +++ b/target/m68k/cpu.c
> @@ -550,7 +550,7 @@ static const TCGCPUOps m68k_tcg_ops = {
>       .restore_state_to_opc = m68k_restore_state_to_opc,
>   
>   #ifndef CONFIG_USER_ONLY
> -    .tlb_fill = m68k_cpu_tlb_fill,
> +    .tlb_fill_align = m68k_cpu_tlb_fill_align,
>       .cpu_exec_interrupt = m68k_cpu_exec_interrupt,
>       .cpu_exec_halt = m68k_cpu_has_work,
>       .do_interrupt = m68k_cpu_do_interrupt,
> diff --git a/target/m68k/helper.c b/target/m68k/helper.c
> index 9bfc6ae97c..1decb6f39c 100644
> --- a/target/m68k/helper.c
> +++ b/target/m68k/helper.c
> @@ -950,9 +950,10 @@ void m68k_set_irq_level(M68kCPU *cpu, int level, uint8_t vector)
>       }
>   }
>   
> -bool m68k_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> -                       MMUAccessType qemu_access_type, int mmu_idx,
> -                       bool probe, uintptr_t retaddr)
> +bool m68k_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out,
> +                             vaddr address, MMUAccessType qemu_access_type,
> +                             int mmu_idx, MemOp memop, int size,
> +                             bool probe, uintptr_t retaddr)
>   {
>       CPUM68KState *env = cpu_env(cs);
>       hwaddr physical;
> @@ -961,12 +962,14 @@ bool m68k_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>       int ret;
>       target_ulong page_size;
>   
> +    memset(out, 0, sizeof(*out));
> +    out->attrs = MEMTXATTRS_UNSPECIFIED;
> +
>       if ((env->mmu.tcr & M68K_TCR_ENABLED) == 0) {
>           /* MMU disabled */
> -        tlb_set_page(cs, address & TARGET_PAGE_MASK,
> -                     address & TARGET_PAGE_MASK,
> -                     PAGE_READ | PAGE_WRITE | PAGE_EXEC,
> -                     mmu_idx, TARGET_PAGE_SIZE);
> +        out->phys_addr = address;
> +        out->prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
> +        out->lg_page_size = TARGET_PAGE_BITS;
>           return true;
>       }
>   
> @@ -985,8 +988,9 @@ bool m68k_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>       ret = get_physical_address(env, &physical, &prot,
>                                  address, access_type, &page_size);
>       if (likely(ret == 0)) {
> -        tlb_set_page(cs, address & TARGET_PAGE_MASK,
> -                     physical & TARGET_PAGE_MASK, prot, mmu_idx, page_size);
> +        out->phys_addr = physical;
> +        out->prot = prot;
> +        out->lg_page_size = ctz32(page_size);
>           return true;
>       }
>   

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


