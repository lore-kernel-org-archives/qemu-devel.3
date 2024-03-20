Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C0DC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 05:04:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmo7E-0001Qt-Pi; Wed, 20 Mar 2024 01:03:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rmo7D-0001Qg-4a; Wed, 20 Mar 2024 01:03:51 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rmo7B-0001l8-2U; Wed, 20 Mar 2024 01:03:50 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1deefb08b9eso29972345ad.3; 
 Tue, 19 Mar 2024 22:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710911027; x=1711515827; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JyL5NC/8thKVlaxG5zLKsChbkNqiGPGhNKrDqolGTKs=;
 b=JDlOIBPdPDk9lb0U8s4M2EcuQEs8OK1mJfwzwEpgSh2xBANxMvlVh5nG2IpnHwKd4u
 8CONAXb6Qof5gozN3jR3mxu2DTyRgtHKmhxHyXlns8KAwd3M9/lJLPL1qRRhmNbW+z8o
 PCNzb0z+4v2ay0o5O1xo6l7HJusCQSxA7DIo37SIjr6m1Zc9JlxfjJpvCAnoguqGiWIf
 dJbDTaLmZA6pkuJGy7OizPmaqMEZIrECo7gdI9N1+13neYMXgRx2r62UzYirWjB1J7o+
 S/NikrlYE0FiW1qVMXHV0l7YxDrebs676ERhRZM9rpxh6mPNYLEjpwucIfg1o7fk4O5Z
 nTJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710911027; x=1711515827;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JyL5NC/8thKVlaxG5zLKsChbkNqiGPGhNKrDqolGTKs=;
 b=BdUmI67pS3LxumonG6YFDZqMdRhNCsTVHwFOBsqz9OX1tkMMRjCwmuKPHj1IWK8ga7
 OVtnIN2Wj0GBM2t+e1qVqSoJg4PU5avlSjXLdPy/8UzaLqP/5VQdKsLyIP9dsKQ5Qs8P
 HDumQiVR9ENqae2dsTBYA/uWeawz9vSrtakL2loLtHi/zkjVCEmzef7xtoYmKKq/Khrm
 XCivgrFGWab9uJAwrEBVVqNnjS/oG4vZvlJQK8PzFTjfYC81Fz/xLB129cvf/mzZZx93
 Cx0z20XwRZIZFxZFmiD92Z3tBhnotxvRDxtzyfDQFT0ATUhekVDDhnStGEXn2ssvMSlZ
 Wd8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdM4GYWit3TNeD8XddhYVjD7JYFIgN3RDRRvT0DLowTfuVA9eu2LABJnw5h/RUpFDppd0vMEgAtQf1ShEPPTgbl443
X-Gm-Message-State: AOJu0Ywlh0RRPklqJgHdyfRE4QruHD8rZWONiA+vd5AtvsSKelH+uGJz
 1MzTGV/PdtgvTtu8zx9oGhpBE58cPIFoaG4oWCp7tlP2A2en4vA1
X-Google-Smtp-Source: AGHT+IGAwo93TfzJ1pA5TkYVttFrxCh6bvZFL9mOYXJG58ABe8rK07SGMQkG+hRpF30YA/4jpsmB6w==
X-Received: by 2002:a17:903:428f:b0:1e0:2b2a:fe40 with SMTP id
 ju15-20020a170903428f00b001e02b2afe40mr4069185plb.40.1710911026859; 
 Tue, 19 Mar 2024 22:03:46 -0700 (PDT)
Received: from localhost (193-116-208-39.tpgi.com.au. [193.116.208.39])
 by smtp.gmail.com with ESMTPSA id
 o12-20020a170902d4cc00b001dd7c2ea323sm6173523plg.114.2024.03.19.22.03.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 22:03:46 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 20 Mar 2024 15:03:39 +1000
Message-Id: <CZYBC7UBTRH0.2SURG9VVUXKG@wheely>
Cc: <qemu-devel@nongnu.org>, <danielhb413@gmail.com>, <clg@kaod.org>,
 <richard.henderson@linaro.org>, <peter.maydell@linaro.org>,
 <harshpb@linux.ibm.com>, <sbhat@linux.ibm.com>
Subject: Re: [PATCH v2 1/2] target/ppc: Merge various fpu helpers
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Chinmay Rath" <rathc@linux.ibm.com>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20240315064422.737812-1-rathc@linux.ibm.com>
 <20240315064422.737812-2-rathc@linux.ibm.com>
