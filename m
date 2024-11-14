Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A96D6A226
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 18:56:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBf0m-0003O6-Ja; Thu, 14 Nov 2024 13:56:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBezN-0001ZS-U5
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:54:52 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBezE-0008Q3-Er
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:54:39 -0500
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-7f12ba78072so798518a12.2
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 10:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731610472; x=1732215272; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RGS72YEF8J8rfAgIqQbA3X2/cWpgXHmuuEO3D5wNClM=;
 b=iRIThU/3enmlakCvjn1U+B65l0DLqXr9eREYCv8UORdCYEkF+4/M1RfRx2L7K22Lu6
 8EDHvKBB1njlpjtgzo3pfXaa/JPwlqTF6gEHXAvNyM4uCs+xGA7i6FZRt/KcDBBIGDN3
 jQEeOhQ2s18FbMOZpqOtvcLWnF7xrARidBERSDgr7SQO3DqcqCDVV/dsM4gsvZY0Bt7t
 DOUJtNdZjy2+FRwXwCIQ2RGc0+Yfhh9bVtOtdoAPRJz/sl2cb/1/n7RHZ7kMkXa8W+iP
 mMlwOxaCRdDcl9qTey/zuvizkgI0+iJ/cHbq5nJDcNijO3T9DPdC0gC3RHJPFpyB6twW
 M0QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731610472; x=1732215272;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RGS72YEF8J8rfAgIqQbA3X2/cWpgXHmuuEO3D5wNClM=;
 b=PuuV2HUgyr1JML6apTnZIjLOWo2R1MxqfVhfjHpZYu+DQhaxSe1RluEI+rTHlk1wu+
 9PdZQoJbgfDuQdL9+aMuqo1JKenbVfcidtJEUhCjLALmDeizLMbwpHtW1uNKAKy9W+U+
 LJ3xmodrQPu+LNF7+CkjyObuKEFjNM7BDbkeboRmlJM7MkgWdU0GrldQz9qcbAyfkRlB
 GQoorOtsFmfN/WluNx0Pad3cYQdKCnjJQ0Sc0DsyZ7FjqMfK9ih1uGISKSJnWniha/9e
 JkqcAYdm2S0WLxKeq0YbkLNxmnWt7Za3IRIH5ERi74ZMNe0UjQ3EWk4XAG0n9bB+oqgL
 muMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXH5oUG6GovZ8njZ8DtlsKPRyX7GW3sF9YxNlOcD6rjtFQ601k24KxgU3Fxi6ediFEoaPXLiOynr1ea@nongnu.org
X-Gm-Message-State: AOJu0YyZx7ZFu9/rit1g0qpp2PDmsiLSM5G4hFg3H7sE7eSEkffVl2bh
 6HPajSUlTV9Mf5c0x++3HA4mjBLu/hb0J2dvKT5boXUd72rvKKDeBaxHmhMYgY4=
X-Google-Smtp-Source: AGHT+IFXoShFHqBYZ4fuhORDQsEjqs808nLltfX3nms3kKWSPPfpFpaj9DVBndvzxD1tVUTZkVA3Cg==
X-Received: by 2002:a05:6a20:258e:b0:1dc:792f:d274 with SMTP id
 adf61e73a8af0-1dc792fd5d2mr7387008637.17.1731610472154; 
 Thu, 14 Nov 2024 10:54:32 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7246a9bbb17sm1590345b3a.168.2024.11.14.10.54.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 10:54:31 -0800 (PST)
