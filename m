Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB7BDC3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 17:05:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txqfS-0006PF-QK; Thu, 27 Mar 2025 13:05:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1txqfN-0006Nf-OZ
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 13:05:17 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1txqfL-0000li-O1
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 13:05:17 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-39ac8e7688aso1031870f8f.2
 for <qemu-devel@nongnu.org>; Thu, 27 Mar 2025 10:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743095114; x=1743699914; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZH8VyodyFqnviPSXYW3qleDr3/hzkqlJCBLUq6bj3K4=;
 b=ityBlR2m/11/luNGt3no8h+gV3v+3VtU+Fv0bntHngHSSLABkBzP6Rp67UE/R0rChp
 AX4G5OWL35urzYmD9BTtvArDQv2HDxbqTkWu68YXFirWQ15n4lbEwNbihqUPv/6Q6w5s
 hxdT149rEjB2OTIh7e8oow4rzCvpOOZo+dz17GMmqO1+RVMSBrrqBqhMShJOD94tx0ZW
 Z2xIhB2eufnsDnuGLaR07Hj8mMvqe2XmNHYvtZAGI5caeEb20eJxBQz9UDdNrh8g60sr
 JcyqRxsC3iBrJ1DVFRWCuOG1f5q9LYw6DyMyC+aU4q9/brz319j//iutoOhOE5+KFT0p
 uD8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743095114; x=1743699914;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZH8VyodyFqnviPSXYW3qleDr3/hzkqlJCBLUq6bj3K4=;
 b=FEjiKcCUtBC+veE11R6zJwrjwCItVg8pobbOJ5sbqmlJ5Al0tojgfqOjAAcbTc2qiS
 UhG9KW7gNbEzJIcGEJy+q363e/JXXkhdz/C2BDeVFbRih12dzayYAcVq9hWpZTiDLHGz
 I+r7Dy3fqEmG/N7JjU69emdygXoNUvJUFdWh8qcmvCVW5AMBPp/jY2mJXuyUzVrXJH8i
 MjK7ZPuoSfEEd7xNPdl2qmmv/aZj12jqgE64rf3JLsguY1cxYZv5WvJU/TLdPhLKPcp+
 IGeoJPfqUsS32ajA8SQCRhvPDdE8/csbvTgqlkbnvRRPulslYkemjyE4gOW3wPs1LXyp
 7olw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOhPupY/CPW/hzeOdFIvzvKUf8Jfpw+eM4v84xCK5e2YxZ7s3eOvGd9h/t6tDebt0UZtp8tDDlLRHE@nongnu.org
X-Gm-Message-State: AOJu0YzundzkXysdO5iMlGd8sQXOjIe48G3HURChEARU50E0byBpEEKK
 ZMWDFvY1Ivz09HHu5EvnTjLgG+79Q4AcwyS1fglIgDajB1bmMcoIAt+HtH2yQR1KW0Bqbx/KPBE
 I
X-Gm-Gg: ASbGnctsQjyycAVRiSIm2gVo8a4tlMBDdjMCdNk6Ol8AjDRCPu/NhXuWkOv8hn4hpXV
 EUZSvo9bPrfqVDY08dChZ0q57XoE5UkRf2XFpPCfIROiOemY8N3w9UWr4WMfUSVDYTc58fzeA1F
 iqwgcGB/2b93eMBmRtHOOOqryAiD28XI7veDZoKP5gBkWEts6hUGPhIXNqPlqi8sr3LX9+YYPNR
 38Weu0PdA0sQk+NRgCjAbeRaTEGskhXy2pd+MG9iHB4d/UUFFpioHCHcPwNKnVz1fazJsvarI/K
 p4xzVnFIY2D3cWuc9msD2Sot7CRkcuFxnJWPUJxpGabvbpEC75E7ScMb/GyyAZMOetlux6W0Eoo
 JfObdXTXPDiyz0SC5sBrHnaw=
X-Google-Smtp-Source: AGHT+IGwlYSXe8kVnq1NBgpYAI3coNB5nbJUTImRqmQBfZG8iOz5/p/LuBB67fsqf6/uxu13iSQdBQ==
X-Received: by 2002:a05:6000:2a5:b0:391:1806:e23d with SMTP id
 ffacd0b85a97d-39ad1740291mr3777928f8f.6.1743095113539; 
 Thu, 27 Mar 2025 10:05:13 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b662c1csm82601f8f.28.2025.03.27.10.05.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Mar 2025 10:05:13 -0700 (PDT)
Message-ID: <8b6ac33d-429c-4ef2-a964-7b44249b2790@linaro.org>
Date: Thu, 27 Mar 2025 18:05:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 6/8] target/mips: Introduce mips_cpu_is_64bit()
 helper
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250325154058.92735-1-philmd@linaro.org>
 <20250325154058.92735-7-philmd@linaro.org>
 <1ba52ba5-6d68-483b-88ef-727fd369e4c0@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <1ba52ba5-6d68-483b-88ef-727fd369e4c0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 26/3/25 19:22, Richard Henderson wrote:
> On 3/25/25 10:40, Philippe Mathieu-Daudé wrote:
>> mips_cpu_is_64bit() returns whether the CPU is a
>> 32-bit or a 64-bit one.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/mips/cpu-qom.h | 2 ++
>>   target/mips/cpu.c     | 6 ++++++
>>   2 files changed, 8 insertions(+)
>>
>> diff --git a/target/mips/cpu-qom.h b/target/mips/cpu-qom.h
>> index 9acf647420c..52996e7c354 100644
>> --- a/target/mips/cpu-qom.h
>> +++ b/target/mips/cpu-qom.h
>> @@ -33,4 +33,6 @@ OBJECT_DECLARE_CPU_TYPE(MIPSCPU, MIPSCPUClass, 
>> MIPS_CPU)
>>   #define MIPS_CPU_TYPE_SUFFIX "-" TYPE_MIPS_CPU
>>   #define MIPS_CPU_TYPE_NAME(model) model MIPS_CPU_TYPE_SUFFIX
>> +bool mips_cpu_is_64bit(MIPSCPU *cpu);
>> +
>>   #endif
>> diff --git a/target/mips/cpu.c b/target/mips/cpu.c
>> index d8930468b7d..05b3ce42af5 100644
>> --- a/target/mips/cpu.c
>> +++ b/target/mips/cpu.c
>> @@ -516,6 +516,12 @@ static void mips_cpu_initfn(Object *obj)
>>   #endif
>>   }
>> +bool mips_cpu_is_64bit(MIPSCPU *cpu)
>> +{
>> +    return !!object_class_dynamic_cast(OBJECT_CLASS(CPU(cpu)->cc),
>> +                                       TYPE_MIPS64_CPU);
>> +}
> 
> This is very nearly object_dynamic_cast.  So why not just
> 
>    return object_dynamic_cast(OBJECT(cpu), TYPE_MIPS64_CPU);
> 
> ?

Good point!


