Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10CA7C54E68
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 21:27:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmgya-0007aq-JV; Tue, 19 Mar 2024 17:26:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rmgyZ-0007ac-3i
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 17:26:27 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rmgyV-0001q8-AM
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 17:26:26 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6e6b22af648so232041b3a.0
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 14:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710883582; x=1711488382; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TVAvmDIhpciLflBuRwbnPdYQ1vOHfHflpIuQkAt+cPE=;
 b=NxtjUuD73Qa92/PGYVqzd7gaPdfy+KGVQgt3irb4pkcZnr7zaXgKw9ww/WziVDnvFa
 rVhBMahFUbZFe8XSreThPjovWYOWlzJ9CiJPAwqWT9A1FcTE9ppl+Zi7hnxYuoV/WfGd
 OsyRdvudIyoaPgLUP7AiLFisKSq2uzKa0iFjWe2gFLyTlIlPFX42g1xWp+eO1Lj2DvdH
 vV5DU9Q6gtvQ6dSZyrI60iK/UreNLTHUvucoOJ+2VegVTvxV1xKMN+0VgetXEDnp0NzB
 D2ShCM6OqhHtFLc2JDw6b5Z5vb4ZCIIDDeqKF83PKMMVIiHQACgnOGnaCNC8s5AHWjSL
 +Cfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710883582; x=1711488382;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TVAvmDIhpciLflBuRwbnPdYQ1vOHfHflpIuQkAt+cPE=;
 b=ZKq8fLzg05ROU0Qpxk7GmmCZITCrpkPIHwodki3CmT8+VxfSh52pwufAt1o+HLwDoe
 iAScUcXChcs9Br9xWQhGTksNXhrW5sQhzsQ25ASLdHbwVClSrXl+pMQ8fz2rX0tQT9o+
 nk8ovATgoKICnEblnJDAKVl9WbnI4nKAFSW8yaKftGl7Ra5wW/m2gUoWWzbuxhyByR3L
 yy3Ww76zDgTBd0lws2gn1XUSm1eZfxC7vhlA42neJSpJO/ItNqkl+u96s8gIED1u3gl0
 QKl1/3ejPVdayf2NNjt7pfv5zKn0vAYyOpnyBYOUs1+XBgz8rXJsh6v38BedCIGe5R9p
 +Tqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZvH/szXlby2/K50ZjC5KYZxG4TBVfzGk5tBxTI8aPRge8X0CWqYTmaTiznffg5slHEjCtb7tmhmaps5RwkwXIfRa9v5g=
X-Gm-Message-State: AOJu0Yzf17WbYROb8Va1J5GrCA342RFMRRtDZUAfFYFXZGU1y6CliUqr
 DAgm22H+2BGqOsoKhlzs6t0YCdPp+bvC0NM7WkBBEj1gapwR3I1p8w8YMsKAB64=
X-Google-Smtp-Source: AGHT+IGxzOLTw2JxHWwhFRZQys6gBfvBim6IA14uajfl3i6tX0YWB5Z9I1xBNEPCcnSa6KXhYpY95Q==
X-Received: by 2002:a05:6a21:3390:b0:1a3:5b82:dd07 with SMTP id
 yy16-20020a056a21339000b001a35b82dd07mr945747pzb.8.1710883581754; 
 Tue, 19 Mar 2024 14:26:21 -0700 (PDT)
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 b30-20020aa78ede000000b006e6ca46cfe7sm4054145pfr.12.2024.03.19.14.26.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 14:26:21 -0700 (PDT)
Message-ID: <d1d9a3b9-3c43-4cde-8aab-abb48fdd50ad@ventanamicro.com>
Date: Tue, 19 Mar 2024 18:26:16 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 19/27] target/riscv: Convert to
 TCGCPUOps::get_cpu_state()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Anton Johansson <anjo@rev.ng>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20240319154258.71206-1-philmd@linaro.org>
 <20240319154258.71206-20-philmd@linaro.org>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240319154258.71206-20-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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



On 3/19/24 12:42, Philippe Mathieu-Daudé wrote:
> Convert cpu_get_tb_cpu_state() to TCGCPUOps::get_cpu_state().
> 
> Note, now riscv_get_cpu_state() is restricted to TCG, and
> is declared with static scope.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>


