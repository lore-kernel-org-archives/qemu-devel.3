Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB6BD6A221
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 18:57:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBf0h-0003DS-EJ; Thu, 14 Nov 2024 13:56:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBezN-0001Yz-9l
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:54:50 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBezG-0008RK-8C
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:54:39 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-720be27db27so817884b3a.2
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 10:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731610477; x=1732215277; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AQeUqjwtLRZoSTT6x4e6sG2EHGdRGo80Nk8KU7pwNqQ=;
 b=AQu2YfWXRFhWyUIBHJOogQPuQzTHDWmcV3qEoHudHIc6FYwVEDhBsdN5IM1ufVxNZJ
 biZSqGlv45CTnPe6mbVuj/R45jLG9PSTshMcTX6zzb9n4jktvgc+QUCKfiOHuewR0SBj
 F3WAQuHtUWBSWwOAEkwHUJNcQEKsLATFEE07+/vEx4EM+Yy0BAwxV152eddC2sAYlYGk
 fhSxX0WvmvkRJwyQhzJoXoh3Jt/zuiJqZZVrRfFbsmlKD1HWnfIRpnwj9yqlhQY7bLuG
 mXx3iyGmTuU41v2U9EBJfYTQyYXtlMHyr8Q6yCrkZizzAq+NgIMVlx3bzCmgz3YIFG53
 ePsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731610477; x=1732215277;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AQeUqjwtLRZoSTT6x4e6sG2EHGdRGo80Nk8KU7pwNqQ=;
 b=F8JZx3Ei3M3ySWnOXX1b3h2lvkc8MP6yCefQVwuHjIve7IFl0Dze/rToWqiZJlHLoM
 NDQCMOHcKrAGeD9lC/buOE7VjBQamt5c0IGrurcD24Gpc5PLnWf3bfDYevRXS6YiXFFG
 hhgi4P8rE8t2EtQTVuOPaXkPPcreGMvDRiqUCDSjOGjWZneuKQnSiCBY0ppe3TFYXOAe
 EDIGgIyyOrsCcuZ+J+h2YrJXczrsU5q532z+6XLFUF4K7HswAEFIHXWrjktKJF9sn22d
 UQgd7rq6DuYTSodgVtO/ayY/w4ugt8L6bB77KdB8FVOwb0M2eWHoXy+wLX5xsFXwRGpI
 qsIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEQ4+WKHYLhMjKLO2yX/Tky7wA/POKaG79CNwtKc7xvkDwpu6n6eieS0DHkBqPsRLtUpSvJOQ6w0Oi@nongnu.org
X-Gm-Message-State: AOJu0YxjGzTSSloITKTvjUlVl5KAoHgiLAyIqz3LTSvukwlsAKSs8v1B
 dl4jQJ/TmG56gYgF0khY109eYmpB5UHj6OKl7Y8qXJnJvyrHeJduikKNj0H5CFg=
X-Google-Smtp-Source: AGHT+IHc1jxiA5GB68cV9UGPeiVw86QmQ/CKbm9GdGvum7+rvoPzo2IAbqe5yBiMuU/hX5N/9pm+jg==
X-Received: by 2002:a05:6a00:a0f:b0:71e:658f:c43b with SMTP id
 d2e1a72fcca58-7244a4fde8emr15424688b3a.2.1731610476638; 
 Thu, 14 Nov 2024 10:54:36 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7246a9bbb17sm1590345b3a.168.2024.11.14.10.54.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 10:54:36 -0800 (PST)
Message-ID: <7ba9731e-66a4-4bf3-a0db-959767fe5113@linaro.org>
Date: Thu, 14 Nov 2024 10:54:35 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 49/54] target/tricore: Convert to
 TCGCPUOps.tlb_fill_align
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241114160131.48616-1-richard.henderson@linaro.org>
 <20241114160131.48616-50-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114160131.48616-50-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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
>   target/tricore/cpu.h    |  7 ++++---
>   target/tricore/cpu.c    |  2 +-
>   target/tricore/helper.c | 19 ++++++++++++-------
>   3 files changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
> index 220af69fc2..5f141ce8f3 100644
> --- a/target/tricore/cpu.h
> +++ b/target/tricore/cpu.h
> @@ -268,8 +268,9 @@ static inline void cpu_get_tb_cpu_state(CPUTriCoreState *env, vaddr *pc,
>   #define CPU_RESOLVING_TYPE TYPE_TRICORE_CPU
>   
>   /* helpers.c */
> -bool tricore_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> -                          MMUAccessType access_type, int mmu_idx,
> -                          bool probe, uintptr_t retaddr);
> +bool tricore_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out,
> +                                vaddr addr, MMUAccessType access_type,
> +                                int mmu_idx, MemOp memop, int size,
> +                                bool probe, uintptr_t retaddr);
>   
>   #endif /* TRICORE_CPU_H */
> diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
> index 1a26171590..29e0b5d129 100644
> --- a/target/tricore/cpu.c
> +++ b/target/tricore/cpu.c
> @@ -173,7 +173,7 @@ static const TCGCPUOps tricore_tcg_ops = {
>       .initialize = tricore_tcg_init,
>       .synchronize_from_tb = tricore_cpu_synchronize_from_tb,
>       .restore_state_to_opc = tricore_restore_state_to_opc,
> -    .tlb_fill = tricore_cpu_tlb_fill,
> +    .tlb_fill_align = tricore_cpu_tlb_fill_align,
>       .cpu_exec_interrupt = tricore_cpu_exec_interrupt,
>       .cpu_exec_halt = tricore_cpu_has_work,
>   };
> diff --git a/target/tricore/helper.c b/target/tricore/helper.c
> index 7014255f77..8c6bf63298 100644
> --- a/target/tricore/helper.c
> +++ b/target/tricore/helper.c
> @@ -64,16 +64,19 @@ static void raise_mmu_exception(CPUTriCoreState *env, target_ulong address,
>   {
>   }
>   
> -bool tricore_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> -                          MMUAccessType rw, int mmu_idx,
> -                          bool probe, uintptr_t retaddr)
> +bool tricore_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out,
> +                                vaddr address, MMUAccessType access_type,
> +                                int mmu_idx, MemOp memop, int size,
> +                                bool probe, uintptr_t retaddr)
>   {
>       CPUTriCoreState *env = cpu_env(cs);
>       hwaddr physical;
>       int prot;
>       int ret = 0;
> +    int rw = access_type & 1;
> +
> +    /* TODO: alignment faults not currently handled. */
>   
> -    rw &= 1;
>       ret = get_physical_address(env, &physical, &prot,
>                                  address, rw, mmu_idx);
>   
> @@ -82,9 +85,11 @@ bool tricore_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>                     __func__, address, ret, physical, prot);
>   
>       if (ret == TLBRET_MATCH) {
> -        tlb_set_page(cs, address & TARGET_PAGE_MASK,
> -                     physical & TARGET_PAGE_MASK, prot | PAGE_EXEC,
> -                     mmu_idx, TARGET_PAGE_SIZE);
> +        memset(out, 0, sizeof(*out));
> +        out->phys_addr = physical;
> +        out->prot = prot | PAGE_EXEC;
> +        out->lg_page_size = TARGET_PAGE_BITS;
> +        out->attrs = MEMTXATTRS_UNSPECIFIED;
>           return true;
>       } else {
>           assert(ret < 0);

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


