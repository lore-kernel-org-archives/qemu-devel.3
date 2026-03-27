Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C27F510BA422
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 04:15:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5yb9-0006tv-Bd; Fri, 27 Mar 2026 00:15:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w5yb7-0006tK-KC
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 00:15:01 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w5yb5-00043E-OA
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 00:15:01 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2a8fba3f769so7078395ad.2
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 21:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774584898; x=1775189698; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rfFYIlpzNHk2zeOvZkib3A3vy/jnnzQMvBbUrq2adIw=;
 b=CPPnyMOQjCNoSYRhLJ6SrHTNDomwIzkPvvrzk9Tq6FCmrLUv7FV72tWy5WSBSxHY8z
 z0OgJSM+4S/EjQPgaGRMxO+aomMXft7siSXgLskvQt66RcALCH3FYoCvFPxtAMAt6U29
 OfiIa9FZylTVS3YWMDnHyKOQTYuHnHLAK0VZayPaCjIMXRuTjIzH38rPSV/Jzcs62OVj
 wjd+DpEaFpwhrzmHE78BXOMJEp/4CTV6g9X+ZPwwmyntOOi3pgFe/QHvnLdmTnYq3+Xr
 6QzE5UDOz7F86p9PSnwXH8I3BBmNI+G76VxZ484ACWOeMy8dDlpV6XYs1RclsjOMFxk5
 59RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774584898; x=1775189698;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rfFYIlpzNHk2zeOvZkib3A3vy/jnnzQMvBbUrq2adIw=;
 b=YnBMb9QZBHAxcswDO1kpYxi/J4o4GDiPQ49qfTw9oqmMUL4Jl97yVaNc8kTtjT4hfn
 DdLjgi5A3wEV7KgQga4qKDg/0ut11k5GBFdr579tqrYG8mYudGVGTvDc+bwV8VPqKrTb
 S3tWMBSNgDw8smYdOCC6FSspb+qDgY/e6EyVMH8Vxco8UbUBeCQdumXRFvbM8fMP7MMC
 PvvWVmBL7/FEI+FzznVNZ17pOFt2jzpXb5t5beGxtCZJbtD8yyZXPVhDb02ydQ2NNV3K
 y790jcVwox59CZTxLkKz/0tmu80rWL40810JMu23Rn/kzllBaPXNd3FPB+DMqExj4dGR
 WSdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+Uj4t5BPoXfKmwbRP+0FENtASXDc6ev8q0EHz2NnmbRZavgAWGzLYmFIeg415ocGvxvDsXNasDrKK@nongnu.org
X-Gm-Message-State: AOJu0Yx5blvOay3fm0aQbosZU25lM/bigTudzuyBrOZV3HfqFseSyLPs
 VMQSab3QpWGjXVqGaoKfUPSCmN23poE2HfaG5VWGiSTXaz+fpiv90Wh/WOQmRMUekak=
X-Gm-Gg: ATEYQzwElbXhtYLZtwNJAYrG336qkB2ecPp+4QKn3rWYA3tiPhd+51KI4/IPDI0iXYY
 6r/92A0kYY80G9rLZ1/n4hi+0UB14sa+59M45x2fGspnEC23ghdAlaMzRY+fDDIStiF+nMoHhf6
 2s+0AJW31R9RJN51sfl2NY4mL7yGbdUzRxx3uVQhToOHM/9XMNljbeJGmYus4VLJKv5CxPWEjTv
 sfNPe3chsxZ4FYBY7KInye0fhZVa2+SeEjIk4yDe88Pyk/tz0WI1aZ+etx+tB2+9HlIm7pcLfn5
 bXs7xN+J8JNmoTor+igAfdfalImsCvFw7eP+32xU3ExcF1rgxITa/JQsQsEqM8MOH2FzkZJwsKw
 fSLsETr4l4Og0YfUikh6P/1/sPgDkatY+D7d73gwMv+1SmqTRPq7z41JjlStZNQTQ6uYy+VXNHn
 bxuVps1slZBzKOh1HFJvNg7WPvb4oYnG/stFEcTarQcg==
