Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA472C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 06:24:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLyWm-00052C-MW; Mon, 02 Jun 2025 02:20:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uLyAR-0003yJ-7z; Mon, 02 Jun 2025 01:57:25 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uLyA7-0000oj-Cy; Mon, 02 Jun 2025 01:56:52 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7311a8bb581so3581121a34.0; 
 Sun, 01 Jun 2025 22:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748843787; x=1749448587; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9glQojxFjNmGVd7GNMX0wnS0mm/d6gRhrUQaPYfDvJg=;
 b=UL9IqjbQhqYBmNcvFiKqf/b7nTcEnKhljkggQF2d/U081ceC4EOQmWyzV7JeIZyzVX
 KB3i/Yd3na7rYTmu4SLSS4T1Fpak98JpiTGnuXxLPg/w8/MUWUTV8HWbrL36rzGDEi//
 dEqHh3oeLitHnlN6jBwQs3J+m8dkXl9y0dXWpoujRr45c3ZERiDdlnDXwPK10fHsCEj9
 2zzj7FztK88Yb9iHgClbdg0/k+d803QLKYdrCE7PaGsSNYL1kQ2NkkPNG2J1pHgsUJ9d
 wIFJgf9qnPYq3vR2bRTykRPWM4VWwShMcZ6I3cwmh6u7g5b6i5ZsoXmfBf7yaUO01Ec5
 drkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748843787; x=1749448587;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9glQojxFjNmGVd7GNMX0wnS0mm/d6gRhrUQaPYfDvJg=;
 b=GcRE38ascgCIiZWPVnyrMTCk5BNP495abhtcH/AnjB5Uuh4kp3ss+WPq6crXKNmAZQ
 3w3l4CtfMk/Jg48AXLV28vKG+blJR42jFEF3S7ea6OzSWZJRuEZuFpF+jJBGeOoBGqft
 HUsYd6F4PNnbEUtk2a60w5ouLWtZz16/RUDa5s3Q9fqTdRvPzwE9JQVt8ygsVe6JW+OB
 VQyjbQMbBDxwo3ejaTpgiLH97eSgeyX6wfX7cXxMWMU2OK7eQIN4CMPus/j241VP5lHS
 pP5Oqy5tzanhD5U53nocQCyv7Lkd9UemUVQZPL8l7ivpwEflRaakszToHFH++h85O++z
 pS5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXz5VUrMrHAaquaGYbPr0PS9kQPbQatSR9hGdR/7cleChX4Rkc//3Bt6JV/N8HuNHLYpRddUuFCQAd/@nongnu.org
X-Gm-Message-State: AOJu0YwxXtHOpk5VXVIJ0puRbwNikTrYSynNj0o0RvLSvBvAS/T0zrfM
 Jo2ieyNa4jQyLSFfvRCk1G3CpEg7eH7Gb2WTB8NZ+zOQTpjXS3T3xuSc5ke/L5UpiRIs1Ou1y3C
 kq3Pk8bW249h7XypvujnE37+3uO5cejteIg==
X-Gm-Gg: ASbGnctNNU9893wMPOVsTiMYdwFdWKzA4K4CWMLzvo4Dn7m5/grQk1FTf0RofSN9JnX
 YvGUI70A+6CfunqFdo5WAlHHy4KmI6HeEkTbuImcdvWVqPdUy/jiR51eHuRX/TC/VlVsOkIx8Wa
 36JjC7OMB6Hb5NJcowg8IsF44Zk/552flEHxlZKYIurKq1sAfqAQPpyzHYZE/zScsciZJYHFD1O
 w==
X-Google-Smtp-Source: AGHT+IHPWdm7nOP6tUsaI3L30yPkbZDP26s1SUnZVIcOZYG9Nn0paK5OeBEyDobtEMy97J21ruF7TRzbAWjepoNL64k=
X-Received: by 2002:a05:6102:3749:b0:4e5:93f5:e836 with SMTP id
 ada2fe7eead31-4e701ccf6e0mr3554072137.25.1748841854561; Sun, 01 Jun 2025
 22:24:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250521091921.180094-1-roan.richmond@codethink.co.uk>
 <20250521091921.180094-2-roan.richmond@codethink.co.uk>
In-Reply-To: <20250521091921.180094-2-roan.richmond@codethink.co.uk>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 2 Jun 2025 15:23:48 +1000
X-Gm-Features: AX0GCFs0ghvxvMgu8YziqnZwG5Euk93jS0PjKNsSQ6FWAu92wNyA7J-ApVG9Tg4
Message-ID: <CAKmqyKOXRN0Ub-RjQkptdzzqW46pe=c9ZJNRZX=OALZcvVUcTA@mail.gmail.com>
Subject: Re: [PATCH 1/1] Add RISCV ZALASR extension
To: Roan Richmond <roan.richmond@codethink.co.uk>
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=alistair23@gmail.com; helo=mail-ot1-x32c.google.com
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

