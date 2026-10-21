Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D642D606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 22:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=n8JUsdhX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJefK-0005cf-W1; Wed, 21 Oct 2026 18:20:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xJefI-0005cG-1g
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 18:20:08 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xJefF-0007xF-Bk
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 18:20:07 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-3a1f628b1d1so12204631fa.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 15:20:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792621203; cv=none;
 d=google.com; s=arc-20260327;
 b=X/uy0YIoGjV7WxetnEaTvPg7gILXtbkfqofOKwfFLWheTNv86RploBEwydB60kS/1n
 LN8zNavTJE0cOx52ADmnz3tfJJ5IQ94d2hPvAzxEIPTTPIjhuIcvJYmNTbgYUBcdwA5/
 +LmWMOCqYeluKwAg+/jiYHFQIfSveMMRySDzKIFpty3MuL3oNyTy/ivLYL1npX3iT8p1
 wGQOJt88VfreKs6t0rEUy/K0sq8tjFgBsNOzJBvNBpRBQUbluU6zkuEb3MTomz7BmBR8
 CgMrJoi/PVMbQikhMs7NZ2DSvzjlt8xrVHpFvolIQFYiGN7vRu5fmz1Rgg9Yd5LvPAqi
 hpww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VFq37WY79ImxoLdHAin9u7adBQqSTyAhB0jN4BdXBXQ=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=GoefPL7TMz5hsxkt2486H/6WDYxvhGJMsjkc6NhMxdObKoJrtMFQYGf1gRNJfWaIx2
 Ykw+fYQgRnLLJVwuFItnUR1RJg3MN2iSbGgip3xe95vm4TEuPtvwcNctlCLbYVSYAujR
 HKPtFDR+YI1hdFOWN6Dn+GGjO/WqeHOL1JTqowPOX6ddmD7zs4kBXHysPv+DTe6/GWMY
 boQjpjGgGuRFlchdMEp4e8DwYU7peiRw6/ilP9z7e6DGGzx5DKU71CpuEcIk8KffqZsn
 e8UGloLlUyTkyL37xlvwo/au95YYUD299b4vWo2IzcmAaYktatMqclretAs5zbJAgTcA
 houA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792621203; x=1793226003; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VFq37WY79ImxoLdHAin9u7adBQqSTyAhB0jN4BdXBXQ=;
 b=n8JUsdhXb8I09W8Tbom6D3XYjFaDIt4uf+AbuOOwdbkrHdcpEZ1hUEEcI5VPGPRiII
 oDICozVMDCJGoRe/pBSeGaT9R2OrpnZnwyHmFCbzYqT57Q11upEcR1hzL1GR7SZyQqmc
 6O5SurIXXTpHkndrFcS4botXW5fXN/Wa8MbYsNG3dHl8lyRsVr/2mL91sbFSfIlmWZhB
 QktMlrUqOXa8va9rgvt9XWLGAkplUAtMBlaqUTllJGuwrqx2rNLbxVqOYenBznbqskpa
 Vv6lH3yCLN9Wf2tiPu5xLLZRDlxdpJmEmN3gTNqd/g12KP/L6zn0yZfhuu9hlek1TKx5
 +RxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792621203; x=1793226003;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VFq37WY79ImxoLdHAin9u7adBQqSTyAhB0jN4BdXBXQ=;
 b=gFQJBMeYl2dRcLfTn2NuJco892YFPgHX+xriZPv501ix3bcUlcIiHQC5xOTILpKTIh
 +bmXQh4WXqJmcetXXcEomEo905t1g1Bk9Wo1BFR9XvRBaOfqiT2S6tHtk1DC4ad4hLXn
 oQcEJO7Bg2bWu2pQiKSzf23b+btK8ikGKg8Qr3Nx2iSW7gp+v4TiVg3zRL+g1vWgP9XT
 wWMjfKvrHRmtdGhX1F7cskqYAnnTljz/TzB3Lv1Z3ZemwvzNUqc5YHbmDGRRUDyRPEd3
 vc5zMhCrTGGaRTELA5W1GXoZDJToBc5dxwrGnVjulvbI5kzYpTAG0n7aqJjUiZLmC+rL
 WOWQ==
