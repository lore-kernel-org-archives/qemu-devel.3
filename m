Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA66CCD183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 01:50:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Zbd-00038N-0T; Thu, 16 Oct 2025 21:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v9Zba-00037z-4m
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 21:50:06 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v9ZbT-00013K-PU
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 21:50:03 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-63bdfd73e6eso4764785a12.0
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 18:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760665797; x=1761270597; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/4S4w7vgrfVuZBfsNDGrnQYcPP5HbD/YZ/o2A90RLqI=;
 b=VcXlpLlQ/RCeUQAwhMfFFcMHJb2L5pUtGO9K26vRUYtmJf5DsjhYS3YcnsXakfBXi2
 YUVaYgtAIIs2zEgkjdVx78A+5UlmGT5lFFko37FcRx8iHUXkf7g34ur83gLo2ByAj+M1
 qHh3ewIbp+/riOo4p1yQ8nsz0dGhEXEQ5eYwGvmCLY6z50tTipdEEcwnMkgSuZddlF4n
 KuiCygI7P/USZdGMOxYufxLZPpow18Fu8D1P9kc1gY8G8s5BZdbLVH3vVlLf7oUJR+1M
 cfag3mePQN9/Iv5LtOCJk1j9dH24iwXRGLEZyaADF0j8qYr62wLjCERnfddzuVBNWd9/
 6jWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760665797; x=1761270597;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/4S4w7vgrfVuZBfsNDGrnQYcPP5HbD/YZ/o2A90RLqI=;
 b=cG4MQbXVL26vhpKc1vJYlj+fvXOEqOpC2foCVIB+R6F6aa+UBnhwZ2zFqLExx2b+AF
 3w+tCLtYZ6EdJnR/it9jZrBYRkBVULQj3PvuH+l1ucptO8W1Xe3nTjmsO85w5pAFPiNc
 gFuTTaudqBmAN0uFz1QLELV3Cia34BT+F0o4EgGVkuAfUv2WqTe0BP0BHbcqqTYJ4kt0
 /5vsgTx4vUixxHqbPysw59gXgK9KIhmeHYt1SfZyae/j5fsdfbPyfcZOhzhu/+BMA/yf
 6Sh/zUVNXySK267ulVTBtx5+bHicOcepPslY8bvEbx4pi2rk2Btt3bqm9iwbauema7Ez
 w4ug==
X-Gm-Message-State: AOJu0YyuRnIK3xbLupeEdQAYMFj+c5U48JxSsudDU5PDPgKD+q01gl8n
 IEfKXyfmylAk/80JxVEyOz/OQVSFvq+CzVIcTjsiEQ7M2bA15A26fn8lmp3vQK0llwCvzZ4wowJ
 dmOhBjCRpc22wrIAyu2QIT+rZVCyZ8IY=
X-Gm-Gg: ASbGncsowCvrXPae3asfAXNob3UIbL+1qbWBTJC9yrQWYFclf2Ats6z4I0pKB2Sa52J
 oYwtry4urlCdJK5UZ3K2S9TP4UU8e3UklilNtRvxg2AOaGyC/utLIefRAOcN5rpwv84rBoXBUXd
 +yCmx3+eSj+LYFO64gGsV3yKAS1w2Lqzh2+co1H7aGhEGpCAputkXBZ8IYnyzJOY9T2z1SR/AFK
 vC6SQDQYvrrhKzPBhUSoiTTe20pjXUSkDg48cH4VskP78LoQYaY9xSP+/PbumfFBTObYOrXOBK3
 SgF0UhI04gqenvIPXefG61L7MA==
X-Google-Smtp-Source: AGHT+IE0/rNw4BRLeKlRkwMEXzGaWumhvr2oF0ObxDw5Dk4Bo5DTAy9OPpq1XIMAKhhVDhHbJNiCqJ91ptcTMl+ciQA=
X-Received: by 2002:a05:6402:5186:b0:639:f648:1093 with SMTP id
 4fb4d7f45d1cf-63c1e1e01c3mr2426806a12.4.1760665796509; Thu, 16 Oct 2025
 18:49:56 -0700 (PDT)
MIME-Version: 1.0
References: <175611702979.27776.8893001401121570723-0@git.sr.ht>
 <175611702979.27776.8893001401121570723-1@git.sr.ht>
