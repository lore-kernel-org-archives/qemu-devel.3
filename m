Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C81BCCF9E9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 09:19:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE2JS-0005TO-N3; Wed, 29 Oct 2025 05:17:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vE2JO-0005Sr-Jy
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 05:17:46 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vE2JG-00057e-Ag
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 05:17:45 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b6d345d7ff7so168249366b.1
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 02:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761729454; x=1762334254; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F9yopHWa05k8ERpXJhW6U8q1+JQFUPafsdbHJKEqY04=;
 b=xZ5V9j50KHxZrf3Qv6Py0GYQab2OuXzs+zKYMzH1VqaswFo326+9fqYKV1+O0pUFcf
 kV8lYg6OJ9GMy3qhoWHOMgaHt2ZXv4lU5w+vM44VWKgHU5C6RGx0VyT6VPjgkSfbhgAU
 aA4IZ6e3CzDwcRpxTd6OOptC7SCEn7MOv4S1gvOa+ndGXAaFOdawFJmRCLbApY6JmHkZ
 lZNN4eNKleRccJa0miyRSbZsA8grLxUeAV+K1CjV7bLJdGELz6LHzX5VAZGUU0CN05n8
 KYoDWhOBCcYi5zk7qXVFfkRn0NQ7Hg99HBjq+2SQp7Qsq4APMe454mXfZcZ6XBHmbFg+
 6Qjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761729454; x=1762334254;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F9yopHWa05k8ERpXJhW6U8q1+JQFUPafsdbHJKEqY04=;
 b=v1mMWtgPF1R0v1MWQLhl8pbS0uUgoXBRZoYFOsP+SXayo+ADbzgpCl/AllBIXDCOgf
 +PtCUbxRkQBH9ZSEqsvUe14MkbdGw8yJTOw9rmBafVyK6JPRU1kVUHlDBaodZnD7tZsJ
 MA+VW+jb4/Zz0URDAzN2Fs44wyGBAyTe1wW1WSOHD+9/JhEKnHN6JDsp9EgcbmBAy0ub
 +hXbaoI40jN6yLUJQsjQaH7lyknsZe9q6QED3RRg02kT6z4UAuHZesUY4kiqFHmCvht5
 t5t4C4yZIrSAXVGrNqu1B64MsjBl1uqxptO/ZAsnSEXdI4Rez8QrSi/rRjOXaat/4UTz
 bvTA==
X-Gm-Message-State: AOJu0Yx8GBW1DQHHXCp9Dskgl07UNOABS9jDk3ZGeV1mUHFLBTu3Gmpf
 MMsViMQsWvOpnfA5ap7mjpXylCnCtQzq/QTMxigqUHLuDrDeCb3O/QcXBOOrSULBDEU8eGIwXWi
 vAJB8YHnKXHPpszA4j0jpruJL05TrAvran77IIVKjtg==
X-Gm-Gg: ASbGncu4ph5bMdpVHHdZU+PsVAR/T5k3PrTkkvNTaVT1wMzrai5Ymj8dKAnvKxxXJkN
 F1iGF6H3uWhHr+926LXqyo6wSClvVjQyOcFRoA8uAhFG/usuNNAmCnCxpzf9RKXPJjDTCpVwP0o
 3lCQDOROn0Jb5MUar9fnXE1PD4NolMVHZG5PABjstKE6FuouxUmJqGOCoCNwq+nsqjs5fMR1fnX
 M/0yOBTIbRox57JZj2Yvv+FFgCzGWYZtDhgBlvRoUhloqdy0esBmjgCfE3Q
X-Google-Smtp-Source: AGHT+IGqtjjFhcm6h3JGWEUoRXS1bY8rZLr3hivp4ibPnvVy1Ya7EjdLbXc6gRT4IoRNdjbZ/SmaQ/inYt6Eny51Q2k=
X-Received: by 2002:a17:907:9415:b0:b6d:5b07:c3f2 with SMTP id
 a640c23a62f3a-b703c1f320amr245200966b.32.1761729454522; Wed, 29 Oct 2025
 02:17:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250928163155.1472914-1-richard.henderson@linaro.org>
 <20250928163155.1472914-4-richard.henderson@linaro.org>
