Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C474D277C1
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 23:27:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veLsc-0005js-LF; Fri, 09 Jan 2026 18:26:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veLsa-0005je-SD
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 18:26:52 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veLsZ-00035k-Aw
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 18:26:52 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-c0c24d0f4ceso1928571a12.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 15:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768001210; x=1768606010; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=doaISFucafXcyanWywKz8cXjrjhGXB6OdnKHhXe0R7M=;
 b=wz05yn6TSa1CPAy5Rj6mLjvYbzmFQmh7iQj5RdKy5oZ3cjKla3Tl18SryHZAY5OFTW
 cEWcxmRSnRmWD+eMbhI/hlJV0upuVZhcbi5TYZTAWagbXlcgCyJnn0lns8+QIjrmQGQe
 TXxhvreK+o6cgL/D8EqHQJkvlF6Y/VjHOnvyymQvMoPat7j7NbInwK99yugFkzkd4mVr
 UgvtrRqxOsoKBiztbCUUqdoPASggDZ9IIkzXN0qNYb312yXrdxauHroqGZQ3SKHGLqo0
 u0B6bY4z7lQDZaZaN3I+9FFt5VWUg9XI0Hb7X4f+3YHBi8Ko5FAZweA1MXYLNN6xqC9J
 O4OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768001210; x=1768606010;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=doaISFucafXcyanWywKz8cXjrjhGXB6OdnKHhXe0R7M=;
 b=HtY0MifkLAk1lpmoAr0DE2oa0m+fCICke9OTmCyQqe5X8XEXx5GYP/zFE2UosjOU/0
 WFEuIIbfVYefgKDOM+rLYvfH384dxRurJYEckvEh55mmuw2WAMsCWlPBIok4ASCCkq8g
 oyHZNGwwXPrE6TvXLLUMD18ISX6dIOXqWkobRQIVSF4vdTL3TrpVMP9+Z5zXm/cEcLDd
 j7Zl1ghh7W/dF+JWYJQzP3RIW0V2WVg2XOHWnLtKBzmSmIq8ofc5s+2mMeiY0ZnLt3HL
 jbkDGo0f9rJMm7NqhFqJE+y7J7qTEl+g0XylQYezeWEgr+0IJb5oglO5313TS8MdDGWW
 s6dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUueIEDj+JsTXO8pWI2TQgphXjIqiKPAwCHGAO3zIlEpHZvJ8+YMphKjsFXcQgRmh+nNX2hlCnd5+TU@nongnu.org
X-Gm-Message-State: AOJu0YxgRjD+lQ+aMGBpTYgW5ZGNe7ftxKBlt/TwhmtXmfp+6mSSQrO2
 gUnMZ++5ImPPi91VH4FqE+LdepVenvpm4tDujFF/J5IcbScXV7WIMkPSHSNRF057cmo=
X-Gm-Gg: AY/fxX70hYyJw6xuxpnRpgM4CDMJoOjVRGVi+5NfjR2pcpHfMsaJk7przrg3Psy/zKj
 qYlEvG1GDAAPoCFUawHlOBsb1WDijhMZG8OaNeqXEFNHzobn4iDOaCzmIlyTjoHNISQrX1Jk0nZ
 Eaq3GhjmikGYtWHht+ZvK2fPsuVj8lc9LPoMSJSiKvXlBY/3Gge+VZAJaNoga4vZ9O/bVQ5glt3
 NQmYG14JM2yCdKFLL/KxtC8RSgglqzjZz5Ot46Ix+yYNYgDdddM2iJQKpRZSfgOlMc/x7QbhdG4
 helmPTmX7sBNyPGZA5k0bwz1I2e+3kn/XiV2j1nU7r8qIKDEzxzJ1EOkCNmdReKYWqbCcyObGK6
 AdubvQ4dAQqOHOU9tLEvjOfhS8Tr57Roc188qqIEV28zr+rgaVYeylFoCo3IuHggrKHWWRALtO9
 PZZamFzRr1oUk9TXLfASyAsvCOOw==
X-Google-Smtp-Source: AGHT+IF3gJLQUt5fxOSnBhwl54bEM4SWzZub2FxSSA/0/Pi0HJitfdeZk63cjlcp0xmzyYZ43zaUTQ==
X-Received: by 2002:a17:90b:5643:b0:343:a631:28a8 with SMTP id
 98e67ed59e1d1-34f68cf39e6mr11162641a91.37.1768001209585; 
 Fri, 09 Jan 2026 15:26:49 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f5f88e968sm11603333a91.9.2026.01.09.15.26.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 15:26:49 -0800 (PST)
Message-ID: <6e00c981-954c-41fc-9300-348efca1483a@linaro.org>
Date: Sat, 10 Jan 2026 10:26:43 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 20/22] system: Allow restricting the legacy
 DEVICE_NATIVE_ENDIAN definition
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260109165058.59144-1-philmd@linaro.org>
 <20260109165058.59144-21-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260109165058.59144-21-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

On 1/10/26 03:50, Philippe Mathieu-Daudé wrote:
> Guard the native endian definition we want to remove by surrounding
> it with TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API #ifdef'ry.
> Assign values to the enumerators so they stay unchanged.
> 
> Once a target gets cleaned we'll set the definition in the target
> config, then the target won't be able to use the legacy API anymore.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/system/memory.h  | 8 +++++---
>   system/memory-internal.h | 2 ++
>   2 files changed, 7 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> 
> diff --git a/include/system/memory.h b/include/system/memory.h
> index 92028dc7a4e..8f8725ea2d5 100644
> --- a/include/system/memory.h
> +++ b/include/system/memory.h
> @@ -27,9 +27,11 @@
>   #include "qemu/rcu.h"
>   
>   enum device_endian {
> -    DEVICE_NATIVE_ENDIAN,
> -    DEVICE_BIG_ENDIAN,
> -    DEVICE_LITTLE_ENDIAN,
> +#ifndef TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API
> +    DEVICE_NATIVE_ENDIAN = 0,
> +#endif
> +    DEVICE_BIG_ENDIAN = 1,
> +    DEVICE_LITTLE_ENDIAN = 2,
>   };
>   
>   #define RAM_ADDR_INVALID (~(ram_addr_t)0)
> diff --git a/system/memory-internal.h b/system/memory-internal.h
> index 46f758fa7e4..5f0524756eb 100644
> --- a/system/memory-internal.h
> +++ b/system/memory-internal.h
> @@ -41,9 +41,11 @@ void mtree_print_dispatch(struct AddressSpaceDispatch *d,
>   /* returns true if end is big endian. */
>   static inline bool devend_big_endian(enum device_endian end)
>   {
> +#ifndef TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API
>       if (end == DEVICE_NATIVE_ENDIAN) {
>           return target_big_endian();
>       }
> +#endif
>       return end == DEVICE_BIG_ENDIAN;
>   }
>   


