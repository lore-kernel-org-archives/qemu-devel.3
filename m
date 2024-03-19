Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 298C0C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 13:31:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmZYc-0001us-2Q; Tue, 19 Mar 2024 09:31:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rmZYK-0001rE-9G
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 09:30:55 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rmZYI-00015c-GF
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 09:30:51 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-33ed7ef0ae8so1897103f8f.0
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 06:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710855048; x=1711459848; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GdltQKzqSsi7h7oD+tW5aVqxPCwN6NcQsTjsq0G+waI=;
 b=Z3M+s3cq2s4nmDTc38Ee+JasrMeC0VB9v7HiggwEi8Ug8NgL4V/mUxzyc0js0UQ0+u
 wma8/4tJS09h9UM4VIiT/XDzZx1EZBGyf9yXEZ0FBcep+0TMmYbVVCvPlJte1juj8AYD
 VqWg703ph/Zu/X3hKtHUFUXMHd/6Uz3H4wcxlQt3mltrn90KNJqTcYx4FN2iEiiHKJUO
 VrYE5iWLF7pBXsgiT1OuDFIVDoiwQoQgco5XoGT8VnKL09eE0TuG7UUTtQkq6Ava8+Mq
 hlhAiVmaDJ77havYjj6WtWCoazsvhuMyBcjStAQ2L1619EJWxgWlJa52lmip58ch7aab
 43uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710855048; x=1711459848;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GdltQKzqSsi7h7oD+tW5aVqxPCwN6NcQsTjsq0G+waI=;
 b=BHbnuqsCFoE60KA3JNiIlIkLoKAH2qiRaiC4Mt2j+loT1loXytE8VB3nSua/7HoTQe
 y/43NEgKlkOiULp4bt0AVWDZgGnIogZcQqlD/qnR7qJ9PkTGRjbkYadSyURQVT7cuZWt
 hTPNpC3MLd3E+K4/wpiNNKK5iKJsZPsKPM4XPidw1X6cjejUggySGU+dMPEXviE/ThM3
 zphlFnK4xGnfHKoRUCbva8QMpvqsyIDUefjyvb4mNgJlZDvvBb5KSZBRmX6ud2vovP18
 0vAPK/0o9jVKBM3Td94YiLdmRc6N+NrSdgTQGLOZwOxg+OQnil46Tr0WxHXSCF54R2VW
 Kjxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4evqxFcO1EsLK/YaX7qYm4YcvbBcSVQuKaZvlmZgBM3drlTsvtuh6xUuyGmNMpiIHWWrXbQoUwOETv1UlxVBwvaSC4LA=
X-Gm-Message-State: AOJu0YwOCwb+27RUHKB7judCexWO2n+yz+YQJKIQQ4bOdAn8Sl4IoeBv
 2lxPgU/MhNgVJstpXB+2Y2F1foKCXkkB0PQsqvz90oZX7h4K6LUIZ8/I5AaSLhbN93aB6vS+ovG
 uaao=
X-Google-Smtp-Source: AGHT+IGpc3C4h3DssHbyPFvZMU2XEIDMRTtSj2dXG5yCyAHF7tQeaEo1Z2Gk+GF4DRsNYx2fO4iO2g==
X-Received: by 2002:a5d:590b:0:b0:33e:7f67:5dd8 with SMTP id
 v11-20020a5d590b000000b0033e7f675dd8mr2080717wrd.54.1710855047700; 
 Tue, 19 Mar 2024 06:30:47 -0700 (PDT)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 dw11-20020a0560000dcb00b0033b66c2d61esm12316405wrb.48.2024.03.19.06.30.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 06:30:47 -0700 (PDT)