X-Gm-Message-State: AFq9FYLWJkYxGwCDZkLXrCXhK4/NtvkQiPvG1Vnth3do54MJ7bIhy0uW
 X08gixVttNhiHgUOb0bkoBpCwSuhnYxMiI1WNIe/HZqYFqlhOVA0/2NSe1IgF9xH9ym6xvd+UKQ
 tydQpRmkbuKXVOJ8kEps/MO2xJ6vWuq0=
X-Gm-Gg: AYBFou1RSZJTHPx4CtPQHYV1zCooSM9eXuuamBYYE7T1wxPQT50X8fdePpULGR94YDj
 PzMkjsSNNO2jtuY81CBrz3r004GCQEmIHlVV3NxaL8S/woGGKMXY25M0YrZ3JTpoZw/Ye0aDmdN
 0uZP3nXAnZs/zdXSM9bx3VIlw94iltoSRSeAl6rRmOIw7lwd32IjKGu/9x0+YkjBrQcr9PC7Gwp
 mprl/55j54rAdDfbNl271D42wsb/TQX9nJvA+sGeHfGUf8/VmYjs6AmQjNhAc3t0v/Uqq3LF/0A
 NJ1P55Nu6sY2Yn/BIlV+CtOtyZt+K5Zio1OkHEUzjGA37X04m8EUZ8OAhcTNZcqHLc4b1Y6ZBXF
 imoEhMXCzJK3mIdKstElPOSPok5dPAi/3+myFpYxPLHViud4M+iY/zbMNgD9Dk8qtw+bFcGWJJn
 3ntbsbIi0oZR3129UEhVTPr7lI4api91oi62gHM1IZraWi2xWguyLi
X-Received: by 2002:a05:651c:222c:b0:3ab:17c9:3d26 with SMTP id
 38308e7fff4ca-3ac44146575mr8584241fa.7.1792621202306; Wed, 21 Oct 2026
 15:20:02 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261021141652.363109-1-richard.henderson@linaro.org>
 <20261021141652.363109-97-richard.henderson@linaro.org>
