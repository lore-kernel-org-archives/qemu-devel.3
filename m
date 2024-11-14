Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B62EDD6A228
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 18:56:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBf0S-0002pM-B8; Thu, 14 Nov 2024 13:55:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBezB-0001RD-1u
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:54:38 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBez5-0008NM-HL
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:54:31 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-20ca1b6a80aso10975955ad.2
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 10:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731610459; x=1732215259; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0aaoGu2ZCGt7U475c99V7+OyHHM6z24drOb8FT1J6e8=;
 b=hG7pbCtDQEyVU6NyTHj41WLtGY9JJXBgWyUHzWl2eA8riWow4Mu2a3J01iYJymLH8Y
 UvZiOSVyeB4tki1AQTNCpwo1htoiiogy+yp8txS8nmH70hDRl3C0enaxAJVd5nsV16Ag
 nlPjX8ttajuAkvDkH3EO6U9MOY+33hOxtcT/FuQ4nfZ9VWGQ0jdr/eq/TGl7RFZON+2Q
 Xe/7VELvkz5RaCX3k710ROx42me2GFxUH/TkjvWg1/EH3YdHUGOE+vnJ6MoHmV5HaEVw
 YI4ufcXdnIl6uyEDBYI4SOSaqjOyG46hmZTul8umK3SI/OHFQD3rE9UZ9y2jNRgoAWQg
 9QGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731610459; x=1732215259;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0aaoGu2ZCGt7U475c99V7+OyHHM6z24drOb8FT1J6e8=;
 b=rwA14GhldMclyy4osYZ35NW7xcnLEYLOrVKlzEaDRLhVnrSz6a1LyPuwNtQa18o1x0
 rufwIcBK81y19ySiGOOyzqfVY+H0x6c0lysuoAKg5fDtA51RPf0++EEVn5iD+DUVr4tq
 78eOJ2nKdliEGIzXoo6Y2Mo3PJwAPosRfLxs92pDbQvclxEr3seCsQpEUMXDib0X33QF
 PzGBXF3NILn0hlPxCYqU1HilaR4iYZqucl/hJh0l88/kinZgnuLRL2AoLHX5ITsDrMOj
 HEnD6a8GIBWFtfVMHPAIzbQFze6HFiKTBLMowCi7j8YQ0QYt50jdN8SxwpcIIcCoC6HO
 JOxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWg0TZKtntJXstlnmOi0KdbuRCeVolkp0iOShzycnL5buHk/guw+HcpaqSKA5LKA1QA48tHlCFXOCAr@nongnu.org
X-Gm-Message-State: AOJu0YxwJhgCJ4dHmOiFMLbfP+lC35DlTug+lkYc7eSQFkMhxu/fj1oo
 ukVTfF5UN/jDk6Co/RDgxvJKJSQJmYYFIrKC6ZjtMS6ElodAU22bLeTx/1tRbtg=
X-Google-Smtp-Source: AGHT+IFkexBjOUni71EzcnArozhOUFx5mJj5jF18/ohq64T0IqFaxF8F3xVDP6csNyzGj0Y4kBcstg==
X-Received: by 2002:a17:902:ebc6:b0:20c:b485:eda3 with SMTP id
 d9443c01a7336-211c4feb134mr33886005ad.20.1731610458879; 
 Thu, 14 Nov 2024 10:54:18 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211c7c49d7bsm13981345ad.72.2024.11.14.10.54.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 10:54:18 -0800 (PST)
Message-ID: <5a4747da-7360-4c2c-af47-920d69b68d4e@linaro.org>
Date: Thu, 14 Nov 2024 10:54:17 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 46/54] target/s390x: Convert to TCGCPUOps.tlb_fill_align
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241114160131.48616-1-richard.henderson@linaro.org>
 <20241114160131.48616-47-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114160131.48616-47-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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