Message-ID: <b62678d5-59e2-44aa-a09a-5fc3960e20c1@linaro.org>
Date: Thu, 14 Nov 2024 10:54:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 48/54] target/sparc: Convert to TCGCPUOps.tlb_fill_align
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241114160131.48616-1-richard.henderson@linaro.org>
 <20241114160131.48616-49-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114160131.48616-49-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x531.google.com
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
>   target/sparc/cpu.h        |  8 ++++---
>   target/sparc/cpu.c        |  2 +-
>   target/sparc/mmu_helper.c | 44 +++++++++++++++++++++++++--------------
>   3 files changed, 34 insertions(+), 20 deletions(-)
> 
> diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
> index f517e5a383..4c8927e9fa 100644
> --- a/target/sparc/cpu.h
> +++ b/target/sparc/cpu.h
> @@ -4,6 +4,7 @@
>   #include "qemu/bswap.h"
>   #include "cpu-qom.h"
>   #include "exec/cpu-defs.h"
> +#include "exec/memop.h"
>   #include "qemu/cpu-float.h"
>   
>   #if !defined(TARGET_SPARC64)
> @@ -596,9 +597,10 @@ G_NORETURN void cpu_raise_exception_ra(CPUSPARCState *, int, uintptr_t);
>   void cpu_sparc_set_id(CPUSPARCState *env, unsigned int cpu);
>   void sparc_cpu_list(void);
>   /* mmu_helper.c */
> -bool sparc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> -                        MMUAccessType access_type, int mmu_idx,
> -                        bool probe, uintptr_t retaddr);
> +bool sparc_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out,
> +                              vaddr addr, MMUAccessType access_type,
> +                              int mmu_idx, MemOp memop, int size,
> +                              bool probe, uintptr_t retaddr);
>   target_ulong mmu_probe(CPUSPARCState *env, target_ulong address, int mmulev);
>   void dump_mmu(CPUSPARCState *env);
>   
> diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
> index dd7af86de7..57ae53bd71 100644
> --- a/target/sparc/cpu.c
> +++ b/target/sparc/cpu.c
> @@ -932,7 +932,7 @@ static const TCGCPUOps sparc_tcg_ops = {
>       .restore_state_to_opc = sparc_restore_state_to_opc,
>   
>   #ifndef CONFIG_USER_ONLY
> -    .tlb_fill = sparc_cpu_tlb_fill,
> +    .tlb_fill_align = sparc_cpu_tlb_fill_align,
>       .cpu_exec_interrupt = sparc_cpu_exec_interrupt,
>       .cpu_exec_halt = sparc_cpu_has_work,
>       .do_interrupt = sparc_cpu_do_interrupt,
> diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
> index 9ff06026b8..32766a37d6 100644
> --- a/target/sparc/mmu_helper.c
> +++ b/target/sparc/mmu_helper.c
> @@ -203,12 +203,12 @@ static int get_physical_address(CPUSPARCState *env, CPUTLBEntryFull *full,
>   }
>   
>   /* Perform address translation */
> -bool sparc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> -                        MMUAccessType access_type, int mmu_idx,
> -                        bool probe, uintptr_t retaddr)
> +bool sparc_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out,
> +                              vaddr address, MMUAccessType access_type,
> +                              int mmu_idx, MemOp memop, int size,
> +                              bool probe, uintptr_t retaddr)
>   {
>       CPUSPARCState *env = cpu_env(cs);
> -    CPUTLBEntryFull full = {};
>       target_ulong vaddr;
>       int error_code = 0, access_index;
>   
> @@ -220,16 +220,21 @@ bool sparc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>        */
>       assert(!probe);
>   
> +    if (address & ((1 << memop_alignment_bits(memop)) - 1)) {
> +        sparc_cpu_do_unaligned_access(cs, address, access_type,
> +                                      mmu_idx, retaddr);
> +    }
> +
> +    memset(out, 0, sizeof(*out));
>       address &= TARGET_PAGE_MASK;
> -    error_code = get_physical_address(env, &full, &access_index,
> +    error_code = get_physical_address(env, out, &access_index,
>                                         address, access_type, mmu_idx);
>       vaddr = address;
>       if (likely(error_code == 0)) {
>           qemu_log_mask(CPU_LOG_MMU,
>                         "Translate at %" VADDR_PRIx " -> "
>                         HWADDR_FMT_plx ", vaddr " TARGET_FMT_lx "\n",
> -                      address, full.phys_addr, vaddr);
> -        tlb_set_page_full(cs, mmu_idx, vaddr, &full);
> +                      address, out->phys_addr, vaddr);
>           return true;
>       }
>   
> @@ -244,8 +249,7 @@ bool sparc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>              permissions. If no mapping is available, redirect accesses to
>              neverland. Fake/overridden mappings will be flushed when
>              switching to normal mode. */
> -        full.prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
> -        tlb_set_page_full(cs, mmu_idx, vaddr, &full);
> +        out->prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
>           return true;
>       } else {
>           if (access_type == MMU_INST_FETCH) {
> @@ -754,22 +758,30 @@ static int get_physical_address(CPUSPARCState *env, CPUTLBEntryFull *full,
>   }
>   
>   /* Perform address translation */
> -bool sparc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> -                        MMUAccessType access_type, int mmu_idx,
> -                        bool probe, uintptr_t retaddr)
> +bool sparc_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out,
> +                              vaddr address, MMUAccessType access_type,
> +                              int mmu_idx, MemOp memop, int size,
> +                              bool probe, uintptr_t retaddr)
>   {
>       CPUSPARCState *env = cpu_env(cs);
> -    CPUTLBEntryFull full = {};
>       int error_code = 0, access_index;
>   
> +    if (address & ((1 << memop_alignment_bits(memop)) - 1)) {
> +        if (probe) {
> +            return false;
> +        }
> +        sparc_cpu_do_unaligned_access(cs, address, access_type,
> +                                      mmu_idx, retaddr);
> +    }
> +
> +    memset(out, 0, sizeof(*out));
>       address &= TARGET_PAGE_MASK;
> -    error_code = get_physical_address(env, &full, &access_index,
> +    error_code = get_physical_address(env, out, &access_index,
>                                         address, access_type, mmu_idx);
>       if (likely(error_code == 0)) {
> -        trace_mmu_helper_mmu_fault(address, full.phys_addr, mmu_idx, env->tl,
> +        trace_mmu_helper_mmu_fault(address, out->phys_addr, mmu_idx, env->tl,
>                                      env->dmmu.mmu_primary_context,
>                                      env->dmmu.mmu_secondary_context);
> -        tlb_set_page_full(cs, mmu_idx, address, &full);
>           return true;
>       }
>       if (probe) {

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


