Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C2FBCCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 05:01:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8XAF-00007F-Ha; Tue, 14 Oct 2025 01:01:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v8XAA-0008Ut-EM
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 01:01:31 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v8XA5-0003H1-Bh
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 01:01:28 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-631787faf35so9694664a12.3
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 22:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760418083; x=1761022883; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IDPx/F7i2mLMEkBQ5n7vFliSEBq3lTA9JBHMF+hmLDM=;
 b=JVblFw2rrxyHi/0orM2Rc2ytgYGv2MyjLQr788IJR1o791toR5Oth+WUbuf+7fe3Fc
 5hwMy++sCmfpP/3X/DZr32rIJZbtHatFtlPQu8zTYhII+iOzZMzFHQSoaOWK8L1DLvYG
 jsGV23sWnDu11FGu3yPQNTdtUCegCCcMRc+mJe/G5rjoQpQ3SyemdmMqsCb80aCAlNli
 uE9VDK0hPhpsIkbqC63KX3h+bsH/Hds/4qyGowLYrYNIx/FhcsiIFGift+3ZNSI/19yE
 Z8n+qsafmE3ArIAdT6/daAMNqCzqVllPMQcwsV+AqZPT6K2kVGFf/+a5RBIli+rr7VYM
 ylWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760418083; x=1761022883;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IDPx/F7i2mLMEkBQ5n7vFliSEBq3lTA9JBHMF+hmLDM=;
 b=h6rfxW4h4mmhT9lyNzCti3Zn2T3atGhv/9b1e04wSt4OaT4SJo9vEHBSoNZmpYdexa
 BgsgbfD4cEvt3b+kPtETyUtRxtZ/jNqTB1P4AjueP5JwI2J5a3jBylF7J8Dm258LohoA
 Mx7i14tJK6iLW2n4SsKt/Be6IeoTKsn/++n/Zdxb/3fuiHImmynbDVUK3qgFvAIE3Br6
 QLfLqiNAOCFWLrILmgGubWRXbvnE6vPAz9Jcyk/yjEi2GwsF+N3Ul545GNmyPeNfsQ1I
 MSNR1POfDZpiIAko4oCJaRJymhoTAsXAIZpCxwXJ4bd2hlZVLlk3SQSGNdn436LkxWag
 aSjQ==
X-Gm-Message-State: AOJu0YxcfInAM73+FyOSkwt3PUXJKF05UuUckVFK1HTJRZOkJcB9Y/bR
 QCNfz48JCW3naxNX81nBVpaBPeXKF8l7JLhQYqnJTbypzPYwQDuMhwMawF8SVUTFLmGgqEqjilH
 G1rA5Cz+z/dgjleWSr7WweW+2KRZQTxE=
X-Gm-Gg: ASbGnctgeQaWoJO0BYKaZT7u+B3A9xdNx02NPGwEdHEnjSvHTIlYrbcV1jwcBUI69/L
 GWZTfMdmjZBcBj2j0dnkb23P6Hvdm6JXsPbwzoBPrytPpqh1L0nbxHHD7RiW6W6dBCViZh67gtU
 6jZixZfz6wPXlpMtltJ007AVJN1h1vg7xpYzMU/P7+M+EBVvW2z1q2CShrJjSUc7LnTnKPMtLOv
 CI2l/fHeqrRmz0d4AfmAdkmKuC7MMeTcVfm2Qw7Hz67lKO5jmHk/PLh
X-Google-Smtp-Source: AGHT+IG6Zhg6zcVQntx0Nx7m0jSGxdGDpiqGeBwpyuGH0SVhDInYgf7WFn6u3lQZ59N4QxlqAYjRmHOw+uiL5qwyGpY=
X-Received: by 2002:a05:6402:1ed0:b0:639:e5b1:def1 with SMTP id
 4fb4d7f45d1cf-639e5b1e2e6mr17978593a12.4.1760418083117; Mon, 13 Oct 2025
 22:01:23 -0700 (PDT)
MIME-Version: 1.0
References: <20251010155045.78220-1-philmd@linaro.org>
 <20251010155045.78220-4-philmd@linaro.org>
