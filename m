Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B51B1C531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 06:38:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seqaY-0003FM-Gb; Fri, 16 Aug 2024 02:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1seqaX-0003Et-3N
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 02:37:29 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1seqaU-0006Li-RU
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 02:37:28 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2ef27bfd15bso20036461fa.2
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 23:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723790244; x=1724395044; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OYXKPjm5UXuaGciCnJ78ftr0XIXJngo+FBC7eVRTHnc=;
 b=NgoRC4gh/oRhVG1k5Uf0aNtopnnA6J3veuHORXqweTeRlA2zINMOv6yIgxE1nKbqDB
 uZM6Eitnhi3+MX6nWqcBfdkoXyxo8VSprGEnE3gLRlnWs9ENCIBYRm9TpKrxVQLNjt46
 x+NwClgwNJvS+B7CXU4otJ+YWPll6QnOG73qxPBgrfeFYquAzBBSUMacy73APn19sLw6
 a/6RmmulSktScjS0uT2YFRQo9LH32e8kH7algjrotkgGimu6IY9S7Ka9iq/tn2T5U1n/
 efjOFnK1taA5deMZZH6yPMr8RIVc1+ID7q4QmkuLaZbmtQQp1S9dGum0ugJIh7LdqBnc
 wB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723790244; x=1724395044;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OYXKPjm5UXuaGciCnJ78ftr0XIXJngo+FBC7eVRTHnc=;
 b=ZApc1q71t0nFOtUFTnRSUemZ37jErQQhc8B0CAFMmukz0DyGu0ukiS1Iiz+lkCgxXV
 P3FXaOllQP2B8QnfTxBpBIPNw8pVrlCgFjsqybRme2DV6hJU3zUdTvnXXo53xmjnl7DC
 mbAidOo2Z89Hy9of/312/b+7dS9TgToQB2wI8jhMD4Cv/XRI6SWffOy/wy/Qa/xoxMMd
 298B9TdRUZp+Qzodm1noMtinLiDtzgaQNX0As3FVBT2jvsQ6FWxGCUCcNmmBMQA6kslU
 vjhBAvSU/FPzX+HnrsWCy5djPs/Zncbm1Lf/WPtxhpFpcVLpwXcjBbp3V9UAE+WuNPHG
 4NyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqMN2aSoGHfNR8MiXAMgVeNvsOqgdg00tLW5YyaEvWZjkRJqLpyuOPFcuTn/Aq+eDBQpRCbVVKAVGtpY4zHdfEszM2rjw=
X-Gm-Message-State: AOJu0YxBiq3j9wi2xERf+J4LJXT3ldvrvEIZoDiBYbmmxTyCXk/mayKw
 e8ds9Q7d2i2XMKQYrWDXNMxeyMleDb4Ob60YIkj0CGkOliJc+k2c5BqXyIoNOEOVp+8xM2T3AXr
 PFJw=
X-Google-Smtp-Source: AGHT+IGukaDDKtQo8YprqhQ2CbDzQMeFWZWo5NGrK/TOg2ZUjVhR5zP+rpM/shnN8MYRRo19YdZLdA==
X-Received: by 2002:a2e:b00d:0:b0:2ef:246e:d04c with SMTP id
 38308e7fff4ca-2f3be5a6bbbmr10343431fa.26.1723790243734; 
 Thu, 15 Aug 2024 23:37:23 -0700 (PDT)
Received: from [192.168.69.100] (cor91-h02-176-184-30-185.dsl.sta.abo.bbox.fr.
 [176.184.30.185]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bebbdfbb4asm1797985a12.52.2024.08.15.23.37.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Aug 2024 23:37:23 -0700 (PDT)
Message-ID: <f2c4d863-1c54-4f28-9215-2d9d55d0de03@linaro.org>
Date: Fri, 16 Aug 2024 08:37:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] target/m68k: Implement packed decimal real stores
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20240812004451.13711-1-richard.henderson@linaro.org>
 <20240812004451.13711-4-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240812004451.13711-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Richard,

