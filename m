Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A536D1D483
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 16:33:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdsvv-0003fg-9E; Thu, 08 Jan 2026 11:32:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdsvt-0003ej-TU
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 11:32:22 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdsvs-00017p-1J
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 11:32:21 -0500
Received: by mail-wr1-x444.google.com with SMTP id
 ffacd0b85a97d-430f2ee2f00so1835154f8f.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 08:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767889938; x=1768494738; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d0KuGYIYvwwD+DpdYGAAaFeQ/tvfqiWPLNlcADIDK0U=;
 b=PzOF3qOh68Yz0ZwbCymIP3VPSDg8YJ/fa8r7Fdqs9ATU/W2lWL/HwPuCSRw0Mo2G0x
 JHP4KTgA7uCJ0jrWRujqvAEvlUbymcWmCGpk8Ht1Qw/lEfAfpEgQapgcTM/poePix+6j
 nzoN8yNeUav1Afz1W+3mJrLxq+ugYsubz+YxuYk+waG7s8KB29ecHAV88FYv9rl0YWDv
 LzHPvGBA4cjdH0h9WUOKaMOdkgVnBcD7aCpgZO+bFI89200gat6aZiJpDqRnA3geWvuv
 /xL35/9eeP9o3IzFXDvy+GLKFxbjgiLtQu9wUxaVSO01wZfpPyszMQC/lEi09TEyBce9
 aDAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767889938; x=1768494738;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d0KuGYIYvwwD+DpdYGAAaFeQ/tvfqiWPLNlcADIDK0U=;
 b=iWUL365II8j8xScJJB5MPbAGLrR5BOW+xhhEh74e2SyWrj63vdDcwk0CMDvUPaOm2A
 vIvHFmEmkV9KZvL+Gb3CmpMyylYPkhZcQPqny0B9p7gtSz5zF+PHV+d+OqyMtAr8jejv
 lSwqZU+TQfaMA97x7sG95T1+wgZYhlq60HYJ5P6L2C40QyAqOcPS38KVi6qdQFN8UeYp
 I9z1ybXEbtdMCG+Dms9lEKUr7hLfUOT7PcDXd7hYlvC1v6K8JN1I9pVMBB3wYtcuEYPU
 27+r8O04ebBUJ2yFvHcddXHo7Z4xDS3CXm6Dyc0+ZjMMAuJOhEVE2N5wdzlYv2MLnlxm
 NtEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7aoAqgru77xZZVVr42PGS4trxaMmjm6jZEMnQWFYJ/KBSQ+/taf+NzFms4+IjtFUdK36+j8kfCdyO@nongnu.org
X-Gm-Message-State: AOJu0YwzGnODHQGl0i92m5wlxi9h5Bi3/KNet8RERf/5KVKEg01tA6Y2
 7S1J0BEUYvXYdGprAnm1PlR4MzSq1H5VAVxk4AGea5SRXJ7HkwfDroOvFfelvPwYltI=
X-Gm-Gg: AY/fxX6qhhaq9pbNs2T/6ZCi0Hfr0eQ965ngTBHkYRuFNWs2iri7+0qP6NpW8xM7wQV
 CVnaFV1G+Nxz3elI4fOLyOCwajez58ZyTxvPn6gMjUuve4M1tVZdBRP8OIl6APWITD4SpaSaiB8
 wYaC65Iycwpt6q0ngTaz6rk8MkjcBKM6Dr4UZeokKQ21aOha8x1sKk/ICEwQhwUCtOWRAtXYNO7
 hB8QOpWFiWFn6N8aIPKaLyin8kDu9dHk2EIkCkY4XlkUvtZ5Lbfg9DMVFP4JvSMC1jZ75iO2CI/
 6czCCIGKMO1hZkTz64P/zm/HupVHhOH4V8m53pKvXvRYDQM3oecft+yaXT3mo6UTlkHdZLVGlVw
 2IgHIvOQ8JXyg5+0hSKS3zHb/3embS52IbOmULFd5Hbtb2PIdyGiuhEU/jOm31tmJdR+7XFrdLA
 xwcofLyxgVeqxO7W3fVOm5POeR+utYXJ6Ak3kgNR21Bxm8yqgBCCsoTA==
X-Google-Smtp-Source: AGHT+IHd+FwVeGgk33YEjks2XNErHIjGko5IphTmfW+sKrKd9IYfGSIJMP1WUC1q+9i0kTu/93LfrA==
X-Received: by 2002:a5d:408b:0:b0:432:58f5:fb36 with SMTP id
 ffacd0b85a97d-432c37a6bd8mr6315505f8f.47.1767889937887; 
 Thu, 08 Jan 2026 08:32:17 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df96asm16997010f8f.28.2026.01.08.08.32.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 08:32:17 -0800 (PST)
Message-ID: <dd020b19-3d3f-430c-9ff2-43787e9318c0@linaro.org>
Date: Thu, 8 Jan 2026 17:32:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system: Convert qemu_arch_available() to TargetInfo API
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20260107181025.51276-1-philmd@linaro.org>
 <9910e23d-b0ed-4211-994f-3fe97cc2d204@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <9910e23d-b0ed-4211-994f-3fe97cc2d204@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x444.google.com
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

