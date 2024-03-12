Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7191DC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 14:02:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk2hG-00009l-1G; Tue, 12 Mar 2024 10:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rk2gy-00005N-8i
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:01:27 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rk2gv-0008Ku-QV
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:01:20 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1dd81aee2b4so29288755ad.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 07:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710252076; x=1710856876; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UXrzOUK7SCW5glR9/buYN1mR79SnPFprWQqXnJXsOs4=;
 b=Jx2H0Oe8l6EARaRBrZQuJvg8jxiJCegwq7xXyqcvPa6LUGh6yemo8nu8Cw2mMGPR4T
 bCAgDdpVGTWBt7zZSu2siqC7kOS0/r6gdkNPS9l723FJseBRel0+lkR8fQ6NFktgfz2F
 HFryrlmRy9Vn/KDRNUyE/iZcdKSmwBJ9VOms6Y9WwpE/nAQr++avX4eUNBn6clbLLuJu
 9dkSrjjsJ6O15WgrWZ74k3f2id8uhA0f+CZIL33N+DYLDWa0iVBXoEdIGhsJhxzHursB
 jMdfZa3HSexvWNOqV6ZSXGyOmSuc675lVw4Kl/dDPd7XzegpgqIqXQfuSDBvUeNLyjwJ
 r/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710252076; x=1710856876;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UXrzOUK7SCW5glR9/buYN1mR79SnPFprWQqXnJXsOs4=;
 b=ZBCWlvdJGa7Pl2iU7WPtUm661AU1y5wJOmCT5aFOeMPyPGvLh//xe1hfJo+bGNXBUL
 xsiI6wposmu+iSsJWjIEi1mIJ9L6gp3bjYWofCN9N05htPP3mHfP1ijftI8hrtB9BXiD
 5sRYqjdrS2mh5V8ErzV6kSdeAOCHoT8b7arapdfhaXWzgprZBUdA2pcv56ukdjPPX0xK
 guwdC9JjP4Di7gVwFtTT1tY4WBPhwM0oe0Kj7XYyMtdsyzhop9QiUZ6C3SWabPgzRQKb
 poFxdhWFab28RgeFTyfnul9GiAFBeV/fYam3M194JPlIz548ukHIbvdzUfCN9AHboYDG
 Lsqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUQtDqy+vBsQBLFP9RcXaZ4igKYCqHgwJbOTMxWKrIBxL8ULIcQhN/RAZgnOeP6dFOh+Osaf4fhIoDpaLvedhiJX57/qw=
X-Gm-Message-State: AOJu0YyzswFAKaoSzuwdkS+5C6A0B+cSMjg4WFtZXQJZMtNhL84aF2qk
 2QKrbYrF6mJUXrfnaZ9RM0FJS6Ib1KhXK3tv0N2TwSM5WyO6uYiDYU+ua2FGWP7RIykK6hQW+/b
 7
X-Google-Smtp-Source: AGHT+IF1pcXpvkxp0RnqbJAJQgIntGwTQjFMdPVfFTL0lBhTPBpQZN2tsCCLn6XW2OJ3rwjhC2pFXQ==
X-Received: by 2002:a17:90a:488f:b0:29b:ce33:492d with SMTP id
 b15-20020a17090a488f00b0029bce33492dmr7372236pjh.22.1710252074166; 
 Tue, 12 Mar 2024 07:01:14 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 lx11-20020a17090b4b0b00b0029c472ec962sm884683pjb.47.2024.03.12.07.01.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 07:01:13 -0700 (PDT)
Message-ID: <0c7c6be1-12fb-4267-9d41-bd51637d104a@linaro.org>
Date: Tue, 12 Mar 2024 04:01:07 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/ppc: Move floating-point arithmetic instructions
 to decodetree.
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: danielhb413@gmail.com, clg@kaod.org, harshpb@linux.ibm.com,
 sbhat@linux.ibm.com
References: <20240307110318.170319-1-rathc@linux.ibm.com>
 <CZRO4Y67CBPV.2IAKB80EFDKEY@wheely>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CZRO4Y67CBPV.2IAKB80EFDKEY@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 3/11/24 23:36, Nicholas Piggin wrote:
