Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B1FC0218D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 10:04:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tciRs-0006Fo-0o; Tue, 28 Jan 2025 05:04:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tciRp-0006F3-Tp
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 05:03:58 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tciRn-00039O-6U
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 05:03:57 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-436326dcb1cso36196135e9.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 02:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738058633; x=1738663433; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9uqJX2oI4fCPCTOIS5RDd0AcD7R3HS4SdmzMVhiheCE=;
 b=W9ypjucRMeGJbzyXvSzs4EGxo4zZT8pYurQP/Lo+fSFb4lgdbBEzdMZpYN/JYfEH+l
 do7tRz1gUuapNMwDvw3Wzs5psjuScacyTWLWHf7rnYwXCUP9vlIIQMG6FzOrxYJUvt9u
 1CvwlMeoKtx+tmMuWUlZH+Yn/Dwke6YWPFwgSuPVuLcOUsx6218XYU51OPjP00E6h7ov
 3gK+obRvqW8dxxkbHy1t/C0XwGvkwBod5T47kPdpUgWcABwI0iX+NX6i21wLFGZX078+
 0MEgRy0op5C/9ynmgF4nLRxX1Fyzbg3d2Y60WnN1fyA9ev0ovMYjI5OxHl8EGbSQ/v6Y
 jQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738058633; x=1738663433;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9uqJX2oI4fCPCTOIS5RDd0AcD7R3HS4SdmzMVhiheCE=;
 b=evzs608HLjmENmeF62ZRz2NRrO4vIOV5kyfnnkQKbi+vCe27ZJHNZDPo+FU/JW59Uu
 GZS0b0UUU7RMgDQA2iE9AGvYqiAighJCArVj72P5xZUa17BzlfQD9OX8v2mZwp1WM89a
 yBEX3sq0rs61QvspmTvmbnAQEzEq8JYlVwhQskENK1HW0q+rdPHr4cFzHOibfLmiygiw
 f9fWh7VSsKzerVB2tWtURCL6kOf1jxfA+pEkr7dBIuaD2DCFhKSOiM3CPt7V0bCptB0F
 NIgS4kQBu2/b/3yA/ldPsXNN2biggdmneBB6oE/+uy64adWkQdoKpozz+jh29heo0HZN
 t2aQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVe4/1glMmj6V8JIYF3+5O3TYOMN6qU30Qz8Uam+mwbIqYgdOig/MFxk+4TIv39vHAxK5sq+qZAwhA0@nongnu.org
X-Gm-Message-State: AOJu0YyfDmEUROs91R0cbuY5/6b0dtnufP/zMi2A/KguFZKUN+yPGzGz
 fLqBo7LNFRPby6lu+4rHJnAM5m8EyvaygZxZgdQLsSG6GDN7XdnxQENYPvudyFU=
X-Gm-Gg: ASbGncuqKnqWBmROTMeniVR7aRwNkXZa9hWFWX8fn9UPqD+P5kOBDd6IoXG5Fn6lD3z
 RHTQWB+6fOFF2s9s3DkVr3W63LurjSp55tRQ8yKWl47c4lI/Mly/z3Bxnu0cSOMDhDjD39nRoyx
 XJ2DozBBPVBd1OyeQXyEfHXlUZkayc0JpIxL4NTW8H8eEQQP4XsQEGZlpVFOZ0PUw92skkSL3ig
 yZBnwFR99Ued2SRQn2+ZP0GRPZ7NUBtS8nn1ROjBVsVSsovut58rRPMhAjqTYerXMHCycXRIgzV
 jGNCC/1fFkCls+9O8NX8iPzcv0dznUjirPCREyIRZ23fV9o/BivHMJlKm/o=
X-Google-Smtp-Source: AGHT+IGaOcMpCGe76iDjpx5qEM9lOSi38d6L8VHCuNy623Ooa/GGfLgW9kPVgf3phKuOTHzmH/jPig==
X-Received: by 2002:a5d:4e86:0:b0:38b:d824:df3 with SMTP id
 ffacd0b85a97d-38bf57890e3mr31075084f8f.24.1738058633371; 
 Tue, 28 Jan 2025 02:03:53 -0800 (PST)
