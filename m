Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB3FACCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 09:01:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE236-0003Kv-FK; Wed, 29 Oct 2025 05:00:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vE233-0003KC-4Q
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 05:00:53 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vE22r-0002xa-4p
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 05:00:51 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b6d5e04e0d3so389097266b.2
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 02:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761728436; x=1762333236; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TYIwi+gftUu7gQoTIM1j0461NaDyVobazNr5CcS/MT0=;
 b=ERTwJEmu4ztJHH6+t404opUjPGiNMaSle6nJGOZRor+6dhQH45jQnISJlwyMs78ANW
 +HdO03u5iMjQini4/KHx7ZwPBHiravhxFk5Z49UCKK02W4Uv4/OnSod2UN850qkCC71d
 g5CP8Q9132cQ0sFZw0OeWp6ISs6BXvI4IaLnOBMUhihsJAsd+984KH8ZTvK3A+II///B
 Vz4LxIbLJxWiW9UCvTUvpLIU44E0ZF3TvuA4FFwho1vC6uurysAlXLjSR3E1ULc1E744
 MudLQW56Uv+fbjrYWKh6PuVqkSVnBpCjIHwwqDzD+yAxQnmfVsbymUxAAwyAy5WyBwEa
 hpXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761728436; x=1762333236;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TYIwi+gftUu7gQoTIM1j0461NaDyVobazNr5CcS/MT0=;
 b=je38uZGq589W60J6fSCa1IdqhirEDCl6bi8mywbeySSf/Pfgk3qb4keMLinGgB3sBD
 RxNP5/njSsheY6prcAGvrPQ2wFn5n/sBzxdMw8sPR00Qfv01kxDJ736EeIZau/MKQxG0
 uTz1gmxyrAUt9PBssGZdDqsdM4nwJEUKaji4MXTtjKR/SugeH0OyGx5KIMP+r7jwys0f
 HTZOEvqoVOxIvFgrsUo4hyjz1OUMbYW3rdD23YHtnSnmLuzrmOnArxPdC+TnNetQ1WGg
 hWEC6rlhJwog1VKz2aZuM23AX4rUGakUiq2gJ85WDFmJd1tcydCUG2Fl0dne99hjFp+8
 naYw==
X-Gm-Message-State: AOJu0Yx51lP8jFOyfhoUzPJPgL2pV5uRXcYp/AR5ZJVzxUvFUtO5+f8J
 ogn9AhAElRar2Ujp8XDe0QJTl8WqPlh9ySOApIAPH2qx6US8FwLYCo5oh28aWOuaRdRp2MCvEqb
 sWXESgTcMZxTKgQ/BFEX623iQ8PHx21HPOhJs7GuPH7xady92bshGSjo=
X-Gm-Gg: ASbGncto09XQO3SxatlrP+PKNjosyp8oYvtCrlxVPYzpqnb0PZMYXb4mYw7asfxWMkg
 060RhEXJqsC7TR1XdMIw3+HQhDi1D6Bk65QuWQAEH5R4EiKqiF8CQHs+BReD4EiGjHfCMZrBH2p
 Od9QJn2jS0PClejn8sPTsSqbEZNqCBrVrDf2Iu6XpJY3smKylDfVA9TVj0V83AlJZ/ndmVSBFBi
 hv2StYmDBECtUywqq42z6We7Emu+tXIQ2wIlNfFYoJ1F2bcroRTB0yI1Bxm
X-Google-Smtp-Source: AGHT+IHqiDcDGp0CGu0XAg0dD0j/UG6mX/lb4CleGy28BIO77vOUajRgxQYJ01XP9A/F2jZF2Ir69HYHpAgX71aeNXA=
X-Received: by 2002:a17:907:9815:b0:b41:12bf:e3aa with SMTP id
 a640c23a62f3a-b703d3111b4mr234850666b.16.1761728435367; Wed, 29 Oct 2025
 02:00:35 -0700 (PDT)