On 8/1/26 01:36, Pierrick Bouvier wrote:
> On 1/7/26 10:10 AM, Philippe Mathieu-Daudé wrote:
>> Get the base arch_mask from the current SysEmuTarget,
>> making qemu_arch_available() target-agnostic.
>>
>> We don't need the per-target QEMU_ARCH definition anymore,
>> remove it.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   meson.build        |  2 --
>>   system/arch_init.c | 30 ------------------------------
>>   target-info.c      | 41 +++++++++++++++++++++++++++++++++++++++++
>>   system/meson.build |  1 -
>>   4 files changed, 41 insertions(+), 33 deletions(-)
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
>> index 24696ff4111..4d38767d214 100644
>> --- a/target-info.c
>> +++ b/target-info.c
>> @@ -11,6 +11,7 @@
>>   #include "qemu/target-info-qapi.h"
>>   #include "qemu/target-info-impl.h"
>>   #include "qapi/error.h"
>> +#include "system/arch_init.h"
>>   const char *target_name(void)
>>   {
>> @@ -33,6 +34,46 @@ SysEmuTarget target_arch(void)
>>       return arch;
>>   }
>> +bool qemu_arch_available(unsigned qemu_arch_mask)
>> +{
>> +    static const unsigned base_arch_mask[SYS_EMU_TARGET__MAX] = {
>> +        [SYS_EMU_TARGET_AARCH64]        = QEMU_ARCH_ARM,
>> +        [SYS_EMU_TARGET_ALPHA]          = QEMU_ARCH_ALPHA,
>> +        [SYS_EMU_TARGET_ARM]            = QEMU_ARCH_ARM,
>> +        [SYS_EMU_TARGET_AVR]            = QEMU_ARCH_AVR,
>> +        /*
>> +        [SYS_EMU_TARGET_HEXAGON]        = QEMU_ARCH_HEXAGON,
>> +        */
>> +        [SYS_EMU_TARGET_HPPA]           = QEMU_ARCH_HPPA,
>> +        [SYS_EMU_TARGET_I386]           = QEMU_ARCH_I386,
>> +        [SYS_EMU_TARGET_LOONGARCH64]    = QEMU_ARCH_LOONGARCH,
>> +        [SYS_EMU_TARGET_M68K]           = QEMU_ARCH_M68K,
>> +        [SYS_EMU_TARGET_MICROBLAZE]     = QEMU_ARCH_MICROBLAZE,
>> +        [SYS_EMU_TARGET_MICROBLAZEEL]   = QEMU_ARCH_MICROBLAZE,
>> +        [SYS_EMU_TARGET_MIPS]           = QEMU_ARCH_MIPS,
>> +        [SYS_EMU_TARGET_MIPS64]         = QEMU_ARCH_MIPS,
>> +        [SYS_EMU_TARGET_MIPS64EL]       = QEMU_ARCH_MIPS,
>> +        [SYS_EMU_TARGET_MIPSEL]         = QEMU_ARCH_MIPS,
>> +        [SYS_EMU_TARGET_OR1K]           = QEMU_ARCH_OPENRISC,
>> +        [SYS_EMU_TARGET_PPC]            = QEMU_ARCH_PPC,
>> +        [SYS_EMU_TARGET_PPC64]          = QEMU_ARCH_PPC,
>> +        [SYS_EMU_TARGET_RISCV32]        = QEMU_ARCH_RISCV,
>> +        [SYS_EMU_TARGET_RISCV64]        = QEMU_ARCH_RISCV,
>> +        [SYS_EMU_TARGET_RX]             = QEMU_ARCH_RX,
>> +        [SYS_EMU_TARGET_S390X]          = QEMU_ARCH_S390X,
>> +        [SYS_EMU_TARGET_SH4]            = QEMU_ARCH_SH4,
>> +        [SYS_EMU_TARGET_SH4EB]          = QEMU_ARCH_SH4,
>> +        [SYS_EMU_TARGET_SPARC]          = QEMU_ARCH_SPARC,
>> +        [SYS_EMU_TARGET_SPARC64]        = QEMU_ARCH_SPARC,
>> +        [SYS_EMU_TARGET_TRICORE]        = QEMU_ARCH_TRICORE,
>> +        [SYS_EMU_TARGET_X86_64]         = QEMU_ARCH_I386,
>> +        [SYS_EMU_TARGET_XTENSA]         = QEMU_ARCH_XTENSA,
>> +        [SYS_EMU_TARGET_XTENSAEB]       = QEMU_ARCH_XTENSA,
>> +    };
>> +
> 
> Just a remark: is that worth having the "static const" array approach 
> when we could have a proper switch than can be checked for 
> exhaustiveness with compiler warnings instead?

I thought 40 LoC would be simpler to review than 80, and it was
simpler to generate the template in bash.

Besides, we don't use compiler warnings for enum (such -Wswitch)
due to QAPI:
https://lore.kernel.org/qemu-devel/20230315112811.22355-1-philmd@linaro.org/

> 
> Beyond that,
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