In-Reply-To: <175611702979.27776.8893001401121570723-1@git.sr.ht>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 17 Oct 2025 11:49:29 +1000
X-Gm-Features: AS18NWAzBH7tMp-4V4Vjcspt6D1eRCiKKLZn1mp3EaciKRNON-eFAGlwP7HDiAo
Message-ID: <CAKmqyKOoGmNaoHW=wdN0jE-z6c-MJmMNdQfz5aM3XXkDk=T-cQ@mail.gmail.com>
Subject: Re: [PATCH qemu v10 1/1] target/riscv: Add Zilsd and Zclsd extension
 support
To: "~liuxu" <liuxu@nucleisys.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52e.google.com
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

On Mon, Aug 25, 2025 at 8:17=E2=80=AFPM ~liuxu <liuxu@git.sr.ht> wrote:
>
> From: lxx <1733205434@qq.com>
>
> This patch adds support for the Zilsd and Zclsd extension,
> which is documented at https://github.com/riscv/riscv-zilsd/releases/tag/=
v1.0
>
> Signed-off-by: LIU Xu <liuxu@nucleisys.com>
> Co-developed-by: SUN Dongya <sundongya@nucleisys.com>
> Co-developed-by: ZHAO Fujin <zhaofujin@nucleisys.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

This patch fails checkpatch

ERROR: New file 'target/riscv/insn_trans/trans_zilsd.c.inc' requires
'SPDX-License-Identifier'

Can you add a SPDX-License-Identifier

Alistair

