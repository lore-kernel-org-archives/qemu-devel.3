Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20EF2C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 04:18:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJQHP-0004kP-Hs; Tue, 18 Jun 2024 00:17:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJQHN-0004jh-Tr
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 00:17:09 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJQHM-0004tB-57
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 00:17:09 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6f9a7120d9dso2681238a34.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 21:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718684226; x=1719289026; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b5aOExNnBKZTBkAmionRYOUYaX+t7RJjx70JQk/W6Mc=;
 b=DJFUiMIwsK8sDQ6XuIXuQ2bwef4ygep17t/BOT3JWp7aNql+SyF3Cy0Ps3m+xsFvLs
 s9pN6VE+lX0Ku1OYBJuWnRICUuUJJjh6rOAcda0fsAJi12gojhmZ2DeoGb32oIN5i5WS
 3xihscwwo3iiYzmQAEjfEU0YMpu2S4obywMdDZNyAC4DVHVGLxxB9qUQGPF4pHygTQKw
 e/hvzCzRDTouaPZfbg1bqoTxUGIpHmc3w1XveIEK4L0+y0bOgnuUKaYOcKOYb3qjPQE7
 nZilKnuge20WWq24CNnMwm4soBbKV/KZFUZ9qs6OrTbep0vIQuP8Xz8mbmxJQi/u9r5C
 j/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718684226; x=1719289026;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b5aOExNnBKZTBkAmionRYOUYaX+t7RJjx70JQk/W6Mc=;
 b=KO+EzJJQhASgv+ej75TRbnzh7B2CthoYubwWRLswK4YjLBJJUPOe1upHJP8bWumLHd
 RCsMh9Z52w3xpB/8UTWtp+6Y+1pqJmYv9HInAdBLXUAMlr+5rTcgkNBXAj2GOVQ10hjZ
 SZt8hzCl/7W+SYRxPDQzC2VinqQr029gIQk6VetRw+sa7Jy6qYd34qeYE/muRwdCLR22
 6cR0QHVnYEHXcoTi64cFgl/wUYseuUWqj2FBF6vTJLWvkNbaXwvqcU4cnQUYxCw6S9Di
 e4/4B+LLGV4tOh4Ge+3YsvtMbnRaR2zU1GyDbio1ugK819yKr/+saoWTkqxy8j1RY5RK
 NXMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWryfFqizuaf/g8Sjx6QPPwatJZNjjKZVhwsVpYZOVnl+lUIt6lGHVaQF5/500Gk2/gsu7TDbDJpnmI3FDZfeDpWcF9V0k=
X-Gm-Message-State: AOJu0Yx8dEbK8eWmudOz1d4XWLiB8oM0otNok7hhqGsymrJb2CEH73k+
 1bYpwyAnfFLW/DD6rkWi6NiAkmtlg0kX92vVVPwTtAodP2H7N6pexEZ2TkDdqw4=
X-Google-Smtp-Source: AGHT+IG5Zetgnc2kVrBxcaqvuaOv7f6ePZ5B5fAZbgk+llGAjDRl2H+rXNx9oSey+mJOWsC66/rUoA==
X-Received: by 2002:a05:6870:9a25:b0:24c:b654:c17a with SMTP id
 586e51a60fabf-25842af70b3mr12294655fac.45.1718684226588; 
 Mon, 17 Jun 2024 21:17:06 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705ccb3bf40sm8135324b3a.111.2024.06.17.21.17.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jun 2024 21:17:06 -0700 (PDT)
Message-ID: <843f41b3-5ade-47bf-9802-be94086e6168@linaro.org>
Date: Mon, 17 Jun 2024 21:17:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/23] Add CPU initialization function
To: Ajeet Singh <itachis6234@gmail.com>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Ajeet Singh <itachis@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>
References: <20240617185804.25075-1-itachis@FreeBSD.org>
 <20240617185804.25075-2-itachis@FreeBSD.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240617185804.25075-2-itachis@FreeBSD.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x329.google.com
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

On 6/17/24 11:57, Ajeet Singh wrote:
> From: Stacey Son <sson@FreeBSD.org>
> 
> Addded function to initialize ARM CPU
> and to check if it supports 64 bit mode
> 
> Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> ---
>   bsd-user/aarch64/target_arch_cpu.h | 42 ++++++++++++++++++++++++++++++
>   1 file changed, 42 insertions(+)
>   create mode 100644 bsd-user/aarch64/target_arch_cpu.h
> 
> diff --git a/bsd-user/aarch64/target_arch_cpu.h b/bsd-user/aarch64/target_arch_cpu.h
> new file mode 100644
> index 0000000000..db5c7062b9
> --- /dev/null
> +++ b/bsd-user/aarch64/target_arch_cpu.h
> @@ -0,0 +1,42 @@
> +/*
> + *  ARM AArch64 cpu init and loop
> + *
> + * Copyright (c) 2015 Stacey Son
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef TARGET_ARCH_CPU_H
> +#define TARGET_ARCH_CPU_H
> +
> +#include "target_arch.h"
> +#include "target/arm/syndrome.h"

Do you actually need syndrome.h?

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> +
> +#define TARGET_DEFAULT_CPU_MODEL "any"
> +
> +static inline void target_cpu_init(CPUARMState *env,
> +    struct target_pt_regs *regs)
> +{
> +    int i;
> +
> +    if (!(arm_feature(env, ARM_FEATURE_AARCH64))) {
> +        fprintf(stderr, "The selected ARM CPU does not support 64 bit mode\n");
> +        exit(1);
> +    }
> +    for (i = 0; i < 31; i++) {
> +        env->xregs[i] = regs->regs[i];
> +    }
> +    env->pc = regs->pc;
> +    env->xregs[31] = regs->sp;
> +}


