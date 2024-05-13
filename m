Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA4ABC25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 10:28:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6SuR-0000CO-5T; Mon, 13 May 2024 06:27:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s6SuN-0000Bd-D3; Mon, 13 May 2024 06:27:51 -0400
Received: from mail-ua1-x931.google.com ([2607:f8b0:4864:20::931])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s6SuI-0001M1-Ca; Mon, 13 May 2024 06:27:49 -0400
Received: by mail-ua1-x931.google.com with SMTP id
 a1e0cc1a2514c-7f7eb08923aso1350695241.3; 
 Mon, 13 May 2024 03:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715596065; x=1716200865; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jVd7GpipVORDUN+d6tsuh7qbMdifShUhNFXObR3POf0=;
 b=SqqjfSlKkP/ovc8o+jeUBfT2umaSTA95IDj4PxeHWWnOz1cG2fyq20cMsprIUVUM7K
 34x6MmzSNNt2wptXF/3N/UEm2Z7CQqTj+04EwmrJyZvYmcKnPMOB3It17O5whN4Fz9g+
 CCEZhEYiW9JYCwDmxHyVMvjTaP5Yxey2Fb6xf1OHWraCFiufiJlrRtMJgQ06/b1rD/DS
 MhFPGaP/fzHBhqEMGeR7ABL9jTonBAALKSG1/D8hVBiAbBjZ8EDzayu4qbOQtBwOQGnX
 x+Z47vQqAAYPeW9E8dRE6I4C7M/7JPaginMOj77Ye0YY1thnLFm049MB//kqa3SdyTHe
 BKyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715596065; x=1716200865;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jVd7GpipVORDUN+d6tsuh7qbMdifShUhNFXObR3POf0=;
 b=uEEwbAyztPaaPGg9KwICJU87sbKnR1HvVM+ZUfMu4gugBSwTG6dpk1/7cTX+cghCmL
 1OWHCdGrtPSBOoFRZFErx024Y4kMnt41J1XG+zAbfjdIobkItNcHmBlrbfag8FLaMU00
 PKaZmWY3XJSG43f8vZVsLkd5Cmp2YPV2GOF0gAEDZdogiDxpXipjJ3ctz3hcdial47Ii
 IkQ0wKe51hauExr6RUZ5AJgXE1OARFrrAvGys+XILORnGJRp5PqxYkbeniOmZ35pocxa
 /xFBCjcRrNVSpTqyk3nuvBgeCJJ6zYOYVTcwYoEdFyN+QNQi/r0Iv+vdIsoZx1HCCU/N
 QcEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVT83J0PIpyPR4MtF4HjQxx2TR3u4YXtgY5+fsBJnEoNzeWyHvYNKNXhswwbYtihsz4OO4hgHJVzsal7dw6ZvNAJOdNll4=
X-Gm-Message-State: AOJu0YwN+9E4/qwLWZzIqbPohrPDeKmbHU6bq0a2LQaLV98JUMlMGo0D
 9hXq+4GNYKrKq5sNFC/f8/6nqC4wM4FyW76idezeLSDQH3lrvK7o5wY4zEA7ZqjwIrN42xmYRez
 SeqsBAiN6yYMScuTx6Hdj+65ooxU=
X-Google-Smtp-Source: AGHT+IGaS4rzAG4Scm5wZQu0v+1601nkLPC4aW5lY0rIleyHYVjetrE9PasLk/espCgFoRXIqc7a24mLrq/vTHo0JzE=
X-Received: by 2002:a05:6102:3596:b0:47e:ecb:4f12 with SMTP id
 ada2fe7eead31-48077e12551mr8498336137.21.1715596064754; Mon, 13 May 2024
 03:27:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240506023607.29544-1-eric.huang@linux.alibaba.com>
In-Reply-To: <20240506023607.29544-1-eric.huang@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 13 May 2024 20:27:18 +1000
Message-ID: <CAKmqyKNNL3mnnLJjO0UA32mZYgHw1QOeZFZMJv0aDCcb0prjpA@mail.gmail.com>
Subject: Re: [PATCH v5] target/riscv: Implement dynamic establishment of
 custom decoder
To: Huang Tao <eric.huang@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com, 
 alistair.francis@wdc.com, palmer@dabbelt.com, 
 Christoph Muellner <christoph.muellner@vrull.eu>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::931;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x931.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Mon, May 6, 2024 at 12:37=E2=80=AFPM Huang Tao <eric.huang@linux.alibaba=
