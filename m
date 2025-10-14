Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 100D4CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 05:07:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8XFk-0005Jz-E6; Tue, 14 Oct 2025 01:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v8XFg-0005Is-MR
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 01:07:12 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v8XFe-0003zC-C9
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 01:07:12 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-631df7b2dffso2566610a12.1
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 22:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760418429; x=1761023229; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tb+wWsUUQ5pTeo29yBMOQVCCwHi6Dx46LIC42JZP2XU=;
 b=EkdMY8POJXPRhFT8RR1h/jgBzAihuqbMIi96WzL8VlR+kvxe+WtjodX/k2PTLh5NUO
 Fl11ZjP9qaToyptM+gZNOyVQjREqwMsE6FXBtxjXSn3Sy9UCIEX6JIO7jeCy870clyao
 jNBzFye5T+urk9aH0EohpJx5LafHIcXBHnRJeG0zid20o1uUJYU9RHE3uilul2Dzw5y9
 gZQhvM4ayDKzxOxs+2LOn6iucpZyFroSsWN8kylbKeg4NJGkuTMhCpsUum4Sv6DqC4gr
 onbEwzNT2wzyAIrqetDFr8FgDs79lnmD3SMrmynukijzzCS4xbEubAiWtigTZ6wZAZ+q
 2mjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760418429; x=1761023229;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tb+wWsUUQ5pTeo29yBMOQVCCwHi6Dx46LIC42JZP2XU=;
 b=IsCJSKHrdC6unEZ6ekdigZ+VJ0O3UbHXK8As2cNcbGH/sbU2XI3cEHofJyGtTyFitm
 G3K3C1pLfk9cTZZ1Kr2AekhSxJqF0uaRxeVaZW3r5sukrwnoPbsZMLhPmFt9ydxbwh8f
 +OX257zX/q61lMR4k/xwrwL/ABz1pS/KBTMY5FskSqGi+A/EfUlfE5pU1KOiacr6Fisy
 Sqv0Usl0Bw+wclOFyBAJaSLAvYRACMOS7QOls4IPTCeSfIixjGRfM6bXaZbpFR8NNrb9
 /CYtbNSV7uP/ameRw+UO/tEET+CxqEWD5ZUgAM5lFtjomPC1zbP6dH12Bz6JDET1aHKF
 eG9w==
X-Gm-Message-State: AOJu0YwVQsgoiDBJfsjeTPAqN86Xuuc3qTiKjCFvpdGrR3VtAf6KjpA7
 ck/bue7Wuw9S9+GpLtWxtf3Ea+gV/6XSN83c86j4BTPG4aICXkSmfD0Q1xKGN243ANpHlKn6tBA
 e7viiMaxQzO6v+WRbx3/oloZPOdQWO4s=
X-Gm-Gg: ASbGncvJsA1vE8eFx0F8WrkDpqq7O91qwMbISmoKWdvJ3iQrK1BijBEsQjhWZ9cNFd7
 7B/xpKgivhIi0mJXiaI5V4IbvxZxkeRvxtBvJcVuwyqAEnNdFJYACtOQANAywfhkCdBnBsqdzTe
 PmSlo3lZfc/dB5zlWvQDIstSW2eU+4GwW2nxQXg43diElOzv7TXCoGT5fL9+vWqhyS8b+MnlFif
 Y0GzOsiS0XJ/yJgnfZAyCNhi5fzWKJN7Dk9bFtl0tBByFwb73fDNVne
X-Google-Smtp-Source: AGHT+IHt61AKGMKSai7SdN23bYKiwu/vp/52DAtaegZNTVZ2U561Rylj6ZPskd4XmvIWvblTx9jm2OpfLuBlwiHbAh0=
X-Received: by 2002:a05:6402:1d50:b0:639:f6a9:1385 with SMTP id
 4fb4d7f45d1cf-639f6a92178mr18740643a12.5.1760418428704; Mon, 13 Oct 2025
 22:07:08 -0700 (PDT)
MIME-Version: 1.0
References: <20251010155045.78220-1-philmd@linaro.org>
 <20251010155045.78220-9-philmd@linaro.org>
