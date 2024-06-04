Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E31C25B75
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 02:20:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEJmY-0003Ir-NE; Mon, 03 Jun 2024 22:20:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEJmW-0003I0-Gy; Mon, 03 Jun 2024 22:20:12 -0400
Received: from mail-vk1-xa30.google.com ([2607:f8b0:4864:20::a30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEJmU-0008JB-2L; Mon, 03 Jun 2024 22:20:12 -0400
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-4eb1b9865e4so675914e0c.1; 
 Mon, 03 Jun 2024 19:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717467608; x=1718072408; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+lThJhnBBmNFKxHJh8bfIc5pc4E0Of3hJvdr8r7d4uw=;
 b=bkaNTSe3l6IdZoBFiCwJ5UaV7l5CzLiVcrvxoY2UISbZscXYKzye8Ph+aOtYeodt0y
 OqqjBVSnlAMnPxnbqdUhvPJF+2aKw95eMONOA6RnjlMn1ztNBVsyQr/8wCifO9HnLvXn
 AIHsQDJaRl51BOrrOHmKJzV5d0maNu6FqCAxcB9hlEhOyRHLmju6rZXueeG8o5MYJviZ
 VBS9DCNBD453HvOFuJ60TnHXGdjp9HT+zsL+SBY3TMSiBhz+cBnHV67HxBlA/TUlLDlH
 QLQZ6pWErpeAIPjcFhg05SLAEsgH4DT/3HhGV1/r88JQ6p/x8rM6CdQMeqUA8NfV1nPy
 6Mvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717467608; x=1718072408;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+lThJhnBBmNFKxHJh8bfIc5pc4E0Of3hJvdr8r7d4uw=;
 b=SUuEbFS8Vh7ltAp+izfvupWarHbeXVkEPC1V4Ugn/gdFyCigb2VjBYnq8wBC+mhC2D
 sGGETTfF9jYh996ExO0Kqhm/LqX9T9HhVRguRuuIyJuPRJPRzSg4EDIO0L61EGYYec08
 wYQ3YOgcpas4rMxhVgKI6GjJaYPQAg5juUNzGWB+v5MTuNFCcV3SQiskcxYwQUtbhYKL
 7bCO4IZ9Jh8G+OwVi3co4z1gmO8hjw2WEMDysmIJOPAepKmdmCT5GX32tB/0pXkoXRSO
 k6QNylUMrRpg5hj++qVoc2YtxiO3d8XmJNfHqjRI2kJ3u7X27O5f6q1T1mCaP/rvEU6J
 s20Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKeYBW9GYzF/mConz39Pt1AjyrCmkb+oPV6QG1a6czT2/MUTlUbki1dhoFIJ+64K+Tk2/LV6NhQ9EGfsoNh0wTBzChnHQ=
X-Gm-Message-State: AOJu0Yw25fyCieDRvONZoerU1hI4NkPQbXx1Bg6n2veRfHUTy4EKx0My
 yX5xcE5WNxkubbiUNewugJxrAMsSt6z1/jUULOGmyDNf6ZGs2F4/BkNqwaWyXg5723xXGAuS/9L
 AKlFCQLJvOM5RrVcl2vhNHbn0+FU=
X-Google-Smtp-Source: AGHT+IFZBJkbXp//a0KXijvumZcRcwBSSFUcOdklh8zjMuHE5wsj50DWIX7aBZJVkIcxgIWh6PK7Dq2aBIwC2cfalKE=
X-Received: by 2002:a05:6122:d8b:b0:4d1:34a1:c892 with SMTP id
 71dfb90a1353d-4eb02e7ba68mr11071500e0c.13.1717467607007; Mon, 03 Jun 2024
 19:20:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240522062905.1799-1-zhiwei_liu@linux.alibaba.com>
 <20240522062905.1799-2-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240522062905.1799-2-zhiwei_liu@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 4 Jun 2024 12:19:41 +1000
Message-ID: <CAKmqyKNoNcjah6FspUOtd0sdp2E3QtsZxhYRU3kVpgqe2Lo9jQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] target/riscv: Add zimop extension
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 Alistair.Francis@wdc.com, dbarboza@ventanamicro.com, bmeng.cn@gmail.com, 
 iwei1518@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a30;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa30.google.com
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

On Wed, May 22, 2024 at 4:32=E2=80=AFPM LIU Zhiwei <zhiwei_liu@linux.alibab=
a.com> wrote:
>
> Zimop extension defines an encoding space for 40 MOPs.The Zimop
> extension defines 32 MOP instructions named MOP.R.n, where n is
> an integer between 0 and 31, inclusive. The Zimop extension
> additionally defines 8 MOP instructions named MOP.RR.n, where n
> is an integer between 0 and 7.
>
> These 40 MOPs initially are defined to simply write zero to x[rd],
> but are designed to be redefined by later extensions to perform some
> other action.
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c                          |  2 ++
>  target/riscv/cpu_cfg.h                      |  1 +
>  target/riscv/insn32.decode                  | 11 ++++++
>  target/riscv/insn_trans/trans_rvzimop.c.inc | 37 +++++++++++++++++++++
>  target/riscv/translate.c                    |  1 +
>  5 files changed, 52 insertions(+)
>  create mode 100644 target/riscv/insn_trans/trans_rvzimop.c.inc
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index eb1a2e7d6d..c1ac521142 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -175,6 +175,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
>      ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
>      ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
> +    ISA_EXT_DATA_ENTRY(zimop, PRIV_VERSION_1_12_0, ext_zimop),
>      ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
>      ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
>      ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
> @@ -1463,6 +1464,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[]=
 =3D {
>      MULTI_EXT_CFG_BOOL("zicsr", ext_zicsr, true),
>      MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
>      MULTI_EXT_CFG_BOOL("zihintpause", ext_zihintpause, true),
> +    MULTI_EXT_CFG_BOOL("zimop", ext_zimop, false),
>      MULTI_EXT_CFG_BOOL("zacas", ext_zacas, false),
>      MULTI_EXT_CFG_BOOL("zaamo", ext_zaamo, false),
>      MULTI_EXT_CFG_BOOL("zalrsc", ext_zalrsc, false),
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index cb750154bd..b547fbba9d 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -71,6 +71,7 @@ struct RISCVCPUConfig {
>      bool ext_zihintntl;
>      bool ext_zihintpause;
>      bool ext_zihpm;
> +    bool ext_zimop;
>      bool ext_ztso;
>      bool ext_smstateen;
>      bool ext_sstc;
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index f22df04cfd..972a1e8fd1 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -38,6 +38,8 @@
>  %imm_bs   30:2                   !function=3Dex_shift_3
>  %imm_rnum 20:4
>  %imm_z6   26:1 15:5
> +%imm_mop5 30:1 26:2 20:2
> +%imm_mop3 30:1 26:2
>
>  # Argument sets:
>  &empty
> @@ -56,6 +58,8 @@
>  &r2nfvm    vm rd rs1 nf
>  &rnfvm     vm rd rs1 rs2 nf
>  &k_aes     shamt rs2 rs1 rd
> +&mop5 imm rd rs1
> +&mop3 imm rd rs1 rs2
>
>  # Formats 32:
>  @r       .......   ..... ..... ... ..... ....... &r                %rs2 =
%rs1 %rd
> @@ -98,6 +102,9 @@
>  @k_aes   .. ..... ..... .....  ... ..... ....... &k_aes  shamt=3D%imm_bs=
   %rs2 %rs1 %rd
>  @i_aes   .. ..... ..... .....  ... ..... ....... &i      imm=3D%imm_rnum=
        %rs1 %rd
>
> +@mop5 . . .. .. .... .. ..... ... ..... ....... &mop5 imm=3D%imm_mop5 %r=
d %rs1
> +@mop3 . . .. .. . ..... ..... ... ..... ....... &mop3 imm=3D%imm_mop3 %r=
d %rs1 %rs2
> +
>  # Formats 64:
>  @sh5     .......  ..... .....  ... ..... ....... &shift  shamt=3D%sh5   =
   %rs1 %rd
>
> @@ -1010,3 +1017,7 @@ amocas_w    00101 . . ..... ..... 010 ..... 0101111=
 @atom_st
>  amocas_d    00101 . . ..... ..... 011 ..... 0101111 @atom_st
>  # *** RV64 Zacas Standard Extension ***
>  amocas_q    00101 . . ..... ..... 100 ..... 0101111 @atom_st
> +
> +# *** Zimop may-be-operation extension ***
> +mop_r_n     1 . 00 .. 0111 .. ..... 100 ..... 0111011 @mop5
> +mop_rr_n    1 . 00 .. 1 ..... ..... 100 ..... 0111011 @mop3
> diff --git a/target/riscv/insn_trans/trans_rvzimop.c.inc b/target/riscv/i=
nsn_trans/trans_rvzimop.c.inc
> new file mode 100644
> index 0000000000..165aacd2b6
> --- /dev/null
> +++ b/target/riscv/insn_trans/trans_rvzimop.c.inc
> @@ -0,0 +1,37 @@
> +/*
> + * RISC-V translation routines for May-Be-Operation(zimop).
> + *
> + * Copyright (c) 2024 Alibaba Group.
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
> +#define REQUIRE_ZIMOP(ctx) do {           \
> +    if (!ctx->cfg_ptr->ext_zimop) {       \
> +        return false;                     \
> +    }                                     \
> +} while (0)
> +
> +static bool trans_mop_r_n(DisasContext *ctx, arg_mop_r_n *a)
> +{
> +    REQUIRE_ZIMOP(ctx);
> +    gen_set_gpr(ctx, a->rd, ctx->zero);
> +    return true;
> +}
> +
> +static bool trans_mop_rr_n(DisasContext *ctx, arg_mop_rr_n *a)
> +{
> +    REQUIRE_ZIMOP(ctx);
> +    gen_set_gpr(ctx, a->rd, ctx->zero);
> +    return true;
> +}
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 2c27fd4ce1..77c6564834 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -1097,6 +1097,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase,=
 target_ulong pc)
>  #include "insn_trans/trans_rvzacas.c.inc"
>  #include "insn_trans/trans_rvzawrs.c.inc"
>  #include "insn_trans/trans_rvzicbo.c.inc"
> +#include "insn_trans/trans_rvzimop.c.inc"
>  #include "insn_trans/trans_rvzfa.c.inc"
>  #include "insn_trans/trans_rvzfh.c.inc"
>  #include "insn_trans/trans_rvk.c.inc"
> --
> 2.25.1
>
>

