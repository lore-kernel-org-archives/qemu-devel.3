Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D41C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 10:48:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkM9C-0007nS-Ie; Wed, 13 Mar 2024 06:47:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkM9B-0007mb-19
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 06:47:45 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkM98-0005jy-Op
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 06:47:44 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-56845954ffeso5031512a12.2
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 03:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710326860; x=1710931660; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n8fchBLUZk4r9Z/ABP0FYSgp5y3W9g67zIQxvWUWSa4=;
 b=ogsdllSksyGt2VGA/rC/SreirMd8heBQPDglSTQV9wDgC69vru3EZ2XN3YeLa60giV
 e930ZO2ZKAcXS0IjiWnEtYplveVGTnHtr+Ch1mi/M7u6EXvt3+7k92ZC9qmnaBKP39cV
 C4hy8TYMb+jX8Cu5flWa0qdZRIy6m2xNRrC8l7EOChDDzw/1cn1kVdP7OSQZKwX7uY+G
 Y6O1UmjZsKslBRSTPq2oWOArM0u9o8GLu6KtZtRc81A5mMzeNbS+0v+upHCwLNuIsUKw
 A7Nbz5pO1JVn/b5NB3d1sqXaSnIea95YN971H8Ibgk281fA2Z27983kT1LwbSv2O8eZk
 7etQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710326860; x=1710931660;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n8fchBLUZk4r9Z/ABP0FYSgp5y3W9g67zIQxvWUWSa4=;
 b=hQiXElTmZXgr7eIxyqGAW1k2XhhtQ5laE8iifGrjmHZak8MRpU20NvKFrDSe0PNdqr
 KfWCsy6jUZcVd+x6vc3su3pBNh+AkvKRFyr3mXGZs+p8A5jvnvvYas6CD4HPhjnaL4h5
 VpT41YABhWrdCG/DXuBEbxxopmtxDqAZtjHbe/O6BEm5TnpZRhtnL5lLvppH9ON7Y3k5
 7pMSJwXaxylIRl9TuQNyJKj3MzU4yNmkWh8XZAspjx2+rCfZb8D3RX0NSsZxDPCtVgYD
 exed8Lefz3aqOxHvV1QYIed5YlkeGKJtD7rKJnpO4/eZldPlimfzg8CZl8iQcdrNayiT
 sXcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7jRIqGA4AO5mfLHx9yl+pJrF9U1WW+x9kEQr+KgPRoLxfNbvxGjqk/D9ILFssVT60tQ1+BYGgD615pAHaxBp8B21t6wo=
X-Gm-Message-State: AOJu0YyNILKDiz8Cf+jkWDnntc2I+KyAHeXzW856QfbLWDRImw962vgo
 xnQ8erLYDIi85d+Lbw2rHHO73n6oq++ABpnzIk4T1nuUtSTZPiV2UfveO1axNfA=
X-Google-Smtp-Source: AGHT+IE63TT36L/f1A2kH1itFq4SM+6ROo41uXvLaBmPB7tKGk82I8pxXrAu+u15+bUnFWBtMH4Qzg==
X-Received: by 2002:a17:907:a0cc:b0:a46:3814:c3e6 with SMTP id
 hw12-20020a170907a0cc00b00a463814c3e6mr2788566ejc.60.1710326860144; 
 Wed, 13 Mar 2024 03:47:40 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.182.179])
 by smtp.gmail.com with ESMTPSA id
 jx14-20020a170907760e00b00a4635a21ff0sm777960ejc.38.2024.03.13.03.47.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Mar 2024 03:47:39 -0700 (PDT)
Message-ID: <1ae334d6-f009-4e80-bf09-0500fa3486a9@linaro.org>
Date: Wed, 13 Mar 2024 11:47:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] target/riscv: Implement dynamic establishment of
 custom decoder
Content-Language: en-US
To: Huang Tao <eric.huang@linux.alibaba.com>, qemu-devel@nongnu.org,
 dbarboza@ventanamicro.com
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com, liwei1518@gmail.com, 
 bin.meng@windriver.com, alistair.francis@wdc.com, palmer@dabbelt.com,
 Christoph Muellner <christoph.muellner@vrull.eu>
References: <20240313095715.32811-1-eric.huang@linux.alibaba.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240313095715.32811-1-eric.huang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
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

Hi,

