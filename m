Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF334C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 06:17:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rarX1-0004es-Vc; Fri, 16 Feb 2024 01:17:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rarX0-0004eQ-81
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 01:17:06 -0500
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rarWy-0006pB-Af
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 01:17:06 -0500
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-59f786b2b59so787906eaf.0
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 22:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708064223; x=1708669023; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lIB4MbW5k+2EMR52deX6osQJSdY/Sj8r8OsF7O2IKbA=;
 b=X2hv78agP/CqgnL2YvTiOTKtZ18EZ5feUH7kK/lMORAigNvrw5pbLm0owVCisbJ9lG
 s96Oj3b6u522jYFjeSgRxFuZomozjTcc+3Q3ohe4WdlVUT0hC6EZV0DgZzwaDTA8wDVg
 +VlndXlEKjfnWR3vSzzZYDu/dckCstDJ7CVNGoUZOEoaUZs7xYNv3nwV9anaGRqeyY7Y
 DG6AXoYuH9Y6LqpQZh8yzUE94uulTBMUx/OC9AXFO/vImeHG0HuI5cCE9SIL/7CG9qR5
 olJVvOaJpDTAKVVxoM4jhJlqPEZ0wN8zxJGxNkUspF5SNlstv6RSf3uO7QASwzmwsDSJ
 6UNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708064223; x=1708669023;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lIB4MbW5k+2EMR52deX6osQJSdY/Sj8r8OsF7O2IKbA=;
 b=EBGsLH3fXhXzjt9mk0juIJCav9DjZ1K9V35RRpnKuieVqr15GqXQjB+W39LChqVtZg
 xUbVXbD+1PHpTmZjsNIHBPzvxyq0tQfWWhivgvKsRzA0lXuK7fjsq8Cz9Prx7DgRAcxB
 Rg3oNQKgpv62k/e13sXme0KnbsBYwDGk5VOuDfUlcXyvEFFCFYW1bImCCJL/a+XMMRwJ
 OYQW7OjmPzX076Ol8ieQ94NO1jdM+waue0frQc99r6dP8+v3SAJbQ1QvDjjzH/fEv6A0
 ezemCBqOzUNOpQ9X02xH2FdwvI9slsdq5UOKV/C6Witi2KEgZ8y2lEUQG17HQheXWnco
 wJqQ==
X-Gm-Message-State: AOJu0YwLuoSPjgsErgpiFAsmTjYy0dpKuBqeVPwZG4CNfZAYbIBP3L4f
 HqAzKlCwaS0JYzGWCbGCAn7E8aHlZta6Xtp+CdgI0lgB54hM3+Q2F+CVB7M2tNOO0XLa4PhAYNr
 z
X-Google-Smtp-Source: AGHT+IFu3wPuRGWSsbFte3ytBB1Hbs/zNf+C6AgWBm0kC1S6Get4Kbpz0IEnoFvwoUqQi27BKD6s9g==
X-Received: by 2002:a05:6358:5717:b0:178:76f8:e626 with SMTP id
 a23-20020a056358571700b0017876f8e626mr4505059rwf.6.1708064222902; 
 Thu, 15 Feb 2024 22:17:02 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 j17-20020a056a00175100b006dbda1b19f7sm2332752pfc.159.2024.02.15.22.17.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Feb 2024 22:17:02 -0800 (PST)
Message-ID: <2e1ec6a5-a566-4729-a604-a7b2ec7aff58@linaro.org>
Date: Thu, 15 Feb 2024 20:16:59 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target: hppa: Fix unaligned double word accesses for
 hppa64
Content-Language: en-US
To: Guenter Roeck <linux@roeck-us.net>
Cc: qemu-devel@nongnu.org, Charlie Jenkins <charlie@rivosinc.com>,
 Helge Deller <deller@gmx.de>
References: <20240216053415.2163286-1-linux@roeck-us.net>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240216053415.2163286-1-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2a.google.com
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

On 2/15/24 19:34, Guenter Roeck wrote:
> -    env->psw = psw & ~(PSW_N | PSW_V | PSW_CB);
> +    if (hppa_is_pa20(env)) {
> +        env->psw = psw & ~(PSW_N | PSW_V | PSW_CB | 0xff00000000ull);
> +    } else {
> +        env->psw = psw & ~(PSW_N | PSW_V | PSW_CB);
> +    }

There are never any bits above 31 set in env->psw, because all of the CB bits are supposed 
to be stored in env->psw_cb.  Thus

   env->psw = psw & (uint32_t)~(...)

with no need for the pa20 check.

With that,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

