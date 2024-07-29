Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6207C3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 02:34:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYcgo-0006vF-Kf; Mon, 29 Jul 2024 22:34:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYcgm-0006lZ-9S
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 22:34:12 -0400
Received: from mail-yb1-xb2f.google.com ([2607:f8b0:4864:20::b2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYcgk-0000bl-J8
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 22:34:12 -0400
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e05ef3aefcfso2737150276.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 19:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722306846; x=1722911646; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jVzlYxv6LNLOd2oE/sywmWSa7LfLB6Y6611FxPpDnIs=;
 b=h02XKeCGlWojK0gGFK6dAJ0x3Remz5F8Cy3B7JwOgbuNPpPIigLlxqBTjqAUoOwB5c
 +pc4O7AWkpzORFebBlPiUSJMQyvc6UEBKgYYuVwcQBNGVJTsT9zq1l2hRjLb+aY7C2A7
 ptYDa8UKP9DVkP3QMyLONZArIzlPMLGMdxOBotAKbM7RBolRO7zrpCsN1+Fmv7bpL76F
 UwSW044qoJqYT7O8xtptZD2BPv4oW1uIYCV/13lV6t1Qk7b/kfLCCZzLF7q+S+ToTNQv
 XnLvHF8KNplBdluZzfGtecyuMlfCjBZQHqEsWRRW1zvQHqwKUeReA5FwOirzaw8K+jgM
 pMxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722306846; x=1722911646;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jVzlYxv6LNLOd2oE/sywmWSa7LfLB6Y6611FxPpDnIs=;
 b=WuBFNoCJ8aiGN+RTeFgkkZVfL+DCU9QHIor2tkaA70PEGztb7aw+wh2+fEkPrPP/pc
 LAmP6hxj2YXg/l7n92EMgv7e1wTGslz9zSOPgc4VsDEdJTuYkwkfAN9TsYDm30eZK89u
 kU1j4wDUCMkZKXmont2bJPrfjJIdjVode9T54GH6ZXHzLL7I43rqVAqUtOz0DxH4zha4
 /P9kM9AMxnZYkllYKhNNR98ts5ukY7onh1NR9n+R853suYTSpGPgd5MZc7xY6hh3l1j4
 n0vOCPLSKidwPCwhShEZQ5Y7QodNsglMzOtXFdRLl1VFQQpFrBt6WpiJS3fzAaMxPkCd
 17bA==
X-Gm-Message-State: AOJu0YxC6RYP044uCJ9PEhpVtZBX0as728ILi8WqPoxXo5tdnR46/wLk
 kqRblr+n763kYFH8fkO5uh9+p6+356TYDl4UHrtbG6wisFGDvJCgObjxAjKbCa+TlwY7pTstHFk
 J8g4=
X-Google-Smtp-Source: AGHT+IGCc/vRFKlFHwPhsN0IidspOybaCNA8ykIHQpfo/V81UtxpEYEetQ4sIPrNjpw3BAuv3QPz4g==
X-Received: by 2002:a17:90a:750:b0:2c9:64fb:1c7e with SMTP id
 98e67ed59e1d1-2cf7e1c0e3emr7708086a91.14.1722294921883; 
 Mon, 29 Jul 2024 16:15:21 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c5635esm9191168a91.4.2024.07.29.16.15.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jul 2024 16:15:21 -0700 (PDT)
Message-ID: <ed23bcbc-fdc4-4492-803c-daa95880375a@linaro.org>
Date: Tue, 30 Jul 2024 09:15:16 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/24] target/riscv: tracking indirect branches (fcfi)
 for zicfilp
To: qemu-devel@nongnu.org
References: <20240729175327.73705-1-debug@rivosinc.com>
 <20240729175327.73705-6-debug@rivosinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240729175327.73705-6-debug@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-yb1-xb2f.google.com
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

On 7/30/24 03:53, Deepak Gupta wrote:
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index acba90f170..c746d7df08 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -20,6 +20,7 @@
>   #include "qemu/log.h"
>   #include "cpu.h"
>   #include "tcg/tcg-op.h"
> +#include "tcg/tcg-temp-internal.h"

No, this is internal to tcg, as the filename says.


>   #include "exec/exec-all.h"
>   #include "exec/helper-proto.h"
>   #include "exec/helper-gen.h"
> @@ -44,6 +45,7 @@ static TCGv load_val;
>   /* globals for PM CSRs */
>   static TCGv pm_mask;
>   static TCGv pm_base;
> +static TCGOp *cfi_lp_check;
>   
>   /*
>    * If an operation is being performed on less than TARGET_LONG_BITS,
> @@ -116,6 +118,9 @@ typedef struct DisasContext {
>       bool frm_valid;
>       bool insn_start_updated;
>       const GPtrArray *decoders;
> +    /* zicfilp extension. cfi enabled or not. lp expected or not */
> +    bool fcfi_enabled;
> +    bool fcfi_lp_expected;
>   } DisasContext;
>   
>   static inline bool has_ext(DisasContext *ctx, uint32_t ext)
> @@ -1238,6 +1243,8 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
>       ctx->pm_base_enabled = FIELD_EX32(tb_flags, TB_FLAGS, PM_BASE_ENABLED);
>       ctx->ztso = cpu->cfg.ext_ztso;
>       ctx->itrigger = FIELD_EX32(tb_flags, TB_FLAGS, ITRIGGER);
> +    ctx->fcfi_lp_expected = FIELD_EX32(tb_flags, TB_FLAGS, FCFI_LP_EXPECTED);
> +    ctx->fcfi_enabled = cpu_get_fcfien(env) && ctx->fcfi_lp_expected;

This is incorrect.  You cannot check fcfien like this here; you must place it in a tb flag 
like "lp_expected".


> @@ -1245,6 +1252,39 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
>   
>   static void riscv_tr_tb_start(DisasContextBase *db, CPUState *cpu)
>   {
> +    DisasContext *ctx = container_of(db, DisasContext, base);
> +
> +    if (ctx->fcfi_lp_expected) {
> +        /*
> +         * Since we can't look ahead to confirm that the first
> +         * instruction is a legal landing pad instruction, emit
> +         * compare-and-branch sequence that will be fixed-up in
> +         * riscv_tr_tb_stop() to either statically hit or skip an
> +         * illegal instruction exception depending on whether the
> +         * flag was lowered by translation of a CJLP or JLP as
> +         * the first instruction in the block.
> +         */
> +        TCGv_i32 immediate;
> +        TCGLabel *l;
> +        l = gen_new_label();
> +        immediate = tcg_temp_new_i32();
> +        tcg_gen_movi_i32(immediate, 0);
> +        cfi_lp_check = tcg_last_op();
> +        tcg_gen_brcondi_i32(TCG_COND_EQ, immediate, 0, l);
> +        tcg_temp_free_i32(immediate);
> +        tcg_gen_st_tl(
> +            tcg_constant_tl(RISCV_EXCP_SW_CHECK_FCFI_TVAL),
> +            tcg_env, offsetof(CPURISCVState, sw_check_code));
> +        generate_exception(ctx, RISCV_EXCP_SW_CHECK);
> +        gen_set_label(l);
> +        /*
> +         * Despite the use of gen_exception_illegal(), the rest of
> +         * the TB needs to be generated. The TCG optimizer will
> +         * clean things up depending on which path ends up being
> +         * active.
> +         */
> +        ctx->base.is_jmp = DISAS_NEXT;
> +    }
>   }

Better to simply delay the check to the first insn load.
See aarch64_tr_translate_insn, dc_isar_feature(aa64_bti, s).


r~

