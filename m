Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69DD8C04FF8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 17:56:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxW0D-00059A-3D; Thu, 18 Apr 2024 13:56:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rxW0B-000530-A8
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 13:56:51 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rxW09-0000Sl-8V
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 13:56:51 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2a68a2b3747so902153a91.3
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 10:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713463008; x=1714067808; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4GhetyBAL6y2MoesB+OoCXNMx9EhlE70+vmqNmEMY3g=;
 b=taqrAuCSTsNEmhpG1ko17wNIr9OL4qiMKqU5GPPFxHS18+dKifoVHZw06F1480Vw6C
 SsjKlp0YkuzG9n48qQz22hqCE7d8XulD0kJvJsmWqv52M1Kn8/OG/2r8lb/T2/1JmG2z
 ZPL8um+3zS9u3HoBBF+iOM7t9OEvfDAgujX3ovC98KBvyu/kr/4avhD+etzyDfLo8zCl
 VNx4zYR7V4bHVSFwqp4rH9qfCWT5TH46D7GoBFOmbzxNwWgFRoUbtxNG5GBfndmf91Dh
 boCaF5bg5Rhij3EGbR3pW251qZZKl7QkdpIv79L/oBmSEEFkFBg9eyIHzSVyzkiHuge4
 Sslw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713463008; x=1714067808;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4GhetyBAL6y2MoesB+OoCXNMx9EhlE70+vmqNmEMY3g=;
 b=iOpYbaa1mhxUJzPeaJZ6oPW5wmdyO53ply6ENOEI8VQHTzmYY8OpqV2X3r97WwSNbY
 XQMQ50tcMmD0MtEXvmUGSoTNkdIpU3YCP7tdLQkTzaqtqnNHEvdmedauuLn6P+6JQkJR
 mUCBHgQ1LFe74QdqEfOBHDLn9jwwlVl5c9v2dopllUMWsyTrJ17LoCi0W7/hwAlFWTi4
 NdvgkAkMvRf8w7C9mXswLUN+M63sGvwOKfZ+3/wJ6LTcf8SuShqEtqq7d7cRuGzLCRzL
 UVYkJw/r5p/fi03XeAAjwTvxGtuNzFE7Ghuapi0aOddC101Wtn+QZuiFwo5FzwUyJeof
 8UhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDFvzeAFNfWuWFAaBvHXPS83q6kQ65uiVX0TFmTV8K4sqfmzYzo4caaDwOdqIwpedxxVp/1YAnaw4n3dykaYCnvLUSgxs=
X-Gm-Message-State: AOJu0YwSzScMzk6YHLO5LDgDu3hLvyain1r2v8uA6ajUUKeg5MpTzaYE
 Enqpkkzc1kYA/HQDYWyx19CFLyRpUnGQPnQNbwmDOgs++KiMWrncqm3a23zMBRM27IryM6cxH3p
 3q2Q=
X-Google-Smtp-Source: AGHT+IFgGYdOTohHy6CPz+BcWr41PC1XQNd2+TtzP3XIYs7VsRL4uk3feMZL/R7EW9j9sUsKix4cPg==
X-Received: by 2002:a17:90b:688:b0:29b:961a:29c3 with SMTP id
 m8-20020a17090b068800b0029b961a29c3mr2918938pjz.49.1713463007697; 
 Thu, 18 Apr 2024 10:56:47 -0700 (PDT)
Received: from ?IPV6:2604:3d08:937d:c610::fc11? ([2604:3d08:937d:c610::fc11])
 by smtp.gmail.com with ESMTPSA id
 p4-20020a17090ac00400b002a3a154b974sm1740653pjt.55.2024.04.18.10.56.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Apr 2024 10:56:47 -0700 (PDT)
