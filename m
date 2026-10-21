Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4669606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 20:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gElzwbDo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJdGH-0007Rt-Cx; Wed, 21 Oct 2026 16:50:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xJdGF-0007Rj-OH
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 16:50:11 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xJdGD-0007P9-Qi
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 16:50:11 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-3ab3dd966e1so9105351fa.2
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 13:50:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792615808; cv=none;
 d=google.com; s=arc-20260327;
 b=FLghFdCqoiYLqIxCnzxwyloUrfomAM1285we477wbqvtVdnJl0yWW9ljaLnKxTyGa/
 InWk2JoA0hjAxVEELdnuVClOWael2TT6wabHlmPAZHBfEyl/9XJqHPS+S0UC6WE/U8pD
 AxGgevxJ8ztw6BK3JPJvOqjV8gYslxpO/gmL5WFQST3edvDIK4bKeOnr9IE/RoQDh2wp
 tXAIA1pCu/Zclj0upuH/SQjgMQMSPfXH31vuoTFcH4HrSFdj+qzPyNCoGwNATef7WHDT
 51GLzLUx4R6916LaA5qB8O8QA/i5CDU7R6iiSvGRU+DFrONJmPLsEYLr+QQK2RKuF35/
 /H2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=X2ZDezcKlnPW/oIxf8c+xtiC4rXEGI/ooM82CLwvu9A=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=XjfAe8aA7uU9ZAjYKRuYQiqe+EmNjjqKPXi7qc0gnZJUHtzHVvVn9Vp8dVLY/NrB+z
 n6aq6aOTLW+DpBvsdC5jDRxECBW+cClzNH87nuuIFsfbdRcfXxPX6gH8NfreekEmNjfs
 ywh4RiPgnO8fUXNXAWzAiwUQMGKPE6N3PFkUkIgDrb48/08GfY6ueyI98BMC3cw8uqqG
 BS21LQr4iTW5WHKIRcqRvmKLx2xGDXFPuVKAaQZ4Nu0yVE5j2YzuBxVXpsR2sv7GNlDd
 /iqJBVAu8X0UL5jhqMlGBeKYp7XFlW20q4acpVrjQcdA9r0L0sSp08xG663XYHAFhQRE
 cC/Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792615808; x=1793220608; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=X2ZDezcKlnPW/oIxf8c+xtiC4rXEGI/ooM82CLwvu9A=;
 b=gElzwbDowygvoCYx7iWZxTq9fDi29vMflV+rfPUCKCk0Y78J+dMxbLavtYvZYNepgE
 P9mSBq3MAPB8rCh9vwpAnqObLUzmQ/u0jkbHk7Hh2tAF87TUx2WDxvTUoU1ShqaZDwES
 sIN93YfTfjmK7UiDbH5vx4NcWYwMEVtQCe/S9lIFvP/xHmNmJq6Hfgd73vlrjgGfp7y/
 s/R/dCQcFgQUlt9BaSwAfWX7q0+E7XFsmikORLufO45NR45Emt61ouA3fQdEfGIikj3q
 Xvv2qd+oG5Tj4lewXkxNUBzuuzkbZsz6L2+R5VJtLXMfNfC+LPFWRQJ0N5Y/hzqVThuF
 NR5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792615808; x=1793220608;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=X2ZDezcKlnPW/oIxf8c+xtiC4rXEGI/ooM82CLwvu9A=;
 b=X2/twxhg4ErqD+nHogVzO0VAu+16r639kPyI2w3JyZYnsPZgbD1OGCZpN8PixQ0GJD
 FFZAOQq659SNOo0SuqZVFyxMFmFN23aPKqCnGepCfvo8ROt7CsGjC2t32QMjFk6CWW6+
 aHvveXGQ59qmnGT2hoQOZr+gstG6eeX2B32N0Zc3y8JA9J1fQtyisqZm/Pp0FjXpL6ot
 b9PMaF2E1AiS43ktjzjy+N70+4rpgwzi+lkjS+6XVzLUp6t1E2J+JZcXQ0At4548VAQE
 zcKPmPPH++fs26ejacP9Ke9ZyiQKUv1zMqM9eXSZ7BXvD0p1g+Cpeip+aewPk9oSEpH6
 zK5A==
