Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C37B6C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 10:05:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsfQu-0004QJ-5n; Thu, 13 Mar 2025 06:04:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsfQp-0004Pt-3u
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 06:04:51 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsfQn-0000A2-9W
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 06:04:50 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43cf848528aso6361935e9.2
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 03:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741860287; x=1742465087; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pjzyT0VpJlK8UYZq195aGahlWKbldqNF2Wk1BAE79bU=;
 b=MxjqLsrj7ej/+02Koa14+6yYhfT2GR9I66OnOc3K/N8rcP5NvQ1SDjTdHWxZ8Y0Rmj
 IHkSEz+8OJdHPihScecnXxcrNm7Sq0McZl5lqItPwDeJgYDoWx5btxXG78axzfXgONaV
 QLFXB8NMqA2aZG6HJ10wOoEBMlmKUowCzypdLIRCeM+7JKL9oI9YPj5wlnIjA0XlmAVJ
 3l5oLt8PHJ//7LmGKuAZ319fRUAMV7VZKMDTIei3dTQiLqrCvQXfXYaH1UEPV2AGsg3J
 eNzQxNqLEFr4P1zW8lLdZr1joLBid1yREBLpdM203+kwj7zlHfLWaACGIQdEckNSP4sG
 TBUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741860287; x=1742465087;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pjzyT0VpJlK8UYZq195aGahlWKbldqNF2Wk1BAE79bU=;
 b=m+MwxZR68EE8wqFO9L1jF/wLzrIzDfCmdE5SJwWn1to+RE2vHldGVwVZSTis+7AwVz
 UeaZIwY9+CpNikjdmTrCaGzph84h6nS44er9+4fBf8ZsP5PEZy+SiDT1+pAcQEvTW2Zg
 weslumCL/EX3Dx4QYdxwbTEMI05B7wtiLsLw9auj6OwpKY0Ug0pDGsfpMwt6kHtlYgyu
 hd0UTyj97E3/l//GNuvXE9x0YcNX9gmCzXh+TjUa9y8E2EHRlouFu3V3PX8j1FXEgsV/
 5eGGzWqddhTNAWa4E/XSt+AkHkE1JsgUZy6ZLZNnBS9nJ0lDepVpCxpSEeWLhBpAKe/x
 TFlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyPLkgpvLGEcAwINef+XaitMah+2R+xsM/tgjM7Fytc2cGLB3UGV03Nz8gJdDeTGw5owNtMWzQavkJ@nongnu.org
X-Gm-Message-State: AOJu0Yy9SYUcavvGZDkCaTm85MXREal9u1Vse7uaPEcFELHAewk5ZFxs
 ToUO6n9vTdamE+T0VTnsfF7UkA+MmiBEbYynQtbKHLq8eCVBlgJmJFfmMZLarFo=
X-Gm-Gg: ASbGnctEaOunQcdKvgtb7PaJZDkKXjXRZKbb437S/NzvZGB3o0UGRWo56P/cLlV0d7O
 XgDpTGXkNLkEKM8DtIEwkvjpCJSd2J7PmB5fTglNc+2IPdWBx39dsVzqLcX2ywoQ5gbhV8D7TV/
 iLUUNenwrCEWAuUdPW1DzZCSiKHiQUjEu+oOk3B8twQIVaMtlKAt8fN/hhAqXr/GIrdr+O0cxsh
 xo4h6NphzRJIv1PQd94AshwXCYbKodxiuW0JJHPJALwzEA7pkx0QVxmo4oT9mvCaj3QKeUN4KTy
 sdtxnBAgidM7TXK87V5wv/Aao1p9BFHLMgN4aOupB9A7SHvjevLSGXM7UFloilGpccYan+Y9PiH
 E0U4d1MUNhi4F5Kw=
X-Google-Smtp-Source: AGHT+IHf7Z73425ZSwPinpcsylnfZKcevFaEAZvRg/9EBrrX0Oh/XU12fbsEkMZFoVv9nPH6MAqi7A==
X-Received: by 2002:a05:600c:3502:b0:43c:f4b3:b0ad with SMTP id
 5b1f17b1804b1-43d01c12187mr98038705e9.19.1741860287379; 
 Thu, 13 Mar 2025 03:04:47 -0700 (PDT)
