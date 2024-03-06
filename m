Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44BB9C54798
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 01:28:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhg4p-0001eM-0Q; Tue, 05 Mar 2024 20:28:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rhg4j-0001do-8P; Tue, 05 Mar 2024 20:28:08 -0500
Received: from mail-vk1-xa33.google.com ([2607:f8b0:4864:20::a33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rhg4c-00033S-1f; Tue, 05 Mar 2024 20:28:02 -0500
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-4d365d28456so1187004e0c.2; 
 Tue, 05 Mar 2024 17:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709688474; x=1710293274; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6OsTV23KsJRIhGwIkzC6YJrm/IPHMCAQ/rP+6aL8H2U=;
 b=KMagQTbK+Bpoj+vfvP/00NNs3L+vgZF3gCqQLYYH0BKQHj7T85QfDWw8egJzpp2OnG
 3lLetwA8Jv3PfOJ5YPV9cOygN4zk62FcpowWtwcWT6hyE4SfsGn3sPDFcJtsk31PLLzX
 +7t5xJTcblwQ/Uv7+yLd2Azk1meqifqkzsmgnFWMvFQlet4MGa6bVMBFW59Oc+HesbAD
 +CdklVC+YdQC+zNHEffSMgzaPkJ415+JapwuWc8SZyq/FOkiSdnN6XQWqhci6GTV/JLD
 1qkQtVazh8grYGKAa8GOCYI7ZrVjnoLve5iZgSmgpDLt7GldyuIl9k/v8r9awbazdgz4
 g3PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709688474; x=1710293274;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6OsTV23KsJRIhGwIkzC6YJrm/IPHMCAQ/rP+6aL8H2U=;
 b=qblw5pPcKRv8slGgvzlJJBt7y6N6NqnmoWT9pLgirnIXSeKW0QllcKoqmtUyQI3sn8
 gymBCIJA+QP7K9w3+sjtdzFCj2cgKkMrhArGvXlF8c8/L6sRdAivD21pUGWvrgG0Kyxp
 dN2denTEdG0YpXMTGEwRjPQtA+NlrzbHiZv//UfBJiJBbTAvVGchYutl/6MfpwrZucQb
 W8d9esaqfSvt57bEQBTycZouedEVHMr2he4BcbaWtoIsIZU5PVlwrZSwLkHPB4RJU2Cd
 vddL6nxbdKn3XuRMvYUq/Y0FtP6ALkgjdpnsBww+G2Ck9fbwSWp7dB8ITqmr8m28svVJ
 SxaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWE0BiFpA9Lm5D0HbSk8ykrAcEquWXVsjlfHJjcmlwUYzpx06Be8puSDIAF0HgcrsZPDE+LHMaWxHQXLYJ0g47I3+1O57g=
X-Gm-Message-State: AOJu0Yxqdknt+N0lWBX1rXLRa67tUhM+KXRCo6yFoACrD2D50N5Q7N7l
 0oCRCdKJY5Kc6d5mwL7oMdJ2XIbnegLJGu6g8w2Oq71OxCDUAMUoTMwyYmzwX/HOTDicaqQwUBC
 ztexpzndxZAMsUOc/loDSV92a5nc=
X-Google-Smtp-Source: AGHT+IG/nCbYLTkpbf2QioideshRfUvHVjTzVP9zmONS0pCmmZdg37MM4cMpeUDUGouUeLgofFLBFzxYQtk3+rbWQZw=
X-Received: by 2002:a05:6122:1694:b0:4d3:355f:bc02 with SMTP id
 20-20020a056122169400b004d3355fbc02mr3894763vkl.2.1709688474450; Tue, 05 Mar
 2024 17:27:54 -0800 (PST)
MIME-Version: 1.0
References: <20240221213140.365232-1-dbarboza@ventanamicro.com>
 <20240221213140.365232-4-dbarboza@ventanamicro.com>
In-Reply-To: <20240221213140.365232-4-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 6 Mar 2024 11:27:28 +1000
Message-ID: <CAKmqyKOtWj-=1m0UUu4BNZOb+hN5wBed7084iGo2F-tjSPC6=Q@mail.gmail.com>
Subject: Re: [PATCH v6 3/9] target/riscv: remove 'over' brconds from vector
 trans
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, richard.henderson@linaro.org, max.chou@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a33;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa33.google.com
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

On Thu, Feb 22, 2024 at 7:32=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Most of the vector translations has this following pattern at the start:
>
>     TCGLabel *over =3D gen_new_label();
>     tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
>
> And then right at the end:
>
>      gen_set_label(over);
>      return true;
>
> This means that if vstart >=3D vl we'll not set vstart =3D 0 at the end o=
f
> the insns - this is done inside the helper that is being skipped.  The
> reason why this pattern hasn't been a bigger problem is because the
> conditional vstart >=3D vl is very rare.
>
> Checking all the helpers in vector_helper.c we see all of them with a
> pattern like this:
>
>     for (i =3D env->vstart; i < vl; i++) {
>         (...)
>     }
>     env->vstart =3D 0;
>
> Thus they can handle vstart >=3D vl case gracefully, with the benefit of
> setting env->vstart =3D 0 during the process.
>
> Remove all 'over' conditionals and let the helper set env->vstart =3D 0
> every time.
>
> While we're at it, remove the (vl =3D=3D 0) brconds from trans_rvbf16.c.i=
nc
> too since they're unneeded.
>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/insn_trans/trans_rvbf16.c.inc |  12 ---
>  target/riscv/insn_trans/trans_rvv.c.inc    | 117 ---------------------
>  target/riscv/insn_trans/trans_rvvk.c.inc   |  18 ----
>  3 files changed, 147 deletions(-)
>
> diff --git a/target/riscv/insn_trans/trans_rvbf16.c.inc b/target/riscv/in=
sn_trans/trans_rvbf16.c.inc
> index 8ee99df3f3..a842e76a6b 100644
> --- a/target/riscv/insn_trans/trans_rvbf16.c.inc
> +++ b/target/riscv/insn_trans/trans_rvbf16.c.inc
> @@ -71,11 +71,8 @@ static bool trans_vfncvtbf16_f_f_w(DisasContext *ctx, =
arg_vfncvtbf16_f_f_w *a)
>
>      if (opfv_narrow_check(ctx, a) && (ctx->sew =3D=3D MO_16)) {
>          uint32_t data =3D 0;
> -        TCGLabel *over =3D gen_new_label();
>
>          gen_set_rm_chkfrm(ctx, RISCV_FRM_DYN);
> -        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
> -        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
>
>          data =3D FIELD_DP32(data, VDATA, VM, a->vm);
>          data =3D FIELD_DP32(data, VDATA, LMUL, ctx->lmul);
> @@ -87,7 +84,6 @@ static bool trans_vfncvtbf16_f_f_w(DisasContext *ctx, a=
rg_vfncvtbf16_f_f_w *a)
>                             ctx->cfg_ptr->vlenb, data,
>                             gen_helper_vfncvtbf16_f_f_w);
>          mark_vs_dirty(ctx);
> -        gen_set_label(over);
>          return true;
>      }
>      return false;
> @@ -100,11 +96,8 @@ static bool trans_vfwcvtbf16_f_f_v(DisasContext *ctx,=
 arg_vfwcvtbf16_f_f_v *a)
>
>      if (opfv_widen_check(ctx, a) && (ctx->sew =3D=3D MO_16)) {
>          uint32_t data =3D 0;
> -        TCGLabel *over =3D gen_new_label();
>
>          gen_set_rm_chkfrm(ctx, RISCV_FRM_DYN);
> -        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
> -        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
>
>          data =3D FIELD_DP32(data, VDATA, VM, a->vm);
>          data =3D FIELD_DP32(data, VDATA, LMUL, ctx->lmul);
> @@ -116,7 +109,6 @@ static bool trans_vfwcvtbf16_f_f_v(DisasContext *ctx,=
 arg_vfwcvtbf16_f_f_v *a)
>                             ctx->cfg_ptr->vlenb, data,
>                             gen_helper_vfwcvtbf16_f_f_v);
>          mark_vs_dirty(ctx);
> -        gen_set_label(over);
>          return true;
>      }
>      return false;
> @@ -130,11 +122,8 @@ static bool trans_vfwmaccbf16_vv(DisasContext *ctx, =
arg_vfwmaccbf16_vv *a)
>      if (require_rvv(ctx) && vext_check_isa_ill(ctx) && (ctx->sew =3D=3D =
MO_16) &&
>          vext_check_dss(ctx, a->rd, a->rs1, a->rs2, a->vm)) {
>          uint32_t data =3D 0;
> -        TCGLabel *over =3D gen_new_label();
>
>          gen_set_rm_chkfrm(ctx, RISCV_FRM_DYN);
> -        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
> -        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
>
>          data =3D FIELD_DP32(data, VDATA, VM, a->vm);
>          data =3D FIELD_DP32(data, VDATA, LMUL, ctx->lmul);
> @@ -147,7 +136,6 @@ static bool trans_vfwmaccbf16_vv(DisasContext *ctx, a=
rg_vfwmaccbf16_vv *a)
>                             ctx->cfg_ptr->vlenb, data,
>                             gen_helper_vfwmaccbf16_vv);
>          mark_vs_dirty(ctx);
> -        gen_set_label(over);
>          return true;
>      }
>      return false;
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_=
trans/trans_rvv.c.inc
> index 15ccebf3fc..58299d9bb8 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -615,9 +615,6 @@ static bool ldst_us_trans(uint32_t vd, uint32_t rs1, =
uint32_t data,
>      TCGv base;
>      TCGv_i32 desc;
>
> -    TCGLabel *over =3D gen_new_label();
> -    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
> -
>      dest =3D tcg_temp_new_ptr();
>      mask =3D tcg_temp_new_ptr();
>      base =3D get_gpr(s, rs1, EXT_NONE);
> @@ -639,7 +636,6 @@ static bool ldst_us_trans(uint32_t vd, uint32_t rs1, =
uint32_t data,
>
>      fn(dest, mask, base, tcg_env, desc);
>
> -    gen_set_label(over);
>      return true;
>  }
>
> @@ -781,9 +777,6 @@ static bool ldst_stride_trans(uint32_t vd, uint32_t r=
s1, uint32_t rs2,
>      TCGv base, stride;
>      TCGv_i32 desc;
>
> -    TCGLabel *over =3D gen_new_label();
> -    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
> -
>      dest =3D tcg_temp_new_ptr();
>      mask =3D tcg_temp_new_ptr();
>      base =3D get_gpr(s, rs1, EXT_NONE);
> @@ -798,7 +791,6 @@ static bool ldst_stride_trans(uint32_t vd, uint32_t r=
s1, uint32_t rs2,
>
>      fn(dest, mask, base, stride, tcg_env, desc);
>
> -    gen_set_label(over);
>      return true;
>  }
>
> @@ -885,9 +877,6 @@ static bool ldst_index_trans(uint32_t vd, uint32_t rs=
1, uint32_t vs2,
>      TCGv base;
>      TCGv_i32 desc;
>
> -    TCGLabel *over =3D gen_new_label();
> -    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
> -
>      dest =3D tcg_temp_new_ptr();
>      mask =3D tcg_temp_new_ptr();
>      index =3D tcg_temp_new_ptr();
> @@ -903,7 +892,6 @@ static bool ldst_index_trans(uint32_t vd, uint32_t rs=
1, uint32_t vs2,
>
>      fn(dest, mask, base, index, tcg_env, desc);
>
> -    gen_set_label(over);
>      return true;
>  }
>
> @@ -1023,9 +1011,6 @@ static bool ldff_trans(uint32_t vd, uint32_t rs1, u=
int32_t data,
>      TCGv base;
>      TCGv_i32 desc;
>
> -    TCGLabel *over =3D gen_new_label();
> -    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
> -
>      dest =3D tcg_temp_new_ptr();
>      mask =3D tcg_temp_new_ptr();
>      base =3D get_gpr(s, rs1, EXT_NONE);
> @@ -1038,7 +1023,6 @@ static bool ldff_trans(uint32_t vd, uint32_t rs1, u=
int32_t data,
>      fn(dest, mask, base, tcg_env, desc);
>
>      mark_vs_dirty(s);
> -    gen_set_label(over);
>      return true;
>  }
>
> @@ -1079,10 +1063,6 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t=
 rs1, uint32_t nf,
>                               uint32_t width, gen_helper_ldst_whole *fn,
>                               DisasContext *s)
>  {
> -    uint32_t evl =3D s->cfg_ptr->vlenb * nf / width;
> -    TCGLabel *over =3D gen_new_label();
> -    tcg_gen_brcondi_tl(TCG_COND_GEU, cpu_vstart, evl, over);
> -
>      TCGv_ptr dest;
>      TCGv base;
>      TCGv_i32 desc;
> @@ -1099,8 +1079,6 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t =
rs1, uint32_t nf,
>
>      fn(dest, base, tcg_env, desc);
>
> -    gen_set_label(over);
> -
>      return true;
>  }
>
> @@ -1174,10 +1152,6 @@ static inline bool
>  do_opivv_gvec(DisasContext *s, arg_rmrr *a, GVecGen3Fn *gvec_fn,
>                gen_helper_gvec_4_ptr *fn)
>  {
> -    TCGLabel *over =3D gen_new_label();
> -
> -    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
> -
>      if (a->vm && s->vl_eq_vlmax && !(s->vta && s->lmul < 0)) {
>          gvec_fn(s->sew, vreg_ofs(s, a->rd),
>                  vreg_ofs(s, a->rs2), vreg_ofs(s, a->rs1),
> @@ -1195,7 +1169,6 @@ do_opivv_gvec(DisasContext *s, arg_rmrr *a, GVecGen=
3Fn *gvec_fn,
>                             s->cfg_ptr->vlenb, data, fn);
>      }
>      mark_vs_dirty(s);
> -    gen_set_label(over);
>      return true;
>  }
>
> @@ -1227,9 +1200,6 @@ static bool opivx_trans(uint32_t vd, uint32_t rs1, =
uint32_t vs2, uint32_t vm,
>      TCGv_i32 desc;
>      uint32_t data =3D 0;
>
> -    TCGLabel *over =3D gen_new_label();
> -    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
> -
>      dest =3D tcg_temp_new_ptr();
>      mask =3D tcg_temp_new_ptr();
>      src2 =3D tcg_temp_new_ptr();
> @@ -1250,7 +1220,6 @@ static bool opivx_trans(uint32_t vd, uint32_t rs1, =
uint32_t vs2, uint32_t vm,
>      fn(dest, mask, src1, src2, tcg_env, desc);
>
>      mark_vs_dirty(s);
> -    gen_set_label(over);
>      return true;
>  }
>
> @@ -1389,9 +1358,6 @@ static bool opivi_trans(uint32_t vd, uint32_t imm, =
uint32_t vs2, uint32_t vm,
>      TCGv_i32 desc;
>      uint32_t data =3D 0;
>
> -    TCGLabel *over =3D gen_new_label();
> -    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
> -
>      dest =3D tcg_temp_new_ptr();
>      mask =3D tcg_temp_new_ptr();
>      src2 =3D tcg_temp_new_ptr();
> @@ -1412,7 +1378,6 @@ static bool opivi_trans(uint32_t vd, uint32_t imm, =
uint32_t vs2, uint32_t vm,
>      fn(dest, mask, src1, src2, tcg_env, desc);
>
>      mark_vs_dirty(s);
> -    gen_set_label(over);
>      return true;
>  }
>
> @@ -1474,8 +1439,6 @@ static bool do_opivv_widen(DisasContext *s, arg_rmr=
r *a,
>  {
>      if (checkfn(s, a)) {
>          uint32_t data =3D 0;
> -        TCGLabel *over =3D gen_new_label();
> -        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
>
>          data =3D FIELD_DP32(data, VDATA, VM, a->vm);
>          data =3D FIELD_DP32(data, VDATA, LMUL, s->lmul);
> @@ -1488,7 +1451,6 @@ static bool do_opivv_widen(DisasContext *s, arg_rmr=
r *a,
>                             s->cfg_ptr->vlenb,
>                             data, fn);
>          mark_vs_dirty(s);
> -        gen_set_label(over);
>          return true;
>      }
>      return false;
> @@ -1550,8 +1512,6 @@ static bool do_opiwv_widen(DisasContext *s, arg_rmr=
r *a,
>  {
>      if (opiwv_widen_check(s, a)) {
>          uint32_t data =3D 0;
> -        TCGLabel *over =3D gen_new_label();
> -        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
>
>          data =3D FIELD_DP32(data, VDATA, VM, a->vm);
>          data =3D FIELD_DP32(data, VDATA, LMUL, s->lmul);
> @@ -1563,7 +1523,6 @@ static bool do_opiwv_widen(DisasContext *s, arg_rmr=
r *a,
>                             tcg_env, s->cfg_ptr->vlenb,
>                             s->cfg_ptr->vlenb, data, fn);
>          mark_vs_dirty(s);
> -        gen_set_label(over);
>          return true;
>      }
>      return false;
> @@ -1622,8 +1581,6 @@ static bool opivv_trans(uint32_t vd, uint32_t vs1, =
uint32_t vs2, uint32_t vm,
>                          gen_helper_gvec_4_ptr *fn, DisasContext *s)
>  {
>      uint32_t data =3D 0;
> -    TCGLabel *over =3D gen_new_label();
> -    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
>
>      data =3D FIELD_DP32(data, VDATA, VM, vm);
>      data =3D FIELD_DP32(data, VDATA, LMUL, s->lmul);
> @@ -1634,7 +1591,6 @@ static bool opivv_trans(uint32_t vd, uint32_t vs1, =
uint32_t vs2, uint32_t vm,
>                         vreg_ofs(s, vs2), tcg_env, s->cfg_ptr->vlenb,
>                         s->cfg_ptr->vlenb, data, fn);
>      mark_vs_dirty(s);
> -    gen_set_label(over);
>      return true;
>  }
>
> @@ -1813,8 +1769,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr =
*a)             \
>              gen_helper_##NAME##_h,                                 \
>              gen_helper_##NAME##_w,                                 \
>          };                                                         \
> -        TCGLabel *over =3D gen_new_label();                          \
> -        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over); \
>                                                                     \
>          data =3D FIELD_DP32(data, VDATA, VM, a->vm);                 \
>          data =3D FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
> @@ -1827,7 +1781,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr =
*a)             \
>                             s->cfg_ptr->vlenb, data,                \
>                             fns[s->sew]);                           \
>          mark_vs_dirty(s);                                          \
> -        gen_set_label(over);                                       \
>          return true;                                               \
>      }                                                              \
>      return false;                                                  \
> @@ -2024,14 +1977,11 @@ static bool trans_vmv_v_v(DisasContext *s, arg_vm=
v_v_v *a)
>                  gen_helper_vmv_v_v_b, gen_helper_vmv_v_v_h,
>                  gen_helper_vmv_v_v_w, gen_helper_vmv_v_v_d,
>              };
> -            TCGLabel *over =3D gen_new_label();
> -            tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
>
>              tcg_gen_gvec_2_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, a->rs1),
>                                 tcg_env, s->cfg_ptr->vlenb,
>                                 s->cfg_ptr->vlenb, data,
>                                 fns[s->sew]);
> -            gen_set_label(over);
>          }
>          mark_vs_dirty(s);
>          return true;
> @@ -2047,8 +1997,6 @@ static bool trans_vmv_v_x(DisasContext *s, arg_vmv_=
v_x *a)
>          /* vmv.v.x has rs2 =3D 0 and vm =3D 1 */
>          vext_check_ss(s, a->rd, 0, 1)) {
>          TCGv s1;
> -        TCGLabel *over =3D gen_new_label();
> -        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
>
>          s1 =3D get_gpr(s, a->rs1, EXT_SIGN);
>
> @@ -2081,7 +2029,6 @@ static bool trans_vmv_v_x(DisasContext *s, arg_vmv_=
v_x *a)
>          }
>
>          mark_vs_dirty(s);
> -        gen_set_label(over);
>          return true;
>      }
>      return false;
> @@ -2108,8 +2055,6 @@ static bool trans_vmv_v_i(DisasContext *s, arg_vmv_=
v_i *a)
>                  gen_helper_vmv_v_x_b, gen_helper_vmv_v_x_h,
>                  gen_helper_vmv_v_x_w, gen_helper_vmv_v_x_d,
>              };
> -            TCGLabel *over =3D gen_new_label();
> -            tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
>
>              s1 =3D tcg_constant_i64(simm);
>              dest =3D tcg_temp_new_ptr();
> @@ -2119,7 +2064,6 @@ static bool trans_vmv_v_i(DisasContext *s, arg_vmv_=
v_i *a)
>              fns[s->sew](dest, s1, tcg_env, desc);
>
>              mark_vs_dirty(s);
> -            gen_set_label(over);
>          }
>          return true;
>      }
> @@ -2254,9 +2198,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr =
*a)             \
>              gen_helper_##NAME##_w,                                 \
>              gen_helper_##NAME##_d,                                 \
>          };                                                         \
> -        TCGLabel *over =3D gen_new_label();                          \
>          gen_set_rm(s, RISCV_FRM_DYN);                              \
> -        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over); \
>                                                                     \
>          data =3D FIELD_DP32(data, VDATA, VM, a->vm);                 \
>          data =3D FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
> @@ -2271,7 +2213,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr =
*a)             \
>                             s->cfg_ptr->vlenb, data,                \
>                             fns[s->sew - 1]);                       \
>          mark_vs_dirty(s);                                          \
> -        gen_set_label(over);                                       \
>          return true;                                               \
>      }                                                              \
>      return false;                                                  \
> @@ -2289,9 +2230,6 @@ static bool opfvf_trans(uint32_t vd, uint32_t rs1, =
uint32_t vs2,
>      TCGv_i32 desc;
>      TCGv_i64 t1;
>
> -    TCGLabel *over =3D gen_new_label();
> -    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
> -
>      dest =3D tcg_temp_new_ptr();
>      mask =3D tcg_temp_new_ptr();
>      src2 =3D tcg_temp_new_ptr();
> @@ -2309,7 +2247,6 @@ static bool opfvf_trans(uint32_t vd, uint32_t rs1, =
uint32_t vs2,
>      fn(dest, mask, t1, src2, tcg_env, desc);
>
>      mark_vs_dirty(s);
> -    gen_set_label(over);
>      return true;
>  }
>
> @@ -2372,9 +2309,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr =
*a)           \
>          static gen_helper_gvec_4_ptr * const fns[2] =3D {          \
>              gen_helper_##NAME##_h, gen_helper_##NAME##_w,        \
>          };                                                       \
> -        TCGLabel *over =3D gen_new_label();                        \
>          gen_set_rm(s, RISCV_FRM_DYN);                            \
> -        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);\
>                                                                   \
>          data =3D FIELD_DP32(data, VDATA, VM, a->vm);               \
>          data =3D FIELD_DP32(data, VDATA, LMUL, s->lmul);           \
> @@ -2387,7 +2322,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr =
*a)           \
>                             s->cfg_ptr->vlenb, data,              \
>                             fns[s->sew - 1]);                     \
>          mark_vs_dirty(s);                                        \
> -        gen_set_label(over);                                     \
>          return true;                                             \
>      }                                                            \
>      return false;                                                \
> @@ -2446,9 +2380,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr =
*a)             \
>          static gen_helper_gvec_4_ptr * const fns[2] =3D {            \
>              gen_helper_##NAME##_h, gen_helper_##NAME##_w,          \
>          };                                                         \
> -        TCGLabel *over =3D gen_new_label();                          \
>          gen_set_rm(s, RISCV_FRM_DYN);                              \
> -        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over); \
>                                                                     \
>          data =3D FIELD_DP32(data, VDATA, VM, a->vm);                 \
>          data =3D FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
> @@ -2461,7 +2393,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr =
*a)             \
>                             s->cfg_ptr->vlenb, data,                \
>                             fns[s->sew - 1]);                       \
>          mark_vs_dirty(s);                                          \
> -        gen_set_label(over);                                       \
>          return true;                                               \
>      }                                                              \
>      return false;                                                  \
> @@ -2563,9 +2494,7 @@ static bool do_opfv(DisasContext *s, arg_rmr *a,
>  {
>      if (checkfn(s, a)) {
>          uint32_t data =3D 0;
> -        TCGLabel *over =3D gen_new_label();
>          gen_set_rm_chkfrm(s, rm);
> -        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
>
>          data =3D FIELD_DP32(data, VDATA, VM, a->vm);
>          data =3D FIELD_DP32(data, VDATA, LMUL, s->lmul);
> @@ -2576,7 +2505,6 @@ static bool do_opfv(DisasContext *s, arg_rmr *a,
>                             s->cfg_ptr->vlenb,
>                             s->cfg_ptr->vlenb, data, fn);
>          mark_vs_dirty(s);
> -        gen_set_label(over);
>          return true;
>      }
>      return false;
> @@ -2675,8 +2603,6 @@ static bool trans_vfmv_v_f(DisasContext *s, arg_vfm=
v_v_f *a)
>                  gen_helper_vmv_v_x_w,
>                  gen_helper_vmv_v_x_d,
>              };
> -            TCGLabel *over =3D gen_new_label();
> -            tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
>
>              t1 =3D tcg_temp_new_i64();
>              /* NaN-box f[rs1] */
> @@ -2690,7 +2616,6 @@ static bool trans_vfmv_v_f(DisasContext *s, arg_vfm=
v_v_f *a)
>              fns[s->sew - 1](dest, t1, tcg_env, desc);
>
>              mark_vs_dirty(s);
> -            gen_set_label(over);
>          }
>          return true;
>      }
> @@ -2752,9 +2677,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *=
a)              \
>              gen_helper_##HELPER##_h,                               \
>              gen_helper_##HELPER##_w,                               \
>          };                                                         \
> -        TCGLabel *over =3D gen_new_label();                          \
>          gen_set_rm_chkfrm(s, FRM);                                 \
> -        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over); \
>                                                                     \
>          data =3D FIELD_DP32(data, VDATA, VM, a->vm);                 \
>          data =3D FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
> @@ -2766,7 +2689,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *=
a)              \
>                             s->cfg_ptr->vlenb, data,                \
>                             fns[s->sew - 1]);                       \
>          mark_vs_dirty(s);                                          \
> -        gen_set_label(over);                                       \
>          return true;                                               \
>      }                                                              \
>      return false;                                                  \
> @@ -2803,9 +2725,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *=
a)              \
>              gen_helper_##NAME##_h,                                 \
>              gen_helper_##NAME##_w,                                 \
>          };                                                         \
> -        TCGLabel *over =3D gen_new_label();                          \
>          gen_set_rm(s, RISCV_FRM_DYN);                              \
> -        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over); \
>                                                                     \
>          data =3D FIELD_DP32(data, VDATA, VM, a->vm);                 \
>          data =3D FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
> @@ -2817,7 +2737,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *=
a)              \
>                             s->cfg_ptr->vlenb, data,                \
>                             fns[s->sew]);                           \
>          mark_vs_dirty(s);                                          \
> -        gen_set_label(over);                                       \
>          return true;                                               \
>      }                                                              \
>      return false;                                                  \
> @@ -2870,9 +2789,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *=
a)              \
>              gen_helper_##HELPER##_h,                               \
>              gen_helper_##HELPER##_w,                               \
>          };                                                         \
> -        TCGLabel *over =3D gen_new_label();                          \
>          gen_set_rm_chkfrm(s, FRM);                                 \
> -        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over); \
>                                                                     \
>          data =3D FIELD_DP32(data, VDATA, VM, a->vm);                 \
>          data =3D FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
> @@ -2884,7 +2801,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *=
a)              \
>                             s->cfg_ptr->vlenb, data,                \
>                             fns[s->sew - 1]);                       \
>          mark_vs_dirty(s);                                          \
> -        gen_set_label(over);                                       \
>          return true;                                               \
>      }                                                              \
>      return false;                                                  \
> @@ -2919,9 +2835,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *=
a)              \
>              gen_helper_##HELPER##_h,                               \
>              gen_helper_##HELPER##_w,                               \
>          };                                                         \
> -        TCGLabel *over =3D gen_new_label();                          \
>          gen_set_rm_chkfrm(s, FRM);                                 \
> -        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over); \
>                                                                     \
>          data =3D FIELD_DP32(data, VDATA, VM, a->vm);                 \
>          data =3D FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
> @@ -2933,7 +2847,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *=
a)              \
>                             s->cfg_ptr->vlenb, data,                \
>                             fns[s->sew]);                           \
>          mark_vs_dirty(s);                                          \
> -        gen_set_label(over);                                       \
>          return true;                                               \
>      }                                                              \
>      return false;                                                  \
> @@ -3010,8 +2923,6 @@ static bool trans_##NAME(DisasContext *s, arg_r *a)=
                \
