Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 761DBC7114C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 00:08:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjSht-0007yj-UU; Wed, 28 Aug 2024 20:08:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sjShU-00076j-UI; Wed, 28 Aug 2024 20:07:45 -0400
Received: from mail-ua1-x935.google.com ([2607:f8b0:4864:20::935])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sjShS-0004Sq-JV; Wed, 28 Aug 2024 20:07:44 -0400
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-8430557e436so45279241.2; 
 Wed, 28 Aug 2024 17:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724890061; x=1725494861; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MYfv/emuw6F0BFbxDUtv91bjlrE2YF+/4k7p/U3WQYQ=;
 b=MNYJXDvCQYNOY/VEX0wVNlTZlX4KyJtSJkbgq35WC+2zJ2wsSVV42EFUcWV5J2hcpX
 sYG0rByZOUa+UqbiOWjdc9y6+E2gq8HvLXciY9uDtjps+wpQ8kiBrVEQkoqeLri4V9jS
 n8l16LTJwEEvvqKJkExbZbqwQkvROu9FbE7O8Sq684TR079sAolqqyev3eDkAR/kU+AZ
 Q4+/93zcYdbuZfGxaql5xCjgyFuEcEGNqL9Y+04KPSNMeyHYIUrLwqRr9yUijTkL2+pc
 BBNAK2rCij/sG29qwV7UB/ggZqFYDaycyspBrWaLzFay1DfFBbC0k/xha1YUougOXuFo
 4TOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724890061; x=1725494861;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MYfv/emuw6F0BFbxDUtv91bjlrE2YF+/4k7p/U3WQYQ=;
 b=MiiqQwQ4K1enwbYeV2D46K/yT7+dBGK7B9Ba3wLvmVGdry6tczoRdAZBH3qFhaCse2
 eA025XBnHH6e0BsABw3oKOrmXbyH7NI3JKw8x13+xV8/3vphLChWp6M9eIxWOfCn4FUJ
 Y5ECezmcgpvZa/tj+vQM50KTX8Q4UzOR3zchh3bqoMpQC2SYmPOUofDgjn1z+ZxInUOy
 At9yUDR7WxSzOgQGpewDk6pWEFHMTbaxeh3gTB3mTufClee5avxZiZM417qztkgA86xe
 HGGxTUm6Inl/Okw9+d0gK3x4W0d5H/7W/9slWL7nE6AiDcvr3ReHLieOnFpgpS2gTkeL
 dJEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2n9BO+gHVkGmnTesxUku7xvmrYb+HyI2LcOAM+1i3DyP2toBFXm+mihInjOLC0AwuvE9qaGSaKasJ@nongnu.org
X-Gm-Message-State: AOJu0YyteQLFTBrhUK26uWE4Ld/3bVeexE+SweHwEIYqJViydWFVqhdk
 cMW5apIrl1pDLf0Ul4CXF/aZmOBYbD0teRkY/LN947NmoHh06bNUwViKHA6ESrmgL7NIOtBD3lt
 GpfGtqSz+KDC3hQ039MECgrcW/cAFxM4uAFw=
X-Google-Smtp-Source: AGHT+IHRqBaLLeS//agGxhmeYA5PK8zgaNbhNJX+kbtqYoNpi3PA0D8erk09RQiGimNM3ja5lc4R3JjQyW5cNOrTrfs=
X-Received: by 2002:a05:6102:942:b0:492:a74d:1664 with SMTP id
 ada2fe7eead31-49a5b05785dmr1495393137.8.1724890060872; Wed, 28 Aug 2024
 17:07:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240828174739.714313-1-debug@rivosinc.com>
 <20240828174739.714313-17-debug@rivosinc.com>
 <CAKmqyKOF0XGhSH5-vNKqFXhX=XB9p5STRAsm6kNaph=7i-7=3A@mail.gmail.com>
 <Zs+7cCW04Y7beKJw@debug.ba.rivosinc.com>
In-Reply-To: <Zs+7cCW04Y7beKJw@debug.ba.rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 29 Aug 2024 10:07:15 +1000
Message-ID: <CAKmqyKPEeWry0yGurH+3o=0N55nG+41-bDeVChwQdKX++zt0Xw@mail.gmail.com>
Subject: Re: [PATCH v11 16/20] target/riscv: implement zicfiss instructions
To: Deepak Gupta <debug@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 Alistair.Francis@wdc.com, laurent@vivier.eu, bmeng.cn@gmail.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 jim.shu@sifive.com, andy.chiu@sifive.com, kito.cheng@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::935;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x935.google.com
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

