Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B54C6C83F09
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 04:01:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXXbB-0001ag-6m; Fri, 04 Jul 2025 00:00:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXXap-0001V4-QQ; Fri, 04 Jul 2025 00:00:12 -0400
Received: from mail-ua1-x931.google.com ([2607:f8b0:4864:20::931])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXXan-0004aS-Oh; Fri, 04 Jul 2025 00:00:07 -0400
Received: by mail-ua1-x931.google.com with SMTP id
 a1e0cc1a2514c-881114808e4so127459241.3; 
 Thu, 03 Jul 2025 21:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751601604; x=1752206404; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f3Ae9461NHyVNzTv+BjQ+tjlvqe2OLFRfYH9ovbiVMc=;
 b=Zz9gjgXJKJ2p495xwGSUPjhRxFWdYWyrbHKveXXpsofQTCEP3IsId5TlfSGN5+OCE8
 /h8gfIdkjIRo+tdhxlPWn0by3hC9YwIU+qc1Z18ohEOFMQ5JrJS0rG3sYdSiO70A6wVy
 ScGBz96r6VCe0fdSTveepj4hvGrx+ZVva+MYt8LiLRcz0uZhSsYx94eY7H0OmT0ch8SF
 QIPFcdsy9Tvb2bOq3zcFcp5ijIbi9A+NBSLJeDVIyBMI0c0vEuVZc62BGII5lXgrY/rU
 MwlsubCbnIV1Gj3KSHKhuU24Zup47JBAl2swJBqS3sG+2o+YrC2bhNmwUpPtkCYm3TJ7
 psEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751601604; x=1752206404;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f3Ae9461NHyVNzTv+BjQ+tjlvqe2OLFRfYH9ovbiVMc=;
 b=NugM+o1W0kO+v1Pb6b5ZAnOHjnk4z527jH+A1V8LpncUZzWhD5jtahN0A0zdWlOjmL
 tzY1SV/2tTw7XmHXKRyfT7oG/dSuh0wYs8WYwnVNGXJEZdg8jDoF7GYPuUnC+a2cPw7b
 JwLYp5UjDdiu+cRnWChXLmnJ5d4WjuexzS8XIIlTYAQIRciujTywR7R4zUwQ812977CE
 ZsF/NbBvsOESKcH0Weyb0Vf1bK+nRoE6xnwVg4xo70G9Keuo/34uuAkOoWI5urMGIQ4v
 oZshDWJ9A+yHvr+XAT4S8ULXOh5yiOa7qkZevUlyS02lRzjpgwD0YyO/ceJjvE37QQaj
 JCZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6vNIN80Owk8/1urJXuiGrZV6+79hk3KaF/i6KDyfQ8EJ411fBA6+areBUFlTcH21VyMjuHGgfOXjv@nongnu.org
X-Gm-Message-State: AOJu0YzZGVVXTnlA53jA4cbC1J+toPb+hIH9arWRgHcd0OtlTC9o3VlH
 fBKILYwXQ4X13XQY36OJQjCUzlIprnS3HZ9oCAnMlBkwgRCMeRz16xPgUPVTabNAsGFxb/d1pxT
 vtq0vPJP3S211NU3bS/CoYVp6o38B0Ug=
X-Gm-Gg: ASbGncvVLSq2rKqCXGz6S9wHw65UUl50pHA0bBwOtOZfsMpH0UYgGBVNxYm0Xr30UJ0
 +MGzT41Fvrl87d4DITfWhS/371hc8L2woQBXcdwS5HzB9ncwWQQoi6HRRapbYFbH+t7/9ehX/HE
 2ctbBrVZg4iyNiednpEQu/PkxdmGgKyuGnmUFfwBj6SG1kUDC3/1NsG6ZmSc4YzhJSHYOXUo2Rx
 w==
X-Google-Smtp-Source: AGHT+IGyr7rxtPmJu29iRfvEQ59Qb59KUNZXg8tAf3cF5Ts7ItKMmYQuLFq2s5nn+MUxDcNrU03aRddfvL9e0Xw9Ge0=
X-Received: by 2002:a05:6102:8090:b0:4eb:eedf:df65 with SMTP id
 ada2fe7eead31-4f2f18329ecmr338818137.11.1751601604022; Thu, 03 Jul 2025
 21:00:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250618213542.22873-1-vliaskovitis@suse.com>
In-Reply-To: <20250618213542.22873-1-vliaskovitis@suse.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 4 Jul 2025 13:59:37 +1000
X-Gm-Features: Ac12FXzG5wIB8HXwREol2P4986gA8j8LZWeokncoDOqXFjTtonEnb0wYwuLFxM8
Message-ID: <CAKmqyKPFO+6sO_h_A6Q_mkOePFXyaEPvEz-Bg3BUQ+niyF6Trg@mail.gmail.com>
Subject: Re: [PATCH v2] target/riscv: Add a property to set vill bit on
 reserved usage of vsetvli instruction
To: Vasilis Liaskovitis <vliaskovitis@suse.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, dbarboza@ventanamicro.com, 
 ajones@ventanamicro.com, alistair.francis@wdc.com, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::931;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x931.google.com
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

