Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F41D606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 22:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KxFeie+v
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJeiH-0006HP-0f; Wed, 21 Oct 2026 18:23:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xJeiF-0006Gt-KV
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 18:23:11 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xJeiD-0008GW-Ps
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 18:23:11 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-3ab3b29a210so3452411fa.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 15:23:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792621388; cv=none;
 d=google.com; s=arc-20260327;
 b=c7VP1GKqHLPqPvVhg7sN8GCu/9Lin3W76vOodDIp+KWE9oSBvL6Y3ILFV+JOxVvqUv
 yYA/+hEOWcZDxXRzFdLqNMlqR4hHKFz0WFhoPKBdsTgTrJS8UE6c5v/ER6pkptF2eip1
 3CQBbb6QqQqSPVUOns7MuJe7gpFv4RPSViGLN9iadvIwOmp/Lsga/UM5fELZwHxmLAWE
 RptDFz0Jga7AdLy104f9zYQC+tQsiG6d4St/Mxr41j3qwaOHDtPcIfujRb0WLiR0f5/6
 iHMuPsjUcG+eh9lp8NmwBaPNZ0qUU6KEzcR9zLSf+VTk6eX772N/fMvmYH83IR3JIxX5
 jBAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+v4KMA9COpcj0rlQpE/YHTTsacuaakOlMPHSJCWCaxg=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=ghxKZlBsV2v6aj2esf67XUwHA4PuVbYVcZtqmUweYLFZc0AjuaG4ARmjtTkoueyIwc
 ogUf+UFSEglfpA3Awf6d5gni1/pH/e5ECqbO5mCIftwS/9xDaoSicrWBSOOO1mK4IVXQ
 T6z8hiEQaS+bK3j1IbMR/yNP0gn7uxPCc58imtV5Favk1UZSnSwhYqY15ELSE8ZjZ+lG
 D7qRz9DgsMPb4OjYlYbf7qNX7U4smyo7LNWgvvYdXmzGBb16tdu122jbEPHPrr4/zKyg
 IY8PICs9WVAfMR+YNpjQGrFX5x7nVS2aZT46/teNodfpT52xYv9RIr5s6/yCd5hysIMO
 jAew==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792621388; x=1793226188; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+v4KMA9COpcj0rlQpE/YHTTsacuaakOlMPHSJCWCaxg=;
 b=KxFeie+vGnJWvg9aZa4TgXiIEYJyURLHHwDlm8id9U4xvuhekw53XKl+QJNKsolqtp
 p0MxthDXw4dDPqV2RVs3nl6K4fwrP0QGJ2NDlkBao6Gk5i/4XwZSmkc7w63a9HqUpPPK
 SyfsUy9jFlEyQjuiUkCIzkbNXfeRrWloJJZaNVrTq9YdCSIqcViDe8ZIwggNlho7dZMQ
 bmwGuO+NSZDeRkwl3Zi/BAp5CuRhOIaz9bDJjyahlZ0F/hZ3sWlGji5yazQq6VUCkg8V
 aHpns7bArioQYMsYN/C4Jej39240RfGMcGGcmZaPAxLz3HQFZie1Uspohfe9DnfJh1DR
 6f2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792621388; x=1793226188;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+v4KMA9COpcj0rlQpE/YHTTsacuaakOlMPHSJCWCaxg=;
 b=KhSVpszTPapwHrdLA8heClkv80TbgPed4mU0LB4vclJwUvX/jWdlzrZWTrEe29Ss4z
 s1Og1wjBf9kxBhs056nwEsSpjGSgEV1JE6h5Gz4Vz6Huzj8BwdcGwZqmbteFAnGkXqkV
 u8n1MxAMNoi7UEqL59ub/mPizUvRiezloJUoT3CbM8cDwq1L0JWFfnLtoDQFzrhkQEg7
 NfH60/7kWb9UwnMvNGa6CmHeSyfL0FG+fhing77aNrHpYHkoFSHUb+iHSGVDRrnlOLo3
 1T7ZLCK3yaACmsREQwWvkyjc6xC27cJO/K2uhlAs5/84BOWZVZMVX1HW8zT15HVAUvq3
 ntPA==
X-Gm-Message-State: AFq9FYI0lJL5tSDtu77is9mgOqH47+7h+83E8KTsV1tYk1YJDoSPV11e
 1bTLg1ZtNI5bcDijS5hg17GesYsLxY+9er42BJNQMOzv/r83KS7y/Qd3rYpht8WqWVDJFuQrj08
 023kUry0mUzJcmTxK4FBFQVddAfwmQR3iMw==
X-Gm-Gg: AYBFou2EDhFyXbBe2YNXWV/DIaO5YiO7GTOfmrcT4WuPZo5MlhNt+yoIDOBtTdu7ecS
 n4FTkBCsAzTagsVUhPcqS9sPsMBwzvBxZxtUo/6Nl76AZjak/7X1Sp0BfFXR1+6Gb0NEpGGAu22
 Rda19Upb11AkAWzWfvshaAp5xqwuUtvoQCh3+po9vZbtSTz0Q1UxFn/jb5qlZ6fhk/rb9hqJrUC
 neiAqhBw4jp6QmKZBRfReirqOWATt6AI00trbc2sli3KC4QTiW2XhqFwq+vZoSpVqFScN6Zt8rQ
 Vd1n0M9bAPSHD0K1jhWCu+HseiQ7nV9d1KYM7d+b3OQt4EHiUEaVVLbKCAiz25uQCs+m6HUT4CB
 AzHnYP52/fX/CccOqoB8NFJfX/CMesDU0wOMqXRGZGCpfjcDAUnT3PrQ2uF1i0Vljo1IUOu1NgN
 ZWCTnx1DM2th3v4HNcmUSY9KFM/n64I/DZhCFXF/cC/dheEHsZqnvu
