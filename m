Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D7D4C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 18:04:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNFwg-0006wI-8i; Fri, 28 Jun 2024 14:03:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sNFwZ-0006qD-HK
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 14:03:35 -0400
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sNFwW-0002CB-7T
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 14:03:31 -0400
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e02bda4aba3so870569276.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 11:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719597807; x=1720202607;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nT+FZp/0PjSs70enrKdEajFzayeXnB0jDdwy63tZ64k=;
 b=YGUH32HqZ1GBAWSm1RdbAaWU5NbuT3hw73s5YNUckfDl8rNPdeLKgFcO3PB8D279Js
 Cec7p2fTvLoKcJAzhpBBcLVff4qCXoe5YX0jzor4WHnf9ieNIrx+SUnC+K1XJlVDmINU
 QJwwDSdagFI+SICHl70u2SgW7xeMg3eUGVIygWVLYhIY7tZzvfSOmhYIgflZqk2zRtlZ
 nYR+kXbtW/VcEn3xMzzcDzDeg4RXWHRH4vi90Q4nZR4EARGcwhkb2HdKzkcheFaVfvNq
 +7fka/ZGzLIUYW5W5mKEPUX2R7j3Iy5goC6lEZlEbIR7jbq1de7ziy2S3jMo5yc09FQ6
 t/nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719597807; x=1720202607;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nT+FZp/0PjSs70enrKdEajFzayeXnB0jDdwy63tZ64k=;
 b=M1xlRw4zy8Ts7mVKmfkXnFwJWTwfpEHZSKktoK+GPeSN4KrImjkOrq7wpkNRMcZbAg
 avAku5VV2S+/SQsa240J7GQ+uVY/49Ft5vcoKDiSUck11vv5QrMfgXVwUP3vliXBbclh
 ci1cgHz0GpxEEqJsoGxy9/lRpalmaRqhsqEnUXHLEV8O10XX1QPLFLSADkDg0sEEPa9s
 Fu7fw+jnsUgMdpXz59mLKWjgd74I3fwFQ0aU3pMVjHgN4NEK3i/g/aavAndzUYDhZ79c
 dp/1NaijJaHtaiziRFse+Sxk0pYdjdbcrmI5XvxaXsvdC2rJ1qW9h7QeSIiLmg+utgif
 D6Rg==
X-Gm-Message-State: AOJu0YxpGnMv/ZzQy2YuZWeXrMdrysJDo2ruRtvN61MK3Np7dND59JU7
 LL8H9lw9XrVUbZTYQ7f6jaYVxySV3sx5qWiSfB928/QROKjaZ7/ffh8ALYI6FuaXbkN5GSvHvDn
 ZqlZrgiJIR6NFkqoryHNxfVnPvorWWLP1dXC1ERoLE4XZULoZsYI=
X-Google-Smtp-Source: AGHT+IGH0KFWKDwGEFSleWEr+9D6BLEW+L3DQ05xqodqWoAWE1HNuDW2nPk8cjfdHE95d8P3X/eWaXscLOggOWsrpMs=
X-Received: by 2002:a25:8709:0:b0:e03:4575:78d7 with SMTP id
 3f1490d57ef6-e0345757a96mr6485605276.55.1719597806863; Fri, 28 Jun 2024
 11:03:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240628175030.595936-1-debug@rivosinc.com>
In-Reply-To: <20240628175030.595936-1-debug@rivosinc.com>
From: Deepak Gupta <debug@rivosinc.com>
Date: Fri, 28 Jun 2024 11:03:14 -0700
Message-ID: <CAKC1njR9iEb_BQPs3-Wsh4L9HJ-YawRXeHXix7dQoyk52XPJAg@mail.gmail.com>
Subject: Re: [PATCH 1/3] target/riscv: zimop and zcmop extension for riscv
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b32;
 envelope-from=debug@rivosinc.com; helo=mail-yb1-xb32.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Please ignore this one.
