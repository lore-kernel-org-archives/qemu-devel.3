Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49982F46435
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 09:31:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w24IB-0000GH-5O; Mon, 16 Mar 2026 05:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1w24I5-0000Da-17
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 05:31:13 -0400
Received: from mail-qk1-x72f.google.com ([2607:f8b0:4864:20::72f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1w24I3-0005Ri-50
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 05:31:12 -0400
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-8cd847b4b23so408358485a.0
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 02:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1773653468; x=1774258268; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iFquTBZU68gcvUODdxMTf6KDKLVI1yO7RtTuaFD7pjk=;
 b=Ye+eeFSdbfy8d5PhMVGKYSuA4PiG4Goi0t84rG5lvnvP6TSN+DRWtbTzksXAHJwctO
 JkWQxLQ7xB0uPGTnx1bYqwowK9v5s7ZCPozLrXgJFMtFw3wxB7COfZvdECk29ICBos1E
 4Hhmjn+VSeTk3sGStC1nd8LWSNPyDWImob9hFPx/kE5LY3zxsFKqdGSUppImXuBMhgyx
 Da32EAak7V17/XaQJwkIqTcY9RfwImVB4Ycx0TORzwSVzDcmbqOgaKheAwcwWdVlZCY7
 tONUeuKhRc18U4mVloq6BMwF0kn9vtZGVaAiB7FpiFON7jRBT3f+WA1aEWVgAo/vfw3i
 mX6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773653468; x=1774258268;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iFquTBZU68gcvUODdxMTf6KDKLVI1yO7RtTuaFD7pjk=;
 b=RJcSLRzPe+HiRSSJ6OXJ6y8HITN36c6fMlUSpbQRNdCYOtz8G7i/mVHkvMuNCcxa49
 RnA3xiV5XK8pJ6rGSXvbXqYEeiehNmAywMJx7B+nu7BFpBWuy1Vaerc8gTJg6c3qeNM8
 vXniEWMOVVEU7wbmws8w2Fk0GivjBZGLuhve0ZsbiqMXDI5oY4fkCM5q0348tXr9Mczb
 3lL9+ehvda2PJ4GpUqrQeG2QvRS8PyTRSdj/XINb02GkN8D0aq80/0llPGsUiUrWX5tL
 P2ITJ2jrwZJ7MXXw8+u7dqdJ3nZvxyI5caQmOBiUf2ueVAnuJhqr/OkppXgq2hWqDPDk
 OCpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/uLPs5VFgDjfOdWgvrzX3+INNzlaoj+RGOHCKu/W7t12f3QJQo8oUJVvKuzc4ujuBGJWgSaEW7nsn@nongnu.org
X-Gm-Message-State: AOJu0YzavQqgZJHbkdJPvCYvD3JLytpjaBxKULeheM62vOwgWfkxymgX
 BweM750m8mkKyPoTmCUCI+guFIFIOl4oWWrKRk6DJNZYAH5j9GZIF+3yapTsKchaIDI=
X-Gm-Gg: ATEYQzz3KDz7Taj4RrdeUHHSJs5AU9pL+t/SqUus6T/4aTGo5ED1EJ1q/gtJfc243zB
 9YtM6sywCoisFzUjDhddjGd5AJlG0QWtVWSdO6ve7fTD5BuC9v/NEZXCJFQzZ1xtswjLb6t89rV
 T/2bFyFqzsfrE6cW/XTn8r3BZuzrw9W3g3VoNWoUEpyezztt7XCbtrr7ZwDIXkReaWqzJrqpxE2
 YesYnaFF7uMUYBfffmA5NBwlKC3YG9kZa9DURLj/b3PubVEmaw+JEZ8e1SgkNhpaXKGRaRODkVO
 LxgesOwi+Y6RckX8ltwNEOwoTou2IrV/Z02pDuOQWwN8oyIVILJSia9sYWChp1iuBCTOarVN1Vt
 fjXBTdbVxWaEj0qcWidspOiHMO32e9ew42qtV0EcYeGx5NsCUYy+frsEb23Lm4qhgB5r6QACJn0
 fBTSCXxDz/CllsVs4wTnl5UfGgXGnNk8aMx35vcg47qMXpYFPKguN9
X-Received: by 2002:a05:620a:2981:b0:8cd:96e5:f7be with SMTP id
 af79cd13be357-8cdb5b7cae0mr1600996185a.69.1773653467638; 
 Mon, 16 Mar 2026 02:31:07 -0700 (PDT)
Received: from [192.168.68.100] ([152.250.131.163])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cda2112f5bsm1361113985a.32.2026.03.16.02.31.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2026 02:31:07 -0700 (PDT)
Message-ID: <eae24955-2500-4d5c-bf78-d65d7f7e9f1a@ventanamicro.com>
Date: Mon, 16 Mar 2026 06:31:03 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] target/riscv: Restrict access to RV128 registers on
 RV32
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBQw6l0cm90?=
 <frederic.petrot@univ-grenoble-alpes.fr>,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
References: <20260315165949.40027-1-philmd@linaro.org>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20260315165949.40027-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-qk1-x72f.google.com
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



On 3/15/2026 1:59 PM, Philippe Mathieu-Daudé wrote:
> One half of 128-bit registers code is not reachable for CPUs
> running in 32-bit mode, while the other half is completely
> broken (handled as a pair of 32-bit registers).
> Better restrict this code on 32-bit builds until RV128 is
> properly implemented.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---

I agree with the premise that if it's not properly implemented for
32 bits we should restrict it.

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

> More than 1y having issue with the 128-bit code path and
> the single binary effort. Fortunately while I dunno how to
> test 128-bit I could with 32/64 bits.
> ---


Not sure how you're tacking this effort in the risc-v front (let me
know if you need help btw) but in a quick glance seems like every
"IF TARGET_RISCV32" could be changed to

