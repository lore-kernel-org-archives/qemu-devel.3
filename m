Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BF3CC47DD9
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 01:31:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rePoi-0003Z8-5n; Sun, 25 Feb 2024 20:30:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rePoe-0003Xv-Vz; Sun, 25 Feb 2024 20:30:01 -0500
Received: from mail-ua1-x92b.google.com ([2607:f8b0:4864:20::92b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rePod-0005Qy-5t; Sun, 25 Feb 2024 20:30:00 -0500
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-7d2a67daa25so1692802241.0; 
 Sun, 25 Feb 2024 17:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708910997; x=1709515797; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d/fAsLWM+w7FYv4H9kFTc0OSWUR6EpV8sEwvpW7fYS4=;
 b=mInunxmqdvo5T+zOZxOaGK9fhTD1qmGJuIRYxZ8wJG+2O9jHBmqxWJFMd0DGom92k4
 Pg8LSgOegXGQcDfM/HDSn0zjko9yE/hU6Pa/DfepyEo4ku5ViFAhDNb+0E0FEXi7WUgN
 szEIb84cO9YKhBGQt4hcJfySwRBuBg/zN92AWpCrwd2sTYRKaYYsuXwseHBxs4wCXOsm
 zH86zAiXSTovyVuhKSFw5d6zRN76qrtjVYukE4GFUQ3BmcQuE454B3huV+PE7ZWM02Qw
 oqn8rKZYaOBfOfdwmT7uFRfIBu7u7kekRsWRUfcNI6XHGhDO96jS3ZKafp0zzoM1PmCW
 /+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708910997; x=1709515797;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d/fAsLWM+w7FYv4H9kFTc0OSWUR6EpV8sEwvpW7fYS4=;
 b=BsawAyBNodzamobzeJM6eHTlIbJ1B9IdUSMeSzrVye5x+V62/5mOiB6/IC/la+zgIr
 GUKKlsLXV3+gT+SDt5BlPyGE/+UquFatr4fEtqJwNUXDWin5mJYSndnF747wPt7b884C
 uOG9jet1sQPjee9ohpJiFn6/pM05q+9xxjO8ZbxFBU2wLXvFWbDH60leoy0+ebVEF1Qk
 SrEqy8EFGxtIlhNpAWPXnQ252vxrTXADCy9N8G1r14CeuFKhbjjQVQ/2gtwt3UkxIZkl
 oiDYwyRMrU+4L1FP7qrBnB14XlaR1fJKfMCM3pkwK1XlX4I9Zb+DaitStzlQ4LjxkcbS
 gA6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWDibs+y4niJAsjg5+SYnItkSow+XpPnQMnIbBt1tao8ELCyhSWu0l1tt8GSHacczsHaQmFW9fpZotD9G14JJAB5DxsM0=
X-Gm-Message-State: AOJu0YzZk7vQzRo8mRd8TDJp7JzZmknJRfo65V8GEyA+RmMyuBSkrKnz
 S6uYaSexZ8xBeI8V+b1t8ZJWQqiNTL/mpyDYLHYdEPikhwFj/AWeZTGUUZqIxDBnegOUSVtVn4b
 Waga4ZuoQE8oHgS0tc+2DqnME10M=
X-Google-Smtp-Source: AGHT+IF7Ym032zLS2iESntsSL2gmIVZlgwNQIDNZzYzffK/0GlW3VM4whEMICFa8XqYaWUmHPZPKNvn0u31GuuPup3I=
X-Received: by 2002:a1f:6201:0:b0:4c9:51f9:3b4a with SMTP id
 w1-20020a1f6201000000b004c951f93b4amr2707688vkb.2.1708910996962; Sun, 25 Feb
 2024 17:29:56 -0800 (PST)
MIME-Version: 1.0
References: <20240207122256.902627-1-christoph.muellner@vrull.eu>
 <20240207122256.902627-2-christoph.muellner@vrull.eu>
In-Reply-To: <20240207122256.902627-2-christoph.muellner@vrull.eu>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 26 Feb 2024 11:29:30 +1000
Message-ID: <CAKmqyKMLF9pgKcbXueK9aqhwM9tetwf4VGOMfQ0OFgfFu5rZ4Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] RISC-V: Add support for Ztso
To: =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>, 
 Palmer Dabbelt <palmer@rivosinc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92b;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92b.google.com
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

On Wed, Feb 7, 2024 at 10:25=E2=80=AFPM Christoph M=C3=BCllner
<christoph.muellner@vrull.eu> wrote:
>
> From: Palmer Dabbelt <palmer@rivosinc.com>
>
> The Ztso extension is already ratified, this adds it as a CPU property
> and adds various fences throughout the port in order to allow TSO
> targets to function on weaker hosts.  We need no fences for AMOs as
> they're already SC, the places we need barriers are described.
> These fences are placed in the RISC-V backend rather than TCG as is
> planned for x86-on-arm64 because RISC-V allows heterogeneous (and
> likely soon dynamic) hart memory models.
>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> Signed-off-by: Christoph M=C3=BCllner <christoph.muellner@vrull.eu>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c                      |  2 ++
>  target/riscv/cpu_cfg.h                  |  1 +
>  target/riscv/insn_trans/trans_rva.c.inc | 11 ++++++++---
>  target/riscv/insn_trans/trans_rvi.c.inc | 16 ++++++++++++++--
>  target/riscv/insn_trans/trans_rvv.c.inc | 20 ++++++++++++++++++++
>  target/riscv/translate.c                |  3 +++
>  6 files changed, 48 insertions(+), 5 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 1b8d001d23..b679ecd8c7 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -143,6 +143,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(zksed, PRIV_VERSION_1_12_0, ext_zksed),
>      ISA_EXT_DATA_ENTRY(zksh, PRIV_VERSION_1_12_0, ext_zksh),
>      ISA_EXT_DATA_ENTRY(zkt, PRIV_VERSION_1_12_0, ext_zkt),
> +    ISA_EXT_DATA_ENTRY(ztso, PRIV_VERSION_1_12_0, ext_ztso),
>      ISA_EXT_DATA_ENTRY(zvbb, PRIV_VERSION_1_12_0, ext_zvbb),
>      ISA_EXT_DATA_ENTRY(zvbc, PRIV_VERSION_1_12_0, ext_zvbc),
>      ISA_EXT_DATA_ENTRY(zve32f, PRIV_VERSION_1_10_0, ext_zve32f),
> @@ -1488,6 +1489,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[]=
 =3D {
>      MULTI_EXT_CFG_BOOL("zksed", ext_zksed, false),
>      MULTI_EXT_CFG_BOOL("zksh", ext_zksh, false),
>      MULTI_EXT_CFG_BOOL("zkt", ext_zkt, false),
> +    MULTI_EXT_CFG_BOOL("ztso", ext_ztso, false),
>
>      MULTI_EXT_CFG_BOOL("zdinx", ext_zdinx, false),
>      MULTI_EXT_CFG_BOOL("zfinx", ext_zfinx, false),
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index 833bf58217..afba8ed0b2 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -71,6 +71,7 @@ struct RISCVCPUConfig {
>      bool ext_zihintntl;
>      bool ext_zihintpause;
>      bool ext_zihpm;
> +    bool ext_ztso;
>      bool ext_smstateen;
>      bool ext_sstc;
>      bool ext_svadu;
> diff --git a/target/riscv/insn_trans/trans_rva.c.inc b/target/riscv/insn_=
trans/trans_rva.c.inc
> index 267930e5bc..4a9e4591d1 100644
> --- a/target/riscv/insn_trans/trans_rva.c.inc
> +++ b/target/riscv/insn_trans/trans_rva.c.inc
> @@ -40,7 +40,11 @@ static bool gen_lr(DisasContext *ctx, arg_atomic *a, M=
emOp mop)
>          tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
>      }
>      tcg_gen_qemu_ld_tl(load_val, src1, ctx->mem_idx, mop);
> -    if (a->aq) {
> +    /*
> +     * TSO defines AMOs as acquire+release-RCsc, but does not define LR/=
SC as
> +     * AMOs.  Instead treat them like loads.
> +     */
> +    if (a->aq || ctx->ztso) {
>          tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
>      }
>
> @@ -76,9 +80,10 @@ static bool gen_sc(DisasContext *ctx, arg_atomic *a, M=
emOp mop)
>      gen_set_label(l1);
>      /*
>       * Address comparison failure.  However, we still need to
> -     * provide the memory barrier implied by AQ/RL.
> +     * provide the memory barrier implied by AQ/RL/TSO.
>       */
> -    tcg_gen_mb(TCG_MO_ALL + a->aq * TCG_BAR_LDAQ + a->rl * TCG_BAR_STRL)=
;
> +    TCGBar bar_strl =3D (ctx->ztso || a->rl) ? TCG_BAR_STRL : 0;
> +    tcg_gen_mb(TCG_MO_ALL + a->aq * TCG_BAR_LDAQ + bar_strl);
>      gen_set_gpr(ctx, a->rd, tcg_constant_tl(1));
>
>      gen_set_label(l2);
> diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_=
trans/trans_rvi.c.inc
> index faf6d65064..ad40d3e87f 100644
> --- a/target/riscv/insn_trans/trans_rvi.c.inc
> +++ b/target/riscv/insn_trans/trans_rvi.c.inc
> @@ -266,12 +266,20 @@ static bool gen_load_i128(DisasContext *ctx, arg_lb=
 *a, MemOp memop)
>
>  static bool gen_load(DisasContext *ctx, arg_lb *a, MemOp memop)
>  {
> +    bool out;
> +
>      decode_save_opc(ctx);
>      if (get_xl(ctx) =3D=3D MXL_RV128) {
> -        return gen_load_i128(ctx, a, memop);
> +        out =3D gen_load_i128(ctx, a, memop);
>      } else {
> -        return gen_load_tl(ctx, a, memop);
> +        out =3D gen_load_tl(ctx, a, memop);
> +    }
> +
> +    if (ctx->ztso) {
> +        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
>      }
> +
> +    return out;
>  }
>
>  static bool trans_lb(DisasContext *ctx, arg_lb *a)
> @@ -328,6 +336,10 @@ static bool gen_store_tl(DisasContext *ctx, arg_sb *=
a, MemOp memop)
>      TCGv addr =3D get_address(ctx, a->rs1, a->imm);
>      TCGv data =3D get_gpr(ctx, a->rs2, EXT_NONE);
>
> +    if (ctx->ztso) {
> +        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
> +    }
> +
>      tcg_gen_qemu_st_tl(data, addr, ctx->mem_idx, memop);
>      return true;
>  }
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_=
trans/trans_rvv.c.inc
> index 9e101ab434..742008f58b 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -636,8 +636,28 @@ static bool ldst_us_trans(uint32_t vd, uint32_t rs1,=
 uint32_t data,
>      tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, vd));
>      tcg_gen_addi_ptr(mask, tcg_env, vreg_ofs(s, 0));
>
> +    /*
> +     * According to the specification
> +     *
> +     *   Additionally, if the Ztso extension is implemented, then vector=
 memory
> +     *   instructions in the V extension and Zve family of extensions fo=
llow
> +     *   RVTSO at the instruction level.  The Ztso extension does not
> +     *   strengthen the ordering of intra-instruction element accesses.
> +     *
> +     * as a result neither ordered nor unordered accesses from the V
> +     * instructions need ordering within the loop but we do still need b=
arriers
> +     * around the loop.
> +     */
> +    if (is_store && s->ztso) {
> +        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
> +    }
> +
>      fn(dest, mask, base, tcg_env, desc);
>
> +    if (!is_store && s->ztso) {
> +        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
> +    }
> +
>      if (!is_store) {
>          mark_vs_dirty(s);
>      }
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 177418b2b9..ea5d52b2ef 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -109,6 +109,8 @@ typedef struct DisasContext {
>      /* PointerMasking extension */
>      bool pm_mask_enabled;
>      bool pm_base_enabled;
> +    /* Ztso */
> +    bool ztso;
>      /* Use icount trigger for native debug */
>      bool itrigger;
>      /* FRM is known to contain a valid value. */
> @@ -1196,6 +1198,7 @@ static void riscv_tr_init_disas_context(DisasContex=
tBase *dcbase, CPUState *cs)
>      ctx->cs =3D cs;
>      ctx->pm_mask_enabled =3D FIELD_EX32(tb_flags, TB_FLAGS, PM_MASK_ENAB=
LED);
>      ctx->pm_base_enabled =3D FIELD_EX32(tb_flags, TB_FLAGS, PM_BASE_ENAB=
LED);
> +    ctx->ztso =3D cpu->cfg.ext_ztso;
>      ctx->itrigger =3D FIELD_EX32(tb_flags, TB_FLAGS, ITRIGGER);
>      ctx->zero =3D tcg_constant_tl(0);
>      ctx->virt_inst_excp =3D false;
> --
> 2.43.0
>
>

