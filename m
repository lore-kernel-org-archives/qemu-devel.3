Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 005C3D232E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 06:59:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve6SC-00081Q-PG; Fri, 09 Jan 2026 01:58:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ve6SA-0007xf-Sp
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:58:34 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ve6S8-00032d-Gr
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:58:34 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2a12ed4d205so26400025ad.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 22:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767941911; x=1768546711; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rnM45ym2snr95Vd5EAjz6BtkZlbaHfTSvcwgB3bfGlk=;
 b=pRtNoVi1QfIWoWwkXFXODY08cRaEyJPZINVomPq9gJ3vVrjOWD4jqALE4XpXrOJyp0
 /8NqdnQmgZ1Ci7719pRBNQOXANA35ew/zdnPyFxt5jRB5YfnRHs0y21OthBoocO2e6jp
 5e8S0psvUsLsmyTp+RvK7LKd7bpfy7E/QWRrmwLISbRfsukTToEvVCIJm35IKAQw/Tua
 YfIvQHZ+RNeFBfZZlkkJPYwbs19svHPKQ8igRepWN91w42G3SBdJ5YBk+v44X+KrRdut
 Fz7lk5doeO76UIHFy5zTskv3U5SzNNfEzjvxvky3/OBnMAQIA5h/j07Z43jL1PW4iKv5
 4JEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767941911; x=1768546711;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rnM45ym2snr95Vd5EAjz6BtkZlbaHfTSvcwgB3bfGlk=;
 b=itsPVJ/s4MmoV6M2xWhZRmZDgJ95UfZEoZiSIF04k0yNaaJK7DuJ8RIdKgbNFLGaYk
 cQVHGKOHR0Rbk6hqiqIQwNzZgZTqBbXDw3ke/yAF7dV0/UMS+9Us7/cJsJeM9VziKdy2
 4VOLbEmmQG0POWpIzZdLF5jtybj7WXgx8e9n9YG7vLIK0T6hZ4Y8KqRXl0DsG9NBV1oX
 LL6uT1HgkclOwCad0g/70Ab6yyjJ48RMGDE+FuAkrtrMgT7tTcBANBvuWTl+Q8wmoEol
 gFxPa75K/NNGVjip7OV7Xk+onsSRwtxMPKEGJW6dJ3w/jl5f9kpUd+WczSRegVCOuGQG
 80eQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjXdLBku0ZQi61jCfbfx/imwi1HbY2VCyEVe7t7x3K/Gdg0L/jxSjWE/UypWTZDuxX5hUgdlEDX/3N@nongnu.org
X-Gm-Message-State: AOJu0Yw8tWvr1zF3JF6A1NKO6qAh49Yei4g4aWuBbO8UqniqwRQ4uodx
 YrbEfuGeT8MliqEYSlAe34PWXuEf9LDeQjt4yHKj/71e54xPxLpGro6OIKiExdL2/WU=
X-Gm-Gg: AY/fxX7BTrKKyrtqDYKj1a5Z3Q6gfpR0nQgneWPh4DqPEpR5OypIXpH29RqZec3I4E4
 DEkhm5nP69psMHsdo3VDa5Teki7/t5oSDKF1GHMhcQ2ZzELwaXV6Zx2IjjFNEdVzcocmCjEJqO+
 fBznz+2TH1nbfmxOgHJc7TJIepgVK4VAlvMFrF9+qlb3ee2uz1R/CrGsbQt0PKq48YaKuGc8+tR
 7r0nW+93Aie4KAMB8UvmMIQFgwn4vsUNIdVBMWDxmB4NRDSScicwW60kzFeYWD2sJGiaLhTYbHD
 s4TH4w1lm4gsqyYDDsuozxVeRFz+WZpU7mqisIfUqMtgKjGnRPsTwRTh//0KwIhkIH5M8Tn1QFk
 gInRyJd1djmP0DsEd4dKj90OlLQVWudCDDP2BUAnoWs5BsYL+OJTqFB8upRRUiPTfUKLORAB6FB
 6SU16lbFCUZmm5TgpNrSomRjZra3Gruf2KDHQhEYU7VufvliZEocM4X8bB
X-Google-Smtp-Source: AGHT+IEe6VWrhQXjY+CD2/waIceEq4TvP4WCZaSGO6txkXL/8FT8RtRYwNCsE364QT6+ztNH2Es+kA==
X-Received: by 2002:a17:903:2344:b0:2a0:b467:a7ce with SMTP id
 d9443c01a7336-2a3ee4901d0mr80816835ad.36.1767941910865; 
 Thu, 08 Jan 2026 22:58:30 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cb2b72sm96671855ad.51.2026.01.08.22.58.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 22:58:30 -0800 (PST)
