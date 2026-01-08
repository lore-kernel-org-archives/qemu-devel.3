Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE5DD1488A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 01:50:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdfA7-0004GM-NG; Wed, 07 Jan 2026 20:50:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdf9o-0004Eu-Q1
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 20:50:00 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdf9n-0004Mi-25
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 20:49:48 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-29f102b013fso28054245ad.2
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 17:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767836984; x=1768441784; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Gk+CyYanCTAdBZJFPVZch6NcYMx+HD2mLMndY3lq/Eo=;
 b=D5Zgya1Y7bW9+rGJUb+SfRORRjkxvAQ+jJI3s/25bPqvRu9I9DMuS9K88EaPzcXr4z
 RGfxTrKKNM0UhOzuHh1mpTPrznE9BqrMIyEZX7DnzneEcoqCMn5hrii2SXsczGzIjziL
 vXk9zTBkmy0Yirn71EscPh3uX9zEGSvyG+77rJP3xvd5/m9Pkc9xTZT0L3V6Ik+AoS0x
 j0BgnugYa437g5lugNHs3tbbw3BksI55+FzJTBio8PKTC9z2W2q69+GmVZ3HBzrKPnLB
 KlwcIUX4+Jreg1UYNexdCschVUMT8VkwsidxLIdDPboB2+8uM+5TvfU0/wx6dLuo0wcy
 EtKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767836984; x=1768441784;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Gk+CyYanCTAdBZJFPVZch6NcYMx+HD2mLMndY3lq/Eo=;
 b=nO+JlzPg4/Dspa7YkdgxVGR01M7FXnEm9SIIEb3MaVBRfx9NIiyhtewO5wfb5jXbjg
 8H86dcXJB+7LzNndxylIqDdvZFOCzGgS0wtuUHH6Ic1o1wkvETw48KLrs3h69ix2edsO
 s4VAclkHhDPBuPxfT3oQaDn3XZM6FIBTlqZY0EPfpsFPhSXRSYdhcB5BJWQZxCNlq3uG
 jhokZrb9vYIH0V10yAYg6rAZ1BpV3mkRcXZcHMwR/9I/RYvtxU49QtwXs6FoVVXv14ni
 enH3PdiO/zkiTtcxW27H5MgJtosHPKPZN9p29yPnoZM2sS9dGcOQsVX0U0p6ccAyZctI
 xo+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfqQzN0L1UdmAgQBW7rzG/CZHa4D6NgGfsmwsQkSQWEhbN27qKd/iFhWxaiUX4gKZJoMq5Z0E1U1Mw@nongnu.org
X-Gm-Message-State: AOJu0YwUTsiVRWLrUzvZfBYWw1ujUOs08v8v6siKWQ93Iq7B7HF+yat+
 juOTBppZtc0Ww/JGUZwiCjvB2RQRsmmDK92XEmfeHxY+l8qy37OcGlYBrHsZaYqh+dw=
X-Gm-Gg: AY/fxX7XDOxHc9f8hdfEY5CcK10Au73uo+S6fj0XkpViIPnfr2y0jVa3md0v4EE3KXc
 QDMpd5Iq6D/FMS3y7Ooj6AFEcMQNIUzLJsAFIRfxAtuDL/8zTH8LEK0mOTde5depV4AWP1gIusE
 sRSA2aS1sU6Vyy+Ka219wuzT5I5czwctaHJTmtmgvtGNnOZUsESGsE/47SWIIRGsTPY/Cv33mgj
 7teCqVCmqAwx14DOw/eteJsU60Ktzv+bS7v1oNaeAFFNxk+u6w0XXGQLx34bf8oTaHKf7oQOF4B
 BRy78bhduVeX3vdF8+xmqFPzf9em45Ma7fAeUPsvQ2MWhxI/wg3Xxm+K30evjLDSB2dUDZKwg0g
 daDMJqqs5vl8JvTFhLacIQHilCczPQyDen8CXZWI77rQODAy47Ht11MUUxOsk+appNz/jDXBO77
 9FRE6gnIHRXtG0G03CAgVjRbV/Uh6138x0E37e2qZxnzd6vS/+1Ubyf0m/
X-Google-Smtp-Source: AGHT+IG76fgREJGkzqTBRet5XUMhi8/XWOcQkuJ8jMYn0osoVA9PrFJjx4g/Xf5gmrUpz9dd8ZoXAQ==
X-Received: by 2002:a17:902:7205:b0:2a2:ecb6:55ac with SMTP id
 d9443c01a7336-2a3ee424c0bmr28887215ad.7.1767836984206; 
 Wed, 07 Jan 2026 17:49:44 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c4795fsm62263215ad.33.2026.01.07.17.49.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jan 2026 17:49:43 -0800 (PST)
