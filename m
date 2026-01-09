Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF18D232C5
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 05:54:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve5RD-0004DI-0a; Fri, 09 Jan 2026 00:53:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ve5R8-000485-MR
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 00:53:26 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ve5R6-0006lZ-8P
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 00:53:26 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4779cc419b2so33849525e9.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 21:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767938000; x=1768542800; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d1ur1xqgw/xaPZhSZWRF/AHUplAl0aWTEroVoaekh0E=;
 b=O4lJwgkukJ9OarOMCN4h+qFF3YqpaaZGGK05ezDya99jMYtYDg2fJX6ZIIWVD0soRW
 uRfubgdut+5yeqKVTHSIpTLA/TtrH+vhG33WTxEHMbl81PDfVTkVlKFHUTCdBmyNhwjy
 Xe0JG9kib29p4BfGVwuNtkxeFDOt99FvqO+qeiY/tnxnmqzX4Ws3V2017K7QmQFITx/W
 ljxNEg5iaYwIsuXYSjlim0NK6Xc5aYkjALUaCKuvzXhFtoQipCuM2RGd9+osROK1KmAC
 HjTYe4nhZTmNuBE2qe426I5ZIm9+rvMkWa0Su0YrbWTK5Lk+8j6e8/O+1JsEEufp+cNv
 TeWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767938000; x=1768542800;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d1ur1xqgw/xaPZhSZWRF/AHUplAl0aWTEroVoaekh0E=;
 b=qz4NRp/TcPys72iZlsQjAdIi/01NgvdZx6ElyDTyIuxBBgzmgziXmqDfH2gSdGyWNk
 ILkI1hIeQnGdj6lEpfqW+wKLn11WTMUvzJLvwsbonLZbkirfF4GQEAvzWJhZ4kL7s+pg
 1tt96NyYRTbD+XmzOpDNoZ6Qlq+DeTuQazWjUmA1uI2eHSZYZPWuKF6mb44ofGXk5oK9
 YywPHItIeIgVNQq3Ly4QKJKnDTjx6qYxxo2YbUk4Yd8qvBc7sVU0jWIA6RJQA7F9RnqC
 ucL8so1o3cIS/miNomSubOLZmUHGodxYbuV/6JkHJksuDpNDnIwz0WnYT3A8Nh9NRtbm
 wgsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyPrsLVGf+xykC13jlyF8f1EHh5eehhtdVhMAUen/UdiGGIWsaUM6xA7mzuw/Wa4DeNNT4oF/WKsCH@nongnu.org
X-Gm-Message-State: AOJu0YxNV7n08nWyHcee0oadJ4Lxxe03ZkG5YGc3WzvZ3ZSEoOe7KkkA
 NPNTWCK4+c/h0feRnZkXISaeWzwyqcwd1wMHh0+cK+B/C6RwXgbEk64CKWul0KZ+U5tXj5T4bba
 lgrN6geE=
X-Gm-Gg: AY/fxX5H8f3dT8wEmAy0ZOtIXIv6kl6nMaIBRdws7hSTktmK5OIQK8ldPQrTgLNmIXC
 YVbsyN4JcflnmaAthiHorgekyl93oAWgXh8yrDUUgOFcoEocF6pPnnQ7TOJFSKo+sOWxMGt50ga
 OO0MP4zUnRELCbHjifoTJ0Ir8QDur3elXz2DU0wN+ZL+/KUhD+z5uqQpOw5rUljekWZL5okcFXM
 6Y1pUQLrxn+5ZcKXgBGG0HqIzHGbkLgqGrW4bzJ7Atk33zmSZhRtTdQRVpXYle1c6llov15YtI7
 4Aae/bu7ge7CLHRZSYeJ9nUzIewXfBAOCQHaBMG9oy29keCE6PI6f2EzLGnPMY4ZX9X7cWVIeHn
 mriMfCORsxf/iBzLAceq0XzI/umeWJ3nOLhJRto1dduH7tTCu6pNB0HyRfGSvo9zeITlUeXJniB
 fRxuudFKerXTBoTi6C9DatLw3xbphbpFt3eLITbEq/ymJClYAZRpz8xw==
