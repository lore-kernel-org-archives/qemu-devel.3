Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A25ABC369B8
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 21:15:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4nd6-0008Lk-3t; Tue, 15 Apr 2025 17:15:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4ncb-0008Ej-8B
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 17:15:09 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4ncY-0002M4-7d
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 17:15:08 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7390d21bb1cso5977501b3a.2
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 14:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744751703; x=1745356503; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z03vxIfjbGJyH2exvYb3HbhJKI6ZgpGc8twzPUrHgts=;
 b=dO2nAXXUfOjVnpxaz4CFqCPyB6yhgeCA85qq9QagRZGlyUoKtmC5LnZsvMfStJMHaQ
 uXyQNw7JrY1sGMzcZl7SE4yfqTbUAvr1qxP3ET/WeD5rzzTFn4KJJ5AdRvTfRAqnaiyn
 27CLEDycqXIijt8k24c0Si7NExjuol/wIwU2mQ5Gp1sDah6R+v5Mo5zR5EYj/4i1UdX2
 Icmr5UjvviKweeXAxwV1lxGr/ggFAIlUM4V0lLv19+oHMgpM6uTFqjiKdzS425B1na91
 31AmbWuoUXeUemNgLbPEE5EYuRbgZ5S4qN5PRxx+/Cs8HY14/XQpSjg9099EyyoabW5k
 FmHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744751703; x=1745356503;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z03vxIfjbGJyH2exvYb3HbhJKI6ZgpGc8twzPUrHgts=;
 b=TsiyBW/9cij+t+hmE6ZzP+D4YE/oB1N1C6NC2YDVfmaSFXTi1uOdML5CcEUB7+I0wO
 F9EKnV1MJgqCTeOEb6fIIRz5/+CIqNDyKUZG6pzgf9xqMZFmUW+Yq2FJO6T0AoPehcAM
 8NnX6et81vm06IFnYQxfkxWz0G6XZA5yWBTpsxtx82xrSqgUHxusyqn3Ngw+qKJkN6sk
 JmJ50HPIp7m0a+T2maoixe5Bj9X7gAaJnP+Pz2HVW8sNDPOpcgMEMcen+d3wtWZRkgzY
 1ALwRxcCbvyfYIBnYLCQDKbnyOc1K9xAJW1E4Kd7Mn/GphS6ge/zeb/ufBD8pjTbgJIs
 zLIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkVeToV+MdHdu4j9BcrGbkQoz9p7TFs3dWyt3XNRa9fE+Tj/Suj1R3WJtXDNexuQjz+HdTo+xi5kXb@nongnu.org
X-Gm-Message-State: AOJu0YwVQlm5MpWRQZPF30c73z9xwYt9TqRnVeyHf0AQPtdnYpntht4m
 kZOZ9uBCZBgn68HwOPof35zzH8wPDkpOz+jmyy+GFrYiJwW2Am8LCu4tGTyL+EzBuNcMjGcC9og
 JMlo=
X-Gm-Gg: ASbGncsMH1k3oQj6Cj6q+1RXH4TMSmZiXhAONxvuJmBoG7DrzPr6Cn+2yTI/U1RA0aP
 i27jMt/ac+CU7lkWelj8HAbLda0M7d+swX42qql6dUNaecQTaf2YSJh0Zt86Muf922T2hu0VnqY
 mCToDYC3lZEOxJUaAfnLpjRGjhWzbjQ5a+s+0NP7P9/zbW9dEbMMA79fj//+c/6DeYvzUfNfnd1
 yW6S8VEzHaqhPjeGB3OsYTpogqHK2rTCg+WPunB9aTXCXEvLjk2k+YdXyiL8klGb/WOy785UM1m
 mU29Fxar6ZEzCv08TYCbDzIaycleMxPoP4PKljG/eXiqxVz2bld6mg==
