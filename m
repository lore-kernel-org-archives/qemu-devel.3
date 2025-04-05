Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D6BC36010
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 16:15:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u16AJ-0001hJ-Js; Sat, 05 Apr 2025 12:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u16AI-0001ZR-06
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 12:14:38 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u16AG-0005JU-94
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 12:14:37 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-306b6ae4fb2so180888a91.3
 for <qemu-devel@nongnu.org>; Sat, 05 Apr 2025 09:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743869675; x=1744474475; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uo7eJ7uFbPjlWwA1xkqprs0pNcPaSeiczOBJaEUBbcE=;
 b=TkhCTZ9eRNokmkKGQYYEVjnqUydLzZtzzZ2oIJmIzcWC5zYYSqamTWKdguheaEAw+l
 Wy20ArYxwPfWICZYbY0akDvRojISSEuXNmarTio2xer25TU5WQDGf4NoD4jKjk3M2WIx
 NR+G6+hG+I/UiFDCDPZdd96OuNEQM3Te2Ig/W9N1/Xs2Vx0A/PdFaPPVsJzeX16jRaKR
 nOn/9r7G8lPwotwBhkEho17o6Rf3lGDUXuI85dbNejmCURIcZy1CHAp1oNir7heYURBe
 XvpWkZwIekSa0PXWgqOnptyBLNrMn1v8qQvhqSlHLODusxpP/hZaBnRb/UP+In+boIqo
 Cmlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743869675; x=1744474475;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uo7eJ7uFbPjlWwA1xkqprs0pNcPaSeiczOBJaEUBbcE=;
 b=b1nRPvbDfrpCyQXQUDZ/xab1ZOdMSqIoS6yNfKX75cuFU61eZ30tg5ogvbuCdW2gQR
 CXZX7GbHytqJMcL+GL7H6YmGdj2yh190bAcTt9MXTVdFmnfyZvcDdJ3LIJ8L0+1dcL0q
 odB9ZLGHczy0kXlnn8bPqbDPl6vIRjP/ezlIPeBmsaRMpfe1n9YCzZnVutqODjrOUi4H
 uDvLCgrVaMRY0n0GauRmaT/43TFQ5ZWzmDwYQwSsLEOObmEMnTrXkZttHHFAVKvYiMfl
 cwYDByl3ABYwThow1BXH5oBnlSze3U3BCktv5luspu3V9jo/jvux+b6q1FxVnVhHde3a
 vZKA==
X-Gm-Message-State: AOJu0Ywtjh8YGP4lO0zoDiyvK3i2SwItxukv9F62uORfCO9Wza/wC6di
 1EZjaMBJTWEK2RIulxRsDeJIu/9jF1b68yL9WY3vEiYo+g7FRcWp7LCkHChbbZqkPpKNL8cyCoL
 s
X-Gm-Gg: ASbGncs9qbDuANLEd3HqyCKOnec2Cu6oWgSrbyc2Lk+JXn36yi6HrIKmRzMO/LCCiGN
 sNeeyaEcCGDF51lvLEg7VDCXqxePv0/K5LKeNic31NFCefi5juu3aSm+opNOI1bN8M/moeNoK2B
 gKALR3TP0fDUwywbjaqXTomjLQ1LYA7h/Z+qyry8uz1q40llEFpNOx0Ftw1tb7oFpcyzc4GvALe
 ZQ9nwm1zcj23QqyJiDPtBhsK8AMrf/eYc7WJQ3SrnfoXF2kWjEJvLryqpHkJnRVT5AML700N0Fj
 H0VirH9zRUORyAf0vSkXJfpMD6wD6lZVAhaj86DoMKZaIclG7ObdfUhUl5zVXjmptY1Dtkc2q28
 =
X-Google-Smtp-Source: AGHT+IHTJisTZ13gxm687OQ8gQQ6Sly850AyBlN/WrQvWIHPTNxZbBPB9IlVjBNoXRmUNs6UBfmP3A==
X-Received: by 2002:a17:90b:3a4c:b0:2fe:dd2c:f8e7 with SMTP id
 98e67ed59e1d1-306a615014emr10286214a91.10.1743869674670; 
 Sat, 05 Apr 2025 09:14:34 -0700 (PDT)
Received: from [192.168.122.15] ([173.164.107.234])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3057cb5a823sm5744935a91.34.2025.04.05.09.14.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Apr 2025 09:14:34 -0700 (PDT)
Message-ID: <e0460752-3a02-42a5-99f5-7a2634f89afd@linaro.org>
Date: Sat, 5 Apr 2025 09:14:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 4/9] target/arm/mte: Include missing headers for
 GETPC()
To: qemu-devel@nongnu.org
References: <20250404223521.38781-1-philmd@linaro.org>
 <20250404223521.38781-5-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250404223521.38781-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

On 4/4/25 15:35, Philippe Mathieu-Daudé wrote:
> Some headers are indirectly pulled in. Make their inclusion
> explicit, otherwise next commit triggers:
> 
>    target/arm/tcg/mte_helper.c:188:26: error: call to undeclared function 'GETPC' [-Wimplicit-function-declaration]
>      188 |     do_stg(env, ptr, xt, GETPC(), store_tag1);
>          |                          ^
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/tcg/mte_helper.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
> index 7dc5fb776b3..9dcdc1d91c1 100644
> --- a/target/arm/tcg/mte_helper.c
> +++ b/target/arm/tcg/mte_helper.c
> @@ -22,7 +22,7 @@
>   #include "cpu.h"
>   #include "internals.h"
>   #include "exec/exec-all.h"
> -#include "exec/page-protection.h"
> +#include "exec/target_page.h"
>   #ifdef CONFIG_USER_ONLY
>   #include "user/cpu_loop.h"
>   #include "user/page-protection.h"
> @@ -33,6 +33,7 @@
>   #include "exec/helper-proto.h"
>   #include "exec/tlb-flags.h"
>   #include "accel/tcg/cpu-ops.h"
> +#include "accel/tcg/getpc.h"
>   #include "qapi/error.h"
>   #include "qemu/guest-random.h"
>   #include "mte_helper.h"

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

