Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57B36D1D483
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 18:53:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdv8G-0003tM-HF; Thu, 08 Jan 2026 13:53:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdv8F-0003t5-5j
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 13:53:15 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdv8D-0006rJ-7i
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 13:53:14 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7b75e366866so927274b3a.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 10:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767898391; x=1768503191; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Et2ieIpIoGE3wM4ZNwopsl7qz50B1ngse5lsIfEuAaQ=;
 b=ml9Nn2SpVAMHNdYzQI80tt5yNBXWbAAvz/7QQ98Ev7o0gwSfl4FYs9ul4zhHQz305k
 Q774DcMY7gppVnz7FuKW9tbHPaU3ywFCJTyzcSnj5PByCS/i6nDZJ4XJU+D1MpnY9F3S
 If0UmPqjHTRmTUbIOCBtSO4ydRI9CHT97KyO3kwM56J+S7XCF6n3MGPNsH9Kn/sSD29p
 nj4XnMc/OuaNSheW2BRhJWO6aIX9OaV8k3jxtXRl+9weyS4bOi66HMTZ44gOuv0mG5bU
 yfAB92p6RMEb2jccQdDY0DB4w3apbKXfNqxP8Iz0aO4w0jgoqv6epvnToUYFcWDd5EjX
 F6Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767898391; x=1768503191;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Et2ieIpIoGE3wM4ZNwopsl7qz50B1ngse5lsIfEuAaQ=;
 b=gApiyVXZmjEOFxVuUjuyiuWgMbpvqkgwHqR/N9orIeV/hB+LQjaIirWr/1R4aKyIle
 GPS0PFWb7FramUajTdRJf+592gi6dmuFSV4frH5VyY40u26uqQ0l/GAo9ekz5N+cR1v7
 weJZINdtPiN8sN66B2NYOtUtAM7k79XAEXcUCWG+4pCJeY/1n3Gn5zGq7Purvctbo6k0
 +RxUv8MDtmfIqTXZ736R1ivfFB651ZD2t+Q0iZDGOIx0cnX4b6M75XDXHo0H/ZWw0dTl
 w+gh2Ci3akh6dVqsqiywBOI7wem1IFOFarS4nh9nrZwqfY6FgRgCwmj0ydB8EnTEsRJx
 +aLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7UlYCZfU7RPpFVP+MejZzOHLaA3TX0FvejwVyWbK1yqdde2JQxCG1FvX9lMza6iV0PgKayE7C7ct1@nongnu.org
X-Gm-Message-State: AOJu0YwMXX7N70Q/RBTH8sL1Q3MTr1KQ4wL6yLJu3Vo6ciyBPQWkzFSA
 XJhzW5exGAiFM+rg6y+X/2rGH37JWdLw47HreA70EGIDxe9lXzVCzfCQoq16ddaqpnk=
X-Gm-Gg: AY/fxX53TNCwpR6uBR9a35tHzAQMRjssG9XgmEO3mRzDzqDc42UCazX+WnF/Cln6V+s
 EpXZwP5dCmfeaXVfc8ihvXEvFGVYqOiD0sCNqYiKF2SDQL7Fxig/rEgCFVW4qvf1zDJxsuBCC9s
 Gqit6v3cYN8Joe9MCxB6y3Qu940cikq7i4YnqhlbCDDQqkUID3vDlZqGI9qP0G3A5Eyf8hVrFRq
 QTQrS64HdagSEUcSioMXt8TyZ6cqeL0ewoqgvBEP8TxTu4+BZkPZLOSeKdXQyw4e+LQyGPWytbV
 0olyf1kJ48WhR4uDi07RHbzt7YWfTPP1h4cMXv35n4JZYr2sPI8TmjZ88soEdBeD7To0kK0ClXE
 /M1cHOq95LFrO0I5W8ZISTCpCfXWM0+lR2nTXoiraI0EG7BicVaA4WDwa0CeKwmdfqUz4EaZDDr
 6lo8izBTTcHsX3gDJOXlIbxrzgX4su8DUj7uyh6M90CxeWGyaHF+t6fLXj
X-Google-Smtp-Source: AGHT+IHyoTFGeBJSPV7vcF5JgI0kWrYcMur/u408rRs30McnUhUm59PotuMgNr7FIA1o8WdHH1BAMA==
X-Received: by 2002:a05:6a00:35c6:b0:81a:b32a:9a40 with SMTP id
 d2e1a72fcca58-81b7f6e6f31mr6197461b3a.32.1767898391296; 
 Thu, 08 Jan 2026 10:53:11 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81db6e09161sm699183b3a.24.2026.01.08.10.53.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 10:53:10 -0800 (PST)
Message-ID: <b51889b4-b101-4618-83dd-2d7be9a97f0c@linaro.org>
Date: Thu, 8 Jan 2026 10:53:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system: Convert qemu_arch_available() to TargetInfo API
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20260107181025.51276-1-philmd@linaro.org>
 <9910e23d-b0ed-4211-994f-3fe97cc2d204@linaro.org>
 <dd020b19-3d3f-430c-9ff2-43787e9318c0@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <dd020b19-3d3f-430c-9ff2-43787e9318c0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42d.google.com
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

