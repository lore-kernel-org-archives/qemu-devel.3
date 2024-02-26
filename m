Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 728E6C5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 19:18:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1regT7-0008Jb-VP; Mon, 26 Feb 2024 14:16:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1regT6-0008IX-2Y
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 14:16:52 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1regT4-0006kF-9c
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 14:16:51 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6e45d0c9676so2039390b3a.0
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 11:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708975008; x=1709579808; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rQXxalWk9PMKM+/XNnXpOpeMZf7T4Zf1m38nWD9CjMw=;
 b=tlC0ENlRJvIb6o6kXJVfDQBT7PP2Zfp9x+mUPq9uXBBjOj3255QkrtZvKcKrCQ9FOH
 cVxb7C6sFuTxrtlrxzdYixsGINZ5as1jaLsqwxNZq5CnEVKBrPNNNOjidnLTIRK7tuRV
 /Y0S3rpuSO/Vcgs8DQX2R2/sr3GV0VQPTa/VyGusAKAJWLQJ3el/kMwx/lviwje/8EPo
 H5jAZPY2fmV+xp3F7NnHgNFJ02F1mlzfd4uqfQgzGHlKei5X/fbF913kaVu7ogYQKi7W
 YnFiz7c7QQPsNNsHMUAIvIaAZEn5JMREAPsvjXR6RDdnvZwYRtWbDatqYjhbmXLLAIpq
 xlOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708975008; x=1709579808;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rQXxalWk9PMKM+/XNnXpOpeMZf7T4Zf1m38nWD9CjMw=;
 b=EykNokxX8mBjA7CST0haZSgZkYnHcQTTvxuJ1U002wb1IDSl4bM1o9lBawXrm+p4h1
 uT8vbSqLFWkpCTNt1+MkM5H/GdJjGRC4uSPW+og6DxtbEFcmX3IwIY5nW6V6rZ9cbfqg
 Xh2XloDSYLwjLV27na4ldnRbCfNMPbBSoGkJHXCmYOb4NXvW87DeuHSleZzzChoyKyRw
 XlZlbkNoSLXYogPT18k+szpd3YBeapTm3Y5sU7C0wp8A9OPcZmgo/c0b9M0J4PCxe1fF
 4KAxMm8nUNt4Uve8z8OolVTtvJQwEoXsgcXcySBuuWWuM0opVrvVSbU/YsIYfzvIjOkD
 SLlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYspnpULychZiwb9MyKxff3tsLrym3EjysNIwXrCVmh59fGJxBL79CIJE+2vtfteXacS72LGuUtU5spaOv0a5JxIgFg+g=
X-Gm-Message-State: AOJu0YwaOBKIqKmdYXAYYXBFSuv/XWY+l0BOxvgp7Et6Qj+FJu31T69c
 DBqOzGIzJE5uqI47qFMEkxG3m+ui6HAulo2B62pX6KJrrTBFNZ0T8YRPsvmBd8QFJAVXHCr247A
 U
X-Google-Smtp-Source: AGHT+IGTWnDvfzbHQiNL8yl2JosllpJBu5McBcsdEknRjod09kIkcNKrxCfzOp7rKsFHWpRsHwZpNg==
X-Received: by 2002:a05:6a21:1798:b0:1a1:5:e883 with SMTP id
 nx24-20020a056a21179800b001a10005e883mr78445pzb.22.1708975007763; 
 Mon, 26 Feb 2024 11:16:47 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 r7-20020aa78b87000000b006e48b04d8c0sm4416024pfd.64.2024.02.26.11.16.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Feb 2024 11:16:47 -0800 (PST)
Message-ID: <4aba8c00-90c0-4b01-b6bb-fadda72acfef@linaro.org>
Date: Mon, 26 Feb 2024 09:16:43 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 04/21] target/arm: Implement ALLINT MSR (immediate)
To: Jinjie Ruan <ruanjinjie@huawei.com>, peter.maydell@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240223103221.1142518-1-ruanjinjie@huawei.com>
 <20240223103221.1142518-5-ruanjinjie@huawei.com>
 <9b20584a-3c4c-47a2-bf42-f8d7d4eabd9f@linaro.org>
 <138ddc99-f6f4-9907-a1c2-6b2b88bd79d0@huawei.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <138ddc99-f6f4-9907-a1c2-6b2b88bd79d0@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 2/25/24 16:22, Jinjie Ruan wrote:
> 
> 
> On 2024/2/24 3:03, Richard Henderson wrote:
>> On 2/23/24 00:32, Jinjie Ruan via wrote:
>>> Add ALLINT MSR (immediate) to decodetree. And the EL0 check is necessary
>>> to ALLINT. Avoid the unconditional write to pc and use raise_exception_ra
>>> to unwind.
>>>
>>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>>> ---
>>> v3:
>>> - Remove EL0 check in allint_check().
>>> - Add TALLINT check for EL1 in allint_check().
>>> - Remove unnecessarily arm_rebuild_hflags() in msr_i_allint helper.
>>> ---
>>>    target/arm/tcg/a64.decode      |  1 +
>>>    target/arm/tcg/helper-a64.c    | 24 ++++++++++++++++++++++++
>>>    target/arm/tcg/helper-a64.h    |  1 +
>>>    target/arm/tcg/translate-a64.c | 10 ++++++++++
>>>    4 files changed, 36 insertions(+)
>>>
>>> diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
>>> index 8a20dce3c8..3588080024 100644
>>> --- a/target/arm/tcg/a64.decode
>>> +++ b/target/arm/tcg/a64.decode
>>> @@ -207,6 +207,7 @@ MSR_i_DIT       1101 0101 0000 0 011 0100 .... 010
>>> 11111 @msr_i
>>>    MSR_i_TCO       1101 0101 0000 0 011 0100 .... 100 11111 @msr_i
>>>    MSR_i_DAIFSET   1101 0101 0000 0 011 0100 .... 110 11111 @msr_i
>>>    MSR_i_DAIFCLEAR 1101 0101 0000 0 011 0100 .... 111 11111 @msr_i
>>> +MSR_i_ALLINT    1101 0101 0000 0 001 0100 .... 000 11111 @msr_i
>>
>> Decode is incorrect either here, or in trans_MSR_i_ALLINT, because CRm
>> != '000x' is UNDEFINED.
>>
>> MSR_i_ALLINT    1101 0101 0000 0 001 0100 000 imm:1 000 11111
>>
>> is perhaps the clearest implementation.
>>
>>> +static void allint_check(CPUARMState *env, uint32_t op,
>>> +                       uint32_t imm, uintptr_t ra)
>>> +{
>>> +    /* ALLINT update to PSTATE. */
>>> +    if (arm_current_el(env) == 1 && arm_is_el2_enabled(env) &&
>>> +        (arm_hcrx_el2_eff(env) & HCRX_TALLINT)) {
>>> +        raise_exception_ra(env, EXCP_UDEF,
>>> +                           syn_aa64_sysregtrap(0, extract32(op, 0, 3),
>>> +                                               extract32(op, 3, 3), 4,
>>> +                                               imm, 0x1f, 0),
>>> +                           exception_target_el(env), ra);
>>> +    }
>>> +}
>>> +
>>> +void HELPER(msr_i_allint)(CPUARMState *env, uint32_t imm)
>>> +{
>>> +    allint_check(env, 0x8, imm, GETPC());
>>
>> As previously noted, the check for MSR_i only applies to imm==1, not 0.
> 
> Sorry! The hardware manual I looked at didn't say this.

In DDI0487J.a, C6.2.229 MSR (immediate), it is present in the pseudocode

   when PSTATEField_ALLINT
     if (PSTATE.EL == EL1 && IsHCRXEL2Enabled()
         && HCRX_EL2.TALLINT == '1' && CRm<0> == '1') then
       AArch64.SystemAccessTrap(EL2, 0x18);
     PSTATE.ALLINT = CRm<0>;

In D19.2.49 HCRX_EL2, it is present as text for the description of TALLINT.


r~