Received: from [192.168.1.20] (88-178-97-237.subs.proxad.net. [88.178.97.237])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d0a74d51esm48127005e9.16.2025.03.13.03.04.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 03:04:46 -0700 (PDT)
Message-ID: <1515d5ca-d6c9-4287-b171-4739382f5620@linaro.org>
Date: Thu, 13 Mar 2025 11:04:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/37] semihosting: Move user-only implementation
 out-of-line
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, pbonzini@redhat.com
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-23-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250313034524.3069690-23-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 13/3/25 04:45, Richard Henderson wrote:
> Avoid testing CONFIG_USER_ONLY in semihost.h.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/semihosting/semihost.h | 29 ++---------------------------
>   semihosting/user.c             | 30 ++++++++++++++++++++++++++++++
>   semihosting/meson.build        |  2 ++
>   3 files changed, 34 insertions(+), 27 deletions(-)
>   create mode 100644 semihosting/user.c
> 
> diff --git a/include/semihosting/semihost.h b/include/semihosting/semihost.h
> index 97d2a2ba99..b03e637578 100644
> --- a/include/semihosting/semihost.h
> +++ b/include/semihosting/semihost.h
> @@ -26,32 +26,6 @@ typedef enum SemihostingTarget {
>       SEMIHOSTING_TARGET_GDB
>   } SemihostingTarget;
>   
> -#ifdef CONFIG_USER_ONLY
> -static inline bool semihosting_enabled(bool is_user)
> -{
> -    return true;
> -}
> -
> -static inline SemihostingTarget semihosting_get_target(void)
> -{
> -    return SEMIHOSTING_TARGET_AUTO;
> -}
> -
> -static inline const char *semihosting_get_arg(int i)
> -{
> -    return NULL;
> -}
> -
> -static inline int semihosting_get_argc(void)
> -{
> -    return 0;
> -}
> -
> -static inline const char *semihosting_get_cmdline(void)
> -{
> -    return NULL;
> -}
> -#else /* !CONFIG_USER_ONLY */
>   /**
>    * semihosting_enabled:
>    * @is_user: true if guest code is in usermode (i.e. not privileged)
> @@ -59,17 +33,18 @@ static inline const char *semihosting_get_cmdline(void)
>    * Return true if guest code is allowed to make semihosting calls.
>    */
>   bool semihosting_enabled(bool is_user);
> +
>   SemihostingTarget semihosting_get_target(void);
>   const char *semihosting_get_arg(int i);
>   int semihosting_get_argc(void);
>   const char *semihosting_get_cmdline(void);
>   void semihosting_arg_fallback(const char *file, const char *cmd);
> +
>   /* for vl.c hooks */
>   void qemu_semihosting_enable(void);
>   int qemu_semihosting_config_options(const char *optstr);
>   void qemu_semihosting_chardev_init(void);
>   void qemu_semihosting_console_init(Chardev *);
> -#endif /* CONFIG_USER_ONLY */
>   void qemu_semihosting_guestfd_init(void);
>   
>   #endif /* SEMIHOST_H */
> diff --git a/semihosting/user.c b/semihosting/user.c
> new file mode 100644
> index 0000000000..f5b500493b
> --- /dev/null
> +++ b/semihosting/user.c
> @@ -0,0 +1,30 @@
> +/*
> + * Semihosting for user emulation
> + *
> + * Copyright (c) 2019 Linaro Ltd
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "semihosting/semihost.h"
> +
> +bool semihosting_enabled(bool is_user)
> +{
> +    return true;
> +}
> +
> +const char *semihosting_get_arg(int i)
> +{
> +    return NULL;
> +}
> +
> +int semihosting_get_argc(void)
> +{
> +    return 0;
> +}
> +
> +const char *semihosting_get_cmdline(void)
> +{
> +    return NULL;
> +}

Do we really need the symbols, can't they be elided now?