Message-ID: <d809c08b-0e9b-4c1e-b362-55ba51f1916d@linaro.org>
Date: Tue, 19 Mar 2024 17:30:46 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/22] plugins: Merge qemu_plugin_tb_insn_get to
 plugin-gen.c
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
References: <20240316015720.3661236-1-richard.henderson@linaro.org>
 <20240316015720.3661236-20-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240316015720.3661236-20-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wr1-x432.google.com
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
> Merge qemu_plugin_insn_alloc and qemu_plugin_tb_insn_get into
> plugin_gen_insn_start, since it is used nowhere else.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/qemu/plugin.h  | 39 ---------------------------------------
>   accel/tcg/plugin-gen.c | 39 ++++++++++++++++++++++++++++++++-------
>   2 files changed, 32 insertions(+), 46 deletions(-)
> 
> diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
> index 34498da717..07b1755990 100644
> --- a/include/qemu/plugin.h
> +++ b/include/qemu/plugin.h
> @@ -128,14 +128,6 @@ static inline void qemu_plugin_insn_cleanup_fn(gpointer data)
>       g_byte_array_free(insn->data, true);
>   }
>   
> -static inline struct qemu_plugin_insn *qemu_plugin_insn_alloc(void)
> -{
> -    struct qemu_plugin_insn *insn = g_new0(struct qemu_plugin_insn, 1);
> -
> -    insn->data = g_byte_array_sized_new(4);
> -    return insn;
> -}
> -
>   /* Internal context for this TranslationBlock */
>   struct qemu_plugin_tb {
>       GPtrArray *insns;
> @@ -152,37 +144,6 @@ struct qemu_plugin_tb {
>       GArray *cbs;
>   };
>   
> -/**
> - * qemu_plugin_tb_insn_get(): get next plugin record for translation.
> - * @tb: the internal tb context
> - * @pc: address of instruction
> - */
> -static inline
> -struct qemu_plugin_insn *qemu_plugin_tb_insn_get(struct qemu_plugin_tb *tb,
> -                                                 uint64_t pc)
> -{
> -    struct qemu_plugin_insn *insn;
> -
> -    if (unlikely(tb->n == tb->insns->len)) {
> -        struct qemu_plugin_insn *new_insn = qemu_plugin_insn_alloc();
> -        g_ptr_array_add(tb->insns, new_insn);
> -    }
> -
> -    insn = g_ptr_array_index(tb->insns, tb->n++);
> -    g_byte_array_set_size(insn->data, 0);
> -    insn->calls_helpers = false;
> -    insn->mem_helper = false;
> -    insn->vaddr = pc;
> -    if (insn->insn_cbs) {
> -        g_array_set_size(insn->insn_cbs, 0);
> -    }
> -    if (insn->mem_cbs) {
> -        g_array_set_size(insn->mem_cbs, 0);
> -    }
> -
> -    return insn;
> -}
> -
>   /**
>    * struct CPUPluginState - per-CPU state for plugins
>    * @event_mask: plugin event bitmap. Modified only via async work.
> diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
> index 28414c4ff1..70914c3bf8 100644
> --- a/accel/tcg/plugin-gen.c
> +++ b/accel/tcg/plugin-gen.c
> @@ -380,11 +380,34 @@ bool plugin_gen_tb_start(CPUState *cpu, const DisasContextBase *db,
>   void plugin_gen_insn_start(CPUState *cpu, const DisasContextBase *db)
>   {
>       struct qemu_plugin_tb *ptb = tcg_ctx->plugin_tb;
> -    struct qemu_plugin_insn *pinsn;
> +    struct qemu_plugin_insn *insn;
> +    size_t n = db->num_insns;
> +    vaddr pc;
>   
> -    pinsn = qemu_plugin_tb_insn_get(ptb, db->pc_next);
> -    tcg_ctx->plugin_insn = pinsn;
> -    plugin_gen_empty_callback(PLUGIN_GEN_FROM_INSN);
> +    assert(n >= 1);
> +    ptb->n = n;
> +    if (n <= ptb->insns->len) {
> +        insn = g_ptr_array_index(ptb->insns, n - 1);
> +        g_byte_array_set_size(insn->data, 0);
> +    } else {
> +        assert(n - 1 == ptb->insns->len);
> +        insn = g_new0(struct qemu_plugin_insn, 1);
> +        insn->data = g_byte_array_sized_new(4);
> +        g_ptr_array_add(ptb->insns, insn);
> +    }
> +
> +    tcg_ctx->plugin_insn = insn;
> +    insn->calls_helpers = false;
> +    insn->mem_helper = false;
> +    if (insn->insn_cbs) {
> +        g_array_set_size(insn->insn_cbs, 0);
> +    }
> +    if (insn->mem_cbs) {
> +        g_array_set_size(insn->mem_cbs, 0);
> +    }
> +
> +    pc = db->pc_next;
> +    insn->vaddr = pc;
>   
>       /*
>        * Detect page crossing to get the new host address.
> @@ -392,16 +415,18 @@ void plugin_gen_insn_start(CPUState *cpu, const DisasContextBase *db)
>        * fetching instructions from a region not backed by RAM.
>        */
>       if (ptb->haddr1 == NULL) {
> -        pinsn->haddr = NULL;
> +        insn->haddr = NULL;
>       } else if (is_same_page(db, db->pc_next)) {
> -        pinsn->haddr = ptb->haddr1 + pinsn->vaddr - ptb->vaddr;
> +        insn->haddr = ptb->haddr1 + pc - ptb->vaddr;
>       } else {
>           if (ptb->vaddr2 == -1) {
>               ptb->vaddr2 = TARGET_PAGE_ALIGN(db->pc_first);
>               get_page_addr_code_hostp(cpu_env(cpu), ptb->vaddr2, &ptb->haddr2);
>           }
> -        pinsn->haddr = ptb->haddr2 + pinsn->vaddr - ptb->vaddr2;
> +        insn->haddr = ptb->haddr2 + pc - ptb->vaddr2;
>       }
> +
> +    plugin_gen_empty_callback(PLUGIN_GEN_FROM_INSN);
>   }
>   
>   void plugin_gen_insn_end(void)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

