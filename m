Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D79D6C54E58
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 12:23:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl6aQ-0006rS-Rw; Fri, 15 Mar 2024 08:22:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rl6aO-0006qi-R9
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 08:22:56 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rl6aN-0004e7-8A
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 08:22:56 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-413f76ff0daso9621255e9.0
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 05:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710505373; x=1711110173; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6+ar7a6maRXKS2xN1AP1Ldd0vWNdIACAf5dh2nKd3pw=;
 b=DYICZNp/fErvhTBvxPwdnTM8F1wHNDcngqRtGdpG0nFchysJJt4CZ82RaK7gNdeinM
 upUk5U0kKRKyvImHWKdHmApSOW5yNbL9z2VEXQg+wsN0QuDLaR8kJ6WeM2sYRYIfXOtn
 7yXoUnWv4DcnfW/5sWIq/oxOfpP4falFatzWq+T+/wMLcxSj3j+MjloIDc61R3CTgKs5
 HxWcqbZ/lNkVHb74bXiwzbmJF/2r5GW0OEOO/C7QSyX4r9t9uI2w83UNJpFHvMguao6g
 jqFwzBcitb4CTIcCMFLxW0+4i6vuEsjSUJgm954s8gxYrN+Xu5XbJtrpMtxnjGWXb8wV
 164w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710505373; x=1711110173;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6+ar7a6maRXKS2xN1AP1Ldd0vWNdIACAf5dh2nKd3pw=;
 b=oUHtSy/6iOskYEzpJ/liZ268F2WkdDIDVH4oWtGcuudvK1xFyitep5+wbnG+LQifpe
 7m+T0AlLDW4V1Ivv2DixTxKx64kbLsCogihuyACSeFPSZdahYjvUV6LJZ0B0BwuAG5HF
 nHnozcq0YSORq+274GYxq2LKYqMLHou0ulrz02pI7ZUclo6yIl0DieevOIwfRjHXIXF8
 p7dx+kbopqcZ4IpWvmCvCXaz483Q2FVp3GOpt2WLQyKqX/l4H8tsBwbypPobZR03Dc2N
 O4+YwEKwKx1pVxfRUBmU/TPT5Rbd5gpv/L7ZRxC719AmUOHgEAfWEqcwE/kjLFaMfwrt
 6Beg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJrTiKYygoOF3k5JicAxAR42FILvTo4Y8weKsa9zCCeEnHlHUgQV/1UEZsEXWdX81UuAgCEz5Cke7Dgs+W33JkimueG20=
X-Gm-Message-State: AOJu0Yzfc3Ac1D3flrAqZqISIh4AQj9L8vFijfrshIlCgV69P06yk/E7
 3WRQ6q6gQYRiKPhP2jc3y5qEB1F9WBNdJ2DvwhF8ljPuaa9yvDfWNjhyfk1iw60=
X-Google-Smtp-Source: AGHT+IE74hK0/OSyz0kM4qpY+YvGUKC7QbA64wa10ic0ZCOi6xvOMfMGNcmyh6GJl9j7QWMKlhb9rg==
X-Received: by 2002:a05:600c:3106:b0:413:21f5:de48 with SMTP id
 g6-20020a05600c310600b0041321f5de48mr3951564wmo.18.1710505373310; 
 Fri, 15 Mar 2024 05:22:53 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.145.26])
 by smtp.gmail.com with ESMTPSA id
 i9-20020a05600c354900b00413ef6826desm5651606wmq.4.2024.03.15.05.22.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Mar 2024 05:22:52 -0700 (PDT)
Message-ID: <f46958e5-01e3-4d88-9d76-00af9d30f110@linaro.org>
Date: Fri, 15 Mar 2024 13:22:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/18] target/mips: Make MIPS_CPU common to new MIPS32_CPU
 / MIPS64_CPU types
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20231010092901.99189-1-philmd@linaro.org>
 <20231010092901.99189-18-philmd@linaro.org>
 <8d30ccda-5b81-42fd-b36c-79bbaceffa2a@linaro.org>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <8d30ccda-5b81-42fd-b36c-79bbaceffa2a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 13/10/23 06:34, Richard Henderson wrote:
