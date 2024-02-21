Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AFF8C48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 20:41:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rctP3-00024R-OW; Wed, 21 Feb 2024 15:41:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rctP1-000247-Ls
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 15:41:15 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rctOz-0002a0-KU
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 15:41:15 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1d746ce7d13so49803705ad.0
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 12:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708548072; x=1709152872; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6etce8ly7+iymUslPRIk+x3FEVGpMx3DvXWMJ8MNuWI=;
 b=ydzcF/eNyEM/MRWxCfF+m9CKHAsM1WVLDc3pl1M16OWJazFxOouIRqhsRUgDkRDiaH
 qrXsOvC9IFZsIlYXaL20WKHxYg+lYWIV+CIw/6Hw6axGX2Kc/ZBeIg/zFDBhrzAhh1gr
 I/nDaKYNHVKDDkyL8dB5ZQxj6Ho/gVL5jjARaOL4gBnrEdyoPqlPmx+Ch2bdeKAlGM8r
 /Z2WphdUU6RSNhNPMEHjc6TPy+3eMd1Wd0/PBWULqbSl4DLMxtdXdcD3oC96jcutv+H1
 ZFRq1vrGCQ6GVDxOEZv+92R1WznjysqWp9GHSH0mJIaru5hWkmjfpi5Opih5rce6o0ux
 C8qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708548072; x=1709152872;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6etce8ly7+iymUslPRIk+x3FEVGpMx3DvXWMJ8MNuWI=;
 b=kLkouPnF35LGoBdqwq/rPw/GkBg8pxb5WQcm8Ui3x9uBa0oDpxZLuMUQYcJKnE9bct
 bQ2yrpSumrXtsuzT4PHT0b1GdmK0QUIDF0rTxY9FA3fcGOZNJ3ZITJOjMAkq1dCDk1VH
 M/X3t3B1OJ0mbyR6N5rGwShh36wnaV8BW0LVNdgvfuV5Hbkr73dshbT3liRYBKAllrGL
 ol0+FDMjdyRxNwSAPw2uBTNBvJH/V5HXTgnwzad5wJNl0A7lJH81OG8NmY00bPlQpmo4
 AClgRYYN1HelQR6Ad1wGFcC8Hrx+jF3iZV5eDknknogGVtVxvwFLj+7ANunJEXOKZARy
 W5ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVAT1uo1rqVe1hPN9mhbUuSwUE8YET4ByabRCz7dbzZrUWcbB30Nz4pdohtDpgU8x8i52CJW0aLT6AO1I6QFYFszN/1GI=
X-Gm-Message-State: AOJu0Yw9Z+Qjd6/iKGo61hkhibreSMFvIBTqPRpFIpuHnvKcZVlrR36c
 uo2PQy9V7xvLijJEwzCTzcnrH/O7F5HGiKHvItaoLCUwaBILYowaZE+lGaHJleU=
X-Google-Smtp-Source: AGHT+IEDdmKtjEoPyd9DOiISdaU8fQCjWehyRiDK6ZFNotIPCXMUnH/oXoXIUPkFdo5Y8CA9OXFQ4A==
X-Received: by 2002:a17:902:bb81:b0:1d8:ee44:629d with SMTP id
 m1-20020a170902bb8100b001d8ee44629dmr17770636pls.30.1708548071779; 
 Wed, 21 Feb 2024 12:41:11 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 x2-20020a170902fe8200b001d947e65ad8sm8507278plm.251.2024.02.21.12.41.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 12:41:11 -0800 (PST)
Message-ID: <0911d6a4-7fd6-4d0f-83a8-ec4ba8420297@linaro.org>
Date: Wed, 21 Feb 2024 10:41:07 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 04/22] target/arm: Implement ALLINT MSR (immediate)
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>, peter.maydell@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240221130823.677762-1-ruanjinjie@huawei.com>
 <20240221130823.677762-5-ruanjinjie@huawei.com>
 <9fb9c74e-e4d3-4a8b-b736-c8603414245c@linaro.org>
