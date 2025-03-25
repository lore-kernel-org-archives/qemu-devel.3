Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A93F6C3600B
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 15:21:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx657-0007Ey-VR; Tue, 25 Mar 2025 11:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tx656-0007EW-Bm
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 11:20:44 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tx654-0001BQ-Dv
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 11:20:44 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3912e96c8e8so3276423f8f.2
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 08:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742916041; x=1743520841; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CLhTm/m5kZr9omcJwQPqd2se7F6veBndREeo7KRRozU=;
 b=xHLx937s6hHhzyks1TJqX+L0jB3+fQXxHdwuHgf8olHzMSEJBNeaztQJqivejNxUuJ
 AC2ZVRipeySfXCCbqgY1KvaqufaO5PSLcYFjp9zK9rSVC5ztm/3ScbuIyRZAeuIdY0cd
 rSARwEsyGB75oW/TG+ltxBXyt/OspB+A80YOFYB6ODeaiAuByy3rJieJZs/yCWz7aMPr
 IYsZrK5iTGsYYaYqjYzsvDV3ASxFeRnFTdMkM0VNbTuZZDpXAw28jQJl7z9VnhLwMKZv
 PfRe+ZToHDyfb7IJyyqH7gd1Zjzi32yVC8w+TArZRDcw15Q3lxM/lUYqk/omB4e8EJko
 o4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742916041; x=1743520841;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CLhTm/m5kZr9omcJwQPqd2se7F6veBndREeo7KRRozU=;
 b=VHLqzIPPFrLL4UeAiyoxfSIF8IdI41NkUNCB5cIbt+mHjlWlVbh5M6yH2uJ4MZoyBI
 UU/E9k5flm0yA4/lfVxq1MGsdGt8wdux4dj3KIE8/tj7NxY3rd5oKQZdEJ/ncAwMAeUz
 a/BH7xcsyi6OqOqZa6acE1QwHb6HijnKiezCgfQARcf7iqeZ1UCN1Q0yRmloaSBFYehM
 DVa4Hw1rZwNUCKRx5sDpyB4n+6PEUDq8Jt+nKO9fbLQasFZZYdGipaJxo0e3+odFegqy
 9rh9X0KAPXckabI7eYj24gEczMoZqjk3B3daTxg0OwFF+iQEM6lcZ9214M/jzxK6LxJh
 mXgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFLGdlwCuqLPGKRuZC1AMpZERfAJ+YTpGGzaFus5JsgTypskBC002nZQKVa6CieqC/0NanFd/S70fG@nongnu.org
X-Gm-Message-State: AOJu0YzqxV6Nt1eJlWh5fsDqTBsRtnlcuPJBhVUvCwy2APLPPcERRsqP
 W7BQy3PUBdbvMwfoki+qBOfmV7gnhnyQpSMgyMpE+hrvkC/qjfKz4CP2F9eqTr8=
X-Gm-Gg: ASbGncsuRolf2eLdrgtBZdJPNF1sYCcn1s0MfeJccW00j8icGD5lVOsspAnUcRjwM6w
 T6q08GjpFcmvahjbISRpOdQe11/XGypKlAAtbxbcAMy5wbOsBU/3EB8tz1fBPtdjZ8VBd/2oEnE
 i/dJAxdw2a8dlh4iVxcGpNSgK01LEY6Ras32FC3eHEG5LoV219SZ9jp+ox02HOrscsVjpf6hYjh
 AYUirtB8MAVdYOSmYkvS1IxzZB7VIoAOLK9dtW2n8TQTpJJ8lcf59sQT/eXciCAOTKO88ZIv9N5
 YjV+AyTQANZPWG6MIJf0ajmmzwPUONrvVBBlz+xAStZaHIrEiAU5QkQi+nsBoFh7/2HSfQTXQKF
 78LeG0yKmhfFn
X-Google-Smtp-Source: AGHT+IG6fPf/X02ymhwblZyZ11SfUl1c0hew2Uw+MJNvTKVFO0ww067fHoaRhAFhL1W9QylX6hancA==
X-Received: by 2002:a5d:59a6:0:b0:390:f6aa:4e72 with SMTP id
 ffacd0b85a97d-3997f8fabdbmr15020725f8f.18.1742916040692; 
 Tue, 25 Mar 2025 08:20:40 -0700 (PDT)
