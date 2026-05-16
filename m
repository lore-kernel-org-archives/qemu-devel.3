Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B92CD4F3C
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2026 21:01:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOM7o-00078v-H7; Sat, 16 May 2026 17:00:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOM7l-00077z-7t
 for qemu-devel@nongnu.org; Sat, 16 May 2026 17:00:42 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOM7f-0005A3-Nn
 for qemu-devel@nongnu.org; Sat, 16 May 2026 17:00:37 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-c8025500cc7so727737a12.1
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 14:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778965233; x=1779570033; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OiLyflX0ohR3lipSWlPPAtrHInPv/h3YkI22h49LYFg=;
 b=TE6vHZdafVEi1Twt3iOGX7MBlL1gYRjnzzuvEr8h4F+PE6Fr0SyREp3DDDg2a9M8Km
 ZqeCt1RM6PSsjowrh3BFtPUNOkdPUOq0fOeGdhDQ2qmkbSbKHb2aEBG/Par0NnM8Jk1f
 cYhvmhZfCB4N5SK+LiSa+FQnmXjOLFrQkO5XTMGlWOpULbDXONphUt+oHLU43JM3sR0X
 7yL2PSs9yS0cgT9lQA2ein1R/hGRVA4Kp4a5v5M3uyUpjPFKqnhScIzFCakCSO/o2H92
 xkG2QBpJ5TKvtHgwpfVuULWmmfv8tO5WE8i4HaZrso1HoyLuKZRTpfN+sXggsznY33Na
 LTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778965233; x=1779570033;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OiLyflX0ohR3lipSWlPPAtrHInPv/h3YkI22h49LYFg=;
 b=q1MC0NWr9+n4tw2TQjUKcMrWJ6CbBVkGOYw5QT6YUtEN7z1BaxUx/y/cFPiq73cdWK
 BIytKx67CqViaSzKnCheBOnDCSkHPVPpGjUA8W3f4CHon3zShpJeHaPq6KFb/QyGS/ty
 1FRtlIRmsXGT4mDHbUXSfoaB36ZLz2vsjyVFEXBVYqu2qSmpOlDmmLMkTyabqluVIDFI
 4EMANrgTl5KBwrsyDnDA0wx4YocfRseNE1CHt6BsiLIoLl/ynrErzijdzGUiXznmHNUY
 ScKFkCbUbQs80NbDM4sMolD8tPhVFH9FNAzzEsTrV1BaCgKCSM99567LHJLQiiWkmrRJ
 9WWw==
X-Gm-Message-State: AOJu0YxVhPYOss9T2DJZKFstkpa8G1sDV7KiWhrDFULsY3caR1hz/xni
 yGHVOuFk1jdpQpIY+4HRY7twF43L8uLyYly3PdcDAEinLZm3HAGiEL/IwWJCMMbbK2U=
X-Gm-Gg: Acq92OF6ziGaT8eLOdVUg1e+hbLGYN6Vqyx2w0JXf1Uirhzdu3T64ucvhn8zLDxctIl
 tNVsNAfImUEmAmbfoYiKFiceoy9AVemzLdA4J7BGBYb6k9FmuAHgXJ9vSEb84Ha5eFUGLXg4IBB
 1FkFBtMYIaScaZJ7oARWR+IkEHDq/ARQzzt+7Hc+oc9IqwJpL4CZIc3f5bKT8KH1KssrxSMYBBz
 lUfRNtMe9uyjYE2c2EMQzS13l7EXQ7W65EIm4DY4tuKUmxbWuo6GWqExuAOi1i9lxo4QIu58R8/
 Ex8ZjJWIIk8e4PNobOAGSrb+xl/ZdWYss3d6TxJi+o4rHMdMe8yUskVW0xk8HNEmpfin5qPMYqH
 KHw06O5H+nId2U76fAtO/SbSERrORFG1pCC2RbeNp3tVE9k+p2jikV8sJR9gHhOm5gIJrH+Uutu
 LKLqjGBaN64haNk6Dzsd5v1t/3XZZUaciZmCj2cRCf8G/JIEQ=
