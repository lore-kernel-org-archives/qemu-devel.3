Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A472FCD585E
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 00:37:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vde1D-000197-5k; Wed, 07 Jan 2026 19:36:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vde1C-00018z-GX
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 19:36:50 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vde1A-0008N8-Is
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 19:36:50 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7bb710d1d1dso2905777b3a.1
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 16:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767832606; x=1768437406; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=c8+xGVAIC4XK4G9ltEpkv7lw24oL73nwTjDALAdlg50=;
 b=OopGhyuA+NaV6plv47o4wQsntCWhvuS2q3x1PRpGKWT7rNp93lDAvKTRrUYvXALGRd
 kynJOtWbe5W58xDbrqoXnisBUOsKZ56FIPSEcgOFJCaFAj+LzydKi1oEg6/aEvYBhHLJ
 ameSsZuM8GSvPLUPja0TnKyB7FLNJG5k83qO90XWwcwlXAjZYsCLr0lI+w1+dQAqXb1p
 PJOb0X9Y/btjGwhH5BILZ08sgpfTfOvaLgpX2A8BTkORNbSx6W5wahTLj7DZE5UJkfOy
 OHsZycm+2jnCBHaOV7dUWDbQ6JVaAeOVK6Q0gKNZZYUXxrDbZrWYYoy4efcXjU+qE/fZ
 pnoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767832606; x=1768437406;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c8+xGVAIC4XK4G9ltEpkv7lw24oL73nwTjDALAdlg50=;
 b=uaAAni+GknHoPFzLa9Vo6CpatsRowPOJcIOzTw9lcsm6pahPC2Hyu9bancan2+BwHU
 ZomCxo5BOuB96YGZERg1wWqXO2msbn2ngY8rmVlu0pyE0WBukfdqHwvficXRPoMy70A7
 AgpVRW06ON1uVEqESQ5DW6PILF7PFmyd1coKoaBxsGBVdWz+pzRzhpiX+IjrvWAjo2L8
 i4apakyyfkVQXSs6a+hlh/SJAxd1Ahi7fjTAF9hfT9KFFV1/gM+9F69BfTIFLxtixrk1
 pPznDj1wbv6ZC335OmDT+2EfWTZZew5MFiUwEnDTGevRUKbOlB7deujlC2YZtzgahN8Q
 WR6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCEkEvQiYQ9XDIxLFCSXbOTS42j0cdBmTbpBluWKVgzAgjfg/AEN7cToJGeliCnfRRcrf944dkos3q@nongnu.org
X-Gm-Message-State: AOJu0Yz0jqFokELY5RiwiII5/AWDSUDqPVztGSsDhlEXT7yTeiYvsgf+
 UNLfl2DfjKHeTkBf80Ls1tv21ZRiA159JOEGrhvh+IJHYPOOA7k08/leuMSZ9uPvVeQ=
X-Gm-Gg: AY/fxX4FCD4DCA9/0NNKDVo8R6NiEy/tGoCtZY+fpHZeu5uAe6/hwYaqFxOGPQZT5TN
 32pv122P0xwrq69d7rUUpTDniuxlSGxBPnDQ7KiHyi4u1q9CjQPLSX6iDaDpiOwr7ZUAXxlZipm
 YRjUjRJeumlVKrNnmsCBCZHq3IxMLCbGBpeX28/pfyXL6hYjB0B5fAZro7D2k7eQ/fxkLdhIGEy
 jSmSjzMQzOVIUQ1TT4Hr8BBZtsZR9Os2lhSifIwbAcPeDwfMUi7DL+Vn9/t7RjmvEdnZgXZQAfu
 rVfhpPK6JKNxQV5qGi75nz+b4KdUnxX45cDsqhayz+o3ABi6m/iNm5MtBTjOG5C/4Q4hdhHVMDY
 /iV05Z9n/xG90tDcv+ARX88BS9QEKJtDkzr9vGPCHlV01o0lNkFGBPdD1k27PzYsroiqcyQCZgY
 LvKXb0aj5q9D2iOAJTMGEc54Oh5ImidWKR2Zoydy3esVKGP9xVG0kFZZzo3s93IXXmuIE=
X-Google-Smtp-Source: AGHT+IELCnjdeTJv6wehHYlQ6UNfSITbY2OprrmfY4/iO8CiomvXXx4rAiqYcSudjcGVxBFgyZJdGA==
X-Received: by 2002:a05:6a00:12cd:b0:7f7:5d81:172b with SMTP id
 d2e1a72fcca58-81b7f6ec17emr4213429b3a.42.1767832606363; 
 Wed, 07 Jan 2026 16:36:46 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-819baa195fasm5897429b3a.1.2026.01.07.16.36.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jan 2026 16:36:45 -0800 (PST)
Message-ID: <9910e23d-b0ed-4211-994f-3fe97cc2d204@linaro.org>
Date: Wed, 7 Jan 2026 16:36:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system: Convert qemu_arch_available() to TargetInfo API
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260107181025.51276-1-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20260107181025.51276-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
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