>          vext_check_isa_ill(s)) {                                   \
>          uint32_t data =3D 0;                                         \
>          gen_helper_gvec_4_ptr *fn =3D gen_helper_##NAME;             \
> -        TCGLabel *over =3D gen_new_label();                          \
> -        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over); \
>                                                                     \
>          data =3D FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
>          data =3D                                                     \
> @@ -3022,7 +2933,6 @@ static bool trans_##NAME(DisasContext *s, arg_r *a)=
                \
>                             s->cfg_ptr->vlenb,                      \
>                             s->cfg_ptr->vlenb, data, fn);           \
>          mark_vs_dirty(s);                                          \
> -        gen_set_label(over);                                       \
>          return true;                                               \
>      }                                                              \
>      return false;                                                  \
> @@ -3110,8 +3020,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *=
a)              \
>          s->vstart_eq_zero) {                                       \
>          uint32_t data =3D 0;                                         \
>          gen_helper_gvec_3_ptr *fn =3D gen_helper_##NAME;             \
> -        TCGLabel *over =3D gen_new_label();                          \
> -        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);          \
>                                                                     \
>          data =3D FIELD_DP32(data, VDATA, VM, a->vm);                 \
>          data =3D FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
> @@ -3124,7 +3032,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *=
a)              \
>                             s->cfg_ptr->vlenb,                      \
>                             data, fn);                              \
>          mark_vs_dirty(s);                                          \
> -        gen_set_label(over);                                       \
>          return true;                                               \
>      }                                                              \
>      return false;                                                  \
> @@ -3150,8 +3057,6 @@ static bool trans_viota_m(DisasContext *s, arg_viot=
a_m *a)
>          require_align(a->rd, s->lmul) &&
>          s->vstart_eq_zero) {
>          uint32_t data =3D 0;
> -        TCGLabel *over =3D gen_new_label();
> -        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
>
>          data =3D FIELD_DP32(data, VDATA, VM, a->vm);
>          data =3D FIELD_DP32(data, VDATA, LMUL, s->lmul);
> @@ -3166,7 +3071,6 @@ static bool trans_viota_m(DisasContext *s, arg_viot=
a_m *a)
>                             s->cfg_ptr->vlenb,
>                             s->cfg_ptr->vlenb, data, fns[s->sew]);
>          mark_vs_dirty(s);
> -        gen_set_label(over);
>          return true;
>      }
>      return false;
> @@ -3180,8 +3084,6 @@ static bool trans_vid_v(DisasContext *s, arg_vid_v =
*a)
>          require_align(a->rd, s->lmul) &&
>          require_vm(a->vm, a->rd)) {
>          uint32_t data =3D 0;
> -        TCGLabel *over =3D gen_new_label();
> -        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
>
>          data =3D FIELD_DP32(data, VDATA, VM, a->vm);
>          data =3D FIELD_DP32(data, VDATA, LMUL, s->lmul);
> @@ -3196,7 +3098,6 @@ static bool trans_vid_v(DisasContext *s, arg_vid_v =
*a)
>                             s->cfg_ptr->vlenb,
>                             data, fns[s->sew]);
>          mark_vs_dirty(s);
> -        gen_set_label(over);
>          return true;
>      }
>      return false;
> @@ -3365,9 +3266,6 @@ static bool trans_vmv_s_x(DisasContext *s, arg_vmv_=
s_x *a)
>          /* This instruction ignores LMUL and vector register groups */
>          TCGv_i64 t1;
>          TCGv s1;
> -        TCGLabel *over =3D gen_new_label();
> -
> -        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
>
>          t1 =3D tcg_temp_new_i64();
>
> @@ -3379,7 +3277,6 @@ static bool trans_vmv_s_x(DisasContext *s, arg_vmv_=
s_x *a)
>          tcg_gen_ext_tl_i64(t1, s1);
>          vec_element_storei(s, a->rd, 0, t1);
>          mark_vs_dirty(s);
> -        gen_set_label(over);
>          return true;
>      }
>      return false;
> @@ -3421,10 +3318,6 @@ static bool trans_vfmv_s_f(DisasContext *s, arg_vf=
mv_s_f *a)
>
>          /* The instructions ignore LMUL and vector register group. */
>          TCGv_i64 t1;
> -        TCGLabel *over =3D gen_new_label();
> -
> -        /* if vstart >=3D vl, skip vector register write back */
> -        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
>
>          /* NaN-box f[rs1] */
>          t1 =3D tcg_temp_new_i64();
> @@ -3432,7 +3325,6 @@ static bool trans_vfmv_s_f(DisasContext *s, arg_vfm=
v_s_f *a)
>
>          vec_element_storei(s, a->rd, 0, t1);
>          mark_vs_dirty(s);
> -        gen_set_label(over);
>          return true;
>      }
>      return false;
> @@ -3603,8 +3495,6 @@ static bool trans_vcompress_vm(DisasContext *s, arg=
_r *a)
>              gen_helper_vcompress_vm_b, gen_helper_vcompress_vm_h,
>              gen_helper_vcompress_vm_w, gen_helper_vcompress_vm_d,
>          };
> -        TCGLabel *over =3D gen_new_label();
> -        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
>
>          data =3D FIELD_DP32(data, VDATA, LMUL, s->lmul);
>          data =3D FIELD_DP32(data, VDATA, VTA, s->vta);
> @@ -3614,7 +3504,6 @@ static bool trans_vcompress_vm(DisasContext *s, arg=
_r *a)
>                             s->cfg_ptr->vlenb, data,
>                             fns[s->sew]);
>          mark_vs_dirty(s);
> -        gen_set_label(over);
>          return true;
>      }
>      return false;
> @@ -3637,12 +3526,9 @@ static bool trans_##NAME(DisasContext *s, arg_##NA=
ME * a)               \
>                               vreg_ofs(s, a->rs2), maxsz, maxsz);        =
\
>              mark_vs_dirty(s);                                           =
\
>          } else {                                                        =
\
> -            TCGLabel *over =3D gen_new_label();                         =
  \
> -            tcg_gen_brcondi_tl(TCG_COND_GEU, cpu_vstart, maxsz, over);  =
\
>              tcg_gen_gvec_2_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, a->rs2), =
\
>                                 tcg_env, maxsz, maxsz, 0, gen_helper_vmvr=
_v); \
>              mark_vs_dirty(s);                                           =
\
> -            gen_set_label(over);                                        =
\
>          }                                                               =
\
>          return true;                                                    =
\
>      }                                                                   =
\
> @@ -3671,8 +3557,6 @@ static bool int_ext_op(DisasContext *s, arg_rmr *a,=
 uint8_t seq)
