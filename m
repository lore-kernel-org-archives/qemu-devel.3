Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF38C3ABC9
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 17:13:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEtB0-0001Ww-6o; Tue, 13 May 2025 13:12:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEtAz-0001VX-1s
 for qemu-devel@nongnu.org; Tue, 13 May 2025 13:12:21 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEtAx-0000YC-5Z
 for qemu-devel@nongnu.org; Tue, 13 May 2025 13:12:20 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a1fb17a9beso2622300f8f.3
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 10:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747156337; x=1747761137; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T540ncNJFrqke0ZjSBQ7eQ9JCXacMOXT7j2qsKpoG/8=;
 b=OTG5oDReFiw4uA+7kMyaFIRcudLqsF3FRx64sHwTiVOsxDJ32Q9k/w5qIzw7zNuSXQ
 vQt5RmiaCyoStqM6p4cVQeu66SPSYYpflLZ84F2WZuZC7otaPBJjOP+MblA2j2N7H2lV
 wzqnm6MvgEDrYbkC/2Ox7hzsxnHvYiIosgjswrE2k6i6l9lbcm2g8OoqWiHXwagYKkW3
 wa7e2iZzhIsTnSkJUhRAO34bsFtUIHYVoDAa5nHSGgUfsp1peV6HnUwo9htcg0QK9CRI
 FZT0G1dp5SlvA3Y1xniaDq+zL73cax6/a/C4oVxrLVpOMSZRTKd7s+X8PJZzc22pZde4
 IG2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747156337; x=1747761137;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T540ncNJFrqke0ZjSBQ7eQ9JCXacMOXT7j2qsKpoG/8=;
 b=PL8MCdkKJFVqAj6u9VkpX+3Yvy+KhSCTiPWDy9syG2KwRUdojT72Ma94aS0a1WGLLE
 zrUNGivgLTXqz+b/640qkC5qeXJ3cpEyeWuKrvVLNpDc3B2T5qSNmchdqrtUNBHCGcza
 o0tOPV5nYAQ6S7Wukmf5zvP7GlccHAhhcYbHF91EQJTdYZCyOyJ/cz04QTEGsJfk8FBx
 NNVQuFUa1gYJfW6A2cGF1Nqf2SnojtkjGcojyz0qYU/6VfDydyoC3Vj6BBlZZT9r0y56
 yjbPZ+9rwu3Q45+qFzzGULs1zrYT4qEUypOQ4SAy0aytMgJYmPJueBeyZy/gMyL4+3LY
 f+lg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWB6KZ9vYGI1Q1500rEFChc+M+obx/5SxcBEE3sKJoetrhMo+1Bk+lrPrqcy8tLpT2NBfD1vs8lUl54@nongnu.org
X-Gm-Message-State: AOJu0Yw5b1X0ttd0hjTvlqNGnEUUkKsu76yEoSUZc0wU6bF4qw8MCa/C
 GPqc/k5oLqC/qroMiJvssZIOnvYofzhExMW4GfWm7WA98TReSL5RoUa9tQHfSWI=
X-Gm-Gg: ASbGnctX5imlwFf+bXTaS0ssVizNrt80k5s1FA4Q3/YjX3FrUiMK8EhYbDOEQXVy/RT
 F6k/Gt41XQb/1IiIQvygyq2pGHZxWvnukkQHJuujWTUIdYop8MoRK8hnToqy6NCdJi1Z4qL0X+j
 q3s24DeBjxVx9LO0XPrKk8XY8sbd3Qk5wDE2E5dLSLsotBbFNXH1zwBzEZU8/H66WYwqRED0hP3
 QpkWfv3BlBlY3pQ3TyDfTa5hQlUNLM2JOGnaq1SxtwcX9Kl2xzvvCE/7wnCzRJmCFEJjuYQ2lP0
 rHIz2/xelMxV5p76KEk+gRWFwABznxmb02otNDNiTwVzvTefTR2wIJGoujFputtl6GAJWkrEBcD
 PPrw4U5h1RuB8xO5hMA==
X-Google-Smtp-Source: AGHT+IGL16BdFJ++J2CAKTAD4h7uoECpiXj/ZB09lxvIo8wt2EW36FWymJLMvbNmNt0byDIquGel8A==
X-Received: by 2002:a05:6000:1788:b0:3a0:b8b0:440e with SMTP id
 ffacd0b85a97d-3a349928fd6mr75822f8f.45.1747156337122; 
 Tue, 13 May 2025 10:12:17 -0700 (PDT)
Received: from [10.61.1.197] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f58ec8f1sm16629888f8f.26.2025.05.13.10.12.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 10:12:16 -0700 (PDT)
Message-ID: <cb2798a2-e673-427c-a83f-2afbac59751b@linaro.org>
Date: Tue, 13 May 2025 18:12:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 30/48] target/arm/ptw: replace TARGET_AARCH64 by
 CONFIG_ATOMIC64 from arm_casq_ptw
To: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
 <20250512180502.2395029-31-pierrick.bouvier@linaro.org>
 <91cd9b9a-8c67-47d3-8b19-ebaf0b4fab5d@linaro.org>
 <39c6f5ab-6e45-491d-a0e8-07408e29e2f8@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <39c6f5ab-6e45-491d-a0e8-07408e29e2f8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 13/5/25 19:03, Richard Henderson wrote:
> On 5/13/25 03:41, Philippe Mathieu-Daudé wrote:
>> On 12/5/25 20:04, Pierrick Bouvier wrote:
>>> This function needs 64 bit compare exchange, so we hide implementation
>>> for hosts not supporting it (some 32 bit target, which don't run 64 bit
>>> guests anyway).
>>>
>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> ---
>>>   target/arm/ptw.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/target/arm/ptw.c b/target/arm/ptw.c
>>> index 68ec3f5e755..44170d831cc 100644
>>> --- a/target/arm/ptw.c
>>> +++ b/target/arm/ptw.c
>>> @@ -737,7 +737,7 @@ static uint64_t arm_casq_ptw(CPUARMState *env, 
>>> uint64_t old_val,
>>>                                uint64_t new_val, S1Translate *ptw,
>>>                                ARMMMUFaultInfo *fi)
>>>   {
>>> -#if defined(TARGET_AARCH64) && defined(CONFIG_TCG)
>>> +#if defined(CONFIG_ATOMIC64) && defined(CONFIG_TCG)
>>>       uint64_t cur_val;
>>>       void *host = ptw->out_host;
>>
>> I'd feel safer squashing:
>>
>> -- >8 --
>> @@ -743,2 +743,5 @@ static uint64_t arm_casq_ptw(CPUARMState *env, 
>> uint64_t old_val,
>>
>> +    /* AArch32 does not have FEAT_HADFS */
>> +    assert(cpu_isar_feature(aa64_hafs, env_archcpu(env)));
> 
> Why?  This is checked in the setting of param.{ha,hd}.
> See aa{32,64}_va_parameters.

I suppose the "AArch32 does not have FEAT_HADFS" is misleading then.

Better if no changes are necessary and this series can go as is.