X-Received: by 2002:a05:651c:b12:b0:3a9:ed4c:5571 with SMTP id
 38308e7fff4ca-3ac5114d346mr983651fa.22.1792621387409; Wed, 21 Oct 2026
 15:23:07 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261021141652.363109-1-richard.henderson@linaro.org>
 <20261021141652.363109-93-richard.henderson@linaro.org>
In-Reply-To: <20261021141652.363109-93-richard.henderson@linaro.org>
From: Matt Turner <mattst88@gmail.com>
Date: Wed, 21 Oct 2026 18:22:52 -0400
X-Gm-Features: AclHuK9UCSt00X7zP8BzFKFGgjSSbdpjak34gSH2QiHRXNlqeCI2Cnf1AJNRFgU
Message-ID: <CAEdQ38Gj55WJHT09JVZj2K6BS9L=vANe-vH007rBREEivaLE4g@mail.gmail.com>
Subject: Re: [PATCH v6 092/100] tcg: Generic expansion of tcg_gen_st_*
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=mattst88@gmail.com; helo=mail-lj1-x231.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 10:26=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/tcg/tcg-op-common.h  | 20 +-------------------
>  include/tcg/tcg-op-def.h.inc |  1 +
>  tcg/tcg-op.c                 | 21 ++++++++++-----------
>  3 files changed, 12 insertions(+), 30 deletions(-)
>
> diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
> index d0d508ced6..469b925fe0 100644
> --- a/include/tcg/tcg-op-common.h
> +++ b/include/tcg/tcg-op-common.h
> @@ -142,7 +142,6 @@ void tcg_gen_dup_i32(unsigned vece, TCGv_i32 out, TCG=
v_i32 in);
>
>  void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offse=
t);
>  void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offs=
et);
> -void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset=
);
>
>  /* 64 bit ops */
>
> @@ -166,7 +165,6 @@ void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, t=
cg_target_long offset);
>
>  void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offs=
et);
>  void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offs=
et);
> -void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset=
);
>
>  /* Size changing operations.  */
>
> @@ -352,24 +350,11 @@ void tcg_gen_stl_vec(TCGv_vec r, TCGv_ptr base, TCG=
Arg offset, TCGType t);
>
>  /* Host pointer ops */
>
> -#if UINTPTR_MAX =3D=3D UINT32_MAX
> -# define PTR  i32
> -# define NAT  TCGv_i32
> -#else
> -# define PTR  i64
> -# define NAT  TCGv_i64
> -#endif
> -
>  TCGv_ptr tcg_constant_ptr_int(intptr_t x);
>  #define tcg_constant_ptr(X)  tcg_constant_ptr_int((intptr_t)(X))
>
>  QEMU_ARG_NONNULL void tcg_gen_ld_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t o)=
;
> -
> -static inline void tcg_gen_st_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t o)
> -{
> -    glue(tcg_gen_st_, PTR)((NAT)r, a, o);
> -}
> -
> +QEMU_ARG_NONNULL void tcg_gen_st_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t o)=
;
>  QEMU_ARG_NONNULL void tcg_gen_discard_ptr(TCGv_ptr a);
>  QEMU_ARG_NONNULL void tcg_gen_add_ptr(TCGv_ptr r, TCGv_ptr a, TCGv_ptr b=
);
>  QEMU_ARG_NONNULL void tcg_gen_addi_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t =
b);
> @@ -382,7 +367,4 @@ QEMU_ARG_NONNULL void tcg_gen_trunc_i64_ptr(TCGv_ptr =
r, TCGv_i64 a);
>  QEMU_ARG_NONNULL void tcg_gen_extu_ptr_i64(TCGv_i64 r, TCGv_ptr a);
>  QEMU_ARG_NONNULL void tcg_gen_trunc_ptr_i32(TCGv_i32 r, TCGv_ptr a);
>
> -#undef PTR
> -#undef NAT
> -
>  #endif /* TCG_TCG_OP_COMMON_H */
> diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
> index 98a07a70f0..514967f91d 100644
> --- a/include/tcg/tcg-op-def.h.inc
> +++ b/include/tcg/tcg-op-def.h.inc
> @@ -70,6 +70,7 @@ DEF3(shr, TCGV, TCGV, TCGV)
>  DEF3(shri, TCGV, TCGV, TINT)
>  DEF3(smax, TCGV, TCGV, TCGV)
>  DEF3(smin, TCGV, TCGV, TCGV)
> +DEF3(st, TCGV, TCGv_ptr, tcg_target_long)
>  DEF3(sub, TCGV, TCGV, TCGV)
>  DEF3(subi, TCGV, TCGV, TINT)
>  DEF6(sub2, TCGV, TCGV, TCGV, TCGV, TCGV, TCGV)
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index f1c33afc02..68e31fe5ca 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -1251,6 +1251,11 @@ void tcg_gen_smin(TCGType type, TCGTemp *dst, TCGT=
emp *src1, TCGTemp *src2)
>      }
>  }
>
> +void tcg_gen_st(TCGType type, TCGTemp *dst, TCGTemp *base, tcg_target_lo=
ng ofs)
> +{

Naming the value we're storing `dst` is kind of odd. Probably a
copy-n-paste artifact.

Same applies to 93 and 94.

> +    tcg_gen_op_tti(INDEX_op_st, type, dst, base, ofs);
> +}

