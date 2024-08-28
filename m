Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF3AC71150
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 23:37:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjSDQ-0005X3-AI; Wed, 28 Aug 2024 19:36:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sjSDP-0005SS-0o; Wed, 28 Aug 2024 19:36:39 -0400
Received: from mail-vs1-xe2d.google.com ([2607:f8b0:4864:20::e2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sjSDM-0001lI-ER; Wed, 28 Aug 2024 19:36:38 -0400
Received: by mail-vs1-xe2d.google.com with SMTP id
 ada2fe7eead31-498cca5d48aso35216137.3; 
 Wed, 28 Aug 2024 16:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724888194; x=1725492994; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J6MH/dqOpNvP+5XESAkoPP6KVz7zY3KBi+jYrGLztg0=;
 b=N6cDvq9HSBUg/LDpl7eU80iAHigHyRslUduKjml7sKw/kVj6AfyeZo2s78GZeewZle
 KemrRnPJli1UWOOOEfBjEc4prtY949SOt0g2u81dsrubDedbBkkkcORa1PrlhRwK1DK7
 /ed4FqwWtChnj3ggxGdh+W1mxCH24dDy+Z9boYQ4pft/f7ZOZgQ68hKO+YyIIEcR9EwH
 MI7iKHwVvXM3LdF/UAzwGIMNz1eVdaEujSfm3WZFnyB65Hu5DH/EJJcgbU+0D1hGdGe1
 mGBBusD3d38H0lrYlVENhXvLPBjz1NYxedhHIOa41I60kYs+LdiOsbcx/lmSBPLI6JQb
 kXFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724888194; x=1725492994;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J6MH/dqOpNvP+5XESAkoPP6KVz7zY3KBi+jYrGLztg0=;
 b=kh/ktoOiNVjy4wz/l37Uuic34k/olbVnG93PDmIvgqOVUVSXTBaBbNS3w4xFGIVayl
 xGxe2rq9ljMsxrznWh6zY6MQV2iIIDSQSlQ+8UqeVVbC0Rq+yD2QHM9q6+UFgP2EF6zr
 JHQzHf6H++86eH8eQ9LolYnqj/AoODOwBhWsxdgCRleYDFLqmRY6/VCvDFpIt8NaX4xR
 pwDLkQdYjFkCoSbA6qi2bJCB7/Jg8ZunpSTomewp7k+D0Zlda48MSZQGNI4oypzmOEeW
 oSpf2FRvcosrJEBxeTeTYf7HFPODDpk1zhUhZdYfeeQTzPuu5LJYhdSe+V9NdzJ2+36R
 WQwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWdNR4rPYFsxlWnyz8nrj/SdZ5ZFkwZzTWP8XLiw8CZ7laV1LOXu2n4Z9SJOqB4VNPan2KZRaPZCWm@nongnu.org
X-Gm-Message-State: AOJu0YxQrpgsHn+/mYSig4nMsCw78Afht3a38xDmBJKURmmvyoMknkub
 Hl7FtSHfJt4chkU57RkPETOH2XfAVR8Ex5bDXeROhqMleU5jO3xvutIvdvfsZIYVldnL0ae1Xtu
 MNzBQBJAuHCuySr4LuPOQk31gWVo=
X-Google-Smtp-Source: AGHT+IH/BiLMWcjlXmZTfHA0Kdty+h9r1d//0OsLwvXpvNvfbobhC7B1YGdao4pCmtE5AcutLvYLies6Texr6P84oNU=
X-Received: by 2002:a05:6102:942:b0:48f:c062:75ae with SMTP id
 ada2fe7eead31-49a5ae57710mr1633462137.8.1724888193391; Wed, 28 Aug 2024
 16:36:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240828174739.714313-1-debug@rivosinc.com>
 <20240828174739.714313-16-debug@rivosinc.com>
In-Reply-To: <20240828174739.714313-16-debug@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 29 Aug 2024 09:36:07 +1000
Message-ID: <CAKmqyKMz=grR4e6aq29LzH5OVf6_ZDVh1DBFtC-69bsLPTGChg@mail.gmail.com>
Subject: Re: [PATCH v11 15/20] target/riscv: update `decode_save_opc` to store
 extra word2
To: Deepak Gupta <debug@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 Alistair.Francis@wdc.com, laurent@vivier.eu, bmeng.cn@gmail.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 jim.shu@sifive.com, andy.chiu@sifive.com, kito.cheng@sifive.com, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2d;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2d.google.com
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

On Thu, Aug 29, 2024 at 3:51=E2=80=AFAM Deepak Gupta <debug@rivosinc.com> w=
rote:
>
> Extra word 2 is stored during tcg compile and `decode_save_opc` needs
> additional argument in order to pass the value. This will be used during
> unwind to get extra information about instruction like how to massage
> exceptions. Updated all callsites as well.

Woo!

This should fix https://gitlab.com/qemu-project/qemu/-/issues/594 as well

>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/594
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/insn_trans/trans_privileged.c.inc |  8 ++++----
>  target/riscv/insn_trans/trans_rva.c.inc        |  4 ++--
>  target/riscv/insn_trans/trans_rvd.c.inc        |  4 ++--
>  target/riscv/insn_trans/trans_rvf.c.inc        |  4 ++--
>  target/riscv/insn_trans/trans_rvh.c.inc        |  8 ++++----
>  target/riscv/insn_trans/trans_rvi.c.inc        |  6 +++---
>  target/riscv/insn_trans/trans_rvvk.c.inc       | 10 +++++-----
>  target/riscv/insn_trans/trans_rvzacas.c.inc    |  4 ++--
>  target/riscv/insn_trans/trans_rvzfh.c.inc      |  4 ++--
>  target/riscv/insn_trans/trans_svinval.c.inc    |  6 +++---
>  target/riscv/translate.c                       | 11 ++++++-----
>  11 files changed, 35 insertions(+), 34 deletions(-)
>
> diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/risc=
v/insn_trans/trans_privileged.c.inc
> index bc5263a4e0..ecd3b8b2c9 100644
> --- a/target/riscv/insn_trans/trans_privileged.c.inc
> +++ b/target/riscv/insn_trans/trans_privileged.c.inc
> @@ -78,7 +78,7 @@ static bool trans_sret(DisasContext *ctx, arg_sret *a)
>  {
>  #ifndef CONFIG_USER_ONLY
>      if (has_ext(ctx, RVS)) {
> -        decode_save_opc(ctx);
> +        decode_save_opc(ctx, 0);
>          translator_io_start(&ctx->base);
>          gen_helper_sret(cpu_pc, tcg_env);
>          exit_tb(ctx); /* no chaining */
> @@ -95,7 +95,7 @@ static bool trans_sret(DisasContext *ctx, arg_sret *a)
>  static bool trans_mret(DisasContext *ctx, arg_mret *a)
>  {
>  #ifndef CONFIG_USER_ONLY
> -    decode_save_opc(ctx);
> +    decode_save_opc(ctx, 0);
>      translator_io_start(&ctx->base);
>      gen_helper_mret(cpu_pc, tcg_env);
>      exit_tb(ctx); /* no chaining */
> @@ -109,7 +109,7 @@ static bool trans_mret(DisasContext *ctx, arg_mret *a=
)
>  static bool trans_wfi(DisasContext *ctx, arg_wfi *a)
>  {
>  #ifndef CONFIG_USER_ONLY
> -    decode_save_opc(ctx);
> +    decode_save_opc(ctx, 0);
>      gen_update_pc(ctx, ctx->cur_insn_len);
>      gen_helper_wfi(tcg_env);
>      return true;
> @@ -121,7 +121,7 @@ static bool trans_wfi(DisasContext *ctx, arg_wfi *a)
>  static bool trans_sfence_vma(DisasContext *ctx, arg_sfence_vma *a)
>  {
>  #ifndef CONFIG_USER_ONLY
> -    decode_save_opc(ctx);
> +    decode_save_opc(ctx, 0);
>      gen_helper_tlb_flush(tcg_env);
>      return true;
>  #endif
> diff --git a/target/riscv/insn_trans/trans_rva.c.inc b/target/riscv/insn_=
trans/trans_rva.c.inc
> index 39bbf60f3c..9cf3ae8019 100644
> --- a/target/riscv/insn_trans/trans_rva.c.inc
> +++ b/target/riscv/insn_trans/trans_rva.c.inc
> @@ -34,7 +34,7 @@ static bool gen_lr(DisasContext *ctx, arg_atomic *a, Me=
mOp mop)
>  {
>      TCGv src1;
>
> -    decode_save_opc(ctx);
> +    decode_save_opc(ctx, 0);
>      src1 =3D get_address(ctx, a->rs1, 0);
>      if (a->rl) {
>          tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
> @@ -61,7 +61,7 @@ static bool gen_sc(DisasContext *ctx, arg_atomic *a, Me=
mOp mop)
>      TCGLabel *l1 =3D gen_new_label();
>      TCGLabel *l2 =3D gen_new_label();
>
> -    decode_save_opc(ctx);
> +    decode_save_opc(ctx, 0);
>      src1 =3D get_address(ctx, a->rs1, 0);
>      tcg_gen_brcond_tl(TCG_COND_NE, load_res, src1, l1);
>
> diff --git a/target/riscv/insn_trans/trans_rvd.c.inc b/target/riscv/insn_=
trans/trans_rvd.c.inc
> index 1f5fac65a2..d779ec75c7 100644
> --- a/target/riscv/insn_trans/trans_rvd.c.inc
> +++ b/target/riscv/insn_trans/trans_rvd.c.inc
> @@ -51,7 +51,7 @@ static bool trans_fld(DisasContext *ctx, arg_fld *a)
>          memop |=3D MO_ATOM_WITHIN16;
>      }
>
> -    decode_save_opc(ctx);
> +    decode_save_opc(ctx, 0);
>      addr =3D get_address(ctx, a->rs1, a->imm);
>      tcg_gen_qemu_ld_i64(cpu_fpr[a->rd], addr, ctx->mem_idx, memop);
>
> @@ -71,7 +71,7 @@ static bool trans_fsd(DisasContext *ctx, arg_fsd *a)
>          memop |=3D MO_ATOM_WITHIN16;
>      }
>
> -    decode_save_opc(ctx);
> +    decode_save_opc(ctx, 0);
>      addr =3D get_address(ctx, a->rs1, a->imm);
>      tcg_gen_qemu_st_i64(cpu_fpr[a->rs2], addr, ctx->mem_idx, memop);
>      return true;
> diff --git a/target/riscv/insn_trans/trans_rvf.c.inc b/target/riscv/insn_=
trans/trans_rvf.c.inc
> index f771aa1939..084c184e65 100644
> --- a/target/riscv/insn_trans/trans_rvf.c.inc
> +++ b/target/riscv/insn_trans/trans_rvf.c.inc
> @@ -52,7 +52,7 @@ static bool trans_flw(DisasContext *ctx, arg_flw *a)
>          memop |=3D MO_ATOM_WITHIN16;
>      }
>
> -    decode_save_opc(ctx);
> +    decode_save_opc(ctx, 0);
>      addr =3D get_address(ctx, a->rs1, a->imm);
>      dest =3D cpu_fpr[a->rd];
>      tcg_gen_qemu_ld_i64(dest, addr, ctx->mem_idx, memop);
> @@ -74,7 +74,7 @@ static bool trans_fsw(DisasContext *ctx, arg_fsw *a)
>          memop |=3D MO_ATOM_WITHIN16;
>      }
>
> -    decode_save_opc(ctx);
> +    decode_save_opc(ctx, 0);
>      addr =3D get_address(ctx, a->rs1, a->imm);
>      tcg_gen_qemu_st_i64(cpu_fpr[a->rs2], addr, ctx->mem_idx, memop);
>      return true;
> diff --git a/target/riscv/insn_trans/trans_rvh.c.inc b/target/riscv/insn_=
trans/trans_rvh.c.inc
> index aa9d41c18c..03c6694430 100644
> --- a/target/riscv/insn_trans/trans_rvh.c.inc
> +++ b/target/riscv/insn_trans/trans_rvh.c.inc
> @@ -44,7 +44,7 @@ static bool do_hlv(DisasContext *ctx, arg_r2 *a,
>      TCGv dest =3D dest_gpr(ctx, a->rd);
>      TCGv addr =3D get_gpr(ctx, a->rs1, EXT_NONE);
>
> -    decode_save_opc(ctx);
> +    decode_save_opc(ctx, 0);
>      func(dest, tcg_env, addr);
>      gen_set_gpr(ctx, a->rd, dest);
>      return true;
> @@ -56,7 +56,7 @@ static bool do_hsv(DisasContext *ctx, arg_r2_s *a,
>      TCGv addr =3D get_gpr(ctx, a->rs1, EXT_NONE);
>      TCGv data =3D get_gpr(ctx, a->rs2, EXT_NONE);
>
> -    decode_save_opc(ctx);
> +    decode_save_opc(ctx, 0);
>      func(tcg_env, addr, data);
>      return true;
>  }
> @@ -147,7 +147,7 @@ static bool trans_hfence_gvma(DisasContext *ctx, arg_=
sfence_vma *a)
>  {
>      REQUIRE_EXT(ctx, RVH);
>  #ifndef CONFIG_USER_ONLY
> -    decode_save_opc(ctx);
> +    decode_save_opc(ctx, 0);
>      gen_helper_hyp_gvma_tlb_flush(tcg_env);
>      return true;
>  #endif
> @@ -158,7 +158,7 @@ static bool trans_hfence_vvma(DisasContext *ctx, arg_=
sfence_vma *a)
>  {
>      REQUIRE_EXT(ctx, RVH);
>  #ifndef CONFIG_USER_ONLY
> -    decode_save_opc(ctx);
> +    decode_save_opc(ctx, 0);
>      gen_helper_hyp_tlb_flush(tcg_env);
>      return true;
>  #endif
> diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_=
trans/trans_rvi.c.inc
> index b427f3a939..a619ea7c0e 100644
> --- a/target/riscv/insn_trans/trans_rvi.c.inc
> +++ b/target/riscv/insn_trans/trans_rvi.c.inc
> @@ -326,7 +326,7 @@ static bool gen_load(DisasContext *ctx, arg_lb *a, Me=
mOp memop)
>      if (ctx->cfg_ptr->ext_zama16b && (ctx->cur_insn_len !=3D 2)) {
>          memop |=3D MO_ATOM_WITHIN16;
>      }
> -    decode_save_opc(ctx);
> +    decode_save_opc(ctx, 0);
>      if (get_xl(ctx) =3D=3D MXL_RV128) {
>          out =3D gen_load_i128(ctx, a, memop);
>      } else {
> @@ -427,7 +427,7 @@ static bool gen_store(DisasContext *ctx, arg_sb *a, M=
emOp memop)
>      if (ctx->cfg_ptr->ext_zama16b && (ctx->cur_insn_len !=3D 2)) {
>          memop |=3D MO_ATOM_WITHIN16;
>      }
> -    decode_save_opc(ctx);
> +    decode_save_opc(ctx, 0);
>      if (get_xl(ctx) =3D=3D MXL_RV128) {
>          return gen_store_i128(ctx, a, memop);
>      } else {
> @@ -889,7 +889,7 @@ static bool trans_fence_i(DisasContext *ctx, arg_fenc=
e_i *a)
>  static bool do_csr_post(DisasContext *ctx)
>  {
>      /* The helper may raise ILLEGAL_INSN -- record binv for unwind. */
> -    decode_save_opc(ctx);
> +    decode_save_opc(ctx, 0);
>      /* We may have changed important cpu state -- exit to main loop. */
>      gen_update_pc(ctx, ctx->cur_insn_len);
>      exit_tb(ctx);
> diff --git a/target/riscv/insn_trans/trans_rvvk.c.inc b/target/riscv/insn=
_trans/trans_rvvk.c.inc
> index ae1f40174a..27bf3f0b68 100644
> --- a/target/riscv/insn_trans/trans_rvvk.c.inc
> +++ b/target/riscv/insn_trans/trans_rvvk.c.inc
> @@ -249,7 +249,7 @@ GEN_OPIVI_WIDEN_TRANS(vwsll_vi, IMM_ZX, vwsll_vx, vws=
ll_vx_check)
>                                                                          =
      \
>              if (!s->vstart_eq_zero || !s->vl_eq_vlmax) {                =
      \
>                  /* save opcode for unwinding in case we throw an excepti=
on */ \
> -                decode_save_opc(s);                                     =
      \
> +                decode_save_opc(s, 0);                                  =
      \
>                  egs =3D tcg_constant_i32(EGS);                          =
        \
>                  gen_helper_egs_check(egs, tcg_env);                     =
      \
>              }                                                           =
      \
> @@ -322,7 +322,7 @@ GEN_V_UNMASKED_TRANS(vaesem_vs, vaes_check_vs, ZVKNED=
_EGS)
>                                                                          =
      \
>              if (!s->vstart_eq_zero || !s->vl_eq_vlmax) {                =
      \
>                  /* save opcode for unwinding in case we throw an excepti=
on */ \
> -                decode_save_opc(s);                                     =
      \
> +                decode_save_opc(s, 0);                                  =
      \
>                  egs =3D tcg_constant_i32(EGS);                          =
        \
>                  gen_helper_egs_check(egs, tcg_env);                     =
      \
>              }                                                           =
      \
> @@ -389,7 +389,7 @@ GEN_VI_UNMASKED_TRANS(vaeskf2_vi, vaeskf2_check, ZVKN=
ED_EGS)
>                                                                          =
      \
>              if (!s->vstart_eq_zero || !s->vl_eq_vlmax) {                =
      \
>                  /* save opcode for unwinding in case we throw an excepti=
on */ \
> -                decode_save_opc(s);                                     =
      \
> +                decode_save_opc(s, 0);                                  =
      \
>                  egs =3D tcg_constant_i32(EGS);                          =
        \
>                  gen_helper_egs_check(egs, tcg_env);                     =
      \
>              }                                                           =
      \
> @@ -440,7 +440,7 @@ static bool trans_vsha2cl_vv(DisasContext *s, arg_rmr=
r *a)
>
>          if (!s->vstart_eq_zero || !s->vl_eq_vlmax) {
>              /* save opcode for unwinding in case we throw an exception *=
/
> -            decode_save_opc(s);
> +            decode_save_opc(s, 0);
>              egs =3D tcg_constant_i32(ZVKNH_EGS);
>              gen_helper_egs_check(egs, tcg_env);
>          }
> @@ -471,7 +471,7 @@ static bool trans_vsha2ch_vv(DisasContext *s, arg_rmr=
r *a)
>
>          if (!s->vstart_eq_zero || !s->vl_eq_vlmax) {
>              /* save opcode for unwinding in case we throw an exception *=
/
> -            decode_save_opc(s);
> +            decode_save_opc(s, 0);
>              egs =3D tcg_constant_i32(ZVKNH_EGS);
>              gen_helper_egs_check(egs, tcg_env);
>          }
> diff --git a/target/riscv/insn_trans/trans_rvzacas.c.inc b/target/riscv/i=
nsn_trans/trans_rvzacas.c.inc
> index fcced99fc7..15e688a033 100644
> --- a/target/riscv/insn_trans/trans_rvzacas.c.inc
> +++ b/target/riscv/insn_trans/trans_rvzacas.c.inc
> @@ -76,7 +76,7 @@ static bool gen_cmpxchg64(DisasContext *ctx, arg_atomic=
 *a, MemOp mop)
>      TCGv src1 =3D get_address(ctx, a->rs1, 0);
>      TCGv_i64 src2 =3D get_gpr_pair(ctx, a->rs2);
>
> -    decode_save_opc(ctx);
> +    decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
>      tcg_gen_atomic_cmpxchg_i64(dest, src1, dest, src2, ctx->mem_idx, mop=
);
>
>      gen_set_gpr_pair(ctx, a->rd, dest);
> @@ -121,7 +121,7 @@ static bool trans_amocas_q(DisasContext *ctx, arg_amo=
cas_q *a)
>
>      tcg_gen_concat_i64_i128(src2, src2l, src2h);
>      tcg_gen_concat_i64_i128(dest, destl, desth);
> -    decode_save_opc(ctx);
> +    decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
>      tcg_gen_atomic_cmpxchg_i128(dest, src1, dest, src2, ctx->mem_idx,
>                                  (MO_ALIGN | MO_TEUO));
>
> diff --git a/target/riscv/insn_trans/trans_rvzfh.c.inc b/target/riscv/ins=
n_trans/trans_rvzfh.c.inc
> index 1eb458b491..bece48e600 100644
> --- a/target/riscv/insn_trans/trans_rvzfh.c.inc
> +++ b/target/riscv/insn_trans/trans_rvzfh.c.inc
> @@ -48,7 +48,7 @@ static bool trans_flh(DisasContext *ctx, arg_flh *a)
>      REQUIRE_FPU;
>      REQUIRE_ZFHMIN_OR_ZFBFMIN(ctx);
>
> -    decode_save_opc(ctx);
> +    decode_save_opc(ctx, 0);
>      t0 =3D get_gpr(ctx, a->rs1, EXT_NONE);
>      if (a->imm) {
>          TCGv temp =3D tcg_temp_new();
> @@ -71,7 +71,7 @@ static bool trans_fsh(DisasContext *ctx, arg_fsh *a)
>      REQUIRE_FPU;
>      REQUIRE_ZFHMIN_OR_ZFBFMIN(ctx);
>
> -    decode_save_opc(ctx);
> +    decode_save_opc(ctx, 0);
>      t0 =3D get_gpr(ctx, a->rs1, EXT_NONE);
>      if (a->imm) {
>          TCGv temp =3D tcg_temp_new();
> diff --git a/target/riscv/insn_trans/trans_svinval.c.inc b/target/riscv/i=
nsn_trans/trans_svinval.c.inc
> index 0f692a1088..a06c3b214f 100644
> --- a/target/riscv/insn_trans/trans_svinval.c.inc
> +++ b/target/riscv/insn_trans/trans_svinval.c.inc
> @@ -28,7 +28,7 @@ static bool trans_sinval_vma(DisasContext *ctx, arg_sin=
val_vma *a)
>      /* Do the same as sfence.vma currently */
>      REQUIRE_EXT(ctx, RVS);
>  #ifndef CONFIG_USER_ONLY
> -    decode_save_opc(ctx);
> +    decode_save_opc(ctx, 0);
>      gen_helper_tlb_flush(tcg_env);
>      return true;
>  #endif
> @@ -57,7 +57,7 @@ static bool trans_hinval_vvma(DisasContext *ctx, arg_hi=
nval_vvma *a)
>      /* Do the same as hfence.vvma currently */
>      REQUIRE_EXT(ctx, RVH);
>  #ifndef CONFIG_USER_ONLY
> -    decode_save_opc(ctx);
> +    decode_save_opc(ctx, 0);
>      gen_helper_hyp_tlb_flush(tcg_env);
>      return true;
>  #endif
> @@ -70,7 +70,7 @@ static bool trans_hinval_gvma(DisasContext *ctx, arg_hi=
nval_gvma *a)
>      /* Do the same as hfence.gvma currently */
>      REQUIRE_EXT(ctx, RVH);
>  #ifndef CONFIG_USER_ONLY
> -    decode_save_opc(ctx);
> +    decode_save_opc(ctx, 0);
>      gen_helper_hyp_gvma_tlb_flush(tcg_env);
>      return true;
>  #endif
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 16fff70dac..e677062a10 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -209,11 +209,12 @@ static void gen_check_nanbox_s(TCGv_i64 out, TCGv_i=
64 in)
>      tcg_gen_movcond_i64(TCG_COND_GEU, out, in, t_max, in, t_nan);
>  }
>
> -static void decode_save_opc(DisasContext *ctx)
> +static void decode_save_opc(DisasContext *ctx, target_ulong excp_uw2)
>  {
>      assert(!ctx->insn_start_updated);
>      ctx->insn_start_updated =3D true;
>      tcg_set_insn_start_param(ctx->base.insn_start, 1, ctx->opcode);
> +    tcg_set_insn_start_param(ctx->base.insn_start, 2, excp_uw2);
>  }
>
>  static void gen_pc_plus_diff(TCGv target, DisasContext *ctx,
> @@ -699,7 +700,7 @@ static void gen_set_rm(DisasContext *ctx, int rm)
>      }
>
>      /* The helper may raise ILLEGAL_INSN -- record binv for unwind. */
> -    decode_save_opc(ctx);
> +    decode_save_opc(ctx, 0);
>      gen_helper_set_rounding_mode(tcg_env, tcg_constant_i32(rm));
>  }
>
> @@ -712,7 +713,7 @@ static void gen_set_rm_chkfrm(DisasContext *ctx, int =
rm)
>      ctx->frm_valid =3D true;
>
>      /* The helper may raise ILLEGAL_INSN -- record binv for unwind. */
> -    decode_save_opc(ctx);
> +    decode_save_opc(ctx, 0);
>      gen_helper_set_rounding_mode_chkfrm(tcg_env, tcg_constant_i32(rm));
>  }
>
> @@ -1096,7 +1097,7 @@ static bool gen_amo(DisasContext *ctx, arg_atomic *=
a,
>          mop |=3D MO_ALIGN;
>      }
>
> -    decode_save_opc(ctx);
> +    decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
>      src1 =3D get_address(ctx, a->rs1, 0);
>      func(dest, src1, src2, ctx->mem_idx, mop);
>
> @@ -1110,7 +1111,7 @@ static bool gen_cmpxchg(DisasContext *ctx, arg_atom=
ic *a, MemOp mop)
>      TCGv src1 =3D get_address(ctx, a->rs1, 0);
>      TCGv src2 =3D get_gpr(ctx, a->rs2, EXT_NONE);
>
> -    decode_save_opc(ctx);
> +    decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
>      tcg_gen_atomic_cmpxchg_tl(dest, src1, dest, src2, ctx->mem_idx, mop)=
;
>
>      gen_set_gpr(ctx, a->rd, dest);
> --
> 2.44.0
>
>

