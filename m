Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F95606A323
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 20:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Xa0WMCBG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJdIX-0008KS-9g; Wed, 21 Oct 2026 16:52:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xJdIU-0008H6-Dl
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 16:52:31 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xJdIS-0007aI-MN
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 16:52:30 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-3ab30b3212aso10691141fa.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 13:52:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792615946; cv=none;
 d=google.com; s=arc-20260327;
 b=LPh+euWddfJOPwV/3V7mY4xvOpr3TSa+MxKSVrsRwOudVx537cjaaIhP21NXpF5S6B
 5eEInfT93vP4ZazfgYl/e/dn+31ioXdgjXktt1jlRsu2PU4pjFrIwidmqPJ/QV8Zz/2t
 R4/brqf3Q+Np6yPfhHQFz7ps5QQyQWsKq4HFjXWzDFeaHwQ7nqp4W+QdUE1l4/XHMatZ
 oGcAQRsNMUuP0ts0TvO1LrKOMKQUV1AKtpCQNqC41C2G6Zi5fZ7Df9k0XglsjlwjpsSM
 iidd3aEBIwW5wfXpbSWbs0kyN53WwXMfT5LsUweJgCx4aE6gWyq8z45f2ZkdvBvoe8J4
 kDNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fJRrsLgj6lOAPECrVzUbl4NVJGRGme/b2ReeI4GYVjA=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=JOTiao1aR6xHzfyLEvLMb521sOqdMg2yQHSJTmLa2kIJPSf/TU6aHCMnVAcgSWANdB
 LOqwUM6ZGffweLccuMVw23Zb+HATnpT6REsRFSmrJ2c9YGhuloklIkxe3yuVGIyoZLBs
 cTTM2Jcw3YiyGXH+6DG7ZTQTIS7HIBhzsoGum2HHr9reIzAmDc8IXVRl3fQE+D8Gl+jC
 eHrDvn2Q9AuG7BqpIDt3JK7pz0EOsaZZreQzUZbNdy6FRag5Ln+qqHTc++2mhf569Pli
 pyR36wvPd8SdaiRlyshqbXnSHioJh7jVTx7d2zZ+sI2Myf201+X/8R4AqFY6r5h5uSAo
 +erw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792615946; x=1793220746; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fJRrsLgj6lOAPECrVzUbl4NVJGRGme/b2ReeI4GYVjA=;
 b=Xa0WMCBGGnCJ6TKQgjnyKH+D2UGvTcWxjIAJC/sVGhzo6RZoA7xpqsA3xmHzcPd1nj
 yfOxayeRCD/xVFsOKv3Fcbd8uBrl3Jy7V2tIAes8Gv4shBJhZuFNWMh+yOs02HM0ytcA
 p1dQD1+Ihi97FZ69LuGYz+D5m2R3NEyRcSf1WUflirSNfA80AgBM2Og8AAEd+I9pksfg
 +xC1fx1PZ3AuXbFooPRZCCswzR/U4MuJ+TlMVeKa6iubrRcUmnsEWVzd0E2b81c6x1dG
 mvtPMO2nS4qtDQ9EhsDE+mvGGrwsn7EunrC9fsoK2fXMSJfbHwhGy4MVVVVkjUJZ0qBh
 hsGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792615946; x=1793220746;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fJRrsLgj6lOAPECrVzUbl4NVJGRGme/b2ReeI4GYVjA=;
 b=dY4sxE2LqKNnnw6i0n6ahWF27oz4Woccj+CjxeeRf/zA7/oLVtmPMwGOU5Omr90pJA
 OnjDaInLwbLJR78GFfWobzIAbJVwofoVkvNDeF9H2LdwdmqGP9CJ4xGl/A4AejSYcC8p
 dLM8W0WI67e83gLL2bkQflYufuI9Shnn187z/9cLOTZFmkg+mEa4pKBgJuPJMAg+t0hU
 eyx7PaDQ1jV10v2apQuelJIajdoZ6LZ93KetNZCk69HCqFSfTJ9xGyquT9lKN3ypELYS
 eqfUM/AFKBnq/txga/vtLMRaalE+8Mi+msGSTqZPvsjL5aOrwxb4qKrucH0RVdzEamGy
 1OsA==