In-Reply-To: <20250928163155.1472914-4-richard.henderson@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 29 Oct 2025 11:17:08 +0200
X-Gm-Features: AWmQ_bm2LR0HVJiCCRlw9kfoySgwNoo9A1RvZ6SCKcwj43VqgZdKRkIxJud_weQ
Message-ID: <CAAjaMXYprOwD+Xde+5_2Bz1O2ExqCv4+omftoXWB924UwSoKug@mail.gmail.com>
Subject: Re: [PATCH 3/5] tcg/optimize: Lower unsupported extract2 during
 optimize
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Sun, Sep 28, 2025 at 7:33=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The expansions that we chose in tcg-op.c may be less than optimial.
> Delay lowering until optimize, so that we have propagated constants
> and have computed known zero/one masks.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  tcg/optimize.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++----
>  tcg/tcg-op.c   |  9 ++------
>  2 files changed, 60 insertions(+), 12 deletions(-)
>
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index 5df57049c2..47fbcd73e3 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -2161,21 +2161,74 @@ static bool fold_extract2(OptContext *ctx, TCGOp =
*op)
>      uint64_t z2 =3D t2->z_mask;
>      uint64_t o1 =3D t1->o_mask;
>      uint64_t o2 =3D t2->o_mask;
> +    uint64_t zr, or;
>      int shr =3D op->args[3];
> +    int shl;
>
>      if (ctx->type =3D=3D TCG_TYPE_I32) {
>          z1 =3D (uint32_t)z1 >> shr;
>          o1 =3D (uint32_t)o1 >> shr;
> -        z2 =3D (uint64_t)((int32_t)z2 << (32 - shr));
> -        o2 =3D (uint64_t)((int32_t)o2 << (32 - shr));
> +        shl =3D 32 - shr;
> +        z2 =3D (uint64_t)((int32_t)z2 << shl);
> +        o2 =3D (uint64_t)((int32_t)o2 << shl);
>      } else {
>          z1 >>=3D shr;
>          o1 >>=3D shr;
> -        z2 <<=3D 64 - shr;
> -        o2 <<=3D 64 - shr;
> +        shl =3D 64 - shr;
> +        z2 <<=3D shl;
> +        o2 <<=3D shl;
> +    }
> +    zr =3D z1 | z2;
> +    or =3D o1 | o2;
> +
> +    if (zr =3D=3D or) {
> +        return tcg_opt_gen_movi(ctx, op, op->args[0], zr);
>      }
>
> -    return fold_masks_zo(ctx, op, z1 | z2, o1 | o2);
> +    if (z2 =3D=3D 0) {
> +        /* High part zeros folds to simple right shift. */
> +        op->opc =3D INDEX_op_shr;
> +        op->args[2] =3D arg_new_constant(ctx, shr);
> +    } else if (z1 =3D=3D 0) {
> +        /* Low part zeros folds to simple left shift. */
> +        op->opc =3D INDEX_op_shl;
> +        op->args[1] =3D op->args[2];
> +        op->args[2] =3D arg_new_constant(ctx, shl);
> +    } else if (!tcg_op_supported(INDEX_op_extract2, ctx->type, 0)) {
> +        TCGArg tmp =3D arg_new_temp(ctx);
> +        TCGOp *op2 =3D opt_insert_before(ctx, op, INDEX_op_shr, 3);
> +
> +        op2->args[0] =3D tmp;
> +        op2->args[1] =3D op->args[1];
> +        op2->args[2] =3D arg_new_constant(ctx, shr);
> +
> +        if (TCG_TARGET_deposit_valid(ctx->type, shl, shr)) {
> +            /*
> +             * Deposit has more arguments than extract2,
> +             * so we need to create a new TCGOp.
> +             */
> +            op2 =3D opt_insert_before(ctx, op, INDEX_op_deposit, 5);
> +            op2->args[0] =3D op->args[0];
> +            op2->args[1] =3D tmp;
> +            op2->args[2] =3D op->args[2];
> +            op2->args[3] =3D shl;
> +            op2->args[4] =3D shr;
> +
> +            tcg_op_remove(ctx->tcg, op);
> +            op =3D op2;
> +        } else {
> +            op2 =3D opt_insert_before(ctx, op, INDEX_op_shl, 3);
> +            op2->args[0] =3D op->args[0];
> +            op2->args[1] =3D op->args[2];
> +            op2->args[2] =3D arg_new_constant(ctx, shl);
> +
> +            op->opc =3D INDEX_op_or;
> +            op->args[1] =3D op->args[0];
> +            op->args[2] =3D tmp;
> +        }
> +    }
> +
> +    return fold_masks_zo(ctx, op, zr, or);
>  }
>
>  static bool fold_exts(OptContext *ctx, TCGOp *op)
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index abce307f26..4caf77da1e 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -1008,13 +1008,8 @@ void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 a=
l, TCGv_i32 ah,
>          tcg_gen_mov_i32(ret, ah);
>      } else if (al =3D=3D ah) {
>          tcg_gen_rotri_i32(ret, al, ofs);
> -    } else if (tcg_op_supported(INDEX_op_extract2, TCG_TYPE_I32, 0)) {
> -        tcg_gen_op4i_i32(INDEX_op_extract2, ret, al, ah, ofs);
>      } else {
> -        TCGv_i32 t0 =3D tcg_temp_ebb_new_i32();
> -        tcg_gen_shri_i32(t0, al, ofs);
> -        tcg_gen_deposit_i32(ret, t0, ah, 32 - ofs, ofs);
> -        tcg_temp_free_i32(t0);
> +        tcg_gen_op4i_i32(INDEX_op_extract2, ret, al, ah, ofs);
>      }
>  }
>
> @@ -2711,7 +2706,7 @@ void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al=
, TCGv_i64 ah,
>          tcg_gen_mov_i64(ret, ah);
>      } else if (al =3D=3D ah) {
>          tcg_gen_rotri_i64(ret, al, ofs);
> -    } else if (tcg_op_supported(INDEX_op_extract2, TCG_TYPE_I64, 0)) {
> +    } else if (TCG_TARGET_REG_BITS =3D=3D 64) {
>          tcg_gen_op4i_i64(INDEX_op_extract2, ret, al, ah, ofs);
>      } else {
>          TCGv_i64 t0 =3D tcg_temp_ebb_new_i64();
> --
> 2.43.0
>
>