>  {
>      uint32_t data =3D 0;
>      gen_helper_gvec_3_ptr *fn;
> -    TCGLabel *over =3D gen_new_label();
> -    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
>
>      static gen_helper_gvec_3_ptr * const fns[6][4] =3D {
>          {
> @@ -3717,7 +3601,6 @@ static bool int_ext_op(DisasContext *s, arg_rmr *a,=
 uint8_t seq)
>                         s->cfg_ptr->vlenb, data, fn);
>
>      mark_vs_dirty(s);
> -    gen_set_label(over);
>      return true;
>  }
>
> diff --git a/target/riscv/insn_trans/trans_rvvk.c.inc b/target/riscv/insn=
_trans/trans_rvvk.c.inc
> index a5cdd1b67f..6d640e4596 100644
> --- a/target/riscv/insn_trans/trans_rvvk.c.inc
> +++ b/target/riscv/insn_trans/trans_rvvk.c.inc
> @@ -164,8 +164,6 @@ GEN_OPIVX_GVEC_TRANS_CHECK(vandn_vx, andcs, zvkb_vx_c=
heck)
>                  gen_helper_##NAME##_w,                                  =
   \
>                  gen_helper_##NAME##_d,                                  =
   \
>              };                                                          =
   \
> -            TCGLabel *over =3D gen_new_label();                         =
     \