> On 10/10/23 02:28, Philippe Mathieu-Daudé wrote:
>> "target/foo/cpu-qom.h" can not use any target specific definitions.
>>
>> Currently "target/mips/cpu-qom.h" defines TYPE_MIPS_CPU depending
>> on the mips(32)/mips64 build type. This doesn't scale in a
>> heterogeneous context where we need to access both types concurrently.
>>
>> In order to do that, introduce the new MIPS32_CPU / MIPS64_CPU types,
>> both inheriting a common TYPE_MIPS_CPU base type.
>>
>> Keep the current CPU types registered in mips_register_cpudef_type()
>> as 32 or 64-bit, but instead of depending on the binary built being
>> targeting 32/64-bit, check whether the CPU is 64-bit by looking at
>> the CPU_MIPS64 bit.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/mips/cpu-qom.h | 13 ++++++-------
>>   target/mips/cpu.h     |  3 +++
>>   target/mips/cpu.c     | 11 ++++++++++-
>>   3 files changed, 19 insertions(+), 8 deletions(-)
>>
>> diff --git a/target/mips/cpu-qom.h b/target/mips/cpu-qom.h
>> index 9c98ca1956..1a71509b5e 100644
>> --- a/target/mips/cpu-qom.h
>> +++ b/target/mips/cpu-qom.h
>> @@ -1,5 +1,5 @@
>>   /*
>> - * QEMU MIPS CPU
>> + * QEMU MIPS CPU QOM header (target agnostic)
>>    *
>>    * Copyright (c) 2012 SUSE LINUX Products GmbH
>>    *
>> @@ -23,13 +23,12 @@
>>   #include "hw/core/cpu.h"
>>   #include "qom/object.h"
>> -#ifdef TARGET_MIPS64
>> -#define TYPE_MIPS_CPU "mips64-cpu"
>> -#else
>> -#define TYPE_MIPS_CPU "mips-cpu"
>> -#endif
>> +#define TYPE_MIPS_CPU   "mips-cpu"
>> +#define TYPE_MIPS32_CPU "mips32-cpu"
>> +#define TYPE_MIPS64_CPU "mips64-cpu"
>> -OBJECT_DECLARE_CPU_TYPE(MIPSCPU, MIPSCPUClass, MIPS_CPU)
>> +OBJECT_DECLARE_CPU_TYPE(MIPS32CPU, MIPSCPUClass, MIPS32_CPU)
>> +OBJECT_DECLARE_CPU_TYPE(MIPS64CPU, MIPSCPUClass, MIPS64_CPU)
>>   #define MIPS_CPU_TYPE_SUFFIX "-" TYPE_MIPS_CPU
>>   #define MIPS_CPU_TYPE_NAME(model) model MIPS_CPU_TYPE_SUFFIX
>> diff --git a/target/mips/cpu.h b/target/mips/cpu.h
>> index 6b026e6bcf..3b6d0a7a8a 100644
>> --- a/target/mips/cpu.h
>> +++ b/target/mips/cpu.h
>> @@ -10,6 +10,9 @@
>>   #include "hw/clock.h"
>>   #include "mips-defs.h"
>> +/* Abstract QOM MIPS CPU, not exposed to other targets */
>> +OBJECT_DECLARE_CPU_TYPE(MIPSCPU, MIPSCPUClass, MIPS_CPU)
> 
> Why is this one moved back to cpu.h?
> You exposed TYPE_X86_CPU in i386/cpu-qom.h...

First thinking was to expose the base TYPE, so we can use QOM methods
to enumerate implementations, but not expose QOM state/class getter
for the base type (except in target/foo/). HW would use concrete
32 or 64b type state/class getter. I might be wrong, so I'll keep
the base type exposed for now. We might restrict later.

