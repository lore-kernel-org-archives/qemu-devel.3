Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5291AC46CD2
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jan 2024 22:15:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTqwr-00042W-MT; Sat, 27 Jan 2024 17:14:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTqwp-00040p-Ay
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 17:14:47 -0500
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTqwn-0000km-T6
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 17:14:47 -0500
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-5ff9adbf216so13563847b3.1
 for <qemu-devel@nongnu.org>; Sat, 27 Jan 2024 14:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706393685; x=1706998485; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+FtI5RqwkWf6PLu6Gu4IG6ekxpapz0gnsgVU84sNUv8=;
 b=bHEKnbcyUUIWXPozoH1902g75ckMfEYu1cBuIXHYT7/o00Vm1d/qQxMj09WjG9JUe+
 K3Ym4jUIQi+j6byYmFIgkjaOcW/IrB8RlmgyvgFUkuXF4+RaUpyLejkZDMO049NBb+wh
 gGjUEnsZTKwK7jSA77nYiIkfp3Nz7SMiiphAM4Thd0ghhn9q3EgY72oBsZMfh3lqxHdS
 JQAJvsC3v7W5/Yke97heJrjD/soUQQf9TfBV/ag3Gncl6RYcoP5OFRwm/b41Wp5sxGQr
 GVm2QiMzyR+nOniur8dsdlwJlQP/RSnCUN93HUgI5Qoai7ByUoSLVsowy/BOfHhH4nBO
 Cg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706393685; x=1706998485;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+FtI5RqwkWf6PLu6Gu4IG6ekxpapz0gnsgVU84sNUv8=;
 b=MgwTpJXQ4wJULNrNVOlMX7UPMRz9cFdJeCOAa7Q80C4RW9fCC0OkuuABOS/dUryjou
 Ib3r0A0WKALnMlqNHbo121Z8si0cctIpeRkT7oVtMq1Ur4QWv5RZSz5XFD4xmhmSz0T6
 baGQb21TMDfcNm9JXOJK0DAL93MJkaxBW1iGRaBTT+8dkyQ6TcE08P3M1kzl/udpHL1O
 bLHd+xaM9AW9OGnxCm0v2vQMr4uN+AlcX7SFcG2E/YgP4VqoiGi3LBB/j8TBHBiJcRAp
 YpJJ+lfHE2ciWlqFQQBqHZL4ZR3/eMm69KNlLng0oJ3o3SZKot9PQBpTKSPx1aglqWv6
 EiJQ==
X-Gm-Message-State: AOJu0YxXhyit8qLwH/v+bk7R49YlmHH4qBVab++u27Kzr/VfY9NQFrO9
 a8ykE/z7+f/SKbbMVfOkWr/zML9CeXzl1/cimS/iWP8uFnrQk8yD3kOpuMDxhOc90AWSQvy7V96
 2dOnfsQ==
X-Google-Smtp-Source: AGHT+IE6whunSq/33H2+XcrrVmfxjw03Z6PYpR7totYKP7IQV1kwDDXXETZ463MEElWq+g3UnyQ1xw==
X-Received: by 2002:a81:ce06:0:b0:602:cc01:81c6 with SMTP id
 t6-20020a81ce06000000b00602cc0181c6mr2424868ywi.14.1706393684724; 
 Sat, 27 Jan 2024 14:14:44 -0800 (PST)
Received: from ?IPV6:2001:8003:c96c:3c00:a829:f39c:2095:de50?
 ([2001:8003:c96c:3c00:a829:f39c:2095:de50])
 by smtp.gmail.com with ESMTPSA id
 t19-20020a62d153000000b006dddd685bbesm3348905pfl.122.2024.01.27.14.14.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Jan 2024 14:14:44 -0800 (PST)
Message-ID: <b18b9f43-dcf7-4eac-8e97-5a6f805b257a@linaro.org>
Date: Sun, 28 Jan 2024 08:14:38 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 16/34] exec: [CPUTLB] Move cpu_*()/cpu_env() to common
 header
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, philmd@linaro.org
References: <20240119144024.14289-1-anjo@rev.ng>
 <20240119144024.14289-17-anjo@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240119144024.14289-17-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x1134.google.com
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

On 1/20/24 00:40, Anton Johansson wrote:
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -347,4 +347,29 @@ G_NORETURN void cpu_loop_exit_restore(CPUState *cpu, uintptr_t pc);
>    */
>   #define PAGE_PASSTHROUGH 0x0800
>   
> +/* accel/tcg/cpu-exec.c */
> +int cpu_exec(CPUState *cpu);
> +
> +/**
> + * env_archcpu(env)
> + * @env: The architecture environment
> + *
> + * Return the ArchCPU associated with the environment.
> + */
> +static inline ArchCPU *env_archcpu(CPUArchState *env)
> +{
> +    return (void *)env - sizeof(CPUState);
> +}
> +
> +/**
> + * env_cpu(env)
> + * @env: The architecture environment
> + *
> + * Return the CPUState associated with the environment.
> + */
> +static inline CPUState *env_cpu(CPUArchState *env)
> +{
> +    return (void *)env - sizeof(CPUState);
> +}
> +
>   #endif /* CPU_COMMON_H */

Missing include of hw/core/cpu.h, as far as I can see?


r~

