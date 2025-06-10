Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D5EEC5B543
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 11:40:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOxL4-00050I-6N; Tue, 10 Jun 2025 07:40:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uOxKq-0004ob-Ck; Tue, 10 Jun 2025 07:40:10 -0400
Received: from mail-ua1-x936.google.com ([2607:f8b0:4864:20::936])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uOxKk-0000xN-Ts; Tue, 10 Jun 2025 07:40:07 -0400
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-87ed98a23easo499622241.0; 
 Tue, 10 Jun 2025 04:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749555596; x=1750160396; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=87OG/KZXtSwB/Ui4B4IJ22DW84IIJxaiTAJ+SsNqZyk=;
 b=YghkIoHxkUOk/6JsMwKiTnMRdqt4CG/RGtMPVB4hExVop49F9TG8BBBglGHhWtcH6K
 h7/bk9fwD0HdS9SRceKx00yaINEBomoQAeBNjwYlgyVVZkINO++qUOzml3AYecFu4eYu
 nMumn8hER8VK/bjuR9zV4WbzWPT4fFzUgCmS8knyv2xOvSnEJU1uniu9Yg5ym8gzyc30
 s5+VfN33qpAu5Iy3awJ6AcAVBW52GTHi+h4xMXjlP4ZyyLoxh6lY80MYEY0YaOubBRk9
 z9v/K0PZXcb4FdqTqKM/U5y+AX8ciQLsETT0NWdtHBIyAMKUVVPhcKmyiwRorcpnmHWb
 PKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749555596; x=1750160396;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=87OG/KZXtSwB/Ui4B4IJ22DW84IIJxaiTAJ+SsNqZyk=;
 b=hnOljnoNpqYgVEFPROwLx+O2mKgYWb2ZTHktQm4LwID4EPptvCmkaWpKmfGf1fp9xb
 /pQ8SJ+k8shQau5TEbkQhgdek9Pe9WSrCYx4LXmsFStf5RTPIET5LbLwJrM2JRDmt3Tg
 m0mtJGUnXEcdOA5460JWsruMoM/Jm6DDhLSxav6sebmAHeIPzEbEL74Pq3344KoGZ2L9
 P44eJcGgKslXwKhLGfo/hBzhRRf9ya/UY4Afhw5ZJkZdgEcBMrg+/Xh9bkibYndcWiVK
 2L2MEQJgIG/hi4reZ4P+S7+UQ6UCPTI8STJkx0dSryole6+qtO5gP3pHy9KLqJARsTWK
 3zLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkP8VsCu3mOlDZbdxdpsdAWoMPNeUkrQuLxb74GdEENm8Yj8KFcVcc4MwysQmeYf+WPwPLbtVFlbDl@nongnu.org
X-Gm-Message-State: AOJu0YzR7sEARqXzRua5mmMbY/G8Wi4xHrkOPWWZgp0IT8X3M7AIhHnD
 vzU/5J/+z+Ti6Z6xS7lhlFQPvLUoerpQ+9XOD2bSH007F4YK961YhcJACwnYIZsHWYoWYwR0Kpt
 5WYO/48s9gUbJSUr06dNhMHZ9b57Fd4I=
X-Gm-Gg: ASbGncvJdPm4WrMc5WTjhEIMBGCqYJeyf6XhfsNmDmr0Jfub4x91M6dmPN9tq4DvjO9
 omPD5FoFnr/QKpC3sq9DP9g+1UoXFvecf8CXG2orjKkwU3GktrdN9WizHrh/e0LiicfH493Q/si
 BkRQIDctxAzNEz3JfFXaUEsY/TlYCpk8q0Nk4laXV/BJdysSqNfuFoC6xfNbY4TgSyTByY/hQ2k
 w==
