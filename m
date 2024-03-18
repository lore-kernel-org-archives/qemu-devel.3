Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3363CC54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 09:11:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rm90w-00065I-38; Mon, 18 Mar 2024 05:10:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rm90r-00064o-QW; Mon, 18 Mar 2024 05:10:33 -0400
Received: from mail-vs1-xe30.google.com ([2607:f8b0:4864:20::e30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rm90p-0004Ug-Ma; Mon, 18 Mar 2024 05:10:33 -0400
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-4767bcb4ebdso349348137.0; 
 Mon, 18 Mar 2024 02:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710753029; x=1711357829; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qng+qzcHxa9AfBUC0FmA1FM/4z3ZYPTC5vPsa6YWWp4=;
 b=Rd8QWC8KnF9sklxvc7nW3jvt2Hox6WXGIgwyn5SRJTCX4VLsLn/f5AEsh6cNSCwnwX
 G5dMZyG68/Gic06hPdcOQi9Hs18slN4Xbu+vtzrygTTdegVz15gg8LKmbExH0ASq4ZIl
 j0o8xTNdyL24wHmvh/2PlUOVkV+/gWnGyuu4lglDybJaR9dpSBNc7C2x73AUuGQGhFFO
 7wcvcVJreiZyvK8PyPRHCIyvqJG1ghYnApE6ODxFZFVyb7HhSbQ1szT5Lu28/I3O8CJf
 x/BVeOxYSmD84maR9YswhybwQq4+pq9Ny48vW+/8Re8ry6YPB83Q+ZZ9MdYwQBWTfTgW
 gdvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710753029; x=1711357829;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qng+qzcHxa9AfBUC0FmA1FM/4z3ZYPTC5vPsa6YWWp4=;
 b=JUvnSJucZhPsonSZ3Njfvw6Dis6riTLjPO4yLFqluzw2FXjVsl5cUGc+nFm8Jo7Fkv
 W9HtY/GAYShx+r5uP8K4B0NXa+Y+n0h38fmhz+t+PMMj8JKDUX4ZSynEd74VSF3wNDPB
 1wgvQOLcl7R5AIgBgEFNEVXSwN8qpNmGMNYVGo5lvQjwMw1UWYVdauxPADG6q7eDEpFg
 GFlsDlaO8Q3fdRVAXoRoldb3V+5nbka1JA80HUG34jXNlK9kINf2en4LOf6zJ4Z9lOYm
 CwfDfIsKQRn6cjuj2QKQ7YbDsHMoFSnOOWW35/47V/GgVuixCQTckZW25ei9mLaf9YMK
 r8tA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaxz5xInh+ODH9TjjT144Vj9Aue1ahE7LJEJAVh88DUO2pcfTxevPLlt3vF7ipPpNwdP++sJCZE2O0lEak6lV5nztiVrI=
X-Gm-Message-State: AOJu0YxiczCzfcpleltVvxIdn7+o5OSMHURWUjmdv7MgE77EdDM9p4BU
 Qu1GPXbY+WBRO0LNLcxUouvVRUP9j+UVQwZF8b7j8XiMn1cYPOXuCsUmkhLjBFLYnQsUD0qw9yv
 ScxLozmbxLGFWLxqlQ41GThpRYYg=
X-Google-Smtp-Source: AGHT+IHhkmWk8bi4dkp343D8vPi82VlxslpXTwCKgO+SnOBfdQDow/vpvVbTKMAwx0k7krMKLvEq6ZvgoIz8wWJlR/U=
X-Received: by 2002:a67:b64b:0:b0:476:5404:5f11 with SMTP id
 e11-20020a67b64b000000b0047654045f11mr7469653vsm.25.1710753029062; Mon, 18
 Mar 2024 02:10:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240314175704.478276-1-dbarboza@ventanamicro.com>
 <20240314175704.478276-6-dbarboza@ventanamicro.com>
In-Reply-To: <20240314175704.478276-6-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 18 Mar 2024 19:10:03 +1000
Message-ID: <CAKmqyKMDMS6gHchNbRcQOGjrA8chJqrCTObw+96hyeQyEozxsQ@mail.gmail.com>
Subject: Re: [PATCH for 9.0 v15 05/10] target/riscv: always clear vstart for
 ldst_whole insns
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, max.chou@sifive.com, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e30;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe30.google.com
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

On Fri, Mar 15, 2024 at 3:57=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Commit 8ff8ac6329 added a conditional to guard the vext_ldst_whole()
> helper if vstart >=3D evl. But by skipping the helper we're also not
> setting vstart =3D 0 at the end of the insns, which is incorrect.
>
> We'll move the conditional to vext_ldst_whole(), following in line with
> the removal of all brconds vstart >=3D vl that the next patch will do. Th=
e
> idea is to make the helpers responsible for their own vstart management.
>
> Fix ldst_whole isns by:
>
> - remove the brcond that skips the helper if vstart is >=3D evl;
>
> - vext_ldst_whole() now does an early exit with the same check, where
>   evl =3D (vlenb * nf) >> log2_esz, but the early exit will also clear
>   vstart.
>
> The 'width' param is now unneeded in ldst_whole_trans() and is also
> removed. It was used for the evl calculation for the brcond and has no
> other use now.  The 'width' is reflected in vext_ldst_whole() via
> log2_esz, which is encoded by GEN_VEXT_LD_WHOLE() as
> "ctzl(sizeof(ETYPE))".
>
> Suggested-by: Max Chou <max.chou@sifive.com>
> Fixes: 8ff8ac6329 ("target/riscv: rvv: Add missing early exit condition f=
or whole register load/store")
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/insn_trans/trans_rvv.c.inc | 52 +++++++++++--------------
>  target/riscv/vector_helper.c            |  5 +++
>  2 files changed, 28 insertions(+), 29 deletions(-)
>
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_=
trans/trans_rvv.c.inc
> index 52c26a7834..1366445e1f 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -1097,13 +1097,9 @@ GEN_VEXT_TRANS(vle64ff_v, MO_64, r2nfvm, ldff_op, =
ld_us_check)
>  typedef void gen_helper_ldst_whole(TCGv_ptr, TCGv, TCGv_env, TCGv_i32);
>
>  static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
> -                             uint32_t width, gen_helper_ldst_whole *fn,
> +                             gen_helper_ldst_whole *fn,
>                               DisasContext *s)
>  {
> -    uint32_t evl =3D s->cfg_ptr->vlenb * nf / width;
> -    TCGLabel *over =3D gen_new_label();
> -    tcg_gen_brcondi_tl(TCG_COND_GEU, cpu_vstart, evl, over);
> -
>      TCGv_ptr dest;
>      TCGv base;
>      TCGv_i32 desc;
> @@ -1120,8 +1116,6 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t =
rs1, uint32_t nf,
>
>      fn(dest, base, tcg_env, desc);
>
> -    gen_set_label(over);
> -
>      return true;
>  }
>
> @@ -1129,42 +1123,42 @@ static bool ldst_whole_trans(uint32_t vd, uint32_=
t rs1, uint32_t nf,
>   * load and store whole register instructions ignore vtype and vl settin=
g.
>   * Thus, we don't need to check vill bit. (Section 7.9)
>   */
> -#define GEN_LDST_WHOLE_TRANS(NAME, ARG_NF, WIDTH)               \
> +#define GEN_LDST_WHOLE_TRANS(NAME, ARG_NF)                              =
  \
>  static bool trans_##NAME(DisasContext *s, arg_##NAME * a)               =
  \
>  {                                                                       =
  \
>      if (require_rvv(s) &&                                               =
  \
>          QEMU_IS_ALIGNED(a->rd, ARG_NF)) {                               =
  \
> -        return ldst_whole_trans(a->rd, a->rs1, ARG_NF, WIDTH,           =
  \
> +        return ldst_whole_trans(a->rd, a->rs1, ARG_NF,                  =
  \
>                                  gen_helper_##NAME, s);                  =
  \
>      }                                                                   =
  \
>      return false;                                                       =
  \
>  }
>
> -GEN_LDST_WHOLE_TRANS(vl1re8_v,  1, 1)
> -GEN_LDST_WHOLE_TRANS(vl1re16_v, 1, 2)
> -GEN_LDST_WHOLE_TRANS(vl1re32_v, 1, 4)
> -GEN_LDST_WHOLE_TRANS(vl1re64_v, 1, 8)
> -GEN_LDST_WHOLE_TRANS(vl2re8_v,  2, 1)
> -GEN_LDST_WHOLE_TRANS(vl2re16_v, 2, 2)
> -GEN_LDST_WHOLE_TRANS(vl2re32_v, 2, 4)
> -GEN_LDST_WHOLE_TRANS(vl2re64_v, 2, 8)
> -GEN_LDST_WHOLE_TRANS(vl4re8_v,  4, 1)
> -GEN_LDST_WHOLE_TRANS(vl4re16_v, 4, 2)
> -GEN_LDST_WHOLE_TRANS(vl4re32_v, 4, 4)
> -GEN_LDST_WHOLE_TRANS(vl4re64_v, 4, 8)
> -GEN_LDST_WHOLE_TRANS(vl8re8_v,  8, 1)
> -GEN_LDST_WHOLE_TRANS(vl8re16_v, 8, 2)
> -GEN_LDST_WHOLE_TRANS(vl8re32_v, 8, 4)
> -GEN_LDST_WHOLE_TRANS(vl8re64_v, 8, 8)
> +GEN_LDST_WHOLE_TRANS(vl1re8_v,  1)
> +GEN_LDST_WHOLE_TRANS(vl1re16_v, 1)
> +GEN_LDST_WHOLE_TRANS(vl1re32_v, 1)
> +GEN_LDST_WHOLE_TRANS(vl1re64_v, 1)
> +GEN_LDST_WHOLE_TRANS(vl2re8_v,  2)
> +GEN_LDST_WHOLE_TRANS(vl2re16_v, 2)
> +GEN_LDST_WHOLE_TRANS(vl2re32_v, 2)
> +GEN_LDST_WHOLE_TRANS(vl2re64_v, 2)
> +GEN_LDST_WHOLE_TRANS(vl4re8_v,  4)
> +GEN_LDST_WHOLE_TRANS(vl4re16_v, 4)
> +GEN_LDST_WHOLE_TRANS(vl4re32_v, 4)
> +GEN_LDST_WHOLE_TRANS(vl4re64_v, 4)
> +GEN_LDST_WHOLE_TRANS(vl8re8_v,  8)
> +GEN_LDST_WHOLE_TRANS(vl8re16_v, 8)
> +GEN_LDST_WHOLE_TRANS(vl8re32_v, 8)
> +GEN_LDST_WHOLE_TRANS(vl8re64_v, 8)
>
>  /*
>   * The vector whole register store instructions are encoded similar to
>   * unmasked unit-stride store of elements with EEW=3D8.
>   */
> -GEN_LDST_WHOLE_TRANS(vs1r_v, 1, 1)
> -GEN_LDST_WHOLE_TRANS(vs2r_v, 2, 1)
> -GEN_LDST_WHOLE_TRANS(vs4r_v, 4, 1)
> -GEN_LDST_WHOLE_TRANS(vs8r_v, 8, 1)
> +GEN_LDST_WHOLE_TRANS(vs1r_v, 1)
> +GEN_LDST_WHOLE_TRANS(vs2r_v, 2)
> +GEN_LDST_WHOLE_TRANS(vs4r_v, 4)
> +GEN_LDST_WHOLE_TRANS(vs8r_v, 8)
>
>  /*
>   *** Vector Integer Arithmetic Instructions
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index bcc553c0e2..1f4c276b21 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -572,6 +572,11 @@ vext_ldst_whole(void *vd, target_ulong base, CPURISC=
VState *env, uint32_t desc,
>      uint32_t vlenb =3D riscv_cpu_cfg(env)->vlenb;
>      uint32_t max_elems =3D vlenb >> log2_esz;
>
> +    if (env->vstart >=3D ((vlenb * nf) >> log2_esz)) {
> +        env->vstart =3D 0;
> +        return;
> +    }
> +
>      k =3D env->vstart / max_elems;
>      off =3D env->vstart % max_elems;
>
> --
> 2.44.0
>
>

