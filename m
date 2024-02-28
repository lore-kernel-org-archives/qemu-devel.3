Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A9AC5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 12:21:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfIw5-0003EP-Eu; Wed, 28 Feb 2024 07:21:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rfIw3-0003CM-72
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 07:21:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rfIw1-0003Ht-HK
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 07:21:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709122876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Eiqxwv9OHlEZjddgbK8H+3zz1PiTsktvR2pES473PUo=;
 b=fSOwlNiYOnMIil5QcXzU67LdYbbD9XzPWSM7zg7Apsry6AIvxsmbeQ+shWnftcL34zmP2/
 8R9GA8ZI1RuDdYihb49oGDPBx1vlLjjzm+ORBFIx4L0N3yVSJ/83tJkxSlsMxF1nyOi4bL
 dsqHO64LsFsdywZKfN0kJ7IdcOQ5Iek=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443--HuZtuAVO2CzUQcZ8fjQ1w-1; Wed, 28 Feb 2024 07:21:14 -0500
X-MC-Unique: -HuZtuAVO2CzUQcZ8fjQ1w-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-33d1d766f83so2170396f8f.3
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 04:21:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709122873; x=1709727673;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Eiqxwv9OHlEZjddgbK8H+3zz1PiTsktvR2pES473PUo=;
 b=kJkA+kX1MxuC2MFvwpfA5cmf8gAXC2crtDqhkv/x1hO8LIYAYht4ug3nYkscgYEg6K
 QZNMlyxmly2hDSAKAtisduKuMb1DDKHWlK6MxDxJHWCBDULBwOBhdX2NuHY471LfgJMd
 ucpmDMRJ6mfsaVsSU/wxbEu4YxinbMKUDUjw9J0HoVqBpanuGPqHdRRvrKrfJTT6JGtL
 CiQagmk6m8nvMB13BHlPYLQniwu8SUrZbeu7VLIGOqC8GgUtJt5PgXk9viV5OQTNfFv4
 kXnQVuOWXP9E1lqLr/l44iYSSSmkvQCguMvuyJXixQLQanWFSLELCSTbLN4WGyxXQBKc
 Msaw==
X-Gm-Message-State: AOJu0YwxqWVwcrLkrsxdZUSsKSKN0Pwkhb5Tw1QTqopsNGI40eJw9QUf
 t5XebQdCa1FcbCvVLQBgKXb7cUTTwQF0BucPRRVnjXsBH2A23tPywfsWHYbOZYYPl9D96TjRZuf
 p60pRBFDlH9GlUPNZzNSl0Bv20VJPntPOvo/TB67B6v7qVrkzdNSpHHO/EiDZPO2JhygUNDGv2f
 Z7iIdjcmj61VGvZbN/ZCD8avKw8TKo75e5O78=
X-Received: by 2002:adf:efc5:0:b0:33d:746b:f377 with SMTP id
 i5-20020adfefc5000000b0033d746bf377mr8796489wrp.45.1709122873172; 
 Wed, 28 Feb 2024 04:21:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHB0Z6Px0e3dwReWVYF/id4vvYXwcU7kNdJtAu1vzQX5nig6/0guAgPjwhAnHrN8YfEA5HiyGtmi82ewCyw7xo=
X-Received: by 2002:adf:efc5:0:b0:33d:746b:f377 with SMTP id
 i5-20020adfefc5000000b0033d746bf377mr8796474wrp.45.1709122872811; Wed, 28 Feb
 2024 04:21:12 -0800 (PST)
MIME-Version: 1.0
References: <20240228110626.287178-1-pbonzini@redhat.com>
In-Reply-To: <20240228110626.287178-1-pbonzini@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 28 Feb 2024 13:21:01 +0100
Message-ID: <CABgObfZXaMp2N9A8j6n-QayhOeV3sinyk3RKPxU7Mch17kpF3g@mail.gmail.com>
Subject: Re: [PATCH] tcg/optimize: lower some ANDs to two shifts
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Sorry, that was sent incorrectly.

Paolo

