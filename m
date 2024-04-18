Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4980C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 17:55:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxVyQ-0000T6-MY; Thu, 18 Apr 2024 13:55:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rxVyO-0000AJ-2X
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 13:55:00 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rxVyL-00085Q-4k
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 13:54:59 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1e651a9f3ffso7859815ad.1
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 10:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713462896; x=1714067696; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UubT2PWLCYPJJF+yhdnjwch3hkD4vysOdd1/r27/3i8=;
 b=U3unThAQTWFWnM4j7r0khtIY6HwZchOMa9Q6KyRd+OiWlH5fgGo3phm1cWm0/4Me1n
 zNkFV/Dz5umHYs0DROTx98hydAu/8ERt7IxQlZEOVdMSkM1Km70NTCFSYYJbs4yVOeho
 dgWUjNiO120CEeFtAZ7KUv2j3WyXOVarTHV2Ila76x2OgT/0R4Il6sTd6qTsGZCjWjL9
 LwqzYATpe/8WmZ71TphiPp3k+ufXYp5szg+LgxIhYgT11A7yi1ICbgWz5JZxtxngu6KB
 k3YUsKJaSqWktgpSi4nVn0jrTL3X6vvhkgFg3d/IycScUGsyT9QME6X8xA7NE8Tv7Pu5
 6QBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713462896; x=1714067696;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UubT2PWLCYPJJF+yhdnjwch3hkD4vysOdd1/r27/3i8=;
 b=OI2KafL2OYjYuOq2k02zGo3Kc4E/Tnxppm/aNIoL1iUjv8+7PIWybbt7GVqKfZAybp
 6NO8Z4LXP8HZsbITjLh1AfWmI05i0wdWAo5hkzwOOjY0OBA7FdAfGjbP5PXrnOFgLJdV
 U3tT7gH2YUOanEZTe0Tivu39b5LyxREG+bfBvCwJ2QxoYvoZcmMZjNZBMXYdgjU+TgL8
 FNC6YpGnOKMK+uZmrYUJTUmsbCNnIXlMiXMgYRNHkYEcgQjXIwfk3XZ2ZJsY5wQxHqP/
 m5OmIdoJR10Z5Snp/Jq7Ezj7QUe6cC76FusW+9VDkZqCGqVMiPAcG3fe20ZmHl4KduGK
 7kUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUR8HR8DSuh+R9nSi7POqJZiNFt5YRDF3EQFlFfGbpv54S+fCiu9jMn3KU7evFM58QqRf0Nz0/DKkoA24E3+h5o5G0hNCY=
X-Gm-Message-State: AOJu0YwfBxMNVf43ff3yhl1nyp+Yh25Gxyt5DbxcyEPVYA5KjL9X/BXt
 F3WKThKQBjIMW5Gcy5q0ZCTwVpWavqXP+98q0afz3LdFgGbn1YyoxAuOZXiCewQxwk9VasA+4CW
 PztY=
X-Google-Smtp-Source: AGHT+IFwWfeYIaqFWcQtV3E5MrfCvpirBLDTeus2W7brklWqip037LHWJNuBOgrenzoyxgvmH+2J8g==
X-Received: by 2002:a17:902:a60f:b0:1e4:8c64:33c6 with SMTP id
 u15-20020a170902a60f00b001e48c6433c6mr3569617plq.59.1713462895721; 
 Thu, 18 Apr 2024 10:54:55 -0700 (PDT)
Received: from ?IPV6:2604:3d08:937d:c610::fc11? ([2604:3d08:937d:c610::fc11])
 by smtp.gmail.com with ESMTPSA id
 mq8-20020a170902fd4800b001e23fcdebe9sm1819076plb.98.2024.04.18.10.54.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Apr 2024 10:54:55 -0700 (PDT)
Message-ID: <68de4f64-90a7-49d0-8d14-57e510da3daf@linaro.org>
Date: Thu, 18 Apr 2024 10:54:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] accel/tcg: Return the TranslationBlock from
 cpu_unwind_state_data
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240416040609.1313605-1-richard.henderson@linaro.org>
 <20240416040609.1313605-4-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240416040609.1313605-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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
> Fix the i386 get_memio_eip function to use tb->cflags
> instead of cs->tcg_cflags.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/cpu-common.h | 9 +++++----
>   accel/tcg/translate-all.c | 9 +++++----
>   target/i386/helper.c      | 6 ++++--
>   3 files changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index 6346df17ce..f056132cab 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -176,12 +176,13 @@ void list_cpus(void);
>    * @host_pc: the host pc within the translation
>    * @data: output data
>    *
> - * Attempt to load the the unwind state for a host pc occurring in
> - * translated code.  If @host_pc is not in translated code, the
> - * function returns false; otherwise @data is loaded.
> + * Attempt to load the the unwind state for a host pc occurring in translated
> + * code.  If @host_pc is not in translated code, the function returns NULL;
> + * otherwise @data is loaded and the TranslationBlock is returned.
>    * This is the same unwind info as given to restore_state_to_opc.
>    */
> -bool cpu_unwind_state_data(CPUState *cpu, uintptr_t host_pc, uint64_t *data);
> +const TranslationBlock *cpu_unwind_state_data(CPUState *cpu, uintptr_t host_pc,
> +                                              uint64_t *data);
>   
>   /**
>    * cpu_restore_state:
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 83cc14fbde..c745bc5b6c 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -243,15 +243,16 @@ bool cpu_restore_state(CPUState *cpu, uintptr_t host_pc)
>       return false;
>   }
>   
> -bool cpu_unwind_state_data(CPUState *cpu, uintptr_t host_pc, uint64_t *data)
> +const TranslationBlock *
> +cpu_unwind_state_data(CPUState *cpu, uintptr_t host_pc, uint64_t *data)
>   {
>       if (in_code_gen_buffer((const void *)(host_pc - tcg_splitwx_diff))) {
>           TranslationBlock *tb = tcg_tb_lookup(host_pc);
> -        if (tb) {
> -            return cpu_unwind_data_from_tb(tb, host_pc, data) >= 0;
> +        if (tb && cpu_unwind_data_from_tb(tb, host_pc, data) >= 0) {
> +            return tb;
>           }
>       }
> -    return false;
> +    return NULL;
>   }
>   
>   void page_init(void)
> diff --git a/target/i386/helper.c b/target/i386/helper.c
> index 23ccb23a5b..eaa691a851 100644
> --- a/target/i386/helper.c
> +++ b/target/i386/helper.c
> @@ -517,13 +517,15 @@ static inline target_ulong get_memio_eip(CPUX86State *env)
>   #ifdef CONFIG_TCG
>       uint64_t data[TARGET_INSN_START_WORDS];
>       CPUState *cs = env_cpu(env);
> +    const TranslationBlock *tb;
>   
> -    if (!cpu_unwind_state_data(cs, cs->mem_io_pc, data)) {
> +    tb = cpu_unwind_state_data(cs, cs->mem_io_pc, data);
> +    if (!tb) {
>           return env->eip;
>       }
>   
>       /* Per x86_restore_state_to_opc. */
> -    if (cs->tcg_cflags & CF_PCREL) {
> +    if (tb->cflags & CF_PCREL) {
>           return (env->eip & TARGET_PAGE_MASK) | data[0];
>       } else {
>           return data[0] - env->segs[R_CS].base;

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

