Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC1BC369B9
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 21:55:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4oFJ-0005kT-U0; Tue, 15 Apr 2025 17:55:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4oFH-0005k1-8D
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 17:55:07 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4oFD-0005d6-SX
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 17:55:06 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7390d21bb1cso6003581b3a.2
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 14:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744754102; x=1745358902; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nAJ12oaCpN40VczBi32K000Eq3KLcogCp8jVJQx3WYk=;
 b=On8INVUlkIHzwcVc+OLw77Vs1GA69TbwXvvwz+JBvExwcwXQl/kayLMNv7+bO3J/Bz
 dd7VAf/w82QZE7KsfZc9hLudepf73fIKioNDU7oRogoaraIEsDLW9lh37rboKBrxe5+H
 /57CZ7O2h/aVSF1weo5CATLalfHTPFDmbnVciOnbv5jB4lZBCgyH+5NhXBPewaF0uzpQ
 7FLPviiZVCobWVrjQdPcx6VfFypH13slmbtJ2L1zP2xzTnUmXMixZAfaXi81YFKTFZ6J
 HFr6wLy27j5TzNxakQbTQoLEfwgdJENLdM8GVXKuDetWDAFzrYC52wkfhQOd1jqrppRl
 Rowg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744754102; x=1745358902;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nAJ12oaCpN40VczBi32K000Eq3KLcogCp8jVJQx3WYk=;
 b=pSdcZ2chLjmuNjJQ+rXt31EglEK0hhqXJ6AG26H7+1x4hJPtXF5JQu8azJU9g3A4ka
 iZ7ewIQCrbqCY8uoQmVdTgs8q++2HaZgsh+tXmz3p29BZyeB4ZOMWXFbeNpwM1ASwd+b
 F4lkfRlv+7/Eh9Gcjbt0DPV9TsLpchR2IHu7LvAc238FO1AS9wcCQPF0JaL7K+sGbQ3A
 36Hga2kPpqFMD+nhdLMT11nGdk8OFm50mFq1JqCY/p37USnpdLFdhRGaPVImmhqRnZ7i
 QJ5UPcX70VhaRIpSBGy+Mz6lf6tsjPEJWL8xOcN1OTLsT62+zvR3zhRCELHxQDOB6rLu
 loWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWC7Rv168b3nqp2UVQVrPrMq2Fwo/PvbhjOM0pYjEwbJRHkORtlZ/Ek/JGtydFF8aECtDLhO9wlkji6@nongnu.org
X-Gm-Message-State: AOJu0YyQ8cbOwnjXuAzkeNm/8JM+VAmpWwKRPNA2++VJQSo91/ERe27t
 UaWJSR5T/xE9QX5JZKBdj77acbaK4mhv/fB4YynCQd0XQx2BBDKqm6t3X48NSd0=
X-Gm-Gg: ASbGncvUWzruGJ/xpZeA0U4bZ8AjyJPjEI+dqd4dDfonldLGkdNx+Xs3uBd0p08eYMz
 8eHenGcq10eCM+pPHatkj3zw7Ra/wRPgc+QcheSe0jOSg3l30bX2Oc92kfX7uyiwOnewwpUm7eF
 fJrBIo94cL5VmL92V6tH2QmNBUC07QPhrxsy4Db52ttC5rrZR+nUW1ZUNyDtp9xeF+IYOO8SEzC
 /+qxvE30mR8yUCD334l7HqgZt+ptji8iOOvlG94I/vSbVDQmdWQxcY8WzeuFtXyNtIK9IrRQjLw
 5xu1Nqa+Cg5tZPxuFB9wlXDbhzFlqh8xhn5m19ApsfhdFO+nufSd1A==
