Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E4A6C54798
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 19:55:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riJq4-0001wl-GT; Thu, 07 Mar 2024 14:55:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1riJq3-0001vG-3y
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 14:55:35 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1riJq0-0006db-V7
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 14:55:34 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6e5eb3dd2f8so1004798b3a.2
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 11:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1709841331; x=1710446131; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LAHVN4vQ3tFy3VzoY6N3j2+8oy13NiVFjjwRGu/531Q=;
 b=iykTVupGdzniDycX7Uh3DimH60ughbW9sovEqVRK2oaV1bO9eAnkmeQbx5znnzRPO7
 5zDwleZT+imLkX+xb7niZa4Yuf0DKgwLCha+a3AlRuNdW2ZlS+yAO/LrmpkTL+sNO0a4
 rRjeXjnzKRxfw+1EF9tTbj7NwNJ8B57m3yunwMTV7VfXlypDtAxhGJMQOZu6Kl1cs4jU
 GXCkZM7egNqX/K316wFMK1fox12++oKXoqSKCty6FrHlxr3id8x2dl4QU0DqbulChFun
 g2j1QZkE/IQUH3M1g6pYtromUJqI6E1xFQ25Y6hiwIe2iFY8NaZZI71Mr7gOAfy535Ok
 IUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709841331; x=1710446131;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LAHVN4vQ3tFy3VzoY6N3j2+8oy13NiVFjjwRGu/531Q=;
 b=GZSDixIa1e7xml/Yk2NSjTMVgEJdl1EvmU3S/vYeAEjcNBQKpJISyTVyE32fCT4aTr
 8wJiU9IYhVj4jhDwHTl2JEJw/CDGPamyvbPUug0KQimJcD5SYumlxtX+t5eY4oQusGqz
 AHszu/h2tjH7G/rJM4aHIqgnjJH0gmGUsMGR2iQO7uKodT7dON0CpsJJqVkZuiE+Kuuc
 mag+hMsqjb/E4CFNTfmx79M7zc1A/qaPdUjO1m4Zuv0lIobprsYxO19Tux1uaEOjgOGP
 BHjYdMAKsE2FAjF6jtp2gUombnNOSS58DQuIPJSrKXrqwHK8npVmY2fYXDjju5YnPB/a
 5+ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcW4zBiiMr2xXltj3aHdV3pF4KGuAL/lVA/ePvjmP0rSxoEM0D+io/IfSh8sLa6+FxxLd6Lw4QaBdtnA4xF4L6Q+xyqhw=
X-Gm-Message-State: AOJu0YwCU3yx5pkeNQB7PMZ8vkUCEKza+aQNbgMhUI0TYrfLILZxHUIB
 qSJFl3TLnnorLYc08YbKgKfPzislOtauRI2sgFiIpWsAlf4YE6UWyyXCrdYMt7w=
X-Google-Smtp-Source: AGHT+IFNvDZIBAQZZxRso+26FEmWvXlaUdgVwZlsdwARYlyvIevMwg33JpBxM5bVddv7tC4hxVpipw==
X-Received: by 2002:a05:6a00:6084:b0:6e6:4e6b:5a16 with SMTP id
 fp4-20020a056a00608400b006e64e6b5a16mr4711525pfb.4.1709841331535; 
 Thu, 07 Mar 2024 11:55:31 -0800 (PST)
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 x20-20020a056a000bd400b006e65d66bb3csm1545166pfu.21.2024.03.07.11.55.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 11:55:31 -0800 (PST)
Message-ID: <9b9c1af9-5dca-4270-8dfe-a62223c8cbbb@ventanamicro.com>
Date: Thu, 7 Mar 2024 16:55:25 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Implement dynamic establishment of custom
 decoder
Content-Language: en-US
To: Huang Tao <eric.huang@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com, liwei1518@gmail.com, 
 bin.meng@windriver.com, alistair.francis@wdc.com, palmer@dabbelt.com,
 Christoph Muellner <christoph.muellner@vrull.eu>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240306093308.35188-1-eric.huang@linux.alibaba.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240306093308.35188-1-eric.huang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

