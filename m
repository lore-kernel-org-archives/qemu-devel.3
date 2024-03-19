Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16278C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 13:33:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmZaM-0003ZE-8b; Tue, 19 Mar 2024 09:32:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rmZaL-0003YL-CO
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 09:32:57 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rmZaJ-0001Vv-9f
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 09:32:57 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-513e25afabaso2979121e87.2
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 06:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710855173; x=1711459973; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fsBvvrqM00WWftJWOlKbmFrLIuby75/+RsN4sAl2i+8=;
 b=vlumG4IrLHkhS7jPkCSFM7yNSiKZ0Xlf40IOdWHVpY5c6YAflCUKZS/wpWuWNpJ0Ve
 +xANy34A81v6UINDckVoKbgG6WCFAKYgWvTmwkMJdrZsQSliFkKD/GADsr+nFHteUqVJ
 +OApJ7GS2Lh0nc75iboXa+p6TLr561F/vxBKndEYItczYycKyfl7CB38i5rvYdfZyc3o
 /JqNB9ng3rXbkGX2iymlxlglfRBc2RqZWqJMgS94MGu5Fdos7EEdAG0+GYI1UXgB9VgN
 DJMkdG3XOjj+lY5gWYK7JOzmVFB0nrLgkmOvAchX9qrM6WJ5E7fyiU1oevqPfVvfItSL
 q8fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710855173; x=1711459973;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fsBvvrqM00WWftJWOlKbmFrLIuby75/+RsN4sAl2i+8=;
 b=wOr/gKuWnOiOGC/J0GxWm4d9f50V+tuIWyiPNUWkN41dWB9wrE6W4FEcYfSbbxqUKb
 PMsDcKKtMLthLJn1NiysbZDWz2zZxTxsq0Q8LHBL6/e9lkGHyJIxP8DU/aaGa1r6+2qh
 feX88DyE1XeSt/+6LJ2nD30Q28WAtpbNksp0ABF45XZU7wUtfx8oVuX8d/ZsvD/smOCJ
 p6ewhwbJKOYs32pb60u4L6fqPq0jQgI+XaEhyzr6/3JZu2Ek3czliQ8t9GSTCJJjjzfA
 4vKFh1nw9Oky7Lin3x/h7dyzWHWrw6iiQ4z0/ptKDm++4tkkyRpsZo6TtUmUXKUPZY7d
 7H2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXh4bMeWkCDDF3UemU9OQSAGIlxmVMInIG/pPNYzPokXIGmE6GNU8jfX0e364PEr5sL9AIxcEBdggY91QxM2mx/CMgQkUw=
X-Gm-Message-State: AOJu0YyQ620TTKFvca/lY62lsfaLSK+zVoAe4VldKynIWxHgBeTjMCgl
 /ql9wxd4Ya6g+GBxXj9kDNFxNy4XC/EZ08JBPu1fprTzHH+lVwBXDQ4GgGRShH8=
X-Google-Smtp-Source: AGHT+IGigG/uMM+3Ob59pXMHEp63HF7b34LJx2kneJE6j5heFfrE+kQjqLT1zBndpCTmtwgQ1AXQwg==
X-Received: by 2002:a19:914e:0:b0:513:93dd:9ecd with SMTP id
 y14-20020a19914e000000b0051393dd9ecdmr9490702lfj.21.1710855172962; 
 Tue, 19 Mar 2024 06:32:52 -0700 (PDT)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 o18-20020a05600c4fd200b004140bece5d1sm8844879wmq.8.2024.03.19.06.32.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 06:32:52 -0700 (PDT)
Message-ID: <5b9ff51d-439f-4e65-acb5-909bdfaf350c@linaro.org>
Date: Tue, 19 Mar 2024 17:32:49 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/22] plugins: Use emit_before_op for
 PLUGIN_GEN_AFTER_INSN
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
References: <20240316015720.3661236-1-richard.henderson@linaro.org>
 <20240316015720.3661236-8-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240316015720.3661236-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-lf1-x131.google.com
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