X-Google-Smtp-Source: AGHT+IG5v+Ju68lWqH82rDbPra2NiBhcl/aOtRO9P3fZxwYZj5+msRNEIQ73pfuHW6IgasDz1FiwWA==
X-Received: by 2002:a05:600c:470c:b0:477:54cd:200a with SMTP id
 5b1f17b1804b1-47d84b0a1c5mr89515835e9.6.1767938000114; 
 Thu, 08 Jan 2026 21:53:20 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f4184e1sm184870135e9.4.2026.01.08.21.53.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 21:53:19 -0800 (PST)
Message-ID: <341da906-68c9-44e9-929b-30760883178e@linaro.org>
Date: Fri, 9 Jan 2026 06:53:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] system: Convert qemu_arch_available() to TargetInfo API
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>
References: <20260108163601.18676-1-philmd@linaro.org>
 <f089c7c9-c00f-4c19-b4b5-175873fd8c1e@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <f089c7c9-c00f-4c19-b4b5-175873fd8c1e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 8/1/26 19:57, Pierrick Bouvier wrote:
> On 1/8/26 8:36 AM, Philippe Mathieu-Daudé wrote:
>> Get the base arch_mask from the current SysEmuTarget,
>> making qemu_arch_available() target-agnostic.
>>
>> We don't need the per-target QEMU_ARCH definition anymore,
>> remove it.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> v3: Return directly within switch
>> v2: Prefer switch over array (pbo)
>> ---
>>   meson.build        |  2 --
>>   system/arch_init.c | 30 -----------------------
>>   target-info.c      | 60 ++++++++++++++++++++++++++++++++++++++++++++++
>>   system/meson.build |  1 -
>>   4 files changed, 60 insertions(+), 33 deletions(-)
>>   delete mode 100644 system/arch_init.c
>>
>> diff --git a/meson.build b/meson.build
>> index 734c801cc77..435dc6e3c8e 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -3419,8 +3419,6 @@ foreach target : target_dirs
>>         config_target_data.set(k, v)
>>       endif
>>     endforeach
>> -  config_target_data.set('QEMU_ARCH',
>> -                         'QEMU_ARCH_' + 
>> config_target['TARGET_BASE_ARCH'].to_upper())
>>     config_target_h += {target: configure_file(output: target + '- 
>> config-target.h',
>>                                                  configuration: 
>> config_target_data)}
>> diff --git a/system/arch_init.c b/system/arch_init.c
>> deleted file mode 100644
>> index e85736884c9..00000000000
>> --- a/system/arch_init.c
>> +++ /dev/null
>> @@ -1,30 +0,0 @@
>> -/*
>> - * QEMU System Emulator
>> - *
>> - * Copyright (c) 2003-2008 Fabrice Bellard
>> - *
>> - * Permission is hereby granted, free of charge, to any person 
>> obtaining a copy
>> - * of this software and associated documentation files (the 
>> "Software"), to deal
>> - * in the Software without restriction, including without limitation 
>> the rights
>> - * to use, copy, modify, merge, publish, distribute, sublicense, and/ 
>> or sell
>> - * copies of the Software, and to permit persons to whom the Software is
>> - * furnished to do so, subject to the following conditions:
>> - *
>> - * The above copyright notice and this permission notice shall be 
>> included in
>> - * all copies or substantial portions of the Software.
>> - *
>> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
>> EXPRESS OR
>> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>> MERCHANTABILITY,
>> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT 
>> SHALL
>> - * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES 
>> OR OTHER
>> - * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, 
>> ARISING FROM,
>> - * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
>> DEALINGS IN
>> - * THE SOFTWARE.
>> - */
>> -#include "qemu/osdep.h"
>> -#include "system/arch_init.h"
>> -
>> -bool qemu_arch_available(unsigned qemu_arch_mask)
>> -{
>> -    return qemu_arch_mask & QEMU_ARCH;
>> -}
>> diff --git a/target-info.c b/target-info.c
>> index 24696ff4111..774fdcd2c46 100644
>> --- a/target-info.c
>> +++ b/target-info.c
>> @@ -11,6 +11,7 @@
>>   #include "qemu/target-info-qapi.h"
>>   #include "qemu/target-info-impl.h"
>>   #include "qapi/error.h"
>> +#include "system/arch_init.h"
>>   const char *target_name(void)
>>   {
>> @@ -33,6 +34,65 @@ SysEmuTarget target_arch(void)
>>       return arch;
>>   }
>> +bool qemu_arch_available(unsigned qemu_arch_mask)
>> +{
>> +    switch (target_arch()) {
>> +    case SYS_EMU_TARGET_ALPHA:
>> +        return qemu_arch_mask & QEMU_ARCH_ALPHA;
>> +    case SYS_EMU_TARGET_ARM:
>> +    case SYS_EMU_TARGET_AARCH64:
>> +        return qemu_arch_mask & QEMU_ARCH_ARM;
>> +    case SYS_EMU_TARGET_I386:
>> +    case SYS_EMU_TARGET_X86_64:
>> +        return qemu_arch_mask & QEMU_ARCH_I386;
>> +    case SYS_EMU_TARGET_M68K:
>> +        return qemu_arch_mask & QEMU_ARCH_M68K;
>> +    case SYS_EMU_TARGET_MICROBLAZE:
>> +    case SYS_EMU_TARGET_MICROBLAZEEL:
>> +        return qemu_arch_mask & QEMU_ARCH_MICROBLAZE;
>> +    case SYS_EMU_TARGET_MIPS:
>> +    case SYS_EMU_TARGET_MIPSEL:
>> +    case SYS_EMU_TARGET_MIPS64:
>> +    case SYS_EMU_TARGET_MIPS64EL:
>> +        return qemu_arch_mask & QEMU_ARCH_MIPS;
>> +    case SYS_EMU_TARGET_PPC:
>> +    case SYS_EMU_TARGET_PPC64:
>> +        return qemu_arch_mask & QEMU_ARCH_PPC;
>> +    case SYS_EMU_TARGET_S390X:
>> +        return qemu_arch_mask & QEMU_ARCH_S390X;
>> +    case SYS_EMU_TARGET_SH4:
>> +    case SYS_EMU_TARGET_SH4EB:
>> +        return qemu_arch_mask & QEMU_ARCH_SH4;
>> +    case SYS_EMU_TARGET_SPARC:
>> +    case SYS_EMU_TARGET_SPARC64:
>> +        return qemu_arch_mask & QEMU_ARCH_SPARC;
>> +    case SYS_EMU_TARGET_XTENSA:
>> +    case SYS_EMU_TARGET_XTENSAEB:
>> +        return qemu_arch_mask & QEMU_ARCH_XTENSA;
>> +    case SYS_EMU_TARGET_OR1K:
>> +        return qemu_arch_mask & QEMU_ARCH_OPENRISC;
>> +    case SYS_EMU_TARGET_TRICORE:
>> +        return qemu_arch_mask & QEMU_ARCH_TRICORE;
>> +    case SYS_EMU_TARGET_HPPA:
>> +        return qemu_arch_mask & QEMU_ARCH_HPPA;
>> +    case SYS_EMU_TARGET_RISCV32:
>> +    case SYS_EMU_TARGET_RISCV64:
>> +        return qemu_arch_mask & QEMU_ARCH_RISCV;
>> +    case SYS_EMU_TARGET_RX:
>> +        return qemu_arch_mask & QEMU_ARCH_RX;
>> +    case SYS_EMU_TARGET_AVR:
>> +        return qemu_arch_mask & QEMU_ARCH_AVR;
>> +    /*
>> +    case SYS_EMU_TARGET_HEXAGON:
>> +        return qemu_arch_mask & QEMU_ARCH_HEXAGON;
>> +    */
>> +    case SYS_EMU_TARGET_LOONGARCH64:
>> +        return qemu_arch_mask & QEMU_ARCH_LOONGARCH;
>> +    default:
>> +        g_assert_not_reached();
> 
> Per explaination on previous version, would be more interesting to have 
> SYS_EMU_TARGET__MAX instead of default here, so compilation will be 
> blocked when enum is extended.

How compilation can be blocked without using -Wswitch?

> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
>> +    };
>> +}
>> +
>>   const char *target_cpu_type(void)
>>   {
>>       return target_info()->cpu_type;
>> diff --git a/system/meson.build b/system/meson.build
>> index 4b69ef0f5fb..66e16db55ce 100644
>> --- a/system/meson.build
>> +++ b/system/meson.build
>> @@ -1,5 +1,4 @@
>>   specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: [files(
>> -  'arch_init.c',
>>     'globals-target.c',
>>   )])
> 


