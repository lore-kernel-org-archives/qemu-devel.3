Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 320E1D1D483
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 18:57:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdvC4-0005sW-FW; Thu, 08 Jan 2026 13:57:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdvC0-0005rd-0v
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 13:57:08 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdvBy-0000Vq-6L
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 13:57:07 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2a0fe77d141so29392745ad.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 10:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767898625; x=1768503425; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TutjKhufpIDQp2R0ury34PHI822qWwonQFp0ZfggMgY=;
 b=k5GElbAhkLznd2tYE9Cw809UeZRb0TkAnsip1GKtopDBmpYwrZ7dBiCmDN6eb7RLaW
 +UVCHJoCguq1tSCC3Y1P9+gk6OJOksPi5q84p1WqK0Sf9KXDoBm8qjsJDovbuOakcTDE
 /lKCjrjTYdISi7btk+tuRoV8xKnCXgNa3LaGTweD95/FrqY6aiahexKi+ZvSMK3QOOdM
 0dHn6VNVguj2a8CI2Pv/W+R47TH2VjbOoQHOboDispIeorNHETRRcS3hufBmarRq1utJ
 qrlWRkN42iP4eleoKs4viukXkvP3MosbPcZi2bmEapUy0spZ0eKIlLVw2NorsWEnCXAl
 ELHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767898625; x=1768503425;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TutjKhufpIDQp2R0ury34PHI822qWwonQFp0ZfggMgY=;
 b=d0CxKEE3nb/txedShvzjgN0z6GA/b/3Oj4+EVCW1FXvMuX7ZIS8NKBLH+RPusoHf0G
 M4/F2UYBXjgvfWK8Mmqbc/5QEEp8Qdv3pZITcPCjO8kvjhyGV86XrgBXcg6969jrMyMf
 hYuvVAvV+Ri37yn7x/H2UeBzuTAXeQFoKQ7UmrZ/8/Yn6APkE4JLs5Fu8ciBLQ3bUxGU
 U1d+8OdAMXI1E6IGnhHzs9iyjgyA9kQFfpwlYOrk2IBnkk6mYqI8S+Pr6Buy7KQQwnYb
 XhdsWJRU3UCz7K/eosw6zZLi0tzdF6DML4ztIEObqmhLI+do+CH/L6D8WM01FmcH/uq4
 Ygww==
X-Forwarded-Encrypted: i=1;
 AJvYcCXS6zAssYGrto7hGpErVXyME14Qr23zpqvW0cCSmA0BXuVnu0OquqqhWKQzKKq6/cxoSvFo1o8eTHcg@nongnu.org
X-Gm-Message-State: AOJu0Yyu63gfyfV5GpfwRzBpi+vxjA6zXrd3Oi/DjaJPvzDf4Oeh4FvQ
 4Z+KlWtYQOeeYwdzih+rgiWJqlv50f0tb4cFLWiDjsY0UHJfYQvP24ZSQoBkkZoBDhU=
X-Gm-Gg: AY/fxX7qzBviPDpND0DziA49y/zEFrwYgdUen/GyfKCeZ4sLqblqcv68wGdo6QUZTs9
 qfr0X31DqaUd1d8rneWjzv2ZklIA1RMSlOqVoSq0i8Rp+8AjftfsHaedPBRy0OLLQDXBMQqf3KN
 vZJ4w1NfWMSmTAJOZTbNS7pLpn+0HhyZ/CXJwV0y4upTb1/fLpB8L335eMONgK5DkmWYcMuKlPR
 F2gpWR+rI3x1YslXO2LKqDi48t7iaNS6LksN3kbiUXJxsjGeySp1HNSZBWK4Mqq8gFS8+IPr1sq
 pWOt2aXamFgZ2LwTkldYvQTcQnhY9cRTLBcLdrCOt5RhxcciZr3BcCyuY7gHwmQK40mqAKCQSAD
 GqsWf+pvfxSwkdeQP4xqUNsOOJOv5awVMN0l8Yj0LpeHk4hGHutlQkqV5g9cDzJQFF34RUBRvsP
 aMKgaU0qqaRIjUNqYx3+Prqq6OBR/6Rh0EC9l1yd3IyukkLu9xHTS5xuBO
X-Google-Smtp-Source: AGHT+IE003uAhRTLa9BLasRn0CZvr4tZ4c5azEHjJBvVn4agqzWyH3jcqGpLe4G/tcDV9GTxcbRYXg==
X-Received: by 2002:a17:902:fc4b:b0:2a0:9084:3aff with SMTP id
 d9443c01a7336-2a3ee509c6dmr67914555ad.61.1767898624502; 
 Thu, 08 Jan 2026 10:57:04 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cd3284sm86318785ad.91.2026.01.08.10.57.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 10:57:04 -0800 (PST)
