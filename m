Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF01C47DDB
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jan 2024 08:27:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTe1K-00077U-Qm; Sat, 27 Jan 2024 03:26:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTe1I-00076C-Qw
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 03:26:32 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTe1H-0001Wf-7C
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 03:26:32 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-290d59df3f0so903853a91.2
 for <qemu-devel@nongnu.org>; Sat, 27 Jan 2024 00:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706343989; x=1706948789; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HaNWo5f4zm/WDKtk0d7GBJnCN1WkH2XNJ1qvL0aDpf8=;
 b=vuhp9X6CjkglUqhcsatX1zR6Cci18grgeB/vUJZO1YgU3KthUeoPAQ7ceGoK4eORRA
 yNu94dn9gmXfkhLwbEwcSYReACrIEU7zfaWDToIeEYDHQgS58ZzN91FoSQY+MWBY9KCV
 MYucw5251kGG6okPnAK5NnVcyM9I3pqmiwjhSb4ZEhwjgKlSI0L341Df4hGla8LPHDj2
 8JmRyLH0rjWwSRnul6HcnH69R4ZRH2MTYqESzWJD7dvxkfhXGGElhzf4S9lHN55s3hVL
 YzvIJnyuCUntJCmBe1oCqNpW4DQK52ZbAzFLpn4piq8GDEn2owIoOw7s8HOtg4Zy+28Z
 AiUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706343989; x=1706948789;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HaNWo5f4zm/WDKtk0d7GBJnCN1WkH2XNJ1qvL0aDpf8=;
 b=iW+XefP0hGXYMPwiaAjZ7qFhPhCF3vkQlucHqPocRO7z9WCtWncxpT9wsgXb7HZGIY
 EqILYorJVaMwqu+Mbk74vTuHJrmimKlvF73jjZeVz0YI2HlyhOJWRqTcOnGfmfcOkE9L
 ZovBKOQInpzdz7/azMGuTbuEeQjOxH9onEbs9GLs7HsYKodq/ljn9m3QNM/Ury8T+CBv
 JGPUWXSGT9niPWqg11az+4Mhf6FHnHbv4B0YxJsRjmDGqN1r+enOuNgaQ1X6D6GqY9xV
 QQhqJPQ256KmGhltU72ABKIMk4jfOFbwRSKtdESebgm5ijOFD3DxHKo01IwG8aNwFcvO
 G57w==
X-Gm-Message-State: AOJu0Yy3I2/bgJpATcQGjx3bTyHes/3n5AXUb6rQiOeuN7AazT7nUa6a
 KvTOvl/l3Pwxn2jx7KhCznLzl+T5OAoiMiQFrav/ZhJdJ54aBpyT8ua0A13gC8w=
X-Google-Smtp-Source: AGHT+IG219vImI1BZHDku9gr8F82pLv/fMRH59cMpeMLDfOaGBtYSGVR/y+A9HYr6bC+3+PoP0aQHw==
X-Received: by 2002:a17:90a:207:b0:28b:c67a:8a1b with SMTP id
 c7-20020a17090a020700b0028bc67a8a1bmr896510pjc.99.1706343989537; 
 Sat, 27 Jan 2024 00:26:29 -0800 (PST)
Received: from ?IPV6:2001:8003:c96c:3c00:f4e4:75ba:818d:188a?
 ([2001:8003:c96c:3c00:f4e4:75ba:818d:188a])
 by smtp.gmail.com with ESMTPSA id
 fr23-20020a17090ae2d700b0029004b9df9fsm4372621pjb.36.2024.01.27.00.26.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Jan 2024 00:26:29 -0800 (PST)
Message-ID: <a379e0b6-848c-469d-95f5-a759c4dee5a7@linaro.org>
Date: Sat, 27 Jan 2024 18:26:24 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 05/34] target/tricore: [VADDR] Use target_ulong for EA
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, philmd@linaro.org
References: <20240119144024.14289-1-anjo@rev.ng>
 <20240119144024.14289-6-anjo@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240119144024.14289-6-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

On 1/20/24 00:39, Anton Johansson wrote:
> Prepares target for typedef'ing abi_ptr to vaddr.  Fixes sign extension
> bug that would result from abi_ptr being unsigned in the future.
> 
> Necessary to make memory access function signatures target agnostic.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/tricore/op_helper.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

This has been fixed on master since

commit ceada000846b0cd81c578b1da9f76d0c59536654
Author: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date:   Wed Sep 13 12:53:26 2023 +0200

     target/tricore: Change effective address (ea) to target_ulong

I'm confused about the branch on which you're working...


r~

> 
> diff --git a/target/tricore/op_helper.c b/target/tricore/op_helper.c
> index 89be1ed648..f57bb39d1f 100644
> --- a/target/tricore/op_helper.c
> +++ b/target/tricore/op_helper.c
> @@ -2395,7 +2395,7 @@ static bool cdc_zero(target_ulong *psw)
>       return count == 0;
>   }
>   
> -static void save_context_upper(CPUTriCoreState *env, int ea)
> +static void save_context_upper(CPUTriCoreState *env, target_ulong ea)
>   {
>       cpu_stl_data(env, ea, env->PCXI);
>       cpu_stl_data(env, ea+4, psw_read(env));
> @@ -2415,7 +2415,7 @@ static void save_context_upper(CPUTriCoreState *env, int ea)
>       cpu_stl_data(env, ea+60, env->gpr_d[15]);
>   }
>   
> -static void save_context_lower(CPUTriCoreState *env, int ea)
> +static void save_context_lower(CPUTriCoreState *env, target_ulong ea)
>   {
>       cpu_stl_data(env, ea, env->PCXI);
>       cpu_stl_data(env, ea+4, env->gpr_a[11]);
> @@ -2435,7 +2435,7 @@ static void save_context_lower(CPUTriCoreState *env, int ea)
>       cpu_stl_data(env, ea+60, env->gpr_d[7]);
>   }
>   
> -static void restore_context_upper(CPUTriCoreState *env, int ea,
> +static void restore_context_upper(CPUTriCoreState *env, target_ulong ea,
>                                     target_ulong *new_PCXI, target_ulong *new_PSW)
>   {
>       *new_PCXI = cpu_ldl_data(env, ea);
> @@ -2456,7 +2456,7 @@ static void restore_context_upper(CPUTriCoreState *env, int ea,
>       env->gpr_d[15] = cpu_ldl_data(env, ea+60);
>   }
>   
> -static void restore_context_lower(CPUTriCoreState *env, int ea,
> +static void restore_context_lower(CPUTriCoreState *env, target_ulong ea,
>                                     target_ulong *ra, target_ulong *pcxi)
>   {
>       *pcxi = cpu_ldl_data(env, ea);


