Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBD9DCA5FAD
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 00:20:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBi2h-0002Ty-BJ; Tue, 29 Sep 2026 20:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xBi2f-0002Tn-NR
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 20:19:25 -0400
Received: from mail-lf2-x11.google.com ([2a00:1450:4864:36::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xBi2d-0001Qv-5Q
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 20:19:25 -0400
Received: by mail-lf2-x11.google.com with SMTP id
 2adb3069b0e04-5b5e4f16f15so4659540e87.3
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 17:19:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790727561; cv=none;
 d=google.com; s=arc-20260327;
 b=eJ7NA3ZucI7Yw9GlF6N/F8l4ycNbJWOB0NJ1Rljkr5WFQWOgyySRKJsbOHrgrweJgT
 rGQAP2XxIbpBqwjDHisdXtvpwqlNffEJvuU3HrlrDk2178pXIVopL/Vmuc19Dpy2McEl
 bDL70RZmB7drdK+9tu8u/dQHmUFb77QwQcrgKmOgnkFCzCdP+yd4VaOBwJcZ8dZJiJRy
 SrV0n8F6387hQRgX+N2YP1ntj0BYCyg/qyMFEqwGNKNNzc+pZlKdWvnI/99Mso6TAeTs
 WsRI3oidFNYCYWeVFcVpXScK4NuQOF+5G/RjUh2y7knkDxom2nikaqQEnyBvy31xHG3k
 XGFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=cgEVRJLdeluNj8mz7kpbOoI7Duu0vlQngLyuJIJmtEk=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=RSIbE+9W6iaVYJ43x1Q9NBhSvxPp5LTU5eMAVwBMid0RLSHbgg6JraZyWgrTf5+yyN
 ZeJ5AdBZRBMiR0NmQkzHKBnrrLjY7I4BG6nlrHeBID5Nm5j89WCz9BBHxDdWvzFERKbD
 TZ1JaGLLezhXufHt56Pr7YwzAxQ7QSpfdHFdpYs5XTiyM+WXo7CAx7ArPxhUu9lg44aC
 q+vgWQ+dJTOt5HQZh7GobVfb3ejrAIlhbUOmMtgaEs5UgtPiVFFZrptAFJ3yVePymr4u
 C8P0TUdcli/LzRXLMw6N5jn6uPQ79Hy3m3E8kZuxTmkKkEkmHyu46Wbfih6kwXP4sw+K
 3cow==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790727561; x=1791332361; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cgEVRJLdeluNj8mz7kpbOoI7Duu0vlQngLyuJIJmtEk=;
 b=nLngtDIREdmXcR0vEu1JkvGaBIDRx5o8AZFLgHw+1JNA6uqv6xZGYR9hIsLw/ZLFH6
 Z6hthrCieruRqtUusdqwE8vkv0pb5Wc0pUxoIeyeha/RWrVOs0RWl4fd/i9G8JyHpLnJ
 h/FEa67id4dCdfTLsIYiyFGfjilzA0DxGAa27PQLfLR/K82EM4aQUJVYq9Pv6rTh07DO
 X02/G+7Qh7qbHsXP0r/PcP6O5tGpmUhO6wYWuU9kue6nHPDQDExrZoFQexLnt4zF54J6
 MeEkMo4bMXb8rY8mOtCXcoP3511O4pgGjwi7K7Xha5xDcrOv8Kya9RZvd+s4Ok7YcCpB
 LRcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790727561; x=1791332361;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cgEVRJLdeluNj8mz7kpbOoI7Duu0vlQngLyuJIJmtEk=;
 b=qz2XeKw4IeFNKp43tkuaD37oospsWA7SvXw4O767aw1QlNS3v0OCGvwsdvRJHrOdPo
 LNxND4QHn6E8kqevPqJuRJOm7lyRfp0RuMVoojcMk00beoeYu3Zl6RuOsHBBsmnJ+9Zc
 QWpRH3ynoqg+FDRMAfIBsN47cqzWlBX88utmMWv14ExDIlB/2u3pQMaxnIzBYATREmDb
 U8vUDYa7cb5he6gnofk57e0G95SSbuhkwXOHvt8DN22KbfzVrxVT0qVC45PefN8eYQ50
 kYfIIqE+XwDEjeSwoJEc9RfhbUGrhZXSNjPrpi8wFz4wOQTLKTWS2ak6hHTIfsrHU8Mk
 94Nw==
X-Gm-Message-State: AFq9FYL+ew/Bb+ZXSld9jI61dneCKv5bRDlw54aHzPo57eG1BuiOlm6X
 RM6St2Ydnunpk6ljjde6bnqaScLHq4Bg/ruNbQL+iLDqkJHTP8dmLBqhy+Wx/22nbrIXb+DIcS9
 TZL5Xa08mJ65ztqMX74qgphHFc149poQ=
X-Gm-Gg: AYBFou2bYkBnHHaeVd/cxLZrQQJTLWcJSdfTuClyiE0mzsFo1chtD+9UU8dehmOygNs
 paHhmkGXxkn+AH9r6xXZbkmWz4eggVvSZtoPntE2/KJU7Rg0KwTVuhVAUyQEHIZNny1TADP4YT8
 KB3FI60PlQ7EXSjISuAyKySWkpS1L+xLnTpyw5Aqyp1jQKBBPdP7T0Z9NlcQOy9/Y6QEuKsxL2U
 XrdFaay3HUoj+DARAJcX/wgjdUxQHop1T9u1K9RCCstan1u4ymFuZQhXKBSBRg2+pl3+sFvc2Nw
 5PQ+4daJ5ihzS5uOwpN9nCywAUnbq4kPGvhaa5ZN5Ew6Kl44p9fdjdf08CA6pqRk/dE8yi8OKs4
 Od2f4OdJwYL9j5aJ79m3tlY34
X-Received: by 2002:ac2:4e93:0:b0:5b8:e820:f111 with SMTP id
 2adb3069b0e04-5ba3bf416f4mr227599e87.21.1790727560802; Tue, 29 Sep 2026
 17:19:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-100-richard.henderson@linaro.org>
In-Reply-To: <20260927090011.10724-100-richard.henderson@linaro.org>
From: Matt Turner <mattst88@gmail.com>
Date: Tue, 29 Sep 2026 20:19:08 -0400
X-Gm-Features: AclHuK9OUSVibAwZ2cB4F7S4Fs42whVVRP6ded44z1hNkkgoydqNw4MmkFDNLB8
Message-ID: <CAEdQ38En6n0th4j3ZwS2qZZMnNb29jE8nNmYLUobqZuMyTcsjw@mail.gmail.com>
Subject: Re: [PATCH v5 099/101] tcg: Generic expansion of
 tcg_gen_{non}atomic_qemu_cmpxchg_chk
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:36::11;
 envelope-from=mattst88@gmail.com; helo=mail-lf2-x11.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sun, Sep 27, 2026 at 5:08=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/tcg/tcg-op-common.h  |  16 +--
>  include/tcg/tcg-op-mem.h     |   2 +-
>  tcg/tcg-internal.h           |   3 +
>  include/tcg/tcg-op-def.h.inc |   3 +
>  tcg/tcg-op-ldst.c            | 237 ++++++++++++++---------------------
>  tcg/tcg-op.c                 |   8 ++
>  6 files changed, 113 insertions(+), 156 deletions(-)
>
> diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
> index 4fec1500d56..9864674f1c2 100644
> --- a/include/tcg/tcg-op-common.h
> +++ b/include/tcg/tcg-op-common.h
> @@ -104,6 +104,8 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned me=
minfo);
>      QEMU_ARG_NONNULL void glue(glue(tcg_gen_,NAME),TExt)(T1, T2, T3, T4,=
 T5);
>  #define DEF6(NAME, T1, T2, T3, T4, T5, T6) \
>      QEMU_ARG_NONNULL void glue(glue(tcg_gen_,NAME),TExt)(T1, T2, T3, T4,=
 T5, T6);
> +#define DEF7(NAME, T1, T2, T3, T4, T5, T6, T7) \
> +    QEMU_ARG_NONNULL void glue(glue(tcg_gen_,NAME),TExt)(T1, T2, T3, T4,=
 T5, T6, T7);
>
>  #define TCGV  glue(TCGv,TExt)
>  #define TExt  _i32
> @@ -129,6 +131,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned me=
minfo);
>  #undef DEF4
>  #undef DEF5
>  #undef DEF6
> +#undef DEF7
>
>  /* 32 bit ops */
>
> @@ -180,18 +183,9 @@ void tcg_gen_qemu_st_chk_i128(TCGv_i128, TCGTemp *, =
TCGArg, MemOp, TCGType);
>
>  /* Atomic ops */
>
> -void tcg_gen_atomic_cmpxchg_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32, TCGv_=
i32,
> -                                    TCGArg, MemOp, TCGType);
> -void tcg_gen_atomic_cmpxchg_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64, TCGv_=
i64,
> -                                    TCGArg, MemOp, TCGType);
> -void tcg_gen_atomic_cmpxchg_i128_chk(TCGv_i128, TCGTemp *, TCGv_i128,
> +void tcg_gen_atomic_cmpxchg_chk_i128(TCGv_i128, TCGTemp *, TCGv_i128,
>                                       TCGv_i128, TCGArg, MemOp, TCGType);
> -
> -void tcg_gen_nonatomic_cmpxchg_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32, TC=
Gv_i32,
> -                                       TCGArg, MemOp, TCGType);
> -void tcg_gen_nonatomic_cmpxchg_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64, TC=
Gv_i64,
> -                                       TCGArg, MemOp, TCGType);
> -void tcg_gen_nonatomic_cmpxchg_i128_chk(TCGv_i128, TCGTemp *, TCGv_i128,
> +void tcg_gen_nonatomic_cmpxchg_chk_i128(TCGv_i128, TCGTemp *, TCGv_i128,
>                                          TCGv_i128, TCGArg, MemOp, TCGTyp=
e);
>
>  void tcg_gen_atomic_xchg_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
> diff --git a/include/tcg/tcg-op-mem.h b/include/tcg/tcg-op-mem.h
> index e8425e10598..935860f1442 100644
> --- a/include/tcg/tcg-op-mem.h
> +++ b/include/tcg/tcg-op-mem.h
> @@ -72,7 +72,7 @@ tcg_gen_qemu_st_i128(TCGv_i128 v, TCGv_va a, TCGArg i, =
MemOp m)
>  #define DEF_ATOMIC3(N, S)                                               =
\
>      QEMU_ARG_NONNULL static inline void                                 =
\
>      N##_##S(TCGv_##S r, TCGv_va a, TCGv_##S o, TCGv_##S n, TCGArg i, Mem=
Op m) \
> -    { N##_##S##_chk(r, tcgv_va_temp(a), o, n, i, m, TCG_TYPE_VA); }
> +    { N##_chk_##S(r, tcgv_va_temp(a), o, n, i, m, TCG_TYPE_VA); }
>
>  DEF_ATOMIC3(tcg_gen_atomic_cmpxchg, i32)
>  DEF_ATOMIC3(tcg_gen_atomic_cmpxchg, i64)
> diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
> index bfd34905ee7..da1b9c9bab3 100644
> --- a/tcg/tcg-internal.h
> +++ b/tcg/tcg-internal.h
> @@ -190,6 +190,8 @@ bool tcg_op_imm_match(TCGOpcode op, TCGType type, tcg=
_target_ulong imm);
>      QEMU_ARG_NONNULL void glue(tcg_gen_,NAME)(TCGType, T1, T2, T3, T4, T=
5);
>  #define DEF6(NAME, T1, T2, T3, T4, T5, T6) \
>      QEMU_ARG_NONNULL void glue(tcg_gen_,NAME)(TCGType, T1, T2, T3, T4, T=
5, T6);
> +#define DEF7(NAME, T1, T2, T3, T4, T5, T6, T7) \
> +    QEMU_ARG_NONNULL void glue(tcg_gen_,NAME)(TCGType, T1, T2, T3, T4, T=
5, T6, T7);
>
>  #define TCGV      TCGTemp *
>  #define TINT      int64_t
> @@ -207,6 +209,7 @@ bool tcg_op_imm_match(TCGOpcode op, TCGType type, tcg=
_target_ulong imm);
>  #undef DEF4
>  #undef DEF5
>  #undef DEF6
> +#undef DEF7
>
>  static inline void tcg_gen_extrh(TCGTemp *dst, TCGTemp *src)
>  {
> diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
> index 552f62b7f4f..e0ffd0da678 100644
> --- a/include/tcg/tcg-op-def.h.inc
> +++ b/include/tcg/tcg-op-def.h.inc
> @@ -85,3 +85,6 @@ DEF3(umin, TCGV, TCGV, TCGV)
>  DEF3(ussub, TCGV, TCGV, TCGV)
>  DEF3(xor, TCGV, TCGV, TCGV)
>  DEF3(xori, TCGV, TCGV, TINT)
> +
> +DEF7(atomic_cmpxchg_chk, TCGV, TCGTempPtr, TCGV, TCGV, unsigned, MemOp, =
TCGType)
> +DEF7(nonatomic_cmpxchg_chk, TCGV, TCGTempPtr, TCGV, TCGV, unsigned, MemO=
p, TCGType)
> diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
> index 7345bdfcc2b..b3143f6311b 100644
> --- a/tcg/tcg-op-ldst.c
> +++ b/tcg/tcg-op-ldst.c
> @@ -667,181 +667,125 @@ typedef void (*gen_atomic_op_i128)(TCGv_i128, TCG=
v_env, TCGv_i64,
>  # define WITH_ATOMIC128(X)
>  #endif
>
> -static void * const table_cmpxchg[(MO_SIZE | MO_BSWAP) + 1] =3D {
> -    [MO_8] =3D gen_helper_atomic_cmpxchgb,
> -    [MO_16 | MO_LE] =3D gen_helper_atomic_cmpxchgw_le,
> -    [MO_16 | MO_BE] =3D gen_helper_atomic_cmpxchgw_be,
> -    [MO_32 | MO_LE] =3D gen_helper_atomic_cmpxchgl_le,
> -    [MO_32 | MO_BE] =3D gen_helper_atomic_cmpxchgl_be,
> -    [MO_64 | MO_LE] =3D gen_helper_atomic_cmpxchgq_le,
> -    [MO_64 | MO_BE] =3D gen_helper_atomic_cmpxchgq_be,
> -    WITH_ATOMIC128([MO_128 | MO_LE] =3D gen_helper_atomic_cmpxchgo_le)
> -    WITH_ATOMIC128([MO_128 | MO_BE] =3D gen_helper_atomic_cmpxchgo_be)
> -};
> -
> -static void tcg_gen_nonatomic_cmpxchg_i32_int(TCGv_i32 retv, TCGTemp *ad=
dr,
> -                                              TCGv_i32 cmpv, TCGv_i32 ne=
wv,
> -                                              TCGArg idx, MemOp memop)
> +static void tcg_gen_nonatomic_cmpxchg_int(TCGType type, TCGTemp *retv,
> +                                          TCGTemp *addr, TCGTemp *cmpv,
> +                                          TCGTemp *newv, unsigned idx,
> +                                          MemOp memop)
>  {
> -    TCGv_i32 t1 =3D tcg_temp_ebb_new_i32();
> -    TCGv_i32 t2 =3D tcg_temp_ebb_new_i32();
> +    g_autoptr(TCGTemp) t1 =3D tcg_temp_new_ebb(type);
> +    g_autoptr(TCGTemp) t2 =3D tcg_temp_new_ebb(type);
>
> -    tcg_gen_ext_i32(t2, cmpv, memop & MO_SIZE);
> +    tcg_gen_ext(type, t2, cmpv, memop & MO_SIZE);
>
> -    tcg_gen_qemu_ld_int(TCG_TYPE_I32, tcgv_i32_temp(t1),
> -                        addr, idx, memop & ~MO_SIGN);
> -    tcg_gen_movcond_i32(TCG_COND_EQ, t2, t1, t2, newv, t1);
> -    tcg_gen_qemu_st_int(TCG_TYPE_I32, tcgv_i32_temp(t2), addr, idx, memo=
p);
> -    tcg_temp_free_i32(t2);
> +    tcg_gen_qemu_ld_int(type, t1, addr, idx, memop & ~MO_SIGN);
> +    tcg_gen_movcond(type, TCG_COND_EQ, t2, t1, t2, newv, t1);
> +    tcg_gen_qemu_st_int(type, t2, addr, idx, memop);
>
>      if (memop & MO_SIGN) {
> -        tcg_gen_ext_i32(retv, t1, memop);
> +        tcg_gen_ext(type, retv, t1, memop);
>      } else {
> -        tcg_gen_mov_i32(retv, t1);
> +        tcg_gen_mov(type, retv, t1);
>      }
> -    tcg_temp_free_i32(t1);
>  }
>
> -void tcg_gen_nonatomic_cmpxchg_i32_chk(TCGv_i32 retv, TCGTemp *addr,
> -                                       TCGv_i32 cmpv, TCGv_i32 newv,
> -                                       TCGArg idx, MemOp memop,
> -                                       TCGType addr_type)
> +void tcg_gen_nonatomic_cmpxchg_chk(TCGType val_type, TCGTemp *retv,
> +                                   TCGTemp *addr, TCGTemp *cmpv, TCGTemp=
 *newv,
> +                                   unsigned idx, MemOp memop, TCGType ad=
dr_type)
>  {
>      tcg_debug_assert(addr_type =3D=3D tcg_ctx->addr_type);
> -    tcg_debug_assert((memop & MO_SIZE) <=3D MO_32);
> -    tcg_gen_nonatomic_cmpxchg_i32_int(retv, addr, cmpv, newv, idx, memop=
);
> +    tcg_debug_assert(memop_size(memop) <=3D tcg_type_size(val_type));
> +    tcg_debug_assert(idx < NB_MMU_MODES);
> +
> +    tcg_gen_nonatomic_cmpxchg_int(val_type, retv, addr, cmpv, newv, idx,=
 memop);
>  }
>
> -static void tcg_gen_atomic_cmpxchg_i32_int(TCGv_i32 retv, TCGTemp *addr,
> -                                           TCGv_i32 cmpv, TCGv_i32 newv,
> -                                           TCGArg idx, MemOp memop)
> +static void tcg_gen_atomic_cmpxchg_int(TCGType type, TCGTemp *retv,
> +                                       TCGTemp *addr, TCGTemp *cmpv,
> +                                       TCGTemp *newv, unsigned idx,
> +                                       MemOp memop)
>  {
> -    gen_atomic_cx_i32 gen;
>      TCGv_i64 a64;
>      MemOpIdx oi;
>
>      if (!(tcg_ctx->gen_tb->cflags & CF_PARALLEL)) {
> -        tcg_gen_nonatomic_cmpxchg_i32_int(retv, addr, cmpv, newv, idx, m=
emop);
> +        tcg_gen_nonatomic_cmpxchg_int(type, retv, addr, cmpv,
> +                                      newv, idx, memop);
>          return;
>      }
>
> -    memop =3D tcg_canonicalize_memop(memop, 0, 0);
> -    gen =3D table_cmpxchg[memop & (MO_SIZE | MO_BSWAP)];
> -    tcg_debug_assert(gen !=3D NULL);
> -
> -    oi =3D make_memop_idx(memop & ~MO_SIGN, idx);
>      a64 =3D maybe_extend_addr64(addr);
> -    gen(retv, tcg_env, a64, cmpv, newv, tcg_constant_i32(oi));
> -    maybe_free_addr64(a64);
> -
> -    if (memop & MO_SIGN) {
> -        tcg_gen_ext_i32(retv, retv, memop);
> -    }
> -}
> -
> -void tcg_gen_atomic_cmpxchg_i32_chk(TCGv_i32 retv, TCGTemp *addr,
> -                                    TCGv_i32 cmpv, TCGv_i32 newv,
> -                                    TCGArg idx, MemOp memop,
> -                                    TCGType addr_type)
> -{
> -    tcg_debug_assert(addr_type =3D=3D tcg_ctx->addr_type);
> -    tcg_debug_assert((memop & MO_SIZE) <=3D MO_32);
> -    tcg_gen_atomic_cmpxchg_i32_int(retv, addr, cmpv, newv, idx, memop);
> -}
> -
> -static void tcg_gen_nonatomic_cmpxchg_i64_int(TCGv_i64 retv, TCGTemp *ad=
dr,
> -                                              TCGv_i64 cmpv, TCGv_i64 ne=
wv,
> -                                              TCGArg idx, MemOp memop)
> -{
> -    TCGv_i64 t1, t2;
> -
> -    t1 =3D tcg_temp_ebb_new_i64();
> -    t2 =3D tcg_temp_ebb_new_i64();
> -
> -    tcg_gen_ext_i64(t2, cmpv, memop & MO_SIZE);
> -
> -    tcg_gen_qemu_ld_int(TCG_TYPE_I64, tcgv_i64_temp(t1),
> -                        addr, idx, memop & ~MO_SIGN);
> -    tcg_gen_movcond_i64(TCG_COND_EQ, t2, t1, t2, newv, t1);
> -    tcg_gen_qemu_st_int(TCG_TYPE_I64, tcgv_i64_temp(t2), addr, idx, memo=
p);
> -    tcg_temp_free_i64(t2);
> -
> -    if (memop & MO_SIGN) {
> -        tcg_gen_ext_i64(retv, t1, memop);
> -    } else {
> -        tcg_gen_mov_i64(retv, t1);
> -    }
> -    tcg_temp_free_i64(t1);
> -}
> -
> -void tcg_gen_nonatomic_cmpxchg_i64_chk(TCGv_i64 retv, TCGTemp *addr,
> -                                       TCGv_i64 cmpv, TCGv_i64 newv,
> -                                       TCGArg idx, MemOp memop,
> -                                       TCGType addr_type)
> -{
> -    tcg_debug_assert(addr_type =3D=3D tcg_ctx->addr_type);
> -    tcg_debug_assert((memop & MO_SIZE) <=3D MO_64);
> -    tcg_gen_nonatomic_cmpxchg_i64_int(retv, addr, cmpv, newv, idx, memop=
);
> -}
> -
> -static void tcg_gen_atomic_cmpxchg_i64_int(TCGv_i64 retv, TCGTemp *addr,
> -                                           TCGv_i64 cmpv, TCGv_i64 newv,
> -                                           TCGArg idx, MemOp memop)
> -{
> -    if (!(tcg_ctx->gen_tb->cflags & CF_PARALLEL)) {
> -        tcg_gen_nonatomic_cmpxchg_i64_int(retv, addr, cmpv, newv, idx, m=
emop);
> -        return;
> -    }
>
>      if ((memop & MO_SIZE) =3D=3D MO_64) {
> -        gen_atomic_cx_i64 gen;
> +        gen_atomic_cx_i64 gen =3D ((memop & MO_BSWAP) =3D=3D MO_LE
> +                                 ? gen_helper_atomic_cmpxchgq_le
> +                                 : gen_helper_atomic_cmpxchgq_be);
> +
> +        tcg_debug_assert(type =3D=3D TCG_TYPE_I64);
>
>          memop =3D tcg_canonicalize_memop(memop, 1, 0);
> -        gen =3D table_cmpxchg[memop & (MO_SIZE | MO_BSWAP)];
> -        if (gen) {
> -            MemOpIdx oi =3D make_memop_idx(memop, idx);
> -            TCGv_i64 a64 =3D maybe_extend_addr64(addr);
> -            gen(retv, tcg_env, a64, cmpv, newv, tcg_constant_i32(oi));
> -            maybe_free_addr64(a64);
> -            return;
> +        oi =3D make_memop_idx(memop & ~MO_SIGN, idx);
> +
> +        gen(temp_tcgv_i64(retv), tcg_env, a64, temp_tcgv_i64(cmpv),
> +            temp_tcgv_i64(newv), tcg_constant_i32(oi));
> +    } else {
> +        static gen_atomic_cx_i32 const table_cmpxchg[(MO_SIZE | MO_BSWAP=
) + 1] =3D {
> +            [MO_8] =3D gen_helper_atomic_cmpxchgb,
> +            [MO_16 | MO_LE] =3D gen_helper_atomic_cmpxchgw_le,
> +            [MO_16 | MO_BE] =3D gen_helper_atomic_cmpxchgw_be,
> +            [MO_32 | MO_LE] =3D gen_helper_atomic_cmpxchgl_le,
> +            [MO_32 | MO_BE] =3D gen_helper_atomic_cmpxchgl_be,
> +        };
> +
> +        g_autoptr(TCGTemp) c32 =3D NULL;
> +        g_autoptr(TCGTemp) n32 =3D NULL;
> +        g_autoptr(TCGTemp) r32 =3D NULL;
> +        TCGTemp *retv_orig =3D retv;
> +
> +        gen_atomic_cx_i32 gen =3D table_cmpxchg[memop & (MO_SIZE | MO_BS=
WAP)];

This now happens before tcg_canonicalize_memop(), so I think that can
lead to indexing into an empty entry.

> +        tcg_debug_assert(gen !=3D NULL);
> +
> +        if (type =3D=3D TCG_TYPE_I64) {
> +            c32 =3D tcg_temp_new_ebb(TCG_TYPE_I32);
> +            n32 =3D tcg_temp_new_ebb(TCG_TYPE_I32);
> +            r32 =3D tcg_temp_new_ebb(TCG_TYPE_I32);
> +
> +            tcg_gen_extrl(c32, cmpv);
> +            tcg_gen_extrl(n32, newv);
> +
> +            cmpv =3D c32;
> +            newv =3D n32;
> +            retv =3D r32;
>          }
>
> -        gen_helper_exit_atomic(tcg_env);
> +        memop =3D tcg_canonicalize_memop(memop, 0, 0);
> +        oi =3D make_memop_idx(memop & ~MO_SIGN, idx);
>
> -        /*
> -         * Produce a result for a well-formed opcode stream.  This satis=
fies
> -         * liveness for set before used, which happens before this dead =
code
> -         * is removed.
> -         */
> -        tcg_gen_movi_i64(retv, 0);
> -    } else {
> -        TCGv_i32 c32 =3D tcg_temp_ebb_new_i32();
> -        TCGv_i32 n32 =3D tcg_temp_ebb_new_i32();
> -        TCGv_i32 r32 =3D tcg_temp_ebb_new_i32();
> -
> -        tcg_gen_extrl_i64_i32(c32, cmpv);
> -        tcg_gen_extrl_i64_i32(n32, newv);
> -        tcg_gen_atomic_cmpxchg_i32_int(r32, addr, c32, n32,
> -                                       idx, memop & ~MO_SIGN);
> -        tcg_temp_free_i32(c32);
> -        tcg_temp_free_i32(n32);
> -
> -        tcg_gen_extu_i32_i64(retv, r32);
> -        tcg_temp_free_i32(r32);
> +        gen(temp_tcgv_i32(retv), tcg_env, a64, temp_tcgv_i32(cmpv),
> +            temp_tcgv_i32(newv), tcg_constant_i32(oi));
>
>          if (memop & MO_SIGN) {
> -            tcg_gen_ext_i64(retv, retv, memop);
> +            tcg_gen_ext(TCG_TYPE_I32, retv, retv, memop);
> +        }
> +        if (retv !=3D retv_orig) {
> +            if (memop & MO_SIGN) {
> +                tcg_gen_exts(retv_orig, retv);

For MO_32, tcg_canonicalize_memop(memop, is64=3Dfalse, ...) clears
MO_SIGN, so the i64 result is always zero-extended. Looks like the old
code tested the caller's memop. Maybe I'm misreading.

