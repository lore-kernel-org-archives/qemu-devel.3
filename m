Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C35C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 21:21:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhEDL-0001WO-7o; Wed, 30 Jul 2025 17:19:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhEAm-0004d9-1K
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 17:17:18 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhEAj-00006V-Qv
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 17:17:15 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-23fe2be6061so1737125ad.0
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 14:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753910232; x=1754515032; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HMOC7c6iorBoiuF2w05EPwiDgNn/tDUljKa5gEpvj98=;
 b=eVAkWzbjARm3C92pR2shwPMPfv4hk52pJ6hcwCZJdfL2JP592QAmpUzPQkIjwK/mBe
 fWmYCIUCFSPgql7jh+Gd7BQ4nolSvMyCmFn9+3RK6Cc1EZF/xhI+B28tzBkBBGWgEW5A
 AXCPVXTbm3bmQAGwSx4BHSujUUofemwoI+K8phDTo8q4hR6Gz5JILK4Wu3FMO+Ak2No1
 sg7gWpnQJcWc8P9wvr+JLOtPpuQV6/YbD3aGyIWKoc4oxkx3g2WwQQ1x1nMbAa9F8+Au
 tEX+bCifJ1odXqNSEu5vtkXDtaZk4EWQFoFrE/hMnUJmRxBthSMPytLTjZz8ArmnJe5g
 cd3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753910232; x=1754515032;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HMOC7c6iorBoiuF2w05EPwiDgNn/tDUljKa5gEpvj98=;
 b=MSVccoqq7jbYp7ogYh5P2sNPEpTchFDKMA3CvshoEQywzyjZDGdKQyAcv29C5Yj7k2
 483ppgakZRLO8CWT0qQeNucOfqc3usqGh9dc4GC6nvkYkoxERN58KKMufvp2+sXrIBE8
 zBjKFR7jTBhKyGKVn/p+V6UMTbpj9yyCctpYRFwoCKL96fUGLpb4iitLlAFx897WMEnb
 ARkK7L5irshGcre5K1o3iEsuf+DnetglPRGT/h8BIQCbkTrFv86cYlMPLlfa+v8Kcbv+
 KLArHqzaLkWdwzgopdmsBVYGLN2820MjKrYpdyUC8iuX4Z/otNqY03vdh5nXQ/3viiU9
 /r/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXloa4PFdYlPHOk6Bm+U1CQP05AonCnMZvrMxWqYz0T9RTt21C3M9YQofxQX4vG3rKlTUhErltq0f3H@nongnu.org
X-Gm-Message-State: AOJu0YyMb8CovBcHrB6do0wtIim1/80n+md6LZksba5WFXwDRkE6fzyj
 EvN9JF1edejhItfnV4dC4dE33jWJ83CNclcyYV4Mb98elSihRrHvmGVguftHUIyBsGU=
X-Gm-Gg: ASbGnctSJeQ0DDSMamjQ7yLgp5qyYej0xUM0dVvdeQORZ9d/a2l2wBOcOo6YZfqK0Ss
 DL6Gv/tVgIZ5Ub8KRyd9y6MoH2TKc7bqG7wqFhWjOc7w6JwChvj6eLp7Ihym+12TN8x0ByYUuzZ
 E7b76rwLLes/mXzpi/HeEKQSlkR7wtdZpROa3IQi1VoMIToLzzupcL9+9duu1fTSWn8b+AyAMlz
 +Fx+0XVjlYUUCPbtTwx6jsS1CFnuEyK5xLhm7qIkQmr8wFeTHUJA4pk5XGmhCFCbHgF8mhrxSSc
 w8rYpBQD2u2UhdcgSxWfPsxkZCg9aIskmKi4eGkqyQAXDwmZArLVtBFFvDMpP0q6tn3veugR0za
 5MktzmhvZJUG6X5BXzTdVjIdimXujT/omY+U=
X-Google-Smtp-Source: AGHT+IEyLuTXYUjHqxt3ta0PRmJkza35kz3PKelRuP8Y0ABqLgcEw0OD48zE5dQvZGONWv305SMRNQ==
X-Received: by 2002:a17:902:d4c6:b0:23e:3911:433e with SMTP id
 d9443c01a7336-240967c623dmr73253685ad.5.1753910232021; 
 Wed, 30 Jul 2025 14:17:12 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e8aca205sm397095ad.193.2025.07.30.14.17.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Jul 2025 14:17:11 -0700 (PDT)
Message-ID: <5174ca41-fe58-41a5-9e89-ff1bf3770eeb@linaro.org>
Date: Wed, 30 Jul 2025 14:17:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 34/82] target/arm: Remove unused env argument from
 regime_is_pan
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-35-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-35-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

On 7/27/25 1:02 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/internals.h | 2 +-
>   target/arm/ptw.c       | 6 +++---
>   2 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