> -            tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);  =
   \
>                                                                          =
   \
>              data =3D FIELD_DP32(data, VDATA, VM, a->vm);                =
     \
>              data =3D FIELD_DP32(data, VDATA, LMUL, s->lmul);            =
     \
> @@ -177,7 +175,6 @@ GEN_OPIVX_GVEC_TRANS_CHECK(vandn_vx, andcs, zvkb_vx_c=
heck)
>                                 s->cfg_ptr->vlenb, s->cfg_ptr->vlenb,    =
   \
>                                 data, fns[s->sew]);                      =
   \
>              mark_vs_dirty(s);                                           =
   \
> -            gen_set_label(over);                                        =
   \
>              return true;                                                =
   \
>          }                                                               =
   \
>          return false;                                                   =
   \
> @@ -249,14 +246,12 @@ GEN_OPIVI_WIDEN_TRANS(vwsll_vi, IMM_ZX, vwsll_vx, v=
wsll_vx_check)
>              TCGv_ptr rd_v, rs2_v;                                       =
      \
>              TCGv_i32 desc, egs;                                         =
      \
>              uint32_t data =3D 0;                                        =
        \
> -            TCGLabel *over =3D gen_new_label();                         =
        \
>                                                                          =
      \
>              if (!s->vstart_eq_zero || !s->vl_eq_vlmax) {                =
      \
>                  /* save opcode for unwinding in case we throw an excepti=
on */ \
>                  decode_save_opc(s);                                     =
      \
>                  egs =3D tcg_constant_i32(EGS);                          =
        \
>                  gen_helper_egs_check(egs, tcg_env);                     =
      \
> -                tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over=
);    \
>              }                                                           =
      \
