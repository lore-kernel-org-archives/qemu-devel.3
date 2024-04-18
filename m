Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F79CC04FFE
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 17:56:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxVzH-0001zg-D4; Thu, 18 Apr 2024 13:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rxVzA-0001m2-G9
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 13:55:50 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rxVz8-0008Uo-Po
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 13:55:48 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1e2b1cd446fso9682315ad.3
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 10:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713462945; x=1714067745; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z6/dF8KLjxAIi2nD4tbxIDVTEKIvgpgdZ72JPUUFEwU=;
 b=WfOLs5MAjiJgNak3tOm+5wKCHeJFKronb8eHljBQSFF1QP6UzaThlq1/t5M8KKLIju
 +j8aQGKX3gezZkzRjVgihAkZEvIQ4dWS1iKbdh8brHWsKBP4CensoIWeNtHCT4VRyigu
 /i0WU/jqRjZ8XMsGxF3ZXt/m8r8KNhi218x6UC2wnTVhcRk6voElwf6fXsBstbCPJJZo
 dy1/S6Y1okvvxt30OTALYzZf8+VGp5Xt9UWfLj8Ol8GWOHSG634UiWBVuTjvmLf18CuT
 txHZsM32MMc2XTRuuH333OaDqm96XE1DpLjR+VtS0DZF+TdlDa/lQB8+EfEfmuGLUNRD
 NjRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713462945; x=1714067745;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z6/dF8KLjxAIi2nD4tbxIDVTEKIvgpgdZ72JPUUFEwU=;
 b=NCmAcDJME1p5kuhZKBTRnrgqxHHghnP/YFzqbQ1Uw1Lu8c2euwDorUHWez0SlQ2a3T
 oByUE5+f3sQ2EbbPG1ePMufTPLrgM1oOIkYeIr4qdk+oYyatdn24DimQ0kO3Q3vPaijn
 IHc2NXmZ2lkQUgBxQp3SBxB2JJcC2bsbX90keaZz4bsnmjqFgnOGptBV/bqRg9RJzZQB
 rPncuX4kvLw+V8gr/fFgZKFunCfh6wOZP1PoZVcJTyCLDMRzb0vdcCC0kc3yGGAFBc6w
 2M95bPPVrXqXFhnNCChOtKaClO7DDuTb04WG56IdMW+nmUw6vCQFvSQHq4NozjIyq/MX
 XBcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsMDswkPmlqbr1sIe7CxRsohReQgo6xo9T85oTo5LYnJAzyEf8kCUq1UW5Po0XRX0+a69SoA3B9wC7e56c7+kmn0P/6eE=
X-Gm-Message-State: AOJu0YwrvM0bvJNZCImnNelE/rVEdAH3yFgXe3Rv9T7FNSqCL0w74ZWq
 /XdiuT7CfD5AlzPwi/oVhqP8ZTGSbwHo7gW2RnciGBpUVjczX3oLQ3O390lKLmCmns9EHUwymK0
 C+sE=
X-Google-Smtp-Source: AGHT+IFbuuYfQNDZPYsnMWcGkh1KV7uZKbFKs9s23Fe+RAljSPGG5hYoqp5PPqLFlcxkscC5gAIAfw==
X-Received: by 2002:a17:902:9a0b:b0:1e2:ac38:2674 with SMTP id
 v11-20020a1709029a0b00b001e2ac382674mr3403514plp.46.1713462945402; 
 Thu, 18 Apr 2024 10:55:45 -0700 (PDT)
Received: from ?IPV6:2604:3d08:937d:c610::fc11? ([2604:3d08:937d:c610::fc11])
 by smtp.gmail.com with ESMTPSA id
 mi8-20020a170902fcc800b001e294f2f30dsm1810462plb.93.2024.04.18.10.55.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Apr 2024 10:55:44 -0700 (PDT)
Message-ID: <42f5f982-30b4-4667-b143-d486e2f4d433@linaro.org>
Date: Thu, 18 Apr 2024 10:55:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] plugins: Introduce TCGCPUOps callbacks for mid-tb
 register reads
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240416040609.1313605-1-richard.henderson@linaro.org>
 <20240416040609.1313605-5-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240416040609.1313605-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

