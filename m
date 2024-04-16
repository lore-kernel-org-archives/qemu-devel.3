Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F8BAC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 09:24:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwf2x-0004FD-89; Tue, 16 Apr 2024 05:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rwf2k-0003lQ-JY
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 05:24:00 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rwf2e-0000lR-Ni
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 05:23:57 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1e3cf5b171eso33926105ad.0
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 02:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1713259428; x=1713864228; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IpW/hijO0aHHxkG2Zb18GBzP2NduAGDhiCt875BvOCU=;
 b=TeiCww9bvjJpD3tRM2PpBB03b4pr1Ad1TIyaANpZQX6kDEnzoXBua4jl14lTZ0ePSw
 XZjBRBs8j0w3S4VOoClv+kb4NbaoABoO035qO8kS5HNC/DBJlIRN3KtOZXta08sTy1pJ
 AB0NkOhkmLfqZKpiBFujDcNFzefxkwTR1wDnVkgzKrZLCWClH0yGlUweM/NZYHfAT4Mn
 eDkEyVedJty2igTs4s2g9jj/BRjoxenFGUQOx0IfXGoq1JnDy9YeOYEpd1Jc5DHad8aP
 PxoHOVENkq3Ed+erhiCUO3g2dGM/NSssERvcoiNA1hMbukbKrl5RSX9zTRw6UK+wWgV0
 o+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713259428; x=1713864228;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IpW/hijO0aHHxkG2Zb18GBzP2NduAGDhiCt875BvOCU=;
 b=kRoUBBllw1djartO/Tf4sZ0jGOZg6QmPhvDOXVWvm9PjcB9wIzoZy0tdEdT8dunFXn
 7SQeRIu0iM3oN+FoA3EmU/txiZgriCvYQp9o4p+yPc+BPHnq/GBJZ5XoCmo1i/wGE/e2
 kUFSu5xc5+GfFowZ5hLeRd+j2cR5g67vdZdbpkGNMLY9WeVxNxqpEMY7KJOjGFmbLRvy
 XRlGiu5UKu+F2+mYKd4AVY0hM49dtuY9blk2tzSfRa3AHnvJAjHcSOq7cqdV4UsGJDtG
 6qX7WLwuwqCP3OTplwrlMKHWyB2Jk9bPYQ3mTWI6SfbrZ2Yig+KjxbHTsXr1HSN/BWwQ
 hHGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUalOhB+wNiYiIJneojaCG5YiMSaq3RZKNpJSWgMsS5sr7B2h8L7yITqyYLgXLGKz2WSEbDJsBnWyvF68Ki76rKZ+9vD38=
X-Gm-Message-State: AOJu0YyPG26EaVnRqfd+pz7raFz6/Mfx4HTvDkbzHuRMJpQFjZb8Xkad
 /kc6O/hrbzRZL+pkKzAQb/AT9hn6scMRaWEK0+uNbUMRT8F8UvA6SMyFzn2a/zo=
X-Google-Smtp-Source: AGHT+IFz7sxyqodhqcMHkpWTghH665tQ4vQZCJAbH/Yc1xan5QSBX/4nYRpWz375G6Ln2ElNnxZyrA==
X-Received: by 2002:a17:902:ea12:b0:1e3:dfdc:6972 with SMTP id
 s18-20020a170902ea1200b001e3dfdc6972mr17052582plg.9.1713259428336; 
 Tue, 16 Apr 2024 02:23:48 -0700 (PDT)
Received: from [192.168.68.110] ([177.45.186.202])
 by smtp.gmail.com with ESMTPSA id
 q6-20020a170902a3c600b001dd0d0d26a4sm9553362plb.147.2024.04.16.02.23.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Apr 2024 02:23:47 -0700 (PDT)
Message-ID: <ada42503-dab4-474f-a61a-a9fe3fa63afa@ventanamicro.com>
Date: Tue, 16 Apr 2024 06:23:43 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/4] target/riscv/kvm: add software breakpoints support
Content-Language: en-US
To: Chao Du <duchao@eswincomputing.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, pbonzini@redhat.com, alistair23@gmail.com,
 bin.meng@windriver.com, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com,
 palmer@dabbelt.com, anup@brainfault.org, atishp@atishpatra.org
References: <20231221094923.7349-1-duchao@eswincomputing.com>
 <20231221094923.7349-2-duchao@eswincomputing.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20231221094923.7349-2-duchao@eswincomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 12/21/23 06:49, Chao Du wrote:
> This patch implements insert/remove software breakpoint process:
> 
> Add an input parameter for kvm_arch_insert_sw_breakpoint() and
> kvm_arch_remove_sw_breakpoint() to pass the length information,
> which helps us to know whether it is a compressed instruction.
> For some remove cases, we do not have the length info, so we need
> to judge by ourselves.
> 
> For RISC-V, GDB treats single-step similarly to breakpoint: add a
> breakpoint at the next step address, then continue. So this also
> works for single-step debugging.
> 
> Add some stubs which are necessary for building, and will be
> implemented later.
> 
> Signed-off-by: Chao Du <duchao@eswincomputing.com>
> ---
>   accel/kvm/kvm-all.c        |  8 ++--
>   include/sysemu/kvm.h       |  6 ++-
>   target/arm/kvm64.c         |  6 ++-
>   target/i386/kvm/kvm.c      |  6 ++-
>   target/mips/kvm.c          |  6 ++-
>   target/ppc/kvm.c           |  6 ++-
>   target/riscv/kvm/kvm-cpu.c | 79 ++++++++++++++++++++++++++++++++++++++
>   target/s390x/kvm/kvm.c     |  6 ++-
>   8 files changed, 107 insertions(+), 16 deletions(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index e39a810a4e..ccc505d0c2 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -3231,7 +3231,7 @@ int kvm_insert_breakpoint(CPUState *cpu, int type, vaddr addr, vaddr len)
>           bp = g_new(struct kvm_sw_breakpoint, 1);
>           bp->pc = addr;
>           bp->use_count = 1;
> -        err = kvm_arch_insert_sw_breakpoint(cpu, bp);
> +        err = kvm_arch_insert_sw_breakpoint(cpu, bp, len);
>           if (err) {
>               g_free(bp);
>               return err;
> @@ -3270,7 +3270,7 @@ int kvm_remove_breakpoint(CPUState *cpu, int type, vaddr addr, vaddr len)
>               return 0;
>           }
>   
> -        err = kvm_arch_remove_sw_breakpoint(cpu, bp);
> +        err = kvm_arch_remove_sw_breakpoint(cpu, bp, len);
>           if (err) {
>               return err;
>           }
> @@ -3300,10 +3300,10 @@ void kvm_remove_all_breakpoints(CPUState *cpu)
>       CPUState *tmpcpu;
>   
>       QTAILQ_FOREACH_SAFE(bp, &s->kvm_sw_breakpoints, entry, next) {
> -        if (kvm_arch_remove_sw_breakpoint(cpu, bp) != 0) {
> +        if (kvm_arch_remove_sw_breakpoint(cpu, bp, 0) != 0) {
>               /* Try harder to find a CPU that currently sees the breakpoint. */
>               CPU_FOREACH(tmpcpu) {
> -                if (kvm_arch_remove_sw_breakpoint(tmpcpu, bp) == 0) {
> +                if (kvm_arch_remove_sw_breakpoint(tmpcpu, bp, 0) == 0) {
>                       break;
>                   }
>               }
> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index d614878164..ab38c23def 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -391,9 +391,11 @@ struct kvm_sw_breakpoint *kvm_find_sw_breakpoint(CPUState *cpu,
>   int kvm_sw_breakpoints_active(CPUState *cpu);
>   
>   int kvm_arch_insert_sw_breakpoint(CPUState *cpu,
> -                                  struct kvm_sw_breakpoint *bp);
> +                                  struct kvm_sw_breakpoint *bp,
> +                                  vaddr len);
>   int kvm_arch_remove_sw_breakpoint(CPUState *cpu,
> -                                  struct kvm_sw_breakpoint *bp);
> +                                  struct kvm_sw_breakpoint *bp,
> +                                  vaddr len);
>   int kvm_arch_insert_hw_breakpoint(vaddr addr, vaddr len, int type);
>   int kvm_arch_remove_hw_breakpoint(vaddr addr, vaddr len, int type);
>   void kvm_arch_remove_all_hw_breakpoints(void);
> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> index 3c175c93a7..023e92b577 100644
> --- a/target/arm/kvm64.c
> +++ b/target/arm/kvm64.c
> @@ -1139,7 +1139,8 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>   /* C6.6.29 BRK instruction */
>   static const uint32_t brk_insn = 0xd4200000;
>   
> -int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
> +int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp,
> +                                  vaddr len)
>   {
>       if (have_guest_debug) {
>           if (cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&bp->saved_insn, 4, 0) ||
> @@ -1153,7 +1154,8 @@ int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
>       }
>   }
>   
> -int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
> +int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp,
> +                                  vaddr len)
>   {
>       static uint32_t brk;
>   
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 4ce80555b4..742b7c8296 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -4935,7 +4935,8 @@ static int kvm_handle_tpr_access(X86CPU *cpu)
>       return 1;
>   }
>   
> -int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
> +int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp,
> +                                  vaddr len)
>   {
>       static const uint8_t int3 = 0xcc;
>   
> @@ -4946,7 +4947,8 @@ int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
>       return 0;
>   }
>   
> -int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
> +int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp,
> +                                  vaddr len)
>   {
>       uint8_t int3;
>   
> diff --git a/target/mips/kvm.c b/target/mips/kvm.c
> index e22e24ed97..2f68938cdf 100644
> --- a/target/mips/kvm.c
> +++ b/target/mips/kvm.c
> @@ -112,13 +112,15 @@ void kvm_mips_reset_vcpu(MIPSCPU *cpu)
>       DPRINTF("%s\n", __func__);
>   }
>   
> -int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
> +int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp,
> +                                  vaddr len)
>   {
>       DPRINTF("%s\n", __func__);
>       return 0;
>   }
>   
> -int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
> +int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp,
> +                                  vaddr len)
>   {
>       DPRINTF("%s\n", __func__);
>       return 0;
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 9b1abe2fc4..a99c85b2f3 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -1375,7 +1375,8 @@ static int kvmppc_handle_dcr_write(CPUPPCState *env,
>       return 0;
>   }
>   
> -int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
> +int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp,
> +                                  vaddr len)
>   {
>       /* Mixed endian case is not handled */
>       uint32_t sc = debug_inst_opcode;
> @@ -1389,7 +1390,8 @@ int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
>       return 0;
>   }
>   
> -int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
> +int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp,
> +                                  vaddr len)
>   {
>       uint32_t sc;
>   
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 45b6cf1cfa..e9110006b0 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -1521,3 +1521,82 @@ static const TypeInfo riscv_kvm_cpu_type_infos[] = {
>   };
>   
>   DEFINE_TYPES(riscv_kvm_cpu_type_infos)
> +
> +static const uint32_t ebreak_insn = 0x00100073;
> +static const uint16_t c_ebreak_insn = 0x9002;
> +
> +int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp,
> +                                  vaddr len)
> +{
> +    if (len != 4 && len != 2) {
> +        return -EINVAL;
> +    }

I wonder if this verification should be moved to kvm_insert_breakpoint(). Is
there any known reason why other archs would use 'len' other than 2 or 4? The
parent function can throw the EINVAL in this case. Otherwise all callers from
all archs will need a similar EINVAL check.

> +
> +    uint8_t * insn = (len == 4) ? (uint8_t *)&ebreak_insn :
> +                                  (uint8_t *)&c_ebreak_insn;
> +
> +    if (cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&bp->saved_insn, len, 0) ||
> +        cpu_memory_rw_debug(cs, bp->pc, insn, len, 1)) {
> +        return -EINVAL;
> +    }
> +
> +    return 0;
> +}
> +
> +int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp,
> +                                  vaddr len)
> +{
> +    uint8_t length;
> +
> +    if (len == 4 || len == 2) {
> +        length = (uint8_t)len;

Same question as above - perhaps the len = 0 | 2 | 4 conditional can be moved to
kvm_remove_breakpoint().


Thanks,


Daniel


> +    } else if (len == 0) {
> +        /* Need to decide the instruction length in this case. */
> +        uint32_t read_4_bytes;
> +        uint16_t read_2_bytes;
> +
> +        if (cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&read_4_bytes, 4, 0) ||
> +            cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&read_2_bytes, 2, 0)) {
> +            return -EINVAL;
> +        }
> +
> +        if (read_4_bytes == ebreak_insn) {
> +            length = 4;
> +        } else if (read_2_bytes == c_ebreak_insn) {
> +            length = 2;
> +        } else {
> +            return -EINVAL;
> +        }
> +    } else {
> +        return -EINVAL;
> +    }
> +
> +    if (cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&bp->saved_insn,
> +                            length, 1)) {
> +        return -EINVAL;
> +    }
> +
> +    return 0;
> +}
> +
> +int kvm_arch_insert_hw_breakpoint(vaddr addr, vaddr len, int type)
> +{
> +    /* TODO; To be implemented later. */
> +    return -EINVAL;
> +}
> +
> +int kvm_arch_remove_hw_breakpoint(vaddr addr, vaddr len, int type)
> +{
> +    /* TODO; To be implemented later. */
> +    return -EINVAL;
> +}
> +
> +void kvm_arch_remove_all_hw_breakpoints(void)
> +{
> +    /* TODO; To be implemented later. */
> +}
> +
> +void kvm_arch_update_guest_debug(CPUState *cs, struct kvm_guest_debug *dbg)
> +{
> +    /* TODO; To be implemented later. */
> +}
> diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
> index 33ab3551f4..fafacedd6a 100644
> --- a/target/s390x/kvm/kvm.c
> +++ b/target/s390x/kvm/kvm.c
> @@ -867,7 +867,8 @@ static void determine_sw_breakpoint_instr(void)
>           }
>   }
>   
> -int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
> +int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp,
> +                                  vaddr len)
>   {
>       determine_sw_breakpoint_instr();
>   
> @@ -879,7 +880,8 @@ int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
>       return 0;
>   }
>   
> -int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
> +int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp,
> +                                  vaddr len)
>   {
>       uint8_t t[MAX_ILEN];
>   

