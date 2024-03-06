Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67EA8C54798
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 01:26:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhg2M-0000ZZ-1C; Tue, 05 Mar 2024 20:25:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rhg2I-0000Z7-PZ; Tue, 05 Mar 2024 20:25:34 -0500
Received: from mail-vs1-xe36.google.com ([2607:f8b0:4864:20::e36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rhg2G-0002kd-Dk; Tue, 05 Mar 2024 20:25:34 -0500
Received: by mail-vs1-xe36.google.com with SMTP id
 ada2fe7eead31-47288b46f2fso1383688137.3; 
 Tue, 05 Mar 2024 17:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709688331; x=1710293131; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jziyd3eUcC30BDVvtj2rkbvUs4y6y4cQNHQkk1V9bPk=;
 b=D8TxErA63tNUb2GhGF53QQcg2qkVXXdiufHBIqxZ8olUTaxCYsVzdCTvYZ4Ntn4Am1
 afz9o7KmPrXH19J0Sp5V/UyUx5EqIl58ugr/7dGLOVi0oXfgJRkmsjEftpE5D2vSu7ud
 ysh2tmzvv6HEjDuKMP2ndaJgat5hydhtcaY6lz0YO0+PW12/UQwmN9pm/h2Wo20KMATB
 0rRgP76K5VGzDcIYUtGwB70lpeuU+Zse+TPyKjY1cnkB6EUCt53O1XcEqWtqRyjSTPUK
 GFn+mwJpbKiW65hXhtXySEEafg/6Ap0UZz2xKsevs5RMjC8s+TGlkYEkW39yIlj/TDYU
 6lnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709688331; x=1710293131;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jziyd3eUcC30BDVvtj2rkbvUs4y6y4cQNHQkk1V9bPk=;
 b=IMmLzBSDjIUz+e9ZR95wKFb42c4JahSNJst1VselUh483BfqHXyhf+9pPQhU0/YrcC
 gmzgMKXodQHZ6+uYY9kY92W/BMGnPzuhJKpqznK5cbLDOJKu9qIEwWh0qkEtOBYO48QJ
 2r4kUxqzOC3832GDZBzO0ZbW49TYIQqxQbYIISyV9/VwI6zSdy505PLiAHjnzHexS1hK
 H0AGDXMw/eLPIov4P0jLHC/NTvfZnXgLQF3NMhNuW8fAKF04CZo/MBVCiqvuG0W/NtxR
 ieMBpyS8uXOC9QF9XoJQWMIMZ3YBCbEZtmRt6hqW06AoEQzLtPltJGZ5X8mn3B/EaTiu
 zVTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRhLDZNUWtN599h4c82sRhDI/n8K7MjHpPgoG8XNtPzmAGzvXdlAHqAMNCOQAWMVKdke++psmor9/jgakqHGuQbZO83Uc=
X-Gm-Message-State: AOJu0YyzF7UzCDuBOLvDxpFkjAuSeT6KhY8ob/Im+4Z4OszIjnmyAqTo
 55kYIGI9J2JcJIlSuoI5XMiMf8OMQbWp2nb5p0ZeLYhwr65Yz4KKtMA7sBC2sqBE9LVOOQk9nRb
 KyHU/eOrLBqBY4WVnYR4F+Jzup80=
X-Google-Smtp-Source: AGHT+IHCf+Y6QBIYrX7AsU6upbIKBL7VJM8zyfbHL8WpKMQD95vKu7MJk7S8JKE2xzT1VVOenMlOsN9xwDQWvdbIrtU=
X-Received: by 2002:a05:6102:5492:b0:472:e990:5db2 with SMTP id
 bk18-20020a056102549200b00472e9905db2mr1206269vsb.7.1709688330728; Tue, 05
 Mar 2024 17:25:30 -0800 (PST)
MIME-Version: 1.0
References: <20240221213140.365232-1-dbarboza@ventanamicro.com>
 <20240221213140.365232-3-dbarboza@ventanamicro.com>
In-Reply-To: <20240221213140.365232-3-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 6 Mar 2024 11:25:04 +1000
Message-ID: <CAKmqyKNT4-r1k632OxBcwm=zZFrcCywcQEMk=PQXsZP=kJfgFg@mail.gmail.com>
Subject: Re: [PATCH v6 2/9] trans_rvv.c.inc: remove 'is_store' bool from
 load/store fns
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, richard.henderson@linaro.org, max.chou@sifive.com, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e36;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe36.google.com
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

On Thu, Feb 22, 2024 at 7:34=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> After the 'mark_vs_dirty' changes from the previous patch the 'is_store'
> bool is unused in all load/store functions that were changed. Remove it.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/insn_trans/trans_rvv.c.inc | 69 ++++++++++++-------------
>  1 file changed, 34 insertions(+), 35 deletions(-)
>
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_=
trans/trans_rvv.c.inc
> index 7a98f1caa6..15ccebf3fc 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -609,8 +609,7 @@ typedef void gen_helper_ldst_us(TCGv_ptr, TCGv_ptr, T=
CGv,
>                                  TCGv_env, TCGv_i32);
>
>  static bool ldst_us_trans(uint32_t vd, uint32_t rs1, uint32_t data,
> -                          gen_helper_ldst_us *fn, DisasContext *s,
> -                          bool is_store)
> +                          gen_helper_ldst_us *fn, DisasContext *s)
>  {
>      TCGv_ptr dest, mask;
>      TCGv base;
> @@ -673,7 +672,7 @@ static bool ld_us_op(DisasContext *s, arg_r2nfvm *a, =
uint8_t eew)
>      data =3D FIELD_DP32(data, VDATA, NF, a->nf);
>      data =3D FIELD_DP32(data, VDATA, VTA, s->vta);
>      data =3D FIELD_DP32(data, VDATA, VMA, s->vma);
> -    return ldst_us_trans(a->rd, a->rs1, data, fn, s, false);
> +    return ldst_us_trans(a->rd, a->rs1, data, fn, s);
>  }
>
>  static bool ld_us_check(DisasContext *s, arg_r2nfvm* a, uint8_t eew)
> @@ -710,7 +709,7 @@ static bool st_us_op(DisasContext *s, arg_r2nfvm *a, =
uint8_t eew)
>      data =3D FIELD_DP32(data, VDATA, VM, a->vm);
>      data =3D FIELD_DP32(data, VDATA, LMUL, emul);
>      data =3D FIELD_DP32(data, VDATA, NF, a->nf);
> -    return ldst_us_trans(a->rd, a->rs1, data, fn, s, true);
> +    return ldst_us_trans(a->rd, a->rs1, data, fn, s);
>  }
>
>  static bool st_us_check(DisasContext *s, arg_r2nfvm* a, uint8_t eew)
> @@ -739,7 +738,7 @@ static bool ld_us_mask_op(DisasContext *s, arg_vlm_v =
*a, uint8_t eew)
>      /* Mask destination register are always tail-agnostic */
>      data =3D FIELD_DP32(data, VDATA, VTA, s->cfg_vta_all_1s);
>      data =3D FIELD_DP32(data, VDATA, VMA, s->vma);
> -    return ldst_us_trans(a->rd, a->rs1, data, fn, s, false);
> +    return ldst_us_trans(a->rd, a->rs1, data, fn, s);
>  }
>
>  static bool ld_us_mask_check(DisasContext *s, arg_vlm_v *a, uint8_t eew)
> @@ -756,7 +755,7 @@ static bool st_us_mask_op(DisasContext *s, arg_vsm_v =
*a, uint8_t eew)
>      /* EMUL =3D 1, NFIELDS =3D 1 */
>      data =3D FIELD_DP32(data, VDATA, LMUL, 0);
>      data =3D FIELD_DP32(data, VDATA, NF, 1);
> -    return ldst_us_trans(a->rd, a->rs1, data, fn, s, true);
> +    return ldst_us_trans(a->rd, a->rs1, data, fn, s);
>  }
>
>  static bool st_us_mask_check(DisasContext *s, arg_vsm_v *a, uint8_t eew)
> @@ -776,7 +775,7 @@ typedef void gen_helper_ldst_stride(TCGv_ptr, TCGv_pt=
r, TCGv,
>
>  static bool ldst_stride_trans(uint32_t vd, uint32_t rs1, uint32_t rs2,
>                                uint32_t data, gen_helper_ldst_stride *fn,
> -                              DisasContext *s, bool is_store)
> +                              DisasContext *s)
>  {
>      TCGv_ptr dest, mask;
>      TCGv base, stride;
> @@ -823,7 +822,7 @@ static bool ld_stride_op(DisasContext *s, arg_rnfvm *=
a, uint8_t eew)
>      data =3D FIELD_DP32(data, VDATA, NF, a->nf);
>      data =3D FIELD_DP32(data, VDATA, VTA, s->vta);
>      data =3D FIELD_DP32(data, VDATA, VMA, s->vma);
> -    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, fn, s, false);
> +    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, fn, s);
>  }
>
>  static bool ld_stride_check(DisasContext *s, arg_rnfvm* a, uint8_t eew)
> @@ -857,7 +856,7 @@ static bool st_stride_op(DisasContext *s, arg_rnfvm *=
a, uint8_t eew)
>          return false;
>      }
>
> -    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, fn, s, true);
> +    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, fn, s);
>  }
>
>  static bool st_stride_check(DisasContext *s, arg_rnfvm* a, uint8_t eew)
> @@ -880,7 +879,7 @@ typedef void gen_helper_ldst_index(TCGv_ptr, TCGv_ptr=
, TCGv,
>
>  static bool ldst_index_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
>                               uint32_t data, gen_helper_ldst_index *fn,
> -                             DisasContext *s, bool is_store)
> +                             DisasContext *s)
>  {
>      TCGv_ptr dest, mask, index;
>      TCGv base;
> @@ -947,7 +946,7 @@ static bool ld_index_op(DisasContext *s, arg_rnfvm *a=
, uint8_t eew)
>      data =3D FIELD_DP32(data, VDATA, NF, a->nf);
>      data =3D FIELD_DP32(data, VDATA, VTA, s->vta);
>      data =3D FIELD_DP32(data, VDATA, VMA, s->vma);
> -    return ldst_index_trans(a->rd, a->rs1, a->rs2, data, fn, s, false);
> +    return ldst_index_trans(a->rd, a->rs1, a->rs2, data, fn, s);
>  }
>
>  static bool ld_index_check(DisasContext *s, arg_rnfvm* a, uint8_t eew)
> @@ -999,7 +998,7 @@ static bool st_index_op(DisasContext *s, arg_rnfvm *a=
, uint8_t eew)
>      data =3D FIELD_DP32(data, VDATA, VM, a->vm);
>      data =3D FIELD_DP32(data, VDATA, LMUL, emul);
>      data =3D FIELD_DP32(data, VDATA, NF, a->nf);
> -    return ldst_index_trans(a->rd, a->rs1, a->rs2, data, fn, s, true);
> +    return ldst_index_trans(a->rd, a->rs1, a->rs2, data, fn, s);
>  }
>
>  static bool st_index_check(DisasContext *s, arg_rnfvm* a, uint8_t eew)
> @@ -1078,7 +1077,7 @@ typedef void gen_helper_ldst_whole(TCGv_ptr, TCGv, =
TCGv_env, TCGv_i32);
>
>  static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
>                               uint32_t width, gen_helper_ldst_whole *fn,
> -                             DisasContext *s, bool is_store)
> +                             DisasContext *s)
>  {
>      uint32_t evl =3D s->cfg_ptr->vlenb * nf / width;
>      TCGLabel *over =3D gen_new_label();
> @@ -1109,42 +1108,42 @@ static bool ldst_whole_trans(uint32_t vd, uint32_=
t rs1, uint32_t nf,
>   * load and store whole register instructions ignore vtype and vl settin=
g.
>   * Thus, we don't need to check vill bit. (Section 7.9)
>   */
> -#define GEN_LDST_WHOLE_TRANS(NAME, ARG_NF, WIDTH, IS_STORE)             =
  \
> +#define GEN_LDST_WHOLE_TRANS(NAME, ARG_NF, WIDTH)               \
>  static bool trans_##NAME(DisasContext *s, arg_##NAME * a)               =
  \
>  {                                                                       =
  \
>      if (require_rvv(s) &&                                               =
  \
>          QEMU_IS_ALIGNED(a->rd, ARG_NF)) {                               =
  \
>          return ldst_whole_trans(a->rd, a->rs1, ARG_NF, WIDTH,           =
  \
> -                                gen_helper_##NAME, s, IS_STORE);        =
  \
> +                                gen_helper_##NAME, s);                  =
  \
>      }                                                                   =
  \
>      return false;                                                       =
  \
>  }
>
> -GEN_LDST_WHOLE_TRANS(vl1re8_v,  1, 1, false)
> -GEN_LDST_WHOLE_TRANS(vl1re16_v, 1, 2, false)
> -GEN_LDST_WHOLE_TRANS(vl1re32_v, 1, 4, false)
> -GEN_LDST_WHOLE_TRANS(vl1re64_v, 1, 8, false)
> -GEN_LDST_WHOLE_TRANS(vl2re8_v,  2, 1, false)
> -GEN_LDST_WHOLE_TRANS(vl2re16_v, 2, 2, false)
> -GEN_LDST_WHOLE_TRANS(vl2re32_v, 2, 4, false)
> -GEN_LDST_WHOLE_TRANS(vl2re64_v, 2, 8, false)
> -GEN_LDST_WHOLE_TRANS(vl4re8_v,  4, 1, false)
> -GEN_LDST_WHOLE_TRANS(vl4re16_v, 4, 2, false)
> -GEN_LDST_WHOLE_TRANS(vl4re32_v, 4, 4, false)
> -GEN_LDST_WHOLE_TRANS(vl4re64_v, 4, 8, false)
> -GEN_LDST_WHOLE_TRANS(vl8re8_v,  8, 1, false)
> -GEN_LDST_WHOLE_TRANS(vl8re16_v, 8, 2, false)
> -GEN_LDST_WHOLE_TRANS(vl8re32_v, 8, 4, false)
> -GEN_LDST_WHOLE_TRANS(vl8re64_v, 8, 8, false)
> +GEN_LDST_WHOLE_TRANS(vl1re8_v,  1, 1)
> +GEN_LDST_WHOLE_TRANS(vl1re16_v, 1, 2)
> +GEN_LDST_WHOLE_TRANS(vl1re32_v, 1, 4)
> +GEN_LDST_WHOLE_TRANS(vl1re64_v, 1, 8)
> +GEN_LDST_WHOLE_TRANS(vl2re8_v,  2, 1)
> +GEN_LDST_WHOLE_TRANS(vl2re16_v, 2, 2)
> +GEN_LDST_WHOLE_TRANS(vl2re32_v, 2, 4)
> +GEN_LDST_WHOLE_TRANS(vl2re64_v, 2, 8)
> +GEN_LDST_WHOLE_TRANS(vl4re8_v,  4, 1)
> +GEN_LDST_WHOLE_TRANS(vl4re16_v, 4, 2)
> +GEN_LDST_WHOLE_TRANS(vl4re32_v, 4, 4)
> +GEN_LDST_WHOLE_TRANS(vl4re64_v, 4, 8)
> +GEN_LDST_WHOLE_TRANS(vl8re8_v,  8, 1)
> +GEN_LDST_WHOLE_TRANS(vl8re16_v, 8, 2)
> +GEN_LDST_WHOLE_TRANS(vl8re32_v, 8, 4)
> +GEN_LDST_WHOLE_TRANS(vl8re64_v, 8, 8)
>
>  /*
>   * The vector whole register store instructions are encoded similar to
>   * unmasked unit-stride store of elements with EEW=3D8.
>   */
> -GEN_LDST_WHOLE_TRANS(vs1r_v, 1, 1, true)
> -GEN_LDST_WHOLE_TRANS(vs2r_v, 2, 1, true)
> -GEN_LDST_WHOLE_TRANS(vs4r_v, 4, 1, true)
> -GEN_LDST_WHOLE_TRANS(vs8r_v, 8, 1, true)
> +GEN_LDST_WHOLE_TRANS(vs1r_v, 1, 1)
> +GEN_LDST_WHOLE_TRANS(vs2r_v, 2, 1)
> +GEN_LDST_WHOLE_TRANS(vs4r_v, 4, 1)
> +GEN_LDST_WHOLE_TRANS(vs8r_v, 8, 1)
>
>  /*
>   *** Vector Integer Arithmetic Instructions
> --
> 2.43.2
>
>