MIME-Version: 1.0
References: <20251022001741.222499-1-richard.henderson@linaro.org>
In-Reply-To: <20251022001741.222499-1-richard.henderson@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 29 Oct 2025 11:00:08 +0200
X-Gm-Features: AWmQ_bkf-yo5b_fre1WXDiv5JB7llBLNFsTz4EMr0Vwl5cG_7GOpupa2Dzqs8Og
Message-ID: <CAAjaMXbVgLS+XcMn0+G5RmVr96rjWqwS6VUtprd0jtXnsbjo5Q@mail.gmail.com>
Subject: Re: [PATCH] accel/tcg: Introduce and use MO_ALIGN_TLB_ONLY
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Wed, Oct 22, 2025 at 3:18=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> For Arm, we need 3 cases: (1) the alignment required when accessing
> Normal memory, (2) the alignment required when accessing Device memory,
> and (3) the atomicity of the access.
>
> When we added TLB_CHECK_ALIGNED, we assumed that cases 2 and 3 were
> identical, and thus used memop_atomicity_bits for TLB_CHECK_ALIGNED.
>
> This is incorrect for multiple reasons, including that the atomicity
> of the access is adjusted depending on whether or not we are executing
> within a serial context.
>
> For Arm, what is true is that there is an underlying alignment
> requirement of the access, and for that access Normal memory
> will support unalignement.
>
> Introduce MO_ALIGN_TLB_ONLY to indicate that the alignment
> specified in MO_AMASK only applies when the TLB entry has
> TLB_CHECK_ALIGNED set; otherwise no alignment required.
>
> Introduce memop_tlb_alignment_bits with an additional bool
> argument that specifies whether TLB_CHECK_ALIGNED is set.
> All other usage of memop_alignment_bits assumes it is not.
>
> Remove memop_atomicity_bits as unused; it didn't properly
> support MO_ATOM_SUBWORD anyway.
>
> Update target/arm finalize_memop_atom to set MO_ALIGN_TLB_ONLY
> when strict alignment isn't otherwise required.
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3171
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>
> PS: There are a number of uses of align_mem for AdvSIMD, SVE and SME.
> I have not re-familiarized myself with the effects of SCR.A and
> Normal/Device memory for those cases.  I may well have missed something.
>
> ---
>  include/exec/memop.h            | 43 +++++++++++++++------------------
>  target/arm/tcg/translate.h      |  4 +--
>  accel/tcg/cputlb.c              | 13 +---------
>  target/arm/ptw.c                |  2 +-
>  target/arm/tcg/translate-a64.c  | 10 +++-----
>  target/arm/tcg/translate-neon.c |  2 +-
>  tcg/tcg.c                       | 10 +++++---
>  7 files changed, 35 insertions(+), 49 deletions(-)
>
> diff --git a/include/exec/memop.h b/include/exec/memop.h
> index cf7da3362e..799b5b4221 100644
> --- a/include/exec/memop.h
> +++ b/include/exec/memop.h
> @@ -72,6 +72,16 @@ typedef enum MemOp {
>      MO_ALIGN_64 =3D 6 << MO_ASHIFT,
>      MO_ALIGN    =3D MO_AMASK,
>
> +    /*
> +     * MO_ALIGN_TLB_ONLY:
> +     * Apply MO_AMASK only along the TCG slow path if TLB_CHECK_ALIGNED
> +     * is set; otherwise unaligned access is permitted.
> +     * This is used by target/arm, where unaligned accesses are
> +     * permitted for pages marked Normal but aligned accesses are
> +     * required for pages marked Device.
> +     */
> +    MO_ALIGN_TLB_ONLY =3D 1 << 8,
> +
>      /*
>       * MO_ATOM_* describes the atomicity requirements of the operation:
>       * MO_ATOM_IFALIGN: the operation must be single-copy atomic if it
> @@ -104,7 +114,7 @@ typedef enum MemOp {
>       * size of the operation, if aligned.  This retains the behaviour
>       * from before this field was introduced.
>       */
> -    MO_ATOM_SHIFT         =3D 8,
> +    MO_ATOM_SHIFT         =3D 9,
>      MO_ATOM_IFALIGN       =3D 0 << MO_ATOM_SHIFT,
>      MO_ATOM_IFALIGN_PAIR  =3D 1 << MO_ATOM_SHIFT,
>      MO_ATOM_WITHIN16      =3D 2 << MO_ATOM_SHIFT,
> @@ -169,16 +179,16 @@ static inline MemOp size_memop(unsigned size)
>  }
>
>  /**
> - * memop_alignment_bits:
> + * memop_tlb_alignment_bits:
>   * @memop: MemOp value
>   *
> - * Extract the alignment size from the memop.
> + * Extract the alignment size for use with TLB_CHECK_ALIGNED.
>   */
> -static inline unsigned memop_alignment_bits(MemOp memop)
> +static inline unsigned memop_tlb_alignment_bits(MemOp memop, bool tlb_ch=
eck)
>  {
>      unsigned a =3D memop & MO_AMASK;
>
> -    if (a =3D=3D MO_UNALN) {
> +    if (a =3D=3D MO_UNALN || (!tlb_check && (memop & MO_ALIGN_TLB_ONLY))=
) {
>          /* No alignment required.  */
>          a =3D 0;
>      } else if (a =3D=3D MO_ALIGN) {
> @@ -191,28 +201,15 @@ static inline unsigned memop_alignment_bits(MemOp m=
emop)
>      return a;
>  }
>
> -/*
> - * memop_atomicity_bits:
> +/**
> + * memop_alignment_bits:
>   * @memop: MemOp value
>   *
> - * Extract the atomicity size from the memop.
> + * Extract the alignment size from the memop.
>   */
> -static inline unsigned memop_atomicity_bits(MemOp memop)
> +static inline unsigned memop_alignment_bits(MemOp memop)
>  {
> -    unsigned size =3D memop & MO_SIZE;
> -
> -    switch (memop & MO_ATOM_MASK) {
> -    case MO_ATOM_NONE:
> -        size =3D MO_8;
> -        break;
> -    case MO_ATOM_IFALIGN_PAIR:
> -    case MO_ATOM_WITHIN16_PAIR:
> -        size =3D size ? size - 1 : 0;
> -        break;
> -    default:
> -        break;
> -    }
> -    return size;
> +    return memop_tlb_alignment_bits(memop, false);
>  }
>
>  #endif
> diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
> index 9a85ea74db..b62104b4ae 100644
> --- a/target/arm/tcg/translate.h
> +++ b/target/arm/tcg/translate.h
> @@ -744,8 +744,8 @@ static inline TCGv_ptr fpstatus_ptr(ARMFPStatusFlavou=
r flavour)
>   */
>  static inline MemOp finalize_memop_atom(DisasContext *s, MemOp opc, MemO=
p atom)
>  {
> -    if (s->align_mem && !(opc & MO_AMASK)) {
> -        opc |=3D MO_ALIGN;
> +    if (!(opc & MO_AMASK)) {
> +        opc |=3D MO_ALIGN | (s->align_mem ? 0 : MO_ALIGN_TLB_ONLY);
>      }
>      return opc | atom | s->be_data;
>  }
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 631f1fe135..fd1606c856 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1668,18 +1668,7 @@ static bool mmu_lookup1(CPUState *cpu, MMULookupPa=
geData *data, MemOp memop,
>
>      if (likely(!maybe_resized)) {
>          /* Alignment has not been checked by tlb_fill_align. */
> -        int a_bits =3D memop_alignment_bits(memop);
> -
> -        /*
> -         * This alignment check differs from the one above, in that this=
 is
> -         * based on the atomicity of the operation. The intended use cas=
e is
> -         * the ARM memory type field of each PTE, where access to pages =
with
> -         * Device memory type require alignment.
> -         */
> -        if (unlikely(flags & TLB_CHECK_ALIGNED)) {
> -            int at_bits =3D memop_atomicity_bits(memop);
> -            a_bits =3D MAX(a_bits, at_bits);
> -        }
> +        int a_bits =3D memop_tlb_alignment_bits(memop, flags & TLB_CHECK=
_ALIGNED);
>          if (unlikely(addr & ((1 << a_bits) - 1))) {
>              cpu_unaligned_access(cpu, addr, access_type, mmu_idx, ra);
>          }
> diff --git a/target/arm/ptw.c b/target/arm/ptw.c
> index d4386ede73..939215d096 100644
> --- a/target/arm/ptw.c
> +++ b/target/arm/ptw.c
> @@ -2351,7 +2351,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1=
Translate *ptw,
>       * CPUs with ARM_FEATURE_LPAE but not ARM_FEATURE_V7VE anyway.)
>       */
>      if (device) {
> -        unsigned a_bits =3D memop_atomicity_bits(memop);
> +        unsigned a_bits =3D memop_tlb_alignment_bits(memop, true);
>          if (address & ((1 << a_bits) - 1)) {
>              fi->type =3D ARMFault_Alignment;
>              goto do_fault;
> diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a6=
4.c
> index 3292d7cbfd..08b21d7dbf 100644
> --- a/target/arm/tcg/translate-a64.c
> +++ b/target/arm/tcg/translate-a64.c
> @@ -3691,9 +3691,8 @@ static bool trans_STP(DisasContext *s, arg_ldstpair=
 *a)
>       * In all cases, issue one operation with the correct atomicity.
>       */
>      mop =3D a->sz + 1;
> -    if (s->align_mem) {
> -        mop |=3D (a->sz =3D=3D 2 ? MO_ALIGN_4 : MO_ALIGN_8);
> -    }
> +    mop |=3D (a->sz =3D=3D 2 ? MO_ALIGN_4 : MO_ALIGN_8);
> +    mop |=3D (s->align_mem ? 0 : MO_ALIGN_TLB_ONLY);
>      mop =3D finalize_memop_pair(s, mop);
>      if (a->sz =3D=3D 2) {
>          TCGv_i64 tmp =3D tcg_temp_new_i64();
> @@ -3742,9 +3741,8 @@ static bool trans_LDP(DisasContext *s, arg_ldstpair=
 *a)
>       * since that reuses the most code below.
>       */
>      mop =3D a->sz + 1;
> -    if (s->align_mem) {
> -        mop |=3D (a->sz =3D=3D 2 ? MO_ALIGN_4 : MO_ALIGN_8);
> -    }
> +    mop |=3D (a->sz =3D=3D 2 ? MO_ALIGN_4 : MO_ALIGN_8);
> +    mop |=3D (s->align_mem ? 0 : MO_ALIGN_TLB_ONLY);
>      mop =3D finalize_memop_pair(s, mop);
>      if (a->sz =3D=3D 2) {
>          int o2 =3D s->be_data =3D=3D MO_LE ? 32 : 0;
> diff --git a/target/arm/tcg/translate-neon.c b/target/arm/tcg/translate-n=
eon.c
> index 844d2e29e4..e3c7d9217b 100644
> --- a/target/arm/tcg/translate-neon.c
> +++ b/target/arm/tcg/translate-neon.c
> @@ -520,7 +520,7 @@ static bool trans_VLDST_multiple(DisasContext *s, arg=
_VLDST_multiple *a)
>      if (a->align) {
>          align =3D pow2_align(a->align + 2); /* 4 ** a->align */
>      } else {
> -        align =3D s->align_mem ? MO_ALIGN : 0;
> +        align =3D MO_ALIGN | (s->align_mem ? 0 : MO_ALIGN_TLB_ONLY);
>      }
>
>      /*
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 294762c283..fbf09f5c82 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -3039,20 +3039,22 @@ void tcg_dump_ops(TCGContext *s, FILE *f, bool ha=
ve_prefs)
>              case INDEX_op_qemu_ld2:
>              case INDEX_op_qemu_st2:
>                  {
> -                    const char *s_al, *s_op, *s_at;
> +                    const char *s_al, *s_tlb, *s_op, *s_at;
>                      MemOpIdx oi =3D op->args[k++];
>                      MemOp mop =3D get_memop(oi);
>                      unsigned ix =3D get_mmuidx(oi);
>
> +                    s_tlb =3D mop & MO_ALIGN_TLB_ONLY ? "tlb+" : "";
>                      s_al =3D alignment_name[(mop & MO_AMASK) >> MO_ASHIF=
T];
>                      s_op =3D ldst_name[mop & (MO_BSWAP | MO_SSIZE)];
>                      s_at =3D atom_name[(mop & MO_ATOM_MASK) >> MO_ATOM_S=
HIFT];
> -                    mop &=3D ~(MO_AMASK | MO_BSWAP | MO_SSIZE | MO_ATOM_=
MASK);
> +                    mop &=3D ~(MO_AMASK | MO_BSWAP | MO_SSIZE |
> +                             MO_ATOM_MASK | MO_ALIGN_TLB_ONLY);
>
>                      /* If all fields are accounted for, print symbolical=
ly. */
>                      if (!mop && s_al && s_op && s_at) {
> -                        col +=3D ne_fprintf(f, ",%s%s%s,%u",
> -                                          s_at, s_al, s_op, ix);
> +                        col +=3D ne_fprintf(f, ",%s%s%s%s,%u",
> +                                          s_at, s_al, s_tlb, s_op, ix);
>                      } else {
>                          mop =3D get_memop(oi);
>                          col +=3D ne_fprintf(f, ",$0x%x,%u", mop, ix);
> --
> 2.43.0
>
>

