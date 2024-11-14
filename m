Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9021CD6A226
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 18:56:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBf07-0002Fl-7P; Thu, 14 Nov 2024 13:55:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBez5-0001P3-T6
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:54:32 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBeyj-00087q-JW
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:54:15 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7e6cbf6cd1dso683995a12.3
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 10:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731610444; x=1732215244; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iE7Pa+DLzQuXQzdq30WtcdwTpoiRLO6397q7RiDB3TA=;
 b=FyxH4FGijroHiZt1VnhUtCt1z3JaE+UPaKPXtzvD3tbDr1jji85qIrXrjgKMDC82yM
 +0y1dfiSPcAnqusECRpVpouJcETv9TWkWBhDEdxjkNaEiI0qcFG4+1NBfKlhNV1eTkLl
 Y9dB0LNhgNJxrAbFnPrUK82xs5G4qWrBSOaW2ntw1EJV5TKA+ul4nGBZVV8LpP/SEcZo
 a0mKYYf1UeDPXjKYWHauRYX44+GNbApGEdnFbZ4W6Z3sG0OGYnuATngvelyrZi34/caa
 Z8euoqY4H7oTaWHWtRG/dmIM1RAebtAHjrTLe84bezel/zc/Wzj56WF2pHi1JC2QChOh
 8erA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731610444; x=1732215244;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iE7Pa+DLzQuXQzdq30WtcdwTpoiRLO6397q7RiDB3TA=;
 b=MZNf+dUAJtk8nN4rvXRZocjwulTRVwRE5yuw7PwPbO6khC5tE55+dYBot+ewgJHMuv
 AGUwbvIi/F5qcaX6gKPUL22mfhMq9y6JZR5Ktb06xY7bNBqe0yOdENtczpNu8/ePFEcI
 nUitpnuThG+mi06DagKApU2fPH+0ARxLHIugToyWl7ZJ+MKeWo5qITyvqlORnzV0U53B
 Z6UU5j9ioE5B1tlih7EUAzoboZYoMZf0fJPlvROckGQWJITfq9d0MLl+zOS/k6upwfG0
 ElAIHwSU7CB53oT9BTuM1V4xrTzWlgiXshyUGw8DSgfx4oqvKZrEl8KfHo2wP0J6lmlF
 IBZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzaCoxwbo63eWd1CbtUDkzrmoLZhG2MmzanYT34cwaJI1/5wRGEPguPhnS4gBSUYJ/nARiQFQ/o2qe@nongnu.org
X-Gm-Message-State: AOJu0Yy4b+1yWz4XmB5+LKSb3480zHdtZ5Be7EpXRowIGiG7HxncvkfX
 /0Kc4zX0wvjOVLID0ItxZWJN/ZV3i9U7gYkiEiRkgPGEpIEd3cGizwqMEL1j6Vs=
X-Google-Smtp-Source: AGHT+IEMFLnBsX5B3MZKmb/HCq6wL9Kfl6/FZMUM0ovY/KzWgp5p9zeTqKwOdZ0r2NGrR5hJG8A9yQ==
X-Received: by 2002:a05:6300:404:b0:1db:de11:8c30 with SMTP id
 adf61e73a8af0-1dc5f982edfmr11016614637.30.1731610443680; 
 Thu, 14 Nov 2024 10:54:03 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7246a5ceda0sm1592394b3a.1.2024.11.14.10.54.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 10:54:03 -0800 (PST)
