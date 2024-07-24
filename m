Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6095EC3DA49
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 03:08:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWSLU-0006tW-AZ; Tue, 23 Jul 2024 23:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sWSLS-0006sv-SF
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 23:07:14 -0400
Received: from mail-ua1-x92f.google.com ([2607:f8b0:4864:20::92f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sWSLQ-0004TP-6l
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 23:07:14 -0400
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-81f91171316so268646241.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 20:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721790431; x=1722395231; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1qXlx/TNxoKqzKLOoKv8F18DrzOG2OfwX+Mj3rQ3Dy0=;
 b=dRvJ6gyo7d3R2ae+17MLufpNXXmh1TWim6567xvAcZTy2u52dPDdTT4RZRJ07IXSyr
 OJRko2+GL9PG4aWIonyerNLyVeYG6syGk8L+YO6hFLPbeJfHMikwPqCIsskjVdIXlMdS
 VId6qr5rUsG9Nhb8bFnoYRrNfOs+0kriA+cc3+ITSHcPYPmxSTo23dGvbkplIh8/HQ1U
 CK/+414fdGR+Hbun+MiYt1XBQpNYNEUay95tPuM/LlahU2wQlvCiJ9Pwzxoxq553g1NW
 dOPqBFg4EJf6as/B37eE1Yx5qBXMsgjGare7DbId3eogv2ckkR+WLziMueuh/k7d1vJW
 M4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721790431; x=1722395231;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1qXlx/TNxoKqzKLOoKv8F18DrzOG2OfwX+Mj3rQ3Dy0=;
 b=NLtdWev6PVjBg+NDc+v9bjfEW0LfAyPQ2t1wts3AZel6mpFYZbB+2zFZSimyqXNMC3
 ntd4Sek4CWxCh9sGKzDyl+mp83xqW/ESBDk5zADjY9DmJSHkmNPkGBVGADJXmA4B4dUn
 g7ZwBoksaGREUrancQD462le6UqcWNDvies0Gm/+cpsMNjwCU97zdJ4+DuYyHOUNqFIj
 MKgxapJ9rXhA7/h/MIN1s5c5OYoPKWdqwA8sDzuaiUeSSSB9x0QdUms/cGaep2N+jtwJ
 hVsO4N3oTNxSj4cqCWSuJI3uPorbQWKMz/bRBhnTl4ryMUHAEThq6aRr+qCH8yYAT2xU
 x0IA==
X-Gm-Message-State: AOJu0YyFUem5SwAVP3D5WqwdZ6m8FmpjmwJvOfIoawZVfdbZZ7E3R+HR
 1zBbVVIYRWv9LDQEBngG7MTplIUUplholAn78p1lpaNVdbVs1gwWK6nrh9dXJHhPaZPOV8edivq
 lCpcIfyxAXbDmKbdKPjhP1i8t9pc85FISj4Q=
X-Google-Smtp-Source: AGHT+IFfJBCBqKvE6cvXpIPtsUfdTyl1f8ARQZIGxm/RhxwE91WhgGNnYsQnWgq9S+iLmMlA54BlXwxeXGglXP8kbC0=
X-Received: by 2002:a05:6102:15ab:b0:492:97c1:a78a with SMTP id
 ada2fe7eead31-493c5b604bdmr237243137.13.1721790430903; Tue, 23 Jul 2024
 20:07:10 -0700 (PDT)
MIME-Version: 1.0
References: <172075515999.22382.15550760745449625636-0@git.sr.ht>
 <172075515999.22382.15550760745449625636-1@git.sr.ht>
In-Reply-To: <172075515999.22382.15550760745449625636-1@git.sr.ht>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 24 Jul 2024 13:06:44 +1000
Message-ID: <CAKmqyKOVuUkOTxjscBOhKR4zvQcX1QqqTCb_+uip3noi=0yOzg@mail.gmail.com>
Subject: Re: [PATCH qemu v2 1/1] target/riscv: Add Zilsd and Zcmlsd extension
 support
To: "~liuxu" <liuxu@nucleisys.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92f;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92f.google.com
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

On Fri, Jul 12, 2024 at 1:32=E2=80=AFPM ~liuxu <liuxu@git.sr.ht> wrote:
>
> From: lxx <1733205434@qq.com>
>
> This patch adds support for the Zilsd and Zcmlsd extension,
> which is documented at https://github.com/riscv/riscv-zilsd/releases/tag/=
v0.9.0
>
> Co-developed-by: SUN Dongya <sundongya@nucleisys.com>
> Co-developed-by: LIU Xu <liuxu@nucleisys.com>
> Co-developed-by: ZHAO Fujin <zhaofujin@nucleisys.com>
> ---
>  target/riscv/cpu.c                         |  4 +
>  target/riscv/cpu_cfg.h                     |  2 +
>  target/riscv/insn16.decode                 |  8 ++
>  target/riscv/insn32.decode                 | 12 ++-
>  target/riscv/insn_trans/trans_zcmlsd.c.inc | 91 +++++++++++++++++++++
>  target/riscv/insn_trans/trans_zilsd.c.inc  | 94 ++++++++++++++++++++++
>  target/riscv/tcg/tcg-cpu.c                 | 13 +++
>  target/riscv/translate.c                   |  2 +
>  8 files changed, 224 insertions(+), 2 deletions(-)
>  create mode 100644 target/riscv/insn_trans/trans_zcmlsd.c.inc
>  create mode 100644 target/riscv/insn_trans/trans_zilsd.c.inc
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 36e3e5fdaf..71274e36f8 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -113,6 +113,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(zihintntl, PRIV_VERSION_1_10_0, ext_zihintntl),
>      ISA_EXT_DATA_ENTRY(zihintpause, PRIV_VERSION_1_10_0, ext_zihintpause=
),
>      ISA_EXT_DATA_ENTRY(zihpm, PRIV_VERSION_1_12_0, ext_zihpm),
> +    ISA_EXT_DATA_ENTRY(zilsd, PRIV_VERSION_1_12_0, ext_zilsd),
>      ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmul),
>      ISA_EXT_DATA_ENTRY(za64rs, PRIV_VERSION_1_12_0, has_priv_1_11),
>      ISA_EXT_DATA_ENTRY(zaamo, PRIV_VERSION_1_12_0, ext_zaamo),
> @@ -132,6 +133,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(zce, PRIV_VERSION_1_12_0, ext_zce),
>      ISA_EXT_DATA_ENTRY(zcmp, PRIV_VERSION_1_12_0, ext_zcmp),
>      ISA_EXT_DATA_ENTRY(zcmt, PRIV_VERSION_1_12_0, ext_zcmt),
> +    ISA_EXT_DATA_ENTRY(zcmlsd, PRIV_VERSION_1_12_0, ext_zcmlsd),
>      ISA_EXT_DATA_ENTRY(zba, PRIV_VERSION_1_12_0, ext_zba),
>      ISA_EXT_DATA_ENTRY(zbb, PRIV_VERSION_1_12_0, ext_zbb),
>      ISA_EXT_DATA_ENTRY(zbc, PRIV_VERSION_1_12_0, ext_zbc),
> @@ -1492,6 +1494,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[]=
 =3D {
>
>      MULTI_EXT_CFG_BOOL("zicntr", ext_zicntr, true),
>      MULTI_EXT_CFG_BOOL("zihpm", ext_zihpm, true),
> +    MULTI_EXT_CFG_BOOL("zilsd", ext_zilsd, false),
>
>      MULTI_EXT_CFG_BOOL("zba", ext_zba, true),
>      MULTI_EXT_CFG_BOOL("zbb", ext_zbb, true),
> @@ -1531,6 +1534,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[]=
 =3D {
>      MULTI_EXT_CFG_BOOL("zcmp", ext_zcmp, false),
>      MULTI_EXT_CFG_BOOL("zcmt", ext_zcmt, false),
>      MULTI_EXT_CFG_BOOL("zicond", ext_zicond, false),
> +    MULTI_EXT_CFG_BOOL("zcmlsd", ext_zcmlsd, false),
>
>      /* Vector cryptography extensions */
>      MULTI_EXT_CFG_BOOL("zvbb", ext_zvbb, false),
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index cb750154bd..54e93897ee 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -51,6 +51,7 @@ struct RISCVCPUConfig {
>      bool ext_zcf;
>      bool ext_zcmp;
>      bool ext_zcmt;
> +    bool ext_zcmlsd;
>      bool ext_zk;
>      bool ext_zkn;
>      bool ext_zknd;
> @@ -71,6 +72,7 @@ struct RISCVCPUConfig {
>      bool ext_zihintntl;
>      bool ext_zihintpause;
>      bool ext_zihpm;
> +    bool ext_zilsd;
>      bool ext_ztso;
>      bool ext_smstateen;
>      bool ext_sstc;
> diff --git a/target/riscv/insn16.decode b/target/riscv/insn16.decode
> index b96c534e73..111bcaee38 100644
> --- a/target/riscv/insn16.decode
> +++ b/target/riscv/insn16.decode
> @@ -130,10 +130,14 @@ sw                110  ... ... .. ... 00 @cs_w
>  {
>    ld              011  ... ... .. ... 00 @cl_d
>    c_flw           011  ... ... .. ... 00 @cl_w
> +  # *** Zcmlsd Extension ***
> +  zcmlsd_ld       011  ... ... .. ... 00 @cl_d
>  }
>  {
>    sd              111  ... ... .. ... 00 @cs_d
>    c_fsw           111  ... ... .. ... 00 @cs_w
> +  # *** Zcmlsd Extension ***
> +  zcmlsd_sd       111  ... ... .. ... 00 @cs_d
>  }
>
>  # *** RV32/64C Standard Extension (Quadrant 1) ***
> @@ -207,10 +211,14 @@ sw                110 .  .....  ..... 10 @c_swsp
>    c64_illegal     011 -  00000  ----- 10 # c.ldsp, RES rd=3D0
>    ld              011 .  .....  ..... 10 @c_ldsp
>    c_flw           011 .  .....  ..... 10 @c_lwsp
> +  # *** Zcmlsd Extension ***
> +  zcmlsd_ldsp     011 .  .....  ..... 10 @c_ldsp
>  }
>  {
>    sd              111 .  .....  ..... 10 @c_sdsp
>    c_fsw           111 .  .....  ..... 10 @c_swsp
> +  # *** Zcmlsd Extension ***
> +  zcmlsd_sdsp     111 .  .....  ..... 10 @c_sdsp
>  }
>
>  # *** RV64 and RV32 Zcb Extension ***
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index f22df04cfd..f6f4b7950b 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -169,8 +169,16 @@ csrrci   ............     ..... 111 ..... 1110011 @c=
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
> diff --git a/target/riscv/insn_trans/trans_zcmlsd.c.inc b/target/riscv/in=
sn_trans/trans_zcmlsd.c.inc
> new file mode 100644
> index 0000000000..f864231226
> --- /dev/null
> +++ b/target/riscv/insn_trans/trans_zcmlsd.c.inc
> @@ -0,0 +1,91 @@
> +/*
> + * RISC-V translation routines for the Zcmlsd Extension.
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
> +#define REQUIRE_ZCMLSD(ctx) do {    \
> +    if (!ctx->cfg_ptr->ext_zcmlsd)  \
> +        return false;               \
> +} while (0)
> +
> +static bool gen_cm_load_i64(DisasContext *ctx, arg_lb *a, int flag)
> +{
> +    REQUIRE_ZCMLSD(ctx);
> +    REQUIRE_32BIT(ctx);
> +
> +    if (flag && (a->rd =3D=3D 0)) {
> +        return false;
> +    }

What is the use of flag here?

Also this is missing a even destination register check

> +
> +    TCGv dest_low =3D dest_gpr(ctx, a->rd);
> +    TCGv dest_high =3D dest_gpr(ctx, a->rd + 1);
> +    TCGv addr =3D get_address(ctx, a->rs1, a->imm);
> +    TCGv_i64 tmp =3D tcg_temp_new_i64();
> +
> +    tcg_gen_qemu_ld_i64(tmp, addr, ctx->mem_idx, MO_TESQ);
> +    tcg_gen_extr_i64_tl(dest_low, dest_high, tmp);
> +    gen_set_gpr(ctx, a->rd, dest_low);
> +    gen_set_gpr(ctx, a->rd + 1, dest_high);
> +
> +    return true;
> +}
> +
> +static bool trans_zcmlsd_ldsp(DisasContext *ctx, arg_zcmlsd_ldsp *a)
> +{
> +    return gen_cm_load_i64(ctx, a, 1);

Where is the stack pointer taken into account?

> +}
> +
> +static bool trans_zcmlsd_ld(DisasContext *ctx, arg_zcmlsd_ld *a)
> +{
> +    return gen_cm_load_i64(ctx, a, 0);
> +}
> +
> +static bool gen_cm_store_i64(DisasContext *ctx, arg_sb *a, int flag)
> +{
> +    REQUIRE_ZCMLSD(ctx);
> +    REQUIRE_32BIT(ctx);
> +
> +    if (flag && (a->rs2 =3D=3D 0)) {
> +        TCGv data =3D get_gpr(ctx, a->rs2, EXT_NONE);
> +        TCGv addr =3D get_address(ctx, a->rs1, a->imm);
> +        TCGv_i64 tmp =3D tcg_temp_new_i64();
> +
> +        tcg_gen_ext_tl_i64(tmp, data);
> +        tcg_gen_qemu_st_i64(tmp, addr, ctx->mem_idx, MO_TESQ);
> +
> +        return true;
> +    }
> +
> +    TCGv data_low =3D get_gpr(ctx, a->rs2, EXT_NONE);
> +    TCGv data_high =3D get_gpr(ctx, a->rs2 + 1, EXT_NONE);
> +    TCGv addr =3D get_address(ctx, a->rs1, a->imm);
> +    TCGv_i64 tmp =3D tcg_temp_new_i64();
> +
> +    tcg_gen_concat_tl_i64(tmp, data_low, data_high);
> +    tcg_gen_qemu_st_i64(tmp, addr, ctx->mem_idx, MO_TESQ);
> +
> +    return true;
> +}
> +
> +static bool trans_zcmlsd_sdsp(DisasContext *ctx, arg_zcmlsd_sdsp *a)
> +{
> +    return gen_cm_store_i64(ctx, a, 1);
> +}
> +
> +static bool trans_zcmlsd_sd(DisasContext *ctx, arg_zcmlsd_sd *a)
> +{
> +    return gen_cm_store_i64(ctx, a, 0);
> +}
> diff --git a/target/riscv/insn_trans/trans_zilsd.c.inc b/target/riscv/ins=
n_trans/trans_zilsd.c.inc
> new file mode 100644
> index 0000000000..a1a7874ed8
> --- /dev/null
> +++ b/target/riscv/insn_trans/trans_zilsd.c.inc
> @@ -0,0 +1,94 @@
> +/*
> + * RISC-V translation routines for the Zilsd Extension.
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
> +static bool gen_load_i64(DisasContext *ctx, arg_ld *a)
> +{
> +    REQUIRE_ZILSD(ctx);
> +    REQUIRE_32BIT(ctx);
> +
> +    if ((a->rd) % 2) {
> +        return false;
> +    }
> +    if (a->rd =3D=3D 0) {
> +        TCGv dest =3D dest_gpr(ctx, a->rd);
> +        TCGv addr =3D get_address(ctx, a->rs1, a->imm);
> +
> +        tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, MO_TESL);
> +        gen_set_gpr(ctx, a->rd, dest);
> +        return true;
> +    }
> +
> +    TCGv dest_low =3D dest_gpr(ctx, a->rd);
> +    TCGv dest_high =3D dest_gpr(ctx, a->rd + 1);
> +    TCGv addr =3D get_address(ctx, a->rs1, a->imm);
> +    TCGv_i64 tmp =3D tcg_temp_new_i64();
> +
> +    tcg_gen_qemu_ld_i64(tmp, addr, ctx->mem_idx, MO_TESQ);
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
> +    return gen_load_i64(ctx, a);
> +}
> +
> +static bool gen_store_i64(DisasContext *ctx, arg_sd *a)
> +{
> +    REQUIRE_ZILSD(ctx);
> +    REQUIRE_32BIT(ctx);
> +
> +    if ((a->rs2) % 2) {
> +        return false;
> +    }
> +    if (a->rs2 =3D=3D 0) {
> +        TCGv data =3D get_gpr(ctx, a->rs2, EXT_NONE);
> +        TCGv addr =3D get_address(ctx, a->rs1, a->imm);
> +        TCGv_i64 tmp =3D tcg_temp_new_i64();
> +
> +        tcg_gen_ext_tl_i64(tmp, data);
> +        tcg_gen_qemu_st_i64(tmp, addr, ctx->mem_idx, MO_TESQ);
> +
> +        return true;
> +    }
> +
> +    TCGv data_low =3D get_gpr(ctx, a->rs2, EXT_NONE);
> +    TCGv data_high =3D get_gpr(ctx, a->rs2 + 1, EXT_NONE);
> +    TCGv addr =3D get_address(ctx, a->rs1, a->imm);
> +    TCGv_i64 tmp =3D tcg_temp_new_i64();
> +
> +    tcg_gen_concat_tl_i64(tmp, data_low, data_high);
> +    tcg_gen_qemu_st_i64(tmp, addr, ctx->mem_idx, MO_TESQ);
> +
> +    return true;
> +}
> +
> +static bool trans_zilsd_sd(DisasContext *ctx, arg_zilsd_sd *a)
> +{
> +    return gen_store_i64(ctx, a);
> +}
> +
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index b5b95e052d..8321586513 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -721,6 +721,19 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu=
, Error **errp)
>          cpu->pmu_avail_ctrs =3D 0;
>      }
>
> +    if (cpu->cfg.ext_zcmlsd) {
> +        if (riscv_has_ext(env, RVC) && riscv_has_ext(env, RVF)) {
> +            error_setg(errp,
> +                    "Zcmlsd cannot be supported together with C and F ex=
tension");

Is that right? The spec just says:

"Zcmlsd depends on Zilsd and Zca. It has overlapping encodings with
Zcf and is thus incompatible
with Zcf."

Also you should setup an imply rule so that Zilsd and Zca are enabled
by default if Zcmlsd is (and also enforce that they are enabled)

Alistair

> +            return;
> +        }
> +        if (cpu->cfg.ext_zcf) {
> +            error_setg(errp,
> +                    "Zcmlsd cannot be supported together with Zcf extens=
ion");
> +            return;
> +        }
> +    }
> +
>      /*
>       * Disable isa extensions based on priv spec after we
>       * validated and set everything we need.
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 9ff09ebdb6..ec39897ef6 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -1109,10 +1109,12 @@ static uint32_t opcode_at(DisasContextBase *dcbas=
e, target_ulong pc)
>  #include "decode-xthead.c.inc"
>  #include "insn_trans/trans_xthead.c.inc"
>  #include "insn_trans/trans_xventanacondops.c.inc"
> +#include "insn_trans/trans_zilsd.c.inc"
>
>  /* Include the auto-generated decoder for 16 bit insn */
>  #include "decode-insn16.c.inc"
>  #include "insn_trans/trans_rvzce.c.inc"
> +#include "insn_trans/trans_zcmlsd.c.inc"
>
>  /* Include decoders for factored-out extensions */
>  #include "decode-XVentanaCondOps.c.inc"
> --
> 2.43.4