In-Reply-To: <9fb9c74e-e4d3-4a8b-b736-c8603414245c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 2/21/24 09:09, Richard Henderson wrote:
> On 2/21/24 03:08, Jinjie Ruan via wrote:
>> Add ALLINT MSR (immediate) to decodetree. And the EL0 check is necessary
>> to ALLINT. Avoid the unconditional write to pc and use raise_exception_ra
>> to unwind.
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>   target/arm/tcg/a64.decode      |  1 +
>>   target/arm/tcg/helper-a64.c    | 24 ++++++++++++++++++++++++
>>   target/arm/tcg/helper-a64.h    |  1 +
>>   target/arm/tcg/translate-a64.c | 10 ++++++++++
>>   4 files changed, 36 insertions(+)
>>
>> diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
>> index 8a20dce3c8..3588080024 100644
>> --- a/target/arm/tcg/a64.decode
>> +++ b/target/arm/tcg/a64.decode
>> @@ -207,6 +207,7 @@ MSR_i_DIT       1101 0101 0000 0 011 0100 .... 010 11111 @msr_i
>>   MSR_i_TCO       1101 0101 0000 0 011 0100 .... 100 11111 @msr_i
>>   MSR_i_DAIFSET   1101 0101 0000 0 011 0100 .... 110 11111 @msr_i
>>   MSR_i_DAIFCLEAR 1101 0101 0000 0 011 0100 .... 111 11111 @msr_i
>> +MSR_i_ALLINT    1101 0101 0000 0 001 0100 .... 000 11111 @msr_i
>>   MSR_i_SVCR      1101 0101 0000 0 011 0100 0 mask:2 imm:1 011 11111
>>   # MRS, MSR (register), SYS, SYSL. These are all essentially the
>> diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
>> index ebaa7f00df..3686926ada 100644
>> --- a/target/arm/tcg/helper-a64.c
>> +++ b/target/arm/tcg/helper-a64.c
>> @@ -66,6 +66,30 @@ void HELPER(msr_i_spsel)(CPUARMState *env, uint32_t imm)
>>       update_spsel(env, imm);
>>   }
>> +static void allint_check(CPUARMState *env, uint32_t op,
>> +                       uint32_t imm, uintptr_t ra)
>> +{
>> +    /* ALLINT update to PSTATE. */
>> +    if (arm_current_el(env) == 0) {
>> +        raise_exception_ra(env, EXCP_UDEF,
>> +                           syn_aa64_sysregtrap(0, extract32(op, 0, 3),
>> +                                               extract32(op, 3, 3), 4,
>> +                                               imm, 0x1f, 0),
>> +                           exception_target_el(env), ra);
>> +    }
>> +}
> 
> A runtime check for EL0 is not necessary; you've already handled that in 
> trans_MSR_i_ALLINT().  However, what *is* missing here is the test against TALLINT for EL1.
> 
>> +
>> +void HELPER(msr_i_allint)(CPUARMState *env, uint32_t imm)
>> +{
>> +    allint_check(env, 0x8, imm, GETPC());
>> +    if (imm == 1) {
>> +        env->allint |= PSTATE_ALLINT;
>> +    } else {
>> +        env->allint &= ~PSTATE_ALLINT;
>> +    }
> 
> I think you should not write an immediate-specific helper, but one which can also handle 
> the variable "MSR allint, <xt>".  This is no more difficult than
> 
> void HELPER(msr_allint)(CPUARMState *env, target_ulong val)
> {
>      ... check ...
>      env->pstate = (env->pstate & ~PSTATE_ALLINT) | (val & PSTATE_ALLINT);
> }

Ho hum..  I just noticed that TALLINT only traps immediate write of 1, not also immediate 
write of 0.  So one helper for both MSR Xt and MSR imm is not practical.


r~

