Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C16C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 17:34:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsmRv-0002KY-30; Thu, 13 Mar 2025 13:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tsmRt-0002Jv-Mp
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 13:34:25 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tsmRr-0001fC-10
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 13:34:25 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22438c356c8so25568705ad.1
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 10:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741887261; x=1742492061; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eb2FbPrNC3iUg9fQDgnU6iPWKQu6W68wsbCs/WvTyyw=;
 b=SdU9bp4TzaypryLe52v0cmfTZbpo/8RI4dvkhKsmV8GTBorS8QrRu31aHUxcK48BtP
 XnACQ9N7s3rfFW24Do49b1vktLxmqiHffAzu6sCth41NKfhaCo3hF5EhWBTAeO2wctzp
 0SHfrnw+dKvOWXqJoo9ayDL5BIiC8jZWSDBC9fY+KVADxbD4eCwd6UkuISBs5ritUvsh
 cW+bzZMSzn7XwZr1R5Sw6NBABmBP0RQvHNsvoGhCBIELVTY0Ft0oWbXGp8TfPZvni1q9
 qK/w7ODCqZuAqlBbiYCaOVLr8XicBvPs8RDhYPn3RaYT3JequJWnoxFfEcQ+ydo8cP9a
 YPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741887261; x=1742492061;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eb2FbPrNC3iUg9fQDgnU6iPWKQu6W68wsbCs/WvTyyw=;
 b=fZdofSKQHhWxC5yeDnezXf2r3bqeaCgc1ppZllFShwR8mGAdZt49sIyejIuVEeOHM4
 0btiAYjpB4y87X/jdhxtMG6QQqGwkbeuClBHTkJMbBLd6IdcRrKAfyXEeWGGAJ5iqR9G
 zrK5+WGw/GrfgBrfFKP+fCQkQnhmIggr0QTPOr6R4p1uyOcx2iiAWG3bSCDJnviwrx9F
 PoR/wDi69pwAdur9hRzlQR8Eti6YjSsARArQQQCuaXi/4Z09R64fPZxqaT6ol/ZlwI6f
 mFMLSY1nmUvXhvZ6EhzX9+wD8DxvtODLrGOMYkET/1j2E3DiIH6oOzGrZO7mn8LOtvkD
 mCzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXF4IfeNBi29yxLy50RffacE5vz7qjna48XdZvhXNW+qPJRXG1+4KVwROk5no7ATm43VuO3ajw1DqaV@nongnu.org
X-Gm-Message-State: AOJu0Yz064rpC1O2stUBVUgFOGkyRNheKEcgZQcRXSCDnm6LhUS9K7w7
 xLmOHo+Q+r3brdp0WrdJxGGrJqVNYBCbocHfDt5ozNFHcjR0mUCzjB0uUhat0ZmVxVhPMQC7DQI
 1jG4=
X-Gm-Gg: ASbGnctxUf28HIddvWdFCvjN9+yvU1tOa+TkatOS0PJKpaDb0Ix9fxFlp7wG0VvLkBE
 BqTuhf6FE3A0VAqE/hJV7N70VBAIjb+6lL56kMUryPl53SYHcoeiTCARMoXen7G9+pcBo0sfvsr
 uRYDN+Yzv/KfAeIpyMzdowiFR0Mdl+7xDS3PjPsPMLMOopqgLsqs/9KVJ4YiBkWxCv/cZMBvdiS
 feUXi20XltPSdmlqfaEjSXhGrFTQX9gZ1LI7C+z/aOgqt70sMjo+bknX8wd9C2QdVyNVi8i8pGY
 5ORFYGU8k5X5As7r6k75pJOAkQhv9E6wkKIYdwOwfhiAIaNLQIdf9gWjkQ==
X-Google-Smtp-Source: AGHT+IEP5BeyyzEbi3fYf5/S0zadYBrQ/Dla8f2K/xYTv2LfkIXKQDYm6MfOnmIl5XbGSVeXzgvinA==
X-Received: by 2002:a17:903:986:b0:223:fbc7:25f4 with SMTP id
 d9443c01a7336-225dd86635cmr5134665ad.14.1741887261422; 
 Thu, 13 Mar 2025 10:34:21 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6bd4e8dsm15927455ad.228.2025.03.13.10.34.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 10:34:21 -0700 (PDT)
