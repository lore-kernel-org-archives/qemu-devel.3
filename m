Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D71AED6A226
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 18:58:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBf0o-0003c8-2p; Thu, 14 Nov 2024 13:56:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBez9-0001QO-6s
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:54:34 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBez5-0008Nb-FT
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:54:30 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-20c803787abso8551405ad.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 10:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731610464; x=1732215264; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/bDOebwew2Gb9DXhur3Q6IwVhhGzXoKJ8q74cyMGczk=;
 b=KYAgiD91tYgyk4VoBnFyM3ayh2x6+248rVnfGAO7gFsU6OSDluPWmzGVMourP8X6wx
 UIGGK5sKAKnH2kfm8VDELeqDmrJoH0yiNLsuNgLH4+/xchT7XcFeSf720m3xml04t05z
 kEfPoFcrKsBV/tjK6SmpXXvaUMSoWoe9Z6mLzCj1X3ZOESf7geHTAM6ileTI2Ijt7p9E
 fUQoO7uhtl+yhM/8WlVq9D9+bZZRTEAAMgsipQMsrl6MxnUn4gut1Qfr/7+DrOPZq1+6
 jpbHTJmLOs4fx6mToRcK6oEmBn5PSo7mLi0vEzTAuQu+EXcp8otp6NlXpw2ToD4rqvLV
 SzwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731610464; x=1732215264;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/bDOebwew2Gb9DXhur3Q6IwVhhGzXoKJ8q74cyMGczk=;
 b=s1QamB7uE6EzbZUjvBoANOZQObS+hkx+VuWUZ3NATMUxWuv2kQZYo7mUJXGZFqZscJ
 S7mUp17i8S4FOBBbNAPpDRqYm4DZ0H/KKzmvUjByJnLU4U+gd8bwQvbYzIzTydYwKWf1
 EdVT6YlUjzGVVeUfZUSrh2kZGYvoKApAGswe3ssXe1CYXd9c1VHV9p5APvu1C1EVUOg7
 1QWrkYmGUdXfPEYn6FZ3KJs5+ku0K3YCKahUXUQfZmcmSmiG3iXlT4yVIZhkcVwDILOm
 VcXeavrz/GN/FvE3aKWYt/CDLUB5djcAMvlNaPoUoFoo/H2UJve1OG4vz5j8mzrhWJCz
 KxHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9C4nSn/3UyT+7Tn+f8AmA+/sarbh1z3EWCrS56ambu/OBCmfpcMHMlrpzg6AmqOyUmsFBKknW1J4w@nongnu.org
X-Gm-Message-State: AOJu0YzZlr568n245BCfI6M3yOzaI0vNTlOSAjllMiVIinmtSu5Meor+
 R27rDG1ypuGrOnwczLo0k6+aH9u5s04Ybxk2IZI/DJTVZVXZk4/vr8m1AVRFTO4=
X-Google-Smtp-Source: AGHT+IEF/fueQmEGqkg7d0Z2L13zjIFCKczydoKiU2Tp6LiV5OYY2tgdjDIfIRUxPDQ7y0qO6i4dPA==
X-Received: by 2002:a17:903:228d:b0:20b:a409:329 with SMTP id
 d9443c01a7336-211c0f0a592mr62521585ad.5.1731610463720; 
 Thu, 14 Nov 2024 10:54:23 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211c7c49d7bsm13981345ad.72.2024.11.14.10.54.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 10:54:23 -0800 (PST)
Message-ID: <22d4d563-7625-463c-92a3-c30fd99b4e4e@linaro.org>
Date: Thu, 14 Nov 2024 10:54:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 47/54] target/sh4: Convert to TCGCPUOps.tlb_fill_align
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241114160131.48616-1-richard.henderson@linaro.org>
 <20241114160131.48616-48-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114160131.48616-48-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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
>   target/sh4/cpu.h    |  8 +++++---
>   target/sh4/cpu.c    |  2 +-
>   target/sh4/helper.c | 24 +++++++++++++++++-------
>   3 files changed, 23 insertions(+), 11 deletions(-)
> 
> diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
> index d928bcf006..161efdefcf 100644
> --- a/target/sh4/cpu.h
> +++ b/target/sh4/cpu.h
> @@ -22,6 +22,7 @@
>   
>   #include "cpu-qom.h"
>   #include "exec/cpu-defs.h"
> +#include "exec/memop.h"
>   #include "qemu/cpu-float.h"
>   
>   /* CPU Subtypes */
> @@ -251,9 +252,10 @@ void sh4_translate_init(void);
>   
>   #if !defined(CONFIG_USER_ONLY)
>   hwaddr superh_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
> -bool superh_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> -                         MMUAccessType access_type, int mmu_idx,
> -                         bool probe, uintptr_t retaddr);
> +bool superh_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out,
> +                               vaddr addr, MMUAccessType access_type,
> +                               int mmu_idx, MemOp memop, int size,
> +                               bool probe, uintptr_t retaddr);
>   void superh_cpu_do_interrupt(CPUState *cpu);
>   bool superh_cpu_exec_interrupt(CPUState *cpu, int int_req);
>   void cpu_sh4_invalidate_tlb(CPUSH4State *s);
> diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
> index 8f07261dcf..8ca8b90e3c 100644
> --- a/target/sh4/cpu.c
> +++ b/target/sh4/cpu.c
> @@ -252,7 +252,7 @@ static const TCGCPUOps superh_tcg_ops = {
>       .restore_state_to_opc = superh_restore_state_to_opc,
>   
>   #ifndef CONFIG_USER_ONLY
> -    .tlb_fill = superh_cpu_tlb_fill,
> +    .tlb_fill_align = superh_cpu_tlb_fill_align,
>       .cpu_exec_interrupt = superh_cpu_exec_interrupt,
>       .cpu_exec_halt = superh_cpu_has_work,
>       .do_interrupt = superh_cpu_do_interrupt,
> diff --git a/target/sh4/helper.c b/target/sh4/helper.c
> index 9659c69550..543ac1b843 100644
> --- a/target/sh4/helper.c
> +++ b/target/sh4/helper.c
> @@ -792,22 +792,32 @@ bool superh_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>       return false;
>   }
>   
> -bool superh_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> -                         MMUAccessType access_type, int mmu_idx,
> -                         bool probe, uintptr_t retaddr)
> +bool superh_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out,
> +                               vaddr address, MMUAccessType access_type,
> +                               int mmu_idx, MemOp memop, int size,
> +                               bool probe, uintptr_t retaddr)
>   {
>       CPUSH4State *env = cpu_env(cs);
>       int ret;
> -
>       target_ulong physical;
>       int prot;
>   
> +    if (address & ((1 << memop_alignment_bits(memop)) - 1)) {
> +        if (probe) {
> +            return false;
> +        }
> +        superh_cpu_do_unaligned_access(cs, address, access_type,
> +                                       mmu_idx, retaddr);
> +    }
> +
>       ret = get_physical_address(env, &physical, &prot, address, access_type);
>   
>       if (ret == MMU_OK) {
> -        address &= TARGET_PAGE_MASK;
> -        physical &= TARGET_PAGE_MASK;
> -        tlb_set_page(cs, address, physical, prot, mmu_idx, TARGET_PAGE_SIZE);
> +        memset(out, 0, sizeof(*out));
> +        out->phys_addr = physical;
> +        out->prot = prot;
> +        out->lg_page_size = TARGET_PAGE_BITS;
> +        out->attrs = MEMTXATTRS_UNSPECIFIED;
>           return true;
>       }
>       if (probe) {

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