On Thu, Aug 29, 2024 at 10:06=E2=80=AFAM Deepak Gupta <debug@rivosinc.com> =
wrote:
>
> On Thu, Aug 29, 2024 at 10:01:30AM +1000, Alistair Francis wrote:
> >On Thu, Aug 29, 2024 at 3:53=E2=80=AFAM Deepak Gupta <debug@rivosinc.com=
> wrote:
> >>
> >> zicfiss has following instructions
> >>  - sspopchk: pops a value from shadow stack and compares with x1/x5.
> >>    If they dont match, reports a sw check exception with tval =3D 3.
> >>  - sspush: pushes value in x1/x5 on shadow stack
> >>  - ssrdp: reads current shadow stack
> >>  - ssamoswap: swaps contents of shadow stack atomically
> >>
> >> sspopchk/sspush/ssrdp default to zimop if zimop implemented and SSE=3D=
0
> >>
> >> If SSE=3D0, ssamoswap is illegal instruction exception.
> >>
> >> This patch implements shadow stack operations for qemu-user and shadow
> >> stack is not protected.
> >>
> >> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> >> Co-developed-by: Jim Shu <jim.shu@sifive.com>
> >> Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
> >> ---
> >>  target/riscv/cpu_bits.h                       |  2 +
> >>  target/riscv/insn32.decode                    | 21 +++++-
> >>  target/riscv/insn_trans/trans_rva.c.inc       | 39 ++++++++++
> >>  target/riscv/insn_trans/trans_rvzicfiss.c.inc | 75 ++++++++++++++++++=
+
> >>  target/riscv/translate.c                      |  5 ++
> >>  5 files changed, 140 insertions(+), 2 deletions(-)
> >>  create mode 100644 target/riscv/insn_trans/trans_rvzicfiss.c.inc
> >>
> >>  # *** Zabhb Standard Extension ***
> >>  amoswap_b  00001 . . ..... ..... 000 ..... 0101111 @atom_st
> >> diff --git a/target/riscv/insn_trans/trans_rva.c.inc b/target/riscv/in=
sn_trans/trans_rva.c.inc
> >> index 9cf3ae8019..a2119393a6 100644
> >> --- a/target/riscv/insn_trans/trans_rva.c.inc
> >> +++ b/target/riscv/insn_trans/trans_rva.c.inc
> >> @@ -114,6 +114,25 @@ static bool trans_amoswap_w(DisasContext *ctx, ar=
g_amoswap_w *a)
> >>      return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_TESL);
> >>  }
> >>
> >> +static bool trans_ssamoswap_w(DisasContext *ctx, arg_amoswap_w *a)
> >> +{
> >> +    REQUIRE_A_OR_ZAAMO(ctx);
> >> +    if (!ctx->bcfi_enabled) {
> >> +        return false;
> >> +    }
> >> +
> >> +    TCGv dest =3D dest_gpr(ctx, a->rd);
> >> +    TCGv src1, src2 =3D get_gpr(ctx, a->rs2, EXT_NONE);
> >> +
> >> +    decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
> >> +    src1 =3D get_address(ctx, a->rs1, 0);
> >> +
> >> +    tcg_gen_atomic_xchg_tl(dest, src1, src2, SS_MMU_INDEX(ctx),
> >> +                           (MO_ALIGN | MO_TESL));
> >> +    gen_set_gpr(ctx, a->rd, dest);
> >> +    return true;
> >> +}
> >> +
> >>  static bool trans_amoadd_w(DisasContext *ctx, arg_amoadd_w *a)
> >>  {
> >>      REQUIRE_A_OR_ZAAMO(ctx);
> >> @@ -183,6 +202,26 @@ static bool trans_amoswap_d(DisasContext *ctx, ar=
g_amoswap_d *a)
> >>      return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_TEUQ);
> >>  }
> >>
> >> +static bool trans_ssamoswap_d(DisasContext *ctx, arg_amoswap_w *a)
> >> +{
> >> +    REQUIRE_64BIT(ctx);
> >> +    REQUIRE_A_OR_ZAAMO(ctx);
> >> +    if (!ctx->bcfi_enabled) {
> >> +        return false;
> >> +    }
> >> +
> >> +    TCGv dest =3D dest_gpr(ctx, a->rd);
> >> +    TCGv src1, src2 =3D get_gpr(ctx, a->rs2, EXT_NONE);
> >> +
> >> +    decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
> >> +    src1 =3D get_address(ctx, a->rs1, 0);
> >> +
> >> +    tcg_gen_atomic_xchg_tl(dest, src1, src2, SS_MMU_INDEX(ctx),
> >> +                           (MO_ALIGN | MO_TESQ));
> >> +    gen_set_gpr(ctx, a->rd, dest);
> >> +    return true;
> >> +}
> >
> >Why aren't these in the rvzicfiss file?
>
> `ssamoswap` encodings are coming from (reserved) AMO encodings (and not z=
imop)
> That's why kept it in trans_rva

But the instructions are defined in the rvzicfiss extension, so I feel
it makes sense to include them there

Alistair

>
> >
> >Otherwise:
> >
> >Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> >
> >Alistair
> >
> >> +
> >>  static bool trans_amoadd_d(DisasContext *ctx, arg_amoadd_d *a)
> >>  {

