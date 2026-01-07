Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57A6AD0D14B
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 18:03:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdXsW-0007pe-O8; Wed, 07 Jan 2026 13:03:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdXs1-0007e0-Av
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 13:02:57 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdXrz-0000zO-JG
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 13:02:56 -0500
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-bc29d64b39dso989476a12.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 10:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767808974; x=1768413774; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4Am2/Nuw3aRl/UlKx93MkIvwIzCrCKfg4v9OKCoZibY=;
 b=LkA2mBcdnSZxbUXlZdICBxHvW7aSfNVqF0U+Y0xgpbqdVWobUfScnoGB5XLJDIRgKk
 7XA49TGa3cvA7TDzCedgdHh511T06oivtmQQ0ysbumJ+HL/7KtWAD8V70COzts9YU0wu
 YKKB57cnVpsHau84wNOYcEVhyWiYM713WM5KgPkQtBLT2TNXtXQQrohc4btboUHA4Wkj
 PqNfM2EZBcJG0RR5sR5TStu/TDqVVfQIuyJa7869Cox/cVYycFZPjuCMPPOXdqkSH5nV
 oRN2zoSzHUA9Lfzb1ijLofMlh5B9dpVK3sO2goWXPhJO2/v1I+coZkeLVwn+7IfMqYId
 qFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767808974; x=1768413774;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4Am2/Nuw3aRl/UlKx93MkIvwIzCrCKfg4v9OKCoZibY=;
 b=vJDilo4jtF590aIOBOS/W0WYLVK4Hmy+H2LVwpJVfW4cI/4UYQHTO8ZP7VXGtTz+2C
 TWQL7jMgybK8MH+zLkxAqVQR11vzqaCxe/HppwrNnOsy1Wuo/YSgnx4Zsc22DEjPh/VU
 deysRLsm8ka4REgRtqwNZxLAKDIVo2w+oIIgsHcjwkV4lRcxxntuIEaKy//nVzoAQ+uF
 oLc5IQi7FdIbOQat0g0r44vvCH4V6WY5jOGRplzcrIAfrWvn+Fk9Iw1OyQ+FVubt08Qj
 v+trCNE1/WxXRwM8WDqJRiBwUf1P9jvEDpJF2ASXu2NQq8OcENhK5Ljp9QrmbH3GCoRX
 y7MQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMhDg8zPHfqEOoNEtfx2PEsjYYbfXWf3aoIbveTjWA6lQ3YhaFA1Jzp6GwiwPMXxN+osQCIsndIEUB@nongnu.org
X-Gm-Message-State: AOJu0YzIJNVneuIxkfdArVLIk64XI0LU0oIJ7hVUspaePN69GeFS1wot
 AqPlVKMOwGnFMHL+dgP88umW6tOme/qNPRMCJVnNGFqN54RsAzNGiL/Vtl+VxIRg5HI=
X-Gm-Gg: AY/fxX7UEFemTuqs/GsxCNpwDtw14YLGybPyhpA3GWC87LIRx53Fwf/grftCs+flDqQ
 4KiHcGr/Br3g9wX7A3xwP8JowXDir1TCSZysEmW4yCdzR406kgX72pMbIaUp4Evb/1izwwcEpB6
 vS0CqBzMd/7Ae6D97014dw60CBFL50XWewT5V8Cj5kKLpSTvs62UlZzQBJFj9a/7/BptkeeFXZa
 g07KXe4495T+thrm2iq3I9ygEumPK2wgL7luLuYDpUxxQHHTNN3zTZ6ZFZOSYTN8WHfPFvLlw8H
 M1mIXLRE+Cu5ImleIIxhSs5clPYQValZc9x3GOfj2pu3n/c4Q1vYIYUvnNaYZeBrM2U1GdMSkVw
 Vse0FPBQYN2yLeiaKjSfL+mmAUsdvgwha2rvOgkgcvL9FkO551s2dFE7E9k1NITRX5x98h0Hpwf
 XAzCJ6tHvqjSDPtLao7LqhVuTONNQtVk6OHrBbJxy7vxct4Wqos5jaCLrBw1h2EZKS7wI=
