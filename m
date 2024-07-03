Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 319D4C30658
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 00:13:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOnc7-0005qp-SJ; Tue, 02 Jul 2024 20:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sOnc5-0005qI-1M; Tue, 02 Jul 2024 20:12:46 -0400
Received: from mail-vk1-xa2d.google.com ([2607:f8b0:4864:20::a2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sOnc2-0001Zp-U9; Tue, 02 Jul 2024 20:12:44 -0400
Received: by mail-vk1-xa2d.google.com with SMTP id
 71dfb90a1353d-4ef5f4e3f56so1520311e0c.3; 
 Tue, 02 Jul 2024 17:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719965561; x=1720570361; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aYcqC3NmCEe1ZlLfdYFuK0biL0G2z7Sd4g/EmJoiElM=;
 b=D4umgjfFmgR8SRZwMotOIwiz2pTl+N0GzJWE/0O3z3mwe01he5mXCiSbrF3+pypVWh
 LH2fNWH5c5WKpRC0kF7o02Vq113kp9zYzps6nI3R062sMt0pFk5vGY9ozg+cw1ZW2JEZ
 rDqQYMLbAvBJUQL1P+azQ9f7tyeLGXV+X8PbLOoWU2EARw5KpP3p0kFEKi8Z/CuM/iC2
 Gb8WxHaJaQSke2GzXpFNOm+9E1spPcZJ2OAEePEMtOi0+0BJmJIKx50+0Fxl4CdVBO2f
 9GJG2W3tq+2lf4j6iZ4LbP4zInE3BSMH2P7FvPBuP/4wL51+vWUutkdGZfuUzZldBqed
 mU8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719965561; x=1720570361;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aYcqC3NmCEe1ZlLfdYFuK0biL0G2z7Sd4g/EmJoiElM=;
 b=V7Fm0Vs8crh/7R9MSpa8HyMDQ4v4FszI8UW+6EP2QCZkFZ7bBNWJTx4hk3nQBVyYYK
 z+L8iVAsRsvSn8bPFuvcKDisTTtcmzIW0JtIqizwQ35Yq3CsV5WQivHJmrUmIFeVVKgJ
 KT6R8MsiuXhbj3QyWrEFinxiC3ef/4OB6xTLy8lJpp/VsatqS9PvoIz3GbNOzGqlagj7
 zbQ55NVxC1ieUafES8m+bNsaHikh/Wef20OrpPdqhqY0hGeKKApL4wueswsYr/lyfsv/
 dBXmjs+ctWUQEHtvnsruTnAVLe/jdZfJGtH6HGkK4E7M4jg3H/pHRrb3PRsWwbzkVmSK
 MyoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBwtO+VLJQCHDetl5vyscLD/vcLVv1Pl747db32V0Y0kbTWhT8cvSag6eywexE6Q6fOrhy/Z3o4e9F+fKxbIvEBnMvnRA=
X-Gm-Message-State: AOJu0Yw+eJg8wcNeLqF49/6q2C0W1cklqsHzKCeIq/KY1IivtPdAsKWD
 9cP08sAcf9F/mKnP6ubPNnjlV1cg9lTOw+1Dy8ltmq27pn2pmPXlnC4lSu1fDoV5GeulSCoP0rd
 jTsIrJoajsr67+3NQzBEGZDUMAxWEMGbU
X-Google-Smtp-Source: AGHT+IHjJHN40yrQs0ro5bCg7/yfOF9RgBflagUDcqHrCHhxB4VRQNzd0qrZvLQZ1fep/++Kwidasnj6ZDgE72GRwAM=
X-Received: by 2002:a05:6122:4895:b0:4ef:64a2:8e18 with SMTP id
 71dfb90a1353d-4f2a5704fb8mr12923557e0c.12.1719965561243; Tue, 02 Jul 2024
 17:12:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240630030559.877-1-zhiwei_liu@linux.alibaba.com>
 <20240630030559.877-6-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240630030559.877-6-zhiwei_liu@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 3 Jul 2024 10:12:15 +1000
Message-ID: <CAKmqyKMcf4ZWApkUSV-VbpSKpXeBE_uTNvT1QG-w00LbSuj8hQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/11] target/riscv: Support Zama16b extension
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, dbarboza@ventanamicro.com, liwei1518@gmail.com, 
 bmeng.cn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2d;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2d.google.com
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

On Sun, Jun 30, 2024 at 1:11=E2=80=AFPM LIU Zhiwei <zhiwei_liu@linux.alibab=
a.com> wrote:
>
> Zama16b is the property that misaligned load/stores/atomics within
> a naturally aligned 16-byte region are atomic.
>
> According to the specification, Zama16b applies only to AMOs, loads
> and stores defined in the base ISAs, and loads and stores of no more
> than XLEN bits defined in the F, D, and Q extensions. Thus it should
> not apply to zacas or RVC instructions.
>
> For an instruction in that set, if all accessed bytes lie within 16B gran=
ule,
> the instruction will not raise an exception for reasons of address alignm=
ent,
> and the instruction will give rise to only one memory operation for the
> purposes of RVWMO=E2=80=94i.e., it will execute atomically.
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c                      |  2 ++
>  target/riscv/cpu_cfg.h                  |  1 +
>  target/riscv/insn_trans/trans_rva.c.inc | 42 ++++++++++++++-----------
>  target/riscv/insn_trans/trans_rvd.c.inc | 14 +++++++--
>  target/riscv/insn_trans/trans_rvf.c.inc | 14 +++++++--
>  target/riscv/insn_trans/trans_rvi.c.inc |  6 ++++
>  6 files changed, 57 insertions(+), 22 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 1d1402775a..5219b44176 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -118,6 +118,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(za64rs, PRIV_VERSION_1_12_0, has_priv_1_11),
>      ISA_EXT_DATA_ENTRY(zaamo, PRIV_VERSION_1_12_0, ext_zaamo),
>      ISA_EXT_DATA_ENTRY(zacas, PRIV_VERSION_1_12_0, ext_zacas),
> +    ISA_EXT_DATA_ENTRY(zama16b, PRIV_VERSION_1_13_0, ext_zama16b),
>      ISA_EXT_DATA_ENTRY(zalrsc, PRIV_VERSION_1_12_0, ext_zalrsc),
>      ISA_EXT_DATA_ENTRY(zawrs, PRIV_VERSION_1_12_0, ext_zawrs),
>      ISA_EXT_DATA_ENTRY(zfa, PRIV_VERSION_1_12_0, ext_zfa),
> @@ -1476,6 +1477,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[]=
 =3D {
>      MULTI_EXT_CFG_BOOL("zimop", ext_zimop, false),
>      MULTI_EXT_CFG_BOOL("zcmop", ext_zcmop, false),
>      MULTI_EXT_CFG_BOOL("zacas", ext_zacas, false),
> +    MULTI_EXT_CFG_BOOL("zama16b", ext_zama16b, false),
>      MULTI_EXT_CFG_BOOL("zaamo", ext_zaamo, false),
>      MULTI_EXT_CFG_BOOL("zalrsc", ext_zalrsc, false),
>      MULTI_EXT_CFG_BOOL("zawrs", ext_zawrs, true),
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index d85e54b475..ddbfae37e5 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -83,6 +83,7 @@ struct RISCVCPUConfig {
>      bool ext_zdinx;
>      bool ext_zaamo;
>      bool ext_zacas;
> +    bool ext_zama16b;
>      bool ext_zalrsc;
>      bool ext_zawrs;
>      bool ext_zfa;
> diff --git a/target/riscv/insn_trans/trans_rva.c.inc b/target/riscv/insn_=
trans/trans_rva.c.inc
> index 4a9e4591d1..eb080baddd 100644
> --- a/target/riscv/insn_trans/trans_rva.c.inc
> +++ b/target/riscv/insn_trans/trans_rva.c.inc
> @@ -103,6 +103,12 @@ static bool gen_amo(DisasContext *ctx, arg_atomic *a=
,
>      TCGv dest =3D dest_gpr(ctx, a->rd);
>      TCGv src1, src2 =3D get_gpr(ctx, a->rs2, EXT_NONE);
>
> +    if (ctx->cfg_ptr->ext_zama16b) {
> +        mop |=3D MO_ATOM_WITHIN16;
> +    } else {
> +        mop |=3D MO_ALIGN;
> +    }
> +
>      decode_save_opc(ctx);
>      src1 =3D get_address(ctx, a->rs1, 0);
>      func(dest, src1, src2, ctx->mem_idx, mop);
> @@ -126,55 +132,55 @@ static bool trans_sc_w(DisasContext *ctx, arg_sc_w =
*a)
>  static bool trans_amoswap_w(DisasContext *ctx, arg_amoswap_w *a)
>  {
>      REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, (MO_ALIGN | MO_TESL)=
);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_TESL);
>  }
>
>  static bool trans_amoadd_w(DisasContext *ctx, arg_amoadd_w *a)
>  {
>      REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, (MO_ALIGN | MO_=
TESL));
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, MO_TESL);
>  }
>
>  static bool trans_amoxor_w(DisasContext *ctx, arg_amoxor_w *a)
>  {
>      REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, (MO_ALIGN | MO_=
TESL));
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, MO_TESL);
>  }
>
>  static bool trans_amoand_w(DisasContext *ctx, arg_amoand_w *a)
>  {
>      REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, (MO_ALIGN | MO_=
TESL));
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, MO_TESL);
>  }
>
>  static bool trans_amoor_w(DisasContext *ctx, arg_amoor_w *a)
>  {
>      REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, (MO_ALIGN | MO_T=
ESL));
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, MO_TESL);
>  }
>
>  static bool trans_amomin_w(DisasContext *ctx, arg_amomin_w *a)
>  {
>      REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, (MO_ALIGN | MO=
_TESL));
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, MO_TESL);
>  }
>
>  static bool trans_amomax_w(DisasContext *ctx, arg_amomax_w *a)
>  {
>      REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, (MO_ALIGN | MO=
_TESL));
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, MO_TESL);
>  }
>
>  static bool trans_amominu_w(DisasContext *ctx, arg_amominu_w *a)
>  {
>      REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, (MO_ALIGN | MO=
_TESL));
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, MO_TESL);
>  }
>
>  static bool trans_amomaxu_w(DisasContext *ctx, arg_amomaxu_w *a)
>  {
>      REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, (MO_ALIGN | MO=
_TESL));
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, MO_TESL);
>  }
>
>  static bool trans_lr_d(DisasContext *ctx, arg_lr_d *a)
> @@ -195,61 +201,61 @@ static bool trans_amoswap_d(DisasContext *ctx, arg_=
amoswap_d *a)
>  {
>      REQUIRE_64BIT(ctx);
>      REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, (MO_ALIGN | MO_TEUQ)=
);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_TEUQ);
>  }
>
>  static bool trans_amoadd_d(DisasContext *ctx, arg_amoadd_d *a)
>  {
>      REQUIRE_64BIT(ctx);
>      REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, (MO_ALIGN | MO_=
TEUQ));
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, MO_TEUQ);
>  }
>
>  static bool trans_amoxor_d(DisasContext *ctx, arg_amoxor_d *a)
>  {
>      REQUIRE_64BIT(ctx);
>      REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, (MO_ALIGN | MO_=
TEUQ));
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, MO_TEUQ);
>  }
>
>  static bool trans_amoand_d(DisasContext *ctx, arg_amoand_d *a)
>  {
>      REQUIRE_64BIT(ctx);
>      REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, (MO_ALIGN | MO_=
TEUQ));
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, MO_TEUQ);
>  }
>
>  static bool trans_amoor_d(DisasContext *ctx, arg_amoor_d *a)
>  {
>      REQUIRE_64BIT(ctx);
>      REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, (MO_ALIGN | MO_T=
EUQ));
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, MO_TEUQ);
>  }
>
>  static bool trans_amomin_d(DisasContext *ctx, arg_amomin_d *a)
>  {
>      REQUIRE_64BIT(ctx);
>      REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, (MO_ALIGN | MO=
_TEUQ));
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, MO_TEUQ);
>  }
>
>  static bool trans_amomax_d(DisasContext *ctx, arg_amomax_d *a)
>  {
>      REQUIRE_64BIT(ctx);
>      REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, (MO_ALIGN | MO=
_TEUQ));
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, MO_TEUQ);
>  }
>
>  static bool trans_amominu_d(DisasContext *ctx, arg_amominu_d *a)
>  {
>      REQUIRE_64BIT(ctx);
>      REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, (MO_ALIGN | MO=
_TEUQ));
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, MO_TEUQ);
>  }
>
>  static bool trans_amomaxu_d(DisasContext *ctx, arg_amomaxu_d *a)
>  {
>      REQUIRE_64BIT(ctx);
>      REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, (MO_ALIGN | MO=
_TEUQ));
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, MO_TEUQ);
>  }
> diff --git a/target/riscv/insn_trans/trans_rvd.c.inc b/target/riscv/insn_=
trans/trans_rvd.c.inc
> index d9ce9e407f..1f5fac65a2 100644
> --- a/target/riscv/insn_trans/trans_rvd.c.inc
> +++ b/target/riscv/insn_trans/trans_rvd.c.inc
> @@ -42,13 +42,18 @@
>  static bool trans_fld(DisasContext *ctx, arg_fld *a)
>  {
>      TCGv addr;
> +    MemOp memop =3D MO_TEUQ;
>
>      REQUIRE_FPU;
>      REQUIRE_EXT(ctx, RVD);
>
> +    if (ctx->cfg_ptr->ext_zama16b && (ctx->cur_insn_len !=3D 2)) {
> +        memop |=3D MO_ATOM_WITHIN16;
> +    }
> +
>      decode_save_opc(ctx);
>      addr =3D get_address(ctx, a->rs1, a->imm);
> -    tcg_gen_qemu_ld_i64(cpu_fpr[a->rd], addr, ctx->mem_idx, MO_TEUQ);
> +    tcg_gen_qemu_ld_i64(cpu_fpr[a->rd], addr, ctx->mem_idx, memop);
>
>      mark_fs_dirty(ctx);
>      return true;
> @@ -57,13 +62,18 @@ static bool trans_fld(DisasContext *ctx, arg_fld *a)
>  static bool trans_fsd(DisasContext *ctx, arg_fsd *a)
>  {
>      TCGv addr;
> +    MemOp memop =3D MO_TEUQ;
>
>      REQUIRE_FPU;
>      REQUIRE_EXT(ctx, RVD);
>
> +    if (ctx->cfg_ptr->ext_zama16b && (ctx->cur_insn_len !=3D 2)) {
> +        memop |=3D MO_ATOM_WITHIN16;
> +    }
> +
>      decode_save_opc(ctx);
>      addr =3D get_address(ctx, a->rs1, a->imm);
> -    tcg_gen_qemu_st_i64(cpu_fpr[a->rs2], addr, ctx->mem_idx, MO_TEUQ);
> +    tcg_gen_qemu_st_i64(cpu_fpr[a->rs2], addr, ctx->mem_idx, memop);
>      return true;
>  }
>
> diff --git a/target/riscv/insn_trans/trans_rvf.c.inc b/target/riscv/insn_=
trans/trans_rvf.c.inc
> index 97a368970b..f771aa1939 100644
> --- a/target/riscv/insn_trans/trans_rvf.c.inc
> +++ b/target/riscv/insn_trans/trans_rvf.c.inc
> @@ -43,14 +43,19 @@ static bool trans_flw(DisasContext *ctx, arg_flw *a)
>  {
>      TCGv_i64 dest;
>      TCGv addr;
> +    MemOp memop =3D MO_TEUL;
>
>      REQUIRE_FPU;
>      REQUIRE_EXT(ctx, RVF);
>
> +    if (ctx->cfg_ptr->ext_zama16b && (ctx->cur_insn_len !=3D 2)) {
> +        memop |=3D MO_ATOM_WITHIN16;
> +    }
> +
>      decode_save_opc(ctx);
>      addr =3D get_address(ctx, a->rs1, a->imm);
>      dest =3D cpu_fpr[a->rd];
> -    tcg_gen_qemu_ld_i64(dest, addr, ctx->mem_idx, MO_TEUL);
> +    tcg_gen_qemu_ld_i64(dest, addr, ctx->mem_idx, memop);
>      gen_nanbox_s(dest, dest);
>
>      mark_fs_dirty(ctx);
> @@ -60,13 +65,18 @@ static bool trans_flw(DisasContext *ctx, arg_flw *a)
>  static bool trans_fsw(DisasContext *ctx, arg_fsw *a)
>  {
>      TCGv addr;
> +    MemOp memop =3D MO_TEUL;
>
>      REQUIRE_FPU;
>      REQUIRE_EXT(ctx, RVF);
>
> +    if (ctx->cfg_ptr->ext_zama16b && (ctx->cur_insn_len !=3D 2)) {
> +        memop |=3D MO_ATOM_WITHIN16;
> +    }
> +
>      decode_save_opc(ctx);
>      addr =3D get_address(ctx, a->rs1, a->imm);
> -    tcg_gen_qemu_st_i64(cpu_fpr[a->rs2], addr, ctx->mem_idx, MO_TEUL);
> +    tcg_gen_qemu_st_i64(cpu_fpr[a->rs2], addr, ctx->mem_idx, memop);
>      return true;
>  }
>
> diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_=
trans/trans_rvi.c.inc
> index ad40d3e87f..98e3806d5e 100644
> --- a/target/riscv/insn_trans/trans_rvi.c.inc
> +++ b/target/riscv/insn_trans/trans_rvi.c.inc
> @@ -268,6 +268,9 @@ static bool gen_load(DisasContext *ctx, arg_lb *a, Me=
mOp memop)
>  {
>      bool out;
>
> +    if (ctx->cfg_ptr->ext_zama16b && (ctx->cur_insn_len !=3D 2)) {
> +        memop |=3D MO_ATOM_WITHIN16;
> +    }
>      decode_save_opc(ctx);
>      if (get_xl(ctx) =3D=3D MXL_RV128) {
>          out =3D gen_load_i128(ctx, a, memop);
> @@ -366,6 +369,9 @@ static bool gen_store_i128(DisasContext *ctx, arg_sb =
*a, MemOp memop)
>
>  static bool gen_store(DisasContext *ctx, arg_sb *a, MemOp memop)
>  {
> +    if (ctx->cfg_ptr->ext_zama16b && (ctx->cur_insn_len !=3D 2)) {
> +        memop |=3D MO_ATOM_WITHIN16;
> +    }
>      decode_save_opc(ctx);
>      if (get_xl(ctx) =3D=3D MXL_RV128) {
>          return gen_store_i128(ctx, a, memop);
> --
> 2.25.1
>
>

