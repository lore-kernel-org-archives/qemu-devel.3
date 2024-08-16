Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D65E2C531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 03:43:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1senqt-0002Cy-T6; Thu, 15 Aug 2024 23:42:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1senqs-0002C4-0I
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 23:42:10 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1senqp-0007uN-W9
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 23:42:09 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-201fae21398so7262155ad.1
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 20:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723779726; x=1724384526; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kbnaXv0iGc/Nio7+hi+eXPRuS8fR6gs42uJMkQONDDE=;
 b=HzJJs4Sm/gWHNy930qCOqlVVXY5VwN+tv3eahLtQtJhKT0iTPlmli7L3W5hrGe6fUk
 NOLi6A6h3Z2+7+JeRRXdlclP4GSWFB+9ARXf1GfY12fEmErUsxo74/6UOl1cC2Nv857J
 Jorwp/YqdiAJz9AXhPvP5qjaZNkKzzkgYwv9PceoAoeqklh1yiGKM6e6kac6zwkp7bRR
 YOpiunIAMZTPiwXndzxx2HI694FS+givjkq4gakd/Xs+coNFnuU5CksNZvvYghjyZEZa
 B2YH+6mNsIGo0ZAhN93du3wQN8Z8K5xfuB8ZCYH0242aiAeMWzQFJFeERrhNBtpArnpM
 Tr2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723779726; x=1724384526;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kbnaXv0iGc/Nio7+hi+eXPRuS8fR6gs42uJMkQONDDE=;
 b=wAuT+bRb4EEEv2VFHxxyV3/qnmOSH3jUkj0UgAWPMm/h/U2zcU33bRGsB91QWfOyYv
 DIeZ9kxtSQMBoje6IiaUYj+HI1rydmZDGZjDDHfl6EKUZ26FwY6JBZ6jTesf+MQP2T7i
 H8s2NjO887eJP5FlVPvNrtGsDfgyJkLERmMs/9cW/DiiIBLXnOAOCx90CB/uk79/AXAi
 7uiN8n/TBP+jcWMWh2IVm9ECzrk4Fz9zsZnEMouTNHHr/lwqDnQMf3XPRyjTTIUqkgyI
 Vve1/hvs3KZCTaRsCW5lNL7hcwpLZ6p/2fnJOtpZBjsegl2pXbWkycbgKk/lM9LuCiWn
 64qA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtMXGyCI5cuT6UDWj86sSuAc5+NUqKCYN+sPWPbTrsJ50bMhjP2PqUkJBsaw17/A9WpXtEp70J8EvMYgbn3j4IjPcA2nU=
X-Gm-Message-State: AOJu0YziWNugIyEYaGkpZO4FZOhPd7DOlCbhS4q+rUcWACNCbQ5C+9+5
 JwVx+ZZcxsJ5PG+IfvnmmV6xoLPhQffrHxkEsNaXpgFg3z2Kfz2Jc68GMvHe1ms=
X-Google-Smtp-Source: AGHT+IG2DYtVJg68EHAqyfxngRDM/0mIoowBrKQpj30/evElx8H1S2tJZvko8z/O7mAZDyGtDO/obw==
X-Received: by 2002:a17:902:ced2:b0:201:eed3:80dd with SMTP id
 d9443c01a7336-20204062fc9mr23563135ad.65.1723779725496; 
 Thu, 15 Aug 2024 20:42:05 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:d09c:46ba:97a2:4a99?
 (2403-580a-f89b-0-d09c-46ba-97a2-4a99.ip6.aussiebb.net.
 [2403:580a:f89b:0:d09c:46ba:97a2:4a99])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f02fb44dsm17045125ad.52.2024.08.15.20.41.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Aug 2024 20:42:05 -0700 (PDT)
Message-ID: <2c1039b4-a865-458a-831c-7e66b6287a98@linaro.org>
Date: Fri, 16 Aug 2024 13:41:51 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/16] target/riscv: tracking indirect branches (fcfi)
 for zicfilp
To: Deepak Gupta <debug@rivosinc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, pbonzini@redhat.com, jim.shu@sifive.com,
 andy.chiu@sifive.com, kito.cheng@sifive.com
References: <20240816010711.3055425-1-debug@rivosinc.com>
 <20240816010711.3055425-6-debug@rivosinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240816010711.3055425-6-debug@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 8/16/24 11:06, Deepak Gupta wrote:
> @@ -1245,6 +1250,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
>   
>   static void riscv_tr_tb_start(DisasContextBase *db, CPUState *cpu)
>   {
> +
>   }

Watch the unrelated changes.

> @@ -1266,6 +1272,28 @@ static void riscv_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
>       CPURISCVState *env = cpu_env(cpu);
>       uint16_t opcode16 = translator_lduw(env, &ctx->base, ctx->base.pc_next);
>   
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
> +        tcg_ctx->cfi_lp_check = tcg_last_op();
> +        tcg_gen_brcondi_i32(TCG_COND_EQ, immediate, 0, l);
> +        gen_helper_raise_sw_check_excep(tcg_env,
> +                tcg_constant_tl(RISCV_EXCP_SW_CHECK_FCFI_TVAL));
> +        gen_set_label(l);
> +    }
> +

I think this is over-complicated.

>       ctx->ol = ctx->xl;
>       decode_opc(env, ctx, opcode16);
>       ctx->base.pc_next += ctx->cur_insn_len;

If we delay the check until here, then

(1) we've decoded the opcode, and processed lpad or not.
(2) we can know that lpad will have cleared ctx->fcfi_lp_expected,
     so that if it is still set here, then we didn't see an lpad.

We can go back an insert the exception like so:

     if (ctx->fcfi_lp_expected) {
         /* Emit after insn_start, i.e. before the op following insn_start. */
         tcg_ctx->emit_before_op = QTAILQ_NEXT(ctx->base.insn_start, link);

         tcg_gen_st_tl(tcg_constant_tl(RISCV_EXCP_SW_CHECK_FCFI_TVAL),
                       tcg_env, offsetof(CPURISCVState, sw_check_code));
         gen_helper_raise_exception(tcg_env, tcg_constant_i32(RISCV_EXCP_SW_CHECK));

         tcg_ctx->emit_before_op = NULL;
         ctx->base.is_jmp = DISAS_NORETURN;
     }

Emit the store to sw_check_code directly; no need for an extra helper. Using 
gen_helper_raise_exception instead of generate_exception means we don't get a spurious pc 
update.


r~

