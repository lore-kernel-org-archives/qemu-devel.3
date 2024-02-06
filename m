Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 746A7C4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 20:39:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXSDJ-0001gB-3w; Tue, 06 Feb 2024 15:38:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXSDG-0001fJ-OZ
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 15:38:38 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXSDD-0008SJ-Rh
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 15:38:37 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-296043e44caso4742791a91.0
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 12:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707251914; x=1707856714; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QPZ4nDHu4Px4WR+0uxKo54dRmPzuN2VdMewUhXIXBr0=;
 b=jQFNRU0O8N9HFdAndTeUM8MN6P5kQ5vglU0pUIirVHQPklsb/ZEGE+UBQBz/jiFJB6
 lqOEs4jUMXLz4RuB4VoCr0V6btiR/ETrf1tuix52Nk2sZvCRvhjJt9EY4TpdmBcNqpzC
 kKotoMV+sIYnlqRWf5OSn5AQxZvYZ77WCJzyxE5b39QB3KB9IuBj3a1Qc3LJkPEpS4qE
 4t7nWY9WeUxIvHO8cdmP02B4A7pDBiGNRUWL5fAXXbvPM6zihHuDMZdoOlc2J/AaGYeU
 IneT/DnD3Mz6K/jhwhSN3fMjnd3TC6SQQq72cW70B7FqHgUQI+PtUVHe6hvFXwxwIPnv
 1Q0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707251914; x=1707856714;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QPZ4nDHu4Px4WR+0uxKo54dRmPzuN2VdMewUhXIXBr0=;
 b=ROwqE1s57+3WAFYMbmhFXiLe1Bp/reIPuWsAXqWrAoWvid+0dR5+kPisQ1q/6O+fIh
 hrEy3tWtHqwa93lXqL4UnB4wYBAwDoOz709aMs+mrnallbcn6ETfih9BL8rCbyOGqSN7
 LhRea5dRCxDub+8B5HJMX3uByxFOE0CEeFfzmF6ZFqCI9w48iGjmb6dby6F7EwXXlbHb
 TGDKyK4/7Qx340o2A+y1pQ51M7f8MOKtWNn6JA817WfCy0KvGh80boPQJexlpNJFiZRi
 Ce1kyVxglNqe52PUnVO4CyLkMD2LIuDAC57nmxlx9Zl0dl49gucRVERCClJLS+YtWlSN
 wqmQ==
X-Gm-Message-State: AOJu0YxPCpz7nMd1gdLjjI+XB3Jg1Y+mq483X8/1LDdJCdz+6p6dJM6q
 CZkz7QvshPe0JOX3VRXzpxpRwjJdSx6K9rv8OkJQ8ItCJlweASZGD0DeyHCG8cg=
X-Google-Smtp-Source: AGHT+IGmjZA9X5202UMS9HSOFLmTbhi+an2I7NmdMEuEmlNbIo/LRQBnVTh9DApdf8lZfztVbzrGpg==
X-Received: by 2002:a17:90b:4f42:b0:296:12df:a93a with SMTP id
 pj2-20020a17090b4f4200b0029612dfa93amr643643pjb.46.1707251914053; 
 Tue, 06 Feb 2024 12:38:34 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWBIRvlNQcIfA7GhgcfXISj3HWTO+j9F/XKaBi/tBh4g9FUWyKJ8u88j8MWaajk6+27qHoJ+XpN9WzJ0V+kiiX2SG61FU3J5WTb2hJECEVRh07n8iQIMZneZmw=
Received: from [192.168.0.100] ([43.252.112.200])
 by smtp.gmail.com with ESMTPSA id
 qa7-20020a17090b4fc700b00296a7abe2aasm2199219pjb.8.2024.02.06.12.38.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Feb 2024 12:38:33 -0800 (PST)
Message-ID: <668729ae-4305-4a6d-9f95-c92fea6cfcbd@linaro.org>
Date: Wed, 7 Feb 2024 06:38:28 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/13] target/arm: The Cortex-R52 has a read-only CBAR
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240206132931.38376-1-peter.maydell@linaro.org>
 <20240206132931.38376-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240206132931.38376-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 2/6/24 23:29, Peter Maydell wrote:
> The Cortex-R52 implements the Configuration Base Address Register
> (CBAR), as a read-only register.  Add ARM_FEATURE_CBAR_RO to this CPU
> type, so that our implementation provides the register and the
> associated qdev property.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/tcg/cpu32.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
> index 11253051156..311d654cdce 100644
> --- a/target/arm/tcg/cpu32.c
> +++ b/target/arm/tcg/cpu32.c
> @@ -809,6 +809,7 @@ static void cortex_r52_initfn(Object *obj)
>       set_feature(&cpu->env, ARM_FEATURE_PMSA);
>       set_feature(&cpu->env, ARM_FEATURE_NEON);
>       set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
> +    set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

I just noticed that arm_cpu_post_init can be simplified to not check CBAR_RO, now that we 
have arm_cpu_propagate_feature_implications.


r~