X-Google-Smtp-Source: AGHT+IH/uprRmeQRXmXXoyKj4uXf45VCUIa8Lk1BGeFa8cHSUnG8c/1FKI8u7FmcaaOS+2rr3Vp71w==
X-Received: by 2002:a05:6a20:9f45:b0:1f8:e0f5:846d with SMTP id
 adf61e73a8af0-203ae05c851mr974033637.34.1744754101634; 
 Tue, 15 Apr 2025 14:55:01 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd230e8b1sm9320538b3a.148.2025.04.15.14.55.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 14:55:01 -0700 (PDT)
Message-ID: <d8f0b0b3-b616-461a-a497-160bbd9d3a58@linaro.org>
Date: Tue, 15 Apr 2025 14:55:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 095/163] tcg: Convert sextract to TCGOutOpExtract
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-96-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-96-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
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
>   tcg/tcg.c                        |  4 ++
>   tcg/aarch64/tcg-target.c.inc     | 18 +++++----
>   tcg/arm/tcg-target.c.inc         | 21 ++++++-----
>   tcg/i386/tcg-target.c.inc        | 63 ++++++++++++++++----------------
>   tcg/loongarch64/tcg-target.c.inc | 49 ++++++++++++++-----------
>   tcg/mips/tcg-target.c.inc        | 42 ++++++++++++---------
>   tcg/ppc/tcg-target.c.inc         | 49 ++++++++++++++-----------
>   tcg/riscv/tcg-target.c.inc       | 49 ++++++++++++++-----------
>   tcg/s390x/tcg-target.c.inc       | 15 ++++----
>   tcg/sparc64/tcg-target.c.inc     | 18 ++++++---
>   tcg/tci/tcg-target.c.inc         | 11 +++---
>   11 files changed, 188 insertions(+), 151 deletions(-)
> 
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 5f5b323c66..b86e3daed0 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -1111,6 +1111,8 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
>       OUTOP(INDEX_op_rotr, TCGOutOpBinary, outop_rotr),
>       OUTOP(INDEX_op_sar, TCGOutOpBinary, outop_sar),
>       OUTOP(INDEX_op_setcond, TCGOutOpSetcond, outop_setcond),
> +    OUTOP(INDEX_op_sextract_i32, TCGOutOpExtract, outop_sextract),
> +    OUTOP(INDEX_op_sextract_i64, TCGOutOpExtract, outop_sextract),
>       OUTOP(INDEX_op_shl, TCGOutOpBinary, outop_shl),
>       OUTOP(INDEX_op_shr, TCGOutOpBinary, outop_shr),
>       OUTOP(INDEX_op_sub, TCGOutOpSubtract, outop_sub),
> @@ -5515,6 +5517,8 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
>           break;
>   
>       case INDEX_op_extract:
> +    case INDEX_op_sextract_i32:
> +    case INDEX_op_sextract_i64:
>           {
>               const TCGOutOpExtract *out =
>                   container_of(all_outop[op->opc], TCGOutOpExtract, base);
> diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
> index 6c9d6094a2..00400f6ea7 100644
> --- a/tcg/aarch64/tcg-target.c.inc
> +++ b/tcg/aarch64/tcg-target.c.inc
> @@ -2583,6 +2583,17 @@ static const TCGOutOpExtract outop_extract = {
>       .out_rr = tgen_extract,
>   };
>   
> +static void tgen_sextract(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
> +                          unsigned ofs, unsigned len)
> +{
> +    tcg_out_sbfm(s, type, a0, a1, ofs, ofs + len - 1);
> +}
> +
> +static const TCGOutOpExtract outop_sextract = {
> +    .base.static_constraint = C_O1_I1(r, r),
> +    .out_rr = tgen_sextract,
> +};
> +
>   static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
>                          const TCGArg args[TCG_MAX_OP_ARGS],
>                          const int const_args[TCG_MAX_OP_ARGS])
> @@ -2668,11 +2679,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
>           tcg_out_dep(s, ext, a0, a2, args[3], args[4]);
>           break;
>   
> -    case INDEX_op_sextract_i64:
> -    case INDEX_op_sextract_i32:
> -        tcg_out_sbfm(s, ext, a0, a1, a2, a2 + args[3] - 1);
> -        break;
> -
>       case INDEX_op_extract2_i64:
>       case INDEX_op_extract2_i32:
>           tcg_out_extr(s, ext, a0, a2, a1, args[3]);
> @@ -3173,8 +3179,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_ld_i64:
>       case INDEX_op_ext_i32_i64:
>       case INDEX_op_extu_i32_i64:
> -    case INDEX_op_sextract_i32:
> -    case INDEX_op_sextract_i64:
>           return C_O1_I1(r, r);
>   
>       case INDEX_op_st8_i32:
> diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
> index bc060b20f2..aebe48679c 100644
> --- a/tcg/arm/tcg-target.c.inc
> +++ b/tcg/arm/tcg-target.c.inc
> @@ -1020,12 +1020,12 @@ static const TCGOutOpExtract outop_extract = {
>       .out_rr = tgen_extract,
>   };
>   
> -static void tcg_out_sextract(TCGContext *s, ARMCond cond, TCGReg rd,
> -                             TCGReg rn, int ofs, int len)
> +static void tgen_sextract(TCGContext *s, TCGType type, TCGReg rd, TCGReg rn,
> +                          unsigned ofs, unsigned len)
>   {
>       if (use_armv7_instructions) {
>           /* sbfx */
> -        tcg_out32(s, 0x07a00050 | (cond << 28) | (rd << 12) | rn
> +        tcg_out32(s, 0x07a00050 | (COND_AL << 28) | (rd << 12) | rn
>                     | (ofs << 7) | ((len - 1) << 16));
>           return;
>       }
> @@ -1034,17 +1034,24 @@ static void tcg_out_sextract(TCGContext *s, ARMCond cond, TCGReg rd,
>       switch (len) {
>       case 8:
>           /* sxtb */
> -        tcg_out32(s, 0x06af0070 | (cond << 28) | (rd << 12) | (ofs << 7) | rn);
> +        tcg_out32(s, 0x06af0070 | (COND_AL << 28) |
> +                  (rd << 12) | (ofs << 7) | rn);
>           break;
>       case 16:
>           /* sxth */
> -        tcg_out32(s, 0x06bf0070 | (cond << 28) | (rd << 12) | (ofs << 7) | rn);
> +        tcg_out32(s, 0x06bf0070 | (COND_AL << 28) |
> +                  (rd << 12) | (ofs << 7) | rn);
>           break;
>       default:
>           g_assert_not_reached();
>       }
>   }
>   
> +static const TCGOutOpExtract outop_sextract = {
> +    .base.static_constraint = C_O1_I1(r, r),
> +    .out_rr = tgen_sextract,
> +};
> +
>   
>   static void tcg_out_ld32u(TCGContext *s, ARMCond cond,
>                             TCGReg rd, TCGReg rn, int32_t offset)
> @@ -2399,9 +2406,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           tcg_out_deposit(s, COND_AL, args[0], args[2],
>                           args[3], args[4], const_args[2]);
>           break;
> -    case INDEX_op_sextract_i32:
> -        tcg_out_sextract(s, COND_AL, args[0], args[1], args[2], args[3]);
> -        break;
>       case INDEX_op_extract2_i32:
>           /* ??? These optimization vs zero should be generic.  */
>           /* ??? But we can't substitute 2 for 1 in the opcode stream yet.  */
> @@ -2448,7 +2452,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_ld16u_i32:
>       case INDEX_op_ld16s_i32:
>       case INDEX_op_ld_i32:
> -    case INDEX_op_sextract_i32:
>           return C_O1_I1(r, r);
>   
>       case INDEX_op_st8_i32:
> diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
> index b26c93bdb1..6a5414ab3a 100644
> --- a/tcg/i386/tcg-target.c.inc
> +++ b/tcg/i386/tcg-target.c.inc
> @@ -3180,6 +3180,38 @@ static const TCGOutOpExtract outop_extract = {
>       .out_rr = tgen_extract,
>   };
>   
> +static void tgen_sextract(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
> +                          unsigned ofs, unsigned len)
> +{
> +    if (ofs == 0) {
> +        switch (len) {
> +        case 8:
> +            tcg_out_ext8s(s, type, a0, a1);
> +            return;
> +        case 16:
> +            tcg_out_ext16s(s, type, a0, a1);
> +            return;
> +        case 32:
> +            tcg_out_ext32s(s, a0, a1);
> +            return;
> +        }
> +    } else if (ofs == 8 && len == 8) {
> +        if (type == TCG_TYPE_I32 && a1 < 4 && a0 < 8) {
> +            tcg_out_modrm(s, OPC_MOVSBL, a0, a1 + 4);
> +        } else {
> +            tcg_out_ext16s(s, type, a0, a1);
> +            tgen_sari(s, type, a0, a0, 8);
> +        }
> +        return;
> +    }
> +    g_assert_not_reached();
> +}
> +
> +static const TCGOutOpExtract outop_sextract = {
> +    .base.static_constraint = C_O1_I1(r, r),
> +    .out_rr = tgen_sextract,
> +};
> +
>   static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>                          const TCGArg args[TCG_MAX_OP_ARGS],
>                          const int const_args[TCG_MAX_OP_ARGS])
> @@ -3369,35 +3401,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           }
>           break;
>   
> -    case INDEX_op_sextract_i64:
> -        if (a2 == 0 && args[3] == 8) {
> -            tcg_out_ext8s(s, TCG_TYPE_I64, a0, a1);
> -        } else if (a2 == 0 && args[3] == 16) {
> -            tcg_out_ext16s(s, TCG_TYPE_I64, a0, a1);
> -        } else if (a2 == 0 && args[3] == 32) {
> -            tcg_out_ext32s(s, a0, a1);
> -        } else {
> -            g_assert_not_reached();
> -        }
> -        break;
> -
> -    case INDEX_op_sextract_i32:
> -        if (a2 == 0 && args[3] == 8) {
> -            tcg_out_ext8s(s, TCG_TYPE_I32, a0, a1);
> -        } else if (a2 == 0 && args[3] == 16) {
> -            tcg_out_ext16s(s, TCG_TYPE_I32, a0, a1);
> -        } else if (a2 == 8 && args[3] == 8) {
> -            if (a1 < 4 && a0 < 8) {
> -                tcg_out_modrm(s, OPC_MOVSBL, a0, a1 + 4);
> -            } else {
> -                tcg_out_ext16s(s, TCG_TYPE_I32, a0, a1);
> -                tcg_out_shifti(s, SHIFT_SAR, a0, 8);
> -            }
> -        } else {
> -            g_assert_not_reached();
> -        }
> -        break;
> -
>       OP_32_64(extract2):
>           /* Note that SHRD outputs to the r/m operand.  */
>           tcg_out_modrm(s, OPC_SHRD_Ib + rexw, a2, a0);
> @@ -4001,8 +4004,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_ext_i32_i64:
>       case INDEX_op_extu_i32_i64:
>       case INDEX_op_extrl_i64_i32:
> -    case INDEX_op_sextract_i32:
> -    case INDEX_op_sextract_i64:
>           return C_O1_I1(r, r);
>   
>       case INDEX_op_extract2_i32:
> diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
> index 42983aff3b..c88db7a0e2 100644
> --- a/tcg/loongarch64/tcg-target.c.inc
> +++ b/tcg/loongarch64/tcg-target.c.inc
> @@ -1804,6 +1804,33 @@ static const TCGOutOpExtract outop_extract = {
>       .out_rr = tgen_extract,
>   };
>   
> +static void tgen_sextract(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
> +                          unsigned ofs, unsigned len)
> +{
> +    if (ofs == 0) {
> +        switch (len) {
> +        case 8:
> +            tcg_out_ext8s(s, type, a0, a1);
> +            return;
> +        case 16:
> +            tcg_out_ext16s(s, type, a0, a1);
> +            return;
> +        case 32:
> +            tcg_out_ext32s(s, a0, a1);
> +            return;
> +        }
> +    } else if (ofs + len == 32) {
> +        tcg_out_opc_srai_w(s, a0, a1, ofs);
> +        return;
> +    }
> +    g_assert_not_reached();
> +}
> +
> +static const TCGOutOpExtract outop_sextract = {
> +    .base.static_constraint = C_O1_I1(r, r),
> +    .out_rr = tgen_sextract,
> +};
> +
>   static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>                          const TCGArg args[TCG_MAX_OP_ARGS],
>                          const int const_args[TCG_MAX_OP_ARGS])
> @@ -1832,26 +1859,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           tcg_out_opc_srai_d(s, a0, a1, 32);
>           break;
>   
> -    case INDEX_op_sextract_i64:
> -        if (a2 + args[3] == 32) {
> -            if (a2 == 0) {
> -                tcg_out_ext32s(s, a0, a1);
> -            } else {
> -                tcg_out_opc_srai_w(s, a0, a1, a2);
> -            }
> -            break;
> -        }
> -        /* FALLTHRU */
> -    case INDEX_op_sextract_i32:
> -        if (a2 == 0 && args[3] == 8) {
> -            tcg_out_ext8s(s, TCG_TYPE_REG, a0, a1);
> -        } else if (a2 == 0 && args[3] == 16) {
> -            tcg_out_ext16s(s, TCG_TYPE_REG, a0, a1);
> -        } else {
> -            g_assert_not_reached();
> -        }
> -        break;
> -
>       case INDEX_op_deposit_i32:
>           tcg_out_opc_bstrins_w(s, a0, a2, args[3], args[3] + args[4] - 1);
>           break;
> @@ -2456,8 +2463,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_extrl_i64_i32:
>       case INDEX_op_extrh_i64_i32:
>       case INDEX_op_ext_i32_i64:
> -    case INDEX_op_sextract_i32:
> -    case INDEX_op_sextract_i64:
>       case INDEX_op_ld8s_i32:
>       case INDEX_op_ld8s_i64:
>       case INDEX_op_ld8u_i32:
> diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
> index dbb4b9355d..56c58bf82d 100644
> --- a/tcg/mips/tcg-target.c.inc
> +++ b/tcg/mips/tcg-target.c.inc
> @@ -2221,6 +2221,30 @@ static const TCGOutOpExtract outop_extract = {
>       .out_rr = tgen_extract,
>   };
>   
> +static void tgen_sextract(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
> +                          unsigned ofs, unsigned len)
> +{
> +    if (ofs == 0) {
> +        switch (len) {
> +        case 8:
> +            tcg_out_ext8s(s, type, a0, a1);
> +            return;
> +        case 16:
> +            tcg_out_ext16s(s, type, a0, a1);
> +            return;
> +        case 32:
> +            tcg_out_ext32s(s, a0, a1);
> +            return;
> +        }
> +    }
> +    g_assert_not_reached();
> +}
> +
> +static const TCGOutOpExtract outop_sextract = {
> +    .base.static_constraint = C_O1_I1(r, r),
> +    .out_rr = tgen_sextract,
> +};
> +
>   static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>                          const TCGArg args[TCG_MAX_OP_ARGS],
>                          const int const_args[TCG_MAX_OP_ARGS])
> @@ -2303,22 +2327,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>                            args[3] + args[4] - 1, args[3]);
>           break;
>   
> -    case INDEX_op_sextract_i64:
> -        if (a2 == 0 && args[3] == 32) {
> -            tcg_out_ext32s(s, a0, a1);
> -            break;
> -        }
> -        /* FALLTHRU */
> -    case INDEX_op_sextract_i32:
> -        if (a2 == 0 && args[3] == 8) {
> -            tcg_out_ext8s(s, TCG_TYPE_REG, a0, a1);
> -        } else if (a2 == 0 && args[3] == 16) {
> -            tcg_out_ext16s(s, TCG_TYPE_REG, a0, a1);
> -        } else {
> -            g_assert_not_reached();
> -        }
> -        break;
> -
>       case INDEX_op_qemu_ld_i32:
>           tcg_out_qemu_ld(s, a0, 0, a1, a2, TCG_TYPE_I32);
>           break;
> @@ -2376,7 +2384,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_ld16u_i32:
>       case INDEX_op_ld16s_i32:
>       case INDEX_op_ld_i32:
> -    case INDEX_op_sextract_i32:
>       case INDEX_op_ld8u_i64:
>       case INDEX_op_ld8s_i64:
>       case INDEX_op_ld16u_i64:
> @@ -2388,7 +2395,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_extu_i32_i64:
>       case INDEX_op_extrl_i64_i32:
>       case INDEX_op_extrh_i64_i32:
> -    case INDEX_op_sextract_i64:
>           return C_O1_I1(r, r);
>   
>       case INDEX_op_st8_i32:
> diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
> index a8558a47b7..3d1ffa9130 100644
> --- a/tcg/ppc/tcg-target.c.inc
> +++ b/tcg/ppc/tcg-target.c.inc
> @@ -3434,6 +3434,33 @@ static const TCGOutOpExtract outop_extract = {
>       .out_rr = tgen_extract,
>   };
>   
> +static void tgen_sextract(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
> +                          unsigned ofs, unsigned len)
> +{
> +    if (ofs == 0) {
> +        switch (len) {
> +        case 8:
> +            tcg_out_ext8s(s, type, a0, a1);
> +            return;
> +        case 16:
> +            tcg_out_ext16s(s, type, a0, a1);
> +            return;
> +        case 32:
> +            tcg_out_ext32s(s, a0, a1);
> +            return;
> +        }
> +    } else if (ofs + len == 32) {
> +        tcg_out_sari32(s, a0, a1, ofs);
> +        return;
> +    }
> +    g_assert_not_reached();
> +}
> +
> +static const TCGOutOpExtract outop_sextract = {
> +    .base.static_constraint = C_O1_I1(r, r),
> +    .out_rr = tgen_sextract,
> +};
> +
>   
>   static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>                          const TCGArg args[TCG_MAX_OP_ARGS],
> @@ -3555,26 +3582,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           }
>           break;
>   
> -    case INDEX_op_sextract_i64:
> -        if (args[2] + args[3] == 32) {
> -            if (args[2] == 0) {
> -                tcg_out_ext32s(s, args[0], args[1]);
> -            } else {
> -                tcg_out_sari32(s, args[0], args[1], args[2]);
> -            }
> -            break;
> -        }
> -        /* FALLTHRU */
> -    case INDEX_op_sextract_i32:
> -        if (args[2] == 0 && args[3] == 8) {
> -            tcg_out_ext8s(s, TCG_TYPE_I32, args[0], args[1]);
> -        } else if (args[2] == 0 && args[3] == 16) {
> -            tcg_out_ext16s(s, TCG_TYPE_I32, args[0], args[1]);
> -        } else {
> -            g_assert_not_reached();
> -        }
> -        break;
> -
>   #if TCG_TARGET_REG_BITS == 64
>       case INDEX_op_add2_i64:
>   #else
> @@ -4256,7 +4263,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_ld16u_i32:
>       case INDEX_op_ld16s_i32:
>       case INDEX_op_ld_i32:
> -    case INDEX_op_sextract_i32:
>       case INDEX_op_ld8u_i64:
>       case INDEX_op_ld8s_i64:
>       case INDEX_op_ld16u_i64:
> @@ -4266,7 +4272,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_ld_i64:
>       case INDEX_op_ext_i32_i64:
>       case INDEX_op_extu_i32_i64:
> -    case INDEX_op_sextract_i64:
>           return C_O1_I1(r, r);
>   
>       case INDEX_op_st8_i32:
> diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
> index 85d978763c..dc2b487844 100644
> --- a/tcg/riscv/tcg-target.c.inc
> +++ b/tcg/riscv/tcg-target.c.inc
> @@ -2501,6 +2501,33 @@ static const TCGOutOpExtract outop_extract = {
>       .out_rr = tgen_extract,
>   };
>   
> +static void tgen_sextract(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
> +                          unsigned ofs, unsigned len)
> +{
> +    if (ofs == 0) {
> +        switch (len) {
> +        case 8:
> +            tcg_out_ext8s(s, type, a0, a1);
> +            return;
> +        case 16:
> +            tcg_out_ext16s(s, type, a0, a1);
> +            return;
> +        case 32:
> +            tcg_out_ext32s(s, a0, a1);
> +            return;
> +        }
> +    } else if (ofs + len == 32) {
> +        tgen_sari(s, TCG_TYPE_I32, a0, a1, ofs);
> +        return;
> +    }
> +    g_assert_not_reached();
> +}
> +
> +static const TCGOutOpExtract outop_sextract = {
> +    .base.static_constraint = C_O1_I1(r, r),
> +    .out_rr = tgen_sextract,
> +};
> +
>   static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>                          const TCGArg args[TCG_MAX_OP_ARGS],
>                          const int const_args[TCG_MAX_OP_ARGS])
> @@ -2600,26 +2627,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           tcg_out_mb(s, a0);
>           break;
>   
> -    case INDEX_op_sextract_i64:
> -        if (a2 + args[3] == 32) {
> -            if (a2 == 0) {
> -                tcg_out_ext32s(s, a0, a1);
> -            } else {
> -                tcg_out_opc_imm(s, OPC_SRAIW, a0, a1, a2);
> -            }
> -            break;
> -        }
> -        /* FALLTHRU */
> -    case INDEX_op_sextract_i32:
> -        if (a2 == 0 && args[3] == 8) {
> -            tcg_out_ext8s(s, TCG_TYPE_REG, a0, a1);
> -        } else if (a2 == 0 && args[3] == 16) {
> -            tcg_out_ext16s(s, TCG_TYPE_REG, a0, a1);
> -        } else {
> -            g_assert_not_reached();
> -        }
> -        break;
> -
>       case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
>       case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
>       case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
> @@ -2871,8 +2878,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_extrl_i64_i32:
>       case INDEX_op_extrh_i64_i32:
>       case INDEX_op_ext_i32_i64:
> -    case INDEX_op_sextract_i32:
> -    case INDEX_op_sextract_i64:
>           return C_O1_I1(r, r);
>   
>       case INDEX_op_st8_i32:
> diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
> index 96e2dc0ad5..ab178bebc8 100644
> --- a/tcg/s390x/tcg-target.c.inc
> +++ b/tcg/s390x/tcg-target.c.inc
> @@ -1587,8 +1587,8 @@ static const TCGOutOpExtract outop_extract = {
>       .out_rr = tgen_extract,
>   };
>   
> -static void tgen_sextract(TCGContext *s, TCGReg dest, TCGReg src,
> -                          int ofs, int len)
> +static void tgen_sextract(TCGContext *s, TCGType type, TCGReg dest,
> +                          TCGReg src, unsigned ofs, unsigned len)
>   {
>       if (ofs == 0) {
>           switch (len) {
> @@ -1606,6 +1606,11 @@ static void tgen_sextract(TCGContext *s, TCGReg dest, TCGReg src,
>       g_assert_not_reached();
>   }
>   
> +static const TCGOutOpExtract outop_sextract = {
> +    .base.static_constraint = C_O1_I1(r, r),
> +    .out_rr = tgen_sextract,
> +};
> +
>   static void tgen_gotoi(TCGContext *s, int cc, const tcg_insn_unit *dest)
>   {
>       ptrdiff_t off = tcg_pcrel_diff(s, dest) >> 1;
> @@ -2980,10 +2985,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           }
>           break;
>   
> -    OP_32_64(sextract):
> -        tgen_sextract(s, args[0], args[1], args[2], args[3]);
> -        break;
> -
>       case INDEX_op_mb:
>           /* The host memory model is quite strong, we simply need to
>              serialize the instruction stream.  */
> @@ -3472,8 +3473,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>   
>       case INDEX_op_ext_i32_i64:
>       case INDEX_op_extu_i32_i64:
> -    case INDEX_op_sextract_i32:
> -    case INDEX_op_sextract_i64:
>           return C_O1_I1(r, r);
>   
>       case INDEX_op_qemu_ld_i32:
> diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
> index cba1dd009c..0f2bec21e9 100644
> --- a/tcg/sparc64/tcg-target.c.inc
> +++ b/tcg/sparc64/tcg-target.c.inc
> @@ -1769,6 +1769,18 @@ static const TCGOutOpExtract outop_extract = {
>       .out_rr = tgen_extract,
>   };
>   
> +static void tgen_sextract(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
> +                          unsigned ofs, unsigned len)
> +{
> +    tcg_debug_assert(ofs + len == 32);
> +    tcg_out_arithi(s, a0, a1, ofs, SHIFT_SRA);
> +}
> +
> +static const TCGOutOpExtract outop_sextract = {
> +    .base.static_constraint = C_O1_I1(r, r),
> +    .out_rr = tgen_sextract,
> +};
> +
>   static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>                          const TCGArg args[TCG_MAX_OP_ARGS],
>                          const int const_args[TCG_MAX_OP_ARGS])
> @@ -1868,11 +1880,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           tcg_out_mb(s, a0);
>           break;
>   
> -    case INDEX_op_sextract_i64:
> -        tcg_debug_assert(a2 + args[3] == 32);
> -        tcg_out_arithi(s, a0, a1, a2, SHIFT_SRA);
> -        break;
> -
>       case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
>       case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
>       case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
> @@ -1904,7 +1911,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_ld_i64:
>       case INDEX_op_ext_i32_i64:
>       case INDEX_op_extu_i32_i64:
> -    case INDEX_op_sextract_i64:
>       case INDEX_op_qemu_ld_i32:
>       case INDEX_op_qemu_ld_i64:
>           return C_O1_I1(r, r);
> diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
> index ede11d9e70..e013321ac7 100644
> --- a/tcg/tci/tcg-target.c.inc
> +++ b/tcg/tci/tcg-target.c.inc
> @@ -57,8 +57,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_ld_i64:
>       case INDEX_op_ext_i32_i64:
>       case INDEX_op_extu_i32_i64:
> -    case INDEX_op_sextract_i32:
> -    case INDEX_op_sextract_i64:
>           return C_O1_I1(r, r);
>   
>       case INDEX_op_st8_i32:
> @@ -453,6 +451,11 @@ static void tcg_out_sextract(TCGContext *s, TCGType type, TCGReg rd,
>       tcg_out_op_rrbb(s, opc, rd, rs, pos, len);
>   }
>   
> +static const TCGOutOpExtract outop_sextract = {
> +    .base.static_constraint = C_O1_I1(r, r),
> +    .out_rr = tcg_out_sextract,
> +};
> +
>   static void tcg_out_ext8s(TCGContext *s, TCGType type, TCGReg rd, TCGReg rs)
>   {
>       tcg_out_sextract(s, type, rd, rs, 0, 8);
> @@ -1078,10 +1081,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           tcg_out_op_rrrbb(s, opc, args[0], args[1], args[2], args[3], args[4]);
>           break;
>   
> -    CASE_32_64(sextract) /* Optional (TCG_TARGET_HAS_sextract_*). */
> -        tcg_out_op_rrbb(s, opc, args[0], args[1], args[2], args[3]);
> -        break;
> -
>       CASE_32_64(add2)
>       CASE_32_64(sub2)
>           tcg_out_op_rrrrrr(s, opc, args[0], args[1], args[2],

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