X-Google-Smtp-Source: AGHT+IH8rEVMkToIV79xfAdtzZxIq/LtDSL0W8P58MWqNNXtOhjPmx5lhYT0xK4c+5/Bt2IO8NupEIsv0JFLGE7ID00=
X-Received: by 2002:a05:6102:3f94:b0:4c3:64bd:93ba with SMTP id
 ada2fe7eead31-4e772967fbfmr14835593137.11.1749555596469; Tue, 10 Jun 2025
 04:39:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250602131226.1137281-1-djordje.todorovic@htecgroup.com>
 <20250602131226.1137281-6-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250602131226.1137281-6-djordje.todorovic@htecgroup.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 10 Jun 2025 21:39:30 +1000
X-Gm-Features: AX0GCFtm0DvKQd9wY9O3ruXRpZqIe5423p5WH17okZjLSCsBmk6FAw-Dz0bykWk
Message-ID: <CAKmqyKM2X24Bs0NAd3AFofqYnOBrtjnGNan--LaFCBKEq99uQQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] target/riscv: Add mips.ccmov instruction
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, 
 "cfu@mips.com" <cfu@mips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::936;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x936.google.com
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

On Mon, Jun 2, 2025 at 11:13=E2=80=AFPM Djordje Todorovic
<Djordje.Todorovic@htecgroup.com> wrote:
>
> Add mips.ccmov defined by Xmipscmov.
>
> Signed-off-by: Chao-ying Fu <cfu@mips.com>
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> ---
>  target/riscv/cpu.c                        |  3 ++
>  target/riscv/cpu_cfg.h                    |  5 +++
>  target/riscv/cpu_cfg_fields.h.inc         |  1 +
>  target/riscv/insn_trans/trans_xmips.c.inc | 39 +++++++++++++++++++++++
>  target/riscv/meson.build                  |  1 +
>  target/riscv/translate.c                  |  3 ++
>  target/riscv/xmips.decode                 | 11 +++++++
>  7 files changed, 63 insertions(+)
>  create mode 100644 target/riscv/insn_trans/trans_xmips.c.inc
>  create mode 100644 target/riscv/xmips.decode
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index db2ad1c08d..f5234a620a 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -242,6 +242,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(xtheadmempair, PRIV_VERSION_1_11_0, ext_xtheadmem=
pair),
>      ISA_EXT_DATA_ENTRY(xtheadsync, PRIV_VERSION_1_11_0, ext_xtheadsync),
>      ISA_EXT_DATA_ENTRY(xventanacondops, PRIV_VERSION_1_12_0, ext_XVentan=
aCondOps),
> +    ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
>
>      { },
>  };
> @@ -1360,6 +1361,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[=
] =3D {
>      MULTI_EXT_CFG_BOOL("xtheadmempair", ext_xtheadmempair, false),
>      MULTI_EXT_CFG_BOOL("xtheadsync", ext_xtheadsync, false),
>      MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
> +    MULTI_EXT_CFG_BOOL("xmipscmov", ext_xmipscmov, false),
>
>      { },
>  };
> @@ -3180,6 +3182,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>          .cfg.pmp =3D true,
>          .cfg.ext_zba =3D true,
>          .cfg.ext_zbb =3D true,
> +        .cfg.ext_xmipscmov =3D true,
>          .cfg.marchid =3D 0x8000000000000201,
>  #ifndef CONFIG_USER_ONLY
>          .custom_csrs =3D mips_csr_list,
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index aa28dc8d7e..2db471ad17 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -36,6 +36,11 @@ static inline bool always_true_p(const RISCVCPUConfig =
*cfg __attribute__((__unus
>      return true;
>  }
>
> +static inline bool has_xmips_p(const RISCVCPUConfig *cfg)
> +{
> +    return cfg->ext_xmipscmov;
> +}
> +
>  static inline bool has_xthead_p(const RISCVCPUConfig *cfg)
>  {
>      return cfg->ext_xtheadba || cfg->ext_xtheadbb ||
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fie=
lds.h.inc
> index 59f134a419..baedf0c466 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -145,6 +145,7 @@ BOOL_FIELD(ext_xtheadmemidx)
>  BOOL_FIELD(ext_xtheadmempair)
>  BOOL_FIELD(ext_xtheadsync)
>  BOOL_FIELD(ext_XVentanaCondOps)
> +BOOL_FIELD(ext_xmipscmov)
>
>  BOOL_FIELD(mmu)
>  BOOL_FIELD(pmp)
> diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/ins=
n_trans/trans_xmips.c.inc
> new file mode 100644
> index 0000000000..5437148af1
> --- /dev/null
> +++ b/target/riscv/insn_trans/trans_xmips.c.inc
> @@ -0,0 +1,39 @@
> +/*
> + * RISC-V translation routines for the MIPS extensions (xmips*).

Can you include links to documentation here

Alistair

> + *
> + * Copyright (c) 2025 MIPS
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2.1 or later, as published by the Free Software Foundation.
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
> +#define REQUIRE_XMIPSCMOV(ctx) do {              \
> +    if (!ctx->cfg_ptr->ext_xmipscmov) {          \
> +        return false;                            \
> +    }                                            \
> +} while (0)
> +
> +static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
> +{
> +    REQUIRE_XMIPSCMOV(ctx);
> +
> +    TCGv zero, source1, source2, source3;
> +    zero =3D tcg_constant_tl(0);
> +    source1 =3D get_gpr(ctx, a->rs1, EXT_NONE);
> +    source2 =3D get_gpr(ctx, a->rs2, EXT_NONE);
> +    source3 =3D get_gpr(ctx, a->rs3, EXT_NONE);
> +
> +    tcg_gen_movcond_tl(TCG_COND_NE, cpu_gpr[a->rd],
> +                       source2, zero, source1, source3);
> +
> +    return true;
> +}
> diff --git a/target/riscv/meson.build b/target/riscv/meson.build
> index fbb6c8fb45..26cd11ec00 100644
> --- a/target/riscv/meson.build
> +++ b/target/riscv/meson.build
> @@ -4,6 +4,7 @@ gen =3D [
>    decodetree.process('insn32.decode', extra_args: '--static-decode=3Ddec=
ode_insn32'),
>    decodetree.process('xthead.decode', extra_args: '--static-decode=3Ddec=
ode_xthead'),
>    decodetree.process('XVentanaCondOps.decode', extra_args: '--static-dec=
ode=3Ddecode_XVentanaCodeOps'),
> +  decodetree.process('xmips.decode', extra_args: '--static-decode=3Ddeco=
de_xmips'),
>  ]
>
>  riscv_ss =3D ss.source_set()
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 2cba1a26a7..a550599e6d 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -1194,8 +1194,10 @@ static uint32_t opcode_at(DisasContextBase *dcbase=
, target_ulong pc)
>  #include "insn_trans/trans_svinval.c.inc"
>  #include "insn_trans/trans_rvbf16.c.inc"
>  #include "decode-xthead.c.inc"
> +#include "decode-xmips.c.inc"
>  #include "insn_trans/trans_xthead.c.inc"
>  #include "insn_trans/trans_xventanacondops.c.inc"
> +#include "insn_trans/trans_xmips.c.inc"
>
>  /* Include the auto-generated decoder for 16 bit insn */
>  #include "decode-insn16.c.inc"
> @@ -1211,6 +1213,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase,=
 target_ulong pc)
>
>  const RISCVDecoder decoder_table[] =3D {
>      { always_true_p, decode_insn32 },
> +    { has_xmips_p, decode_xmips},
>      { has_xthead_p, decode_xthead},
>      { has_XVentanaCondOps_p, decode_XVentanaCodeOps},
>  };
> diff --git a/target/riscv/xmips.decode b/target/riscv/xmips.decode
> new file mode 100644
> index 0000000000..cb334fa4bd
> --- /dev/null
> +++ b/target/riscv/xmips.decode
> @@ -0,0 +1,11 @@
> +#
> +# RISC-V translation routines for the MIPS extension
> +#
> +# Copyright (c) 2025 MIPS
> +#
> +# SPDX-License-Identifier: LGPL-2.1-or-later
> +#
> +# Reference: MIPS P8700 instructions
> +#            (https://mips.com/products/hardware/p8700/)
> +
> +ccmov          rs3:5 11 rs2:5 rs1:5 011 rd:5 0001011
> --
> 2.34.1
>