On Wed, May 21, 2025 at 7:21=E2=80=AFPM Roan Richmond
<roan.richmond@codethink.co.uk> wrote:
>

Can you include in the commit message which exact version (please
include a link) of the spec this targets. We need exact versions as
RISC-V will often release multiple conflicting "final" versions, so
it's good to have a record of what this was written to support.

> Signed-off-by: Roan Richmond <roan.richmond@codethink.co.uk>
> ---
>  target/riscv/cpu.c                           |   1 +
>  target/riscv/cpu_cfg.h                       |   1 +
>  target/riscv/insn32.decode                   |  10 ++
>  target/riscv/insn_trans/trans_rvzalasr.c.inc | 109 +++++++++++++++++++
>  target/riscv/translate.c                     |   1 +
>  5 files changed, 122 insertions(+)
>  create mode 100644 target/riscv/insn_trans/trans_rvzalasr.c.inc
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index d92874baa0..630911a289 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -121,6 +121,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(zabha, PRIV_VERSION_1_13_0, ext_zabha),
>      ISA_EXT_DATA_ENTRY(zacas, PRIV_VERSION_1_12_0, ext_zacas),
>      ISA_EXT_DATA_ENTRY(zama16b, PRIV_VERSION_1_13_0, ext_zama16b),
> +    ISA_EXT_DATA_ENTRY(zalasr, PRIV_VERSION_1_12_0, ext_zalasr),
>      ISA_EXT_DATA_ENTRY(zalrsc, PRIV_VERSION_1_12_0, ext_zalrsc),
>      ISA_EXT_DATA_ENTRY(zawrs, PRIV_VERSION_1_12_0, ext_zawrs),
>      ISA_EXT_DATA_ENTRY(zfa, PRIV_VERSION_1_12_0, ext_zfa),
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index cfe371b829..da23771899 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -96,6 +96,7 @@ struct RISCVCPUConfig {
>      bool ext_zacas;
>      bool ext_zama16b;
>      bool ext_zabha;
> +    bool ext_zalasr;
>      bool ext_zalrsc;
>      bool ext_zawrs;
>      bool ext_zfa;
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index cd23b1f3a9..c848c0c1c5 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -1066,3 +1066,13 @@ amominu_h  11000 . . ..... ..... 001 ..... 0101111=
 @atom_st
>  amomaxu_h  11100 . . ..... ..... 001 ..... 0101111 @atom_st
>  amocas_b    00101 . . ..... ..... 000 ..... 0101111 @atom_st
>  amocas_h    00101 . . ..... ..... 001 ..... 0101111 @atom_st
> +
> +# *** Zalasr Standard Extension ***
> +lb_aqrl  00110 . . ..... ..... 000 ..... 0101111 @atom_st
> +lh_aqrl  00110 . . ..... ..... 001 ..... 0101111 @atom_st
> +lw_aqrl  00110 . . ..... ..... 010 ..... 0101111 @atom_st
> +ld_aqrl  00110 . . ..... ..... 011 ..... 0101111 @atom_st
> +sb_aqrl  00111 . . ..... ..... 000 ..... 0101111 @atom_st
> +sh_aqrl  00111 . . ..... ..... 001 ..... 0101111 @atom_st
> +sw_aqrl  00111 . . ..... ..... 010 ..... 0101111 @atom_st
> +sd_aqrl  00111 . . ..... ..... 011 ..... 0101111 @atom_st
> diff --git a/target/riscv/insn_trans/trans_rvzalasr.c.inc b/target/riscv/=
insn_trans/trans_rvzalasr.c.inc
> new file mode 100644
> index 0000000000..7c39dd895c
> --- /dev/null
> +++ b/target/riscv/insn_trans/trans_rvzalasr.c.inc
> @@ -0,0 +1,109 @@
> +/*
> + * RISC-V translation routines for the ZALASR (Load-Aquire and Store-Rel=
ease)
> + * Extension.
> + *
> + * Copyright (c) 2025 Roan Richmond, roan.richmond@codethink.co.uk
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
> +#define REQUIRE_ZALASR(ctx) do {     \
> +    if (!ctx->cfg_ptr->ext_zalasr) { \
> +        return false;                \
> +    }                                \
> +} while (0)
> +
> +static bool gen_load_acquire(DisasContext *ctx, arg_lb_aqrl *a, MemOp me=
mop)
> +{
> +    decode_save_opc(ctx, 0);
> +
> +    TCGv addr =3D get_address(ctx, a->rs1, 0);
> +    TCGv dest =3D get_gpr(ctx, a->rd, EXT_NONE);
> +    TCGBar bar =3D (a->rl) ? TCG_BAR_STRL : 0;
> +
> +    memop |=3D (ctx->cfg_ptr->ext_zama16b) ? MO_ATOM_WITHIN16 : 0;
> +
> +    tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, memop);
> +    gen_set_gpr(ctx, a->rd, dest);
> +
> +    /* Add a memory barrier implied by AQ (mandatory) and RL (optional) =
*/
> +    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ | bar);
> +
> +    return true;
> +}
> +
> +static bool trans_lb_aqrl(DisasContext *ctx, arg_lb_aqrl *a)
> +{
> +    REQUIRE_ZALASR(ctx);
> +    return gen_load_acquire(ctx, a, (MO_ALIGN | MO_SB));
> +}
> +
> +static bool trans_lh_aqrl(DisasContext *ctx, arg_lh_aqrl *a)
> +{
> +    REQUIRE_ZALASR(ctx);
> +    return gen_load_acquire(ctx, a, (MO_ALIGN | MO_TESW));
> +}
> +
> +static bool trans_lw_aqrl(DisasContext *ctx, arg_lw_aqrl *a)
> +{
> +    REQUIRE_ZALASR(ctx);
> +    return gen_load_acquire(ctx, a, (MO_ALIGN | MO_TESL));
> +}
> +
> +static bool trans_ld_aqrl(DisasContext *ctx, arg_ld_aqrl *a)
> +{
> +    REQUIRE_ZALASR(ctx);

There should be a RV64 check here

> +    return gen_load_acquire(ctx, a, (MO_ALIGN | MO_TEUQ));
> +}
> +
> +static bool gen_store_release(DisasContext *ctx, arg_sb_aqrl *a, MemOp m=
emop)
> +{
> +    decode_save_opc(ctx, 0);
> +
> +    TCGv addr =3D get_address(ctx, a->rs1, 0);
> +    TCGv data =3D get_gpr(ctx, a->rs2, EXT_NONE);
> +    TCGBar bar =3D (a->aq) ? TCG_BAR_LDAQ : 0;

Aren't you missing a check to ensure RL is set?

Alistair

> +
> +    memop |=3D (ctx->cfg_ptr->ext_zama16b) ? MO_ATOM_WITHIN16 : 0;
> +
> +    /* Add a memory barrier implied by RL (mandatory) and AQ (optional) =
*/
> +    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL | bar);
> +
> +    tcg_gen_qemu_st_tl(data, addr, ctx->mem_idx, memop);
> +    return true;
> +}
> +
> +static bool trans_sb_aqrl(DisasContext *ctx, arg_sb_aqrl *a)
> +{
> +    REQUIRE_ZALASR(ctx);
> +    return gen_store_release(ctx, a, (MO_ALIGN | MO_SB));
> +}
> +
> +static bool trans_sh_aqrl(DisasContext *ctx, arg_sh_aqrl *a)
> +{
> +    REQUIRE_ZALASR(ctx);
> +    return gen_store_release(ctx, a, (MO_ALIGN | MO_TESW));
> +}
> +
> +static bool trans_sw_aqrl(DisasContext *ctx, arg_sw_aqrl *a)
> +{
> +    REQUIRE_ZALASR(ctx);
> +    return gen_store_release(ctx, a, (MO_ALIGN | MO_TESL));
> +}
> +
> +static bool trans_sd_aqrl(DisasContext *ctx, arg_sd_aqrl *a)
> +{
> +    REQUIRE_64BIT(ctx);
> +    REQUIRE_ZALASR(ctx);
> +    return gen_store_release(ctx, a, (MO_ALIGN | MO_TEUQ));
> +}
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 0d4f7d601c..558ea0646a 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -1183,6 +1183,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase,=
 target_ulong pc)
>  #include "insn_trans/trans_rvzicond.c.inc"
>  #include "insn_trans/trans_rvzacas.c.inc"
>  #include "insn_trans/trans_rvzabha.c.inc"
> +#include "insn_trans/trans_rvzalasr.c.inc"
>  #include "insn_trans/trans_rvzawrs.c.inc"
>  #include "insn_trans/trans_rvzicbo.c.inc"
>  #include "insn_trans/trans_rvzimop.c.inc"
> --
> 2.43.0
>
>

