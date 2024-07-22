Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4DF1C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 23:33:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW2WS-0007bO-Q4; Mon, 22 Jul 2024 19:32:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sW2WR-0007a2-6H
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 19:32:51 -0400
Received: from mail-vs1-xe2e.google.com ([2607:f8b0:4864:20::e2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sW2WO-0007x7-UP
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 19:32:50 -0400
Received: by mail-vs1-xe2e.google.com with SMTP id
 ada2fe7eead31-4928989e272so744032137.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 16:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721691166; x=1722295966; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZkP7QwXr4hRE4s+dXOoLTTqerr3rhi3Ig7Sm4iNrFmA=;
 b=Ku0JUsmTUOHb8+5ij+ff28RCOpC4RVuK61cRgvoxDvQuzCJ2ehvnGbL1FlsuLxG252
 LB+CTWIZjg3r/nTZ8jXUF3/v3g/qg+i2V1ydJXTWYgRAkh5BVIGI3n3fPr37u4yzwaGI
 R7K2sR6c4hg6ssZu5MCzbKuD9FXHg4Cdj1H9lRcFLkRS1midpDF1WODncFto53ZRfxen
 lYZIltVcKHBTjKbxd0/KQgKTyQE41SPmVZtCXSA0Lh1Fj3g4VwNu1P5MA9MzCCrwNIQY
 p/Rp3VncALgev5eaf3euM7QimdEVWhDdCSs77lO/4lDXYKLu9kJ9abgPdtRUarXsPsHJ
 9hag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721691166; x=1722295966;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZkP7QwXr4hRE4s+dXOoLTTqerr3rhi3Ig7Sm4iNrFmA=;
 b=ixnzWoDiLmbvIUtwHrwXEUenFQA+YjIO5d5Ey7cK/IVu2wK8DhlVdRBBcTq12BLF9U
 v8GKSEjkevDRLD6iOQMfXyRyFOd8hcQkIPVGPOwu6qAo32RDHXAapTuLGsRr36gHUPgF
 BZLeup1MQ/4p/nepo4gu476VMWTfXoY5dF89KuNvE7uxpRf8oblBtHIeqzV++o7cVGCQ
 +QlNEjP7kWpM5kmtbpcmRvEX/S9SnWUv2RjnZBW2VR72QYxf3du3NMnBV+DraZgJHpHE
 SjdO8vb2+xIUzFa4Zqxmi2mx5Ly/Uk5URPilaDk3mAMZ8Tg/SCtnnE6nFmFVKjJEV7CJ
 8W8w==
X-Gm-Message-State: AOJu0YzgjDfgTt7BBqOkPxWgpaoKlToCoIWKuJyYa5mkgpbvKvsHGt44
 6eXp8b/8IjvLrUfMVJrL39xSarAKEJLr3vnYJp6DzTVLnd1RkMCzaI6iYDCNBHH8YXbXKZXrIfb
 s8T47vH3RB0/auhBnxKbrUWNC71UjhhXPYlA=
X-Google-Smtp-Source: AGHT+IEtcUMBgAK8UU3dU30MKrNHsa846cttdDcye5ASwrjO2qkR8gXVQWbv+civTEZnB25v3vQ8UiRRLYbTprFFgRM=
X-Received: by 2002:a05:6102:5f0c:b0:48f:1bea:3c70 with SMTP id
 ada2fe7eead31-4928b99e83cmr9232220137.17.1721691166132; Mon, 22 Jul 2024
 16:32:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240718021012.2057986-1-alistair.francis@wdc.com>
 <20240718021012.2057986-6-alistair.francis@wdc.com>
In-Reply-To: <20240718021012.2057986-6-alistair.francis@wdc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 23 Jul 2024 09:32:20 +1000
Message-ID: <CAKmqyKNsjEiwDYpZx5j84xu69nc5TS6syGp7mwbB9BJaVVhNzg@mail.gmail.com>
Subject: Re: [PULL 05/30] target/riscv: Support Zama16b extension
To: qemu-devel@nongnu.org
Cc: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2e;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2e.google.com
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

On Thu, Jul 18, 2024 at 12:10=E2=80=AFPM Alistair Francis <alistair23@gmail=
.com> wrote:
>
> From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
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
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Message-ID: <20240709113652.1239-6-zhiwei_liu@linux.alibaba.com>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu_cfg.h                  |  1 +
>  target/riscv/cpu.c                      |  2 ++
>  target/riscv/insn_trans/trans_rva.c.inc | 42 ++++++++++++++-----------
>  target/riscv/insn_trans/trans_rvd.c.inc | 14 +++++++--
>  target/riscv/insn_trans/trans_rvf.c.inc | 14 +++++++--
>  target/riscv/insn_trans/trans_rvi.c.inc |  6 ++++
>  6 files changed, 57 insertions(+), 22 deletions(-)
>
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
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index f4f8287a6d..de9c06904f 100644
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

Richard pointed out that checking the cur_insn_len looks a bit strange.

He's right, the length of the instruction has no impact. We should
instead just check for ext_zama16b

Do you mind sending a followup patch to remove all of the instruction
length checks?

Alistair