X-Google-Smtp-Source: AGHT+IHKTjqnhye5b7T1pGUBW/1S0fJtfp4BxudwytmIYxQHXrXlOrQuJkQZ7ZMDk+D5tBTX5TWWWg==
X-Received: by 2002:a05:6a20:43a8:b0:1f3:41d5:6608 with SMTP id
 adf61e73a8af0-203ae05c67dmr732380637.26.1744751703432; 
 Tue, 15 Apr 2025 14:15:03 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b02a0cf2d9bsm11482577a12.22.2025.04.15.14.15.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 14:15:03 -0700 (PDT)
Message-ID: <c2905ead-2d85-4560-956e-06638705ac60@linaro.org>
Date: Tue, 15 Apr 2025 14:15:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 067/163] tcg: Merge INDEX_op_ctpop_{i32,i64}
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-68-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-68-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
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
>   include/tcg/tcg-opc.h    |  3 +--
>   tcg/optimize.c           |  9 +++------
>   tcg/tcg-op.c             | 21 ++++++++++-----------
>   tcg/tcg.c                |  6 ++----
>   tcg/tci.c                |  6 ++----
>   docs/devel/tcg-ops.rst   |  6 +++---
>   tcg/tci/tcg-target.c.inc |  2 +-
>   7 files changed, 22 insertions(+), 31 deletions(-)
> 
> diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
> index 4dfd8708a5..f4ccde074b 100644
> --- a/include/tcg/tcg-opc.h
> +++ b/include/tcg/tcg-opc.h
> @@ -43,6 +43,7 @@ DEF(add, 1, 2, 0, TCG_OPF_INT)
>   DEF(and, 1, 2, 0, TCG_OPF_INT)
>   DEF(andc, 1, 2, 0, TCG_OPF_INT)
>   DEF(clz, 1, 2, 0, TCG_OPF_INT)
> +DEF(ctpop, 1, 1, 0, TCG_OPF_INT)
>   DEF(ctz, 1, 2, 0, TCG_OPF_INT)
>   DEF(divs, 1, 2, 0, TCG_OPF_INT)
>   DEF(divs2, 2, 3, 0, TCG_OPF_INT)
> @@ -97,7 +98,6 @@ DEF(setcond2_i32, 1, 4, 1, 0)
>   
>   DEF(bswap16_i32, 1, 1, 1, 0)
>   DEF(bswap32_i32, 1, 1, 1, 0)
> -DEF(ctpop_i32, 1, 1, 0, 0)
>   
>   DEF(setcond_i64, 1, 2, 1, 0)
>   DEF(negsetcond_i64, 1, 2, 1, 0)
> @@ -130,7 +130,6 @@ DEF(brcond_i64, 0, 2, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH)
>   DEF(bswap16_i64, 1, 1, 1, 0)
>   DEF(bswap32_i64, 1, 1, 1, 0)
>   DEF(bswap64_i64, 1, 1, 1, 0)
> -DEF(ctpop_i64, 1, 1, 0, 0)
>   
>   DEF(add2_i64, 2, 4, 0, 0)
>   DEF(sub2_i64, 2, 4, 0, 0)
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index 2dbc0e45b4..78979623c5 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -503,11 +503,8 @@ static uint64_t do_constant_folding_2(TCGOpcode op, TCGType type,
>           }
>           return x ? ctz64(x) : y;
>   
> -    case INDEX_op_ctpop_i32:
> -        return ctpop32(x);
> -
> -    case INDEX_op_ctpop_i64:
> -        return ctpop64(x);
> +    case INDEX_op_ctpop:
> +        return type == TCG_TYPE_I32 ? ctpop32(x) : ctpop64(x);
>   
>       CASE_OP_32_64(bswap16):
>           x = bswap16(x);
> @@ -2890,7 +2887,7 @@ void tcg_optimize(TCGContext *s)
>           case INDEX_op_ctz:
>               done = fold_count_zeros(&ctx, op);
>               break;
> -        CASE_OP_32_64(ctpop):
> +        case INDEX_op_ctpop:
>               done = fold_ctpop(&ctx, op);
>               break;
>           CASE_OP_32_64(deposit):
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index db0e79059b..0eeec47b83 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -765,8 +765,7 @@ void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
>           tcg_temp_free_i64(t2);
>           return;
>       }
> -    if (tcg_op_supported(INDEX_op_ctpop_i32, TCG_TYPE_I32, 0) ||
> -        tcg_op_supported(INDEX_op_ctpop_i64, TCG_TYPE_I64, 0)) {
> +    if (tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_REG, 0)) {
>           t = tcg_temp_ebb_new_i32();
>           tcg_gen_subi_i32(t, arg1, 1);
>           tcg_gen_andc_i32(t, t, arg1);
> @@ -791,7 +790,7 @@ void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2)
>   {
>       if (arg2 == 32
>           && !tcg_op_supported(INDEX_op_ctz, TCG_TYPE_I32, 0)
> -        && tcg_op_supported(INDEX_op_ctpop_i32, TCG_TYPE_I32, 0)) {
> +        && tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_REG, 0)) {
>           /* This equivalence has the advantage of not requiring a fixup.  */
>           TCGv_i32 t = tcg_temp_ebb_new_i32();
>           tcg_gen_subi_i32(t, arg1, 1);
> @@ -819,9 +818,9 @@ void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg)
>   
>   void tcg_gen_ctpop_i32(TCGv_i32 ret, TCGv_i32 arg1)
>   {
> -    if (tcg_op_supported(INDEX_op_ctpop_i32, TCG_TYPE_I32, 0)) {
> -        tcg_gen_op2_i32(INDEX_op_ctpop_i32, ret, arg1);
> -    } else if (tcg_op_supported(INDEX_op_ctpop_i64, TCG_TYPE_I64, 0)) {
> +    if (tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_I32, 0)) {
> +        tcg_gen_op2_i32(INDEX_op_ctpop, ret, arg1);
> +    } else if (tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_I64, 0)) {
>           TCGv_i64 t = tcg_temp_ebb_new_i64();
>           tcg_gen_extu_i32_i64(t, arg1);
>           tcg_gen_ctpop_i64(t, t);
> @@ -2372,7 +2371,7 @@ void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
>           tcg_gen_op3_i64(INDEX_op_ctz, ret, arg1, arg2);
>           return;
>       }
> -    if (tcg_op_supported(INDEX_op_ctpop_i64, TCG_TYPE_I64, 0)) {
> +    if (tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_I64, 0)) {
>           t = tcg_temp_ebb_new_i64();
>           tcg_gen_subi_i64(t, arg1, 1);
>           tcg_gen_andc_i64(t, t, arg1);
> @@ -2406,7 +2405,7 @@ void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2)
>           tcg_temp_free_i32(t32);
>       } else if (arg2 == 64
>                  && !tcg_op_supported(INDEX_op_ctz, TCG_TYPE_I64, 0)
> -               && tcg_op_supported(INDEX_op_ctpop_i64, TCG_TYPE_I64, 0)) {
> +               && tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_I64, 0)) {
>           /* This equivalence has the advantage of not requiring a fixup.  */
>           TCGv_i64 t = tcg_temp_ebb_new_i64();
>           tcg_gen_subi_i64(t, arg1, 1);
> @@ -2435,12 +2434,12 @@ void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg)
>   void tcg_gen_ctpop_i64(TCGv_i64 ret, TCGv_i64 arg1)
>   {
>       if (TCG_TARGET_REG_BITS == 64) {
> -        if (tcg_op_supported(INDEX_op_ctpop_i64, TCG_TYPE_I64, 0)) {
> -            tcg_gen_op2_i64(INDEX_op_ctpop_i64, ret, arg1);
> +        if (tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_I64, 0)) {
> +            tcg_gen_op2_i64(INDEX_op_ctpop, ret, arg1);
>               return;
>           }
>       } else {
> -        if (tcg_op_supported(INDEX_op_ctpop_i32, TCG_TYPE_I32, 0)) {
> +        if (tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_I32, 0)) {
>               tcg_gen_ctpop_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1));
>               tcg_gen_ctpop_i32(TCGV_LOW(ret), TCGV_LOW(arg1));
>               tcg_gen_add_i32(TCGV_LOW(ret), TCGV_LOW(ret), TCGV_HIGH(ret));
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 8344aee6c1..6095205307 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -1027,8 +1027,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
>       OUTOP(INDEX_op_and, TCGOutOpBinary, outop_and),
>       OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
>       OUTOP(INDEX_op_clz, TCGOutOpBinary, outop_clz),
> -    OUTOP(INDEX_op_ctpop_i32, TCGOutOpUnary, outop_ctpop),
> -    OUTOP(INDEX_op_ctpop_i64, TCGOutOpUnary, outop_ctpop),
> +    OUTOP(INDEX_op_ctpop, TCGOutOpUnary, outop_ctpop),
>       OUTOP(INDEX_op_ctz, TCGOutOpBinary, outop_ctz),
>       OUTOP(INDEX_op_divs, TCGOutOpBinary, outop_divs),
>       OUTOP(INDEX_op_divu, TCGOutOpBinary, outop_divu),
> @@ -5444,8 +5443,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
>           }
>           break;
>   
> -    case INDEX_op_ctpop_i32:
> -    case INDEX_op_ctpop_i64:
> +    case INDEX_op_ctpop:
>       case INDEX_op_neg:
>       case INDEX_op_not:
>           {
> diff --git a/tcg/tci.c b/tcg/tci.c
> index 8bcf48b251..d58a94ff28 100644
> --- a/tcg/tci.c
> +++ b/tcg/tci.c
> @@ -577,8 +577,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
>               tci_args_rr(insn, &r0, &r1);
>               regs[r0] = ~regs[r1];
>               break;
> -        case INDEX_op_ctpop_i32:
> -        case INDEX_op_ctpop_i64:
> +        case INDEX_op_ctpop:
>               tci_args_rr(insn, &r0, &r1);
>               regs[r0] = ctpop_tr(regs[r1]);
>               break;
> @@ -1023,6 +1022,7 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
>                              op_name, str_r(r0), str_r(r1), s2);
>           break;
>   
> +    case INDEX_op_ctpop:
>       case INDEX_op_mov:
>       case INDEX_op_neg:
>       case INDEX_op_not:
> @@ -1033,8 +1033,6 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
>       case INDEX_op_bswap32_i32:
>       case INDEX_op_bswap32_i64:
>       case INDEX_op_bswap64_i64:
> -    case INDEX_op_ctpop_i32:
> -    case INDEX_op_ctpop_i64:
>           tci_args_rr(insn, &r0, &r1);
>           info->fprintf_func(info->stream, "%-12s  %s, %s",
>                              op_name, str_r(r0), str_r(r1));
> diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
> index 92344b8786..fb7764e3c0 100644
> --- a/docs/devel/tcg-ops.rst
> +++ b/docs/devel/tcg-ops.rst
> @@ -366,12 +366,12 @@ Logical
>   
>        - | *t0* = *t1* ? ctz(*t1*) : *t2*
>   
> -   * - ctpop_i32/i64 *t0*, *t1*
> +   * - ctpop *t0*, *t1*
>   
>        - | *t0* = number of bits set in *t1*
>          |
> -       | With *ctpop* short for "count population", matching
> -       | the function name used in ``include/qemu/host-utils.h``.
> +       | The name *ctpop* is short for "count population", and matches
> +         the function name used in ``include/qemu/host-utils.h``.
>   
>   
>   Shifts/Rotates
> diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
> index a931369a80..1d696a087e 100644
> --- a/tcg/tci/tcg-target.c.inc
> +++ b/tcg/tci/tcg-target.c.inc
> @@ -883,7 +883,7 @@ static const TCGOutOpBinary outop_xor = {
>   
>   static void tgen_ctpop(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
>   {
> -    tcg_out_op_rr(s, glue(INDEX_op_ctpop_i,TCG_TARGET_REG_BITS), a0, a1);
> +    tcg_out_op_rr(s, INDEX_op_ctpop, a0, a1);
>   }
>   
>   static TCGConstraintSetIndex cset_ctpop(TCGType type, unsigned flags)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