In-Reply-To: <20240315064422.737812-2-rathc@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri Mar 15, 2024 at 4:44 PM AEST, Chinmay Rath wrote:
> This patch merges the definitions of the following set of fpu helper meth=
ods,
> which are similar, using macros :
>
> 1. f{add, sub, mul, div}(s)
> 2. fre(s)
> 3. frsqrte(s)
>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>  target/ppc/fpu_helper.c | 221 +++++++++++-----------------------------
>  1 file changed, 62 insertions(+), 159 deletions(-)
>
> diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
> index 4b3dcad5d1..8d0cbe27e7 100644
> --- a/target/ppc/fpu_helper.c
> +++ b/target/ppc/fpu_helper.c
> @@ -490,54 +490,12 @@ static void float_invalid_op_addsub(CPUPPCState *en=
v, int flags,
>      }
>  }
> =20
> -/* fadd - fadd. */
> -float64 helper_fadd(CPUPPCState *env, float64 arg1, float64 arg2)
> +static inline void addsub_flags_handler(CPUPPCState *env, int flags,
> +                                        uintptr_t ra)
>  {
> -    float64 ret =3D float64_add(arg1, arg2, &env->fp_status);
> -    int flags =3D get_float_exception_flags(&env->fp_status);
> -
> -    if (unlikely(flags & float_flag_invalid)) {
> -        float_invalid_op_addsub(env, flags, 1, GETPC());
> -    }
> -
> -    return ret;
> -}
> -
> -/* fadds - fadds. */
> -float64 helper_fadds(CPUPPCState *env, float64 arg1, float64 arg2)
> -{
> -    float64 ret =3D float64r32_add(arg1, arg2, &env->fp_status);
> -    int flags =3D get_float_exception_flags(&env->fp_status);
> -
> -    if (unlikely(flags & float_flag_invalid)) {
> -        float_invalid_op_addsub(env, flags, 1, GETPC());
> -    }
> -    return ret;
> -}
> -
> -/* fsub - fsub. */
> -float64 helper_fsub(CPUPPCState *env, float64 arg1, float64 arg2)
> -{
> -    float64 ret =3D float64_sub(arg1, arg2, &env->fp_status);
> -    int flags =3D get_float_exception_flags(&env->fp_status);
> -
>      if (unlikely(flags & float_flag_invalid)) {
> -        float_invalid_op_addsub(env, flags, 1, GETPC());
> +        float_invalid_op_addsub(env, flags, 1, ra);
>      }
> -
> -    return ret;
> -}
> -
> -/* fsubs - fsubs. */
> -float64 helper_fsubs(CPUPPCState *env, float64 arg1, float64 arg2)
> -{
> -    float64 ret =3D float64r32_sub(arg1, arg2, &env->fp_status);
> -    int flags =3D get_float_exception_flags(&env->fp_status);
> -
> -    if (unlikely(flags & float_flag_invalid)) {
> -        float_invalid_op_addsub(env, flags, 1, GETPC());
> -    }
> -    return ret;
>  }
> =20
>  static void float_invalid_op_mul(CPUPPCState *env, int flags,
> @@ -550,29 +508,11 @@ static void float_invalid_op_mul(CPUPPCState *env, =
int flags,
>      }
>  }
> =20
> -/* fmul - fmul. */
> -float64 helper_fmul(CPUPPCState *env, float64 arg1, float64 arg2)
> -{
> -    float64 ret =3D float64_mul(arg1, arg2, &env->fp_status);
> -    int flags =3D get_float_exception_flags(&env->fp_status);
> -
> -    if (unlikely(flags & float_flag_invalid)) {
> -        float_invalid_op_mul(env, flags, 1, GETPC());
> -    }
> -
> -    return ret;
> -}
> -
> -/* fmuls - fmuls. */
> -float64 helper_fmuls(CPUPPCState *env, float64 arg1, float64 arg2)
> +static inline void mul_flags_handler(CPUPPCState *env, int flags, uintpt=
r_t ra)
>  {
> -    float64 ret =3D float64r32_mul(arg1, arg2, &env->fp_status);
> -    int flags =3D get_float_exception_flags(&env->fp_status);
> -
>      if (unlikely(flags & float_flag_invalid)) {
> -        float_invalid_op_mul(env, flags, 1, GETPC());
> +        float_invalid_op_mul(env, flags, 1, ra);
>      }
> -    return ret;
>  }
> =20
>  static void float_invalid_op_div(CPUPPCState *env, int flags,
> @@ -587,36 +527,14 @@ static void float_invalid_op_div(CPUPPCState *env, =
int flags,
>      }
>  }
> =20
> -/* fdiv - fdiv. */
> -float64 helper_fdiv(CPUPPCState *env, float64 arg1, float64 arg2)
> -{
> -    float64 ret =3D float64_div(arg1, arg2, &env->fp_status);
> -    int flags =3D get_float_exception_flags(&env->fp_status);
> -
> -    if (unlikely(flags & float_flag_invalid)) {
> -        float_invalid_op_div(env, flags, 1, GETPC());
> -    }
> -    if (unlikely(flags & float_flag_divbyzero)) {
> -        float_zero_divide_excp(env, GETPC());
> -    }
> -
> -    return ret;
> -}
> -
> -/* fdivs - fdivs. */
> -float64 helper_fdivs(CPUPPCState *env, float64 arg1, float64 arg2)
> +static inline void div_flags_handler(CPUPPCState *env, int flags, uintpt=
r_t ra)
>  {
> -    float64 ret =3D float64r32_div(arg1, arg2, &env->fp_status);
> -    int flags =3D get_float_exception_flags(&env->fp_status);
> -
>      if (unlikely(flags & float_flag_invalid)) {
> -        float_invalid_op_div(env, flags, 1, GETPC());
> +        float_invalid_op_div(env, flags, 1, ra);
>      }
>      if (unlikely(flags & float_flag_divbyzero)) {
> -        float_zero_divide_excp(env, GETPC());
> +        float_zero_divide_excp(env, ra);
>      }
> -
> -    return ret;
>  }
> =20
>  static uint64_t float_invalid_cvt(CPUPPCState *env, int flags,
> @@ -812,81 +730,66 @@ float64 helper_##name(CPUPPCState *env, float64 arg=
)                          \
>  FPU_FSQRT(FSQRT, float64_sqrt)
>  FPU_FSQRT(FSQRTS, float64r32_sqrt)
> =20
> -/* fre - fre. */
> -float64 helper_fre(CPUPPCState *env, float64 arg)
> -{
> -    /* "Estimate" the reciprocal with actual division.  */
> -    float64 ret =3D float64_div(float64_one, arg, &env->fp_status);
> -    int flags =3D get_float_exception_flags(&env->fp_status);
> -
> -    if (unlikely(flags & float_flag_invalid_snan)) {
> -        float_invalid_op_vxsnan(env, GETPC());
> -    }
> -    if (unlikely(flags & float_flag_divbyzero)) {
> -        float_zero_divide_excp(env, GETPC());
> -        /* For FPSCR.ZE =3D=3D 0, the result is 1/2.  */
> -        ret =3D float64_set_sign(float64_half, float64_is_neg(arg));
> -    }
> -
> -    return ret;
> +#define FPU_FRE(name, op)                                               =
      \
> +float64 helper_##name(CPUPPCState *env, float64 arg)                    =
      \
> +{                                                                       =
      \
> +    /* "Estimate" the reciprocal with actual division.  */              =
      \
> +    float64 ret =3D op(float64_one, arg, &env->fp_status);              =
        \
> +    int flags =3D get_float_exception_flags(&env->fp_status);           =
        \
> +                                                                        =
      \
> +    if (unlikely(flags & float_flag_invalid_snan)) {                    =
      \
> +        float_invalid_op_vxsnan(env, GETPC());                          =
      \
> +    }                                                                   =
      \
> +    if (unlikely(flags & float_flag_divbyzero)) {                       =
      \
> +        float_zero_divide_excp(env, GETPC());                           =
      \
> +        /* For FPSCR.ZE =3D=3D 0, the result is 1/2.  */                =
          \
> +        ret =3D float64_set_sign(float64_half, float64_is_neg(arg));    =
        \
> +    }                                                                   =
      \
> +                                                                        =
      \
> +    return ret;                                                         =
      \
>  }
> =20
> -/* fres - fres. */
> -uint64_t helper_fres(CPUPPCState *env, uint64_t arg)
> -{
> -    /* "Estimate" the reciprocal with actual division.  */
> -    float64 ret =3D float64r32_div(float64_one, arg, &env->fp_status);
> -    int flags =3D get_float_exception_flags(&env->fp_status);
> -
> -    if (unlikely(flags & float_flag_invalid_snan)) {
> -        float_invalid_op_vxsnan(env, GETPC());
> -    }
> -    if (unlikely(flags & float_flag_divbyzero)) {
> -        float_zero_divide_excp(env, GETPC());
> -        /* For FPSCR.ZE =3D=3D 0, the result is 1/2.  */
> -        ret =3D float64_set_sign(float64_half, float64_is_neg(arg));
> -    }
> -
> -    return ret;
> +#define FPU_FRSQRTE(name, op)                                           =
      \
> +float64 helper_##name(CPUPPCState *env, float64 arg)                    =
      \
> +{                                                                       =
      \
> +    /* "Estimate" the reciprocal with actual division.  */              =
      \
> +    float64 rets =3D float64_sqrt(arg, &env->fp_status);                =
        \
> +    float64 retd =3D op(float64_one, rets, &env->fp_status);            =
        \
> +    int flags =3D get_float_exception_flags(&env->fp_status);           =
        \
> +                                                                        =
      \
> +    if (unlikely(flags & float_flag_invalid)) {                         =
      \
> +        float_invalid_op_sqrt(env, flags, 1, GETPC());                  =
      \
> +    }                                                                   =
      \
> +    if (unlikely(flags & float_flag_divbyzero)) {                       =
      \
> +        /* Reciprocal of (square root of) zero.  */                     =
      \
> +        float_zero_divide_excp(env, GETPC());                           =
      \
> +    }                                                                   =
      \
> +                                                                        =
      \
> +    return retd;                                                        =
      \
>  }
> =20
> -/* frsqrte  - frsqrte. */
> -float64 helper_frsqrte(CPUPPCState *env, float64 arg)
> -{
> -    /* "Estimate" the reciprocal with actual division.  */
> -    float64 rets =3D float64_sqrt(arg, &env->fp_status);
> -    float64 retd =3D float64_div(float64_one, rets, &env->fp_status);
> -    int flags =3D get_float_exception_flags(&env->fp_status);
> -
> -    if (unlikely(flags & float_flag_invalid)) {
> -        float_invalid_op_sqrt(env, flags, 1, GETPC());
> -    }
> -    if (unlikely(flags & float_flag_divbyzero)) {
> -        /* Reciprocal of (square root of) zero.  */
> -        float_zero_divide_excp(env, GETPC());
> -    }
> -
> -    return retd;
> +#define FPU_HELPER(name, op, flags_handler)                             =
      \
> +float64 helper_##name(CPUPPCState *env, float64 arg1, float64 arg2)     =
      \
> +{                                                                       =
      \
> +    float64 ret =3D op(arg1, arg2, &env->fp_status);                    =
        \
> +    int flags =3D get_float_exception_flags(&env->fp_status);           =
        \
> +    uintptr_t ra =3D GETPC();                                           =
        \
> +    flags_handler(env, flags, ra);                                      =
      \
> +    return ret;                                                         =
      \
>  }
> =20
> -/* frsqrtes  - frsqrtes. */
> -float64 helper_frsqrtes(CPUPPCState *env, float64 arg)
> -{
> -    /* "Estimate" the reciprocal with actual division.  */
> -    float64 rets =3D float64_sqrt(arg, &env->fp_status);
> -    float64 retd =3D float64r32_div(float64_one, rets, &env->fp_status);
> -    int flags =3D get_float_exception_flags(&env->fp_status);
> -
> -    if (unlikely(flags & float_flag_invalid)) {
> -        float_invalid_op_sqrt(env, flags, 1, GETPC());
> -    }
> -    if (unlikely(flags & float_flag_divbyzero)) {
> -        /* Reciprocal of (square root of) zero.  */
> -        float_zero_divide_excp(env, GETPC());
> -    }
> -
> -    return retd;
> -}
> +FPU_FRE(fre, float64_div)
> +FPU_FRE(fres, float64r32_div)
> +FPU_FRSQRTE(frsqrte, float64_div)
> +FPU_FRSQRTE(frsqrtes, float64r32_div)
> +FPU_HELPER(fadd, float64_add, addsub_flags_handler)
> +FPU_HELPER(fadds, float64r32_add, addsub_flags_handler)
> +FPU_HELPER(fsub, float64_sub, addsub_flags_handler)
> +FPU_HELPER(fsubs, float64r32_sub, addsub_flags_handler)
> +FPU_HELPER(fmul, float64_mul, mul_flags_handler)
> +FPU_HELPER(fmuls, float64r32_mul, mul_flags_handler)
> +FPU_HELPER(fdiv, float64_div, div_flags_handler)
> +FPU_HELPER(fdivs, float64r32_div, div_flags_handler)
> =20
>  /* fsel - fsel. */
>  uint64_t helper_FSEL(uint64_t a, uint64_t b, uint64_t c)