X-Gm-Message-State: AFq9FYI3lFi1QSz3LXuqSMOKpqGmq2d14Fk/fOpE4kOSy93ObNgpd/R3
 DqW6+EXh9MseYZqkVeWxY/AJUWdygQ2RYAJkXDV8wec34e7kc59IJkVeMt4gn5puo5Rb8CjUDxu
 cPGc7m1/Ch8eFgjyPgTpao1+X5qNn49p34SCqWI4=
X-Gm-Gg: AYBFou0kdFvg5nNaotjSl7bvcFzDnNPwcWW+wjKKAI0Y7vBr0HfjpinqgUNS5nMHtdu
 6wyYx7ai/BbNdRx3Y7QyLl/ePAyDwJBWD9P9SgHarftOs8DfEi1btWd+Magyy4xsyNi337MYhul
 l77EuaGtJPz3V1BgkiIFL6RKy3L5tO5CrQ4M1b3OWCfrN/uFDCOIwZt8es+HZsVACc9GjRkE43u
 M54pFEOZ7g92d4ejsHbLEdxuEw1zqFEkco7YmW9vefSOTw2mxHBtx9YZLl9ZKFcfoKYIVqYISqR
 uYzImc+UnK4SeEWEnJMYVUwXFkXKnKTXjjMv0/bCkYeZuYk7uflXCLXyj5tfnRkhelvGtKQ7riq
 KQFKg3Jzve5Jrg03gBtvKUu4d7WZADbcCWK3BCwWE9iE+/mon6/IizAYszxTmMbylmnhltsoUzZ
 R9v6wYyCYhPXzzzTdKvfetrrdGqAgFkYI6reQHoHOcrLYHYhBbF5K7
X-Received: by 2002:a2e:b88b:0:b0:3ac:4ce6:8b73 with SMTP id
 38308e7fff4ca-3ac4ce68e14mr4415541fa.22.1792615946105; Wed, 21 Oct 2026
 13:52:26 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261021141652.363109-1-richard.henderson@linaro.org>
 <20261021141652.363109-78-richard.henderson@linaro.org>
