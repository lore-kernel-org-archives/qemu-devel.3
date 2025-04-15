Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C3EC369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 21:38:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4nyI-000266-Np; Tue, 15 Apr 2025 17:37:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4ny7-00023t-CQ
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 17:37:23 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4ny4-0001Ih-IK
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 17:37:23 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2255003f4c6so63437385ad.0
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 14:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744753038; x=1745357838; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YhMgT86IPVpWqHE34ViVhV6+CUX6eRioBbQ0zUlFeMs=;
 b=w6yNDWbTbiUEMMScPZ3yj5WE77ELL0lRzXI/F1CAn2wRKQOsYV8ddxvYp7U3Sq8+Rk
 7BLS+4iOnzH6HkLQvxSPOSMCljSaNrl163E1tQM8YFp6gnuACNO16fbv3pRg7z+G5JnU
 DK3Dpv3gei/arTtuFe9X0XWK5mxA+1+d/9kSu/uel/+ByMOL+AEDz0PGuYr2MBa3rwW5
 GqbefZwexyUJTQSqDGBSEFHo4uXEaCWHrqiEzPpCRwOJPcLnErQPjboK1lvPlo4f9nwj
 8KcR4PeWmXvLdF3VukxhEemfX/3xNpTspLiIb6y0HV74cd6yFW5rBu5xYi4o6f8Af/2N
 WWwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744753038; x=1745357838;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YhMgT86IPVpWqHE34ViVhV6+CUX6eRioBbQ0zUlFeMs=;
 b=xSHzCrUHLEa4XSTH6+Szg4FF/M+V2q/9VQc76fHM0ruZuNb143WEDNoXyMaRaFSbNP
 KzpgDUGsWLPWIB7wt29nrbrb20trKK0n0tSBa+aWlv5TJtmRbJoa+sOlvXRCwFu0myb7
 Gq0OCvg0AW3FBehZ/CF8wgRuu+rMpRJgKRU9WgqZ7XgZeF2ifgPcTjP4M64qGxrJicDH
 ePwTHVEQUamtXp1MM3ckLRhu0cFRkQuljK4MeIFFBdJ1M0NDJKq/xbfYxyMHJ/FvAhW9
 2hej68dDg9q2llGbm3derR6UYRz+0cU1l6VGmSUAVxgL2zpR5RtRMSGuEwSoIUIbbO4/
 lotQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHYF8s8xjvpuVQ6GGhIS5XBWL2hz0Iz4HdWiya8L2LsJ1k6gowqlIe0tLF3adJf7NQpl3ye1KZycUA@nongnu.org
X-Gm-Message-State: AOJu0YxtqizG33EhR8lmTHUqZiDRp8AmtgYoTP14Lji0qptD1B72mRnV
 KueTlu3oOsFhqpsw2XgDRtUGKY278HQyuunCD0JHpFGpZToJdylaveLkEnAmDZ4hMhog20SaodY
 lMqQ=
X-Gm-Gg: ASbGnctbRD/QduvRpx8lXUo0gaf2HHXouH9LOTbCNJQrG0t63rsuiisgrlW7tBrvaid
 KeKL+BH9gcIYwaFj+UykNOJ44dNkJ2wFczy0J37TtO4Pt4KUcQtiUiiRtXfizp1lrUSHFwbRwih
 mIp2TPpR2/Ci43h0oB5fHAZBaUET/TIQVIocZaJXFP9wcQQbmyZ/BqPX5AcIy3Sx1BKceU5kirJ
 HDGgvmcssmYwJQ32tFtBXqIimIRevepCNSErkFVeqtK0Lv4NEqh5H3aOhN+SjjnhbRy7VaAXbmb
 xOJlc+s9Mh28I0Y9MCq99WL6lv7/r9hAJHG/El/KfEY0QChAKbRzeg==
X-Google-Smtp-Source: AGHT+IHDdApmv752ryl1ZhpGd6qBODNl0D452Le8HEMa1SJ9q43j/ENacODXjJeWVeh516DLLHv3Rw==
X-Received: by 2002:a17:903:40d2:b0:223:5124:a16e with SMTP id
 d9443c01a7336-22c318ac7cemr11919245ad.5.1744753038529; 
 Tue, 15 Apr 2025 14:37:18 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c33ef119bsm106655ad.48.2025.04.15.14.37.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 14:37:18 -0700 (PDT)
