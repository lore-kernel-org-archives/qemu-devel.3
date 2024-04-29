Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C71B1C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 01:10:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1FX8-0000d3-O2; Sun, 28 Apr 2024 21:10:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1FWw-0000bv-Qo
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 21:10:08 -0400
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1FWr-0007bN-3C
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 21:10:04 -0400
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-5aa26990d5aso2631910eaf.1
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 18:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714352999; x=1714957799; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YlMvBBLciMtKDwJHakZsSV52gSwVyLJfb+4Mr5gqwpY=;
 b=GTjBZ4I7049TZuAW77br34xc914wixGXlOWsWPdt5emwE383NYpIWQLzjtmK6sXlz8
 b2rH8zdgLaeJudRc+iEvdgJmM+9bxtzmbkPdl3A5GDUwKby5TTi69RXfUeZJHQsZDg9r
 c/I9xC6rnWZ/T9Ndn+o71B+HhsGDttBpp/jFLhEF1SlnG1aVZjTt2QwjOZuGKKt5zaY0
 wAljF50F3uPMqTMognHPtfBC+3tzNujdbfzccw5H9cvRbTYNsG7X2CHY+Ua7vURUCc5L
 LkE6OO+nKwohd8gjWVd/ZYn/8YYWGm+yrJHW0n5Gd0KpLB5ivJN5z2FPrC6yA4S2qm9w
 FS7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714352999; x=1714957799;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YlMvBBLciMtKDwJHakZsSV52gSwVyLJfb+4Mr5gqwpY=;
 b=SANbWeiYaL9bNn6xmAmM/U6gsWwn7aHokrxAkn5ahdPHRHeWryepKsh7604UswqLoE
 ScNKaplh/ut/KbhUhBGWWVaCsqpBQxwdDuW4QajuQiJHb/Yn0s+5ErOFYpHeG6NC8Jfd
 x16OeVm+RTFbWSNyBvRuJzN8UtsFz8tBawH2pKfkqg/OU7BVhx1bZKuAPoIuDUZy/qTb
 ZUCRED6jiT17x6CRuBNQBy3LIJdsgl62EPrXcV9gVm0gPg+84elGrG+DurnrzmYSlFKU
 3mT5+9xYNXsYpLc0IuOUINwhqtvu7RA9SUwN307/IKMuetTzwscwAuzC83HPWq7dimu4
 seVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6UbzKMNRfVATtKbPoPQix02M4O8lq39cpbKCyI6uJkFNOa4bTp2MAXNQpYQsjQwZOVOtXVdLAzUphzFT4s7HiLjzNgRw=
X-Gm-Message-State: AOJu0YwKWU5tpjsBd1x798dRvWp9T45FiXlRx/llaUqZTWqWWjrDsURv
 v5tXdVPufectsUegWNu93Odu3llBk1U6P8PzARn+JgWxNDfLaEQZs50wak67MuICjA1HPZXsTP5
 M
X-Google-Smtp-Source: AGHT+IGLlG4qhGnxc6epFDaqVVae8UeiH1x+NX419XGE0utR3ceG6ZIRL8VhZBiRsaVmDo47oWe/PA==
X-Received: by 2002:a05:6870:f154:b0:22e:1487:a94b with SMTP id
 l20-20020a056870f15400b0022e1487a94bmr10677261oac.53.1714352998780; 
 Sun, 28 Apr 2024 18:09:58 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 gj14-20020a056a00840e00b006ed93e7ef22sm18104465pfb.39.2024.04.28.18.09.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Apr 2024 18:09:58 -0700 (PDT)
Message-ID: <5472b677-08fb-4b3e-8b2f-c94e26e89eea@linaro.org>
Date: Sun, 28 Apr 2024 18:09:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/24] accel/tcg: Implement
 AccelOpsClass::exit_vcpu_thread() handler
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
References: <20240428221450.26460-1-philmd@linaro.org>
 <20240428221450.26460-8-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240428221450.26460-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc36.google.com
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
> The TCG-specific code from the system generic cpu_exit()
> is equivalent of tcg_cpu_exit(). Define the AccelOpsClass
> exit_vcpu_thread() handler to it, making cpu_exit() generic.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/tcg/tcg-accel-ops.c | 2 ++
>   system/cpus.c             | 3 ---
>   2 files changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> 
> diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
> index 7ac5f0c974..56bbad9fcd 100644
> --- a/accel/tcg/tcg-accel-ops.c
> +++ b/accel/tcg/tcg-accel-ops.c
> @@ -43,6 +43,7 @@
>   #include "tcg-accel-ops-mttcg.h"
>   #include "tcg-accel-ops-rr.h"
>   #include "tcg-accel-ops-icount.h"
> +#include "internal-common.h"
>   
>   /* common functionality among all TCG variants */
>   
> @@ -218,6 +219,7 @@ static void tcg_accel_ops_init(AccelOpsClass *ops)
>           }
>       }
>   
> +    ops->exit_vcpu_thread = tcg_cpu_exit;
>       ops->cpu_reset_hold = tcg_cpu_reset_hold;
>       ops->supports_guest_debug = tcg_supports_guest_debug;
>       ops->insert_breakpoint = tcg_insert_breakpoint;
> diff --git a/system/cpus.c b/system/cpus.c
> index d0d585e8b9..3e86b488d3 100644
> --- a/system/cpus.c
> +++ b/system/cpus.c
> @@ -422,9 +422,6 @@ void run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data)
>   void cpu_exit(CPUState *cpu)
>   {
>       qatomic_set(&cpu->exit_request, 1);
> -    /* Ensure cpu_exec will see the exit request after TCG has exited.  */
> -    smp_wmb();
> -    qatomic_set(&cpu->neg.icount_decr.u16.high, -1);
>       if (cpus_accel->exit_vcpu_thread) {
>           cpus_accel->exit_vcpu_thread(cpu);
>       }