.com> wrote:
>
> In this patch, we modify the decoder to be a freely composable data
> structure instead of a hardcoded one. It can be dynamically builded up
> according to the extensions.
> This approach has several benefits:
> 1. Provides support for heterogeneous cpu architectures. As we add decode=
r in
>    RISCVCPU, each cpu can have their own decoder, and the decoders can be
>    different due to cpu's features.
> 2. Improve the decoding efficiency. We run the guard_func to see if the d=
ecoder
>    can be added to the dynamic_decoder when building up the decoder. Ther=
efore,
>    there is no need to run the guard_func when decoding each instruction.=
 It can
>    improve the decoding efficiency
> 3. For vendor or dynamic cpus, it allows them to customize their own deco=
der
>    functions to improve decoding efficiency, especially when vendor-defin=
ed
>    instruction sets increase. Because of dynamic building up, it can skip=
 the other
>    decoder guard functions when decoding.
> 4. Pre patch for allowing adding a vendor decoder before decode_insn32() =
with minimal
>    overhead for users that don't need this particular vendor decoder.
>
> Signed-off-by: Huang Tao <eric.huang@linux.alibaba.com>
> Suggested-by: Christoph Muellner <christoph.muellner@vrull.eu>
> Co-authored-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
> Changes in v5:
> - rebase on https://github.com/alistair23/qemu/tree/riscv-to-apply.next
>
> Changes in v4:
> - fix typo
> - rename function
> - add 'if tcg_enable()'
> - move function to tcg-cpu.c and declarations to tcg-cpu.h
>
> Changes in v3:
> - use GPtrArray to save decode function poionter list.
> ---
>  target/riscv/cpu.c         |  1 +
>  target/riscv/cpu.h         |  1 +
>  target/riscv/tcg/tcg-cpu.c | 15 +++++++++++++++
>  target/riscv/tcg/tcg-cpu.h | 15 +++++++++++++++
>  target/riscv/translate.c   | 31 +++++++++++++++----------------
>  5 files changed, 47 insertions(+), 16 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index a74f0eb29c..2cb145121d 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1134,6 +1134,7 @@ void riscv_cpu_finalize_features(RISCVCPU *cpu, Err=
or **errp)
>              error_propagate(errp, local_err);
>              return;
>          }
> +        riscv_tcg_cpu_finalize_dynamic_decoder(cpu);
>      } else if (kvm_enabled()) {
>          riscv_kvm_cpu_finalize_features(cpu, &local_err);
>          if (local_err !=3D NULL) {
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index e0dd1828b5..2838d9640b 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -455,6 +455,7 @@ struct ArchCPU {
>      uint32_t pmu_avail_ctrs;
>      /* Mapping of events to counters */
>      GHashTable *pmu_event_ctr_map;
> +    const GPtrArray *decoders;
>  };
>
>  /**
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 4ebebebe09..3a4ec3662a 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -863,6 +863,21 @@ void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, =
Error **errp)
>      }
>  }
>
> +void riscv_tcg_cpu_finalize_dynamic_decoder(RISCVCPU *cpu)
> +{
> +    GPtrArray *dynamic_decoders;
> +    dynamic_decoders =3D g_ptr_array_sized_new(decoder_table_size);
> +    for (size_t i =3D 0; i < decoder_table_size; ++i) {
> +        if (decoder_table[i].guard_func &&
> +            decoder_table[i].guard_func(&cpu->cfg)) {
> +            g_ptr_array_add(dynamic_decoders,
> +                            (gpointer)decoder_table[i].riscv_cpu_decode_=
fn);
> +        }
> +    }
> +
> +    cpu->decoders =3D dynamic_decoders;
> +}
> +
>  bool riscv_cpu_tcg_compatible(RISCVCPU *cpu)
>  {
>      return object_dynamic_cast(OBJECT(cpu), TYPE_RISCV_CPU_HOST) =3D=3D =
NULL;
> diff --git a/target/riscv/tcg/tcg-cpu.h b/target/riscv/tcg/tcg-cpu.h
> index f7b32417f8..ce94253fe4 100644
> --- a/target/riscv/tcg/tcg-cpu.h
> +++ b/target/riscv/tcg/tcg-cpu.h
> @@ -26,4 +26,19 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, =
Error **errp);
>  void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp);
>  bool riscv_cpu_tcg_compatible(RISCVCPU *cpu);
>
> +struct DisasContext;
> +struct RISCVCPUConfig;
> +typedef struct RISCVDecoder {
> +    bool (*guard_func)(const struct RISCVCPUConfig *);
> +    bool (*riscv_cpu_decode_fn)(struct DisasContext *, uint32_t);
> +} RISCVDecoder;
> +
> +typedef bool (*riscv_cpu_decode_fn)(struct DisasContext *, uint32_t);
> +
> +extern const size_t decoder_table_size;
> +
> +extern const RISCVDecoder decoder_table[];
> +
> +void riscv_tcg_cpu_finalize_dynamic_decoder(RISCVCPU *cpu);
> +
>  #endif
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 9ff09ebdb6..15e7123a68 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -37,6 +37,8 @@
>  #include "exec/helper-info.c.inc"
>  #undef  HELPER_H
>
> +#include "tcg/tcg-cpu.h"
> +
>  /* global register indices */
>  static TCGv cpu_gpr[32], cpu_gprh[32], cpu_pc, cpu_vl, cpu_vstart;
>  static TCGv_i64 cpu_fpr[32]; /* assume F and D extensions */
> @@ -116,6 +118,7 @@ typedef struct DisasContext {
>      /* FRM is known to contain a valid value. */
>      bool frm_valid;
>      bool insn_start_updated;
> +    const GPtrArray *decoders;
>  } DisasContext;
>
>  static inline bool has_ext(DisasContext *ctx, uint32_t ext)
> @@ -1125,21 +1128,16 @@ static inline int insn_len(uint16_t first_word)
>      return (first_word & 3) =3D=3D 3 ? 4 : 2;
>  }
>
> +const RISCVDecoder decoder_table[] =3D {
> +    { always_true_p, decode_insn32 },
> +    { has_xthead_p, decode_xthead},
> +    { has_XVentanaCondOps_p, decode_XVentanaCodeOps},
> +};
> +
> +const size_t decoder_table_size =3D ARRAY_SIZE(decoder_table);
> +
>  static void decode_opc(CPURISCVState *env, DisasContext *ctx, uint16_t o=
pcode)
>  {
> -    /*
> -     * A table with predicate (i.e., guard) functions and decoder functi=
ons
> -     * that are tested in-order until a decoder matches onto the opcode.
> -     */
> -    static const struct {
> -        bool (*guard_func)(const RISCVCPUConfig *);
> -        bool (*decode_func)(DisasContext *, uint32_t);
> -    } decoders[] =3D {
> -        { always_true_p,  decode_insn32 },
> -        { has_xthead_p, decode_xthead },
> -        { has_XVentanaCondOps_p,  decode_XVentanaCodeOps },
> -    };
> -
>      ctx->virt_inst_excp =3D false;
>      ctx->cur_insn_len =3D insn_len(opcode);
>      /* Check for compressed insn */
> @@ -1160,9 +1158,9 @@ static void decode_opc(CPURISCVState *env, DisasCon=
text *ctx, uint16_t opcode)
>                                               ctx->base.pc_next + 2));
>          ctx->opcode =3D opcode32;
>
> -        for (size_t i =3D 0; i < ARRAY_SIZE(decoders); ++i) {
> -            if (decoders[i].guard_func(ctx->cfg_ptr) &&
> -                decoders[i].decode_func(ctx, opcode32)) {
> +        for (guint i =3D 0; i < ctx->decoders->len; ++i) {
> +            riscv_cpu_decode_fn func =3D g_ptr_array_index(ctx->decoders=
, i);
> +            if (func(ctx, opcode32)) {
>                  return;
>              }
>          }
> @@ -1207,6 +1205,7 @@ static void riscv_tr_init_disas_context(DisasContex=
tBase *dcbase, CPUState *cs)
>      ctx->itrigger =3D FIELD_EX32(tb_flags, TB_FLAGS, ITRIGGER);
>      ctx->zero =3D tcg_constant_tl(0);
>      ctx->virt_inst_excp =3D false;
> +    ctx->decoders =3D cpu->decoders;
>  }
>
>  static void riscv_tr_tb_start(DisasContextBase *db, CPUState *cpu)
> --
> 2.44.0
>
>