Message-ID: <5f644b11-ec34-4278-8d0c-6cb013229482@linaro.org>
Date: Tue, 15 Apr 2025 14:37:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 085/163] tcg: Convert brcond2_i32 to TCGOutOpBrcond2
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-86-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-86-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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

On 4/15/25 12:23, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/mips/tcg-target-con-set.h |  2 +-
>   tcg/tcg.c                     | 30 +++++++++++++++++
>   tcg/arm/tcg-target.c.inc      | 20 +++++++----
>   tcg/i386/tcg-target.c.inc     | 62 ++++++++++++++++++-----------------
>   tcg/mips/tcg-target.c.inc     | 19 ++++++-----
>   tcg/ppc/tcg-target.c.inc      | 25 +++++++-------
>   tcg/tci/tcg-target.c.inc      | 30 +++++++++--------
>   7 files changed, 118 insertions(+), 70 deletions(-)
> 
> diff --git a/tcg/mips/tcg-target-con-set.h b/tcg/mips/tcg-target-con-set.h
> index f5e4852b56..9d0ea73f4f 100644
> --- a/tcg/mips/tcg-target-con-set.h
> +++ b/tcg/mips/tcg-target-con-set.h
> @@ -13,7 +13,7 @@ C_O0_I1(r)
>   C_O0_I2(r, rz)
>   C_O0_I2(rz, r)
>   C_O0_I3(rz, rz, r)
> -C_O0_I4(rz, rz, rz, rz)
> +C_O0_I4(r, r, rz, rz)
>   C_O1_I1(r, r)
>   C_O1_I2(r, 0, rz)
>   C_O1_I2(r, r, r)
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 702fae003b..6fd287cdda 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -994,6 +994,13 @@ typedef struct TCGOutOpBrcond {
>                      TCGReg a1, tcg_target_long a2, TCGLabel *label);
>   } TCGOutOpBrcond;
>   
> +typedef struct TCGOutOpBrcond2 {
> +    TCGOutOp base;
> +    void (*out)(TCGContext *s, TCGCond cond, TCGReg al, TCGReg ah,
> +                TCGArg bl, bool const_bl,
> +                TCGArg bh, bool const_bh, TCGLabel *l);
> +} TCGOutOpBrcond2;
> +
>   typedef struct TCGOutOpDivRem {
>       TCGOutOp base;
>       void (*out_rr01r)(TCGContext *s, TCGType type,
> @@ -1087,6 +1094,10 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
>       OUTOP(INDEX_op_shr, TCGOutOpBinary, outop_shr),
>       OUTOP(INDEX_op_sub, TCGOutOpSubtract, outop_sub),
>       OUTOP(INDEX_op_xor, TCGOutOpBinary, outop_xor),
> +
> +#if TCG_TARGET_REG_BITS == 32
> +    OUTOP(INDEX_op_brcond2_i32, TCGOutOpBrcond2, outop_brcond2),
> +#endif
>   };
>   
>   #undef OUTOP
> @@ -5537,6 +5548,25 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
>           }
>           break;
>   
> +#if TCG_TARGET_REG_BITS == 32
> +    case INDEX_op_brcond2_i32:
> +        {
> +            const TCGOutOpBrcond2 *out = &outop_brcond2;
> +            TCGCond cond = new_args[4];
> +            TCGLabel *label = arg_label(new_args[5]);
> +
> +            tcg_debug_assert(!const_args[0]);
> +            tcg_debug_assert(!const_args[1]);
> +            out->out(s, cond, new_args[0], new_args[1],
> +                     new_args[2], const_args[2],
> +                     new_args[3], const_args[3], label);
> +        }
> +        break;
> +#else
> +    case INDEX_op_brcond2_i32:
> +        g_assert_not_reached();
> +#endif
> +
>       default:
>           if (def->flags & TCG_OPF_VECTOR) {
>               tcg_out_vec_op(s, op->opc, type - TCG_TYPE_V64,
> diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
> index cebd783285..1c42df1092 100644
> --- a/tcg/arm/tcg-target.c.inc
> +++ b/tcg/arm/tcg-target.c.inc
> @@ -2253,6 +2253,19 @@ static const TCGOutOpMovcond outop_movcond = {
>       .out = tgen_movcond,
>   };
>   
> +static void tgen_brcond2(TCGContext *s, TCGCond cond, TCGReg al, TCGReg ah,
> +                         TCGArg bl, bool const_bl, TCGArg bh, bool const_bh,
> +                         TCGLabel *l)
> +{
> +    cond = tcg_out_cmp2(s, cond, al, ah, bl, const_bl, bh, const_bh);
> +    tcg_out_goto_label(s, tcg_cond_to_arm_cond[cond], l);
> +}
> +
> +static const TCGOutOpBrcond2 outop_brcond2 = {
> +    .base.static_constraint = C_O0_I4(r, r, rI, rI),
> +    .out = tgen_brcond2,
> +};
> +
>   
>   static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>                          const TCGArg args[TCG_MAX_OP_ARGS],
> @@ -2335,11 +2348,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           tcg_out_mov_reg(s, COND_AL, args[0], a0);
>           break;
>   
> -    case INDEX_op_brcond2_i32:
> -        c = tcg_out_cmp2(s, args[4], args[0], args[1], args[2], const_args[2],
> -                         args[3], const_args[3]);
> -        tcg_out_goto_label(s, tcg_cond_to_arm_cond[c], arg_label(args[5]));
> -        break;
>       case INDEX_op_setcond2_i32:
>           c = tcg_out_cmp2(s, args[5], args[1], args[2], args[3], const_args[3],
>                            args[4], const_args[4]);
> @@ -2444,8 +2452,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>           return C_O2_I4(r, r, r, r, rIN, rIK);
>       case INDEX_op_sub2_i32:
>           return C_O2_I4(r, r, rI, rI, rIN, rIK);
> -    case INDEX_op_brcond2_i32:
> -        return C_O0_I4(r, r, rI, rI);
>       case INDEX_op_setcond2_i32:
>           return C_O1_I4(r, r, r, rI, rI);
>   
> diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
> index ae3a53a18a..b7708c945f 100644
> --- a/tcg/i386/tcg-target.c.inc
> +++ b/tcg/i386/tcg-target.c.inc
> @@ -1662,42 +1662,52 @@ static const TCGOutOpBrcond outop_brcond = {
>       .out_ri = tgen_brcondi,
>   };
>   
> -#if TCG_TARGET_REG_BITS == 32
> -static void tcg_out_brcond2(TCGContext *s, const TCGArg *args,
> -                            const int *const_args, bool small)
> +static void tcg_out_brcond2(TCGContext *s, TCGCond cond, TCGReg al,
> +                            TCGReg ah, TCGArg bl, bool blconst,
> +                            TCGArg bh, bool bhconst,
> +                            TCGLabel *label_this, bool small)
>   {
>       TCGLabel *label_next = gen_new_label();
> -    TCGLabel *label_this = arg_label(args[5]);
> -    TCGCond cond = args[4];
>   
>       switch (cond) {
>       case TCG_COND_EQ:
>       case TCG_COND_TSTEQ:
>           tcg_out_brcond(s, 0, tcg_invert_cond(cond),
> -                       args[0], args[2], const_args[2], label_next, 1);
> -        tcg_out_brcond(s, 0, cond, args[1], args[3], const_args[3],
> -                       label_this, small);
> +                       al, bl, blconst, label_next, true);
> +        tcg_out_brcond(s, 0, cond, ah, bh, bhconst, label_this, small);
>           break;
>   
>       case TCG_COND_NE:
>       case TCG_COND_TSTNE:
> -        tcg_out_brcond(s, 0, cond, args[0], args[2], const_args[2],
> -                       label_this, small);
> -        tcg_out_brcond(s, 0, cond, args[1], args[3], const_args[3],
> -                       label_this, small);
> +        tcg_out_brcond(s, 0, cond, al, bl, blconst, label_this, small);
> +        tcg_out_brcond(s, 0, cond, ah, bh, bhconst, label_this, small);
>           break;
>   
>       default:
> -        tcg_out_brcond(s, 0, tcg_high_cond(cond), args[1],
> -                       args[3], const_args[3], label_this, small);
> +        tcg_out_brcond(s, 0, tcg_high_cond(cond),
> +                       ah, bh, bhconst, label_this, small);
>           tcg_out_jxx(s, JCC_JNE, label_next, 1);
> -        tcg_out_brcond(s, 0, tcg_unsigned_cond(cond), args[0],
> -                       args[2], const_args[2], label_this, small);
> +        tcg_out_brcond(s, 0, tcg_unsigned_cond(cond),
> +                       al, bl, blconst, label_this, small);
>           break;
>       }
>       tcg_out_label(s, label_next);
>   }
> +
> +static void tgen_brcond2(TCGContext *s, TCGCond cond, TCGReg al,
> +                         TCGReg ah, TCGArg bl, bool blconst,
> +                         TCGArg bh, bool bhconst, TCGLabel *l)
> +{
> +    tcg_out_brcond2(s, cond, al, ah, bl, blconst, bh, bhconst, l, false);
> +}
> +
> +#if TCG_TARGET_REG_BITS != 32
> +__attribute__((unused))
>   #endif
> +static const TCGOutOpBrcond2 outop_brcond2 = {
> +    .base.static_constraint = C_O0_I4(r, r, ri, ri),
> +    .out = tgen_brcond2,
> +};
>   
>   static void tcg_out_setcond(TCGContext *s, TCGType type, TCGCond cond,
>                               TCGReg dest, TCGReg arg1, TCGArg arg2,
> @@ -1854,11 +1864,8 @@ static const TCGOutOpSetcond outop_negsetcond = {
>   static void tcg_out_setcond2(TCGContext *s, const TCGArg *args,
>                                const int *const_args)
>   {
> -    TCGArg new_args[6];
>       TCGLabel *label_true, *label_over;
>   
> -    memcpy(new_args, args+1, 5*sizeof(TCGArg));
> -
>       if (args[0] == args[1] || args[0] == args[2]
>           || (!const_args[3] && args[0] == args[3])
>           || (!const_args[4] && args[0] == args[4])) {
> @@ -1867,8 +1874,8 @@ static void tcg_out_setcond2(TCGContext *s, const TCGArg *args,
>           label_true = gen_new_label();
>           label_over = gen_new_label();
>   
> -        new_args[5] = label_arg(label_true);
> -        tcg_out_brcond2(s, new_args, const_args+1, 1);
> +        tcg_out_brcond2(s, args[5], args[1], args[2], args[3], const_args[3],
> +                        args[4], const_args[4], label_true, true);
>   
>           tcg_out_movi(s, TCG_TYPE_I32, args[0], 0);
>           tcg_out_jxx(s, JCC_JMP, label_over, 1);
> @@ -1884,9 +1891,10 @@ static void tcg_out_setcond2(TCGContext *s, const TCGArg *args,
>           tcg_out_movi(s, TCG_TYPE_I32, args[0], 0);
>   
>           label_over = gen_new_label();
> -        new_args[4] = tcg_invert_cond(new_args[4]);
> -        new_args[5] = label_arg(label_over);
> -        tcg_out_brcond2(s, new_args, const_args+1, 1);
> +        tcg_out_brcond2(s, tcg_invert_cond(args[5]), args[1], args[2],
> +                        args[3], const_args[3],
> +                        args[4], const_args[4], label_over, true);
> +
>   
>           tgen_arithi(s, ARITH_ADD, args[0], 1, 0);
>           tcg_out_label(s, label_over);
> @@ -3233,9 +3241,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           break;
>   
>   #if TCG_TARGET_REG_BITS == 32
> -    case INDEX_op_brcond2_i32:
> -        tcg_out_brcond2(s, args, const_args, 0);
> -        break;
>       case INDEX_op_setcond2_i32:
>           tcg_out_setcond2(s, args, const_args);
>           break;
> @@ -4007,9 +4012,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>           tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
>           return C_O0_I3(L, L, L);
>   
> -    case INDEX_op_brcond2_i32:
> -        return C_O0_I4(r, r, ri, ri);
> -
>       case INDEX_op_setcond2_i32:
>           return C_O1_I4(r, r, r, ri, ri);
>   
> diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
> index 3ce71a1c8d..9a9b1bb09a 100644
> --- a/tcg/mips/tcg-target.c.inc
> +++ b/tcg/mips/tcg-target.c.inc
> @@ -1074,8 +1074,9 @@ static void tcg_out_setcond2(TCGContext *s, TCGCond cond, TCGReg ret,
>       tcg_out_setcond_end(s, ret, tmpflags);
>   }
>   
> -static void tcg_out_brcond2(TCGContext *s, TCGCond cond, TCGReg al, TCGReg ah,
> -                            TCGReg bl, TCGReg bh, TCGLabel *l)
> +static void tgen_brcond2(TCGContext *s, TCGCond cond, TCGReg al, TCGReg ah,
> +                         TCGArg bl, bool const_bl,
> +                         TCGArg bh, bool const_bh, TCGLabel *l)
>   {
>       int tmpflags = tcg_out_setcond2_int(s, cond, TCG_TMP0, al, ah, bl, bh);
>       TCGReg tmp = tmpflags & ~SETCOND_FLAGS;
> @@ -1086,6 +1087,14 @@ static void tcg_out_brcond2(TCGContext *s, TCGCond cond, TCGReg al, TCGReg ah,
>       tcg_out_nop(s);
>   }
>   
> +#if TCG_TARGET_REG_BITS != 32
> +__attribute__((unused))
> +#endif
> +static const TCGOutOpBrcond2 outop_brcond2 = {
> +    .base.static_constraint = C_O0_I4(r, r, rz, rz),
> +    .out = tgen_brcond2,
> +};
> +
>   static void tgen_movcond(TCGContext *s, TCGType type, TCGCond cond,
>                            TCGReg ret, TCGReg c1, TCGArg c2, bool const_c2,
>                            TCGArg v1, bool const_v1, TCGArg v2, bool const_v2)
> @@ -2297,10 +2306,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           }
>           break;
>   
> -    case INDEX_op_brcond2_i32:
> -        tcg_out_brcond2(s, args[4], a0, a1, a2, args[3], arg_label(args[5]));
> -        break;
> -
>       case INDEX_op_setcond2_i32:
>           tcg_out_setcond2(s, args[5], a0, a1, a2, args[3], args[4]);
>           break;
> @@ -2401,8 +2406,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>           return C_O2_I4(r, r, rz, rz, rN, rN);
>       case INDEX_op_setcond2_i32:
>           return C_O1_I4(r, rz, rz, rz, rz);
> -    case INDEX_op_brcond2_i32:
> -        return C_O0_I4(rz, rz, rz, rz);
>   
>       case INDEX_op_qemu_ld_i32:
>           return C_O1_I1(r, r);
> diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
> index 669c5eae4a..cde8a55918 100644
> --- a/tcg/ppc/tcg-target.c.inc
> +++ b/tcg/ppc/tcg-target.c.inc
> @@ -2283,14 +2283,23 @@ static void tcg_out_setcond2(TCGContext *s, const TCGArg *args,
>       tcg_out_rlw(s, RLWINM, args[0], TCG_REG_R0, CR_EQ + 0*4 + 1, 31, 31);
>   }
>   
> -static void tcg_out_brcond2(TCGContext *s, const TCGArg *args,
> -                            const int *const_args)
> +static void tgen_brcond2(TCGContext *s, TCGCond cond, TCGReg al, TCGReg ah,
> +                         TCGArg bl, bool const_bl,
> +                         TCGArg bh, bool const_bh, TCGLabel *l)
>   {
> -    tcg_out_cmp2(s, args[4], args[0], args[1], args[2], const_args[2],
> -                 args[3], const_args[3]);
> -    tcg_out_bc_lab(s, TCG_COND_EQ, arg_label(args[5]));
> +    assert(TCG_TARGET_REG_BITS == 32);
> +    tcg_out_cmp2(s, cond, al, ah, bl, const_bl, bh, const_bh);
> +    tcg_out_bc_lab(s, TCG_COND_EQ, l);
>   }
>   
> +#if TCG_TARGET_REG_BITS != 32
> +__attribute__((unused))
> +#endif
> +static const TCGOutOpBrcond2 outop_brcond2 = {
> +    .base.static_constraint = C_O0_I4(r, r, rU, rC),
> +    .out = tgen_brcond2,
> +};
> +
>   static void tcg_out_mb(TCGContext *s, TCGArg a0)
>   {
>       uint32_t insn;
> @@ -3450,10 +3459,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           tcg_out_mem_long(s, STD, STDX, args[0], args[1], args[2]);
>           break;
>   
> -    case INDEX_op_brcond2_i32:
> -        tcg_out_brcond2(s, args, const_args);
> -        break;
> -
>       case INDEX_op_qemu_ld_i32:
>           tcg_out_qemu_ld(s, args[0], -1, args[1], args[2], TCG_TYPE_I32);
>           break;
> @@ -4272,8 +4277,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_deposit_i32:
>       case INDEX_op_deposit_i64:
>           return C_O1_I2(r, 0, rZ);
> -    case INDEX_op_brcond2_i32:
> -        return C_O0_I4(r, r, rU, rC);
>       case INDEX_op_setcond2_i32:
>           return C_O1_I4(r, r, r, rU, rC);
>       case INDEX_op_add2_i64:
> diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
> index 99a5744ab4..0fe365e2d4 100644
> --- a/tcg/tci/tcg-target.c.inc
> +++ b/tcg/tci/tcg-target.c.inc
> @@ -87,11 +87,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_sub2_i64:
>           return C_O2_I4(r, r, r, r, r, r);
>   
> -#if TCG_TARGET_REG_BITS == 32
> -    case INDEX_op_brcond2_i32:
> -        return C_O0_I4(r, r, r, r);
> -#endif
> -
>       case INDEX_op_setcond2_i32:
>           return C_O1_I4(r, r, r, r, r);
>   
> @@ -985,6 +980,23 @@ static const TCGOutOpMovcond outop_movcond = {
>       .out = tgen_movcond,
>   };
>   
> +static void tgen_brcond2(TCGContext *s, TCGCond cond, TCGReg al, TCGReg ah,
> +                         TCGArg bl, bool const_bl,
> +                         TCGArg bh, bool const_bh, TCGLabel *l)
> +{
> +    tcg_out_op_rrrrrc(s, INDEX_op_setcond2_i32, TCG_REG_TMP,
> +                      al, ah, bl, bh, cond);
> +    tcg_out_op_rl(s, INDEX_op_brcond, TCG_REG_TMP, l);
> +}
> +
> +#if TCG_TARGET_REG_BITS != 32
> +__attribute__((unused))
> +#endif
> +static const TCGOutOpBrcond2 outop_brcond2 = {
> +    .base.static_constraint = C_O0_I4(r, r, r, r),
> +    .out = tgen_brcond2,
> +};
> +
>   static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>                          const TCGArg args[TCG_MAX_OP_ARGS],
>                          const int const_args[TCG_MAX_OP_ARGS])
> @@ -1055,14 +1067,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>                             args[3], args[4], args[5]);
>           break;
>   
> -#if TCG_TARGET_REG_BITS == 32
> -    case INDEX_op_brcond2_i32:
> -        tcg_out_op_rrrrrc(s, INDEX_op_setcond2_i32, TCG_REG_TMP,
> -                          args[0], args[1], args[2], args[3], args[4]);
> -        tcg_out_op_rl(s, INDEX_op_brcond, TCG_REG_TMP, arg_label(args[5]));
> -        break;
> -#endif
> -
>       case INDEX_op_qemu_ld_i64:
>       case INDEX_op_qemu_st_i64:
>           if (TCG_TARGET_REG_BITS == 32) {

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