Wrong command and all patches came out as one.
Sorry about that.

On Fri, Jun 28, 2024 at 10:50=E2=80=AFAM Deepak Gupta <debug@rivosinc.com> =
wrote:
>
> `zimop` stands for `may be operations`. `zcmop` stands for compressed
> `may be operations`. For some RISC-V CPU extension, once compiled into
> the binary are part of generated code which can't be gated behind a probe
> of whether an instruction set is supported or not. One such example is
> `zicfiss` [1] extension where `shadow stack push` and `shadow stack pop
> and check` will be part of every function body. Thus binaries compiled
> with such extensions need to run in following scenarios
>
>     - On machines where extension is present and enabled
>     - On machines where extension is present and disabled
>     - On machines where extension is not present/implemented.
>
> `zimop` (for 32bit instructions) and `zcmop` (for compressed) were devise=
d
> and defined [2] to support such future (like zicfiss) CPU extensions
> where zimops and zcmops provide a base non-faulting behavior for
> codepoints that may claimed by future ISA extensions. Minimally, any
> CPU implementation wanting to have binary compatibility with such
> binaries only has to implement `zimop and zcmop`. Furthermore, this
> allows per-task optin for software where user has the option to enable
> the feature on per-task basis.
>
> `zimop` are defined to write zero to `rd`. `zcmop` are defined to *not* w=
rite
> to any register.
>
> [1] - https://github.com/riscv/riscv-cfi/blob/main/src/cfi_backward.adoc
> [2] - https://github.com/riscv/riscv-isa-manual/blob/main/src/zimop.adoc
>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>  target/riscv/cpu.c     | 2 ++
>  target/riscv/cpu_cfg.h | 1 +
>  2 files changed, 3 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index eb1a2e7d6d..3caf8553d1 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -113,6 +113,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(zihintntl, PRIV_VERSION_1_10_0, ext_zihintntl),
>      ISA_EXT_DATA_ENTRY(zihintpause, PRIV_VERSION_1_10_0, ext_zihintpause=
),
>      ISA_EXT_DATA_ENTRY(zihpm, PRIV_VERSION_1_12_0, ext_zihpm),
> +    ISA_EXT_DATA_ENTRY(zimops, PRIV_VERSION_1_12_0, ext_zimops),
>      ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmul),
>      ISA_EXT_DATA_ENTRY(za64rs, PRIV_VERSION_1_12_0, has_priv_1_11),
>      ISA_EXT_DATA_ENTRY(zaamo, PRIV_VERSION_1_12_0, ext_zaamo),
> @@ -2273,6 +2274,7 @@ static Property riscv_cpu_properties[] =3D {
>       * it with -x and default to 'false'.
>       */
>      DEFINE_PROP_BOOL("x-misa-w", RISCVCPU, cfg.misa_w, false),
> +    DEFINE_PROP_BOOL("zimops", RISCVCPU, cfg.ext_zimops, true),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index cb750154bd..5c42ff8cdf 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -124,6 +124,7 @@ struct RISCVCPUConfig {
>      uint32_t mvendorid;
>      uint64_t marchid;
>      uint64_t mimpid;
> +    bool ext_zimops;
>
>      /* Named features  */
>      bool ext_svade;
> --
> 2.34.1
>
>
> From 4d15b0e0037f444eb75e60b398e19dcf476f07d4 Mon Sep 17 00:00:00 2001
> From: Deepak Gupta <debug@rivosinc.com>
> Date: Fri, 28 Jun 2024 00:13:58 -0700
> Subject: [PATCH 2/3] target/riscv: zimop instruction encoding and its
>  implementation
>
> This patch adds assigned codepoints for decoder for 32bit instructions
> and provide implementation for instruction. If extension is present,
> then moves 0 to `rd`.
>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>  target/riscv/insn32.decode                 | 15 +++++++
>  target/riscv/insn_trans/trans_zimops.c.inc | 50 ++++++++++++++++++++++
>  target/riscv/translate.c                   |  3 ++
>  3 files changed, 68 insertions(+)
>  create mode 100644 target/riscv/insn_trans/trans_zimops.c.inc
>
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index f22df04cfd..fca3838a9f 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -167,6 +167,21 @@ csrrwi   ............     ..... 101 ..... 1110011 @c=
sr
>  csrrsi   ............     ..... 110 ..... 1110011 @csr
>  csrrci   ............     ..... 111 ..... 1110011 @csr
>
> +# zimops (unpriv integer may be operations) instructions with system opc=
ode
> +# zimops_r and zimops_rr are two code points assigned to zimops
> +# Any new extension that claims zimops encoding should be placed above m=
op.r
> +# and mop.rr
> +
> +# mop.r
> +{
> +  zimops_r   1-00--0 111--     ----- 100 ..... 1110011 %rd
> +}
> +
> +# mop.rr
> +{
> +  zimops_rr  1-00--1 -----     ----- 100 ..... 1110011 %rd
> +}
> +
>  # *** RV64I Base Instruction Set (in addition to RV32I) ***
>  lwu      ............   ..... 110 ..... 0000011 @i
>  ld       ............   ..... 011 ..... 0000011 @i
> diff --git a/target/riscv/insn_trans/trans_zimops.c.inc b/target/riscv/in=
sn_trans/trans_zimops.c.inc
> new file mode 100644
> index 0000000000..b5ad7bded8
> --- /dev/null
> +++ b/target/riscv/insn_trans/trans_zimops.c.inc
> @@ -0,0 +1,50 @@
> +/*
> + * RISC-V translation routines for the Control-Flow Integrity Extension
> + *
> + * Copyright (c) 2024 Rivos Inc.
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
> +static bool trans_zimops_r(DisasContext *ctx, arg_zimops_r * a)
> +{
> +    /* zimops not implemented, raise illegal instruction & return true *=
/
> +    if (!ctx->cfg_ptr->ext_zimops) {
> +        gen_exception_illegal(ctx);
> +        return true;
> +    }
> +    /*
> +     * zimops implemented, simply grab destination and mov zero.
> +     * return true
> +     */
> +    TCGv dest =3D dest_gpr(ctx, a->rd);
> +    dest =3D tcg_constant_tl(0);
> +    gen_set_gpr(ctx, a->rd, dest);
> +    return true;
> +}
> +
> +static bool trans_zimops_rr(DisasContext *ctx, arg_zimops_r * a)
> +{
> +    /* zimops not implemented, raise illegal instruction & return true *=
/
> +    if (!ctx->cfg_ptr->ext_zimops) {
> +        gen_exception_illegal(ctx);
> +        return true;
> +    }
> +    /*
> +     * zimops implemented, simply grab destination and mov zero.
> +     * return true
> +     */
> +    TCGv dest =3D dest_gpr(ctx, a->rd);
> +    dest =3D tcg_constant_tl(0);
> +    gen_set_gpr(ctx, a->rd, dest);
> +    return true;
> +}
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 2c27fd4ce1..b7fd3456c8 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -1115,6 +1115,9 @@ static uint32_t opcode_at(DisasContextBase *dcbase,=
 target_ulong pc)
>  /* Include decoders for factored-out extensions */
>  #include "decode-XVentanaCondOps.c.inc"
>
> +/* Include decoder for zimop */
> +#include "insn_trans/trans_zimops.c.inc"
> +
>  /* The specification allows for longer insns, but not supported by qemu.=
 */
>  #define MAX_INSN_LEN  4
>
> --
> 2.34.1
>
>
> From dc5d2c62475ac7a9cf42b9ed1398961505b8b91d Mon Sep 17 00:00:00 2001
> From: Deepak Gupta <debug@rivosinc.com>
> Date: Tue, 2 Jan 2024 15:46:13 -0800
> Subject: [PATCH 3/3] target/riscv: Introduce `compressed zimop` aka `zcmo=
p`
>
> Analogous to zimop, there are 8 encodings carved out of illegal space
> encodings (c.lui xn, 0) in compressed instructions which are defined
> to be zcmops short for compressed may be operations.
>
> Unlike zimops (which write 0 to rd), zcmops don't actually write anything
> to any register. Their encodings allow future extensions to define them t=
o
> read register x[n].
>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>  target/riscv/insn16.decode                 |  6 ++++++
>  target/riscv/insn_trans/trans_zimops.c.inc | 11 +++++++++++
>  2 files changed, 17 insertions(+)
>
> diff --git a/target/riscv/insn16.decode b/target/riscv/insn16.decode
> index b96c534e73..d24b54d319 100644
> --- a/target/riscv/insn16.decode
> +++ b/target/riscv/insn16.decode
> @@ -32,6 +32,7 @@
>  %uimm_cl_w     5:1 10:3 6:1       !function=3Dex_shift_2
>  %imm_cb        12:s1 5:2 2:1 10:2 3:2 !function=3Dex_shift_1
>  %imm_cj        12:s1 8:1 9:2 6:1 7:1 2:1 11:1 3:3 !function=3Dex_shift_1
> +%zcmop_n       8:3
>
>  %shlimm_6bit  12:1 2:5               !function=3Dex_rvc_shiftli
>  %shrimm_6bit  12:1 2:5               !function=3Dex_rvc_shiftri
> @@ -66,6 +67,8 @@
>  &cmpp      urlist spimm
>  &cmjt      index
>
> +&cmop      zcmop_n
> +
>  # Formats 16:
>  @cr        ....  ..... .....  .. &r      rs2=3D%rs2_5       rs1=3D%rd   =
  %rd
>  @ci        ... . ..... .....  .. &i      imm=3D%imm_ci      rs1=3D%rd   =
  %rd
> @@ -109,6 +112,8 @@
>  @cm_mv        ... ...  ... .. ... ..  &r2_s  rs2=3D%r2s     rs1=3D%r1s
>  @cm_jt        ... ...  ........   ..  &cmjt  %index
>
> +@c_mop        ... . .....  ..... ..  &cmop %zcmop_n
> +
>  # *** RV32/64C Standard Extension (Quadrant 0) ***
>  {
>    # Opcode of all zeros is illegal; rd !=3D 0, nzuimm =3D=3D 0 is reserv=
ed.
> @@ -140,6 +145,7 @@ sw                110  ... ... .. ... 00 @cs_w
>  addi              000 .  .....  ..... 01 @ci
>  addi              010 .  .....  ..... 01 @c_li
>  {
> +  zcmops          011 0  0...1  00000 01 @c_mop # zcmop carving out of i=
llegal c.lui xn,0 space
>    illegal         011 0  -----  00000 01 # c.addi16sp and c.lui, RES nzi=
mm=3D0
>    addi            011 .  00010  ..... 01 @c_addi16sp
>    lui             011 .  .....  ..... 01 @c_lui
> diff --git a/target/riscv/insn_trans/trans_zimops.c.inc b/target/riscv/in=
sn_trans/trans_zimops.c.inc
> index b5ad7bded8..99f25bd9ea 100644
> --- a/target/riscv/insn_trans/trans_zimops.c.inc
> +++ b/target/riscv/insn_trans/trans_zimops.c.inc
> @@ -48,3 +48,14 @@ static bool trans_zimops_rr(DisasContext *ctx, arg_zim=
ops_r * a)
>      gen_set_gpr(ctx, a->rd, dest);
>      return true;
>  }
> +
> +static bool trans_zcmops(DisasContext *ctx, arg_zcmops * a)
> +{
> +    /* zimops not implemented, return false */
> +    if (!ctx->cfg_ptr->ext_zimops) {
> +        gen_exception_illegal(ctx);
> +        return false;
> +    }
> +
> +    return true;
> +}
> --
> 2.34.1
>