On 12/8/24 02:44, Richard Henderson wrote:
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2488
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/m68k/helper.h     |   1 +
>   target/m68k/fpu_helper.c | 112 +++++++++++++++++++++++++++++++++++++++
>   target/m68k/translate.c  |  27 ++++++++--
>   3 files changed, 137 insertions(+), 3 deletions(-)
> 
> diff --git a/target/m68k/helper.h b/target/m68k/helper.h
> index 2c71361451..21af6adb39 100644
> --- a/target/m68k/helper.h
> +++ b/target/m68k/helper.h
> @@ -127,6 +127,7 @@ DEF_HELPER_3(chk, void, env, s32, s32)
>   DEF_HELPER_4(chk2, void, env, s32, s32, s32)
>   
>   DEF_HELPER_FLAGS_3(load_pdr_to_fx80, TCG_CALL_NO_RWG, void, env, fp, tl)
> +DEF_HELPER_FLAGS_4(store_fx80_to_pdr, TCG_CALL_NO_RWG, void, env, tl, fp, int)
>   
>   #if !defined(CONFIG_USER_ONLY)
>   DEF_HELPER_3(ptest, void, env, i32, i32)
> diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
> index 50b0e36cbe..0c9c3b7b64 100644
> --- a/target/m68k/fpu_helper.c
> +++ b/target/m68k/fpu_helper.c
> @@ -750,6 +750,29 @@ void HELPER(fcosh)(CPUM68KState *env, FPReg *res, FPReg *val)
>       res->d = floatx80_cosh(val->d, &env->fp_status);
>   }
>   
> +/* 10**0 through 10**18 */
> +static const int64_t i64_pow10[] = {
> +    1ll,
> +    10ll,
> +    100ll,
> +    1000ll,
> +    10000ll,
> +    100000ll,
> +    1000000ll,
> +    10000000ll,
> +    100000000ll,
> +    1000000000ll,
> +    10000000000ll,
> +    100000000000ll,
> +    1000000000000ll,
> +    10000000000000ll,
> +    100000000000000ll,
> +    1000000000000000ll,
> +    10000000000000000ll,
> +    100000000000000000ll,
> +    1000000000000000000ll,

10**18 is never used, is that expected?

Could we define KFACTOR_MAX = 17 and use it as
array size?

> +};
> +
>   static const floatx80 floatx80_pow10[] = {
>   #include "floatx80-pow10.c.inc"
>   };
> @@ -838,3 +861,92 @@ void HELPER(load_pdr_to_fx80)(CPUM68KState *env, FPReg *res, target_ulong addr)
>       t = int64_to_floatx80(mant, &env->fp_status),
>       res->d = floatx80_scale10i(t, exp, &env->fp_status);
>   }
> +
> +void HELPER(store_fx80_to_pdr)(CPUM68KState *env, target_ulong addr,
> +                               FPReg *srcp, int kfactor)
> +{
> +    floatx80 x = srcp->d;
> +    int len, exp2, exp10;
> +    uint64_t res_lo;
> +    uint32_t res_hi;
> +    int64_t y;
> +
> +    res_lo = x.low;
> +    exp2 = x.high & 0x7fff;
> +    if (unlikely(exp2 == 0x7fff)) {
> +        /* NaN and Inf */
> +        res_hi = (uint32_t)x.high << 16;
> +        goto done;
> +    }
> +
> +    /* Copy the sign bit to the output, and then x = abs(x). */
> +    res_hi = (x.high & 0x8000u) << 16;
> +    x.high &= 0x7fff;
> +
> +    if (exp2 == 0) {
> +        if (res_lo == 0) {
> +            /* +/- 0 */
> +            goto done;
> +        }
> +        /* denormal */
> +        exp2 = -0x3fff - clz64(res_lo);
> +    } else {
> +        exp2 -= 0x3fff;
> +    }
> +
> +    /*
> +     * Begin with an approximation of log2(x) via the base 2 exponent.
> +     * Adjust, so that we compute the value scaled by 10**17, which will
> +     * allows an integer to be extracted to match the output digits.
> +     */
> +    exp10 = (exp2 * 30102) / 100000;
> +    while (1) {
> +        floatx80 t;
> +
> +        /* kfactor controls the number of output digits */
> +        if (kfactor <= 0) {
> +            /* kfactor is number of digits right of the decimal point. */
> +            len = exp10 - kfactor;
> +        } else {
> +            /* kfactor is number of significant digits */
> +            len = kfactor;
> +        }
> +        len = MIN(MAX(len, 1), 17);
> +
> +        /*
> +         * Scale, so that we have the requested number of digits
> +         * left of the decimal point.  Convert to integer, which
> +         * handles the rounding (and may force adjustment of exp10).
> +         */
> +        t = floatx80_scale10i(x, len - 1 - exp10, &env->fp_status);
> +        y = floatx80_to_int64(t, &env->fp_status);
> +        if (y < i64_pow10[len - 1]) {
> +            exp10--;
> +        } else if (y < i64_pow10[len]) {
> +            break;
> +        } else {
> +            exp10++;
> +        }
> +    }
> +
> +    /* Output the mantissa. */
> +    res_hi |= y / i64_pow10[len - 1];
> +    res_lo = 0;
> +    for (int i = 1; i < len; ++i) {
> +        int64_t d = (y / i64_pow10[len - 1 - i]) % 10;
> +        res_lo |= d << (64 - i * 4);
> +    }
> +
> +    /* Output the exponent. */
> +    if (exp10 < 0) {
> +        res_hi |= 0x40000000;
> +        exp10 = -exp10;
> +    }
> +    for (int i = 24; exp10; i -= 4, exp10 /= 10) {
> +        res_hi |= (exp10 % 10) << i;
> +    }
> +
> + done:
> +    cpu_stl_be_data_ra(env, addr, res_hi, GETPC());
> +    cpu_stq_be_data_ra(env, addr + 4, res_lo, GETPC());
> +}
> diff --git a/target/m68k/translate.c b/target/m68k/translate.c
> index 59e7d27393..fb5ecce0c3 100644
> --- a/target/m68k/translate.c
> +++ b/target/m68k/translate.c
> @@ -119,6 +119,8 @@ typedef struct DisasContext {
>       int done_mac;
>       int writeback_mask;
>       TCGv writeback[8];
> +    uint16_t insn;
> +    uint16_t ext;

Maybe worth commenting here what this field is used for?

>       bool ss_active;
>   } DisasContext;
>   
> @@ -671,6 +673,7 @@ static inline int ext_opsize(int ext, int pos)
>       case 4: return OS_WORD;
>       case 5: return OS_DOUBLE;
>       case 6: return OS_BYTE;
> +    case 7: return OS_PACKED; /* store, dynamic k-factor */
>       default:
>           g_assert_not_reached();
>       }
> @@ -1010,11 +1013,25 @@ static void gen_store_fp(DisasContext *s, int opsize, TCGv addr, TCGv_ptr fp,
>           tcg_gen_qemu_st_i64(t64, tmp, index, MO_TEUQ);
>           break;
>       case OS_PACKED:
> +        if (!m68k_feature(s->env, M68K_FEATURE_FPU_PACKED_DECIMAL)) {
> +            gen_exception(s, s->base.pc_next, EXCP_FP_UNIMP);
> +            break;
> +        }
>           /*
> -         * unimplemented data type on 68040/ColdFire
> -         * FIXME if needed for another FPU
> +         * For stores we must recover k-factor, either from an
> +         * immediate or the low 7 bits of a D register.
>            */
> -        gen_exception(s, s->base.pc_next, EXCP_FP_UNIMP);
> +        switch ((s->ext >> 10) & 7) {
> +        case 3:
> +            tcg_gen_movi_i32(tmp, sextract32(s->ext, 0, 7));
> +            break;
> +        case 7:
> +            tcg_gen_sextract_i32(tmp, DREG(s->ext, 4), 0, 7);
> +            break;
> +        default:
> +            g_assert_not_reached();
> +        }
> +        gen_helper_store_fx80_to_pdr(tcg_env, addr, fp, tmp);
>           break;
>       default:
>           g_assert_not_reached();
> @@ -4940,6 +4957,8 @@ DISAS_INSN(fpu)
>       TCGv_ptr cpu_src, cpu_dest;
>   
>       ext = read_im16(env, s);
> +    s->ext = ext;
> +
>       opmode = ext & 0x7f;
>       switch ((ext >> 13) & 7) {
>       case 0:
> @@ -6042,6 +6061,8 @@ static void m68k_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
>       CPUM68KState *env = cpu_env(cpu);
>       uint16_t insn = read_im16(env, dc);
>   
> +    dc->insn = insn;
> +    dc->ext = 0;
>       opcode_table[insn](env, dc, insn);
>       do_writebacks(dc);
>   

Otherwise patch LGTM.

