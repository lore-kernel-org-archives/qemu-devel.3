Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D35B5C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 17:00:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpWdl-0004QV-Nr; Wed, 27 Mar 2024 13:00:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpWdj-0004Q3-Rm
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 13:00:39 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpWdh-0001ul-Ny
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 13:00:39 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a4e0e3ef357so3377566b.2
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 10:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711558836; x=1712163636; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AGW+C/Gr+c7wcUaZFDoiaQoGGaCdcH7UV+vZEMvUXvo=;
 b=gNGyt/WkKaOvCNsyp55FqG2oq4FjY4fmOHpjORqOGCI9+NBx6q5vHZexg1SfunZ+ln
 lLEHagOLswze0OFmx29F91BbfPzL2w9thVCfAba2NYVCGfYdruvJai7SQ86YyMiaB+6O
 HMAv0+f3FGuQygzQJ6rJ5dK7p6p1BDpvY8cfJWfpbbokod4gnvkcz+okuIfm8dXVh7Gr
 RHz0PAYmFS66eRcVXZX523F+m1YFQWbnImg5NeJuf0utMkMzkU6Vs83bQxIYe9AJso+j
 06lq8dWVdyB1548GXAWBFlihfdEq63s04u9tSknVQUq450jKn8hz1wI6NZlL/pifTYwN
 j2+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711558836; x=1712163636;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AGW+C/Gr+c7wcUaZFDoiaQoGGaCdcH7UV+vZEMvUXvo=;
 b=bxGP8TkMEbuM+lxPIVfF39VLX2WTuqzGhIqMIvPBcEgOdQsgcr8v45oFV2kdq3cHx7
 1lV2N7tT8HmxIIyckCgxcl5QLUIDJhqFOf73dRBcYnxF9y/HN9nFey79hGx1yYuf2i+h
 Y4p8DfuQX5396KuuN4Su2cdQL7EYVlfodFza9mousso30mjFadNIy5DH1emKFCes/AYq
 9hBZqpKnKzVwQ/adaFFfEE4c6g3i6IW80U9WBTU1SWHs/UhMdZBiNoec9+GJVswEF7DO
 Dn2pBWDG94thqLYhPjR1ncA88LvIHk2LuboAZOxB2S38g12foe24BENjId2cQadVg8V1
 5WCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8Dmvr9DAQpC+XwNJ9pNoHCu/JSgDLff8suHc9SQSq2DR5vHAVf4swSZ1g4/SallWwOmRf7FwexqoMejv48OpsKcdqQIE=
X-Gm-Message-State: AOJu0YzynrcAB7R6x50P8EeyRJwrzeZAiBUoKJcEltEPji8oymvcJ0A3
 ohEmIkbaJbJA+Aw9ivOb2ijSEEp6Au22MM4dvG52ysbdte4t3jxLxeomX/ASb5c=
X-Google-Smtp-Source: AGHT+IEPdLTA5y5eiBq0D+Cee5Or+YkU0ENVo9KfmT8veLATiqPEWuzVMld2AsaPSybc2zDy/BdjvA==
X-Received: by 2002:a17:906:3997:b0:a4d:f620:25e4 with SMTP id
 h23-20020a170906399700b00a4df62025e4mr32708eje.66.1711558836044; 
 Wed, 27 Mar 2024 10:00:36 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.205.175])
 by smtp.gmail.com with ESMTPSA id
 u21-20020a1709067d1500b00a471123323fsm5696070ejo.144.2024.03.27.10.00.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Mar 2024 10:00:35 -0700 (PDT)
Message-ID: <5a0b2c03-ea65-4d7d-89ae-33edaa966f49@linaro.org>
Date: Wed, 27 Mar 2024 18:00:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1] target/nios2: Remove machines and system emulation
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Chris Wulff <crwulff@gmail.com>, devel@lists.libvirt.org,
 Marek Vasut <marex@denx.de>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Maydell
 <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
References: <20240327123554.3633-1-philmd@linaro.org>
 <7aad7197-21f3-4c0e-931c-2eb4febdf94a@linaro.org>
 <fb28d3b0-1ab9-4423-80ef-03a285cf02d7@redhat.com>
 <14787bbb-e6cc-45bd-bb5d-1fb3fee5a60f@linaro.org>
 <49052bf6-658f-4bec-a9da-794670da3706@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <49052bf6-658f-4bec-a9da-794670da3706@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
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

On 27/3/24 16:39, Thomas Huth wrote:
> On 27/03/2024 15.15, Philippe Mathieu-Daudé wrote:
>> On 27/3/24 14:19, Thomas Huth wrote:
>>> On 27/03/2024 13.45, Philippe Mathieu-Daudé wrote:
>>>> On 27/3/24 13:35, Philippe Mathieu-Daudé wrote:
>>>>> Remove the Nios II machines and the system emulation code
>>>>> (deprecated since v8.2 in commit 9997771bc1 "target/nios2:
>>>>> Deprecate the Nios II architecture").


>>>>> diff --git a/hw/nios2/Kconfig b/hw/nios2/Kconfig
>>>>> deleted file mode 100644
>>>>> index 4748ae27b6..0000000000
>>>>> --- a/hw/nios2/Kconfig
>>>>> +++ /dev/null
>>>>> @@ -1,13 +0,0 @@
>>>>> -config NIOS2_10M50
>>>>> -    bool
>>>>> -    select NIOS2
>>>>> -    select SERIAL
>>>>> -    select ALTERA_TIMER
>>>>
>>>> I forgot to mention I deliberately chose to keep the Altera
>>>> timer model in the tree, since it looks like a re-usable
>>>> IP component.
>>>
>>> But if it is not used anymore by any machine, this will happily 
>>> bitrot, won't it? I think I'd rather remove it, too ... maybe in a 
>>> separate patch, so that in case somebody later needs it again, it can 
>>> be restored by simply reverting the patch again.
>>
>> It is related to dynamic machines, how do we decide what components
>> to remove once there? I suppose we'd need to deprecate every single
>> component, like ALTERA_TIMER. But we are not yet generating dynamic
>> machines, so for now we can consider ALTERA_TIMER part of Nios II
>> sysemu removal. I like your idea of removing it as a separate patch.
> 
> Even if we switch to dynamic machines one day, the devices still need to 
> be somehow used and tested in the CI, e.g. by scripts that assemble a 
> machine dynamically. If there's a device that is never used at all, we 
> can also simply remove it until someone needs it again, I think.

Fair enough :)

