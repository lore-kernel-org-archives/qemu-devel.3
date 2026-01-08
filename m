Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB070D185DB
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 11:44:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdoR4-0001SA-Ia; Thu, 08 Jan 2026 06:44:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdoQx-0001EW-Ae
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 06:44:07 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdoQv-0007oq-Px
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 06:44:07 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47a95efd2ceso27892245e9.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 03:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767872644; x=1768477444; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H0NrGQ7s0ij4n05JRGXa2E3BAuPDKOUZVJLMcEpwmRg=;
 b=x42n44ILhKoqIUGZPWhCinfhH+lV+aS4a38/VPUzGFcr/MjY2+7zzC8Gy5LFORsh21
 tDjtNn0MRLqav0gwiBckQG8qX/TWXDHA6fWuoLvZR+pBX0MB048uMQSkovCRJXXaW51R
 Iw/lde1AbW9EczUfjwKrL6Obpni532uuScb2V7CIfIMlwGpJYJ8TDf3xUpBa0NuAK2mr
 PzrW4nVz/R8yl/PkE8CnUa2WYcaoke49bGbm0QvpXIx/CiYdi3l4clB2+yn4mIz/3m3D
 Q7jlaUuBNcjkMjR5unbWCh7XfB7/BjbYq2ZFzyC9/rKE0G7+nWjVkIJtAe5ZKDjiu+Mw
 bg1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767872644; x=1768477444;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H0NrGQ7s0ij4n05JRGXa2E3BAuPDKOUZVJLMcEpwmRg=;
 b=JaWv46DJ9a/GrNFoiH8qkmKK0usYmIDLklW9HN0LCtamd+2fLR/mD18IVDxQ/vjnSZ
 qRksnmL+YkEeYdjhnHSEvvdJi/lfKZDvLLtAyzClner6xvkOv8cHF9ANrSHstued546Q
 Jt3qTbUadB89ibVzG071aF+lHxkCXqmywA98C/BVx/kRlmAk4OGcilxygWLoALUCS4ha
 nAm8wA27CqGNu/LKl4xt/N0w33dMxs4B25DcJTmuKGbG7pVr8Ngv7Rqc3nQjLwAI/j8b
 E0LNwAugERsJTkHb7VpPaA3+RrY/ZEefhUwuXe0B5HGPi16EmdGc5qZTvvmdcZMUBnPf
 V3tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcL0KwrheSLFgvHwWS87k9SiDU2iGU9GUcx2fafj0YpPRLB+53GEqKWeS3i/dARdBHUBCoohYmQVb2@nongnu.org
X-Gm-Message-State: AOJu0YwxYo2FkIifxJN8soIbCtez4863YXL0S62Hex6/3RMkBwBhmseA
 +1p5hqrQSE1sdWsq6vW7fX7NILTtFaW4BW1mehJFyRBNP3TbqIlaKQlHsYN3/AscKCs=
X-Gm-Gg: AY/fxX6V+7b8XO4dJl9edtgMFUJzJJtptf2uVKSJDE+48AxOIe0V9ZT0MPRBLNFK+SE
 JKACl9DJiVdsP+BYAtVil5hMo2nvg1T5GOJDbyxItn8t1FCF5/OQmCFjrKeozxQIJH1A2btM8W2
 R7MJB6QUwlex0TvkshA50WXC8lGf6PDGbrYz+SC7FNtQOIhMaZaj+FWmZYWdFU7l/pDIvhUUg68
 u4Hft+d2eYfMNubNmvLfomiaUuMVKfkveVkmz+r3+kdKgg2SV9TeDiU7xsE/a/FCarYzHOQ/h4z
 ohuFRV5iY14R2Df07Pw0itegSJqtKmJPZPOVqNy13LTQ4b4e2Tk9MO7TxhG5LCvYuoTqHHpPtVL
 u6ufXK/l4UbcDXmmsuveBah7lPnQV90J3UXAVdSZxCGlZCqjv1ZSZmEfyoHFuTFbJq2tI7Q4NQF
 Y9KteNjaxRmOPu3ElyEc8r4en9jPHBdoQ7S7jkt+BZu3qtuhNMrWC5mFwrYkwoL1BP
X-Google-Smtp-Source: AGHT+IGgCF0zNiPSjN6YHB+RJibxKA5VaMe22qjTq7oBzueJwvNj5UeKT3vb/A17gLoC9wKvB2o1OA==
X-Received: by 2002:a05:600c:3b94:b0:477:9caa:1a26 with SMTP id
 5b1f17b1804b1-47d84b3af65mr75758865e9.29.1767872643711; 
 Thu, 08 Jan 2026 03:44:03 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f69e13bsm146287855e9.7.2026.01.08.03.44.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 03:44:03 -0800 (PST)
Message-ID: <357e0205-d696-4b10-8cec-f7cf2e62c3ba@linaro.org>
Date: Thu, 8 Jan 2026 12:44:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/18] target/s390x: Replace target_ulong -> hwaddr in
 get_phys_page_debug()
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>
References: <20260107130807.69870-1-philmd@linaro.org>
 <20260107130807.69870-7-philmd@linaro.org>
 <d14892bf-a2f3-40e2-910c-a1898ede74d7@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <d14892bf-a2f3-40e2-910c-a1898ede74d7@redhat.com>
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

On 8/1/26 08:37, Thomas Huth wrote:
> On 07/01/2026 14.07, Philippe Mathieu-Daudé wrote:
>> mmu_translate() fills a hwaddr type.
> 
> Does this depend on another patch series again?

I was not expecting dependencies but indeed I'm based on top of
a branch of 272 patches waiting to be merged, so I might have
missed something.

> Currently mmu_translate 
> is still defined like this:
> 
> int mmu_translate(CPUS390XState *env, target_ulong vaddr, int rw, 
> uint64_t asc,
>                    target_ulong *raddr, int *flags, uint64_t *tec)
> 
> i.e. the "raddr" parameter is still a target_ulong pointer.

I tried to arrange patches for incremental changes and bisectability,
but might have failed. That'll be simpler with your "change all of these
in mmu_helper.c in one go." suggestion from next patch.

> 
>   Thomas
> 
> 
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/s390x/helper.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/target/s390x/helper.c b/target/s390x/helper.c
>> index a6c89ed0af3..59e1fd0c4fe 100644
>> --- a/target/s390x/helper.c
>> +++ b/target/s390x/helper.c
>> @@ -43,7 +43,7 @@ hwaddr s390_cpu_get_phys_page_debug(CPUState *cs, 
>> vaddr vaddr)
>>   {
>>       S390CPU *cpu = S390_CPU(cs);
>>       CPUS390XState *env = &cpu->env;
>> -    target_ulong raddr;
>> +    hwaddr raddr;
>>       int prot;
>>       uint64_t asc = env->psw.mask & PSW_MASK_ASC;
>>       uint64_t tec;
> 


