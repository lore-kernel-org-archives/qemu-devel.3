Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF16C5320E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 03:59:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sinMC-0008E8-GK; Mon, 26 Aug 2024 23:59:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sinM6-0007c3-61; Mon, 26 Aug 2024 23:58:54 -0400
Received: from mail-vk1-xa2d.google.com ([2607:f8b0:4864:20::a2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sinM3-0005VT-ON; Mon, 26 Aug 2024 23:58:53 -0400
Received: by mail-vk1-xa2d.google.com with SMTP id
 71dfb90a1353d-4fcf9102c8bso1664870e0c.2; 
 Mon, 26 Aug 2024 20:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724731130; x=1725335930; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AXlmylrdK7U78PuqTPsnv+AkK4yqYBKr2CWs0IQexl8=;
 b=cAQZJBM51Tphwn/p+hWeI+5pBbbfWOzzAchelJxuvHjBJqhSnDS9T8crs5V+no28p7
 ZKz2QjUUs/mAGzLBl+qqbihZheAGxJNRXPdG9p6Q/hKShd+JRwkFV59ADd7vryMnbf5r
 VTNnDxTzEo7kSY8Qub8HNH7DB35gnrDu8jG+eYbUhdBfTevXordtU6hSci/vxtDxdh2C
 ZT+KXHlOW2gokVvr+hteFQ2AIDww6i9c1rnlzeBTqAiPOXGdo9fAygVnOEVTWqyJq3Hw
 sUXfJg4RV0C/kkjR12n1k9LPrJACGlvAavP1LRhhBUkL3yUYt9TfGj7F4MtMk5aYGHIG
 KlZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724731130; x=1725335930;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AXlmylrdK7U78PuqTPsnv+AkK4yqYBKr2CWs0IQexl8=;
 b=fbPVcKvS3/K006TheeH04ZN/gnlLQjf7T3hYhIkB1sulfTEeW3Kxy/b8i6iMivTMzg
 lHRbGXxICfoWozRk1h1/VuFmir/ieJaA67Nfg5buKnAXbHbp1h4Pe6Vh+aARZWFrbb5t
 JBvgQxNgmfbOXTS95VCG05tqiJjFiGjRx2CbQmFXbGS6l8z6kWpW1ELfgdsPX6oJ8dFR
 9o7l1lvPoJZJTCG9Yr23vIcpgSzeLAJRJLx2eivrAkAQx6l6jsmC07r1F/ZZM9GXNFfC
 dcfvjfFInLOceJFsXflvNNqa+Ra44EUIS928+yGuCR5oKbQWr+ifrsW+S04tcOfhuXR9
 WzSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzFzRGsqaVD5pvBa8BRok/BjUtUTHSU663ZU1ls+k2r/It6JrhibulCxXgWFuX3fPQHsXWpU8L2w3j@nongnu.org
X-Gm-Message-State: AOJu0Yw5MYXwqXzyRchbhTUXrlr41/08ikemmSdZhcChvkJ9amoLsKT0
 Hc4fR/0W+i3mHA0UP1O1HTPDiPULCN9uK6lvdGM0z+ajxTKnueSr2cogORCAjdydUYgnd4sO5+E
 0yHBQMRXwZzCPN5RMG8oknwnrmNDteMl88po=
X-Google-Smtp-Source: AGHT+IEi32ePEO56PNrxTxYzu0F6JiVo07iqEQIKeIKSJv2rLDaDR2kS1SERM4HZJvb2wJEm07FM7ijJn8TcWLw3hcU=
X-Received: by 2002:a05:6122:410d:b0:4f2:f1f1:a9f2 with SMTP id
 71dfb90a1353d-4fd1a52c596mr14810145e0c.4.1724731129946; Mon, 26 Aug 2024
 20:58:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240826152949.294506-1-debug@rivosinc.com>
 <20240826152949.294506-6-debug@rivosinc.com>
In-Reply-To: <20240826152949.294506-6-debug@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 27 Aug 2024 13:58:23 +1000
Message-ID: <CAKmqyKPO50bM77QsE=dcUxgeoxouP2zQ2c0b3UJ5t82mf9Z6CA@mail.gmail.com>
Subject: Re: [PATCH v9 05/17] target/riscv: tracking indirect branches (fcfi)
 for zicfilp
To: Deepak Gupta <debug@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 Alistair.Francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, 
 andy.chiu@sifive.com, richard.henderson@linaro.org, kito.cheng@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2d;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Tue, Aug 27, 2024 at 1:31=E2=80=AFAM Deepak Gupta <debug@rivosinc.com> w=
rote:
>
> zicfilp protects forward control flow (if enabled) by enforcing all
> indirect call and jmp must land on a landing pad instruction `lpad`. If
> target of an indirect call or jmp is not `lpad` then cpu/hart must raise
> a sw check exception with tval =3D 2.
>
> This patch implements the mechanism using TCG. Target architecture branch
> instruction must define the end of a TB. Using this property, during
> translation of branch instruction, TB flag =3D FCFI_LP_EXPECTED can be se=
t.
> Translation of target TB can check if FCFI_LP_EXPECTED flag is set and a
> flag (fcfi_lp_expected) can be set in DisasContext. If `lpad` gets
> translated, fcfi_lp_expected flag in DisasContext can be cleared. Else
> it'll fault.
>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> Co-developed-by: Jim Shu <jim.shu@sifive.com>
> Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h        |  3 +++
>  target/riscv/cpu_bits.h   |  3 +++
>  target/riscv/cpu_helper.c | 10 ++++++++++
>  target/riscv/translate.c  | 23 +++++++++++++++++++++++
>  4 files changed, 39 insertions(+)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 11c6513a90..edf540339a 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -606,6 +606,9 @@ FIELD(TB_FLAGS, ITRIGGER, 22, 1)
>  FIELD(TB_FLAGS, VIRT_ENABLED, 23, 1)
>  FIELD(TB_FLAGS, PRIV, 24, 2)
>  FIELD(TB_FLAGS, AXL, 26, 2)
> +/* zicfilp needs a TB flag to track indirect branches */
> +FIELD(TB_FLAGS, FCFI_ENABLED, 28, 1)
> +FIELD(TB_FLAGS, FCFI_LP_EXPECTED, 29, 1)
>
>  #ifdef TARGET_RISCV32
>  #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index b05ebe6f29..900769ce60 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -685,6 +685,9 @@ typedef enum RISCVException {
>      RISCV_EXCP_SEMIHOST =3D 0x3f,
>  } RISCVException;
>
> +/* zicfilp defines lp violation results in sw check with tval =3D 2*/
> +#define RISCV_EXCP_SW_CHECK_FCFI_TVAL      2
> +
>  #define RISCV_EXCP_INT_FLAG                0x80000000
>  #define RISCV_EXCP_INT_MASK                0x7fffffff
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 121fef1be6..172c945bf3 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -133,6 +133,16 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr =
*pc,
>          flags =3D FIELD_DP32(flags, TB_FLAGS, VILL, 1);
>      }
>
> +    if (cpu_get_fcfien(env)) {
> +        /*
> +         * For Forward CFI, only the expectation of a lpad at
> +         * the start of the block is tracked via env->elp. env->elp
> +         * is turned on during jalr translation.
> +         */
> +        flags =3D FIELD_DP32(flags, TB_FLAGS, FCFI_LP_EXPECTED, env->elp=
);
> +        flags =3D FIELD_DP32(flags, TB_FLAGS, FCFI_ENABLED, 1);
> +    }
> +
>  #ifdef CONFIG_USER_ONLY
>      fs =3D EXT_STATUS_DIRTY;
>      vs =3D EXT_STATUS_DIRTY;
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index acba90f170..b5c0511b4b 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -116,6 +116,9 @@ typedef struct DisasContext {
>      bool frm_valid;
>      bool insn_start_updated;
>      const GPtrArray *decoders;
> +    /* zicfilp extension. fcfi_enabled, lp expected or not */
> +    bool fcfi_enabled;
> +    bool fcfi_lp_expected;
>  } DisasContext;
>
>  static inline bool has_ext(DisasContext *ctx, uint32_t ext)
> @@ -1238,6 +1241,8 @@ static void riscv_tr_init_disas_context(DisasContex=
tBase *dcbase, CPUState *cs)
>      ctx->pm_base_enabled =3D FIELD_EX32(tb_flags, TB_FLAGS, PM_BASE_ENAB=
LED);
>      ctx->ztso =3D cpu->cfg.ext_ztso;
>      ctx->itrigger =3D FIELD_EX32(tb_flags, TB_FLAGS, ITRIGGER);
> +    ctx->fcfi_lp_expected =3D FIELD_EX32(tb_flags, TB_FLAGS, FCFI_LP_EXP=
ECTED);
> +    ctx->fcfi_enabled =3D FIELD_EX32(tb_flags, TB_FLAGS, FCFI_ENABLED);
>      ctx->zero =3D tcg_constant_tl(0);
>      ctx->virt_inst_excp =3D false;
>      ctx->decoders =3D cpu->decoders;
> @@ -1270,6 +1275,24 @@ static void riscv_tr_translate_insn(DisasContextBa=
se *dcbase, CPUState *cpu)
>      decode_opc(env, ctx, opcode16);
>      ctx->base.pc_next +=3D ctx->cur_insn_len;
>
> +    /*
> +     * If 'fcfi_lp_expected' is still true after processing the instruct=
ion,
> +     * then we did not see an 'lpad' instruction, and must raise an exce=
ption.
> +     * Insert code to raise the exception at the start of the insn; any =
other
> +     * code the insn may have emitted will be deleted as dead code follo=
wing
> +     * the noreturn exception
> +     */
> +    if (ctx->fcfi_lp_expected) {
> +        /* Emit after insn_start, i.e. before the op following insn_star=
t. */
> +        tcg_ctx->emit_before_op =3D QTAILQ_NEXT(ctx->base.insn_start, li=
nk);
> +        tcg_gen_st_tl(tcg_constant_tl(RISCV_EXCP_SW_CHECK_FCFI_TVAL),
> +                      tcg_env, offsetof(CPURISCVState, sw_check_code));
> +        gen_helper_raise_exception(tcg_env,
> +                      tcg_constant_i32(RISCV_EXCP_SW_CHECK));
> +        tcg_ctx->emit_before_op =3D NULL;
> +        ctx->base.is_jmp =3D DISAS_NORETURN;
> +    }
> +
>      /* Only the first insn within a TB is allowed to cross a page bounda=
ry. */
>      if (ctx->base.is_jmp =3D=3D DISAS_NEXT) {
>          if (ctx->itrigger || !is_same_page(&ctx->base, ctx->base.pc_next=
)) {
> --
> 2.44.0
>
>