X-Gm-Message-State: AFq9FYLJzpRCO8a65r9jSM2QF+SPXYEwq9HoYpz+j6R6NrFCLwVRaBKm
 UiaP3gR34IyyhSagfh4EUGK9JsJIa9ucX1Jqft9yInIporFGbycjXPWvdU0pY4JVVBqTHqgtSBG
 PDC6xRLuHG/gFpG3GbQ4aaxS2BEgwK40=
X-Gm-Gg: AYBFou163iJA6niJGaLASjyu3SX9/KkeXJ8Td5vxMHxS+Kqm7f8/9gopnocqr7cVDbb
 cLicJ/N42OaDgfTSqhTiuy+xzrztaOdB4FUdNXlp7kS+ppH+IhQ9nG6NELJ+L9HDEHkgvXwNrL2
 PmIOsDeU6m1XR+MwoGbZhyF1XI9PZ947s0PvgI6puzWmBixVctRWEfcthvjhQIfTlr18wh30iJ7
 WIcefdglkn23yOJx6Xfle+QqbCncDs3bahoSt2VnVgmUPsTV2xjHSAiYhVN1FELvd/8D1YPEGzT
 mLxWXoe4GmOfvMgqMcSXEudazAns/qUYxLRdHe0BaLvAVTeULvd++lp9HQC0ooKuTzqGt/XkX1j
 BYFHJqDZ6uy6Ps3VKJ86QUZZ3H5bCVl6XgoxssWD1SDCpcHkGUiAHhOgJV7jR8tSnktKxnwbk+m
 EgDoyN7sSC1VHbYQCQF4zfMuPOIy7U2h1PI1ySgXD4riJ+Ms/sAqzs
X-Received: by 2002:a2e:bc02:0:b0:3a9:d407:41f6 with SMTP id
 38308e7fff4ca-3ac441d43a0mr9657771fa.26.1792615807698; Wed, 21 Oct 2026
 13:50:07 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261021141652.363109-1-richard.henderson@linaro.org>
 <20261021141652.363109-85-richard.henderson@linaro.org>
In-Reply-To: <20261021141652.363109-85-richard.henderson@linaro.org>
From: Matt Turner <mattst88@gmail.com>
Date: Wed, 21 Oct 2026 16:49:54 -0400
X-Gm-Features: AclHuK9Q46u4BTZwcUM70YIC5GzXLnmYMR5AyY6rWVAb3m_g8JVq2Pcyx5uYavY
Message-ID: <CAEdQ38H0ORwHrEXj_0Gc0OZt1k0jxheq-Zxsdw+rfwgbQEwZtA@mail.gmail.com>
Subject: Re: [PATCH v6 084/100] tcg: Generic expansion of tcg_gen_bswap16_*
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=mattst88@gmail.com; helo=mail-lj1-x233.google.com
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