In-Reply-To: <20261021141652.363109-97-richard.henderson@linaro.org>
From: Matt Turner <mattst88@gmail.com>
Date: Wed, 21 Oct 2026 18:19:49 -0400
X-Gm-Features: AclHuK-NGEVjPqQAM12Brc2a7T-sBhMlu9FLGcXolQqZxuzBFOt5ggHqYF2lB1Q
Message-ID: <CAEdQ38HYWL7du4chh2FA5e1R8FYcVK99GbzhQHgYffc6rLYerg@mail.gmail.com>
Subject: Re: [PATCH v6 096/100] tcg: Generic expansion of tcg_gen_qemu_ld_chk
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=mattst88@gmail.com; helo=mail-lj1-x22f.google.com
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
>  include/tcg/tcg-op-common.h  |   4 +-
>  include/tcg/tcg-op-mem.h     |   6 +-
>  include/tcg/tcg.h            |   2 +
>  include/tcg/tcg-op-def.h.inc |   1 +
>  tcg/tcg-op-ldst.c            | 164 ++++++++++++++---------------------
>  tcg/tcg-op.c                 |   4 +
>  6 files changed, 75 insertions(+), 106 deletions(-)
>
> diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
> index 75194c1906..ce47bebb2b 100644
> --- a/include/tcg/tcg-op-common.h
> +++ b/include/tcg/tcg-op-common.h
> @@ -177,11 +177,9 @@ void tcg_gen_st_i128(TCGv_i128 val, TCGv_ptr base, t=
cg_target_long offset);
>
>  /* Local load/store bit ops */
>
> -void tcg_gen_qemu_ld_i32_chk(TCGv_i32, TCGTemp *, TCGArg, MemOp, TCGType=
);
> +void tcg_gen_qemu_ld_chk_i128(TCGv_i128, TCGTemp *, TCGArg, MemOp, TCGTy=
pe);
>  void tcg_gen_qemu_st_i32_chk(TCGv_i32, TCGTemp *, TCGArg, MemOp, TCGType=
);
> -void tcg_gen_qemu_ld_i64_chk(TCGv_i64, TCGTemp *, TCGArg, MemOp, TCGType=
);
>  void tcg_gen_qemu_st_i64_chk(TCGv_i64, TCGTemp *, TCGArg, MemOp, TCGType=
);
> -void tcg_gen_qemu_ld_i128_chk(TCGv_i128, TCGTemp *, TCGArg, MemOp, TCGTy=
pe);
>  void tcg_gen_qemu_st_i128_chk(TCGv_i128, TCGTemp *, TCGArg, MemOp, TCGTy=
pe);
>
>  /* Atomic ops */
> diff --git a/include/tcg/tcg-op-mem.h b/include/tcg/tcg-op-mem.h
> index 29e7c02f25..76955d27c1 100644
> --- a/include/tcg/tcg-op-mem.h
> +++ b/include/tcg/tcg-op-mem.h
> @@ -31,7 +31,7 @@ typedef TCGv_i64 TCGv_va;
>  QEMU_ARG_NONNULL static inline void
>  tcg_gen_qemu_ld_i32(TCGv_i32 v, TCGv_va a, TCGArg i, MemOp m)
>  {
> -    tcg_gen_qemu_ld_i32_chk(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
> +    tcg_gen_qemu_ld_chk_i32(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
>  }
>
>  QEMU_ARG_NONNULL static inline void
> @@ -43,7 +43,7 @@ tcg_gen_qemu_st_i32(TCGv_i32 v, TCGv_va a, TCGArg i, Me=
mOp m)
>  QEMU_ARG_NONNULL static inline void
>  tcg_gen_qemu_ld_i64(TCGv_i64 v, TCGv_va a, TCGArg i, MemOp m)
>  {
> -    tcg_gen_qemu_ld_i64_chk(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
> +    tcg_gen_qemu_ld_chk_i64(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
>  }
>
>  QEMU_ARG_NONNULL static inline void
> @@ -55,7 +55,7 @@ tcg_gen_qemu_st_i64(TCGv_i64 v, TCGv_va a, TCGArg i, Me=
mOp m)
>  QEMU_ARG_NONNULL static inline void
>  tcg_gen_qemu_ld_i128(TCGv_i128 v, TCGv_va a, TCGArg i, MemOp m)
>  {
> -    tcg_gen_qemu_ld_i128_chk(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
> +    tcg_gen_qemu_ld_chk_i128(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
>  }
>
>  QEMU_ARG_NONNULL static inline void
> diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
> index 09d20064fc..8f409b23b7 100644
> --- a/include/tcg/tcg.h
> +++ b/include/tcg/tcg.h
> @@ -304,6 +304,8 @@ typedef struct TCGTemp {
>      void *state_ptr;
>  } TCGTemp;
>
> +typedef TCGTemp *TCGTempPtr;
> +
>  typedef struct TCGContext TCGContext;
>
>  typedef struct TCGTempSet {
> diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
> index 556f7470cd..e2da3ddef6 100644
> --- a/include/tcg/tcg-op-def.h.inc
> +++ b/include/tcg/tcg-op-def.h.inc
> @@ -53,6 +53,7 @@ DEF2(not, TCGV, TCGV)
>  DEF3(or, TCGV, TCGV, TCGV)
>  DEF3(ori, TCGV, TCGV, TINT)
>  DEF3(orc, TCGV, TCGV, TCGV)
> +DEF5(qemu_ld_chk, TCGV, TCGTempPtr, unsigned, MemOp, TCGType)
>  DEF3(rem, TCGV, TCGV, TCGV)
>  DEF3(remu, TCGV, TCGV, TCGV)
>  DEF2(revbit8, TCGV, TCGV)
> diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
> index 031c5ce926..7d3fe60d89 100644
> --- a/tcg/tcg-op-ldst.c
> +++ b/tcg/tcg-op-ldst.c
> @@ -191,33 +191,37 @@ plugin_gen_mem_callbacks(TCGv_i64 copy_addr, TCGTem=
p *orig_addr, MemOpIdx oi,
>  #endif
>
>  static void
> -plugin_gen_mem_callbacks_i32(TCGv_i32 val,
> +plugin_gen_mem_callbacks_tmp(TCGType type, TCGTemp *val,
>                               TCGv_i64 copy_addr, TCGTemp *orig_addr,
>                               MemOpIdx oi, enum qemu_plugin_mem_rw rw)
>  {
>  #ifdef CONFIG_PLUGIN
>      if (tcg_ctx->plugin_insn !=3D NULL) {
> -        tcg_gen_st_i32(val, tcg_env,
> -                       offsetof(CPUState, neg.plugin_mem_value_low) -
> -                       sizeof(CPUState) + (HOST_BIG_ENDIAN * 4));
> +        tcg_gen_st(type, val, tcgv_ptr_temp(tcg_env),
> +                   offsetof(CPUState, neg.plugin_mem_value_low)
> +                   - sizeof(CPUState)
> +                   + (HOST_BIG_ENDIAN && type =3D=3D TCG_TYPE_I32 ? 4 : =
0));
>          plugin_gen_mem_callbacks(copy_addr, orig_addr, oi, rw);
>      }
>  #endif
>  }
>
> +static void
> +plugin_gen_mem_callbacks_i32(TCGv_i32 val,
> +                             TCGv_i64 copy_addr, TCGTemp *orig_addr,
> +                             MemOpIdx oi, enum qemu_plugin_mem_rw rw)
> +{
> +    plugin_gen_mem_callbacks_tmp(TCG_TYPE_I32, tcgv_i32_temp(val), copy_=
addr,
> +                                 orig_addr, oi, rw);
> +}
> +
>  static void
>  plugin_gen_mem_callbacks_i64(TCGv_i64 val,
>                               TCGv_i64 copy_addr, TCGTemp *orig_addr,
>                               MemOpIdx oi, enum qemu_plugin_mem_rw rw)
>  {
> -#ifdef CONFIG_PLUGIN
> -    if (tcg_ctx->plugin_insn !=3D NULL) {
> -        tcg_gen_st_i64(val, tcg_env,
> -                       offsetof(CPUState, neg.plugin_mem_value_low) -
> -                       sizeof(CPUState));
> -        plugin_gen_mem_callbacks(copy_addr, orig_addr, oi, rw);
> -    }
> -#endif
> +    plugin_gen_mem_callbacks_tmp(TCG_TYPE_I64, tcgv_i64_temp(val), copy_=
addr,
> +                                 orig_addr, oi, rw);
>  }
>
>  static void
> @@ -238,8 +242,31 @@ plugin_gen_mem_callbacks_i128(TCGv_i128 val,
>  #endif
>  }
>
> -static void tcg_gen_qemu_ld_i32_int(TCGv_i32 val, TCGTemp *addr,
> -                                    TCGArg idx, MemOp memop)
> +static void tcg_gen_bswap(TCGType type, TCGTemp *dst,
> +                          TCGTemp *src, unsigned flags, MemOp memop)
> +{
> +    switch (memop & MO_SIZE) {
> +    case MO_16:
> +        tcg_gen_bswap16(type, dst, src, flags);
> +        break;
> +    case MO_32:
> +        if (type =3D=3D TCG_TYPE_I32) {
> +            tcg_gen_bswap32_i32(temp_tcgv_i32(dst), temp_tcgv_i32(src));
> +        } else {
> +            tcg_gen_bswap32_i64(temp_tcgv_i64(dst), temp_tcgv_i64(src), =
flags);
> +        }
> +        break;
> +    case MO_64:
> +        tcg_debug_assert(type =3D=3D TCG_TYPE_I64);
> +        tcg_gen_bswap64_i64(temp_tcgv_i64(dst), temp_tcgv_i64(src));
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +
> +static void tcg_gen_qemu_ld_int(TCGType type, TCGTemp *val,
> +                                TCGTemp *addr, TCGArg idx, MemOp memop)
>  {
>      MemOp orig_memop;
>      MemOpIdx orig_oi, oi;
> @@ -247,48 +274,40 @@ static void tcg_gen_qemu_ld_i32_int(TCGv_i32 val, T=
CGTemp *addr,
>      TCGTemp *addr_new;
>
>      tcg_gen_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
> -    orig_memop =3D memop =3D tcg_canonicalize_memop(memop, 0, 0);
> +    memop =3D tcg_canonicalize_memop(memop, type !=3D TCG_TYPE_I32, 0);
> +    orig_memop =3D memop;
>      orig_oi =3D oi =3D make_memop_idx(memop, idx);
>
>      if ((memop & MO_BSWAP) && !tcg_target_has_memory_bswap(memop)) {
> -        memop &=3D ~MO_BSWAP;
>          /* The bswap primitive benefits from zero-extended input.  */
> -        if ((memop & MO_SSIZE) =3D=3D MO_SW) {
> -            memop &=3D ~MO_SIGN;
> -        }
> +        memop &=3D ~(MO_BSWAP | MO_SIGN);
>          oi =3D make_memop_idx(memop, idx);
>      }
>
>      addr_new =3D tci_extend_addr(addr);
>      copy_addr =3D plugin_maybe_preserve_addr(addr);
> -    gen_ldst1(INDEX_op_qemu_ld, TCG_TYPE_I32, tcgv_i32_temp(val), addr_n=
ew, oi);
> +    tcg_gen_op_tti(INDEX_op_qemu_ld, type, val, addr_new, oi);
>
>      if ((orig_memop ^ memop) & MO_BSWAP) {
> -        switch (orig_memop & MO_SIZE) {
> -        case MO_16:
> -            tcg_gen_bswap16_i32(val, val, (orig_memop & MO_SIGN
> -                                           ? TCG_BSWAP_IZ | TCG_BSWAP_OS
> -                                           : TCG_BSWAP_IZ | TCG_BSWAP_OZ=
));
> -            break;
> -        case MO_32:
> -            tcg_gen_bswap32_i32(val, val);
> -            break;
> -        default:
> -            g_assert_not_reached();
> -        }
> +        int flags =3D (orig_memop & MO_SIGN

This is passed to tcg_gen_bswap which now takes unsigned. Might want
to change the declaration for consistency.


> +                     ? TCG_BSWAP_IZ | TCG_BSWAP_OS
> +                     : TCG_BSWAP_IZ | TCG_BSWAP_OZ);
> +        tcg_gen_bswap(type, val, val, flags, orig_memop);
>      }
>
> -    plugin_gen_mem_callbacks_i32(val, copy_addr, addr, orig_oi,
> -                                 QEMU_PLUGIN_MEM_R);
> +    plugin_gen_mem_callbacks_tmp(type, val, copy_addr, addr,
> +                                 orig_oi, QEMU_PLUGIN_MEM_R);
>      maybe_free_addr(addr, addr_new);
>  }
>
> -void tcg_gen_qemu_ld_i32_chk(TCGv_i32 val, TCGTemp *addr, TCGArg idx,
> -                             MemOp memop, TCGType addr_type)
> +void tcg_gen_qemu_ld_chk(TCGType val_type, TCGTemp *val, TCGTemp *addr,
> +                         unsigned idx, MemOp memop, TCGType addr_type)

unsigned idx -> TCGArg idx I think?

Same applies to 97, 98, 99.

>  {
>      tcg_debug_assert(addr_type =3D=3D tcg_ctx->addr_type);
> -    tcg_debug_assert((memop & MO_SIZE) <=3D MO_32);
> -    tcg_gen_qemu_ld_i32_int(val, addr, idx, memop);
> +    tcg_debug_assert(memop_size(memop) <=3D tcg_type_size(val_type));
> +    tcg_debug_assert(idx < NB_MMU_MODES);
> +
> +    tcg_gen_qemu_ld_int(val_type, val, addr, idx, memop);
>  }
>
>  static void tcg_gen_qemu_st_i32_int(TCGv_i32 orig_val, TCGTemp *addr,
> @@ -337,63 +356,6 @@ void tcg_gen_qemu_st_i32_chk(TCGv_i32 val, TCGTemp *=
addr, TCGArg idx,
>      tcg_gen_qemu_st_i32_int(val, addr, idx, memop);
>  }
>
> -static void tcg_gen_qemu_ld_i64_int(TCGv_i64 val, TCGTemp *addr,
> -                                    TCGArg idx, MemOp memop)
> -{
> -    MemOp orig_memop;
> -    MemOpIdx orig_oi, oi;
> -    TCGv_i64 copy_addr;
> -    TCGTemp *addr_new;
> -
> -    tcg_gen_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
> -    orig_memop =3D memop =3D tcg_canonicalize_memop(memop, 1, 0);
> -    orig_oi =3D oi =3D make_memop_idx(memop, idx);
> -
> -    if ((memop & MO_BSWAP) && !tcg_target_has_memory_bswap(memop)) {
> -        memop &=3D ~MO_BSWAP;
> -        /* The bswap primitive benefits from zero-extended input.  */
> -        if ((memop & MO_SIGN) && (memop & MO_SIZE) < MO_64) {
> -            memop &=3D ~MO_SIGN;
> -        }
> -        oi =3D make_memop_idx(memop, idx);
> -    }
> -
> -    addr_new =3D tci_extend_addr(addr);
> -    copy_addr =3D plugin_maybe_preserve_addr(addr);
> -    gen_ld_i64(val, addr_new, oi);
> -
> -    if ((orig_memop ^ memop) & MO_BSWAP) {
> -        int flags =3D (orig_memop & MO_SIGN
> -                     ? TCG_BSWAP_IZ | TCG_BSWAP_OS
> -                     : TCG_BSWAP_IZ | TCG_BSWAP_OZ);
> -        switch (orig_memop & MO_SIZE) {
> -        case MO_16:
> -            tcg_gen_bswap16_i64(val, val, flags);
> -            break;
> -        case MO_32:
> -            tcg_gen_bswap32_i64(val, val, flags);
> -            break;
> -        case MO_64:
> -            tcg_gen_bswap64_i64(val, val);
> -            break;
> -        default:
> -            g_assert_not_reached();
> -        }
> -    }
> -
> -    plugin_gen_mem_callbacks_i64(val, copy_addr, addr, orig_oi,
> -                                 QEMU_PLUGIN_MEM_R);
> -    maybe_free_addr(addr, addr_new);
> -}
> -
> -void tcg_gen_qemu_ld_i64_chk(TCGv_i64 val, TCGTemp *addr, TCGArg idx,
> -                             MemOp memop, TCGType addr_type)
> -{
> -    tcg_debug_assert(addr_type =3D=3D tcg_ctx->addr_type);
> -    tcg_debug_assert((memop & MO_SIZE) <=3D MO_64);
> -    tcg_gen_qemu_ld_i64_int(val, addr, idx, memop);
> -}
> -
>  static void tcg_gen_qemu_st_i64_int(TCGv_i64 orig_val, TCGTemp *addr,
>                                      TCGArg idx, MemOp memop)
>  {
> @@ -638,7 +600,7 @@ static void tcg_gen_qemu_ld_i128_int(TCGv_i128 val, T=
CGTemp *addr,
>                                    QEMU_PLUGIN_MEM_R);
>  }
>
> -void tcg_gen_qemu_ld_i128_chk(TCGv_i128 val, TCGTemp *addr, TCGArg idx,
> +void tcg_gen_qemu_ld_chk_i128(TCGv_i128 val, TCGTemp *addr, TCGArg idx,
>                                MemOp memop, TCGType addr_type)
>  {
>      tcg_debug_assert(addr_type =3D=3D tcg_ctx->addr_type);
> @@ -800,7 +762,8 @@ static void tcg_gen_nonatomic_cmpxchg_i32_int(TCGv_i3=
2 retv, TCGTemp *addr,
>
>      tcg_gen_ext_i32(t2, cmpv, memop & MO_SIZE);
>
> -    tcg_gen_qemu_ld_i32_int(t1, addr, idx, memop & ~MO_SIGN);
> +    tcg_gen_qemu_ld_int(TCG_TYPE_I32, tcgv_i32_temp(t1),
> +                        addr, idx, memop & ~MO_SIGN);
>      tcg_gen_movcond_i32(TCG_COND_EQ, t2, t1, t2, newv, t1);
>      tcg_gen_qemu_st_i32_int(t2, addr, idx, memop);
>      tcg_temp_free_i32(t2);
> @@ -871,7 +834,8 @@ static void tcg_gen_nonatomic_cmpxchg_i64_int(TCGv_i6=
4 retv, TCGTemp *addr,
>
>      tcg_gen_ext_i64(t2, cmpv, memop & MO_SIZE);
>
> -    tcg_gen_qemu_ld_i64_int(t1, addr, idx, memop & ~MO_SIGN);
> +    tcg_gen_qemu_ld_int(TCG_TYPE_I64, tcgv_i64_temp(t1),
> +                        addr, idx, memop & ~MO_SIGN);
>      tcg_gen_movcond_i64(TCG_COND_EQ, t2, t1, t2, newv, t1);
>      tcg_gen_qemu_st_i64_int(t2, addr, idx, memop);
>      tcg_temp_free_i64(t2);
> @@ -1047,7 +1011,7 @@ static void do_nonatomic_op_i32(TCGv_i32 ret, TCGTe=
mp *addr, TCGv_i32 val,
>
>      memop =3D tcg_canonicalize_memop(memop, 0, 0);
>
> -    tcg_gen_qemu_ld_i32_int(t1, addr, idx, memop);
> +    tcg_gen_qemu_ld_int(TCG_TYPE_I32, tcgv_i32_temp(t1), addr, idx, memo=
p);
>      tcg_gen_ext_i32(t2, val, memop);
>      gen(t2, t1, t2);
>      tcg_gen_qemu_st_i32_int(t2, addr, idx, memop);
> @@ -1088,7 +1052,7 @@ static void do_nonatomic_op_i64(TCGv_i64 ret, TCGTe=
mp *addr, TCGv_i64 val,
>
>      memop =3D tcg_canonicalize_memop(memop, 1, 0);
>
> -    tcg_gen_qemu_ld_i64_int(t1, addr, idx, memop);
> +    tcg_gen_qemu_ld_int(TCG_TYPE_I64, tcgv_i64_temp(t1), addr, idx, memo=
p);
>      tcg_gen_ext_i64(t2, val, memop);
>      gen(t2, t1, t2);
>      tcg_gen_qemu_st_i64_int(t2, addr, idx, memop);
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index df769dd975..679cf87995 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -239,6 +239,8 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned me=
minfo)
>  #define C_MemOp
>  #define C_TCGCond
>  #define C_TCGLabelPtr
> +#define C_TCGTempPtr
> +#define C_TCGType
>  #define C_tcg_target_long
>  #define C_unsigned
>
> @@ -272,6 +274,8 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned me=
minfo)
>  #undef C_MemOp
>  #undef C_TCGCond
>  #undef C_TCGLabelPtr
> +#undef C_TCGTempPtr
> +#undef C_TCGType
>  #undef C_tcg_target_long
>  #undef C_unsigned
>
> --
> 2.53.0
>

