Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8418C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 04:19:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rv8NW-0004xe-D8; Fri, 12 Apr 2024 00:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bazz1tv2@gmail.com>)
 id 1rv8NU-0004xO-FB
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 00:19:04 -0400
Received: from mail-lj1-f179.google.com ([209.85.208.179])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bazz1tv2@gmail.com>)
 id 1rv8NP-0007jt-MN
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 00:19:04 -0400
Received: by mail-lj1-f179.google.com with SMTP id
 38308e7fff4ca-2d48d75ab70so6497941fa.0
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 21:18:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712895537; x=1713500337;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YeXG9bxUc2aeeokE+GrsM51ZLkkwxA9pWcijAoTSoJw=;
 b=HdXfgOAqw1kEXgIYQzJK7WySxoCBJ77F28b85GExNCYXcmR4uPAHsIpatc4XfUqbrm
 1oHZ+hmNcBDgKMF3dQpEnxPCmOt7z73MjLMWhleI38JGVdaSejkdAVr2m6H0fJ+RRd8I
 eRySPgfJ/lXnk60quDmpGM6iiSp69hFn/QzxDs0K17MLRPABiR5lSGWuuVEi9tQgbuxO
 GRZRInnwuaCiL6HT2jLeV6AInHQSMqvxDssAPtoajp6zcjZiYPe2JTp8N+58RsJXr4Zu
 eGA1aQSGC1o+P3A1rn74j57ObSyDBQIZPv+cozl0ysnqR/hSF24rA7cqaV7olDZ1FPw4
 vqFg==
X-Gm-Message-State: AOJu0Ywz0RTCQhRwgaHAV8OrB5CqNtFzgF8RHo8c7/mKsqT12hvIL3wm
 wr/FC4kaFcsGJpwzI6vvjOFcN/6sk2Cg+kFDr0OCCLNlPq0bLkDQ1p+318jEi1w=
X-Google-Smtp-Source: AGHT+IEgib4jWrpTO39bj23v2iOiL6T0abBlelhx1G1Th+0+bPdNTkxm1u2Qd8WPlUpcSE4DfCzXwA==
X-Received: by 2002:a2e:b2d1:0:b0:2d8:5084:f5b9 with SMTP id
 17-20020a2eb2d1000000b002d85084f5b9mr827626ljz.28.1712895536992; 
 Thu, 11 Apr 2024 21:18:56 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com.
 [209.85.208.176]) by smtp.gmail.com with ESMTPSA id
 k8-20020a05651c0a0800b002d85452f55csm401193ljq.47.2024.04.11.21.18.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Apr 2024 21:18:56 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id
 38308e7fff4ca-2d8a24f8a3cso4235151fa.1
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 21:18:56 -0700 (PDT)
X-Received: by 2002:a05:651c:1a21:b0:2d8:4890:c0fa with SMTP id
 by33-20020a05651c1a2100b002d84890c0famr981155ljb.35.1712895536538; Thu, 11
 Apr 2024 21:18:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240412021509.145502-1-richard.henderson@linaro.org>
In-Reply-To: <20240412021509.145502-1-richard.henderson@linaro.org>
From: M Bazz <bazz@bazz1.com>
Date: Fri, 12 Apr 2024 00:18:44 -0400
X-Gmail-Original-Message-ID: <CAMFqb-bp48=Kd23AzwZ2U3AsPbnwUBUiyv=37ua1V_RDQ3wdyg@mail.gmail.com>
Message-ID: <CAMFqb-bp48=Kd23AzwZ2U3AsPbnwUBUiyv=37ua1V_RDQ3wdyg@mail.gmail.com>
Subject: Re: [PATCH] target/sparc: Use GET_ASI_CODE for ASI_KERNELTXT and
 ASI_USERTXT
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Artyom Tarasenko <atar4qemu@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000fe2f4a0615de9181"
Received-SPF: pass client-ip=209.85.208.179; envelope-from=bazz1tv2@gmail.com;
 helo=mail-lj1-f179.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--000000000000fe2f4a0615de9181
Content-Type: text/plain; charset="UTF-8"

On Thu, Apr 11, 2024, 10:15 PM Richard Henderson <
richard.henderson@linaro.org> wrote:

> Reads are done with execute access.  It is not clear whether writes
> are legal at all -- for now, leave helper_st_asi unchanged, so that
> we continue to raise an mmu fault.
>
> This generalizes the exiting code for ASI_KERNELTXT to be usable for
> ASI_USERTXT as well, by passing down the MemOpIdx to use.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2281
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2059
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1609
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1166
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/sparc/helper.h      |  3 ++
>  target/sparc/ldst_helper.c | 65 ++++++++++++++++++++++++++------------
>  target/sparc/translate.c   | 49 ++++++++++++++++++++++++++--
>  3 files changed, 95 insertions(+), 22 deletions(-)
>
> diff --git a/target/sparc/helper.h b/target/sparc/helper.h
> index e55fad5b8c..b8087d0d2b 100644
> --- a/target/sparc/helper.h
> +++ b/target/sparc/helper.h
> @@ -32,6 +32,9 @@ DEF_HELPER_FLAGS_3(udiv, TCG_CALL_NO_WG, i64, env, tl,
> tl)
>  DEF_HELPER_FLAGS_3(sdiv, TCG_CALL_NO_WG, i64, env, tl, tl)
>  DEF_HELPER_3(taddcctv, tl, env, tl, tl)
>  DEF_HELPER_3(tsubcctv, tl, env, tl, tl)
> +#if !defined(CONFIG_USER_ONLY) && !defined(TARGET_SPARC64)
> +DEF_HELPER_FLAGS_3(ld_code, TCG_CALL_NO_WG, i64, env, tl, i32)
> +#endif
>  #if !defined(CONFIG_USER_ONLY) || defined(TARGET_SPARC64)
>  DEF_HELPER_FLAGS_4(ld_asi, TCG_CALL_NO_WG, i64, env, tl, int, i32)
>  DEF_HELPER_FLAGS_5(st_asi, TCG_CALL_NO_WG, void, env, tl, i64, int, i32)
> diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
> index e581bb42ac..2846a86cc4 100644
> --- a/target/sparc/ldst_helper.c
> +++ b/target/sparc/ldst_helper.c
> @@ -585,7 +585,6 @@ uint64_t helper_ld_asi(CPUSPARCState *env,
> target_ulong addr,
>  #if defined(DEBUG_MXCC) || defined(DEBUG_ASI)
>      uint32_t last_addr = addr;
>  #endif
> -    MemOpIdx oi;
>
>      do_check_align(env, addr, size - 1, GETPC());
>      switch (asi) {
> @@ -684,24 +683,6 @@ uint64_t helper_ld_asi(CPUSPARCState *env,
> target_ulong addr,
>      case ASI_M_DIAGS:   /* Turbosparc DTLB Diagnostic */
>      case ASI_M_IODIAG:  /* Turbosparc IOTLB Diagnostic */
>          break;
> -    case ASI_KERNELTXT: /* Supervisor code access */
> -        oi = make_memop_idx(memop, cpu_mmu_index(env_cpu(env), true));
> -        switch (size) {
> -        case 1:
> -            ret = cpu_ldb_code_mmu(env, addr, oi, GETPC());
> -            break;
> -        case 2:
> -            ret = cpu_ldw_code_mmu(env, addr, oi, GETPC());
> -            break;
> -        default:
> -        case 4:
> -            ret = cpu_ldl_code_mmu(env, addr, oi, GETPC());
> -            break;
> -        case 8:
> -            ret = cpu_ldq_code_mmu(env, addr, oi, GETPC());
> -            break;
> -        }
> -        break;
>      case ASI_M_TXTC_TAG:   /* SparcStation 5 I-cache tag */
>      case ASI_M_TXTC_DATA:  /* SparcStation 5 I-cache data */
>      case ASI_M_DATAC_TAG:  /* SparcStation 5 D-cache tag */
> @@ -779,7 +760,6 @@ uint64_t helper_ld_asi(CPUSPARCState *env,
> target_ulong addr,
>      case 0x4c: /* SuperSPARC MMU Breakpoint Action */
>          ret = env->mmubpaction;
>          break;
> -    case ASI_USERTXT: /* User code access, XXX */
>      default:
>          sparc_raise_mmu_fault(cs, addr, false, false, asi, size, GETPC());
>          ret = 0;
> @@ -787,6 +767,8 @@ uint64_t helper_ld_asi(CPUSPARCState *env,
> target_ulong addr,
>
>      case ASI_USERDATA: /* User data access */
>      case ASI_KERNELDATA: /* Supervisor data access */
> +    case ASI_USERTXT: /* User code access */
> +    case ASI_KERNELTXT: /* Supervisor code access */
>      case ASI_P: /* Implicit primary context data access (v9 only?) */
>      case ASI_M_BYPASS:    /* MMU passthrough */
>      case ASI_LEON_BYPASS: /* LEON MMU passthrough */
> @@ -1161,6 +1143,49 @@ void helper_st_asi(CPUSPARCState *env, target_ulong
> addr, uint64_t val,
>  #endif
>  }
>
> +uint64_t helper_ld_code(CPUSPARCState *env, target_ulong addr, uint32_t
> oi)
> +{
> +    MemOp mop = get_memop(oi);
> +    uintptr_t ra = GETPC();
> +    uint64_t ret;
> +
> +    switch (mop & MO_SIZE) {
> +    case MO_8:
> +        ret = cpu_ldb_code_mmu(env, addr, oi, ra);
> +        if (mop & MO_SIGN) {
> +            ret = (int8_t)ret;
> +        }
> +        break;
> +    case MO_16:
> +        ret = cpu_ldw_code_mmu(env, addr, oi, ra);
> +        if ((mop & MO_BSWAP) != MO_TE) {
> +            ret = bswap16(ret);
> +        }
> +        if (mop & MO_SIGN) {
> +            ret = (int16_t)ret;
> +        }
> +        break;
> +    case MO_32:
> +        ret = cpu_ldl_code_mmu(env, addr, oi, ra);
> +        if ((mop & MO_BSWAP) != MO_TE) {
> +            ret = bswap32(ret);
> +        }
> +        if (mop & MO_SIGN) {
> +            ret = (int32_t)ret;
> +        }
> +        break;
> +    case MO_64:
> +        ret = cpu_ldq_code_mmu(env, addr, oi, ra);
> +        if ((mop & MO_BSWAP) != MO_TE) {
> +            ret = bswap64(ret);
> +        }
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +    return ret;
> +}
> +
>  #endif /* CONFIG_USER_ONLY */
>  #else /* TARGET_SPARC64 */
>
> diff --git a/target/sparc/translate.c b/target/sparc/translate.c
> index 319934d9bd..c9b9b047df 100644
> --- a/target/sparc/translate.c
> +++ b/target/sparc/translate.c
> @@ -1117,6 +1117,7 @@ typedef enum {
>      GET_ASI_EXCP,
>      GET_ASI_DIRECT,
>      GET_ASI_DTWINX,
> +    GET_ASI_CODE,
>      GET_ASI_BLOCK,
>      GET_ASI_SHORT,
>      GET_ASI_BCOPY,
> @@ -1159,14 +1160,22 @@ static DisasASI resolve_asi(DisasContext *dc, int
> asi, MemOp memop)
>                 || (asi == ASI_USERDATA
>                     && (dc->def->features & CPU_FEATURE_CASA))) {
>          switch (asi) {
> -        case ASI_USERDATA:   /* User data access */
> +        case ASI_USERDATA:    /* User data access */
>              mem_idx = MMU_USER_IDX;
>              type = GET_ASI_DIRECT;
>              break;
> -        case ASI_KERNELDATA: /* Supervisor data access */
> +        case ASI_KERNELDATA:  /* Supervisor data access */
>              mem_idx = MMU_KERNEL_IDX;
>              type = GET_ASI_DIRECT;
>              break;
> +        case ASI_USERTXT:     /* User text access */
> +            mem_idx = MMU_USER_IDX;
> +            type = GET_ASI_CODE;
> +            break;
> +        case ASI_KERNELTXT:   /* Supervisor text access */
> +            mem_idx = MMU_KERNEL_IDX;
> +            type = GET_ASI_CODE;
> +            break;
>          case ASI_M_BYPASS:    /* MMU passthrough */
>          case ASI_LEON_BYPASS: /* LEON MMU passthrough */
>              mem_idx = MMU_PHYS_IDX;
> @@ -1379,6 +1388,22 @@ static void gen_ld_asi(DisasContext *dc, DisasASI
> *da, TCGv dst, TCGv addr)
>      case GET_ASI_DIRECT:
>          tcg_gen_qemu_ld_tl(dst, addr, da->mem_idx, da->memop | MO_ALIGN);
>          break;
> +
> +    case GET_ASI_CODE:
> +#if !defined(CONFIG_USER_ONLY) && !defined(TARGET_SPARC64)
> +        {
> +            MemOpIdx oi = make_memop_idx(da->memop, da->mem_idx);
> +            TCGv_i32 r_oi = tcg_constant_i32(oi);
> +            TCGv_i64 t64 = tcg_temp_new_i64();
> +
> +            gen_helper_ld_code(t64, tcg_env, addr, r_oi);
> +            tcg_gen_trunc_i64_tl(dst, t64);
> +        }
> +        break;
> +#else
> +        g_assert_not_reached();
> +#endif
> +
>      default:
>          {
>              TCGv_i32 r_asi = tcg_constant_i32(da->asi);
> @@ -1791,6 +1816,26 @@ static void gen_ldda_asi(DisasContext *dc, DisasASI
> *da, TCGv addr, int rd)
>          }
>          break;
>
> +    case GET_ASI_CODE:
> +#if !defined(CONFIG_USER_ONLY) && !defined(TARGET_SPARC64)
> +        {
> +            TCGv_i64 tmp = tcg_temp_new_i64();
> +            MemOpIdx oi = make_memop_idx(da->memop, da->mem_idx);
> +
> +            gen_helper_ld_code(tmp, tcg_env, addr, tcg_constant_i32(oi));
> +
> +            /* See above.  */
> +            if ((da->memop & MO_BSWAP) == MO_TE) {
> +                tcg_gen_extr_i64_tl(lo, hi, tmp);
> +            } else {
> +                tcg_gen_extr_i64_tl(hi, lo, tmp);
> +            }
> +        }
> +        break;
> +#else
> +        g_assert_not_reached();
> +#endif
> +
>      default:
>          /* ??? In theory we've handled all of the ASIs that are valid
>             for ldda, and this should raise DAE_invalid_asi.  However,
> --
> 2.34.1
>

Hi Richard,

I see this is in your hands now. I agree with your take on leaving writes
alone. I'm also grateful for the opportunity to collaborate with you.

It brings a smile for the community members who will be touched by this
amazing contribution. I see them happily realizing that this perplexing bug
has been solved, and in our case finally able to use the debuggers we love!
:D

Thanks for the proper fix, qemu sensei!

-bazz

>

--000000000000fe2f4a0615de9181
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr">On Thu, Apr 11, 2024, 10:15 PM Richard Henderson &lt;<a href=
=3D"mailto:richard.henderson@linaro.org">richard.henderson@linaro.org</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex">Reads are done with execu=
te access.=C2=A0 It is not clear whether writes<br>
are legal at all -- for now, leave helper_st_asi unchanged, so that<br>
we continue to raise an mmu fault.<br>
<br>
This generalizes the exiting code for ASI_KERNELTXT to be usable for<br>
ASI_USERTXT as well, by passing down the MemOpIdx to use.<br>
<br>
Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/2281" re=
l=3D"noreferrer noreferrer" target=3D"_blank">https://gitlab.com/qemu-proje=
ct/qemu/-/issues/2281</a><br>
Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/2059" re=
l=3D"noreferrer noreferrer" target=3D"_blank">https://gitlab.com/qemu-proje=
ct/qemu/-/issues/2059</a><br>
Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/1609" re=
l=3D"noreferrer noreferrer" target=3D"_blank">https://gitlab.com/qemu-proje=
ct/qemu/-/issues/1609</a><br>
Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/1166" re=
l=3D"noreferrer noreferrer" target=3D"_blank">https://gitlab.com/qemu-proje=
ct/qemu/-/issues/1166</a><br>
Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@li=
naro.org" target=3D"_blank" rel=3D"noreferrer">richard.henderson@linaro.org=
</a>&gt;<br>
---<br>
=C2=A0target/sparc/helper.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 3 ++<br>
=C2=A0target/sparc/ldst_helper.c | 65 ++++++++++++++++++++++++++-----------=
-<br>
=C2=A0target/sparc/translate.c=C2=A0 =C2=A0| 49 ++++++++++++++++++++++++++-=
-<br>
=C2=A03 files changed, 95 insertions(+), 22 deletions(-)<br>
<br>
diff --git a/target/sparc/helper.h b/target/sparc/helper.h<br>
index e55fad5b8c..b8087d0d2b 100644<br>
--- a/target/sparc/helper.h<br>
+++ b/target/sparc/helper.h<br>
@@ -32,6 +32,9 @@ DEF_HELPER_FLAGS_3(udiv, TCG_CALL_NO_WG, i64, env, tl, tl=
)<br>
=C2=A0DEF_HELPER_FLAGS_3(sdiv, TCG_CALL_NO_WG, i64, env, tl, tl)<br>
=C2=A0DEF_HELPER_3(taddcctv, tl, env, tl, tl)<br>
=C2=A0DEF_HELPER_3(tsubcctv, tl, env, tl, tl)<br>
+#if !defined(CONFIG_USER_ONLY) &amp;&amp; !defined(TARGET_SPARC64)<br>
+DEF_HELPER_FLAGS_3(ld_code, TCG_CALL_NO_WG, i64, env, tl, i32)<br>
+#endif<br>
=C2=A0#if !defined(CONFIG_USER_ONLY) || defined(TARGET_SPARC64)<br>
=C2=A0DEF_HELPER_FLAGS_4(ld_asi, TCG_CALL_NO_WG, i64, env, tl, int, i32)<br=
>
=C2=A0DEF_HELPER_FLAGS_5(st_asi, TCG_CALL_NO_WG, void, env, tl, i64, int, i=
32)<br>
diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c<br>
index e581bb42ac..2846a86cc4 100644<br>
--- a/target/sparc/ldst_helper.c<br>
+++ b/target/sparc/ldst_helper.c<br>
@@ -585,7 +585,6 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong=
 addr,<br>
=C2=A0#if defined(DEBUG_MXCC) || defined(DEBUG_ASI)<br>
=C2=A0 =C2=A0 =C2=A0uint32_t last_addr =3D addr;<br>
=C2=A0#endif<br>
-=C2=A0 =C2=A0 MemOpIdx oi;<br>
<br>
=C2=A0 =C2=A0 =C2=A0do_check_align(env, addr, size - 1, GETPC());<br>
=C2=A0 =C2=A0 =C2=A0switch (asi) {<br>
@@ -684,24 +683,6 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulon=
g addr,<br>
=C2=A0 =C2=A0 =C2=A0case ASI_M_DIAGS:=C2=A0 =C2=A0/* Turbosparc DTLB Diagno=
stic */<br>
=C2=A0 =C2=A0 =C2=A0case ASI_M_IODIAG:=C2=A0 /* Turbosparc IOTLB Diagnostic=
 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 case ASI_KERNELTXT: /* Supervisor code access */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 oi =3D make_memop_idx(memop, cpu_mmu_index(env=
_cpu(env), true));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (size) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 1:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D cpu_ldb_code_mmu(env, ad=
dr, oi, GETPC());<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 2:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D cpu_ldw_code_mmu(env, ad=
dr, oi, GETPC());<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 4:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D cpu_ldl_code_mmu(env, ad=
dr, oi, GETPC());<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 8:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D cpu_ldq_code_mmu(env, ad=
dr, oi, GETPC());<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0case ASI_M_TXTC_TAG:=C2=A0 =C2=A0/* SparcStation 5 I-ca=
che tag */<br>
=C2=A0 =C2=A0 =C2=A0case ASI_M_TXTC_DATA:=C2=A0 /* SparcStation 5 I-cache d=
ata */<br>
=C2=A0 =C2=A0 =C2=A0case ASI_M_DATAC_TAG:=C2=A0 /* SparcStation 5 D-cache t=
ag */<br>
@@ -779,7 +760,6 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong=
 addr,<br>
=C2=A0 =C2=A0 =C2=A0case 0x4c: /* SuperSPARC MMU Breakpoint Action */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D env-&gt;mmubpaction;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 case ASI_USERTXT: /* User code access, XXX */<br>
=C2=A0 =C2=A0 =C2=A0default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sparc_raise_mmu_fault(cs, addr, false, fa=
lse, asi, size, GETPC());<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D 0;<br>
@@ -787,6 +767,8 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong=
 addr,<br>
<br>
=C2=A0 =C2=A0 =C2=A0case ASI_USERDATA: /* User data access */<br>
=C2=A0 =C2=A0 =C2=A0case ASI_KERNELDATA: /* Supervisor data access */<br>
+=C2=A0 =C2=A0 case ASI_USERTXT: /* User code access */<br>
+=C2=A0 =C2=A0 case ASI_KERNELTXT: /* Supervisor code access */<br>
=C2=A0 =C2=A0 =C2=A0case ASI_P: /* Implicit primary context data access (v9=
 only?) */<br>
=C2=A0 =C2=A0 =C2=A0case ASI_M_BYPASS:=C2=A0 =C2=A0 /* MMU passthrough */<b=
r>
=C2=A0 =C2=A0 =C2=A0case ASI_LEON_BYPASS: /* LEON MMU passthrough */<br>
@@ -1161,6 +1143,49 @@ void helper_st_asi(CPUSPARCState *env, target_ulong =
addr, uint64_t val,<br>
=C2=A0#endif<br>
=C2=A0}<br>
<br>
+uint64_t helper_ld_code(CPUSPARCState *env, target_ulong addr, uint32_t oi=
)<br>
+{<br>
+=C2=A0 =C2=A0 MemOp mop =3D get_memop(oi);<br>
+=C2=A0 =C2=A0 uintptr_t ra =3D GETPC();<br>
+=C2=A0 =C2=A0 uint64_t ret;<br>
+<br>
+=C2=A0 =C2=A0 switch (mop &amp; MO_SIZE) {<br>
+=C2=A0 =C2=A0 case MO_8:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D cpu_ldb_code_mmu(env, addr, oi, ra);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (mop &amp; MO_SIGN) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D (int8_t)ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case MO_16:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D cpu_ldw_code_mmu(env, addr, oi, ra);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((mop &amp; MO_BSWAP) !=3D MO_TE) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D bswap16(ret);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (mop &amp; MO_SIGN) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D (int16_t)ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case MO_32:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D cpu_ldl_code_mmu(env, addr, oi, ra);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((mop &amp; MO_BSWAP) !=3D MO_TE) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D bswap32(ret);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (mop &amp; MO_SIGN) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D (int32_t)ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case MO_64:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D cpu_ldq_code_mmu(env, addr, oi, ra);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((mop &amp; MO_BSWAP) !=3D MO_TE) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D bswap64(ret);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_not_reached();<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return ret;<br>
+}<br>
+<br>
=C2=A0#endif /* CONFIG_USER_ONLY */<br>
=C2=A0#else /* TARGET_SPARC64 */<br>
<br>
diff --git a/target/sparc/translate.c b/target/sparc/translate.c<br>
index 319934d9bd..c9b9b047df 100644<br>
--- a/target/sparc/translate.c<br>
+++ b/target/sparc/translate.c<br>
@@ -1117,6 +1117,7 @@ typedef enum {<br>
=C2=A0 =C2=A0 =C2=A0GET_ASI_EXCP,<br>
=C2=A0 =C2=A0 =C2=A0GET_ASI_DIRECT,<br>
=C2=A0 =C2=A0 =C2=A0GET_ASI_DTWINX,<br>
+=C2=A0 =C2=A0 GET_ASI_CODE,<br>
=C2=A0 =C2=A0 =C2=A0GET_ASI_BLOCK,<br>
=C2=A0 =C2=A0 =C2=A0GET_ASI_SHORT,<br>
=C2=A0 =C2=A0 =C2=A0GET_ASI_BCOPY,<br>
@@ -1159,14 +1160,22 @@ static DisasASI resolve_asi(DisasContext *dc, int a=
si, MemOp memop)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 || (asi =3D=3D ASI_=
USERDATA<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;=
&amp; (dc-&gt;def-&gt;features &amp; CPU_FEATURE_CASA))) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switch (asi) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 case ASI_USERDATA:=C2=A0 =C2=A0/* User data ac=
cess */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case ASI_USERDATA:=C2=A0 =C2=A0 /* User data a=
ccess */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mem_idx =3D MMU_USER_IDX;<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0type =3D GET_ASI_DIRECT;<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 case ASI_KERNELDATA: /* Supervisor data access=
 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case ASI_KERNELDATA:=C2=A0 /* Supervisor data =
access */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mem_idx =3D MMU_KERNEL_IDX;=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0type =3D GET_ASI_DIRECT;<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case ASI_USERTXT:=C2=A0 =C2=A0 =C2=A0/* User t=
ext access */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mem_idx =3D MMU_USER_IDX;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 type =3D GET_ASI_CODE;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case ASI_KERNELTXT:=C2=A0 =C2=A0/* Supervisor =
text access */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mem_idx =3D MMU_KERNEL_IDX;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 type =3D GET_ASI_CODE;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case ASI_M_BYPASS:=C2=A0 =C2=A0 /* MMU pa=
ssthrough */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case ASI_LEON_BYPASS: /* LEON MMU passthr=
ough */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mem_idx =3D MMU_PHYS_IDX;<b=
r>
@@ -1379,6 +1388,22 @@ static void gen_ld_asi(DisasContext *dc, DisasASI *d=
a, TCGv dst, TCGv addr)<br>
=C2=A0 =C2=A0 =C2=A0case GET_ASI_DIRECT:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_gen_qemu_ld_tl(dst, addr, da-&gt;mem_=
idx, da-&gt;memop | MO_ALIGN);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
+<br>
+=C2=A0 =C2=A0 case GET_ASI_CODE:<br>
+#if !defined(CONFIG_USER_ONLY) &amp;&amp; !defined(TARGET_SPARC64)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MemOpIdx oi =3D make_memop_idx(d=
a-&gt;memop, da-&gt;mem_idx);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TCGv_i32 r_oi =3D tcg_constant_i=
32(oi);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TCGv_i64 t64 =3D tcg_temp_new_i6=
4();<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_helper_ld_code(t64, tcg_env,=
 addr, r_oi);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_trunc_i64_tl(dst, t64);<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+#else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_not_reached();<br>
+#endif<br>
+<br>
=C2=A0 =C2=A0 =C2=A0default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TCGv_i32 r_asi =3D tcg_cons=
tant_i32(da-&gt;asi);<br>
@@ -1791,6 +1816,26 @@ static void gen_ldda_asi(DisasContext *dc, DisasASI =
*da, TCGv addr, int rd)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
<br>
+=C2=A0 =C2=A0 case GET_ASI_CODE:<br>
+#if !defined(CONFIG_USER_ONLY) &amp;&amp; !defined(TARGET_SPARC64)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TCGv_i64 tmp =3D tcg_temp_new_i6=
4();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MemOpIdx oi =3D make_memop_idx(d=
a-&gt;memop, da-&gt;mem_idx);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_helper_ld_code(tmp, tcg_env,=
 addr, tcg_constant_i32(oi));<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* See above.=C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((da-&gt;memop &amp; MO_BSWAP=
) =3D=3D MO_TE) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_extr_i64_t=
l(lo, hi, tmp);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_extr_i64_t=
l(hi, lo, tmp);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+#else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_not_reached();<br>
+#endif<br>
+<br>
=C2=A0 =C2=A0 =C2=A0default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* ??? In theory we&#39;ve handled all of=
 the ASIs that are valid<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for ldda, and this should raise D=
AE_invalid_asi.=C2=A0 However,<br>
-- <br>
2.34.1<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"=
auto">Hi Richard,</div><div dir=3D"auto"><br></div><div dir=3D"auto">I see =
this is in your hands now. I agree with your take on leaving writes alone. =
I&#39;m also grateful for the opportunity to collaborate with you.</div><di=
v dir=3D"auto"><br></div><div dir=3D"auto">It brings a smile for the commun=
ity members who will be touched by this amazing contribution. I see them ha=
ppily realizing that this perplexing bug has been solved, and in our case f=
inally able to use the debuggers we love! :D</div><div dir=3D"auto"><br></d=
iv><div dir=3D"auto">Thanks for the proper fix, qemu sensei!</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">-bazz</div><div dir=3D"auto"><div cla=
ss=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex"></blockquote></div></div>=
</div>

--000000000000fe2f4a0615de9181--