On Wed, Oct 21, 2026 at 10:26=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/tcg/tcg-op-common.h  |   2 -
>  tcg/tcg-internal.h           |   6 ++
>  include/tcg/tcg-op-def.h.inc |   1 +
>  tcg/tcg-op.c                 | 120 ++++++++++-------------------------
>  4 files changed, 41 insertions(+), 88 deletions(-)
>
> diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
> index 9f5cae36c5..8f8560023a 100644
> --- a/include/tcg/tcg-op-common.h
> +++ b/include/tcg/tcg-op-common.h
> @@ -133,7 +133,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned me=
minfo);
>  /* 32 bit ops */
>
>  void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i3=
2 arg2);
> -void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, unsigned flags);
>  void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
>  void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
>  void tcg_gen_revbit8_i32(TCGv_i32 ret, TCGv_i32 arg);
> @@ -158,7 +157,6 @@ void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a=
, TCGv_i64 *b);
>  void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i6=
4 arg2);
>  void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg);
>  void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg);
> -void tcg_gen_bswap16_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags);
>  void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags);
>  void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
>  void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg);
> diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
> index 09899cb309..d6ea11d8fc 100644
> --- a/tcg/tcg-internal.h
> +++ b/tcg/tcg-internal.h
> @@ -108,6 +108,12 @@ static inline void tcg_gen_op_tt(TCGOpcode opc, TCGT=
ype type,
>      tcg_gen_op2(opc, type, temp_arg(t0), temp_arg(t1));
>  }
>
> +static inline void tcg_gen_op_tti(TCGOpcode opc, TCGType type,
> +                                  TCGTemp *t0, TCGTemp *t1, TCGArg a2)
> +{
> +    tcg_gen_op3(opc, type, temp_arg(t0), temp_arg(t1), a2);
> +}
> +
>  static inline void tcg_gen_op_ttt(TCGOpcode opc, TCGType type,
>                                    TCGTemp *t0, TCGTemp *t1, TCGTemp *t2)
>  {
> diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
> index b606aaab12..2ebcf4a066 100644
> --- a/include/tcg/tcg-op-def.h.inc
> +++ b/include/tcg/tcg-op-def.h.inc
> @@ -11,6 +11,7 @@ DEF3(andi, TCGV, TCGV, TINT)
>  DEF3(andc, TCGV, TCGV, TCGV)
>  DEF4(brcond, TCGCond, TCGV, TCGV, TCGLabelPtr)
>  DEF4(brcondi, TCGCond, TCGV, TINT, TCGLabelPtr)
> +DEF3(bswap16, TCGV, TCGV, unsigned)
>  DEF2(clrsb, TCGV, TCGV)
>  DEF3(clz, TCGV, TCGV, TCGV)
>  DEF3(clzi, TCGV, TCGV, TINT)
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index c3a8a04a4d..f1a79dc921 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -425,6 +425,40 @@ void tcg_gen_brcondi(TCGType type, TCGCond cond, TCG=
Temp *src1,
>      tcg_gen_brcond(type, cond, src1, tcg_constant_internal(type, src2), =
l);
>  }
>
> +void tcg_gen_bswap16(TCGType type, TCGTemp *dst, TCGTemp *src, unsigned =
flags)
> +{
> +    /* Only one extension flag may be present. */
> +    tcg_debug_assert(!(flags & TCG_BSWAP_OS) || !(flags & TCG_BSWAP_OZ))=
;
> +
> +    if (tcg_op_supported(INDEX_op_bswap16, type, 0)) {
> +        tcg_gen_op_tti(INDEX_op_bswap16, type, dst, src, flags);
> +    } else {
> +        g_autoptr(TCGTemp) t0 =3D tcg_temp_new_ebb(type);
> +        g_autoptr(TCGTemp) t1 =3D tcg_temp_new_ebb(type);
> +        int width =3D tcg_type_bits(type);
> +
> +        if (flags & TCG_BSWAP_IZ) {                     /* t0 =3D ...a *=
/
> +            tcg_gen_shri(type, t0, src, 8);
> +        } else {
> +            tcg_gen_extract(type, t0, src, 8, 8);
> +        }
> +
> +        if (flags & TCG_BSWAP_OS) {
> +            tcg_gen_shli(type, t1, src, width - 8);     /* t1 =3D b... *=
/
> +            tcg_gen_sari(type, t1, t1, width - 16);     /* t1 =3D ssb. *=
/
> +        } else if (flags & TCG_BSWAP_OZ) {
> +            tcg_gen_ext8u(type, t1, src);               /* t1 =3D ...b *=
/
> +            tcg_gen_shli(type, t1, t1, 8);              /* t1 =3D ..b. *=
/
> +        } else {
> +            tcg_gen_shli(type, t1, src, 8);             /* t1 =3D xab. *=
/
> +        }
> +
> +        tcg_gen_or(type, dst, t0, t1);                  /* ret =3D ..ba =
(OZ) */
> +                                                        /*     =3D ssba =
(OS) */
> +                                                        /*     =3D xaba =
(0)  */
> +    }
> +}
> +
>  void tcg_gen_clrsb(TCGType type, TCGTemp *dst, TCGTemp *src)
>  {
>      if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_REG, 0)) {
> @@ -1294,49 +1328,6 @@ static void gen_bitswap_i64(TCGv_i64 ret, TCGv_i64=
 arg, uint64_t mask)
>      tcg_temp_free_i64(t1);
>  }
>
> -/*
> - * bswap16_i32: 16-bit byte swap on the low bits of a 32-bit value.
> - *
> - * Byte pattern: xxab -> yyba
> - *
> - * With TCG_BSWAP_IZ, x =3D=3D zero, else undefined.
> - * With TCG_BSWAP_OZ, y =3D=3D zero, with TCG_BSWAP_OS y =3D=3D sign, el=
se undefined.
> - */
> -void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, unsigned flags)
> -{
> -    /* Only one extension flag may be present. */
> -    tcg_debug_assert(!(flags & TCG_BSWAP_OS) || !(flags & TCG_BSWAP_OZ))=
;
> -
> -    if (tcg_op_supported(INDEX_op_bswap16, TCG_TYPE_I32, 0)) {
> -        tcg_gen_op3i_i32(INDEX_op_bswap16, ret, arg, flags);
> -    } else {
> -        TCGv_i32 t0 =3D tcg_temp_ebb_new_i32();
> -        TCGv_i32 t1 =3D tcg_temp_ebb_new_i32();
> -
> -                                            /* arg =3D ..ab (IZ) xxab (!=
IZ) */
> -        tcg_gen_shri_i32(t0, arg, 8);       /*  t0 =3D ...a (IZ) .xxa (!=
IZ) */
> -        if (!(flags & TCG_BSWAP_IZ)) {
> -            tcg_gen_ext8u_i32(t0, t0);      /*  t0 =3D ...a */
> -        }
> -
> -        if (flags & TCG_BSWAP_OS) {
> -            tcg_gen_shli_i32(t1, arg, 24);  /*  t1 =3D b... */
> -            tcg_gen_sari_i32(t1, t1, 16);   /*  t1 =3D ssb. */
> -        } else if (flags & TCG_BSWAP_OZ) {
> -            tcg_gen_ext8u_i32(t1, arg);     /*  t1 =3D ...b */
> -            tcg_gen_shli_i32(t1, t1, 8);    /*  t1 =3D ..b. */
> -        } else {
> -            tcg_gen_shli_i32(t1, arg, 8);   /*  t1 =3D xab. */
> -        }
> -
> -        tcg_gen_or_i32(ret, t0, t1);        /* ret =3D ..ba (OZ) */
> -                                            /*     =3D ssba (OS) */
> -                                            /*     =3D xaba (no flag) */
> -        tcg_temp_free_i32(t0);
> -        tcg_temp_free_i32(t1);
> -    }
> -}
> -
>  /*
>   * bswap32_i32: 32-bit byte swap on a 32-bit value.
>   *
> @@ -1495,49 +1486,6 @@ void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg=
)
>      tcg_gen_extract_i64(ret, arg, 0, 32);
>  }
>
> -/*
> - * bswap16_i64: 16-bit byte swap on the low bits of a 64-bit value.
> - *
> - * Byte pattern: xxxxxxxxab -> yyyyyyyyba
> - *
> - * With TCG_BSWAP_IZ, x =3D=3D zero, else undefined.
> - * With TCG_BSWAP_OZ, y =3D=3D zero, with TCG_BSWAP_OS y =3D=3D sign, el=
se undefined.
> - */

We're dropping this comment. Dunno if you want to keep it in the refactor.

