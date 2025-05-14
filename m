Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA7A0C3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 16:53:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFFML-0002yB-Lw; Wed, 14 May 2025 12:53:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uFFMH-0002pN-6n
 for qemu-devel@nongnu.org; Wed, 14 May 2025 12:53:29 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uFFMF-00060v-CF
 for qemu-devel@nongnu.org; Wed, 14 May 2025 12:53:28 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43cfebc343dso237215e9.2
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 09:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747241605; x=1747846405; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EJDvpjsckjvN0xZPH1wXDoMTsindwY7WPuMUHXI/XOA=;
 b=xSACArT7WXbRyt4GDoACwBIbYeFQCCcDHsguPHKeKKUViMrrBI2idcjTisMvsZ0xIp
 xiA6IVwXOC5fJA4wqHMZW3Vzq0KZ+stFOGTDp26hp4Ivd7VXZKCaGYa4hlKOaoGmrpJn
 nyoLbcTST327oYJDOQM96at4BcYh9XVCtADnxKZS8RrjnfdfxtoOE4+6NAosIEW3mZwF
 qZaJUToesb31OkgJo7E8ujkts9VJYi42Xtkt/9F3eFLKa27tSsZiksAk+mrqxC5Xhdpi
 eM7cG6tvc5iTIzmvjnv2Z0WU59hLCmwJPfNBb7DQqcqh8HV/UGjbbLvh7HeXcFB8UNRK
 ji2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747241605; x=1747846405;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EJDvpjsckjvN0xZPH1wXDoMTsindwY7WPuMUHXI/XOA=;
 b=aXNBIenrUOLwptgnnH4OJeiiUAL0PR8rI76ETYDxrKNPsrcvIMkZdDdr/Trl4OAMEU
 nSrIgs7o0aliYnIKRgnRYTGYc4DU5TZs5F5MSAVGQK3j5hYAVRRX4u+dsbWLn6CzuUFD
 Dl2dFfgCuTGWgP1QftA4c/wH5zozM65ipFGDmHNmvcxDfP7qsLRr1v+/hUYYQDOIb0GY
 uwTdO/92mvLgmaSvjneN1+4XEev0aZBtsJnQwIv7hz0RdPw5Sulm0vydaz5pL1NkfPs3
 AYoXc019VFQtw2IisOqxFX56jtKLVStOh7vHveM6MtQH18b89hHX95oVgL604Eeh3/ZX
 eXTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1Fm1zGTMFRzEeLq981dSY9w0YlkD6dIdlYxVKZYHOaLr3VaXkouiJjlSuwgKcaOkq6ixUI9QzscAT@nongnu.org
X-Gm-Message-State: AOJu0Yz3oK2hmX7oJXSrvHuDnuGHqOddo+zTHfwBdkSqgqTZCrD34yLb
 CGvgQq5w05b45TEkeMSmNLnplYajF/v5iy40FjldB18q7H9/Ut+ZqbP17VJA2wk=
X-Gm-Gg: ASbGncvE1BXCTQnL0QoLjQQe6JPQ3BdWFtBAtHelrfIqYm13aWjceL1KZISbC3injxt
 kn9bQ4Tz/MDFH1LmYGteaMazCdgVPffeU/84V3889yF2tz1+gc2jvQPfnCWY/hgH7Ke75kL8g3K
 Xyyfc+0sZV6T58h4a8v12XG8MEs205/ecdKNx1zB3sNOj/t2TxC0Q6an+IqAjmsTrvAiSF6HFG3
 cMha0ppx7IMLaPQ4Qa8xa+yEfzPaISOes/M/jdLhEttdr3XfiDtCDAjvQ1IV14p1FyM+7dlQoPz
 fAZ/CRfLQt0M8MBlAfbiu16Bq8ckx1i3/Jfy1SXvPjocbQ6gF3wyduWHJthuNtoKaHybMwTjW6X
 t3tttpiOl7Z/FUWQuZw==
X-Google-Smtp-Source: AGHT+IGuBwssz8RIInxR+1zCl34Lwg+moYy+U57cD5N0/AcjbTEuZaCbQXSxdkJZifomQxcVgSpx+g==
X-Received: by 2002:a05:600c:609a:b0:441:d43d:4f68 with SMTP id
 5b1f17b1804b1-442f210de3dmr46598685e9.15.1747241605605; 
 Wed, 14 May 2025 09:53:25 -0700 (PDT)
Received: from [10.61.1.248] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f397b6fbsm37092555e9.39.2025.05.14.09.53.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 May 2025 09:53:25 -0700 (PDT)
Message-ID: <f7bcd8b2-2c0c-4907-8a0e-af172c235d56@linaro.org>
Date: Wed, 14 May 2025 17:53:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/19] target/arm: Add arm_cpu_has_feature() helper
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250513173928.77376-1-philmd@linaro.org>
 <20250513173928.77376-17-philmd@linaro.org>
 <b6c81748-091b-4d61-8d34-beaa0442aab3@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <b6c81748-091b-4d61-8d34-beaa0442aab3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 14/5/25 10:24, Richard Henderson wrote:
> On 5/13/25 18:39, Philippe Mathieu-Daudé wrote:
>> arm_cpu_has_feature() is equivalent of arm_feature(), however
>> while the latter uses CPUARMState so is target-specific, the
>> former doesn't and can be called by target-agnostic code in hw/.
> 
> CPUARMState is no more target-specific than ARMCPU.

ARMCPU is forward-declared as opaque pointer in target/arm/cpu-qom.h,
so we can expose prototypes using it to non-ARM units.
CPUARMState is only declared in "cpu.h", itself only accessible by
ARM-related units.

> 
> Did you really mean to use CPUState?
> Or is it merely that arm_cpu_has_feature is out-of-line?
> 
> 
> r~
> 
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   target/arm/cpu_has_feature.h | 2 ++
>>   target/arm/cpu.c             | 7 +++++++
>>   2 files changed, 9 insertions(+)
>>
>> diff --git a/target/arm/cpu_has_feature.h b/target/arm/cpu_has_feature.h
>> index 2adfccd9208..352f9d75bed 100644
>> --- a/target/arm/cpu_has_feature.h
>> +++ b/target/arm/cpu_has_feature.h
>> @@ -62,4 +62,6 @@ typedef enum arm_features {
>>       ARM_FEATURE_BACKCOMPAT_CNTFRQ, /* 62.5MHz timer default */
>>   } ArmCpuFeature;
>> +bool arm_cpu_has_feature(ARMCPU *cpu, ArmCpuFeature feature);
>> +
>>   #endif
>> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
>> index 8c9d161f2ef..759636a3b0e 100644
>> --- a/target/arm/cpu.c
>> +++ b/target/arm/cpu.c
>> @@ -54,6 +54,13 @@
>>   #include "target/arm/gtimer.h"
>>   #include "target/arm/multiprocessing.h"
>> +bool arm_cpu_has_feature(ARMCPU *cpu, ArmCpuFeature feature)
>> +{
>> +    CPUARMState *env = &cpu->env;
>> +
>> +    return arm_feature(env, feature);
>> +}
>> +
>>   static void arm_cpu_set_pc(CPUState *cs, vaddr value)
>>   {
>>       ARMCPU *cpu = ARM_CPU(cs);
> 


