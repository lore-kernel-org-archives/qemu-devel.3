Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5623C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 19:57:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1X7L-000883-PC; Mon, 29 Apr 2024 15:56:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1s1X7J-000878-OL
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 15:56:49 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1s1X7H-0004BU-RR
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 15:56:49 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1e4266673bbso43948715ad.2
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 12:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714420603; x=1715025403; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DrQA2MTMtgoMWDwdbUXLW0Cputh5Kj+19Bd9jAjMVSE=;
 b=uBTZrTQmjOAIXbrLbZR7my6kULJEDQJJnwI4CIZlBGny6YEuuIJTo4vpyjKBcGjWSg
 ONDalXnD4VFPKBq0ZFneNBunKNtCR9qM4Vpk0kj7zjQFYrWuYXGLJNoTgYQWOnkPDlqT
 kEsEbiLfRiDXhfSKL1H2tyUdrf7MvUdDhcNTnr6qfhWkXTSo1fdeYPekUvskH3ellgbp
 WsGw1+MzcMxAyNOzqLceADzBEFOmtz8WUhRxgyZNUP2WKVl/vLWhxmA9XrWJG57cWkwy
 nwGfxZaTnvQDTmjI9ZEfxu8fZFxijKAxL6Kek36+54t51QAHHipepjZuwt0PD9Uwpg9f
 YoQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714420603; x=1715025403;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DrQA2MTMtgoMWDwdbUXLW0Cputh5Kj+19Bd9jAjMVSE=;
 b=nOKfzgxrcFmJZz7SBux6wG4qeSpDTxTpl7d4MgOoUTJNW025QG037IuIx/tes70aN/
 eRCcyHaik+OxWedUONI4uhMft2pImpiJHtjBbL48azhoiXwZlw11UFEFj7GzloPC2nM+
 vZuNmcAdKrQcEU2MECDPy5Drxo0hyzcydgaGRAWa4eQWSver+3l/F2ORQNrvvraNuTlq
 eWZ/bN6WEZBOwV67WmsCVvS9xXXFcEhACyrAxSw3u6f8VS+fnhUzfRefy6ZD2lS/uMnp
 gycMKuiP8IzOMW4WeGh8loFeCddVx5L1Thh8Q7laoFEBMSWvrG+/GFSGi5dQw6P7KdrW
 ZYWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpzMtJT1huyymkdgjE5EwKSzeCSobyayikmAY8Z6wfhNyKZiMtJuFT2P0SrqMJf6gecBgqcApRWqzWWLevxuBvefY8BSw=
X-Gm-Message-State: AOJu0YzVofNcVqYun8aFEnqIDDQNqMtt7+xKJa6F7Al0m0bb2+Jtib9i
 32crSjgsPFVKxdHHsRHGVOV+cpIVU1qaLNF9AG3cYvYqZyU+1hU7Dqu2zMwdthE=
X-Google-Smtp-Source: AGHT+IF4IKv7jnZb2rDsQ3ZLAqxun5o25naKtLwg2FSPvCQIcgOXmkU3f7L6HaPEWEEr2dGNbNaGdQ==
X-Received: by 2002:a17:902:da8a:b0:1e8:813f:4009 with SMTP id
 j10-20020a170902da8a00b001e8813f4009mr13527390plx.14.1714420603519; 
 Mon, 29 Apr 2024 12:56:43 -0700 (PDT)
Received: from ?IPV6:2604:3d08:937d:c610::abdb? ([2604:3d08:937d:c610::abdb])
 by smtp.gmail.com with ESMTPSA id
 f15-20020a170902ce8f00b001eb61a4a2c1sm4702758plg.46.2024.04.29.12.56.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 12:56:43 -0700 (PDT)
Message-ID: <bb07e478-ba62-4a73-a6c3-6adc9e9197a2@linaro.org>
Date: Mon, 29 Apr 2024 12:56:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/20] plugins: Use emit_before_op for
 PLUGIN_GEN_AFTER_INSN
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240424230224.941028-1-richard.henderson@linaro.org>
 <20240424230224.941028-7-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240424230224.941028-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

On 4/24/24 16:02, Richard Henderson wrote:
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
> index 4b488943ff..4b02c0bfbf 100644
> --- a/accel/tcg/plugin-gen.c
> +++ b/accel/tcg/plugin-gen.c
> @@ -201,8 +201,7 @@ static void plugin_gen_empty_callback(enum plugin_gen_from from)
>   {
>       switch (from) {
>       case PLUGIN_GEN_AFTER_INSN:
> -        gen_wrapped(from, PLUGIN_GEN_DISABLE_MEM_HELPER,
> -                    gen_empty_mem_helper);
> +        tcg_gen_plugin_cb(from);
>           break;
>       case PLUGIN_GEN_FROM_INSN:
>           /*
> @@ -608,16 +607,6 @@ static void inject_mem_enable_helper(struct qemu_plugin_tb *ptb,
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
> @@ -703,11 +692,14 @@ static void plugin_gen_enable_mem_helper(struct qemu_plugin_tb *ptb,
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
> @@ -766,16 +758,49 @@ static void pr_ops(void)
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
> @@ -840,19 +865,6 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