Message-ID: <1de592dc-3903-455a-bf6b-6c4c15d8e398@linaro.org>
Date: Thu, 18 Apr 2024 10:56:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] target/i386: Implement TCGCPUOps for plugin register
 reads
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240416040609.1313605-1-richard.henderson@linaro.org>
 <20240416040609.1313605-8-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240416040609.1313605-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1030.google.com
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
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/i386/tcg/tcg-cpu.c | 72 ++++++++++++++++++++++++++++++---------
>   1 file changed, 56 insertions(+), 16 deletions(-)
> 
> diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
> index cca19cd40e..2370053df2 100644
> --- a/target/i386/tcg/tcg-cpu.c
> +++ b/target/i386/tcg/tcg-cpu.c
> @@ -22,9 +22,11 @@
>   #include "helper-tcg.h"
>   #include "qemu/accel.h"
>   #include "hw/core/accel-cpu.h"
> -
> +#include "gdbstub/helpers.h"
> +#include "gdb-internal.h"
>   #include "tcg-cpu.h"
>   
> +
>   /* Frob eflags into and out of the CPU temporary format.  */
>   
>   static void x86_cpu_exec_enter(CPUState *cs)
> @@ -61,38 +63,74 @@ static void x86_cpu_synchronize_from_tb(CPUState *cs,
>       }
>   }
>   
> -static void x86_restore_state_to_opc(CPUState *cs,
> -                                     const TranslationBlock *tb,
> -                                     const uint64_t *data)
> +static uint64_t eip_from_unwind(CPUX86State *env, const TranslationBlock *tb,
> +                                uint64_t data0)
>   {
> -    X86CPU *cpu = X86_CPU(cs);
> -    CPUX86State *env = &cpu->env;
> -    int cc_op = data[1];
>       uint64_t new_pc;
>   
>       if (tb_cflags(tb) & CF_PCREL) {
>           /*
> -         * data[0] in PC-relative TBs is also a linear address, i.e. an address with
> -         * the CS base added, because it is not guaranteed that EIP bits 12 and higher
> -         * stay the same across the translation block.  Add the CS base back before
> -         * replacing the low bits, and subtract it below just like for !CF_PCREL.
> +         * data[0] in PC-relative TBs is also a linear address,
> +         * i.e. an address with the CS base added, because it is
> +         * not guaranteed that EIP bits 12 and higher stay the
> +         * same across the translation block.  Add the CS base
> +         * back before replacing the low bits, and subtract it
> +         * below just like for !CF_PCREL.
>            */
>           uint64_t pc = env->eip + tb->cs_base;
> -        new_pc = (pc & TARGET_PAGE_MASK) | data[0];
> +        new_pc = (pc & TARGET_PAGE_MASK) | data0;
>       } else {
> -        new_pc = data[0];
> +        new_pc = data0;
>       }
>       if (tb->flags & HF_CS64_MASK) {
> -        env->eip = new_pc;
> -    } else {
> -        env->eip = (uint32_t)(new_pc - tb->cs_base);
> +        return new_pc;
>       }
> +    return (uint32_t)(new_pc - tb->cs_base);
> +}
>   
> +static void x86_restore_state_to_opc(CPUState *cs,
> +                                     const TranslationBlock *tb,
> +                                     const uint64_t *data)
> +{
> +    CPUX86State *env = cpu_env(cs);
> +    CCOp cc_op;
> +
> +    env->eip = eip_from_unwind(env, tb, data[0]);
> +
> +    cc_op = data[1];
>       if (cc_op != CC_OP_DYNAMIC) {
>           env->cc_op = cc_op;
>       }
>   }
>   
> +static bool x86_plugin_need_unwind_for_reg(CPUState *cs, int reg)
> +{
> +    return reg == IDX_IP_REG || reg == IDX_FLAGS_REG;
> +}
> +
> +static int x86_plugin_unwind_read_reg(CPUState *cs, GByteArray *buf, int reg,
> +                                      const TranslationBlock *tb,
> +                                      const uint64_t *data)
> +{
> +    CPUX86State *env = cpu_env(cs);
> +    CCOp cc_op;
> +
> +    switch (reg) {
> +    case IDX_IP_REG:
> +        return gdb_get_regl(buf, eip_from_unwind(env, tb, data[0]));
> +
> +    case IDX_FLAGS_REG:
> +        cc_op = data[1];
> +        if (cc_op == CC_OP_DYNAMIC) {
> +            cc_op = env->cc_op;
> +        }
> +        return gdb_get_reg32(buf, cpu_compute_eflags_ccop(env, cc_op));
> +
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +
>   #ifndef CONFIG_USER_ONLY
>   static bool x86_debug_check_breakpoint(CPUState *cs)
>   {
> @@ -110,6 +148,8 @@ static const TCGCPUOps x86_tcg_ops = {
>       .initialize = tcg_x86_init,
>       .synchronize_from_tb = x86_cpu_synchronize_from_tb,
>       .restore_state_to_opc = x86_restore_state_to_opc,
> +    .plugin_need_unwind_for_reg = x86_plugin_need_unwind_for_reg,
> +    .plugin_unwind_read_reg = x86_plugin_unwind_read_reg,
>       .cpu_exec_enter = x86_cpu_exec_enter,
>       .cpu_exec_exit = x86_cpu_exec_exit,
>   #ifdef CONFIG_USER_ONLY

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