Received: from [192.168.69.175] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9b55cdsm14089517f8f.52.2025.03.25.08.20.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Mar 2025 08:20:39 -0700 (PDT)
Message-ID: <8426486f-d795-475a-b98e-35c31ae3f9a9@linaro.org>
Date: Tue, 25 Mar 2025 16:20:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/18] target/mips: Make MIPS_CPU common to new MIPS32_CPU
 / MIPS64_CPU types
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20231010092901.99189-1-philmd@linaro.org>
 <20231010092901.99189-18-philmd@linaro.org>
 <8d30ccda-5b81-42fd-b36c-79bbaceffa2a@linaro.org>
 <f46958e5-01e3-4d88-9d76-00af9d30f110@linaro.org>
Content-Language: en-US
In-Reply-To: <f46958e5-01e3-4d88-9d76-00af9d30f110@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 15/3/24 13:22, Philippe Mathieu-Daudé wrote:
> On 13/10/23 06:34, Richard Henderson wrote:
>> On 10/10/23 02:28, Philippe Mathieu-Daudé wrote:
>>> "target/foo/cpu-qom.h" can not use any target specific definitions.
>>>
>>> Currently "target/mips/cpu-qom.h" defines TYPE_MIPS_CPU depending
>>> on the mips(32)/mips64 build type. This doesn't scale in a
>>> heterogeneous context where we need to access both types concurrently.
>>>
>>> In order to do that, introduce the new MIPS32_CPU / MIPS64_CPU types,
>>> both inheriting a common TYPE_MIPS_CPU base type.
>>>
>>> Keep the current CPU types registered in mips_register_cpudef_type()
>>> as 32 or 64-bit, but instead of depending on the binary built being
>>> targeting 32/64-bit, check whether the CPU is 64-bit by looking at
>>> the CPU_MIPS64 bit.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   target/mips/cpu-qom.h | 13 ++++++-------
>>>   target/mips/cpu.h     |  3 +++
>>>   target/mips/cpu.c     | 11 ++++++++++-
>>>   3 files changed, 19 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/target/mips/cpu-qom.h b/target/mips/cpu-qom.h
>>> index 9c98ca1956..1a71509b5e 100644
>>> --- a/target/mips/cpu-qom.h
>>> +++ b/target/mips/cpu-qom.h
>>> @@ -1,5 +1,5 @@
>>>   /*
>>> - * QEMU MIPS CPU
>>> + * QEMU MIPS CPU QOM header (target agnostic)
>>>    *
>>>    * Copyright (c) 2012 SUSE LINUX Products GmbH
>>>    *
>>> @@ -23,13 +23,12 @@
>>>   #include "hw/core/cpu.h"
>>>   #include "qom/object.h"
>>> -#ifdef TARGET_MIPS64
>>> -#define TYPE_MIPS_CPU "mips64-cpu"
>>> -#else
>>> -#define TYPE_MIPS_CPU "mips-cpu"
>>> -#endif
>>> +#define TYPE_MIPS_CPU   "mips-cpu"
>>> +#define TYPE_MIPS32_CPU "mips32-cpu"
>>> +#define TYPE_MIPS64_CPU "mips64-cpu"
>>> -OBJECT_DECLARE_CPU_TYPE(MIPSCPU, MIPSCPUClass, MIPS_CPU)
>>> +OBJECT_DECLARE_CPU_TYPE(MIPS32CPU, MIPSCPUClass, MIPS32_CPU)
>>> +OBJECT_DECLARE_CPU_TYPE(MIPS64CPU, MIPSCPUClass, MIPS64_CPU)
>>>   #define MIPS_CPU_TYPE_SUFFIX "-" TYPE_MIPS_CPU
>>>   #define MIPS_CPU_TYPE_NAME(model) model MIPS_CPU_TYPE_SUFFIX
>>> diff --git a/target/mips/cpu.h b/target/mips/cpu.h
>>> index 6b026e6bcf..3b6d0a7a8a 100644
>>> --- a/target/mips/cpu.h
>>> +++ b/target/mips/cpu.h
>>> @@ -10,6 +10,9 @@
>>>   #include "hw/clock.h"
>>>   #include "mips-defs.h"
>>> +/* Abstract QOM MIPS CPU, not exposed to other targets */
>>> +OBJECT_DECLARE_CPU_TYPE(MIPSCPU, MIPSCPUClass, MIPS_CPU)
>>
>> Why is this one moved back to cpu.h?
>> You exposed TYPE_X86_CPU in i386/cpu-qom.h...
> 
> First thinking was to expose the base TYPE, so we can use QOM methods
> to enumerate implementations, but not expose QOM state/class getter
> for the base type (except in target/foo/). HW would use concrete
> 32 or 64b type state/class getter. I might be wrong, so I'll keep
> the base type exposed for now. We might restrict later.

With retrospective I was indeed wrong, as it seems useful for a
heterogeneous board to check "is there any vCPU based on Arch FOO"
without having to worry for FOO being 32 or 64. I'll expose the
base arch as QOM definition.


