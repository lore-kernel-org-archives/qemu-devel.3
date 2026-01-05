Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E671CCF2F8
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 20:11:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcquH-0006MU-Q1; Mon, 05 Jan 2026 15:10:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vcquG-0006Lh-Ll
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 15:10:24 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vcquF-0004bh-4C
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 15:10:24 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4779aa4f928so3416535e9.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 12:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767643821; x=1768248621; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bIU2s4KJJRBbJUd2XBpD85ZPXhJLwARtyREZU1HcZKg=;
 b=o6/AOJmyaOC5F8xDWWmx370vzsJiQkdPZ3bnVZCBonn7Jbnt4Og/jTF5mVZJxYLOU/
 EtPZHBIptB2iORwnxKebJ2bKZEbnNChKerfzOmiqs14g/aY2b6BZhk+c5SY0g64yBg3r
 m6lN9HA4I+rhkvsChqQeabqVGf6aqHTd4+QDqk6/Yeo0Ne7Y8Snfh03JxhJ5jSHAC3dJ
 q1Aitt24oIehMnRa7vD45Z3w9yQkOsAkoLSg+Uj/JOZIkyprpzdr02i6fmKe0DIa40IN
 LH4Px78UuCMvpRwXv2WllBbr5lC1/mvCK59WFpIM6yFeFyzwPxg2sESxyI/EccLrh+3h
 lwkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767643821; x=1768248621;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bIU2s4KJJRBbJUd2XBpD85ZPXhJLwARtyREZU1HcZKg=;
 b=kg6me48Q1QaRHznXiu0nKHkJ+FyE2zguYTsNZlLPNXGW1Kl/MlOi/wlffo1u44tkdA
 bmn8o92LYfOiluyOvGgZF3MU/kHLZM6HVptPo0Fw25iMRJpLjl0itJ9YSDuxtC1GfdMn
 nNaAcu3oJHq7OHssbmDYwTYOfKQ8pBBLhjTxAKtGeJnpAGgDjaCjKJFMhOlhm+yTuh3x
 qVtONTsm9KC9LDP3al/GQZdJYGHy8117XYKaA4voqSnodR62/rHDqiQfSXVtQIST+u5R
 /OkOXrsE7qvls2ofKpRO+KlnZg3Y6pUiN0hSBRY2Q+0YM21u85ZUOVnbKSnAN/OyhNW4
 /1LQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9qSpF8hSNCL/wXDWv8kAeh47FfeoDYY4hJXCNktV8Tv/8eJp6QgX6vvBDB4dnSdYq1xmOmoH1Yga8@nongnu.org
X-Gm-Message-State: AOJu0Yyyr9zO0qGkV8axYF4gM5aSEoXesIb13CfOj/EDr7nv4i9suHon
 IPr7JPOp8+3swYZGjCSeG53t3kHvSQ2QqKvfsXQ5owxL6XTapLuny+RVGrCKu3DRySo=
X-Gm-Gg: AY/fxX4qHd6nMPwDY9Pyna+phU0eI/zGnUtm09GTKpEhTguzHIMEtWsXk+DNuRtQW0L
 CW0uHwY9MJxfXpDupSDYHg9OtioAe49Kn/QOjqPe7Em6yqD3x4Cf1XfZ7ur94AE8Pr8l62K8U57
 UGlhQH0xF5I9co1qwowq1g9AzVUOmmHP47snx/LdyiRaisQs4RStVL2Tmb6WJuFUFn6NyGwd9/6
 BMmGHhhZNwlo9+I1pWbiUFGCq+h4DvqiyiYZkgd7Z8afE8j7Kbh4fmR07hCMJEIL2oAu8oW8S6T
 DA68mirGZ6QOGxkbrJAggOXFYlIorJVH4tNvFmuUQEyzJKB60RjqYHvK2j1TpRGqSAp8rvIp+Nb
 kvRRHmoMz6pueWnWxQTY7MjecMZsV0Rse352IRxa6EERcigjJQG4EwX65GpWRJ7djMBu+lsakX8
 1NfXDrdu67IN3oPgAmx+F4GzZdg7mk1WKfFa7CDAi3UyY10cYkWhTl
X-Google-Smtp-Source: AGHT+IH2z1pKP4wgXypZMaOaz3FmVF61nZs8Sc7OmJXixITySz70+RNHcBmf3gZ7OMT4L9LznUSybw==
X-Received: by 2002:a05:600c:a08:b0:477:9814:6882 with SMTP id
 5b1f17b1804b1-47d7f066044mr7612005e9.5.1767643816844; 
 Mon, 05 Jan 2026 12:10:16 -0800 (PST)
