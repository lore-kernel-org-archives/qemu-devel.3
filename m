Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F12C3C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 04:00:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seo7w-0000mS-2d; Thu, 15 Aug 2024 23:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1seo7u-0000lV-TZ
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 23:59:46 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1seo7s-0001jh-SF
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 23:59:46 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1fec34f94abso16040695ad.2
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 20:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723780783; x=1724385583; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=51KZbNfBjnB8rvGafgEnEPadW5VYjs2rD2xxoubdmO4=;
 b=iRjR/JemLY8NrJ0VcZ2M2C0vrQBttk0Kssj+73shZPyynsPxYhO9QO9WQUMylmyIy7
 c6PytMH18kZD0RbH8y32Zbs1CX9O6NJ/v1fuoPv7bK4e0w2UsnNDLlYO+cPa6Smau2Xe
 vQnnJ5FH6B4ndnsrrScfgY+bv4ZCyHy4oWB90Rb+O9IQ8+cLimptlJqjvI7s1nA1YjJe
 OESqaoY5d/KfuxU1v2URggUg+lA+PFyJdlcAYrdRODvYyK1c3aqshCIMgvzljq+somn5
 SfuIJRyTg3I8guDzAcbAJIYveaWMV/6+ympWk+G41QdHeW05pvfINtI9t1fqTcgQRCOq
 X7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723780783; x=1724385583;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=51KZbNfBjnB8rvGafgEnEPadW5VYjs2rD2xxoubdmO4=;
 b=gSYpLkan4aMaFepxX/OMRyc5/PSdFcCeswZRPgXk5fnABzPDktf2LSqx21H5Z37CSC
 5WbMO/dlhQO8IYZc2P3TNqzdkoWeq2fdy9naEAb/UiVczdTNU24qNzdOcBdXeq+/RQya
 DBxuyzL7Q4U7frbUY2wmAzjADpEh8Cc+RrJRonkV1Qou2GQ623COXPJYYjzhQVW1LamZ
 MjWErApKkmdESXsxBXEZeabPiYxbXxofHOM9zxxgxjqAbYesDNnaYQVI2nqg2yHllhJU
 jWEcjGr5C+QTWFjdYvgzOs+uHG3HECTbjLHRu6rVZMfCfYmjo7psclCKROhhO0P62N0R
 +uyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVg0j8tKyzQc+yag9jIbLalFzPdDllzecLkCh7l0SQT7oYMsekjZyP3q252REXyP5Vlzi3p0KfOKU/o@nongnu.org
X-Gm-Message-State: AOJu0Yzde9InCgf8FEehDY0t5TtNHJtmCWRFcCZ3zTRGMjcvz1Zf3rYJ
 vdslS2XrYFHvGbfK9StMtZqCNr11fLXuRy1Z4gg4rOXKs5+pfL8VOMawwovdRyCjvADHtqadfoL
 4rXU=
X-Google-Smtp-Source: AGHT+IFMrzUBy6YtoxA5WQMLNQm7baHzWcdSapIwbpMrjS2QLvtB1Qa+YOw3HZhZIi8EgQy6h/dNgA==
X-Received: by 2002:a17:902:d490:b0:1fb:46a7:dbda with SMTP id
 d9443c01a7336-20203f323ccmr20691085ad.47.1723780782723; 
 Thu, 15 Aug 2024 20:59:42 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:d09c:46ba:97a2:4a99?
 (2403-580a-f89b-0-d09c-46ba-97a2-4a99.ip6.aussiebb.net.
 [2403:580a:f89b:0:d09c:46ba:97a2:4a99])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f03756c7sm17154495ad.151.2024.08.15.20.59.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Aug 2024 20:59:41 -0700 (PDT)
Message-ID: <12b02b87-6089-47b2-ad8d-8f00e64f3539@linaro.org>
Date: Fri, 16 Aug 2024 13:59:31 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/16] target/riscv: zicfilp `lpad` impl and branch
 tracking
To: Deepak Gupta <debug@rivosinc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, pbonzini@redhat.com, jim.shu@sifive.com,
 andy.chiu@sifive.com, kito.cheng@sifive.com
References: <20240816010711.3055425-1-debug@rivosinc.com>
 <20240816010711.3055425-7-debug@rivosinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240816010711.3055425-7-debug@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 8/16/24 11:07, Deepak Gupta wrote:
> Implements setting lp expected when `jalr` is encountered and implements
> `lpad` instruction of zicfilp. `lpad` instruction is taken out of
> auipc x0, <imm_20>. This is an existing HINTNOP space. If `lpad` is
> target of an indirect branch, cpu checks for 20 bit value in x7 upper
> with 20 bit value embedded in `lpad`. If they don't match, cpu raises a
> sw check exception with tval = 2.
> 
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> Co-developed-by: Jim Shu <jim.shu@sifive.com>
> Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
> ---
>   target/riscv/cpu_user.h                 |  1 +
>   target/riscv/insn32.decode              |  5 ++-
>   target/riscv/insn_trans/trans_rvi.c.inc | 53 +++++++++++++++++++++++++
>   3 files changed, 58 insertions(+), 1 deletion(-)
> 
> diff --git a/target/riscv/cpu_user.h b/target/riscv/cpu_user.h
> index 02afad608b..e6927ff847 100644
> --- a/target/riscv/cpu_user.h
> +++ b/target/riscv/cpu_user.h
> @@ -15,5 +15,6 @@
>   #define xA6 16
>   #define xA7 17  /* syscall number for RVI ABI */
>   #define xT0 5   /* syscall number for RVE ABI */
> +#define xT2 7
>   
>   #endif
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index c45b8fa1d8..494b6cdcc6 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -123,7 +123,10 @@ sfence_vm   0001000    00100 ..... 000 00000 1110011 @sfence_vm
>   
>   # *** RV32I Base Instruction Set ***
>   lui      ....................       ..... 0110111 @u
> -auipc    ....................       ..... 0010111 @u
> +{
> +  lpad     label:20 00000 0010111
> +  auipc    ....................       ..... 0010111 @u

It's often helpful to align the fields.

   lpad     label:20                   00000 0010111
   auipc    ....................       ..... 0010111 @u


> +static bool trans_lpad(DisasContext *ctx, arg_lpad *a)
> +{
> +    bool lp_expected = ctx->fcfi_lp_expected;
> +    /*
> +     * If zicfilp not present, the encoding is a nop.
> +     * If forward cfi is not enabled, implementation is a nop.
> +     */
> +    if (!ctx->fcfi_enabled) {
> +        return true;
> +    }
> +
> +    if (ctx->base.pc_next == ctx->base.pc_first) {
> +        ctx->fcfi_lp_expected = false;
> +        /* If landing pad was expected, PC must be 4 byte aligned */
> +        if (lp_expected && ((ctx->base.pc_next) & 0x3)) {
> +            /*
> +             * misaligned, according to spec we should raise sw check exception
> +             */
> +            gen_helper_raise_sw_check_excep(tcg_env,
> +                tcg_constant_tl(RISCV_EXCP_SW_CHECK_FCFI_TVAL));
> +            return true;
> +        }
> +    }
> +
> +    /* if lp was expected and lpad_label non-zero, do label check */
> +    if (lp_expected && (a->label != 0)) {

This is over-complicated.

(1) lp_expected is true if and only if fcfi_enabled is true.
(2) if lp_expected is false, the implementation is a nop.

Therefore, just begin with

     if (!ctx->fcfi_lp_expected) {
         return true;
     }

and drop all other references to lp_expected.

(3) lp_expected is true if and only if ctx->base.pc_next == ctx->base.pc_first.
     Beyond the first instruction of the TranslationBlock, trans_lpad itself will
     clear lp_expected.  It cannot be set again except by ending a TranslationBlock.


> +    tcg_gen_st_tl(tcg_constant_tl(0), tcg_env,
> +                  offsetof(CPURISCVState, elp));

Incorrect: this stores to target_(u)long, whereas elp is a bool.
You need tcg_gen_st8_i32.

> +    if (ctx->fcfi_enabled) {
> +        /*
> +         * return from functions (i.e. rs1 == xRA || rs1 == xT0) are not
> +         * tracked. zicfilp introduces sw guarded branch as well. sw guarded
> +         * branch are not tracked. rs1 == xT2 is a sw guarded branch.
> +         */
> +        if (a->rs1 != xRA && a->rs1 != xT0 && a->rs1 != xT2) {
> +            tcg_gen_st_tl(tcg_constant_tl(1),
> +                          tcg_env, offsetof(CPURISCVState, elp));

Likewise.

You may wish to add a utility function to set elp.


r~

