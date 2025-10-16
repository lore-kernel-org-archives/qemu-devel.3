Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 994C3CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 05:13:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9GHx-0006II-6R; Thu, 16 Oct 2025 01:12:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v9GHv-0006Hq-08
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 01:12:31 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v9GHr-000214-V3
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 01:12:29 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b5e19810703so39837966b.2
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 22:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760591545; x=1761196345; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cVaXGWZcWAqQErFu3HFNIMUeWzNnClLF//wu1wUPfzA=;
 b=Hro2Ok95iTc06S5+of5ey7C6ZW6uxZV3uGA6WlfDp+owwMfjBUk0IJTLJqiatpheqH
 BuLAgz+xU9ssTxk5/dgLhZMy3BmpyOERaDhgfu6FfF8OUaxkQ4F/CsEXfSqWp+Hwi/DA
 i/oGUEEyskP/nKxpPd6RmR6eCKSWAdfpOQCYLK2/w18ZAncgGi49eGsWhjqowx9l2bUY
 1o76mVO+Z9KVT4uS3cU0xGW4lFIY1S/4sI0IcksOJWly4WpkN7fSX576BushVWWC5Z+G
 29AbydLBnE5J3XDATSCJI8D/3xnXhlKt2c7sDNvsd2+kJ6O8f1t2hBfJLH/0cGWz/j7u
 4RPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760591545; x=1761196345;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cVaXGWZcWAqQErFu3HFNIMUeWzNnClLF//wu1wUPfzA=;
 b=YFbxEXduBIp7bScn8M38k5gxIM81A+slrVOcVJH2qtSOfkuwGPzm1nrAoHuldtu9vB
 z11p3blbDolvjetkxLsJ8uA2cZi806NEfN/3u3wdA1qDfUkruk83N2P2cK0ggCIFC6za
 RuMl/uZhnAHg6a03Ar1lSlkiwOoXNci52euvpQJTdXH5+j60lWt5m6XtxkJELBRl3Wxa
 3OtHQVijImW97rKyIY8hOOPPYkzUkzsBBZSvGvz0r8lPCu/yjFmXtzxp6Ux4hD0fLIyQ
 VikZK0QUyApesUU6ZSUaTXQ8+0RgRnWnH/uhcgURXBP4ldNCWWXkBgMtWFhJmotWQMYS
 2ATA==
X-Gm-Message-State: AOJu0YyAhL9PkQOIHbfYKaLJWLctGAdzeBaZTSEFuz90Z6scgSeyxB+Y
 qGiqPDbJRhcvHXXPGOYUtJ5Hkd1QI+Xs1pSJxH2bwX3nOA6qL5T/1VwCtFL55VIJbxG4hLn7Xp2
 I3F+7RILVD0q8SauvmvF1vffNM6rdsPM=
X-Gm-Gg: ASbGncvpsvRuLREVyNsi6+IgsBDojCS7eGpycxAXyN0iL6ZygbYiZfapRlIigcaxLEz
 2U86sCL3GY80+aqQJjOpirkQEawC/x0SDuJ3Zz7bLficxyGDm+s8vDB/XhRNcCY6C8hnIdlalRH
 lLBDCH6SbsFgLDp9GE9HYIR7rXaWJfCbvqzJp1vmMSU7HXy0RyCcw8z74FHmm6vBUJ1Yycm951+
 8D1UpINimZK4ViUv6nlkysx8mj6LXJAOZ4iWjhV3foJXxAyK0CPy7Fst5iOqdSLdz0galQjXS5t
 EpU+gymi+0UuC4/dTTAK0fkIsQ==
X-Google-Smtp-Source: AGHT+IH4OtuwU3ddvNBGJl35xW3ph0WDW+kq+B05QuexDjghiBh8GWoghB6R1n5D88st38xBSOHIhvuNUlwLJ8FF2ag=
X-Received: by 2002:a17:907:3e05:b0:b04:563f:e120 with SMTP id
 a640c23a62f3a-b50abfcd056mr3530410766b.53.1760591545421; Wed, 15 Oct 2025
 22:12:25 -0700 (PDT)