>   target/riscv/cpu.h                      |  3 -
>   target/riscv/cpu.c                      |  2 +-
>   target/riscv/cpu_helper.c               | 87 ------------------------
>   target/riscv/tcg/tcg-cpu.c              | 88 +++++++++++++++++++++++++
>   target/riscv/insn_trans/trans_rvv.c.inc |  2 +-
>   5 files changed, 90 insertions(+), 92 deletions(-)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 3b1a02b944..d00d1be235 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -704,9 +704,6 @@ static inline uint32_t vext_get_vlmax(uint32_t vlenb, uint32_t vsew,
>       return vlen >> (vsew + 3 - lmul);
>   }
>   
> -void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
> -                          uint64_t *cs_base, uint32_t *pflags);
> -
>   void riscv_cpu_update_mask(CPURISCVState *env);
>   bool riscv_cpu_is_32bit(RISCVCPU *cpu);
>   
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index c160b9216b..ca537d0e0a 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -889,7 +889,7 @@ static vaddr riscv_cpu_get_pc(CPUState *cs)
>       RISCVCPU *cpu = RISCV_CPU(cs);
>       CPURISCVState *env = &cpu->env;
>   
> -    /* Match cpu_get_tb_cpu_state. */
> +    /* Match riscv_get_cpu_state. */
>       if (env->xl == MXL_RV32) {
>           return env->pc & UINT32_MAX;
>       }
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index ce7322011d..e18a269358 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -25,7 +25,6 @@
>   #include "pmu.h"
>   #include "exec/exec-all.h"
>   #include "instmap.h"
> -#include "tcg/tcg-op.h"
>   #include "trace.h"
>   #include "semihosting/common-semi.h"
>   #include "sysemu/cpu-timers.h"
> @@ -62,92 +61,6 @@ int riscv_env_mmu_index(CPURISCVState *env, bool ifetch)
>   #endif
>   }
>   
> -void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
> -                          uint64_t *cs_base, uint32_t *pflags)
> -{
> -    RISCVCPU *cpu = env_archcpu(env);
> -    RISCVExtStatus fs, vs;
> -    uint32_t flags = 0;
> -
> -    *pc = env->xl == MXL_RV32 ? env->pc & UINT32_MAX : env->pc;
> -    *cs_base = 0;
> -
> -    if (cpu->cfg.ext_zve32f) {
> -        /*
> -         * If env->vl equals to VLMAX, we can use generic vector operation
> -         * expanders (GVEC) to accerlate the vector operations.
> -         * However, as LMUL could be a fractional number. The maximum
> -         * vector size can be operated might be less than 8 bytes,
> -         * which is not supported by GVEC. So we set vl_eq_vlmax flag to true
> -         * only when maxsz >= 8 bytes.
> -         */
> -
> -        /* lmul encoded as in DisasContext::lmul */
> -        int8_t lmul = sextract32(FIELD_EX64(env->vtype, VTYPE, VLMUL), 0, 3);
> -        uint32_t vsew = FIELD_EX64(env->vtype, VTYPE, VSEW);
> -        uint32_t vlmax = vext_get_vlmax(cpu->cfg.vlenb, vsew, lmul);
> -        uint32_t maxsz = vlmax << vsew;
> -        bool vl_eq_vlmax = (env->vstart == 0) && (vlmax == env->vl) &&
> -                           (maxsz >= 8);
> -        flags = FIELD_DP32(flags, TB_FLAGS, VILL, env->vill);
> -        flags = FIELD_DP32(flags, TB_FLAGS, SEW, vsew);
> -        flags = FIELD_DP32(flags, TB_FLAGS, LMUL,
> -                           FIELD_EX64(env->vtype, VTYPE, VLMUL));
> -        flags = FIELD_DP32(flags, TB_FLAGS, VL_EQ_VLMAX, vl_eq_vlmax);
> -        flags = FIELD_DP32(flags, TB_FLAGS, VTA,
> -                           FIELD_EX64(env->vtype, VTYPE, VTA));
> -        flags = FIELD_DP32(flags, TB_FLAGS, VMA,
> -                           FIELD_EX64(env->vtype, VTYPE, VMA));
> -        flags = FIELD_DP32(flags, TB_FLAGS, VSTART_EQ_ZERO, env->vstart == 0);
> -    } else {
> -        flags = FIELD_DP32(flags, TB_FLAGS, VILL, 1);
> -    }
> -
> -#ifdef CONFIG_USER_ONLY
> -    fs = EXT_STATUS_DIRTY;
> -    vs = EXT_STATUS_DIRTY;
> -#else
> -    flags = FIELD_DP32(flags, TB_FLAGS, PRIV, env->priv);
> -
> -    flags |= riscv_env_mmu_index(env, 0);
> -    fs = get_field(env->mstatus, MSTATUS_FS);
> -    vs = get_field(env->mstatus, MSTATUS_VS);
> -
> -    if (env->virt_enabled) {
> -        flags = FIELD_DP32(flags, TB_FLAGS, VIRT_ENABLED, 1);
> -        /*
> -         * Merge DISABLED and !DIRTY states using MIN.
> -         * We will set both fields when dirtying.
> -         */
> -        fs = MIN(fs, get_field(env->mstatus_hs, MSTATUS_FS));
> -        vs = MIN(vs, get_field(env->mstatus_hs, MSTATUS_VS));
> -    }
> -
> -    /* With Zfinx, floating point is enabled/disabled by Smstateen. */
> -    if (!riscv_has_ext(env, RVF)) {
> -        fs = (smstateen_acc_ok(env, 0, SMSTATEEN0_FCSR) == RISCV_EXCP_NONE)
> -             ? EXT_STATUS_DIRTY : EXT_STATUS_DISABLED;
> -    }
> -
> -    if (cpu->cfg.debug && !icount_enabled()) {
> -        flags = FIELD_DP32(flags, TB_FLAGS, ITRIGGER, env->itrigger_enabled);
> -    }
> -#endif
> -
> -    flags = FIELD_DP32(flags, TB_FLAGS, FS, fs);
> -    flags = FIELD_DP32(flags, TB_FLAGS, VS, vs);
> -    flags = FIELD_DP32(flags, TB_FLAGS, XL, env->xl);
> -    flags = FIELD_DP32(flags, TB_FLAGS, AXL, cpu_address_xl(env));
> -    if (env->cur_pmmask != 0) {
> -        flags = FIELD_DP32(flags, TB_FLAGS, PM_MASK_ENABLED, 1);
> -    }
> -    if (env->cur_pmbase != 0) {
> -        flags = FIELD_DP32(flags, TB_FLAGS, PM_BASE_ENABLED, 1);
> -    }
> -
> -    *pflags = flags;
> -}
> -
>   void riscv_cpu_update_mask(CPURISCVState *env)
>   {
>       target_ulong mask = 0, base = 0;
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index ab6db817db..934007673e 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -31,6 +31,7 @@
>   #include "hw/core/accel-cpu.h"
>   #include "hw/core/tcg-cpu-ops.h"
>   #include "tcg/tcg.h"
> +#include "sysemu/cpu-timers.h"
>   
>   /* Hash that stores user set extensions */
>   static GHashTable *multi_ext_user_opts;
> @@ -129,10 +130,97 @@ static void riscv_restore_state_to_opc(CPUState *cs,
>       env->bins = data[1];
>   }
>   
> +static void riscv_get_cpu_state(CPURISCVState *env, vaddr *pc,
> +                                uint64_t *cs_base, uint32_t *pflags)
> +{
> +    RISCVCPU *cpu = env_archcpu(env);
> +    RISCVExtStatus fs, vs;
> +    uint32_t flags = 0;
> +
> +    *pc = env->xl == MXL_RV32 ? env->pc & UINT32_MAX : env->pc;
> +    *cs_base = 0;
> +
> +    if (cpu->cfg.ext_zve32f) {
> +        /*
> +         * If env->vl equals to VLMAX, we can use generic vector operation
> +         * expanders (GVEC) to accerlate the vector operations.
> +         * However, as LMUL could be a fractional number. The maximum
> +         * vector size can be operated might be less than 8 bytes,
> +         * which is not supported by GVEC. So we set vl_eq_vlmax flag to true
> +         * only when maxsz >= 8 bytes.
> +         */
> +
> +        /* lmul encoded as in DisasContext::lmul */
> +        int8_t lmul = sextract32(FIELD_EX64(env->vtype, VTYPE, VLMUL), 0, 3);
> +        uint32_t vsew = FIELD_EX64(env->vtype, VTYPE, VSEW);
> +        uint32_t vlmax = vext_get_vlmax(cpu->cfg.vlenb, vsew, lmul);
> +        uint32_t maxsz = vlmax << vsew;
> +        bool vl_eq_vlmax = (env->vstart == 0) && (vlmax == env->vl) &&
> +                           (maxsz >= 8);
> +        flags = FIELD_DP32(flags, TB_FLAGS, VILL, env->vill);
> +        flags = FIELD_DP32(flags, TB_FLAGS, SEW, vsew);
> +        flags = FIELD_DP32(flags, TB_FLAGS, LMUL,
> +                           FIELD_EX64(env->vtype, VTYPE, VLMUL));
> +        flags = FIELD_DP32(flags, TB_FLAGS, VL_EQ_VLMAX, vl_eq_vlmax);
> +        flags = FIELD_DP32(flags, TB_FLAGS, VTA,
> +                           FIELD_EX64(env->vtype, VTYPE, VTA));
> +        flags = FIELD_DP32(flags, TB_FLAGS, VMA,
> +                           FIELD_EX64(env->vtype, VTYPE, VMA));
> +        flags = FIELD_DP32(flags, TB_FLAGS, VSTART_EQ_ZERO, env->vstart == 0);
> +    } else {
> +        flags = FIELD_DP32(flags, TB_FLAGS, VILL, 1);
> +    }
> +
> +#ifdef CONFIG_USER_ONLY
> +    fs = EXT_STATUS_DIRTY;
> +    vs = EXT_STATUS_DIRTY;
> +#else
> +    flags = FIELD_DP32(flags, TB_FLAGS, PRIV, env->priv);
> +
> +    flags |= riscv_env_mmu_index(env, 0);
> +    fs = get_field(env->mstatus, MSTATUS_FS);
> +    vs = get_field(env->mstatus, MSTATUS_VS);
> +
> +    if (env->virt_enabled) {
> +        flags = FIELD_DP32(flags, TB_FLAGS, VIRT_ENABLED, 1);
> +        /*
> +         * Merge DISABLED and !DIRTY states using MIN.
> +         * We will set both fields when dirtying.
> +         */
> +        fs = MIN(fs, get_field(env->mstatus_hs, MSTATUS_FS));
> +        vs = MIN(vs, get_field(env->mstatus_hs, MSTATUS_VS));
> +    }
> +
> +    /* With Zfinx, floating point is enabled/disabled by Smstateen. */
> +    if (!riscv_has_ext(env, RVF)) {
> +        fs = (smstateen_acc_ok(env, 0, SMSTATEEN0_FCSR) == RISCV_EXCP_NONE)
> +             ? EXT_STATUS_DIRTY : EXT_STATUS_DISABLED;
> +    }
> +
> +    if (cpu->cfg.debug && !icount_enabled()) {
> +        flags = FIELD_DP32(flags, TB_FLAGS, ITRIGGER, env->itrigger_enabled);
> +    }
> +#endif
> +
> +    flags = FIELD_DP32(flags, TB_FLAGS, FS, fs);
> +    flags = FIELD_DP32(flags, TB_FLAGS, VS, vs);
> +    flags = FIELD_DP32(flags, TB_FLAGS, XL, env->xl);
> +    flags = FIELD_DP32(flags, TB_FLAGS, AXL, cpu_address_xl(env));
> +    if (env->cur_pmmask != 0) {
> +        flags = FIELD_DP32(flags, TB_FLAGS, PM_MASK_ENABLED, 1);
> +    }
> +    if (env->cur_pmbase != 0) {
> +        flags = FIELD_DP32(flags, TB_FLAGS, PM_BASE_ENABLED, 1);
> +    }
> +
> +    *pflags = flags;
> +}
> +
>   static const TCGCPUOps riscv_tcg_ops = {
>       .initialize = riscv_translate_init,
>       .synchronize_from_tb = riscv_cpu_synchronize_from_tb,
>       .restore_state_to_opc = riscv_restore_state_to_opc,
> +    .get_cpu_state = riscv_get_cpu_state,
>   
>   #ifndef CONFIG_USER_ONLY
>       .tlb_fill = riscv_cpu_tlb_fill,
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
> index e42728990e..3c16c4852b 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -578,7 +578,7 @@ static bool vext_check_slide(DisasContext *s, int vd, int vs2,
>   }
>   
>   /*
> - * In cpu_get_tb_cpu_state(), set VILL if RVV was not present.
> + * In riscv_get_cpu_state(), set VILL if RVV was not present.
>    * So RVV is also be checked in this function.
>    */
>   static bool vext_check_isa_ill(DisasContext *s)