Message-ID: <f089c7c9-c00f-4c19-b4b5-175873fd8c1e@linaro.org>
Date: Thu, 8 Jan 2026 10:57:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] system: Convert qemu_arch_available() to TargetInfo API
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>
References: <20260108163601.18676-1-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20260108163601.18676-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 1/8/26 8:36 AM, Philippe Mathieu-Daudé wrote:
> Get the base arch_mask from the current SysEmuTarget,
> making qemu_arch_available() target-agnostic.
> 
> We don't need the per-target QEMU_ARCH definition anymore,
> remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> v3: Return directly within switch
> v2: Prefer switch over array (pbo)
> ---
>   meson.build        |  2 --
>   system/arch_init.c | 30 -----------------------
>   target-info.c      | 60 ++++++++++++++++++++++++++++++++++++++++++++++
>   system/meson.build |  1 -
>   4 files changed, 60 insertions(+), 33 deletions(-)
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
> index 24696ff4111..774fdcd2c46 100644
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
> @@ -33,6 +34,65 @@ SysEmuTarget target_arch(void)
>       return arch;
>   }
>   
> +bool qemu_arch_available(unsigned qemu_arch_mask)
> +{
> +    switch (target_arch()) {
> +    case SYS_EMU_TARGET_ALPHA:
> +        return qemu_arch_mask & QEMU_ARCH_ALPHA;
> +    case SYS_EMU_TARGET_ARM:
> +    case SYS_EMU_TARGET_AARCH64:
> +        return qemu_arch_mask & QEMU_ARCH_ARM;
> +    case SYS_EMU_TARGET_I386:
> +    case SYS_EMU_TARGET_X86_64:
> +        return qemu_arch_mask & QEMU_ARCH_I386;
> +    case SYS_EMU_TARGET_M68K:
> +        return qemu_arch_mask & QEMU_ARCH_M68K;
> +    case SYS_EMU_TARGET_MICROBLAZE:
> +    case SYS_EMU_TARGET_MICROBLAZEEL:
> +        return qemu_arch_mask & QEMU_ARCH_MICROBLAZE;
> +    case SYS_EMU_TARGET_MIPS:
> +    case SYS_EMU_TARGET_MIPSEL:
> +    case SYS_EMU_TARGET_MIPS64:
> +    case SYS_EMU_TARGET_MIPS64EL:
> +        return qemu_arch_mask & QEMU_ARCH_MIPS;
> +    case SYS_EMU_TARGET_PPC:
> +    case SYS_EMU_TARGET_PPC64:
> +        return qemu_arch_mask & QEMU_ARCH_PPC;
> +    case SYS_EMU_TARGET_S390X:
> +        return qemu_arch_mask & QEMU_ARCH_S390X;
> +    case SYS_EMU_TARGET_SH4:
> +    case SYS_EMU_TARGET_SH4EB:
> +        return qemu_arch_mask & QEMU_ARCH_SH4;
> +    case SYS_EMU_TARGET_SPARC:
> +    case SYS_EMU_TARGET_SPARC64:
> +        return qemu_arch_mask & QEMU_ARCH_SPARC;
> +    case SYS_EMU_TARGET_XTENSA:
> +    case SYS_EMU_TARGET_XTENSAEB:
> +        return qemu_arch_mask & QEMU_ARCH_XTENSA;
> +    case SYS_EMU_TARGET_OR1K:
> +        return qemu_arch_mask & QEMU_ARCH_OPENRISC;
> +    case SYS_EMU_TARGET_TRICORE:
> +        return qemu_arch_mask & QEMU_ARCH_TRICORE;
> +    case SYS_EMU_TARGET_HPPA:
> +        return qemu_arch_mask & QEMU_ARCH_HPPA;
> +    case SYS_EMU_TARGET_RISCV32:
> +    case SYS_EMU_TARGET_RISCV64:
> +        return qemu_arch_mask & QEMU_ARCH_RISCV;
> +    case SYS_EMU_TARGET_RX:
> +        return qemu_arch_mask & QEMU_ARCH_RX;
> +    case SYS_EMU_TARGET_AVR:
> +        return qemu_arch_mask & QEMU_ARCH_AVR;
> +    /*
> +    case SYS_EMU_TARGET_HEXAGON:
> +        return qemu_arch_mask & QEMU_ARCH_HEXAGON;
> +    */
> +    case SYS_EMU_TARGET_LOONGARCH64:
> +        return qemu_arch_mask & QEMU_ARCH_LOONGARCH;
> +    default:
> +        g_assert_not_reached();

Per explaination on previous version, would be more interesting to have 
SYS_EMU_TARGET__MAX instead of default here, so compilation will be 
blocked when enum is extended.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

> +    };
> +}
> +
>   const char *target_cpu_type(void)
>   {
>       return target_info()->cpu_type;
> diff --git a/system/meson.build b/system/meson.build
> index 4b69ef0f5fb..66e16db55ce 100644
> --- a/system/meson.build
> +++ b/system/meson.build
> @@ -1,5 +1,4 @@
>   specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: [files(
> -  'arch_init.c',
>     'globals-target.c',
>   )])
>   


