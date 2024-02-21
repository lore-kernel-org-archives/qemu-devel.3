Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C7D3C5478A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 20:17:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rct0x-00011v-N8; Wed, 21 Feb 2024 15:16:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rct0w-00011Q-7c
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 15:16:22 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rct0t-0006l8-Sq
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 15:16:21 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1dc0d11d1b7so26518555ad.2
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 12:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708546577; x=1709151377; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PVkpFAilUxGp8au5ffoJ9uG8M+v2FG1V+AJA3Dq5Oo4=;
 b=v9/q6JCrtpWBfoUATZJ5eZWYIqj5uobMa1+25ZpaPUyM2BXh20lZF5KVQQaJpy5BhA
 hkoExxDvekRQJz9/aAKrnPUhPOnIFpvG4Whzq7BbtWD4Y4W6x+x/9VSAKFVmoCqfsDqI
 eU/0Ol12QVFGsB6iy2mZ1KsEoFzOZ7qRJwgsvZ59MBGhvWFLONKYpUXtusWefkO4c7+G
 aOE4uDfIUpICa5epD2847M0R2Az+q+EdvG5KnQ6Q3q5AM8Q8FpgoUHWLZmK/VHR48BXx
 TZp+gWN66QhoaPk/g4+QrsY9euvYJZ09flkNwQJ3LYyouF8ZtP1mSvQo7w1YY2fEnMFc
 gLhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708546577; x=1709151377;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PVkpFAilUxGp8au5ffoJ9uG8M+v2FG1V+AJA3Dq5Oo4=;
 b=JJcmZ68ORBV4oEvZI7dm+m6AT1w/Ojgn8gbuHC+QZBzhPEriziVnz26eAVPXTAI1Pp
 mOr0T8dHNk3xH/YelZHd5M2sLUi5tHiCMcKqaBeaMfZfMOTRqAyT4vl+CiE7PKCMbiTz
 Gy2SoypxUCawCPdbN8/QcllbwzuDCfmJHT+IEwqDZk+4aNhLEvnYSy8y/gw2heUheAXE
 EHQcLI7c92p1XMXXbu7ojFpg6cdtO+7/bZ5oAV4z9di1LSwUouDAR1bD1XuDnyPaVAHL
 V5BjpQGF6vmavwUJLDeWyqApnG87IuGtqm/1wanvjb03t3zRor1lBGRyDhocrSwXVm76
 vIMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUff0q06R3Z+wou6ohTDTQs0BD5U7ea7SRwyXjm/GU7ddyEqpR1u/Ttbg9NeBybWPyG+dAtDFwS6ypalQdBFsnZjJtyAeQ=
X-Gm-Message-State: AOJu0YwruqPVGqpPZSQBuEjjEBaYHFDYzjiaLtEsY8xBwbcjJ8uXYD9f
 osKWlM5twVDy5Nl+HAG5WlF1O6NcaWGr4QSnXkpCpb0zEqX1K9LCpHP/JvZdp+w=
X-Google-Smtp-Source: AGHT+IFGIZjnN2d9q1lVqBsnK1TgcGO5Ql8wnGx9pSPQT1Prg7KMoSn44JyiyYKpXUd1jQxTd1fHKg==
X-Received: by 2002:a17:902:7593:b0:1dc:1c81:1b17 with SMTP id
 j19-20020a170902759300b001dc1c811b17mr4453755pll.55.1708546577258; 
 Wed, 21 Feb 2024 12:16:17 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 bc7-20020a170902930700b001dc486f0cb2sm88345plb.208.2024.02.21.12.16.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 12:16:16 -0800 (PST)
Message-ID: <e70ef6af-61e0-4656-a9bb-3b418b96ac2e@linaro.org>
Date: Wed, 21 Feb 2024 10:16:12 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 09/22] target/arm: Add support for FEAT_NMI,
 Non-maskable Interrupt
Content-Language: en-US
To: Jinjie Ruan <ruanjinjie@huawei.com>, peter.maydell@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240221130823.677762-1-ruanjinjie@huawei.com>
 <20240221130823.677762-10-ruanjinjie@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240221130823.677762-10-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 2/21/24 03:08, Jinjie Ruan via wrote:
> Add support for FEAT_NMI. NMI (FEAT_NMI) is an mandatory feature in
> ARMv8.8-A and ARM v9.3-A.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>   target/arm/internals.h | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index 50bff44549..fee65caba5 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -1078,6 +1078,9 @@ static inline uint32_t aarch64_pstate_valid_mask(const ARMISARegisters *id)
>       if (isar_feature_aa64_mte(id)) {
>           valid |= PSTATE_TCO;
>       }
> +    if (isar_feature_aa64_nmi(id)) {
> +        valid |= PSTATE_ALLINT;
> +    }
>   
>       return valid;
>   }

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

This patch probably should have been sorted before the MSR patches.


r~

