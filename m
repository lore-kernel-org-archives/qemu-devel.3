Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41EF1C25B75
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 02:24:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEJq5-0004xK-8b; Mon, 03 Jun 2024 22:23:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEJq4-0004x5-NT; Mon, 03 Jun 2024 22:23:52 -0400
Received: from mail-ua1-x934.google.com ([2607:f8b0:4864:20::934])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEJq2-0002Zb-JX; Mon, 03 Jun 2024 22:23:52 -0400
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-804efaaae87so193611241.0; 
 Mon, 03 Jun 2024 19:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717467829; x=1718072629; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8OX5d/4fRV+AvT5dBEYpRjGHWr5fI0WlQMWxSj5t0Tw=;
 b=OC7pf3t4ggTndPhGcjWRtXNLi8fh5v8mlDlEoDEpPb97GtsIjFzA2ouONZ2t1bLXjF
 UvIXgauDtNgCY5zqsk4RKOxntslRqDv348o2Uqlf9KSrpGf42CsW1yBs/nsr4chgtq+s
 GBrTDcyHlGQ4HnSKqVW1olScq/gUz/m+8iAz14kpWCEhQ3VVr8D6iw+r6vf5MCBDXYsI
 QJSO9WoeDrfhL+zZolaYR0Q+rWNr7s/fZRxh/ZYye3SNKffdaZEMx/ol5TX33eE8G5pp
 kBn9ZlmyN3YpHoaXXSV+vsTegyFYgGEXyY4BqUOxB4o36Kk2tQHuGeFeTJHtc9K1PCgn
 ay3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717467829; x=1718072629;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8OX5d/4fRV+AvT5dBEYpRjGHWr5fI0WlQMWxSj5t0Tw=;
 b=r18yIB6MRj2y2Y1mUKSeJHXWDv53KL7J6RMQVnMQVGNFUAmRZ8KUNQe2xWgY6JqD+u
 aqusHh6OZjMesyD5W1OqkwkAdAwC1iJoOHWS4GUdeTmzIjCli5eBhlzGt7pr4Ato6Fap
 mMhA5VXx5vFvdrIb/Hv5mnQRo5eP7d48r7Elwt6HjRElqoSCh/NjpWI2/MxN0b2PMe40
 Fryd14B9MIzpL+o4sUPg0vIjqPldvr6OE42EQcbz3RsQohfP1+lsR0UveEBAon++x1o7
 1Y8dAWAYuGueGZOzRH7Fq3uBC6DQfJZHcN+nlGcqp4zIhUuhCDZea9swR+ByLxwZJ1X9
 xUmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJR4XUqge38kVgko+aLhM32WZtm7M2yMx4cZ+sWEI4ru7eMBL5EjB+gcVPatKqglTwwSkOL1+S0yIC5SClm9JLSeI0U40=
X-Gm-Message-State: AOJu0YxjPer7yQJgRkjGguqEbbCFZzq8h4J7XL5he1xppZimVgT0hs8k
 MJWopLPudXyRVCL81TWFBatS42uS8V77NKvPL8mGi7Qbi9alXnecipPOjyhBiJ73ikjLe5BoCFs
 n5OJMisdm5fRefAV74elbuqn7TyI=
X-Google-Smtp-Source: AGHT+IHwH7xnEJcJ4Ny9k3Yigvq0DYzqMZmRHPhL5/RQMZ2hzY5jFxCijIix8ySNLWENo7ZNkj1xyEP/IOHjCCGeE+k=
X-Received: by 2002:a05:6102:364f:b0:47e:facd:5515 with SMTP id
 ada2fe7eead31-48bc23faa5dmr9549245137.35.1717467829026; Mon, 03 Jun 2024
 19:23:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240522062905.1799-1-zhiwei_liu@linux.alibaba.com>
 <20240522062905.1799-4-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240522062905.1799-4-zhiwei_liu@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 4 Jun 2024 12:23:23 +1000