Message-ID: <0e4437cd-0e4d-4e5b-9aac-c882ef1e9214@linaro.org>
Date: Thu, 8 Jan 2026 22:58:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] system: Convert qemu_arch_available() to TargetInfo API
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>
References: <20260108163601.18676-1-philmd@linaro.org>
 <f089c7c9-c00f-4c19-b4b5-175873fd8c1e@linaro.org>
 <341da906-68c9-44e9-929b-30760883178e@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <341da906-68c9-44e9-929b-30760883178e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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

On 1/8/26 9:53 PM, Philippe Mathieu-Daudé wrote:
> On 8/1/26 19:57, Pierrick Bouvier wrote:
>> On 1/8/26 8:36 AM, Philippe Mathieu-Daudé wrote:
>>> Get the base arch_mask from the current SysEmuTarget,
>>> making qemu_arch_available() target-agnostic.
>>>
>>> We don't need the per-target QEMU_ARCH definition anymore,
>>> remove it.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>> v3: Return directly within switch
>>> v2: Prefer switch over array (pbo)
>>> ---
>>>    meson.build        |  2 --
>>>    system/arch_init.c | 30 -----------------------
>>>    target-info.c      | 60 ++++++++++++++++++++++++++++++++++++++++++++++
>>>    system/meson.build |  1 -
>>>    4 files changed, 60 insertions(+), 33 deletions(-)
>>>    delete mode 100644 system/arch_init.c
>>>
>>> diff --git a/meson.build b/meson.build
>>> index 734c801cc77..435dc6e3c8e 100644
>>> --- a/meson.build
>>> +++ b/meson.build
>>> @@ -3419,8 +3419,6 @@ foreach target : target_dirs
>>>          config_target_data.set(k, v)
>>>        endif
>>>      endforeach
>>> -  config_target_data.set('QEMU_ARCH',
>>> -                         'QEMU_ARCH_' +
>>> config_target['TARGET_BASE_ARCH'].to_upper())
>>>      config_target_h += {target: configure_file(output: target + '-
>>> config-target.h',
>>>                                                   configuration:
>>> config_target_data)}
>>> diff --git a/system/arch_init.c b/system/arch_init.c
>>> deleted file mode 100644
>>> index e85736884c9..00000000000
>>> --- a/system/arch_init.c
>>> +++ /dev/null
>>> @@ -1,30 +0,0 @@
>>> -/*
>>> - * QEMU System Emulator
>>> - *
>>> - * Copyright (c) 2003-2008 Fabrice Bellard
>>> - *
>>> - * Permission is hereby granted, free of charge, to any person
>>> obtaining a copy
>>> - * of this software and associated documentation files (the
>>> "Software"), to deal
>>> - * in the Software without restriction, including without limitation
>>> the rights
>>> - * to use, copy, modify, merge, publish, distribute, sublicense, and/
>>> or sell
>>> - * copies of the Software, and to permit persons to whom the Software is
>>> - * furnished to do so, subject to the following conditions:
>>> - *
>>> - * The above copyright notice and this permission notice shall be
>>> included in
>>> - * all copies or substantial portions of the Software.
>>> - *
>>> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>>> EXPRESS OR
>>> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>>> MERCHANTABILITY,
>>> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT
>>> SHALL
>>> - * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES
>>> OR OTHER
>>> - * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
>>> ARISING FROM,
>>> - * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
>>> DEALINGS IN
>>> - * THE SOFTWARE.
>>> - */
>>> -#include "qemu/osdep.h"
>>> -#include "system/arch_init.h"
>>> -
>>> -bool qemu_arch_available(unsigned qemu_arch_mask)
>>> -{
>>> -    return qemu_arch_mask & QEMU_ARCH;
>>> -}
>>> diff --git a/target-info.c b/target-info.c
>>> index 24696ff4111..774fdcd2c46 100644
>>> --- a/target-info.c
>>> +++ b/target-info.c
>>> @@ -11,6 +11,7 @@
>>>    #include "qemu/target-info-qapi.h"
>>>    #include "qemu/target-info-impl.h"
>>>    #include "qapi/error.h"
>>> +#include "system/arch_init.h"
>>>    const char *target_name(void)
>>>    {
>>> @@ -33,6 +34,65 @@ SysEmuTarget target_arch(void)
>>>        return arch;
>>>    }
>>> +bool qemu_arch_available(unsigned qemu_arch_mask)
>>> +{
>>> +    switch (target_arch()) {
>>> +    case SYS_EMU_TARGET_ALPHA:
>>> +        return qemu_arch_mask & QEMU_ARCH_ALPHA;
>>> +    case SYS_EMU_TARGET_ARM:
>>> +    case SYS_EMU_TARGET_AARCH64:
>>> +        return qemu_arch_mask & QEMU_ARCH_ARM;
>>> +    case SYS_EMU_TARGET_I386:
>>> +    case SYS_EMU_TARGET_X86_64:
>>> +        return qemu_arch_mask & QEMU_ARCH_I386;
>>> +    case SYS_EMU_TARGET_M68K:
>>> +        return qemu_arch_mask & QEMU_ARCH_M68K;
>>> +    case SYS_EMU_TARGET_MICROBLAZE:
>>> +    case SYS_EMU_TARGET_MICROBLAZEEL:
>>> +        return qemu_arch_mask & QEMU_ARCH_MICROBLAZE;
>>> +    case SYS_EMU_TARGET_MIPS:
>>> +    case SYS_EMU_TARGET_MIPSEL:
>>> +    case SYS_EMU_TARGET_MIPS64:
>>> +    case SYS_EMU_TARGET_MIPS64EL:
>>> +        return qemu_arch_mask & QEMU_ARCH_MIPS;
>>> +    case SYS_EMU_TARGET_PPC:
>>> +    case SYS_EMU_TARGET_PPC64:
>>> +        return qemu_arch_mask & QEMU_ARCH_PPC;
>>> +    case SYS_EMU_TARGET_S390X:
>>> +        return qemu_arch_mask & QEMU_ARCH_S390X;
>>> +    case SYS_EMU_TARGET_SH4:
>>> +    case SYS_EMU_TARGET_SH4EB:
>>> +        return qemu_arch_mask & QEMU_ARCH_SH4;
>>> +    case SYS_EMU_TARGET_SPARC:
>>> +    case SYS_EMU_TARGET_SPARC64:
>>> +        return qemu_arch_mask & QEMU_ARCH_SPARC;
>>> +    case SYS_EMU_TARGET_XTENSA:
>>> +    case SYS_EMU_TARGET_XTENSAEB:
>>> +        return qemu_arch_mask & QEMU_ARCH_XTENSA;
>>> +    case SYS_EMU_TARGET_OR1K:
>>> +        return qemu_arch_mask & QEMU_ARCH_OPENRISC;
>>> +    case SYS_EMU_TARGET_TRICORE:
>>> +        return qemu_arch_mask & QEMU_ARCH_TRICORE;
>>> +    case SYS_EMU_TARGET_HPPA:
>>> +        return qemu_arch_mask & QEMU_ARCH_HPPA;
>>> +    case SYS_EMU_TARGET_RISCV32:
>>> +    case SYS_EMU_TARGET_RISCV64:
>>> +        return qemu_arch_mask & QEMU_ARCH_RISCV;
>>> +    case SYS_EMU_TARGET_RX:
>>> +        return qemu_arch_mask & QEMU_ARCH_RX;
>>> +    case SYS_EMU_TARGET_AVR:
>>> +        return qemu_arch_mask & QEMU_ARCH_AVR;
>>> +    /*
>>> +    case SYS_EMU_TARGET_HEXAGON:
>>> +        return qemu_arch_mask & QEMU_ARCH_HEXAGON;
>>> +    */
>>> +    case SYS_EMU_TARGET_LOONGARCH64:
>>> +        return qemu_arch_mask & QEMU_ARCH_LOONGARCH;
>>> +    default:
>>> +        g_assert_not_reached();
>>
>> Per explaination on previous version, would be more interesting to have
>> SYS_EMU_TARGET__MAX instead of default here, so compilation will be
>> blocked when enum is extended.
> 
> How compilation can be blocked without using -Wswitch?
>

See my previous answer on v1, -Wswitch is used:

Reading the thread above, the only mention I find is the 3rd commit that
precisely change definition because -Wswitch is enabled with clang.
And it's not only a clang thing, gcc has it in Wall also [1].

I don't mind the array approach, but maybe just add a *static* assert
making sure (SYS_EMU_TARGET__MAX-1 == SYS_EMU_TARGET_XTENSAEB) so this
file will break as soon as there is a new target added. It's simple and
the next developer who won't have to debug this will thank you.

[1] https://gcc.gnu.org/onlinedocs/gcc-14.2.0/gcc/Warning-Options.html

>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>
>>> +    };
>>> +}
>>> +
>>>    const char *target_cpu_type(void)
>>>    {
>>>        return target_info()->cpu_type;
>>> diff --git a/system/meson.build b/system/meson.build
>>> index 4b69ef0f5fb..66e16db55ce 100644
>>> --- a/system/meson.build
>>> +++ b/system/meson.build
>>> @@ -1,5 +1,4 @@
>>>    specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: [files(
>>> -  'arch_init.c',
>>>      'globals-target.c',
>>>    )])
>>
> 