In-Reply-To: <20261021141652.363109-78-richard.henderson@linaro.org>
From: Matt Turner <mattst88@gmail.com>
Date: Wed, 21 Oct 2026 16:52:13 -0400
X-Gm-Features: AclHuK9n-wOlryQxEQRxTGT8U6flB2F1EL-eYonxbcvcqrNbwitgjnQnksYnss4
Message-ID: <CAEdQ38Gu=PudDOb=r1c0-ZjoD-SBE2RygzFreZardoqkV3DSJg@mail.gmail.com>
Subject: Re: [PATCH v6 077/100] tcg: Generic expansion of tcg_gen_extract2_*
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=mattst88@gmail.com; helo=mail-lj1-x232.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 10:22=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/tcg/tcg-op-common.h  |  4 ---
>  include/tcg/tcg-op-def.h.inc |  1 +
>  tcg/tcg-op.c                 | 69 +++++++++---------------------------
>  3 files changed, 18 insertions(+), 56 deletions(-)
>
> diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
> index 6942012787..c1c41a03f3 100644
> --- a/include/tcg/tcg-op-common.h
> +++ b/include/tcg/tcg-op-common.h
> @@ -132,8 +132,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned me=
minfo);
>
>  /* 32 bit ops */
>
> -void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
> -                          unsigned int ofs);
>  void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
>                        TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh);
>  void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
> @@ -164,8 +162,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg=
_target_long offset);
>
>  /* 64 bit ops */
>
> -void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
> -                          unsigned int ofs);
>  void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
>                        TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh);
>  void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
> diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
> index 82dfc90009..a237ccd0c5 100644
> --- a/include/tcg/tcg-op-def.h.inc
> +++ b/include/tcg/tcg-op-def.h.inc
> @@ -26,6 +26,7 @@ DEF2(ext8u, TCGV, TCGV)
>  DEF2(ext16s, TCGV, TCGV)
>  DEF2(ext16u, TCGV, TCGV)
>  DEF4(extract, TCGV, TCGV, unsigned, unsigned)
> +DEF4(extract2, TCGV, TCGV, TCGV, unsigned)
>  DEF3(eqv, TCGV, TCGV, TCGV)
>  DEF2(mov, TCGV, TCGV)
>  DEF2(movi, TCGV, TINT)
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index f6cc56661d..712536cfc2 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -183,20 +183,6 @@ static void DNI tcg_gen_op4_i64(TCGOpcode opc, TCGv_=
i64 a1, TCGv_i64 a2,
>                  tcgv_i64_arg(a3), tcgv_i64_arg(a4));
>  }
>
> -static void DNI tcg_gen_op4i_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2=
,
> -                                 TCGv_i32 a3, TCGArg a4)
> -{
> -    tcg_gen_op4(opc, TCG_TYPE_I32, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
> -                tcgv_i32_arg(a3), a4);
> -}
> -
> -static void DNI tcg_gen_op4i_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2=
,
> -                                 TCGv_i64 a3, TCGArg a4)
> -{
> -    tcg_gen_op4(opc, TCG_TYPE_I64, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
> -                tcgv_i64_arg(a3), a4);
> -}
> -
>  /* Generic ops.  */
>
>  void gen_set_label(TCGLabel *l)
> @@ -691,6 +677,23 @@ void tcg_gen_extract(TCGType type, TCGTemp *dst, TCG=
Temp *src,
>      }
>  }
>
> +void tcg_gen_extract2(TCGType type, TCGTemp *dst, TCGTemp *lo, TCGTemp *=
hi,
> +                      unsigned int ofs)
> +{
> +    unsigned width =3D tcg_type_bits(type);
> +
> +    tcg_debug_assert(ofs <=3D width);
> +    if (ofs =3D=3D 0) {
> +        tcg_gen_mov(type, dst, lo);
> +    } else if (ofs =3D=3D width) {
> +        tcg_gen_mov(type, dst, hi);
> +    } else if (lo =3D=3D hi) {
> +        tcg_gen_rotri(type, dst, lo, ofs);
> +    } else {
> +        tcg_gen_op_ttti(INDEX_op_extract2, type, dst, lo, hi, ofs);
> +    }
> +}
> +
>  void tcg_gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
>  {
>      if (src !=3D dst) {
> @@ -1119,25 +1122,6 @@ void tcg_gen_xori(TCGType type, TCGTemp *dst, TCGT=
emp *src1, int64_t src2)
>
>  /* 32 bit ops */
>
> -/*
> - * Extract 32-bits from a 64-bit input, ah:al, starting from ofs.
> - * Unlike tcg_gen_extract_i32 above, len is fixed at 32.
> - */
> -void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
> -                          unsigned int ofs)
> -{
> -    tcg_debug_assert(ofs <=3D 32);
> -    if (ofs =3D=3D 0) {
> -        tcg_gen_mov_i32(ret, al);
> -    } else if (ofs =3D=3D 32) {
> -        tcg_gen_mov_i32(ret, ah);
> -    } else if (al =3D=3D ah) {
> -        tcg_gen_rotri_i32(ret, al, ofs);
> -    } else {
> -        tcg_gen_op4i_i32(INDEX_op_extract2, ret, al, ah, ofs);
> -    }
> -}
> -
>  void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
>                        TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh)
>  {
> @@ -1674,25 +1658,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 a=
rg)
>      }
>  }
>
> -/*
> - * Extract 64 bits from a 128-bit input, ah:al, starting from ofs.
> - * Unlike tcg_gen_extract_i64 above, len is fixed at 64.
> - */

We're dropping this comment. Dunno if you want to keep it in the refactor.

