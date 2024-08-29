Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 471C5C7114C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 00:02:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjSc0-0001fr-98; Wed, 28 Aug 2024 20:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sjSby-0001cR-KD; Wed, 28 Aug 2024 20:02:02 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sjSbw-0003qX-8F; Wed, 28 Aug 2024 20:02:02 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3db14339fb0so38714b6e.2; 
 Wed, 28 Aug 2024 17:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724889717; x=1725494517; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NAHKTVPYI9c/nz80GN8ovrKmVljGCelJCXsiS+hVZr0=;
 b=HGF+vi8PHh2QdACexPEC0NlniDIXu80uy6FZB26816jhEJ5EXQgKlMcmX2D3g7XciT
 Xbqf/D/xbRtnucIlChzJnoGfjQbLaCOiLhy7+KZU4kXgfl9v9JBUxvSgq6bn/KaXbG6n
 0fyqKufoxaHKMJazzIM6vazKlKPKwDwPbr+O995hJSJdlyXZryXgm7ZASlXl5w2rp1tG
 Yk0c50Ta4ybpW872M4UdOzPJnML/4NBHnUUTqbrk06sbJ0XdwDA3mT4pdGr2G3SG4ejY
 pv3ahWIIcSKjsRs698SbivzGepcYS0858fdkNBbkofvM2PtMCy7THnl8hec2rgIeokqK
 OVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724889717; x=1725494517;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NAHKTVPYI9c/nz80GN8ovrKmVljGCelJCXsiS+hVZr0=;
 b=D9vgdFhdRVkHqmN4qZzSzpyWpKIhEQT6ZwcYu+M9VzBuIGsmd+1zYuV6fwwoGaNrs5
 5aY8Tst0xjh8q6QKKwj5YMekvlQY5uNBl6TbuC/EqN+oWVRfbuvAg/hdWa+9k0fr8cc3
 qzXjeNkWAoG5bGCyvswuCfYqvETUdKVDaLRKBsqBdQDpPO4SpHC5qGW5R3JM/HYYtGQy
 sQtnUUphekZdBDCXgSFPZvkb7Ft6MCvWUtFTLmi8FnyuIOvubvziXhUqZ2iEq7M/0SOJ
 GYCQVHm5wgcUH2N6WXOO0ELhICwqArZwEJ4utTwmFQTAltU5lefdHWospyB74reRqo6N
 Ke3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSEsbysd5jfV0bUZOHFvv+mFpqW7EXC8WTm3uYU6a7mcIVRn5GgBEAlVyAVORAd/pKtDwbR3CKb566@nongnu.org
X-Gm-Message-State: AOJu0YzHUnMMy+M81LWHIAMoh33dvv80KILQPXUlsEb1z6TvpEKRlZTn
 6Hc5GGzm9/oFHFxWcemWCTMcKw/wIhUruEqi055eiFoYC3SEodHzzE0DcWd3fWX4FcUlrpcEzsg
 i/DHhQ/iaWAnQw1dUVQHgtm+j9aA=
X-Google-Smtp-Source: AGHT+IFq/QYEQbQm+YFNt1hvj3nynGW7FU909Vwf8ZpzDrBPoO13IElB/nUI6gNCG1d07POdji766Op+y58f6Sy+tN8=
X-Received: by 2002:a05:6808:1388:b0:3db:42b2:ee28 with SMTP id
 5614622812f47-3df05e8e9dbmr1225484b6e.51.1724889717194; Wed, 28 Aug 2024
 17:01:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240828174739.714313-1-debug@rivosinc.com>
 <20240828174739.714313-17-debug@rivosinc.com>
In-Reply-To: <20240828174739.714313-17-debug@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 29 Aug 2024 10:01:30 +1000
Message-ID: <CAKmqyKOF0XGhSH5-vNKqFXhX=XB9p5STRAsm6kNaph=7i-7=3A@mail.gmail.com>
Subject: Re: [PATCH v11 16/20] target/riscv: implement zicfiss instructions
To: Deepak Gupta <debug@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 Alistair.Francis@wdc.com, laurent@vivier.eu, bmeng.cn@gmail.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 jim.shu@sifive.com, andy.chiu@sifive.com, kito.cheng@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=alistair23@gmail.com; helo=mail-oi1-x22d.google.com
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