X-Google-Smtp-Source: AGHT+IH8aPTYs6XRRRulPemcTtz32Ztck/GgkW8GnKBxQwTFE0ZbBgWBSmpqd1UaxDQepOxefZrULQ==
X-Received: by 2002:a17:90b:1643:b0:340:bc27:97b8 with SMTP id
 98e67ed59e1d1-34f68c4ffd5mr2702717a91.10.1767808973347; 
 Wed, 07 Jan 2026 10:02:53 -0800 (PST)
Received: from ?IPV6:2001:569:6fb1:810d:63cb:57dc:3bf7:ccf8?
 ([2001:569:6fb1:810d:63cb:57dc:3bf7:ccf8])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f5f88e95dsm5617132a91.12.2026.01.07.10.02.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jan 2026 10:02:53 -0800 (PST)
Message-ID: <ea63e54b-adf0-4ab5-88ac-d522d578ab58@linaro.org>
Date: Wed, 7 Jan 2026 10:02:46 -0800
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
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <a8afadf0-fcec-444a-86d8-a75676f8bd76@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x533.google.com
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

On 2026-01-05 12:05, Philippe Mathieu-Daudé wrote:
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
>>    include/hw/arm/smmu-common.h |  4 ++++
>>    include/hw/arm/virt.h        |  2 ++
>>    hw/arm/sbsa-ref.c            | 16 ++++++++++++----
>>    hw/arm/smmu-common.c         | 25 +++++++++++++++++++++++++
>>    hw/arm/virt.c                | 13 +++++++++++--
>>    5 files changed, 54 insertions(+), 6 deletions(-)
> 
> 
>> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
>> index 62a76121841..9a67ce857fe 100644
>> --- a/hw/arm/smmu-common.c
>> +++ b/hw/arm/smmu-common.c
>> @@ -944,6 +944,13 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
>>            return;
>>        }
>>    
>> +    g_assert(s->memory);
>> +    address_space_init(&s->memory_as, s->memory, "smmu-memory-view");
>> +    if (s->secure_memory) {
>> +        address_space_init(&s->secure_memory_as, s->secure_memory,
>> +                           "smmu-secure-memory-view");
> 
> Else, are we sure the SMMU implementations will behave correctly?
> 
>> +    }
>> +
>>        /*
>>         * We only allow default PCIe Root Complex(pcie.0) or pxb-pcie based extra
>>         * root complexes to be associated with SMMU.
>> @@ -1008,10 +1015,28 @@ static void smmu_base_class_init(ObjectClass *klass, const void *data)
>>        rc->phases.exit = smmu_base_reset_exit;
>>    }
>>    
>> +static void smmu_base_instance_init(Object *obj)
>> +{
>> +    SMMUState *s = ARM_SMMU(obj);
>> +
>> +    object_property_add_link(obj, "memory",
>> +                             TYPE_MEMORY_REGION,
>> +                             (Object **)&s->memory,
>> +                             qdev_prop_allow_set_link_before_realize,
>> +                             OBJ_PROP_LINK_STRONG);
>> +
>> +    object_property_add_link(obj, "secure-memory",
>> +                             TYPE_MEMORY_REGION,
>> +                             (Object **)&s->secure_memory,
>> +                             qdev_prop_allow_set_link_before_realize,
>> +                             OBJ_PROP_LINK_STRONG);
> 
> Why can't we use device_class_set_props(&static_properties)
> in smmu_base_class_init()?
>

To be honest, I simply duplicated what was done on cpu side, without 
thinking too much about it.
I thought there was something about passing a memory region that 
requires this, compared to having a simple property.

If you think it's important, I can try to use the function you mentioned 
above.

>> +}
>> +
>>    static const TypeInfo smmu_base_info = {
>>        .name          = TYPE_ARM_SMMU,
>>        .parent        = TYPE_SYS_BUS_DEVICE,
>>        .instance_size = sizeof(SMMUState),
>> +    .instance_init = smmu_base_instance_init,
>>        .class_data    = NULL,
>>        .class_size    = sizeof(SMMUBaseClass),
>>        .class_init    = smmu_base_class_init,
> 
> Anyhow this is functional and I suppose this can be improved on top, so:
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 

Thanks,
Pierrick