(--- adding Richard ---)


On 3/6/24 06:33, Huang Tao wrote:
> In this patch, we modify the decoder to be a freely composable data
> structure instead of a hardcoded one. It can be dynamically builded up
> according to the extensions.
> This approach has several benefits:
> 1. Provides support for heterogeneous cpu architectures. As we add decoder in
>     CPUArchState, each cpu can have their own decoder, and the decoders can be
>     different due to cpu's features.
> 2. Improve the decoding efficiency. We run the guard_func to see if the decoder
>     can be added to the dynamic_decoder when building up the decoder. Therefore,
>     there is no need to run the guard_func when decoding each instruction. It can
>     improve the decoding efficiency
> 3. For vendor or dynamic cpus, it allows them to customize their own decoder
>     functions to improve decoding efficiency, especially when vendor-defined
>     instruction sets increase. Because of dynamic building up, it can skip the other
>     decoder guard functions when decoding.
> 
> Signed-off-by: Huang Tao <eric.huang@linux.alibaba.com>
> Suggested-by: Christoph Muellner <christoph.muellner@vrull.eu>
> Co-authored-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> ---
>   target/riscv/cpu.c         | 20 ++++++++++++++++++++
>   target/riscv/cpu.h         |  2 ++
>   target/riscv/cpu_decoder.h | 34 ++++++++++++++++++++++++++++++++++
>   target/riscv/translate.c   | 28 ++++++++++++----------------
>   4 files changed, 68 insertions(+), 16 deletions(-)
>   create mode 100644 target/riscv/cpu_decoder.h
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 5ff0192c52..cadcd51b4f 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -38,6 +38,7 @@
>   #include "kvm/kvm_riscv.h"
>   #include "tcg/tcg-cpu.h"
>   #include "tcg/tcg.h"
> +#include "cpu_decoder.h"
>   
>   /* RISC-V CPU definitions */
>   static const char riscv_single_letter_exts[] = "IEMAFDQCBPVH";
> @@ -1102,6 +1103,23 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
>   }
>   #endif
>   
> +static void riscv_cpu_finalize_dynamic_decoder(RISCVCPU *cpu)
> +{
> +    CPURISCVState *env = &cpu->env;
> +    decode_fn *dynamic_decoder;
> +    dynamic_decoder = g_new0(decode_fn, decoder_table_size);
> +    int j = 0;
> +    for (size_t i = 0; i < decoder_table_size; ++i) {
> +        if (decoder_table[i].guard_func &&
> +            decoder_table[i].guard_func(&cpu->cfg)) {
> +            dynamic_decoder[j] = decoder_table[i].decode_fn;
> +            j++;
> +        }
> +    }
> +
> +    env->decoder = dynamic_decoder;
> +}
> +
>   void riscv_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
>   {
>       Error *local_err = NULL;
> @@ -1127,6 +1145,8 @@ void riscv_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
>               return;
>           }
>       }
> +
> +    riscv_cpu_finalize_dynamic_decoder(cpu);
>   }
>   
>   static void riscv_cpu_realize(DeviceState *dev, Error **errp)
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 5d291a7092..42bfed065c 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -30,6 +30,7 @@
>   #include "qemu/int128.h"
>   #include "cpu_bits.h"
>   #include "cpu_cfg.h"
> +#include "cpu_decoder.h"
>   #include "qapi/qapi-types-common.h"
>   #include "cpu-qom.h"
>   
> @@ -433,6 +434,7 @@ struct CPUArchState {
>       uint64_t kvm_timer_state;
>       uint64_t kvm_timer_frequency;
>   #endif /* CONFIG_KVM */
> +    const decode_fn *decoder;
>   };
>   
>   /*
> diff --git a/target/riscv/cpu_decoder.h b/target/riscv/cpu_decoder.h
> new file mode 100644
> index 0000000000..549414ce4c
> --- /dev/null
> +++ b/target/riscv/cpu_decoder.h
> @@ -0,0 +1,34 @@
> +/*
> + * QEMU RISC-V CPU Decoder
> + *
> + * Copyright (c) 2023-2024 Alibaba Group
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef RISCV_CPU_DECODER_H
> +#define RISCV_CPU_DECODER_H
> +
> +struct DisasContext;
> +struct RISCVCPUConfig;
> +typedef struct RISCVDecoder {
> +    bool (*guard_func)(const struct RISCVCPUConfig *);
> +    bool (*decode_fn)(struct DisasContext *, uint32_t);
> +} RISCVDecoder;
> +
> +typedef bool (*decode_fn)(struct DisasContext *, uint32_t);
> +
> +extern const size_t decoder_table_size;
> +
> +extern const RISCVDecoder decoder_table[];
> +#endif
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 177418b2b9..23c5321bce 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -115,6 +115,7 @@ typedef struct DisasContext {
>       bool frm_valid;
>       /* TCG of the current insn_start */
>       TCGOp *insn_start;
> +    const decode_fn *decoder;
>   } DisasContext;
>   
>   static inline bool has_ext(DisasContext *ctx, uint32_t ext)
> @@ -1118,21 +1119,16 @@ static inline int insn_len(uint16_t first_word)
>       return (first_word & 3) == 3 ? 4 : 2;
>   }
>   
> +const RISCVDecoder decoder_table[] = {
> +    { always_true_p, decode_insn32 },
> +    { has_xthead_p, decode_xthead},
> +    { has_XVentanaCondOps_p, decode_XVentanaCodeOps},
> +};
> +
> +const size_t decoder_table_size = ARRAY_SIZE(decoder_table);
> +
>   static void decode_opc(CPURISCVState *env, DisasContext *ctx, uint16_t opcode)
>   {
> -    /*
> -     * A table with predicate (i.e., guard) functions and decoder functions
> -     * that are tested in-order until a decoder matches onto the opcode.
> -     */
> -    static const struct {
> -        bool (*guard_func)(const RISCVCPUConfig *);
> -        bool (*decode_func)(DisasContext *, uint32_t);
> -    } decoders[] = {
> -        { always_true_p,  decode_insn32 },
> -        { has_xthead_p, decode_xthead },
> -        { has_XVentanaCondOps_p,  decode_XVentanaCodeOps },
> -    };
> -
>       ctx->virt_inst_excp = false;
>       ctx->cur_insn_len = insn_len(opcode);
>       /* Check for compressed insn */
> @@ -1153,9 +1149,8 @@ static void decode_opc(CPURISCVState *env, DisasContext *ctx, uint16_t opcode)
>                                                ctx->base.pc_next + 2));
>           ctx->opcode = opcode32;
>   
> -        for (size_t i = 0; i < ARRAY_SIZE(decoders); ++i) {
> -            if (decoders[i].guard_func(ctx->cfg_ptr) &&
> -                decoders[i].decode_func(ctx, opcode32)) {
> +        for (size_t i = 0; i < decoder_table_size; ++i) {
> +            if (ctx->decoder[i](ctx, opcode32)) {
>                   return;
>               }
>           }
> @@ -1199,6 +1194,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
>       ctx->itrigger = FIELD_EX32(tb_flags, TB_FLAGS, ITRIGGER);
>       ctx->zero = tcg_constant_tl(0);
>       ctx->virt_inst_excp = false;
> +    ctx->decoder = env->decoder;


Up there, in riscv_cpu_finalize_dynamic_decoder(), we assigned a dynamic decoder in
env->decoder. The DisasContext 'decoder' pointer is then assigned to env->decoder in
every tr_init_disas_context() here.

'ctx->decoder' is used in decode_opc(), that receives a CPURISCVState *env pointer as
a parameter.

Am I missing something? It seems we can just remove the ctx->decode pointer altogether
and use env->decoder.


Thanks,

Daniel



>   }
>   
>   static void riscv_tr_tb_start(DisasContextBase *db, CPUState *cpu)