Message-ID: <f9a500b2-af32-47d1-88e2-657a83ea5b87@linaro.org>
Date: Thu, 13 Mar 2025 10:34:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/37] include/exec: Split out mmap-lock.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-14-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250313034524.3069690-14-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

On 3/12/25 20:44, Richard Henderson wrote:
> Split out mmap_lock, et al from page-protection.h
> to a new header.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/internal-target.h    |  1 +
>   include/exec/mmap-lock.h       | 33 +++++++++++++++++++++++++++++++++
>   include/exec/page-protection.h | 22 ----------------------
>   accel/tcg/cpu-exec.c           |  1 +
>   accel/tcg/tb-maint.c           |  1 +
>   accel/tcg/translate-all.c      |  1 +
>   linux-user/arm/cpu_loop.c      |  1 +
>   linux-user/elfload.c           |  1 +
>   linux-user/flatload.c          |  1 +
>   linux-user/mmap.c              |  1 +
>   linux-user/syscall.c           |  1 +
>   target/arm/helper.c            |  1 +
>   12 files changed, 43 insertions(+), 22 deletions(-)
>   create mode 100644 include/exec/mmap-lock.h
> 
> diff --git a/accel/tcg/internal-target.h b/accel/tcg/internal-target.h
> index 2cdf11c905..c88f007ffb 100644
> --- a/accel/tcg/internal-target.h
> +++ b/accel/tcg/internal-target.h
> @@ -13,6 +13,7 @@
>   #include "exec/translation-block.h"
>   #include "tb-internal.h"
>   #include "tcg-target-mo.h"
> +#include "exec/mmap-lock.h"
>   
>   /*
>    * Access to the various translations structures need to be serialised
> diff --git a/include/exec/mmap-lock.h b/include/exec/mmap-lock.h
> new file mode 100644
> index 0000000000..eb02dd409c
> --- /dev/null
> +++ b/include/exec/mmap-lock.h
> @@ -0,0 +1,33 @@
> +/*
> + * QEMU user-only mmap lock, with stubs for system mode
> + *
> + *  Copyright (c) 2003 Fabrice Bellard
> + *
> + * SPDX-License-Identifier: LGPL-2.1+
> + */
> +#ifndef EXEC_MMAP_LOCK_H
> +#define EXEC_MMAP_LOCK_H
> +
> +#ifdef CONFIG_USER_ONLY
> +
> +void TSA_NO_TSA mmap_lock(void);
> +void TSA_NO_TSA mmap_unlock(void);
> +bool have_mmap_lock(void);
> +
> +static inline void mmap_unlock_guard(void *unused)
> +{
> +    mmap_unlock();
> +}
> +
> +#define WITH_MMAP_LOCK_GUARD() \
> +    for (int _mmap_lock_iter __attribute__((cleanup(mmap_unlock_guard))) \
> +         = (mmap_lock(), 0); _mmap_lock_iter == 0; _mmap_lock_iter = 1)
> +
> +#else
> +
> +static inline void mmap_lock(void) {}
> +static inline void mmap_unlock(void) {}
> +#define WITH_MMAP_LOCK_GUARD()
> +
> +#endif /* CONFIG_USER_ONLY */
> +#endif /* EXEC_MMAP_LOCK_H */
> diff --git a/include/exec/page-protection.h b/include/exec/page-protection.h
> index 3e0a8a0333..c43231af8b 100644
> --- a/include/exec/page-protection.h
> +++ b/include/exec/page-protection.h
> @@ -38,26 +38,4 @@
>    */
>   #define PAGE_PASSTHROUGH 0x0800
>   
> -#ifdef CONFIG_USER_ONLY
> -
> -void TSA_NO_TSA mmap_lock(void);
> -void TSA_NO_TSA mmap_unlock(void);
> -bool have_mmap_lock(void);
> -
> -static inline void mmap_unlock_guard(void *unused)
> -{
> -    mmap_unlock();
> -}
> -
> -#define WITH_MMAP_LOCK_GUARD() \
> -    for (int _mmap_lock_iter __attribute__((cleanup(mmap_unlock_guard))) \
> -         = (mmap_lock(), 0); _mmap_lock_iter == 0; _mmap_lock_iter = 1)
> -#else
> -
> -static inline void mmap_lock(void) {}
> -static inline void mmap_unlock(void) {}
> -#define WITH_MMAP_LOCK_GUARD()
> -
> -#endif /* !CONFIG_USER_ONLY */
> -
>   #endif
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index ef3d967e3a..372b876604 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -27,6 +27,7 @@
>   #include "disas/disas.h"
>   #include "exec/cpu-common.h"
>   #include "exec/page-protection.h"
> +#include "exec/mmap-lock.h"
>   #include "exec/translation-block.h"
>   #include "tcg/tcg.h"
>   #include "qemu/atomic.h"
> diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
> index 3f1bebf6ab..d5899ad047 100644
> --- a/accel/tcg/tb-maint.c
> +++ b/accel/tcg/tb-maint.c
> @@ -24,6 +24,7 @@
>   #include "exec/log.h"
>   #include "exec/exec-all.h"
>   #include "exec/page-protection.h"
> +#include "exec/mmap-lock.h"
>   #include "exec/tb-flush.h"
>   #include "tb-internal.h"
>   #include "system/tcg.h"
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 82bc16bd53..16e5043597 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -45,6 +45,7 @@
>   
>   #include "exec/cputlb.h"
>   #include "exec/page-protection.h"
> +#include "exec/mmap-lock.h"
>   #include "tb-internal.h"
>   #include "exec/translator.h"
>   #include "exec/tb-flush.h"
> diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
> index 10d8561f9b..cb6e17e50c 100644
> --- a/linux-user/arm/cpu_loop.c
> +++ b/linux-user/arm/cpu_loop.c
> @@ -25,6 +25,7 @@
>   #include "signal-common.h"
>   #include "semihosting/common-semi.h"
>   #include "exec/page-protection.h"
> +#include "exec/mmap-lock.h"
>   #include "user/page-protection.h"
>   #include "target/arm/syndrome.h"
>   
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 8799e4ea27..f54054dce3 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -10,6 +10,7 @@
>   #include "user/tswap-target.h"
>   #include "user/page-protection.h"
>   #include "exec/page-protection.h"
> +#include "exec/mmap-lock.h"
>   #include "exec/translation-block.h"
>   #include "user/guest-base.h"
>   #include "user-internals.h"
> diff --git a/linux-user/flatload.c b/linux-user/flatload.c
> index d5cb1830dd..4beb3ed1b9 100644
> --- a/linux-user/flatload.c
> +++ b/linux-user/flatload.c
> @@ -35,6 +35,7 @@
>   
>   #include "qemu.h"
>   #include "exec/page-protection.h"
> +#include "exec/mmap-lock.h"
>   #include "user-internals.h"
>   #include "loader.h"
>   #include "user-mmap.h"
> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
> index d1f36e6f16..f88a80c31e 100644
> --- a/linux-user/mmap.c
> +++ b/linux-user/mmap.c
> @@ -21,6 +21,7 @@
>   #include "trace.h"
>   #include "exec/log.h"
>   #include "exec/page-protection.h"
> +#include "exec/mmap-lock.h"
>   #include "exec/tb-flush.h"
>   #include "exec/translation-block.h"
>   #include "qemu.h"
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index b32de763f7..4928f0b080 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -26,6 +26,7 @@
>   #include "tcg/startup.h"
>   #include "target_mman.h"
>   #include "exec/page-protection.h"
> +#include "exec/mmap-lock.h"
>   #include "exec/tb-flush.h"
>   #include "exec/translation-block.h"
>   #include <elf.h>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index f0ead22937..8316beead3 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -14,6 +14,7 @@
>   #include "cpu-features.h"
>   #include "exec/helper-proto.h"
>   #include "exec/page-protection.h"
> +#include "exec/mmap-lock.h"
>   #include "qemu/main-loop.h"
>   #include "qemu/timer.h"
>   #include "qemu/bitops.h"

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