Message-ID: <6f35a609-6499-4645-9aa5-94871a9c0bc6@linaro.org>
Date: Wed, 7 Jan 2026 17:49:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] hw/arm/smmu: add memory regions as property for an
 SMMU instance
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Radoslaw Biernacki <rad@semihalf.com>,
 tangtao1634@phytium.com.cn, Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>
References: <20251216235731.1793908-1-pierrick.bouvier@linaro.org>
 <a8afadf0-fcec-444a-86d8-a75676f8bd76@linaro.org>
 <a467095a-b796-4581-8237-665f1989f7d3@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <a467095a-b796-4581-8237-665f1989f7d3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

On 1/5/26 12:10 PM, Philippe Mathieu-Daudé wrote:
> On 5/1/26 21:05, Philippe Mathieu-Daudé wrote:
>> On 17/12/25 00:57, Pierrick Bouvier wrote:
>>> This will be used to access non-secure and secure memory. Secure support
>>> and Granule Protection Check (for RME) for SMMU need to access secure
>>> memory.
>>>
>>> As well, it allows to remove usage of global address_space_memory,
>>> allowing different SMMU instances to have a specific view of memory.
>>>
>>> User creatable SMMU are handled as well for virt machine,
>>> by setting the memory properties when device is plugged in.
>>>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> ---
>>>    include/hw/arm/smmu-common.h |  4 ++++
>>>    include/hw/arm/virt.h        |  2 ++
>>>    hw/arm/sbsa-ref.c            | 16 ++++++++++++----
>>>    hw/arm/smmu-common.c         | 25 +++++++++++++++++++++++++
>>>    hw/arm/virt.c                | 13 +++++++++++--
>>>    5 files changed, 54 insertions(+), 6 deletions(-)
>>
>>
>>> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
>>> index 62a76121841..9a67ce857fe 100644
>>> --- a/hw/arm/smmu-common.c
>>> +++ b/hw/arm/smmu-common.c
>>> @@ -944,6 +944,13 @@ static void smmu_base_realize(DeviceState *dev,
>>> Error **errp)
>>>            return;
>>>        }
>>> +    g_assert(s->memory);
>>> +    address_space_init(&s->memory_as, s->memory, "smmu-memory-view");
>>> +    if (s->secure_memory) {
>>> +        address_space_init(&s->secure_memory_as, s->secure_memory,
>>> +                           "smmu-secure-memory-view");
> 
> Preferrably: "smmu-normal-view" and "smmu-secure-view" (IMO 'memory'
> is more confusing than helping).
>

A bit of bike shedding, but I'm not sure what "normal" is supposed to 
mean. Basically, it's the view of main memory, as opposed to secure 
view. Especially, "normal" is used to access realm memory also, so I 
would prefer to have something hinting it's global vs secure memory, 
thus the names chosen.

>> Else, are we sure the SMMU implementations will behave correctly?
> 
> Alternatively, use AddressSpace pointers, then:
> 
>           } else {
> 
>               s->secure_memory_as = s->memory_as;
> 
>>> +    }
>>> +
>>>        /*
>>>         * We only allow default PCIe Root Complex(pcie.0) or pxb-pcie
>>> based extra
>>>         * root complexes to be associated with SMMU.
>>> @@ -1008,10 +1015,28 @@ static void smmu_base_class_init(ObjectClass
>>> *klass, const void *data)
>>>        rc->phases.exit = smmu_base_reset_exit;
>>>    }
>>> +static void smmu_base_instance_init(Object *obj)
>>> +{
>>> +    SMMUState *s = ARM_SMMU(obj);
>>> +
>>> +    object_property_add_link(obj, "memory",
>>> +                             TYPE_MEMORY_REGION,
>>> +                             (Object **)&s->memory,
>>> +                             qdev_prop_allow_set_link_before_realize,
>>> +                             OBJ_PROP_LINK_STRONG);
>>> +
>>> +    object_property_add_link(obj, "secure-memory",
>>> +                             TYPE_MEMORY_REGION,
>>> +                             (Object **)&s->secure_memory,
>>> +                             qdev_prop_allow_set_link_before_realize,
>>> +                             OBJ_PROP_LINK_STRONG);
>>
>> Why can't we use device_class_set_props(&static_properties)
>> in smmu_base_class_init()?
>>
>>> +}
>>> +
>>>    static const TypeInfo smmu_base_info = {
>>>        .name          = TYPE_ARM_SMMU,
>>>        .parent        = TYPE_SYS_BUS_DEVICE,
>>>        .instance_size = sizeof(SMMUState),
>>> +    .instance_init = smmu_base_instance_init,
>>>        .class_data    = NULL,
>>>        .class_size    = sizeof(SMMUBaseClass),
>>>        .class_init    = smmu_base_class_init,
>>
>> Anyhow this is functional and I suppose this can be improved on top, so:
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>
> 


