Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38365C54E66
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 09:37:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjyZA-0008HK-BV; Tue, 12 Mar 2024 05:37:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rjyZ5-0008Gm-5f; Tue, 12 Mar 2024 05:36:56 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rjyZ3-00051p-6L; Tue, 12 Mar 2024 05:36:54 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6e5760eeb7aso3817326b3a.1; 
 Tue, 12 Mar 2024 02:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710236210; x=1710841010; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zpO5XAgY1uG2xSNGmqMWPwXUSllkb8Z6znTLmmkzBIU=;
 b=VC7V8abbQw8zbZX30kFM/Nlpudp74AWqsPx2mP8l+VZrYKPDzsB17moenkjE8OMTRb
 qHmqJbBEeDjvGMTeX4hxECWGTNcJFTE9oIwdQoxcVdBCrztI8v10ZzHiO36d9MLXPQge
 xNd6JPJrtEGnJrwNVG/vJbGDcySUdlwcup9hsIrG3ykuy7X8EblD3Y2vEvbJBFYk6Y/5
 zLfcoyV8OPoHrtHYCp2wzqQy9JZx2wr8e08SM6lPTFmBE8j6L0TutJfIQC4eHvM5sGZi
 DVaMo29JCJNuZiGZt0yUjDEP9Y33q8iQ0xDslhTiHOP00DE9z7A68X4iBhrmVaAcb+qd
 cDyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710236210; x=1710841010;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zpO5XAgY1uG2xSNGmqMWPwXUSllkb8Z6znTLmmkzBIU=;
 b=izjUk2Bxrr+l1WcpX17GwMppC3StZdwbhATd3i5pUaLSU/ZfEXMpIYFyoKC7+fsXY9
 QgspvBbETBOqerN9cSeUZb7iYEZ+4lM27fbK1eWMP2TAcJNerCbZnTVyOj8xOPYbpW6Q
 5bwICq+CAmZoKZI08WrUOHTobJoMDYCMtoVrkIaKy4GkuXwc6mNLE2ps/lbcxG31RANi
 SUn5ybtwWJMOEgOjx/cpfxZtJ1WUpEYOqT2BI5GpJJp/TwJ3LTI2/sX+yoHVgK6G1D3h
 KsvsYdCWnmYZxeMP1w+xFX0AO+Rxk9xXaD0xjRU3ZH1w8Yokwtm7CSwxr26UB2ku8GFZ
 uuyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0X3DR3Mmq9eAOitTo5mb4cu1ykV8tIP1PiVBHXYEBqhnlBXOfcOgGFbnT5c/UqID6W7uY2f6sdQL8OW43s0C+EVd2aTM8NDUFR6KLG4XdA/lCwypNnHcqwqY=
X-Gm-Message-State: AOJu0YzZcibbNm9UxKOm3YULu5WhFYh79VE0F1zunNqm2//bHXXGCazl
 QFhMVBBDNemKivJhKA3viPHDRHCtBplyBMoW+7QAUJfzAvIiMPh71JPE73dF5oE=
X-Google-Smtp-Source: AGHT+IHW3EUbrm0KTsL+3G8S+6Fiz9P5Wg77gh3Hkl+qL7+hzDCsdhmklQUsb+mx04hQWKPESwp8mA==
X-Received: by 2002:a05:6a20:d38e:b0:1a1:4733:475b with SMTP id
 iq14-20020a056a20d38e00b001a14733475bmr10774394pzb.38.1710236210647; 
 Tue, 12 Mar 2024 02:36:50 -0700 (PDT)
Received: from localhost ([118.208.155.46]) by smtp.gmail.com with ESMTPSA id
 x13-20020a056a000bcd00b006e45a0101basm5901351pfu.99.2024.03.12.02.36.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 02:36:50 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Mar 2024 19:36:44 +1000
Message-Id: <CZRO4Y67CBPV.2IAKB80EFDKEY@wheely>
Subject: Re: [PATCH] target/ppc: Move floating-point arithmetic instructions
 to decodetree.
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Chinmay Rath" <rathc@linux.ibm.com>, <qemu-ppc@nongnu.org>,
 <qemu-devel@nongnu.org>