In-Reply-To: <20251010155045.78220-4-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 14 Oct 2025 15:00:56 +1000
X-Gm-Features: AS18NWAZ6HHzFmfwdaG_19UdAPxP0uuNmr4cqFDgYcBznRtrQu1Phfk23my4-Bk
Message-ID: <CAKmqyKNVoAPyyzbpPDOYoyui4Uu3S55B5mBbhpoFHPf2-=shuw@mail.gmail.com>
Subject: Re: [PATCH 03/13] target/riscv: Conceal MO_TE within gen_amo()
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
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x529.google.com
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

On Sat, Oct 11, 2025 at 1:53=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> All callers of gen_amo() set the MO_TE flag. Set it once in
> the callee.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/translate.c                    |  1 +
>  target/riscv/insn_trans/trans_rva.c.inc     | 36 ++++++++++-----------
>  target/riscv/insn_trans/trans_rvzabha.c.inc | 18 +++++------
>  3 files changed, 28 insertions(+), 27 deletions(-)
>
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 9a53aecbfe9..94af9853cfe 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -1135,6 +1135,7 @@ static bool gen_amo(DisasContext *ctx, arg_atomic *=
a,
>      TCGv src1, src2 =3D get_gpr(ctx, a->rs2, EXT_NONE);
>      MemOp size =3D mop & MO_SIZE;
>
> +    mop |=3D MO_TE;
>      if (ctx->cfg_ptr->ext_zama16b && size >=3D MO_32) {
>          mop |=3D MO_ATOM_WITHIN16;
>      } else {
> diff --git a/target/riscv/insn_trans/trans_rva.c.inc b/target/riscv/insn_=
trans/trans_rva.c.inc
> index 10e4c55efda..e0fbfafdde4 100644
> --- a/target/riscv/insn_trans/trans_rva.c.inc
> +++ b/target/riscv/insn_trans/trans_rva.c.inc
> @@ -111,55 +111,55 @@ static bool trans_sc_w(DisasContext *ctx, arg_sc_w =
*a)
>  static bool trans_amoswap_w(DisasContext *ctx, arg_amoswap_w *a)
>  {
>      REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_TE | MO_SL);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_SL);
>  }
>
>  static bool trans_amoadd_w(DisasContext *ctx, arg_amoadd_w *a)
>  {
>      REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, MO_TE | MO_SL);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, MO_SL);
>  }
>
>  static bool trans_amoxor_w(DisasContext *ctx, arg_amoxor_w *a)
>  {
>      REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, MO_TE | MO_SL);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, MO_SL);
>  }
>
>  static bool trans_amoand_w(DisasContext *ctx, arg_amoand_w *a)
>  {
>      REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, MO_TE | MO_SL);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, MO_SL);
>  }
>
>  static bool trans_amoor_w(DisasContext *ctx, arg_amoor_w *a)
>  {
>      REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, MO_TE | MO_SL);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, MO_SL);
>  }
>
>  static bool trans_amomin_w(DisasContext *ctx, arg_amomin_w *a)
>  {
>      REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, MO_TE | MO_SL)=
;
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, MO_SL);
>  }
>
>  static bool trans_amomax_w(DisasContext *ctx, arg_amomax_w *a)
>  {
>      REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, MO_TE | MO_SL)=
;
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, MO_SL);
>  }
>
>  static bool trans_amominu_w(DisasContext *ctx, arg_amominu_w *a)
>  {
>      REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, MO_TE | MO_SL)=
;
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, MO_SL);
>  }
>
>  static bool trans_amomaxu_w(DisasContext *ctx, arg_amomaxu_w *a)
>  {
>      REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, MO_TE | MO_SL)=
;
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, MO_SL);
>  }
>
>  static bool trans_lr_d(DisasContext *ctx, arg_lr_d *a)
> @@ -180,61 +180,61 @@ static bool trans_amoswap_d(DisasContext *ctx, arg_=
amoswap_d *a)
>  {
>      REQUIRE_64BIT(ctx);
>      REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_TE | MO_UQ);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_UQ);
>  }
>
>  static bool trans_amoadd_d(DisasContext *ctx, arg_amoadd_d *a)
>  {
>      REQUIRE_64BIT(ctx);
>      REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, MO_TE | MO_UQ);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, MO_UQ);
>  }
>
>  static bool trans_amoxor_d(DisasContext *ctx, arg_amoxor_d *a)
>  {
>      REQUIRE_64BIT(ctx);
>      REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, MO_TE | MO_UQ);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, MO_UQ);
>  }
>
>  static bool trans_amoand_d(DisasContext *ctx, arg_amoand_d *a)
>  {
>      REQUIRE_64BIT(ctx);
>      REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, MO_TE | MO_UQ);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, MO_UQ);
>  }
>
>  static bool trans_amoor_d(DisasContext *ctx, arg_amoor_d *a)
>  {
>      REQUIRE_64BIT(ctx);
>      REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, MO_TE | MO_UQ);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, MO_UQ);
>  }
>
>  static bool trans_amomin_d(DisasContext *ctx, arg_amomin_d *a)
>  {
>      REQUIRE_64BIT(ctx);
>      REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, MO_TE | MO_UQ)=
;
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, MO_UQ);
>  }
>
>  static bool trans_amomax_d(DisasContext *ctx, arg_amomax_d *a)
>  {
>      REQUIRE_64BIT(ctx);
>      REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, MO_TE | MO_UQ)=
;
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, MO_UQ);
>  }
>
>  static bool trans_amominu_d(DisasContext *ctx, arg_amominu_d *a)
>  {
>      REQUIRE_64BIT(ctx);
>      REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, MO_TE | MO_UQ)=
;
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, MO_UQ);
>  }
>
>  static bool trans_amomaxu_d(DisasContext *ctx, arg_amomaxu_d *a)
>  {
>      REQUIRE_64BIT(ctx);
>      REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, MO_TE | MO_UQ)=
;
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, MO_UQ);
>  }
> diff --git a/target/riscv/insn_trans/trans_rvzabha.c.inc b/target/riscv/i=
nsn_trans/trans_rvzabha.c.inc
> index 25db42d24cd..c1f99b65f09 100644
> --- a/target/riscv/insn_trans/trans_rvzabha.c.inc
> +++ b/target/riscv/insn_trans/trans_rvzabha.c.inc
> @@ -79,55 +79,55 @@ static bool trans_amomaxu_b(DisasContext *ctx, arg_am=
omaxu_b *a)
>  static bool trans_amoswap_h(DisasContext *ctx, arg_amoswap_h *a)
>  {
>      REQUIRE_ZABHA(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_TE | MO_SW);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_SW);
>  }
>
>  static bool trans_amoadd_h(DisasContext *ctx, arg_amoadd_h *a)
>  {
>      REQUIRE_ZABHA(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, MO_TE | MO_SW);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, MO_SW);
>  }
>
>  static bool trans_amoxor_h(DisasContext *ctx, arg_amoxor_h *a)
>  {
>      REQUIRE_ZABHA(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, MO_TE | MO_SW);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, MO_SW);
>  }
>
>  static bool trans_amoand_h(DisasContext *ctx, arg_amoand_h *a)
>  {
>      REQUIRE_ZABHA(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, MO_TE | MO_SW);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, MO_SW);
>  }
>
>  static bool trans_amoor_h(DisasContext *ctx, arg_amoor_h *a)
>  {
>      REQUIRE_ZABHA(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, MO_TE | MO_SW);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, MO_SW);
>  }
>
>  static bool trans_amomin_h(DisasContext *ctx, arg_amomin_h *a)
>  {
>      REQUIRE_ZABHA(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, MO_TE | MO_SW)=
;
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, MO_SW);
>  }
>
>  static bool trans_amomax_h(DisasContext *ctx, arg_amomax_h *a)
>  {
>      REQUIRE_ZABHA(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, MO_TE | MO_SW)=
;
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, MO_SW);
>  }
>
>  static bool trans_amominu_h(DisasContext *ctx, arg_amominu_h *a)
>  {
>      REQUIRE_ZABHA(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, MO_TE | MO_SW)=
;
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, MO_SW);
>  }
>
>  static bool trans_amomaxu_h(DisasContext *ctx, arg_amomaxu_h *a)
>  {
>      REQUIRE_ZABHA(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, MO_TE | MO_SW)=
;
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, MO_SW);
>  }
>
>  static bool trans_amocas_b(DisasContext *ctx, arg_amocas_b *a)
> --
> 2.51.0
>
>