> ---
>  target/riscv/cpu.c                        |   4 +
>  target/riscv/cpu_cfg_fields.h.inc         |   2 +
>  target/riscv/insn16.decode                |   8 ++
>  target/riscv/insn32.decode                |  12 ++-
>  target/riscv/insn_trans/trans_zilsd.c.inc | 112 ++++++++++++++++++++++
>  target/riscv/tcg/tcg-cpu.c                |  33 +++++++
>  target/riscv/translate.c                  |   1 +
>  7 files changed, 170 insertions(+), 2 deletions(-)
>  create mode 100644 target/riscv/insn_trans/trans_zilsd.c.inc
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index d055ddf462..78969a5874 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -121,6 +121,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(zihintntl, PRIV_VERSION_1_10_0, ext_zihintntl),
>      ISA_EXT_DATA_ENTRY(zihintpause, PRIV_VERSION_1_10_0, ext_zihintpause=
),
>      ISA_EXT_DATA_ENTRY(zihpm, PRIV_VERSION_1_12_0, ext_zihpm),
> +    ISA_EXT_DATA_ENTRY(zilsd, PRIV_VERSION_1_12_0, ext_zilsd),
>      ISA_EXT_DATA_ENTRY(zimop, PRIV_VERSION_1_13_0, ext_zimop),
>      ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmul),
>      ISA_EXT_DATA_ENTRY(za64rs, PRIV_VERSION_1_12_0, has_priv_1_12),
> @@ -144,6 +145,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(zcmop, PRIV_VERSION_1_13_0, ext_zcmop),
>      ISA_EXT_DATA_ENTRY(zcmp, PRIV_VERSION_1_12_0, ext_zcmp),
>      ISA_EXT_DATA_ENTRY(zcmt, PRIV_VERSION_1_12_0, ext_zcmt),
> +    ISA_EXT_DATA_ENTRY(zclsd, PRIV_VERSION_1_12_0, ext_zclsd),
>      ISA_EXT_DATA_ENTRY(zba, PRIV_VERSION_1_12_0, ext_zba),
>      ISA_EXT_DATA_ENTRY(zbb, PRIV_VERSION_1_12_0, ext_zbb),
>      ISA_EXT_DATA_ENTRY(zbc, PRIV_VERSION_1_12_0, ext_zbc),
> @@ -1291,6 +1293,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[]=
 =3D {
>
>      MULTI_EXT_CFG_BOOL("zicntr", ext_zicntr, true),
>      MULTI_EXT_CFG_BOOL("zihpm", ext_zihpm, true),
> +    MULTI_EXT_CFG_BOOL("zilsd", ext_zilsd, false),
>
>      MULTI_EXT_CFG_BOOL("zba", ext_zba, true),
>      MULTI_EXT_CFG_BOOL("zbb", ext_zbb, true),
> @@ -1330,6 +1333,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[]=
 =3D {
>      MULTI_EXT_CFG_BOOL("zcmp", ext_zcmp, false),
>      MULTI_EXT_CFG_BOOL("zcmt", ext_zcmt, false),
>      MULTI_EXT_CFG_BOOL("zicond", ext_zicond, false),
> +    MULTI_EXT_CFG_BOOL("zclsd", ext_zclsd, false),
>
>      /* Vector cryptography extensions */
>      MULTI_EXT_CFG_BOOL("zvbb", ext_zvbb, false),
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fie=
lds.h.inc
> index e2d116f0df..6c1b523b68 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -19,6 +19,7 @@ BOOL_FIELD(ext_zce)
>  BOOL_FIELD(ext_zcf)
>  BOOL_FIELD(ext_zcmp)
>  BOOL_FIELD(ext_zcmt)
> +BOOL_FIELD(ext_zclsd)
>  BOOL_FIELD(ext_zk)
>  BOOL_FIELD(ext_zkn)
>  BOOL_FIELD(ext_zknd)
> @@ -41,6 +42,7 @@ BOOL_FIELD(ext_zicond)
>  BOOL_FIELD(ext_zihintntl)
>  BOOL_FIELD(ext_zihintpause)
>  BOOL_FIELD(ext_zihpm)
> +BOOL_FIELD(ext_zilsd)
>  BOOL_FIELD(ext_zimop)
>  BOOL_FIELD(ext_zcmop)
>  BOOL_FIELD(ext_ztso)
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
> index cd23b1f3a9..b341832e41 100644
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
> index 0000000000..7bdc303298
> --- /dev/null
> +++ b/target/riscv/insn_trans/trans_zilsd.c.inc
> @@ -0,0 +1,112 @@
> +/*
> + * RISC-V translation routines for the Zilsd & Zclsd Extension.
> + *
> + * Copyright (c) 2025 Nucleisys, Inc.
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
> +    return gen_store_i64(ctx, a);
> +}
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 78fb279184..873d65a92e 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -818,6 +818,19 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu=
, Error **errp)
>          cpu->pmu_avail_ctrs =3D 0;
>      }
>
> +    if (cpu->cfg.ext_zclsd) {
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
> @@ -1081,6 +1094,20 @@ static void cpu_enable_zc_implied_rules(RISCVCPU *=
cpu)
>      }
>  }
>
> +static void cpu_enable_zilsd_implied_rules(RISCVCPU *cpu)
> +{
> +    CPURISCVState *env =3D &cpu->env;
> +
> +    if (cpu->cfg.ext_zilsd && riscv_has_ext(env, RVC)) {
> +        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zclsd), true);
> +    }
> +
> +    if (cpu->cfg.ext_zclsd) {
> +        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zca), true);
> +        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zilsd), true);
> +    }
> +}
> +
>  static void riscv_cpu_enable_implied_rules(RISCVCPU *cpu)
>  {
>      RISCVCPUImpliedExtsRule *rule;
> @@ -1089,6 +1116,9 @@ static void riscv_cpu_enable_implied_rules(RISCVCPU=
 *cpu)
>      /* Enable the implied extensions for Zc. */
>      cpu_enable_zc_implied_rules(cpu);
>
> +    /* Enable the implied extensions for Zilsd. */
> +    cpu_enable_zilsd_implied_rules(cpu);
> +
>      /* Enable the implied MISAs. */
>      for (i =3D 0; (rule =3D riscv_misa_ext_implied_rules[i]); i++) {
>          if (riscv_has_ext(&cpu->env, rule->ext)) {
> @@ -1592,6 +1622,9 @@ static void riscv_init_max_cpu_extensions(Object *o=
bj)
>      isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zcmp), false);
>      isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zcmt), false);
>
> +    isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zilsd), false);
> +    isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zclsd), false);
> +
>      if (env->misa_mxl !=3D MXL_RV32) {
>          isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zcf), false);
>      } else {
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 9ddef2d6e2..62f714034f 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -1200,6 +1200,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase,=
 target_ulong pc)
>  /* Include the auto-generated decoder for 16 bit insn */
>  #include "decode-insn16.c.inc"
>  #include "insn_trans/trans_rvzce.c.inc"
> +#include "insn_trans/trans_zilsd.c.inc"
>  #include "insn_trans/trans_rvzcmop.c.inc"
>  #include "insn_trans/trans_rvzicfiss.c.inc"
>
> --
> 2.49.1