On 13/3/24 10:57, Huang Tao wrote:
> In this patch, we modify the decoder to be a freely composable data
> structure instead of a hardcoded one. It can be dynamically builded up
> according to the extensions.
> This approach has several benefits:
> 1. Provides support for heterogeneous cpu architectures. As we add decoder in
>     RISCVCPU, each cpu can have their own decoder, and the decoders can be
>     different due to cpu's features.
> 2. Improve the decoding efficiency. We run the guard_func to see if the decoder
>     can be added to the dynamic_decoder when building up the decoder. Therefore,
>     there is no need to run the guard_func when decoding each instruction. It can
>     improve the decoding efficiency
> 3. For vendor or dynamic cpus, it allows them to customize their own decoder
>     functions to improve decoding efficiency, especially when vendor-defined
>     instruction sets increase. Because of dynamic building up, it can skip the other
>     decoder guard functions when decoding.
> 4. Pre patch for allowing adding a vendor decoder before decode_insn32() with minimal
>     overhead for users that don't need this particular vendor deocder.

Typo "decoder"

> 
> Signed-off-by: Huang Tao <eric.huang@linux.alibaba.com>
> Suggested-by: Christoph Muellner <christoph.muellner@vrull.eu>
> Co-authored-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> ---
> 
> Changes in v3:
> - use GPtrArray to save decode function poionter list.
> ---
>   target/riscv/cpu.c         | 18 ++++++++++++++++++
>   target/riscv/cpu.h         |  2 ++
>   target/riscv/cpu_decoder.h | 34 ++++++++++++++++++++++++++++++++++
>   target/riscv/translate.c   | 29 +++++++++++++----------------
>   4 files changed, 67 insertions(+), 16 deletions(-)
>   create mode 100644 target/riscv/cpu_decoder.h
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 5ff0192c52..9aedd93cf6 100644
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
> @@ -1102,6 +1103,21 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
>   }
>   #endif
>   
> +static void riscv_cpu_finalize_dynamic_decoder(RISCVCPU *cpu)

riscv_tcg_cpu_finalize_dynamic_decoder()

> +{
> +    GPtrArray *dynamic_decoders;
> +    dynamic_decoders = g_ptr_array_sized_new(decoder_table_size);
> +    for (size_t i = 0; i < decoder_table_size; ++i) {
> +        if (decoder_table[i].guard_func &&
> +            decoder_table[i].guard_func(&cpu->cfg)) {
> +            g_ptr_array_add(dynamic_decoders,
> +                            (gpointer)decoder_table[i].decode_fn);
> +        }
> +    }
> +
> +    cpu->decoders = dynamic_decoders;
> +}

Move this function to translate.c and make decoder_table[] static.
Then we don't need the "cpu_decoder.h", it is specific to TCG and
declarations go in "target/riscv/tcg/tcg-cpu.h".

> +
>   void riscv_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
>   {
>       Error *local_err = NULL;
> @@ -1127,6 +1143,8 @@ void riscv_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
>               return;
>           }
>       }
> +
> +    riscv_cpu_finalize_dynamic_decoder(cpu);

Move within the 'if tcg_enabled' block.

>   }
>   
>   static void riscv_cpu_realize(DeviceState *dev, Error **errp)
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 5d291a7092..923721e67a 100644
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
> @@ -457,6 +458,7 @@ struct ArchCPU {
>       uint32_t pmu_avail_ctrs;
>       /* Mapping of events to counters */
>       GHashTable *pmu_event_ctr_map;
> +    const GPtrArray *decoders;
>   };
>   
>   /**
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
> index 177418b2b9..332f0bfd4e 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -115,6 +115,7 @@ typedef struct DisasContext {
>       bool frm_valid;
>       /* TCG of the current insn_start */
>       TCGOp *insn_start;
> +    const GPtrArray *decoders;

Why do we need this reference? We can use env_archcpu(env)->decoders.

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
> @@ -1153,9 +1149,9 @@ static void decode_opc(CPURISCVState *env, DisasContext *ctx, uint16_t opcode)
>                                                ctx->base.pc_next + 2));
>           ctx->opcode = opcode32;
>   
> -        for (size_t i = 0; i < ARRAY_SIZE(decoders); ++i) {
> -            if (decoders[i].guard_func(ctx->cfg_ptr) &&
> -                decoders[i].decode_func(ctx, opcode32)) {
> +        for (guint i = 0; i < ctx->decoders->len; ++i) {
> +            decode_fn func = g_ptr_array_index(ctx->decoders, i);
> +            if (func(ctx, opcode32)) {
>                   return;
>               }
>           }
> @@ -1199,6 +1195,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
>       ctx->itrigger = FIELD_EX32(tb_flags, TB_FLAGS, ITRIGGER);
>       ctx->zero = tcg_constant_tl(0);
>       ctx->virt_inst_excp = false;
> +    ctx->decoders = cpu->decoders;
>   }
>   
>   static void riscv_tr_tb_start(DisasContextBase *db, CPUState *cpu)


