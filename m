Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F45EC25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 02:26:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEJsU-0006fu-C7; Mon, 03 Jun 2024 22:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEJsP-0006fD-Fr; Mon, 03 Jun 2024 22:26:18 -0400
Received: from mail-vk1-xa36.google.com ([2607:f8b0:4864:20::a36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEJsM-0005L5-RG; Mon, 03 Jun 2024 22:26:17 -0400
Received: by mail-vk1-xa36.google.com with SMTP id
 71dfb90a1353d-4e4f0020ca3so189541e0c.2; 
 Mon, 03 Jun 2024 19:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717467971; x=1718072771; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xvK0QffcDHRsp9PYk9sQNjHP6ZWfdM0jvowCQmYhotA=;
 b=J5Mv1Q+I5Nbq0VNSu57UKvol/nbVRnk32eoWc5ohsSj5pAjleUDMEcDbjZ6DLHF13C
 RkmFgC7MSzaWk9q+kt5KLiZseLWQpw4DM8nAzNsF02dic40UxBeCz9Wf5lwqkcn+ito/
 Anlkn8Ro9J3DcIdIvAx6ambtUZLfh03WVXHJrB60sPolttXkZMLq1tM/TSxKocATktc/
 byv1LuYztlpXK4+GM8+W1azCFF3hg+kKPA/5Ve/BzssYHYAQDiFs/CVlF6OweyAn8rPy
 6xZd9xV20Y9whvHICf/ZyMcl1IOq9VSLaz92FLqPhLM1L7q+qlBI0k1NK9iU2/p69ijS
 1xng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717467971; x=1718072771;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xvK0QffcDHRsp9PYk9sQNjHP6ZWfdM0jvowCQmYhotA=;
 b=rRBH52tAFWrXctms4IWC0Qe/QikneFZ2L0H5dnsqN/7dCTEOh96ISPqNuIsdSCYqxx
 NrhGFuZ1Up3zO8w7UE5WtZLPn0HVSGhzE8+rze7n0ePnMzbP7MgP1DDpJC6valuTrtBU
 75zScAjwVxNQ9FoRZzw11PTGdU6ibvGFyQGNUmdSZCkHDD+T44feftSlU3egGBQndi+l
 +Ppau7OPdHNaZalfbAz/YbWfIQj+Szk4tfM9Jav7RMQ2OlUuJFgFIqmRL113W/z48HrA
 kyT3m2P5vbCn9gbOHAQrllbXKmIFVVausCP9bbqDFoF5FwsDhpEUPxoljqG4Ev1DZrDf
 EYzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmnso/Ko2c8y7qHq74+V7iavmllnoaDQJ0RT+J08Usy8AMh/jPo7kXNEWqnnzL2RgHcVyYVCL+bQLm5wpWkMpNYGWWlwc=
X-Gm-Message-State: AOJu0YxuKDmnyZIm1W6v+tJbWIFKxtpjQstuq1PjNsh458hKzf9jCwKd
 vZOlaRJuqWBM5Hm+4aXzSAKobMJ0JOtQkiF9KU8umnJe3rEWj+nu8sHdVDDNN6YRLfr8lDo6FVY
 6YpUGL8nUTsZ2GsbOF/cWs6d0V6I=
X-Google-Smtp-Source: AGHT+IFZGOtL7LO80ExbhV0xRcA6ewRFuIt9j2erWksw8F/11s9K3lFitmILFqMuxr4uggB78gmyb7zytbh3EcadHEI=
X-Received: by 2002:a05:6122:98f:b0:4eb:1be0:3398 with SMTP id
 71dfb90a1353d-4eb1be03428mr5049713e0c.5.1717467970694; Mon, 03 Jun 2024
 19:26:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240523124045.1964-1-zhiwei_liu@linux.alibaba.com>
 <20240523124045.1964-2-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240523124045.1964-2-zhiwei_liu@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 4 Jun 2024 12:25:44 +1000
Message-ID: <CAKmqyKOgdRPdmBu=a=pM7hrtZqTGxuU6-sPogWiG5Hw-1MVxxA@mail.gmail.com>
Subject: Re: [PATCH 1/6] target/riscv: Move gen_amo before implement Zabha
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 Alistair.Francis@wdc.com, dbarboza@ventanamicro.com, bmeng.cn@gmail.com, 
 liwei1518@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a36;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa36.google.com
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

On Thu, May 23, 2024 at 10:43=E2=80=AFPM LIU Zhiwei
<zhiwei_liu@linux.alibaba.com> wrote:
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/insn_trans/trans_rva.c.inc | 21 ---------------------
>  target/riscv/translate.c                | 21 +++++++++++++++++++++
>  2 files changed, 21 insertions(+), 21 deletions(-)
>
> diff --git a/target/riscv/insn_trans/trans_rva.c.inc b/target/riscv/insn_=
trans/trans_rva.c.inc
> index eb080baddd..39bbf60f3c 100644
> --- a/target/riscv/insn_trans/trans_rva.c.inc
> +++ b/target/riscv/insn_trans/trans_rva.c.inc
> @@ -96,27 +96,6 @@ static bool gen_sc(DisasContext *ctx, arg_atomic *a, M=
emOp mop)
>      return true;
>  }
>
> -static bool gen_amo(DisasContext *ctx, arg_atomic *a,
> -                    void(*func)(TCGv, TCGv, TCGv, TCGArg, MemOp),
> -                    MemOp mop)
> -{
> -    TCGv dest =3D dest_gpr(ctx, a->rd);
> -    TCGv src1, src2 =3D get_gpr(ctx, a->rs2, EXT_NONE);
> -
> -    if (ctx->cfg_ptr->ext_zama16b) {
> -        mop |=3D MO_ATOM_WITHIN16;
> -    } else {
> -        mop |=3D MO_ALIGN;
> -    }
> -
> -    decode_save_opc(ctx);
> -    src1 =3D get_address(ctx, a->rs1, 0);
> -    func(dest, src1, src2, ctx->mem_idx, mop);
> -
> -    gen_set_gpr(ctx, a->rd, dest);
> -    return true;
> -}
> -
>  static bool trans_lr_w(DisasContext *ctx, arg_lr_w *a)
>  {
>      REQUIRE_A_OR_ZALRSC(ctx);
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 51dfb03685..b160bcbfe0 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -1075,6 +1075,27 @@ static bool gen_unary_per_ol(DisasContext *ctx, ar=
g_r2 *a, DisasExtend ext,
>      return gen_unary(ctx, a, ext, f_tl);
>  }
>
> +static bool gen_amo(DisasContext *ctx, arg_atomic *a,
> +                    void(*func)(TCGv, TCGv, TCGv, TCGArg, MemOp),
> +                    MemOp mop)
> +{
> +    TCGv dest =3D dest_gpr(ctx, a->rd);
> +    TCGv src1, src2 =3D get_gpr(ctx, a->rs2, EXT_NONE);
> +
> +    if (ctx->cfg_ptr->ext_zama16b) {
> +        mop |=3D MO_ATOM_WITHIN16;
> +    } else {
> +        mop |=3D MO_ALIGN;
> +    }
> +
> +    decode_save_opc(ctx);
> +    src1 =3D get_address(ctx, a->rs1, 0);
> +    func(dest, src1, src2, ctx->mem_idx, mop);
> +
> +    gen_set_gpr(ctx, a->rd, dest);
> +    return true;
> +}
> +
>  static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
>  {
>      DisasContext *ctx =3D container_of(dcbase, DisasContext, base);
> --
> 2.25.1
>
>

