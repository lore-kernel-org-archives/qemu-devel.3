Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0553CC04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 03:52:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1I3a-0008I2-Gu; Sun, 28 Apr 2024 23:51:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s1I3Y-0008HQ-8p; Sun, 28 Apr 2024 23:51:56 -0400
Received: from mail-ua1-x92b.google.com ([2607:f8b0:4864:20::92b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s1I3V-000868-0H; Sun, 28 Apr 2024 23:51:54 -0400
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-7efa7296beeso1075798241.3; 
 Sun, 28 Apr 2024 20:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714362711; x=1714967511; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4rgtm6WajaZEbtDgbC5CBjYdHRrRLInGF0V0f1suT+c=;
 b=eLQT4SmGLBmldROknbZPlEi5TUfJKycmVGb3n2/xbtDYP6mIJTPxfAerU+QALTZI2F
 O0gN6WWM/qXdl6uuOQQq4wCZyNZpZZ7Qdc/VU7hJViMJ9z+Yz7ikvKML+qRdDf6Td0y9
 pW/1mGUN4tGlUyYGHq7n/+TOTAgR1G+DUm3UaWVSSkTGKNcOJ48fqucF2jH5WKpo+j4S
 s56yCmlre+b5hPBO7/v8EYLv8HmvjE/JY1ID9ZJgJivkXG5UMzu65PS/+HEaCPdzAAO+
 pgcYDgvhPeXVQY9VseRjjToUWtoGtu8Q8j5x4/CQmKadE0lLoH+/CIkPcwenggKC00E5
 FD4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714362711; x=1714967511;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4rgtm6WajaZEbtDgbC5CBjYdHRrRLInGF0V0f1suT+c=;
 b=ClE8Lbqpo0ccKpwsORqaG9A1zl8671HVfeqSOaTaXD0FFSK7gURilYthVnNs6WEzWU
 pe5fvUql8neHRDPlNjZV2aQsS/+g6XYzdT7rQTG1Wv9ijUNxhBv3kOPJOgK+1e5Fo8lk
 CkBTnyLNChGI8L4d/hrUWmjzkN6Mtlm++EEPJLLRjmNsZZnDRqEiC4vV2K2k5VPFb7hq
 Ra4J5i5NXOLECjvPpwlr5myWPlKauQ0XchXMIn34a1fe/2xh1QneAuaT5DsOlD9FV8WM
 dZScd01StHgnvJwZi81G53d95AMzwqO/UV/YhUkWDmmVpz1//PjuP/jv12oB1Ns7VuX3
 KXhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXq91BNfVstI5YRt6ALI5zJBYhPdRyMtQ+pZ5c0OxBB5KWK/4iXUnQTgn2LfHT142+R8FJDOpZSaJBxrqhUxSVkHZ9bI/g=
X-Gm-Message-State: AOJu0YwaKfZCmDVDhbZBxhQL9+wlC+TDZBNgjlFcq7R7jKCnW9bC6HrN
 Y8SjWOeiQIy4XRbsIVaenZzsWBkoj04Nxatuo1OsNXWBPy4nLryubFlJQLPpLcx8d64vubwz/Bs
 voouS+g9GuTpKwdohcFBwwk3dxN8=
X-Google-Smtp-Source: AGHT+IGEoIORT9TFKzGm69l1R2As1zDoyV1BoqVZ/Vq1zEqG8MW9dBnZk/wG6RuTN8/giqlgSfEkLka6iRMnp1YBJ7Q=
X-Received: by 2002:a05:6102:2ac2:b0:47c:28c1:5379 with SMTP id
 eh2-20020a0561022ac200b0047c28c15379mr8240283vsb.33.1714362711329; Sun, 28
 Apr 2024 20:51:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240314092158.65866-1-eric.huang@linux.alibaba.com>
In-Reply-To: <20240314092158.65866-1-eric.huang@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Apr 2024 13:51:25 +1000
Message-ID: <CAKmqyKP+=Q4oup1mpWskykfgE3HZRJpaVX_JTk=0=jU_TkgsUQ@mail.gmail.com>
Subject: Re: [PATCH v4] target/riscv: Implement dynamic establishment of
 custom decoder
To: Huang Tao <eric.huang@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com, 
 alistair.francis@wdc.com, palmer@dabbelt.com, 
 Christoph Muellner <christoph.muellner@vrull.eu>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92b;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92b.google.com
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

On Thu, Mar 14, 2024 at 7:23=E2=80=AFPM Huang Tao <eric.huang@linux.alibaba=
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

Do you mind rebasing this on
https://github.com/alistair23/qemu/tree/riscv-to-apply.next?

Alistair

> ---
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
> index c160b9216b..17070b82a7 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1132,6 +1132,7 @@ void riscv_cpu_finalize_features(RISCVCPU *cpu, Err=
or **errp)
>              error_propagate(errp, local_err);
>              return;
>          }
> +        riscv_tcg_cpu_finalize_dynamic_decoder(cpu);
>      } else if (kvm_enabled()) {
>          riscv_kvm_cpu_finalize_features(cpu, &local_err);
>          if (local_err !=3D NULL) {
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 3b1a02b944..48e67410e1 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -457,6 +457,7 @@ struct ArchCPU {
>      uint32_t pmu_avail_ctrs;
>      /* Mapping of events to counters */
>      GHashTable *pmu_event_ctr_map;
> +    const GPtrArray *decoders;
>  };
>
>  /**
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index ab6db817db..c9ab92ea2f 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -853,6 +853,21 @@ void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, =
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
> index ea5d52b2ef..bce16d5054 100644
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
> @@ -117,6 +119,7 @@ typedef struct DisasContext {
>      bool frm_valid;
>      /* TCG of the current insn_start */
>      TCGOp *insn_start;
> +    const GPtrArray *decoders;
>  } DisasContext;
>
>  static inline bool has_ext(DisasContext *ctx, uint32_t ext)
> @@ -1120,21 +1123,16 @@ static inline int insn_len(uint16_t first_word)
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
> @@ -1155,9 +1153,9 @@ static void decode_opc(CPURISCVState *env, DisasCon=
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
> @@ -1202,6 +1200,7 @@ static void riscv_tr_init_disas_context(DisasContex=
tBase *dcbase, CPUState *cs)
>      ctx->itrigger =3D FIELD_EX32(tb_flags, TB_FLAGS, ITRIGGER);
>      ctx->zero =3D tcg_constant_tl(0);
>      ctx->virt_inst_excp =3D false;
> +    ctx->decoders =3D cpu->decoders;
>  }
>
>  static void riscv_tr_tb_start(DisasContextBase *db, CPUState *cpu)
> --
> 2.41.0
>
>

