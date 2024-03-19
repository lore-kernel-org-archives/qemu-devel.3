Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0DB4C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 13:00:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmZ4N-0002kE-SJ; Tue, 19 Mar 2024 08:59:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rmZ4K-0002k0-72
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 08:59:52 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rmZ4I-0003zJ-0i
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 08:59:51 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-41467d697a2so2222635e9.1
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 05:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710853186; x=1711457986; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8RicTkEZEqbbpIn8TxjLQzuftbzXWlhEZxFvomlQNZE=;
 b=xZah3n4O1VcD0og+BFH1+4HDAsjBGRlfwORDaeOXzKWveFP/PZdRYH/7l3QvhOUF7C
 2zgmtznpJEMIIDoxSmzcLKwatPPV5UBHpJcV7alSsUSdE2SYiUg7cOAzF2lydS+dOk5I
 hbq8wRHfnHGrZDQbZq3qvozok8ytuMrS5mfAqgV2yWG7vBJ669ZDS6QVtQK/gk9mVM5n
 xu0PJ8OQ7A5Z5rcqrJpS2bqKYXki4mkPKX/IIkEnKaRn2q9ct2kQFfWEBxv2u/8EKMSi
 ua7FbpglOM24FQaKmGNla8M9slrGUaTMaa9hYqh0B0ILVaQSV/Mc03i/UAqJ6pKw1mue
 LFoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710853186; x=1711457986;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8RicTkEZEqbbpIn8TxjLQzuftbzXWlhEZxFvomlQNZE=;
 b=Z08DbxvgyPOQ7mNJzEXiOJNpBr4g8GNogyLIt/CLFWjOj+UAU4Tt3vkrWCECRyaaLX
 hCXqWwLI37Y/Y5SWAkPF+alsPdvIO+j5kWjX9KsdC4W7V4/n+mQOLrHR9zfOSqnZ3FAt
 qdWvmqoLSqglsiX50QoCLcGzPWs4jNskNqe77u1IaNwxCSHgzDlW2b77oBfPd+hP/X1Y
 gLajVisqXVFex+rpzPeaun/7LBL5Ad9Mbq8iPwvw3sTpNUNGcG/u4j5llyUR6tOf3s3s
 gAmIvVHzePsWJjGe0a4FzD9x80nN95+D+i5haHW94R5x9gbBJiXZ7YiHASFocd51R8Y6
 c1jA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmiNtFBpLNaNFNbNYHwS5z3K8EiNapsRz0bBijVhiM1ectKD90BMv+hhDdmr/tHZvVu+hS5LORsAA1YVVE5ja5dxh4oak=
X-Gm-Message-State: AOJu0Yzq4KjLyvzBUxfvcVCLIlxzfKOmHiO3hxQ9phNd9bPUdjX0MbIF
 C5Nb+4DjjbFLLycSZvavAQBpind4gNm7qZx4ExIRtUZ/jfx+skzCfXTM2dkpygvvpVVGnQQJFY7
 ZVmc=
X-Google-Smtp-Source: AGHT+IEGdxhx6uBYDhamaQrUr7jL67E8GWoQBOsuG6OcRaAoWL5nls0WibizBZssoRkHSTPI8I60Pw==
X-Received: by 2002:a05:600c:4f96:b0:414:65cb:7e99 with SMTP id
 n22-20020a05600c4f9600b0041465cb7e99mr1180574wmq.26.1710853186580; 
 Tue, 19 Mar 2024 05:59:46 -0700 (PDT)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 r8-20020a05600c458800b0041409c1af05sm10159697wmo.21.2024.03.19.05.59.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 05:59:46 -0700 (PDT)
