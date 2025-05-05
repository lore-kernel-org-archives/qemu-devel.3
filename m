Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28A12C3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 18:48:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC0qw-000701-5l; Mon, 05 May 2025 14:47:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC0qj-0006mg-6Q
 for qemu-devel@nongnu.org; Mon, 05 May 2025 14:47:35 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC0qf-0006ef-Fb
 for qemu-devel@nongnu.org; Mon, 05 May 2025 14:47:32 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-73bf5aa95e7so4555048b3a.1
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 11:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746470848; x=1747075648; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TrysJu1PXbfeK8SZ2A0j/x6crADYuLFKWDlFDWA0zQo=;
 b=TSQRopRAAClFIwF7CT1Tx6M59A4pB+30DK7Sj7WSF3R1oZY2unKY1g8eFc1IvAi8+9
 ShpMg+fyyQ51v2c//p9NX3oYpfRx0lTs2iYz3snW7TR/DFgelZc5RxyZpZ+ihVQxHKlc
 lSfgK2D900PpXqLvFjdPzPJ87uArlWQa4ls9UUeblqgzTFBj4FklpGbRmD41tB3RHpwn
 6jpg+J1UhhBLcNDJ8koTfELQCKwmnCbsyHmW7KSabH7q3KD7qZA5G2rIuupPl+Q8QlhI
 HioDkfns6nos3KpZkWlaEzrnjMeTkQDNxHXnNZ6MbwInmcMUPdJGzFm1+NLpfCyaOxeT
 iBNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746470848; x=1747075648;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TrysJu1PXbfeK8SZ2A0j/x6crADYuLFKWDlFDWA0zQo=;
 b=LFQi0LBc+Op6APHltbV3QzmCGqEHD2JeQVYzEJnpwsHscyj5RfHsfKiJdW1Ctg7ICj
 rIhOIumfUt/q82sdEk0zrwgmHtix98WaODY5zjVZb54qXEoPu6xFeCBiPpBPCyMWEdOw
 YY/WNoFBHKXA4xTfcjKx0cPYWDvCO6X04tipjJ2JBFTVzKmIX637i15fQ+whoZBUHDWr
 IR5NF9wiKd3tF1Fg9C5G39wJeQOgkpY6nWaoXVZFqPznrud5BI1++Iz1wE9b2V4zMQ8N
 wUO9Lyk3Oo6SZv+Ly35JjZDlMbkjfNBTFf6V/Y65cr9jbdovYhkJ3XmiYT8ESi5Ok61k
 JhDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcwMsXhP4bGonRWwNXk6TxhLSXPvUpJ770i9t2CVmElsPQxNNmQ7P7KSnZOyiqJeFfVnBz+RqncvX3@nongnu.org
X-Gm-Message-State: AOJu0YwLf61EbLb1pFbAYkvsL1Rwsr8DMt+kwxbV4T0k/KUU3LEDf4zG
 LoA45t1Cgcm7/HJ85pwC9mG0pbz7LOz0k0EgED7PXEjt88QBG24lBx3Q2r8sfeI=
X-Gm-Gg: ASbGncuDdNoo7ifGCJ6gal0pTjARW5hKvdMs/VfBNEK7fzDiBD3nniRzr7DruQ9R7ck
 UzdDbQsPw2ueI3LFgOFOilDXFtoIbuPG/fvA/fopNMtSJLLFSFkaPE3j4YLs7vfdeSfTXtW4kqV
 mm97Msz9vNLAOOztfF6gXfyelEqttePXj/jV2vPSPyQAx/swpwRpWP+3JMaXVsVLvCgLGTaIfXY
 sg+sAiG8/tmEwzoF1AfiO7WNZE8XwB3UEJ/7HYKdMjq3qazqu2J3/yykttdgJ8Ftt8XEBsxmSZ9
 MT5ToFrL9vDbnv9jm5NwFVjCpqbXOzoIMTd40bcRz3RJa8Rs0hEjwg==
X-Google-Smtp-Source: AGHT+IEt7/lwpwdaScb+0p9Fg8aZK81PZGU74vSUU2NY/HtKI988XqzBXbfqUBIR4rmnm1R5PX8mag==
X-Received: by 2002:a05:6a00:8f0c:b0:736:50c4:3e0f with SMTP id
 d2e1a72fcca58-7406f0b5e78mr9676093b3a.10.1746470847991; 
 Mon, 05 May 2025 11:47:27 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74059020f4esm7153739b3a.112.2025.05.05.11.47.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 11:47:27 -0700 (PDT)
Message-ID: <f33fa744-1557-4c01-ba49-e64b4d3b6368@linaro.org>
Date: Mon, 5 May 2025 11:47:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 41/48] target/arm/tcg/crypto_helper: compile file twice
 (system, user)
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
 <20250505015223.3895275-42-pierrick.bouvier@linaro.org>
 <79916f8d-2793-40a7-b769-ee109c52ef63@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <79916f8d-2793-40a7-b769-ee109c52ef63@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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

On 5/5/25 11:38 AM, Richard Henderson wrote:
> On 5/4/25 18:52, Pierrick Bouvier wrote:
>> --- a/target/arm/tcg/meson.build
>> +++ b/target/arm/tcg/meson.build
>> @@ -30,7 +30,6 @@ arm_ss.add(files(
>>      'translate-mve.c',
>>      'translate-neon.c',
>>      'translate-vfp.c',
>> -  'crypto_helper.c',
>>      'hflags.c',
>>      'iwmmxt_helper.c',
>>      'm_helper.c',
>> @@ -63,3 +62,10 @@ arm_system_ss.add(files(
>>    
>>    arm_system_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('cpu-v7m.c'))
>>    arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files('cpu-v7m.c'))
>> +
>> +arm_common_system_ss.add(files(
>> +  'crypto_helper.c',
>> +))
>> +arm_user_ss.add(files(
>> +  'crypto_helper.c',
>> +))
> 
> Could this use arm_common_ss?  I don't see anything that needs to be built user/system in
> this file...
> 

It needs vec_internal.h (clear_tail), which needs CPUARMState, which 
pulls cpu.h, which uses CONFIG_USER_ONLY.

I'll take a look to break this dependency, so it can be built only once, 
and for other files as well.

> 
> r~