>                                                                          =
      \
>              data =3D FIELD_DP32(data, VDATA, VM, a->vm);                =
        \
> @@ -272,7 +267,6 @@ GEN_OPIVI_WIDEN_TRANS(vwsll_vi, IMM_ZX, vwsll_vx, vws=
ll_vx_check)
>              tcg_gen_addi_ptr(rs2_v, tcg_env, vreg_ofs(s, a->rs2));      =
      \
>              gen_helper_##NAME(rd_v, rs2_v, tcg_env, desc);              =
      \
>              mark_vs_dirty(s);                                           =
      \
> -            gen_set_label(over);                                        =
      \
>              return true;                                                =
      \
>          }                                                               =
      \
>          return false;                                                   =
      \
> @@ -325,14 +319,12 @@ GEN_V_UNMASKED_TRANS(vaesem_vs, vaes_check_vs, ZVKN=
ED_EGS)
>              TCGv_ptr rd_v, rs2_v;                                       =
      \
>              TCGv_i32 uimm_v, desc, egs;                                 =
      \
>              uint32_t data =3D 0;                                        =
        \
> -            TCGLabel *over =3D gen_new_label();                         =
        \
>                                                                          =
      \
>              if (!s->vstart_eq_zero || !s->vl_eq_vlmax) {                =
      \
>                  /* save opcode for unwinding in case we throw an excepti=
on */ \
>                  decode_save_opc(s);                                     =
      \
>                  egs =3D tcg_constant_i32(EGS);                          =
        \
>                  gen_helper_egs_check(egs, tcg_env);                     =
      \
> -                tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over=
);    \
>              }                                                           =
      \