> On Thu Mar 7, 2024 at 9:03 PM AEST, Chinmay Rath wrote:
>> This patch moves the below instructions to decodetree specification :
>>
>>      f{add, sub, mul, div, re, rsqrte, madd, msub, nmadd, nmsub}[s][.] : A-form
>>      ft{div, sqrt}                                                     : X-form
>>
>> With this patch, all the floating-point arithmetic instructions have been
>> moved to decodetree.
>> The patch also merges the definitions of different sets of helper methods of
>> the above instructions, which are similar, using macros.
>> The changes were verified by validating that the tcg ops generated by those
>> instructions remain the same, which were captured with the '-d in_asm,op' flag.
>>
>> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> 
> Hi Chinmay,
> 
> Nice patch. I think the fpu_helper.c change should be done separately.
> 
>> diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
>> index 4b3dcad5d1..a3fcfb3907 100644
>> --- a/target/ppc/fpu_helper.c
>> +++ b/target/ppc/fpu_helper.c
>> @@ -490,54 +490,16 @@ static void float_invalid_op_addsub(CPUPPCState *env, int flags,
>>       }
>>   }
>>   
>> -/* fadd - fadd. */
>> -float64 helper_fadd(CPUPPCState *env, float64 arg1, float64 arg2)
>> -{
>> -    float64 ret = float64_add(arg1, arg2, &env->fp_status);
>> -    int flags = get_float_exception_flags(&env->fp_status);
>> -
>> -    if (unlikely(flags & float_flag_invalid)) {
>> -        float_invalid_op_addsub(env, flags, 1, GETPC());
>> -    }
>> -
>> -    return ret;
>> -}
>> -
>> -/* fadds - fadds. */
>> -float64 helper_fadds(CPUPPCState *env, float64 arg1, float64 arg2)
>> -{
>> -    float64 ret = float64r32_add(arg1, arg2, &env->fp_status);
>> -    int flags = get_float_exception_flags(&env->fp_status);
>> -
>> -    if (unlikely(flags & float_flag_invalid)) {
>> -        float_invalid_op_addsub(env, flags, 1, GETPC());
>> -    }
>> -    return ret;
>> -}
>> -
>> -/* fsub - fsub. */
>> -float64 helper_fsub(CPUPPCState *env, float64 arg1, float64 arg2)
>> -{
>> -    float64 ret = float64_sub(arg1, arg2, &env->fp_status);
>> -    int flags = get_float_exception_flags(&env->fp_status);
>> -
>> -    if (unlikely(flags & float_flag_invalid)) {
>> -        float_invalid_op_addsub(env, flags, 1, GETPC());
>> -    }
>> -
>> -    return ret;
>> -}
>> -
>> -/* fsubs - fsubs. */
>> -float64 helper_fsubs(CPUPPCState *env, float64 arg1, float64 arg2)
>> -{
>> -    float64 ret = float64r32_sub(arg1, arg2, &env->fp_status);
>> -    int flags = get_float_exception_flags(&env->fp_status);
>> -
>> -    if (unlikely(flags & float_flag_invalid)) {
>> -        float_invalid_op_addsub(env, flags, 1, GETPC());
>> -    }
>> -    return ret;
>> +#define FPU_ADD_SUB(name, op)                                                 \
>> +float64 helper_##name(CPUPPCState *env, float64 arg1, float64 arg2)           \
>> +{                                                                             \
>> +    float64 ret = op(arg1, arg2, &env->fp_status);                            \
>> +    int flags = get_float_exception_flags(&env->fp_status);                   \
>> +                                                                              \
>> +    if (unlikely(flags & float_flag_invalid)) {                               \
>> +        float_invalid_op_addsub(env, flags, 1, GETPC());                      \
>> +    }                                                                         \
>> +    return ret;                                                               \
>>   }
>>   
>>   static void float_invalid_op_mul(CPUPPCState *env, int flags,
>> @@ -550,29 +512,17 @@ static void float_invalid_op_mul(CPUPPCState *env, int flags,
>>       }
>>   }
>>   
>> -/* fmul - fmul. */
>> -float64 helper_fmul(CPUPPCState *env, float64 arg1, float64 arg2)
>> -{
>> -    float64 ret = float64_mul(arg1, arg2, &env->fp_status);
>> -    int flags = get_float_exception_flags(&env->fp_status);
>> -
>> -    if (unlikely(flags & float_flag_invalid)) {
>> -        float_invalid_op_mul(env, flags, 1, GETPC());
>> -    }
>> -
>> -    return ret;
>> -}
>> -
>> -/* fmuls - fmuls. */
>> -float64 helper_fmuls(CPUPPCState *env, float64 arg1, float64 arg2)
>> -{
>> -    float64 ret = float64r32_mul(arg1, arg2, &env->fp_status);
>> -    int flags = get_float_exception_flags(&env->fp_status);
>> -
>> -    if (unlikely(flags & float_flag_invalid)) {
>> -        float_invalid_op_mul(env, flags, 1, GETPC());
>> -    }
>> -    return ret;
>> +#define FPU_MUL(name, op)                                                     \
>> +float64 helper_##name(CPUPPCState *env, float64 arg1, float64 arg2)           \
>> +{                                                                             \
>> +    float64 ret = op(arg1, arg2, &env->fp_status);                            \
>> +    int flags = get_float_exception_flags(&env->fp_status);                   \
>> +                                                                              \
>> +    if (unlikely(flags & float_flag_invalid)) {                               \
>> +        float_invalid_op_mul(env, flags, 1, GETPC());                         \
>> +    }                                                                         \
>> +                                                                              \
>> +    return ret;                                                               \
>>   }
>>   
>>   static void float_invalid_op_div(CPUPPCState *env, int flags,
>> @@ -587,37 +537,31 @@ static void float_invalid_op_div(CPUPPCState *env, int flags,
>>       }
>>   }
>>   
>> -/* fdiv - fdiv. */
>> -float64 helper_fdiv(CPUPPCState *env, float64 arg1, float64 arg2)
>> -{
>> -    float64 ret = float64_div(arg1, arg2, &env->fp_status);
>> -    int flags = get_float_exception_flags(&env->fp_status);
>> -
>> -    if (unlikely(flags & float_flag_invalid)) {
>> -        float_invalid_op_div(env, flags, 1, GETPC());
>> -    }
>> -    if (unlikely(flags & float_flag_divbyzero)) {
>> -        float_zero_divide_excp(env, GETPC());
>> -    }
>> -
>> -    return ret;
>> +#define FPU_DIV(name, op)                                                     \
>> +float64 helper_##name(CPUPPCState *env, float64 arg1, float64 arg2)           \
>> +{                                                                             \
>> +    float64 ret = op(arg1, arg2, &env->fp_status);                            \
>> +    int flags = get_float_exception_flags(&env->fp_status);                   \
>> +                                                                              \
>> +    if (unlikely(flags & float_flag_invalid)) {                               \
>> +        float_invalid_op_div(env, flags, 1, GETPC());                         \
>> +    }                                                                         \
>> +    if (unlikely(flags & float_flag_divbyzero)) {                             \
>> +        float_zero_divide_excp(env, GETPC());                                 \
>> +    }                                                                         \
>> +                                                                              \
>> +    return ret;                                                               \
>>   }
>>   
>> -/* fdivs - fdivs. */
>> -float64 helper_fdivs(CPUPPCState *env, float64 arg1, float64 arg2)
>> -{
>> -    float64 ret = float64r32_div(arg1, arg2, &env->fp_status);
>> -    int flags = get_float_exception_flags(&env->fp_status);
>> -
>> -    if (unlikely(flags & float_flag_invalid)) {
>> -        float_invalid_op_div(env, flags, 1, GETPC());
>> -    }
>> -    if (unlikely(flags & float_flag_divbyzero)) {
>> -        float_zero_divide_excp(env, GETPC());
>> -    }
>>   
>> -    return ret;
>> -}
>> +FPU_ADD_SUB(FADD, float64_add)
>> +FPU_ADD_SUB(FADDS, float64r32_add)
>> +FPU_ADD_SUB(FSUB, float64_sub)
>> +FPU_ADD_SUB(FSUBS, float64r32_sub)
>> +FPU_MUL(FMUL, float64_mul)
>> +FPU_MUL(FMULS, float64r32_mul)
>> +FPU_DIV(FDIV, float64_div)
>> +FPU_DIV(FDIVS, float64r32_div)
> 
> Several of the existing macros have slightly different styles and
> patterns. FPU_FMADD being one. You're mostly adding an existing style
> and being pretty consistent so that's fine. It would be nice if the
> others could be made more regular, but maybe not feasible.
> 
> There is also quite a bit of duplication in the templates just to
> cater to different error handling. I wonder if you could consolidate
> it a bit or make it nicer if you passed in the flags handling
> function as an argument. Then you could have:
> 
> 
> #define FPU_HELPER(name, op, flags_handler)                           \
> float64 helper_##name(CPUPPCState *env, float64 arg1, float64 arg2)   \
> {                                                                     \
>      float64 ret = op(arg1, arg2, &env->fp_status);                    \
>      int flags = get_float_exception_flags(&env->fp_status);           \
>      flags_handler(env, flags)                                         \
>      return ret;                                                       \
> }
> 
> static inline void addsub_flags_handler(CPUPPCState *env, int flags)
> {
>      if (unlikely(flags & float_flag_invalid)) {
>          float_invalid_op_addsub(env, flags, 1, GETPC());
>      }
> }
> 
> static inline void mul_flags_handler(CPUPPCState *env, int flags)
> {
>      if (unlikely(flags & float_flag_invalid)) {
>          float_invalid_op_mul(env, flags, 1, GETPC());
>      }
> }
> 
> static inline void div_flags_handler(CPUPPCState *env, int flags)
> {
>      if (unlikely(flags & float_flag_invalid)) {
>          float_invalid_op_div(env, flags, 1, GETPC());
>      }
>      if (unlikely(flags & float_flag_divbyzero)) {
>          float_zero_divide_excp(env, GETPC());
>      }
> }

Beware -- GETPC() may only be called from the outermost helper.


r~

