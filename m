Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69550C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 19:21:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwoLq-0006m4-0n; Tue, 16 Apr 2024 15:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rwoLo-0006kD-Jv
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 15:20:16 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rwoLm-0000Ye-Gs
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 15:20:16 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6effe9c852eso2025439b3a.3
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 12:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713295212; x=1713900012; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WLQ/HcsoX9exGFJ0ckMYMcf7iU4Fld6gbQdibbI56Qc=;
 b=IknN/i+ib7Cd7F4M7qEb6iE7lS9T9DEniMJH91y2On3IwIAs0G8/qJvKESzoY9xWSV
 UdGNTNzF1Ic8WifE0I7KgyozrKL63GWdod5ncJZ1o6/0EwpYo5qlkSzh1Je3f40d6NMJ
 T322bWcZrtRhMIWOn54DoM12OOVRPjwlskg/XTZfLobhewWEGBM7rPPUOsHii5UYl0fP
 zZ/Wnr0JFecwWRLQxKIo9MkR9b0/i+5QY+pHmcDuKOAfxfmJwHztjrlaAsxTACmF4njx
 KRL63yB4kTVCeYntm9cKR67AqiVlCO7b/X0f/FUyxkLNt0sXzxVzV/gPZ9PaYpiETWHO
 uwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713295212; x=1713900012;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WLQ/HcsoX9exGFJ0ckMYMcf7iU4Fld6gbQdibbI56Qc=;
 b=fcUoSt4MqBSiOJzgNKPAqJ9yjsix0c+EpFlQPUjY0a/tRojibREj+6/uBe8hMBuJ3C
 7vdGfWdceljrahSwGIsbEXS5EeGJs7PD/1h8QSgeaoCSElUmG9qFiho99CDyo3jVYmgc
 xhpD6ndYE+hHUwFbDdfrsRcQXUtr9x/NzklaWepEr+FbV6jv06Ln7fYzYqHD4zzhBGAe
 +EMST0f/19Hehed4BBYZ4Cmr1sC35cOcaCGYeiG9voiidDvgiCxeh2fRe3Qu/Rk7hOV9
 QwOUvI0oesdEZ9Kf7bogoiqZtv5L5uxsVOwMJD2/ScQXaqDgzXZVU+lVSPKoSdR6QuaU
 T63w==
X-Gm-Message-State: AOJu0YxOGf7oYhEq0lyjDBIujsXlqBcU2anS1hl90eu01o7qH06VNtTR
 8XHa574SaiWj3xqNjeJhfu24Deg2NDnHGoY/M7J1FTZAlo8AH5RNUXyuhSsGdbE=
X-Google-Smtp-Source: AGHT+IG6SmVExnOQXvlPEdNf0ZXSUbLWH+A1b3iObQo1JEANUj/IKNmA4B5aZqLpTiOiQzfdcCqlFg==
X-Received: by 2002:a05:6a21:3a42:b0:1aa:14a1:e5ef with SMTP id
 zu2-20020a056a213a4200b001aa14a1e5efmr6290137pzb.38.1713295211883; 
 Tue, 16 Apr 2024 12:20:11 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 f22-20020a056a000b1600b006ecfb733248sm9678441pfu.13.2024.04.16.12.20.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Apr 2024 12:20:11 -0700 (PDT)
Message-ID: <1f39a25e-6c64-4ff2-8521-7059c5ed2214@linaro.org>
Date: Tue, 16 Apr 2024 12:20:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] target/ppc: Move cmp{rb, eqb}, tw[i], td[i], isel
 instructions to decodetree.
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 harshpb@linux.ibm.com
References: <20240416063927.99428-1-rathc@linux.ibm.com>
 <20240416063927.99428-8-rathc@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240416063927.99428-8-rathc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 4/15/24 23:39, Chinmay Rath wrote:
> Moving the following instructions to decodetree specification :
> 
> 	cmp{rb, eqb}, t{w, d}	: X-form
> 	t{w, d}i		: D-form
> 	isel			: A-form
> 
> The changes were verified by validating that the tcg ops generated by those
> instructions remain the same, which were captured using the '-d in_asm,op' flag.
> 
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>

A faithful reorg of the existing code, so,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Notes for improvement:

> +static bool trans_CMPRB(DisasContext *ctx, arg_CMPRB *a)
> +{
> +    TCGv_i32 src1 = tcg_temp_new_i32();
> +    TCGv_i32 src2 = tcg_temp_new_i32();
> +    TCGv_i32 src2lo = tcg_temp_new_i32();
> +    TCGv_i32 src2hi = tcg_temp_new_i32();
> +    TCGv_i32 crf = cpu_crf[a->bf];
> +
> +    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
> +    tcg_gen_trunc_tl_i32(src1, cpu_gpr[a->ra]);
> +    tcg_gen_trunc_tl_i32(src2, cpu_gpr[a->rb]);
> +
> +    tcg_gen_andi_i32(src1, src1, 0xFF);
> +    tcg_gen_ext8u_i32(src2lo, src2);
> +    tcg_gen_shri_i32(src2, src2, 8);
> +    tcg_gen_ext8u_i32(src2hi, src2);

tcg_gen_extract_i32(src2hi, src2, 8, 8);

> +
> +    tcg_gen_setcond_i32(TCG_COND_LEU, src2lo, src2lo, src1);
> +    tcg_gen_setcond_i32(TCG_COND_LEU, src2hi, src1, src2hi);
> +    tcg_gen_and_i32(crf, src2lo, src2hi);
> +
> +    if (a->l) {
> +        tcg_gen_shri_i32(src2, src2, 8);
> +        tcg_gen_ext8u_i32(src2lo, src2);

tcg_gen_extract_i32(src2lo, src2, 16, 8);

> +        tcg_gen_shri_i32(src2, src2, 8);
> +        tcg_gen_ext8u_i32(src2hi, src2);

tcg_gen_extract_i32(src2hi, src2, 24, 8);

> +/*
> + * Fixed-Point Trap Instructions
> + */
> +
> +static bool trans_TW(DisasContext *ctx, arg_TW *a)
> +{
> +    TCGv_i32 t0;
> +
> +    if (check_unconditional_trap(ctx, a->rt)) {
> +        return true;
> +    }
> +    t0 = tcg_constant_i32(a->rt);
> +    gen_helper_TW(tcg_env, cpu_gpr[a->ra], cpu_gpr[a->rb], t0);
> +    return true;
> +}
> +
> +static bool trans_TWI(DisasContext *ctx, arg_TWI *a)
> +{
> +    TCGv t0;
> +    TCGv_i32 t1;
> +
> +    if (check_unconditional_trap(ctx, a->rt)) {
> +        return true;
> +    }
> +    t0 = tcg_constant_tl(a->si);
> +    t1 = tcg_constant_i32(a->rt);
> +    gen_helper_TW(tcg_env, cpu_gpr[a->ra], t0, t1);
> +    return true;
> +}
> +
> +static bool trans_TD(DisasContext *ctx, arg_TD *a)
> +{
> +    TCGv_i32 t0;
> +
> +    REQUIRE_64BIT(ctx);
> +    if (check_unconditional_trap(ctx, a->rt)) {
> +        return true;
> +    }
> +    t0 = tcg_constant_i32(a->rt);
> +    gen_helper_TD(tcg_env, cpu_gpr[a->ra], cpu_gpr[a->rb], t0);
> +    return true;
> +}
> +
> +static bool trans_TDI(DisasContext *ctx, arg_TDI *a)
> +{
> +    TCGv t0;
> +    TCGv_i32 t1;
> +
> +    REQUIRE_64BIT(ctx);
> +    if (check_unconditional_trap(ctx, a->rt)) {
> +        return true;
> +    }
> +    t0 = tcg_constant_tl(a->si);
> +    t1 = tcg_constant_i32(a->rt);
> +    gen_helper_TD(tcg_env, cpu_gpr[a->ra], t0, t1);
> +    return true;
> +}

See target/sparc/translate.c, delay_exception, for a method of implementing 
compare-and-trap inline with no inline branch penalty.

static void do_conditional_trap(DisasContext *ctx, unsigned to, TCGv a, TCGv b)
{
     static const TCGCond ucond[8] = {
         TCG_COND_NEVER, TCG_COND_GTU, TCG_COND_LTU, TCG_COND_NE,
         TCG_COND_EQ,    TCG_COND_GEU, TCG_COND_LEU, TCG_COND_ALWAYS,
     };
     static const TCGCond scond[8] = {
         TCG_COND_NEVER, TCG_COND_EQ,  TCG_COND_GT,  TCG_COND_GE,
         TCG_COND_LT,    TCG_COND_LE,  TCG_COND_NE,  TCG_COND_ALWAYS,
     };

     TCGCond uc = ucond[to & 7];
     TCGCond sc = scond[to >> 2];

     /* There is overlap with EQ; we may not need both comparisons. */
     if (!(to & 0x18)) {
         sc = TCG_COND_NEVER;
     } else if (!(to & 0x03)) {
         uc = TCG_COND_NEVER;
     }

     if (uc == TCG_COND_ALWAYS || sc == TCG_COND_ALWAYS) {
         unconditional trap;
         return true;
     }
     if (uc == TCG_COND_NEVER && sc == TCG_COND_NEVER) {
         return true;
     }

     e = delay_exception(ctx, POWERPC_EXCP_TRAP);

     if (uc != TCG_COND_NEVER) {
         tcg_gen_brcond_tl(uc, a, b, e->lab);
     }
     if (sc != TCG_COND_NEVER) {
         tcg_gen_brcond_tl(sc, a, b, e->lab);
     }
     return true;
}

bool trans_TW(...)
{
     TCGv a = tcg_temp_new();
     TCGv b = tcg_temp_new();

     /* Note that consistent sign extensions work for unsigned comparisons. */
     tcg_gen_exts_i32_tl(a, ra);
     tcg_gen_exts_i32_tl(b, rb);
     return do_conditional_trap(ctx, to, a, b);
}

etc.


r~