X-Received: by 2002:a05:6a21:9983:b0:3a0:200e:64b0 with SMTP id
 adf61e73a8af0-3b22e682b99mr10357798637.9.1778965233449; 
 Sat, 16 May 2026 14:00:33 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c82c4031662sm8416841a12.16.2026.05.16.14.00.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 16 May 2026 14:00:32 -0700 (PDT)
Message-ID: <4ee83dd6-47eb-4eb8-9091-7955f2376f0c@linaro.org>
Date: Sat, 16 May 2026 14:00:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/37] target/arm: Implement FEAT_FAMINMAX for AdvSIMD
From: Richard Henderson <richard.henderson@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20260421051346.41106-1-richard.henderson@linaro.org>
 <20260421051346.41106-3-richard.henderson@linaro.org>
 <CAFEAcA8cM2aKa=9Qh8LOVyoEZKQfw3rTBfNrDi4xd_s+tXq2Mg@mail.gmail.com>
 <0b520bc5-d680-4e40-92ad-1ff4b6f71466@linaro.org>
Content-Language: en-US
In-Reply-To: <0b520bc5-d680-4e40-92ad-1ff4b6f71466@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/16/26 11:18, Richard Henderson wrote:
> On 5/14/26 03:35, Peter Maydell wrote:
>> On Tue, 21 Apr 2026 at 06:15, Richard Henderson
>> <richard.henderson@linaro.org> wrote:
>>>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>   target/arm/cpu-features.h        |  5 +++++
>>>   target/arm/tcg/helper-a64-defs.h |  7 +++++++
>>>   target/arm/tcg/vec_internal.h    |  7 +++++++
>>>   target/arm/tcg/translate-a64.c   | 14 +++++++++++++
>>>   target/arm/tcg/vec_helper64.c    | 35 ++++++++++++++++++++++++++++++++
>>>   target/arm/tcg/a64.decode        |  5 +++++
>>>   6 files changed, 73 insertions(+)
>>
>>
>>
>>> +#define DO_FAMINMAX(NAME, TYPE, FN)                             \
>>> +TYPE TYPE##_##NAME(TYPE a, TYPE b, float_status *s)             \
>>> +{                                                               \
>>> +    bool save_fz = get_flush_to_zero(s);                        \
>>> +    bool save_fiz = get_flush_inputs_to_zero(s);                \
>>> +    int new_flags, save_flags = get_float_exception_flags(s);   \
>>> +                                                                \
>>> +    set_flush_to_zero(0, s);                                    \
>>> +    set_flush_inputs_to_zero(0, s);                             \
>>> +    TYPE r = TYPE##_##FN(TYPE##_abs(a), TYPE##_abs(b), s);      \
>>> +                                                                \
>>> +    set_flush_to_zero(save_fz, s);                              \
>>> +    set_flush_inputs_to_zero(save_fiz, s);                      \
>>> +    new_flags = get_float_exception_flags(s);                   \
>>> +    new_flags = (save_flags & float_flag_input_denormal_used)   \
>>> +              | (new_flags & ~float_flag_input_denormal_used);  \
>>> +    set_float_exception_flags(new_flags, s);                    \
>>> +                                                                \
>>> +    return r;                                                   \
>>> +}
>>
>> I don't think this has the right behaviour for NaN inputs.
>> We don't special-case NaNs in this function, and we pass
>> our inputs to the floatN_abs() functions, which also don't
>> special-case NaNs, they just flip the sign bit. So if the
>> input is a NaN with the sign bit set, the max/min function
>> will propagate a sign-flipped NaN to the output, rather
>> than correctly propagating the input NaN untouched.
> 
> Yep.
> 
> See FPAbsMax{N}, where the sign bits are squashed before unpacking:
> 
>      let op1 = '0'::op1_in[N-2:0];
>      let op2 = '0'::op2_in[N-2:0];
>      let (type1,-,value1) = FPUnpack{N}(op1, fpcr);
>      let (type2,-,value2) = FPUnpack{N}(op2, fpcr);

Ho hum.  And then FPProcessNaNs uses op[12]_in.  So, yeah, the absolute value isn't used 
if there's a NaN.


r~