On Wed, Feb 28, 2024 at 12:06=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com=
> wrote:
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tcg/optimize.c | 60 +++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 52 insertions(+), 8 deletions(-)
>
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index 3995bc047db..8ea1f287788 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -1281,6 +1281,43 @@ static bool fold_add2(OptContext *ctx, TCGOp *op)
>      return fold_addsub2(ctx, op, true);
>  }
>
> +static bool fold_and_to_shifts(OptContext *ctx, uint64_t c, TCGOp *op)
> +{
> +    TCGOpcode shl_opc =3D tcg->type =3D=3D TCG_TYPE_I32 ? INDEX_op_shl_i=
32 : INDEX_op_shl_i64;
> +    TCGOpcode shr_opc =3D tcg->type =3D=3D TCG_TYPE_I32 ? INDEX_op_shr_i=
32 : INDEX_op_shr_i64;
> +
> +    TCGOpcode first, second;
> +    int count;
> +    TCGOp *op2;
> +
> +    unsigned_c =3D tcg->type =3D=3D TCG_TYPE_I32 ? (uint32_t) c : c;
> +    if (is_power_of_2(-c) &&
> +         !tcg_op_imm_match(op->opc, c)) {
> +        /* AND with 11...11000, shift right then left.  */
> +        count =3D ctz64(c);
> +        first =3D shr_opc;
> +    } else if (is_power_of_2(c + 1) &&
> +               !tcg_op_imm_match(INDEX_op_and_i64, c)) {
> +        /* AND with 00...00111, shift left then right.  */
> +        int bits =3D tcg->type =3D=3D TCG_TYPE_I32 ? 32 : 64;
> +        count =3D bits - cto64(c);
> +        first =3D shl_opc;
> +    } else {
> +        return false;
> +    }
> +
> +
> +    op->opc =3D first;
> +    op->args[2] =3D arg_new_constant(ctx, count);
> +
> +    second =3D shl_opc ^ shr_opc ^ first;
> +    op2 =3D tcg_op_insert_after(ctx->tcg, op, second, 3);
> +    op2->args[0] =3D op->args[0];
> +    op2->args[1] =3D op->args[0];
> +    op2->args[2] =3D arg_new_constant(ctx, count);
> +    return true;
> +}
> +
>  static bool fold_and(OptContext *ctx, TCGOp *op)
>  {
>      uint64_t z1, z2;
> @@ -1294,6 +1331,18 @@ static bool fold_and(OptContext *ctx, TCGOp *op)
>
>      z1 =3D arg_info(op->args[1])->z_mask;
>      z2 =3D arg_info(op->args[2])->z_mask;
> +
> +    /*
> +     * Known-zeros does not imply known-ones.  Therefore unless
> +     * arg2 is constant, we can't infer affected bits from it.
> +     */
> +    if (arg_is_const(op->args[2])) {
> +        if (fold_and_to_shifts(ctx, z2, op)) {
> +            return true;
> +        }
> +        ctx->a_mask =3D z1 & ~z2;
> +    }
> +
>      ctx->z_mask =3D z1 & z2;
>
>      /*
> @@ -1303,14 +1352,6 @@ static bool fold_and(OptContext *ctx, TCGOp *op)
>      ctx->s_mask =3D arg_info(op->args[1])->s_mask
>                  & arg_info(op->args[2])->s_mask;
>
> -    /*
> -     * Known-zeros does not imply known-ones.  Therefore unless
> -     * arg2 is constant, we can't infer affected bits from it.
> -     */
> -    if (arg_is_const(op->args[2])) {
> -        ctx->a_mask =3D z1 & ~z2;
> -    }
> -
>      return fold_masks(ctx, op);
>  }
>
> @@ -1333,6 +1374,9 @@ static bool fold_andc(OptContext *ctx, TCGOp *op)
>       */
>      if (arg_is_const(op->args[2])) {
>          uint64_t z2 =3D ~arg_info(op->args[2])->z_mask;
> +        if (fold_and_to_shifts(ctx, z2, op)) {
> +            return true;
> +        }
>          ctx->a_mask =3D z1 & ~z2;
>          z1 &=3D z2;
>      }
> --
> 2.43.2