On 1/8/26 8:32 AM, Philippe Mathieu-Daudé wrote:
> On 8/1/26 01:36, Pierrick Bouvier wrote:
>> On 1/7/26 10:10 AM, Philippe Mathieu-Daudé wrote:
>>> Get the base arch_mask from the current SysEmuTarget,
>>> making qemu_arch_available() target-agnostic.
>>>
>>> We don't need the per-target QEMU_ARCH definition anymore,
>>> remove it.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>    meson.build        |  2 --
>>>    system/arch_init.c | 30 ------------------------------
>>>    target-info.c      | 41 +++++++++++++++++++++++++++++++++++++++++
>>>    system/meson.build |  1 -
>>>    4 files changed, 41 insertions(+), 33 deletions(-)
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
>>> index 24696ff4111..4d38767d214 100644
>>> --- a/target-info.c
>>> +++ b/target-info.c
>>> @@ -11,6 +11,7 @@
>>>    #include "qemu/target-info-qapi.h"
>>>    #include "qemu/target-info-impl.h"
>>>    #include "qapi/error.h"
>>> +#include "system/arch_init.h"
>>>    const char *target_name(void)
>>>    {
>>> @@ -33,6 +34,46 @@ SysEmuTarget target_arch(void)
>>>        return arch;
>>>    }
>>> +bool qemu_arch_available(unsigned qemu_arch_mask)
>>> +{
>>> +    static const unsigned base_arch_mask[SYS_EMU_TARGET__MAX] = {
>>> +        [SYS_EMU_TARGET_AARCH64]        = QEMU_ARCH_ARM,
>>> +        [SYS_EMU_TARGET_ALPHA]          = QEMU_ARCH_ALPHA,
>>> +        [SYS_EMU_TARGET_ARM]            = QEMU_ARCH_ARM,
>>> +        [SYS_EMU_TARGET_AVR]            = QEMU_ARCH_AVR,
>>> +        /*
>>> +        [SYS_EMU_TARGET_HEXAGON]        = QEMU_ARCH_HEXAGON,
>>> +        */
>>> +        [SYS_EMU_TARGET_HPPA]           = QEMU_ARCH_HPPA,
>>> +        [SYS_EMU_TARGET_I386]           = QEMU_ARCH_I386,
>>> +        [SYS_EMU_TARGET_LOONGARCH64]    = QEMU_ARCH_LOONGARCH,
>>> +        [SYS_EMU_TARGET_M68K]           = QEMU_ARCH_M68K,
>>> +        [SYS_EMU_TARGET_MICROBLAZE]     = QEMU_ARCH_MICROBLAZE,
>>> +        [SYS_EMU_TARGET_MICROBLAZEEL]   = QEMU_ARCH_MICROBLAZE,
>>> +        [SYS_EMU_TARGET_MIPS]           = QEMU_ARCH_MIPS,
>>> +        [SYS_EMU_TARGET_MIPS64]         = QEMU_ARCH_MIPS,
>>> +        [SYS_EMU_TARGET_MIPS64EL]       = QEMU_ARCH_MIPS,
>>> +        [SYS_EMU_TARGET_MIPSEL]         = QEMU_ARCH_MIPS,
>>> +        [SYS_EMU_TARGET_OR1K]           = QEMU_ARCH_OPENRISC,
>>> +        [SYS_EMU_TARGET_PPC]            = QEMU_ARCH_PPC,
>>> +        [SYS_EMU_TARGET_PPC64]          = QEMU_ARCH_PPC,
>>> +        [SYS_EMU_TARGET_RISCV32]        = QEMU_ARCH_RISCV,
>>> +        [SYS_EMU_TARGET_RISCV64]        = QEMU_ARCH_RISCV,
>>> +        [SYS_EMU_TARGET_RX]             = QEMU_ARCH_RX,
>>> +        [SYS_EMU_TARGET_S390X]          = QEMU_ARCH_S390X,
>>> +        [SYS_EMU_TARGET_SH4]            = QEMU_ARCH_SH4,
>>> +        [SYS_EMU_TARGET_SH4EB]          = QEMU_ARCH_SH4,
>>> +        [SYS_EMU_TARGET_SPARC]          = QEMU_ARCH_SPARC,
>>> +        [SYS_EMU_TARGET_SPARC64]        = QEMU_ARCH_SPARC,
>>> +        [SYS_EMU_TARGET_TRICORE]        = QEMU_ARCH_TRICORE,
>>> +        [SYS_EMU_TARGET_X86_64]         = QEMU_ARCH_I386,
>>> +        [SYS_EMU_TARGET_XTENSA]         = QEMU_ARCH_XTENSA,
>>> +        [SYS_EMU_TARGET_XTENSAEB]       = QEMU_ARCH_XTENSA,
>>> +    };
>>> +
>>
>> Just a remark: is that worth having the "static const" array approach
>> when we could have a proper switch than can be checked for
>> exhaustiveness with compiler warnings instead?
> 
> I thought 40 LoC would be simpler to review than 80, and it was
> simpler to generate the template in bash.
>
> Besides, we don't use compiler warnings for enum (such -Wswitch)
> due to QAPI:
> https://lore.kernel.org/qemu-devel/20230315112811.22355-1-philmd@linaro.org/
> 

Reading the thread above, the only mention I find is the 3rd commit that 
precisely change definition because -Wswitch is enabled with clang.
And it's not only a clang thing, gcc has it in Wall also [1].

I don't mind the array approach, but maybe just add a *static* assert 
making sure (SYS_EMU_TARGET__MAX-1 == SYS_EMU_TARGET_XTENSAEB) so this 
file will break as soon as there is a new target added. It's simple and 
the next developer who won't have to debug this will thank you.

[1] https://gcc.gnu.org/onlinedocs/gcc-14.2.0/gcc/Warning-Options.html

>>
>> Beyond that,
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 


