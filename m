Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D9CAC369C4
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 19:20:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u58J8-0000Sh-Ns; Wed, 16 Apr 2025 15:20:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u58J5-0000Rv-QY
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 15:20:23 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u58J2-0006s6-UX
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 15:20:23 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22c33677183so383405ad.2
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 12:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744831219; x=1745436019; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9uiOYiJ3slcT5mHxcUGQ7mnx9Q3QvgbvjzruPIeJurs=;
 b=YVr6nEexI+Nu8wzuStjTXOOk0XgSxPBSvxa0LkSqG8teVLQWyWU6hKEi1ITAO2Bfg1
 fMqRhDOnH7n85n+7saF8J706DkzdptUFw+DG6H+0WSWEB0MYezo4+Ozl1X/4Etg6wv3a
 aAAxS7oP6VeNleDzVSwBVwbsTSzsiHKvAVU2QRM8iYt95P+41X9ougvj5WaXivFc99z+
 7LP3ffzetEVW85+Uqr/2Y2upiLkqTKedd2SLFlqYzOnv+/h02mk432hugZu9gsjTrIX3
 mDKNfk/P+evNfLJmpmlGNjwLX83dTf++ZhO+lpZ7qI7sWP9DMkBxGJlVcnDz/+Qgsyru
 oH9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744831219; x=1745436019;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9uiOYiJ3slcT5mHxcUGQ7mnx9Q3QvgbvjzruPIeJurs=;
 b=G5DWzgmCuCbLBqY1NA9XQaslrCnBIPa3NEPX6m+6dwHmtagJeYxbNkt/rNElQNNejG
 ZlZQVrTDRcCOQHCjAznZdMod3yVHoGxNO7UTuDTGqqTE4lo5rEF5kbPVcVVGNRhgvKpq
 1RpZjYI/2VYt0lY5FPqYtUD6N1lGRrIVWHzuocu3wr3h0ZQfYT9MuwR3MUiwTEf/uCGR
 iqKLkqN28BDuqJpVLXQnTPG63ajcQRM5zl12xdOcZEcACxQJnHuymOO9Hi0xQQR336y5
 fK5mAlzniCp1S3e4gOXAQuZ2aKSBzyfUiplP4rpP3v/5nQiUxL2OAhAhknMHghHcoWSS
 HHUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNBTPZqxLkj6JFtbdZxkC2LFZYUflWjpk1EPrBveD5Njj8Rp8U4aM8cfZa8xoCb7EBF88nnUxPThva@nongnu.org
X-Gm-Message-State: AOJu0YyGt4HUfbxl7sjrO+Qt5eHWDJGfC4j76fzaBklXCL+Ki6hqDAgA
 jP6Oruwtc3XFVAy9RRh5ci3dY7Nosr8I7frHZy3J4opSNX0JUbiBatPndzvsI2k=
X-Gm-Gg: ASbGncugja6GIitYEQ1V63vJst8Gcg7e2KB+f5IsR9fVEyVRvX0mYzr550GOPANB+v+
 RlqxZCvfxrzEbRofE51k41OBG3Qt1uEKYCxeBArPIfv/5K74FdtL3AjHrtCQhvHpz8iBo/kQL47
 kOZL+AKZdP+XmB0jKAcUUqE9fKaH9qeXPD7b29hNxCJAKI8OfobAHhbPjKrdunETlMkxHu/+1es
 G4A1J+iUu/Zb1X1qq2yNSccxg14pzfAYMA004epCLasH5ND2bH8u3snjEVxYOXKOpdOlUCKdrRs
 9D/MUT4EOdRKD6K0U+ALkpqp9oK5FsWGmKOJ3z1qal9zBkmiNOwb0w==
X-Google-Smtp-Source: AGHT+IF9kByt2z6DTPK0vWM1r3zHqYwqqOw/tcI9tBab31MIBH6hV7ZNP/lmaN+ZJewKw6ZYi5PRVA==
X-Received: by 2002:a17:903:3c65:b0:224:255b:c932 with SMTP id
 d9443c01a7336-22c358c3f5emr48812085ad.3.1744831219181; 
 Wed, 16 Apr 2025 12:20:19 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c33f1cf9dsm18221385ad.75.2025.04.16.12.20.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 12:20:18 -0700 (PDT)