>   target/s390x/s390x-internal.h  |  7 ++++---
>   target/s390x/cpu.c             |  4 ++--
>   target/s390x/tcg/excp_helper.c | 23 ++++++++++++++++++-----
>   3 files changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/target/s390x/s390x-internal.h b/target/s390x/s390x-internal.h
> index 825252d728..eb6fe24c9a 100644
> --- a/target/s390x/s390x-internal.h
> +++ b/target/s390x/s390x-internal.h
> @@ -278,9 +278,10 @@ void s390_cpu_record_sigsegv(CPUState *cs, vaddr address,
>   void s390_cpu_record_sigbus(CPUState *cs, vaddr address,
>                               MMUAccessType access_type, uintptr_t retaddr);
>   #else
> -bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> -                       MMUAccessType access_type, int mmu_idx,
> -                       bool probe, uintptr_t retaddr);
> +bool s390x_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out,
> +                              vaddr addr, MMUAccessType access_type,
> +                              int mmu_idx, MemOp memop, int size,
> +                              bool probe, uintptr_t retaddr);
>   G_NORETURN void s390x_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
>                                                 MMUAccessType access_type, int mmu_idx,
>                                                 uintptr_t retaddr);
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index 514c70f301..4d0eb129e3 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -330,7 +330,7 @@ void cpu_get_tb_cpu_state(CPUS390XState *env, vaddr *pc,
>            * Instructions must be at even addresses.
>            * This needs to be checked before address translation.
>            */
> -        env->int_pgm_ilen = 2; /* see s390_cpu_tlb_fill() */
> +        env->int_pgm_ilen = 2; /* see s390x_cpu_tlb_fill_align() */
>           tcg_s390_program_interrupt(env, PGM_SPECIFICATION, 0);
>       }
>   
> @@ -364,7 +364,7 @@ static const TCGCPUOps s390_tcg_ops = {
>       .record_sigsegv = s390_cpu_record_sigsegv,
>       .record_sigbus = s390_cpu_record_sigbus,
>   #else
> -    .tlb_fill = s390_cpu_tlb_fill,
> +    .tlb_fill_align = s390x_cpu_tlb_fill_align,
>       .cpu_exec_interrupt = s390_cpu_exec_interrupt,
>       .cpu_exec_halt = s390_cpu_has_work,
>       .do_interrupt = s390_cpu_do_interrupt,
> diff --git a/target/s390x/tcg/excp_helper.c b/target/s390x/tcg/excp_helper.c
> index 4c0b692c9e..6d61032a4a 100644
> --- a/target/s390x/tcg/excp_helper.c
> +++ b/target/s390x/tcg/excp_helper.c
> @@ -139,9 +139,10 @@ static inline uint64_t cpu_mmu_idx_to_asc(int mmu_idx)
>       }
>   }
>   
> -bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> -                       MMUAccessType access_type, int mmu_idx,
> -                       bool probe, uintptr_t retaddr)
> +bool s390x_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out,
> +                              vaddr address, MMUAccessType access_type,
> +                              int mmu_idx, MemOp memop, int size,
> +                              bool probe, uintptr_t retaddr)
>   {
>       CPUS390XState *env = cpu_env(cs);
>       target_ulong vaddr, raddr;
> @@ -151,6 +152,14 @@ bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>       qemu_log_mask(CPU_LOG_MMU, "%s: addr 0x%" VADDR_PRIx " rw %d mmu_idx %d\n",
>                     __func__, address, access_type, mmu_idx);
>   
> +    if (address & ((1 << memop_alignment_bits(memop)) - 1)) {
> +        if (probe) {
> +            return false;
> +        }
> +        s390x_cpu_do_unaligned_access(cs, address, access_type,
> +                                      mmu_idx, retaddr);
> +    }
> +
>       vaddr = address;
>   
>       if (mmu_idx < MMU_REAL_IDX) {
> @@ -177,8 +186,12 @@ bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>           qemu_log_mask(CPU_LOG_MMU,
>                         "%s: set tlb %" PRIx64 " -> %" PRIx64 " (%x)\n",
>                         __func__, (uint64_t)vaddr, (uint64_t)raddr, prot);
> -        tlb_set_page(cs, address & TARGET_PAGE_MASK, raddr, prot,
> -                     mmu_idx, TARGET_PAGE_SIZE);
> +
> +        memset(out, 0, sizeof(*out));
> +        out->phys_addr = raddr;
> +        out->prot = prot;
> +        out->lg_page_size = TARGET_PAGE_BITS;
> +        out->attrs = MEMTXATTRS_UNSPECIFIED;
>           return true;
>       }
>       if (probe) {

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