On 3/16/24 05:57, Richard Henderson wrote:
> Introduce a new plugin_cb op and migrate one operation.
> By using emit_before_op, we do not need to emit opcodes
> early and modify them later -- we can simply emit the
> final set of opcodes once.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h |  1 +
>   include/tcg/tcg-opc.h       |  1 +
>   accel/tcg/plugin-gen.c      | 74 +++++++++++++++++++++----------------
>   tcg/tcg-op.c                |  5 +++
>   4 files changed, 50 insertions(+), 31 deletions(-)
> 
> diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
> index 2d932a515e..9de5a7f280 100644
> --- a/include/tcg/tcg-op-common.h
> +++ b/include/tcg/tcg-op-common.h
> @@ -74,6 +74,7 @@ void tcg_gen_goto_tb(unsigned idx);
>    */
>   void tcg_gen_lookup_and_goto_ptr(void);
>   
> +void tcg_gen_plugin_cb(unsigned from);
>   void tcg_gen_plugin_cb_start(unsigned from, unsigned type, unsigned wr);
>   void tcg_gen_plugin_cb_end(void);
>   
> diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
> index b80227fa1c..3b7cb2bce1 100644
> --- a/include/tcg/tcg-opc.h
> +++ b/include/tcg/tcg-opc.h
> @@ -197,6 +197,7 @@ DEF(exit_tb, 0, 0, 1, TCG_OPF_BB_EXIT | TCG_OPF_BB_END)
>   DEF(goto_tb, 0, 0, 1, TCG_OPF_BB_EXIT | TCG_OPF_BB_END)
>   DEF(goto_ptr, 0, 1, 0, TCG_OPF_BB_EXIT | TCG_OPF_BB_END)
>   
> +DEF(plugin_cb, 0, 0, 1, TCG_OPF_NOT_PRESENT)
>   DEF(plugin_cb_start, 0, 0, 3, TCG_OPF_NOT_PRESENT)
>   DEF(plugin_cb_end, 0, 0, 0, TCG_OPF_NOT_PRESENT)
>   
> diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
> index c56f104aee..8fa342b425 100644
> --- a/accel/tcg/plugin-gen.c
> +++ b/accel/tcg/plugin-gen.c
> @@ -207,8 +207,7 @@ static void plugin_gen_empty_callback(enum plugin_gen_from from)
>   {
>       switch (from) {
>       case PLUGIN_GEN_AFTER_INSN:
> -        gen_wrapped(from, PLUGIN_GEN_DISABLE_MEM_HELPER,
> -                    gen_empty_mem_helper);
> +        tcg_gen_plugin_cb(from);
>           break;
>       case PLUGIN_GEN_FROM_INSN:
>           /*
> @@ -614,16 +613,6 @@ static void inject_mem_enable_helper(struct qemu_plugin_tb *ptb,
>       inject_mem_helper(begin_op, arr);
>   }
>   
> -static void inject_mem_disable_helper(struct qemu_plugin_insn *plugin_insn,
> -                                      TCGOp *begin_op)
> -{
> -    if (likely(!plugin_insn->mem_helper)) {
> -        rm_ops(begin_op);
> -        return;
> -    }
> -    inject_mem_helper(begin_op, NULL);
> -}
> -
>   /* called before finishing a TB with exit_tb, goto_tb or goto_ptr */
>   void plugin_gen_disable_mem_helpers(void)
>   {
> @@ -709,11 +698,14 @@ static void plugin_gen_enable_mem_helper(struct qemu_plugin_tb *ptb,
>       inject_mem_enable_helper(ptb, insn, begin_op);
>   }
>   
> -static void plugin_gen_disable_mem_helper(struct qemu_plugin_tb *ptb,
> -                                          TCGOp *begin_op, int insn_idx)
> +static void gen_disable_mem_helper(struct qemu_plugin_tb *ptb,
> +                                   struct qemu_plugin_insn *insn)
>   {
> -    struct qemu_plugin_insn *insn = g_ptr_array_index(ptb->insns, insn_idx);
> -    inject_mem_disable_helper(insn, begin_op);
> +    if (insn->mem_helper) {
> +        tcg_gen_st_ptr(tcg_constant_ptr(0), tcg_env,
> +                       offsetof(CPUState, plugin_mem_cbs) -
> +                       offsetof(ArchCPU, env));
> +    }
>   }
>   
>   /* #define DEBUG_PLUGIN_GEN_OPS */
> @@ -772,16 +764,49 @@ static void pr_ops(void)
>   
>   static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
>   {
> -    TCGOp *op;
> +    TCGOp *op, *next;
>       int insn_idx = -1;
>   
>       pr_ops();
>   
> -    QTAILQ_FOREACH(op, &tcg_ctx->ops, link) {
> +    /*
> +     * While injecting code, we cannot afford to reuse any ebb temps
> +     * that might be live within the existing opcode stream.
> +     * The simplest solution is to release them all and create new.
> +     */
> +    memset(tcg_ctx->free_temps, 0, sizeof(tcg_ctx->free_temps));
> +

Not an expert at this, but wouldn't that break an existing TB that 
already has some ops on those temps?

> +    QTAILQ_FOREACH_SAFE(op, &tcg_ctx->ops, link, next) {
>           switch (op->opc) {
>           case INDEX_op_insn_start:
>               insn_idx++;
>               break;
> +
> +        case INDEX_op_plugin_cb:
> +        {
> +            enum plugin_gen_from from = op->args[0];
> +            struct qemu_plugin_insn *insn = NULL;
> +
> +            if (insn_idx >= 0) {
> +                insn = g_ptr_array_index(plugin_tb->insns, insn_idx);
> +            }
> +
> +            tcg_ctx->emit_before_op = op;
> +
> +            switch (from) {
> +            case PLUGIN_GEN_AFTER_INSN:
> +                assert(insn != NULL);
> +                gen_disable_mem_helper(plugin_tb, insn);
> +                break;
> +            default:
> +                g_assert_not_reached();
> +            }
> +
> +            tcg_ctx->emit_before_op = NULL;
> +            tcg_op_remove(tcg_ctx, op);
> +            break;
> +        }
> +
>           case INDEX_op_plugin_cb_start:
>           {
>               enum plugin_gen_from from = op->args[0];
> @@ -846,19 +871,6 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
>   
>                   break;
>               }
> -            case PLUGIN_GEN_AFTER_INSN:
> -            {
> -                g_assert(insn_idx >= 0);
> -
> -                switch (type) {
> -                case PLUGIN_GEN_DISABLE_MEM_HELPER:
> -                    plugin_gen_disable_mem_helper(plugin_tb, op, insn_idx);
> -                    break;
> -                default:
> -                    g_assert_not_reached();
> -                }
> -                break;
> -            }
>               default:
>                   g_assert_not_reached();
>               }
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index aa6bc6f57d..0f2026c91c 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -312,6 +312,11 @@ void tcg_gen_mb(TCGBar mb_type)
>       }
>   }
>   
> +void tcg_gen_plugin_cb(unsigned from)
> +{
> +    tcg_gen_op1(INDEX_op_plugin_cb, from);
> +}
> +
>   void tcg_gen_plugin_cb_start(unsigned from, unsigned type, unsigned wr)
>   {
>       tcg_gen_op3(INDEX_op_plugin_cb_start, from, type, wr);

