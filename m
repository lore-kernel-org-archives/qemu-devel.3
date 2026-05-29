Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB6F9CD6E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 14:37:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSyLJ-0007FI-HZ; Fri, 29 May 2026 10:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSyLB-00075j-9Z
 for qemu-devel@nongnu.org; Fri, 29 May 2026 10:37:38 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSyL9-0007hJ-F0
 for qemu-devel@nongnu.org; Fri, 29 May 2026 10:37:36 -0400
Received: by mail-wr1-x443.google.com with SMTP id
 ffacd0b85a97d-45ef372c58aso385508f8f.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 07:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780065454; x=1780670254; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=t+D0Q/aqLAwBDuCvlNp0ak5Yi1mV0wkY+x8QEgNjGRg=;
 b=xh5ixn+7Q8sOGzCHbr2dPNVVNuo3pDPV9gBvyPy6tVpr0uGqgzp/e1q5N402vnuXYK
 WrBCfPchTBYNELraPgA0Twieij2bRwVAYQePmJLTBvZ4Ol1DpKwa+0l3zA3DD4qwJftn
 +L93QxhYGvXn4lrQ0/5h8VDEtj/hRB5gUGUnFtZ7BRiFzj5o//z3B8I9kcJ6niMpJlFf
 8azwWL9YnEHzKoeqCluJrZM+Jb9GYAya0nmDoVLhhbJUhfu2t6jHFB1Xv0G+msbhpHNl
 L5qQa8PTN/dmIAnAQEOUlSojDfrbEDP8R92lTTaHZcCYEgEQdZK0HeywXJ9eV5v+izTY
 HwMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780065454; x=1780670254;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t+D0Q/aqLAwBDuCvlNp0ak5Yi1mV0wkY+x8QEgNjGRg=;
 b=gQFsXoOjJWIOzQ2b7rpt/ZtM/Qn23Y85d0MI8evuUcjtnacyo7fbUKh4F0/4fKLFv8
 L6g4brlH03eBp8/FEBf4nPJ5kVbodH3rHSkhS9LABNJRDBCoImm27nCRTl/v5mMamdVe
 Gr0+/QAc8/MBNR0nKSJ7ENT7awU4FboILWyJv1hxugq+ryYnCyIm/aIXEcdF+z9dVnLK
 SLNM/ZgWLp0rV/SFAhjOu50bEtBR38n5Dc/ujyVSgi+XDRL4FZ6jOzOQAHvGitA2sUEn
 4VOFqYo06/NNp3NDqT2u/B7Tj2czVUVQpa2764e2p5Ql2U7UDL9ByaIXZ1UuCpYXYOfI
 0SAQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ84EoQIrV2MJsAQCr9Tttm1OEzLJA5MNaKRAgeMRrCQZEHZj5XlEA9FfsSO2RzvfffDhUkEI1f8cqcr@nongnu.org
X-Gm-Message-State: AOJu0Yx150gIBnmBT6s/yGAC9aZraJGZiLqZ0SonJ+Z7nIr1BMDNnuqQ
 qAgEDQS1XbwuIPny17YYb2GRC93SBO3YYAeqD8InXh9ABsqCKWY1xMejOXXuf4pCsg4=
X-Gm-Gg: Acq92OHv1ocP917S6zcJ14CWypXnSfDy2uufrpkwPI3/K9CWU/X7sHUF1xiF08hK6/f
 Rr2esd3ck+UYPzYCbTwrJsYD+0ebUXGBfTGrd9pMRVILL3jEEfX19GovKJ1GWaPmVVqWxWNmeVD
 ZAmdLwTebPJTe5RpS89Ygk5huvaunB8hA67H4f9HQlxTXmflWOzbwLnyaudrjYx0t3xem17+haN
 ChmZ2EQBmkxNP3nbVtmWyqLESZhzmbzTXmdFZIh/EGBH7EYau3RCdpZ/kgeYDHpAyfawenzTRit
 LZJcpAPNsHuHJPCMl5J2xAJInjOnkkcSoQOq/EpunxQTaMZeiSPY0bs8tve1CGDtZvRs1XOFTC0
 ENCJ69rSRVCkuxcjLTQhvGHamNqWeBxaxyLtTtUWleK0MfS8UYP8zW3CwlZfoc5OMRWXCeJ/T1Z
 m/lKCg7jKjZCUEk8Hru1CjCyVHNUx8D07xO0oa2yXrs+jBhc568nhgc/rbxpuVMNXb1srJHn0Ki
 SGVeo1WhbJBe0U=
