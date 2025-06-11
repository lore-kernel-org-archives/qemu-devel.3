Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A208FC677C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 04:47:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPDMo-0005QV-Oe; Wed, 11 Jun 2025 00:47:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uPDMk-0005QC-FK
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 00:47:10 -0400
Received: from mail-vs1-xe30.google.com ([2607:f8b0:4864:20::e30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uPDMi-0002zP-6K
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 00:47:10 -0400
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-4e2b5ffb932so2311054137.0
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 21:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749617227; x=1750222027; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mbp9tjmx9HBlI8Cls16+iqwzkJqQ3XeUQWDI8MbT8Qg=;
 b=NhaNUIBwoKSUJ9EjuNd3rH6dcGjsxMNd3WnicfZa0W/7pUjEpwdqq5UcCO68iZInG+
 Wnqj3gNSy1VFoIEPBXSAzq2XH4tfgP3t4GKIUdIe8H7XDLd37/KMv0anQOqsCT7G1ioc
 874h76uCsn5q+EDFUhPWhsuzxsqbeN2wkH1Jv1v9pghoS8DZB9IRpQm7tXEoW0AUGeFV
 3tI/9KzBaykokju5hgTv3EdGrG/W+HVwEbwXGb8K4xuMZYjhv8nOzT60pgAx0aZ1Tm9g
 fh5mRB5chVZ3d3GTkIyEAwmlhqF8/38wz/4RpBbq5mmxI+8n3dHIL+20pxUs2/jVHNEI
 e5+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749617227; x=1750222027;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mbp9tjmx9HBlI8Cls16+iqwzkJqQ3XeUQWDI8MbT8Qg=;
 b=AABBeCfWn6RcJVh5O7aI7BYFCyYYZmHtpxKx8Q41ah60n3gWf6ztM7bAcG3HjRkkMO
 7TnxhUhXHTpzltQYNX9i7K+Qefi1qAtVBUf3TljWYQ9cgV9eJp8ajg5eEoQoIv/2QCe4
 e7dsbc/021bM2SJSjLV8T+mFoHbbObOJ+Cc8ZAwRt+p5WQrFhIu764Ep9S8ozr5wWUUn
 PY62JvK4r8zFfktvE/1hRFi4WPAjQg4xWKMu2T4MFA8tHPh0VHA8SXPQJKFF/VFnL1SU
 0k1rNoj0W4t51grCdFqEzNwh1yEhiTkSSt7pBaBovyPXSG45LthrQraQOnq64ohYMAGQ
 oEIw==
X-Gm-Message-State: AOJu0YzPsNOYQqE2BErM7zk0Fq6O8eGF5k0Zwm6KuI+CTwaBmpYhSKYk
 epVXitqOXaDguRiF/ZcukA//wTas5W8/Aopxx9U+xa0Je4KHxs8vq2DDrn+v6/phQOX5zmAKA6Q
 xqqN2zvJhwVHts7WxD2YxPkIA8SlnFBjSUg9+
X-Gm-Gg: ASbGncuhKzThxfxzqoliwfBmGKdZmyVMUlg2Jczyzxycbun1NIRlJ/16zoJwMCn3jGk
 uYK0ZxoXdd9RKrSDCsjZIVpEtQHyQTNgESfzJ/bG5QN2SPv7nMCZczsIzDuxcuVrQsJxkk6DoOF
 m+NrgrLvZppj+ueZb2LTeFFlihltl8Lp2Ut4quhRXB1rBdlquQxebnZx71m41BXFBHx9W/qhB+x
 w==
X-Google-Smtp-Source: AGHT+IGJt5KETTWtsJUYRoju9iJIcLPKIQ284FIozEMfgcRY20blm/ajQmB1fBmiyS3TXo/c4VcDXxjvumtNw65E81s=
X-Received: by 2002:a05:6102:c52:b0:4de:81a:7d42 with SMTP id
 ada2fe7eead31-4e7bae9c6damr1822755137.1.1749617226772; Tue, 10 Jun 2025
 21:47:06 -0700 (PDT)
MIME-Version: 1.0
References: <174728204531.21306.2652888415201006563-0@git.sr.ht>
 <174728204531.21306.2652888415201006563-1@git.sr.ht>
In-Reply-To: <174728204531.21306.2652888415201006563-1@git.sr.ht>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 11 Jun 2025 14:46:40 +1000
X-Gm-Features: AX0GCFuirUp88yQKbhs3N8fqfZqv5AkeoYMLXirwaaZkOLGxfx_2iAtCVZB-XIo
Message-ID: <CAKmqyKMfsWew3_GNHh3Y57bN6Djx_kDr0ZkAiMabfwYQTPy1oA@mail.gmail.com>
Subject: Re: [PATCH qemu v7 1/1] target/riscv: Add Zilsd and Zclsd extension
 support
To: "~liuxu" <liuxu@nucleisys.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e30;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe30.google.com
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

On Thu, May 15, 2025 at 2:07=E2=80=AFPM ~liuxu <liuxu@git.sr.ht> wrote:
>
> From: lxx <1733205434@qq.com>
>
> This patch adds support for the Zilsd and Zclsd extension,
> which is documented at https://github.com/riscv/riscv-zilsd/releases/tag/=
v1.0
>
> Co-developed-by: SUN Dongya <sundongya@nucleisys.com>
> Co-developed-by: LIU Xu <liuxu@nucleisys.com>
> Co-developed-by: ZHAO Fujin <zhaofujin@nucleisys.com>
> ---
>  target/riscv/cpu.c                        |   4 +
>  target/riscv/cpu_cfg.h                    |   2 +
>  target/riscv/insn16.decode                |   8 ++
>  target/riscv/insn32.decode                |  12 ++-
>  target/riscv/insn_trans/trans_zilsd.c.inc | 112 ++++++++++++++++++++++
>  target/riscv/tcg/tcg-cpu.c                |  20 ++++
>  target/riscv/translate.c                  |   1 +
>  7 files changed, 157 insertions(+), 2 deletions(-)
>  create mode 100644 target/riscv/insn_trans/trans_zilsd.c.inc
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 09ded6829a..54072e284d 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -115,6 +115,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(zihintntl, PRIV_VERSION_1_10_0, ext_zihintntl),
>      ISA_EXT_DATA_ENTRY(zihintpause, PRIV_VERSION_1_10_0, ext_zihintpause=
),
>      ISA_EXT_DATA_ENTRY(zihpm, PRIV_VERSION_1_12_0, ext_zihpm),
> +    ISA_EXT_DATA_ENTRY(zilsd, PRIV_VERSION_1_12_0, ext_zilsd),
>      ISA_EXT_DATA_ENTRY(zimop, PRIV_VERSION_1_13_0, ext_zimop),
>      ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmul),
>      ISA_EXT_DATA_ENTRY(za64rs, PRIV_VERSION_1_12_0, has_priv_1_12),
> @@ -138,6 +139,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(zcmop, PRIV_VERSION_1_13_0, ext_zcmop),
>      ISA_EXT_DATA_ENTRY(zcmp, PRIV_VERSION_1_12_0, ext_zcmp),
>      ISA_EXT_DATA_ENTRY(zcmt, PRIV_VERSION_1_12_0, ext_zcmt),
> +    ISA_EXT_DATA_ENTRY(zclsd, PRIV_VERSION_1_12_0, ext_zclsd),
>      ISA_EXT_DATA_ENTRY(zba, PRIV_VERSION_1_12_0, ext_zba),
>      ISA_EXT_DATA_ENTRY(zbb, PRIV_VERSION_1_12_0, ext_zbb),
>      ISA_EXT_DATA_ENTRY(zbc, PRIV_VERSION_1_12_0, ext_zbc),
> @@ -1653,6 +1655,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[]=
 =3D {
>
>      MULTI_EXT_CFG_BOOL("zicntr", ext_zicntr, true),
>      MULTI_EXT_CFG_BOOL("zihpm", ext_zihpm, true),
> +    MULTI_EXT_CFG_BOOL("zilsd", ext_zilsd, false),
>
>      MULTI_EXT_CFG_BOOL("zba", ext_zba, true),
>      MULTI_EXT_CFG_BOOL("zbb", ext_zbb, true),
> @@ -1692,6 +1695,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[]=
 =3D {
>      MULTI_EXT_CFG_BOOL("zcmp", ext_zcmp, false),
>      MULTI_EXT_CFG_BOOL("zcmt", ext_zcmt, false),
>      MULTI_EXT_CFG_BOOL("zicond", ext_zicond, false),
> +    MULTI_EXT_CFG_BOOL("zclsd", ext_zclsd, false),
>
>      /* Vector cryptography extensions */
>      MULTI_EXT_CFG_BOOL("zvbb", ext_zvbb, false),
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index 8a843482cc..1ca11f99f1 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -51,6 +51,7 @@ struct RISCVCPUConfig {
>      bool ext_zcf;
>      bool ext_zcmp;
>      bool ext_zcmt;
> +    bool ext_zclsd;
>      bool ext_zk;
>      bool ext_zkn;
>      bool ext_zknd;
> @@ -73,6 +74,7 @@ struct RISCVCPUConfig {
>      bool ext_zihintntl;
>      bool ext_zihintpause;
>      bool ext_zihpm;
> +    bool ext_zilsd;
>      bool ext_zimop;
>      bool ext_zcmop;
>      bool ext_ztso;
> diff --git a/target/riscv/insn16.decode b/target/riscv/insn16.decode
> index bf893d1c2e..c34020e4dc 100644
> --- a/target/riscv/insn16.decode
> +++ b/target/riscv/insn16.decode
> @@ -130,10 +130,14 @@ sw                110  ... ... .. ... 00 @cs_w
>  {
>    ld              011  ... ... .. ... 00 @cl_d
>    c_flw           011  ... ... .. ... 00 @cl_w
> +  # *** Zclsd Extension ***
> +  zclsd_ld        011  ... ... .. ... 00 @cl_d
>  }
>  {
>    sd              111  ... ... .. ... 00 @cs_d
>    c_fsw           111  ... ... .. ... 00 @cs_w
> +  # *** Zclsd Extension ***
> +  zclsd_sd        111  ... ... .. ... 00 @cs_d
>  }
>
>  # *** RV32/64C Standard Extension (Quadrant 1) ***
> @@ -212,10 +216,14 @@ sw                110 .  .....  ..... 10 @c_swsp
>    c64_illegal     011 -  00000  ----- 10 # c.ldsp, RES rd=3D0
>    ld              011 .  .....  ..... 10 @c_ldsp
>    c_flw           011 .  .....  ..... 10 @c_lwsp
> +  # *** Zclsd Extension ***
> +  zclsd_ldsp      011 .  .....  ..... 10 @c_ldsp
>  }
>  {
>    sd              111 .  .....  ..... 10 @c_sdsp
>    c_fsw           111 .  .....  ..... 10 @c_swsp
> +  # *** Zclsd Extension ***
> +  zclsd_sd        111 .  .....  ..... 10 @c_sdsp
>  }
>
>  # *** RV64 and RV32 Zcb Extension ***
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index 6d1a13c826..57c242c3bb 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -182,8 +182,16 @@ csrrci   ............     ..... 111 ..... 1110011 @c=
sr
>
>  # *** RV64I Base Instruction Set (in addition to RV32I) ***
>  lwu      ............   ..... 110 ..... 0000011 @i
> -ld       ............   ..... 011 ..... 0000011 @i
> -sd       ....... .....  ..... 011 ..... 0100011 @s
> +{
> +  ld       ............   ..... 011 ..... 0000011 @i
> +  # *** Zilsd instructions ***
> +  zilsd_ld ............   ..... 011 ..... 0000011 @i
> +}
> +{
> +  sd       ....... .....  ..... 011 ..... 0100011 @s
> +  # *** Zilsd instructions ***
> +  zilsd_sd ....... .....  ..... 011 ..... 0100011 @s
> +}
>  addiw    ............   ..... 000 ..... 0011011 @i
>  slliw    0000000 .....  ..... 001 ..... 0011011 @sh5
>  srliw    0000000 .....  ..... 101 ..... 0011011 @sh5
> diff --git a/target/riscv/insn_trans/trans_zilsd.c.inc b/target/riscv/ins=
n_trans/trans_zilsd.c.inc
> new file mode 100644
> index 0000000000..1e3ab362de
> --- /dev/null
> +++ b/target/riscv/insn_trans/trans_zilsd.c.inc
> @@ -0,0 +1,112 @@
> +/*
> + * RISC-V translation routines for the Zilsd & Zclsd Extension.
> + *
> + * Copyright (c) 2024 Nucleisys, Inc.
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
> +
> +#define REQUIRE_ZILSD(ctx) do {    \
> +    if (!ctx->cfg_ptr->ext_zilsd)  \
> +        return false;              \
> +} while (0)
> +
> +#define REQUIRE_ZCLSD(ctx) do {    \
> +    if (!ctx->cfg_ptr->ext_zclsd)  \
> +        return false;              \
> +} while (0)
> +
> +static bool gen_load_i64(DisasContext *ctx, arg_ld *a)
> +{
> +    if ((a->rd) % 2) {
> +        return false;
> +    }
> +
> +    TCGv dest_low =3D dest_gpr(ctx, a->rd);
> +    TCGv dest_high =3D dest_gpr(ctx, a->rd + 1);
> +    TCGv addr =3D get_address(ctx, a->rs1, a->imm);
> +    TCGv_i64 tmp =3D tcg_temp_new_i64();
> +
> +    tcg_gen_qemu_ld_i64(tmp, addr, ctx->mem_idx, MO_TESQ);
> +
> +    if (a->rd =3D=3D 0) {
> +        return true;
> +    }
> +
> +    tcg_gen_extr_i64_tl(dest_low, dest_high, tmp);
> +
> +    gen_set_gpr(ctx, a->rd, dest_low);
> +    gen_set_gpr(ctx, a->rd + 1, dest_high);
> +
> +    return true;
> +}
> +
> +static bool trans_zilsd_ld(DisasContext *ctx, arg_zilsd_ld *a)
> +{
> +    REQUIRE_32BIT(ctx);
> +    REQUIRE_ZILSD(ctx);
> +    return gen_load_i64(ctx, a);
> +}
> +
> +static bool trans_zclsd_ld(DisasContext *ctx, arg_zclsd_ld *a)
> +{
> +    REQUIRE_32BIT(ctx);
> +    REQUIRE_ZCLSD(ctx);

Shouldn't there be a check that only x8-15 is used?

> +    return gen_load_i64(ctx, a);
> +}
> +
> +static bool trans_zclsd_ldsp(DisasContext *ctx, arg_zclsd_ldsp *a)
> +{
> +    REQUIRE_32BIT(ctx);
> +    REQUIRE_ZCLSD(ctx);
> +
> +    if (a->rd =3D=3D 0) {
> +        return false;
> +    }
> +    return gen_load_i64(ctx, a);
> +}
> +
> +static bool gen_store_i64(DisasContext *ctx, arg_sd *a)
> +{
> +    if ((a->rs2) % 2) {
> +        return false;
> +    }
> +
> +    TCGv data_low =3D get_gpr(ctx, a->rs2, EXT_NONE);
> +    TCGv data_high =3D get_gpr(ctx, a->rs2 + 1, EXT_NONE);
> +    TCGv addr =3D get_address(ctx, a->rs1, a->imm);
> +    TCGv_i64 tmp =3D tcg_temp_new_i64();
> +
> +    if (a->rs2 =3D=3D 0) {
> +        tmp =3D tcg_constant_i64(0);
> +    } else {
> +        tcg_gen_concat_tl_i64(tmp, data_low, data_high);
> +    }
> +    tcg_gen_qemu_st_i64(tmp, addr, ctx->mem_idx, MO_TESQ);
> +
> +    return true;
> +}
> +
> +static bool trans_zilsd_sd(DisasContext *ctx, arg_zilsd_sd *a)
> +{
> +    REQUIRE_32BIT(ctx);
> +    REQUIRE_ZILSD(ctx);
> +    return gen_store_i64(ctx, a);
> +}
> +
> +static bool trans_zclsd_sd(DisasContext *ctx, arg_zclsd_sd *a)
> +{
> +    REQUIRE_32BIT(ctx);
> +    REQUIRE_ZCLSD(ctx);

and a x8-15 check here as well

Otherwise:

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> +    return gen_store_i64(ctx, a);
> +}
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 5aef9eef36..ea25817ffc 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -673,6 +673,26 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu=
, Error **errp)
>          cpu->pmu_avail_ctrs =3D 0;
>      }
>
> +    if (cpu->cfg.ext_zilsd && riscv_has_ext(env, RVC)) {
> +        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zclsd), true);
> +    }
> +
> +    if (cpu->cfg.ext_zclsd) {
> +        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zca), true);
> +        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zilsd), true);
> +
> +        if (riscv_has_ext(env, RVC) && riscv_has_ext(env, RVF)) {
> +            error_setg(errp,
> +                    "Zclsd cannot be supported together with C and F ext=
ension");
> +            return;
> +        }
> +        if (cpu->cfg.ext_zcf) {
> +            error_setg(errp,
> +                    "Zclsd cannot be supported together with Zcf extensi=
on");
> +            return;
> +        }
> +    }
> +
>      if (cpu->cfg.ext_zicfilp && !cpu->cfg.ext_zicsr) {
>          error_setg(errp, "zicfilp extension requires zicsr extension");
>          return;
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index d6651f244f..2cf1378dfd 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -1201,6 +1201,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase,=
 target_ulong pc)
>  /* Include the auto-generated decoder for 16 bit insn */
>  #include "decode-insn16.c.inc"
>  #include "insn_trans/trans_rvzce.c.inc"
> +#include "insn_trans/trans_zilsd.c.inc"
>  #include "insn_trans/trans_rvzcmop.c.inc"
>  #include "insn_trans/trans_rvzicfiss.c.inc"
>
> --
> 2.45.3

