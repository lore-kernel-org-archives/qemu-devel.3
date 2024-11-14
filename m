Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D4EED6A226
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 18:55:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBeyI-0007wa-Bv; Thu, 14 Nov 2024 13:53:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBeyH-0007w9-6V
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:53:37 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBeyF-0007WY-Gi
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:53:36 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-72475e29578so62740b3a.3
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 10:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731610414; x=1732215214; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CVwtG4F/1OBy5KJo9AlX/DbjUVEDbiayNVTa2BOUnAA=;
 b=MPK4nlTqAXAQOJVZGlacZ0XliFOjUaHW342qwvP0IACB7ObpzH3cJMG7TU+WCOTYvL
 LGTgU+VV4QAd5vwVmTSFrd6xxYZxfbyeXCB6pslh07jkwg5vQVlvjTl1hjPrmLRgHmoa
 wjCT83nyqDVWgpgIbvseV7MmWS+7GZnp9XqkeW0qDrwlZ1ROSlYAuXCvpTDM4M7LgE6g
 JTM/4aP1VROu/STf8JXageOWE3b2dHRIHNHtdt3jBjzrEL860M9queI5UWDpTEVa4/Hh
 UNzaM3NvOTUn6m+uSnrS2T60hPqVOFWSHM8wQpFfKNiHmhMRO4FQjgNbd94dhybp2q5O
 imSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731610414; x=1732215214;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CVwtG4F/1OBy5KJo9AlX/DbjUVEDbiayNVTa2BOUnAA=;
 b=TfuZ6JjXIgmEHf3iVC+v0WzgK6kn53ybQrtPKEUQzazmMjSEf0U7ihEOFC/s4MwdUo
 KAv3aan4RLVnL0JrKbdKVZVy2n/0e9WaYxrFIjMoF1lg7q5EB7At+wVyI/3PK3Rmvp55
 2GJ6Qxw+IWyOnUfBt+BNumnE4lX66Ed2WNS1gQrX7bDLHGkkummXuxAHj/2jfJwuweY8
 EJcr9zX+lfGxmO2MbEG2npzxCQoyKn1FU0qIjYTOK8MvkroOjplmAso6osr7NAnVd4cY
 45UMOlmFglvexrqWRHsvuBhtbGNz0Gyxz002qu7kOx/rIh+yE1hXoWwmeGbwrRR5bagr
 9Bkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKEjaLx/zjlvzMT55/gsKCPdwsdBwTibMtRSf+mlPQOhRxCLv0AyZgU/+o87uOXH3YNTRrOdPcVGUW@nongnu.org
X-Gm-Message-State: AOJu0YzJhLQtOtOA/MQOnFUFY2K7UgYPEiiGSp0s8GT86NiTuu4RDABr
 BqrVqEWhjcaDMiuFljQVYsIkNM3qYvhSwwIxi7ZitaycewMbmGE5deaAxU6xjFA=
X-Google-Smtp-Source: AGHT+IG/vt2gGMGxV6dko42LGxN+RMaMKXgBZHEzCrhJOmMRoWKOZTJCt2q7NkslqgeA4/aTpyuH/g==
X-Received: by 2002:a05:6a00:98a:b0:71e:581f:7d7e with SMTP id
 d2e1a72fcca58-724579c3afdmr9638972b3a.15.1731610414052; 
 Thu, 14 Nov 2024 10:53:34 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7246a5cfabdsm1587559b3a.13.2024.11.14.10.53.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 10:53:33 -0800 (PST)
Message-ID: <b8028e76-d1af-4e39-be84-da5e6d3cfdc7@linaro.org>
Date: Thu, 14 Nov 2024 10:53:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 37/54] target/loongarch: Convert to
 TCGCPUOps.tlb_fill_align
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241114160131.48616-1-richard.henderson@linaro.org>
 <20241114160131.48616-38-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114160131.48616-38-richard.henderson@linaro.org>
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
>   target/loongarch/internals.h      |  7 ++++---
>   target/loongarch/cpu.c            |  2 +-
>   target/loongarch/tcg/tlb_helper.c | 17 +++++++++++------
>   3 files changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
> index 1a02427627..a9f73f27b2 100644
> --- a/target/loongarch/internals.h
> +++ b/target/loongarch/internals.h
> @@ -60,9 +60,10 @@ int get_physical_address(CPULoongArchState *env, hwaddr *physical,
>   hwaddr loongarch_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
>   
>   #ifdef CONFIG_TCG
> -bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> -                            MMUAccessType access_type, int mmu_idx,
> -                            bool probe, uintptr_t retaddr);
> +bool loongarch_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out,
> +                                  vaddr addr, MMUAccessType access_type,
> +                                  int mmu_idx, MemOp memop, int size,
> +                                  bool probe, uintptr_t ra);
>   #endif
>   #endif /* !CONFIG_USER_ONLY */
>   
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index 57cc4f314b..47d69f1788 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -798,7 +798,7 @@ static const TCGCPUOps loongarch_tcg_ops = {
>       .restore_state_to_opc = loongarch_restore_state_to_opc,
>   
>   #ifndef CONFIG_USER_ONLY
> -    .tlb_fill = loongarch_cpu_tlb_fill,
> +    .tlb_fill_align = loongarch_cpu_tlb_fill_align,
>       .cpu_exec_interrupt = loongarch_cpu_exec_interrupt,
>       .cpu_exec_halt = loongarch_cpu_has_work,
>       .do_interrupt = loongarch_cpu_do_interrupt,
> diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
> index 97f38fc391..94d5df08a4 100644
> --- a/target/loongarch/tcg/tlb_helper.c
> +++ b/target/loongarch/tcg/tlb_helper.c
> @@ -474,9 +474,10 @@ void helper_invtlb_page_asid_or_g(CPULoongArchState *env,
>       tlb_flush(env_cpu(env));
>   }
>   
> -bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> -                            MMUAccessType access_type, int mmu_idx,
> -                            bool probe, uintptr_t retaddr)
> +bool loongarch_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out,
> +                                  vaddr address, MMUAccessType access_type,
> +                                  int mmu_idx, MemOp memop, int size,
> +                                  bool probe, uintptr_t retaddr)
>   {
>       CPULoongArchState *env = cpu_env(cs);
>       hwaddr physical;
> @@ -488,12 +489,16 @@ bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>                                  access_type, mmu_idx);
>   
>       if (ret == TLBRET_MATCH) {
> -        tlb_set_page(cs, address & TARGET_PAGE_MASK,
> -                     physical & TARGET_PAGE_MASK, prot,
> -                     mmu_idx, TARGET_PAGE_SIZE);
>           qemu_log_mask(CPU_LOG_MMU,
>                         "%s address=%" VADDR_PRIx " physical " HWADDR_FMT_plx
>                         " prot %d\n", __func__, address, physical, prot);
> +
> +        memset(out, 0, sizeof(*out));
> +        out->phys_addr = physical;
> +        out->prot = prot;
> +        out->attrs = MEMTXATTRS_UNSPECIFIED;
> +        out->lg_page_size = TARGET_PAGE_BITS;
> +
>           return true;
>       } else {
>           qemu_log_mask(CPU_LOG_MMU,

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