X-Received: by 2002:a05:6000:2892:b0:45e:73eb:5119 with SMTP id
 ffacd0b85a97d-45ef6b5ffb8mr163554f8f.22.1780065453693; 
 Fri, 29 May 2026 07:37:33 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef358c07bsm4077507f8f.36.2026.05.29.07.37.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 May 2026 07:37:33 -0700 (PDT)
Message-ID: <ee503de0-85fb-4220-8069-6a084f164339@linaro.org>
Date: Fri, 29 May 2026 16:37:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/common: Remove last bit of target-specific code
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Anton Johansson <anjo@rev.ng>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260528140857.44130-1-philmd@linaro.org>
 <b2a58b62-b061-4bdf-b459-9953b7f373fe@oss.qualcomm.com>
 <5b693f87-2f9a-4564-9efb-83c815bcb20e@oss.qualcomm.com>
 <dc1b9965-4ac3-4157-91e3-edb9d93556cf@linaro.org>
 <39ce331b-e361-49ae-9954-47e3aaa88948@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <39ce331b-e361-49ae-9954-47e3aaa88948@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x443.google.com
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

On 28/5/26 22:02, Pierrick Bouvier wrote:
> On 5/28/2026 12:59 PM, Philippe Mathieu-Daudé wrote:
>> On 28/5/26 20:47, Pierrick Bouvier wrote:
>>> On 5/28/2026 11:47 AM, Pierrick Bouvier wrote:
>>>> On 5/28/2026 7:08 AM, Philippe Mathieu-Daudé wrote:
>>>>> Initialize the TypeInfo structure at runtime using the TargetInfo
>>>>> API to resolve TYPE_ACCEL_CPU, replacing CPU_RESOLVING_TYPE by
>>>>> target_cpu_type(). Since the code is no more target-specific, move
>>>>> it to accel-common.c, removing the need for accel-target.c.
>>>>>
>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>> ---
>>>>> Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>>>>
>>>>> Pierrick, this is an alternative for both
>>>>> 20260528051642.115721-4-pierrick.bouvier@oss.qualcomm.com
>>>>> and
>>>>> 20260528051642.115721-5-pierrick.bouvier@oss.qualcomm.com
>>>>> for your "single-binary: fix compilation/execution for {arm,
>>>>> aarch32, microblaze}" series. WDYT?
>>>>> ---
>>>>>    accel/accel-common.c | 15 +++++++++++++++
>>>>>    accel/accel-target.c | 41 -----------------------------------------
>>>>>    accel/meson.build    |  1 -
>>>>>    3 files changed, 15 insertions(+), 42 deletions(-)
>>>>>    delete mode 100644 accel/accel-target.c


>>>>> diff --git a/accel/meson.build b/accel/meson.build
>>>>> index 7da12b9741f..1b5b37e3097 100644
>>>>> --- a/accel/meson.build
>>>>> +++ b/accel/meson.build
>>>>> @@ -1,5 +1,4 @@
>>>>>    common_ss.add(files('accel-common.c'))
>>>>> -specific_ss.add(files('accel-target.c'))
>>>>>    system_ss.add(files('accel-system.c', 'accel-blocker.c', 'accel-
>>>>> qmp.c', 'accel-irq.c'))
>>>>>    user_ss.add(files('accel-user.c'))
>>>>>    
>>>>
>>>> I'm open to follow this approach first .
>>>> The only downside is that it limits to a single accelerator parent type,
>>>> which will be a problem as soon as we have two arch using this framework
>>>> for tcg. Nothing we can't solve later though.
>>
>> Good point. I'll see how to handle that (as a following up patch).
>>
> 
> Maybe we need to duplicate this struct for each base architecture? :)

Back to your patch? I was never fond of AccelCPUClass and its QOM use,
ended to ditch it completly:
https://lore.kernel.org/qemu-devel/20260529142434.87880-1-philmd@linaro.org/

> 
>>>>
>>>> Regards,
>>>> Pierrick
>>>
>>> Forgot :)
>>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>
> 