MIME-Version: 1.0
References: <20251014203512.26282-1-anjo@rev.ng>
 <20251014203512.26282-18-anjo@rev.ng>
In-Reply-To: <20251014203512.26282-18-anjo@rev.ng>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 16 Oct 2025 15:11:58 +1000
X-Gm-Features: AS18NWBzgsED7KQqyElxxHwzoSF-dW7oUwayaNTnd_L5LKEKoleJ8UdVqtjjtDU
Message-ID: <CAKmqyKND4kGvmaM64C_Wb1rYXE4KFGU3Ys+6YeWRp5MUf_a0Zw@mail.gmail.com>
Subject: Re: [PATCH v3 17/34] target/riscv: Fix size of retxh
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org, philmd@linaro.org, 
 alistair.francis@wdc.com, palmer@dabbelt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x636.google.com
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

On Wed, Oct 15, 2025 at 6:35=E2=80=AFAM Anton Johansson via
<qemu-devel@nongnu.org> wrote:
>
> 128-bit helpers only make sense for MXL_RV128, TARGET_RISCV64,
> and TCGv =3D=3D TCGv_i64, therefore fix retxh to 64 bits.
>
> For the sake of being pedandic, update 128-bit instructions to access
> retxh via 64 bit TCG ops, even if they only make sense when TCGv =3D=3D
> TCGv_i64.
>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h                      |  2 +-
>  target/riscv/insn_trans/trans_rvi.c.inc |  8 ++++++--
>  target/riscv/insn_trans/trans_rvm.c.inc | 16 ++++++++++++----
>  3 files changed, 19 insertions(+), 7 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 6ed912cbd1..d7a41e6db5 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -248,7 +248,7 @@ struct CPUArchState {
>      uint32_t xl;            /* current xlen */
>
>      /* 128-bit helpers upper part return value */
> -    target_ulong retxh;
> +    uint64_t retxh;
>
>      uint64_t jvt;
>
> diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_=
trans/trans_rvi.c.inc
> index b9c7160468..9c8c04b2dc 100644
> --- a/target/riscv/insn_trans/trans_rvi.c.inc
> +++ b/target/riscv/insn_trans/trans_rvi.c.inc
> @@ -1012,10 +1012,12 @@ static bool do_csrr_i128(DisasContext *ctx, int r=
d, int rc)
>      TCGv destl =3D dest_gpr(ctx, rd);
>      TCGv desth =3D dest_gprh(ctx, rd);
>      TCGv_i32 csr =3D tcg_constant_i32(rc);
> +    TCGv_i64 wide_desth =3D tcg_temp_new_i64();
>
>      translator_io_start(&ctx->base);
>      gen_helper_csrr_i128(destl, tcg_env, csr);
> -    tcg_gen_ld_tl(desth, tcg_env, offsetof(CPURISCVState, retxh));
> +    tcg_gen_ld_i64(wide_desth, tcg_env, offsetof(CPURISCVState, retxh));
> +    tcg_gen_trunc_i64_tl(desth, wide_desth);
>      gen_set_gpr128(ctx, rd, destl, desth);
>      return do_csr_post(ctx);
>  }
> @@ -1035,10 +1037,12 @@ static bool do_csrrw_i128(DisasContext *ctx, int =
rd, int rc,
>      TCGv destl =3D dest_gpr(ctx, rd);
>      TCGv desth =3D dest_gprh(ctx, rd);
>      TCGv_i32 csr =3D tcg_constant_i32(rc);
> +    TCGv_i64 wide_desth =3D tcg_temp_new_i64();
>
>      translator_io_start(&ctx->base);
>      gen_helper_csrrw_i128(destl, tcg_env, csr, srcl, srch, maskl, maskh)=
;
> -    tcg_gen_ld_tl(desth, tcg_env, offsetof(CPURISCVState, retxh));
> +    tcg_gen_ld_i64(wide_desth, tcg_env, offsetof(CPURISCVState, retxh));
> +    tcg_gen_trunc_i64_tl(desth, wide_desth);
>      gen_set_gpr128(ctx, rd, destl, desth);
>      return do_csr_post(ctx);
>  }
> diff --git a/target/riscv/insn_trans/trans_rvm.c.inc b/target/riscv/insn_=
trans/trans_rvm.c.inc
> index 795f0ccf14..0e2da5bed2 100644
> --- a/target/riscv/insn_trans/trans_rvm.c.inc
> +++ b/target/riscv/insn_trans/trans_rvm.c.inc
> @@ -169,8 +169,10 @@ static bool trans_mulhu(DisasContext *ctx, arg_mulhu=
 *a)