On Thu, Jun 19, 2025 at 7:36=E2=80=AFAM Vasilis Liaskovitis
<vliaskovitis@suse.com> wrote:
>
> Usage of vsetvli instruction is reserved if VLMAX is changed when vsetvli=
 rs1
> and rd arguments are x0.
>
> In this case, if the new property is true, only the vill bit will be set.
>
> See https://github.com/riscv/riscv-isa-manual/blob/main/src/v-st-ext.adoc=
#avl-encoding
> According to the spec, the above use cases are reserved, and
> "Implementations may set vill in either case."
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2422
> Signed-off-by: Vasilis Liaskovitis <vliaskovitis@suse.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/cpu.c                      |  1 +
>  target/riscv/cpu_cfg_fields.h.inc       |  1 +
>  target/riscv/helper.h                   |  2 +-
>  target/riscv/insn_trans/trans_rvv.c.inc |  4 ++--
>  target/riscv/vector_helper.c            | 12 +++++++++++-
>  5 files changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 629ac37501..1c29ed3b2b 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2595,6 +2595,7 @@ static const Property riscv_cpu_properties[] =3D {
>      DEFINE_PROP_BOOL("rvv_ta_all_1s", RISCVCPU, cfg.rvv_ta_all_1s, false=
),
>      DEFINE_PROP_BOOL("rvv_ma_all_1s", RISCVCPU, cfg.rvv_ma_all_1s, false=
),
>      DEFINE_PROP_BOOL("rvv_vl_half_avl", RISCVCPU, cfg.rvv_vl_half_avl, f=
alse),
> +    DEFINE_PROP_BOOL("rvv_vsetvl_x0_vill", RISCVCPU, cfg.rvv_vsetvl_x0_v=
ill, false),
>
>      /*
>       * write_misa() is marked as experimental for now so mark
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fie=
lds.h.inc
> index 59f134a419..9c78a797cf 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -114,6 +114,7 @@ BOOL_FIELD(ext_supm)
>  BOOL_FIELD(rvv_ta_all_1s)
>  BOOL_FIELD(rvv_ma_all_1s)
>  BOOL_FIELD(rvv_vl_half_avl)
> +BOOL_FIELD(rvv_vsetvl_x0_vill)
>  /* Named features  */
>  BOOL_FIELD(ext_svade)
>  BOOL_FIELD(ext_zic64b)
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index 85d73e492d..f712b1c368 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -159,7 +159,7 @@ DEF_HELPER_FLAGS_3(hyp_hsv_d, TCG_CALL_NO_WG, void, e=
nv, tl, tl)
>  #endif
>
>  /* Vector functions */
> -DEF_HELPER_3(vsetvl, tl, env, tl, tl)
> +DEF_HELPER_4(vsetvl, tl, env, tl, tl, tl)
>  DEF_HELPER_5(vle8_v, void, ptr, ptr, tl, env, i32)
>  DEF_HELPER_5(vle16_v, void, ptr, ptr, tl, env, i32)
>  DEF_HELPER_5(vle32_v, void, ptr, ptr, tl, env, i32)
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_=
trans/trans_rvv.c.inc
> index 2b6077ac06..87071c5d62 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -202,7 +202,7 @@ static bool do_vsetvl(DisasContext *s, int rd, int rs=
1, TCGv s2)
>          s1 =3D get_gpr(s, rs1, EXT_ZERO);
>      }
>
> -    gen_helper_vsetvl(dst, tcg_env, s1, s2);
> +    gen_helper_vsetvl(dst, tcg_env, s1, s2, tcg_constant_tl((int) (rd =
=3D=3D 0 && rs1 =3D=3D 0)));
>      gen_set_gpr(s, rd, dst);
>      finalize_rvv_inst(s);
>
> @@ -222,7 +222,7 @@ static bool do_vsetivli(DisasContext *s, int rd, TCGv=
 s1, TCGv s2)
>
>      dst =3D dest_gpr(s, rd);
>
> -    gen_helper_vsetvl(dst, tcg_env, s1, s2);
> +    gen_helper_vsetvl(dst, tcg_env, s1, s2, tcg_constant_tl(0));
>      gen_set_gpr(s, rd, dst);
>      finalize_rvv_inst(s);
>      gen_update_pc(s, s->cur_insn_len);
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 5dc1c10012..b41c29da0b 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -35,7 +35,7 @@
>  #include <math.h>
>
>  target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
> -                            target_ulong s2)
> +                            target_ulong s2, target_ulong x0)
>  {
>      int vlmax, vl;
>      RISCVCPU *cpu =3D env_archcpu(env);
> @@ -83,6 +83,16 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target=
_ulong s1,
>      } else {
>          vl =3D vlmax;
>      }
> +
> +    if (cpu->cfg.rvv_vsetvl_x0_vill && x0 && (env->vl !=3D vl)) {
> +        /* only set vill bit. */
> +        env->vill =3D 1;
> +        env->vtype =3D 0;
> +        env->vl =3D 0;
> +        env->vstart =3D 0;
> +        return 0;
> +    }
> +
>      env->vl =3D vl;
>      env->vtype =3D s2;
>      env->vstart =3D 0;
> --
> 2.46.0
>
>

