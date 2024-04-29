Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D480C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 00:55:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1FIB-0004bn-M5; Sun, 28 Apr 2024 20:54:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1FI9-0004bc-Pj
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 20:54:49 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1FI8-0004ry-0w
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 20:54:49 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1e8fce77bb2so29935985ad.0
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 17:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714352086; x=1714956886; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F+T4HB4+Xp7MUWCCGKy4m3Gi1G+2agqjGyynN3Q/N6Y=;
 b=ONzZ3PeCGnjEzOfEdQtUfszQ19VrKEj02nguNdCzvN8KjaGQ/oJhRH2CCHq3CSiXsv
 CTkCe3qEgUzjggJ3LTcsqoiXSQKctZvx3KNKtqm9+NS9XEcgNfQ+CTgqqgvvHdRVtuhu
 VHXpSr+7sayvMDrOczYe3Qv9DcnArb/urn8V2WAs9q9Qq/REddGY4bqZTOyDk8rB0aIO
 Q2w0cCWcYHEQveDX2NgWO/Qc7NTnqaeNNo8Sw8zmSim2Qla22tJsif9ZOxCQsASp2ApX
 4uxgbv6aoHrO+TrRJHjIrPJJSlFCex/B3lvhI5kJLgbnKSjJGHhqD6BVARsieCvuwNN4
 mXjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714352086; x=1714956886;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F+T4HB4+Xp7MUWCCGKy4m3Gi1G+2agqjGyynN3Q/N6Y=;
 b=HVKRG0b38lF9Gl4DmpOY/eCDXHN9RDtfpA6eGHtxGz8DiiA2KpRJ9pmwVbHNOSI/pP
 98Tp/iUkvI6ZooTzoHd+1pcO9ml5WEu+uPw1w6uOnT4jHNW+qmEP94PO2BEaWlIVcOWy
 tPLwVmr4dAGYZQrMfN5SXjGbWiwBFfd+PeR5+zBQguNeVFp/xXsiLQaJAJCQPe/+CkJY
 Vqzkm78trR9X/beua+q0ui9mkXf7MsDsTXFp73LFemhpJO7TpLRjM33l3PsB4GYSEZVC
 Q+oUovfkSOMlWkJK9Q+sITs3f9FkMkNjO3IuDJQNxQvjo2tHlW8wBV+lUZ24DyIqy6zj
 oxtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpZKd+XAfj4xScCpb1bTJIFYWRXEug1pfcYZYKa8QhhYHSlOL6Wn7msLb4IwO69xjjQjWMjdxBGgbXQu9bal20ffPL8Hs=
X-Gm-Message-State: AOJu0YygSfGSUCIQCSissZVxGo27QAgauKuw4ONdUedCn23FW9U1zVHh
 LWDgsKEOv7UB1LFrsblz+pO1nbBzaLWEPwVQ3/PrB1xdE3MiODaajrQvCj1igyI=
X-Google-Smtp-Source: AGHT+IFCF/qwoyyoNFMEra9+4yzTU6tGLbLEdr8HZFqdFuGb8JptaL/3RoOhhLfhJ1alKi10/KLMdA==
X-Received: by 2002:a17:902:e542:b0:1e2:ae83:3197 with SMTP id
 n2-20020a170902e54200b001e2ae833197mr11818866plf.10.1714352086450; 
 Sun, 28 Apr 2024 17:54:46 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 l11-20020a170903120b00b001e98f928d0fsm13404171plh.10.2024.04.28.17.54.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Apr 2024 17:54:46 -0700 (PDT)
Message-ID: <7acbabe3-2eb6-4b3b-b5cc-01708339f1d4@linaro.org>
Date: Sun, 28 Apr 2024 17:54:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/24] accel/tcg: Move user definition of cpu_interrupt()
 to user-exec.c
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
References: <20240428221450.26460-1-philmd@linaro.org>
 <20240428221450.26460-4-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240428221450.26460-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 4/28/24 15:14, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/tcg/translate-all.c | 9 ---------
>   accel/tcg/user-exec.c     | 8 ++++++++
>   2 files changed, 8 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 83cc14fbde..fdf6d8ac19 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -644,15 +644,6 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
>       cpu_loop_exit_noexc(cpu);
>   }
>   
> -#else /* CONFIG_USER_ONLY */
> -
> -void cpu_interrupt(CPUState *cpu, int mask)
> -{
> -    g_assert(bql_locked());
> -    cpu->interrupt_request |= mask;
> -    qatomic_set(&cpu->neg.icount_decr.u16.high, -1);
> -}
> -
>   #endif /* CONFIG_USER_ONLY */
>   
>   /*
> diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
> index ca27746fe4..f49435df9d 100644
> --- a/accel/tcg/user-exec.c
> +++ b/accel/tcg/user-exec.c
> @@ -24,6 +24,7 @@
>   #include "qemu/bitops.h"
>   #include "qemu/rcu.h"
>   #include "exec/cpu_ldst.h"
> +#include "qemu/main-loop.h"
>   #include "exec/translate-all.h"
>   #include "exec/page-protection.h"
>   #include "exec/helper-proto.h"
> @@ -38,6 +39,13 @@ __thread uintptr_t helper_retaddr;
>   
>   //#define DEBUG_SIGNAL
>   
> +void cpu_interrupt(CPUState *cpu, int mask)
> +{
> +    g_assert(bql_locked());
> +    cpu->interrupt_request |= mask;
> +    qatomic_set(&cpu->neg.icount_decr.u16.high, -1);
> +}
> +
>   /*
>    * Adjust the pc to pass to cpu_restore_state; return the memop type.
>    */


