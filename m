Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47A9AC5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 18:44:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdaWT-0005Zx-D3; Fri, 23 Feb 2024 13:43:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdaBI-0006kW-8w
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 13:22:01 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdaBE-0002Nx-KS
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 13:21:55 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6e332bc65b3so694537b3a.3
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 10:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708712506; x=1709317306; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7YKUGCOPT+JdTEjJ4JcaQB9kUWGXFYEylDzP9pi6MO0=;
 b=Fq9Ba3pcwGMifIqeXsPTqQgzAqwalojiNFb61eojSiQlhLOCiugEO3Y77kDneY+vqR
 TB87yafEnQpi2ku2/n6/P6FwcmyKW6WRAJM5l5WS1CyL9z9Evtickgz5Dz6WeAgdIT8D
 yIVZ65+yFE+Hz82mhPHhtdiyxtE4F7urOKYeZU66r/sya/+XQR9dmkSe8c0xlr8U7AbG
 ytIKRkptSm8lwxAH/LiMZgdosD5UTTyziM8no54E0NixUndcVsOVt+EYQaGnjKdSKPI+
 N7pgbtPD76TgWFQxQxrfpnTQhHtHITkdZeyKqFDWDSkRt6eoHW+jTrcsLK9zRLqzXfeC
 kG2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708712506; x=1709317306;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7YKUGCOPT+JdTEjJ4JcaQB9kUWGXFYEylDzP9pi6MO0=;
 b=B+Eq8W+M/cb44Lj08ZHI1kKFox47lWjrKnH2wQJOlJh2bWWaI6mmfUKDcWcgv5UaDJ
 c+Dw0YwAVeDdH8GLSRUg605+eypMQ4tLiC6LPE9PL3JcsmJLduHbbKhgmJIQYrhCjG5S
 I4UuD2OrDqEfYVtg/IWfk2L4Sk8h49fnG8w/P0WM2sHqgSd45e5wH28P1GNhchOBWVsQ
 uoYZ31naAiUEYDZFGGxudo0bCntxP9aG4f2bmiuY04dLTo9QMo4GFeVPbsGb1hXwBxL4
 /3KzKVIsbzXCjLQGFdrkUaTNVAtCqlFvcTLCe590r/gefmKU6u95EWgs9nmnkNU0vsaF
 6YfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXH4zhXDBbuCIoE8W84I3wM3iKeVrSOZugHOik4qm0A6y6RM86gEkwjzXNIEazkG2Pf7TtNGbIB8ihU1IO3il3iqVSQpY=
X-Gm-Message-State: AOJu0YzDoo9wrQxP6O4eXnuh1m5EsdnEALwaa1lxrF/xwzFgQH691y7s
 V+yYqGCZrEn3lGzQMA3lnPAnaMpJA47K9ol+McjaqVsqwXV/zErI0RP5jQMgxLMWJyKOiQqbFsW
 g
X-Google-Smtp-Source: AGHT+IGe7rJ+I/rBfmY3V0XlmVEP964Z0SqlEKs1QKQzc0Xp/7hEcvEinllhYrvxMy4gVU2iPjzM3A==
X-Received: by 2002:aa7:9984:0:b0:6e0:9149:a964 with SMTP id
 k4-20020aa79984000000b006e09149a964mr515721pfh.10.1708712506010; 
 Fri, 23 Feb 2024 10:21:46 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 e18-20020a656792000000b005dc389409c1sm10901115pgr.93.2024.02.23.10.21.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Feb 2024 10:21:45 -0800 (PST)
Message-ID: <808e13f8-11da-4ec1-969d-d2495cbd3a88@linaro.org>
Date: Fri, 23 Feb 2024 08:21:42 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] atomic.h: Reword confusing comment for qatomic_cmpxchg
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20240223182035.1048541-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240223182035.1048541-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 2/23/24 08:20, Peter Maydell wrote:
> The qatomic_cmpxchg() and qatomic_cmpxchg__nocheck() macros have
> a comment that reads:
>   Returns the eventual value, failed or not
> 
> This is somewhere between cryptic and wrong, since the value actually
> returned is the value that was in memory before the cmpxchg.  Reword
> to match how we describe these macros in atomics.rst.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/qemu/atomic.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/qemu/atomic.h b/include/qemu/atomic.h
> index f1d3d1702a9..99110abefb3 100644
> --- a/include/qemu/atomic.h
> +++ b/include/qemu/atomic.h
> @@ -202,7 +202,7 @@
>       qatomic_xchg__nocheck(ptr, i);                          \
>   })
>   
> -/* Returns the eventual value, failed or not */
> +/* Returns the old value of '*ptr' (whether the cmpxchg failed or not) */
>   #define qatomic_cmpxchg__nocheck(ptr, old, new)    ({                   \
>       typeof_strip_qual(*ptr) _old = (old);                               \
>       (void)__atomic_compare_exchange_n(ptr, &_old, new, false,           \

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