On 1/7/26 10:10 AM, Philippe Mathieu-Daudé wrote:
> Get the base arch_mask from the current SysEmuTarget,
> making qemu_arch_available() target-agnostic.
> 
> We don't need the per-target QEMU_ARCH definition anymore,
> remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   meson.build        |  2 --
>   system/arch_init.c | 30 ------------------------------
>   target-info.c      | 41 +++++++++++++++++++++++++++++++++++++++++
>   system/meson.build |  1 -
>   4 files changed, 41 insertions(+), 33 deletions(-)
>   delete mode 100644 system/arch_init.c
> 
> diff --git a/meson.build b/meson.build
> index 734c801cc77..435dc6e3c8e 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3419,8 +3419,6 @@ foreach target : target_dirs
>         config_target_data.set(k, v)
>       endif
>     endforeach
> -  config_target_data.set('QEMU_ARCH',
> -                         'QEMU_ARCH_' + config_target['TARGET_BASE_ARCH'].to_upper())
>     config_target_h += {target: configure_file(output: target + '-config-target.h',
>                                                  configuration: config_target_data)}
>   
> diff --git a/system/arch_init.c b/system/arch_init.c
> deleted file mode 100644
> index e85736884c9..00000000000
> --- a/system/arch_init.c
> +++ /dev/null
> @@ -1,30 +0,0 @@
> -/*
> - * QEMU System Emulator
> - *
> - * Copyright (c) 2003-2008 Fabrice Bellard
> - *
> - * Permission is hereby granted, free of charge, to any person obtaining a copy
> - * of this software and associated documentation files (the "Software"), to deal
> - * in the Software without restriction, including without limitation the rights
> - * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> - * copies of the Software, and to permit persons to whom the Software is
> - * furnished to do so, subject to the following conditions:
> - *
> - * The above copyright notice and this permission notice shall be included in
> - * all copies or substantial portions of the Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> - * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> - * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> - * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> - * THE SOFTWARE.
> - */
> -#include "qemu/osdep.h"
> -#include "system/arch_init.h"
> -
> -bool qemu_arch_available(unsigned qemu_arch_mask)
> -{
> -    return qemu_arch_mask & QEMU_ARCH;
> -}
> diff --git a/target-info.c b/target-info.c
> index 24696ff4111..4d38767d214 100644
> --- a/target-info.c
> +++ b/target-info.c
> @@ -11,6 +11,7 @@
>   #include "qemu/target-info-qapi.h"
>   #include "qemu/target-info-impl.h"
>   #include "qapi/error.h"
> +#include "system/arch_init.h"
>   
>   const char *target_name(void)
>   {
> @@ -33,6 +34,46 @@ SysEmuTarget target_arch(void)
>       return arch;
>   }
>   
> +bool qemu_arch_available(unsigned qemu_arch_mask)
> +{
> +    static const unsigned base_arch_mask[SYS_EMU_TARGET__MAX] = {
> +        [SYS_EMU_TARGET_AARCH64]        = QEMU_ARCH_ARM,
> +        [SYS_EMU_TARGET_ALPHA]          = QEMU_ARCH_ALPHA,
> +        [SYS_EMU_TARGET_ARM]            = QEMU_ARCH_ARM,
> +        [SYS_EMU_TARGET_AVR]            = QEMU_ARCH_AVR,
> +        /*
> +        [SYS_EMU_TARGET_HEXAGON]        = QEMU_ARCH_HEXAGON,
> +        */
> +        [SYS_EMU_TARGET_HPPA]           = QEMU_ARCH_HPPA,
> +        [SYS_EMU_TARGET_I386]           = QEMU_ARCH_I386,
> +        [SYS_EMU_TARGET_LOONGARCH64]    = QEMU_ARCH_LOONGARCH,
> +        [SYS_EMU_TARGET_M68K]           = QEMU_ARCH_M68K,
> +        [SYS_EMU_TARGET_MICROBLAZE]     = QEMU_ARCH_MICROBLAZE,
> +        [SYS_EMU_TARGET_MICROBLAZEEL]   = QEMU_ARCH_MICROBLAZE,
> +        [SYS_EMU_TARGET_MIPS]           = QEMU_ARCH_MIPS,
> +        [SYS_EMU_TARGET_MIPS64]         = QEMU_ARCH_MIPS,
> +        [SYS_EMU_TARGET_MIPS64EL]       = QEMU_ARCH_MIPS,
> +        [SYS_EMU_TARGET_MIPSEL]         = QEMU_ARCH_MIPS,
> +        [SYS_EMU_TARGET_OR1K]           = QEMU_ARCH_OPENRISC,
> +        [SYS_EMU_TARGET_PPC]            = QEMU_ARCH_PPC,
> +        [SYS_EMU_TARGET_PPC64]          = QEMU_ARCH_PPC,
> +        [SYS_EMU_TARGET_RISCV32]        = QEMU_ARCH_RISCV,
> +        [SYS_EMU_TARGET_RISCV64]        = QEMU_ARCH_RISCV,
> +        [SYS_EMU_TARGET_RX]             = QEMU_ARCH_RX,
> +        [SYS_EMU_TARGET_S390X]          = QEMU_ARCH_S390X,
> +        [SYS_EMU_TARGET_SH4]            = QEMU_ARCH_SH4,
> +        [SYS_EMU_TARGET_SH4EB]          = QEMU_ARCH_SH4,
> +        [SYS_EMU_TARGET_SPARC]          = QEMU_ARCH_SPARC,
> +        [SYS_EMU_TARGET_SPARC64]        = QEMU_ARCH_SPARC,
> +        [SYS_EMU_TARGET_TRICORE]        = QEMU_ARCH_TRICORE,
> +        [SYS_EMU_TARGET_X86_64]         = QEMU_ARCH_I386,
> +        [SYS_EMU_TARGET_XTENSA]         = QEMU_ARCH_XTENSA,
> +        [SYS_EMU_TARGET_XTENSAEB]       = QEMU_ARCH_XTENSA,
> +    };
> +

Just a remark: is that worth having the "static const" array approach 
when we could have a proper switch than can be checked for 
exhaustiveness with compiler warnings instead?

Beyond that,
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