>                                                                          =
      \
>              data =3D FIELD_DP32(data, VDATA, VM, a->vm);                =
        \
> @@ -350,7 +342,6 @@ GEN_V_UNMASKED_TRANS(vaesem_vs, vaes_check_vs, ZVKNED=
_EGS)
>              tcg_gen_addi_ptr(rs2_v, tcg_env, vreg_ofs(s, a->rs2));      =
      \
>              gen_helper_##NAME(rd_v, rs2_v, uimm_v, tcg_env, desc);      =
      \
>              mark_vs_dirty(s);                                           =
      \
> -            gen_set_label(over);                                        =
      \
>              return true;                                                =
      \
>          }                                                               =
      \
>          return false;                                                   =
      \
> @@ -394,7 +385,6 @@ GEN_VI_UNMASKED_TRANS(vaeskf2_vi, vaeskf2_check, ZVKN=
ED_EGS)
>      {                                                                   =
      \
>          if (CHECK(s, a)) {                                              =
      \
>              uint32_t data =3D 0;                                        =
        \
> -            TCGLabel *over =3D gen_new_label();                         =
        \
>              TCGv_i32 egs;                                               =
      \
>                                                                          =
      \
>              if (!s->vstart_eq_zero || !s->vl_eq_vlmax) {                =
      \
> @@ -402,7 +392,6 @@ GEN_VI_UNMASKED_TRANS(vaeskf2_vi, vaeskf2_check, ZVKN=
ED_EGS)
>                  decode_save_opc(s);                                     =
      \
>                  egs =3D tcg_constant_i32(EGS);                          =
        \
>                  gen_helper_egs_check(egs, tcg_env);                     =
      \
> -                tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over=
);    \
>              }                                                           =
      \
>                                                                          =
      \
>              data =3D FIELD_DP32(data, VDATA, VM, a->vm);                =
        \
> @@ -417,7 +406,6 @@ GEN_VI_UNMASKED_TRANS(vaeskf2_vi, vaeskf2_check, ZVKN=
ED_EGS)
>                                 data, gen_helper_##NAME);                =
      \
>                                                                          =
      \
>              mark_vs_dirty(s);                                           =
      \
> -            gen_set_label(over);                                        =
      \
>              return true;                                                =
      \
>          }                                                               =
      \