X-Received: by 2002:a17:902:e952:b0:2b0:571f:6f09 with SMTP id
 d9443c01a7336-2b0cdcd5695mr13332295ad.44.1774584897703; 
 Thu, 26 Mar 2026 21:14:57 -0700 (PDT)
Received: from [172.16.11.156] ([103.100.225.140])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b0bc8fb099sm43418685ad.72.2026.03.26.21.14.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Mar 2026 21:14:57 -0700 (PDT)
Message-ID: <dcab4982-1ced-43d8-ae32-5477604054ed@linaro.org>
Date: Fri, 27 Mar 2026 14:14:49 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/7] target/riscv: Implement runtime data endianness
 via MSTATUS bits
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>
References: <20260324164007.549397-1-djordje.todorovic@htecgroup.com>
 <20260324164007.549397-4-djordje.todorovic@htecgroup.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260324164007.549397-4-djordje.todorovic@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

I replied to v4 before I saw a v5 was already posted:
https://lore.kernel.org/qemu-devel/d974df44-b46e-4e51-9eec-b46e391c3462@linaro.org/

On 3/25/26 02:40, Djordje Todorovic wrote:
> Implement runtime big-endian data support by reading the MSTATUS
> UBE/SBE/MBE bits to determine data endianness per privilege level.
> 
> The key changes are:
> 
> - Add riscv_cpu_data_is_big_endian() helper in cpu.h that checks
>    the appropriate MSTATUS endianness bit based on current privilege
>    level (MBE for M-mode, SBE for S-mode, UBE for U-mode).
> 
> - Update mo_endian() in translate.c to return MO_BE or MO_LE based
>    on a new 'big_endian' field in DisasContext, rather than the
>    previous hardcoded MO_TE.
> 
> - Update mo_endian_env() in op_helper.c to call the new helper,
>    giving hypervisor load/store helpers correct runtime endianness.
> 
> - Pack the endianness flag into cs_base bit 32 (alongside misa_ext
>    in bits 0-25) in riscv_get_tb_cpu_state(), ensuring translation
>    blocks are correctly separated by data endianness.
> 
> Note: instruction fetches continue to use MO_LE unconditionally
> (from the previous patch), as RISC-V instructions are always
> little-endian per the ISA specification.
> 
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> ---
>   target/riscv/cpu.h         | 28 ++++++++++++++++++++++++++++
>   target/riscv/internals.h   |  9 +--------
>   target/riscv/tcg/tcg-cpu.c |  9 ++++++++-
>   target/riscv/translate.c   | 12 ++++--------
>   4 files changed, 41 insertions(+), 17 deletions(-)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 35d1f6362c..ef870d05b3 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -703,6 +703,12 @@ FIELD(TB_FLAGS, BCFI_ENABLED, 28, 1)
>   FIELD(TB_FLAGS, PM_PMM, 29, 2)
>   FIELD(TB_FLAGS, PM_SIGNEXTEND, 31, 1)
>   
> +/*
> + * cs_base carries misa_ext (bits 0-25) plus additional flags.
> + * Bit 32 is used for data endianness since TB_FLAGS has no free bits.
> + */
> +#define TB_CSBASE_BIG_ENDIAN  (1ULL << 32)
> +
>   #ifdef TARGET_RISCV32
>   #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
>   #else
> @@ -718,6 +724,28 @@ static inline const RISCVCPUConfig *riscv_cpu_cfg(CPURISCVState *env)
>       return &env_archcpu(env)->cfg;
>   }
>   
> +/*
> + * Return true if data accesses are big-endian for the current privilege
> + * level, based on the MSTATUS MBE/SBE/UBE bits.
> + */
> +static inline bool riscv_cpu_data_is_big_endian(CPURISCVState *env)
> +{
> +#if defined(CONFIG_USER_ONLY)
> +    return false;
> +#else
> +    switch (env->priv) {
> +    case PRV_M:
> +        return env->mstatus & MSTATUS_MBE;
> +    case PRV_S:
> +        return env->mstatus & MSTATUS_SBE;
> +    case PRV_U:
> +        return env->mstatus & MSTATUS_UBE;
> +    default:
> +        g_assert_not_reached();
> +    }
> +#endif
> +}
> +
>   #if !defined(CONFIG_USER_ONLY)
>   static inline int cpu_address_mode(CPURISCVState *env)
>   {
> diff --git a/target/riscv/internals.h b/target/riscv/internals.h
> index 460346dd6d..e2f0334da8 100644
> --- a/target/riscv/internals.h
> +++ b/target/riscv/internals.h
> @@ -64,14 +64,7 @@ static inline bool mmuidx_2stage(int mmu_idx)
>   
>   static inline MemOp mo_endian_env(CPURISCVState *env)
>   {
> -    /*
> -     * A couple of bits in MSTATUS set the endianness:
> -     *  - MSTATUS_UBE (User-mode),
> -     *  - MSTATUS_SBE (Supervisor-mode),
> -     *  - MSTATUS_MBE (Machine-mode)
> -     * but we don't implement that yet.
> -     */
> -    return MO_LE;
> +    return riscv_cpu_data_is_big_endian(env) ? MO_BE : MO_LE;
>   }
>   
>   /* share data between vector helpers and decode code */
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 3407191c22..fa42197e98 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -189,10 +189,17 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
>       flags = FIELD_DP32(flags, TB_FLAGS, PM_PMM, riscv_pm_get_pmm(env));
>       flags = FIELD_DP32(flags, TB_FLAGS, PM_SIGNEXTEND, pm_signext);
>   
> +    uint64_t cs_base = env->misa_ext;
> +#ifndef CONFIG_USER_ONLY
> +    if (riscv_cpu_data_is_big_endian(env)) {
> +        cs_base |= TB_CSBASE_BIG_ENDIAN;
> +    }
> +#endif
> +
>       return (TCGTBCPUState){
>           .pc = env->xl == MXL_RV32 ? env->pc & UINT32_MAX : env->pc,
>           .flags = flags,
> -        .cs_base = env->misa_ext,
> +        .cs_base = cs_base,
>       };
>   }
>   
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 5df5b73849..d7f1f8e466 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -119,6 +119,8 @@ typedef struct DisasContext {
>       bool fcfi_lp_expected;
>       /* zicfiss extension, if shadow stack was enabled during TB gen */
>       bool bcfi_enabled;
> +    /* Data endianness from MSTATUS UBE/SBE/MBE */
> +    bool big_endian;
>   } DisasContext;
>   
>   static inline bool has_ext(DisasContext *ctx, uint32_t ext)
> @@ -128,14 +130,7 @@ static inline bool has_ext(DisasContext *ctx, uint32_t ext)
>   
>   static inline MemOp mo_endian(DisasContext *ctx)
>   {
> -    /*
> -     * A couple of bits in MSTATUS set the endianness:
> -     *  - MSTATUS_UBE (User-mode),
> -     *  - MSTATUS_SBE (Supervisor-mode),
> -     *  - MSTATUS_MBE (Machine-mode)
> -     * but we don't implement that yet.
> -     */
> -    return MO_LE;
> +    return ctx->big_endian ? MO_BE : MO_LE;
>   }
>   
>   #ifdef TARGET_RISCV32
> @@ -1346,6 +1341,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
>       ctx->zero = tcg_constant_tl(0);
>       ctx->virt_inst_excp = false;
>       ctx->decoders = cpu->decoders;
> +    ctx->big_endian = ctx->base.tb->cs_base & TB_CSBASE_BIG_ENDIAN;
>   }
>   
>   static void riscv_tr_tb_start(DisasContextBase *db, CPUState *cpu)