In-Reply-To: <20251010155045.78220-9-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 14 Oct 2025 15:06:41 +1000
X-Gm-Features: AS18NWAuqghR-LS7lxh5i-k0e6YjPzkmQjXkgIFxO86Q-YZceHQt1uI0P_5222c
Message-ID: <CAKmqyKPFBzaRjvOLtX5WpQE0eqLKoUuptyAegONeM9DSM-FinA@mail.gmail.com>
Subject: Re: [PATCH 08/13] target/riscv: Conceal MO_TE within
 gen_storepair_tl()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Christoph Muellner <christoph.muellner@vrull.eu>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Anton Johansson <anjo@rev.ng>, Richard Henderson <richard.henderson@linaro.org>,
 Valentin Haudiquet <valentin.haudiquet@canonical.com>,
 Weiwei Li <liwei1518@gmail.com>, 
 qemu-riscv@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x532.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Sat, Oct 11, 2025 at 1:52=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> All callers of gen_storepair_tl() set the MO_TE flag. Set it once in
> the callee.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/insn_trans/trans_xthead.c.inc | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/target/riscv/insn_trans/trans_xthead.c.inc b/target/riscv/in=
sn_trans/trans_xthead.c.inc
> index 859cbc26cb2..2f31842791e 100644
> --- a/target/riscv/insn_trans/trans_xthead.c.inc
> +++ b/target/riscv/insn_trans/trans_xthead.c.inc
> @@ -926,6 +926,7 @@ static bool gen_loadpair_tl(DisasContext *ctx, arg_th=
_pair *a, MemOp memop,
>      addr1 =3D get_address(ctx, a->rs, imm);
>      addr2 =3D get_address(ctx, a->rs, memop_size(memop) + imm);
>
> +    memop |=3D MO_TE;
>      tcg_gen_qemu_ld_tl(t1, addr1, ctx->mem_idx, memop);
>      tcg_gen_qemu_ld_tl(t2, addr2, ctx->mem_idx, memop);
>      gen_set_gpr(ctx, a->rd1, t1);
> @@ -937,19 +938,19 @@ static bool trans_th_ldd(DisasContext *ctx, arg_th_=
pair *a)
>  {
>      REQUIRE_XTHEADMEMPAIR(ctx);
>      REQUIRE_64BIT(ctx);
> -    return gen_loadpair_tl(ctx, a, MO_TE | MO_SQ, 4);
> +    return gen_loadpair_tl(ctx, a, MO_SQ, 4);
>  }
>
>  static bool trans_th_lwd(DisasContext *ctx, arg_th_pair *a)
>  {
>      REQUIRE_XTHEADMEMPAIR(ctx);
> -    return gen_loadpair_tl(ctx, a, MO_TE | MO_SL, 3);
> +    return gen_loadpair_tl(ctx, a, MO_SL, 3);
>  }
>
>  static bool trans_th_lwud(DisasContext *ctx, arg_th_pair *a)
>  {
>      REQUIRE_XTHEADMEMPAIR(ctx);
> -    return gen_loadpair_tl(ctx, a, MO_TE | MO_UL, 3);
> +    return gen_loadpair_tl(ctx, a, MO_UL, 3);
>  }
>
>  static bool gen_storepair_tl(DisasContext *ctx, arg_th_pair *a, MemOp me=
mop,
> @@ -964,6 +965,7 @@ static bool gen_storepair_tl(DisasContext *ctx, arg_t=
h_pair *a, MemOp memop,
>      addr1 =3D get_address(ctx, a->rs, imm);
>      addr2 =3D get_address(ctx, a->rs, memop_size(memop) + imm);
>
> +    memop |=3D MO_TE;
>      tcg_gen_qemu_st_tl(data1, addr1, ctx->mem_idx, memop);
>      tcg_gen_qemu_st_tl(data2, addr2, ctx->mem_idx, memop);
>      return true;
> @@ -973,13 +975,13 @@ static bool trans_th_sdd(DisasContext *ctx, arg_th_=
pair *a)
>  {
>      REQUIRE_XTHEADMEMPAIR(ctx);
>      REQUIRE_64BIT(ctx);
> -    return gen_storepair_tl(ctx, a, MO_TE | MO_SQ, 4);
> +    return gen_storepair_tl(ctx, a, MO_SQ, 4);
>  }
>
>  static bool trans_th_swd(DisasContext *ctx, arg_th_pair *a)
>  {
>      REQUIRE_XTHEADMEMPAIR(ctx);
> -    return gen_storepair_tl(ctx, a, MO_TE | MO_SL, 3);
> +    return gen_storepair_tl(ctx, a, MO_SL, 3);
>  }
>
>  /* XTheadSync */
> --
> 2.51.0
>
>