On Thu, Aug 29, 2024 at 3:53=E2=80=AFAM Deepak Gupta <debug@rivosinc.com> w=
rote:
>
> zicfiss has following instructions
>  - sspopchk: pops a value from shadow stack and compares with x1/x5.
>    If they dont match, reports a sw check exception with tval =3D 3.
>  - sspush: pushes value in x1/x5 on shadow stack
>  - ssrdp: reads current shadow stack
>  - ssamoswap: swaps contents of shadow stack atomically
>
> sspopchk/sspush/ssrdp default to zimop if zimop implemented and SSE=3D0
>
> If SSE=3D0, ssamoswap is illegal instruction exception.
>
> This patch implements shadow stack operations for qemu-user and shadow
> stack is not protected.
>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> Co-developed-by: Jim Shu <jim.shu@sifive.com>
> Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
> ---
>  target/riscv/cpu_bits.h                       |  2 +
>  target/riscv/insn32.decode                    | 21 +++++-
>  target/riscv/insn_trans/trans_rva.c.inc       | 39 ++++++++++
>  target/riscv/insn_trans/trans_rvzicfiss.c.inc | 75 +++++++++++++++++++
>  target/riscv/translate.c                      |  5 ++
>  5 files changed, 140 insertions(+), 2 deletions(-)
>  create mode 100644 target/riscv/insn_trans/trans_rvzicfiss.c.inc
>
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 48ce24dc32..bb62fbe9ec 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -690,6 +690,8 @@ typedef enum RISCVException {
>
>  /* zicfilp defines lp violation results in sw check with tval =3D 2*/
>  #define RISCV_EXCP_SW_CHECK_FCFI_TVAL      2
> +/* zicfiss defines ss violation results in sw check with tval =3D 3*/
> +#define RISCV_EXCP_SW_CHECK_BCFI_TVAL      3
>
>  #define RISCV_EXCP_INT_FLAG                0x80000000
>  #define RISCV_EXCP_INT_MASK                0x7fffffff
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index 27108b992b..e9139ec1b9 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -246,6 +246,7 @@ remud    0000001 .....  ..... 111 ..... 1111011 @r
>  lr_w       00010 . . 00000 ..... 010 ..... 0101111 @atom_ld
>  sc_w       00011 . . ..... ..... 010 ..... 0101111 @atom_st
>  amoswap_w  00001 . . ..... ..... 010 ..... 0101111 @atom_st
> +ssamoswap_w 01001 . . ..... ..... 010 ..... 0101111 @atom_st
>  amoadd_w   00000 . . ..... ..... 010 ..... 0101111 @atom_st
>  amoxor_w   00100 . . ..... ..... 010 ..... 0101111 @atom_st
>  amoand_w   01100 . . ..... ..... 010 ..... 0101111 @atom_st
> @@ -259,6 +260,7 @@ amomaxu_w  11100 . . ..... ..... 010 ..... 0101111 @a=
tom_st
>  lr_d       00010 . . 00000 ..... 011 ..... 0101111 @atom_ld
>  sc_d       00011 . . ..... ..... 011 ..... 0101111 @atom_st
>  amoswap_d  00001 . . ..... ..... 011 ..... 0101111 @atom_st
> +ssamoswap_d 01001 . . ..... ..... 011 ..... 0101111 @atom_st
>  amoadd_d   00000 . . ..... ..... 011 ..... 0101111 @atom_st
>  amoxor_d   00100 . . ..... ..... 011 ..... 0101111 @atom_st
>  amoand_d   01100 . . ..... ..... 011 ..... 0101111 @atom_st
> @@ -1022,8 +1024,23 @@ amocas_d    00101 . . ..... ..... 011 ..... 010111=
1 @atom_st
>  amocas_q    00101 . . ..... ..... 100 ..... 0101111 @atom_st
>
>  # *** Zimop may-be-operation extension ***
> -mop_r_n     1 . 00 .. 0111 .. ..... 100 ..... 1110011 @mop5
> -mop_rr_n    1 . 00 .. 1 ..... ..... 100 ..... 1110011 @mop3
> +{
> +  # zicfiss instructions carved out of mop.r
> +  [
> +    ssrdp     1100110 11100 00000 100 rd:5  1110011
> +    sspopchk  1100110 11100 00001 100 00000 1110011 &r2 rs1=3D1 rd=3D0
> +    sspopchk  1100110 11100 00101 100 00000 1110011 &r2 rs1=3D5 rd=3D0
> +  ]
> +  mop_r_n    1 . 00 .. 0111 .. ..... 100 ..... 1110011 @mop5
> +}
> +{
> +  # zicfiss instruction carved out of mop.rr
> +  [
> +    sspush    1100111 00001  00000 100 00000 1110011 &r2_s rs2=3D1 rs1=
=3D0
> +    sspush    1100111 00101  00000 100 00000 1110011 &r2_s rs2=3D5 rs1=
=3D0
> +  ]
> +  mop_rr_n   1 . 00 .. 1 ..... ..... 100 ..... 1110011 @mop3
> +}
>
>  # *** Zabhb Standard Extension ***
>  amoswap_b  00001 . . ..... ..... 000 ..... 0101111 @atom_st
> diff --git a/target/riscv/insn_trans/trans_rva.c.inc b/target/riscv/insn_=
trans/trans_rva.c.inc
> index 9cf3ae8019..a2119393a6 100644
> --- a/target/riscv/insn_trans/trans_rva.c.inc
> +++ b/target/riscv/insn_trans/trans_rva.c.inc
> @@ -114,6 +114,25 @@ static bool trans_amoswap_w(DisasContext *ctx, arg_a=
moswap_w *a)
>      return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_TESL);
>  }
>
> +static bool trans_ssamoswap_w(DisasContext *ctx, arg_amoswap_w *a)
> +{
> +    REQUIRE_A_OR_ZAAMO(ctx);
> +    if (!ctx->bcfi_enabled) {
> +        return false;
> +    }
> +
> +    TCGv dest =3D dest_gpr(ctx, a->rd);
> +    TCGv src1, src2 =3D get_gpr(ctx, a->rs2, EXT_NONE);
> +
> +    decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
> +    src1 =3D get_address(ctx, a->rs1, 0);
> +
> +    tcg_gen_atomic_xchg_tl(dest, src1, src2, SS_MMU_INDEX(ctx),
> +                           (MO_ALIGN | MO_TESL));
> +    gen_set_gpr(ctx, a->rd, dest);
> +    return true;
> +}
> +
>  static bool trans_amoadd_w(DisasContext *ctx, arg_amoadd_w *a)
>  {
>      REQUIRE_A_OR_ZAAMO(ctx);
> @@ -183,6 +202,26 @@ static bool trans_amoswap_d(DisasContext *ctx, arg_a=
moswap_d *a)
>      return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_TEUQ);
>  }
>
> +static bool trans_ssamoswap_d(DisasContext *ctx, arg_amoswap_w *a)
> +{
> +    REQUIRE_64BIT(ctx);
> +    REQUIRE_A_OR_ZAAMO(ctx);
> +    if (!ctx->bcfi_enabled) {
> +        return false;
> +    }
> +
> +    TCGv dest =3D dest_gpr(ctx, a->rd);
> +    TCGv src1, src2 =3D get_gpr(ctx, a->rs2, EXT_NONE);
> +
> +    decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
> +    src1 =3D get_address(ctx, a->rs1, 0);
> +
> +    tcg_gen_atomic_xchg_tl(dest, src1, src2, SS_MMU_INDEX(ctx),
> +                           (MO_ALIGN | MO_TESQ));
> +    gen_set_gpr(ctx, a->rd, dest);
> +    return true;
> +}