Message-ID: <3d77c835-0620-4b54-ab3b-6dbcd4ff325f@linaro.org>
Date: Tue, 19 Mar 2024 16:59:43 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/22] plugins: Replace pr_ops with a proper debug dump
 flag
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
References: <20240316015720.3661236-1-richard.henderson@linaro.org>
 <20240316015720.3661236-18-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240316015720.3661236-18-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x336.google.com
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
> The DEBUG_PLUGIN_GEN_OPS ifdef is replaced with "-d op_plugin".
> The second pr_ops call can be obtained with "-d op".
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/qemu/log.h     |  1 +
>   include/tcg/tcg.h      |  1 +
>   accel/tcg/plugin-gen.c | 68 ++++++++----------------------------------
>   tcg/tcg.c              | 29 +++++++++++++++++-
>   util/log.c             |  4 +++
>   5 files changed, 46 insertions(+), 57 deletions(-)
> 
> diff --git a/include/qemu/log.h b/include/qemu/log.h
> index df59bfabcd..e10e24cd4f 100644
> --- a/include/qemu/log.h
> +++ b/include/qemu/log.h
> @@ -36,6 +36,7 @@ bool qemu_log_separate(void);
>   #define LOG_STRACE         (1 << 19)
>   #define LOG_PER_THREAD     (1 << 20)
>   #define CPU_LOG_TB_VPU     (1 << 21)
> +#define LOG_TB_OP_PLUGIN   (1 << 22)
>   
>   /* Lock/unlock output. */
>   
> diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
> index df66e8f012..753d7ca3e0 100644
> --- a/include/tcg/tcg.h
> +++ b/include/tcg/tcg.h
> @@ -1065,5 +1065,6 @@ static inline const TCGOpcode *tcg_swap_vecop_list(const TCGOpcode *n)
>   }
>   
>   bool tcg_can_emit_vecop_list(const TCGOpcode *, TCGType, unsigned);
> +void tcg_dump_ops(TCGContext *s, FILE *f, bool have_prefs);
>   
>   #endif /* TCG_H */
> diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
> index 6f0731b479..10d917abd3 100644
> --- a/accel/tcg/plugin-gen.c
> +++ b/accel/tcg/plugin-gen.c
> @@ -44,6 +44,7 @@
>    */
>   #include "qemu/osdep.h"
>   #include "qemu/plugin.h"
> +#include "qemu/log.h"
>   #include "cpu.h"
>   #include "tcg/tcg.h"
>   #include "tcg/tcg-temp-internal.h"
> @@ -58,6 +59,7 @@
>   # define CONFIG_SOFTMMU_GATE 0
>   #endif
>   
> +/* Update plugin_from_name in tcg.c. */
>   enum plugin_gen_from {
>       PLUGIN_GEN_FROM_TB,
>       PLUGIN_GEN_FROM_INSN,
> @@ -192,66 +194,21 @@ static void gen_mem_cb(struct qemu_plugin_dyn_cb *cb,
>       tcg_temp_free_i32(cpu_index);
>   }
>   
> -/* #define DEBUG_PLUGIN_GEN_OPS */
> -static void pr_ops(void)
> -{
> -#ifdef DEBUG_PLUGIN_GEN_OPS
> -    TCGOp *op;
> -    int i = 0;
> -
> -    QTAILQ_FOREACH(op, &tcg_ctx->ops, link) {
> -        const char *name = "";
> -        const char *type = "";
> -
> -        if (op->opc == INDEX_op_plugin_cb_start) {
> -            switch (op->args[0]) {
> -            case PLUGIN_GEN_FROM_TB:
> -                name = "tb";
> -                break;
> -            case PLUGIN_GEN_FROM_INSN:
> -                name = "insn";
> -                break;
> -            case PLUGIN_GEN_FROM_MEM:
> -                name = "mem";
> -                break;
> -            case PLUGIN_GEN_AFTER_INSN:
> -                name = "after insn";
> -                break;
> -            default:
> -                break;
> -            }
> -            switch (op->args[1]) {
> -            case PLUGIN_GEN_CB_UDATA:
> -                type = "udata";
> -                break;
> -            case PLUGIN_GEN_CB_INLINE:
> -                type = "inline";
> -                break;
> -            case PLUGIN_GEN_CB_MEM:
> -                type = "mem";
> -                break;
> -            case PLUGIN_GEN_ENABLE_MEM_HELPER:
> -                type = "enable mem helper";
> -                break;
> -            case PLUGIN_GEN_DISABLE_MEM_HELPER:
> -                type = "disable mem helper";
> -                break;
> -            default:
> -                break;
> -            }
> -        }
> -        printf("op[%2i]: %s %s %s\n", i, tcg_op_defs[op->opc].name, name, type);
> -        i++;
> -    }
> -#endif
> -}
> -
>   static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
>   {
>       TCGOp *op, *next;
>       int insn_idx = -1;
>   
> -    pr_ops();
> +    if (unlikely(qemu_loglevel_mask(LOG_TB_OP_PLUGIN)
> +                 && qemu_log_in_addr_range(plugin_tb->vaddr))) {
> +        FILE *logfile = qemu_log_trylock();
> +        if (logfile) {
> +            fprintf(logfile, "OP before plugin injection:\n");
> +            tcg_dump_ops(tcg_ctx, logfile, false);
> +            fprintf(logfile, "\n");
> +            qemu_log_unlock(logfile);
> +        }
> +    }
>   
>       /*
>        * While injecting code, we cannot afford to reuse any ebb temps
> @@ -389,7 +346,6 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
>               break;
>           }
>       }
> -    pr_ops();
>   }
>   
>   bool plugin_gen_tb_start(CPUState *cpu, const DisasContextBase *db,
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 363a065e28..d248c52e96 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -2540,6 +2540,15 @@ static const char bswap_flag_name[][6] = {
>       [TCG_BSWAP_IZ | TCG_BSWAP_OS] = "iz,os",
>   };
>   
> +#ifdef CONFIG_PLUGIN
> +static const char * const plugin_from_name[] = {
> +    "from-tb",
> +    "from-insn",
> +    "after-insn",
> +    "after-tb",
> +};
> +#endif
> +
>   static inline bool tcg_regset_single(TCGRegSet d)
>   {
>       return (d & (d - 1)) == 0;
> @@ -2558,7 +2567,7 @@ static inline TCGReg tcg_regset_first(TCGRegSet d)
>   #define ne_fprintf(...) \
>       ({ int ret_ = fprintf(__VA_ARGS__); ret_ >= 0 ? ret_ : 0; })
>   
> -static void tcg_dump_ops(TCGContext *s, FILE *f, bool have_prefs)
> +void tcg_dump_ops(TCGContext *s, FILE *f, bool have_prefs)
>   {
>       char buf[128];
>       TCGOp *op;
> @@ -2714,6 +2723,24 @@ static void tcg_dump_ops(TCGContext *s, FILE *f, bool have_prefs)
>                       i = k = 1;
>                   }
>                   break;
> +#ifdef CONFIG_PLUGIN
> +            case INDEX_op_plugin_cb:
> +                {
> +                    TCGArg from = op->args[k++];
> +                    const char *name = NULL;
> +
> +                    if (from < ARRAY_SIZE(plugin_from_name)) {
> +                        name = plugin_from_name[from];
> +                    }
> +                    if (name) {
> +                        col += ne_fprintf(f, "%s", name);
> +                    } else {
> +                        col += ne_fprintf(f, "$0x%" TCG_PRIlx, from);
> +                    }
> +                    i = 1;
> +                }
> +                break;
> +#endif
>               default:
>                   i = 0;
>                   break;
> diff --git a/util/log.c b/util/log.c
> index d36c98da0b..6219819855 100644
> --- a/util/log.c
> +++ b/util/log.c
> @@ -466,6 +466,10 @@ const QEMULogItem qemu_log_items[] = {
>         "show micro ops after optimization" },
>       { CPU_LOG_TB_OP_IND, "op_ind",
>         "show micro ops before indirect lowering" },
> +#ifdef CONFIG_PLUGIN
> +    { LOG_TB_OP_PLUGIN, "op_plugin",
> +      "show micro ops before plugin injection" },
> +#endif
>       { CPU_LOG_INT, "int",
>         "show interrupts/exceptions in short format" },
>       { CPU_LOG_EXEC, "exec",

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