Message-ID: <957b58d5-6606-4851-84a7-64b214cf7311@linaro.org>
Date: Wed, 16 Apr 2025 12:20:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 146/163] tcg/sparc64: Remove support for add2/sub2
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-147-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-147-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 4/15/25 12:24, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/sparc64/tcg-target-con-set.h |   6 +-
>   tcg/sparc64/tcg-target-has.h     |   8 +-
>   tcg/sparc64/tcg-target.c.inc     | 169 +++----------------------------
>   3 files changed, 19 insertions(+), 164 deletions(-)
> 
> diff --git a/tcg/sparc64/tcg-target-con-set.h b/tcg/sparc64/tcg-target-con-set.h
> index 37cb190450..1a57adc0e8 100644
> --- a/tcg/sparc64/tcg-target-con-set.h
> +++ b/tcg/sparc64/tcg-target-con-set.h
> @@ -15,9 +15,7 @@ C_O0_I2(r, rJ)
>   C_O1_I1(r, r)
>   C_O1_I2(r, r, r)
>   C_O1_I2(r, r, rJ)
> -C_O1_I2(r, r, rZ)
> -C_O1_I2(r, rZ, rJ)
> -C_O1_I2(r, rZ, rZ)
> +C_O1_I2(r, rz, rJ)
> +C_O1_I2(r, rz, rz)
>   C_O1_I4(r, r, rJ, rI, 0)
>   C_O2_I2(r, r, r, r)
> -C_O2_I4(r, r, rz, rz, rJ, rJ)
> diff --git a/tcg/sparc64/tcg-target-has.h b/tcg/sparc64/tcg-target-has.h
> index b8760dd154..caf7679595 100644
> --- a/tcg/sparc64/tcg-target-has.h
> +++ b/tcg/sparc64/tcg-target-has.h
> @@ -14,13 +14,13 @@ extern bool use_vis3_instructions;
>   #endif
>   
>   /* optional instructions */
> -#define TCG_TARGET_HAS_add2_i32         1
> -#define TCG_TARGET_HAS_sub2_i32         1
> +#define TCG_TARGET_HAS_add2_i32         0
> +#define TCG_TARGET_HAS_sub2_i32         0
>   #define TCG_TARGET_HAS_qemu_st8_i32     0
>   
>   #define TCG_TARGET_HAS_extr_i64_i32     0
> -#define TCG_TARGET_HAS_add2_i64         1
> -#define TCG_TARGET_HAS_sub2_i64         1
> +#define TCG_TARGET_HAS_add2_i64         0
> +#define TCG_TARGET_HAS_sub2_i64         0
>   
>   #define TCG_TARGET_HAS_qemu_ldst_i128   0
>   
> diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
> index 93bb88b05f..842ef68c54 100644
> --- a/tcg/sparc64/tcg-target.c.inc
> +++ b/tcg/sparc64/tcg-target.c.inc
> @@ -919,74 +919,6 @@ static const TCGOutOpMovcond outop_movcond = {
>       .out = tgen_movcond,
>   };
>   
> -static void tcg_out_addsub2_i32(TCGContext *s, TCGReg rl, TCGReg rh,
> -                                TCGReg al, TCGReg ah, int32_t bl, int blconst,
> -                                int32_t bh, int bhconst, int opl, int oph)
> -{
> -    TCGReg tmp = TCG_REG_T1;
> -
> -    /* Note that the low parts are fully consumed before tmp is set.  */
> -    if (rl != ah && (bhconst || rl != bh)) {
> -        tmp = rl;
> -    }
> -
> -    tcg_out_arithc(s, tmp, al, bl, blconst, opl);
> -    tcg_out_arithc(s, rh, ah, bh, bhconst, oph);
> -    tcg_out_mov(s, TCG_TYPE_I32, rl, tmp);
> -}
> -
> -static void tcg_out_addsub2_i64(TCGContext *s, TCGReg rl, TCGReg rh,
> -                                TCGReg al, TCGReg ah, int32_t bl, int blconst,
> -                                int32_t bh, int bhconst, bool is_sub)
> -{
> -    TCGReg tmp = TCG_REG_T1;
> -
> -    /* Note that the low parts are fully consumed before tmp is set.  */
> -    if (rl != ah && (bhconst || rl != bh)) {
> -        tmp = rl;
> -    }
> -
> -    tcg_out_arithc(s, tmp, al, bl, blconst, is_sub ? ARITH_SUBCC : ARITH_ADDCC);
> -
> -    if (use_vis3_instructions && !is_sub) {
> -        /* Note that ADDXC doesn't accept immediates.  */
> -        if (bhconst && bh != 0) {
> -           tcg_out_movi_s13(s, TCG_REG_T2, bh);
> -           bh = TCG_REG_T2;
> -        }
> -        tcg_out_arith(s, rh, ah, bh, ARITH_ADDXC);
> -    } else if (bh == TCG_REG_G0) {
> -	/* If we have a zero, we can perform the operation in two insns,
> -           with the arithmetic first, and a conditional move into place.  */
> -	if (rh == ah) {
> -            tcg_out_arithi(s, TCG_REG_T2, ah, 1,
> -			   is_sub ? ARITH_SUB : ARITH_ADD);
> -            tcg_out_movcc(s, COND_CS, MOVCC_XCC, rh, TCG_REG_T2, 0);
> -	} else {
> -            tcg_out_arithi(s, rh, ah, 1, is_sub ? ARITH_SUB : ARITH_ADD);
> -	    tcg_out_movcc(s, COND_CC, MOVCC_XCC, rh, ah, 0);
> -	}
> -    } else {
> -        /*
> -         * Otherwise adjust BH as if there is carry into T2.
> -         * Note that constant BH is constrained to 11 bits for the MOVCC,
> -         * so the adjustment fits 12 bits.
> -         */
> -        if (bhconst) {
> -            tcg_out_movi_s13(s, TCG_REG_T2, bh + (is_sub ? -1 : 1));
> -        } else {
> -            tcg_out_arithi(s, TCG_REG_T2, bh, 1,
> -                           is_sub ? ARITH_SUB : ARITH_ADD);
> -        }
> -        /* ... smoosh T2 back to original BH if carry is clear ... */
> -        tcg_out_movcc(s, COND_CC, MOVCC_XCC, TCG_REG_T2, bh, bhconst);
> -	/* ... and finally perform the arithmetic with the new operand.  */
> -        tcg_out_arith(s, rh, ah, TCG_REG_T2, is_sub ? ARITH_SUB : ARITH_ADD);
> -    }
> -
> -    tcg_out_mov(s, TCG_TYPE_I64, rl, tmp);
> -}
> -
>   static void tcg_out_jmpl_const(TCGContext *s, const tcg_insn_unit *dest,
>                                  bool in_prologue, bool tail_call)
>   {
> @@ -1424,10 +1356,10 @@ static void tgen_addci_rri(TCGContext *s, TCGType type,
>   {
>       if (type == TCG_TYPE_I32) {
>           tcg_out_arithi(s, a0, a1, a2, ARITH_ADDC);
> -    } else if (use_vis3_instructions) {
> -        tcg_debug_assert(a2 == 0);
> -        tcg_out_arith(s, a0, a1, TCG_REG_G0, ARITH_ADDXC);
> -    } else if (a2 != 0) {
> +        return;
> +    }
> +    /* !use_vis3_instructions */
> +    if (a2 != 0) {
>           tcg_out_arithi(s, TCG_REG_T1, a1, a2, ARITH_ADD); /* for CC */
>           tcg_out_arithi(s, a0, TCG_REG_T1, 1, ARITH_ADD);  /* for CS */
>           tcg_out_movcc(s, COND_CC, MOVCC_XCC, a0, TCG_REG_T1, false);
> @@ -1440,25 +1372,13 @@ static void tgen_addci_rri(TCGContext *s, TCGType type,
>       }
>   }
>   
> -static void tgen_addci_rir(TCGContext *s, TCGType type,
> -                           TCGReg a0, tcg_target_long a1, TCGReg a2)
> -{
> -    tgen_addci_rri(s, type, a0, a2, a1);
> -}
> -
> -static void tgen_addci_rii(TCGContext *s, TCGType type,
> -                           TCGReg a0, tcg_target_long a1, tcg_target_long a2)
> -{
> -    tgen_addci_rri(s, type, a0, TCG_REG_G0, a2);
> -}
> -
>   static TCGConstraintSetIndex cset_addci(TCGType type, unsigned flags)
>   {
>       if (use_vis3_instructions && type == TCG_TYPE_I64) {
>           /* Note that ADDXC doesn't accept immediates.  */
> -        return C_O1_I2(r, rZ, rZ);
> +        return C_O1_I2(r, rz, rz);
>       }
> -    return C_O1_I2(r, rZ, rJ);
> +    return C_O1_I2(r, rz, rJ);
>   }
>   
>   static const TCGOutOpAddSubCarry outop_addci = {
> @@ -1466,8 +1386,6 @@ static const TCGOutOpAddSubCarry outop_addci = {
>       .base.dynamic_constraint = cset_addci,
>       .out_rrr = tgen_addci_rrr,
>       .out_rri = tgen_addci_rri,
> -    .out_rir = tgen_addci_rir,
> -    .out_rii = tgen_addci_rii,
>   };
>   
>   /* Copy %xcc.c to %icc.c */
> @@ -1487,10 +1405,7 @@ static void tgen_addcio_rrr(TCGContext *s, TCGType type,
>                               TCGReg a0, TCGReg a1, TCGReg a2)
>   {
>       if (type != TCG_TYPE_I32) {
> -        if (use_vis3_instructions) {
> -            tcg_out_arith(s, a0, a1, a2, ARITH_ADDXCCC);
> -            return;
> -        }
> +        /* !use_vis3_instructions */
>           tcg_out_dup_xcc_c(s);
>       }
>       tcg_out_arith(s, a0, a1, a2, ARITH_ADDCCC);
> @@ -1500,11 +1415,7 @@ static void tgen_addcio_rri(TCGContext *s, TCGType type,
>                               TCGReg a0, TCGReg a1, tcg_target_long a2)
>   {
>       if (type != TCG_TYPE_I32) {
> -        if (use_vis3_instructions) {
> -            tcg_debug_assert(a2 == 0);
> -            tcg_out_arith(s, a0, a1, TCG_REG_G0, ARITH_ADDXCCC);
> -            return;
> -        }
> +        /* !use_vis3_instructions */
>           tcg_out_dup_xcc_c(s);
>       }
>       tcg_out_arithi(s, a0, a1, a2, ARITH_ADDCCC);
> @@ -1514,9 +1425,9 @@ static TCGConstraintSetIndex cset_addcio(TCGType type, unsigned flags)
>   {
>       if (use_vis3_instructions && type == TCG_TYPE_I64) {
>           /* Note that ADDXC doesn't accept immediates.  */
> -        return C_O1_I2(r, r, rZ);
> +        return C_O1_I2(r, rz, rz);
>       }
> -    return C_O1_I2(r, r, rJ);
> +    return C_O1_I2(r, rz, rJ);
>   }
>   
>   static const TCGOutOpBinary outop_addcio = {
> @@ -1881,7 +1792,7 @@ static void tgen_subbo_rri(TCGContext *s, TCGType type,
>   }
>   
>   static const TCGOutOpAddSubCarry outop_subbo = {
> -    .base.static_constraint = C_O1_I2(r, r, rJ),
> +    .base.static_constraint = C_O1_I2(r, rz, rJ),
>       .out_rrr = tgen_subbo_rrr,
>       .out_rri = tgen_subbo_rri,
>   };
> @@ -1917,24 +1828,10 @@ static void tgen_subbi_rri(TCGContext *s, TCGType type,
>       }
>   }
>   
> -static void tgen_subbi_rir(TCGContext *s, TCGType type,
> -                           TCGReg a0, tcg_target_long a1, TCGReg a2)
> -{
> -    tgen_subbi_rrr(s, type, a0, TCG_REG_G0, a2);
> -}
> -
> -static void tgen_subbi_rii(TCGContext *s, TCGType type,
> -                           TCGReg a0, tcg_target_long a1, tcg_target_long a2)
> -{
> -    tgen_subbi_rri(s, type, a0, TCG_REG_G0, a2);
> -}
> -
>   static const TCGOutOpAddSubCarry outop_subbi = {
> -    .base.static_constraint = C_O1_I2(r, rZ, rJ),
> +    .base.static_constraint = C_O1_I2(r, rz, rJ),
>       .out_rrr = tgen_subbi_rrr,
>       .out_rri = tgen_subbi_rri,
> -    .out_rir = tgen_subbi_rir,
> -    .out_rii = tgen_subbi_rii,
>   };
>   
>   static void tgen_subbio_rrr(TCGContext *s, TCGType type,
> @@ -1955,24 +1852,10 @@ static void tgen_subbio_rri(TCGContext *s, TCGType type,
>       tcg_out_arithi(s, a0, a1, a2, ARITH_SUBCCC);
>   }
>   
> -static void tgen_subbio_rir(TCGContext *s, TCGType type,
> -                            TCGReg a0, tcg_target_long a1, TCGReg a2)
> -{
> -    tgen_subbio_rrr(s, type, a0, TCG_REG_G0, a2);
> -}
> -
> -static void tgen_subbio_rii(TCGContext *s, TCGType type,
> -                            TCGReg a0, tcg_target_long a1, tcg_target_long a2)
> -{
> -    tgen_subbio_rri(s, type, a0, TCG_REG_G0, a2);
> -}
> -
>   static const TCGOutOpAddSubCarry outop_subbio = {
> -    .base.static_constraint = C_O1_I2(r, rZ, rJ),
> +    .base.static_constraint = C_O1_I2(r, rz, rJ),
>       .out_rrr = tgen_subbio_rrr,
>       .out_rri = tgen_subbio_rri,
> -    .out_rir = tgen_subbio_rir,
> -    .out_rii = tgen_subbio_rii,
>   };
>   
>   static void tcg_out_set_borrow(TCGContext *s)
> @@ -2114,17 +1997,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           tcg_out_ldst(s, a0, a1, a2, STW);
>           break;
>   
> -    case INDEX_op_add2_i32:
> -        tcg_out_addsub2_i32(s, args[0], args[1], args[2], args[3],
> -                            args[4], const_args[4], args[5], const_args[5],
> -                            ARITH_ADDCC, ARITH_ADDC);
> -        break;
> -    case INDEX_op_sub2_i32:
> -        tcg_out_addsub2_i32(s, args[0], args[1], args[2], args[3],
> -                            args[4], const_args[4], args[5], const_args[5],
> -                            ARITH_SUBCC, ARITH_SUBC);
> -        break;
> -
>       case INDEX_op_qemu_ld_i32:
>           tcg_out_qemu_ld(s, a0, a1, a2, TCG_TYPE_I32);
>           break;
> @@ -2148,15 +2020,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           tcg_out_ldst(s, a0, a1, a2, STX);
>           break;
>   
> -    case INDEX_op_add2_i64:
> -        tcg_out_addsub2_i64(s, args[0], args[1], args[2], args[3], args[4],
> -                            const_args[4], args[5], const_args[5], false);
> -        break;
> -    case INDEX_op_sub2_i64:
> -        tcg_out_addsub2_i64(s, args[0], args[1], args[2], args[3], args[4],
> -                            const_args[4], args[5], const_args[5], true);
> -        break;
> -
>       case INDEX_op_mb:
>           tcg_out_mb(s, a0);
>           break;
> @@ -2203,12 +2066,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_qemu_st_i64:
>           return C_O0_I2(rz, r);
>   
> -    case INDEX_op_add2_i32:
> -    case INDEX_op_add2_i64:
> -    case INDEX_op_sub2_i32:
> -    case INDEX_op_sub2_i64:
> -        return C_O2_I4(r, r, rz, rz, rJ, rJ);
> -
>       default:
>           return C_NotImplemented;
>       }

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