>          return false;                                                   =
      \
> @@ -448,7 +436,6 @@ static bool trans_vsha2cl_vv(DisasContext *s, arg_rmr=
r *a)
>  {
>      if (vsha_check(s, a)) {
>          uint32_t data =3D 0;
> -        TCGLabel *over =3D gen_new_label();
>          TCGv_i32 egs;
>
>          if (!s->vstart_eq_zero || !s->vl_eq_vlmax) {
> @@ -456,7 +443,6 @@ static bool trans_vsha2cl_vv(DisasContext *s, arg_rmr=
r *a)
>              decode_save_opc(s);
>              egs =3D tcg_constant_i32(ZVKNH_EGS);
>              gen_helper_egs_check(egs, tcg_env);
> -            tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
>          }
>
>          data =3D FIELD_DP32(data, VDATA, VM, a->vm);
> @@ -472,7 +458,6 @@ static bool trans_vsha2cl_vv(DisasContext *s, arg_rmr=
r *a)
>                  gen_helper_vsha2cl32_vv : gen_helper_vsha2cl64_vv);
>
>          mark_vs_dirty(s);
> -        gen_set_label(over);
>          return true;
>      }
>      return false;
> @@ -482,7 +467,6 @@ static bool trans_vsha2ch_vv(DisasContext *s, arg_rmr=
r *a)
>  {
>      if (vsha_check(s, a)) {
>          uint32_t data =3D 0;
> -        TCGLabel *over =3D gen_new_label();
>          TCGv_i32 egs;
>
>          if (!s->vstart_eq_zero || !s->vl_eq_vlmax) {
> @@ -490,7 +474,6 @@ static bool trans_vsha2ch_vv(DisasContext *s, arg_rmr=
r *a)
>              decode_save_opc(s);
>              egs =3D tcg_constant_i32(ZVKNH_EGS);
>              gen_helper_egs_check(egs, tcg_env);
> -            tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
>          }
>
>          data =3D FIELD_DP32(data, VDATA, VM, a->vm);
> @@ -506,7 +489,6 @@ static bool trans_vsha2ch_vv(DisasContext *s, arg_rmr=
r *a)
>                  gen_helper_vsha2ch32_vv : gen_helper_vsha2ch64_vv);
>
>          mark_vs_dirty(s);
> -        gen_set_label(over);
>          return true;
>      }
>      return false;
> --
> 2.43.2
>
>