On 4/15/24 21:06, Richard Henderson wrote:
> Certain target registers are not updated continuously within
> the translation block.  For normal exception handling we use
> unwind info to re-generate the correct value when required.
> Leverage that same info for reading those registers for plugins.
> 
> All targets will need updating for these new callbacks.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/hw/core/tcg-cpu-ops.h | 13 +++++++++++++
>   plugins/api.c                 | 36 +++++++++++++++++++++++++++++++++--
>   2 files changed, 47 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/core/tcg-cpu-ops.h b/include/hw/core/tcg-cpu-ops.h
> index bf8ff8e3ee..e954d83edf 100644
> --- a/include/hw/core/tcg-cpu-ops.h
> +++ b/include/hw/core/tcg-cpu-ops.h
> @@ -49,6 +49,19 @@ struct TCGCPUOps {
>       /** @debug_excp_handler: Callback for handling debug exceptions */
>       void (*debug_excp_handler)(CPUState *cpu);
>   
> +    /**
> +     * @plugin_need_unwind_for_reg:
> +     * True if unwind info needed for reading reg.
> +     */
> +    bool (*plugin_need_unwind_for_reg)(CPUState *cpu, int reg);
> +    /**
> +     * @plugin_unwind_read_reg:
> +     * Like CPUClass.gdb_read_register, but for registers that require
> +     * regeneration using unwind info, like in @restore_state_to_opc.
> +     */
> +    int (*plugin_unwind_read_reg)(CPUState *cpu, GByteArray *buf, int reg,
> +                                  const TranslationBlock *tb,
> +                                  const uint64_t *data);
>   #ifdef NEED_CPU_H
>   #ifdef CONFIG_USER_ONLY
>       /**
> diff --git a/plugins/api.c b/plugins/api.c
> index 3912c9cc8f..3543647a89 100644
> --- a/plugins/api.c
> +++ b/plugins/api.c
> @@ -40,10 +40,12 @@
>   #include "qemu/plugin.h"
>   #include "qemu/log.h"
>   #include "tcg/tcg.h"
> +#include "tcg/insn-start-words.h"
>   #include "exec/exec-all.h"
>   #include "exec/gdbstub.h"
>   #include "exec/ram_addr.h"
>   #include "disas/disas.h"
> +#include "hw/core/tcg-cpu-ops.h"
>   #include "plugin.h"
>   #ifndef CONFIG_USER_ONLY
>   #include "qemu/plugin-memory.h"
> @@ -454,9 +456,39 @@ GArray *qemu_plugin_get_registers(void)
>   
>   int qemu_plugin_read_register(struct qemu_plugin_register *reg, GByteArray *buf)
>   {
> -    g_assert(current_cpu);
> +    CPUState *cs;
> +    uintptr_t ra;
> +    int regno;
>   
> -    return gdb_read_register(current_cpu, buf, GPOINTER_TO_INT(reg));
> +    assert(current_cpu);
> +    cs = current_cpu;
> +    ra = cs->neg.plugin_ra;
> +    regno = GPOINTER_TO_INT(reg);
> +
> +    /*
> +     * When plugin_ra is 0, we have no unwind info.  This will be true for
> +     * TB callbacks that happen before any insns of the TB have started.
> +     */
> +    if (ra) {
> +        const TCGCPUOps *tcg_ops = cs->cc->tcg_ops;
> +
> +        /*
> +         * For plugins in the middle of the TB, we may need to locate
> +         * and use unwind data to reconstruct a register value.
> +         * Usually this required for the PC, but there may be others.
> +         */
> +        if (tcg_ops->plugin_need_unwind_for_reg &&
> +            tcg_ops->plugin_need_unwind_for_reg(cs, regno)) {
> +            uint64_t data[TARGET_INSN_START_WORDS];
> +            const TranslationBlock *tb;
> +
> +            tb = cpu_unwind_state_data(cs, ra, data);
> +            assert(tb);
> +            return tcg_ops->plugin_unwind_read_reg(cs, buf, regno, tb, data);
> +        }
> +    }
> +
> +    return gdb_read_register(cs, buf, regno);
>   }
>   
>   struct qemu_plugin_scoreboard *qemu_plugin_scoreboard_new(size_t element_size)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