>  static void gen_div_i128(TCGv rdl, TCGv rdh,
>                           TCGv rs1l, TCGv rs1h, TCGv rs2l, TCGv rs2h)
>  {
> +    TCGv_i64 wide_rdh =3D tcg_temp_new_i64();
>      gen_helper_divs_i128(rdl, tcg_env, rs1l, rs1h, rs2l, rs2h);
> -    tcg_gen_ld_tl(rdh, tcg_env, offsetof(CPURISCVState, retxh));
> +    tcg_gen_ld_i64(wide_rdh, tcg_env, offsetof(CPURISCVState, retxh));
> +    tcg_gen_trunc_i64_tl(rdh, wide_rdh);
>  }
>
>  static void gen_div(TCGv ret, TCGv source1, TCGv source2)
> @@ -212,8 +214,10 @@ static bool trans_div(DisasContext *ctx, arg_div *a)
>  static void gen_divu_i128(TCGv rdl, TCGv rdh,
>                            TCGv rs1l, TCGv rs1h, TCGv rs2l, TCGv rs2h)
>  {
> +    TCGv_i64 wide_rdh =3D tcg_temp_new_i64();
>      gen_helper_divu_i128(rdl, tcg_env, rs1l, rs1h, rs2l, rs2h);
> -    tcg_gen_ld_tl(rdh, tcg_env, offsetof(CPURISCVState, retxh));
> +    tcg_gen_ld_i64(wide_rdh, tcg_env, offsetof(CPURISCVState, retxh));
> +    tcg_gen_trunc_i64_tl(rdh, wide_rdh);
>  }
>
>  static void gen_divu(TCGv ret, TCGv source1, TCGv source2)
> @@ -244,8 +248,10 @@ static bool trans_divu(DisasContext *ctx, arg_divu *=
a)
>  static void gen_rem_i128(TCGv rdl, TCGv rdh,
>                           TCGv rs1l, TCGv rs1h, TCGv rs2l, TCGv rs2h)
>  {
> +    TCGv_i64 wide_rdh =3D tcg_temp_new_i64();
>      gen_helper_rems_i128(rdl, tcg_env, rs1l, rs1h, rs2l, rs2h);
> -    tcg_gen_ld_tl(rdh, tcg_env, offsetof(CPURISCVState, retxh));
> +    tcg_gen_ld_i64(wide_rdh, tcg_env, offsetof(CPURISCVState, retxh));
> +    tcg_gen_trunc_i64_tl(rdh, wide_rdh);
>  }
>
>  static void gen_rem(TCGv ret, TCGv source1, TCGv source2)
> @@ -289,8 +295,10 @@ static bool trans_rem(DisasContext *ctx, arg_rem *a)
>  static void gen_remu_i128(TCGv rdl, TCGv rdh,
>                            TCGv rs1l, TCGv rs1h, TCGv rs2l, TCGv rs2h)
>  {
> +    TCGv_i64 wide_rdh =3D tcg_temp_new_i64();
>      gen_helper_remu_i128(rdl, tcg_env, rs1l, rs1h, rs2l, rs2h);
> -    tcg_gen_ld_tl(rdh, tcg_env, offsetof(CPURISCVState, retxh));
> +    tcg_gen_ld_i64(wide_rdh, tcg_env, offsetof(CPURISCVState, retxh));
> +    tcg_gen_trunc_i64_tl(rdh, wide_rdh);
>  }
>
>  static void gen_remu(TCGv ret, TCGv source1, TCGv source2)
> --
> 2.51.0
>
>