get_xl(ctx) == MXL_RV32

And same thing with TARGET_RISCV64 and MXL_RV64.  And in theory the same
thing for 128 too - the rv128 CPU will exist in the same binary as the
other ones, ergo it must behave nicely according to get_xl = MXL_128
alone.


Thanks,
Daniel



>   target/riscv/cpu.h                          |  2 ++
>   target/riscv/machine.c                      |  4 +++
>   target/riscv/monitor.c                      |  4 +++
>   target/riscv/translate.c                    | 31 +++++++++++++++++++--
>   target/riscv/insn_trans/trans_rvzacas.c.inc |  2 ++
>   5 files changed, 41 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 633d5301f30..94f4daa06e7 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -214,7 +214,9 @@ typedef struct PMUFixedCtrState {
>   
>   struct CPUArchState {
>       target_ulong gpr[32];
> +#if defined(TARGET_RISCV64)
>       target_ulong gprh[32]; /* 64 top bits of the 128-bit registers */
> +#endif
>   
>       /* vector coprocessor state. */
>       uint64_t vreg[32 * RV_VLEN_MAX / 64] QEMU_ALIGNED(16);
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index 09c032a8791..e220e562ff4 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -168,6 +168,7 @@ static const VMStateDescription vmstate_pointermasking = {
>       }
>   };
>   
> +#ifdef TARGET_RISCV64
>   static bool rv128_needed(void *opaque)
>   {
>       RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(opaque);
> @@ -187,6 +188,7 @@ static const VMStateDescription vmstate_rv128 = {
>           VMSTATE_END_OF_LIST()
>       }
>   };
> +#endif
>   
>   #ifdef CONFIG_KVM
>   static bool kvmtimer_needed(void *opaque)
> @@ -487,7 +489,9 @@ const VMStateDescription vmstate_riscv_cpu = {
>           &vmstate_hyper,
>           &vmstate_vector,
>           &vmstate_pointermasking,
> +#ifdef TARGET_RISCV64
>           &vmstate_rv128,
> +#endif
>   #ifdef CONFIG_KVM
>           &vmstate_kvmtimer,
>   #endif
> diff --git a/target/riscv/monitor.c b/target/riscv/monitor.c
> index a9d31114442..b99a4e6ec18 100644
> --- a/target/riscv/monitor.c
> +++ b/target/riscv/monitor.c
> @@ -251,8 +251,12 @@ static bool reg_is_ulong_integer(CPURISCVState *env, const char *name,
>       target_ulong *vals;
>   
>       if (is_gprh) {
> +#ifdef TARGET_RISCV64
>           reg_names = riscv_int_regnamesh;
>           vals = env->gprh;
> +#else
> +        g_assert_not_reached();
> +#endif
>       } else {
>           reg_names = riscv_int_regnames;
>           vals = env->gpr;
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 6d0f316ef1e..5b4a9934e83 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -38,7 +38,10 @@
>   #include "tcg/tcg-cpu.h"
>   
>   /* global register indices */
> -static TCGv cpu_gpr[32], cpu_gprh[32], cpu_pc, cpu_vl, cpu_vstart;
> +static TCGv cpu_gpr[32], cpu_pc, cpu_vl, cpu_vstart;
> +#ifdef TARGET_RISCV64
> +static TCGv cpu_gprh[32];
> +#endif
>   static TCGv_i64 cpu_fpr[32]; /* assume F and D extensions */
>   static TCGv load_res;
>   static TCGv load_val;
> @@ -374,11 +377,15 @@ static TCGv get_gpr(DisasContext *ctx, int reg_num, DisasExtend ext)
>   
>   static TCGv get_gprh(DisasContext *ctx, int reg_num)
>   {
> +#ifdef TARGET_RISCV64
>       assert(get_xl(ctx) == MXL_RV128);
>       if (reg_num == 0) {
>           return ctx->zero;
>       }
>       return cpu_gprh[reg_num];
> +#else
> +    g_assert_not_reached();
> +#endif
>   }
>   
>   static TCGv dest_gpr(DisasContext *ctx, int reg_num)
> @@ -391,10 +398,14 @@ static TCGv dest_gpr(DisasContext *ctx, int reg_num)
>   
>   static TCGv dest_gprh(DisasContext *ctx, int reg_num)
>   {
> +#ifdef TARGET_RISCV64
>       if (reg_num == 0) {
>           return tcg_temp_new();
>       }
>       return cpu_gprh[reg_num];
> +#else
> +    g_assert_not_reached();
> +#endif
>   }
>   
>   static void gen_set_gpr(DisasContext *ctx, int reg_num, TCGv t)
> @@ -404,17 +415,21 @@ static void gen_set_gpr(DisasContext *ctx, int reg_num, TCGv t)
>           case MXL_RV32:
>               tcg_gen_ext32s_tl(cpu_gpr[reg_num], t);
>               break;
> +#ifdef TARGET_RISCV64
>           case MXL_RV64:
>           case MXL_RV128:
>               tcg_gen_mov_tl(cpu_gpr[reg_num], t);
>               break;
> +#endif
>           default:
>               g_assert_not_reached();
>           }
>   
> +#ifdef TARGET_RISCV64
>           if (get_xl_max(ctx) == MXL_RV128) {
>               tcg_gen_sari_tl(cpu_gprh[reg_num], cpu_gpr[reg_num], 63);
>           }
> +#endif
>       }
>   }
>   
> @@ -425,27 +440,35 @@ static void gen_set_gpri(DisasContext *ctx, int reg_num, target_long imm)
>           case MXL_RV32:
>               tcg_gen_movi_tl(cpu_gpr[reg_num], (int32_t)imm);
>               break;
> +#ifdef TARGET_RISCV64
>           case MXL_RV64:
>           case MXL_RV128:
>               tcg_gen_movi_tl(cpu_gpr[reg_num], imm);
>               break;
> +#endif
>           default:
>               g_assert_not_reached();
>           }
>   
> +#ifdef TARGET_RISCV64
>           if (get_xl_max(ctx) == MXL_RV128) {
>               tcg_gen_movi_tl(cpu_gprh[reg_num], -(imm < 0));
>           }
> +#endif
>       }
>   }
>   
>   static void gen_set_gpr128(DisasContext *ctx, int reg_num, TCGv rl, TCGv rh)
>   {
> +#ifdef TARGET_RISCV64
>       assert(get_ol(ctx) == MXL_RV128);
>       if (reg_num != 0) {
>           tcg_gen_mov_tl(cpu_gpr[reg_num], rl);
>           tcg_gen_mov_tl(cpu_gprh[reg_num], rh);
>       }
> +#else
> +    g_assert_not_reached();
> +#endif
>   }
>   
>   static TCGv_i64 get_fpr_hs(DisasContext *ctx, int reg_num)
> @@ -1453,14 +1476,18 @@ void riscv_translate_init(void)
>        * unless you specifically block reads/writes to reg 0.
>        */
>       cpu_gpr[0] = NULL;
> -    cpu_gprh[0] = NULL;
>   
>       for (i = 1; i < 32; i++) {
>           cpu_gpr[i] = tcg_global_mem_new(tcg_env,
>               offsetof(CPURISCVState, gpr[i]), riscv_int_regnames[i]);
> +    }
> +#ifdef TARGET_RISCV64
> +    cpu_gprh[0] = NULL;
> +    for (i = 1; i < 32; i++) {
>           cpu_gprh[i] = tcg_global_mem_new(tcg_env,
>               offsetof(CPURISCVState, gprh[i]), riscv_int_regnamesh[i]);
>       }
> +#endif
>   
>       for (i = 0; i < 32; i++) {
>           cpu_fpr[i] = tcg_global_mem_new_i64(tcg_env,
> diff --git a/target/riscv/insn_trans/trans_rvzacas.c.inc b/target/riscv/insn_trans/trans_rvzacas.c.inc
> index 8d94b83ce94..8cf7cbd4599 100644
> --- a/target/riscv/insn_trans/trans_rvzacas.c.inc
> +++ b/target/riscv/insn_trans/trans_rvzacas.c.inc
> @@ -55,10 +55,12 @@ static void gen_set_gpr_pair(DisasContext *ctx, int reg_num, TCGv_i64 t)
>           tcg_gen_sari_i64(cpu_gpr[reg_num + 1], t, 32);
>   #endif
>   
> +#ifdef TARGET_RISCV64
>           if (get_xl_max(ctx) == MXL_RV128) {
>               tcg_gen_sari_tl(cpu_gprh[reg_num], cpu_gpr[reg_num], 63);
>               tcg_gen_sari_tl(cpu_gprh[reg_num + 1], cpu_gpr[reg_num + 1], 63);
>           }
> +#endif
>       }
>   }
>   


