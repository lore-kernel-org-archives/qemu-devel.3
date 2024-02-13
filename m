Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A92BBC4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 13:02:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZsOa-0007H7-9m; Tue, 13 Feb 2024 08:00:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZsOV-0007Fd-6L
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 08:00:15 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZsOT-00054F-44
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 08:00:14 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-411ca9dfffdso2494505e9.2
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 05:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707829208; x=1708434008; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Jt8fd4/S/HkFgosxslTrakxymbh51e1E7Iz+Z+eRB8o=;
 b=c0jUCaklK8ykuqMaLdj4qG45R18ZPs5X+cpdYrYU8kpxyMGKId7XZ38w/mlDzczqHl
 Az+CdEAGaCthDaw/8/qjDDropDJYWGh2C8dSBcB+Zo6t/KufaZGnJYEeDva+Who/LPll
 drBHFbXnuWUX/fvB7IRjgF5ctfDp65zBtPvQ/4WbAoICctbRPKipF/tAGD4/TIMYEWUZ
 y7dt4nhi9+BHcFPiV26DXHXK+GGqUek7l2ISSiDXSWjBIcB++EsO5E4v0bpLCOrZa9gD
 SMQ05982qTkJ4IA9ABY1MB1IE+FbN4yjQJQr3T6r9pF3K/vioUvamChUZy8J9QBB9COX
 m5Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707829208; x=1708434008;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Jt8fd4/S/HkFgosxslTrakxymbh51e1E7Iz+Z+eRB8o=;
 b=i1JQmj2M4QbwGZtAfl0wvEqJFfXlOHf+76drOZnyjHH1CIo3zbsHi0XHY/zC2rvi4v
 qp5cd1qHQJ/pPjyCGuqtgLBqjE8yZzcfzFUOyAS2I1F1fHjz/hRhFyO7TBS2fWhBUJyk
 oHFg23N/5S5ZOEWUk+hIrj+GmsHywgxGf1C+ypTbzcTZ9kVsELKH3MNHPp19DkukKJ65
 KXdYuv2I+XY8xOwXxTeQYaw6KKsKnNOxxyX/uoVg4DG7PgY8Wv44NXkiHRpVgPPYWd77
 hYzXinPOEKxFG7RXW1vGp2wuP9hZM6OIT6522X4kRs2Iksyyn/9nkDW6LgEjP8slF4O0
 11DQ==
X-Gm-Message-State: AOJu0YxqANpZvDx6uJnDYUZO0cvBI5qiMZ+Nmc/etarli0cUi9oreYIr
 /kiEy4HCVLK3ZRcASVpeVyv01GZZnD41T9R3QPIkRGjsJUgcNcXDZOfLntJfUZs=
X-Google-Smtp-Source: AGHT+IGJNEFi1nmBUtyz/3dm6UksAcKQQiUht90+H0oybPwO643PSduMU0qHGJOK/GQCmrf/OX/Kbw==
X-Received: by 2002:a05:600c:4ed0:b0:410:c127:62fe with SMTP id
 g16-20020a05600c4ed000b00410c12762femr4991591wmq.1.1707829208244; 
 Tue, 13 Feb 2024 05:00:08 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWLAc7XE7XGKJWxovSC8XBDjN1Qh8nuULtlKLsFFfVJgweq7wRApkp3GZ30uvbr29hGyPfoEowitz9PqUSKdU5cXdeYhPS/WuDPwrgBvDIEvktpTC/wAwUTQ063IqxBoYw25jfruCKPK+EzlL+uWt19sA7AOQ9thpFnuI1lkITHiRO7Xy+JcatxF+5r01I2f2U7x8nSehXwyPdR12H/fuTcAf6q5fMhXTpIyvwXvC5auubchlCrgdzTLdkZQBbfePgS8e8efexliK5UmfMlD7y5CXffRW6nNhEJ1PHcgP5BVkzJ3YD+90V0vKJ2X3i442OCG7Lw8GfxuwrWK6snhvuiuPdHHIGxrIW+1lfoSemxtgs=
Received: from [192.168.69.100] ([176.176.128.243])
 by smtp.gmail.com with ESMTPSA id
 4-20020a05600c028400b00411a0477755sm3539764wmk.9.2024.02.13.05.00.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 05:00:07 -0800 (PST)
Message-ID: <566758d3-89d1-4108-b9af-4680c0ecb7d7@linaro.org>
Date: Tue, 13 Feb 2024 14:00:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/11] hw/sparc64/cpu: Initialize GPIO before realizing
 CPU devices
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@linux.intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>
References: <20240208181245.96617-1-philmd@linaro.org>
 <20240208181245.96617-12-philmd@linaro.org>
 <CAFEAcA8XF4i7qNWRAO2PjiNxecLY8qfGzYK-ZDE8fvy7mpf-4Q@mail.gmail.com>
 <63c7c694-ab39-40f0-bda7-96edc70ca87c@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <63c7c694-ab39-40f0-bda7-96edc70ca87c@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 9/2/24 23:01, Mark Cave-Ayland wrote:
> On 09/02/2024 11:34, Peter Maydell wrote:
> 
>> On Thu, 8 Feb 2024 at 18:14, Philippe Mathieu-Daudé 
>> <philmd@linaro.org> wrote:
>>>
>>> Inline cpu_create() in order to call
>>> qdev_init_gpio_in_named_with_opaque()
>>> before the CPU is realized.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   hw/sparc64/sparc64.c | 4 +++-
>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/sparc64/sparc64.c b/hw/sparc64/sparc64.c
>>> index 72f0849f50..3091cde586 100644
>>> --- a/hw/sparc64/sparc64.c
>>> +++ b/hw/sparc64/sparc64.c
>>> @@ -24,6 +24,7 @@
>>>
>>>
>>>   #include "qemu/osdep.h"
>>> +#include "qapi/error.h"
>>>   #include "cpu.h"
>>>   #include "hw/boards.h"
>>>   #include "hw/sparc/sparc64.h"
>>> @@ -271,9 +272,10 @@ SPARCCPU *sparc64_cpu_devinit(const char 
>>> *cpu_type, uint64_t prom_addr)
>>>       uint32_t  stick_frequency = 100 * 1000000;
>>>       uint32_t hstick_frequency = 100 * 1000000;
>>>
>>> -    cpu = SPARC_CPU(cpu_create(cpu_type));
>>> +    cpu = SPARC_CPU(object_new(cpu_type));
>>>       qdev_init_gpio_in_named(DEVICE(cpu), sparc64_cpu_set_ivec_irq,
>>>                               "ivec-irq", IVEC_MAX);
>>> +    qdev_realize(DEVICE(cpu), NULL, &error_fatal);
>>>       env = &cpu->env;
>>>
>>>       env->tick = cpu_timer_create("tick", cpu, tick_irq,
>>> -- 
>>> 2.41.0
>>
>> For the purposes of letting us enforce the "init GPIOs
>> before realize, not after" rule,
>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>>
>> but it looks like this code is adding a GPIO to a
>> device from code that's not actually part of the
>> implementation of the device. Ideally most of the code in
>> this file should be rolled into the CPU itself in target/sparc.
> 
> I suspect the reason the code is arranged like this is because IVECs 
> aren't part of the core SPARC 64-bit architecture specification, 
> although they happen to be implemented by the CPUs used by QEMU. Perhaps 
> this would be better be handled on a CPU model basis, but I agree this 
> shouldn't be a blocker for this patch.

Suggestion recorded as https://gitlab.com/qemu-project/qemu/-/issues/2163.

Thanks both!

Phil.