Message-ID: <6e21718e-468c-4288-b7e8-e4eb43f2c581@linaro.org>
Date: Thu, 14 Nov 2024 10:54:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 44/54] target/riscv: Convert to TCGCPUOps.tlb_fill_align
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241114160131.48616-1-richard.henderson@linaro.org>
 <20241114160131.48616-45-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114160131.48616-45-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x535.google.com
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
>   target/riscv/cpu.h         |  8 +++++---
>   target/riscv/cpu_helper.c  | 22 +++++++++++++++++-----
>   target/riscv/tcg/tcg-cpu.c |  2 +-
>   3 files changed, 23 insertions(+), 9 deletions(-)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 284b112821..f97c4f3410 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -25,6 +25,7 @@
>   #include "hw/qdev-properties.h"
>   #include "exec/cpu-defs.h"
>   #include "exec/gdbstub.h"
> +#include "exec/memop.h"
>   #include "qemu/cpu-float.h"
>   #include "qom/object.h"
>   #include "qemu/int128.h"
> @@ -563,9 +564,10 @@ bool cpu_get_bcfien(CPURISCVState *env);
>   G_NORETURN void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
>                                                  MMUAccessType access_type,
>                                                  int mmu_idx, uintptr_t retaddr);
> -bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> -                        MMUAccessType access_type, int mmu_idx,
> -                        bool probe, uintptr_t retaddr);
> +bool riscv_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out,
> +                              vaddr addr, MMUAccessType access_type,
> +                              int mmu_idx, MemOp memop, int size,
> +                              bool probe, uintptr_t ra);
>   char *riscv_isa_string(RISCVCPU *cpu);
>   int riscv_cpu_max_xlen(RISCVCPUClass *mcc);
>   bool riscv_cpu_option_set(const char *optname);
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 0a3ead69ea..edb2edfc55 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1429,9 +1429,10 @@ static void pmu_tlb_fill_incr_ctr(RISCVCPU *cpu, MMUAccessType access_type)
>       riscv_pmu_incr_ctr(cpu, pmu_event_type);
>   }
>   
> -bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> -                        MMUAccessType access_type, int mmu_idx,
> -                        bool probe, uintptr_t retaddr)
> +bool riscv_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out,
> +                              vaddr address, MMUAccessType access_type,
> +                              int mmu_idx, MemOp memop, int size,
> +                              bool probe, uintptr_t retaddr)
>   {
>       RISCVCPU *cpu = RISCV_CPU(cs);
>       CPURISCVState *env = &cpu->env;
> @@ -1452,6 +1453,14 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>       qemu_log_mask(CPU_LOG_MMU, "%s ad %" VADDR_PRIx " rw %d mmu_idx %d\n",
>                     __func__, address, access_type, mmu_idx);
>   
> +    if (address & ((1 << memop_alignment_bits(memop)) - 1)) {
> +        if (probe) {
> +            return false;
> +        }
> +        riscv_cpu_do_unaligned_access(cs, address, access_type,
> +                                      mmu_idx, retaddr);
> +    }
> +
>       pmu_tlb_fill_incr_ctr(cpu, access_type);
>       if (two_stage_lookup) {
>           /* Two stage lookup */
> @@ -1544,8 +1553,11 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>       }
>   
>       if (ret == TRANSLATE_SUCCESS) {
> -        tlb_set_page(cs, address & ~(tlb_size - 1), pa & ~(tlb_size - 1),
> -                     prot, mmu_idx, tlb_size);
> +        memset(out, 0, sizeof(*out));
> +        out->phys_addr = pa;
> +        out->prot = prot;
> +        out->lg_page_size = ctz64(tlb_size);
> +        out->attrs = MEMTXATTRS_UNSPECIFIED;
>           return true;
>       } else if (probe) {
>           return false;
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index c62c221696..f3b436bb86 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -138,7 +138,7 @@ static const TCGCPUOps riscv_tcg_ops = {
>       .restore_state_to_opc = riscv_restore_state_to_opc,
>   
>   #ifndef CONFIG_USER_ONLY
> -    .tlb_fill = riscv_cpu_tlb_fill,
> +    .tlb_fill_align = riscv_cpu_tlb_fill_align,
>       .cpu_exec_interrupt = riscv_cpu_exec_interrupt,
>       .cpu_exec_halt = riscv_cpu_has_work,
>       .do_interrupt = riscv_cpu_do_interrupt,

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