Why aren't these in the rvzicfiss file?

Otherwise:

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> +
>  static bool trans_amoadd_d(DisasContext *ctx, arg_amoadd_d *a)
>  {
>      REQUIRE_64BIT(ctx);
> diff --git a/target/riscv/insn_trans/trans_rvzicfiss.c.inc b/target/riscv=
/insn_trans/trans_rvzicfiss.c.inc
> new file mode 100644
> index 0000000000..741459003d
> --- /dev/null
> +++ b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
> @@ -0,0 +1,75 @@
> +/*
> + * RISC-V translation routines for the Control-Flow Integrity Extension
> + *
> + * Copyright (c) 2024 Rivos Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOU=
T
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +static bool trans_sspopchk(DisasContext *ctx, arg_sspopchk *a)
> +{
> +    if (!ctx->bcfi_enabled) {
> +        return false;
> +    }
> +
> +    TCGv addr =3D tcg_temp_new();
> +    TCGLabel *skip =3D gen_new_label();
> +    uint32_t tmp =3D (get_xl(ctx) =3D=3D MXL_RV64) ? 8 : 4;
> +    TCGv data =3D tcg_temp_new();
> +    tcg_gen_ld_tl(addr, tcg_env, offsetof(CPURISCVState, ssp));
> +    decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
> +    tcg_gen_qemu_ld_tl(data, addr, SS_MMU_INDEX(ctx),
> +                       mxl_memop(ctx) | MO_ALIGN);
> +    TCGv rs1 =3D get_gpr(ctx, a->rs1, EXT_NONE);
> +    tcg_gen_brcond_tl(TCG_COND_EQ, data, rs1, skip);
> +    tcg_gen_st_tl(tcg_constant_tl(RISCV_EXCP_SW_CHECK_BCFI_TVAL),
> +                  tcg_env, offsetof(CPURISCVState, sw_check_code));
> +    gen_helper_raise_exception(tcg_env,
> +                  tcg_constant_i32(RISCV_EXCP_SW_CHECK));
> +    gen_set_label(skip);
> +    tcg_gen_addi_tl(addr, addr, tmp);
> +    tcg_gen_st_tl(addr, tcg_env, offsetof(CPURISCVState, ssp));
> +
> +    return true;
> +}
> +
> +static bool trans_sspush(DisasContext *ctx, arg_sspush *a)
> +{
> +    if (!ctx->bcfi_enabled) {
> +        return false;
> +    }
> +
> +    TCGv addr =3D tcg_temp_new();
> +    int tmp =3D (get_xl(ctx) =3D=3D MXL_RV64) ? -8 : -4;
> +    TCGv data =3D get_gpr(ctx, a->rs2, EXT_NONE);
> +    decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
> +    tcg_gen_ld_tl(addr, tcg_env, offsetof(CPURISCVState, ssp));
> +    tcg_gen_addi_tl(addr, addr, tmp);
> +    tcg_gen_qemu_st_tl(data, addr, SS_MMU_INDEX(ctx),
> +                       mxl_memop(ctx) | MO_ALIGN);
> +    tcg_gen_st_tl(addr, tcg_env, offsetof(CPURISCVState, ssp));
> +
> +    return true;
> +}
> +
> +static bool trans_ssrdp(DisasContext *ctx, arg_ssrdp *a)
> +{
> +    if (!ctx->bcfi_enabled || a->rd =3D=3D 0) {
> +        return false;
> +    }
> +
> +    TCGv dest =3D dest_gpr(ctx, a->rd);
> +    tcg_gen_ld_tl(dest, tcg_env, offsetof(CPURISCVState, ssp));
> +    gen_set_gpr(ctx, a->rd, dest);
> +
> +    return true;
> +}
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index e677062a10..2753c154ba 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -144,6 +144,8 @@ static inline bool has_ext(DisasContext *ctx, uint32_=
t ext)
>  #define get_address_xl(ctx)    ((ctx)->address_xl)
>  #endif
>
> +#define mxl_memop(ctx) ((get_xl(ctx) + 1) | MO_TE)
> +
>  /* The word size for this machine mode. */
>  static inline int __attribute__((unused)) get_xlen(DisasContext *ctx)
>  {
> @@ -1127,6 +1129,8 @@ static uint32_t opcode_at(DisasContextBase *dcbase,=
 target_ulong pc)
>      return translator_ldl(env, &ctx->base, pc);
>  }
>
> +#define SS_MMU_INDEX(ctx) (ctx->mem_idx | MMU_IDX_SS_WRITE)
> +
>  /* Include insn module translation function */
>  #include "insn_trans/trans_rvi.c.inc"
>  #include "insn_trans/trans_rvm.c.inc"
> @@ -1157,6 +1161,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase,=
 target_ulong pc)
>  #include "decode-insn16.c.inc"
>  #include "insn_trans/trans_rvzce.c.inc"
>  #include "insn_trans/trans_rvzcmop.c.inc"
> +#include "insn_trans/trans_rvzicfiss.c.inc"
>
>  /* Include decoders for factored-out extensions */
>  #include "decode-XVentanaCondOps.c.inc"
> --
> 2.44.0
>
>

