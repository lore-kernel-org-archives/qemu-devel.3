Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A23A4E7DF11
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 17:40:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmxtv-0007RX-Q0; Mon, 02 Feb 2026 12:39:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vmxtu-0007QS-KZ
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 12:39:50 -0500
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vmxts-0004gX-QE
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 12:39:50 -0500
Received: by mail-qt1-x842.google.com with SMTP id
 d75a77b69052e-5014f383df6so35207381cf.1
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 09:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1770053988; x=1770658788; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L5BwdvI09BB46pmTluKOcSXhuaOM8CJ2zbaYIkrMgGk=;
 b=oj2U6g95YG4/8m0yeTzWF5NadgTzhx7aMjzG+jHsa1k0WoYtKpNKS2i6l1+er4LsqC
 qof4Trt+xjuFPQqfY4qTH0luAtV3/5bw32d6OzNeKhqeW3Rukwzl2cfbB1bbmJobC2hI
 h4rxCskGM3UorkQim/QxWHuvgCgO+L0z/z4ndURGgLawjWYHnkPZT1dMHWJSvg6oO0yQ
 9TeKeHeZL4W/i6JI0u9LTtbc+IAq34HkSz8xBya1WUdxRD6qWFwuaF5XX5oRpU9MIQsB
 IZf7/yi/DiqxAoRPk2QxkZ4MiabLfUh+kS041WO3yXRSU61pNZ1E3/tJp70iVsEDzLQw
 aNRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770053988; x=1770658788;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L5BwdvI09BB46pmTluKOcSXhuaOM8CJ2zbaYIkrMgGk=;
 b=CDYc6rRYzUjOyc/UE6oeoOIYsT0Bf80rl1HIgCQVIpJRosPqF+p+/mhlABO8SybWoF
 mCD1tkun2DCVI+wkyMAgrR5mhkiUZkYsBj3ezmR+hdBq42nuOvx03nbgkEtj0TV9kane
 gIqWeCI1CWqB4lUqQkkFxT1TkejWoOHVpKP8rqIDfgRbjdIkE5RvjFfWuuto1LDgPzK8
 UZfUk1TEPrsS2MVpnSjcobJ63/Q1t/llevgda/Xwk5CAnuQaPmu8yJfb/YM2m9me9+5j
 5PcNx78lDqpTWV03YyDaocIis6wPwmxu0xQ6JT76G0BhnOabvGcCSP+TKTXDx3L4TEqY
 2EyQ==
X-Gm-Message-State: AOJu0YzsYf+xHmetA3paBle9jgqx/LWAMELwOpMvdRj15/ULFCV7IyID
 HtzpiWZXIn5jn9ortWAUUPJ6flCj4BDQrCatFmephQMr72poSL4vpazXD1n8ySOuYTk=
X-Gm-Gg: AZuq6aKyVLCKzejPkH+E7HweXYCCRz3qEA78JiEKlpCTli/ogU9hEzkH3M/NZFhR+1e
 9E2Fx2p77mj2NyDxlOuoDyMHZD5nXVutQldERnCul0n0baXFN3o7Qxe3TKTOZw47PKMT3VBg3pU
 0I5PtJHwgmaoyxgJHDhIvdDzllfaEKlOT/2L1MAykMY4C16q43JezJeY7PkPy5fhU479f5c47xW
 GkdmjVlm0T2zLJIhdsID1XiYfMtUYIGo00aTk+cPsgN9Y6MzXzW5ptg3tlKEnpOV3yL0gmmFjm9
 69llTfXPpHjJRBAe6QoshiM2xZ1ZvV5fXWNEZRAj7TZBDtwBmwSg1jpJ2ZahJyfaDe78WUnDdcR
 DpmqFpcwhOP05Fzz4ulV9d0rg9JvgroBFDjgKX7fwgtsx2v9vzVCcaY8F/zxBR2FaLeFalLsDl1
 4k97qmqmwacjRe27pJdusNESrl8DtKROa7Bb6tPG864D9fJU95spK2uQM9d1ghLCwPVH0p3zA4c
 g==
X-Received: by 2002:a05:622a:20d:b0:503:4258:93aa with SMTP id
 d75a77b69052e-505d1ffc375mr164622351cf.0.1770053987751; 
 Mon, 02 Feb 2026 09:39:47 -0800 (PST)