Cc: <danielhb413@gmail.com>, <clg@kaod.org>, <richard.henderson@linaro.org>,
 <harshpb@linux.ibm.com>, <sbhat@linux.ibm.com>
X-Mailer: aerc 0.15.2
References: <20240307110318.170319-1-rathc@linux.ibm.com>
In-Reply-To: <20240307110318.170319-1-rathc@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42d.google.com
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

On Thu Mar 7, 2024 at 9:03 PM AEST, Chinmay Rath wrote:
> This patch moves the below instructions to decodetree specification :
>
>     f{add, sub, mul, div, re, rsqrte, madd, msub, nmadd, nmsub}[s][.] : A=
-form
>     ft{div, sqrt}                                                     : X=
-form
>
> With this patch, all the floating-point arithmetic instructions have been
> moved to decodetree.
> The patch also merges the definitions of different sets of helper methods=
 of
> the above instructions, which are similar, using macros.
> The changes were verified by validating that the tcg ops generated by tho=
se
> instructions remain the same, which were captured with the '-d in_asm,op'=
 flag.
>
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>

Hi Chinmay,

Nice patch. I think the fpu_helper.c change should be done separately.

> diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
> index 4b3dcad5d1..a3fcfb3907 100644
> --- a/target/ppc/fpu_helper.c
> +++ b/target/ppc/fpu_helper.c
> @@ -490,54 +490,16 @@ static void float_invalid_op_addsub(CPUPPCState *en=
v, int flags,
>      }
>  }
> =20
> -/* fadd - fadd. */
> -float64 helper_fadd(CPUPPCState *env, float64 arg1, float64 arg2)
> -{
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
> -    if (unlikely(flags & float_flag_invalid)) {
> -        float_invalid_op_addsub(env, flags, 1, GETPC());
> -    }
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
> +#define FPU_ADD_SUB(name, op)                                           =
      \
> +float64 helper_##name(CPUPPCState *env, float64 arg1, float64 arg2)     =
      \
> +{                                                                       =
      \
> +    float64 ret =3D op(arg1, arg2, &env->fp_status);                    =
        \
> +    int flags =3D get_float_exception_flags(&env->fp_status);           =
        \
> +                                                                        =
      \
> +    if (unlikely(flags & float_flag_invalid)) {                         =
      \
> +        float_invalid_op_addsub(env, flags, 1, GETPC());                =
      \
> +    }                                                                   =
      \
> +    return ret;                                                         =
      \
>  }
> =20
>  static void float_invalid_op_mul(CPUPPCState *env, int flags,
> @@ -550,29 +512,17 @@ static void float_invalid_op_mul(CPUPPCState *env, =
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
> -{
> -    float64 ret =3D float64r32_mul(arg1, arg2, &env->fp_status);
> -    int flags =3D get_float_exception_flags(&env->fp_status);
> -
> -    if (unlikely(flags & float_flag_invalid)) {
> -        float_invalid_op_mul(env, flags, 1, GETPC());
> -    }
> -    return ret;
> +#define FPU_MUL(name, op)                                               =
      \
> +float64 helper_##name(CPUPPCState *env, float64 arg1, float64 arg2)     =
      \
> +{                                                                       =
      \
> +    float64 ret =3D op(arg1, arg2, &env->fp_status);                    =
        \
> +    int flags =3D get_float_exception_flags(&env->fp_status);           =
        \
> +                                                                        =
      \
> +    if (unlikely(flags & float_flag_invalid)) {                         =
      \
> +        float_invalid_op_mul(env, flags, 1, GETPC());                   =
      \
> +    }                                                                   =
      \
> +                                                                        =
      \
> +    return ret;                                                         =
      \
>  }
> =20
>  static void float_invalid_op_div(CPUPPCState *env, int flags,
> @@ -587,37 +537,31 @@ static void float_invalid_op_div(CPUPPCState *env, =
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
> +#define FPU_DIV(name, op)                                               =
      \
> +float64 helper_##name(CPUPPCState *env, float64 arg1, float64 arg2)     =
      \
> +{                                                                       =
      \
> +    float64 ret =3D op(arg1, arg2, &env->fp_status);                    =
        \
> +    int flags =3D get_float_exception_flags(&env->fp_status);           =
        \
> +                                                                        =
      \
> +    if (unlikely(flags & float_flag_invalid)) {                         =
      \
> +        float_invalid_op_div(env, flags, 1, GETPC());                   =
      \
> +    }                                                                   =
      \
> +    if (unlikely(flags & float_flag_divbyzero)) {                       =
      \
> +        float_zero_divide_excp(env, GETPC());                           =
      \
> +    }                                                                   =
      \
> +                                                                        =
      \
> +    return ret;                                                         =
      \
>  }
> =20
> -/* fdivs - fdivs. */
> -float64 helper_fdivs(CPUPPCState *env, float64 arg1, float64 arg2)
> -{
> -    float64 ret =3D float64r32_div(arg1, arg2, &env->fp_status);
> -    int flags =3D get_float_exception_flags(&env->fp_status);
> -
> -    if (unlikely(flags & float_flag_invalid)) {
> -        float_invalid_op_div(env, flags, 1, GETPC());
> -    }
> -    if (unlikely(flags & float_flag_divbyzero)) {
> -        float_zero_divide_excp(env, GETPC());
> -    }
> =20
> -    return ret;
> -}
> +FPU_ADD_SUB(FADD, float64_add)
> +FPU_ADD_SUB(FADDS, float64r32_add)
> +FPU_ADD_SUB(FSUB, float64_sub)
> +FPU_ADD_SUB(FSUBS, float64r32_sub)
> +FPU_MUL(FMUL, float64_mul)
> +FPU_MUL(FMULS, float64r32_mul)
> +FPU_DIV(FDIV, float64_div)
> +FPU_DIV(FDIVS, float64r32_div)

Several of the existing macros have slightly different styles and
patterns. FPU_FMADD being one. You're mostly adding an existing style
and being pretty consistent so that's fine. It would be nice if the
others could be made more regular, but maybe not feasible.

There is also quite a bit of duplication in the templates just to
cater to different error handling. I wonder if you could consolidate
it a bit or make it nicer if you passed in the flags handling
function as an argument. Then you could have:


#define FPU_HELPER(name, op, flags_handler)                           \
float64 helper_##name(CPUPPCState *env, float64 arg1, float64 arg2)   \
{                                                                     \
    float64 ret =3D op(arg1, arg2, &env->fp_status);                    \
    int flags =3D get_float_exception_flags(&env->fp_status);           \
    flags_handler(env, flags)                                         \
    return ret;                                                       \
}

static inline void addsub_flags_handler(CPUPPCState *env, int flags)
{
    if (unlikely(flags & float_flag_invalid)) {
        float_invalid_op_addsub(env, flags, 1, GETPC());
    }
}

static inline void mul_flags_handler(CPUPPCState *env, int flags)
{
    if (unlikely(flags & float_flag_invalid)) {
        float_invalid_op_mul(env, flags, 1, GETPC());
    }
}

static inline void div_flags_handler(CPUPPCState *env, int flags)
{
    if (unlikely(flags & float_flag_invalid)) {
        float_invalid_op_div(env, flags, 1, GETPC());
    }
    if (unlikely(flags & float_flag_divbyzero)) {
        float_zero_divide_excp(env, GETPC());
    }
}

FPU_HELPER(FADD, float64_add, addsub_flags_handler);
FPU_HELPER(FADDS, float64r32_add, addsub_flags_handler);
FPU_HELPER(FSUB, float64_sub, addsub_flags_handler);
FPU_HELPER(FSUBS, float64r32_sub, addsub_flags_handler);
FPU_HELPER(FMUL, float64_mul, mul_flags_handler);
FPU_HELPER(FMULS, float64r32_mul, mul_flags_handler);
FPU_HELPER(FDIV, float64_div, div_flags_handler);
FPU_HELPER(FDIVS, float64r32_div, div_flags_handler);

Thoughts?

Thanks,
Nick