Received: from [10.247.174.66] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7faecaccsm949605e9.2.2026.01.05.12.10.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jan 2026 12:10:16 -0800 (PST)
Message-ID: <a467095a-b796-4581-8237-665f1989f7d3@linaro.org>
Date: Mon, 5 Jan 2026 21:10:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] hw/arm/smmu: add memory regions as property for an
 SMMU instance
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Radoslaw Biernacki <rad@semihalf.com>,
 tangtao1634@phytium.com.cn, Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>
References: <20251216235731.1793908-1-pierrick.bouvier@linaro.org>
 <a8afadf0-fcec-444a-86d8-a75676f8bd76@linaro.org>
In-Reply-To: <a8afadf0-fcec-444a-86d8-a75676f8bd76@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 5/1/26 21:05, Philippe Mathieu-Daudé wrote:
> On 17/12/25 00:57, Pierrick Bouvier wrote:
>> This will be used to access non-secure and secure memory. Secure support
>> and Granule Protection Check (for RME) for SMMU need to access secure
>> memory.
>>
>> As well, it allows to remove usage of global address_space_memory,
>> allowing different SMMU instances to have a specific view of memory.
>>
>> User creatable SMMU are handled as well for virt machine,
>> by setting the memory properties when device is plugged in.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   include/hw/arm/smmu-common.h |  4 ++++
>>   include/hw/arm/virt.h        |  2 ++
>>   hw/arm/sbsa-ref.c            | 16 ++++++++++++----
>>   hw/arm/smmu-common.c         | 25 +++++++++++++++++++++++++
>>   hw/arm/virt.c                | 13 +++++++++++--
>>   5 files changed, 54 insertions(+), 6 deletions(-)
> 
> 
>> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
>> index 62a76121841..9a67ce857fe 100644
>> --- a/hw/arm/smmu-common.c
>> +++ b/hw/arm/smmu-common.c
>> @@ -944,6 +944,13 @@ static void smmu_base_realize(DeviceState *dev, 
>> Error **errp)
>>           return;
>>       }
>> +    g_assert(s->memory);
>> +    address_space_init(&s->memory_as, s->memory, "smmu-memory-view");
>> +    if (s->secure_memory) {
>> +        address_space_init(&s->secure_memory_as, s->secure_memory,
>> +                           "smmu-secure-memory-view");

Preferrably: "smmu-normal-view" and "smmu-secure-view" (IMO 'memory'
is more confusing than helping).

> Else, are we sure the SMMU implementations will behave correctly?

Alternatively, use AddressSpace pointers, then:

         } else {

             s->secure_memory_as = s->memory_as;

>> +    }
>> +
>>       /*
>>        * We only allow default PCIe Root Complex(pcie.0) or pxb-pcie 
>> based extra
>>        * root complexes to be associated with SMMU.
>> @@ -1008,10 +1015,28 @@ static void smmu_base_class_init(ObjectClass 
>> *klass, const void *data)
>>       rc->phases.exit = smmu_base_reset_exit;
>>   }
>> +static void smmu_base_instance_init(Object *obj)
>> +{
>> +    SMMUState *s = ARM_SMMU(obj);
>> +
>> +    object_property_add_link(obj, "memory",
>> +                             TYPE_MEMORY_REGION,
>> +                             (Object **)&s->memory,
>> +                             qdev_prop_allow_set_link_before_realize,
>> +                             OBJ_PROP_LINK_STRONG);
>> +
>> +    object_property_add_link(obj, "secure-memory",
>> +                             TYPE_MEMORY_REGION,
>> +                             (Object **)&s->secure_memory,
>> +                             qdev_prop_allow_set_link_before_realize,
>> +                             OBJ_PROP_LINK_STRONG);
> 
> Why can't we use device_class_set_props(&static_properties)
> in smmu_base_class_init()?
> 
>> +}
>> +
>>   static const TypeInfo smmu_base_info = {
>>       .name          = TYPE_ARM_SMMU,
>>       .parent        = TYPE_SYS_BUS_DEVICE,
>>       .instance_size = sizeof(SMMUState),
>> +    .instance_init = smmu_base_instance_init,
>>       .class_data    = NULL,
>>       .class_size    = sizeof(SMMUBaseClass),
>>       .class_init    = smmu_base_class_init,
> 
> Anyhow this is functional and I suppose this can be improved on top, so:
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 