Received: from [192.168.68.103] (200-206-229-25.dsl.telesp.net.br.
 [200.206.229.25]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50337bbbf8csm111612221cf.28.2026.02.02.09.39.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Feb 2026 09:39:47 -0800 (PST)
Message-ID: <19cabb53-386a-4282-b878-b514f0661ca5@ventanamicro.com>
Date: Mon, 2 Feb 2026 14:39:44 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 3/7] target/riscv: add sdext Debug Mode helpers
To: Chao Liu <chao.liu.zevorn@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 hust-os-kernel-patches@googlegroups.com, wangjingwei@iscas.ac.cn,
 devel@lists.libvirt.org
References: <cover.1769751489.git.chao.liu.zevorn@gmail.com>
 <e7bcdb91db6c5f51081a079ca4e8c593152a3f36.1769751489.git.chao.liu.zevorn@gmail.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <e7bcdb91db6c5f51081a079ca4e8c593152a3f36.1769751489.git.chao.liu.zevorn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::842;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-qt1-x842.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 1/30/2026 3:00 AM, Chao Liu wrote:
> RISC-V Debug Specification:
> https://github.com/riscv/riscv-debug-spec/releases/tag/1.0
> 
> Add helpers to enter/leave Debug Mode and to update dpc/dcsr.
> Model resume without a Debug Module by leaving Debug Mode at
> cpu_exec_enter and continuing from dpc.
> 
> Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/cpu.h         |  3 ++
>   target/riscv/cpu_helper.c  | 84 ++++++++++++++++++++++++++++++++++++++
>   target/riscv/debug.c       |  5 +++
>   target/riscv/tcg/tcg-cpu.c | 14 +++++++
>   4 files changed, 106 insertions(+)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 2a265faae5..62732957a4 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -624,6 +624,9 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>   char *riscv_isa_string(RISCVCPU *cpu);
>   int riscv_cpu_max_xlen(RISCVCPUClass *mcc);
>   bool riscv_cpu_option_set(const char *optname);
> +void riscv_cpu_enter_debug_mode(CPURISCVState *env, target_ulong pc,
> +                                uint32_t cause);
> +void riscv_cpu_leave_debug_mode(CPURISCVState *env);
>   
>   #ifndef CONFIG_USER_ONLY
>   void riscv_cpu_do_interrupt(CPUState *cpu);
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index dd6c861a90..0e266ff3a9 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -136,6 +136,90 @@ bool riscv_env_smode_dbltrp_enabled(CPURISCVState *env, bool virt)
>   #endif
>   }
>   
> +#ifndef CONFIG_USER_ONLY
> +static bool riscv_sdext_enabled(CPURISCVState *env)
> +{
> +    return riscv_cpu_cfg(env)->ext_sdext;
> +}
> +#endif
> +
> +void riscv_cpu_enter_debug_mode(CPURISCVState *env, target_ulong pc,
> +                                uint32_t cause)
> +{
> +#ifndef CONFIG_USER_ONLY
> +    if (!riscv_sdext_enabled(env)) {
> +        return;
> +    }
> +
> +    env->debug_mode = true;
> +    env->dpc = pc & get_xepc_mask(env);
> +    env->dcsr &= ~(DCSR_CAUSE_MASK | DCSR_PRV_MASK | DCSR_V);
> +    env->dcsr |= ((target_ulong)(cause & 0x7)) << DCSR_CAUSE_SHIFT;
> +    env->dcsr |= env->priv & DCSR_PRV_MASK;
> +    if (env->virt_enabled && riscv_has_ext(env, RVH)) {
> +        env->dcsr |= DCSR_V;
> +    }
> +
> +    if (env_archcpu(env)->cfg.ext_zicfilp) {
> +        if (env->elp) {
> +            env->dcsr |= DCSR_PELP;
> +        } else {
> +            env->dcsr &= ~DCSR_PELP;
> +        }
> +        env->elp = false;
> +    }
> +#endif
> +}
> +
> +void riscv_cpu_leave_debug_mode(CPURISCVState *env)
> +{
> +#ifndef CONFIG_USER_ONLY
> +    if (!riscv_sdext_enabled(env)) {
> +        return;
> +    }
> +
> +    target_ulong new_priv = env->dcsr & DCSR_PRV_MASK;
> +    bool new_virt = riscv_has_ext(env, RVH) && (env->dcsr & DCSR_V);
> +
> +    if (new_priv > PRV_M) {
> +        new_priv = PRV_M;
> +    }
> +    if (new_priv == PRV_M) {
> +        new_virt = false;
> +    }
> +
> +    if (new_priv == PRV_S && !riscv_has_ext(env, RVS)) {
> +        new_priv = PRV_M;
> +        new_virt = false;
> +    } else if (new_priv == PRV_U && !riscv_has_ext(env, RVU)) {
> +        new_priv = riscv_has_ext(env, RVS) ? PRV_S : PRV_M;
> +        new_virt = false;
> +    }
> +
> +    env->debug_mode = false;
> +    riscv_cpu_set_mode(env, new_priv, new_virt);
> +
> +    if (env_archcpu(env)->cfg.ext_zicfilp) {
> +        env->elp = cpu_get_fcfien(env) && (env->dcsr & DCSR_PELP);
> +        env->dcsr &= ~DCSR_PELP;
> +    }
> +
> +    if (new_priv != PRV_M) {
> +        env->mstatus = set_field(env->mstatus, MSTATUS_MPRV, 0);
> +    }
> +
> +    if (env_archcpu(env)->cfg.ext_smdbltrp && new_priv != PRV_M) {
> +        env->mstatus = set_field(env->mstatus, MSTATUS_MDT, 0);
> +    }
> +    if (env_archcpu(env)->cfg.ext_ssdbltrp && (new_priv == PRV_U || new_virt)) {
> +        env->mstatus = set_field(env->mstatus, MSTATUS_SDT, 0);
> +        if (new_virt && new_priv == PRV_U) {
> +            env->vsstatus = set_field(env->vsstatus, MSTATUS_SDT, 0);
> +        }
> +    }
> +#endif
> +}
> +
>   RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)
>   {
>   #ifndef CONFIG_USER_ONLY
> diff --git a/target/riscv/debug.c b/target/riscv/debug.c
> index 5664466749..5877a60c50 100644
> --- a/target/riscv/debug.c
> +++ b/target/riscv/debug.c
> @@ -927,6 +927,11 @@ void riscv_cpu_debug_excp_handler(CPUState *cs)
>       RISCVCPU *cpu = RISCV_CPU(cs);
>       CPURISCVState *env = &cpu->env;
>   
> +    /* Triggers must not match or fire while in Debug Mode. */
> +    if (env->debug_mode) {
> +        return;
> +    }
> +
>       if (cs->watchpoint_hit) {
>           if (cs->watchpoint_hit->flags & BP_CPU) {
>               do_trigger_action(env, DBG_ACTION_BP);
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index d9fbb5bf58..f80e3413f8 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -266,6 +266,19 @@ static vaddr riscv_pointer_wrap(CPUState *cs, int mmu_idx,
>       }
>       return extract64(result, 0, 64 - pm_len);
>   }
> +
> +static void riscv_cpu_exec_enter(CPUState *cs)
> +{
> +    RISCVCPU *cpu = RISCV_CPU(cs);
> +    CPURISCVState *env = &cpu->env;
> +
> +    if (!cpu->cfg.ext_sdext || !env->debug_mode) {
> +        return;
> +    }
> +    target_ulong pc = env->dpc;
> +    riscv_cpu_leave_debug_mode(env);
> +    env->pc = pc;
> +}
>   #endif
>   
>   const TCGCPUOps riscv_tcg_ops = {
> @@ -282,6 +295,7 @@ const TCGCPUOps riscv_tcg_ops = {
>   #ifndef CONFIG_USER_ONLY
>       .tlb_fill = riscv_cpu_tlb_fill,
>       .pointer_wrap = riscv_pointer_wrap,
> +    .cpu_exec_enter = riscv_cpu_exec_enter,
>       .cpu_exec_interrupt = riscv_cpu_exec_interrupt,
>       .cpu_exec_halt = riscv_cpu_has_work,
>       .cpu_exec_reset = cpu_reset,