Received: from [192.168.69.151] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1c4199sm13376367f8f.89.2025.01.28.02.03.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 02:03:52 -0800 (PST)
Message-ID: <ec2e5528-5a55-4f76-99db-504c329770e5@linaro.org>
Date: Tue, 28 Jan 2025 11:03:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/15] target/ppc: Restrict exception helpers to TCG
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>
References: <20250127102620.39159-1-philmd@linaro.org>
 <20250127102620.39159-10-philmd@linaro.org>
 <e0219562-1bce-421e-b056-28f0132e2a70@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <e0219562-1bce-421e-b056-28f0132e2a70@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 28/1/25 10:59, Harsh Prateek Bora wrote:
> 
> 
> On 1/27/25 15:56, Philippe Mathieu-Daudé wrote:
>> Move exception helpers to tcg-excp_helper.c so they are
>> only built when TCG is selected.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/ppc/excp_helper.c     | 34 --------------------------------
>>   target/ppc/tcg-excp_helper.c | 38 ++++++++++++++++++++++++++++++++++++
>>   2 files changed, 38 insertions(+), 34 deletions(-)
>>
>> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
>> index 9e1a2ecc36f..6a12402b23a 100644
>> --- a/target/ppc/excp_helper.c
>> +++ b/target/ppc/excp_helper.c
>> @@ -2504,41 +2504,7 @@ bool ppc_cpu_exec_interrupt(CPUState *cs, int 
>> interrupt_request)
>>   #endif /* !CONFIG_USER_ONLY */
>> -/ 
>> *****************************************************************************/
>> -/* Exceptions processing helpers */
>> -
>> -void raise_exception_err_ra(CPUPPCState *env, uint32_t exception,
>> -                            uint32_t error_code, uintptr_t raddr)
>> -{
>> -    CPUState *cs = env_cpu(env);
>> -
>> -    cs->exception_index = exception;
>> -    env->error_code = error_code;
>> -    cpu_loop_exit_restore(cs, raddr);
>> -}
>> -
>> -void raise_exception_err(CPUPPCState *env, uint32_t exception,
>> -                         uint32_t error_code)
>> -{
>> -    raise_exception_err_ra(env, exception, error_code, 0);
>> -}
>> -
>> -void raise_exception(CPUPPCState *env, uint32_t exception)
>> -{
>> -    raise_exception_err_ra(env, exception, 0, 0);
>> -}
>> -
>>   #ifdef CONFIG_TCG
>> -void helper_raise_exception_err(CPUPPCState *env, uint32_t exception,
>> -                                uint32_t error_code)
>> -{
>> -    raise_exception_err_ra(env, exception, error_code, 0);
>> -}
>> -
>> -void helper_raise_exception(CPUPPCState *env, uint32_t exception)
>> -{
>> -    raise_exception_err_ra(env, exception, 0, 0);
>> -}
>>   #ifndef CONFIG_USER_ONLY
>>   void helper_store_msr(CPUPPCState *env, target_ulong val)
>> diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
>> index 93c2d6b5a03..268a1614597 100644
>> --- a/target/ppc/tcg-excp_helper.c
>> +++ b/target/ppc/tcg-excp_helper.c
>> @@ -19,15 +19,53 @@
>>   #include "qemu/osdep.h"
>>   #include "qemu/log.h"
>>   #include "exec/cpu_ldst.h"
>> +#include "exec/exec-all.h"
>> +#include "exec/helper-proto.h"
>>   #include "system/runstate.h"
>> +#include "helper_regs.h"
>>   #include "hw/ppc/ppc.h"
>>   #include "internal.h"
>>   #include "cpu.h"
>>   #include "trace.h"
>> +/ 
>> *****************************************************************************/
>> +/* Exceptions processing helpers */
>> +
>> +void raise_exception_err_ra(CPUPPCState *env, uint32_t exception,
>> +                            uint32_t error_code, uintptr_t raddr)
>> +{
>> +    CPUState *cs = env_cpu(env);
>> +
>> +    cs->exception_index = exception;
>> +    env->error_code = error_code;
>> +    cpu_loop_exit_restore(cs, raddr);
>> +}
>> +
>> +void helper_raise_exception_err(CPUPPCState *env, uint32_t exception,
>> +                                uint32_t error_code)
>> +{
>> +    raise_exception_err_ra(env, exception, error_code, 0);
>> +}
>> +
>> +void helper_raise_exception(CPUPPCState *env, uint32_t exception)
>> +{
>> +    raise_exception_err_ra(env, exception, 0, 0);
>> +}
>> +
>>   #ifndef CONFIG_USER_ONLY
> 
> In excp_helper.c, below helpers were getting built when CONFIG_USER_ONLY 
> is defined. Is this change to move under above ifndef intentional?

Yes, they are unused otherwise. I'll mention in commit description.

> 
> regards,
> Harsh