Message-ID: <CAKmqyKMUZzFRrzu48O1EgiWGOqEagaOvgUtp9CN2GWbggKPYMw@mail.gmail.com>
Subject: Re: [PATCH 3/4] target/riscv: Add zcmop extension
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 Alistair.Francis@wdc.com, dbarboza@ventanamicro.com, bmeng.cn@gmail.com, 
 iwei1518@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::934;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x934.google.com
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
> Zcmop defines eight 16-bit MOP instructions named C.MOP.n, where n is
> an odd integer between 1 and 15, inclusive. C.MOP.n is encoded in
> the reserved encoding space corresponding to C.LUI xn, 0.
>
> Unlike the MOPs defined in the Zimop extension, the C.MOP.n instructions
> are defined to not write any register.
>
> In current implementation, C.MOP.n only has an check function, without an=
y
> other more behavior.
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c                          |  2 ++
>  target/riscv/cpu_cfg.h                      |  1 +
>  target/riscv/insn16.decode                  |  1 +
>  target/riscv/insn_trans/trans_rvzcmop.c.inc | 29 +++++++++++++++++++++
>  target/riscv/tcg/tcg-cpu.c                  |  5 ++++
>  target/riscv/translate.c                    |  1 +
>  6 files changed, 39 insertions(+)
>  create mode 100644 target/riscv/insn_trans/trans_rvzcmop.c.inc
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index c1ac521142..5052237a5b 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -176,6 +176,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
>      ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
>      ISA_EXT_DATA_ENTRY(zimop, PRIV_VERSION_1_12_0, ext_zimop),
> +    ISA_EXT_DATA_ENTRY(zcmop, PRIV_VERSION_1_12_0, ext_zcmop),
>      ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
>      ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
>      ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
> @@ -1465,6 +1466,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[]=
 =3D {
>      MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
>      MULTI_EXT_CFG_BOOL("zihintpause", ext_zihintpause, true),
>      MULTI_EXT_CFG_BOOL("zimop", ext_zimop, false),
> +    MULTI_EXT_CFG_BOOL("zcmop", ext_zcmop, false),
>      MULTI_EXT_CFG_BOOL("zacas", ext_zacas, false),
>      MULTI_EXT_CFG_BOOL("zaamo", ext_zaamo, false),
>      MULTI_EXT_CFG_BOOL("zalrsc", ext_zalrsc, false),
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index b547fbba9d..e29d4f6f9c 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -72,6 +72,7 @@ struct RISCVCPUConfig {
>      bool ext_zihintpause;
>      bool ext_zihpm;
>      bool ext_zimop;
> +    bool ext_zcmop;
>      bool ext_ztso;
>      bool ext_smstateen;
>      bool ext_sstc;
> diff --git a/target/riscv/insn16.decode b/target/riscv/insn16.decode
> index b96c534e73..3953bcf82d 100644
> --- a/target/riscv/insn16.decode
> +++ b/target/riscv/insn16.decode
> @@ -140,6 +140,7 @@ sw                110  ... ... .. ... 00 @cs_w
>  addi              000 .  .....  ..... 01 @ci
>  addi              010 .  .....  ..... 01 @c_li
>  {
> +  c_mop_n         011 0 0 n:3 1 00000 01
>    illegal         011 0  -----  00000 01 # c.addi16sp and c.lui, RES nzi=
mm=3D0
>    addi            011 .  00010  ..... 01 @c_addi16sp
>    lui             011 .  .....  ..... 01 @c_lui
> diff --git a/target/riscv/insn_trans/trans_rvzcmop.c.inc b/target/riscv/i=
nsn_trans/trans_rvzcmop.c.inc
> new file mode 100644
> index 0000000000..7205586508
> --- /dev/null
> +++ b/target/riscv/insn_trans/trans_rvzcmop.c.inc
> @@ -0,0 +1,29 @@
> +/*
> + * RISC-V translation routines for compressed May-Be-Operation(zcmop).
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
> +#define REQUIRE_ZCMOP(ctx) do {           \
> +    if (!ctx->cfg_ptr->ext_zcmop) {       \
> +        return false;                     \
> +    }                                     \
> +} while (0)
> +
> +static bool trans_c_mop_n(DisasContext *ctx, arg_c_mop_n *a)
> +{
> +    REQUIRE_ZCMOP(ctx);
> +    return true;
> +}
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 40054a391a..499b48dce8 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -583,6 +583,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu=
, Error **errp)
>          }
>      }
>
> +    if (cpu->cfg.ext_zcmop && !cpu->cfg.ext_zca) {
> +        error_setg(errp, "Zcmop extensions require Zca");
> +        return;
> +    }
> +
>      if (mcc->misa_mxl_max !=3D MXL_RV32 && cpu->cfg.ext_zcf) {
>          error_setg(errp, "Zcf extension is only relevant to RV32");
>          return;
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 77c6564834..51dfb03685 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -1112,6 +1112,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase,=
 target_ulong pc)
>  /* Include the auto-generated decoder for 16 bit insn */
>  #include "decode-insn16.c.inc"
>  #include "insn_trans/trans_rvzce.c.inc"
> +#include "insn_trans/trans_rvzcmop.c.inc"
>
>  /* Include decoders for factored-out extensions */
>  #include "decode-XVentanaCondOps.c.inc"
> --
> 2.25.1
>
>

